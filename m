Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F4D769484
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jul 2023 13:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjGaLRu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 07:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbjGaLRt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 07:17:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8AABF
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 04:17:48 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VAitCS000970
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 11:17:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=UbZIy/MO5Br6DUs7FbAFzoJcjg1EFjWeWaRSWGyMuu0=;
 b=QrFOpP7PQv4h7/8WQdXLRd/l3O09Kky3X0srJtF9Pvt9qXN8bvf8uw/iD/XwhoRo65w1
 sPia+NF0VGJAC2ex1k4GQQWYw3/wL0wcp7G5xgnku7vLrfUN8itF7Wj0MA61q8/Fy448
 sEBp0HOhCg/m8FKBjCtnc/DuKzdqWgkP5jZeAL0aQb8WTUIBfcRNfoowLfjyX98NBYQ2
 HlGWoQnzf66ennYhZkhSV6TcdOiNHQM0K4GQC4DrCL0PCCF6T/9gSoJooGPaMLqKWJyz
 Cga5zeoT4jQa/3zKe5xeVqkKS4nit09iPh3FgD7ZH/wrwrplGSgSfzpxAI9vTBwiYQic ow== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4sc2abp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 11:17:48 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36V9ZvUh008708
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 11:17:46 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7aw273-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 11:17:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4OKNsbfd/oGKOzXv1U/dYw6NEsm4UubmOHLqd5guH9CE4aTt0F86wQ/AsdxDu6+EAQPgPm5bihu3rjAAynAEkYURhebudr/wSsbtQIIKfR1GKIwJUEm18KogPKWu0UDKsOajXn2web0qgWC+uXg6B9DcxNhSebEL8s106OxfbEQ3q9MXyWoWoaGnoVy/eCzFN5WcDX5PtwNg+r+aml/BYUQ1JOhGziDofcK0UeFC2L+FYh/fmCO8DRNYWCbK/GlWydjSV89J60OI4TjAvhRMD/vDSnEEGmGE9FDVJhOqqHWVLdudG/Fd05mQTOBOeghTB5k0QWsS2pa/NWrKirDnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbZIy/MO5Br6DUs7FbAFzoJcjg1EFjWeWaRSWGyMuu0=;
 b=HGuGbSzmeVsg/ZdvepkG0DOIaSPTz8dHkTqVfACoQVkk+dpi5nU1f798fIdolPLVLV/0QJQqUTnp+IXlMPGiYjrTpXOyckmdUSSC6kZG7eb9TgDS20mZD7D5/fYkoUuX7tBtY0jzzMxpEC8+XbGj6u653MecjdHaprcxhINQ83Sz7dY/vR9TVBHMTIdDz3y70cCE49V67uMY7Q0vpCV5lBG2OazNCMYSukuhTA56Z9WFRQn11mr9k8FnfH3p5zpuvHsXb34Ih1oT70nuE3NG8sTc4ENF3JSbUl1vQsdZCTuEhiy4VONDW0WP0wAkMLQU4OSJT3JTfKrotjr6SUzVFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbZIy/MO5Br6DUs7FbAFzoJcjg1EFjWeWaRSWGyMuu0=;
 b=PcnudgYuT4dUF5N4Nt6nQCZQs8pl4M3DfGHnHE4gUCpCRfLbfSGm7m8Z5/Ldx06jA49Lbjca6NwhOP0kxV8sBrB+0ThWQiDkMFQSurV+3yuJDE4sKMXGuQNq2eCA3OB3r99oWbZF85OF2RKYstWA2HrAjC2y8CJ90CKOaxf4NX8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BY5PR10MB4113.namprd10.prod.outlook.com (2603:10b6:a03:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 11:17:45 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 11:17:45 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 2/7] btrfs: simplify memcpy either of metadata_uuid or fsid
Date:   Mon, 31 Jul 2023 19:16:33 +0800
Message-Id: <371de895b777e1805002a0703dbbd4fe5a5bf3f3.1690792823.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <cover.1690792823.git.anand.jain@oracle.com>
References: <cover.1690792823.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:195::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BY5PR10MB4113:EE_
X-MS-Office365-Filtering-Correlation-Id: cc0e3d0f-a343-4157-8061-08db91b7c396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NJnFwntumDT0adq1pcMK6PoGNyoW8NwhOAoD8FM1Agn/DKxaP6/gPTuWvWOYmTX2uSeh2nkhsHfRC7gSlPfzHdjSAKMUlg5De+qaP5fBNsHXCEecIXrJVlo6XdAlr5ybUrxBuufq8ib3ZeFVNPsDA4IGvJhc/lnA/FQ8hBhnt2+F2cr0w9kxI3Y8YRhflJP8yhWK64YUqwOgpgIT5Yk+j+enXQSwEzd6hVupKwmaX6ICeHFU7D+/x65mhne7Wx1o/PZz1mnHqgv9UtXkL4Pk9rqdkiVJ2aAVVAajJ2Tzlk5YE4+e7uq2/vofV8hNoNuF+nVg+X6pzGNUywnio/ocC5htZoz220mAsJ8jsxvjg3Pd7Y8BArh5YaM7NZDUTnpidjlORhGyJqutqPX2GvJH3JcyJGRA5UO9EkVx6F38hLxp70cmcBgbSZWdPjhgo1sty2zPwrR59dbmbjXwaj2dGUcXbDBZorc4shXH4TtMsxtgCxpFkT125IVqZIj0kMp9OAql7Pbnz/RLnEOUXm/WeTftpI68YPJO/gNNnGSDi8uAf2YMsURHVR5C4S19Ou9E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199021)(6512007)(6486002)(36756003)(2616005)(26005)(6506007)(83380400001)(107886003)(186003)(44832011)(66946007)(66556008)(86362001)(66476007)(316002)(4326008)(5660300002)(6916009)(8676002)(8936002)(41300700001)(38100700002)(2906002)(6666004)(478600001)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2MTRHUyJyfJQVi0Q6FqKaBdDf73UsO4xs3mZXki0/2g913mdMnuUxAvhO2iM?=
 =?us-ascii?Q?CaZIViv4dr4z3Hw9tdobOFEC1EMkSIOglkyB0UGInuM6n5Cq5+YnS02112Ic?=
 =?us-ascii?Q?ainXt3wSlqi88v+1PSwc6hvMkKD1P18zLcBDDJOteAb4LUjUj+9j3rntJnVs?=
 =?us-ascii?Q?3FsXrIUeHx98UOK4UkO6DWs9sDhMi27jA+3aNSZi8XHJ/2P7869GOjE9dFCr?=
 =?us-ascii?Q?pv1lMs5dpcC56VHi51l9znKyVTvdI/LpmCZEHTwURe82aiqvv9Z7eec+n63H?=
 =?us-ascii?Q?duq2BcyYfUgjC4d+fGIozo+Ob9vy7Eujd+++Q6UH0VdLSyApwf2v7NFMAcGV?=
 =?us-ascii?Q?m8wlTX/XvebkLBmq4qVrDCxMQieq8h+iug4NH1hl+OpPSwMGNeBP7+fTQ1+h?=
 =?us-ascii?Q?vWH6d4UF0jsS2R5ggh9jPVbfKyITVl6795QqH1pq2YoJDIjhRKS3312ndLe8?=
 =?us-ascii?Q?OrAloqyDsIrfVVD+SXTh7dO/NvBoHecl6HgFdqxRlZq6oiSHiz1CmTr+mV2v?=
 =?us-ascii?Q?VDKcjdG1wwxc1QqCr4tnmzUnJ9bgmLgouJbTcFJ3+c2B1k6XVIYCIea47t1X?=
 =?us-ascii?Q?L9GspYdDlQ4AdT4Dwu2OV1y/7ERBSD5TpjN3m6LkKtK5jQnOuquIdhIGvapj?=
 =?us-ascii?Q?GdU58OpgUm+HQ32bsUKcX+Lk6nIrb5q5gJkLK8K9C2ciZNgBdqAPyexWynKB?=
 =?us-ascii?Q?8SEfyApGhnmRzEOaqMXgRNQOKKFWkxLYZDwkbaOwtN5f4cZtUQJggqQkIEg1?=
 =?us-ascii?Q?3wmXG+5CovpO0ELUYH+1mpV4ekHE8o6fKV+BBF9m2VOcviEYNgm1rq3ULm3b?=
 =?us-ascii?Q?SYSKarrwJdA5yBOtB2T4TZmXB3DqR5UOZuIcr6BLQ3emAiffqQl+bOTujWil?=
 =?us-ascii?Q?q4Qv0+WGXMZexOREHXsP1xm3OkaqLt4h6pTu7lk27ul4lOYqt4UdYF28YPMU?=
 =?us-ascii?Q?DDLWJ8NVBDieEEnMLSsRjn5TsBDKoig6fdC7UbHXDBHBa9N3YKHY/B5JokHv?=
 =?us-ascii?Q?c4CytdIOnTB9abKQgfKUSD+hl6ZDtrk9CGlRAgfLzy/fkPdlAoNrsr2uPt6x?=
 =?us-ascii?Q?qmb3WL8eMUPN3IymT3jXufyRUZQE1nsKml8rV/MKWvLNNYH10V9WoTTSgwfQ?=
 =?us-ascii?Q?MXzVr7J6yFZWdEDPDUJRP3Xhf1ZVIuKhGDwOAcGsANaUDxBwqoCpp9Jyaebm?=
 =?us-ascii?Q?QIQiLL7M4jSrXmfcVGJ4NImjCPc0XYV9B3dLswGDhlFrN5Dem3CoWcEDaiGE?=
 =?us-ascii?Q?kbitGtJsi2SsHEq7t9BENWWT66WiDFQ4OO/wnAkWphuF1tG6ynlwSzxAeMeC?=
 =?us-ascii?Q?3+B8MN1G6bncPJtbjeEpSScqt0gKWoSCVb8KvcJSs6rNDEYML7xaqOEAfegY?=
 =?us-ascii?Q?Gjlp04VNtbXGJKUOlhrqaNmOulEMjlMkGPusupxoCeS+g/zckAFrcJ0h28GE?=
 =?us-ascii?Q?Kq1cFNPkZa0abOhpec4q8Z1yTdIrIGDV9g0XPPRtfjkLVdzNO4TvR62NMEGN?=
 =?us-ascii?Q?//FefG/nqzDFzIMA1Yhf5Zj9IsOZrOZrGkdfZc6pb4MjwiJH2XjVCDEBtgMk?=
 =?us-ascii?Q?sIzxAsW0BDZYVbYUwJ1AOZdim2CHYkb36Dqj1lBM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GlPLCETtx35gjm6AAOlFruiy5rN7YR35Ul2Jn+wiQSY0YHpQdwT7rCVATicCb6PfqtxLhtqv0kyhKckeSVZkqzGaVS67TL11QB7r6waL8RtlT0YXy/J7z5imlzpoYpiFE/09do+q1wU3+SjCAFjVr5AGnRN/P4r7ueG2DdWme/I+JTx5KFjcHd+fBxvULKVE1URWjPjo2E5XHoDphxbquGA0vp7ACkFRbHgO7BPyHpCTJI2j7VQIT7W2Ci3wjE8/c0a0TShUUdOSYof+Go2pdJQNsLEEphWN9cwGLFUzrPW0SDUISPyUOKZOZKwejLm+shzdD9Alq9EdVHHRj9Ff/W3suLhud9V5TA1UDMo8IpxFlVK6i2UMpjDY72o0g0kU9SppSn2HaZtaA8ASMHJzpyCR7bUEmGrqFP//rd5RWfMjk87YvI4DWHb17b8eM2RK2Yu495XBT0gOO7FGQVOBhcFZgjhn//4V/TC0kaey4sm9zR5LI4udB2zzO9TUCjcUhN5gVWRoxPTsV/HiZHonULEmiSIJp2tAnLKl5qqJZCHyBcPY0qA6HfXRgM7i+yWynDdimGAwp6PoufFPbMWMkcD5rm8ZuyKs/HUWPI/p6QM8q+QFfE6pq0iENxB0Imqowmb8zkq5qkaBz8ypyjNnqVYHsdb4RmNXUzs04buaSHttzo9BFKrecLhZHIKzLGCbQ78fOodAgdl1Cw9eDFGyBUotvHfqNxyMqkA2iOt15vKGqJ4nfQ/zIRNN0Imc8Wl7XLRmEWuaC74Tqs7uCJFfrQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc0e3d0f-a343-4157-8061-08db91b7c396
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 11:17:45.0644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y6bmMiYwFKxdXOzBGiZJU4c2FklriBMc2f5LC+BB15cNAv2rw7JgZgbSf4Te4zODkaBrli65jsfDonwK3D+JNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4113
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_04,2023-07-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310101
X-Proofpoint-ORIG-GUID: gTBsaRmhuSQe56lvQKxtdmEXFy-xjvkM
X-Proofpoint-GUID: gTBsaRmhuSQe56lvQKxtdmEXFy-xjvkM
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a helper which provides either metadata_uuid or fsid as per
METADATA_UUID flag. So use it.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2020b1fac764..2f470404ff83 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -841,15 +841,8 @@ static noinline struct btrfs_device *device_list_add(const char *path,
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
-
+			memcpy(fs_devices->metadata_uuid,
+			       btrfs_sb_fsid_ptr(disk_super), BTRFS_FSID_SIZE);
 			fs_devices->fsid_change = false;
 		}
 	}
-- 
2.39.2

