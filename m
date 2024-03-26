Return-Path: <linux-btrfs+bounces-3590-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF6988B9D6
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 06:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3712B23420
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 05:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CC312A17D;
	Tue, 26 Mar 2024 05:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lPzBHBbU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F1C84D29
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 05:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711431581; cv=none; b=mGjc53Uw7DIHfmREzM2qcX7cFQwUoYYwxjAjR+x9LBOppQni44VU+PeP9hShro8NVPnbWnNwGp9WVOUIu98AaJlNMQEgT8qBCQe1cj8dylqL2JfL6czerafOtgIAkafsM+2mRQ9MdwpHxE47gtqJZ1xptj4+aZPaOFV4q+zkDhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711431581; c=relaxed/simple;
	bh=sdI0rnWgNWXuMaiziT7y66L2uu3ZMtxbrCnXd/oy/7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FjE9ANgv0MDBTDpxXE2e1RfpOs1j4QpLrGQPFc2+NDzX9Y5I3er3eHnYl+9aLeLJvMkYMYKHBC9ekRmYz3xBzThP+2InY1kbeyM2YTuRWZ4F4QJRcX+PQGPuumxsMsH4glcMAdjvO/F1/k3tkYx7osvJnf8k4Fy4+YWQHslSz6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lPzBHBbU; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1711431580; x=1742967580;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sdI0rnWgNWXuMaiziT7y66L2uu3ZMtxbrCnXd/oy/7k=;
  b=lPzBHBbUk6U/qfyyjPBI1FmhLoJhFRdCcc6dfG1LF5mXiw64kRGA/0LQ
   mjau0RMucaYXzz5qZS9+8/rFSH7foYfS3V6gJTS8hWbb2Uht/g4fWVwTt
   egirxnt1TyUSI2351pJ3cLzjUJiigeFdPywBPzbTD/PvFiL7CHhPaiuY9
   aQZ7/oTvkYMrI6Vp/6xgIYuiiCwqxXMoUtrkacJj2rwou80o3SEank6C0
   o2na6LI5HHmpjFzOiRTd3J+io4CtMrrFGlDih8/WXtNcZWNl4qHyC/uTZ
   mtEJIkzTCpLB8+OKvgPfjqht0LwB7P5UvaTpToYAvZM+PiY3oyX7UTPqt
   g==;
X-CSE-ConnectionGUID: 2lqgWUy3Speg9CQGhZiBow==
X-CSE-MsgGUID: dwT301I5TsWmipW8QYOaSw==
X-IronPort-AV: E=Sophos;i="6.07,155,1708358400"; 
   d="scan'208";a="12317322"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Mar 2024 13:39:35 +0800
IronPort-SDR: eSNfSFkJN5cbI1Cen76n8Iqyf7k6/woIQDcEUXEdY7OMMUf+/Uuk41KYWM8FqHlJVe55pbKTPW
 gnn54minYlwA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Mar 2024 21:48:20 -0700
IronPort-SDR: 076g6uz908PsS6CNDKCwkaCg/Edv+TqTy4kOOsnTgwFomfy1/HZy920EIifhQW/Hv62+QEMGeG
 RkVJG3UhLnvQ==
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.124])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Mar 2024 22:39:34 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 1/2] btrfs: zoned: do not flag ZEROOUT on non-dirty extent bufffer
Date: Tue, 26 Mar 2024 14:39:20 +0900
Message-ID: <3a0f0627bed425503f0d6006ddd937decd682503.1711416290.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1711416290.git.naohiro.aota@wdc.com>
References: <cover.1711416290.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Btrfs clears the content of an extent buffer marked as
EXTENT_BUFFER_ZONED_ZEROOUT before the bio submission. This mechanism is
introduced to prevent a write hole of an extent buffer, which is once
allocated, marked dirty, but turns out unnecessary and cleaned up within
one transaction operation.

Currently, btrfs_clear_buffer_dirty() marks the extent buffer as
EXTENT_BUFFER_ZONED_ZEROOUT, and skip the enteri function. If this call
happens while the buffer is under IO (with the WRITEBACK flag set, without
the DIRTY flag), we can add the ZEROOUT flag and clear the buffer's content
just before a bio submission. As a result, 1) it can lead to adding faulty
delayed reference item which leads to a FS corrupted (EUCLEAN) error, and
2) it writes out cleared tree node on disk

The former issue is previously discussed in [1]. The corruption happens
when it runs a delayed reference update. So, on-disk data is safe.

[1] https://lore.kernel.org/linux-btrfs/3f4f2a0ff1a6c818050434288925bdcf3cd719e5.1709124777.git.naohiro.aota@wdc.com/

The latter one can reach on-disk data. But, as that node is already
btrfs_clear_buffer_dirty()'ed, that will be invalidated in the next
transaction commit anyway. So, the chance of hitting the corruption is
relatively small.

Anyway, we should skip flagging ZEROOUT on a non-DIRTY extent buffer, to
keep the content under IO intact.

Fixes: aa6313e6ff2b ("btrfs: zoned: don't clear dirty flag of extent buffer")
CC: stable@vger.kernel.org # 6.8
Link: https://lore.kernel.org/linux-btrfs/oadvdekkturysgfgi4qzuemd57zudeasynswurjxw3ocdfsef6@sjyufeugh63f/
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 38e689bf148b..bfe7814c818a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4153,7 +4153,7 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
 	 * The actual zeroout of the buffer will happen later in
 	 * btree_csum_one_bio.
 	 */
-	if (btrfs_is_zoned(fs_info)) {
+	if (btrfs_is_zoned(fs_info) && test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags)) {
 		set_bit(EXTENT_BUFFER_ZONED_ZEROOUT, &eb->bflags);
 		return;
 	}
-- 
2.44.0


