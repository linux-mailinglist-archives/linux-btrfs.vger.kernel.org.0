Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECAA3E2A6B
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 08:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437756AbfJXG2h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Oct 2019 02:28:37 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55674 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437738AbfJXG2h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Oct 2019 02:28:37 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O6O0Vw178710
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2019 06:28:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=mPlxhVDF+hCtdwbeCs3VbucGQP5oFBe8/QoY08apD6U=;
 b=pcRZwuCjAJO+bi5m6yIjA1L2SpPKXHRUbPcI4VwnOl7wTAeVSp7SShNFKuu+xxVlRpmH
 xE3eJvEb/1tt4OxsPm9norqwzAVetyuWxLIghWZCjT1jB/uNd5kOdKFLcn0NF063e3HE
 32GieYlbZFvsCwL4QBDEDDAfaztDGhDo/KWeo8DfHXrnjgT+6sr3asq/7rMqlp33lKmn
 HoctOBzr5+JkArcwKRAn1ZtJRHzNOzS15TtAK2nemQRaYM62MVDNCluyJX1u2wo2phJ7
 t264CSxiLd2pN9fFWF7H3gnZcL9oEidMbkEFIzg1oiWPOkOapotgi15rHT6f/MBdqtQV 5Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2vqswtsktt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2019 06:28:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O6Mv7i150710
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2019 06:28:35 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2vtsk3vqy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2019 06:28:35 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9O6SXdu023386
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2019 06:28:34 GMT
Received: from localhost.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Oct 2019 23:28:33 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [RFC PATCH 3/3] btrfs-progs: receive: make quiet really quiet
Date:   Thu, 24 Oct 2019 14:28:25 +0800
Message-Id: <20191024062825.13097-4-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024062825.13097-1-anand.jain@oracle.com>
References: <20191024062825.13097-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=957
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910240060
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910240060
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A message is still being printed even when the receive option --quiet
is specified, this patch fixes it.

before:
---- btrfs receive -q -f /tmp/t /btrfs1 -----
At snapshot ss3
---- btrfs receive -f /tmp/t /btrfs1 -----
At snapshot ss3

after:
---- btrfs receive -q -f /tmp/t /btrfs1 -----
---- btrfs receive -f /tmp/t /btrfs1 -----
At snapshot ss3

Signed-off-by: Anand Jain <anand.jain@oracle.com>

fstests doesn't use --quiet option, so all test cases should remain
unaffected with this change.
---
 cmds/receive.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/cmds/receive.c b/cmds/receive.c
index d8c934a7c57c..cc3df5c35821 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -269,7 +269,8 @@ static int process_snapshot(const char *path, const u8 *uuid, u64 ctransid,
 		goto out;
 	}
 
-	fprintf(stdout, "At snapshot %s\n", path);
+	if (g_verbose)
+		fprintf(stdout, "At snapshot %s\n", path);
 
 	memcpy(rctx->cur_subvol.received_uuid, uuid, BTRFS_UUID_SIZE);
 	rctx->cur_subvol.stransid = ctransid;
-- 
2.23.0

