Return-Path: <linux-btrfs+bounces-6870-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFCB940F9A
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 12:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65A9228664D
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 10:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A431A257D;
	Tue, 30 Jul 2024 10:33:29 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AC91A0AFE;
	Tue, 30 Jul 2024 10:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335608; cv=none; b=GwPQmm42r2adUkjWe1UtGk/DCNrs0Heikkb/d12Hg0XSN+48HSeQz0W5QjPhN8WeJCQQBUrrm1t6/tAlP1NfDzgs1OtRinJLyDWUasq+RwQkdHYev/zXMXYrAKX58WkQhneKmZgb+K3Yn/ppGAdj7xpos50wV+VQ0xdne7e6T58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335608; c=relaxed/simple;
	bh=/IcSJYYXJNCnwyGW/xg7CQHiY002W+thsnUAs/eIUL4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CRdBG1efAOHqnmGfFsinmRFjcQpnD4I3AKrAnL0qmp3Jot3EASZj9YaFLrauyZwfrTCug0h9JnjgNtS8GCIRgXJnUN4l5VF2rvTPvRIoRg7uYKaeFDyP4ZT0sv/IuzK0kJGOMnPsaT9fdWJyUuS95z912m00C5y5bgXiI0ri600=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7a9185e1c0so417485366b.1;
        Tue, 30 Jul 2024 03:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722335605; x=1722940405;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJWlRDxSJTNdG19sMCqs4ElfI/UMNfe1NBY5LQ2S1jo=;
        b=gFG+0GC6YuyOUaX9O7Ji3IYayl2UFPW0UNMkHoSvKs59kLXDfQfQMi7F++bDr07Sje
         sPeoRIzTE4nes/+zsHGY0YTVX2Qyijkfu4HD2tvxwkCGO6JOdwZAlDuMJ+/7xZCBeTuk
         F674XfklTTIYqj3FWxcOht22/Vi+QWeR4PSf2oVlw48chrKEzm0RjoH47d/GziUt8V+S
         ORJZ6KaaQ4eIE6Ket3o7Uebdo4V4VhoxCdD/xYlKNXpXgvnqYP0z4vcnGCwOMwh8AlPG
         9bWdAFeszTvdJ98i83BT5DZQcX965OqSDcT1ubXThAJKo9eTvZtQjEqV6HkFYSaC8m01
         uVAg==
X-Forwarded-Encrypted: i=1; AJvYcCXLTBssChbgHtfP89keynryyj9sfSRXwHFrOF4oIaASskY/nMz3/NtYrHx77tDDJls6EuzG7oges999X+HFD5Y8L5qjY5IuGz0f1FxD
X-Gm-Message-State: AOJu0YzoOyJMmbiYgsrLxLTJhW4tCuGkEjWA81tPjTK/tVYVYDcRffU0
	TSLW4Zb5NlKMPwC9X3Cuar0XdTjK8KGsDVT9bVxskII4D58YE2WASgosSw==
X-Google-Smtp-Source: AGHT+IGz8vrwXgYDFNl6r0Cv/OnPdHKZoCpNEXptSTywro3ZWzR0pul4eNhh7t6g7yA570bQMnyuiQ==
X-Received: by 2002:a17:907:72c7:b0:a7a:8e0f:aaf0 with SMTP id a640c23a62f3a-a7d400a4179mr740813466b.36.1722335605401;
        Tue, 30 Jul 2024 03:33:25 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f732f200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f732:f200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb9f60sm622455266b.223.2024.07.30.03.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 03:33:25 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Tue, 30 Jul 2024 12:33:16 +0200
Subject: [PATCH v2 3/5] btrfs: set rst_search_commit_root in case of
 relocation
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-debug-v2-3-38e6607ecba6@kernel.org>
References: <20240730-debug-v2-0-38e6607ecba6@kernel.org>
In-Reply-To: <20240730-debug-v2-0-38e6607ecba6@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=807; i=jth@kernel.org;
 h=from:subject:message-id; bh=b0Pb+uSMgNZdT9sxeeZ9pRVHoEwmmPaSc/gj9kZGk3k=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaStOFjQ6ftE2lG/+f1E28LFr3rfr2zccEMg8XTilWhP/
 deqrqvEOkpZGMS4GGTFFFmOh9rulzA9wj7l0GszmDmsTCBDGLg4BWAiXlaMDJNPe5pnNUnf5HSr
 Xcc/50SQ7sxf+TITys7xNcrvYT58V5zhn5GxtZSN2Rej9TtlWo9ctz007RxTsfzv809+PZdu+LA
 9kBcA
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Set rst_search_commit_root in the btrfs_io_stripe we're passing to
btrfs_map_block() in case we're doing data relocation.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/bio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index dfb32f7d3fc2..c6563616c813 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -679,7 +679,8 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 	blk_status_t ret;
 	int error;
 
-	smap.rst_search_commit_root = !bbio->inode;
+	smap.rst_search_commit_root =
+		(!bbio->inode || btrfs_is_data_reloc_root(inode->root));
 
 	btrfs_bio_counter_inc_blocked(fs_info);
 	error = btrfs_map_block(fs_info, btrfs_op(bio), logical, &map_length,

-- 
2.43.0


