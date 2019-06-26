Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 628E3564BA
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2019 10:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfFZIhj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jun 2019 04:37:39 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36242 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfFZIhj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jun 2019 04:37:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5Q8XT0b094509
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2019 08:37:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=ngDpWvpNEeyfWePElqY+V2nvbBvkPOOCKyLHybH7bEY=;
 b=0ZlRTBK/JpjIDRha1VQMJvtbibEMh3/rWhz73wyy7107u7tu0ByXTw9pFYWixs0KxhIX
 VXRIGAZG6tnawH5xHog6572CKjex5l+ZO+FYIgT2+V08LCB607XoPsl1ena7zUJAyvq/
 7lu2OYMV+qu/rMEK/zj9fopWgzXx3ZI0Y952oDQxF3Upfwg74oNePxl8eGKbA6mxYDU4
 bSAIQyIkkeqzAwtYCN7YYwOhCDdUE/2JfHUWtqHDqhOFzCtdozk8UJmr6UHa0w7dP2U+
 oo3xnwdl7SEXNvW43q+JzAgtT1fs8eJs+8r26fAUTWL/LMCf8w0hW05KMmjy3XBMhmnW zw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2t9c9prut0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2019 08:37:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5Q8baNH164855
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2019 08:37:37 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2t9acck2pp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2019 08:37:37 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5Q8bRvw003950
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2019 08:37:27 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Jun 2019 01:37:27 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2 RESEND Rebased] btrfs-progs: add helper to create xattr name
Date:   Wed, 26 Jun 2019 16:37:22 +0800
Message-Id: <20190626083723.2094-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190626083402.1895-1-anand.jain@oracle.com>
References: <20190626083402.1895-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906260105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260104
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a preparatory patch to add more xattr attributes, care a helper
function to alloc xattr name.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 props.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/props.c b/props.c
index efa11180d4c5..3a498bd9e904 100644
--- a/props.c
+++ b/props.c
@@ -94,6 +94,21 @@ static int prop_label(enum prop_object_type type,
 	return ret;
 }
 
+static char *alloc_xattr_name(const char *name)
+{
+	char *xattr_name;
+
+	xattr_name = malloc(XATTR_BTRFS_PREFIX_LEN + strlen(name) + 1);
+	if (!xattr_name)
+		ERR_PTR(-ENOMEM);
+
+	memcpy(xattr_name, XATTR_BTRFS_PREFIX, XATTR_BTRFS_PREFIX_LEN);
+	memcpy(xattr_name + XATTR_BTRFS_PREFIX_LEN, name, strlen(name));
+	xattr_name[XATTR_BTRFS_PREFIX_LEN + strlen(name)] = '\0';
+
+	return xattr_name;
+}
+
 static int prop_compression(enum prop_object_type type,
 			    const char *object,
 			    const char *name,
@@ -114,14 +129,11 @@ static int prop_compression(enum prop_object_type type,
 		goto out;
 	}
 
-	xattr_name = malloc(XATTR_BTRFS_PREFIX_LEN + strlen(name) + 1);
-	if (!xattr_name) {
-		ret = -ENOMEM;
-		goto out;
+	xattr_name = alloc_xattr_name(name);
+	if (IS_ERR(xattr_name)) {
+		error("failed to alloc xattr_name %s: %m", object);
+		return PTR_ERR(xattr_name);
 	}
-	memcpy(xattr_name, XATTR_BTRFS_PREFIX, XATTR_BTRFS_PREFIX_LEN);
-	memcpy(xattr_name + XATTR_BTRFS_PREFIX_LEN, name, strlen(name));
-	xattr_name[XATTR_BTRFS_PREFIX_LEN + strlen(name)] = '\0';
 
 	if (value) {
 		if (strcmp(value, "no") == 0 || strcmp(value, "none") == 0)
-- 
1.8.3.1

