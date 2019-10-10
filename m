Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8397FD2225
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 09:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733058AbfJJHx7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 03:53:59 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47056 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbfJJHx6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 03:53:58 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9A7rtZl089336
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2019 07:53:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=Qwb4VH23uj87NOXi27p/NVxJEcoJKjUGMBd+uFC1VMU=;
 b=FAauTkyKfolTDNwYpapbaktRkiYe7ldvbCt4CK99l1QtO4PQEQVfIujUZx8crWnEaEnr
 l4jrilbPLehQt1uzbfdAnahh+y11/fG2ZuHQFi5k+m9rgCvhvvdZ2B+ZOVMGXO6A0zwh
 Ay9L3AyAqx21uNUykzUdftjcbxpwsJ5f3D9Ijcaxb/6KPWdIWnwW7VAh05MQ/m7TuZf6
 REiGgp3aruLbIwshrbGLS2Ku9pOOu3bLK2LpMO8IKKsBR7UK3ID19yGi7zUVaA7uKucz
 lb/NCn8BcNnvNNrLGvpU5r3PteLk/08KyfzfQQEw8RNnD5TUXM+bBNIaiqFlKTNmzdXb Hw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2vek4qsc75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2019 07:53:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9A7qWfr080555
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2019 07:53:57 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2vhhsp5y9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2019 07:53:57 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9A7ruD3009636
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2019 07:53:56 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Oct 2019 00:53:56 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RESEND] btrfs-progs: btrfstune -M|m drop test_uuid_unique
Date:   Thu, 10 Oct 2019 15:53:52 +0800
Message-Id: <20191010075352.8352-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910100074
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910100074
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's common to copy/snapshot an OS image to run another instance of the OS.
A duplicate fsid can't be mounted on the same system unless the fsid is
changed by using btrfstune -m.

However in some circumstances the image needs to go back to the original
fsid /metadata_uuid.

As of now btrfstune -M fails if the specified uuid isn't unique, as show
below.

btrfstune -M $(btrfs in dump-super ./2-2g.img | grep metadata_uuid | \
					awk '{print $2}') ./2-2g.img
ERROR: fsid 87f8d9c5-a8b7-438e-a890-17bbe11c95e5 is not unique

But as we are changing the fsid of an unmounted image, so its ok to
leave it to the users choice if the fsid is not unique, so that the
image can be sent back the system where it was used with that fsid.

So this patch drops the check test_uuid_unique() in btrfstune -M|m.
Thanks.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
Previous sent patch and its discussions:
https://patchwork.kernel.org/patch/11134157/

 btrfstune.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/btrfstune.c b/btrfstune.c
index afa3aae35412..4befcadef8b1 100644
--- a/btrfstune.c
+++ b/btrfstune.c
@@ -570,10 +570,6 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 			error("could not parse UUID: %s", new_fsid_str);
 			return 1;
 		}
-		if (!test_uuid_unique(new_fsid_str)) {
-			error("fsid %s is not unique", new_fsid_str);
-			return 1;
-		}
 	}
 
 	fd = open(device, O_RDWR);
-- 
2.21.0 (Apple Git-120)

