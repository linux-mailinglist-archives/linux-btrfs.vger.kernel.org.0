Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6173F008C
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 11:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbhHRJc7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 05:32:59 -0400
Received: from mail-m972.mail.163.com ([123.126.97.2]:49314 "EHLO
        mail-m972.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbhHRJcU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 05:32:20 -0400
X-Greylist: delayed 930 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Aug 2021 05:32:16 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=qijfI
        FoL/35EH+Z6y3n8GDDoiZ8v1xXSaNfWOq3SWIY=; b=Y49H+YW2dMTSqyE2c2cJQ
        sFpeiHlIgnW5yCf0JMlyqYiajub+Wkou7shBGsLgvg51vvQTOPllurXkXFxGvCNU
        WvUIKkQz9+OEU3lW2/6Elm9SFA+fSv1iKIhuH6eoKxvQMq6jBYdcZIrRcN0GnhlR
        ++I8Isee7ruHWlv7VUTjL8=
Received: from localhost.localdomain (unknown [218.106.182.47])
        by smtp2 (Coremail) with SMTP id GtxpCgDHxvWozxxhjERKOw--.2267S4;
        Wed, 18 Aug 2021 17:15:32 +0800 (CST)
From:   Wentao_Liang <Wentao_Liang_g@163.com>
To:     clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wentao_Liang <Wentao_Liang_g@163.com>
Subject: [PATCH] btrfs: fix a potential double put bug and some related use-after-free bugs
Date:   Wed, 18 Aug 2021 17:15:18 +0800
Message-Id: <20210818091518.4825-1-Wentao_Liang_g@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgDHxvWozxxhjERKOw--.2267S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw15ZFy3Ww4fJry7GryxAFb_yoW8Kr13p3
        y3uF4DKa4kZFnrZw4xGrWUW34fKa4kCa4j9rn8Crsru3W3X34Iya4kKw1qvF1qqF95JFZr
        ZryYvry5Crs8A3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j6dgXUUUUU=
X-Originating-IP: [218.106.182.47]
X-CM-SenderInfo: xzhq3t5rboxtpqjbwqqrwthudrp/1tbiWxTyL1SIrOr8DQAAs5
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In line 2955 (#1), "btrfs_put_block_group(cache);" drops the reference to
cache and may cause the cache to be released. However, in line 3014, the
cache is dropped again by the same put function (#4). Double putting the
cache can lead to an incorrect reference count.

Furthermore, according to the definition of btrfs_put_block_group() in fs/
btrfs/block-group.c, if the reference count of the cache is one at the
first put, it will be freed by kfree(). Using it again may result in the
use-after-free flaw. In fact, after the first put (line 2955), the cache
is also accessed in a few places (#2, #3), e.g., lines 2967, 2973, 2974,
….

We believe that the first put of the cache is unnecessary (#1).
We can fix the above bugs by removing the redundant
"btrfs_put_block_group(cache);" in line 2955 (#1).

2951         if (!list_empty(&cache->io_list)) {
...
2955             btrfs_put_block_group(cache);
				 //#1 the first drop to cache (unnecessary)
...
2957         }
...
2967         cache_save_setup(cache, trans, path); //#2 use the cache
...
2972          //#3 use the cache several times

2973         if (!ret && cache->disk_cache_state == BTRFS_DC_SETUP) {
2974             cache->io_ctl.inode = NULL;
2975             ret = btrfs_write_out_cache(trans, cache, path);
2976             if (ret == 0 && cache->io_ctl.inode) {
2977                 num_started++;
2978                 should_put = 0;
2979                 list_add_tail(&cache->io_list, io);
2980             } else {
...
2985                 ret = 0;
2986             }
2987         }
2988         if (!ret) {
2989             ret = update_block_group_item(trans, path, cache);
...
3003             if (ret == -ENOENT) {
...
3006                 ret = update_block_group_item(trans, path, cache);
3007             }
...
3010         }
3011
...
3013         if (should_put)
3014             btrfs_put_block_group(cache);
				//#4 the second drop to cache

Signed-off-by: Wentao_Liang <Wentao_Liang_g@163.com>
---
 fs/btrfs/block-group.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 9e7d9d0c763d..c510c821b1be 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2953,7 +2953,6 @@ int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans)
 			spin_unlock(&cur_trans->dirty_bgs_lock);
 			list_del_init(&cache->io_list);
 			btrfs_wait_cache_io(trans, cache, path);
-			btrfs_put_block_group(cache);
 			spin_lock(&cur_trans->dirty_bgs_lock);
 		}
 
-- 
2.25.1

