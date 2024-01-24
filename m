Return-Path: <linux-btrfs+bounces-1734-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4864A83AFB4
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE761C26393
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BCA12A14C;
	Wed, 24 Jan 2024 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="oyQB3EE3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FFD12A154
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116815; cv=none; b=py7LEcjsv4+pthBuvI2pNWnocvgHXacu70jvJEyQQ/+YrThUExgQGD+r3Dm1auSBCdWDb0x/kqissyGca5K6txRCB8g+QqXRDgFTxTlHskZyOTn9i5rz772F6hUhLcyJ2jaRncn8Ux+QD4M6DbMbHQg5dskutqKxjPkl/ln55Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116815; c=relaxed/simple;
	bh=Nrb9xo2/gpWMxEaOcp87QSnTKOHJ5xz49hdfHTZqtvo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXPuA/IjE56VI9oirlT0MwassY1yXXvjhAEeDo7VurAo7GQAKXhq3sG9cQyH9qAtInWAEj4uOW5ymtuumw1VU+c2MDaqMurCyNRTm7v1n+8ff+sQN3PLsWpX4LaRmUDxQn2mI1lJ4TbdHmUXO06nIHVf9IPrrEwyUSjiziGbSrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=oyQB3EE3; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5ff88cbbcceso49120357b3.2
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116813; x=1706721613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6KtRgI2gN3jgTS1ZjmRKWWEBm9g1qkqNOsjV2pyGmtQ=;
        b=oyQB3EE3+L1QNCJ9qIJiJ2lzulRM/enkJrCsEiuGzYORoBKQABR1AuPQMrWrx/3L6E
         /FvKuugAqQkD/M15OWOpEj+9biY/YA59Pe77QhBQyiBJWM+385F65zT5fPvvYA7rllHj
         LVi5wNZ6HynbsRMx2mzWIHFmLU/R3lkN+w+w1Y6nUrcauoPjG5ymtjYont29zK66km1D
         aAl0kQ033ueXokA3Y1ROAColEKruT1Oi0jj9+V8JdlyFQiWdlC2OpaPncIvrakJ30l4z
         nlL1/S5abIvE3HAQh+LMmkmh3KbhBPmYc9D6hw4Ml3w6AtVLNHXnyIrTt97fd/GNPzWD
         qP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116813; x=1706721613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6KtRgI2gN3jgTS1ZjmRKWWEBm9g1qkqNOsjV2pyGmtQ=;
        b=gSWYOefTy26MW9oqFprRPf+cSBCbukyERj7ZjCcESQq46gHtnVfiWOfvRRX0QL7uth
         yVVcf4bYMxzUwDLv2/F1z/HtExBLcTTijvYKP/GjfKYAei28cojeQjfpTPKHmaTBzfNX
         Cd9dHz05u0eSIIlUCaBlH21uEHWNW72toQMJFppBdVl1jdLwsbE7foErh23YBkCXH0ok
         sjeZTJ4dPDJFiCPllF616Vjf8u0JQ4J/oM1ok87tHfW112jCSyh3/ENzbgWffq4qGu7N
         Idd9uQnuRtPmur49JnPw4wDluDT1NsVYJF5GpO7yqRxypq4xs5whIyj1ET/a/aq8gBnf
         v18Q==
X-Gm-Message-State: AOJu0YyL7Ybv8nVVPhpMo5M/FhS6wyKs6TsOXTkH47PwmfhXp5uozLgE
	rx5tknY+XoseXCrpHcAxof7EzmdDFKDRyDx5H3NoOd4MrIvvTtnWUajjlEsdZg8B/wKl+L3arKb
	H
X-Google-Smtp-Source: AGHT+IEUyt0GSuNb+Fy14IsnnBiIWH/n/pFpxx+ysKSUIfdMQFWp8ILgrYYtOtjWyaIX/EuBJ5m5oQ==
X-Received: by 2002:a81:4a07:0:b0:5ff:4895:8c0b with SMTP id x7-20020a814a07000000b005ff48958c0bmr1244570ywa.40.1706116813371;
        Wed, 24 Jan 2024 09:20:13 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id bh13-20020a05690c038d00b005ff864709aesm64580ywb.42.2024.01.24.09.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:20:13 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 52/52] btrfs: disable send if we have encryption enabled
Date: Wed, 24 Jan 2024 12:19:14 -0500
Message-ID: <62ce86b38e2575c542eed7fbe8d986e68496b1d7.1706116485.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706116485.git.josef@toxicpanda.com>
References: <cover.1706116485.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

send needs to track the dir item values to see if files were renamed
when doing an incremental send.  There is code to decrypt the names, but
this breaks the code that checks to see if something was overwritten.
Until this gap is closed we need to disable send on encrypted file
systems.  Fixing this is straightforward, but a medium sized project.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/send.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index d26ca7b64087..eba45477b10a 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -8183,6 +8183,12 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (btrfs_fs_incompat(fs_info, ENCRYPT)) {
+		btrfs_err(fs_info,
+		  "send with encryption enabled isn't currently suported");
+		return -EINVAL;
+	}
+
 	/*
 	 * The subvolume must remain read-only during send, protect against
 	 * making it RW. This also protects against deletion.
-- 
2.43.0


