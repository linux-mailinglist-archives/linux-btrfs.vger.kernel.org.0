Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C6D73993B
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jun 2023 10:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjFVITR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jun 2023 04:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjFVITN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jun 2023 04:19:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CDF1BEA
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 01:19:12 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35M7pkkp015212
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 08:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=UrW6AznctKDU7dzwOVFXnUUfwFtS5laqLNZtttQsbCE=;
 b=UXTpQUad7j2mj5H3hnB+hRSjwvBfVTL65jTVHUNnovSeKdoCIHyCnrVzFOsRh1OMq1L4
 SB9dN18Rj1V4wVvrwL6AcqCgRaiP1eAb7MO0wDoQDsU/CyYsWxZOZ2qC9cvkLmEJePw3
 TmXUkCFVb26ojLTL0MXcDxpcKMmdLR4mAhUWN3SrsONe/BkSoBywsfWGvvj+f6C2Q6hd
 PqCP0P7uVl1qLFHF0jud6R8gOJxP4Y7ng/IKwYw1OpdVXjQ04ijO9qwAjlrT9so18qMT
 REs475tpRN+82gCCY4/z4bfzfD5tBv4Vkg8Z8ZDLFY8bDnpXiEAtvKFVQriVbwNgmEp8 xw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93rbsabd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 08:19:11 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35M7FcFh028877
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 08:19:10 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r939d724x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 08:19:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/gxTJfdW6OnzRxLy45HQLhmDCy6eRiLVw4KNhAZMYhPPGImKvGtYL45zGT2FrINziB1PqheD7DaAMj5gZgCPBhsx2T95WJWR2FIW9uAX4nRux8uudMV2qow+9lde0Ecz7Bi85XDR9Srm2oxL1dEn99RqMg2/ZQrY5NN2v/8D6CcJaezFRkj8rnNMScOHLQUXbrocQPVTSIOGAjm0mvstpTGfenOG4exBM3Rda/n+WWDJcXHCN8Xrp+zmk6LxVNo4Mdy9X4e7WkvJOwKRzjmiQWgUnVrqOa3y3DIlU79sfYHrnskcihMiFWe7Gm1X7wbdVZdjiXNXW86Hgr5X5Qsfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrW6AznctKDU7dzwOVFXnUUfwFtS5laqLNZtttQsbCE=;
 b=SZDYcSohOPAnC/PV3U9UaBdfCfUTnmQiJYGcpLBdAXfjOOxlqsocHvqxQBgnlRFVDDqtwbBV1EDoos1jdaziJjXYqNV0vdJwHcAMPXlvlDCp8ZfhyMWGmcuzSljWySqBROgMOLTTA8F+3xI45YL681U7Gx8NPrkfRz7wkfRbCy91SdEkfq/ny22c1lew259J3NJeUDCdz+wRTGSGF3QNCpiziiyjP3nAUzShdzCoqorcOoU7pa54HGX8HFJTUIJIqPzbK9BBMZIwdB+Z1+uFDNkRhQDfe3+bkjSHgIshIvpZ4DV8lvKAketsKmL6htVt4Ws0FXoQjswvMl2SN8T6ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrW6AznctKDU7dzwOVFXnUUfwFtS5laqLNZtttQsbCE=;
 b=trohC6w3wRU3cJO7tvEDSYL3iKcHcmjNU8cmChNP+6rdgl7WiUupjTU71a1jWSpv2RTNNG/bmJmLiyzk1m2L/f/4tPGMdyNmv3SiJucvKmtnwbkp8kojpzE9ayTwamga1PChRDQaDW0RkG1+Tv4LQsxUDODb48jwMRUSaZPoVEk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CYYPR10MB7652.namprd10.prod.outlook.com (2603:10b6:930:bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 08:18:35 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6500.036; Thu, 22 Jun 2023
 08:18:35 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2 v2] btrfs-progs: tests: add helper check_kernel_support_acl
Date:   Thu, 22 Jun 2023 16:18:11 +0800
Message-Id: <1a79c0a998966f42f6fd561d38801a6c4d309dcc.1687419918.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1687419918.git.anand.jain@oracle.com>
References: <cover.1687419918.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:3:17::29) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CYYPR10MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: 19cd06fd-ef70-4a12-2355-08db72f945fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aIJ+LfXWhJnYAiGFBkAwvlQwpH8K/Xvxvg64ptFR2PiguBQ24PFnJCp50Wysc3YsOSsdctB2UA6s3OUfiPnMS0fNP7LNuAlXQY+em5rsWlgCtPHb0tN6+gFitPneV1I/KeBAI6LKLvPARXiJbU/pVTHPclwdxluX2SqYy8GtXU+1rS5OPJ8JFG1ZBYIwUYpdktCKP2p0e+dXEMZBYF47dbYaBJHLVZstINBC0puG5mh8zcjqbvq5rLtSC5z5fkz77M7Z7C410UmO6QsBnMAazqvo0IkFSEJMhKUDYa5U88k+FSA5GnPp3/BgdADClYwCJB21MqH07153oXP8skoPSRzeWorWzlMUhp5gWTH+koX22zBY70+k8hq5Zxv/86V4/T/u0KOnYgU/URLSALayQP+H9ZcXJCxxC76/sQqjQKyJtuZ28gNcH0cIYo6d2EyChmszz7ibd7WdltKekAC+G+ipOoqsvKxOHLVts8+pTR4FSGAlgnKvW9yNFPNoZFZjALnKglKaOeLMv5m0Hfz0ejBQUt7BCzItq954Bk1AMkvu4I/jLYao2LgQBpvyHsMb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(376002)(346002)(396003)(451199021)(36756003)(86362001)(38100700002)(2616005)(83380400001)(6506007)(186003)(26005)(6512007)(8676002)(478600001)(44832011)(6666004)(6486002)(316002)(66476007)(6916009)(66946007)(66556008)(5660300002)(41300700001)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cfTguEz3Skzhk9Mp5Uq6LKYQQeXQY8NR36lpWDnkwY2I5MDvRTH33LuMAqS0?=
 =?us-ascii?Q?/mNOrxyz+SurvrsTkuX1ZbfTpY6gh+nvmNaoWG9hOpDOrmlDDmbnK3MlrFyx?=
 =?us-ascii?Q?I+iHiAGAW2OlIQuursUtYNyoOA3PsqAsj/WTrOXzjxRVlMVuEJPgVSxHF8/N?=
 =?us-ascii?Q?nJHxl+JzD1KbA3GU8UmW+/U/yq55KB3bCJsGEKf+tbkBgHxyoTQW3E2EDtjJ?=
 =?us-ascii?Q?N1RB4h+4Z7xm/VRsiyyvVkoayml+i2orLR+o0LINKOn3VMjhIqUPrR1clcav?=
 =?us-ascii?Q?m+KV/E/chdpDWVyF1gC/odSYHwSmi3L7pNIhpXEVpRN9N6Ktjw5I0Yt2HoGB?=
 =?us-ascii?Q?VR6UqpUZaM5Je5pJ7XLeBcsqy3te62wCLflVZazHag04/2hoi+qRwXsIHB1q?=
 =?us-ascii?Q?Ho88Ny+gCxCbamoks1/2+vVb4Mku80YmG7p1lA7okp3PD7tluuWKJEJ3qysh?=
 =?us-ascii?Q?FPAOXT+0QxENHHJJN6elbyZQnQIeCbCeujcaUMGlW4UjqvS3FiXd0X4gNJJG?=
 =?us-ascii?Q?QV6RebPBZlSbd6ZNooB4d1SwBcA64xRmijh19f85/v2bdifnzpNlflDUIs8k?=
 =?us-ascii?Q?WlItm3PQm0a6W9I/qNt92EcfvvMmFH9RCZoiMEjjB4W4dqDBFdqp4VyL+7La?=
 =?us-ascii?Q?AFTpjMdoBlwAAXZpM9QWFqVbOg6X+mdoNDQnUk+5tYExtqkFA2sNDvulWu2R?=
 =?us-ascii?Q?whAnCoqYiMl89tLiU9HufOpT8WHUeyd817K4xScutqnNaSzgRGqgISYpFs3P?=
 =?us-ascii?Q?huDzmVEqGyw8yppw171E00n9mM/b1uuimtOedr3Od6zNMZIVtfCW3FIXrPZO?=
 =?us-ascii?Q?mbEnHZi0qby3mBh+CU9TFo+7kj4yeI8NWdQqDFidhUyUzbf599pFJYDBGJOL?=
 =?us-ascii?Q?+ONjgcq02H/RxZwNSOLD6Al6h+J1wYvwyw64BEKkc0N/LAkAM/7qMK7TvDv4?=
 =?us-ascii?Q?KRLNnRnx9PzC3HmrEVAFY3/3TTg8JumELIwOx7nBpRnmhD3l1jftQ+47l71/?=
 =?us-ascii?Q?GJhQpRuNLUk9mr5p4gdIDGCuC1Gik7eoKGWdGdI6d1BfL+EHKfa1zvz6S6/T?=
 =?us-ascii?Q?rAy5eBZnqNjrlJQ/PsvDYgUnn0hR6Lq2pjTDUNB0coXWhMFGdJBaSu65iujv?=
 =?us-ascii?Q?wVgRF2R8f7iGM2kZSRLjThZSyPUAP9A77tqisR29S+Zc2KN+2FPv9jDuKRai?=
 =?us-ascii?Q?9lIvSFkKvjKa+EieJvO2cCPGqk/7lJoKD+JtIl2vz03Ppsklo7PrqJtayKSl?=
 =?us-ascii?Q?j3FmTeDqHxW6+vBH9QhOOigiT95o0IIZBAOk9lI00TBrbq6cLSltocvDa/MZ?=
 =?us-ascii?Q?Rrah+2Mli7ey5JdruK1CmgYYzXwGwByEVmPl6xk5JdcXqZ/H8GJRHNXkzgbF?=
 =?us-ascii?Q?f2nXN6bSErKwsxMdl9EO+i+Qn75yOgORJ7ymtW1pk1e4NEUDe+Ptrk+/9oN7?=
 =?us-ascii?Q?e2NNtuxrvOaG8jjJxtnVCrGg0/f6XyWgLa/58uftKqdx+1LNWG9u5Rph2S2a?=
 =?us-ascii?Q?iFduij9Y43Bs4eqsCDOqZz847o99IOjaMGm95KlcOv+tVHyTKEwHJFVvs4Yf?=
 =?us-ascii?Q?L4bvY2754Ie8sYKW2rBfPAyVI1ZIl7Mk1jtjEwKP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: r/7r/9RUnycpdjE/4C2LkPMCL9P/fXNm4BBTr6I4hrZ3p1lpgCQg0Lxc7JZ4bnowBd6fD0ieeBNYCBY+TGydv7AsTuMTDrSpvHFvsA7nCy6N2Kchdzn9tx3LZK6/4tF2UJFeZUpXZPWy9SsuknewCoHQOyTLrAvfAr3itgDqc0c69CwInxzGWN6MJ6PGHat5uT88aeYqQ+OqMGvQ65QdX1k+6BHvA2kTfDtGcayQXGH6UyuiK5IJRb2GgB0yrDaJ47Z7R1Xt4HgNr9HOxOVH1C4bonOg5rM4utDmNxUTkaocv4Vv26DLmgilvZ5Jmtu+xcH5gpRA3Ao2MTkQVmKvfc1LGmRYWFWxKbppQCqLSAuDvNDybF81clA4UKg+94T2B50Qq8D8SaAk9xFgKyw55ldUFGR5UZ0MIuFJ+DTfXqw/9zsqHTPxrJ/Ejxnv8lg4JFIgvDdpjplNYL9VYgR3zu+e27YIe39nS+IeMI9z0F03iJ/nsTofsc9E0mDi8P1FUfw2GdPTdIVZQbCuadfrt2LAttOV51FpBFp1YyDJw5N79HPtGX9yAMGl1wAiwmgLr5O/JVMiumNxOaOD4b/xz9fKrprWTZ2hMMwIbflp9x0PXxAGlZfx+t7IZBhj2mE75whDFK6imMXleyZa5vaF3SItp06s0adS/6PlNQmB0bJuWLWTu8KusYLIVVJ/fFspVgJtIwihgafR8dEe6p67OO4U/iDV6v/wQJTn9I5C1HM3WqUizNH2b0zo0jd6ghQ/eLjdGzOvVyNyg/W0tRcYWw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19cd06fd-ef70-4a12-2355-08db72f945fc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 08:18:35.0565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JeDKBjcHud+6K9ZuNyXMKcdsEkuEPd+rsAC0xya2z9EODsozf+eD6oEFH/Njg0rxPu7lVmDOgSWuvQs+zbO14w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7652
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_05,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220068
X-Proofpoint-ORIG-GUID: t5jYRBAKX_qXyJ1duiZ1Eg5Gt0jBRblb
X-Proofpoint-GUID: t5jYRBAKX_qXyJ1duiZ1Eg5Gt0jBRblb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Some test cases are failing because ACL is not compiled on the system.
Instead, they should be marked as 'not_run'.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2:
 Work on David's comments regarding function names.
 Also use /proc/config.gz to verify ACL support.

 tests/common | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tests/common b/tests/common
index d985ef72a4f1..37473bc8080e 100644
--- a/tests/common
+++ b/tests/common
@@ -575,6 +575,24 @@ setup_root_helper()
 	SUDO_HELPER=root_helper
 }
 
+# Check if btrfs is compiled with CONFIG_BTRFS_FS_POSIX_ACL, may need TEST_DEV.
+check_kernel_support_acl()
+{
+	if [ -f /proc/config.gz ] && \
+	   ! zgrep -q "^CONFIG_BTRFS_FS_POSIX_ACL=y" /proc/config.gz; then
+		_not_run "ACL is not compiled"
+	fi
+
+	run_check_mkfs_test_dev
+	run_check_mount_test_dev
+
+	if grep "$TEST_MNT" /proc/self/mounts | grep -q noacl; then
+		run_check_umount_test_dev
+		_not_run "ACL is not compiled"
+	fi
+	run_check_umount_test_dev
+}
+
 prepare_test_dev()
 {
 	# num[K/M/G/T...]
-- 
2.39.3

