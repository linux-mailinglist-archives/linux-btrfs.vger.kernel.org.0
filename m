Return-Path: <linux-btrfs+bounces-7640-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B14B962FCB
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 20:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2182F286F09
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 18:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D10D1AC88B;
	Wed, 28 Aug 2024 18:21:10 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4424F1A76A7;
	Wed, 28 Aug 2024 18:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869269; cv=none; b=qXsY2gXiVWMXN/Qa9o41hz1vfpbKhn1vUMJsyOaizyjDkO2m/kwWwrvbjImuFK6N5hK5yqv+yJrP/+SfaNZljVON3jLQIQgDZx/rk2FyqmpTBhhmlFC0m2hgL3juXSsXtTDGzvgYGvkdPK+6xOUl+MpgJyIUprZvfXlHvPTAIwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869269; c=relaxed/simple;
	bh=fpGLC0tKQK3YV4qT5cEov+87aHdcktUGT8luODxwSQ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TGO7lUcaRsI7/6j7HL1nfO9QhODYO8JfYqWtaVHw7rGGjEgjbVjKrxg8/jbwlCS1z+7lCLL1L5WZMbqXCSlUGI7Iv5Ju4da86nLAjoZ24mjFbKBiJMS8qwS/NWchDKqFN1Thk5u47w6+5ZhKInEfXsUIeh2zRpav4gCsUc9QHao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WvCLw5qV3z1HHg5;
	Thu, 29 Aug 2024 02:17:44 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id E3D491401F2;
	Thu, 29 Aug 2024 02:21:04 +0800 (CST)
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
Subject: [PATCH -next v2 08/14] btrfs: convert try_release_extent_state() to take a folio
Date: Thu, 29 Aug 2024 02:29:02 +0800
Message-ID: <20240828182908.3735344-9-lizetao1@huawei.com>
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
 fs/btrfs/extent_io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 111de9b9d537..3016ebe5f31b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2304,9 +2304,9 @@ int extent_invalidate_folio(struct extent_io_tree *tree,
  * to drop the page.
  */
 static bool try_release_extent_state(struct extent_io_tree *tree,
-				    struct page *page, gfp_t mask)
+				    struct folio *folio, gfp_t mask)
 {
-	u64 start = page_offset(page);
+	u64 start = folio_pos(folio);
 	u64 end = start + PAGE_SIZE - 1;
 	bool ret;
 
@@ -2415,7 +2415,7 @@ bool try_release_extent_mapping(struct page *page, gfp_t mask)
 			cond_resched();
 		}
 	}
-	return try_release_extent_state(io_tree, page, mask);
+	return try_release_extent_state(io_tree, folio, mask);
 }
 
 static void __free_extent_buffer(struct extent_buffer *eb)
-- 
2.34.1


