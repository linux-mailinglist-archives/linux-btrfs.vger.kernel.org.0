Return-Path: <linux-btrfs+bounces-3947-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A848993DD
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 05:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 906E628B962
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 03:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797CF200DB;
	Fri,  5 Apr 2024 03:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Wt8G6g7x";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Wt8G6g7x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0028715E9B
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Apr 2024 03:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712287660; cv=none; b=jyYMyoFdQVbYwckPxA9Z7d77g7t7LKiZLAAN85rlZkyJz7p+tR5teduV5VWpyYMCi2xo2L3W/s7pDuVxC9XIp7wK2isyv465XjAJ+68otM64oDe+HE+VeZSBrEJl769+RSJrL8AU/ZcsS4GTSQuinuq6xWLrWy+Ud92pVCoID6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712287660; c=relaxed/simple;
	bh=5U7g2FStNr7rVJfYF4sGvXT7xk3Ux5B64V4+WoM2lNA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tppKE726ly9+UnosSAoC2jk5hCSZRPx1stHCh/m4VN2T87F6esygL8MFhRTiWzuNcTttf1qqYqEoNsqoDJxdawvAtG1/oyDv8vKy9UbxwF+VttQcj5F9aExnQ6WkYA20Qy3ouSY32E3UAMaXFALqmdJ2j8BoDnNhAQ1fPEjdAe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Wt8G6g7x; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Wt8G6g7x; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 214661F745
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Apr 2024 03:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712287657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HC377AOO2qqemualEaEH0RBFAnZKMkpSMLjMNo2AtQc=;
	b=Wt8G6g7xuxQbdFtDthFT6f8qj7LI0DtrxLY2hYVJgE1WWUtRBIjw/Nf68Wye+lc3XtKIm9
	7gcN2lQTVn02C/kAX/bOY8T7Kyj95AXq/Xpeyq+TEU10oEyAev5z3kl+aIqqxJafZkvg0c
	lCMZkQidpBG7BSMkg+LonRMR8q2CgQ8=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Wt8G6g7x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712287657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HC377AOO2qqemualEaEH0RBFAnZKMkpSMLjMNo2AtQc=;
	b=Wt8G6g7xuxQbdFtDthFT6f8qj7LI0DtrxLY2hYVJgE1WWUtRBIjw/Nf68Wye+lc3XtKIm9
	7gcN2lQTVn02C/kAX/bOY8T7Kyj95AXq/Xpeyq+TEU10oEyAev5z3kl+aIqqxJafZkvg0c
	lCMZkQidpBG7BSMkg+LonRMR8q2CgQ8=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F34613357
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Apr 2024 03:27:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id GE3tNKdvD2a+aQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 05 Apr 2024 03:27:35 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 3/3] btrfs: add extra sanity checks for create_io_em()
Date: Fri,  5 Apr 2024 13:57:13 +1030
Message-ID: <86cb1590afda8ea8659aa40009b35aa5130fa214.1712287421.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712287421.git.wqu@suse.com>
References: <cover.1712287421.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: 214661F745
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
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]

The function create_io_em() is called before we submit an IO, to update
the in-memory extent map for the involved range.

This patch changes the following aspects:

- Does not allow BTRFS_ORDERED_NOCOW type
  For real NOCOW (excluding NOCOW writes into preallocated ranges)
  writes, we never call create_io_em(), as we does not need to update
  the extent map at all.

  So remove the sanity check allowing BTRFS_ORDERED_NOCOW type.

- Add extra sanity checks
  * PREALLOC
    - @block_len == len
      For uncompressed writes.

  * REGULAR
    - @block_len == @orig_block_len == @ram_bytes == @len
      We're creating a new uncompressed extent, and referring all of it.

    - @orig_start == @start
      We haven no offset inside the extent.

  * COMPRESSED
    - valid @compress_type
    - @len <= @ram_bytes
      This is to co-operate with encoded writes, which can cause a new
      file extent referring only part of a uncompressed extent.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c6f2b5d1dee1..ced916f42bab 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7320,11 +7320,49 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 	struct extent_map *em;
 	int ret;
 
+	/*
+	 * Note the missing of NOCOW type.
+	 *
+	 * For pure NOCOW writes, we should not create an io extent map,
+	 * but just reusing the existing one.
+	 * Only PREALLOC writes (NOCOW write into preallocated range) can
+	 * create io extent map.
+	 */
 	ASSERT(type == BTRFS_ORDERED_PREALLOC ||
 	       type == BTRFS_ORDERED_COMPRESSED ||
-	       type == BTRFS_ORDERED_NOCOW ||
 	       type == BTRFS_ORDERED_REGULAR);
 
+	switch (type) {
+	case BTRFS_ORDERED_PREALLOC:
+		/* Uncompressed extents. */
+		ASSERT(block_len == len);
+
+		/* We're only referring part of a larger preallocated extent. */
+		ASSERT(block_len <= ram_bytes);
+		break;
+	case BTRFS_ORDERED_REGULAR:
+		/* Uncompressed extents. */
+		ASSERT(block_len == len);
+
+		/* COW results a new extent matching our file extent size. */
+		ASSERT(orig_block_len == len);
+		ASSERT(ram_bytes == len);
+
+		/* Since it's a new extent, we should not have any offset. */
+		ASSERT(orig_start == start);
+		break;
+	case BTRFS_ORDERED_COMPRESSED:
+		/* Must be compressed. */
+		ASSERT(compress_type != BTRFS_COMPRESS_NONE);
+
+		/*
+		 * Encoded write can make us to refer to part of the
+		 * uncompressed extent.
+		 */
+		ASSERT(len <= ram_bytes);
+		break;
+	}
+
 	em = alloc_extent_map();
 	if (!em)
 		return ERR_PTR(-ENOMEM);
-- 
2.44.0


