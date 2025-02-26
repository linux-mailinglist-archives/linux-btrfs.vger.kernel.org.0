Return-Path: <linux-btrfs+bounces-11851-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DECA45AB5
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 10:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED88718954FC
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 09:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E02E26E62F;
	Wed, 26 Feb 2025 09:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XuNvo0Db";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UFB9Hzs/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426342459E4
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 09:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563490; cv=none; b=GWQMNtTWp5AGFKE1WvABYQskL6xCQteMAGbHWla4MwvUxBdRF4vZyJwll9mdGAvXjynCrfk6VI0Mq6o42JcKZHZEhpm4rq5Ka1yUFziWwDUIf/6Bfb4f53mbsaqbtaiAIBEdlijDG9D9ApnLkqs15sR7kk9Ra9uxYPhUlTHeEQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563490; c=relaxed/simple;
	bh=lhgGfXm/Re1yMlptSzsOjOFiLuikqDkBdd0MeRm61/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bI5F+DuRnASvKtZAfDbBjG9whHCvRjfuXMZ59/dvUITlLlwxSKr8/6dB2w8qrpKrjh5SiSrR9riwe8KAVOAOYet8XiKTIJO96K4yIDgWw2Cp3ZTaNrlUkPwWpiowyjEbCK2zeXMEnIUTjH6GCKdce4QGK6VXi9TVuwk6AKm5uCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XuNvo0Db; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UFB9Hzs/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F35252116B;
	Wed, 26 Feb 2025 09:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0leqhUpk8hGWINSG19wYMQT7YqaqsDog1fJ/QD2cIOg=;
	b=XuNvo0DbHJ+OswFtnKCE6PUHvSWQXlPOc2YvL0T//SiJRwGCF6WS+uH2k4ohYb6l+C1PnQ
	Oh9SW6k5sklQ69byJIEte7//oifFDUgM/dqz9JmkUX9YjjjdqBtj0lBJUEASCI5kxLCkZ7
	uWc/mttS1w6TgB42oIdvch/4LMBKJ58=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0leqhUpk8hGWINSG19wYMQT7YqaqsDog1fJ/QD2cIOg=;
	b=UFB9Hzs/ztrYrgtCpg6vmk+Nh61u4tkDwjUCoLflmsMcOHrN1ibgYKDEy/uaFBxj3pqKG+
	aPMlIK16x4nfUmnV1/LzfIzBOaAjyE0BZC53cm8wATsX3neYO/J7BqL2TcC8RzSLYeaKdX
	+PJrZksykoH2q8G7MdTmYsN31gTBi80=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECAC013A53;
	Wed, 26 Feb 2025 09:51:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hMPFORjkvmc4YgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 26 Feb 2025 09:51:20 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 15/27] btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_lookup_data_extent()
Date: Wed, 26 Feb 2025 10:51:20 +0100
Message-ID: <85d7977ce027c087d8a43a19ba89736602fa19c0.1740562070.git.dsterba@suse.com>
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
beginning and free at the end.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-tree.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 4a6036e7fa83..e62ab4eaa6ff 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -70,9 +70,8 @@ static int block_group_bits(struct btrfs_block_group *cache, u64 bits)
 int btrfs_lookup_data_extent(struct btrfs_fs_info *fs_info, u64 start, u64 len)
 {
 	struct btrfs_root *root = btrfs_extent_root(fs_info, start);
-	int ret;
 	struct btrfs_key key;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -81,9 +80,7 @@ int btrfs_lookup_data_extent(struct btrfs_fs_info *fs_info, u64 start, u64 len)
 	key.objectid = start;
 	key.type = BTRFS_EXTENT_ITEM_KEY;
 	key.offset = len;
-	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	btrfs_free_path(path);
-	return ret;
+	return btrfs_search_slot(NULL, root, &key, path, 0, 0);
 }
 
 /*
-- 
2.47.1


