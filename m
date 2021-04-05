Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E52354104
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Apr 2021 12:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240524AbhDEKAz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Apr 2021 06:00:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15598 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbhDEKAy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Apr 2021 06:00:54 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FDR1m58sjz18HLL;
        Mon,  5 Apr 2021 17:58:36 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Mon, 5 Apr 2021 18:00:36 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <zhengyongjun3@huawei.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     <linux-btrfs@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Hulk Robot" <hulkci@huawei.com>
Subject: [PATCH -next] btrfs: integrity-checker: use DEFINE_MUTEX() for mutex lock
Date:   Mon, 5 Apr 2021 18:14:46 +0800
Message-ID: <20210405101446.14990-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.104.82]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

mutex lock can be initialized automatically with DEFINE_MUTEX()
rather than explicitly calling mutex_init().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 fs/btrfs/check-integrity.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 169508609324..7af9273ef1b6 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -370,7 +370,7 @@ static void btrfsic_cmp_log_and_dev_bytenr(struct btrfsic_state *state,
 					   struct btrfsic_dev_state *dev_state,
 					   u64 dev_bytenr);
 
-static struct mutex btrfsic_mutex;
+static DEFINE_MUTEX(btrfsic_mutex);
 static int btrfsic_is_initialized;
 static struct btrfsic_dev_state_hashtable btrfsic_dev_state_hashtable;
 
@@ -2787,7 +2787,6 @@ int btrfsic_mount(struct btrfs_fs_info *fs_info,
 		return -ENOMEM;
 
 	if (!btrfsic_is_initialized) {
-		mutex_init(&btrfsic_mutex);
 		btrfsic_dev_state_hashtable_init(&btrfsic_dev_state_hashtable);
 		btrfsic_is_initialized = 1;
 	}

