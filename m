Return-Path: <linux-btrfs+bounces-15751-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C0FB15E52
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 12:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA58018C3DFA
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 10:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5A128F53F;
	Wed, 30 Jul 2025 10:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YImGyRD+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E43E28DEE0
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Jul 2025 10:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753871774; cv=none; b=Kg+54NkcWOtZbU4DkSmlmzCWsHBpk8yVBtJFz8S/W8jcFNYbgaHfIeepKNM9xNUJqFJ2BvI1iilVi8abr11qeIFL8IY2j5TARyHqis4166RxIU8m7y838Lqp/3e4ZAreyNYxUkVk7wKPhWLHivLMD21CRGXXOhjhRGMy9ykiVsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753871774; c=relaxed/simple;
	bh=aLo6QRsMDCPNf0WqLSuob5QIDj5wkUs07FN/mmFAZA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mwWmvWF2Sv66LTqUm7+jcno7o7HJ25sSfsGeRlqw/UkZ9n6cUkBhvASf1cwIpBFNY6D+4aRFvxCZXcy7SWfkLl55OQkvir623PESuPsMGaNcICa4rsXpN/Gh87LUmaEM98KwNOSNUZqt8/Yh4pKw+EnNi/03ejZpRkS++vxj50o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YImGyRD+; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1753871772; x=1785407772;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aLo6QRsMDCPNf0WqLSuob5QIDj5wkUs07FN/mmFAZA0=;
  b=YImGyRD+DAS+0vcKripEzLsbhocjKKDKAjy/ZLcmSbGNaNv1W52Ytecu
   YWWYJ62rX4W+cQ+PlPyXXfHmmo0EYVEldJQKHdTzxF3VcbekT7xsv0A2S
   /P9r+QxwNHy7xmBk45flQakzdcbDY3YfM3eBD9MwmwnckdCQYmmKgemC5
   3rgTM18TVnhND7420yQYvRlBsgu2FCuV0MuvQ+RciOjHaOXMTvbkUaBdj
   kaF7VN6kCY+wDSDYNDTq13+LsJEciDiSZhk5O8wl4ZGWsZw2AOxzGaFaH
   n2teFVRogD9yQw+6LiTpb+u1pEqawyKLaJkqKaH7yp7DSAQDP9sFdiXkq
   A==;
X-CSE-ConnectionGUID: EuYzzsPdSfqarskzOyJykA==
X-CSE-MsgGUID: S9zk4ISxQMi/T488f0Aa8g==
X-IronPort-AV: E=Sophos;i="6.16,350,1744041600"; 
   d="scan'208";a="102978195"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jul 2025 18:36:06 +0800
IronPort-SDR: 6889e6de_vUuKKOSoVbvNUBzmBRGSOK6DhDymyjiDupthyTSAMptO++L
 4LMkK/jqTfbWTsj40zFcocQZrOb8D/rwES202tQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jul 2025 02:33:18 -0700
WDCIronportException: Internal
Received: from 5cg2148fr4.ad.shared (HELO naota-xeon) ([10.224.173.92])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 Jul 2025 03:36:05 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: wqu@suse.com,
	Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: subpage: keep TOWRITE tag until folio is cleaned
Date: Wed, 30 Jul 2025 19:35:34 +0900
Message-ID: <20250730103534.259857-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

btrfs_subpage_set_writeback() calls folio_start_writeback() the first time
a folio is written back, and it also clears the PAGECACHE_TAG_TOWRITE tag
even if there are still dirty pages in the folio. This can break ordering
guarantees, such as those required by btrfs_wait_ordered_extents().

Consider process A calling writepages() with WB_SYNC_NONE. In zoned mode or
for compressed writes, it locks several folios for delalloc and starts
writing them out. Let's call the last locked folio folio X. Suppose the
write range only partially covers folio X, leaving some pages dirty.
Process A calls btrfs_subpage_set_writeback() when building a bio. This
function call clears the TOWRITE tag of folio X.

Now suppose process B concurrently calls writepages() with WB_SYNC_ALL. It
calls tag_pages_for_writeback() to tag dirty folios with
PAGECACHE_TAG_TOWRITE. Since folio X is still dirty, it gets tagged. Then,
B collects tagged folios using filemap_get_folios_tag() and must wait for
folio X to be written before returning from writepages().

However, between tagging and collecting, process A may call
btrfs_subpage_set_writeback() and clear folio X’s TOWRITE tag. As a result,
process B won’t see folio X in its batch, and returns without waiting for
it. This breaks the WB_SYNC_ALL ordering requirement.

Fix this by using btrfs_subpage_set_writeback_keepwrite(), which retains
the TOWRITE tag. We now manually clear the tag only after the folio becomes
clean, via the xas operation.

Fixes: 55151ea9ec1b ("btrfs: migrate subpage code to folio interfaces")
CC: stable@vger.kernel.org # 6.12+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/subpage.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index c9b3821957f7..67cbf0b15b4a 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -448,8 +448,25 @@ void btrfs_subpage_set_writeback(const struct btrfs_fs_info *fs_info,
 
 	spin_lock_irqsave(&bfs->lock, flags);
 	bitmap_set(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
+
+	/*
+	 * Don't clear the TOWRITE tag when starting writeback on a still-dirty
+	 * folio. Doing so can cause WB_SYNC_ALL writepages() to overlook it,
+	 * assume writeback is complete, and exit too early — violating sync
+	 * ordering guarantees.
+	 */
 	if (!folio_test_writeback(folio))
-		folio_start_writeback(folio);
+		folio_start_writeback_keepwrite(folio);
+	if (!folio_test_dirty(folio)) {
+		struct address_space *mapping = folio_mapping(folio);
+		XA_STATE(xas, &mapping->i_pages, folio->index);
+		unsigned long flags;
+
+		xas_lock_irqsave(&xas, flags);
+		xas_load(&xas);
+		xas_clear_mark(&xas, PAGECACHE_TAG_TOWRITE);
+		xas_unlock_irqrestore(&xas, flags);
+	}
 	spin_unlock_irqrestore(&bfs->lock, flags);
 }
 
-- 
2.50.1


