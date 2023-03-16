Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26EE26BD89F
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Mar 2023 20:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjCPTH4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Mar 2023 15:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjCPTHy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Mar 2023 15:07:54 -0400
Received: from libero.it (smtp-31-wd.italiaonline.it [213.209.13.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BECE4C5F
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Mar 2023 12:07:38 -0700 (PDT)
Received: from [192.168.1.27] ([84.220.128.202])
        by smtp-31.iol.local with ESMTPA
        id cswppisaF5FHKcswppdNYf; Thu, 16 Mar 2023 20:07:35 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1678993655; bh=+GEQBatEBeOg4qdilFF2ifG5dYHvidhLlQ/gHYubdc0=;
        h=From;
        b=KwR/x2BMQfIP/ni8gOmnz0pvGWxwtu5mEg3e/dTVXqY3pse02NLRcbbOAeUjX7Xzk
         Ti9ePa3MN2rWWxRGljMWa3h51Ir2lz3sXas29CuSOZdJWt2X2MEaPBNY8+ZmTmU5fA
         VNEcgDYlJyrvBDvCkJ/TGhSoNEzcnoDi4dNKs0oT+vS6f3wVaFNx5cXTHEHzYC39n+
         mf9PbbJznEDUjj5H7VxixKLjk0dGCZxeSdSpnM+5D/c8M8VPzsZYROS6O2TdhAwdRR
         HO8j0fUsNQi1uD+TNh7FA5DZ1yX1nNOUQMUhk150Zgf/1/zV76mg1r9onyr/hpOhRn
         Xh/QeFWvudv1w==
X-CNFS-Analysis: v=2.4 cv=Q7IUoa6a c=1 sm=1 tr=0 ts=641368f7 cx=a_exe
 a=7XXxH8DXEs6J8bMFqK0LmA==:117 a=7XXxH8DXEs6J8bMFqK0LmA==:17
 a=IkcTkHD0fZMA:10 a=bZBIavpCO2DmXpAkWOQA:9 a=QEXdDO2ut3YA:10
Message-ID: <3fd217a8-8694-a3dc-06b6-c5f8a1dca57e@libero.it>
Date:   Thu, 16 Mar 2023 20:07:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: kreijack@inwind.it
Subject: Re: Btrfs Raid10 eating all Ram on Mount
To:     Robert Krig <robert.krig@render-wahnsinn.de>,
        linux-btrfs@vger.kernel.org
References: <dd155011-37a5-b597-a3ff-db63176d8fa1@render-wahnsinn.de>
 <8121e6ba-f6e5-77ba-8a82-2c65d271c115@libero.it>
 <2a0c8279-9521-2661-056f-bc5560094356@render-wahnsinn.de>
 <00abe228-fe4c-cb9c-9617-77a6b0944c06@render-wahnsinn.de>
Content-Language: en-US
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <00abe228-fe4c-cb9c-9617-77a6b0944c06@render-wahnsinn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfAKjH6BejoMIRdKusr02HLRMaj5SsFXqia4Iw0kU0a+E8Sk2d8Ul44HqhR4dxPWXqqLJaZSnLzIgJjkcl5zeXCUpZBFX+4EZUrWCG3Q88/4ZgqpHgO0f
 RKAabLGSONwLfz2GT+v54oYx/+VZvabwoHWkRbOMGgt/XM05g/bNjDLLxZMxwb6EPGqNcHT0WwxwwH3YNCASQHMa8LnilPxZmnvrGSw9MBx7rMK9oBZio0Rb
 VDnaK118dOKCki8MisnE9w==
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 16/03/2023 08.57, Robert Krig wrote:
> Update:
> 
> Ok, mounting as read-only seems to have done the trick (for now). At least it looks like I'm able to btrfs send snapshots to my new server without the RAM increasing.
> 
> How can I avoid this sort of thing in the future? Not using deduplication tools on snapshots? Only deleting one snapshot at a time and wait until I no longer see a btrfs-cleaner process?

I am not sure how a deduplication tool is compatible with multiple snapshot.
In theory both the snapshot and the deduplication create multiple reference to the same pieces of data.
However snapshot does the same for metadata (and this is good); instead dedup does the opposite: unshare the metadata to improve the sharing between the files of the same pieces of data (bad); this means that you have smal reduction of the data, at the cost of increasing the metadata.

It would be useful if you share the information about the metadata/data usage:

# btrfs fi us <mnt>

I suspect that you have a lot of metadata that creates the problem that you are experiencing.

Even tough it should not degenerate to an oom situation.

BR
> 
> 
> 
> 
> Am 16.03.23 um 08:02 schrieb Robert Krig:
>> There were quite a few snapshots that I deleted on that system. But those snapshots were probably heavily de-duplicated since I was using the beesd tool to deduplicate the filesystem while in use.
>> At the moment, I just want to copy off some data from that filesystem, since that server is going to be cancelled.
>>
>> Could I just mount the FS readonly, would that prevent the btrfs-cleaner from running and eating all my ram?
>>
>>
>>
>>
>> Am 15.03.23 um 19:48 schrieb Goffredo Baroncelli:
>>> On 15/03/2023 08.26, Robert Krig wrote:
>>>> Hi,
>>>>
>>>>
>>>> I've got a bit of a strange situation here.  I've got a server with 4x16TB Drives in a RAID10 for data and a Raid1C4 for metadata configuration.
>>>> I'm currently retiring that server so I've been transferring and deleting snapshots from it.
>>>
>>> Deleting a snapshot requires a background process to release all the resource allocated on the filesystem.
>>>
>>>>
>>>> For some reason, this server (Debian with kernel 6.2.1) suddenly starts eating all of my ram (64GB). Even if completely idle. I see that there is a btrfs-transaction process and a btrfs-cleaner process that are running and using quite a bit of cpu.
>>>>
>>>> Basically, even after a fresh reboot. Once I mount the array, the memory usage will slowly start to creep up, until it reaches OOM and the system freezes.
>>>
>>> Could you share some numbers about the filesystem, like the number of the snapshots deleted, the number of files of each snapshot and the kind of workload on the filesystem ? This to understand if 'btrfs-cleaner' is busy to 'unlink' the shared references between the files or not.
>>>
>>> Unfortunately btrfs-cleaner even if interrupted by an unmount, restarts at the next mount.
>>>
>>> Hoping that you had encountered a bug of the new 6.2.x series, may be a downgrading of the kernel could help. But before doing that, wait some other comments by other developers...
>>>>
>>>> I'm currently running a read-only check on the system and as far as I recall, I've never enabled Quotas on that system.
>>>>
>>>> Does anyone have any idea what's causing this, or how I can fix it?
>>>>
>>>

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

