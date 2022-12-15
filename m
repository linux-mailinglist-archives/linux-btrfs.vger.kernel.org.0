Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C748264E4BF
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Dec 2022 00:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiLOXjo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Dec 2022 18:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiLOXjn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Dec 2022 18:39:43 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941E833C38;
        Thu, 15 Dec 2022 15:39:41 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MJVDM-1pLRNB2W3U-00JqBI; Fri, 16
 Dec 2022 00:39:38 +0100
Message-ID: <233175d4-b201-50b0-5356-b003d5bd3f93@gmx.com>
Date:   Fri, 16 Dec 2022 07:39:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH] fstests: add basic json output support
To:     David Disseldorp <ddiss@suse.de>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20221215114113.38815-1-wqu@suse.com>
 <20221215174252.031fcbba@echidna.fritz.box>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20221215174252.031fcbba@echidna.fritz.box>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:lo5Q1j73M1gG3l60JS9kKf7cmnhoOPVxjWQ6g14XLdWuonnqlGl
 sSiWmd77uqs6GcvNwkNle2G9GhpbOIpC4fUKGHBXq9YUpXAVrL8yyw3Winu8dvirjqoSsqa
 9zKC639Gg8F9I/ioWjK2XJOnWP/2g39dVlJ43CnE5YltNgKCl6o6xAiq1pePywT/kEpP0Pm
 yA+d6AbkK6U81q1vt5bDg==
UI-OutboundReport: notjunk:1;M01:P0:2oV9T2jv320=;JS5oP5c28SFRAdNZ7PpUyRO5yIf
 oc2Jn2NT8f8dX1g6qpAwARSXJLnouH+Al/8/amNa6DAOWUNT8mFreEIepI9mtmCxyLzFQIf+k
 8MpfzSk7MA73C5YoN2Wz0iXG2fBZnKx3yCVfibillFk+9ny+InjMpi1Rs8RrEyQDxbZw1SrAE
 LN2+4dY+hiPUvHxV0mOmd6xQTZvOkDWNctUmzZro+y8JuHNdLsuBMeoWf5kYycm7jwgsZOmhI
 2bnWj2Y19Uji62wjjTMLTHzU+XYsSt8R/kUAsh88BXF6BbNtRw4IfrYLrFFpqy4tBXokpf/c5
 ticEvvOeEstLZUX28u4g0q8h//Ee1BLHJvjLHPFSw/PEtOmcTCSRLM+wtot4h9bTyoHWeFDQR
 dH845BYAw8Lp99k2eypWGD7Svm/hHimeTsQ0nI8TJjv/RYus6vABWo8PRkJCd2Dtc/TSTmqpZ
 acZJpM2HxwJzdvhq5bh+h5lf1Q74h/Xph3JetbdRzjaXzdmNIwWaVQaDdemwhKYXNbd0A5cKe
 xtMgIPokDL6ncIsQbXoEDQujczZP6oihQKs30c9nedgIsaYJQOG6kJ4QshWP27PuAi5n7i8BJ
 zjDGbM0K+3A653Iq2SD7CSqPvlls47S/Np6n6tj7loMLnr1XRifRSs+s7RSYtZRSEK1Cc6MPC
 VRW4XyfdogMGq1TJWCwDW8ukOfvRFtwX8K0ODjvGX/5lTGY+87uT25k4zySzm9G5mQ9D68arx
 80vUcKzFJJVGJ8f9AjPmV5qXkrr+lDkh8F86rrLn6/E2Gu3sBogDdpmFs190OyIutR4+NTFQP
 kIvvH52JcxW/1LbZrjPz/gl3acm+1+ifdLc8DT3+F/vXxFgV35JG8FXjwramgKSFR5rfr6yY0
 tbl5QfyOAzsLvKaYlUgblKWJWIluNEHi83ZUUrHo/oBDuEZXVpkF7izIMcpZfut6z5hpe+Dpt
 xz2M6E51VoOcy9RfVAk9l8Waoqs=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/16 00:42, David Disseldorp wrote:
> Hi Qu,
> 
> On Thu, 15 Dec 2022 19:41:13 +0800, Qu Wenruo wrote:
> 
>> Although the current result files "check.log" and "check.time" is enough
>> for human to read, it's not that easy to parse.
> 
> Have you looked at the existing junit XML based report types, available
> via "check -R xunit ..."? junit is standardized, parsable and supported
> by tools such as:
> - https://docs.gitlab.com/ee/ci/testing/unit_test_reports.html
> - https://github.com/weiwei/junitparser
> - https://ddiss.github.io/online-junit-parser/
> - https://plugins.jenkins.io/junit/

Oh, that's way better, the existing reporting facility is really what I 
need.

> 
>> Thus this patch will introduce a json output to "$RESULT_BASE/check.json".
>>
>> The example output would look like this:
>>
>>    {
>>        "section": "(none)",
>>        "fstype": "btrfs",
>>        "start_time": 1671103264,
>>        "arch": "x86_64",
>>        "kernel": "6.1.0-rc8-custom+",
>>        "results": [
>>            {
>>                "testcase": "btrfs/001",
>>                "status": "pass",
>>                "start_time": 1671103264,
>>                "end_time": 1671103266
>>            },
>>            {
>>                "testcase": "btrfs/006",
>>                "status": "pass",
>>                "start_time": 1671103266,
>>                "end_time": 1671103268
>>            },
>>            {
>>                "testcase": "btrfs/007",
>>                "status": "pass",
>>                "start_time": 1671103268,
>>                "end_time": 1671103271
>>            }
>>        ]
>>    }
>>
>> Which should make later parsing much easier.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Reason for RFC:
>>
>> - Not crash safe
>>    If one test case caused a crash, the "check.json" file will be an
>>    invalid one, missing the closing "] }" string.
>>
>> - Is json really a good choice?
>>    It may be much easier to convert to a web page, but we will still
>>    need to parse and handle the result using another languages anyway,
>>    like to determine a regression.
> 
> I'm not opposed to adding an extra json report type, but I really think
> it should be plumbed into the existing common/report API.
> 
>>    Another alternative is .csv, and it can be much easier to handle.
>>    (pure "echo >> $output", no need to handle the comma rule).
>>    But for .csv, we may waste a lot of columes for things like "arch",
>>    "kernel", "section".
> 
> My preference for any new output formats, especially if they're intended
> for parsing, is that they're based on an existing standard/tool. E.g.
> https://testanything.org .

That's a much better unified protocol, I'll definitely look into it.

Thanks for all the feedbacks!
Qu

> 
> Cheers, David
