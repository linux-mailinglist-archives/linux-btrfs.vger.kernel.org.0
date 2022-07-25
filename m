Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230A9580133
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jul 2022 17:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbiGYPLG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 11:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbiGYPLE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 11:11:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41ABC9FFA
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 08:11:03 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26PF9UOS022457;
        Mon, 25 Jul 2022 15:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=n6vusWSntcd8Tr7uNj7W4UzhR6sfcRvy5LJQMzdjWUc=;
 b=DQBNgoIcGKvoXNPO1k+HyZvWy5vOS2tMnaojx9Pv0UMGuGjLSClJjQqOKAXnkao/TFZB
 XJXC1FGFu18LYPudijGDphuP3ZVIPeWefqc0aRQD8l0yQz1uj1Fnaiq5UzwbJfdoaFa2
 CHMyoaFpUgTIGgd2HGun59Fop04CuaCCMoE8H5BcUQ52kxcb/dCfyguOy2NTOaSKgPrz
 8V+BuzGDy6hEtyeXEwCdUcxGJN9VWDVhdIR2UnYcRSWoEw4FrhbScGoIWAzguj3saIf3
 qihIEBGpJq09jN84TYDWgsHx2bl1uCmoPs3JIDWQ/BSXdck2nSQ/ZELyxfrmfwmgHF5i ig== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9hsknsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jul 2022 15:11:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26PF39n0017794;
        Mon, 25 Jul 2022 15:11:00 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2046.outbound.protection.outlook.com [104.47.51.46])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh64ybvx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jul 2022 15:10:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsNqcMY7m1CDWSdgphItjFLJLHf2Pw1OGJmp/gUROX1lLYMuQQ0lIqIcRORM8aQxdQoXVL4gCI6o4lSFKQjy6IUbIwvmcFpVzmyaI1rPGYhBlqKWNnhJx7vq3WR7x+iGiUntg1+mVjTZ4QGJoByfjhs86Y6hjk8pDbwhugCKa4nYWj4fpUuVo18gIx4y2Gh7qGOyR1Kmxw3vZ5XErcK2YH/p9jPmXh/021G9vesBajHGDRc7LQbBeGxeHCDhl56oTIXUyhamckGJ85Io2kkSjk9q6aLAztyUSb/xNW5HqrnF3KLPlNZhPliCwcajVAT22c7Hxckf/+fqD+OgigwGiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6vusWSntcd8Tr7uNj7W4UzhR6sfcRvy5LJQMzdjWUc=;
 b=cFEFGV/XMx+w9UyzHEiZJDygO0/gDx02T9M86/Zr8bn/UJpgvUZRzRDwhvGXLUzy6H0Ah7a7EpyK0MqudP6IGlEc5c4nhrnuprLWS035C/svpZ6+eZ/hRVmlvrhDstFpDJC/1dcmLTU8TpOk4IrombNcCWFOlt1auKqqRm7jWvxT7v6wMzQPQC+Hl+xUct3xl41FZ+ET7yAY5/m1z5F1G8wxMmzRXy8o7uKgJootgAaZqw60BBitQ1SaCN7/NLqHzS782vID8xxHxmdBZ1vDPK04c6EOZ+WK/zfVt9joZj1Rnq5Iy8wl+VcjiomZ4w6c2BaztC3P5ZqQEb3g8igpoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6vusWSntcd8Tr7uNj7W4UzhR6sfcRvy5LJQMzdjWUc=;
 b=cpGjFQ1aW8JAvNcAif/fHyuUh5OmJb/X558A45JlCXXd4Kqyx8H8G7EmHo8uj6lOEJCkdhGZfoCUwV49No1+G+U9Als4ljzmNowgH87vYMm9b5+V4flakFXaKwNFiVn6x924MagcU0773UFkkU8NtS/UCoxRfHvswHbIvug68Eo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BYAPR10MB3429.namprd10.prod.outlook.com (2603:10b6:a03:81::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Mon, 25 Jul
 2022 15:10:57 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078%7]) with mapi id 15.20.5458.019; Mon, 25 Jul 2022
 15:10:57 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 2/2] btrfs: introduce new read_policy device
Date:   Mon, 25 Jul 2022 23:10:37 +0800
Message-Id: <6cdfc71129c2ca6df28a6080a53cdcc165184d46.1658409737.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1658409737.git.anand.jain@oracle.com>
References: <cover.1658409737.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bec2072-5856-438e-b8e2-08da6e4fe055
X-MS-TrafficTypeDiagnostic: BYAPR10MB3429:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s/lmnRSc3SUOdnjjeLR9dKLFVtf/I9Zt0ZV+gaT/h93nL/uv78cT7OOgJ2mj8KC/oT+c78Kwixd9qM21XvDodnEHYgt1bZ8bzZy7WunXt0IR3Mt8XVkhS+NRum+n2BO/ABwL+LeCCPBHn52FmkjT08p9uPg32SyN/0irIVI5SAmFFVLDEVc9wi/jRDAdeC40aIi40nOUmLhKTPH8EMhtt4h0jM5h7KPXOKTWQ2k1faNYBzAcT3k/dY9HLPzl2eAdndjcdQTdg/xHDZobkkRswUvv9uolkzawG7VyBYWUKjiysQfKO88ZI/5HgqW42iA3H6iXIPNeRal/sXFJ8kcsvEeMP8mAtAyaeaPP2V+F5tjAynLl6ACT2YQ9cPPG2INbU0s4KBs7uXRvVeUiQbVO+Lzvrak/vZYoxD4zwD+l9vwvyUDUEcwdGTZrVNYamwMTibh/z6xOshu/syw3LFCP3E0oxj3oqBPH2yPe6SUYcsLUH29xywW0jnWVvGqB/AvzFkhDqTRA08vYuqvGyvrVSIUtOoybmx4u8b77wl1aLpbpyEjtrI55+63X7LUZpf2dbLeQaoCA5sveYQ867PH/LEQsE8KhUScsdLDI4lEryp9+2oSN+tXk8RTG+Uq3xOu9FH6fVgqAkD/IYcjdApNfjJWuFQl0JFRK/rFscnw+qJfU6g8dgapGmZ19zHm/2GwrLbKqijx+zLJFXMBJDj55mbQCgGLB2rjyQ0rPK+PGLio=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(366004)(39860400002)(396003)(38100700002)(44832011)(6916009)(2616005)(6512007)(6666004)(26005)(6506007)(8936002)(5660300002)(2906002)(41300700001)(36756003)(316002)(86362001)(6486002)(478600001)(83380400001)(186003)(66476007)(4326008)(66946007)(8676002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xC6aNNj+gG/Mg2+T3MK4bBeLyjUqKCB9WqlJOGPD1tYLnX+dDeYDx5tihgLu?=
 =?us-ascii?Q?kj+aad9FifQIEiZBvt5cnTYqowWyDMYZjtR7nNJkvNw8bHwUQsa077sGvDIy?=
 =?us-ascii?Q?4pyNHmqjiM2ceK6G0K69PrgIVsgXE6wosLZ3RdEVDabE5PLFmMoAWWQECmLT?=
 =?us-ascii?Q?WTxXZqukmOCdVrFiC+H6vfX4C1NNodEGaRfgbOiVQFwAY8hQXjazdv4z85mU?=
 =?us-ascii?Q?JzMx9Kl01VHuritwOjL0ybx2uatkir2oaOWnc0lFz5GvtIhC9jlpATl4LSY4?=
 =?us-ascii?Q?ZJpMWhvB4OnWUXOlopQxrIRj6Riok3Caw/LVcd52+EDoZ2RUONJNKMbkjftz?=
 =?us-ascii?Q?RUu8WLaIeq6rhKeLFNYB22MJb8sYSOmpT/UJd8JjVz/vbu3h74M+UCgfrOXU?=
 =?us-ascii?Q?zsv7C6dk+n2w/j6E0LcwjV5L97AvG55g6hFi6T9Y3hnJdIcw20Vm7EWddzex?=
 =?us-ascii?Q?GlgQsBeqA455LjhDtwgaWnA3GWzFmDAkn81n3Vjnysykze+/laCw0H4op/0/?=
 =?us-ascii?Q?Q58bN6ohxpKz9CW6YF1UGgS+1ocZ/bsigkTKxADqLBIQH5fRuSAsw4Ch2Bcd?=
 =?us-ascii?Q?OQr9Cw7Dz3n551DCEGYnRl53vyNf0t2nLYWc9+4LLtp9MUMOkuPMCdgyktDV?=
 =?us-ascii?Q?YtKw2YgfLbJofRAcbmsCM1wcnN4RpU/kVTO+wPbURkrICQCmqrUB+TQwAiUE?=
 =?us-ascii?Q?fkVXFystfoV1Cr+jt/ZZTqDkhNEWKIf1GmYmDC9hgD5IVCGx+PqLk4IUN4m0?=
 =?us-ascii?Q?ZYQwQEuEIVy2eWFJvH6yofzqAuedAiXcr9T1A3mMKVju3jZN0+EU7CrX4APF?=
 =?us-ascii?Q?dZmMp5aMtIqx3uplSoDl0Y2cHxWnCl6DISkKfGWJMxCJrKnhidOKUw26fJIG?=
 =?us-ascii?Q?EGIsqpKik2URPbBCS0UMNGsCKNKxGy76nWBaiCe0UcUGgpKUS4yoX1BfzAJb?=
 =?us-ascii?Q?KDBfKQxsa2W5ltL6W3GIs9lyeHkK9FWDLqOnZNw20JdOpzU07VXv4RsTOISk?=
 =?us-ascii?Q?4rZ7/5PEBxQIWtCh6cD2i6ppzFcK9KinwJsySgNbuO3ocF+/Lk7fgmIdwAtX?=
 =?us-ascii?Q?lUI+HvdalSh4wJyqHt1cjKJ5ITbGQhSuJUqht+A3waWgsPcnBRhgd9+uatje?=
 =?us-ascii?Q?vDQivEzj+YHpUYgQnejusWMsP5NP/tWLRruw2co+FIgrlc8yAqUsMdKl6Q99?=
 =?us-ascii?Q?Y7z1TLhXxk+2gkMbni5A2F7Ba94SBJsx20aZj/QuuzmeBbu66KwOsPc2ac4H?=
 =?us-ascii?Q?y/XwwZonpZu31whSgMeAhDUm3irDT386hVewp2QBfIquSkm2g6bm6sj2z+ax?=
 =?us-ascii?Q?0629htHM9lGmVHDrKAzEMRz2qBmtWMZqUiHzC/CoRuxNRN/j/75vSEjjYiva?=
 =?us-ascii?Q?i1KoHZEq/vl36p8XmFVS98ADHmypzWxwMrW7vkaVLdM20aEWmjWoi7Y81ip4?=
 =?us-ascii?Q?yLrQyiujXo47g1aUbuXb/4LNmiTBz8MZbazr3gSBZ6kmVsRG9dABUR3NWGNC?=
 =?us-ascii?Q?gQS4v9LqeZUiU/uRvhWq/wn0sbHo8PZ4FyrGiD76xWuMx2tXEat2VY0pyU1R?=
 =?us-ascii?Q?Q+p2tQzkMFkUgnuCjR3bmjiPp+yZ6RrJBBsuBZqj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bec2072-5856-438e-b8e2-08da6e4fe055
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 15:10:57.4813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2kol0y6mUyNSYFraNh91k2q7IgcOSlTPFaFNEUFzlqXe3aXVnbkTCrdDr7dWhfmAQJhAH5Zf/H9I6eeJHU2Xzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3429
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-25_10,2022-07-25_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207250062
X-Proofpoint-ORIG-GUID: b_PqYIWwaJLgksr6086e3WYGYw56DW5F
X-Proofpoint-GUID: b_PqYIWwaJLgksr6086e3WYGYw56DW5F
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Read-policy type 'device' and device flag 'read-preferred':

The read-policy type device picks the device(s) flagged as
read-preferred for reading stripes of type raid1, raid10,
raid1c3 and raid1c4.

A system might contain SSD, nvme, iscsi, or san lun, and which are all
a non-rotational device, so it is not a good idea to set the read-preferred
automatically. Instead, device read-policy along with the read-preferred
flag provides an ability to do it manually. This advanced tuning is useful
in more than one situation, for example,
 - In heterogeneous-disk volume, it provides an ability to manually choose
    the low latency disks for reading.
 - Useful for more accurate testing.
 - Avoid known problematic device from reading the chunk until it is
   replaced (by marking the other good devices as read-preferred).


Note:

If the read-policy type is set to 'device', but there isn't any device
which is flagged as read-preferred, then stripe 0 is used for reading.

The device replacement won't migrate the read-preferred flag to the new
replace the target device.

As of now, this is an in-memory only feature.

It's pointless to set the read-preferred flag on the missing device, as
IOs aren't submitted to the missing device.

If there is more than one read-preferred device in a chunk, the read IO
shall go to the stripe 0 as of now.

Usage example:

Consider a typical two disks raid1.

Configure devid1 for reading.

 $ echo 1 > devinfo/1/read_preferred
 $ cat devinfo/1/read_preferred
 1
 $ cat devinfo/2/read_preferred
 0

 $ pwd
 /sys/fs/btrfs/12345678-1234-1234-1234-123456789abc

 $ cat read_policy
 [pid] device
 $ echo device > ./read_policy
 $ cat read_policy
 pid [device]

Now read IOs are sent to devid 1 (sdb).

 $ echo 3 > /proc/sys/vm/drop_caches
 $ md5sum /btrfs/YkZI

 $ iostat -zy 1 | egrep 'sdb|sdc' (from another terminal)
 sdb              50.00     40048.00         0.00      40048          0

Change the read-preferred device from devid 1 to devid 2 (sdc).

 $ echo 0 > ./devinfo/1/read_preferred

[ 3343.918658] BTRFS info (device sdb): reset read preferred on devid 1 (1334)

 $ echo 1 > ./devinfo/2/read_preferred

[ 3343.919876] BTRFS info (device sdb): set read preferred on devid 2 (1334)

 $ echo 3 > /proc/sys/vm/drop_caches
 $ md5sum /btrfs/YkZI

Further read ios are sent to devid 2 (sdc).

 $ iostat -zy 1 | egrep 'sdb|sdc' (from another terminal)
 sdc              49.00     40048.00         0.00      40048          0

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/sysfs.c   |  2 +-
 fs/btrfs/volumes.c | 23 +++++++++++++++++++++++
 fs/btrfs/volumes.h |  2 ++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index ca9812cabece..7c15fa1a8b33 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1169,7 +1169,7 @@ static bool strmatch(const char *buffer, const char *string)
 	return false;
 }
 
-static const char * const btrfs_read_policy_name[] = { "pid" };
+static const char * const btrfs_read_policy_name[] = { "pid", "device" };
 
 static ssize_t btrfs_read_policy_show(struct kobject *kobj,
 				      struct kobj_attribute *a, char *buf)
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 272901514b0c..cf358926b52a 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5793,6 +5793,25 @@ int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 	return ret;
 }
 
+static int btrfs_find_read_preferred(struct map_lookup *map, int first, int num_stripe)
+{
+	int stripe_index;
+	int last = first + num_stripe;
+
+	/*
+	 * If there are more than one read preferred devices, then just pick the
+	 * first found read preferred device as of now.
+	 */
+	for (stripe_index = first; stripe_index < last; stripe_index++) {
+		if (test_bit(BTRFS_DEV_STATE_READ_PREFERRED,
+			     &map->stripes[stripe_index].dev->dev_state))
+			return stripe_index;
+	}
+
+	/* If there is no read preferred device then just use the first stripe */
+	return first;
+}
+
 static int find_live_mirror(struct btrfs_fs_info *fs_info,
 			    struct map_lookup *map, int first,
 			    int dev_replace_is_ongoing)
@@ -5822,6 +5841,10 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 	case BTRFS_READ_POLICY_PID:
 		preferred_mirror = first + (current->pid % num_stripes);
 		break;
+	case BTRFS_READ_POLICY_DEVICE:
+		preferred_mirror = btrfs_find_read_preferred(map, first,
+							     num_stripes);
+		break;
 	}
 
 	if (dev_replace_is_ongoing &&
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index f04a177136b5..e62252061606 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -260,6 +260,8 @@ enum btrfs_chunk_allocation_policy {
 enum btrfs_read_policy {
 	/* Use process PID to choose the stripe */
 	BTRFS_READ_POLICY_PID,
+	/* Use the device marked with READ_PREFERRED state */
+	BTRFS_READ_POLICY_DEVICE,
 	BTRFS_NR_READ_POLICY,
 };
 
-- 
2.33.1

