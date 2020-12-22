Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2202E0820
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Dec 2020 10:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbgLVJc2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Dec 2020 04:32:28 -0500
Received: from mx.exactcode.de ([144.76.154.42]:55630 "EHLO mx.exactcode.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbgLVJc1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Dec 2020 04:32:27 -0500
X-Greylist: delayed 1183 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Dec 2020 04:32:26 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de; s=x;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject; bh=6pBohVzd+I91OTwclyUo99CJiAUm29mThuQM+AgYaNg=;
        b=vCUONNf69GxHoQOBO90OX3bjNXN1b8xTtFOmZcnENs2Simc94s15aYn3DSSo9RG/zZlKHVzxXE/Jda5ohVbDbju6pDFVQdBbwCuLIdDRY86zTdycIBbqbubxGzEGP9HDzLKgp0Nilmr9ZRy+s1/PwgF/48fJh84N820TuZDQBJs=;
Received: from exactco.de ([90.187.5.221])
        by mx.exactcode.de with esmtp (Exim 4.82)
        (envelope-from <rene@exactcode.com>)
        id 1krdii-0000EO-PM; Tue, 22 Dec 2020 09:12:40 +0000
Received: from [192.168.2.130]
        by exactco.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.86_2)
        (envelope-from <rene@exactcode.com>)
        id 1krdXn-00058w-7d; Tue, 22 Dec 2020 09:01:24 +0000
Subject: Re: [BUG] 500-2000% performance regression w/ 5.10
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        =?UTF-8?Q?Ren=c3=a9_Rebe?= <rene@exactcode.de>,
        linux-btrfs@vger.kernel.org
References: <B4BB2DCB-C438-4871-9DDD-D6FB0E6E4F1B@exactcode.de>
 <55e24dfb-8985-b972-2cd5-7b810661672d@gmx.com>
From:   Rene Rebe <rene@exactcode.com>
Message-ID: <cc99c0a9-6b2f-559f-c867-d2064ab46e09@exactcode.com>
Date:   Tue, 22 Dec 2020 10:12:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <55e24dfb-8985-b972-2cd5-7b810661672d@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Score: -0.3 (/)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear Qu,

On 12/22/20 9:28 AM, Qu Wenruo wrote:
> On 2020/12/22 上午3:45, René Rebe wrote:
>> Hey there,
>>
>> as a long time btrfs user I noticed some some things became very slow
>> w/ Linux kernel 5.10. I found a very simple test case, namely extracting
>> a huge tarball like:
>>
>>    tar xf 
>> /usr/src/t2-clean/download/mirror/f/firefox-84.0.source.tar.zst
>>
>> Why my external, USB3 road-warrior SSD on a Ryzen 5950x this
>> went from ~15 seconds w/ 5.9 to nearly 5 minutes in 5.10, or 2000%
>>
>> To rule out USB, I also tested a brand new PCIe 4.0 SSD, with
>> a similar, albeit not as shocking regression from 5.2 seconds
>> to ~34 seconds or∫~650%.
>>
>> Somehow testing that in a VM did over virtio did not produce
>> as different results, although it was already 35 seconds slow
>> with 5.9.
>>
>> # first bad commit: [38d715f494f2f1dddbf3d0c6e50aefff49519232]
>>    btrfs: use btrfs_start_delalloc_roots in shrink_delalloc
>
> This means metadata space is not enough and we go shrink_delalloc() to
> free some metadata space.
>
> My concern is, why we need to go shrink_delalloc() in the first place.
>
> Normally either the fs has enough unallocated space (thus we can
> over-commit) or has enough unused metadata space.
>
> We only need to shrink delalloc if we have no unallocated space, and not
> enough space for the over-estimated metadata reserve.
>
>
> Would you please try to provide the `btrfs fi usage` output of your test
> drive?
> My initial guess is, this is related to fs usage/layout.


Thank you for looking into this and your reply.

That was my initial thoguht, too, and thus I already had run the test on 
a brand new, previously unused 1TB SSD with a fresh mkfs.btrfs with 
similar results to the long used drive:

# btrfs fi usage /mnt/
Overall:
     Device size:                 931.51GiB
     Device allocated:              4.01GiB
     Device unallocated:          927.50GiB
     Device missing:                  0.00B
     Used:                        640.00KiB
     Free (estimated):            930.50GiB      (min: 930.50GiB)
     Data ratio:                       1.00
     Metadata ratio:                   1.00
     Global reserve:                3.25MiB      (used: 0.00B)

Data,single: Size:3.00GiB, Used:512.00KiB
    /dev/nvme0n1    3.00GiB

Metadata,single: Size:1.01GiB, Used:112.00KiB
    /dev/nvme0n1    1.01GiB

System,single: Size:4.00MiB, Used:16.00KiB
    /dev/nvme0n1    4.00MiB

Unallocated:
    /dev/nvme0n1  927.50GiB


# mkfs.btrfs /dev/nvme0n1 -f

# mount /dev/nvme0n1 /mnt

# cat /t2/download/mirror/f/firefox-84.0.source.tar.zst > /dev/null
# time tar -x -C /mnt -f /t2/download/mirror/f/firefox-84.0.source.tar.zst

I hope this helps,

   René

> Thanks,
> Qu
>>
>> Now just this single commit does obviously not revert cleanly,
>> and I did not have the time today to look into the rather more
>> complex code today.
>>
>> I hope this helps improve this for the next release, maybe you
>> want to test on bare metal, too.
>>
>> Greetings,
>>     René    https://youtu.be/NhUMdvLyKJc
>>
