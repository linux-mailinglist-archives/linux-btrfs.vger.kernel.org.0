Return-Path: <linux-btrfs+bounces-1375-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9890829FE7
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 18:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCE921C213C7
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 17:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0D64E1C9;
	Wed, 10 Jan 2024 17:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="OZtP/Svj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2514E1B3
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 17:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7833bd8be24so26481385a.0
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 09:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1704909285; x=1705514085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=09bfAGeu7L2ZkY5H8Zufho5egdM5qoQF/m1kqMZcgfo=;
        b=OZtP/SvjLfyPusFsex8fKFw+fhcjyBet0FYYYswCzCrlhy46D4whm7X5yc4FuanGZd
         aRoYXPxXLc/sT+uN7CehJzvJYf9921TgdD5GLFfEAKa6qfkW4P+di0Dy+pD/aHKcgwhd
         dUZ+MYzaJoVAyRVTvAUtCZsWN86ndlORBr93X32SevMtw7EspwyRt8a8jJeMyHPYoPyB
         FKAvuekpkSLyHyIooXQxTBKrgrqG34LbBiv9EFkWf3+pQuUtqU4586OrQ+dhxaoN0fyp
         KEuuXbL9Ds3ph0ezUW1imSGTEKagr7/Ydc7luHWxwvYDCk0gbV3NdjrSB5CpF7scbrao
         QKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704909285; x=1705514085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=09bfAGeu7L2ZkY5H8Zufho5egdM5qoQF/m1kqMZcgfo=;
        b=SUUGEQzjwTIVO4N1UwlKt3GYe51kTtQoFRZCg8oq0EfCpsQlVNNEOxQLn3kZVDiTrw
         8kEjtqVpZqPtKMFXkZRcP0sZ0fE9dclPf7boRmkUjsMbs4y2ylk8M22NQPeMNQYsE/z2
         +Hlw8IAS7WFb+LKIyfYFaksjE8NaYTgznM2P2cjn1T3BNJPIQEho43AVe+5KWOG0v1GN
         LwNgSsrHMU+qvySdJJWvKf1lMOnPnQ2N2mP6VMvWjeqUFXcaHWUj3804U9Ek5FHFt0WW
         kohuIkJHZvlYwTUVATTxdnUjjLhJB4+tL8gLAPXctO+sjhy1jrNAVj93MPDKp70DjCao
         qc2g==
X-Gm-Message-State: AOJu0YzLhtnVhb4A4TdJMi5L5g6RsiV3o0JHKk9eM6wVsCQQrSgvkD36
	3Eq9L+KdORK3wpYPn4UCWy0bhGKqmtQcGGzYiq3FILqguz0=
X-Google-Smtp-Source: AGHT+IG+3/GRz/E6+SyG5qN1qfv8GzPyzORlJWO3X47TLx4QBKbZO8HQOgSzX3l6og+UtYPhQDgcLw==
X-Received: by 2002:a05:620a:5223:b0:783:21f1:8f8f with SMTP id dc35-20020a05620a522300b0078321f18f8fmr600686qkb.46.1704909284965;
        Wed, 10 Jan 2024 09:54:44 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id w24-20020a05620a149800b007830709340csm1773742qkj.2.2024.01.10.09.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 09:54:44 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: use the original mount's mount options for the legacy reconfigure
Date: Wed, 10 Jan 2024 12:54:41 -0500
Message-ID: <18faaced53d356f66b4b1f0f118d15e37e3c8a2c.1704909267.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btrfs/330, which tests our old trick to allow

mount -o ro,subvol=/x /dev/sda1 /foo
mount -o rw,subvol=/y /dev/sda1 /bar

fails on the block group tree.  This is because we aren't preserving the
mount options for what is essentially a remount, and thus we're ending
up without the FREE_SPACE_TREE mount option, which triggers our free
space tree delete codepath.  This isn't possible with the block group
tree and thus it falls over.

Fix this by making sure we copy the existing mount options for the
existing fs mount over in this case.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 3a677b808f0f..f192f8fe0ce6 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1451,6 +1451,14 @@ static int btrfs_reconfigure(struct fs_context *fc)
 
 	btrfs_info_to_ctx(fs_info, &old_ctx);
 
+	/*
+	 * This is our "bind mount" trick, we don't want to allow the user to do
+	 * anything other than mount a different ro/rw and a different subvol,
+	 * all of the mount options should be maintained.
+	 */
+	if (mount_reconfigure)
+		ctx->mount_opt = old_ctx.mount_opt;
+
 	sync_filesystem(sb);
 	set_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
 
-- 
2.43.0


