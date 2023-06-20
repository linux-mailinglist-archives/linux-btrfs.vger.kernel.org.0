Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FEC7366B7
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jun 2023 10:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjFTIz2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jun 2023 04:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjFTIz0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jun 2023 04:55:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFC710F2
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 01:55:23 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35JMbErU004079
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 08:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=Pc7jUrlTunV64lSlEiSSNMpAtGdzQdXIkDKNd2Nc8Nk=;
 b=rgL9/EwyCym/1jzmUhlPkrIodb+cbdTORfXXgsjKP/Dnc5hYQ1xf2agcPIbPiJ82zaUl
 qDNSG2VwKkww6MvfkIFaoH/S3RDIR/oWE8tSzCRT0FeVc3yjCblM0zeZI3xn0L/TIx0H
 u49W2WYodUN9enft36Ysyorqv1+siGGJKcG8T6ZinpJWU2tmiMRv71gdmYUQcaChsRDb
 kvX2qSV6lxKPbhw197YPus+N1ZQLiBE5aOrtdbj1FyJ1QxIm4S0aHo9Prjxgpaf4gS84
 pNamgWIHTf5oTOLBHwr2yMGTzLEPNS6EcmiWK+7m/jszAQksgVpnoT28nFNeNFF1yUsN ZQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94vcm77a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 08:55:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35K8aPqk008308
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 08:55:22 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9394jxuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 08:55:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAQJS4Jad7ZzLHFyBlWdcY386MAyvE3UYEiMS3MWXyOhLA5RonFCaY+SqvRIHWQM4k3rB5VZCpfxzOGdRPH3/YM+iYV7uwmXzNPMfayD09nL/9PDnBQ08/pWIpoRHaK7yWSQQfVB9baZRZKyhNA6Q6C4Ab3oVBSEnArPIcUsNEr2vzZz52PBLxNeDMJ+w7NuH0YmiC0mPYhJZLh9Cb813XDxjmvLW/MhhsrqeqoAwI3MaGnOEaw3MvL7ViSfOCTPqXO4UHf/el7J4SlSdB7xqrWDgqB2YXzke+EwHlzexwzzSw3OIAhDpsqkTkIQHB12XOZLMbkS80cjguO14lktEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pc7jUrlTunV64lSlEiSSNMpAtGdzQdXIkDKNd2Nc8Nk=;
 b=JFygI9GajqbnlWHwqdP2p/bXEhBMLIKPAaUcangMx2N0TMAk9FxCxJNTNjhBJ50fP6vrnMVrhlnWBwFa/VJ2LIi3Mr3YDIYWTbEbwXGf6evxbqpJmdYjLOk10R1Gs0YuO4DCaRe1i4LKV5YhiJevrJKSsDd+2wRAZ0Gv9ipMl3Qa1RdiQ56+btL3xbFSrZqcG5mXnmUTxHfEAm03W/ilA45chDOlKzUsR24rFvilYT0/cr2S3O3x6QJ391x89Ew5T8FqfUiIe4mEAT98ddTL5GIO1KEllAyai9jcQkRX973PQALEO5pQ7xdZERjjCunnYhvLAg9BYwghgEPGi+9Qwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pc7jUrlTunV64lSlEiSSNMpAtGdzQdXIkDKNd2Nc8Nk=;
 b=d0/GXDoJmCDa4rP+GyCbszqCcNippMOvuCk4KNRJ365NxSGwKxt3I83nBCqTBgFJJmyg+98rovrchgZGfXeAM7S0hOeyG67URJ8+SgK+jKdbh907QkSE+G0XKPhyOwFZe0Ji1uYgiJMT21BvBqeTj2Bhg3nI8IfjED5Xkw/DQ1g=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB6876.namprd10.prod.outlook.com (2603:10b6:930:87::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Tue, 20 Jun
 2023 08:55:19 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 08:55:19 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH] btrfs-progs: tests/common: simplify check_prereq_btrfsacl
Date:   Tue, 20 Jun 2023 16:55:08 +0800
Message-Id: <df5dfa3a329e7418519a5881311d776a50a118a2.1687250430.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: 37f2e8ec-0da0-49d4-127c-08db716c12fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /cF1HEcDYtMiaqo0lyu7E02VNl/XTgc+Insm3/HkAnd99t5YRsa/Szj1wCKNUWV7HmJfvHMhivjnMxU0bDq/g8BMY/xz8BBkg3FQiN5eJRjP5jJYEKBazKSuhEE1iAkCHl1QbxYlR87KkyV5pqu/BxuXtGVs7QtM3zBq9f00xzQuMkqLRrp9R7puC9216mIcIQC8aWY5EHVH3rK2q2oQZ76nG38IaZyJPf8PB7mEwFEwbJA4+qnn+n7sELoaDSlu6y8tj1ojAOod+NiTsuE3HsZiet1a9DsukrBdAqwQ2L1kFCe+iaC3URgrVemxXy8JEQ51e0njHImWMATKtpi49zH4PgK3BWXMwYfO7JfYODYSF8PR2vbTLPkMloLBFPsLlaMHW+czIJkBLkz9BJCmGo4pDfWRuHwpiFHM1PpjsmY/qxWlUFRhmdTnjGixydc8OHzLWh9x+5F7bs8q4jAufK5jL4EdkNSAeKlgytMq2zAkWVXpJZXHJ1r2wnUMCzQYm+BTVBgb+Z6mtX/qciA7Myr7CUvdycuvzTpdDvNP8jFf4xCqzDfQLi37OLrGprut
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(136003)(366004)(376002)(451199021)(4744005)(5660300002)(478600001)(44832011)(26005)(6916009)(66946007)(66556008)(66476007)(316002)(4326008)(41300700001)(2906002)(6666004)(6486002)(8676002)(8936002)(107886003)(186003)(6512007)(6506007)(2616005)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ua0VuXRqp5jJzu36Jcjc4YrC+3dSLSOXI24LjkNlaH7QZEKAHpL77gXVXttx?=
 =?us-ascii?Q?yxa1CZ5PBAp9ei/Ep0boxQKSYMC6T0aucn7IvlqThZ+hqEPaosIQW33n7s/C?=
 =?us-ascii?Q?lf88vH24OI8R+BRtBSko9j3XFftjEKLpPAJSPlJu4wpA601TXYMtBqdqr8un?=
 =?us-ascii?Q?CsVh902spTrPAPgFH1lc+6J2hhUKX66segB65Q0nVU3X8rSvLtzT4aWQDJXq?=
 =?us-ascii?Q?7FdZHbxJX5AuCVbonvp4uFVmDW+0ugzJqBRaUUrNnyOdsFJpKNRa27boM+sB?=
 =?us-ascii?Q?i6d6V7zL6ZRMDAHhZyIiwYVGGHit9lCi/vP447Fewa5cgw/Aey3GWgCiOSSR?=
 =?us-ascii?Q?3FCisYECBPLTfIiwKlsvoXOGP3dZHI+34r2h8+UZLqKjmZ5Lb3fQfmd3JmB7?=
 =?us-ascii?Q?hwisJBANniZY/gvfSDcIG1QLDT7V6sarCMoXil3ZbyLHNm954G+FBxEqiQ8T?=
 =?us-ascii?Q?J2nvaGRvg5d7jVhINGX2V3ByeAWySY71cce5oacL+ZkkpoDLvppxr+YEGi6c?=
 =?us-ascii?Q?o0nCez04g57qaw6cd9e0pHoXQWAnnMK6r32j7HCGReKha8GKppS2S4r2zXt8?=
 =?us-ascii?Q?aIW3xcLfzKAag6JxCMlvHhm8BFcgfHmlyU4QTY+IweWmmYlwtE9aOV3f6V9h?=
 =?us-ascii?Q?Y4eZeVgoT3FdpumKhjgZoZPh+ezOoeoSb1HxkoPAO69zZTXSteEyzXg0SHf7?=
 =?us-ascii?Q?tk0fVIvjbYmWxp90C92f8Ud6izt7NgBO4hT4w53H2AltZ9/JbstDKhioad/l?=
 =?us-ascii?Q?2YLY64n0x61whWHMx6L+PaKKg9ewRVS/vSuRH0ry1fXufoZ7WUqT3pFsYfNE?=
 =?us-ascii?Q?wTejAYvpdV1y9yDWg12dPRg6woUwEeJmCFjV6+P1loRiX+J4sdKcKdo3jBFl?=
 =?us-ascii?Q?31xcJ69vVUeaSE+w92kkMSmR5cg83s84S+eQL1uE2Wb9LM3KOC1Kj1E/xW8O?=
 =?us-ascii?Q?IjeUpwsVdswXqyLZceWqnL5Z40M0tkhnsSBTw7aGNFxOUO3v9So53Mj++zlD?=
 =?us-ascii?Q?8n073+ZfCjuux2ADHvlSdRpliZ72SBlEYWR0a2RRHhTNqlIezYVh9eIMlFgf?=
 =?us-ascii?Q?KnrLGZeipt6MU1y6RRfe0x3kJ44sU3sOpnNC9sR/7PS5d4cRD/u2VhhG6h+s?=
 =?us-ascii?Q?xb4Sm8jXPBQcxY2fXYaGVFHF6LLScnbJGt0wgoHsFNEW/sS8sNO3t/T4jmHy?=
 =?us-ascii?Q?6tM9n0ncOkvQW7zJuJ2J2+tr8lFVjP+rJclusWCEYZ7pNHYkpgTEj6Co8YzK?=
 =?us-ascii?Q?Mc1SJC/ViEROKTFatKcIRCOMp8qOJ9xQBsRxUmdS8tXT6u3knRAHNNysyS3a?=
 =?us-ascii?Q?TD/ZuWi5o39I2AcbJbkJWuRrADSxRYhkVI3qt5sT3yrTfvHV8KAdNMDMN2DE?=
 =?us-ascii?Q?zCnkT8DraFrb7JJk9V8j3pfkLY7152yWCNQ/vZ+CnHvbJBbUppprBYaB0d6z?=
 =?us-ascii?Q?KKbt4PRaaqA3kQhEBVYkBUPyJRT2dST3Tkq+P+EHLMKcArDLt38ONqJRnKjW?=
 =?us-ascii?Q?MUa0oOkzGAR8Ea76Ej10cHAAHU1P/0vyPXNJ9ONjP5R1RGCMDoEKldDbZyN1?=
 =?us-ascii?Q?swDSlzcfI5LniiX5O+lpo4RMBArZKHPdq7wwevc1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: T1eCN23CMH/+IJsosYmT7DsVAN+aVSTWUIjUrCcS5TWsN1oxCMMl1ci8IPcWw2JBF0k/UNzxZTcik+nI2SUNI8srZaAy9+FiQDnJ4By3ynWzzwDwLeOzh0f/NB+n9+sI2jCSEWHCSsJRyYq3g0z6n+ZBHUUdDeIz6gdBtfxcYGpZSZLsUVs/FziPA+WramlvJOslN1NNglfss7jY52qHk6lX2PpyePs5a0IHYQg5wW5o+trqOVoo3fx1kt3fT9KGzOl56bhTkYAT4fHi6Ff92CoeuULNAEWrAqEtcDlnBc3fyfl/fG8TtRbFu6m8LvnYbltCNWGeqdNgTuoem7N5J/lzpl7Tcgd7e3ULifPIj/IK3wVNbjbC9A00kQYu/3jU+UEd6sOcPoR0PAF6pg0Kp4WXcDOb4W/XaUO98YkUtVYfEa2KeJaZv7oSy41oM88wmQ53aqPKhtawxGLpduycOpKCG6JvPOxJOlZ9heDYL9kXWjDLOE/bQzVHT4KFsg2rnK+8ysr7eInv3vlxtPINK98D0UOwuT3IGxvtT/fSE0jQNVbCxJInsJ/RS6ihix3qDOSMkHbARqeszewYw6RlBqN5k2KqCnsdahQQoPlw5tPsHPtO6S9MVx52kjr1fob599hxHzgk6Ceu531QRRcXPGxvMj4S4aNR/DW20JKKp/LJLP29XYE/ADKhb0SVp14uctypvxWLc0sjAQq6lfE81W3eyOrOENLxl5gTo+U7XprF82O+X0x70yDDhvsfd+mcH61RloLeFpTrawI/00NaZQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f2e8ec-0da0-49d4-127c-08db716c12fb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 08:55:19.2882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r1etP7+CPvLPyqIG15Y8gno7eY5iUlEyJetAY7li/khozeQeWzROa0QrVI6bxRnhr+wP5EYvboIyJKGZpXRcFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_05,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=995 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200079
X-Proofpoint-GUID: DVFXM7gPO01V_Mvy46TT3Dz4WmZxOzCs
X-Proofpoint-ORIG-GUID: DVFXM7gPO01V_Mvy46TT3Dz4WmZxOzCs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With the kernel patch
   [PATCH] btrfs: sysfs: display ACL support

We can now check if ACL is compiled without requiring a btrfs device.
However, to ensure backward compatibility, the old code remains in place.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
Depends on the patch-set:
   [PATCH 0/6] btrfs-progs: tests: fix no acl support

 tests/common | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/common b/tests/common
index afcbfc8f09ea..303282c3ecf8 100644
--- a/tests/common
+++ b/tests/common
@@ -578,6 +578,14 @@ setup_root_helper()
 # Check if btrfs is compiled with CONFIG_BTRFS_FS_POSIX_ACL, requires TEST_DEV.
 check_prereq_btrfsacl()
 {
+	if [ -f /sys/fs/btrfs/features/acl ]; then
+		if grep -q 0 /sys/fs/btrfs/features/acl; then
+			_not_run "acl is not compiled"
+		fi
+		return
+	fi
+
+	# It is an older kernel without acl sysfs interface.
 	run_check_mkfs_test_dev
 	run_check_mount_test_dev
 
-- 
2.31.1

