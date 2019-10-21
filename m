Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EECA8DE8E9
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 12:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbfJUKBu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 06:01:50 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42000 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbfJUKBt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 06:01:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9L9xGwI023764
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=05uIH3mtPdVhf3eXGKp6QQbrJLYkIR3tibB3+k9Uvcg=;
 b=I2JtxV2jhlmsHIsHeybpQKB270wEp/u5dfh8/RIEYncGeNRYjTs068Ft6vpVJXKXUquR
 pWvfMbA0P7+fyDXm3G3h5wVkgV1sjvMGX1n8cVSCRzl7L7YV9fGSDjN9gIrGS+t9y4cd
 rGS9ZQjBGjJGVNWPolONleDqmjHMGLPOAf0oEqjUrSMA69lToHIhYIn0Df9WCL+daEPx
 cJDE7glgyG29MQrPXRlce6RslsoYD5itMZXo9SyDXq4f0NUCW9sr3Hb4p2c/A2BPdYxB
 EGfnHUe8b5tNxKKAwPVHNh5pkpnnCesMFynVFyU0p7nj7M/gkZFwLxSYDh94zCtNg+Oz 3Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2vqswt6pm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9L9wLMl088734
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:47 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2vrbyycux4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:47 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9LA1kSS013522
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:46 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Oct 2019 03:01:46 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [RFC PATCH 09/14] btrfs-progs: restore: delete unreachable code
Date:   Mon, 21 Oct 2019 18:01:17 +0800
Message-Id: <1571652082-25982-10-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571652082-25982-1-git-send-email-anand.jain@oracle.com>
References: <1571652082-25982-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9416 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910210096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9416 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910210096
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Maximum value of %verbose is 1 when %verbose is enabled using
'btrfs restore -v <dev> <dir>', and the code under the condition
%verbose > 1 is never reached. So delete them.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/restore.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/cmds/restore.c b/cmds/restore.c
index c104b01aef69..79caf6734e76 100644
--- a/cmds/restore.c
+++ b/cmds/restore.c
@@ -987,9 +987,6 @@ static int search_dir(struct btrfs_root *root, struct btrfs_key *key,
 
 	leaf = path.nodes[0];
 	while (!leaf) {
-		if (verbose > 1)
-			printf("No leaf after search, looking for the next "
-			       "leaf\n");
 		ret = next_leaf(root, &path);
 		if (ret < 0) {
 			fprintf(stderr, "Error getting next leaf %d\n",
@@ -1035,18 +1032,12 @@ static int search_dir(struct btrfs_root *root, struct btrfs_key *key,
 			continue;
 		}
 		btrfs_item_key_to_cpu(leaf, &found_key, path.slots[0]);
-		if (found_key.objectid != key->objectid) {
-			if (verbose > 1)
-				printf("Found objectid=%Lu, key=%Lu\n",
-				       found_key.objectid, key->objectid);
+		if (found_key.objectid != key->objectid)
 			break;
-		}
-		if (found_key.type != key->type) {
-			if (verbose > 1)
-				printf("Found type=%u, want=%u\n",
-				       found_key.type, key->type);
+
+		if (found_key.type != key->type)
 			break;
-		}
+
 		dir_item = btrfs_item_ptr(leaf, path.slots[0],
 					  struct btrfs_dir_item);
 		name_ptr = (unsigned long)(dir_item + 1);
-- 
1.8.3.1

