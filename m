Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90C377BD05
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Aug 2023 17:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjHNP3h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Aug 2023 11:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjHNP3N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Aug 2023 11:29:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E729B130
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 08:29:12 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ECiecO024721
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:29:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=um36b7D9W0sJc82qe75RFVzMFoUGQXuMRpva0QEAl5M=;
 b=NbY2rKxGsVe37MNXXfYNxNK75IYtXKajHtDhAzFvkMO3UJtIoeePL6JAgJFe/O4rAr7e
 hJA+DjlRyAVgI/o4685UacaW3Cpsmh/t1NjYm5xzLuTlzQPERVsxKJ2EdaKlyV92h8Ah
 KM4P/i68XnoKBdn4xqi/tTyxWFZF0dZWOYPuANXREAwXhMLKio8/FrKpiLuE9V8HlNuU
 QIGluzBQqTryPdnEYOPW7vKMN3c8O5DtFKS5zcMTp8WaXw1ncsYcf9bZEaghp/G3iQP5
 DMLdMcDXbz51HGRGtFew9hYEqcoHAZm8vUoSNIgzGe1j80Qibyhc3ZHfP5txiq4u1Pti Aw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se3142vg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:29:12 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EF3cjv019807
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:29:11 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey3u9yp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:29:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5yRL4pfKHrOcgIIEueQtVIY8XnZNyM4NxMwHQqHCbXhoqmPIVtEjiaagSsg95s0+KL5mhgMSaCuaYgyLeWxEutKVdiNy2LC1omUdYjr1cyj7bKi+LnrrAKjc+gpQMYEpelZx51ZA2p2DGC60sbXB3eH9CQPTPk09rr3I+IexrGpeyU6vwaMB1ClNVghV+HXXYrsn66HVqAQogyaRnbesy/9PoQwi54zG9if/MT+IE8zWA3oS86LpJ/8o8PsJ/64ZSyeEv03KF2LwLkrGJ651cxBGT6I9lspJj7Ma+0av4CSWyD/8nQEDxqJ/D5VZQZD9AJwxgUMvqAtzFpLPyW4oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=um36b7D9W0sJc82qe75RFVzMFoUGQXuMRpva0QEAl5M=;
 b=PqlBvr5t9ERJ1UpZ1CFR0dX6RnWokGSXc0mwaUJ585JwE/6rfzBda2aRMl0EZNvpOvvmnI0Ks1JLDVVDS6lZTb2XdVEvNHHhx0N26K05ZVGTOfxalRjRE93K6mFFtvM0Aah4D+yU+hGiGBRPp57qok56//nFbyQyn1rxtfO3iUtdnDYdTAKg6Iim3n/9XP9DHPgdFPNE06jFX3eWn9kk+KA5WwXJ5OBvUJZdpzLkgH0uvOMcEo5slKv1tkK8OoeRPH4mRmZnv9Xc5ATX2KbPlnT41CqoksTzgPSFy6X/Sxi9ShdJFQJLDz2jQB3atGrMrVR6JaNRBz1Sqh+Egg3daQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=um36b7D9W0sJc82qe75RFVzMFoUGQXuMRpva0QEAl5M=;
 b=VWDIA2IAnYpgZQqB0RyJSA2pH8YyCOif6W42ENHHYqOj2FkuvWotUNCzBvkDXXnXAjONGIad8FaaqHUI1zVQ2n+I266fGUbpY9ht7QL8BRrhu788XXbPCDCuDZtKGg+D8GoyZ3zl4yULAAAzLpolGOGzx69GNfcZS9XER1ITsW0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5214.namprd10.prod.outlook.com (2603:10b6:5:3a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 15:29:09 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 15:29:09 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 07/16] btrfs-progs: pass fsid in check_unfinished_fsid_change arg2
Date:   Mon, 14 Aug 2023 23:28:03 +0800
Message-Id: <bbdc2e713b2213eea59b87add474bbce560c83d6.1692018849.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1692018849.git.anand.jain@oracle.com>
References: <cover.1692018849.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0119.apcprd03.prod.outlook.com
 (2603:1096:4:91::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5214:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cbf657f-ade5-49a6-434e-08db9cdb3476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JkKK3Mx9mCHPLn6xTVMAe+DQUjJVgWXXjkBsnT/RGUgtT2LSVtLoCDFG1SETzq6dpYbZPCG2a5XhhL7+yruajrgoY2vHSY7crMbwbzv2AvuYqSBFvdGpAZTxa3rxzF1enwxENDbuplK4NLMDKhJl6frgiPt2JCtUyfefbEWjOe164y2SHYhU5KO4k8fitdW7N/H5LQx0gTiC8cplYmtB3N1nqOdZN5lG+d8kxvP8G9U1uVZLvku2hDlUEOiJiZHJSIBOT8dvxooVkmKnFsH9LDMAgsOR4jFRrVqGCBUzrzfz4G5xcgIdj1ZBBY7/qlXceX/cfuzTjDMTFgRAG+3NuLcdqJvOdStaVhqConw/DXbbgWsCECnadeDmxnUT2xkibnLlaUSd4fIKeg7k/LK9Q/Q5r+RM6AQJqSalE2nITEIM1zHyNZ45NaPO06vGG4tMgURb2s52/MNLTo5DIgfLJhcmCExa1WENDvxIPZYnPMo6D5IymXjy21OdTa+8V2dbG5c1eZLTrwEq3j7AR4cEKdN8ovaugoROYKtuyJuS+P13Xe19Ol8Roj98dQjqAgAd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199021)(1800799006)(186006)(38100700002)(6486002)(6666004)(478600001)(5660300002)(2906002)(36756003)(86362001)(44832011)(6916009)(66476007)(66556008)(66946007)(41300700001)(8936002)(8676002)(316002)(6506007)(26005)(83380400001)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RVIbKHbpFOnluBwBOePZcMeEAlJSKqfi6gfYhcKeBupo61ngv5XFoTXBRmsY?=
 =?us-ascii?Q?TF7kmD/dyYByhSXXfUpX8fnfGMYAAdZubDdZGlL3lsvBLM5P7VTkt0BxuIlk?=
 =?us-ascii?Q?ug4HMjeiuLjn9b3LGdaCN1eHkWqjXE+G6uGpmub8HSdfWrmKN72V1B3NXhEW?=
 =?us-ascii?Q?ify62q0OglpQCZxBFCPK357lpEgZrZpqAZ7OFBxVljUSc+5aD+I9pnYHMe8q?=
 =?us-ascii?Q?oRMY2fCF0bqJXo03e4XtNb4feUojkNokFI/eFXrWh8AshPaSCNaywYmhnrwd?=
 =?us-ascii?Q?nhxT9GeRNak/+teyBq5cr2PqQc45uFCLJrdW6EMGzHrw7G829r4Xd6lx2z1W?=
 =?us-ascii?Q?cVnuylio7ZBFbtxGiYEutWGN1QlYo+EvQiQhWfoZZgIB+iJE3R4LT0A8jFOu?=
 =?us-ascii?Q?MrRkTXKoaE3UacvVNLuhzP3Lada5VMcEfJxCCUU/Lsxp/7uZlYQ60OMtdgXw?=
 =?us-ascii?Q?zRlJI7p0SoiWe3jQJ76Fw9OE0LX84wnAU05PF8vhEResWWgHBJBLKQ7kAfMY?=
 =?us-ascii?Q?rKTaL3TCXyy4fQmly1EwHEH93Gf6fOPT/QWPQZgSJmjN/jjd+gdAV/9/KrGR?=
 =?us-ascii?Q?m9O+nT65PkQ9/HJC/4g0nUvZhAVb863zULnSBc+LLZ2X9+XWTHus40MbwRvX?=
 =?us-ascii?Q?3+/AU/6YaxCtOUM/AKkdTAomwrSJkxnKLXpiouNAAVG0hMAz7v1LzJ1YOPXZ?=
 =?us-ascii?Q?C/XYRCwMMOjo5pMP7/srEvA3GPKbLDzm2Sh4yFTdmHiq+gwUyOG/yXarnvGo?=
 =?us-ascii?Q?IZL4HnT4h9ylzsRkKJR+v0OdGve3o5uCV8P3/esS7Zp7bLDbkwYiMJDqIK8I?=
 =?us-ascii?Q?+gbJ7zlZLvwK8mZqd87P/5+qt5PWIqkDSPy7s8Gg8j0XoEYFrsg5Ws97j28T?=
 =?us-ascii?Q?3dT8OEECfs5xlAiW1xOIZQjNGYvJdnmjkJcNrYzVI0+3gw2/YEh9uSbDDpBo?=
 =?us-ascii?Q?irW8tG9tiKBbIy3/4/+As6/C79pThgJ/qNPeXTnU7z5DUFeBoYEWfcFdi0Hy?=
 =?us-ascii?Q?wzknEYxuPFH2SeGS7NFNh2JUFNCAdtkJEbmdgj53JGHFKwO0uv3pVKrMjgkt?=
 =?us-ascii?Q?mlIPKBvAczaheVkW0X8ZIXFvaNGC8ewkkWyElSN51BbSjWzhyOKYf6pw38Og?=
 =?us-ascii?Q?VZRdHdfdryiVAFg0n6dSTwKMPkZ3ZE/Mg9vIqu8PLl/9Ugph8YUJHNVC+J10?=
 =?us-ascii?Q?TICTmEoNdTgjz4hopwzeRq59NhGbuu5L/XxeKAsIy4Sm6WU3h9lVhiqnx1Cq?=
 =?us-ascii?Q?371lSBD2oRt6Tdcpz2Hp0lrXKrqhol/o36s6rYtT81XsHs9+Rkhgi3bjoJAs?=
 =?us-ascii?Q?jOQXAliofRZ1WAqoo21d/pqBTy3Z1L+RO9dzdxtBRTLmxeEA9X6zBPjjonFN?=
 =?us-ascii?Q?CEwp6o+iITDTYVJg0Zc7iU9kYKXrGUvnrvOpZlQS1ARinrfo4pXzBYglMYKt?=
 =?us-ascii?Q?sdj3Ntqf35iybZD6w5I1IuxUsmilYfgn6aoRdJheBZCzhUW9siH1nTS1/Bnc?=
 =?us-ascii?Q?52oFioqT2uM02ig7MjUt6T56dTUjx0twxfiwqph67UYmeBk6kxlyG6oT56Ox?=
 =?us-ascii?Q?cKcwlf4Lxloly5BpNc6MUzIThLrou4qVgeYx3ksI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ohIJBsqZA3EqrcVg+4TtyPGneoVsOuDPCAEL+gMTrxn6+pyaxxUgoJiWMNcI+lTDWSoVQD5CZz/ufIB0AT45v2w1k8Fz76ZwvygOvwV2D6PG1qaEWG5cYHvXTTiyyT8Ya5cBnONF/g4XAAcD+yQstMzYxrJt350E80AYMDZKeW/ciEV2035dVSZEdNFp3M5vHdUoH16uKNIa4qoJyII4bzp2T25JwOpAtOPQ4YT4YVbcculC5vVkWzESouOrUmCO+sJXQUJ4N3n4boCM/V0os2aFQvL/J9VMLmFdv+oYXMmBqbH1udU0QfQ+Dye3ZoNo/bJOGvbNTRA/iNmR6RWpKUvKrYeM04JQyaNWvUmcUbW03NBlMFKQEKLAwjjMsllpydusB7XzLZkdG1xgzCZcbKbuHrbXIGa1KQs5pxJEAYdtNTBiWG/M1FHof63lDKw6iRBWljqtaQWt1wWOmGQFtDRHK4+MtmktnedvT8Op5e4kYOij4BzGZVRB8eHxy8QP9aVDyrdQnVpyV4fCgbhAO94QHw3rLS7jmoiuyw8uwNDheZUugk++jxuWcfF6tgWA7o2p9MyPiK2RiFlJEaE8UV8/4Ry83hHt2JztUnwZsx8+FdQxK+O0oOqfz2UDJG6j+qYqbOMt9SjQLiDl4f8XM/OK6vTp9n+tuz69neX2QGbi2GvfqFRk+P15cyCCMRUsA7LIPm4sjAEev6a4+I/MQTwUn4sAt1f0hCm5p41/XxN0P4xkTZZ5GSLx+K3I9Ce43TN6u/rTBqGNWZpFUUSgsw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cbf657f-ade5-49a6-434e-08db9cdb3476
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 15:29:09.6418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4jpCZDlu8ysNW1UxR8d9LmpGAlWFlWJO1RwLApDNScxcF0p0jYwRhxLrgTj3LJiMANwUYO93sb9UVvaSQS7twg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_12,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140144
X-Proofpoint-GUID: 6bfxbGYSI7-QSBUWp7EdPBqqiB-1vA0-
X-Proofpoint-ORIG-GUID: 6bfxbGYSI7-QSBUWp7EdPBqqiB-1vA0-
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In preparation to use check_unfinished_fsid_change() to support the
ability to reunite devices after a failed 'btrfstune -m|M' command,
delete unused1 argument instead reuse %fsid as the function
check_unfinished_fsid_change() returns the fsid.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tune/change-metadata-uuid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tune/change-metadata-uuid.c b/tune/change-metadata-uuid.c
index 7bf30da4c3b0..a49adda8dd29 100644
--- a/tune/change-metadata-uuid.c
+++ b/tune/change-metadata-uuid.c
@@ -27,7 +27,7 @@
 int set_metadata_uuid(struct btrfs_root *root, const char *new_fsid_string)
 {
 	struct btrfs_super_block *disk_super;
-	uuid_t fsid, unused1, unused2;
+	uuid_t fsid, unused2;
 	struct btrfs_trans_handle *trans;
 	bool new_fsid = true;
 	u64 incompat_flags;
@@ -45,7 +45,7 @@ int set_metadata_uuid(struct btrfs_root *root, const char *new_fsid_string)
 		return 1;
 	}
 
-	if (check_unfinished_fsid_change(root->fs_info, unused1, unused2)) {
+	if (check_unfinished_fsid_change(root->fs_info, fsid, unused2)) {
 		error("UUID rewrite in progress, cannot change metadata_uuid");
 		return 1;
 	}
-- 
2.39.3

