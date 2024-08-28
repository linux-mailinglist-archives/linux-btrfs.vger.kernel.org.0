Return-Path: <linux-btrfs+bounces-7636-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D3E962FC2
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 20:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44C761C23D9B
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 18:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F3A1AB531;
	Wed, 28 Aug 2024 18:21:08 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54C21A4B9F;
	Wed, 28 Aug 2024 18:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869268; cv=none; b=q4czxth5jvvJJCmg7kLS2ClPuioI5bsfz5Tqd52d/9ZwaKzNOCYLsGPSZMeSFHvFxlpZjr2GOjkhbhQfXGaOHObYsKWnlhJidRATGQsXYstVbhG8ymh7BiLvipQJsstB+gzA7+tvKrRy/mCmTfXp9CMOS0seRMNi2vP8eMDJ5Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869268; c=relaxed/simple;
	bh=9R7mpMML5dokushsMYJ2b21KzMbuzgtU9oxvUSN1co0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ft38Y4epnW31p1ml96Wq7AniGewLBj2fmFr3hgOjQy3vP/KcOiLwlzXzApEPnxD55edAuNSes1qt/rw6pGHO+cEb9z/7+1B0H4bVcjJqvxibevb3iH22sJ64PuNsOIFDuDT7BpmhGHFi6ly3Zg2qluPwSnVlVk7saevYye+aFQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WvCQW5x8sz1j7fT;
	Thu, 29 Aug 2024 02:20:51 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 5CA28140203;
	Thu, 29 Aug 2024 02:21:03 +0800 (CST)
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
Subject: [PATCH -next v2 04/14] btrfs: convert try_release_extent_buffer() to take a folio
Date: Thu, 29 Aug 2024 02:28:58 +0800
Message-ID: <20240828182908.3735344-5-lizetao1@huawei.com>
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
 fs/btrfs/disk-io.c   |  2 +-
 fs/btrfs/extent_io.c | 15 +++++++--------
 fs/btrfs/extent_io.h |  2 +-
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a6f5441e62d1..ca2f52a28fb0 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -525,7 +525,7 @@ static bool btree_release_folio(struct folio *folio, gfp_t gfp_flags)
 	if (folio_test_writeback(folio) || folio_test_dirty(folio))
 		return false;
 
-	return try_release_extent_buffer(&folio->page);
+	return try_release_extent_buffer(folio);
 }
 
 static void btree_invalidate_folio(struct folio *folio, size_t offset,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index feec1c21dbb9..fa436a4ab46a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4148,21 +4148,20 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
 
 }
 
-int try_release_extent_buffer(struct page *page)
+int try_release_extent_buffer(struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	struct extent_buffer *eb;
 
-	if (page_to_fs_info(page)->nodesize < PAGE_SIZE)
-		return try_release_subpage_extent_buffer(page_folio(page));
+	if (folio_to_fs_info(folio)->nodesize < PAGE_SIZE)
+		return try_release_subpage_extent_buffer(folio);
 
 	/*
 	 * We need to make sure nobody is changing folio private, as we rely on
 	 * folio private as the pointer to extent buffer.
 	 */
-	spin_lock(&page->mapping->i_private_lock);
+	spin_lock(&folio->mapping->i_private_lock);
 	if (!folio_test_private(folio)) {
-		spin_unlock(&page->mapping->i_private_lock);
+		spin_unlock(&folio->mapping->i_private_lock);
 		return 1;
 	}
 
@@ -4177,10 +4176,10 @@ int try_release_extent_buffer(struct page *page)
 	spin_lock(&eb->refs_lock);
 	if (atomic_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
 		spin_unlock(&eb->refs_lock);
-		spin_unlock(&page->mapping->i_private_lock);
+		spin_unlock(&folio->mapping->i_private_lock);
 		return 0;
 	}
-	spin_unlock(&page->mapping->i_private_lock);
+	spin_unlock(&folio->mapping->i_private_lock);
 
 	/*
 	 * If tree ref isn't set then we know the ref on this eb is a real ref,
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 1d9b30021109..345774c84c4b 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -237,7 +237,7 @@ static inline void extent_changeset_free(struct extent_changeset *changeset)
 }
 
 bool try_release_extent_mapping(struct page *page, gfp_t mask);
-int try_release_extent_buffer(struct page *page);
+int try_release_extent_buffer(struct folio *folio);
 
 int btrfs_read_folio(struct file *file, struct folio *folio);
 void extent_write_locked_range(struct inode *inode, const struct folio *locked_folio,
-- 
2.34.1


