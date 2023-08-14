Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7A477BD0A
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Aug 2023 17:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjHNPaH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Aug 2023 11:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbjHNP3n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Aug 2023 11:29:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C5E130
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 08:29:42 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ECiecZ024721
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:29:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=9pic2CtJryYpk+bt/O0MfSzhrWvyaLWdvm9rN4ajPzQ=;
 b=qc/e9sa+ccAU+Yc0AM8jC91EKww7EBzHOi7FC6sgwWDbTTqTQYpdntNdmZQf66qayMM/
 raX3wI3WprZr3td0zglZTEt1NHsudaPBT1EXpofIlzzIoILTEG//+mFOtesjFyoZZFd1
 t4unyUZB8J1oHNcm8je8vQMLLF8WtWFswI+qZAQx8/Pzx+OgaM9p64/MtkeIKxD8TyMF
 ROSM+MTNb7n/AwGQI0h2nLHCmP1IxeyLB4fGQsC9qwLUXz1kU2SP1wRVw506LPz4B1ye
 fcEsXV5vbmPeZmE+7M0UvDBtuSUsOb3exH11euWKx4o6BimolzlSBi7AQKvSSjI2gWur VQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se3142vhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:29:41 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EF31ca040064
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:29:41 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey0pt14p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:29:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sdpe9+lzZMgCon0/C5NkiFaiwRA7ET9veXUPTYG7IeNzTp8HCs8kb088An+MCYEHnIxtH+i6XnAYrS/gVzAxxKeP2cE8aGXOpSv2LuvK29EVA9XH6NfLm9Yh6BD0qYLPR7HoxO/An6sqVrPsJYsxeAYw6mEvG23SEgNoDgCTlQLGEXhlYriwwtVAbAjhjSmhctevcfTnbQ/YRHKuuPAhMPMwsneBHQnF7mhORuyZuCFdei/DqaKz51JV8J4SnUDJYqzEWuK0AtPuIgTWKt8lmxnOQucPcVch2LrMrS5Lth6UkSgPVGWlEvKxUavvrChkVgkbQZ1WAIy6x6MELZN5NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pic2CtJryYpk+bt/O0MfSzhrWvyaLWdvm9rN4ajPzQ=;
 b=kYQaYMfZ6PctPoZT8h6HcY42JI8cWm/4CWYh6Kz9j8vYtLqNhOuQcNFsgE5onZ3ZwPhEHqMY4mqXp6cPeXUzzdlDWZoDixbfI85tL4m8KCLDiouDNppCaIwdYHoziy+1vSvyssnhe2nQV8MUTIvyzbWsmCn9MvUTBy1YvN7OgVghURGGR38T5Uz+IdcVgvbuU/U0Pxuy24PKyONic0v8IKPJMuRsyWh6CVeTQcPpARMTiFgUfd6ow5MpDjkY+m97W49rJvDZL3fPirYcnTLef0bc1z08Gd+3QsNTBISQha5cQ/SuRqhHxfP8qBSf/FvNcgBRVbrga8AJoRiGjdgKMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pic2CtJryYpk+bt/O0MfSzhrWvyaLWdvm9rN4ajPzQ=;
 b=DQ1WTDTwi26bHFj9Y6jQQH8exnrO2somMTbt2qSXY4JiHTPzh6g3VaGOBPsh/RciEFa2nuVOiDAPr8EjdP39cJ/CL0ouZQ65fwdjIj5AmHS+kgLRT7zrQcC2ayXsZ/OcY3grIiKRTG2O0BCt5VxYxnKU+cVzpDeBtFEYXPcDz3Y=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5214.namprd10.prod.outlook.com (2603:10b6:5:3a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 15:29:39 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 15:29:39 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 11/16] btrfs-progs: rename fs_devices::list to match the kernel
Date:   Mon, 14 Aug 2023 23:28:07 +0800
Message-Id: <2d576d56ebafc539c249ebf42c471a65f7b9bb73.1692018849.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1692018849.git.anand.jain@oracle.com>
References: <cover.1692018849.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0225.apcprd06.prod.outlook.com
 (2603:1096:4:68::33) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5214:EE_
X-MS-Office365-Filtering-Correlation-Id: 57cb573f-4ee4-4949-80c7-08db9cdb45f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fc1VGzTRnDsu2SwvdnwEr/jVmC414blx4NkY4SjHVDbeZCNJQGk/EjgTfb7sAguFAunARBusD/rbmYhKPBDjVMFx7hqOmecc3dD7rHaZlbS/4twr+0xp9QtTmGeJS0R5KDM8p4OukCbE0WYMAm1jGXUrzaq+ATDPTGbVLxZHq3Na7KS/+aDSpkYMwQtLn9iGtOG/+GDOM/sg5JcCRG9gnbYg1Nc+EN3EdMANGHIhm58xbV8LlsrNJp8GCFqfm+kcCtCyLfynCnKWz/EiIvDekEQ/Krvq0CzbEvbxDSAfi5EHXZFXHaegihZxiWrJe8uFhfwiUKWvoiQ9SZDbZdSqACef6YsDZjZvtgfMLendGSdXcbGJ3AmUYN5N4+yrFKj0dK+Tg94vCCNigBD7APPRMNT7n1AdcC0GGQBVuztNxRJW8HzHgrBM928ZpEIDIU00ZkWhqr0j9QjsCPWr0uZ1X6U1t6xwDzQClXQhOqsrxVfs+nRlMM/di8FPg8rV8R0FFKfVLCz//+mMEfpTCP1ELxMX4O0H/2CoK4GfGz1oK82WdmmUkJGvIY6ZEt1zMVbj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199021)(1800799006)(186006)(38100700002)(6486002)(6666004)(478600001)(5660300002)(2906002)(36756003)(86362001)(44832011)(6916009)(66476007)(66556008)(66946007)(41300700001)(8936002)(8676002)(316002)(6506007)(26005)(83380400001)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?26BcyGYVZgBSWHl78vesMEjurYj/e2fEv15YFcDKF3sPl+ffT3/f/6pF6SmJ?=
 =?us-ascii?Q?fFbRQGJRR2llRPckSJb6DD5EQvIIaOjC5ReYAXvIdyfzKtnYeGgZopIx3aZc?=
 =?us-ascii?Q?lEbHOGMfia1Ks33AlASGx0Sa2aP6E3WEH2Ko9wilt2zxi17N3aAOtDWITzhI?=
 =?us-ascii?Q?kDh8DoqfFqT5qxJpXgGp0PMXyvsEcqlssQeJoiDhbV2lKEe3hssOla7X6CjT?=
 =?us-ascii?Q?vzMlBQhDavE/QRGnmnElezuUiRQbXDjNJP5vyjEa/Y/kVPfPwyMz3FfkO5jF?=
 =?us-ascii?Q?cEVQKAbQYGXunQCnP7afsE1kbjPQEMIcRMVrUAJwK7+viZ4PAMQW15D/za7n?=
 =?us-ascii?Q?E+NbJsieewRtAKkmXBiYXeDyYb5pbaVjM/+eVyDsreIeTcporzd2NyFSxx+l?=
 =?us-ascii?Q?XHSoWiFFbcl5OXmMQwexZZOucY9WiseCreZ4AcPLuW+nC5qtWGR1h9qIWT5d?=
 =?us-ascii?Q?uUSx6rqCYzMbv3gF4nOIoeEEQOVTh9N9swhFKQrLvAosyEuc8Tc7vk8tHJJQ?=
 =?us-ascii?Q?nxY8c5IjmRD1YDgcsx58TEODR1FMfvTiltPbvj71IqShGfKzgs7ZiJAKIEaI?=
 =?us-ascii?Q?Ddo9bKjnSnof2enSMFu5FzBg4w7qMEisW0haHwDPhV/zgpcsq2RIDGL2vLSe?=
 =?us-ascii?Q?cbsm655SMMDpt4Z7ryGu43fd7UABjdghsxd8xy5ZOUd11ecCptVGoPmUTXkj?=
 =?us-ascii?Q?WtTFZCC99Rz+dnPIoDUWIONirHED/569m3mfKmPJefUUZTt6Q1gYHzBOPkew?=
 =?us-ascii?Q?kEQxP+thkFtayDrLL5S5KZm1POX/Kuy1Me38YOpEHjO+TDaEQ4ENkI0UKuUt?=
 =?us-ascii?Q?7N5xmIWtdgUtE28HNSNZuGhFCFiQe9njBybw8svSGZRKjIryFDx7KLQRRRra?=
 =?us-ascii?Q?4KOnh1viBCOPCBa1FsIJHKF5HESywIn/mpqWe2myyzKx4EZXZ2t9vSRmi0OW?=
 =?us-ascii?Q?GIgnj/n7h1aFi7z51Pt8La6ps3bNmEUPwFnVIxq5Ds+Vq4Kl2tq9e3iZMKwB?=
 =?us-ascii?Q?jRPqzloc1gb8Kvb5c0KnmVuRxElMHzAbXfE+9w00a8y32wIJcxr5rhbL+GdJ?=
 =?us-ascii?Q?xvdk/3esPMLeI9DB/iadbj9IecidldSsJVnbToUyTp+iMXTdtauAxx9+QWbD?=
 =?us-ascii?Q?3hOXGjFIAhNYY9KkygVFrWmq61Cco4HfClLiBUs51lGzPWG4H/HkZMTyvLFT?=
 =?us-ascii?Q?HC/0aPo9L7jVnCipCcB7S7iMEFWh5eLHCAk7F+Y1m5a67EdpMJsmQ8hbV0aX?=
 =?us-ascii?Q?MWo2wgyIfXh7Vvqmuy+q4HHRX4z+motV+mmfDJy2C5itnQLLIYlCW9rCtcCQ?=
 =?us-ascii?Q?Vuli8df5kpC6erj1oJ7XU5uNSK9J89NTA6nMshojOhBIzBXkeFbB90KObZ0R?=
 =?us-ascii?Q?CZoKccFwtC91HKSGaqqNoIzZEkUIdUEFD9GXCQhwu2VXzy3DPa6yKm/6lwVX?=
 =?us-ascii?Q?ImWgYvLBtRuOpxqROv+5ngHdPKQAdLMJovrpu8EsdUzwoCprqmrYhjB9ubW4?=
 =?us-ascii?Q?BdY1O2GhpWqtOUHDUDyMDtEH01SxPvs+yICxwTIjyNQyAF33zxloOWMeoA2x?=
 =?us-ascii?Q?GVwLHRw/imRDvRqsY5GSbFjg6Rcv0lMfjCXkzu9dQk1JfNU+QBbuWqkuWbZ0?=
 =?us-ascii?Q?KQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1bnD2sd4OIg0mLV2tJgBlSy1OnOXlZ6tax4KOZLcrz+5V7uC3xLW4PoGvyWtEWbhBXkFXH7b272tYPXDYl6kt1RrIB714hmArzgYgOqkhEw3m/V38tFWSBd9uywOcxfDATEYCXRDsm2+/S1tWZve5lMHeXSUpmnizWEwuNr5pTNvsdQVc2fqrTD5OlqIl4qqCRyKJfzNqVf4ld2PAd8BMoW3bKa5vpjtIxCycTo/ajP2634CznYecUbrMlLfOGrh4+uX27dsCLoUgon69cZITo9AjWFki9NIfiJtjID8jy3tH1yHoyPYa3STymFmzDX3od8qCdSgNXjqaDxo6Nj5ufy8wmUpvcHHtzNBpLDi28pPiImiOhye3ACtBEWume48en7OqGM4B6Mis+30iUopAGqQnyxtaQZi/7xDjrguM03wAyW7NH346VBkEmFq17cmjkjLbh1K+2tj9fYABDsU8k8wz7PfaI3tANORi/MDsHCXml10JudLNrNJq+iTn2tn/7nI7AL6xH4J9zfjLeIXR6UGb+y4zNnu2E2UT3R7z8t/9p6RyQ+NVnKOD6WvLZocMt0NHlXBWinzFDARq4tpYiWtAv+m3UDrNgHI8vzmnd2qqCAZPObh7MGMk+qL/hCrQZaG4QXu3bUYiPfBysiHnu1xzMcpmiUadWzBBzakneNWihlEykHIasfjRBL2oPdP10oJ3ROIP9UEb6Vs+WjB07St5vZ42VG2NGO9E2rnWlWCgQMS8LXFmSBHe5oAGXSX6lwU7Rqz7H12d871JY1Opg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57cb573f-4ee4-4949-80c7-08db9cdb45f0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 15:29:39.1795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PgmzRYZfHzR0p5xyeaeaLXpKh7wzqMh6hWnKGTdtxNmnHXauFH+2UuqpIKZut4luoFGR60v12XvhQJXjvuwi6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_12,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140144
X-Proofpoint-GUID: bA8yFJ2Rura3Y3ngW11ri-2-BV0VxfNN
X-Proofpoint-ORIG-GUID: bA8yFJ2Rura3Y3ngW11ri-2-BV0VxfNN
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Aligning with the kernel's struct btrfs_fs_devices:fs_list, rename
btrfs_fs_devices::list to btrfs_fs_devices::fs_list.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/filesystem.c       | 14 +++++++-------
 common/device-scan.c    |  2 +-
 kernel-shared/volumes.c | 12 ++++++------
 kernel-shared/volumes.h |  2 +-
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 79f3e799250a..7dad5f6a0d25 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -485,7 +485,7 @@ static void free_fs_devices(struct btrfs_fs_devices *fs_devices)
 		cur_seed = next_seed;
 	}
 
-	list_del(&fs_devices->list);
+	list_del(&fs_devices->fs_list);
 	free(fs_devices);
 }
 
@@ -555,7 +555,7 @@ static int find_and_copy_seed(struct btrfs_fs_devices *seed,
 			      struct list_head *fs_uuids) {
 	struct btrfs_fs_devices *cur_fs;
 
-	list_for_each_entry(cur_fs, fs_uuids, list)
+	list_for_each_entry(cur_fs, fs_uuids, fs_list)
 		if (!memcmp(seed->fsid, cur_fs->fsid, BTRFS_FSID_SIZE))
 			return copy_fs_devices(copy, cur_fs);
 
@@ -591,7 +591,7 @@ static int search_umounted_fs_uuids(struct list_head *all_uuids,
 	 * The fs_uuids list is global, and open_ctree_* will
 	 * modify it, make a private copy here
 	 */
-	list_for_each_entry(cur_fs, fs_uuids, list) {
+	list_for_each_entry(cur_fs, fs_uuids, fs_list) {
 		/* don't bother handle all fs, if search target specified */
 		if (search) {
 			if (uuid_search(cur_fs, search) == 0)
@@ -616,7 +616,7 @@ static int search_umounted_fs_uuids(struct list_head *all_uuids,
 			goto out;
 		}
 
-		list_add(&fs_copy->list, all_uuids);
+		list_add(&fs_copy->fs_list, all_uuids);
 	}
 
 out:
@@ -635,7 +635,7 @@ static int map_seed_devices(struct list_head *all_uuids)
 
 	fs_uuids = btrfs_scanned_uuids();
 
-	list_for_each_entry(cur_fs, all_uuids, list) {
+	list_for_each_entry(cur_fs, all_uuids, fs_list) {
 		struct open_ctree_args oca = { 0 };
 
 		device = list_first_entry(&cur_fs->devices,
@@ -837,7 +837,7 @@ devs_only:
 		goto out;
 	}
 
-	list_for_each_entry(fs_devices, &all_uuids, list)
+	list_for_each_entry(fs_devices, &all_uuids, fs_list)
 		print_one_uuid(fs_devices, unit_mode);
 
 	if (search && !found) {
@@ -846,7 +846,7 @@ devs_only:
 	}
 	while (!list_empty(&all_uuids)) {
 		fs_devices = list_entry(all_uuids.next,
-					struct btrfs_fs_devices, list);
+					struct btrfs_fs_devices, fs_list);
 		free_fs_devices(fs_devices);
 	}
 out:
diff --git a/common/device-scan.c b/common/device-scan.c
index a140634f5d88..d61018a86f5c 100644
--- a/common/device-scan.c
+++ b/common/device-scan.c
@@ -257,7 +257,7 @@ int btrfs_register_all_devices(void)
 
 	all_uuids = btrfs_scanned_uuids();
 
-	list_for_each_entry(fs_devices, all_uuids, list) {
+	list_for_each_entry(fs_devices, all_uuids, fs_list) {
 		list_for_each_entry(device, &fs_devices->devices, dev_list) {
 			if (*device->name)
 				err = btrfs_register_one_device(device->name);
diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 3ca7a5a62da8..0a3b295930f0 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -319,7 +319,7 @@ static struct btrfs_fs_devices *find_fsid(u8 *fsid, u8 *metadata_uuid)
 {
 	struct btrfs_fs_devices *fs_devices;
 
-	list_for_each_entry(fs_devices, &fs_uuids, list) {
+	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
 		if (metadata_uuid && (memcmp(fsid, fs_devices->fsid,
 					     BTRFS_FSID_SIZE) == 0) &&
 		    (memcmp(metadata_uuid, fs_devices->metadata_uuid,
@@ -357,7 +357,7 @@ static int device_list_add(const char *path,
 		if (!fs_devices)
 			return -ENOMEM;
 		INIT_LIST_HEAD(&fs_devices->devices);
-		list_add(&fs_devices->list, &fs_uuids);
+		list_add(&fs_devices->fs_list, &fs_uuids);
 		memcpy(fs_devices->fsid, disk_super->fsid, BTRFS_FSID_SIZE);
 		if (metadata_uuid)
 			memcpy(fs_devices->metadata_uuid,
@@ -489,11 +489,11 @@ again:
 
 		orig = fs_devices;
 		fs_devices = seed_devices;
-		list_del(&orig->list);
+		list_del(&orig->fs_list);
 		free(orig);
 		goto again;
 	} else {
-		list_del(&fs_devices->list);
+		list_del(&fs_devices->fs_list);
 		free(fs_devices);
 	}
 
@@ -506,7 +506,7 @@ void btrfs_close_all_devices(void)
 
 	while (!list_empty(&fs_uuids)) {
 		fs_devices = list_entry(fs_uuids.next, struct btrfs_fs_devices,
-					list);
+					fs_list);
 		btrfs_close_devices(fs_devices);
 	}
 }
@@ -2227,7 +2227,7 @@ static int open_seed_devices(struct btrfs_fs_info *fs_info, u8 *fsid)
 			goto out;
 		}
 		INIT_LIST_HEAD(&fs_devices->devices);
-		list_add(&fs_devices->list, &fs_uuids);
+		list_add(&fs_devices->fs_list, &fs_uuids);
 		memcpy(fs_devices->fsid, fsid, BTRFS_FSID_SIZE);
 	}
 
diff --git a/kernel-shared/volumes.h b/kernel-shared/volumes.h
index 23559b43e749..2bf7b9d78b39 100644
--- a/kernel-shared/volumes.h
+++ b/kernel-shared/volumes.h
@@ -96,7 +96,7 @@ struct btrfs_fs_devices {
 	int latest_bdev;
 	int lowest_bdev;
 	struct list_head devices;
-	struct list_head list;
+	struct list_head fs_list;
 
 	struct btrfs_fs_devices *seed;
 
-- 
2.39.3

