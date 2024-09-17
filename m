Return-Path: <linux-btrfs+bounces-8095-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4498797B4B3
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 22:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6228D1C22737
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 20:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A26190486;
	Tue, 17 Sep 2024 20:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VimV8Ftm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C04D187FF5;
	Tue, 17 Sep 2024 20:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726605234; cv=none; b=dDhTtlypUtxww68CDkL74qbKuVkxE0Ep7zMdoWsq4Thfyg8H2PhJVMl2mgIscmBD8izr3xiyhNhSXt/yCYFtRZJuWImZCBDZd0kNyJDj9P4Bp8fIdYJ8EeLPkxpq7UTwYEfihnjlihjc2fFR8gASX7ZiNVT2KSPac8O1TRy89SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726605234; c=relaxed/simple;
	bh=/tB73lCEwkWc8PVe9lLkqlvyICzGhv1+4G4VhJnAZCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YH6bQayAd7vf/17WDgLpASinEC05WuKHrr4iIHSBXyUkPlEGinRIEDIUCJgg054oV97yDoyKa13i8fjDVXyH9tMPZzVNGBmgjLbQSz3KKNg/LGqPFnaNyG20sUZWECTDL9uPG1OvPnIgsIMqaFIdzFnfw470oFBI9j9gmUrNUmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VimV8Ftm; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cba8340beso550035e9.1;
        Tue, 17 Sep 2024 13:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726605231; x=1727210031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2AT3wnKUqRlT6uiGl5yddAf+ea2CD+q5ywgEsXs62g=;
        b=VimV8FtmTjIp2oolDLhJ0i9mvudtbuIPjTGQDMiPbxcYtj70X8OHnDnxZwzx8fBBiI
         pI8rEjQRwPN1sOttkVtezdGYFA2+CKWjZCF3/GMfC7/sQMGOb/tvEh1SjMJnc/S6TGNV
         tl9Je08YhfnxoLPkPjGSDUtDcVRkv558f0Oe4n1RRQmp1IRuWria7T2FDCdUOSojNfr8
         O1J13AY6QjvbzvmZIzgflr4LBqdtV6gVXGRHBfo24wd0KnQUxklRume7wLe+1BXR6iuq
         XwglaxaRLrJWaujWpgECNC218xn3zHBs07FaIpSSbCuefRNhV2V+4lVbDgqaEseivcs/
         xOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726605231; x=1727210031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2AT3wnKUqRlT6uiGl5yddAf+ea2CD+q5ywgEsXs62g=;
        b=c/kmhKcsIaaRoMsdI853iOiSGVeqZzbEHGTMcqbSUuzYu91vzHZXz/PIaNuwN7jjna
         iWVZy/OqWM4g/Sgur0nlUDb95cU0i37Jdp+9z0ZOwhPJV0xYFuzT03ScHl0w4gwSPmVk
         fXTOOCw0v5ss5/DRHB+gpOTA07jFjMHsRmhd0GwWP0RHK/qX2YVqokB3lhQs446AUJc/
         9hYoL+TtSL/bC2SNt/uLTkuyN0BukodMxITiGTAqP2RxnmLlnrr0Zd9JVfJDHM05HAK7
         xkJb0INwUSQdFHhMWSO/ZkwnHeIn5ZDrK28TZ22/ONRFWtxd+xGPK+Dl63opeubAtWEQ
         iQtA==
X-Forwarded-Encrypted: i=1; AJvYcCU8ofZ4e/MtdzW4APcj31Qeiur8Kln4TDFpZu2hNcxL0/PG22Gvy3ah72e61FcVf8g/endCSX8RwxFCxg==@vger.kernel.org, AJvYcCXn7FL/Me0toZ2qcr1OKp8X5crZwoPYQrllSHoWSzDinWRUUrB7ERnp4tZuh61A/rFRqICqyVDJou8oR7z0@vger.kernel.org
X-Gm-Message-State: AOJu0YxSrXEcNuSsMzrjNO2HpnnoT7rr4+f3Ric1222ed5vmz4pVOZvs
	YdXLO1fOV2wiybYrKazFrTqwS6FSe6qTzH0jY22ERjCi7ZQs9nlmTyEPD771
X-Google-Smtp-Source: AGHT+IEpXgTw7WNZdI1ghUuNRqg+lU3bnzPkJoNQFhKbunxX9YpI0hVcnd44m53kwjaDV93DDUi2jg==
X-Received: by 2002:a05:600c:1c25:b0:42c:ae1d:ea4b with SMTP id 5b1f17b1804b1-42cbde1a51emr156416235e9.13.1726605230625;
        Tue, 17 Sep 2024 13:33:50 -0700 (PDT)
Received: from fedora-thinkpad.lan (net-109-116-17-225.cust.vodafonedsl.it. [109.116.17.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42d9b15c435sm148304545e9.23.2024.09.17.13.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 13:33:50 -0700 (PDT)
From: Luca Stefani <luca.stefani.ge1@gmail.com>
To: 
Cc: Luca Stefani <luca.stefani.ge1@gmail.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] btrfs: Split remaining space to discard in chunks
Date: Tue, 17 Sep 2024 22:33:04 +0200
Message-ID: <20240917203346.9670-2-luca.stefani.ge1@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917203346.9670-1-luca.stefani.ge1@gmail.com>
References: <20240917203346.9670-1-luca.stefani.ge1@gmail.com>
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

We now split the space left to discard based on BTRFS_MAX_DISCARD_CHUNK_SIZE
in preparation of introduction of cancellation signals handling.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219180
Link: https://bugzilla.suse.com/show_bug.cgi?id=1229737
Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
---
 fs/btrfs/extent-tree.c | 19 +++++++++++++++----
 fs/btrfs/volumes.h     |  1 +
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index a5966324607d..ad70548d1f72 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1300,13 +1300,24 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
 		bytes_left = end - start;
 	}
 
-	if (bytes_left) {
+	while (bytes_left) {
+		u64 bytes_to_discard = min(BTRFS_MAX_DISCARD_CHUNK_SIZE, bytes_left);
+
 		ret = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
-					   bytes_left >> SECTOR_SHIFT,
+					   bytes_to_discard >> SECTOR_SHIFT,
 					   GFP_NOFS);
-		if (!ret)
-			*discarded_bytes += bytes_left;
+
+		if (ret) {
+			if (ret != -EOPNOTSUPP)
+				break;
+			continue;
+		}
+
+		start += bytes_to_discard;
+		bytes_left -= bytes_to_discard;
+		*discarded_bytes += bytes_to_discard;
 	}
+
 	return ret;
 }
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 03d2d60afe0c..c15062a435bd 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -29,6 +29,7 @@ struct btrfs_trans_handle;
 struct btrfs_zoned_device_info;
 
 #define BTRFS_MAX_DATA_CHUNK_SIZE	(10ULL * SZ_1G)
+#define BTRFS_MAX_DISCARD_CHUNK_SIZE	(1ULL * SZ_1G)
 
 extern struct mutex uuid_mutex;
 
-- 
2.46.0


