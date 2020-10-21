Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9500F29472F
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 06:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411919AbgJUESV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 00:18:21 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:32884 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411917AbgJUESU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 00:18:20 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09L4EuMT003688
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 04:18:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=FMFSQjT1EBj+B4hA2UlDXKsYfxTimQO/jk0Y3zMGZvE=;
 b=DhMFf9XboDl0z13Ao2KQ1H0gW7VpWlLrsVSrjmox3smoydQ1M5X+RE66WtKC0G5XyFsr
 Qh7DokpJP7o577i42rMHUjx8uDrdljAuaG/nO22Z5qtw1AShHkxTS04lOr4+ZRV263aw
 o0+83IuSsffwiryI9MpkJYlsfolwME4PaMm12rFxzlxU/w4rPELIMA/8QI95P2QsO1Xt
 ZZw9km9rpT2yMio1KtUjS2T4XcP2E14hUg8sj6MIVE4smVltLX3diFVqWmFGmci1YJBP
 pFuuDpHv9p7gHqhqVAJZNpGbiLToXu8Sr3gj9jnNFdSWpTKfD1QEld95OoBd0De9QQ6X PQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 347p4axfeh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 04:18:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09L49tMK141834
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 04:16:19 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 348acrk47s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 04:16:18 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09L4GIvf017580
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 04:16:18 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 20 Oct 2020 21:16:17 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RESEND 0/2] fix verify_one_dev_extent and btrfs_find_device
Date:   Wed, 21 Oct 2020 12:16:07 +0800
Message-Id: <cover.1600940809.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9780 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 malwarescore=0 suspectscore=1 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010210033
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9780 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010210033
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_find_device()'s last arg %seed is unused, which the commit
343694eee8d8 (btrfs: switch seed device to list api) ignored purposely
or missed.

But there isn't any regression due to that. And this series makes
it official that btrfs_find_device() doesn't need the last arg.

To achieve that patch 1/2 critically reviews the need for the check
disk_total_bytes == 0 in the function verify_one_dev_extent() and finds
that, the condition is never met and so deletes the same. Which also
drops one of the parents of btrfs_find_device() with the last arg false.

So only device_list_add() is using btrfs_find_device() with the last arg as
false, which the patch 2/2 finds is not required as well. So
this patch drops the last arg in btrfs_find_device() altogether.

Anand Jain (2):
  btrfs: drop never met condition of disk_total_bytes == 0
  btrfs: fix btrfs_find_device unused arg seed

 fs/btrfs/dev-replace.c |  4 ++--
 fs/btrfs/ioctl.c       |  4 ++--
 fs/btrfs/scrub.c       |  4 ++--
 fs/btrfs/volumes.c     | 37 ++++++++++---------------------------
 fs/btrfs/volumes.h     |  2 +-
 5 files changed, 17 insertions(+), 34 deletions(-)

-- 
2.25.1

