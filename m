Return-Path: <linux-btrfs+bounces-6829-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7161D93F4C0
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 14:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9781F22BA4
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 12:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18810148303;
	Mon, 29 Jul 2024 12:00:18 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F57F145B0B;
	Mon, 29 Jul 2024 12:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722254417; cv=none; b=LTrT9iBmSQ68M84wxASIIMeBZ2GLv/dEJlA0/1pgRfgKlDrP48z4uOJFL1RsJyDMIDJnoJ11aoBUU6DDzI/EwEI9AifJwpTMarFXzWyUatiaznxb2linf/VUqjjL0c9w3jEEEGtU70cjEIqMi/1bqXbo8orrVjV5KHei9lCNqEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722254417; c=relaxed/simple;
	bh=V2/wyFM3bPaGJfPQmLX/sluxJRKr7lvIOzPidOT0y/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ajjeafd1fvGCgzR57suqafAXC07Lf9lnuaZl4Wre9a7QfwFcaT7E3GmAzdfNfAjNMGgdf4G1MDw+B9b/DO9QWqmHZh4Pta63IcamRnvJXNp01o8U5k+cGWOU/0uimzWVUXYchU/kerQt92j/GArZWDw7hrIWY5s5nQ6QxnG76rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52efd855adbso5142415e87.2;
        Mon, 29 Jul 2024 05:00:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722254412; x=1722859212;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LuI4Ztw0QlpRT70UGqlhNtTpM0k62lG+oH/v547owU=;
        b=npaH2VPx6x8PvFhNNONPFz8wLQixyNT/AJGldNT+bkXCSmJDv60kETl4YEeQo+KqSN
         gdK0MMUHLhcOgaYI63VCruYXfzaTw/Pq5xmUViHLew8Pnbz7g8LrP0cUGMSbvdP+L1gn
         xEtGI+pDApbjDP/nPraqFDMz+/Oz9fpfAVRH3NSbxBBWpheFnJobEErW0FzC2fbOWdtz
         vNUs3CAEhMK2IxaOMdhx3lKn1SIAEnC8khgQag1VwkvUAHVlj6YSwmplymlMHijO6hYF
         9DyH80FlSU1OIY3TkaTOjJuFhajk7Wby120Qtyu0s6Sc7TgC7WZzaDiaDns7luVnjWiN
         tApA==
X-Forwarded-Encrypted: i=1; AJvYcCVu3BSTxWxapvrwdB/3ePsAaVptGLyRQWmo+zf/DRG6Qo3aUo6G2c3+5tkCnibGCllSS4TfVITI728V8ZifQVL1hHBPM5RWqCRKh+Gt
X-Gm-Message-State: AOJu0Yyc2/bgWhZK17Os8SaQm1trbb+yLPKldigI0A2Ejzz26mp72OE/
	iieS7nahCudsKu+rDvSMCBZ2+4D9d41hAObG0C/jB0E/Y5Gx8U/pua38RQ==
X-Google-Smtp-Source: AGHT+IFw17vz6wvXaqgDgsK/XkKKX/l2xE03S8Vjxb4Ugyre4iGkQtr60Zs6wR7ZuinghQ1zDriOwg==
X-Received: by 2002:a05:6512:3056:b0:52c:cd4f:b95b with SMTP id 2adb3069b0e04-5309b27a467mr5327231e87.22.1722254412296;
        Mon, 29 Jul 2024 05:00:12 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f732f200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f732:f200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab2311asm508136266b.18.2024.07.29.05.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 05:00:11 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Mon, 29 Jul 2024 14:00:03 +0200
Subject: [PATCH 2/4] btrfs: rename btrfs_io_stripe::is_scrub to
 rst_search_commit_root
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-debug-v1-2-f0b3d78d9438@kernel.org>
References: <20240729-debug-v1-0-f0b3d78d9438@kernel.org>
In-Reply-To: <20240729-debug-v1-0-f0b3d78d9438@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2799; i=jth@kernel.org;
 h=from:subject:message-id; bh=GLCvjYyujrbk7qMrFGW/JRXoGw+aEQQjKxibIwWDeQ4=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaQtb/FcYiw2wYZvw9LayKvpldv/zjnTOffdAVuJE5MO9
 bre26Rn1lHKwiDGxSArpshyPNR2v4TpEfYph16bwcxhZQIZwsDFKQATibjG8D9jk0fVuv6T4fKp
 7cZbjtfbFtZkH84/Ln21dn22zMTFnVGMDNPumbrrH+Bhu8Iz2dQ/+cLxg71ClwObNPb83/Jxl9S
 kBcwA
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Rename 'btrfs_io_stripe::is_scrub' to 'rst_search_commit_root'. While
'is_scrub' describes the state of the io_stripe (it is a stripe submitted
by scrub) it does not describe the purpose, namely looking at the commit
root when searching RAID stripe-tree entries.

Renaming the stripe to rst_search_commit_root describes this purpose.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/bio.c              | 2 +-
 fs/btrfs/raid-stripe-tree.c | 4 ++--
 fs/btrfs/scrub.c            | 2 +-
 fs/btrfs/volumes.h          | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index f04d93109960..dfb32f7d3fc2 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -679,7 +679,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 	blk_status_t ret;
 	int error;
 
-	smap.is_scrub = !bbio->inode;
+	smap.rst_search_commit_root = !bbio->inode;
 
 	btrfs_bio_counter_inc_blocked(fs_info);
 	error = btrfs_map_block(fs_info, btrfs_op(bio), logical, &map_length,
diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 97430918e923..bfb567f602b1 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -210,7 +210,7 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
 	if (!path)
 		return -ENOMEM;
 
-	if (stripe->is_scrub) {
+	if (stripe->rst_search_commit_root) {
 		path->skip_locking = 1;
 		path->search_commit_root = 1;
 	}
@@ -283,7 +283,7 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
 out:
 	if (ret > 0)
 		ret = -ENOENT;
-	if (ret && ret != -EIO && !stripe->is_scrub) {
+	if (ret && ret != -EIO && !stripe->rst_search_commit_root) {
 		btrfs_err(fs_info,
 		"cannot find raid-stripe for logical [%llu, %llu] devid %llu, profile %s",
 			  logical, logical + *length, stripe->dev->devid,
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 0f15f5139896..a1f41e8b00cd 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1695,7 +1695,7 @@ static void scrub_submit_extent_sector_read(struct scrub_ctx *sctx,
 					    (i << fs_info->sectorsize_bits);
 			int err;
 
-			io_stripe.is_scrub = true;
+			io_stripe.rst_search_commit_root = true;
 			stripe_len = (nr_sectors - i) << fs_info->sectorsize_bits;
 			/*
 			 * For RST cases, we need to manually split the bbio to
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index c947187539dd..03d2d60afe0c 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -444,7 +444,7 @@ struct btrfs_io_stripe {
 	/* Block mapping. */
 	u64 physical;
 	u64 length;
-	bool is_scrub;
+	bool rst_search_commit_root;
 	/* For the endio handler. */
 	struct btrfs_io_context *bioc;
 };

-- 
2.43.0


