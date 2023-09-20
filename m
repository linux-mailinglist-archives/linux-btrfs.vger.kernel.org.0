Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC777A8EB5
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Sep 2023 23:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjITVv4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Sep 2023 17:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjITVvz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Sep 2023 17:51:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AD1C9
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Sep 2023 14:51:49 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KKJdsr007884
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Sep 2023 21:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=5F78KBT/PF0US2pGxo53oobZAueRkf8IvRdTGJeq3vI=;
 b=b83WnMZZ9Hk7BapttUX0vcYNEWJOhsdrfi7FQBGnmmUp8zVOszdLUlSAMJ9xhw4evYYY
 9RidOp3mBMA+6OnO+ZHhgJIOS+TLi7xOkO2ZtgVBOGFo187Ox9R7QE80Z9oLJ0Bi5Qny
 HKQN7sxlm2Dj56oEWqHtmyw4fTSFfsZJSF/5oYYgfpjXjsE9uFZyi3rnYj93zUFU0Jc1
 3Joj2tp5Wj9r4er3zWcMTJq0Jmwc84Fzx49zmswTrUK+5s0yaXAO/zTnw8iKuHt7sytc
 ecQYHVoGcOZ9cUdav2Gk72W4hxiJGqneMoGFSpvOlx3LuHjjI786a/glAI6+0Rp/IK6M ZQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t539crjc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Sep 2023 21:51:48 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38KLa84b015876
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Sep 2023 21:51:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t7ek3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Sep 2023 21:51:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hil/pEa/ZYOv8C0nUtHIU9ngrbK610STflMGlAcNxnVrDO5+cC6cllHUYWU8vXYoL39yeiD4+BjK6mljgO6RWb0/SPJAKCui3YTs1FJNERfKzoOUzpRfX9sGBYU0RdNAA6Vd5YlL3Mq1qcjwy9TtuGEwGtAmxVtPUVBZURofalQPVYkNikvQr/EbkMQ75dbCRhbMR8vzd07ZCbRiUYOz3zSkiw83uQqPSrZ7linA9lQ0P7APjQzI68W1iDTcXVqP2Ka5CHFlV8lGr/eRX0U4DM6lBxaq87qeW8fu7K0JJtxQr4O9vXlkdmdVd/6DmqurjpayymcZ5kq5sZ2efjY+Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5F78KBT/PF0US2pGxo53oobZAueRkf8IvRdTGJeq3vI=;
 b=FymuYWXg8az4rH5dMitsCzdPUjsAtHtYvv//CCjgrIlrWMQN039jmGai9FWwjYfQw//xj/9zuci+y3Tv1YHueJcYm3kewh12I/IMp8GHdW4MNx/jnmGHk2zdC6IVXMWWN3sIeuXDP0T5XeanCNEJuygtMm91iMNhHCzqNfV1KMAHm+B8HWGWaGHImID5Lj6oDh5Abqt5BzXTjCDjOTCT43/iWxcyw1RJnsevixXXEVSjUkpia6OCYP5rJ6K+xdvsUTdJS86Np1bSX/1K82YwSooaoHfYzYSGna9YB4n4Md09j5pHYHu2ZlMR7xRXHMa07W3yunNVLEuiqjxa/BZeQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5F78KBT/PF0US2pGxo53oobZAueRkf8IvRdTGJeq3vI=;
 b=vbWYZfIMhE6OrllVnXel/c6XkD8swncSts4A0LYHtYkDIYKTYWF37Gi68hfewl7qY1IYB9gO93ka7B1sWxs2Bxzo1PviMhqwKchDrJxIMsCY5qZT6AaVMy3kK5PhzaVjnZtVIIjJ9p441D70odphyH9LQCmdiDQdttzm6hdxysY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM3PR10MB7927.namprd10.prod.outlook.com (2603:10b6:0:42::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.28; Wed, 20 Sep 2023 21:51:42 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6792.024; Wed, 20 Sep 2023
 21:51:42 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 2/2] btrfs: remove unused code related to the CHANGING_FSID_V2 flag
Date:   Thu, 21 Sep 2023 05:51:14 +0800
Message-Id: <0f62955f15e60f493014592e8cf0dc6427e2bc1b.1695244296.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1695244296.git.anand.jain@oracle.com>
References: <cover.1695244296.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0142.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM3PR10MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: b9f7c25a-1f87-4469-10c6-08dbba23c692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a+yZ2NSRgq2cDY/2B2CfSkxjoCABAqQQgXZpdz2OO9aFYrW3i+Vc793qDGsDXRtD6UZCRpTm8+s5Ubv3AGSTB/h+ZTuXqiC8RaiJwflBdPlMt1887CzUWaLw//DXL5MLXiRs4E+fxS2/sV068NhIHy4/CeqVySy6bzzbiSyrHk76RcY1Ybra9RYvxSI8gei6xpfQWdyz1D/+Tyz9DnHyFKP4bL5dl3eImFrKV9moz1dUSFTgM463PBnYpGthjBcXnx1WMnh51IzY9caeov4xtLTelNhFvcFiXbUbDIiKFg1P8/3AXMIHm7KP4Apoq/S1LQGpFBjZj+D5PYoq5et00ZSTQKgrGHFfcHb7PxAYOCFT7AetmXcYm5S4nPord+0K/MjkBWiCsRIZYSYRmtPDL9f7YbdS09pugc6WKpwDc3YSpJiiEqs921Lq3Z7RXcsvBVP64pRTv8MWEC05Zam0fzHEG7fEgdSjJ5DR79S5zBE8JVXQuaYx50KfV9tp75NLXh58HMDOqFHIocseiybgwlCwEFPS+7GZ/+KfgDuEL7bNSDXy7LtWN08S1UMZUNTu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(346002)(366004)(186009)(1800799009)(451199024)(86362001)(478600001)(6486002)(6666004)(6506007)(36756003)(38100700002)(2906002)(26005)(8676002)(44832011)(83380400001)(8936002)(5660300002)(2616005)(41300700001)(66556008)(4326008)(316002)(107886003)(66946007)(6916009)(6512007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/6cDF5zFTn35Q7Klm0Hi9F39WuI0FoBi90YZAbT+/LgH7KVFR3aKdZWkHr/z?=
 =?us-ascii?Q?mOAFQiZOHeCL+5EYKC2mF7nNze49tG16cCuxEOlS1XSx3arM8tZTgEHWHVIA?=
 =?us-ascii?Q?nCUb8TiIVkD5LH3PcQfxZQsiEkrQgEU3tmBzkUrXOCOHfQ5AteQKpIqGmULQ?=
 =?us-ascii?Q?ojNYEyz4qjk+X64s6CBXer29x0RK0hmx5zcQBoCy6UL5ekkOlKMwy16CrV1B?=
 =?us-ascii?Q?6mou3oC61jt9QoHVPEle8Rx7fyVrfvOMbvrgiiJobYZTSQUxZGTNWuAfrW/8?=
 =?us-ascii?Q?dkyks6j4G2Y0lmJYTzUNoK1ztg/a/CAGUO0ksnml7kKkEUNAt3C0Uju3nWpL?=
 =?us-ascii?Q?7xFpGUm3L0yGa6x3MyB4vBFkwdqlqnkKPaG9DcPQXC7hOvD8CKLWbxFt25M8?=
 =?us-ascii?Q?WrV3l7tW77u4e4Z04yIE0GVjE3I7wbPG+0VKbboNi21iLB1LVg80rUxOtjnz?=
 =?us-ascii?Q?FDeckpsjnuzaE86UVsMdi9qSXdH39XRd2Jgnh+0c16qJGJqNESwiL8UCySVF?=
 =?us-ascii?Q?+fyjU03LXBGsYYsHF5hhVL7mByUJvcSrblXo8Y+BuGpTqWa0tZTEmFOscw0g?=
 =?us-ascii?Q?Vj8HTI7hy1+1VsM5W8tEqcpIAOeRpkXcifDjTtAhZJE67U6j06zFsrUra8Co?=
 =?us-ascii?Q?lnC+vJGE1uz65/V95i0dX2fFdRmBfhhpHutv6bCyOPbsLf2b4H0h/OWQq0m3?=
 =?us-ascii?Q?rPpcGB0xkD9yXbPY+L3JHRFxHEM1PZtaNS25Ld1qVerleda51JIrPfL1ZLDv?=
 =?us-ascii?Q?kpciwR6tDIlT7fUL61K+5axlWNbEUSTvbrT9eGAehnOxQJvCz8eGElqRYCsr?=
 =?us-ascii?Q?dY3WKlAv92NvcDtQ4eWDXppiiYDfC3lq9HHHtNi10FaAcBleg/7Xi61CmDY0?=
 =?us-ascii?Q?ilXAMjRtDMypiwMXzah6HQ6BATSZxurLsrxArz+Fb5RAqgXj+GUrnxXBcit8?=
 =?us-ascii?Q?GJejTn3hI9VBU14pm6cek+HaAT3tUbFas764123dHEh3b2BBzH3J0mmgelYs?=
 =?us-ascii?Q?bgy5DSt1cykHplvyIXCAFpnzO8D0O8lke73dDAZdLm9BKpw0RmXJxOGtcmGh?=
 =?us-ascii?Q?BXZ2LggvQXtH0dYmRz4oiwTCbGn57ev1n3tIeWco3bqahOnRmrk25rH4GnRj?=
 =?us-ascii?Q?ddi6/2W9vN1z4AR+xhVJ7yNFzhdxGDugX0owTw1eQOmzRqJ8Y2qeKj5cMcWw?=
 =?us-ascii?Q?JTetHKz/Mgnv7ErQb3eBvuON4kp3dTVu9PizUPElxipAszdKcsRVlyaAv1t6?=
 =?us-ascii?Q?rt8cPy2+OihMwbJv/N21b9hqqt1vatqAmKmtNCiKCnehVOiTzrLIU8z6HEs5?=
 =?us-ascii?Q?SjlTlLRcCjlHGCgll5UDAv8ZJSCQbQXqk4rNarWgW9nhk3Ctw+e6m2+VJ1PA?=
 =?us-ascii?Q?yL5x7G5h1WxCE72VdOeHWT/zUFi2JoKohBxhWEHajx4AfpM90CjF/zDRW2Mg?=
 =?us-ascii?Q?ai08WlcfbLxvlT3FTHrz4eT85NHegOvHgMes/7+ASnsnRUc5w83Y2p89MvHh?=
 =?us-ascii?Q?IHaa7Lmk5aX2Z8vwGerj37kZxhdHDVFMH3I6IKmzz2kGUBT9K8qTB70OTIF4?=
 =?us-ascii?Q?PZWtBIWeFPaUUdNizse1yAOSzt/yFwcWwH1c6HVQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GQo5xt9qUFuKB+RHNQ0XUTDf6nCaMB9XNTSVEBTw7d+hXXwq5Lryu5Rb5M/abWD1P5EUduXNHgKhRewxA2RGfxBJhdo5MeKwsTVV6qWV3e6TIMe+jrwUukiEq4ljf0DvbZROnLh/6h9oM5CXl8KH0fZUw8sGwbjF30qC9tMhcMV2SL2d0WppTlL48GHmqoAygB+LYowM0v3DyINgklXx44nO7as06AH5ow6Ji2ChqxYeEOZM3e5F3aCGhl8PilgmttzvNAv3B5zBmEPvYmEdafduW00eVW0rzdKa52NW3FrlGTOF9YhUi0rRd3MU4G4tk3q4SFkGEBi+QlXGw6t0+Lb/GlzVhOfMb0ECc6wm0MWUmxkYj2CW5xV7cFpfo5S+bVa7qUg2W0htGzcm22qBDJ7adqO/eZOYSdLkI3/DDjWNa4qqGX84T8Ozfx2Iob0lCPkk45d0M3c8AVKl9kSzTbsWabrF6vKb176+/ewzjF46mGDxgARqySrtrTsIJJ3CddGUi5G2MiXyJToemAWK7FIomvApLxghQQj9Fd96rit9VzJ3HBPc5TUxPOEFEC6XtZ5tA2WTDCQDYruuOMSwsrFCCh10NVHtcd+zFK8FQcI6ebBIoh7vHqaHFSzBClqUcEs76Cw4WzzKVhIWf8w/dY43v0hm8EIM2IqGb6dfgUPFOg5dGLQi50oa9Cs9fX42C7X+odZGok8XDaA+1TXivLx9D6INIAnr60xJvzcUUoKYkf4TMQP18evSM67lEhCcj5hzeUWOFT1oFYKfqxy6vg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f7c25a-1f87-4469-10c6-08dbba23c692
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 21:51:42.2395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o2FlKCTLoq9L0+GA5HLd1JZANbjbbfS1vNtz8etjeV8xu3NUfV0SILcBBY9/ayuA0rJPJwbsDnKS0IgiZ9ZH+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7927
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_11,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200183
X-Proofpoint-ORIG-GUID: qYnh31UeTsq3BThOaCA3wNs3KxlBzII8
X-Proofpoint-GUID: qYnh31UeTsq3BThOaCA3wNs3KxlBzII8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The commit ("btrfs: reject devices with CHANGING_FSID_V2") has stopped
the assembly of devices with the CHANGING_FSID_V2 flag in the kernel.
Remove the related unused code.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 161 ++-------------------------------------------
 fs/btrfs/volumes.h |   1 -
 2 files changed, 7 insertions(+), 155 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c845c60ec207..8ebd1427a6f3 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -455,58 +455,6 @@ static noinline struct btrfs_fs_devices *find_fsid(
 	return NULL;
 }
 
-/*
- * First check if the metadata_uuid is different from the fsid in the given
- * fs_devices. Then check if the given fsid is the same as the metadata_uuid
- * in the fs_devices. If it is, return true; otherwise, return false.
- */
-static inline bool check_fsid_changed(const struct btrfs_fs_devices *fs_devices,
-				      const u8 *fsid)
-{
-	return memcmp(fs_devices->fsid, fs_devices->metadata_uuid,
-		      BTRFS_FSID_SIZE) != 0 &&
-	       memcmp(fs_devices->metadata_uuid, fsid, BTRFS_FSID_SIZE) == 0;
-}
-
-static struct btrfs_fs_devices *find_fsid_with_metadata_uuid(
-				struct btrfs_super_block *disk_super)
-{
-
-	struct btrfs_fs_devices *fs_devices;
-
-	/*
-	 * Handle scanned device having completed its fsid change but
-	 * belonging to a fs_devices that was created by first scanning
-	 * a device which didn't have its fsid/metadata_uuid changed
-	 * at all and the CHANGING_FSID_V2 flag set.
-	 */
-	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
-		if (!fs_devices->fsid_change)
-			continue;
-
-		if (match_fsid_fs_devices(fs_devices, disk_super->metadata_uuid,
-					  fs_devices->fsid))
-			return fs_devices;
-	}
-
-	/*
-	 * Handle scanned device having completed its fsid change but
-	 * belonging to a fs_devices that was created by a device that
-	 * has an outdated pair of fsid/metadata_uuid and
-	 * CHANGING_FSID_V2 flag set.
-	 */
-	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
-		if (!fs_devices->fsid_change)
-			continue;
-
-		if (check_fsid_changed(fs_devices, disk_super->metadata_uuid))
-			return fs_devices;
-	}
-
-	return find_fsid(disk_super->fsid, disk_super->metadata_uuid);
-}
-
-
 static int
 btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
 		      int flush, struct block_device **bdev,
@@ -690,84 +638,6 @@ u8 *btrfs_sb_fsid_ptr(struct btrfs_super_block *sb)
 	return has_metadata_uuid ? sb->metadata_uuid : sb->fsid;
 }
 
-/*
- * Handle scanned device having its CHANGING_FSID_V2 flag set and the fs_devices
- * being created with a disk that has already completed its fsid change. Such
- * disk can belong to an fs which has its FSID changed or to one which doesn't.
- * Handle both cases here.
- */
-static struct btrfs_fs_devices *find_fsid_inprogress(
-					struct btrfs_super_block *disk_super)
-{
-	struct btrfs_fs_devices *fs_devices;
-
-	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
-		if (fs_devices->fsid_change)
-			continue;
-
-		if (check_fsid_changed(fs_devices,  disk_super->fsid))
-			return fs_devices;
-	}
-
-	return find_fsid(disk_super->fsid, NULL);
-}
-
-static struct btrfs_fs_devices *find_fsid_changed(
-					struct btrfs_super_block *disk_super)
-{
-	struct btrfs_fs_devices *fs_devices;
-
-	/*
-	 * Handles the case where scanned device is part of an fs that had
-	 * multiple successful changes of FSID but currently device didn't
-	 * observe it. Meaning our fsid will be different than theirs. We need
-	 * to handle two subcases :
-	 *  1 - The fs still continues to have different METADATA/FSID uuids.
-	 *  2 - The fs is switched back to its original FSID (METADATA/FSID
-	 *  are equal).
-	 */
-	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
-		/* Changed UUIDs */
-		if (check_fsid_changed(fs_devices, disk_super->metadata_uuid) &&
-		    memcmp(fs_devices->fsid, disk_super->fsid,
-			   BTRFS_FSID_SIZE) != 0)
-			return fs_devices;
-
-		/* Unchanged UUIDs */
-		if (memcmp(fs_devices->metadata_uuid, fs_devices->fsid,
-			   BTRFS_FSID_SIZE) == 0 &&
-		    memcmp(fs_devices->fsid, disk_super->metadata_uuid,
-			   BTRFS_FSID_SIZE) == 0)
-			return fs_devices;
-	}
-
-	return NULL;
-}
-
-static struct btrfs_fs_devices *find_fsid_reverted_metadata(
-				struct btrfs_super_block *disk_super)
-{
-	struct btrfs_fs_devices *fs_devices;
-
-	/*
-	 * Handle the case where the scanned device is part of an fs whose last
-	 * metadata UUID change reverted it to the original FSID. At the same
-	 * time fs_devices was first created by another constituent device
-	 * which didn't fully observe the operation. This results in an
-	 * btrfs_fs_devices created with metadata/fsid different AND
-	 * btrfs_fs_devices::fsid_change set AND the metadata_uuid of the
-	 * fs_devices equal to the FSID of the disk.
-	 */
-	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
-		if (!fs_devices->fsid_change)
-			continue;
-
-		if (check_fsid_changed(fs_devices, disk_super->fsid))
-			return fs_devices;
-	}
-
-	return NULL;
-}
 /*
  * Add new device to list of registered devices
  *
@@ -788,10 +658,9 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 	int error;
 	bool has_metadata_uuid = (btrfs_super_incompat_flags(disk_super) &
 		BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
-	bool fsid_change_in_progress = (btrfs_super_flags(disk_super) &
-					BTRFS_SUPER_FLAG_CHANGING_FSID_V2);
 
-	if (fsid_change_in_progress) {
+	if (btrfs_super_flags(disk_super) &
+	    BTRFS_SUPER_FLAG_CHANGING_FSID_V2) {
 		btrfs_err(NULL,
 "device %s has incomplete FSID changes please use btrfstune to complete",
 			  path);
@@ -805,20 +674,13 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		return ERR_PTR(error);
 	}
 
-	if (fsid_change_in_progress) {
-		if (!has_metadata_uuid)
-			fs_devices = find_fsid_inprogress(disk_super);
-		else
-			fs_devices = find_fsid_changed(disk_super);
-	} else if (has_metadata_uuid) {
-		fs_devices = find_fsid_with_metadata_uuid(disk_super);
+	if (has_metadata_uuid) {
+		fs_devices = find_fsid(disk_super->fsid,
+				       disk_super->metadata_uuid);
 	} else {
-		fs_devices = find_fsid_reverted_metadata(disk_super);
-		if (!fs_devices)
-			fs_devices = find_fsid(disk_super->fsid, NULL);
+		fs_devices = find_fsid(disk_super->fsid, NULL);
 	}
 
-
 	if (!fs_devices) {
 		fs_devices = alloc_fs_devices(disk_super->fsid);
 		if (has_metadata_uuid)
@@ -828,8 +690,6 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		if (IS_ERR(fs_devices))
 			return ERR_CAST(fs_devices);
 
-		fs_devices->fsid_change = fsid_change_in_progress;
-
 		mutex_lock(&fs_devices->device_list_mutex);
 		list_add(&fs_devices->fs_list, &fs_uuids);
 
@@ -843,18 +703,11 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		mutex_lock(&fs_devices->device_list_mutex);
 		device = btrfs_find_device(fs_devices, &args);
 
-		/*
-		 * If this disk has been pulled into an fs devices created by
-		 * a device which had the CHANGING_FSID_V2 flag then replace the
-		 * metadata_uuid/fsid values of the fs_devices.
-		 */
-		if (fs_devices->fsid_change &&
-		    found_transid > fs_devices->latest_generation) {
+		if (found_transid > fs_devices->latest_generation) {
 			memcpy(fs_devices->fsid, disk_super->fsid,
 					BTRFS_FSID_SIZE);
 			memcpy(fs_devices->metadata_uuid,
 			       btrfs_sb_fsid_ptr(disk_super), BTRFS_FSID_SIZE);
-			fs_devices->fsid_change = false;
 		}
 	}
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index a0e76bb20140..e485e6a3e52c 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -362,7 +362,6 @@ struct btrfs_fs_devices {
 	bool rotating;
 	/* Devices support TRIM/discard commands. */
 	bool discardable;
-	bool fsid_change;
 	/* The filesystem is a seed filesystem. */
 	bool seeding;
 
-- 
2.38.1

