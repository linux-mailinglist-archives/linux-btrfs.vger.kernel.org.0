Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCAC2E2E85
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Dec 2020 16:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgLZPa1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 26 Dec 2020 10:30:27 -0500
Received: from mx.exactcode.de ([144.76.154.42]:45260 "EHLO mx.exactcode.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgLZPa1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 26 Dec 2020 10:30:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de; s=x;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=9WTMlJxSuEUOJC+743U498aK5dGknBPyzrlPq/rxUvw=;
        b=U6y8oNJSFYpHwiKWErFjDKyoauFuPDYbhBhKf89vIcpP6q2hTfiL/aWWJWaTYvMkj5tfmD32FKafMrLmNE3tizK14ccY7Teiw/1Dg8riuY9DO9T7skzz56AgdIaHoimZuoMknuRunQDVn+Xz09nDaPhPnnKnk5oWAEL/qaBwvw4=;
Received: from exactco.de ([90.187.5.221])
        by mx.exactcode.de with esmtp (Exim 4.82)
        (envelope-from <rene@exactcode.com>)
        id 1ktBWS-00042q-Bt; Sat, 26 Dec 2020 15:30:24 +0000
Received: from [192.168.2.130]
        by exactco.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.86_2)
        (envelope-from <rene@exactcode.com>)
        id 1ktBLm-0006m5-BS; Sat, 26 Dec 2020 15:19:22 +0000
Subject: Re: [BUG] 500-2000% performance regression w/ 5.10
To:     Nikolay Borisov <nborisov@suse.com>,
        =?UTF-8?Q?Ren=c3=a9_Rebe?= <rene@exactcode.de>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org
References: <B4BB2DCB-C438-4871-9DDD-D6FB0E6E4F1B@exactcode.de>
 <6df7ff08-b9bf-a06e-13a9-bf1c431920e4@toxicpanda.com>
 <A2426D8D-893D-4B37-96CF-C9589730F437@exactcode.de>
 <b82b913a-11f7-4f79-a41b-c4d16135de80@suse.com>
From:   Rene Rebe <rene@exactcode.com>
Message-ID: <75c703bc-1f47-0f07-1421-55f6c889e996@exactcode.com>
Date:   Sat, 26 Dec 2020 16:30:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b82b913a-11f7-4f79-a41b-c4d16135de80@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Score: -0.1 (/)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey there,

On 12/26/20 1:24 PM, Nikolay Borisov wrote:
>
> On 24.12.20 г. 23:11 ч., René Rebe wrote:
>> Hi Josef,
>>
>>> On 24. Dec 2020, at 19:09, Josef Bacik <josef@toxicpanda.com> wrote:
>>>
>>> On 12/21/20 2:45 PM, René Rebe wrote:
>>>> Hey there,
>>>> as a long time btrfs user I noticed some some things became very slow
>>>> w/ Linux kernel 5.10. I found a very simple test case, namely extracting
>>>> a huge tarball like:
>>>>    tar xf /usr/src/t2-clean/download/mirror/f/firefox-84.0.source.tar.zst
>>>> Why my external, USB3 road-warrior SSD on a Ryzen 5950x this
>>>> went from ~15 seconds w/ 5.9 to nearly 5 minutes in 5.10, or 2000%
>>>> To rule out USB, I also tested a brand new PCIe 4.0 SSD, with
>>>> a similar, albeit not as shocking regression from 5.2 seconds
>>>> to ~34 seconds or∫~650%.
>>>> Somehow testing that in a VM did over virtio did not produce
>>>> as different results, although it was already 35 seconds slow
>>>> with 5.9.
>>>> # first bad commit: [38d715f494f2f1dddbf3d0c6e50aefff49519232]
>>>>    btrfs: use btrfs_start_delalloc_roots in shrink_delalloc
>>>> Now just this single commit does obviously not revert cleanly,
>>>> and I did not have the time today to look into the rather more
>>>> complex code today.
>>>> I hope this helps improve this for the next release, maybe you
>>>> want to test on bare metal, too.
>>> Alright to close the loop with this, this slipped through the cracks because I was doing a lot of performance related work, and specifically had been testing with these patches on top of everything
>>>
>>> https://lore.kernel.org/linux-btrfs/cover.1602249928.git.josef@toxicpanda.com/
>>>
>>> These patches bring the performance up to around 40% higher than baseline
>> I indeed tested the linux-btrfs for-5.11 and found the performance some 50% better. I would hope that can be brought back to 5.9 levels sometime soon ;-)
> Do you mean 50% better as compared to 5.9?


Sorry for any confusion, I meant 50% better than the bisected regression 
as found with 5.10, not yet as good as 5.9 has been before.


     René

>>> .  In the meantime we'll probably push this partial revert into 5.10 stable so performance isn't sucking in the meantime.  Thanks,
>> That certainly makes sense for the LTS kernel series.
>>
>> Thanks for looking into this,
>> Merry Christmas,
>> 	René Rebe
>>
