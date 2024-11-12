Return-Path: <linux-btrfs+bounces-9546-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A849C5FC3
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 19:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE9B6BE1980
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 18:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEF3219E4F;
	Tue, 12 Nov 2024 17:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="1Uqoyvlc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778AF219C9E
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731434213; cv=none; b=QJvLMRkllEsFv6yjaOfbbUKtRXkG9AvbYATrcKS/pCByxhpCRXXykJGDHkijneEyvh+9ImxbHa1G5Co6UxBAsmQSMy0uRfp+UzSaMdUFsDBv+xS4HT5QG8U/Ml4YL3FlIhrTA6p1O0rcts9axvxMjXqxXH7fCzOPbpazDPZdWC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731434213; c=relaxed/simple;
	bh=t7nvLm79BnbL0G55pVnNTkmA0duqgzyrwuSpS5La8ko=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJELHoSZ/jryoy4mYChCNKDdVqpiggOq/6nQtxMldaQL2FaXoO7wrZLd9wI3FdDDlYd8roytxTPv4Q/wlCBNyZLPS4XXtIVVL/maA7hMqfoYHxS3PTxfJ5CgdwyA9Erc5ssQ5thip5Zs4yVPp0dZAgdMUJrZlu9Jx4F/7mCPTtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=1Uqoyvlc; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e291cbbf05bso5826771276.2
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 09:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731434210; x=1732039010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QtBO4W7ojcvMiQeJDBijogkryb22CThmLCgaVfO4L7E=;
        b=1UqoyvlcmSbNjfa83E/BLYP3/wBFxyI7s6orl5X38TpFHJ/IwLnJrrnChZW1qtnioU
         NWv9+ekSBoMewwqUgaWni6y3f0YMAozpymF64o4ydIfe3H4uVzlYGsz+6cGq+MSaplh4
         jkOH1KgCivF3DPiOF7ZFtcAR+UPv7MgmEk06GiRnfdfcH7V3lJXlqkchkPjXcTvlcfex
         dbekYoGl3TPy4lJgStAPCVC9FX52TAq+h4QvCwzHGxchJ3ZMtqFfTP2cF2mTVbp1h+tT
         kqoWojj+bGglyaxTMJFhd547qjMBwun+Zq2RuudlsAnfKgzXH3i55WZHW6bKb2mfvY9E
         ZQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731434210; x=1732039010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtBO4W7ojcvMiQeJDBijogkryb22CThmLCgaVfO4L7E=;
        b=UvgIFP30AydU3dpXpOlKwogDEtEXsVuwSWRmc9hYeiJpCUBXXc1kSHRDZP7DtWmbyx
         jBPpcGtegNnyRT1+1IVoPja+D6R5WYW1eZBF1LiGyilQ6UrV8lIidXcnYYkAobgEuYbE
         DpqldvpllSl1FWs2K4w8m1GyDePjfMGTIJ7nf6A+1rXIdVuP6ewdOozMnEVci+bfjU3v
         mNFATB6fTl1ucnxZLiLIbvth4Kqvvv0a99FfN8VdUiTQLc2WT8Cv7Dc/X73AcZqdBlcP
         RivQZhqJMQivarGToPPI8HuRbjiWKNrkstlk7n7cLTe4BDgqeyOPHUgjaWbjq2FkQFi2
         +Wqg==
X-Forwarded-Encrypted: i=1; AJvYcCXfSCVK6U6dCjgw2lHVT+TlDfoW+c91VJvH0WriAwqJH97BtjXjvX6TSPQ8ReXLlQG51+KuFebRSbsHZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YySpAh2Pr7wwq/mdmLZ9hjOUL3ivDXzxH4y29QYVnxzUOLolkjD
	1Dccaej9w9ToA51TD/YRATuj97dPkpvlJVbNZ652++f+oYpCOEKSIOzh/jDxO+Y=
X-Google-Smtp-Source: AGHT+IEKuDZzW/fvP8psHkg5hrvM/70eBZxELM8jsrhGXCGLQnsHGSpuUuvJ02++phM7o+afQ4JSUQ==
X-Received: by 2002:a05:6902:20c4:b0:e33:25e2:4b1e with SMTP id 3f1490d57ef6-e337f86d626mr14917803276.19.1731434210511;
        Tue, 12 Nov 2024 09:56:50 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e336f1ba835sm2880031276.47.2024.11.12.09.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:56:49 -0800 (PST)
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
Subject: [PATCH v7 14/18] mm: don't allow huge faults for files with pre content watches
Date: Tue, 12 Nov 2024 12:55:29 -0500
Message-ID: <532dfc336dc1b09e5604dee4f08b70577089b76a.1731433903.git.josef@toxicpanda.com>
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

There's nothing stopping us from supporting this, we could simply pass
the order into the helper and emit the proper length.  However currently
there's no tests to validate this works properly, so disable it until
there's a desire to support this along with the appropriate tests.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mm/memory.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index bdf77a3ec47b..dc16a0b171e3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -78,6 +78,7 @@
 #include <linux/ptrace.h>
 #include <linux/vmalloc.h>
 #include <linux/sched/sysctl.h>
+#include <linux/fsnotify.h>
 
 #include <trace/events/kmem.h>
 
@@ -5637,8 +5638,17 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
+	struct file *file = vma->vm_file;
 	if (vma_is_anonymous(vma))
 		return do_huge_pmd_anonymous_page(vmf);
+	/*
+	 * Currently we just emit PAGE_SIZE for our fault events, so don't allow
+	 * a huge fault if we have a pre content watch on this file.  This would
+	 * be trivial to support, but there would need to be tests to ensure
+	 * this works properly and those don't exist currently.
+	 */
+	if (file && fsnotify_file_has_pre_content_watches(file))
+		return VM_FAULT_FALLBACK;
 	if (vma->vm_ops->huge_fault)
 		return vma->vm_ops->huge_fault(vmf, PMD_ORDER);
 	return VM_FAULT_FALLBACK;
@@ -5648,6 +5658,7 @@ static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
 static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
+	struct file *file = vma->vm_file;
 	const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
 	vm_fault_t ret;
 
@@ -5662,6 +5673,9 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
 	}
 
 	if (vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) {
+		/* See comment in create_huge_pmd. */
+		if (file && fsnotify_file_has_pre_content_watches(file))
+			goto split;
 		if (vma->vm_ops->huge_fault) {
 			ret = vma->vm_ops->huge_fault(vmf, PMD_ORDER);
 			if (!(ret & VM_FAULT_FALLBACK))
@@ -5681,9 +5695,13 @@ static vm_fault_t create_huge_pud(struct vm_fault *vmf)
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) &&			\
 	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
 	struct vm_area_struct *vma = vmf->vma;
+	struct file *file = vma->vm_file;
 	/* No support for anonymous transparent PUD pages yet */
 	if (vma_is_anonymous(vma))
 		return VM_FAULT_FALLBACK;
+	/* See comment in create_huge_pmd. */
+	if (file && fsnotify_file_has_pre_content_watches(file))
+		return VM_FAULT_FALLBACK;
 	if (vma->vm_ops->huge_fault)
 		return vma->vm_ops->huge_fault(vmf, PUD_ORDER);
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
@@ -5695,12 +5713,16 @@ static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) &&			\
 	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
 	struct vm_area_struct *vma = vmf->vma;
+	struct file *file = vma->vm_file;
 	vm_fault_t ret;
 
 	/* No support for anonymous transparent PUD pages yet */
 	if (vma_is_anonymous(vma))
 		goto split;
 	if (vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) {
+		/* See comment in create_huge_pmd. */
+		if (file && fsnotify_file_has_pre_content_watches(file))
+			goto split;
 		if (vma->vm_ops->huge_fault) {
 			ret = vma->vm_ops->huge_fault(vmf, PUD_ORDER);
 			if (!(ret & VM_FAULT_FALLBACK))
-- 
2.43.0


