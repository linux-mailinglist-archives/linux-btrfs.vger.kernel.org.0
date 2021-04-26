Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1BA36AC38
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 08:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbhDZG3S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 02:29:18 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41951 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbhDZG3P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 02:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619418513; x=1650954513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JMZc7s5PWSv2sdJtwJrr2lOzFkA8DgKfyV+RGbXQ8BU=;
  b=di0eb54DppjLEIpdVqTN8WpcOkwAcgPgamQX6rptIzrNarWzi4iDObUF
   CbrvLZ+Y/nTsBe+TlK17S7S1mJwIR7xN6sV7di4u948S6qL75YGsS1tEF
   wl/vDH3HBUzVt/GLQh1mtaoc/zPvyTjfaEty5MJq0wO+pjrDVdcp1JGQ/
   sMC+7AO2Yvg6sJK7smQaRO6cLhDTs87Ssdzcz0tEIVIw/hB/BtMu1TUQM
   FSN7sXBFTu+IgyqE1+HUCizQAFsIQD74kSU4kroFwUd8Vt+8Wg1ZC7V2N
   O4tTazKFaeGxz6eCMS5jUxa/oHKtqjc702fpcOJ7po6Dnvng5Eu3SKQb3
   A==;
IronPort-SDR: MVEBw+ovgQv6OsSz0L9N63tKBTdi2SELaJdR/Hq2YqyLsqssXm7lraufGW52sG6iwp54seORci
 usE/cyTLb329YBYkl/xvdtb5S6SJqc91MD0ymFUZQVbOpMJV2clWZqyEXiap5YAaPu53NohMgZ
 cAu+o6WOrxLjFR7wtOTnLL8Iw9spocimjflPYsbjsQnZ6KkWwXNU+q2SPUvr1EJc7Brs7BMMhO
 N4Jgtt13rwreNJ0tCVUb/hpmsLsFb/bXJ005dmjqTGofidwRwnlDRV8pMLif+sipTec8BuI3GQ
 GBw=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="170788142"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 14:28:33 +0800
IronPort-SDR: JlAVwbc2QeipCJd3YRPKa7uZQ098mlORQjhOaz4wTil43tml+RtEqaUv+TSEfKBD26GFgNzXJx
 kmjnjWs1shs9AnaAVd7JcpXXDuRhIctvPrAPPqbpvEtFEiZ2c9LPF06jD5dzf/pX/hn2qW/bqv
 G64YsExEzrYJK1DUyMERXAj0OCfQR0/TCQJElpgtHRWiPo9wbQMtCC5DWjJ/iNMXxSYbYDsgr7
 /dkiuXs/JU7xCD2o241EYmJQmNVPOh8PNyZoDejbh2si8bvnuGLLFbiuHxZxUo4Eqi30ACbWk9
 +lIhlPp/nO1l8dqlPSnLbwVU
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 23:08:58 -0700
IronPort-SDR: jePceaJEY0K8E/1Np1VLQUveU6e0n75LgvqEVirFGHbIuepCIJbXYPrU9pXMsJ2mBmXitL1abX
 nsI20wmOc2teDdAsu5mwer3KQ0a8pQ5DLXyVh60O5MJ5gzAXFi8X/KSMsHD3Pd8caL9WqRpbxL
 kta4xEkRSedkplYTxutxhVoiUIvhRpqK594HK5pVVVVK3YgNmQtOJhaI42WqN4iBeb9RxZvkx1
 b3M4uKyplk1nEpRBd46dAu1zOXQInJyZbsMLS+znXdgayNPYNllBwJSn12LqIymLyqS3ZEFW0L
 rOw=
WDCIronportException: Internal
Received: from bgy2573.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.58])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Apr 2021 23:28:34 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 23/26] btrfs-progs: mkfs: zoned: use sbwrite to update superblock
Date:   Mon, 26 Apr 2021 15:27:39 +0900
Message-Id: <cb65da8937e76d2c18ced31b16cd97046ada8789.1619416549.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1619416549.git.naohiro.aota@wdc.com>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Use sbwrite instead of pwrite to support superblock logging on zoned btrfs.
In addition, call fsync() to persist the superblock to ensure the write
order. It also helps us to detect an unaligned write (write to a position
other than the write pointer) error.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 mkfs/common.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index 3d10ad086754..cee6a54ae7a5 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -473,13 +473,16 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	buf->len = BTRFS_SUPER_INFO_SIZE;
 	csum_tree_block_size(buf, btrfs_csum_type_size(cfg->csum_type), 0,
 			     cfg->csum_type);
-	ret = pwrite(fd, buf->data, BTRFS_SUPER_INFO_SIZE,
-			cfg->blocks[MKFS_SUPER_BLOCK]);
+	ret = sbwrite(fd, buf->data, cfg->blocks[MKFS_SUPER_BLOCK]);
 	if (ret != BTRFS_SUPER_INFO_SIZE) {
 		ret = (ret < 0 ? -errno : -EIO);
 		goto out;
 	}
 
+	ret = fsync(fd);
+	if (ret)
+		goto out;
+
 	ret = 0;
 
 out:
-- 
2.31.1

