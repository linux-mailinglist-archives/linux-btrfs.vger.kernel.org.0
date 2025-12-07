Return-Path: <linux-btrfs+bounces-19552-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AEECAB158
	for <lists+linux-btrfs@lfdr.de>; Sun, 07 Dec 2025 05:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C977730094A3
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Dec 2025 04:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB77254AE1;
	Sun,  7 Dec 2025 04:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CZLyqZsv";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="S9TjXXkA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781C917BA2
	for <linux-btrfs@vger.kernel.org>; Sun,  7 Dec 2025 04:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765081436; cv=none; b=mOT1px6KJOOb+0rGTA5158LerJ/5tN9ZL74XTPxNhSx8T0xfOI/NvOm0jb9sm79Qjc4z8EDXTj13QnFy5EZTjKFB55ihZuzLS70fhIfCyw/O2wfe+IdeMLV69R9aDjYWiQ+pXk8/42/SHWzwVmvZoBsNOs+8TM2lzmKIPrC2hA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765081436; c=relaxed/simple;
	bh=tLVwx/c1ZBHv1AtE+hpgxcvRhbT93BBHFtRPCX8SBvQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BdQLq0LC4TYpQOPh1u3N+Ws0lG3OC0oUQm0qGcmNKTu2O/3XlrZwwXvkXZvZq7azuhYmqk189V5GXIJKMTfK5uE3nK88mty2rifE/aRlflxYpgq3jkr2EIbuvEfIj6gk6sEzrlrn1HqIdz2igvgQntQD2cXB3F3ETU4QFqTzJUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CZLyqZsv; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=S9TjXXkA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E495B33681
	for <linux-btrfs@vger.kernel.org>; Sun,  7 Dec 2025 04:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765081427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ITa3xyIvgomeQoLdRCLevanILb5MBoZl35mlTcA8Wk8=;
	b=CZLyqZsvgqw6J1ogNUAAH1PVZzHxzsjCxXigDXi0AKH2NJXv3SG9Ys84pjgSVKYZzn3EHw
	bnIJD3dg2iaeQ2PvPHqClXZahgjsbRXm90Q/JwN3MC2BIWICHcpfw3CVhF7FNsIiAftmAo
	FxbQsqdKzjpay3QDrB9jTtczGx8G2fI=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765081426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ITa3xyIvgomeQoLdRCLevanILb5MBoZl35mlTcA8Wk8=;
	b=S9TjXXkA/gCIOOZoP5ISYxZrQ+EK+XDQyikaBymjNHbSkkvM713imVWkJNkcOOkdf8tbAz
	8SXQjXRNzSac6eyJKiOcQNfYK8veVqEJY76e3eAyi74sccgKygi23xXbl+Og4fkZvBZI8T
	ni174lPGvPQN0EOuU6gW43U9g7A2lmU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 211FF3EA63
	for <linux-btrfs@vger.kernel.org>; Sun,  7 Dec 2025 04:23:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id unQwNVEBNWkaCgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 07 Dec 2025 04:23:45 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: avoid access-byoned-folio for bs > ps encoded writes
Date: Sun,  7 Dec 2025 14:53:20 +1030
Message-ID: <79e1be995894f1c987a54c6298c36459a756b672.1765081384.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.69
X-Spam-Level: 
X-Spamd-Result: default: False [-2.69 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	NEURAL_HAM_SHORT(-0.09)[-0.459];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

[POTENTIAL BUG]
If the system page size is 4K and fs block size is 8K, and max_inline
mount option is set to 6K, we can inline a 6K sized data extent.

Then a encoded write submitted a compressed extent which is at file
offset 0, and the compressed length is 6K, which is allowed to be inlined.

Now a read beyond page boundary is triggered inside write_extent_buffer()
from insert_inline_extent().

[CAUSE]
Currently the function __cow_file_range_inline() can only accept a
single folio.

For regular compressed write path, we always allocate the compressed
folios using the minimal order matching the block size, thus the
@compressed_folio should always cover a full fs block thus it is fine.

But for encoded writes, they allocate page size folios, this means we
can hit a case where the compressed data is smaller than block size but
still larger than page size, in that case __cow_file_range_inline() will
be called with @compressed_size larger than a page.

In that case we will trigger a read beyond the folio inside
insert_inline_extent().

Thankfully this is not that common, as the default max_inline is only
2048 bytes, smaller than PAGE_SIZE, and bs > ps support is still
experimental.

[FIX]
We need to either allow insert_inline_extent() to accept a page array to
properly support such case, or reject such inline extent.

The latter is a much simpler solution, and considering bs > ps will stay
as a corner case and non-default max_inline will be even rarer, I don't
think we really need to fulfill such niche.

So just reject any inline extent that's larger than PAGE_SIZE, and add
an extra ASSERT() to insert_inline_extent() to catch such beyond-boundary
access.

Fixes: ec20799064c8 ("btrfs: enable encoded read/write/send for bs > ps cases")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0cbac085cdaf..2f6be047c6ad 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -482,10 +482,12 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 	 * The compressed size also needs to be no larger than a sector.
 	 * That's also why we only need one page as the parameter.
 	 */
-	if (compressed_folio)
+	if (compressed_folio) {
 		ASSERT(compressed_size <= sectorsize);
-	else
+		ASSERT(compressed_size <= PAGE_SIZE);
+	} else {
 		ASSERT(compressed_size == 0);
+	}
 
 	if (compressed_size && compressed_folio)
 		cur_size = compressed_size;
@@ -572,6 +574,18 @@ static bool can_cow_file_range_inline(struct btrfs_inode *inode,
 	if (offset != 0)
 		return false;
 
+	/*
+	 * Even for bs > ps cases, cow_file_range_inline() can only accept a
+	 * single folio.
+	 *
+	 * This can be problematic and cause access beyond page boundary if a
+	 * page sized folio is passed into that function.
+	 * And encoded write is doing exactly that.
+	 * So here limits the inlined extent size to PAGE_SIZE.
+	 */
+	if (size > PAGE_SIZE || compressed_size > PAGE_SIZE)
+		return false;
+
 	/* Inline extents are limited to sectorsize. */
 	if (size > fs_info->sectorsize)
 		return false;
-- 
2.52.0


