Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDC9615A4C0
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 10:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgBLJ2X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 04:28:23 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:47612 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728696AbgBLJ2X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 04:28:23 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01C9N9b0148625
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2020 09:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2020-01-29;
 bh=Up1Vrq8FZuevT2I3WX9oAkNrLEk8RRupaDQ7M3pS0JI=;
 b=FEocpM4kc7I9YgPwmxmEuH8rCQ7qDCJg/lE3vrFc6DQ+FgT2r1QHXyglQGrZifhzVDGI
 LB5iieWtE8uY2NYSdnF/ijadYJK8LXjodfp7fSj33j1IW3eg1bFPVb0qO9/HOTw3yURf
 s2xDZoSsfoQN6RBgnhFRNt85eZ49+XVAVx5xnEIbf1f/SuaADA93b0tr6YWL+/KTumZ4
 5HiGhXGO7rop7KoYmUzmpc9h3jdoAE3wtOqj6uWlrCAJlQ83nJDOW28GRI8hac0PT/gt
 pQnvxqFSgT92Qw/L4MNiHq2AoYnSJIg6D8J4efzePgui86aLR4hAJIMkzcO4QCoBPSyV +w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2y2p3sgt6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2020 09:28:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01C9N3gs032338
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2020 09:28:22 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2y26fjw0jf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2020 09:28:21 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01C9SLsT027683
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2020 09:28:21 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Feb 2020 01:28:20 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: sysfs, add devinfo, fix devid and cleanups
Date:   Wed, 12 Feb 2020 17:28:09 +0800
Message-Id: <1581499693-22407-1-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9528 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=1
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=721 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002120075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9528 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 suspectscore=1 mlxlogscore=800 priorityscore=1501 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002120075
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here, first patch creates UUID/devinfo. 2nd relocates devid kobject to
UUID/devinfo.

Patches 3 and 4 are cleanups.

Anand Jain (4):
  btrfs: sysfs, add UUID/devinfo kobject
  btrfs: sysfs, move dev_state kobject under UUID/devinfo
  btrfs: sysfs, use btrfs_sysfs_remove_fsid in fail return in add_fsid
  btrfs: sysfs, rename device_link add,remove functions

 fs/btrfs/dev-replace.c |  4 ++--
 fs/btrfs/sysfs.c       | 31 +++++++++++++++++++++++--------
 fs/btrfs/sysfs.h       |  4 ++--
 fs/btrfs/volumes.c     |  8 ++++----
 fs/btrfs/volumes.h     |  1 +
 5 files changed, 32 insertions(+), 16 deletions(-)

-- 
1.8.3.1

