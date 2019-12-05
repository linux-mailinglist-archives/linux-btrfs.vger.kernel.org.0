Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 501C011400E
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 12:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbfLEL1P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 06:27:15 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:42868 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbfLEL1P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Dec 2019 06:27:15 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB5BJ5q2077879
        for <linux-btrfs@vger.kernel.org>; Thu, 5 Dec 2019 11:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=pZDaJQP+QdvFQ8XhzG4QApogf5wLcbF9Bj3CQA8XlNM=;
 b=YwEWLj2UCaX68xIPm3P9z8QZzR8JM1rXzneZLxT14t+VwaECKfWVNUAGoH/iCg2zP5HF
 B19Wmtuws9REVPCt+wDnKWSw7Z7HJND2eh7Tom5A5FBhh/kFvCBGRp6Z+noHROHCeXIk
 Ko9KCpE1HAr2RTBgdJ+koI5WFtauWmcFJZn8fEB0oVNvjtUJl9FuZ4PudkrdkWnGR1Lh
 ++wETWe54I2jEUWlOMZ2iGiGfxrNmWpCQc5078sX/G+v7dGLCop03olJjUGSKU1vPM/b
 JsFe3WJyqMz081r6SscO170G88+11n6DKNqvt3lJqmYZj+IiEVX7YoP6qQMaZM2ozs2i Fw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2wkfuumnv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Dec 2019 11:27:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB5BNnKC088859
        for <linux-btrfs@vger.kernel.org>; Thu, 5 Dec 2019 11:27:13 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2wptpu94r3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Dec 2019 11:27:12 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB5BRBAV022610
        for <linux-btrfs@vger.kernel.org>; Thu, 5 Dec 2019 11:27:12 GMT
Received: from localhost.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Dec 2019 03:27:11 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs, sysfs cleanup and add dev_state
Date:   Thu,  5 Dec 2019 19:27:02 +0800
Message-Id: <20191205112706.8125-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=682
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912050094
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=764 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912050094
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Patch 1/4 is a cleanup patch.
Patch 2/4 adds the kobject devinfo which is a preparatory to patch 4/4.
Patch 3/4 was sent before, no functional changes, change log is updated.
Patch 4/4 creates the attribute dev_state.

Anand Jain (4):
  btrfs: sysfs, use btrfs_sysfs_remove_fsid in fail return in add_fsid
  btrfs: sysfs, add UUID/devinfo kobject
  btrfs: sysfs, rename device_link add,remove functions
  btrfs: sysfs, add devid/dev_state kobject and attribute

 fs/btrfs/dev-replace.c |   4 +-
 fs/btrfs/sysfs.c       | 130 +++++++++++++++++++++++++++++++----------
 fs/btrfs/sysfs.h       |   4 +-
 fs/btrfs/volumes.c     |   8 +--
 fs/btrfs/volumes.h     |   3 +
 5 files changed, 111 insertions(+), 38 deletions(-)

-- 
2.23.0

