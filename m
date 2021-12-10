Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5EE47084A
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Dec 2021 19:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbhLJSTT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Dec 2021 13:19:19 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:64118 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230479AbhLJSTS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Dec 2021 13:19:18 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BAGHSTE001883;
        Fri, 10 Dec 2021 18:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=jLjGKcoXOOXroN/84Mscplg5vqW6Q7W7bM4u4oURLYs=;
 b=hCexF3LPlqzZDf/93HE7tl/yrOy2WpbSskKhyjq2Ew82VLla6sqpblhrDiX/YSKpWMZ+
 7zHEVw8u63z01dp+JwY5DZY+VXlfJ0FQbGYuFRp5JzSNzfVLl5wqP+RjOpWEU+XtVWIM
 StbbM7L6hFZ9zMwAhqIaZ3jNZPpWdpwDZrXJpkFiz4XS55/BKAvRMrgUzSFudx8LtBbO
 F61JtpdDln0Fyq2yivSdtcn2tFxOKRVZpE2xB5x7DQxpZfHj9KrvPnzYQ8gME+FLLKFj
 7iUmPQPBlxz8+rKfmy6EJC2Lt0Ddhxvr5K8c6mTrzn3tdDbaxi5RALiNMEq0DWT9waUI dw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cva9ng98u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 18:15:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BAIFLCp188398;
        Fri, 10 Dec 2021 18:15:41 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2048.outbound.protection.outlook.com [104.47.74.48])
        by userp3030.oracle.com with ESMTP id 3cqwf4dcbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 18:15:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTE0Vfyy7ZL7M/n4m25rqkh9AZ7wLa2dHsxX1CjRpBlWTami4m4QS7yZ4mxBkzfSOOO4hBlZ+/sQebqP6O6HI+xhpioydYtJSnqP9KGkT+a7ocPk2Pu2tmKMxxzVWHqicNiP9bF9THs2PHhF7Jam90u6yo8mzOGCS1zUOQ7Gbuy7TV738VAUCKp9tuMg77OIi6MbZkJP+I0fc2OUhffA/yOjKscjIcSPkUpaOLsNeiyK8Mg3D+E6y/lmMUuJEiiUo8AQPeX9hZYQDGozUuoE5aOAi64w3QrTHlhjH205r553rOe3b9LPwAnkDrsR/Zxxj1VWrvBt/cJI4iEM33Y85A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLjGKcoXOOXroN/84Mscplg5vqW6Q7W7bM4u4oURLYs=;
 b=XzAqgJL5qGjSTApRztrGYTQ0pmF/wPw3+1+8nGr6PcJSVmsu13GJxRQ92jkin3fVdM6Je5cqq43fnWcpfpMvEu0pVi5P7DYaS4Sibucol7w2fwi6VHVvogEqjkcRHsE+KlUjFfbVnbbtPF/GnrCw2yTcOaFO/LynZpxSaDa4mAY2PYnsTK/6J8koAq26NLrdrqrGQiewtAZSirWJnimJDAIHn7oKZQq44xVlCLcuZWK+y273C4v9+ZjhEBLgAtFZVd928NHn1ybnvDp87VtW1XfWDdd9tX9KpX+veHroadHwYfFQv4ATooJP3BbPJ/H5iUox79dUEisHZX6U2YNxGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLjGKcoXOOXroN/84Mscplg5vqW6Q7W7bM4u4oURLYs=;
 b=w7zecfJQ+8EjpFs9/EQVoS+aHvne9zSLk7TkAc/wgzGB4E2Z4dsyBT/ydsPrX9qN+84Z0x8rKlPJy9UIA3Ppzl8Qlds4dvfpscZDwK0ck9L//QrY2xsLjI/yQ/ykuZwWrtlAnSZWawJjz/IOAaM98biXt2qkRtGMrNi+0mGhYng=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4368.namprd10.prod.outlook.com (2603:10b6:208:1d6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14; Fri, 10 Dec
 2021 18:15:39 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%5]) with mapi id 15.20.4755.026; Fri, 10 Dec 2021
 18:15:39 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com
Subject: [PATCH v2 0/2] btrfs: match device by dev_t
Date:   Sat, 11 Dec 2021 02:15:28 +0800
Message-Id: <cover.1639155519.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0090.apcprd03.prod.outlook.com
 (2603:1096:4:7c::18) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from localhost (39.109.140.76) by SG2PR03CA0090.apcprd03.prod.outlook.com (2603:1096:4:7c::18) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Fri, 10 Dec 2021 18:15:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9cf0fea-9196-46bb-c133-08d9bc09120e
X-MS-TrafficTypeDiagnostic: MN2PR10MB4368:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB436850C09B96830C64066891E5719@MN2PR10MB4368.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 06sPIL9JENvH/QZvHztcVLOzeWrjuaLnZCTQvRKvgG4yrDZJ0hWFOhvSPDa6jeAclnJf9bpGDXgx6tUP7rdsYw0dhhYp0vvEwKbD1/kYoV01nSg/Fx4YaOTL+KQFzU7ZasNz+z8l6lKEbVvaet6SgOGpbPCAv2O847wkR4cLN1OHRwsXA835Jqs2FmxQ7CTNEN4O8Joz8ce3rdulThJlmoJaFdrA+2v7kLZr3t3FTwJ1Ox/CYLy1JNiWcsqKqqYyqwP9vSBqX39G4PuIzfEbnAhVzQQIvvpAFnqSrg73GUqMCw+l7jJUHPhCW4qLvjhZxqupMDZA5aPGNV/aGqa3O53mjy+Axx7eLpDrm+QceO0Yc8GV1vLhHWLh90j2LDxAmFsaP1LaKyJqlbIwFZkHlHGTCtei1a5jGYznZ172ejS3J38TJP1AfILeYLXlh8J8eEuYLZ8QRf9nqELc/NtsFqTTz8CrysFOHC/UxBnbtvFrFmrR8D4IADmlTUWm3hYVIJ2JZEHzr5vnQ6HU8H3RmZ4EYsDq8Xpo4yA8QdaH83pe0PN/00qHvYeCqRuc1/3xCHYe3ZjqQpVQe6/VsRN9imvyY0SJpd8j76++rfSVJ0aptzs4s/3xTFvpDSwNDMOOuP4/rL6EkgR925B3O23IvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(2616005)(38100700002)(66476007)(6496006)(6916009)(66946007)(4326008)(66556008)(83380400001)(6666004)(508600001)(8676002)(26005)(44832011)(2906002)(956004)(36756003)(186003)(316002)(8936002)(6486002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FmCml5UhHpWX2xRKSyUDypiqrrp4GFS7uW11pioovnTLd/jyrh/NWRC8HPAm?=
 =?us-ascii?Q?4WaZcFIdyb58iscszSgUtBFe03iqHZ4d9HL+C+29BSEQVlx6fzQLJR9F6Mih?=
 =?us-ascii?Q?Z66j4k3PfbvVrvqPM3ZXjO0vw0r9xjH7WnzWrqXeuPRWhXgHZL5kx2LWw2nH?=
 =?us-ascii?Q?/qXdfCW+NpgTlUNtiBFo1uvBly1XT8RQ48jGH+V84n6X6Ff+dLveJEnfvsrz?=
 =?us-ascii?Q?DXVLpSTupgxyKtyIYF0XIVUONAA5tuUtzw8fyCMra+FmOMPJ7sHzhythzmFq?=
 =?us-ascii?Q?m8O67nmjtKT7hLqSPoK2E54RZrC86kPS6p/wN5YljILd4h6dyeUQ68YIFJ5Z?=
 =?us-ascii?Q?AMZ3zea2L+eOLVeEyJXzj/1MUzAiJNO/sHV6j8hdz2yKK8UbzuK8BZ46+UlD?=
 =?us-ascii?Q?xzBkIh9b2puJuTNcYz6/v06v4gIUgGkYweh1vvch0Z+G3uvBWr46EQeJ7DHb?=
 =?us-ascii?Q?xeALyDYRkm2LU0gs9eC3xYEnxbjqjN7t4nBmpA5xp8Q9fVUtKLeUrzsvUGKA?=
 =?us-ascii?Q?bXrtnJjhZG1BTDzhTOKHtkWP0jz9sBn3ZKSfpnVPvAhZxvwnXn+Zfu9BfacS?=
 =?us-ascii?Q?UeiDUmgel7Rh+cpzBybqj5QRojhjKYPo0wWd7S5vMAMajy30MF3p0cCp65vs?=
 =?us-ascii?Q?JKctiV53589iUh24+9nalAjbn+t8xEKv8CAi8jQSMHXwXc8vI865qE73BbdP?=
 =?us-ascii?Q?Ygj62Ffuqr6z9+x5CrE+DXM6Mw4dohO3IjCKGZeqVToP7izJsd2pgsf7QkXI?=
 =?us-ascii?Q?BscGpN96llfG5IjytGRw6mUyp94Mg7epCRJdUlK0I/HsCRVkeR6PqbF7XfyD?=
 =?us-ascii?Q?XkEtufeIfLRbo0cxh+EYrZTBTDw61K3TPOk9TN5ZQgi3p4gNFIwvTFS3RFa7?=
 =?us-ascii?Q?AJaFiUu8FnxMSwO4GKJrcrSy8YKzCHT7k7v7eMODFiqU3TvOXrSBoZU2gWWO?=
 =?us-ascii?Q?NzzMw4OZn0oyGonNxS5uEycdRH19JVXIqKBK8hpJEMYkS4fikKxvJughghKM?=
 =?us-ascii?Q?Uwp1mkGR4pfqWFBCE7NL7UF+UGN+HvlZn5fSpihYwtOOl0oyAazBQ4Xl5kt/?=
 =?us-ascii?Q?7VQx0e320cThnXDRSUqUqL1eLtOjWB7P5FmnC3GGvHuzcTGniw/fNoWc7Bja?=
 =?us-ascii?Q?jhwLcrW9Bx+bsAyX+lKp74Od2nMAUhWN5iJqyFkO0/Xx/ZGdBjF9oRvDDJKn?=
 =?us-ascii?Q?LYiDS0UNNtQCGU/Vtqzmvyv+ZJQzzAuqpQObNpj4WfnAbu5+IwXuAcIQcqoy?=
 =?us-ascii?Q?sGCvvnh0SlRwVwX3d+G2pur0gW9Uo5MzsthuZRjjOlINdMh9fi4Lbd9cycb7?=
 =?us-ascii?Q?/dj3JgDsvPt1jCDcI3HVqlKfRAouaAQEZnQLnCMjPCHBzq6ozBrJBM+RRUiN?=
 =?us-ascii?Q?1USeILZ9DnnrXOvdLN3JYMH7apjAB7T1T8U8yOWcbEpXJHcFa+pOrLS3m0xo?=
 =?us-ascii?Q?F7+Y5kuAVtqoRXOH27FJX/fPqMYy1jX6L4KEXPvNbz7w07Aqn6jdsfHrmBuk?=
 =?us-ascii?Q?CCgIKiDkJiXqSQi6I7Ei+hFcWJL/kfQXGuYpRPK6BoHqYh0AEUVoIWMwrpa+?=
 =?us-ascii?Q?QuInRd0U1MjxxE5LWB55rov+61aXJ8ilKf5RoJUVOYYXrgZj2fhyPmLPeJJl?=
 =?us-ascii?Q?PA5hBYk25OLoz7QXp30fXGA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9cf0fea-9196-46bb-c133-08d9bc09120e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 18:15:39.4570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y7cn2jZ5Kuw6ZuVQdsFtGAgtbvyay65LVnba/KB3rK7NbmQ9oogBh7TL27Q6CJfGJ4KIyyByZFenPWnOGn/tmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4368
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10194 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 mlxlogscore=938 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112100103
X-Proofpoint-GUID: JO2USyNVdBoPzcjBGnICD_YYf8S66Ms8
X-Proofpoint-ORIG-GUID: JO2USyNVdBoPzcjBGnICD_YYf8S66Ms8
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Patch 1 is the actual bug fix and should go to stable 5.4 as well.
On 5.4 patch1 conflicts (outside of the changes in the patch),
so not yet marked for the stable.

Patch 2 simplifies calling lookup_bdev() in the device_matched()
by moving the same to the parent function two levels up.

Patch 2 is not merged with 1 because to keep the patch 1 changes local
to a function so that it can be easily backported to 5.4 and 5.10.

We should save the dev_t in struct btrfs_device with that may be
we could clean up a few more things, including fixing the below sparse
warning.

  sparse: sparse: incorrect type in argument 1 (different address spaces)

For using without rcu:

  error = lookup_bdev(device->name->str, &dev_old); 

Anand Jain (2):
  btrfs: harden identification of the stale device
  btrfs: redeclare btrfs_stale_devices arg1 to dev_t

 fs/btrfs/super.c   |  8 +++++-
 fs/btrfs/volumes.c | 72 +++++++++++++++++++++++++++++++++-------------
 fs/btrfs/volumes.h |  2 +-
 3 files changed, 60 insertions(+), 22 deletions(-)

-- 
2.33.1

