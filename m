Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 543F317994C
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 20:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgCDTuM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 14:50:12 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:19666 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728614AbgCDTuL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Mar 2020 14:50:11 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 024Jk8K7024747
        for <linux-btrfs@vger.kernel.org>; Wed, 4 Mar 2020 11:50:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=zBd+5qaL3qCpMGDjmFLdwfve7IIb8GrWrTDOOZQAm1o=;
 b=OD+9dxjAszOVJAKEAHqFl5ws+jBOYe2g195UCbw2bPSpTkzs6EmmQISeR1R92rT5YRyl
 LRU03bd53091itcJ1s3NTjuQSG/NaPN4CTZw4jlxmzmE5U3id0y5CDdLuBo+KCCpYWvM
 IfvBE0k8ksQXOUa4dQibIPrH1PuDyABTm/o= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2yjggj0u82-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Mar 2020 11:50:10 -0800
Received: from intmgw001.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 4 Mar 2020 11:50:06 -0800
Received: by devvm4439.prn2.facebook.com (Postfix, from userid 111017)
        id 1C713FEBAC0A; Wed,  4 Mar 2020 11:50:03 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm4439.prn2.facebook.com
To:     Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>
CC:     <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH] btrfs: implement migratepage callback
Date:   Wed, 4 Mar 2020 11:50:02 -0800
Message-ID: <20200304195002.3854765-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_08:2020-03-04,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1011
 bulkscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=756
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040129
X-FB-Internal: deliver
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently btrfs doesn't provide a migratepage callback. It means that
fallback_migrate_page()	is used to migrate btrfs pages.

fallback_migrate_page() cannot move dirty pages, instead it tries to
flush them (in sync mode) or just fails (in async mode).

In the sync mode pages which are scheduled to be processed by
btrfs_writepage_fixup_worker() can't be effectively flushed by the
migration code, because there is no established way to wait for the
completion of the delayed work.

It all leads to page migration failures.

To fix it the patch implements a btrs-specific migratepage callback,
which is similar to iomap_migrate_page() used by some other fs, except
it does take care of the PagePrivate2 flag which is used for data
ordering purposes.

Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Chris Mason <clm@fb.com>
---
 fs/btrfs/inode.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7735ce6127c3..f23230b3cbda 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -28,6 +28,7 @@
 #include <linux/magic.h>
 #include <linux/iversion.h>
 #include <linux/swap.h>
+#include <linux/migrate.h>
 #include <linux/sched/mm.h>
 #include <asm/unaligned.h>
 #include "misc.h"
@@ -8323,6 +8324,37 @@ static int btrfs_releasepage(struct page *page, gfp_t gfp_flags)
 	return __btrfs_releasepage(page, gfp_flags);
 }
 
+static int btrfs_migratepage(struct address_space *mapping,
+			     struct page *newpage, struct page *page,
+			     enum migrate_mode mode)
+{
+	int ret;
+
+	ret = migrate_page_move_mapping(mapping, newpage, page, 0);
+	if (ret != MIGRATEPAGE_SUCCESS)
+		return ret;
+
+	if (page_has_private(page)) {
+		ClearPagePrivate(page);
+		get_page(newpage);
+		set_page_private(newpage, page_private(page));
+		set_page_private(page, 0);
+		put_page(page);
+		SetPagePrivate(newpage);
+	}
+
+	if (PagePrivate2(page)) {
+		ClearPagePrivate2(page);
+		SetPagePrivate2(newpage);
+	}
+
+	if (mode != MIGRATE_SYNC_NO_COPY)
+		migrate_page_copy(newpage, page);
+	else
+		migrate_page_states(newpage, page);
+	return MIGRATEPAGE_SUCCESS;
+}
+
 static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 				 unsigned int length)
 {
@@ -10525,6 +10557,7 @@ static const struct address_space_operations btrfs_aops = {
 	.direct_IO	= btrfs_direct_IO,
 	.invalidatepage = btrfs_invalidatepage,
 	.releasepage	= btrfs_releasepage,
+	.migratepage	= btrfs_migratepage,
 	.set_page_dirty	= btrfs_set_page_dirty,
 	.error_remove_page = generic_error_remove_page,
 	.swap_activate	= btrfs_swap_activate,
-- 
2.24.1

