Return-Path: <linux-btrfs+bounces-11849-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE89FA45AAF
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 10:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54A57189522F
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 09:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A74F26D5B5;
	Wed, 26 Feb 2025 09:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="myRY8CuX";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="myRY8CuX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C222459E0
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 09:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563484; cv=none; b=OxTlRkn3PHGrGqjGIG6Pwq5iqqLYSdcwR1QjTe1XEuHCjWl7VZz18YOsM0s3Dmrou5DHZYVoNuUmSUyIDbP+gvET8lFyNxQjx+b59lPp9OozgpiM6xURVlWG4LklS2XYDh+Ou3W9nKm98fdbDVqjWBJ+HRm92vVGnfj07yYyUpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563484; c=relaxed/simple;
	bh=IVFI6aE96QAx/DdS5aM7gLOqD5A/2aMYqhPu1AMewyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZlbtrdt13NiAFT7HKmHh9h6Q5KOvc1M5tcb8yen9dN0vGcmebnGztM3RGUvP943M+ZIzf7YnjpJXzyfaxHakxi0EcfYUk55SAr3L2lKZsshjwdpRi+DvPa/ESAMBb/bBVUOMJieMSm1dmzvQXLSE2LUdYIRJ008TaXVxTg8Ihc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=myRY8CuX; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=myRY8CuX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 93D1221163;
	Wed, 26 Feb 2025 09:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H07PdzhT2j+vkvOvYwG8FG/H73nQVxhUOqe4RKrKNG4=;
	b=myRY8CuXEDYk1iYwdRXr/iD+y1f+4qBc3pM0jrrouNwwEiYUxYaZ+8uQWdjOuhFMVHstj0
	YIR8CHRqqVXftUC3FbTKDuazE7lLU3xrY6Kd0qtq/jmv8Ou3O6827r/DNX/ApbRxyquJkY
	ZZFURoJdpGWoPV58Mi8PkFN3ETmP3Ag=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H07PdzhT2j+vkvOvYwG8FG/H73nQVxhUOqe4RKrKNG4=;
	b=myRY8CuXEDYk1iYwdRXr/iD+y1f+4qBc3pM0jrrouNwwEiYUxYaZ+8uQWdjOuhFMVHstj0
	YIR8CHRqqVXftUC3FbTKDuazE7lLU3xrY6Kd0qtq/jmv8Ou3O6827r/DNX/ApbRxyquJkY
	ZZFURoJdpGWoPV58Mi8PkFN3ETmP3Ag=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D0F913A53;
	Wed, 26 Feb 2025 09:51:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id szdtIhbkvmc0YgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 26 Feb 2025 09:51:18 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 14/27] btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_get_name()
Date: Wed, 26 Feb 2025 10:51:18 +0100
Message-ID: <36c61f30ea6df6145eb92581dccff1b56b0c2139.1740562070.git.dsterba@suse.com>
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

s is the trivial pattern for path auto free, initialize at the beginning
and free at the end with some return simplifications.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/export.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index 0c0b8db82df6..a91eaf0ca34e 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -223,7 +223,7 @@ static int btrfs_get_name(struct dentry *parent, char *name,
 	struct btrfs_inode *dir = BTRFS_I(d_inode(parent));
 	struct btrfs_root *root = dir->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_inode_ref *iref;
 	struct btrfs_root_ref *rref;
 	struct extent_buffer *leaf;
@@ -255,15 +255,12 @@ static int btrfs_get_name(struct dentry *parent, char *name,
 
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0) {
-		btrfs_free_path(path);
 		return ret;
 	} else if (ret > 0) {
-		if (ino == BTRFS_FIRST_FREE_OBJECTID) {
+		if (ino == BTRFS_FIRST_FREE_OBJECTID)
 			path->slots[0]--;
-		} else {
-			btrfs_free_path(path);
+		else
 			return -ENOENT;
-		}
 	}
 	leaf = path->nodes[0];
 
@@ -280,7 +277,6 @@ static int btrfs_get_name(struct dentry *parent, char *name,
 	}
 
 	read_extent_buffer(leaf, name, name_ptr, name_len);
-	btrfs_free_path(path);
 
 	/*
 	 * have to add the null termination to make sure that reconnect_path
-- 
2.47.1


