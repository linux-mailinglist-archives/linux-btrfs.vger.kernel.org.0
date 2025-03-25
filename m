Return-Path: <linux-btrfs+bounces-12577-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64620A706F3
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Mar 2025 17:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 133567A29A3
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Mar 2025 16:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACF025F7B4;
	Tue, 25 Mar 2025 16:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tsggc41S";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tsggc41S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E2D25A322
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Mar 2025 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742920340; cv=none; b=UD9MIBREjqCTrdbXe5eqLc2Hlo4EKfLnfa22AOMwOG21O2nhS/GI5lS+vt8J3HGf1oMIYNb4a5oVfG0L13/Nq/ToCFmzjvAYwe3hoi5t9GVrVasUxFSFmrBWqpPMYLGtK/jbkX1j9r9Y0O4iBuBd9hFdkrIFyI6hlAeX8kmxpVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742920340; c=relaxed/simple;
	bh=+a+aGSk/YWiUCPhe5u/nwtnq9eiwWu7KqUURGQUojxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTdj+HywLZObdO7gAcymYOlqiIhoKkpk0IE+J1jX7wJQoCf12WooV7KGT42yO1uVV3Y98XSOrtfiyVmdedaiuh94pjr4JJBBMdert+rqmYeuCFXaqafoB8zEN2NFXy/8LBS+GEnH+2X6bK2/xrIUBlLjoLkkNg2KMttScEbffmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tsggc41S; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tsggc41S; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E04B521193;
	Tue, 25 Mar 2025 16:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742920314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cUJyeMoKB0EHg6JVVeIaUfBU01Do74x3esYio0TY5ck=;
	b=tsggc41Sy3Yw2tCVHOvihVY3q8S3gaOQg7JJIOh9p25G9ajIVsihlzTIts25K6iZ6y96JV
	QswoUwW0YRJq01J49mB/v4CfFmxZWY9CND9BV8FAhB7lWsVK5Fthp2/XW9wfVIho6M52xL
	ff8zGmzGP/1LujJqPpLoxqW0FogV/3g=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=tsggc41S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742920314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cUJyeMoKB0EHg6JVVeIaUfBU01Do74x3esYio0TY5ck=;
	b=tsggc41Sy3Yw2tCVHOvihVY3q8S3gaOQg7JJIOh9p25G9ajIVsihlzTIts25K6iZ6y96JV
	QswoUwW0YRJq01J49mB/v4CfFmxZWY9CND9BV8FAhB7lWsVK5Fthp2/XW9wfVIho6M52xL
	ff8zGmzGP/1LujJqPpLoxqW0FogV/3g=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C7C45137AC;
	Tue, 25 Mar 2025 16:31:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eE0yMHra4meDSQAAD6G6ig
	(envelope-from <neelx@suse.com>); Tue, 25 Mar 2025 16:31:54 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] btrfs: cleanup EXTENT_BUFFER_CORRUPT flag
Date: Tue, 25 Mar 2025 17:31:38 +0100
Message-ID: <20250325163139.878473-4-neelx@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250325163139.878473-1-neelx@suse.com>
References: <20250325163139.878473-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E04B521193
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

This flag is no longer being used. Remove it.

It was added by commit a826d6dcb32d ("Btrfs: check items for correctness as
we search") but it's no longer being used after commit f26c92386028 ("btrfs:
remove reada infrastructure").

Signed-off-by: Daniel Vacek <neelx@suse.com>
---
 fs/btrfs/disk-io.c     | 11 ++---------
 fs/btrfs/extent-tree.c |  6 ------
 fs/btrfs/extent_io.h   |  1 -
 3 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 1a916716cefeb..6303d4dda8725 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -224,7 +224,6 @@ int btrfs_read_extent_buffer(struct extent_buffer *eb,
 	ASSERT(check);
 
 	while (1) {
-		clear_bit(EXTENT_BUFFER_CORRUPT, &eb->bflags);
 		ret = read_extent_buffer_pages(eb, mirror_num, check);
 		if (!ret)
 			break;
@@ -452,15 +451,9 @@ int btrfs_validate_extent_buffer(struct extent_buffer *eb,
 			goto out;
 	}
 
-	/*
-	 * If this is a leaf block and it is corrupt, set the corrupt bit so
-	 * that we don't try and read the other copies of this block, just
-	 * return -EIO.
-	 */
-	if (found_level == 0 && btrfs_check_leaf(eb)) {
-		set_bit(EXTENT_BUFFER_CORRUPT, &eb->bflags);
+	/* If this is a leaf block and it is corrupt, just return -EIO. */
+	if (found_level == 0 && btrfs_check_leaf(eb))
 		ret = -EIO;
-	}
 
 	if (found_level > 0 && btrfs_check_node(eb))
 		ret = -EIO;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 957230abd8271..47db37b7236d3 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3488,12 +3488,6 @@ int btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 	trace_btrfs_reserved_extent_free(fs_info, buf->start, buf->len);
 
 out:
-
-	/*
-	 * Deleting the buffer, clear the corrupt flag since it doesn't
-	 * matter anymore.
-	 */
-	clear_bit(EXTENT_BUFFER_CORRUPT, &buf->bflags);
 	return 0;
 }
 
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index d0b3526749aa2..c74e4a07d0ad1 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -38,7 +38,6 @@ struct btrfs_tree_parent_check;
 enum {
 	EXTENT_BUFFER_UPTODATE,
 	EXTENT_BUFFER_DIRTY,
-	EXTENT_BUFFER_CORRUPT,
 	EXTENT_BUFFER_TREE_REF,
 	EXTENT_BUFFER_STALE,
 	EXTENT_BUFFER_WRITEBACK,
-- 
2.47.2


