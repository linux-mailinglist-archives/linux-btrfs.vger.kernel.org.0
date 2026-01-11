Return-Path: <linux-btrfs+bounces-20380-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 500ADD0FCB0
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Jan 2026 21:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DDC23032720
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Jan 2026 20:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486D5258EE1;
	Sun, 11 Jan 2026 20:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLvFMpgZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3786919F121
	for <linux-btrfs@vger.kernel.org>; Sun, 11 Jan 2026 20:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768163104; cv=none; b=tlYhfglzRCf0Ig290X6aExHlv4EUk78I3xJIEZzHeGk/1YQCeLAOsiHXkk67VnlYW8dQfYsgtbYu3kjKKQT4NpSVWzVrfZbW7lkUkMUduKDprco+oYsTDN2gtC2X30UGtacjing1nDeIfKftJA2R1di/6QnJ5ORI35YL7uD5BLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768163104; c=relaxed/simple;
	bh=qJvyB/3WkL8MaHiMJ2MSrGEoZoHbUS3JsMZ8irOWw40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DKneJzatIwqCnyYXIoitsr9qhAfokGZurOcFBSqvEbzAMn4qtlhFTPEl3+D+g5AIbUfOSvEZ8hcU/sbV36hkPjSVz/X6F0E326Tn5MhArL9UxOBE5rnEXnd9SY18BO3BygLt28JUN08SswmocTG2o6472fXsPFV8/M4Pepw2D4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLvFMpgZ; arc=none smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-45330fe6e1bso3416808b6e.2
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Jan 2026 12:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768163102; x=1768767902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxyTeImYBmZA39crZjolcxk7Z4LKlXIeMH8wnvv68VE=;
        b=iLvFMpgZoHz+78xFJ8CF6687CJodLLuTx3mz22Maspw/iYfE8qL116ikV1DhNwkaxT
         AaCdZRulNa3j4zxgsV9/n01O+8CkTXAGLrj3cWYPsY76G3JMxpSZKxysQssXRFj8ExsS
         P3yraGZwLr9phJDXSSn8ku81QzT+gywyJKqj+tDl/3+DRiyrvPOfM7Dy45QlRp0HjH3W
         CiZ4HzRgx6ROFMCW1NNVBgnzUzitnwuud2HH6b0IiwcqdVO5wWMMukjWUdeBfEamUyT1
         Ntq9Aa12zi9Wd5TafqdiKpdqjndnnEVbCYkfcDWQp337h70copyAXwMqPk4cMK4zEGgV
         WIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768163102; x=1768767902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vxyTeImYBmZA39crZjolcxk7Z4LKlXIeMH8wnvv68VE=;
        b=cEhnm/IUtEYbO+bXKbSzLozVDRNna1P94egkF8aMJ/Z0qNPYobMGm9jD8+Buok7RJY
         mkTxqmcNW2YkrA9izoo4WbY4+3biVu4HvZdsfMVPjJXCw5+pyqV+fl1CJcvWBfrGO4mh
         3JUpyp7Xosl2rjR30vYj39DJJuUm+xx5j8ft1jLeNkdVv5eB9EtcEcULQFJ8AUWa1s+S
         sqllESpLkiJ+3idx240dOB5sr2scHZ8tFswmzSTDyQwd955MuStxmL/8N2oysUKZ4xZZ
         HMKUcBvxRfgUns8nxm+ithFA9qz3jKTKuHgoeo5GM7jKgFg0z5L1jBP3O3A2svTKOocB
         B9QQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRExoc2Q6z6SdlQ3n4D9oO9wuQ9LSIP672eJDior0MTD9sPC1J4ba+lwzzMfuXO8XyzqLPUbv9tW8omw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAdgrfLFUY8SaLMrxq4tu1Zp6ksjDQ6eEm4bGJ4nxtKqGKc5gI
	ZoxcyS9if3Trb1JHNsJeyDvuqFwXUQ0knYN0g5VyaK2u4YDNUyqPxatL
X-Gm-Gg: AY/fxX6fwESWefp4L+JtOx3oBzEUSkYEesdRfWMgIQKFsvYS++igKxITo01TGwzawrL
	PI4g4tQKdJOE6znPtD1dKeBlKFYF9jXYm3Qv+nWayW71GSuloS69DBRScZADYbuTDfgvNeJuXyR
	mPEK9yUOlRyhKpJrzuCeid0/mTyAbjznIrGJ7tbxBI7bWVzU/Lj3+g3WsZez94GLnSVuVdBu88x
	z+Tjy+dCfSk3NTA/2SUekQiiKo97IuXY1INlzZYpdFvKHiknDkdr3U5aQw9Sfg5v0KhZgTUlF5m
	fTY/Qezzb9kO9Ls+oJqYsb6LYiUo6LtUWn2mdGpu/dFLfvUY3blxjw6rbGuXKHMHX+6FXAjYlmF
	KcfoMudvb6hWpNBVSiwdLfyXPwltbAPlRrLb2Jass0/NODMjRN+o62cL/f8+bfkF/c01Ue1Fejy
	/tvvGkiNIwL7Csb6yIf/bZqc/AIrQcF3PD
X-Google-Smtp-Source: AGHT+IF7ZRBV/c8QXWUV0Ji5pAEu8T6ygemgtPIQCSQZucWvZ2FKBbysdddR1sv2edaPcFU3kDctHA==
X-Received: by 2002:a05:6808:ecd:b0:450:4628:e3ce with SMTP id 5614622812f47-45a6bd4b226mr8007317b6e.15.1768163102077;
        Sun, 11 Jan 2026 12:25:02 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a8c6b3fdfsm3407834b6e.17.2026.01.11.12.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 12:25:01 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: fdmanana@kernel.org
Cc: clm@fb.com,
	dsterba@suse.com,
	jiashengjiangcool@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] btrfs: reset block group size class when reservations are freed
Date: Sun, 11 Jan 2026 20:24:57 +0000
Message-Id: <20260111202457.23698-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAL3q7H5TPCmtbupb_gQuEnvFhh2dKU89T6C2TsUJqts8gxW00w@mail.gmail.com>
References: <CAL3q7H5TPCmtbupb_gQuEnvFhh2dKU89T6C2TsUJqts8gxW00w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Differential analysis of block-group.c shows an inconsistency between
btrfs_add_reserved_bytes() and btrfs_free_reserved_bytes().

When space is reserved, btrfs_use_block_group_size_class() is called to
set a block group's size class, specializing it for a specific allocation
size to reduce fragmentation. However, when these reservations are
subsequently freed (e.g., due to an error or transaction abort),
btrfs_free_reserved_bytes() fails to perform the corresponding cleanup.

This leads to a state leak where a block group remains stuck with a
specific size class even if it contains no used or reserved bytes. This
stale state causes find_free_extent to unnecessarily skip these block
groups for mismatched size requests, leading to suboptimal allocation
behavior.

Fix this by resetting the size class to BTRFS_BG_SZ_NONE in
btrfs_free_reserved_bytes() when the block group becomes completely
empty.

Fixes: 606d1bf10d7e ("btrfs: migrate the block group space accounting helpers")
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
Changelog:

v1 -> v2:

1. Inlined btrfs_maybe_reset_size_class() function.
2. Moved check below the reserved bytes decrement in btrfs_free_reserved_bytes().
---
 fs/btrfs/block-group.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 08b14449fabe..8339ad001d3f 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3867,6 +3867,12 @@ void btrfs_free_reserved_bytes(struct btrfs_block_group *cache, u64 num_bytes,
 	spin_lock(&cache->lock);
 	bg_ro = cache->ro;
 	cache->reserved -= num_bytes;
+
+	if (btrfs_block_group_should_use_size_class(cache)) {
+		if (cache->used == 0 && cache->reserved == 0)
+			cache->size_class = BTRFS_BG_SZ_NONE;
+	}
+
 	if (is_delalloc)
 		cache->delalloc_bytes -= num_bytes;
 	spin_unlock(&cache->lock);
-- 
2.25.1


