Return-Path: <linux-btrfs+bounces-5807-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5313490E2B8
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 07:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3130284373
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 05:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B8F57CBE;
	Wed, 19 Jun 2024 05:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rxeWbTV7";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EHBmTrd6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890A74C635
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 05:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718775245; cv=none; b=GdoMWb5QyKHNnNHzoMazEgt2eI8xukmz+F4ZOwVDQ1QjdlVM9W6FkFgqaVvwMQAWi/v6OPOow7aUaBXHGzfXJ6/oOD0OzxCPGX3PxMK9s2cLrxgXPi4hL3XOZJzfGWXyJWIeF+6YZ28SKNMdpsc0uHWM55jNc00rs1ODu+5M8Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718775245; c=relaxed/simple;
	bh=LWvNVaGthbYvI4yj3ghqWqZu/vYWrQ3wpV+A61DssWI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=huc9wERnaJHDIjIZ/oRBqLtGLDTfrMgk6IdTnJqVPlFWldWBdsWT14+ID8rISpMhYbYiG2Yg2bPEUG8M5FShLfxZHHyO7QNfJ/t1jsLc7c9zDja3y7n7qjm0BmC1gHWsSTE8vKQP+4nDjEP5a/v+nxwPeWqYJ3lEVQzED+F/Fvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rxeWbTV7; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EHBmTrd6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E4E2F21A2B
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 05:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718775242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OTpcAHvNRgz7hHOHyV971kpgK9P/XxuDK7599zOP8bk=;
	b=rxeWbTV7s7R3TMEgMqsrTZhixUoK8KO/GXb0+wwlbqkM6lrISqUWOdg3MIkuM9qHo+u2LS
	Sfw/U0u+5UoRphgE75SDz6iOC/G3ZYH0FGD0Ov3GJSILnU9N8xj95Buq977pEs+nfA2Iws
	+nO8wxnjBfJHHbVKSai8X0mzNneIep0=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=EHBmTrd6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718775241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OTpcAHvNRgz7hHOHyV971kpgK9P/XxuDK7599zOP8bk=;
	b=EHBmTrd6RGcWHnIWk5ilMBJpxWm0h9P3ts/+HlgxmOmYbyuXbz/W0XWJpAMRtvBodoqJ8m
	y8EaSMsuYoNAldtFZq4lXWR7xBkRINgYQwkNfd0xDGJUYSpEc47h1nZehy5mYYyh4pk0GX
	Z0xtbtUF1cvI9u/NDd60ejo/78519Zg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE80913AAF
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 05:34:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eM2gKMhtcmYUaQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 05:34:00 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs-progs: csum-change: add leaf based threshold
Date: Wed, 19 Jun 2024 15:03:38 +0930
Message-ID: <b21316d646aed69b1286938d5ad4fd043e87fc66.1718775066.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718775066.git.wqu@suse.com>
References: <cover.1718775066.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E4E2F21A2B
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

For "btrfstune --csum", currently we do the following operations in just
one transaction for each:

- Delete old data csums
- Change new data csums objectid

Both opeartion can modify up to GiB or even TiB level of metadata, doing
them in just one transaction is definitely going to cause problems.

This patch adds a leaf number based threshold (32 leaves), after
modifying/deleteing this many leaves, we commit a transaction to avoid
huge amount of dirty leaves piling up.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tune/change-csum.c | 68 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 52 insertions(+), 16 deletions(-)

diff --git a/tune/change-csum.c b/tune/change-csum.c
index 0f95cdb25533..66fdd207335c 100644
--- a/tune/change-csum.c
+++ b/tune/change-csum.c
@@ -371,29 +371,48 @@ static int generate_new_data_csums(struct btrfs_fs_info *fs_info, u16 new_csum_t
 	return generate_new_data_csums_range(fs_info, 0, new_csum_type);
 }
 
+/* After deleting/modifying this many leaves, commit a transaction. */
+#define CSUM_CHANGE_LEAVES_THRESHOLD	32
+
 static int delete_old_data_csums(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, 0);
-	struct btrfs_trans_handle *trans;
+	struct btrfs_trans_handle *trans = 0;
 	struct btrfs_path path = { 0 };
 	struct btrfs_key last_key;
+	unsigned int deleted_leaves = 0;
 	int ret;
 
 	last_key.objectid = BTRFS_EXTENT_CSUM_OBJECTID;
 	last_key.type = BTRFS_EXTENT_CSUM_KEY;
 	last_key.offset = (u64)-1;
 
-	trans = btrfs_start_transaction(csum_root, 1);
-	if (IS_ERR(trans)) {
-		ret = PTR_ERR(trans);
-		errno = -ret;
-		error("failed to start transaction to delete old data csums: %m");
-		return ret;
-	}
 	while (true) {
 		int start_slot;
 		int nr;
 
+		if (deleted_leaves >= CSUM_CHANGE_LEAVES_THRESHOLD) {
+			assert(trans);
+			ret = btrfs_commit_transaction(trans, csum_root);
+			if (ret < 0) {
+				errno = -ret;
+				error(
+		"failed to commit transaction to delete old data csums: %m");
+				return ret;
+			}
+			trans = NULL;
+			deleted_leaves = 0;
+		}
+		if (!trans) {
+			trans = btrfs_start_transaction(csum_root, 1);
+			if (IS_ERR(trans)) {
+				ret = PTR_ERR(trans);
+				errno = -ret;
+				error(
+		"failed to start transaction to delete old data csums: %m");
+				return ret;
+			}
+		}
 		ret = btrfs_search_slot(trans, csum_root, &last_key, &path, -1, 1);
 		if (ret < 0) {
 			errno = -ret;
@@ -428,6 +447,7 @@ static int delete_old_data_csums(struct btrfs_fs_info *fs_info)
 			break;
 		}
 		btrfs_release_path(&path);
+		deleted_leaves++;
 	}
 	btrfs_release_path(&path);
 	if (ret < 0)
@@ -445,9 +465,10 @@ static int delete_old_data_csums(struct btrfs_fs_info *fs_info)
 static int change_csum_objectids(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, 0);
-	struct btrfs_trans_handle *trans;
+	struct btrfs_trans_handle *trans = NULL;
 	struct btrfs_path path = { 0 };
 	struct btrfs_key last_key;
+	unsigned int changed_leaves = 0;
 	u64 super_flags;
 	int ret = 0;
 
@@ -455,17 +476,32 @@ static int change_csum_objectids(struct btrfs_fs_info *fs_info)
 	last_key.type = BTRFS_EXTENT_CSUM_KEY;
 	last_key.offset = (u64)-1;
 
-	trans = btrfs_start_transaction(csum_root, 1);
-	if (IS_ERR(trans)) {
-		ret = PTR_ERR(trans);
-		errno = -ret;
-		error("failed to start transaction to change csum objectids: %m");
-		return ret;
-	}
 	while (true) {
 		struct btrfs_key found_key;
 		int nr;
 
+		if (changed_leaves >= CSUM_CHANGE_LEAVES_THRESHOLD) {
+			assert(trans);
+			ret = btrfs_commit_transaction(trans, csum_root);
+			if (ret < 0) {
+				errno = -ret;
+				error(
+		"failed to commit transaction to change data csum objectid: %m");
+				return ret;
+			}
+			trans = NULL;
+			changed_leaves = 0;
+		}
+		if (!trans) {
+			trans = btrfs_start_transaction(csum_root, 1);
+			if (IS_ERR(trans)) {
+				ret = PTR_ERR(trans);
+				errno = -ret;
+				error(
+		"failed to start transaction to change csum objectids: %m");
+				return ret;
+			}
+		}
 		ret = btrfs_search_slot(trans, csum_root, &last_key, &path, 0, 1);
 		if (ret < 0)
 			goto out;
-- 
2.45.2


