Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16607A8F81
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Sep 2023 00:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjITWfa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Sep 2023 18:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjITWf3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Sep 2023 18:35:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6777B4
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Sep 2023 15:35:22 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KKJ7oZ019103
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Sep 2023 22:35:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=bYBYZ2zF23By5Ok8h1dqY5MGS5F1hfAvrJ0RBedb8tI=;
 b=vY8p7N2t/YmCT7/sCpFzKxvK/mI4efFQ9emZcsRoDYdxCCOJkMowOo1YWz0h7/AZxhMz
 I5o7UPkvoQSLta8sK2xfMzz06c8npV65QPmPujHvDBAzZBo4I6J7KDYZQ9EXUFqm/tJE
 JLdbowKohreiT4wOYCq00RQmkdAY95qCUl1piu0hO2eDBpRGSE0hKufR6LUViqZM5aVN
 MrkXV4B9SfFxb9iRgxgKrl/UCLGlsU5H6uvs9IXHQbPJjNgHMKr5uMIoqtgKOBH2MOmV
 66QZVOVMJDgx+Z4bI4F0f2uDECYp7cuINnzxe9wNpyfywqYSlhNvWKiaqCZvVB+m4KXT ig== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t52se0f1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Sep 2023 22:35:22 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38KLHWbr027102
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Sep 2023 22:35:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t7yn6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Sep 2023 22:35:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oj8O9QE+jwDT+CpdKTZIyBWSh4CqOczxdtyUG6gpwePpZ0Cq8ljPwlCnWO/7UyVtj8Cnt5bjLj3Bd2kpL2jwBZCMcDZTWbkmWyvW4eNbTo1T91uHwfGvPQW0gl9tzRoGpAYgNZvAm5jjkXjiBq9oMYg/hs3arkTKvWov1hV5/TWDQ3SILeCdvvwzooyxsYlKSYY6/UYnQim/oyccY9zAFsIDJPnTni+TgPC8/ZC1zfTx3TR2PXjY7uNAgzYpS+1SmHqyVGMfAPN+ZRIpMfl+LJLUdS+SR1oAQz3OF/fFGq4XnSJbvfP83oSSsPgmfkzqDgjsE2+RdJ2jo9020AUuLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYBYZ2zF23By5Ok8h1dqY5MGS5F1hfAvrJ0RBedb8tI=;
 b=OxWQZ5p65CDXSq527hymhFVxUISrKq5WtU5I+xNI6xs+TB4LBrolywXOaog5rw0DjjZU5KEoTGy71DMAW9n3loll2EwJ/QcSWdRKIkv0q+CW7a+DzWkjLrMkcxWI6FSo7yK7qI7nQ4jPo4BIeSTd6weeUNqQYE76CwZkjCsmaKt47XCfyBdFhG2qQcppvxF4CttzVbB4GGfyHi6xQStutT8SWjHnDwkpAkyJC60ZYXbcKByK2XSbrD5xu8TAJU1yk2yjfIEUBaR1zppNPkpTXvlFs6dPruCY8zJM13OQDysICGrdb5JvUDTvXBGQ6+TDGYWqKNOG7436IrW/fT8IAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYBYZ2zF23By5Ok8h1dqY5MGS5F1hfAvrJ0RBedb8tI=;
 b=MTL18b9zRQuv62zvEadTrd5L9Bzi6zgwehxpLKqQ+UmhX14xEdsvHKCYTQw7qLmriZFW+RWxpHJpOze4i0vvMcLzTuHyAe9E8KXi4w7M3ckEunn3kPBYwNzbZ1B+ONfqdw6JV4dXcfEVfdwEor7vKfk0KQvw83wKrDWmd8dRh54=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5119.namprd10.prod.outlook.com (2603:10b6:5:297::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 20 Sep
 2023 22:35:18 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6792.024; Wed, 20 Sep 2023
 22:35:18 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: misc-tests/034-metadata-uuid remove kernel support
Date:   Thu, 21 Sep 2023 06:35:10 +0800
Message-Id: <c4d569b4e92cbc6ca2a7bd87e0bc0df1758bbba8.1694525360.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:194::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5119:EE_
X-MS-Office365-Filtering-Correlation-Id: ab1b5df7-17b1-44ba-e8d7-08dbba29dde6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3XSIX5tVWik2yyigow+t2L/8dAWKj063lFN5KNOzgpFmxXhNvmsF+qcyUsnE5cSybVVPxGhTkxkn8dUZJsovLO9aOILSxDKkZhgX3cElXH/jcrcRxlwMstZwrMVnr98wm9Tv2mJmlR4Z8i15N/x9LMKVCeoaIOThhj90Dc2xX8uhIN7Y8Q6fP/24zwV5e8olJdg1V0ecEcN/v2vSdDinAL8gFu5N40R2tcCKjzHRXLSAGTrNekiB7mtGxxArn1ZXUN5mWeJF8mMMtQm/krp9pbm+nwqElqPu5A9VHRleaFfumpjSK/jG3m0dF0mPlrhfL/HeetmNR8e9hvqomzyrLYSKl38UF6YRIRJYqRv7ZiTrNp5sFw5H+WjoVyaUGlc2UAUjtnrY0jbqpojRW9ZSXePf0+gAip8BAGaZ/kzvPXS82JAtF92Qg8qMAK4JMbjmw5HVmJanbVkTewcQs4SjlmXO5Ap2jOYpKdGxanalrdNlBMcQBkzxejMeUWkoG0PmW/1ZSc7UyMNrXOjKIeUq9O441TvH3dDUyO7y24VQlwiIEPR5qD/PzINE796WfxrI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(39860400002)(346002)(451199024)(1800799009)(186009)(2906002)(44832011)(5660300002)(26005)(316002)(66556008)(41300700001)(66476007)(6916009)(66946007)(478600001)(8936002)(8676002)(6666004)(6506007)(6486002)(6512007)(2616005)(36756003)(38100700002)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dts6WFeOjYSn4B+Z/8V0+KSJ+FfBYya1o8d2Fold/7BHk38n8/eK3QT0oc4+?=
 =?us-ascii?Q?7eJamhOGM7x+xn8U72VEPJUTICjBsDemn5D6l6/6Ia/Kq3k7PAXJ8h36dwDu?=
 =?us-ascii?Q?tZFkDjTrGwneMopudkqaLabfJmVgQ7Fin3pNbYI+0reOA4daY3P3jeuDjvpb?=
 =?us-ascii?Q?JpK/Zt+Vz8XmuoaozkuJzeWSJdCFGkkMCUQgilRCKCVdi1TrK08NCVYxqx2v?=
 =?us-ascii?Q?7q1RYLr6cUzjRK7ZRdejnbkmmrxpt4Ipw65XcGg+G2aqHX9HK90jzcuS1/hI?=
 =?us-ascii?Q?f4uaXus3Vxxj4qLz7C2sw6d+2aziTFt+tNVeE0HZhkoJGLFqnavPd9bbzYJ9?=
 =?us-ascii?Q?q60pxuTnc5oLty04HoSXxw99b9QBk5eq7mGY3W+FsbzBGOJ2c0r88ORJv0r+?=
 =?us-ascii?Q?nHN6ku6HRSM60opf9EGK4xDf1ZK2arHKxQ4BFXUv9ONFP5qL++5BuwQoE52w?=
 =?us-ascii?Q?3Cj6y14kR4iB7etIIC9136YD7/ix1CNN0BTMe/u9Dq/VvQ/Kysbo5KUBI2m5?=
 =?us-ascii?Q?g47Wm+OyPCM3Tmoee0IAenCWU90Gr/6QL0m8EKoVAScpJCsj5ob4Mhsr1A+0?=
 =?us-ascii?Q?QnvbpOFqrcsLk/4kmcwf5WqJxbo5Kra8HaH8w9VcGJSMPdWWI6hhG/IUvNVq?=
 =?us-ascii?Q?I59BOAiBIK6gyafK7MEe+ajuvCFe/I5Oj2KCkRcekhBtY7y6kSWPPF1uQzQR?=
 =?us-ascii?Q?dvGaVpxrDRoHbOaCGpuvP3H4JIJ9szfFErgA+puZI2djScfu+vqZ6OAXvvzq?=
 =?us-ascii?Q?yBZeSStB10nemhUR8cKkRe4uf+cDCUccP9/oSL6Hg8gZgIgp40vAARteFbca?=
 =?us-ascii?Q?/8k6rutrY5504rNRGPBxdEYPk5FFndHF3QS/xsd260VHcUW/5ngVNpR9250S?=
 =?us-ascii?Q?7I/zF/Yp/0XGfZj5CqKn8nLcUpg9zgiAg2fXefdA8sK/XtjVyyNVEASh1YxO?=
 =?us-ascii?Q?WGb1FIF7WtCZtNmpshwZyL9RzlFXOhZt6rxM23jgynFrCOGjgNH0VrMII515?=
 =?us-ascii?Q?GWQ88CLOQXZeyCP7rxQvmCrLTJbbFoJSVayup5up9PjcQTzF9coMae/zImPr?=
 =?us-ascii?Q?BdQFx+CAY4L5mwxj3ESceAZkxXUQKGfBWkrlYHzh+vKlgmTUY5hweqQk8sO5?=
 =?us-ascii?Q?yH4qJXcinF+fkewaBJRlrWG8XimYT4BaWL9kHZ8K65NSd3RTjzla70y8hHRD?=
 =?us-ascii?Q?uhjWavX1Drmgq4PvR0dP2+13ttUVaFF1Wh8hGJnEf/vVr+OUK5MEIjS8d49K?=
 =?us-ascii?Q?wRK9tbhKuZrqGfzS7fXg61u3CSQWnEDLiPb7u/zEvIjcTzYPWe3l8IIAB5wt?=
 =?us-ascii?Q?GuhaQWQgXqstsRjcB6H+KfhmvPQoQvCHA++LBhk9hNJ+k3Qxyc7GoZ+jed1y?=
 =?us-ascii?Q?ZPL4I3hUjnZHfK6bRksO8UV6gAm61rusPdbUyVqkuu4XZjJxwa6f7550xkVq?=
 =?us-ascii?Q?fG8j6r+E0P/krazkS54JHDMGgLmrSmAJw1gYNk80NvPrc+IBKadziM50DVVJ?=
 =?us-ascii?Q?PaN5LQDVvlCcGN1mQitlVEkNrJzsgwZKhUBGZRMQoy6JJAEBsxjf3xbvT1g1?=
 =?us-ascii?Q?Rugt/SXztm/AWfu4ONjvXYbl6VqLs1UOkF/97a0jv+aU5yD67ngBCy17zVRA?=
 =?us-ascii?Q?0g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /pRCLpQWfpOVgrVsbjopy6hZg0WjidYa4etTfoWYhvyN3ceCVy9en7kjT3EaBZD55fpuO8e+qeQy1Ivv6kgLvrKo5JUb2eMjqrof/xfvcs4xGRdh7SJaCsxxCXX30qnfc1YftjEAeNNoQ2NGU96DhTnYs5KuI59DdmnFWlgq9If+Znjgggj9FF61y5MrG89Cf9AXMIyub5jmFZpAWdST0F/wfvuROhcK1slzrZx2l91ifgdAnCZnE6HfvIPUgVf6sXcDhDpuh/s3N9KfrhgO/eW9JvBRBMcfr17WS+fZF5qRkyKD4v9qySFJXNGFcPDRgt40fPFDEMzD2BsZ3SrOBta/y7hiJo7z9nkdLV+3I0dXKDuqewepIRkwrcG07F9AfiHRSU8Eh1Vw6BkbmTg4dD8QsWTUP7GlMAl5PQhSWi6lkvL00OYiGpNpcxgInSA7CmjihUK6Y8UiQ4+bb/zKj2Pzw+/Xmhyz62fBQ4Lb0SJLKOVJex6nj1MwDLQfNRNGcfMPvy9JR8nRXLQPNHr3zMuhxfdQK7k2/f4am1YzPkG3JNsexehSNMCPRB73Be1i1ZEp3lgJ8+y4Y5IeINcveqt3gpWY59XLLtmw/zJPjo8dRkYbVH46/xnV0ArW/A7tgA01cZF1Z85cpfy7/K8s7PpIsRpSRF3cnwP+N8Iv+sTAhIMNCva6C1N15tlf+qTVb3pXA3hUEK8VKKiDMFAXTlkcMfA7eWCRInxAIkAgH1xlLS+DdlaBgMBjchU3S+ytt3pc7Pg2maFmOt9YMstVaA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1b5df7-17b1-44ba-e8d7-08dbba29dde6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 22:35:18.5396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKEnMVqg48Dr4wuqwAbCklICqq5/OzLyi8uGZxSr/PArEaKmMzdgcQOBKriLkw/r6BsLUTxOn52qIrDumnfJvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5119
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_11,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200189
X-Proofpoint-GUID: tvd1vtIj9zZDdmiqHal6tuynvdS5VDZR
X-Proofpoint-ORIG-GUID: tvd1vtIj9zZDdmiqHal6tuynvdS5VDZR
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The kernel patch, ("btrfs: reject device with CHANGING_FSID_V2 flag"),
removes kernel support for the CHANGING_FSID_V2 flag. So, drop its
related testcase.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
Apply this on top of

 [PATCH 0/4 v4] btrfs-progs: recover from failed metadata_uuid port kernel
    btrfs-progs: tune use the latest bdev in fs_devices for super_copy
    btrfs-progs: add support to fix superblock with CHANGING_FSID_V2 flag
    btrfs-progs: recover from the failed btrfstune -m|M
    btrfs-progs: test btrfstune -m|M ability to fix previous failures

 tests/misc-tests/034-metadata-uuid/test.sh | 34 ----------------------
 1 file changed, 34 deletions(-)

diff --git a/tests/misc-tests/034-metadata-uuid/test.sh b/tests/misc-tests/034-metadata-uuid/test.sh
index 0b06f1266f57..852770488051 100755
--- a/tests/misc-tests/034-metadata-uuid/test.sh
+++ b/tests/misc-tests/034-metadata-uuid/test.sh
@@ -222,42 +222,8 @@ failure_recovery_progs() {
 	rm -f -- "$image1" "$image2"
 }
 
-failure_recovery_kernel() {
-	local image1
-	local image2
-	local loop1
-	local loop2
-	local devcount
-
-	reload_btrfs
-
-	image1=$(extract_image "$1")
-	image2=$(extract_image "$2")
-	loop1=$(run_check_stdout $SUDO_HELPER losetup --find --show "$image1")
-	loop2=$(run_check_stdout $SUDO_HELPER losetup --find --show "$image2")
-
-	run_check $SUDO_HELPER udevadm settle
-
-	# Scan to make sure btrfs detects both devices before trying to mount
-	run_check $SUDO_HELPER "$TOP/btrfs" device scan "$loop1"
-	run_check $SUDO_HELPER "$TOP/btrfs" device scan "$loop2"
-
-	# Mount and unmount, on trans commit all disks should be consistent
-	run_check $SUDO_HELPER mount "$loop1" "$TEST_MNT"
-	run_check $SUDO_HELPER umount "$TEST_MNT"
-
-	# perform any specific check
-	"$3" "$loop1" "$loop2"
-
-	# cleanup
-	run_check $SUDO_HELPER losetup -d "$loop1"
-	run_check $SUDO_HELPER losetup -d "$loop2"
-	rm -f -- "$image1" "$image2"
-}
-
 failure_recovery() {
 	failure_recovery_progs $@
-	failure_recovery_kernel $@
 }
 
 reload_btrfs() {
-- 
2.39.3

