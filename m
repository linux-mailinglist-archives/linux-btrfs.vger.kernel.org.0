Return-Path: <linux-btrfs+bounces-41-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A69A17E5E43
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Nov 2023 20:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05E64B212AA
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Nov 2023 19:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC11D36B18;
	Wed,  8 Nov 2023 19:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="cQvtzXfv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64624374D9
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Nov 2023 19:09:25 +0000 (UTC)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC09D210A
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Nov 2023 11:09:24 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-6711dd6595fso418886d6.3
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Nov 2023 11:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699470563; x=1700075363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qn4wfDb6jDre0GFiLqI3t3dfv/iDXvlKvBWKVyZYNgA=;
        b=cQvtzXfvW8EczGn83PSMtx0Qw5TJ09QhUZiiMuAeHP8OG8Qq27NyFDJYQV4I3Kx0se
         t6cANqrrtSrFptxX6t3SwA/2n3GH/WSiXUS3eFa/9J5nZ7jHqZTV2JDl7NN37Xb2BlMp
         S2LHB/ZAnBRimju4iYFsTlX0g7a3/XdbHhHhUG5dQciD/bbCEBvgvFkyZXV30TSeWVLC
         1MRwzVFddRj7MxXBLAOLUqeUve9XqOSTCEadc9WetKNhwZYQ0RljBkT9+pp9QJWr2AGE
         QgQ/TEmMwxlI6XJq1LDHuTzMAHcqjFk87PE9xt2ptsDyOdhlgrL6Gw/MYXhNdVhBc8OZ
         BpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699470563; x=1700075363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qn4wfDb6jDre0GFiLqI3t3dfv/iDXvlKvBWKVyZYNgA=;
        b=cN3CT3tn6Vme8z+Xi6FbeQf3n8Bxe+/t+Seabh0oljvn4ZKN2t4BZOfj3zS2miBo9z
         wR+dTa5wMjGlEQNoaAIzKJoNk+b3RzfNQ2rrYx4K865UvebKkkPrDIN1Dsfxr24dpvRw
         boqhXQv9S29XPb4ZS8UsBxJXL+2oKZd7Uyapf1cWv2NHEpYP9UKSP8MKnlyuwV/5m/Bl
         lsZbSmNo6aF1LUtq/x3OEKJ1yKQgIOmmsylaotyl3zKITazfJORQ/60XaRqOGetiUdoo
         jicypg8leJs11gSp8QF8qZp4KFcHu2nmEZB3awcXfHHJUx26Z/RTBPBvxOh5ayRiSUvS
         c0vQ==
X-Gm-Message-State: AOJu0YyGDDxjJqT1rGr2uMzeA0AzSWjdI9To7Buc+QGi0vSVdgSKtNlS
	I6emZNe0HRG6YR3rH5fyAASHg4DykwC/MhTPOCsY+Q==
X-Google-Smtp-Source: AGHT+IHURzhA1WV2kWdzm3EfHMJOEChXSbYb/jw8zKkSftyVmAe79UzIpCJONo3PgRzPf9Rn38yWUw==
X-Received: by 2002:a05:6214:76e:b0:66d:ab4a:dc4e with SMTP id f14-20020a056214076e00b0066dab4adc4emr2501267qvz.1.1699470563547;
        Wed, 08 Nov 2023 11:09:23 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id f2-20020ad45582000000b0066cfd398ab5sm1348860qvx.146.2023.11.08.11.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 11:09:23 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: [PATCH v2 07/18] btrfs: add a NOSPACECACHE mount option flag
Date: Wed,  8 Nov 2023 14:08:42 -0500
Message-ID: <f055629d0b79b0f8dd9ceb4527519c800c612694.1699470345.git.josef@toxicpanda.com>
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
index 072c45811c41..c70e507a28d0 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2938,6 +2938,7 @@ void btrfs_clear_oneshot_options(struct btrfs_fs_info *fs_info)
 {
 	btrfs_clear_opt(fs_info->mount_opt, USEBACKUPROOT);
 	btrfs_clear_opt(fs_info->mount_opt, CLEAR_CACHE);
+	btrfs_clear_opt(fs_info->mount_opt, NOSPACECACHE);
 }
 
 /*
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 318df6f9d9cb..ecfa13a9c2cf 100644
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


