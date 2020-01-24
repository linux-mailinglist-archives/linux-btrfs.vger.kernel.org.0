Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 729661478F2
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 08:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgAXHZ3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 02:25:29 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:43162 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgAXHZ2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 02:25:28 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00O7NEd5108219
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 07:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=BXcOUnNEiYk9pqyAhcqk+TwNqxL33dMOWKdeWgbNlRg=;
 b=LDaRZT1wS0lPyY/DTyT0SA3XwBHE6vk5Zw7d5o/Npz3DdvUYMZVJe+DnOhP9MwkxNUAk
 Bn2Rkq32dkZyaeZ8KBOL2HLx5+d47AgCYi3vb+dz//8HAF+BHag28WX0AQWCR/g33nuL
 JHv19x6LF4FlkkAM4cF2AlGyvldyLlxBJhHURtoyTd40N+1ntRn5hYhlvdU7FAI0F3iB
 gAsagIV4f27XyxKPEduv5aLiCuFcULcN5Cqj1Ge0abIF/ogucI0I1xCpIybYLgmeD4v0
 53qJoc2y/Z7d4UgtDnOHLDhZnljSMbzPdCiZccnoRsQFD6rFKeUsZQXvEotwYrKAZSMd MQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2xksyqqbwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 07:25:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00O7OJYm022333
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 07:25:27 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2xqmuebp4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 07:25:26 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00O7PP0A001874
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 07:25:25 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 Jan 2020 23:25:25 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: fix btrfs-qgroup man page as unstable feature
Date:   Fri, 24 Jan 2020 15:25:21 +0800
Message-Id: <20200124072521.3462-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9509 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001240060
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9509 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001240060
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are known performance and counting errors for the quota when qgroup is
enabled.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 Documentation/btrfs-qgroup.asciidoc | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/btrfs-qgroup.asciidoc b/Documentation/btrfs-qgroup.asciidoc
index 0c9f5940a1d3..2da3d7819ba6 100644
--- a/Documentation/btrfs-qgroup.asciidoc
+++ b/Documentation/btrfs-qgroup.asciidoc
@@ -16,8 +16,7 @@ DESCRIPTION
 NOTE: To use qgroup you need to enable quota first using *btrfs quota enable*
 command.
 
-WARNING: Qgroup is not stable yet and will impact performance in current mainline
-kernel (v4.14).
+WARNING: Qgroup is an unstable feature as of now.
 
 QGROUP
 ------
-- 
2.23.0

