Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612FD296DA5
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Oct 2020 13:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462974AbgJWL0u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Oct 2020 07:26:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37194 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462886AbgJWL0u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Oct 2020 07:26:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09NBOx22022603;
        Fri, 23 Oct 2020 11:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=J+fY7K/PMwP5qX5S8TQUDWhdvCCBHhdIEr5a9q7bD8c=;
 b=o2hNJlXQaZGph993OO71RyzLaJm9gGOnGhpQncigxhdchdle1C0gQrJrqip/6ccScVsl
 s+CJXUvcnXXEzmiXELUlhut3I2ylUKqWYU0rIoXQJ3349JYOENJoscm4S5nPtLrDylM4
 P2Ajdt5OeRzegusUn8YrVzumhrrA+6R0TXBERxgg7eSIit89TKoqAIxk8oYTq60OZyg9
 CFX2ABPzEzH5qP9i+YYg9SZ2NnvBQP3Ia0+QcasmlQFZ9X8ikPS20rAKYXkEnOSXGYYx
 jujtjqluNFfE5BC6cn62CyGe6dEEjMK3/UmhQNoRSZEuVD6JWW+8s+8tfBn3GBojq8st Hg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 34ak16tywn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 23 Oct 2020 11:26:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09NBPkjB123745;
        Fri, 23 Oct 2020 11:26:41 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 348ah1w7kb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Oct 2020 11:26:41 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09NBQer2009641;
        Fri, 23 Oct 2020 11:26:40 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 23 Oct 2020 04:26:39 -0700
Date:   Fri, 23 Oct 2020 14:26:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chris Mason <clm@fb.com>, Qu Wenruo <wqu@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] btrfs: clean up NULL checks in qgroup_unreserve_range()
Message-ID: <20201023112633.GE282278@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9782 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010230081
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9782 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1011 malwarescore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010230081
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Smatch complains that this code dereferences "entry" before checking
whether it's NULL on the next line.  Fortunately, rb_entry() will never
return NULL so it doesn't cause a problem.  We can clean up the NULL
checking a bit to silence the warning and make the code more clear.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
My patch does not change run-time, but it's possible that the original
code was buggy and I missed it.

 fs/btrfs/qgroup.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 580899bdb991..a7ae2f18f486 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3417,24 +3417,20 @@ static int qgroup_unreserve_range(struct btrfs_inode *inode,
 {
 	struct rb_node *node;
 	struct rb_node *next;
-	struct ulist_node *entry = NULL;
+	struct ulist_node *entry;
 	int ret = 0;
 
 	node = reserved->range_changed.root.rb_node;
+	if (!node)
+		return 0;
 	while (node) {
 		entry = rb_entry(node, struct ulist_node, rb_node);
 		if (entry->val < start)
 			node = node->rb_right;
-		else if (entry)
-			node = node->rb_left;
 		else
-			break;
+			node = node->rb_left;
 	}
 
-	/* Empty changeset */
-	if (!entry)
-		return 0;
-
 	if (entry->val > start && rb_prev(&entry->rb_node))
 		entry = rb_entry(rb_prev(&entry->rb_node), struct ulist_node,
 				 rb_node);
-- 
2.28.0

