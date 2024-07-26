Return-Path: <linux-btrfs+bounces-6754-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 784B193D90E
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EF2D1F248ED
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3094E149C6E;
	Fri, 26 Jul 2024 19:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="jng4wTTn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070711494C4
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022613; cv=none; b=JNyfBoaE3I9oH2cRu/Xs2GinUSjrL+KRJtGel6EiNg7QvjsiwaRwGY6uKuH4pPSV6MPNheNlpywrsAB30h4b/OMIG0Tpr/cDxfAB92RloejkEt2Flcr84C8UkR5BX6R5vIFd+G/0QxmAHYSkRHNZK4PKc2RvwNVpOltqTd5QKfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022613; c=relaxed/simple;
	bh=J7BBIGhhm2FS8UFEmQBi7T+yd9UdETAZk7vQWLqu3I8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXWL82gK5zy1IO/PvgkEKZ3s9mIhpVeKH+xUznZAy+rwwa0SAXm8XtGkZukLppkGKHqxd221U2k0mSlCw9VGjL/e7Vu648euy9Aw/rGTMn51QzFkDPKkHW4VshXFPTpldzVcu00TYXdWLZ82UWxUOynjOOHc4PWagawROOpmWmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=jng4wTTn; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-66acac24443so474997b3.1
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022611; x=1722627411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4LnGUFZUUgHRmnS2zRm+HCi7okNv00BI48+/c5ZwGSU=;
        b=jng4wTTnS5HpRhsFdJR6FcUoBNc+adNIzkSQ/NNRvnCVuO+WFnRxl+FC3HQtvurAAw
         5Wli/f/cVq5bBo03loK0RJXkBM4/aMrowdwN6U2EfVsxMBoD5h+5Dif3WCCMIqESz3kJ
         ExymX30AZAQApuoAgvE8i9Pthls80AKyq64WWrHFNFqdyWsRPCt1iQSuWHYz5tKXDbGJ
         6Bwct7GMxRKaw+jZwIEXVDdWLoi1uKJk9mMKjoUmPeueEod80uNuK1ugRGOP49WyQ07Y
         CrPLeGckmLKr+gxscX//jGXqmGuYOG6lQumPGuL3DHqkloJik3Z+k2RD9bHXRGkvPgLM
         p7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022611; x=1722627411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LnGUFZUUgHRmnS2zRm+HCi7okNv00BI48+/c5ZwGSU=;
        b=VdicpnBE4kTzsIknWgyPBC4i54XGrBcQxiMeozWoMVAwHNZ5L+dXVVWOyMSb6rHGWX
         Y/+vZwSTmd8bjtGcYth/yLUxhsTaIhxFc8ILvCDjHbOH12Gur6uaco+FLLvPEmXQf+NX
         d790jPwsn645Ggy3XZYQi4UGjS76+7GLJ6mH1OszBCayxw3CcquTD9bYhGDcjeBDiHEq
         lBURlUORIiMtPsHu5Cbe3EgRPpqGOVGVh02Y1iXAsU8mFU6XinGY4zhMj7Xjxxm3G0Yg
         uCwQF3il3eyjbV1FaR6502C6fH1s+7jh4obdTHBYq5vtYflZCfpP3dWt4hd0RHoQSHlK
         +zCQ==
X-Gm-Message-State: AOJu0Ywyntqjg3Aigx+RQyNhzGQ30n9yCZv1KcgfgG5rqZdNwtdUp57w
	ZRNcUVj80HRWNRMijPfbsfiTOWiZGBgbZ1jIMAGwwivYDtZ1yMlv6YKQ3zUI1W2J4h4UV8HhBrE
	J
X-Google-Smtp-Source: AGHT+IFmt/O9WZX/lFDiuezmNO3j0ssPcWjg6Um/H7DPMD1gXhdy7CobV013iiBIWTSC4eFcenwm+A==
X-Received: by 2002:a0d:f3c6:0:b0:627:24d0:5037 with SMTP id 00721157ae682-679ffbfc4a8mr10645207b3.0.1722022610994;
        Fri, 26 Jul 2024 12:36:50 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756795e992sm9977077b3.46.2024.07.26.12.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:36:50 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 13/46] btrfs: convert can_finish_ordered_extent to use a folio
Date: Fri, 26 Jul 2024 15:36:00 -0400
Message-ID: <707dc843b9812f05f89071714bcf881e24d38bff.1722022376.git.josef@toxicpanda.com>
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

Pass in a folio instead, and use a folio instead of a page.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ordered-data.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 82a68394a89c..760a37512c7e 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -332,7 +332,7 @@ static void finish_ordered_fn(struct btrfs_work *work)
 }
 
 static bool can_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
-				      struct page *page, u64 file_offset,
+				      struct folio *folio, u64 file_offset,
 				      u64 len, bool uptodate)
 {
 	struct btrfs_inode *inode = ordered->inode;
@@ -340,10 +340,10 @@ static bool can_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
 
 	lockdep_assert_held(&inode->ordered_tree_lock);
 
-	if (page) {
-		ASSERT(page->mapping);
-		ASSERT(page_offset(page) <= file_offset);
-		ASSERT(file_offset + len <= page_offset(page) + PAGE_SIZE);
+	if (folio) {
+		ASSERT(folio->mapping);
+		ASSERT(folio_pos(folio) <= file_offset);
+		ASSERT(file_offset + len <= folio_pos(folio) + folio_size(folio));
 
 		/*
 		 * Ordered (Private2) bit indicates whether we still have
@@ -351,10 +351,9 @@ static bool can_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
 		 *
 		 * If there's no such bit, we need to skip to next range.
 		 */
-		if (!btrfs_folio_test_ordered(fs_info, page_folio(page),
-					      file_offset, len))
+		if (!btrfs_folio_test_ordered(fs_info, folio, file_offset, len))
 			return false;
-		btrfs_folio_clear_ordered(fs_info, page_folio(page), file_offset, len);
+		btrfs_folio_clear_ordered(fs_info, folio, file_offset, len);
 	}
 
 	/* Now we're fine to update the accounting. */
@@ -408,7 +407,8 @@ void btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
 	trace_btrfs_finish_ordered_extent(inode, file_offset, len, uptodate);
 
 	spin_lock_irqsave(&inode->ordered_tree_lock, flags);
-	ret = can_finish_ordered_extent(ordered, page, file_offset, len, uptodate);
+	ret = can_finish_ordered_extent(ordered, page_folio(page), file_offset,
+					len, uptodate);
 	spin_unlock_irqrestore(&inode->ordered_tree_lock, flags);
 
 	/*
@@ -524,7 +524,8 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 		ASSERT(end + 1 - cur < U32_MAX);
 		len = end + 1 - cur;
 
-		if (can_finish_ordered_extent(entry, page, cur, len, uptodate)) {
+		if (can_finish_ordered_extent(entry, page_folio(page), cur, len,
+					      uptodate)) {
 			spin_unlock_irqrestore(&inode->ordered_tree_lock, flags);
 			btrfs_queue_ordered_fn(entry);
 			spin_lock_irqsave(&inode->ordered_tree_lock, flags);
-- 
2.43.0


