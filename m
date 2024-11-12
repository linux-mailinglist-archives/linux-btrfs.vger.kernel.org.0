Return-Path: <linux-btrfs+bounces-9545-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 285AF9C5FB7
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 19:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA4A91F24F5E
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 18:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3072194BA;
	Tue, 12 Nov 2024 17:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="X7M9bpLw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA94D2194BE
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731434212; cv=none; b=beYYSit63PGBzG6B5d9K3EDlrzpf7kENMirujNINHOfzwLb9VpUocTPqtLvKBE61qb+IgibZMt4+NUoq2AQ7ngGI1D+trVL5FgVwaI6vDa+euTFqW6OPNL19McbvZSZB0ViXP8cc6G3YePr/VwQlWHOU47uRVjLnt/kMKgbyyPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731434212; c=relaxed/simple;
	bh=nEHBpFohXdPFfKZTP2r5oPAoCPK79vU6B8kkFKUWAqs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P97of95jWR6S4vDUisCM6l3cvrWKW/Xhn0rqClPWU5hBOifaNMzw3sd1VGySJJ1COR28ykr9GkOBmjTjBphT9EjF8Mnrf9bUAuAziSbJhc/dWaB875L1C/ARsMpkXeUJcyyeNCCb73ipjMSvaF+6AluocRz5qSYc4cloSxS/nio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=X7M9bpLw; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e330b7752cso49004087b3.1
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 09:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731434209; x=1732039009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DKrH1r2LzuvlRLkIW99g50GCI+7PqnnQMlTA3Xoxniw=;
        b=X7M9bpLwKlcHfwdwZ9XMGaLTxSfeBZAH2ImNoUK8oJ230t/fVhMM6yJlzjG+DMyOfa
         77xXDbM82n52tE/mqdwX965sJ1zgJs+MKWsRHnGlWPeEOksFRkA9barSVvr9x4QLtAwh
         ur6gOFEsK2Zyiyn4Ef9KWlnHhSOhW2MZijD2QGPk6bFIiGibR9HZ1HKRz4OLBP8QTrUv
         5Qa+OVWc3RJUKKMTirKiXgNfNFcB2Ol5PXChLH1AHGSSB4pdKlvR8Z94392x7x2Kyx9q
         ZdZSIzW2NGamKBoj6BjLzFtp2+EoGDv8Zne/9X9RGt++pIjuVJH/f1GNUma5yDzc3/iU
         oVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731434209; x=1732039009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DKrH1r2LzuvlRLkIW99g50GCI+7PqnnQMlTA3Xoxniw=;
        b=vYtnLqxWK+LpsvmInVcb5L+ZjTlQC+ipG8L6S7hzeq15YeAvzHkR6QeHfxyLePNgL2
         Ip20e5JDLtKR1OpHqn24p85j5CM+weJvqKLGG6lc/l7y8na0pjSL2j0fEIe9k/lDBAr3
         Mc90Eeve8aj/ppSiYaqEt4YnEUWx+6xsHAW8eGh3gVnqwblbaKvr6MqPT4GeCUgoCjJs
         GJtuQocUHNKmlTian5cfB2S7VpHXfv/2CjtdHOiypJaKdCLq8uIW6Y8k8nDPXVueu0Pc
         IxHGpuv7ofMbr5EFX0jQhelSWQlMU+AAvhyTSOeFdjqaRZk9e1G6Wwz4UJftse9EPbCt
         HjSw==
X-Forwarded-Encrypted: i=1; AJvYcCXaYtmgB3jv9nS+nQuX/u8cuUXjUIeh9pYKLrt31YzzTgZ6XUijKJluwSoGmaVA5y7As8sB2TxlheuhOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMctEZwKpQHJf8B7WpmNR5Ueu0S21K3qIZ/IGH076ubAKdi76N
	ZYPZLmI11auLZYNUESiQxMsVUhCxcOLhzu7JtQyn8+jkZu0bUirZOZyCss/KXGs=
X-Google-Smtp-Source: AGHT+IFJc2RNjc1G/OBWSTi5fyS4IghkV6OUbtpYdZWmaUR5D0i4/YYlt6JaXitbsIbc6IfGCQnj9g==
X-Received: by 2002:a05:690c:3510:b0:6e3:c92c:1d57 with SMTP id 00721157ae682-6eadc0a271emr140258467b3.2.1731434208685;
        Tue, 12 Nov 2024 09:56:48 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eaceb65a75sm26238187b3.97.2024.11.12.09.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:56:48 -0800 (PST)
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
Subject: [PATCH v7 13/18] fanotify: disable readahead if we have pre-content watches
Date: Tue, 12 Nov 2024 12:55:28 -0500
Message-ID: <23edd657a315f2e5ed648f8dba6d34898b4af85b.1731433903.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731433903.git.josef@toxicpanda.com>
References: <cover.1731433903.git.josef@toxicpanda.com>
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
index 9a807727d809..277c2061fc82 100644
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
+	if (ractl->file && fsnotify_file_has_pre_content_watches(ractl->file))
+		return;
+
 	/*
 	 * Even if readahead is disabled, issue this request as readahead
 	 * as we'll need it to satisfy the requested range. The forced
@@ -622,6 +631,10 @@ void page_cache_async_ra(struct readahead_control *ractl,
 	if (!ra->ra_pages)
 		return;
 
+	/* See the comment in page_cache_sync_ra. */
+	if (ractl->file && fsnotify_file_has_pre_content_watches(ractl->file))
+		return;
+
 	/*
 	 * Same bit is used for PG_readahead and PG_reclaim.
 	 */
-- 
2.43.0


