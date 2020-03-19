Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D69D718BF02
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 19:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbgCSSFf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 14:05:35 -0400
Received: from smtp-16.italiaonline.it ([213.209.10.16]:45944 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727082AbgCSSFe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 14:05:34 -0400
Received: from venice.bhome ([84.220.24.82])
        by smtp-16.iol.local with ESMTPA
        id EzXvjkvXMjfNYEzXvjgohn; Thu, 19 Mar 2020 19:05:31 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1584641132; bh=CeSBpmJDJ2ksfsirA0KdlhYJkWfe8cKq4N5LiFH64FQ=;
        h=From;
        b=ft/clRqGu+eW1DSNJGHBdx34I4jaJx1Zj2dKpYznoDUvCbbXJBFIJtIywdvGEYVs6
         5NzpLneZKmGprRZL8o3iUWZys3xOKXiMvWEtbsK2rORY2L4HELI9sd+6NxUsMCGl40
         gpZLnsul5jpJURJuJWp6j+gYgl3Z6hXjmHk6F20Ha1zQmyiqnpVtZ/mX1/ioLYNCTi
         NCd3Cr1ocWl2SigquS3r8sjH164Cp5WnW4xaa2A18L59agggJ/4lq9o3dAomiM6/Nb
         tsxUM9WIPnJ6oSSmS/8cyrSDyW9wBkfeQ8NdeP8iEm1Xmza4AaRo5HggDNn5dRyR5g
         ND0qat+vnyARQ==
X-CNFS-Analysis: v=2.3 cv=IdH5plia c=1 sm=1 tr=0
 a=ijacSk0KxWtIQ5WY4X6b5g==:117 a=ijacSk0KxWtIQ5WY4X6b5g==:17
 a=bKyAHLF-biHPe4QFXIQA:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH RFC V2] new ioctl BTRFS_IOC_GET_CHUNK_INFO
Date:   Thu, 19 Mar 2020 19:05:26 +0100
Message-Id: <20200319180527.4266-1-kreijack@libero.it>
X-Mailer: git-send-email 2.26.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfCclRO+vlnVgQOBH3TN9/1ykJReYJyeL+Iz/VeFxA5DYEmTPJh0rghIaHTlxM6rInyS/qwi2Evxe8fMvPfa6G/V4HJAd7a+1tumbthBYQwZ5EOIpIKgX
 Q99fFLhj7nOkzF/5d1fbQuxfoh6PBkKCOZMaUCjJMe6+vmupe+EFMyfaxVuLGyljS3cCK7jwxOIf8k8T801DeqyyfZ4Xh7gfKc0=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


This is a repost of an old patch (~2017). At the time it din't received
any feedback. I repost it hoping that it still be interesting.

This patch is the kernel related one; another one related to the
btrfs-progs is send separately.

v2: 
  - Remove the goto from copy_chunk_info()
V1: 
  - First issue

----

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




