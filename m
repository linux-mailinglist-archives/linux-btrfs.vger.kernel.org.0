Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED9E760F9B
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jul 2023 11:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjGYJoO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jul 2023 05:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjGYJoN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jul 2023 05:44:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C663110F
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 02:44:12 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P7oYkl025592
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 09:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=L9Ntjx5Uk+ha1ZwZamdKmuVP7quIeogd7yPAcwxoVak=;
 b=SCQffssOUGjfRnvRFYHVF6C73myqdNIaVF+O+N2eWkcbUMbwNsKFFub7EMJMOp24INyW
 2ZRt+BER3Yspdg8dAqxdl9lo5IvCZ93XDUspAxvqGXJgbpRqqc+Nz582V7ROzym/vjpn
 pXPeq3fJrbCysEIC7VQsJcc+TBdz38iotEstIOhBl4ABPQo4PHpz0UwNU3QFajqFx1qv
 ebDBsrfrY8qo+burWJUzlYkc2rwkm2gvTM1VzgouPNrdODf4qOCbgDG0gu4/1Gx0Egn4
 Tb7LEr1mIr8494CF1q+fmGktKqocLJpLb5g0cQLXC7X76Wek4+0b7tYDFomtx73Cdrx8 7Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s07nummwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 09:44:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36P8ROXV035460
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 09:44:11 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j4hef6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 09:44:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSHPZxSrKHKrFIDJNTLjaZKJoq3E0u6N7WDIq3fAD8ABPnQ/8PNadwjdXuzPR/iy1ELPQM1KVH8wFRCPNh3LLHdWom8rZKlN0VJwwKkRpYOyJ/pEBE6ZvLu5Le31ik0s0ssvmkKy+iQIMCd4WmotCsecjmLpVyIWDDsjxD8qitD1pFWj+inJXHxybM65XwOhxlUEAx7++Yli0/O2eSnk6SKH5xfIzAdiOAdL+zzVbw97sAuH3AzAzsn51LecwtbOJLSVXOsTQYuBKtVk5zGuO1CDfVXDdRyIbvGyo1V2lK+evbsJ8/puOp8otxaPoEAZVSekJjrvbCOVQraapenipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9Ntjx5Uk+ha1ZwZamdKmuVP7quIeogd7yPAcwxoVak=;
 b=JdvC1RPsw/OUxwIdnyNk+7uEVNCw9pM/uj7Yul9VZvLWJGnjNemZAjUyQ6Ovqk9aY1YqXd3LJtJ4DVcWlOASmcW9wStmNODOnJdjfXy4Ix/94XCZc/Qzn4oQRFh0omXZ+Y3ALAYg/NaXtBejfX2mAC1S84Jb+rM4jCzGGvGw5qdcK2j8rOTUMsfJ17K/4vpBbLFY2V7Kg/p8N/nxF5YcOwiPWuKezB0uK1tQv3wLQuHZ9Iu8skHZDFf6D8RTNq/MeTuxmszT+/0WyzV+aFhU4tJtmdg26rveZtycUNSNSUXJRCOPWPautAKmetD/M8nLdXpX+luinC3bKyvBXmAWJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9Ntjx5Uk+ha1ZwZamdKmuVP7quIeogd7yPAcwxoVak=;
 b=d8qQAVOHfHgeHAbY8Cyl/K7uEWoNE84H187AXeBkgYvDqwx9CcyvlBZOh0XWxvBPLV/45p31mPGCCoRlQbdUgdf8tq92Y16oCUHu3oonfahnvHAYT4L1uj4sPJjBdG2S76LvZCNkps4iCG0bdv6V7wdUvkK5DazwLFGXqq6bMj8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN0PR10MB4919.namprd10.prod.outlook.com (2603:10b6:408:129::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 09:44:10 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 09:44:09 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: tests: not_run for global_prereq fail
Date:   Tue, 25 Jul 2023 17:43:54 +0800
Message-Id: <149265ca8a94688008c1cda96c95cf83ac55950c.1690024017.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::18)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BN0PR10MB4919:EE_
X-MS-Office365-Filtering-Correlation-Id: c9e9d091-c5bf-48d2-beab-08db8cf3b230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jkAt5DPmYWS9NWpAsRedji8Su2gSgCIyanhtn4l2xFBANjrT10qCTxfJzAD+Y/fSlJXYII//zImVPzLYZYK7rMK0/7OZipLUCAnzNYcniE0RUdeQS+wlHapUtqR+X+dxLofXnLk2heMQkdneu0q3MEvBKE1POMU3HC0VdszCaCsSPa1LZX7pFJ7V/oW+cu52k9QQbRnP5trxO2AXEC3w79YqFsVQIAq9ITbPGVUeRn2xGMU29Bu5EM+irIeLsvsBcmyyU/S5p5sOLa33Jmbe+u3Yn7hbEUkJhbhIadlfMrpR4D8ymAK3uVEXi/JRpKaM6ZwYmZ7o+5j9X5e993WNGGUCCvxrnLGfUpqfahFX4IZEqtQXVcwvC3U5Z7LqzF2k1d59+v801jqZWfE040QlfzJ4UirtiUfaTbgvRAZLtSObkMyFXc2nqNnTZzC1JreKCQIBGu6eNyfzvozEP1f5QfKv9vG2Fdyywf6HTlDCOpJEKcTliAtoGproUO50UQmjmT8qXoef6xt//KVOoBvq5cupTs/zARrUBvbxXhVhaIPEnkGslxsPICEmiPxaWjBf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199021)(36756003)(86362001)(4744005)(2906002)(44832011)(83380400001)(186003)(26005)(6506007)(6486002)(6666004)(38100700002)(6512007)(478600001)(8676002)(66476007)(66556008)(66946007)(6916009)(8936002)(2616005)(316002)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KHFQ6d/Rer9FTHh9IRAgdR4xpHpnMDBwv7gWJUug0nUIAQ5CHqUmN3Ldd1xZ?=
 =?us-ascii?Q?fdaGICs9VefiaHnqPj5btvkBmVudnipy1d/xo1XnQ9DY5jW9jDXLOV9QUBYj?=
 =?us-ascii?Q?kIhmqL262cgAsr2lPnvLAJ6RfeGGG3FVH5tDDLOSZ3uNrfiRkvi6Yc4gubqa?=
 =?us-ascii?Q?vtVszZU1fgsD0UFqCoRYcKhm5OnEsNhXU3ITROsiPblv9M+tScJuenBZp/mD?=
 =?us-ascii?Q?XFgwcybt+CgP4Ym11Na8GZXC+t9k/H3scOf2Sdw6EGt0Kg/jJ1p0Ky77JoEN?=
 =?us-ascii?Q?105Ca6cQgrlMJqig87qBd2iMOw6CUgkebcATsOUw7vMv7yXGqYxhoCd8B9/W?=
 =?us-ascii?Q?kcPQCZKwd58dPhd6k1vOLCz/uPkiDukgsEEw5tAUuFGteceQ9UbmR0H597AI?=
 =?us-ascii?Q?afelNVk2amzzfwtSb+hEfaSY8+M1nXb6u/64UDs701U6tdy6i2Nyd3rJTOO+?=
 =?us-ascii?Q?kpTGtzo8F/U83ZIbXLpfUFFd02xRZLvwiCQtWDcyrgodxFYNWt9WnZZbR3PI?=
 =?us-ascii?Q?WpcyZILaaoaAZxwtm7KbO6U4dCie+/RHF3PGh1D1szodTC3RwY2XhJ5A1yNs?=
 =?us-ascii?Q?Se1In/5j1Vsn1USpAMSZQmvkrgHX2Zv2B/uHkNcXHsYlbLHPdvXUtRFJnyhM?=
 =?us-ascii?Q?uO996X4vHkHJFOEM+VLwNCSivQwCD8a3L4bgH0dSEAkVLGPlaJt6QGswoU0b?=
 =?us-ascii?Q?6AlqswPUN8BDj2+XZZH2CYK5ieDtVPvbpiOjmy48RSHlEz/DjmDv+8moToGa?=
 =?us-ascii?Q?Xz2DXLA2rw2SCWMQDF9D/9Z7kUr0VLLtYR7h7qfaorGkUfZ3FjkJOAI+hSk2?=
 =?us-ascii?Q?NcThxTdbQ6E0KsPSIr2Btj1Up8shVHasV4c9qL5eHOSK8fhsV4UveyYiXDBS?=
 =?us-ascii?Q?p19KIjN4PSbvQVvTdDvLticmAtsn+lGbHQ3XJa/BGEKsPKKvPHAbVlz5/DL5?=
 =?us-ascii?Q?pNvXLa7zqEwpNqLTang+lPFae9y4kreqbtQYiU5ISHkJjOFDtxzPbjVvmeQ5?=
 =?us-ascii?Q?luocp7TbjKy62IQ3Te1dy3Ub+L428MRf4MChGuhe+LHTm72BqBgNWmHagVq7?=
 =?us-ascii?Q?KpyEmM9k3KHmm1H6hIh5PT0UYQJd+GGwnBTmR/SoqM8FWQSVebiDIfBM25zZ?=
 =?us-ascii?Q?QyYjFOVAPsIKpGuFDavHsR0wz6nEWWbf9AYXSo3ONmSjGdxxAmFlVeXfmvV0?=
 =?us-ascii?Q?2a8ufGPSPTL2VzjrysDsP4KBcXP4gDn/6YkOKNdi92/nAWgj0Wlx2Zpozq9U?=
 =?us-ascii?Q?+flD0eM0ni/ewJ++d0NAwiZWY9J17Xe8uD4fTPmAErl9GyszIVzQyWrBaKQL?=
 =?us-ascii?Q?n6RC79Zapc80LAlLNbg9DP96HyBwZNXUpkhKD/x0JeqfAWkAbUoIbIEET6dw?=
 =?us-ascii?Q?nw/sC6uQPvmn7IlmiIh8yPt3XZ9UZQTzh6Ec7OO8jRAvx683a+yNJT8Z+Wcl?=
 =?us-ascii?Q?5QZOqP+n07sLj8tX8JIoH2CBurcdjj+yyrQE28bt1g9AO3IxLv5xw5zb//xz?=
 =?us-ascii?Q?/907kp827C0aWVYFEzL1qX9nfJ2X0OHtvjMmi3kr+XfbiUdC3Vc/hump/dq6?=
 =?us-ascii?Q?hM1lyArZc1sgd1Ol+V6qrY/TsNnaI2eCb/cIylh7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Pluuw00U1utI6qbSxyvXRDZ89S7a8hMJdJH2+Pf6rlbvp4QIricFxFsRDwszUCmHT8/ND6CHevaw3X7nxPhYRCzSoZ7F6K4oT8BED9X1gvyKiScRp5llB5I3Tw2q3zcwvTDK1KPKdSQSwsGJLHDRbddG0g8Pjr+4bCEplWvlkLajRDzjK64i9FglMGRYwYpNmZGL4snMHPHzAhUJLq9ZDtY7PBE8hcppNtKPgsHKCf7kBms0b4LtQ+wJMI1MwgHKlZImbftSt9BzozvKD77awj48/48GQnDCTaswQgGCBs/kz1rubA1kX1HJQF5yKc6xlepI51pZnQAXMjPJi+n6aX8jZahSd5ySQnP8iX9QLFJAtjYWM3jOuBBG+I1FhgF2RkJrZctcuzwpr/VrdJT9lBEHPDQX+SyYgAovOkmSPV3XJunDnGlBk853rPVVGJTOydXPJtO0eJkgSJCuaoqxOy60asgjylcBKDFE+N3ogDBzQgAFKLKkwRgi0rMkTYrJPOk8WwAdKPV0k5DDitKbKT0CyELkbA0DK0NUo9Z2r/yr6uPfom77X1PTD2+OVqQEwOBSE+mJWIEeMI7Jc+4NJErQvA81vQdV8jasfDgcNUspmhjCsJTj1m3VicAwMMR5TDBJdaTDqFDfY0NlEtmnlu/EN6lVh78erDIMMD/bsjziOmz+j69oH7l2a48TJmcOgcVQUgHO9TvlkN0wui4mCpRXZpj1eQ64W0yeX5P4OvcN0axSDGojY1d1GXRhMrXVP6vGG4riuDCD0JVoyJhMQw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e9d091-c5bf-48d2-beab-08db8cf3b230
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 09:44:09.8572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QC+QhG/gksiZ+KI5KRIP89tVWNE2oLdimz+Pg80xp0MkmTUdmYFBXmdJU1Htmguex/c4DnRkigpBAvRYmYlhPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4919
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_05,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxlogscore=994 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307250084
X-Proofpoint-ORIG-GUID: hhODElcxBMhGTgv04k5eP9HTV0Lv_oWB
X-Proofpoint-GUID: hhODElcxBMhGTgv04k5eP9HTV0Lv_oWB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Prerequisite checks using global_prereq() aren't global, so why
fail and stop further test cases? Instead, just don't run them.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/common | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/common b/tests/common
index 602a4122f8bd..4bde06ad9d1d 100644
--- a/tests/common
+++ b/tests/common
@@ -395,7 +395,7 @@ check_global_prereq()
 {
 	type -p "$1" &> /dev/null
 	if [ $? -ne 0 ]; then
-		_fail "Failed system wide prerequisities: $1";
+		_not_run "Failed system wide prerequisities: $1";
 	fi
 }
 
-- 
2.39.3

