Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5780D7B5F84
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Oct 2023 05:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjJCDqx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Oct 2023 23:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjJCDqv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Oct 2023 23:46:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C030AB8
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Oct 2023 20:46:47 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3930iurh019783;
        Tue, 3 Oct 2023 03:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=rJwQwH3XgjCPlb/9XP8Cmy202hutPhGE7FBSc6jxc5Y=;
 b=HoURPxGHdH+D+72Ykg4H31gyZc6mNb6x3qgefBoJQHLLrBnt7BU43BdxdxJV9MxK1lu2
 uq1+DcSHpV+5NEvMtZUspzX4qblINc49AMnuYD0Y2TqJv6j492+fPNxUVgcBO6c5xHZs
 hUFHL8+voqqDQba9Uhqn16qrAbzRrh/+Y/b1vj9iZmIy8AwORygOltMDFI4PHC3ZMrA5
 tWVJiZgYOWuxROjoHXWK3jPT/+mG1cyhZ479bROIEGi5WQvKpmM8i8j6h3d8dTvOmQ25
 a6zaV4TjvIwBbsvv66sfrXlN/RLrbXEGuWqOat+kbtHs2dW4iASGe81B+XnLniYXQ+AN 8g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teaf43t7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 03:46:37 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 393328iK005824;
        Tue, 3 Oct 2023 03:46:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea45djkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 03:46:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oedTS2qS5OsxFVTeL3ZFgyl4encYj3AqWkG/kfNhobLVctQFGZwHwMcXowFBuSke+cs7oqJvU1UbNO7+XWJRhf9+lOk+ZHeOfNZRtIZ20YKYgGLrefaapIQHJW5M+RUqVsBP1bDisbj76HKcsZttL2M1KfvWB628L+avv+sZcwb2yRWvwvp9UI70nw9bw3BHai8lijq/8i+gwHHc7vY7iX7WHARKDpukkGeOdo81D/EsAlaUQQNqtD69pm1u10XDWYRu737sJiKO5+LSqv5PWlFKZAF9X4eG2mnV7eH1FjPnmZhMQP18ejWutVhwKyOLyk18z737dahKhq61vkAp/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJwQwH3XgjCPlb/9XP8Cmy202hutPhGE7FBSc6jxc5Y=;
 b=Q8m1dW9EJH2M9adXYFI8Z498i7kzgWIAnxuaxGIbEasiWm27uP89IJva+EwjB59kp77ZLYMLA0EP9s4gw4e2JEVqkOXRpPbYrnBooqkvRNaxHim4tQQIKLFbqGvgjIKjeO+yrjAAIxvgnwDvXzJ0TWPFMmvVTto8K7EcnENR+31nZ5Vd8Am/vYO3OKfDgQK1fWpDNJ3LcGOao3vMny3k1eACaaFrbcavZ5nwOmFF6KGrJFtPPgEQq/jojmcvT/ipzSPrRW4MHoM//7ZFDDPkjasgt7bBHrX6KQI8MELze0mq4xmzLVSKzHnyqFX+bSwkVzIfURKpZoozkvuLoav49A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJwQwH3XgjCPlb/9XP8Cmy202hutPhGE7FBSc6jxc5Y=;
 b=wK8J6hNVW+Ik8wpxpumDkpZtIN0IxF2MmVldeDyCuAr6hTqEmdHFS2+wP36sxofrKkZK81Nuzhehrfifmm0n2FY39L2cyLEoy/B4gzY2N57pOlfoicVGvjk0Qu9QQ0Je3nOyI74Ic+vJ+4U4f+beEkzEg4EilhDZ207FIgvJU1M=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4511.namprd10.prod.outlook.com (2603:10b6:a03:2de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Tue, 3 Oct
 2023 03:46:34 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Tue, 3 Oct 2023
 03:46:34 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, gpiccoli@igalia.com
Subject: [PATCH 2/2 v2] btrfs-progs: add mkfs option for dev_uuid
Date:   Tue,  3 Oct 2023 11:46:14 +0800
Message-Id: <83954cc64b45bacb8e02835e8704234e998b3a59.1696304039.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1696304038.git.anand.jain@oracle.com>
References: <cover.1696304038.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:4:186::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4511:EE_
X-MS-Office365-Filtering-Correlation-Id: 459f83f2-9271-4300-f39c-08dbc3c356a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iUp4H0gJ43XxKchCtvl/3N0jpcaPDXD6AP/XUelylw0wvDwC/kRJ+536XTALSYoH2jF1rSl0D1dZfVq8Rzy7Jo1zUIdDjWlbM9M//YJ1I/zlV0l9OYrloqKOP80Sinlo3A/cXrsXztToHOHNavaJd5HZUu7znVy9Q39S49vYZ5goiCUmAzNnmU7hf3DVUWkvUhRMSm5yNqnOEYZpB5iNDeEZI4j9T0aR9WDXiKvTFl2TXxbjpJz4j04p0rM2U16qmI99/zJU/9oMRFL/A0w8LfDHh5F4Gn4Ftd2XyIeV7hGmLbWK5k9dwNZkysa13jd0RJdMydzS9oyx2TOwgPZpp9iEo2pp/aawL0BrD6wc15oMp1FI0mwaBWO+dZD3ULIKyNaZY8pwVjv0DjuEl4v361uHP6bvLjPCWUjG4QnZ44RHWw+zBnzPNGH91VkY7/tch1b0rc0c/5BxM5e6AqyBIcyVWZ3rA1JOCac1UVVcpYchpQP2OPjj4JaEnNs2v5WwbDyxuWQ93LLyiGMkKE1xl+ZJIi1PLbmfJyeDuW57rJ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(366004)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(8936002)(41300700001)(6916009)(2616005)(86362001)(38100700002)(6512007)(66556008)(6666004)(26005)(83380400001)(6486002)(6506007)(966005)(478600001)(66476007)(5660300002)(8676002)(36756003)(316002)(2906002)(4326008)(44832011)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MlgxvqO6lLuw2/UI+h9qaFQDqXa6JgWJkIq4T5UDo15GOely5HsQENRVDTlH?=
 =?us-ascii?Q?b+vz1DnVuqtRa6NlH2CHjZfHpQ1cJv1RbJPLrG84SVq/9dq42YLpNeKIQIv0?=
 =?us-ascii?Q?uh1fd0eUVL/XCBHRXhTeVxAYgZC6ua3jiotRz7WfzVU0b3lNlo8cLzvDH/1x?=
 =?us-ascii?Q?e/azenSGMnGdWjKaMOJz34vawPt1xiwQt831MaovLbt8R0Od8AwUH70DCVdT?=
 =?us-ascii?Q?N00YJ8LKBR5PTuPB+ZiOJoQy16ckKfl/drZKgJjx2dztNDQZSjMKp646GcHp?=
 =?us-ascii?Q?msnw4kSmGGQq27knx5XVwyN2MrV/93WY1IAjLY9/nloUHAM+d2uBhx+2Mhxn?=
 =?us-ascii?Q?g4/emPB0d3dU+kDS9qPkeCH3SuDn0KUAoIp49OqA+aBSrp8ykdGvxSRwnZJz?=
 =?us-ascii?Q?Bo6TAdVVshJvOzHb4sQ/+E35ygWNYeeM4IJzbLihQ4IytUnMzBi+bUUTCqSY?=
 =?us-ascii?Q?94jITQfcgb9mlv5LtM46T8mVacFJi7fPATUxKaHP+zxU7Evh2Y0AhtXUyhdx?=
 =?us-ascii?Q?lZMHhtjaZHEsyBXUZEKuimewRFmZyjSPx3zHh7sXN4wqVUXMwrvNquMp3lkt?=
 =?us-ascii?Q?QAP1qmNB1jEKeGjor9TLgLADiefCAYtD8wQvao8KVqV2YlkorMq9OYk7ZKGO?=
 =?us-ascii?Q?H7iPW7KTBudzyMby0AgzisYnjYZZJdacdKeHiuyo9e/y3HE+YzWTw6nAWYXB?=
 =?us-ascii?Q?dts2r+f7IXY+v0pPjlTMD7UnpUYAxyNeLavJbVWmzqaRpd0z4PB+Fe398k3l?=
 =?us-ascii?Q?RRjqUvLnNZT24AnLmLLZGYnYY7+yNqHU9m7BWI5VgaD+FQXuRFLn0pl+t3gj?=
 =?us-ascii?Q?Dp6yUyhbbzy09k+edER5EEC6xeZoiJKXQNx9QYTOiMArxUTpATJD4+Ai/WKG?=
 =?us-ascii?Q?1P63744cvEx8ZUzqdfILanyDnTmNq37jji4mdJOay97bUsQPTg4AbSirt+Kn?=
 =?us-ascii?Q?vkEIUGvM73emedAbxiAF8piWsCXk4GGoMZxoXPk/xwzqI52ORFdTcDByFjPe?=
 =?us-ascii?Q?NmPzE1B92cVkW1JKaE1t6WXcAcn/xRGvS3ROQ3SE2HPC7nWesNCfrPl3AQFH?=
 =?us-ascii?Q?RIbuzDuW3OqQk1j1xhB6/SjhyK25u0izGhBAvBoaziY7Z5wVUc99UgEq7fPM?=
 =?us-ascii?Q?DcbkR85ruq6qpUDl6RiVZrF9uvxUxlzIAgchl1+ovwVfcb9tzEumOJz08MOc?=
 =?us-ascii?Q?mNR63+/9NPbg/TyMl/vmCjBj1pcA5guDXHKdjlh8aidUnVW8Mnuu8UcvFqmg?=
 =?us-ascii?Q?rvSRWUKmyC9h5PaEb71vtwzgEuN3Vb3El3uD0w7JwUKEtYDvfiST2LgziPqS?=
 =?us-ascii?Q?ZfVqELmFV0O+pBI65w/S8Xc3C2ReCrs+709koMitV1nJxO1WxHJiw4Qg/uI2?=
 =?us-ascii?Q?nJgdH4oPG953mWSTFokAiT6vF4Vfm8otjI6DdD9t4gw6etSUbpu9QL6OpG8D?=
 =?us-ascii?Q?6cb64PZdgscSRCaqBYDa/P4/TzzRpiFaKKD/yxj4gPozxwhFd4pQl2PfeD++?=
 =?us-ascii?Q?2nJg8mkmLfCOPRlovC6FJquk3hjUgNu/3+cDGccaGJSm6un7tJ1VgkcyHPHs?=
 =?us-ascii?Q?kesdsQZdyCcc595P5VkSj7jYvc0MGfbAaRjAWuuf6Ia//Y48HNWo4KSxta0Y?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EBKo/op6NjmGGDN+dE+8OC4Mgq6aIrDe4rhjw/Dqb5Ed/8wcdHFZIiiOnMJWzFFfyhcmXTsjtp9pvWUL2Jzvfa/OrGxQlNB6t1xxS8xdxky/73RqJW4lVELp5b0yOpXgCl//5VI/FyRnB4VFRiXYpnSOm/OOt+Pzh0us1t7NlVU6KP11LEy1Hvg1QFjgBCbs6QRBvD9iinR0p98575CFZ05poo+fzinJH2ChKnx1URiFViCbqn54OI8vM4F1NCUkUv79ae/JZ8EqSXjmWVqRcdGO2FSFod4fJdX6GHUl4eY2wtH+mevqFqU3VtFIX6uMV6ZB6ittfxi6LKXvLZQ9813xbZNf+pAa5Fop0eAImDOXo9h/tot59w1fGMA+J9o5pE3o0HMBFGin4GLnU3vqf+5vEUHdQYx0M1Q/Rz3A9zLmUHf68KEHKG2EwGY5Whglqu29jhiYEUPTtByRO6CgC2C+glsyMd0FJIK6sIGqrMVUhz6zVE9jLuVST14SvCx4w7P9um4+RaaNg7srV9T/0tc/ymH+tBsLgfx6sNTCUVdhh6mVmDjnXQD0r7gm5fhfDo/L+ePdb76nkb2IbupL4BQEo78bIDfyKof/m7yEVb1rOmtjr59Ocv7aBGD7uI/uovQVO6ti9JnmT/SGQcV2ByX0d6Zjq9MVjfbtmC9d3nNS1wHYKefLMMfkNf9IrpP2tV9bc5OgWyKA2Q+aY7x1MIOLklpZwY7cu6wRBh+hC8o/f5SfzlPpB/qsieZ0rnO//NQEQ4TmkCMToX4mTkk+17vBP4xNEWJKOQZDEDOw0jpOvXjcc2vMj+mryq6ZH3gc
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 459f83f2-9271-4300-f39c-08dbc3c356a4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 03:46:34.5742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+jJ1AyXXlnjnSAIjfPGVPaHyxNJgDKQ9Phee8mkDC0pz2zDWY9f+/D7ONDjl1Gi0507hFmQ75pUpJOKZYVdTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4511
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_16,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310030029
X-Proofpoint-GUID: lmM5nCn6erlNzlToUFNUvm0PVorHgV1w
X-Proofpoint-ORIG-GUID: lmM5nCn6erlNzlToUFNUvm0PVorHgV1w
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add an option to specify the device uuid for mkfs. This is useful
for creating a filesystem with a specific device uuid. This is
useful for testing.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2:
 Added --help.
 Added comments for the dev_uuid and fs_uuid.
 Removed short -P option instead using only long option --device-uuid.
 Add error if --device-uuid is used with multi-device.
  For example:
   $ mkfs.btrfs -f --device-uuid 29e708ad-6fe5-447d-8910-a9b9f79854b5 /dev/sdc5 /dev/sdc6
     btrfs-progs v6.5.1 
     See https://btrfs.readthedocs.io for more information.

     ERROR: the option --device-uuid is limited to a single device

 Documentation/mkfs.btrfs.rst |  5 +++++
 mkfs/common.c                |  8 +++++++-
 mkfs/common.h                |  5 +++++
 mkfs/main.c                  | 14 ++++++++++++++
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/Documentation/mkfs.btrfs.rst b/Documentation/mkfs.btrfs.rst
index 95ddc5399090..919bb19c3e0a 100644
--- a/Documentation/mkfs.btrfs.rst
+++ b/Documentation/mkfs.btrfs.rst
@@ -183,6 +183,11 @@ OPTIONS
         you can duplicate the UUID; however, for a multi-device filesystem, the UUID
         must not already exist on any currently present filesystem.
 
+--device-uuid <UUID>
+        Create the filesystem with the given device-uuid (also known as sub-uuid) *UUID*.
+        For a single-device filesystem, you can duplicate the device-uuid; however, used
+        for a multi-device filesystem this option will not apply presently.
+
 -v|--verbose
         Increase verbosity level, default is 1.
 
diff --git a/mkfs/common.c b/mkfs/common.c
index d400413c7d41..e9a2fd5e4d3e 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -340,6 +340,7 @@ static void mkfs_blocks_remove(enum btrfs_mkfs_block *blocks, int *blocks_nr,
 
 /*
  * @fs_uuid - if NULL, generates a UUID, returns back the new filesystem UUID
+ * @dev_uuid - if NULL, generates a UUID, returns back the new device UUID
  *
  * The superblock signature is not valid, denotes a partially created
  * filesystem, needs to be finalized.
@@ -435,7 +436,12 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	} else {
 		uuid_parse(cfg->fs_uuid, super.fsid);
 	}
-	uuid_generate(super.dev_item.uuid);
+	if (!*cfg->dev_uuid) {
+		uuid_generate(super.dev_item.uuid);
+		uuid_unparse(super.dev_item.uuid, cfg->dev_uuid);
+	} else {
+		uuid_parse(cfg->dev_uuid, super.dev_item.uuid);
+	}
 	uuid_generate(chunk_tree_uuid);
 
 	for (i = 0; i < blocks_nr; i++) {
diff --git a/mkfs/common.h b/mkfs/common.h
index 06ddc926390f..554693b52aff 100644
--- a/mkfs/common.h
+++ b/mkfs/common.h
@@ -90,7 +90,12 @@ struct btrfs_mkfs_config {
 
 	/* Logical addresses of superblock [0] and other tree roots */
 	u64 blocks[MKFS_BLOCK_COUNT + 1];
+
+	/* btrfs_super_block filesystem uuid */
 	char fs_uuid[BTRFS_UUID_UNPARSED_SIZE];
+
+	/* btrfs_dev_item device uuid */
+	char dev_uuid[BTRFS_UUID_UNPARSED_SIZE];
 	char chunk_uuid[BTRFS_UUID_UNPARSED_SIZE];
 
 	/* Superblock offset after make_btrfs */
diff --git a/mkfs/main.c b/mkfs/main.c
index ccab3c31b2f5..e92b43846217 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -431,6 +431,7 @@ static const char * const mkfs_usage[] = {
 	OPTLINE("-O|--features LIST", "comma separated list of filesystem features (use '-O list-all' to list features)"),
 	OPTLINE("-L|--label LABEL", "set the filesystem label"),
 	OPTLINE("-U|--uuid UUID", "Specify the filesystem UUID (must be unique for a filesystem with multiple devices)"),
+	OPTLINE("--device-uuid UUID", "Specify the filesystem device UUID (a.k.a sub-uuid) (for single device filesystem only)"),
 	"Creation:",
 	OPTLINE("-b|--byte-count SIZE", "set size of each device to SIZE (filesystem size is sum of all device sizes)"),
 	OPTLINE("-r|--rootdir DIR", "copy files from DIR to the image root directory"),
@@ -1161,6 +1162,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	struct btrfs_mkfs_features features = btrfs_mkfs_default_features;
 	enum btrfs_csum_type csum_type = BTRFS_CSUM_TYPE_CRC32;
 	char fs_uuid[BTRFS_UUID_UNPARSED_SIZE] = { 0 };
+	char dev_uuid[BTRFS_UUID_UNPARSED_SIZE] = { 0 };
 	u32 nodesize = 0;
 	bool nodesize_forced = false;
 	u32 sectorsize = 0;
@@ -1187,6 +1189,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			GETOPT_VAL_SHRINK = GETOPT_VAL_FIRST,
 			GETOPT_VAL_CHECKSUM,
 			GETOPT_VAL_GLOBAL_ROOTS,
+			GETOPT_VAL_DEVICE_UUID,
 		};
 		static const struct option long_options[] = {
 			{ "byte-count", required_argument, NULL, 'b' },
@@ -1208,6 +1211,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			{ "features", required_argument, NULL, 'O' },
 			{ "runtime-features", required_argument, NULL, 'R' },
 			{ "uuid", required_argument, NULL, 'U' },
+			{ "device-uuid", required_argument, NULL, \
+						GETOPT_VAL_DEVICE_UUID },
 			{ "quiet", 0, NULL, 'q' },
 			{ "verbose", 0, NULL, 'v' },
 			{ "shrink", no_argument, NULL, GETOPT_VAL_SHRINK },
@@ -1331,6 +1336,10 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			case 'q':
 				bconf_be_quiet();
 				break;
+			case GETOPT_VAL_DEVICE_UUID:
+				strncpy(dev_uuid, optarg,
+					BTRFS_UUID_UNPARSED_SIZE - 1);
+				break;
 			case GETOPT_VAL_SHRINK:
 				shrink_rootdir = true;
 				break;
@@ -1372,6 +1381,10 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		error("the option -r is limited to a single device");
 		goto error;
 	}
+	if (strlen(dev_uuid) != 0 && device_count > 1) {
+		error("the option --device-uuid is limited to a single device");
+		goto error;
+	}
 	if (shrink_rootdir && source_dir == NULL) {
 		error("the option --shrink must be used with --rootdir");
 		goto error;
@@ -1730,6 +1743,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 
 	mkfs_cfg.label = label;
 	memcpy(mkfs_cfg.fs_uuid, fs_uuid, sizeof(mkfs_cfg.fs_uuid));
+	memcpy(mkfs_cfg.dev_uuid, dev_uuid, sizeof(mkfs_cfg.dev_uuid));
 	mkfs_cfg.num_bytes = dev_block_count;
 	mkfs_cfg.nodesize = nodesize;
 	mkfs_cfg.sectorsize = sectorsize;
-- 
2.39.3

