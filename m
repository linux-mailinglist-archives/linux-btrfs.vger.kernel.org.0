Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4D13F1930
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 14:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239449AbhHSM2D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 08:28:03 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:46903 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239271AbhHSM16 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 08:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629376041; x=1660912041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2JTgZ+t51DrzBD/054qtVi6rG7eyH6kwOLyaq/fxBxc=;
  b=B8FwRkEA0iAChkEIyrmfU8V0s5vUQLYRD+4MouOG1q5cbHSp4UIGLNxT
   2w2dw5mKkoNyzf03gL1u/oq3T8Ilxa64ih59aYL2Mkf00WZAKmTd6DmIA
   kBc9aR8WrtGE4Q8usB5C9wYPPR5Wwm8nUQAMoX3G9JelgQ/y6EsgzEwZd
   5j1sHjLS/tjfdxRjw+SBrF4hfqwOgbXyiRPXPyPchaP6bt5GdrZuikMvM
   bjNvi5ZzA4B7C3wW/774m+a3ZUo63AuRGzzD3Ycotm3WkowqglwfWVghQ
   wKhxe6C/Z5L1Y8CdC53dR8ZaAhXArJxHrQ6XMGk/Qjdb7uwSqT2bEWNpI
   A==;
X-IronPort-AV: E=Sophos;i="5.84,334,1620662400"; 
   d="scan'208";a="177773616"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2021 20:27:21 +0800
IronPort-SDR: LrigAq+ClKFY2T3PgonuuhtXGm0/B/FiF7H4Thps+oBwdz2AhC5Ezw/4y5svvrv5ijOMo1kTP8
 /gCuZK9vNtIJ/KCRDEWeFoBnf79dxjWbGFAO46ULz+M9RbN4RBTRo+M8AQ9kuQ1LYZo5bkY1Bs
 rGjvTJwqNZIDg9k8E68M+BcYch2QftcyoFuIBsudF6iHYFj4kiF1rjbsKtpVenyGM0omjrhNpo
 +Em88bqJ/CP/EYmuUuuv//nRKTKfhODwfgWChNABcueSHECUEM5f1aklIQXkTe2pfm+V7wIIGv
 jSz+9CzC1F36lBo6/8CuHj6D
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 05:04:29 -0700
IronPort-SDR: pMah6UjPyJ3klcn88YH9VQO7rDniFe1wPHbPm7UqM0aHpXPpm3h54wsh0fr0hpy3pX/D0AlNG2
 hGnqJatSEHPro1fRrevBdtDBzmfU802o4uieiP7agJ2acxVO4e4ArwcMUbPu1jcWqiX+kLZnGB
 DATBpP5hN7i1qQwSapYHMWDuRr3GVk/VmmkJpz7lOggk0k18P8BTsJB3A7yMOKVmlPr9WtS7Ds
 eSffZRh+PtqRWalixkMQFwJbGiwGlErM1nfGSf3AVlAIeujyfZ67FgrmUfW3/uQmWBd1EdcyVF
 pcQ=
WDCIronportException: Internal
Received: from gkg9hr2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.52.110])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Aug 2021 05:27:21 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 13/17] btrfs: zoned: activate new block group
Date:   Thu, 19 Aug 2021 21:19:20 +0900
Message-Id: <4c886c670310905a4ac104b735f5a4d4a216ed78.1629349224.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1629349224.git.naohiro.aota@wdc.com>
References: <cover.1629349224.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Activate new block group at btrfs_make_block_group(). We do not check the
return value. If failed, we can try again later at the actual extent
allocation phase.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 90c4279592a0..f4fa65438eed 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2447,6 +2447,12 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
 		return ERR_PTR(ret);
 	}
 
+	/*
+	 * New block group is likely to be used soon. Try to activate it now.
+	 * Failure is OK for now.
+	 */
+	btrfs_zone_activate(cache);
+
 	ret = exclude_super_stripes(cache);
 	if (ret) {
 		/* We may have excluded something, so call this just in case */
-- 
2.33.0

