Return-Path: <linux-btrfs+bounces-7390-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C80DD95AA8A
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 03:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58F8628724F
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 01:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F1160B8A;
	Thu, 22 Aug 2024 01:29:46 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11FB4500E
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2024 01:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724290186; cv=none; b=k/OR5hA74ywn4W25MOfgNwP6Qt0rjeuBqjoCN02JbWAJMgIpa0LbR2vQwj/sA0mpCWSKhRkifT5dvVqe5zy96khGc06SIlPNytHsceNkoVlBIGFrqz2vawJGXSQBCApuzl0Xbn5InPMmsZLSL/SR/xEc24kBq49Dh3k7xTIFcFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724290186; c=relaxed/simple;
	bh=WhnKWg00fkEtqFw0Zro8jLu9cGktRj3rIe2XDyItdDg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FywMDkipUEinsmJkiQt6lNVwmsiqbDCqRcZMDbICK7ImMaeGM9/f+ARO5jQV2QHoAz8c+W+0D2IXq8VQe7Si1b3USSgAWrc9Efv5xNm1sLbl0Wrr817DYfaRPxcGRXZBJcUXGrDlvo0cYos/bXxK/7MVdfYcRI9JdMW1Od6R5yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Wq5Fp2rYBz13TVL;
	Thu, 22 Aug 2024 09:29:02 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 2A9B2140361;
	Thu, 22 Aug 2024 09:29:42 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 22 Aug
 2024 09:29:41 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
	<terrelln@fb.com>
CC: <willy@infradead.org>, <lizetao1@huawei.com>,
	<linux-btrfs@vger.kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>
Subject: [PATCH 08/14] btrfs: convert try_release_extent_state() to take a folio
Date: Thu, 22 Aug 2024 09:37:08 +0800
Message-ID: <20240822013714.3278193-9-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822013714.3278193-1-lizetao1@huawei.com>
References: <20240822013714.3278193-1-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd500012.china.huawei.com (7.221.188.25)

The old page API is being gradually replaced and converted to use folio
to improve code readability and avoid repeated conversion between page
and folio. Moreover, use folio_pos() instend of page_offset(),
which is more consistent with folio usage.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/btrfs/extent_io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e16477ef0bfb..27ca7a56d8f5 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2397,9 +2397,9 @@ int extent_invalidate_folio(struct extent_io_tree *tree,
  * to drop the page.
  */
 static bool try_release_extent_state(struct extent_io_tree *tree,
-				    struct page *page, gfp_t mask)
+				    struct folio *folio, gfp_t mask)
 {
-	u64 start = page_offset(page);
+	u64 start = folio_pos(folio);
 	u64 end = start + PAGE_SIZE - 1;
 	bool ret;
 
@@ -2508,7 +2508,7 @@ bool try_release_extent_mapping(struct page *page, gfp_t mask)
 			cond_resched();
 		}
 	}
-	return try_release_extent_state(io_tree, page, mask);
+	return try_release_extent_state(io_tree, folio, mask);
 }
 
 static void __free_extent_buffer(struct extent_buffer *eb)
-- 
2.34.1


