Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB77AAFEE
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Sep 2019 02:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391677AbfIFAud (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Sep 2019 20:50:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57282 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390787AbfIFAuc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Sep 2019 20:50:32 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x860njtc184005
        for <linux-btrfs@vger.kernel.org>; Fri, 6 Sep 2019 00:50:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=WJNUg2f7I5IYoCVPqskPAZB6J/2s48spzPRcWwJOqhw=;
 b=qNHnvI9PLWMhzvUYThIZYgUfqQjw8w3dbNiQMoTaZo6X4F3eL2UY7uq6+KM7Lkl/SE/e
 k0WvNRfYfg5s57lmk2diNj5RsLoS333FJvvhi9zVai6PKqa886TBB+R9KS9c7ZxcOWom
 HWvzjD7MDj4M3OFawaBOgbepUxsb+DdoSBvJmJkJ5M6e16Ht5ZT+5NwYZ/L6kQDwZHT6
 EUHRGCCKIjUXF+gzl/WHrCS4dVJsGGzRXJs99fIrzun4KHvRBxPAxbuamECav5Gmyip+
 84P8iU3LpTmLopGZGfUfhs6XvYVU1rMLsWvXbEROGs26Z3D9Y2IOETvaNAJn3uu30afF Dg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2uud78g087-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Sep 2019 00:50:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x860m06d002657
        for <linux-btrfs@vger.kernel.org>; Fri, 6 Sep 2019 00:50:30 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2uu1b9741q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Sep 2019 00:50:30 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x860oT2h010022
        for <linux-btrfs@vger.kernel.org>; Fri, 6 Sep 2019 00:50:29 GMT
Received: from mb.sg.oracle.com (/10.191.51.169)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Sep 2019 17:50:28 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: drop unique uuid test for btrfstune -M
Date:   Fri,  6 Sep 2019 08:50:25 +0800
Message-Id: <20190906005025.2678-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-120)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9371 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909060005
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9371 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909060005
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

So this patch drops the check test_uuid_unique() for btrfstune -M|m.
Thanks.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
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

