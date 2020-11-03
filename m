Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073762A3C31
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 06:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgKCFt5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 00:49:57 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:44658 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgKCFt5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Nov 2020 00:49:57 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A35n4Zo063414;
        Tue, 3 Nov 2020 05:49:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=WyKj5IGi3XqHukJLxuoQ557f9yPesujedlIGDFJeY+0=;
 b=yDlMU3Y9lppYXMrhLaojW9ZV+wUHDVtlLF7/0wZ1avDm40/SalbSkgjVifKDRM6KhIvv
 QRaoEyQ21SXqtPbsCKCCekv6n+IbR9KeD92YP8cc8VeyrUFE9Ovk2POvne7NW2Jmngdq
 j/uV923cjvtw83e7h9bVHnxIeV97V3Ok5Lv68w+d2rC/VYTGt7A1ouJ2xszZlcUffFEA
 8XWM0Fx0ZgOSPATUDsmA7xTYmO/jF+T43GjhUHwrB9dZyGxQENtBWI78RbobMC1yEy5a
 M3LQYMB6QVqdlJCB5DUkBauGqv3v3cVu0Gmez3mKTl5insAWkKifSMj3JUrcrRzR5Yzz FQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 34hhw2fcd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 03 Nov 2020 05:49:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A35eQrH011731;
        Tue, 3 Nov 2020 05:49:52 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 34hw0gd2aw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Nov 2020 05:49:52 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A35nqrA005873;
        Tue, 3 Nov 2020 05:49:52 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Nov 2020 21:49:51 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH RESEND v2 0/3] cleanup btrfs_find_device and fix sysbot warning
Date:   Tue,  3 Nov 2020 13:49:41 +0800
Message-Id: <cover.1604372688.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9793 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 bulkscore=0
 mlxscore=0 suspectscore=1 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011030042
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9793 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=1 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011030043
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Patch 1 and 2 are cleanups. They were sent before with the cover-letter
as below.
 [PATCH RESEND 0/2] fix verify_one_dev_extent and btrfs_find_device

Patch 3 is a fix for the Warning reported by sysbot. This also was sent
before with the cover-letter titled as below.
  [PATCH 0/1] handle attacking device with devid=0

To avoid conflict fixes, please apply these patches in the order it is
sent here. But the sets are not related.

Both of these patchsets are at v2 at the latest. So I am marking all of
them as v2. The individual changes are in the patches.

Also earlier resend patches were threaded under its previous cover-letter
(though --in-reply-to was not used to generate/send those patches). So I am
trying to resend these patches again, hopefully, they are not threaded to
the older series again.

Anand Jain (3):
  btrfs: drop never met condition of disk_total_bytes == 0
  btrfs: fix btrfs_find_device unused arg seed
  btrfs: fix devid 0 without a replace item by failing the mount

 fs/btrfs/dev-replace.c | 30 ++++++++++++++---
 fs/btrfs/ioctl.c       |  4 +--
 fs/btrfs/scrub.c       |  4 +--
 fs/btrfs/volumes.c     | 73 ++++++++++++++++--------------------------
 fs/btrfs/volumes.h     |  2 +-
 5 files changed, 58 insertions(+), 55 deletions(-)

-- 
2.25.1

