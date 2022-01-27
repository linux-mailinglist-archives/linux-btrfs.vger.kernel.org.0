Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109ED49EB6A
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jan 2022 20:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343496AbiA0T5T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jan 2022 14:57:19 -0500
Received: from santino.mail.tiscali.it ([213.205.33.245]:54784 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234826AbiA0T5R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jan 2022 14:57:17 -0500
Received: from venice.bhome ([78.14.151.50])
        by santino.mail.tiscali.it with 
        id nvxE2600k15VSme01vxEpG; Thu, 27 Jan 2022 19:57:16 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: -100
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From:   Goffredo Baroncelli <kreijack@tiscali.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 0/3][RFC] btrfs-progs: get/set allocation_hint for an unmounted filesystem
Date:   Thu, 27 Jan 2022 20:57:06 +0100
Message-Id: <cover.1643313144.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.34.1
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1643313436; bh=cGM/kejF59IypAO1fSNtnjKoK/tTY4vZmcGmkPzChuc=;
        h=From:To:Cc:Subject:Date:Reply-To;
        b=qzVGkR/ikpH51RtUDpcu53Xh1u4E17jJN7kUKn7uT7UpbJd+xjAjmBfRZa49vGJbG
         Xcx4BcxZEAPtXxqJAsNnI/g/UHq95HBOsPt9iyPD0stiFnwbQHf3O0lgSajzVSkR/H
         0+Bg1pGz2ERenP+pSXsiJwOJ8ydTA1E6ZTkHziW8=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

This patches set allows to change the allocation_hint even for an unmounted
filesystem.  It does that using the user space btrfs code.

Because the userspace btrfs code is unaware of the allocation_hint 
if a new (metadata) chunk allocation is required during the changing of
this property, the new chunk is allocated without considering the
allocation_hint ... hint.


Goffredo Baroncelli (3):
  Rename btrfs_device->type to flags
  Rename dev_item.type in flags in the command output.
  Read/change the allocation_hint prop when unmounted

 cmds/property.c             | 115 ++++++++++++++++++++++++++++++++++++
 cmds/rescue-chunk-recover.c |   2 +-
 common/device-scan.c        |   4 +-
 convert/common.c            |   2 +-
 image/main.c                |   6 +-
 kernel-shared/ctree.h       |   8 +--
 kernel-shared/disk-io.c     |   2 +-
 kernel-shared/print-tree.c  |   8 +--
 kernel-shared/volumes.c     |   6 +-
 kernel-shared/volumes.h     |   4 +-
 mkfs/common.c               |   2 +-
 11 files changed, 137 insertions(+), 22 deletions(-)

-- 
2.34.1

