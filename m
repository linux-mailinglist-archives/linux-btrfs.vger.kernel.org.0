Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7415D47725A
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Dec 2021 13:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237071AbhLPM5V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Dec 2021 07:57:21 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:17472 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237069AbhLPM5U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Dec 2021 07:57:20 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BGCX5CA000422;
        Thu, 16 Dec 2021 12:57:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=jEsEFEw9l1np6ispEoGgySgHzt2k/1uN/MjwzB5lHnw=;
 b=poc39XBirCzdU2v9NyD3hU6iTODPtWvXYfbhPK5/V7eXwdDqggf6jwGT/JdfcrobxNyq
 X+GFxllfrTQSUe0EC6CZR9SbwZSZHPPsCDDRhm8ZMd/as5Sks8EkqpYpkykLGb4bJhyW
 cUJVIsDFwhC03ZMDdzTLuhz6vrL4H5surqqx52+NiBFiywLMziUSZD8NXjqiM2MPWxhK
 gpV0ewg3pa94WsEdwAZykqpsUgXBlOyG58ArWPMHpdxVHJUrCL1NDCsRVYqu40hUKNC7
 M63acdBfIrgWSVYVyqykKA5HgrZ1Ys76TOAB33iWnGOgrte/ZSVAU5L3+SRDncdMAMIp FQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cyknrjm1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 12:57:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BGCoB3G133884;
        Thu, 16 Dec 2021 12:57:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by aserp3030.oracle.com with ESMTP id 3cyju9u7hs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 12:57:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRbLcbrPJW9/mxWbmYT22ae3h4RCYgRrJtKouv5xpmlWm+OUKorgrbHp16hfJ9U4/IbhFjA56lokxzGaY8cnoyTsqZ9itOnoJzLxv2iP7O1hkrRf/HNduqINVaRcgCvQllbuoTfpDBdgeAtWEr9WL1BpAW+L5eCiOWWKLoEwR8hOURLbP4O2xLeJ7vFUmhICCHC5EOeiG9+bnve7NAS0j4lcvvMQc42Q7W2IpnmKcDrbmCAatY8rN2NjodgO5xRlYUp0uF+WjJVgrwquf6mtSZrRLQo3DHkAZa/vrInPaE4Tl1KmmMBHHEK8sQqI5U8r2Ln5aQ6BQb0AZfQx/aNFSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEsEFEw9l1np6ispEoGgySgHzt2k/1uN/MjwzB5lHnw=;
 b=i6Y9W5ug45l/jrdMvZxYQsg6bhDe6/n7l0TRyOA2taj/JQt+v7tepKKiZbVykuMYK3cp1zakH9JUvhwZlGKrxDdIDKoFxKNYpe/fdzekFlidU9QoXMmaF22Z5wTkatdiwYzztVy6MvpP10vcAqVJ2IXANF5oGjUAvgs27QR1ALx07uomjI7v44TC27G9pCJ6oyTIMotUWRsonfzSyAk/AvprsC3thoJTb82+8AFs1opQhU7FhE4guqBHOZbdC+6PBp5JY7YgsjJC8x2UVkcZkGGgkEeTNpsYTR8GuXisVQDKCNswGJkwuV78fdSqSgvo5VexpgO1bsg8HKE2K8zKaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEsEFEw9l1np6ispEoGgySgHzt2k/1uN/MjwzB5lHnw=;
 b=wRoRF10tr3Vd3Z3d+ebYRZtS+Ffj4Pmsm7oW0aj7E5WvJarKGoSr7uFnadLU/AnYif1hYuLFHwf5jFjMB4cKCIODRkhNkqnyMutitt3+bGpcIn8GG0jLyhZuXHwFGrX81Ikr2gkfKkZ6lor89S0uLV51hhHP2xlqWNk/xM+AQXA=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB3425.namprd10.prod.outlook.com (2603:10b6:208:33::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Thu, 16 Dec
 2021 12:57:17 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4778.018; Thu, 16 Dec 2021
 12:57:17 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH stable-5.15.y 3/4] btrfs: update latest_dev when we create a sprout device
Date:   Thu, 16 Dec 2021 20:56:46 +0800
Message-Id: <3cc9f5d26cf29f91b3a87df814ff84420e31080a.1639658429.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639658429.git.anand.jain@oracle.com>
References: <cover.1639658429.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56ca2ae7-4f32-4353-28b8-08d9c09396f1
X-MS-TrafficTypeDiagnostic: BL0PR10MB3425:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB34252DC780B6F2D84F9A83BDE5779@BL0PR10MB3425.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tVXQ1JxIyZOdP/zUPOpx6Iwmplw7MtzP16Iz81IdMaKPb3wN/+9Vwxua5F48j0LJOG6OpqgA55npDOC/9Q4gtoiNw0SJLsXg+lpsjH8DuIwXPBTJyrtoVQGFEoBYMMfmVbXuUerUFBrDY9Vj6FHCrF6ppET5T+JcPSwzl24Wi16owroI/C5xzH4qAGnwG6dpLoMJ9toilTrVssBjywvSBsIzYCuq1mbcGLgSkYglwpq3fb4oJGI8t92Pj27aN4PAybLGVdNgbHWxVGr5C1C1d2F3noer7rjZbNPJTM0uAAzW3hXtrBfF/iQyzZZhfYDiT2/Qlx9/Zp2yh/+HyhpwRMoJXS42ik9vULgrdYiuQrhxiPKO8gHD2g2JGIkLkQlSW9JBEsLkSheITe2ClzrhT64t6nQwFbapZCdF1dyHYAaG8PfMxX/lFQt9Ts9/JKjf0kxQ0O75RYPpyWHRwDpBtyOxcAqRf0Al0i+JrI66tq+Eb8C1fH5NpmMo1GjEFEbldwhRTrNTqXsRwDmW+8ubFcAcYZY1KkPwAOZbU6VsQpU7rdhqbozghACuT3g0s6tFlq6kbkVV2dHd5I2sLb3k+Iky6XRdO37xV31+DMB0DMqCLMH65lj2A6v1jehvRGQGM8lVQGNuSOliA/SecWvF9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(66556008)(316002)(5660300002)(186003)(6916009)(6486002)(6666004)(66476007)(508600001)(4326008)(6506007)(86362001)(15650500001)(36756003)(6512007)(2906002)(2616005)(8936002)(83380400001)(38100700002)(44832011)(8676002)(450100002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4X2q43muviR8tF9HGeJczXTvtedBlrP4cvgQxhxOxjpkMCbs45YDly2qbNE4?=
 =?us-ascii?Q?i5lzcK8B8QcnEXHro9TiHzKpRxBUdHTbtiuchWdQ1x2tIWSLJ7syRFfgl43B?=
 =?us-ascii?Q?K08XxClXFNVR+N+2/cUCyEo2+LHCQf3W7LGTAzH0Ltynkcn1TOJaCGnT6WVY?=
 =?us-ascii?Q?JfSRW/hf7fEkM/UNbG8V2QE+tkV7LceqK0XHNGSpewUJeY0R2LYp9Wj1bn5B?=
 =?us-ascii?Q?gV6yrCfPVXUnVK12UD/WqU+iJhYJmOhAokvEF9VIW8Z95+yHcSf+O78xgQlp?=
 =?us-ascii?Q?4wWWY9DdfpIa6SaxcaLRc+r1XbPTyLmGAtER87JACnRFEq2RXikucMyfcuJE?=
 =?us-ascii?Q?vk5o9R9bS9VRJ9cyM0sPstxzHNPDBKRy5yQGmeYKSWS0ZgI8YUUaEWcha9dH?=
 =?us-ascii?Q?yiIopd9GQiJj3k3NFjM6XvJt8+lTCBsMxKxGrmTLjmL0527nQrOGN0xZMMPl?=
 =?us-ascii?Q?C69snA1lw9R465v6l7EaL3beqBpkuEcRV29bc5LQP4ZzGNQG4UvLoRHWDrO9?=
 =?us-ascii?Q?Zm2t/god2SUwr8t4eDB5KKQY6VrYShxOT/23OrK8vZO31WI52pVSevUZlnVa?=
 =?us-ascii?Q?3SQv3FN73LW8qYEIVlOIg7xnM2ZxetODPZaZneJujBQ3xa+iA+UsHmwJnt1+?=
 =?us-ascii?Q?XQLZA37eKGCo9PQp2y+WYxNvrjW4t6PuuP08ZtrrtBAWXzPLVDgV0Hyra953?=
 =?us-ascii?Q?lGyJtPthJ0yFhnbiOsblICGXgJ26l328xGX0uYlfGBpqVq93Z71UOJH4K4pm?=
 =?us-ascii?Q?F0gi6YaDlcqgdcMhf6VG3YpocVcPZYIZ8Do4ZBoz2vKTy/WsbCKSXmQqBKAq?=
 =?us-ascii?Q?weFqEYssoKfQCazMvap32O2Wjt+INv35XrtYcI1e8ayOI7ZgM+0WSwCPBuO3?=
 =?us-ascii?Q?v/Hs106+LZyC9F4KlfY4n2RY6UVD+hfyAmQNUFVSyJ6jy2hsEYJed82q1ZT4?=
 =?us-ascii?Q?/x/Su0YneGqxc8rNq6G9yOgjFHgnQAfQBMAG/5HiZGg52g5VUJffJiLL660P?=
 =?us-ascii?Q?QnFtX/O0cUDQNVV8acZghCFi3Sjsmuf39SerPf+r9lzbI6ad1Ywx1Ejt3kYb?=
 =?us-ascii?Q?7DvfMy1szzixwNmx1pLbaMEObIioJmct059jbofjtyXJ0hi47awufffMDvSV?=
 =?us-ascii?Q?pZW6eBryNzB1BzjYkdebEOWXhKFRU+//sv2/+6vRY0qvik+mSVkb4kS+qwhJ?=
 =?us-ascii?Q?rLNk8wdF7ohGidZzo+UZLfJl3Z/dgvQjaYWSiNHgThhe78I1eyH3fzomkSYh?=
 =?us-ascii?Q?f0uhWRAY2dvnbiID9YBs8fRoAHQ36xNWWCy6JGdvjp5lZEbzQlVpR/GAy5Fn?=
 =?us-ascii?Q?ukeqsDkI1T61ATG3Uykxpf0ChnPm7WPgiDNKLCJqAkKCL32Ov5d7pkQdrw3B?=
 =?us-ascii?Q?SHQ/XV5rnODaa4v+qe1E+91oKpxW5WtSOjnBuexO+rleWZTXt7Iw1EuiE/PP?=
 =?us-ascii?Q?iYA+rqYgMQqUWlar8UihoPi232fmp238Rr7ZH26qF/gEr8cVSRMd3xKjMmaJ?=
 =?us-ascii?Q?JRIB7Xxh5ILKh2dZcwUPp1WUlc4mirJ7uYdaVl4Y6mgI+SVsCFNTEsz6Ld0h?=
 =?us-ascii?Q?OnyQd2ziroNhyptkUFvd/87iIs1Y9GXMAqoWouBL20ZVSoge8PySJUBGCwCW?=
 =?us-ascii?Q?eSX746zaSCkZy1iPcPakRPiJ4M8VXlZ0xCzhFM3d74HU6P5tV5ECvzFNTZG4?=
 =?us-ascii?Q?Ls7WIA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ca2ae7-4f32-4353-28b8-08d9c09396f1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 12:57:17.5998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KLQdtAHyqckGmBw0Werwtih9pPi4mhES0d8jWbNXbhOrx6V1HYl+FYE6xrPvQ3mTy2FHj81wEWcicgCwcCWnVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3425
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10199 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160072
X-Proofpoint-ORIG-GUID: CKHSXtUa3evU8qNGZjOf63qiXJQjJZ4z
X-Proofpoint-GUID: CKHSXtUa3evU8qNGZjOf63qiXJQjJZ4z
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit b7cb29e666fe79dda5dbe5f57fb7c92413bf161c upstream.

When we add a device to the seed filesystem (sprouting) it is a new
filesystem (and fsid) on the device added. Update the latest_dev so
that /proc/self/mounts shows the correct device.

Example:

  $ btrfstune -S1 /dev/vg/seed
  $ mount /dev/vg/seed /btrfs
  mount: /btrfs: WARNING: device write-protected, mounted read-only.

  $ cat /proc/self/mounts | grep btrfs
  /dev/mapper/vg-seed /btrfs btrfs ro,relatime,space_cache,subvolid=5,subvol=/ 0 0

  $ btrfs dev add -f /dev/vg/new /btrfs

Before:

  $ cat /proc/self/mounts | grep btrfs
  /dev/mapper/vg-seed /btrfs btrfs ro,relatime,space_cache,subvolid=5,subvol=/ 0 0

After:

  $ cat /proc/self/mounts | grep btrfs
  /dev/mapper/vg-new /btrfs btrfs ro,relatime,space_cache,subvolid=5,subvol=/ 0 0

Tested-by: Su Yue <l@damenly.su>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 4afa050384d9..b996ea0dc78b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2634,6 +2634,8 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 			btrfs_abort_transaction(trans, ret);
 			goto error_trans;
 		}
+		btrfs_assign_next_active_device(fs_info->fs_devices->latest_dev,
+						device);
 	}
 
 	device->fs_devices = fs_devices;
-- 
2.33.1

