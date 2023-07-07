Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC57474B4A3
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jul 2023 17:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjGGPw7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jul 2023 11:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbjGGPwz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jul 2023 11:52:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FDDFB
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jul 2023 08:52:54 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367FOAYS003221
        for <linux-btrfs@vger.kernel.org>; Fri, 7 Jul 2023 15:52:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=+LcCRgaqF9ZMz7lvvFXVwl726myYsEYfHXXLCsFaKtU=;
 b=2c7mIz36L8B+PFIIOY/G1iemb9q16YVmA2NQOJpymAxgTssDmoFpD54g348/mH6Z/cY8
 uZBARr/h/J4eubbaPvXd8yI1fER3nzPyomkH5lGVdSaHFdTz9Cs/66PJWxNw2YvS/6sW
 bbi8d1pXuTFL/MyvWkzCNk5XytYrWlFRvazf3HnfG7ztYO3wiaZeFso7h+ZqwwupdcLO
 C1KSVufsZPEqc1pxwMHyPBwvaqdNyHCMtUpfAgVE9U1ryx59+rASCNwoOvopLKwSe9Yh
 tbxtJXNRuZHvdriAd0ijEs5eBQJsXOFY0xrK4BCYm8dPk/3bnmCSjC32UqiBKNZ++cwo Gg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpn1j83pw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jul 2023 15:52:53 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 367ECbW8033353
        for <linux-btrfs@vger.kernel.org>; Fri, 7 Jul 2023 15:52:52 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak8t0kr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jul 2023 15:52:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuBeHq22cOfDZdkLgmcZcIY9FWb4fM9miz6sB94sGlTJKh6+GsLvyGlSArHMDPIbzAVBVBGtrIwnYv2vrPiWgr4QsVs0ZWFWlvtJgWeZqQVWu4bA8v73Uickj/uewGT1t6zoyJ3IbmQSKNRsHFAjHml/wSTfwpK2+MgeFwt8bMSClmgZPSwnHhruB8XYMaeRkP3F2J76Gb4A+4epD5KgI+gmRGTCcOp1DHQAmyBYqXOa9TXnKWAjVfwqBgWF/NZJFD1Z131i/JEqDZnTsmfOe0d3MBpg+nTwFEMz5B/mctVOgG7tP4ntbh7Ei9bDwhcv8br1ZKAB2nl288ZV8U21MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LcCRgaqF9ZMz7lvvFXVwl726myYsEYfHXXLCsFaKtU=;
 b=WgEHAzgUW4VKdJlLNbIMJ8IIegc6CtwWSAVZIlGI0iLIxHLFGohu6XLii2AQtk2i+BhcuuS8mT8tnv9bwCTR4NvePOmGVMDSaTEglhg0TgP5m2ilfbydlNYGo3aBXzVlqRdV28YyVXRjpLcdU8vd8+d4vLJ0/pN9luO5lCl+XMxf9OdbxCzZiAfVnSskPWlrIpUmSCSS+WFgHDiX+kaYDE+e0dCZEL3GXG9VCENOvLBh8E/MHEkuwa49oDEMZ/H2eu3/mhhr4ZMgvvdm0+Fjf5iOodykhWb5DNgVt1+QQJdCwt3llKV86HLMQZmbe9d6o51K+5TsDLnlPanyltC3pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LcCRgaqF9ZMz7lvvFXVwl726myYsEYfHXXLCsFaKtU=;
 b=JnS6dM/fPl7ZSX/nqbgVJKQDUlw866Ue6ocaVVG3rFL+YP8eb0cRWn7lg/1cTCeFyh9MVAKehCP/fO6HmupCt2yJL5059a0+m3HDBEIwRtzRfJ6JV6OO03vHYGkegGkLN9fXUC89ZQt1DU/Jn83ebWSsvEvq9ZTNigAqJgAcUgo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6156.namprd10.prod.outlook.com (2603:10b6:510:1f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 15:52:50 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814%4]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 15:52:50 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 00/11] btrfs-progs: fix bugs and CHANGING_FSID_V2 flag
Date:   Fri,  7 Jul 2023 23:52:30 +0800
Message-Id: <cover.1688724045.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:194::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: 9accb0ae-c797-4e05-950e-08db7f02379d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V+NNIm/Zg4jzOXb59ApIzfgWZzVD4EmIUwehkak/Lc8A/B4MPy4EIIwbOISdcgV/UwEXyXHRpV9ObgTeVfhXlyYa0/lkCUplByGSk1Jiy59Oqc5Kmge4A2KxcBhI+vjrlvVVga5xWHhioEFI7tB0jonHSkl0uzC7Ayyv0nsm/o7bKsEMDrt3rytYl5+dAMpzOztPh9Qt8FCRgPvCm+/TLGw23HvbiYYjqeUHzBRFzkYzJWIyAg98je2LAJtftq/yiyGWcoJ+DiHrsH3DZoBulgt7CB0YfXpXoib5WfT4zcuVbT6Mqb6AWUTKOOxKXq2g6gzyCRYByrTMhhxP7tR7m2xBvDB4ELTOEwY5peog12ACEp3WEqxP6ahnbrpzJISmHmss6Wf7LtYQZX8LLC68ttcZXfMD5kLycvwPXClYWs1JLDO3SyV+RxdU3GYptqyoQNuMs57+qDN+EzF+iTtW0LCVqprzvMmYE9SeSM1lGJ4VGtsopw1O8yXEN537czkyTAS7/4u4lrz84SxsQzNc1/WNSRTdzX/HmA6bE8/+cBucT8k8CwVFEyRaZKhpIoYg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199021)(44832011)(5660300002)(8676002)(66946007)(66476007)(6916009)(316002)(66556008)(2906002)(6666004)(6486002)(6512007)(41300700001)(8936002)(2616005)(26005)(6506007)(186003)(83380400001)(478600001)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r3J5VqgyMEe1yTlfloyEN4mk/6ueOVNOdDtj3c2o3ycIPb9TsoX2DhT9E6co?=
 =?us-ascii?Q?5Qw9Nrl8g5C/mPvnP6lpp+HHPl4uZW/wqwy9loPNm3Wb6ZShfMVSrzKy2d1x?=
 =?us-ascii?Q?TbQoyA+eZyKWDvyck5I4FhmPyGah49Zxd5FSgPG0qDJU8xrGLQxcJKtnZVw1?=
 =?us-ascii?Q?Rc6ScHDmMCP7UM9FkBr+tklZpKWRbAv5SnKGaATn+bhM8evAB9mJcebVAPmS?=
 =?us-ascii?Q?BBv1nKzHBnRX5CFbvXnyVuAAyGoUA3SAchCsMtz9I1+9Srq7jOupt91Z1Y6y?=
 =?us-ascii?Q?JioUlecKggmNIGi3LT5G/Q5OZTCS8gup/Miq40QVpqG4fZdbrvEuOBzYVGr4?=
 =?us-ascii?Q?Dv5hORDL8ru1EewdlxWAwIONsgeWHKZi9n7gMiORaU+50BOg+IEcXCrD4w/Y?=
 =?us-ascii?Q?8LcfnCCoe+gtV4qI7brvvLwp9+iUuyeoOfHU9qxoKs8Aa9NNynftRwYXqCmW?=
 =?us-ascii?Q?PpgN84RXXKuhI441Fh3g58EGNPcAnHKrEpZjqWt+jufGTUQWst4ENQ9sGkZr?=
 =?us-ascii?Q?oBc837fwwnpY7udnL7PenSOlZxTXCcKMDCpJyJW4/2x/NGqm5bQdcrFVMR0Z?=
 =?us-ascii?Q?v+B1rGZKHDZtYE0O4lj26bgZvsIMoq/oYBOUSnIX3IN903OnksnjapbrO8vw?=
 =?us-ascii?Q?mphy32ftCpcYjm6DZgoLfOxLebVjTvQgCc7V8j8DUP1aS5Uv5vFRJJQe+Xks?=
 =?us-ascii?Q?ge9ugh8ifoIcvCQZWukmHrB4q5xcRkyvRnyZ+/O/AmxsYsYOwALlx4oZhat3?=
 =?us-ascii?Q?vZL0VPzhpy6HA1Q22csTAfhpvumHZDWaTKF0BckYyZv4bLz+oZaXuJTyZuPo?=
 =?us-ascii?Q?fVp40B8fjcx6/JGooCUh+vipU+UhOtj/YnCT1faBjMnMdp8+DJgI6Nab/LUX?=
 =?us-ascii?Q?BDEYHo+m01q+M9SwEiNAW14qgWInPgbNtDz4jDT6ZYflpPinHOGg4BOZEXgL?=
 =?us-ascii?Q?iDdONzpapGApbD5Td3fUEVTfLfKsghap/K1A+1pg5J4VynKWdCzSu6848fFf?=
 =?us-ascii?Q?SMBuYYgP+HRYa9ikeZHkBFm1dMoYBP7tP/hpllFxsNF7MkM7Fb7YXVYyvHF8?=
 =?us-ascii?Q?p6Ank22CQIAL27aZrjlqkfDxLZo5Exqg+u4+UZRwCg/KOPBfTW8ru9/DCTO/?=
 =?us-ascii?Q?M3FHR51mlaH/vMMpeq+S15y90CvLOyVZ3uJCB2o5dcJNV7a/xUFuahdb5E2Z?=
 =?us-ascii?Q?rz42g8ApBO87SFYwCmkwNVEaoWJ0P8hIXO+uOWvkUoWfp2ToubmA/7dA5wS1?=
 =?us-ascii?Q?yOYHiU0319QmsmJ10ThKRNYxwx7VdjwMH6g3v+Z4Jg9dKEuTwtTVJYKdL0Mc?=
 =?us-ascii?Q?UgUnOve/R4FRTc7nnM2PVtZGRqICw9JSswEdtmR2lUk0N/VQvhZwKfDXJg7C?=
 =?us-ascii?Q?PEM3z3eFgx9v/lAPfao85exSo4D7WyRue8QWfH+DAZ+9r82ZnRys+k/t5Qvh?=
 =?us-ascii?Q?tXyc8GJp3yfEUpyHq/G/pC1QVfmz06NCwdrUcfTfO3Oso9JNR8XzIuLvgZIT?=
 =?us-ascii?Q?xYNw/zEHtK1vPRROvfukNI8wIhUAQYDKbT3YJyncArfTFAaSwlI2RBbXerOq?=
 =?us-ascii?Q?1ioCyPQb1IuAJDxX7kiqmTL0b6kJBGe07OJ2sRlf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Xs/rTs2KQ+yxobyYonpHGUFfKhzarMce9aRyT7vJX3xhf/rmB3tabqRuZIIlyormEqt/7h0L5tbyxBGZDan9YZmrxd4CLLTkJ8ASE/+EUJ7KSJb5t28WYoaJdaQCFXG/NGCjl02vmX7CrAQYXA71bZ9UHYQEvdgmxU6E+oPlVeSIgcnvQBO+LjziCygqBLLNqHOavXmgSDl12sgPR8ggWKRc90Gywmms5GBBCJW70sOR/eXQ9g6G3YugJPuW1bbTpLsbFATPyW+VG8R52cEtM5uCWo5qd8p63JcuBlww5YqJ/u/CUyklh/dB62o2cAjtetQzREKcBMl1RCPJt93ePMd2hEVbBf5nUw+jwImarVAfBj/cMR/7+RtTli4JAtlG4nv3PUVVEZp/BgUCyJ1X+OGVgTZv7tFl8NNi5DP1XogO34lVOuGqBLUOSY8PsFL+MmLh0qDxLzLIrm/tcIaIbJfEfUYZyT5JF+m16KJo0Vj7rHjPN6EsYBmktAWVAY+m0S7fcs7afsK/rePh1QzoO95TA8O7JuaAdXreqz76NrP8T2XM5CCKthdm2KyBh6nsHZcwocAGf5NFs1Q506Zs55fk8BGm3/ftjg1w2+cHIxShiyiu5qDCfwvI8uo1oe97kOeVqKxbKHjq0yTO9wSIVvE+QSA8a7gWmCkZ08aEDZNiqMpNbWRl+uXh22W3ZvBOBKSbJaJbgap+LnT4FLSDQx21gPBL4cJKGsKbL89Pi8A6I/2Z8IxtFb4lWyEo/+A1
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9accb0ae-c797-4e05-950e-08db7f02379d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 15:52:50.4517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPIwYRahmozhIIYSn9iJlLsh62cMtOU29brA/4SvAyNoIipK9M0yLgkdMvj1jhkI0mwUSfnJgWGp7gTUaqwYmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6156
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=994
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307070147
X-Proofpoint-ORIG-GUID: adPs96_F_Tu1VYF1NxOocb3imlnNNCVH
X-Proofpoint-GUID: adPs96_F_Tu1VYF1NxOocb3imlnNNCVH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfstune currently lacks support for fixing incomplete or broken
previous runs. Instead, it relies on the kernel to assemble the
correct set of devices based on metadata_uuid, generation, and
the CHANGE_FSID_V2 flag.

However, depending on the kernel to handle this interim change_fsid
state may not be suitable for all situations. For instance, if
there are other fsids sharing the same metadata_uuid but are not
part of the incomplete fsid, the assembly process in the kernel
may not be transparent or controllable to the user. So, this patch
set bring the ability to fix incomplete fsid changes to the userland
using btrfstune.

This patch set fixes bugs as in the individual change log,
introduces new fs_devices members and helper functions, and
the last patch provides the feature discussed.

To ensure proper device assembly and to mitigate any potential
incorrect assembly this feature is behind the --noscan and
--device options. And calls automatically, however I am ok to
add another option like --fix-changing_fsid if you think it
makes sense. However, I don't think it is needed as of now
the kernel does it with all normal options.

This patch set depends on:

 --noscan and --device option:
  [PATCH 00/10] btrfs-progs: check and tune: add device and noscan options


Testing:

The btrfs-progs tests/misc-tests/034-metadata_uuid include a series of 4
disk images that contain incomplete fsid states (changing_fsid).

To evaluate this patch set, the images were tested using a local script,
which is not yet prepared for submission.

The typical testing steps involve:

	xz --uncompress --keep <imgs>

	btrfstune -m --noscan --device=disk1.raw disk2.raw
	btrfstune -m --noscan --device=disk2.raw disk1.raw

	btrfstune -m --noscan --device=disk3.raw disk4.raw
	btrfstune -m --noscan --device=disk4.raw disk3.raw

	and so on.

I plan to migrate misc-test/034-metadata_uuid test cases to assess
btrfstune, as the kernel's support for fixing the changing_fsid state
will be removed.

This patch set has successfully passed the btrfs-progs test cases.

Thanks.

Anand Jain (11):
  btrfs-progs: fix duplicate missing device
  btrfs-progs: call warn() for missing device
  btrfs-progs: track missing device counter
  btrfs-progs: NULL initialize device name for missing
  btrfs-progs: tune: check for missing device
  btrfs-progs: track changing_fsid flag in fs_devices
  btrfs-progs: track num_devices per fs_devices
  btrfs-progs: track total_devs in fs devices
  btrfs-progs: track active metadata_uuid per fs_devices
  btrfs-progs: add helper to reunite devices with same metadata_uuid
  btrfs-progs: tune: fix incomplete fsid_change

 common/device-scan.c        | 42 ++++++++++++++++
 common/device-scan.h        |  1 +
 kernel-shared/volumes.c     | 99 +++++++++++++++++++++++++++++++++++--
 kernel-shared/volumes.h     |  8 +++
 tune/change-metadata-uuid.c |  4 +-
 tune/change-uuid.c          |  4 +-
 tune/main.c                 | 16 +++++-
 7 files changed, 166 insertions(+), 8 deletions(-)

-- 
2.39.3

