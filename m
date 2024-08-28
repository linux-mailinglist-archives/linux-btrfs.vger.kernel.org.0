Return-Path: <linux-btrfs+bounces-7637-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 285EB962FC5
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 20:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AFC91C2415D
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 18:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6271AC429;
	Wed, 28 Aug 2024 18:21:09 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF6D1A76BC;
	Wed, 28 Aug 2024 18:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869268; cv=none; b=q+GiJ6lhREtUgiVbVxFsh1Ll6izSztWyuQ74BMoIIyfmH3LxzdBxWOOG09XramALmN7CwuIS+xnp+gv4S/3ZpWSN0aocvDv2zeYEkq8DqFw4uAB1g8R8nGyNWXEgJ9ZdZ6vEnbs+CId74LnbDk8cmdiGBhdteQUwOuc64sZdICg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869268; c=relaxed/simple;
	bh=exad+LAyLUfgaiPD6o6GYx5gICn+RX8bbCn15LgeSSQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uaDkkzDvOVcL27hkc4Emk4ZkHoaisWR4r0/UweZczOxP/rGSpZ+u5lDEqejRe94jQTMwECfGMcPgNPlFIelfN+/uwYih5jGRlDtwp2vzep+JblMh/rCJ0p5GpIWSRjRFtQeN/nngQphSJnJlYi6ZVNNiW8T/RuSOayvNJOAmvG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WvCLw0GCxz1HHgQ;
	Thu, 29 Aug 2024 02:17:44 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 255DC1A016C;
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
Subject: [PATCH -next v2 06/14] btrfs: convert submit_eb_subpage() to take a folio
Date: Thu, 29 Aug 2024 02:29:00 +0800
Message-ID: <20240828182908.3735344-7-lizetao1@huawei.com>
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
and folio. Moreover, use folio_pos() instend of page_offset(),
which is more consistent with folio usage.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/btrfs/extent_io.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index fa436a4ab46a..f40aecb96cba 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1736,12 +1736,11 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
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
 
@@ -1756,21 +1755,21 @@ static int submit_eb_subpage(struct page *page, struct writeback_control *wbc)
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
@@ -1779,7 +1778,7 @@ static int submit_eb_subpage(struct page *page, struct writeback_control *wbc)
 		 */
 		eb = find_extent_buffer_nolock(fs_info, start);
 		spin_unlock_irqrestore(&subpage->lock, flags);
-		spin_unlock(&page->mapping->i_private_lock);
+		spin_unlock(&folio->mapping->i_private_lock);
 
 		/*
 		 * The eb has already reached 0 refs thus find_extent_buffer()
@@ -1830,7 +1829,7 @@ static int submit_eb_page(struct page *page, struct btrfs_eb_write_context *ctx)
 		return 0;
 
 	if (page_to_fs_info(page)->nodesize < PAGE_SIZE)
-		return submit_eb_subpage(page, wbc);
+		return submit_eb_subpage(folio, wbc);
 
 	spin_lock(&mapping->i_private_lock);
 	if (!folio_test_private(folio)) {
-- 
2.34.1


