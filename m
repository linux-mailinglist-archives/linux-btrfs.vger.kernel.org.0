Return-Path: <linux-btrfs+bounces-19023-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF5EC5F19C
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 20:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 434E5353C32
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 19:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD243491C8;
	Fri, 14 Nov 2025 19:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="OMyC2uHO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FED320A3C;
	Fri, 14 Nov 2025 19:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763149509; cv=none; b=mE/+rEu0jaSfIOp2XJiJ1q58Rl5orCJ30ZzM8zcKbAP9OwWVp/yWti3qvutFCwPoIYR8iJ780epsZc8BtrAx3Wgl3jxosiMqTGnKf+ywCJ1Rk2jMo4NqKZJI1TQb3R/71JIXIvXdpyusq5DIwrIZ5yI+RqsrWs6FqGuBbdLLxYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763149509; c=relaxed/simple;
	bh=gOFKqzSFiRiOCzWCTdvvgfm0B/xrhVMqhBoEdWG92Rk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DpxZVkxKTR87IyVxEnA5j/3ywYJHKrilN5THqjZSslCGYgfT2bEOOsxL4USIb94JdKbaMw3EEmg9TFr+qlRTYLyW0MXOWdlMvTC1sayJMPHdZIOhLkXd69uS83eOTZSbBI1jtZAYoyi6mWgNHJmYSJ6DQkrIGEu8w/iPOxX4/oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=OMyC2uHO; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Andrey Kalachev <kalachev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1763149504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GZCJwwP3tFzS384hkJ1Q0PkMppgIk1mrNVDIATRmQS0=;
	b=OMyC2uHOuLlEViHQ0HIC20bl6J1LS/n+UrJPIFC3jCtWk3gt/dAWDtoLPADt5FkxmVdnKR
	Yer/qP/Wx9blnknPVovLBfw5lOTyr/buO5qOWv5R1OTdUxHvtuEcvjWLSFgg9ZVc2zpXOM
	SIBhhtNlVA0RyKaT9gSSHBg5S5pch/8=
To: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	fdmanana@suse.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: stable@vger.kernel.org,
	kalachev@swemel.ru,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1.y v2 6/6] btrfs: set start on clone before calling copy_extent_buffer_full
Date: Fri, 14 Nov 2025 22:44:38 +0300
Message-Id: <20251114194438.5694-7-kalachev@swemel.ru>
In-Reply-To: <20251114194438.5694-1-kalachev@swemel.ru>
References: <20251030131254.9225-1-kalachev@swemel.ru>
 <20251114194438.5694-1-kalachev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 53e24158684b527d013b5b2204ccb34d1f94c248 ]

Our subpage testing started hanging on generic/560 and I bisected it
down to 1cab1375ba6d ("btrfs: reuse cloned extent buffer during
fiemap to avoid re-allocations").  This is subtle because we use
eb->start to figure out where in the folio we're copying to when we're
subpage, as our ->start may refer to an area inside of the folio.

For example, assume a 16K page size machine with a 4K node size, and
assume that we already have a cloned extent buffer when we cloned the
previous search.

copy_extent_buffer_full() will do the following when copying the extent
buffer path->nodes[0] (src) into cloned (dest):

  src->start = 8k; // this is the new leaf we're cloning
  cloned->start = 4k; // this is left over from the previous clone

  src_addr = folio_address(src->folios[0]);
  dest_addr = folio_address(dest->folios[0]);

  memcpy(dest_addr + get_eb_offset_in_folio(dst, 0),
	 src_addr + get_eb_offset_in_folio(src, 0), src->len);

Now get_eb_offset_in_folio() is where the problems occur, because for
sub-pagesize blocksize we can have multiple eb's per folio, the code for
this is as follows

  size_t get_eb_offset_in_folio(eb, offset) {
	  return (eb->start + offset & (folio_size(eb->folio[0]) - 1));
  }

So in the above example we are copying into offset 4K inside the folio.
However once we update cloned->start to 8K to match the src the math for
get_eb_offset_in_folio() changes, and any subsequent reads (i.e.
btrfs_item_key_to_cpu()) will start reading from the offset 8K instead
of 4K where we copied to, giving us garbage.

Fix this by setting start before we co copy_extent_buffer_full() to make
sure that we're copying into the same offset inside of the folio that we
will read from later.

All other sites of copy_extent_buffer_full() are correct because we
either set ->start beforehand or we simply don't change it in the case
of the tree-log usage.

With this fix we now pass generic/560 on our subpage tests.

CC: stable@vger.kernel.org # 6.1
Fixes: 1cab1375ba6d ("btrfs: reuse cloned extent buffer during fiemap to avoid re-allocations")
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[cherry picked from upstream commit]
Signed-off-by: Andrey Kalachev <kalachev@swemel.ru>
---
 fs/btrfs/extent_io.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index da90e5a5f855..9816ff562386 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3831,13 +3831,19 @@ static int fiemap_next_leaf_item(struct btrfs_inode *inode, struct btrfs_path *p
 		goto out;
 	}
 
-	/* See the comment at fiemap_search_slot() about why we clone. */
-	copy_extent_buffer_full(clone, path->nodes[0]);
 	/*
 	 * Important to preserve the start field, for the optimizations when
 	 * checking if extents are shared (see extent_fiemap()).
+	 *
+	 * We must set ->start before calling copy_extent_buffer_full().  If we
+	 * are on sub-pagesize blocksize, we use ->start to determine the offset
+	 * into the folio where our eb exists, and if we update ->start after
+	 * the fact then any subsequent reads of the eb may read from a
+	 * different offset in the folio than where we originally copied into.
 	 */
 	clone->start = path->nodes[0]->start;
+	/* See the comment at fiemap_search_slot() about why we clone. */
+	copy_extent_buffer_full(clone, path->nodes[0]);
 
 	slot = path->slots[0];
 	btrfs_release_path(path);
-- 
2.39.5


