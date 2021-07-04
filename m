Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAF03BACFD
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Jul 2021 14:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhGDMH5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 4 Jul 2021 08:07:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:4376 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229614AbhGDMH4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 4 Jul 2021 08:07:56 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 164BtoX7019794
        for <linux-btrfs@vger.kernel.org>; Sun, 4 Jul 2021 12:05:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2020-01-29;
 bh=PdmULkCvQIWcvPT/sWaAJ308rtLuEaWoYQF6EE+9vow=;
 b=CCtgnAyLG3vyuiF/2N0LvBGFywlEK7g0JXNUhkMOAhZVxu9oAOrI9G92VDA5X6PujOsJ
 AiS5QC1d4dm+vNAYdekmms0hjbQqV2gWl1PLGR1FiiZ/y5axLrnZh3ntSvfarCfN051U
 RcdqhzPalg5zL2rhXWlk8g1K0nuM92bFr26frgqsxCk5fXLExRvMozVzYOgk+Q4X1r5E
 QAuwSTJMmwv6cf1OXmIqSzopu8llkH/NBaq9yMJaMy/mcRoU2XhMhi/EbBhypod7LfkK
 WMrNHMF8vn44pOUFlvYQyvhqKBeL9F7wB0+tkTp2WpnoSlHH7EEAF3v9Xjo9lo5S6gBj Kg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39jeg1h5hc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Sun, 04 Jul 2021 12:05:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 164Bxvlr193397
        for <linux-btrfs@vger.kernel.org>; Sun, 4 Jul 2021 12:05:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by userp3030.oracle.com with ESMTP id 39jd0w5wbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Sun, 04 Jul 2021 12:05:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwOHTQOgbz0DCr4jaV/EsxA+W2N1Hy88yq19z8bN3dIIsxb+RSMM+AMwkC+2b64DPql/8a+BvANJVpSrca9DcLXWWhDcuty9A7S17FUKNocNNWWJXgIakU08G0YyxeIjrBVM5HUlb1FrjyRHOp0l7Jt94xK7aGJiWO/O+s2RkjJW56lFVkyi8HrYFfQ4KKDMBW8zlAIbBkxrPkEa94YBlN5ELPYQGMQnwUMm4XkymSdjfN4+IalXbGOna8SQGbdB2GyD7+Iasyt5aHPx3L0i/aAboDGU+3b+eFXKmTb/bepaVwR8nf4/oRbjnxh7cboy7eKZKj1mp9dAKRaaqjLa/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdmULkCvQIWcvPT/sWaAJ308rtLuEaWoYQF6EE+9vow=;
 b=I7tnr7Bqr8LnKTzWjs8BoexOuNUic0VkwOYg6XrqvH6kT1+6bK+Y8y6tW60VOqiayzM/K6UzLR/XNxR4Kngp3HTFNMx5zGBa8Q46cQv86JviH1GIeuBEEjE4aj/VU/rlVDuLs4XJCDndsr4ySUc5roOm8RCCNuqiFv/c8Y9tyzf2C04qzhfSgtVzmgmVsZ7kwtWDlcJX6kSXXsICTn2jocmTV0ZWnOHIWWFX1P2K0tShUV9t5t8Q4+rkPPsICil7sn080CBGWfLgqa0BWAXGYSeUOIZMVWR+RP3S0sYSzKBgp+04y+oD5zNm/n48d36MPDceqQfHfKOYFoeybAPz3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdmULkCvQIWcvPT/sWaAJ308rtLuEaWoYQF6EE+9vow=;
 b=oFMbk/qFmKFarqTnoB0g5iNSj2GUi1VnmiKPJCKMyNXgfFcdwZtlIjX3LQgNxTPHKP8zOPEv5GAWGw8U4FNubByDEWV+209hal2bVfwSQfRoUQRuLKasNVfxMo+rYqkbFJjuglqmA1AINryFelmoU7xaDAsIUk3k9V8RXCsysi4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3901.namprd10.prod.outlook.com (2603:10b6:208:1b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.26; Sun, 4 Jul
 2021 12:05:17 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%4]) with mapi id 15.20.4287.033; Sun, 4 Jul 2021
 12:05:17 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: change btrfs_io_bio_init inline function to macro
Date:   Sun,  4 Jul 2021 20:04:58 +0800
Message-Id: <0ae479ebdecf5501937b5d93449a782d96864cce.1625237377.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1625237377.git.anand.jain@oracle.com>
References: <cover.1625237377.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:54::14) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2PR02CA0050.apcprd02.prod.outlook.com (2603:1096:4:54::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Sun, 4 Jul 2021 12:05:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: debb64b7-1850-48ba-9f9e-08d93ee3fce0
X-MS-TrafficTypeDiagnostic: MN2PR10MB3901:
X-Microsoft-Antispam-PRVS: <MN2PR10MB3901DDE5981F4D2223D3878AE51D9@MN2PR10MB3901.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 90XXVK3dU7ACYlmtn7zP6FXq+bTebbTgfO0YBNhMkPaTBd8MX0Z+RIhvG3lCGTHNqc9NY+lco72YUPyCI4006xq4Ovjgy1s2ijuT2+ErpSkPBQlmn5aiUv2Kozi6/SwrYUgOUxJadzE9V0dzBvqG9/oV6mZ+uxznlyFp2U0DNb4meJrlru0mCA0XdbDeMA5Umpi27gqYguS9S1ZEPqzhKVKjJEo+EROw9Gra5zM/ZpMCZkISdCkdgthgFeOydm/41wpY2nbdsejSyc1kVcpRSTbEBYIFmHY4YMhgM39H6btCN/9sjTKqlU89PTCzrAB0GPly/SJfg9nD79Z892L1HE1hQlLQf0hwdDN/cyIuo9JgeIB6EOr3mhKYjxwzsoq2X3WkjRc1HytrEJ23PeV4/Zm6di6TgUBJjU15k6KYFcZmBsmojjs7x8+mi1vPlzqknDZNnbCR8XZRMwMpRmV7oJTyIhUA56cteder/b2VigRYM8A0FGu9lx87NnWeczQ74vF61Bta4ubfTHr4+yw+vzGI89tindRXnx/+G5GRNaSTwCRqTXGW/b3uPh1pbDhQ4cCgePDdVx1DK/muM9ckO2d8gsnoejsPlCruVfIegx25QvP9spy7OFCmeXWfooAqtgy9xwDQrRHscFbPvG4Pt/09u9brNSQyvo/yckIgBOOipYgImmd4l/0BOs23KfYt1C2HOpWa6M4+ChDFNbkWusaiyQnUQphSXP0+LePpdEkVd28OO1HMMSA0fnmG1m8s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(346002)(376002)(39860400002)(6486002)(6666004)(83380400001)(44832011)(38100700002)(52116002)(316002)(8936002)(5660300002)(26005)(38350700002)(6916009)(86362001)(2616005)(8676002)(478600001)(66946007)(6512007)(186003)(16526019)(66556008)(36756003)(2906002)(66476007)(6506007)(956004)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y4QAI5FRXmJwDCPkfZtJ7DO2JSddPFEOJDYA2wyo9j3UjSd4W8iQ16LM8lXf?=
 =?us-ascii?Q?U1d4gTLkq5iVGVoztG51wkwQPx0W7k6DL8lvwdWwLWnqIH12P6kgB985y9tL?=
 =?us-ascii?Q?JMCNgHC4sXI7lGkG1zLGgToTrfROrE9FydW4ACI6yWZUVFbHadALcv82TbKt?=
 =?us-ascii?Q?spbubcDAcHRtbyMUu3u8WxBbmJxM/LxsH7WTmsjxOY4Ap98mrx9U6kU7qd1K?=
 =?us-ascii?Q?DkXdqUm1qJAGm2kp+LwPbRpSPyJkc8ovvXFPxEW52gRPCNFX0VpxXGSvuzJU?=
 =?us-ascii?Q?L3vmm5AGmYXxKV+ckxg+T9nrcTh5Wcuapt8KkDfIxQYmJLy7kuOTXKEFgpvz?=
 =?us-ascii?Q?Kw2ngvqGVsvYVK9tNk+7DuRfdeYbuOta5oQfHK/UosKmCN7wKOwk02mvUv/i?=
 =?us-ascii?Q?at40oLneWy47yXtti64YnbcJU32gI5czHniuP17grGl8W3/ROoUxOWauTWyF?=
 =?us-ascii?Q?ggScM1X8gfIMoCSIciBCbhicp/kmUzp12HcQaxa/1Fop/r/RwzoKXYZLO8p6?=
 =?us-ascii?Q?YKx7zB2OB8mDXdDw6DtyzxqThXx7mULuE2fMddtNgTldp7ozmnv8741SFY+d?=
 =?us-ascii?Q?maF8Ie4CBcDAkpXMurtvzwYzUSDjZS6e/JagiQMlrl0wL7oZ/bF62kAjMcQA?=
 =?us-ascii?Q?jwUcuYyWnjkyZIJ6y4R5M0YX6qE/6hzrMvRkhuS1t43jmAxCgECsLPlKrZaw?=
 =?us-ascii?Q?oHmQIPnwuqzidMLSxf5Ttv+27reS7uMsQYaxo6Dbo/SjYFJSdpwoTIYIWY1n?=
 =?us-ascii?Q?T8dufsg+tNCjTB8MqEffu5nDMsvQ6x3wZutKv9s8Ix+NGUSh3JnObwxJF8IN?=
 =?us-ascii?Q?XCziYG1eGSPgfiPw4E23YBHzdDNMug4xRLMeU8iLSqkp/cw5vD7fZE1a9hGg?=
 =?us-ascii?Q?gyRJmsf+jlSw/PZ+FmSpkGeiKhkpy8Yt4GZ74dpve7DFLtSEYzR3tUF8gmM6?=
 =?us-ascii?Q?5n/F/woRfJn4pydmnNj7pLmp74Ar1n2QzFrFxQceWuRIbD1M0QxSGQVWFy6/?=
 =?us-ascii?Q?lXeWYNMO0HeDdFf6sf2VUujGHnc3wESArw/BEHOA+HeqEBIROcghpq9l6Gcy?=
 =?us-ascii?Q?cPhBQlP1wG7D+/pUkLI4EfHRReln3fp5Jl5Urk8zJQytUBHME7XD8QKdRM//?=
 =?us-ascii?Q?/FIT5az0UlYQMxrwXLdmNQk7tvD5nbAQrAkjocOaByW+F9+zaHg/bj1oNsgW?=
 =?us-ascii?Q?7gT0J7jTGjSTsVFDtB/rI33TaY3PXOwhHZ/COhFNmZk8P3N8gNBJedTXy5gH?=
 =?us-ascii?Q?LmR+dgLXMB5pQ6/M9CkR5eUhTTibIb7/5LiqNzx9wKr1HeUlzOKxnzGJmnj3?=
 =?us-ascii?Q?MayI0asSA00c237Y5gbirJH8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: debb64b7-1850-48ba-9f9e-08d93ee3fce0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2021 12:05:17.4397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+gzFs/Z02e03Ssrrc/60OHgYYFb1+PeyJ30HfZv2sr7w9P1YPxH2bltzdmdl4n6iISJ5NuAzxAslj2aDaNoWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3901
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10034 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107040075
X-Proofpoint-GUID: ar83tSzlJnVCan1RIED09yNOfiEq6zdf
X-Proofpoint-ORIG-GUID: ar83tSzlJnVCan1RIED09yNOfiEq6zdf
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_io_bio_init() is a single line static inline function and initializes
part of allocated struct btrfs_io_bio. Make it macro so that preprocessor
handles it and preserve the original comments of the function.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/extent_io.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9e81d25dea70..8ed07cffb4a4 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3110,10 +3110,7 @@ static void end_bio_extent_readpage(struct bio *bio)
  * new bio by bio_alloc_bioset as it does not initialize the bytes outside of
  * 'bio' because use of __GFP_ZERO is not supported.
  */
-static inline void btrfs_io_bio_init(struct btrfs_io_bio *btrfs_bio)
-{
-	memset(btrfs_bio, 0, offsetof(struct btrfs_io_bio, bio));
-}
+#define btrfs_io_bio_init(bbio)	memset(bbio, 0, offsetof(struct btrfs_io_bio, bio))
 
 /*
  * The following helpers allocate a bio. As it's backed by a bioset, it'll
-- 
2.31.1

