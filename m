Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309BC65158D
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Dec 2022 23:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbiLSWaY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Dec 2022 17:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiLSWaX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Dec 2022 17:30:23 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAB312A82;
        Mon, 19 Dec 2022 14:30:21 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MN5if-1pQIPQ35sr-00J1DA; Mon, 19
 Dec 2022 23:30:14 +0100
Message-ID: <a1bc81ca-49fb-c67a-54cc-403287c26629@gmx.com>
Date:   Tue, 20 Dec 2022 06:30:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
To:     "Darrick J. Wong" <djwong@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20221216070543.31638-1-wqu@suse.com> <Y6CmEBltWukgZ3rV@magnolia>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] fstests: report: add arch and kernel version info into
 testsuite attributes
In-Reply-To: <Y6CmEBltWukgZ3rV@magnolia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:kXuJ9cRDod0hQzCZb8rYnhAEGpVxW7/+uveh49tbVfc/Y2sUUP3
 Wj9uMbWtbetW8a/vC5Vs2u/uUxKFTu5kJO/KKiBoWKBhi8XsCqTVdGcc1JLd66VMfDRINTb
 iBMkvxbD2CUnCNgRXUTldZQ9GlQAwwNKy72ovLpD2NrH1D3H9Q2sgx4qeKnFmHUukYRzhXH
 +/SNPXO7rsnUjFMrK0+Ig==
UI-OutboundReport: notjunk:1;M01:P0:RRNcBSbwiXM=;uLoG2FAzE8yKC900DWTC5TxzQfz
 kOkCIyVdQgVSw6ant8zdWR4WxaFH81W9ruWVLkdbNCygZXjB8URy76MxV2BVwPnaLpruAbXof
 UnsOFvu2Au+eCMx5SWMIJWKqxZBGkPbnINwpcn38n8EDOXymEgPpVMuDiDbwcX5Na+JmdOyj/
 lYYDhAL4601tqTd1NeFWM4TsvETjqtH9vY9ubdr8WN+AEDFobwGrY0qopozC/ZhQ4crVLzFrv
 MVehLeRxWBMv7Pou3e7v7zMNqlgRLrrWN7Sm1V9/FuRyf0+HmMn6qr/+gV2ilKHiqN/uGePcz
 lrQwhRWK0T0WzNIvP/mi2PaZ6qCS5VkhkmWjzy0ge7ai+ux20RIjmq2/bt/OaPpGrsVHXk4HH
 FzAfySMTCfZ5HeeRm2wTu6ThrT2B+JbNVrhODLAUrKNApkpGiM6fx7U2a4OJ0Y6dDiT4GW14J
 WxE4ENe7F9iW768NHDANsN9B+BjgUKrtqB2gZBeTYTixTv1HSFZTPbfI64hVXeQW7xwAMB8xj
 I/kTnUMjI5tGrB0MsMHrMk27O6P03x8yTnzeFgg+uGaLC02YdlxZQD3qcnIEi7HBDSXcMGsLO
 9OJ73wzBHdg0Vr995WMoq3j36FqTMIRfE2ynqv7uJrg6e//Yn5R5JNPizWyJ7ZzQHqg4/1poI
 vO6xFg6vL/2rZBzBJRHg1ivaS2Yx7ZxZthwmbVvBFYXo05wCKcXYrwwJpsVh0IzomUULa48pr
 ZGyTDrv6S1Uowfu0L1tB4g8aFKCWVe3d52CyDO+0F0a4DioOMlSn0bNmcoQYF97hsOjCYTXfw
 GZeQkCeeeZjHbOE1EyC3RKMCCc+gGPsMjYqpi3OYZmG+wNzlp8YjYhQu0d5nULftX3wYfBwO4
 n6UAnaT3sCo7xJpq+S4qCf0fdvTSzMXYipdtTKkzOp50cr+9CUqQhJ4fdP3lVfsMY9Qbz5T9f
 zbkjBVSYgNomxuwYA25h4srkSs0=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/20 01:57, Darrick J. Wong wrote:
> On Fri, Dec 16, 2022 at 03:05:43PM +0800, Qu Wenruo wrote:
>> Although "testcase" tags contain the "timestamp" element, for day-0
>> testing it can be hard to relate the timestamp to the tested kernel
>> version.
>>
>> Thus this patch will add a "kernel" element to the "testcase" tag, to
>> indicate the kernel version we're running.
>> Paired with CONFIG_LOCALVERSION_AUTO=y config, it will easily show the
>> kernel commit we're testing.
>>
>> Since we're here, also add a "arch" element, as there are more and more
>> aarch64 boards (From RK3399 to Apple M1) able to finish fstests in an
>> acceptable duration, we can no longer assume x86_64 as our only
>> platform.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   common/report | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/common/report b/common/report
>> index 4a747f8d..92586527 100644
>> --- a/common/report
>> +++ b/common/report
>> @@ -49,7 +49,7 @@ _xunit_make_section_report()
>>   		date_time=$(date +"%F %T")
>>   	fi
>>   	local stats="failures=\"$bad_count\" skipped=\"$notrun_count\" tests=\"$tests_count\" time=\"$sect_time\""
>> -	local hw_info="hostname=\"$HOST\" timestamp=\"${date_time/ /T}\" "
>> +	local hw_info="hostname=\"$HOST\" timestamp=\"${date_time/ /T}\" arch=\"$(uname -m)\" kernel=\"$(uname -r)\""
>>   	echo "<testsuite name=\"xfstests\" $stats  $hw_info >" >> $REPORT_DIR/result.xml
> 
> The original commit that added this report format was f9fde7db2f
> ("report: Add xunit format report generator").  Dmitry Monakhov's commit
> message points out that the xml being emitted was "xunit/junit":
> 
>      Footnotes:
>      [1] https://xunit.github.io/docs/format-xml-v2.html
>      [2] http://help.catchsoftware.com/display/ET/JUnit+Format
> 
> The first link is now dead, but the second link contains enough
> information to find the current junit xml format:
> 
> [1] https://raw.githubusercontent.com/windyroad/JUnit-Schema/master/JUnit.xsd
> 
> Note that the xunit project appears to have diverged their report
> format:
> 
> [2] https://xunit.net/docs/format-xml-v2

Great we have something solid to follow.

> 
> (Or perhaps there were multiple things called xunit?)
> 
> Either way, it's pretty obvious from common/report code that the "xunit"
> code is still emitting junit xml files.  I think it's important that
> fstests should continue to follow that schema, so that these files can
> be fed into test dashboards (yes I have one) that consume this file
> format.
Totally agreed.

> 
> Regrettably, the schema does not provide for @arch or @kernel attributes
> hanging off the <testsuite> element, so it's not a good idea to add
> things that a strict parser could reject.

I'm totally fine with the properties method, but still curious why some 
parsers would even reject elements with unknown attributes?

Isn't the idea of XML (or JSON) to be flex for newer attributes?

> 
> That said, I think it's important to record the architecture and kernel.
> Probably even more attributes than that.  The junit xml schema provides
> for arbitrary string properties to be attached to reports; would you
> mind putting these there instead?
> 
> (I want to add a few more properties now that people have started
> talking about reporting again... ;))
> 
> 	# Properties
> 	echo -e "\t<properties>" >> $REPORT_DIR/result.xml
> 	echo -e "\t\t<property name=\"arch\" value=\"$(uname -m)\"/>" >> $REPORT_DIR/result.xml
> 	echo -e "\t\t<property name=\"kernel\" value=\"$(uname -r)\"/>" >> $REPORT_DIR/result.xml
> 	for p in "${REPORT_ENV_LIST[@]}"; do
> 		_xunit_add_property "$p"
> 	done
> 	echo -e "\t</properties>" >> $REPORT_DIR/result.xml

Sounds pretty good, thanks for all the awesome advices!
Qu

> 
> --D
> 
>>   
>>   	# Properties
>> -- 
>> 2.38.0
>>
