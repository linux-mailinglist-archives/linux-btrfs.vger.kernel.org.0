Return-Path: <linux-btrfs+bounces-10317-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BFB9EE723
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 13:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DB491886E03
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 12:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288F82144BD;
	Thu, 12 Dec 2024 12:54:54 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EDE214236;
	Thu, 12 Dec 2024 12:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734008093; cv=none; b=IYZlujOs+j15A+BGTik6aENJ50kGrygtSCoVlLCyKDxQIUH07ZtF6kzAyiG6au9M1TSRm/dZNPj6XjaYgw+0Jp8NsYC+m2K+FZrbyYBxNXC/4kfJ/f3e9YjnKIhRD3Fg1pdFXIfURVcZaw4R8Ed/cdCfPZYSpx9FCs4aGNwbTRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734008093; c=relaxed/simple;
	bh=ehiwohuVozwTI+2huPsJ4SX1bw2G3Og2BiDEY0kWHlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oUA471hpS3FYJ2BPcFPx6GF3Ps/3XyClomg9k44yPZzNCqAZ1cYsJZRcc3UT93vK5Idq8uoNQTIs4rwA682m6su0pdYorOIxuHLC17elZL9sxZI+Ko6qo6qx1hAiAHesyQjIXLTwtgIIR1Xqkjd8qD1X2Aa3zWvPlLmO+W48DsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3f28a4fccso823546a12.2;
        Thu, 12 Dec 2024 04:54:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734008090; x=1734612890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HcJcEN7t283VckUD+iHCuwkxl5YnOdBeEa9iNyBsUSI=;
        b=rVQgmGkSIChPczEm2g+0GIINP9815x8TIXBaWCQi45lEja8XMnkdvwqDqbgEhs7N0u
         HDpYg7WItb+oOH5jclmjC3Qc1c9JG8/sXmvP7i7Wl6U9nsQalFwZvoUwCTkEK7U7VLWF
         Gp/xrxVG7sR+fXt5oO5BtF/8FgmFO0wr7AG97+AGjShWeBcxsczucCwROztHw8xkpCvA
         opAxWDNEjdc+1yuGF/G0iymr03ol6jib9N4dgD8d1ojOQeZwTa/TNBz8IjYBrLXtLtRo
         XCzO/kMBHk2ay49NrZyiSMrvk7rDFJq3yKYyIOg7YI+Qtm5JXGFDJnKBH3gmhryjM9AP
         9x1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/Pb2W6v5wq1IWD7+E8QPxdx7saWPzu/dXrdcBaB9/nExB9Xa5nHL2Fi88xTuBUFwFs5R3oRaRbttLEQJ8@vger.kernel.org, AJvYcCWh1/WEZ0/eL8RuqvXzlaQujjYq9SZDUYr6lTr0q3HzfJva8kV3ueKmnzSjvT+zLe0wP9bytX8bfYE54g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYVTrdxti8oGZCuW7QxBbSukQn9nfcXzjHOZqaWuilGz3NOlzx
	AfoR0wNZEe6yqpczihKy3wA6HDmgtoxPvOiRJewiFWzWwnN6jkyc
X-Gm-Gg: ASbGncs0jlhs7pN/ZcFOtqV9+/V+/Ayg6IgljWHceJyMqWQljyk1N/ckeqyUghMFnJl
	nYwZ9zooZzWyREIOJRkOiVtR1E/ntJdbl4NlonXhn2sXjohl2FrMQJ8hbowhQRrjLjGZ6qkA6xQ
	2cytJfA4GGeaWlFsi2Mjn0CQzEWoNP23K3Qz/XVrmhZnUt5fyCBCSKP8s9mb2eOGvHpKCv1/4s5
	lUBU2jHVW6QfddZHF2Ml/HTYCPhsx8VlQhGk/7VtolXvSmxbaNX1BGo9MWtJUVmoz+p5uX7I5Fz
	jBtyvzo3AKsQ/Pz5E4hOuuw9Az3PvmvlRavcUjg=
X-Google-Smtp-Source: AGHT+IGSjNa9QUN1494FSKSv5mCuYUwFKonxrdaSNxMKHuVR1Ha7kz21TA2TOicxprW3fDcL5eOZSQ==
X-Received: by 2002:a05:6402:35ce:b0:5d0:b9c7:479a with SMTP id 4fb4d7f45d1cf-5d6337dffc9mr153108a12.25.1734008089993;
        Thu, 12 Dec 2024 04:54:49 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f7081700fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f708:1700:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14c74c3d5sm10309638a12.52.2024.12.12.04.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 04:54:49 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Johannes Thumshirn <jth@kernel.org>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johannes Thumshirn <johannes.thjumshirn@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 1/3] btrfs: cache stripe tree usage in io_geometry
Date: Thu, 12 Dec 2024 13:54:26 +0100
Message-ID: <20241212-btrfs_need_stripe_tree_update-cleanups-v1-1-d842b6d8d02b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1536; i=jth@kernel.org; h=from:subject:message-id; bh=DISFLb+CmKpum56sSEBO4U3wTr62J5bLTzQsVr4YvlQ=; b=owGbwMvMwCV2ad4npfVdsu8YT6slMaRH3XnePaF1Vujy476Hl/zTPzBbZdcGb6PJfx8IrZjPn zuz8kQPU0cpC4MYF4OsmCLL8VDb/RKmR9inHHptBjOHlQlkCAMXpwBMZFkPI0OXpkb070/VVoz8 IhvvTvky++yVj5eiP0Qw3k+bd+zKOa8CRoZ9a4IrmNmNs5x/W/luOm2tIBnhN/vfky3HzS6tdry aoM8HAA==
X-Developer-Key: i=jth@kernel.org; a=openpgp; fpr=EC389CABC2C4F25D8600D0D00393969D2D760850
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Cache the return of btrfs_need_stripe_tree_update() in struct
btrfs_io_geometry.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1cccaf9c2b0d5d4029440c46a4a92c7d6541d474..fa190f7108545eacf82ef2b5f1f3838d56ca683e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -48,6 +48,7 @@ struct btrfs_io_geometry {
 	u64 raid56_full_stripe_start;
 	int max_errors;
 	enum btrfs_map_op op;
+	bool use_rst;
 };
 
 const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
@@ -6346,8 +6347,7 @@ static int set_io_stripe(struct btrfs_fs_info *fs_info, u64 logical,
 {
 	dst->dev = map->stripes[io_geom->stripe_index].dev;
 
-	if (io_geom->op == BTRFS_MAP_READ &&
-	    btrfs_need_stripe_tree_update(fs_info, map->type))
+	if (io_geom->op == BTRFS_MAP_READ && io_geom->use_rst)
 		return btrfs_get_raid_extent_offset(fs_info, logical, length,
 						    map->type,
 						    io_geom->stripe_index, dst);
@@ -6579,6 +6579,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	io_geom.raid56_full_stripe_start = (u64)-1;
 	max_len = btrfs_max_io_len(map, map_offset, &io_geom);
 	*length = min_t(u64, map->chunk_len - map_offset, max_len);
+	io_geom.use_rst = btrfs_need_stripe_tree_update(fs_info, map->type);
 
 	if (dev_replace->replace_task != current)
 		down_read(&dev_replace->rwsem);

-- 
2.43.0


