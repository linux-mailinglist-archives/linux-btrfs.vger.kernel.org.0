Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B63C1CEC79
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 May 2020 07:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbgELFig (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 May 2020 01:38:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:32852 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgELFig (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 May 2020 01:38:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04C5bXxh137732;
        Tue, 12 May 2020 05:38:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=QA9Y8qSvmF25zwbGM+iJGc5fZkKFhQ6TxMYGBNlezeQ=;
 b=QV9jvPWqrlxxkLFt1uWeVmlbY0hl2QuIu8CizoTBZSuS87f7PZ+pQZCqyAp9FQJnD6vQ
 iCCYhSXrWJ+Yn1Sc1S/9XBC+MNLllfZWCxXhRyPNKY1hvDnTK1s/VnNRqdKGU3D0EzNh
 9EWfBzqcmgSL02g1Hf53O/pdB+86vZg25c7UPgRgozI4MI8W8iqgomQ3H6y/c12F9ZNu
 qvT9I1b6V8vQ2F/UGWoQAS78YHgxZTdQwzD5YH+IhUvs3VWA04Bqi2LNdfA1D0xb33Nm
 iKm1ISTRJGr4kZaRJnjXnoblJIsll1RSIc1Srl2+Ijx61E7o/ljnhLXT8gHwT4Sd3g5X XQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 30x3gsgtcn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 May 2020 05:38:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04C5YWPM147027;
        Tue, 12 May 2020 05:38:31 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 30xbgh5yu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 May 2020 05:38:31 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04C5cUe0029510;
        Tue, 12 May 2020 05:38:30 GMT
Received: from localhost.localdomain (/39.109.177.87) by default (Oracle
 Beehive Gateway v4.0) with ESMTP ; Mon, 11 May 2020 22:38:18 -0700
MIME-Version: 1.0
Message-ID: <20200512053751.22092-1-anand.jain@oracle.com>
Date:   Mon, 11 May 2020 22:37:51 -0700 (PDT)
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH] btrfs: unexport btrfs_compress_set_level()
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 suspectscore=1 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005120049
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005120049
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_compress_set_level() can be static function in the file
compression.c.

Fixes: b0c1fe1eaf5e (btrfs: compression: replace set_level callbacks by
a common helper)
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/compression.c | 32 ++++++++++++++++----------------
 fs/btrfs/compression.h |  2 --
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 9ab610cc9114..e4ee724d47df 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -1141,6 +1141,22 @@ static void put_workspace(int type, struct list_head *ws)
 	}
 }
 
+/*
+ * Adjust @level according to the limits of the compression algorithm or
+ * fallback to default
+ */
+static unsigned int btrfs_compress_set_level(int type, unsigned level)
+{
+	const struct btrfs_compress_op *ops = btrfs_compress_op[type];
+
+	if (level == 0)
+		level = ops->default_level;
+	else
+		level = min(level, ops->max_level);
+
+	return level;
+}
+
 /*
  * Given an address space and start and length, compress the bytes into @pages
  * that are allocated on demand.
@@ -1748,19 +1764,3 @@ unsigned int btrfs_compress_str2level(unsigned int type, const char *str)
 
 	return level;
 }
-
-/*
- * Adjust @level according to the limits of the compression algorithm or
- * fallback to default
- */
-unsigned int btrfs_compress_set_level(int type, unsigned level)
-{
-	const struct btrfs_compress_op *ops = btrfs_compress_op[type];
-
-	if (level == 0)
-		level = ops->default_level;
-	else
-		level = min(level, ops->max_level);
-
-	return level;
-}
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index d253f7aa8ed5..284a3ad31350 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -140,8 +140,6 @@ extern const struct btrfs_compress_op btrfs_zstd_compress;
 const char* btrfs_compress_type2str(enum btrfs_compression_type type);
 bool btrfs_compress_is_valid_type(const char *str, size_t len);
 
-unsigned int btrfs_compress_set_level(int type, unsigned level);
-
 int btrfs_compress_heuristic(struct inode *inode, u64 start, u64 end);
 
 #endif
-- 
2.25.1

