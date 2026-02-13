Return-Path: <linux-btrfs+bounces-21673-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDL/LHaLj2nURQEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21673-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Feb 2026 21:37:10 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF1A13979D
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Feb 2026 21:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47D91302B226
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Feb 2026 20:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9332528726A;
	Fri, 13 Feb 2026 20:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxbPmMP6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0700248880
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Feb 2026 20:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771015026; cv=none; b=QrXou7YnPxONZnygbfMkxXSaXVyHZLWPNKh/k8mEZ6LmJrHCRjnw0C8yRIdsFw7MGbfR3FBvkIvC+5Wp9FDQh2o+B8xQqXUys5cUjRrkMambOuoCcXlKPn4ujIvOreVSpp3BhLSlX4dnlg3lS9SRX461kMypoYB+vikNe3mpEXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771015026; c=relaxed/simple;
	bh=f/CaZhrmjgq9IC6prUsEuyMxwtHsFUpgb0rjiIuq960=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kc6ZSxIYQuQl+IwARwAhIk+EthuKwB/w9MRoAwIfw5GIG1qdNchH5SUgPDAu7xUG9hWy5enMliTX6DsW5CW9VzJg3rjOnTgBk0Q12+hiuLyRwdgpsRkCePZYuhaYqhA0ssieI8ApxaRci2eps3Swm7xKED9QsXJR9L/HNecewSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxbPmMP6; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-796d68083cdso21625997b3.1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Feb 2026 12:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771015024; x=1771619824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0xNW/wENJHkLD91E3EQDXfagEc8caOluQvUlarJ2Ne4=;
        b=MxbPmMP6r4p+6aTa3JpFOy6ngmklKqE0vS95dGEEY9qYlIb+EpNi4naJWskthlK9Wr
         ELCcWxMbRNO9B7bRMr5XtGEwCTINlN5F2tpHdQH5CuEBTWaICCI4FR25WOmjiTlyaU6C
         MAE0iXkYB0JcIJI2cJdZAHso8BrBe97VKiT1Xjsz0WiRvvWS4/PYA8r0q6RZ4GDk4i6c
         uI3/uKn+FTBAXGylDXrX/MyU04In6SQGesEhTGfg2KQU60tJSuayR7MATm8ZilH8yKuV
         CgmqoaKNdL2yefpZ1pLljcY8Vct3Zi9kB49tsEQ3Bo4oHKAS7T922SHF1tqHvFKesXGB
         /CxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771015024; x=1771619824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0xNW/wENJHkLD91E3EQDXfagEc8caOluQvUlarJ2Ne4=;
        b=WGvoKHTDMUBGLf3DsR1K58XMdWHKcO05YtuyC9FQGTaVwNgdAMBl/tR5fn4U/Fo6Hh
         avELYDMpAL1o0YDASdNi9Wl9LuQKFRi2EjavUG8HzmVO6Q0ZV9I9cijzHz2r0HNM/bTg
         WwqORHOe75PPfEqOXEqFrpgwBRoA2rhTksFBSV7vGhr0SFMFBVJGsXpmU5HrJTooFaGK
         dagdHUUWeTDS3V7sTbo74nAjaZI7eUXTwGcmHP3U65JboTiaoju57xYvpcNWipUE/Gba
         ZTGE5qW9bQG4tTxwPiE7VfI1jAHnJpas9TePoBkbyC9gBAXFYIPlopsi6WEjfSHjRYWM
         vwNg==
X-Gm-Message-State: AOJu0YxzROs6d7asNpI5LQN2GvVGrYKaYgZgey+qnUIaBy1ONDucD4Vl
	qcL9UAmX1si6Nk7aDkaHW3Ykglm5GPcHmk+KdsvV3D8kpBjFGPvNmNzzERokmw7m
X-Gm-Gg: AZuq6aIe4c45Ig7LLe5ghpYf8nN9/Swe1fdnOYkyeLGV9uGEpLdkD/L7nMlcli+h3oj
	oRVTTfQx5c1hXswFImYh8OPsFbLB7l2pipVsMGhMeubARoeta1+Iw/xcnPeoukflpNMLgRUy3xp
	fECOe/jK0N0IQDvY0W/AMFjlE8GwsvdVqEvHPzyk1GfZnjA0+cPhNW6sZ/pNLY6BQ629KRTTrGF
	D9ldqCwDUX2SJaep5BWINRcWPo5MNzu1DkZLmIlvi5XixDMmZzWXj/HT755rVw2w4k2Gv65YpaM
	74YD5iaw2nW90Io8sd7deO4Ya3MXAxJ496KvSTmKKnVHjWydCW06eL/tkl0yBdnayulsf+WiA9+
	K+IUEo7IGbDGrFOwvdr/GFgTVseummqphRY27rm5BYrfekF+rQM0nf/jwxWboEVS5Nfj5N8HYra
	amdtPJZM5MehPsSVZxGQ==
X-Received: by 2002:a05:690c:c50e:b0:796:3079:a88 with SMTP id 00721157ae682-797aa905601mr13632097b3.16.1771015024187;
        Fri, 13 Feb 2026 12:37:04 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:5d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c16f201sm74115887b3.10.2026.02.13.12.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 12:37:03 -0800 (PST)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 1/3] btrfs: skip COW for written extent buffers allocated in current transaction
Date: Fri, 13 Feb 2026 12:30:24 -0800
Message-ID: <04eca407999f1db58a4af9f4d88397aa2edd2d3c.1771012202.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771012202.git.loemra.dev@gmail.com>
References: <cover.1771012202.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21673-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[loemradev@gmail.com,linux-btrfs@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2CF1A13979D
X-Rspamd-Action: no action

When memory pressure causes writeback of a recently COW'd buffer,
btrfs sets BTRFS_HEADER_FLAG_WRITTEN on it. Subsequent
btrfs_search_slot() restarts then see the WRITTEN flag and re-COW
the buffer unnecessarily, causing COW amplification that can exhaust
block reservations and degrade throughput.

Overwriting in place is crash-safe because the committed superblock
does not reference buffers allocated in the current (uncommitted)
transaction, so no on-disk tree points to this block yet.

When should_cow_block() encounters a WRITTEN buffer whose generation
matches the current transaction, instead of requesting a COW, re-dirty
the buffer and re-register its range in the transaction's dirty_pages.

Both are necessary because btrfs tracks dirty metadata through two
independent mechanisms. set_extent_buffer_dirty() sets the
EXTENT_BUFFER_DIRTY flag and the buffer_tree xarray PAGECACHE_TAG_DIRTY
mark, which is what background writeback (btree_write_cache_pages) uses
to find and write dirty buffers. The transaction's dirty_pages io tree
is a separate structure used by btrfs_write_and_wait_transaction() at
commit time to ensure all buffers allocated during the transaction are
persisted. The dirty_pages range was originally registered in
btrfs_init_new_buffer() when the block was first allocated, but
background writeback may have already written and cleared it.

Keep BTRFS_HEADER_FLAG_WRITTEN set so that btrfs_free_tree_block()
correctly pins the block if it is freed later.

Exclude cases where in-place overwrite is not safe:
 - EXTENT_BUFFER_WRITEBACK: buffer is mid-I/O
 - Zoned devices: require sequential writes
 - Log trees: log blocks are immediately referenced by a committed
   superblock via btrfs_sync_log(), so overwriting could corrupt the
   committed log
 - BTRFS_ROOT_FORCE_COW: snapshot in progress
 - BTRFS_HEADER_FLAG_RELOC: block being relocated

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 fs/btrfs/ctree.c | 53 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 7267b2502665..a345e1be24d8 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -599,9 +599,9 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static inline bool should_cow_block(const struct btrfs_trans_handle *trans,
+static inline bool should_cow_block(struct btrfs_trans_handle *trans,
 				    const struct btrfs_root *root,
-				    const struct extent_buffer *buf)
+				    struct extent_buffer *buf)
 {
 	if (btrfs_is_testing(root->fs_info))
 		return false;
@@ -621,8 +621,55 @@ static inline bool should_cow_block(const struct btrfs_trans_handle *trans,
 	if (btrfs_header_generation(buf) != trans->transid)
 		return true;
 
-	if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN))
+	if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
+		/*
+		 * The buffer was allocated in this transaction and has been
+		 * written back to disk (WRITTEN is set). Normally we'd COW
+		 * it again, but since the committed superblock doesn't
+		 * reference this buffer (it was allocated this transaction),
+		 * we can safely overwrite it in place.
+		 *
+		 * We keep BTRFS_HEADER_FLAG_WRITTEN set. The block has been
+		 * persisted at this bytenr and will be again after the
+		 * in-place update. This is important so that
+		 * btrfs_free_tree_block() correctly pins the block if it is
+		 * freed later (e.g., during tree rebalancing or FORCE_COW).
+		 *
+		 * We re-dirty the buffer to ensure the in-place modifications
+		 * will be written back to disk.
+		 *
+		 * Exclusions:
+		 * - Log trees: log blocks are written and immediately
+		 *   referenced by a committed superblock via
+		 *   btrfs_sync_log(), bypassing the normal transaction
+		 *   commit. Overwriting in place could corrupt the
+		 *   committed log.
+		 * - Zoned devices: require sequential writes
+		 * - FORCE_COW: snapshot in progress
+		 * - RELOC flag: block being relocated
+		 */
+		if (!test_bit(EXTENT_BUFFER_WRITEBACK, &buf->bflags) &&
+		    !btrfs_is_zoned(root->fs_info) &&
+		    btrfs_root_id(root) != BTRFS_TREE_LOG_OBJECTID &&
+		    !test_bit(BTRFS_ROOT_FORCE_COW, &root->state) &&
+		    !btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC)) {
+			/*
+			 * Re-register this block's range in the current
+			 * transaction's dirty_pages so that
+			 * btrfs_write_and_wait_transaction() writes it.
+			 * The range was originally registered when the block
+			 * was allocated, but that transaction's dirty_pages
+			 * may have already been released.
+			 */
+			btrfs_set_extent_bit(&trans->transaction->dirty_pages,
+					     buf->start,
+					     buf->start + buf->len - 1,
+					     EXTENT_DIRTY, NULL);
+			set_extent_buffer_dirty(buf);
+			return false;
+		}
 		return true;
+	}
 
 	/* Ensure we can see the FORCE_COW bit. */
 	smp_mb__before_atomic();
-- 
2.47.3


