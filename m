Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98047A0A70
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 18:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241885AbjINQHv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 12:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241877AbjINQH0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 12:07:26 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D1E2109;
        Thu, 14 Sep 2023 09:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694707642; x=1726243642;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=/fWmE+uB6+cLnKgUKo0l86vqhneVO3Sjo3PEyQRxI/Y=;
  b=Ff26f5aOS43NVuQODJamUwVSmfk4lNW9GIr15krnxTU2h8MSJNfZjp1G
   BjXzaHx9YSaJuDYzhfD8eyeB+tSVAf1RLfkE8IiXq6hXwmYoWqyVPQ7y3
   6wFHDws+2m7+RjVQEJImPWBx6QT9vo5ClzJps7RsLxX168c7Pug3/FOI4
   kyWHWfy4ou3CNGtW5+mOoQxqNZWa0Fy3NzJh2n5cCaSY4uzGOSC/9oQxW
   wRLFrlAk0aeFswzmoK/ejNNVYrEQUNCr0OtY2FoNnBva6Hs8DLifO7o+n
   fD46hVI9H7LPVemPzIqaykOUwGukpzwHurfwnicgEXbnTYoLs2bKqcZYT
   w==;
X-CSE-ConnectionGUID: ijtyTw22T9yyJRVRUCVDXA==
X-CSE-MsgGUID: iiPjG7IARIyMSibIPPhIcw==
X-IronPort-AV: E=Sophos;i="6.02,146,1688400000"; 
   d="scan'208";a="248490573"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2023 00:07:21 +0800
IronPort-SDR: RaJZJs312+8yF5+dZ5R1vtNzP1DPHx9TiM6zZt/3dBUPkbYK87SEwFqTP+fKASwfjYQ0XmQYsy
 F13Ekxa19Z9rjcYHOJuCjVWuQsqGvfjkJdiD4BfzH3f9DlC27TyCAGKU2cCf69Ws/wOb8AOGXm
 m5bDkmqEY/zJV615Ay56hzk3fCvizkHTzhzNllD/063at+ww3jGPxtEKy5D/Nh6Eyqizr7Gvcl
 cBlZCxG37/ETPLVNXrwBXr8crP6dPV+RTQiRSRMZoJ9hl7aQvVoNeX1pQGyVm7/lGjBTE+H//3
 TSg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2023 08:14:23 -0700
IronPort-SDR: 75PiryJ87YXpE26JXhHlYbdzH+7UKP6OZCuyxhnI28FBl10PVmgVNVXMBSsEjiwIFvdZ1UXkv/
 yhf6boxZgiRRpWfvUbhfa1cxRMX+NMyFNluo9RnE6dOCciLDwqhqO3Qnb4gydeRwopxWP5K4AW
 1Q3DD+cNmG7olLNiPtq1UqzydH0Mm6IJvGIEqN7HwYoULG4dmOD0t4hZ/GhGKgqrtX4j5SVQwt
 KvxLOgYlRX0QKj10LG0rPmBqm96VEwkO10G+N6ZOxR5gmo1N+dEHrZUXsaRctRwD1brSMpcQ3n
 fPs=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Sep 2023 09:07:18 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Thu, 14 Sep 2023 09:07:06 -0700
Subject: [PATCH v9 11/11] btrfs: add raid-stripe-tree to features enabled
 with debug
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230914-raid-stripe-tree-v9-11-15d423829637@wdc.com>
References: <20230914-raid-stripe-tree-v9-0-15d423829637@wdc.com>
In-Reply-To: <20230914-raid-stripe-tree-v9-0-15d423829637@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694707621; l=775;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=/fWmE+uB6+cLnKgUKo0l86vqhneVO3Sjo3PEyQRxI/Y=;
 b=/C47RMNPoCTeCb2qkXbWbQIU0ZEwwdrRMtpSq8JkjzqOmqd+FSgvX1kpR/NcWZaczD7R6lQcI
 OciV2JTShDiCHTpq4QBCb9vyC1n2THbrm2wUMG33IjUwmYaZZd4Soj9
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
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

