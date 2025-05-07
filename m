Return-Path: <linux-btrfs+bounces-13806-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B452BAAE82F
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 19:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC624E1D92
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 17:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8A228DB59;
	Wed,  7 May 2025 17:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="mNajizjU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5061DF748
	for <linux-btrfs@vger.kernel.org>; Wed,  7 May 2025 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746640184; cv=none; b=XnmDzHt8PiNBMofTapEWjWyEwgaKAt5S96R0bpCpynpIGOczaCevN5vfDjXcAH8Q5iDBWW7wPgybOPNa54C/J7KkP+7d1Gi4qi7fYtaYr+vqqLxdCFoenrqL6KVIAsbfe6T+mj2v452ENv8mC/v3FUaUIJxGzlTLirQlNw5qyuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746640184; c=relaxed/simple;
	bh=JU9FjPvgtCg6P7W6miM/YmPqGBvyWOhO+aAD0PYN804=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qxtvuuLNTT7HlCXRZpXI8dNfjY+hsBiUmRqoRagxhRYKx7bpnMP+FesYQ9g7R2EZlgzkcZlJfMaDLpEoOEnxZgfXEQMfGAvqs9O8qvzlC7ZsgjKy+Oxl2eim3OokkvuiT2bG/P4qkela/ZLgNov4KV+oFjkz2f7DEyo+0f5bPbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=mNajizjU; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-70427fb838cso1076527b3.2
        for <linux-btrfs@vger.kernel.org>; Wed, 07 May 2025 10:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1746640180; x=1747244980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XORqY8bsBfReAiOhhIGHXHA2xD+TszyJNXE+JF8i4CY=;
        b=mNajizjU8h6QPt7lzdmFFxTfd/Wjru6+G3EURYFNUkB1P2D54uWB1WMHj4tgle81uy
         YaHgD+Ppvd0poHgT0fvnN18EumIrYGCqQxiUpWFIj5fAS0Y0YOWpVLLxYZf6Y1OzcSHw
         IkX1UBKia+6gL3jimUlqo++BjVwFfyxG5vU37n4vuGcCiLHdmeVKMaYcyMCz1KbXMyHo
         Jcz2NX+7s9jeJdeRoPUfsBg5BHBxS/n+x3K7GvjfFTr9ew+6r6PmRJ7FlSADkowuvEV8
         MRN/WPlrygSvM7EUO4Qnd80ZBySGJ+reWAbMmLlFkVBjZErJhkxrZQdeYqI+w/bCIJPR
         tepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746640180; x=1747244980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XORqY8bsBfReAiOhhIGHXHA2xD+TszyJNXE+JF8i4CY=;
        b=ofba1Os48qAJj/LmFDgeGHwHUJDbIY6Lgb8IWYQYxfUG0oyj1ST/TfZfcvyYJVkjcv
         gVrt0D/CBwvFZ23Rp6riP9b8+xSUl8UJvAB2KS8hIAclFfKK3D5tmhcFwcNd0JYMRl06
         hJeDvLm83z9YgwI/Y0uXKFIDg2HnFuZynyprcJodwPsKRm8btqGwnDgSbVXFy5dL6z6R
         BvUruHWhIhsa6cYb3c6ErMYnSXqwcp7gTqKvs/nRsezRFYavX+KCLZlgDWRz0Nalvwga
         QbQAH3opKCNY0R+vgzdp9/BWzDJRHf+chouPyL6RGlkoN0mTjd1QbUXtFCNtuyHB2suy
         AIvA==
X-Gm-Message-State: AOJu0Yzbi/3K+J7+WCRyMpOQNoaJaWMboIbUdmlmQYEQVNE8NsKBrJBU
	dvbqX2YqaycBbglb4uMceFKWHpSlmLgNLdlnKR3VaZR6YxIvyrr2vApg/mZzKPualyfjthD1u83
	GzUM=
X-Gm-Gg: ASbGncskK8MPmYKgmzRAoWIaVqy2rX70YIKG/C+vuEnYVB/Tze5SvtT1kkb5mFE9MwS
	K/e9T8DrJNOid1U3c/xtK9UwdBvzeUa42C9IHLt1zavCMyrrwkyeALXaxfkG1jY7ClS0EqQhuwv
	SaGK6lej/7ksCZyz8LsHsCw0KIkeAN45PPeTFg/Q5oNn200nsCS+WT+c5l2KGCKfJAyJxNxFO7P
	dQC0REEIAtO08ej8rIXdnBZpTT96GhDIq79Mafh6GTTMrM56S3lMA1nanGMrjvOSdiee//2Mzwy
	IbDl+KC7Zso8rls0d2kUWhl9h17mliEQGDn2qXKV+//wD/chZay+4ERgy+WDej6so5ycdcs/azP
	PQoF8Dy+pOGMC
X-Google-Smtp-Source: AGHT+IHbeBVE2fQCjpS8sDbIZxvHlF0Fj0n1Re2wJMtWIZl8W4N25XdqAr+rBYANXbtDaGku8Z6YoA==
X-Received: by 2002:a05:690c:380e:b0:708:1d15:e008 with SMTP id 00721157ae682-70a1da88e33mr62845477b3.13.1746640180025;
        Wed, 07 May 2025 10:49:40 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7092bdd66d6sm9103397b3.51.2025.05.07.10.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 10:49:39 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: handle subpage releasepage properly with xarray
Date: Wed,  7 May 2025 13:49:33 -0400
Message-ID: <d4bd5c3c2f9ce345daa12b059d326d1814cce660.1746640142.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Qu reported a EB leak with the new xarray stuff.  I messed up and when I
was converting to the easy xarray helpers I used xa_load() instead of
xa_find(), so if we failed to find the extent buffer at the given index
we'd just break. I meant to use the xa_find() logic which would mean
that it would find the index or later.

But instead of hand doing the iteration, rework this function further to
use the xa_for_each() helper to get all the eb's in the range of the
folio.  With this we now properly drop all the extent buffers for the
folio instead of stopping if we fail to find an eb at a given index.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f56c99eb17dc..b44396846c04 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4246,31 +4246,14 @@ void memmove_extent_buffer(const struct extent_buffer *dst,
 static int try_release_subpage_extent_buffer(struct folio *folio)
 {
 	struct btrfs_fs_info *fs_info = folio_to_fs_info(folio);
-	u64 cur = folio_pos(folio);
-	const u64 end = cur + PAGE_SIZE;
+	struct extent_buffer *eb;
+	unsigned long start = folio_pos(folio) >> fs_info->sectorsize_bits;
+	unsigned long index = start;
+	unsigned long end = index + (PAGE_SIZE >> fs_info->sectorsize_bits) - 1;
 	int ret;
 
-	while (cur < end) {
-		unsigned long index = cur >> fs_info->sectorsize_bits;
-		struct extent_buffer *eb = NULL;
-
-		/*
-		 * Unlike try_release_extent_buffer() which uses folio private
-		 * to grab buffer, for subpage case we rely on xarray, thus we
-		 * need to ensure xarray tree consistency.
-		 *
-		 * We also want an atomic snapshot of the xarray tree, thus go
-		 * with spinlock rather than RCU.
-		 */
-		xa_lock_irq(&fs_info->buffer_tree);
-		eb = xa_load(&fs_info->buffer_tree, index);
-		if (!eb) {
-			/* No more eb in the page range after or at cur */
-			xa_unlock_irq(&fs_info->buffer_tree);
-			break;
-		}
-		cur = eb->start + eb->len;
-
+	xa_lock_irq(&fs_info->buffer_tree);
+	xa_for_each_range(&fs_info->buffer_tree, index, eb, start, end) {
 		/*
 		 * The same as try_release_extent_buffer(), to ensure the eb
 		 * won't disappear out from under us.
@@ -4278,8 +4261,7 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
 		spin_lock(&eb->refs_lock);
 		if (atomic_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
 			spin_unlock(&eb->refs_lock);
-			xa_unlock_irq(&fs_info->buffer_tree);
-			break;
+			continue;
 		}
 		xa_unlock_irq(&fs_info->buffer_tree);
 
@@ -4299,7 +4281,10 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
 		 * release_extent_buffer() will release the refs_lock.
 		 */
 		release_extent_buffer(eb);
+		xa_lock_irq(&fs_info->buffer_tree);
 	}
+	xa_unlock_irq(&fs_info->buffer_tree);
+
 	/*
 	 * Finally to check if we have cleared folio private, as if we have
 	 * released all ebs in the page, the folio private should be cleared now.
-- 
2.43.0


