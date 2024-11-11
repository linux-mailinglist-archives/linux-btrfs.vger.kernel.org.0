Return-Path: <linux-btrfs+bounces-9449-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 297619C4702
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 21:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0A6AB2A0E0
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 20:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8009F1C8FBD;
	Mon, 11 Nov 2024 20:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="SRh+pPmm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EAC1C3318
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 20:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731356375; cv=none; b=Cuwqkt6CKxUeAXe2dmGl067YmSbp1sSCxXkP2HP2b2fX4glh3nriH8dfugULDln2QCa+bPcX1I9rIfI8zekYo78cXhfQX/KTl30y6oIrtoi7qKJP4ZyvXhbhAIBj3I0DgBs8GXTzRyrq6i4LUfJerGCBOkuktGBWWOIiYAxBb/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731356375; c=relaxed/simple;
	bh=t7nvLm79BnbL0G55pVnNTkmA0duqgzyrwuSpS5La8ko=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KEuqgroeJ7g7WO92WUVgm21bHMyzqfBedicdRXR0y9Y2zI4khrNaOs4xFaALJgUXHJEXd1ADG38R3CqVO1wH1enQOTjr+nmEvlCgZip3zu7C3Ij025LiFFnCZoQa2LrIvh4MlTgkchmKrpDVAMGmjsuhcP8vHrJdm6bFZb4C3bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=SRh+pPmm; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b175e059bdso335507185a.0
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 12:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731356373; x=1731961173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QtBO4W7ojcvMiQeJDBijogkryb22CThmLCgaVfO4L7E=;
        b=SRh+pPmm8ixAsMoQrAPKciMNt87tnAODzM/E8MMC7uO8gmdqjFrKORPIeSF9D9T5dv
         d0XghpJQz/zSJki0hO4V+jpEmTp7VbU4a1MWuVVMn6FaqomXXAzHNDLGxCFVzT8dlqh2
         5yNau6tdDFGasfo16eMpgLL0MtymMfGjYZeClrZ1iHcEoD1Eb2J5EGeuwYDfBgTFIsGc
         C6nx4gj3d6LHiYQPQxEJ2EGsCQGrb/dwd/tYH0Ox7Leatukwrbgw70zoxmtI8rY8Lf9+
         vfko1iNdDGHfoxphYbjFiQ5Yx+xkE/HuCnaCfD6Yewlfa6i/tY4jqE8X9jdb0CwE9MxS
         LNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731356373; x=1731961173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtBO4W7ojcvMiQeJDBijogkryb22CThmLCgaVfO4L7E=;
        b=EnfT0Yb5X/xvuROVCe/jg0eFNP8fkrm+2/vV7/x3ohyOi56yWf006z0Pj+iHoytfQi
         CJPdMQ2bF1bseej+jWRAajEdjLN2XGmFV7WmVmkS0cNVPTr2Vbv8SJE61V9PQ2A6YUXT
         ho+dyR1N3wdLzbXKWEtBV61TvzMouANH7hHLyGaVXQFdVth0hGiltAVTgVhVL8YA4+kf
         Wb0LXpeGVikhmCvmTuaB0BwNPfvIvzk8GYQjtBc1VCgZq/pKvMv4+VubIPzxjblm5jCP
         7DkHerbua25RUNS9Fg7EbA5T//TSwXFw14HrM2FlfN7h/SfCw2tiMCV6P5UnaXVAXSmS
         IOqw==
X-Forwarded-Encrypted: i=1; AJvYcCU5Nxu815dukMDIUNMXta2e9u1dgfjGHYss+iaKjmSqHw8NOtT/BlVdNS0wLpd0oSpBCZaCz/K+eahxDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTLV1LZVxsxyIEAVN+GffGL6uSfP2Zhbz5ArqlSy3eXfvJ/KE4
	flEsDtLZJrtw4QzN93KWeHeZxJKAoAiW1ssgC/+wkcRWZl1NFwisZevmtU9cHT4=
X-Google-Smtp-Source: AGHT+IEVZ5vmyN/LZmrG/1kTbJ7T1FWoFz0xAw/6r2wr8/vwFJmdfm3sS2snhEtpIWxC1ONY/ffBRQ==
X-Received: by 2002:a05:620a:178b:b0:7b1:447f:d6f0 with SMTP id af79cd13be357-7b331eb87dbmr1968482385a.23.1731356371650;
        Mon, 11 Nov 2024 12:19:31 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32acea072sm526763585a.114.2024.11.11.12.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:19:30 -0800 (PST)
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
Subject: [PATCH v6 13/17] mm: don't allow huge faults for files with pre content watches
Date: Mon, 11 Nov 2024 15:18:02 -0500
Message-ID: <5c64164cd1f16431edd1d468cb3204d29d86bbf4.1731355931.git.josef@toxicpanda.com>
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


