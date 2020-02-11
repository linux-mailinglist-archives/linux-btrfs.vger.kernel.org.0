Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 318DC159291
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 16:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgBKPKb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 10:10:31 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:35875 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbgBKPKb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 10:10:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581433831; x=1612969831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oI3lM21taxH8n1gKhqZom7DbyYjWr+yCj5ESoL5FNrg=;
  b=SpPcyVhYkS6qEuS8+q5g/y83KmtkY3FFZWi51c1LlyDWConCBapIiSqX
   Xl+U0gdRphOs9ClLm74Kai006LJpUcrTY+bC6iqhcEU6TDTuKowMqpPBK
   EXi7q4of9SLHrVm+1uejGfxLKyb5XI7Orw1lGlkrH4Ee0911EMsIKzKdO
   lTjSBLI/wkkRkItHKKi1/j8sbUDf9Q0XXFQqEMd+ffVZUCC7bQ5EaKa/g
   P1/Kgg7rCgxnvG6jZeFV3o/c5l2LwxJZE9zKBdXIZy55lWGUv4VIxMOKg
   RHmcJXAxKnAAMb6hkLMfQZWA4ykEYNbaJVWweUaRvp/7psXhfCDY3fVrJ
   Q==;
IronPort-SDR: +K6KX1gj87QhfiH4JOhFlJFN9Y+5/enHVSGxe/V4UUEEuUOcu9e7Vd8czRkACgwTYSra8sVST7
 ocWke9aedBzGRVG7wSmrmsIpWrisjEC1EG7eIv8uAVQFw9WdmEPvxGqZIzpt3p2/EOjr88MRDE
 Xa41IptA8YpUJA411YxUdXSwLULBOX00RWON9wz7be3G2CLXWfBRUyLVCHf+Hz9NR2yQo3/y3Y
 fxXT4at0pcpPH8SHMs3rhrYAZGmhzOHGEL7ykPYOrMR4X6a2LTT4cHAOFSVw6SpAHuurw27DkK
 UxI=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="130128673"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Feb 2020 23:10:31 +0800
IronPort-SDR: 0acQMuv95zmXE1KaQBtZ4Gzy+taetUh5hHKDU16IS1KMyAYC39l3xZxQHMQ3wAb3tF0TRc52MJ
 tLcUCOYcyN8p8/KWF9FXhlAJhK3GZRBcWH1ROFQ12eeAQYMbYM7fAkIJUQpmsU81q7lOiOgPok
 4fM+3RHlX7G9uFUBUB1zycql1A17cKdoPw4mmfGNDxiDhvwsD0nWmHFPNthCaFeVWK2fPE/L1F
 oZxzMYRYV+yfrBd4K/UOy/wH7qMpvSm7GNyPX+PlLAdv6ccy1eh0fnmhGfZN3xapIAII5DquOP
 xZodnIWgVsiaJNCpvPt/VzCp
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 07:03:21 -0800
IronPort-SDR: Z8JKCXnKQEu3Oeat+MX2m3Ayu0dxeu37rphcZqIyEM14k5QhR64NOoVOp+tzcxZkmHzSIdi9Rj
 kisXxWuKYuhtvw5QQitT7Vw4if3FmFpGD6pdOuM7xbyQvPgj/s4EuzksWwb+ayFWCAjfE11hRB
 I5L7uNueq3XD9CtaBc0SaqXROeopUbvw/JRtb0VRXrG6Cxt6FVO3YlzAq2+i+ioxzkcMEeulSD
 wjtsTJIBZxQNIUx1RUGGimHqTCyO4JVPCM+nr5NN2QLOdJ6jsCZ9KLbWBHX82JiKLL1zx+gZvC
 w04=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Feb 2020 07:10:30 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 2/5] btrfs: make the uptodate argument of io_ctl_add_pages() boolean.
Date:   Wed, 12 Feb 2020 00:10:20 +0900
Message-Id: <20200211151023.16060-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200211151023.16060-1-johannes.thumshirn@wdc.com>
References: <20200211151023.16060-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Make the uptodate argument of io_ctl_add_pages() boolean.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/free-space-cache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index f4ae7629a0e7..98f547e87bb4 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -371,7 +371,7 @@ static void io_ctl_drop_pages(struct btrfs_io_ctl *io_ctl)
 	}
 }
 
-static int io_ctl_prepare_pages(struct btrfs_io_ctl *io_ctl, int uptodate)
+static int io_ctl_prepare_pages(struct btrfs_io_ctl *io_ctl, bool uptodate)
 {
 	struct page *page;
 	struct inode *inode = io_ctl->inode;
@@ -732,7 +732,7 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 
 	readahead_cache(inode);
 
-	ret = io_ctl_prepare_pages(&io_ctl, 1);
+	ret = io_ctl_prepare_pages(&io_ctl, true);
 	if (ret)
 		goto out;
 
@@ -1291,7 +1291,7 @@ static int __btrfs_write_out_cache(struct btrfs_root *root, struct inode *inode,
 	}
 
 	/* Lock all pages first so we can lock the extent safely. */
-	ret = io_ctl_prepare_pages(io_ctl, 0);
+	ret = io_ctl_prepare_pages(io_ctl, false);
 	if (ret)
 		goto out_unlock;
 
-- 
2.16.4

