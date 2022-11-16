Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C045262B37D
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Nov 2022 07:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiKPGuF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 16 Nov 2022 01:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbiKPGuE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Nov 2022 01:50:04 -0500
X-Greylist: delayed 556 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Nov 2022 22:50:02 PST
Received: from pio-pvt-msa2.bahnhof.se (pio-pvt-msa2.bahnhof.se [79.136.2.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560BE624F
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 22:50:02 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 0345E40525;
        Wed, 16 Nov 2022 07:40:43 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6xnXb1mIXXAi; Wed, 16 Nov 2022 07:40:41 +0100 (CET)
Received: by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 9CCA740519;
        Wed, 16 Nov 2022 07:40:41 +0100 (CET)
Received: from [104.28.234.221] (port=26491 helo=[10.208.94.3])
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1ovC6B-000H9l-Ez; Wed, 16 Nov 2022 07:40:40 +0100
Date:   Wed, 16 Nov 2022 07:40:35 +0100 (GMT+01:00)
From:   Forza <forza@tnonline.net>
To:     Spencer Collyer <spencer@spencercollyer.plus.com>,
        linux-btrfs Mailinglist <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <b8bc96b.b07fe284.1847f2b0003@tnonline.net>
Subject: Re: Change BTRFS filesystem back to R/W from R/O
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



---- From: Spencer Collyer <spencer@spencercollyer.plus.com> -- Sent: 2022-11-15 - 15:08 ----

> (Resending to the list as I accidentally sent it just to Qu.)
> 
> On Tue, 15 Nov 2022 20:41:54 +0800, Qu Wenruo wrote:
> 
>> Considering you have some metadata space left, I believe you can free 
>> enough space by deleting files (aka, moving it to other filesystems)
>> 
>> Thanks,
>> Qu  
> 
> Hi Qu,
> 
> Thanks for that. You say I should move some files to other filesystems, but that's really the nub of my problem - the filesystem is marked as read-only. Am I Ok to do what I mentioned previously:
> 
>> 1) Unmount the filesystem.
>> 2) Remount it as R/W
>> 3) Move data to the external disk  
> 
> If that is all good, would I need to do anything else or would the BTRFS system sort itself out correctly?

With enough `unallocated` space, Btrfs will be OK. Read below for more details on why/how... 

> 
> Thanks for your attention,
> 
> Spencer
> 
> PS. The output form the 'btrfs fi usage /data' command you requested is as follows (run as root to get everything):
> 
> Overall:
>     Device size:		  10.92TiB
>     Device allocated:		  10.92TiB
>     Device unallocated:		   1.00MiB
>     Device missing:		     0.00B
>     Device slack:		     0.00B
>     Used:			  10.90TiB
>     Free (estimated):		  15.26GiB	(min: 15.26GiB)
>     Free (statfs, df):		  15.26GiB
>     Data ratio:			      1.00
>     Metadata ratio:		      2.00
>     Global reserve:		 512.00MiB	(used: 0.00B)
>     Multiple profiles:		       yes	(metadata, system)
> 
> Data,RAID0: Size:10.87TiB, Used:10.86TiB (99.86%)
>    /dev/mapper/data1	   5.44TiB
>    /dev/mapper/data2	   5.44TiB
> 
> Metadata,single: Size:8.00MiB, Used:0.00B (0.00%)
>    /dev/mapper/data1	   8.00MiB
> 
> Metadata,RAID1: Size:23.00GiB, Used:21.39GiB (93.00%)
>    /dev/mapper/data1	  23.00GiB
>    /dev/mapper/data2	  23.00GiB
> 
> System,single: Size:4.00MiB, Used:0.00B (0.00%)
>    /dev/mapper/data1	   4.00MiB
> 
> System,RAID1: Size:8.00MiB, Used:784.00KiB (9.57%)
>    /dev/mapper/data1	   8.00MiB
>    /dev/mapper/data2	   8.00MiB
> 
> Unallocated:
>    /dev/mapper/data1	     0.00B
>    /dev/mapper/data2	   1.00MiB


Btrfs uses a multi stage allocator. The first stage allocates large regions of space known as chunks for specific types of data, then the second stage allocates blocks like a regular (old-fashioned) filesystem within these larger regions.

In your case, btrfs needed to allocate another metadata chunk, but as you see, there is no `unallocated` space available. Btrfs went read-only to protect itself from damage.

Balancing means Btrfs moved data between chunks so that it can free them. It means that if there are two chunks with 50% usage, Btrfs can compact the data into one chunk and free the other, increasing the unallocated space that can be used for new allocations as needed.

It might be good to schedule a limited data balance at regular intervals to ensure there are always a few unallocated gigabytes.

I wrote a little about it on my wiki  https://wiki.tnonline.net/w/Btrfs/ENOSPC and https://wiki.tnonline.net/w/Btrfs/Balance

Regards,
Forza 
