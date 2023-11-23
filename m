Return-Path: <linux-btrfs+bounces-322-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEB57F6348
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Nov 2023 16:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B77C1C20DD4
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Nov 2023 15:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160793E47D;
	Thu, 23 Nov 2023 15:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rahNFFSN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394BA10C4;
	Thu, 23 Nov 2023 07:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700754485; x=1732290485;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=YR0t4kJbsg/rQjWSgH2abh/zRKciGglDOIEvPoc2P7I=;
  b=rahNFFSNEKCl9wp3tFBb3T3d+FL4YTJLkDPgL04lMb6k50TcqiY3VViT
   EMclWijOGmzsQNzSbOWY8LesyEDROwKbS8zJPeBONPhrJ73VAKKaac3NZ
   xy9HFMlk56NpmpUgm920c+3Cri6FxKZczfwPmv5s2mo8LLLC+yTTgCmpO
   kwDmZxfps8tp1fqM8JAKubqgdWuFuwGuFnmnut1DnwduLjGQg/Mct+9+6
   fZBl4/T4Fx/DFovsUIOHkILmIOF+Q83r0eJe/xogeaBv/fO4bkBF7KwN6
   TBDqLVEC+dq9W2G4DNznTX1GhqnxjRoeiJ0eL91vGs5Oi5Scuc7vwk5BJ
   A==;
X-CSE-ConnectionGUID: JowBlqUCTcejboqeqn3hkw==
X-CSE-MsgGUID: rgWc+jNbSTuzevXQlWiasw==
X-IronPort-AV: E=Sophos;i="6.04,222,1695657600"; 
   d="scan'208";a="3129200"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Nov 2023 23:47:27 +0800
IronPort-SDR: H2b91i91NAiwEos5V1g0Z4jHH0hCm6eSBg0Lrxm2+EhQH9+trT46xFLtWexJjnwqD7JpB5l/az
 FiQaPAgOBizEmuCT4ENGlLW5ig47aPb8BjPpU869sKXaysxMV854KjuocJrzG6Of0oWFP7hoJe
 dlI2DYDoyYXmrQjMyoBf7RhaeSme1OWNNAYo7/2YBJN/RFXJStunqJU3NIcjXPLi+yEgO5zt83
 YVlgOaJZxhkIJpFTFLJlk3vBCaohdHNyc5LfKMIa6xaYMWv1x2ju6zG/gHN5UvBpFh2mI+p9j9
 s4Q=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2023 06:58:43 -0800
IronPort-SDR: 0z6dPAeIYvdBScoL+Y/i3Iff/c07B61B/rY/Z6npaAVJYfe+K6htIJjpnjmCMlVv/VN5nlnrvY
 A0AkbTzyZubCf5cF774S2sK/92jeAX6yuGZIDn2vz2SEx9hS67/f8bp37nJf5EBwgZbmLQIc8A
 ns9TaUTH/6VydUzBBmg9tullFJHsqpQ3qDk+HAaXDgLe6O3+Zf+u8a+knQn6u5sdIIXMRo8A2m
 u4Vupthh+nsKWeYScULbV3pqYevK2ng46GV+DUEA3ZELYyfezdZdjwsqdBk+QLKnbbdkD1UYL3
 VGg=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Nov 2023 07:47:26 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Thu, 23 Nov 2023 07:47:15 -0800
Subject: [PATCH v2 1/5] btrfs: rename EXTENT_BUFFER_NO_CHECK to
 EXTENT_BUFFER_ZONED_ZEROOUT
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231123-josef-generic-163-v2-1-ed1a79a8e51e@wdc.com>
References: <20231123-josef-generic-163-v2-0-ed1a79a8e51e@wdc.com>
In-Reply-To: <20231123-josef-generic-163-v2-0-ed1a79a8e51e@wdc.com>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Christoph Hellwig <hch@lst.de>, Naohiro Aota <Naohiro.Aota@wdc.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700754443; l=3212;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=YR0t4kJbsg/rQjWSgH2abh/zRKciGglDOIEvPoc2P7I=;
 b=TkJecc8Wo6SeIaMwQIaMhC8B4+Q3j63Hbdtaowtmu0kWfKcsprkpN/fxhsJXiLhKnOouzRKSE
 YX41J3GMJPjCCBJKEA1nzOGIVxGN0jREPEJdFj2FLnJLZRiTcYW+FkB
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

EXTENT_BUFFER_ZONED_ZEROOUT better describes the state of the extent buffer,
namely it is written as all zeros. This is needed in zoned mode, to
preserve I/O ordering.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/disk-io.c     | 2 +-
 fs/btrfs/extent-tree.c | 2 +-
 fs/btrfs/extent_io.c   | 2 +-
 fs/btrfs/extent_io.h   | 3 ++-
 fs/btrfs/zoned.c       | 2 +-
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5ac6789ca55f..460b88526f56 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -254,7 +254,7 @@ blk_status_t btree_csum_one_bio(struct btrfs_bio *bbio)
 	if (WARN_ON_ONCE(bbio->bio.bi_iter.bi_size != eb->len))
 		return BLK_STS_IOERR;
 
-	if (test_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags)) {
+	if (test_bit(EXTENT_BUFFER_ZONED_ZEROOUT, &eb->bflags)) {
 		WARN_ON_ONCE(found_start != 0);
 		return BLK_STS_OK;
 	}
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 0455935ff558..2d8379d34a24 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5041,7 +5041,7 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	__btrfs_tree_lock(buf, nest);
 	btrfs_clear_buffer_dirty(trans, buf);
 	clear_bit(EXTENT_BUFFER_STALE, &buf->bflags);
-	clear_bit(EXTENT_BUFFER_NO_CHECK, &buf->bflags);
+	clear_bit(EXTENT_BUFFER_ZONED_ZEROOUT, &buf->bflags);
 
 	set_extent_buffer_uptodate(buf);
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 03cef28d9e37..49514ef829fb 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4139,7 +4139,7 @@ static void __write_extent_buffer(const struct extent_buffer *eb,
 	/* For unmapped (dummy) ebs, no need to check their uptodate status. */
 	const bool check_uptodate = !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
 
-	WARN_ON(test_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags));
+	WARN_ON(test_bit(EXTENT_BUFFER_ZONED_ZEROOUT, &eb->bflags));
 
 	if (check_eb_range(eb, start, len))
 		return;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 2171057a4477..b8adb5b6fb21 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -28,7 +28,8 @@ enum {
 	EXTENT_BUFFER_IN_TREE,
 	/* write IO error */
 	EXTENT_BUFFER_WRITE_ERR,
-	EXTENT_BUFFER_NO_CHECK,
+	/* Indicate the extent buffer is written zeroed out (for zoned) */
+	EXTENT_BUFFER_ZONED_ZEROOUT,
 	/* Indicate that extent buffer pages a being read */
 	EXTENT_BUFFER_READING,
 };
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 188378ca19c7..b9bfde6fb929 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1725,7 +1725,7 @@ void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 	ASSERT(!test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
 
 	memzero_extent_buffer(eb, 0, eb->len);
-	set_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags);
+	set_bit(EXTENT_BUFFER_ZONED_ZEROOUT, &eb->bflags);
 	set_extent_buffer_dirty(eb);
 	set_extent_bit(&trans->dirty_pages, eb->start, eb->start + eb->len - 1,
 			EXTENT_DIRTY, NULL);

-- 
2.41.0


