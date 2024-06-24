Return-Path: <linux-btrfs+bounces-5935-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 225A1915395
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 18:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D137A28668E
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 16:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EF719EEA7;
	Mon, 24 Jun 2024 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FstCIoqI";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NbCzA7dK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC84A19DF72
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 16:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246213; cv=none; b=UInI/6bDQERRjnBLCu1HgNMmIB5WO0bCKkuiovGu8J6Lk8qtKaswUkqFi+4ZcmLMvtheRKMbwwq/daF6MJt1FP6grNEchLDMETqu9nXiLkn/j6Q3ySryUvWZk2GH7oyHj0CnI57YbFZXaxP+xdsqcDj+EaPp8jySau+Zn/XWfXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246213; c=relaxed/simple;
	bh=tMk9hY049RPe8D8kWy/YxP5JfkEAwZF2n0Dy746oNCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FNvdCT5rwaWUwQ1QsbmD0h9NWwvE0BFmZeAO0A4PtG17r75+uwjUIfIQth1kdTfyc9zwG6EnQk3GHRAwV7QHQtn6M5TpP3Mmg/81pjVABzL4FMpcUTFjDYDFR1ZmxGv51kFBdVSgrnRI0iQofHbp++4SJRZLBgPJ/r6F8o3oDyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FstCIoqI; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NbCzA7dK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E81A521A57;
	Mon, 24 Jun 2024 16:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719246209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mmU6DYd7htakX5/HsXSis6cg01iICKoWQLgPEiVw3/0=;
	b=FstCIoqIW9nCoz89NtO1fU/7tlNkF6r52ydIwJPZEGytMH3GJndYcr5xCBvMSWDjHN4QPf
	thmqrxL19DSrJEeRo9sH8q/pKgZz/4mZrJHU8tKQa92DyGqhjRThnfJEXcguW1659oX+4P
	gemgAlgUg743h2u0FPSr6M7WIphdwuI=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719246208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mmU6DYd7htakX5/HsXSis6cg01iICKoWQLgPEiVw3/0=;
	b=NbCzA7dKgMcxjQd3WoMYbYzueD9rsY+BHmPyhxuaYwjb/+27WiSX6oLCAEcQhoES90Q1ki
	A8yB7scl/NO+LfjiVyltbrEIb7sIPwJBievV9OFJkiyu5h+RBM0wd9cUIrqgXK218lgQ4r
	sVC4nFuiexi+UBPOeRlUhY0ZF27DRoY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E131E1384C;
	Mon, 24 Jun 2024 16:23:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ilr5NoCdeWb7LQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 24 Jun 2024 16:23:28 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 10/11] btrfs: pass a btrfs_inode to btrfs_load_inode_props()
Date: Mon, 24 Jun 2024 18:23:28 +0200
Message-ID: <2f83176d3fbdecdbe86df844b746d212422d4098.1719246104.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1719246104.git.dsterba@suse.com>
References: <cover.1719246104.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 

Pass a struct btrfs_inode to btrfs_load_inode_props() as it's an
internal interface, allowing to remove some use of BTRFS_I.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 2 +-
 fs/btrfs/props.c | 6 +++---
 fs/btrfs/props.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e9744392fe51..ed0275cee649 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3953,7 +3953,7 @@ static int btrfs_read_locked_inode(struct inode *inode,
 			btrfs_ino(BTRFS_I(inode)), &first_xattr_slot);
 	if (first_xattr_slot != -1) {
 		path->slots[0] = first_xattr_slot;
-		ret = btrfs_load_inode_props(inode, path);
+		ret = btrfs_load_inode_props(BTRFS_I(inode), path);
 		if (ret)
 			btrfs_err(fs_info,
 				  "error loading props for ino %llu (root %llu): %d",
diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index b8fa34e16abb..f6dba783d66b 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -273,10 +273,10 @@ static void inode_prop_iterator(void *ctx,
 		set_bit(BTRFS_INODE_HAS_PROPS, &BTRFS_I(inode)->runtime_flags);
 }
 
-int btrfs_load_inode_props(struct inode *inode, struct btrfs_path *path)
+int btrfs_load_inode_props(struct btrfs_inode *inode, struct btrfs_path *path)
 {
-	struct btrfs_root *root = BTRFS_I(inode)->root;
-	u64 ino = btrfs_ino(BTRFS_I(inode));
+	struct btrfs_root *root = inode->root;
+	u64 ino = btrfs_ino(inode);
 
 	return iterate_object_props(root, path, ino, inode_prop_iterator, inode);
 }
diff --git a/fs/btrfs/props.h b/fs/btrfs/props.h
index 63546d0a9444..4f401e890db8 100644
--- a/fs/btrfs/props.h
+++ b/fs/btrfs/props.h
@@ -22,7 +22,7 @@ int btrfs_validate_prop(const struct btrfs_inode *inode, const char *name,
 			const char *value, size_t value_len);
 bool btrfs_ignore_prop(const struct btrfs_inode *inode, const char *name);
 
-int btrfs_load_inode_props(struct inode *inode, struct btrfs_path *path);
+int btrfs_load_inode_props(struct btrfs_inode *inode, struct btrfs_path *path);
 
 int btrfs_inode_inherit_props(struct btrfs_trans_handle *trans,
 			      struct inode *inode,
-- 
2.45.0


