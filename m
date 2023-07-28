Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132B3767051
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jul 2023 17:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbjG1PQo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jul 2023 11:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234744AbjG1PQn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jul 2023 11:16:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBD811D
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 08:16:42 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SF4N1E021101
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 15:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=OtvZDcfIa1Uv6mFYN2AMnxd4rGxJQQgBBNB42/5Nszk=;
 b=D6cNuYCP6Yv7qHChsXQy785ZznnlsXkskYvEA89fVtANli6NUY/jnn6TvXdhJ3LCkfA6
 SzRLzT5OfzjdgmPsX76FLxzVKrcLiXZc4irop/24GLjxaCqG/d9TW1dPa2o9dhf+2UOn
 DBz8ckSi9IuabILW7Ex5ZRxqG7hIgjjgOmb+L1+us773JHV9VerAdiWBAdqknlLEE18/
 5/HNeNyRycLDMMiwtTnVWhIuoVAx/zN8DTmqfMNk73M3bhiaAoe/a8zY5yMRnrfYMDtR
 ohypTD7bKk20s7hVShMbCS2JN7oHblOwDhv4BCEoEiOEj3QNkyFm2K7EAfMw7n5CRxnU sA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s06qu438g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 15:16:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36SE60Yi030496
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 15:16:40 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05jffy7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 15:16:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMb+1nwcTRCu4Y13jhQT8/JN6EagLRzmFOotnBChGbqK3HzjfANF7rg4AEZNF/satoPd8dKFU/HvMNlOvV+foj1a2UO1mU2eiGX5P8FeXvJdCHXwDF8wQQnh9CNdJxGLiD8LUTEkMTwIOsy2Fdct5mMEfYGLGyPRXj2QaGfHbk/dizQERWhzNl7f8FK8i78e0K0rxwj2LnZL8CNva2vCMvJNITFuEmrd1Tus6v4JUN9+Q1YHYPSwTgDKkqquML1/QW0FYq8PfQyM4qafJRVZ6wcA5joAFU53DJiv+0j0o6Qxl0KGNG4fSGRDH5KcHkZl5kRbiOwMkzrAzRH7OlWSRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtvZDcfIa1Uv6mFYN2AMnxd4rGxJQQgBBNB42/5Nszk=;
 b=d5fG294Wjj4lWaimpnwbGnazXdbyb4CpHu04oYtTv0Ex6ZRK9b85kVa18YWjbv4MEgPOF+Dfk1VQrkNpms9Wl7f4jBA5d9eE32Z/LeAOR2fXBdwH5FwjHGz/UXF0O5tivo1oj7qtTVQb6wW/ewWdPqexJAqlFOgXvc0zUXNjk9vBVjtlE9H3PfQTHOGuIy9dPSS3bPPvCuodibl+Fbibw/RiDHsOVeG3S54yj+gexzRbrqKppIaRtZRKBAIUC1NTrLLB9GBv/1HUV+JkTyeFVfSa3EDQNJdpcyYNbxwHXtWNW0VuAtK43apypo1GdYhdJigkPIbgua+v9KmMT7zwPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtvZDcfIa1Uv6mFYN2AMnxd4rGxJQQgBBNB42/5Nszk=;
 b=CtHDgMkecY9X05Blb7Y+fPGF886vw/+hnXdQjVDITPJgKuudYCNx4vRQz3XMVYy2fnV+39pbB7BENIdSbpT6I3dJ9keM3DF6c3OWMCy0VjikP5N2FJqv11hwZ3RmSlJgdaUj5HOqDKkAUA76vM1tsKKxqzg5fRvsPoaLg8bYKMg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ1PR10MB5930.namprd10.prod.outlook.com (2603:10b6:a03:48b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 15:16:35 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 15:16:35 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 1/4] btrfs: simplify memcpy for either metadata_uuid or fsid.
Date:   Fri, 28 Jul 2023 23:16:14 +0800
Message-Id: <ae10e7c26537465368445d379c660fc8be62ad8b.1690541079.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1690541079.git.anand.jain@oracle.com>
References: <cover.1690541079.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ1PR10MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd4980a-803b-4d82-619e-08db8f7da1b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9v8FMJgKAxFMm4SJO/e5EblnAZVhy42HxGqLm4KXYyNApjeCfws+6js0KUSUu2dXmkhO7S9Nhf3nsupGpiiWWcC3cSDgPnWWv4rkhh0jWWt8j6/RuRysioZgewM4OfzX2eoNRub6dTsr1uAgANta4baNHBs8BxQC5+i7GfwIzUZ/eMjENAW9r4hj/7XPtp1khfaRlJMxAb7yixXS0Y3dlLCsNktIdWoaZB/sBHPwti1vWjC/mY7IEpCjKHC69CNpPy3beX7RnruuLCr5x2YsBFEy0h7gJYgtalO/Txgq6YH7riwokjT/N4dH0a+U2uoklgoNPPtyNRrOdkpeQD3Ui/K9cCfaI8UIaZ9ELBWqtr/H+4cW/urBfWta0lZTVC0hBjuuhFnxHJzoVi45tVOXwbXJLxhEU8YJ+9n5t0yyzWSe+M6DacRuXjBXGA6AoIwf7mTI50gvOeJZ82bhh8IsgjM2NeXg5vTqRyhCiu22pIMgh9+dw9mP47TeeBVFG0F9seAiEeZghqq+pS3WOEr+poD1a5xq7Z2M1W8DxKXIRiY4DaDFWBiNcCu6lb001fIA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199021)(83380400001)(26005)(2616005)(8936002)(8676002)(186003)(5660300002)(86362001)(6506007)(107886003)(41300700001)(6512007)(6666004)(478600001)(2906002)(66946007)(6486002)(36756003)(38100700002)(4744005)(316002)(66556008)(6916009)(4326008)(66476007)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cS5DPy8h+QlSRDYOCX5ioFQAodWgnXhWf4ea3AYo6QK7cQfShstiKi/trWwc?=
 =?us-ascii?Q?YkUi4mOdtd4TIDsAqQ8OhiufEYzYeaejlNqlMPtlObXFk0dgAydG457OMtfL?=
 =?us-ascii?Q?cHhV/Z5GMgqUA9X81nd1TptNGMBkGPw1wwRzpwvCSvMU3yyVt/fYU7b9ZEtk?=
 =?us-ascii?Q?U7iXE/1di3z0cifqsf/uwDkuYsTEYaDGokjXnXuehU6t34IpGjmm/cWGkLp2?=
 =?us-ascii?Q?XbQ6v57V8Lsqnydy1SDTGaKgz6nehCiSC5zcaaGKwImGg7YUGNyMQSI9u68t?=
 =?us-ascii?Q?QxSjzylKLchW2b3j9wga+GnuTUrtDvBwkVNphy8mroYRregKYIisBXi3nXzW?=
 =?us-ascii?Q?APPE8UQrWrmaqz7vFsyTJnRPzoElmDyPtl6JPZciQ2NN6thSVsmMX/978ewU?=
 =?us-ascii?Q?vtDxAgJI8bzGsOYCRTfESOL6GN9UEfSCT0G2DfP15v1YRaQtpqeb0qbzbJ+c?=
 =?us-ascii?Q?diMOifElBNdPwfPJxMwYK673McRK+METRUhDWIx6uZhjW84peKxZJpOEZ+I9?=
 =?us-ascii?Q?yLFptOEC+NyXD6P1vgT79l6UnQRmBlPs/QatdxdQHtAtJjBaAsQwDO/pZRTc?=
 =?us-ascii?Q?pGwFda1hYDAKQBgrYNPv31RXyFudPU/U6+GiofSsiy2kPPfnvo7zIarpjZPJ?=
 =?us-ascii?Q?gLh7qQReUXJW45rEY5vURjB6inNB2ce04OiLjYQoYm5FAjuJMQV67y9/Zx3K?=
 =?us-ascii?Q?l4veFSdaz8AdesglU9GZqi/fhmDsUePVVt2U16cEfAJiTBX2QY028tBFIDrk?=
 =?us-ascii?Q?dTgQglA3i03grdSs1Y+bpnu+2DuaNcQroGoPsV0m4UHYYIwohFhG47ni89ze?=
 =?us-ascii?Q?pKS1Vk9xN4FiYyWZTNH614rID8shf3ztwolRHMPLsV0X193AHqPTTTxAqtlx?=
 =?us-ascii?Q?Jm0SrVU4sHCfu4FS/jZugps0lcfM0/wgPRhln/Jaj6EDf6/0/y54M6lOVowu?=
 =?us-ascii?Q?z74pJU6pm1IPZgNAuVX9UzQCTvfYSr+UojORJQmgysyl7oeGtBs64PeNhR2y?=
 =?us-ascii?Q?HSvIa6hZe9UU0CW+ITgUJga8iev9LjT9WAD93RU/5d0uKgVQq9xpof23ihex?=
 =?us-ascii?Q?L5i5I2FZS44kdAloKUOJfLzlT5MY5Z4Uje+1u1A7/5p6heaK1aPqeIzOpKL1?=
 =?us-ascii?Q?T7+TGGp5k4W4sHiTDkPO676LhYnfebSHeM6HbytN9XTkgx3i9cB7Lvq6uJdV?=
 =?us-ascii?Q?KxgDK6n8WZUx3XHlZe7UpxH2ab8VdkIdkSaRxPp5ia9/7dPoOklVy0piOvJX?=
 =?us-ascii?Q?Ym/f+ypJr9pmLPYTCctiDtHugLCeH9X/2FcT6VC7frhjN0HO3H+Goj0aMRIx?=
 =?us-ascii?Q?6wuFA395huWu3CzBanRX5QbFb4ma2qqRk2K2QPBFzHGOK58BM0NSAGDkFrcT?=
 =?us-ascii?Q?+zrtLtO6UCsc86n4ojVgnr62Haogn4GnmGXYAiXsE0qksKAluyzeX7eImMAp?=
 =?us-ascii?Q?KNJk5YsxBrGtOPxNX0VtHJLPbRfvQdsohzZhy90cUHde50Gm19UzxIHHGEdX?=
 =?us-ascii?Q?mq9miZc0tKTGwdcWNhBaoGE+xQx1KZDUfnN+X2LMrCcZUsoEomYnnvmUhED/?=
 =?us-ascii?Q?lgddnqXMkCDgkkSz/kuhx9mmUAMkbIo6I0WkYnQT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vpO+vbz+dLMpAQAooSJeX73rQ0n9SF6zyw3S8pPQ/PE+f1MGjAaC1dP5RmyYGxGT6yiU57r+7xdSko9wPRnpq52ph3jX64oox+xVgvDOQTdikTYKhkN/0cCyqQn5BmmjiHnK4astKu+Osm0r6lS2l3D6vV30wOzCU6QYtl1RQnI/omksezF0hX2ztrMm2Vesp2DZNI045mcoIFlWxiw2vMIJ64NIyrdoIQrfRTJJ/OzCLd670t6FcuZQq4/W3umktUvBwgezDaEsoB2u+McDmH9LO9nlvOzT8lHIKKGXvm+EYktDpotYzOs7x7h5MuIHJ3wSXi/p3VzgQII+hzjYCIBB98NI2SOXK3i0acFrjAMcJH/qOfobnIF/pslr02TfIxpTdCCdtLB00QPNrSOL0OSjJNtSc4Aj/No2AKiSM09JDInYi7c8TAfRPICLENAXO/51sSWG2e0wnKImPyBRt0Ofk0GC4B2TwSHeBOrzVljPgJi0gS27pWhj8ZaUQQ4rAjvYJvYhkcbjqfBa97HZu2xsLgmnUHlIJu1pXXI3NJsdr53lxQb9WkJ4LflhDfjNvJWBRGQ89BhW6gxP82CHSDnLzuXnbgUSOkCZHl/24jn9DtSdyv/SpMq1ZonBcXdX3R0UIGUZwIALUd9oNvTU6XMfv9XP8dQL06YxwAIw+EVpogJ7bjbv32JrbdZsb7Ppsneg55kYIDyoFBDcvgSmWGOaCwmmOGQ/o4clawGWnsPP6rOP8N+ir74C1uevgvMUCZzfz2XWoWXdNv08U0nY6g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd4980a-803b-4d82-619e-08db8f7da1b0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 15:16:35.0744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G5Cg/8xcGIWjdTfP8kOfg4ZJFctrPLeuNssbXzjG7GawiOeTBWNZRZ14uSjzZeH/DFXebLNDj7PRTp1Te4mfMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5930
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280140
X-Proofpoint-ORIG-GUID: hsN6L4o1gN97WHqq02zLCrdwVVlgA0LN
X-Proofpoint-GUID: hsN6L4o1gN97WHqq02zLCrdwVVlgA0LN
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This change makes the code more readable.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 5678ca9b6281..4ce6c63ab868 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -833,14 +833,10 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		    found_transid > fs_devices->latest_generation) {
 			memcpy(fs_devices->fsid, disk_super->fsid,
 					BTRFS_FSID_SIZE);
-
-			if (has_metadata_uuid)
-				memcpy(fs_devices->metadata_uuid,
-				       disk_super->metadata_uuid,
-				       BTRFS_FSID_SIZE);
-			else
-				memcpy(fs_devices->metadata_uuid,
-				       disk_super->fsid, BTRFS_FSID_SIZE);
+			memcpy(fs_devices->metadata_uuid,
+			       has_metadata_uuid ?
+				disk_super->metadata_uuid : disk_super->fsid,
+			       BTRFS_FSID_SIZE);
 
 			fs_devices->fsid_change = false;
 		}
-- 
2.38.1

