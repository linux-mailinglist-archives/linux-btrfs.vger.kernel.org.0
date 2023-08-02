Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD83476DB92
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Aug 2023 01:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjHBXa4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Aug 2023 19:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjHBXay (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Aug 2023 19:30:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098E726B0
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 16:30:53 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372MjE0V032491
        for <linux-btrfs@vger.kernel.org>; Wed, 2 Aug 2023 23:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=zBdLO3bcnk0HYARqSZTJ3hAvhLZoVnW4hTbN+MEOXfU=;
 b=1MlrPpr4FCBR4nUfCFTY5MB/Gw//ZBlD5EVf+Jxptl51cte0kPvaShWREqgWEUt7kSnr
 wYByg9gRVapf5l1FLAaJegrU5dEnIyP6kHNscTNolvvqGa/XBYhMIhxaXFEEk3ulLi2k
 76NfL9y4mOwyKpauqsruxgRKbymlygdQ+HtWzv6OApfWN71AIVIVHQLDHD/YdktepvaA
 in4dCFKOhtSaX95dUc7DbuBJWHT9q9SG8l68AdDRKwxz4w2lEFmP52ajIt8vMv1/xrLa
 rhtPaxkq1fk38neYFffpPVhFlwxko1gII9yw3T5lcK1ZjdmW4n9qrB1sl7t7Ly4nvF4P Kw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4ttd8h53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Aug 2023 23:30:53 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 372N2WS0020505
        for <linux-btrfs@vger.kernel.org>; Wed, 2 Aug 2023 23:30:52 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s78tvmm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Aug 2023 23:30:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITyZyp2g/ywIJ54LhYA0VE/V0ssGWLUVtyKL3fD/m9PdQyy8o4zqTvljadM+UAgZxmAwM76bgbx/kZ9sgZH/iPu3V2UP00cFSxVkjdGQa2IbLnASzhmimkexC3+cEhykz8WmJ+4/RHqQMbZWpCbwDKtbN5bZPaqXOduLOD9yHNAK+xS9dLREIcj4IzRkefmBTm8BS90k6Q+tUUYy8mVxL72v0dgSn1ZDlNxsd66qA7WEY1fEy+SiFnyuF8QrE6zcM5oaz2uXqvx5jUO6CxlyyF1dkgOPdXhnBhbCtwJ5shR94OM5cP7DKIGSPrYSJUIkme/raZsUJgTd0ztO/6CpTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBdLO3bcnk0HYARqSZTJ3hAvhLZoVnW4hTbN+MEOXfU=;
 b=L19DtNekO7YBtkgFj/dZXUSx8i0fu7Q9sNjxOXQFaUjdiGztmXXyfzXuhM0OMjrMODS3VIxhtyLE8qWrAn0a1hhdRQmXA7RQJyWKUT5/pX5qxoJFQ88hcYDeO+tS3Kbmg+9AlW7vh6QoDy2bPGu64iIJ+nVuHcUhdmAgnZLyNeFgp0El1WC/NQB+EcbPySwfqauPTVxQNRbnJcwjLfNHTXbYYXezk7kQtAIXznRWw4hmNwNPk9U9jnW1LznJ/mU5gKarJP5eDp7f4cX4up7HsVTXLxPZE2CAcRDpXLaAe+zC/sP2f6iy9GE+RZ0/s8rf8SJy0zhioZw3LFvIuJoX/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBdLO3bcnk0HYARqSZTJ3hAvhLZoVnW4hTbN+MEOXfU=;
 b=yLQ3GXaoX6mT/MLcqthaMjvPDIEFz152f8quVDrWMQ4EhVb1LFIzzLwM96XU3d+4G7DRZSleCvHr4NNdCq/7R4GGEOXy9/zEoxHnkCPNyx5Zy3+TRN8vetSOCrzK8yoYHT9Rk3zpk8F1B44jO3KqALnp6FyP5sdL1DPvRx5LSSs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6383.namprd10.prod.outlook.com (2603:10b6:806:26d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Wed, 2 Aug
 2023 23:30:50 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6631.046; Wed, 2 Aug 2023
 23:30:50 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 08/10] btrfs-progs: track total_devs in fs devices
Date:   Thu,  3 Aug 2023 07:29:44 +0800
Message-Id: <b61446563f85b3ba7666ca85f8e9b5ac6f6c70f7.1690985783.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1690985783.git.anand.jain@oracle.com>
References: <cover.1690985783.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: a167db3f-24b2-47dd-df90-08db93b08172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MaGXCxLUj0c23A5Nee+p38M/Gp2mB+GstZa0YpiZw/AgnKU3SyGcYbRigeVfXzoenqbvkX009OnHCYHJ1u5ENbf/h38MISudYgsHUlDeNUX4nZKat0BvE46ujJ+HW8UhxTQtC0HjBFdyEg3Uj+hfqhAK+A3O/EKL4gDhK0e51p05Nptl8jCPLhRWGkEeuQrOXe8Q6r8X/wjX+ON5VsEOUSlAEoMkDNY8QkfW1lwhKDAifNpOJCqTJ4qqWt52eaN7GslJE/CRXqJOERFFt8hhspzBGCFU8sqxlsTwQQFrYc2s7a7nEIaCH8NZQAfHTc2wPGHAsluUjuMIR2DJ9Uhzo6OYofDXKWyR0IXgWEirdJyUdtJxPhAn4EtXPgraSGiTw0froVNn8T982paoGRUXzQknsO/MDA2Cvo+JvxzYC+fK8Hp5xK0O2SXwS5rxwpnpzSQhV1zfE9qZTIxbc/04t2Me+FDXwWcyhgrAXV24VSVNN8kQoYuUQLsOyaiOoP3ZCBvfgjcE8HfAlsq4fixKKTDuiWyJyAGweyJqhFrpp8eclCjDEZ43hV8sfogQr4cm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199021)(2616005)(6506007)(26005)(186003)(83380400001)(316002)(2906002)(66946007)(6916009)(66476007)(66556008)(5660300002)(44832011)(41300700001)(8676002)(8936002)(6666004)(6486002)(6512007)(478600001)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TcOilQoSTnBPuICWrlI43Wr79vbnWapsAtZhbzt2eTaRlbY2L31bEVvDmZvH?=
 =?us-ascii?Q?6Ye+rilN2iR1tpF1mgAnYi6An5sn1Ub+XGuAHecr1vMtcTo99BHjvxOlGeB8?=
 =?us-ascii?Q?KLjQ768RFHCoX5BUHB+z6tp+UyFVjhIahE+MvLzbLfE+gIqmw8QPCQuuHeQD?=
 =?us-ascii?Q?7RWv8suoF0tgNTv410Sp3Hu6ZReQ2t38H3Dq00c8ENtBRHeq+14VHkvMXZuT?=
 =?us-ascii?Q?V39D8G0FGqj97V3HINjeNnBBySOBUahqpz6GdR/SWisOvMWPNKrJZmv96SUK?=
 =?us-ascii?Q?Jxq9C5mZq898mrIR4pOlSiClrOmrJJ5SMdsCKApPcGWheBOWXU4k7gl37SuL?=
 =?us-ascii?Q?q7BFXEoGKKF1EEJn50KaGxgMS8X648Ao6OFG/LEOdNRI0gWvSf+YfUXM/uGe?=
 =?us-ascii?Q?SgdYi7X4qicXK4NTwdoXy9V1xggsuDkvNN7psaSOx1OFLPm4gXIQDhSPCuMD?=
 =?us-ascii?Q?dYLBUls1v6m9URWELWejmnf8pcFmhu6YtsqjpaC1gKITqetxtc9iKiWuTEAV?=
 =?us-ascii?Q?WCp3Gl7R3U11SbOVE6D3yOUbS6jEi/oDaRUbvH2X1Gb1ySX+w1FDCmc5xEWl?=
 =?us-ascii?Q?G1v6nK9nZr01UVnZE5eSqr7TcxAvi0tidtBdJsb+IaGpyTwt5bD0oYaR6b42?=
 =?us-ascii?Q?MmzoFNqO2vG0nZvfANQ2Cgb2xb4+5m/VAd77MCfkf0wA67EizcvqulYOY/aj?=
 =?us-ascii?Q?vlecdPhokPF6SAKugvUZezbRUfrFgSbpFxwTTIYIQMuv+g9+/XiC358nRIVM?=
 =?us-ascii?Q?Ft3GuYnNG8tyqSZTEqPeKA1KpQtVyhngN/Sj3RrnWI7tpwqU2jAo0Fi6pQVO?=
 =?us-ascii?Q?Ntq1HyWEX6XleMZcAIf5U7K8s6aNU/Eu8cxNl9GM04VKtLC+HE25S/PaDLqW?=
 =?us-ascii?Q?xNa3TAGfNsdS1l/ewNd3wQvtrAqKbgfBRy9Zc/iwVszwA7bwXmg8VfNaFg6a?=
 =?us-ascii?Q?k1IGh+pQB9rlccdUyftc0L6MizfUYnjdANFAzE7RFFDLSD3pGWx8oH0BbVuj?=
 =?us-ascii?Q?QrRORRq377ROyZ3pXHFSBa9tNuhIJdW3rMhsAdXdR9N4CkH3zLflF3RJ2WYh?=
 =?us-ascii?Q?wCa3n3v6M9vR2YkE80n4H17tBUK04U5LnqRcYmgcJCBXfpS3enRK35lNW7ec?=
 =?us-ascii?Q?gl/r+x8QrQkLx5Z553xd4H81OJ7WJnxNev3Ttr+Rm76YqFJJpH8cXs57s/hX?=
 =?us-ascii?Q?CC+sKLEQ//zWg2veVhjAA4IAnFfRXvVerH5fcW1HcI7eM3NzbNkUaE3YGby9?=
 =?us-ascii?Q?1h09gkMHglfstVDzZDjxryRBl+kwG++VxOJdEPGg6/QRzyJuo25rFWjqGpA0?=
 =?us-ascii?Q?NiUBOQ+JkSAiWyIIFIixI4n7XWMHPErFwNQcPAEUYM4rzg1MrmKTwBMIo5HZ?=
 =?us-ascii?Q?b9VpiOsaVtxry/3z24wmh/mAscFBrRu30UXrau+0OTLJ9vcudjYVZUNhBfhH?=
 =?us-ascii?Q?Y1e41vzuVHxa6Lo4Csn4FRw8yxxYkUL5NXMJPUWGR20sxt/nW0/+8Cq+lfT0?=
 =?us-ascii?Q?g0qADlyNCi+gymF3qjbrI3pFtAUxVRVczoDhho6nBToXHChetbzT9dEQwLBg?=
 =?us-ascii?Q?u4iRwH9nWZFhKFwMgR2do7eIJJ3LWXTl5ZpTHl92?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xUQeFnYpqv9sdcOiPNyz6E2Q6EeGWDwjzGy/WXESZkzqsEE8/sMDePxGg1fscElnpKx8f/bCJ3cL5ds/JlSL0K++t+xI3uSc8S4ia3jOVu8gtwInXDhw3lwbCEsV0QaLaiVOSwKFQE3QFCq+BIxVm3LW+nuoU4gMIP2+/z4tzXl4kU9hapVD62kT+14x52TIoOEERznVLAp/liuTg+3DgSg1YsmPVD+VYIX96Crj4S2QD9AkIrM0PE62vH0Sbx2gblIaFYwXikh0qGrmjdBQnqCuumLqn+lrWmb8GLNomxaJjeWG0C497SnG2wAXJWcN4QCJJAfYpneFGgAhpzSKMjvATpirSegYubgUpc9zSZAy3hKf6XwRdLEfx0+jZcWM5vi5UcSr5us42k0WqCSteCkWUXTXTi1OdYQbVqZh8kAX321G0yDYPdiMlqqexwElASYiJWMSiWbBC0cEKxAmcT2xFfpNdJcgfL6Qm+M6+U4pfDGdGFwhq5Wv+Ul8/LBTHS/6uyN2S8cDXruY5JCu20ict0TMsbeWHdWWqX3m1dkvbIFByPxSvj7Bj6EiXGS1y+jvjw3Y5DXdyKWHKGodQu7pJ4jDuLzq6RTDO+b18sCtokALqZuI8Kd0KjB4SLGIxdbxNirQmafSK8tS6kMw/dlUygYSttyj2UEClzLXgy7H0ElTjy5ELOtw4KH53pekYP+kF4UQ046qALkfTUD4KXKZQ3E/8dDT9Wmrtw2wcGAfbqLUpDPMoKN8/FNOTeFQHGIIcvKAnGIS3c6808Ve5A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a167db3f-24b2-47dd-df90-08db93b08172
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 23:30:49.9493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fcw7Hi1Voib8RIFjXYdX7ODjrj4IMZZa+jTVSP/49ZcryahN8v38wNjBO5/hhGLMmkDWtIxvmeUatQ+O8Lh8Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6383
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_18,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020208
X-Proofpoint-GUID: R8aZ3EAyV07RCiTnYVFO94G9GSV1sHdj
X-Proofpoint-ORIG-GUID: R8aZ3EAyV07RCiTnYVFO94G9GSV1sHdj
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Similar to the kernel, introduce the btrfs_fs_devices::total_devs
attribute to know the overall count of devices that are expected
to be present per filesystem.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Maintains parity with the kernel.

 kernel-shared/volumes.c | 4 +++-
 kernel-shared/volumes.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 88d6c51e3e7e..1954bc230462 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -367,7 +367,8 @@ static int device_list_add(const char *path,
 			       BTRFS_FSID_SIZE);
 
 		fs_devices->latest_devid = devid;
-		fs_devices->latest_trans = found_transid;
+		/* Below we would set this to found_transid */
+		fs_devices->latest_trans = 0;
 		fs_devices->lowest_devid = (u64)-1;
 		fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_REGULAR;
 		device = NULL;
@@ -438,6 +439,7 @@ static int device_list_add(const char *path,
 	if (found_transid > fs_devices->latest_trans) {
 		fs_devices->latest_devid = devid;
 		fs_devices->latest_trans = found_transid;
+		fs_devices->total_devices = device->total_devs;
 	}
 	if (fs_devices->lowest_devid > devid) {
 		fs_devices->lowest_devid = devid;
diff --git a/kernel-shared/volumes.h b/kernel-shared/volumes.h
index fe8802a9fb38..088cb62c3c32 100644
--- a/kernel-shared/volumes.h
+++ b/kernel-shared/volumes.h
@@ -92,6 +92,7 @@ struct btrfs_fs_devices {
 	u64 missing_devices;
 	u64 total_rw_bytes;
 
+	u64 total_devices;
 	int latest_bdev;
 	int lowest_bdev;
 	struct list_head devices;
-- 
2.38.1

