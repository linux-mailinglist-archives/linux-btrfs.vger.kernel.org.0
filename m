Return-Path: <linux-btrfs+bounces-3052-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F734874851
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 07:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9B91C21590
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 06:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED6F1CFBC;
	Thu,  7 Mar 2024 06:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KdsoL8I1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956B9CA6B;
	Thu,  7 Mar 2024 06:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709794096; cv=none; b=OCZEsJ1ZnElOCNTdkeiX9KT3cq4Qd3JbN5pfEGUgYl8pfyPNhEFz5TqfGKKR6k5+IDx/dlf74JTjHs0HtGqfcoXtdAk/8QKaHuUfVu/qtiZMw3j+y9hjkKOREvFrpDYdthav3P4+3MQWU+jlB5SAh4yGDOWHve950ExKUvCCO0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709794096; c=relaxed/simple;
	bh=CmO2257QuqH44nTghzgymkCgYXXj6YJ5RsIdSqMmr2U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PEYlLGlSqjaGzqSntreRB8FO7AG6AvEtkpCPKtMgkDaipY8GLPQgbmIKM01bJYV9OXUy5gc8+G8tELoaGz2wHrl1+Kn1dCwIGZHmdxXJ2HwMG/87QV/An/uztN/x9RugIB7/Z05ERue/Sf0xAcig6ScdTBtD2fgtbgaLMLmy/Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KdsoL8I1; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709794085; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=hwLsWVyYaQavvqdTHFAohjNoKhfPvj0KlLidtOHVrZA=;
	b=KdsoL8I1UAkNvTF1FWI48UGLE1d8sSJIQ2ypwfE7A4D+IxMeqZvKBKBMGLZt9mi4j7wZ4jqpOstYDSRotOgZ5PNcs9cc3fjMuY/DBkevjYMbCd8afgurGT5+saCs2NVUzmQhkY+aKMOMeVuQDXhVFpvc9qYN+QHxadtdSOOh/WM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W1zkUQf_1709794074;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W1zkUQf_1709794074)
          by smtp.aliyun-inc.com;
          Thu, 07 Mar 2024 14:48:04 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: clm@fb.com
Cc: josef@toxicpanda.com,
	dsterba@suse.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] btrfs: clean up some inconsistent indenting
Date: Thu,  7 Mar 2024 14:47:53 +0800
Message-Id: <20240307064753.36780-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

fs/btrfs/volumes.c:770 device_list_add() warn: inconsistent indenting.
fs/btrfs/volumes.c:1373 btrfs_scan_one_device() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8453
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/btrfs/volumes.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a2d07fa3cfdf..caa3e83b0d6c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -767,7 +767,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		if (same_fsid_diff_dev) {
 			generate_random_uuid(fs_devices->fsid);
 			fs_devices->temp_fsid = true;
-		pr_info("BTRFS: device %s (%d:%d) using temp-fsid %pU\n",
+			pr_info("BTRFS: device %s (%d:%d) using temp-fsid %pU\n",
 				path, MAJOR(path_devt), MINOR(path_devt),
 				fs_devices->fsid);
 		}
@@ -1370,8 +1370,9 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 		else
 			btrfs_free_stale_devices(devt, NULL);
 
-	pr_debug("BTRFS: skip registering single non-seed device %s (%d:%d)\n",
-			path, MAJOR(devt), MINOR(devt));
+		pr_debug("BTRFS: skip registering single non-seed device %s (%d:%d)\n",
+			 path, MAJOR(devt), MINOR(devt));
+
 		device = NULL;
 		goto free_disk_super;
 	}
-- 
2.20.1.7.g153144c


