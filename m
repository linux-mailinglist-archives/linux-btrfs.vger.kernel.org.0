Return-Path: <linux-btrfs+bounces-7775-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7569696950D
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 09:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E28D9B22249
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 07:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4595E201275;
	Tue,  3 Sep 2024 07:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M06K5cS2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3C91D6C78;
	Tue,  3 Sep 2024 07:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347803; cv=none; b=aPTwP0qNVTN82c8hll50qgBQHa6qFDVY/ZcGtZvM4eWs5LeP2WuabQfUGGSu40FLtUaQ8T8P5ooU8faUZzsA1BTz35uiqIy8HD5syyJNF66Y/PzlDyQLOCNSdrDv/kY6cCb1NoJVttSrH0enuXhenZ18zBAmCEF1IaUQR9xwhf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347803; c=relaxed/simple;
	bh=ThNtPFXL57A51d99qaXTeauCFubif2+4fiwjdImBiJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twGpJFnUWoZyFThNlkLRfR3O2uuiF8iBAJwGlfv2dMquvXQpwJCmVlDht/bD+UTdgAi+XUE+BntTRFpJIb/07rcXzdZUFBqFBqX+4/thKECSd7t4PrQbNBcjNK0diyrwYhDHng+dkuXUrAc5LpjU4d724Uf4xl7vi46cqKEp6CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M06K5cS2; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42bbf138477so28551895e9.2;
        Tue, 03 Sep 2024 00:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725347800; x=1725952600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryqZJRWkyu5qx2NdJr7139fCsE/EdmFwuSbUl8OhEdM=;
        b=M06K5cS2Pi5CnKgu3QJ+hx26Ry+TLKCacSGUg7Qy7BWaLDY8fMii/NbPXmUI9Isdb9
         92CgM332beOntqelnYfsinqV9YJiXHM0WteXL4XBJQ+za8Sw5W4+pQ7mltWNbP/9BqOh
         qRyZHesLmDPAlLN9O05ZyCmOwD8khgf2C0SVxlq001shMwm017cfRyM/Bhmgs5Y4qTE1
         OfsqUOFrmeR/6u/ezui4DkVjvyYxiE9xjWf8mxh9ZqC2ydM9gVtDJbLlkhLJwhvaDNKd
         MW3tJI4A+6PGc3afhswR0L+cZQUV8QkcywfdClkDSTXA6swBG8FdW/TrF1tgc+paJj/G
         m+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725347800; x=1725952600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ryqZJRWkyu5qx2NdJr7139fCsE/EdmFwuSbUl8OhEdM=;
        b=FQyT+55YBv2wAbeLgLZUJ3Nm1zR64bcDMMJkbIMAr6SXs+fQHTXGun87qkeKRbqhBG
         +GWp8f0moXQkcbxnUY1NRV6v/Uixx9zTcHbOXyQiz8e8i7c+TDDxG1T9DTfMIt6bkL1l
         M0TzAUGIBGEnAweJnpecOr4ZlFXv75SS1OeVgMbsvQPyfUi/iB+T7c9cB6ExReR6KZDy
         KjJLasLuSKs9nv7/Pyz25yeVpOd/RHHSycfwtEND59cgoCslQ6hiYzgwBMiTzOeJXvB3
         E9sZ+UkGDLOMAAAm3BNiWcn63GMJEfms90hmtaQSaUhpY+5FajZE3bqXAN4I+HYK745i
         85Pw==
X-Forwarded-Encrypted: i=1; AJvYcCUFuDiAq0YP721RI2dXloCGwut0ihhJvATO1Z6FBqdh4IWMq4nd/H7qnNq+ueNjxEkKX43anWjD6hHFUw==@vger.kernel.org, AJvYcCXQujuKVvWEMd6gSZMBzFlngOnM5zhUELbyOVBNjM9USnaWDd6xV7KFhHH+EvDg4NGhsnbERRropvqFSRdt@vger.kernel.org
X-Gm-Message-State: AOJu0YzNezAoTVDtex941XmhoxOD4s5zDECywLwP65rcCMKaqRhUjZHw
	35yVhxp6uJ3JBWFT3KQUXPWDzo97m5SJdNjyyrByYVdgSEEfFTZL
X-Google-Smtp-Source: AGHT+IHclp0SP6+Nzye3WHRy+v0L2cVP+Ta1KlUQWveQ37LmGxy/YIEIQll5uQnwvAankg4Dmg/vAg==
X-Received: by 2002:a05:600c:3b08:b0:42b:a9b4:3f59 with SMTP id 5b1f17b1804b1-42c880efb93mr16434265e9.14.1725347799827;
        Tue, 03 Sep 2024 00:16:39 -0700 (PDT)
Received: from fedora-thinkpad.lan (net-109-116-17-225.cust.vodafonedsl.it. [109.116.17.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42bb85ffbadsm154349815e9.12.2024.09.03.00.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 00:16:39 -0700 (PDT)
From: Luca Stefani <luca.stefani.ge1@gmail.com>
To: 
Cc: Luca Stefani <luca.stefani.ge1@gmail.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] btrfs: Split remaining space to discard in chunks
Date: Tue,  3 Sep 2024 09:16:11 +0200
Message-ID: <20240903071625.957275-3-luca.stefani.ge1@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240903071625.957275-1-luca.stefani.ge1@gmail.com>
References: <20240903071625.957275-1-luca.stefani.ge1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per Qu Wenruo in case we have a very large disk, e.g. 8TiB device,
mostly empty although we will do the split according to our super block
locations, the last super block ends at 256G, we can submit a huge
discard for the range [256G, 8T), causing a super large delay.

We now split the space left to discard based the block discard limit
in preparation of introduction of cancellation signals handling.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219180
Link: https://bugzilla.suse.com/show_bug.cgi?id=1229737
Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
---
 fs/btrfs/extent-tree.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index a5966324607d..9c1ddf13659e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1301,12 +1301,26 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
 	}
 
 	if (bytes_left) {
-		ret = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
-					   bytes_left >> SECTOR_SHIFT,
-					   GFP_NOFS);
-		if (!ret)
-			*discarded_bytes += bytes_left;
+		u64 bytes_to_discard;
+		struct bio *bio = NULL;
+		sector_t sector = start >> SECTOR_SHIFT;
+		sector_t nr_sects = bytes_left >> SECTOR_SHIFT;
+
+		while ((bio = blk_alloc_discard_bio(bdev, &sector, &nr_sects,
+				GFP_NOFS))) {
+			ret = submit_bio_wait(bio);
+			bio_put(bio);
+
+			if (!ret)
+				bytes_to_discard = bio->bi_iter.bi_size;
+			else if (ret != -EOPNOTSUPP)
+				return ret;
+
+			start += bytes_to_discard;
+			bytes_left -= bytes_to_discard;
+		}
 	}
+
 	return ret;
 }
 
-- 
2.46.0


