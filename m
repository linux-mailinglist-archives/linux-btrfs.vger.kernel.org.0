Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F392A2D48
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 15:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgKBOtJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 09:49:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:39732 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbgKBOtJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Nov 2020 09:49:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604328548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UiJ6bkmNA67Oapbu1ZengFDsOA3y7IoIhilFmvzaUF0=;
        b=Sf6Km9IMPZFyTlca8N2sXGFOlnEXu/fVgu/E+d++Ue2ihBvU9u+SQtlD5zGTWfjPGYP+9E
        45q6TgI2UAFdSdITrhOCmxey/fH9kI0J8vKBTPQz7P/0a3+eiVZ0KHPva6FKkjwLRQWcBq
        0IwErgYgCdqeqeoeelGWb2JYZpbb0RA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2475CAE61;
        Mon,  2 Nov 2020 14:49:08 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 00/14] Another batch of inode vs btrfs_inode cleanups
Date:   Mon,  2 Nov 2020 16:48:52 +0200
Message-Id: <20201102144906.3767963-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here is another batch which  gets use closer to unified btrfs_inode vs inode
usage in functions.

Nikolay Borisov (14):
  btrfs: Make btrfs_inode_safe_disk_i_size_write take btrfs_inode
  btrfs: Make insert_prealloc_file_extent take btrfs_inode
  btrfs: Make btrfs_truncate_inode_items take btrfs_inode
  btrfs: Make btrfs_finish_ordered_io btrfs_inode-centric
  btrfs: Make btrfs_delayed_update_inode take btrfs_inode
  btrfs: Make btrfs_update_inode_item take btrfs_inode
  btrfs: Make btrfs_update_inode take btrfs_inode
  btrfs: Make maybe_insert_hole take btrfs_inode
  btrfs: Make find_first_non_hole take btrfs_inode
  btrfs: Make btrfs_insert_replace_extent take btrfs_inode
  btrfs: Make btrfs_truncate_block take btrfs_inode
  btrfs: Make btrfs_cont_expand take btrfs_inode
  btrfs: Make btrfs_drop_extents take btrfs_inode
  btrfs: Make btrfs_update_inode_fallback take btrfs_inode

 fs/btrfs/block-group.c      |   2 +-
 fs/btrfs/ctree.h            |  21 +--
 fs/btrfs/delayed-inode.c    |  13 +-
 fs/btrfs/delayed-inode.h    |   3 +-
 fs/btrfs/file-item.c        |  18 +--
 fs/btrfs/file.c             |  88 +++++++------
 fs/btrfs/free-space-cache.c |   8 +-
 fs/btrfs/inode-map.c        |   2 +-
 fs/btrfs/inode.c            | 249 ++++++++++++++++++------------------
 fs/btrfs/ioctl.c            |   6 +-
 fs/btrfs/reflink.c          |   9 +-
 fs/btrfs/transaction.c      |   3 +-
 fs/btrfs/tree-log.c         |  24 ++--
 fs/btrfs/xattr.c            |   4 +-
 14 files changed, 233 insertions(+), 217 deletions(-)

--
2.25.1

