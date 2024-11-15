Return-Path: <linux-btrfs+bounces-9721-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4929CF033
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 16:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F51289F21
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 15:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3D51D5AD9;
	Fri, 15 Nov 2024 15:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="oBe0EtWQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49081F12E8
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 15:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684715; cv=none; b=VTvg2vSqlo2qirVRwKy46eNbnzckZJbhsqJAUfEQ2nXbUB13vvopeXiZlvhbquRXvVH6TfpJ8js1niagLUyzUMKv0flXCbAfOBc1qk+YE1Gny0o/aRKocF2HNEtwZ+7S99cKG/L8Icfoo59LCZ9+zZBwafxcHe+PAqHV3Fz7AKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684715; c=relaxed/simple;
	bh=PPbePcs2WGvhpmWcX89Tq9aMCCGa8+t1geWVk1JQ/rg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TbM9RP8vwHTHFuua75Yco/ptY9POmi84lGPlN1jbCqP1LXSAdvYEDe1I6UrXnr89rxR9X1yrqs3WIV645IG4Sh5YsHF2Emt22346QTXJXE8CQYGQ7ZmB47LMWz0T5bB/e5BNw5YanfWi+zVrT9uWdL9Qt5/e/pm9E+0LzW9ARVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=oBe0EtWQ; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5ee354637b4so1105259eaf.3
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 07:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731684713; x=1732289513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UmMh2R9TaZZeTO+3Pa04+NECyzvSza2nfFK0oCoLtcs=;
        b=oBe0EtWQuwl88cCU5pTvTDkB/94N5XzWzaD3zlA6XpaCdsxhM9FEYAhy7NFj6hJ/5e
         fPoANvxD874ilkta+gRbLOycSq8Rdaoivm4Hy50CyqpEtUUESWkaxNykV8O8dToXo8d0
         YDe8QLamWU2B7rEIrcz+HMJwOKXUBmdWCXEk5Gr/qhWRRGUjKjI2yaE7TfzhVSR/w8tN
         Nij/ncSEtuB0ENvFeh1P7Y3CT23ad9PRgF2yoiy8KUUOukcSCpU5/CN1CQDXWjJJnaJf
         iOxKK3OyEOObXKi1CRQotq77wT9aYZfj/Z6zi5UZxrK9AmCH21ivYJknNi7HPbd4NdsA
         ycZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684713; x=1732289513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmMh2R9TaZZeTO+3Pa04+NECyzvSza2nfFK0oCoLtcs=;
        b=VTPrKs5rgvjFCVP5i2XWe6sgPyYmb17kfZNzJuNM22S3gyQ0rZjFHp7jSuVQxAxCLK
         nhUiI8nTf/d93s673xfgrVhDcUXFzvaqYk0B/iMlYZ9gnoZDl1Cbf5uAO2ibqmG9dYrY
         raxjja86WGPLcsUIeitb9kz8qD72Y+QQ9lJ+SKTTgNqnOMliKBw9YQkzYjIgQgCYeyLY
         OmSsTsCKCRy62gvPfat9A35UMr4tsX5+kxMYPyVtvJGiaGK3VIAkcc2cXZK4O6xG8FBN
         8zQVJc+3mTo927cNC4t6tTptBgowLiGmkTYqCgM73zirB30q2sDhUxazx7uHkGXOEsrT
         XyGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXM9v/RxCyHKvS6o5poD0pT+yCdDGzjulP/XpsKrc2e+ynd0T7/yrVQjaw7YvfB8skoLHH/MwR+srRqCw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2cdklzSFDY9bYxlP/0xaRPGva4kblICquvjcellgcJclx/n3a
	HsHANe2wjFxDZNipSg9THY5cG71wFXx9QS6cPV+mbg5MgwdhWA8fl2u7e6/jtyA=
X-Google-Smtp-Source: AGHT+IHtKZ3WiG2a6Yh90R7O7Da3Go40IEKMQxser6w6wpGF8sO84iqOBIyuVxo5A9VSaCx3/txhnw==
X-Received: by 2002:a05:6830:d8c:b0:718:9df:997f with SMTP id 46e09a7af769-71a779b2c25mr3850260a34.14.1731684712917;
        Fri, 15 Nov 2024 07:31:52 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee4400c6e6sm7807317b3.9.2024.11.15.07.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:31:52 -0800 (PST)
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
Subject: [PATCH v8 15/19] mm: don't allow huge faults for files with pre content watches
Date: Fri, 15 Nov 2024 10:30:28 -0500
Message-ID: <9035b82cff08a3801cef3d06bbf2778b2e5a4dba.1731684329.git.josef@toxicpanda.com>
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
index bdf77a3ec47b..843ad75a4148 100644
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
+	if (fsnotify_file_has_pre_content_watches(file))
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
+		if (fsnotify_file_has_pre_content_watches(file))
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
+	if (fsnotify_file_has_pre_content_watches(file))
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
+		if (fsnotify_file_has_pre_content_watches(file))
+			goto split;
 		if (vma->vm_ops->huge_fault) {
 			ret = vma->vm_ops->huge_fault(vmf, PUD_ORDER);
 			if (!(ret & VM_FAULT_FALLBACK))
-- 
2.43.0


