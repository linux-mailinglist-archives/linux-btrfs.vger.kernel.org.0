Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECCB17DED7
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Mar 2020 12:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgCILkq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Mar 2020 07:40:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55984 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgCILkq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Mar 2020 07:40:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 029BcLij054264;
        Mon, 9 Mar 2020 11:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=LJ4OruDVxqoyMVWywxvSE+1biPdg7OzrzQZPPJHHaj0=;
 b=BmxEzjn5uvP9peSaSKk/tgzbi0CcAaiKALek67tmqWkpS9AQwY5IpLHGyBsQlGOAQLH8
 PrFz8p0TaFT1WA1aUCUEnWufLVQfC5xF7R/+o0hb/0JgqegAOeV/z0Y7d/bATPZ+xS59
 jc6yHUUV/p+cC5Xk0twNfAesO7aepi8NDdMxUHJoiKMJXFlnyGBLkUFhAsNpTdoaz4RU
 vJNEEUd/ye/2PkdPZrHc+KT3FLwjags1a+P4dUvlAupmV0lyT1FrvazXmg2RnuGy7l+7
 FV7FKmN/pGhshIdy7ZFFslvw8WJRxJG0h8R/Uvp4XG9njHk/CuEETNsCk8L7GW6oYMmL Eg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2ym3jqefm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Mar 2020 11:40:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 029Bb6sq100241;
        Mon, 9 Mar 2020 11:40:43 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2ymn3fryar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Mar 2020 11:40:43 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 029Beg9D022307;
        Mon, 9 Mar 2020 11:40:43 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Mar 2020 04:40:42 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] fstests: btrfs/177 check for minsize of the scratch device
Date:   Mon,  9 Mar 2020 19:40:35 +0800
Message-Id: <20200309114036.5266-2-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200309114036.5266-1-anand.jain@oracle.com>
References: <20200309114036.5266-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9554 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=13 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003090082
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9554 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=13 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003090082
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This test case needs at least 3g scratch device space, check for it
before starting the test case.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/177 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/btrfs/177 b/tests/btrfs/177
index 2b2c2fcc2198..a627c2ab1666 100755
--- a/tests/btrfs/177
+++ b/tests/btrfs/177
@@ -34,6 +34,11 @@ _require_scratch_swapfile
 
 swapfile="$SCRATCH_MNT/swap"
 
+minsize=$((3 * 1024 * 1024 * 1024))
+devsize=$(blockdev --getsize64 $SCRATCH_DEV)
+[ "$devsize" -lt "$minsize" ] && \
+	_notrun "Scratch device $SCRATCH_DEV $devsize must be at least $minsize"
+
 # First, create a 1GB filesystem and fill it up.
 _scratch_mkfs_sized $((1024 * 1024 * 1024)) >> $seqres.full 2>&1
 _scratch_mount
-- 
2.18.1

