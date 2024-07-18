Return-Path: <linux-btrfs+bounces-6553-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A729A937090
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 00:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 341521F229D2
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2024 22:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE50146586;
	Thu, 18 Jul 2024 22:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dRq4ho/A";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dRq4ho/A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F58145FFC
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 22:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721340674; cv=none; b=NlaA91FBMcJM+pOLxrtKI9P3WWm4Vj4TK9QxUREqJghQKnbiMtTf1kxKSNMaMcL33UCoK8dCYjKnUZ9tVf0rTzCCQcBFf6NmSbD4FhPEWFtIR1jeSArzc6XX+CAVk4+NA3Dxb+CWIY382y/miNJilLHTYqqMAZhNwM6GH+o3kKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721340674; c=relaxed/simple;
	bh=LWvNVaGthbYvI4yj3ghqWqZu/vYWrQ3wpV+A61DssWI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2cQlZ65gV5yD3UbsskfpGlb6UF8GbXHOibTE88XsWsStxzdUU9oamRiB5eHNSjSZZrLoJ39OkJT1O8W5xzqkwcw2Tmt7+tb3FiBbUdIpeBcLNmqxQAc8ida8TNhEd922VNjRPnt/4XwGpz9n96/q8Y/HOX4cW/rqYkZWtX1Kmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dRq4ho/A; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dRq4ho/A; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0A744216EA
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 22:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721340670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OTpcAHvNRgz7hHOHyV971kpgK9P/XxuDK7599zOP8bk=;
	b=dRq4ho/AlvVN+nvc4oCHIFpIc73c0GV00iv3TXa8ffq1iKcAuqFm0NrxZzApsOriQw7c54
	liauDaAZBHsz50ThtFAHlD+AkihPiGA1u6guEY+5rPNUKHnO5C2BMOWiAxFtOo0QUVnNiE
	OAgX4QMSwSIvUuf2nIF/XmXc/ipGcok=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="dRq4ho/A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721340670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OTpcAHvNRgz7hHOHyV971kpgK9P/XxuDK7599zOP8bk=;
	b=dRq4ho/AlvVN+nvc4oCHIFpIc73c0GV00iv3TXa8ffq1iKcAuqFm0NrxZzApsOriQw7c54
	liauDaAZBHsz50ThtFAHlD+AkihPiGA1u6guEY+5rPNUKHnO5C2BMOWiAxFtOo0QUVnNiE
	OAgX4QMSwSIvUuf2nIF/XmXc/ipGcok=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2FD7B137EB
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 22:11:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6KjTNvySmWZZFwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 22:11:08 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 1/3] btrfs-progs: csum-change: add leaf based threshold
Date: Fri, 19 Jul 2024 07:40:43 +0930
Message-ID: <7e8e75f50bb6b8d44a50bacfe803f7790e6a2a70.1721340621.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1721340621.git.wqu@suse.com>
References: <cover.1721340621.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0A744216EA
X-Spam-Flag: NO
X-Spam-Score: 0.99
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.99 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Level: 
X-Spamd-Bar: /

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


