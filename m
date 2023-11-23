Return-Path: <linux-btrfs+bounces-321-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63ACC7F6345
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Nov 2023 16:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951AA1C208E4
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Nov 2023 15:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6403D99C;
	Thu, 23 Nov 2023 15:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="R+9dpOg/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E7310C7;
	Thu, 23 Nov 2023 07:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700754485; x=1732290485;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=wDRvUXJ6mVtVEukoOw489ax7uRNihNJAyUogAfyAXjo=;
  b=R+9dpOg/6Hp3aHGsBdmm0rvSxUfETtUxXGRJrfe4pDF0I6dES9gQQwUl
   dkNlQNcTF++HUIZM+w9PsFDUVlMS9/USXW5czV5kJbRtvM3JqtNeFJ0r+
   NO9s6I8T6b/LOnf7i3At4Kw7vGu30xBtR+Uh4C8MarjCLlQ6UwrMh2vpD
   mkhXgQ/EfojE1WhN2sCvUpuZwfQd/lrJ3NwnlHtWSEKO2k7jobRfzZNyq
   qoLGgkUGtV01hW4JAzdEs0x8ILESpNdQmixRAElFypUSm+opPCtKprNA9
   oqjKuh0aY81loE4aa3ZZ9cEeGOYUCUswYbfoKGIa1qhOGcswRbhbHHNvU
   Q==;
X-CSE-ConnectionGUID: qm7DTtz6QSmbuesitw53/A==
X-CSE-MsgGUID: dn+w52BeRFuwgv74kXNuBA==
X-IronPort-AV: E=Sophos;i="6.04,222,1695657600"; 
   d="scan'208";a="3129202"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Nov 2023 23:47:30 +0800
IronPort-SDR: iQWjHGWnJ2d3Al3koAjvSDHT6ncLcFx6OLwirWGTxoRWOVkAAG93GoZ/J9gKGFZt73/bndgdYb
 gldZet+AtQDEyrOjMC1YoCj68EWhgrYY0HaoxJ7AitfbSfN8H3tb/948RLhT85c1ffLoeP/mMx
 ghclrDD7DJHG/tswgccqFZNyy/O/hUjqwQgw2jGj4r5mbKlGoUS40uUm2WaDEzkALoj4Lgyb9h
 fMFVT59YyOBvleveehkFzLor6S9ORxp7ihkMHqgJT3Q5d/z8RAANpgxrfGcia5xcVMuhWv4XTY
 HFI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2023 06:58:46 -0800
IronPort-SDR: lsfs8oPCU2giWsDgpzJxi9WE8DUXV7CFkSxklSygvHSG9EcNPfeN4Q4gYK83j5EJMjQauUSJbN
 0LuCQNzc8GKl7XOJHWw3MJ+mLXoUhI5RZcpXcSLj930p2e7dQtsmHT4fVu7TAtaRYQTXgcM6Zy
 6IWKfhkMtvD1srEUhdqhmdJ/3i9CZu9u99dUftFIVRXFOML7abbd3wAoYXeS/ooUCeN2BPlt5p
 7neHxvd2fgcTfUu0rwpk/OSaWS44EGWxlLLPpceVXBfNJ7SmN8Phgzsj/OnS4lVDNSIPfCzto3
 JsU=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Nov 2023 07:47:27 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Thu, 23 Nov 2023 07:47:16 -0800
Subject: [PATCH v2 2/5] btrfs: zoned: don't clear dirty flag of extent
 buffer
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231123-josef-generic-163-v2-2-ed1a79a8e51e@wdc.com>
References: <20231123-josef-generic-163-v2-0-ed1a79a8e51e@wdc.com>
In-Reply-To: <20231123-josef-generic-163-v2-0-ed1a79a8e51e@wdc.com>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Christoph Hellwig <hch@lst.de>, Naohiro Aota <Naohiro.Aota@wdc.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700754443; l=3002;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=wDRvUXJ6mVtVEukoOw489ax7uRNihNJAyUogAfyAXjo=;
 b=sWqCwaHo+SgYIPyXduOpD5Wi4szyqt/vJ2WunGbdgKcWSpUf3mkQvzvJRN8D03LagqUwYT2YG
 ExQbTtlzkgRBdoyFKyIELaHsoyYWiZUrx4ehZgrX39GtkPzHYsyrjo1
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

One a zoned filesystem, never clear the dirty flag of an extent buffer,
but instead mark it as zeroout.

On writeout, when encountering a marked extent_buffer, zero it out.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/disk-io.c   |  7 ++++++-
 fs/btrfs/extent_io.c | 16 ++++++++++++++--
 fs/btrfs/zoned.c     |  3 ++-
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 460b88526f56..9c09062d3d0a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -254,8 +254,13 @@ blk_status_t btree_csum_one_bio(struct btrfs_bio *bbio)
 	if (WARN_ON_ONCE(bbio->bio.bi_iter.bi_size != eb->len))
 		return BLK_STS_IOERR;
 
+	/*
+	 * If an extent_buffer is marked as EXTENT_BUFFER_ZONED_ZEROOUT, don't
+	 * checksum it but zero-out its content. This is done to preserve
+	 * ordering of I/O without unnecessarily writing out data.
+	 */
 	if (test_bit(EXTENT_BUFFER_ZONED_ZEROOUT, &eb->bflags)) {
-		WARN_ON_ONCE(found_start != 0);
+		memzero_extent_buffer(eb, 0, eb->len);
 		return BLK_STS_OK;
 	}
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 49514ef829fb..c378094b5cc8 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3748,6 +3748,20 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
 	if (trans && btrfs_header_generation(eb) != trans->transid)
 		return;
 
+	/*
+	 * Instead of clearing the dirty flag off of the buffer, mark it as
+	 * EXTENT_BUFFER_ZONED_ZEROOUT. This allows us to preserve
+	 * write-ordering in zoned mode, without the need to later re-dirty
+	 * the extent_buffer.
+	 *
+	 * The actual zeroout of the buffer will happen later in
+	 * btree_csum_one_bio.
+	 */
+	if (btrfs_is_zoned(fs_info)) {
+		set_bit(EXTENT_BUFFER_ZONED_ZEROOUT, &eb->bflags);
+		return;
+	}
+
 	if (!test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags))
 		return;
 
@@ -4139,8 +4153,6 @@ static void __write_extent_buffer(const struct extent_buffer *eb,
 	/* For unmapped (dummy) ebs, no need to check their uptodate status. */
 	const bool check_uptodate = !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
 
-	WARN_ON(test_bit(EXTENT_BUFFER_ZONED_ZEROOUT, &eb->bflags));
-
 	if (check_eb_range(eb, start, len))
 		return;
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index b9bfde6fb929..ed8e002b33e7 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1722,7 +1722,8 @@ void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 	    btrfs_header_flag(eb, BTRFS_HEADER_FLAG_WRITTEN))
 		return;
 
-	ASSERT(!test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
+	ASSERT(test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
+	ASSERT(test_bit(EXTENT_BUFFER_ZONED_ZEROOUT, &eb->bflags));
 
 	memzero_extent_buffer(eb, 0, eb->len);
 	set_bit(EXTENT_BUFFER_ZONED_ZEROOUT, &eb->bflags);

-- 
2.41.0


