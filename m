Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26229293E13
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Oct 2020 16:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407801AbgJTODR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Oct 2020 10:03:17 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44740 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407796AbgJTODQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Oct 2020 10:03:16 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09KDwe04020166;
        Tue, 20 Oct 2020 14:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=TzE67M+tCTfHivihyiWDT/nwZ+UJ/PZUoWqYwEwrgEI=;
 b=jg2ifzCeT/jiNGE/dWBh5tXI6wMMBsBWoRnXL+1Dh/CrIQgTZ2eNI1Lrc5epTOdTC/q4
 eBppaKQT6YBi1wXa9SIXsaC3wi7XfwQZc/ZvWrgtdJ+YCj1947NOrxxueBPjL1CY0ElW
 MGecaqhuC2chW6BQfWWJ6vhyB+brRmyW1B5RY9Uw7KcKPxJOXK1RPn5+K8Ecjhg4lODE
 cDsJDTf4DwJwb3dFtFoCoLXbolXiK0Y7n32eHI9VhhKdqTe3pIHcF8OZhISrTkNzLID/
 f1h9l9Z0Iv1MHmWP+M/Ew8YDwVbboJ/YdOACckMEw4ZD8+MiXBzPuDY5vz4IBfkqibTP /A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 349jrpkcvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Oct 2020 14:03:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09KE1aJx127767;
        Tue, 20 Oct 2020 14:03:11 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 348agxec1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Oct 2020 14:03:11 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09KE3B5M008863;
        Tue, 20 Oct 2020 14:03:11 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 20 Oct 2020 07:03:09 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v8 1/3] btrfs: add btrfs_strmatch helper
Date:   Tue, 20 Oct 2020 22:02:13 +0800
Message-Id: <7418ae34e5a4cc7d110eed756d9e37c5630ec568.1602756068.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1602756068.git.anand.jain@oracle.com>
References: <cover.1602756068.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9779 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=1 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010200095
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9779 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=1 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010200095
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a generic helper to match the golden-string in the given-string,
and ignore the leading and trailing whitespaces if any.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Suggested-by: David Sterba <dsterba@suse.com>
---
v5: born

 fs/btrfs/sysfs.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 8424f5d0e5ed..eb0b2bfcce67 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -863,6 +863,29 @@ static ssize_t btrfs_generation_show(struct kobject *kobj,
 }
 BTRFS_ATTR(, generation, btrfs_generation_show);
 
+/*
+ * Match the %golden in the %given. Ignore the leading and trailing whitespaces
+ * if any.
+ */
+static int btrfs_strmatch(const char *given, const char *golden)
+{
+	size_t len = strlen(golden);
+	char *stripped;
+
+	/* strip leading whitespace */
+	stripped = skip_spaces(given);
+
+	if (strncmp(stripped, golden, len) == 0) {
+		/* strip trailing whitespace */
+		if (strlen(skip_spaces(stripped + len)))
+			return -EINVAL;
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 static const struct attribute *btrfs_attrs[] = {
 	BTRFS_ATTR_PTR(, label),
 	BTRFS_ATTR_PTR(, nodesize),
-- 
2.25.1

