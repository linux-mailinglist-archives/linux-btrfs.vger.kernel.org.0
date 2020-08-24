Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24C02506BD
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Aug 2020 19:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgHXRmj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Aug 2020 13:42:39 -0400
Received: from smtp-33.italiaonline.it ([213.209.10.33]:44039 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726090AbgHXRmR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Aug 2020 13:42:17 -0400
Received: from venice.bhome ([94.37.192.142])
        by smtp-33.iol.local with ESMTPA
        id AGU0kWvrd8e2WAGU1kBVWJ; Mon, 24 Aug 2020 19:42:13 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1598290933; bh=Sa6AGB1jKaLzY2kEvM/2Sm10RUCtZreHjy+d4KV1zro=;
        h=From;
        b=mlA+o/cYmhnMgFsbvEutTi2bhX6wqUOk8k8mvkGSOjOAcCpzmM+86ngYBRcQf/PeG
         YHVl5iGk/JVfogiZ7Hl8cZlbavggcXTzzr+yvt5IRzBwged5zcYFmZncIBoAijQtH0
         bX0AsgLkKooqf8LbMsc05xP4SgN1tdA3rg8D9NNtcS9RG9LH8G1nHRG+J2Kyd++5+R
         GPTFbCi7ymKJTkXGAMSGeyAL/rMcbXr+rd89kwAU6eMGyGMx0GsZuR00XiWefG7yVX
         5OdVB1Un+CYLQKFlMsx6Bhi6c0t/eeC09Us7G8T6Xm/5Df3blwimgPgtkadqy77CzW
         TqIUxmbRN2N5g==
X-CNFS-Analysis: v=2.4 cv=ZYejiuZA c=1 sm=1 tr=0 ts=5f43fbf5
 a=ppQ2YIgYQAGACouVZCsPPQ==:117 a=ppQ2YIgYQAGACouVZCsPPQ==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=qnnqL9_eLCmMa0nUPbIA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
Reply-To: kreijack@inwind.it
Subject: Re: [Help] Can't login to my systemd-homed user account due to
 fallocate failure
To:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Chris Murphy <lists@colorremedies.com>,
        Andrii Zymohliad <azymohliad@protonmail.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <bdJVxLiFr_PyQSXRUbZJfFW_jAjsGgoMetqPHJMbg-hdy54Xt_ZHhRetmnJ6cJ99eBlcX76wy-AvWwV715c3YndkxneSlod11P1hlaADx0s=@protonmail.com>
 <CAJCQCtTC2yi4HRqg6fkMrxw33TVSBh_yAKtnX-Z1-nXSVjBW7w@mail.gmail.com>
 <Yy8-04dbNru1LWPcNZ9UxsagH1b0KNsGn7tDEnxVOqS812IqGiwl37dj4rxAh05gEP8QoNJ5F_Ea6CZ8iZgvnupuq5Qzc38gl69MceWMc9s=@protonmail.com>
 <CAJCQCtSqe_oqRZWYP7iLJcGQnzZkC4vmoYVTm_9RPb8eb0-E6Q@mail.gmail.com>
 <2aed3d08-94fe-f2ef-e858-31913a8ecfee@gmail.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <b0d0784a-03b5-c212-f4a1-f09ff487e355@libero.it>
Date:   Mon, 24 Aug 2020 19:42:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <2aed3d08-94fe-f2ef-e858-31913a8ecfee@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfI2dI3/Pk5DmRZzXMvvK/0zchH0qg+6rLoIoqLV+AP45an1oRTrInswQ02h2nRqYqsA8LHEEJbM8pyiFt3PEQ5nAiaBtq1PHAih8BO43RApUePuwpJcH
 sxNsIeOweHhcXApV3pMc/VDi6rTT6liw9suZwfCTTBu0WTFo859ujxcGjAtKrsUNXU32Tf6PQilWF7ODQNmex/LlAcrSqEO8P3DbwDfUtF6pPr8qMbiGlNnj
 KfGhcjL7BLzdSHWI8TCNMOO6yKV6oxpszhiQsZIuw9cWIUAQG7p5SAeU9kNoiP0T
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/24/20 5:23 PM, Andrei Borzenkov wrote:
> 24.08.2020 10:13, Chris Murphy пишет:
>>
>> I think we've got a pretty good idea what's going on. The current work
>> around in your case will be to use the --luks-discard=true option when
>> activating. This will avoid the fallocate step. But the question
>> remains why the fallocate fails. I suspect it has something to do with
>> shared extents.
> 
> 
> Actually I see the same behavior without any shared extent at all.
> fallocate attempts to allocate full file size, not just additional
> unallocated space:

I don't remember if at the time it was reached a conclusion, but this topic was already discussed in the past:

https://lore.kernel.org/linux-btrfs/798a9077-bcbd-076c-a458-3403010ce8ac@libero.it/

I think that this information should be forwarded back to the systemd mailing list...

Anyway IMHO a failing fallocate for a small file is a reasonable failure.
However I am not convinced that this is still true for a filesystem image (like the systemd-homed
case is). In this case it is reasonable to thinking the image as sparse image as a way of
over-provisioning.
However it is true that not all the stack (btrfs <-> loopback <-> luks <-> btrfs) is able to manage
a case where there is no space, so fallocat'ing may be the least worst scenario...

> 
> tw:/mnt # truncate -s $[112*5]M src/file
> tw:/mnt # dd if=/dev/urandom of=src/file conv=notrunc,block,sync bs=112M
> count=20+2 records in
> 2+0 records out
> 234881024 bytes (235 MB, 224 MiB) copied, 1.53186 s, 153 MB/s
> tw:/mnt # sync
> tw:/mnt # btrfs fi us /mnt
> Overall:
>      Device size:		   1.00GiB
>      Device allocated:		 356.00MiB
>      Device unallocated:		 668.00MiB
>      Device missing:		     0.00B
>      Used:			 224.59MiB
>      Free (estimated):		 787.81MiB	(min: 787.81MiB)
>      Data ratio:			      1.00
>      Metadata ratio:		      1.00
>      Global reserve:		   3.25MiB	(used: 0.00B)
>      Multiple profiles:		        no
> 
> Data,single: Size:344.00MiB, Used:224.19MiB (65.17%)
>     /dev/vdc	 344.00MiB
> 
> Metadata,single: Size:8.00MiB, Used:400.00KiB (4.88%)
>     /dev/vdc	   8.00MiB
> 
> System,single: Size:4.00MiB, Used:16.00KiB (0.39%)
>     /dev/vdc	   4.00MiB
> 
> Unallocated:
>     /dev/vdc	 668.00MiB
> tw:/mnt # fallocate -l $[112*5]M -n src/file
> tw:/mnt # sync
> tw:/mnt # btrfs fi us /mnt
> Overall:
>      Device size:		   1.00GiB
>      Device allocated:		 916.00MiB
>      Device unallocated:		 108.00MiB
>      Device missing:		     0.00B
>      Used:			 560.78MiB
>      Free (estimated):		 451.62MiB	(min: 451.62MiB)
>      Data ratio:			      1.00
>      Metadata ratio:		      1.00
>      Global reserve:		   3.25MiB	(used: 0.00B)
>      Multiple profiles:		        no
> 
> Data,single: Size:904.00MiB, Used:560.38MiB (61.99%)
>     /dev/vdc	 904.00MiB
> 
> Metadata,single: Size:8.00MiB, Used:400.00KiB (4.88%)
>     /dev/vdc	   8.00MiB
> 
> System,single: Size:4.00MiB, Used:16.00KiB (0.39%)
>     /dev/vdc	   4.00MiB
> 
> Unallocated:
>     /dev/vdc	 108.00MiB
> tw:/mnt # btrfs fi du src/file
>       Total   Exclusive  Set shared  Filename
>   560.00MiB   560.00MiB       0.00B  src/file
> tw:/mnt # uname -a
> Linux tw.0.2.15 5.8.0-1-default #1 SMP Tue Aug 4 07:30:59 UTC 2020
> (9bc0044) x86_64 x86_64 x86_64 GNU/Linux
> tw:/mnt #
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
