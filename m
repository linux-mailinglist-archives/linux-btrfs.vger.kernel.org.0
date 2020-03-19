Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4F6418C18D
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 21:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbgCSUja (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 16:39:30 -0400
Received: from smtp-16.italiaonline.it ([213.209.10.16]:55237 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727095AbgCSUja (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 16:39:30 -0400
Received: from venice.bhome ([84.220.24.82])
        by smtp-16.iol.local with ESMTPA
        id F1wsjltlljfNYF1wtjhZ9F; Thu, 19 Mar 2020 21:39:27 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1584650367; bh=+Jw4Llw+6aSoVJsBwP1YhxHjJT0PqUSXBaRi5DviaJ4=;
        h=From;
        b=uRUhQuYhibTs47ZgPLd4WXM87Gc4GPZwuXkdKBWIURItTjgzktPXzUxKxuUdevpNV
         S4YNiwgUwNubN574WHaI3PaMpeuibsdPcgCPInB1FV844jkjgQvZbLkJflQkH5J4Ym
         9TfvvXwHZEzEPuy0pstCC86u2tVoW8TA/87QlzB33CuznKtnbb3LGmD+AMcrrBh9kv
         F5bTodgv6ixY2gFnUJpApCkc0ljwsvuXblEEIiSz2qMnmii/XRtX/OQRWBrhUgnrWR
         y6utCrZImk4lfxNOPSk7+43m6kOZbDcc7Hq3jJjjYR8N/YxdZKQpCxINKKtmBl5gbt
         3Nvkm5kvlX7kg==
X-CNFS-Analysis: v=2.3 cv=IdH5plia c=1 sm=1 tr=0
 a=ijacSk0KxWtIQ5WY4X6b5g==:117 a=ijacSk0KxWtIQ5WY4X6b5g==:17
 a=T1KYyEI1q8gI7QELBr0A:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH RFC V3] new ioctl BTRFS_IOC_GET_CHUNK_INFO
Date:   Thu, 19 Mar 2020 21:39:12 +0100
Message-Id: <20200319203913.3103-1-kreijack@libero.it>
X-Mailer: git-send-email 2.26.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfP6Dkv1tdDxES8nKEqlWrkYgg0piWpakYdQ9WmSX0QyfUPLS50/2wQ4n/SkR6LVI3h0wuZ/yy9UQ4FgIUNjRWwEGe9Pkq/qqfk0Vb9vBggEKgOboWDYu
 cqLMaY5yZJ9r0BmzmJirFqBqVzX2QUJe4tifVQLtGUKqO8C6mPGsCdl8W7WzUAGkaOwspu4+U7+D0nbn9MqXMSA22+Vb/2OA1Yk=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



This patch is the kernel related one; another one related to the
btrfs-progs is sent separately.

v3:
  - Replace btrfs_read_fs_root_no_name() with btrfs_get_fs_root()
  - Set a value for a uninitialized variable
  - correct the return value for copy_chunk_info()
v2: 
  - Remove the goto from copy_chunk_info()
V1: 
  - First issue

----

This patch creates a new ioctl BTRFS_IOC_GET_CHUNK_INFO.
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




.

