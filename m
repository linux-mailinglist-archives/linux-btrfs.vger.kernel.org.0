Return-Path: <linux-btrfs+bounces-5470-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D57498FCFA0
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 15:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBBF61C23EEA
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 13:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E65319938B;
	Wed,  5 Jun 2024 13:17:59 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40749197A8F;
	Wed,  5 Jun 2024 13:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717593478; cv=none; b=WSTVBylD/mIpqgtF9O9IxgAabAzxpzyalfUZ6BYLRfSeIZjBKzyOzeZLNM8x7ilzcmd6fHygZWYG+e63E3tVamBTW6MZORopCIXcs/hGcI1MnfZce3d0CsJht6gso5PzDdiAmR3gYh9xeUo6/TG6ds+DMdNgrH/H9UsA9+PdGkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717593478; c=relaxed/simple;
	bh=WDUz7fG6FfIJIZkudiSnKmkmX/Ia1bOQENtWWLof9SY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KS6X+SMCM0Di/YRtBFEi5ot1SCABGo2jF/Kmp/ScOZP15O7ubwh++WGt7IKkhwssZdz1KIy3wqLTtVxK7oWPmVdm1Ua7x8sjwI6bnp0DVD5oO4prKP++m4JdTwajsr9xCLSxKSipLlYDoTNVgW4IqMUZofoI1QT1I/21v+FjIeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63a96so6559548a12.0;
        Wed, 05 Jun 2024 06:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717593475; x=1718198275;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIYhLPhDACS5S3WiEv4gpp9ka+wmTQUeOJx3H2AvDpY=;
        b=w+SwiKz/abeX1C45N+M8aVkYaaQcg6bKclGzad12YoX7deOMtkqbO/JSJPZA4Il347
         BA7jYK3nAFjxURHk+0Ic2EM42rrjuxw7NvkJAMBR6E1OC7PVNxd1Pc2GCd+oXutZF2eh
         SQrjVBuYyBp+kVVQdA9/MCR+2LG3kmLaX9bAH/2zkwO75M7lNe7oVflfTntpNatcBVMx
         0nK+XqxoOvfxZKsIhhoYlGl/0gPGGQKJ5l2Jqh6a/x+PmhW6M7Urdff2MRbrh5Shffh9
         dWYX3T13HkNMvdiZ1/z+rfL53L+8Gwb2qeKJDGelm4GZscvm3PM11yWF1i5k+o8PU+ns
         H6Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUURfm7RjXjJl+Xo83q1CNed8ZL6C/ouMge+0LE17gs8nyJVDE9eZCkzC8wvQEkLGFGLHGbhZ0TH8wbV2LgzEDZBxG4BF0zaOu0Zk6S
X-Gm-Message-State: AOJu0Yw8rD2wFY+wtZQZcsHiFXF6KMDP0pAz+CKKfotynRDq82XwiHwq
	Tdh8uwVP+b2pIhyXBZQscVE572gMgedilPV6V8+j7m68WPLPq/pv
X-Google-Smtp-Source: AGHT+IGGxN/ZriO44OeX3cspPv797GsM3IAm/GNPtkSuYA4xbXWMGbnQdDUE4hbUCoSsUXoCcLQ8kQ==
X-Received: by 2002:a50:aac4:0:b0:57a:2417:5ef4 with SMTP id 4fb4d7f45d1cf-57a8b6aa068mr1677660a12.17.1717593475378;
        Wed, 05 Jun 2024 06:17:55 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f7253800fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f725:3800:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31b99a3fsm9266913a12.9.2024.06.05.06.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 06:17:55 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Wed, 05 Jun 2024 15:17:50 +0200
Subject: [PATCH 2/4] btrfs: pass a reloc_control to
 relocate_file_extent_cluster
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-reloc-cleanups-v1-2-9e4a4c47e067@kernel.org>
References: <20240605-reloc-cleanups-v1-0-9e4a4c47e067@kernel.org>
In-Reply-To: <20240605-reloc-cleanups-v1-0-9e4a4c47e067@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2313; i=jth@kernel.org;
 h=from:subject:message-id; bh=80TgFMM98ydJfyyVXKV8pIHBUC0TTeyzRxVisoduFMI=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaQlpDYYrqvLMJD/1Lqr19ncdTvPxY4CezsloUyvXR5Zh
 f5H/dZ2lLIwiHExyIopshwPtd0vYXqEfcqh12Ywc1iZQIYwcHEKwETSbRn+J4a/j769nenTmXud
 AufnrgoRFCwQcVnZf2mdvq9z5pzCSIb/8b8F3Zt+bY6/c5Wna5+LUGW+b5/EnflOezlusIpmzNP
 hAQA=
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Instead of passing in a reloc_control's data_inode and
file_extent_cluster members, pass in the whole reloc_control structure.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/relocation.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 442d3c074477..e23220bb2d53 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3084,9 +3084,10 @@ static int relocate_one_folio(struct inode *inode, struct file_ra_state *ra,
 	return ret;
 }
 
-static int relocate_file_extent_cluster(struct inode *inode,
-					const struct file_extent_cluster *cluster)
+static int relocate_file_extent_cluster(struct reloc_control *rc)
 {
+	struct inode *inode = rc->data_inode;
+	const struct file_extent_cluster *cluster = &rc->cluster;
 	u64 offset = BTRFS_I(inode)->reloc_block_group_start;
 	unsigned long index;
 	unsigned long last_index;
@@ -3132,7 +3133,7 @@ static noinline_for_stack int relocate_data_extent(struct reloc_control *rc,
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 
 	if (cluster->nr > 0 && extent_key->objectid != cluster->end + 1) {
-		ret = relocate_file_extent_cluster(inode, cluster);
+		ret = relocate_file_extent_cluster(rc);
 		if (ret)
 			return ret;
 		cluster->nr = 0;
@@ -3158,7 +3159,7 @@ static noinline_for_stack int relocate_data_extent(struct reloc_control *rc,
 		 * the cluster we need to relocate.
 		 */
 		root->relocation_src_root = cluster->owning_root;
-		ret = relocate_file_extent_cluster(inode, cluster);
+		ret = relocate_file_extent_cluster(rc);
 		if (ret)
 			return ret;
 		cluster->nr = 0;
@@ -3177,7 +3178,7 @@ static noinline_for_stack int relocate_data_extent(struct reloc_control *rc,
 	cluster->nr++;
 
 	if (cluster->nr >= MAX_EXTENTS) {
-		ret = relocate_file_extent_cluster(inode, cluster);
+		ret = relocate_file_extent_cluster(rc);
 		if (ret)
 			return ret;
 		cluster->nr = 0;
@@ -3775,8 +3776,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 	}
 
 	if (!err) {
-		ret = relocate_file_extent_cluster(rc->data_inode,
-						   &rc->cluster);
+		ret = relocate_file_extent_cluster(rc);
 		if (ret < 0)
 			err = ret;
 	}

-- 
2.43.0


