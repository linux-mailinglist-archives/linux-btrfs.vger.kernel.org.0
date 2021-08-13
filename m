Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408F73EAE51
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Aug 2021 03:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbhHMCAU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Aug 2021 22:00:20 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:37910 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229919AbhHMCAT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Aug 2021 22:00:19 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17D1vXr8029463;
        Fri, 13 Aug 2021 01:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=iJacALhd3Hl6KrZ8da05VCxMqLmYi5cGfgzBrdc1FFQ=;
 b=dez95E2wvzAW5FDiUlKm6fvi3HV6gieyqg8MHGZ65nDVK8ZodTGvSRmNTNXM1NMsh0/O
 Cq17hsLaN8KLYLliMSbhj0vCkO3BeNROs+QL068n1cwBrzU0LEXK7UJ/f7lCN4BNnR1X
 VaUoZD1s97CQL6Lj2PowDLgeGNS7IUBspBU3HBlG0Q2Ls1pl4lPJlkca9Uf9KufzZ+uA
 OHS7lT7m8PCIq2rs+5IxZzjH3bGqhBtOZ2J4hwP2aX89ebpNgTlAv/SNO4gGNto95cFV
 OxCwpKJmOyM+/and3iP8zJLd8qPq0J40mFJ1tVkQsy7ROm/tru7xLwNTivjIbq2St+kV QQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=iJacALhd3Hl6KrZ8da05VCxMqLmYi5cGfgzBrdc1FFQ=;
 b=ThWZ831rhnviFMXHrhILXWaHsaqg/KslNd+7xV1Xb+Wakt7tkK5pqyOESi7/AA/FBZHR
 nMYl5hyJmZbEWTglooPaFNsLFLwMyL+Z0U0xtfhqHfI1Wl/8+VgBA8+5V4L4Vnww0kOf
 cdW64UdWfEvynR+ue7gAw6cP3l3GlBqjMhHvnmIADzgKmRR5sGlKxz9CcEcBe4ajyqin
 InE/i45Ja+sYb84Ys3ZsL9UyyUBP3y4mHYphnDydQLyk33N7qQIFFtNzgiUtNtRPIj//
 pTponFiFdffwQA7OTmHiSG0Zkbd014C2ZTpkRXDklJf3lnAKjVZCuoKMegEu4y/9kmjd XQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3acd64cbtk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Aug 2021 01:59:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17D1uXrR128903;
        Fri, 13 Aug 2021 01:59:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by aserp3020.oracle.com with ESMTP id 3accrd5ynx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Aug 2021 01:59:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NezAQer6mhH/ZfCDIjWjad7HbT0rwwAntaf8O+MW/MnJ5vhtN6BV9RuAc4B8zK4+giDkKxUKLh/4k+6rPLxzdAhYsdrKg2fUDql3dWRVzYFNjD8y4hgnv6NxfMhwqLi9V+iYeASDRPSE0XMDbGDYNdZtXF58+Fa4KuUHEwUrnfpxJFD2/zPSdMK700zRYLLmRKJdIZFExW0PAdREALRbyGoT/pGjPwv5uDeyt4QDcmwQ1iq4S+cbta1tOaa5PUcVeYx5c3cpnotAJlajlxu2Hzu+SJ1TFh6Q0ss0PamtpCYYycoY3AxRJtJuLd0nzHSfhksnpIVIhvFC5Yn5VJInLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJacALhd3Hl6KrZ8da05VCxMqLmYi5cGfgzBrdc1FFQ=;
 b=Lh2wtKUrS68FiEAi9S7bF8WDVjILvFWRltx6AejC1bXcz6LGgSuTiybbwSI62G7IMg6ABWgCnsu37ig+WLjXKlAcK19i9NAFCxiFky+EeBpxslLbls65Src/yGw/6Y6GJH/ZnsVQGLSIGFamC7h1wj5FqyR6z2C3TaqvUp2m2ha7QmJE3w3fCgG9r+qtSjLzYOcuui4dcxQuMRG/lhq93XS/WAXlMT9dBFhv69vJ5U8agDOA5NEw3UVfJi0BvweHJR3CfHDBt7C8rjiEJFGHP4HWWauHmmdZUWDRkLJUhPFdO9IiwkIt38bbUPpf22waWesDazXRKCl0ySX7+l+4lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJacALhd3Hl6KrZ8da05VCxMqLmYi5cGfgzBrdc1FFQ=;
 b=vKqmVzjMTuE5MiBLH+Qhrcv4meDplFNfl07K4fRv07gnXO0HHvlCPHUCwc82gEYxwI8DJOsLX1LGVH+cP/ESWL3aC8ZCIJxsdE0J0M5wuNLGwJtJCwYluxgPI20WrWt2z4wE45uOX66BqN3z+vRetiGu/8+F0HxHL2rvj07FK7w=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2771.namprd10.prod.outlook.com (2603:10b6:208:7b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Fri, 13 Aug
 2021 01:59:51 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%4]) with mapi id 15.20.4394.025; Fri, 13 Aug 2021
 01:59:51 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs/220: make it compatible with older kernels
Date:   Fri, 13 Aug 2021 09:59:31 +0800
Message-Id: <cover.1628818510.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0191.apcprd06.prod.outlook.com (2603:1096:4:1::23)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2PR06CA0191.apcprd06.prod.outlook.com (2603:1096:4:1::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15 via Frontend Transport; Fri, 13 Aug 2021 01:59:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2352761-aed7-41bf-5b6a-08d95dfe093f
X-MS-TrafficTypeDiagnostic: BL0PR10MB2771:
X-Microsoft-Antispam-PRVS: <BL0PR10MB27712030A7C780A596A6F2E4E5FA9@BL0PR10MB2771.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z/sp4/HR6ZXiFxCthOWW3+kFzVvvvQwg06IU10fuOrLwADh1vs+tVUdY8w4gSogMkQnRTG3Ztxqq5d3e0f4Rb68EXlVAE2t9PcJ6UcbWRIMTxU0M+1KvUXa0wgyHNEZo9T1Hwh84aFXCngpTvmIdFUIcpgRLIlLpLdYd+Ua4J1dmLmpzhwHdoDhEBnsShsPWigLfVprGMzjSvF7Oh0CGCwcWYsTHsDiuQ1Y1UVp4aq8KOvDVhuXBy8YISuc7pXymCHG+B2svI7f+O4FuvzsegLFaE2B2GQM6LFfjcL/eS2aFSd3Qbn6VE+Hz2fhJk6GnmEayWreaICV4/vGzbJ2IKuCk5hQItTkS2IvqoIQ7xHGQ14zN/9rv1VAXkdmwB8O0Hymq5kzRvoIR4z+/KDvSq0yIVTaxx3OoWn28mpiKI1wI0MqSnX//thBHpKj+VNTZJZiIU9TP857i0TkIMBGogL50SmtiVxobxTxpQlN4/sMPGIZlYBUaqdd/Jef5Doqo4XYjOldFNCPJy8Wss7CwWWXPM2uN9IrTYJQCJgjSAVagq+E7NBr2V1x+XQnO9jlyQ2w1fgpgMgbaW2DNkMJfsbLTaBhs+FV1NKwJsAQGAOqDzSFEEja9YMYRKcX+8PDfOKzf/P/o4dXskdzGLqq4Hfp5mbBB/df0gWAPaD5RT9hPJFY50+H+Al5dMEsA8rO89LV+jZ4JuwWvNkOcAVldmFqLL6zCAdRzFkiwxbnZaifluUhrZOL3wMEC6LsSfJHFALVU7zli0SuibkUAruhZvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(39860400002)(376002)(346002)(956004)(2616005)(44832011)(8936002)(966005)(8676002)(26005)(66476007)(316002)(52116002)(2906002)(478600001)(186003)(66556008)(66946007)(6916009)(6512007)(6486002)(450100002)(6506007)(86362001)(4326008)(6666004)(38350700002)(38100700002)(5660300002)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jPxttwwBS662QNe+fKmQrzI5ljyLr9rJX6H19GdG/LOb5rKbFWRn3KZlpN3Y?=
 =?us-ascii?Q?YsZrRfyvmZs/4aPFOrHhYjj/sPFM+4IaU1KZF/A+SCB8JptkXuh6fXuA80PN?=
 =?us-ascii?Q?WBrWH1HNeuk4sOwaBiLrzBMj+eCvHSyacSQkJucNTI67ejPO3OFI1dF0al7x?=
 =?us-ascii?Q?XOhvjLgsbhT4XyVjRqjMkQd+fSOZmD6ocVkaPGNy9C781mCORpOsWzhdlHJZ?=
 =?us-ascii?Q?vbtnv4v7TjQTcaHZH0jt2yhN7pRr8VYUHFkzh/jeQfuHVtmTf+EL72zOGvr0?=
 =?us-ascii?Q?m+K8poXEELIluwBbRTJabIE1zxTOgqr7cm0UZno0fOmuUPV6WQMEY0ttXkLb?=
 =?us-ascii?Q?gIgEyGgF3kQz5gQEKGv4BggLvlrSz5Q4WQVUU2YiLbFQtBu4rt87PUPKsppM?=
 =?us-ascii?Q?k5jB4pste5du193uOaQa+p46UlbWip8tXqkH+0Rm3U8TouJgim31S2skzLz/?=
 =?us-ascii?Q?oida98FZFQqwOTuB+3FrFflmQ3/bxddJfAmawEK1dqet5vik4N9K+p69b3T0?=
 =?us-ascii?Q?UfFqaZRIz+1mbCrNWrt/YDo+TFGJEeBDFZfHf+ZLmet6gigbW/r2mhSaVOIM?=
 =?us-ascii?Q?IvpbPh/bMjh4ovpsV+0rba7pzOM3/BloxhlcInaUd+xuAYsW8ZtNQX5rd3rA?=
 =?us-ascii?Q?734Za2ONry4AAw6C7LbubomeGDPM0l19lYlZtYqj39YDzUZJoEGs+/LkCpJR?=
 =?us-ascii?Q?I7u9lFD0PzEkikbwLnrsdiW6QEl/m1AjiXPZ85JYx1HUI/oJH5Iugtxmb3bN?=
 =?us-ascii?Q?hbeEuXuZ04UPcMSQqzVHxe1KDLOu8U6H+rh8PxQ1LpDyiI18JUr/gpO/b7E5?=
 =?us-ascii?Q?j+ycQWvv27ee1jKhsJ+1NCunwthE1S7ZZ95vezX2D5sfn/oMpGrxuYtdl3WW?=
 =?us-ascii?Q?Gwlhle52oLvUG1+Gb7uHFkTK2sTrRHtL9wncmOyMQoG+c6/oOXYaMuw7FSFU?=
 =?us-ascii?Q?lRHIfkPpTbpS8wVipZGcPYf0Bnw0ZtZytEIXp7bEzTb2dVLxdpx+IcfoCJkG?=
 =?us-ascii?Q?DB4NZIzq9rZlKoYAfnJv28JJxHabzdAclpvmsAMlfFM64qNEw1quC2r9OMJV?=
 =?us-ascii?Q?01rTLADPrg03dtw8OJ/7iTzPESP/ycxSrGS58dVVoWjQPIsxck2YucCQ7Gkz?=
 =?us-ascii?Q?YaaUZlHmOjytPtiku9QsBQj7Izlq+tYf/IBrfNELaX5KwFsPikT7WP5dXGrj?=
 =?us-ascii?Q?/ddnmc22CeHBKuqxwAS7cqHPmG19RfT8sw19JBJmojXeYUhx4BuQa7RStfJV?=
 =?us-ascii?Q?zNAnimpQWI1t+idq+Ou+YYb4TdN5aPuzNpJhNbQCX1takEqd07wkG5HJnmtA?=
 =?us-ascii?Q?zdHNUjOwE5wfgMrqgGFV9WXy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2352761-aed7-41bf-5b6a-08d95dfe093f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 01:59:51.1911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GXzIlwPxHilSsXBstLALRhnH5PX3UA2yuDj1Je0bOquapbBCB+UXv65pdmj8Ur3dxio2hmU1hm8E87wNfla2MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2771
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10074 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108130010
X-Proofpoint-GUID: 6oV9g1_Xn7JPGvNFN0hqW3dzH-Ku8bpK
X-Proofpoint-ORIG-GUID: 6oV9g1_Xn7JPGvNFN0hqW3dzH-Ku8bpK
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I found this test case fails on older kernels such as 5.4.17 as the
patches that brought the mount options changes aren't the candidate
for the backport because of ABI compliance.

So make this test case to check if the newer options such as [1]
are supported and tests the mount options along with the expected
output in /proc/self/mounts accordingly.

[1]
 mount options changes:
  new                   old
  discard=sync          discard
  rescue=nologreplay    nologreplay

 /proc/self/mounts output changes:
  new  old
  ""   clear_cache

Patch 1 improves the debug log provided by the _fail() for the
scratch_mount.

Patch 2,3,4 fixes discard, nologreplay and clear_cache, respectively
and,  they are separated into the individual patch to show the diff.
These may merge at the time of integration. I am ok.

This patchset is on top of Boris's patch [2]
[2]
 [PATCH] btrfs/220: fix clear_cache and inode_cache option tests
 https://patchwork.kernel.org/project/fstests/patch/409e4c73fefce666d151b043d6b2a0d821f8ef85.1610485406.git.boris@bur.io/

Anand Jain (4):
  rc: debug add _scratch_mount_options to the _scratch_mount
  btrfs/220: discard=sync support older kernel
  btrfs/220: nologreplay support older kernel
  btrfs/220: clear_cache fix for older kernel

 common/rc       |  2 +-
 tests/btrfs/220 | 59 +++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 48 insertions(+), 13 deletions(-)

-- 
2.27.0

