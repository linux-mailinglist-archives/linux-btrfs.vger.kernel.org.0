Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1E4564B9
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2019 10:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfFZIhh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jun 2019 04:37:37 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36188 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfFZIhh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jun 2019 04:37:37 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5Q8XTai094511
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2019 08:37:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=6xsjW0a6Mh130bz9FEHliziANLE3HUWx6kVGTVzsq1s=;
 b=CelM7N1LMB+cUebkp6FnTYboVjdFQs0nxzgezK/NJCTTFAuxSJJRiYrbHaEoeyiesjqq
 hQJFAnbFgOxH3PQoZND+7PTwNjG/ZtG2/IxfPTCK7scLjcjeXVvAnojUK8v03iiOlr+W
 cokcMPGEM7YUGSBVnqraxEFGxAWoGizXPDGlDYJp0QXI9cdJ2oKqojSLZxCXgoJ11M8I
 UiGDaRB6pur4oqfBM6CK7rWD+OwzjxOvE1IGfmAkwIN4kUY1GyZLSbv2zZcowU3haGQ1
 04TXU5XEG9AKMjZrQ+DNTdA5D8BJQa/se166R3LdFP88Nfa+CHblDcI4Yb+2fyxRaYL7 Aw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2t9c9prus8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2019 08:37:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5Q8bZZR035918
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2019 08:37:35 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2t9p6unmbu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2019 08:37:30 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5Q8bT85003963
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2019 08:37:29 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Jun 2019 01:37:28 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2 RESEND Rebased] btrfs-progs: add readmirror policy
Date:   Wed, 26 Jun 2019 16:37:23 +0800
Message-Id: <20190626083723.2094-2-anand.jain@oracle.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190626083723.2094-1-anand.jain@oracle.com>
References: <20190626083402.1895-1-anand.jain@oracle.com>
 <20190626083723.2094-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906260105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260104
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This sets the readmirror=<parm> as a btrfs.<attr> extentded attribute.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 props.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/props.c b/props.c
index 3a498bd9e904..1d1a2c7f9d14 100644
--- a/props.c
+++ b/props.c
@@ -178,6 +178,53 @@ out:
 	return ret;
 }
 
+static int prop_readmirror(enum prop_object_type type, const char *object,
+			   const char *name, const char *value)
+{
+	int fd;
+	int ret;
+	char buf[256] = {0};
+	char *xattr_name;
+	DIR *dirstream = NULL;
+
+	fd = open_file_or_dir3(object, &dirstream, value ? O_RDWR : O_RDONLY);
+	if (fd < 0) {
+		ret = -errno;
+		error("failed to open %s: %m", object);
+		return ret;
+	}
+
+	xattr_name = alloc_xattr_name(name);
+	if (IS_ERR(xattr_name)) {
+		error("failed to alloc xattr_name %s: %m", object);
+		return PTR_ERR(xattr_name);
+	}
+
+	ret = 0;
+	if (value) {
+		if (fsetxattr(fd, xattr_name, value, strlen(value), 0) < 0) {
+			ret = -errno;
+			error("failed to set readmirror for %s: %m", object);
+		}
+	} else {
+		if (fgetxattr(fd, xattr_name, buf, 256) < 0) {
+			if (errno != ENOATTR) {
+				ret = -errno;
+				error("failed to get readmirror for %s: %m",
+				      object);
+			}
+		} else {
+			fprintf(stdout, "readmirror=%.*s\n", (int) strlen(buf),
+				buf);
+		}
+	}
+
+	free(xattr_name);
+	close_file_or_dir(fd, dirstream);
+
+	return ret;
+}
+
 const struct prop_handler prop_handlers[] = {
 	{"ro", "Set/get read-only flag of subvolume.", 0, prop_object_subvol,
 	 prop_read_only},
@@ -185,5 +232,7 @@ const struct prop_handler prop_handlers[] = {
 	 prop_object_dev | prop_object_root, prop_label},
 	{"compression", "Set/get compression for a file or directory", 0,
 	 prop_object_inode, prop_compression},
+	{"readmirror", "set/get readmirror policy for filesystem", 0,
+	 prop_object_root, prop_readmirror},
 	{NULL, NULL, 0, 0, NULL}
 };
-- 
1.8.3.1

