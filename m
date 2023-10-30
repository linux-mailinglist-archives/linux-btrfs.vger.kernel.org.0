Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F547DBB8C
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Oct 2023 15:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbjJ3OPu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Oct 2023 10:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233684AbjJ3OPr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Oct 2023 10:15:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2422AEE;
        Mon, 30 Oct 2023 07:15:44 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UDocqv021750;
        Mon, 30 Oct 2023 14:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=SEjeDcT+immK+Y2GyXU3TZIMCoAfB3yfnOPwdnbra/Y=;
 b=Q5ErqZxrL4AqTLXmoITQP0JelowVNJTC0WVqmtBwg2QkMif0UgdGOeH+D0kx66UYpNJ/
 dUy4NqlGQrUR2Yc+urQI0lO7nZldQgIiKwT1Nj1nN9eFyN/9msBirxtM0mnmyfti+FqE
 QxKHQBShbs48dobRrz/0XaS4pF2pgAotFKpAm9yBHhjtAxa4N9ejyaAgcZZzQQboK4Tk
 6eFCvlf+8PDdvtMhDR83/p9SHzpwlkT6v3alHuhPlJUlED4OqHZq9pSprBHj+mheZbnh
 +ZRDfkxcpY6EWgIu41/0axeEbwVdi4WrJGYiNWPIhbfsHJDCNbXKVdicqViO9mUzVIio Jw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0t6b2t9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 14:15:41 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39UE3Pbm009110;
        Mon, 30 Oct 2023 14:15:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u14x46jr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 14:15:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/LAIyAb0yEcvv0vRNIMl9mgCBJbDApKYaUCKrxKfIg0kj/Dfd9iHgelDOEip/YNIDvdKobtCeBw3qFy25n8InCa8iZngB8HjnUIVVZuslSf0L9XIZBo9IKNCWKifGlrZ16N255mqj3gSTnZ6JhLtbsWjtKTEBxic8xZW6CMqbnNmFGmpdDTfrso8z6/yoTM9C7bsKWobr9tBznBFYpSX/MO0g8s4Pw+s/VPuMWK5EeTaG6oXX+NT4IJGIdxP26TSnF2c8M+KhfyviqXTzIKJcjPnzVAvYuw1ev+f/lfViTVpmlgNapQrC4AdiAYQQJdJQkO2p0H8DeDOwt19Xyf3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEjeDcT+immK+Y2GyXU3TZIMCoAfB3yfnOPwdnbra/Y=;
 b=fp1QYPAKOCjLXFKOilsQ811Qhd+606Mof1EokuvPhtWx9Nkj3icStVZ/tO2QaRvs1pZTB4MR3o46gNZzTcqCt7WAiuVE3MArpXgh3L1HLmyi3cLLnExuZApWcZeRJY8epByd29Lgbwx9AEeyNbQ9ersRD6scjhPwUGsEr7biyDEzHC8PIAWkTnR4ZUqCSd10oK6i3N5YQkSnVhkuTBtFFdMFemSvDDXcOQAbD2pVLy+pbgFgXEFVLkKEzv1dKLLtcd2PW66Ogp+3lrQt+oRYXWQ6cm15z13nW5p2wkE4iszcvl0q6ad7HoHP8Ik/WVNiKGK6zIeIpQDe7lr2MQEvlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEjeDcT+immK+Y2GyXU3TZIMCoAfB3yfnOPwdnbra/Y=;
 b=jdrGg7xlP2zDtG5rdsMubI6sv8j34iDM2SIrsawZC0IUe7Qavp6v8/9hK/KHyl/eRx7gNzF9//CMTQIGbgmoKx3rGUIMcb/4N84rGiQXinKrMjgt88OwtQJ/gh70mela3vSRJChF6+JZG1yw4BQY2sV0yF9MuT8jbrWBfxd6cSM=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by DS0PR10MB6127.namprd10.prod.outlook.com (2603:10b6:8:c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Mon, 30 Oct
 2023 14:15:39 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::9010:707c:641f:68ab]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::9010:707c:641f:68ab%6]) with mapi id 15.20.6907.021; Mon, 30 Oct 2023
 14:15:39 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [PATCH 5/6 v3] btrfs/219: cloned-device mount capability update
Date:   Mon, 30 Oct 2023 22:15:07 +0800
Message-Id: <63f926ab53abb279fa0a836bd1391baaf308afc4.1698674332.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1698674332.git.anand.jain@oracle.com>
References: <cover.1698674332.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:195::11) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|DS0PR10MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b607096-de08-4091-fcfb-08dbd952b14c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 15ksTbTXjNKBd/xL2yubmlrGBTY7/nbYIUnirEhut39t0jkJngAmOjjlHSml/+0UiWi2fkvXJcVEEdLeNNXxmZiyfMfcSG4OvSoKAxXDR3yQCLC3S1b2rFptZwnTu03aJr++ogHhheVCklV5GFkQxFtipa8Ct4/RfSI3d9+FmOWboOsobJXgTx6Ygynk6pOUFfFWzl8qXvbIh+85Wtb/lpui0uBiMsh+5yNgM+qOsVlNdHxT9gBQScICWU0wWxdpEj2XJRzFsn2gD5zcWdXOBC0KyRzBbZTnACwjUegPsX8IK7BeDcOP7n7NUuJl7ra80+Vks/ufUIgjmlj36FGHvNH3NCBOkxo5YzoFcGAq4jWfOYcCHCRNYmMlYwxuwmvuh9zUa68D7AdrihVk/d7IZSzeiGo3WaALM+wK5yeF3xm1zpYnMq7Ke8o9f7j3coX2tLAlmueHnZZjnszE/w1RBc084YJD/QjCoAlrpXxqVXmgGZP+V+zXBXiEa/Dm7ujmMXfPoTo49h5aL7EPiuIaHss5dWuw1itD6FKjb09njDI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(136003)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38100700002)(2906002)(83380400001)(5660300002)(2616005)(86362001)(6512007)(41300700001)(44832011)(66556008)(66476007)(316002)(6916009)(66946007)(6666004)(6486002)(6506007)(8676002)(966005)(26005)(478600001)(4326008)(8936002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NSnrXnBn6jBASDoJbjXAyqw1/0hdUdrjArtWJeWKab1xmTOKNbrMjDBulQDg?=
 =?us-ascii?Q?NpMrjYU6mEVRYhToOgGZw9HKdBsnxeT9gdTwU7g4+pw0teAjiSGrD7rYstqh?=
 =?us-ascii?Q?oQo2ZnM2UlKE5JRZ6W2RXIeApLWi/0MYrWusNX3Rw0TiX67Nu679FN17MYYs?=
 =?us-ascii?Q?0hKYMx0bBJ/rGAGQMxyj+X5+HMz1+8/ImYmjxOOcD+hfUgwySf0ay0oyLi2K?=
 =?us-ascii?Q?EqodRwZBhqS8jffDBRIBqq8te1jHhvtZt937FZstuq8kcpcTbPsSiLszxtV9?=
 =?us-ascii?Q?Z6iSRhjyvZ/pY5BK9lMj+3h3xNBM0U4MVfwek8nEVZH/R2BAX4LotIy2Nvp0?=
 =?us-ascii?Q?WzV+RJnP+slgWw9qjA75CvU+Dr8JGV1u3bw1H8qn045SmVLolYuQpGHZuUrP?=
 =?us-ascii?Q?kIOO7K35c2iT5Jl7ZGLqC0OTrCpSuYgjysGJDdC+YzXFyIMSr6ffz+zd5I/0?=
 =?us-ascii?Q?1gxDkZ7zsG6ek45whIi6XeJQGpfIR6oljURHWyEdEaMOfRo/Q+aPVWPGm87v?=
 =?us-ascii?Q?HrsIYNEra1EJtdaCrTyzSWZxOvoKiXEWrn4RmSHxjrw75GzfEshKyH3snAYs?=
 =?us-ascii?Q?GoV1aZEG5W0vmlsPtlt6xXFhDij75Sf8zaeG8WUTZ/ayp4l3ohwyMKzUA5oe?=
 =?us-ascii?Q?buE3qTfP60u2Am0sXc6tcpV+YtM9ePQhaVL5jqHSno31daLAqKUdnuvv+9d2?=
 =?us-ascii?Q?gRNfzs9PyZ9ko6UnxOOHco+6xE8BKJylFwbxfHAS43kQIepN5NFfoKgWuQlo?=
 =?us-ascii?Q?GM7uBpAnLLslv3a0Rbh2Ae8PFfwrrPRV+DeWARmwFtntt1GGGksVMEpCF6Ty?=
 =?us-ascii?Q?pZ0/KqMPgc7z1pH9bDkJoJ7jX5/XaYEZ8+GlgBxCR22yYEcXlnau2jkXZ7hw?=
 =?us-ascii?Q?9X/+Zq/0iaFAi7LKGvA7IuCi1IOlmXpPaVk2WdZtggexrFtojdMwM9WXjalC?=
 =?us-ascii?Q?uIcWrsqohP12/V0DgjfzVsdLf2vECG8xAFBl+tHuJJ2KxEHVmLhGTyNAwtb9?=
 =?us-ascii?Q?xIaTVZaepN2CEHVjRvroEri8eY9NZwovJs89gyF5PoTN+MFLH/soZ8VgDVz6?=
 =?us-ascii?Q?EVIHyYqsVnLdsaLLQpWxPIZw7O5NjL0qV+qtzG7CtF/I2pRajcc+y2yHbc0Z?=
 =?us-ascii?Q?yU3RcsCnSodxNdveB0PGFFHXLmo2q4fjrkNTDAUajOS7nsK4sBnPwmRLMNe0?=
 =?us-ascii?Q?LdwoDzKZww41TRKJ0qyF0MEgsLaxusQAgRKx9mpujozXlxz2YHr4x037vXRI?=
 =?us-ascii?Q?lAByBnPC0YF0Ye9QVwgYxf7dWlwTJtt58AMlJQ6k5qkj1VfPC7XGNn1Rl2LI?=
 =?us-ascii?Q?EtY2LimaeAJ5MMNBcDNVn1wyhI2sHNqtieSwbSmHjlWWB6QMbE0dffEse1K5?=
 =?us-ascii?Q?lKu/XvrVMUd0ates+EvjDhG7gY+1TZrMnDO/IM1hHN4T4uV2d2wnpa0BlY14?=
 =?us-ascii?Q?N4MNEvdyR6q2H7vGXoT4brzx+uNUoVaCQWlo63hnu+aM0hl4LoaLjVutE1Yw?=
 =?us-ascii?Q?Yh3jskaFiKSbrD9jplHIBp/BgOPVOPZxICEQ/ZizI3YWgn9BJpqoaHpFvk2n?=
 =?us-ascii?Q?YIF29XBHSJJed28iBL/HdMfYdiem9cFFCE3qjI30NQbdFN/bu/JdfLKMF3F5?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ne1EM00rV0h8+Crxv8NE3/2Eezp6yal7Tn4k5OAppXUefgskA24iFZGVlFDn7vJljuuv1zUMsIEWRUpgHV9x5C3Kqw2F9Sro+1UZgrXeHx8+M8UXrEqWh8lp4F5NA9CHaxhT425zZ9kk/1a4ThVlJyumuO/BiARYqPyDRsLHSBDr3p9OMc8G/KWWJteDfNpFmNQO+YE+F0Pp7Z6o4bB7b8X0vJme2/NO4aOP3UrSqMIePTdwQID5f26yDDLPyfDqNtjiAeHb2Kl6IFxfeIFLbfk/DeTyvXmpn+YJOXQaHcdXMl30pJNSl3Mn6FL2CldZdhLgtAFzpQIvBDEFN7jDcSHdFtNBnImRFAFtYO4BOabGiz0Nqi58Oam0JTNoEzKVq1pARttna0V40of1R1Yh0+43nWGTlMr/1L6QdAxmK48l9ww+vAk7RMZanvriifxvugygYcwaokO86Bq4vFGmIt8KMAyX5QmRNitWvQVMYcN8ObJV1YaEuKVaeU2T6ROKMolsGiRVyJ/u8qf+ZGq0re6boEe3VzVnvmYVUKWAX8r2j/Clu5TtwSBD0L6gxIuGfhmtl0KcWhL2BT0uinOPFPIDQEhbcp7CotoGMxJ/LIhCh3tFj+37i1CYXnrIEXoV0JDikoiRmn7DIXKqbLo3nn4dkQ/Zs3hafXQSuHeI1ad5TqO55+4XA/J2B2CC6PAmlsSx3XV14e9yKIFGtPVTChfCDRFguILjBnxtE7M0nYlukZBjcJvI3voTS0gK4cwEDEJ6ti3jdWzWv4bWXdDjSG9LFHBfnyjoeH+7rD5TdnM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b607096-de08-4091-fcfb-08dbd952b14c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 14:15:39.1412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGCOZk6UyKfZ0ZbHrjSkjlNr8xl3argeNoyZ7ATL3QJYaFaeZfA0x2HrA+nIu+CufL4igyKOD/4A2k8Qczj/qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6127
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310300108
X-Proofpoint-GUID: s4czEAkP42MAIuOmSUBOA0ubIVFbHOlB
X-Proofpoint-ORIG-GUID: s4czEAkP42MAIuOmSUBOA0ubIVFbHOlB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This test case checks for failure of the cloned device mounts, which
is no longer true after the commit a5b8a5f9f835 ("btrfs: support
cloned-device mount capability"). So check for the non-presence the
temp-fsid feature and do not test for the failure of the cloned device
mount.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202310251645.5fe5495a-oliver.sang@intel.com
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---

v3: check only that mount of clone device fails if temp-fsid is not
supported.

 tests/btrfs/219 | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tests/btrfs/219 b/tests/btrfs/219
index 44a4c79dc05d..3c414dd9c2e0 100755
--- a/tests/btrfs/219
+++ b/tests/btrfs/219
@@ -51,6 +51,7 @@ loop_dev2=""
 
 _require_test
 _require_loop
+_require_btrfs_fs_sysfs
 _require_btrfs_forget_or_module_loadable
 _fixed_by_kernel_commit 5f58d783fd78 \
 	"btrfs: free device in btrfs_close_devices for a single device filesystem"
@@ -88,14 +89,16 @@ _mount $loop_dev1 $loop_mnt1 > /dev/null 2>&1 || \
 	_fail "Failed to mount the second time"
 $UMOUNT_PROG $loop_mnt1
 
-# Now we definitely can't mount them at the same time, because we're still tied
-# to the limitation of one fs_devices per fsid.
+# Now try mount them at the same time, if kernel does not support
+# temp-fsid feature then mount will fail.
 _btrfs_forget_or_module_reload
 
 _mount $loop_dev1 $loop_mnt1 > /dev/null 2>&1 || \
 	_fail "Failed to mount the third time"
-_mount $loop_dev2 $loop_mnt2 > /dev/null 2>&1 && \
-	_fail "We were allowed to mount when we should have failed"
+if ! _has_btrfs_sysfs_feature_attr temp_fsid; then
+	_mount $loop_dev2 $loop_mnt2 > /dev/null 2>&1 && \
+		_fail "We were allowed to mount when we should have failed"
+fi
 
 _btrfs_rescan_devices
 # success, all done
-- 
2.39.3

