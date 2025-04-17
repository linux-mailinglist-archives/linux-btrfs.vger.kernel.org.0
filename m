Return-Path: <linux-btrfs+bounces-13121-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B366A91780
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 11:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B7F446490
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 09:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D79228CB7;
	Thu, 17 Apr 2025 09:17:39 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34EF227EB1
	for <linux-btrfs@vger.kernel.org>; Thu, 17 Apr 2025 09:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744881458; cv=none; b=pPSwfOMHkBAEb98m8xFht5E6N41VIWRGCmYJSb/RSAM5qxsWjH6KMLKhUqX/bwK6TTF69ehYAlWcN0HrIZPpbQr4hH0aJriqFZkF0OnPFNzglNbcyVzTTGfGl9/Zyau0Scli1E/I8+s4fLvKJNEPJ5ERGBEbbwj5/x7787KxbRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744881458; c=relaxed/simple;
	bh=JV+6R3Dk8JPGLQk20fbPkQMYBNZiEvw6dyBQVSBi+ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mF0x223k0WDPd14uCLJt1Cxtly7uzmYCyookgFV6HXUPZ6zZldXVVF1gtUOp4L89k0WTzSJPxAf8KCrFqPH4zrH4XO0/pcNPYzt6Vxk8Zr/PaP1aTNlxZe7d0zcuKEjKnnwCXSnEzhHTvjkXTl92bqpF/Ph8BekDU22r/Iou1/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 693901F6E6;
	Thu, 17 Apr 2025 09:17:31 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61B56137CF;
	Thu, 17 Apr 2025 09:17:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1tnYFyvHAGjIcQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 17 Apr 2025 09:17:31 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH v2 4/5] btrfs: convert WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG)) to DEBUG_WARN
Date: Thu, 17 Apr 2025 11:17:02 +0200
Message-ID: <a69c7b7ecd0a6a579f33db26106d6e51e31b7c00.1744881160.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744881159.git.dsterba@suse.com>
References: <cover.1744881159.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 693901F6E6
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

Use the conditional warning instead of typing the whole condition.
Optional message is printed where it seems clear what could be the
problem.

Conversion is left out in btree_csum_one_bio() because of the additional
condition.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/backref.c      | 2 +-
 fs/btrfs/disk-io.c      | 2 +-
 fs/btrfs/extent-tree.c  | 2 +-
 fs/btrfs/extent_io.c    | 2 +-
 fs/btrfs/inode.c        | 6 ++----
 fs/btrfs/qgroup.c       | 6 +++---
 fs/btrfs/tree-checker.c | 8 +++-----
 7 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 5936cff80ff3d3..e76e1845cfce14 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2877,7 +2877,7 @@ int btrfs_backref_iter_start(struct btrfs_backref_iter *iter, u64 bytenr)
 		goto release;
 	}
 	if (path->slots[0] == 0) {
-		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+		DEBUG_WARN();
 		ret = -EUCLEAN;
 		goto release;
 	}
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 59da809b7d57ab..041d5477647639 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4435,7 +4435,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	set_bit(BTRFS_FS_CLOSING_DONE, &fs_info->flags);
 
 	if (btrfs_check_quota_leak(fs_info)) {
-		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+		DEBUG_WARN("qgroup reserved space leaked");
 		btrfs_err(fs_info, "qgroup reserved space leaked");
 	}
 
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 8e3c6739d45e82..ad3a891874440b 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6425,7 +6425,7 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed,
 
 		/* Check if there are any CHUNK_* bits left */
 		if (start > device->total_bytes) {
-			WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+			DEBUG_WARN();
 			btrfs_warn_in_rcu(fs_info,
 "ignoring attempt to trim beyond device size: offset %llu length %llu device %s device size %llu",
 					  start, end - start + 1,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c5aba14ee53dc0..fcd830a0bce20c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3681,7 +3681,7 @@ static bool report_eb_range(const struct extent_buffer *eb, unsigned long start,
 	btrfs_warn(eb->fs_info,
 		"access to eb bytenr %llu len %u out of range start %lu len %lu",
 		eb->start, eb->len, start, len);
-	WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+	DEBUG_WARN();
 
 	return true;
 }
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b75d4a035da024..17db9a870b37db 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -777,9 +777,7 @@ static inline int inode_need_compress(struct btrfs_inode *inode, u64 start,
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 
 	if (!btrfs_inode_can_compress(inode)) {
-		WARN(IS_ENABLED(CONFIG_BTRFS_DEBUG),
-			KERN_ERR "BTRFS: unexpected compression for ino %llu\n",
-			btrfs_ino(inode));
+		DEBUG_WARN("BTRFS: unexpected compression for ino %llu", btrfs_ino(inode));
 		return 0;
 	}
 
@@ -2873,7 +2871,7 @@ int btrfs_writepage_cow_fixup(struct folio *folio)
 	 * We should not hit such out-of-band dirty folios anymore.
 	 */
 	if (IS_ENABLED(CONFIG_BTRFS_EXPERIMENTAL)) {
-		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+		DEBUG_WARN();
 		btrfs_err_rl(fs_info,
 	"root %lld ino %llu folio %llu is marked dirty without notifying the fs",
 			     BTRFS_I(inode)->root->root_key.objectid,
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 944c207cca87ff..b3176edbde82a0 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1823,7 +1823,7 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 	if (qgroup->rsv.values[BTRFS_QGROUP_RSV_DATA] ||
 	    qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PREALLOC] ||
 	    qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PERTRANS]) {
-		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+		DEBUG_WARN();
 		btrfs_warn_rl(fs_info,
 "to be deleted qgroup %u/%llu has non-zero numbers, data %llu meta prealloc %llu meta pertrans %llu",
 			      btrfs_qgroup_level(qgroup->qgroupid),
@@ -1843,7 +1843,7 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 	    !(fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT)) {
 		if (qgroup->rfer || qgroup->excl ||
 		    qgroup->rfer_cmpr || qgroup->excl_cmpr) {
-			WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+			DEBUG_WARN();
 			btrfs_warn_rl(fs_info,
 "to be deleted qgroup %u/%llu has non-zero numbers, rfer %llu rfer_cmpr %llu excl %llu excl_cmpr %llu",
 				      btrfs_qgroup_level(qgroup->qgroupid),
@@ -4767,7 +4767,7 @@ int btrfs_qgroup_add_swapped_blocks(struct btrfs_root *subvol_root,
 				 * Marking qgroup inconsistent should be enough
 				 * for end users.
 				 */
-				WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+				DEBUG_WARN("duplicated but mismatched entry found");
 				ret = -EEXIST;
 			}
 			kfree(block);
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 6ca3c09514e7b5..8f4703b488b71d 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -2230,8 +2230,7 @@ int btrfs_verify_level_key(struct extent_buffer *eb,
 
 	found_level = btrfs_header_level(eb);
 	if (unlikely(found_level != check->level)) {
-		WARN(IS_ENABLED(CONFIG_BTRFS_DEBUG),
-		     KERN_ERR "BTRFS: tree level check failed\n");
+		DEBUG_WARN();
 		btrfs_err(fs_info,
 "tree level mismatch detected, bytenr=%llu level expected=%u has=%u",
 			  eb->start, check->level, found_level);
@@ -2255,7 +2254,7 @@ int btrfs_verify_level_key(struct extent_buffer *eb,
 		btrfs_err(fs_info,
 		"invalid tree nritems, bytenr=%llu nritems=0 expect >0",
 			  eb->start);
-		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+		DEBUG_WARN();
 		return -EUCLEAN;
 	}
 
@@ -2266,8 +2265,7 @@ int btrfs_verify_level_key(struct extent_buffer *eb,
 
 	ret = btrfs_comp_cpu_keys(&check->first_key, &found_key);
 	if (unlikely(ret)) {
-		WARN(IS_ENABLED(CONFIG_BTRFS_DEBUG),
-		     KERN_ERR "BTRFS: tree first key check failed\n");
+		DEBUG_WARN();
 		btrfs_err(fs_info,
 "tree first key mismatch detected, bytenr=%llu parent_transid=%llu key expected=(%llu,%u,%llu) has=(%llu,%u,%llu)",
 			  eb->start, check->transid, check->first_key.objectid,
-- 
2.49.0


