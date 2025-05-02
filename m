Return-Path: <linux-btrfs+bounces-13631-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C5AAA73F3
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 15:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A2DE17D267
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 13:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8D1255F5E;
	Fri,  2 May 2025 13:38:09 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5691E255F52
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 13:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746193089; cv=none; b=tzvYu4fqNLFFuNh0DwJ43w++t8sX581/OnsAho8knZHRJ1msf4JkeDqCjUu76/p+E7EHZbmFYojFhxg3efcOawvCVm1EnQHIOFx8JgK0fW19xLXI/BEpEEMa6JpFNIyRRfSxbM4ZzaqhZhrb1T8tHLGXC0WESH8U+bsqJ1YAyWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746193089; c=relaxed/simple;
	bh=9HlB6BZrvTeKSOtGQZ2/obKxWDta9eZ5Yv1TcUrk06Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rac1NRxzNCGOn0lboUwZhMr275wirugTAy/2/lYCusEI63b5+nv2z/mG5A4YSeDlajdYMzCpyH96P5YkU4B2tASmTrgN/b3hFThLF/CNI/ZJ+RZNmZyN2ajrXzPoAMyVSdtaUTMPULxb0Bi3jgDTTCLNEVhuzfilP7V02XhGhRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EF4A91F385;
	Fri,  2 May 2025 13:37:59 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CCCB71372E;
	Fri,  2 May 2025 13:37:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EKJ7MbfKFGiIHQAAD6G6ig
	(envelope-from <neelx@suse.com>); Fri, 02 May 2025 13:37:59 +0000
From: Daniel Vacek <neelx@suse.com>
To: David Sterba <dsterba@suse.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs: rearrange the extent buffer structure members
Date: Fri,  2 May 2025 15:37:23 +0200
Message-ID: <20250502133725.1210587-3-neelx@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250502133725.1210587-1-neelx@suse.com>
References: <20250429151800.649010-1-neelx@suse.com>
 <20250502133725.1210587-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: EF4A91F385
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

Fill in the hole after the removed `len` field. There should be no difference
on default config but it cuts the size down by 8 bytes on -rt kernels due to
different lock sizes and alignment. This way we can completely get rid of the
other hole which was there before.

Signed-off-by: Daniel Vacek <neelx@suse.com>
---

This patch is new in v2.

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


