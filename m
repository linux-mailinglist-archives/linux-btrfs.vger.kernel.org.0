Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E20E516B0E5
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 21:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgBXUW6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 15:22:58 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:60610 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgBXUW6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 15:22:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582575777; x=1614111777;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PaAifg0FausWbfa43zWAUrDcYaGJAHSfOGrtD0Cw8pQ=;
  b=YTZ46DfUJpxA6vxcCb/D8XOj7mFXFJYyoeoyNlkikaOREMZFBBigGVa2
   RleWPvKmvDKjUa3qTDWgbL5NyWEUJ6tlmJlar1YE5cg72/VpP4tC6s110
   yAXTE1gbtSlYdjVkDV32vgh/kcH987o96q9rF78BdfQ9qnkUL0wzYdznC
   IF+/morSigabQNnN9k3cEBzA2CLBaQB7pO7eqF9YglSoxUwU0nMCAunUh
   o9skuoHwRN755odzORwxW9YXqN6bLSSwvb9LGkQwGkjc0LssK7TWt2d0O
   Ks1M7vURXOxT+efkvtjKhBsUGcMs8HENFvl5BPDJAR54KUUrWmYZyqS49
   A==;
IronPort-SDR: SiseZwjaGP4hJNZfjCYh8QymBV9wGVjPlGMJvcfDKAqx0pcGG8hhPhm1SwDzdzerz8ihfGS+Qe
 83Cf0b3+3Mx4I19OWQMRuCOlRIk5wi8zIQF1VUDzhRxN7fltbobMsElEaeUk4dsqN3uDD9vAEg
 /H5nEmrLFru5MkYTr3R7ABknuqo+DkXqlel48/AeuV2UP5tGsi1RTPd7zOMlivGYROf99V30lA
 6pKiINSL6wClJCZ1/e4HtPzQgnCo5FF6gdoZbGGhG20KnAbzVZDcaTMQPYFJ25BcCFVOXH9ntM
 zzc=
X-IronPort-AV: E=Sophos;i="5.70,481,1574092800"; 
   d="scan'208";a="238749937"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2020 04:22:57 +0800
IronPort-SDR: q76JIw7P7uReBiRAWS3BWvrVj18VZyFBv5mXZXKY4r5vwYdFSmAO6Av+8AmFe7Arrc/gc1Lqkb
 Xn37BHDIFot1UKOXbjJLOeB5tB0MraF/fTRwfmIc4HXKYPeokvnbH1Sk4Et/CR33XcQQeLXXLS
 f6x4of9j7LgQnjppXQwcGROASl1LuycKGLAO3mpGwgkgKih2BcEIBPB7/ANU18h/dEFNYVUQhF
 XM4L9Bs3C/MXFmmyRnX2nwMcVS17Fk6u9zBytr+P1AFbUHwbTwROMdfZi2sKUGjH0o54qBduZi
 x2RARcwQ/4A/N0sMNleWXQuc
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 12:15:25 -0800
IronPort-SDR: FECBVGZLWYyAxgTB98WlCNgdGy05QIsFIH1tfiz8GrkOsKNIKQt/jnHLnKzpmERV6CVF+9drxd
 8dpzDNo5CKBTmfMkOvLZJaTKUp9XkNDb3dBimy++rvhDxANkPPGMPGfHhfFLHLv7Sjwpo0lypL
 UyxPE3YghiDWMfLmIpojBMFB9TwVLr2co1Y0WvP2wOAbMu0pMBWfj66bhrOua6hRfrri/XzuAA
 F1IC5gT2mRK5GPW5BjnYHmpTwvpJeQpExAcXFcKVrRz8+Wy+qkAV+flU3FMtRMnCc0rmoo3E+Q
 HQc=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2020 12:22:57 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH misc-next] btrfs: fix compilation error in btree_write_cache_pages()
Date:   Tue, 25 Feb 2020 05:22:51 +0900
Message-Id: <20200224202251.37787-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

CC [M]  fs/btrfs/extent_io.o
fs/btrfs/extent_io.c: In function ‘btree_write_cache_pages’:
fs/btrfs/extent_io.c:3959:34: error: ‘tree’ undeclared (first use in this function); did you mean ‘true’?
 3959 |  struct btrfs_fs_info *fs_info = tree->fs_info;
      |                                  ^~~~
      |                                  true
fs/btrfs/extent_io.c:3959:34: note: each undeclared identifier is reported only once for each function it appears in
make[2]: *** [scripts/Makefile.build:268: fs/btrfs/extent_io.o] Error 1
make[1]: *** [scripts/Makefile.build:505: fs/btrfs] Error 2
make: *** [Makefile:1681: fs] Error 2

Fixes: 75c39607eb0a ("btrfs: Don't submit any btree write bio if the fs has errors")
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 903a85d8fbe3..837262d54e28 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3956,7 +3956,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 		.extent_locked = 0,
 		.sync_io = wbc->sync_mode == WB_SYNC_ALL,
 	};
-	struct btrfs_fs_info *fs_info = tree->fs_info;
+	struct btrfs_fs_info *fs_info = BTRFS_I(mapping->host)->root->fs_info;
 	int ret = 0;
 	int done = 0;
 	int nr_to_write_done = 0;
-- 
2.24.1

