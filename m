Return-Path: <linux-btrfs+bounces-5282-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3097B8CE8A7
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2024 18:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 541E01C20CA6
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2024 16:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD5F12F37F;
	Fri, 24 May 2024 16:29:23 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10AE12E1F9;
	Fri, 24 May 2024 16:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716568162; cv=none; b=U8MxltVzfxmlKJX1cxUEfxTyGNRvaE0SoYtJZk9wFqB8w+h/A0Go6/cpqHJ7hNHWc40xsrXl6DcO2XS5Y+gEV8gHxr+gUUWhFCkihGeBB40Iq0E9/oCLkvdZtNCNX2gtclBPLW4txnk0gEZjPJKpmKZDkGk6+LLhzWsFXQL4A9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716568162; c=relaxed/simple;
	bh=Mk0vm2wVweC2c4LVvfTLIog2loSut5Ggn308jLaRuyg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OV/C3Ay9YMRGbPpym1tzZFB1/uvq+9JWtIc6dyttUMXyZNPnXJKIr+0F7LBX/nsJiaVKTuW3UgCX59b2BhjtgLmd2V86LHwp4OI50CYv4ONlW9Atb/YiDPqgMYjulPS1LLF++czfuLbEySv4h/deiF5nKY+7irRvqAP/VEjmCoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e6f51f9de4so105412171fa.3;
        Fri, 24 May 2024 09:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716568159; x=1717172959;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWaH5m1taPdNRPa1DydupB1kL3ngtpXAOuzfbitKQaM=;
        b=Agof2uAfuJGt+K76LY2l9smWLqHlPzumhRgMpjtZLCtTSEuBkQ17FHPrM6AjhWoqNP
         UptjMSZ/GJFC9iYeEQO8/hcWF67iYP0EgRYVRh2/duWaSS6BuEJte9YgD27PGjjC59mD
         4z28CgReNR7ZEL27NYZHhZH7mAlsOUVuciTDQDe1HPaYuaEIaCl3b9F2a8uZzjju1W8K
         nbBEjmTBTD6ttHhikmbeuTZZE5jo9s4R/QYU1HJWNe3aJMiN12LY4xVbwXAp9HhXW3wr
         zjP5dBXMJK9MiEVAzd/IOXFTv4twTe9RPVkXLguu3G4eNIKBMjw6o1Mdpe72fKTTL2VQ
         E0EA==
X-Forwarded-Encrypted: i=1; AJvYcCVh/MV1K4uXt5mTEAee/UD3JQX60NdNRMEKr5DzJFoHjlEIUn72B95EhH7y4FvXCD63++662gAZkQ55eoo0Up9aN8R+tfN3i05mgXp9C5lcO8q11UUtv915JHzrmJtkiib0Bp8URPQJvWE=
X-Gm-Message-State: AOJu0Yz2aQXE3C14utcrY37Bb24oMSlWqrPNeddVhR1JBiCOe8Rky6u7
	j8VPqs0unKXzIIaEalnIaYBPncPNky8Jg83ifskRgAaypV1PXQTA
X-Google-Smtp-Source: AGHT+IFkgQtfaIlsqVpLE7g73XFcz1lpiXB76f2bRrZdvEXPLRXm6aeWUqL5spkEvEK4udydsMpzjA==
X-Received: by 2002:a2e:9e50:0:b0:2e1:fa3f:67bd with SMTP id 38308e7fff4ca-2e95b256672mr23266371fa.36.1716568158825;
        Fri, 24 May 2024 09:29:18 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f7253800fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f725:3800:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc8dcb2sm154137066b.173.2024.05.24.09.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 09:29:18 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Fri, 24 May 2024 18:29:09 +0200
Subject: [PATCH v5 1/3] btrfs: don't try to relocate the data relocation
 block-group
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-zoned-gc-v5-1-872907c7cff4@kernel.org>
References: <20240524-zoned-gc-v5-0-872907c7cff4@kernel.org>
In-Reply-To: <20240524-zoned-gc-v5-0-872907c7cff4@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Hans Holmberg <Hans.Holmberg@wdc.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>, 
 Filipe Manana <fdmanana@suse.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

When relocating block-groups, either via auto reclaim or manual
balance, skip the data relocation block-group.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-group.c | 2 ++
 fs/btrfs/relocation.c  | 7 +++++++
 fs/btrfs/volumes.c     | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 9910bae89966..9a01bbad45f6 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1921,6 +1921,8 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 				div64_u64(zone_unusable * 100, bg->length));
 		trace_btrfs_reclaim_block_group(bg);
 		ret = btrfs_relocate_chunk(fs_info, bg->start);
+		if (ret == -EBUSY)
+			ret = 0;
 		if (ret) {
 			btrfs_dec_block_group_ro(bg);
 			btrfs_err(fs_info, "error relocating chunk %llu",
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 5f1a909a1d91..39e2db9af64f 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4037,6 +4037,13 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
 	int rw = 0;
 	int err = 0;
 
+	spin_lock(&fs_info->relocation_bg_lock);
+	if (group_start == fs_info->data_reloc_bg) {
+		spin_unlock(&fs_info->relocation_bg_lock);
+		return -EBUSY;
+	}
+	spin_unlock(&fs_info->relocation_bg_lock);
+
 	/*
 	 * This only gets set if we had a half-deleted snapshot on mount.  We
 	 * cannot allow relocation to start while we're still trying to clean up
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3f70f727dacf..75da3a32885b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3367,6 +3367,8 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 	btrfs_scrub_pause(fs_info);
 	ret = btrfs_relocate_block_group(fs_info, chunk_offset);
 	btrfs_scrub_continue(fs_info);
+	if (ret == -EBUSY)
+		return 0;
 	if (ret) {
 		/*
 		 * If we had a transaction abort, stop all running scrubs.

-- 
2.43.0


