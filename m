Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E473075AA19
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jul 2023 10:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjGTI6O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 04:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjGTIu7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 04:50:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9711BC0
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 01:50:56 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K3Op50018212
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 08:50:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=Ejl3Gzs2iD72kUvAdittupk2Pa/bqIz2sxP5a5Sh1tc=;
 b=xT9v4pZI8rcea7ZQUg5CdDrTpwSdTc/1f2pTwLht6IEsJxHH1kvjrvjeudDDYxMtefyJ
 8xpxpMFgXTlACiytL6z/6OwuHIwDkaisD6JOmznIlRGjb9assVzA/jpeUE9ngcdmp57+
 pRxzMuROfo2cHNKBQ7hL4JK05Q9T6bBVmylVRbSlYXnurM1cXjQto+SFT61go29/lCAg
 A8S+TjAogoOpRgkRpRaHFlav8JiXrd+VRErvbVkcpE/a2Xmcx5t8rs5U5dxKp1m/dN2T
 Q0HBzbfxFpwSAn2xiFQYEL9QHI1JrhHWQFWaJWsNDbd+hA8YjIn72Xyku1q4dKcmvF2j TA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run771bjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 08:50:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36K81955019311
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 08:50:55 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw8tcpn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 08:50:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RY0C5FHuFtc5OXB/ypXTEiBeLH/04ipJt/pmFwva2vEeWnOCBsdG8zYNT5/Hdb8UmHAdGSMJtbKBTVLfqxaGgXOF/EqIVfBiQ9iHmni9EgNfUINFu4GguRc98ambmP0ncVj7p+f4pjAj8nM1Sl1Ey3IA3tpjecQXfRZYOc6i0PLoFNbm55SQ/uGkt1NnmbyroFlS1ZED3miJ6bLir3P6DSeDjO70M0mxG6mPk3ajWY8v6YzlFcGibud5qTp5gGKU/GgUPoGuA62v73+vGtVMoPhR7mznfOU3PHsBJF+NP9nNDuZv177uTLp4WXcTxpYmhWQoAeOwpzJOogE9GC3t9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ejl3Gzs2iD72kUvAdittupk2Pa/bqIz2sxP5a5Sh1tc=;
 b=MahaDrZQVE4SGa/s+jAKrcn362MApViSD1FdfCcHyqw5D25wdoLsTsTHgppmC3VEFoO2cRZ2Cm0gxVFWeVxYTe2jJ2GIckKGv8SDOOoMo9Ab7i9VZrWm72GDFLnq+33xAKGMx2FF5/OkfRj8eLRcK4TQ25zY1ceh6+xaTWrTlpFBL9MvNsndTe5G7VSMV6LTyZbR/Tus/EdLQ8dIonxjmT25YF/V5G1vwJfTnTrhHkwp6N8ujrocHYETq6OZLMSqfGMQvcFEhlgQoHPDk6sr0Q2ec1X/dhiAlkg4O1NuVL2Llj9mz0n3Pvjgqb9eWBE9J/E3XVoT2BhM7MoFxY7UJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ejl3Gzs2iD72kUvAdittupk2Pa/bqIz2sxP5a5Sh1tc=;
 b=RUvdjpKjNC3SZAF/C6JqeA+DqjWE2Zk7REYuNl1Cs1mzs3PGU2RwfAhBCtG+SHPbzVfQeRLGH3zw6NuUSp7I6fh8q+H/MGHx6S2N6IU2vB1/tMU+2uTahwGddFjgDHZW1/RoV7RzyUsyz7JkNUfS8adKU9dqIQ+xDZKmHpBSpwU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB6823.namprd10.prod.outlook.com (2603:10b6:8:11e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 08:50:53 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 08:50:53 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: fix dump-super metadata_uuid
Date:   Thu, 20 Jul 2023 16:50:43 +0800
Message-Id: <cover.1689841911.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:4:186::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df7f2f8-9033-45e0-2d2c-08db88fe6cae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cSGpL41vTX4esaL2Du4QNw3oQBTLyqg4/oifLkc/kFdyU1ef16aRLQPdx1BeslGN6bvCDHBX6LzHWRdfAne7AsXggvumv+1HXaFgng5kSadVRuJxAKRqO9yoQ2N2qe/YPy4BEejKyZbpEIyafo70M1P6LxK/7ghfsSXxeBTQzMXOf+Gc7DeZjWYpdfbI3jE9BHeYm8wQH4nPcv6PJGLnouX7OneSYn21HTf7HxAOkOlnXbUqT6r1FwDabfGdPPmqczF8vKlhgdpCU4ns4VY59QL7wX6eZ0fIIJPKMmmIJpGayFVtqwSVIqAGCBUCwAhA0YlXLSp/dPq4wiw7V7KxR/3pSIeoG4MtBD2a3cnZTqEJvItzVz+avu1A2+HRjTVV3Je0fH8GYZ4l8Rc1Y2zZzwzxsm/o9SOMsXWqTSq2YSeTmxioFUB9AUx0Z5okS1sYs+NZJdaFPyOMxbRYHTCym2A9dGn0VJchgDU/E15jWuIKYh9XGZM2laY/ozOnGR4dRb6QdQ0F+4buDtg/ckXthTt9ZH9TMFqgOxWwx5FnXSKl4MaKs2goBRWc8Es39v+j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199021)(2906002)(4744005)(478600001)(41300700001)(44832011)(8936002)(8676002)(5660300002)(66556008)(66476007)(66946007)(6916009)(316002)(2616005)(86362001)(36756003)(26005)(186003)(6506007)(6486002)(83380400001)(6512007)(38100700002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AcoPAhFOeR++5tZIcxia3phbul87sJAY8PGh1GFZFz5KR87uBRewPeDfDSuI?=
 =?us-ascii?Q?nNZRvE4kzmQs6MFmA2u7dtza9Jaa6r3DLmrntwQVu5rawjHL/6PpSPDFmF3T?=
 =?us-ascii?Q?I6v1/ybsTR/hPr4oecigDeh+zCGKb1Ew6fhOl9Z7lvTxtC43TZBdU0lE2xxF?=
 =?us-ascii?Q?XFfla7gpH1TBK7lg+PNpJO3gIVnVY53MSVP/bQoHaB/q+klq0ttnuCrBN2uv?=
 =?us-ascii?Q?KIch19Xmhpx2trLhMw7IZy+E+u07oBdl165QkAyoFmLJojGjsHxU5Bp4PGfM?=
 =?us-ascii?Q?iGp7zaMXmxDJnxvjQKlAbin2Ad5aj0NNJ0k1Qwf2nKaKP2QWIJKFYPe7Kp7k?=
 =?us-ascii?Q?XQ7bhIg471t1RWPKeeDcu2GlWj5D8pq9opTAo7UlkE95BnG6FuqYfy7paLru?=
 =?us-ascii?Q?XVEFqdWNSErDhFwSM1p4Lrd/yDLdx9atvKpf/W3jCKJDDOXJMNHF+RRkiT4K?=
 =?us-ascii?Q?+8cAkV9RxPX/R5znUNT8+rVNp1ur6VyigNwEOV+YlyMbqEBuW4kO2+ITCWFc?=
 =?us-ascii?Q?ahC6un0z9Z+B5GKkY2fJejOPhmOje/W5E7fYNVV6/AdHDUqLhsF3t8N075Zf?=
 =?us-ascii?Q?uoQLTQf8Mau8nw9K3ptrmpfKmJEzNKf6Dm6Dlmf3kVxGNErcAcwaOMx5qGx7?=
 =?us-ascii?Q?IYDVE6I3OYhUROH4VFGqE3ta8Qk3/dzxhQxEhB/X6uIeucPTH/0Ukg49OZXN?=
 =?us-ascii?Q?jMCInwqyQmgu4bMCuv5xhvRh1Xj2M8cH9zCKBhOhWrMvarw0X3agsfsRLEKd?=
 =?us-ascii?Q?k6Xp6G9z4oW/UnXUQH3xKzlu92g5Bb81OOu8C16J15Pxx44o0h5BUJqPQvlp?=
 =?us-ascii?Q?XSUr3p/gNPwBFprizjCMsAD4TyQP8kOGsdqo7DcDbV20QoF5MXRlCc/yHAKB?=
 =?us-ascii?Q?2NpxkkpaHSxso9QIFIKHzh2orD5QZ8lc/I9K8is/Af7jmazLrTy3bko7Ggyx?=
 =?us-ascii?Q?5KOfeAj7kV6I2JSu2tkXLNeL56iGKyGDO2UR9lMRgQMGlzvtQLQbLX0pHQOG?=
 =?us-ascii?Q?Sf0T3vgkN3byipGyl9gE6bpFf5AzOkd71EUvswzGmnfQlC+lPODmjQbQytVZ?=
 =?us-ascii?Q?CUwJtIlB1NZT59VBjpDMV7uPaFkc8xwKbvedp7h7baZahUICq0800PNq3NIL?=
 =?us-ascii?Q?tVKvJcYjNR//INFVLQxEXCWqenBeOKjgeIZPAFPfAScpKwlzHoSuIqNmyB6c?=
 =?us-ascii?Q?gP/A8wZ+eGtwPDMBRCqo8ULj0AsX/68qNBc/dWY62oiD7zynv3IcdUebL5Fo?=
 =?us-ascii?Q?FJ/LLH0ynTkSs191M5/7TxcVO5Vc26SVY4nXbyfkhTDx0jMSEFaACky+Dnds?=
 =?us-ascii?Q?ibMEbEF2lQUF0h+HCy4OE+YSGzL7L0WQErPr0Bt9PCjcc5T1d046aD9ELcHO?=
 =?us-ascii?Q?FS1eLmVUHQeENUhReII0vqsvyMxZCM3tZjIQ0B4TcsC99efGJSow4zhDXqbs?=
 =?us-ascii?Q?o2Y9C9fo2e4+PW9rWcd28j/8amfzUWNSaCF8PdkJcod7df4sso5LfuP89p3q?=
 =?us-ascii?Q?E7z9yqzMtIKUciLbNjthvaHfOG9ZjVHX+8rHZhMxtXTqL2k+byIOGas29F9U?=
 =?us-ascii?Q?NoBIt6xDlfCOWo7ZUP8oF50bqpYy2YE8U3KpdyB+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zCWTBeoci53pVX6KDj3nqxJCSZg6H/hLwKxAU1FAqLgkmRBIxJ+++VD86JkRPoUDAqU7FVMt1qZp0x1Io9SY9bgMvOdRaRMjqEFoBR1c4XJkXASTXiY9+TlkLokaqDjyvTnlQiFKZN3ntbXJnC+FgqXFYKgPJZBLokIc9Goaj3XIB8rywq4IeGs2UOwCeEaDnNi8SI48qf8GCcC5pzfypAFvdRgQY3iLA31jBAvGdfuStlyVvHfuMg6UU9tmY1iyeUQ92qRFB4IAsqcoFYYyIKfrsdu5o0dSkgIMEpxBsMMFU4RcN834TFyOijLVf2ODSILxpEbE7QAqi8SJw2ypX1wKT1fVe4WgFdkQFv3XGbFvpEpFqYp09jfm+3d05Gx5FoSqlsF+TjyVCdUFvT2+MczapSLTbsV1Rt0aALBD0r7Z4dOhThegHfF15Oy1DIhyHqUmwtb5sf5b6oW+amkRr00+102ULQME1yD/R6i/0NgxxpbflExqNaMOIx66wxUHkH3KyXvZK8xIE+HNwRi5u4u3Aopez64urFqZ5hEijYhGlfVNLLRT5wmFotXJZxmXyTOjCnC/2yMHN5Fzf0oRVMW15hG/GkozBu+AlACT3mTDHrsbg80f2IJe/x8vCh0/cc9ijLsoN1WyEFv9St7tfma9if9skKg6xMH6MMdOnpoZxRCaDwCk4fMaDe5eCYdXRDu8+He1r2feQ/0ULSvNpnBHyiwk5eSojM8K5U7PQiWRMzHiuADx/jFyvK+7GU5GZahj09Z+YIgU0Xm5kf6jeg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df7f2f8-9033-45e0-2d2c-08db88fe6cae
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 08:50:53.0565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x7gUZ1ulzCV7F4BpQdSlKgL+kouCNOQRMjUmdUijlLzaNnUHCJguGdMBBhJODd5soXzwIc/mIN9XZ2iPmN7A0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6823
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_02,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200073
X-Proofpoint-GUID: bpCXs4MkjdMzixszsHC-B_17nm-LyUfA
X-Proofpoint-ORIG-GUID: bpCXs4MkjdMzixszsHC-B_17nm-LyUfA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This can be integrated independently; so sending it out separately while
I continue to revise the other patches.

This has passed Btrfs-progs tests, and Fstests tests need no fix.

Patch 1 fixes the dump-super output, and patch 2 fixes the test cases
depending on the dump-super output.

Anand Jain (2):
  btrfs-progs: dump-super print actual metadata_uuid value
  btrfs-progs: tests: return metadata_uuid or fsid as per METADATA_UUID
    flag

 kernel-shared/print-tree.c                 |  8 ++------
 tests/misc-tests/034-metadata-uuid/test.sh | 24 +++++++++++++++++++---
 2 files changed, 23 insertions(+), 9 deletions(-)

-- 
2.39.3

