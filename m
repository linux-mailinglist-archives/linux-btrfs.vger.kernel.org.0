Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B7E73F7D2
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jun 2023 10:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjF0Ixd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jun 2023 04:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjF0Ixc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jun 2023 04:53:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6216B8
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 01:53:31 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35R8Durd013815
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 08:53:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=LmRrtLKqBZB1hd8jwrjjkP/+vsyIB3EDQ82SnKw9890=;
 b=t8e7QliKl6MMCvwJABk9veJ/mR+aHSMje3FpxD24enITafOsYk9xC9xqMcNrUXzI3fD1
 F789Q9qmoCKbvkV3YszGihHB8CC2fZ7NiSsvBjUc4s3wPsbGXf2gKsLWQWWnySJYVmet
 bkZBx+Aax1sE4lNhyJcml+NQp1wlAOkWDBiX2Q+ZJEArDNxmY/dwVsn1NH5XxnyCA+wy
 BNkKZq7UywjKdx5rC7d/r9WtFkCmUx9BYOqLLKzzFSN4/cPG0NHOHy2Z5KWxyV1eVENR
 9lR+k3gYQBE0H3JJXRpz+URDYqXN+qRndgz4j3oBKVNmoYGqG1JzXe1WD/iJxrD/T6vi rA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdrca4amm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 08:53:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35R8Jvxg018856
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 08:53:30 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx4eq72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 08:53:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oi0dXD97BLVRHWsRzdgmhJ3nGyHZxF42YPBsELvHSEIcD+hjqpn6nA2Pd62Cm+e/0uM9navMEBPJOBq5/eGBImwW1KuDx2BoXEE4lUanRwSPBcDtOyAiiolCFJ+pISGWO7TypFB5afI+tujCvm7y7XDZ6rSLB51wk7tn92l5OHhsylb1+ao2JXW0j0ER4qqM9Fcdkwl09+N9/0a6xEH++IoysiBz3P8ME9J/yvKl5OBPWFdSy1qbkyDa/MFqinr24ok6qf+uCWZ5ti90xxv/RZP3JRcEcKKdLv2LpjEmYNs7b8iHCGgZpMNY2qy8IggejLW0p+zeYvAclXQfA19Otg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmRrtLKqBZB1hd8jwrjjkP/+vsyIB3EDQ82SnKw9890=;
 b=mGO9lJ298+Zu25DUuvIk//l2hWo7NfP199IzudAYYtbtIYGn5ohu55sdN86fbPSLzcup00KMwOZGX+R4yUpZiZTO1RtWJL5FfAJBwmnK7wdobisTzjcQ3OZFUYKhkEl84FYEl/GFBtYCz+NYQj343OL9gFEmCVabPXZttDk0KS53oFJcRoSNCMWalZqoheh1rqp+YULHOdmYRFnoTTusSkfJNQeDMkDP1s1Sl+dUowgZkMnOwy023mfVAsWZ3ANegPdjJzzqDRQOa4yTtVwwZvhrOV8gh4a5BHO0R1O9aqF+ulV23iMTG8minwcOFdsUc4NwwTkLCs4FL6SoKqIn0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmRrtLKqBZB1hd8jwrjjkP/+vsyIB3EDQ82SnKw9890=;
 b=J5EEw3A/jwFRsEZqOqZUspPrqQQ42EXUxrY34HMgbyaTtC3qtpjWiPXxdTCsiszS6iMH9XvXxi7+wjaHFfQ/+WAYc0M2j7d23o5pY25cglxO2UCPIW6tGE73mtHriurteSxXwHylcvftGvkhpYAODuCeSSnUR/q5pndB5X/zpAA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6520.namprd10.prod.outlook.com (2603:10b6:806:2b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Tue, 27 Jun
 2023 08:53:28 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 08:53:28 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3 v2] btrfs-progs: dump-super: fix dump-super on aarch64
Date:   Tue, 27 Jun 2023 16:53:12 +0800
Message-Id: <cover.1687854248.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6520:EE_
X-MS-Office365-Filtering-Correlation-Id: 936d5e86-1099-41a0-8a0a-08db76ebf9bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MSglMlhbw58gDU+wfsVSAq5oMsSCeICkui9yKplBs3l4AD2PPK48AgbSs3qA/S3JTMFLIqzxJmfwSvxk0QnnAGZ1TEaHX6YZqc83HExpybEYzZ1G4KpiZzWyGfI/IHYARwBVXAWFstAVf/u2xcNRlkN/lI2s1yOm/JGV1Jb67GvD9wEKTveDrzmMnyfV6OPWOWYSI1U/Q2V+3PqW02OGA9s9DBv3U8xxRzJgqh7RO6zY0g7SzvczVXkG0nkH1TzJ+huQxDmI41KVL6FMVjHQB024xmec5jzzyd/V0TMX+7e2XFq8V5g/mW3DLCX9dJS3wZkUfVyxU7LOcYrQk5S0bqP/1tpPrHN7c+tOVj1ifkYsWjDAJayY3tQqHfr4jIsZ8pK55CZ5BEnLFYjabLL2J3xEYvfX3J0iM7V9KJS83Tn7cJtA+HHuvKFOEou/gwKveOxlCvpiC/w2BHPd6tOmFCgQTX9BClBjM+3Hj69fssyL94FiujrWZKEqFU3l4JS2pk9lyzKs/TdZ+3Q2zhGs7Kab6IUH+QsfWVihLuEWwLprjXa2jP5MrNL5s8HJTOd7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199021)(4744005)(6486002)(38100700002)(26005)(83380400001)(2616005)(6666004)(186003)(6506007)(6512007)(41300700001)(2906002)(86362001)(478600001)(316002)(66946007)(66476007)(6916009)(66556008)(44832011)(8936002)(36756003)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0Prf9piE3bRbgSILvLTyi1ynB1hlN6Q++LoSazwXE+VCI8GPa0DhKxh6APJl?=
 =?us-ascii?Q?ei15Nwf1elrVFSZRlOb/mKxrDNUASrjjgotaHkep8GkHZd+K89bAtZG5D9/F?=
 =?us-ascii?Q?UOzppClml/PgJndeVkWYyUfjeJRoLkIN6ioZkSYydUEc5fti9gYb21rgvw4M?=
 =?us-ascii?Q?JWbwf0AfxcB8xHl6+v9+p6J4s2GwhzsiIjJleHgJe9NXncVJO5Ryo7ueC2pN?=
 =?us-ascii?Q?Q5k0ucXVZJvSo3u90sYM54vtTpdUEz24FPz2JHSqrSgS/e3Sg+l7hf+XNkPu?=
 =?us-ascii?Q?kThN53BTPnS4Qa4DHmbbBi0lVQ7EkyDw03hRgQ0nVsQ7WNWJUkQ9GailbQCB?=
 =?us-ascii?Q?4xRKbfflHyhVq/g6nL9khTUX/r18OlMApJ2ab4bphlm1hktwLANNLbWKU/uU?=
 =?us-ascii?Q?QoWIsfToNpITeen0cCfnEFkf9kf62iu6BE9+Lg/2smk1H8K077wT7RHdX6OB?=
 =?us-ascii?Q?BVauNtAbrwhD3+aFxMvJla3roU05b8w+xKCrHWH97ncqwjbLgsb8GlXWOecs?=
 =?us-ascii?Q?I5tAYrkqpvMwZeyGXbkVrlrZpzHBUIrg9q4hq9nnEzrB6OLzqBkofZBgawG6?=
 =?us-ascii?Q?omAuIQoDHsxMOUD/EnRez5PV+uM0bUVXKioUX+Ual3XeWDW8olFRBH1YnCza?=
 =?us-ascii?Q?JXjmsTJikFctBAb1mC27gRQeGVJEe+9UR01GUA5V6lm122ObMS5bW73o8yLO?=
 =?us-ascii?Q?Tw9S325YHmSN3y5E6aruBcaqx+jmuAAmNvtCTWCb1iTj1s6k/Zu3DqyuGuoU?=
 =?us-ascii?Q?lE6yZyk4aSdHUGvD1qT/+jRYj4M8K0/tUR8MlSSZkP7mvc7KxBfzq8U/8FMj?=
 =?us-ascii?Q?gJZc21nxOyHimsTtbdvjO5msWpYzNuihoQ7qWfuIVLx6OUDtn4RgJSH5e2F7?=
 =?us-ascii?Q?1lf8TKEmdV6y9SjM/1HbCGHGAOfQCnaqlFomIdZW5E70J7NePz27sLe02d45?=
 =?us-ascii?Q?DmB85hMGeTe3aHVRAFk7D5XiMqiKyBysgO1ucSUtaQtoHFtH85CibuZzOr4B?=
 =?us-ascii?Q?iRFrR8ue5/tRXv1FNJmX8gFNYMlkCVyB0hkUuQwowiOvcHiq7uLgylS3VEwH?=
 =?us-ascii?Q?CNxgrFjM9pHeotzoumIdfjgKfG8igXsZnfQ2bdK5mxPXW17tbaouBzBz5mDS?=
 =?us-ascii?Q?iH3doTOWfhDzE1imvSWAV6eSR/wCRa6uMqPSDTybqF1KUreywgC6sy5IspU/?=
 =?us-ascii?Q?jwl7AFYPngZBoS9+xcLq0grNMUkH4cFx/YutUJYYElylx7MU2Y0za1CvbegS?=
 =?us-ascii?Q?2fgK8/07mymGdlyUzE/HWrgItHn4v0PDkbobqExxJT+9NhnQt+D1K6ORxOFB?=
 =?us-ascii?Q?yxl49XjOksIMUU59guFOVGKDBMDcAPq7mkZdaOTk4CeXB4hFtRkgZQ2t3nQH?=
 =?us-ascii?Q?2hPmLZcMaG2DIIcNZj9b6gN/rijlAno3bDJYwt/zpuG9snQktxXYcz/MCnnn?=
 =?us-ascii?Q?oXyMC4yRBefMC8A9/64TCRN+wHzHcyCYkjzqA7LK3DtwxHR2UVV3qVw6STf2?=
 =?us-ascii?Q?ZH4rZ8tysnNYsVez46RjPYMQCiyVokKtV+NSC/8BnzIiC8E8t5FLCJSzcqFD?=
 =?us-ascii?Q?0jgf//MQ2dKXcMDqwwImBBzdy4ohJ19jT0Ig0nri?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wSKSSgfjAF9/ZjishizeHww8ny96NOUOtnM/m558Gc2Oglfms0WGd9WLvu6IOTqhPWBkWrQt+P9xpovweQO8AqLIxNfmYKpMkB5NfKRAxJ/IWTa1Dua6d6qT9RXUSc1QsYUsGKt9RdIm+K0UTKP/gA+yRxPnqU7t2nNQ7et9+3adrRJZezcKO1usczVeD25GGiKlY89fXdcR/ugQUOCebIozteOBKQRGoLoUvHL2c62nTN6bkI43P2ozrx3N2QaBvG7XiGZNKAwGI8LZtdlTk/vVZ62NsoLMvJGbDaeXTkJqxz9pHHVJyzXDbC1rWyV0x3vBqKu//PxqHtcQyb6VvG/H+RAsW7Ljf03bftebhe0T2YHtIEwpbxxwoZRNl5JZx0nvoKk4nDRZmL9npP3WEXT4mniX7CwKdRJyVlhfoh+zfhjCfTIphTu0BjTwgLTdlmu6zhe0A8ND40fLCSbWU/StAWuXv+cjKToA6Za7RoiLz5MBKCAwgYBN/5C2gIpI91dDcXd1RSCFiGl81H3w4SDnobjhPGG5rp3EnqZsIuezqvEoxymBtBt14GzkmfL+cugFXbDU3yCXNz9AzMdIW1PA30Sdz9/O3K6gM8fac6wGsnmL7ssKlBjr8e2QgAzJzV/myuBK16GAxxkTYq38SaHbNDNfx9iF289LOCBMXdBSLp5nY39okuy4i8frlI8k/w/WGPaGoNp2XpLGnhaL1gtJCuCDcYUI+8TP5OaKuz3NKZUXr5XQ8yydie4+trnK5TiFa3xMBUazf+DO174f0A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 936d5e86-1099-41a0-8a0a-08db76ebf9bd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 08:53:28.3372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4R944KgvOd/1UqHtORRS/HKEkPAEm8exY8IbnuChjBwkxqg7Zxsg8DQ8ORCrG/QUYTc964ucpf/58qo6HnmHyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6520
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_05,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=983
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306270084
X-Proofpoint-ORIG-GUID: sZ3ygpUviFwL-Hk8IQit6MEe9zRayJkI
X-Proofpoint-GUID: sZ3ygpUviFwL-Hk8IQit6MEe9zRayJkI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v2: Skip sbreads() for sb bytenr greater the device size.

The command "btrfs inspect dump-super -a" is failing on aarch64 systems.
The following set of patches resolves the issue. Patch 1/3 is enhancing
the error log it helped debug the issue. Patch 2/3 preparatory. Patch
3/3 provides the fix.

Anand Jain (3):
  btrfs-progs: dump-super: improve error log
  btrfs-progs: dump_super: drop the label out and variable ret
  btrfs-progs: dump-super: fix read beyond device size

 cmds/inspect-dump-super.c | 40 ++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

-- 
2.39.3

