Return-Path: <linux-btrfs+bounces-10399-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AE69F2B95
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 09:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5A4B1882D95
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 08:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED64200BBD;
	Mon, 16 Dec 2024 08:10:53 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD111FF7BE;
	Mon, 16 Dec 2024 08:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734336653; cv=none; b=R3HdCNgRuXyEiGO09N0sbob/HQ4KmVnumibGIkPivrYRnUBv/d7SgDOORvVs5Dblh+HUHXxSxWTLDmWxO7mseZjRYPQ/HQ9yeK9uu3LbtsV5eL/weSzQ+wa9wWXWh3C/UinOCf2Z5ygIfnuxU2IZfrtguzWuQJRIdNtUm1Dmh3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734336653; c=relaxed/simple;
	bh=hQhGyaMBEowC2R1tTMNuKMGO/V5a1g4mixVuy4H5gjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ClOQA5N2I0qNJocGmZoFr2KrK1I+i+UVhX0yu//u5FkygBqBXfHTlrKGSrd2STGpdYmvrLacnm3TU7aQ2t2Hcg/DSYUErspEmv6D/Fviiuq65y+ujmL5BSw0pyolZRfOj3I7Y2GNBoTiZeNxhEI+kIx5/Q4f7BedUtydJ5tXBIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa66e4d1d5aso617883766b.2;
        Mon, 16 Dec 2024 00:10:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734336650; x=1734941450;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubOWkPBCqZViUNDRxYFuVw+FV+8QDXQo5XOc7MPemnk=;
        b=H1CaiLeaPzON5zS4R7A+e5142k0p0e4zgEiu1iN1f/fYT2PM32S7buHmkU74lhCX78
         6zr4ujHuqt9zP/HdLF/Y7/0T7dmaFljxUZPcH329JgQMyJamKCMjZfhKE4/pnqEiY8NA
         LdJ0vSeZ2xsYV+tlpM81LeFj2u+FmNeX3P/iTPKY1FfDbOB789lF9XJSHloxMNPLyysk
         7oBVUXi0SQih1xPFcDcKU988eLC6bjIX2UijRlr9cjddR2FEdrJJBnhXOoCjJdJAZYbz
         +NV+F5gHiQelS+gKU5KDD1YhTPgJn2ZGZfo6UvaxlJqwFDdwLLbT3AJShCcnFrWMiu96
         KFow==
X-Forwarded-Encrypted: i=1; AJvYcCXAetLSjg6aIQH6AMWI5DbVxv/FzMN8xymIlKYaOkLLmn1XPO+5mEcqfIeLTd/42/cHRwmoryCPbdeIKsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN1yeuj99hOijuads6D3Lr4kSGwPdJsaaP5r9iga6wBZsD2iwd
	VWEJ9ji+ZEhbGuS5aebNgly2PEG+HAtdioqmoBgrkJS1QPHQTEAU
X-Gm-Gg: ASbGncsZITWNQ09urP0k4+yfJx/lv42+ZPOF5WDhPKkw1OMlEvM70aeIBpp+OUN2h5C
	A60IRGliCdPzSxpqX7v3rxSB8pzgBhZYYbEtkH9Sb8Gjd0c7TzTlVl1wUY0zNWTr0L2UQHxR6GS
	/W2+SOdPlyYyv/Z9V3Hw5bwzmla6oI5D4Tz1nBKja1FvMfCggq5zs2qIBxqR7EoxaP0EQksQQYd
	7/SpQQrLPdqEfaxh51+0y1KJM0NoYWa9NoNyVlmmQjluakY9O25nCO85JmlFxAPBLeLSikBdhzy
	yF2g+/trX4Oafn9zj3EQEqQ8dOeCV/OP5p+3
X-Google-Smtp-Source: AGHT+IHwUA1aq6YnB9jAt/lmxLCtcX0i1EG0DXOUPCbEF68poPJbkaZDDM69m1sshq4hhS069Y8ZTg==
X-Received: by 2002:a17:906:6a04:b0:aa6:af4b:7c90 with SMTP id a640c23a62f3a-aab77ebf83dmr1162709166b.58.1734336649558;
        Mon, 16 Dec 2024 00:10:49 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7081700fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f708:1700:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9635a000sm299013566b.113.2024.12.16.00.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 00:10:49 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Mon, 16 Dec 2024 09:10:40 +0100
Subject: [PATCH v2 2/3] btrfs: cache RAID stripe tree decision in
 btrfs_io_context
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-btrfs_need_stripe_tree_update-cleanups-v2-2-42b6d0274da7@kernel.org>
References: <20241216-btrfs_need_stripe_tree_update-cleanups-v2-0-42b6d0274da7@kernel.org>
In-Reply-To: <20241216-btrfs_need_stripe_tree_update-cleanups-v2-0-42b6d0274da7@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Filipe Manana <fdmanana@suse.com>, 
 Johannes Thumshirn <johannes.thjumshirn@wdc.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1775; i=jth@kernel.org;
 h=from:subject:message-id; bh=Fxo2E0W6vytL2KFqXYlgw7HuAk1pRB3J9eQSpw8UY68=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaTHP2hbzyXocOyJrPP3Fw5/xWzWeU7ZXt54POBqXVx62
 uHN8c5nOkpZGMS4GGTFFFmOh9rulzA9wj7l0GszmDmsTCBDGLg4BWAiJ40ZfrPof5JrWO/tdEYl
 icd65QNt+8hvDGfDFEwFilr1uzN36TD8FZBvbimdH3+U5wLX1VdXd3acTWjO/JZzcLPpo5z3vay
 SfAA=
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Cache the decision if a particular I/O needs to update RAID stripe tree
entries in struct btrfs_io_context.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/bio.c     | 3 +--
 fs/btrfs/volumes.c | 1 +
 fs/btrfs/volumes.h | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 7ea6f0b43b95072b380172dc16e3c0de208a952b..bc80ee4f95a5a8de05f2664f68ac4fcb62864d7b 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -725,8 +725,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 			bio->bi_opf |= REQ_OP_ZONE_APPEND;
 		}
 
-		if (is_data_bbio(bbio) && bioc &&
-		    btrfs_need_stripe_tree_update(bioc->fs_info, bioc->map_type)) {
+		if (is_data_bbio(bbio) && bioc && bioc->use_rst) {
 			/*
 			 * No locking for the list update, as we only add to
 			 * the list in the I/O submission path, and list
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index fa190f7108545eacf82ef2b5f1f3838d56ca683e..088ba0499e184c93a402a3f92167cccfa33eec58 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6663,6 +6663,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		goto out;
 	}
 	bioc->map_type = map->type;
+	bioc->use_rst = io_geom.use_rst;
 
 	/*
 	 * For RAID56 full map, we need to make sure the stripes[] follows the
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 3a416b1bc24cb0735c783de90fb7490d795d7d96..10bdd731e3fcc889237b4e1b05cc9389bc937659 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -485,6 +485,7 @@ struct btrfs_io_context {
 	struct bio *orig_bio;
 	atomic_t error;
 	u16 max_errors;
+	bool use_rst;
 
 	u64 logical;
 	u64 size;

-- 
2.43.0


