Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9242E7B5F83
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Oct 2023 05:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjJCDqo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Oct 2023 23:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjJCDqn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Oct 2023 23:46:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCA9C6
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Oct 2023 20:46:39 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3930jRRb028533;
        Tue, 3 Oct 2023 03:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=WHAVg0uPbjuyBlNN3MIdrdYrzUdAotOSk+WsRb1goVY=;
 b=qpt6I1jcttlj81eyKTpKFklepjdh5b2crsvGsGPIJ3Gx4qggUFeOXhOX01B0XKEc6o7w
 v7V9CjyPbW9JV045lbY04nCHppDZTeVzvMPkyAuU/LQbZJWfIjtwybHIlATyCIYIUQHi
 n2Yj42EgqLWwTFuBfeSn3frXEjV54hTAS1thpk+jvYM+hyZZpIjiIzYGjd7WijC4T98U
 CBSbSom2Mb5hC0cPU/HIDTET31gyKZTEiiAWQOO8VlXfhJnLJIVX0qJ43msyK7fVFZ8/
 X+qKPApvRifgQJd21dICLBcFzElwRM9fMbytpCv4XUQEjCK0eqsFmYnH/Tqpq8/9zcbG 4A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tec7vbqtv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 03:46:29 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3932nOYB033614;
        Tue, 3 Oct 2023 03:46:28 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea45ke5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 03:46:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfVLuFMz6rh1l3bZ2vEbeI3JVN6b8aZqzyi4KyUcNXjSXkoSDDW6Je5HpDB9sbdTrC3nOnvdgAgbPP9r6l/Rofk5+vDg9T+EqKv6TGghu+kaIqA/I2IkdAGwrsh73OSiRzIhJ+XM/vDEhfyIOvpE90mm7KNr1GyKnouLVswqUTy3voGtlLpgWR3qseoQ7HiP6BL4SCBgnrcpDW4HFe3eRNIGkgz0FfvX3iiNm4FqlciGOoQG2xrroqemlpEqy4l4uWfdiBiTIz04m2LK7ddxJEFaH7tDVRFLIyRRGUQqPRi+ymFtBC4xwa/xJPs9WwO+Y2quYrg/g88Uvzc/Uu/9bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHAVg0uPbjuyBlNN3MIdrdYrzUdAotOSk+WsRb1goVY=;
 b=FEJttRtz4SLfkB7UM2oLIUoDEbpy/em4rnu51pOxywpBCJDz7ZOLZ2j47pJNDgu59Byv+SNYn1frBUPBu/lvdiC8tapqJPDiXjcBXkQgoYEWfNXindzRUfmHyKnplCbw/W/o9CJ5wmTJE4tkxy2c0Gy5aFEuUBYrCk3b/Sw33DcVg78WLu+FIsibXgBvSuQInGx5jQMn9TYC/MZlPIbHopEiw1qnKXceq6lSOyqQrj2xnXJbWaYYgCsyaBhZaMedyiMqqzvn2qXdKDOgVhpN4fEzMolIg/rBTemcLNgOE0d7Jc4CBINXTOCiEeLFRR2f18gWG7NGtu5d7sCQbksdMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHAVg0uPbjuyBlNN3MIdrdYrzUdAotOSk+WsRb1goVY=;
 b=WFJx3ka+Fko+SeUHJyPdOyVy6JskpAGYu6mwsRbDIBQEn8zh/Q+QMXEhb2hheZ0BhTO2Lc7axPvxb32HlXlg3n0s/YZ+soHS8UETfJs12qj3A1Yn7hxNQVyc/a6aYnmGLbo8tMlbL+HLrgWQwzPh1vs6/7abA1+s1zNN60I5CSE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4511.namprd10.prod.outlook.com (2603:10b6:a03:2de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Tue, 3 Oct
 2023 03:46:26 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Tue, 3 Oct 2023
 03:46:26 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, gpiccoli@igalia.com
Subject: [PATCH 1/2] btrfs-progs: document allowing duplicate fsid
Date:   Tue,  3 Oct 2023 11:46:13 +0800
Message-Id: <24bc23323d8e13b609cb854c1965c842852610a5.1696304039.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1696304038.git.anand.jain@oracle.com>
References: <cover.1696304038.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4511:EE_
X-MS-Office365-Filtering-Correlation-Id: c446df65-8295-4f29-3f10-08dbc3c35204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WnziDooYQbLJ1IksLIvVhrGlwnISRYRP46vWZ7x1QF8tAzfj483Vu3bmx+tRE/Ik3MTV8pGR7Euchl1k09lxDhShlBUkw/05IHBQvvBpm827Mc90j4ITKEoKNmTh4w0N3BPqDXT+sToButKXDsYB/8Uy5CoKJbgF9xa/VVTOZce4s0elTBq3OeRZuszcmJgmSUjUd5NK1Tqlz1JaahWkv8ToqQmVvryAuzEwRxI3ILwzMDgCtLyrpZ1R1NPm24uE7YRDAUHWXuMudavxpuDfzZGH47Wll0fecMSnks2tTgHygNbYnO7i+vNCzdW37iNuLNc3S1joGBfMPwQbAx+m0EeZLem96Lc970Qac0hHOj0aLzeHp7tXXkal/nb139SYSh0H0ulMVLycpDckOXm1/S5/Mj6GRxvxh5fpyM3YFO7tNmxoos9zILS4M6FzZxhFlZffJn/61ZfwStRlbNvpHPTe5IPlppSIPfmWnr/2yYJdV1B2heRkAxqRYyb22/4hLOMw4ziihngyBs3kp5SeHOmjB6s3d9a/8q9t2BP/MCV+vYYiXI/F/0zgwk2TtOuK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(366004)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(8936002)(41300700001)(6916009)(2616005)(86362001)(38100700002)(6512007)(66556008)(6666004)(26005)(83380400001)(6486002)(6506007)(478600001)(66476007)(5660300002)(8676002)(36756003)(316002)(2906002)(4326008)(44832011)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5ZU+LTdIQHHc+eUTfD+Xa689UOUiNDUigtKyrsUrht36LK9P+Jne2EEzPqTJ?=
 =?us-ascii?Q?au/b0MstVyPILALLGzIA/8v3Kt7oJIG2opMf7iV1eMu3v/gtowjtyL7Q80QN?=
 =?us-ascii?Q?OvJeZzqZ6AIfDl7EqPi4IFOMeajBXbT3SnoblFUtxXWk26fGOypF77Wd1NZ5?=
 =?us-ascii?Q?gcEBW3h4gFSMpyyYmvoTX9UYUNWLuHGhOnGRjDmxTCl8p5mu4CtAuJRat3Qg?=
 =?us-ascii?Q?hr6T6H7NOhgjftwMYJMhUeDVS4I8ZWR2rpPA+U8HzQ2q2SLHe1Mf1EmJzbA9?=
 =?us-ascii?Q?1KoGESK6yqMQic+KmFesuymvfnAdG5Ll3IHzvzrtkpyn83w5f0ZvQUH/Spnp?=
 =?us-ascii?Q?nQFkS/vnj35ibtuheA5x8r1Bt005TgWCZOhUE44p/0VS29ZSGNhqZzZnLWk8?=
 =?us-ascii?Q?ZkgvzxhPrwOd6zfOzENBz1/AtURr0CiO+VjIXlKbwLurVtzTu7ORxlG8bZdj?=
 =?us-ascii?Q?J3WgO0gTpA/+dn5y+5FAHdnucOGGKajZHCJa9SZQE6GfTtRoGDrKQf/ODMSY?=
 =?us-ascii?Q?I3QS5L9b7EKz8iO+3QZdPGJZckJKeZ+nS9LQ5fKd6WCx5SljezLxK7KZYZK2?=
 =?us-ascii?Q?twiZUK3RGQNXSwR6/RkZOD50k5XOTjt3XNiuzP9nxPvht/yrZi7ajLvyCD1a?=
 =?us-ascii?Q?EWM/exTXkeCCDl6NRPffwN+x43Xifc14A0SrbAxKzS0aqREzKFigFWRR1L50?=
 =?us-ascii?Q?UW/gerMdRXpQ0hm4dyiHxJRuF8SouBhJ22PtN6GJRHvYgYUA9aJ0+oB9FvGr?=
 =?us-ascii?Q?1x1XXhEugJuPOBFgYDuJV7NnlzeVwfySTPZXh2khq6lSetdyJQNDFsdl3LTy?=
 =?us-ascii?Q?sQtJD5ZcuPtAAPfcZIMGtRrewdYqt3SWx4SYYP9X9chxqLf+4oMP5oryDgDn?=
 =?us-ascii?Q?Li5QgFB+r4B+q5ihLmq7KvbDXUtH/qGHizF1g1Lf5XMZRD2TzwlW8fo/6LvV?=
 =?us-ascii?Q?7JExja2YuXZsCXdA49OFisN+o/EyjHIyrrgJXrVpBIRL7Xb61lAH3FVtF7hn?=
 =?us-ascii?Q?lRQM5VkTXj/GmEb2OBPNqufLoXfoiqmWZP6YeO0uZspl9erD3HWUK7HgLOsl?=
 =?us-ascii?Q?JYKce884C8Qj2vygdfb/p7rqT/OzqkIQD2AmVWsg77pVc1WW03lPUMRIp/vy?=
 =?us-ascii?Q?+wV9ps9V/ocn2E0pIstCdHgb2Tjuet3XdjSsnsFkBCjQV4hkKjJdxUR/PMWz?=
 =?us-ascii?Q?A5eQc4lw3YU+Kastrnn3YXTYB1mg3VTlW7kjyithnuE221zRteygYXqetKC6?=
 =?us-ascii?Q?9MwGczbUHv6+2gyA0n5M6xoEwxFgtDp6YybbrSikUu74WrLYGmxP+wHORM2n?=
 =?us-ascii?Q?591QQIQQGka40kW37w0fRBJZe7Npy/J6dreB+OTekKD3TdG8wRqUkEexyGYw?=
 =?us-ascii?Q?Dcfq7bg6CHBMkf48dwSzRfpNFXP3lluyM2JhK5ZoRuc2dXURpXCEgVKjSjxY?=
 =?us-ascii?Q?OjHMJKOWsDwIivsw8mCjV83gtX5kZFW7MYbuVF5uQDHNG7TbiA4XNscIDm8C?=
 =?us-ascii?Q?kgc7PLvtxlnVd9T3KbBmW8EDT0mSn+MTe9Nk4+YW17ESFQJ9fshtPBp8DpRc?=
 =?us-ascii?Q?EoE3TkhOpobAFAdhrMGqbqg2YsUJRCthwetmcojXBigPFmdEahadmCbdoai4?=
 =?us-ascii?Q?pQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gmnXEbDo/b7enr+w/DyY0b4+iJwC9IaqvIPwD31Bg2fiUM4MqpPtno+pe1q7vT4EAN7/YuMcBv4uqbn79PqM22dlG23Yd2FdaNmrB82kySPn/k+247iAaIRBY/qhxYeDVI3/Qi8HNHTh7/mjefzorq+FgcQYowOymLTDyZ2QrekrVRVsZkvN76oMCvp0UIRQsTMAxQYoc+kp7qEvTFF7hj2j6/71JvWndkRyyrSbwSPdMi8RhgOoApDq45Jm1qqc66aSYDd3Fu6aff8yn4O0os6olhsuhVXPCxHN24yVLfm5+OWutfE/FFy6+e5ivRNafU9D0LgL7cw5dilS/eU/usCEEbe1715MiyU4o+IGnMa1xLOc6MdBrtEQtH7uWZMfL9fKv/ZkCLxUt5T3aqnaV2bAwlT7fnoda5OVFSgN7ty66A2sOGdzmiJXaC+qKlBEE1SpY4xPM8V/knVPqCgJyWwlJ+v0Kad5XZ8JpUVje6m3zV9lEBw6F+ngV4Wsh2/7q5ahAVK14oZvLBlFaWfRiQYZ5YI2wi/xt/kDb7Sqja2WOB/6D1WDBDKONUGYTu5RXq/OwScqH99dHvvDe5rVUjUAwC4qqsQwrHH7uA6hRCVozk8TdhkUjmz1Imw8eZfZYMmFF9QWfVzOTV9xCK6hwBfKg/nBxkETwUbGqlJjZad8aA0L4bMyN/x3dGlDQyXBisUgYvQPa+W6eL669mHPnLV5fuwZgCGp9GJoVqgQLlsI4MgJ6Ygs7EGMBA1sMRzkdwwegzWgusbDXr5Xlh8lbXBa6rEmxAkmlAP0JureBKrrLEtYzuqkaRByn1RXH/Cx
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c446df65-8295-4f29-3f10-08dbc3c35204
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 03:46:26.8018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDXI+piab91EPjC6yBS6TGeb2G4Dq01sYd+qf3LP4PMVctdR/lwuilv1FAdXExqjNj8SXCt+P0QgKx8c86L/fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4511
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_16,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030029
X-Proofpoint-ORIG-GUID: I128FV3mWMyj4Cimq1dhPs-tXcv_dIAW
X-Proofpoint-GUID: I128FV3mWMyj4Cimq1dhPs-tXcv_dIAW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The commit ("btrfs-progs: allow duplicate fsid for single device
filesystems") lets the duplicate fsid used for a new mkfs document this.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---

David,
 This patch can be folded into patch:
   ff4c4a3a00db btrfs-progs: allow duplicate fsid for single device filesystems
 in your devel.

 Documentation/mkfs.btrfs.rst | 5 +++--
 mkfs/main.c                  | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/mkfs.btrfs.rst b/Documentation/mkfs.btrfs.rst
index 2ff3ed241533..95ddc5399090 100644
--- a/Documentation/mkfs.btrfs.rst
+++ b/Documentation/mkfs.btrfs.rst
@@ -179,8 +179,9 @@ OPTIONS
         Resets any previous effects of *--verbose*.
 
 -U|--uuid <UUID>
-        Create the filesystem with the given *UUID*. The UUID must not exist on any
-        filesystem currently present.
+        Create the filesystem with the given *UUID*. For a single-device filesystem,
+        you can duplicate the UUID; however, for a multi-device filesystem, the UUID
+        must not already exist on any currently present filesystem.
 
 -v|--verbose
         Increase verbosity level, default is 1.
diff --git a/mkfs/main.c b/mkfs/main.c
index ead1edded9bf..ccab3c31b2f5 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -430,7 +430,7 @@ static const char * const mkfs_usage[] = {
 	OPTLINE("-s|--sectorsize SIZE", "data block size (may not be mountable by current kernel)"),
 	OPTLINE("-O|--features LIST", "comma separated list of filesystem features (use '-O list-all' to list features)"),
 	OPTLINE("-L|--label LABEL", "set the filesystem label"),
-	OPTLINE("-U|--uuid UUID", "specify the filesystem UUID (must be unique)"),
+	OPTLINE("-U|--uuid UUID", "Specify the filesystem UUID (must be unique for a filesystem with multiple devices)"),
 	"Creation:",
 	OPTLINE("-b|--byte-count SIZE", "set size of each device to SIZE (filesystem size is sum of all device sizes)"),
 	OPTLINE("-r|--rootdir DIR", "copy files from DIR to the image root directory"),
-- 
2.39.3

