Return-Path: <linux-btrfs+bounces-7633-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D784962FBD
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 20:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C987F1C21129
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 18:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57171AAE0D;
	Wed, 28 Aug 2024 18:21:07 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28493156649;
	Wed, 28 Aug 2024 18:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869267; cv=none; b=kXyBv+FL9bInzDoDF2a8nWeFTA2UuNsq0kf42hXR3dINKPfxR8g3slzynOmWp4QwlQQvV1SYk8FDAy3/tEvjOhxKLLIlOabp5N7nlMYxETPAbIA0s0Z4OY/1sz2wFaRP2lDbstaSbMbFGergRgbPl8L1qNxdmnBKJxiEDteOOX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869267; c=relaxed/simple;
	bh=XvWC5RxTiYgmiQZx3O4Fkh/2fsCea7Ge7ljSuN5vYrA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kSwCKtq3oZ/BP3FQ966VT4fhMxZJtyUkvYqsEuWU55Q4DSkeuF3usQL0y7yxaEil3x/PZxPbpIF+wfCNT24qXCipHC4GC27C5NAqO1yFHuR6ckGzAFYRWHSXCANAqRC2OIQNE254vfSu7UhjZfETbreFicIdu5gj0Oryv+fP07Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WvCQV2JsPz1S9Fd;
	Thu, 29 Aug 2024 02:20:50 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A714180019;
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
Subject: [PATCH -next v2 02/14] btrfs: convert get_next_extent_buffer() to take a folio
Date: Thu, 29 Aug 2024 02:28:56 +0800
Message-ID: <20240828182908.3735344-3-lizetao1@huawei.com>
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
consistent with folio usage.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/btrfs/extent_io.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7f630edcc791..a77e38fc563e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4042,17 +4042,17 @@ void memmove_extent_buffer(const struct extent_buffer *dst,
 
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
 
@@ -4064,7 +4064,7 @@ static struct extent_buffer *get_next_extent_buffer(
 			goto out;
 		for (i = 0; i < ret; i++) {
 			/* Already beyond page end */
-			if (gang[i]->start >= page_start + PAGE_SIZE)
+			if (gang[i]->start >= folio_start + PAGE_SIZE)
 				goto out;
 			/* Found one */
 			if (gang[i]->start >= bytenr) {
@@ -4097,7 +4097,7 @@ static int try_release_subpage_extent_buffer(struct page *page)
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


