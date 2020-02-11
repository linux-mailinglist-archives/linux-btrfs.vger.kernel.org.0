Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A75C8159292
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 16:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbgBKPKd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 10:10:33 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:35881 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgBKPKc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 10:10:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581433832; x=1612969832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9p9CwSeXupNCM9jnIYnpHRH38xmM1qzKlKT+fZwFin0=;
  b=Xyr73yqVt2aeBVHQirrfwmSz4Jqpr8rxWXrv/fYTz6ekXHDrBZbSJVll
   59S8zX7hWkq4TyeXJLsP2c6Hq1pXBa4el61m5l4vMa3pb67NvmaM255nB
   8fXEkqgqohtSSHGfrrJRv+nH4aV/Q32vDmWqeNWIe8YLULeQKcXW5FIg7
   vSrvnnGYQELFMYLw2LZDJl1+WYR5dLG6grB/5QU1zMrR7t/VDy/eELZLy
   wd7rxbapoaJY///vhwVDztHUXiz4JhPe+l5NjN/VTwLk8Q46GMyrn4CtV
   vd7FkK/s1p0N/r5Du3gsKcnpymPv/gpSKqb+Z5qQBp3AD8kQovWjB6ctc
   g==;
IronPort-SDR: tuRVEocHvP5jZd3WlkVsH7I3hv2TBWSU5cEfE7ycltLmy9ejQzRIE8bJUD6p0QMDDqWRhNnnIs
 xqgPS07EUT/MJ6w5wtPr00/iWbqYKX+29JlpEpbY4olTGKXN6GGW94OIC/je1lE2O5EeLMAljg
 BvUFgS2QsNmUY0ICpbXPlIPCX0jgJxH7un4xv2H7qYBx2OwxgNWeRP76tVkh/YmG4g3c6xJqmP
 be01nhV2Qdlu8SU2Mt9EqT4+2r4PipJJ/0oRppvkZmNjAB+6yXlbQznSlJb4Mo4A2pOqSXL+zP
 QKQ=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="130128674"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Feb 2020 23:10:31 +0800
IronPort-SDR: PlsP1Efigm9bG8r9MZIJ35EoAwY377jU+qkFj7I1N/X/qoRP7FF2p93geVyfmIkdhS+0kh0IuR
 Pi/t+PtzkEGjZ0IKIZzeaf2GwVXmDL12pMk4J4ODflEpTdXQfY2kNn08eNMFA75GrrRSZM35x/
 2O4tV3YpKNXibp7tpIwyrI0ZfANJiJcTIEh0v8Czzr3caoP+8XYNHuzAZQJhQzFQw8wmcYfvf1
 Buot7yOPKCkK3KfS4ryXmndvo0nm7ILkiT8Zp7RB9Yl2ozK449549AKLNSoRFIxJATl4SOOmZ8
 XTxqfs874zyI1kVR2u/RFVng
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 07:03:21 -0800
IronPort-SDR: /NmXw4YTjp33R5lxb255jeVkneqolJSZJ9qtM4pmVilUbG5EJvCnouICRMiotDhCWXT4blN4Q7
 F9/tfhsxdlduoJ0InXRuS7IrmT/TXvwRGhURY91EvUZYeIeIJC/vYMBfyBB+Evb2Q0g+tjZOi0
 q0aY3ln5kApv7W7+BcJyFttB2/W/CeB0jxacDSng8Jc0G8rfKfOfVSAG1qFY1EbqRKBosJ9Dh9
 p39b6EAvxQxP5pOkQJQH85h5kiW0oQFyJ6HorMhR84aJkBunWae70BW8IWZar96Ebotr84cuDQ
 jsQ=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Feb 2020 07:10:31 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 3/5] btrfs: use standard debug config option to enable free-space-cache debug prints
Date:   Wed, 12 Feb 2020 00:10:21 +0900
Message-Id: <20200211151023.16060-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200211151023.16060-1-johannes.thumshirn@wdc.com>
References: <20200211151023.16060-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

free-space-cache.c has it's own set of DEBUG ifdefs which need to be
turned on instead of the global CONFIG_BTRFS_DEBUG to print debug messages
about failed block-group writes.

Switch this over to CONFIG_BTRFS_DEBUG so we always see these messages
when running a debug kernel.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/free-space-cache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 98f547e87bb4..7d6d6aa7b7d6 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1190,7 +1190,7 @@ static int __btrfs_wait_cache_io(struct btrfs_root *root,
 		invalidate_inode_pages2(inode->i_mapping);
 		BTRFS_I(inode)->generation = 0;
 		if (block_group) {
-#ifdef DEBUG
+#ifdef CONFIG_BTRFS_DEBUG
 			btrfs_err(root->fs_info,
 				  "failed to write free space cache for block group %llu",
 				  block_group->start);
@@ -1416,7 +1416,7 @@ int btrfs_write_out_cache(struct btrfs_trans_handle *trans,
 	ret = __btrfs_write_out_cache(fs_info->tree_root, inode, ctl,
 				block_group, &block_group->io_ctl, trans);
 	if (ret) {
-#ifdef DEBUG
+#ifdef CONFIG_BTRFS_DEBUG
 		btrfs_err(fs_info,
 			  "failed to write free space cache for block group %llu",
 			  block_group->start);
@@ -4036,7 +4036,7 @@ int btrfs_write_out_ino_cache(struct btrfs_root *root,
 		if (release_metadata)
 			btrfs_delalloc_release_metadata(BTRFS_I(inode),
 					inode->i_size, true);
-#ifdef DEBUG
+#ifdef CONFIG_BTRFS_DEBUG
 		btrfs_err(fs_info,
 			  "failed to write free ino cache for root %llu",
 			  root->root_key.objectid);
-- 
2.16.4

