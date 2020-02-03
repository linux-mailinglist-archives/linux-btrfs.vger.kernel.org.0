Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C54A1504C7
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 12:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbgBCLAX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 06:00:23 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50906 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgBCLAX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 06:00:23 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 013Arhku017874;
        Mon, 3 Feb 2020 11:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=MF6d6P2nSNMs8IlYPh2VL1fKPUs/3gIwoxdPWeG4JZo=;
 b=aDGxV4hSLFA9arrKrkwOj4Ow1CdgEjH/nil8S1mxHVSe8M9USHJAmFZufmPKAsCmmUvw
 fq32cpNmlO4iaKurqPVDWZjon7OUkXKsDyT3cSybgBRQO0ET2gryllyw1h8xqzRPgefS
 Zhn70DtkU/nYU03UOY1ZlzPZceFGT+8LtCfccGj7SXbJTg3WnjjZexQsvd7EVPWaZyi1
 4b1Al//42+buETY2jJx48IIein0q43q1ZuWvjZ3AKQV1AM8WHQNVvpNcRIvZuRpS1lXo
 RKpyARBbPGYE1lkmpKPA5PW6BtrvBjUcJnDaS+UucsbsZNGI4iYdlO79MkbAvmHZEVR/ LQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2xw0rty2as-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Feb 2020 11:00:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 013ArYkQ158152;
        Mon, 3 Feb 2020 11:00:18 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2xwjv02xyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Feb 2020 11:00:18 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 013B0Hfm006714;
        Mon, 3 Feb 2020 11:00:17 GMT
Received: from localhost.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Feb 2020 03:00:17 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH 0/4 RESEND 1-3/4 v5 4/4] btrfs, sysfs cleanup and add dev_state
Date:   Mon,  3 Feb 2020 19:00:08 +0800
Message-Id: <20200203110012.5954-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9519 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002030083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9519 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002030083
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Resend:
  Patch 4/4 is already integrated without the cleanup and preparatory
  patches (1,2,3)/4. So I am resending those 3 patches. And the changes
  in patch 4/4 as in misc-next is imported into patch v5 4/4 here. Patch
  4/4 has the details of the changes.

Patch 1/4 is a cleanup patch.
Patch 2/4 adds the kobject devinfo which is a preparatory to patch 4/4.
Patch 3/4 was sent before, no functional changes, change log is updated.
Patch 4/4 creates the attribute dev_state.

Anand Jain (4):
  btrfs: sysfs, use btrfs_sysfs_remove_fsid in fail return in add_fsid
  btrfs: sysfs, add UUID/devinfo kobject
  btrfs: sysfs, rename device_link add,remove functions
  btrfs: sysfs, add devid/dev_state kobject and device attribute

 fs/btrfs/dev-replace.c |   4 +-
 fs/btrfs/sysfs.c       | 156 +++++++++++++++++++++++++++++++++++++++----------
 fs/btrfs/sysfs.h       |   4 +-
 fs/btrfs/volumes.c     |   8 +--
 fs/btrfs/volumes.h     |   3 +
 5 files changed, 137 insertions(+), 38 deletions(-)

-- 
1.8.3.1

