Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58E82F2D06
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jan 2021 11:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbhALKhs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jan 2021 05:37:48 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:53470 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbhALKhs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jan 2021 05:37:48 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CATUpw058117;
        Tue, 12 Jan 2021 10:37:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=XOV77wP8Tqsr6aTHxPvrbO9f7w6twNF/XaRcK15TMJE=;
 b=r9h2sj9iKZpEnTyh2hU0vm3Bj+Lb+dN90EVb4Qbg+Ly/wrfP/T+5TfTcvB/Bv8v+Djzf
 IzZslyCMkg5iGM3FpoJXbwo6UvHmFBLGqm7XXGsDfrukI4U4L5ZzzG+eEMfpsZLx8TWf
 RovW/wuWP9FjiK6JUagQOcXH6hcvR2tC21nPtOlSQIJ0NoaDkjCFTmtM0OwzSkQNAHiN
 oz75MOGcUCFzo3unI0v8APzu/wQ9cXK0I2h85TmBD1cFfY08oINp9rhQDlEJ8Y6BSPdY
 5ZqAYxUVoeE8MpEHePDc0ySSQm3HU2j8gLj9EUPjUlTHfUDYrsZd4hujGpivnLGRp594 Qw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 360kg1npa7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Jan 2021 10:37:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CATxpk047997;
        Tue, 12 Jan 2021 10:35:05 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 360kexkcrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 10:35:05 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10CAZ3BP017025;
        Tue, 12 Jan 2021 10:35:03 GMT
Received: from localhost.localdomain (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 02:35:03 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com
Subject: [PATCH RFC] btrfs: no need to transition to rdonly for ENOSPC error
Date:   Tue, 12 Jan 2021 18:34:53 +0800
Message-Id: <169ba15cd316c181042bbe25e7d10c7963e3b7e8.1610444879.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9861 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120057
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9861 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120057
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In the current kernel both scrub and balance fails due to ENOSPC,
however there is no reason that it should be transitioned to the
RDONLY and making free spaces difficult.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 12d7d3be7cd4..8c1b858f55c4 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -172,6 +172,9 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function
 	if (sb_rdonly(sb))
 		return;
 
+	if (errno == -ENOSPC)
+		return;
+
 	btrfs_discard_stop(fs_info);
 
 	/* btrfs handle error by forcing the filesystem readonly */
-- 
2.18.4

