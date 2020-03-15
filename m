Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BECC9185E34
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Mar 2020 16:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbgCOPcc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 Mar 2020 11:32:32 -0400
Received: from smtp-16-i2.italiaonline.it ([213.209.12.16]:41983 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726501AbgCOPcc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Mar 2020 11:32:32 -0400
X-Greylist: delayed 477 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Mar 2020 11:32:31 EDT
Received: from venice.bhome ([84.220.24.82])
        by smtp-16.iol.local with ESMTPA
        id DV7lj4MqSjfNYDV7ljCbne; Sun, 15 Mar 2020 16:24:22 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1584285862; bh=pSyVETGFWQLmhrvL/nwOyf1holAIkOmAbqScgDxpJLc=;
        h=From:To:Subject:Date;
        b=RidoePZPghYSlce/Otoh7cK5h1WnlX2lG83592M4Q3WPqvcnMbUKCdOGtpk75ZGgG
         gLU1sMK5LFY4nz6Y+eFhLQjsORMHUAyz9fESiZkxJE19fxHDbcrpHocR3HRH9iTdTf
         nWvOu7tbbJU6Pdc5LV3iB1Ew89mTsaknHUEQ7qr+Y1V0rlVvmCgA9cKZkojhXlppxQ
         XrPggKZMeaJGZAMR60rQBICGertmX6k3xFjDHu83v2cIVGFDIGkoPAtPIDo61Ia6Ov
         0ADtFIJptMr24tvYO1ryP8X+uyMETOCzV3qckPvzMvpN4KW44MoEM1ee8tvxPDGw12
         7saYKlfDlWWgw==
X-CNFS-Analysis: v=2.3 cv=BYemLYl2 c=1 sm=1 tr=0
 a=ijacSk0KxWtIQ5WY4X6b5g==:117 a=ijacSk0KxWtIQ5WY4X6b5g==:17
 a=bKyAHLF-biHPe4QFXIQA:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Subject: [RFC] new ioctl BTRFS_IOC_GET_CHUNK_INFO
Date:   Sun, 15 Mar 2020 16:24:17 +0100
Message-Id: <20200315152418.7784-1-kreijack@libero.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfOmr431hnNfw2d4Mp+/zDV2+OjHLiih1/fGC8se8wcCU4zSTGtx33NwK7tsPnHoIyuDpQTWeMKW609Y3GXqVAwi3chVyWfSPc9Ho2G+UyoQfsXgAzACp
 XJ2LXjhbP7zI04XBJoRctjZkzmk18WllJ5Lfjp1dbxid2bKXYxj45v0MG3vcxXK6psH4rOjnq5rVV3vfSHmfJ/LUO9okgAlLbeE=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


This is a repost of an old patch (~2017). At the time it din't received
any feedback. I repost it hoping that it still be interesting.

This patch is the kernel related one; another one related to the
btrfs-progs is send separately.

This patch set creates a new ioctl BTRFS_IOC_GET_CHUNK_INFO.
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
    Device size:                 100.00GiB
    Device allocated:             26.03GiB
    Device unallocated:           73.97GiB
    Device missing:                  0.00B
    Used:                         17.12GiB
    Free (estimated):             80.42GiB      (min: 80.42GiB)
    Data ratio:                       1.00
    Metadata ratio:                   1.00
    Global reserve:               53.12MiB      (used: 0.00B)

Data,single: Size:23.00GiB, Used:16.54GiB (71.93%)

Metadata,single: Size:3.00GiB, Used:588.94MiB (19.17%)

System,single: Size:32.00MiB, Used:16.00KiB (0.05%)

after:
-----------------------------------------------
$ ./btrfs fi us /
Overall:
    Device size:                 100.00GiB
    Device allocated:             26.03GiB
    Device unallocated:           73.97GiB
    Device missing:                  0.00B
    Used:                         17.12GiB
    Free (estimated):             80.42GiB      (min: 80.42GiB)
    Data ratio:                       1.00
    Metadata ratio:                   1.00
    Global reserve:               53.12MiB      (used: 0.00B)

Data,single: Size:23.00GiB, Used:16.54GiB (71.93%)
   /dev/sdd3      23.00GiB

Metadata,single: Size:3.00GiB, Used:588.94MiB (19.17%)
   /dev/sdd3       3.00GiB

System,single: Size:32.00MiB, Used:16.00KiB (0.05%)
   /dev/sdd3      32.00MiB

Unallocated:
   /dev/sdd3      73.97GiB

Comments are welcome
BR
G.Baroncelli


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


