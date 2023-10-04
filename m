Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25147B7935
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Oct 2023 09:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241638AbjJDH4f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Oct 2023 03:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241615AbjJDH4a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Oct 2023 03:56:30 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B66AD;
        Wed,  4 Oct 2023 00:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696406186; x=1727942186;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=e+YyfDQ1PFX4rBIrEPfhcrCD3fDnJ1asPXocJQ97CxI=;
  b=SuLQcE6nxGiyHpczPQsdRu7srg1pvCyfnESJZ7xJksrHuayQzr7XQaOR
   CAwWROa/jJh7FrbDZhTOfa07hYmwJ2yp7Dn3/DM85d27rl1DP2RvCRe9Z
   SRjKhhLEl6TBjfBWHDMIWNu+V4WvU1hydgnWySn95U4JzrF2blK0DgQJw
   IBqXQi03uJqAGoPa85Z+u/fsYfC0qxNeZdDVOs71Ur9QbDAvvPBzsGz9H
   eukpupsziGqvnVIqSyjBWpbzSnqg9BlRZ8ximqcabJM3lrCXI8csa2yz5
   wgjRECJ5JbtL2wWDrbAJsHMn8lKIcz9VmqYKSbU1fBFxPrOV1UQLqQA4l
   g==;
X-CSE-ConnectionGUID: Rvl5g4JMQ8WH70Gv/dU9mg==
X-CSE-MsgGUID: d9t3ZTI4Q3qkp4r6aaV0jQ==
X-IronPort-AV: E=Sophos;i="6.03,199,1694707200"; 
   d="scan'208";a="351024168"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2023 15:56:26 +0800
IronPort-SDR: xPSh7UtJYUKBehJmvRyje1nbOEgzPNbjbs/Yzlh01XhlirqGV7UQ1XmGSZm8BoA6dlRiEJ2DJH
 pkwTJeE6dtU/mgjfzqXcjw/TDIjtd6VIHqlsxhg+LX4gK6XVdMfdwbTyCVE2/Tci3fwMQw0W/x
 +Suv6DAJpOAfGQa+wgKhFdSTsF/XWK0Y2cYpRjt8aCM1kpzpVFdHi8pnCGTJrSDvDTw7Pki/I8
 /eX8lZau+C+jAkLcsLxX0m9eRKB4ArvFmJq5D3P8PHa63MjTgt79lt63RwTqLumjERo5YvDGYf
 b00=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2023 00:03:04 -0700
IronPort-SDR: N503Q1l6AQ2yqCQtEZfqH3hSDxANp+eLAKJrvkCh9J4SSOIlycDddY2QJEgYBgXtXFlwMY+7yD
 H59TshsF7ZIJMxi9H8/8GsOI7gLaXaMbzM06/Fe/WI5l/06DtwMDYwxq3k8yxtpr0FRz1SVtSl
 cCNF09WcuMvjedLBeK/0HUpCbhOP+u1RSlKwlECTNaVswS0DUelCtaO1zvIzIvAo9ppUXi7s9H
 k2+ZoKUtU+aAULQqS/z5Wt8YKgMRg+wwYl+wVEWo2CXMn3LN9GVprzYZAnAcXoorRa/6MYW2c0
 RHs=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Oct 2023 00:56:25 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Wed, 04 Oct 2023 00:56:18 -0700
Subject: [PATCH v3 3/4] btrfs: remove raid stride length in tree printer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231004-rst-updates-v3-3-7729c4474ade@wdc.com>
References: <20231004-rst-updates-v3-0-7729c4474ade@wdc.com>
In-Reply-To: <20231004-rst-updates-v3-0-7729c4474ade@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenru <wqu@suse.com>, Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696406180; l=903;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=e+YyfDQ1PFX4rBIrEPfhcrCD3fDnJ1asPXocJQ97CxI=;
 b=+Dk11t5dxqsV4xH3DcQn0eUXJ+m+asjEZZbUU4ZqwWJM+BSx7zTVyvSM6tqpdmJ4B3/bT9dHA
 7HDB8bLUa5YC6LsjTPSQchwKFOUV0vBdmhzAMUF4d6GKG9iK1FKPWDZ
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/print-tree.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index 2ade2672ed58..7e46aa8a0444 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -215,10 +215,9 @@ static void print_raid_stripe_key(const struct extent_buffer *eb, u32 item_size,
 		btrfs_raid_array[encoding].raid_name : "unknown");
 
 	for (int i = 0; i < num_stripes; i++)
-		pr_info("\t\t\tstride %d devid %llu physical %llu length %llu\n",
+		pr_info("\t\t\tstride %d devid %llu physical %llu\n",
 			i, btrfs_raid_stride_devid(eb, &stripe->strides[i]),
-			btrfs_raid_stride_physical(eb, &stripe->strides[i]),
-			btrfs_raid_stride_length(eb, &stripe->strides[i]));
+			btrfs_raid_stride_physical(eb, &stripe->strides[i]));
 }
 
 /*

-- 
2.41.0

