Return-Path: <linux-btrfs+bounces-5126-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5A08CA2F2
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 21:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87E7C1F22095
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 19:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6523F13956F;
	Mon, 20 May 2024 19:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gv7v3wqX";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gv7v3wqX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C601386C0
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 19:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716234761; cv=none; b=UGc4BMWKFKyTMUC/bcn8nCeLsfTKVUH37XwN0QPILfCX6QAyYGoVWvR3rz8xj+VVb2LlyJsIL3tPQk9IrZJDyzt3fgM7SXxu+K240NYDyFtiEQdVCKOA4HdcCuJa4jAWdRB+SGoUJK/uD0s82twh+P4lMKJK9jtABrKA1/4Ivo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716234761; c=relaxed/simple;
	bh=p/t4Dk/2ukl+dyfDqtQkF+JHpziEitzsBkCJ7uLavS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRraG5wvPbLci/r/VJn5VP3xjYV5lQEWqCodjem1mj8AbiRCvZoqjvJMA7kf3+u2190VxuppI1FUpCR1U2axcpW+45hn1A9cCSEqWrLgywOfFjr4gKY4XgHbq4kj2gc+E4yzlcOqi613BURRHOv+DsipjKhQxCWxRCd+I4f2r5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gv7v3wqX; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gv7v3wqX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 27F5320F86;
	Mon, 20 May 2024 19:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716234758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W7EotRIFf8fXqdqbDG/SF+t1NcRy2KLXMkMkQrRjrso=;
	b=gv7v3wqX7N9Jl05cXTk5pKKctBuNVJRdvPLOezzq6rK9brKtYPVz6Z1uwWyXliwzYA90/e
	xqJhgDQ5hS/bLhrs7o07vCoqft5O2TO8EXG1wZU8f5AMbS7HYmDpVQqK1PYQnekJW2zbZB
	/XEv/nR4eCXasMcuSpQdHlQfaeiYz7c=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=gv7v3wqX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716234758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W7EotRIFf8fXqdqbDG/SF+t1NcRy2KLXMkMkQrRjrso=;
	b=gv7v3wqX7N9Jl05cXTk5pKKctBuNVJRdvPLOezzq6rK9brKtYPVz6Z1uwWyXliwzYA90/e
	xqJhgDQ5hS/bLhrs7o07vCoqft5O2TO8EXG1wZU8f5AMbS7HYmDpVQqK1PYQnekJW2zbZB
	/XEv/nR4eCXasMcuSpQdHlQfaeiYz7c=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 225C713A6B;
	Mon, 20 May 2024 19:52:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4zBhCAaqS2ZlSQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 20 May 2024 19:52:38 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 6/6] btrfs: constify parameters of write_eb_member() and its users
Date: Mon, 20 May 2024 21:52:33 +0200
Message-ID: <017852b8a85b0de9255cfe927ad8eaea96d4c60a.1716234472.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1716234472.git.dsterba@suse.com>
References: <cover.1716234472.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 27F5320F86
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:email];
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

Reported by '-Wcast-qual', the argument from which write_extent_buffer()
reads data to write to the eb should be const. In addition the const
needs to be also added to __write_extent_buffer() local buffers.

All callers of write_eb_member() can now be updated to use const for the
input buffer structure or type.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/accessors.h | 10 +++++-----
 fs/btrfs/extent_io.c |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index c60f0e7f768a..6c3deaa3e878 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -48,8 +48,8 @@ static inline void put_unaligned_le8(u8 val, void *p)
 			    offsetof(type, member),			\
 			    sizeof_field(type, member)))
 
-#define write_eb_member(eb, ptr, type, member, result) (\
-	write_extent_buffer(eb, (char *)(result),			\
+#define write_eb_member(eb, ptr, type, member, source) (		\
+	write_extent_buffer(eb, (const char *)(source),			\
 			   ((unsigned long)(ptr)) +			\
 			    offsetof(type, member),			\
 			    sizeof_field(type, member)))
@@ -353,7 +353,7 @@ static inline void btrfs_tree_block_key(const struct extent_buffer *eb,
 
 static inline void btrfs_set_tree_block_key(const struct extent_buffer *eb,
 					    struct btrfs_tree_block_info *item,
-					    struct btrfs_disk_key *key)
+					    const struct btrfs_disk_key *key)
 {
 	write_eb_member(eb, item, struct btrfs_tree_block_info, key, key);
 }
@@ -446,7 +446,7 @@ void btrfs_node_key(const struct extent_buffer *eb,
 		    struct btrfs_disk_key *disk_key, int nr);
 
 static inline void btrfs_set_node_key(const struct extent_buffer *eb,
-				      struct btrfs_disk_key *disk_key, int nr)
+				      const struct btrfs_disk_key *disk_key, int nr)
 {
 	unsigned long ptr;
 
@@ -512,7 +512,7 @@ static inline void btrfs_item_key(const struct extent_buffer *eb,
 }
 
 static inline void btrfs_set_item_key(struct extent_buffer *eb,
-				      struct btrfs_disk_key *disk_key, int nr)
+				      const struct btrfs_disk_key *disk_key, int nr)
 {
 	struct btrfs_item *item = btrfs_item_nr(eb, nr);
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2d773c1cbaa7..bf50301ee528 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4604,7 +4604,7 @@ static void __write_extent_buffer(const struct extent_buffer *eb,
 	size_t cur;
 	size_t offset;
 	char *kaddr;
-	char *src = (char *)srcv;
+	const char *src = (const char *)srcv;
 	unsigned long i = get_eb_folio_index(eb, start);
 	/* For unmapped (dummy) ebs, no need to check their uptodate status. */
 	const bool check_uptodate = !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
-- 
2.45.0


