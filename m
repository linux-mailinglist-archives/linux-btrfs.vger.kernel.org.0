Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC983412DEA
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Sep 2021 06:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhIUEfX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Sep 2021 00:35:23 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:20180 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229642AbhIUEfT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Sep 2021 00:35:19 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18L3TWSN025457;
        Tue, 21 Sep 2021 04:33:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2021-07-09;
 bh=GzZBJdVo7kPAbRRP1QJOPWtA5m25FryR8IHMKTSRUr8=;
 b=z7nq1u3Klh5VzEn4s6CQcqUJUIcsk231mgWYAmaplug6S0AqfmDpGj0zgHG5ONMat2xh
 YkuX5DdcaP5uPmYx114ZWD+2SzGPdJXqlegtC/ZbOdgGtI3FUVTY+Q0NtWg9t2FJZInC
 SsvXS7blNqzZJGZn2EDmw/a/1wUEkGEuM5U8McFJhKcbNp0HQ3DjyRY5wUoNEsAKMHh0
 2zqeeqHDeW74YpK/Sr7ONlt3R/vLzHkx+jRB+lr/uHUfeV/1Pr4hctB8E5sGGyRXngPf
 g8daEr0BvD5jU8W8Q7oZuvv4jYVwp2DsN+c4TkQp3TdvUHs3fHDihKs/fev0kOW0ztCv Bw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b66gn5fng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 04:33:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18L4UkS5043556;
        Tue, 21 Sep 2021 04:33:47 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2043.outbound.protection.outlook.com [104.47.74.43])
        by aserp3020.oracle.com with ESMTP id 3b57x4xkjf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 04:33:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCEG6xfY8iqwKB+DeAgXim4Olr0rQ8yQlQVQ4azkhffrscHnMt4axZaBBJBEAAfR0YcwDpLPzE3EyTU3CEkX/WXqarL2pqk7Ekj1DksSZ6wYcWUFfg47hJhlfFP+F0HUDFBei82M85ITbXemyj1SLAUBwTY4MfV6Lgb11func1Rxu3SaybIxLnEHHgtxCV/zH5d40feqnrysKFmYPTj0nlYjC9EGV/fuKl/SSRw9Wn+0MqwyI8w5AEFCF/8yGHsy3Ms0psTlcYcw48g8aTzTB8gNKoF1riPES52AXvOwy0WKR8SsKJh57Gb+gYmqS29Eaxtl0olAzuW3ZGBWkteZmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=GzZBJdVo7kPAbRRP1QJOPWtA5m25FryR8IHMKTSRUr8=;
 b=eqnrTv2Q55x4TBxryXhgwQOA48k21B1znscR+PRgAJ6pLrpT/VjmpKNXbRlSpKiVG8GjdtWxIo7moM0eTwGEbdLChugOcVfh3+zNQWLEC/z/JWU++V8FJhicWYwGhAhMAYYiF/A52wYd+NhmD/T/W5qIQzOLz1gOErZKPkim7x59Yx9omFTTVBiuig5/pwjvaP3OfMNx5MB2hlGEUnyIlFehMVf1zZsxeMuAE7APwIHVusFfw1e64LbLTY70kwVI3f9qZns9pA30ExRgaosIZJa4e+4hzpmgNXv7/zucaLmwvwap3E2LXy0YGuaQ5Cgs5ysk/4mMMyrW3nxTeQ1pDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzZBJdVo7kPAbRRP1QJOPWtA5m25FryR8IHMKTSRUr8=;
 b=aZw1lIqPiQS5GnvWS5NQ0PsEziM9FQzRaYG44JUaXIrXD5ScmdWgLtgPxRq/ndYTi6P1qGUjpokKixFf1VkqsgAQCJcuerj/kJtrpk3LBTW11R61IYRe59652Igt0BK5S3/KcexOmvDhHevtpUpOHjtn11Es6Oq7OxX40G0U+7s=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3984.namprd10.prod.outlook.com (2603:10b6:208:1bf::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Tue, 21 Sep
 2021 04:33:46 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%8]) with mapi id 15.20.4500.018; Tue, 21 Sep 2021
 04:33:46 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: [PATCH v6 2/3] btrfs: remove unused device_list_mutex for seed fs_devices
Date:   Tue, 21 Sep 2021 12:33:24 +0800
Message-Id: <457af6350aa51333fc584210d8dc5ca7e679f3f9.1632179897.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632179897.git.anand.jain@oracle.com>
References: <cover.1632179897.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0129.apcprd03.prod.outlook.com
 (2603:1096:4:91::33) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from localhost.localdomain (39.109.140.76) by SG2PR03CA0129.apcprd03.prod.outlook.com (2603:1096:4:91::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.7 via Frontend Transport; Tue, 21 Sep 2021 04:33:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2265907b-61be-42a2-69fc-08d97cb8fff6
X-MS-TrafficTypeDiagnostic: MN2PR10MB3984:
X-Microsoft-Antispam-PRVS: <MN2PR10MB3984F23833459AD8C0CE5F44E5A19@MN2PR10MB3984.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7NCHO4Ygk5TyXu9JNUsKfpYmpuoa/tw36pQAam8CyoEZmqPh+cnF9UX3EQQJxrg4Nc10Z/BJwIbnwEU46AW6EcvDEDTo/9oXCJP9jPycJcxFOXaIHJVE66uh/bt9Lvfk3k7ItIJR7vux56sislALGhm0jL8Nj97q2Xd389PAGzB/6E7fVFv8lnqrsbMlB9xYp+sPuUlM3rN7XhUE0Peej3UnJEvqB0wZFjGHI9nz3e9N0RIKxABP7oG34FiRbv5dmsKkF2vjalPHB+94LEHB49lr9InFX7S7YHkkDh9zhVdxzvSEUKl1rOpDkHH90p7pnR+vjmra8sQZU0rpHUxqPzJikPQc9FN+/8fbcnScMEzK9E2Z4wnSWiC8ilNTizpLT9kHeq5vpTsiOzXxTrYZUOlhflyD867Ft67rhogFpzFUOa3/gutNIoXbIkjMCi2N0aFG0er/uWHvJck9trkyW1+ZjTA3+fPQXkgDHZhgtX6z39ACaNcEGPFq8bxtrJa37Kr8uRKAAEr0Fuc+x0zdvpHMrE2BlSTnbMRV1byYpBQf0cpudg4GnfbtWVnqBYNkuxIbjekc1fU85lIhYNo4zSVon64Ue7xmyJL20108keVEW5eNuKFp7UOj7n3lUGDrtrPaCI/+Qny/xVfrsHZjRB8uJ1cb+BUOKiJ8/mWk2idwFqR2o/NUMlg6gOhN6Mq+emJAs57Y2IbxyEfmNlRWtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(136003)(376002)(39860400002)(52116002)(2616005)(83380400001)(956004)(478600001)(66556008)(66946007)(8676002)(8936002)(6506007)(5660300002)(36756003)(6666004)(6512007)(38100700002)(2906002)(38350700002)(316002)(26005)(44832011)(186003)(4744005)(86362001)(6486002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uo1v6nZoyTQ/gOLP2jO/JfX9oX7T60/IwdOiji1fsOjoyv/UeSWBdLw9gYX2?=
 =?us-ascii?Q?qViAqPLhzL6Q1Z5/BZ8ggI6r6R61Ldt95LNGgGsW8iBM3I6H7IpqTZtTRP2J?=
 =?us-ascii?Q?OFCnTVyT6aImZeEdZTrkKrRWz8m9IQ3/n17q89rpztVW8BI0UuLe/s96FR+p?=
 =?us-ascii?Q?GWErN5vvRMPYKjJPWmwoYw6E6Caz2REAukxih602TUTpgJ24buPkNOL4TUqC?=
 =?us-ascii?Q?3SVi9sVhbqHs0+ZQa603tVrtADXeS8mL8JqxfUShV//ZImqLW5au4OMnA+hP?=
 =?us-ascii?Q?2As+7hnDBszbqwx2xNuAKsiTJFFl1qLrXouDBIlljU/+VlR+7Kdk+kGQnqnP?=
 =?us-ascii?Q?anersvX3+ahPZUrxq3n6N9DDrbQCCq0dx7OOpHJ713oQlh9Tyo3Zmqf4rScT?=
 =?us-ascii?Q?sXrJuKUMVNpa9/Ev+F/VLR50G9n2k91B1dAusrTXywQjXgXNITchMmd5PIDY?=
 =?us-ascii?Q?x7CgMLUBHTpE7QBA1JmOt/KAU2aRFY55Kk0SrDVUwa69WHtZf7ByPdP1nWkO?=
 =?us-ascii?Q?IvSItYE70Q8S1932uE1KiPNM9R/XF5hWVtdKMv1t79a7sLHFvwxPtREZCDFc?=
 =?us-ascii?Q?FA6VLJ9QZn3B5ISNn1Lj50IV6O5uPD+FjuduCLLscpHZDh5kdf0W6vTOdB70?=
 =?us-ascii?Q?B5F4r3sdjEtB7eXwXrYcRRezJHlIBUMPQKtDwAVOs/4b7AjpEXXp6he74lzZ?=
 =?us-ascii?Q?GpKT+gcR9tdCj/Qp3dfeoMzXkpr8xmTPsquwbt4ae6Q88tlOVMHFwhcEtJ2N?=
 =?us-ascii?Q?NYU53xFl5j7HEJ4bbE/hnRkVsWQmjVqAklxr6UjOMo2ANxHWF8LO/VZhtmfh?=
 =?us-ascii?Q?cRUkznPuD1UgvmQcHnqJdzu4QvMUJqzmgJGjAJwbXEnFs3GQv45Blp3WCwVc?=
 =?us-ascii?Q?CBOd/2q9zES5GJ02PQCe5fX2txgNwYXScoJukrjZwc5HbB0RYBmsSCTYJSEm?=
 =?us-ascii?Q?i0nU7Ftiq7aTI2+pdU3grJyIbFU3h3C6DNGD4/jIN2R56ht+GgUQn3zHsQIl?=
 =?us-ascii?Q?cYbproMQczgEqIPdJ1KsA2KQLD2Jd8zWlpuSLAxq7VeJhVFFowPlYLlaxpyb?=
 =?us-ascii?Q?Kg0WTop7MDmw15j8Q6Q1KGolXQGTbTu8GtGCjrkRxMhtvEBYJRM9ylEgOVyp?=
 =?us-ascii?Q?DpsBFhEY+krQ7oxxTNqwXJ0TLHOhf7DWnMqtFCKRSfGXcovN6ZuBh+MLvIiQ?=
 =?us-ascii?Q?58pWI5YHID5ioeJADsHJVTvFuGcfUIRZE1sHJg9uzJBViRKgocDtbRDr5Y11?=
 =?us-ascii?Q?+Xe6mNhMQj18zGVRb+0oSQ1T6bxkVGg/WEhAHryU0CGhppV3G51XCuFicHB6?=
 =?us-ascii?Q?LuReIbdMCca5EW4XuWM71qqm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2265907b-61be-42a2-69fc-08d97cb8fff6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 04:33:46.3375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z97mQS7ZJ878toXIL4xNgp4hJc799fXGhFaI0Au5lZ7uw9/whakFI26+O9rBLldJOG1PZG+soLtUQUNMcpZG8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3984
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10113 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109210026
X-Proofpoint-GUID: HiP1WYi_7fRZQxKgFoQLUG1U7jyXzlEd
X-Proofpoint-ORIG-GUID: HiP1WYi_7fRZQxKgFoQLUG1U7jyXzlEd
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The btrfs_fs_devices::seed_list is of type btrfs_fs_devices as well and,
it is a pointer to the seed btrfs_fs_device in a btrfs created from a
seed devices.
In this struct, when it points to seed, the device_list_mutex is not
used. So drop its initialize.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v6: new
 fs/btrfs/volumes.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c4bc49e58b69..e4079e25db70 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2418,7 +2418,6 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
 	seed_devices->opened = 1;
 	INIT_LIST_HEAD(&seed_devices->devices);
 	INIT_LIST_HEAD(&seed_devices->alloc_list);
-	mutex_init(&seed_devices->device_list_mutex);
 
 	mutex_lock(&fs_devices->device_list_mutex);
 	list_splice_init_rcu(&fs_devices->devices, &seed_devices->devices,
-- 
2.31.1

