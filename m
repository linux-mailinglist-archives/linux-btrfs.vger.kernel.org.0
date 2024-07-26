Return-Path: <linux-btrfs+bounces-6768-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA9493D91C
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3627B283A76
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF8C14E2E2;
	Fri, 26 Jul 2024 19:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="VMIJeQST"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2F24AEE9
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022628; cv=none; b=TFIWMZPlrctQSHk8cbvw5iv+umueO5MxhAWFbiG/14AzKo7vs8d0/k3uyatNWY+2j/GNknxtLVK/mt/gsc+C8z2llM68PPbkN8oeB76I1OueKKtvHUf2YGM0uPcZ1EpChCkB1B/saEjtfG6kbvYtaUVGj/lwdsr3j83to//MaTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022628; c=relaxed/simple;
	bh=BE5n0wzzNs2giZL0UI05zMNv8ItKz0Zm+10eLjTjdyE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6wedcgNQmESWKV+iirs3v+AsbnVJqOVlhjwHFkd2+nSFTsbm5RHyG5APn52GlWHOoRFFPoN2zYbrDqGzucKTDpIIeBZ3+NBPvE53pNvmF3XgEwJrcxOdrR8KzfOywz9cC93XZ188LIqItKp0uOfpkUYozOfkcAgV4Ij0K8LXAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=VMIJeQST; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-65fe1239f12so564837b3.0
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022626; x=1722627426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ymN4eCpoeNZacIzt3rOcGtpA4GpPoFMo44PJbXvbV4U=;
        b=VMIJeQSTp9AHjVoJ08hSlgWlL45ShUACxVgQDCUXXnG0EQ96evJQ5Jtu8fr6Ag1Lz2
         cUfaYCFB/51OvH5R24m6gx2hn86XIDW4YTIrIWjy3v8YOF7FJk58crWT5KsSLphc/mPH
         huIWPwwGVgIyiBSMZCfCSHFRP/+huio9MSWUDm97Gc52I+GVXYMZaxeFOGYHxkunw+yw
         tif29gZD0TCcMy/VYxy7OcZdMQ6izVAQZvOv281hyac5dRu5g2w0GqYDNZBd+9PfPSz8
         oONriBx2lSHhzx7gB7UQeJfGw+H9zjcedh1yeBItjDX81KrquM/4TL+qQwzVk72bLcXY
         UWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022626; x=1722627426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymN4eCpoeNZacIzt3rOcGtpA4GpPoFMo44PJbXvbV4U=;
        b=OUF2YDhz5HyX5qLaN2mYZ5ZCWbyjaOI376V8GJk/Yboa2ma4KCf/yCaBWwliD91EO0
         m2rU9Ugn1I/g/7oSvZMXye4o6dREyTW/5RUYNJ66M/ew9y9C+VmqvebDvgdWKDS/KOjy
         X8hceKzJstMXpAPoBSzee59xXlujhYr3nlxhClyO1kF1gxQfRcAIVrApa7WjCvRhScKn
         ITtqMLf25J+zVKGHarhOuk+GirA8PI7fKFMgeLeK1xhTmIbnE6gM50W1W0VA6xHEcU9r
         +i7ajSLWGWPMjRExbDFwJ4+7itehSeM2HvIxI0MeIz41hhwoUOX0MjjWtrg24hHfYPAl
         06/A==
X-Gm-Message-State: AOJu0Yzg/Ow5JsY2ZrSP7tWY6bQicOsAL/CJNtQYRLwoWuAsij42yPt3
	bPIIUaGuXXK20DZRK4nSFKStMf0NHzTlQuMyQtCzQBPdr6iIsxhTQXbzK+i+ZtSs9TpflgQyd7m
	U
X-Google-Smtp-Source: AGHT+IEspBnmO1sJcSKORGUxJTZC2xCc328MpUMGGBrVgm7AFRQc2OWQk7I6eEN2sKkt75XN0xWfxw==
X-Received: by 2002:a05:690c:6d89:b0:66a:76cf:f312 with SMTP id 00721157ae682-67a05b949bemr9666127b3.11.1722022626277;
        Fri, 26 Jul 2024 12:37:06 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756b1193basm10024997b3.95.2024.07.26.12.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:37:05 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 27/46] btrfs: convert fallback_to_cow to take a folio
Date: Fri, 26 Jul 2024 15:36:14 -0400
Message-ID: <5bbc066b26be3d629474be5f76df606bd61d1a84.1722022377.git.josef@toxicpanda.com>
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

With this we can pass the folio directly into cow_file_range().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9fc15b881dba..d8ff1bb188e1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1763,8 +1763,9 @@ static noinline int run_delalloc_cow(struct btrfs_inode *inode,
 	return 1;
 }
 
-static int fallback_to_cow(struct btrfs_inode *inode, struct page *locked_page,
-			   const u64 start, const u64 end)
+static int fallback_to_cow(struct btrfs_inode *inode,
+			   struct folio *locked_folio, const u64 start,
+			   const u64 end)
 {
 	const bool is_space_ino = btrfs_is_free_space_inode(inode);
 	const bool is_reloc_ino = btrfs_is_data_reloc_root(inode->root);
@@ -1833,8 +1834,8 @@ static int fallback_to_cow(struct btrfs_inode *inode, struct page *locked_page,
 	 * is written out and unlocked directly and a normal NOCOW extent
 	 * doesn't work.
 	 */
-	ret = cow_file_range(inode, page_folio(locked_page), start, end, NULL,
-			     false, true);
+	ret = cow_file_range(inode, locked_folio, start, end, NULL, false,
+			     true);
 	ASSERT(ret != 1);
 	return ret;
 }
@@ -2151,7 +2152,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		 * NOCOW, following one which needs to be COW'ed
 		 */
 		if (cow_start != (u64)-1) {
-			ret = fallback_to_cow(inode, locked_page,
+			ret = fallback_to_cow(inode, page_folio(locked_page),
 					      cow_start, found_key.offset - 1);
 			cow_start = (u64)-1;
 			if (ret) {
@@ -2230,7 +2231,8 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 
 	if (cow_start != (u64)-1) {
 		cur_offset = end;
-		ret = fallback_to_cow(inode, locked_page, cow_start, end);
+		ret = fallback_to_cow(inode, page_folio(locked_page), cow_start,
+				      end);
 		cow_start = (u64)-1;
 		if (ret)
 			goto error;
-- 
2.43.0


