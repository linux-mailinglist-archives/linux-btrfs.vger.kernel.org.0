Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430635700B6
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jul 2022 13:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiGKLco (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jul 2022 07:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiGKLc1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jul 2022 07:32:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BCBDF
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jul 2022 04:15:21 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BAkd8K008365;
        Mon, 11 Jul 2022 11:15:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=QlB1y3XGI3+aQTB52hEuvturZM2kMrSJ1ApXmArx4lg=;
 b=EXO+z4csqf004jWK7TEU00B0DvE+z1jFHZ6VxLZAEBKN9stlOEq7V7jjqOW9TXXXgplo
 n6NBuMJwiz7Z82L8M+71JSxavu3zwQbjZJ4JZvhlm6r2tWMLLwRzJIXTZAswo8sfvGm7
 ywiwRi2DOqdgldm4pTSQFEjoRBbxEq1/XX9uFYVTYuR2zssSXqOhLPV2HTQgeGA6rfTq
 EQGGo7JD3AA7xbKP21NmQidwzQK2F6Qn3LHnJNXR/SVXusM2mAYcdVPXUF+oHAjlf1S+
 huRYkhsfYFFh0gUFFPblHES2siRa0E6a/VvvkxtphmUm9Ufg+PqervetmHK6arSwDfnP og== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71xrb3r6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 11:15:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26BB6gFE014269;
        Mon, 11 Jul 2022 11:15:16 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7041uhxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 11:15:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NpKO23KOstAiN5LBN7JotFloMA1XdjwvRpsn4WM+p0P484qHKUbdIqTYrT9A9DflOroOOxPKoS+y9iwTEXJehWUvTFoU+Uc8hU/OQg3f16QU794iMfdIK26YST8p8AX3nW5xzkQ2D3LlX7jMAb1ZYCUMgJHoxqAqCRvTwuBgMtTawEvzYiN+yZlpGr0neG7hvlZfvaU9JgMxLT3Gg2KyxFB0Fyxvh2usQc+XVnCwJVF+SZThJeecubqgcF2M1NStZgsGin5TF7cSWx75G3JE8WFBZQoM7QFiSAD8j1HQdEW9lfdDKyvOHYQh9be6Lg1ubQU5CnpULLE4Of79VnpOpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlB1y3XGI3+aQTB52hEuvturZM2kMrSJ1ApXmArx4lg=;
 b=iX0XOnUO30U7ddJ2/5p4ikwcFG1ANCU1Hlp+GesI6IEu5RQ8qpMIBXiGcXJWGQfdkGIyDSggbsDNtqsriObT37lUMGNKQLn9CLLhDwX23caU+wDtqGaJ8CW0t7/OjbYNer8HOQd3Iosw6Po5tmDV0epdiz0UXRxOzcW8hZQycpP4yw3kzfMefhNz4CP/InQ66LUp7EHU9NO4Y///udDeM6Obk6ZtT6aqsl5Jfy9Zz51KM3v63zxyE2kUkROLx4p+CAFrKHStibqYJVtOjBhtZirPQi9PpZlzDeE3OWqJsy32bhpDYHyzZGc4oM9E4LC9idSVSb9PNwlGcgY2oAdUlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlB1y3XGI3+aQTB52hEuvturZM2kMrSJ1ApXmArx4lg=;
 b=oqjg+ifDay8eN/fNBGD6qGNHIno3UohvdH5bFxmYKdRB125/tUzSdc0Pmc3j7O+kBUWC1BlFJJEopHaPuI9Y/QQ295JA+EZhJLbeIisuXAgBnQGy/JyZIWlC95RtQH3xmZZHXOLloB+PdBY3jxrjAckiLI3dYIgyj0YAkWgVshw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB5001.namprd10.prod.outlook.com (2603:10b6:610:c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Mon, 11 Jul
 2022 11:15:13 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bcb9:f224:ac37:6044]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bcb9:f224:ac37:6044%7]) with mapi id 15.20.5417.016; Mon, 11 Jul 2022
 11:15:13 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH 2/2 v2 RFC] btrfs: create chunk device type aware
Date:   Mon, 11 Jul 2022 19:14:52 +0800
Message-Id: <007dccb0651ea5d278d88d9f991214543c1a14c5.1657536723.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1657536723.git.anand.jain@oracle.com>
References: <cover.1657536723.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0204.apcprd06.prod.outlook.com (2603:1096:4:1::36)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7a6c003-4406-4f35-cec7-08da632ea04d
X-MS-TrafficTypeDiagnostic: CH0PR10MB5001:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hDbzEJHh4zlwrsRkQ/GzyU6VgYEFoKKVVUp1IISSSGgMBiif3XdOsVuo9pqTJ5ElytnOCEaRWiIHWo9Mc+CsA/0Chx+stSxLPVVBJUJgzA2QkArXEXno7cmsQuG9h3WTiIjqQ0P4gcR5lEoiIx1czUoEWoNjs/1TkyZ5+XTLWCe58QGG5uD2x/3yS+WUG7EG9kNHfyqckvJGiEcUrTtX44dFaUJXV7kvpG3+v0eLeVUE5Kg5vPNjAgrj37oJP4UfXqQIUa/hrzH1ZB5U012as/l56PXhZ8TqLsqqv4qnAe1eIy/rpTsdc8fKATeFXKQZbAivmqRX2Ztp0aaSfB8nn33+YyFWMTaCdkMvOZbIyZcRDT3x59Zf/lRVqOVe1oESruknkmKXiRJSEZd/U+3cjm2dDf8QGsxTwTyFtP1HKvkj/jaKmJgxBbWxdL3nG+Wdcz+pFb1BgTNpv3DuLOpwHTAXWZhXMKCAo9GXYNdTSIpQtMxUSPFdJs7vV1WLmWp2CCktr/JCcucd6K2jsGy05vcTdA3F59ezvsY9auWYWxcqiDDijRr7VYKkf2UqqR5zXPxPfeMQ1RkNXsFep6+kdfcKAamBvr1OpsQT/dec4YhznM33mu4Vslpc8XeQh26kZmL54d8s9M0alSrxgnbARENp8x0t/WN5k8nCiszS5d97kgXVQRcrZzLA25aAd+/28ESOgkEINPiEDdMO/Qj67v/g5K1dC7HbcDAA2UJIjIaUcemp+WittLTgsGJA4R8y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(39860400002)(396003)(366004)(66556008)(478600001)(41300700001)(6666004)(8676002)(2906002)(66476007)(36756003)(6916009)(86362001)(4326008)(6512007)(66946007)(6506007)(26005)(316002)(6486002)(83380400001)(38100700002)(2616005)(5660300002)(44832011)(8936002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5R6RcoYBHxRCQhA1F06a34luYsZ5g1fWlfreQaERw5mRB/1Ru1y3bsDioEOj?=
 =?us-ascii?Q?T3wO3UkiGJ7x4XdX5cU0wZZMbfKQiR02RqoObzh/XpLpkaVaPru71gPe8aap?=
 =?us-ascii?Q?I8OXsJ80lI3IC18/SPCAJeDBL7xhDd2BwfOVV+G6HplChpvUsNZEAJN4nifu?=
 =?us-ascii?Q?AoLSpgCUKR7bmwKfxvRVgZMwXSlW0IfbekuZwOFrvJj221ONBTxOutqJF+hc?=
 =?us-ascii?Q?hnxFlOtrzLAAU3h9gCUEk6kKr4APrRkTxrgWmjJSReW5clGykMRz/DRJhnX2?=
 =?us-ascii?Q?Bdd1zAebeMlq1Afu3HY7eJD6gQR1PIYRgOtUZNOhthBOOffBtIcYefSSnmsG?=
 =?us-ascii?Q?D0L020tr2xYjkcJGeD9OmPfG9Uql8uhgvVlL4sFi+1etJnqQe1IUJuY1LuIR?=
 =?us-ascii?Q?eELLFuWHDk6K6GpLvcVcGmpdzPRBMW2pK9QtIQWvMm0gdsIsXfzzAKLWRV/Q?=
 =?us-ascii?Q?2UyZUQhgY40m5+vYcVeqj/ak3GtZ1EVck44N9kbLQEsns3Gz1bXfqWZ1+Hwu?=
 =?us-ascii?Q?x8fSwVzS1kuar7xZXYjGREu/6EvJxce8LejEVVlB5qz1UguqQ/tEjzfM+iBU?=
 =?us-ascii?Q?c5KayGnKDX0Q6LepStJ6Eox7GUg8FS2GLFMooiIiYYY7gqQlDspT33/dQK7m?=
 =?us-ascii?Q?7xGG2ftxy8YnzDPStHe2oPHM8QEt/9pOaCx42xfiiqlZ+71X5uxv5vFoBxUz?=
 =?us-ascii?Q?Hq+BchpOS8XQstLZVO0rKqL8HDz6OhvRGOH23bm6v+haRlAXyTwaxr/CliMQ?=
 =?us-ascii?Q?USYpUO2xv/6CvW440wxVCwtOcQYoqPkZ5srDjLKYnxoOhqSfPk3cFFl8A3z+?=
 =?us-ascii?Q?LfJmDM9ORyUDTo8SldaBN3mrLLAblxOJI5votz4UmDNjc3I4+/HYrpM/CBKE?=
 =?us-ascii?Q?Js7zzA9+b6V+GJYUbNUZqpreJhW91Zd2iOmmE35nvo5l5OfRLrLgbtIZoFKK?=
 =?us-ascii?Q?OErD32vJb6CGsSOjWDzR2rI+VPNfpxLedLruQqen2ar3+sO8ymA0CgaSGlAK?=
 =?us-ascii?Q?2GPu2oN+gGxzclCTg62s+KYsKUxAW9TiLkYfSzST0EhM4feouFKklaae3fMl?=
 =?us-ascii?Q?fYG7koCZ3UHA27p5E0nHvVwRwWRhonuImYl5Sezgk9OaEaOeUMeKorpcRUJU?=
 =?us-ascii?Q?bx/PxPCP7SkpvC2oDMjzM7wLPnzstr+PnN6T6njyG4eG2tWirIQ0nTvTJLLW?=
 =?us-ascii?Q?z8Dna7SPvaFsiLiIgdx8Nlyd7LFlvb3OapobXT+nulNSRWg+c6WU42VjNBuX?=
 =?us-ascii?Q?/Jsr2dGffTKPMwooVKckV8FfjDBcmPS8tNqdfOIZkWKF4SC/XMwI5fYIpPIv?=
 =?us-ascii?Q?ci9FUDd1sjF9xqKhN42sBmP9TKwyqoPT+xLz1YkKSmohe7YFf1jQa3JI5rvS?=
 =?us-ascii?Q?nF5lxk4Ln5tsz8XP9GbsHHQPvZ+g8vOoSE074QFJuKCV9o/f9yCGpx7mOBt7?=
 =?us-ascii?Q?WeGJvuFG8qk8olIT4GrHJyiw6muBxhEa+EERxibdy0LMqofhZL70fX2vpbpu?=
 =?us-ascii?Q?ot6rHPnhl48q6dGIfRl295yVWwEEkOmerh86xLSucCzxGtYfOFz8CMdAlRYI?=
 =?us-ascii?Q?9FV8aTG2WJNSaxDo0AgqOiO/xM3Ezx4zMEXieae4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a6c003-4406-4f35-cec7-08da632ea04d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 11:15:13.8101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qtTxQl0LPM2hpNvcpmSr1+tHxYlzTdr0S5bONJ46ZV0ncyWIWDcKB8dL1cseqKQPMbJpgZFyzRXVtd0aFcSmvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5001
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-11_17:2022-07-08,2022-07-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207110048
X-Proofpoint-GUID: wOlTBw5XBr2rvakc4tXMwL_JE2HKSLjs
X-Proofpoint-ORIG-GUID: wOlTBw5XBr2rvakc4tXMwL_JE2HKSLjs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Mixed device-types use case prefers that the data chunk allocates on lower
latency device type and the metadata chunk allocates on the faster device
type when possible.

As of now, in the function gather_device_info() called from
btrfs_create_chunk(), we sort the devices based on unallocated space only.
After this patch, the function will also check for mixed device types.

First, it sorts the devices based on the latency. That is, sort
ascending if the allocation type is metadata and reverse-sort if the
allocation type is data. Next, within a device type, sort the devices by
their free space.

enum btrfs_device_types values are in the ascending order of latency.
It is a simple static list helps in most common cases. For any user
options it can be added later.

When one of the device types runs out of free space, that device will not
make it to the available device list. Then allocation will continue by
the free space next preferred device type. At some point later, we can
change this behaviour too by the user option, to fail with ENOSPC or to warn().

The advantage of this method is that data/metadata allocation distribution
based on the device type happens automatically for the performance without
any manual configuration.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Initialize btrfs_dev_types array btrfs_devices_by_latency to hold
     latency value. (Kdave).
    Sort devices by type and then by latency. (Kdave).

 fs/btrfs/volumes.c | 89 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 84 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b8ab13127caf..838ebf62e517 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5027,6 +5027,47 @@ static int btrfs_add_system_chunk(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
+/* The most preferred type for Metadata is at the top. */
+enum btrfs_dev_types btrfs_devices_by_latency[] = {
+	BTRFS_DEV_TYPE_NVME,
+	BTRFS_DEV_TYPE_NONROT,
+	BTRFS_DEV_TYPE_ZNS,
+	BTRFS_DEV_TYPE_ROT,
+	BTRFS_DEV_TYPE_ZONED,
+};
+
+static int btrfs_dev_type_to_latency(enum btrfs_dev_types type)
+{
+	int p;
+
+	for (p = 0; p < BTRFS_DEV_TYPE_NR; p++) {
+		if (btrfs_devices_by_latency[p] == type)
+			return p;
+	}
+
+	return -EINVAL;
+}
+
+/* Sort the devices in the ascending order of their latency. */
+static int btrfs_device_latency_asc(const void *a, const void *b)
+{
+	const struct btrfs_device_info *di_a = a;
+	const struct btrfs_device_info *di_b = b;
+	int latency_a = btrfs_dev_type_to_latency(di_a->dev->dev_type);
+	int latency_b = btrfs_dev_type_to_latency(di_b->dev->dev_type);
+
+	if (latency_a > latency_b)
+		return 1;
+	if (latency_a < latency_b)
+		return -1;
+	return 0;
+}
+
+static int btrfs_device_latency_des(const void *a, const void *b)
+{
+	return -btrfs_device_latency_asc(a, b);
+}
+
 /*
  * sort the devices in descending order by max_avail, total_avail
  */
@@ -5185,6 +5226,7 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 	u64 dev_extent_want = ctl->max_stripe_size * ctl->dev_stripes;
 	int ret;
 	int ndevs = 0;
+	unsigned int mixed_type = 0;
 	u64 max_avail;
 	u64 dev_offset;
 
@@ -5239,15 +5281,52 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 		devices_info[ndevs].max_avail = max_avail;
 		devices_info[ndevs].total_avail = total_avail;
 		devices_info[ndevs].dev = device;
+		mixed_type |= 1 << device->dev_type;
 		++ndevs;
 	}
 	ctl->ndevs = ndevs;
 
-	/*
-	 * now sort the devices by hole size / available space
-	 */
-	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
-	     btrfs_cmp_device_info, NULL);
+	/* Check if the gathered devices have mixed device types. */
+	if (mixed_type && !is_power_of_2(mixed_type)) {
+		u64 cur_index;
+		u64 start_index;
+		int start_type;
+
+		/*
+		 * Sort devices by their type. Ascending for metadata and descending
+		 * for the data chunks.
+		 */
+		sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
+		     ctl->type & BTRFS_BLOCK_GROUP_DATA ?
+		     btrfs_device_latency_des : btrfs_device_latency_asc,
+		     NULL);
+
+		/* Now sort devices in each type by its available space */
+		start_index = 0;
+		start_type = devices_info[0].dev->dev_type;
+		for (cur_index = 1; cur_index < ndevs; cur_index++) {
+			int cur_type = devices_info[cur_index].dev->dev_type;
+
+			if (cur_type == start_type)
+				continue;
+
+			sort(&devices_info[start_index],
+			     cur_index - start_index,
+			     sizeof(struct btrfs_device_info),
+			     btrfs_cmp_device_info, NULL);
+
+			start_index = cur_index;
+			start_type = cur_type;
+		}
+		if (cur_index - start_index > 1)
+			sort(&devices_info[start_index], cur_index - start_index,
+			     sizeof(struct btrfs_device_info),
+			     btrfs_cmp_device_info, NULL);
+	} else {
+		/* Sort the devices by hole size / available space */
+		sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
+		     btrfs_cmp_device_info, NULL);
+	}
 
 	return 0;
 }
-- 
2.33.1

