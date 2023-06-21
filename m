Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5B57389F3
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jun 2023 17:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbjFUPml (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jun 2023 11:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbjFUPmb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jun 2023 11:42:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9F519A8
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jun 2023 08:42:08 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LDAoj0003672
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jun 2023 15:41:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=VA5a1M2NlUkcowgigjaCr8xJAaI1odOtSpdF4LYVnLA=;
 b=B2cZ0i5sdio2KumTynBef9cDkIjNRE9gbfkbGrGb0Ok2WRolISoZ0AycW2Mc1sonQQ3M
 PyjKH6BBSsThDFGuBBdppP2s43uDsRrRK8YYXOFYcvCdBYYtWiKci/utCKuqVntDWPdG
 O0MO9r/9CEtJgHkNvh1ATruIveUE0YGi0WNI+nF+0hnPI2i0JJpd+FfFr7mjt7ebRbRc
 e1c03Ll5YqB/RWDHCRCs3onJcKYpF4xioo7toBPvsOAX6daI7rDD/u7B/9ktQr8sXLS/
 YKy6jh5gs7REL30s8L+NKXS+B8L3vWLMMSQh9i52hF6mS+ruohtPgMcD+KooAKJw+mSi Ig== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r95ctys33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jun 2023 15:41:39 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35LFb6Mf032910
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jun 2023 15:41:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9397668p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jun 2023 15:41:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+fUxfmYZBgv7lSJ9uvO4IxZ9uVzF5ZJ9O7we34Z9B+GaU2QvtIA1Th1hPUJNVJ4pewUH6L0XAoHMkOLAz6H5jveXHJ025490kpLWA6BgyyvN5groQrZeG931rBVvnlqP8NFCHBLtHlG2gboUgQnlKibc6CMK7MQlmUh8NcOeCiqcAcypvGJtIwRv1QgPyAVkN+Cv+i2oI3+IugzGWD7SvoADv4wt5X42Altrm1+JPAU7s9P3lyeDX8nNmQ0U8erGZuZ+V2SS59Z8mQWnt9xOj0ptTgMQzAC7WB8aiE91llNhKGNJoy8T2BI6fZShvFEh0ds7ay7TyJd+YpxWCu33g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VA5a1M2NlUkcowgigjaCr8xJAaI1odOtSpdF4LYVnLA=;
 b=jLrTnQZ1ODEEJsRyWolM6UiK6qG0Jvx1MMnczxaeF/GFV6ad5l+Vj4NsSVPMQ0X6rL1x2Mv1/Z3X9ylrk4OWwmwf/Aa74QiJ6Jooo+KVfDXg+IE7TCDXMlkCU4kxM/UCfx65BZ8spklG7RnaEg1tGKx+nJz7H/OWPc/qxKZubrqmz5vaxlo/ppjAl60loGyTNRR7VLTmkEZp4AXsivi9iTSQyuYR5Wo8mwujOn8qlN6SrtBX88trP52BWiGR2qC9jHLkD7hnyUh0Yw/gB0JHHeDKLQcLQ9Mx3T6HR7i1m4NkiGlMMN+SWItk4LkzmbfUUvJbXcD9QHDXY205V6F0ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VA5a1M2NlUkcowgigjaCr8xJAaI1odOtSpdF4LYVnLA=;
 b=WXLgQlIk4kTpfiy0PUapjXEh0WNIVIJSvWNC9ESjsK0D4evEdHHfHE7yGuevQz0MACHcf2ZnCOrIqTQZYS5wo3Yjc1hlSPhqFhGNpahi8jbElCkBoBtRflST3pjWGFKD8gHQ5iwY4DS5AV7Ndc1xYiKjZksyv1OaJ7mrddpXHvw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB5401.namprd10.prod.outlook.com (2603:10b6:510:e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 15:41:36 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 15:41:36 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: dump-super: improve error log
Date:   Wed, 21 Jun 2023 23:41:19 +0800
Message-Id: <1e37dff08e8149c58841266d9ada250025626e43.1687361649.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1687361649.git.anand.jain@oracle.com>
References: <cover.1687361649.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0042.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::11)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB5401:EE_
X-MS-Office365-Filtering-Correlation-Id: 47dd74fc-60e0-4889-621a-08db726dff95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k4cNqiuqbAgmkynNW73IHMb2Pu5l9ptSTcFS6T67K3pVQ41bUv+FOkBI3qpj1A8z7xuUyWIlFj1O+no7Nh2L1YPikZaUbcuEyRWmdvcP0NPoJB2z/f9nli8Gft0gw0wZLNUODUVE3Eb162+v1gtW860TBfFd4/QL+HmBVkiX+HHAgszNS2WUem0mHQ8R/oqhqGp8sYpikfeZv+4s7tmsdzLCS4J7cV2udtGYd2jSvxfIu8r3Fbbvn0KLzzehXke9y/00C9+qvv21JjMyR6FFctjkLRcOikDy55/Cu2VhDgywaKNWZv9lEthO/1uGvTWKaDSw4DtoGL95UqcLkBwuL9ZREJB5NjuOiRAYlb1Q/LuXICXs3tltyQd26ctd9LMcbHfXxsflaF7Zp+rK1EyWK2HKicwqPDxzq7aJ0NCQPOFIp5iKFVBGL5zLNKdz3zusNtG1k4pe/Os+9/+h0MYI+6mSp4i9DnyHnJWPNXW6kM0j9OohwqVhnrclbExkoAM1SVfIScUieiy0FSzxHse61sl2HmsLZGqK1tGHKu3x/LBEDIp0miEwFwRQhnE4dqUb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199021)(86362001)(36756003)(38100700002)(83380400001)(478600001)(6486002)(6666004)(316002)(66476007)(66946007)(66556008)(2616005)(6506007)(8676002)(8936002)(41300700001)(6512007)(26005)(6916009)(186003)(2906002)(4744005)(44832011)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GjFJc4fW2/y03+oXhziC/j2s2m+r8OkIk/2qW4n0+W0FRCAM0ZfFAFxvJa2D?=
 =?us-ascii?Q?u6htNSc7aLPYhO5r2l5Y/8Lvjn5lOiM9cdvr0ut+IxFVc7QOBM22N4HfNPRO?=
 =?us-ascii?Q?v4qaOiEQQG+63leVNEMEDJG7fkGJIZGdAPMPjmd7ZqSIKDueSKDr9ESUwu8/?=
 =?us-ascii?Q?dGJwGKTmxo6I/+UWoBiUp9iniTSZuXmjZYv3B8E45+VdMkgw22SQNL+ofucf?=
 =?us-ascii?Q?o62M67Ai9lzzT6vXvxJjhk/bgsgZsNRqJaxG477j8lxRbsENWbuyJMa0GrN4?=
 =?us-ascii?Q?7cB4GGZmJu7Y94BGR6OB3onTsLd65qxZc91OqCWLk5Hy/SGYpSa+BKUmBQlJ?=
 =?us-ascii?Q?pGc7mJfC08CQwb6CBX8/JILkDzJfCgaTz5VNkn6sxhe2li1kXz1ihBjop08b?=
 =?us-ascii?Q?kmV9Fw0EV2uOJNxLCvK5Co9i+Tq8ZoXHlVEOw3reeQ0tRpG7vdiyii7qGbSd?=
 =?us-ascii?Q?B+HyGczy+SHvi9Yw14X1WwUz6VG5yAqMYqADb55nSPv75K9ErAsxIN8TlH3V?=
 =?us-ascii?Q?WtxboMl2EtVL9L7hXvzjwEK7SvXugHGRLy8glgdVj0zYUsGimHj8/8mCIHld?=
 =?us-ascii?Q?zTJCJDDWlt3Q10gXwoTmAWHjUQGSyLmW2z2ANKxh+wGf6A2jcEO7SiRo5dBM?=
 =?us-ascii?Q?hZ2epVGs1SFFQ+A33rWY0NmSR6K32kizU83x2f5EcOsXbR2KudV9aHXPG/k3?=
 =?us-ascii?Q?sKX/+Pcsah3Q03iSxUv4SjEo8eyZErHPRSWSEz68F3O1prlR86Kk+mWzA38T?=
 =?us-ascii?Q?7Zz0rV//rebPdVfdH0YjUXtesTUm+gmuHZD2WzuVmj5rIZoCtUiuosFxazJA?=
 =?us-ascii?Q?xbmg2k5L0jHW/H8Lh1FmQrHaSfvdXOFYfxjHySQ/zGzV9Ai5qQenlA4KQ0Md?=
 =?us-ascii?Q?Mzv7CK9VZTj40UJn+4+zQEZVwoSBmaLztS3pkscQWMbbjG55sl2sFIYZKuJ/?=
 =?us-ascii?Q?Utk5vkRHZZoVhU6OCGvGWTPthh3B0DzCDkNur8sptzPZIIP8qXNGDrKV4Jsx?=
 =?us-ascii?Q?5V624Gd+2Mu0QNIXWiUqu+RPjjNzi8WzeU0m1MXHsRXRzb8nRJHBUZev1MxF?=
 =?us-ascii?Q?LOtRf1JD1lLeXrIeh71//YwQvRDRUgvyA0INefqRIrdpr2yGkG7S1eEyrmGX?=
 =?us-ascii?Q?o+YXUeuDZ6Latr/xL7MNE8wTGggOnqzoyZhqliAP4hcUDA0HqCi8cEYw7jho?=
 =?us-ascii?Q?3YakZ35GFQKYlOLIJX5tLWUT50AQHi36fAa1UowStwDgWVFUGB4RrAH7xy87?=
 =?us-ascii?Q?8Ayrku7CHRM/qCDk/SRL8YyNvMCRgU3bDkc75uW3zepuXI7/HizvluQ6hwA2?=
 =?us-ascii?Q?zWMC79LTuRtBCW/8xmHC3yGk9sSAf0k8z5YzYKlvzEcqreqyMcGmDlaHW01t?=
 =?us-ascii?Q?PSOha1HhE56LIp6eRhHoJKxPJYczcVvop5kgxrcwF4C7qcsW2bByQstcd08a?=
 =?us-ascii?Q?mwRwtIiYCJ/mry91kkmtcmBEBW6uS3U/68aGyWZTn9nhtg2pzXjOiH5N/P8p?=
 =?us-ascii?Q?7jMyTY4wMdGnrH+SG2+B6GlPw5PtUXuhxfHmy+3XUHv0Lis8+e8AqNh7b1TH?=
 =?us-ascii?Q?jcchY6J6LAwD3e08Pw/YFgtJsW/X7VHKWPpLwEFj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: b2NF3JK92t/RPSZJh6TIg0srVgOTjmfX+6HFpCX8P13H4+j035fI0P/fDSf4p31IdxyuurDgOa2BmEQ/dQQmGCak2tm1skOsDejQeas3tc4mhwrTjaFo2URwE5ismO09iDMGISN3mF/6aB6hxaZKpD0GZ/OuGBASXD88OOJ+fReJ8ZPoTEn+7fYFHfF/72SLOneoszomz4Z5Nl7r2XB4Jm8vMUjJO3m6RVPhR8vjR2xDuOESgRrJn1LtDLJDiX7HypIsDmjRR+9PsaPGsvWc55yu9madUyqLXR/DINyIvqLHJsva0EnUKMvsaje1ya0DwENECyWnT/zmBSpBWQhSfCvOjp33jPOPNZXeS8voAf5TtHS6rJfS2eMk8G45phiP5frVSGT0RsR9t9R4BVZu1GxlUgnXx3/iCjXSO9fqnaTpPMiLVhC7TS7zbLT2Fs2ZzmsZOsrep5mfEF13wk5IPiniEYAsk2GSsd3hUxoOZJjsZtrD3BRc5wfc3EBeyEYK55R7fzEUZ2lLDpF9U4lZQ+GZHLZsfazrqMgOBQy8OspdxRmZOe3YG4f0et1rX7j/NnGbgPStHbkQhXFBMlr2q1S1PQast9xOq/h53AQvAURkLlfXhFrg2JD5Ei81KRHO8H0+aYLHUIMtZFQXYyC6uQWPo1Gk2IZ9aWvO8sC/qVH2TW8KIK5edKpERX2aNzmh5ttaTGnPo50I0j7ZSrmsyt/5YVkMhmBuz00DhfkWYkBYejYSAMnPADfPXWGSoHHXyoRsNJLluIqpPp8lF4sXAQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47dd74fc-60e0-4889-621a-08db726dff95
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 15:41:36.8929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pyREb7DN35AS7QsEGQkXblMeeRIf2FElyCYpCAPnj9g+H++buRZzrhfmXtqtt6VDVr8Bx8JcGZ0ha/sdoP1XKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5401
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_08,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210132
X-Proofpoint-GUID: On-8dNhGx4cUj3cFMVtddB_X6it00hlM
X-Proofpoint-ORIG-GUID: On-8dNhGx4cUj3cFMVtddB_X6it00hlM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add more error info to help debug.

  $ ./btrfs inspect-internal dump-super -Ffa /dev/vdb10

  Before:
  ERROR: failed to read the superblock on /dev/vdb10 at 274877906944

  After:
  ERROR: failed to read the superblock on /dev/vdb10 at 274877906944
  read 0/4096 bytes

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/inspect-dump-super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
index d62c3a85d9ca..4529b2308d7e 100644
--- a/cmds/inspect-dump-super.c
+++ b/cmds/inspect-dump-super.c
@@ -41,7 +41,8 @@ static int load_and_dump_sb(char *filename, int fd, u64 sb_bytenr, int full,
 		if (ret == 0 && errno == 0)
 			return 0;
 
-		error("failed to read the superblock on %s at %llu", filename, sb_bytenr);
+		error("Failed to read the superblock on %s at %llu read %llu/%d bytes",
+		       filename, sb_bytenr, ret, BTRFS_SUPER_INFO_SIZE);
 		error("error = '%m', errno = %d", errno);
 		return 1;
 	}
-- 
2.31.1

