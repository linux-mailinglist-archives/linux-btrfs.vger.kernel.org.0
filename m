Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F6F274FAC
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Sep 2020 05:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgIWDwV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 23:52:21 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57680 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIWDwV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 23:52:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08N3mu1Y023229;
        Wed, 23 Sep 2020 03:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=vNxsyMf157OJcramj5uIGqbOTeslPkHJBftIQUlEjdI=;
 b=hId3OJrb8C2zA4Cgdoh82fiJDl8T/fSm4JG0+GC0kXl/2/F27dRH7l/a4j2f3wNyM0Ov
 XUcwS+iZpFA9K8ZWg5hUsuXUzco459v0WLJMXMNqMGoKAVQuOMNiOpCO03oR/Hg3AtoL
 wk8HGtJP8k6vTqOHbLkBCFvfgg5H0THI3eCC4dV9IK330DJCpScXNa5OMOS4icHxcWny
 tnTDqNTO7I25m3gkw4+uB7V37E/KtcdHIGZJHuvKNV74DbkpQJ3T5eX9LnlJtUZYednu
 ha0MSKVpzIrfuOI5nHaVXb+PdiWWieDf7SZ6YPBVj8J7l/znBEf9s4gUb8qpWNcdegY+ Og== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 33ndnug4c5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Sep 2020 03:52:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08N3o1QA004859;
        Wed, 23 Sep 2020 03:52:17 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 33nuw5r814-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Sep 2020 03:52:17 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08N3qGT2002640;
        Wed, 23 Sep 2020 03:52:16 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Sep 2020 20:52:15 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     johannes.thumshirn@wdc.com, josef@toxicpanda.com
Subject: [PATCH] fstests: add btrfs/218 to seed group
Date:   Wed, 23 Sep 2020 11:52:04 +0800
Message-Id: <3d196401103c515ffdcf149a01ca781a5c55a6be.1600833114.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9752 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=1 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009230026
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9752 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=1 bulkscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009230026
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's a seed test case. Add it to the seed group.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/group | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/group b/tests/btrfs/group
index 1b5fa695a9f7..f7b493d0435f 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -219,6 +219,6 @@
 215 auto quick
 216 auto quick seed
 217 auto quick trim dangerous
-218 auto quick volume
+218 auto quick seed volume
 219 auto quick volume
 220 auto quick
-- 
2.25.1

