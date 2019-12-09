Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF06E116586
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 04:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfLIDmE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Dec 2019 22:42:04 -0500
Received: from mail.zju.edu.cn ([61.164.42.155]:10754 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726748AbfLIDmE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 8 Dec 2019 22:42:04 -0500
X-Greylist: delayed 133167 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Dec 2019 22:42:03 EST
Received: from localhost.localdomain (unknown [10.181.191.229])
        by mail-app4 (Coremail) with SMTP id cS_KCgAn74iCwu1d6bMGAw--.10849S3;
        Mon, 09 Dec 2019 11:41:54 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] btrfs: add missing check after link_free_space
Date:   Mon,  9 Dec 2019 11:41:14 +0800
Message-Id: <20191209034114.16212-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cS_KCgAn74iCwu1d6bMGAw--.10849S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZrWkJw1DWF45AF4kAw17GFg_yoWDCrg_ZF
        97A3W8tr43Kryxuwn5Kw1rXrZY9wsYkFyFq3WIkF17GayfZwn8XrsFyryxCFnIga18JFsF
        y34kZr17Ga47ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2AFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2
        jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
        x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
        GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
        8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv
        6cx26r4fKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
        C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48J
        MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
        IF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
        6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
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

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
--
Changes in v2:
  - Add memory free for free space entry.
---
 fs/btrfs/free-space-cache.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 3283da419200..ba2e6cea5233 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2437,6 +2437,10 @@ int btrfs_remove_free_space(struct btrfs_block_group *block_group,
 			if (info->bytes) {
 				ret = link_free_space(ctl, info);
 				WARN_ON(ret);
+				if (ret) {
+					kmem_cache_free(btrfs_free_space_cachep, info);
+					goto out_lock;
+				}
 			} else {
 				kmem_cache_free(btrfs_free_space_cachep, info);
 			}
-- 
2.21.0 (Apple Git-122)

