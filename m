Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E371A7D9CB6
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Oct 2023 17:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346173AbjJ0POl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Oct 2023 11:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345887AbjJ0POk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Oct 2023 11:14:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01F9186;
        Fri, 27 Oct 2023 08:14:37 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RDUs46031151;
        Fri, 27 Oct 2023 15:14:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=19zuK1xhNreUi4mic1lsNh0pHOR72uKVZdx/YwjsDX4=;
 b=TIpYP2ioyGZQrjw2TNbWOcSgcEpiMwpvCE/TnuvreTNpL/wUQgStrJ5z5V32m5/qfOff
 gKtA9EIpSZvokYSJkYMB23s5w4dqJkhgsTI9oxckHZeyqVWvFC7BBvPByk83NmY+qela
 l5YN1xz3Rs7/hCWgDCjJGjTIQqddWfviKpGMsUjuOPHs+DggVhNm7+OfQ0+GlG2PoY+S
 aefGEZG4FkFfJ37qUNSoZjxCzcpMI+fCVcx+QO2RFNzYPIGFmQGNafHtnS9SY4YLfxdi
 NllInEuM0hfT+0SQ3KEs/LtFonufHSzGBYIxAtbZCkWYTKda4xGdYPq6m17C9BjvSLvN dQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tyxge1nxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 15:14:03 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39RF48d1038079;
        Fri, 27 Oct 2023 15:14:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tywqt2wps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 15:14:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STFa3NbBbCjLoobtSKIccRUy3edM8jWQoi7D1wgKXkYIeB65RKU/i/R+mnJJ9pbob3it1yCPO/jj9+N+ay6muG/B9f+BvfPeCmBf5/1f7jBoLfrFYU7ykSzD9ACmE9PUZma4tf9ucrZSAtrC0f7GdDY39k3uyLnznGvNn8m+LlpVfc1oDMs4xwLvVY/Ci8q6dvvdRdGLGG7OfvMje3FT1JoMmwhBk2GUJ8cDvKb6rDyxtXAwmiA+ddAwcQPR/ZP0bBsZYs4IAo8PO5qgGDSubHtDfNPBIZWmOpb0AwhXRXhIApsWHuYa7Hpz8C/BAmCdgmFtdrWn7woXJQCDEq3vNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19zuK1xhNreUi4mic1lsNh0pHOR72uKVZdx/YwjsDX4=;
 b=EYIqIBrfTAUoYYAOQcbJYmANBYEEJAYDCZ9hfBx3HXHyXVxkiUBOIyHOjKp2005YnmCWaaXK7AsFDADmU8FunpblYZxeyJ1t2NoVceaDz8rjV2VFn63k/XY+NB87v73kK+yEIDCw6H+TreBN0NejGo4ozacfFKH1qmqn2Eel0ywlcadrGJcD3HLbRDxPEkUp8O+5flqvhOjf9gIDg8p1Z2xmUKMwIwSQB/WLqX0P40c6jMtz92uq9tDSouSydwrDo6NtEDhuHJTJ7uOvm1eBjR+uz1FIORRmWDbo6iufI7wBx3VSLVi6b3d/wMpUqd4b0hQX0pRb6ZCNnxycXiDhKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19zuK1xhNreUi4mic1lsNh0pHOR72uKVZdx/YwjsDX4=;
 b=KutIFOh/srdIbw1TUz/5yypUs25PyoO1IRLgU6bCQkpw0YxtXLbVR+LFz0WLun7+qtCXzOvAYcrtzBINuDuiWNyy6lU2jCIfQCHXkWbmjBNiYYIt44l0iP9BW5RUND2Y1pdpUIJcjpHpX3NisMxC+GJH45xB+EEIO4jrYNwc304=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ2PR10MB7785.namprd10.prod.outlook.com (2603:10b6:a03:56b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 27 Oct
 2023 15:14:01 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6886.034; Fri, 27 Oct 2023
 15:14:01 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [PATCH 2/2 v2] fstests: btrfs/219 cloned-device mount capability update
Date:   Fri, 27 Oct 2023 23:13:48 +0800
Message-Id: <cf97bf909b5a67464f5dcf2a802b7d80c79c472e.1698418886.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1698418886.git.anand.jain@oracle.com>
References: <cover.1698418886.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ2PR10MB7785:EE_
X-MS-Office365-Filtering-Correlation-Id: bfb72589-bb8e-467d-33eb-08dbd6ff59b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YmCl9CPjL41kDkCpq0GiUCsLVOMQfe1YIkBXu5s0U7oDwrqLwS/klvor7hMb1gMXEkMkVCV4EhOgZyUu+xiRdUP2v7nxlJaZla2FPRqc4kawEpfP9Zi3m8RFw/shupoD7DpTiTMfVn8f2vBdcBxZZniCJZ2VlTycp7Rr82GMQcgAobSDQA1slFdQ/Flp4OELRxZDJ20Ao4jBGAhj14vARn639N6UDUr0oaO97e/n80NThoPM1xDjfsrwEKp9OEKsPHjJoeoz/i9a4/dzxQnSaxk1FSxBQdGWINRBWgBUJRLJnOV/0AymPp2AkufWutQ/9no9bcj/+6hVREa8QTCxhCKoGWop2v3dYyUk47e60If08O4KKcgShuLk1+CYdOibOCSbAqzTTqlKBl7Dq/mERAluKMy4gOtJvChHVT9j7nRNnjnPqogkH5d3bBMkK88H9uqZj+TbeXncLNMXJlhxKox2HvVuwUUEQn7QyoPbXrmqzAnmUGVpmEGrGK699qhT1W6c4My5GSt+N4d+a58Eq1MCtJfi8DeIJst0yfsuKGs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(366004)(376002)(39860400002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(6486002)(966005)(86362001)(38100700002)(478600001)(83380400001)(36756003)(6506007)(316002)(6512007)(66556008)(66476007)(6916009)(66946007)(2616005)(26005)(41300700001)(2906002)(6666004)(44832011)(4326008)(8936002)(5660300002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U7glnvToqboWcqkurKXQvXWmdgFTVXFrHvv7mwtHX4s60JzK0xzLNyPOeOYA?=
 =?us-ascii?Q?F9HdmialP57aq9jlMlldIMNaWmWlPVSFNMTDALmue36IYiJyvuKKyJ2T57oH?=
 =?us-ascii?Q?abn3VJ9dUrqwxrCbNqTLMsD01u/vfJIrj7rrJgqzApAW/yxHRjVuV3JSxpmt?=
 =?us-ascii?Q?Q2RJTg4xQVuLDS3wqVfdTBFmzdge6bODl7MCLm63Zi92Sn82oyVuWOlPNX16?=
 =?us-ascii?Q?2FdkVMcaS/FYR5aQNTTUeE9M/tjcWnUGUpQK2yhzjOrcDRvwWGNztykxsvu0?=
 =?us-ascii?Q?ZXVDL2UykuvutXrjFZgIqU81rBnmgdn1OdR7sZtn6dpeTFOqetes9PlyMrVk?=
 =?us-ascii?Q?0RyuoUaIJ97gG5ttsIci+M1hE4uDTDQVI9mtQ54nhf8L04rX7FxhSwdJgiPR?=
 =?us-ascii?Q?8QcWFZo2wmKrfYdml+hNm1N3qPtdSvzDbCnYhSIXvoNHDuk5INXHHYgCTokh?=
 =?us-ascii?Q?2RCXsIv0m6SyK7yN++HTJweUlEWAZi3sChuWy3Ib4IuiGY+C/YxZJ6qM6F8N?=
 =?us-ascii?Q?IIfwcTHu3S5V7puTdFkZQUrCPK8ktbh8q+jyku81FP+K+Yj2klaBsw4PYU+m?=
 =?us-ascii?Q?bwbTxcf+wlUjK+78mEZ0QOI81iRviiFY4TEqORyhz9qcbpwq8Uwi3TopALqw?=
 =?us-ascii?Q?o2gVl02nW/oICibIRI5TR+4/XP/0jZ3CCu1NjUFyN5CM0Zje/AteqEzslNl3?=
 =?us-ascii?Q?Zh2SCUVXcynj6S8mftdWeccBw4ft95Al4uScXUOG11mupymTw6IAMIQ9grYb?=
 =?us-ascii?Q?P2Di52ZU350qNPnxg6z9ALutQmE6N8SfvGxi3Gb+3kJ3KxOeI9KY2F6Fw5d8?=
 =?us-ascii?Q?hREQTMw5YsJQ+BE0M/kMJYEn10N3k9VqtDtJjkn3oSSEGaCNjlNC9rFQYjqJ?=
 =?us-ascii?Q?MnbT1kQBe11iBCcq2y/ECwrS1QPRE0kTxvE5JLF39xxw50ZS5qSJy23IJN83?=
 =?us-ascii?Q?HKPT9ozF2XuiYRGdFd1q3G+Cg1PZGb4nEg/XaAI98dH7oGZUZF9XEr8yI/Vb?=
 =?us-ascii?Q?8oGbKFsnUR0v7T8CQAL2mJIOu+d0u7LC+ns3zSEY9b9CIBm2XXiP8FGgo92l?=
 =?us-ascii?Q?aIRxdEAEW96qdHs4OFlxw7MNgLvve38ENBLnMw3BicET8fc/sJastW+bmweO?=
 =?us-ascii?Q?ueHWYPVeL4QDBs1ZRMJAMvUdv6IF3YlM/MUW/7hZ7KZq6mv511P5Nuu4uhka?=
 =?us-ascii?Q?qVv3jkJzN4sLFT5OQ0cpIavZY9iJX+mF5LDHetfwu0+4iCHHdOqaVcuAamAf?=
 =?us-ascii?Q?ZpDf48OqAIknC8YNCWSeL3+xRgbDH4JvENMpvzCkWwghUpk4X/Dv5Z7Z1Q6T?=
 =?us-ascii?Q?LBCHWGOHNhLlZ20WcG9EKH2nNGa1I/xpAeazcjfjsK1Zt727X6h6jfsgg9JQ?=
 =?us-ascii?Q?LTce3RNnPycJE5GHCieA89/3g3485tguDXEnY0hH6tRDChZMz4N5WZORqIIA?=
 =?us-ascii?Q?NQyF93F7vyT88T55g2m/R5aUbzQbNjmDcmocLmjVHtLKWhNmagPTuCH+lHVA?=
 =?us-ascii?Q?45StPNjAUBNm5BtTHvyVrET+vW+r2jfHpL81+g8CTgN5BCBnlx/FS9bjFSr2?=
 =?us-ascii?Q?NDfGHZiX1+MKYCt2g/kzdLXkpspHG9pit5CbOCX8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tGp2eo36QCpO9aTI4ldyTxe7l7Wq4hTeHNFxxMoN8NK7ZQLXWL0g/8xMNLLZkFnDbcZba9ppqO4KfJFFEcOtdhBbQmUmXatzJ4863qu8J897hwR6PnOvKTdQNjFYn7hMEBTeh8utT2yEISK/ZaPr72hJJAayBB77XJIPwcPnSjHluxzyvgM/aJSQaATpsXTG1B9hWp3vkCs5rz+EJLkhzX28PF725MgyUisJl4KZWL9IPwUPGDpwbLr27CXmZhx08UmmjET9ir650Sxaw/kHUqbEr0d9IdcY1c9EajedtUrGdlxyd+q9kGJkz7AxwTMUTtd6/1TQOKfbxb83r/hMjGUr29aqqdZfA3c019r8hI4cNVbjRDQZveDFCjrGilzW9nJtPVkf3HokOgIRCbvUUPr81T3FmBAzGkUwuTKas8Bh9eNFqCmIt4wsBsOQFxZq4EEEFSMooOFxJy60g+nRvmOI88cB2gCYG6djoAbdfFaZHeahlRfhWFKl9zosguIJPr9xTD3k5moZCfWUAh9IDPx18s/WxLrJOPZilvQeyzeeNA9+gZzGs/kpstPHPzKtXhqMtQWG0wB1Rx0AbDf2ixh4k6IOJyHYLkmR+O5QThbG8KNURdDbhVjTrYN5lGYS/KEt7K++IgwlAB43xn8Gp367L0VxE30ii+NgK4jYVuJBABBv38KxnVV3jLxzAQky2DGTQl0WajNKkKmhKQP17qtbt4ei7x+JF3TtiklhN1HkCefLmIsKlaCY4iSxOBNwEqLjlu1Az+GjcpWJiQ9Wg5C9dVJed5IZf4kfJYyCfas=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb72589-bb8e-467d-33eb-08dbd6ff59b8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 15:14:01.4583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UIDfVfpu0V4xw4J6BkuCM6vG9So3N7TVjrQ+YoiLysvIK/s/ervcmP+D9/+LvMbGg9u/Yr99NA/H6NH6WHUejg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7785
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310270131
X-Proofpoint-GUID: 7wJ04ewUA2zAvPr_4KAfclsYLUUUmvUj
X-Proofpoint-ORIG-GUID: 7wJ04ewUA2zAvPr_4KAfclsYLUUUmvUj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This test case originally checked for failed cloned device mounts, which
is no longer relevant after the commit a5b8a5f9f835 ("btrfs: support
cloned-device mount capability"). So removing the obsolete part.

Additionally, add this test case back to the auto group which reverts the
commit e2e7b549380a ("fstests: btrfs/219: remove it from auto group") since
the previously missing kernel commit 5f58d783fd78 ("btrfs: free device in
btrfs_close_devices for a single device filesystem") has already been
integrated.

Add cleanups of the local variables and the _cleanup() function.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202310251645.5fe5495a-oliver.sang@intel.com
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Restores the code where it tests clone-devices.

 tests/btrfs/219 | 79 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 30 deletions(-)

diff --git a/tests/btrfs/219 b/tests/btrfs/219
index b747ce34fcc4..eb3e0487aa74 100755
--- a/tests/btrfs/219
+++ b/tests/btrfs/219
@@ -12,21 +12,27 @@
 #
 
 . ./common/preamble
-_begin_fstest quick volume
+_begin_fstest auto quick volume
 
 # Override the default cleanup function.
 _cleanup()
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
+
+	_destroy_loop_device $loop_dev1 &> /dev/null
+	_destroy_loop_device $loop_dev2 &> /dev/null
+
+	rm -rf $fs_img1 &> /dev/null
+	rm -rf $fs_img2 &> /dev/null
+
+	rm -rf $loop_mnt1 &> /dev/null
+	rm -rf $loop_mnt2 &> /dev/null
+
 	_btrfs_rescan_devices
 }
 
@@ -38,55 +44,68 @@ _cleanup()
 _supported_fs btrfs
 _require_test
 _require_loop
+_require_btrfs_fs_sysfs
 _require_btrfs_forget_or_module_loadable
 _fixed_by_kernel_commit 5f58d783fd78 \
 	"btrfs: free device in btrfs_close_devices for a single device filesystem"
 
-loop_mnt=$TEST_DIR/$seq.mnt
-loop_mnt1=$TEST_DIR/$seq.mnt1
-fs_img1=$TEST_DIR/$seq.img1
-fs_img2=$TEST_DIR/$seq.img2
+loop_mnt1=$TEST_DIR/$seq/mnt1
+loop_mnt2=$TEST_DIR/$seq/mnt2
+fs_img1=$TEST_DIR/$seq/img1
+fs_img2=$TEST_DIR/$seq/img2
 
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
 
-# Now we definitely can't mount them at the same time, because we're still tied
-# to the limitation of one fs_devices per fsid.
+# Now try mount them at the same time, if kernel does not support
+# temp-fsid feature then mount should fail.
 _btrfs_forget_or_module_reload
 
-_mount $loop_dev $loop_mnt > /dev/null 2>&1 || \
+_mount $loop_dev1 $loop_mnt1 > /dev/null 2>&1 || \
 	_fail "Failed to mount the third time"
-_mount -o loop $fs_img2 $loop_mnt1 > /dev/null 2>&1 && \
-	_fail "We were allowed to mount when we should have failed"
+_mount $loop_dev2 $loop_mnt2 > /dev/null 2>&1
+
+if [ $? == 0 ]; then
+	# On temp-fsid supported kernels, mounting cloned device will be successfull.
+	if _has_fs_sysfs_attr $loop_dev2 temp_fsid; then
+		temp_fsid=$(_get_fs_sysfs_attr ${loop_dev2} temp_fsid)
+		if [ $temp_fsid == 0 ]; then
+			_fail "Cloned devices mounted without temp_fsid"
+		fi
+	else
+		_fail "We were allowed to mount when we should have failed"
+	fi
+fi
 
 _btrfs_rescan_devices
 # success, all done
-- 
2.39.3

