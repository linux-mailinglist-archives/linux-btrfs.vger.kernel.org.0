Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81257DF134
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Nov 2023 12:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347393AbjKBLbT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Nov 2023 07:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344733AbjKBLbR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Nov 2023 07:31:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B514111;
        Thu,  2 Nov 2023 04:31:15 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A282qW2015412;
        Thu, 2 Nov 2023 11:31:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=UVJ+/aJAvlGq0n89MvPP3s38a4qwui1yTJd0hTSPRnU=;
 b=HeFE7OtpUXTpqB7VauNdFDpxZiD9RrbMPfdaWnjXbgaVb16eVurADb8W/syyF/Qct+44
 Qr0SXGXdySTray2MQTnNgPIGQedr8MWigoK0auChrI7Wcd8PVWEJI55GeQrhPCYQAR+1
 LzzcLEmNXtJBu9VV+jwl/GZABMyO9DtlPYr0kVhhHadO/LAefXDxCG29cTL0aHhqABox
 NkNUd7k1bLxw5X7oKsPTc4H63O1fUjP5cnn+KD7TLft09kFXC1lnFE3K/FCscb4zIpoE
 YenwErdemOrVYQg4IxlBmicVfTEO/ye4vgg6ZGggtbFgxe9J0oTrAjX2sK04yyF1FN18 tA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0s7c1fyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Nov 2023 11:31:07 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2ABGCe022584;
        Thu, 2 Nov 2023 11:31:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr8ebrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Nov 2023 11:31:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hd8n9moGZ5/mDZVTZSJWZPy3GrJelekujcWzh2YTb9dla5H8ixrGnau9w2bq/wJDZMH1oUGDilZEfdsR7sdWQUclUC0tAwmYdvHa0PAV5FxFZcVhMl57K0F8V742l0IaWjGGLckZ1wwvZzB+AmzjLKOrC9wz+dUkwGK+np3ev6nOSx8sQr/1ooupEOpS6Q2r9Lqs97/fBR24dMafUiURn3wgRaa8rRmHkIMLpDLc4cVFSP+FHQnLdsDTHHqRLVFcK9g8qn59oJzx0H62Pw+iUu51Bwbi62EDGbhws15WC/K8QGfkLVJYSl35muBSFsag6aHlMf6Y4XgU03bTJU8mhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVJ+/aJAvlGq0n89MvPP3s38a4qwui1yTJd0hTSPRnU=;
 b=czKvx6s+yLcNR8p91v3ecPMfgpt9ZRnR4Ys/AvBPdFxH/ckC2rswsZzy+97Rz8Icg8+B72rxtfQFsopJrm+OUa/jvQbsbG45cFx+Wcdc6eEs1uBtsmUxzRlc4SL2qTkK+rIr+EgprvSB7pzHY4Ka065Zhw3cqCILTQ0cmTYSKCq8I8WMKkTdtepG0J+MBSDPleV3fGm0ZGW2Xq1tdl5fjXZ84doLLnL738haYZO008ue9CjeKkVCxFvg0JbPd4IC+bc+2YlgSOGSDPk10MN1d2xVxHk8BCF39L+GSVibycBzXgN3wH3VpR2Dai21soxwmUlluSg/LDf/Jgj0nnRprg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVJ+/aJAvlGq0n89MvPP3s38a4qwui1yTJd0hTSPRnU=;
 b=IIQXIKO2z9yHfJ347rf1XFjiHLAjWNgNqnVqFZQLaFfWsjncyYauVHC30iTxMLEqb+pjxl7LGvibOsfUXKydlEntXuHW4M/ZrKFcCVz9hSzUYjgILG2W0DF2FpF/4vxix7dR4RG8iFyqZjfZldbh+SGTNtNpZJ07dcgHPiKwYn8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4552.namprd10.prod.outlook.com (2603:10b6:510:42::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 11:31:04 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb%4]) with mapi id 15.20.6954.021; Thu, 2 Nov 2023
 11:31:04 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org, fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org, zlang@redhat.com
Subject: [PATCH v4 3/5] btrfs/219: fix _cleanup() to successful release the loop-device
Date:   Thu,  2 Nov 2023 19:28:20 +0800
Message-ID: <77a360863a5d41d4e849fdb829145c6591d4e955.1698712764.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1698712764.git.anand.jain@oracle.com>
References: <cover.1698712764.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:194::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4552:EE_
X-MS-Office365-Filtering-Correlation-Id: d3c2df8c-6e4c-4c98-9de8-08dbdb97329a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ONi8OPIjPAj4BIS26tBeoes4UKGJw6PjGfaWFwkIDa4BKhz1oTY7c9jhNga6dWdA8UCFbtsG5X0n+MM/r7QUORnomiJMLiPEUQtnlzBq5U7081UoyLp9odVcbUh1crjvljzOoLLnfMlG4S2M8j376POvnazeft07SYQdjGzsELOXNIWsmwZkTA2ywNvhg3aPUlnlSTveRkp8DEzrtU9Cwxe/jU3tTsg3e4Zl+m3SfDCrdGNNp0mq7TzlJc8WLq5y3eYI5Zy0BIaT3s7jZ5647NiwxEzs++2Z5s+cCKzu8E0wR6COu0PHANAfzkAuJ+Ag4ZiDc8RUGQu3ei5TF4q1j4dYcF/9aKkc0CLCPOLv3uySnUjICYz9y6pKLEFRWGIu9uan+GkBU68BsUeoZz2UeKQbFtSl5bCSNMvjZbjIoN/OVlR//6RuT4ZhctA+Z3EnxQfOhVsYhRO4uadh8BbwSgrxJRpgKEX1G2vmimCm76k6oKfA4T6cyms1nNPjPsRbHYpbIpv2lN5wEdItXC90nT/Lb1wNFZY3Y4ineD6ISAVWJpilQxzXoikCJrDNyNGS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(366004)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(36756003)(86362001)(2616005)(478600001)(2906002)(316002)(41300700001)(44832011)(8676002)(4326008)(6666004)(6512007)(8936002)(6506007)(83380400001)(26005)(6486002)(5660300002)(66946007)(66476007)(66556008)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uH2jGVHJ6a52ypoyvfE1nzZueU7HY7RvmMerrt1TDrnzrCc4nAOXS8lj9qZw?=
 =?us-ascii?Q?AoKgjoyS+qJyiDZ8zk0dWRr63BNACKXA0/nL4pG/Gr5gmCgA07o7XT06bGMi?=
 =?us-ascii?Q?BuCDB0YbHD65jJwN4MVBcJ6Gygora4BtstclRMpBmKnomZS2KsnAmDTr2emQ?=
 =?us-ascii?Q?RoTeGvKDd1ccsPpFxsIg8Ida1l68WHo1prBkv/tTObEn+/iaHWtA1EmIfImN?=
 =?us-ascii?Q?ngZoRaFxbgrl6CMVvEIvljnEb/ryXqP6Zypbgf6hO7BfUtMNMTJ9sNrgsUu8?=
 =?us-ascii?Q?cCcZxfaT5BvSSZEZKUV1a0AvyEqwBBUUKPD+72vFt6Sj12Qn5aJdqUREQOq7?=
 =?us-ascii?Q?rT7gTWhS2ItGg9vmfbIXAM/4+7fW0+lzQkb+Vvo2WzYM45keAXt1Y8zU2jWg?=
 =?us-ascii?Q?3AqWv8nuvKDZpjgQlZPfBP9vCthRG1G/TCRHSq9CSK5GO/+0uGT5dVzhgx3h?=
 =?us-ascii?Q?rU1mKNklw8K+Px7j3gGsg2mWYyTXGimT9N/0Cmoqw/lIBqu6Nut4noQbaccI?=
 =?us-ascii?Q?wVpNS3LGm2Jrw81rparhN4gk90T3BY7Lck6I/qLhha7gM9QvCQ+aWs4bWBDZ?=
 =?us-ascii?Q?fmggZcna9o+WkYro5db4QDhnyC/lO+MZCd3Wg71qPFm/I+QH5R4ysk/WvKpu?=
 =?us-ascii?Q?IOy/Tzi1plC2kmOil2Oi5IMth94SXRz40FnHGYZBEnOyevQmO8ecJAolOP2l?=
 =?us-ascii?Q?bFCEnJ8j97zETEtkWDaE7d9qjLaUl6/bkhVibj/lodLNhtIXhN5RRKYCN9tP?=
 =?us-ascii?Q?XpE5mjOA2OJTuXiNZ1zV8D2uN+wSTSEV9OjEhDkae3poG3Is9KPrm+Lnae3s?=
 =?us-ascii?Q?BPF07g6G62KW9YU/Y8TWMiMwV559pSfQaWddxf3OwBewG7XuPvDUwyU0UVf1?=
 =?us-ascii?Q?fxwIn2l+QtPX5yTUNaIHntpomIBOkJmq4gFbjGnBsrmZcqG0Zv5pCGN89qzl?=
 =?us-ascii?Q?q0buhjUmI6mU+UODtuh3hZMZlCRd54WVBUiAfnN4qXhv18e5O+CcC88XZsoX?=
 =?us-ascii?Q?VsfZoAXbYERIiIh7IWyU1WkRBUtp5hVv2A/4V3N7wn1PbIuIwmIqLjQ6SjYA?=
 =?us-ascii?Q?0wmpWT5TS0ZlBO74qwo4qadkkx+XrPd/jwRRpMnp6XsAuMpcLDZRxwwHf56c?=
 =?us-ascii?Q?9BlklkKkIqFyNwrgT0GAIy6P1s8/PLvxLaY9GBz2NoLYd8EiWq0dGzBZNT6P?=
 =?us-ascii?Q?mnGNdbDGexpDVlsMPD6iuT0a8OclKwyXiSOzZnnuL7RCV/BN2vSIQNEmfH7G?=
 =?us-ascii?Q?5ysS1EQpDnKOKYpwvvmWS6AJewNIWBvehXgBD9XIrmTLbT96ujQ7fp3LujwN?=
 =?us-ascii?Q?BFD/cHfbpV6oTmXXrRBHmRCZDpfV9scoA+R/Jpr6WAvRPG/MEJ1OobtskF0q?=
 =?us-ascii?Q?iPg7WYdTNNQjJI1mKdAGKpnaBing5d51t4/t0+eU3W7htbJyzOZO2cEBB7Rl?=
 =?us-ascii?Q?zgUTL0XM5oJOiH+WCeCUickt6Wwj2xLyHEQhRy1fNRTI+pW3IGnMFlVposDz?=
 =?us-ascii?Q?B8Tq+Ac4hX30SukWfqg7OQLbSmepI9FM88Y92NcjNSdobnnk5OnA1lMxB7XS?=
 =?us-ascii?Q?1E3Hc74rFYDFqZJXwXbTpS5ZkBAO7dC84pKKvvyQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Z224LjAQdauYiKbgi/MzZ/PKOCrvFI5J1jdIUNVgGQfJSANap/KL2hdrGJXmY18zqHShdq3KGxkofOnODjFoq+n619SgwbNKKwWTGDHmrtIzQa6Uyta/yPjKN1YSFS9MrCa2FbA8k+Pmwsdwnk7rtwSG+Qr9KStT6ITECfSrcfBeoqL2aC3Ew2mEBBX6k78nf4M6U5Vtd6yp4dU9ZWAFTX4GwExfiVCzB8E8zliWFJ/CY9t9xp2u+9RMtPLvwUmzT5Dlvo0UKAFVCaVV+POePWTtzMBJcYTwCiE5kJN0dkTdmIZXvGbqnvBwH+av2c1YeNyooKdUvbIAH9tEY97i6GjSdLAM/L9LVv7bSLpraCtHFuFzDsGadXA3ApEAfBKDe37na9pdHL7tSNyubjmWEL2uMq6Roc4+rg3YWDEiSFgXlU/0AiZ4/sG0mGLFNyoB0vRkFdCEhxRzLNE5KKbBrplXoIWpnIEJu5UrbjI+NHDTFp5utq1YhmzgX9iwCEIIVJ3x8EB9WhaO9JHtR3HALgy6mJqQGualhHYd2Gm+FtH7JTyZG7RM7gCxjxiB3fxmhRV5aZCzcpbuK0AoFQRMtbsmWIvHRPPm0PCnFGEkjPnQ9iGs8OfXwgT/7kjf5wL0sGLkN6avnqDRlntqSrfuoUZzKvgH+Wfj9nGxeFxl3BAXt6RvkCKgOzbQsbRMB3OsKDEkhzaL0DzuQ1hnE7mMSo7mNr5oCPfDHTzoZ8iGvvusPZIDS/zGNdm791KqJ4LBGkhGgb7R+rcYI448oLnGvEF8dSWDPzFLz+B1/N2Xy4zvODR2dru3EaFyO3Vi05AV
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c2df8c-6e4c-4c98-9de8-08dbdb97329a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 11:31:03.9848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yiXx6deYhQ5IZ0iDQ31QP/ut47qqOAU4RyF7i1uL1GlxAoBnNH+n7KbaCb9XNvepESHp4hDvaPSPRxGDwtmoWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4552
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311020092
X-Proofpoint-GUID: FoTiHBYgvdolWEbmcF7dr7kHj1sOQlp_
X-Proofpoint-ORIG-GUID: FoTiHBYgvdolWEbmcF7dr7kHj1sOQlp_
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we fail with the message 'We were allowed to mount when we should
have failed,' it will fail to clean up the loop devices, making it
difficult to run further test cases or the same test case again.

So we need a 2nd loop device local variable to release it. Let's
reorganize the local variables to clean them up in the _cleanup() function.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
v4: rm -f, removed error/output redirection
    rm, -r removed for file image
    Check for the initialization of the local variable loop_dev[1-2]
     before calling  _destroy_loop_device().

v3: a split from the patch 5/6

 tests/btrfs/219 | 63 ++++++++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 27 deletions(-)

diff --git a/tests/btrfs/219 b/tests/btrfs/219
index b747ce34fcc4..35824df2baaa 100755
--- a/tests/btrfs/219
+++ b/tests/btrfs/219
@@ -19,14 +19,19 @@ _cleanup()
 {
 	cd /
 	rm -f $tmp.*
-	if [ ! -z "$loop_mnt" ]; then
-		$UMOUNT_PROG $loop_mnt
-		rm -rf $loop_mnt
-	fi
-	[ ! -z "$loop_mnt1" ] && rm -rf $loop_mnt1
-	[ ! -z "$fs_img1" ] && rm -rf $fs_img1
-	[ ! -z "$fs_img2" ] && rm -rf $fs_img2
-	[ ! -z "$loop_dev" ] && _destroy_loop_device $loop_dev
+
+	# The variables are set before the test case can fail.
+	$UMOUNT_PROG ${loop_mnt1} &> /dev/null
+	$UMOUNT_PROG ${loop_mnt2} &> /dev/null
+	rm -rf $loop_mnt1
+	rm -rf $loop_mnt2
+
+	[ ! -z $loop_dev1 ] && _destroy_loop_device $loop_dev1
+	[ ! -z $loop_dev1 ] && _destroy_loop_device $loop_dev2
+
+	rm -f $fs_img1
+	rm -f $fs_img2
+
 	_btrfs_rescan_devices
 }
 
@@ -36,56 +41,60 @@ _cleanup()
 # real QA test starts here
 
 _supported_fs btrfs
+
+loop_mnt1=$TEST_DIR/$seq/mnt1
+loop_mnt2=$TEST_DIR/$seq/mnt2
+fs_img1=$TEST_DIR/$seq/img1
+fs_img2=$TEST_DIR/$seq/img2
+loop_dev1=""
+loop_dev2=""
+
 _require_test
 _require_loop
 _require_btrfs_forget_or_module_loadable
 _fixed_by_kernel_commit 5f58d783fd78 \
 	"btrfs: free device in btrfs_close_devices for a single device filesystem"
 
-loop_mnt=$TEST_DIR/$seq.mnt
-loop_mnt1=$TEST_DIR/$seq.mnt1
-fs_img1=$TEST_DIR/$seq.img1
-fs_img2=$TEST_DIR/$seq.img2
-
-mkdir $loop_mnt
-mkdir $loop_mnt1
+mkdir -p $loop_mnt1
+mkdir -p $loop_mnt2
 
 $XFS_IO_PROG -f -c "truncate 256m" $fs_img1 >>$seqres.full 2>&1
 
 _mkfs_dev $fs_img1 >>$seqres.full 2>&1
 cp $fs_img1 $fs_img2
 
+loop_dev1=`_create_loop_device $fs_img1`
+loop_dev2=`_create_loop_device $fs_img2`
+
 # Normal single device case, should pass just fine
-_mount -o loop $fs_img1 $loop_mnt > /dev/null  2>&1 || \
+_mount $loop_dev1 $loop_mnt1 > /dev/null  2>&1 || \
 	_fail "Couldn't do initial mount"
-$UMOUNT_PROG $loop_mnt
+$UMOUNT_PROG $loop_mnt1
 
 _btrfs_forget_or_module_reload
 
 # Now mount the new version again to get the higher generation cached, umount
 # and try to mount the old version.  Mount the new version again just for good
 # measure.
-loop_dev=`_create_loop_device $fs_img1`
-
-_mount $loop_dev $loop_mnt > /dev/null 2>&1 || \
+_mount $loop_dev1 $loop_mnt1 > /dev/null 2>&1 || \
 	_fail "Failed to mount the second time"
-$UMOUNT_PROG $loop_mnt
+$UMOUNT_PROG $loop_mnt1
 
-_mount -o loop $fs_img2 $loop_mnt > /dev/null 2>&1 || \
+_mount $loop_dev2 $loop_mnt2 > /dev/null 2>&1 || \
 	_fail "We couldn't mount the old generation"
-$UMOUNT_PROG $loop_mnt
+$UMOUNT_PROG $loop_mnt2
 
-_mount $loop_dev $loop_mnt > /dev/null 2>&1 || \
+_mount $loop_dev1 $loop_mnt1 > /dev/null 2>&1 || \
 	_fail "Failed to mount the second time"
-$UMOUNT_PROG $loop_mnt
+$UMOUNT_PROG $loop_mnt1
 
 # Now we definitely can't mount them at the same time, because we're still tied
 # to the limitation of one fs_devices per fsid.
 _btrfs_forget_or_module_reload
 
-_mount $loop_dev $loop_mnt > /dev/null 2>&1 || \
+_mount $loop_dev1 $loop_mnt1 > /dev/null 2>&1 || \
 	_fail "Failed to mount the third time"
-_mount -o loop $fs_img2 $loop_mnt1 > /dev/null 2>&1 && \
+_mount $loop_dev2 $loop_mnt2 > /dev/null 2>&1 && \
 	_fail "We were allowed to mount when we should have failed"
 
 _btrfs_rescan_devices
-- 
2.31.1

