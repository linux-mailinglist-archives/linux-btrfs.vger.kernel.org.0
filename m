Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062345F847F
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Oct 2022 11:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiJHJCv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 8 Oct 2022 05:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJHJCt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 8 Oct 2022 05:02:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C69B9FE2
        for <linux-btrfs@vger.kernel.org>; Sat,  8 Oct 2022 02:02:45 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2987iCJH016836
        for <linux-btrfs@vger.kernel.org>; Sat, 8 Oct 2022 09:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=r6Dc3FIk1dnY/3qNj7zq5mKglVOfo5iosSSQukaa36w=;
 b=DUhzLquxScyhVlghZjb3dKtAizNu+ghTR2szIgdfvBYT6YkCmAG4W7o3wYlRZvVX9k1z
 0Ekh/mjFo+jazj84EdSmvccFtmoXa6X/lYF6QOAsXJDq0Uxl16VTwnh0J9lAsDKy4AdB
 3gm1NgyO/GkNydYG0/nrUb8auf8Q+Ag5BYdULAoi3mvEqxvsmUsRYplp6lvgHFuukFFY
 LK7bPyz/yfXeSUSDkdivMjuj+zEM9vJG/SUiPKzyWmSVA5xrBBnzWYQcXuQlsIwqhm3s
 F5ZYBACrz1PN9z8awYjlbcyjF7sSHBSwikYqpH2JyAg2T1eaCsVpazRWPK7twFFzrtb/ Mg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k3139rd1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Sat, 08 Oct 2022 09:02:44 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2987dOes032950
        for <linux-btrfs@vger.kernel.org>; Sat, 8 Oct 2022 09:02:43 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn1nduq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Sat, 08 Oct 2022 09:02:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4Dqv/fE8pqai84Hy2kXH8FX+Qm4elo/Z6FPVWawaidC3j2hlXNJtSldgt7JICn5/hcjJhejK93HTie/coSGnNboG0ThKnRGykPm9rTRhuGR8UfWUDymQVXsil2qxnswWPhe+97rE26sHI+hyrvTsqlqhP579hT6fugsbUFPI3XgCyKrmHS7UWClbannacj8Bc8ASvJhR5lcD7tGOZRS6JZVBQBYoCHnb7/5RmgSHOkB3d79RqNsmHtT5kXBOZlPyTiGOMfZ7Sz7g7oy0i1o6TnVGfB+L2NtlK8mPTWJpzT6Og2QMjOEiuLItqIdLNe7rfavXqrD2ogW3lQsAd4T1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6Dc3FIk1dnY/3qNj7zq5mKglVOfo5iosSSQukaa36w=;
 b=Oey0yww4uMk/MmVRYg7Z2atyLTEAZpAgRWP0ClLDpEmBijIT/YNfAtlWZF5ej9j4GIip2sbWrHrVqV2xDTVb/zs4Q+tmFi3KrfeniNk9lxH1/5k79NzaxiR/2zIZDBrSM95lmluIN2cbVoP+WhINEMX8eOrO3UcdEVja1hjvK7Dq/mQJ//Bg3SKbaRRzHALaJ+xvsSzCj8lOdx7ViOhkNddSSqAb47/HfPBHcZCCsu3R8AVaBeU53aAGTYdoYaYfz4SdP8WyUrw7FHIoOsmzuG1+vMeBXPZF7KGesn2Ryi+z3qiCv2AvdJwXYiR53aCIQORAtrfccqafaJsxxeZCpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6Dc3FIk1dnY/3qNj7zq5mKglVOfo5iosSSQukaa36w=;
 b=frSnIFdCaKaa/JEGCEdkg8EIGSAUMxjyCOOW4liQTuKO7snItZmVZEXWfPeiwkgT5oyt+b5fCELK3GeQzgtf0O9Y0g8fyb3lrz0/k9055QeB50UuTgq58HBkyN624RmzBuW7YrwRnXxeGve7TJDUVb+TV55GhHO/maUSR2JKKnM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB5177.namprd10.prod.outlook.com (2603:10b6:610:df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Sat, 8 Oct
 2022 09:02:41 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2515:220f:4d94:63a7]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2515:220f:4d94:63a7%6]) with mapi id 15.20.5709.015; Sat, 8 Oct 2022
 09:02:41 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: add extent-tree-v2 support to dump-super
Date:   Sat,  8 Oct 2022 17:02:35 +0800
Message-Id: <78ebe492ca09e716ca5ca2b6fabec0934aaa0370.1665219233.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::19)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB5177:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e7e2668-e88c-4354-a5f3-08daa90bdb0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ow18J+HzUbRbvFXkYH65NjgZ4VC501DAEPOZL4a6dhk2zH5mPd/ehV+fOTYqWnjBXjWAJ+hypaqMmJ4oZL2M+ZkRmyph037/bZWbJfHPOLsmZ/d0E6BfUeQzFsAsn+6bNkmP53cB8yVp56rhvF97dGsBaLShwm11eeVdqkaZBSFolTG/utyqHZqPeYMl76QtrhP2BbqbLQuqfqlqzOhU2AHr9gO3Bl+sJ2pW1EgKa+EvAGODvQLgyPxERHPwZ8Wkf+V+TchGLmcrXVE1+vnFST6FtTJQKeGPrZqifxZMwPzl/i1TU3Z3DxHQbSv47xcx7FwRzZYn+R6kqtlOvHaZN/nQw14d8hWyU2DIVgE8HwqSvbAsqOZ54giTOuHISqXbtXZ/4W5ntCSud2+Jmsydqw2GH2hkCRUZ3uA1o6otAWGq/P+otNDeDSovYEQytPPrHcDq/uQrGWfILRC0iCRv2scg1+Ajw+2TB76mccvjQKcXNFwV6CNJjzqRYpRTN4yCnq8DQdBAXRc58k1wGviVRHkywv0ZRAjv6B5mf5IBD0XW86G/jzFyBgUx0GOyZUfm47mH5YfsGSuMhWD67NTa40EN6uMOI3RktRuVvp0sXbmCcXtq+N36m2ARyII8f6HFlr07gFVswbZ5QjK0UeoC/wnE+a1fvwMl3Un1qGRDa6t2CNUZjBJekZ93gEqdn0s63iAtCL5bNKhfV0rS8Qn9NQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199015)(6666004)(6916009)(4744005)(5660300002)(86362001)(6486002)(8936002)(36756003)(41300700001)(44832011)(8676002)(316002)(66946007)(66556008)(66476007)(38100700002)(6512007)(478600001)(6506007)(2616005)(186003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PL73eIDKnCRi2yr1XtkJfaSs+x3dZ+xJWgbQVsfAIGFbonarBCkDQNccRDe8?=
 =?us-ascii?Q?rFFmN9MopGA+jPEuoqpWMVQj2stxA67N3oEpsyddghjaYEVsU8AgzJDO/kdz?=
 =?us-ascii?Q?m8TNuqTwgDzRoi9Ee7i61aDmpmnS/+DTnAPWLWFgME2YkLahXnrRcUYBoLil?=
 =?us-ascii?Q?YXHTYy1gqWUDLnb3MG4dCdP/MZ4JH5Uk3o2ffuzfcHoWLicQ7UIyEHjMNhQ2?=
 =?us-ascii?Q?HckcuxUf6nHRnIZSY53jc2Ri++6iYbHxyvcaqs2RUKuT4HKhJFJUaajkc8uh?=
 =?us-ascii?Q?jXEAVhEbxh9/yVX1RHUWhhbHxXDzfeW5MoWCsoq3V7kx1SWUQsib1RaJu0ko?=
 =?us-ascii?Q?4exauOflCCHYbM+2qVwsXtMBnFGQiAiA3tCFp9tmOiL4N7Y8qqqi8Nzzhuea?=
 =?us-ascii?Q?tugziITGqYB6dhJCrlRZpyLbeYxv91FiePOSh4bnMY9/jNSz26CssHax3Lvo?=
 =?us-ascii?Q?7hne/aSuMagL3vX7YrkS9ZyQdX2tMpvQ0gPm3UOPRYeuD/ANnYyIBxQzx+9w?=
 =?us-ascii?Q?trHOTrXBUXXRrNm+gP+z55S1wwSqpcdh7lQCiuKL8CR7zCB5681p9WfSGy5P?=
 =?us-ascii?Q?j6fZo7d7Dz3BSDIZpT7oqnT2FSm9wuGZvfFbxnciWKhpOX0Joc9jKn7buDr8?=
 =?us-ascii?Q?TijWkrHixszdZV/j0NyvVR2U1qJp+5kUODkJiRhiXru5GH2wQN3o57xU4+C3?=
 =?us-ascii?Q?A2GXR/LO4ljjuN0oELr8uh341/JL2W0WHymuecaNXNKjo/sWt97OJF5xSK1o?=
 =?us-ascii?Q?LrJHGOKxwxda9BSyCAi4ZQDyoKs80nkoklrYMJzYjxEdWW0NXzcu15TTw6Ia?=
 =?us-ascii?Q?NEMK6FyPMqnwUdvbdtV6yB8yLfrZwn9QQFBNImB9QMXqdGjLjiO56JBYM2Ls?=
 =?us-ascii?Q?YoPBieRvruAgmbKuQ7+lIA7LefcSHucAHnExkzrGTzYWz8g6oqKSSBxnVhYr?=
 =?us-ascii?Q?zcy59w9ID3pREx26DsY1sfStD1AxlWemdfUmY5madylgNwP8cULoFsXVpSlN?=
 =?us-ascii?Q?zyQj2SABDkEs/rb2/RvtgLbNlrp0HccPOx0mCIStrppn+ZmUj7B6WGmQe6ia?=
 =?us-ascii?Q?oJIdrNiaa4HPwlufzhBqpEteNwkZIz60OFJRq/dHv8cZXq/N5BlmCWpQGTcQ?=
 =?us-ascii?Q?KuJ/4NiWfpiad7rJbbwBdj6NkVLSzWQd/vtnpTnrPUofGsVVsWTS7mmzLxt2?=
 =?us-ascii?Q?RVlPrp4cX1XC2a6tyFVY/kq45SDiIFxhDW5IjD1nr8JG9cXImrWUnLb6fXJ3?=
 =?us-ascii?Q?hD8g9CfPjKsY1dSmJ00nD5qkToiae1O3TRM0qyaRWwHYiQnxQkJ/IaxNTjIm?=
 =?us-ascii?Q?WzmZ/V55dALiHpO1ahzngru2UBA195ply8hxiQVGLLNPtslk3YYZ69BerKbC?=
 =?us-ascii?Q?v7gLMF6P+GidAaN4aK9LdHllOoLtA0PFZm/f6ExLbbYFB91WOvgorv+MkXGE?=
 =?us-ascii?Q?XIfY+X2QK9F+JZC91pJtuCts4L/CET9JyxRLpdrtiZ7y/CtBHjCMjecXAybS?=
 =?us-ascii?Q?PZef2tT4tRNqiFnkKjVL+MKgTO2LQqMDr1jGt5b4YxRfVaArDAAnirSINesc?=
 =?us-ascii?Q?OGKDpkTknXxKZtCJBnkEWRBK5Kz8qC6nv0BmGJG/u9lyhw5OfWLW8rJ30z4A?=
 =?us-ascii?Q?jwrv3on3NqQaY6rdIrm7hrk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7e2668-e88c-4354-a5f3-08daa90bdb0f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2022 09:02:41.5378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMc4xcGzwv9bHMKErTCQP4oANSmfrfnBiUf1rDsI+53gA3akFdmAJEJpl7aQt8UDjO+hrSQ3Sr+Adh56UDNQRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210080055
X-Proofpoint-GUID: UJaX8OCcxEF8-z1a83-8rimz2BtcfA5V
X-Proofpoint-ORIG-GUID: UJaX8OCcxEF8-z1a83-8rimz2BtcfA5V
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 kernel-shared/print-tree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 5c3d14298b58..6b5fd37ab2bc 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -1689,6 +1689,9 @@ static struct readable_flag_entry incompat_flags_array[] = {
 	DEF_INCOMPAT_FLAG_ENTRY(METADATA_UUID),
 	DEF_INCOMPAT_FLAG_ENTRY(RAID1C34),
 	DEF_INCOMPAT_FLAG_ENTRY(ZONED),
+#if EXPERIMENTAL
+	DEF_INCOMPAT_FLAG_ENTRY(EXTENT_TREE_V2),
+#endif
 };
 static const int incompat_flags_num = sizeof(incompat_flags_array) /
 				      sizeof(struct readable_flag_entry);
-- 
2.31.1

