Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81534115D47
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Dec 2019 16:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfLGPCo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Dec 2019 10:02:44 -0500
Received: from aliyun-cloud.icoremail.net ([47.90.104.110]:32738 "HELO
        aliyun-sdnproxy-3.icoremail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S1726400AbfLGPCo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 7 Dec 2019 10:02:44 -0500
X-Greylist: delayed 709 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Dec 2019 10:02:42 EST
Received: from localhost.localdomain (unknown [222.205.62.5])
        by mail-app2 (Coremail) with SMTP id by_KCgC3vlJPuutdctLMBQ--.24137S3;
        Sat, 07 Dec 2019 22:42:24 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     pakki001@umn.edu, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs: Fix a missing check bug
Date:   Sat,  7 Dec 2019 22:41:25 +0800
Message-Id: <20191207144126.14320-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: by_KCgC3vlJPuutdctLMBQ--.24137S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtF47GF1kZr47Ww18Xw1rtFb_yoWfWwc_AF
        ZxAw1jqr4fKr4xuwn8GwnYqrZY9wsYkryFq3WjkFsrGayYvws8XrnrAryfuF9Iga1UGFsF
        k34kZry7Ga47ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbIxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6ry5MxAIw28IcxkI7VAKI48J
        MxAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7VUbkR65UUUUU==
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The return value of link_free_space(ctl, info) is checked out-sync. Only one branch of an if statement checks this return value after WARN_ON(ret).

Since this path pair is similar in semantic, there might be a missing check bug.

Fix this by simply adding a check on ret.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 fs/btrfs/free-space-cache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 3283da419200..acbb3a59d344 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2437,6 +2437,8 @@ int btrfs_remove_free_space(struct btrfs_block_group *block_group,
 			if (info->bytes) {
 				ret = link_free_space(ctl, info);
 				WARN_ON(ret);
+				if (ret)
+					goto out_lock;
 			} else {
 				kmem_cache_free(btrfs_free_space_cachep, info);
 			}
-- 
2.21.0 (Apple Git-122)

