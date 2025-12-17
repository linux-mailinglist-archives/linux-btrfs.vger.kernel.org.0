Return-Path: <linux-btrfs+bounces-19822-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EADCC693C
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 09:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FD19311A1E2
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 08:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0445339853;
	Wed, 17 Dec 2025 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VBCZ1puR";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VBCZ1puR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A27274B28
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 08:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765958911; cv=none; b=Ho0wrcoQDF5YCO7j5/EQnO/rork96k5UPbVuKayaBY/yyxtvBZY2wpNOR6nG2b6xtRNnDUdmPpLEWe9lgPaeCU9VfX5XAympSzfP6nDo6uj3Ut2NBXE8tW66c6FyMejazSE3aSoIh9x7wwQvaabcCIWVlHte5Alflx5C3MkOY7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765958911; c=relaxed/simple;
	bh=M3uJBoIy6XGq+OrT0AglAltVJvXOQaZ6jYPOD4Lh5B8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BW5D0IwhiuLV7PSUG66EKN+PMdQtxqVsE30PvTn8wtL4DiNhWcS6EHK25Ce2aeGs7gOzzgFzvN0HHgZWQvv1IXUPUl3kIb+ohsplTzFRttfOySeQHbYtS8qVwKYTUlDg0XIrB4fIdasv7FXspzMhfinFwI4Bs9hBcwBQciKiOcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VBCZ1puR; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VBCZ1puR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B2323336C2
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 08:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765958900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1NDuwHvLjaqv7S7LWZssfbEg0WroWcPibN/exEZWG4A=;
	b=VBCZ1puROt7MjAvqpfmKuZbn56MekSorFiE8+Ezcy7k3xkmBGJXG5mNtUWAZ1yI325OIne
	UB4YonYnayF6Nrtpk31x3ZnGcuTE4iQluoEiA8qSdM0L8psocO6WTeNEuzYS2947IHCJ1i
	qrkbd44vi6RomvB912KWCBlJYhuo2Ak=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765958900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1NDuwHvLjaqv7S7LWZssfbEg0WroWcPibN/exEZWG4A=;
	b=VBCZ1puROt7MjAvqpfmKuZbn56MekSorFiE8+Ezcy7k3xkmBGJXG5mNtUWAZ1yI325OIne
	UB4YonYnayF6Nrtpk31x3ZnGcuTE4iQluoEiA8qSdM0L8psocO6WTeNEuzYS2947IHCJ1i
	qrkbd44vi6RomvB912KWCBlJYhuo2Ak=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 028DB3EA63
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 08:08:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gKpRLvNkQmmoGQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 08:08:19 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: check/original: add dedicated missing INODE_REF repair
Date: Wed, 17 Dec 2025 18:38:13 +1030
Message-ID: <f918d7325772029501db8fc57d606cbe7450b41e.1765958753.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1765958753.git.wqu@suse.com>
References: <cover.1765958753.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.68 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	NEURAL_HAM_SHORT(-0.08)[-0.393];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.68

Currently if the original mode of btrfs-check hits a missing INODE_REF,
but with valid DIR_INDEX/DIR_ITEM, then it will repair it by deleting
the valid DIR_INDEX, which will just make things worse.

Add a dedicated repair for missing INODE_REF which will just add back
the missing INODE_REF, properly fixing the problem other than making it
worse.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/check/main.c b/check/main.c
index 96c7ef7d8261..880827e11ee7 100644
--- a/check/main.c
+++ b/check/main.c
@@ -2351,6 +2351,42 @@ static int create_inode_item(struct btrfs_root *root,
 	return 0;
 }
 
+static int create_inode_ref(struct btrfs_root *root,
+			    struct inode_record *i_rec,
+			    struct inode_backref *backref)
+{
+	struct btrfs_trans_handle *trans;
+	int ret;
+
+	trans = btrfs_start_transaction(root, 1);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		errno = -ret;
+		error_msg(ERROR_MSG_START_TRANS, "%m");
+		return ret;
+	}
+
+	ret = btrfs_insert_inode_ref(trans, root, backref->name, backref->namelen,
+				     i_rec->ino, backref->dir, backref->index);
+	if (ret < 0) {
+		btrfs_commit_transaction(trans, root);
+		return ret;
+	}
+	ret = btrfs_commit_transaction(trans, root);
+	if (ret < 0) {
+		ret = PTR_ERR(trans);
+		errno = -ret;
+		error_msg(ERROR_MSG_COMMIT_TRANS, "%m");
+		return ret;
+	}
+	backref->found_inode_ref = 1;
+	backref->errors &= ~REF_ERR_NO_INODE_REF;
+	printf("Added INODE_REF for root %lld ino %llu parent %llu index %llu name %.*s\n",
+		btrfs_root_id(root), i_rec->ino, backref->dir, backref->index,
+		backref->namelen, backref->name);
+	return 0;
+}
+
 static int repair_inode_backrefs(struct btrfs_root *root,
 				 struct inode_record *rec,
 				 struct cache_tree *inode_cache,
@@ -2375,6 +2411,21 @@ static int repair_inode_backrefs(struct btrfs_root *root,
 		if (rec->ino == root_dirid && backref->index == 0)
 			continue;
 
+		/*
+		 * Have DIR_INDEX, DIR_ITEM and INODE_ITEM, and even nlinks
+		 * matches with only missing INODE_REF.
+		 */
+		if (!backref->found_inode_ref && backref->found_dir_item &&
+		    backref->found_dir_index && rec->found_inode_item &&
+		    rec->found_link == rec->nlink) {
+			ret = create_inode_ref(root, rec, backref);
+			if (ret)
+				break;
+			repaired++;
+			list_del(&backref->list);
+			free(backref);
+			continue;
+		}
 		if (delete &&
 		    ((backref->found_dir_index && !backref->found_inode_ref) ||
 		     (backref->found_dir_index && backref->found_inode_ref &&
-- 
2.52.0


