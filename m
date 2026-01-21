Return-Path: <linux-btrfs+bounces-20844-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDy3FbsecWmodQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20844-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 19:45:15 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1606D5B762
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 19:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BFF077854DE
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 16:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC0940F8F7;
	Wed, 21 Jan 2026 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhNotUb3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9894149551B
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769013053; cv=none; b=t6sEdkLfOScXYql25P2e9nrHa5UKd1nXW+Il2yLmAHOnqN6LvNwiQmiq+mG/hHcFBBU/KoyB+0nP5Qy2E2Aet65sETfnUFSTkEKOj4l1yvxqgekz2yudtC+cs0k4Z1QBFXMpny6BA0QYHLxmTBxeKS17AEq2aU3++m54wNxfx4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769013053; c=relaxed/simple;
	bh=FeQcJQPc/0OBlEL40Vy4K1mWq+dGfRncv8KHYp5AjjU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i4PB5TU+EOXQlXK19+mgo02c5zQw0G/3HzeKKl2UZYQsB4XVL1PwqI2TshljSG0JUJw527/tzwrDagrb8oG8/2/1g8B5ViSpcTYbmnsUqsI/+fx9UxfBARbWD+qWVnYV+HL7i0eE3QtNWY3MdySD75ftR3jP0nFkQjrIG/SdL8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhNotUb3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0985AC116D0
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 16:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769013053;
	bh=FeQcJQPc/0OBlEL40Vy4K1mWq+dGfRncv8KHYp5AjjU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KhNotUb3E2CjjNiMphfkYGlH7hr1D9sOSq0s4YfibT6bxc6TX7+Y37le0HVn3QqzN
	 M9MIf9LSPjumnIoBb9ufEHTsc0i/O8Unn/nX51h3oy5+pIHiWmX0ckzhN1NmaTcg/Q
	 ERuLSgqiIOduQDm9wHcaGyoWATI9JIWx+8gTJVPIBcpBmwu9tsF0at/wEsnhelRLtG
	 foZjF3ssynAkqfnSUqP00iJ/PN+pk4JiX+bI8BIg4Po3SJu9d0OOcWCqPY6GjySp6J
	 yuRH4gY7oknzCySyMXid56GNHEcFCsMoI7NDGSJTZ65CFginqlovh7Ozwug2psCuqX
	 Axmf4j2F5bJ6w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 05/19] btrfs: remove pointless out labels from disk-io.c
Date: Wed, 21 Jan 2026 16:30:31 +0000
Message-ID: <c698fe33c3b15d38eaf7e4890d41557cfb67aa76.1769012877.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1769012876.git.fdmanana@suse.com>
References: <cover.1769012876.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20844-lists,linux-btrfs=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org]
X-Rspamd-Queue-Id: 1606D5B762
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Filipe Manana <fdmanana@suse.com>

Some functions (btrfs_validate_extent_buffer() and
btrfs_start_pre_rw_mount()) have an 'out' label that does nothing but
return, making it pointless. Simplify this by removing the label and
returning instead of gotos plus setting the 'ret' variable.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c | 54 +++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 32fffb0557e5..cdda16775231 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -369,22 +369,19 @@ int btrfs_validate_extent_buffer(struct extent_buffer *eb,
 		btrfs_err_rl(fs_info,
 			"bad tree block start, mirror %u want %llu have %llu",
 			     eb->read_mirror, eb->start, found_start);
-		ret = -EIO;
-		goto out;
+		return -EIO;
 	}
 	if (unlikely(check_tree_block_fsid(eb))) {
 		btrfs_err_rl(fs_info, "bad fsid on logical %llu mirror %u",
 			     eb->start, eb->read_mirror);
-		ret = -EIO;
-		goto out;
+		return -EIO;
 	}
 	found_level = btrfs_header_level(eb);
 	if (unlikely(found_level >= BTRFS_MAX_LEVEL)) {
 		btrfs_err(fs_info,
 			"bad tree block level, mirror %u level %d on logical %llu",
 			eb->read_mirror, btrfs_header_level(eb), eb->start);
-		ret = -EIO;
-		goto out;
+		return -EIO;
 	}
 
 	csum_tree_block(eb, result);
@@ -399,18 +396,15 @@ int btrfs_validate_extent_buffer(struct extent_buffer *eb,
 			      BTRFS_CSUM_FMT_VALUE(csum_size, result),
 			      btrfs_header_level(eb),
 			      ignore_csum ? ", ignored" : "");
-		if (unlikely(!ignore_csum)) {
-			ret = -EUCLEAN;
-			goto out;
-		}
+		if (unlikely(!ignore_csum))
+			return -EUCLEAN;
 	}
 
 	if (unlikely(found_level != check->level)) {
 		btrfs_err(fs_info,
 		"level verify failed on logical %llu mirror %u wanted %u found %u",
 			  eb->start, eb->read_mirror, check->level, found_level);
-		ret = -EIO;
-		goto out;
+		return -EIO;
 	}
 	if (unlikely(check->transid &&
 		     btrfs_header_generation(eb) != check->transid)) {
@@ -418,8 +412,7 @@ int btrfs_validate_extent_buffer(struct extent_buffer *eb,
 "parent transid verify failed on logical %llu mirror %u wanted %llu found %llu",
 				eb->start, eb->read_mirror, check->transid,
 				btrfs_header_generation(eb));
-		ret = -EIO;
-		goto out;
+		return -EIO;
 	}
 	if (check->has_first_key) {
 		const struct btrfs_key *expect_key = &check->first_key;
@@ -437,14 +430,13 @@ int btrfs_validate_extent_buffer(struct extent_buffer *eb,
 				  expect_key->type, expect_key->offset,
 				  found_key.objectid, found_key.type,
 				  found_key.offset);
-			ret = -EUCLEAN;
-			goto out;
+			return -EUCLEAN;
 		}
 	}
 	if (check->owner_root) {
 		ret = btrfs_check_eb_owner(eb, check->owner_root);
 		if (ret < 0)
-			goto out;
+			return ret;
 	}
 
 	/* If this is a leaf block and it is corrupt, just return -EIO. */
@@ -458,7 +450,6 @@ int btrfs_validate_extent_buffer(struct extent_buffer *eb,
 		btrfs_err(fs_info,
 		"read time tree block corruption detected on logical %llu mirror %u",
 			  eb->start, eb->read_mirror);
-out:
 	return ret;
 }
 
@@ -3075,7 +3066,7 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
 		if (ret) {
 			btrfs_warn(fs_info,
 				   "failed to rebuild free space tree: %d", ret);
-			goto out;
+			return ret;
 		}
 	}
 
@@ -3086,7 +3077,7 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
 		if (ret) {
 			btrfs_warn(fs_info,
 				   "failed to disable free space tree: %d", ret);
-			goto out;
+			return ret;
 		}
 	}
 
@@ -3097,7 +3088,7 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
 	ret = btrfs_delete_orphan_free_space_entries(fs_info);
 	if (ret < 0) {
 		btrfs_err(fs_info, "failed to delete orphan free space tree entries: %d", ret);
-		goto out;
+		return ret;
 	}
 	/*
 	 * btrfs_find_orphan_roots() is responsible for finding all the dead
@@ -3112,17 +3103,17 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
 	 */
 	ret = btrfs_find_orphan_roots(fs_info);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = btrfs_cleanup_fs_roots(fs_info);
 	if (ret)
-		goto out;
+		return ret;
 
 	down_read(&fs_info->cleanup_work_sem);
 	if ((ret = btrfs_orphan_cleanup(fs_info->fs_root)) ||
 	    (ret = btrfs_orphan_cleanup(fs_info->tree_root))) {
 		up_read(&fs_info->cleanup_work_sem);
-		goto out;
+		return ret;
 	}
 	up_read(&fs_info->cleanup_work_sem);
 
@@ -3131,7 +3122,7 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
 	mutex_unlock(&fs_info->cleaner_mutex);
 	if (ret < 0) {
 		btrfs_warn(fs_info, "failed to recover relocation: %d", ret);
-		goto out;
+		return ret;
 	}
 
 	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE) &&
@@ -3141,24 +3132,24 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
 		if (ret) {
 			btrfs_warn(fs_info,
 				"failed to create free space tree: %d", ret);
-			goto out;
+			return ret;
 		}
 	}
 
 	if (cache_opt != btrfs_free_space_cache_v1_active(fs_info)) {
 		ret = btrfs_set_free_space_cache_v1_active(fs_info, cache_opt);
 		if (ret)
-			goto out;
+			return ret;
 	}
 
 	ret = btrfs_resume_balance_async(fs_info);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = btrfs_resume_dev_replace_async(fs_info);
 	if (ret) {
 		btrfs_warn(fs_info, "failed to resume dev_replace");
-		goto out;
+		return ret;
 	}
 
 	btrfs_qgroup_rescan_resume(fs_info);
@@ -3169,12 +3160,11 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
 		if (ret) {
 			btrfs_warn(fs_info,
 				   "failed to create the UUID tree %d", ret);
-			goto out;
+			return ret;
 		}
 	}
 
-out:
-	return ret;
+	return 0;
 }
 
 /*
-- 
2.47.2


