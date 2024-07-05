Return-Path: <linux-btrfs+bounces-6233-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D99A928B68
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 17:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502F31C24C42
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 15:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A7316F8F1;
	Fri,  5 Jul 2024 15:14:06 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AEE16EB74;
	Fri,  5 Jul 2024 15:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720192445; cv=none; b=HNr+HnLV5rZutCltvu+00g89Kg2ls01yo3aAj5GRXmHp82cfj7VP5otWC0zURuVY5tf2RsRUFwUdmJzaSBVCsrjk8Fj95GMOzgeeOPj/dlE/l3x0IGLInMHdraGEsNCmhPDmGJV+X17YsQznka337E0Ha31JBKVqub6QES1iwvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720192445; c=relaxed/simple;
	bh=QMnTCTtJiJrPH2JIySIPFKT86DVHKnbXKEgtE+He4bc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R/9Sacz/djI2Ivcg1FUY5ZreHqLsh7mfV3d2nGiojOLGNhFNt5/7/AQOksD03daTVP9XZRS7qyjQ6RVnTRQsoMagEvwtZoUMWkaEJwuFqy5GM/swkQoF/Jtegz3kQfE7s/qQaAWFE178Fq7JnaMjEetwLLcXMyEWwWCarN+idk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a77cb7c106dso99364766b.1;
        Fri, 05 Jul 2024 08:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720192442; x=1720797242;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7ntbhccgXALWpWLNHUmzWoIXG74udOWs1KUfAeRQqk=;
        b=HTDZv8E7FioHlmJMnZuveOZbJPzEGglAu4VwtkeGjkIfZZLpCFgqXBSdA0D7S3y1lp
         WRMRQa4hhL/+t6cPZDzUrK/srQEAAx1Rz4veDZwEJen3msPWVgQXEkrC4dGSea1IU167
         N/T8qU6o2qXWH31XT0TedkxZywYWnbWgfXtQvinBqWTIS290jLmrTVtuOpvb0XwzjZh4
         QGYRtWJgG5ZVpcHSEZxHOlT2v17QKLoaPV5bjFEPyPJqGWNxzcuRPXmXq+6U3BeNcAg6
         0fV1hEiIeiOlGjwCmezpNbdgpYDcsph2ayUlvF0u2qoIcPv7+6kpnsNS5pGVgHT4aadV
         NT7w==
X-Forwarded-Encrypted: i=1; AJvYcCWr6h5xXhkNsVQRiQFm/rSeyJTu74boIOLJJjgCVsiKCb06ONnc2fDN6XHCL4HmKNc1Ul775+DNnGOnqB2uIbocZUXxpl4fQDn0WEJx
X-Gm-Message-State: AOJu0YzJUZRTPve8WKAPV+/uevA8KFembCEiNeCSFz+DNuo6OwswSYL4
	YA/pxYCCmDQ57FJGl/IphNwzoOEtRLaM3JbTKn1+4H2rjVWpQjYK5o/LJQ==
X-Google-Smtp-Source: AGHT+IHgG+iQF5DSzz32+NK65g5H7nR0U1CRekw5L64vzqWqFJRL1PUd1roZp9OHvKKy92DK1dTnMw==
X-Received: by 2002:a17:907:6e8d:b0:a72:8d40:52b8 with SMTP id a640c23a62f3a-a77ba44cf6dmr367219966b.3.1720192442400;
        Fri, 05 Jul 2024 08:14:02 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f72f3200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f72f:3200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf6336csm686226566b.70.2024.07.05.08.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 08:14:01 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Fri, 05 Jul 2024 17:13:52 +0200
Subject: [PATCH v4 6/7] btrfs: rename brtfs_io_stripe::is_scrub to
 commit_root
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-b4-rst-updates-v4-6-f3eed3f2cfad@kernel.org>
References: <20240705-b4-rst-updates-v4-0-f3eed3f2cfad@kernel.org>
In-Reply-To: <20240705-b4-rst-updates-v4-0-f3eed3f2cfad@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2170; i=jth@kernel.org;
 h=from:subject:message-id; bh=Fok4bTdJnN9CEf4tAvRVtqyQ7FJSvMwR/2K0tVu4Mso=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaR18G4yVp3StJ9h4+M69Z75c6wn7PWbc+meIVeyss6WR
 j891SVnO0pZGMS4GGTFFFmOh9rulzA9wj7l0GszmDmsTCBDGLg4BWAiywQYGQ7mSn86f+2CWH71
 3SjrY/t7vEU2uzdpdE1WFQ3YuSXTPoDhn+EeuTUn/554bVaqVbiU6++7xa5Gs+rCTiXVth0KT0t
 cygwA
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Rename brtfs_io_stripe's is_scrub to commit_root, as this is what it
actually does, instruct btrfs_get_raid_extent_offset() to look at the
commit root.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/bio.c              | 2 +-
 fs/btrfs/raid-stripe-tree.c | 2 +-
 fs/btrfs/scrub.c            | 2 +-
 fs/btrfs/volumes.h          | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index f04d93109960..5f36c75a2457 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -679,7 +679,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 	blk_status_t ret;
 	int error;
 
-	smap.is_scrub = !bbio->inode;
+	smap.commit_root = !bbio->inode;
 
 	btrfs_bio_counter_inc_blocked(fs_info);
 	error = btrfs_map_block(fs_info, btrfs_op(bio), logical, &map_length,
diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index ba0733c6be76..39085ff971c9 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -259,7 +259,7 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
 	if (!path)
 		return -ENOMEM;
 
-	if (stripe->is_scrub) {
+	if (stripe->commit_root) {
 		path->skip_locking = 1;
 		path->search_commit_root = 1;
 	}
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 14a8d7100018..9c483b799cf1 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1688,7 +1688,7 @@ static void scrub_submit_extent_sector_read(struct scrub_ctx *sctx,
 					    (i << fs_info->sectorsize_bits);
 			int err;
 
-			io_stripe.is_scrub = true;
+			io_stripe.commit_root = true;
 			stripe_len = (nr_sectors - i) << fs_info->sectorsize_bits;
 			/*
 			 * For RST cases, we need to manually split the bbio to
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 37a09ebb34dd..25bc68af0df8 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -444,7 +444,7 @@ struct btrfs_io_stripe {
 	/* Block mapping. */
 	u64 physical;
 	u64 length;
-	bool is_scrub;
+	bool commit_root;
 	/* For the endio handler. */
 	struct btrfs_io_context *bioc;
 };

-- 
2.43.0


