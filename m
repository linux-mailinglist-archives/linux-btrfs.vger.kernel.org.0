Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E705F8B67
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Oct 2022 14:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiJIM4w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Oct 2022 08:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiJIM4v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 9 Oct 2022 08:56:51 -0400
Received: from mr3.vodafonemail.de (mr3.vodafonemail.de [145.253.228.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877EB2CE2C
        for <linux-btrfs@vger.kernel.org>; Sun,  9 Oct 2022 05:56:49 -0700 (PDT)
Received: from smtp.vodafone.de (unknown [10.0.0.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mr3.vodafonemail.de (Postfix) with ESMTPS id 4Mlhrb5NXJz1ypy;
        Sun,  9 Oct 2022 12:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arcor.de;
        s=vfde-mb-mr2-21dec; t=1665320207;
        bh=dpCTJq75XMyKNvUZFjcxcmbKDqISnKHKrV2WyhJuPNw=;
        h=Message-ID:Date:User-Agent:Subject:To:References:Content-Language:
         From:In-Reply-To:Content-Type:From;
        b=BeUPzazMF2Ozp8x0ZD9zJzkV6YJ5dHRh7EwBwJ8C401AsADV/Aq7b54NxA/30zZ/p
         T1tY7exMboWdFn0QquRY+EPcmy91UYbNAKEZfQgb97DPk26llGnGxWtLmu+kUlswwE
         8CufDWH9Z5p+CVWYpYAnkrul0Oibk430TamrGlQc=
Received: from [10.0.2.6] (p54afaf98.dip0.t-ipconnect.de [84.175.175.152])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp.vodafone.de (Postfix) with ESMTPSA id 4MlhrW5t9lzMmvC;
        Sun,  9 Oct 2022 12:56:40 +0000 (UTC)
Message-ID: <31e00e1f-38c3-0b9a-7944-2d04426aa1c0@arcor.de>
Date:   Sun, 9 Oct 2022 14:56:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: RAID5 on SSDs - looking for advice
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <a502eed4-b164-278a-2e80-b72013bcfc4f@arcor.de>
 <86f8b839-da7f-aa19-d824-06926db13675@gmx.com>
Content-Language: en-US
From:   Ochi <ochi@arcor.de>
In-Reply-To: <86f8b839-da7f-aa19-d824-06926db13675@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 5790
X-purgate-ID: 155817::1665320206-9E4964B9-6C647F1F/0/0
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 09.10.22 13:36, Qu Wenruo wrote:
> 
> 
> On 2022/10/9 18:34, Ochi wrote:
>> Hello,
>>
>> I'm currently thinking about migrating my home NAS to SSDs only. As a
>> compromise between space efficiency and redundancy, I'm thinking about:
>>
>> - using RAID5 for data and RAID1 for metadata on a couple of SSDs (3 or
>> 4 for now, with the option to expand later),
> 
> Btrfs RAID56 is not safe against the following problems:
> 
> - Multi-device data sync (aka, write hole)
>    Every time a power loss happens, some RAID56 writes may get de-
>    synchronized.
> 
>    Unlike mdraid, we don't have journal/bitmap at all for now.
>    We already have a PoC write-intent bitmap.
> 
> - Destructive RMW
>    This can happen when some of the existing data is corrupted (can be
>    caused by above write-hole, or bitrot.
> 
>    In that case, if we have write into the vertical stripe, we will
>    make the original corruption further spread into the P/Q stripes,
>    completely killing the possibility to recover the data.
> 
>    This is for all RAID56, including mdraid56, but we're already working
>    on this, to do full verification before a RMW cycle.

Especially from the last point (and others below) I understand that 
RAID56 is still in quite active development with known issues being 
worked on, and it's not only regarding the write-hole that I guess many 
btrfs users have heard about in the context of RAID56.

> - Extra IO for RAID56 scrub.
>    It will cause at least twice amount of data read for RAID5, three
>    times for RAID6, thus it can be very slow scrubbing the fs.
> 
>    We're aware of this problem, and have one purposal to address it.
> 
>    You may see some advice to only scrub one device one time to speed
>    things up. But the truth is, it's causing more IO, and it will
>    not ensure your data is correct if you just scrub one device.
> 
>    Thus if you're going to use btrfs RAID56, you have not only to do
>    periodical scrub, but also need to endure the slow scrub performance
>    for now.

Interesting point. I will probably start out with 20-24 TB of raw 
storage space, and scrubbing may actually take a significant amount of 
time even with SATA SSD speeds. If RAID56 makes this even worse, it 
might be an issue to be aware of.

>> - using compression to get the most out of the relatively expensive SSD
>> storage,
>> - encrypting each drive seperately below the FS level using LUKS (with
>> discard enabled).
>>
>> The NAS is regularly backed up to another NAS with spinning disks that
>> runs a btrfs RAID1 and takes daily snapshots.
>>
>> I have a few questions regarding this approach which I hope someone with
>> more insight into btrfs can answer me:
>>
>> 1. Are there any known issues regarding discard/TRIM in a RAID5 setup?
> 
> Btrfs doesn't support TRIM inside RAID56 block groups at all.
> 
> Trim will only work for the unallocated space of each disk, and the
> unused space inside the METADATA RAID1 block groups.

Thank you for the insight. I didn't think that the statement from 2013 
might actually still be valid nowadays, but I'm glad I asked. :) I'm not 
sure know how important the trim information _actually_ is for the SSDs 
at the end (with regards to the internal implementation of the 
particular SSDs), but I guess it's another aspect to be aware of with 
RAID56+SSDs.

>> Is discard implemented on a lower level that is independent of the
>> actual RAID level used? The very, very old initial merge announcement
>> [1] stated that discard support was missing back then. Is it implemented
>> now?
>>
>> 2. How is the parity data calculated when compression is in use? Is it
>> calculated on the data _after_ compression? In particular, is the parity
>> data expected to have the same size as the _compressed_ data?
> 
> To your question, P/Q is calculated after compression.
> 
> Btrfs and mdraid56, they work at block layer, thus they don't care the
> data size of your write.(although full-stripe aligned write is way
> better for performance)
> 
> All writes (only considering the real writes which will go to physical
> disks, thus the compressed data) will first be split using full stripe
> size, then go either full-stripe write path or sub-stripe write.
> 
>>
>> 3. Are there any other known issues that come to mind regarding this
>> particular setup, or do you have any other advice?
> 
> We recently fixed a bug that read time repair for compressed data is not
> really as robust as we think.
> E.g. the corruption in compressed data is interleaved (like sector 1 is
> corrupted in mirror 1, sector 2 is corrupted in mirror 2).
> 
> In that case, we will consider the full compressed data as corrupted,
> but in fact we should be able to repair it.

It's always fascinating what kind of corner cases might appear that one 
may or may not have thought about initially. :)

Taking everything into account, maybe I will consider what alternative 
options I have for my particular use case until more issues have been 
ironed out. Maybe RAID5 is overcomplicating things in my case after all. 
A significant amount of the data I'm going to store is pretty static in 
nature, so maybe using single devices and merging them in some way (with 
something like MergerFS as Roman Mamedov suggested in another reply to 
my original mail, but I'll have to take a closer look), together with my 
regular backup, is another viable option for me that is possibly less 
error-prone.

Thank you!

> You may want to use newer kernel with that fixed if you're going to use
> compression.
> 
>>
>> [1] https://lwn.net/Articles/536038/
>>
>> Best regards
>> Ochi
