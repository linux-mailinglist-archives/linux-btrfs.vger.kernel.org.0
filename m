Return-Path: <linux-btrfs+bounces-5866-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA16911A37
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 07:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A89D1F223A8
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 05:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED2C13AD20;
	Fri, 21 Jun 2024 05:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PYjFJiaf";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PYjFJiaf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A0112BF2B
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 05:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718947046; cv=none; b=OiViqTjRvRNWAfuVI3tZ1fh6QimnUg7pXZEJPikvs2+Es+KAM0cS/r4zgRxxQl+vWR9DJyJqJOCvQ1Wspjg+r2UjNtoRj+PtA+dNhoiARrTurZfnidaCNzfBMZshIwgL9UlWY1NpR3FML0dkbCh5P4BH8kokdcjmwCIm89o/KBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718947046; c=relaxed/simple;
	bh=LWvNVaGthbYvI4yj3ghqWqZu/vYWrQ3wpV+A61DssWI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i4sJhqeHECBCn/ajHqPz/RBipDYILVgZKKuOCSGD/ANVgwUNCqLErUBOyAp7Q5DPjuLxbxkzjJcGEOLbUNhCNXqdrpO0PTZVLF0nTX1qHRX99EqTL15USSnApeRYk/7KbkOM8/YCuyZC3pnNK9qkG0Nk8eEDUfnqjhvhCRolirs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PYjFJiaf; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PYjFJiaf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3D99F1FB3F
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 05:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718947042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OTpcAHvNRgz7hHOHyV971kpgK9P/XxuDK7599zOP8bk=;
	b=PYjFJiafeHTK2yeSiC4QGUVZ6fCXCdkyTcoEBIQXLZyhnW4x6FNF9gj7r/1NOe/GCcLn57
	sb1jAMoBeVViAyyPmAR7KGjgBhLujdxZ6+UAaiQbTA4TyudCKnUQS6QqrcqWybYD+oEFFz
	CETc03ifNmmG21fcAHxenEYPvf7Q7cc=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718947042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OTpcAHvNRgz7hHOHyV971kpgK9P/XxuDK7599zOP8bk=;
	b=PYjFJiafeHTK2yeSiC4QGUVZ6fCXCdkyTcoEBIQXLZyhnW4x6FNF9gj7r/1NOe/GCcLn57
	sb1jAMoBeVViAyyPmAR7KGjgBhLujdxZ6+UAaiQbTA4TyudCKnUQS6QqrcqWybYD+oEFFz
	CETc03ifNmmG21fcAHxenEYPvf7Q7cc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 535BC13AAA
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 05:17:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QPi1AuEMdWavbAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 05:17:21 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/3] btrfs-progs: csum-change: add leaf based threshold
Date: Fri, 21 Jun 2024 14:46:55 +0930
Message-ID: <9f7a033fe4e33c1c8122a523fe11844b6d8ba95e.1718946934.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718946934.git.wqu@suse.com>
References: <cover.1718946934.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.972];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.79
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


