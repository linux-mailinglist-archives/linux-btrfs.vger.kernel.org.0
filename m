Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F3323C99A
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Aug 2020 11:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgHEJyc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Aug 2020 05:54:32 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40554 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgHEJwM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Aug 2020 05:52:12 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0759lZjI002785;
        Wed, 5 Aug 2020 09:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=jVXoorume8SV69ux9wJBaq9dI1x9Ui2qpIvnLwvDi8M=;
 b=DFDbasSbii0CeyV1/yk5lmNINP1FFV7YMs04N+EBlX7SfmZmw83nggoxMu8qF+t1uGjl
 JrcoPbgumH916VilW5hH6rdzRql5yLvWl6R2hcVdBYcr2hoxUT0mFdNaap/bR7NwToTB
 dgkwJG/dW1jI9j+13eL62N3/TFh72OBwPpBotOS6LVHuLW56dmJ/GOFmXaA2fs0527Ca
 IAnXRYYnjFQK3a3x4HEzqrISXAuVeVBpQEFkfVPDKHlshvf7MAIc15C7ko3PDq0/w/ZV
 DOEw6kVtVcnfjYDF/ZGZM4MjvPiizZdm0bIISVK7G4DXm8wZrTY+9Pp1FnhluMGab3e/ Bg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 32pdnqcega-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 05 Aug 2020 09:51:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0759mtD9068676;
        Wed, 5 Aug 2020 09:51:55 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 32pdnsv7yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Aug 2020 09:51:55 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0759psKf027605;
        Wed, 5 Aug 2020 09:51:54 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Aug 2020 02:51:53 -0700
Date:   Wed, 5 Aug 2020 12:51:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] btrfs: Fix an error pointer vs NULL check
Message-ID: <20200805095147.GB483832@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9703 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008050081
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9703 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 suspectscore=0 clxscore=1011 priorityscore=1501 bulkscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008050081
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The btrfs_get_subvol_name_from_objectid() function never
returns NULL, it returns error pointers.  Update the check
accordinglingly to prevent an Oops.

Fixes: ca346708eb17 ("btrfs: don't show full path of bind mounts in subvol=")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/btrfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 53639de3a064..e529ddb35b87 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1475,7 +1475,7 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 		  BTRFS_I(d_inode(dentry))->root->root_key.objectid);
 	subvol_name = btrfs_get_subvol_name_from_objectid(info,
 			BTRFS_I(d_inode(dentry))->root->root_key.objectid);
-	if (subvol_name) {
+	if (!IS_ERR(subvol_name)) {
 		seq_puts(seq, ",subvol=");
 		seq_escape(seq, subvol_name, " \t\n\\");
 		kfree(subvol_name);
-- 
2.27.0

