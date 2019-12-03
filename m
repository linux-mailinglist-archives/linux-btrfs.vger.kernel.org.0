Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D58C810FC75
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 12:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfLCLZZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Dec 2019 06:25:25 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35958 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfLCLZZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Dec 2019 06:25:25 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB3BO0BV111171;
        Tue, 3 Dec 2019 11:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2019-08-05; bh=N0kbbeTYMJ44dw9vyBfhOmrv/doA7q8QC99/099cT9Q=;
 b=WzGrn48aQ1uDColiOtF9fkFvyNx5FeSbQXSVbVDx/2htzVTsUR63z0DFIDKWfeiSR1IX
 VLLOl/YvcRDMmbYoF0ZR+gwCAbbirjRvsyy93TbykSNYyH+dKBfXmzGOPEd77eifA4vT
 JN6ZgQXFumSNJkbOhzzZQ/Q3lj6zZLOwoJnyDLZlGUwud5NGnRhHDdG7xZSg3IfzWj8P
 De98QlBP/vkFtI4hw83YqmmJTx6aD+hOIAsqHJxTZGeMbQw73eVDoW7tBQ+f/61uO1dT
 SvacCx4QNhZPV4jKUGo4EE2bGnCOT+FSZV+drWO4uQTu8Ze15+5DLz7RCzFPdajzHBjk NQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2wkh2r6sym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Dec 2019 11:25:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB3BN57A042774;
        Tue, 3 Dec 2019 11:25:08 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2wnb7xsnbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Dec 2019 11:25:08 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB3BP6E5001914;
        Tue, 3 Dec 2019 11:25:06 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Dec 2019 03:25:05 -0800
Date:   Tue, 3 Dec 2019 14:24:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>
Cc:     David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-btrfs@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2] btrfs: Fix btrfs_find_create_tree_block() testing
Message-ID: <20191203112457.GF1787@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203110408.GA30629@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9459 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912030093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9459 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912030093
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The btrfs_find_create_tree_block() uses alloc_test_extent_buffer() for
testing and alloc_extent_buffer() for production.  The problem is that
the test code returns NULL and the production code returns error
pointers.  The callers only check for error pointers.

I have changed alloc_test_extent_buffer() to return error pointers and
updated the two callers which use it directly.

Fixes: faa2dbf004e8 ("Btrfs: add sanity tests for new qgroup accounting code")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: Correct the commit message.  alloc_test_extent_buffer() instead of
alloc_dummy_extent_buffer().

 fs/btrfs/extent_io.c                   | 6 ++++--
 fs/btrfs/tests/free-space-tree-tests.c | 4 ++--
 fs/btrfs/tests/qgroup-tests.c          | 4 ++--
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index eb8bd0258360..2f4802f405a2 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5074,12 +5074,14 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 		return eb;
 	eb = alloc_dummy_extent_buffer(fs_info, start);
 	if (!eb)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	eb->fs_info = fs_info;
 again:
 	ret = radix_tree_preload(GFP_NOFS);
-	if (ret)
+	if (ret) {
+		exists = ERR_PTR(ret);
 		goto free_eb;
+	}
 	spin_lock(&fs_info->buffer_lock);
 	ret = radix_tree_insert(&fs_info->buffer_radix,
 				start >> PAGE_SHIFT, eb);
diff --git a/fs/btrfs/tests/free-space-tree-tests.c b/fs/btrfs/tests/free-space-tree-tests.c
index 1a846bf6e197..914eea5ba6a7 100644
--- a/fs/btrfs/tests/free-space-tree-tests.c
+++ b/fs/btrfs/tests/free-space-tree-tests.c
@@ -452,9 +452,9 @@ static int run_test(test_func_t test_func, int bitmaps, u32 sectorsize,
 	root->fs_info->tree_root = root;
 
 	root->node = alloc_test_extent_buffer(root->fs_info, nodesize);
-	if (!root->node) {
+	if (IS_ERR(root->node)) {
 		test_std_err(TEST_ALLOC_EXTENT_BUFFER);
-		ret = -ENOMEM;
+		ret = PTR_ERR(root->node);
 		goto out;
 	}
 	btrfs_set_header_level(root->node, 0);
diff --git a/fs/btrfs/tests/qgroup-tests.c b/fs/btrfs/tests/qgroup-tests.c
index 09aaca1efd62..ac035a6fa003 100644
--- a/fs/btrfs/tests/qgroup-tests.c
+++ b/fs/btrfs/tests/qgroup-tests.c
@@ -484,9 +484,9 @@ int btrfs_test_qgroups(u32 sectorsize, u32 nodesize)
 	 * *cough*backref walking code*cough*
 	 */
 	root->node = alloc_test_extent_buffer(root->fs_info, nodesize);
-	if (!root->node) {
+	if (IS_ERR(root->node)) {
 		test_err("couldn't allocate dummy buffer");
-		ret = -ENOMEM;
+		ret = PTR_ERR(root->node);
 		goto out;
 	}
 	btrfs_set_header_level(root->node, 0);
-- 
2.11.0
