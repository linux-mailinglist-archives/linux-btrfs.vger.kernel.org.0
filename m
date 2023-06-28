Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA82741096
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jun 2023 13:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjF1L5f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jun 2023 07:57:35 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:6582 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231573AbjF1L5d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jun 2023 07:57:33 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SBTOUG011292
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=ql4gqAT5jI7slKWxysceoAQqTV6FL3XDczLSlmv0WwQ=;
 b=PQIYgI1vOugK5tEoJScRQ5J2REqxhL/V2zt/xLOkpaIftvkj3W2MeEVCtEV9mv5JqpUD
 hieyHh5BWZX8BjEr0JPJxSvVJp1l0lUzjsM1rVmc3KGqpjA/b24wuJ0q0mcHSD8z0/8z
 OC0sJjoLxlfmAGLGB6RpuWN/kjRpbEtxoHW/7cfZ9RgpNTH7xIb1s1JB6+DMhCMWyCFT
 +Pye8TDbISOc8rleeQZ3TNkxbbw6cMVKQ4xW25iX4fa6GlZj0YM6fExWBAton9UI0EAU
 j66xBdw/bsS/Yd44pRcR0UDKWKN74zlB1hCH+mTT7J7mUNDvWC1KpVBNU/dmD9eo6KXx 8g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rds1u77pp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:57:33 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35SBfsFt029806
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:57:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx5wb7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:57:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTSWjukqdLKU7QZjTGe5dR/lJBacn6edCLdZ6smh56Yxr/5fMTcv4T+y0lES10AIEpOSfgBap111viyOe8F31WvzJX+P+c/bDJZBUnEzUm+QGCMI5rqniyPTXN6DbiWTi4/bD2kShbwLCaYd5gIXaMa7Zqzw3Y6mVV254/KCrSnUaYjnVMy8yRSOcOPNInOwGNfrMOO/LJi0kn1M/1z0d7Tuh2Q0UmubHTcP3Cu/JqnKABqPvUJwu1EK516RW2lNdYJSCueXrCY0og3X2s9LXjxxI3Gsmo5+byvO+YUOLgkgIM6/T0RB6tBJPGzR7kJ11Yh8X4cVF7tn27NDw2ZQQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ql4gqAT5jI7slKWxysceoAQqTV6FL3XDczLSlmv0WwQ=;
 b=NocIqQNQI2aX1/9G09HGL3HLptsJ195s7Q/g9et1HrEOo4qeRTABPwQfQStopWck2GHshdhEg7tw5OZ0OdLbMd6aE+JY5TPVJEXvlT/XG2WpCc52GA5c4Y4eUbFxvASynmDTJTK/Crlb65+qxmETUQLFmu5BERrXA/5qSYvrvtWcBaoiDyewVFQdYFHuIy2Y3OJnBx1+UCvbuQkFyTfDJ6cQ7GleacJT0Pxw65xjF1Z1j3xmrkr7pF/A8uQYPo0eMebnvJLu8fI+7Yu6RLkhrCXDLTVqnEbrSxyDoAFYGtCEdqXsYZ/U9LDgbV7GySu3UqD7b+V1jCYcgcZOPADbhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ql4gqAT5jI7slKWxysceoAQqTV6FL3XDczLSlmv0WwQ=;
 b=ij9toI2agmtqKRl2BAV7W4gWvUL/VhiBg5MxW/4Ewv+1bNTDuGqAa3C62fevaxonEAySJmOyVqhtW1UPXcVVhP0dW48fZ1/D2MtTn3JLqOvkJqrLPcUTmulvIQh+NjDUio73XIaqwiR9XRU+3lNUVtxwqewgIvVISPLjV6vyKi4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4700.namprd10.prod.outlook.com (2603:10b6:806:11c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 11:57:30 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 11:57:30 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 09/10] btrfs-progs: check: introduce --noscan option
Date:   Wed, 28 Jun 2023 19:56:16 +0800
Message-Id: <9a7e479cb5122a04adf00a434eb003d6b386b8ee.1687943122.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1687943122.git.anand.jain@oracle.com>
References: <cover.1687943122.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4700:EE_
X-MS-Office365-Filtering-Correlation-Id: 639d7c36-cb5f-46c3-4bbf-08db77ced9bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SrZCT4tdLbcW7UDtsOZ/qJT+uekSTnXFvYwfg/rerKsYzCaRBPO1/VQvs5u8D5hw4y+7pNTx8vuoLhQF/pYH6ep4StwfV25Kn1ptFpiiAgc0n3aMSZ7qKZtOOMH2sK0TiykOjxtYLqO4HQtc5Q6jAbZ3dZJDuWAbXXCEdIfhSbi/GBBl6N3zfvVF0yo4nVEAiDPeo9GqDfOo732Lh4nB0MP9UUXPd85fn9EylhvF0tP+HvYakpr6wJhsXcCl5Hv3KChcT82CqtBDz04Q5cjxhS1exkk1mirhxPcxQcVf19INktagqA5y9jlKoKsSWXBdd+Epu+lmiy5xOk2sVhdzJm+D/v2HhsdmqPRln2boNIbgEe22tYboOIXvGA3zWk9PgxyDtinX2peZjt9sHTNAs8Fmia0EL/Pkpt9N9F+x4XfTJwLI7SYLtfZ2k71QJpeQYLLwc8nKBylhfhgV7fVwVRKAOujHvdR3fBHzVyPNcrBHgdQOBLNc6hYYuCAWGf0gm8iBBsRsP7W8scgilv2JqKZ2y/0JZynqBYY3vTTkYUHZllUY5nR8CpfE+Y+hFAwj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199021)(36756003)(38100700002)(5660300002)(44832011)(86362001)(41300700001)(66476007)(6916009)(8936002)(8676002)(66556008)(316002)(66946007)(478600001)(6486002)(186003)(6506007)(6512007)(26005)(2906002)(83380400001)(6666004)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RTrlyUBmSFmKU20KqfNTPD6Jjl4P4lFthrWD786KBJ82sFCFEDGHQnJ66dfH?=
 =?us-ascii?Q?4FzK2IV0E0/sBPh7yetnNJMLRmv2HjOqvl1ObqqggGW6lS8XfheBvowXyTZ7?=
 =?us-ascii?Q?BDWsODZSY0+m/mkgykkyYDo+UhJKCL8DsMZ5HVYBgmnc9B4kxWf2Iv/BHRsh?=
 =?us-ascii?Q?CIQkoc/g0pregdUyRavFFJGR4zwUT9keO2n9V9nS3rAN15YZKhcplSqGFr21?=
 =?us-ascii?Q?b2/S4sdkolVTEDVndZJUarrZx2jmBqc7/u2Cms/gsuWPbtH5VU5jBPkoDpQx?=
 =?us-ascii?Q?rlOoqzTywSV77OIipACLHTtGa7CYJl8G9kbiGr4DH9KiXxVRZPbgAzV1ts1L?=
 =?us-ascii?Q?W0eAOPA6y/R51KATQGPMhnpzks2sgfjX5+xW43GGJtOBGZTXTZvA9oqZBa70?=
 =?us-ascii?Q?h9g69GpPr88b/HGlTSa+pseDSkBMb5Jkr6NwtgkSFj4s8ywQz83dOLzhFKo4?=
 =?us-ascii?Q?QYmyK9dxQcbl0s8tS8jkvyewkMwjKy02FuldTltjV91XTIRqzabA1lX5GpG0?=
 =?us-ascii?Q?rMFRhbNblEcQ/qRWiizB+3HKbTm8wZm1wx262cIz39PshReNa68oBhpp6fI1?=
 =?us-ascii?Q?aQ9KNRi/E6TEkcL+4D4v4RaapblbivvVgwiGtOQkmeTlPs2L8vRTLdfKtPll?=
 =?us-ascii?Q?q5jy6iyvGI3NFltZOHwXHS/8eAIP78Gon+h58MK5yoC9Xy0Jxpa3bxsy4vZS?=
 =?us-ascii?Q?AaxeFzejQNifnJhYGtgaTYts7AbrNr9krFQylGhtvO//lbQFOJVg0WY+Slz7?=
 =?us-ascii?Q?vZ27sVp/pB7EhHuTtpwanhf5R90U7JW++wMFv18S/4Zc3wKbQznvTnrNJFtH?=
 =?us-ascii?Q?uz2zaR3SRc9Dt6QEosvw1VYvfM0zRWnjRC8bMS3qk8PTfJmXDDQ3m/EPIHFi?=
 =?us-ascii?Q?nntlck4g2kta6ABYEm+tlDYa2uYQSKJlz64g+mfgKtKo3Thj/CvrRtfTseGo?=
 =?us-ascii?Q?ZbcKIriqj2LX+BNo4xZvCPP/cm1hqAmGi88DoF/jbbgJ1j4Lbi5wsuMpgyXh?=
 =?us-ascii?Q?MBfIYaRkA4n9pyd5nQdUTsMUb3vq7SPBFG5mVlE1YMIqUFPQIe8s5r9nWXRx?=
 =?us-ascii?Q?rpZbIGPKo2cQYzuzvR+ZGhk8O/OF666i9Fu6Yg+zy1q4NGNn3bRxvBXQf6Do?=
 =?us-ascii?Q?nTCBez42wneaEulMJRLOFouNxCTCGhvZ83wesIaUlH3pKlqhfuzfzFlHQjjh?=
 =?us-ascii?Q?gvGehAPQG9RqCtcFZryj5sASwuZa4mAuhIuq8FFjlgjHDz2EMqOZqjVhpns8?=
 =?us-ascii?Q?F3KMqND9hGk/nBM7V+l/hht/lNliEJADb7WogliPGnoOe3sGjmeTGpqJg6ej?=
 =?us-ascii?Q?TppigUiQihD82MnnD6RnWMy6lxT4/OBV9jSfVNT+np6FIhHJfiIIWrd3cSF+?=
 =?us-ascii?Q?TCV56BLlWxfJFsKzemR3d2gK64NqKfzmptwbwgzk/Al8qmAFp8tFrPLJNrlO?=
 =?us-ascii?Q?xQPjp9ZrB7RZXi9toEdaPRN9JNvkyuH/7FSZ7nRdZVA2vxQ61eT/Brb4BBvK?=
 =?us-ascii?Q?Eg0I5YO+QT0yy/8i42fAcf8wmQcCkSzUxIyuRSXMT3HruSb26m6Itt6aHeDI?=
 =?us-ascii?Q?KZnU9h3otdQmMELEZivoInBeRhHKSJJekmmnA8HeA905q2NZM/s8AZXWOGgX?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: u6X259IO1UfJizI+eZRpUo0uwOsSChCUY+O6RKMFDBbxSpuh23uZZ5HLXr8INt+CpzRYMkDV8WE1y/zen0rWPqNy5bUo0fem3YMhML0JnA7ePcj3uxK3jNd+5l6x3aoEC+rhrVUjnxCXtlKnKhq9Rwva0fdyImhx2sZ6jVewpG0vq4q0nJGaX4lTbhR/RNEsr+7+BCVHiPv7bGtn1Stef1RSxj7jNUE90n/DiKN/LBNdsUz0bVhRWtcMonaQ59s4CKCvM1FiNfLtU5MV5L8wAym6Iy42Fo1xfE1LYN0zCNNsAY2L8m2wh3V6GxBzfbPpxh+0huvIXuGqBi0CDcViE6NrowCVGRDnnJCLbM8QnNzG1OFf1XXkUWRC+jbHkxN0nGxVHVuob8ivUMD7+GPYSNlJcPYQskkCrlNdL3B1h60TXZu6eJW23WVP/ngou5tVqnI/YpTCETL3f3BSVDU6f+VWIs98XT/i1BftDFaCuvLVzjR+11UDycy9+I1jN5vknybUh9khHXCNqUB/IKbVUywFPteD6ZzXp7rPSWCJ0fTWFOKsdQ0YOu8s8fRh5PAkc2FZ1r49T+y/0UWaI7vDIU/femd0MFNN/Af9L8qO5JBN5IeYkKAbHLGJR4u/I/Ld2ec1iMdUyul/F+NLjtRXs9fzc4RG3aCzS+bawKl+gavsCPkC+/MsOLcQB1PvisgDCkW1l5U16TnGsLFerFwoXcP9FdhNtPG4OcWo0onuLoU29F/veHcRnQyAJebqkXbZvijsd5K/IqFkwh7yDF3LQA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 639d7c36-cb5f-46c3-4bbf-08db77ced9bc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 11:57:30.5739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pt4176izr0ieBp8UwiisjYMowUGrWRbFfluLErEZHlvDq7NoHQEr8oUPzA+D1/rtdtHIqMLHDprpCfA1vWKO5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_08,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280105
X-Proofpoint-GUID: mFlyn5eHbKT2C5eo_zBXHQArgzUUVUqX
X-Proofpoint-ORIG-GUID: mFlyn5eHbKT2C5eo_zBXHQArgzUUVUqX
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function check_where_mounted() scans the system for other btrfs
devices, but in certain cases, we may need a way to instruct
btrfs check not to perform the system scan and instead only work on the
devices provided through the command line. And so, add an option
--noscan.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 check/main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/check/main.c b/check/main.c
index 7eb57f10aded..d4aa0db2514a 100644
--- a/check/main.c
+++ b/check/main.c
@@ -10015,7 +10015,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 			GETOPT_VAL_READONLY, GETOPT_VAL_CHUNK_TREE,
 			GETOPT_VAL_MODE, GETOPT_VAL_CLEAR_SPACE_CACHE,
 			GETOPT_VAL_CLEAR_INO_CACHE, GETOPT_VAL_FORCE,
-			GETOPT_VAL_DEVICE };
+			GETOPT_VAL_DEVICE, GETOPT_VAL_NOSCAN };
 		static const struct option long_options[] = {
 			{ "super", required_argument, NULL, 's' },
 			{ "repair", no_argument, NULL, GETOPT_VAL_REPAIR },
@@ -10041,6 +10041,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 				GETOPT_VAL_CLEAR_INO_CACHE},
 			{ "force", no_argument, NULL, GETOPT_VAL_FORCE },
 			{ "device", required_argument, NULL, GETOPT_VAL_DEVICE },
+			{ "noscan", no_argument, NULL, GETOPT_VAL_NOSCAN },
 			{ NULL, 0, NULL, 0}
 		};
 
@@ -10148,6 +10149,9 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 					exit(1);
 				}
 				break;
+			case GETOPT_VAL_NOSCAN:
+				ctree_flags |= OPEN_CTREE_NO_DEVICES;
+				break;
 		}
 	}
 
-- 
2.31.1

