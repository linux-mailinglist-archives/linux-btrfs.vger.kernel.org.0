Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18DD73DC02
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jun 2023 12:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjFZKHd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jun 2023 06:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjFZKHa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jun 2023 06:07:30 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2090.outbound.protection.outlook.com [40.107.117.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED04811C;
        Mon, 26 Jun 2023 03:07:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j15m1ALPUOeTzIw3KSRTGYge6X6jwEOvspvpAXvweOBfpm86TLpm2mbmGP959BfP7mUMEuKXdi7m3Ene/XXB1B92PU6xjopmTEQQiZxuI1D8Vjkg3GBGyiv/MRs0Wo1Gas7GY2PxPksX7M9B/We5W+B1zsHv2Xg2JqmfdX3vavdX0pk6Fno9wT4cLngUvRbdP4HgVWTlPSRWSzswNfJcEyByWoud7LAbgR/mYC14IwcOuo27/wF4sVZUsE+abML+xvP2PBRXJLlwGEvwqI55el418XgXupF9PjNa6c8NGPHk5bAA2DQj3tSouwO+5ty32b+DI6wQarnfmJCtTBZI+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqmnioJ3vzotlIxAdjHlpXNRzAHZFf9ikm1RY9ddu+c=;
 b=Md2IUVA0dgzYz3YVsOH9idxkFvKBwpOqMZXB9rVjSzjrDfRBBNcWiM8kzPn636/biCp7QwU6pdQqHv5BmYYe9ru4Z1jVU29gPIeOdcwmZYIyNcvry2GTdzyAhs9EFyap5EJjeROrWHvDNHmKsMztCimxOQE/OJIzn22dPve0bF3oYH5KOAjk4rcaX/JhrhWhshK83KrjUawWs0weX0zFLxPU+uk3+KWf3fmcrGZD9wJ3dRs8VN8uI3njGZB8ArwDVBNMuMjjFp+NBFUWO16GYvQHXXK4607nIaQSno/QCIxVRsAwbWYXk+SBlhmJ1Z7lvRFPkv1gId7VoNasH3m5sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqmnioJ3vzotlIxAdjHlpXNRzAHZFf9ikm1RY9ddu+c=;
 b=HEFZO+7KFAnraZ+30va0siIX/dgedMOhkUUuwmCc/wwiLJfBaBArZd2ptLGwsm87liucMH5A+6mF5wBtDRYky5a3JecB8A61Xwrv7MsCed6hx1OFGcDUn4jTpQ7Gax3E9fV4bnmSWYEOyJe2hCMZWsAUo9vmzAIu3ArjNVqUbCC2FjmcLncZA2OwbiRjHLGAIE9Bg16+LpKgdMt4Alyfw9Uv5lm39OePozV7x5ri4m681Rt2VP4QZfprLxkhcGh36ci9CbfPQnlEg1glS3/KiscmIOZGyBNvjGLkcjqOSAC39qbmZXRBwG8dwI0/e08IjbxMt6/paRkHXtka/14kNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by TY0PR06MB5755.apcprd06.prod.outlook.com (2603:1096:400:27d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 10:07:26 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e%6]) with mapi id 15.20.6521.023; Mon, 26 Jun 2023
 10:07:26 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: [PATCH] fs: btrfs: Optimize code execution process to save time
Date:   Mon, 26 Jun 2023 18:07:16 +0800
Message-Id: <20230626100716.18935-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0046.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::6) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|TY0PR06MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: 1624f149-b1c4-4d59-204b-08db762d2454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jhq01hPmk4Wim8qPwv5JTzaNnjybcGP7ttH7EiJUkqmE/D5DXOmV/klCAnxDfyXZh/V4QrYVSpaKTV/UvW0ZY3Xm5wzPjaQgrPlxIK8aD1jrcZWz5K+MN/Y8kkGM+cALnIIZ/L8jaDXaOwCPq83b6Wv6f4O2ijWm8S7Kpn4dpcTDXSrBO9y69dscFLiwUPP2NiAkWxUhnEsee5XhW28UZnmkjykzeLoeOtMFaSXMd1Y0aKeHgjhdJGSBtPKtduD48AOyQJf/n73GnujG5MvSSqOtgEKEavQNFdcdHPgHPdszCbHT+tkyc75JcVsI/MHRErZVHozMgEo9JGZeMsFX+g6GREvB36Wdax3Djv04UtGNYhNF3StqX2zPqF5hBPEOUEWi2TGIDQaUh9OenNNQeuVgNhDYyy/hlPh1l2MJItJxvgi4qT0TqDPYSzxBk9BUDuyq6SdoQYZD9bIHfb/CHKeNfpH3T5h23c1ed30aPIX233PfsJGO+4hdCsz9jR8aOU4ut4qDJoqdHI03z66L+IVfKfhIztfWFecAGWS4JqJMgF7M5GAqGnH3waAwiafaXc6Am811UAWUAlz+gxHphFcdWLHdhnyT9yOvsRrrMrQICBVJJ/2FscCpgSM3jbWj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199021)(6506007)(6512007)(66556008)(2616005)(66476007)(8676002)(1076003)(8936002)(186003)(5660300002)(26005)(107886003)(4744005)(2906002)(38350700002)(4326008)(41300700001)(6666004)(83380400001)(66946007)(36756003)(38100700002)(110136005)(478600001)(52116002)(316002)(6486002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cdb+iNZNV/3GXx/DCchui25yVXuDi50qVyQulEO2kysAg+zSyIzAMapoCTrz?=
 =?us-ascii?Q?hWVNyp4ETy+JChUxI7/t476rHVlteEDWFHK2HjHpO0+Zr0U+LWNchB94shQF?=
 =?us-ascii?Q?e5dJwOQOJvoVbS/zwNE9Al20wvDWAQEnQ7NUIRiFUDHokwMuOQGThFODH4WN?=
 =?us-ascii?Q?Tu3SODwOBdXgKDpytS1ELcZsn2Wf/781vAU8m8fetkFjUvuXAfMIQVP6RoZ1?=
 =?us-ascii?Q?LgxFd0AU5c2q3kwR6rPQ+ZPQO9XPgHx/9KTuwM4Ay+QSwyFmXZsdonFaB84Y?=
 =?us-ascii?Q?ZTSrIw6Vd9kLUsPq1rMHdM/IDEAY1RWkh/OzIS2IldbVD/8hWLd7U/zFnYft?=
 =?us-ascii?Q?2trod6ahHp9eQF9afDOT6Ze+rkR0cZbGifZclCTVR0VQSiYZGl9tarIOOWOQ?=
 =?us-ascii?Q?s71KT41ePxOcygFr39rj+u9GIpa9RGMYu3/WwNa4Dse0G/wUt6xtIQwMiQL+?=
 =?us-ascii?Q?Dilmbn+R37ZOlhCj2SQvZF9qt3xltuP96Qzo8D5bCTC1Qv33rUTuytWxKoe5?=
 =?us-ascii?Q?lKL2f1AE6YxmJSKVeBQG1rZtFp8O29cYw/o6mxwYgf3npYYvLo3Sh+/KpOIw?=
 =?us-ascii?Q?mWtURwNV3e3+3Roy45DDgpaJDzjI12OzbmMbFlPG1v1nE54+zGetcg2gvFyj?=
 =?us-ascii?Q?OeVoiOfSL+DOxTRuJCUbZCNkwRL+RmvoOcUxEAGqQlss+GYgwWZjkDi4KN2B?=
 =?us-ascii?Q?dwM7DiGkphVReZIuqUv0z2BHNEV1iyjAt1LcJHLp03W/0V1b1vexUG1enQ4x?=
 =?us-ascii?Q?USMwh98mfd7wiLAPxf9pzjfavmpYHqwmZO0x1XOfL1awnP9vI7TU2EnVdfUE?=
 =?us-ascii?Q?vVJAsEU0Ahj4r7OA7Tob4Z52ZCfTLW8gY59lKl52D4mi31QoZOYvCODCLvV0?=
 =?us-ascii?Q?A+7pMzxt/YItIGn8iPkn0Vr/09L0BlJpiHnvTTcyXjJzqFzyuowna50n5+qH?=
 =?us-ascii?Q?Pi8JyKUMAiqfs/ZQos6DdJyX2vWH21jU51cXkUaGiNTbv0sqmIeSpatZQcEr?=
 =?us-ascii?Q?faD+f9Ep/DMdTIJN5fOXrg+2TYb+deb1gTwHv+H5pkqA+n9x5t5zyRWE/PQC?=
 =?us-ascii?Q?EtgGb4axlX/FOcECzrjlJ72EIwfeBVRip7A3ishqmWb10UFlAsUp1s45F1AR?=
 =?us-ascii?Q?ROPKooxZ8o9E96kdZMSALCX/sqFk+wgHfUueKkdeWw8iSjtDC/PMtKUGAmHU?=
 =?us-ascii?Q?54jTBVVS/7eoreEKu/RnSTtQP73GxIaGaGr5SbKnfN32Js6ZHevO3YTg9Dn6?=
 =?us-ascii?Q?tx4AITbTrFKUkHbJgdpPn9WiUVPAbVv6ApYXVWrfhW2qmN3oEctKD9YnlbDD?=
 =?us-ascii?Q?NjDxuoUmftgqPO0LTipNdLSt0mUxus7KaTBS3uuXWrCydz+QFAqZwkEVxl9w?=
 =?us-ascii?Q?J0gFe5D1+IaTowWP+vHr2cX5hZb3bP3egZH9kWoqquKFUs+kpyJPHhGw1Z7L?=
 =?us-ascii?Q?vuV5VMdE+s7KURpjGcjzTadDBkNXIfvP+frwEFRwOL4ESlCXsPYv518jWae/?=
 =?us-ascii?Q?mklPMksjuVEbRyL+00/Jk6YaSZYl9kk5UrrfVXw8tzIssFCBvfdmTMqMo2Lx?=
 =?us-ascii?Q?odmVR3AIy1kGcdl2+3BOSFJP0HmqqNtLwRqXvR+q?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1624f149-b1c4-4d59-204b-08db762d2454
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 10:07:25.9905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: beSyTg8sTd9dhFv/tMZCDIo4dkxtp8i43foGwSpkgb0dhrSCMVYsPv3tLezt/CvZfSbwwL/d6ajmGx8CwoqCNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5755
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Originally, the btrfs_check_data_free_space used round_down twice when
aligning the range, which to some extent increased the execution time of
the code.
After optimization, round_down only needs to be executed once, which can
improve code efficiency and increase code readability.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
 fs/btrfs/delalloc-space.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 427abaf608b8..fd33b1cf1954 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -137,9 +137,8 @@ int btrfs_check_data_free_space(struct btrfs_inode *inode,
 	int ret;
 
 	/* align the range */
-	len = round_up(start + len, fs_info->sectorsize) -
-	      round_down(start, fs_info->sectorsize);
 	start = round_down(start, fs_info->sectorsize);
+	len = round_up(start + len, fs_info->sectorsize) - start;
 
 	if (noflush)
 		flush = BTRFS_RESERVE_NO_FLUSH;
-- 
2.39.0

