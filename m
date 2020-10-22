Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43528295986
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Oct 2020 09:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507174AbgJVHqG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Oct 2020 03:46:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58710 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442023AbgJVHqF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Oct 2020 03:46:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09M7iHiH136421;
        Thu, 22 Oct 2020 07:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=3lgTb5s9mcZDmJXNLrEMS44OxCOSHdKTVNG3EmCxgh4=;
 b=ztA1TGftukYifK6xgt6Wy4baT7nJLAY8WjTNvUkwQSJsK9QAI/z8kkxSimhOZYrwMdv8
 dZYXuhcxWvklKYeljHUe2PAAqyktjGrbJYVkA/Ejpsk6dGaPIAKr+2uK8or40DJvzpiP
 xTVQnjtBR7oMDeHvF+2za7yxNvUtAfqegBTx61thAnaXrm7gV/wZTSS/jpTiuct4970M
 Nf0OBo6uzHNaAJFDNI29Y6qiWrnkPK4ucUq5cKDWMdSxUx7wM6NPZbjyQ43O9XlSFjwt
 u5nrl3HEEoVu9V7k3xkDolvw20c/U37C7/I1CiaTwtv0WWlVsfivFRXsMcWQugm2ASqi Jg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 34ak16mp7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Oct 2020 07:45:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09M7a8EX176631;
        Thu, 22 Oct 2020 07:43:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 348a6qaa52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Oct 2020 07:43:59 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09M7hveW012650;
        Thu, 22 Oct 2020 07:43:57 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 22 Oct 2020 00:43:56 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com
Subject: [PATCH v9 1/3] btrfs: add btrfs_strmatch helper
Date:   Thu, 22 Oct 2020 15:43:35 +0800
Message-Id: <75264e50d49f3c68cc14dc87510c8f3767390dcf.1603347462.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1603347462.git.anand.jain@oracle.com>
References: <cover.1603347462.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 adultscore=0 suspectscore=1 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010220049
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010220050
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a generic helper to match the golden-string in the given-string,
and ignore the leading and trailing whitespaces if any.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Suggested-by: David Sterba <dsterba@suse.com>
---
v9: use Josef suggested C coding style, using single if statement.
v5: born

 fs/btrfs/sysfs.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 8424f5d0e5ed..5ea262d289c6 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -863,6 +863,26 @@ static ssize_t btrfs_generation_show(struct kobject *kobj,
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
+	/* strip trailing whitespace */
+	if ((strncmp(stripped, golden, len) == 0) &&
+	    (strlen(skip_spaces(stripped + len)) == 0))
+		return 0;
+
+	return -EINVAL;
+}
+
 static const struct attribute *btrfs_attrs[] = {
 	BTRFS_ATTR_PTR(, label),
 	BTRFS_ATTR_PTR(, nodesize),
-- 
2.25.1

