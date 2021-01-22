Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA602FFFB2
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 11:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbhAVKBl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 05:01:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:58386 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbhAVKAo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 05:00:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611309489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=obVTR/iajbTHptudWZFYKehs+SdWkAKFztadESKI2VM=;
        b=iRO0k8Eds78RDm3QqGGt2QvLif/gdL18SpLBu2HSp0yF2u8IAJLoT/uLHoFL4IQcXR+jw3
        KuEIKOcbIeGLTEy99k5d1L7coUtNY4zb8wxEElPt0ENeBfNzWhopxcOD1ahHOv/QtWK/gI
        NW1VjWpaCZOy2Xtbd8n9hEBmn10E+MQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 47701B7DD;
        Fri, 22 Jan 2021 09:58:09 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 10/14] btrfs: Fix parameter description of btrfs_inode_rsv_release/btrfs_delalloc_release_space
Date:   Fri, 22 Jan 2021 11:58:01 +0200
Message-Id: <20210122095805.620458-11-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210122095805.620458-1-nborisov@suse.com>
References: <20210122095805.620458-1-nborisov@suse.com>
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
 fs/btrfs/delalloc-space.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index bacee09b7bfd..35f25a3d897b 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -191,12 +191,14 @@ void btrfs_free_reserved_data_space(struct btrfs_inode *inode,
 }
 
 /**
- * btrfs_inode_rsv_release - release any excessive reservation.
- * @inode - the inode we need to release from.
- * @qgroup_free - free or convert qgroup meta.
- *   Unlike normal operation, qgroup meta reservation needs to know if we are
- *   freeing qgroup reservation or just converting it into per-trans.  Normally
- *   @qgroup_free is true for error handling, and false for normal release.
+ * Release any excessive reservation.
+ *
+ * @inode:       the inode we need to release from.
+ * @qgroup_free: free or convert qgroup meta. Unlike normal operation, qgroup
+ *               meta reservation needs to know if we are freeing qgroup
+ *               reservation or just converting it into per-trans.  Normally
+ *               @qgroup_free is true for error handling, and false for normal
+ *               release.
  *
  * This is the same as btrfs_block_rsv_release, except that it handles the
  * tracepoint for the reservation.
@@ -361,7 +363,8 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
 }
 
 /**
- * btrfs_delalloc_release_metadata - release a metadata reservation for an inode
+ * Release a metadata reservation for an inode
+ *
  * @inode: the inode to release the reservation for.
  * @num_bytes: the number of bytes we are releasing.
  * @qgroup_free: free qgroup reservation or convert it to per-trans reservation
@@ -455,11 +458,13 @@ int btrfs_delalloc_reserve_space(struct btrfs_inode *inode,
 }
 
 /**
- * btrfs_delalloc_release_space - release data and metadata space for delalloc
- * @inode: inode we're releasing space for
- * @start: start position of the space already reserved
- * @len: the len of the space already reserved
- * @release_bytes: the len of the space we consumed or didn't use
+ * Release data and metadata space for delalloc
+ *
+ * @inode:       inode we're releasing space for
+ * @reserved:    list of changed/reserved ranges
+ * @start:       start position of the space already reserved
+ * @len:         the len of the space already reserved
+ * @qgroup_free: should qgroup reserved-space also be freed
  *
  * This function will release the metadata space that was not used and will
  * decrement ->delalloc_bytes and remove it from the fs_info delalloc_inodes
-- 
2.25.1

