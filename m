Return-Path: <linux-btrfs+bounces-254-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6267F33CF
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 17:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D40061C21C72
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 16:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358FF5B1F7;
	Tue, 21 Nov 2023 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LEqreQjI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B884319A;
	Tue, 21 Nov 2023 08:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700584359; x=1732120359;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=bS+izt25i86OJPhEwD89NOAR8tVmlYBFUeLwZDlkh0I=;
  b=LEqreQjIyUPVJ8z8l7ODxwQFpbfwBjbGI/XQ2dh5L1YaNseHULYYSoWF
   /+ucOxyUp8U8XIGTFgUW4fTunRBihedbFNQEu5TTBxKVhp9USc1RwODhx
   PFqjDEVy4RGtHSGTAg7wzpxxelVCHdWN9NnFSWtXcypYHKGD1Wm+ykSKL
   pSO7lok9jse1l8KPJaKGaCBdSU2YH/4wE3JijAcJlxrYNqJhSSkOyupCm
   fNb0NyJuU5tIL4fLWt2bmQncMs9IjvnngJnDNnrj53GkLOLQHlgTFfsP5
   8CHmrrpzIGawBFYYJss6yFxqUXMvhg24m/CPlc2akgIulUowZqEBPROEp
   Q==;
X-CSE-ConnectionGUID: KUMxJjYARR+J9pxun3k16A==
X-CSE-MsgGUID: ZR4JLwuCSEu64OxxxBAd0A==
X-IronPort-AV: E=Sophos;i="6.04,216,1695657600"; 
   d="scan'208";a="3076035"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Nov 2023 00:32:36 +0800
IronPort-SDR: 6rk3XbVXN9iBuM4qhPXHRwKILhfISyHEyDRoe+rV6gmO0fHuc4ZF048AoQSXkA3A7iOFX81ZNg
 8BIluOz3WnlKYXWRfEH14sVtW4dGAe5RStj0k4zNM0llwZ/MM3Bk09+LAq2ZAsQyp+gbAapsMK
 sjizi/1OCVPle69qKPJwRx0mi5M00ArMiZc1cmX5CFAFNlhjQg48JXmvTp0PJ+G5VKNKCEilGy
 U0qu06LPwOOyznKBDIjlOyJShkrYI7KoE7TdJiXrnwh1Y5UY9qVpiGcV2rLvtNU/WvB9GCZxeI
 Dhg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Nov 2023 07:38:15 -0800
IronPort-SDR: UNUqSkBJ/ydA/hw5JjSvecmx5zIzlhg5WZC2gvr0LS/EFtyRqpTvbjpr0+vHKjn9fjoJQG0mRw
 QZeGugMR1HTR5fOP1GpZVA1YxWe/Kumrwznd+IxVqQWc5L+uS7MeU9bdzf8xfaJGB49qNwnC3w
 Payzzu+OPzvwdtZ+HOcQ8l3oNk8yuZAS8LTFwU7dXct+zAPa7UEjm/8Y3nRm37B2qedlzyuUKW
 msWiLI9W2e6o0xX3oMocxbvBh+dnM9vCn3hLxJOpw8Yfs55VZzYZC3saK5bQr8yVh0WltxzoWv
 LUI=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Nov 2023 08:32:37 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Tue, 21 Nov 2023 08:32:30 -0800
Subject: [PATCH 1/5] btrfs: rename EXTENT_BUFFER_NO_CHECK to
 EXTENT_BUFFER_CANCELLED
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-josef-generic-163-v1-1-049e37185841@wdc.com>
References: <20231121-josef-generic-163-v1-0-049e37185841@wdc.com>
In-Reply-To: <20231121-josef-generic-163-v1-0-049e37185841@wdc.com>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Christoph Hellwig <hch@lst.de>, Naohiro Aota <Naohiro.Aota@wdc.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700584354; l=3043;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=bS+izt25i86OJPhEwD89NOAR8tVmlYBFUeLwZDlkh0I=;
 b=FCEmPciCRqRb3Maq3MBRz4eaMfqNnROnTcW1n6V8DYNA61YPlWKSobzJ36gbBsCEXj6X9nJAH
 xETkC9h6hEwCoi3gZSnNH+lOE2g50q0yUlkvHJg2xNGgKIe0ItAcDym
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

EXTENT_BUFFER_CANCELLED better describes the state of the extent buffer,
namely its writeout has been cancelled.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/disk-io.c     | 2 +-
 fs/btrfs/extent-tree.c | 2 +-
 fs/btrfs/extent_io.c   | 2 +-
 fs/btrfs/extent_io.h   | 3 ++-
 fs/btrfs/zoned.c       | 2 +-
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5ac6789ca55f..ff6140e7eef7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -254,7 +254,7 @@ blk_status_t btree_csum_one_bio(struct btrfs_bio *bbio)
 	if (WARN_ON_ONCE(bbio->bio.bi_iter.bi_size != eb->len))
 		return BLK_STS_IOERR;
 
-	if (test_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags)) {
+	if (test_bit(EXTENT_BUFFER_CANCELLED, &eb->bflags)) {
 		WARN_ON_ONCE(found_start != 0);
 		return BLK_STS_OK;
 	}
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 0455935ff558..f6cbbec539fa 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5041,7 +5041,7 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	__btrfs_tree_lock(buf, nest);
 	btrfs_clear_buffer_dirty(trans, buf);
 	clear_bit(EXTENT_BUFFER_STALE, &buf->bflags);
-	clear_bit(EXTENT_BUFFER_NO_CHECK, &buf->bflags);
+	clear_bit(EXTENT_BUFFER_CANCELLED, &buf->bflags);
 
 	set_extent_buffer_uptodate(buf);
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 03cef28d9e37..74f984885719 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4139,7 +4139,7 @@ static void __write_extent_buffer(const struct extent_buffer *eb,
 	/* For unmapped (dummy) ebs, no need to check their uptodate status. */
 	const bool check_uptodate = !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
 
-	WARN_ON(test_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags));
+	WARN_ON(test_bit(EXTENT_BUFFER_CANCELLED, &eb->bflags));
 
 	if (check_eb_range(eb, start, len))
 		return;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 2171057a4477..d5c9079dc578 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -28,7 +28,8 @@ enum {
 	EXTENT_BUFFER_IN_TREE,
 	/* write IO error */
 	EXTENT_BUFFER_WRITE_ERR,
-	EXTENT_BUFFER_NO_CHECK,
+	/* Indicate the extent buffer write out is cancelled (for zoned) */
+	EXTENT_BUFFER_CANCELLED,
 	/* Indicate that extent buffer pages a being read */
 	EXTENT_BUFFER_READING,
 };
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 188378ca19c7..89cd1664efe1 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1725,7 +1725,7 @@ void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 	ASSERT(!test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
 
 	memzero_extent_buffer(eb, 0, eb->len);
-	set_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags);
+	set_bit(EXTENT_BUFFER_CANCELLED, &eb->bflags);
 	set_extent_buffer_dirty(eb);
 	set_extent_bit(&trans->dirty_pages, eb->start, eb->start + eb->len - 1,
 			EXTENT_DIRTY, NULL);

-- 
2.41.0


