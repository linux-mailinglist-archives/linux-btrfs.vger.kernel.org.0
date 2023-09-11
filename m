Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A4879B544
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 02:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355608AbjIKWB1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 18:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237479AbjIKMwr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 08:52:47 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15161E40;
        Mon, 11 Sep 2023 05:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694436763; x=1725972763;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/fWmE+uB6+cLnKgUKo0l86vqhneVO3Sjo3PEyQRxI/Y=;
  b=AaCNvq5+j5JKtqGZqtug1workw7YxvixkAf+lSG1cmkYgZffYzRugZYE
   ElB12DXXR5Z5k5q3jILOBzfwXzr3VYcTbockRKgOh6iP79sCS4v7zp+Lr
   9HEAYk1iosh4p0RbJn8LjKPRcELKRp5drW7QM2whzLqurv/P57TfJ5los
   TFEyJHRScXwpJRoEju8WnNeCCZkMdBp2pqsuXF0yVVd13Dx+lGzKFDIeC
   3N449nDrvsteB8HPOZGsdd1TzXczDKThQ+6kMQNO/VDxXBhYDIx396DSK
   ces7/h/OmcHW/YfW3/1o3vsgGpU4Pyu1t39XHSFEi/cjv5JqDdjEG3Lf5
   A==;
X-CSE-ConnectionGUID: xKthyqHtQPSEJ1EJNU5sSQ==
X-CSE-MsgGUID: jcN6phx6RMOjd3en2AV3oA==
X-IronPort-AV: E=Sophos;i="6.02,244,1688400000"; 
   d="scan'208";a="243594410"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2023 20:52:43 +0800
IronPort-SDR: y3MTalOFKWs4gVTHnOG1qBJhuSTMCG3yVzb6qgtwZJ47QZmCBHF8HKQOnWJLrGwDTOhiRTL0Nf
 QluLaLpKkKcaD+cgISxVvRyjvRBFJ0Wqq/XVsNsBmHHYy2dxuwzzJSy9zcFki5vnYWGa9Tc5oX
 YpE4c8T4FpiCNg4rmuk1WciaLF5H8KkMkwIhgQyCXD9wT1I4I2jHUN/Y15SWL8mnK/guF08ZDd
 WQbWIPnB6RPgm9a5NX4DLK1YfdNTi3XhoPLFxt0SZP6drtCLKXBew2q8UpYbgwOSNHY7IVtEcJ
 cJA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2023 05:05:29 -0700
IronPort-SDR: 3btV4OVI8RNYODwm1XbMQDlmqWQijaR4Ytic85YP0CLWv97BptziphRBsy7D4tZCK1jzIi9YqI
 Oankj/BPIDEC341tgE0buQB2/qwxZ6+Cf9kWxe26b7LJCjJu+jzrUhJsG7U/gJ6A2hwp3oBYj1
 htdgtXMcBVsqpnWVagQicXixRjG6KJFdWj29Jrpc5EYVgSZ0ov4m/RXUigLvPiidN5utcULOHZ
 6Cld2xMlvFOvqN/uq/ZJKeF9wUusa9Q7du7/jA75x7qNhfp5P/bpbsVrfZFkd96Y6SuMC9o7l1
 Lrs=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2023 05:52:41 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 11/11] btrfs: add raid-stripe-tree to features enabled with debug
Date:   Mon, 11 Sep 2023 05:52:12 -0700
Message-ID: <20230911-raid-stripe-tree-v8-11-647676fa852c@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
References: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694436627; l=775; i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id; bh=/fWmE+uB6+cLnKgUKo0l86vqhneVO3Sjo3PEyQRxI/Y=; b=Su1TKBOnkmZ402g2jaDHChVW8ZW+tVw98E6A9CWMfigW7vRAAl0HMgD4tmh3XAAV+1CX1c6RY 9K0VQimL/l8DGEapVFrsFibjCpMVk2VZI39rad98kMcRFKfL2ed4zTG
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519; pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Until the RAID stripe tree code is well enough tested and feature
complete, "hide" it behind CONFIG_BTRFS_DEBUG so only people who
want to use it are actually using it.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/fs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 5c7778e8b5ed..0f5894e2bdeb 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -223,7 +223,8 @@ enum {
 	 */
 #define BTRFS_FEATURE_INCOMPAT_SUPP		\
 	(BTRFS_FEATURE_INCOMPAT_SUPP_STABLE |	\
-	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2)
+	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2 |\
+	 BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE)
 
 #else
 

-- 
2.41.0

