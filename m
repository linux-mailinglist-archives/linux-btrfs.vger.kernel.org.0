Return-Path: <linux-btrfs+bounces-6925-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3159B943749
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 22:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 314411C21D3D
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 20:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE0B16D324;
	Wed, 31 Jul 2024 20:43:30 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7B316C6B4;
	Wed, 31 Jul 2024 20:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722458610; cv=none; b=tIijiRAXUqVGWqtZJCHqpLzch2ksWNq9ty9DuzR7MwN8iDbxW336yoNs/aiDny2aIsCLfcs9CDhCsnjzNDYPEGfM/5MC9KMu1VY0m3742jAkNHgVDFQc7TedmkzhmCpzq7rILf+3n3GU+/3ExOwWaSPmZenbN23gsxo/YlR3sq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722458610; c=relaxed/simple;
	bh=v4vCd/Bu2h4j7zhmr8yL+7rc9TdDQLIsA3Q1rIS8QPA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VgH04onorDVab2C5V2N1IGVThTQE843QZw5vyxXw0o+/QuccSxkEHzbEYXoXa5XWdODtOX3GhXoUeYFGsOMuWN2CG2NqHgOtNHHs5MVq2uO+w1d+aW0Z5aQgUrOaoBR7ZS2KHIRgGx67YR/qT0gQkEGgu/LN4SLW60ibC9PzN48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7aa4bf4d1eso858589166b.0;
        Wed, 31 Jul 2024 13:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722458607; x=1723063407;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xHk5RgMaWEKXGJ61N7K1mI3Jkz5zzJ/5Z19Qs8wpYI=;
        b=SUBoM2e0aZlkFmSNe2VY3gBTrmo64TAO4f7RXz+R377An4mfSDeVqibdcU5hoXpv6b
         c9WOCD612NDFBDT7PtTC7SWSqevSMXXcu/genqFa42KOew6Ci0x9wDviBWT8l5tVlxky
         jJw8/ThBZkLIkeBFBMT/PxzObFxjaVgbGJr7kWEUsci8u+8q/aaVGenylDOKusgL+oTq
         XyJpmcG2Tg2tXdOf/1HWs1UXSWQ+J4P6tKj+tq9M+NrG/RQfNqFm94wbcMba45PE+Kfy
         xdURDUHB18s1rtZfcpnQ/GRVPlH1DZCuxZDKlAOGsJkN7k33QJOignikzmhXaCmcV3fA
         K6uw==
X-Forwarded-Encrypted: i=1; AJvYcCXGKaJgLFYtTNqqPRgOPE/KDWKMO0Resg1YRrMzesnM7l4PqtldFlsHmlij3BCefUOG2ZfU+nTSonWPnVr3EjA0WboaLC36bCUXd+BO
X-Gm-Message-State: AOJu0YyrF8DwwTlbJZ4H5phOHrpuq1kQJwLNIHcI3LfAPPYvSdyUuCvv
	imsiCRVmgoVU52AdKOIV9G1d42c8tc6TY98nrVKDf/bDCTlpixFGEm4JLA==
X-Google-Smtp-Source: AGHT+IGRO8QW+aUvS3ay8zHdASwFvT7/4hNrCek0rA6DH2DIWFiQkCPtVZgaLaVvm1OMMGSpODZ7Uw==
X-Received: by 2002:a17:907:cb88:b0:a7a:a30b:7b91 with SMTP id a640c23a62f3a-a7daf672dc0mr15434966b.64.1722458606523;
        Wed, 31 Jul 2024 13:43:26 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f732f200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f732:f200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab4dec6sm807454366b.61.2024.07.31.13.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 13:43:26 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Wed, 31 Jul 2024 22:43:05 +0200
Subject: [PATCH v3 3/5] btrfs: set rst_search_commit_root in case of
 relocation
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-debug-v3-3-f9b7ed479b10@kernel.org>
References: <20240731-debug-v3-0-f9b7ed479b10@kernel.org>
In-Reply-To: <20240731-debug-v3-0-f9b7ed479b10@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, Qu Wenruo <wqu@suse.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=895; i=jth@kernel.org;
 h=from:subject:message-id; bh=/oIRBLEpQO1DCEdzc5KY2X8GmQ9KE67FpNuLhhDmBNM=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaStWviy6tWaf2kCiumRBkpfv735OuPdp7/z10WpiPvlz
 nGQ0Wuz7ihlYRDjYpAVU2Q5Hmq7X8L0CPuUQ6/NYOawMoEMYeDiFICJPO9n+F951mUJ111hvs0p
 50OCTrMq/fYy3/HjF2PM0z+p7DZfPNcxMuzcll/S86y/d+L6j7+fHfM+vu5JAmOwSbhrYX26zeL
 32QwA
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Set rst_search_commit_root in the btrfs_io_stripe we're passing to
btrfs_map_block() in case we're doing data relocation.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/bio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index dfb32f7d3fc2..c6563616c813 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -679,7 +679,8 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 	blk_status_t ret;
 	int error;
 
-	smap.rst_search_commit_root = !bbio->inode;
+	smap.rst_search_commit_root =
+		(!bbio->inode || btrfs_is_data_reloc_root(inode->root));
 
 	btrfs_bio_counter_inc_blocked(fs_info);
 	error = btrfs_map_block(fs_info, btrfs_op(bio), logical, &map_length,

-- 
2.43.0


