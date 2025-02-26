Return-Path: <linux-btrfs+bounces-11843-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5222DA45A9B
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 10:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AFB33ACB99
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 09:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BBF2459DF;
	Wed, 26 Feb 2025 09:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Y9ZTMlXa";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Y9ZTMlXa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B994E2459D1
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 09:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563458; cv=none; b=HuWiLN/9oSJAK8OMGYo3e9QeuUs8pfkPRJ+GJn1VVxcoaA84aPpvan6W38v2HZQSwv3su6a24Rob/9tZdNVRzGri+T64ObW+dbPOAWCzqavBKRqZLgoQXy+DoOw3JZeorKcUgFcRXCHrEAy1jVYXFcn630puqeiUM1I89LVFttA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563458; c=relaxed/simple;
	bh=Qv6t7j88P8ddgYygWNyBDXdtAvqXjIZi8U4yWzLy29g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mx5e2VGYN6phXjKqCahFk5mCCovqwFmkFXDBULBrRgJVG1P25ZYCjaswlJwHsNnj1H9n9pV5qFsDCLTCUg3WFIiWlwpvXlvb67ITVreYteb2csp0gNIB22z2BqUTFSeaGXrSREcqEWsNpxZmnuGUYFQTu0pGH5CBRfkGDzgXkQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Y9ZTMlXa; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Y9ZTMlXa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D19671F38D;
	Wed, 26 Feb 2025 09:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jYTy6mFNKKviHxfxYAN1SuiefFV0lZvliu+5dSSSjE0=;
	b=Y9ZTMlXaf13fPR2Eg+GouubihY93my6C1jSBRyO7/+dofBHStxSQOeDeFM468+/tj+URuR
	8/MN9WqwyuHWdQIsQjWb316QmYfZvttKPElXJ0f1dvmlPk9zDMGRFxTPKQIZB+Ye+F9MFF
	ZiK0nMKw1FXiYGvkfm74hoJS+ZA7+2I=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jYTy6mFNKKviHxfxYAN1SuiefFV0lZvliu+5dSSSjE0=;
	b=Y9ZTMlXaf13fPR2Eg+GouubihY93my6C1jSBRyO7/+dofBHStxSQOeDeFM468+/tj+URuR
	8/MN9WqwyuHWdQIsQjWb316QmYfZvttKPElXJ0f1dvmlPk9zDMGRFxTPKQIZB+Ye+F9MFF
	ZiK0nMKw1FXiYGvkfm74hoJS+ZA7+2I=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA0D313A53;
	Wed, 26 Feb 2025 09:50:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XG9GMfnjvmf9YQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 26 Feb 2025 09:50:49 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 02/27] btrfs: use BTRFS_PATH_AUTO_FREE in insert_dev_extent()
Date: Wed, 26 Feb 2025 10:50:49 +0100
Message-ID: <42157a2e72da246aba949b79914ff0750b6c2be4.1740562070.git.dsterba@suse.com>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
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
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

This is the trivial pattern for path auto free, initialize at the
beginning and free at the end with simple goto -> return conversions.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/block-group.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index cd20bf9289bd..9c689e7982c2 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2640,7 +2640,7 @@ static int insert_dev_extent(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = device->fs_info;
 	struct btrfs_root *root = fs_info->dev_root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_dev_extent *extent;
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
@@ -2657,7 +2657,7 @@ static int insert_dev_extent(struct btrfs_trans_handle *trans,
 	key.offset = start;
 	ret = btrfs_insert_empty_item(trans, root, path, &key, sizeof(*extent));
 	if (ret)
-		goto out;
+		return ret;
 
 	leaf = path->nodes[0];
 	extent = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_dev_extent);
@@ -2665,10 +2665,8 @@ static int insert_dev_extent(struct btrfs_trans_handle *trans,
 	btrfs_set_dev_extent_chunk_objectid(leaf, extent,
 					    BTRFS_FIRST_CHUNK_TREE_OBJECTID);
 	btrfs_set_dev_extent_chunk_offset(leaf, extent, chunk_offset);
-
 	btrfs_set_dev_extent_length(leaf, extent, num_bytes);
-out:
-	btrfs_free_path(path);
+
 	return ret;
 }
 
-- 
2.47.1


