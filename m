Return-Path: <linux-btrfs+bounces-6828-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5767093F4BE
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 14:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 724D51C22367
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 12:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648E5147C96;
	Mon, 29 Jul 2024 12:00:17 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A179146D63;
	Mon, 29 Jul 2024 12:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722254416; cv=none; b=cYgYKxKxW5sWLhBspIwQlRemGd42khQJnFB4Bt5pPw8APxyoP3b3t2YSFoH+DrXzO2NTWoJcq9QN+HvtA98gLQ0NxX5SpmLIp+dOP0rWTAxNWPxJKGXGKk33nr+2XZDUxaYClvvwjwYmlSZFME3K3aog/Y/vO1s1VmCaKI5yEAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722254416; c=relaxed/simple;
	bh=/IcSJYYXJNCnwyGW/xg7CQHiY002W+thsnUAs/eIUL4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KrBT1wMyd26/AJIQW4mq2Fk01GW6KDSgibEYGwF4/3bUW+s+Mf2emd7IF8TcKnCu4cGSkAkO1C5qbiqYSzIX7Zut0o8yIeTNVI6jO+ki+IGd/kPKOTRsZg8AsgNgI/U+UOE9ACBojY5CXuVFR2SY8WG+5mR7ybLnkH0ASqgSLsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7a9a7af0d0so449912566b.3;
        Mon, 29 Jul 2024 05:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722254414; x=1722859214;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJWlRDxSJTNdG19sMCqs4ElfI/UMNfe1NBY5LQ2S1jo=;
        b=MF9kVmj1PFYpz71srRsxcIhbPgr41r93Q8xO5oEpglenIBgzXUoer9boIBX2z5Py6R
         o+MJ7nx8FjNlzosdtxfwYHDqJT+OpVOwngeibJo1xQ1MxJN6GjBPfeJijzoJPXJAo0B3
         8g+LfohmIVm6hXekwZSVw7NBMJN6qNSfRLZNySndrOzGXJHA7O8I5/FKvczCvpIkErV1
         snjS0KMJ0rT2kVCZiOlqpZzbgbhETvA7HMbYD7JISIURiQokwKapf+YPnciTC1TPjQ/9
         t+DLpGwet8uJE3YuSvqmQ0/FYvM6D4RNP6dUzGSC3lfafyLFlH0XwkI4ARsKE7BGsk2O
         zGIA==
X-Forwarded-Encrypted: i=1; AJvYcCUnsdPFtbkkWzzF6BUrjj74naXopgd/UQw/Lyd+EmJUyhW9ihKRX1/Mfpt+RQo3m5BCEdc0+G4Si7tD/V8/o3kKHi+FEVQmbl6/hyV7
X-Gm-Message-State: AOJu0YzOroHo38KYeLQTuSylNF8rIVSNfoxLEQYmE4KPmouMRmHo3vvJ
	JpDeKh3+yYd0dcGDzi9Eri/Wl1QH7ohEY8goBHDKALVRqKGRGATO4xmNWg==
X-Google-Smtp-Source: AGHT+IHQz/cs4BNgOjsZ7NScCJNoUR0po1I68N/2lTCAbnlRYFbs6SDsccisgH2AtWk9x8CcybNVMg==
X-Received: by 2002:a17:907:608c:b0:a7a:b643:654f with SMTP id a640c23a62f3a-a7d3ffb67cbmr414133466b.15.1722254413467;
        Mon, 29 Jul 2024 05:00:13 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f732f200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f732:f200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab2311asm508136266b.18.2024.07.29.05.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 05:00:13 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Mon, 29 Jul 2024 14:00:04 +0200
Subject: [PATCH 3/4] btrfs: set rst_search_commit_root in case of
 relocation
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-debug-v1-3-f0b3d78d9438@kernel.org>
References: <20240729-debug-v1-0-f0b3d78d9438@kernel.org>
In-Reply-To: <20240729-debug-v1-0-f0b3d78d9438@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=807; i=jth@kernel.org;
 h=from:subject:message-id; bh=b0Pb+uSMgNZdT9sxeeZ9pRVHoEwmmPaSc/gj9kZGk3k=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaQtb/FcYpRSlnGFj+FipserpPULs85GfdeV1jhjI1w9e
 3Zm/X31jlIWBjEuBlkxRZbjobb7JUyPsE859NoMZg4rE8gQBi5OAZiI/DaG/8Gm8Q73Dx7l0cle
 uX6z/uGPUu4b3y8Stfcq3cd3bZFY/3mGf+ZnTlmePf7QiDVYv6fu3uNVlyQm2G95q+OjuMvM9q6
 FMTMA
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Set rst_search_commit_root in the btrfs_io_stripe we're passing to
btrfs_map_block() in case we're doing data relocation.

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


