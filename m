Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D1C45B780
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 10:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236624AbhKXJec (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 04:34:32 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32191 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236365AbhKXJeY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 04:34:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637746275; x=1669282275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mMAauS95dagPEwAA3C5sY5b5r8u/OUswGaLfT1rzYfw=;
  b=Vo3TdTfpAscFdF3YMpZfHeysm0FbDt7xeIu4zkCBzR03kFdRR/QcY80p
   65Qfq1awI8xih3UHfxnAt7JiO3zIDXOSSo5X/UXhtYg3u/r6EqqCW1MHz
   aYjtjwA1KhwkWLkhdRISFZPDw0xSK0YyK8nqY2T5y6aFX/OnhU871hI9r
   3h3pWccUXA/ntRk7NoSUaic8xTqjaSyWtSLkK3AWWKFqXEik3yFYcVWe0
   dYJzkVgfAAbhPDALZfLx5AubSmWELrRPGXK01cHH3qHI3B00/3mQAYzrW
   uFm8PLzHEA+O9oejPH1t43S+whOoJx2XquQkvclUpFHJMFYrxqIrXEnUT
   w==;
X-IronPort-AV: E=Sophos;i="5.87,260,1631548800"; 
   d="scan'208";a="185499400"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2021 17:31:14 +0800
IronPort-SDR: 0Aod9BmYCC4yqS6Qm5diVgvKH/rUOfwehYJ6XGrz9ljkdPoI55n+qEk02ggeiUEsimE/HDZ4Ob
 DJ9/gmsYOcD9qVEO526agpjlurKL+16LVx3/KF2/8YqT0kddvryF/C2yh9LNZEbefGbX2Y+P0B
 oQiDtjegsx7IBfFMFH6tVYls6133K1H+xvj3iNouUALZre7x+jWj5CuBmq1p2Pv9oeL3aijfuG
 oFxzvFAg8I1fCQp9Mz9OfhBrc7+ombWvNEpJ408nyx5lX01SoOnEmHatXz8GktCgSVKPPmfjqG
 B4xtPN91MIGzf4zeOYv1/VdQ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 01:06:08 -0800
IronPort-SDR: Ejk4Fitn42JkSyaaPfW+v+9hafPCH/AVrPbDulk5Qy4hF5UV9WD73MR1/Idk1DBvScaGjFzNBP
 diJ+cmAXxT3kqPSrtxQQF3eWayhzihL5ryTN6rXWuaGemaKn7Sd1tV1s3/JcGmOvK7eKXEMWm4
 9FJiVJ7bKZKlmjfFG0mLFNiAPv5ag/zJyhcNDD+z7XfyYftEu2OaAziWYtGYTkLXq6t93S98NC
 ncTZPVpcEAMSMchDl51fFbgk8hXRPu/aA+Im5XmlPBJyRwW9wO5hNj98x4fKSleQ5Pv03f9W4Z
 nsU=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Nov 2021 01:31:14 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH 16/21] btrfs: move btrfs_scrub_dev() definition to scrub.h
Date:   Wed, 24 Nov 2021 01:30:42 -0800
Message-Id: <4344c424f8638151bc1faeae080644a7dd1f488a.1637745470.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1637745470.git.johannes.thumshirn@wdc.com>
References: <cover.1637745470.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we have a scrub.h move btrfs_scrub_dev()'s definition there.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/ctree.h       | 3 ---
 fs/btrfs/dev-replace.c | 1 +
 fs/btrfs/ioctl.c       | 1 +
 fs/btrfs/scrub.h       | 3 +++
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index f1dd2486dcb37..c050c47131760 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3801,9 +3801,6 @@ struct btrfs_root *find_reloc_root(struct btrfs_fs_info *fs_info,
 int btrfs_should_ignore_reloc_root(struct btrfs_root *root);
 
 /* scrub.c */
-int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
-		    u64 end, struct btrfs_scrub_progress *progress,
-		    int readonly, int is_dev_replace);
 void btrfs_scrub_pause(struct btrfs_fs_info *fs_info);
 void btrfs_scrub_continue(struct btrfs_fs_info *fs_info);
 int btrfs_scrub_cancel(struct btrfs_fs_info *info);
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 1fcc5d57e96ef..bb325334333a7 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -23,6 +23,7 @@
 #include "sysfs.h"
 #include "zoned.h"
 #include "block-group.h"
+#include "scrub.h"
 
 /*
  * Device replace overview
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index d7f710e57890e..cc2e1297ca250 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -50,6 +50,7 @@
 #include "block-group.h"
 #include "subpage.h"
 #include "zoned.h"
+#include "scrub.h"
 
 #ifdef CONFIG_64BIT
 /* If we have a 32-bit userspace and 64-bit kernel, then the UAPI
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
index 8d17fac108556..9ff9d3e033b25 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -50,4 +50,7 @@ struct scrub_ctx {
 
 void btrfs_scrub_submit(struct scrub_ctx *sctx);
 void btrfs_scrub_wr_submit(struct scrub_ctx *sctx);
+int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
+		    u64 end, struct btrfs_scrub_progress *progress,
+		    int readonly, int is_dev_replace);
 #endif /* BTRFS_SCRUB_H */
-- 
2.31.1

