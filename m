Return-Path: <linux-btrfs+bounces-7385-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7FB95AA85
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 03:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F562B25C81
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 01:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C144779D;
	Thu, 22 Aug 2024 01:29:44 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBAA37160
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2024 01:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724290184; cv=none; b=FrFB8D0fhpJvEmYGAv97OukTueYikXxRLJJr8SLikFD27ssFTsQHwJ3+D/SKp5wNV08zUg9HgzG/4jMRhT33H1HsnTb5nxc48HvWgRbXJDcPoQTgVyC5+7JhNfv6qPibMHy/ApkXjKxO6gV/OGG5ub64nA7jM6MzoHwhGYzN0XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724290184; c=relaxed/simple;
	bh=sPsqqGr+XUqhmxoIiZXSD3M/cVag3Uf/JU46x/AueWI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QHDubpAZOeLcH/4eKXkb4RdNp1jgW+gqTc+zSiN+d+9hHOWTyqHwP1Pu7SgXswKM3A7AXE9jBTYdiPjW455Kz/NIpyLTkR0qDv9t8TtbbIXeOiC2tn2XCMw4fr6gdluU3vlldKk8tkzkdnpPGr1Sx/53cvUzboNNbTpEQyHwqeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wq5G45pflzyR8j;
	Thu, 22 Aug 2024 09:29:16 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 1CB5C180087;
	Thu, 22 Aug 2024 09:29:40 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 22 Aug
 2024 09:29:39 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
	<terrelln@fb.com>
CC: <willy@infradead.org>, <lizetao1@huawei.com>,
	<linux-btrfs@vger.kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>
Subject: [PATCH 03/14] btrfs: convert try_release_subpage_extent_buffer() to take a folio
Date: Thu, 22 Aug 2024 09:37:03 +0800
Message-ID: <20240822013714.3278193-4-lizetao1@huawei.com>
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
and folio. And use folio_pos instend of page_offset, which is more
consistent with folio usage. At the same time, folio_test_private can
handle folio directly without converting from page to folio first.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/btrfs/extent_io.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b9d159fcbbc5..77c1f69f4229 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4171,11 +4171,11 @@ static struct extent_buffer *get_next_extent_buffer(
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
@@ -4190,7 +4190,7 @@ static int try_release_subpage_extent_buffer(struct page *page)
 		 * with spinlock rather than RCU.
 		 */
 		spin_lock(&fs_info->buffer_lock);
-		eb = get_next_extent_buffer(fs_info, page_folio(page), cur);
+		eb = get_next_extent_buffer(fs_info, folio, cur);
 		if (!eb) {
 			/* No more eb in the page range after or at cur */
 			spin_unlock(&fs_info->buffer_lock);
@@ -4231,12 +4231,12 @@ static int try_release_subpage_extent_buffer(struct page *page)
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
@@ -4247,7 +4247,7 @@ int try_release_extent_buffer(struct page *page)
 	struct extent_buffer *eb;
 
 	if (page_to_fs_info(page)->nodesize < PAGE_SIZE)
-		return try_release_subpage_extent_buffer(page);
+		return try_release_subpage_extent_buffer(page_folio(page));
 
 	/*
 	 * We need to make sure nobody is changing folio private, as we rely on
-- 
2.34.1


