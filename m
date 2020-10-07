Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198B3285C6D
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Oct 2020 12:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbgJGKIQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Oct 2020 06:08:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34448 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgJGKIQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Oct 2020 06:08:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0979nb95183061
        for <linux-btrfs@vger.kernel.org>; Wed, 7 Oct 2020 10:08:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=wxM9Xiwq7C4HMCZ5gC/EtSphDsj7/aFHZgOJU9+LajQ=;
 b=qNEi1ZdFMgs7zGEWGJSDrNHrhWOUVJVSKim4XO2GR79Mqaoiw83TtW6GM6WvzcxZH1Dk
 GApsFClRub7vzPSkmuH99qOjnR/sESWqkyBM010k2702EqHxiyF64SzxexrizUFlGK6s
 0XecLIAN8E9UZB/vcUJkTOla4mPefdx40yaTKgH0C5iHN3KYs1vu2Dgjkvx9YNOsfJSA
 MoPCWxCQd0jC7Y/C5PpbATRsqp/kpq+bZ3P2JYIiAVN4by4G0a8fgUT+iUEZdtBvRx6c
 Ce0xJ4sRbiEUYz+J2xb8pgrnCz9qRiPOv+9mdwF7vvNzEWG0MTVDeebJ5+65ItQ7Aqqr SQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 33xhxn0su4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Oct 2020 10:08:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0979oqY1074495
        for <linux-btrfs@vger.kernel.org>; Wed, 7 Oct 2020 10:08:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 3410jyecwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Oct 2020 10:08:14 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 097A8D1P030834
        for <linux-btrfs@vger.kernel.org>; Wed, 7 Oct 2020 10:08:13 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Oct 2020 03:08:12 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: btrfs-sb-mod add devid to the modifiable list
Date:   Wed,  7 Oct 2020 18:08:05 +0800
Message-Id: <8c8c3cbe61cc62d8a5f09ca497d6e88a0a1cd74d.1602065251.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9766 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=1 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070066
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9766 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=1 phishscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070066
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We need this patch to create a crafted image with bogus devid.

For example:
./btrfs-sb-mod devid =0

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 btrfs-sb-mod.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/btrfs-sb-mod.c b/btrfs-sb-mod.c
index ad143ca05aa6..832e29d29710 100644
--- a/btrfs-sb-mod.c
+++ b/btrfs-sb-mod.c
@@ -139,6 +139,7 @@ struct sb_field {
 	{ .name = "log_root_level",		.type = TYPE_U8 },
 	{ .name = "cache_generation",		.type = TYPE_U64 },
 	{ .name = "uuid_tree_generation",	.type = TYPE_U64 },
+	{ .name = "devid",			.type = TYPE_U64 },
 };
 
 #define MOD_FIELD_XX(fname, set, val, bits, f_dec, f_hex, f_type)	\
@@ -154,11 +155,28 @@ struct sb_field {
 		}							\
 	}
 
+#define MOD_DEV_FIELD_XX(fname, set, val, bits, f_dec, f_hex, f_type)	\
+	else if (strcmp(name, #fname) == 0) {				\
+		if (set) {						\
+			printf("SET: "#fname" "f_dec" (0x"f_hex")\n", \
+			(f_type)*val, (f_type)*val);				\
+			sb->dev_item.fname = cpu_to_le##bits(*val);			\
+		} else {							\
+			*val = le##bits##_to_cpu(sb->dev_item.fname);			\
+			printf("GET: "#fname" "f_dec" (0x"f_hex")\n", 	\
+			(f_type)*val, (f_type)*val);			\
+		}							\
+	}
+
 #define MOD_FIELD64(fname, set, val)					\
 	MOD_FIELD_XX(fname, set, val, 64, "%llu", "%llx", unsigned long long)
 
+#define MOD_DEV_FIELD64(fname, set, val)					\
+	MOD_DEV_FIELD_XX(fname, set, val, 64, "%llu", "%llx", unsigned long long)
+
 /* Alias for u64 */
 #define MOD_FIELD(fname, set, val)	MOD_FIELD64(fname, set, val)
+#define MOD_DEV_FIELD(fname, set, val)	MOD_DEV_FIELD64(fname, set, val)
 
 /*
  * Support only GET and SET properly, ADD and SUB may work
@@ -202,6 +220,7 @@ static void mod_field_by_name(struct btrfs_super_block *sb, int set, const char
 		MOD_FIELD8(log_root_level, set, val)
 		MOD_FIELD(cache_generation, set, val)
 		MOD_FIELD(uuid_tree_generation, set, val)
+		MOD_DEV_FIELD(devid, set, val)
 	else {
 		printf("ERROR: unhandled field: %s\n", name);
 		exit(1);
@@ -260,7 +279,8 @@ static int arg_to_op_value(const char *arg, enum field_op *op, u64 *val)
 	return 0;
 }
 
-int main(int argc, char **argv) {
+int main(int argc, char **argv)
+{
 	int fd;
 	loff_t off;
 	int ret;
-- 
2.25.1

