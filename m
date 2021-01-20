Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908092FD260
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 15:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388471AbhATOKJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 09:10:09 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:37912 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733174AbhATMfm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 07:35:42 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10KCEvn2066830;
        Wed, 20 Jan 2021 12:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=DDc91NVavG0GYhKnQzZHffAEfc5RZu6B1kFYbN+NG9Y=;
 b=avzC+VRP6QH4/KfkK7gwxPSUqs4DVofOtMJX+4Sg226L9lvx3YmFqpTrokNS38Mwk7QQ
 lLb9SCfZjB1p4AyJ2ks99ez2GA1WU01Iie1UWTVNvBzKCXwkJxJ5/tnghBr0BsH9TuS7
 QLbzOD+5cISX7nFzS55/KqGPz2lMrHccSOWHGZl5RsxwxTIbnHEg09oZpHKaGgsq4Dpb
 6HB2WkGdx4EnlznbMfzh1K74DLKgSNk65I0M7HYKeeWe6VtxAEC58gQRAHX8QKd4yt74
 uY5v43gQdslgo4DY3m++WvmYxRiKl2VHtu5Kl5aSFlIQkE1EsLKMrCtR+xBe6Z4Mu41d Vw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 3668qra868-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 12:34:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10KCGe2E004302;
        Wed, 20 Jan 2021 12:34:48 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 3668qw4a04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 12:34:48 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10KCYku4006078;
        Wed, 20 Jan 2021 12:34:47 GMT
Received: from localhost.localdomain (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Jan 2021 04:34:46 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com
Subject: [PATCH v4 0/3, full-cover-letter] btrfs: read_policy types latency, device and round-robin
Date:   Wed, 20 Jan 2021 20:34:37 +0800
Message-Id: <cover.1611114341.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611114341.git.anand.jain@oracle.com>
References: <cover.1611114341.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101200073
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101200073
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[Only some parts of the cover-letter went through, tying again.].

v4:
Add rb from Josef in patch 1 and 3.
In patch 1/3, use fs_info instead of device->fs_devices->fs_info.
Drop round-robin policy because my workload (fio random) shows no performance
 gains due to fewer merges at the block layer.

v3:
The block layer commit 0d02129e76ed (block: merge struct block_device and
struct hd_struct) has changed the first argument in the function
part_stat_read_all() in 5.11-rc1. So trickle down its changes in the patch 1/4.

v2:
Fixes as per review comments, as in the individual patches.

rfc->v1:
Drop the tracing patch.
Drop the factor associated with the inflight commands (because there
were too many unnecessary switches).
Few C styles fix.

-----

This patchset adds read policy types latency, device, and round-robin, for the
mirrored raid profiles such as raid1, raid1c3, raid1c4, and raid10. The default
read policy remains as PID, as of now.

Read policy types:
Latency:

Latency policy routes the read IO based on the historical average
wait time experienced by the read IOs on the individual device.

Device:

With the device policy along with the read_preferred flag, you can
set the device for reading manually. Useful to test mirrors in a
deterministic way and helps advance system administrations.

Round-robin (RFC patch):

Alternates striped device in a round-robin loop for reading. To achieve
this first we put the stripes in an array, sort it by devid and pick the
next device.

Test scripts:
=============

I have included a few scripts which were useful for testing.

-------------------8<--------------------------------
Set latency policy on the btrfs mounted at /mnt

Usage example:
  $ readpolicyset /mnt latency

Anand Jain (3):
  btrfs: add read_policy latency
  btrfs: introduce new device-state read_preferred
  btrfs: introduce new read_policy device

 fs/btrfs/sysfs.c   | 57 ++++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/volumes.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h |  5 ++++
 3 files changed, 121 insertions(+), 1 deletion(-)

-- 
2.28.0

