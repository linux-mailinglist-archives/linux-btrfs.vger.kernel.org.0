Return-Path: <linux-btrfs+bounces-7383-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7AC95AA83
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 03:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAD621F225D8
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 01:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A3C433CB;
	Thu, 22 Aug 2024 01:29:44 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF502200AE
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2024 01:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724290183; cv=none; b=NNd8zhsB7AjBxpMP7ZGXH87stXudb8WSRfVfbAhmt1nrOctvMArJHeNqMzecIjYPKGyG0L/l8+rWpZNJhn5GRM7D/KLkw+73U/bZyJpOe2p6PB36BKONAwhkPtvKOlRzFsoy794nXp/JFGxWEOjBDlFm4KpQi/12qO1S24VDe7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724290183; c=relaxed/simple;
	bh=FpqNFXC4g+z64DX9CJFXjSZBjX4YZuywJJv+qf7teaE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pb+NjlEzKKy0QuLUW/Wvw3GrD5yae8WztFMOFoCLKj0cFSYVvX3a1MTxICxaNYpmgZkrzZMXtnccjfJJSDqAwaZYMaUG9b84pmDNDQM0v/h2njlvGoGt3y2l2gywF2jqIxc75tlUi5XQ4SQMbvQrfGsmyMNPkV6L+nYXNI75dZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Wq5946nWxz69Lc;
	Thu, 22 Aug 2024 09:24:56 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id B05A21800FF;
	Thu, 22 Aug 2024 09:29:39 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 22 Aug
 2024 09:29:39 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
	<terrelln@fb.com>
CC: <willy@infradead.org>, <lizetao1@huawei.com>,
	<linux-btrfs@vger.kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>
Subject: [PATCH 02/14] btrfs: convert get_next_extent_buffer() to take a folio
Date: Thu, 22 Aug 2024 09:37:02 +0800
Message-ID: <20240822013714.3278193-3-lizetao1@huawei.com>
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
consistent with folio usage.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/btrfs/extent_io.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 3c2ad5c9990d..b9d159fcbbc5 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4135,17 +4135,17 @@ void memmove_extent_buffer(const struct extent_buffer *dst,
 
 #define GANG_LOOKUP_SIZE	16
 static struct extent_buffer *get_next_extent_buffer(
-		const struct btrfs_fs_info *fs_info, struct page *page, u64 bytenr)
+		const struct btrfs_fs_info *fs_info, struct folio *folio, u64 bytenr)
 {
 	struct extent_buffer *gang[GANG_LOOKUP_SIZE];
 	struct extent_buffer *found = NULL;
-	u64 page_start = page_offset(page);
-	u64 cur = page_start;
+	u64 folio_start = folio_pos(folio);
+	u64 cur = folio_start;
 
-	ASSERT(in_range(bytenr, page_start, PAGE_SIZE));
+	ASSERT(in_range(bytenr, folio_start, PAGE_SIZE));
 	lockdep_assert_held(&fs_info->buffer_lock);
 
-	while (cur < page_start + PAGE_SIZE) {
+	while (cur < folio_start + PAGE_SIZE) {
 		int ret;
 		int i;
 
@@ -4157,7 +4157,7 @@ static struct extent_buffer *get_next_extent_buffer(
 			goto out;
 		for (i = 0; i < ret; i++) {
 			/* Already beyond page end */
-			if (gang[i]->start >= page_start + PAGE_SIZE)
+			if (gang[i]->start >= folio_start + PAGE_SIZE)
 				goto out;
 			/* Found one */
 			if (gang[i]->start >= bytenr) {
@@ -4190,7 +4190,7 @@ static int try_release_subpage_extent_buffer(struct page *page)
 		 * with spinlock rather than RCU.
 		 */
 		spin_lock(&fs_info->buffer_lock);
-		eb = get_next_extent_buffer(fs_info, page, cur);
+		eb = get_next_extent_buffer(fs_info, page_folio(page), cur);
 		if (!eb) {
 			/* No more eb in the page range after or at cur */
 			spin_unlock(&fs_info->buffer_lock);
-- 
2.34.1


