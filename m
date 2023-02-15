Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75956977A0
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 08:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbjBOHyX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 02:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjBOHyW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 02:54:22 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E3F29E25;
        Tue, 14 Feb 2023 23:54:21 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EL47RE027245;
        Wed, 15 Feb 2023 07:54:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=UeNg4j41lH8QuT2Zcii3RWdQni5vx3l/KoMeY4YMJXM=;
 b=i/OEIm4LRtuC3C06Ig7nMl6+OKuw+MR7xEmnX8lmHba0ywr5iE4RgdcmoDHGFvTfgGk/
 iI2B7tjMIcjQF7/+lhZbdo02e5P0YjjDSN6CYQpCeMwfY5sIZW0A2LpWJREXsyhv2zWs
 JnhdHXHxStdHvnMRxb9m225wRoHB+CG6+DdGSKENEV7wTkjr59C8y60q1JJttzXiImps
 RwTUue6+pJ20kL1sZUMOZNMzGo7I23S12x2XrBVL1IhFGR1dlZ/fbVCUMeBxCv8LQVDS
 gX/OQwzWhiU7aNwuTj1UL2fLhUwCvVbl/+AuaGo6bu2VRxgV8pBK514KK4P8BkWMxJEf TA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1xb7kdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 07:54:17 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31F66I0G015210;
        Wed, 15 Feb 2023 07:54:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f6r5c3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 07:54:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVasMAOUzBoZx2xOCLrCPBG7dTxCbAVEa2nenoqxlZ9ODnX1Sq16RBiGv9MeGiTi6NEEgVVDzh52YCLrfRAdwNjGTkUd8mwUgoNs0znfBourTFsIy/JNBlz5/baOuErmKPKYdtA8XzWPcBAd4iSuOSYFUSfer37PQ7kLaKXa1hSzT0CxAyTCwlYJpHlK7PXHvbil0UWUiU02LdGvw3iJPNlz5qswvpwzepGpLddvLHmMPvrovlVjskjBuyqFk0yVV/uJe/whx6yG/LDBfDu1512rSJDxG1pv/WrB1cTVUULWmtCEp7XMZNxfPwj19NLH6p9/y/JcQf/h1951V1nHqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UeNg4j41lH8QuT2Zcii3RWdQni5vx3l/KoMeY4YMJXM=;
 b=TsAaJQwVIWNNmN77r0E7vpxflHuwFOx34c4pympJ4NDWr3btyMXzF70zIY5VbrxEztJFRV7U6ZumLpf6b3mQ1zBjabLUFSz7RGy5Rue8J0RwtnpfhIaHE+xiweMCJ9R0BAkXtdkHWh9QSwinrlHc5ChasCeiQ/n4b3QMAyMxCsvDidCav2jAHM6NI7trk5YCJN4vswrd2Qo/44G/gPycoFgsf3ryQPSZnaL5+bqHaLygNUMoYkZZbd3AiRJk8b0cLUl5g31BnB/bAxReGimBOKFFZ/Cguo0XPR021xZxviTID14+B97ZBc4C6dGEzxeKEXJSkrzNPioaoEE5nhz+iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeNg4j41lH8QuT2Zcii3RWdQni5vx3l/KoMeY4YMJXM=;
 b=zxLXQZiHa3EzdXRgnqkQN6DuBPxwg0Wqahs1oQyfvmLL6lX7XrrzEXki0ZmaLs85GixsG9H/yO/joXVDykkjwGQqmliWgBszBxnFPPDAzz3elUNrKuGi1iFYfoHZNLhxsLjThQ7oh8e5dzNGXOIgVfLlYqvRNliCj1177b0UN2Q=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB5730.namprd10.prod.outlook.com (2603:10b6:510:148::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Wed, 15 Feb
 2023 07:54:14 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%9]) with mapi id 15.20.6111.012; Wed, 15 Feb 2023
 07:54:14 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     zlang@redhat.com, fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH v2] fstests: btrfs/249: add _wants_kernel_commit
Date:   Wed, 15 Feb 2023 15:54:06 +0800
Message-Id: <75cbde02c45a75268b19dc8091a3af13ca1c2903.1676393253.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <a9970cfc5eef360f6eff8cd24b41f50c07c1d744.1676207936.git.anand.jain@oracle.com>
References: <a9970cfc5eef360f6eff8cd24b41f50c07c1d744.1676207936.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0098.apcprd02.prod.outlook.com
 (2603:1096:4:92::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB5730:EE_
X-MS-Office365-Filtering-Correlation-Id: 38c38786-6d1c-494e-f89a-08db0f29d4ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QGmfsTFEGGA7D5GNRM8/i0zmkw0Xf9X3nTYWe8gsS3Bmh8YuTgM3Ww6QkKGImtomQNkUX8yZQuMsNr0A/ggDYcuRG6WnUvEeg+nh5Vp3ii1zjyAUoU3OZ0A8uyGz1Gc8SAvSP/0o2ZWSiFlqNfJQz1rOyVTZ0IM7fJwzjwT8Tw3gWtM0m/9MGfMgsIBMsxj7tlj0dbGAGlIkVuFSrAZF6gSinR9XIZtEP3BUe6BPpkBOiSb4lqoaSX0A2Ujhl2qIZH4aoJ7rD9BRuJMIJCTjog79NcFyo4CKl04hfeLZzADkKCEZh3XnQUSaIRRWsBCiEp9HNQVbMG3wOmIPe7aXK/AEomS9G4MGbyS9x2bE1jJXR0Gfji+neMNT9q3jwAniLhinHCYqul1XdMV7CVm+2r87yq1uVrwUd5GHUgpHlCZAKL5toHtugSdenaHhiEIuvcgK/MNAXADkKD4ik7vydxOsPHuSteu8Xq1RV1h60+Msb700lp5uVuc4yJNixYH7LOEqzJj5FOhlaF5p42uvrGlh6uEBmmUq3ROIVpcuAjlJNUfCmz0JD8osOXY8V7gtR8nSNt750sv78Vg5AnSai9RHkpcuTw3agSfl9O3deha/IFVLAqPOvDF++Mr8wwPrqjpglV4FpHdWa9F1MfUAIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(39860400002)(376002)(396003)(136003)(451199018)(38100700002)(316002)(8936002)(4326008)(6916009)(8676002)(66476007)(41300700001)(2906002)(44832011)(66556008)(5660300002)(66946007)(6666004)(478600001)(6486002)(6506007)(2616005)(6512007)(186003)(26005)(36756003)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8rYpWS1KSIZ/ElcXNy2NJE8jfDuohbIxIt60Wv6G4ecX08QTnVwDA1MDiAG6?=
 =?us-ascii?Q?jRnDEZ1hwfauH3BE8kIeSbqKTKA1LKP3Wzr1KEVoTUFUk9oPxvByZUBaYMrB?=
 =?us-ascii?Q?AyY8Uwpa3y+0wAML4uSghRr0tSK8eetQOlRvHIux++rzzHz9rAdVD0dx9Vmk?=
 =?us-ascii?Q?d21MJmzkY/qMOrF5dF5aO3Wugw1RZlfhIOkdDwuTIMvAGo+NFlYHhA2pDR1b?=
 =?us-ascii?Q?Au7LIp2uAo8gfHfk2CGVUZlsBcQkZUPeAs6N6FdOxnOFzFktzHHJ3I+ZeGTu?=
 =?us-ascii?Q?W9B/6n9dyYPEMaaSWKXbrVaQMRYqK9RXvcBzTS0JGQGj7V1+SfTsjMcUVuEY?=
 =?us-ascii?Q?2cxmrKYSyCZ/fac9mhXVnlgX7bBvBzowfzrXlhYVOZWc6puSzP8XCrAAdPKo?=
 =?us-ascii?Q?zuxBj7EqpvSCMs3c1Fh3bSkV70ekWK6Bix23Xk7WvaM52ZoF7vtSobYIpzRq?=
 =?us-ascii?Q?RszHk7iUIzq2zW9vvHr8TO+V5Lqb7/iWr4ouw7zuHJ/hoseuq+sX2TVEhvSt?=
 =?us-ascii?Q?cSZks4CRekERj+g2zMT7SPwTATcoWTJg0EhniioXHfsCYldytTy1b/2FVNAj?=
 =?us-ascii?Q?pdrC9nqtKPMbhz+DKSf94ceu/g9b6QTE1Odwww6gXihqYUSunbuXhECzJ1Do?=
 =?us-ascii?Q?ibRoS8CxwSzGn/NKezMOqzzJjpxodEtT/FCJKUgIfcPDuPsMZ1J29UrFgbiU?=
 =?us-ascii?Q?HDGBNaVXRf9JGqNjOqm6yxA15Lnf3z+5t3b8DtNziz4GhJhM2OubAGxIdYqX?=
 =?us-ascii?Q?+JVwvTDaO/B6kYcLKpowo6SmCDYfdGCLXwi/YEx7GE7lZfG63cA4fTM3db3S?=
 =?us-ascii?Q?gM+PUPNEYixWv8KjKXocKwlTWMiWQz/NXtTazP7kFE0HHQYexM+EthRyYTBp?=
 =?us-ascii?Q?k41eLGAx1deVpR183A2aNRWM1cDtD4x1uFLzvG3/B7VQw4NF4l6kEIjRAZQo?=
 =?us-ascii?Q?2wWs2ElmKx6pY0yi0e8FBBGJHnqWr7r1CFMEketioJlW90Xtwh2likAkX8KB?=
 =?us-ascii?Q?3TKrqhJW/pxrnEf2l+Ki6u9fJNZXq5edpl6qeVowvpQJ+3QL0ScjjH192Hsy?=
 =?us-ascii?Q?/B4rSCHKCepTiDuUS6JKxKOGDsoZxbYsbmlI4vspZJsxdQlyQyuiiz1hhuE+?=
 =?us-ascii?Q?196sEPq4pFCE01/5/csCA0y3DXJvRvt17aZ6YgktFZTY/ysAQpYwp7OC0dF4?=
 =?us-ascii?Q?iHhsjMqyufMvO3/sYv1GbvnoNdFW9DgB3Xk2XW8MxHb39WSfwQM8hYeo1SPm?=
 =?us-ascii?Q?i6r0/uZr4bffNwDkqa5WGcEh+jzslHewPD6eZW/LPLbEoLM97wS/nD/qKSFn?=
 =?us-ascii?Q?XK7bbuXX1eRSWCj52o3dJ18DMOqnXCNu8bJe24J2dN83Uubtu4Vz6SGZmEWD?=
 =?us-ascii?Q?kR9waUaohUjDiFkEYP+5w08EGLadDfVr/QOhZEY0l0ux7XlZRxKJCAQJdTPj?=
 =?us-ascii?Q?y53D1GrBFE7TDiaZBpXW/kvRtzdcwGCKP76NmVPHXqyrrK2Djju8ODttgVO+?=
 =?us-ascii?Q?jJeYf2guZpRX8yvuG2AMDGu5+6m9OFgsYGOStsltBy0bXuvoaijvUDyzWt4i?=
 =?us-ascii?Q?qS+d7nSHHXGNkQujcro+CH8NfKTIYDrESgNwi5ZIC3ha83NiX9PBv+DTTMsV?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LfRUBfzhJlpwDmioF1u6H1G9ss3P+jagdEeRvZSihnpFqB2TBCHNb5zygwzSbBkhCpWIh76dsc2HuH9Squ9ng+77wf8sfyAu9hKFNPLwFmMKE6qMAGq5t+HtkVrDGg+GQF/jfm+lkalCou3NfJKOTIHyynpcReUTiyIqBmDWL6Rt7fAALbxBpzFtWn8lh7p5J/zja9PebJHfl6ViJ0hiuPzZ4i/SThHgU3jxqhGV0aZupr06PYVQMVDGyIveFWcN4Qna+IaVYbKFCIh/uIBhN0inSpcYftV4qxJDogBibbYCB/AN9OXoruSBIL5syxS8AfcdEivmKQlTYr3i1ruRSV+FJCw5Bjhzd5BWdSOGBbcWwAkf/l3yM5OZSoBHwJb0ErXSwmBu82UdnYa7J3qCpi3xCMTJwIwLlDYBG/VcrmmpKcPCz2QGdkOsVQsogMOG/iSyrjKbTmYN9lq2+979fGvyGS5QmvuWVeSug7MmtvzDlXFV55VACm9almLZVGLNpIDlsw5Pn2padUTSoKN1RzNKx4HqlxIPNTv+7u2LYxwfcpsF+2m2y2xZ5rRR+ofkNVveHngzT6OGFI9DX7BKOaMFEbTUMVgtvyeHmJS6dL/XbajTdcFXe5WjRF2J3aluwAJzmgLQmNWuc4Zy+LZpGffYmjKuqpUOUCWGXWK2cyWhFLVM746T5rtuds+1TQUs0mrucdVp7SxDCq+28FG6Iwmdp78swGSYmQLHxiuDrCP67UY5zt2W451mVP81pOncyB2rzH6CWM/iAisFdHxBDX0soL4jSlUKcuf18I8Pzbf5PqDeYYPvua7kixum6Exn
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c38786-6d1c-494e-f89a-08db0f29d4ba
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 07:54:14.3436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 69C5xsEXgJQOjVz0DTc4nfHbYfirOUbx5FC392kxdB62UgHVEX4jggKRSZzrMMwXdyJwBS4/DkVrW5lfMqVIVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5730
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_04,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302150072
X-Proofpoint-ORIG-GUID: jNEpSyIHF76JdFesdpk12dVQW6HKDY1T
X-Proofpoint-GUID: jNEpSyIHF76JdFesdpk12dVQW6HKDY1T
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add the _wants_kernel_commit tag for the benifit of testing on the older
kernels.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Include the necessary btrfs-progs patch.

 tests/btrfs/249 | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/btrfs/249 b/tests/btrfs/249
index 7cc4996e387b..06cc444b5d7a 100755
--- a/tests/btrfs/249
+++ b/tests/btrfs/249
@@ -12,9 +12,6 @@
 #  Create a sprout filesystem (an rw device on top of a seed device)
 #  Dump 'btrfs filesystem usage', check it didn't fail
 #
-# Tests btrfs-progs bug fixed by the kernel patch and a btrfs-prog patch
-#   btrfs: sysfs add devinfo/fsid to retrieve fsid from the device
-#   btrfs-progs: read fsid from the sysfs in device_is_seed
 
 . ./common/preamble
 _begin_fstest auto quick seed volume
@@ -29,6 +26,10 @@ _supported_fs btrfs
 _require_scratch_dev_pool 3
 _require_command "$WIPEFS_PROG" wipefs
 _require_btrfs_forget_or_module_loadable
+_wants_kernel_commit a26d60dedf9a \
+	"btrfs: sysfs: add devinfo/fsid to retrieve actual fsid from the device"
+_fixed_by_git_commit btrfs-progs xxxxxxxxxxxx \
+	"btrfs-progs: read fsid from the sysfs in device_is_seed"
 
 _scratch_dev_pool_get 2
 # use the scratch devices as seed devices
-- 
2.31.1

