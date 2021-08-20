Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCDA33F2B36
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 13:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238769AbhHTL3q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 07:29:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:58356 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237660AbhHTL3p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 07:29:45 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17KBGR89016914;
        Fri, 20 Aug 2021 11:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=TDjDPNE7fIkYLkICzc/ThJDhTlBTYXaUmPQ+ss7K/8M=;
 b=DuSHj7agIc6xpVt5hWBrI8H2pxy1HnGG6OJI7tyvpqfUvJQzqWwRJbbji6ilOk01aXZ2
 9+J2a073VeNcZ22LQMCSzRkixS++XloBeGuIDD1XtXJjLk/r2vVAdJrL7mVXcoPf9mHw
 /45u74A+Zq28lWhjsndzqjjtB0BQzGq+LYbjfi+0yVI43AUpDmtVmboyiw8MrDmmuOB8
 6ZTfS+yqk8Ri9762LQlXn19DirQ2RLBd5CKfunaMN6qONX2B1RsYret2Yjw3Bgrg05wu
 HBThc7Vxn7CnlKVHQ+Z/pDl9QvZL58460lElR4vh+uoiC4PbYBsasKT8DQHBZ30QvFtU DA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=TDjDPNE7fIkYLkICzc/ThJDhTlBTYXaUmPQ+ss7K/8M=;
 b=Wi9hyRh2Uh/jpoGdYoBc9616YrM+LdeW2469f+qDRWgP73gTKm91GSYUzJ5t/TQKwbq0
 DheUooYT6H5TxgIpZ8NS9QzroyPVFWSm9WgfgNwwLS2WHAEa64UChu83SeCograTPLR+
 g7xEbMqRVPAd4HFosfFj3jNY+ENC5QYK/vGC52HYjsmC0MaSBv5hcid61PUg6CM9mHeH
 WV3dz/pgyG6j+rBNJ9IsLh6swbopa0BAb5K+Hwi+TvINQuhMcNLF6x4rxjOSAO0ejbMO
 cpi7H3JQy4phSis+jVGPwDL+HJ7jpNSKJb9v0/FpSykb8GHfvuWOJSQbGUprkaIr3nqk hQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aj6rfrptr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Aug 2021 11:29:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17KBF66I008098;
        Fri, 20 Aug 2021 11:29:01 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by aserp3030.oracle.com with ESMTP id 3ae3vncma2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Aug 2021 11:29:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNDZWt/Pb0EaeTwbt6LXSQYh9dWZwiZxNKY4cVVyT7h8qO1MzCYbLpXJV67tOXScuY51+BoJ78xuEbX6vPXQRdyrAVRTpv9RosWzMpJCAAMMohvT7rCrg0vqRSn0BlfxJdo9X6PFQ0iC/pQnxA0qh3j323LDX8CclqDkz4Cfi/aN/iwTqCnp1dR7UJbvQ/8v8c2h/lSVlM+rSHHXOkgI4swCQG483NP9GxqVmkCxOPhxzqCl9ESaeVDwkWloq6GFAZ5JOCAM3r4D+zHYgBA/N4XOGELmB63e/gO+WZRmGiTzUvVt8kD8LvQBu7bMVDzu9dE784epCU9QHdcyMCG6hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDjDPNE7fIkYLkICzc/ThJDhTlBTYXaUmPQ+ss7K/8M=;
 b=n0T5NBQ9+uSn6IJBQ8qUNuJdl/SqYZ9kHnygGv8hGTn/HEZYxtHnI1lCzOo3C2zIHigy39n7/2OOe9Rhp1RjBWkl14MCxAxIA489erv0ia9A+EYzduS1aJ37cEqprvEmzrFv4n5DHMDPQmkp/oRnCnqvhYhTnfj1WqXAsYhvYDulmeFNcwJ4hnoDhTnuBIM3jyDkaEgj2aslKxjVpRqrt7tK0I6xuPsbugs9LaX3Mg4So2Jj28jUQP8dw/QHizgbBZYiaC2pUqz79fKjWUl9ohBMlrhF6gKJTNDDlhuPcDxq3ePYPNc7Gs8flWS7x2yb+tmpyUbqcTlcgiowIG7rSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDjDPNE7fIkYLkICzc/ThJDhTlBTYXaUmPQ+ss7K/8M=;
 b=SDz9nymC1t+uclKflcJ66CeX/0b0vcrTAzO4V3zvWF5glAolJJGUrhCDIFpxtaZFnV5slAhUZvThZsLSv8mOZvB+9QZN4JW7IOt3ihXsqXhqdLJj4As7EAnGImk6qCJdC3m8lHpaIDj4FZbWSWUfXRSXdYAoJ7PO3c4tu0uJ9Ic=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4094.namprd10.prod.outlook.com (2603:10b6:208:11e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Fri, 20 Aug
 2021 11:29:00 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4415.023; Fri, 20 Aug 2021
 11:29:00 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, l@damenly.su
Subject: [PATCH v3 0/4] btrf_show_devname related fixes
Date:   Fri, 20 Aug 2021 19:28:38 +0800
Message-Id: <cover.1629458519.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:3:17::28) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2PR02CA0016.apcprd02.prod.outlook.com (2603:1096:3:17::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 11:28:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4770cc9c-b423-4e3d-c919-08d963cdb469
X-MS-TrafficTypeDiagnostic: MN2PR10MB4094:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4094DB90C87139CF703D9535E5C19@MN2PR10MB4094.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8FiSuujuiGBmYg9PhegHVIVCw8r2qcGH8S+CoqrqpZ+J+hD4mIlI5NpTBW0qVSOoJA2+UUfIFqIt/wHEO3RaFSx/1ZGL2oXFSgQlcd8YAA/aRT0kz2L9F0yxfHU0zn5M3y3qWCMbmUlOXfiQzINrHw5WCUYHBVSeJawM7WNtAh8MouFmwFddqjNHxAwgQxYUr67oyScXRO8dKoo3g1IcN211uR/BnEWYon52JQLn9JmFvB86Tl4qXojlf9CJ9Xp1l5C4jlWvVAEMBxU6cmd+XE83rGO1wxZXD991ArNOkQVak44+D4S8NKWKzzAscVM0c2SHsiXOB9NhtnGRBgQAQtBuL2ixS8ME0V5hNIo1nrPEAQX2Fgv/7t+Yw5sIsITfsUJWMmjhzXRZfiBwzAZslptKUsWnyLRDw62LtR9AuxT3WeluHN//2TYYqBDqsAoRO68zSUtSHorFtLigqKD8aCPidi2AWqTdX3QuTABO5YxIekPRkNkrwjG1J81gHoR48McBhm6cBnGUqRnaUhrRjRmvdqio3UNvXM/Mkjx8TNIyyUC8ZUt0eR1sei/1yIaitwKa3/ImMYmLztvqMoPfQxrlMw3fV9CauOexA5+IKOW6zNv7+bCVgLWb7xK1qJxSaivIN5vJTK825i32Z1s4uQmQvSCtx1GnSlrv2mbXwBLRxqnnbv4bKCn7FZQE9NOSBf2aNtkoiOxAOcr9ydDnIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(396003)(136003)(366004)(376002)(5660300002)(956004)(44832011)(8676002)(8936002)(2616005)(478600001)(83380400001)(6916009)(6506007)(6486002)(4744005)(4326008)(316002)(2906002)(38100700002)(38350700002)(52116002)(36756003)(6512007)(86362001)(66476007)(66556008)(186003)(66946007)(6666004)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ETAdQ1os3rs5Z+Cf4liIv8Os8EXmu6RfAv9QmDIMAgE7oNME0pLXoG5C65qK?=
 =?us-ascii?Q?WhGBwiD1SHPjROKZQBKfHS5TehdCR+Ht0ShlQu7bVWtYmuqoaJdBXmIsfL7q?=
 =?us-ascii?Q?EqdeMg8r6r9YbCQMKA7F65srhDkT2TfP7RjKRL34dLQUJ98JazdfXjCnIFuq?=
 =?us-ascii?Q?rjzE7FS5hQpeWahLSXDGZEcZL0EVYwt0QT7QVuuje5k9Shmfo0FgN80AdI4r?=
 =?us-ascii?Q?vsHaYJLdq5P+N4S5Kv1eazz9bYSEFWZXr0RmCvySspUHOyqGW/D3iH3h1rxE?=
 =?us-ascii?Q?DrKgq5Zuvsjrv5DXDY4VflA0cV4rBNNzRxjzJR1Wg/E8aArWzin+QWOSs3ic?=
 =?us-ascii?Q?NlNqvAqOou9l5fOwnZBEeQM1hyH9wHtkk6NefLU9pgu37KQsEBx9zzHC5ko/?=
 =?us-ascii?Q?5RVsEbQl2iEYk345PlLswHe2MfJyylneOt3/Rl76jwfi720tZfDIM+92m6GF?=
 =?us-ascii?Q?bI6xVv2o0xz47jSiAhKIi2xSLJQ7/khLIWPAcozmE98w0Ra6o8lL+vp7JPCW?=
 =?us-ascii?Q?Z0PZisEIKsXhjdu8iT7sp2T4Hqp4TsVpr1fV6toYRVfcEVZwpZJ2zTkUOoA5?=
 =?us-ascii?Q?5vuHB4ZLpwqr1C0DnQLChvdP5TheDHVpvRjPhEutieDIqo7o8GIoWops47PO?=
 =?us-ascii?Q?JgkH65jelwh04edpoSUOyvqcDPfckV2PiQU49KTQFZJ2MOzlGNTEybwj1ge6?=
 =?us-ascii?Q?5sYqJsjvAC9RW8HSQO69GLKVrY9z1H5GBUHY/E3ETl7LkO1c+dq/+MI/nOuy?=
 =?us-ascii?Q?5NtkZGGzwh9OlnLdh0QwWYNDILDLnd/pYzCD363n8DTgtgqD7LjwZxTRZt/f?=
 =?us-ascii?Q?ysCq/nofGksqugwlw8MWGyJDvjTyJ4YK7KbBMsxtQKD1rHdymj1UeijQcD8l?=
 =?us-ascii?Q?HRImZY0b2bIcaNyJUYn2qAOUBBMR1hguxJXl7WAch+aNJ3gHCqX30OZFZEBk?=
 =?us-ascii?Q?1mu3t0BiVqLNApctjPqteRKZJlFi2mE3lZmFleVi0GHX9kP+0mBTRkWs9aX2?=
 =?us-ascii?Q?xr/pWdvRk22xeFH98Q8Wet0ZNlin1fvI0vyEaZo+Z4ZTmnYILOv/8sqqVIKZ?=
 =?us-ascii?Q?2WKrdVDs4rRTYONt8oRYXBiNHjoHbzuZXiaHWud7RfVtATmzp7PppDnqEIgO?=
 =?us-ascii?Q?RhHaWjN1i+Mc+o5gcC81UdNON1ZXa3jdjvHbMW3yM4yB2l2GzaRaSD8f0WX1?=
 =?us-ascii?Q?+tpSy/ApcS2b3jW0VV9QwGhNK0G0Xf1ftpMpLeE+bNKk2F0o8WOdOP4ykJ5r?=
 =?us-ascii?Q?SBBVuSysWgkKoYWvFJMO6n+vKwlB0NQqacRDNzMB3fG8x0qYZL3upgvYnFVb?=
 =?us-ascii?Q?5mplhGiGHUnJCN92OCz8+VqW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4770cc9c-b423-4e3d-c919-08d963cdb469
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 11:28:59.9766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2M0O+ioAl6N2S7xiEMSm8d2iAuxYOkfhuAYLn+n3YXlSfdt00vghH2v4Df+H+VmKjjCqb8lmwyYqzQPJPMcEpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4094
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10081 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108200061
X-Proofpoint-GUID: iXXWICv_1PQbUMb64yf6oroHyqmqzfxj
X-Proofpoint-ORIG-GUID: iXXWICv_1PQbUMb64yf6oroHyqmqzfxj
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These fixes are inspired by the bug report and its discussions in the
mailing list subject
 btrfs: traverse seed devices if fs_devices::devices is empty in show_devname

v3:
 Fix rcu_lock in the patch 3/4

Anand Jain (4):
  btrfs: consolidate device_list_mutex in prepare_sprout to its parent
  btrfs: save latest btrfs_device instead of its block_device in
    fs_devices
  btrfs: use latest_dev in btrfs_show_devname
  btrfs: update latest_dev when we sprout

 fs/btrfs/disk-io.c   |  6 +++---
 fs/btrfs/extent_io.c |  2 +-
 fs/btrfs/inode.c     |  2 +-
 fs/btrfs/procfs.c    |  6 +++---
 fs/btrfs/super.c     | 26 ++++----------------------
 fs/btrfs/volumes.c   | 19 +++++++++++--------
 fs/btrfs/volumes.h   |  2 +-
 7 files changed, 24 insertions(+), 39 deletions(-)

-- 
2.31.1

