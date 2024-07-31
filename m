Return-Path: <linux-btrfs+bounces-6909-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 875BF942B08
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 11:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4931C24943
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 09:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DF043169;
	Wed, 31 Jul 2024 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="C6FaSRAG";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="C6FaSRAG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9861AB504
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2024 09:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722418755; cv=none; b=fPUaD+FIav3k1RdzciyfER/iWxS2O3UV5E2u1XBcYKYw5KQ7hHSUUB45ceMiz/fbUe9J0OED/ZaXHWN5Zqwg89VoXMv6pGXkf6J27RuYa+EERk7x57mEp1PZfif36yBTsqs1U9FXAmcTvJ3ERqIdMXSKSgNJX+HDS/YGt+fCwns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722418755; c=relaxed/simple;
	bh=G9ZP0Eq/9zdDxCcsmtWudLUCUhN/XotgjILKVL269M0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YC0aPBN61SRvFEGPGIkaY1CVuaDSzHR3MNrJIxLw22lboj/4P5Yf+Zm9nkdPKM6ganbOfulnR1u2u5pPfOMZw+BuSWWSATco4Y4W1xywkBAxClz9ON7pdDrg2fjScLUGUNUdQ+Izyj8mWBzvoym5WXp05BmOqZiHhsXPU0zS3BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=C6FaSRAG; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=C6FaSRAG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BB1DA1F841
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2024 09:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1722418751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IXaFpEBJeXnnmICYMNntmLhru83ZtlCfQqQX9H9D7rk=;
	b=C6FaSRAGcbAt6YluGwfMZzTQlWAC2Fc+UcuxtR1KSuDJHpXZb5d5rphScV+s60sWjGjXbN
	MaIeT/RhIDoA0mvg9AQK7jkO3mKEizqneC4nAEhKEvcIKyBH0RjsIRW6q2krVcKBFyttUX
	SBYGyzhOz3VgGGwuBylaOqKn4j4wXxc=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=C6FaSRAG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1722418751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IXaFpEBJeXnnmICYMNntmLhru83ZtlCfQqQX9H9D7rk=;
	b=C6FaSRAGcbAt6YluGwfMZzTQlWAC2Fc+UcuxtR1KSuDJHpXZb5d5rphScV+s60sWjGjXbN
	MaIeT/RhIDoA0mvg9AQK7jkO3mKEizqneC4nAEhKEvcIKyBH0RjsIRW6q2krVcKBFyttUX
	SBYGyzhOz3VgGGwuBylaOqKn4j4wXxc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF1491368F
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2024 09:39:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ID/aJT4GqmZgHgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2024 09:39:10 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: rootdir: reject hard links
Date: Wed, 31 Jul 2024 19:08:48 +0930
Message-ID: <7984ff20beeb81268f786234d30d3c24d90a9a5b.1722418505.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722418505.git.wqu@suse.com>
References: <cover.1722418505.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.81 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.81
X-Rspamd-Queue-Id: BB1DA1F841

Hard link detection needs extra memory to save all the inodes hits with
extra nlinks.

There is no such support from the very beginning, and our code will just
create two different inodes, ignoring the extra links completely.

Considering the most common use case (populating a rootfs), there is not
much distro doing hard links intentionally, it should be pretty safe.

Just error out if we hit such hard links.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 mkfs/rootdir.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index d8bd2ce29d5a..babb9d102d6a 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -418,6 +418,18 @@ static int ftw_add_inode(const char *full_path, const struct stat *st,
 	u64 ino;
 	int ret;
 
+	/*
+	 * Hard link need extra detection code, not support for now.
+	 *
+	 * st_nlink on directories is fs specific, so only check it on
+	 * non-directory inodes.
+	 */
+	if (unlikely(!S_ISDIR(st->st_mode) && st->st_nlink > 1)) {
+		error("'%s' has extra hard links, not supported for now",
+			full_path);
+		return -EOPNOTSUPP;
+	}
+
 	/* The rootdir itself. */
 	if (unlikely(ftwbuf->level == 0)) {
 		u64 root_ino = btrfs_root_dirid(&root->root_item);
-- 
2.45.2


