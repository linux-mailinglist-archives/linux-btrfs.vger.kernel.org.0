Return-Path: <linux-btrfs+bounces-13260-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D100FA97CEA
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 04:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041B7178F30
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 02:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C791F4CB6;
	Wed, 23 Apr 2025 02:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="P6zYRicp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB8D263F24
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 02:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745376266; cv=none; b=YKPPTmE0XiD9fC9eU9nqPoPCxICkI6zUXp+HQIIBV8ha1soPSjhRvxHUP2vcHsijC4rcyHun1dn+gjbAw/eGII1sBveRLeU/ReOoGblo77Ak1PM6Z848Tbv/YdwO5QBv6PRMdZLOsiDUso4T1bu7VtSSTQxQJ7FOiZV6ShyjUzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745376266; c=relaxed/simple;
	bh=RY4vfOPTNVfbmI3l95hf4OGAn04SDLaaMCUSWBDN7Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0k7SgjxVjDFPyA8p4Z1DWRhaHiqOi6xxI5yOQ+nimF7l+vtETec4u2AemumzMnRWnf0TL+mClURpmzXcsTgC7LCvt7Dd9yywrMT67yVkG09ZccBk70qyzy6ZIzAO+FNtaulBrF8VHPZUVNCWNY5CgTijSik2JRRgg3P19S8MW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=P6zYRicp; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745376263; x=1776912263;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RY4vfOPTNVfbmI3l95hf4OGAn04SDLaaMCUSWBDN7Ac=;
  b=P6zYRicpZyq7PZ4Cg33DwP9XRk6KpVnyS/32zMD0/fEXmIkqiDb7lYGr
   LiIZPTQXMTpWMsHX2w6aPVr6StDa2zARPdvu0ug5W2VTtD7ztJ7+YOuPS
   sH/2uMEvW//FR1pipsMbuPhJn2iz6BJ8EfW7f+vFRBuzDpUS1Dn5hVZkQ
   TM5rrgXNVTyoWKu1lhU03pfG/44KeSslCWbAD2COBTvRbG98m/G/4Vre5
   f4fAObNumFe/qZFQZH/sNNyh2GB94yvdXP5W0LAnWmqoiJZDYZ5ydyXUd
   RC90wSpfsSdYtLqZqWWCU3eP49kYRokp8T8LHx/QpoTJ2DY9CKRhknjzM
   A==;
X-CSE-ConnectionGUID: guMIksBOQBWdt5j1cKe55g==
X-CSE-MsgGUID: BE57ZNquT1yF9aHWl8SiLw==
X-IronPort-AV: E=Sophos;i="6.15,232,1739808000"; 
   d="scan'208";a="83011835"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2025 10:44:16 +0800
IronPort-SDR: 680845e8_saOXFIorntwOu69LyPEWROZxA/rEy5HklYwAnsV/cUEbnuO
 fkJuIrMpI+Xeci/dcvSyBN7dSqQ9oh9GPh2GCmA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Apr 2025 18:44:08 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon..) ([10.224.173.39])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Apr 2025 19:44:16 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 02/13] btrfs: take struct btrfs_inode in btrfs_free_reserved_data_space_noquota
Date: Wed, 23 Apr 2025 11:43:42 +0900
Message-ID: <bdb1b80701e3b7bb2cff9d7f6916f7ffe7b34bbc.1745375070.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745375070.git.naohiro.aota@wdc.com>
References: <cover.1745375070.git.naohiro.aota@wdc.com>
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
index a88aa23cdbb6..e68c0b4a3410 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2589,7 +2589,7 @@ void btrfs_clear_delalloc_extent(struct btrfs_inode *inode,
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
index 97c223aa90b6..e0fbfd56fbba 100644
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


