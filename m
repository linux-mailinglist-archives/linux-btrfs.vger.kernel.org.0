Return-Path: <linux-btrfs+bounces-4288-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5368A5E6D
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 01:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F3951C20DD6
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 23:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3B1159206;
	Mon, 15 Apr 2024 23:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hBwCC/0u";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vMXHWb9d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04DD15746D
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 23:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713224170; cv=none; b=MYT1ViCIYjzookKPeTs2Yu+rcXmhTAS8jrIV0m0u4BVCm2ojDZJp3YQlEcjPdA/0tQ9VjsiV6OluDAiH2Emyl74+ihE8rmD3A4h9NRIrMnxsxqs8PQnkUFHiCVZtUNLIDuPQEo49ZoWYWqiCjlcRtWUe0VTE2cTX2Y7SY7cilRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713224170; c=relaxed/simple;
	bh=iyigEEghyqfaq4beWuemVzPOxUhbZC7lm9cajPWnN5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cy0owJ7A8lLFpAnFCGu6Sl4r35ltg+dHRdofoAwZo/rtjbeGi0kja61O8i9c/r2EwsIQoTD2V0EOlcXjqmU3u79BwX8SFex48lcC1Lpsq0gO2Fs0z4btElYt9DxTW5tnkT2B5ICsFu+nD1IPK1Gt7N7U7sDUlLX4LiB7zJ6yk5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hBwCC/0u; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=vMXHWb9d; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F0AA83762A;
	Mon, 15 Apr 2024 23:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713224164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W+W3eyhTPhFh3H+d3eHTVEFq9E5NTf0/YVcrJToa2As=;
	b=hBwCC/0uhGOOZNp7NhwSnX+IP49gYmJnsqH9ekc3zUGXdbyczIcqi7Oyq9ggG7DbvD4IGJ
	vwa4iJdmi2SCPfUNJ7yA5Rq+oc00Ll5xUGYQdWaB5iLv4xZgM02P8mS36pNfkL070sYkkb
	RrKvVoB3Puoz/mKHZnEyDp9WZ/Hbxl8=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713224163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W+W3eyhTPhFh3H+d3eHTVEFq9E5NTf0/YVcrJToa2As=;
	b=vMXHWb9dhhhg7F02WDtx8zkJ7QIXfVKKu+Y9E7/5VRYW/srezJ+yJ+S8bbLQak/NEEdEIY
	QvV3gEc2FPvqa5Qj8w1RdlgdxwKPdEdOGnr1DUqCmWcS9gWVAlQ7BRgHAOh/Yom9qZJl6d
	zBAarC2VVuowKZH0W4tXgFkzHfhzPzM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E563A1368B;
	Mon, 15 Apr 2024 23:36:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OKbLKOK5HWZyTQAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 15 Apr 2024 23:36:02 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v5 3/3] btrfs: add extra sanity checks for create_io_em()
Date: Tue, 16 Apr 2024 09:05:40 +0930
Message-ID: <b63666662f99e0c93b192bfb539e4d697436c4f4.1713224013.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713224013.git.wqu@suse.com>
References: <cover.1713224013.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	RCVD_TLS_ALL(0.00)[]

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

Reviewed-by: Filipe Manana <fdmanana@suse.com>
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


