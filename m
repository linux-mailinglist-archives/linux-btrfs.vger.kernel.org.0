Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08D370F5DA
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 14:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjEXMDz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 08:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjEXMDx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 08:03:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FDF184
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 05:03:52 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OC19cW020012
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:03:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=ReEmUnVPsBUYwcPRgw3J2dhS96tL2szo1iLQdzK4kF8=;
 b=zyYjqIIMlIlFrqwV4672Y5ZV82jJ9CI+NSipBcfHNNHFKFd3D6ubXRHEPHffOQN1jCX7
 pKdLHExU/8MBCvDNxkL9msdijEf3zfNjK9EpVhzDmkICwmAEQio6Phbk53dT3972DPEb
 O7aqCG7SmTR/IhSSPv4PxS2N1DQf7OVTqJzF2iLjAVGkBuVpwL3X48Juwsu0tYH+cc6N
 IpcZomtzxX/a6w6DuqouZNNUGvRGEZqM0HBMkv/zt0kw4MzFjT0KQljTzVVGxT09P70b
 H1Fyt0lpkx57QSMIquGnrHJEo49NlO4PdDEd1Eqek8e8MrrejLZmmslI/d8qFznHdq3Z ew== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qsj2980q4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:03:51 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34OAQbna028715
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:03:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2sd0uh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:03:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxP0JvA/tZKaiWmJJJ8N+7BFYt0QxF6MM8iXwYnS8NC56JjI82HpUl3JSMyWLxQ5PmqEb/yHrxMKXvxU/BWx1iR3wtJQRZ7m5AFVyER6A29Ro4qa39tdqUYFCVQr0KWf5012tem2GcMklbZ5xz+cT2DoWh2dPfFTbn8uY5etzCFJMej4REYTTNqgFL5txLxkP9ygszor/D9yIuUoJPTmdrxWM0mVssMvvslIbb2rjXpSY+21g1k/dVUCHHEHzxDYvtr3QAf0ANKd3zu4ezNEYtXRPiAEnvu64aXmKvjVRDiquz/5EP8rIo+2h2L4T/+p+ZGqbioLAVILScjP4wmMkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ReEmUnVPsBUYwcPRgw3J2dhS96tL2szo1iLQdzK4kF8=;
 b=Tpa6TismHgnE+5VDZ5RA/IcKqgjqPIgOyf2oMrkXCBdrY/sBuFYd3Qxm83bOSEoptzUOeWpNeDKhuw2poSDT+mkw8/9o2BIQtutNT1GvI0TrXSNv/C2ICxOKueIf4nXFzvZ1mPSQVrCRsm3HtK5599RK+YP1rAY3znjIZQkThCY5AdfSdRHuh31J8m13GqD0jrVJkvRrFmC+AComnaikocKhzO9qHo8bKwJ9AjoZCmwYjxsxAHh83WQi9xS4a3cQLT5uPZjtOZCRc0IKm1leWlMhHIR8YKvrYKMDgy+NmdSpJ+d7Eu0HaHM+JN1fJmnbFTav0/X64pAFastPDBWOtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ReEmUnVPsBUYwcPRgw3J2dhS96tL2szo1iLQdzK4kF8=;
 b=KBu5HJOVGvECcGkD+g+rMxdbhRdfkWRr5q6ZoRWl2s+9RKeVeqWR6TVaiUK0VYSclCCZne7k7GVFppNzZqurJ+ebhDuxeMgHC/NLciZytLat4aVwdQ/TyJZuFgYy3ZFRopCd3v3SjHdHoO7pV05oDMdUEatNkATFCqPuepJrD34=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB5098.namprd10.prod.outlook.com (2603:10b6:610:da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 12:03:48 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 12:03:47 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2 6/9] btrfs: refactor with match_fsid_fs_devices helper
Date:   Wed, 24 May 2023 20:02:40 +0800
Message-Id: <e9769859dca130abf187cab7861e03f57c507fd4.1684928629.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1684928629.git.anand.jain@oracle.com>
References: <cover.1684928629.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::33)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB5098:EE_
X-MS-Office365-Filtering-Correlation-Id: 88ca4a1c-aeab-42b0-e14d-08db5c4eedea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bEvmtPx+VjV5sYQxDVpMV8XkfGHX0VJmJhtLEvUJRq5HCBd4LjeKrrVnQObl4+yM1jK0GoEvWiK1aCsGsFj59u8bFCt9fwuJwEA7KKLb1V8UK2RzmSAgEUBAWOLGMPMKgQEXSWTH3sYKZyh6MGfL/47nZCyERErclEbOAqoSLi50LrWMBsMJl+FH9AfAWP4hUln+shvQh0e73Sf9uUkv97qAtyZ7FHMG4rSYRFvmqMy/VtucBQTjg6aVB1ahtj1tHNTpim1Mr2u7lvAgulI846IQiAj084o7mNv/rpQb3YKeOpV4u18dqW8FrH5c2R3Y0qlZn2uusgGy9VOBu0cgnLLZnkjJ3QZLnFcVeMZniYK/OX3QkS18SAI4k7s2nCnYBtq4+3B3OH0zhlYepwmpRV1istusE1M+p8DI9CIOKOj0J/sE1lbp7WWMJ42xc/8TzX20NjRC2oMNMhniHYjJt9I4tdBmRCtjdwejB8tOaPDcDFPDBsNyfvKjSdV2Zn7PtVQm1rkqEQPtRObb87seyeAX0y1i3OzGwTvf1tDce5WfhWZoR3V81ZFqXERuW3wF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(366004)(39860400002)(376002)(451199021)(8936002)(8676002)(44832011)(5660300002)(83380400001)(107886003)(6512007)(6506007)(2616005)(186003)(26005)(86362001)(38100700002)(41300700001)(6486002)(6916009)(6666004)(66946007)(66556008)(66476007)(316002)(4326008)(36756003)(478600001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o9eMvk3JPxKL2LmIsjeAynX/dN9bBMHVBfklLbbD680DR2FnS6FN1KX1E4Iw?=
 =?us-ascii?Q?Pyy3AN7OZnxiB7wqHQ9IBbEHRAI12XijJ4xauddnBM6xQSfvJW67eBc32iyq?=
 =?us-ascii?Q?+1IyAJWzEmlJQ7PJa95ghxup/tc44fSl+nVGRmb9uHQFCGq/7wNLrPFlumNz?=
 =?us-ascii?Q?TNBUdMrAFwC73GDBewMWuWppTGmrU8ySG24DSYsBgdZ9rCYfX9n9obR42wRt?=
 =?us-ascii?Q?jjZx2bQVHbb9ZpRXLSJj9AurWdeLfRJq4a4xK/g8lpXeCFdrUQTcHh6n2Vm8?=
 =?us-ascii?Q?vjUDYDDxnC04xVlpPrTKXXihhwVSdSoJvmlHIp+JdJojNL26JgLsrZI0XrHE?=
 =?us-ascii?Q?HuIUJRyqceCKIa4N3obdS/cnPQtk5niyjRpGO9lw923TCs04t9Idjomqfy6s?=
 =?us-ascii?Q?ANt9xPrIHqH64QCqLOPH6O+Otnq+OdqF8/Xvtd7b31WBxZkoGCLYa9FVoADK?=
 =?us-ascii?Q?6boWaF9Nf+YKJMD0XrUbnos+bgMD9a7GyHyGz+FtGRX9tcJSdUca0JU54LEb?=
 =?us-ascii?Q?YmHAJEdRoBmMYlPsdWlsokbGtCgxiTbINqiHT80iUw6f0Z8V9qpG3RT/be1N?=
 =?us-ascii?Q?6NSh+DNmHUOEb8bTdbGW+h7F/bJOBvVD8MVzR54W9Dmq4IiCPmI+ZoEVbXZ7?=
 =?us-ascii?Q?DFR2mzbBc4zrbjJK9NC5zCLIesFZFmmMYHkBZ/J5rcybBv12ZZtXW7Zqu1hf?=
 =?us-ascii?Q?UJCreqNPlxJUtsxiMfpSyCSjlkPnNtjxm6sgRwLkc+QBifLdugsBJGtimPpl?=
 =?us-ascii?Q?UgHGJ3Ohdzm889A30BUAMaW72iiZp44T8QN4w7B95oSCEfUrsDfcKqckV3h3?=
 =?us-ascii?Q?JWxJpv5ZMV05Zgbo+2bWBS/rajYJwCPJv8jidgt0gOP4hc31Cp+p1WloxsqN?=
 =?us-ascii?Q?Qe/bEtJneyOyiOM1+doRXC0p2Kl2Iwgr0o8hgGEMVcvlKvJ/Zxhzx6MN76ma?=
 =?us-ascii?Q?VcyphTswGN+fbHWE0HCeNQwdjrK5QdH01GW0UOtE4vucymn/eVQjt4TKm+fG?=
 =?us-ascii?Q?vKMhtJPk5LO1PAIE9kJMOz76DMNChcAcya3GuW6RvYIEitcssucvQdeOgI0S?=
 =?us-ascii?Q?RzU9nk8MsUJDTFFstQQhBrS/fnME/t5+SnFAj4neB+/VVVAjPtjAaGMGnXA6?=
 =?us-ascii?Q?pjCKL1OaKyGdqxNfNZeh1NRqU0rxqKLdOFS9GV5FIrf5htBbnYJUAhCzqSZ8?=
 =?us-ascii?Q?W00Z9wIB+syZj18T0FE+g41Iz/IJX5QtsEfjzdY8g6vh4DdwNkXTKwR1HM6W?=
 =?us-ascii?Q?TRmGzgXqT5J2Ly3z+LCnsszHEJUdmlTp3M8oHFvoQtSHd48ldhRibJZKx5DL?=
 =?us-ascii?Q?RtErev4TLcA8Ne3u6VEdscJH1BCK37bOKk4B6p9uVdTDPMun3YhUu7gTPGXb?=
 =?us-ascii?Q?J25dRC1ZXqNT0degyW1DqsZdtx+cbTP4tAaVfKVw2hxFb281yDc3NdWbbIOH?=
 =?us-ascii?Q?b4LWsobYtMvgpn9rR+W/bcvADeJc1WqlFT8gnf7/FcuRbf6edXMZ6axJ1CLo?=
 =?us-ascii?Q?Ko7xPgRQp+JlbPWxmLvbTqxgXmY9anHehbomC+ahFiihIjoskWwoQRzv2hFv?=
 =?us-ascii?Q?MG5lS4ZMU9S5rvrIyf0RRUAUH9UZPlnlZ6vDTW+33hhc6liV4XOcgiyP4uPx?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: brLvd8Flc4j0nEz5Od+BUVB5+9nMlsYavvJsD+NP3EDandisoVnO/t5zZ0qcDWQmiPZ3SE4FFkpepsrBjDxB6ixDGtAL9OUkDtMaGdLpE9E5gZy0RnON5KFGj0GBVgWyJ+P8wrih3VumiG1FBCbNLJc/4RNxzmATHmpbglNeJds9RYaxsM5VmcyrCRqi2+kCMC609FksCsU0QdsPg4NdIK86bJE1viVtxaxenB2iiAuZxBavvk+f7EF6jve6a7lapEFZEKEHUvHw6S2sMkIWpONlZGsVM5bnEZcdKnfytYJIG1XVYEKfdY41vOE6DjXhbUaodUKIZJ7NyyxTtHS8cm9Txa6oEnu+Yi/x/2YQU3SuiCprhP7oeqP2DuupI07Bf1wJVNHBu2latIbDRIc7pkFQav1TwxcsBTrNH6DL+mqUHtTN0b3wllhvSc4VOFt9rvjXwKiSa+wRI32reBN+h9Q+rIjqJn/nGyKG4nwBufiO3uO9e7xhVHf8xzd8GZJ7PzhMyzWv8sZhOEMfFTn1Ou7NmLCVoCVnI9XMEHMk67ZU6Xji3LMr82JxGsBLdDJGTP5AUkFCNO4Dk7NMp97tYXI+BvE3j9jN2NXgwYxOXraEGWcYZ+Fn+gN3L1dYwVBfkaCGk6GKKtXhpRxbkufqyNLjMfL7TwKZ/ZJ+w6kMsONWKORk71HI2qV1H78TcHnDxMzNme37CMPBfxcJ1XEsHhJlEe3zNsOIhEVhnOpyBuuXb/4p5azInBmhi9yuHhKsU1N2aN5o4n7LQpkh/9nWvg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ca4a1c-aeab-42b0-e14d-08db5c4eedea
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 12:03:47.3076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R56JIcDEpeayKrKGWT3I20JDA42mrshwFLhlYbks7RvE0h2jxR182+XDVSw2CqbT1MQPF3ozf4TZLeLoyM3AtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5098
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_07,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305240101
X-Proofpoint-GUID: h64W6bbPI2Gnk7oZbZKVMD-ewDk6icP3
X-Proofpoint-ORIG-GUID: h64W6bbPI2Gnk7oZbZKVMD-ewDk6icP3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Refactor the functions find_fsid() and find_fsid_with_metadata_uuid(), as
they currently share a common set of code to compare the fsid and
metadata_uuid. Create a common helper function,
match_fsid_fs_devices().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Rename helper function.

 fs/btrfs/volumes.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f573f93024b0..3d426dbd1199 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -427,6 +427,22 @@ void __exit btrfs_cleanup_fs_uuids(void)
 	}
 }
 
+static bool match_fsid_fs_devices(struct btrfs_fs_devices *fs_devices,
+				   const u8 *fsid, const u8 *metadata_fsid)
+{
+	if (memcmp(fsid, fs_devices->fsid, BTRFS_FSID_SIZE) != 0)
+		return false;
+
+	if (!metadata_fsid)
+		return true;
+
+	if (memcmp(metadata_fsid, fs_devices->metadata_uuid, BTRFS_FSID_SIZE) !=
+		   0)
+		return false;
+
+	return true;
+}
+
 static noinline struct btrfs_fs_devices *find_fsid(
 		const u8 *fsid, const u8 *metadata_fsid)
 {
@@ -436,15 +452,8 @@ static noinline struct btrfs_fs_devices *find_fsid(
 
 	/* Handle non-split brain cases */
 	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
-		if (metadata_fsid) {
-			if (memcmp(fsid, fs_devices->fsid, BTRFS_FSID_SIZE) == 0
-			    && memcmp(metadata_fsid, fs_devices->metadata_uuid,
-				      BTRFS_FSID_SIZE) == 0)
-				return fs_devices;
-		} else {
-			if (memcmp(fsid, fs_devices->fsid, BTRFS_FSID_SIZE) == 0)
-				return fs_devices;
-		}
+		if (match_fsid_fs_devices(fs_devices, fsid, metadata_fsid))
+			return fs_devices;
 	}
 	return NULL;
 }
@@ -462,14 +471,15 @@ static struct btrfs_fs_devices *find_fsid_with_metadata_uuid(
 	 * at all and the CHANGING_FSID_V2 flag set.
 	 */
 	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
-		if (fs_devices->fsid_change &&
-		    memcmp(disk_super->metadata_uuid, fs_devices->fsid,
-			   BTRFS_FSID_SIZE) == 0 &&
-		    memcmp(fs_devices->fsid, fs_devices->metadata_uuid,
-			   BTRFS_FSID_SIZE) == 0) {
+		if (!fs_devices->fsid_change)
+			continue;
+
+		if (match_fsid_fs_devices(fs_devices,
+					   disk_super->metadata_uuid,
+					   fs_devices->fsid))
 			return fs_devices;
-		}
 	}
+
 	/*
 	 * Handle scanned device having completed its fsid change but
 	 * belonging to a fs_devices that was created by a device that
-- 
2.38.1

