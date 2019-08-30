package com.Preaid.Diagnosis.Client;

import java.io.*;
import java.math.*;
import java.security.*;
import java.text.*;
import java.util.*;
import java.util.concurrent.*;
import java.util.function.*;
import java.util.regex.*;
import java.util.stream.*;

import javax.swing.plaf.basic.BasicInternalFrameTitlePane.MaximizeAction;

import static java.util.stream.Collectors.joining;
import static java.util.stream.Collectors.toList;

class Result {

	/*
	 * Complete the 'maxDifference' function below.
	 *
	 * The function is expected to return an INTEGER. The function accepts
	 * INTEGER_ARRAY arr as parameter.
	 */

	public static int maxDifference(int[] inputArr) {
		// Write your code here
		int maxDifference = -1;
		//int[] inputArr = a.stream().mapToInt(i -> i).toArray();
		if (inputArr == null || inputArr.length < 2) {
			return -1;
		}

		int minimum = inputArr[0];
		for (int index = 1; index < inputArr.length; index++) {
			if (inputArr[index] <= minimum) {
				minimum = inputArr[index];
			} else if (maxDifference < inputArr[index] - minimum) {
				maxDifference = inputArr[index] - minimum;
			}
		}
		return maxDifference;
	}

}

public class Solution {
	public static void main(String[] args) {
		int[] a = { 8,3,3,0 };
		System.out.println(Result.maxDifference(a));
	}
}