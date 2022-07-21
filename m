Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3B957C9FA
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jul 2022 13:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiGULwp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jul 2022 07:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbiGULwm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jul 2022 07:52:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C8283230
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Jul 2022 04:52:41 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LAGDHo003962
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Jul 2022 11:52:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2022-7-12;
 bh=RTbdG13TcU6jKnOFsm18NLni3F7ISPsCnNvY81O4H0Q=;
 b=Pv8/dZULssokgAcTY/8VsW1YIO3eaESyRUFD8nWTgbGznxn1K1rULlzSaelD/Cx/md7M
 W2Ryb5sR7cu6HW5ZaTltxjOB/pShnpsBOFd+ApMh+FYc/QMT+UZGuTCzfhYwEtXzCnul
 ff8RZHYw1DD2e5cKykhLlIFl+wT0sTa9kCI47sWngPc+LR4+a1RAWnsyQjulhhvika5Z
 iweSPjpZeOnslwN3tio5fuBVa6zkVkw8jYy4jN2WNDmyu8i1xaCMv0TsmF/XiG9+A6xP
 rDEAb+1/tN0jxO9KUu9RxpafMH9THEt5qdt2pr1aBlq2c12uscvjDQVX0CNRZ/7PEYSn 1w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx14b8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Jul 2022 11:52:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26LA1mct039230
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Jul 2022 11:52:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k6h295-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Jul 2022 11:52:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0a5YXzXbr+n3kQdbukpG5WFZtzXQQWpM0goNwKe57vLOyIkqRQCCE2vnOcPjeG+lg12GcYfQ4tAHHmBW4n4wqYxodDE0GMnk+jr8oQei//h57pbJWkIuCnZi/I8vNAXnHvy3iYW9CdPv39Fa6xANufeVKoNpsn1sdKOtPcRfkD08cdGd+VHD0v7QvrmnF6/J7keVs6369O+6O7Ds0hrhgSYyIobKznTmRbpKlekfH76smEsU7JL61/LjmEFTgSDWVFQHm125WTSdTlMoJODkO9PpsqafDgXIO+xk70JpY+jY3pX0/Sw09WyMxfujQtDJHSy/WpdkUQoT6TwHaR0zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTbdG13TcU6jKnOFsm18NLni3F7ISPsCnNvY81O4H0Q=;
 b=b6L2qpqpLXZGlC4M/++NXBuxeIPqGMk3YdTPQud+oV0ipLuD+qOKst4U6p8nIqN24lLfL9YtZJNMfjYiWdgVyy3DUuHdT/rwLTD7ZIlW8mZIo4vvVFMZyZ6z05oxwaijZhA1oOiS8ZkNl8OGbUHzelKR7RnlvHQeGLBaZ3VRkS+EOAqBZwww2nH4LttqXKpnKvK8nMc0QhwUqDe4Ve3tr/+GvEFx9IynnilU8alO0+uSnV2H+SCGAeSd+rI8H0uBwY18tZQTrl4Q6z1Fc8f3DtyUidBMeQy2KXuKYbO3XAAWQvjMjlBawZK+uHbAvNXVKxtisL7dp/F6fdPjRAnjHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTbdG13TcU6jKnOFsm18NLni3F7ISPsCnNvY81O4H0Q=;
 b=AcdcynR+tz39qtZUZrHLFfbiIC4o6Lf3/jMRbaW9/0AeU5GbgjlA/VLLDyJjeNRNR4IjXzUIoJLIBTZXB5Od0EVFJwUnGOIVC4lQkfjM8hK/+xcTVT+uXcZEmjJU2IzZ3BMOd0pXtTjedvApvkjFhQOliGUtmiFH87gdKQWGy/k=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB4140.namprd10.prod.outlook.com (2603:10b6:5:21b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19; Thu, 21 Jul
 2022 11:52:39 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078%8]) with mapi id 15.20.5458.018; Thu, 21 Jul 2022
 11:52:39 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/1 RFC] btrfs: add read_policy heuristic
Date:   Thu, 21 Jul 2022 19:52:27 +0800
Message-Id: <8fd44134c310df469520d7ce77c579640b8766f0.1658401527.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1658401527.git.anand.jain@oracle.com>
References: <cover.1658401527.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:3:18::30) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cafd8a38-b588-4f0e-5bcf-08da6b0f82b4
X-MS-TrafficTypeDiagnostic: DM6PR10MB4140:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I7/BoE5ae7phDBkeeBg2HwpqtqsDNxvcSpOetAnYhMZ/Fte4gpVrWbGh65Kkdl2VBSa5sMQ+RdWy2Dj1ugYfoKdEF+sNHqs8eyOE0gIZ+kBQhsRjIPiPxo0ZbD5H09hG8FuMB4rxVU4+CpLE1chTTqdr4s7t7LiM3XZuyEwry8feBe3oYkRMmPB4c/i62FnJy1P6OAhZlmFY5RPOwdM2UD6kjv8UXyc8Yl/MGb5RO4A99kLL0Mq+vl5mbIWS9kRN11Xe5Gy7129Yu4BUQ0gfu3q1x6LRNOGDqZUTgQ+oWcIn2Ca7IBG6M44sOq79pQBk6Flwsj5YrxQdmVMLb/MKLSYLmrgE+YY3q2fVFC8YHr2312fEuHv2DdgpgRZps7LASesZVLIofE4kwfVQUIm7n6omkQsBvtnohefuNqajbNQ47gD/qvMJzTgKD3PKpqquayrahStMxS2ncS+HbsKKBO3TnLk3kocleMeRxIljhyaUbUtM8ePDjEBcrI2Y+bQ1HAmlpTFPc1VVHJ2uwkfW+uW4pY/P+y1MC24NvHiAGoWLXLDtH5ZY1CA+lox3pgoCOSI6W97B+gqroGD5x0lF/qUkH4RJw7nPUcYl/gsrZ9Mq62O/KQgYDKT0BcwHF9BfU9OQ/xPzTpy8e9eFsKES0sSJBe5EfmB6ewpiDAdJlIc539eef3JOdDJLTDLtOEYiypMNMDBil8bSFMQ7nUgxKdyVqnztPM+3dCJWc7uyaMW81vtqp6wQYLjYRQuxcAcf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(39860400002)(376002)(346002)(366004)(66476007)(2616005)(6916009)(41300700001)(316002)(38100700002)(83380400001)(186003)(8676002)(8936002)(5660300002)(44832011)(6506007)(86362001)(6666004)(2906002)(6512007)(6486002)(36756003)(478600001)(66556008)(26005)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jq7i1Qe7aP4RHbT02BDePzQmGBY4b06LP4B29jXVtNaT1/yJhSPUmh2BzHjv?=
 =?us-ascii?Q?9Na42H91mCPLoT5Q8vVkShCoWk406k8WCZ9Na4FifwQyOldAthQo3IWvcC7Q?=
 =?us-ascii?Q?6ov4Xm0J8vzisecvo+bTpfVLgmrnkxCdieG3nOLQWQtH2AGq+wirZrEUni9d?=
 =?us-ascii?Q?8UWdq1yXFuMiucxp7QD8TLWim8oO62/tPyJvNfidxssvYsOO2YvuuiPaZoRO?=
 =?us-ascii?Q?AJRHVe+VrYgPSXPz0ewhIBg5LWOEilaM/GzhxFSGUfC/d3EldLL1CUVXSXa+?=
 =?us-ascii?Q?ya1+qbvTGNiXJinoiRP9xDh4FTiLeDynV5xhwSGaKm6LG7a9fiPXMK+k0MH9?=
 =?us-ascii?Q?a0cqfFSYfQIpFCmQpAcKvilcDYqmx9ekJeEf0SvVCkCoLfUcvu3NO77XUS5W?=
 =?us-ascii?Q?TY2aU2u1YwTH1vyFGb+O9oj7A4NMjNfP+jUVx6BvoP1A2j6tRvbG8yd8R03B?=
 =?us-ascii?Q?0jydqRPi7NXof/VBPjKHpnZwN5ZSRsD8UjDXdC263oN45LVfnylNaAmmlnim?=
 =?us-ascii?Q?g9gGw9VzKnIGj1PAqq9L1mCHpeXmI+PmrMIcJ2DxLNK7WjRR66UxvRDLML0F?=
 =?us-ascii?Q?xLdowqDt4LPagpRZsilf6kN5Z1XY3KBPZ82FlhrZskGQmH+YX8HMVTlsXmQY?=
 =?us-ascii?Q?a0xfvZgfwKvu9UYid55AyMyDzQVwRp3DqAHpsc8gUThQSBrNkAu5krRZYMey?=
 =?us-ascii?Q?m7l7g+j/UxwsI+H8nUEopgUtqR+34hNV8rmNBRcxsy86YheaKuK9i0q2W3do?=
 =?us-ascii?Q?SH66DkDQOoQyl6194oGQ9jLyHHemnXZ2Go0lud0oOHdqPDkI2dku4Yvoekih?=
 =?us-ascii?Q?sVwCrcketCpoYdwv/BmYDWX2LzVtTeulkvkJKiSZLi+NtUtS6w0s7LcDdzJJ?=
 =?us-ascii?Q?x//W8CkrUgMeZfbVXBlBA9Awo0U8shBA76uh1efq5Ddb0KchVE5O101RpWt7?=
 =?us-ascii?Q?DaXr3Rq51cqS1cKtbQsduzgPlSH3yxBPlSJKwsiIFCr2DcHW4zC/lENZYmIi?=
 =?us-ascii?Q?o3p9t4WoQZNNrGQjHJUw6s++HV7ALHvvNsN0ydna3uPd8UT/mRdqe0uDfaTh?=
 =?us-ascii?Q?QsnOhGtMDlZIEHhKH4+pS7ryZpJ1DVx3u7DEIBo1U+QukEHv+gtDUAw0XjWt?=
 =?us-ascii?Q?hQ4+fOyvRIWi14fDuMfCvJ6TXBS5oechwd+MamxQ8l45HmN6bhiCSIP75qj0?=
 =?us-ascii?Q?oNytXfCTMjjznRRJH9AO6xv5yIen7eaM3woN60MTetaPgz9PJXBHYYSzIqBz?=
 =?us-ascii?Q?uiISalJZxkGprK1vYXzasUhXi7xmCvi5aBbr+EYtdIagcogT4z+eIf6eIaTy?=
 =?us-ascii?Q?umkZNULOwxHmZ/sYLgBPB2jsHyq3g59Ucljq1GVS6ezSxiM1H8vi4ZS69CfJ?=
 =?us-ascii?Q?mlSnRVcGAbRIWcW7UNdaHshVZw1XXQAefzFTsjSRhYzHITIKb+yy6hyG6OyO?=
 =?us-ascii?Q?KRPMFUgH9+hdZIGYntyaNhSlnRDkRKvD8+1Tx108MF5u6cPs5y5FzZYM8RaN?=
 =?us-ascii?Q?LQhLOrqDB2SrAb/02Fih2q+so5WuM+vrT6urvzjCcDjFiidTZ/fiKPisNca6?=
 =?us-ascii?Q?U85iSsMFB753r2xcvR/QZjGYkpwPJ8ZgFaTsiQcA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cafd8a38-b588-4f0e-5bcf-08da6b0f82b4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 11:52:39.0385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CsfnW0dYBIufKm1WIPJsDnl2F1JyCRAmdhcbgN+x9LlZttOPs6BliakN99STQqMV5VrT1kSBLJqA797xo1hwWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4140
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_16,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207210047
X-Proofpoint-GUID: nnY_NKwDr3deIbLl-0pnvh5DBd122NNN
X-Proofpoint-ORIG-GUID: nnY_NKwDr3deIbLl-0pnvh5DBd122NNN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Read_policy type Heuristic provides the low latency device-type if
read_policy type PID fails. The read policy heuristic retains the
advantages of the PID-based read_policy and has no dependency on
block layer iostats. This policy can be a default policy.

This patch depends on the patches[1], which provides device types
in the order of their latency.
[1] 
 btrfs: create chunk device type aware 
 btrfs: keep device type in the struct btrfs_device

Usage:
  $ echo heuristic > /sys/fs/btrfs/4b74dc57-526c-42c0-882a-8be30e1b8933/read_policy

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c   |  2 +-
 fs/btrfs/volumes.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h |  2 ++
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index d5d0717fd09a..501c216009fb 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1169,7 +1169,7 @@ static bool strmatch(const char *buffer, const char *string)
 	return false;
 }
 
-static const char * const btrfs_read_policy_name[] = { "pid" };
+static const char * const btrfs_read_policy_name[] = { "pid", "heuristic" };
 
 static ssize_t btrfs_read_policy_show(struct kobject *kobj,
 				      struct kobj_attribute *a, char *buf)
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ad053c2a63a5..7efdd1dabf7b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5896,6 +5896,54 @@ int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 	return ret;
 }
 
+static int btrfs_read_heuristic(struct btrfs_fs_info *fs_info,
+				struct map_lookup *map, int first,
+				int num_stripes)
+{
+	int cur;
+	int new;
+	int stripe;
+	int latency;
+	int curlatency;
+
+	/*
+	 * First get the preferred mirror as per current pid and check its
+	 * latency
+	 */
+	stripe = first + (current->pid % num_stripes);
+	latency = btrfs_dev_type_to_latency(map->stripes[stripe].dev->dev_type);
+
+	/* If the device selected already has the lowest latency then return */
+	if (latency == 0)
+		return stripe;
+
+	cur = stripe;
+	curlatency = latency;
+
+	/* Find if any other stripes have lower latency */
+	for (new = first; new < first + num_stripes; new++) {
+		struct btrfs_device *device = map->stripes[new].dev;
+		int newlatency;
+
+		newlatency = btrfs_dev_type_to_latency(device->dev_type);
+
+		if (newlatency < curlatency) {
+			cur = new;
+			curlatency = newlatency;
+		}
+	}
+
+	/*
+	 * If the PID chosen device also has the same latency, then use that
+	 * device.
+	 */
+	if (curlatency == latency)
+		return stripe;
+
+	return cur;
+}
+
+
 static int find_live_mirror(struct btrfs_fs_info *fs_info,
 			    struct map_lookup *map, int first,
 			    int dev_replace_is_ongoing)
@@ -5925,6 +5973,10 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 	case BTRFS_READ_POLICY_PID:
 		preferred_mirror = first + (current->pid % num_stripes);
 		break;
+	case BTRFS_READ_POLICY_HEURISTIC:
+		preferred_mirror = btrfs_read_heuristic(fs_info, map, first,
+							num_stripes);
+		break;
 	}
 
 	if (dev_replace_is_ongoing &&
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 0fe20eb4087a..c8a73722bf60 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -277,6 +277,8 @@ enum btrfs_chunk_allocation_policy {
 enum btrfs_read_policy {
 	/* Use process PID to choose the stripe */
 	BTRFS_READ_POLICY_PID,
+	/* Find and use device with the lowest latency */
+	BTRFS_READ_POLICY_HEURISTIC,
 	BTRFS_NR_READ_POLICY,
 };
 
-- 
2.33.1

