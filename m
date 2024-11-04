Return-Path: <linux-btrfs+bounces-9323-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5C49BB465
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2024 13:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA584B24144
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2024 12:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA1C1B5EBC;
	Mon,  4 Nov 2024 12:14:09 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48FC1BB6BA;
	Mon,  4 Nov 2024 12:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730722448; cv=none; b=M2SIB57Ig39z4vi14ZOxY/vJBCGwb8+IKwWO+BYCr22by5CtzqXeLJSv/CrklubrvuK1zioKbltHvfbqvAS7n6FazXyBKCCKCR7LcPOfEEFKCaG+18WZna8Xf8+ptWbSfGASP1j7JPTdrfemzVrTyEdjubDSMhw+HMyBag7bLxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730722448; c=relaxed/simple;
	bh=LlJTpzPFOcXD6rJumc2gatXqNvI8NA9EdhmLf5bd0yg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bUgq1gj602hDPdL5184xDEhDHFMya901vTJI/WpSorJdJad/EpTj+XKHKNCYV3TYlX/Jeakkw6X7xNAJFlKJ4XxxJoDQvGtrDT+HyGP56vWo73AAml3J0XlrZK3z+ygkk9Q1H2ZuLz9P99oVlNTS6SjE89bdofKnaNJaeRSOi2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a850270e2so692809366b.0;
        Mon, 04 Nov 2024 04:14:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730722445; x=1731327245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLfhXe+DOk/Zvr718XsKSVZCtaQ0VoFVxnwJJzDWUIw=;
        b=Xg6TiatSQOqTyxVXajrgVhXE5z0U+xtM8NJkwdjqJ2BJSWZTAkHn3Yxr9kVsTMZpuM
         N57bBNIeQJ+qkw3if7tLag8cA8qf8UQ0mRYDt/5eh9vL1KibxOOzZMPKvemTJT7OjVxj
         e4J1uhYOv7DFclbH0t703joD+1VK8YYJIoQ5oEOYpNqmyED9IZ70twyhwnlY2DlIppdF
         rM5INUUclODH8TC7ORsh0t/zfhE0o7BFCCOSM8yVzRFnORXBF4JKGCDKf0TR29jklI2J
         nSkTTTpKz8UzapbFGsyM2w2AHlRrajUWgc9VNrtVcmFmK1AsugJBR2MZKXXcu3c16EYt
         5AEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSkFmNyf+FoJ29VnPdvWIk51kphP8sC5FiB6mzwPQQBSMwCUKvjfDvydS7qVJVO4O8up2VDv2wa1BGmIKn@vger.kernel.org, AJvYcCW1OQ8/zobVBwYBca8uiy9LQfI5wsClNoK8ksr5CE1B0gQWdwpbfj/ujtThH4B0cCurpfIz3XVparEVfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyotnqNlyq+OMIeuERH5S66kxPQTiJjTWjlSA/EV9R++t+ytFl
	Vdd56YcJH++o9RVT1HH4JBDNxIkRYw0bbax36Zuaga//jY3zh7sm
X-Google-Smtp-Source: AGHT+IEjEmNi1Mf4Lrwzo59HZaxOA4fUhH1eR1qk3q6/SqNWYRNG9+oN+bdCXPzY4FnI+PsKaQYCmg==
X-Received: by 2002:a17:907:2dac:b0:a9a:82e2:e8ce with SMTP id a640c23a62f3a-a9e6587e288mr1356965066b.40.1730722444776;
        Mon, 04 Nov 2024 04:14:04 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f71fdb00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f71f:db00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e56494052sm543350466b.29.2024.11.04.04.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 04:14:04 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: linux-block@vger.kernel.org,
	John Garry <john.g.garry@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3] btrfs: handle bio_split() error
Date: Mon,  4 Nov 2024 13:13:17 +0100
Message-ID: <20241104121318.16784-1-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Now that bio_split() can return errors, add error handling for it in
btrfs_split_bio() and ultimately btrfs_submit_chunk().

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---

This is based on top of John Garry's series "bio_split() error handling
rework" explicitly on the patch titled "block: Rework bio_split() return
value", which are as of now (Tue Oct 29 10:02:16 2024) not yet merged into
any tree.

Changes to v2:
- assign the split bbio to a new variable, so we can keep the old error
  paths and end the original bbio

Changes to v1:
- convert ERR_PTR to blk_status_t
- correctly fail already split bbios
---
 fs/btrfs/bio.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 1f216d07eff6..7a0998d0abe3 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -81,6 +81,9 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
 
 	bio = bio_split(&orig_bbio->bio, map_length >> SECTOR_SHIFT, GFP_NOFS,
 			&btrfs_clone_bioset);
+	if (IS_ERR(bio))
+		return ERR_CAST(bio);
+
 	bbio = btrfs_bio(bio);
 	btrfs_bio_init(bbio, fs_info, NULL, orig_bbio);
 	bbio->inode = orig_bbio->inode;
@@ -678,7 +681,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 				&bioc, &smap, &mirror_num);
 	if (error) {
 		ret = errno_to_blk_status(error);
-		goto fail;
+		goto end_bbio;
 	}
 
 	map_length = min(map_length, length);
@@ -686,7 +689,14 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 		map_length = btrfs_append_map_length(bbio, map_length);
 
 	if (map_length < length) {
-		bbio = btrfs_split_bio(fs_info, bbio, map_length);
+		struct btrfs_bio *split;
+
+		split = btrfs_split_bio(fs_info, bbio, map_length);
+		if (IS_ERR(split)) {
+			ret = errno_to_blk_status(PTR_ERR(split));
+			goto end_bbio;
+		}
+		bbio = split;
 		bio = &bbio->bio;
 	}
 
@@ -760,6 +770,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 
 		btrfs_bio_end_io(remaining, ret);
 	}
+end_bbio:
 	btrfs_bio_end_io(bbio, ret);
 	/* Do not submit another chunk */
 	return true;
-- 
2.43.0


