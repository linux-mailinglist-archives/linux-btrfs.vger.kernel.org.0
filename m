Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5877777BD10
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Aug 2023 17:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjHNPak (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Aug 2023 11:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbjHNPaI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Aug 2023 11:30:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14BB10DD
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 08:30:03 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ECiR23016385
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:30:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=S3VZhSxYvFbH1ZOSZVmQS00gs7M7MXRwoQaZ4BNoqoM=;
 b=GlODWw5JF8Ly3A7lGvGGobZo/8533vXFxmXvK/IMc1gGn9IWyytTUdAO2hvplnjKm/uj
 dK/wf+yKB9SwZT/s+aHhgkuWyPR1PyH0zUUjFDyp+gUvI7803bNYt87Cdkhf5zFP4DlI
 qayf7AJzMMzIre4vrPAC1NH9GsDsfbdtZYyyatykJHcdrtt4NI2Cca+T88JWmCkFAZ4y
 8S30YMSM6sYwEPSYvFYFCnlhEDRdXbj85w6xenuywtpPH5HqHI9LeaSrw6fkmakD6E5Y
 TOulzFUZNLg6io59Z98BSrcP/VKu6LRfGXQ1aoUTh/f/6DIhx+WQmLRdlu63pwLNFf9P 5Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2w5tuuu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:30:03 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EF7Xnd038962
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:30:02 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey6y1s54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:30:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GESZnLXkH5+wPlS8iWsMn+ueei0zz3A861/O/I1zsovgMJU7AE6imutlCeY+iIV+aByQDVKnE0JcJyCWTqeMtgrh0+b+/HThUuRt8FRpjQmjR7AgzYb+LAHmedqP8Q+4Tunm8Wu3ES6+kr9dhBWpPIB7I1nVFmNMc3CHzfiw4dGubihC1HuNLCtM1N8LYwmTrF+jbSQGHBdNTV71ScmRGTbHNQ8NM118G75ChuuwSbadwj2iVwU316FJUgqBYWjkESHAGjE/8QsOt/YiYQUmL1qWOdrema1V71ojzDfrhwCJ/fmQIaikxUre3dLhNj0V8bHhU/narOh0fwEyQcWDeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3VZhSxYvFbH1ZOSZVmQS00gs7M7MXRwoQaZ4BNoqoM=;
 b=jK9ve3l9W92ARScpJQjYIMNVFePjpVQYVkbb7lv6XYbuYcV8xRvW7wW1y/LgPIeXAA4hAzmNU2qJv9TuqSgF6VUZCPTBA/RvzlnHU+wQXCvghHKTjRmkUsSDcgMKHGf6MszxZz1dOUUhQAGNJuPq291NZh0XVCTMSfQRtWKAU4PWtVcNKWHImTmvX+6DPdN2lovIgo1zRbinaJ2hibbZqXPfH6isY6dZvtVAb78P1R/LnhTNmUYqdcmYSc6k2+wm8bX5Wntoiv1NRy43VR5Uhody9EyiNRJ1Lq14kxiICVBF0t6m0mnTG+CJgDtFHJIG0YnSLHvEdUq6GXtd5z59IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3VZhSxYvFbH1ZOSZVmQS00gs7M7MXRwoQaZ4BNoqoM=;
 b=SoCYTUulHnvG7BwEGPo6KYGYSv47o127/TFr7Gs/RMqiD3nAVBqeawM8OZ+lboS16n1kD2xiCdrFFkS/L0CUmZxH0Wb0DVMDhsAwThK/bkOnnfmcIUGB2uKib0d5DM3BpHb3WHaEdDd90DeJQeauGOuivckrapIkyC/oJd1I9Y0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6342.namprd10.prod.outlook.com (2603:10b6:806:255::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 15:30:00 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 15:30:00 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 14/16] btrfs-progs: add support to fix superblock with CHANGING_FSID_V2 flag
Date:   Mon, 14 Aug 2023 23:28:10 +0800
Message-Id: <14877be7a8208ca54419de27e02e741401cdd863.1692018849.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1692018849.git.anand.jain@oracle.com>
References: <cover.1692018849.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: 825b8c5b-fd4e-4ee7-32b4-08db9cdb52b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZrirHwyONKRKJj6ZkFVo1rxlxjIIR5jO8HlWjnHyX+Zv6UCb0jhP3Z57GdvSzcGrBZtWrX1IpoaT0T5bY5pVgNzrw2EApXaZuMV6RVO+Rm+jEwJ/eOUukbqhwTowz/mTnnHN5Ci2IQVzOoZ3LFfNPVXQDctkjYU4ZVa81AcWQw7TUG5xxoIMrO9QmN00y12861mNtSbRvyKjW/Eyy1eC2EtyfrY9Jj39SU2amWxl1DLBS/CIL5naHvBGUn0P9t/afBXK/mmBbhTBHcj+fbyezXYyYxmza0HQgMi2J78wzvvtKkBLVzOOSC0ilzyAR2UQWg5tky30nmCHrXuEU7qq48ovhdxdsP6l32omdEttRIBmw/8jNNqICa6QwLJ4I0AVWkUQRaK9ItC81KkU5xshadEwmP4cI3RV46J5e3GLsFd+nIvvMZP/EycJ8Lu3x+zFreAxalu68TvL2CDHybHk6y4xCpaYBRITeijQbjbNJAFw2gvc5j/SGt/miv0jKCXTk1lsD/pCWM02osCGTbW47Yp5ibLWtIt/9h/F0Jrqt+idJQoeoR6itZkN0sIwl/XD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(346002)(39860400002)(136003)(186006)(451199021)(1800799006)(8936002)(6512007)(86362001)(478600001)(6506007)(6486002)(316002)(8676002)(66946007)(41300700001)(66556008)(6666004)(66476007)(6916009)(5660300002)(44832011)(26005)(2616005)(36756003)(83380400001)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NOgFmbWztEy4ok1OSqJOHFdcHOGo98GBNXutFGSvvS/c6slBKERqrPkXbFK4?=
 =?us-ascii?Q?Iq3C7YoWl2wLpNRfCqSZW6cHZ7u+asJS86LI/DFyFwwS7qlAMmCERmZ9uu1A?=
 =?us-ascii?Q?noNLbxCCkE9Awdn2hjtxmCiLxvdv1gFwb6boWiKIx0P87zDs6NaMIk286WZ+?=
 =?us-ascii?Q?vhhpYuUxfpmte9ykidDrCrummDt+FEfEz61oskvD1kA9aefHq+SEUCW80LHS?=
 =?us-ascii?Q?uHV6fBJZQhThJLziNjhOXkgLazykqGEHG8Sc/M2Aso9x/wUen4Ax0aObEiYp?=
 =?us-ascii?Q?c7bhJZdmrLh1ChZc/VwExE65jswGEGvS93bkZQi7inzn1mMhojnW2VMIG8Sj?=
 =?us-ascii?Q?Xv10wHsIdnNaEj91g8P9kxiq+B771JjMOlsm1DrAMc67YnTfxjf3Kb8R523y?=
 =?us-ascii?Q?Uh8gdIEIPLvpioUtuvvlKKz+G96mW2IgALe/iR1vf9wTBZlrgkaHwktvdqbO?=
 =?us-ascii?Q?iCUHepuxo+JDWTuNxp+NPyOBeWu8LRTdDm9SVS0EcTUigjj4tzl9L0jeDvp3?=
 =?us-ascii?Q?NzuqxU/f5IgD20DaMkQgaFVvssnMGsc3PbbY2ZxizFwDm9zeD+4YC1sUQIar?=
 =?us-ascii?Q?7CUi526t4O5k+30ufVjsCpd4HfICE2fv+amuzUZurYQuT2MYtijzI8xWL3sA?=
 =?us-ascii?Q?zXlIjXvgNm31ZNG2va91ZBHoCcDtyg+qUG4b08bZWmgJ5eoVlbajltWneG2a?=
 =?us-ascii?Q?exLY58V4AiEadDRm5TidRcDKF9lhv5txq55XCibFmobooAaCN8FA0UVWbORk?=
 =?us-ascii?Q?F1UY09UFODWPPfgJE7WVJNW44KmaD2CTbuNYtSSlQAmP8mUU8/o7L2vrQSQg?=
 =?us-ascii?Q?5vKwH2xcnIMTCx3Emb3LP5ubGecE3hD1dHXDVQML04UDFwrXKCbdMEtiC6Th?=
 =?us-ascii?Q?IYCMaj52tuvp803NL4xtSuQl/PhghOubZK7d6x6umaSVnqiWuzgNdCCo2gwu?=
 =?us-ascii?Q?YyhAFPp4aS0xx2cl9EA7TFFMOZi3FbBGaZNp/qLqTSrTDAAiRaNjmKwFPHgt?=
 =?us-ascii?Q?c7EMxzajDS9SZGR1vdTy6HlmQqm3q/GtGtnkBHUfn1aOF/PVeq6jSOnJEM27?=
 =?us-ascii?Q?oHtR8iVphEnTfaMH1039MbqVeCWiMxWmkktZICV2VhsS5fE9m6CWgN6t6vI/?=
 =?us-ascii?Q?GmraoqYAxSWQi63n272rr9N+uBHzwv79CIEVec+5iNygHY0+G7g6KjHs6Srp?=
 =?us-ascii?Q?xYnroms7MItFT2Ofj11f1lxA0uzqw4aj5mGUinbvbAMUcfcaObctR7uPiuSS?=
 =?us-ascii?Q?FGk99KnWAvq/2Vcn4DEG/NvxL4blL0XHi7K3ehGD5dkaTAorlTZdTl7sycrm?=
 =?us-ascii?Q?xloEn40iGXtpFnRU+WlFIcAe/LTxzOIJIn/UInL+Gv/rhMzyI91ULGkf6qLX?=
 =?us-ascii?Q?OpVOCgIm1x30rRJN3wzKlUwNE0AsIUvIDarE0IUu1AiQkgPjQCrTkyI/i15m?=
 =?us-ascii?Q?4EpYWhnFMDpKZh8lnuXFN/6gDgp7ZhKZs7lSWON2VGy6QHkoS48oGUX2uziI?=
 =?us-ascii?Q?wT+dXmEg+EzvQOgYjoSfN6DjoxsNEgv87jzJ09epkQj1KJROYzDGjQPUAflL?=
 =?us-ascii?Q?BbF9sqxHcbuWEaW6N9Lk6DXui5BLE743kXYQ06/Fv4uxIQlQAIIRdoQ+bvD5?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4+r7PYHEVYJL603mYUeLKmeoncLv38ERcoovODM9u3VTz9oXC53gpW+/wKIU3RcxLWhPCX+2sEE3VkFhrVmh/lZ2cmJUJ8vcGJb3PSj86/UXhGz+67v0j3kErgZD6eSf2zZOjz8m0vcNNOolT+lzY6GJKV9I3Wukr2UAZMrafJOGIxdOpscALNc5z/HZno1Y4mRgDzR5lDYJDDrvR7v3Vlg2m36dNyV2gW2Pt8C9FMz+wE0RQMoKpkRcAzxRDNeRqv8Wn+DdeHIlJ1U+99g2pSBzo/mfxTNGj8ymrFpaRsl2P7KFVCKFaj5bcGqwLEpOLKEyaVqGLf7GVxlzrzL7zaUZhPJla0bqyc2dxXi5qYuuD+js0+xkM7CH9yjeIoEfiywqPljJdprwmMuu28iHI67Bd4qRJq18Kfoxpj4JjhaQi3cCxeaMT0Ezhc1Q/lsbQIKlNQTCbizIdKlrgg6p9iZnsZxydhOAatB8mXgMBQrHJfLY+VzGiIlnnSeZGVj9zANr5Q85ex4CXQfyTOiMZ2n/MR1jlusDeZ9vB1I5lDB//9/aLAJEO5efIKmECekiDbvVjFXuYpivNQRCjC1oA6ACY6yMUFIQzrZlR9WnZRlClR3WNg30WCDGG42Bxovpk8YEwAr4m7ALUgL6R0aqKKyLWve8b4Gd17FODPsbSZ04rbcrCDcI9eRfRyPwJ4IAR1LLHMG766EaDOFdDmMm4mc2SgIfucLbZuS+ATuHitTXVT1BP7rqJztXYEXOn0YtXP5BYQJRLQCik8coQgM1ig==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 825b8c5b-fd4e-4ee7-32b4-08db9cdb52b2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 15:30:00.5573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sie5Wthx/FFcI9ZIQ3ZzQKZrqopjhExwjVcCfNuw4cvZHDe+R59QLicgJ02MKHz/XjQfVljXFN3/X+NCNRJMsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6342
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_12,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140144
X-Proofpoint-ORIG-GUID: YwX4-3I7DtQ2U-qdA0dgWyfpTfRPfUTv
X-Proofpoint-GUID: YwX4-3I7DtQ2U-qdA0dgWyfpTfRPfUTv
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Most of the code and functions in this patch is copied from the kernel.
Now, with this patch applied, there is no need to mount the device to
complete the incomplete 'btrfstune -m|M' command (CHANING_FSID_V2 flag).
Instead, the same command could be run, which will successfully complete
the operation.

Currently, the 'tests/misc-tests/034-metadata-uuid' tests the kernel using
four sets of disk images with CHANING_FSID_V2. Now, this test case has been
updated (as in the next patch) to test the the progs part.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 kernel-shared/volumes.c | 184 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 179 insertions(+), 5 deletions(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index ad006b9de315..62015053afe3 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -332,6 +332,159 @@ static struct btrfs_fs_devices *find_fsid(u8 *fsid, u8 *metadata_uuid)
 	return NULL;
 }
 
+static u8 *btrfs_sb_fsid_ptr(struct btrfs_super_block *sb)
+{
+	bool has_metadata_uuid = (btrfs_super_incompat_flags(sb) &
+				  BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
+
+	return has_metadata_uuid ? sb->metadata_uuid : sb->fsid;
+}
+
+static bool match_fsid_fs_devices(const struct btrfs_fs_devices *fs_devices,
+				  const u8 *fsid, const u8 *metadata_fsid)
+{
+	if (memcmp(fsid, fs_devices->fsid, BTRFS_FSID_SIZE) != 0)
+		return false;
+
+	if (!metadata_fsid)
+		return true;
+
+	if (memcmp(metadata_fsid, fs_devices->metadata_uuid, BTRFS_FSID_SIZE) != 0)
+		return false;
+
+	return true;
+}
+
+/*
+ * First check if the metadata_uuid is different from the fsid in the given
+ * fs_devices. Then check if the given fsid is the same as the metadata_uuid
+ * in the fs_devices. If it is, return true; otherwise, return false.
+ */
+static inline bool check_fsid_changed(const struct btrfs_fs_devices *fs_devices,
+				      const u8 *fsid)
+{
+	return memcmp(fs_devices->fsid, fs_devices->metadata_uuid,
+		      BTRFS_FSID_SIZE) != 0 &&
+	       memcmp(fs_devices->metadata_uuid, fsid, BTRFS_FSID_SIZE) == 0;
+}
+
+static struct btrfs_fs_devices *find_fsid_with_metadata_uuid(
+				struct btrfs_super_block *disk_super)
+{
+
+	struct btrfs_fs_devices *fs_devices;
+
+	/*
+	 * Handle scanned device having completed its fsid change but
+	 * belonging to a fs_devices that was created by first scanning
+	 * a device which didn't have its fsid/metadata_uuid changed
+	 * at all and the CHANGING_FSID_V2 flag set.
+	 */
+	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
+		if (!fs_devices->changing_fsid)
+			continue;
+
+		if (match_fsid_fs_devices(fs_devices, disk_super->metadata_uuid,
+					  fs_devices->fsid))
+			return fs_devices;
+	}
+
+	/*
+	 * Handle scanned device having completed its fsid change but
+	 * belonging to a fs_devices that was created by a device that
+	 * has an outdated pair of fsid/metadata_uuid and
+	 * CHANGING_FSID_V2 flag set.
+	 */
+	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
+		if (!fs_devices->changing_fsid)
+			continue;
+
+		if (check_fsid_changed(fs_devices, disk_super->metadata_uuid))
+			return fs_devices;
+	}
+
+	return find_fsid(disk_super->fsid, disk_super->metadata_uuid);
+}
+
+/*
+ * Handle scanned device having its CHANGING_FSID_V2 flag set and the fs_devices
+ * being created with a disk that has already completed its fsid change. Such
+ * disk can belong to an fs which has its FSID changed or to one which doesn't.
+ * Handle both cases here.
+ */
+static struct btrfs_fs_devices *find_fsid_inprogress(
+					struct btrfs_super_block *disk_super)
+{
+	struct btrfs_fs_devices *fs_devices;
+
+	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
+		if (fs_devices->changing_fsid)
+			continue;
+
+		if (check_fsid_changed(fs_devices,  disk_super->fsid))
+			return fs_devices;
+	}
+
+	return find_fsid(disk_super->fsid, NULL);
+}
+
+static struct btrfs_fs_devices *find_fsid_changed(
+					struct btrfs_super_block *disk_super)
+{
+	struct btrfs_fs_devices *fs_devices;
+
+	/*
+	 * Handles the case where scanned device is part of an fs that had
+	 * multiple successful changes of FSID but currently device didn't
+	 * observe it. Meaning our fsid will be different than theirs. We need
+	 * to handle two subcases :
+	 *  1 - The fs still continues to have different METADATA/FSID uuids.
+	 *  2 - The fs is switched back to its original FSID (METADATA/FSID
+	 *  are equal).
+	 */
+	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
+		/* Changed UUIDs */
+		if (check_fsid_changed(fs_devices, disk_super->metadata_uuid) &&
+		    memcmp(fs_devices->fsid, disk_super->fsid,
+			   BTRFS_FSID_SIZE) != 0)
+			return fs_devices;
+
+		/* Unchanged UUIDs */
+		if (memcmp(fs_devices->metadata_uuid, fs_devices->fsid,
+			   BTRFS_FSID_SIZE) == 0 &&
+		    memcmp(fs_devices->fsid, disk_super->metadata_uuid,
+			   BTRFS_FSID_SIZE) == 0)
+			return fs_devices;
+	}
+
+	return NULL;
+}
+
+static struct btrfs_fs_devices *find_fsid_reverted_metadata(
+				struct btrfs_super_block *disk_super)
+{
+	struct btrfs_fs_devices *fs_devices;
+
+	/*
+	 * Handle the case where the scanned device is part of an fs whose last
+	 * metadata UUID change reverted it to the original FSID. At the same
+	 * time fs_devices was first created by another constituent device
+	 * which didn't fully observe the operation. This results in an
+	 * btrfs_fs_devices created with metadata/fsid different AND
+	 * btrfs_fs_devices::fsid_change set AND the metadata_uuid of the
+	 * fs_devices equal to the FSID of the disk.
+	 */
+	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
+		if (!fs_devices->changing_fsid)
+			continue;
+
+		if (check_fsid_changed(fs_devices, disk_super->fsid))
+			return fs_devices;
+	}
+
+	return NULL;
+}
+
 static int device_list_add(const char *path,
 			   struct btrfs_super_block *disk_super,
 			   struct btrfs_fs_devices **fs_devices_ret)
@@ -346,11 +499,18 @@ static int device_list_add(const char *path,
 			      (BTRFS_SUPER_FLAG_CHANGING_FSID |
 			       BTRFS_SUPER_FLAG_CHANGING_FSID_V2));
 
-	if (metadata_uuid)
-		fs_devices = find_fsid(disk_super->fsid,
-				       disk_super->metadata_uuid);
-	else
-		fs_devices = find_fsid(disk_super->fsid, NULL);
+	if (changing_fsid) {
+		if (!metadata_uuid)
+			fs_devices = find_fsid_inprogress(disk_super);
+		else
+			fs_devices = find_fsid_changed(disk_super);
+	} else if (metadata_uuid) {
+		fs_devices = find_fsid_with_metadata_uuid(disk_super);
+	} else {
+		fs_devices = find_fsid_reverted_metadata(disk_super);
+		if (!fs_devices)
+			fs_devices = find_fsid(disk_super->fsid, NULL);
+	}
 
 	if (!fs_devices) {
 		fs_devices = kzalloc(sizeof(*fs_devices), GFP_NOFS);
@@ -375,7 +535,21 @@ static int device_list_add(const char *path,
 	} else {
 		device = find_device(fs_devices, devid,
 				       disk_super->dev_item.uuid);
+		/*
+		 * If this disk has been pulled into an fs devices created by
+		 * a device which had the CHANGING_FSID_V2 flag then replace the
+		 * metadata_uuid/fsid values of the fs_devices.
+		 */
+		if (fs_devices->changing_fsid &&
+		    found_transid > fs_devices->latest_generation) {
+			memcpy(fs_devices->fsid, disk_super->fsid,
+			       BTRFS_FSID_SIZE);
+			memcpy(fs_devices->metadata_uuid,
+			       btrfs_sb_fsid_ptr(disk_super), BTRFS_FSID_SIZE);
+			fs_devices->changing_fsid = false;
+		}
 	}
+
 	if (!device) {
 		device = kzalloc(sizeof(*device), GFP_NOFS);
 		if (!device) {
-- 
2.39.3

