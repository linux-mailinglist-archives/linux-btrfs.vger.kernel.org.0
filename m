Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBB2B17933C
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 16:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbgCDPXL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 10:23:11 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:42968 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbgCDPXL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Mar 2020 10:23:11 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 024FI4Ll026977
        for <linux-btrfs@vger.kernel.org>; Wed, 4 Mar 2020 15:23:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2020-01-29;
 bh=B9Na65P4WYj14bRrDxKoIhqTK7ym17mb9g56DRqpx9U=;
 b=hpIntEcwJJHGAu/w0pLeYsxkOAcfVvSBOXad6QzjAS/ZTb+JHCEzxWBwDWBfaKIqJCYD
 ZIHQevLr6bMzwWiT+aSeqH0+HsK/u9yGfQdTrpYy0MjveVLyAQqfdaggb23ZynRMVqHr
 aBOlR6xBOecf3Vfpx1LZo+yDYSRwTUs8HnEuiMM59eUT2+szvc1yoCqo6JWY4g+LYDWY
 PwW7t6h1fKMPSnbh5SP4yf2IBM9Z5XJj4hOCnnuZrmzt7+FZu3nMdpFpna7E+g40S+FA
 h8gXRP47NnsU4OoYA3peGMkm9KR9mEesHoBLW2REQpunDI4AIBFitI741nOHossguZl3 Uw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2yffwqxxhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Mar 2020 15:23:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 024FGj1D031352
        for <linux-btrfs@vger.kernel.org>; Wed, 4 Mar 2020 15:23:08 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2yg1eq29d7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Mar 2020 15:23:08 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 024FN75e010639
        for <linux-btrfs@vger.kernel.org>; Wed, 4 Mar 2020 15:23:07 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Mar 2020 15:23:07 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs-progs: convert, warn if converting a fs which won't mount
Date:   Wed,  4 Mar 2020 23:22:05 +0800
Message-Id: <1583335325-20569-1-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=1 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003040114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=1
 phishscore=0 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003040114
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On aarch64 with pagesize 64k, btrfs-convert of ext4 is successful,
but it won't mount because we don't yet support subpage blocksize/
sectorsize.

 BTRFS error (device vda): sectorsize 4096 not supported yet, only support 65536

So in this case during convert provide a warning.

For example:

WARNING: Blocksize 4096 is not equal to the pagesize 65536,
         converted filesystem won't mount on this system.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Drop the delay part. Update the change log.

 convert/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/convert/main.c b/convert/main.c
index a04ec7a36abf..5b2979e3e1e6 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -1140,6 +1140,11 @@ static int do_convert(const char *devname, u32 convert_flags, u32 nodesize,
 		error("block size is too small: %u < 4096", blocksize);
 		goto fail;
 	}
+	if (blocksize != getpagesize())
+		warning("Blocksize %u is not equal to the pagesize %u,\n\
+         converted filesystem won't mount on this system.",
+			blocksize, getpagesize());
+
 	if (btrfs_check_nodesize(nodesize, blocksize, features))
 		goto fail;
 	fd = open(devname, O_RDWR);
-- 
1.8.3.1

