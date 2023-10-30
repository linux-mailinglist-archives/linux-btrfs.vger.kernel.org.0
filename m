Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9CB7DBB8E
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Oct 2023 15:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbjJ3OPy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Oct 2023 10:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbjJ3OPx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Oct 2023 10:15:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056E1C6;
        Mon, 30 Oct 2023 07:15:50 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UD2C7K011859;
        Mon, 30 Oct 2023 14:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=qlhH7Ll3v/GRYG47BVrph9fsYSXYpVT21BbJUmJNFdA=;
 b=vqIrIvMux04kFomsE+96Hc9KYdtAQqFlU9CHrLf/ARzy7Sag7uX+1LA9TMLFMxhYJ3pC
 yZCNk9Y3XLgqjoBb+IoY4KQ+h1+JATu8PJ/yrZhKNissAHVkbxzzW+3FgllSVtlAJ4vx
 iQBsVVxnA6lvdBJHAuOuS/OEkkWZ98BzC+aoDxIYSlwyh5Jg+RQlRsKQi8fUB/bchDJ0
 p9Du2q85sT/UvnVNBfUiCrCpLSTu+hXTw306ghanpvtRtwdXDknMfLGuvJjX2B8NjsY0
 vERkuZD+H9OiPxk3Ut8diHNIvyV4WAggB66ICX349vD8ppAhdCNMR4FKYvnVmKkrILYr yw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0s33twx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 14:15:47 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39UE3QG9001067;
        Mon, 30 Oct 2023 14:15:46 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr4p7yp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 14:15:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlYofMGt3zm7G6zTTzYA5rIavnwTfbpw+7wthE7nkg9KWHJmFc8i2KAOgoqmefA4/3gTUbl/ZknGi7sb++5G3OWzUHHgdjD+wTVsZpeNClIcUx5/qYt9Lembn48h3Zs0fhpmHMMQQar7xy6vR49m3Wb9GCM+WBRWhgUQW+mtyqto8zPUmRsLzyvnNp8kbh4bPmGPHi6InnO1I3lcSjXPDxBzQ6k9L211fiPbYNTVHHIxMy6DQbrZDs94+Q8RRqFFgTKdXajBXDXgCMHUiBTSqJT0G/OT14Qu2TuNRXxpdpVySSfWbKNs/q/mo3evl8+jobrlLAd/AisfNEyF1PkzMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlhH7Ll3v/GRYG47BVrph9fsYSXYpVT21BbJUmJNFdA=;
 b=gtP3IVeLWF4K2STzTVW2dGuTJnXNoep/cAlhG5xwRSHB3X7Ddec9V/RDCqNOm0Z70uL4kVoxYwDVlysvlmZxs8bBgDMR08SOxr4NGfxcledHUNYk7nOn4yhlnCZNJmoHcK4xPNUuMsJ5sigGQmjpMjPKDK9Ft0DGMwoHBJ5PjsXfbcNxgHJfoWl9v1WLA5K0jeYa8+UPzOFR1RmQB90W+fCepvZtzgfHMRmpm3VTrm0xZlmG7/4eBMt90lJP9g2Nse3pcCvgSnxQZrcR2Wzu+jdOEqT/5qzhpaHNkljpTSKPJZFusVoP3cB1aab8JUBpRFKivI2uh+2GEgRtZT7l4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlhH7Ll3v/GRYG47BVrph9fsYSXYpVT21BbJUmJNFdA=;
 b=AS3ougRTo/M69QkKUC78DtkAuNtHh6efoKFgHWZfEPg+tApjhey7DtVVr7bu4IL0jw4CTsBQJsGuAdH0OjRtiIuPMnvUBl35JZGHF3J9qsqhSN0C+r4vNrTaqKssDW2MMpUPjtS5o7gvCt8v1SGtVWpe0xI4Ss1J07R0ey7zoW0=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by DS0PR10MB6127.namprd10.prod.outlook.com (2603:10b6:8:c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Mon, 30 Oct
 2023 14:15:44 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::9010:707c:641f:68ab]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::9010:707c:641f:68ab%6]) with mapi id 15.20.6907.021; Mon, 30 Oct 2023
 14:15:44 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [PATCH 6/6 v3] btrfs/219: add to the auto group
Date:   Mon, 30 Oct 2023 22:15:08 +0800
Message-Id: <5c22b975907174835f5a42e4d53b482b266b9056.1698674332.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1698674332.git.anand.jain@oracle.com>
References: <cover.1698674332.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|DS0PR10MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab3ee68-34c1-4b9b-d91a-08dbd952b472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7gN98IGYkjx/qzKkPgfoikS+aHt+uSkOeTeK0/FGDBqQTHO9q76LYMSAZ8Ic0xi/E98wkA8EaEPQ6mA5ZkqQpixhX9dTl0mU9xUHC8yMcxpYBvprqjzBlDrTvu69JCte+dGlzZdus986SsQ6iKquZKQN4X6RawhyNuPBvJfYYV2jNC+8S8VApPsIc6KhbS+gFgJEih1V4pZTaRHB8tlFdbTnC1DCg8+lehXUJ0qh0gJqmNwrJDPIvBv1gZuDWHzwcEglsintzZdbHhgX9EjUOxYbeuHKnzVWlFz6kDAgHPy2naVZIK5LSdXyO0e4zFpphFbuSJI1oy9NsjKVWCGWLESpbNhxma7HpurxTzscHZ00vVOoEXoaWpoLmMDGtJRaRyGaFmlJlR+4EPMbVwHPMf0RYxioHt+6irYZQmm8RE5baoZKHUUJHUNo+aCIp/AL5zCAYc3dbpPH6oRp/rxa903m/EQJi44fvGNWUj5CuaPjbEZSoahri1Zmk52EihA1ZsHSWpa25bTP6FHuKc+D9Pc/ZRBrjckI8fqMxs59dBZcIN8DcEDHJ77g287ldsMi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(136003)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38100700002)(2906002)(4744005)(83380400001)(5660300002)(2616005)(86362001)(6512007)(41300700001)(44832011)(66556008)(66476007)(316002)(6916009)(66946007)(6666004)(6486002)(6506007)(8676002)(26005)(478600001)(4326008)(8936002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eksyc3ILSG75MMmUd4+Mby4515c0eTsGheOwutt6HfdwA68rMovJlSggPZXv?=
 =?us-ascii?Q?1+qkIFz9KAyaqyjzpg7igWHvVMcMrtlSS0xVt6s7OErB1Sc/HRHDrm4lHygQ?=
 =?us-ascii?Q?FGrbwaSTyUrm3Qwfa2d5IM8FBcPorHDBiezRf3MtLFiWfmOzsPXPbqM/I64k?=
 =?us-ascii?Q?xuMZJmsN4hXlAV5M7YYZ4kP4mSQVaen6oo1EyXp2O86tq5ft9Y3iSc1Zy9Ar?=
 =?us-ascii?Q?2ogWU2fgMWnyTQRCLjy+P8nIYShNJvUSS4011d++NqFo7gOlB13VdjCNDQ2O?=
 =?us-ascii?Q?qRTbD5Q24X1nOFxb741e/MV/+tvQIcaKBs9WbdZSKneyLi0btSR74PnwjpDG?=
 =?us-ascii?Q?efotPx0XLGhnzRY6ixm1U5fyD6IiPySwvdAYdY85owX1hYwKt9/pLEWQNa1K?=
 =?us-ascii?Q?kafmQqqCVfMkO9LqhpSGtgZ2Xf6GuYGQHOD6HqVYAtEiTPf43zJ56XZ7q4Up?=
 =?us-ascii?Q?3+0aToUp+H5Kl0LwTqBHIblC6QNwejK9Rg9OGLrQizPedhO501pNPKLS99Mc?=
 =?us-ascii?Q?8/rQBabitxQ96cUoM7Eh11TUQob3ncuEjNFnkh/ThH4sfTEjXcooH3Hg0ueY?=
 =?us-ascii?Q?g/hlBuN+pGRztf8oQUKg2m3T3nyRF+MsPcndgPbOtem/87CcpgasGavB+pbQ?=
 =?us-ascii?Q?S+1VtkWqprxPSuQozLMztO539CwEFVToSIFMcI6pvd/qBv2fqQuNpS/2uNrl?=
 =?us-ascii?Q?Ad/xmuGM8MD3NBNuYgao2DW2x/0HJRT2q6KIXryECgcOeU9elV4QbqEDLmwU?=
 =?us-ascii?Q?s3AsAfEwNCEHL63CNSAf6TY46OA5WiQw0oJ7PUCVGdl3bmCB0C6H8pgONOJO?=
 =?us-ascii?Q?j/xIfbvuMmXibD6+GwEt/PfnE1DJgg6gZYw+2tbgLWYYTmgR1e/8YTW8O4rx?=
 =?us-ascii?Q?wS1hJ/CPHTy6HuOD3a0ZswQzTiGABqJDvXvM3WbI8PURBcy3MjmwcEJuz2JQ?=
 =?us-ascii?Q?DrwX/DYhQZrnpvLxYWC8rgQ2zkU9W49WOQpSc+ZU0ODdowkJ4MufrwyfDsQa?=
 =?us-ascii?Q?xuNMxHZ9x/TOwYCeV3PcRyhM0cN3N2+QWukaV3bFfCNVPOh5HdhnVKv461TU?=
 =?us-ascii?Q?PIFbRGMitqmmmCbcsZ1XXDh89LkgGLOQMs0OBgfnKzQkIdPGItDNBMjE7he5?=
 =?us-ascii?Q?Quwyxb7Nf/YtAxHUhWpe+pM5WMfSVcdokipeut3eZ/c4ybrZFkEM54kTR0eb?=
 =?us-ascii?Q?5V/zzPAzn3yF0Wf9GFLtXqJBAnIqSVlbjN97WMUu5bxUjZA9Ci8I2+iTdZMl?=
 =?us-ascii?Q?6kBNZFVK6FGTeZMRtC+APj5rm56v48KVWvCXbtgW86/7qhZMZT/1TbAcGzx/?=
 =?us-ascii?Q?350BSXjq/vwxJgDPwnI4BCSAotZ+p2g5nXkcvn3qL5IdYC2/Njfc+BzNdZEn?=
 =?us-ascii?Q?JghjLzldzA9d6whPRbU+sISGTTmYdFIR/33x08Hll/U+2unfTSF+UR+w8baW?=
 =?us-ascii?Q?HT1xpfa9qAOdPNNJH0hjMp/7fSQKkjNnK4ZxHbRrpnFCLIUcL3lYd1I8IiZB?=
 =?us-ascii?Q?s17OnJH1irPxUawx1CEPeI6u4jmF7fjwTJDxWyncXOxbKEVZ9kMcOP+ZnLTI?=
 =?us-ascii?Q?YrubirmNGhlnI8cPlydp45yT7L1ADkKY8SFp4IsF7qZFaryG4EyB7pcFzvVW?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2tSFYy1j+laVGlpuM6pwiAPGifxNQAFua473b8IcOrxB0ndpm+GfI4Nx/vsKIgk4BTtf66bUdKDxPythObuWbdxTdaUP/lfL7mVepidKihuQmZN2OdMsXiCpe8HkvUONFF4QBV+ngmicj2mhshAnH4HFJ/MeCeHeXmaVxoxNk9aiDGsc9PlpRZcr6MvMFgSeHzergdUlpMiSK0x5tLOmvzRaZ2kvrszoN3HlA33syP8udpt+F+mseCiLl4yl1bLx/Sk93u26iY19AXTAQgr/QoxYWeOfHubafOzjTWLyw0p/PB34WN+nJs2xEMXR9MQkP5Z4xVq6rYnDjlUrevQWBTZrb0NhHP2GtX9M4eDp0fAH0syrJoe/jRE7srOE2t6K4v8hywzNmA33XxpivxZUoNOOGkgn2St1QSAU81yWtvHY+pQ2MkSyGiP8YiiGfDLzoaEVSQciTeqBAjRcrU62BvjkdrnTVu39ezsIXrn1cI67eChFc6WopB7fWSWhGwA3lD2XPLLwcxCK8PiIDY7nqVu1+MzVWCIqT9XHXP5oin7jokF9Ueh8LifhUSDeMcW5cnANCcNR6oTogyfq9RcVq7EBCcp3La9pR3StVDWokyBXbJb8+0OXvcT3u3tjIlPjWY39DjafBIZdvOtKaDg8Odw4+/fU01Ir3uSfwlAjjSyr4nn2kNLR5d/jDZzRJ5H2Y3jheKNWCUlZUGho+T8wwBYREPAeX0LfL/2KRRzxRqMs3gpBX2hlo1Sdkod7wU7jTIjgM6O0rXmPjA/MBpEyYRzKLJwAdhlAE4r9KdPaAas=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab3ee68-34c1-4b9b-d91a-08dbd952b472
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 14:15:44.2208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xL6gUS0mtOvG0Nz7uI07hdQyMG0mK5xQ8jVpRKutw47424Dcxnsw9u7Wkui/zrx9POZAeXG63KJ+17gER6lpKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6127
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300108
X-Proofpoint-GUID: _enYi870Plh5W_ISxbosLpbYCEqmkT3A
X-Proofpoint-ORIG-GUID: _enYi870Plh5W_ISxbosLpbYCEqmkT3A
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add this test case back to the auto group which reverts the
commit e2e7b549380a ("fstests: btrfs/219: remove it from auto group") since
the previously missing kernel commit 5f58d783fd78 ("btrfs: free device in
btrfs_close_devices for a single device filesystem") has already been
integrated.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---

v3: A split from the patch 5/6.

 tests/btrfs/219 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/219 b/tests/btrfs/219
index 3c414dd9c2e0..ebebb75f4b1d 100755
--- a/tests/btrfs/219
+++ b/tests/btrfs/219
@@ -12,7 +12,7 @@
 #
 
 . ./common/preamble
-_begin_fstest quick volume
+_begin_fstest auto quick volume
 
 # Override the default cleanup function.
 _cleanup()
-- 
2.39.3

