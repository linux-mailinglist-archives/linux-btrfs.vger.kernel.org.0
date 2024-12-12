Return-Path: <linux-btrfs+bounces-10319-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4D29EE727
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 13:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844ED16643D
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 12:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760292153DC;
	Thu, 12 Dec 2024 12:54:56 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47EB2144A6;
	Thu, 12 Dec 2024 12:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734008096; cv=none; b=BeD0itVQd2WmWvqw/LTDvmHnYXsEGnQcXgcOAlZJx+jvrWZFoswth5SbIN0V/K8G+uBeYc65VRwWtUh8uC3Z7PKGjbULZWQg1RE6paJhtgOgTWHSTFf0vrAjHmHL4aebB06f5wO9XzICVrEmW1c23RG+5Il2u3Og1ypi2ejBFNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734008096; c=relaxed/simple;
	bh=2j55y+TneVx+D6nV4rwWdHfLRaHQY6AlVlT8u10YDvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1gRi5BZ+RzV+jKrBqwLYDKq6C2rQAcwzXjrN7Pdfl3RZuut/WiWBycSmZQNnHw4DGVFPg8QBFy6tsba5PSSklKTWtDp33oHobScehHCayXcWUG0pHWE5Kjcw46aoTbzowaZF2932Tv9ESuiFmOTiWXKpQ9KOilxBwTyVd1vbCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d3f65844deso896448a12.0;
        Thu, 12 Dec 2024 04:54:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734008092; x=1734612892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0/JgBYDqksM8PvqpUI3FsZWQKGnr3QspWVFYX5vYJ0=;
        b=TNwqtqL8P0bcbJ3W/hcHq9CnxdMBuY5N/9wpCKzdd5TAZ43kvycBqVpqAcn0jMZ75A
         34HncHm6swOH3DTjHW7hwR5wkSOU1gGAvADKLOA8o5r4vLXEo7xcmVXY6PJnNystOYAm
         FqToMIPYF+xlMdF5RbnQ+ksrY1f2smpq1v5DFLMwKKdKK1T3NKEnMWtKjus9OZKxGkQZ
         2vXdmzNx8hhU0xMZM9ra0d+LyoOfojYE7tBr3aOeSxnS2dpT4Uf2f6RZjY5TeF8LMh8t
         Nn8Posc//6Nhu3RaXzifPzPwAcFvvovxZ0PbwfkgOTNVrtX9N64zQIdVfTJcWfR2Veh3
         M1GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKB+GowHhkWdRRHCiGzXwITtEpM76yDowA2qIXFYjI3Y3gScxSL8oQhYu0c6ehDj0KiXcXLxVsgAVt1UA2@vger.kernel.org, AJvYcCWx5II/n32WEI8Lf9g9l4CF4xkZR7gzjXI7bZyxGLhVim2EwPN0Q7Pspeb6q98Bs1sif2AvWTZu2j6anQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5nYMxBpLU2MW9O4IRd3yrocAHE2mL2ILlCYM4IZZae5VPOLhn
	I+FEPWsb1FHzP8csEJmK4MTnN5K/8jqDSa5n7h708I9is8IQ92j1
X-Gm-Gg: ASbGnctkGqmDlXBdzl12EvyEhpVUnAC53OdGqMyLaE+ffjEzkEvV0MZ0YbwGtrbmv6E
	EgcqWjlI3BEEwt/1LvDPMOzZ1OD4oanRSjBC4Jvof5wYQH0EEg0xOAklj5TVD3KAF7sHrph0b/p
	awz/NT8FRZG+FiVN1ErwTGf1GT1kHfH5jnbivtyvQu7VPRsk5wJBHKZOZQWJtQCIu5EM/BZEVza
	PyPZebaMBhEwTmnrOAPnChpH9uskx2rHn5YfwCMw4glAqBXUnksqUSjaJpeHxKcKDGN/cyJ3Oca
	fbVen9ZOTu6oe3hpgviwXz0Tzs3C2aXIv9FiyF8=
X-Google-Smtp-Source: AGHT+IGSeHNoc3AEk5gaJaYGuFkZxb9V2fX+bmLgZuixpkZHrLmG0IJdf3bA9eh+GSlahZ75c1Bbrw==
X-Received: by 2002:a05:6402:4588:b0:5d4:34a5:e2f4 with SMTP id 4fb4d7f45d1cf-5d633eaf220mr125358a12.31.1734008091962;
        Thu, 12 Dec 2024 04:54:51 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f7081700fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f708:1700:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14c74c3d5sm10309638a12.52.2024.12.12.04.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 04:54:51 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Johannes Thumshirn <jth@kernel.org>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johannes Thumshirn <johannes.thjumshirn@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 3/3] btrfs: pass btrfs_io_geometry to is_single_device_io
Date: Thu, 12 Dec 2024 13:54:28 +0100
Message-ID: <20241212-btrfs_need_stripe_tree_update-cleanups-v1-3-d842b6d8d02b@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212-btrfs_need_stripe_tree_update-cleanups-v1-0-d842b6d8d02b@kernel.org>
References: <20241212-btrfs_need_stripe_tree_update-cleanups-v1-0-d842b6d8d02b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1908; i=jth@kernel.org; h=from:subject:message-id; bh=Zb2mLlr0+jNyUX4pYR5ND5op1LwqKFpwsUju8rkXRmY=; b=owGbwMvMwCV2ad4npfVdsu8YT6slMaRH3Xmusyhj/uzYoumWvxOSTn867nSoLy/Mk22he4V1y s1Hm+aYdJSyMIhxMciKKbIcD7XdL2F6hH3KoddmMHNYmUCGMHBxCsBEVoQxMkwXZjjA8+DQQ/7W 4nkqT/KX8stVrH2+u2q78KsCo6Zj8woY/ll4SISut9/1c+tZlZulv3aK9tdcTtufdeDTVbn2jpw 78zkA
X-Developer-Key: i=jth@kernel.org; a=openpgp; fpr=EC389CABC2C4F25D8600D0D00393969D2D760850
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Now that we have the stripe tree decision saved in struct
btrfs_io_geometry we can pass it into is_single_device_io() and get rid of
another call to btrfs_need_raid_stripe_tree_update().

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 088ba0499e184c93a402a3f92167cccfa33eec58..3636586371f6de2df76ecc67c2dbf2fdf3848995 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6362,7 +6362,7 @@ static bool is_single_device_io(struct btrfs_fs_info *fs_info,
 				const struct btrfs_io_stripe *smap,
 				const struct btrfs_chunk_map *map,
 				int num_alloc_stripes,
-				enum btrfs_map_op op, int mirror_num)
+				struct btrfs_io_geometry *io_geom)
 {
 	if (!smap)
 		return false;
@@ -6370,10 +6370,11 @@ static bool is_single_device_io(struct btrfs_fs_info *fs_info,
 	if (num_alloc_stripes != 1)
 		return false;
 
-	if (btrfs_need_stripe_tree_update(fs_info, map->type) && op != BTRFS_MAP_READ)
+	if (io_geom->use_rst && io_geom->op != BTRFS_MAP_READ)
 		return false;
 
-	if ((map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) && mirror_num > 1)
+	if ((map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) &&
+	    io_geom->mirror_num > 1)
 		return false;
 
 	return true;
@@ -6648,8 +6649,8 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	 * physical block information on the stack instead of allocating an
 	 * I/O context structure.
 	 */
-	if (is_single_device_io(fs_info, smap, map, num_alloc_stripes, op,
-				io_geom.mirror_num)) {
+	if (is_single_device_io(fs_info, smap, map, num_alloc_stripes,
+				&io_geom)) {
 		ret = set_io_stripe(fs_info, logical, length, smap, map, &io_geom);
 		if (mirror_num_ret)
 			*mirror_num_ret = io_geom.mirror_num;

-- 
2.43.0


