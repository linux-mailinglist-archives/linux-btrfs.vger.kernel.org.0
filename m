Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1434C70F5D9
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 14:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjEXMDq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 08:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjEXMDp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 08:03:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E450135
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 05:03:44 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OBxWlu029406
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=nflhDjwWvOsueNJn1liNidurl0zQjbQcgZW984XGYtY=;
 b=LYaqtZFbmNXyBbDyUQiVTeSeujFD6445szlbVkHt8hX+tPJnIgRJeA+O3eDB8TvyoPgl
 MWqFxQCkFX4d/m8rQeA7Fn2j0iT3NZ09zIxB5qlM8JWop1/74PTfhdxxJOl2KNWKi/ob
 uFfBzEvJBnYLBocISfN9WgNgx1h7fWpdzj4Nm+YUR6Z0Jri7PUPL8luDW5WbBZzFKBG8
 CM0qb2QJTuipEdSY3ZYem0XMUDYVDXODacMoDB6HNJllFYaXEQazHcUOd9Z1agCsYxZS
 XdQfcEgH5mrSYiZ9YCkS0tmxcWHuNPTTVdb2LN6E+AKLV1JnNQRQ2ipQlSXA47k60XC6 WQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qsj27r0qm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:03:44 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34OAX66W027071
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:03:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2evka1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:03:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMmXM7EP2E/QX59J1A4BU3ERzIjTvU/kce1Oes0K74GQCPRte0KLX8n7rDdao0At12lG6HdrwrJf2oouVtZ3/lEvlnjjjkeI+VvLUuGjXO2ndmLjW5MQdtaLoUz8bwVl1IvVR8dvg8cDRuHp//ekoyTpRxnMK5fQ/rF0kCi/YZulAc04flwZPRLDdV6Sa4Ilh84jPgj14fesEiNCKzOsIEeaTQbBbFoEjhLDB3zc93Zq8GTaonPUj2C2JpYCzgkrZMt+Cfl3WvGbVH0VzO093CNAi2IxrCpUHRsBAgEaKnjH0vLR3hW/vR7V5cDGNFeJaBUBMbWj3K0H5RcnIOJx4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nflhDjwWvOsueNJn1liNidurl0zQjbQcgZW984XGYtY=;
 b=fCpvej6lXHEJDtcN32FTPKYTPTfjcEIG/6Q9VOcQFRKU+P1BhBqY+JOvv1IUuzh4VNr/O9FVhmRCdYv/9tzX3+jXs2ykQ7IMB1KcDHYkaulmQ8/gK2GrEhVtubfxzlHVvpPaU6VYBLbtN93tJRobd5K/9G5h2hg6S67qPmNwbMGmmy6xM6Sjzku59/d8zja2R8Mijfp+ZYQEGkqjYKUmZ9jyWUoofHJ73jVrP1oiGK+pke0myBGxncXU8yFrFKkTOdoHSH4STVwtQPZZdt+/0yJ2HgzzWkPJce2AttflDakeJ/a0rO3rnp/ZGgg576k63sT8OlfF5osNoQXHrwPvPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nflhDjwWvOsueNJn1liNidurl0zQjbQcgZW984XGYtY=;
 b=g8o9MYgliBHZ0OFbYtHWbxC4Ju8BLeklIDWrvP4+vSNP3fnwVx9Mo9G0urJBIoAE8r0uV/PPesjThD8Fk5d1TxYIZQgi4KwP0UFEOAuPNlnhcruwx5oDNFgCXu0XwqlCYcJi/kBIf8bW7WYe/VPCJzdBXTTYxhY3eIpLlCUstaQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB6893.namprd10.prod.outlook.com (2603:10b6:8:135::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 12:03:41 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 12:03:41 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2 5/9] btrfs: simplify check_tree_block_fsid return arg to bool
Date:   Wed, 24 May 2023 20:02:39 +0800
Message-Id: <ddadeeff95984ef5a1a60300a6aec8d034f43b33.1684928629.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1684928629.git.anand.jain@oracle.com>
References: <cover.1684928629.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:194::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: ef8b8ff9-af86-46e4-f144-08db5c4eea1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cun2huUu7Cor2Rqzo3j5K4XMgMkK6doPkVJWbKl4yckhcveLQW+aQdpLCf9pFHiqDNWdQwqXYSiNg9i+E6OZwixBs0H7R2p5u3RRXJh+NOPvT7IdUV8trivaUm32EYWDk4Ie7oiG8JqeMOm8EtljSQ6BU9K70BNjf4tjDT0MqWOb4z7ABQmKecwOSgXo986CjIbw/U+4pZBULgpeIamTpWFDUh2zgjhTV0o9M7NmOWXnVWkQOtzWhnt+41fhFb7lkt4OU0PL18BPuPtaOwIL09JNN7zIesd/oQ0ZYMUlbRPL+9N/ZpZdSpd0tBDzRo/DAxgUmQ1vF6JtdYrapEnChm4Hx1qF77lopWp8K2Xb2iFylsL3WBoAYKqu5sgSuqY2Dk38cXp4Q5uBtftiaiNsW2Dg01J8odQyqyPb9wf+CT/8CvX+2ll3dYp4adVh+TZu/Ij/n7zFIyhyu/YTMrx0Mtzo5sOx8S2fT0cbWViC3RshfEp3FEAX+n0dSKbcq6mRLGqYWZrkBLxlt04QWhhaaVY6pzTBD0vKLfV4i4KHjOmVTtoYZVjUt5Yg5P9BrrFJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199021)(38100700002)(6512007)(83380400001)(26005)(6506007)(107886003)(44832011)(36756003)(2616005)(186003)(2906002)(316002)(4326008)(66476007)(66946007)(6916009)(66556008)(41300700001)(6486002)(478600001)(8676002)(86362001)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r9EdD2EuiltMdIo/WbjicooA0+yPjJO1ieE0V+x1H4Y1FTOYpvz1BXirfW2D?=
 =?us-ascii?Q?U+NQNaVGbJgBUG9uu+iqthNykrS5HE5XUoyNfQod9uIHLjDQSGgQmlcNLEK1?=
 =?us-ascii?Q?YJDWz7QHT1qMavmoUcuI2RzRXlJalqTvK+nqVvX3vU+3PkkywDMvMmbv3F10?=
 =?us-ascii?Q?OiVEAtzXs2baVGIO6Q1R/+H2LJo2dXTFajJXc3aVYS0GYsXVfQbvfqdUQiNX?=
 =?us-ascii?Q?tSP4rY3Df7z08ZHrCUtmfszYeFDjcwPgk7fEpzmrHxjjBpkaxd6szqC5/rX/?=
 =?us-ascii?Q?MiQPIHkAxnVjcxBLTA9WcRbuutAIjWPa1lzl/kVwsYYqnbWkqXlbL5oZcI6p?=
 =?us-ascii?Q?zCw/13+Du6gTIL+EaqOaEGPXdV43WbFbIoKcBRMhKBIf4NqHAn9V0xnFfn8e?=
 =?us-ascii?Q?T0ogI4CY8qF0zt36Rr6s2VEnriADmh/HUj3H1/cYd95ATz2LOAx/lyEJDzFf?=
 =?us-ascii?Q?80RNTP1RnEKhLIDcb69jZ0i8rwA2v3gMiOpXQugbhgBTyc3ZJiMcRdjI9NRs?=
 =?us-ascii?Q?2xbmyGBFxn/YDOYpZ05c+YZ94g6laUtkMWeDhTY/71XrmKZi6mNxROKGcvrV?=
 =?us-ascii?Q?2mfsw4DpvnolZNsKpoQM6D6F8Ox6CIdcbRH0VEIaSkIT0sxNZcWvNl45Vm0q?=
 =?us-ascii?Q?KNR4bfZYXnWjn7v1uU7twaomx3OeYvpu80qHwK7ptLm+hHhxeFJfL9FUgSzi?=
 =?us-ascii?Q?iQkz1l2zdYmfFR5dFtbUyvj7XMonfVWjmmoekCdb+iuQpRVjcAkVyvY+ImrL?=
 =?us-ascii?Q?a8+GoJZ/k5LnAxEk5gCKrNwsiDHRgGX+Y3BFUuw1f122xSr44OTS5jt+TLCk?=
 =?us-ascii?Q?9uihb9DWVsTW+mSvISJbruOVyb0tqK/PupJP7fbjjJTGpPFzL1AD7XxqrTxB?=
 =?us-ascii?Q?shDSCYcD7CUmGoQIczM7L7/8pMkLUp/hsVp7QYkMAZPP7DuzcCOWBQwtaKQv?=
 =?us-ascii?Q?oR2KY95npYT+QwtQAJ8l9e06NI2rhmQkgMNbfny8ndKU3wrDww/87r3M7gHQ?=
 =?us-ascii?Q?GP4xdgB3X5hwGJmLV2r26TsQZylzHDG1VN/85BCrV25s9rZWNVjloDzKO1w7?=
 =?us-ascii?Q?j1c5Fn6KP/a7ARWD/c7smVgmwql+uveQbz3niWYYMYBNL/Q8Pfg0ow//AYXD?=
 =?us-ascii?Q?aO5nc/7pSjCm+4e0AaUWZvXvLI+He1eEgGFk0HjTIRlAbJseVW4WXhU5zOIP?=
 =?us-ascii?Q?RxBzBZtH9ZGU0Pf9OIghxmAQBlGqRfY041yt5mnYIGmji4EQl+hzU+OxBrHA?=
 =?us-ascii?Q?T0eH7KFsyyFztoMM4THOq4ieWJ8g5MUk0M8hJ57QR4bvSbTMMiDt694PVGTj?=
 =?us-ascii?Q?CHt3V5neMyRpDFXNEh0nRIyPnxfDXlb6JheIFXH938Oyz2AAZ4keox9a1hK+?=
 =?us-ascii?Q?EmyfrEdsVtru4wWY5KXhsxaqyN1Kr0ZT3XKhICOmNfniUeqT09RVWxEfe7wv?=
 =?us-ascii?Q?y9Ju6i7R7f7oxjvL2v1wutuwpy7VEbxuOgIRIj+o06lAf+PXVwaF+pM37FHc?=
 =?us-ascii?Q?jH2Qx5OwoS665Z29sm3w+qz9zDA8hTiUyzKZVUBwDZWLGfzGbM5G2oDAjlvv?=
 =?us-ascii?Q?s8HHEX/HdeYHriCDEPTRZIqWCLDvx4q0MZGZOSwIoQb6nASSddUqZ2kqgKVV?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SCDpR4UfBD3WQl92JscbxYMk0dOdocnv/IqfMw5KzJlXrbhMHTOGIz/FSkXfg4BupZlVg7c62IKr8ZUUPrUc4P+TtDkFUbbsddJyyQpfVk75S38W7xdCY4nPLb3RBT4L4z3omlHMRIzh85qAX0N75dkj3PAVDJyphv8+EeDU+CoQ/LYPkosIv13l+Y6s+2sc3W6t3nZpM6QkW7AE0JdO93h7pcbJ4tGLjsUByAUYLj1QUXAKuIY1Lziozi6oryDjbr6IzD+6k3630wxVzcKmDg3ql00yPDLtLIdYM8zpeOyY3nL0AKSdxhRjmKEv/hoJeQHB+IuJi7c3ydEldOJeSfH3zuOqrdl9cjvSSBT2OJjhRvxUMlOdXnpnOmNp3l2SCEkGeonhqg8y+8lcJtPRxZDpUsJXNFT6JqXc5D8K7HOeTBkRKWDOz2SLOx5CJaksitnfz1qzqxE7FEUFclD0FQo0ydf/6zKl9alyR4W+fjP3gP3KwTY0mDAp5DKP6ARvy20Eilvw8bohlRyWPaqjjykLvll5VCCgdpffSNPGplAwzMD/h2EmmY9jSxFYrJ/G+g96TGcx/gJyFq5J2xm/nSVqOcmsrxRhFRy7tyB21/7pffhxFe3pLt6kIOpuKDsC4BnIWcRCLPGJ/k7gplYNxl5Z9Mgk9yVyGZfb6uUe1J19opTKLtov4fyLkZVL41oX3yrh3L1qSgfwoP6IFkytY9Gww6ha5WeGBy4ERnvfp0PDElflliF6UBi0e65xdZ6fretFby3rI7hEcWKeFKwxKA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8b8ff9-af86-46e4-f144-08db5c4eea1b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 12:03:41.0927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRR8wRcRCQc7/7hHpFvBQ1sLaKobJYKW11Py2NvQnsjrckFhRI80xZaVoT0r6Mya2JdvMydLnL5YXBieBqDKjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6893
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_07,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305240101
X-Proofpoint-GUID: iJPrs9duYR06bt9BHRIV8B4LiTcxq9Tg
X-Proofpoint-ORIG-GUID: iJPrs9duYR06bt9BHRIV8B4LiTcxq9Tg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Simplify the return type of the static function check_tree_block_fsid()
from int (1 or 0) to bool. Its only user is interested in knowing the
success or failure.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: None.

 fs/btrfs/disk-io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 52caaf4b0678..6681e82900b0 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -315,7 +315,7 @@ blk_status_t btree_csum_one_bio(struct btrfs_bio *bbio)
 	return errno_to_blk_status(ret);
 }
 
-static int check_tree_block_fsid(struct extent_buffer *eb)
+static bool check_tree_block_fsid(struct extent_buffer *eb)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices, *seed_devs;
@@ -335,13 +335,13 @@ static int check_tree_block_fsid(struct extent_buffer *eb)
 		metadata_uuid = fs_devices->fsid;
 
 	if (!memcmp(fsid, metadata_uuid, BTRFS_FSID_SIZE))
-		return 0;
+		return false;
 
 	list_for_each_entry(seed_devs, &fs_devices->seed_list, seed_list)
 		if (!memcmp(fsid, seed_devs->fsid, BTRFS_FSID_SIZE))
-			return 0;
+			return false;
 
-	return 1;
+	return true;
 }
 
 /* Do basic extent buffer checks at read time */
-- 
2.38.1

