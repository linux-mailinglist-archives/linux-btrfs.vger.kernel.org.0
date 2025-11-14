Return-Path: <linux-btrfs+bounces-19030-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2921FC5F6B3
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 22:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC4693B1112
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 21:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D143306488;
	Fri, 14 Nov 2025 21:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WORq8Zvq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="L7fCDqny"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CB9302176
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Nov 2025 21:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763156793; cv=none; b=cz2xR/D9Oz+ZCfnJULWbq1FsH2vVFE4hAA+kKdSg+gzOXGw2hsIj50aoSef7RqtsMF2X2uBfXjK17NF22Y7iNfz+5UnE8FoqxA/Z2E/QJLWlu6D9mwwMvNbA+YoDVRup+FLHSQsq3/y5AIckaB0vqpgXbA7FcNrkZcPuHGniDPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763156793; c=relaxed/simple;
	bh=cQGJeuH22b1e5onEbxjc9WqxLxLVIAnEIdv9hNfjPkg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LnYjeNKPkO4qfyg/tS3sU8CvPkYQmA2ipvrjnc1smetLK5ty4mVNlrABucafhBrn3dHrXU8KsQVwScXVAVcqSTvYlYVASuiS6q/1w55cWB8BGeBfDvFqdEprT7BtSin1zrpr3pBTiZTyjIDkudJ54LGcVIQWqaoZybgcPwuHQ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WORq8Zvq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=L7fCDqny; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6AFC21F7D3
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Nov 2025 21:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763156789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1HJG54SDhcv/qlaIY601YmHrzFRTqYjY2LBekTUuj48=;
	b=WORq8Zvqo1u2/O59L+YaJAeLYWEyFnXW0xESFfPUQnTYpD8rGiZbf/W3UYrfr1yt9ZxdJg
	yR1y9dDI54l1mmL7aLdgczdZyg8Xm6C6KzKhjSy8TVQnuaNjgjgybMZGj9Q+2tZlNWhe5r
	en7AFTh4f9APdMHeVOoeWnfbUE2sifs=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763156788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1HJG54SDhcv/qlaIY601YmHrzFRTqYjY2LBekTUuj48=;
	b=L7fCDqnyoLcZkJ2eKw/iBSGLVcjlPHNXM/fQsURsYop28JHw9WKsJAAhi4QY91HZC3DWam
	QWzR6wczNk80TDHfM42xUt51T8A1rkLDm4vDt+vHQUIymzankbcM4aLONVSQSaVq3Drgub
	+X3L74s4RMYLWwkcvxyzG/3PbR3of6w=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A72B63EA61
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Nov 2025 21:46:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YLY9GjOjF2l/FQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Nov 2025 21:46:27 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: check: add repair ability for missing orphan root item
Date: Sat, 15 Nov 2025 08:15:59 +1030
Message-ID: <6511d4175e77e7f9cd11e074c4e06bd745ff4568.1763156743.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1763156743.git.wqu@suse.com>
References: <cover.1763156743.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

There is a known bug in older kernels that orphan items can be missing
for dropped subvolumes.

This makes those subvolumes unable to be removed on the next mount, and
recent kernel commit 4289b494ac55 ("btrfs: do not allow relocation of
partially dropped subvolumes") introduced one extra safe net to catch
such problem.

But unfortunately there is no way to repair it.

Add the repair ability to both the original and lowmem modes.

Link: https://lore.kernel.org/linux-btrfs/01f8b560-fb57-4861-8382-141c39655478@gmx.com/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c        |  5 +++++
 check/mode-common.c | 33 +++++++++++++++++++++++++++++++++
 check/mode-common.h |  1 +
 check/mode-lowmem.c | 13 ++++++++++---
 4 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/check/main.c b/check/main.c
index 77458a769028..db055ae194f8 100644
--- a/check/main.c
+++ b/check/main.c
@@ -3550,6 +3550,11 @@ static int check_root_refs(struct btrfs_root *root,
 				 */
 				if (!rec->found_root_item)
 					continue;
+				if (opt_check_repair) {
+					ret = repair_subvol_orphan_item(gfs_info, rec->objectid);
+					if (!ret)
+						continue;
+				}
 				errors++;
 				fprintf(stderr, "fs tree %llu missing orphan item\n", rec->objectid);
 			}
diff --git a/check/mode-common.c b/check/mode-common.c
index 0467ba28395e..2d11a96dfb7e 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -1672,3 +1672,36 @@ int check_and_repair_super_num_devs(struct btrfs_fs_info *fs_info)
 	printf("Successfully reset super num devices to %u\n", found_devs);
 	return 0;
 }
+
+int repair_subvol_orphan_item(struct btrfs_fs_info *fs_info, u64 rootid)
+{
+	struct btrfs_root *tree_root = fs_info->tree_root;
+	struct btrfs_trans_handle *trans;
+	struct btrfs_path path = { 0 };
+	int ret;
+
+	trans = btrfs_start_transaction(tree_root, 1);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		errno = -ret;
+		error_msg(ERROR_MSG_START_TRANS, "%m");
+		return ret;
+	}
+	ret = btrfs_add_orphan_item(trans, tree_root, &path, rootid);
+	btrfs_release_path(&path);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to insert orphan item for subvolume %llu: %m", rootid);
+		btrfs_abort_transaction(trans, ret);
+		btrfs_commit_transaction(trans, tree_root);
+		return ret;
+	}
+	ret = btrfs_commit_transaction(trans, tree_root);
+	if (ret < 0) {
+		errno = -ret;
+		error_msg(ERROR_MSG_COMMIT_TRANS, "%m");
+		return ret;
+	}
+	printf("Added back missing orphan item for subvolume %llu\n", rootid);
+	return 0;
+}
diff --git a/check/mode-common.h b/check/mode-common.h
index c37b4dc00e54..e97835a5b6a3 100644
--- a/check/mode-common.h
+++ b/check/mode-common.h
@@ -197,5 +197,6 @@ int repair_dev_item_bytes_used(struct btrfs_fs_info *fs_info,
 int fill_csum_tree(struct btrfs_trans_handle *trans, bool search_fs_tree);
 
 int check_and_repair_super_num_devs(struct btrfs_fs_info *fs_info);
+int repair_subvol_orphan_item(struct btrfs_fs_info *fs_info, u64 rootid);
 
 #endif
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 363dc4ae1904..ea4d4017827f 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -5569,9 +5569,16 @@ static int check_btrfs_root(struct btrfs_root *root, int check_all)
 	 * If this tree is a subvolume (not a reloc tree) and has no refs, there
 	 * should be an orphan item for it, or this subvolume will never be deleted.
 	 */
-	if (btrfs_root_refs(root_item) == 0 && is_fstree(btrfs_root_id(root))) {
-		if (!has_orphan_item(root->fs_info->tree_root,
-				     btrfs_root_id(root))) {
+	if (btrfs_root_refs(root_item) == 0 && is_fstree(btrfs_root_id(root)) &&
+	    !has_orphan_item(root->fs_info->tree_root, btrfs_root_id(root))) {
+		bool repaired = false;
+
+		if (opt_check_repair) {
+			ret = repair_subvol_orphan_item(root->fs_info, btrfs_root_id(root));
+			if (!ret)
+				repaired = true;
+		}
+		if (!repaired) {
 			error("missing orphan item for root %lld", btrfs_root_id(root));
 			err |= REFERENCER_MISSING;
 		}
-- 
2.51.2


