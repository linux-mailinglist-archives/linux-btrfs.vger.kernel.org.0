Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C1A3FD3EC
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Sep 2021 08:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242237AbhIAGoT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Sep 2021 02:44:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:2938 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242118AbhIAGoQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Sep 2021 02:44:16 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1816Atat006304
        for <linux-btrfs@vger.kernel.org>; Wed, 1 Sep 2021 06:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=+AI2D4XBB/cEux1FFoVzhbtStSf55C1S0ibR8196N7w=;
 b=lQyr94DeEbWDZHbWz9rTuZm6mv8IZKtmSt/VfuW6ITlzd4GxFNYtrbNkOUo2q46jTGmk
 sC57dVe8BU+1V0XAMYuje+qpcXlFV/hGW/Kh55gJYIoSAsUISPeslXXKwT8GT1NyeM6K
 72xvc2lcElin810iMjyVRpbqy0dnlm7U/ujHKne2nqSbpabVpm8c/uThbXlqgVjh8vdH
 +Qg05l8syCYpVbuYPmvC35vi2+En/KWw4gdd6A+gwIqDVfCFPgu0UaSdjzCgQ9g0lkVP
 p+TyAt/QBupDkjj6h9BRaXd7As6IIuneN7UZsYBGYbJ5TbkRqi6TWfX/XtYWg58zgNbP xw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=+AI2D4XBB/cEux1FFoVzhbtStSf55C1S0ibR8196N7w=;
 b=B7b5l5k3j3a92O58yE1OCNGIfcJRjJqGnJCt2zSWak0+6YHNwGSXwCdaNXv9ruI2hugy
 40Dqi9GfyLf5MIPO7ovgdjQ26A2tURtujQJyOIEX3iPHB4YSFiburhasdzYOJWwtll2s
 M2j9HQRIeXmS9jaFImO3dPyrhhNZzJZX0ybAnck3JFtbK1UbxGHK/hwbhvvKTDVwX3g5
 NfSeYA5PAzoL+UlzOY01vFirKGp/F702r/KL/Pa5DyVB4/MZMUDLccqmidQ/9xJ/2nF5
 ob1tUJOckjaN7Z2X2Y4bCbVAvOZ98yOibGun6cb7uuwkjVnJ7NeWhFC0Wd0KLjM+mA/g iQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3asf66kfhg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Sep 2021 06:43:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1816QOuK003073
        for <linux-btrfs@vger.kernel.org>; Wed, 1 Sep 2021 06:43:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by userp3030.oracle.com with ESMTP id 3arpf5vyey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Sep 2021 06:43:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=And30impb6UQxJSgot0rXoab/YmlCaYKlY3v2umnDvZbTd/i5nyZQj8KKoL/3fcs/8PXjmdkH4Uj+Ax+aI4PLF5flxkLDMIajJZR8q/VR1L12VUySPIlb6BkCkw4UHfW0MNxwfQsL45yrEKh9HYkPAH5JfadldXs/flghTXXMwFNmXpIUhFK5/vlzpPj48OOyTgMKkDb/r9KeAAf4ZF0vPxfzC0U+pF6uIk7IpiCbA9Lu6GcnV+VAyrLEwqrcCr9sZu8MXqhiv8oAVyh5fSPWgzMCDaftlgFj+ZShdDtx48HC8qnrnadeWjeYVSiJJhKXGryMLwueUs8YwdpuIrJ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AI2D4XBB/cEux1FFoVzhbtStSf55C1S0ibR8196N7w=;
 b=lYW1QMk2NXQ2U4csZ4ZAiOp9YGYn/MF0xTNGPiUgnjxRsQ25JSbM8XJqhT9sYGnwTGeA8nwxIOunVJqfJE+2aGsrwQWQ8AiAs70PcZ1InR9ApBi37nl4sIMJlaGt48MMOkmD68yzXRcGpaMOCLXp9vQZlGX49Jjd5Qmvx1Y4FmqHgL0bvNI//5jAJ4A/zpcO5HNLr6N3EmbgncWNa+s9pHDB8qWo8GEW0042BGR/vYYfRbbUl9q4JDKhD6g1L6GicYxdCCj1QGCBQYssFX6LEsugsoUSeKg7r9EhhZFzi2iH43vpZO9VtSckHqpnQDkdb46tHmfFHNZLZB2lTzFbaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AI2D4XBB/cEux1FFoVzhbtStSf55C1S0ibR8196N7w=;
 b=EPaxXyEPiSl6fOasZuNkfe9r0X+XAhaaJZU7r46IOcqguabGeEH6oRdcslhncMsHJrpoTpQAZ2/EUV8n4pep0vhgE0GrrxeIMnAxxBsWZAHiZwA7/AKC5SqqMX7+wp/t0OlKqN+qsPR1MMccrvqDH7sH/NG22ak0KkKekrmqURs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from DM6PR10MB4123.namprd10.prod.outlook.com (2603:10b6:5:210::10)
 by DM6PR10MB2795.namprd10.prod.outlook.com (2603:10b6:5:70::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Wed, 1 Sep
 2021 06:43:16 +0000
Received: from DM6PR10MB4123.namprd10.prod.outlook.com
 ([fe80::99af:5f7e:6cb7:922]) by DM6PR10MB4123.namprd10.prod.outlook.com
 ([fe80::99af:5f7e:6cb7:922%8]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 06:43:16 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] Fix device count check btrfs_rm_devices() and add comments
Date:   Wed,  1 Sep 2021 14:43:00 +0800
Message-Id: <cover.1630478246.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0109.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::13) To DM6PR10MB4123.namprd10.prod.outlook.com
 (2603:10b6:5:210::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2PR01CA0109.apcprd01.prod.exchangelabs.com (2603:1096:4:40::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Wed, 1 Sep 2021 06:43:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26aa19f0-a690-4800-41da-08d96d13c6fe
X-MS-TrafficTypeDiagnostic: DM6PR10MB2795:
X-Microsoft-Antispam-PRVS: <DM6PR10MB27958E70B4A957E5EB48EF5EE5CD9@DM6PR10MB2795.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8+jwU0g6+XsAMnbtG3DOfWZXU7TuFLJmk7LkF64eO8YCHt/zFN8ejzDpr2erYJpSyaXoh/lXvJP9DcYxxfNqkYfmEWm7bqshHnCS7EgZbMMBuqQtJFKGTxVLt74m3hTQMZOEKWujJfiFukoUQ/Cm84XSzBwVLO3JmKCK8JISJFwepSQU3CS399FYlkVizVGaYRWE8F1j11BiAJG1fjYSmgXMRuBpS1W70UIJghjuyU++89U3aDHA4MHPO/eJ7mxgiOdD+JqEou2GDR5ocp3qxL0naZDv4+wIKMQ5OXE15PKlre8GKW4XSzLi/807G96eZzDg56Qz4JFgXzjJ4ADpzZ9QsjYygwEStP9crm+GPKsIsklAixfjXxB+/R6PAR+g9fu1GmBij8Z3BbsQwUtjWvT1U50bwQEpWHNpc8JAvbYaF3JUKQ2aDZY/czSFBbf8ffwviNTJuShFXl1oJYgblT/7T7POBPiHhK5uEVw9qB42YFqCleQYB7dlBviP7yz6A8yTmtD/dH7BFIW6BMqaVnJ1zFoEBqp16McM3pdd4Y+mbajTkkqBQxqbgp0kExTyOMPZmmS6OxjwYSdsHZe3tJCWEp36mAVxPmahZWXDo9BqPg1x89zQfVXcUEJFYyS+JpWubb/0wHiXNToMznq+lG5mb0u/CL6y0CPQuW1CaNJvjQ70B+oeXsnkKn17buDl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4123.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(396003)(346002)(39860400002)(66946007)(6512007)(26005)(186003)(316002)(86362001)(38100700002)(8676002)(66476007)(52116002)(6486002)(83380400001)(478600001)(38350700002)(36756003)(44832011)(2616005)(66556008)(4744005)(8936002)(6666004)(6916009)(6506007)(5660300002)(956004)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?52d7C7yBT0SVbjJpGFAtNw/BgHe8M6ZymUX+daWtRSjfKYWiq8wtox7hO/Y5?=
 =?us-ascii?Q?Elsh+K+NoEh0IPefspzXuDxTSQ5/Szm1nx6F7PpxszyfFGbs0recTwRaghqu?=
 =?us-ascii?Q?3l36/CsdLfC3QwU87QwFXtKhI8dkMbMqc/7QthQ52sYZE+v5HVhJS80y3dBc?=
 =?us-ascii?Q?cowIZFs5VFHD6Wq2pnyIy+phvQFR2Qh4SQkUUgPGczAFF4DirPl613XdOFMH?=
 =?us-ascii?Q?8fRpDq5hiYta2M9M9PZ4pVxQCuoDBPTZu0Vierqiv94WtkGmnTE+0cOZJHdH?=
 =?us-ascii?Q?Bk7vz1Gu5oAgxOMr4iFokBhroPAhlQ2lKlvcoLXiR2yqonjcvyN25chY7dR+?=
 =?us-ascii?Q?WUFqRC2sS70roe8RZQ/Dshlkt1gu2GO6fxJSOPVIiH6N/vCYBWrUeqG85MyV?=
 =?us-ascii?Q?mhQdq/fg0xa2VV13fDZf48inqMU0wx06ZNFvxs4AoLY1mLAjdNN18xeXXh2Q?=
 =?us-ascii?Q?8HQcgVVPLupgCkFFqCz8GUfVVVhLzz1A2+3sCGk1V1DwqK2R7vVZSZnZzQZH?=
 =?us-ascii?Q?sl3djxy+NmBPPbys1ncmI/D70/TLErnJ9hQ7gM7vDX5rqinHxj4x9rzXFbYx?=
 =?us-ascii?Q?iwN/fHWYYES6tE5IP/y9sCReeNnS21NfTuaE02q8jR3QiJm91lanlqs9RC1L?=
 =?us-ascii?Q?wq196aJ27Uj4ZATe0hyhvjGvBozdzuBIkF8kEGV/NGlVgfqbBJsEAM5fp63q?=
 =?us-ascii?Q?ksO5lstqhsWaGJ6NkXadyNgkIp55c79V6QQumjzL2yta3VggtMoepOF7pqRd?=
 =?us-ascii?Q?aLokT3CFksZjSA334830rmuP+MvcQrDmTCDnkZRdJs5MabfgJyZbjM9oMby0?=
 =?us-ascii?Q?GHwpis3CQPAdmEFjjTsW5EAitq/LEWyF51viBcSE5jGIZKSXaKLl4NbTABjs?=
 =?us-ascii?Q?yCqVkj79QfhmvwNlyq1PEFqM8AKHh6/9oVX8bB3WlBSaGEgvkLrn5Y9vDbqC?=
 =?us-ascii?Q?4tvitQoAhELRPni/uAFRH+oQ1COna/KVUSn/VjTsfJM3XKa9IT51TM8Ja3q5?=
 =?us-ascii?Q?1z2dPIbEQnROnZ0xqdup04dMYm1Sy5RL2ap9jg/ahklMrbPi1aN4gGrOzvk6?=
 =?us-ascii?Q?m1s24cSNij2U0OsvqCmlKVMYtf9PFJZo4FdA5V+66hiRf33U0h8J5dZThn/d?=
 =?us-ascii?Q?ZNvlGIigthiZkPc9Nl0MSFrTQmWRbi+griBhJLlsdaZN+XolmtfsnFbzIu/0?=
 =?us-ascii?Q?2eN8m9SoYbGujInqPW408/8w11K7HPjfV+Er8bQh6dWhGGZfqMPLHmpMUitj?=
 =?us-ascii?Q?B3V3LGYC20ZoWl7uMbil4kuFhJz05BdtdaDR3/L+Ldefr8DnqbDluJwIqx57?=
 =?us-ascii?Q?o1V2XqIbWeoEz4HJjdTr+Qoo?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26aa19f0-a690-4800-41da-08d96d13c6fe
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4123.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 06:43:16.3368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNHJaVKbD+oJOGA+sGdf1V6FNu//lme8wZc67kjjZDZSDRvBdiwtYJCaVyuXEKW+0QtyKuyZFr8dGzTV3SqmXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2795
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10093 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=977 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2109010035
X-Proofpoint-GUID: wk3hzk6Ho_rh-_iTLBMpM1z0098EM_zh
X-Proofpoint-ORIG-GUID: wk3hzk6Ho_rh-_iTLBMpM1z0098EM_zh
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Patch 1/2 fixes a bug that we checked open_devices to check if the deleted
device was the last surviving device in the seed fsid.
Patch 2/2 adds comments about the device counts in struct btrfs_fs_devices.

Anand Jain (2):
  btrfs: use num_device to check for the last surviving seed device
  btrfs: add comments for device counts in struct btrfs_fs_devices

 fs/btrfs/volumes.c |  2 +-
 fs/btrfs/volumes.h | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

-- 
2.31.1

