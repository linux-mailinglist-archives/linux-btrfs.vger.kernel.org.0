Return-Path: <linux-btrfs+bounces-13653-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A079AA924F
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 13:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19CA618856E1
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 11:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526D520A5EA;
	Mon,  5 May 2025 11:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="M093U6FM";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="M093U6FM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA17A208994
	for <linux-btrfs@vger.kernel.org>; Mon,  5 May 2025 11:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746445880; cv=none; b=qTS0SRfGTQ/DwTz/FOmpuAYrqe06+3DkouTz1HsVZxgm1RhVEct1G1CdOZ6LN5Nnxh6FKjnJFbHd+ewofDaiH9X4mejtwORpZ69hZ55DieXSOB+89cQziH6T5cCZAfT8rHYTFH4HBzUZYE6mveZC86lccbvgQZX6Jk9m/QBvxso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746445880; c=relaxed/simple;
	bh=FmVnT3qT9b6rm8K8I+eQfNmFOvg/P/6dbHE70HtVtVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twRKO8xGaD1ZmOV/3VtiRRj9g0wKOHikZQfzNY3jHADDAQeqYe8ASZ409bv5Gu+JMdItJBz1NoAA3UJEKrtdzIDyM7zo8+bGG/uEgHfQtVoq3VApQ2WHemNcLSzfkGSMUTiLULnVHhxAefcqBCnBQqL+jG6Fjhp75wVGt25g32w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=M093U6FM; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=M093U6FM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 998AB1F453;
	Mon,  5 May 2025 11:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746445874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3lpU7FNa2BSfpJyr58dC/nz5TEF5PhJvkDb+wkZ5zc=;
	b=M093U6FMvGlnYJZPG4QPEJ8Tl5qrL3EcepWTFrywe8X+oC9XuY4QykcL6NP7Bm09FD1Xbj
	oBEi5Mx/wFkYFB5f+B0CGHxcjV9WQiL2ZI921fYFiFvZqZCFZECNNWlQjKyjuZCHp9FZ/q
	IjHNP8Jg5bRSQ9sR8rltzbmMwCAM6Lk=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=M093U6FM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746445874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3lpU7FNa2BSfpJyr58dC/nz5TEF5PhJvkDb+wkZ5zc=;
	b=M093U6FMvGlnYJZPG4QPEJ8Tl5qrL3EcepWTFrywe8X+oC9XuY4QykcL6NP7Bm09FD1Xbj
	oBEi5Mx/wFkYFB5f+B0CGHxcjV9WQiL2ZI921fYFiFvZqZCFZECNNWlQjKyjuZCHp9FZ/q
	IjHNP8Jg5bRSQ9sR8rltzbmMwCAM6Lk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82C4113883;
	Mon,  5 May 2025 11:51:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kNRsHzKmGGj3FgAAD6G6ig
	(envelope-from <neelx@suse.com>); Mon, 05 May 2025 11:51:14 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] btrfs: rearrange the extent buffer structure members
Date: Mon,  5 May 2025 13:50:55 +0200
Message-ID: <20250505115056.1803847-3-neelx@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505115056.1803847-1-neelx@suse.com>
References: <20250502133725.1210587-2-neelx@suse.com>
 <20250505115056.1803847-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 998AB1F453
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Fill in the hole after the removed `len` field. There should be no difference
on default config but it cuts the size down by 8 bytes on -rt kernels due to
different lock sizes and alignment. This way we can completely get rid of the
other hole which was there before.

Signed-off-by: Daniel Vacek <neelx@suse.com>
---

This patch is new in v2. No changes for v3.

@Dave> What assembly would you like to see?

>@@ -10148,30 +10148,27 @@
> struct extent_buffer {
> 	u64                        start;                /*     0     8 */
> 	u32                        folio_size;           /*     8     4 */
>+	u8                         folio_shift;          /*    12     1 */
>+	s8                         log_index;            /*    13     1 */
> 
>-	/* XXX 4 bytes hole, try to pack */
>+	/* XXX 2 bytes hole, try to pack */
> 
> 	long unsigned int          bflags;               /*    16     8 */
> 	struct btrfs_fs_info *     fs_info;              /*    24     8 */
> 	void *                     addr;                 /*    32     8 */
> 	spinlock_t                 refs_lock;            /*    40    32 */
> 	/* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
> 	atomic_t                   refs;                 /*    72     4 */
> 	int                        read_mirror;          /*    76     4 */
>-	s8                         log_index;            /*    80     1 */
>-	u8                         folio_shift;          /*    81     1 */
>+	struct callback_head       callback_head __attribute__((__aligned__(8))); /*    80    16 */
>+	struct rw_semaphore        lock;                 /*    96    40 */
>+	/* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
>+	struct folio *             folios[16];           /*   136   128 */
> 
>-	/* XXX 6 bytes hole, try to pack */
>-
>-	struct callback_head       callback_head __attribute__((__aligned__(8))); /*    88    16 */
>-	struct rw_semaphore        lock;                 /*   104    40 */
>-	/* --- cacheline 2 boundary (128 bytes) was 16 bytes ago --- */
>-	struct folio *             folios[16];           /*   144   128 */
>-
>-	/* size: 272, cachelines: 5, members: 13 */
>-	/* sum members: 262, holes: 2, sum holes: 10 */
>-	/* forced alignments: 1, forced holes: 1, sum forced holes: 6 */
>-	/* last cacheline: 16 bytes */
>+	/* size: 264, cachelines: 5, members: 13 */
>+	/* sum members: 262, holes: 1, sum holes: 2 */
>+	/* forced alignments: 1 */
>+	/* last cacheline: 8 bytes */
> } __attribute__((__aligned__(8)));

Here the refs_lock and refs are split to different cachelines. But the
slab object is not aligned anyways so this is inevitable anyways on -rt.
For non-rt they always move together as they fit into 8 bytes aligned.
So that's not an issue for non-rt.

---
 fs/btrfs/extent_io.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 7a8451c11630a..5162d2da767ad 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -88,6 +88,9 @@ void __cold extent_buffer_free_cachep(void);
 struct extent_buffer {
 	u64 start;
 	u32 folio_size;
+	u8 folio_shift;
+	/* >= 0 if eb belongs to a log tree, -1 otherwise */
+	s8 log_index;
 	unsigned long bflags;
 	struct btrfs_fs_info *fs_info;
 
@@ -100,9 +103,6 @@ struct extent_buffer {
 	spinlock_t refs_lock;
 	atomic_t refs;
 	int read_mirror;
-	/* >= 0 if eb belongs to a log tree, -1 otherwise */
-	s8 log_index;
-	u8 folio_shift;
 	struct rcu_head rcu_head;
 
 	struct rw_semaphore lock;
-- 
2.47.2


