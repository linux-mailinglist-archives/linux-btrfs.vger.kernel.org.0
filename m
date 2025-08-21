Return-Path: <linux-btrfs+bounces-16207-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1274EB30642
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 22:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 794D8188CE5F
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 20:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DCC372190;
	Thu, 21 Aug 2025 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="H7FCKGiV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B473A371E89
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 20:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807628; cv=none; b=LimuIRUoJVLKUT+fQWyD4tW//KzZ8N6hZH207lIAK51D1LskWpyidw5bp6nHIrnBG9WzeV0t68nQ42GXgeO6ni0fpYOASRIMh5Q8DovWEABSV7Jlj8j6Kb1bGhGjhpVKrJjZnZa85AZtGMyh/2S4zOWLCWvEUJubpZDrojVJbGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807628; c=relaxed/simple;
	bh=VW5j9pCOlroZhl/lnWfntKbo6qQXfaDKec+FJlQf3TY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXRZYEIvU+RPUyTT8yQe3s/87P9cnVu1sxCgAqT1iv4/byK0NGw3N58yqQ61aRKHdu+mX6HSTqwZCIUpkgy1mPUbs13zSJEG3RMvPBkrrefHM77hom2p+4O1GVOOiysYCzG4ET/2LbsGlg6kB0DTlzLncM+eW06GwmT4dKL48qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=H7FCKGiV; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d6051afbfso12417177b3.2
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 13:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807625; x=1756412425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VojWusNxgTfPnzlXh9Aw6r7SNSzmMD9Pubt2ZgZyin4=;
        b=H7FCKGiV9rPYtCdu1AbEOsJUd95oOwUHPt1VmyGHmjWdnwvzkiS2bRI1st3t+RaPEl
         3tlBu43SDBy9odOfNZaf4AOI6KR8fiL92bOuK2e3ZCzgbgXtMVRWWoW+snti4LeXgn7M
         nekQEGJnhGcExHdqIX5MM2qG4vHtigNNWlZA2sp4UIeY8ZgEvBfMN915r3q4dZfbOIGY
         Wv0jaxoLJApbEafnU76CRw39tUvjeYtb/1JvoZAu9tZxgbISevZCV+f5vM0MFUIghNrF
         coiLsBoF7bmf8F7HMD008zpv6aN+HQCEsiS0eutPQUyrGqZGWEhpEOL7ZuvhVU5QGMLl
         A1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807625; x=1756412425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VojWusNxgTfPnzlXh9Aw6r7SNSzmMD9Pubt2ZgZyin4=;
        b=VNUSyZ2Tt6PMwb0rQWZZT7CWNj8GWSjFh5lYX32lgSTN1ViuV4RqeG71jwR8yONi9F
         esdgUtBaN5iZo7MVIpI8j1vgjleAGuOZGp6wlau6KtjtzR9g2aHAuGFm0yMmiBKEERg2
         ZnnchcqCx8SvLx/nYmevR5Xkt49HmjUVfCqj/wlO30wyufmEY6CUJPmK0L2Qvwu6tO3p
         b+wxSwxnSnlvNNfEyozZgmwFptPT+iKrq5xNNajx2rt8g/EFhVQcQpOBUKVmShBfiP51
         MKLsy5Zg0HFiP0WaPRqUnfkDscVYxcdLuzpZbbvRt7mtbiCcf1mq55Gh5XFHZEiBl1OX
         orrw==
X-Forwarded-Encrypted: i=1; AJvYcCV+otFp3GfRYTGTabZE0y4eqeNYRNiGYX+S6ukc/g+cc5XF7RExArl0jSB1j1rMrQl2m0ZmObinK0CWuA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi3oTiW/SIH7bFN6t8z73EKYJrWrjrBdrFY+clqtC0bkgjvvp6
	mjxYKOCl1Qe39NeN9e3TdOFY8K3toY4YZguV4kA2n1qdAGQCjOZLXv6oUthHRr/adnk=
X-Gm-Gg: ASbGncu/OimWsvJHHsJ90bCx6U21uPUWZYMS20Amdx22zzH0ylIu19gKh1+XOTE7ZU1
	OlZQDbraXUG8HzA3cf9z9lF1PGKw01itkxFIfurxDXTOoD3/oyjyI0scKwgAJb6dIw4Kc6kwGug
	r1uHEmh3xCGrEXTDDJiDUjZs1efnEzaNqYlhPdFaMOMCdBT1qrW7sEijvdfwK3NIWzY8UZqegC9
	300pPsx1wZ75XoUi+1/2PAGJdIOCt9+STYf2q+CkeslxjCkzyfpUUgvx2nqXs7uOxD3orCVqy1y
	+7IKMPjTZOQBRTVaBQLI+Qn7LTC6iAH7F9hf+YthP3s9cx3Zqu+YRTV2sIYRWZAeLCYhARrpACb
	pi6qf8eSrkUX5wW3p9vwxskxNH58eCzC5OT4MXFTKZtc4ChR7S4N/YToA54c=
X-Google-Smtp-Source: AGHT+IF8JBW4Xh52SDVildob/BUomhJ9K4wuNU15xnoWWWlqqaOPm3Y7fskuJegwPAQeudlS8EK8SA==
X-Received: by 2002:a05:690c:680c:b0:71f:b944:1034 with SMTP id 00721157ae682-71fdc530ce2mr6839237b3.49.1755807624618;
        Thu, 21 Aug 2025 13:20:24 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71fdbedffd8sm1165897b3.5.2025.08.21.13.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:23 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 06/50] fs: hold an i_obj_count reference in writeback_sb_inodes
Date: Thu, 21 Aug 2025 16:18:17 -0400
Message-ID: <1a7d1025914b6840e9cc3f6e10c6e69af95452f5.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We drop the wb list_lock while writing back inodes, and we could
manipulate the i_io_list while this is happening and drop our reference
for the inode. Protect this by holding the i_obj_count reference during
the writeback.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fs-writeback.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 24fccb299de4..2b0d26a58a5a 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1977,6 +1977,7 @@ static long writeback_sb_inodes(struct super_block *sb,
 			trace_writeback_sb_inodes_requeue(inode);
 			continue;
 		}
+		iobj_get(inode);
 		spin_unlock(&wb->list_lock);
 
 		/*
@@ -1987,6 +1988,7 @@ static long writeback_sb_inodes(struct super_block *sb,
 		if (inode->i_state & I_SYNC) {
 			/* Wait for I_SYNC. This function drops i_lock... */
 			inode_sleep_on_writeback(inode);
+			iobj_put(inode);
 			/* Inode may be gone, start again */
 			spin_lock(&wb->list_lock);
 			continue;
@@ -2035,10 +2037,9 @@ static long writeback_sb_inodes(struct super_block *sb,
 		inode_sync_complete(inode);
 		spin_unlock(&inode->i_lock);
 
-		if (unlikely(tmp_wb != wb)) {
-			spin_unlock(&tmp_wb->list_lock);
-			spin_lock(&wb->list_lock);
-		}
+		spin_unlock(&tmp_wb->list_lock);
+		iobj_put(inode);
+		spin_lock(&wb->list_lock);
 
 		/*
 		 * bail out to wb_writeback() often enough to check
-- 
2.49.0


