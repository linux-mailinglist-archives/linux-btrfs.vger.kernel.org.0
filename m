Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9085118D676
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Mar 2020 19:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgCTSCQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Mar 2020 14:02:16 -0400
Received: from smtp205.alice.it ([82.57.200.101]:62554 "EHLO smtp205.alice.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbgCTSCP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Mar 2020 14:02:15 -0400
X-Greylist: delayed 334 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Mar 2020 14:02:13 EDT
Received: from venice.bhome (84.220.24.82) by smtp205.alice.it (8.6.060.28) (authenticated as kreijack@alice.it)
        id 5E177A8C11B75E30 for linux-btrfs@vger.kernel.org; Fri, 20 Mar 2020 18:56:38 +0100
Reply-To: kreijack@inwind.it
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
From:   Goffredo Baroncelli <kreijack@alice.it>
Subject: Question: how understand the raid profile of a btrfs filesystem
Message-ID: <517dac49-5f57-2754-2134-92d716e50064@alice.it>
Date:   Fri, 20 Mar 2020 18:56:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

for a btrfs filesystem, how an user can understand which is the {data,mmetadata,system} [raid] profile in use ? E.g. the next chunk which profile will have ?
For simple filesystem it is easy looking at the output of (e.g)  "btrfs fi df" or "btrfs fi us". But what if the filesystem is not simple ?

btrfs fi us t/.
Overall:
     Device size:		  40.00GiB
     Device allocated:		  19.52GiB
     Device unallocated:		  20.48GiB
     Device missing:		     0.00B
     Used:			  16.75GiB
     Free (estimated):		  12.22GiB	(min: 8.27GiB)
     Data ratio:			      1.90
     Metadata ratio:		      2.00
     Global reserve:		   9.06MiB	(used: 0.00B)

Data,single: Size:1.00GiB, Used:512.00MiB (50.00%)
    /dev/loop0	   1.00GiB

Data,RAID5: Size:3.00GiB, Used:2.48GiB (82.56%)
    /dev/loop1	   1.00GiB
    /dev/loop2	   1.00GiB
    /dev/loop3	   1.00GiB
    /dev/loop0	   1.00GiB

Data,RAID6: Size:4.00GiB, Used:3.71GiB (92.75%)
    /dev/loop1	   2.00GiB
    /dev/loop2	   2.00GiB
    /dev/loop3	   2.00GiB
    /dev/loop0	   2.00GiB

Data,RAID1C3: Size:2.00GiB, Used:1.88GiB (93.76%)
    /dev/loop1	   2.00GiB
    /dev/loop2	   2.00GiB
    /dev/loop3	   2.00GiB

Metadata,RAID1: Size:256.00MiB, Used:9.14MiB (3.57%)
    /dev/loop2	 256.00MiB
    /dev/loop3	 256.00MiB

System,RAID1: Size:8.00MiB, Used:16.00KiB (0.20%)
    /dev/loop2	   8.00MiB
    /dev/loop3	   8.00MiB

Unallocated:
    /dev/loop1	   5.00GiB
    /dev/loop2	   4.74GiB
    /dev/loop3	   4.74GiB
    /dev/loop0	   6.00GiB

This is an example of a strange but valid filesystem. So the question is: the next chunk which profile will have ?
Is there any way to understand what will happens ?

I expected that the next chunk will be allocated as the last "convert". However I discovered that this is not true.

Looking at the code it seems to me that the logic is the following (from btrfs_reduce_alloc_profile())

         if (allowed & BTRFS_BLOCK_GROUP_RAID6)
                 allowed = BTRFS_BLOCK_GROUP_RAID6;
         else if (allowed & BTRFS_BLOCK_GROUP_RAID5)
                 allowed = BTRFS_BLOCK_GROUP_RAID5;
         else if (allowed & BTRFS_BLOCK_GROUP_RAID10)
                 allowed = BTRFS_BLOCK_GROUP_RAID10;
         else if (allowed & BTRFS_BLOCK_GROUP_RAID1)
                 allowed = BTRFS_BLOCK_GROUP_RAID1;
         else if (allowed & BTRFS_BLOCK_GROUP_RAID0)
                 allowed = BTRFS_BLOCK_GROUP_RAID0;

         flags &= ~BTRFS_BLOCK_GROUP_PROFILE_MASK;

So in the case above the profile will be RAID6. And in the general if a RAID6 chunk is a filesystem, it wins !

But I am not sure.. Moreover I expected to see also reference to DUP and/or RAID1C[34] ...

Does someone have any suggestion ?

BR
G.Baroncelli

