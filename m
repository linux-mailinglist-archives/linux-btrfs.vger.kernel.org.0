Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BFA70D9DF
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 12:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbjEWKFL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 06:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236499AbjEWKEw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 06:04:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223E2120
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 03:04:51 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N6EFL6027131
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:04:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Pe8Vj1GA7hV7/RDWN+egQxEDQeDRRunQKfCw3lzPGZk=;
 b=g0YimS7K41ivHHixfAM6NfX1hcZ/q88iQWCowVg3j5nIhsmgExq2NgnUlX3i6w0KQ/k7
 CCO7Hpp8QHmPi5O2albZccb/3qttrW/RF8oKKB9m12G/KCrirQ1ZRwMFbo0/B5h1wu+6
 AI4+NPKhuaja4swVLwt49hSXE95XItxnwtbogbZ5LxEPz6v4PLiRgsaiDFFJ9QBOKOFH
 liUV7Iw1NooOO1FgqvXCmMPGOqhqPcHoOndlhNnwzUTyNX86UsdPw3eOTtai962fZdbT
 cGaqaz+Fvmou8WLeeli+lWiS8hrKi+8LHZebvNz7wEtlLF2NVMOUP1lTuTgmU2ixVTjj 1A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp8cct1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:04:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34N94QT1023801
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:04:49 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk8u449k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:04:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtRJTK4bkQ0LMix/3ZHks8DvQ6ehWaneInl+VV0rv0FSvEgjDn+BycK7tMSCGu1OkzCA+81l3yeFZypV7BFAhNcwr+8TVccz4D4qbDTRMWKdvM0oi2VgwtnvAfbu68A4culaWXCEcr7Ng5xLfbozOtFfixWIFEXZ0K1Sg2oZ+DMohmZ53gpjOirNQHMS7CuvBLtfwkQG/SgA9BQVbMTQa0dItAaJ/WAMQKfO5LRQiKge96OnbaBueSqp1hnMdd8LugtsGF5FknZB6R9U2Z50ejTt/m4OzzFMgHxuPsATPPH6yzhBI6Rdlq95yduErS/fPYGZ5tIHE4ZHDlTIpiteUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pe8Vj1GA7hV7/RDWN+egQxEDQeDRRunQKfCw3lzPGZk=;
 b=OJ5GgV83eivQq+dLp05D2i2KSZRkSnO/7BqdVLocJBkpByu+adUMWG53CSdidqYRa15igPFvVznstM+ZwqBMo59uTFme+3HlPGArV8CJ2i7xHFbsX24JT8Ze+deJC5uyHYCfHa4PmiyOBHm7jyiePLgFiNg5vATEPDeKFeCTWeq8qc92KSZfnn4y7ItwCPvYe6YBIVuAr/N18NEaJ0sIJySbLp/BAVvvcyBSKiVkys4cFEk/UT9P9S+wSDqw669Tiv1UizeZNVJABDu/9L9vczczuHqODeP/8RAq4XljIdbpaxQi0flNvdXIsZ9/U78Tf0mzQ75jqjxXkIfYpvdfSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pe8Vj1GA7hV7/RDWN+egQxEDQeDRRunQKfCw3lzPGZk=;
 b=hDhwqNtx/Gb4RycvYXNYySAgpB3zTHtNuB47DYInu8pZSSPdFjzToiMNrmP32VyfdRYzmlgXfQbAM3wfEROLXH7K2o3s/zUDkyYRLJlEwtEnd6aEa2Ki/UkDyKgn15tPadZwa5l0bVHUJkA5YEn7OFWNst7u9efMbWrPscyc1sA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7305.namprd10.prod.outlook.com (2603:10b6:610:12e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 10:04:47 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 10:04:47 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 6/9] btrfs: refactor with memcmp_fsid_fs_devices helper
Date:   Tue, 23 May 2023 18:03:21 +0800
Message-Id: <fec5e2be6fd4c778966edc3c576f7df38cd0ad3d.1684826247.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1684826246.git.anand.jain@oracle.com>
References: <cover.1684826246.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: 80b368e3-ee50-4271-9384-08db5b7523e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zJYc83Sm3UQj8GWQIH68MCuKmNkO5nLQufGLXxgoSO+tNoC1DTxUDwJclE10fqG4onGmFa/LRZoNQua1g43fskCusLLKp+EGvoSl9cLzo3QsGk5mZEgj1cBWS2dhvbuC40n+7khIEZzeHrL9u65dBWJXI6wdhxPHlYwO0iHRveePW0ccrHdfpNkn5iw8xpCWvv80vbq7mJfI27PYpyngfXvwyzt8KQVOtVkKzrg/tnPixwc4TbFKziznGYryl1zVUK9CkpI4E9v+AmbAG9C84LJLlclAlsjjoxrOMxkcBpZUF1FMTWnlFUgs+5Z4pIz+IIbU9qa06X6bYr4T/F3+0Unb34Mrq0LB8N5xPEoDp6BgocB3ekbZ71f+kak1OdNyjU5VzdxM9KOJh02czHUTRZuV+gMybKRHZKo6G4n4oeJOPzuHINCIh09ydbUzzVEKmmp3T1V6paRGA99W2pECI60DSQPtxuZ0Tkjbb+aYU7pLGtB0A2m5TaDqdYVNwHAAq1U4xhqf6Xpmr7IkCtozHCdDx4eZ2DKB9J/ZSW5GKO8B2DJbqHlPB7mOXVxEBnaE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199021)(478600001)(107886003)(6506007)(26005)(6512007)(316002)(6666004)(41300700001)(6486002)(66556008)(6916009)(4326008)(66476007)(66946007)(5660300002)(38100700002)(83380400001)(44832011)(86362001)(2616005)(8676002)(36756003)(2906002)(8936002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tAZ9AT2cmC4/Hz4LEszK2nGIEKarccqlZhFlhNew2NRwadX2Ss2dWCm/QKyq?=
 =?us-ascii?Q?/uTtT/NKJw0Pa7xjETmRL/9Vs/sWGKcAzq/KkY28V6U5koqodlHCy7+oXPwH?=
 =?us-ascii?Q?Urj/V3y84WjHAJA/Vh13thY2iMm75VYyBfWIC/bVlvJcduKH/xACaCQj+Osn?=
 =?us-ascii?Q?0y8oaYyX/aMMhqLg6GVwHSHweBhn0qHinZNax5q85LxmJdkS54+1SVOrya7O?=
 =?us-ascii?Q?3XhCEQiTRwI4ZEU/EPEbIiL67JgToERYtYXZHfs0vPk7fXceeGR7hQtGVGUW?=
 =?us-ascii?Q?mA7EcbIyb8Cq6MKsHrzdTbPUhOi9zheoyfQoXWIo69yQe6jeT57Draps4ONS?=
 =?us-ascii?Q?ENiwOceskNptMFeWqw5KhNuaDgbEpChQnbi37FcqKQQRRRvBbLj/J3W3hNJn?=
 =?us-ascii?Q?zXIsef4WkwPOQHAVhChGIzTltQrpGkxZQTUQ01/FKKqZ5IGmZjUTcoEdAUBL?=
 =?us-ascii?Q?5zkdEwetuCRJeUxgNUUh1Myr/wOtdvr5VtFHkNoT03Ex26Ckm7SZYMnxrdnl?=
 =?us-ascii?Q?EsZ7lK1+lWiiz/HTAFQa6lJvJ2oPNELscRkjwG+hSeGAi+b4GnGQ6wSakzZu?=
 =?us-ascii?Q?utd5t8+K+xphO6E7lx0JYOBsHyBhUOwifThhMUMFLJBKM+VrxdfBUJ/goQaJ?=
 =?us-ascii?Q?pLSJet+Ozy4RMAk4luC8NI07X+uwphEjuJCoO57plDTdvVq47+zOTS5uRplX?=
 =?us-ascii?Q?jiVvv3toB/i7YRSmDQ2hdDeQy44e1wjdLy2w3i0KJlJ2vmXXUw6+xi9qupwy?=
 =?us-ascii?Q?93KTY8RIYSGoUO5Fz+zTyP7eAk6AXIdFjlN+F14i7N9/BIpvcZN3na7l1+uM?=
 =?us-ascii?Q?v8/a5PsnPmjRd+w0+9M9Ch3UudUFaKACb57JepVBjSLWst017Bdutmrae66c?=
 =?us-ascii?Q?BXXs9X2dtguChcGcFSpU1ZfnGFwTxMnqjv7lb5Tax+CJ/PFKgjuE3pcnA4+p?=
 =?us-ascii?Q?0wdi/c3N3UPGThgBi1I3ygetE6Ois6snddXaDVFfJ1XI/AWwf7hNmmOS4IUL?=
 =?us-ascii?Q?/jW+zavPP6qJ+FBKE8uwrAsBov0xgednKtDn5xqu4JvYqVRweRisO4tzbq5c?=
 =?us-ascii?Q?WlDxHogOp/+YJyd3HCTod+2gvEj3vHuA4EqI7f9ys1Z4OAkwUHXhKYIEotSJ?=
 =?us-ascii?Q?rm530jhF6Q50RyaONf1JDhg7c8LfzCikHNXkfXR6Nj3eEIfhDAJoVJJLyjyc?=
 =?us-ascii?Q?IEsFpodnPZP5gPRCeCa5vP2cVGK5dvaUemKNKaVRt+/f4uP//m4NyXQK1gdI?=
 =?us-ascii?Q?QoxLofnKqR/aEonTXgv2U3fLL9t7NUVJxBHEKT5o7mijTvaY48y0cwa4WXnW?=
 =?us-ascii?Q?hoGLp4bjK+OVcipkmuFd1AYLLo/XRnao5y8CKi4T8q3exxJfILKfxoy5jZ3o?=
 =?us-ascii?Q?J0UDHfuvTNcRqg0cfnvQCZ8+uCth7ChW+O81aoHB8EOIwEl196zIDjOzsxrD?=
 =?us-ascii?Q?7/ibc3mcLhyY0eY5MinPNTCMIJPGsrcbls5rT83uEYt2usPsLiEYMOssiV4o?=
 =?us-ascii?Q?hZXoeUu+RmGvbnfvmo1yiEvvuCioF7llUSaLfmL3H5PTGt7Zei3+gXMdcv1a?=
 =?us-ascii?Q?zdRWXjyI7G7sV45Z+rt/TdvheH3vpr6+pSeHTl7l?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4RRBefc9wn/omgcGH/QI6juz6jJ8oxx7OZM2uJfqOO3aYE5PLEZkrAaRmrlENnT9I4aW+jEPrBXvMAZ7Ov7r+1DNRBt8GzeIzXnv3akYCbL3tOwCKRTO/AdkzOaCrnjHUybQ8nxXrRB7ZZiFB3KnosDa6HFLPVHzX9pw5sw8BMlL9fLwThow19yekxxHA+hyLlal37ZCrmMPZpLlUtsAux8tFa7hAwLDe2KS9AeCSyC9Bnoi4oIzCcF0gBXSxNaOndqhAlRKK8VtEB+7ahQRnLeHZTrb1YSBjQwCJAGhuErPCRPtq5WRx8ETsdMW7M1mpm2lcETJ0/OjGeBkwhRUHT7TO1oK28WpfFnL2Y9JNKgDLvK+sQ3CcPbQ6jrkcD1JMdggueCppWyMmfTsBOsHyx+rwdSaBx+3y7bfYsYEaXvtJXENx3ZZZKzC3mS/2hVqvYEI8DGm5/j9zxXqryFHHq8rlXoXEmQ+vBcd5/Xo+yuFs50JW6lwgLqwSYTQO5nUzzXQaQgLQ1/d65wwfly4aEktxfvURZt/G5wlRXQJld7eNnSAj1umLuwn6B6WSIUUBUHTyICsVRvp7riB5o9xmgUHnuNAm8AYZG9cLHvfTtWZGWEaO/erSHj5q5JhYnIimSVlh1/Tyhe9WfFBSir0gzbHm3UvLLqQvYNnQxDqwf6/mUXT2tnZvUVuRbVoG3is3o90aJj93mg7Fbzm4wmfZsHkuiI0Vhz1LG7l+tvTG8WUL/UFpf2qaO2aTPuxLcGE2Tl0oW1hylUr719Zb2KBBw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b368e3-ee50-4271-9384-08db5b7523e1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 10:04:47.8221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eigXrbNuAl1jlDsKzpp6kMRiwwaldcgH5FeNOMGvd29gUEAP4DNZMf5iVEFLWVl2e9SY/0TyGUl6toBdVeQmsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7305
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_06,2023-05-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230082
X-Proofpoint-ORIG-GUID: YdwOQpB9ZEanQZ7CKPcgu5qn3vTvC0ID
X-Proofpoint-GUID: YdwOQpB9ZEanQZ7CKPcgu5qn3vTvC0ID
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Refactor the functions find_fsid() and find_fsid_with_metadata_uuid(), as
they currently share a common set of code to compare the fsid and
metadata_uuid. Create a common helper function,
memcmp_fsid_fs_devices().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 95b87e9a0a73..8738c8027421 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -427,6 +427,22 @@ void __exit btrfs_cleanup_fs_uuids(void)
 	}
 }
 
+static bool memcmp_fsid_fs_devices(struct btrfs_fs_devices *fs_devices,
+				   const u8 *fsid, const u8 *metadata_fsid)
+{
+	if (memcmp(fsid, fs_devices->fsid, BTRFS_FSID_SIZE) != 0)
+		return false;
+
+	if (!metadata_fsid)
+		return true;
+
+	if (memcmp(metadata_fsid, fs_devices->metadata_uuid, BTRFS_FSID_SIZE) !=
+		   0)
+		return false;
+
+	return true;
+}
+
 static noinline struct btrfs_fs_devices *find_fsid(
 		const u8 *fsid, const u8 *metadata_fsid)
 {
@@ -436,15 +452,8 @@ static noinline struct btrfs_fs_devices *find_fsid(
 
 	/* Handle non-split brain cases */
 	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
-		if (metadata_fsid) {
-			if (memcmp(fsid, fs_devices->fsid, BTRFS_FSID_SIZE) == 0
-			    && memcmp(metadata_fsid, fs_devices->metadata_uuid,
-				      BTRFS_FSID_SIZE) == 0)
-				return fs_devices;
-		} else {
-			if (memcmp(fsid, fs_devices->fsid, BTRFS_FSID_SIZE) == 0)
-				return fs_devices;
-		}
+		if (memcmp_fsid_fs_devices(fs_devices, fsid, metadata_fsid))
+			return fs_devices;
 	}
 	return NULL;
 }
@@ -462,14 +471,15 @@ static struct btrfs_fs_devices *find_fsid_with_metadata_uuid(
 	 * at all and the CHANGING_FSID_V2 flag set.
 	 */
 	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
-		if (fs_devices->fsid_change &&
-		    memcmp(disk_super->metadata_uuid, fs_devices->fsid,
-			   BTRFS_FSID_SIZE) == 0 &&
-		    memcmp(fs_devices->fsid, fs_devices->metadata_uuid,
-			   BTRFS_FSID_SIZE) == 0) {
+		if (!fs_devices->fsid_change)
+			continue;
+
+		if (memcmp_fsid_fs_devices(fs_devices,
+					   disk_super->metadata_uuid,
+					   fs_devices->fsid))
 			return fs_devices;
-		}
 	}
+
 	/*
 	 * Handle scanned device having completed its fsid change but
 	 * belonging to a fs_devices that was created by a device that
-- 
2.39.2

