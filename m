Return-Path: <linux-btrfs+bounces-14906-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 391F8AE60FB
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 11:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A76A27B38BC
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 09:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF01A27EC80;
	Tue, 24 Jun 2025 09:37:26 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DFD27C179
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 09:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750757846; cv=none; b=OdSjyvLptOwO5RzLtqMYQNACsCBNeRjGB7YClC8/F1h7Q+VCZ9WJHA9DJnRXdgV4GYP2C1FeO+S5GTYvdrvCOl+6PeUZxv2W9p197h2JHgoUX9JVUO7vLM7PC/ml6ZIKgQIgxqwi8bipYcU6LGHV2K4PepMNNL24Jt6lp6JyGBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750757846; c=relaxed/simple;
	bh=lpLN6lB5DbyqbfcG2sHrpxA7tjv2fEfeeRIGhf8Mv1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uuHk10aJWW5Q05EjJ5HEG8h9FdZ7LJsAMWk6Sed9fvlYemZ4F8z4WybehsLK9cMbopeC9WlprwcQQyqAkqqPtKZ2tsBU6Nd8bMWp0TiBjMmldZ3h9u53NTJgplVEjdTnQb/Rqtj0cmENY9dWHcGd/Dff1K0L8CZzQUk/kgFrTEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4537edf2c3cso2272915e9.3
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 02:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750757843; x=1751362643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2j7fFL/zhx0WJUPGHtR7dJiSrwn/Fg7cJ2D7UHOlqEw=;
        b=rFZppCZGJeBpFKQUBu11g9IrXwwl26DICpVzItD2YVleVrP5rgnFcBxL6vq0LxwBdu
         0AoYzy3+2vMqYNJolnx1/JYlidQyOAwIZzdP2cLzyZdSIAuJzq0wM7yYT5/vuxlFobbG
         lbWliaGLte00StYIZ1vrfzsT0BoZTN4rjJJx4kiMZzO0IyZnRPpyXFVqMFXN4fj5cYaf
         cHYFtEsKdtUIgqsfEhMvqoV3b+eCezD2kjwyD4pbi1OHnrVPM407BPdzBI8CfEoPe9no
         +lfszKtwn86WcJVXWYDdZESDURrSKpQqLfdyU77HZLQdtNmFpBphBgOff6wZ9wFNSkMj
         c8RA==
X-Gm-Message-State: AOJu0YzOAjvruLmDFysI00evgkfx7AJZhCoNv2FbiXN/Jt872k12Zjh/
	RwjQ5uZUwxrEbA/zMHtgf5HFKcDYQmZ3J8h21Gadt4MBv4h1DLAl/GoYfx9pk3jy
X-Gm-Gg: ASbGncuuAI8UCXreBrGUDya0q2n4W8lsAtTBjVO2CkjA6qYqTvO5uTpQg1D20BaHG50
	CBsAdPoK8Q2B6E8Zb07AWuiWjw9ANWiPVeJpA5ahyUxmbQi2RtixxjcW99SMlSG9r4rsjw53Af1
	rfHAi3/sGOfKrzLHlxlVyouUIY+n3Gc4edqnruafV/irI6LSri0vRtXiWQwlnFLGOo8w/L/rM/y
	tuBOx6fZwegXOAIzR9zzH+9HA1sfgH4nHfQ5U7sFRobfe0RRSRqKcHbzZv935SJOLum1wJNUEun
	xG1TtAnLoIdDf4WlVYGOk7oPm5oqUcSznrfA9U0r3l7Wu52g6EwpljOY9CIJXk+RVC6P2EHNvBZ
	Zg8RA1ha58fQjWqQMkXeft+IAggQYeQBfJnLYEeoiUtibxwl70Q==
X-Google-Smtp-Source: AGHT+IEcsizhZLI7jxuduomZNlSsgToNi96t8Ghx53/SMOhoPPP7fV6+A8D0uX7JOMG3hlRV4h66uA==
X-Received: by 2002:a05:600c:820e:b0:442:f97f:8174 with SMTP id 5b1f17b1804b1-453658ba2d7mr166479865e9.18.1750757842734;
        Tue, 24 Jun 2025 02:37:22 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f734a1006f354b1e839513ef.dip0.t-ipconnect.de. [2003:f6:f734:a100:6f35:4b1e:8395:13ef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453769da7f6sm54880745e9.40.2025.06.24.02.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 02:37:22 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 3/3] btrfs: zoned: don't hold space_info lock on zoned allocation
Date: Tue, 24 Jun 2025 11:37:10 +0200
Message-ID: <20250624093710.18685-4-jth@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624093710.18685-1-jth@kernel.org>
References: <20250624093710.18685-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

The zoned extent allocator holds 'struct btrfs_space_info::lock' nearly
over the entirety of the allocation process, but nothing in
do_allocation_zoned() is actually accessing fields of 'struct
btrfs_space_info'.

Furthermore taking lock_stat snapshots in performance testing, always shows
the space_info::lock as the most contented lock in the entire system.

Remove locking the space_info lock during do_allocation_zoned() to reduce
lock contention.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent-tree.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 39d3984153a2..e8d607877fb4 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3819,7 +3819,6 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 			       struct btrfs_block_group **bg_ret)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
-	struct btrfs_space_info *space_info = block_group->space_info;
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 	u64 start = block_group->start;
 	u64 num_bytes = ffe_ctl->num_bytes;
@@ -3868,7 +3867,6 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 		 */
 	}
 
-	spin_lock(&space_info->lock);
 	spin_lock(&block_group->lock);
 
 	if (ret)
@@ -3966,7 +3964,6 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	if (ret && ffe_ctl->for_data_reloc)
 		WRITE_ONCE(fs_info->data_reloc_bg, 0);
 	spin_unlock(&block_group->lock);
-	spin_unlock(&space_info->lock);
 	return ret;
 }
 
-- 
2.49.0


