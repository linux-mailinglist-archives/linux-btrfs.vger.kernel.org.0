Return-Path: <linux-btrfs+bounces-22038-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QA6rH3ThoGk4nwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22038-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 01:12:36 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D43881B1277
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 01:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94AD83042242
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 00:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A081F4C8E;
	Fri, 27 Feb 2026 00:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAlx8PCT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C34155326
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 00:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772151108; cv=none; b=Qw2MB0iyMLgdmd3EVO88ZOAcKOKKs/YwFMxXClysqN1dzcmepS5Aq2blQCoxTDteTYQ2jyAomK94btzDklXM05ovLj+oh1SF7zrLjNQaCIdqYgwNQ0SVot3JQTbHYVdTEJ5wgv9W/7+SP94sISqdsFx34tgDvnVFC5ar6HPCaW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772151108; c=relaxed/simple;
	bh=IPDF4uY7u1aisHjPAx14feMyo848FVvoRf1jYeL30pU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XvKVxaqzf5B8yR62mtpJznOSwbOBZT1JjxxODOrafv3C3wXLo+YiDkdCIchO/axwMD5bMoGFTMJLJ5Kj7crg/MKvPsE0zI+/8YgHLbiPXuQwEI/uGt4qbBPkeEoSS5/mEyXTnpmOQGGU9qD5k7QpRaoIC3qsYuc/JcDOzKxFbho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAlx8PCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC1AC19425
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 00:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772151108;
	bh=IPDF4uY7u1aisHjPAx14feMyo848FVvoRf1jYeL30pU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dAlx8PCTYoZC//4aupHSCPjCwkrmTazS/9ZCiueaBhKA5EqN2G3/XS6UokKpgpcW2
	 DP/OyX/Gnb0LuT6AAxeK4QenaWblyOEWn3NsxUe6OIqZ87EE+9z0qVSVSuAzwme2Wc
	 Tzp6VWP2QCpvAJScus8TCPUug3EeLa4qtSnq3minWY+ps0t0Cn+PDkZ3Yc+6u6EP1j
	 EoNed6gHZVgkjWUd0UKwVFIFYMh81RAjmx4mqN2Qm1m3X7jyVv74RBiF8DGALIWT+b
	 jVxfiKjolgCFOnIioCCl+UcKCR8403qK7b3X4HnKQa/1SoWIi9yHkq74RrNIrNtxvs
	 1wqTmiADXZ+aA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: fix transaction abort on set received ioctl due to item overflow
Date: Fri, 27 Feb 2026 00:11:41 +0000
Message-ID: <db16f1cae85b0fe2507902a2d4ac0f3878ef54e0.1772150849.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1772150849.git.fdmanana@suse.com>
References: <cover.1772150849.git.fdmanana@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22038-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D43881B1277
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

If the set received ioctl fails due to an item overflow when attempting to
add the BTRFS_UUID_KEY_RECEIVED_SUBVOL we have to abort the transaction
since we did some metadata updates before.

This means that if a user calls this ioctl with the same received UUID
field for a lot of subvolumes, we will hit the overflow, trigger the
transaction abort and turn the filesystem into RO mode. A malicious user
could exploit this, and this ioctl does not even requires that a user
has admin privileges (CAP_SYS_ADMIN), only that he/she owns the subvolume.

Fix this by doing an early check for item overflow before starting a
transaction. This is also race safe because we are holding the subvol_sem
semaphore in exclusive (write) mode.

A test case for fstests will follow soon.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ioctl.c     | 21 +++++++++++++++++++--
 fs/btrfs/uuid-tree.c | 38 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/uuid-tree.h |  2 ++
 3 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index fa68fbeb6722..dd411b0732a7 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3865,6 +3865,25 @@ static long _btrfs_ioctl_set_received_subvol(struct file *file,
 		goto out;
 	}
 
+	received_uuid_changed = memcmp(root_item->received_uuid, sa->uuid,
+				       BTRFS_UUID_SIZE);
+
+	/*
+	 * Before we attempt to add the new received uuid, check if we have room
+	 * for it in case there's already an item. If the size of the existing
+	 * item plus this root's ID (u64) exceeds the maximum item size, we can
+	 * return here without the need to abort a transaction. If we don't do
+	 * this check, the btrfs_uuid_tree_add() call below would fail with
+	 * -EOVERFLOW and result in a transaction abort. Malicious users could
+	 * exploit this to turn the fs into RO mode.
+	 */
+	if (received_uuid_changed && !btrfs_is_empty_uuid(sa->uuid)) {
+		ret = btrfs_uuid_tree_check_overflow(fs_info, sa->uuid,
+						     BTRFS_UUID_KEY_RECEIVED_SUBVOL);
+		if (ret < 0)
+			goto out;
+	}
+
 	/*
 	 * 1 - root item
 	 * 2 - uuid items (received uuid + subvol uuid)
@@ -3880,8 +3899,6 @@ static long _btrfs_ioctl_set_received_subvol(struct file *file,
 	sa->rtime.sec = ct.tv_sec;
 	sa->rtime.nsec = ct.tv_nsec;
 
-	received_uuid_changed = memcmp(root_item->received_uuid, sa->uuid,
-				       BTRFS_UUID_SIZE);
 	if (received_uuid_changed &&
 	    !btrfs_is_empty_uuid(root_item->received_uuid)) {
 		ret = btrfs_uuid_tree_remove(trans, root_item->received_uuid,
diff --git a/fs/btrfs/uuid-tree.c b/fs/btrfs/uuid-tree.c
index 7942d3887515..276f0eb874d4 100644
--- a/fs/btrfs/uuid-tree.c
+++ b/fs/btrfs/uuid-tree.c
@@ -196,6 +196,44 @@ int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, const u8 *uuid, u8
 	return 0;
 }
 
+/*
+ * Check if we can add one root ID to a UUID key.
+ * If the key does not yet exists, we can, otherwise only if extended item does
+ * not exceeds the maximum item size permitted by the leaf size.
+ *
+ * Returns 0 on success, negative value on error.
+ */
+int btrfs_uuid_tree_check_overflow(struct btrfs_fs_info *fs_info,
+				   const u8 *uuid, u8 type)
+{
+	BTRFS_PATH_AUTO_FREE(path);
+	int ret;
+	u32 item_size;
+	struct btrfs_key key;
+
+	if (WARN_ON_ONCE(!fs_info->uuid_root))
+		return -EINVAL;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	btrfs_uuid_to_key(uuid, type, &key);
+	ret = btrfs_search_slot(NULL, fs_info->uuid_root, &key, path, 0, 0);
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		return 0;
+
+	item_size = btrfs_item_size(path->nodes[0], path->slots[0]);
+
+	if (sizeof(struct btrfs_item) + item_size + sizeof(u64) >
+	    BTRFS_LEAF_DATA_SIZE(fs_info))
+		return -EOVERFLOW;
+
+	return 0;
+}
+
 static int btrfs_uuid_iter_rem(struct btrfs_root *uuid_root, u8 *uuid, u8 type,
 			       u64 subid)
 {
diff --git a/fs/btrfs/uuid-tree.h b/fs/btrfs/uuid-tree.h
index c60ad20325cc..02b235a3653f 100644
--- a/fs/btrfs/uuid-tree.h
+++ b/fs/btrfs/uuid-tree.h
@@ -12,6 +12,8 @@ int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, const u8 *uuid, u8 typ
 			u64 subid);
 int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, const u8 *uuid, u8 type,
 			u64 subid);
+int btrfs_uuid_tree_check_overflow(struct btrfs_fs_info *fs_info,
+				   const u8 *uuid, u8 type);
 int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info);
 int btrfs_create_uuid_tree(struct btrfs_fs_info *fs_info);
 int btrfs_uuid_scan_kthread(void *data);
-- 
2.47.2


