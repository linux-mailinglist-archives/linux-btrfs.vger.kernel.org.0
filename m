Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B1E7A1B9D
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 12:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbjIOKBO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 06:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbjIOKBI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 06:01:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CAE44B7
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Sep 2023 02:59:45 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38EKxkpb000826;
        Fri, 15 Sep 2023 08:17:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=V5Ep5VORwqQOycfp+827G9j+WsafUKXSEHsxkhWInZ8=;
 b=2gu2DbdexMEI+iTk9zGfazM45Odba77nTAJFcjWHr30o6E1Q+cktzW+wh+wpDkoOndmd
 meryM+iJdIC68mmxgNBucNdkOUlS4m1joXGgB4AAlCXJRuBR9bLVn5Vy1iekmeTd66NK
 l75o5HPpgtHn4M4rSntgji9DRGMXjCRdsvnbpgVS8C0iarEtj/Y4+GPiznGWDzqVFMQr
 3SYH1HqT1n9Jr3WY0aCocpG8dPMwqk6P+Qpq9K0czZBB2qBrzhH/aADpdf1PVTKC3jBL
 l5ylHMYNx96K/jp1foeB67/3229BXDE8kctRU3iTijo2WhFvVhbegjHyGPnxaK9V9O9r PQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t37jr6gh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 08:17:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38F8GEkp036198;
        Fri, 15 Sep 2023 08:17:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5g29sq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 08:17:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GihxBpSmXtTaPENsREeT0kbXnub7/mEwuH9l0C8DmuLSG/GD4ZnmZZB1oS4mZY3Kv1uKWRMLCmZ9uqNNlEnDUCocSEcGxm6iy0CUdpvUI8v98jw0JyZOWsysGh/qx/U/2AcNO0Oepyxclsc7HVckU1mWnI8/QkMyMBw70XFySfHHfSAd0RHTmQiGO2zCGDR2GwsTRmaMBPg6E+DE+s5tZZwsRzKPUlgle2xFE/h70Lf2pqbD0j/hrcqS9cbmRB8zlSNsczTsvIvWV9H3DVkhsUCPlZbVdx+ajlzhJPXIuZfLa1vln6GmwZR0EtQPzkDEOXW0ejoiV9FhZKk4vaplBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5Ep5VORwqQOycfp+827G9j+WsafUKXSEHsxkhWInZ8=;
 b=jYXMG1YaYOhcwdZrLO1ajp56WYTosFgM9+yy6PpjjeDBC0lmtnIzmEAmfK3x/Oi1ruZkK40+wRaHodv4PMD6AV6rwrswMpU3FzW7VK0O5lhNQaXevfD/WnjfcM9FObevxfNDSEsUsT1MmKDM0i5OrHZUOIwYa4KICLIbfOg1Mgda/5+kYau9HFObp2wd2WeHK4RO+8p+cWnl8pSaTLGOm0KJy1GwSuYz+5wwU+vKLP5EUtkU7E8uxe0N2eSAHVWhx2WR3i5mvgAdpAgfWycnlOaDuX6DUTFcRgVa+fv0MIaQLJdRmXsrB0Rerid14tRm7Q0BsPn8dL4ho1WHjeVoWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5Ep5VORwqQOycfp+827G9j+WsafUKXSEHsxkhWInZ8=;
 b=ZaOEezSM6oV09k+hJQG6Fulzwv0GOMAilVpifmr81WmZviWid20wUkx8UErlf2ef1mYxFYNMqT/nWQuahsvTUqJoOX9S4YHLPV5Q0L9ZGP8UVxjMmhifDp+0WJLdE5/xov8I3jPzi3/7lh+jC1o0Yqlm92kiFq/OsWi1ex58wG8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO1PR10MB4577.namprd10.prod.outlook.com (2603:10b6:303:97::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Fri, 15 Sep
 2023 08:17:31 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 08:17:31 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] btrfs: fix smatch static checker warning in btrfs_scan_one_device
Date:   Fri, 15 Sep 2023 16:17:21 +0800
Message-Id: <81fd5fbda9772cde786d60b3cecf7d60d5a378f0.1694765532.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO1PR10MB4577:EE_
X-MS-Office365-Filtering-Correlation-Id: a9d3ab18-a7ea-4d1b-1ca5-08dbb5c4352e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5+YmgqQ5E6eCdW2nxOGCTLvGr6KHLhw1Y3zxd85AmV22iS6Bzg/dZqVntAYfaDI4LW5sOOBp6vIZJ2FI6YC1ZVgk2I9hJurtcteNuQiQwkVFOBsafrKwPHShzK+ecIzo+lSe2ybAWyKExLsHGgrxlcWyCqoRcQOsfpECYtT8GT6zRX6JwJ38m26raCI6IqUky2t3eYNC1uK25imcjEHBK0lRv4M5op4GAwSXdjlujGwsJFdsJkeM9UVA5vO5R1RODE9Tx4DGIriEbuQh3JUBTrEVK243h90vRP8EvhhnQ1F4P2hGgkxVAchGS9zYT16kXRARUVHCIOJegG90ovAa3/K1tNNv7598WspjeoetKjm3t6iN6CTEFrT91XRAueTU5B84mIv5kR/9omEZnijt0sYyeBVyrlWQUQGb1sAje2n8Jg9Xk7rUfPUDHc2rTFSL0qE0X9NAf9FdVdKRRaCgcK3R2xfBxIUMhOymlsgtqzM4G14FyQvqV2n5NpOGCEerQpCa4GUe7lOBsCP2rmw1+5y9VYz4BYlLnuMB3+ljCpY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(1800799009)(451199024)(186009)(38100700002)(2906002)(66476007)(54906003)(316002)(4326008)(6512007)(66556008)(36756003)(8936002)(41300700001)(8676002)(44832011)(5660300002)(6666004)(966005)(6486002)(6916009)(6506007)(66946007)(2616005)(86362001)(26005)(478600001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GUPUMAEgj7r3blgew4xcnzYEbDVGk9qUZUD4aJcpsnMoc0Zp44428BO0uil/?=
 =?us-ascii?Q?ckuxB961iPVfKwy6Vdu2mqfuWrU4c6Nm8rjNrrKP0VIPJc5LIMHYGpvvrtNU?=
 =?us-ascii?Q?EfhqX3rajaKJp6/CIqyzA20v/5sktynyJ/jyijCSzlpHSEqb3EIJwoOIdDu1?=
 =?us-ascii?Q?bGvXTD9ETzb7oQL6LDofVdO3xgXvFuSKNLr3R/cHxVA5lm0uSroKkdGagkdS?=
 =?us-ascii?Q?8TOo86FgGQWAO9xHfrnKRzLoa4fP5WJ4OQ4oL2mxbcoe3DnoDq1ZHNkqJohN?=
 =?us-ascii?Q?Nk8j4IiTxVinf6l3XbN970J6rncKkEh8r5AON94Zola5wDxBi3rNNqIpvvFh?=
 =?us-ascii?Q?Ot45pV4Y8I+jHa7LalhRePfNDnaPeRVBa/hxRCzvb8d5hZG//6Ii2VoC9cS+?=
 =?us-ascii?Q?pcaWiKZOUCOFynmjMJvhhzidpB45Ln4XtqdQJwn546cZCLfyUY+ID6Hfmxi8?=
 =?us-ascii?Q?s9L4vRQz/yza0xW19Dd8Gglmn1Olp2DH7xgluYQ5K86GpLBaTBWk10kdekZb?=
 =?us-ascii?Q?DONuUuVVcguQT1OxQ2J5h61YoyjBu8lYhpszJ8iFbWYI3UUhhJ4U/l1RDkf+?=
 =?us-ascii?Q?MyYnenbkgCODD69CXgeRARFZ/CjFXVWjPRMO0F6P/CcdsLjHBGAAl+/fCugh?=
 =?us-ascii?Q?fXK/MdtZRwBcTbE2rONdf3Sxte9BrD/Xtnm2D/DGg1g+9EAsiUDsnFSs9Dl6?=
 =?us-ascii?Q?NyiGp0h1BpUeMkuKAX8LyVwc1+ggoTva5HrQchG5iyuyppTjc7irVI1SmUxi?=
 =?us-ascii?Q?tjZAXlzWJd7ZDzTSGqHgem7G43rvdXsWfqUT/Gdz5I1qTnKKorx7qjZ8Ig7u?=
 =?us-ascii?Q?z1GKX/sFBKQuu0DYhFFy0m/p4zLnGYwtv6onHJw+pg7nlOqZdfmTSeOM4KF1?=
 =?us-ascii?Q?fdYF/aqPot04cA08OxQbmy6ovMEmHDz9K+gdUmsFztcNOTVDzisFd20az7De?=
 =?us-ascii?Q?9UYD6JavpOWHHQdOthTa55/4S1JytlIAK33J+VtEl4unlqPwgR+ywKJz5Bku?=
 =?us-ascii?Q?DxODuGfYABSeDKBM5Fp9s2kNovIig1db7NzKSUipi270UuxaXqvJDggwSRLA?=
 =?us-ascii?Q?Ibn8dmQX/VoU0avhA9WLQsFjEybn5JWhx0dKd5TGH4kSs22ajWC2rhohKVsf?=
 =?us-ascii?Q?dgGFMIKIdIgVU6EFAK+8BgfimwNxRMOwYwcmWSc6HNU5mwKiw+POHZIfdejB?=
 =?us-ascii?Q?E1wksmjH6RwQiYqttyqI13esice8efMfQqwgCPD1L3MNxVL+L7embP2RiKcy?=
 =?us-ascii?Q?rshVoCT1BpKem8zB8jNViBgaqw670EXchNVqcTHarPN8bSk7GofjtxwpL3kP?=
 =?us-ascii?Q?h3EY3I0yUtdqDGeabd2Vg6kQaW68U3GRgcrnqAiaUjW+QM8gRwp3JcsyFGPP?=
 =?us-ascii?Q?73BBkz5b/042Rnwv0A1mgSQrBz8Z4JzGjExnQ/XTPNa88p1/nknbgGinAnsT?=
 =?us-ascii?Q?+rijxT86N8Jx1U9YSl0LqfX36zGcl3Z+6/yx+q36QF9rpqxtKSO3E6VgSAFq?=
 =?us-ascii?Q?GJeWjrQrNmdIdTaZ/zb97EFi4Jj5u9lPpOvescuXjX6F4qJKgW3D4Z2s+oDH?=
 =?us-ascii?Q?IFLZ29VfJ0lCZ0uzz8k5O8f6swUWaZW/gGOXGUAl?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: k6kJuDfZz4hegINRr0gnhPjGLZSfo9bVvBqN5+nl55WAXFUKsdw+CC0TJd/GU01UGKmKHNBDbMshWuBr52lCCLtcQHfFADcainHbjRxX7weeP1zFRChrFe8Da8mF7gD5pVq2hvbBDaJwWntPXgnfLf7Kv0duPz2PF+3+YfKZDg7gkQByzzsgq1rOqNz/Pz2zeH0qB0ss3xsjmmtAm5u3oOvh7hk5H2ReKt5vfRtoy/ifs+W1HZvw3/mQaJnKssd12xcUF7h8V3VYOplQOdewJVm87MidTFOkDeI64fy2r4Q3Ge3sZqPWCt2fIclJH57b72nYYTifrEJm8pGSw2xmx7iHwtywLw/YHrSol1DxNZTUs6UdGCfDm9eJ4ir3aQPofYVofJP54qqij7o5I8sU8pG49SPVZG/OPoxoCr1k3jNNHIo7mv6prBTeYVdoUEX6dqHOxihDc/Pp3nvDwLCbCB9AjqcIyYODU7vAKizUhTdvCBQglegInpOqDKZ6om7jKX7pUZ6GFDgLPCVD4AHp8NBTY1PpwFUECSPOzTMS/pQVAd3TBdg39cXQCHJgZw+hD7sNem6xO/tr8NBAkw2PTCiI6MufWdrPFHSlUcGYkhzh+1AiOaPsJ20yblHsWVJKsfQtjCgh4lFFZT+VgMjRsyBD8orwTcw10CmZ5gTRGHFxSQsDrfAl2UcmYLYEcUI0UtbsuDXOYg2qCq/cQTkRCF4Kyjhx2TXjPMDsac3uLzkGy5MlheVJN3YnRuyXNZzDYCPI8W9d19EXsugFyfRGhumi+ftV8mq5YFphoE2XlXI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d3ab18-a7ea-4d1b-1ca5-08dbb5c4352e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 08:17:31.6134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x6CLkDSrfE28/s8PbNZ1CNU66ciKe3wm3KPkUD+jQOq61/HQR80FGPtlyKmWxV6prk+PSt1D2zya0tnDZe6QxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4577
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_05,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309150071
X-Proofpoint-ORIG-GUID: a_tp_TfysUZ_jEGFIvCSJ2qguQVGeOz0
X-Proofpoint-GUID: a_tp_TfysUZ_jEGFIvCSJ2qguQVGeOz0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit d41f57d15a90 ("btrfs: scan but don't register device on
single device filesystem") might call btrfs_free_stale_devices() with
uninitialized devt.

To fix bring the btrfs_free_stale_devices() under the else part which
will ensure devt is initialized.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/linux-btrfs/32e15558-0a3f-418a-b3ae-8cfbddbff7af@moroto.mountain
Fixes: d41f57d15a90 ("btrfs: scan but don't register device on single device filesystem")
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---

David,

  Could you pls fold this fix into the commit d41f57d15a90 ("btrfs: scan
  but don't register device on single device filesystem")

Thx.

 fs/btrfs/volumes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 47c1fa3f24e3..289cec740c2d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1280,11 +1280,11 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 		dev_t	devt;
 
 		ret = lookup_bdev(path, &devt);
-		if (ret) {
+		if (ret)
 			btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
 			path, ret);
-		}
-		btrfs_free_stale_devices(devt, NULL);
+		else
+			btrfs_free_stale_devices(devt, NULL);
 
 		pr_debug("BTRFS (%s) skip registering single non seed device\n",
 			 path);
-- 
2.38.1

