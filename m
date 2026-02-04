Return-Path: <linux-btrfs+bounces-21369-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEOdGvVxg2mFmwMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21369-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 17:21:09 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B92E3EA1D3
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 17:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B37730E256C
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Feb 2026 15:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2CB421EE0;
	Wed,  4 Feb 2026 15:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KV2Nf+9o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0711421A1E
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770220335; cv=none; b=f4erKvh7qKhpOO4cDU6RsCfyJIsdJ2nr+dpQEAOg4Gx49xEUNj57VlzWeF/Mqq5qLtftOWPY6tBfefRviCsuzBR9u0ON8YlF3lfyIMxzQymTPnkVJ6PnLOji0dpeCwFADtZokU0CSka1lN0BiVJm15lEItnK0y36R1W0qBDk624=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770220335; c=relaxed/simple;
	bh=uKnrrV5LgfSvyBh+BrCKiEvsf/UCVozi5WRN/dx2zgE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AbQtxqXzRb9j9kgy6NZ4hzN/VDVyNBprjWK9plcscQHKmsyKAeRG3lxLLAK/rU/uCty8509O+lr7XuezZMEhn6x78FBF7XiHKAQctBMDMrQtB6UQtcsA6Em7ccVBSmlx9eC2Bo3Vu2XApGRtx2q8v53xz8qCFyxsEGXy6ni9YGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KV2Nf+9o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90CCC4CEF7
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 15:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770220335;
	bh=uKnrrV5LgfSvyBh+BrCKiEvsf/UCVozi5WRN/dx2zgE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KV2Nf+9oUgkuVDmONkKuF6agEWx6w+jgfolx/LXjGItOx+nTw2oiKl/xjkDhSZCEF
	 X2tI5AwOfBS4GpjXx1pDpns+OA2Ks76zfX/6SKuIg/SrxqiV/nxjJp9OY+ml3cIOO5
	 lMEPN6RnvsfRWdnOdjlMEL1Co5acq1GoZI7f4H2IGxYolsAS4U9T8lRMo+MW2RVybN
	 RE/aWWXMhSGJiOWVYAaQ3FJOTP2whFQ1MHq9XgNf0i0mA7lorX86Bx8BveEnxYT9nT
	 kbvMPB33EhWjDnCjgb4/qUeTBuhZKHX0hfZRFRzKvF1+6RlFmiciwVMmHio4Mz2JFs
	 CTb7uuwLce1qQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/7] btrfs: mark all error and warning checks as unlikely in btrfs_validate_super()
Date: Wed,  4 Feb 2026 15:51:59 +0000
Message-ID: <09f9fef601b39776ad0f0c9b46c645f6866b2a17.1770212626.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1770212626.git.fdmanana@suse.com>
References: <cover.1770212626.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21369-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B92E3EA1D3
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

When validating a super block, either when mounting or every time we write
a super block to disk, we do many checks for error and warnings and we
don't expect to hit any. So mark each one as unlikely to reflect that and
allow the compiler to potentially generate better code.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c | 78 +++++++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a6011da279e3..b9eb38072191 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2363,11 +2363,11 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
 	int ret = 0;
 	const bool ignore_flags = btrfs_test_opt(fs_info, IGNORESUPERFLAGS);
 
-	if (btrfs_super_magic(sb) != BTRFS_MAGIC) {
+	if (unlikely(btrfs_super_magic(sb) != BTRFS_MAGIC)) {
 		btrfs_err(fs_info, "no valid FS found");
 		ret = -EINVAL;
 	}
-	if ((btrfs_super_flags(sb) & ~BTRFS_SUPER_FLAG_SUPP)) {
+	if (unlikely(btrfs_super_flags(sb) & ~BTRFS_SUPER_FLAG_SUPP)) {
 		if (!ignore_flags) {
 			btrfs_err(fs_info,
 			"unrecognized or unsupported super flag 0x%llx",
@@ -2379,17 +2379,17 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
 				   btrfs_super_flags(sb) & ~BTRFS_SUPER_FLAG_SUPP);
 		}
 	}
-	if (btrfs_super_root_level(sb) >= BTRFS_MAX_LEVEL) {
+	if (unlikely(btrfs_super_root_level(sb) >= BTRFS_MAX_LEVEL)) {
 		btrfs_err(fs_info, "tree_root level too big: %d >= %d",
 				btrfs_super_root_level(sb), BTRFS_MAX_LEVEL);
 		ret = -EINVAL;
 	}
-	if (btrfs_super_chunk_root_level(sb) >= BTRFS_MAX_LEVEL) {
+	if (unlikely(btrfs_super_chunk_root_level(sb) >= BTRFS_MAX_LEVEL)) {
 		btrfs_err(fs_info, "chunk_root level too big: %d >= %d",
 				btrfs_super_chunk_root_level(sb), BTRFS_MAX_LEVEL);
 		ret = -EINVAL;
 	}
-	if (btrfs_super_log_root_level(sb) >= BTRFS_MAX_LEVEL) {
+	if (unlikely(btrfs_super_log_root_level(sb) >= BTRFS_MAX_LEVEL)) {
 		btrfs_err(fs_info, "log_root level too big: %d >= %d",
 				btrfs_super_log_root_level(sb), BTRFS_MAX_LEVEL);
 		ret = -EINVAL;
@@ -2399,65 +2399,65 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
 	 * Check sectorsize and nodesize first, other check will need it.
 	 * Check all possible sectorsize(4K, 8K, 16K, 32K, 64K) here.
 	 */
-	if (!is_power_of_2(sectorsize) || sectorsize < BTRFS_MIN_BLOCKSIZE ||
-	    sectorsize > BTRFS_MAX_METADATA_BLOCKSIZE) {
+	if (unlikely(!is_power_of_2(sectorsize) || sectorsize < BTRFS_MIN_BLOCKSIZE ||
+		     sectorsize > BTRFS_MAX_METADATA_BLOCKSIZE)) {
 		btrfs_err(fs_info, "invalid sectorsize %llu", sectorsize);
 		ret = -EINVAL;
 	}
 
-	if (!btrfs_supported_blocksize(sectorsize)) {
+	if (unlikely(!btrfs_supported_blocksize(sectorsize))) {
 		btrfs_err(fs_info,
 			"sectorsize %llu not yet supported for page size %lu",
 			sectorsize, PAGE_SIZE);
 		ret = -EINVAL;
 	}
 
-	if (!is_power_of_2(nodesize) || nodesize < sectorsize ||
-	    nodesize > BTRFS_MAX_METADATA_BLOCKSIZE) {
+	if (unlikely(!is_power_of_2(nodesize) || nodesize < sectorsize ||
+		     nodesize > BTRFS_MAX_METADATA_BLOCKSIZE)) {
 		btrfs_err(fs_info, "invalid nodesize %llu", nodesize);
 		ret = -EINVAL;
 	}
-	if (nodesize != le32_to_cpu(sb->__unused_leafsize)) {
+	if (unlikely(nodesize != le32_to_cpu(sb->__unused_leafsize))) {
 		btrfs_err(fs_info, "invalid leafsize %u, should be %llu",
 			  le32_to_cpu(sb->__unused_leafsize), nodesize);
 		ret = -EINVAL;
 	}
 
 	/* Root alignment check */
-	if (!IS_ALIGNED(btrfs_super_root(sb), sectorsize)) {
+	if (unlikely(!IS_ALIGNED(btrfs_super_root(sb), sectorsize))) {
 		btrfs_err(fs_info, "tree_root block unaligned: %llu",
 			  btrfs_super_root(sb));
 		ret = -EINVAL;
 	}
-	if (!IS_ALIGNED(btrfs_super_chunk_root(sb), sectorsize)) {
+	if (unlikely(!IS_ALIGNED(btrfs_super_chunk_root(sb), sectorsize))) {
 		btrfs_err(fs_info, "chunk_root block unaligned: %llu",
 			   btrfs_super_chunk_root(sb));
 		ret = -EINVAL;
 	}
-	if (!IS_ALIGNED(btrfs_super_log_root(sb), sectorsize)) {
+	if (unlikely(!IS_ALIGNED(btrfs_super_log_root(sb), sectorsize))) {
 		btrfs_err(fs_info, "log_root block unaligned: %llu",
 			  btrfs_super_log_root(sb));
 		ret = -EINVAL;
 	}
 
-	if (!fs_info->fs_devices->temp_fsid &&
-	    memcmp(fs_info->fs_devices->fsid, sb->fsid, BTRFS_FSID_SIZE) != 0) {
+	if (unlikely(!fs_info->fs_devices->temp_fsid &&
+		     memcmp(fs_info->fs_devices->fsid, sb->fsid, BTRFS_FSID_SIZE) != 0)) {
 		btrfs_err(fs_info,
 		"superblock fsid doesn't match fsid of fs_devices: %pU != %pU",
 			  sb->fsid, fs_info->fs_devices->fsid);
 		ret = -EINVAL;
 	}
 
-	if (memcmp(fs_info->fs_devices->metadata_uuid, btrfs_sb_fsid_ptr(sb),
-		   BTRFS_FSID_SIZE) != 0) {
+	if (unlikely(memcmp(fs_info->fs_devices->metadata_uuid, btrfs_sb_fsid_ptr(sb),
+			    BTRFS_FSID_SIZE) != 0)) {
 		btrfs_err(fs_info,
 "superblock metadata_uuid doesn't match metadata uuid of fs_devices: %pU != %pU",
 			  btrfs_sb_fsid_ptr(sb), fs_info->fs_devices->metadata_uuid);
 		ret = -EINVAL;
 	}
 
-	if (memcmp(fs_info->fs_devices->metadata_uuid, sb->dev_item.fsid,
-		   BTRFS_FSID_SIZE) != 0) {
+	if (unlikely(memcmp(fs_info->fs_devices->metadata_uuid, sb->dev_item.fsid,
+			    BTRFS_FSID_SIZE) != 0)) {
 		btrfs_err(fs_info,
 			"dev_item UUID does not match metadata fsid: %pU != %pU",
 			fs_info->fs_devices->metadata_uuid, sb->dev_item.fsid);
@@ -2468,9 +2468,9 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
 	 * Artificial requirement for block-group-tree to force newer features
 	 * (free-space-tree, no-holes) so the test matrix is smaller.
 	 */
-	if (btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE) &&
-	    (!btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID) ||
-	     !btrfs_fs_incompat(fs_info, NO_HOLES))) {
+	if (unlikely(btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE) &&
+		     (!btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID) ||
+		      !btrfs_fs_incompat(fs_info, NO_HOLES)))) {
 		btrfs_err(fs_info,
 		"block-group-tree feature requires free-space-tree and no-holes");
 		ret = -EINVAL;
@@ -2481,25 +2481,25 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
 		 * Reduce test matrix for remap tree by requiring block-group-tree
 		 * and no-holes. Free-space-tree is a hard requirement.
 		 */
-		if (!btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID) ||
-		    !btrfs_fs_incompat(fs_info, NO_HOLES) ||
-		    !btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE)) {
+		if (unlikely(!btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID) ||
+			     !btrfs_fs_incompat(fs_info, NO_HOLES) ||
+			     !btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE))) {
 			btrfs_err(fs_info,
 "remap-tree feature requires free-space-tree, no-holes, and block-group-tree");
 			ret = -EINVAL;
 		}
 
-		if (btrfs_fs_incompat(fs_info, MIXED_GROUPS)) {
+		if (unlikely(btrfs_fs_incompat(fs_info, MIXED_GROUPS))) {
 			btrfs_err(fs_info, "remap-tree not supported with mixed-bg");
 			ret = -EINVAL;
 		}
 
-		if (btrfs_fs_incompat(fs_info, ZONED)) {
+		if (unlikely(btrfs_fs_incompat(fs_info, ZONED))) {
 			btrfs_err(fs_info, "remap-tree not supported with zoned devices");
 			ret = -EINVAL;
 		}
 
-		if (sectorsize > PAGE_SIZE) {
+		if (unlikely(sectorsize > PAGE_SIZE)) {
 			btrfs_err(fs_info, "remap-tree not supported when block size > page size");
 			ret = -EINVAL;
 		}
@@ -2509,32 +2509,32 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
 	 * Hint to catch really bogus numbers, bitflips or so, more exact checks are
 	 * done later
 	 */
-	if (btrfs_super_bytes_used(sb) < 6 * btrfs_super_nodesize(sb)) {
+	if (unlikely(btrfs_super_bytes_used(sb) < 6 * btrfs_super_nodesize(sb))) {
 		btrfs_err(fs_info, "bytes_used is too small %llu",
 			  btrfs_super_bytes_used(sb));
 		ret = -EINVAL;
 	}
-	if (!is_power_of_2(btrfs_super_stripesize(sb))) {
+	if (unlikely(!is_power_of_2(btrfs_super_stripesize(sb)))) {
 		btrfs_err(fs_info, "invalid stripesize %u",
 			  btrfs_super_stripesize(sb));
 		ret = -EINVAL;
 	}
-	if (btrfs_super_num_devices(sb) > (1UL << 31))
+	if (unlikely(btrfs_super_num_devices(sb) > (1UL << 31)))
 		btrfs_warn(fs_info, "suspicious number of devices: %llu",
 			   btrfs_super_num_devices(sb));
-	if (btrfs_super_num_devices(sb) == 0) {
+	if (unlikely(btrfs_super_num_devices(sb) == 0)) {
 		btrfs_err(fs_info, "number of devices is 0");
 		ret = -EINVAL;
 	}
 
-	if (mirror_num >= 0 &&
-	    btrfs_super_bytenr(sb) != btrfs_sb_offset(mirror_num)) {
+	if (unlikely(mirror_num >= 0 &&
+		     btrfs_super_bytenr(sb) != btrfs_sb_offset(mirror_num))) {
 		btrfs_err(fs_info, "super offset mismatch %llu != %u",
 			  btrfs_super_bytenr(sb), BTRFS_SUPER_INFO_OFFSET);
 		ret = -EINVAL;
 	}
 
-	if (ret)
+	if (unlikely(ret))
 		return ret;
 
 	ret = validate_sys_chunk_array(fs_info, sb);
@@ -2543,13 +2543,13 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
 	 * The generation is a global counter, we'll trust it more than the others
 	 * but it's still possible that it's the one that's wrong.
 	 */
-	if (btrfs_super_generation(sb) < btrfs_super_chunk_root_generation(sb))
+	if (unlikely(btrfs_super_generation(sb) < btrfs_super_chunk_root_generation(sb)))
 		btrfs_warn(fs_info,
 			"suspicious: generation < chunk_root_generation: %llu < %llu",
 			btrfs_super_generation(sb),
 			btrfs_super_chunk_root_generation(sb));
-	if (btrfs_super_generation(sb) < btrfs_super_cache_generation(sb)
-	    && btrfs_super_cache_generation(sb) != (u64)-1)
+	if (unlikely(btrfs_super_generation(sb) < btrfs_super_cache_generation(sb) &&
+		     btrfs_super_cache_generation(sb) != (u64)-1))
 		btrfs_warn(fs_info,
 			"suspicious: generation < cache_generation: %llu < %llu",
 			btrfs_super_generation(sb),
-- 
2.47.2


