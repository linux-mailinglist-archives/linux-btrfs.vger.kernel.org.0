Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E4D45B785
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 10:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236510AbhKXJei (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 04:34:38 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32204 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236382AbhKXJeb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 04:34:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637746281; x=1669282281;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TSwy7QTI0fRTsdbXkhy9nV3Gi8Poo7wRKEZTydiY0aw=;
  b=I12yIKuYe9RBd6oXD2cRDvsAfsGnb5ygtAyiwUe1CjKf4UPh+ffyncjT
   MhVtuhGjY9PHEX+AzFfh8ROrPDvCKuDAlkXBRFIlj6vv+aZpMr5ZrrWha
   quaIsDzW7fOHz9L6E2fcZNv/IzJ5LXPZCAEJ+YHUs8z2zYRTsNMEn3WSk
   YAbLUsfkBbtNzCtG36nlMDoVJc8IGgZxrZlMIrnAKn4miDh6WOTTSn8QH
   6E5nM3gR80+yQEwKYKCve5EbvsJKXSU+ExZj+1rVf3aBx8+oxR1SiBd2C
   MXohhPRG44NhZZ8FLFbhJU7OFU3tGuRuv4DBF+8/eVCBd5ABO8ZMHpNKE
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,260,1631548800"; 
   d="scan'208";a="185499412"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2021 17:31:21 +0800
IronPort-SDR: Zg8Pt9IqVZRQUe7OQBgd7TvSfKdEQt8UmGW1ZUKbW44lBinMUcOqrHdufIdtcH5rxfgFqt7/IC
 KD+mWH7Va/l9sjp1Rrujg+R6L6BFX7IauQeOySy80UxZ72xAhCWvVpWFQbf8jFFhm78zV9e8+r
 PoTgEszDxyxZTOJ6mUAJOY2h2rkbg3ioOtY5SfXtbkYVlUIuPqNltApcUBNeFIXlOZrt/51D9Y
 ZZfPzqUtF+eiw9U+XsXG4us2o0tDS5BVBmgqfAtKmKjAUXSfQJajBrAmTX9VKVoRWliicQU9OB
 W0WdTsfDldX62psbO78lf66i
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 01:06:14 -0800
IronPort-SDR: BUFpWSD6VPG8FADESup6FdXy29nQ4Q5dZQ2T/M6cxG8c4wbBpB1/YYUsgEJoVfYXpQaf2zKQ7P
 9nZh03Ygs5v6Ne24ckG27GuJ5W82RrxvUr+jk42qt5MAVwe873K1Tojnwv1MJI7oyHNIyFB9MQ
 yY4c2nezMCWhfGrTY9I1R6C5aU7WsVDXSI9t20jPT3LM5VL3dDn/X1ZX8FRuifPaNINXd7jXSi
 qplfiphT/P/XjLp4DynbWJQQQ/wNmqk8prEQifOeHn8Mk7BhzyvcwNKCXN85QswqNrfkvZHp7K
 zZ4=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Nov 2021 01:31:21 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH 21/21] btrfs: move btrfs_scrub_progress() definition to scrub.h
Date:   Wed, 24 Nov 2021 01:30:47 -0800
Message-Id: <6cbadf7d286d9074dab45b4f4916e7b781b61d97.1637745470.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1637745470.git.johannes.thumshirn@wdc.com>
References: <cover.1637745470.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we have a scrub.h move btrfs_scrub_progress()'s definition there.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/ctree.h | 3 ---
 fs/btrfs/scrub.h | 2 ++
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index aef03199e367a..5cfb2ebf3a020 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3800,9 +3800,6 @@ struct btrfs_root *find_reloc_root(struct btrfs_fs_info *fs_info,
 				   u64 bytenr);
 int btrfs_should_ignore_reloc_root(struct btrfs_root *root);
 
-/* scrub.c */
-int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
-			 struct btrfs_scrub_progress *progress);
 static inline void btrfs_init_full_stripe_locks_tree(
 			struct btrfs_full_stripe_locks_tree *locks_root)
 {
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
index e6eaf22b04e14..9fe4b7dee61f5 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -57,4 +57,6 @@ void btrfs_scrub_pause(struct btrfs_fs_info *fs_info);
 void btrfs_scrub_continue(struct btrfs_fs_info *fs_info);
 int btrfs_scrub_cancel(struct btrfs_fs_info *info);
 int btrfs_scrub_cancel_dev(struct btrfs_device *dev);
+int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
+			 struct btrfs_scrub_progress *progress);
 #endif /* BTRFS_SCRUB_H */
-- 
2.31.1

