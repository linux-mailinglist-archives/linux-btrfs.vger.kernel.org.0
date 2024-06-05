Return-Path: <linux-btrfs+bounces-5471-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7748FCFA4
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 15:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E2961C23EEA
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 13:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130B119A296;
	Wed,  5 Jun 2024 13:18:02 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83483199393;
	Wed,  5 Jun 2024 13:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717593481; cv=none; b=WCVgGCXwEz/pY+S3CQSUT3f3ynTVSkCicwsXjtIc5J2zH/lqWzq05WW7IOk7nvGUeKGWjKokywP5inZ8U7t3LX+Gy7odPlF1HrTkvXspxXkBcmBalxD7PhwAESxrPskIhdV8bbFeKHq82iqADMGUtX9/HpEtGLLim0Fcd11DqR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717593481; c=relaxed/simple;
	bh=LQWaXCkks8QFeGC4yzq3v/pe/w3ygDZxLK1b8dLJQE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pqrrS9v1k8MNudVDw3d0jdBSrmcfAXo2SrqaymiF4pJAgJhEzpDtZXytXRBBG23XToPzIwqufNBhhY582wEN7GqzHKF5WQMWG8K/9mj5Q6KtSDXk0B63iBTg7HKsvluBCpJs6t5gtwZ10orKiGGYNok+3PpSjYChxTXn4FWR3zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57a5bcfb2d3so1877662a12.3;
        Wed, 05 Jun 2024 06:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717593478; x=1718198278;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NabLomXctzJfOIf9JUgsvOd5nDkBFJ6nfLfOkmNQ+vw=;
        b=YUjrsFOBDsGsX/Yn0HgMSCXx2FPAO881rynJoKIuINqX47dbIAMA5cZDDWcP8imLpY
         YGUxDK4fVyiCeM8Uzh8xUEAMHdKfEh92mcdBBsBo2ilIvposdv/Gi8Xq4PsQuRDxe5Wa
         HtupKsWK7s8G02ZaR8B1SwtWIG7TORGsgX48CMg5Pn923/wUOHwShTFAw0F0X6uxE9Zf
         gCxC44hkGsI64pHyYrCnaE7IAxILIQaRDD2m18BqicWaSnnB/cpYu1Hx/4cUMDRWyNrD
         OG4mui6rcwPZxTxPxREU8CJdtNhw7YVNiB5uTEFcGpBcAxTqvFpmyM9afesBADhW3Oi5
         5Gdw==
X-Forwarded-Encrypted: i=1; AJvYcCXWeuCBKZxIfWL4l3naMxMPzOaXdWDuJHiYOl0mii3KBhYx+KhIOHWNjOLmmtcMom+71X7A6E6/bwB599wAFmQKQPR/I7QQ53xtoUQH
X-Gm-Message-State: AOJu0YySNObihnhSb3EtntUpbMkPiALvmOqYt8x7BUFcNhvKcVdHnq92
	E6QJVuCRmH9dkzzp10ruwXqX8lqBQ7zEHZxvvQ4pDvtSH/K7WzwY
X-Google-Smtp-Source: AGHT+IGqVBSF4s5bgsGUc0mjR0HxgVNarc4CZk5fAfx94W4rYtI0583sFWS7gHYt8+k8edQKszgRZQ==
X-Received: by 2002:a50:9509:0:b0:57a:3046:1cd8 with SMTP id 4fb4d7f45d1cf-57a8b697867mr2205252a12.7.1717593477784;
        Wed, 05 Jun 2024 06:17:57 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f7253800fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f725:3800:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31b99a3fsm9266913a12.9.2024.06.05.06.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 06:17:56 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Wed, 05 Jun 2024 15:17:51 +0200
Subject: [PATCH 3/4] btrfs: pass a reloc_control to relocate_one_folio
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-reloc-cleanups-v1-3-9e4a4c47e067@kernel.org>
References: <20240605-reloc-cleanups-v1-0-9e4a4c47e067@kernel.org>
In-Reply-To: <20240605-reloc-cleanups-v1-0-9e4a4c47e067@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1655; i=jth@kernel.org;
 h=from:subject:message-id; bh=ndZzlF5EeEbH1BXyLDy/6frtitIBCl8R/yHkFE8Tgs0=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaQlpDbMq45vlXY35lr/X/3ymbUfW20vMBnHvBZZv+YQi
 9UimdrTHaUsDGJcDLJiiizHQ233S5geYZ9y6LUZzBxWJpAhDFycAjCRugZGhmt7ONws7Zru/VjN
 GL4/VyZ4edzH/n1fr3Q/31uomCKXv4Phn/7nWzMbZcM+P2osuD1d70jk7yur5lpMKp37fv590cO
 ThZkA
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Pass a struct reloc_control to relocate_one_folio, instead of passing
it's members data_inode and cluster as separate arguments to the function.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/relocation.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index e23220bb2d53..a43118a70916 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2947,10 +2947,12 @@ static u64 get_cluster_boundary_end(const struct file_extent_cluster *cluster,
 	return cluster->boundary[cluster_nr + 1] - 1;
 }
 
-static int relocate_one_folio(struct inode *inode, struct file_ra_state *ra,
-			      const struct file_extent_cluster *cluster,
+static int relocate_one_folio(struct reloc_control *rc,
+			      struct file_ra_state *ra,
 			      int *cluster_nr, unsigned long index)
 {
+	const struct file_extent_cluster *cluster = &rc->cluster;
+	struct inode *inode = rc->data_inode;
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	u64 offset = BTRFS_I(inode)->reloc_block_group_start;
 	const unsigned long last_index = (cluster->end - offset) >> PAGE_SHIFT;
@@ -3116,7 +3118,7 @@ static int relocate_file_extent_cluster(struct reloc_control *rc)
 	last_index = (cluster->end - offset) >> PAGE_SHIFT;
 	for (index = (cluster->start - offset) >> PAGE_SHIFT;
 	     index <= last_index && !ret; index++)
-		ret = relocate_one_folio(inode, ra, cluster, &cluster_nr, index);
+		ret = relocate_one_folio(rc, ra, &cluster_nr, index);
 	if (ret == 0)
 		WARN_ON(cluster_nr != cluster->nr);
 out:

-- 
2.43.0


