Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6F09CB57C
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2019 09:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387677AbfJDHwT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Oct 2019 03:52:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35796 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387626AbfJDHwT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Oct 2019 03:52:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x947nEQv104051
        for <linux-btrfs@vger.kernel.org>; Fri, 4 Oct 2019 07:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2019-08-05;
 bh=b/WW8yY5MW0Rjl1pMcdzxDGwkC13JxLzr/KH2cnctN8=;
 b=Nip1ah09dyQLLCbQ/9EHa4ASvyxtAix5P7tbdBcUXfudbbccmhcSJuk07pCku4OmK6vX
 FePVKUL8hrhrpw48WpZQfr3VUX1+hJQS3FywlZUSpk6qzMJa+IcV6RxsfRqc9d/VzAR+
 F375m4ggvGDT7J8mj1Pb1sz2vo+xPnrI02CohtDrzTeEHWfKFCEprJTlfusm6ac2Zm2K
 voaSrPMuoWFlIs5Jb+Iaz8DWdi+eHrPi1MJPdYvCZwQii3tlUwbROc2c6WZ2fnYtsyrp
 jleZrIIaTSECgonXvdx4sarxBz6lDysQjs/rOLQJHzAwy3sdKzK/LMifJmqN7HRiPvYz fA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2va05s9gh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Oct 2019 07:52:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x947mBpY090637
        for <linux-btrfs@vger.kernel.org>; Fri, 4 Oct 2019 07:50:17 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2vdt3p6qw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Oct 2019 07:50:17 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x947oGKV001609
        for <linux-btrfs@vger.kernel.org>; Fri, 4 Oct 2019 07:50:16 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Oct 2019 00:50:15 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: fix issues due to alien device
Date:   Fri,  4 Oct 2019 15:49:59 +0800
Message-Id: <1570175403-4073-1-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9399 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=696
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910040072
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9399 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=783 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910040072
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Alien device is a device in fs_devices list having a different fsid than
the expected fsid. This patch set fixes issues found due to the same.

Patch1: is a cleanup patch, not related.
Patch2: fixes the missing device not missing in the userland, by
        hardening the function btrfs_open_one_device().
Patch3: fixes failing to mount a degraded RAID1 (but it can apply
        to RAID5/6/10 as well), by hardening the function
	btrfs_free_extra_devids().
Patch4: eliminates the source of the alien device in the fs_devices.

Anand Jain (4):
  btrfs: drop useless goto in open_fs_devices
  btrfs: delete identified alien device in open_fs_devices
  btrfs: include non-missing as a qualifier for the latest_bdev
  btrfs: free alien device due to device add

 fs/btrfs/volumes.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

-- 
1.8.3.1

