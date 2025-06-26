Return-Path: <linux-btrfs+bounces-15003-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8A1AEA096
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 16:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFFD35A4FCB
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 14:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA362F1FF0;
	Thu, 26 Jun 2025 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vJ5gLPuA";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vJ5gLPuA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BBC2EA493
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Jun 2025 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750948227; cv=none; b=QDf7II95ya6JN0Bh9fAQXBbEwWkOEtdz8U24XJzxYKLLKzr5PkvO5jF28a+VtRcByCD+wkJWwBj1A9/bV56e8EyOTJcN5w6znKsruc1oEJ+mJX3jgRgBUXyHCNRoFR9s52goGQicA8BheeiieoGVm2tpAGxNC1xkYz6ecROv69Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750948227; c=relaxed/simple;
	bh=l6uWFuaKSaJXdz4QN52z1d74Ah35y6b8QnJrlLdHRqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3Me7nY1YxSuALHdrK7P/qA8231LuNYvcBuU1cb233/8l3bcemsxxs4BnL4Eg1AlZY3oiKv4lMmZFMvDFDzcJBLsJmoNoC+Qn26ia/hF8/7+FZABZDso8E7pWmBwhHUgTstbrWmt8fVmfkUPNRiVn/kMH4A2fUUnVD+kL7NsSD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=vJ5gLPuA; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=vJ5gLPuA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 39CDB1F395;
	Thu, 26 Jun 2025 14:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750948224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XzdQr7nblnm9zimIAV8iJQD6tt/Vy8EG/KcNb+Wiad0=;
	b=vJ5gLPuAwAUFKWZAfREKFfWx46KAFnKqn+TI1C1HOUAOyaIMykJq9tIbMuMXXs1MdRAmW7
	tnjVY46wxGZzLDpPxosNf+MqnuQ5xzNnbjU02fhwzr8HVJWO2VaF5ecUVJshviP8pSA2FW
	MXPVtIDMOo8c2RXI08qb+SW1fRyY6ck=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750948224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XzdQr7nblnm9zimIAV8iJQD6tt/Vy8EG/KcNb+Wiad0=;
	b=vJ5gLPuAwAUFKWZAfREKFfWx46KAFnKqn+TI1C1HOUAOyaIMykJq9tIbMuMXXs1MdRAmW7
	tnjVY46wxGZzLDpPxosNf+MqnuQ5xzNnbjU02fhwzr8HVJWO2VaF5ecUVJshviP8pSA2FW
	MXPVtIDMOo8c2RXI08qb+SW1fRyY6ck=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32753138A7;
	Thu, 26 Jun 2025 14:30:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9XpNDIBZXWgiLgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 26 Jun 2025 14:30:24 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 4/4] btrfs: rename inode number parameter passed to btrfs_check_dir_item_collision()
Date: Thu, 26 Jun 2025 16:30:12 +0200
Message-ID: <e2238a75fe08e6d51761f88f4f8072b3f47dc20a.1750948128.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750948128.git.dsterba@suse.com>
References: <cover.1750948128.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

The name 'dir' is misleading as it's the inode number of the directory,
so rename it accordingly.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/dir-item.c | 4 ++--
 fs/btrfs/dir-item.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index b29cc31a7c4a9d..69863e398e223f 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -227,7 +227,7 @@ struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
 	return di;
 }
 
-int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
+int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir_ino,
 				   const struct fscrypt_str *name)
 {
 	int ret;
@@ -242,7 +242,7 @@ int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
 	if (!path)
 		return -ENOMEM;
 
-	key.objectid = dir;
+	key.objectid = dir_ino;
 	key.type = BTRFS_DIR_ITEM_KEY;
 	key.offset = btrfs_name_hash(name->name, name->len);
 
diff --git a/fs/btrfs/dir-item.h b/fs/btrfs/dir-item.h
index 8462579a95f404..e52174a8baf92c 100644
--- a/fs/btrfs/dir-item.h
+++ b/fs/btrfs/dir-item.h
@@ -14,7 +14,7 @@ struct btrfs_inode;
 struct btrfs_root;
 struct btrfs_trans_handle;
 
-int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
+int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir_ino,
 			  const struct fscrypt_str *name);
 int btrfs_insert_dir_item(struct btrfs_trans_handle *trans,
 			  const struct fscrypt_str *name, struct btrfs_inode *dir,
-- 
2.49.0


