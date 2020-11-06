Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C411A2A90F9
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 09:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgKFIGy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 03:06:54 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42862 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgKFIGy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Nov 2020 03:06:54 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A6851hk169083
        for <linux-btrfs@vger.kernel.org>; Fri, 6 Nov 2020 08:06:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=vSamvILVPcZcPLOsXtCSGKUyRKdN455oi5335FqB/UU=;
 b=GNO4Yw+M4IuVoqX38QVqbCqWaxc+ygekVpcJyEHiJpjq12cBSwVjMH8IReDhcwmkjLZ/
 /dc/kb5FWmasUNhaWWm83pf5u7IELLd3JRKqHOAZrydujC02Aw3Rr+HmF2mrv1cnvfMm
 yack6kTjsnpS/KZNgVQnhEdMeZWgB2Muo3pDCY7n5+4k0RbdZpEY72TupAZuu7T5nLyC
 ogm7hCs67RaOp7wZRhWWdEuVxRKb7dI2a/qefXQK46rB2X4/t7qT//mW7T7XYCh7qtQj
 wwzC/RnhjqVYxMsF11ilHBbML630yWoGCUkZ+YQfYcJAtCKer41PiO/beJgPkXr7vr0L 7w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 34hhw2yqsb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Nov 2020 08:06:53 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A684xTu163486
        for <linux-btrfs@vger.kernel.org>; Fri, 6 Nov 2020 08:06:52 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 34jf4dkj9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Nov 2020 08:06:52 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A686qDE008173
        for <linux-btrfs@vger.kernel.org>; Fri, 6 Nov 2020 08:06:52 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Nov 2020 00:06:51 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 0/1] cleanup btrfs_free_extra_devids() drop arg step
Date:   Fri,  6 Nov 2020 16:06:32 +0800
Message-Id: <cover.1604649817.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9796 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=3 mlxscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=897 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011060057
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9796 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=3 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=909 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011060057
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Requires on:
 btrfs: dev-replace: fail mount if we don't have replace item with target device
in the mailing list.

Anand Jain (1):
  btrfs: cleanup btrfs_free_extra_devids() drop arg step

 fs/btrfs/disk-io.c | 12 ++++++------
 fs/btrfs/volumes.c |  8 ++++----
 fs/btrfs/volumes.h |  2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.25.1

