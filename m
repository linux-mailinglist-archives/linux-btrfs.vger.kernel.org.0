Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABB759AD78
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Aug 2022 13:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241503AbiHTL2S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Aug 2022 07:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiHTL2Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Aug 2022 07:28:16 -0400
Received: from libero.it (smtp-16.italiaonline.it [213.209.10.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48C4228
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Aug 2022 04:28:11 -0700 (PDT)
Received: from [192.168.1.27] ([84.222.35.163])
        by smtp-16.iol.local with ESMTPA
        id PMe9oOhq7nJ6yPMe9oBeSH; Sat, 20 Aug 2022 13:28:09 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1660994889; bh=30Wr0Edw+1jn7yZRjw+pFJ2HHyL2yQBiQ1sVbtdCY+U=;
        h=From;
        b=Ulw8LxPJokY5TEzU6UiX0RIYXC3jeBFOcTEhBECaqKdsSRah4KGdKBta3/B04zUVi
         w3wfADwG5e8PXnA7zumjAaJELQEYIis4xySeyDSzFPyMlzsZA4C1NNuRByt2PY3Jad
         SyYP3HbCrlN/+r4fgWtUf2JrZXX0CDc46OL9xiscLU4iRZxGqkpVYu5dUIsPgwkMym
         2ImN14ia+dDfp5OR/suD7jzcl8NDCO1x6D+ODY5QQ4eZpNqW6+kmKpytWYayBjkVlK
         ryqjgUUPlWcL3N9yyR8YEWPU0fYEm2GDI2XTHzbeDrzl1SB9JPYarNaL56Lq5Et1rN
         vdsU6A6iWyH8w==
X-CNFS-Analysis: v=2.4 cv=E9MIGYRl c=1 sm=1 tr=0 ts=6300c549 cx=a_exe
 a=FwZ7J7/P4KMHneBNQvmhbg==:117 a=FwZ7J7/P4KMHneBNQvmhbg==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=UXIAUNObAAAA:8 a=PjuYqXk4AAAA:8
 a=zwdywIuLuQqAPXSNFTkA:9 a=QEXdDO2ut3YA:10 a=zaI_uc7A8u8A:10
 a=RMblk7DMegEA:10 a=AjGcO6oz07-iQ99wixmX:22
Message-ID: <aa81ac50-0f2f-73c0-5174-1709ec24b52c@libero.it>
Date:   Sat, 20 Aug 2022 13:28:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
Reply-To: kreijack@inwind.it
Subject: Re: What exactly is BTRFS Raid 10?
Content-Language: en-US
To:     George Shammas <btrfs@shamm.as>, linux-btrfs@vger.kernel.org
References: <a3fc9d94-4539-429a-b10f-105aa1fd3cf3@www.fastmail.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <a3fc9d94-4539-429a-b10f-105aa1fd3cf3@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfJq9WTFeZo257a2oyd04477cekaNeiWhtrThmuoPjjIUu8Uc9QMjXVcg/FejU+q9UPNf8/SyBhY5G0+nQE9FNl+kepzUdHecToUHcqREx4scsndioSjO
 9YRjjHvj1w/dCRa5NiCAvcVTfQlCPgWPOsHgNKcMnJUwn1kNJGGLxCXJHO8D2ukRXhZDaSdyZzjgLq9or/bPIjAChW+jw5TJ+NJOicyhKi5lgxnOuvmtGPBP
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/08/2022 18.49, George Shammas wrote:
> Hello,
> 
>   I've been searching and reading docs for a few days now, and btrfs raid 10 is a mystery to me.
> 
> This is mostly a documentation question, as many places reference it but nothing actually describes it and the real question is how does it differ from btrfs raid1.
> 
> Both BTRFS Raid1 and Raid10
>   - Allows arbitrary number of drives (>=2), including odd numbers.
>   - Will write duplicate blocks across disks.
> 
> Raid 10 is referenced in many places, including being the example on using btrfs on multiple devices
> 
> https://btrfs.wiki.kernel.org/index.php/Using_Btrfs_with_Multiple_Devices
> 
> And while raid0,1,5,6 are described in several places, raid 10 is missing. Including in the layout examples here:
> 
> https://btrfs.readthedocs.io/en/latest/mkfs.btrfs.html?highlight=raid10#profile-layout
> 
> The Raid 1 example there also likely needs a bit of explanation or validation, as all the blocks are written to one device. In that raid one example three devices could be lost as long as it is not one of them is the first device. It also cannot be accurate once the amount stored is above 1 full drive.
> 
> Since raid10 allows for two devices, is there ever a scenario in which choose raid10 would be bad when you want raid1?

The allocation is done by BTRFS not per disk but per "chunk". A chunk is the minimal unit of allocation.
Depending by the layout, the chunk may be spread over multiple disks. The size of chunk generally is about 1G x "disc count".
If you have a pool composed by 7 disk and the chunk is spread over all the disks, the chunk size is 1G x 7 = 7G.
Depending by the redundancy level the space available may be lesser.
When a chunk is filled, a new one is allocated.

Below the description of each profile, with an example of data allocation.

SINGLE:
A new chunk is allocated only in one disk, the one which more space free. There is not any redundancy.

DUP:
A new chunk is allocated only in one disk, the one which more space free.
The data is written two time in the same chunk, so the space available is half of the size of the chunk.

If you got corruption by a bad sector you can recover the data from the other copy.

RAID0:
This is a stripe mode, there is not any redundancy.
When a new unit of allocation is required, BTRFS allocate a new chunk over ALL the disk.
The chunk size is 1GB x disk count.
If you write data to a disk, the first 64k are written in the first disk, the 2nd 64 are written to the 2nd disk and so on..


RAID1:
A new chunk is allocated to the two disks with more space available. Each new chunk has a size of 1GB x 2 = 2GB, but only 1GB is available for the data because the other one contains a copy of the data.
A raid1 layout may have more than two disks. However the data is copied only two times, this means that you can tolerate only the lost of one device.
For example the first chunk is allocated on the first two disks; the 2nd chunk is allocated on the first and the 3rd disk; the 3rd chunk is allocated on the 2nd and 3rd disk....

RAID1C3, RAID1C4:
These profiles are variant of RAID1, where the data is copied 3 times or 4 times.

RAID10:
Is a mix of RAID0 and RAID1: the data is copied two times (so you can tolerate the lost of one device), but it is spread over near all the disks.
If you have 7 disks, a new chunk is allocated over 6 disks (the greatest even number <= to the disk count) with more space available.
If you write data to a disk, the first 64K are written on the 1st disk and and the 2nd disk (as 2nd copy). When you write the 2nd 64 k of data, these are written in the 3rd disk and 4th disk (as 2nd copy). And so on until you fill the chunk.
When the chunk is filled, a new allocation occurred. Likely the 7th disk is used and one of the first 6 isn't for the new chunk.

RAID5 (and 6)
A new chunk is allocated over all the disks. The space available in the new chunk is 1GB x (number of disk -1) (or -2 in case of raid 6).
If you write data to a disk, the first 64k are written in the first disk, the 2nd 64 are written to the 2nd disk and so on..



> 
> BTRFS defaults to raid1 for Data and Metadata, is there a reason that doesn't default to raid10?
> 
> Since BTRFS raid modes aren't like traditional block level raids, it would be very useful to explain this somewhere and the pros and cons of each. Maybe even merging the two modes if they cover the same use cases.
> 
> --George
> 
> PS:
> 
> There is a lot of misinformation out there about btrfs raid as well. For example:
> 
> https://www.reddit.com/r/btrfs/comments/f5unv5/raid_1_vs_raid_10/
> 
> None of the comments seem accurate, as they are describing traditional raid setups. The second comment says btrfs raid10 is actively harmful, but I has no references to collaborate that.

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

