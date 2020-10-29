Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7341C29F8B3
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 23:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgJ2WyO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 18:54:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59190 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJ2WyO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 18:54:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TMnOoj006353;
        Thu, 29 Oct 2020 22:54:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=4FN807f+KhWQeX2f7buy4So9Kb4av58UNKnjkrb5Qws=;
 b=SvvRDahS2cLIBQ/j6yFZKA0btn09SX236R1J0NirhzdCLLTCx9cAHsCyrhSVl0DPb3J9
 V4FplN4FFTm5EpOj3DP9VhIDadnPapOKKJGdEqcpcKZIWhQckYcNt7QKoPF/kxxAPhwZ
 pcrytpRy85Q0qcoTaJP0h+LD3aLiF6GIeAtQI8mJz0RTS4aOE6rOeVUtuc6mgBgKSFZU
 oaqDm3JJf5c/ngNCAqIgun0h1ZsOVauMDI3cUUp2HvqAI35BXOTnj1kvZTjXLBaCeTuq
 nfCb/7pvd+dpRVSd+rje0P8zR5jjLH2RqIOj+CuUJKmUfUj4ahUd0cA9Ikre9t6OXGWO zQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 34dgm4d0fc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Oct 2020 22:54:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TMoPIj135322;
        Thu, 29 Oct 2020 22:54:09 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 34cx1tsbhx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Oct 2020 22:54:09 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09TMs87P014775;
        Thu, 29 Oct 2020 22:54:08 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Oct 2020 15:54:08 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 0/1] handle attacking device with devid=0
Date:   Fri, 30 Oct 2020 06:53:55 +0800
Message-Id: <cover.1604009248.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=3 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 suspectscore=3 clxscore=1015 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290157
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch started as a fix to the Warning reported by the sysbot. 
More details about the warning in the changelog itself. But there
is a more fundamental question on how we would want to handle the
mount if we find an extra device during the mount.   

There are two ways to handle 

1. Just free the attacking device and keep them out of the mounted fs,
and let the mount be successful. Originally we have been doing something
like this. We free the extra devices in __btrfs_free_extra_devids()
including the corrupted/attacking devid=0.

2. Fail the mount so that the user has a chance to review.

Both of these approaches which shall fix the warning reported by sysbot
those fixes are in the patch 1 and 2. So either 1 or 2 must be integrated.
They can be found in the ML.

1.
 [patch] btrfs: fix rw_devices count in __btrfs_free_extra_devids
2.
 [patch v2] btrfs: fix devid 0 without a replace item by failing the mount
 (This patch is threaded with this cover-letter).

If we follow the second method for most of the other similar attacks, I
think at some point the __btrfs_free_extra_devids() shall be redundant.

Thanks.

Anand Jain (1):
  btrfs: fix devid 0 without a replace item by failing the mount

 fs/btrfs/dev-replace.c | 26 ++++++++++++++++++++++++--
 fs/btrfs/volumes.c     | 26 +++++++-------------------
 2 files changed, 31 insertions(+), 21 deletions(-)


base-commit: 00b19effbd917546c9f7bb3adff425c05613675e
prerequisite-patch-id: 0d3416ab45d924135a9095c3d9c68646f7c5e476
prerequisite-patch-id: 51a2e9b4b78bf808279307d03436a33063d42130
-- 
2.25.1

