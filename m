Return-Path: <linux-btrfs+bounces-37-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 145177E5E39
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Nov 2023 20:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4559B1C209A2
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Nov 2023 19:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA87237175;
	Wed,  8 Nov 2023 19:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="NbuedA4A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E01137149
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Nov 2023 19:09:19 +0000 (UTC)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4D32111
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Nov 2023 11:09:19 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-41cd52c51abso442671cf.2
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Nov 2023 11:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699470558; x=1700075358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ehBDfIuN7LiSpCRECNrlmwLyhaoGnDe/cfSCFvX9BgQ=;
        b=NbuedA4AK12KCMwQao7/ulFKJSgYVPGy19xCR5/oGnzmRZzCadJOnAnsVka+SA488l
         IpBGZx4VlEnoHBEiytapejgCSc7BcI3OLkZla0Bcx3Ho0T2lJGkyT16N3qNHuk+Ce8il
         4jzulj24rOzRhummzw4wlBOdXBR9AX+SMG8Vjgbj+ka8MlspVTh2OTQy3lq0Gtkr0ypj
         HQCWErUiZ3YHsnqtKhMsnwj4C78fhtoyR/+hqgI/7JG210SEEX3oCxVGX/fnOowksYEP
         BOb5a1BTH1S6t26EX5/YAG3TXHN3VATM8/hYr8BnCvhHYmWl6tp2LS8xNpMnMNhjjYse
         29Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699470558; x=1700075358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehBDfIuN7LiSpCRECNrlmwLyhaoGnDe/cfSCFvX9BgQ=;
        b=QZwhQAu6CTGNcFuJmd6YMT96NLSpJFj81qGRRK6VSF1f8J8V3Y1GzsZMj7rpUuv8+e
         a5dOcEkooVuuCNgvbJgH/cBx4LxNY15aPRPOJod7xKIxIUdqNa7T/5qZ24CMp6pN7h+1
         tGOS4OF3hKNKXThNvmWFX7WMHW8j6ZsCJ909xcu17m3ApsGQgYMhgpf+bss2QDXrIfxq
         zfK3A/r61BQihb6b2UIkN1FOxPo6relE6xuj2rxGYkN+o5+gX5iDqFqdTtzSKUajnRG5
         4c1rrdeAGOv7gpCIkaX4BHbdhBDSQBOlfhJ462CUIcOxXjkeWswXtBWfg1heBbEZS0ZU
         e+Cg==
X-Gm-Message-State: AOJu0YxQ5VyFVTAYr9kYCBIjRYFgdV1zvw1jtCpQTIianA0hT3zHy31d
	nRzbC1keqCmxZIfBi7U34HTUf6y7DbhID/LbCgWHVA==
X-Google-Smtp-Source: AGHT+IFindzUn+c01KYR9m8hp6yPBLdpa1aovHkvskMV2xNNSrvhUfof0d1YuPZpWeORj06eqiwOfg==
X-Received: by 2002:ac8:5a0d:0:b0:41c:376d:20ac with SMTP id n13-20020ac85a0d000000b0041c376d20acmr2758382qta.0.1699470558032;
        Wed, 08 Nov 2023 11:09:18 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id ff22-20020a05622a4d9600b004198ae7f841sm1183529qtb.90.2023.11.08.11.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 11:09:17 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: [PATCH v2 03/18] btrfs: set default compress type at btrfs_init_fs_info time
Date: Wed,  8 Nov 2023 14:08:38 -0500
Message-ID: <e9b7e3a7889af140e2da4b49f232f79f4be1708f.1699470345.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699470345.git.josef@toxicpanda.com>
References: <cover.1699470345.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the new mount API we'll be setting our compression well before we
call open_ctree.  We don't want to overwrite our settings, so set the
default in btrfs_init_fs_info instead of open_ctree.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 350e1b02cc8e..27bbe0164425 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2790,6 +2790,9 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	fs_info->sectorsize_bits = ilog2(4096);
 	fs_info->stripesize = 4096;
 
+	/* Default compress algorithm when user does -o compress */
+	fs_info->compress_type = BTRFS_COMPRESS_ZLIB;
+
 	fs_info->max_extent_size = BTRFS_MAX_EXTENT_SIZE;
 
 	spin_lock_init(&fs_info->swapfile_pins_lock);
@@ -3271,13 +3274,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	if (btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_ERROR)
 		WRITE_ONCE(fs_info->fs_error, -EUCLEAN);
 
-	/*
-	 * In the long term, we'll store the compression type in the super
-	 * block, and it'll be used for per file compression control.
-	 */
-	fs_info->compress_type = BTRFS_COMPRESS_ZLIB;
-
-
 	/* Set up fs_info before parsing mount options */
 	nodesize = btrfs_super_nodesize(disk_super);
 	sectorsize = btrfs_super_sectorsize(disk_super);
-- 
2.41.0


