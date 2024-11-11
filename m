Return-Path: <linux-btrfs+bounces-9452-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A65249C46AD
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 21:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B61A289A57
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 20:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6431C9B9B;
	Mon, 11 Nov 2024 20:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ul3sfdrd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289781C9B97
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 20:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731356379; cv=none; b=DCA+wBYL99boKCHR8X6/FbWapbke2XuQmCnuaM8RAJn4yZoHp+qksGx4UD34x0izSH1pIiKViHpzc2QepOml0JPWB10vhhBf0WHRAbp0n4RSPVdevKg919hl750BasCgwwcSW/4ZxCUCamXfUINsCeCjbN5FONb0jkvQNsNXMl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731356379; c=relaxed/simple;
	bh=g8f8HPGo6FF6bNhCenpptLnEwEhFsJS2XcfOHpq3gpw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epF6VTgR8vOJT46zlARThqcXIXVYzxQjv1YJN19zxsnecEGhV2+UhR/Q5v+P2OlOXasLaS5i8XkrGx63ks+2i+KKP9QadReTGNz6Z62DK16JG+HP4DeR4Z5rc0zbz0NLf1zHu6oCzJVLiOGD6s8QTT1XlXrNW2nLdtPaG+4Cits=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ul3sfdrd; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b158542592so343955085a.2
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 12:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731356377; x=1731961177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qkyyLOcMapxd8eZps50M2cPjgtuAOvBDRyUA+1LsM90=;
        b=ul3sfdrdnV34wC5BOw9gEuQZTFZo6RWEaCK/AQr3weUiTVU/eJkPtu9fgqudOsJXnv
         mZQj0sOAbfHNRFTehmU174vQivZGCUYNwADSJ9qV7Wyw/j3oyq5/gRKmj06ki2wD6JNy
         75RkjRTrqTQ/lCnQa22zFxX7asmDSp3503jGvAIce+8FbpLPJ6UB6O/AJPUeLCiV+aCR
         7+PZ6R7vOGnkwyTkgTDuCySVK9RNBzQhe5LdYWDiV1Ej1FOBlVtMQwdGy495bC+y56mu
         6ZCDJEMlkyjuYiDc5dW7atL7J8aPlLG605AIYviz0sGSZc6jaB8FO3OYgiwfU0pytqqC
         apdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731356377; x=1731961177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkyyLOcMapxd8eZps50M2cPjgtuAOvBDRyUA+1LsM90=;
        b=TxhRyqVd+lvbETyvFQAmCBIcqv03chqz8uiIGysPGmJl33w6OuqY9CsZpKb5rN2Axy
         t8bTOWHVA+o++bYe+LZAbdeRmz+v1T6bb910xrjvGqJvsesmuGBvJ8UoE+sqzUjb8ccz
         c2cPHtZJ5RG71oVd1BNdyucU2SzF7Iukjh2pXRgghCfYXXsjfnNSloCHQl0AkhHRiTTN
         2rWHZ3Q/e4nHhdF5Y3SaPCTb2UFQ18yC57IfretttOpKnsBBdbFPmx5sVix+0c+o84ON
         AN/YHmSsbchiLqix0jz0Tbb9lrWc1j7SJdAATALKYQ7s0PbKY1HUUX4xocNQ0Z+iMNbE
         mV7g==
X-Forwarded-Encrypted: i=1; AJvYcCXTATS9mLut+C4lo3eghoezPmIYerQGqTKzLrR5SEqwBSmNL+5R/3NkDLZYx8j8MqAFmCKMOcoVjqSXow==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpmJhfYJ84J+2cHMy5+Ywq92aMdbyVKMCeQHdMNvGYsT0q8zX2
	fDrb6sexnSDP7z4/FNGpDNxUbiZ3WBa3/7+aswh3EAopdK7TsAnrzJqjMnZFfJw=
X-Google-Smtp-Source: AGHT+IGjGL9g3kFfcH+6V8KAtQzfg7b48XSPpKvHKYOiM22WInprVkhEgNc7K8iBcMmLd7E6fsLBYg==
X-Received: by 2002:a05:620a:19a7:b0:7b1:3e41:849f with SMTP id af79cd13be357-7b331eff745mr2211412185a.47.1731356377090;
        Mon, 11 Nov 2024 12:19:37 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32acae57asm525455685a.81.2024.11.11.12.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:19:36 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH v6 16/17] btrfs: disable defrag on pre-content watched files
Date: Mon, 11 Nov 2024 15:18:05 -0500
Message-ID: <c46f21bd55082ccf7380d438d82d3ebbaea284f9.1731355931.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731355931.git.josef@toxicpanda.com>
References: <cover.1731355931.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We queue up inodes to be defrag'ed asynchronously, which means we do not
have their original file for readahead.  This means that the code to
skip readahead on pre-content watched files will not run, and we could
potentially read in empty pages.

Handle this corner case by disabling defrag on files that are currently
being watched for pre-content events.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 226c91fe31a7..9b13df1ea729 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2638,6 +2638,15 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
 			goto out;
 		}
 
+		/*
+		 * Don't allow defrag on pre-content watched files, as it could
+		 * populate the page cache with 0's via readahead.
+		 */
+		if (fsnotify_file_has_pre_content_watches(file)) {
+			ret = -EINVAL;
+			goto out;
+		}
+
 		if (argp) {
 			if (copy_from_user(&range, argp, sizeof(range))) {
 				ret = -EFAULT;
-- 
2.43.0


