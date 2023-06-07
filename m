Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150A5725B33
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 12:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240058AbjFGKAb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 06:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbjFGKA3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 06:00:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC5E1735
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 03:00:29 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3576Jrek011462
        for <linux-btrfs@vger.kernel.org>; Wed, 7 Jun 2023 10:00:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=0hZoEqUHVaQ7ZD2hlYCI7nnEJdDUH2/D44dggDLBexk=;
 b=AQ8ps//JdSTel5TbWihDDmGHa89M8aF+2DXKvIHfT/2uKgVS5tS+DRB0AmbaT/yifqmN
 zUXGqzVQAJ3mN84T46H4jpvUBneaiALkSbqsp5Is+mPPAI7Uz8HtzLxFhO2bGGk1ijqP
 /tyFDgIGLyRE0CNSi5EkjIRi2iOi1/Wni6LcpPJIAUgZW8nzCQObCOUps0PwX/n9jkJD
 0kVsS3KgreJunhzYardF11yyjZBpWnNCGrAl4hBRaHX/icGKXQ6cgrRkx8sAFvl581YK
 SaqXj14+cEVVJ0RmxIv7sruD2f+Rxj1PbK2UtgFD5ggQv0ONrAATSUaH7BDLldkRRB4P MQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6uscve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jun 2023 10:00:28 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3579fhMo037092
        for <linux-btrfs@vger.kernel.org>; Wed, 7 Jun 2023 10:00:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6r9gs9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jun 2023 10:00:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqG7WywbbRJifttIgs+7gmq/xXDCgu97iGh41BMWLoWhsUxwMWXwpfqFFFFlOLw64V++P4nH6w5qq1gFZ+8HfeM5AGY8h2RnYEJUP1dbBW50Vjob/du1/gXBmZFSOvarM/m3DT+ZtaIQqPxTIhUHqEG5mR5EOTLkpXNEcf1F7amSxoANSnBWUEboXwwfbt1oGpZy95w/xmnYhqXZo8CJ5ELGm+9zW4lDmaH4K4f/nnfSoK91ljRXOKAJrO/dn7GZdVFwLfbCsf5nbjhUMWODq4+I3aJKrdwhG/94agmgYTwOOk3B3+zGjGMNlAQe5o43bLi9zv8y1xp/B6Jj0mRTZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hZoEqUHVaQ7ZD2hlYCI7nnEJdDUH2/D44dggDLBexk=;
 b=Zz9NdQt8QJ+y1R9xmVCwDKsVXgqmO0A20FcjGO1Fri363CHJu6LFYzCdTJNsBFKjceU/0EufFcY9b8V/doAd6n2dgU2IvttLEbIT/CYeAYftzzVMCWuE0IS+1utiPHXV0+P6J+uouxgfCnrKAFwk0YEFluWzt19Jz0s9bxhuaaiF0FzcomR9FhskPpPd4YIyfca9eZlqgzVoeqSBht51lfxGpYWIpIL09ow1RYdcONBoGKFNfXlbK6OOWKZ2SZhIj7dGHkupC3/5U+aifzvyzl6KtwFr6ViLNC0wUepKYJrqNSKi7Q95N0XUuzLzt+n8yZ6SvsgY4eJs/Gc+yhsQkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hZoEqUHVaQ7ZD2hlYCI7nnEJdDUH2/D44dggDLBexk=;
 b=PvCkwTXuHoA3M1VtUSjnVnEKX1GTZMUCrA+dxImlCXNSnY1sdggJ2H5V/8Qp1drKEPqt+ebwlNnTwsgC88QbUXkpLL3YdPedNpHyRw2NHUTp2Tn76w+5YqUWzOX/8pLhvKuLFNtzdKUfWcQ9TonQbPjlrEO7sYYX+GFqOcPPB9k=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4762.namprd10.prod.outlook.com (2603:10b6:806:114::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 10:00:25 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 10:00:25 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 07/11] btrfs-progs: tune: add stdin device list
Date:   Wed,  7 Jun 2023 17:59:12 +0800
Message-Id: <6f4f5eb0d897033b6e4105b93ad4f1de422e6487.1686131669.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1686131669.git.anand.jain@oracle.com>
References: <cover.1686131669.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4762:EE_
X-MS-Office365-Filtering-Correlation-Id: e9ef92f5-e695-4611-f941-08db673e03d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kWB9+H+HEqaQp4zCv7vg+U5Ra1LiuqSNp1sOTkajVz0STPZwGtWcvT+Vlrls6a/mN69Cu2kTqwrUyOcBBFzpHsLmIGHKzbhMRo1bgsvkA6Wa9PMXyOAVJviqVzcLCYMfds4YXHVsepN2/URVIpkSYwjGeTCTp1HW6an5yjTh+EUyyZdNEk05mKgcsN0C5tL1qDlIvD6NTMW9v0m4Yr48UkNlvO9GhBtwkmsdYVlU3Sa/7ZGV9+4mnOpUZVxPChWQ6Ufllw7bLmEQ7Oqw5B8pxyMevrgJdXbCI1H1iegBPCUHdf338Kt672c3l9ER3a0ePJyVtX997t+NDW9hm3ycGW0ligfPYLcEtL6ONqhwab5a4n9WI+L+7OZ7RNa7ZjgUUAWkAI2bxby6LsGlkXn/bEd3n+qV6XGwN6S6DcDs1a/RrBxI01FNNZgHHdj7tW5L7UB877ahoBqFBkpJg1k01YWLRn9VvwT6eMMwLjD+S1mokTn5iZ0XweUKizpymSQ5BL+7UWRWpAv8rwUQVXLfUvyR3Mr83cgU0Haf0qiC2hbwLsBgj+1nVdLO5eqwDkln
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199021)(83380400001)(4744005)(2906002)(2616005)(36756003)(86362001)(38100700002)(41300700001)(6486002)(316002)(6666004)(5660300002)(107886003)(8936002)(8676002)(478600001)(66556008)(66946007)(66476007)(6916009)(4326008)(6506007)(6512007)(26005)(186003)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9m2lrWXcZGA8Yxm+x9V1BoZb+wLtaSdiV7QTlnrDPCHzaWnUvhQYZlggxchD?=
 =?us-ascii?Q?NUNMh3LKTuCsYR1KIrkzzYOQ3YHPiUOkbTbDhJFMLguYHCx6ENLdxWryO9tC?=
 =?us-ascii?Q?rQnk7D4z9jlvN8xGVtrO+6XjEzuoM51ySG9tZTDsRGDmYly7fZpMEtqUrH1P?=
 =?us-ascii?Q?NZPhLQ9mZU6scChY1GmAr7gw+jpQcaXAX284StI99Bshf5Cczp90Yi8eBzSN?=
 =?us-ascii?Q?obmBNBFOTZpROLvaIGje0aqIAIAsbCvFbpti4gLajdqC1yvzW2w0S6MD9fEs?=
 =?us-ascii?Q?TufF1V2i0esUTQpc6/aJMuVgkPNiF/Y23lnQJuqJxeCQsUQKGfcBeeDr15nL?=
 =?us-ascii?Q?oQFbVzDCa58gcYOUjmPb+hMK8o/E0qTTV36lvf67MQpYvNegWJUsdbVhbkuM?=
 =?us-ascii?Q?gsMV2AsPqLWahftXa4xzxH1QRSoc1UtH6fRlhzlODI4XWYHEJABQ4ONG+byJ?=
 =?us-ascii?Q?TzVl36VzA05W38wTMzakfbTpvD2lshT8Y14NAmwKgvPuJcgZxB7yvVjF9bn+?=
 =?us-ascii?Q?7n7ZwVOpB6RUExxmXaM37NPoeiu0ZRrZ4OGPfNXWGSMo+RcVy8AK0nSpVhhC?=
 =?us-ascii?Q?joD6I2TJ/h4J6hjW2YvOMMuIfaI6GaLu2d8zBu0MPQ2M4/BORGygE8nx3+s4?=
 =?us-ascii?Q?V/KPf6b5jHEgzU0tAGlUntjEbhZScV+G6xeTi44JD1tY27Y8IMMfatWxCJji?=
 =?us-ascii?Q?m2ae01jcyt/1RJNpZIqD3D9BePvncU5jOYNj5sOYV9Cf+UGQJnlOXrB8voFa?=
 =?us-ascii?Q?6YbWkGo4voNw2+ZyJY5bcdtG/pd8zwDtbQ1XF3AaB6zJeyVJtWB0a3k7aBWX?=
 =?us-ascii?Q?2dmjoErtEHi1B4t5VmVN0re81I2cQMHE40vBFRvCnM8mgzcsOP4hCUfdQaIO?=
 =?us-ascii?Q?IfAzs0lZqUHd2mB3nKCl5jaK3toCyKx7M4L9c8x56ywjymEs81d0QGYRLfPF?=
 =?us-ascii?Q?+DbW+iLA4x0hcx1CvbDJydlWJLUQAlaUWmjYOB+UbJjESCFU6v7+mxPZtQK6?=
 =?us-ascii?Q?H/wVigXh7hptj0Z5CP0102l5rjscpJtEOGv2u04wmdyOOtSN5rN5On27J8D6?=
 =?us-ascii?Q?l1uMzEl5lT9GxUVS9Hcvf7mmjgqpydp9spq5sfTKSjV3HmJr0hpN6A8B1SCu?=
 =?us-ascii?Q?RflJEAXDHBv/UB3aqm98hoyXHS5ThdeOh2YC3l7ea8elNHbghq1UAA3+qwha?=
 =?us-ascii?Q?n/p15aBBktF7MtzjS6OdZ8EC3m3VP1YbEl/TN7zWdu48J2c5OgLRBmKN4y0j?=
 =?us-ascii?Q?gjvalkRw6Me6j0MZH0aj04lQOmQ/55DUR6mVovCZm9k+LBE6mA0ObeuBGgsy?=
 =?us-ascii?Q?N76Kgiyl+bK9cRMbpzUc1YC/1cG94a7T8XgnqmlSvQx33PC8sgKyhaS8F7aC?=
 =?us-ascii?Q?P7Gq33UXbMb0lJCIsnnLjal/KVro6ZIBUBzrBX1IVmB6GIiB5BK2LdxRN9tD?=
 =?us-ascii?Q?UovRnfyjW0xtn1kyEPD6MyeD384lLkGqeArlCqJtX9OLMXIN66y9K+MnzUOP?=
 =?us-ascii?Q?xpd5GWfCZkO+/rnPjprWLC6BmRy4D9XKiaafO+Jdwk1j18x5U7k+IZ2TaHoi?=
 =?us-ascii?Q?mNYnOL3Yi/TQ67UvE/FMgPT7DH7l7Jsu5v/+B2sHijkKKRsyQVc6XBE0ip+Q?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QpGVf4EKwcjpiKMN95KluoDIKzpUXONxmMF5Scjzo1Qp9IAftog9P48p+moWw8F8elD7wcxREqi8PLaBX7kLwNLYriCOr/4uFFuriiLmdK3OhXhs6HFAypmShu9CwZP2BShzlBCZ9gSKydloYnqQL7pYD3sKb4uUpwt3rXC+S/nKK43p72/hCrZsEOr3At4tZU4Ak31rBj9LaU4EEFwTh6KJVeOJuRJKS0DUR/dKMfSquoxMw34wO68umaj3o07Ng09OrJsONuPnIq8GfbyFaPDEsnLtzfiCN2VOxLY6YNyZakjTseRT4u9vix1sxhtxNDcPhGEOD5gD5rTBNsRAqUuzxP6ko/fJtBlLHzjHWZ67iyHaKkeyZulc/gblNRq81aNdffQUu7R576OU/x9tGsbWJkqXf74grDQ7JEEk/uKH5wtZUoom5nk+BZi2BjsHQ0Cvora3Rz3AeJa4r1vFBkWXLx2eu/8k8CwPLaJAF7d0CSyIqvqJHOQfQISvIw31iii/nzpfhumFrqYDDr64lKtP7ZS1yWG5cdAkiDfx+PFsYJR04k6MM9EIIXC6VMb8eGslu5Rxlrce1geFzbSPtm4mcx1k13flTbyyG1D97KFbqFjBOfsGyiVOeC57zcbtPLMP+PMAKosiDnD0p/bY5vNoUQiAAlDN6zv/qMG7s1MNMyJaM7S6Ec+1jZSC/IkbEmhSIkV8tuqh7+PG/EYenKvlYIcX3AgyG7nQqaahancinGSMEPtYaMXNpdfRGmDv5hQcW8T88ov92RsJRMkD3w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ef92f5-e695-4611-f941-08db673e03d9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 10:00:25.4305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bEPTsiye2RiJcqKS03GcaTpOeBgMu3kmTvD6e+ag93lMEteP095yhcEASR+SpVnWb3w/D1WB1GZOf1NalJZv9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4762
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_06,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070081
X-Proofpoint-GUID: tUTWBzx-ViJzjHcZoZTLRi3qBxM1rhYl
X-Proofpoint-ORIG-GUID: tUTWBzx-ViJzjHcZoZTLRi3qBxM1rhYl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tune/main.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tune/main.c b/tune/main.c
index e38c1f6d3729..2ea737bd0c0f 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -232,7 +232,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 
 	set_argv0(argv);
 	device = argv[optind];
-	if (check_argc_exact(argc - optind, 1))
+	if (check_argc_min(argc - optind, 1))
 		return 1;
 
 	if (random_fsid && new_fsid_str) {
@@ -280,6 +280,14 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		return 1;
 	}
 
+	/*
+	 * check_mounted_where() with noscan == true frees the scanned devices
+	 * scan the command line provided device list now.
+	 */
+	ret = btrfs_scan_stdin_devices(optind, argc, argv);
+	if (ret)
+		return 1;
+
 	root = open_ctree_fd(fd, device, 0, ctree_flags);
 
 	if (!root) {
-- 
2.31.1

