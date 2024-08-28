Return-Path: <linux-btrfs+bounces-7641-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3845B963006
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 20:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAB9128257A
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 18:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C7E1AC8B0;
	Wed, 28 Aug 2024 18:21:10 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D981A76D5;
	Wed, 28 Aug 2024 18:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869269; cv=none; b=sdVX24nmJrHMFTfw5+tB8qebHcMWsAft2ljPFws835oJLqXGN8om8P1kuEKsHd7gi3KcRzebpqeGtjnEzflnaMFsAVlJ7FKXNr05ElZ2DcsMwp6SWV3Alc0oajfs4xk4O/5A6c3oDgniXovPidAqFI3U7dF2rK4atadsgN80w4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869269; c=relaxed/simple;
	bh=sKeRpVHvZRSqvs/QsVPm9a9Psj95HP5ZyUUQegM6QbI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o0TsdW7TImTEBgm7veLT8Upoa1SKUanZMpNPG1nnulvE/FJJWH6TYgYpOspwna4f+FtivpvWXPh45jIuHA1hvB87UoL8qHzBv9i6Efnlh7vuB7KCbWJnMUd4aCtz0aqZDwIFTd0fi0AB//OWNG88qCWOMTMrT15bBaOmZpqaqjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WvCQB4NNBzyRC6;
	Thu, 29 Aug 2024 02:20:34 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 4AF07140156;
	Thu, 29 Aug 2024 02:21:05 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 29 Aug
 2024 02:21:04 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
	<terrelln@fb.com>, <quwenruo.btrfs@gmx.com>, <willy@infradead.org>,
	<dan.carpenter@linaro.org>
CC: <lizetao1@huawei.com>, <linux-btrfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH -next v2 09/14] btrfs: convert try_release_extent_mapping() to take a folio
Date: Thu, 29 Aug 2024 02:29:03 +0800
Message-ID: <20240828182908.3735344-10-lizetao1@huawei.com>
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
and folio. And page_to_inode() can be replaced with folio_to_inode() now.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/btrfs/extent_io.c | 6 +++---
 fs/btrfs/extent_io.h | 2 +-
 fs/btrfs/inode.c     | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 3016ebe5f31b..0155bea0ece7 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2342,11 +2342,11 @@ static bool try_release_extent_state(struct extent_io_tree *tree,
  * in the range corresponding to the page, both state records and extent
  * map records are removed
  */
-bool try_release_extent_mapping(struct page *page, gfp_t mask)
+bool try_release_extent_mapping(struct folio *folio, gfp_t mask)
 {
-	u64 start = page_offset(page);
+	u64 start = folio_pos(folio);
 	u64 end = start + PAGE_SIZE - 1;
-	struct btrfs_inode *inode = page_to_inode(page);
+	struct btrfs_inode *inode = folio_to_inode(folio);
 	struct extent_io_tree *io_tree = &inode->io_tree;
 
 	while (start <= end) {
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 345774c84c4b..8a36117ed453 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -236,7 +236,7 @@ static inline void extent_changeset_free(struct extent_changeset *changeset)
 	kfree(changeset);
 }
 
-bool try_release_extent_mapping(struct page *page, gfp_t mask);
+bool try_release_extent_mapping(struct folio *folio, gfp_t mask);
 int try_release_extent_buffer(struct folio *folio);
 
 int btrfs_read_folio(struct file *file, struct folio *folio);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f113ec3d5392..d2366db474ae 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7238,7 +7238,7 @@ static int btrfs_launder_folio(struct folio *folio)
 
 static bool __btrfs_release_folio(struct folio *folio, gfp_t gfp_flags)
 {
-	if (try_release_extent_mapping(&folio->page, gfp_flags)) {
+	if (try_release_extent_mapping(folio, gfp_flags)) {
 		wait_subpage_spinlock(folio);
 		clear_folio_extent_mapped(folio);
 		return true;
-- 
2.34.1


