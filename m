Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB616653EE
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 06:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjAKFn5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 00:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjAKFn3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 00:43:29 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D3ADF2B
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 21:40:26 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30B52jYZ005483
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 05:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=tXPcq5m/rA+NNxFaRO6T7ATWkJLtu5AXY78z0RR+OyU=;
 b=1lYtW8eGoDVrb9u+evP9+kxGQNX5mMIrAKCn/m+54PFTsCSmn7z6p/FIScqWMo3vZRJc
 np4JpGzXRTQGyKyrQ4xy3GLb8hs46dAOVPQPhnY+Gy4KnAEdfwkND9Vfh3H2TC5acGqB
 0cEVNAFwJ+LQrJFCcQLT2YE08TRnSJlFvpQOIGzQFaMU46uVQK6zlJVhdITxSgN28TSK
 BNcBY30qjYehb8k7ksV17n2S4PCwBk5A5s1DFpHWA/g5L0hPCdCZB1PHCKp7auvItbc8
 N4R/NEWQkN+PRgJzJJxFv6exyH4IUYRiU/4XQCDNYXasOLizH+GRXBIqZSTDIFF27AZV zQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n1fe58mjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 05:40:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30B41Z2H009141
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 05:40:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4nqj29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 05:40:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Onj+QCsnrPxC8bRUvZyDmu+oYwjHWx9MsYLY1Sa0WAiQYSCSTMOpgXqHjKT+EKw1XeQw/WFUUHJqjWTn0pqtoLYuaUmBsGEA72R7i/5d2Xx1pg44k0wQNnc3lrF7np/+8IGmEBdGyhWU35Y7Tg3I3LWDofQzi6OVDgnw/NEGgtxmGd+LOYYDl29dkiaUBtM//utr9GoeEuUYCjb1wXFgfRQQqktMlm5Tcdfn8wbpkxR5M+4yqzaN5tLdF0+gcZrtlE5Lt34w7qE2Led6juJiBWiZftIWlCYzCEdjSbVd1aPrBe+vZEkSn3hF2vmvbBA4v7yP108pQhzZs7SZ0rgECg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXPcq5m/rA+NNxFaRO6T7ATWkJLtu5AXY78z0RR+OyU=;
 b=CPGWdgM9WjhaAp6UFNEByYvwXSntsJTvplbogOJA3BabtSan6xm+04Fx+FOUwwyrxB9u2V8tqpq670+BQ8fL9uPC6At17NsA/YOx/Ntx80CmP7axs77UFsD7kuuC3ebZ/b9TSN2xKQrRN+GCZBoD0dTWzSW37fXrClYm1LdpmAhwHxuTZnT+IPbBYezBaWgxA5xCzvZI+DLAcNyMVuo2ZH5egBM6nT2wVLv7XUN6n133XTxttKS6lTFBt4puBeCinoOEcpEXk2V6G3cTjjkZFkr2KVEngEz1RNvGWocVGxqRE1csokBj42TmfVxey3XjQbNoNmfSXgEZ1kw9g1Gs9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXPcq5m/rA+NNxFaRO6T7ATWkJLtu5AXY78z0RR+OyU=;
 b=XNjf6AMIvUK6V9P4oG1zFmSJASrPK31S405EN1OdokSWROpeFI33VgftGwXGVg2vSNzQVjKBy/c5NOOvHh7x4uIr8qQVG0if5dt2zrEZRgC1TzK7Ge26U163XnmKwkHzerS8hLfU1fxk9QoO9VuGuMzIG+a9Gwl0VnzHwqbvFYo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB5308.namprd10.prod.outlook.com (2603:10b6:610:c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Wed, 11 Jan
 2023 05:40:23 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%7]) with mapi id 15.20.6002.009; Wed, 11 Jan 2023
 05:40:23 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: keep sysfs features in tandem with runtime features change
Date:   Wed, 11 Jan 2023 13:40:17 +0800
Message-Id: <ef0efdacd9bd53a55a02c6419b9ff0d51edf5408.1673412612.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB5308:EE_
X-MS-Office365-Filtering-Correlation-Id: 39137ba6-ab87-4fc2-edc9-08daf3965573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e2eggBn4oKqawDvt1W/yWpXN8Vn6Wz2Zh2Tj2dAqe3Yn+36IgVWcOdyGE3DKF9ttdwHVvxoJT8k+5VmAJYbrrL26U3EOD74N1El7SAdTiEbY3iRVdFNjlkL2zHALc5PlZV8Qg+/ci2ztG2UE8qxPrQTwkPDeh43h48P57KAWcJ6OKLeXMOKIevySwl+jRDYeImUbalo7r4LbmlHxbAunLlsLKAw5ZPTFxpDPwsb3dlvZSX1SC8sI1Q2XJmBWBC8j06+ySa0+Av8EhnVVP67DIuxpUFXEH++1Mz0vZ68dJ4T8u7emZ85+bvLOaYkmwOfXgHdh+symulJadQYlSmNx/XtmH+2H+D8+9/UfeOvqXdiC9VgbFa+EjPhxpSzeekfueiuS7NefEZLJcPlCOM0Q9oHbnFoD9spzk6xmmMwGKtSAG4pMTZGnGoF4O03GldMhKoHtWiXIvYiFH8GAY25cvtoHNXqpXdV1aYm2e9/k9Eq/L1bFk6V/BKe4EiB0G5vB5CJd7XuiwD8ZmuiJ6BqXVsd1Bvgu9wAk2IQeUwTVmvDaSiLMFyvYB9h0PTVKGcGcrG8S6NUgly4ndt4IBUv/O8hI5cifg70+DnQ/UdcJZE/ECs81IafGl5Xm4lsb6RCbqca3uxlH7ie9oqdvnhrL+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(346002)(136003)(376002)(396003)(451199015)(2906002)(86362001)(6506007)(83380400001)(6666004)(41300700001)(36756003)(5660300002)(44832011)(186003)(6486002)(26005)(8936002)(66556008)(66946007)(66476007)(478600001)(6512007)(2616005)(316002)(8676002)(6916009)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fKVpwTtVXOTKE0blQluz90RcAQ6CE7KtCRfsUsBKKkT+/IZcvk2zYlcD6XLu?=
 =?us-ascii?Q?wx6GMtwEXnSDBZxEyUoIzASb2I1x4IxklVbweBQqPkfkQCyoQaVtRNpeTD+b?=
 =?us-ascii?Q?ZqzWudzVT780s2GVBgzOdpTnnsiLKdD6UkRkiPrNXRpdpkBd7+cBJ3lV6fH+?=
 =?us-ascii?Q?bN+4CEEv7Pesyn6ZydWEV31wlxN+U21JMFb+rtd1yzHw93d7A6OaHaJP2ul+?=
 =?us-ascii?Q?HKfOhpoBS6yHqx6j+v7le2GbjC/mN7ddLKc4hluDRCbsoA8zamF5YiZsMai8?=
 =?us-ascii?Q?W8E4yFhwQi42DlVt2pfCQ8+9E6hTYEtieec7CvbYXNIC1jweMTvt0bDpBxCS?=
 =?us-ascii?Q?j+ZGvbbVoBmHJS+GYfqjrl+8kzYOvEJ5wNxcYGv+4tE2GsFqbWT7eZccvIbQ?=
 =?us-ascii?Q?x2CzBPeHqVxqIbpiEI6yJuA9h7ilxn42OM0d95qDfK8u+OJkevwT0kRdqbb0?=
 =?us-ascii?Q?nXZKjN9pSDeQ8BA/tR3Y+M6zC8mXg3WdC2hKG69qIMTENIdkmfbHgv97Bw64?=
 =?us-ascii?Q?96wCLZW0sAweuV1xIklMnCSvcpgQ/YHlMAG+qwbMXXgF/qSO4I7KsTVmcxWQ?=
 =?us-ascii?Q?QeHN0szq7b7jXQsotrAJ6JjURjjEmQ9Bbg42+OO3m+R/gnVZvzjxDN7dODkV?=
 =?us-ascii?Q?M2k354Gq0qhajYd1ln5DmGsp9q5FOK6FY3cnM+SuogchNIpS8qB6YI4IRSSk?=
 =?us-ascii?Q?2EFl9hrtOgvGvxTICkjWWMjnIEAMouEvqJtcgASigWly7mxSHVoUOK4p21FC?=
 =?us-ascii?Q?MHYmR0CDjV7gYIRaFlnjEPE7qj9VnYw5fQOj+4oNY9pP/jaKUaOREkD4yFwY?=
 =?us-ascii?Q?EvZpXmj7jCdKbVk1O4ne2AHFs8cVRxLR6gujHmjrYCo1BPnBSPH96xF66OnS?=
 =?us-ascii?Q?rPmzDLQ8kbd2YrNKMs0G8ISXroG28FfBz15ydpZambxRqh8H2P/fitmmdvct?=
 =?us-ascii?Q?NR6/WnPHWKlT82Uep5cHvBbkMJ9JTtLOylzUMKhlyj5tsVzWSixEugmBYVtZ?=
 =?us-ascii?Q?LsjcUM5HHDOw8Y8/RMGG29WVNit1n8qRXXwTYKB/DZmcumsW2JX+CYfaIXKj?=
 =?us-ascii?Q?M1ZECTszyuDolueG7o89xxEAZOQCN/ZnFMNrCEsuKqUa0ZAys+B3Qug1XYNa?=
 =?us-ascii?Q?KFv8pPk05/oYohRF2cQJlg24ILS5QWlEGzGPCiwuIiwq8uu5yJnBZyICluNP?=
 =?us-ascii?Q?AMR9rbwuKEU1Yen6xEuYMCnoO6baOSFC3RxMCS/7iM56ljltyH0pWMuqQie8?=
 =?us-ascii?Q?F8fk7pEg0RLJDgOME+xEwDtHeaXmwAfP92p1RQTrmC8ChlxmFUur5GYPuljb?=
 =?us-ascii?Q?/duWIUvvGFtPsZTzeJbbV1T1A5EP0wRduFmdri6H5NzI9Qmy+9yliJJgCvof?=
 =?us-ascii?Q?2aihKXxUmbc7BqPC88cBx+zv1fn/BA+cr4SKP2EqGjAqrgfBF8ZiXeEnYesL?=
 =?us-ascii?Q?tzTJcYYN4AQV7bX3dqgXfPfsUmyEeAAaEnFqfeIFnzqjgbV8S+hglmAX9BRz?=
 =?us-ascii?Q?Y492J2ZLeR0sA71aN4KAoJ8T1L6iFuZtphB6Hda2C9PsPyLPYgp+060oDKfN?=
 =?us-ascii?Q?9OxcEvrpBP2phFJi0WKxhTMifv/jdBgYwtL4zvnI1nkLAroDh6To5tpFkixn?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RdpC/KQoW81+z/ajwGPP53QlHtApx13DkoFFV8mb1HQl8P51grLyC6PnAjtpOtgEhIJ1TBpBnP4qwwAw7qSgY53wtXp2iL6wIfSZJdcSCBKDx2FpEC0JNJTTNp8R6IrIS18Uri5Voa14l9tJLiyW3CujmqTRUVHmByf2JBtQTiIBg8BHcCVFCXdSGmj864+phsrr6GOPgeQ0ArTpeZeRbm53wvi500/HN8Fqb3DapDAhMUuyuSEP35aiDDocvBFy0PwMoiyrsK3ZAW480sgN+JXlEE+3DkxGaaFTS0hD7M9vCNaMZb3UVPijOLO/2TNPGY16ZIX/xCDaUCHl5NA4h3lgZdcQQAtnmIt0+Nkl82Fi1SqsL6IaT75UthAs7DH2f5IXVWCuFIndbIg7v7hHSYakzU5PY4tzRv2velr8uJb51QVOME99SvXg1pxy2mV9t1neRXOF5AzvbefMXO/2cCC0geOslJ5lss9l0ngH3eNhOhaYDbDd8EHE8vVQmEXKDZg3CF629LIdn11wijMz9XjQ6PJxEpLWNAKEM/q/bSohJuO4DESWxrEgYUy5unF1KiE6DjWwax7FPxpxC00/4T22BPBEd3PKU0HrhEL2NoKNkGypzK4xHJYs3wpN/6hqDpaob7Iext4L8BdF2cu8gDOARa9lT2pwBdt7n07Yn0ttXEh63DcI9iW6XP+pFZLQeO6QHlvqrESsXD7Rvqu8GdDgnZFF8/5b4aLhixpcWm+AhDTXDZQS+WjAakGReIzv0hcxHDqQxHmCLdP9QL5eRA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39137ba6-ab87-4fc2-edc9-08daf3965573
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 05:40:23.1901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1kgUwH9UQY5nh46RPXGd3unDW6EJlaYOmMGBVjZl9HCHwLAKg6VmNslULMHyAgALXIX4S+xa+G2SsJnS7WTdBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5308
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_01,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301110043
X-Proofpoint-GUID: jh6L4uB96vttVC9Y4aPai8UoRlD4zlj_
X-Proofpoint-ORIG-GUID: jh6L4uB96vttVC9Y4aPai8UoRlD4zlj_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we change runtime features, the sysfs under
	/sys/fs/btrfs/<uuid>/features
render stale.

For example: (before)

 $ btrfs filesystem df /btrfs
 Data, single: total=8.00MiB, used=0.00B
 System, DUP: total=8.00MiB, used=16.00KiB
 Metadata, DUP: total=51.19MiB, used=128.00KiB
 global reserve, single: total=3.50MiB, used=0.00B

 $ ls /sys/fs/btrfs/d5ccbf34-bb40-4b4c-af62-8c6c8226f1b7/features/
 extended_iref free_space_tree no_holes skinny_metadata

Use balance to convert from single/dup to RAID5 profile.

 $ btrfs balance start -f -dconvert=raid5 -mconvert=raid5 /btrfs

Still, sysfs is unaware of raid5.

 $ ls /sys/fs/btrfs/d5ccbf34-bb40-4b4c-af62-8c6c8226f1b7/features/
 extended_iref free_space_tree no_holes skinny_metadata

Which doesn't match superblock

 $ btrfs in dump-super /dev/loop0

 incompat_flags 0x3e1
 ( MIXED_BACKREF |
 BIG_METADATA |
 EXTENDED_IREF |
 RAID56 |
 SKINNY_METADATA |
 NO_HOLES )

Require mount-recycle as a workaround.

Fix this by laying out all attributes on the sysfs at mount time. However,
return 0 or 1 when read, for used or unused, respectively.

For example: (after)

 $ ls /sys/fs/btrfs/d5ccbf34-bb40-4b4c-af62-8c6c8226f1b7/features/
 block_group_tree compress_zstd extended_iref free_space_tree mixed_groups raid1c34 skinny_metadata zoned
compress_lzo default_subvol extent_tree_v2 metadata_uuid no_holes raid56 verity

 $ cat /sys/fs/btrfs/d5ccbf34-bb40-4b4c-af62-8c6c8226f1b7/features/raid56
 0

 $ btrfs balance start -f -dconvert=raid5 -mconvert=raid5 /btrfs

 $ cat /sys/fs/btrfs/d5ccbf34-bb40-4b4c-af62-8c6c8226f1b7/features/raid56
 1

A fstests test case will follow.

The source code changes involve removing the visible function pointer for
the btrfs_feature_attr_group, as it is an optional feature. And the
store/show part for the same is already implemented.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 45615ce36498..fa3354f8213f 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -256,28 +256,6 @@ static ssize_t btrfs_feature_attr_store(struct kobject *kobj,
 	return count;
 }
 
-static umode_t btrfs_feature_visible(struct kobject *kobj,
-				     struct attribute *attr, int unused)
-{
-	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
-	umode_t mode = attr->mode;
-
-	if (fs_info) {
-		struct btrfs_feature_attr *fa;
-		u64 features;
-
-		fa = attr_to_btrfs_feature_attr(attr);
-		features = get_features(fs_info, fa->feature_set);
-
-		if (can_modify_feature(fa))
-			mode |= S_IWUSR;
-		else if (!(features & fa->feature_bit))
-			mode = 0;
-	}
-
-	return mode;
-}
-
 BTRFS_FEAT_ATTR_INCOMPAT(default_subvol, DEFAULT_SUBVOL);
 BTRFS_FEAT_ATTR_INCOMPAT(mixed_groups, MIXED_GROUPS);
 BTRFS_FEAT_ATTR_INCOMPAT(compress_lzo, COMPRESS_LZO);
@@ -335,7 +313,6 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 
 static const struct attribute_group btrfs_feature_attr_group = {
 	.name = "features",
-	.is_visible = btrfs_feature_visible,
 	.attrs = btrfs_supported_feature_attrs,
 };
 
-- 
2.38.1

