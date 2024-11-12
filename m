Return-Path: <linux-btrfs+bounces-9548-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 272A49C5FC1
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 19:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3AFD1F25651
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 18:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497F1219E39;
	Tue, 12 Nov 2024 17:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="RTYNfLGe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E0F219E5A
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 17:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731434216; cv=none; b=uM5YEa/7Yh/zaaZ1KAU2q1r6wzaavKqGyI5RF1mWtbXohdUbZ1XaBFeJH3Ouxn52TRLFWMVFuKFE35K50qt0lQ+2ITsxCtCsx1snYz2RsyJNhaR71818itIoR4+oYB6OSNkuJOJNtg0ljZIgZg6Cu+4hC6e+VsQ5k71fJ2vLb0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731434216; c=relaxed/simple;
	bh=2N0bizMEg0czxuSX0Hl7S5FVpQVRVn9Mf1MRV8yCr7o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3O7gaVZUPpqvr1O5IKWvVl5RgMLv01/cviUFWLD9fSUB7lt1NYJERJp/Xw9W6FPzmhd71y0HCdxA90ho/TDbMQFVEnRFrWkk9luKcGT3FZRv9esGLhIoTWmHk7KdJAeRY9es1L2lCC4DNg3ySKV2aQ2Jb8ESNWu0Rfo7Ag1LPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=RTYNfLGe; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e30d1d97d20so5291610276.2
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 09:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731434214; x=1732039014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3nbIBZPU5mMiQBH7fH9PUjd6pvpSRIo6Q0oL6vGrX38=;
        b=RTYNfLGeQaoy0PUOIWxtYtFnHVkNAibJVBgae86g9BcoEobO0cKR3Dydxi9PJIha/G
         Thqv41YoK6M44s0kX/FHVhFC7+Gjqd/RVpJ7660Mxa6z/QASgm4QjDkcTIZfYq7+u7ub
         9McV9Ysht7dCZHYkz1ysnrijTWRYt1OgiFkjBxPrxHGpphL0fY6HT1FKVeek5hsmIVuS
         U4Dkrh3dC5cSlpufhZbHE5A+5xLut0KZ7xU2Lh5a+dTAkoDKNhrM02HM6JzDkT0CNlDq
         oSB2X6fi9G3LuXSimLUj0o+n1kwk2ODZ2rqfOak4SczlmthPuTY8BSCrQZa2/j9PtI+I
         NOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731434214; x=1732039014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3nbIBZPU5mMiQBH7fH9PUjd6pvpSRIo6Q0oL6vGrX38=;
        b=xPDEmXdfrimsXbDnAnI7K4/BTYENTrfxECNwMCIFqPFVGt3cYM5RZl465oONEbKJ2J
         LH+7P0L5syIjpg/ocz7NVCofl26X3Az43lB4N2feRYff9m6M3kSHqB7etAVVCMvNI8lR
         wKMIXArfmiF6W1j3Nq2wM9EERCA9QU0pnrxk73/Uml+0tYWtaktR5TkJgKcm0TPVIkum
         xB3k2QAVEgBJOP4pE3pefP0qSbnWyx/2p1irj8M7sS9aA4Rb7i+aZapsUh+5Jk8kfMBd
         Vf/o0WQlLKh0dSvCnsPbFp0WXIAE8MkgZKVyjBM2LqjKQpk0m8efWJmEvCflSvamAR9g
         1Wxg==
X-Forwarded-Encrypted: i=1; AJvYcCUo2T1FNYfT39E6v0cErrAOtgEZjmDR8Jh5xrC5jFz2lpQYWBwMnWOfYm1C2mjbT2/Ju+jlddEs+4hw+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMrQVVA3VRrMCFB4mRkAxdTy1moFepnvKdu5NWyw8SkhAY5649
	1gb6P8L8C/hvRcoL0pAJDA3tPEFWVi/RoWy/8BGMBkd3AbHZenfR97J2YUAggRk=
X-Google-Smtp-Source: AGHT+IFiuIuaM6zhnPYYC70N0ed/AHQHsVCWIUgMJBIkKyN4ZxuOm530ZzxRBomBAB77BqDgpRvfSQ==
X-Received: by 2002:a05:6902:150b:b0:e1d:c3ea:da14 with SMTP id 3f1490d57ef6-e337f8f0c7fmr17671301276.32.1731434213851;
        Tue, 12 Nov 2024 09:56:53 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e336ee15907sm2754453276.4.2024.11.12.09.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:56:53 -0800 (PST)
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
Subject: [PATCH v7 16/18] xfs: add pre-content fsnotify hook for write faults
Date: Tue, 12 Nov 2024 12:55:31 -0500
Message-ID: <efd617db128969415cadb1635217c58d6eca1bd7.1731433903.git.josef@toxicpanda.com>
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


