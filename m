Return-Path: <linux-btrfs+bounces-21575-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GI9IJCWlimmhMgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21575-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 04:25:25 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFA2116BC1
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 04:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A05353015716
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 03:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09742FBE1F;
	Tue, 10 Feb 2026 03:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cYPt5y60";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cYPt5y60"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C435A285073
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 03:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770693908; cv=none; b=ax1YbeFGb0Dw+ybfjOsYxtyCjTVt5Hcy38bP7aFSLxacgLNop/e+mrGUjswi+ZVerIB384E5ybdlp/4GrebxDizwKTQyIEHAhEopt8I8ZgxWTkKVBz4mwsaKjzhFwjlCX3HT3lk2oa7ya/4J7FuCABaurvFYP6CNes5sdvs41WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770693908; c=relaxed/simple;
	bh=cPpxqUktoFODM7wsOKygXsFopfp/IFu+SwRcZWmBWgM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kg028oOCP98+daie5ZdKmBD1XghJYBEwNtlQ/9yy/tuzusBE3Do8eZw+yS9x3eahKIjHjoxMcnHjmX5Ht8+4moAKsc7PIiI5bgfCxP9kuQ/YyMTKSSHa0PbXTWyc9/pTMfyunypIDYglmplj2qKbun+6Q5MFBEX0yI6yKZnjz9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cYPt5y60; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cYPt5y60; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 15DEA5BD32
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 03:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770693896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v4Sm4LkopwUkbhsCh8ALAxBZVKP+EGa2z9YEID6b2sg=;
	b=cYPt5y60uSmzc7yX1KwZpkm5SckIhRbmnfb8vxc8OW8xkX6TH8P+KNm8wXpkUvD4sJO9Pt
	ovU9ri6ezt8czk6mx7g9YBvGkJIu7SdTezKdHpHcaIGzLPj8l/RMGUjNPNB2ABVJ010b62
	PI0tm6cyisLpOWv+LwW5G/fyGWPeB4I=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=cYPt5y60
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770693896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v4Sm4LkopwUkbhsCh8ALAxBZVKP+EGa2z9YEID6b2sg=;
	b=cYPt5y60uSmzc7yX1KwZpkm5SckIhRbmnfb8vxc8OW8xkX6TH8P+KNm8wXpkUvD4sJO9Pt
	ovU9ri6ezt8czk6mx7g9YBvGkJIu7SdTezKdHpHcaIGzLPj8l/RMGUjNPNB2ABVJ010b62
	PI0tm6cyisLpOWv+LwW5G/fyGWPeB4I=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 077EB3EA62
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 03:24:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yO+gKQalimkrEgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 03:24:54 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: rename btrfs_csum_file_blocks() to btrfs_insert_data_csums()
Date: Tue, 10 Feb 2026 13:54:31 +1030
Message-ID: <d01bc01684f779f3d33cee5871527f9a8f504faf.1770693583.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1770693583.git.wqu@suse.com>
References: <cover.1770693583.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21575-lists,linux-btrfs=lfdr.de];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0EFA2116BC1
X-Rspamd-Action: no action

The function btrfs_csum_file_blocks() is a little confusing, unlike
btrfs_csum_one_bio(), it is not calculating the checksum of some file
blocks.

Instead it's just inserting the already calculated checksums into a given
root (can be a csum root or a log tree).

So rename it to btrfs_insert_data_csums() to reflect its behavior better.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file-item.c | 6 +++---
 fs/btrfs/file-item.h | 6 +++---
 fs/btrfs/inode.c     | 2 +-
 fs/btrfs/tree-log.c  | 6 +++---
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 7bd715442f3e..27d971b12ce7 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -1090,9 +1090,9 @@ static int find_next_csum_offset(struct btrfs_root *root,
 	return 0;
 }
 
-int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
-			   struct btrfs_root *root,
-			   struct btrfs_ordered_sum *sums)
+int btrfs_insert_data_csums(struct btrfs_trans_handle *trans,
+			    struct btrfs_root *root,
+			    struct btrfs_ordered_sum *sums)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_key file_key;
diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
index 5645c5e3abdb..6c678787c770 100644
--- a/fs/btrfs/file-item.h
+++ b/fs/btrfs/file-item.h
@@ -61,9 +61,9 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root,
 			     struct btrfs_path *path, u64 objectid,
 			     u64 bytenr, int mod);
-int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
-			   struct btrfs_root *root,
-			   struct btrfs_ordered_sum *sums);
+int btrfs_insert_data_csums(struct btrfs_trans_handle *trans,
+			    struct btrfs_root *root,
+			    struct btrfs_ordered_sum *sums);
 int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool async);
 int btrfs_alloc_dummy_sum(struct btrfs_bio *bbio);
 int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6c7fe7c87bc3..4256c8056428 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2756,7 +2756,7 @@ static int add_pending_csums(struct btrfs_trans_handle *trans,
 		if (!csum_root)
 			csum_root = btrfs_csum_root(trans->fs_info,
 						    sum->logical);
-		ret = btrfs_csum_file_blocks(trans, csum_root, sum);
+		ret = btrfs_insert_data_csums(trans, csum_root, sum);
 		trans->adding_csums = false;
 		if (ret)
 			return ret;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 6ff1fe284ee9..b5f8e1399758 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -996,7 +996,7 @@ static noinline int replay_one_extent(struct walk_control *wc)
 						       btrfs_root_id(root));
 		}
 		if (!ret) {
-			ret = btrfs_csum_file_blocks(trans, csum_root, sums);
+			ret = btrfs_insert_data_csums(trans, csum_root, sums);
 			if (ret)
 				btrfs_abort_log_replay(wc, ret,
 	       "failed to add csums for range [%llu, %llu) inode %llu root %llu",
@@ -4722,7 +4722,7 @@ static int log_csums(struct btrfs_trans_handle *trans,
 	 * worry about logging checksum items with overlapping ranges.
 	 */
 	if (inode->last_reflink_trans < trans->transid)
-		return btrfs_csum_file_blocks(trans, log_root, sums);
+		return btrfs_insert_data_csums(trans, log_root, sums);
 
 	/*
 	 * Serialize logging for checksums. This is to avoid racing with the
@@ -4745,7 +4745,7 @@ static int log_csums(struct btrfs_trans_handle *trans,
 	 */
 	ret = btrfs_del_csums(trans, log_root, sums->logical, sums->len);
 	if (!ret)
-		ret = btrfs_csum_file_blocks(trans, log_root, sums);
+		ret = btrfs_insert_data_csums(trans, log_root, sums);
 
 	btrfs_unlock_extent(&log_root->log_csum_range, sums->logical, lock_end,
 			    &cached_state);
-- 
2.52.0


