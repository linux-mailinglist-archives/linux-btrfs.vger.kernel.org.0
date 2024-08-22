Return-Path: <linux-btrfs+bounces-7389-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A633C95AA89
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 03:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D92311C20A27
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 01:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A33364CD;
	Thu, 22 Aug 2024 01:29:46 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98E238DD3
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2024 01:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724290185; cv=none; b=KFXdoRaPcvgQ9B7p/LVCucMf0CtWmyzhgenYOtMuAU0lavwCU7DDp7LNhjxbtmUbj7Ww0xXWMiPsS96Z14gFTEVZVPlpv4nq7tTDMoUstlTviimIDpE0kliSnna4a5Iq4SoYVXueeC157eK5CRXjZVcpRvFNm1nwCoEWwZAB9Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724290185; c=relaxed/simple;
	bh=e+uf+N1xdKPR42n/gjlVnQ0lxRSjiMtGtUobvwwSDJk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aE5XWSGffy7J2Os+/+/Q1IPjWsDofhUpsGO5mmUiwQyTldO9T2qWV3uAjR9ZVh1j+pQWixWk1IDv3UmZrLQl3R+6vURvF3wNFfNOtKbefEm9Ar1xgDsCxrQv6AL4pvc26dwNgoUNE5lZFDYUtDek5tO+oC4EFAqO838fsGwcMF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wq5972yrbz20mFZ;
	Thu, 22 Aug 2024 09:24:59 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id B8A101A0188;
	Thu, 22 Aug 2024 09:29:41 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 22 Aug
 2024 09:29:41 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
	<terrelln@fb.com>
CC: <willy@infradead.org>, <lizetao1@huawei.com>,
	<linux-btrfs@vger.kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>
Subject: [PATCH 07/14] btrfs: convert submit_eb_page() to take a folio
Date: Thu, 22 Aug 2024 09:37:07 +0800
Message-ID: <20240822013714.3278193-8-lizetao1@huawei.com>
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
and folio.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/btrfs/extent_io.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ca458237ac35..e16477ef0bfb 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1899,18 +1899,17 @@ static int submit_eb_subpage(struct folio *folio, struct writeback_control *wbc)
  * previous call.
  * Return <0 for fatal error.
  */
-static int submit_eb_page(struct page *page, struct btrfs_eb_write_context *ctx)
+static int submit_eb_page(struct folio *folio, struct btrfs_eb_write_context *ctx)
 {
 	struct writeback_control *wbc = ctx->wbc;
-	struct address_space *mapping = page->mapping;
-	struct folio *folio = page_folio(page);
+	struct address_space *mapping = folio->mapping;
 	struct extent_buffer *eb;
 	int ret;
 
 	if (!folio_test_private(folio))
 		return 0;
 
-	if (page_to_fs_info(page)->nodesize < PAGE_SIZE)
+	if (folio_to_fs_info(folio)->nodesize < PAGE_SIZE)
 		return submit_eb_subpage(folio, wbc);
 
 	spin_lock(&mapping->i_private_lock);
@@ -2009,7 +2008,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 		for (i = 0; i < nr_folios; i++) {
 			struct folio *folio = fbatch.folios[i];
 
-			ret = submit_eb_page(&folio->page, &ctx);
+			ret = submit_eb_page(folio, &ctx);
 			if (ret == 0)
 				continue;
 			if (ret < 0) {
-- 
2.34.1


