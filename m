Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057D93F49D8
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 13:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbhHWLcy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 07:32:54 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:24166 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236359AbhHWLcw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 07:32:52 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17N8TIXB016731;
        Mon, 23 Aug 2021 11:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=YmfqLPyioykdQtKQjae0fuw6UpojB+46/gxFuWOodWc=;
 b=xBgdYm/grc8K1ASnkSMQp1CwHx5Ak78srmwgyn7I0xFPJubZPcLASvhf7G63gXnLBlxK
 GcuogimykZ87JTs1mQH2cKSVd3w2fGJN7M0zzkxzedSYNIGeyJIeRdZSlnO3KaumhTTh
 YH7Fq8jZ/qVsX3DsuYtA3W+3FLkxHocnDfnEMkSlOCL9dV5lky++N/UcCMBq8BsPwvDc
 Lh81j0yT9vAf9ILRkeziAkwKKzh1o2kpBq9yEBszCEdNCOb5QfljLiPvT0keXGEZGrwz
 SiQq0OjaTk1QJfDwCQ3o4MX88SYjs5FFNu3Nyt1ywTLHA/2d4uAvnG0A6EYZ/31Ojygy Kw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=YmfqLPyioykdQtKQjae0fuw6UpojB+46/gxFuWOodWc=;
 b=ZqbYuY4vX0vONM4c3ahYGeNT6mto+MbM2XS3G4dg2VOwVKvSmpXGujmliEd0GyNlavn0
 AhxpF92fJUJzxQeNB3TV0sx8Yh9VzNgIlnrMMvsvpQDQPvYLY+gDtSEu/ioMsRJHm00z
 5o3dxWD4aDk5dao0tT6LJtEXij1thDtjOWIWptQBwWKVzGaZt5B6RrPF1qtDSmrwt64a
 /q9SP5BFH9FWdqvIrpfxDhB2bf6L1sAzJgL7e9qYeR4ebEvEiOr0H/p5FFHWE4g5GUpR
 LcikJTi0j68W1AJ6c9iwGBuNdGGuU5wwN7INkUoFNzimv9HfnoL33lMdIpA7T+xDBU/A /g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3akuswh8hc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 11:32:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17NBVGlW105101;
        Mon, 23 Aug 2021 11:32:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by aserp3030.oracle.com with ESMTP id 3ajqhcgyqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 11:32:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CL7TywOCyMSoGbPz+ptiR53oh37gR//S4RoheCLOFm87c/Azv9bnSgbWCujk/ZY6jNKmPUOvsylr7mg3g6Y0Ixu/di954bu/GB235VD1u1L5dq9+gS5fZiJTbYbhYQciJ0C9Jn6WNsF1bXBfBCZ6N2N6U9GBJNNWJnEw+PonbpVwRG9pVfKdAVNTRAsDUUZUYGbwZBs3YHzxuaP6Q7ISNSCCVWDFAIM3Ln9hMU5ZW0JJ21WLu7JC1k6GgUMeocx/Zek8PRpRxesYKfce2eT24B1aTlwCL2NVDnyAx+uigNEsmBQA6NzE31bt4Oyz1ZJNq3ThZXX8GS33nnlyK8r3Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmfqLPyioykdQtKQjae0fuw6UpojB+46/gxFuWOodWc=;
 b=Xm09AYgTPknzblLCrqhGXChwGpiK7LZN9P8mXw0xNNBWaC806oNXDzqKvMH36IGN+q867a+FsPPle0v1oDKPPthSVxqUL7LvQTm9XJL99vnYHuNLfbzTE5gpYh3VuFSDFv/QDfiw+CWXbo5/qR5i/8DTXG1sc5yjqLT9VkruvOHAPXVGcr03TuRiycF5OYUZmYyTsSk0Zf6NFVzFwNgDFj2Z0dhRl9f9pEAinLhw8+g6oO3FY/oJOpuKykgMwAsE4GrKQ0OGUWsocn8+kP3ZbbRPs4d6X4mpNtrA++d97UWhjqmoRMpQhUKebFK01BP0k8NwNRGwzWO8/bjtNFlhtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmfqLPyioykdQtKQjae0fuw6UpojB+46/gxFuWOodWc=;
 b=asrnufK+JFldnRtF2dwmSSaqV4mkxPH+CAjcwXNo0kYhYccG5SPuGGdfnjX/Kx38vHyC9P/yzUBhcWw7GtWqtvJEOC1YCoXns2gyZPT+ouFN4yJntDTP+NdxSdF6CAP4gSK5TNx1F7QtcM/ywYORPS+yHkjeHvQPWlPDkEYTCxc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4206.namprd10.prod.outlook.com (2603:10b6:208:1df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Mon, 23 Aug
 2021 11:32:03 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 11:32:03 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, l@damenly.su
Subject: [PATCH v4 4/4] btrfs: update latest_dev when we sprout
Date:   Mon, 23 Aug 2021 19:31:41 +0800
Message-Id: <e31bc6c24a676834482a7eea5e36df128f96717e.1629458519.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629458519.git.anand.jain@oracle.com>
References: <cover.1629458519.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0142.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::22) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2PR01CA0142.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 11:32:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 706a7584-7a17-40ce-2823-08d96629a10d
X-MS-TrafficTypeDiagnostic: MN2PR10MB4206:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4206A402A0E32200D7306E6DE5C49@MN2PR10MB4206.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GFnbvwmYCiulJbDvw1kBtCxorNTgODiLU7xzFVByg/cTfH0C1QsWRJOS3V9Wx3H5u+IsIoMk3UYza7f9jnPtD8uLwdUvo5DIRYba6pTKKnfhmPehLJtAlDhgQgJ3UqRVWU+G0PFVWQcGQ7BHgHonqkJolFNOzaFXwWvCP91vqmjrO01r/zLiMUbHfvZYrN/FYgOcda6H3aePR2kUY7LuqimaUca8fKac/x4zVPQLdeCfLPq2tJNTMKjT9BbVvZm2UVBjvZ5hoq5AayCYngUKi/3B8+1UZKAFIiH5l8q20EVxF/7eMKLhTzXmVBhCE/3pPScKwwfn9GAmXXB7tTwuTfPpN2t3JzKqX6kO76MUszP7E0laI2u2XCkf/J5YnnBOWSGALpT55FYAEyjRmhr9eCBkGLX2faiRWY4u1v+T44OCUL+05uKHSlPxb2LdWQp5tBxS5OeYFIC3wysW59Xm96L2QuStwyeb8OSagWna97tyF2uRc1b9wxlgcqJ95XSo0NVOf8nnqMz2FtZuWM2lD1cWgyQc/4br7OwsegPAV7QEmNh+fQt7XJRlYHisdkY+oajoWNh66d0QDuebvOIZoqfuGtqd+oou2gGu1oU1UnZOxAlkX903/x4AdfGhhhTUpNfC8DjaOhnMlNeIe7hWwA8GhbKWZWPgdnqM0QD6BFFRAUEBBvv8O5k48Z4MXwmIgGf7mmSNFvKreTpumZnCKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(366004)(376002)(396003)(6666004)(52116002)(66476007)(38350700002)(6512007)(26005)(15650500001)(478600001)(38100700002)(6486002)(6916009)(86362001)(316002)(83380400001)(2906002)(44832011)(66946007)(8676002)(4326008)(6506007)(8936002)(66556008)(956004)(5660300002)(36756003)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YieszWaH4rcxVRNbsnJJw9pGile1OcB/ZPVaHChGvY1uy+P8coP68xMIxJm3?=
 =?us-ascii?Q?hDQnrpwIJ/LsjuFIiZZRW5Q5mKXSz1UeWPutfHhkzX4cGTQbO+y35X8wCAtE?=
 =?us-ascii?Q?S6A9D11FkhuJqghRVhgMl7cdtqfmLbI0k/UHh7FB4n/YtftEy5IUP6v8cpnZ?=
 =?us-ascii?Q?wDorSKoeKB0ci9YB3ZkvaEGJZ6YTGevEVf5xsJ9J5PSjmUDPHYXMMpfKwmBd?=
 =?us-ascii?Q?mmcp7bqLuXquxbgQkLaUIVD2Gz3S5hkdkpZ46iSCRTFkuTWEhnGpDE7xtoUx?=
 =?us-ascii?Q?OS54ZsmYU5uU8APg5ZktmTXEnHazLJQ84QXxqUbJ+C0C+0Zzz3+1t1guFzX5?=
 =?us-ascii?Q?IAB2H6S9yZsj4vGirijsUKVagh0XPeUPQNilz/r1k9+mMNlWVAaeE2TUhyE0?=
 =?us-ascii?Q?QnyrlI2XiP5b35Xe0rNvemGz1Yvi5bXgkcwrPXQ5K0sYjh/T4S1cvYBjycdz?=
 =?us-ascii?Q?egbwFUPeOOnhKr9lmpSIP/NKeCHvr+FZIOjUTxFbI2nwH0APih0pCz6Dkc6+?=
 =?us-ascii?Q?ALMLGd+HSGqUExvN0NIYj9DYAw/8QVnHTujPxvBilA4kHkQuzpWduvRaby7B?=
 =?us-ascii?Q?kQKwxC9ZHFhcJR84S25SsKJ7w4OQxeIIx9/j+UHNbEHY8vLeXYROip1Qd/Vi?=
 =?us-ascii?Q?7JYzaixnocbU1i1iWoPUDBqwNnIlbqCVj8P/q3PwcNRlhVfcK33LWSYqlDuP?=
 =?us-ascii?Q?hv3Q0Qm0ehkBgn4beQTZQiJxXFU8mrt/V/ZzVxXVNAgiWLauobTsDcV3/sXD?=
 =?us-ascii?Q?Jq4eWL9rysDvCqR1DpuCXE8PFbGcC/B/4HBeVOyKUkbPmmFVyq0BQ1Q3JgSI?=
 =?us-ascii?Q?BCSBpHiN4pScqcAWHCtKWp1luyWwiUlIyMeGvsi0UYZjXHor3uc/BdJHVqY0?=
 =?us-ascii?Q?96OdBA3MAtPd5fLP+7W6IgMOMada26TTyrmGcDgXLU40g9WK4CHUAUxaDH/W?=
 =?us-ascii?Q?ox0XEBsFGfSzBTyuvjhiP0MCLOdW1abIEHxirFK6fq6wFYQM9mRkdOtxfqP9?=
 =?us-ascii?Q?F3ua1GFpUPb5imQ9kfz4D0cD6v9sPb5zE1fhLNWIMsyozC1yp3XpmfO6Rtoz?=
 =?us-ascii?Q?mNRRoBV+lQV9mxi0yoTmBe6zlj4/P6GyUmQI4O1lykWX8bLXkC4kAvvGnNgQ?=
 =?us-ascii?Q?39aQEeJW/VJo8uFnXyj1SqKfwBkztDKsFQJZeLCR1pWWeCBhZhPFR7xd/v6K?=
 =?us-ascii?Q?/oEnGFVHfqZT7BKVWbd+6vAgaOJCFFoApDeeyUhzEFzk3KXgumzmco1kC5fK?=
 =?us-ascii?Q?522SiDmvP8vhdwRUf1MuKT+w6QKPK7POpeH3r664IFRq9NFnmJfl3JCS2v4d?=
 =?us-ascii?Q?KYzogxPjq+Yf59J4AFymX8i5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 706a7584-7a17-40ce-2823-08d96629a10d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 11:32:03.4199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aETMvI2ksGJ5H/0n+6/3OcWpBL32gPGMeT4UVxN0cVdKnB1BoKVgeoncwinZKnZa2rwvwiTYmVfADDLsbFKzcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4206
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10084 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108230077
X-Proofpoint-ORIG-GUID: -9fAZMLLQTdoUg854e39eZsWUXb2RDH9
X-Proofpoint-GUID: -9fAZMLLQTdoUg854e39eZsWUXb2RDH9
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we add a device to the seed filesystem (sprouting) it is a new
filesystem (and fsid) on the device added. Update the latest_device so
that /proc/self/mounts shows the correct device.

For example:
 $ btrfstune -S1 /dev/vg/scratch1
 $ mount /dev/vg/scratch1 /btrfs
 mount: /btrfs: WARNING: device write-protected, mounted read-only.

 $ cat /proc/self/mounts | grep btrfs
 /dev/mapper/vg-scratch1 /btrfs btrfs ro,relatime,space_cache,subvolid=5,subvol=/ 0 0

 $ btrfs dev add -f /dev/vg/scratch0 /btrfs

Before:
 $ cat /proc/self/mounts | grep btrfs
 /dev/mapper/vg-scratch1 /btrfs btrfs ro,relatime,space_cache,subvolid=5,subvol=/ 0 0

After:
 $ cat /proc/self/mounts | grep btrfs
 /dev/mapper/vg-scratch0 /btrfs btrfs ro,relatime,space_cache,subvolid=5,subvol=/ 0 0

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: born
v3: -
v4: -

 fs/btrfs/volumes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 958503c8a854..1d1204547e72 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2597,6 +2597,8 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 			btrfs_abort_transaction(trans, ret);
 			goto error_trans;
 		}
+		btrfs_assign_next_active_device(fs_info->fs_devices->latest_dev,
+						device);
 	}
 
 	device->fs_devices = fs_devices;
-- 
2.31.1

