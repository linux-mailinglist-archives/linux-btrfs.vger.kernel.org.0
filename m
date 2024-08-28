Return-Path: <linux-btrfs+bounces-7635-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE86C962FC1
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 20:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F26F01C23706
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 18:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756501AB522;
	Wed, 28 Aug 2024 18:21:08 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6496819E83D;
	Wed, 28 Aug 2024 18:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869267; cv=none; b=rw9KaYfq8f8Gs8qxuGnZuPgfHQtj9yNgKjUVyrpREEJ5s6k/VA6Cj+gV64Qbdsq9M6mB6stK4e9rm+ZeK/s9dTz5EICkG60K0bL5G3zbeqFB9K5Ar8F9d4LqirM85i9F6ByzAd5ScD15WOil05AYYgjehCNwV/fd2CQRDbWVQQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869267; c=relaxed/simple;
	bh=wVJjQuu8tl/XXCovr/Dd+wo+/6FVvnjxnjDeChv5WNA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KGOJdTXzFI5TgX6nNN/5aSymL3bko04xERwAwqgwsJSZILR2T1uoMkikn/AtGN3OwKImvMmCYQx/H+gz6grIQgNX2Gp/RxUtNBsmDCKfv59DkRss2qegSbUjP1qHOACpJTeo/JJzYoO8MeSktKY2ruCsN4LWJ6lWy2gnZbQ1iQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WvCQW34BDz1j7f1;
	Thu, 29 Aug 2024 02:20:51 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id EE4D9140159;
	Thu, 29 Aug 2024 02:21:02 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 29 Aug
 2024 02:21:02 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
	<terrelln@fb.com>, <quwenruo.btrfs@gmx.com>, <willy@infradead.org>,
	<dan.carpenter@linaro.org>
CC: <lizetao1@huawei.com>, <linux-btrfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH -next v2 03/14] btrfs: convert try_release_subpage_extent_buffer() to take a folio
Date: Thu, 29 Aug 2024 02:28:57 +0800
Message-ID: <20240828182908.3735344-4-lizetao1@huawei.com>
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
and folio. And use folio_pos instend of page_offset, which is more
consistent with folio usage. At the same time, folio_test_private can
handle folio directly without converting from page to folio first.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/btrfs/extent_io.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a77e38fc563e..feec1c21dbb9 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4078,11 +4078,11 @@ static struct extent_buffer *get_next_extent_buffer(
 	return found;
 }
 
-static int try_release_subpage_extent_buffer(struct page *page)
+static int try_release_subpage_extent_buffer(struct folio *folio)
 {
-	struct btrfs_fs_info *fs_info = page_to_fs_info(page);
-	u64 cur = page_offset(page);
-	const u64 end = page_offset(page) + PAGE_SIZE;
+	struct btrfs_fs_info *fs_info = folio_to_fs_info(folio);
+	u64 cur = folio_pos(folio);
+	const u64 end = cur + PAGE_SIZE;
 	int ret;
 
 	while (cur < end) {
@@ -4097,7 +4097,7 @@ static int try_release_subpage_extent_buffer(struct page *page)
 		 * with spinlock rather than RCU.
 		 */
 		spin_lock(&fs_info->buffer_lock);
-		eb = get_next_extent_buffer(fs_info, page_folio(page), cur);
+		eb = get_next_extent_buffer(fs_info, folio, cur);
 		if (!eb) {
 			/* No more eb in the page range after or at cur */
 			spin_unlock(&fs_info->buffer_lock);
@@ -4138,12 +4138,12 @@ static int try_release_subpage_extent_buffer(struct page *page)
 	 * Finally to check if we have cleared folio private, as if we have
 	 * released all ebs in the page, the folio private should be cleared now.
 	 */
-	spin_lock(&page->mapping->i_private_lock);
-	if (!folio_test_private(page_folio(page)))
+	spin_lock(&folio->mapping->i_private_lock);
+	if (!folio_test_private(folio))
 		ret = 1;
 	else
 		ret = 0;
-	spin_unlock(&page->mapping->i_private_lock);
+	spin_unlock(&folio->mapping->i_private_lock);
 	return ret;
 
 }
@@ -4154,7 +4154,7 @@ int try_release_extent_buffer(struct page *page)
 	struct extent_buffer *eb;
 
 	if (page_to_fs_info(page)->nodesize < PAGE_SIZE)
-		return try_release_subpage_extent_buffer(page);
+		return try_release_subpage_extent_buffer(page_folio(page));
 
 	/*
 	 * We need to make sure nobody is changing folio private, as we rely on
-- 
2.34.1


