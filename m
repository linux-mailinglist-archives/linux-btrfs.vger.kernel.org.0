Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EC470F5D7
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 14:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjEXMDj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 08:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjEXMDh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 08:03:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAF9130
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 05:03:36 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OBx8rh011508
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:03:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=dwUevjbkhdL0sC5QDO2G48LLgZLYR4GfFIZA5GaYrMs=;
 b=d75UgIcjG1ORo1M50PBDfvwuE2QMZ5GgV0ZLw3OkWjK1pxJIdUHkLX60UAycwT1dHMIG
 A1Kr5WHCtKbSGoYNykZFvM3Ie4lnkuWOrOtHuRcxsqN1yyQBn8YvL01ptN2aO7h9sUL4
 8HfjJSPZwvxD2AcDvY72cen69m/orgGA2nhCgrjsByfbjkODIx0m66CJuqeCQY7ci+ye
 jpFWYAD69EhNNKP1z5mQun7vDikjJWAQOP5cvl3lrILJ4FR+snqfPG/+xVuO/Gcm+c5B
 Nmx7QFPaAv/oHzrgPAGDUYUvqMUMhJ8dDBTL3rMyKzRrCn9FTiUTi7gPT/6UHr5ONaXM ag== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qsj2bg0p5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:03:36 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34O9xYIr015938
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:03:35 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk6knxhx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:03:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRwjx05n9oQ1iPtSPpa2gRkff2k2lqFSeYs2tEasTv0orD1OBjJ2liw3wbQqFH+QIwEuN1yVAJJtsf1u7PORIX2UAhh/RCXrv229Xx8YXQlqgm8vfD9dxBbBf0ImuWbId5OQDWdxs27NYug7iWzRMALV2JsBANjGLS3FLrw2CJ0CV7bcRTrcS3VTncxRHAEBNnCLISYefDjXwF+fKXvWlLiWPXnSB/eylBbh+ptgOIeednZoTOKH0JM38k6NTdlNfp4HwSTH+MA5LQy1yjasykmpo7fmwHfVkVZN9j62Vf4fa6R845xpi9A6cTfPAxoSHqiGYPnbt2OOPPVhY+Sn5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwUevjbkhdL0sC5QDO2G48LLgZLYR4GfFIZA5GaYrMs=;
 b=JdT06jGcbtUk5GKQNGE43BUxJa87MIu7KCbIY/Q9L5k5JsgR8v0u8cm6BesndpLFrGnWleWDCqhJLpIhWl/Tc7OV2eVpp0sOnUh+koZPP4XZMidR7UMjrADywlcbGzVuuZ22XZL5/kqdN5wQ9G8ILd7KeW+KEhDoNWXh7443k6sZCWd5lRkFn8bWy7R3vRz7UQB7/CUtuMDE4VCR7dxa4AcMgFcGQkB3zU/akVnUYugJT5k8Oedgh2FMQqPTEdgXic5SRN82Aoi1k4R0NtNmEKqXw+wh4j0wRwoo1AeCr9jcPrOJj2OjEx3C76jIktqA6qUfhJfCaSt2pbvaVAP/5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwUevjbkhdL0sC5QDO2G48LLgZLYR4GfFIZA5GaYrMs=;
 b=YLD0mV7JxV1x5JsluBDFBIQbhcojDz704vTrLCenzY8cBhCJcxSLQxIQtT3sBTThWPAQHIhinrEMcQOH6o5CO3h1QXcDyGUqTNrO72aqduMQQvDCr41bm1kGLCAFfOozSUoIdAh8U+JV71FpwpGHSlxd7dBNIo39JUSrVxq+/ww=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB6893.namprd10.prod.outlook.com (2603:10b6:8:135::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 12:03:33 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 12:03:33 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2 4/9] btrfs: add comment about metadata_uuid in btrfs_fs_devices
Date:   Wed, 24 May 2023 20:02:38 +0800
Message-Id: <4541c4ddf5f49ad5fc3a9d22b5c1e0e17d3f1579.1684928629.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1684928629.git.anand.jain@oracle.com>
References: <cover.1684928629.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0144.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::24) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: a27abc4a-435d-4b4f-1076-08db5c4ee5b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1m1UTdMhUphsWNhJ1RNYFcjnkt/55gFAQEKCIbngaK38JRGajiDgnaYMsekg9erqvR9GubavimIzDlzQfhw6iOXt0RFOlgumdsci7t4BWnZ1Cw+GaTGivyxST5VRjb2aG0+EFAmKQeeqi8FauQAtM/J9rsXSYU8v43bJhMwqsSMnKA2AwQ0zqBnt5lriyTEHOXc5H67OANWg4umGQnkm4Mmwrbp21I696/t1mhqwqSF3+Z/mZP3aeaiz3MzpZdESlodGAr/b5896yY106NYss7xAwdgUYKEXsKPmrXpEl2ZSGc1A+7LNH7H8ljiOG+7IRUndzC/subNkkrFsSXnBjvLYyJhXDmuBrIuuYi1+Q+XJjc4emhfqR8QWnfb4UMtDhYHuzHzE89CLvSiR36je6r60iOfJiU1v1cAzceimADmJEoCAQ+qm6fqrWAdSdnApbF1S9EcwEg2r3KSKnuilid4cV3wUnN3XkB66fRfVVBQ4ifsQbeUsrJfE5w+CDev2/eNZ4bFxEAmoi/C+9gYjKvB4wndPdKuBvYsKDXOv0hi519QNo8O0Tw/z0FWnzVJD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199021)(38100700002)(6512007)(83380400001)(26005)(6506007)(107886003)(44832011)(36756003)(2616005)(186003)(2906002)(4744005)(316002)(4326008)(66476007)(66946007)(6916009)(66556008)(41300700001)(6486002)(478600001)(8676002)(86362001)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xd7zklUgJrXvlW2KARzArg+8TjUe5iy+s5bjVIoV28/XXQVVb0I2LfpdEbJu?=
 =?us-ascii?Q?fmFvBhGER9wVHUJegTEiF8tNStkQA4oEc4YEo+tfU8jBoHSYNAV/Du0qhO7c?=
 =?us-ascii?Q?1tdNHogtc489fTNq9ZDYfeQ189aCV0TDsmMLqMlPGDo6Gf0P1fjJaIUiGstQ?=
 =?us-ascii?Q?kysyyMKQAIscP1owAcPRY4YaPDqGUp1LOS4HwVYOaaaIifiitxfTj3j4rSZn?=
 =?us-ascii?Q?qMe23YxKj8U41Lf2z8r4w1xsPbDwzF8QIip8DelE7Jf8Eyld18l2FUyUYYkM?=
 =?us-ascii?Q?AdfsFK5HkVL0zCwp72vpQ2UjOTZmypmd2q0K57grZnkUW7F/881PytVUQ+4x?=
 =?us-ascii?Q?d4699dzYeQ8ZDFrOBoo11c9Aib9hiiU5T2sApYIPxNml1YfU/fcfloZ1iA+y?=
 =?us-ascii?Q?YtD/yCUxLuz207KObhPwGKtkSHk8jtcQCLfHR1RBmTMnsnU16MPzX9NPlzLz?=
 =?us-ascii?Q?Vb89vku8Ln62aYovOLAh4U7s4BTvhQMILXYYuvlQUxah+sPgfM7B/PP7Rm7e?=
 =?us-ascii?Q?kMa3T4Hoi4YrnTersAH6ow5vm1Qyp+Cvc9g6dnRfwEJs/iytEcdNbVkCwrsE?=
 =?us-ascii?Q?bUXCr8bvWsGR7SB5CQ9cL/2/Ut6Q5I6hR88rmubazjA+gqjW4G8gmVtwJS5u?=
 =?us-ascii?Q?tPs2dbuiU8E4DEoKRCz3U+kC4VEIHaKYHgtP3IwTsQpdtWk43NxPOfwSbST8?=
 =?us-ascii?Q?B7++PAcTefMHiyPjzXusMP2VZa42EUqY2ZnXdp2wSYxmPjFMZgXp8xLmymCd?=
 =?us-ascii?Q?5qz5/oHNJZosWYKWIdh1LNP8OrNoMMGiqZMHuIA0G1oJvS8ztDOyUcRWphq/?=
 =?us-ascii?Q?NdPl2k+GfpQq3stUb+kRO6e8tPLFmbjzAfb8Igr6fxzNfHfzxjRwhZdy8E3X?=
 =?us-ascii?Q?OnG8i6n2XqxJsuaff0AQhAEWTg4B1+cR/oFMoN09GXLG1pz8okbKf7Fukj5s?=
 =?us-ascii?Q?uoTffBmUxSejZyGHONHxf6tRvDDiaUk8EEPu9nX+tC8qkzmNB7oW43NFa2KD?=
 =?us-ascii?Q?eOQuyhTyQBgA8dXwEHX10ci+RKNDxx7aIfv2WRiSQBb1szkEKzS9Dcs4T41u?=
 =?us-ascii?Q?p7+TB2ldFmxSwWfV4IxsfaYt6VuDSRrJznJrrSjFfeOq/wBwgcf6wAQp+Jmr?=
 =?us-ascii?Q?NSswGWqieZmWome0D1gl1Yi4+qeH4BfN5LQwBZ26G33C9ZofTjsL1sdBeCiW?=
 =?us-ascii?Q?11Y282TCFhNSZ1jfqjCQuJCX1owDaRj8Nl8k9KypeVyEkvc17cwAx9R6hMwM?=
 =?us-ascii?Q?tH6ijPF7TXrlfevMb1SQCxns+MsBPKrCDKzDQcDiNU+sQa247ea4aVlCWx5O?=
 =?us-ascii?Q?Gf1UKUtgr849ohbxcLdyB5LMhKJqaCPRqzgPfKwXbe+LbQwSHCamlYixissl?=
 =?us-ascii?Q?ox6mUy1tcTnsWSpQphKo739lpHd8CLQOxco/6fZt1RHoYZBmFPOmNVilBpZJ?=
 =?us-ascii?Q?quDfXoFreDJpVvbgMbbuZ21mctmPqwmdZY9IB8vNWLTd1hxGd/IlHYCFu3Jg?=
 =?us-ascii?Q?YxH3hM9x7Q+zQgOxuuZxvQOyVumMPTQrBdbuLRgApcPf/LLg6u2jcFOVZ2LE?=
 =?us-ascii?Q?i+XIe8ymcPaJ7eB+O4ejrrIGoNvfwOoOXjBSMrcYAX0yFUY+tEyHc47rLMP3?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mEWwL/6FTKXIZXRkiwW6rhp8M8QFDX1aXLM4ASuR4/rl22fKxg8hBWQgriBORfUXdOLpmUiXfnod5MortVuOdTQHHWu8cWxi6Mrg4SHxO8L94/qauucIN70hQ7k+ks+DHB5TSX6yS3B23fIXV1z3Lj7tPIKnh+VARcn1TAjtK0ET5D8mydW0Na/Qbi6tMef6UgsSArkwWslDgyJrbs2K6itzmxd4e8VeYe26YeqatRWKGXs1OFdilXXjl0hiWcudfQpMSkyo3g+j6gMGvni9by9cR8RJ7zYit8Zms9CS1V4aQtwh0glqt/AjyE7KZ/Las9P5YdWZ1ms8YCF1aheqK2K3GqlFLwqthGHPz5MdODXS52dlmrMZFDm8aLBSC9+PsqYDm/8zULUyqFRbZA/BnkHtUPafEa13FNiNiiKgxnHQMjujaGwDKtMq0pY2VSDaHGVvdNu/p9fB1GArbufcDXWCNLwZCe/1AdI4UY0dpbV7UqUmWG6zOWIq3jBqULqN94k6pdS9PmSaLwglUvtfMB5rn95XSBv98s+iU8HQGLiX1ZZhBBcMefNNiqq+igsTJ+0grb1CJRcGckQhBuNrlfPrHzL6AJMLde/J9yvCYCdbfmcsIM/TqZJxnlyswwaqXL0691U5+un5scaA1yKsUnksLqISdnZL93kijCtPHk1hPL7y7fBydQMEEBHAOB9Z3ncInnoG9AL1zPVMyWgQOceaW7T3zjHDNmiGabLZexMGT0CXhWOSScbKv5odh0mfR1tCzf75EGgamvryiaXoJw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a27abc4a-435d-4b4f-1076-08db5c4ee5b2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 12:03:33.5118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KVktdSehgBMt+rH+ivJaca6BWtK3wCPQEB7gIHPL6+fUsVu4r60VUF3nAjHSVna3t97RR69JS6oaVocM/DMxGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6893
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_07,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305240101
X-Proofpoint-GUID: 3OcTs0Q1zQEx2WfrQGec5FQaCHh-Vm6a
X-Proofpoint-ORIG-GUID: 3OcTs0Q1zQEx2WfrQGec5FQaCHh-Vm6a
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add comment about metadata_uuid in btrfs_fs_devices.
No functional change.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Fix added code comment style.

 fs/btrfs/volumes.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 236ae696c984..56633d4f9b31 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -280,7 +280,17 @@ enum btrfs_read_policy {
 
 struct btrfs_fs_devices {
 	u8 fsid[BTRFS_FSID_SIZE]; /* FS specific uuid */
+
+	/*
+	 * UUID written into the btree blocks:
+	 *   If metadata_uuid != fsid then sb must have
+	 *   	BTRFS_FEATURE_INCOMPAT_METADATA_UUID flag set.
+	 *   Following shall be true at all times.
+	 *   	metadata_uuid == btrfs_header::fsid
+	 *   	metadata_uuid == btrfs_dev_item::fsid
+	 */
 	u8 metadata_uuid[BTRFS_FSID_SIZE];
+
 	struct list_head fs_list;
 
 	/*
-- 
2.38.1

