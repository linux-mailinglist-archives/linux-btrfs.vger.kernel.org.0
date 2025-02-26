Return-Path: <linux-btrfs+bounces-11868-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D08FA45ACF
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 10:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083AA188733B
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 09:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588F824E009;
	Wed, 26 Feb 2025 09:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="c1LgipPF";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="c1LgipPF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6832459DE
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 09:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563562; cv=none; b=AlezVKnyaEdITgjQ8OecEQQ9BrV+k77vyZy3VXFpU9DOgDRxMDunNZqwCeLX+/bfq4zmihA5JGSp+hx/mIfcuMOqGu2pSakXNd14xucd2SSHvOgdPEutNgbybtjxHD3qmoraGjMXf42oi6iYpV7jxIipm2fiFxiNfKCQkXsxh6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563562; c=relaxed/simple;
	bh=IejPlqcGNj01wrnavBtbaIIgo/FiVMv9CFC3gDaIUZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IB3792IHjSJ5O/kRhSpt4lGQ+hQYHwe/rUJD2FNEla9MH37ydam2vNPYz73RIBW3rQ5LQZnSoMLJ/17W/HO0Pzb+ZYenwB9LWEy0GnwCdRdSsqIWdqVoQq9MhzG2yiRxN6rEZ/phXyK4ir42iGjvVZeef5kfHZjszsrewdfN2XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=c1LgipPF; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=c1LgipPF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4A6971F38A;
	Wed, 26 Feb 2025 09:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RQNoNU9NCwyg/luP9ZqfmH9Pexqae+5Zpx84b4IK7co=;
	b=c1LgipPFESP5q7fxEn71Iir/F9ltVh94tel/vfMoDl8RDRTqgL3mJhPKaQCSidgtFwY5CL
	oWLOfOfg9GO7z92EjM4usWI5YoJ6Q7TQK8OxEOBIH1qU9eF6iqFB0T4vUwsT7RbvHYPSdF
	U4Y50jOh1bbJKPQmRJEY1sPej8NsDh4=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=c1LgipPF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RQNoNU9NCwyg/luP9ZqfmH9Pexqae+5Zpx84b4IK7co=;
	b=c1LgipPFESP5q7fxEn71Iir/F9ltVh94tel/vfMoDl8RDRTqgL3mJhPKaQCSidgtFwY5CL
	oWLOfOfg9GO7z92EjM4usWI5YoJ6Q7TQK8OxEOBIH1qU9eF6iqFB0T4vUwsT7RbvHYPSdF
	U4Y50jOh1bbJKPQmRJEY1sPej8NsDh4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43B1113A53;
	Wed, 26 Feb 2025 09:51:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a8SFEDvkvmd+YgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 26 Feb 2025 09:51:55 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 26/27] btrfs: use BTRFS_PATH_AUTO_FREE in clear_free_space_tree()
Date: Wed, 26 Feb 2025 10:51:54 +0100
Message-ID: <4ba10c28bab36a1ea5fb3f75676539c749eda967.1740562070.git.dsterba@suse.com>
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
X-Rspamd-Queue-Id: 4A6971F38A
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
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

This is the trivial pattern for path auto free, initialize at the
beginning and free at the end with simple goto -> return conversions.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/free-space-tree.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index d1ec02d5e1f6..589ff73ed13a 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1215,7 +1215,7 @@ int btrfs_create_free_space_tree(struct btrfs_fs_info *fs_info)
 static int clear_free_space_tree(struct btrfs_trans_handle *trans,
 				 struct btrfs_root *root)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	int nr;
 	int ret;
@@ -1231,7 +1231,7 @@ static int clear_free_space_tree(struct btrfs_trans_handle *trans,
 	while (1) {
 		ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
 		if (ret < 0)
-			goto out;
+			return ret;
 
 		nr = btrfs_header_nritems(path->nodes[0]);
 		if (!nr)
@@ -1240,15 +1240,12 @@ static int clear_free_space_tree(struct btrfs_trans_handle *trans,
 		path->slots[0] = 0;
 		ret = btrfs_del_items(trans, root, path, 0, nr);
 		if (ret)
-			goto out;
+			return ret;
 
 		btrfs_release_path(path);
 	}
 
-	ret = 0;
-out:
-	btrfs_free_path(path);
-	return ret;
+	return 0;
 }
 
 int btrfs_delete_free_space_tree(struct btrfs_fs_info *fs_info)
-- 
2.47.1


