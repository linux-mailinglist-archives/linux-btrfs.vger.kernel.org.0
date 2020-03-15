Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A68A185E36
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Mar 2020 16:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgCOPcl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 Mar 2020 11:32:41 -0400
Received: from smtp-16-i2.italiaonline.it ([213.209.12.16]:41983 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726501AbgCOPcl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Mar 2020 11:32:41 -0400
X-Greylist: delayed 477 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Mar 2020 11:32:31 EDT
Received: from venice.bhome ([84.220.24.82])
        by smtp-16.iol.local with ESMTPA
        id DV7vj4MthjfNYDV7wjCbpR; Sun, 15 Mar 2020 16:24:32 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1584285872; bh=r9xBVawPbar5BU7gHLU3v7QOTt6SIJqQTBt7MyZFsc4=;
        h=From:To:Subject:Date;
        b=nA40wlfv+OLRn96m6Oh+lvrFc8gr3umvWVzVTAmYCOpOSasVYHNHEtL6srMP07K2I
         WzlPZrWfZM9p1k7Rti7CAIOElxUPb9whnKzAxM0QxNbIxCQje0GoigSPastfnMTyWp
         A685gTTRFPzQKkXZyZX5Q06qf0LJqXoWVIZE90z7Xlyik60GoC7ndVxhZ4N6SjS1yC
         ZimUym9961r3uPFMXS1cTJiWtIksbryYXZ3IBf4QeUrlGqXeavlfBrmg8ktLaYMuM1
         22inzA+GcUJr1159zcvkzbq5CVLKKOCfRrnYCwUfxM8UzEXNYql0SLRXMPvsLr2Oo8
         zvK4qfv3s1pkA==
X-CNFS-Analysis: v=2.3 cv=BYemLYl2 c=1 sm=1 tr=0
 a=ijacSk0KxWtIQ5WY4X6b5g==:117 a=ijacSk0KxWtIQ5WY4X6b5g==:17
 a=bKyAHLF-biHPe4QFXIQA:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Subject: [RFC] btrfs-progs: use the new ioctl BTRFS_IOC_GET_CHUNK_INFO
Date:   Sun, 15 Mar 2020 16:24:27 +0100
Message-Id: <20200315152430.7532-1-kreijack@libero.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfKeuC/zBMoiSUPj6vKAcEqpN98nRdSfcvkr9W7omw91sQbYuyvGGIkHAn9VgnTVZXXPuMGBIHFLvLNwQZ5IVvoCnMW7AYn57rrfajnvPlymCK7jC05wm
 KZUPI7v/C+2eieBxLOuudwhBNxJEE4ls0eS6ljJ4i3SSk5g1h5ybmvN5h+s0/FnXDQwV52Zoq/1cSEjcGCZQLy+7uAXrcf34Qj4=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Hi,

this is a repost of an old patch (~2017). At the time it din't received
any feedback. I repost it hoping that it still be interested.

This patch set is the btrfs-prog related one; another one related to the
kernel is send separately.

This patch set createa a new ioctl BTRFS_IOC_GET_CHUNK_INFO.
The aim is to replace the BTRFS_IOC_TREE_SEARCH ioctl
used by "btrfs fi usage" to obtain information about the 
chunks/block groups. 

The problems in using the BTRFS_IOC_TREE_SEARCH is that it access
the very low data structure of BTRFS. This means: 
1) this would be complicated a possible change of the disk format
2) it requires the root privileges

The BTRFS_IOC_GET_CHUNK_INFO ioctl can be called even from a not root
user: I think that the data exposed are not sensibile data.

These patches allow to use "btrfs fi usage" without root privileges.

before:
-------------------------------------------

$ btrfs fi us /
WARNING: cannot read detailed chunk info, per-device usage will not be shown, run as root
Overall:
    Device size:		 100.00GiB
    Device allocated:		  26.03GiB
    Device unallocated:		  73.97GiB
    Device missing:		     0.00B
    Used:			  17.12GiB
    Free (estimated):		  80.42GiB	(min: 80.42GiB)
    Data ratio:			      1.00
    Metadata ratio:		      1.00
    Global reserve:		  53.12MiB	(used: 0.00B)

Data,single: Size:23.00GiB, Used:16.54GiB (71.93%)

Metadata,single: Size:3.00GiB, Used:588.94MiB (19.17%)

System,single: Size:32.00MiB, Used:16.00KiB (0.05%)

after:
-----------------------------------------------
$ ./btrfs fi us /
Overall:
    Device size:		 100.00GiB
    Device allocated:		  26.03GiB
    Device unallocated:		  73.97GiB
    Device missing:		     0.00B
    Used:			  17.12GiB
    Free (estimated):		  80.42GiB	(min: 80.42GiB)
    Data ratio:			      1.00
    Metadata ratio:		      1.00
    Global reserve:		  53.12MiB	(used: 0.00B)

Data,single: Size:23.00GiB, Used:16.54GiB (71.93%)
   /dev/sdd3	  23.00GiB

Metadata,single: Size:3.00GiB, Used:588.94MiB (19.17%)
   /dev/sdd3	   3.00GiB

System,single: Size:32.00MiB, Used:16.00KiB (0.05%)
   /dev/sdd3	  32.00MiB

Unallocated:
   /dev/sdd3	  73.97GiB

Comments are welcome
BR
G.Baroncelli


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5




