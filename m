Return-Path: <linux-btrfs+bounces-257-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E652D7F33D2
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 17:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2074F1C21C44
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 16:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582DD5B214;
	Tue, 21 Nov 2023 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VOeMVvJm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CFB19E;
	Tue, 21 Nov 2023 08:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700584360; x=1732120360;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=L3NVSoa0Cpx4pPFIb1TUWiVH9DFoJOyUHEUP90OBa2o=;
  b=VOeMVvJmaIxB9oqY60BqtyFKYrkSxRBb1mq2L1T3iR7qHnEf4At7hJwY
   0orSLXxrxFvtE7CG27IRrOyhrB/xj1u0Kb/LQQhSlJR0o4hmd6ffKmdT3
   EoHjbO1Es3ND4apR0b3F1oW2MkTZv/chhnVGwhQ2N1zHcwvRFDCIkz75l
   YY60XsKE0tqg8Wvg6MN33m0IJ6qd0MxmBpioH+jzNMGLbaOvJWHXhF/QV
   tYnxx5WuIi62s/cxHOnq+1JUPWNO2ya3SUeNFigQQpDH1yylP/7WRNTKS
   JkapmtWtWwxnBO+ToOQOnRFMEN4kQ8tXXxla/H2d///dc7Ph9VqiiJLM7
   A==;
X-CSE-ConnectionGUID: 3JGdFnzGRSWh2k++jw3oxw==
X-CSE-MsgGUID: nzNMQh8DQPmy/kX0jkgMBw==
X-IronPort-AV: E=Sophos;i="6.04,216,1695657600"; 
   d="scan'208";a="3076038"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Nov 2023 00:32:38 +0800
IronPort-SDR: ZW7tzteNq4G/Ea4JGzf0Pp9WSW6Bz19/35qspf9REDQQlIa5nQ9IjgKpvDd30WnGdgakJeiH/k
 Kiqltc7Y+ua481d33pw1U8n0pLYDRc17Y5vatPQF34ByKz4v9ftxsLBC7eUjqrCkbFMx2mbNFI
 JWeppZgicR8RtGnkC9T0A3EieioOw0zMfa+2xP+DFkxulHTxcSnR3nkG+eeJ/pUxjf3z+lK9FO
 4LNipNJrvFUcZ5q2tUcPjkB4OFiHgsVEP2Unl11FC3p4dDVlkF0JVXm7T7ZlMYyd3IORMrwXpx
 +Fs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Nov 2023 07:38:16 -0800
IronPort-SDR: IOKuH+FE/Sxtimd3j5gs6rbKKgH4w5JW7AtaTKCl1+ZX6G+wtmAZPCkaIlDsSVHaZkYYWFk8Oq
 0vxxGEVQKzpUL8lCaE7fCxR1cEsMMRtPenl/6oFiMuh1fxMGoFDh3N7uJskra70O/A/Odk6lKL
 6cUJOLxCBc21SesKtl25Xnijz1f8JwpRfdyiPx6lSZgKMy4BTSfKGqHYnMjhnJnG5sBq9URVIL
 EmHHQ/WrieVC8aMYMd+1G1mwd8Kb/xGQnFqym/zstEBKRMQ8YG6ZfQ+CxETtpz0bQtIvTFG13Z
 Kuc=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Nov 2023 08:32:38 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Tue, 21 Nov 2023 08:32:31 -0800
Subject: [PATCH 2/5] btrfs: zoned: don't clear dirty flag of extent buffer
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-josef-generic-163-v1-2-049e37185841@wdc.com>
References: <20231121-josef-generic-163-v1-0-049e37185841@wdc.com>
In-Reply-To: <20231121-josef-generic-163-v1-0-049e37185841@wdc.com>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Christoph Hellwig <hch@lst.de>, Naohiro Aota <Naohiro.Aota@wdc.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700584354; l=2264;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=L3NVSoa0Cpx4pPFIb1TUWiVH9DFoJOyUHEUP90OBa2o=;
 b=T9kBt7f2Hj0NyDJUnB2/A2fnDALdHmF2eaDZtiMrukTgRelffox9lplELS0/Arzh7ecOgcrM6
 1OmbzpOZOpzCtJdugdkd6eXglwZSesqiGu59vI2GkXuBp+uKTtTS3ib
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

One a zoned filesystem, never clear the dirty flag of an extent buffer,
but instead mark it as cancelled.

On writeout, when encountering cancelled extent_buffers, zero them out.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/disk-io.c   | 2 +-
 fs/btrfs/extent_io.c | 7 +++++--
 fs/btrfs/zoned.c     | 3 ++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ff6140e7eef7..f259bae1c3ee 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -255,7 +255,7 @@ blk_status_t btree_csum_one_bio(struct btrfs_bio *bbio)
 		return BLK_STS_IOERR;
 
 	if (test_bit(EXTENT_BUFFER_CANCELLED, &eb->bflags)) {
-		WARN_ON_ONCE(found_start != 0);
+		memzero_extent_buffer(eb, 0, eb->len);
 		return BLK_STS_OK;
 	}
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 74f984885719..8bc5025ce278 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3748,6 +3748,11 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
 	if (trans && btrfs_header_generation(eb) != trans->transid)
 		return;
 
+	if (btrfs_is_zoned(fs_info)) {
+		set_bit(EXTENT_BUFFER_CANCELLED, &eb->bflags);
+		return;
+	}
+
 	if (!test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags))
 		return;
 
@@ -4139,8 +4144,6 @@ static void __write_extent_buffer(const struct extent_buffer *eb,
 	/* For unmapped (dummy) ebs, no need to check their uptodate status. */
 	const bool check_uptodate = !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
 
-	WARN_ON(test_bit(EXTENT_BUFFER_CANCELLED, &eb->bflags));
-
 	if (check_eb_range(eb, start, len))
 		return;
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 89cd1664efe1..117e041bdc7a 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1722,7 +1722,8 @@ void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 	    btrfs_header_flag(eb, BTRFS_HEADER_FLAG_WRITTEN))
 		return;
 
-	ASSERT(!test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
+	ASSERT(test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
+	ASSERT(test_bit(EXTENT_BUFFER_CANCELLED, &eb->bflags));
 
 	memzero_extent_buffer(eb, 0, eb->len);
 	set_bit(EXTENT_BUFFER_CANCELLED, &eb->bflags);

-- 
2.41.0


