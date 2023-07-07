Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE0974B4AE
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jul 2023 17:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjGGPyD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jul 2023 11:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjGGPxp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jul 2023 11:53:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADE611B
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jul 2023 08:53:44 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367FNhgS030779
        for <linux-btrfs@vger.kernel.org>; Fri, 7 Jul 2023 15:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=OKSSAO2FySNFU888KIJknebyCV49MOUkfd4IgY8UFHA=;
 b=Owq2fBxYNuVe+PE/gL7yRAV+o/i7Z7nD+nuhw8vhwa+xUWr/RUdKQDpqrexFxOKHCYxx
 gn3UbhcIr1nYT+KQjJ9O/TDS+vT7GXdfUPCfeP03XuWjjO5yWx2swpc5cXhpNluo6yBK
 LtP7kBO4HeC7TD3EdkFeCMkVoY+xDxV/9o6bILdKIMNOjsBHRIk1seXygHxPtGrD80tt
 86SksBMcMNV4zEppXJ9KamknUKx1WNfdWMlhcZJGPqLjRolfgsHxiNgy3G1Ec6iA6Rk/
 hlljEtLw2bz76qD7Rgb0FvPPBlTMkM0UVwbTKch7lqddCS0igWEO36sVnl5Fl0hhfTbD 5w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjc6cuaws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jul 2023 15:53:44 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 367FZkwN024415
        for <linux-btrfs@vger.kernel.org>; Fri, 7 Jul 2023 15:53:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak93ce6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jul 2023 15:53:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuvQnE8+l+GeK5KYuh3nnHEI9BrhYMNQmCPUrbsU0zAEUgRSz7I+rcri2sFQuONbDqzSUv51I6IuD32aQvEkH03fNBH5hg4eEd+VD1dquN2Yhi9BOGrUbv7h0zHCaT+dDshdhpABSJFxtl8ZC50InNeoM5qEw0FqwzEdPyIRevhkTI1pOyJI+DMm6zcTDJagLFup5nv0L0+yXtR2XtkyIjCc5rjeCEkYEGkqZnQUlPrgfrj4rdyDORHjTaAp9s5mLhGgLmgk3plULdXmeqnF1rKIaroWQCmSl3evlD7JgaSPxXqgczcvbehRiItW/nT4/knyPAOgtiKOLVefarUoWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKSSAO2FySNFU888KIJknebyCV49MOUkfd4IgY8UFHA=;
 b=NTaDbDjZ23WHV1enQFGhsc1zrXCJYK58be3006S0pPYIS+VZ5JajAxiWo0I1s8ePFXT1JK7nWhr6XT7Vnwt8PHnBCSX3CbSrC+b1CQT4ZcSK9DaxK5kdFTDDGDJZqXgEUPl3ndnS4CDM+SRfIWuWaosrJYtpn88VOmj+Il6xKT9NDEAtMU+nxQJJ/byeQJ5UM7Cd3yNrhaCt10bfn4cxZ8XKb7MAtz5aKtRxdEdIe1K0LQMIY8KcCCqkou7QwlzTqJWvLshrEMUQi45IB5iUgNhCxzKLKel/HDSpBCjmp6RmtpWUj0GIuvi0vNLCbf7OjPSPcy+S6bwv41Txh0hk8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKSSAO2FySNFU888KIJknebyCV49MOUkfd4IgY8UFHA=;
 b=jufZq+TuPlb2MzPZXs2gIYVCJNHNAAlfucQpqDZlfD/lJJDJVtFt5l0/uwn/9Mq4DfjD1+8iywGLErqTWgtMKeoajQNQ/Kv6sJRb039h8bLk00dizWNuvjx5aUDdyN7few14LE89CueSM7cz7cY99G7cl41dhVjXBQ8XqFNpMNg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB7700.namprd10.prod.outlook.com (2603:10b6:806:38f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 15:53:35 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814%4]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 15:53:35 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 06/11] btrfs-progs: track changing_fsid flag in fs_devices
Date:   Fri,  7 Jul 2023 23:52:36 +0800
Message-Id: <8964ffba81e66712b57ac826c139ee0d8c50e75d.1688724045.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1688724045.git.anand.jain@oracle.com>
References: <cover.1688724045.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: a4bae61f-444d-4ba1-5211-08db7f02524d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Mtz70RZJsaoVwUpuTC0BiIdwuWdWWiuzHvlpqssq9L2rtPydPc1fGa3hJeXo6airP/w7tCAGwwmsxUUBsCoLC7IlvBpfqh9vmZwoEDFVDH9jWUzXFhRq7FISzWamboqkPJ80hmbcvx0yZNQPG2oSFeLivLFdPHkL4azzaNkf8BNhBnrQ8ISVwvuBZ+2kJLbFAJNeyWUtngGvA5bCgLeN7RJDH/wXR4ieu9kW6DumzLmElM/6PH10rxXzW6dDl0ZDodckONR1XyfJYwQLDEQGI2C7R0Cf2yrbWpWZ3lujTC+vSdL0JC5tIXePBPiQ3dIRCOy0Qw/JGpejLsfDBBE6G5LLG8BIED7A2LDV6hJWZMSuNeXQmeFqKjR1VPgMbHnWzH6m/pt3TWGE9UO8gMGP//Z+3IW/5D540RjpEockbWeKYAjX6Eb4CDeJXPyr7DjGDb02BhgQ+PVglZjK+riPzT8VLoFsrUJ1DfdQUgj7J7oeDfzTvFdFqDr5p7RFRXM9mA3MqJanA4pA09v6946XG7ba3RUneVAB5UDcrqByn6RufVbU438PxKYYDdRa6Hq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199021)(8936002)(83380400001)(2616005)(2906002)(6916009)(66476007)(66556008)(66946007)(6486002)(478600001)(8676002)(5660300002)(26005)(6512007)(186003)(44832011)(6506007)(41300700001)(38100700002)(36756003)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HSZmjo9j9Yw3EXaYfvHQrwZRuMK0D4HpdjktiYVEhpoZBJrs01NuroUbUX42?=
 =?us-ascii?Q?7yq3HXIfxRd3oInsQbpZWD4okmMuFU7jmnp8Wr/uUo261f2SRr+v4ThI5nJR?=
 =?us-ascii?Q?pVW92HOTRZO0OP0ih26f1YyR1Rx+NEgsyGkZb+vztFYs7wU/3luJH49EKV2t?=
 =?us-ascii?Q?yQ8LCu3rpS+DiSWhKegQcHX9eBMuM2ZksbYE7t/DF7lIJYpZJB9m4xVxLYqh?=
 =?us-ascii?Q?OkEHZyXDcU9BShCC3rb1PXU4bqKNGFbSDhuR+jDgwHRHkpCyXG73Gg6KhsiG?=
 =?us-ascii?Q?getTkfZhaJyOTYdj40yXTFc4ehdFdU5jbJEv10I78hUSeC5tFK5JmWcjR189?=
 =?us-ascii?Q?SPZPA9kTGS/SpxcACJ7A3HZgyY0KvmeZ7DZBXggiysgUHOfVnj4G0LOPwbae?=
 =?us-ascii?Q?OiggThI7fF8PVQhs7oR6ee9uv0JnH4tta65bXH97XhG/Og54U5N4PGFQlRmV?=
 =?us-ascii?Q?f55XzhD4KrivEEULt+v4r8qfhoZuidUrDC3FlOlxyXiWUzfxECvBJvvm9CVH?=
 =?us-ascii?Q?q30krOeRAcLwEzUwBAXRFBWXMZ3VUcVgqGvYKi5SrImClzqVrhRoRScMmxVt?=
 =?us-ascii?Q?YcYhOA1PClt8NslmBZLKMqsS0ZzKpBZCP5E94W9mudc5sOw9Vyvzqu4WwI7G?=
 =?us-ascii?Q?lqauIfKagKlHwj5Ed0IOPdJ6sY+qDwtAQxJWT9XO8x4YTsV/YjyqxhDJPGHI?=
 =?us-ascii?Q?38ZITD6yVlu4bVKyZa4jes1QvjzeW79B86BHy6K6nbIN1EdSCjA2cdvAWbn3?=
 =?us-ascii?Q?JamzGnZKcr/cFMAGlJhssjSAwRXt6cScLk7uiUIQLQKNTVc6IoEA4Y2krlUM?=
 =?us-ascii?Q?6XNwFA0phZSyx5hw6lZGsIpO43EmPuqs4zR6aduX3WQg8JIjAbABw3QDWKPS?=
 =?us-ascii?Q?xv3CKxMvavRpuAoHHi9oOfcLE641JWKK49kdFgYNv4ONvoprndLmfFl6nMbx?=
 =?us-ascii?Q?Sok5ypOML6AYB/Xd35ntpkupoQjLh+p/ASogA5N46BqTXDW60PFAiUcde3sW?=
 =?us-ascii?Q?718WOd8zAq713kYMG1Er5kEldnjftloXqp7IFvyRCvDZFWvB9I0P0VCDB/SP?=
 =?us-ascii?Q?Z0OBYf+7WIAVlsNpdmOCT0SF1xtzhib360iX89PzCTyrttfxBE8bay+qa8Wt?=
 =?us-ascii?Q?Hi9+TVcmlhfTYW+goHT0g6SWKe1Y471juI+aKrVAAs+7dgTFnSRmXNT5M14h?=
 =?us-ascii?Q?qxrBgZKKYLJyfTAsYVUwWS77I9ynJNw1HMTP1pinFCAJ+8KQcDNo3gVnpDI6?=
 =?us-ascii?Q?TIB0bAIuVMgDTy5d8x7/oAyH10+84hGR4d4VLlZVpMNnJugTCB1HduQsI7a7?=
 =?us-ascii?Q?LCYi7KX7AJiZXGhNtLUAve8549uFUGR1nsZFQe/M9hpYJWvF2KEuVlITbpVE?=
 =?us-ascii?Q?RO7xF/wRC1TMLwTELx4/es7f7Tat3oxqPj5tnzNEFt1tMliJBR6r1aevypWr?=
 =?us-ascii?Q?OhJahd7VYLUubEr1XQVyYy4vNFvy1EH3EYOnCaDiQKa9jf35ohXP9JG58RvQ?=
 =?us-ascii?Q?NSx21vMepc7Dm7ue/8bNRq0i+yDj5+2UmQLRNJYvh2PtWOGqGm3qdUYA0YWm?=
 =?us-ascii?Q?kjNJwW+7edlK0afcfy4LRIQgIiOYUDQwdNqjg6RP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1agIvv6R6qpf+d5zEDgtlr11XxlLTIk4OtJVWIpldnZGC7QUUkyK61Ogx53heDRAf6s5lilW3ciewFfvYkZn1dAjwqRmFdNm3HdTX/vwtQShdwjOi7RIEAJNx/6CfP2GjpZGZh+acbmyNGxrimcVMVxb8KGqQHYbOZ7uzOhXlAn4m+O4QQ7BfrypTk7SL1TwyuK335st2w3yLqUtQKIfusKzdsCrtlsxWmoL3wyMpbpDSXya6DLrF3qP2yKDRc4CjF+LPN0fSzzLwa+PmJVMch5Zru8n1jQdJ1trMQwizwCOcZwXvMAYOTxlNHSwECO0ykBdLSxROWLhuENq3RgOkEsNdz1MvH3Pas73PZN3Q1P1cBVXv3LXdu0a3ZX7ikw5KIN4I+4ePoM8Yg0OKUlpf1T9FlaNgPZl7vxilqG2gdJP4rYWVG/luC6y5Ba/ST+Vax0Kzh95a69e1IknPg1eUk5DNAJt/WCO7hiAdzg7Q+988UNfROjMsYk0cVKK+wdyHgJfg/VqvFDdf3v5hjimkJr+Gn3b48kfoTVE5WrHDyU4UXzK6qLfW9XLFiy8etrAWC0yhuussBn5TAEjmaBxr1Aub6mvt+6O0cpwwhRIprUrBLLSFTtAcambQ4W1hij5C5Lir5vJIMVQxvHShLjq6RuOXgCpow5ykpBBN+3mzeDhHDLwwPp6u9lmR/NeUlL4N2cN8am2ELPHtDZcqjd2R8sG8dBgTdV62f4kznw1fVEFXrg30YwnMcWN6Svk3Y+l
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4bae61f-444d-4ba1-5211-08db7f02524d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 15:53:35.3486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHlPDVSsmimk1QN0qyf9gpgypW97hK7BaSbPvo9RdqbjtCbUk0y6xgibjNeKqwZ3d1F0XeoCEQzwWhxIT1JxDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307070147
X-Proofpoint-GUID: 7DijbkYmqjH1viX1xUoB_YbJ2ma0jhJk
X-Proofpoint-ORIG-GUID: 7DijbkYmqjH1viX1xUoB_YbJ2ma0jhJk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To prepare for reuniting separated devices due to an incomplete
fsid change task, consolidate and monitor the per device's
changing_fsid flag in the struct btrfs_fs_devices.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 kernel-shared/volumes.c | 9 +++++++++
 kernel-shared/volumes.h | 2 ++
 tune/change-uuid.c      | 4 +---
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 4a8c559d4b20..51b3a16a39af 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -342,6 +342,9 @@ static int device_list_add(const char *path,
 	u64 devid = btrfs_stack_device_id(&disk_super->dev_item);
 	bool metadata_uuid = (btrfs_super_incompat_flags(disk_super) &
 		BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
+	bool changing_fsid = (btrfs_super_flags(disk_super) &
+			      (BTRFS_SUPER_FLAG_CHANGING_FSID |
+			       BTRFS_SUPER_FLAG_CHANGING_FSID_V2));
 
 	if (metadata_uuid)
 		fs_devices = find_fsid(disk_super->fsid,
@@ -424,6 +427,12 @@ static int device_list_add(const char *path,
                 device->name = name;
         }
 
+	/*
+	 * If changing_fsid the fs_devices will still hold the status from
+	 * the other devices.
+	 */
+	if (changing_fsid)
+		fs_devices->changing_fsid = true;
 
 	if (found_transid > fs_devices->latest_trans) {
 		fs_devices->latest_devid = devid;
diff --git a/kernel-shared/volumes.h b/kernel-shared/volumes.h
index d2915681e6de..9763c677a7cc 100644
--- a/kernel-shared/volumes.h
+++ b/kernel-shared/volumes.h
@@ -99,6 +99,8 @@ struct btrfs_fs_devices {
 	struct btrfs_fs_devices *seed;
 
 	enum btrfs_chunk_allocation_policy chunk_alloc_policy;
+
+	bool changing_fsid;
 };
 
 struct btrfs_bio_stripe {
diff --git a/tune/change-uuid.c b/tune/change-uuid.c
index cbfc8634168b..30cfb145459f 100644
--- a/tune/change-uuid.c
+++ b/tune/change-uuid.c
@@ -214,10 +214,8 @@ int check_unfinished_fsid_change(struct btrfs_fs_info *fs_info,
 				 uuid_t fsid_ret, uuid_t chunk_id_ret)
 {
 	struct btrfs_root *tree_root = fs_info->tree_root;
-	u64 flags = btrfs_super_flags(fs_info->super_copy);
 
-	if (flags & (BTRFS_SUPER_FLAG_CHANGING_FSID |
-		     BTRFS_SUPER_FLAG_CHANGING_FSID_V2)) {
+	if (fs_info->fs_devices->changing_fsid) {
 		memcpy(fsid_ret, fs_info->super_copy->fsid, BTRFS_FSID_SIZE);
 		read_extent_buffer(tree_root->node, chunk_id_ret,
 				btrfs_header_chunk_tree_uuid(tree_root->node),
-- 
2.39.3

