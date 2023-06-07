Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A748B725B2A
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 11:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbjFGJ7w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 05:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239332AbjFGJ7t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 05:59:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC30199D
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 02:59:48 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3576JrnK011468
        for <linux-btrfs@vger.kernel.org>; Wed, 7 Jun 2023 09:59:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=F45kMKDT9qLokCtRvEO8B2rprbWhXa7H+y3DJalIv2Y=;
 b=ik+0HGDDlmI4zajvr4VOhXyBBPiKJFnTe9wlkqEPUH0og2LJNyYfr5bZWhHWEfSl2MTO
 TEwwCuk3YJyQYwccvMpYqkFVDR1owRtv80mcHsxPR0lYWhVJk7GkwcXTWW1kII2Foy8E
 VM5pYi4I//GyBy1fpfaBZyQUAaoyWyvN4OfwxkppuLE827ddwLTfBrQWULuA8UdYJWgs
 oYHZyj8/TgoXXjhNlvblGZiwIcN68pWbGHkg+5jZMP/QaQ2MbkxSwMOIC2DH///5x1AG
 h7MbPIzYNbq7lTJ49PIx+V7fuCuBwGeOodTcDVhjlvmV3Wmfa7zHp/WWRnPN5mkSZ2lL rA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6uscu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jun 2023 09:59:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3579QHDu035860
        for <linux-btrfs@vger.kernel.org>; Wed, 7 Jun 2023 09:59:46 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6r9fx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jun 2023 09:59:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRYqxsx1otp7MIfm7pZi8OuCDt0Uj+8jrJ0/B5W3/fyrcQ519nWFjeHZJSvam9gKqcqAzmcUc48dnLQtsEkHwKnQZxMK1HNn6ns8Tv7vbIObt9ofEPipiN0lEtkzbAwjT1VYV+aDflZK2Uai/i1flzME9U3nIghb2BE9V96ZS66Se37GeHo7MrX3sqb2cvCW7svLRD6ffM833pqlOOTTL5/CeRJW70lPQeN711UkVTquOEnnQJMpQ/ZMZ0WC/I4O3UKtgAls6jBoRLPZWTIpva4erz9gua4h9q9IsYPM35SEAdEb+9PmVrL/iTQsHaUI76KFTIWuziltrORZlRNBHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F45kMKDT9qLokCtRvEO8B2rprbWhXa7H+y3DJalIv2Y=;
 b=P2CMut7MueqkL9qVH7O5rKjD2o30iWP22JFOJIwnicj6HqMDVi7Ix4LfGNnWSXQNXp+7UH0JZK+X7e5C+E3DPq0fbTSFiDZAwNsEHCadQhPpOKiuAS4pG3SjtJWoKLBqrHPRj5MeMUCSeW6cYOpzTDgqGSdwHTV1SjCkjCy1tqLGrE21wX7QlxDLw08nZhNs2cZs1KevoKFMSmFD3hCfeCPwsyFNOGDdZYEZzyn/m6hjtT78tNJ0PmGfQnpviMcwKJXPfL3CEmkY5Z0fqrF5OYUyF4XO/CnbrhdTMIjoViJxbdEB2542br6jWlCXYRCEm/bI/Alep31ShhLeiVC2ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F45kMKDT9qLokCtRvEO8B2rprbWhXa7H+y3DJalIv2Y=;
 b=SpAOlN6bc6aPhWitlCg4ZRZQTGVaHiiqB/F4YjkGf3l7uYMSk5zyuRGVcz2Iv0ztl6HsOY7PLXWaJ3uCg4K1f5OuKEcCM+a1Tuujd+vGK4qf4AyFckWazcafi9kWsYo2n6Eqiz5Llwz+FkO2zp5Il2Wxj3xWyH0EcwqAoS+CsZk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4762.namprd10.prod.outlook.com (2603:10b6:806:114::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 09:59:44 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 09:59:44 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 01/11] btrfs-progs: check_mounted_where declare is_btrfs as bool
Date:   Wed,  7 Jun 2023 17:59:06 +0800
Message-Id: <cffc24438e797408730f5beba8ec53500a042569.1686131669.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1686131669.git.anand.jain@oracle.com>
References: <cover.1686131669.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0196.apcprd04.prod.outlook.com
 (2603:1096:4:14::34) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4762:EE_
X-MS-Office365-Filtering-Correlation-Id: d154d41b-1817-4362-b42c-08db673deb87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cJrsQUa+68+JDNWiLnaF+VRTVdpbQ68TRQVWjSWuqj1ST+F7HCkqUJ7tcdops8UH3mIDvHy7bbJ71yMUtHPu3httc0JzimXCdNT0B/8cbZuu+ATOG3wFVaAxmXO1unItjLW9gebb2FkUjq6sMBiJSICoG8JYYlPr7Ze1WOjgUWqkPGxJQDcAam1tkFnYFXlHxcd6HiTVXbpDHdTj525I8O2xdK3wbdmT2F01qTfJK+Z8J3NQLZrK78ks38kJ9XX3nY9yJDvOZTaSaZexVC5cyq7q6QgDOVsyXapoxLGpffbAKYx58b2UYou+vXr8JDhaJ/LbTf00JMFMwFNKSL1k7NcWekkkQQZrvsg9qP14BC3ZkMRzNpZDHByOmpIrsVmMqIOsCFse3bu5+torzILcetr37Ej9PDg6WCqSuIGleeQyqyG2KMiA7grKWFaiRUCFwvuM5ZIsEz2BJi8iUfopgbJ1nLHzJr+QSxJRTmJn0UePW0rtHJ+PP+j63OeYxOrHlfNDwICUtkPSXQyMZLMi5umT00FHstKbJAxtY9nYkmgrE3NqIY6kKj7J5fwM9wui
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199021)(83380400001)(4744005)(2906002)(2616005)(36756003)(86362001)(38100700002)(41300700001)(6486002)(316002)(6666004)(5660300002)(107886003)(8936002)(8676002)(478600001)(66556008)(66946007)(66476007)(6916009)(4326008)(6506007)(6512007)(26005)(186003)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KiAzlMe19ZaxDPmRJ0KaGxMN3xm1RJ9L5Yn9pAja96OahmXHvP7xLNcrNrar?=
 =?us-ascii?Q?2F/GpVcvKjKOmnzWNpwzG6ZNudatqf1ErDRoW0bkT8hawc6a/3DAiAbrQjK/?=
 =?us-ascii?Q?XSyhbRbwj/5rt9T6cur7e9EA1g6bkRGDNU8ErMngTlQjc9vL78YFuEodflBF?=
 =?us-ascii?Q?ls+GUT+MOzeOyVp2aSBfN+d35rCiN89mPMzJE28Vpp7mvAByAIIf94w/Eo3N?=
 =?us-ascii?Q?KJDyqawHJgXqn/AwYi8QwzQaGcc3c8nM3M7FY/CdgFrV7AyjTac1rWLvfBA6?=
 =?us-ascii?Q?CuCb+kTBLTaYet1AQqAOmqEkV1RKdT9BojFlDE/uToatRhDcLlP1nZaqLCnW?=
 =?us-ascii?Q?wD5G4dqeNwXD1eVlVxW+RGW/kYp4KwolT/drD4TGMHebbsNp9FiVB20pzUwU?=
 =?us-ascii?Q?22Uqn/kGWMCPsqvS/y/KW6HC6s8+GZGOriEsFMwlW57Oywvv1hCo/9drvoY0?=
 =?us-ascii?Q?2n6QEhOv5pqKjS4qMh6IIBjQBbLHVIlwsU1DXmCOx9zwIRYvtLsdgWmvQ51t?=
 =?us-ascii?Q?v9QB3uRGQEHS0ukIMQ/YnStvcMOZWijzhDBi7WQ23P6ogXpxk74ZTCIqtUqf?=
 =?us-ascii?Q?77IUO23855Vah3J/o4nZNAu51nQ0Zrwveo/NneSV3/AwaWs9bLNEkKsuI17S?=
 =?us-ascii?Q?+vVdVF80nrpHF9rLP7iA88Hbe5wtl9e4wRtQ0tcElKbf1BjWvulhlWDMr9Sw?=
 =?us-ascii?Q?n8uVToWdQi1xo/NAebJxhuFq3joGBicMm3N5Jigc4PbIvjiLVayouJ3r1pLk?=
 =?us-ascii?Q?QFlX0A/BulTjfxMTFqIEEOxgFSKCXyMFrhE35lhNaEVjBuBK2VGChEeIadGi?=
 =?us-ascii?Q?eAnG6+uotwC2IUxtpuuXne5T66+AAbYMbUnd4hmMWSW/bjGK219fexWLj3Q1?=
 =?us-ascii?Q?upMY6pvqIaaAR22nKMKaFieNrWfGYSWsicU/k6tCt7C/jAhnIz+oMcqam6fG?=
 =?us-ascii?Q?AMkfWc8+bhLienZ8z2upl4O7F3u4bQUa40WJuBZFzNnlENirA49RkiLSAlJU?=
 =?us-ascii?Q?c2eGWKmtRyA0V+0g6vrw8LdDrYhy93QnXHaA3f5JNZAu2fCKFq/YNfhZ/pnx?=
 =?us-ascii?Q?9JtyRa0qL47p6/Wy0xNWqTwn48ZCK0foTRn7rdQh9ZksejHQga0iAiYKhB+E?=
 =?us-ascii?Q?zAZcCWrjLYltntVfVxD/mZYB60XQ+v0+/o/ugOVYXr9N3m3Y4JorN8QKdJum?=
 =?us-ascii?Q?bgpkbJ8opdow/RZtYRd1sg26fPRbT+QAgf+3FzTJIP2UtCY4lW06fLnKXySA?=
 =?us-ascii?Q?0ygqLQmkmY35uJBGHmAOIl8c3YIDZEl0WSygB+FbMuD+/ip49++6N03Ek0c/?=
 =?us-ascii?Q?fKms55gjeiMADOIYJpqzISmu/KLxiCvuyoBZr5VqbWKs44JqslX+GjniZJxi?=
 =?us-ascii?Q?N8jXchn3EPoFTrq0GsmjFnqYqoH/Hlwo2EiCVlu8qfG3RjzgFhldW7+zUA2O?=
 =?us-ascii?Q?qYhaODggl90hV1jn0NsFSF3Mab1QBM2YTSudkgEEde/jgOFOGBEWjSLh1joH?=
 =?us-ascii?Q?qaQaoOlOcI9Ubpv/MC2UHQf+Xxs3y4AD3f27rZ9gdRVO6h9O/KmBWfzhMniy?=
 =?us-ascii?Q?8ljjXBjD1XALBud+ee/CuA3f+b3Cs5EjpZ9uxvpBRiCRB8Lkg1jTMGJFbLEF?=
 =?us-ascii?Q?+A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DcuOADeW4QF4p4kp23hTH7EJ0t1nWXZlozS9wW0LG7FxX/v3zmkYNAUQgEZf5QKb0NQCUpA2Mu8Y1f3soc4Z76Z+qh7wuLfgbwejCuPJG79IJBU1/LhN4WcrIRDQEXv/SAEJGZF5wrp4lBDsglqWTqlkerIrExwkn0n4oC6WewUWumGjLekerQMAzU2myUlUrUuX+uN7oah4P6TWgUWi3kEsSCFOlbbfc4G2FhD9msJo+xPWUaf1shklUfgamk3JrBcvkzeIV2sIGLosnYRHlBpOgJ0Lj8G2JYJqmzec9Jx5hZvju6mBv3qHE86zzqDQGwvyW6z+tjwKqeba+FnAdSxagjP0j8yHsgZOQrndtfqQaN20FvBJwgIr/sBqxNgySRjKDKVV7P/hrW1mJXk9b63MpkdygSjwER9Pb/QFaOeXakx8knHmTZTlvPiQ3coz3DsNBFG6H4iZx76xYAu7TBYQyXyQ2+UNCchb2393o+2BoIWU3v+4a/qDbbYhb9d0ueqZDo9G+U9cy5azX9Wp3czUcylfnOwtGaEyVIGkwHw+j97RCUXYVEeo4w/VeNficznSy7HOHjc6f/dL4IIxqT4NHIR2p6WckcIdKv6jczdVzsaZ0Qau6/+sesZ/lOq+5lXbl1ATjLH85vyMc4mm1+vQXSYRIAGwa3stoG5QVP0ymPEssf54IxQs1tUcahw4c8QqDGDexUpXfcoCQaCatDUfc4PhyjEfxfGN2B6tS9F1MJX242gKE2tuQ0ep18X8
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d154d41b-1817-4362-b42c-08db673deb87
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 09:59:44.6015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pHQ8/ENkUooc5ERONnJs5IsbgMb/H0HZPsabJL8mx7ytnbspR2n06cdAdLFPCDKngSL8xJgoUvvvRbmJ/bJi/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4762
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_06,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070081
X-Proofpoint-GUID: DaciZ5dBkBBRTEOgP_oLBnRDfB5PnoxK
X-Proofpoint-ORIG-GUID: DaciZ5dBkBBRTEOgP_oLBnRDfB5PnoxK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/open-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/open-utils.c b/common/open-utils.c
index d4fdb2b01c7f..01d747d8ac43 100644
--- a/common/open-utils.c
+++ b/common/open-utils.c
@@ -57,7 +57,7 @@ int check_mounted_where(int fd, const char *file, char *where, int size,
 {
 	int ret;
 	u64 total_devs = 1;
-	int is_btrfs;
+	bool is_btrfs;
 	struct btrfs_fs_devices *fs_devices_mnt = NULL;
 	FILE *f;
 	struct mntent *mnt;
-- 
2.31.1

