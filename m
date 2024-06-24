Return-Path: <linux-btrfs+bounces-5936-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8C2915396
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 18:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E87C1C22F59
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 16:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4922E19DFA6;
	Mon, 24 Jun 2024 16:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="amIDUhta";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="amIDUhta"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C692619E839
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 16:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246214; cv=none; b=fe4XpxEFc/i9te8/idStLMv9CwnxXCmraaP2ubDIUs2XhAqOwXgs+8lVt658awSD1g7NNC8fB+rqx42OBmhSyl1l+7HYG0FB12fVJ12XNmQH4WFxlHFF9Gd4SqRthFcXO479g3pNJJn5r2mnvazxs+tLjQw6Wpw/WFs+ubjpVb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246214; c=relaxed/simple;
	bh=jyx1V2QM7pqrJzC3D/UFnMoNepIaLYJcLKmJesSTIT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O++PLcHzdh0MXwa4Yy+87bqAXWY+Wt6RSU6OOk5EWV+4ydN3KyXrAojgNXQrkd0qU2XJgu4WOwue+EZe4aDEn03Ayv4+d6DtD4CkViDiyGi32EPPREd5dCBe7BWXfF/9e7klw4mkkaZWDnamutOkhs2VELP6toLqcNjNUAZhpyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=amIDUhta; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=amIDUhta; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4A97F1F7A4;
	Mon, 24 Jun 2024 16:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719246211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OFTVegAZEU+a9jGNADbtbiHYLovRM8EfHhRNyxHQULk=;
	b=amIDUhta2bZoYTZ6THRUeMsDkIgSa+gJl/kEm1p92TX5dEB+Xj5oMleRa7UUyDLQzLU2nx
	uR9VY/Pld2KKXjhj6ZRstFZzZf1Odbo6gE/Pr5o5gCmlEU2dPQoPVm9M5xgffChGsY/qCI
	FmZW4EPtJkg9BeOZzsyIoCqPrm0/hIk=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719246211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OFTVegAZEU+a9jGNADbtbiHYLovRM8EfHhRNyxHQULk=;
	b=amIDUhta2bZoYTZ6THRUeMsDkIgSa+gJl/kEm1p92TX5dEB+Xj5oMleRa7UUyDLQzLU2nx
	uR9VY/Pld2KKXjhj6ZRstFZzZf1Odbo6gE/Pr5o5gCmlEU2dPQoPVm9M5xgffChGsY/qCI
	FmZW4EPtJkg9BeOZzsyIoCqPrm0/hIk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 447611384C;
	Mon, 24 Jun 2024 16:23:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4Ne0EIOdeWYCLgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 24 Jun 2024 16:23:31 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 11/11] btrfs: pass a btrfs_inode to btrfs_inode_inherit_props()
Date: Mon, 24 Jun 2024 18:23:31 +0200
Message-ID: <4947f99671d0566173d3285d3b559bdf8990c078.1719246104.git.dsterba@suse.com>
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
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spam-Flag: NO
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

Pass a struct btrfs_inode to btrfs_inode_inherit_props() as it's an
internal interface, allowing to remove some use of BTRFS_I.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c |  4 ++--
 fs/btrfs/props.c | 23 +++++++++++------------
 fs/btrfs/props.h |  4 ++--
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ed0275cee649..e50f97c138f6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6406,11 +6406,11 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 		if (IS_ERR(parent)) {
 			ret = PTR_ERR(parent);
 		} else {
-			ret = btrfs_inode_inherit_props(trans, inode, parent);
+			ret = btrfs_inode_inherit_props(trans, BTRFS_I(inode), BTRFS_I(parent));
 			iput(parent);
 		}
 	} else {
-		ret = btrfs_inode_inherit_props(trans, inode, dir);
+		ret = btrfs_inode_inherit_props(trans, BTRFS_I(inode), BTRFS_I(dir));
 	}
 	if (ret) {
 		btrfs_err(fs_info,
diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index f6dba783d66b..5f805703aedc 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -385,16 +385,16 @@ static struct prop_handler prop_handlers[] = {
 };
 
 int btrfs_inode_inherit_props(struct btrfs_trans_handle *trans,
-			      struct inode *inode, const struct inode *parent)
+			      struct btrfs_inode *inode,
+			      const struct btrfs_inode *parent)
 {
-	struct btrfs_root *root = BTRFS_I(inode)->root;
+	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	int ret;
 	int i;
 	bool need_reserve = false;
 
-	if (!test_bit(BTRFS_INODE_HAS_PROPS,
-		      &BTRFS_I(parent)->runtime_flags))
+	if (!test_bit(BTRFS_INODE_HAS_PROPS, &parent->runtime_flags))
 		return 0;
 
 	for (i = 0; i < ARRAY_SIZE(prop_handlers); i++) {
@@ -405,10 +405,10 @@ int btrfs_inode_inherit_props(struct btrfs_trans_handle *trans,
 		if (!h->inheritable)
 			continue;
 
-		if (h->ignore(BTRFS_I(inode)))
+		if (h->ignore(inode))
 			continue;
 
-		value = h->extract(parent);
+		value = h->extract(&parent->vfs_inode);
 		if (!value)
 			continue;
 
@@ -416,7 +416,7 @@ int btrfs_inode_inherit_props(struct btrfs_trans_handle *trans,
 		 * This is not strictly necessary as the property should be
 		 * valid, but in case it isn't, don't propagate it further.
 		 */
-		ret = h->validate(BTRFS_I(inode), value, strlen(value));
+		ret = h->validate(inode, value, strlen(value));
 		if (ret)
 			continue;
 
@@ -436,16 +436,15 @@ int btrfs_inode_inherit_props(struct btrfs_trans_handle *trans,
 				return ret;
 		}
 
-		ret = btrfs_setxattr(trans, inode, h->xattr_name, value,
+		ret = btrfs_setxattr(trans, &inode->vfs_inode, h->xattr_name, value,
 				     strlen(value), 0);
 		if (!ret) {
-			ret = h->apply(inode, value, strlen(value));
+			ret = h->apply(&inode->vfs_inode, value, strlen(value));
 			if (ret)
-				btrfs_setxattr(trans, inode, h->xattr_name,
+				btrfs_setxattr(trans, &inode->vfs_inode, h->xattr_name,
 					       NULL, 0, 0);
 			else
-				set_bit(BTRFS_INODE_HAS_PROPS,
-					&BTRFS_I(inode)->runtime_flags);
+				set_bit(BTRFS_INODE_HAS_PROPS, &inode->runtime_flags);
 		}
 
 		if (need_reserve) {
diff --git a/fs/btrfs/props.h b/fs/btrfs/props.h
index 4f401e890db8..6e12cb1d24da 100644
--- a/fs/btrfs/props.h
+++ b/fs/btrfs/props.h
@@ -25,7 +25,7 @@ bool btrfs_ignore_prop(const struct btrfs_inode *inode, const char *name);
 int btrfs_load_inode_props(struct btrfs_inode *inode, struct btrfs_path *path);
 
 int btrfs_inode_inherit_props(struct btrfs_trans_handle *trans,
-			      struct inode *inode,
-			      const struct inode *dir);
+			      struct btrfs_inode *inode,
+			      const struct btrfs_inode *dir);
 
 #endif
-- 
2.45.0


