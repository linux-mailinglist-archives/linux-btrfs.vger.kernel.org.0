Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF9269E2D9
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 16:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbjBUPAI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 10:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbjBUPAF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 10:00:05 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0702D2B2BD
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 06:59:49 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LDSifS015124
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 14:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=DoVf6KRDqi0gzQvq6Xz/D9D5ZC/iMzhkMhBZR2Pbbk8=;
 b=EcqBtR8mYYc0UbXAgvf4BNZJKh0UHLzvZsuQGEsxfJ49gXvPyFMhnq+aBGuD3AKpFdJR
 iOK1vn3UKBs7RvfSiXI5KGph2A7Gstc8H4GwqWeoUHsS5ceB5oMt8x3iYphpzZBqTdRi
 45lywBnIdmzb3goyFn3mlQLZ186PLK1wyL2kSNtwe5b/6xLwJyudwHeSrVHnT8tgmphJ
 357l5oW2cCXwMEVR2+TmZhg/lhrWR0yaKVRSSrqGQjzwS3drnGJhdecPrTdvlmHRGF/B
 AfV6Ou/GPdilE5Rg5NEy6HF+utbckzAX4a0vxMTB0ASOgpJoMK2SVa/8VHC/jCBYwhh9 dw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntp9tncxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 14:59:48 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31LDt7q0023322
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 14:59:48 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn4580r4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 14:59:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4RiwzwJpRfOLjsk5P2HK3wQ5toJ7b93/2toDtpfwi53njrJpnrbSqmxE6JQ1Ew9cAK9fsoeNeKcqKhFsIWUYDaH3m1eU4//3E9zm4Q6C7EPQeZDIpgA7gjGHwuw/Uy6DwedeLjwFiYvqKs6gUAP7dNJZzF63IGL1zfsKkjDBsWaAkvpDI9E/SWOrNkllz5kvrv19Ne8tub13dtb4FYVN1CZW9fMMIhyd37CgDMxO0jHL21bxKNAvN81V5qd7/1X5o8kItVrOx7quouQa9FY2n2pQXphIbWvhyUWyfTS+eNPmdoP+0cozVQ5YtdDXRjd5merjXxOPI6GQZQfFfRb4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoVf6KRDqi0gzQvq6Xz/D9D5ZC/iMzhkMhBZR2Pbbk8=;
 b=DCVbzbqcpetOi9QxTI2Tcew6To6U+FI2+LbiiAfpoNZVUK8zZB19L+Br7uZP9c4mkLwOCRZ+Eb4OL3hQ8JgSi6dm8L65vQ0RuNphV+2m6KEsrORaXQRlCvyy5dt4NiYEfPsdjFj3i9KcH+P3Tbb6o+pvPJ4Q2+0cP0EyYONzOUBzs3HO2XVOWq1g4ijPV4QGEsk82bG5JBTYHgZadEZdhAJ+ZUJNVTCwmSCezSOcM21a5uGOao1l5kxDj1+/FAZWsjK50iNZExcPUgOvS4qmd/a4+n92nSJOluNvmRdj439wlqrsJyJwmvffeNbdGof1SS2SEhf7nd3mzuuQdLHp5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoVf6KRDqi0gzQvq6Xz/D9D5ZC/iMzhkMhBZR2Pbbk8=;
 b=pIu59pn9WBCMGybTGwm7ySn7WCIaahMxmKQD/w4N0k8SUg8Yq3fruS24xxsdz03PmZCZcX7OuBRqYespO4bm+rbWWnUIH4jneRUqNrxeUHmsxRqEQT/cricGYLfCUIaCLWuc2U9n2NSi+H5AofCtjfG+rSSdl90CssiOTn2Z7HU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB6417.namprd10.prod.outlook.com (2603:10b6:303:1e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.17; Tue, 21 Feb
 2023 14:59:46 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6134.015; Tue, 21 Feb 2023
 14:59:46 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: make btrfs_bin_search a macro
Date:   Tue, 21 Feb 2023 22:59:38 +0800
Message-Id: <520705d35cbfb6c21d1e89481f8a4d0343daa138.1676986303.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB6417:EE_
X-MS-Office365-Filtering-Correlation-Id: 00b762d0-66c6-4d93-229c-08db141c4586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pdlICzNCZm8fpi2D/KSSpX/9GaJy0xbGYhi/2+L2TWsurTXzVxZTDbpfs9Lmw4Q8alT9LZm9TLXh8KapRKEMkfz65x6uq4CawoJJHP8TEpMmI079+BKARTqSPRCKrYT4zmWz3LSROjnqX02XkHPnh8eCQ/7bZbUZlyOmDa4YJj2yi3+97++icSJZwUc1mCoTd376EhJ6skd0oV7JigjyKc54nudpWDNXPC+T6SDJrP16zj98iW+eoScPrb+tlXRB+mlHUahHzNvekL8YvrkxFPNcqC5tsSNm87nbQpNInhKtTj279P6bi7QowCcLPIIGM2DsUND9npxTl0+MFoLS6qa3QejufwHmPW3ZyKkfpU6hr7HLCHfxmU7RVFZKaUU3nblP1GxU4KaI4sCAzrhU8l0Ktz87f/4Ui0ydU2PG0kQuRymO2SdHHZtcz5+bdPenzhvTM9LV+nwlSOaaMeSKoMK8UkidCOze0DhwWmniTShfDz18Qim/KyheA1KaZ+52S2Ou0brnJKyJPXiBqrPkse8rtfUb6eno3xPyoWGTsrneQChAWBPYU7nrjQWkxxQ9lNHnib1yJt3+z6Um3t3ATsDSwdgg17n+eKHDcBLnefvzQ6GgkkX7UE4yl75em/aphYYzHVHhZ6SRdqI/thLNFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199018)(316002)(83380400001)(38100700002)(86362001)(478600001)(6486002)(26005)(6666004)(6506007)(186003)(2616005)(6512007)(36756003)(2906002)(41300700001)(44832011)(8936002)(5660300002)(6916009)(8676002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0VxGKjm5j4XS38yI+3pwYWaALJm/+NWRgyPz/zXcOM2yLT58peKPBfyctrL6?=
 =?us-ascii?Q?+rbV7jZbpma2Lr9cVPn1W+vuUDiuB/47Lq6OJNtipwPtjsfPSHJfgG9ktppS?=
 =?us-ascii?Q?JJyxMqSLMuwT1JQx+lWBleVlX2pJffy3gziCQoeZmAJvebY0tKwkIEBNI9oA?=
 =?us-ascii?Q?qtXQD8GOK0kBRL9ZNtRV0CDp+ZQVrOlvE0D4rlecNUyjnEcAQq9F5sehJTAJ?=
 =?us-ascii?Q?rt68aQisjhbcugDNG7g6D4/7dCj0xuaPMeyQfABqrQ9XnEc+1nBorDie0Vlp?=
 =?us-ascii?Q?3DA4+F08PWSEeswgYo9BFw9L1KwjLyL16lbT41xO01gEa4J9/eWejs/EP9ls?=
 =?us-ascii?Q?48QNr/LFUeVmvu47TI9eC72J6sV9Hyh5q6GRZ2a74KlwM568/5oLqLhNDEKw?=
 =?us-ascii?Q?8WpiP4ZliNVcDp7ESGO05J264fY3Ak0iIGTcK78BCuAStw/aeXToqKcM6sjH?=
 =?us-ascii?Q?GwEq0jUoTK8XdjMwgrlNsNWOsC60vIRuWh0Sel9v2BsqT/g1dSevSWtMx2M8?=
 =?us-ascii?Q?Wj9LWR3nxh9Pd/Yq7ZQnTjnw/ew5GTiWGKQdQNKV1lAmwNiwye+ZPUgotVSy?=
 =?us-ascii?Q?ApgK8pZPp85gUGxMer8J0/dCBS6ufjEhZ+kxMxdZNy1Icpwt7WpivT1Q5Tdh?=
 =?us-ascii?Q?cGvK5sdqJDh9XirofloOcM8VTgAfzB9mh5tOPE/NOMb1/A42npE5R5yGJu2G?=
 =?us-ascii?Q?jlv6l5kMLs6FUClwrnhLLIV1qAoCJ4+nwI7v3HW8m/s3L6pdW6/K02VGTbRi?=
 =?us-ascii?Q?7JG/51JqRbv+2NNPC7/KoHQl+HmlqimqEqrH8sqQC6gpy5kNhf+toB1BWFQV?=
 =?us-ascii?Q?RsnDmozzO/IOXOXGuT0Y4eJ/S1Qv/mv4dl62O7hgTpWh0/3nybxnCkZn0aJU?=
 =?us-ascii?Q?J3H4HspiiEL6yevJlT689Fr9bCbQq3PRatjo3RuXztqSW3HmGCU7lYh/MVEV?=
 =?us-ascii?Q?ke5mQ8AbkzMXok8guzf27+xxmVNA3tqlcSQ0FoBp3e3ivCCNbO/lXXvg7Y7+?=
 =?us-ascii?Q?G/1F0tMZCK0g1HPxj66uFtv2uHMZ3Znjiz3fHfPY9tUADmRm9lNXCw0OPGJQ?=
 =?us-ascii?Q?hiJrqtnbjI9vH41p5OnCGL4tRM9C3A1lC51Sx3IaU8jOb6r0XtLn4vH7M0Vu?=
 =?us-ascii?Q?Z1xg4JBT0sREd0hjBBgEKoIBa09pJLizyuogCWzH4Dva4y5ftQQRIdoIF120?=
 =?us-ascii?Q?eTcxH/6HB0TAK88qRsxcLYdrC6lGwTbnOxDox5BnIS+vfPs0gwxCz+Qf1R2W?=
 =?us-ascii?Q?UxHfNaBSgGOKggRVCwYGE5LWxYlGqZ7sb5TiDE86V6h4rMP1SdrjMAQKleQg?=
 =?us-ascii?Q?6GwBt+kyFwcbIPeJwyuHiPndtcpvZf4/1vU29y5Gos2C32j8dmjROofwjUiI?=
 =?us-ascii?Q?NRw4cjiYMrKEm7rnH0+bsKq7X2N875JprGI9rJV/Mdq07zFlI8hcte4qOz4f?=
 =?us-ascii?Q?2vZyWUOpxk2b50K8JZ0q+2M3jh8vtlmfi3Fnz5b29svFUuUVfYTRGyvjSb++?=
 =?us-ascii?Q?em906clPzoCP+SsZxcUpX88MhuFzKaweaKaR6/lk+B/nHC6CDsGZcr4gm97C?=
 =?us-ascii?Q?GmLAznDCn23qBG1iUbCpV9ArAKRmKLPNOLcLJL4f?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IR6RaR46PDZlHltuk1OylY+ay0OAMPf+IRRTFS6b75JPJFZqiVuKHHzakxtm0vXmlQrtDXhj3s9AViAMtc8IrTXL1VmpUh3RPpc+NUKMOByYoj/9lLmWknMpc77ZdcsQgi0kFxjtFN06JpQqsA0JrAFsx2BtN+c1MDa1aoj+qssmQeFqZVzqM0B5S/3qKHmR0TrM1kBub1Ln05DTq1O63zIU9GhgBetqFHXh8VPAzOGQVj/PvFcMv92uzznxhiH1uE9ArINU3QAmcXp8zcHhJ2ZSkJd2I3mm+gbVbAcU0MCdE1MrN9Wjrrn/UvmEtAYFZBPqQntHu0AqfAD/sVJzZ5oltvpUzGM67t6IEpxl/vXCvVm0YQmhBTbCHREkX88VqDUWgL2fYcCW7tIJR4TwSZ/LDOX2HwSObtbcNQHMr7nOAil72Frvysm08lhmLu8LVHfy4aYkXI24n3yyOzK6sWIi+FNgApJnnCKEVEnM253jXk5pnI/6I4eFtcavZ/C2u/64JraBjUOyOIb9tQzBxtaMN7kUdpdLsOkW3cUOfzCyYpdekSm4+fEZZ8CKHsEnN8tObDp3Z5zsGSzNCg4LiDcK1ePG5pFNJ3bMWrvoFB02ynFihxWQdNz7syq8MPaHK7qlgKBDwqhxDTjcL2RclLiTNGx7/j1jS+6A1HbSkdN5+WPqxtLIBIEd24ygF5EtWXFW4ILx0BFTMMUiMllvYMYNRtCUfW73Y4jzVRAFlTNNOOrpeKOqb6YibIx+j0AMyW2PlwqKu0au7uaeaJvcdQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b762d0-66c6-4d93-229c-08db141c4586
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 14:59:46.2365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gUwcxxiQmhVGjp1zgrjL8mKDhbC3OxxaL6GLfVrdrPJItLA/l5BSP2mFknDjFe59xKiWq+eqR5x6zoRnwWxQxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6417
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_08,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302210124
X-Proofpoint-GUID: gZ4fWObe1h3xQ9N71Eyp55yed_qOeHgn
X-Proofpoint-ORIG-GUID: gZ4fWObe1h3xQ9N71Eyp55yed_qOeHgn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_bin_search() is an inline function that wraps
btrfs_generic_bin_search() and sets the second argument to 0.

The inline compiler directive is not always guaranteed to work,
unless the __always_inline directive is used.

Further, this function is small and can be a #define macro as well.
Make btrfs_bin_search() a macro.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/ctree.h | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 97897107fab5..e86bb94558bc 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -515,15 +515,9 @@ int btrfs_generic_bin_search(struct extent_buffer *eb, int first_slot,
  * Simple binary search on an extent buffer. Works for both leaves and nodes, and
  * always searches over the whole range of keys (slot 0 to slot 'nritems - 1').
  */
-static inline int btrfs_bin_search(struct extent_buffer *eb,
-				   const struct btrfs_key *key,
-				   int *slot)
-{
-	return btrfs_generic_bin_search(eb, 0, key, slot);
-}
+#define btrfs_bin_search(eb, key, slot) \
+		btrfs_generic_bin_search(eb, 0, key, slot);
 
-int btrfs_bin_search(struct extent_buffer *eb, const struct btrfs_key *key,
-		     int *slot);
 int __pure btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_key *k2);
 int btrfs_previous_item(struct btrfs_root *root,
 			struct btrfs_path *path, u64 min_objectid,
-- 
2.38.1

