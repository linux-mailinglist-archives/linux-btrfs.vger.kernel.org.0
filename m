Return-Path: <linux-btrfs+bounces-15491-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B46B035B4
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Jul 2025 07:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 158E7189AB16
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Jul 2025 05:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E0120ADD6;
	Mon, 14 Jul 2025 05:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="USEGLarz";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="USEGLarz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BAC2046BA
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Jul 2025 05:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752470803; cv=none; b=CPJLQ4gUQEN0YkQFuQJ7Kmz3crBJNto5jMm4lDUW8twlMxq0zCj6Z4t8Ruq94GetII/fvknRAKjoW86ESW089z4JKXk7qxtHXvuRXF7UC2uCtG2tv7bkiGYyWNf17Gf5+u/PBJqtw0O7eGQAKN5eqtD7yK8LloKNrrOh++rpM4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752470803; c=relaxed/simple;
	bh=64ZCiqSv7leXwKLoI+FQc5mTKCqMj0IXimQmrQC6rLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/SArBDBC0fq+chu3hv1b+DZwQpKIhDuqSJ0+tZ7OnmPLB+F0zE/4IIRv6gqi0POyfj/MdJ1ucXqeZ/9CZNYW8YnTOTBoSkQo9g76lMYGUcCMJmAKo57wbaPwnLDvNw+DsyjceomI5OxfVQkN1KsM0wCLDExX0JhG889AWa3zMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=USEGLarz; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=USEGLarz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 63E5F1F387;
	Mon, 14 Jul 2025 05:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752470793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J9N+QNTZ/J+7cVqc25gwhG5kkixhex1ZKfbrlMHE910=;
	b=USEGLarzvw4gZzCLjEXj29Q/sQp/znQKHglxsKPNgvlChfJunG4KhAaOFmFQYwOaY1oPKm
	89P1DSVU6qvk46kknQwJt/l9Hj9DNPnJlLTlfiMydga222MktiAZjkmLMFHz5XTCVF0Fbt
	wj5Zt64mVXO1xUJ9J0QVCJiBv+Ggkg4=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752470793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J9N+QNTZ/J+7cVqc25gwhG5kkixhex1ZKfbrlMHE910=;
	b=USEGLarzvw4gZzCLjEXj29Q/sQp/znQKHglxsKPNgvlChfJunG4KhAaOFmFQYwOaY1oPKm
	89P1DSVU6qvk46kknQwJt/l9Hj9DNPnJlLTlfiMydga222MktiAZjkmLMFHz5XTCVF0Fbt
	wj5Zt64mVXO1xUJ9J0QVCJiBv+Ggkg4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61CB3138A1;
	Mon, 14 Jul 2025 05:26:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GMqQBQeVdGhadQAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 14 Jul 2025 05:26:31 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Subject: [PATCH v5 4/6] btrfs: reject delalloc ranges if in shutdown state
Date: Mon, 14 Jul 2025 14:56:00 +0930
Message-ID: <008c18313360b02181e7732d1a5bded7a6620f17.1752470276.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752470276.git.wqu@suse.com>
References: <cover.1752470276.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

If the filesystem has dirty pages before the fs is shutdown, we should
no longer write them back, instead should treat them as writeback error.

Handle such situation by marking all those delalloc range as error and
let error handling path to clean them up.

For ranges that already have ordered extent created, let them continue
the writeback, and at ordered io finish time the file extent item update
will be rejected as the fs is already marked error.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7ed340cac33f..928ab8ba7d0e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -861,6 +861,9 @@ static void compress_file_range(struct btrfs_work *work)
 	int compress_type = fs_info->compress_type;
 	int compress_level = fs_info->compress_level;
 
+	if (unlikely(btrfs_is_shutdown(fs_info)))
+		goto cleanup_and_bail_uncompressed;
+
 	inode_should_defrag(inode, start, end, end - start + 1, SZ_16K);
 
 	/*
@@ -1276,6 +1279,11 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	unsigned long page_ops;
 	int ret = 0;
 
+	if (unlikely(btrfs_is_shutdown(fs_info))) {
+		ret = -EIO;
+		goto out_unlock;
+	}
+
 	if (btrfs_is_free_space_inode(inode)) {
 		ret = -EINVAL;
 		goto out_unlock;
@@ -2027,7 +2035,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_root *root = inode->root;
-	struct btrfs_path *path;
+	struct btrfs_path *path = NULL;
 	u64 cow_start = (u64)-1;
 	/*
 	 * If not 0, represents the inclusive end of the last fallback_to_cow()
@@ -2047,6 +2055,10 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	 */
 	ASSERT(!btrfs_is_zoned(fs_info) || btrfs_is_data_reloc_root(root));
 
+	if (unlikely(btrfs_is_shutdown(fs_info))) {
+		ret = -EIO;
+		goto error;
+	}
 	path = btrfs_alloc_path();
 	if (!path) {
 		ret = -ENOMEM;
-- 
2.50.0


