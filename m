Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1117B117B
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 06:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjI1EXs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Sep 2023 00:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1EXq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Sep 2023 00:23:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50680114;
        Wed, 27 Sep 2023 21:23:45 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RL6YYQ010724;
        Thu, 28 Sep 2023 04:23:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=aHoSOSGTCky1oTnvbuSrYs/iKHexisq1gsjKQFqf/Wo=;
 b=4IIAhQ9J14l9HmM+eThqeiOAek0qeX2dGL3rYcRDRVo0LHsUkvk4CpE9Lh1TgsXWSCHN
 /s7CDXOR9ADymdbGlDVoobTPqIpzXPY705daH6huFGiTwF+f+WVUhxiXDI/BKFXrN0HA
 dDeHfWO2y59jZGO8o+877aSEMTPDbATQasIsLsybL8n35MnLqyd7In4wdnTSYiC7ap51
 R3DOa886zHpL7U7FpC2tlYqreKJFLZWQuqHg+fcE1cEDkWh8W4C6Pf2fYB06EggR/rR7
 Ey046bknlMYIGO2YRNS9fSaAPjhGS94lCPvErpuSKCNqtvLNoKB17T9V8+pkuP455zoW lg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9r2dkaqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 04:23:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38S1nZgJ030753;
        Thu, 28 Sep 2023 04:23:30 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf91fnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 04:23:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K22uYdFmtGPNfmTofK/x2WfRvkrDQ4Si0oj5DzpLTUPRIct6nz0kWf+efNiaNwddooU7GgBGhzBtb7ZLz0l8RrijOZQOP01oUx/SVLHZfNZi7MApzKtAAYfbGz1MyAiS0shgT5z9I+Zbknnp5Ks5Pz+MxaElePbKNbGklZaWV6/S2xL/+5aMkqc+TdqKv3hThAAfUwEPnI1mFqD1so9dvkMheR0vHdFFLn69pTBanBtGeVJuiP+KZg1T6NLB9nZoyWkJnZ2A8Ty6+R5pl7K5IeA101xXJuADZJqQ5KuW/VNT0D0Lo19qt8JFVpW7e6OJo38Kg1MJIpZzdJpXBE9Neg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHoSOSGTCky1oTnvbuSrYs/iKHexisq1gsjKQFqf/Wo=;
 b=BjjF1dcTbLqzyNLRhcrBcCi32DMs8OsST3rA783KD2+MmrNSLDiKbQEzbooHuC2rZbUBblasyqoEJ4O8WbE77V8/nKb+usGl4MUuvD3OC+cMrvHyfTus/+1eo71msfAxzlsaDyM2r4d0O1Ac+fgsSIUGdEHT2KYLO1842AUXgn1vvqlL7H5n7JaUyjNDx5nmTH1NT0IvwkwHwH1AImGmvJOW6K6awmvT/JFVdH8vYrGAhcH4NV2J4Cz2K10RS5B4EY1QDkYZ263rlCmhavBs9Lcy/YxPUAt7DhKLYXVXz+BQuPocIcken3uD8BaUj4IfIzXpSjuViF5M0wpZMC+Kag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHoSOSGTCky1oTnvbuSrYs/iKHexisq1gsjKQFqf/Wo=;
 b=bPw81ycbrpZsZzIif+5Rs78IJFMgacNLGD7neFCIdQ0KLxAk7HDwaflZ9ylgUe8jPRrFXUnYCegJaISl4W4bdQiSct28KlGwxgc5y7Pn9evTy8KOate7OYC8Dfgw0YY1sB51zzrFDuE9rGHU3woCVOSZ/7B1PYmmnUV0OWnFgx0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH8PR10MB6672.namprd10.prod.outlook.com (2603:10b6:510:216::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 04:23:28 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 04:23:28 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com
Subject: [PATCH 2/2] fstests: add configuration option for executing post mkfs commands
Date:   Thu, 28 Sep 2023 12:23:05 +0800
Message-Id: <eff4da60fe7a6ce56851d5fc706b5f2f2d772c56.1695543976.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1695543976.git.anand.jain@oracle.com>
References: <cover.1695543976.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH8PR10MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c8861e3-65c7-4de4-7ba0-08dbbfdaaa52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kz+xKMHBLBpgsTiuYhtNgXcvi4L98Jwvm2z80Nrnu4RDTMQinmTdC2blH6Zv+rCaORfSzoklmO6kLyRuNCh6xRe9tzV/q6wNP87mgFAlwyU1ogTimg3134C6pUY6+tBXuMNN0l1SPN9fTAPQYUcARjvJz+fTZ3jX9W0RsiDdsKYRBskJAX/AkdLBWDwYdZkM26rDTMHBH8Znb+Ghmh8bT6/mRaabpsdSImi0YUJsrynA3U3X9P95Nl/l7URUTAsDbkpnjgugoel6VMvYKsGu9vgGJIlnN5iRQE5VrWA0yyARVEHG3PBApSCeFClb3OF/Bbor1UfYN5x/lf8LowrAslGJ1n+Mutslq5ljG11XmaSLmdPlqr2JEEMjuAHyDlAwALZ38I1oMztVeb0fq3HCaN/lRhILP/U8VHaCex6Y/tYzxkxTYzv46EuRLQfP1Qcw3uD+uOX0wlShHbCFqoDw22Ypt4OCg/GT+Wgqr5tZUhumVifLDZn5MmAgsSNX/ahN5h9oF14w0/o5N5bxU1QJ2AaF7GAF6HX76kYbiiOLGjXXxYNh0yoAm+fXj0chCv2a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(376002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(6666004)(26005)(6486002)(478600001)(2616005)(36756003)(86362001)(5660300002)(38100700002)(6506007)(8936002)(6512007)(6916009)(8676002)(41300700001)(316002)(2906002)(66556008)(66946007)(66476007)(4326008)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YIBa5GoZTHxyhhlIT5GEU7hDtoK4hqC8jL1rYxlxX4RJSnp510SQlDuLq8c1?=
 =?us-ascii?Q?qUMm+UHcCkM5LthUlacTwoGdosiIwBWU2AkxewsFQT3TYZHid4WUo7NNefBq?=
 =?us-ascii?Q?NEolDtSKRFcrD2VIy35102rXIEmSGjAh6q2lSM/ZWfqwGmFjT9/ImsoR0zqm?=
 =?us-ascii?Q?kmA7HKedKfX1m3iyJaDe0hewFstaxy0d4FtOwLkeZBYW72uW7khQ4yo2GfNp?=
 =?us-ascii?Q?EW2NgbvSGm5BsbaRlehAePW1JYis+Ul71rXyf9ilSeu1QrauDh9b5bCOq+MQ?=
 =?us-ascii?Q?3pSFqt5S6v28MQA4lff6XV1FUlQ0D4XRYqpcKbgYO+SHoMXUtz7teCz088eW?=
 =?us-ascii?Q?iyNhtZLD0BaWeNUuNKDO+fgusofzmuP8B+JpqFE/Ocf7vc55jP6khFKDP8tV?=
 =?us-ascii?Q?dcPm1f1bI9UHAzltWGkg5qHgK/yTwqmwOHeD/RA1/cUtymWns2YdB4b4hbS8?=
 =?us-ascii?Q?hiLKw1A0N+ZelWMrbCcrWyg4iEJVAwaVEfxjLeU+msHLcZUGW/WH3+2l1+M4?=
 =?us-ascii?Q?AY6Kl5KIEYFki5U+N4f0C9vR7Fq7RG4Hz17ibG0Yir5lzRBj5HDPtT9M6eFZ?=
 =?us-ascii?Q?crdbZ9Vq9o66oMqhCgxLPk2Vn8JBa35QH/kd9lELehHVAYYwot5FaPzYCg3P?=
 =?us-ascii?Q?EX3HENRPitQ3sGZw3s3upOFU4ECC93Dc0x8yATvkwboV9ae1LbBlKDZZwB+h?=
 =?us-ascii?Q?6QI5HU9G4TifRijSiXl51kdU+o6a42hmbsTISOv5WH2TeK48gGS9EMbxgn4z?=
 =?us-ascii?Q?tC4qCEO+VagOpPkppzude9pbVTaZ5PfeS3/h7MTdYUXFr785/5WNCqOvbJ6U?=
 =?us-ascii?Q?eryL8R/aXsbJSBwa4P4zBLuP178zw9F1kVntkWvAFVYUpE7kOyYvxnw+w15+?=
 =?us-ascii?Q?Vw8GPLZ9JmMJfpZF76qiH9m9PB2mFN63h6sHgwEDZCDlPffbRbpM5sDpGj7W?=
 =?us-ascii?Q?w+i0ttD5dA9+g2s/p8oEombP6ZSCrgklc/omhIhx0gcDIO540WIcAO6t73qT?=
 =?us-ascii?Q?gM3tF3jsTowEr39cg7TAk4hR4qWRIrOxrNmhR3SnoqkZ9vhIsR3bn2WcyvTF?=
 =?us-ascii?Q?u+FI8yZXwOfFtLyKxs0IwzY7SIqPFufNPsZ7kSxJbjH7xg6U6Jlduil/yYZA?=
 =?us-ascii?Q?LTK7iKlsXcsM42V61u2iNQWagRAkE5lRRr4s8bF7Ez35CmrvOIeH9i+8DBn7?=
 =?us-ascii?Q?twax7nyMpd+9JOxB+CR0FN//PrPpq2cSgZz3H2S+Qmfi7yfJsyUU1UCG9Le/?=
 =?us-ascii?Q?4ba5L0ERitw8XvVYV4XObnexgzoMAyhCrHv9S095/yvd2SI0IQQA+5yR5aJM?=
 =?us-ascii?Q?tNoVfTcifVGUPXDr4TPiGS5ePwrP8/24J5k0gcrki745N5XRoKyzPv6X1aNG?=
 =?us-ascii?Q?zYqL1Aa7W+H52PsTTAG8oEnqkrL7Rtiwd2zwWIzB2uptmgxVik/tNr6/QGcQ?=
 =?us-ascii?Q?kUyvtpVsdPm/k++4TFkRcChZeOcZiFP5/OhXTLvY8+JZCXwLhzGKMiSUdlXQ?=
 =?us-ascii?Q?j8KCtKtvYWwSJpHbr5J9naWYIg/pTEVXiFlZrsyN2P97clrxIy8gQ92U560J?=
 =?us-ascii?Q?kAHzuZwP92R+8fHjjZF6mrbpi3/RK7P/3qwoK9w7OXHOxLovDrM9STnnniaL?=
 =?us-ascii?Q?sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 17PZU/fM7i479+JscwYKD0OMMbjJXpqMj/9eT6K1YPDg822f+fzHmmTBhBgPlJOxBF5Hp4JCkJYJEpzzDDvPnO5GWTu5OrH+Yl0orIKoRNk8G1zqeP5xbL1aqRz/Qq5yXlSbUZZqF6rnVuAvw4nrlSZcG8aQdPf3rOAKtLVM1TDXa7ZGypWdfOQ2Z5u61D7RKucPk5S7+pyo9jVt1zQG4UKvYqFuf1CT+JmhuLjQR0V/Lf02eVAswstQQ+T3DLVc9DkoxMZCmPM6C4wd7xtAtQPUXVhvZUZHvu4i9EhNZK/DYg7893GHfhcS55+qOgpNB4JBifSatIADCwJ1diy0cUioeqG1IhPni4NMlqtFGehDivKomZXqub6U5huYBJLLtuAJE+G59fLle+9Oi7FpNEGt3Q54uZ3il4zRKEKdfVBNpLgvJJ8pKaehhVC7fvJAVBLjUNTOBnUF4BB39phej1zWP/sFN9lNvaS1hG46HaFAMpCiGfGU8BQ+NkUKOTI7tClHmBs73KT/DbJ4hAGe+Oo7uvVEMT5eLeo6bYwDZE1KouFM1y4vMMfqBMpWfF6NMbDgQYHFo0RBCq2Yox2tJwjIN/mKojDdVjPd3Z+QrwT+cA0XqcGiVYJmyqIl2MJuQwu/+FOvQHLZ8nPYIRE5Z2HVsyNbai2p25sLzJTBRC0qCBAAh+mGQ/2hkYPVAu2TyRVY1GoDrVbkIlH+tl7ak4CPRFpQc0cOqNPF6+fRGo/VBK35+zMIhvxmiMpG77NWyEj3IrlT5gh0mXEQwtE1PoS5S4BTJ1YkQQ6XV36h9T4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8861e3-65c7-4de4-7ba0-08dbbfdaaa52
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 04:23:28.6952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQ7y1RplG8OTqGYveVjlggM0WctrMZmXJeOfdqKVzJWNmraxmZRry3sEeHmGldKjReynJau1p82lRd1LoNa3pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6672
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_01,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309280039
X-Proofpoint-GUID: C_w-LPNQ6ecPuxDKQ6QOYbeSR7JF7OcF
X-Proofpoint-ORIG-GUID: C_w-LPNQ6ecPuxDKQ6QOYbeSR7JF7OcF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch introduces new configuration file parameters,
POST_SCRATCH_MKFS_CMD and POST_SCRATCH_POOL_MKFS_CMD.

Usage example:

        POST_SCRATCH_MKFS_CMD="btrfstune -m"
        POST_SCRATCH_POOL_MKFS_CMD="btrfstune -m"

With this configuration option, test cases using _scratch_mkfs(),
scratch_pool_mkfs(), or _scratch_mkfs_sized() will run the above
set value after the mkfs operation.

Other mkfs functions, such as _mkfs_dev(), are not connected to the
POST_SCRATCH_MKFS_CMD.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/btrfs | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index 798c899f6233..b0972e882c7c 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -690,17 +690,48 @@ _require_btrfs_scratch_logical_resolve_v2()
 	_scratch_unmount
 }
 
+post_scratch_mkfs_cmd()
+{
+	if [[ -v POST_SCRATCH_MKFS_CMD ]]; then
+		echo "$POST_SCRATCH_MKFS_CMD $SCRATCH_DEV"
+		$POST_SCRATCH_MKFS_CMD $SCRATCH_DEV
+		return $?
+	fi
+
+	return 0
+}
+
+post_scratch_pool_mkfs_cmd()
+{
+	if [[ -v POST_SCRATCH_POOL_MKFS_CMD ]]; then
+		echo "$POST_SCRATCH_POOL_MKFS_CMD $SCRATCH_DEV_POOL"
+		$POST_SCRATCH_POOL_MKFS_CMD $SCRATCH_DEV_POOL
+		return $?
+	fi
+
+	return 0
+}
+
 _scratch_mkfs_retry_btrfs()
 {
 	# _scratch_do_mkfs() may retry mkfs without $MKFS_OPTIONS
 	_scratch_do_mkfs "$MKFS_BTRFS_PROG" "cat" $*
 
+	if [[ $? == 0 ]]; then
+		post_scratch_mkfs_cmd
+	fi
+
 	return $?
 }
 
 _scratch_mkfs_btrfs()
 {
 	$MKFS_BTRFS_PROG $MKFS_OPTIONS $mixed_opt -b $fssize $SCRATCH_DEV
+
+	if [[ $? == 0 ]]; then
+		post_scratch_mkfs_cmd
+	fi
+
 	return $?
 }
 
@@ -708,5 +739,9 @@ _scratch_pool_mkfs_btrfs()
 {
 	$MKFS_BTRFS_PROG $MKFS_OPTIONS $* $SCRATCH_DEV_POOL
 
+	if [[ $? == 0 ]]; then
+		post_scratch_pool_mkfs_cmd
+	fi
+
 	return $?
 }
-- 
2.39.3

