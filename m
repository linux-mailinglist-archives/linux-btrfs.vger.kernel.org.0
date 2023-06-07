Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E59D725B2F
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 12:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239870AbjFGKAS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 06:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbjFGKAR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 06:00:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51C11735
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 03:00:16 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3576Jq8h026210
        for <linux-btrfs@vger.kernel.org>; Wed, 7 Jun 2023 10:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=rZRLSuZD/mJHZYqyasxuvJ/uZ9NnS1RtlEB9CLMOHxQ=;
 b=O/P9oUnk7fqIiAGrzysG8ubix/4PjxU5S/YT9nUdrmj77cwiAjKi/NLyveCKh0S5P3uq
 6rAA99jnHQmfT9pnt4Hvd3q6dWT7BjYTre8Z0kk7HoFwUmSlJVg/etofqHXGfNJepaPd
 Ep6sHM4kjp6DaVG9gi9XLXersCGX9NynnGkBzOi4iCKehvqa13cNJsg5BoZd1mEq3MXg
 3hYamSW28Cf17CaQ9dzSB/U8BdnX80qrgfrN6Yiwv3TC8ZG7CX4ez1MVrbPdhMxcIBdl
 O3WByQCUkNsXcXrcJO2ZXIOImEyzeBK1sgKlqdva7NubIZL7YS1gULdd5cI5uxnKfCIP KQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6r9cwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jun 2023 10:00:15 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3579dWkP002962
        for <linux-btrfs@vger.kernel.org>; Wed, 7 Jun 2023 10:00:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6k1dby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jun 2023 10:00:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTq8K0ZZkGTtNcL8KcwNY28HqaddGzoufHvigLNPr/DngqcMsXh82v+WBZeY4FE3BXEz1F7nVFGCxNB1YXanSrnXQtbKIiG7M8pAzCbs+h7a3hjLaGOLmRgr/rxUKTbSowsXvFxgNvtltKUIOoeOnJ7qlW1tQcmsd3Fc9LqMzp9XH8shzZtscb9JumTysolCk+tZ6jrBBNwcj6aQgcCpvODfNLfl1PsHejcJT7wPG3YbwZHC9YBVw863JKOVShx62poGu/woUI1UqE/c6qPHRD72QYwjwcoZzmF1ZkZwzm3KRxDl+vJt0tzZ8VvdmlM1s/LLZbQCVG5WbTWSFif+3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZRLSuZD/mJHZYqyasxuvJ/uZ9NnS1RtlEB9CLMOHxQ=;
 b=n9a47/oZZQsyjIxROTz9t5otRq/e3tXNTzcR2Vyc9bcMbNKA/fPlvoOzcfVHJ1p7y4CbqysDSb7BRSjV40RpK/K+jOM4dk3zRYCydZuuw0isaUr1EoPhAVPCqKPyxOFi5ci9J6WPOWeA84QYt+koDL6TmAC5DFUQQSLstktu+aIZfiC1DEmC9hq3ZuRQtG/uj+0P/hrAf3nqas479kV6inuj7qZ2h6+pRph43Z6sWzFpkGOpc4dHrAHPd2fDPsoBghU7E7Vbjk79JHF32VVH6yZxCz7RieLavo7BPdc8YFBez1RqTY1Iz3qCubu13/Q/UHsBWZLOGBr0zJ6JRgQA0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZRLSuZD/mJHZYqyasxuvJ/uZ9NnS1RtlEB9CLMOHxQ=;
 b=H17Hsgzc4I57GF+8/Z9VyZqvyA8hrzKvQ8EdVGHEV5p/eeEeJFIp6x7ZHVGQUANczjYRS0zS5PpdwWRPd4BvYkHNvB18QZ8NJLOo2EpdhRcIEVF3fPB568IFK1iPUpTuSnxpSzPaFtbZ3y2iT33XTOrYcne7xioGuAcl0njy+yM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4762.namprd10.prod.outlook.com (2603:10b6:806:114::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 10:00:13 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 10:00:13 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 05/11] btrfs-progs: simplify btrfs_scan_one_device()
Date:   Wed,  7 Jun 2023 17:59:10 +0800
Message-Id: <98d656a7febdd9248109a4356e72773fbf34ee36.1686131669.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1686131669.git.anand.jain@oracle.com>
References: <cover.1686131669.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4762:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f77d98c-f394-470b-0bc7-08db673dfcb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LJNBhCN3cBdES2xrknWSManAjF5Hm75AKwUcsy/CDoGd7zR6eQPEVmFpO9TuuU3OGz9rXDi0xEA0sJh70TB8SuNIftRrcGXdbtZl//eWMQ/9jjIxwJsKnjbaF/ShaeurFyM6Mol8/++Pf5jg6Egt9/nETHdHAdR94jOalC8Wl2KWPOgm4fQTpz0JpUO1vMqvC8VSbbPMEcnxBQl2qQFTNql9Zxk8q8yIcLcU0iF9ZysOMEJFu4Bm5kjJcroVmNx2lpenE6EXga0XmyGPiAdzUe8m9Wrng8s3iFkIKp6abPC5/9Nc8k3LtxNxvz3ojp27lAF2WxWfldxUKu5sFh8bsD7UjnUBIQuLXEEW3jboMuqTihGtRfZjxrUbFBLgtBxu+iJ17Yfin0dH8WGcRLqfeiqiPVfeaM+9YKocVfH2wMhrBk7Tn8W5wbk9CPcmEoGqbdXG9QsnzY1MZk4FzOnOgpNQSqorC6NedIL+wQPYlQcowyH4JHooy7Q/tl/v1b5NhpQEBv05viiSYsb5gfDW0pHbMD/Iees1zA8JG6VUFmhmyzeTwTMj2y0nEPf3urdL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199021)(83380400001)(2906002)(2616005)(36756003)(86362001)(38100700002)(41300700001)(6486002)(316002)(5660300002)(107886003)(8936002)(8676002)(478600001)(66556008)(66946007)(66476007)(6916009)(4326008)(6506007)(6512007)(26005)(186003)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UM2NCGfFvUv4u52BT0BlxUcy38dNGuObQZFJDKW36Jbv93h3bAV+7kht3kBb?=
 =?us-ascii?Q?/4Ur9UrH9j1bcPNvv5QsePkPQO638hDqR7Qx+i46QOS2EmwSqt5u6tVuPwbN?=
 =?us-ascii?Q?Oa+jgZqvPXAMEkRYeMSV09Fy3FYZhdoV+jJ9zLdXpVInfLCjFU+o9zmHvdN4?=
 =?us-ascii?Q?GNiZnBtdyUIQ4B3srs4saTqICrD0LFZ+AZI5f9OIW43rKYhwJub18HsdW1sR?=
 =?us-ascii?Q?Os91YGmaJxKyJKGay+810ZjWLElx8VoDmANBPe6Xur12J018p6hEFy51YcRO?=
 =?us-ascii?Q?rZ76rAjChcNeu7oYTfdOUnFUvpiYDtXbQo3mnnPTkffjo29YSRkgsrLs6eDY?=
 =?us-ascii?Q?hmAVbQDLKpF3qPsh1CtXnjT1T/VB5PLTMot5d0Jj97NB/wBgyE+pRrLFTx4v?=
 =?us-ascii?Q?iB/X7F+WybR5Cis/db+oLjFo9IsL5blrs0odPwxqAD/tWFL7DYU/DASHPWe8?=
 =?us-ascii?Q?3+Pl60x9sKQ32MtDtCs0vr2AWSusK77b9mEkeMck+q6LIBMplwoIB3N9Gpih?=
 =?us-ascii?Q?SRc90K/88wsvbdXoOcrsVRF4PvVy2fYoTqDW4UccXtNljaL5DUPoaIxc+0cs?=
 =?us-ascii?Q?1tMtOfjGrrUYufC5N+ZPm7+fwHLNsc19eiaCSOH0gT6LsdEYkOXQPvt5bQqL?=
 =?us-ascii?Q?e55srCCNQ/0I7czrMXm1Nou11XZ90NIQcbb8DxGdm37OyJafIMAP9dGajJXy?=
 =?us-ascii?Q?DH5PAS59Kfv/6JNyG6F169uM2q/tlW5IIyNXihINxq7Ca/ilmp34hQuEjXxA?=
 =?us-ascii?Q?F1wKePfgdFw1lOlQvS2CBshZGOrHZpV60ewfuxdbyNtAOKTICXmHyAUvb+yz?=
 =?us-ascii?Q?LgamDN0uhgCzK0jLLW2Hk30f91/HwGyrQA9EfoG4bljv3S65tRqt1LbAr0gs?=
 =?us-ascii?Q?USwt4lbTb05lJ4+doEpT9LtXitegjC7yj7LOSl9aJCcAORmEHsIjtDQIpgHa?=
 =?us-ascii?Q?p/2PigzyVtYHbNyccRyamq/mpTXutJ9SlCpcmPU+2eAV3qvA5wM5ZFnXJ82w?=
 =?us-ascii?Q?CZ3RBa2M+HsXedgzpDtYnbeMgMV9iAW1eLRU4L2e61Qu5iQz7E7/K6MLr7Xp?=
 =?us-ascii?Q?Upd2PzOZ8hGAsKCLs9fO1runB/78BuxCsvfpPxnYytfLJbwy2GVV1uc4YxEg?=
 =?us-ascii?Q?Dw9EeweS42xP2uee6gfclYbVk3p653rNkX05jX0x7D0FMiDNR6hh+tX1nY+6?=
 =?us-ascii?Q?+aWt+FWxfEB1x6617WyuwuS93w+2TKJJXRa7o9muwQQTqR7Zo3d6bZ9ch52o?=
 =?us-ascii?Q?6GIAHTWHzD2A1L0NyeH83POXFaTV6h7G8m2jJerXjRcMb0xmygkmcyeUDfvx?=
 =?us-ascii?Q?ZHmDxhdo9u8Oh5K5RdtEjB9kQgN4QlXpY+30cLdRRmJzjRkSsS7WukCOJ9jp?=
 =?us-ascii?Q?yCqMq7ZDZAn7inIw5wN3ph4xYEStgcYOO9ktdHb9B8Qbh+3NYBigPHpziqfd?=
 =?us-ascii?Q?Gd39N/r26fw4zpQdO3WTmwlebU2f7xOWVW7eVUjx5IXM8VUj08JYWujrbxIx?=
 =?us-ascii?Q?Mw5pmdZIthr4JenZH4vuyFBmrm+5nE6MW5HjS+X9NcU2h8ixwIfXhyptK/O9?=
 =?us-ascii?Q?KLAorr0zjRiWsw8lZ9mjTM0QYoXuUdo09r1G8F3R8XAph9n2auYggojhUDrT?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7XcOBujDUT2suTrr45saKg7QGYmifcBcp2wLwMDkBQiasy4llzPHiN2WSZEQlI1nSFqj87nAySY9v6HYLk4MFDKS4kZnpRFolzeek99MwDvRXdta9OslWuSvpNp/SDVfCM7hwdXDNo9XRDvG45dJ0fa6tU1jyeyN00tu7n9bO5neSzQ6B2h5uzq93jdny1Apd4TSGSjAV1K7I+qaYrfScS/4PaPkp6zEtYReRKD8Tp1Y3ZZbXYRmCmCRZPRK4slu4VZgzFdEXICnChRxqrFembOcZLbD/9gFKOuDHaJFvauu7LzffUmuAXG44SrTS1e40OwmldDQyaXVeDu3jeJGzvlKaESOkPjN1xZ0kBa1H4zJ9LdztVE/hNYDi3TwVIotTm23CAzanYmiwIgHrOL5Ez2ZY/Aay2fe0L0iHyB/zF6tb58QTsqLECj8EP3g2I+PG3QRlNTCRBkIiHyQ/5lbmznBhnwTczhr95oYWr004uiEmLYHm+0xN06HxrIB6kh9mjCbewWsv1l6NEJHqtkHA92tEYJwoN6oPGUy/R6lOvQq6yyP2EoS0yNtPD30ryuiPACIfOnfWfW/CqEsFbj6pZQAGy/nJOnMsETHLl8GwRAkFri636sfzOHOlzDV84wdgBcJl1J6joU4fiMQQH571sqDAs7nFh9Q+GsMQeAK5oH/JGms/t5BwgHe0CvwlpxLgeARlOapmyK9gbAphPdMfsMWFtJGZmGGHm/vUJb7rRA6hSVG+7GQir/ilZ7pzq+uGvOBRoJQPaU8F721oihEBA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f77d98c-f394-470b-0bc7-08db673dfcb8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 10:00:13.4836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZP4O0pdExv0gPouwr1U0yaYEVE3X8FuVgViuUDWwPeVyeCkOhPaP7ljoBV3AJPsKqZ8cdtVpeyK3OuHsTBrf+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4762
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_06,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306070081
X-Proofpoint-ORIG-GUID: IjQZLN3ZuQIH2gAbnFi8Ty5L3FvrAUcx
X-Proofpoint-GUID: IjQZLN3ZuQIH2gAbnFi8Ty5L3FvrAUcx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Local variable int ret is unnecessary, drop it.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 kernel-shared/volumes.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 81abda3f7d1c..c8053ae1c7f7 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -545,10 +545,8 @@ int btrfs_scan_one_device(int fd, const char *path,
 			  u64 *total_devs, u64 super_offset, unsigned sbflags)
 {
 	struct btrfs_super_block disk_super;
-	int ret;
 
-	ret = btrfs_read_dev_super(fd, &disk_super, super_offset, sbflags);
-	if (ret < 0)
+	if (btrfs_read_dev_super(fd, &disk_super, super_offset, sbflags) < 0)
 		return -EIO;
 
 	if (btrfs_super_flags(&disk_super) & BTRFS_SUPER_FLAG_METADUMP)
@@ -556,9 +554,7 @@ int btrfs_scan_one_device(int fd, const char *path,
 	else
 		*total_devs = btrfs_super_num_devices(&disk_super);
 
-	ret = device_list_add(path, &disk_super, fs_devices_ret);
-
-	return ret;
+	return device_list_add(path, &disk_super, fs_devices_ret);
 }
 
 static u64 dev_extent_search_start(struct btrfs_device *device, u64 start)
-- 
2.31.1

