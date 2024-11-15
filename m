Return-Path: <linux-btrfs+bounces-9717-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AF99CF12B
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 17:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4787B2EFCE
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 15:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03891E7C31;
	Fri, 15 Nov 2024 15:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="oa2nZq9Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B561D54D1
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 15:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684703; cv=none; b=GdoYNcEZpirurDXXzG5RGDndMtX0I5CrWgNNLAJOUK1+EpRs094iNP4OSdDAacMnmLqnDPUNf05MI5si6u+cakpy5j+/B/D9kwn/yqssb5vNLZulcQuvXb1ei+8w9Kk4NJWyyO2s56xUi+FI4PdPqFMsgksRXUEHO5ByndiGEyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684703; c=relaxed/simple;
	bh=wJBpuZKjarBs8HwRCSHfMpMBiZ+HVYWNz5ARDhZnhyo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZ0W3CcaRnIG/D2WR4lahm3+xsVB3IpR0Ukf5pGuDYoHx8FZi3cSoW1LIy8NEZk3gO3lBE7UJSLRvrYhF4qBaNha+5XXKgzBBY4woaTnuYO4nLP0SYH/ymYrax+uH0tzut/J3zS3f2gLRZKfM7kQ5nG8dSe6KuXI1WJ9BMpmAs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=oa2nZq9Z; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d4035f2d18so2372726d6.1
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 07:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731684700; x=1732289500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QSuoTi14zhdgmEJ2e8nj/BNpHIFoytvzNxhl/LStwJg=;
        b=oa2nZq9ZwzzbdCsPBw9Jwz//1s3xZKULZm1HZeyLncTbcIDg8njRmB9VTheKZl467O
         mq6iDqEgcUuGO5uR9WW2KNWYFYIH1ctahp4Lds0E/BvcsU62TCjQ4wbYJhxBcQNjtwiZ
         Jvu03pcMarq8XI8xZofHMle0RuQ6LM9eeGJqHW0844ZhELkQpUMtZXr1mx3IUEQWJZeD
         dKiWPOcP1vXpzdX2ojoeDm6qsOYs6Iz7YCQ+FUMeZaZ1nUXfhc2mrL+RSacdk8rb7n9/
         f8I/thvHKxn0fPRWp3sqZoSSLG+Aru4IRQKdrTQwu7RHD9z6jYnYblQcweYNHhlK961E
         fC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684700; x=1732289500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSuoTi14zhdgmEJ2e8nj/BNpHIFoytvzNxhl/LStwJg=;
        b=LvwFJKu7RJW/UMW5/TvtiBLWTq0AQDeGo+v2boYLc7gtyDXf7u1hZYniXz6d+HuEUm
         9aUs0oA13R0G8pIcgVbRGBfWibtTpYKSHZNH9z66GKSO0OcwCneHsYnLAWHvxubffOCz
         XJLMTeZ/HUyDJzeTTTL0Y8wftQXtsTVQotHIsmvpRCAYnzqnZpxHyumWIWxGFxBg/Gct
         Zpj7Ke0hvRWjnx1IShEcyrsiZWWk8bLAgIC9TVvsVRwHZlWW8+Kgfq2AS/rmreSJaIyl
         J+Tekjr6ttagvdc1ITOh52ehLjl37W8PI5sfH2u7pfagBJHhhvfOPHav4kA+B+PK2Mty
         qpuw==
X-Forwarded-Encrypted: i=1; AJvYcCVJa3ZmPnQvshjYzmbjAkmBcvE2X/rk+cGaC3XflzsoZiNc30WaH1pALUlB6Vc+yqTMUeS4QB+POfbasA==@vger.kernel.org
X-Gm-Message-State: AOJu0YygXOi7k1130TDUU1gEZy+XJtTzNqjYhSisgbfGao3lrJXWRnfk
	8kQq6VEf0cV+eYtm5EjxfaUDPpc7PkZKQQToa1LHAud6LzbDKThrWcu39LIy1ClB6afdSwINDB1
	D
X-Google-Smtp-Source: AGHT+IHJEyVOG62NvWa9d1qggTtMCjzt+EKNCXFckK971VFGqKmUTAI/9H3Oo1mgh59gFKizdUDdeA==
X-Received: by 2002:a05:6902:1242:b0:e35:e173:3341 with SMTP id 3f1490d57ef6-e3825bdd813mr3265588276.0.1731684690002;
        Fri, 15 Nov 2024 07:31:30 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e38152c61d4sm989132276.5.2024.11.15.07.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:31:29 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH v8 05/19] fanotify: rename a misnamed constant
Date: Fri, 15 Nov 2024 10:30:18 -0500
Message-ID: <8776ab90fe538225aeb561c560296bafd16b97c4.1731684329.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731684329.git.josef@toxicpanda.com>
References: <cover.1731684329.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

FANOTIFY_PIDFD_INFO_HDR_LEN is not the length of the header.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 8fca5ec442e4..456cc3e92c88 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -117,7 +117,7 @@ struct kmem_cache *fanotify_perm_event_cachep __ro_after_init;
 #define FANOTIFY_EVENT_ALIGN 4
 #define FANOTIFY_FID_INFO_HDR_LEN \
 	(sizeof(struct fanotify_event_info_fid) + sizeof(struct file_handle))
-#define FANOTIFY_PIDFD_INFO_HDR_LEN \
+#define FANOTIFY_PIDFD_INFO_LEN \
 	sizeof(struct fanotify_event_info_pidfd)
 #define FANOTIFY_ERROR_INFO_LEN \
 	(sizeof(struct fanotify_event_info_error))
@@ -172,14 +172,14 @@ static size_t fanotify_event_len(unsigned int info_mode,
 		dot_len = 1;
 	}
 
-	if (info_mode & FAN_REPORT_PIDFD)
-		event_len += FANOTIFY_PIDFD_INFO_HDR_LEN;
-
 	if (fanotify_event_has_object_fh(event)) {
 		fh_len = fanotify_event_object_fh_len(event);
 		event_len += fanotify_fid_info_len(fh_len, dot_len);
 	}
 
+	if (info_mode & FAN_REPORT_PIDFD)
+		event_len += FANOTIFY_PIDFD_INFO_LEN;
+
 	return event_len;
 }
 
@@ -501,7 +501,7 @@ static int copy_pidfd_info_to_user(int pidfd,
 				   size_t count)
 {
 	struct fanotify_event_info_pidfd info = { };
-	size_t info_len = FANOTIFY_PIDFD_INFO_HDR_LEN;
+	size_t info_len = FANOTIFY_PIDFD_INFO_LEN;
 
 	if (WARN_ON_ONCE(info_len > count))
 		return -EFAULT;
-- 
2.43.0


