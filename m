Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D454345C6
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Oct 2021 09:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhJTHTT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Oct 2021 03:19:19 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:46782 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229771AbhJTHTS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Oct 2021 03:19:18 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19K59ge2022167;
        Wed, 20 Oct 2021 07:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=6kk3GC70yYKkFczHfoFKw5jYGXVK9SMDmpZTiLKY7sA=;
 b=1MrpE+3Ct3EFqHHlYU3KIWZaLDhQW9MJV71KlH6uBAGfL+F4GO6fI3A9mQHta7MVlqgQ
 OaY4b9TjUYc5W/aEAF9ZNoNHqutyS2hBZ4KaHrHKSevfdn9+ldod8ijWod26Kv9qzvYX
 x24wZMfTS1qB2TRu/HQ+vUcdRvBeV5DOjObgFELSKPLGPbI0GO4IQRjUJWhMwY/0/e7C
 uk45jlEIsAjwaFeD6mz5U9qrg/moyyOPfzl87HS1IKwIg+UUy6rO/7fLunPgsptKXHnF
 fzqkJ39U1obEsm8inUAUC/CsZTL6voxvvO+9q4XK2utWowfSEeeoP9eb+XlQ4D/7tvS7 3A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bsreff8bb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 07:17:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19K7BB2b102202;
        Wed, 20 Oct 2021 07:17:03 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2168.outbound.protection.outlook.com [104.47.73.168])
        by aserp3020.oracle.com with ESMTP id 3bqpj6mpwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 07:17:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRsMaZX+Ty3b+rY9UantvrcUiti6/54knqFGrE37bOD9vLZEb6pCu3Xm6qER3O2HY28k+XKlEf8GVkZEF+YDABN/5AuVf8hrjb/bByfvxfOLGYJUB4HtUjlo4hBJlp6/1vYF/6qN4zDcVdMDPlhzuPyua/ae5D6W7jT1AWo0SqYpS6HizY3nfOul8ONi1EpLqTtZVrsQlD7aZSz2j0bUycI7n2YBSmIp0MRGea11yZ98yEStSxYiWUGv8mGRMpDjGQ1PP5UiPQIMrmAkTv3Md5xbMLCIZLhI2lG+MCdb0fSW/tx9LB6fil/NFHRTTFP6yAGZw+TW189AEiFcJ+Hg3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kk3GC70yYKkFczHfoFKw5jYGXVK9SMDmpZTiLKY7sA=;
 b=f0Nh5snL3RsAmwuAVKisHaCtNFRfn76b70g/uvX6a7GqI/HBtxcHZhHzrEgqa1uncCzDwOlDdqAgOswxA4F30gezqnkJ/cyOsiTOSN/Ax6H9AFPeijg5wfPm01qHvljyRiIrkaJH4oN8xz9DhVrQ3j+COfii1ym4ddhTKgnpAPDJ0dOzgaMEhegcJlGjlVHu50UoQGpaFdJa9mV+A40Sva1Jfc6IbRVRJEVj1N4GYwDEMWtchmA9Fwj8vWcB6oD5AkOnLnc8wdDiKVRm7KFHRyO63aML4sU5laYLytuAaelFApnSLnRF2+49MQ2Gf0vaM1kwO68Dh9sw2722vB0y3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kk3GC70yYKkFczHfoFKw5jYGXVK9SMDmpZTiLKY7sA=;
 b=zaIjwseRy1C3X3y5fDT6ZB1vdKt8zkrL/y2pvxH84LaU4XcxnuRnd2VnzPXn7pTK0olKt9TbEErWKEVza0Mc4hXQbvNBt0Qf8XiodEbvquu6W53Muilbvx+rifVfVfJhoEC9iK9wwnjf7bu0FGdQCngbLvjPQ1oMSFdRDy0dFuc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4094.namprd10.prod.outlook.com (2603:10b6:208:11e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 20 Oct
 2021 07:17:00 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 07:17:00 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com
Subject: [PATCH 0/3] fstests: btrfs validate sysfs fsid and usage
Date:   Wed, 20 Oct 2021 15:16:41 +0800
Message-Id: <cover.1634713680.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::8) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from localhost.localdomain (39.109.140.76) by SI2PR01CA0044.apcprd01.prod.exchangelabs.com (2603:1096:4:193::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Wed, 20 Oct 2021 07:16:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27661dd2-ee41-484c-5810-08d993999baa
X-MS-TrafficTypeDiagnostic: MN2PR10MB4094:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4094669707E6DFD7BCB35EEDE5BE9@MN2PR10MB4094.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4x6ZVvHV0l7PAr8pT2pdwumg8km4pGk0a+Pd2+NMxkZiVGKMhdwXJYak3hOJy/olhVr0CzYyz6sfd5Yvh7+G13G1DH3IpXYoH8CbLUfMUwsduawDARsNhIbUnlxqN4Ajn99tu+O1xkmUJs3pxZX8zuOYB4ml4hHKuo+Bi59MF2Kvw82KPb0ptYmA8t3dUAC5IYP25ku8L3dXGGWl9M679x9CWvD41UJY1IpDh48yMG6keGuY/6MngnB5ca/aybvkZEgfVtdULRKwlN0X/IeTLbpBger+qa8/myJaPIr2bvFDV9jSv7hNQqrB7VcFaLt+C/q5YTQrUAXPkiBBoFhRcrO1WHLqoINm/b2MJE/g+Em+4mvKaogDJ5z2UU5PO3uV9ysmdh9bhW65GLHnQAWnO7imshrdxYPplq+jrN47PGDrrY20YWbqVrnCDPEDoAn3tlEmN/Zxt0wzWnGwXNNgPy6n4ypOjWeenCKDuN548ScLoGazcBA7x8CO1bO4rvDxxe/SVTplUR33BKPul/9kLnSQ2T0jeS05ZiOJKw/aWUENTY7+psZTqxKojfJCVAXVqfZEro/7eSVlDfROMBzObDYUFYoYCcSDW7lbZ5PXYTAJ7ZugbJ8JepOuAGgSk4ASLMYHlCt38YXIwUclPduIMrOb+qtRLDX24Put/KRygtuX4DsMLNY5e4SZPItKZ/D8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(6916009)(66476007)(86362001)(508600001)(38350700002)(26005)(83380400001)(6666004)(66556008)(2616005)(8936002)(15650500001)(4744005)(44832011)(4326008)(36756003)(6512007)(38100700002)(5660300002)(956004)(6486002)(2906002)(316002)(52116002)(186003)(8676002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qO6HA3TiIN2hVYHrqSXqxUaVjLgyNvi7k/sSDsJNa138yI1nft6t/3zoFIGN?=
 =?us-ascii?Q?m7/L8haa3WHvLV1LCTJkuHrq4TWbMUMLeub8dsl9Skx5Hicy3ivWn7ECPJzZ?=
 =?us-ascii?Q?LfJqHBtnDUTUCYoXvobk8vK6QdxqGigxQUWXcLvlzTEbH7eJfXUi8N0Y+TcD?=
 =?us-ascii?Q?SAsujxgKXRcNw6s9Ry8hp4xZrULyWbEAwcwFMI885DtidxJdRIO2vkre0yBD?=
 =?us-ascii?Q?R4JYQvJYsMfHUBatgN9WlA+dAQj9EQpikrPyb6pKwuClQ2UUpAk50YI+lmV3?=
 =?us-ascii?Q?eTOwwQz5460inoxTuYb/hvkQINdvhF3yQL8i9E3W7cSA/0IVGW/YLwuGXPnm?=
 =?us-ascii?Q?KcrAmpDrSGrnug3/7oxaOdGQbZJnJBIJXzP6m5a4g/FBLxFbYGXLTU1vn56X?=
 =?us-ascii?Q?O6lhUnUDyVVDGX/k6tlcJMz2RYkQmJmYjqLt4TS9YnDcquINKrZodgW03GI6?=
 =?us-ascii?Q?85Utb6AvwSJDekpzZIl9TUR1YN9DukIeTBDTOVBDzGU9SLA1v8qXXuDvA9PI?=
 =?us-ascii?Q?I52VbwoHw7kfYJJWvPp6p0tUg4Qv9TYi6wSaCYV/b/LZ3AmJZKFprMFJBwxH?=
 =?us-ascii?Q?WHTsewYirs0FHFfdDc7dO22Nsw4k3PKriKslwTClmzYdeyxC3YGS3tD6oHBb?=
 =?us-ascii?Q?15lgNmLu8xvu+/WWE4dzyIXQMMhEukJ9UczJDk4UGPR+N1JBZiOhVJwFMWLh?=
 =?us-ascii?Q?6X3Jex3Pumf9MYnHU4my38vwzOZUJhcrSpSFkgv7XYMbwfmyJF1T+6X5O/Ao?=
 =?us-ascii?Q?nEubk0r2uSS6yerz+x9sqQYVjQ1uQAsaWY0UI5CsasygfiJtqjJ4FMUv0viR?=
 =?us-ascii?Q?nkrzu58uoYel6kQhuue6NdmcnQqKG6aNX7Tryr4Te0GGrJ6cr6ESVfex0VDv?=
 =?us-ascii?Q?Pzo9EYio7KWXaHp2g1Jfv/qCYD1RhipDwhAw2yhIYKJZuQYl3a8UQ4Rt8kze?=
 =?us-ascii?Q?AWg6NH9z21pHVT6zYZdAKw/r5NGzalAC1pZ3U/Lt/TcYBN1CyQsXiOrkw3CE?=
 =?us-ascii?Q?ZTQRMOk+XxM+UewD+jr5uX57nLEgtW1bWo4aaNht564UAEB8g2ByxvX0I92y?=
 =?us-ascii?Q?I1/A11J/NT2sTw2q+nwk9sNWwvQzC9VNIpxwsouAwjtqEUg1AfXkQCvdYJ41?=
 =?us-ascii?Q?ZiSLRRHirae/7wJ/pxbbGayN847xbok4J8Df5155vYUX7Hd67LgItGDk5Gf5?=
 =?us-ascii?Q?qKw5E1xfg4mKIHi2wNSrZHL0z4s/ctHbKa0MqvRNlHIXYSeSfo/HjB5oWuHw?=
 =?us-ascii?Q?Gp/3VbbvTzEOIa3/Z4YmPb4fEbL+iiEwKfCE5oS2jcefUzEVwXuUOhIHw2da?=
 =?us-ascii?Q?LWeS5r6qMNBturB2/w75oHzG?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27661dd2-ee41-484c-5810-08d993999baa
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 07:17:00.6102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anand.jain@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4094
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10142 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=681 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110200039
X-Proofpoint-GUID: gC2T_D6AUeMfe-Vn6AOZ2JlMuMRt_xVZ
X-Proofpoint-ORIG-GUID: gC2T_D6AUeMfe-Vn6AOZ2JlMuMRt_xVZ
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Patch 1 adds a helper to check if the kernel is latest enough to provide
the fsid from the sysfs.
Patch 2 validates the sysfs fsid against the fsid from the sb
Patch 3 is a test case to make sure if the btrfs filesystem usage is
successful on a sprout filesystem with a seed device missing.

Anand Jain (3):
  common/btrfs: add _require_btrfs_sysfs_fsid helper
  btrfs/248: validate sysfs fsid
  btrfs/249: test btrfs filesystem usage command on missing seed device

 common/btrfs        | 14 ++++++++++
 tests/btrfs/248     | 66 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/248.out |  2 ++
 tests/btrfs/249     | 67 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/249.out |  2 ++
 5 files changed, 151 insertions(+)
 create mode 100755 tests/btrfs/248
 create mode 100644 tests/btrfs/248.out
 create mode 100755 tests/btrfs/249
 create mode 100644 tests/btrfs/249.out

-- 
2.27.0

