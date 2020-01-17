Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 377B41403A0
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 06:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgAQFes (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 00:34:48 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:47158 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgAQFes (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 00:34:48 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00H5YeL0161775;
        Fri, 17 Jan 2020 05:34:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=inIRk5XUY06eqAh9VbxMgcZkldFBCm9mzf3e+846xsw=;
 b=oiIx7FQwtOF4UF5KteKXA1i8ySJO/HglS584eZW0mF5c8WxPUr4yULsj7/nKZMHwYr/5
 PDxVF34nigtWp62r/A8uslcMFQA05loyw/kpa4nCHSXIfy5OzpTO8ECppuDoZCzTWxj9
 EOx0cqQsfS5Itr2HQBgS9++YhpZQRMYVp2FQN+gp7rbckiG9fbdWFUGWfSUT+T2Q6ojz
 bS74HKJG+Mdj4QCnqUkEoD/wO17OAB7Ruo1IzEfEXBBKmM6l0dGFcsMh+JJhIjr3391g
 PCUYCNy6sPKMm1PZNRwsWAKP7Fyq6vn9b0kwGYTj9v5ej/dWPlTcnRkad65wB9z8v3KS 6g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2xf74spks1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 05:34:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00H5Ya5X049927;
        Fri, 17 Jan 2020 05:34:43 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2xjxp4f21x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 05:34:43 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00H5Yg8l008111;
        Fri, 17 Jan 2020 05:34:42 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Jan 2020 21:34:41 -0800
Date:   Fri, 17 Jan 2020 08:34:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] btrfs: tests: Fix an NULL vs IS_ERR() test
Message-ID: <20200117053432.k46ftoqf67dezauh@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=932
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001170043
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=984 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001170043
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The btrfs_alloc_dummy_device() function never returns NULL, it returns
error pointers.

Fixes: 5d9a4f871168 ("btrfs: Add self-tests for btrfs_rmap_block")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/btrfs/tests/extent-map-tests.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index b7f2c4398e92..70a2f0dc9a78 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -490,9 +490,9 @@ static int test_rmap_block(struct btrfs_fs_info *fs_info,
 	for (i = 0; i < map->num_stripes; i++) {
 		struct btrfs_device *dev = btrfs_alloc_dummy_device(fs_info);
 
-		if (!dev) {
+		if (IS_ERR(dev)) {
 			test_err("cannot allocate device");
-			ret = -ENOMEM;
+			ret = PTR_ERR(dev);
 			goto out;
 		}
 		map->stripes[i].dev = dev;
-- 
2.11.0

