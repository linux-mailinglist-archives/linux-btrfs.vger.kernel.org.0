Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53653536485
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 17:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353507AbiE0PNn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 11:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236970AbiE0PNk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 11:13:40 -0400
Received: from mail.cock.li (unknown [37.120.193.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC141CFF3
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 08:13:39 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firemail.cc; s=mail;
        t=1653664417; bh=A04WBhvq4uoOwzMBacvDb0kWyK9asPmPZiSUTrRsxCM=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=QAa5oR83PdB67gN0sygy+UCQRGkHN+nayDyZ9XZ1C8/T1ouQ2W2qcs4UDOGtw91UM
         jT/beoVpzLxXL/7JI7lQh30UJMDz99HnJH/p6GpyzqjQdBYSf2eXeIHpi/uVC798mD
         fDwae7vmDLMYLvKkWXNavoLKfnlgQcdiU3gSDCYGSXpXeUn/y5n5RHD5aKnxjgxU3x
         nGXN7J6G3SdBZHFkyKZdghGtuA4vTujUjNbnpTpLpC0tEFa6tRZWbFH+XP/ccKKwru
         j7+wIkGr1n2gUFwQi61OnlEByz1+heBJWVlafb0VR1f6nvxV17QjKn2Q/bJ0zJy4EZ
         FeLUN1YDNKWKg==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 27 May 2022 16:13:36 +0100
From:   efkf@firemail.cc
To:     Chris Murphy <lists@colorremedies.com>, linux-btrfs@vger.kernel.org
Subject: Re: Tried to replace a drive in a raid 1 and all hell broke loose
In-Reply-To: <CAJCQCtT_PjKprryxHwsyn3qXc06qFFmnMR48CxZuvav8aQUOQQ@mail.gmail.com>
References: <9a9d16a133c13bed724f2a6a406bd3b6@firemail.cc>
 <5fd50e9.def5d621.180f273d002@tnonline.net>
 <f39a23c9fe32b5ae79ddbe67e1edb7a8@firemail.cc>
 <af34ef558ea7bbd414b5a076128b1011@firemail.cc>
 <b713b9540ad29a83a3c2c672139d6e6f@firemail.cc>
 <CAJCQCtT_PjKprryxHwsyn3qXc06qFFmnMR48CxZuvav8aQUOQQ@mail.gmail.com>
Message-ID: <4e7fdc9608777774595bf060a028b600@firemail.cc>
X-Sender: efkf@firemail.cc
User-Agent: Roundcube Webmail/1.3.17
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

thanks a lot for reading into this

On 2022-05-24 20:11, Chris Murphy wrote:
> I suggest mounting with "mount -o ro,rescue=all"
Thanks a lot, with this command I was able to mount the filesystem again 
and retrieve a lot more data!
Only a very small percentage of the files (that i could check) were 
corrupt.

> Do you have a complete dmesg that shows boot, mount, and the kernel
> errors while copying?
If you mean the copying of the data mentioned on my update email then 
yes, its the attached file on this one.


> From one of your attached files:
> 
>> Total devices 2 FS bytes used 772.76GiB
>> devid    2 size 1.82TiB used 334.00GiB path 
>> /dev/mapper/ST2000DL003-###############
>> devid    3 size 1.82TiB used 661.00GiB path 
>> /dev/mapper/ST3000VN007-###############
> 
> This doesn't list a 3rd device so it suggests it's a 2x device raid1. 
> However:

I had (i think) successfully removed the failing drive with devid 1

> 
>> #btrfs fi df /mnt/sd/
>> Data, RAID1: total=772.00GiB, used=771.22GiB
>> Data, single: total=1.00GiB, used=2.25MiB
>> System, RAID1: total=32.00MiB, used=96.00KiB
>> System, single: total=32.00MiB, used=48.00KiB
>> Metadata, RAID1: total=3.00GiB, used=1.54GiB
>> Metadata, single: total=1.00GiB, used=0.00B
> 
> This is not good. Some of the data and some of the metadata
> (specifically system profile which is the chunk tree) is only
> available on one drive
I had that issue with single chunks, run the command to make it all 
raid1, run a scrub some checks messed around a tiny bit, most likely 
mounted with -o degraded in the process and they appeared again ( on 
linux 5.17.0 ).


> Some older kernels would create single
> profile chunks when a raid1 file system was mounted in degraded,rw
> mode with a missing device. This happens silently.

I had mounted the fs with -o degraded and one drive a couple of times 
just as a sanity check to make sure the data really is in both drives, i 
assume this would mount it rw and fall into the category you described. 
The first chunks were created before having updated to debian testing 
under kernel 5.10.0-11 but the same thing happened after updating to 
testing
I think i had tried to mount ro,degraded and it failed but i'm not sure.

Once again thank you so much for suggesting -o rescue=all, i had 
previously managed to recover around 300G and now i think i got the full 
~800G with a very small amount of corrupted files !!
