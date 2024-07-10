Return-Path: <linux-btrfs+bounces-6336-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C1792CA27
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jul 2024 07:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D68D284B7A
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jul 2024 05:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EA94644C;
	Wed, 10 Jul 2024 05:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="J969ASWl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AF1A20;
	Wed, 10 Jul 2024 05:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720589675; cv=none; b=Mu/6XyFUuiLhkIHgh0mFig5UktLcBCklH5qfVOsqHh2XJ7RELqpcygZeDlpZsU0aezb8oalKo2+bzfyq4NPtJz+Rm/Q9L4VlXyzB388laInMcFMK8JRCXrynBAaizlSClqK/3TX0XUfFujNHmwwF9a1CFgyp5BHW9UxsHSxK1p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720589675; c=relaxed/simple;
	bh=Dh8I6DVeDGg/cTYi/jaZpkaj2VEUePLur13YDEdKgT4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O+seGwUprD3AAXyI59Zte052Y4hyQBodPg/SOQYNWqQy9IQn57O6pVOO6q39fOhlMf+tvfIfww1NmILDAcvHcqi9LwVhQQdC0HZTmfL9zwirmw6rMFMeE5S1WE24gXajCOwXnwDNJ7fFJpDKH0rbN4FecHUMXNBi2DaLui8H4uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=J969ASWl; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720589670; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=I2+ZvisetqpXUbVJlEWDiBmdO4OjNz+k9Lyxa5rSvPQ=;
	b=J969ASWlqhg3lS8LDoz8LCed847coiLgjLVeb52xdfX8k+R3cgI5uSwnCCv9FYoc3kVHTlCLxRJrorICOTNPcmAEWWOHEr+YUWdOflX/eVq1j6olPSyhOa/99Eqm12V2AmlAeKO1Xcsd536pM4ykCcWU8vcRp4lNnbTrnFrCfMY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045220184;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0WADz9Hl_1720589660;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WADz9Hl_1720589660)
          by smtp.aliyun-inc.com;
          Wed, 10 Jul 2024 13:34:30 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: clm@fb.com
Cc: josef@toxicpanda.com,
	dsterba@suse.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] btrfs: Remove duplicate btrfs_inode.h header
Date: Wed, 10 Jul 2024 13:34:20 +0800
Message-Id: <20240710053420.23713-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

./fs/btrfs/zlib.c: btrfs_inode.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9492
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/btrfs/zlib.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index decbadc6657d..8aa82ee1991e 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -20,7 +20,6 @@
 #include <linux/refcount.h>
 #include "btrfs_inode.h"
 #include "compression.h"
-#include "btrfs_inode.h"
 #include "fs.h"
 #include "subpage.h"
 
-- 
2.20.1.7.g153144c


