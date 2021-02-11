Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88533184DA
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Feb 2021 06:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhBKF0g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Feb 2021 00:26:36 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46026 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhBKF0V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Feb 2021 00:26:21 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11B5Oqwd153273;
        Thu, 11 Feb 2021 05:25:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=tkrtsuB4nOosd/iSYfgnHW5+MJDa9OZsW0EIBC/MpgQ=;
 b=yn0rr6PHa9KFn+hga2KPuub2jtD82YW267dtXFdmTa1bVutmvdCxHqohXh1okkShExlf
 sO1xfhkWWLBK0kJ0iOzludE1BXMV40B4UxGJNj8M7167QFRdfqKpVCTLJrl90tACUx1D
 ZByjyunLD4iK5OE1HSczJbjEQNvPBitgT1y68gj8Kw/gtAyS99NZtFe0Ji7ZcImuA6sz
 OoczdMNNvxjyvqWAPulGe8YWwmKRcINZ+z+VAcha7Q5mUdBaOiFVi6fHHif78qe4c9Br
 sT1ZOl8pJCfIKZsu1JlgimdgLDMxLGijgmGEP+SOYg/nDJD7ml6GooArv4LzbFrOH+du qw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 36mv9dr925-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 05:25:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11B5P6wq176909;
        Thu, 11 Feb 2021 05:25:35 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 36j51yg4hk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 05:25:35 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11B5PYvH015018;
        Thu, 11 Feb 2021 05:25:35 GMT
Received: from ca-dev104.us.oracle.com (/10.129.135.33)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Feb 2021 21:25:34 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com
Subject: [PATCH 0/5] cleanups btrfs_extent_readonly() and scrub, part1
Date:   Wed, 10 Feb 2021 21:25:14 -0800
Message-Id: <cover.1613019838.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102110045
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 mlxscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102110045
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patchset makes btrfs_extent_readonly() static and changes the return
type to bool.
And drops few unwanted function declarations in the scrub.c.

Thanks. Anand

Anand Jain (5):
  btrfs: make btrfs_extent_readonly() static
  btrfs: btrfs_extent_readonly() change return type to bool
  btrfs: scrub drop few function declarations
  btrfs: scrub_checksum_tree_block() drop its function declaration
  btrfs: scrub_checksum_data() drop its function declaration

 fs/btrfs/ctree.h       |   1 -
 fs/btrfs/extent-tree.c |  13 ---
 fs/btrfs/inode.c       |  13 +++
 fs/btrfs/scrub.c       | 202 ++++++++++++++++++++---------------------
 4 files changed, 109 insertions(+), 120 deletions(-)

-- 
2.27.0

