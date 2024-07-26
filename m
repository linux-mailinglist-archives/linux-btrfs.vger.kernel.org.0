Return-Path: <linux-btrfs+bounces-6748-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA1D93D908
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2100B2308F
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23207145B00;
	Fri, 26 Jul 2024 19:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="tMEikmd/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0298143759
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022607; cv=none; b=Uyrb+sx4M0JcB+rrSGP+gkPjwzwcCfmQ+Aeq1H3WTSQ8IH98tO+W8BXyvyxVvFm4+jPwvdjOyEqDnOdi+EQXhl+clqzWjqyG6DJeY+gdN/boNMwDFzTL3dHm6gbKd7PlKpvZIJX9w+DSoE40okoX2Zyj9mJ4houZEUm019SsDIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022607; c=relaxed/simple;
	bh=3bPbADCS2HpfhslYpNioSuMX/epY9LtEf3G8hvbnK34=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdu3BzZzI3yYYKjmN6ROJccUpsm44k3RKiQc07Y3y3RovMGr47Zs3jAn9CTPicrNlOnfBMdbTtfjKbJ9KPIY4qhtgw5Yf2/IpsFdsK0fKBZIHrcsdbr3ZXXlvqOY37h7y2guSRkEJBIvJvHwMnuInjQpks1/dFrNdxbrzukFeQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=tMEikmd/; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-66599ca3470so395947b3.2
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022605; x=1722627405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K1tPlUcBg+AQjlcZOU2aBLx99C3Jfi1gm9Dpkd3CfrI=;
        b=tMEikmd/b8pSfNbYMCWiYycDThYrP/+YMylr0nOMnQadu3otC1ampZ46Adjg/CPf3I
         t3ZDFlnte3Sd1Smi9CgI+k3GmaKiaTLgtFT0Uu/cKeN/f4z+BTsmD348TqGqmb3BQIj2
         W7lSpH+SGO6RhxhqkSULvooBPwiRORkMzkR0XEjg6SG4D9BohAMzKmFTM567C1TONYqV
         MLnlG4MtdU2BxWDe8GUpO/gQRN2r5d1Dh8Ksdyo0QOgtQSmHe+XT6n0QJRe0mRx9t/XP
         TxEHWp6eHLpoVcT6p8+rps4UVB/hNJ40Z+ngbE7cEkld+98Myq+3UCgkVrrau9tSYZhD
         rMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022605; x=1722627405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1tPlUcBg+AQjlcZOU2aBLx99C3Jfi1gm9Dpkd3CfrI=;
        b=ZvfXWNXzFst7VrtoWYYt3aTBTIa/B14nc0c014K0yHM0IYQqsob8I9hkSW2xyp5+Zx
         AXIifyP8WaDsMhA8Fb7EwI+oiD9VAsYQBxc9KW/7orQtMJMa+weSiyAtooRge3UDtW0u
         0qG6NqeOyrBWcrKoRQIviFr6vmDcjFJOaXMoZMUVUWBm/hp0hOkxETWkeIhHlxCOAxfB
         W74rKdPTYy5OQjoDohdpZVfDQsCSd1N0y0ul9+elKu3UjrsGKcb7lQVFxFYIsOViO6gw
         lnxt4igmvnO+bWS1kbi0w77pysxbtHpwMHJNkrxYIJYMl0mqcj5pHxcvMUAqgD2oqFbc
         HGAQ==
X-Gm-Message-State: AOJu0YwauzwO3vaBJdkutXMd/XIkElakf/D4tF9hesYPXPVr0dctQRic
	t4MV9uwv5urVyYcwM3oe4ONY9anJCiqCHeZrai2Vjocn9Zheyt0Dryzx48WMQk9ECW4eQoZM3Jh
	I
X-Google-Smtp-Source: AGHT+IGTJGpi+AwKXS3QmEnY1AVDG3uHlPLeRI4TpoNj9gNuGG9L7ax3ROoTgyBGzFbH9UYv3ujMAA==
X-Received: by 2002:a05:690c:ec5:b0:63b:df6e:3f6d with SMTP id 00721157ae682-67a0a7fc533mr10170997b3.37.1722022604735;
        Fri, 26 Jul 2024 12:36:44 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756bab5090sm9959487b3.120.2024.07.26.12.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:36:44 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 07/46] btrfs: update the writepage tracepoint to take a folio
Date: Fri, 26 Jul 2024 15:35:54 -0400
Message-ID: <b986d4c374360137fa9c95a591bf083735de06a4.1722022376.git.josef@toxicpanda.com>
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

Willy is wanting to get rid of page->index, convert the writepage
tracepoint to take a folio so we can do folio->index instead of
page->index.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c         |  2 +-
 include/trace/events/btrfs.h | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 973028a9ba3f..eed2be8afb15 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1531,7 +1531,7 @@ static int __extent_writepage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl
 	loff_t i_size = i_size_read(inode);
 	unsigned long end_index = i_size >> PAGE_SHIFT;
 
-	trace___extent_writepage(page, inode, bio_ctrl->wbc);
+	trace___extent_writepage(folio, inode, bio_ctrl->wbc);
 
 	WARN_ON(!PageLocked(page));
 
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index eeb56975bee7..3af681642652 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -674,10 +674,10 @@ TRACE_EVENT(btrfs_finish_ordered_extent,
 
 DECLARE_EVENT_CLASS(btrfs__writepage,
 
-	TP_PROTO(const struct page *page, const struct inode *inode,
+	TP_PROTO(const struct folio *folio, const struct inode *inode,
 		 const struct writeback_control *wbc),
 
-	TP_ARGS(page, inode, wbc),
+	TP_ARGS(folio, inode, wbc),
 
 	TP_STRUCT__entry_btrfs(
 		__field(	u64,	ino			)
@@ -695,7 +695,7 @@ DECLARE_EVENT_CLASS(btrfs__writepage,
 
 	TP_fast_assign_btrfs(btrfs_sb(inode->i_sb),
 		__entry->ino		= btrfs_ino(BTRFS_I(inode));
-		__entry->index		= page->index;
+		__entry->index		= folio->index;
 		__entry->nr_to_write	= wbc->nr_to_write;
 		__entry->pages_skipped	= wbc->pages_skipped;
 		__entry->range_start	= wbc->range_start;
@@ -723,10 +723,10 @@ DECLARE_EVENT_CLASS(btrfs__writepage,
 
 DEFINE_EVENT(btrfs__writepage, __extent_writepage,
 
-	TP_PROTO(const struct page *page, const struct inode *inode,
+	TP_PROTO(const struct folio *folio, const struct inode *inode,
 		 const struct writeback_control *wbc),
 
-	TP_ARGS(page, inode, wbc)
+	TP_ARGS(folio, inode, wbc)
 );
 
 TRACE_EVENT(btrfs_writepage_end_io_hook,
-- 
2.43.0


