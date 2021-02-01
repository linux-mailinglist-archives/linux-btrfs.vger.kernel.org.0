Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF6E30B214
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Feb 2021 22:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbhBAV3L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Feb 2021 16:29:11 -0500
Received: from smtp-36.italiaonline.it ([213.209.10.36]:51698 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230110AbhBAV3G (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Feb 2021 16:29:06 -0500
Received: from venice.bhome ([84.220.24.72])
        by smtp-36.iol.local with ESMTPA
        id 6gkAlJHqMi3tS6gkAlGswf; Mon, 01 Feb 2021 22:28:23 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1612214903; bh=nJiVQ5GKlbUDGRDEAGnHJIgplbE++5nHmvKt/typobw=;
        h=From;
        b=Dsaps+7+9DqR8bRN2qXRN0KzRzQZvN1+bSitElfzrdfXOXeuA87Q8LII1jXztrZrE
         fk2//Qua6wPVJxRBoDj6+6KdfGihjUqW7fmjGDQrn175GvVczPfx25SLzXmxv5Rqwx
         zkb1DlmPB2Pe2zSQGvNz4W3F7OdbFCEC0XfpqoSWbmlZ4OfqrrPnkX/nmBM6Gbi+yD
         E05K7zkx/NrscO8Ulm9BUq0N7s8iz0nrk/AYtRKlFPTAHtYOHWj/4ko8/JFZxUqhF1
         Z8waVUX4abURz4GLQW/2DqWS2RaRNppsNfbaOE4kwt30Q95Tss+28kVbiBFafwxFTW
         qRLnz8JcTY0wA==
X-CNFS-Analysis: v=2.4 cv=FqfAQ0nq c=1 sm=1 tr=0 ts=60187277 cx=a_exe
 a=tAq5w2qrEf5dL+VNPEPBHQ==:117 a=tAq5w2qrEf5dL+VNPEPBHQ==:17
 a=dfLDlhdaAAAA:20 a=VwQbUJbxAAAA:8 a=kT-NTsFwAAAA:8 a=EPUJG05OU6-sTYLwU_UA:9
 a=AjGcO6oz07-iQ99wixmX:22 a=TLwuWKmryFjkTYsgBL5T:22
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [RFC][PATCH V6] btrfs: allocation_hint mode
Date:   Mon,  1 Feb 2021 22:28:15 +0100
Message-Id: <20210201212820.64381-1-kreijack@libero.it>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFYKrWBstadXte6rQg6x4TKquP1wXXhoyYYM2AI7cSRXuTIpKOEM6dMF0M35KslNX9CHRb27wdGuhAxg+LNzrGNazimiOamvgWENsGVQQxRnL7gBwVNZ
 mPd9T6PL6syZ29P2NxRG0KHGaDfq4zDmSWZid8tJGoH9zNiasJrMEly4fW1vKzTvCRb6PDxjrbdTv56eMK3ELHk2k/t5QoKrTF5wUK2HvNZu3osD95O9vs2s
 Yx59lI5vbRUjJwM5RDk+okrw6maP4u7onxduWY3RM6s=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Hi all,

the previous V5 serie was called "btrfs: preferred_metadata: preferred device
for metadata".

This patches set was born after some discussion between me, Zygo and Josef.
Some details can be found in https://github.com/btrfs/btrfs-todo/issues/19.

Some further information about a real use case can be found in 
https://lore.kernel.org/linux-btrfs/20210116002533.GE31381@hungrycats.org/

The idea behind this patches set, is to dedicate some disks (the fastest one)
to the metadata chunk. My initial idea was a "soft" hint. However Zygo
asked an option for a "strong" hint (== mandatory). The result is that
each disk can be "tagged" by one of the following flags:
- BTRFS_DEV_ALLOCATION_METADATA_ONLY
- BTRFS_DEV_ALLOCATION_PREFERRED_METADATA
- BTRFS_DEV_ALLOCATION_PREFERRED_DATA
- BTRFS_DEV_ALLOCATION_DATA_ONLY

When the chunk allocator search a disks to allocate a chunk, scans the disks
in an order decided by these tags. For metadata, the order is:
*_METADATA_ONLY
*_PREFERRED_METADATA
*_PREFERRED_DATA

The *_DATA_ONLY are not eligible from metadata chunk allocation.

For the data chunk, the order is reversed, and the *_METADATA_ONLY are
excluded.

The exact sort logic is to sort first for the "tag", and then for the space
available. If there is no space available, the next "tag" disks set are
selected.

To set these tags, a new property called "allocation_hint" was created.
There is a dedicated btrfs-prog patches set [[PATCH V5] btrfs-progs:
allocation_hint disk property].

To enable this new allocation mode, the filesystem has to be mounted
each time using the option "allocation_hint=1". This option can be changed
on the fly using the "remount" mount option.

By default this mode is disabled. 

$ sudo mount -o allocation_hint=1 /dev/loop0 /mnt/test-btrfs/
$ for i in /dev/loop[0-9]; do sudo ./btrfs prop get $i allocation_hint; done
devid=1, path=/dev/loop0: allocation_hint=PREFERRED_METADATA
devid=2, path=/dev/loop1: allocation_hint=PREFERRED_METADATA
devid=3, path=/dev/loop2: allocation_hint=PREFERRED_DATA
devid=4, path=/dev/loop3: allocation_hint=PREFERRED_DATA
devid=5, path=/dev/loop4: allocation_hint=PREFERRED_DATA
devid=6, path=/dev/loop5: allocation_hint=DATA_ONLY
devid=7, path=/dev/loop6: allocation_hint=METADATA_ONLY
devid=8, path=/dev/loop7: allocation_hint=METADATA_ONLY

$ sudo ./btrfs fi us /mnt/test-btrfs/
Overall:
    Device size:		   2.75GiB
    Device allocated:		   1.34GiB
    Device unallocated:		   1.41GiB
    Device missing:		     0.00B
    Used:			 400.89MiB
    Free (estimated):		   1.04GiB	(min: 1.04GiB)
    Data ratio:			      2.00
    Metadata ratio:		      1.00
    Global reserve:		   3.25MiB	(used: 0.00B)
    Multiple profiles:		        no

Data,RAID1: Size:542.00MiB, Used:200.25MiB (36.95%)
   /dev/loop0	 288.00MiB
   /dev/loop1	 288.00MiB
   /dev/loop2	 127.00MiB
   /dev/loop3	 127.00MiB
   /dev/loop4	 127.00MiB
   /dev/loop5	 127.00MiB

Metadata,single: Size:256.00MiB, Used:384.00KiB (0.15%)
   /dev/loop1	 256.00MiB

System,single: Size:32.00MiB, Used:16.00KiB (0.05%)
   /dev/loop0	  32.00MiB

Unallocated:
   /dev/loop0	 704.00MiB
   /dev/loop1	 480.00MiB
   /dev/loop2	   1.00MiB
   /dev/loop3	   1.00MiB
   /dev/loop4	   1.00MiB
   /dev/loop5	   1.00MiB
   /dev/loop6	 128.00MiB
   /dev/loop7	 128.00MiB

# change the tag of some disks

$ sudo ./btrfs prop set /dev/loop0 allocation_hint DATA_ONLY
$ sudo ./btrfs prop set /dev/loop1 allocation_hint DATA_ONLY
$ sudo ./btrfs prop set /dev/loop5 allocation_hint METADATA_ONLY

$ for i in /dev/loop[0-9]; do sudo ./btrfs prop get $i allocation_hint; done
devid=1, path=/dev/loop0: allocation_hint=DATA_ONLY
devid=2, path=/dev/loop1: allocation_hint=DATA_ONLY
devid=3, path=/dev/loop2: allocation_hint=PREFERRED_DATA
devid=4, path=/dev/loop3: allocation_hint=PREFERRED_DATA
devid=5, path=/dev/loop4: allocation_hint=PREFERRED_DATA
devid=6, path=/dev/loop5: allocation_hint=METADATA_ONLY
devid=7, path=/dev/loop6: allocation_hint=METADATA_ONLY
devid=8, path=/dev/loop7: allocation_hint=METADATA_ONLY

$ sudo btrfs bal start --full-balance /mnt/test-btrfs/
$ sudo ./btrfs fi us /mnt/test-btrfs/
Overall:
    Device size:		   2.75GiB
    Device allocated:		 735.00MiB
    Device unallocated:		   2.03GiB
    Device missing:		     0.00B
    Used:			 400.72MiB
    Free (estimated):		   1.10GiB	(min: 1.10GiB)
    Data ratio:			      2.00
    Metadata ratio:		      1.00
    Global reserve:		   3.25MiB	(used: 0.00B)
    Multiple profiles:		        no

Data,RAID1: Size:288.00MiB, Used:200.19MiB (69.51%)
   /dev/loop0	 288.00MiB
   /dev/loop1	 288.00MiB

Metadata,single: Size:127.00MiB, Used:336.00KiB (0.26%)
   /dev/loop5	 127.00MiB

System,single: Size:32.00MiB, Used:16.00KiB (0.05%)
   /dev/loop7	  32.00MiB

Unallocated:
   /dev/loop0	 736.00MiB
   /dev/loop1	 736.00MiB
   /dev/loop2	 128.00MiB
   /dev/loop3	 128.00MiB
   /dev/loop4	 128.00MiB
   /dev/loop5	   1.00MiB
   /dev/loop6	 128.00MiB
   /dev/loop7	  96.00MiB


#As you can see all the metadata were placed on the disk loop5/loop7 even if
#the most empty one are loop0 and loop1.



TODO:
- more tests
- the tool which show the space available should consider the tagging (
  the disks tagged by _METADATA_ONLY should be excluded from the data
  availability)


Comments are welcome
BR
G.Baroncelli

--
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

