Return-Path: <linux-btrfs+bounces-6785-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5264893D92D
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8E0B1F2369C
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E3215530C;
	Fri, 26 Jul 2024 19:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="LzZi1bpz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3AB1552E4
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022646; cv=none; b=rVDVGo9SWvgysmGiWDlKittJq0mQz2/NQx1xI7lZybT2LiLmGH1y3qZCHWqqiPMpAdH/ZvXDbAzRAxMe8/GBcg1SHLO9Jd6fd+VRoY+gDYTyiyiZl9uBS8QBfEEuAsl1WBKymlSpiwB8lhNL8r0ylfHQyQ8r5lEe5WdWnAWSx/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022646; c=relaxed/simple;
	bh=2CYokru1KOIzGaR+kYpzm6XUamdiCZ5kw+OFy8OFq3Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=STgzeAvRK8TUrU4KjwIdqYhelyy8AwdcCcnD6j4DY7IKhTU3ytfE6nQnJNzC4la7s0IxdATjHp8/YKjq5AwcjfpE/EtewuLt86fGC2kPQ8ZB2bXx1hNRwGKmlvZPSxZfQONsHsyTyOaSxqt6Y9AgG1nOdEJ4zzkHrY71PH5SrbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=LzZi1bpz; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e05eccfcdb3so43561276.1
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022644; x=1722627444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=znHk55CvcRk1eRAfKmKo0u4zO8N0q6ASd9YRTunmw2k=;
        b=LzZi1bpztTExyXrTZaOClJLdHer/Vh/CxPuE30EAWjsvtLu2EmH+elibu8aToUqVKT
         xz7QDLWwM/6FRrQ1mdj9u2jwFMjn7rhMl3fhM+qu2nvgdOMLyy1qpuxyRcLRmQcCSsIH
         ofgeqb7/YJ4piyYshhVdiWqa6BJDV/wIUeN4ffS9yqZdgripGj7Iq9NymF9PQu6l0bwc
         Gz0etxgoZ0hnVOKak0m+3jrOoynYxiUex/UX0ecB8Uag7mJrQAODMB/NKytw/ox1sI08
         zDt7H8UcOq8ojg/cFjF61lDT7oASI/3Iv/6CypuGSdQFk+RAFnMDl8q3i70CD+8qEcT/
         t6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022644; x=1722627444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=znHk55CvcRk1eRAfKmKo0u4zO8N0q6ASd9YRTunmw2k=;
        b=B8g3a6bn/bGdA6J796SmjUIR84SXdjrxPlcYLb7Wje0p5fU85Rgq4PyypVs1cYwNPd
         yZ0JcMyXBOxIuFTgqFlfr1AgfapwIkwlHVcWnPCfO5EPkwVWmJaUdctMmGxCxj9APunf
         ++ZYiA5VqLpRQvc+33H9INN80XSgFziMweDsxY1CdwOuBtWBdi+CyXnYMRBKfmS4zXOc
         VCV04EA1qFjpDPtfKpvL9yRCFhjK+DelhzZ9DJJGW8SqEV45Eeg5IZ3Ke/ms8Qvb5UuV
         HfO2sP7VoZfFCe5T8jGUEE+hrzoRnBjZT0I/lDxTmt6Uf5DbJxMa6WHc4zFuwTOsxdxn
         Y0vA==
X-Gm-Message-State: AOJu0YynEujB5rV/CcNZXfpHBqR9R7ytt2QvcBu68pBcVmhg/xrSmiLR
	mxn5Xzmn+O9YBDmaxsoykr9kNqlIUbiCDG4jplQ4abPhFuiL/IO0f+qTfB3nzad9r014C1BWS61
	C
X-Google-Smtp-Source: AGHT+IGoaqwufS5j/zmBL47wmLmvHmEGLu3s5OItxHsD/kKymYaZYqMOBaNboQtGuS1TW757t4jEsQ==
X-Received: by 2002:a0d:c983:0:b0:62f:945a:7bb1 with SMTP id 00721157ae682-67a0a323dc1mr8646947b3.42.1722022643924;
        Fri, 26 Jul 2024 12:37:23 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-67567869beasm9889097b3.40.2024.07.26.12.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:37:23 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 44/46] btrfs: convert btrfs_set_range_writeback to use a folio
Date: Fri, 26 Jul 2024 15:36:31 -0400
Message-ID: <5a35f970d3a576b6f459cc88565d44dad94ef771.1722022377.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722022376.git.josef@toxicpanda.com>
References: <cover.1722022376.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We already use a lot of functions here that use folios, update the
function to use __filemap_get_folio instead of find_get_page and then
use the folio directly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 80022a8c718e..2f14b337a7ef 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8956,19 +8956,19 @@ void btrfs_set_range_writeback(struct btrfs_inode *inode, u64 start, u64 end)
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	unsigned long index = start >> PAGE_SHIFT;
 	unsigned long end_index = end >> PAGE_SHIFT;
-	struct page *page;
+	struct folio *folio;
 	u32 len;
 
 	ASSERT(end + 1 - start <= U32_MAX);
 	len = end + 1 - start;
 	while (index <= end_index) {
-		page = find_get_page(inode->vfs_inode.i_mapping, index);
-		ASSERT(page); /* Pages should be in the extent_io_tree */
+		folio = __filemap_get_folio(inode->vfs_inode.i_mapping, index, 0, 0);
+		ASSERT(!IS_ERR(folio)); /* folios should be in the extent_io_tree */
 
 		/* This is for data, which doesn't yet support larger folio. */
-		ASSERT(folio_order(page_folio(page)) == 0);
-		btrfs_folio_set_writeback(fs_info, page_folio(page), start, len);
-		put_page(page);
+		ASSERT(folio_order(folio) == 0);
+		btrfs_folio_set_writeback(fs_info, folio, start, len);
+		folio_put(folio);
 		index++;
 	}
 }
-- 
2.43.0


