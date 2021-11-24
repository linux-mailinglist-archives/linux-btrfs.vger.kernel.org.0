Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA5E45B779
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 10:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236181AbhKXJeQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 04:34:16 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32168 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235832AbhKXJeP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 04:34:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637746266; x=1669282266;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x7yvu98ERR/ovrQiMkVrafuES9bRSxEkK10e5TDFVoo=;
  b=CVwxxmrc6+nbZha8dOFwWFUg3nmw+Nu3R6zTodTR9qvuG3MXq/4EMikF
   vQoShQB2IUfhz0+orSeJFxSWdU6g/w+E6Y7M1dTZyAwDu+ZvYLTcNE1kk
   Cg2mlwV2p8s7OIQl5v5QEAbFVhxq5HXeAh91cBNDq4o9V+LxSXXGA3mkL
   ihIg8d9ZEzmIZdnaYX/wzXUyQUQWckq8axrRxPVj6bLx3nTWUc8q2ahm6
   F6x8r400YSm8sFbW8EXU33fjKmOzTIrpQTnwV2sOJyr11anLWx+RcOo6r
   waEO3ti0BlP5hqSB+QkacirtRqFkw0gOJU9qw5RuZUmSeF4yCTp3EmAzo
   A==;
X-IronPort-AV: E=Sophos;i="5.87,260,1631548800"; 
   d="scan'208";a="185499382"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2021 17:31:06 +0800
IronPort-SDR: 1o4wHzPUVm1INkpbHAMsrgnGWx5vY1H8i4Ayg0XVTiLCG9qP3LrTJqG93H0vruKBSl8IgRtukq
 is8HIuKArf2qtoqrWKnUtY2egwgG5qk7sGnkspsiQUlM+6a1EwI1+NWQf/DAPczTRvVnWWX4ge
 NNH0lTvgUsOKdPwWWFidIox3sh9SnBVrbo0yL7x8Qm8caaYLR4uUBbt/zBC2/gJt5knebIBYtR
 54qKz1qObkFIVZOaIdwf6qPUmDJdeTET44PTCowoNuwsleYyfRR3mWZ6Ttmo9FdiXj002RTGXn
 UI/HLB4oQpwdtDxWb0cj+z8E
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 01:05:59 -0800
IronPort-SDR: JfG9/BYsNmzqU76nrIo5G0xuEXr0NPm43ejKlyRz0g7Xy9gC5/WzXhY0FiYTsr8k/09quZ4le+
 ptt0u56z4VYQo76aJldE9RSaCWuD5i9Yvpjp+Gb70DsMYuVLxvkpX7PeaAcXnfAb8+5blruUyJ
 2gdnKCkCsS7D7HvlToJjs5G0xmqSvZv+YrIl2Uy5ikr6ACIYeu7JZWwrsioiWLQM+F/x3mPnUb
 MGKYV//EdXocKM702NgWqgxkhwtEaB9pkZhHO7dNZms9qmd2YcBNENnReojoeK1uJLOee+PZlC
 qAs=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Nov 2021 01:31:05 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH 09/21] btrfs: zoned: skip zoned check if block_group is marked as copy
Date:   Wed, 24 Nov 2021 01:30:35 -0800
Message-Id: <9cf41680544814baa4fe3ba3424a01a47475526c.1637745470.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1637745470.git.johannes.thumshirn@wdc.com>
References: <cover.1637745470.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When enumerating chunks for scrub, we check if the block_group is marked
as to copy and if yes we skip the block_group.

As the to_copy logic is only used in a zoned filesystem, it's pointless to
check if the filesystem is zoned.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/scrub.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 30bb304bb5e9a..70cf1f487748c 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3732,15 +3732,13 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		if (!cache)
 			goto skip;
 
-		if (sctx->is_dev_replace && btrfs_is_zoned(fs_info)) {
-			spin_lock(&cache->lock);
-			if (!cache->to_copy) {
-				spin_unlock(&cache->lock);
-				btrfs_put_block_group(cache);
-				goto skip;
-			}
+		spin_lock(&cache->lock);
+		if (sctx->is_dev_replace && !cache->to_copy) {
 			spin_unlock(&cache->lock);
+			btrfs_put_block_group(cache);
+			goto skip;
 		}
+		spin_unlock(&cache->lock);
 
 		/*
 		 * Make sure that while we are scrubbing the corresponding block
-- 
2.31.1

