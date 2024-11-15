Return-Path: <linux-btrfs+bounces-9723-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E20CF9CF03D
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 16:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3B5828A6B5
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 15:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290E91F4275;
	Fri, 15 Nov 2024 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Nn8a0H/F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD83B1F4FAE
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 15:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684718; cv=none; b=aZqqcuATvpsSqYSr4/jrjIqvrmq8Pp9R12t3Uf0vcT5602C8tX02tDqqHgpObOMq7OBk7TQfAqFDdGgk7IM9HjfRGPoz6bzrIY7s91h4nHz9G+gnMV0PhI9chJiI9elOIqcr98mL826rX10ONc+jXVdx7P3U2wpsxwz+n9K7BlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684718; c=relaxed/simple;
	bh=2N0bizMEg0czxuSX0Hl7S5FVpQVRVn9Mf1MRV8yCr7o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LaMRvAgtZc4wA9fh2UBNG1gvLQI2MBQG8QC48tq0/bsreu0QGVhJgZn1mwRveWMnOrEFJFtjtzwHnAUXSLUmkhLBgh+7k7+kz8TBff/t/u4m9GB1jQZBFEIzD85fMgZXP4RaNmfttl7hJX8Fp/J/6nnawRlb5REgziyrlaGovl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Nn8a0H/F; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e377e4aea3so16031897b3.3
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 07:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731684715; x=1732289515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3nbIBZPU5mMiQBH7fH9PUjd6pvpSRIo6Q0oL6vGrX38=;
        b=Nn8a0H/FQysF4XkeMCetCBuCLA35sQ8Jz5j6L95M+XZBsWbp0y/hvT7Y6xEjhZGxVR
         IMSjsIQ75XwNJnQVdXGS8PkADAN+C993Gd/uRursWwPD00dUr6jEbff00nvhp2S96N6j
         8eVHb/vINrOraZxpKuUT0cW8e9KNdx4Pr/RLsRf82XgpD9CZqvzN7f1FZiMrmYYKgBSE
         RdlA7duTU6YjHT/tRPV81CgYurPJ6+frHb3go9wm1QAnlZHcAtuLOJJ/1N6UKblg8P/b
         UbGD5xbMt+XR+5NbgWrY5PQ/I2z+kjCG5TkU/5DhR6/6d+gf5eah89dExuFmC6XGlfBd
         8dyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684716; x=1732289516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3nbIBZPU5mMiQBH7fH9PUjd6pvpSRIo6Q0oL6vGrX38=;
        b=FZn9KAbhRXj7a5eM/2Ptsn8DCj5o74hXD5RANf0alhwDfn462QjOZ6mhoqwDJAM3Ls
         /Su7XxefJG2Ci7JNI8f3FOQWIZwVt+DP3F82mP/108Mj0hSAhGIFXnd8fi45gLSTELHX
         3S7MubXQXSGLxjJZqFtXPjcFeBY6IHzuxhdscO+lVn8tt4nt79PdY/GCvkjNdfGEcsBy
         PmTfzlJ7nUpfQM1W2Ggpd/MUkuIKUUYNRRBBrnt08VzNU0Qw9PvIAFsJdfobJbZUgyCf
         VZY/B/1B57v+XkyGCBFUqgfPcIKQepyHQSISxTm2DDH9suhfCKkfGO6a7r0j99skLnnc
         I+IQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNICUcL4RSNp5PgHoSs41Pal/2GYCYyvN7id2/hPkGDz0aAI+SXZM63149MUnIuE89ALHj66a8WeiXoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKKA7QABviIuIBRlbWkWL0gDSehfrt+FSwtldeLvbLk3Jr3g2c
	Vk/dJMNh/zQULEozueOJwG/giMTwJ+bHI7/GU7Bxs3FNepiSXI+eCC01PRy7aRg=
X-Google-Smtp-Source: AGHT+IF2kfSK7avJhhme8jmNEknNmwYth/OIHi/JSJVRuMCWaSMr+rN1yucoeC0+W4HJkwXlrHqqNQ==
X-Received: by 2002:a05:690c:688a:b0:6ea:7c46:8c23 with SMTP id 00721157ae682-6ee55ef8021mr42068567b3.35.1731684715691;
        Fri, 15 Nov 2024 07:31:55 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee440709dbsm7729117b3.54.2024.11.15.07.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:31:55 -0800 (PST)
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
Subject: [PATCH v8 17/19] xfs: add pre-content fsnotify hook for write faults
Date: Fri, 15 Nov 2024 10:30:30 -0500
Message-ID: <9eccdf59a65b72f0a1a5e2f2b9bff8eda2d4f2d9.1731684329.git.josef@toxicpanda.com>
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

xfs has it's own handling for write faults, so we need to add the
pre-content fsnotify hook for this case.  Reads go through filemap_fault
so they're handled properly there.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/xfs/xfs_file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index ca47cae5a40a..4fe89770ecb5 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1458,6 +1458,10 @@ xfs_write_fault(
 	unsigned int		lock_mode = XFS_MMAPLOCK_SHARED;
 	vm_fault_t		ret;
 
+	ret = filemap_fsnotify_fault(vmf);
+	if (unlikely(ret))
+		return ret;
+
 	sb_start_pagefault(inode->i_sb);
 	file_update_time(vmf->vma->vm_file);
 
-- 
2.43.0


