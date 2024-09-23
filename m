Return-Path: <linux-btrfs+bounces-8157-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BAE97E623
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2024 08:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9427BB20DF3
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2024 06:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF47286A3;
	Mon, 23 Sep 2024 06:46:06 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AF379E1;
	Mon, 23 Sep 2024 06:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727073966; cv=none; b=Hycanjuj78s/6G+ViFl9jaDYffv8DZ0ZeCzq6mEJdEKGWPC2U4Nql9M133LcLnMAyEfoJCra8ma0Qgfr5e7rk8WbYCdm6VKyaLeRdtsZuGhqbc7BYzXmw/4KzlDMwKMo6D/3qPaXZ12Nf8i+WGzZKY17k/LKlCIaf6p/c2qlOAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727073966; c=relaxed/simple;
	bh=bxptygOmMcq1Bshzz4RYiW48dnfzATZyXLTCfFFN0mg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sZ9J/bTqhGiXw/SEwQxKhfV2rnFspBT224b91QkOlp9qWruxkHiHaeySv5AASoS0yZxl/0YYVVANbT4eHyG6QEgirNv8WJX6NMS/EWAzMiyLQcC1a2bhqkI+OVP01T22ovLiWAqBR2jX7XM3zcvkcpsXbJGGrO4dUGyeYVbF5/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cae102702so30826865e9.0;
        Sun, 22 Sep 2024 23:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727073963; x=1727678763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zo0dAkRT+AqYG1gzt+JV1P2irG7GBbHX1QJ390D0754=;
        b=duTbAGiQLdz5CLG8r2oajFZRLrqfAFCkgCBCODuBBexJ6zxj6dCsY3U5lUftTHvuJV
         Rcj4W44Wx1asb3SI0hO2Y4Q1q5ICCpr0U95ybeC4o35oSs/LF75bgajFTBLiy0n21fll
         o7eaDpbW1MvXCVC61p38LRtTgUXpX7us1FdWIEsloM9uAFLAEEhK5imo/gbamup0fuhZ
         khH/aLrFoSfSSj9CQ8flkLPsMF5ml0TfkcLOJolYsBud5U5XlveSdI6NYgAWfFt3da72
         t0wyzX0TIVuXT7TffjgEYXnWu9krrch8Y5VlliZ59qDrxIHqDYPRUFyvKYLnkukA7gIt
         bzEA==
X-Forwarded-Encrypted: i=1; AJvYcCUA972acPA7XwCd0eF5DKCd/XxEGZDK4V6cnqipNebS2uH8nnFhm1R0pzezRTrDvVVkkChxm8SWDsF8Yg==@vger.kernel.org, AJvYcCWO3SDvHh0DwnzauczgV84MOQ9YiuUFRLDAkziggHp6Ewn+iYQQIz/Ng2yFGoGKd4hfkQ7aWS9WQzVIo0SG@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcra+xleT5z9uqGbEXQDnznB/PAButASNdchysOEniVUcavi31
	K0SDtbwNeI3FuEYI8Sylqkm+6MjOWgqd91WLrvt6OBZd3VfsZPuZ
X-Google-Smtp-Source: AGHT+IEKPyeK5mIXRlxhwKWGqU6n+Ro2HOWCIbCN6lazV3i33jLAoLGKysmTcDxbDc4V06y+y+2taQ==
X-Received: by 2002:a5d:64e1:0:b0:377:2df4:55f6 with SMTP id ffacd0b85a97d-37a42265576mr6872513f8f.17.1727073962704;
        Sun, 22 Sep 2024 23:46:02 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f72a2100fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f72a:2100:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e81cbsm23547838f8f.28.2024.09.22.23.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 23:46:02 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Qu Wenruo <wqu@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: also add stripe entries for NOCOW writes
Date: Mon, 23 Sep 2024 08:45:47 +0200
Message-ID: <20240923064549.14224-1-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

NOCOW writes do not generate stripe_extent entries in the RAID stripe
tree, as the RAID stripe-tree feature initially was designed with a
zoned filesystem in mind and on a zoned filesystem, we do not allow NOCOW
writes. But the RAID stripe-tree feature is independent from the zoned
feature, so we must also allow NOCOW writes for zoned filesystems.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/inode.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index edac499fd83d..c6e4b58c334c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3111,6 +3111,11 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 		ret = btrfs_update_inode_fallback(trans, inode);
 		if (ret) /* -ENOMEM or corruption */
 			btrfs_abort_transaction(trans, ret);
+
+		ret = btrfs_insert_raid_extent(trans, ordered_extent);
+		if (ret)
+			btrfs_abort_transaction(trans, ret);
+
 		goto out;
 	}
 
-- 
2.43.0


