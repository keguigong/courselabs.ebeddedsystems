package com.example.ece.course.lab_1_2;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    boolean isBoy = true;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Button btnPicture = (Button) findViewById(R.id.btnPicture);
        btnPicture.setOnClickListener(new View.OnClickListener() {
            public void onClick(View view) {
                TextView tvName = (TextView) findViewById(R.id.tvName);
                tvName.setText(R.string.nameBoy);
                ImageView ivPicture = (ImageView) findViewById(R.id.ivPicture);
                ivPicture.setImageResource(R.drawable.boy);
                EditText etName = (EditText) findViewById(R.id.etName);
                String name = etName.getText().toString();
            }
        });
    }
}