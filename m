Return-Path: <linux-btrfs+bounces-3901-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C638897C73
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 01:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ABFC288AAB
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 23:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C2F159560;
	Wed,  3 Apr 2024 23:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="A9wJFVhn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB0C159573
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Apr 2024 23:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712187742; cv=none; b=sRIDCAbUbZ6ekDvMPkpbCvFS40SbpKeeiZn5w0cFB5eMEJzTfXBM+kTRfVVxvERlMG3YGH11p702mjxYH3gquF3DF5kAC7kBBejp5AU2/TLs7ASHCptCsiimUoGSk4NVZPQkdGQhh/Fl6oIW4ClN2iZ8GiG76SM4QYdP+lKwBUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712187742; c=relaxed/simple;
	bh=65D5DJf3Qav9dVyQUemFEU8dBDfK+IwvN5D4Sup9Wvs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGCISVWzCy6fZmx6SmUwc00HjJ13R+CI7zn8mtC1kAaArU78rxBwIlirKvFCzjNoHwHWevKZtXcaALcbm5Eifkek2YY5SNSmpcUyWaisPvL0/awbaTF5U0gRrXEm+g7SqCvZjkCXaii4gg/XcQSLAQr/4ZuCj/EyQ1o5lB8ZZ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=A9wJFVhn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 189265D2E8
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Apr 2024 23:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712187739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tpBvXT1/0ENfkOX6536FAlocR/yLskD/O2EQ2QVcxv0=;
	b=A9wJFVhnrmvx0i0uWkjpuc4H6nmDDpgxkfSZgMmYJU5y3eE8FGKVbvW1eCCGGaNLrTfyJA
	6g/Ask3tRCV/pCkK2n6iXDayzBRaxaG4253qppuWLBRif1QHhVhfKF8qdsXDdMctmerhQ9
	673eKPr64cbRwMID+cZkJxf9G4Sj/mg=
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3AC021331E
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Apr 2024 23:42:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id mN1iO1npDWalfQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 03 Apr 2024 23:42:17 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/4] btrfs: add extra sanity checks for create_io_em()
Date: Thu,  4 Apr 2024 10:12:01 +1030
Message-ID: <6527c36f8fd775cf3ca87e5541cf550537d8e757.1712187452.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712187452.git.wqu@suse.com>
References: <cover.1712187452.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -1.80
X-Spam-Level: 
X-Spam-Flag: NO

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
index c6f2b5d1dee1..261fafc66533 100644
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
 
+	if (type == BTRFS_ORDERED_PREALLOC) {
+		/* Uncompressed extents. */
+		ASSERT(block_len == len);
+
+		/* We're only referring part of a larger preallocated extent. */
+		ASSERT(block_len <= ram_bytes);
+	}
+
+	if (type == BTRFS_ORDERED_REGULAR) {
+		/* Uncompressed extents. */
+		ASSERT(block_len == len);
+
+		/* COW results a new extent matching our file extent size. */
+		ASSERT(orig_block_len == len);
+		ASSERT(ram_bytes == len);
+
+		/* Since it's a new extent, we should not have any offset. */
+		ASSERT(orig_start == start);
+	}
+
+	if (type == BTRFS_ORDERED_COMPRESSED) {
+		/* Must be compressed. */
+		ASSERT(compress_type != BTRFS_COMPRESS_NONE);
+
+		/*
+		 * Encoded write can make us to refer part of the
+		 * uncompressed extent.
+		 */
+		ASSERT(len <= ram_bytes);
+	}
+
 	em = alloc_extent_map();
 	if (!em)
 		return ERR_PTR(-ENOMEM);
-- 
2.44.0


