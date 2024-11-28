Return-Path: <linux-btrfs+bounces-9946-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3659DB4EB
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2024 10:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3AD8282688
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2024 09:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CB0157469;
	Thu, 28 Nov 2024 09:42:23 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F6B17BA5
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Nov 2024 09:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732786943; cv=none; b=hbDxD2yFnsMp5PzxHorGdG1AcruXhsTtDUvjP8Veck96shBhMlgtXo80k0JqyiCFtlwd0od4skTTDJ8/qPtcVbXhav4p/VczrXSfCQZDXFDWRACrC9wLE052D4qfOAZQJmoayqtZ/LHr3FrqEVDfslSN+z1uR04G9lRQuRiSnl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732786943; c=relaxed/simple;
	bh=vQry+iYnBCca+ZE7tpjoW/J+qd69yUxECAcRh8VxFnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OiO6oVbDnoyqpGYctNthsXf9oDJJsqI1jv1OyWfqfdWu6+UENDc4xG2punHZowZHDb4qMzBqrpTRwTb8i56fZTK9PAmNSuNQRbPGa4cOOwIZwiWQxRDPXzAmQyr61EhD8l72ecvu6YbQ5DA4nYmSFC8BlF6splLxnKTdfbRsZig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-382433611d0so562307f8f.3
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Nov 2024 01:42:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732786940; x=1733391740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tMRhgdNe7p5hG2RuCHIsEX6hQVqRXijMvdFo86MDDE=;
        b=vc7dS/n7OTh73rFq/uQ4Dx8y2HQSu/CeRHvWCbOxqqcJYE+LQJKD8hFVFWmQZxmYMa
         74EG0gkJjMhjJZF+aOrvSH1ME6+FTsRader1qPRowqpxzOrWh0eB8qgdh5Kl7vYNnYoS
         f8JvUEhJ+xcskd+xtr9GKfSsVxZBPwjcfY9VtDSYu9Hobj25NlkfXN/K0vnddfbcV7mU
         dkE6h19XTbdS+bOAboOOSVQRQSXyrqS+JmPFA8dSmGPVnGFAznWFhrdeJbZagL+DAtaY
         Yg/PIia4Uhz4tkH8/tw5F6xrfmG3Hb6V6YJK7OZwPWuxBaGygS7BiC4nqYeZkGJGVtnd
         E5gA==
X-Gm-Message-State: AOJu0YwMmI4SGnKDX43bX/xjzM30V4PMOwOo2YP34n2Kq2NgFg7kYCOg
	3e5XBt2voJcPARmbBvv5HKr0yK5PvXDenM88YRK1jpLjYRCkF6fJvYAVFw==
X-Gm-Gg: ASbGncua1Zs2dg/S0u3p6lP6pNpjBV0WMJJRxlesMvlOJ6fr784T4FwP2PjZK3etZYY
	wlbi64speLZr//EwIj+SD7IhSLU7ZYkIVo09BEbURjlacs4sCYbCerPRKr7ls3bqzpuetsbkIa4
	2LrjpLLGgBp6FbqwYpst55AnbmgrBkzESXBmXs8b5mhGpRLRbK+HC/bFuMRx+KaVbFpVDHf5C/+
	8V445lF0H2z4VWYpAlH8G6FtJ9LlqDiqPs5tLiNcO8uk8JWemI08bPvdNc62ZjP69qkDXaoAHIM
	HyZDqeheCCB/XyTIQHQdcwjdRMuAomTy
X-Google-Smtp-Source: AGHT+IFjNQ3LzGC3ze3KKpWxcbcakBHonSAby8jsuCduXfhrT+P+Gmfj3IBWALkG7vQc1uRAjX7KsQ==
X-Received: by 2002:a05:6000:20c6:b0:382:4e5c:5c82 with SMTP id ffacd0b85a97d-385c6eb785dmr4641065f8f.14.1732786939344;
        Thu, 28 Nov 2024 01:42:19 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f7081700fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f708:1700:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd8017csm1161364f8f.101.2024.11.28.01.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 01:42:18 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4] btrfs: handle bio_split() error
Date: Thu, 28 Nov 2024 10:42:01 +0100
Message-ID: <3b491cb4fcb7c34bd8cd5265871ff115395fca79.1732786874.git.jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Commit bfebde92bd31 ("block: Rework bio_split() return value") changed
bio_split() so that it can return errors.

Add error handling for it in btrfs_split_bio() and ultimately
btrfs_submit_chunk().

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---

Changes to v3:
- decrement bio counter

Changes to v2:
- assign the split bbio to a new variable, so we can keep the old error
  paths and end the original bbio

Changes to v1:
- convert ERR_PTR to blk_status_t
- correctly fail already split bbios
---
 fs/btrfs/bio.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 1f216d07eff6..af3db0a7ae4d 100644
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
@@ -678,7 +681,8 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 				&bioc, &smap, &mirror_num);
 	if (error) {
 		ret = errno_to_blk_status(error);
-		goto fail;
+		btrfs_bio_counter_dec(fs_info);
+		goto end_bbio;
 	}
 
 	map_length = min(map_length, length);
@@ -686,7 +690,15 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 		map_length = btrfs_append_map_length(bbio, map_length);
 
 	if (map_length < length) {
-		bbio = btrfs_split_bio(fs_info, bbio, map_length);
+		struct btrfs_bio *split;
+
+		split = btrfs_split_bio(fs_info, bbio, map_length);
+		if (IS_ERR(split)) {
+			ret = errno_to_blk_status(PTR_ERR(split));
+			btrfs_bio_counter_dec(fs_info);
+			goto end_bbio;
+		}
+		bbio = split;
 		bio = &bbio->bio;
 	}
 
@@ -760,6 +772,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 
 		btrfs_bio_end_io(remaining, ret);
 	}
+end_bbio:
 	btrfs_bio_end_io(bbio, ret);
 	/* Do not submit another chunk */
 	return true;
-- 
2.43.0


