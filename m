Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DA0741095
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jun 2023 13:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjF1L50 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jun 2023 07:57:26 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55010 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229456AbjF1L5Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jun 2023 07:57:25 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SBTQkr005288
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:57:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=ly8TthvVptid9kHhMGjloQHFFCY0mawizKNQHOJJjZM=;
 b=p4X2lDuuQHiUJruCjKgyPxhvoTtX6j+C5+JR8sAP0tOylQxPxCgDdr0bLuZDQGRUl4oy
 1nSQb1EnU6bjbf3gYAqd/uQMl1QDf/BM4HCpDyDRYFN6P3dqjRpbcFnrDIsJ9aAhFv0/
 rslUK28HOe58vWElbR9yiLYxpsBS9wbZ0crg90mfKcrzRcvfAmTQWTfKDBIVGURQg9/k
 XlmnNRxkRGYGqsRjtEra/on3qzLlibLdqle8E/j3JUdpz/AuE+6i4eD+VIu54K9Ggb6C
 1viBMsE4hg/ac5z/Hu1d/gxdRjbYDcNZugTzegCgB3YyMViNXmbzgqBD5UsOwgxDg7zA Ew== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdrca732n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:57:24 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35SBDcca029658
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:57:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx5wb3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:57:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nR41+3FuOnNS8dbDsNWvFzmq7l0ZyNGqfyt+sYWkQ1HPsfZWF3PNsdejKEzw1IVq0dMUUN2Y+8GOpOo9GhI/mfGPHHvrbB7dvHTeIW9wamkmFATfnco044BaRVT4G21RylFSUNCskyANafoms6ySZj98LQK4sUeBd1leiEwYipiZ00k7sFsAkEFHhUq0fKWihMIzXN7ZplhxqZ4F6DNxDKShndNo2dPTH+bSnN1NoZvEzc8eEOkMtnx5vsPByR3tduSIDhMEJ5A2RzcRiJRUZ2AFHT1EAeGipkJJQQSpR6Da+gGUXvsV5otu32zcdjEkyR2I0LVaLg8Vg9qeRfKuEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ly8TthvVptid9kHhMGjloQHFFCY0mawizKNQHOJJjZM=;
 b=doFEC62DYIQJYOq8wawRb0R//mkffrPaC+fbn2MqG9g/dYLR5uO+wyhG326dibwHMmxRuCkI2foiWa0KiXzRb3vEeXlz9hN+Z/mtRY8m7mcY8FiXTULc7PzBSHLRPWRn3UbUfwBqjn6jjcKXG1s7E1GGifA8XDZemPPL0NyOyQyfig6nST5naOr4NL76VN0Tu8jfKHZ8SmJpJXx7uV59mEVKNEjFlMlcRtKvaJPQ4EkiDliSVSzriTkqT7DKnfDsjnqA4PnciiLEAFKgaIt4cJI2UjrdSAv040SHEGj4XfEnvipU5bbOzQD52S7KgePkeJV1N1vjdoQPXtfiF4VfQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ly8TthvVptid9kHhMGjloQHFFCY0mawizKNQHOJJjZM=;
 b=J1G3L0okXiQkY8S7Nk0ZG2sODzVSWgqp+8PJCNjSNL4s65XK8v1FcGc/s4HBQJ/5Guq4gMUZS1UzLENviBVPvJ+LmwfkbNdsbQQmhpVpJ9L0EOw3gLOHeTh0QFOcJMs3uiWNKxoV6wMruaQgMulDZFdmJzFBj2kXovicTPlMuSw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4700.namprd10.prod.outlook.com (2603:10b6:806:11c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 11:57:22 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 11:57:22 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 08/10] btrfs-progs: docs: update btrfs check --device option
Date:   Wed, 28 Jun 2023 19:56:15 +0800
Message-Id: <978b6965cb3a3b5153c58c1fd613ecee7e4c8f1f.1687943122.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1687943122.git.anand.jain@oracle.com>
References: <cover.1687943122.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::19)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4700:EE_
X-MS-Office365-Filtering-Correlation-Id: a7be162b-3351-4a8e-8910-08db77ced4e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PjITDRju9sHGKOsDvGmZjIHLzO6/jGYkkDmLJ+c0ghr3ednxZNv3Hf07rlLwXy4+VHdpiqpmkhmYWmcqIR2bufydQe/pPvelCEIzZZC1m7Vk1+rh05kgTtJDJxI3tzpQwYdLyRthPlCXYA90ja5gkebBA6+xNuSiJFmPHF5VukVtGUnpF5JQH8ZbYGIlK24RsmPrsB8pg7D4JRn1cc00W4CAe4RA/u4UuVlMNBxbZ4gS7NVqBof5RWRf4lAJ1MQ/MFTjptOUgimqm7NHNy96D9iBYuOBeWdYciX8+A7bJRIzdo1R93sh0nfrjviaTiZ1vIp8bsHHgpFvduxTahpN4RtMVHl4oAu1iYRob7NaL3ppa/uLFF7DX5XMKYANriXFiO92ZhhxlBq+yEiaIhasmZb/qcFFPxd2QgRir+QhyegV/5EqC+3TIfJRveUlhjdsO69eZhi8mnaH6EPfZI2nlxMqmnyj2T0Ac9SivXEfGaT6OiaPCiw9HrKW7pJdJESR0JONSLNGsfV4Xkrh3bDWL6by7XLIR5Bg/VgiegPoPzBWrtQtTtOPz1XFTNnMfOeo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199021)(36756003)(38100700002)(5660300002)(44832011)(86362001)(41300700001)(66476007)(6916009)(8936002)(8676002)(66556008)(316002)(66946007)(478600001)(6486002)(186003)(6506007)(15650500001)(6512007)(4744005)(26005)(2906002)(83380400001)(6666004)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cxz4a+q7Fih4LLv1eJeRg81ch+qQK2cFgGJJp29XunY2ujXyLCrMStLqqJF9?=
 =?us-ascii?Q?2l9IytFO2h4BHl8g4Ws3ad7IgQ6lMl89UdULFpzc54UtXG9Pt4ipcWV7Hn/l?=
 =?us-ascii?Q?RZZqCgTVsAs/nE+Ii40/ZYhi6+h5oUal3NTSkY7ddGRXnSHuylXT3kC+6kTn?=
 =?us-ascii?Q?wZzO00p6imZtM0KKW8I4QPzpT1YJZmaHK/w5G8szPCQDpw9+NxiADtaOl1sb?=
 =?us-ascii?Q?LOZVhc26Us43S2+A+bjAzMsGLLEuK9V+a62G234GzMkT/pkdzNhSDJqBQNP3?=
 =?us-ascii?Q?A0KsSmxkmYUNcVU9mpHwVi0917oHp3K0ovmlu/AOtuglTgLkqhWx33QiM4YB?=
 =?us-ascii?Q?qYplWZyFFZfzyNXZ+tfVmbWNPLEU8dfABFYmZBt823dif/OkmIlyzL14eM7B?=
 =?us-ascii?Q?R3bOE/ZgOAQMuKT8Ez0RM7+HpUZl01oG9yey3U11j5+CpPXLitK1Oi3EN7hB?=
 =?us-ascii?Q?yT+OJlT1f7vOvnSOrSJKStlkUU3TQ8X3IvWEWRHrcRz3vBIWmn5YuyiPdcUK?=
 =?us-ascii?Q?bd0KfOdMqULbZeFeQANQjLYlrGnk3qZ6eh15/cVaZNXsYfs4zJMrinpI8Oal?=
 =?us-ascii?Q?gPShBhhpfaqJOyk71odE236OikUAFKLj6BlQSPvx9KDLD76mvftO7D/QCbx5?=
 =?us-ascii?Q?QKjcSidnb5mGXJJc3+Mgw2tXV+fB60GS+rQLsm3FHs8zxRW0PzlfZbOJQPPR?=
 =?us-ascii?Q?3GefIVzOETJUmOOlYtdROKu1moT1YPzs7VMSa37i4mPmIpw6FTyuSmnnnwh6?=
 =?us-ascii?Q?uFuyt/M4JVNTFG9V4KcAik1mpqxDbEWZhXRfrsQ9rkpg1V5bAPqI7GkljFPD?=
 =?us-ascii?Q?KkG8+iGhgbw3pfQUVer5ed3+OViCTPwrOq8crq//4GXvWoi14YhvrRUbtCix?=
 =?us-ascii?Q?Ufl2r1oYQc05mb5VZIWniWIh6jd9jjVtEvrwYk2n1Gmn04iShZUGNwdccJQy?=
 =?us-ascii?Q?6JM+gx2iau6uxYoriUSwkDUgvPyA0IukzYKbINQFpzow08y+2hpDrge7+FHa?=
 =?us-ascii?Q?0Nr+L7a1Z2TLEZCB1CgZooPaX07geMUrAk7Xj1Ez9bze8u+xRM/yBFq7R/8l?=
 =?us-ascii?Q?48m+c35D6AOeNN3mUurrhEurEPbQT4hM0JIsNIG6ZfVhXC6b7xwQd26dRgzN?=
 =?us-ascii?Q?fRUB1w7opuwRZw1HpjSdqsk3H8iVqTSmGUTao6mEVpIvZ2O0/MjXjVucYWNk?=
 =?us-ascii?Q?+b6AUFIfkRZ4bjH7wkm6vlXiorbOIWsYwZeiLi7DoAl1XU+aitcVRZzWlJM4?=
 =?us-ascii?Q?kQZJY3N3xhZQDco19QCrnSnQTKKZlhAgwf7VThAWwTQK9DbpsDvSlE5QH0w6?=
 =?us-ascii?Q?Ws+X6115kuGQJ0jIXwCeZgZ7/FEpireZLVbnM1tUM7hPZLNlI0owJ0TX8CF7?=
 =?us-ascii?Q?PsKYeN6RTYY+4bNlXL0PJAQuK0DPi0i4ERnLIpD0tDiYXiGJceWKuEQzYJMb?=
 =?us-ascii?Q?Atb+0PGZYHEKTCkNNSm02ZMIBO27nd/6bOILHh3PpeWMh+eTceSkGwitQFEH?=
 =?us-ascii?Q?s3r+UwCMqsW+308ulXDXho3r/Hy+AIiCXdoglkbe7FXKkZEaNc5F+nzOpAmE?=
 =?us-ascii?Q?RO52SURK/Go9hEsDcPIOwMOQJOvqDulUeLTB/Cw13WVg4gmKCgD9BHYU+dEs?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wGPu9ZjKkUu+uxMDK2idbz3ahT5m+6Jefs1YuIz5YnWVR/t5KXnhgM2pePyVOgztaNfXPMOWCDp2YoLyPf7yYwmVJV8tHiZp15w3XkZVo6grYHWPcRk5JEF8GvRy/v/ONaamhJ2apdByoxTo6Y2lAplZ5QX5OoIY0G99NoBV9XI4nSAmv2om4v5SPU2VbnHt7wXTmWP87MqKjyXP2joyF5uEK8lw9f5GrzsBkL2X7SiiDU1kI5YYPmSGCj9raxCSJNbegIpvNjJZG2uiv5putf8oS2Y2VRFeng2WytK1uvl++OF9RwxRDdmyfni9sjf2IASGIGvDsoG/ExZwkMzUW4uIeT9AIoHA8sTZLTsRqwJElohXhLQKc24916RZKDCXZAhGZVgqn4L8FmnYXig04VHBh6Mq5ARM7wel5Io8m4C+7I4covGxF0cOJPhXVwTnZ6a8poE1Bj6N2PaIER/iVfDzD+7SXPq2mNFnm5LfwT1F2XejkhVM9S5Ty0qSk9dJSwoU1t25IdAh6xbl4Hx49FXyuRKkFtobkDOVtygac3vVQvHnFn3Bfi5JfL62rLwX+1JckxqZp0vRaC+5Dk4EJvd9Q/ZOgZTWptQpKokP8R9dZuDhyl6XUUZY8JfsPLnGrayVn8cxYa0zEtdlgzv+dsnxv9pXhgjjWTUk9Hrv9Jov0Y8/tTbuXUlFrtylNNvtNsIscrbUV6CiGJoxjItl/OeEwU3JngWsASsq/lmZRogfVw8/SuDvi8CfTb1/CFGcBib/IXjiVHtvZ7aLPFzFUQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7be162b-3351-4a8e-8910-08db77ced4e9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 11:57:22.3094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AyX2CsjxUmouqyJdXG9WX6FxmFUUchVcfTCoItZdFw+wymjaYt+jtVTJfu1qnUKpDn2HgBMOvwotjzBrwAPlAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_08,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280105
X-Proofpoint-ORIG-GUID: d1tA46Q10tHrjYoUuiojRyaPOi0cwIW2
X-Proofpoint-GUID: d1tA46Q10tHrjYoUuiojRyaPOi0cwIW2
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Update the Documentation/btrfs-check.rst to carry the new --device
option.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 Documentation/btrfs-check.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/btrfs-check.rst b/Documentation/btrfs-check.rst
index 6ade9d51b4d2..bfdd48bbcbb7 100644
--- a/Documentation/btrfs-check.rst
+++ b/Documentation/btrfs-check.rst
@@ -86,6 +86,8 @@ SAFE OR ADVISORY OPTIONS
 --clear-ino-cache
         remove leftover items pertaining to the deprecated inode map feature
 
+--device
+        List of block devices or regular files that are part of the filesystem.
 
 DANGEROUS OPTIONS
 -----------------
-- 
2.31.1

