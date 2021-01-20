Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE582FD025
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 13:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389208AbhATMR6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 07:17:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:37900 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730542AbhATK11 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 05:27:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611138330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=frb+PZ9kVXij3jQDJdz1Vsnh2JU/aBbmJtXqrAEgPbQ=;
        b=nPMJGMhbMNtsHrflI/P1x/kPcfvDj4rs2kVUpux15DPMnxl5uyB622dOiuQcnb2hYv0lle
        o7kW+BXEfSIyVDifnV58aBbWf0WX69ej9zd+Cog8xzqsAA7QSSpJRndPtuqoI82bcWAOg2
        YcmALxQkIJ9Ztu5ZHZ1jM9xLJ6rVlOg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 41463B01F;
        Wed, 20 Jan 2021 10:25:30 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 10/14] btrfs: Fix parameter description of btrfs_inode_rsv_release/btrfs_delalloc_release_space
Date:   Wed, 20 Jan 2021 12:25:22 +0200
Message-Id: <20210120102526.310486-11-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120102526.310486-1-nborisov@suse.com>
References: <20210120102526.310486-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fixes following warnings:

fs/btrfs/delalloc-space.c:205: warning: Function parameter or member 'inode' not described in 'btrfs_inode_rsv_release'
fs/btrfs/delalloc-space.c:205: warning: Function parameter or member 'qgroup_free' not described in 'btrfs_inode_rsv_release'
fs/btrfs/delalloc-space.c:472: warning: Function parameter or member 'reserved' not described in 'btrfs_delalloc_release_space'
fs/btrfs/delalloc-space.c:472: warning: Function parameter or member 'qgroup_free' not described in 'btrfs_delalloc_release_space'
fs/btrfs/delalloc-space.c:472: warning: Excess function parameter 'release_bytes' description in 'btrfs_delalloc_release_space'

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/delalloc-space.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index bacee09b7bfd..c73e5131a2de 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -192,8 +192,8 @@ void btrfs_free_reserved_data_space(struct btrfs_inode *inode,
 
 /**
  * btrfs_inode_rsv_release - release any excessive reservation.
- * @inode - the inode we need to release from.
- * @qgroup_free - free or convert qgroup meta.
+ * @inode: the inode we need to release from.
+ * @qgroup_free: free or convert qgroup meta.
  *   Unlike normal operation, qgroup meta reservation needs to know if we are
  *   freeing qgroup reservation or just converting it into per-trans.  Normally
  *   @qgroup_free is true for error handling, and false for normal release.
@@ -457,9 +457,10 @@ int btrfs_delalloc_reserve_space(struct btrfs_inode *inode,
 /**
  * btrfs_delalloc_release_space - release data and metadata space for delalloc
  * @inode: inode we're releasing space for
+ * @reserved: list of changed/reserved ranges
  * @start: start position of the space already reserved
  * @len: the len of the space already reserved
- * @release_bytes: the len of the space we consumed or didn't use
+ * @qgroup_free: should qgroup reserved-space also be freed
  *
  * This function will release the metadata space that was not used and will
  * decrement ->delalloc_bytes and remove it from the fs_info delalloc_inodes
-- 
2.25.1

