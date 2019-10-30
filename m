Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 755F2E984E
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2019 09:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfJ3Ild (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Oct 2019 04:41:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60440 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfJ3Ilc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Oct 2019 04:41:32 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9U8crQL054270;
        Wed, 30 Oct 2019 08:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=+Ho813UuMrlu7rk9iE6S99A3Dhw/fREytY+VkMNAToc=;
 b=fTLB2giYeegHTkv0mJIUB+WSSpfJadEBJ6y9xKOHXhflAlBn0Q/oVLd+SKiFBeKGlGTT
 O7KJP30PMGASBwdtWS6sj6+6/tUtV0lUCQ/G64Jyc9WnbFJyKMx+9MvOIhNKMbX1OzO6
 DxiSSBBVcMVHsh/Wv7Vah4LlEBwRxsTP9Za/ows+mqEmsCK7bqvZj8kxzoeL+pISaMy5
 LhIYYdjVPLp6+jyA5WaeuSdkNgoM3EPenE8Hj53Kx82X4e850QehWdFjmrcv/vwkPhPA
 clUuFleiNxo96OZb6469mfeiTsEq6udBUbFg+1TbRG9fGYtTYeisNJB5KPGYb9Dr7SjB uQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2vxwhfje02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 08:41:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9U8cpjw150096;
        Wed, 30 Oct 2019 08:41:30 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2vxwhvmfnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 08:41:30 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9U8fU73008011;
        Wed, 30 Oct 2019 08:41:30 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Oct 2019 01:41:29 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH v1 02/18] btrfs-progs: balance status: fix usage show long verbose
Date:   Wed, 30 Oct 2019 16:41:06 +0800
Message-Id: <20191030084122.29745-3-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191030084122.29745-1-anand.jain@oracle.com>
References: <20191030084122.29745-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910300086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910300086
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs balance status supports both short and long option -v|--verbose
but usage failed to show it in its --help. This patch fixes the --help.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/balance.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmds/balance.c b/cmds/balance.c
index 32830002f3a0..b236fabbe236 100644
--- a/cmds/balance.c
+++ b/cmds/balance.c
@@ -822,7 +822,7 @@ static const char * const cmd_balance_status_usage[] = {
 	"btrfs balance status [-v] <path>",
 	"Show status of running or paused balance",
 	"",
-	"-v     be verbose",
+	"-v|--verbose     be verbose",
 	NULL
 };
 
-- 
2.23.0

