Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86403EAE56
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Aug 2021 04:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbhHMCAZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Aug 2021 22:00:25 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:42896 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229919AbhHMCAZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Aug 2021 22:00:25 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17D1umKP008939;
        Fri, 13 Aug 2021 01:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=GyCFn1YRKMYK13Rygn6g/qraAJfogh/vjNcDtRNt7SE=;
 b=ms157C/MaQ1AYnZso6jX2YTY6HunBNtKdjsBECIGGqJxeElRZIXFZytPNucNN8mGSZdp
 XeWg1D91BrSZtW1o1eQIgcuWPgL8Utxv72+j/6D0E3f5yuzVmi/VeKQnxzkGMmWvb/L9
 HA0wgCWPEznuzOB2OTCkER6jc6lj3cmJj4Ogsnu0ZCo/PeCc03HomYUGrT1GbpqXTFIn
 R5VPVgO7xe/hFjtRhy+a7YuHf35LT52B04UgRIc+nAs3Aw8yDlfwwpeZ0dLwPqQJoOZ6
 /3f1bVLtgQuqa7SPv/KqybULnIHl+/+URlt4Zw/EhUEF5nCPjIX8ZdQrw7IVwv+OFC+0 nw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=GyCFn1YRKMYK13Rygn6g/qraAJfogh/vjNcDtRNt7SE=;
 b=wNoS7LpPAMKP91jdGfjuttlQ2++OAtOTb0doOdMCNAy+GR7pAXUnUXpWD1fdZh7fXHHY
 ZdQAscwHBG8YovVfw63peQYGT4cmestQLLRwrJreQGZs1NeHKMfW7cRn8wLOQsrBJBvV
 5bgW/9TUBMWlodN3b8zh3PBt028kA0AyELvYBa2fafI4nMjSj45WDSOqOK4z482B+lTM
 cxeCZPK4Gsmz9AKoahMMVy7zOpg1SkMMRFa0SKB+x1ffJ6ixloWqnqruzt6LQDnCXYW5
 0j1oksvV07doeo7snlaeeeCxsXgjyZ9OEuccs2fYVf+CoSfzfopUKMaGyNkSVmAfKr+L Kg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3acw9p29jy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Aug 2021 01:59:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17D1udAA112689;
        Fri, 13 Aug 2021 01:59:58 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by aserp3030.oracle.com with ESMTP id 3abx3yv9nf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Aug 2021 01:59:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSIkzmUIwnh85idTfgfcauUjH2Qm1CtDxWEeG9Uwvdfva6hRwvSZfJSK4f5ph7DBy5PjVPjKw/YTpmohoEVjApN1MOOxjRsPNpzRds/AN47vTX0WgNu5cOHU3Dr6YfK5uEVWZNWLLvL60uAV3XH1rpaLg4qM+9XFYwklHiwEvvpLjs76UA39GFjm6KbzFmjHTAfMrz7Zt/HhDmjPl3yKJnbKxowZ7pGVWsRhQ1Lig9yZxL6qxIju2ZwkGWFOLZCtRNzcjjZA/VRlhNfwlyfzzSKVr0gdFqtL0o5UQ/Y2ym1teTbIC8fGUhsFkHN/kugfKO5CGq3ZSa7kxTC2sw/Eew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyCFn1YRKMYK13Rygn6g/qraAJfogh/vjNcDtRNt7SE=;
 b=m2+DOn87Vxbti5Oh+vN8Y9zxKEudiMxVdm9aK+5zuzJbBE9OFf1ZyLdDpzgkuaqPjEQXO8KfbkDfVT4v/wLfUN+FGQm5rUSsbJGGybgwTnzE0CNEl377u86BHcqibyQAT/+7bjnCaZeDG8vUUvA2d+uVhL0acyXWc3QfyJ0r6fc3nQTTBmBxAGtUWSjPJdtGmt51yEnmQrW+Z9v/zn6uER8f4hdWnSp5ED+tE4Y9qylwzNI0e+FfmQzRHxmmyb9DX5jbpuVMg1gRW5zCTrQRJ+UG/nD/k8nL96gIfsmvVhtKvNAaT1oTjwT/232urztm3e0vbfME7zpCHA9Aly7NBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyCFn1YRKMYK13Rygn6g/qraAJfogh/vjNcDtRNt7SE=;
 b=b2m9oNh1NoUZb362zr68kxKd+Of7bSDNRXTyQrCI+VCHaS1HPG7hKs/RWI2yzHaoQbsu0JodFAxjObsZ7tIIjspmGSPW99myFfOVQOl8XdCRGfWOuBp1aJ5oxkEtfU+pyDOhCXYteVKCFkYUTvlA+OsmIRFh6qg7aLOUYokC/ew=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2771.namprd10.prod.outlook.com (2603:10b6:208:7b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Fri, 13 Aug
 2021 01:59:56 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%4]) with mapi id 15.20.4394.025; Fri, 13 Aug 2021
 01:59:56 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs/220: nologreplay support older kernel
Date:   Fri, 13 Aug 2021 09:59:34 +0800
Message-Id: <1419f13a972043a6e7d2de8300adccfd29021079.1628818510.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628818510.git.anand.jain@oracle.com>
References: <cover.1628818510.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0191.apcprd06.prod.outlook.com (2603:1096:4:1::23)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2PR06CA0191.apcprd06.prod.outlook.com (2603:1096:4:1::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15 via Frontend Transport; Fri, 13 Aug 2021 01:59:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93aade8d-72c7-4edc-186a-08d95dfe0c5d
X-MS-TrafficTypeDiagnostic: BL0PR10MB2771:
X-Microsoft-Antispam-PRVS: <BL0PR10MB27714C2ACB9D10ACB5D6D953E5FA9@BL0PR10MB2771.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5qRcAnGyT3CDexstWmjeFCvVSWwV2SsQLFSQ2WjgGE490T376kIa9Ch/1jtfOjOktlUs+MVBwetWC6K7f4FngGDU690G3Hzpvqo9H5aQoE9ErDtUCrxC83UNjkHxpwdn+yqFFzErixf/UL7Y8HVN2sdD5oNhQdYET6pvggEcSakousFnrADLmLT9dOxDo7hzNsF08F7sbUwRPRxGwUpEdtidIbcycfaqgveQ/RxiE5X99J+vpY7pmKQlnwLS22u4o/vkbQqiiV5az+ff/dXFL7ugVLsjq2GSaw9f7OlrXqA1RUoenpei4NA/JETCwKoppNM4U1v0N+90mOv8+zMiMBOqrR4XXDId3pd4lodgDyhA6Y3brB5PkV4smdoKJoOcE+fNCxi/lx+ZkrTfaicE/JYMREmIluRveoWmbden88X6IWi7LxnJKORS/kJZ+/bIzylLoLidbEXLvOQzYGntaYMbxoyK3EEEO6x581iZGkHwhgVtNum/q/XCOi2TNKzPDtSNzLmeXTovnjh5+If3fTAI8rurSAfLRNRiZi3sPzcKYi3d4stRREuKmiD3+jOmi5030TQ/f3cpY+Lr+KmhRa+b0KFrziLFjkWPpW1Ih8ZjQE1Q+oBqS9eIkRkuRNdJIdZP5itwCB3xCsuXV8emQ9L0zLmTahdtttYVEKnBDvOSurINVBUdVeGO4CcR8y4XpD7DPHZkIc64KaiK+wIxuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(39860400002)(376002)(346002)(956004)(2616005)(44832011)(8936002)(8676002)(26005)(66476007)(316002)(52116002)(2906002)(478600001)(186003)(66556008)(66946007)(6916009)(6512007)(6486002)(450100002)(6506007)(86362001)(4326008)(6666004)(38350700002)(38100700002)(5660300002)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KmSJBZd81F4Ve7eSmWcRh8RS0a4gUuVJ3hsRBHPSmAg+/Xq8P3IfyG4HiLR8?=
 =?us-ascii?Q?nFkfQzLlsbETUJg8fxGS3WAEr8+/SZ1SiAvGsT1M8HQ8Kr5SORyN/8MdKqLg?=
 =?us-ascii?Q?1IAg8KjN8O85Gw14XjoyFWvkC2H9LmRwZHM11TjmGMLAo2WxKVLA+DYkWLO5?=
 =?us-ascii?Q?GQ4VpoxY/fg16yDIal0RlTU7q3Rfc/oTDbB5N9B1btqiOsiityPTJLdYIYm7?=
 =?us-ascii?Q?dqPRSlCInU3plvg8jJ9hlUx+Z3ZIpvTsIjr3UqbuMWhTNp35XuNTJT82S9/J?=
 =?us-ascii?Q?kmL8RR6imcn7XgDg6kTblPddbhfrMrsmIcpUAFKRLMlO6hZqhtaZBf/Tli1I?=
 =?us-ascii?Q?M3kGuiro8o+X6PUgzxL5LK7fNv4LDoqUKFamefjUbkB1ZugyxMU2nGM6MLaI?=
 =?us-ascii?Q?eBSkd/rFQ3/+Jr2/jhMCXupClJTcJhDqsctFLMrqltMBCPC+nTvzkzVlOyNk?=
 =?us-ascii?Q?EzdW/tmfUesdYaoNyr1mGc1tcTWkFin47628yTueKkv+PT4xVbdY0sekqR7w?=
 =?us-ascii?Q?w7JauKgSpgn8DKZsq3u+g+V98vNdMBfFZC+7n9TEdB4gRWingblGVCr/F7mz?=
 =?us-ascii?Q?jZvNbiNalReHjxqwYow8Hs4atOPHedNpB1rfCh4b0ngZ+Z8FArZ+FZ+FBmPS?=
 =?us-ascii?Q?9Y9/l5iRtqpMwgnuCzXUA+zZJnP7rcT/qy8Eu3UJY6IMlxVCAI/eJ5ebYPlb?=
 =?us-ascii?Q?oT3x7qsOIJMsMhNsLIz0MHMdXThat/KXxJu65aTCg7Prxkjg04HsPqZe8Enx?=
 =?us-ascii?Q?xIs7gzSadkS5T611bt7vd55pd6y3w0Boo6x8CIr8JxDu/9FMkBzfApNdPmwk?=
 =?us-ascii?Q?zPg6LAMRxz52bLPEH3mmOwBlWdBWoU3Nh+Aydv1tvcN6WokD4b7xSKJZJli+?=
 =?us-ascii?Q?xB7UKJL2j/IiHYHZPtt/z43iaq6S7J76SThB3A36BjEDGa01ZceVqxkHWOLQ?=
 =?us-ascii?Q?HFwIRocX3UftatDhbGc8puZEODsIwOj4lWBiREhWhau8UovNyCnZRbuwKohS?=
 =?us-ascii?Q?BkyM9Ve0zTdhYqjaz+quHMYLIRnDT7QFTz+9NiQClviPBl53CNrv1mCqsyu+?=
 =?us-ascii?Q?Mt4WSESnOep6AJPVPgFrgVLnNWE2oOlQLThz4cYWLcjsub9PAE4/Ysb99P7V?=
 =?us-ascii?Q?Oslgtp99OTA2VUqRwZaJG7BdSxsavF76NAD3ZkTLFck8u5fgWSu/2849CFPH?=
 =?us-ascii?Q?Btw4VJyOahJhT4Gob+9vrk14byQ2HnIYpehsdXL3xtqGtu9Pyy78XBOyIqI9?=
 =?us-ascii?Q?SELMlp/W6SVPsQUK+X5zniLzMQUHrrLBdES6JAwvLOoS4dp5HCfV79/lWRyr?=
 =?us-ascii?Q?am3s2WwFzQV6JWrQ2fNYBDGL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93aade8d-72c7-4edc-186a-08d95dfe0c5d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 01:59:56.3903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFuvUoljIv8RCZaE4oiPN08MEN22lSB1Lw8iQ5tecfN7D2yfXYUOOmuic5P0VXBnheJGiGcruajJDUnWXKKXhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2771
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10074 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108130010
X-Proofpoint-GUID: Cqr8bY3ewWpfH8hOjc6RTj8NUCsasg9t
X-Proofpoint-ORIG-GUID: Cqr8bY3ewWpfH8hOjc6RTj8NUCsasg9t
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

mount option -o rescue=nologreplay isn't supported on the older kernel, make
this test case older kernel compatible by checking if the mount option
is supported.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/220 | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/tests/btrfs/220 b/tests/btrfs/220
index a01b28a6e42f..9f2f07d723c4 100755
--- a/tests/btrfs/220
+++ b/tests/btrfs/220
@@ -209,22 +209,30 @@ test_non_revertible_options()
 {
 	test_mount_opt "degraded" "degraded"
 
-	# nologreplay should be used only with
+	# nologreplay should be used only with readonly
 	test_should_fail "nologreplay"
-	test_mount_opt "nologreplay,ro" "ro,rescue=nologreplay"
 
-	# norecovery should be used only with. This options is an alias to nologreplay
+	# norecovery should be used only with readonly.
+	# This options is an alias to nologreplay
 	test_should_fail "norecovery"
-	test_mount_opt "norecovery,ro" "ro,rescue=nologreplay"
+
+	if [ "$enable_rescue_nologreplay" = true ]; then
+		#rescue=nologreplay should be used only with readonly
+		test_should_fail "rescue=nologreplay"
+
+		test_mount_opt "nologreplay,ro" "ro,rescue=nologreplay"
+		test_mount_opt "norecovery,ro" "ro,rescue=nologreplay"
+		test_mount_opt "rescue=nologreplay,ro" "ro,rescue=nologreplay"
+	else
+		test_mount_opt "nologreplay,ro" "ro,nologreplay"
+		test_mount_opt "norecovery,ro" "ro,nologreplay"
+	fi
+
 	test_mount_opt "rescan_uuid_tree" "rescan_uuid_tree"
 	test_mount_opt "skip_balance" "skip_balance"
 	test_mount_opt "user_subvol_rm_allowed" "user_subvol_rm_allowed"
 
 	test_should_fail "rescue=invalid"
-
-	# nologreplay requires readonly
-	test_should_fail "rescue=nologreplay"
-	test_mount_opt "rescue=nologreplay,ro" "ro,rescue=nologreplay"
 }
 
 test_one_shot_options()
@@ -304,6 +312,10 @@ enable_discard_sync=false
 _try_scratch_mount "-o discard=sync" > /dev/null 2>&1 && \
 	{ enable_discard_sync=true; _scratch_unmount; }
 
+enable_rescue_nologreplay=false
+_try_scratch_mount "-o ro,rescue=nologreplay" > /dev/null 2>&1 && \
+	{ enable_rescue_nologreplay=true; _scratch_unmount; }
+
 # real QA test starts here
 _scratch_mkfs >/dev/null
 
-- 
2.27.0

