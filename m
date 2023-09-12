Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E24F79C859
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 09:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjILHkk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 03:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjILHkj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 03:40:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BB0B9
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Sep 2023 00:40:36 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BJf33c015114;
        Tue, 12 Sep 2023 07:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=QQf0XZ8UlGu8FbxH/QeHC70OsLk8624SY0JYDOu3xds=;
 b=ZrbIyA0jFmEJbQ1HOeariOJBNdM0FsFxUI0ZRBj3/FzEnYqXfSwaYR7AbdCgU6+fLRcO
 7LgA2OBysNEl/pDNprKoKc/8p62pgJtBmA1s8sk2xO9PQ9dneQJincvMDv9CkqvjdGZz
 DvkARm2ArGF9g7Xv+eiPM69IJmE4rK8IDE4JML0ecV0TKbK7lbd390j3jaEBnodEJUnH
 UZCoCEpt/rptoImAuLRFDygOjoSOoGhvlFkq0LUvDurIUxHrlN1qC9XKdgSUoZretaO9
 XWGxck/ycgjMy6VWnSO80ZQ5zPfV3eVQraNUZAlYJRIZIi5x9d+0mueszYaOqqWDnX9x xg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1hy8bbtt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 07:40:22 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38C7acaS014757;
        Tue, 12 Sep 2023 07:40:21 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5bmukv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 07:40:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfG+iS1Xy5Tze3Bh1PRdxlgTzQsGgu3KU5mSji75LVV1yx/SRC4R/bt8t0F8OPICYMzMjkzpZ+KHqSfLyMGWDxXTnN2ZjwkFA7aPZ6YDOZANpQTdY+KVJsqNSaGEDXNb8Do7tw6EAIFxE6zFTNz7V5WmqFyQgYTzjQXTOAps/R74l/1cRPwUO6yYuC+sGG0k0HPDaWt9U7r0AJbpq+7cITzB2tkijEWHdR475QNEY4QLJDNvjQuk9jEgsTGQVt6dMGPHrZAfFvyoaLAtD+AoXfVlwcfzGfsgMAyz2ZMzasKv+JLYF9je93UgvWUL3wW6PAVOruegoZRDig6oWwoW8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQf0XZ8UlGu8FbxH/QeHC70OsLk8624SY0JYDOu3xds=;
 b=idYNt4Wjv2MiCw5QVIa4t8+3A1spye4JaSNky2e6uVgDHBm+BI809hFSp2Bqcf8F2SNBswtpWXU8miZqxz0GI2PmNLw4yG6pTV0hAKf7cseuOyWCysigIY4vCUdiWQO3IpTnJ0T10m7B7+MR10Qw2+KqRa5//JKyXBKoOh7nXx8kyWF1LJhawfZ9iTA7BDcN+Muw4WloS7DqMWbDEmivjFcBK881o1v6m4weouzosBtjqSP3Dl32s8a0zjR7hj606Tkb2sZ3bBGjne7LKirDqSqM04DBsHKLyjhjN4hYNOoDaCC7C7ozX+tAdS7HS8i0ctNUBXvbEmj01OM5bC1UFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQf0XZ8UlGu8FbxH/QeHC70OsLk8624SY0JYDOu3xds=;
 b=ez2aAf5xjWsk0AD2sO2/jSOJNZLxBvEi4Zm3hLGnqM5SknMVXcmXGijnSCVF4TpmivbInMDUBBiASlVAyjIjyIiHOVy3nDDc/VfpYHUIiWa36QiWn0SZYEnS17aupF+WENhVyfKueuz3Q+KDb5qkI5l3+jYJTpImEFNWjZMEKx8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH2PR10MB4358.namprd10.prod.outlook.com (2603:10b6:610:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Tue, 12 Sep
 2023 07:40:19 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 07:40:19 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>, gpiccoli@igalia.com,
        dsterba@suse.cz
Subject: [PATCH] btrfs: scan forget for no instance of dev
Date:   Tue, 12 Sep 2023 15:39:59 +0800
Message-Id: <d18a400b7708b2405278122c264357918be3bc5d.1694503804.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::23)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH2PR10MB4358:EE_
X-MS-Office365-Filtering-Correlation-Id: 988d4a74-8c50-465d-0ea5-08dbb363835e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ej57rdX+i0NXkkN1/OLBQ1aEWbjyadeFuvdEyDhFweyyVKiC7Kpi2oCsQAAgcRZFXOrEYbK6KD7wS7yejTujF8P6TBvoKWQElvFuXeBNP56PZU2csPrkFu3hiUK4RO1OMfolTdQ9J8waq2MvTEm8O5Tt8HdDzawjwR046Qa112DGATmzLPVeoqB6/EQM/OsGstB6VVIAnaP6FFMz9s/8Fn7QECbSSBQJO2t9F0wlvKqGY/o9/LkB4rg0IPIavJNwgyNs0WJuBTa0mIMkiUfqcfLY/wksLwY5ExfmDjMVyIbVVqrvglVHkFlXxGuMbk4x+qKbc2aXnjALQk/6aMO3Kbc0cxRJ6D+qS+ZYVdtzB6asIbs3NNPCS6YJeoEVNsY/e/md4YgrLmG9z2cnyzGgKpEYSibm/aDWIX+qUy67KC8Dl92tpKICaoUrj9jHzrXJTAN+YMQQHP/TrC6O0atwfEdXOoOguGFtB65U/E/+gDRt6nFupEo7F6HfnN7ILro3Rx2tOkLY5locOnWSEiE/79xpNiPZ4XG6p8mEbDK61G+V5+qVVZqXd92eUa0V7m81
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199024)(186009)(1800799009)(41300700001)(6506007)(6486002)(6666004)(26005)(36756003)(6512007)(38100700002)(86362001)(2616005)(2906002)(83380400001)(8676002)(8936002)(5660300002)(4326008)(478600001)(44832011)(66556008)(6916009)(66946007)(316002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5VLR3pXv27x2GzqhoTlTm4F/CF6/pz9ZRTOrtZwNT0FLFiOqs5827pC42+Qc?=
 =?us-ascii?Q?jk2oxDp1NARVbIehXzg8nOaTAJQ4bPoRhDXfx8r1jBDJ1b8EmfCyT8hlNUkw?=
 =?us-ascii?Q?GJ0sZ5h9SON1IQWf2JUBHjIChKJ2Z64wu3Qh6mee68JuEaP1waKPVrkWDT9j?=
 =?us-ascii?Q?OTvunCH8oZS9z1w/k9IXhJ1VN2fmiuKQNc7cFXTY/U93d8tRo+gM2NEle7eT?=
 =?us-ascii?Q?Et70BbI0v1MI6K0W5A8Wl5C9m3uiWFW+HM/QOiw6PO+uxSoXvGBaBwW2gYAf?=
 =?us-ascii?Q?dMiV32M9fnmgpt5iwRF3HnLJA87cg/USGuTtZqbzfFZV+PsvXWzg9WvTQqCY?=
 =?us-ascii?Q?NPTjM7rgx+pny+Vy3YOvFA2ItbLOcingVXl3cN6YT5/EiDqYrFnvfSE7ldox?=
 =?us-ascii?Q?VkTt6MsZqOIjwlMVVTeiRmxoTbK6o0PQezqrmQ8HN4zQ3rheabtph1TQC7Er?=
 =?us-ascii?Q?6aRBNdWRAZiElQclCUyp+6GhwoY0JyTiJ7shGobMqtZLOtOIDy2mRb97f+//?=
 =?us-ascii?Q?8VsXJ7tYjzWyfToBXK4eKG7mDSIPReuNWL9HEcP7uOBR1gHKSjw3NBfX1tB+?=
 =?us-ascii?Q?eSA+YOTMGX7X7MUINJ5X9yHey8gmeV6hxwvKH9Y0J4EnupZA73WnqSiPTncE?=
 =?us-ascii?Q?3TN8aUxjZjlnl6uPnm9jW8bFRuPiA11GHkQ/Bbxjeqb+Ax1PRNS4tnli9+Wc?=
 =?us-ascii?Q?yxzCpPrOj+oOMIRebW5qauhwoab+wmDEfMyuR+fdqTA+iVLNDRkPbR0tPpCp?=
 =?us-ascii?Q?Gl7xIelFirFk4U1NTfEBgNFXc7dv+Mz1I+/+ZHJdTexgqeoo3+SDD7usiVNg?=
 =?us-ascii?Q?3TzihGXbhpXwMR5r3GNeEPvbU/KkUU3/MuR2QaoKutS+DjLU99HuM4PhLmQa?=
 =?us-ascii?Q?yEqlfarDF9mIeLW9hkpXo2vCaXBt817Xo+12vq4jfMfmLbhd5a2KuNrmcNxz?=
 =?us-ascii?Q?cZ92uLBvCBjyGAg34j6CvLzSnxmVutVJfW5WnolGDebDvHB3L0QKPNwW+UUT?=
 =?us-ascii?Q?FUK1/CbE+nApMSY172s5BFnuJNl3FKyxNQy+0cmjg82twcXC87tCKgClMQXn?=
 =?us-ascii?Q?fT9lCad0ifNo+qx4N+RP6oQrD9c3hX7HEJZwua9c2WSkdBpRQaHNU2W5uzlA?=
 =?us-ascii?Q?4WAp4zbrD3BfgLbHF89iEP3gQsemWZOxREGzuE8A4Y95KtGYe34LNeo8+5ij?=
 =?us-ascii?Q?FkmVvZhdfpMOe+eG0L6qodQDT060dGyekyBV0FlJ1Jxz/cQ33KzZBeKp7LNQ?=
 =?us-ascii?Q?6d6bjysXGjtglEiMVMXcBZi4Qwd0scONU5Nmj/RQsm6pfVxrMBuGFgwXp+Wq?=
 =?us-ascii?Q?8saxZjCRoaiYyn6nwe2s8GHkB/B/U/to9n4+bKOEUxT60MJKuGv5nfRB99pm?=
 =?us-ascii?Q?xB68b9Q9B6v61BtnBp9xgGY9mNl5yD5kS7TM3D7iLq5K13Xtyd+Kngi8PyLI?=
 =?us-ascii?Q?chJvmkRCPfifck2KKJX8gCBIvt8RmaM3J2dYmjV5xYXZ9qNuctPzUxXEREEi?=
 =?us-ascii?Q?h8m6HeSTs+Kn2+PwBeXsQU3rCQ1Nx6Gepns1dC/VeKaYcOnVMTwNXf6tupVv?=
 =?us-ascii?Q?J0W+PQXkWLVpa4WOUnCa4zhE5UVoZPqKvN8tswa2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: USS2jvo8GbIoYwCdXPgc/yA76RnNeiW1qAgZBXcmHIZmMXsElL5DP3sDrbZoP1mFHvKBvhkbOgIdupaE2hSgbOY2SLHbe1rPMUhqFYCF0uzav/PZbhOqpVBAbJod63xBJfC2khn0HVMhJ0r9/VDrhEop17ZfnT//A1inZQ99uWtLpJj2VghSA2fHZ3IVZyqe97G6uC8zd1TidXiQmfMMoOid4FirthEECR0yybOO8hFQ7oywuNtOGpN+z6Bq2+FRuVGt3+Vf4SXOYz1dDkmhqLctPx4Ull9WywEo24l64hCfZjLsgIn5fm4/FMjdsjfzrPiE3uovzIogQ0m6j3LK5OsMTKJLyKUZpcvGC1hgd5pb3gKAcK/DdgPRDswHV7leYJSnUPm0w4nOflMUX3tT3/QG9BiL+Ophci5qY65CeU4iN9pZawz/CcwneV7HvF7eok6GN2XntoYJa9HeOHOrv3wY/3M5bqCHvViAgbJLJfmVA4MeOhf/WUJbezO99HkF2I+RfilsGhV005Rk7TpxDY9joTLOwWztBTMzqjHMppGjmprAVpBgJg1lny+WTs2sYJWcSCvOmTmVC0QHgmJ+eMuUBjEDNS8lRGiQSReplacHgifx487OlnCzVW0BZiQ2fa6ITGK7jI673lxE/7459QPNhf2My6YGk+JQHKpiiHbOjCtETLNZ9xFQLyCTJWqX0mhOx88G2IavZhwE8ASxG39MoEHQZryK8H64Cn+9lUpItqIlh6j78xhrOkAyKyA/YagCC/pRyuPluUaNCNk9nn7GRhXbGNqro51fyWlw8gp7CoPccTddQbKioF4ZJd6H
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 988d4a74-8c50-465d-0ea5-08dbb363835e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 07:40:19.3042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBTewDBOiCJN3joESmKDyAIELBuNR2luMjsiele80NvJ4CUvO2mOOFfr8CJc3pfxOVEOusyqizG3d+bY3U/0uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4358
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_04,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120065
X-Proofpoint-GUID: dQNTIq5BkAI_iyZWz_KCL_vXnutYx5oe
X-Proofpoint-ORIG-GUID: dQNTIq5BkAI_iyZWz_KCL_vXnutYx5oe
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In commit d41f57d15a90 ("btrfs: scan but don't register device on single
device filesystem"), the code scans the device but refrains from
registering the single device filesystem. Consequently, there's no reason
to report an error when running the 'btrfs device scan --forget <dev>'
command for a single device if 'dev' is not present in the device_list.
In such cases, returning success is the appropriate.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---

This patch fixes the failure reported by the test cases in btrfs/254,
due to the kernel commit d41f57d15a90. So this can be folded into it.


 fs/btrfs/volumes.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 53dcb8f17253..cc2b21a90106 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -507,13 +507,13 @@ static int btrfs_free_stale_devices(dev_t devt, struct btrfs_device *skip_device
 {
 	struct btrfs_fs_devices *fs_devices, *tmp_fs_devices;
 	struct btrfs_device *device, *tmp_device;
-	int ret = 0;
+	int ret;
+	bool freed = false;
 
 	lockdep_assert_held(&uuid_mutex);
 
-	if (devt)
-		ret = -ENOENT;
-
+	/* Return good status if there is no instance of devt. */
+	ret = 0;
 	list_for_each_entry_safe(fs_devices, tmp_fs_devices, &fs_uuids, fs_list) {
 
 		mutex_lock(&fs_devices->device_list_mutex);
@@ -524,8 +524,7 @@ static int btrfs_free_stale_devices(dev_t devt, struct btrfs_device *skip_device
 			if (devt && devt != device->devt)
 				continue;
 			if (fs_devices->opened) {
-				/* for an already deleted device return 0 */
-				if (devt && ret != 0)
+				if (devt)
 					ret = -EBUSY;
 				break;
 			}
@@ -535,7 +534,7 @@ static int btrfs_free_stale_devices(dev_t devt, struct btrfs_device *skip_device
 			list_del(&device->dev_list);
 			btrfs_free_device(device);
 
-			ret = 0;
+			freed = true;
 		}
 		mutex_unlock(&fs_devices->device_list_mutex);
 
@@ -546,6 +545,10 @@ static int btrfs_free_stale_devices(dev_t devt, struct btrfs_device *skip_device
 		}
 	}
 
+	/* If there is atleast one freed device return 0 */
+	if (freed)
+		return 0;
+
 	return ret;
 }
 
-- 
2.38.1

