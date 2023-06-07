Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9771725B2D
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 12:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbjFGKAG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 06:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbjFGKAE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 06:00:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA321984
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 03:00:03 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3576Jv2W011754
        for <linux-btrfs@vger.kernel.org>; Wed, 7 Jun 2023 10:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=k1bzmiZlM53OVvVyZDl1b+6vfwEcglyjqs/zesI3PFw=;
 b=3hp7nOhVc5kzr4rDQ6q0CnGg5+Fsqdhb42uPkPOPk/15cKNzYycHKWs5kNS45PL+o2PF
 6TNzdo2p6gRy2E56V7BWBpHtcVJrZOF++7KMsgly9IdaefSlsGH8Ueg7jkWqm0y6gjzB
 5fnS9dwEHGdyotmRBy8Tx54CXHeUCu2j/XCFdfwafcw/vYlR+ug44y8B+dJgPQgiU3D7
 BOMHqrqbDpcASgg3VEYXC91DKbyJiY/nQ7TW1pLr8elq/Oehm0eZRfqSYWZS+YueO/iG
 l7ouVrRFefu5p0XEe/n3qEFJF5NfWEhRsvkFVMF9Ipgm7Uq34E7Edms+vx/uM9YzUw4M Lw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6uscum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jun 2023 10:00:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3579YauO003124
        for <linux-btrfs@vger.kernel.org>; Wed, 7 Jun 2023 10:00:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6k1d03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jun 2023 10:00:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4lcxCDbfJPRkM1Yan6Sa/i26gYBSiin7uLzvIIpBWE+aCJmPcmNC/lvBpvkvIZVaGfO0gvp8B1OIyEPG/9ziQTF9motl3+nVX6ClKcG0q2MFc4dVHjN2S38AVle8sJTUIOM8DsO4Ce6XxEUY+04IBtg+gX1HrWzW3nUfBm+eOkt2l9MO3RCGt/ZHdpGSCZKhZwYwoLfZrxn5PoblcEdSZ+Z6YVDHZuSkTBJqTS0Rb5+yPLidHLI9FH9movBAixSni0IQ6pJLdX3KWyGwrDDc1Gt3sxvJG4wlGJ3lLAiAHT2Z4/uuBaWFXd+T/ARI6tDx98aU3OYNSUYrqPnnmsx7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1bzmiZlM53OVvVyZDl1b+6vfwEcglyjqs/zesI3PFw=;
 b=gUfCa2CPtmxIhUA/IFnglIsajgfDDZCiwWO5ARtDdwtfKympCQK9hM5ASTmYw0Pjs2ekJK73aqwebbka1/U0E2c/5zKq64QfGa33EoBCpLe9L4EFqzYF2RW8DI0CbP/MnxEaxYyFbZH5ud5tZepl4WpeZGTWyHOa+vQp1jC7WaQ044B0xpV7/6Q/ka48xSlijXg3ETNvgBw+72cpEoPXwD5s1NaHcWZB993UCvH3aHp6Xrg/4o63cv2/cwR5Rp5D6GCwTpf1/Zdj/zsh2K5pUIBn32Lu7ZJLBTSKnjG2MF7IKCd0eFaoUj3aLRYkpxEqEE5cB0yczKMJFdrQJeU0uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1bzmiZlM53OVvVyZDl1b+6vfwEcglyjqs/zesI3PFw=;
 b=AohBTM92IKGjfCh0WPzlJrFgFuo+I7WdM7ZgEoq73jxUCiixU01FQi5u8+yxRwKI/szw2RDOO182yjRZCrkgL6KsttC01RXiG9zpwJkeCYy7zuIAHjN3nuRz4846faJnMt0pLZ19ft/ZQzQTrCy+tqcQpVAYLh4c3l8HfQ1/DJE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4762.namprd10.prod.outlook.com (2603:10b6:806:114::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 09:59:59 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 09:59:59 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 03/11] btrfs-progs: rename struct open_ctree_flags to open_ctree_args
Date:   Wed,  7 Jun 2023 17:59:08 +0800
Message-Id: <50ea8bac7ced576d011afae890612ab2c8eeee32.1686131669.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1686131669.git.anand.jain@oracle.com>
References: <cover.1686131669.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0187.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4762:EE_
X-MS-Office365-Filtering-Correlation-Id: 1432395a-9dae-4eaa-bc42-08db673df3f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xbzUfgfr00K49cM/DReHslNtWWTu48RJEHCmz0B8n7ldVT3OssxuVBC9HC6rHs4WCJAvHiyu2f8J2+nzUrR4gNeJYKTqYeDZkSrfoJnGBFU/D10ih+bSox8B5jf6h9iNl+2mC0a4YvCT0NM34y8wC2iUUH2Ntau1a6cN4Sf/oc4HxzJ7I+OKLP/mSyqwOn+wxl01NPjsKSoMzLBs4eW0oOvMwZJttto1gRu0oztS4ISSPFgQCPTlfYrwbxpp1YcsWVPNiQTFjdfjcDwlx9ZnZN+ldFi7oZLJD1/V61V97OPsJ0TrGGRzHZWKSHVkQLyQTxemYYJ4mzixSPqUXLGGWze2sHOnsjkesUeOqwzfWvZVcu6YHfb+HKoeUZBaO1SAm+s2IKADT1PG2nyUy4RmmQnj9mwTruTlkJaJ+Wtvf4D92csqDHuQKwaSEQ4HQJuwQkWG2vq+xaWAs7XPhr59b8z7rswhmPsKl7ZKWTeNAicUm4bQQpN15aXD0xHoLnKV+zU9xeNgUeGSWpwSdfHoSmqzq5sVVwNR7MbOkD7rKYKCfBKidJ7OtjgnJIG+c6YB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199021)(83380400001)(2906002)(2616005)(36756003)(86362001)(38100700002)(41300700001)(6486002)(316002)(6666004)(5660300002)(107886003)(8936002)(8676002)(478600001)(66556008)(66946007)(66476007)(6916009)(4326008)(6506007)(6512007)(26005)(186003)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FIkUhL2lmy8Gv+BpE5WfkjGXK5+N5ofSP55j+6F00p0Z8cwnsh7u9H0/fspJ?=
 =?us-ascii?Q?ml2KOGzgoy8OoxxxVUyx5qeVw7VcK6nvXo91OnUS/PGvRGsYlskQ0k5XIr0Q?=
 =?us-ascii?Q?31E+aKvC1m8t7mhFmxJmDL5mnavTVLmFYcZVnql/qwNUdbxaMgQED6XU711N?=
 =?us-ascii?Q?dOWdD1oqTeBHcq8deohD9rPO1ECngwmEDnAOUhOHL4+LdXXYuJRsoWGNZWMv?=
 =?us-ascii?Q?P34M3RdSF8kqOEUy2nqkpbxGMppEjGRFheUh1y1SBgdZUjzX2ALpxdpoF6uG?=
 =?us-ascii?Q?20JUuYPIjS5GxIOkftsrr9C9y9J57ev8tPqzBvowTLjhjmxg9iQ86U0E5fbB?=
 =?us-ascii?Q?PQzXdNAYNi8XWXc2u+1md+13Z4l9k55WPaNjf9GvRRZvxQDviqdCujnC4pqW?=
 =?us-ascii?Q?CkNuggxQqgc41cjmJcmD/T1l31Xqwc2uOCgFwQyH+Bw94JLk+HBijzQGaVv8?=
 =?us-ascii?Q?72NdvyvK9bkbPglKuLd1uFrSS1hIZYa7vWfS5REo8WeRGJTegpkX8cqrd7w5?=
 =?us-ascii?Q?v4k8t2WX8OfXKcRtk12wzO/2vSwkpvQUK9hEquPXUl/kOI8451UqQIwiVenK?=
 =?us-ascii?Q?0n5dGN5eAeKTbav5OHnQPx9IPMbxPYwE/XWpKjJWsQ8PTIMhhnpGzQnIwwp2?=
 =?us-ascii?Q?aQZ3Kx0y179s+4fzsk5AIOSJ83ui/ni/zK5pJyYdYU/7UuVAreFJ1z3HpobE?=
 =?us-ascii?Q?Qf+kClXicbAHcWQnJuobAwaPzrmj2KnpEfGttkhyhpnKAWFb1yfjy3qxtYfb?=
 =?us-ascii?Q?wyQJDC7UusFk21v4EDPCztMTBp/JCN96B1gt3z3Ml4CzzysrYp63dqHYYUTP?=
 =?us-ascii?Q?+zVco/1fbfI2FIjwSxzwu0jhGk8Ld/n8SkvtPOQTPuhoNyTqHLNXA9BJ9ppv?=
 =?us-ascii?Q?BYJjvy0kJgyIHXSPRctOl3BXFSAc5w5QisR85/lIwlqyDr4WZxFJSyHWl6I1?=
 =?us-ascii?Q?qV6TWqO7yOtf21HIjbIrE6UvXy5sSVV60XtE7cir9CCre6TX8e3b/sx7ViTF?=
 =?us-ascii?Q?lPnZnV32YePvIAe6odpK3nSDyMXnqbwwQ9lLzbwqWgqlCoEcnY+9ngF2cbhI?=
 =?us-ascii?Q?KdfWwgiYc+QKUcvw7vEryj5DJ2kXpDKO5SWU2vIKG9WMhitq27q/gQyjLmi4?=
 =?us-ascii?Q?XzRIP5uNu16Dt+nXXGfHsCERh7OMsDmOuj/Nk+Kj2qHsuUJZU3D/EsWregEI?=
 =?us-ascii?Q?7ZGbH7AKN7TzDCI2jPZqADE/e3Iz5tPOvJUsIyPOzi4EqDsPYsUDsV3MGR24?=
 =?us-ascii?Q?3kQb5N5nMrxav5j0L7bqMGjYB0QNcv38zTJNd8msumNK6zmmq9wKp6+ThQGp?=
 =?us-ascii?Q?Eeevtj+7awq6Brma3VDkQE6WsedhZ87QKmwOUZyUSdREjKx+dW9cHTa+Z655?=
 =?us-ascii?Q?4tcDnc1yc6N8oBk6BJci/M+UZnykZEZdoS/l6xiZvvzsY2eyVpmlqvf7fau6?=
 =?us-ascii?Q?uNVEJExXYccgsP0G86ESwBosbtsU65tPb5rnIGXxIsn850PmfBtnjkJQ0KyN?=
 =?us-ascii?Q?kYumex8xNXE9WF7exO0vzfuWfPKb2TgkjJiVzrrlWWe/hkVLX3zmXi/ec3lI?=
 =?us-ascii?Q?86QkPDaddq4ixc4muHqWtCtcFZS6vtdICalWEiF1a3UEWnBYhkBdrtArYSZD?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JTGPsTCgFljn/yLwIn2NqLZFgeR6Ubvt2P8EQysG+H7qRtW+FO5vk0JIvi23qJPLcSkIhRaPrpIRjDMys8DE8TkywK/nxYmpMtB1mjUbeiW7g4tyuEEVf+7llQ1MdFPt8RnkhG0VKTFYaJM963hL1kBMMk/r+5A6ZwuE22bXfWf2kMulo6gduLQCP7ObWpeVO6doamHyknSx+SidF9og+HGNxhDr2gq0auBQ+rxKCpqD7jovk+jbhBkSIv4z+zDu1ItJ6LlBbB8wDUBdQowjaOVaGdq1df0f6cYY/W9WQUrK1ZVz/oHc0ykhrLu5hgoASKFeRSGSJvBUQHDXW3WMP0+5ONpo/OSkjL2/O4MtF2na1qFMEyX27WWgUHazw7bwO0LFmwYv7epWGq/VpllKANCB7uceanMYe4OCiJfxXBbiPpM3n7VLwQmzBMRHvxla56kK/LodUNsGzDW4vUby5hCBRJ6cLNdX3ocCigiV3CIqY42l6VrHH0Y7SV1LPnybf1mpB0pzSyMwsCyxCpZUVv08Ao8z5E+yd0PIKKYLOJgQuCxZjUpGqNvoIn9RD25Fizki9LNnH3xLTVlwqhGm02x9sQrB66irDqdxMlJYNcdm+wCK+DBDeZECFbugb8r/kh7tj6e5gpNropHUl4Oz/mtvQ8zjJLRDHwb2xZdVCgvTtCT5O2wba5Uppg3LvQUcyoEKHMBodv0lXHQ6yYBBzLXxa+Mfbw9lRaFdtSeZkOOfTQlA6TMSC1RAyK6qxbKoXcPRzm4rpeqHtm6IizO1sw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1432395a-9dae-4eaa-bc42-08db673df3f9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 09:59:58.9708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5KxtVXRoyECHxeCJ+DlDGjukJS3YimICllWBzkJMJRcZBv+e6AiaIaAGrt/JxtHxJ/h/X+ap7R3v24o+vX6YTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4762
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_06,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306070081
X-Proofpoint-GUID: 1VElhJoGCBwlmC2eaImJjJyIGJ8cs-yR
X-Proofpoint-ORIG-GUID: 1VElhJoGCBwlmC2eaImJjJyIGJ8cs-yR
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
named open_ctree_flags as below.

cmds/inspect-dump-tree.c:

	cmd_inspect_dump_tree()
	::
	struct open_ctree_flags ocf = { 0 };
	::
	unsigned open_ctree_flags;

So rename struct open_ctree_flags to struct open_ctree_args.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 btrfs-find-root.c        | 2 +-
 check/main.c             | 2 +-
 cmds/filesystem.c        | 2 +-
 cmds/inspect-dump-tree.c | 2 +-
 cmds/rescue.c            | 4 ++--
 cmds/restore.c           | 2 +-
 image/main.c             | 4 ++--
 kernel-shared/disk-io.c  | 8 ++++----
 kernel-shared/disk-io.h  | 4 ++--
 mkfs/main.c              | 2 +-
 10 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/btrfs-find-root.c b/btrfs-find-root.c
index 398d7f216ee7..52041d82c182 100644
--- a/btrfs-find-root.c
+++ b/btrfs-find-root.c
@@ -335,7 +335,7 @@ int main(int argc, char **argv)
 	struct btrfs_find_root_filter filter = {0};
 	struct cache_tree result;
 	struct cache_extent *found;
-	struct open_ctree_flags ocf = { 0 };
+	struct open_ctree_args ocf = { 0 };
 	int ret;
 
 	/* Default to search root tree */
diff --git a/check/main.c b/check/main.c
index 7542b49f44f5..f7a2d446370a 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9983,7 +9983,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 {
 	struct cache_tree root_cache;
 	struct btrfs_root *root;
-	struct open_ctree_flags ocf = { 0 };
+	struct open_ctree_args ocf = { 0 };
 	u64 bytenr = 0;
 	u64 subvolid = 0;
 	u64 tree_root_bytenr = 0;
diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 47fd2377f5f4..c9e641b2fa9a 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -636,7 +636,7 @@ static int map_seed_devices(struct list_head *all_uuids)
 	fs_uuids = btrfs_scanned_uuids();
 
 	list_for_each_entry(cur_fs, all_uuids, list) {
-		struct open_ctree_flags ocf = { 0 };
+		struct open_ctree_args ocf = { 0 };
 
 		device = list_first_entry(&cur_fs->devices,
 						struct btrfs_device, dev_list);
diff --git a/cmds/inspect-dump-tree.c b/cmds/inspect-dump-tree.c
index bfc0fff148dd..35920d14b7e9 100644
--- a/cmds/inspect-dump-tree.c
+++ b/cmds/inspect-dump-tree.c
@@ -317,7 +317,7 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
 	struct btrfs_disk_key disk_key;
 	struct btrfs_key found_key;
 	struct cache_tree block_root;	/* for multiple --block parameters */
-	struct open_ctree_flags ocf = { 0 };
+	struct open_ctree_args ocf = { 0 };
 	char uuidbuf[BTRFS_UUID_UNPARSED_SIZE];
 	int ret = 0;
 	int slot;
diff --git a/cmds/rescue.c b/cmds/rescue.c
index 5551374d4b75..aee5446e66d0 100644
--- a/cmds/rescue.c
+++ b/cmds/rescue.c
@@ -233,7 +233,7 @@ static int cmd_rescue_fix_device_size(const struct cmd_struct *cmd,
 				      int argc, char **argv)
 {
 	struct btrfs_fs_info *fs_info;
-	struct open_ctree_flags ocf = { 0 };
+	struct open_ctree_args ocf = { 0 };
 	char *devname;
 	int ret;
 
@@ -368,7 +368,7 @@ static int cmd_rescue_clear_uuid_tree(const struct cmd_struct *cmd,
 				      int argc, char **argv)
 {
 	struct btrfs_fs_info *fs_info;
-	struct open_ctree_flags ocf = {};
+	struct open_ctree_args ocf = {};
 	char *devname;
 	int ret;
 
diff --git a/cmds/restore.c b/cmds/restore.c
index 9fe7b4d2d07d..aa78d0799c4a 100644
--- a/cmds/restore.c
+++ b/cmds/restore.c
@@ -1216,7 +1216,7 @@ static struct btrfs_root *open_fs(const char *dev, u64 root_location,
 {
 	struct btrfs_fs_info *fs_info = NULL;
 	struct btrfs_root *root = NULL;
-	struct open_ctree_flags ocf = { 0 };
+	struct open_ctree_args ocf = { 0 };
 	u64 bytenr;
 	int i;
 
diff --git a/image/main.c b/image/main.c
index 50c3f2ca7db5..9e460e7076e7 100644
--- a/image/main.c
+++ b/image/main.c
@@ -2795,7 +2795,7 @@ static int restore_metadump(const char *input, FILE *out, int old_restore,
 
 	/* NOTE: open with write mode */
 	if (fixup_offset) {
-		struct open_ctree_flags ocf = { 0 };
+		struct open_ctree_args ocf = { 0 };
 
 		ocf.filename = target;
 		ocf.flags = OPEN_CTREE_WRITES | OPEN_CTREE_RESTORE |
@@ -3223,7 +3223,7 @@ int BOX_MAIN(image)(int argc, char *argv[])
 
 	 /* extended support for multiple devices */
 	if (!create && multi_devices) {
-		struct open_ctree_flags ocf = { 0 };
+		struct open_ctree_args ocf = { 0 };
 		struct btrfs_fs_info *info;
 		u64 total_devs;
 		int i;
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 442d3af8bc01..3b709b2c0f7f 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -1437,7 +1437,7 @@ int btrfs_setup_chunk_tree_and_device_map(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
-static struct btrfs_fs_info *__open_ctree_fd(int fp, struct open_ctree_flags *ocf)
+static struct btrfs_fs_info *__open_ctree_fd(int fp, struct open_ctree_args *ocf)
 {
 	struct btrfs_fs_info *fs_info;
 	struct btrfs_super_block *disk_super;
@@ -1608,7 +1608,7 @@ out:
 	return NULL;
 }
 
-struct btrfs_fs_info *open_ctree_fs_info(struct open_ctree_flags *ocf)
+struct btrfs_fs_info *open_ctree_fs_info(struct open_ctree_args *ocf)
 {
 	int fp;
 	int ret;
@@ -1646,7 +1646,7 @@ struct btrfs_root *open_ctree(const char *filename, u64 sb_bytenr,
 			      unsigned flags)
 {
 	struct btrfs_fs_info *info;
-	struct open_ctree_flags ocf = { 0 };
+	struct open_ctree_args ocf = { 0 };
 
 	/* This flags may not return fs_info with any valid root */
 	BUG_ON(flags & OPEN_CTREE_IGNORE_CHUNK_TREE_ERROR);
@@ -1665,7 +1665,7 @@ struct btrfs_root *open_ctree_fd(int fp, const char *path, u64 sb_bytenr,
 				 unsigned flags)
 {
 	struct btrfs_fs_info *info;
-	struct open_ctree_flags ocf = { 0 };
+	struct open_ctree_args ocf = { 0 };
 
 	/* This flags may not return fs_info with any valid root */
 	if (flags & OPEN_CTREE_IGNORE_CHUNK_TREE_ERROR) {
diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
index 3a31667967cc..93572c4297ad 100644
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
+struct btrfs_fs_info *open_ctree_fs_info(struct open_ctree_args *ctree_args);
 int close_ctree_fs_info(struct btrfs_fs_info *fs_info);
 static inline int close_ctree(struct btrfs_root *root)
 {
diff --git a/mkfs/main.c b/mkfs/main.c
index a31b32c644c9..23db58b7186d 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -990,7 +990,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	struct btrfs_root *root;
 	struct btrfs_fs_info *fs_info;
 	struct btrfs_trans_handle *trans;
-	struct open_ctree_flags ocf = { 0 };
+	struct open_ctree_args ocf = { 0 };
 	int ret = 0;
 	int close_ret;
 	int i;
-- 
2.31.1

