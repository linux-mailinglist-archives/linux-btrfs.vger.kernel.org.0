Return-Path: <linux-btrfs+bounces-11859-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1B8A45AC1
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 10:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12CB53A5EEB
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 09:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A8A270EDE;
	Wed, 26 Feb 2025 09:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="O/IGuw1Z";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VVFQoN8e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66E224DFF2
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 09:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563516; cv=none; b=NPS1Kmkri2bfrkDU58Amg6Vj6pEUkxDfvokviGHwNE+WWc8GoMCNFvM7ci7Crf4bmRQ7umrk3ah++xTchGeZ9iXUkYr5TCOvW218oAoOsR4PL2YAaabC1uqhy0S33mvxMFMtneJyjkFWVvj630miAREeuoUfcePxIlHkTGb3arU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563516; c=relaxed/simple;
	bh=OSvKa6ldCrYaThj2Vs66K4fowBbNwP1sLZeOC8KaeSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7OwJRw3hVrK1GvNz7Cr+7fDKQQIMjf2Tm+lZG2Z7pIy3zRKf56DuVtLHpeihY60u+x4ohhF21oLc3pkT/8IdDzihANEzBlBiG0dbWX5GUrprngikUqxQbHoJfDKiJkGBBK3BUygYLxqAMX46g9MtsLn44TBNdgthuvGtka1Vbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=O/IGuw1Z; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VVFQoN8e; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DF3DE2118E;
	Wed, 26 Feb 2025 09:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8CulcJzd52gW0vX+Rg5Bly4ecMcxOvpziv7u9A5dY6M=;
	b=O/IGuw1ZdDYlxIfqwkJ5e8mpk+3hvctGOce9H8cOSZHJxoEdOakZD4qVFyBzbAZWJt8Cq1
	6HrPYH1vhjhEYGqN5H7QJW1EkIFkzrsZv0m1B3Cut5vU0TpS+c7hkkU/3pIV3/NtdKY9EO
	g2eFi+9FAYhfHkRZvihFaeZWAuB+T0Q=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=VVFQoN8e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8CulcJzd52gW0vX+Rg5Bly4ecMcxOvpziv7u9A5dY6M=;
	b=VVFQoN8eey574aGeoscptnjDZ0e/gHqUafFoNrjN3cqpD1oyoVKD3L8swbtIH99qif/xkV
	yCTigt5K8HyWJe1F0ZIgDxGluzVHuGLKzQ+Q3CH/enQrp+WXzw3XFtNlabF7p4JfZbA/V+
	feUrW0Q0T5XmXYaPR/VLlNxxeBqkV4A=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8BBF13A53;
	Wed, 26 Feb 2025 09:51:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zlDnNDjkvmd1YgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 26 Feb 2025 09:51:52 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 25/27] btrfs: use BTRFS_PATH_AUTO_FREE in populate_free_space_tree()
Date: Wed, 26 Feb 2025 10:51:48 +0100
Message-ID: <a99a384d4b63007dd1be265644549700ed63c583.1740562070.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1740562070.git.dsterba@suse.com>
References: <cover.1740562070.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DF3DE2118E
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
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
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

This is the trivial pattern for path auto free, initialize at the
beginning and free at the end with simple goto -> return conversions.
This applies to both path and path2.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/free-space-tree.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index cae540ec15ed..d1ec02d5e1f6 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1062,7 +1062,8 @@ static int populate_free_space_tree(struct btrfs_trans_handle *trans,
 				    struct btrfs_block_group *block_group)
 {
 	struct btrfs_root *extent_root;
-	struct btrfs_path *path, *path2;
+	BTRFS_PATH_AUTO_FREE(path);
+	BTRFS_PATH_AUTO_FREE(path2);
 	struct btrfs_key key;
 	u64 start, end;
 	int ret;
@@ -1070,17 +1071,16 @@ static int populate_free_space_tree(struct btrfs_trans_handle *trans,
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
-	path->reada = READA_FORWARD;
 
 	path2 = btrfs_alloc_path();
-	if (!path2) {
-		btrfs_free_path(path);
+	if (!path2)
 		return -ENOMEM;
-	}
+
+	path->reada = READA_FORWARD;
 
 	ret = add_new_free_space_info(trans, block_group, path2);
 	if (ret)
-		goto out;
+		return ret;
 
 	mutex_lock(&block_group->free_space_lock);
 
@@ -1146,9 +1146,7 @@ static int populate_free_space_tree(struct btrfs_trans_handle *trans,
 	ret = 0;
 out_locked:
 	mutex_unlock(&block_group->free_space_lock);
-out:
-	btrfs_free_path(path2);
-	btrfs_free_path(path);
+
 	return ret;
 }
 
-- 
2.47.1


