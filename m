Return-Path: <linux-btrfs+bounces-9725-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2079CF043
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 16:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C96428AEFB
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 15:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E049A1F80CB;
	Fri, 15 Nov 2024 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="qf2O11I7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FDF1D5CC4
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684724; cv=none; b=Qz3Ug4+QaxRY+IyU0BV4m56Z7fDwg0q8OPJiQFOUr41VTYVM2rJWiKQhnQ9hATZ1XGIsOGNM+SmV+TTaqBOvTH44EGPWZssuwWRGluIfX/RM0wxlCMm7Y0YlRFnTlnhBpkzCeXP+rMGUYfeBmtVnHReYedW7JRBkDZmPCvmpiqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684724; c=relaxed/simple;
	bh=+l9EWxArkxZP8ea+ZGgm7I/UwC2ThOnM6mqb60PUC1g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HxCKMOOoN4AfREraLi6Vw/rc1bYQW0d1XR3rRD9jrF65VtR6Qb1T+cTszQeogY13hSxttm7u7rWlGpE0NbHhF6LMeG0f0D8SlcuBOCTX8s4zs0yMCNcOdwZfJzLwqyS5msFzR3jMAXRY6M+4k3NBLryDmodw9PcyTe4n4hSbNtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=qf2O11I7; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20c6f492d2dso22801285ad.0
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 07:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731684722; x=1732289522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GWXqETStm7Md/ZZi4QCCd1GSXP4JC1lp6P3n7C6qnQo=;
        b=qf2O11I7ymYVCJ+NkAZ0PashgAyJ6uE17jb20O8NynYc7riEYo92P1HNOvH5CMOQ6c
         TIwRukKgSrNHGyeWeGCjueZZGZiQYjAhp3H43Adq3Jex8E/IRFSIbUYPnRUTcYXKZBto
         olRPNkh4C40kNNM5QIIS0kDAkBAojv6n+CMDfhGgDC7YSvdJlwdjfPALrGQsUtJ/2O87
         k682Jp5u+CpYoaf2JXOc4rqRdFsXDyLjiytVV2D/UZbio4/2q0cs0PNUCWqwf8HYbLYZ
         VbLRnGk6oTXvpJRUXcz01b0D673/oO8NTm2p90YxSVGYJspGbji9/j+zzcmy230rsyzF
         bU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684722; x=1732289522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GWXqETStm7Md/ZZi4QCCd1GSXP4JC1lp6P3n7C6qnQo=;
        b=E65FTrJq6nR+Mrkzq+Y29l19Ux1liyAHQJYwOB7ObPfm1lEaRPZEcc2rEtEvrTVbio
         WdM9cwn76Tqkuf3kloec7L8+uLONqCZzMI86ixBKeNl6CdQFvtLvPYx1R32p4keb8EfR
         tsEaMtc6TRpeMgHxQVySUy6+uTbfQyrD6mAWjz4XR6g5zdzzI/TIQaHicA2BIyeNUcPS
         zZ8Do2AelIa6EwlVZIhFKoulPP1RqJ13iLiITuZSFI+6wgVjyCc6/VogtiEzvyMR5pmX
         KdwH+v2JDdXmnhbN9oNXtVuPW1LnD5AE/r991eN/YO6IaYaM4zNTd7891ooy6ABgTSN9
         YWYw==
X-Forwarded-Encrypted: i=1; AJvYcCX2ujM0P20JABTu6qFGMgEGvuMxm7vAgPA8JAnWKbbehcIoF4DHEMBT3Xmk+ZYSmDsZHMxAZlWfCksPwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrBubmzR/avjNQEsvzCcF6FHcMPmlcxq9zZIbUovoXgBKkp9tZ
	wTIUUbhilGCxKFLCyrHNu5PcrgfNdtiPLBVholiFf5rGBPhQVYgGNLDqHvOpPXcZU2wTXAxe7YQ
	5
X-Google-Smtp-Source: AGHT+IEHUujjEReLNYNPy+KE0ogVxqRd47YtuHwtc3zNs/tYtNRt3+/0IcuvnNweNADhk1HvQaDdYw==
X-Received: by 2002:a05:6902:20c7:b0:e29:1627:d4d3 with SMTP id 3f1490d57ef6-e38263c0d7amr3021251276.41.1731684704575;
        Fri, 15 Nov 2024 07:31:44 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e381545ae18sm987344276.46.2024.11.15.07.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:31:44 -0800 (PST)
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
Subject: [PATCH v8 14/19] fanotify: disable readahead if we have pre-content watches
Date: Fri, 15 Nov 2024 10:30:27 -0500
Message-ID: <70a54e859f555e54bc7a47b32fe5aca92b085615.1731684329.git.josef@toxicpanda.com>
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

With page faults we can trigger readahead on the file, and then
subsequent faults can find these pages and insert them into the file
without emitting an fanotify event.  To avoid this case, disable
readahead if we have pre-content watches on the file.  This way we are
guaranteed to get an event for every range we attempt to access on a
pre-content watched file.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mm/filemap.c   | 12 ++++++++++++
 mm/readahead.c | 13 +++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 196779e8e396..68ea596f6905 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3151,6 +3151,14 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	unsigned long vm_flags = vmf->vma->vm_flags;
 	unsigned int mmap_miss;
 
+	/*
+	 * If we have pre-content watches we need to disable readahead to make
+	 * sure that we don't populate our mapping with 0 filled pages that we
+	 * never emitted an event for.
+	 */
+	if (fsnotify_file_has_pre_content_watches(file))
+		return fpin;
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	/* Use the readahead code, even if readahead is disabled */
 	if ((vm_flags & VM_HUGEPAGE) && HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER) {
@@ -3219,6 +3227,10 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 	struct file *fpin = NULL;
 	unsigned int mmap_miss;
 
+	/* See comment in do_sync_mmap_readahead. */
+	if (fsnotify_file_has_pre_content_watches(file))
+		return fpin;
+
 	/* If we don't want any read-ahead, don't bother */
 	if (vmf->vma->vm_flags & VM_RAND_READ || !ra->ra_pages)
 		return fpin;
diff --git a/mm/readahead.c b/mm/readahead.c
index 9a807727d809..b42792c20605 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -128,6 +128,7 @@
 #include <linux/blk-cgroup.h>
 #include <linux/fadvise.h>
 #include <linux/sched/mm.h>
+#include <linux/fsnotify.h>
 
 #include "internal.h"
 
@@ -544,6 +545,14 @@ void page_cache_sync_ra(struct readahead_control *ractl,
 	unsigned long max_pages, contig_count;
 	pgoff_t prev_index, miss;
 
+	/*
+	 * If we have pre-content watches we need to disable readahead to make
+	 * sure that we don't find 0 filled pages in cache that we never emitted
+	 * events for.
+	 */
+	if (fsnotify_file_has_pre_content_watches(ractl->file))
+		return;
+
 	/*
 	 * Even if readahead is disabled, issue this request as readahead
 	 * as we'll need it to satisfy the requested range. The forced
@@ -622,6 +631,10 @@ void page_cache_async_ra(struct readahead_control *ractl,
 	if (!ra->ra_pages)
 		return;
 
+	/* See the comment in page_cache_sync_ra. */
+	if (fsnotify_file_has_pre_content_watches(ractl->file))
+		return;
+
 	/*
 	 * Same bit is used for PG_readahead and PG_reclaim.
 	 */
-- 
2.43.0


