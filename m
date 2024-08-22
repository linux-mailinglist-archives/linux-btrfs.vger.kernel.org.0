Return-Path: <linux-btrfs+bounces-7387-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D1495AA87
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 03:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1C5E1F21287
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 01:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF95C54759;
	Thu, 22 Aug 2024 01:29:45 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37018381C8
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2024 01:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724290185; cv=none; b=Qte9VsigvjJw689ivw5zQH4UqhQCRrWJ1eMpLKD3rmRjBmpFjsUmwO2xaHGKA+EWJ/lDgzkt37S4RAIIRCQSRiA8rTlIoyYZIIqe+6lfbJv4n1CHRXHpql3rm+MI56/BHCjH2uMuvfz0uJYCTnCmgwal8qJS0aX6sH4ZIXPFcgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724290185; c=relaxed/simple;
	bh=qA5LtxGJvtYAePAgO0iF6JhD5Gne9qJr3Ohnt8xJcQI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jPxfBx2wK3YcBTzKgODfUJGS4HMb0pHRokTXEmUHnPPbuvgJwabnedTULrFdpgSJLE9G2j5A21YKVYOnx3q9OzHcPbXjY5H1GbSI5lbEWSgqzSPhZce0D//CM6OTFx2rpK1x79jjXUAKiVsvX9UMN187Hz8b4XWldMbknKpb8L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wq5Fn2Kl5zpVYq;
	Thu, 22 Aug 2024 09:29:01 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 5BF4C1800D3;
	Thu, 22 Aug 2024 09:29:41 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 22 Aug
 2024 09:29:40 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
	<terrelln@fb.com>
CC: <willy@infradead.org>, <lizetao1@huawei.com>,
	<linux-btrfs@vger.kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>
Subject: [PATCH 06/14] btrfs: convert submit_eb_subpage() to take a folio
Date: Thu, 22 Aug 2024 09:37:06 +0800
Message-ID: <20240822013714.3278193-7-lizetao1@huawei.com>
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
 fs/btrfs/extent_io.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a0102b9b67ff..ca458237ac35 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1818,12 +1818,11 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
  * Return >=0 for the number of submitted extent buffers.
  * Return <0 for fatal error.
  */
-static int submit_eb_subpage(struct page *page, struct writeback_control *wbc)
+static int submit_eb_subpage(struct folio *folio, struct writeback_control *wbc)
 {
-	struct btrfs_fs_info *fs_info = page_to_fs_info(page);
-	struct folio *folio = page_folio(page);
+	struct btrfs_fs_info *fs_info = folio_to_fs_info(folio);
 	int submitted = 0;
-	u64 page_start = page_offset(page);
+	u64 folio_start = folio_pos(folio);
 	int bit_start = 0;
 	int sectors_per_node = fs_info->nodesize >> fs_info->sectorsize_bits;
 
@@ -1838,21 +1837,21 @@ static int submit_eb_subpage(struct page *page, struct writeback_control *wbc)
 		 * Take private lock to ensure the subpage won't be detached
 		 * in the meantime.
 		 */
-		spin_lock(&page->mapping->i_private_lock);
+		spin_lock(&folio->mapping->i_private_lock);
 		if (!folio_test_private(folio)) {
-			spin_unlock(&page->mapping->i_private_lock);
+			spin_unlock(&folio->mapping->i_private_lock);
 			break;
 		}
 		spin_lock_irqsave(&subpage->lock, flags);
 		if (!test_bit(bit_start + fs_info->subpage_info->dirty_offset,
 			      subpage->bitmaps)) {
 			spin_unlock_irqrestore(&subpage->lock, flags);
-			spin_unlock(&page->mapping->i_private_lock);
+			spin_unlock(&folio->mapping->i_private_lock);
 			bit_start++;
 			continue;
 		}
 
-		start = page_start + bit_start * fs_info->sectorsize;
+		start = folio_start + bit_start * fs_info->sectorsize;
 		bit_start += sectors_per_node;
 
 		/*
@@ -1861,7 +1860,7 @@ static int submit_eb_subpage(struct page *page, struct writeback_control *wbc)
 		 */
 		eb = find_extent_buffer_nolock(fs_info, start);
 		spin_unlock_irqrestore(&subpage->lock, flags);
-		spin_unlock(&page->mapping->i_private_lock);
+		spin_unlock(&folio->mapping->i_private_lock);
 
 		/*
 		 * The eb has already reached 0 refs thus find_extent_buffer()
@@ -1912,7 +1911,7 @@ static int submit_eb_page(struct page *page, struct btrfs_eb_write_context *ctx)
 		return 0;
 
 	if (page_to_fs_info(page)->nodesize < PAGE_SIZE)
-		return submit_eb_subpage(page, wbc);
+		return submit_eb_subpage(folio, wbc);
 
 	spin_lock(&mapping->i_private_lock);
 	if (!folio_test_private(folio)) {
-- 
2.34.1


