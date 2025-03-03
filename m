Return-Path: <linux-btrfs+bounces-11982-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C26A4C3EA
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 15:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFE9C168D6E
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 14:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FC8213E6D;
	Mon,  3 Mar 2025 14:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YGGHKAsM";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YGGHKAsM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E123202F9F
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Mar 2025 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741013731; cv=none; b=VJ3Qld3OzvAKsILnDpDxssuYaVD6j550BvuafHWRdlNbDInIRHB49bwAdUJloDPpm3tVmznz8cj7jzrgHtXI+WY5+xrwn76nNUStImF/KK2Foh0HzAxx/OEKLLtMXNXylNzWPWO/a/MtoDo6czAxaOXabkN+uKsRNbJNLMT2tS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741013731; c=relaxed/simple;
	bh=nmefiIzwpfQN/tNMP4/KfidpW3ONn/u6Ejq0/4GGdPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZrRZs98J0AJa6D8aV7AtXw7GRFc0mEHbM4tyLkBDKO1+4hjaI5EbFUYx2voO8oloAFf/dSdZ7JH9bcRzKk7zq/mpXpBAjezlJVf6hndaBJq+763JfCI1g6s+hiCAYraJ6Y6yXrSn+vh/kCXnv35Xwfxt0xKQ+zkdWvk/ohJlsv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YGGHKAsM; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YGGHKAsM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 28AD521182;
	Mon,  3 Mar 2025 14:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741013724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5tVvMexWDJ6lBVK1LOMko762swICCJIFQrsoLnatN3I=;
	b=YGGHKAsMJtqscuRGu2LoBO+nDheKoEExGHcCepdAta2rJCWJNAwsMk44RboYN2dAnLQC1h
	3CwSkHHxNNwLgs5KiRBxQpk/xJfAnneYyepFF3JGnQ3IUvnW7jI9qK2wQYYYsOQgJOjCrZ
	QDuARCQCySSU4/eEcXbe16xXiAsi9/Y=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=YGGHKAsM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741013724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5tVvMexWDJ6lBVK1LOMko762swICCJIFQrsoLnatN3I=;
	b=YGGHKAsMJtqscuRGu2LoBO+nDheKoEExGHcCepdAta2rJCWJNAwsMk44RboYN2dAnLQC1h
	3CwSkHHxNNwLgs5KiRBxQpk/xJfAnneYyepFF3JGnQ3IUvnW7jI9qK2wQYYYsOQgJOjCrZ
	QDuARCQCySSU4/eEcXbe16xXiAsi9/Y=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 225E013939;
	Mon,  3 Mar 2025 14:55:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MgpiCNzCxWc3AwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 03 Mar 2025 14:55:24 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 3/7] btrfs: pass root pointers to search tree ioctl helpers
Date: Mon,  3 Mar 2025 15:55:23 +0100
Message-ID: <1e0bdcdae376d8ed2e0e303daf62701848bc7cbd.1741012265.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1741012265.git.dsterba@suse.com>
References: <cover.1741012265.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 28AD521182
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

The search tree ioctl use btrfs_root so change that from btrfs_inode
pointers so we don't have to do the conversion.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ioctl.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 124f104d31b1..74de458b6496 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1605,13 +1605,12 @@ static noinline int copy_to_sk(struct btrfs_path *path,
 	return ret;
 }
 
-static noinline int search_ioctl(struct inode *inode,
+static noinline int search_ioctl(struct btrfs_root *root,
 				 struct btrfs_ioctl_search_key *sk,
 				 u64 *buf_size,
 				 char __user *ubuf)
 {
-	struct btrfs_fs_info *info = inode_to_fs_info(inode);
-	struct btrfs_root *root;
+	struct btrfs_fs_info *info = root->fs_info;
 	struct btrfs_key key;
 	struct btrfs_path *path;
 	int ret;
@@ -1628,9 +1627,10 @@ static noinline int search_ioctl(struct inode *inode,
 		return -ENOMEM;
 
 	if (sk->tree_id == 0) {
-		/* search the root of the inode that was passed */
-		root = btrfs_grab_root(BTRFS_I(inode)->root);
+		/* Search the root that we got passed. */
+		root = btrfs_grab_root(root);
 	} else {
+		/* Look up the root from the arguments. */
 		root = btrfs_get_fs_root(info, sk->tree_id, true);
 		if (IS_ERR(root)) {
 			btrfs_free_path(path);
@@ -1674,7 +1674,7 @@ static noinline int search_ioctl(struct inode *inode,
 	return ret;
 }
 
-static noinline int btrfs_ioctl_tree_search(struct inode *inode,
+static noinline int btrfs_ioctl_tree_search(struct btrfs_root *root,
 					    void __user *argp)
 {
 	struct btrfs_ioctl_search_args __user *uargs = argp;
@@ -1690,7 +1690,7 @@ static noinline int btrfs_ioctl_tree_search(struct inode *inode,
 
 	buf_size = sizeof(uargs->buf);
 
-	ret = search_ioctl(inode, &sk, &buf_size, uargs->buf);
+	ret = search_ioctl(root, &sk, &buf_size, uargs->buf);
 
 	/*
 	 * In the origin implementation an overflow is handled by returning a
@@ -1704,7 +1704,7 @@ static noinline int btrfs_ioctl_tree_search(struct inode *inode,
 	return ret;
 }
 
-static noinline int btrfs_ioctl_tree_search_v2(struct inode *inode,
+static noinline int btrfs_ioctl_tree_search_v2(struct btrfs_root *root,
 					       void __user *argp)
 {
 	struct btrfs_ioctl_search_args_v2 __user *uarg = argp;
@@ -1726,7 +1726,7 @@ static noinline int btrfs_ioctl_tree_search_v2(struct inode *inode,
 	if (buf_size > buf_limit)
 		buf_size = buf_limit;
 
-	ret = search_ioctl(inode, &args.key, &buf_size,
+	ret = search_ioctl(root, &args.key, &buf_size,
 			   (char __user *)(&uarg->buf[0]));
 	if (ret == 0 && copy_to_user(&uarg->key, &args.key, sizeof(args.key)))
 		ret = -EFAULT;
@@ -5265,9 +5265,9 @@ long btrfs_ioctl(struct file *file, unsigned int
 	case BTRFS_IOC_DEV_INFO:
 		return btrfs_ioctl_dev_info(fs_info, argp);
 	case BTRFS_IOC_TREE_SEARCH:
-		return btrfs_ioctl_tree_search(inode, argp);
+		return btrfs_ioctl_tree_search(root, argp);
 	case BTRFS_IOC_TREE_SEARCH_V2:
-		return btrfs_ioctl_tree_search_v2(inode, argp);
+		return btrfs_ioctl_tree_search_v2(root, argp);
 	case BTRFS_IOC_INO_LOOKUP:
 		return btrfs_ioctl_ino_lookup(root, argp);
 	case BTRFS_IOC_INO_PATHS:
-- 
2.47.1


