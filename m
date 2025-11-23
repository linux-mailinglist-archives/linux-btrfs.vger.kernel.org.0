Return-Path: <linux-btrfs+bounces-19273-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C56C7E9B5
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 00:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6BFBE4E155C
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Nov 2025 23:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC14219301;
	Sun, 23 Nov 2025 23:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dzFxONIi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dzFxONIi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5382E36D4F4
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Nov 2025 23:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763940771; cv=none; b=hSGx3oKOO75ssuPWBuDgvx1DEzIoL03FQdB4WB0s2BuitIYUOqw3Kz/SKh4bGKeIsmNy2M11au04EZr1wiB/WeEmYWflT/3dAPL8MugOz5574IrokVdEq/LGDALmxvDN0VRnXTrwmZSmISTplPr2NxeJjsQqiLXbZcyo2HRw+CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763940771; c=relaxed/simple;
	bh=BGbnZFr7Lg5gLhN5m7WPCaEHnh+eSb6ghpfz13TCUc0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nr1PBt68229gcX22eScJO1ovEF7dMwg9mt9j3/S3JMQFdoB27VE5D48GRotVp3G9tHU9JDOpq2n40IGjCY0hazf9zt4v/66wDy3IrUjQxwbmvKgWV39UeyP4YOuTy1zag+rwvmE1ZuHcgUtGCjwMdlq2/nEvjlmWATMHVwIIjEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dzFxONIi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dzFxONIi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 26C5B5BCF3
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Nov 2025 23:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763940766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YtsmSfkuUm9FeSjPqkQ+UurhTuMkttqpuyH3phD1NnI=;
	b=dzFxONIikspHFn8GAlHovjvHsrSjMKtJnR82w3xRcxg+itNoCsNK9IR08BcDtnVhltPGHv
	8N7SZ1NHCBHSh3kpW5u9CqIotJiUWzWHNXXHqR6JQi8Y3oCMoO2ZVXswIP0jQ1tN8RCW4Y
	lVscTIOAuhCo9dXLaesqqIqQOGkof9k=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763940766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YtsmSfkuUm9FeSjPqkQ+UurhTuMkttqpuyH3phD1NnI=;
	b=dzFxONIikspHFn8GAlHovjvHsrSjMKtJnR82w3xRcxg+itNoCsNK9IR08BcDtnVhltPGHv
	8N7SZ1NHCBHSh3kpW5u9CqIotJiUWzWHNXXHqR6JQi8Y3oCMoO2ZVXswIP0jQ1tN8RCW4Y
	lVscTIOAuhCo9dXLaesqqIqQOGkof9k=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66A1B3EA61
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Nov 2025 23:32:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WHTECp2ZI2kGRQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Nov 2025 23:32:45 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: return the largest hole between two file extent items
Date: Mon, 24 Nov 2025 10:02:24 +1030
Message-ID: <8f8e8639c8b7cdde04d0930017a2f354f33c82d4.1763939785.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1763939785.git.wqu@suse.com>
References: <cover.1763939785.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

[CORNER CASE]
If we have the following file extents layout, btrfs_get_extent() can
return a smaller hole and cause unnecessary extra tree search:

	item 6 key (257 EXTENT_DATA 0) itemoff 15810 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 13631488 nr 4096
		extent data offset 0 nr 4096 ram 4096
		extent compression 0 (none)

	item 7 key (257 EXTENT_DATA 32768) itemoff 15757 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 13635584 nr 4096
		extent data offset 0 nr 4096 ram 4096
		extent compression 0 (none)

In above case, range [0, 4K) and [32K, 36K) are regular extents, and
there is a hole in range [4K, 32K), and the fs has "no-holes" feature,
meaning the hole will not have a file extent item.

[INEFFICIENCY]
Assume the system has 4K page size, and we're doing readahead for range
[4K, 32K), no large folio yet.

 btrfs_readahead() for range [4K, 32K)
 |- btrfs_do_readpage() for folio 4K
 |  |- get_extent_map() for range [4K, 8K)
 |     |- btrfs_get_extent() for range [4K, 8K)
 |        We hit item 6, then for the next item 7.
 |        At this stage we know range [4K, 32K) is a hole.
 |        But our search range is only [4K, 8K), not reaching 32K, thus
 |        we go into not_found: tag, returning a hole em for [4K, 8K).
 |
 |- btrfs_do_readpage() for folio 8K
 |  |- get_extent_map() for range [8K, 12K)
 |     |- btrfs_get_extent() for range [8K, 12K)
 |        We hit the same item 6, and then item 7.
 |        But still we goto not_found tag, inserting a new hole em,
 |        which will be merged with previous one.
 |
 | [ Repeat the same btrfs_get_extent() calls until the end ]

So we're calling btrfs_get_extent() again and again, just for a
different part of the same hole range [4K, 32K).

[ENHANCEMENT]
The problem is inside the next: tag, where if we find the next file extent
item and knows it's beyond our search range start.

But there is no need to fallback to not_found: tag, if we know there is
a larger hole for [start, found_key.offset).

By removing the check for (start + len) against (found_key.offset), we can
improve the above read loop by:

 btrfs_readahead()
 btrfs_readahead() for range [4K, 32K)
 |- btrfs_do_readpage() for folio 4K
 |  |- get_extent_map() for range [4K, 8K)
 |     |- btrfs_get_extent() for range [4K, 8K)
 |        We hit item 6, then for the next item 7.
 |        At this stage we know range [4K, 32K) is a hole.
 |        So the hole em for range [4K, 32K) is returned.
 |
 |- btrfs_do_readpage() for folio 8K
 |  |- get_extent_map() for range [8K, 12K)
 |     The cached hole em range [4K, 32K) covers the range,
 |     and reuse that em.
 |
 | [ Repeat the same btrfs_get_extent() calls until the end ]

Now we only call btrfs_get_extent() once for the whole range [4K, 32K),
other than the old 8 times.

Although again I do not expect much difference for the real world
performance.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3cf30abcdb08..3a76cea1d43d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7181,8 +7181,6 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 		if (found_key.objectid != objectid ||
 		    found_key.type != BTRFS_EXTENT_DATA_KEY)
 			goto not_found;
-		if (start + len <= found_key.offset)
-			goto not_found;
 		if (start > found_key.offset)
 			goto next;
 
-- 
2.52.0


