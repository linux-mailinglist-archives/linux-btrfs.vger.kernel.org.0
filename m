Return-Path: <linux-btrfs+bounces-13080-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBD2A90678
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 16:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAD66189B96A
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 14:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862F51EE032;
	Wed, 16 Apr 2025 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JONb/SR5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A835C1DA2E5
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 14:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813718; cv=none; b=p1ZZsDkUrglH8lvDmwNcx99LtMIuQ/1snwJMLbcJeOCdECEaZHvkG2gFZOHlSMKVrAJcjLoxRPrHn99HBZbC9MKyTwtWMN0yuwJwWz6xuH4qOuYFalBrA/Q4cxjGTzbfMjvbzjhMVOCBzjg88jnCX8l06WE8Eoqt7GtisB9dTwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813718; c=relaxed/simple;
	bh=SzSGoxamWDY402w6GyCgok8UEOwwuH7LjcUAxc9lxTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lfaZshHL6S7ktSLeC3kNTMHBwCocJEn0l3MYDN1oKWcrqrgGgCrC2V4u8UG/1klNrUmZd2p5WH0PLK7xArFnD53D9S00zqDp8EY37FH7G+n6ilaUBFkog7KrAkpdgWmN1sLyZpCs3h8iMkdxu7y+/BHEMftu1WVbS1+2jzOr1rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JONb/SR5; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744813715; x=1776349715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SzSGoxamWDY402w6GyCgok8UEOwwuH7LjcUAxc9lxTo=;
  b=JONb/SR5pcy9SWRiBHXWypSM01gVIAwpCZa2tUqwgROD5nov97340104
   eiMtIX+EjHFNETguNKwllvXhCe6lwbt5trDKaX7SWP7IYaYKHlpILyamg
   Hyn9lAUgrCPj0rVIkZHscXnsFLhJzwmSON82l8nFL5yF/BgbZNaJPRHbG
   ydyjXDmiWQLHHUJlYtco/8+TmtgAFf4HVZtw/6yyLya6CXYgCaK9D7v82
   s/enGXYFJGWCweCNyDvyIumROke0Ok1R57AZFaFl7txJMcBB44GALYMbF
   sz7lb+3ZorU5RN2IuvkiSjARpjywoIULjE8gqUmp6eyRgy6tcZ5x7rKis
   A==;
X-CSE-ConnectionGUID: 5nriC3SRRYmQzxxo9a9fEQ==
X-CSE-MsgGUID: flx/9Bb5RZWPDXme/el07w==
X-IronPort-AV: E=Sophos;i="6.15,216,1739808000"; 
   d="scan'208";a="81484519"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2025 22:28:28 +0800
IronPort-SDR: 67ffb07e_4w+u/dNRTh0/wAIgZNfbf0EIFeIn6XQrDh72XH2FekwyXre
 aOvl9OM0pH24oS+xlr3A0jmQO8Agm4XUIGtmF+Q==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2025 06:28:31 -0700
WDCIronportException: Internal
Received: from 5cg2075gjp.ad.shared (HELO naota-xeon..) ([10.224.104.89])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Apr 2025 07:28:27 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 02/13] btrfs: take struct btrfs_inode in btrfs_free_reserved_data_space_noquota
Date: Wed, 16 Apr 2025 23:28:07 +0900
Message-ID: <a41a96db95c25fd695a3fc576998169922209778.1744813603.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744813603.git.naohiro.aota@wdc.com>
References: <cover.1744813603.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As well as the last patch, take struct btrfs_inode in the function and let
it distinguish which data space it is working on in a later patch. There is
no functional change with this commit.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/delalloc-space.c | 7 ++++---
 fs/btrfs/delalloc-space.h | 3 +--
 fs/btrfs/inode.c          | 4 ++--
 fs/btrfs/relocation.c     | 3 +--
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index c7181779b013..a18895255af9 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -151,7 +151,7 @@ int btrfs_check_data_free_space(struct btrfs_inode *inode,
 	/* Use new btrfs_qgroup_reserve_data to reserve precious data space. */
 	ret = btrfs_qgroup_reserve_data(inode, reserved, start, len);
 	if (ret < 0) {
-		btrfs_free_reserved_data_space_noquota(fs_info, len);
+		btrfs_free_reserved_data_space_noquota(inode, len);
 		extent_changeset_free(*reserved);
 		*reserved = NULL;
 	} else {
@@ -168,9 +168,10 @@ int btrfs_check_data_free_space(struct btrfs_inode *inode,
  * which we can't sleep and is sure it won't affect qgroup reserved space.
  * Like clear_bit_hook().
  */
-void btrfs_free_reserved_data_space_noquota(struct btrfs_fs_info *fs_info,
+void btrfs_free_reserved_data_space_noquota(struct btrfs_inode *inode,
 					    u64 len)
 {
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_space_info *data_sinfo;
 
 	ASSERT(IS_ALIGNED(len, fs_info->sectorsize));
@@ -196,7 +197,7 @@ void btrfs_free_reserved_data_space(struct btrfs_inode *inode,
 	      round_down(start, fs_info->sectorsize);
 	start = round_down(start, fs_info->sectorsize);
 
-	btrfs_free_reserved_data_space_noquota(fs_info, len);
+	btrfs_free_reserved_data_space_noquota(inode, len);
 	btrfs_qgroup_free_data(inode, reserved, start, len, NULL);
 }
 
diff --git a/fs/btrfs/delalloc-space.h b/fs/btrfs/delalloc-space.h
index 069005959479..6119c0d3f883 100644
--- a/fs/btrfs/delalloc-space.h
+++ b/fs/btrfs/delalloc-space.h
@@ -18,8 +18,7 @@ void btrfs_free_reserved_data_space(struct btrfs_inode *inode,
 void btrfs_delalloc_release_space(struct btrfs_inode *inode,
 				  struct extent_changeset *reserved,
 				  u64 start, u64 len, bool qgroup_free);
-void btrfs_free_reserved_data_space_noquota(struct btrfs_fs_info *fs_info,
-					    u64 len);
+void btrfs_free_reserved_data_space_noquota(struct btrfs_inode *inode, u64 len);
 void btrfs_delalloc_release_metadata(struct btrfs_inode *inode, u64 num_bytes,
 				     bool qgroup_free);
 int btrfs_delalloc_reserve_space(struct btrfs_inode *inode,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 868ec20ef805..652dd9c5ec82 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2591,7 +2591,7 @@ void btrfs_clear_delalloc_extent(struct btrfs_inode *inode,
 		    !btrfs_is_free_space_inode(inode) &&
 		    !(state->state & EXTENT_NORESERVE) &&
 		    (bits & EXTENT_CLEAR_DATA_RESV))
-			btrfs_free_reserved_data_space_noquota(fs_info, len);
+			btrfs_free_reserved_data_space_noquota(inode, len);
 
 		percpu_counter_add_batch(&fs_info->delalloc_bytes, -len,
 					 fs_info->delalloc_batch);
@@ -9718,7 +9718,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	 * bytes_may_use.
 	 */
 	if (!extent_reserved)
-		btrfs_free_reserved_data_space_noquota(fs_info, disk_num_bytes);
+		btrfs_free_reserved_data_space_noquota(inode, disk_num_bytes);
 out_unlock:
 	btrfs_unlock_extent(io_tree, start, end, &cached_state);
 out_folios:
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 6ba9fcb53c33..6f4d9ffa404e 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2749,8 +2749,7 @@ static noinline_for_stack int prealloc_file_extent_cluster(struct reloc_control
 	btrfs_inode_unlock(inode, 0);
 
 	if (cur_offset < prealloc_end)
-		btrfs_free_reserved_data_space_noquota(inode->root->fs_info,
-					       prealloc_end + 1 - cur_offset);
+		btrfs_free_reserved_data_space_noquota(inode, prealloc_end + 1 - cur_offset);
 	return ret;
 }
 
-- 
2.49.0


