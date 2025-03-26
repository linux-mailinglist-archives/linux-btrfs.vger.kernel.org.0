Return-Path: <linux-btrfs+bounces-12596-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 881C1A71B6B
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Mar 2025 17:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E23B67A3AC0
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Mar 2025 16:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5641B3950;
	Wed, 26 Mar 2025 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="J5CbCd7I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292771F4703
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Mar 2025 16:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743005056; cv=none; b=BmlKXciJR1o7bCgDut4AK1KjhoI9l+6rPb2O7C1hvC9ZPz0urqE2JQfU+g+BQ3IN8oTMrqCre6XeJbQ3ZV9jhM9Wa2AGD+bjo+9Z4Hjn97S5qK4x7Dm/f0ssnZfIOPm6YDnnr15w2kcF52faZOtGclYgrUUii8K3qq7vb0OQRjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743005056; c=relaxed/simple;
	bh=oqYKM1ZpqC7RtfF7IzC0cixXHyD/NT9TgSDoB1yKb90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aohzGmj1DlCqf6L3cveGRkUBwYBjjITl19TrfO9kSE8tIH8N86T77hGT8PC+JyLEPycD7FpiD1g1KJBk9i2lm5k2LqNphRd+sDAECxyDOvY6QmvNHqboavqM5CsOsr0LUsqzQuXSU2FuCR1cy3Q2WITRE1JelGdiB+L5vqGTAMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=J5CbCd7I; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22622ddcc35so1125155ad.2
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Mar 2025 09:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1743005054; x=1743609854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V92Mcu6ROGqDUYrr0Vu3d5f14OfoLPIUJ7IhtsUxhlQ=;
        b=J5CbCd7IhHSd5Doa2D3yEmNf2yBrzCT9957Q1N/HEdy+tC6KpSCHIWZLnF5XyAstxb
         jG4XXMbGvCCdv9p97UmuLfsTnPMVonYwr5lPd+77pxWEhV0bJa89bJVzLN0gtn8vWHY3
         KhIQRzM56xdA5BQnMWiCSiwDohx6qDIHCwv9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743005054; x=1743609854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V92Mcu6ROGqDUYrr0Vu3d5f14OfoLPIUJ7IhtsUxhlQ=;
        b=eAGHsznNVTFMla9cvTVv5MqTNd9sl2b1gM75NnERcsPpcuiyAxK6gzUbBNsQL79xzq
         5OUiaTqGPH+V+X1V7UKu9G/XW2FhpEFALkIvmBHVnP918/dn0aLGuJx6hd9gPAx+9jzj
         gk0s5pyLlHfWcJ/34BE2irkKIUJWD8CP8FDf8JMVusWZj41VMQifFk+FG3zrDjoYoO8Z
         tBTpSf03VjH5egq6mc5xT2LsidpB2QOTxf5ignlGsVIc5teAJ8SHDpAE6K3iRxT0XwcJ
         GnEe/44C33pms1/jRUKKnx6lGyQQLzZhoA/kAgAH7JnNQLXH+6iFp9bbnXTC8NdGqSAF
         k7eA==
X-Gm-Message-State: AOJu0YzRj68xzwNeNhWnpypjYoiHAK044fZz70xS4MU54miabbuiUWyv
	LfXNtQMw34Us7ASQ3SViGfJvgIeYc18sf1yH6LsjMJ25KJ6l56gk4tnYtXf1MWY=
X-Gm-Gg: ASbGncsHnhghw4p2p7uKE0eNjQG1sn8iqvmi/vLQLdCNC5up2MKif9+UqtCprb7xgGi
	4v6txei2MCPA0t3Q8WWmqpuA5IfIq3FFnglqrPyZmCu3+ANO6ocwUL6CIlSfMkGmlfs0sflYmOt
	jO0zxFyymchWTl8meUUBVxKmuJCKrpkqtNIAQzFPfgXG4sk8wujehHjKBTw+ualuN746MNDATC3
	Z+FkqOM8SAn9qIDrCgvkzlKlPto1CIMAkFQzLw6lCnRPn7571pevWjgK2mgYW9nHp30jK22zEfT
	8SpAHgCJzKAmt0rNhlGdIfIgOeVwkwuz014EF13JKLHKiKUduP4e5HJR6NGyetOyczp+wPV9DQq
	AY7+I
X-Google-Smtp-Source: AGHT+IHW8xu1XUEic/d8MMjR4RQnRgGFxBNA9gZny8EZQSOeF0ZVLLhc++6oIw8DXemWvzAssm4PLg==
X-Received: by 2002:a05:6a00:180b:b0:736:6d4d:ffa6 with SMTP id d2e1a72fcca58-739610a4c99mr141933b3a.15.1743005054274;
        Wed, 26 Mar 2025 09:04:14 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73907b36bfasm12217947b3a.2.2025.03.26.09.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 09:04:13 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [PATCH 6.13] btrfs: ioctl: error on fixed buffer flag for io-uring cmd
Date: Wed, 26 Mar 2025 16:03:51 +0000
Message-ID: <20250326160351.612359-1-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the io-uring fixed buffer cmd flag is silently dismissed,
even though it does not work. This patch returns an error when the flag
is set, making it clear that operation is not supported.

Fixes: 34310c442e17 ("btrfs: add io_uring command for encoded reads (ENCODED_READ ioctl)")
Cc: stable@vger.kernel.org
Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 fs/btrfs/ioctl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 4d9305fa37a8..98d99f2f7926 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4906,6 +4906,12 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
 		ret = -EPERM;
 		goto out_acct;
 	}
+
+	if (cmd->flags & IORING_URING_CMD_FIXED) {
+		ret = -EOPNOTSUPP;
+		goto out_acct;
+	}
+
 	file = cmd->file;
 	inode = BTRFS_I(file->f_inode);
 	fs_info = inode->root->fs_info;
-- 
2.43.0


