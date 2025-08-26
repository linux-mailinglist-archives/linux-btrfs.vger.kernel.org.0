Return-Path: <linux-btrfs+bounces-16413-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2DEB36EE9
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 17:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 270058E7DFB
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 15:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F1937288D;
	Tue, 26 Aug 2025 15:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="c5I2z7r9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315DB371E99
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 15:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222918; cv=none; b=ZNkcsauVlgB+V1ro/cUJC7N00PMcu+OjrYrEiqsWQ5XIl5UsNCVC2R4o7JWAJIloKTYkCf0AZSvSXaYMBFESCDq3y1kP1kwDjDfmB8yiRLWUjqqjE4Y8EfjrDf74gZR4Q+BxayLHx2dgdMa8n0ijzlU0Fm5H2q9FU/GpAwwZSPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222918; c=relaxed/simple;
	bh=tkUhaR2Wdt5kCnisT2HbbJH/eYzoHj1oGz3hiKRRSd0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lsU52gK+Oi9nQM0UUEpG+py2Lckw0X0YZPiXi4PvY5BAYJ2xl6/FLZiayQ9a7eI17pspkRjAINQ6WcZcIT4WTLFddGhITdcpmhHhi7hgP4MZDxVQp/ziSBQtPdLvf3+K3/nn17BWfw+tC6bBrPGhC/TqJmlt+nXszdkbjzHgMLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=c5I2z7r9; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d603b62adso50216637b3.1
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 08:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222916; x=1756827716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=afAll3Ztw+chy5iK2sURo8W26thUm5pr0Qhfoj2rvnQ=;
        b=c5I2z7r9VVzoxl68ES1Z25gV+d6w6eJYv/6Bxlte/oj+84QvjtChOCwiegislYCmfg
         XFUBdiMCkmH3DimoO3xk+iXCCb/LektHh3tcGXDDRWBIL90wQjdtXCZ5uE/cs0KWovWF
         /eNoBYpC+RCgDGJS7HqroABXV8u6Hj3uQtFDPUdszi8bmi0c+UWIY918xSW1pjOTwKw4
         KJrsLIgxJ+FOcFyyrHaGWcFeEd8/FQ+AHBsDoI/zuInW9+lwZGnESZc9wMLr0NzhrIQC
         33lUYMb++s0q1v8cBpgCZ0fMEfZaZsQt+Wf2K5ERzoSXXY1peHTavVx/0Jr57qARt/X2
         C+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222916; x=1756827716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afAll3Ztw+chy5iK2sURo8W26thUm5pr0Qhfoj2rvnQ=;
        b=LHDuv4CqVvkvthkshQm2a6JDLWxT025wTa4WiB04bn+W8PRSlvMHi1edVA0MtQd3J6
         XVHUCym4IKFE+l/rf8dahYKqWVIM0V3DCM37jOgfBqf4tyMc59/Kst9eYereBVxlAGhR
         63AdkY/3cu2hjgvBlU6cpKVFMq0ky0vpDeM/ccIg/yJjyHeHLVu7MnAQ6arS9bq5QKPS
         aWkbq6Mv87ORAsY8CipLW+MrExPqHAnSKYK9/9XRRwmNYrczBaRm3VREnsmK00+GWrY3
         NmAPKo6Oksy0FlkvY0u8MB8iThr6pXaGhMC2pp5YyVXukQdJqnUrS/jT/Fh/iheYdU6/
         t03A==
X-Forwarded-Encrypted: i=1; AJvYcCUzcrl86z+twEaHNjKbiZvegGBRdZbvTayxJytTRDf62tCFzwL0aCnWuToyhxTopnMC56TJdjvnv1CaJA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8XMevNPf2l0D7wsy+9M9c6gkyAa9k9wnlsa1gG4Fxe+Innldz
	pZVwcLGAMfsOHsuj47aEvERTrLCRw6+EmUcys7rOjO/b6n09hyw2mtwiQuQCpTBK4aw=
X-Gm-Gg: ASbGncu4fd1pGyHHWMOuFl+Ff1DuDd3z16WRqbv8qMKom2z8epogRNOEjLPe0b8dZdK
	53DyuMibG0kLJ/l4K+1sZ/rmxz9oiahdPPHqH5MHoeSn8UnunB4U+SWy77UxxDaLnwtshRw17NI
	x6FAbElWQt1Bdw91bGUdWA3kaq9VcMQACOkI9NekmLYnE/lJsmHjtDHH0he8w0as1f639NAdSve
	eauZVN9EQTiL/oL5Idv5yEa7NL2mX2EZJAcZ/s+QsOXV5BTeoA9xbD4u+WnGyM1zaVyV15BfwjE
	x/psJUZdcxEOivBvdUrUNrRSjA4BJdfKA3WU7ya1hmBHjPhLDhpJRJesdcFrMmylD0fLe5oc0h1
	yVh4FHlFWhvU2yV/Q2hyef4GHAECxW4/3gGPYeof391HZP8n3TewLRpP7aaY=
X-Google-Smtp-Source: AGHT+IGcJ0F+Yu8LKKYT4wPl7uuybVV1LKhPL6NkeZN/ZOA11iSP+ko8POCF1twTXQouIMsAmh++wg==
X-Received: by 2002:a05:690c:3348:b0:721:3bd0:d5ba with SMTP id 00721157ae682-7213bd0d69dmr13183867b3.41.1756222916060;
        Tue, 26 Aug 2025 08:41:56 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18e31acsm24874707b3.67.2025.08.26.08.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:55 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 46/54] ext4: remove reference to I_FREEING in orphan.c
Date: Tue, 26 Aug 2025 11:39:46 -0400
Message-ID: <5e023690acf2ba9a94f12a5d703bb6c66ec99723.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can use the i_count refcount to see if this inode is being freed.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/ext4/orphan.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
index 524d4658fa40..9ef693b9ad06 100644
--- a/fs/ext4/orphan.c
+++ b/fs/ext4/orphan.c
@@ -107,7 +107,8 @@ int ext4_orphan_add(handle_t *handle, struct inode *inode)
 	if (!sbi->s_journal || is_bad_inode(inode))
 		return 0;
 
-	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
+	WARN_ON_ONCE(!(inode->i_state & I_NEW) &&
+		     icount_read(inode) > 0 &&
 		     !inode_is_locked(inode));
 	/*
 	 * Inode orphaned in orphan file or in orphan list?
@@ -236,7 +237,8 @@ int ext4_orphan_del(handle_t *handle, struct inode *inode)
 	if (!sbi->s_journal && !(sbi->s_mount_state & EXT4_ORPHAN_FS))
 		return 0;
 
-	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
+	WARN_ON_ONCE(!(inode->i_state & I_NEW) &&
+		     icount_read(inode) > 0 &&
 		     !inode_is_locked(inode));
 	if (ext4_test_inode_state(inode, EXT4_STATE_ORPHAN_FILE))
 		return ext4_orphan_file_del(handle, inode);
-- 
2.49.0


