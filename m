Return-Path: <linux-btrfs+bounces-299-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9677F4E1A
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 18:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E9F2813D5
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 17:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7FB58ACF;
	Wed, 22 Nov 2023 17:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="gjn8o1pA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0A583
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:18:11 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5cd0af4a7d3so916497b3.0
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700673491; x=1701278291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wmo6bUZ2Uooog1uRBxQCT5GQG23bw3r/h7mqFB83zlg=;
        b=gjn8o1pAg6a1SRXTlwxma2cLtfkkZchS0Ao3ydthY/y+qI2XNOfI5hF4cyYbn+LuCm
         +aVrHEXvHkJpHAdIaVfu95Ubkzvr52iCWdCZ1aa8LgoQsGVMwl9gUF2CQx/XQFNk4n/2
         ckxlBXZiRyMbGEMsLzlJOrmBBfBj+uCQB0RfRChgYhQfJ/UG1LE6JzIfB1vKNd8gHW65
         lVbbggrw/s/+r5nMAN7T+jOtsp8OfhnL6BOoEwOzv0XMPTyWGljYU7CPGXEXPieT73X9
         YZs8B4y25DzrZ2X4VgWynfFjxCgV2gJGRf2b9ypsQOuCy8MJZw4KUyTEweqRylQSaEPx
         6sxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700673491; x=1701278291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wmo6bUZ2Uooog1uRBxQCT5GQG23bw3r/h7mqFB83zlg=;
        b=BAMmbY4k1sY7kKN06Re21y8Vy+fDyfgOdUc/spe7rFgXq6xAcUKvvbN3MOwyHfesv6
         CGbj6XoeKNDRmDwtNEqBhQb7ZrHV1O+CV1WJDMnZPL18dzKiPchWGDUsD86gQGSDbwGZ
         ZsWKF/1r623OdWu0e1z9YZS6EYOJb+q/9p90/ykSXzHCcAYopLgLhX/UY2vD3J/E/wzG
         YozSdHxJYRNa5bgOUN+Dp646sZDo6ParGxy1S5diMSiTIHPaJEinUnYM5oorgPBgwMlj
         y0+gCa5ZmcA6wa7iN+H/xZz9Gc56uAw0JbRq0iBqE/4miWM1D1RYNDX3J2oMEPbz7nkP
         94kw==
X-Gm-Message-State: AOJu0YzrXSkttS1TLbin8OJTqCyd7lzLFIJQxSmgdHGKHZyiiLv780s6
	ciF0RJrDQ+EnDznL3FB61DoGz2/Ua72dmln2mM9kTFbc
X-Google-Smtp-Source: AGHT+IEzN4TfKYU8NK8VOiJ8nPCdQ3O4NXLfBtEw11r9k/9nIFLJNMqw1iP8UwxULF8BUdhLmQsk8Q==
X-Received: by 2002:a81:4e01:0:b0:5c9:a998:b4cf with SMTP id c1-20020a814e01000000b005c9a998b4cfmr2756958ywb.10.1700673490991;
        Wed, 22 Nov 2023 09:18:10 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d127-20020a0df485000000b0059b17647dcbsm3782094ywf.69.2023.11.22.09.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 09:18:10 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 07/19] btrfs: add a NOSPACECACHE mount option flag
Date: Wed, 22 Nov 2023 12:17:43 -0500
Message-ID: <6c1683589158f68afadc876fe427b73b7be3f182.1700673401.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700673401.git.josef@toxicpanda.com>
References: <cover.1700673401.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the old mount API we'd pre-populate the mount options with the
space cache settings of the file system, and then the user toggled them
on or off with the mount options.  When we switch to the new mount API
the mount options will be set before we get into opening the file
system, so we need a flag to indicate that the user explicitly asked for
-o nospace_cache so we can make the appropriate changes after the fact.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 1 +
 fs/btrfs/fs.h      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 42da84a186c7..3c72bc1d09a3 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2947,6 +2947,7 @@ void btrfs_clear_oneshot_options(struct btrfs_fs_info *fs_info)
 {
 	btrfs_clear_opt(fs_info->mount_opt, USEBACKUPROOT);
 	btrfs_clear_opt(fs_info->mount_opt, CLEAR_CACHE);
+	btrfs_clear_opt(fs_info->mount_opt, NOSPACECACHE);
 }
 
 /*
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index a3debac2819a..e6f7ee85032e 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -188,6 +188,7 @@ enum {
 	BTRFS_MOUNT_IGNOREBADROOTS		= (1UL << 27),
 	BTRFS_MOUNT_IGNOREDATACSUMS		= (1UL << 28),
 	BTRFS_MOUNT_NODISCARD			= (1UL << 29),
+	BTRFS_MOUNT_NOSPACECACHE		= (1UL << 30),
 };
 
 /*
-- 
2.41.0


