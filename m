Return-Path: <linux-btrfs+bounces-7638-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 092D1962FC6
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 20:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B84F72868C0
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 18:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9C11AC432;
	Wed, 28 Aug 2024 18:21:09 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11E91A76A6;
	Wed, 28 Aug 2024 18:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869269; cv=none; b=sBkE9xKm7uMGzN2vFKINV2C4PeBWrtu2Ulfqoca2s1s11NUKpkFWhrxOmQBNC3lpVQSLpo+kGtfpojVIdUkfa8QPP5+jEZIkslBrSCIhiGl59ocbRMgckuGJc/L/uz11d4nFyGaFfKH1Rl93zY7FjU4IpRmfPHuWmhRcIMd6HfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869269; c=relaxed/simple;
	bh=54WGKokO1R87rCCiS9gPeqwfC86b3S4VvCxOJ6OM7nQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IAdApGcoRNaN7b4AVg7f8Nssqms/gjnDdU4BKBAiEh9eWA2N6xE/6YFtJFVJLklTsbkA9zxZv2Bz+Aj6Co6Lwbm27GbIOHXPKn7BCEVooTTVQR53VHPr4uq4TUtoOSVhKhDrGaFKAtAfM9RScjBfgb3Kc+eqK6GH7CitVbbAqbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WvCNV5HHNz1xwT4;
	Thu, 29 Aug 2024 02:19:06 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 82A051A0188;
	Thu, 29 Aug 2024 02:21:04 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 29 Aug
 2024 02:21:03 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
	<terrelln@fb.com>, <quwenruo.btrfs@gmx.com>, <willy@infradead.org>,
	<dan.carpenter@linaro.org>
CC: <lizetao1@huawei.com>, <linux-btrfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH -next v2 07/14] btrfs: convert submit_eb_page() to take a folio
Date: Thu, 29 Aug 2024 02:29:01 +0800
Message-ID: <20240828182908.3735344-8-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828182908.3735344-1-lizetao1@huawei.com>
References: <20240828182908.3735344-1-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd500012.china.huawei.com (7.221.188.25)

The old page API is being gradually replaced and converted to use folio
to improve code readability and avoid repeated conversion between page
and folio.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/btrfs/extent_io.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f40aecb96cba..111de9b9d537 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1817,18 +1817,17 @@ static int submit_eb_subpage(struct folio *folio, struct writeback_control *wbc)
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
@@ -1927,7 +1926,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 		for (i = 0; i < nr_folios; i++) {
 			struct folio *folio = fbatch.folios[i];
 
-			ret = submit_eb_page(&folio->page, &ctx);
+			ret = submit_eb_page(folio, &ctx);
 			if (ret == 0)
 				continue;
 			if (ret < 0) {
-- 
2.34.1


