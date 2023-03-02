Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7CD6A8387
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 14:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjCBNbJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 08:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjCBNbI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 08:31:08 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8701C3B675
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 05:31:06 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322DPqot029458
        for <linux-btrfs@vger.kernel.org>; Thu, 2 Mar 2023 13:31:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=0lWsYGeI9Q+UMW/XUdqqhGcvgjFAk9AetfOQKPct5cU=;
 b=WZCjMEaI5Y44nmAUI2zLVe41FfMxV2lqsfhgsVepC2/VR4PaAl6DXXoWxacOmm1xc5k9
 UX6cFSvZAiED3EmXCbG1HJAJ4nZrNSIHl5eD/0V5gwceGkiVwhKy+tPIfdDaUupYi8LV
 taCUrFaB2RbieEYLCFsI5bOLGwqgZ6QRX+SL4fn8g3PBK3akWdadSo/tHtV+WAJmZPl8
 9AQ18mAd76661ZKvCeiObJGUberIKPehiz7XHkXKRw5/8QCLGi9/RBo+EZaeT0+jNmZY
 L2plDGV/qFzrqosGqEBwE3wjCj01Wx3e7V7/a2+hzMvQ4hCqBmLeJvf+52jgo5FwXz84 2g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb7wuxes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Mar 2023 13:31:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 322BrOED034864
        for <linux-btrfs@vger.kernel.org>; Thu, 2 Mar 2023 13:31:04 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sg4ksh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Mar 2023 13:31:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBOU2blcr9pDxxi92v6vyutDCb3emM2Tiitc70pNzkymdPxlKbBzYPtMzci5ZmNgYwwNJoNrEYzQXjQMvw+vdjCcItU3Gltok5c1gLEiNI5Rj0OnpYwiWREvDlZmA6TSEYF1Y/3uDohhJgRSrnFk84y/y+PgFwoi/X4Y4e4zDrn1qPYC83W9L8Ovu4sN+nVpG0nAvN372nw/+jQq0HrlNeyYwAr/Ayiobg5YcjAqTbvRmoWd31rXzXIXHIThY9XrDnEhrTg5wBgNvQvforvRFEAt0+1WoQjE0SWx9KltolszU0n7Dx03F8cN2qbsLdvuYmGJDdPyOKmQ/jNPJ9mTTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lWsYGeI9Q+UMW/XUdqqhGcvgjFAk9AetfOQKPct5cU=;
 b=etzttMJ3vTHQ7NCAq8NwkJeaWqpDZS8jpXNUHt4T7g9IxVN9bZEYrR1ecoYeIX4t3rs4VmC/HoObTCc99YjpV6HOkq5wHlUklBeg7DG9XcXYl/cg4YYExO7lAP/GmCIWp6A6BexCP+fYmJXcMwBXxOS7HFGvI/++MMcxhZm1npS4iUdWglwgEvW3lttwunquC3O7idy/HLI1teeQsQBeztUjAhRC8nyM1ubyrAvhrax90dj8WEa36hWLiY+ebYj3T30DIXI+eIiCUE3FsFfGbRh6KrwqHH1drOHvF/EOGV0pcVG8vRPevUevKoATm+VzdWkOTBquk2FoM+V6pt+1Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lWsYGeI9Q+UMW/XUdqqhGcvgjFAk9AetfOQKPct5cU=;
 b=FH3QQ9YZ2X2WcXcOMCamIaJIsljUeUFUi3JwDfj1CQMR0KGzTeyvFDFl1semqUY0BY7Q2HsE83XG7kdC0ZdbAcLpV/ltnOdNLjqsYuU/nxihji35l4zqwDDIR+lhWy5HmveBLGEV7QkHPwHW27H7lCkIDDE4nksC2SEwc1qj4XI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA3PR10MB7093.namprd10.prod.outlook.com (2603:10b6:806:304::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 13:31:00 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%5]) with mapi id 15.20.6156.017; Thu, 2 Mar 2023
 13:31:00 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH] btrfs: remove redundant clear NODISCARD
Date:   Thu,  2 Mar 2023 21:30:48 +0800
Message-Id: <73233a37a2e5ce11f8eff689c9f2eef4d8fcbee0.1677745385.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA3PR10MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: dad4b94f-1314-4292-379f-08db1b225cfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o8hfvTPDXQp0DLwxuxyTmpjzgYYAUVpIVJnuqBkWiPBvoXyXBYXnk/Di3D7cxCto4SDC5crgphl761OcgU/I7YrJDdbhKT6BEz3tP+84fzVwM9VLWTWRJjvHk3eZozfj2TuLDapqt5/d43AhGwUVo84PqW9xZjEkzO2WQcrYlPZEu1D+f3YRKr2HRHqb6tTlXcmg4pZ2x975pABT764omJ0EQGKHEJ63qPglMjhGge3MEMHjYxdwXFB2KmjN2Mr6DMzY5VSvCAsDvClnrrDoKsjoPfMJ2EKCXNzZ7Ql+kK9gZmgmeGSZWOijXy5DO3ZQ27hgSFDGMCn8YO++0kOnCgj05XFZOZfjJuNc8Ux3fMyQCeqPx14GmQG/RHeKESge6e1e/uROLbYC+8mrcuWkRqe60Fzl2tLtzOOiSfnzM9qccUjkjoq7q5gYT+agxO2nn/+FYM49ShEpx/PaLAHgSFznF8+vUXEhYkGiiT/I6pHHiQGqiWOeZHOOmaI5vVOaE/J7N0uf+kxtzamnhv4ltGpFzjODv7q7sCczFaw6iZfyz9w1DbaX3XFH0s0P9Pa5rPlaYq0Z8jJ8F7nMV2EmYTjCqwiKzqm6NLnbBHPYETcbjOGDYeCM1mWhuDAVLjIS6u8A9atNaqriRasp8xYXwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199018)(36756003)(6666004)(107886003)(6506007)(6486002)(26005)(2616005)(6512007)(186003)(316002)(41300700001)(6916009)(4326008)(4744005)(66556008)(66476007)(2906002)(8676002)(44832011)(5660300002)(478600001)(8936002)(38100700002)(86362001)(66946007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rjbs5vikg3+PYtnozHuV2POECt81i+tOcnzViNGMK7H9QLWWb72ROJxmYhu7?=
 =?us-ascii?Q?hHbRPoNt0Aj+rqcsPMHxfgd0Y0n9dfhWzvWCpnm9X9ITAyBZg18g2iuG46wB?=
 =?us-ascii?Q?V3l/DXh8ZZeRyzEYex+83KCEf1SPtP2bViGbIFYyEZpWmu+knWM8rNwDKf1L?=
 =?us-ascii?Q?nMSvoBRe+hcNqpEHusxNBaEOOZTzaYw3CDWEQv7Fslryk+H7naCYOnw7H9Eo?=
 =?us-ascii?Q?xjbi1BpvVTGCO6XB10633SUAewMhdQaQNqfGlmu7VEAn1BFov9txDxUpjz/0?=
 =?us-ascii?Q?hXYjy45u264+OtqdeqUqGRNcq7kId+8TROyBHnHBxCG6JZYfTcITfJZD207y?=
 =?us-ascii?Q?kG9tZ0COYqy+f47dlgKXRkkAOhxrcoSqRx3PixljzL/8Q14zYan/MnTkpYNL?=
 =?us-ascii?Q?CtSQOF8Bqr9HapUJyBHG64l8Kzc88QOfUUN13XB2FGuC4QzjJdJUzcdYYKEe?=
 =?us-ascii?Q?UQjcx4RrhoDU3f4CZdTNqwuJJPxKM3FvXz4cGsxUZOi8xqPc+obK8cWJ41fj?=
 =?us-ascii?Q?uNzJNftDT13n/GCrfWD+/e04edpEW8KyUOKQXNgfqYZodjRTnniiyBEAIvVF?=
 =?us-ascii?Q?/x9tRlY3lnCryqVvV8OZmtPFogNU692bZ6WmDg87cwSpMylPfhZw1+Wtw9J6?=
 =?us-ascii?Q?B+5QsGNGqvZBGL5hw2vb00jAPHBeX6xM+XPzD+jZVNiMF9opK/7DDeIymcnX?=
 =?us-ascii?Q?a2ppP/AvqtL3BoLIY6MCCukAuPi7ZwfVlNzI1CnhXJXiAQP7qlyWgp63uO65?=
 =?us-ascii?Q?e7RxcG8bQALFHVyb80/TgLHICrM02WuTf/SQ7ws8XFP/95TPH4Luq4ZWoZdR?=
 =?us-ascii?Q?hwRf/pI3guqgSfo3Dbumn8Su9PZr96l7Geg6W5D3tFx7X2jssqjFzsKI3/Kj?=
 =?us-ascii?Q?kvVOYjLWYi38cPKR2Th4HSf3igkzRx2/4rj+2jGSr6NQQ1EmmWsVdxefBeEs?=
 =?us-ascii?Q?u6TMpC9uludn6V8eVBkyfRBngucRyFecNR9UYc3FNzewoT/cwOFFLxZtrJRQ?=
 =?us-ascii?Q?zdGWLaJJsVph17ASOEhdgbTYqbhmKEni2l+Ptr5y3XazuP6UK/vbC9NBjv5r?=
 =?us-ascii?Q?2duKMZgAfXPxe6hBDXNOAGKHCULkIeFdzR8gDqnHYfzEhKCd+Gpi3VgGA1Nh?=
 =?us-ascii?Q?0ufqaOrbxQi54GutuyBIf9XhS3Kr578DvzuH0yRCd+LP+0ZNHfsCsaJEUPYd?=
 =?us-ascii?Q?lKdQTTLepLkq9IF7HypKw76AfEnipg/F8hX3R9RqrW6P4hofGZSxsGPRLmPX?=
 =?us-ascii?Q?lmdx9MMPdTMamm9fxn7bBQfQdrta2cTd7hGmzuGJjc4KB17IBFLZ8HsSNzdv?=
 =?us-ascii?Q?ZjkSj89jHMYaQuFD0/Cg5YJuEK9HlRAVCQj0JOxgbXFQSIux8XVnNMOS+RqX?=
 =?us-ascii?Q?zk2TZzAJ0p35dCN0RbtXPEpZ4OJgnPSG6hDlFt9BaxA73w5/vwMNNEEw2k2n?=
 =?us-ascii?Q?pJ8AfjhzjhQ+uCJcn57vOxKxu1ek1SSyDiFIpxRV4hA/79CoMv6DdEYRmxfr?=
 =?us-ascii?Q?uD5p7eWAZnHPyQ8IcrLLF+1GJsy9xHuh9gZwbJrwQPTRNeaAR8dr3PW3o0vn?=
 =?us-ascii?Q?3YCqXwvWERk/gs3pHotP7sv+R4amNiDkqqszNKlD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: w7mCT4n5QntQzuu3P4VDafmrktrgET9hLm67eXR6hqxR7rIHQ/wPJ0kOIka0R6FsI/fafdXWXqQ+OoLP4nO/P9uN0IesR3KexgpwlhGnxBbdPsvllTmG2GUNJFJr6V9mmH9yzNK0GDiRwzsb6dj+PP+QtiKc8az9LdAsR1hogkocQ2hGU0nlTphwOLAEFoK+mKQR6qpCAye1KqIHjZZjBz8VOTD9ZuAm+15H3Js9weaKhYXtykjx/TegpjLmf1NRAY3EKDe8pe3dpZAW7E1l2J/8Yx9yWEGOHpRyzkgJmqsxrF82t269ySBBnm+/BLOai5XAqWeMeAGqv4Ge+mMEAhZebTkzSMXMa3LjQs/p8q+ZlbxHVShXRHYPDBSFo7l9LgcXhr6MiPqi8KmQ/MbWxH6NYmq90fSsMMwHzHsKB9P31O40aoA7LSijHD60qJPIu91xGvKVgWR2I/cf8eNUhxR7yTHE7T7X+UobVOCu0vdYqsVJZCJuZviIYHVKvNO24omw76dQTXXIgCShDtFlzH9eRiyGdqae4Liy9/cNoafoFz8uW6/6q7y8RN6KvCIYkPwIoyELuUAn/uV1PjD5m2wD2tBKAEyyDmep6gacdxxu+Kcm71ixQSgrP5Od48vb2lu9Zip119d7uCDUjQZtx71UoCw7Sxq7YNqX0vxBqb8Fae/pA5qfoElvPPr8Nx8zr31l8rX4NyqMDhkbS/9ebY0h93ZBEUHSatKd9U6+8xtQIP8suPYUytNeviPSEzX3
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad4b94f-1314-4292-379f-08db1b225cfc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 13:31:00.7021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: upuKq4cXpeb0VRB3o2TT3zEqBu93SQrWxJpMe0Uk54j41GvOPIoruRvnmcX1fROr3XGL5ojLYXejgseHvg5JMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7093
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_06,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303020117
X-Proofpoint-GUID: dSjplM3WNR8kJ8nMdIH5U9uynj2WXB8z
X-Proofpoint-ORIG-GUID: dSjplM3WNR8kJ8nMdIH5U9uynj2WXB8z
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If no discard mount option is specified, including the NODISCARD option,
we make the async discard the default option then we don't have to call
the clear_opt again to clear the NODISCARD flag.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/disk-io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5d86daa5d685..9d656eba7ce1 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3675,7 +3675,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	    fs_info->fs_devices->discardable) {
 		btrfs_set_and_info(fs_info, DISCARD_ASYNC,
 				   "auto enabling async discard");
-		btrfs_clear_opt(fs_info->mount_opt, NODISCARD);
 	}
 
 #ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
-- 
2.39.2

