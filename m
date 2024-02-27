Return-Path: <linux-btrfs+bounces-2827-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8618687A5
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 04:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78F4EB23A9A
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 03:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D6C1BF24;
	Tue, 27 Feb 2024 03:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HaZAfJ2H";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AG4ejUXE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190E01B27D;
	Tue, 27 Feb 2024 03:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709003763; cv=none; b=ual9wi80V0KTnZCOgCUkhskt3H7iY2GTg3v70s2G37nYV0dVCEGf7hPcSF38rTSykRMCtpOBSj6nE7LdTaVnor7fSQITsy8wKZSV6Sf6L9nYuK0A6U9Lqn4Lgu3Bi0e4oG8svHV6hVE5ncCoA5RUfrMNVdNjdSaxKZeFH5pYbds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709003763; c=relaxed/simple;
	bh=UrM7wTpq4+dmPWPePjxgFqA69mKlm97Ulf9b+n6ijaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pmeUN5Axz6BFdPeuiFRna33EepRxq3XevRBhssp1L2zdQU+7UKaIvVhJ52GB7giLYIveLh6pIGkI1zjt1PufQKwaFfCrGbxr37o0sJ4gK7EA7wKrd9F1yYq4XSBqoM5mOu2Z+1bOiNiH/m6FMCHoxtTrTmXIzuQgl3ozHupVs4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HaZAfJ2H; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AG4ejUXE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E20F02274E;
	Tue, 27 Feb 2024 03:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709003759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=W5Ef0/U5YnlZfi8ZjQ3e3gx56JTtT3S0QwsgnGFnK7o=;
	b=HaZAfJ2HAA62guvcQj4QkGGKaccHFpPozMZ8NjWoMCTu63ArKzJexvubdO2Pnz46SGMTqC
	GxZxJ4vUoCGp3hrrtDtuIFwC8iqeKpWPyQYKc73vRXo+d5FPaURVtTemhQP13Vp/62kafS
	+Wa+3b2tmEVZU+zKTv0lImRMwbU1mLo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709003758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=W5Ef0/U5YnlZfi8ZjQ3e3gx56JTtT3S0QwsgnGFnK7o=;
	b=AG4ejUXEAzWdPMMuCwLBedo1ZLvIbQGVBSfrHD9RLtBN+RU9EW3n2tNqPwVGlYa7nc/FSZ
	in9d9lX63lqM3CCuABrL5mRENopa9JUVs7A3KyxhW5GnicAqYehIVhDzhht8zZfLaFu4fN
	rACwVFkzqDzqdWPmSplueUq2v9yB8IE=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AFC7D13419;
	Tue, 27 Feb 2024 03:15:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id A4z2G+1T3WXhbwAAn2gu4w
	(envelope-from <wqu@suse.com>); Tue, 27 Feb 2024 03:15:57 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] btrfs: qgroup: verify btrfs_qgroup_inherit parameter
Date: Tue, 27 Feb 2024 13:45:35 +1030
Message-ID: <bde2887da38aaa473ca60801b37ac735b3ab2d6d.1709003728.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Score: 1.90
X-Spam-Flag: NO

[BUG]
Currently btrfs can create subvolume with an invalid qgroup inherit
without triggering any error:

 # mkfs.btrfs -O quota -f $dev
 # mount $dev $mnt
 # btrfs subvolume create -i 2/0 $mnt/subv1
 # btrfs qgroup show -prce --sync $mnt
 Qgroupid    Referenced    Exclusive   Path
 --------    ----------    ---------   ----
 0/5           16.00KiB     16.00KiB   <toplevel>
 0/256         16.00KiB     16.00KiB   subv1

[CAUSE]
We only do a very basic size check for btrfs_qgroup_inherit structure,
but never really verify if the values are correct.

Thus in btrfs_qgroup_inherit() function, we have to skip non-existing
qgroups, and never return any error.

[FIX]
Fix the behavior and introduce extra checks:

- Introduce early check for btrfs_qgroup_inherit structure
  Not only the size, but also all the qgroup ids would be verifyed.

  And the timing is very early, so we can return error early.
  This early check is very important for snapshot creation, as snapshot
  is delayed to transaction commit.

- Drop support for btrfs_qgroup_inherit::num_ref_copies and
  num_excl_copies
  Those two members are used to specify to copy refr/excl numbers from
  other qgroups.
  This would definitely mark qgroup inconsistent, and btrfs-progs has
  dropped the support for them for a long time.
  It's time to drop the support for kernel.

- Verify the supported btrfs_qgroup_inherit::flags
  Just in case we want to add extra flags for btrfs_qgroup_inherit.

Now above subvolume creation would fail with -ENOENT other than silently
ignore the non-existing qgroup.

CC: stable@vger.kernel.org
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c           | 16 +++---------
 fs/btrfs/qgroup.c          | 52 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/qgroup.h          |  3 +++
 include/uapi/linux/btrfs.h |  1 +
 4 files changed, 59 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 8b80fbea1e72..c19ce2e292dc 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1382,7 +1382,7 @@ static noinline int btrfs_ioctl_snap_create_v2(struct file *file,
 	if (vol_args->flags & BTRFS_SUBVOL_RDONLY)
 		readonly = true;
 	if (vol_args->flags & BTRFS_SUBVOL_QGROUP_INHERIT) {
-		u64 nums;
+		struct btrfs_fs_info *fs_info = inode_to_fs_info(file_inode(file));
 
 		if (vol_args->size < sizeof(*inherit) ||
 		    vol_args->size > PAGE_SIZE) {
@@ -1395,19 +1395,9 @@ static noinline int btrfs_ioctl_snap_create_v2(struct file *file,
 			goto free_args;
 		}
 
-		if (inherit->num_qgroups > PAGE_SIZE ||
-		    inherit->num_ref_copies > PAGE_SIZE ||
-		    inherit->num_excl_copies > PAGE_SIZE) {
-			ret = -EINVAL;
+		ret = btrfs_qgroup_check_inherit(fs_info, inherit, vol_args->size);
+		if (ret < 0)
 			goto free_inherit;
-		}
-
-		nums = inherit->num_qgroups + 2 * inherit->num_ref_copies +
-		       2 * inherit->num_excl_copies;
-		if (vol_args->size != struct_size(inherit, qgroups, nums)) {
-			ret = -EINVAL;
-			goto free_inherit;
-		}
 	}
 
 	ret = __btrfs_ioctl_snap_create(file, file_mnt_idmap(file),
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 4fa83c76b37b..66968092b554 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3046,6 +3046,58 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
 	return ret;
 }
 
+int btrfs_qgroup_check_inherit(struct btrfs_fs_info *fs_info,
+			       struct btrfs_qgroup_inherit *inherit,
+			       size_t size)
+{
+	if (inherit->flags & ~BTRFS_QGROUP_INHERIT_FLAGS_SUPP)
+		return -EOPNOTSUPP;
+	if (size < sizeof(*inherit) || size > PAGE_SIZE)
+		return -EINVAL;
+
+	/*
+	 * In the past we allow btrfs_qgroup_inherit to specify to copy
+	 * refr/excl numbers directly from other qgroups.
+	 * This behavior has been disable in btrfs-progs for a very long time,
+	 * but here we should also disable them for kernel, as this behavior
+	 * is known to mark qgroup inconsistent, and a rescan would wipe out the
+	 * change anyway.
+	 *
+	 * So here we just reject any btrfs_qgroup_inherit with num_ref_copies or
+	 * num_excl_copies.
+	 */
+	if (inherit->num_ref_copies || inherit->num_excl_copies)
+		return -EINVAL;
+
+	if (inherit->num_qgroups > PAGE_SIZE)
+		return -EINVAL;
+
+	if (size != struct_size(inherit, qgroups, inherit->num_qgroups))
+		return -EINVAL;
+
+	/*
+	 * Now check all the remaining qgroups, they should all:
+	 * - Exist
+	 * - Be higher level qgroups.
+	 */
+	for (int i = 0; i < inherit->num_qgroups; i++) {
+		struct btrfs_qgroup *qgroup;
+		u64 qgroupid = inherit->qgroups[i];
+
+		if (btrfs_qgroup_level(qgroupid) == 0)
+			return -EINVAL;
+
+		spin_lock(&fs_info->qgroup_lock);
+		qgroup = find_qgroup_rb(fs_info, qgroupid);
+		if (!qgroup) {
+			spin_unlock(&fs_info->qgroup_lock);
+			return -ENOENT;
+		}
+		spin_unlock(&fs_info->qgroup_lock);
+	}
+	return 0;
+}
+
 static int qgroup_auto_inherit(struct btrfs_fs_info *fs_info,
 			       u64 inode_rootid,
 			       struct btrfs_qgroup_inherit **inherit)
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 1f664261c064..706640be0ec2 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -350,6 +350,9 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 				struct ulist *new_roots);
 int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans);
 int btrfs_run_qgroups(struct btrfs_trans_handle *trans);
+int btrfs_qgroup_check_inherit(struct btrfs_fs_info *fs_info,
+			       struct btrfs_qgroup_inherit *inherit,
+			       size_t size);
 int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 			 u64 objectid, u64 inode_rootid,
 			 struct btrfs_qgroup_inherit *inherit);
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index f8bc34a6bcfa..cdf6ad872149 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -92,6 +92,7 @@ struct btrfs_qgroup_limit {
  * struct btrfs_qgroup_inherit.flags
  */
 #define BTRFS_QGROUP_INHERIT_SET_LIMITS	(1ULL << 0)
+#define BTRFS_QGROUP_INHERIT_FLAGS_SUPP (BTRFS_QGROUP_INHERIT_SET_LIMITS)
 
 struct btrfs_qgroup_inherit {
 	__u64	flags;
-- 
2.43.2


