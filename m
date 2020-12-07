Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A66B02D14C7
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 16:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgLGPd1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 10:33:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:45580 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgLGPd1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Dec 2020 10:33:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607355161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ktVWi8JVsTw4dCHJj921EkOhV3qyr1TCmSYGwj+nBEY=;
        b=vV89ms5QIKH6s8mNkt6DeOvOE1OzjGj6ui1KilSK/GSePbcmIrEL+8QBWTCe6NOxY33kw+
        Xz/52bK2vAhIbhBBtxBPvdkgfyPTtFdUn7slUmSCf6CN0pUUIcZ51sgmmPv/FH6jSpQa+N
        yP6CAEU2zw57scLStEmzavps3aDYK4s=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DB1DBAB63;
        Mon,  7 Dec 2020 15:32:40 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 0/6] Overhaul free objectid code
Date:   Mon,  7 Dec 2020 17:32:31 +0200
Message-Id: <20201207153237.1073887-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series aims to make the free objectid code more straighforward. Currently
the highest used objectid is used which implies that when btrfs_get_free_objectid
is called the pre-increment operator is used. At the same time when looking
at how highest_objectid is initialised in find_free_objectid it's using the,
at first looko unusual, 'BTRFS_FREE_OBJECTID - 1'. Furthermore btrfs_find_free_objectid
is badly named as it's used only in initializaion context.

With the series applied the following is achieved:
 * The 2 functions related to free objectid have better naming which describes
 their semantic meaning.

 * highest_objectid is renamed to free_objectid which clearly states what it's
 supposed to hold, also btrfs_get_free_objectid now returns the value and
 does a post-increment which seems more logical than the previous cod.

 * Now it's not necessary to re-initialize free_objectid in create_subvol
 since that member is now consistently initialized when a given root is read
 for the first time in btrfs_init_fs_root->btrfs_init_root_free_objectid.
 Additionally in btrfs_init_root_free_objectid free_objectid is now initialized
 to BTRFS_FIRST_FREE_OBJECTID so it's self-explanatory.

This series survived xfstest as well as a new xfstest which verifies precisely
this functionality.


Nikolay Borisov (6):
  btrfs: Rename btrfs_find_highest_objectid to
    btrfs_init_root_free_objectid
  btrfs: Rename btrfs_find_free_objectid to btrfs_get_free_objectid
  btrfs: Remove useless ASSERTS
  btrfs: Rename highest_objectid to free_objectid
  btrfs: Make free_objectid hold the next available objectid in the root
  btrfs: Remove new_dirid argument from btrfs_create_subvol_root

 fs/btrfs/ctree.h            |  5 ++---
 fs/btrfs/disk-io.c          | 25 ++++++++++---------------
 fs/btrfs/disk-io.h          |  4 ++--
 fs/btrfs/free-space-cache.c |  2 +-
 fs/btrfs/inode.c            | 23 +++++++++++++----------
 fs/btrfs/ioctl.c            | 11 +++--------
 fs/btrfs/relocation.c       |  2 +-
 fs/btrfs/transaction.c      |  2 +-
 fs/btrfs/tree-log.c         |  3 +--
 9 files changed, 34 insertions(+), 43 deletions(-)

--
2.25.1

