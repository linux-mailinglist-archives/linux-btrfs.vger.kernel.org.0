Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97FB3564B3
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2019 10:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfFZIgL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jun 2019 04:36:11 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34870 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfFZIgK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jun 2019 04:36:10 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5Q8XX0W094714
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2019 08:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=E3EAeleBiXT0rgowwC4CvtN8PYGT9OSD3g3msD/hrY0=;
 b=nvhuuO/zDvej45e6X7axbFFROylu5ncED87z5mnLk5GbyqR27zKeviffIry6LuhLLRpc
 chMGFM6ws0mrekRNET7EGNcQ3PLMxDDZD5cH5PAsw9K+nr7B36HO/hVURqK1IvC96ell
 nKtOeRgNtncfTRw8FoWmHItWyrJELHmuhfTa6WkOAr2GaEPl7OamZ6vRgp2eT9MGssrn
 jJKguRFOlhKaGOgX5ySLzmEjjeBoHm0K4IsaDbJqmTC8z2TZRyPUdQ4lq1pfBtPnSz7X
 nEvW+/DyyqEO2+YH3TL5LyeXeN1rDXvid5F5QY0/3U4ESLhX0vZ2gHl9humZTIQS8hpM Xg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2t9c9prub1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2019 08:36:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5Q8Xtcq027355
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2019 08:34:09 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2t99f4bh1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2019 08:34:08 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5Q8Y8nQ015469
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2019 08:34:08 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Jun 2019 01:34:07 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3 RESEND Rebased] btrfs: add inode pointer to prop_handler::validate()
Date:   Wed, 26 Jun 2019 16:34:00 +0800
Message-Id: <20190626083402.1895-2-anand.jain@oracle.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190626083402.1895-1-anand.jain@oracle.com>
References: <20190626083402.1895-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906260104
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

In preparation to add the readmirror property, pass inode in the
prop_handler::validate() function vector, so that it can fetch
corresponding fs_devices.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/props.c | 12 +++++++-----
 fs/btrfs/props.h |  4 ++--
 fs/btrfs/xattr.c |  2 +-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index e0469816c678..f9143f7c006d 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -17,7 +17,7 @@ static DEFINE_HASHTABLE(prop_handlers_ht, BTRFS_PROP_HANDLERS_HT_BITS);
 struct prop_handler {
 	struct hlist_node node;
 	const char *xattr_name;
-	int (*validate)(const char *value, size_t len);
+	int (*validate)(struct inode *inode, const char *value, size_t len);
 	int (*apply)(struct inode *inode, const char *value, size_t len);
 	const char *(*extract)(struct inode *inode);
 	int inheritable;
@@ -55,7 +55,8 @@ find_prop_handler(const char *name,
 	return NULL;
 }
 
-int btrfs_validate_prop(const char *name, const char *value, size_t value_len)
+int btrfs_validate_prop(struct inode *inode, const char *name,
+			const char *value, size_t value_len)
 {
 	const struct prop_handler *handler;
 
@@ -69,7 +70,7 @@ int btrfs_validate_prop(const char *name, const char *value, size_t value_len)
 	if (value_len == 0)
 		return 0;
 
-	return handler->validate(value, value_len);
+	return handler->validate(inode, value, value_len);
 }
 
 int btrfs_set_prop(struct btrfs_trans_handle *trans, struct inode *inode,
@@ -252,7 +253,8 @@ int btrfs_load_inode_props(struct inode *inode, struct btrfs_path *path)
 	return ret;
 }
 
-static int prop_compression_validate(const char *value, size_t len)
+static int prop_compression_validate(struct inode *inode, const char *value,
+				     size_t len)
 {
 	if (!value)
 		return 0;
@@ -350,7 +352,7 @@ static int inherit_props(struct btrfs_trans_handle *trans,
 		 * This is not strictly necessary as the property should be
 		 * valid, but in case it isn't, don't propagate it futher.
 		 */
-		ret = h->validate(value, strlen(value));
+		ret = h->validate(inode, value, strlen(value));
 		if (ret)
 			continue;
 
diff --git a/fs/btrfs/props.h b/fs/btrfs/props.h
index 40b2c65b518c..5b1e39136f7f 100644
--- a/fs/btrfs/props.h
+++ b/fs/btrfs/props.h
@@ -13,8 +13,8 @@ void __init btrfs_props_init(void);
 int btrfs_set_prop(struct btrfs_trans_handle *trans, struct inode *inode,
 		   const char *name, const char *value, size_t value_len,
 		   int flags);
-int btrfs_validate_prop(const char *name, const char *value, size_t value_len);
-
+int btrfs_validate_prop(struct inode *inode, const char *name,
+			const char *value, size_t value_len);
 int btrfs_load_inode_props(struct inode *inode, struct btrfs_path *path);
 
 int btrfs_inode_inherit_props(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index 95d9aebff2c4..9bfe179717d3 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -378,7 +378,7 @@ static int btrfs_xattr_handler_set_prop(const struct xattr_handler *handler,
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 
 	name = xattr_full_name(handler, name);
-	ret = btrfs_validate_prop(name, value, size);
+	ret = btrfs_validate_prop(inode, name, value, size);
 	if (ret)
 		return ret;
 
-- 
2.20.1 (Apple Git-117)

