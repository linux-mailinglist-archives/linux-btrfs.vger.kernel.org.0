Return-Path: <linux-btrfs+bounces-12595-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BBAA71B52
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Mar 2025 17:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DCF33BF442
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Mar 2025 15:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C2F1F8BDF;
	Wed, 26 Mar 2025 15:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="T8VWEhwI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C381F790B
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Mar 2025 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743004736; cv=none; b=m+exX05XqWLuudrY31yUM0w31ihxC/u8BcThKge2t+GbtYZkIBCipNl7IQ2Xjm1wXrN+CcRF3y7SnO+ORFZPFNtuckwLUmd2m/OM43DAE0tcSTtAMkF1WVXCLRchr4wYthY9942VnUHRLV2JEQOozrG+09gwdzM23Qycb3uvjQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743004736; c=relaxed/simple;
	bh=Ko35wHuYTUsyD9pNDD6CddW86SuHmvVF/p8rHOgc5Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ya7Uk9yC7jrpQVzhDyZ6H3ztLTZFOq8Oe20DZtVISTtppoWQSKp8tC6yAeu15d/YAw4o+US5pdTeM2tByaRxovot8RGYrrXjI2STxDTuRQ7njqgrZeuzUzOWl4gnKTCjQwofh39ykKJJkKnpRZQ2ag7ibOH+/C/xsVu1BhVZf6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=T8VWEhwI; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ff85fec403so2352461a91.1
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Mar 2025 08:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1743004733; x=1743609533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vaZQ+2MJDMVjz/9PaIWP0hky9ATIPKX3HyuJU/jmspM=;
        b=T8VWEhwIWdprG7TzGEYgjk8BP/tosxJmDPwv1apaqgnHfMtYfvrE9EfeKFk/WJGTiP
         T4knKjFqT11kDt1yCPC0XVRr2Kdte1to2oNh4c6QneRLhxyYh/RXmCf4oNPIAuAx2xXa
         90KmDNoJ+JQunZJbAulL5f7e+W61mYfNEIJEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743004733; x=1743609533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vaZQ+2MJDMVjz/9PaIWP0hky9ATIPKX3HyuJU/jmspM=;
        b=LB2c3oT3N6r17KKlPU04e+eydmxvvQ8erGTcKN3lyC5t8PFGYuE/hAsPHd98WBwYiL
         DMDTE6Z4ujLdIKMfvBd0l615gPfja5/aicnBNbtEtTRQdufSePCII1gKWmGkPB38OBeD
         mgQSUSd+Enh6epqZqCkm9h/HnsH8wxaV26XuEQBUmUT7DaLUNmRHidy66yMytjTzoINp
         RZe4A0qgZBE1SJMDdud7klSRkeHhlUM0S0Xd7gLvR05conm7+MbYvjlVu9pkFfCDBqmN
         vnUW62eExzcJMpO0kZL1g6aaLCeV8QDjQ72KVHFW6cFsTuwuXOQHwrT5h/hAwrDia7+s
         dTRQ==
X-Gm-Message-State: AOJu0YznuoffSSVFzDsxlz4Va7J82P3/D+ZeH4s8g3bSpsUSGFKymx/A
	BW7waOi4Jq9Dv5VB2c4QfG084EcUbDXMngODCT6nMBtMyovy0s/wWxmxEvczwUdWsThiGuEOorF
	4
X-Gm-Gg: ASbGncsp4k8xFlNKpuldmcImNOa2bBfB7ZmZLMVl0VvseshaXpb3Z57hQKHk3kcvc+B
	SMNY+TxH6TCk2Thqc/y8ekut0OoW3CfjiRQQTJD0bXJ7ktPvBAqSMOFL2X2mBXdVb9FHzX0vInC
	mERt07hSwyL0f916o5NOL7detuss1DnTcEvOA/g/xUg7TRVK9M9R2h5E5Ses5G3PWRlE8WWqhUL
	MODp2EL6VeYVo6g+X/pw1ZjUSdPiJg+sgm7wFCV+59qCt9nSlSZv8WOCpqc3gFORoLUicJApeQr
	/KUKwteaEUE4A7w3bQMtXKbdW3916oFlaPGE90JFVKQxZsWMmWfUYuHIHxJdSr0WgNo3FHD1qmD
	OLiTT
X-Google-Smtp-Source: AGHT+IHFgZ5MnxSjZ1MnHHSC8h28hT1dJVRZQpLzJ1vDyTU635J4PM5CGpBG8FJ9Nnh2HGTU+QyICw==
X-Received: by 2002:a17:90b:3e8d:b0:2fc:aaf:74d3 with SMTP id 98e67ed59e1d1-303788c3949mr5434698a91.4.1743004733212;
        Wed, 26 Mar 2025 08:58:53 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fab1d1sm12423939b3a.32.2025.03.26.08.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 08:58:52 -0700 (PDT)
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
Subject: [PATCH 6.14] btrfs: ioctl: error on fixed buffer flag for io-uring cmd
Date: Wed, 26 Mar 2025 15:57:36 +0000
Message-ID: <20250326155736.611445-1-sidong.yang@furiosa.ai>
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
 fs/btrfs/ioctl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 6c18bad53cd3..62bb9e11e8d6 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4823,6 +4823,12 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
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
@@ -4959,6 +4965,11 @@ static int btrfs_uring_encoded_write(struct io_uring_cmd *cmd, unsigned int issu
 		goto out_acct;
 	}
 
+	if (cmd->flags & IORING_URING_CMD_FIXED) {
+		ret = -EOPNOTSUPP;
+		goto out_acct;
+	}
+
 	file = cmd->file;
 	sqe_addr = u64_to_user_ptr(READ_ONCE(cmd->sqe->addr));
 
-- 
2.43.0


