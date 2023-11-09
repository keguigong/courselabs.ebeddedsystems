//---------------------------------------------------------------------
//
// Copyright (c) 2016 CWB Tech Limited All rights reserved
//
//
//---------------------------------------------------------------------
// File: GraphFragment.java
// Author: Kevin Kwok (kevinkwok@cwb-tech.com)
//         William Chan (williamchan@cwb-tech.com)
// Project: Glance
//---------------------------------------------------------------------

package com.cwb.glancesampleapp;

import android.app.Fragment;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.FrameLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.cwb.bleframework.GlanceStatus;

import java.lang.ref.WeakReference;
import java.util.HashMap;

public class GraphFragment extends Fragment {
    private String TAG = "GraphFragment";

    private static final int SWITCH_MODE_STATEMACHINE_DELAY = 500;
    private static final int SWITCH_MODE_STATEMACHINE_WAIT_MAX_TIMEOUT = 60000;
    private static final int SWITCH_MODE_STATEMACHINE_WAIT_MAX_TIMEOUT_COUNT = SWITCH_MODE_STATEMACHINE_WAIT_MAX_TIMEOUT / SWITCH_MODE_STATEMACHINE_DELAY;
    private static final int MSG_KEEP_4SEC_GRAPH_DATA = 1000;
    private static final int MSG_STATE_SET_STREAMING_MODE = MSG_KEEP_4SEC_GRAPH_DATA + 1;
    private static final int MSG_STATE_WAITING_SET_STREAMING_MODE = MSG_STATE_SET_STREAMING_MODE + 1;
    private static final int MSG_STATE_SET_CONNECTION_INTERVAL = MSG_STATE_WAITING_SET_STREAMING_MODE + 1;
    private static final int MSG_STATE_WAITING_SET_CONNECTION_INTERVAL = MSG_STATE_SET_CONNECTION_INTERVAL + 1;
    private static final int MSG_STATE_TIMEOUT = MSG_STATE_WAITING_SET_CONNECTION_INTERVAL + 1;
    
    private TextView mDataAnalysis;
    private FrameLayout mGraphViewAccl;
    private GraphDisplayXYZ mAccelGraph;
    private Button mCapture;
    private int mGraphX;
    private double mRMSAccel[];
	private boolean isCapturing;
    private boolean mKeep4SecGraphData;
    private int mStateLoopCount = 0;
    private boolean mIsReceivedSetStreamingMode = false;
    private boolean mIsReceivedGetConnectionInterval = false;
    private static Object mLock = new Object();

    public interface onGraphListener {
        public abstract void onEnableStreaming(boolean enable);
        public abstract void onSetConnectionIntervalHigh();
        public abstract void onSetStreamingMode();
        public abstract void onResetStreamingMode();
        public abstract void onKeyBack();
    }

    private onGraphListener onGraphListener = null;

    public void setOnGraphListener(onGraphListener listener) {
        onGraphListener = listener;
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        Log.d(TAG, "  onCreateView");

        View view = inflater.inflate(R.layout.fragment_layout_graph, container, false);

        mDataAnalysis = (TextView) view.findViewById(R.id.graph_analysis);
        mGraphViewAccl = (FrameLayout) view.findViewById(R.id.graph_accel_rawdata);
        mCapture = (Button) view.findViewById(R.id.graph_capture_4s);
        mCapture.setOnClickListener(mOn4sClickListener);
        isCapturing = false;

        return view;
    }

    private View.OnClickListener mOn4sClickListener = new View.OnClickListener() {
        @Override
        public void onClick(View v) {
            if (!isCapturing){
                if (onGraphListener != null) {
                    onGraphListener.onEnableStreaming(true);
                }
                ((Button) v).setText(R.string.chip_dev_graph_stop_capturing);
                mGraphX = 0;
                mKeep4SecGraphData = false;
                readTimePlot();
            }else{
                if (onGraphListener != null) {
                    onGraphListener.onEnableStreaming(false);
                }
                ((Button) v).setText(R.string.chip_dev_graph_capture_4s);
            }
            isCapturing = !isCapturing;
        }
    };

    private void readTimePlot(){
        mGraphViewAccl.removeAllViews();
        mAccelGraph = new GraphDisplayXYZ(getActivity(), 4096-500, 4096+500);
        mGraphViewAccl.addView(mAccelGraph.getView());
    }

    public void processMotionData(HashMap<String, GlanceStatus.SensorData> kvs)
    {
        if (kvs.containsKey("accel") && kvs.containsKey("gyro")) {
            receiveRawDataGraph(kvs.get("accel"), kvs.get("gyro"));
        }
    }

    public void receiveRawDataGraph(GlanceStatus.SensorData accel, GlanceStatus.SensorData gyro){
        if (mAccelGraph == null) {
            Log.e(TAG, "accelGraph not init");
            return;
        } else if (!mAccelGraph.isRealTimeUpdate()) {
            Log.e(TAG, "accelGraph not in real time mdoe");
            return;
        }
        if (mAccelGraph.getSize() == 0) {
            mHandler.sendEmptyMessageDelayed(MSG_KEEP_4SEC_GRAPH_DATA, 4000);
        }
        if (mKeep4SecGraphData) {
            mAccelGraph.removeFirst();
        }
        mAccelGraph.addPoint(mGraphX, accel);
        mRMSAccel = mAccelGraph.getRMS();
        mDataAnalysis.setText("Root Mean Square:\n");
        mDataAnalysis.append(String.format("Accel: %.02f %.02f %.02f\n", mRMSAccel[0], mRMSAccel[1], mRMSAccel[2]));

    }

    public void SetStreamingModeSuccess()
    {
        synchronized(mLock) {
            mIsReceivedSetStreamingMode = true;
        }
    }

    public void start()
    {
        mHandler.sendEmptyMessage(MSG_STATE_SET_STREAMING_MODE);
    }

    public void SetConnectionIntervalSuccess()
    {
        synchronized(mLock) {
            mIsReceivedGetConnectionInterval = true;
        }
    }

    public void keyBack()
    {
        if (onGraphListener != null) {
            onGraphListener.onEnableStreaming(false);
            onGraphListener.onResetStreamingMode();
            onGraphListener.onKeyBack();
        }
    }

    /**
     * Instances of static inner classes do not hold an implicit
     * reference to their outer class.
     */
    private static class MyHandler extends Handler {
        private final WeakReference<GraphFragment> mDevFragment;

        public MyHandler(GraphFragment fragment) {
            mDevFragment = new WeakReference<GraphFragment>(fragment);
        }

        @Override
        public void handleMessage(Message msg) {
            GraphFragment fragment = mDevFragment.get();
            int ret = 0;
            if (fragment != null) {
                synchronized(fragment.mLock) {
                    switch (msg.what) {

                        case MSG_KEEP_4SEC_GRAPH_DATA:
                            fragment.mKeep4SecGraphData = true;
                            break;
                        case  MSG_STATE_SET_STREAMING_MODE:
                            if (fragment.onGraphListener != null) {
                                fragment.mStateLoopCount = 0;
                                fragment.mIsReceivedSetStreamingMode = false;
                                fragment.onGraphListener.onSetStreamingMode();
                                fragment.mHandler.sendEmptyMessageDelayed(MSG_STATE_WAITING_SET_STREAMING_MODE, SWITCH_MODE_STATEMACHINE_DELAY);
                            }
                            else {
                                fragment.mHandler.sendEmptyMessage(MSG_STATE_TIMEOUT);
                            }
                            break;
                        case  MSG_STATE_WAITING_SET_STREAMING_MODE:
                            if (fragment.mIsReceivedSetStreamingMode) {
                                fragment.mHandler.sendEmptyMessageDelayed(MSG_STATE_SET_CONNECTION_INTERVAL, SWITCH_MODE_STATEMACHINE_DELAY);
                            } else {
                                if (++fragment.mStateLoopCount < SWITCH_MODE_STATEMACHINE_WAIT_MAX_TIMEOUT_COUNT) {
                                    fragment.mHandler.sendEmptyMessageDelayed(MSG_STATE_WAITING_SET_STREAMING_MODE, SWITCH_MODE_STATEMACHINE_DELAY);
                                } else {
                                    fragment.mHandler.sendEmptyMessage(MSG_STATE_TIMEOUT);
                                }
                            }
                            break;
                        case  MSG_STATE_SET_CONNECTION_INTERVAL:
                            if (fragment.onGraphListener != null) {
                                fragment.mStateLoopCount = 0;
                                fragment.mIsReceivedGetConnectionInterval = false;
                                fragment.onGraphListener.onSetConnectionIntervalHigh();
                                fragment.mHandler.sendEmptyMessageDelayed(MSG_STATE_WAITING_SET_CONNECTION_INTERVAL, SWITCH_MODE_STATEMACHINE_DELAY);
                            }
                            else {
                                fragment.mHandler.sendEmptyMessage(MSG_STATE_TIMEOUT);
                            }
                            break;
                        case  MSG_STATE_WAITING_SET_CONNECTION_INTERVAL:
                            if (fragment.mIsReceivedGetConnectionInterval) {
                                if (fragment.mCapture != null)
                                {
                                    fragment.mCapture.setEnabled(true);
                                }
                            } else {
                                if (++fragment.mStateLoopCount < SWITCH_MODE_STATEMACHINE_WAIT_MAX_TIMEOUT_COUNT) {
                                    fragment.mHandler.sendEmptyMessageDelayed(MSG_STATE_WAITING_SET_STREAMING_MODE, SWITCH_MODE_STATEMACHINE_DELAY);
                                } else {
                                    fragment.mHandler.sendEmptyMessage(MSG_STATE_TIMEOUT);
                                }
                            }
                            break;
                        case  MSG_STATE_TIMEOUT:
                            if (fragment.getActivity() != null) {
                                Toast.makeText(fragment.getActivity(), R.string.chip_dev_graph_fail, Toast.LENGTH_SHORT).show();
                            }
                            break;
                    }
                }
            }
        }
    }

    private final MyHandler mHandler = new MyHandler(this);
}
