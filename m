Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A13D77E1AF
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Aug 2023 14:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244194AbjHPMbM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Aug 2023 08:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245326AbjHPMbA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Aug 2023 08:31:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D4B98
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Aug 2023 05:30:55 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GBewjd020076
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Aug 2023 12:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=ogxP/SuXnI75w6Z6dIHxorhrZrTzvihVvvaR14lwTIw=;
 b=IAjH/HcAIT1jQ4nkBowdVA2Scu+Rg0zYKVhG91yWxAtAdJbBF5yfwS6/jfQt/SJtJYbe
 PigSaBLt5ZUgSIdhqapDfQlGEk+pS5Um6xGo6mH4WoZqqEsL5++n5L9sAv77SMxLOIUa
 dvTTUv1e9Fm1jLY/ngZ/SANdc2VZjXRlML2B5J87TCdLlnqmBsyrX4FubMnKqm8l/24c
 qO/Yx4iG+tx5nUlerdCR2jGni40cZgekbVWNkb2j6NR5aQDj/B17QWqtsgVPlTQIb1uG
 U+LscJhq1lexVchbAi6x10gZ2XFhlhla0nZpWYGM7uKOQHpPp1u1tB/FHm34X5q2YE8H cQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2w5xx3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Aug 2023 12:30:54 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37GCAOYT039408
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Aug 2023 12:30:54 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey71ccae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Aug 2023 12:30:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVS7RMxfaOZkZqz5Zs7gjj7r2bmTUBrhjjR+XZ1RBx8mOLadF/7yxVRUd3aDNabV43z28AHkPH/GpR0fXJw8r0oHu8Mnp4es38+cV42f1U6Gq5oiw7Zndoliy6UWs3ZdCZC+mZ6plUum7wHJruH0QlOF2B83fufdOweFSLIPARYHFVE/J6+qQVA870SDARrcGZ7pPD2jKpN4F4a8jrqi2HT8FkGF1Wfc4kaX3jDSl3DZwYDKtNYCQjRxxer1J8xpZKAl7dqC5dUhX4d/txjna/IXbS4LbBs2qqV9SwLdq9ilZZaiB1LoYs79T/MDFuHiiG6FYpG3VYgGMB7Lqhyx5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ogxP/SuXnI75w6Z6dIHxorhrZrTzvihVvvaR14lwTIw=;
 b=eeewKZLpIBzmqDFXyFnJiTA+yYVHt28wE4Y++wWCfKLeUOPS8QPC0MB1zz4RY7JcruT9dXuEMtlkMx1cgMnrkNbMY3gdusQaKEKKux2BNshT4MlL0sDX4crpkuKrvVikn13ScVW+pImR/15PiGAnNMoo8TEYzOzbAHUzzYuvh7yCtGPMn2+A6u0HwjXdMX+Hr02qENmpErChQplSI2KIsfJSDdnhcVkIgv9abATJUiVNr64tCjfnVAZnoApZVACfbW3FIvKlqPSPRp5lijnzSA8JCLKIZVGgRZ5SGCX+Bl/ljnlLoe5zXQt/iQd5Pl+Ol0I8y9VxCir8NugpTSlvhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogxP/SuXnI75w6Z6dIHxorhrZrTzvihVvvaR14lwTIw=;
 b=vmdXP5taNJQIftJllZ7VWBi/+ITbND+pT2+pwuK66rQOjKlh3LOJYgHy+u1uFW/+EKY+ebm4+hhIa0ubANNxOKHXPNoET+Arri/JQSq+keXA8mGx8LqL7/Uhz5wjxEcQpNqnU7NzCCzSJMKRyLauXIdQbL/hTkrKqKrXkPweaSA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO1PR10MB4659.namprd10.prod.outlook.com (2603:10b6:303:6c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 12:30:51 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6678.022; Wed, 16 Aug 2023
 12:30:51 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH] btrfs: reject device with CHANGING_FSID_V2
Date:   Wed, 16 Aug 2023 20:30:40 +0800
Message-Id: <02d59bdd7a8b778deb17e300354558498db59376.1692178060.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO1PR10MB4659:EE_
X-MS-Office365-Filtering-Correlation-Id: a6978790-8217-4b77-acb9-08db9e54a074
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2hC1rOrGIhgevUDAkuFOHMgTlGJnAR52M8PlxnLL5MqorQqyP3/ddf0h7vvsHIjsNMrWPl7/ZIQOjVNy0INX3FrwKJDyls/A7jmZWIo6GfVpIe7oi7FmwI9/WtXYfq/glvqApoH8b3/053JvlqPII9s4UJ4GKbF3QLwPhEKS2bPYkjrHINBd2ONWCRvO5NbYZBA25L7Q14kN7H/C5/d3DqUnK3ifEbp42cqxm6DkpP140sTwx/2qDJ/sD4Fa0m64TEk9oOdu2Vn2EGQ2fle1VdqerPgFMGRk3zf55re3lDguFr102js0JhNjUrB4qxh49PsF3UpYv0az4Xf7qJpsOsLQvwE89xVV8oRFTf1s9hYWXcCN7MhhtyBX526f0xApwEZJ5C195Mzth2f0ntpjpi7pgP1zrv9SxEOMZUFDDxDNiNG738bfXbQood5H7ff16ORbFg9torYqeMjfREX7mykoPxfSaRYqYU8w4K3qq8StfxA217rtaQhYeZF8hEEZi0ia1MSSgm87BHe0YctzVUAepVd/ws4z9WCQMz7AVlEMYxET/yyxHTsCHAV+9lcm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199024)(1800799009)(186009)(30864003)(2906002)(83380400001)(86362001)(478600001)(6506007)(107886003)(36756003)(6486002)(2616005)(6666004)(6512007)(26005)(5660300002)(44832011)(41300700001)(316002)(66946007)(66556008)(66476007)(6916009)(8676002)(8936002)(4326008)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?evf//uapgRTnLwPd8rqrM5nlcw2uvrytNNbHeRKtOze9/FIF/I6MIZGIJkyQ?=
 =?us-ascii?Q?qFHTRHaBo2ocKxUCBpirJEplazTYF7d9hNp0S7hbpcL1mHvMXO+EGSpDznGr?=
 =?us-ascii?Q?D/Z3d8P88Kk2/ZZZNGYHR3K2WhdQtjYyG3CB88uNeL6HdMUOsr1Urr8fsnjL?=
 =?us-ascii?Q?SpTDIN6U+rgompr6FZSEcWu6QZRyebrmwN3eztgsuegXlqec6T1C35MUcpPW?=
 =?us-ascii?Q?f7fJSz364/8l4Jvv1mPP40T0pscqoCIKFzDuGLNPdd9PZ15iKNn9aHiprnJk?=
 =?us-ascii?Q?8+YpK6ncEVSSkZPY7NK0OGMAJGYQ2WPaGKkS5KFBla/KgrRZ3KLkSA3yTl2C?=
 =?us-ascii?Q?aw+KgTNEZOwau5CVILYYIypyq/u1l87m41VYV/qC4A+8zJjfGFbxh1NIPcja?=
 =?us-ascii?Q?9C/Vopp3wjtEH1xrGiHpXFvthSo03WZH8h2vA9lpfJBZ6DwTavrW2H5eoifS?=
 =?us-ascii?Q?lqzBc7deB/40SROjG7QqUES3J/rAmWgkJDSRjKGhM45CJcF5lZnTaQzq3kFs?=
 =?us-ascii?Q?S1RhjdehuAb9HRK4j7T8nCT8mD2iwXhL5YoRTZ3aBapPX1GWoSReetUglX6/?=
 =?us-ascii?Q?4QakERB3+0n2rURRrBrnlUYLX5nxwTCe7dQLW9BoDxyrmM0TlTpGbHESJ0yl?=
 =?us-ascii?Q?65mVx8M5yXs8rCjUekYTbnzk4Bxjz7pQz4EPdzCIE+XY1ygXqbeULw/NGaLK?=
 =?us-ascii?Q?E17LM2UYZFT1kcsoJLEDcnUcwSaCK2qzY2Tk+GKvJAF0823tNbuhjjo67ATy?=
 =?us-ascii?Q?o7pTp/UQzYsk+K8Oc3kiFV3dp9ANjG08vQ1xhK1wxVHMiozzN68rC6YIYyQS?=
 =?us-ascii?Q?QM4ttLukHWyKCXmLJHXBU9JTAdKzGDILmjz+VdQsLOcmYLf9qXX4bdvy8mOI?=
 =?us-ascii?Q?uxHBsFCG6nmA2GucBqXRkieFXSp+JUNZJQ5Ntps1skPLT74PMQtYuaqx6Iww?=
 =?us-ascii?Q?Bj2FwZzkRJx9GQLVHiyLQoP/J4majGcjpYrs1ULPQSaRA87r6tCE2bsaolUB?=
 =?us-ascii?Q?xZzXRNUdmgRMqKX5sTGNLjCQbc7DUenF9n7lfSUhGhmVHnvokYK8teZhqM4E?=
 =?us-ascii?Q?8YZPgT5J9hn9LWpFNswlpFs9mkiUCugHK7oIr7yBRd4j0e2WvmMp+ploe/eH?=
 =?us-ascii?Q?vO+4ASkMEOKTyRvCQxjWvsIpXMy0Ig4NY14iKAfZL++ZupmV9VfJJoLo1sEs?=
 =?us-ascii?Q?VziMKlwoLoPvGKU1X4xH2oY4aDsPKw11UC1vP6xP1HyLby6ExcZhmyZLyLSy?=
 =?us-ascii?Q?I5f8S5CkgH/KqsMPhyWZwUhRWJ+NMzbEQ1PVDo+50Nqb+vhs6jdIpsL9KIHz?=
 =?us-ascii?Q?L8jmfuWJWxxDFoZcHCeN1rWVffKlwzTjihZVT6FfCYJxT3SIPj+hCMGIKQiv?=
 =?us-ascii?Q?I9ABsdN61De+EU/Zla2EZvfpJBzeAE60C81S7iIqtx4TQdv3QwMXD2OcPPBm?=
 =?us-ascii?Q?5XrvFSLaug1AndBVt0pNyxkjzqVEuAQatLHOiMeyYp6ceJmuA9R9rWWFNOJo?=
 =?us-ascii?Q?CHb+DBwvaniSU/skKZrdU66uc3bzY/d8W2WmuD+tojLh99VbP/z91zj5H0kb?=
 =?us-ascii?Q?eNa0k+MHcgouqO6QkI7V/BgDPbobXNIMxccLWj2XwRmbIW5Bn1jdLZ/5XVqz?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hU7VJ/i96EQWyNHeFs33XaXQ72UKI8Wv70zWmuETgln6C2+eduwfG+ljoyRSzQYZ0sZUVQzOOGfAkgSYTNsC2OxVgh+KBfTHUfx2DoOGZ3fjmX4J+KBBWwBJY2vTBqfMkTJzIBF3ZVDaAmT9um6RnvdfXfZit4o3dXMkCDk6mc4YxeFr0M4Rt+AVXBJYYtTAUk3pUSe0ULwRH/zbdg/fI9/zKQcH3WZZ2S08i6yfQNhbl0BzjlC4TP0Dszcag0hgM/Vzs5YfjZCo56RYei8iIMoY6jQhSXl8vtZziESJU02JfnGFHER24X3qkAxEcb/bTo8jfrDO6v21sKMJvDkSaogw8FhE0QRLTW3+LxTCVeqfq+QltsfIgC/tPggSIzoOnOL9ZJf2fM/CeP5esLgCGwnS2YZys/AvUSL1soX8pdkmxwAv6AQ1SjeHqLhizIEBvr6P95042jbkQ3PJDeW2V9IhnJjc4GY4jqmSTWr8PqFhw559ZBmGT8X2AY5wMUilJ0g77zC0wIE5WQczdBh+kb+IQLRwvhMK2mJv/ejiFNfQjlf40JDkHYByGjYctkCX3KkQv8WTay/Gof2VZOOqQvU2YsUOFuAaaPMWATtgt39a5zupmBKQaSmWBslBHMHbrc9/w2l34aXRb9WjtuXqGDzduJjqQ+dXwtrxOqUs7QNTcfEIKcfeL0qvcXmmrot5NTA8g0uHln0F6AMZFlBO1CEkgbin/A8xeySS8g/pXMtWtWOzTewEm0R8RWP/oaxgc/poIVwK0+K92491WdSNjg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6978790-8217-4b77-acb9-08db9e54a074
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 12:30:51.2660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxYV96sulbFsvo89Z9z7+D5uTlFmq+BBMDQaSIbzTUONjTf3kbEUGj1/shTbuOc9WXtfferlH7VpMYfr0vgkQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4659
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_11,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308160110
X-Proofpoint-ORIG-GUID: gqBYa1LU6-99kyqTcISHdNJgVm2ZIaRF
X-Proofpoint-GUID: gqBYa1LU6-99kyqTcISHdNJgVm2ZIaRF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The BTRFS_SUPER_FLAG_CHANGING_FSID_V2 flag indicates a transient state
where the device in the userspace btrfstune -m|-M operation failed to
complete changing the fsid.

This flag makes the kernel to automatically determine the other
partner devices to which a given device can be associated, based on the
fsid, metadata_uuid and generation values.

btrfstune -m|M feature is especially useful in virtual cloud setups, where
compute instances (disk images) are quickly copied, fsid changed, and
launched. Given numerous disk images with the same metadata_uuid but
different fsid, there's no clear way a device can be correctly assembled
with the proper partners when the CHANGING_FSID_V2 flag is set. So, the
disk could be assembled incorrectly, as in the example below:

Before this patch:

Consider the following two filesystems:
   /dev/loop[2-3] are raw copies of /dev/loop[0-1] and the btrsftune -m
operation fails.

In this scenario, as the /dev/loop0's fsid change is interrupted, and the
CHANGING_FSID_V2 flag is set as shown below.

  $ p="device|devid|^metadata_uuid|^fsid|^incom|^generation|^flags"

  $ btrfs inspect dump-super /dev/loop0 | egrep '$p'
  superblock: bytenr=65536, device=/dev/loop0
  flags			0x1000000001
  fsid			7d4b4b93-2b27-4432-b4e4-4be1fbccbd45
  metadata_uuid		bb040a9f-233a-4de2-ad84-49aa5a28059b
  generation		9
  num_devices		2
  incompat_flags	0x741
  dev_item.devid	1

  $ btrfs inspect dump-super /dev/loop1 | egrep '$p'
  superblock: bytenr=65536, device=/dev/loop1
  flags			0x1
  fsid			11d2af4d-1b71-45a9-83f6-f2100766939d
  metadata_uuid		bb040a9f-233a-4de2-ad84-49aa5a28059b
  generation		10
  num_devices		2
  incompat_flags	0x741
  dev_item.devid	2

  $ btrfs inspect dump-super /dev/loop2 | egrep '$p'
  superblock: bytenr=65536, device=/dev/loop2
  flags			0x1
  fsid			7d4b4b93-2b27-4432-b4e4-4be1fbccbd45
  metadata_uuid		bb040a9f-233a-4de2-ad84-49aa5a28059b
  generation		8
  num_devices		2
  incompat_flags	0x741
  dev_item.devid	1

  $ btrfs inspect dump-super /dev/loop3 | egrep '$p'
  superblock: bytenr=65536, device=/dev/loop3
  flags			0x1
  fsid			7d4b4b93-2b27-4432-b4e4-4be1fbccbd45
  metadata_uuid		bb040a9f-233a-4de2-ad84-49aa5a28059b
  generation		8
  num_devices		2
  incompat_flags	0x741
  dev_item.devid	2


It is normal that some devices aren't instantly discovered during
system boot or iSCSI discovery. The controlled scan below demonstrates
this.

  $ btrfs device scan --forget
  $ btrfs device scan /dev/loop0
  Scanning for btrfs filesystems on '/dev/loop0'
  $ mount /dev/loop3 /btrfs
  $ btrfs filesystem show -m
  Label: none  uuid: 7d4b4b93-2b27-4432-b4e4-4be1fbccbd45
	Total devices 2 FS bytes used 144.00KiB
	devid    1 size 300.00MiB used 48.00MiB path /dev/loop0
	devid    2 size 300.00MiB used 40.00MiB path /dev/loop3

/dev/loop0 and /dev/loop3 are incorrectly partnered.

This kernel patch removes functions and code connected to the
CHANGING_FSID_V2 flag.

With this patch, now devices with the CHANGING_FSID_V2 flag are rejected.
And its partner will fail to mount with the extra -o degraded option.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
Moreover, a btrfs-progs patch (below) has eliminated the use of the
CHANGING_FSID_V2 flag entirely:

   [PATCH RFC] btrfs-progs: btrfstune -m|M remove 2-stage commit

And we solve the compatability concerns as below:

  New-kernel new-progs - has no CHANGING_FSID_V2 flag.
  Old-kernel new-progs - has no CHANGING_FSID_V2 flag, kernel code unused.
  Old-kernel old-progs - bug may occur.
  New-kernel old-progs - Should use host with the newer btrfs-progs to fix.

For legacy systems to help fix such a condition in the userspace instead
we have the below patchset which ports of kernel's CHANGING_FSID_V2 code.

   [PATCH 00/16] btrfs-progs: recover from failed metadata_uuid

And if it couldn't fix in some cases, users can use manually reunite,
with the patchset:

   [PATCH 00/10] btrfs-progs: check and tune: add device and noscan options

 fs/btrfs/disk-io.c |  10 ---
 fs/btrfs/volumes.c | 166 ++++-----------------------------------------
 fs/btrfs/volumes.h |   1 -
 3 files changed, 13 insertions(+), 164 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 9858c77b99e6..98e73805f3fc 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3156,7 +3156,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	u32 nodesize;
 	u32 stripesize;
 	u64 generation;
-	u64 features;
 	u16 csum_type;
 	struct btrfs_super_block *disk_super;
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
@@ -3238,15 +3237,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 
 	disk_super = fs_info->super_copy;
 
-
-	features = btrfs_super_flags(disk_super);
-	if (features & BTRFS_SUPER_FLAG_CHANGING_FSID_V2) {
-		features &= ~BTRFS_SUPER_FLAG_CHANGING_FSID_V2;
-		btrfs_set_super_flags(disk_super, features);
-		btrfs_info(fs_info,
-			"found metadata UUID change in progress flag, clearing");
-	}
-
 	memcpy(fs_info->super_for_commit, fs_info->super_copy,
 	       sizeof(*fs_info->super_for_commit));
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 852590e06d76..e3a83f779558 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -453,58 +453,6 @@ static noinline struct btrfs_fs_devices *find_fsid(
 	return NULL;
 }
 
-/*
- * First check if the metadata_uuid is different from the fsid in the given
- * fs_devices. Then check if the given fsid is the same as the metadata_uuid
- * in the fs_devices. If it is, return true; otherwise, return false.
- */
-static inline bool check_fsid_changed(const struct btrfs_fs_devices *fs_devices,
-				      const u8 *fsid)
-{
-	return memcmp(fs_devices->fsid, fs_devices->metadata_uuid,
-		      BTRFS_FSID_SIZE) != 0 &&
-	       memcmp(fs_devices->metadata_uuid, fsid, BTRFS_FSID_SIZE) == 0;
-}
-
-static struct btrfs_fs_devices *find_fsid_with_metadata_uuid(
-				struct btrfs_super_block *disk_super)
-{
-
-	struct btrfs_fs_devices *fs_devices;
-
-	/*
-	 * Handle scanned device having completed its fsid change but
-	 * belonging to a fs_devices that was created by first scanning
-	 * a device which didn't have its fsid/metadata_uuid changed
-	 * at all and the CHANGING_FSID_V2 flag set.
-	 */
-	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
-		if (!fs_devices->fsid_change)
-			continue;
-
-		if (match_fsid_fs_devices(fs_devices, disk_super->metadata_uuid,
-					  fs_devices->fsid))
-			return fs_devices;
-	}
-
-	/*
-	 * Handle scanned device having completed its fsid change but
-	 * belonging to a fs_devices that was created by a device that
-	 * has an outdated pair of fsid/metadata_uuid and
-	 * CHANGING_FSID_V2 flag set.
-	 */
-	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
-		if (!fs_devices->fsid_change)
-			continue;
-
-		if (check_fsid_changed(fs_devices, disk_super->metadata_uuid))
-			return fs_devices;
-	}
-
-	return find_fsid(disk_super->fsid, disk_super->metadata_uuid);
-}
-
-
 static int
 btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
 		      int flush, struct block_device **bdev,
@@ -685,84 +633,6 @@ u8 *btrfs_sb_fsid_ptr(struct btrfs_super_block *sb)
 	return has_metadata_uuid ? sb->metadata_uuid : sb->fsid;
 }
 
-/*
- * Handle scanned device having its CHANGING_FSID_V2 flag set and the fs_devices
- * being created with a disk that has already completed its fsid change. Such
- * disk can belong to an fs which has its FSID changed or to one which doesn't.
- * Handle both cases here.
- */
-static struct btrfs_fs_devices *find_fsid_inprogress(
-					struct btrfs_super_block *disk_super)
-{
-	struct btrfs_fs_devices *fs_devices;
-
-	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
-		if (fs_devices->fsid_change)
-			continue;
-
-		if (check_fsid_changed(fs_devices,  disk_super->fsid))
-			return fs_devices;
-	}
-
-	return find_fsid(disk_super->fsid, NULL);
-}
-
-static struct btrfs_fs_devices *find_fsid_changed(
-					struct btrfs_super_block *disk_super)
-{
-	struct btrfs_fs_devices *fs_devices;
-
-	/*
-	 * Handles the case where scanned device is part of an fs that had
-	 * multiple successful changes of FSID but currently device didn't
-	 * observe it. Meaning our fsid will be different than theirs. We need
-	 * to handle two subcases :
-	 *  1 - The fs still continues to have different METADATA/FSID uuids.
-	 *  2 - The fs is switched back to its original FSID (METADATA/FSID
-	 *  are equal).
-	 */
-	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
-		/* Changed UUIDs */
-		if (check_fsid_changed(fs_devices, disk_super->metadata_uuid) &&
-		    memcmp(fs_devices->fsid, disk_super->fsid,
-			   BTRFS_FSID_SIZE) != 0)
-			return fs_devices;
-
-		/* Unchanged UUIDs */
-		if (memcmp(fs_devices->metadata_uuid, fs_devices->fsid,
-			   BTRFS_FSID_SIZE) == 0 &&
-		    memcmp(fs_devices->fsid, disk_super->metadata_uuid,
-			   BTRFS_FSID_SIZE) == 0)
-			return fs_devices;
-	}
-
-	return NULL;
-}
-
-static struct btrfs_fs_devices *find_fsid_reverted_metadata(
-				struct btrfs_super_block *disk_super)
-{
-	struct btrfs_fs_devices *fs_devices;
-
-	/*
-	 * Handle the case where the scanned device is part of an fs whose last
-	 * metadata UUID change reverted it to the original FSID. At the same
-	 * time fs_devices was first created by another constituent device
-	 * which didn't fully observe the operation. This results in an
-	 * btrfs_fs_devices created with metadata/fsid different AND
-	 * btrfs_fs_devices::fsid_change set AND the metadata_uuid of the
-	 * fs_devices equal to the FSID of the disk.
-	 */
-	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
-		if (!fs_devices->fsid_change)
-			continue;
-
-		if (check_fsid_changed(fs_devices, disk_super->fsid))
-			return fs_devices;
-	}
-
-	return NULL;
-}
 /*
  * Add new device to list of registered devices
  *
@@ -783,8 +653,14 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 	int error;
 	bool has_metadata_uuid = (btrfs_super_incompat_flags(disk_super) &
 		BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
-	bool fsid_change_in_progress = (btrfs_super_flags(disk_super) &
-					BTRFS_SUPER_FLAG_CHANGING_FSID_V2);
+
+	if ((btrfs_super_flags(disk_super) &
+	    BTRFS_SUPER_FLAG_CHANGING_FSID_V2)) {
+		btrfs_err(NULL,
+"device %s has incomplete FSID changes please use btrfstune to complete",
+			  path);
+		return ERR_PTR(-EINVAL);
+	}
 
 	error = lookup_bdev(path, &path_devt);
 	if (error) {
@@ -793,20 +669,13 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		return ERR_PTR(error);
 	}
 
-	if (fsid_change_in_progress) {
-		if (!has_metadata_uuid)
-			fs_devices = find_fsid_inprogress(disk_super);
-		else
-			fs_devices = find_fsid_changed(disk_super);
-	} else if (has_metadata_uuid) {
-		fs_devices = find_fsid_with_metadata_uuid(disk_super);
+	if (has_metadata_uuid) {
+		fs_devices = find_fsid(disk_super->fsid,
+				       disk_super->metadata_uuid);
 	} else {
-		fs_devices = find_fsid_reverted_metadata(disk_super);
-		if (!fs_devices)
-			fs_devices = find_fsid(disk_super->fsid, NULL);
+		fs_devices = find_fsid(disk_super->fsid, NULL);
 	}
 
-
 	if (!fs_devices) {
 		fs_devices = alloc_fs_devices(disk_super->fsid);
 		if (has_metadata_uuid)
@@ -816,8 +685,6 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		if (IS_ERR(fs_devices))
 			return ERR_CAST(fs_devices);
 
-		fs_devices->fsid_change = fsid_change_in_progress;
-
 		mutex_lock(&fs_devices->device_list_mutex);
 		list_add(&fs_devices->fs_list, &fs_uuids);
 
@@ -831,18 +698,11 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		mutex_lock(&fs_devices->device_list_mutex);
 		device = btrfs_find_device(fs_devices, &args);
 
-		/*
-		 * If this disk has been pulled into an fs devices created by
-		 * a device which had the CHANGING_FSID_V2 flag then replace the
-		 * metadata_uuid/fsid values of the fs_devices.
-		 */
-		if (fs_devices->fsid_change &&
-		    found_transid > fs_devices->latest_generation) {
+		if (found_transid > fs_devices->latest_generation) {
 			memcpy(fs_devices->fsid, disk_super->fsid,
 					BTRFS_FSID_SIZE);
 			memcpy(fs_devices->metadata_uuid,
 			       btrfs_sb_fsid_ptr(disk_super), BTRFS_FSID_SIZE);
-			fs_devices->fsid_change = false;
 		}
 	}
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 2128a032c3b7..6672ca13eda5 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -353,7 +353,6 @@ struct btrfs_fs_devices {
 	bool rotating;
 	/* Devices support TRIM/discard commands. */
 	bool discardable;
-	bool fsid_change;
 	/* The filesystem is a seed filesystem. */
 	bool seeding;
 
-- 
2.38.1

