Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCF96990AF
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Feb 2023 11:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjBPKFP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Feb 2023 05:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjBPKFO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Feb 2023 05:05:14 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D182F3E616
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Feb 2023 02:05:11 -0800 (PST)
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M9o21-1pVbGv43wT-005uAI; Thu, 16
 Feb 2023 11:05:06 +0100
Message-ID: <dabed1bf-da8b-6ef4-77c4-e2c28cf9106f@gmx.com>
Date:   Thu, 16 Feb 2023 18:05:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Content-Language: en-US
To:     Boris Burkov <boris@bur.io>, Chris Murphy <chris@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <aa1fb69e-b613-47aa-a99e-a0a2c9ed273f@app.fastmail.com>
 <124a916c-786b-42ec-bc9d-db97bb081881@app.fastmail.com>
 <Y+1pAoetotjEuef7@zen>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: LMDB mdb_copy produces a corrupt database on btrfs, but not on
 ext4
In-Reply-To: <Y+1pAoetotjEuef7@zen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:EK+hcK1Sku8/67fVcp6fgD8kklH0oETHqly0vINX6i0AP1+qw/v
 PNi/LwOEP6ZVNHa/SaIPKbj9TdFMVjcFev/K3gx4uQ7WEuiUwdZKcj7ezW0yMFmwupzUwUr
 zFHBasNxVJ16YrMiuMARNTIcRt/SunY6cPy6mjwuyg5DkByxp0o2QlL94Fe5IyeXt0ke97Z
 nx0Lmk9WgEfE86T+Ax6Zw==
UI-OutboundReport: notjunk:1;M01:P0:r7oGc1PzSJ8=;Yssix7KFcWg25qvaxqDSwCDM0OM
 rxpyHNDFOwgmiGmMloi82+Y30pFSNeOYmeal1iwOdtf5puWaXcFiYBzy7PjDn5s8pzIPGDG1T
 uoCVcgqfiQtzQCxYnY8YMWvdMYSfEQ9F4Q6JyWGRP0eCHfLUXHObYWFBF8w1k9JPjGYom/VGU
 N1KgCh6n1CWZR62EWmSX78UOLIDCCK7jt+SIHbuHp1WVeMgec8x+wpoWVd3PhY668qF7vq2oL
 soQfg7E17ggFnF5zsxq2VPq4exwr2jIIFNmFTOdsB5PaQ7LDAepyWZmHXaQaTRLZpd03eB1tp
 ICT9e+fUYiIMXHk4rJQBERnOx5rPHyPXMcb/my8PEBBBi7fRFNopnda1hLgfyQACUFNR+9KNN
 zxCgNS63Fxx2yb6UAwPxswWsdWrqOSM5s6t+QXILU5yWmLbjLDbg6uRQzhIzOxL0LWEdgww/8
 k5nz9846vhL3fgvVkqu6WivkdJh+NAA+1KtwQlWb9V3E3VQlVBgop/rhZrB+blLUZyW6Usic1
 qAT4H6rELLKEy3bsYLEWn4EO/n6KTpZ/VpktJJWIAkzEHr4MKXIjbdwqaRHgLB5sH5YpL5tad
 P1Fx20uzTixzbl2+dBE31n5RUITd+BOS4mMw7OokBh8ox9BF9Knp9H1Hh4ugCLjtl3Y6uyAUr
 hOftRcejkeluts5SA/1SumwC45vDQR1P1HjQm5+SKU+epMJKZU744gnPm0oNahe6IBagYbZj4
 f0TQITcXbCIn2IK68RtkgWjoSe+L/qClNle7v7kJzG4xhix4JUdBUFcnf1bMW9IL7WwbkOmh0
 uUWOOLhH3d2LnErblRQQ0hOreC7PPzVny4fENS3Du7mdmKnsC+tum2ukra3oSvDONOz3rJ3iU
 zhKB8tNmitwGTArRj5lfFxOizI9t96Fke26DERUSPYk9pieSwwxFGLAuwsImNk4vfoHm6dJwM
 zZSkTqU6wx/YC5l3/m4hoqb8ZvY=
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/16 07:21, Boris Burkov wrote:
> On Wed, Feb 15, 2023 at 03:16:39PM -0500, Chris Murphy wrote:
>>
>>
>> On Wed, Feb 15, 2023, at 3:04 PM, Chris Murphy wrote:
>>> Downstream bug report, reproducer test file, and gdb session transcript
>>> https://bugzilla.redhat.com/show_bug.cgi?id=2169947
>>>
>>> I speculated that maybe it's similar to the issue we have with VM's
>>> when O_DIRECT is used, but it seems that's not the case here.
>>
>> I can reproduce the mismatching checksums whether the test files are datacow or nodatacow (using chattr +C). There are no kernel messages during the tests.
>>
>> kernel 6.2rc7 in my case; and in the bug report kernel series 6.1, 6.0, and 5.17 reproduce the problem.
>>
> 
> I was also able to reproduce on the current misc-next. However, when I
> hacked the kernel to always fall back from DIO to buffered IO, it no
> longer reproduced. So that's one hint..
> 
> The next observation comes from comparing the happy vs unhappy file
> extents on disk:
> happy: https://pastebin.com/k4EPFKhc
> unhappy: https://pastebin.com/hNSBR0yv
> 
> The broken DIO case is missing file extents between bytes 8192 and 65536
> which corresponds to the observed zeros.
> 
> Next, at Josef's suggestion, I looked at the IOMAP_DIO_PARTIAL and
> instrumented that codepath. I observed a single successful write to 8192
> bytes, then a second write which first does a partial write from 8192 to
> 65536 and then faults in the rest of the iov_iter and finishes the
> write.

A little off-topic, as I'm not familiar with Direct IO at all.

That fault (I guess means page fault?) means the Direct IO source 
(memory of the user space program) can not be accessible right now?
(being swapped?)

If that's the case, any idea why we can not wait for the page fault to 
fill the user space memory?
I guess it's some deadlock but is not for sure.

Thanks,
Qu
> 
> I'm now trying to figure out how these partial writes might lead us to
> not create all the EXTENT_DATA items for the file extents.
> 
> Boris
> 
>>
>> -- 
>> Chris Murphy
