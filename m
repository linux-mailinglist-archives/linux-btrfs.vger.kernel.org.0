Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9F51182EA
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2019 09:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfLJI7V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Dec 2019 03:59:21 -0500
Received: from spam.zju.edu.cn ([61.164.42.155]:7180 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726574AbfLJI7V (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Dec 2019 03:59:21 -0500
Received: from localhost.localdomain (unknown [222.205.61.84])
        by mail-app3 (Coremail) with SMTP id cC_KCgB3GbxbXu9dno13Aw--.7592S3;
        Tue, 10 Dec 2019 16:59:07 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] btrfs: add missing check after link_free_space
Date:   Tue, 10 Dec 2019 16:56:22 +0800
Message-Id: <20191210085623.17737-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cC_KCgB3GbxbXu9dno13Aw--.7592S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ur15XFWUWF43Kr4xJF43ZFb_yoW8XF4xpF
        9akF1DJw1kZw4rCFWDKw4DWFyFgayvga15uasrAa17Ar43uryqqry0yF15C3W2yr97Jr4I
        yan8KFyUAr43AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW0oVCq3wA2z4x0Y4vEx4A2
        jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
        x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
        GwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
        8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr41l
        42xK82IY6x8ErcxFaVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
        8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWU
        twCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
        0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0J
        U4a0PUUUUU=
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The return value of link_free_space is checked out-sync.
One branch of an if statement uses an extra check after
WARN_ON() but its peer branch does not. WARN_ON() does
not change the control flow, thus only using this check
might be insufficient.

Fix this by simply adding a check on ret.

The repeated kmem_cache_free branches have not been merged 
because this will influence the original control flow. If 
the control flow does not step into the if (ret) branch, 
then we actually need not to free memory again.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
--
Changes in v3:
  - Remove WARN_ON after link_free_space
---
 fs/btrfs/free-space-cache.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 3283da419200..ae4eea12fc9a 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2436,7 +2436,10 @@ int btrfs_remove_free_space(struct btrfs_block_group *block_group,
 			info->offset += to_free;
 			if (info->bytes) {
 				ret = link_free_space(ctl, info);
-				WARN_ON(ret);
+				if (ret) {
+					kmem_cache_free(btrfs_free_space_cachep, info);
+					goto out_lock;
+				}
 			} else {
 				kmem_cache_free(btrfs_free_space_cachep, info);
 			}
@@ -2449,7 +2452,6 @@ int btrfs_remove_free_space(struct btrfs_block_group *block_group,
 
 			info->bytes = offset - info->offset;
 			ret = link_free_space(ctl, info);
-			WARN_ON(ret);
 			if (ret)
 				goto out_lock;
 
-- 
2.21.0 (Apple Git-122)

