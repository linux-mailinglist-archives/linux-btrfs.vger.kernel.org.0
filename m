Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7A43EADF5
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Oct 2019 11:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfJaK5R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Oct 2019 06:57:17 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41464 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfJaK5Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Oct 2019 06:57:16 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9VAsVqx176368;
        Thu, 31 Oct 2019 10:57:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=1sG/Yfs8vobHE1MHtWKvt3EvUARJQXQLqUpb9M6oFB4=;
 b=NyaOBEV93IoD8pDIk/KcV4JZPe9bCa1quM606v5LfIfUChHkL7SVKTdaMLZhaCoa9qbK
 QpeZREAsGO3DROkyxkOJ1rPAB7S+Q0SFEjJc77gIr5LGjvSaYXdRnKZnBfDvMIDyzAOO
 p+ast89RAeb4i/8Nng2h0IgmK+mLiDWSeNGhmaVtiQOYqPGsuIRJjtz/D5LWx2Jd+L27
 rREJRpHfiWI1TutepPR2ChexFeXBbQqAhlMvAjVIpr66NhfdX0axQjJR/uT8Pl5jvvkE
 RribWGe9q7Td26PhuNPCR4/9jX/hmh2UvynfDDrCDD9BiGFCAk3kk3Qf6esgV7qilOOh 6w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2vxwhfjedb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 10:57:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9VArk7E160618;
        Thu, 31 Oct 2019 10:55:10 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2vyv9fx6ev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 10:55:09 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9VAt866005535;
        Thu, 31 Oct 2019 10:55:08 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 31 Oct 2019 03:55:08 -0700
Date:   Thu, 31 Oct 2019 13:55:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] btrfs: clean up locking name in scrub_enumerate_chunks()
Message-ID: <20191031105501.GB26612@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910310111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910310111
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The "&fs_info->dev_replace.rwsem" and "&dev_replace->rwsem" refer to
the same lock but Smatch is not clever enough to figure that out so it
leads to static checker warnings.  It's better to use it consistently
anyway.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/btrfs/scrub.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 4a5a4e4ef707..06494304ab80 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3620,7 +3620,7 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 			break;
 		}
 
-		down_write(&fs_info->dev_replace.rwsem);
+		down_write(&dev_replace->rwsem);
 		dev_replace->cursor_right = found_key.offset + length;
 		dev_replace->cursor_left = found_key.offset;
 		dev_replace->item_needs_writeback = 1;
@@ -3661,10 +3661,10 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 
 		scrub_pause_off(fs_info);
 
-		down_write(&fs_info->dev_replace.rwsem);
+		down_write(&dev_replace->rwsem);
 		dev_replace->cursor_left = dev_replace->cursor_right;
 		dev_replace->item_needs_writeback = 1;
-		up_write(&fs_info->dev_replace.rwsem);
+		up_write(&dev_replace->rwsem);
 
 		if (ro_set)
 			btrfs_dec_block_group_ro(cache);
-- 
2.20.1

