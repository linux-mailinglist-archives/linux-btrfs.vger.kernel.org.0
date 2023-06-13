Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8A472DF62
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jun 2023 12:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238653AbjFMK2C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jun 2023 06:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240537AbjFMK1b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jun 2023 06:27:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E51419A7
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 03:27:26 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35D65FuP003835
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=C5+t32R+K6g7V92RYqZ1zDieYtSn41noNJ87r+RD17w=;
 b=z/cTD3uTmAPYrziKlDwiKlg1Dy4/duJrs46xhPo2K2a8Prr2YdNrf2zU2PO79O2aW6FL
 q0k4PVFk/filNOTGw8siWnoboqtMIRQDqpCyaiFnM0L96rKTswnRlONQprOYlJEN8Lds
 VII/9iNWkGQ7CgZCqQ4MZm6uYN+nvVzRr90HPp8KIwVH/y6pWSjha478NQvFmvNyaNuZ
 qY83D+ldR1oh7a14a/HC2Ye14CKgKgKVTuhHqVB/zXSRNWHE3N7yWt7fqaC3eaJX+JL0
 fh3iZ0h+m9xquXAJ6cSPFpGGyqTobWvd2pEuDQgtr9lpsSEFlwBkh+isNAXQ5ZGI4J/a Aw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h7d4vs3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:27:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35D8PHV8021727
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:27:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm3ywu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:27:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnQ8wzid50VN91JLyjSsrPuGEhHTWVJRZuxt1qsV3oMewa/tf4dV7Ap2eVuZVWp/SudHBAxh1OxbMUFpGdKL6vK4DlR/ZGTudiVyscvdN5T5bDSG7hH0HtvU95MHlsEGn7uVntDZbjMCRWEww8Xlbx16UH3xO+5hZ0KeJ0pRG1pBpKb/2lyT86RSgbuhvH5CJoEqmYMUxgKRzCI5zqGvbidnRrb4qNk1h0kEmBgJTupb5RKOY7x+U2T62LBCHHGq4OuLNNAcX8YmTdZSg1WzTKcWQIgkgKdPp/dAgRwHYiwjNPwqiRziSz2ILwyjoD6spc/Sp8TnpnzO2D0jYIvAPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5+t32R+K6g7V92RYqZ1zDieYtSn41noNJ87r+RD17w=;
 b=BpaehSll59fg1YDLTmnsawLtkVerRPK13QgdZHVS2JpQg/ZKcQ305qbfdVVxUCWZ+03sDOQ0tTZIBepA2n8ZcAotwCc+C7exHHcd0GPfaAQXK1eZCuIPtf0e5w1A/Rd7f+4A9+nHhuX2gbDogezCG1JAVv052St0jSNiIWraOxNY2DgibGafiUkTVHFxDMSrcFDnMR5SiSakCaM8wUhqLgxiP2wYRzuz1HLl6lpD+ZYr2+1kbz5hWRkiGP9jC9A3XB4ds9R+ubB0kJAI/auDRraO9hS+xhLD0OCeAPt7/Nq3nyu9w/ad7lImrlc1MS1NFjP5WCvxdgA7KiouzfXluQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5+t32R+K6g7V92RYqZ1zDieYtSn41noNJ87r+RD17w=;
 b=USTtKmrmdgsQCp1a/RaNrLEiS0GoH9AUhex9hgliPZqN/cTFIxxzEwr7e3LmIjuRKVh3bfQYUplt/cw6UOGpImgktM21I0PoFg4/2pNtK5u4l+scroIKn2IfrWWsyyAY+3tKN3IWkTiEXUNYWozT0jJngyl80H62IQnD5FBnS9E=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN2PR10MB4398.namprd10.prod.outlook.com (2603:10b6:208:1dc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 10:27:21 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 10:27:20 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/6] btrfs-progs: rename struct open_ctree_flags to open_ctree_args
Date:   Tue, 13 Jun 2023 18:26:53 +0800
Message-Id: <452c6fb3507f8e9b864efbcfccc8a759040f356e.1686484067.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1686484067.git.anand.jain@oracle.com>
References: <cover.1686484067.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0132.apcprd02.prod.outlook.com
 (2603:1096:4:188::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN2PR10MB4398:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fb0a7bc-d41e-42ba-0edb-08db6bf8c509
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dOdq7qBgps7LraKJ0uFfLIiN+OULHRxkts3TCwMDAZaPLC8a4SHerEC53Ie73HUAykyBzY2rLSnwDZXUZwXuerCXLz+3w/wFLNEgvGUj4IMM79mox07LeS6E1M/68doWww5ZoZeYfisVJQipDeY/6WEfPalTFUe42Py7uqrw1NIt4wdnjgE7mXvfknUeQR7c8CS+4D5m8oban/g5XXeI7h+QWdS0hNw3nD/Y5Np4MumQNgLBNIuElZ3YbgNyFBAy3XXGT0zpGw++k7NBC+FeHECAqwJO8gerSOX2lgmj6XHuTahLCcEC+FKQYzPHk9n6yn7XoJGweRjjtu3ixLb2Wy9TVraZcI82IYciDwYHesXu4Fc63xoK7tsNEJ9ldg0bxLZqzyazDD8pa/o4+55tgA3OKGwamOtPdMXjVZtWQQYpyhva8LAXjja0kGB55e90H2dUotqoTrAez5qUFYpCgh1MdEjc9Ne/lgmJmrzhRBm7/3XRTYL2XWEUUOJtAZSgKQktHrLGNm63w1MzRxAAKay1JOa9+JpNfYeppRRy5+HKb4VGcbzzGxr4P9YGK0gq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199021)(38100700002)(5660300002)(478600001)(316002)(6916009)(2616005)(8936002)(8676002)(66946007)(66476007)(41300700001)(66556008)(186003)(83380400001)(6486002)(6666004)(26005)(6512007)(6506007)(44832011)(86362001)(30864003)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lYQoSv78oF56gEa/NSH6OsmOU6ZVEt8ubgCtL8YTItq9oiue0LM1UDdFtO/h?=
 =?us-ascii?Q?eUnQ3Lanf3vK/V4xc9PBuJmY/3MgzADjKd/NxKyRy7tTkcNCqrYpdtR+pFew?=
 =?us-ascii?Q?lZtAGLBUuOQ/J+ASGIOujEiV2kdj8A/53zII85DOYQJ1pi7NLKvaGWPgYq7G?=
 =?us-ascii?Q?s6fDvkKANzboMmcx51R7w2AfQSZWgWBK61f9GFjs8Dqgs6l1xLyRzd/IorjC?=
 =?us-ascii?Q?7edlWTPUAJk3oiYy6fG7PoeI1BdbDSJqHyYzjSMU7VBYt/LzOrR/P8y0HC0R?=
 =?us-ascii?Q?r0HqUZ0XxMh7GV+ho8Z/eSS8r8JM9t4I4h3TcE6lwfRUXgaea7wKlp4pcv+Z?=
 =?us-ascii?Q?NoxSIbAW7HrBS37tQ1AS4/T2fV9T76zyf8cw/O70GYA+CP4YEBNBD82TgpRn?=
 =?us-ascii?Q?fO2eFrZ+RI98X78px33WoHQSdRyk8NxHeNvPgDvP8Rhq8AyIlHTTiNpyQgiB?=
 =?us-ascii?Q?w41dNqzAaDTxVJLC2hrB9zSB7iX9a2kh7OhEOzESlmI8k3Umn8WlGioQz/xA?=
 =?us-ascii?Q?clVwq2si00ozRNkapW1npriy8taGdV6+K52DbnjvxUJ86gDmg46F9PCac+BH?=
 =?us-ascii?Q?vy7jclnNxlXrbTL1bxLmafNT0PZglFUTmLsz75f3Ma4BobqCfPDT8OWI9iKl?=
 =?us-ascii?Q?qRKoXzXOFUOqkP8+/JJIBs761RzDhSQ0QgZ0BtkD+Zk40MyRh9JvgFRWXUNs?=
 =?us-ascii?Q?oWLQENxags9pFTuENe8xMKgqjqEugfYAhgEepVrNDd3cpsOI6to+UeiYeGs0?=
 =?us-ascii?Q?UXHKH0puqhBGTjdvtalVux9Nxly6MR+ztb9gE9rSG5unXbC8lesGlKBUyAMs?=
 =?us-ascii?Q?PxlHXcQuze/3g8f/T9eulxZ9Yei8F33J5tcVRNBYjjG29DUJnlSJysVqgt0I?=
 =?us-ascii?Q?MdZD05VhIGzejwKx8JBsX3f9/E9RDM9aj0YOBQYK72tfI3wb3M3KW76vTVpU?=
 =?us-ascii?Q?O1Ve9ckyvYiIwWgQIWi0HmKr0eIeGRrF5HmeO9wJXqQbCUTEKfIirU+Dsqhi?=
 =?us-ascii?Q?QP7cHxkKoiaAr8agaoRv4BfEwgZbGtD4XTQP6EQsgsSdcPNrY1qMIkfFK9OH?=
 =?us-ascii?Q?RY7DAkeEmW0uc9tmSyOyAFK58XKBdje6eeeB2wXItpXSh/mb8c9cVdO60YLg?=
 =?us-ascii?Q?0G/C39b/m7dEjtqTQWcBJoNSqj4Oy31lAvAUOBERhoXUALpnf4PuF6t8EKH5?=
 =?us-ascii?Q?SoSNvIuTFul6Vs1A4J70CkP0EXwz6jad143CiVjEn1VeijuPb1g3OcD8ayXP?=
 =?us-ascii?Q?sZkkigVY5pspNT2+rPv06R9ffgf5UmR9i+gmNnXy5WaJ1z2sLGbkZ1aoGPxc?=
 =?us-ascii?Q?cCFcAxGxAgpefupYOpEOTXXLM9ALsNEIr7psZm3hiIGkaP3tf8gROPRWMd8g?=
 =?us-ascii?Q?RaBPL4Lng09uhUzwCwnM9dyI23tGI3KsJIFDGabo9h+ShbaDY+etfxLuLUMJ?=
 =?us-ascii?Q?H+cswzpxhsKGPgt39AzAyp3/n5YdQnHudNJ63gBFMGH2P0E4pRA4L1uXiWl8?=
 =?us-ascii?Q?usZ7WHnK+xp0SOBU31EF59n/PVCH6ab4CTwn13A4VY9Umx9eYP7drlY5D39f?=
 =?us-ascii?Q?J6rdyH4+VIgaGa4Yi/QfsQ5rYrRDvrB/lPHuC6Qh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iIoBZ+gv7T+qx2JBzQq8bY6I651/jWAsggR5r82k9i+tWtS7zvyktAJZVpE/HZlkORs4Hmnlm3jMG2lhbf7EVs+BgwS0MjE8G0WSIKfmVEadGvUMgXIIt/IYTnewT/gYrUdUYIyqu4NkO85ZB4XI+7NNpDJ1ui0SySuGYp2/RhXggHEnephIY5gj27GpGVd3XrUEnRnaTYLs46JzjSBz85hAB49Uh5QSKiNrKorGOg6bkuTHuwAuRH5wnMJIZk7zL/YHiMWqgCDlzbj2RxOim+oU9uCBeYuZjjz8MW6AtayXhzxcS13ztcXZNil++nlbOdF5Oat7+7pj29brHkDWhiyjhUcB8key5rR0ELV/MnVF9wLoC8UjVAHzDADLfhlKoPBRYACkqzAFjFaiTIzjf/922bDq8Zut+vqq6imPFNaL0lSVjn3XSLDbDC3I5DeUImXoybe9Slmh9ekdvESUtckcU1Aefw3lpimxfPbX9bnaoxDDJOGfCDT51PrQIs/6+Y4l1ajuuz+M4tJ+45miobiikiNjOE5wtvaZBs6eHri4H0izBIdHwvNjH9Wq7b1RpeI6Kkxa6Xw9d10zcxJRD1HZg6JhMjtMpxJxi3eF20WOckiV+ZLKbzSPujUHvAsjX6dqz22DgAiWKOKbQp5ed6HpL7MOwoyRmj+xDnesUCN5YmVrU4n0MyJCjIGaE2XTcASXnDT6iM3bLqrQs3WfdGfYt8J7ETGhlLLjmobuN/dxTUgELc0zZJO/F5p+2oR+82uLPd524O8AbNcqMwc4mQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb0a7bc-d41e-42ba-0edb-08db6bf8c509
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 10:27:20.6137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/j+2YwdVGRDIvsBykF3BBhxjA2b6WJS8bDcgyjJOcmwNUJDm/Z1pJtt1gWf7GE1FRqTymDdGTNTbK5j+jf3lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4398
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_04,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306130092
X-Proofpoint-ORIG-GUID: kWtFvjLyW0VUJd3mLJ0_EM3PHDfc9uYc
X-Proofpoint-GUID: kWtFvjLyW0VUJd3mLJ0_EM3PHDfc9uYc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The struct open_ctree_flags currently holds arguments for
open_ctree_fs_info(), it can be confusing when mixed with a local variable
named open_ctree_flags as below in the function cmd_inspect_dump_tree().

	cmd_inspect_dump_tree()
	::
	struct open_ctree_flags ocf = { 0 };
	::
	unsigned open_ctree_flags;

So rename struct open_ctree_flags to struct open_ctree_args.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3: Also rename struct open_ctree_args' variable to oca.

 btrfs-find-root.c        |  8 +++----
 check/main.c             | 14 +++++------
 cmds/filesystem.c        |  8 +++----
 cmds/inspect-dump-tree.c |  8 +++----
 cmds/rescue.c            | 16 ++++++-------
 cmds/restore.c           | 12 +++++-----
 image/main.c             | 16 ++++++-------
 kernel-shared/disk-io.c  | 50 ++++++++++++++++++++--------------------
 kernel-shared/disk-io.h  |  4 ++--
 mkfs/main.c              |  8 +++----
 10 files changed, 72 insertions(+), 72 deletions(-)

diff --git a/btrfs-find-root.c b/btrfs-find-root.c
index 398d7f216ee7..e5a60c2023df 100644
--- a/btrfs-find-root.c
+++ b/btrfs-find-root.c
@@ -335,7 +335,7 @@ int main(int argc, char **argv)
 	struct btrfs_find_root_filter filter = {0};
 	struct cache_tree result;
 	struct cache_extent *found;
-	struct open_ctree_flags ocf = { 0 };
+	struct open_ctree_args oca = { 0 };
 	int ret;
 
 	/* Default to search root tree */
@@ -378,9 +378,9 @@ int main(int argc, char **argv)
 	if (check_argc_min(argc - optind, 1))
 		return 1;
 
-	ocf.filename = argv[optind];
-	ocf.flags = OPEN_CTREE_CHUNK_ROOT_ONLY | OPEN_CTREE_IGNORE_CHUNK_TREE_ERROR;
-	fs_info = open_ctree_fs_info(&ocf);
+	oca.filename = argv[optind];
+	oca.flags = OPEN_CTREE_CHUNK_ROOT_ONLY | OPEN_CTREE_IGNORE_CHUNK_TREE_ERROR;
+	fs_info = open_ctree_fs_info(&oca);
 	if (!fs_info) {
 		error("open ctree failed");
 		return 1;
diff --git a/check/main.c b/check/main.c
index 77bb50a0e21e..2f4fa5ada339 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9983,7 +9983,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 {
 	struct cache_tree root_cache;
 	struct btrfs_root *root;
-	struct open_ctree_flags ocf = { 0 };
+	struct open_ctree_args oca = { 0 };
 	u64 bytenr = 0;
 	u64 subvolid = 0;
 	u64 tree_root_bytenr = 0;
@@ -10204,12 +10204,12 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 	if (opt_check_repair)
 		ctree_flags |= OPEN_CTREE_PARTIAL;
 
-	ocf.filename = argv[optind];
-	ocf.sb_bytenr = bytenr;
-	ocf.root_tree_bytenr = tree_root_bytenr;
-	ocf.chunk_tree_bytenr = chunk_root_bytenr;
-	ocf.flags = ctree_flags;
-	gfs_info = open_ctree_fs_info(&ocf);
+	oca.filename = argv[optind];
+	oca.sb_bytenr = bytenr;
+	oca.root_tree_bytenr = tree_root_bytenr;
+	oca.chunk_tree_bytenr = chunk_root_bytenr;
+	oca.flags = ctree_flags;
+	gfs_info = open_ctree_fs_info(&oca);
 	if (!gfs_info) {
 		error("cannot open file system");
 		ret = -EIO;
diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 47fd2377f5f4..79f3e799250a 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -636,7 +636,7 @@ static int map_seed_devices(struct list_head *all_uuids)
 	fs_uuids = btrfs_scanned_uuids();
 
 	list_for_each_entry(cur_fs, all_uuids, list) {
-		struct open_ctree_flags ocf = { 0 };
+		struct open_ctree_args oca = { 0 };
 
 		device = list_first_entry(&cur_fs->devices,
 						struct btrfs_device, dev_list);
@@ -650,9 +650,9 @@ static int map_seed_devices(struct list_head *all_uuids)
 		/*
 		 * open_ctree_* detects seed/sprout mapping
 		 */
-		ocf.filename = device->name;
-		ocf.flags = OPEN_CTREE_PARTIAL;
-		fs_info = open_ctree_fs_info(&ocf);
+		oca.filename = device->name;
+		oca.flags = OPEN_CTREE_PARTIAL;
+		fs_info = open_ctree_fs_info(&oca);
 		if (!fs_info)
 			continue;
 
diff --git a/cmds/inspect-dump-tree.c b/cmds/inspect-dump-tree.c
index bfc0fff148dd..4c65f55db014 100644
--- a/cmds/inspect-dump-tree.c
+++ b/cmds/inspect-dump-tree.c
@@ -317,7 +317,7 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
 	struct btrfs_disk_key disk_key;
 	struct btrfs_key found_key;
 	struct cache_tree block_root;	/* for multiple --block parameters */
-	struct open_ctree_flags ocf = { 0 };
+	struct open_ctree_args oca = { 0 };
 	char uuidbuf[BTRFS_UUID_UNPARSED_SIZE];
 	int ret = 0;
 	int slot;
@@ -492,9 +492,9 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
 
 	pr_verbose(LOG_DEFAULT, "%s\n", PACKAGE_STRING);
 
-	ocf.filename = argv[optind];
-	ocf.flags = open_ctree_flags;
-	info = open_ctree_fs_info(&ocf);
+	oca.filename = argv[optind];
+	oca.flags = open_ctree_flags;
+	info = open_ctree_fs_info(&oca);
 	if (!info) {
 		error("unable to open %s", argv[optind]);
 		goto out;
diff --git a/cmds/rescue.c b/cmds/rescue.c
index 5551374d4b75..11f351f20ede 100644
--- a/cmds/rescue.c
+++ b/cmds/rescue.c
@@ -233,7 +233,7 @@ static int cmd_rescue_fix_device_size(const struct cmd_struct *cmd,
 				      int argc, char **argv)
 {
 	struct btrfs_fs_info *fs_info;
-	struct open_ctree_flags ocf = { 0 };
+	struct open_ctree_args oca = { 0 };
 	char *devname;
 	int ret;
 
@@ -254,9 +254,9 @@ static int cmd_rescue_fix_device_size(const struct cmd_struct *cmd,
 		goto out;
 	}
 
-	ocf.filename = devname;
-	ocf.flags = OPEN_CTREE_WRITES | OPEN_CTREE_PARTIAL;
-	fs_info = open_ctree_fs_info(&ocf);
+	oca.filename = devname;
+	oca.flags = OPEN_CTREE_WRITES | OPEN_CTREE_PARTIAL;
+	fs_info = open_ctree_fs_info(&oca);
 	if (!fs_info) {
 		error("could not open btrfs");
 		ret = -EIO;
@@ -368,7 +368,7 @@ static int cmd_rescue_clear_uuid_tree(const struct cmd_struct *cmd,
 				      int argc, char **argv)
 {
 	struct btrfs_fs_info *fs_info;
-	struct open_ctree_flags ocf = {};
+	struct open_ctree_args oca = {};
 	char *devname;
 	int ret;
 
@@ -387,9 +387,9 @@ static int cmd_rescue_clear_uuid_tree(const struct cmd_struct *cmd,
 		ret = -EBUSY;
 		goto out;
 	}
-	ocf.filename = devname;
-	ocf.flags = OPEN_CTREE_WRITES | OPEN_CTREE_PARTIAL;
-	fs_info = open_ctree_fs_info(&ocf);
+	oca.filename = devname;
+	oca.flags = OPEN_CTREE_WRITES | OPEN_CTREE_PARTIAL;
+	fs_info = open_ctree_fs_info(&oca);
 	if (!fs_info) {
 		error("could not open btrfs");
 		ret = -EIO;
diff --git a/cmds/restore.c b/cmds/restore.c
index 9fe7b4d2d07d..7a3606457771 100644
--- a/cmds/restore.c
+++ b/cmds/restore.c
@@ -1216,7 +1216,7 @@ static struct btrfs_root *open_fs(const char *dev, u64 root_location,
 {
 	struct btrfs_fs_info *fs_info = NULL;
 	struct btrfs_root *root = NULL;
-	struct open_ctree_flags ocf = { 0 };
+	struct open_ctree_args oca = { 0 };
 	u64 bytenr;
 	int i;
 
@@ -1228,12 +1228,12 @@ static struct btrfs_root *open_fs(const char *dev, u64 root_location,
 		 * in extent tree. Skip block group item search will allow
 		 * restore to be executed on heavily damaged fs.
 		 */
-		ocf.filename = dev;
-		ocf.sb_bytenr = bytenr;
-		ocf.root_tree_bytenr = root_location;
-		ocf.flags = OPEN_CTREE_PARTIAL | OPEN_CTREE_NO_BLOCK_GROUPS |
+		oca.filename = dev;
+		oca.sb_bytenr = bytenr;
+		oca.root_tree_bytenr = root_location;
+		oca.flags = OPEN_CTREE_PARTIAL | OPEN_CTREE_NO_BLOCK_GROUPS |
 			    OPEN_CTREE_ALLOW_TRANSID_MISMATCH;
-		fs_info = open_ctree_fs_info(&ocf);
+		fs_info = open_ctree_fs_info(&oca);
 		if (fs_info)
 			break;
 		pr_stderr(LOG_DEFAULT, "Could not open root, trying backup super\n");
diff --git a/image/main.c b/image/main.c
index c175179e1515..42fd2854e9d4 100644
--- a/image/main.c
+++ b/image/main.c
@@ -2795,12 +2795,12 @@ static int restore_metadump(const char *input, FILE *out, int old_restore,
 
 	/* NOTE: open with write mode */
 	if (fixup_offset) {
-		struct open_ctree_flags ocf = { 0 };
+		struct open_ctree_args oca = { 0 };
 
-		ocf.filename = target;
-		ocf.flags = OPEN_CTREE_WRITES | OPEN_CTREE_RESTORE |
+		oca.filename = target;
+		oca.flags = OPEN_CTREE_WRITES | OPEN_CTREE_RESTORE |
 			    OPEN_CTREE_PARTIAL | OPEN_CTREE_SKIP_LEAF_ITEM_CHECKS;
-		info = open_ctree_fs_info(&ocf);
+		info = open_ctree_fs_info(&oca);
 		if (!info) {
 			error("open ctree failed");
 			ret = -EIO;
@@ -3223,15 +3223,15 @@ int BOX_MAIN(image)(int argc, char *argv[])
 
 	 /* extended support for multiple devices */
 	if (!create && multi_devices) {
-		struct open_ctree_flags ocf = { 0 };
+		struct open_ctree_args oca = { 0 };
 		struct btrfs_fs_info *info;
 		u64 total_devs;
 		int i;
 
-		ocf.filename = target;
-		ocf.flags = OPEN_CTREE_PARTIAL | OPEN_CTREE_RESTORE |
+		oca.filename = target;
+		oca.flags = OPEN_CTREE_PARTIAL | OPEN_CTREE_RESTORE |
 			OPEN_CTREE_SKIP_LEAF_ITEM_CHECKS;
-		info = open_ctree_fs_info(&ocf);
+		info = open_ctree_fs_info(&oca);
 		if (!info) {
 			error("open ctree failed at %s", target);
 			return 1;
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 442d3af8bc01..4e7cc381471c 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -1437,7 +1437,7 @@ int btrfs_setup_chunk_tree_and_device_map(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
-static struct btrfs_fs_info *__open_ctree_fd(int fp, struct open_ctree_flags *ocf)
+static struct btrfs_fs_info *__open_ctree_fd(int fp, struct open_ctree_args *oca)
 {
 	struct btrfs_fs_info *fs_info;
 	struct btrfs_super_block *disk_super;
@@ -1446,8 +1446,8 @@ static struct btrfs_fs_info *__open_ctree_fd(int fp, struct open_ctree_flags *oc
 	int ret;
 	int oflags;
 	unsigned sbflags = SBREAD_DEFAULT;
-	unsigned flags = ocf->flags;
-	u64 sb_bytenr = ocf->sb_bytenr;
+	unsigned flags = oca->flags;
+	u64 sb_bytenr = oca->sb_bytenr;
 
 	if (sb_bytenr == 0)
 		sb_bytenr = BTRFS_SUPER_INFO_OFFSET;
@@ -1491,7 +1491,7 @@ static struct btrfs_fs_info *__open_ctree_fd(int fp, struct open_ctree_flags *oc
 	if (flags & OPEN_CTREE_IGNORE_FSID_MISMATCH)
 		sbflags |= SBREAD_IGNORE_FSID_MISMATCH;
 
-	ret = btrfs_scan_fs_devices(fp, ocf->filename, &fs_devices, sb_bytenr,
+	ret = btrfs_scan_fs_devices(fp, oca->filename, &fs_devices, sb_bytenr,
 			sbflags, (flags & OPEN_CTREE_NO_DEVICES));
 	if (ret)
 		goto out;
@@ -1559,7 +1559,7 @@ static struct btrfs_fs_info *__open_ctree_fd(int fp, struct open_ctree_flags *oc
 	if (fcntl(fp, F_GETFL) & O_DIRECT)
 		fs_info->zoned = 1;
 
-	ret = btrfs_setup_chunk_tree_and_device_map(fs_info, ocf->chunk_tree_bytenr);
+	ret = btrfs_setup_chunk_tree_and_device_map(fs_info, oca->chunk_tree_bytenr);
 	if (ret)
 		goto out_chunk;
 
@@ -1591,7 +1591,7 @@ static struct btrfs_fs_info *__open_ctree_fd(int fp, struct open_ctree_flags *oc
 			   btrfs_header_chunk_tree_uuid(eb),
 			   BTRFS_UUID_SIZE);
 
-	ret = btrfs_setup_all_roots(fs_info, ocf->root_tree_bytenr, flags);
+	ret = btrfs_setup_all_roots(fs_info, oca->root_tree_bytenr, flags);
 	if (ret && !(flags & __OPEN_CTREE_RETURN_CHUNK_ROOT) &&
 	    !fs_info->ignore_chunk_tree_error)
 		goto out_chunk;
@@ -1608,7 +1608,7 @@ out:
 	return NULL;
 }
 
-struct btrfs_fs_info *open_ctree_fs_info(struct open_ctree_flags *ocf)
+struct btrfs_fs_info *open_ctree_fs_info(struct open_ctree_args *oca)
 {
 	int fp;
 	int ret;
@@ -1616,28 +1616,28 @@ struct btrfs_fs_info *open_ctree_fs_info(struct open_ctree_flags *ocf)
 	int oflags = O_RDWR;
 	struct stat st;
 
-	ret = stat(ocf->filename, &st);
+	ret = stat(oca->filename, &st);
 	if (ret < 0) {
-		error("cannot stat '%s': %m", ocf->filename);
+		error("cannot stat '%s': %m", oca->filename);
 		return NULL;
 	}
 	if (!(((st.st_mode & S_IFMT) == S_IFREG) || ((st.st_mode & S_IFMT) == S_IFBLK))) {
-		error("not a regular file or block device: %s", ocf->filename);
+		error("not a regular file or block device: %s", oca->filename);
 		return NULL;
 	}
 
-	if (!(ocf->flags & OPEN_CTREE_WRITES))
+	if (!(oca->flags & OPEN_CTREE_WRITES))
 		oflags = O_RDONLY;
 
-	if ((oflags & O_RDWR) && zoned_model(ocf->filename) == ZONED_HOST_MANAGED)
+	if ((oflags & O_RDWR) && zoned_model(oca->filename) == ZONED_HOST_MANAGED)
 		oflags |= O_DIRECT;
 
-	fp = open(ocf->filename, oflags);
+	fp = open(oca->filename, oflags);
 	if (fp < 0) {
-		error("cannot open '%s': %m", ocf->filename);
+		error("cannot open '%s': %m", oca->filename);
 		return NULL;
 	}
-	info = __open_ctree_fd(fp, ocf);
+	info = __open_ctree_fd(fp, oca);
 	close(fp);
 	return info;
 }
@@ -1646,14 +1646,14 @@ struct btrfs_root *open_ctree(const char *filename, u64 sb_bytenr,
 			      unsigned flags)
 {
 	struct btrfs_fs_info *info;
-	struct open_ctree_flags ocf = { 0 };
+	struct open_ctree_args oca = { 0 };
 
 	/* This flags may not return fs_info with any valid root */
 	BUG_ON(flags & OPEN_CTREE_IGNORE_CHUNK_TREE_ERROR);
-	ocf.filename = filename;
-	ocf.sb_bytenr = sb_bytenr;
-	ocf.flags = flags;
-	info = open_ctree_fs_info(&ocf);
+	oca.filename = filename;
+	oca.sb_bytenr = sb_bytenr;
+	oca.flags = flags;
+	info = open_ctree_fs_info(&oca);
 	if (!info)
 		return NULL;
 	if (flags & __OPEN_CTREE_RETURN_CHUNK_ROOT)
@@ -1665,7 +1665,7 @@ struct btrfs_root *open_ctree_fd(int fp, const char *path, u64 sb_bytenr,
 				 unsigned flags)
 {
 	struct btrfs_fs_info *info;
-	struct open_ctree_flags ocf = { 0 };
+	struct open_ctree_args oca = { 0 };
 
 	/* This flags may not return fs_info with any valid root */
 	if (flags & OPEN_CTREE_IGNORE_CHUNK_TREE_ERROR) {
@@ -1673,10 +1673,10 @@ struct btrfs_root *open_ctree_fd(int fp, const char *path, u64 sb_bytenr,
 				(unsigned long long)flags);
 		return NULL;
 	}
-	ocf.filename = path;
-	ocf.sb_bytenr = sb_bytenr;
-	ocf.flags = flags;
-	info = __open_ctree_fd(fp, &ocf);
+	oca.filename = path;
+	oca.sb_bytenr = sb_bytenr;
+	oca.flags = flags;
+	info = __open_ctree_fd(fp, &oca);
 	if (!info)
 		return NULL;
 	if (flags & __OPEN_CTREE_RETURN_CHUNK_ROOT)
diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
index 3a31667967cc..424b953e0363 100644
--- a/kernel-shared/disk-io.h
+++ b/kernel-shared/disk-io.h
@@ -175,7 +175,7 @@ struct btrfs_root *open_ctree(const char *filename, u64 sb_bytenr,
 			      unsigned flags);
 struct btrfs_root *open_ctree_fd(int fp, const char *path, u64 sb_bytenr,
 				 unsigned flags);
-struct open_ctree_flags {
+struct open_ctree_args {
 	const char *filename;
 	u64 sb_bytenr;
 	u64 root_tree_bytenr;
@@ -183,7 +183,7 @@ struct open_ctree_flags {
 	unsigned flags;
 };
 
-struct btrfs_fs_info *open_ctree_fs_info(struct open_ctree_flags *ocf);
+struct btrfs_fs_info *open_ctree_fs_info(struct open_ctree_args *oca);
 int close_ctree_fs_info(struct btrfs_fs_info *fs_info);
 static inline int close_ctree(struct btrfs_root *root)
 {
diff --git a/mkfs/main.c b/mkfs/main.c
index 7acd39ec6531..972ed1112ea6 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -990,7 +990,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	struct btrfs_root *root;
 	struct btrfs_fs_info *fs_info;
 	struct btrfs_trans_handle *trans;
-	struct open_ctree_flags ocf = { 0 };
+	struct open_ctree_args oca = { 0 };
 	int ret = 0;
 	int close_ret;
 	int i;
@@ -1569,9 +1569,9 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		goto error;
 	}
 
-	ocf.filename = file;
-	ocf.flags = OPEN_CTREE_WRITES | OPEN_CTREE_TEMPORARY_SUPER;
-	fs_info = open_ctree_fs_info(&ocf);
+	oca.filename = file;
+	oca.flags = OPEN_CTREE_WRITES | OPEN_CTREE_TEMPORARY_SUPER;
+	fs_info = open_ctree_fs_info(&oca);
 	if (!fs_info) {
 		error("open ctree failed");
 		goto error;
-- 
2.38.1

