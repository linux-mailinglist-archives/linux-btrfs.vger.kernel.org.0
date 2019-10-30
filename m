Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F72EE9870
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2019 09:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfJ3IsH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Oct 2019 04:48:07 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42788 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfJ3IsH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Oct 2019 04:48:07 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9U8cbcH036237;
        Wed, 30 Oct 2019 08:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=1c1Zg3UflTmkGFhjebS0lkduhabm/1qnNdMje/Wjk44=;
 b=Emw9DAXQ5KYUDjWtWJvKRoJL/FSlTft/YF/4HVb/rU5+cBAFlI8mX67QF92HvB0UbHyj
 Arsrv1TYZht+LAElorXlSk08fE9MOjfvOmJV4nNIpJ6a/Hq8V+WajcdTURMHH7cYoIRb
 t2O9+QAyQnP1SHGYHjlhRM+mQk5Lfk8jEA2SCcTUkKdJdZ0n+0oqubjgpYa0DNwEvn70
 Ag5O1kNFuVqNhl7r8A7jeP/wzgWQkRdxNsTKtQhjNNDfR+gO02qGGAD1UOPyjpBPHr1m
 +xkMNiK6qehvSLbtsM9xiisa5PoHfyGz/tT7umqZgRpbQu05pwJgSYj/M2V7w40f5Hgz Ug== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2vxwhfafdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 08:41:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9U8bvMk113504;
        Wed, 30 Oct 2019 08:41:32 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2vxwj9ja49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 08:41:32 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9U8fVkY008376;
        Wed, 30 Oct 2019 08:41:31 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Oct 2019 01:41:31 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH v1 03/18] btrfs-progs: balance start: fix usage add long verbose
Date:   Wed, 30 Oct 2019 16:41:07 +0800
Message-Id: <20191030084122.29745-4-anand.jain@oracle.com>
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

btrfs balance start supports both short and long option -v|--verbose
however usage failed to show the long option. This patch fixes the --help.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/balance.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmds/balance.c b/cmds/balance.c
index b236fabbe236..a98cd8d6200f 100644
--- a/cmds/balance.c
+++ b/cmds/balance.c
@@ -490,7 +490,7 @@ static const char * const cmd_balance_start_usage[] = {
 	"-d[filters]    act on data chunks",
 	"-m[filters]    act on metadata chunks",
 	"-s[filters]    act on system chunks (only under -f)",
-	"-v             be verbose",
+	"-v|--verbose   be verbose",
 	"-f             force a reduction of metadata integrity",
 	"--full-balance do not print warning and do not delay start",
 	"--background|--bg",
-- 
2.23.0

