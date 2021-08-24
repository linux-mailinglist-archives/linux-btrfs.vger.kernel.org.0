Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B017A3F577B
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 07:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhHXFGd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Aug 2021 01:06:33 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:64000 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229646AbhHXFGc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Aug 2021 01:06:32 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17O0xBfb012065;
        Tue, 24 Aug 2021 05:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Kfmn7Ipr/LAP3MZABIkHbhXFdDHvQIkko1C/VmaUKxI=;
 b=fHCvkyVxKNLUNsy47M5IEbbLKAC0YiNXR9VEy2PVwqFTlxl1pVITtfa8M7QAcLrYE8H8
 qKhRSwUoTpDxy2C4Qh6WgUJfrDbILNZZi52zqO6rHIwLLdG0MJwQLCLqMI5KYjfQnWm3
 Dt/yIoblGXGT648Xck1OsfG+qvod5qUIEO5s7PzGZMBvdmqgbeYIX7fpPvBBcwXNfobp
 NAhSQJXAR5z15wueM1+ZuB8qO6qbvrbmtoUXqFUAbQprP6P8Xbul5rm1ExPQu93vQcu7
 g+G1sXjvWEgneKY7HT6AoIo0mEtM1g/dAf1A9SFrzkTWivjoflkIDO8D1zaGj8R74VSW jg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=Kfmn7Ipr/LAP3MZABIkHbhXFdDHvQIkko1C/VmaUKxI=;
 b=qi8X/zHZ3ZaHAszyPC48vHuuhdvygzNPSkrfWbLLnY7ylW+YluMIuMBgbiCxy0RUId1d
 YoNNZi/UVxKgsPQot6SA5jD/pxS5DF9g8UYCij17VFkCfJnD4B7oxNcVWtrLrYI3v9t2
 0hnCGYe3NBdFWxDUgIzk8z1+m0IughvRYCUbUcMdrp2NfR19U8/MTsKmkX1w0RLZ2UCf
 XaWD58MjgfOGTrLlBq4PC7dt/pltUvJFgHgU2Mbp1bzQnvgxy9F1ifG4IkHJ0dscIAI4
 4CaeBJf67lpW3BrnrLgKILCXTKC7tVdLg0YmWiF1jcQ8hvmiL0Z9wuopP2yLuTQewImP 9g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3akw7nbab9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 05:05:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17O55J6i121827;
        Tue, 24 Aug 2021 05:05:41 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by aserp3030.oracle.com with ESMTP id 3ajqhdwwk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 05:05:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MC+hKlZGJ2HJXZ9/5+p8tz1+eCMdTN7/TkABqN3W409UryZPZdnHz6ehYn/fEOQVGUXG0+affHME4N/CL53VIyS/OCjHffQr6IE+Uqo6d3k4qWbkqp1e534sbn/abMBIaP1JumT0xkNDbpudc4O+HlS3ZQ6HMxAuhJN1Uk5L/fQu5I8HdZkjo9iBo2FxUGgU+ZGEe+2cQuIus8IrDraxjz/EDitQPCwhY9OCyuAcXnmK+6wu4yZEK1ZeEob1szdixcbyFMXWg8tEpt2Gzvc6XVeFt7gs3upBbbp4p91hDQ0X+6+d1GsgEfpRmkGBTc0BUt+9Rwpgaq4k1jYCKHfIDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kfmn7Ipr/LAP3MZABIkHbhXFdDHvQIkko1C/VmaUKxI=;
 b=lpM2z0BGABghzrfiEDZtKzMtsCFCxExCXE+e5PlbirkfwddNQdnJUZlqt9D5uoa273yZhFLKDNQknnnV5USaUc0nVT709LMN+OcbjbofEFotWNMrUZg9HGGnf59cm5z9egpe8BW6XANomZhg8r+3fJaVnMfPNHH5/q94KlsQdcPjKvbIRmQFcs2xFB8cWKK8y909+UzX8rxbK0umVcFdlZOx9QBu/3Y3KvAnMgVFu5s0sh7I9PZHGAQ1qOZ6dwzrgwtmJ/TOFZGU5d++AOQJJLd/JMHTFqPNfPSFJJ5dJaXMSWZqy05X53/QmooUjrszQ8rggVsZjWNG9Cw1ORG3pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kfmn7Ipr/LAP3MZABIkHbhXFdDHvQIkko1C/VmaUKxI=;
 b=gUCOfzFdMGIjeC45iUHHC9V557WCqpOSGi/igvrdjTDWltFlHN5D8XoPPHDrXJ+DBLhid/vzJTwyYRwaX5xSf+xE6nY4aZJcuxNn2WT7uJvPS+HvY1V+ZaD5O0FpIHfW07hWc6XOpoitkrviRQGLF2Ta6SRdIlCypN0SQzAw7Wc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB3428.namprd10.prod.outlook.com (2603:10b6:208:7c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.24; Tue, 24 Aug
 2021 05:05:38 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 05:05:38 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, l@damenly.su
Subject: [PATCH V5 0/4] btrf_show_devname related fixes
Date:   Tue, 24 Aug 2021 13:05:18 +0800
Message-Id: <cover.1629780501.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0127.apcprd03.prod.outlook.com
 (2603:1096:4:91::31) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2PR03CA0127.apcprd03.prod.outlook.com (2603:1096:4:91::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.6 via Frontend Transport; Tue, 24 Aug 2021 05:05:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51faedec-2472-4e55-5c21-08d966bcd008
X-MS-TrafficTypeDiagnostic: BL0PR10MB3428:
X-Microsoft-Antispam-PRVS: <BL0PR10MB3428498203AD3BE0130ADD89E5C59@BL0PR10MB3428.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SPe1Qwthbyyw3Ba1ELaWUDLWGCPfdMPbTPl0NKPo7WLCImauyGs+NWUm4lFRjdY4hJjidnSCPi9YbZoB4bJwziXEiShyxDPQTehrHYe58Cq5kLdbev31/4wKfXr2As+6GC+9WL9jQgNJ7fF95wRIoHiJAXLg4BAtCzYTtymWEogw4TxfmfbCA6hDZFPDQktD8jU6nxp/stqNeZiS8h1hj/RxGDtB/hw2ozfFkr65A9KzcKXzFfttr4gbX0WxoB8PYo1P69LkO1hSBMawTUiZ2xiF6+sURUDSRfZXgLNrvgn0m9mXmaA/iaGqsB/8qplSJ2OacCproQOutD6uyRWG3NiHM3D/BXNmhtBEaINV8uZdMhTCiTlqXQH63/9UTQQWH+Xa6NUP9kPMNSe98E6OUfulMUBk3ILqXHeQ/n1SS4wZHVxkB/X+Y99MXk9Sk45dZxoOqwon46o2UTRAFLF40K/FOAU139iXwvzRz+kPMKOlVO4ZsGtV6Vq7PJYold2EUF0i2GG3Ppqc2iBjlZUqLQ9MWxo/9WiG9eo/2ZcAH7ytnx9CkIOs68ZjbkFs6n3CKLrxbBEGyXUiwDGlZY6gYOnZaTdt/2ESOWuhW1O0xzR8NCudB6cnBcAT+5GVBnUqkV1N4e6JeedGeKsbjaqudrB8YIQoeA/PeKi7mwoklWNU2SjkDgD5tw7tv4aQ4iTnokq/XIreACRPwJZ+7FBYrOKgzsrERaVJ156fGbeosL7GuQy7kN8E74pkGzuQBhIjv12nXclbtwe3oXQP1BpqMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39860400002)(346002)(396003)(136003)(8936002)(6506007)(6512007)(956004)(86362001)(8676002)(2616005)(66476007)(38100700002)(66946007)(966005)(38350700002)(83380400001)(5660300002)(66556008)(478600001)(52116002)(6486002)(316002)(186003)(4326008)(26005)(6916009)(36756003)(2906002)(6666004)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SkNbtHgAaTvrhYZlRLIvqBEQ6WZekV4i+f/ZQt4ytBfVBz4gBQbjco3FcY1f?=
 =?us-ascii?Q?j6iTLGAkg8aC++CmWicQnIsTyOufTH31Cv9QpXstHOKsbstkdWfM6Ubb+kQy?=
 =?us-ascii?Q?ZpoT5A1tUGXONltkKW/lEiBuVqHOarssfB+j+2Y8VPJfHs1krSu+cWCh6pTg?=
 =?us-ascii?Q?Q/SKzEBuh3Er2K7TS4334tJbHlLV68l0QRFSi3qzdqIedUGvZMZuWXxdsdqK?=
 =?us-ascii?Q?XvuIwFY0VSNIp2AmQvn7u46QwxQbk99k5w/7zjPJKHCmmu4qkKTkRR9D3nJM?=
 =?us-ascii?Q?4rbiZ09/bfRfV3PK0R2I0z98GkgQ/YWHnMhnzkp0heKinv2CTUcIU/7HKlEg?=
 =?us-ascii?Q?HVYLKLYAbwJr21Rf0KFWBVe7diPvnGP3Za7fUrWQW9uePHItTlXG4UQoVuwo?=
 =?us-ascii?Q?BnTjywGPmtrq0KhDDho1EDuXC6yysYvWrsBwi8ZPcekS3UYW/D079TzVEW2z?=
 =?us-ascii?Q?TcgbCEJ+I4RseWwulbfR6cgb96a9oFC+1HJrroNNCDqZESIgZmWiDSoZRBrV?=
 =?us-ascii?Q?wGZeCMbJJD2Bw8JNjZ+vimGlILTqAKzhJIhLhsZpVIK6SUEAGyTcIQkDzCMb?=
 =?us-ascii?Q?jI7nodrtQpf8xpn54SkWKKHsWeFCC0t/Jea9HmzAN4yBeA1YI4JYt/teFgzh?=
 =?us-ascii?Q?rMDGsVUPea+FV03KopviodemjYtY0oR49mDJKz0tKDcD3/UfpHb7MHKGU9K/?=
 =?us-ascii?Q?gOTLEPnv9lAfHT59pA8DiwdKrCVg2Lhpsd8vqxLkxPFlgvD7qsY2+grG3dRo?=
 =?us-ascii?Q?9x1X1K1dM+J0gOv3YPNSA4lzt++K8uGk9xefIKelnxgMaWu+9I3UYKp9O67i?=
 =?us-ascii?Q?TSX8gm0rf6HOu9KW0ofn08fn2ib9nBnSausOywwdZ8W+3F35gBQRX+CnS7AM?=
 =?us-ascii?Q?msqY6SnPSxBd+2VYC+V4bibRilFlyJKUFuvw06+FRseTgnrvB0yLaOTofch+?=
 =?us-ascii?Q?xnoOpESMMGMldde2bIRMGfGCjn/BGYoysAfrAwmatket496pXtmg4hHsVpot?=
 =?us-ascii?Q?0IyjLkSw29u6G1zxweQFqBtJiEjS4hjQ3kkZDf/d1TVPor2RgMqtNAulowRs?=
 =?us-ascii?Q?eNsVXfRE5gPZB0YQYbVdD3B6m987mb8qxrv/QoaFFBqaIy4KUQngqsaUyx1c?=
 =?us-ascii?Q?FcZ146Ohlhsx+CCwxdaz2PQQcCKIEm8BxVWaCVutmsbQoA/Xt4vhOD9qxPNn?=
 =?us-ascii?Q?I2BpT5IAvJ92ypdvQwXyZy2bf74axFgwNuOC3IXjuF0+HrGd1OY0H/hBdDjI?=
 =?us-ascii?Q?5+1J9XmfRmHRw0G8qQchY3X4/2Nu9YYlgYtngEyuIOfbEJURGjqt2yPmKVmm?=
 =?us-ascii?Q?Yc+zgr2TdFywpp+5duMJy4ue?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51faedec-2472-4e55-5c21-08d966bcd008
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 05:05:38.3025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2DCd1S4m+C0OiDhgqV0/6THh8Oo2t0A00Q/OyefWOs3Kfiy5pA4TFMfPekVQkA05O/+62BEow3Q0tpsoueiPXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3428
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10085 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108240031
X-Proofpoint-GUID: hAYDpIhVH1_zw4UGL8lx7k1YDRXq1j0b
X-Proofpoint-ORIG-GUID: hAYDpIhVH1_zw4UGL8lx7k1YDRXq1j0b
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v5: Patches reorged.
 Patch (btrfs: consolidate device_list_mutex in prepare_sprout to its parent)
 moved into a new set as it has a dependency on an older patch in the ML.
 Change log updated.
v4: Fix unrelated changes
v3: Add missing rcu_lock in show_devname
v2: Use latest_dev so that device path is also shown

Su Yue reported [1] warn() as a result of a race between the following two
threads,
  Thread-A: function stack leading to btrfs_prepare_sprout()
and
  Thread-B: function stack leading to btrfs_show_devname()

[1]  https://patchwork.kernel.org/project/linux-btrfs/patch/20210818041944.5793-1-l@damenly.su/

While btrfs_prepare_sprout() moves the fs_devices::devices into
fs_devices::seed_list, the btrfs_show_devname searched for the devices
and found none, leading to the warning as in [1] (above).

The btrfs_prepare_sprout() uses device_list_mutex however
btrfs_show_devname() don't and, the device_list_mutex in
btrfs_show_devname() was removed by the patch 88c14590cdd6
(btrfs: use RCU in btrfs_show_devname for device list traversal)
for the perforamcne reasons.

This series does not intend to reintroduce the device_list_mutex in
btrfs_prepare_sprout() but instead saves the pointer to btrfs_devices
in the fs_devices::latest_dev so that btrfs_show_devname() can use it.

patch 1 converts fs_devices::latest_bdev type from struct block_device to
        struct btrfs_device and renames it to latest_dev
patch 2 btrfs_show_devname() uses the fs_devices::latest_dev::name to show
        the device path in the /proc/self/mounts
patch 3 fixes a stale latest_dev pointer after the sprout operation
patch 4 fixes an old comment about the function btrfs_show_devname()

Anand Jain (4):
  btrfs: convert latest_bdev type to struct btrfs_device and rename
  btrfs: use latest_dev in btrfs_show_devname
  btrfs: update latest_dev when we sprout
  btrfs: fix comment about the btrfs_show_devname

 fs/btrfs/disk-io.c   |  6 +++---
 fs/btrfs/extent_io.c |  2 +-
 fs/btrfs/inode.c     |  2 +-
 fs/btrfs/super.c     | 26 ++++----------------------
 fs/btrfs/volumes.c   | 17 ++++++++---------
 fs/btrfs/volumes.h   |  2 +-
 6 files changed, 18 insertions(+), 37 deletions(-)

-- 
2.31.1

