Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FB577BD04
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Aug 2023 17:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjHNP3i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Aug 2023 11:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbjHNP32 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Aug 2023 11:29:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB5E10CE
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 08:29:28 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ECiYGR026738
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=mdbMYEk0ECi71sCN0KxUA0MNMjAQtbm17Y61d1YnU9Q=;
 b=xbOGlajW3mI+TePuy56rRfOS9Z9Q7RQDN62JBKqJBSkMVxlVDL9FZiduCoMueZPX2Dfm
 mEywtix6oojKfiLfmS+iweqCNCJa88HUfxBvaiYIoLo0ffH3RgZNOj/NmvQ4lDmWTNdc
 iubLtMpXRkSO5F6dMe4ZVIYY3FfhJ0SdYDh/HsxWZJY5W2/HnHoGUU8YpaAF2IgCbioZ
 wd5JhB0JUtL3oW7K549kqaQWJMBDCd8rDHO9Zj4Cpo8oqaAiNzvQL0E0fVM/McPiJQPv
 f2xL5DguuLT3+Rwhzli5MjXa5qR/GXpZdS+PzS/1hHCcRwdzAEv7AUdNJBWw0+xuYkIi oA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2xwjvg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:29:27 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EEtl8u027462
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:29:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey1r1v4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:29:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OueSHAEI6QMMhJnGSRM82Pys6iidGsgimOFhFr3V8jh+0OSkSH1BfwuhKv16AI6MXp36j3l8tHW8Oe1h8htMWI7bGS4bDDU0PCRcWqIq0WCdElphtJjtYgiqV4mof44z/GqmTUVL2S3Nhdr9i0vIltp+qsi3boR5fs9YqJJnNNsSPSZ3O6CcB119wxauqtmGodaSg/WcThjfkvDdkkyC41JAikQeD6My7SYC3/mviTUGf+LKrkhxwk0JgKIFX7F8yYQTFLryb1TURns5DNGlVnoQXpqwHeJUtaq7LD3i0MmXHF3OnQuigX3OjBz6LPX0Iht6FqoNqIsx06fVUCn/BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdbMYEk0ECi71sCN0KxUA0MNMjAQtbm17Y61d1YnU9Q=;
 b=jvRJGUNydiWAw0qpHxlYimQvk6rTbxgAULqJMF+Lrk1ilFmvXzsVBg/5rujF5JsY1QxoagBaD4CwFvv4fwDqZT6SDnUNvEyDiWfTcKA/Wys3nIDOpzsARCnbjtym/mUsVoOq8n3rJcClbQv/+tuaq4FgbbhqGvVoN+OI9yX669bWturIovG9duoxzZxY3ZmlF8cWdxu9zjMk6i3z59mdBi5l8SPjSXZCqv714kyMtZv+/QjD4+uVN5g8RP9t9Y5SHrgpe+tdePjsOJ25gp/oicYvq1N9HiushJQs3NDxcKTKI3Y58Nk+yxVOcypHcKlrBq+j975swOVUzDj+TYNIfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdbMYEk0ECi71sCN0KxUA0MNMjAQtbm17Y61d1YnU9Q=;
 b=qDej9Bn2O+Xb8axoCIPMhM4gBA2PzKIUZBjApoz8r85Jw9sjsZByzSmCi1WTHTpxLM0yNcbrxSxqI+/fzQp2JXBoi2aEqIp+OdTVAgarQuJDeXMXiuJDnXoxC84HMqN0nwtv6ZQIpQNLpN90rVXoBw8+Kc5snYl4/zDRibLF4Ys=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5214.namprd10.prod.outlook.com (2603:10b6:5:3a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 15:29:24 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 15:29:24 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 09/16] btrfs-progs: fix return without flag reset commit in tune
Date:   Mon, 14 Aug 2023 23:28:05 +0800
Message-Id: <6b871014a82f276ee239e01c29d94450ee297350.1692018849.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1692018849.git.anand.jain@oracle.com>
References: <cover.1692018849.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0087.apcprd02.prod.outlook.com
 (2603:1096:4:90::27) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5214:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b15cbe1-c32e-43cd-ef6f-08db9cdb3d74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DfK5t5TVIarvsghAGzNz3VLGT6vgnfOxNl8cv6dCDx7JmQHPmxAcedzN6ws5Ec+EkKba/jAHtkPs/0TVXzWu2IdpYj28j8eS44ggTHWdTJvBlTRBAhXTJVDjjFIi74f0m7Y4T01tE+nihVTvku3YcGyT584xZUEQn0HMmKLq9Mc/duxub/BorWymyPaw/Wqe/eMJX30TvXZkjf0TO+ByBZxsLfbQI/rQ5LUERTLM5Sj8XKVO4ePUVf0IEJs9S2UtXiImWBA5yYkiI3392KtTNv8AFgcm0FrThc9+VOnw848b5T/9qLe1TZIgBCZP+nYkG3lOMdjki4a4en4pjKLT6WlwsJzgnUQlbiMGIodjM5zgyOxPzZ/DODlGBPs1z+qqJtATo0IdwCGkTRNHm+QejDBVq5pPtxVrKCvYUokmpvdU3kMMQu3LxGe+tIv9FtwXtc9aRbDiV7hlE/WKKD/uUgvfX6PoANrNv7O8/V4Jxkqd4vZagXZMFECpktlnrM4MzZp2G14GRPBm3GAdqjUHVj88YuXlttilQFQTxUGodVoLQLM7lD1uj27dXhAE4rMo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199021)(1800799006)(186006)(38100700002)(6486002)(6666004)(478600001)(5660300002)(2906002)(36756003)(86362001)(44832011)(6916009)(66476007)(66556008)(66946007)(41300700001)(8936002)(8676002)(316002)(6506007)(26005)(83380400001)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vGJGkshtWy8H1VvnDFKFp+Hq62BEj59jazkHNnky2Wtd1EVgyC+zE7Op3bq+?=
 =?us-ascii?Q?Zm+nmRpYts77GRMKuSbW/pEo+sLZL3nM513z6JnZQFgeJStRUQuQd6eGmZ1Q?=
 =?us-ascii?Q?cRjFELPcWrn2AZNLjShqF391JT+V0psxIIBHPXPz9CMFBVU2ZGbJGl0Ng7bm?=
 =?us-ascii?Q?g6eD908zSjujuD/37vhYhEVJu7djoZJpdRJ4KNcIeP3OKTD9CVbkM3kxZzdv?=
 =?us-ascii?Q?E7aFuVUipdw1+9AtDYCPfu67jDBYVvIznnhWxAGg5uVV3e/PCH9YPSblfB9n?=
 =?us-ascii?Q?1QC4Y9UvnSppYLC0M55AQ8qlMXldmoh41QrddA/5F8X12scvajZaQ6qhg1Iy?=
 =?us-ascii?Q?KA7Kxikh0ipXY6Ns93tIWKpb5lKDE9XlSGeUoFoQn+SayK3p8hikWgLxJFvV?=
 =?us-ascii?Q?bSSD/uonUeRplyPHSluG/o3OuYwyGG0tYtkDdOvm4PRZquqzDOejUrSyVapL?=
 =?us-ascii?Q?1t9sEo3YCkkqcvxdjzCIyVURTzpVmDbCRrUwTQpRmvT8W9Vmc43jtyHFZqab?=
 =?us-ascii?Q?Lj91LlZg2ZgRN2rvvWJ0V2Rni9uR93vThLDL3tVJe6X0PiLK86OYxqK1HZCW?=
 =?us-ascii?Q?frhn5oKlKK3n3Ht7uE6JloeSkHxUnNnR+1XWar/pCyMzmd8CpjPP4GIeOeSm?=
 =?us-ascii?Q?GbAsBDQylQXgCh2ISa86KMuolLZL8G53i0KeDJiEHPKbrcFG0UeVJF5ppuQN?=
 =?us-ascii?Q?+53YxIx4/f31w+AzgcvNzWOag972KVp07nZqrEkY538kS+r1TzpFzQRdLs5Z?=
 =?us-ascii?Q?pvXlPpQ5aaO5esd5UzrpXdGSPrDDh5FSQ9XEXUFJ43u1+BSBVPmdyG6XD1vi?=
 =?us-ascii?Q?iW3T6mkE6gxyobtpYPByOyoGvnOcXL46UoDxk5OLhreatm/f98i9t0yoLIJ3?=
 =?us-ascii?Q?LPR2Nj9YEH/TFUohrrf/CSw1flrcWZUFWtuRIvKo9mLnzi8xwZUSBablb5gV?=
 =?us-ascii?Q?Iow+1jwFDipj+ckSW3RJVaEQpPVxSMiD3H07Mvi3T77CfuIKsDUZESzj0X5k?=
 =?us-ascii?Q?+rMqFi/DbUWqz04ULdg0XQMfC3ZsXPEyQ+aKSvF2mCRgfKjTPA0nmaIcfM8/?=
 =?us-ascii?Q?1XXmSA2eVIjMSqme1tga4jfBSljAkt4UY1rcFUG4Ai23KIp2ZyPhqy8s9AkA?=
 =?us-ascii?Q?kB/uMZDdzgn/unUBDYeMLoit3Et+gBixwbtBTVBNV1IbnEEwdygzwbtEDfur?=
 =?us-ascii?Q?utQSuh9jXpTW4BKIV0N5qQ9wWDIoNNcR9o/tYEABSsO6Xs0rdu46fPpE0hcJ?=
 =?us-ascii?Q?UtFJgjp0iAvgj71UxYSHJMKaZWnooY4CYBpzeexBzhfQZB86ydeQXQuHWYyz?=
 =?us-ascii?Q?KmF5HaaWYhINW1pi9YSO7IqbcyL4K8U2GeyXiWbTUNwncqWMEbrzRybLOSZB?=
 =?us-ascii?Q?ZE0Q8+6Uw5myDWCmdDgFRuhb4gUyMk5w2Lf8jooB5JqlpKgtkvtGtNI5XaMy?=
 =?us-ascii?Q?d9cBg3rhei59aw7XdxtHBfugRWZmvSRRKqhEXBIBFNRbLIHCxw7f6yGln8rJ?=
 =?us-ascii?Q?+/Q+60dfXkvE3Cz9qzFzUZU7ogB6pMY3rzUgBk99q/O2PAR5vPjUvGuvmN7j?=
 =?us-ascii?Q?wiFZtO/O+e0w4lkJEfZ7wrWeZ3PCCXqO4Iz4ESyv7hqjssXPI9ySkz0xgVXa?=
 =?us-ascii?Q?XQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: x2ImudUNUiQK5bRKMMpM56GOKNz6Mv1p3bzJmNaKzbOs5VdEhgSKnX7/sf+rRFaRckBpU6dsubhkQcOqc9Wiw8g6b9IDW/RaZqEDZUreUNik1m+yUlKvAB8OV3GiInuoixqqBRoL9DuHC6RWn6f1gFlrSsH4DbwyZw7y/JOvVEuFEewwhGx13xRWjBY2laa0ghusTyqGrIh7il2H0PJhUnZZUcHYRcDzxsBFEXehUl7rQqND8zafB43s5xXuVJaDYVhmxHuHxUpCOtBZVlA+KDj33ZyBDzpu7U5f/ytvoh3IAFz9gaU7CVQhLBrwLgN/WITFb0rCE9iFuigbAxl/ZGTwYSskX3qQ80bynUVTxVTHQIzaznAVzQgSr4r//SWZSdQ80mDBPJvb/cWghIW80QwfPm9rXdptSsrPwr9EVpcUhNp5yVLOPJj7lPA5m1xTmsVdwHV6W0KSX8vCf/YUOxVpgs3P4agfpimtHzd+swZ5RBGKaOcvW4wWfrxkr5y0W+yRJORVC0GkCXIw3D6Wc/NICoKlAlTiuIxQwBidivrO/rrrpyDdtC0Vnna+Qt1Ky/O0NeY3jabELQ8QWfluqf9fJMX/CTOmF2T4y0yQyJGd1e0B3XEzamd7SwklOipUMTVNAN5FJdxHRq5iFhx5lbhgqT5h5eqlwcToJOctx6MYJYBPMFgnLWY24AiftwUIygDcyCog7NBvAtIdr6eE/UE7jlODJ9Gg0u9kRbLcMUwzcH7QYxkRJ+VVBYlyVf+X7afr/fYJOsT1VAg4wT9VFw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b15cbe1-c32e-43cd-ef6f-08db9cdb3d74
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 15:29:24.7645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TRQJNsK4/ityh64sq2MWdK2Hds7xU/+Bmeqf+DYYPK0vya6QPDSz547d8hDu06DsZyj72s3ScDR/xjSBT7pYqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_12,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140144
X-Proofpoint-ORIG-GUID: _KE4O6HCzo4rIAe2lj4_jTDeFBxAmS7y
X-Proofpoint-GUID: _KE4O6HCzo4rIAe2lj4_jTDeFBxAmS7y
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In the function set_metadata_uuid(), we set the flag
BTRFS_SUPER_FLAG_CHANGING_FSID_V2 in step 1 at line 71 as shown below:

   71         super_flags |= BTRFS_SUPER_FLAG_CHANGING_FSID_V2;
   72         btrfs_set_super_flags(disk_super, super_flags);
   73         ret = btrfs_commit_transaction(trans, root);

However, we fail to reset this flag if there is no change in the fsid on
the incoming disks, as we return too early.

  105       } else {
  106               /* Setting the same fsid as current, do nothing */
  107               return 0;

Fix this by allowing the thread to pass through the step 2, where we
reset the flag.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tune/change-metadata-uuid.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tune/change-metadata-uuid.c b/tune/change-metadata-uuid.c
index b161f6757d13..ada3149ad549 100644
--- a/tune/change-metadata-uuid.c
+++ b/tune/change-metadata-uuid.c
@@ -92,9 +92,6 @@ int set_metadata_uuid(struct btrfs_root *root, const char *new_fsid_string)
 		memcpy(disk_super->metadata_uuid, disk_super->fsid,
 		       BTRFS_FSID_SIZE);
 		memcpy(disk_super->fsid, &fsid, BTRFS_FSID_SIZE);
-	} else {
-		/* Setting the same fsid as current, do nothing */
-		return 0;
 	}
 
 	trans = btrfs_start_transaction(root, 1);
-- 
2.39.3

