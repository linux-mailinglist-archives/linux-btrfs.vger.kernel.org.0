Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DA16D6605
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Apr 2023 16:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbjDDOzs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Apr 2023 10:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjDDOzr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Apr 2023 10:55:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194CE4487
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Apr 2023 07:55:36 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334Dx9CZ004348
        for <linux-btrfs@vger.kernel.org>; Tue, 4 Apr 2023 14:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=8/r3c2eEDHDTfs/lB1uV4D0ff86+H6mlR9e8ju4Bm/o=;
 b=ekgfTI0yBGoAtKH+esqHt9ZhgeQtSkUrdQqvHgb8f5PX69yj0Flq8xcUPgX40YbdHyJt
 dLs7S6tac1Whb1w9zZWS3bDQRanDeIMFDN6Y9xwkMYjygHO0oTeMym0tDB8YnTUWveih
 UzuUe3PGir7crDQyEsQdJSIJz1N4LYoGwzAMBuEL02ZsG8Ef6c90F5A/yF2Cgf5t8e+Y
 UEenvtpblIqTbNPIhE6RWH1zpVDKh3sRv8A64rTujsnUA8E14jIsuepGVlMCo5Fd3L54
 +4HgVtPRa8sOgIle/qQBhkO73H4nj3/rhdwsmJwUV1qywG0NaCZvgCP4i/pivUzZJoWu cw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppcncx1ck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Apr 2023 14:55:36 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 334DoObM013415
        for <linux-btrfs@vger.kernel.org>; Tue, 4 Apr 2023 14:55:35 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt3fymjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Apr 2023 14:55:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0cxwFyDaSAMOZdsH0XQMpmUXVFZj2OfqAskNlx6DDWnXXA2Otsi1Uww7NWpegdsc+R+DLGF7+FKhLhNkpa+rRhofPitbnEN6INSnU4hvfIakRCcH/NKgSLbDNZNcco2v/lXPbAwwYB4E29zc0rN1Kg4Pda9AGPONv61NN7qqtV3VIG0e6Fggu89doZswa/I8jv+oTflAVLQKSp5VdbEa6NWl1KVhFovZj3z4IeA5upuKnWHSeOomWWXFzhzX1Hw3HBYHFdlFmEQnmQ454J743kS3f6lTz4ZKIkqNnYenGF5XOw2W4RX31yuoJLUZGSccMAEw5wPpx9hG0INRSaKiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/r3c2eEDHDTfs/lB1uV4D0ff86+H6mlR9e8ju4Bm/o=;
 b=n9DI/qLDNbdRivyup9lqU9tQrbjcmW6O0H+29aG+gLAJo7BGdKD4hW3rNIWeTy3+lXKAYuq2KdySBYyAS23lTbIPlZy36bnl1b3EdDnyARtT2zkeriHX195UvLEMqq24uhFYBHJDuSGFGz1OKZiFQIs8R1sAKnFez4ud+kLXo8K1yWXj0blmZcBZhYhUaxYnV6iWA0tHlyzLEFHhK+D11Ion+4Od+a1AN7oSAN0sL8qtnn1C0rm5XwBLXFpcOmoUZYpFgfpksNJxB9NL539sI0YazXCu8fnGw7RunR3bcRu4HvOn/XRjxlpxlTR0+vro1XfMxLjiEsgllbhf4u2dIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/r3c2eEDHDTfs/lB1uV4D0ff86+H6mlR9e8ju4Bm/o=;
 b=yHUN3CY3d0VKuMjSZICfTq3ll8d3sQlavXDj06ZswA5+p2Kh7kCyDfFkeigUVZ5bi7sTpyTQW1shxT1LegA8+DRW+XzqXdJng2k9zwHlBHjUMo08CIuPl7NVYXnRKrSjuwjffiIhXFgXrLCE3PDWHhrC5a1jrU9WtgZLc2f9Wb8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO6PR10MB5790.namprd10.prod.outlook.com (2603:10b6:303:145::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 14:55:33 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%5]) with mapi id 15.20.6254.026; Tue, 4 Apr 2023
 14:55:33 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 1/2] btrfs: warn for any missed cleanup at btrfs_close_one_device
Date:   Tue,  4 Apr 2023 22:55:11 +0800
Message-Id: <584322021db1e182838b5dc9d90459850e5fcf36.1680619177.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680619177.git.anand.jain@oracle.com>
References: <cover.1680619177.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO6PR10MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: c91cea8e-7cd0-4768-db18-08db351ca40d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xIX3LVbQiKTN7OSGD6xTDpK86DxG0UIjQFKOioxWKRtp46KiAJB1JEqxkJ90dW/IU7cx8HfKAhNl3ABISk+e/uWOgb87G1B/GvnaSneNsOLGQ2wVOSCcKTlZTfAXvwRsG2hztjg7ZTgZHtdAp6U8BTmQ0qkYgJnAeEjTk4Fnbdf0UbL9c+YeiElWz5gtpepxESgLSphXeH8qhqD9oXteafKLUdJUFhe14Ay/zMg7rHBTF/4q3zBaE4wQH1u6q4DHTd5pgqCwWbxewA/fc3g0myZk6rHRmEt0qbZsidgjXDnAJ9Dpns1EXJP+OJkWZuAyUkJJ+O6RSGEDe9IVQ3YiRE31cvS+BeQhn+YxnsdBFZcD2GcokcVD4A6aNeB+t+CHLBka+1aSHMPClkdKfJqGgHq7ywLF98ehWZrBu6b2yxilmwy4p+9c9ukZqzddv8FpNPW6D2+WZ7zMbpF2W4Obx+1GFaYTFlFsDjhkmZ47Dv7GgOsxIURPOVFI7P79GibDFkCw5crYm3R8U8JooM43zKM9hhnqKQY7mO3hHJlptXS8Lhd1C5HuxIUubX2rhtBc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199021)(186003)(6666004)(26005)(107886003)(2906002)(5660300002)(86362001)(8936002)(44832011)(478600001)(66946007)(6506007)(316002)(6916009)(4326008)(6512007)(8676002)(83380400001)(2616005)(41300700001)(36756003)(38100700002)(66476007)(66556008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AcU3v0XiBP2WkGUrsIksmw2csRfYfOJXvyjkUx7xFgQP2uIO3YwPPVooaEW0?=
 =?us-ascii?Q?mh6eFINnX6qcLppj3QbJgzzLl2fTj7fnZwioH9onIo5FjDZYHx6ggYh8/T1K?=
 =?us-ascii?Q?EDUmRKIlJmQQ5c0X2rqysCrGth9DCnjtB/umfktLsBlpVUChjYQbKWpsNEsW?=
 =?us-ascii?Q?t16hME8wC0JCXJINRPESAcNqjQAZCVKNkKHfFvPuGJpSmKKlt8es0FwgzIT7?=
 =?us-ascii?Q?mAaD3pSsqK2Ia2e7b7ZWWnxB9B/yR6ECIzQv8fSEBJZ7mn1VMbX+QFBh34cp?=
 =?us-ascii?Q?jp0jmEBbTaFGZ3sOmoay/MDIIv9qhnz6gpqYWRXKqiUKq/Z01xJGsOZvW1eW?=
 =?us-ascii?Q?KEmEIBln6K6NZi2oAazbvq2OBkAk+yUhPR6psRIjUxuWCbNGaHXGdNSgtg9U?=
 =?us-ascii?Q?s8wMJuBOPdFaON2q4pXk2JiIlVoadmpuEVeyYtuK7ugqXQTjqpgHRIyEYLAi?=
 =?us-ascii?Q?WwkJw0aMfOSi6fLVg75FGukvPP48DCQc58YZNDhli622NUj7w0dosdS1kZuw?=
 =?us-ascii?Q?aVfTMP8Bp138X7JMIYCPAhvHKoc33aDvHcbaPcMijJcoItU7Bh4xqLZxk8U2?=
 =?us-ascii?Q?RSNAdONJXGOzyd7rg6+yGPIueNGJv/lvUH+FBh8y9BGPBNfir7D/4CO65FZc?=
 =?us-ascii?Q?OXXQKo/i3WGCi3SdYzR6kq+WCXk6nNX7bgiQ1PLeEaYVmUaMNYMqaWgCemDa?=
 =?us-ascii?Q?mD4wH0cxp357nh8q+kPgOQVRcq7TKwV6wAVDf9L+T1SX89mHXZe7l+a0TKv9?=
 =?us-ascii?Q?CWyKA/Yhv2mpounkzMxR1WZnQDKOb2vzr6BEnww9xAu73UZmrZo+hRsehXz2?=
 =?us-ascii?Q?z1oK6TqVRo+uplBDbUAL1wn/lR3YoyVhjRQ3PvjBKRW7hXLQjyvo/P966ed2?=
 =?us-ascii?Q?/HN9m6LfJKbZaHmrrY3hCbyZypQjMjSVb0PCSn3yECnPCB3vpFd67iu1Z4cH?=
 =?us-ascii?Q?r3n6BhO7UvpPlIB+df+F5njPJLOtVDh5RXODJxabasYKp9Wq3z5P7RK/n9KD?=
 =?us-ascii?Q?HFrnkEHgTDfHxByyWJy8WkPapCqJnh+hfEmp2m110x+WNS9AADjbO8fjjY5Y?=
 =?us-ascii?Q?nOAkyjqWQEHdmQ26DNk1bs5gakQmY2PVju1ULUmfdT3UWWSQgQpPjUbcDIR2?=
 =?us-ascii?Q?GGmRZfathc1YNkljfgpGg1Hvm+ua6FpKFzWMlFL39yM8LCAaWw3zjWzPVI2f?=
 =?us-ascii?Q?HivkwtI4WyIR+oTepVJ9qq2aWivSEzVZfFbYu1HA5z1mqcoVQKF59t9PIwkz?=
 =?us-ascii?Q?07R/IvXSUO0UUKoTZwXpYUFLx3dy9z1ZbjYrJ9r5fudh7g+xLKg1eRirMCss?=
 =?us-ascii?Q?PDTW6EkJVOeJow/3Q5x2fmKwYlfD6FLFRW3C1DRbDPauCCdB8hQpa1IN4nDa?=
 =?us-ascii?Q?tTRs9cKB0YQtdp69i72Ts5R7UTQNhNgnlu/WznZd0T1JxQFI49NSO92z3f/E?=
 =?us-ascii?Q?gWKGK4K3S2aeYfd4qmY5H1DNt8UpHkuEedtnOXJsT2OeP8NVSueKMvWaBiXV?=
 =?us-ascii?Q?9sxqgmCGFf+l7NcDjK8Cq5N/25TeCC0hkZB136W6YOCxhOAqLUtFJa9/B7Ov?=
 =?us-ascii?Q?u8YNfdJeEWQtS8O1le8AC0HMMX4/TeYxPtNeOAKe?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: X4sfUEdFeIP5T5HwK9ZuTXf7sDZqOHKhNJaNTzHQpBCaLVuC5CH4wj6RLDDjyBKdTz2eURyddfhqwvF01Vci9woLyeVPfuJ71XKfyr4TjyUSYqGKQbwOBg5JiW4hmN6Gkrkq1AqH3MPE3O8xlbjSSbZcMIUMlvOXTTlJVK2Oj3gVBTLJ/mRFjhR7cLyI1UlV2ef4LBb9RCpxCXoCAgfTqcJC3CF2X8YTIz+7d2UqiIZGKrmtZ1HPRPo2oybjMwXUott4CTjx9x2lFTyxvi7eTySsttOg76xx8qRiAcD84EgR4BVKhx39jmjFgTh77iAWpqjO64OGoxgcZBwGlf8g0c23UQ0RN0zzI5llK//eud7Ey5IkiAi6XCzDXe8EAAUzCiBzDUx/okXryE5ZkF3tUQXqqWBEOTDvfCgRnY8Dftd8qL95Bd7mM7MINIozPH80uMCZboxxLQMrZT5572GpbqLgyYU18DaNExQ9d2l0/GuLpGPAI14LOdsJNxMMKTdezxv8clYar1iqycoLCnNUp3IUvqb1dzhqLDcJlsBK5QF5C8ifZKP5491SAHapfIFYHFmG8La8Uvi081z/kn3b0ZavZrlUQRIDTwnw6FdxbwBpdDAIaaQBG3cONhrfvBrIbfixsTO6Rs/gQTCo7cRfQw83hrZZP7reSZUoI87TdVPtS7gY70HhYvioS1zX8M7bU+tKTpRoYF5pseMMmmhHpHE0EDQVFnPult8jw7M9lKBmT8H2CfusT5YgQb/RBgpy
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c91cea8e-7cd0-4768-db18-08db351ca40d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 14:55:33.2566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yG9rLqSKbFbGvzC9Md8Kw7B1o0jWfituSAoVGZ1b3fZ5pAN9SvOAA4uvQDBlk0x2mncW4m+bkdt9+c5xbed/sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5790
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_06,2023-04-04_04,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304040138
X-Proofpoint-GUID: jS9AFq884g3LLOqftvOF9cNNR_rgBVWn
X-Proofpoint-ORIG-GUID: jS9AFq884g3LLOqftvOF9cNNR_rgBVWn
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

During my recent search for the root cause of a reported bug, I realized
that it's a good idea to issue a warning for missed cleanup instead of
using debug-only assertions. Since most installations run with debug off,
missed cleanups and premature calls to close could go unnoticed. However,
these issues are serious enough to warrant reporting and fixing.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index eead4a1f53b7..0e3677650a78 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1150,10 +1150,10 @@ static void btrfs_close_one_device(struct btrfs_device *device)
 	device->last_flush_error = 0;
 
 	/* Verify the device is back in a pristine state  */
-	ASSERT(!test_bit(BTRFS_DEV_STATE_FLUSH_SENT, &device->dev_state));
-	ASSERT(!test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state));
-	ASSERT(list_empty(&device->dev_alloc_list));
-	ASSERT(list_empty(&device->post_commit_list));
+	WARN_ON(test_bit(BTRFS_DEV_STATE_FLUSH_SENT, &device->dev_state));
+	WARN_ON(test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state));
+	WARN_ON(!list_empty(&device->dev_alloc_list));
+	WARN_ON(!list_empty(&device->post_commit_list));
 }
 
 static void close_fs_devices(struct btrfs_fs_devices *fs_devices)
-- 
2.39.2

