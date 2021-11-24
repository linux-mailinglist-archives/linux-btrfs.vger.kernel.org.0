Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E7C45B774
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 10:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbhKXJeK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 04:34:10 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32168 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbhKXJeK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 04:34:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637746260; x=1669282260;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R/Lph/a8nHCftXszb+5s0kPt/bO6HgxadgO6TWN0U6o=;
  b=OrzeFTCP0MtiPtZCBWZLWqffIIgax5t53LDue4t0EuYGsg2fXVAwhNVM
   yjG4FBemKfKA91g54JW2b4V9wvll2o4Wge1KW0+Q46Drs16mmtssQbg/N
   eGiiyrV5ba8BacKjpq4OPhqLgepqVmrmjU4cV54BFvRD7AeoJAwA9oC7+
   n1ur1sbwVAkZqV8g2fi5xTwGM1l04jhSX6FBwhlXROhvhuzoZZ0GvGwq/
   JPvSdD5YKO6my7DTI3j27RDd79V2BFF39odG9IjtAcbFD2BZR85XzrBk0
   x0ngVu2yJzvnOPwZJyD7STlaEl9/Wnkp2hSOEqqV2Wrz9nXp5hXLZunbJ
   A==;
X-IronPort-AV: E=Sophos;i="5.87,260,1631548800"; 
   d="scan'208";a="185499363"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2021 17:31:00 +0800
IronPort-SDR: jIgxKFzzpatc7RW32LoR55m0n6MPDn9SiUXNgW6+tBYp0zak1guN6tEJq1MDcbaFdVx7w2dWq5
 5WKKeKP8FPpqEkDDg4QWL4e/cGrekwB1n7Di2Sh0uMMpSMrOK10jexJuUx3yWCO8hH3MHC1uKG
 2bcdxWdhReaovElpqaAYfpcMSBTYqXw91fqBSqA0MW1HqhYpoo3C6CBw/4VRrw7yNs88A10wDD
 zkUpbaTL6NCsEmi7sobwsMURtbDRlNPh/dI5FpmZ3yD0JVVkWsodwqnpTqUD+xBFcrHSuzy8rq
 Y+QvWKRl2pgPH+Z+KXg9SLFs
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 01:05:53 -0800
IronPort-SDR: Cd30PMbst6NJqB0cYEjYryC2ukR0JwX2jD++B5S5u963IOLE+mcYLmd4DysrWiZU5szCuD7ge8
 JGdHTIGLmJ5Y2AtkTyd3KTIUzyQ07lseea9+Sz7FKbeOw3cp1l13msdaU5NllKVwBhgTnkkfEJ
 lAYYOduHKrvAGSCEQyL7DjNDoxkJjZwtwlSJxwjNyFMtzXOJYuND4w2ve3MsDqA+igETC7VLsv
 iaKXC4ZHCsiYuR7XTXOb/epSZZ8UW1+Mj1NWIE/7uXDmrDM50B18GTBEbsFwx8A9hQTmBckYNu
 UzA=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Nov 2021 01:31:00 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH 05/21] btrfs: zoned: move compatible fs flags check to zoned code
Date:   Wed, 24 Nov 2021 01:30:31 -0800
Message-Id: <dd096a7fac48e8314eb43b3f4a17fa5e4ca56c53.1637745470.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1637745470.git.johannes.thumshirn@wdc.com>
References: <cover.1637745470.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

check_fsflags_compatible() is only used in zoned filesystems, so move it
to zoned code.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/ioctl.c | 12 ++----------
 fs/btrfs/zoned.h |  9 +++++++++
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 05c77a1979a9f..d7f710e57890e 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -49,6 +49,7 @@
 #include "delalloc-space.h"
 #include "block-group.h"
 #include "subpage.h"
+#include "zoned.h"
 
 #ifdef CONFIG_64BIT
 /* If we have a 32-bit userspace and 64-bit kernel, then the UAPI
@@ -192,15 +193,6 @@ static int check_fsflags(unsigned int old_flags, unsigned int flags)
 	return 0;
 }
 
-static int check_fsflags_compatible(struct btrfs_fs_info *fs_info,
-				    unsigned int flags)
-{
-	if (btrfs_is_zoned(fs_info) && (flags & FS_NOCOW_FL))
-		return -EPERM;
-
-	return 0;
-}
-
 /*
  * Set flags/xflags from the internal inode flags. The remaining items of
  * fsxattr are zeroed.
@@ -238,7 +230,7 @@ int btrfs_fileattr_set(struct user_namespace *mnt_userns,
 	if (ret)
 		return ret;
 
-	ret = check_fsflags_compatible(fs_info, fsflags);
+	ret = btrfs_zoned_check_fsflags_compatible(fs_info, fsflags);
 	if (ret)
 		return ret;
 
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index e3eaf03a34222..8e8f36c1d28a4 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -371,4 +371,13 @@ static inline void btrfs_zoned_data_reloc_unlock(struct inode *inode)
 		btrfs_inode_unlock(inode, 0);
 }
 
+static inline int btrfs_zoned_check_fsflags_compatible(
+					       struct btrfs_fs_info *fs_info,
+					       unsigned int flags)
+{
+	if (btrfs_is_zoned(fs_info) && (flags & FS_NOCOW_FL))
+		return -EPERM;
+
+	return 0;
+}
 #endif
-- 
2.31.1

