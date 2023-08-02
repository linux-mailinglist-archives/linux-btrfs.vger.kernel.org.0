Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED27276DB8D
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Aug 2023 01:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjHBXag (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Aug 2023 19:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjHBXad (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Aug 2023 19:30:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5503926A2
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 16:30:32 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372MiMeE003655
        for <linux-btrfs@vger.kernel.org>; Wed, 2 Aug 2023 23:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=4Pwu99+kaMez8uMc6xA6npMNVrqYg0EqAMmV2xMfBvA=;
 b=mefzTh6zPuk/M1p9Fv7L3Nv7/wLOoR0klTJFEZIXFAlboXsw2msnd/AQ3nha8TxMC29n
 X6G+mAPLGfWLnhQjT8lqPIbz38R15v0uJBdkAmwc7Nr8tFiQNK17g6wG0Kys0LcX8tPb
 oGkfNbob2e4MF0a1JK+yJJ9LXzK5xkP/XjfFAE7dngY/4EJNXQwr41YGSkPuD3j4ivvW
 YsL0C6Kvlf2BMluVxATyqy3666uqH/Oaw8L3m10vNn+wBNdEScCLXtldAHLL12Ca9LcU
 X+w/OGR2k+t3IabPGi9pyZ6co7Zc7GIjMJS3NiheyNzG2GExJlIgZNm1DSZY4FjG18OK mw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4uav0egr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Aug 2023 23:30:31 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 372N635X006590
        for <linux-btrfs@vger.kernel.org>; Wed, 2 Aug 2023 23:30:30 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7f3qt9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Aug 2023 23:30:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eP5UQX+zTWDKYgn9q4b5h2YBjudhJSCIU+6y5V0c74qecJSeC1hWHiS2LB45jRZTSms5EaVJzMBuqJ1iS5R3eUhcukI04fzWanKhKfylIaEeRPZUnluRGpHeUu3FdQ0A5fqDvikHlXj8EPkrcmTLAAvyWQUeTSVx5EI18Ymbvm2rXRaOU6wsQwbTEgh4ksh/yE7DMdC1LDP5O7+/E65yPPmpdIVWShjE6WJU2KC8bzViJ/9jVGKI+J4hTK7K3inb+s+i249CLzdKWK7Idbwbq9vK48gw+63RzqQpNb8Y7cblBoM+tUP5pRfT0oS61eS3JhwLUIERSBxlkwxDVpcNzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Pwu99+kaMez8uMc6xA6npMNVrqYg0EqAMmV2xMfBvA=;
 b=TDNl7q3sYEdeF/VV6ECrfn9lv8es/XzlAr6B4MfsRkn0ZC9tEokSFSD6oI3AIwfxuptcx5A6JELdx2OgD2Fuw/i32G/33hA/pF2UTnsYHosQBTRVY/J142RaIzhSuRLaixVPucMj2wYRQ4JGrwD6adVShws/Zq9cVXdn+hTNnSJlcINLoDwihjfHXJMm9/r9SSCC/2qP+Zeni384Ta5JJSzLQ7F2WX5j4tqA+U/SHFWDqqBvCVdVvtfat/jh/wyQZ7amU1ADo2/YTw4UMDOQmyww01DDDIEfr6Q6TYCsShSPZoSt7I9tMYuU3EQPvH4qZOhLf2omlZb2Bgyzy/oTzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Pwu99+kaMez8uMc6xA6npMNVrqYg0EqAMmV2xMfBvA=;
 b=AW0vcW37vTzItS25ZeZtwCc+lgAG5CRaTix7ts7JW0zRt62uMmAV7G3iJemCPQz7yLsq+QG+SmAGEKrqoxODIKMaRnKlpk1CwuAu5E3xL25mv2X5uW8tYBJrTNZSOaxWgAtEYW9j66CL9J6kNfY5jSl+vd+Tvu/CHPMNImRKQGQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6383.namprd10.prod.outlook.com (2603:10b6:806:26d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Wed, 2 Aug
 2023 23:30:29 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6631.046; Wed, 2 Aug 2023
 23:30:29 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 05/10] btrfs-progs: tune: check for missing device
Date:   Thu,  3 Aug 2023 07:29:41 +0800
Message-Id: <aebc04bcbbfc24298969e986eab5f27b002cebdd.1690985783.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1690985783.git.anand.jain@oracle.com>
References: <cover.1690985783.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a35dfa6-9ec9-484c-4df3-08db93b074f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 89ZE6jVJraUVYe1H4rBsC56KVD002NqL5J/ii+oXe74OLggGf4kC0VZudVX1FsLmKPUTRgn5WotiyN6KVs2dK0dql1xE9BTAouivipcJL+8Gkw7RbXiyBXc59dN8hqx3OCaWHu0jQiQZ8BZWNNQeICL7nZoOd60fClvbMNEFUhh/Nxz/9UM0UiJZ3znJvOxhAsNyPC2BXMaiL2OwVb0V50LrAHAggbma5EL3P+ZAU4Lssn5lspuDkA4NmNIIDJBPftLpaI+NB2ECDTXajDq4ICpXlWb6Yd7LmIOiMJ1HOW3/nJIqrkaIo+i08PK/RbycBMBLpP/1c15jX2Jao0po2lQtKQfDa2CzrZmDAhl6xw4P5kLYSl16WXFaWDXR1t13huZCmIs/AC7Tu0xcPEBZkTkNybBZ0l2iHrN4FZ1aNNuZUkVgA0Q3jQfqEcJ1xp7QPFCh8CRrTEsOlnGGyWeE9R2nTxaFEJ+oktvaKi3WOSO8TsBwrE8quSV9Ic6Xh+37GKIK8mmDFXtutu1wK/iiDQg3sC+BOelhM09+30ll9gTHJBpDEgWPSNLQ1RpIUlFb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199021)(2616005)(6506007)(26005)(186003)(83380400001)(316002)(2906002)(66946007)(6916009)(66476007)(66556008)(5660300002)(44832011)(41300700001)(8676002)(8936002)(6666004)(6486002)(6512007)(478600001)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LdpZAQt8z2GpbR8pmU56Rhsm5aAxrIqCOZ8yihHRtiqMgpp2tqKaJI6GAw2V?=
 =?us-ascii?Q?3eAQp/PfFQMNt0iyyq/9AYN1K0OqOXlId2TqILVUUIOlw+P3rLYyU2eYmyS6?=
 =?us-ascii?Q?O8MTUI9TFf6y/hs9Q9JnxcAruzdtQxe8o2nETeZHgpwcfKEpaEdHGai+lGQ3?=
 =?us-ascii?Q?/ZJstmV3Qv1F2VXqADB/IzakwboLMTrFp9P1mDIaWE69Gp2nEgMbsm4qx1Al?=
 =?us-ascii?Q?7StUgwUaICkYQG6QDQ10kINe1MOZQOwSxOheebxWvKX0sjCxhxSzZcHQgzoX?=
 =?us-ascii?Q?H+8Hme3901ejxap5+0bgi3EK1gAZzfskL++xl89JzhArpgqthjwmZN4nDNAJ?=
 =?us-ascii?Q?OAPcQOl6RgVTbSCTKQ7ReQlFylihShxk7egykOFiJMziqrlHIwVHyZhSilOV?=
 =?us-ascii?Q?3qtRZsVS6qSjgN7AZ9dFb+QW75zWoqB/KjG5xMZrwMAAKBaB6oCzJ6Tf726H?=
 =?us-ascii?Q?VAGJAbYO1t2iFOsK9/hnytTll2Inr8kYcthmSkBABcLBLM9Rs/EGPKpvcY+e?=
 =?us-ascii?Q?16EO+ujW4iJfbewGVo+N12Rf+hb8l3YY5KZ6k+4PdIKLNThXU+c7L8P1qlsE?=
 =?us-ascii?Q?drQEljzCu3+mafe1Y/DP7vUarz5TfWuZK/oJX4eBLo6aFnfXclMqxLNbL8Wu?=
 =?us-ascii?Q?bPkYKutx/LuH7o0s9jwf+nU7Ereg/mVVt6YK3Bwis8CC83LdxZ+l84Wptupd?=
 =?us-ascii?Q?9SBF4E1cLFck55hdlwlibE28ot4I+zWVEGSBah7JkA/rHnX+z0s7beGmnm8q?=
 =?us-ascii?Q?yLzCDGTVMAQuD/eHPaXTp7APJ4BvIl9F1D2WpPeJxGmRoVTQpr7YRTmgziwH?=
 =?us-ascii?Q?hDulI0yla82vT4pZr1kI36TrBZSPonJr76tWJ1g/M+pbVHnDaUSrTEuhSJ8J?=
 =?us-ascii?Q?6nptQ8rsrkGqeuuV8uLPo8IDGZ83gJFDCp02l6SvZ9L6Ino2gwo133gsHrC0?=
 =?us-ascii?Q?bJxasUHNchPRxvIpGBeDT62pLApfKrq4gaNet4pes6cR/KLi130eDkP4DHib?=
 =?us-ascii?Q?LjDYVjtGgPVDWm84VhL4It04sZYacPyecXa/QYC0VS1khTVTxy7lBzFSqsB+?=
 =?us-ascii?Q?/voYea7aThyC35ZAFEiEBw+Hqouq5bV8wFTZL/CcENbZgUKtDaHyPBh8AEET?=
 =?us-ascii?Q?wXcteoQArD3JIzGJHvyVi2k5+a35IsZthTOJN0R46OE82bqfz1X04IqSuJg5?=
 =?us-ascii?Q?/YokNaliIN7Z3S3LtIErR2SXjpbffvf35HpS3p0VHgXNdYlLCRjUj0gCwKlP?=
 =?us-ascii?Q?aUJOS1cLwe79yuuIor9Eak6O2aG5KDMZ/53ynn5LP6hb7Z3enkARhLQFRhIW?=
 =?us-ascii?Q?I9IRVW2G8ryXc7Hz8Dd5QDixnkzwtMoJFgwiA+D1MC2RNA4OUoO6os7A6eET?=
 =?us-ascii?Q?TATBQyHQC9DjwNXU1dj87PFuCyQjUuEzHTAZb/p8oBBx8YoUzapvkg0FulYf?=
 =?us-ascii?Q?N7V89BXlomi4L87l8O9i4lP+bbQurIAIM6H6DDtkyG4saBZwbjPAJ0lbe2Ov?=
 =?us-ascii?Q?v+dmPiedaBMGjmWyVf296iktOIYphcN0P3okbCSlxA5L/M2TyOU/WD8Dhb30?=
 =?us-ascii?Q?XARfQYsuTQSjl+70h9QIkwsax+dFKfxhvN2BbJ6S?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nBjC1Iw9drTgcOiaUK16hWp8dDWwadNd7aZu3U9oHjgpYabYfFzlfwDXMvfr7CQjmjotTGcllFWKC35M+0KQBdltvdaFcOHPoukD7p7VXDWGaejhIYA5rk7vIFYqRuRgkZ/Pnkte1iiqJKpYL20inx8LYcxWG9/EvFe0b2LoXov/QErjradofSv7PaCUk2RQnU4tvMwSrGMKbH0uF0nej1Smib7OTVgQHuuc43W+BE8KXc8yiNytoBMTvndT/mJLqEAi/mDZCeBuyt3NlU7vZ+Bj4caA3SDmQAldjtgfa59/ZolCkjnIIxriHNjFutQHp/CgP2U6BQ3oFiZNF90cohIxNwoOEw8lF42flRXY26YnYzjCfhb3/0yYGTiaVVr9pM2hUDl6mEiR6Bw8rKEfb/iKy6bm1fnUflHbh1Q+qge8kiE7GoeI37PboIbhNvOLzfQ1quMiOaopRGH7xNEp41sSO4lU4e+VDAnhtFKHipMnnr6EOr4NGStmQel97GMJKyVMa5sEHOeYdnHclLuPDW72KjeoA/JQw/66T/ZlpxRM2KwCYoHSrIAGK/5ZFjDGTytRsYgRNK0VdwvNVqX8eF61ZxP5Tq0kpT9GOfVssbTokVsTMq80s1tH9kRf45R8hCaczt3WFjXxMXNhQe30w+zpogzBcawMgFt1kYrSKuasRzH7hJK9g6fz+5FlTY8QaTS3EnEgNOgF/R64q/M8FCJK5u3l1K+JXy/h0xMJ5oe8lkqSEkJD0JSlYkyOWtGiWj5VLMhKv5JEvy/wB1pqMw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a35dfa6-9ec9-484c-4df3-08db93b074f6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 23:30:28.9948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1mv+D9KaSOCfildDhVXd/tUU7E9UmbP84vXWHYdeMBNWiyiY9dYS0U3BhB71EMaOQGEcqpV7rrP92xmJGhXd9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6383
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_18,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020208
X-Proofpoint-ORIG-GUID: xQp_x_-LSqTDxKkr4LG4BKRxOzbsqvVv
X-Proofpoint-GUID: xQp_x_-LSqTDxKkr4LG4BKRxOzbsqvVv
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If btrfstune is executed on a filesystem that contains a missing device,
the command will now fail.

It is ok fail when any of the options supported by btrfstune are used.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: adds comment

 tune/main.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tune/main.c b/tune/main.c
index 73d09c34a897..8febd0d6479c 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -287,6 +287,23 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		return 1;
 	}
 
+	/*
+	 * As we increment the generation number here, it is unlikely that the
+	 * missing device will have a higher generation number, and the kernel
+	 * won't use its sb for any further commits, even if it is not missing
+	 * during mount. So, we allow all operations except for -m, -M, -u, and
+	 * -U, as these operations also change the fsid/metadata_uuid, which are
+	 *  key parameters for assembling the devices and need to be consistent
+	 *  on all the partner devices.
+	 */
+	if ((change_metadata_uuid || random_fsid || new_fsid_str) &&
+	     root->fs_info->fs_devices->missing_devices) {
+		error("missing %lld device(s), failing the command",
+		       root->fs_info->fs_devices->missing_devices);
+		ret = 1;
+		goto out;
+	}
+
  	if (to_bg_tree) {
 		if (to_extent_tree) {
 			error("option --convert-to-block-group-tree conflicts with --convert-from-block-group-tree");
-- 
2.38.1

