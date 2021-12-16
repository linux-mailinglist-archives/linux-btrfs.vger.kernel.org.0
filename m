Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF4C47725B
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Dec 2021 13:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbhLPM52 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Dec 2021 07:57:28 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:30270 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237069AbhLPM52 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Dec 2021 07:57:28 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BGCOktk004235;
        Thu, 16 Dec 2021 12:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=zC65l+39CBCp+dw1xl4cUd5wrd9eoBwoj1+w3rfTY2w=;
 b=WT1+XFd0gxvs7oN572hkBXfFf4YHuEFW9ggBKakECzkhEvsXgZ81Ux7SzNVXYI36M625
 Ivh3XVM4lSi0iV6sn3UMJQD+OA7A2/DKuap/i5KMq0mOp5UtbZbsX0vMnOWMwi7MSPZu
 WZeTt2di8xDiFahl7BKB2WLVEm0wqZ00ipqY01UZldq4hURJQKYxobfPZWYL2cv5t7+k
 POPirvYGbkAXThAzBAO44ntPa+mYYUAL4MDAfd2TGvb3HcaUrcwAuh1onjO/WUZvrv96
 FXpsqOx3x5p2ffbA0JGmDPnbqAk/hysSBTcwA1pU+cf4kfhooVzkWDGGS6IQL4Bb6MKo 3A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cykm5aq4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 12:57:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BGCpqBN081746;
        Thu, 16 Dec 2021 12:57:26 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by userp3020.oracle.com with ESMTP id 3cvnetm772-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 12:57:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glxJjdKYi6iXev92MITjBgvIIgUD++/lcHIsP6dWwBi1yTF5Fs3Q6KoF5p3MInvPwOU5NyIIW6+dQOng19HS39FnyH0o9B3NuEzE63r3wKueUpi/PBnGXCGiWIgxLJfN+sJtNOx8446OGzlOqJw1Xsmslzs14O4RH/cdf+Xa0CN92lTQ2YmcdxSDPw1psEdjv9nY8cdGLKtWPaT9aX2XmfUs4y4z/UWLlbKIsQ/N8Eceav8SzaNJ98NWAv/xV9g21O2wQ4+Xh9pZ9BhiusUh+utanc2ioUyO5nq/hKj5GcJAb2qqPvrViFSiZlz5mn3axiSs3o15kBUCRYVxZZQJXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zC65l+39CBCp+dw1xl4cUd5wrd9eoBwoj1+w3rfTY2w=;
 b=K03fh1k1htyaFPtyggfYmYbsVm1hietrujrW9lYeg9LwH98B0JywUTMY/ggFEbY/b+IW542o0iybMG74yForvWflu5Mj6wSoRZnnmjaypLria/0B1GF2QOxxeMS6dmTJqbq67kqAf+TVcrcpS6ItvdsGkU2DrtZ+I3n5Rb8ebtJk/mJ0uEke522PS+B7JtVKrvLVYJVBtwcYMa55yPweYLPNsWhdv64H/gME0jo5g5h1nsEevNPpS/mY67HTHoI0Dd4cXgYSD3MkfWGJmig0nV6J+6TsotGEn0hs8edvoTr9yBgHy9wxuch5mBppo++cH/eBUx30nVu/nsl1Ei7NAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zC65l+39CBCp+dw1xl4cUd5wrd9eoBwoj1+w3rfTY2w=;
 b=BW1RTiCqevBlUsRrvPwwgdE2v6Ansp/OQnmWknS3rIYuLaAt3ZU7OjX4/BupE2U/iRDBZXitDL3ijBUX/f+oLjL509Y16omx7I6EgUAodSkVhs7b2or6j7Mu4hnbsKJtarbEmOcxBRAVlpJRh6MDdXEbr2mtSjnkczewgQ+jGRk=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4851.namprd10.prod.outlook.com (2603:10b6:208:332::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 16 Dec
 2021 12:57:24 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4778.018; Thu, 16 Dec 2021
 12:57:24 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH stable-5.15.y 4/4] btrfs: remove stale comment about the btrfs_show_devname
Date:   Thu, 16 Dec 2021 20:56:47 +0800
Message-Id: <2fe0e10df7494300346f88470230a883f20753c4.1639658429.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639658429.git.anand.jain@oracle.com>
References: <cover.1639658429.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR03CA0021.apcprd03.prod.outlook.com
 (2603:1096:404:14::33) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 505cb29c-285c-4b11-ebef-08d9c0939b2b
X-MS-TrafficTypeDiagnostic: BLAPR10MB4851:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB48518B51D6D9F9D8FA7C8615E5779@BLAPR10MB4851.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:514;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MD5kVjmG74N4Jb3Rg/ZGfnGIpsnD6v5DB8Q0mnQd9V8e6lzpwk2bsEL5h/mS8BcKOfnB7sqwiB8J++yz1Byi6mKvGgTgSZymxsrHXftaWV5LqdrUPORMzFyDDdpDYv45x63kYb0WTd/bAbzPINu513qYo5gmxum09t0nPEjO/0I6RPI1uC9r9unL0lRgklgRH10bU8NxHnF8VuNSkzyO+SginzYyNBrKQhHvz5xUTrG6frDBOEXb5tFmPiUjU6yuRxbK+pSPSoAun7nnILbPEo6vMy2KgZXMX4vRRYw77Ey0SHBbiyTf7qelHwERF5Iv92lwlz1GOW6QbQDOI+Bes0FymKXx8y+nevIpIzmpX1lylISohYXm9P3Rtcjd20njZXcA8EqD/D+JM2Me3mk3MGy42C79HUF8X+KRPx6vqN10fWjmPElyImRFmh9Pq+ihgLi0QLuD5by/UECJR3zgUqIVLo9a0IwTr9stlpbRVio7Yam5ytKCt+L+hqwmHEwMldoNv0hflaOe9BKfQsgaAOvJ/Ks4UYrAidyUhVeX9GbO50BMxD07g6o1h9z3ieTou568MaFfZRJAez3kM7Jyucz8vzu7EYPYps4kNwDahr0XOSgdbCJ8z+gJkfw743gW/L2grvDYMGKn9tIQmSJrhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(450100002)(44832011)(66946007)(6486002)(36756003)(66556008)(5660300002)(38100700002)(8936002)(6666004)(6512007)(2906002)(86362001)(8676002)(4326008)(66476007)(6506007)(83380400001)(316002)(508600001)(2616005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gjzbs0xeDzORcrBBTP88Pq6m1YuAciI8d8+88QbzevdXApNtH5QDVj2Flg3y?=
 =?us-ascii?Q?FpCYktsd0f/K/t9fd95NfT1+9kcMSXqIvUr3y5KG3rDihFuChnFrT320iK0S?=
 =?us-ascii?Q?WapotyBAj4twOt8waTKG/jdAiEOmFUtbopJhalutSFdJVD+xDknkteMgGB03?=
 =?us-ascii?Q?urY8bBDck0f8rAdNxChopYg2IN5kYSkWfqnehAbZYFgEfaO89Udud3R2JvZZ?=
 =?us-ascii?Q?iYTfRkVh67JURq5SrA7nCBOxKIAJBBvfurG2TPMaKUj9j5WrbPSGYBaFkAgm?=
 =?us-ascii?Q?BcxBLY6l92RSGrSWkw3dt34QRPsxUoctXmvhP7ODpbliy5O7btIc3Rg+oE1t?=
 =?us-ascii?Q?TjX95FcRt0XgFi5BHA/ZFmDBRPD4S/xuO8qRicGB1iMNrXNhEPgOpPga2KsY?=
 =?us-ascii?Q?/eneGH8sfktoIRhHJAp7wH4gBW6V1zNWYp95hp+o7TemzoBPiYyeVCz0e0Bb?=
 =?us-ascii?Q?kVvkPw/whhTh7Fbjgmde7iAOIJo5/il/5IrJZSDLiiQk+ILx0+firgmK49VK?=
 =?us-ascii?Q?8e5tbX5YhdJBpwIOCmHobpW4+nmI0cGoqUEFgRix/PUt6BXKaHgY4f6l6H3o?=
 =?us-ascii?Q?8UfgPUR2Q1Deb7ICc3B3/xsSN3UcHUIXd4q6krcu14V9VEW8g3AkDrte+QFI?=
 =?us-ascii?Q?NgHxctC7ZZLZVpJVQg34JCJ4I1fd47ZMYall5ck3K9HUphhlsTfVcihQ372d?=
 =?us-ascii?Q?6Vu0/Qw983dsXhkIX0mWSZYzamv0vTCoXoYGlWG0RfDD2UF3S8xeSL5RJhDJ?=
 =?us-ascii?Q?YoldTmACh7z5fe7MNQF+ui1ifoMMx7rFiVL+ZuBXgqcYCQCgu/apu/6vagX3?=
 =?us-ascii?Q?tB8NPSSax+grimvYQrKWX1mHccquiCWiYTYocVNFOzE1NAQc/P2d1/+IjfNX?=
 =?us-ascii?Q?ue6dTlCSK9QGa1nCbplIlwi347eZ4lgGgKBI3qkOYHpFGMCxRcFpJ774CKdu?=
 =?us-ascii?Q?B2jhtpSX3qppljnGpNoNgzIS1yylPFEd8uaMnGdMIILyeULc+35ZIxZ97DJk?=
 =?us-ascii?Q?x+jphMu9ms04chhMKp0ejKMe1+krUKhEOLhSa2FjOeG8NqOL+D4GOUiXeDn4?=
 =?us-ascii?Q?b+6pxT3fIOU3t4TrJwzG9bFKa2+XnkilbMj0txg1QjFvD/+0SDqXTps/nl5L?=
 =?us-ascii?Q?mUlN1KsUktRdslNpVwlC4IaKvcxv2b+9prFixYR2Hesqi0qfXn0PbnwgvgtL?=
 =?us-ascii?Q?Ui6LzZ2R2BrJ3pKWOAtSW9MHLUoDcA4ajQwCUhzMVN/HiGLhFKdMBWDnrN9t?=
 =?us-ascii?Q?s+w/FOxpMhyR8Yn2g6qLyKBJHEyt3Im6Oip6K/VDieF53StF4CkXQtk6eHmc?=
 =?us-ascii?Q?jw+IjSPoBpKU7inn1yrQPNPYvGkwJ2VItMZO+O+NmK5qrdfb1oNzUZiMHwcs?=
 =?us-ascii?Q?uDTj78OGhA0+wa6FF29kBj9arEO27X4Uhnposh20t5JcEL3hw82w7K+Su9YO?=
 =?us-ascii?Q?J16lDeQjdthuVzgKgv0dIeCtn/e/d7VmDNYNmy7Px2vtGzLwy7BVgi9MHUMq?=
 =?us-ascii?Q?fCnG90Y0aTfduPkXuTWQ2Ab7Ilw0bQ3yByyNRadfBvhQ1tYgitUZ5RC9kNte?=
 =?us-ascii?Q?OONU0Q6aTKQ4rB5ZY1hu13hjKfmGwKp57fcLHu8Y98GK8JYr/VIWShc2c0TB?=
 =?us-ascii?Q?MGnKwvJAlzf8dGbejLRiTLXKNxI9i8gx0qWW9hQOwygITjcU0L1ayBt9F6+o?=
 =?us-ascii?Q?C/S/sg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 505cb29c-285c-4b11-ebef-08d9c0939b2b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 12:57:24.6958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 039Ktl2rK6VzwbpNRmfZgv5/uQ+t9Ec70Yt2FEdFK3aJjTMmeezqFlIB3o3LPMjq71iAtR17XowP3wBApNtqzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4851
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10199 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160072
X-Proofpoint-GUID: au_t6tcb_1eactmaIEewRwj2t8AU-CzD
X-Proofpoint-ORIG-GUID: au_t6tcb_1eactmaIEewRwj2t8AU-CzD
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit cdccc03a8a369b59cff5e7ea3292511cfa551120 upstream.

There were few lockdep warnings because btrfs_show_devname() was using
device_list_mutex as recorded in the commits:

  0ccd05285e7f ("btrfs: fix a possible umount deadlock")
  779bf3fefa83 ("btrfs: fix lock dep warning, move scratch dev out of device_list_mutex and uuid_mutex")

And finally, commit 88c14590cdd6 ("btrfs: use RCU in btrfs_show_devname
for device list traversal") removed the device_list_mutex from
btrfs_show_devname for performance reasons.

This patch removes a stale comment about the function
btrfs_show_devname and device_list_mutex.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b996ea0dc78b..0f549d2681c0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2312,13 +2312,6 @@ void btrfs_destroy_dev_replace_tgtdev(struct btrfs_device *tgtdev)
 
 	mutex_unlock(&fs_devices->device_list_mutex);
 
-	/*
-	 * The update_dev_time() with in btrfs_scratch_superblocks()
-	 * may lead to a call to btrfs_show_devname() which will try
-	 * to hold device_list_mutex. And here this device
-	 * is already out of device list, so we don't have to hold
-	 * the device_list_mutex lock.
-	 */
 	btrfs_scratch_superblocks(tgtdev->fs_info, tgtdev->bdev,
 				  tgtdev->name->str);
 
-- 
2.33.1

