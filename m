Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDDA93A3C22
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 08:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhFKGoK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Jun 2021 02:44:10 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:5382 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhFKGoJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Jun 2021 02:44:09 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G1WPh38Rvz6wbg;
        Fri, 11 Jun 2021 14:38:16 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 14:42:09 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 11 Jun
 2021 14:42:09 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
        <anand.jain@oracle.com>, <linux-btrfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>, "Hulk Robot" <hulkci@huawei.com>
Subject: [PATCH -next v2] btrfs: send: use list_move_tail instead of list_del/list_add_tail in send.c
Date:   Fri, 11 Jun 2021 14:51:15 +0800
Message-ID: <20210611065115.1165906-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Using list_move_tail() instead of list_del() + list_add_tail() in send.c.
And open-code name_cache_used() as there is only one user.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
V1->V2:
        open-code name_cache_used()

 fs/btrfs/send.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index bd69db72acc5..418ada6139fd 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -2077,16 +2077,6 @@ static struct name_cache_entry *name_cache_search(struct send_ctx *sctx,
 	return NULL;
 }
 
-/*
- * Removes the entry from the list and adds it back to the end. This marks the
- * entry as recently used so that name_cache_clean_unused does not remove it.
- */
-static void name_cache_used(struct send_ctx *sctx, struct name_cache_entry *nce)
-{
-	list_del(&nce->list);
-	list_add_tail(&nce->list, &sctx->name_cache_list);
-}
-
 /*
  * Remove some entries from the beginning of name_cache_list.
  */
@@ -2147,7 +2137,14 @@ static int __get_cur_name_and_parent(struct send_ctx *sctx,
 			kfree(nce);
 			nce = NULL;
 		} else {
-			name_cache_used(sctx, nce);
+
+			/*
+			 * Removes the entry from the list and adds it back to the end.
+			 * This marks the entry as recently used so that
+			 * name_cache_clean_unused does not remove it.
+			 */
+			list_move_tail(&nce->list, &sctx->name_cache_list);
+
 			*parent_ino = nce->parent_ino;
 			*parent_gen = nce->parent_gen;
 			ret = fs_path_add(dest, nce->name, nce->name_len);
-- 
2.31.1

