Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C079394B71
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 May 2021 11:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhE2JvJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 May 2021 05:51:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34302 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbhE2JvG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 May 2021 05:51:06 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14T9hpSo121216
        for <linux-btrfs@vger.kernel.org>; Sat, 29 May 2021 09:49:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=HdQeg4cge2O88c5SSPFAW1Q5HMs8xd/zSA3cisPRDTs=;
 b=TSGIbXhTFSDLN18lNM3xVRFA7UsS6XK6UJOfiHViHeUVq+B5SMcMgLuXlGMX+ACDxemm
 /UtSbdjqg5Vas7TzwVCACvvDlFkfwYPPByIPfirUF3ISPUTCO9KLs8bwvIOa8+fd1098
 8IhKjrlhRiIIgQvJIJ4bRHUyNRMXfYxVWN14be2qzqQ68KbdXyMhZ7fvPMJYudZNdXRS
 mvQlCfJnPDcLlAkmdfDBjYwzRgJo6RVOzZRzIlyrn7XjczmOX1xmpfJK+e0BwcSrAHlg
 QHTcnjQKv5LOb629eYJc+cSHsZobt7ENP1p5pWSlAzOFfLLcmBLrR3OuE/R2ZnebhYy/ rg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 38ue8p8dbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Sat, 29 May 2021 09:49:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14T9ihmd036224
        for <linux-btrfs@vger.kernel.org>; Sat, 29 May 2021 09:49:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 38ude2pq3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Sat, 29 May 2021 09:49:28 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14T9nSaU046300
        for <linux-btrfs@vger.kernel.org>; Sat, 29 May 2021 09:49:28 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 38ude2pq31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 May 2021 09:49:28 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 14T9nRgn013673;
        Sat, 29 May 2021 09:49:27 GMT
Received: from localhost.localdomain (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 29 May 2021 02:49:26 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 4/4] btrfs: fix comment about max_out in btrfs_compress_pages
Date:   Sat, 29 May 2021 17:48:36 +0800
Message-Id: <972fcec7e9fdc34b52ca186231497979812677eb.1622252933.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1622252932.git.anand.jain@oracle.com>
References: <cover.1622252932.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: x4nq7vj8Q4xEzzOw4DVaOPtq4yIhtsjA
X-Proofpoint-ORIG-GUID: x4nq7vj8Q4xEzzOw4DVaOPtq4yIhtsjA
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9998 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105290075
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit e5d74902362f (btrfs: derive maximum output size in the compression
implementation) removed @max_out argument in btrfs_compress_pages() but
its comment remained, remove it.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/compression.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index c523f384bd1a..35ca49893803 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -1192,9 +1192,6 @@ static unsigned int btrfs_compress_set_level(int type, unsigned level)
  *
  * @total_out is an in/out parameter, must be set to the input length and will
  * be also used to return the total number of compressed bytes
- *
- * @max_out tells us the max number of bytes that we're allowed to
- * stuff into pages
  */
 int btrfs_compress_pages(unsigned int type_level, struct address_space *mapping,
 			 u64 start, struct page **pages,
-- 
2.30.2

