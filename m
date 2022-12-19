Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3956515B9
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Dec 2022 23:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbiLSWzE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Dec 2022 17:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbiLSWzB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Dec 2022 17:55:01 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1924E12751;
        Mon, 19 Dec 2022 14:54:59 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MY68T-1pO5M93Ekv-00YV8M; Mon, 19
 Dec 2022 23:54:53 +0100
Message-ID: <38088b9f-ab32-7ffe-cc4f-51279cfea95b@gmx.com>
Date:   Tue, 20 Dec 2022 06:54:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     "Darrick J. Wong" <djwong@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20221216065121.30181-1-wqu@suse.com> <Y6Ch1Qq9op2tmB1U@magnolia>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] fstests: report: always save the dmesg as system-err if
 KEEP_DMESG is set
In-Reply-To: <Y6Ch1Qq9op2tmB1U@magnolia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:NN5DhGQvs39M+YawxCpQHKGe6n+pd38LiqN9DYRY9S4G9uDu8k0
 VOBn8tQ/YW8eXGaCwA3do6UfXTiTC9oQ88xDGaK+qejFKpBePbOORigiifMVd1lpLPWB6uS
 XdKcxKDGGjAr87pBUtXVVpYdYy2hLxCrdoHTtgSE3SVscE2h0+0htxPewKKwj0Nj+W+W5OY
 1Sw9yq1mmjjcsua3Y96QA==
UI-OutboundReport: notjunk:1;M01:P0:qLitI1RZSSw=;e69OBXRcMGoe87DlBzLGHz8g0FJ
 G54hL9KTvIQk2hTAhk7gWhWKLm65Jrj7PrFICCXM7dYjg7d6qmf28K6Op4p9EI2BsTn0FSO8U
 OQFsyvg+vNkDuxI/awaSipk811D+aU7jEssD7DAv2zPWZEcCTtxs7Uvl+bV60V8xyjBHoQudZ
 qe8GdaPXrorSdHyZTF6pcRtecy11OI6TJ4bd7G0s6blxx6FXuV/dz7vNbhi6PXUXM2h0NQzJ9
 uKAqKPrLmtVO+EPxhyEG4RwjrH892yJ3s6UwA73k4x73o7fNnTnE4FvtNpTBEK/CXszVSLaQk
 uL/Tkj+vPZ6vbew/4VzIPyU0fjgMtN+hcIODjC/Og3l2Shw0Egtnl5Oha7G734B8OY2ebFJJZ
 HhHOrjH6dLO3LDZz+wAUqMju6BMc3llSLetf+tTiG8ZHI1QKxquQMdJww+bbvSEBQ5f5UaQ4h
 TGjiP7rQgVlTfoCpDrxE2O8WJ4kyEFROndtnk/zFGhX1IJ0Vy2Xdtu5MfuOgyUkjchlLnX3Or
 X3D1hMJrqd2TicuzSp9PEID9heFhl0V8MOZGbjTrvmx68/9VvscN/VLY7j1qjHDukwfztUkyD
 UMDShpa+kg5R9GGPYUR+oD1RI3YiWX3NxkTP1TOI0NTF+XQeDOXvwr8EfFSIG+4pMcWT6pG3r
 6hIjA+tnAcbQLcrfglbjVLNX9kMGPzFVxvxKpQROrGCQ4ydvAz5EfSceioDnR3fXBcnKEqYAL
 4qo3WC75DHVWzarYviZ3Qzpz8rO09MJKQm9kfiOtAq7PEYLmlPd4I+FGnSty9rPw9bk1ItUvN
 nI5X9Rr1NfrYPq/Q58iYbRzcb2UY40TNJYxQTiUtvOdgYvfpMZsJIvWiXzTOMxd5kCsX2u5u/
 1R0VZ3kVkFgGBKvOyNWe7kFNyGo2BkGDLZfICjXAsNIERqefZYv/38/zjc7V/r7ewSbEcDQub
 iPzI7Kf7KiIwrHk7JeglCWf7LAI=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/20 01:39, Darrick J. Wong wrote:
> On Fri, Dec 16, 2022 at 02:51:21PM +0800, Qu Wenruo wrote:
>> When KEEP_DMESG is set to "yes", we will always save the dmesg of any
>> test case (no matter if it passed or not) into "$seqnum.dmesg".
>>
>> But this KEEP_DMESG behavior doesn't affect xunit report.
>>
>> This patch will make xunit report to follow KEEP_DMESG setting.
>> Since error is checked by testcase.failure attribute, this new
>> <system-err> section should not cause the existing parsers to treat
>> passed cases as errors.
>>
>> KEEP_DMESG is only followed if all the following conditions are met:
>>
>> - KEEP_DMESG is set to yes
> 
> Feel free to push back against the proliferation of config variables,
> but perhaps this ought to be REPORT_DMESG={always,never,auto} ?

I guess this would cover a lot of work of xunit-quiet?

> 
>> - Using xunit reporting
>>    xunit-quite won't save the dmesg for passed test cases.
> 
>            ^^^^^ "quiet"?
> 
>> This extra saved dmesg would definitely boost the xml size, but if the
>> end user wants to save all the dmesg (for later verification), then I'd
>> say it's a unavoidable cost.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   common/report | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/common/report b/common/report
>> index 64f9c866..4a747f8d 100644
>> --- a/common/report
>> +++ b/common/report
>> @@ -87,6 +87,19 @@ _xunit_make_testcase_report()
>>   	echo -e "\t<testcase classname=\"xfstests.$sect_name\" name=\"$test_name\" time=\"$test_time\">" >> $report
>>   	case $test_status in
>>   	"pass")
>> +		# If we have KEEP_DMESG and want full output, also save the
>> +		# dmesg into the passed result
>> +		if [ "$KEEP_DMESG" == yes -a "$quiet" != "yes" ]; then
>> +			local dmesg_file="${REPORT_DIR}/${test_name}.dmesg"
>> +			if [ -f "$dmesg_file" ]; then
>> +				echo -e "\t\t<system-err>" >> $report
>> +				printf	'<![CDATA[\n' >>$report
>> +				cat "$dmesg_file" | tr -dc '[:print:][:space:]' | \
>> +					encode_xml >>$report
>> +				printf ']]>\n'	>>$report
>> +				echo -e "\t\t</system-err>" >> $report
> 
> Hmm.  Does the junit xml schema[1] (that's what fstests implements, even
> if we call it xunit, and even though there's a separate xunit[2] format
> that is not the same!) actually allow us to have multiple <system-err>
> elements?
> 
> For that matter, I look at things like this:
> 
> 	if [ -n "$quiet" ]; then
> 	   :
> 	elif [ -f "$dmesg_file" ]; then
> 		echo -e "\t\t<system-err>" >> $report
> 		printf	'<![CDATA[\n' >>$report
> 		cat "$dmesg_file" | tr -dc '[:print:][:space:]' | encode_xml >>$report
> 		printf ']]>\n'	>>$report
> 		echo -e "\t\t</system-err>" >> $report
> 	elif [ -s "$outbad_file" ]; then
> 		echo -e "\t\t<system-err>" >> $report
> 		printf	'<![CDATA[\n' >>$report
> 		$diff "$out_src" "$outbad_file" | encode_xml >>$report
> 		printf ']]>\n'	>>$report
> 		echo -e "\t\t</system-err>" >> $report
> 	fi
> 
> and wonder why we prioritize recording dmesg output over .out.bad when
> we could do both?

Well, before you mentioning this, I didn't even notice we don't save 
out.bad if we have dmesg...

And we need some standard on what should be put into system-out and what 
should go system-err.

Personally speaking, out.bad should go system-out, while dmesg and full 
should go system-err.


Another thing is, if we have multiple system-err elements, should we add 
some properties for the system-err elements to distinguish .full and .dmesg?

Thanks,
Qu

> 
> --D
> 
> [1] https://raw.githubusercontent.com/windyroad/JUnit-Schema/master/JUnit.xsd
> [2] https://xunit.net/docs/format-xml-v2
> 
>> +			fi
>> +		fi
>>   		;;
>>   	"notrun")
>>   		local notrun_file="${REPORT_DIR}/${test_name}.notrun"
>> -- 
>> 2.38.0
>>
