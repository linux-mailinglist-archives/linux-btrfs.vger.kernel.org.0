Return-Path: <linux-btrfs+bounces-14457-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EE7ACDF8D
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 15:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C8C2173BFD
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 13:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949D728FFDB;
	Wed,  4 Jun 2025 13:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bo23b+EB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC5F28EA7C
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Jun 2025 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749044878; cv=none; b=JT+pbbwU83d6RAaX11UbtFpbQDuxIdbj8Q5AIbJTII+6aflb4Sp3q76VyctfpxISxrq2gIRUZSYE3SGn2nhtHlm5TMIgxMzv+c5JCRxo8v5s9oSp294ni89JeTkaEYFJ9NLbLg//qNeeqXnK2Wq21vb8O7X13P6wtPfjfo8UAYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749044878; c=relaxed/simple;
	bh=X+QzyMfElZ8R7daRCiLq+MbyNDkLxwSCqN5pIWGslhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IKG5ZvAMDKlGIS6b/mTHK07xj+w/mWDpsqcNjqzAalOgqVWlaAswXyg4pd8WPBginP+MndL4VomsBXeG3/vO6cps5MGMd5NwalY3/Ih450ZkJ/y+mVix8Vahk55XccEolNt77zdFMuEq6DvJE0pglKTZNFtWdSZnL6AbEmAzszc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bo23b+EB; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-47745b4b9aaso3315541cf.0
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Jun 2025 06:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749044876; x=1749649676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H5S5yqOPyvyzsrKSC2LX2EkzmJdkwi1VVE9tvUM7oGQ=;
        b=bo23b+EBYCG08IErHWCYVqs8yL7DU5cypjMlHe0zkPy1BQcwCxOXGekoAfhTR6cXW7
         r+Kug6eqPZO0ToqdjHdRF5MiBxdX05Zxtr4zuKXFeY344UkR6e5wsVd6O05i9GEr6G9u
         YK0d9Lt6Pbuu5YNHzaJSf0vgxyXyeXMxzamjwMMrTc58Hdj8FRyV+ZZcTLg7VrDEs8k/
         sdnCTv79HkuKZLU8tAxvIcvHySsLXP137tqxmIl5/gwMXWBWb/5Rx6ZG4d5SOGVl4C3I
         ygKAGFy+RmFbgK1sUnyMKzW1Q2Q2op9+ZGxdYhRbgB6gmTQuwW4tbTxkcUPSrX4+LlWq
         9M2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749044876; x=1749649676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H5S5yqOPyvyzsrKSC2LX2EkzmJdkwi1VVE9tvUM7oGQ=;
        b=RVcD/qNaZShYRQS8jujiNWDHKyL/vRMfz7w1mMAR2aYXeC1bwkgkaJfplPh5UNQ84q
         b/nePNSXxWgfjMwmZljen2BNFgDyPeQygsnKopYlwon5PmmyOBgutWX/ZTdnI0X20Bwf
         2zizMNS3FFu2MZznmxgC9bqC4FXvQ29qcvGcaQW88N32X9GZSDj4nyvWSbXeyNKbmsXt
         4JRhMc/V3VrV6KkQz6IwG7KeukPw4D4iU4UcOKjNt51eWSIovheWHQKrK6D6pc26SvMU
         M59qjMgZjxqucZZW+7iJI269gPhU3SQd5cdQnz7ngpEyCxYFJFccGkoIG+HC7kvjs0+Q
         r+nQ==
X-Gm-Message-State: AOJu0Ywee/olt6qX70AFOX9f+Jw5FrxFsWUtQ3LhVx7ZvF1JAj6CRDT0
	RTreUHFcRyEsLm9UiLeohry9enJ/OL5H7rc0AnGUDtVaA13PdHF96FxaqrZURrr+dOhO5g==
X-Gm-Gg: ASbGncv8HyKVuCwnggmNBsl32vOo30O74zc6ILllMaMcGarbK2z4+5T8+V+Ukwg0e2g
	/Si+EeqBDrNyE8W4o6NZT8NFg/FtS3qFQ5Hc/i19yYjbefXaObIpjc5KyZ09EWMgroYZ9ZLgSvx
	QW7jgEdX26YoaSA8hz9Z1lgz8Fx7ltNGvDjVE6l3Jpwxe3rMpzq19eBnSewiqgMqk0+SJJxOwNE
	NliTB+mFxH7PBK5KGi9t7tB4zGHJKcd1Oltfzc1Cm18GLVEWBhDgUcb5NWNvnxX1MzH9KVs84aZ
	6Wz63HEAVJ8Wg3HNea6PIe2mV1p/ekHDePG5nPlbT39WgjKh2UM=
X-Google-Smtp-Source: AGHT+IH1cPrjb18AhOEjBBnoNjn9lRfpm+TFGy+uNutw2G1RR1QTUsXdFJ08GUV+IIFuygr954TZdg==
X-Received: by 2002:a05:622a:1803:b0:49c:91b7:c58 with SMTP id d75a77b69052e-4a5a57d249dmr17185881cf.10.1749044876075;
        Wed, 04 Jun 2025 06:47:56 -0700 (PDT)
Received: from SaltyKitkat.. ([154.3.36.122])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a591f0764csm42820701cf.81.2025.06.04.06.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 06:47:55 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: sunk67188@gmail.com
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: update comment for fields in btrfs_root
Date: Wed,  4 Jun 2025 21:46:39 +0800
Message-ID: <20250604134710.10895-1-sunk67188@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The inode_lock field of struct btrfs_root was removed in
commit e2844cce75c9e61("btrfs: remove inode_lock from struct btrfs_root and use xarray locks")
but the related comment is not updated.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/ctree.h | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 71fa42ca04fe..9dfe2dcd4a37 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -224,16 +224,10 @@ struct btrfs_root {
 
 	struct list_head root_list;
 
-	/*
-	 * Xarray that keeps track of in-memory inodes, protected by the lock
-	 * @inode_lock.
-	 */
+	/* Xarray that keeps track of in-memory inodes. */
 	struct xarray inodes;
 
-	/*
-	 * Xarray that keeps track of delayed nodes of every inode, protected
-	 * by @inode_lock.
-	 */
+	/* Xarray that keeps track of delayed nodes of every inode. */
 	struct xarray delayed_nodes;
 	/*
 	 * right now this just gets used so that a root has its own devid
-- 
2.49.0


