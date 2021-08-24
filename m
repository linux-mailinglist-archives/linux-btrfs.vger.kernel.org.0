Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3D53F577C
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 07:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhHXFGf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Aug 2021 01:06:35 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:64380 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229736AbhHXFGd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Aug 2021 01:06:33 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17O0xE7l014868;
        Tue, 24 Aug 2021 05:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=khMr4HDcj7gNg1bH7/m6wArQjK/aAXk3Sd8dykb+lSI=;
 b=nNW0d2UzV9Di37+KWbqmKl3V4WwMxK1BKjsbzsKv0lniSuC2NMrvJOtY1FYf1jVkTrhT
 9t1l1LUf5HGTHLA4GoLXp4cEw8LdhgjlvYcOxsQbcMXNz7y3eoBBtweY0Fl13c+Gc8Xx
 omspFwSXymKHlQ8ZFc7SBe72/VcLimmaJ4H+qoLqsAXK1wUVe7Py84kr2lInh7ItAKUs
 vhEHJkA09LG0Ca+GyEqCKOSvId0UzX85UKxifAtpte92rgA4An1evZhRZxW0VoeN0LMv
 cio+bNyZV/vyzhUsHOTlci9qo8GlMQv6lkNyDKFa6BM+YPrPcBoSnG5zpvWjPvAPxFoy Tw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=khMr4HDcj7gNg1bH7/m6wArQjK/aAXk3Sd8dykb+lSI=;
 b=q8RNuKAXWLYYXoMy5kato6xUEmgPoBYCR/58DvAEGiBDItd5txW3fcUD9R0P3yJkXz5c
 ATC7lN/7DIeNF59CQl3HUk4n7fosVEDIQPZscTVv9cAK80mDC2cNh3HI0AGYVP8LSfNH
 +G057hOFUxyAqgPxYKlNUiw41epbUnhceKpueDfQnJZbGYe/o8h0uwFdphM4jiivw+tF
 5jaDYMd3PPjGK5uqPjDZ7aknSy1EkLixGFGzFSLvpSlU9DN9p/JEhWkrXS8BCVwqhgEB
 wcDeLzM+f88NLJD1QMCs1kQenunJVYbjKmjhNsh89G29Wo1HBVliulG5k9prEBY0UxqH Hw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3akuswkby1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 05:05:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17O55OmG062250;
        Tue, 24 Aug 2021 05:05:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by userp3020.oracle.com with ESMTP id 3akb8u1jay-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 05:05:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BB0GzNYzPQtU8YyzHnZdZ28FCtL55/r+WR9xE2c0xMrmph7KTRNyWKXk/OfTJI9ym34zqeDi6IOr9VSPJZPy+8EGeNoWQ9Uvss8ZaAd6nmnjka2XRz2N+LLSXN9qcFdQxSpUIQPZ2umETQDvlilBadoc4wKexhzdGtjfcN+5paw9KqA4B/VYae7nSUoUfjybBgHp9afr9TYKmYBG+OR/aUxjyfUuusf1WpaIl4ySBvkPzSGKkMHxbBOeZ+rbX9nmidYgUVhI9tGFyfcJVvu8mO5bKf1HT+991f/xarCnVwmM6a52fTkrOiMzvbuVwJl+BKikAB2vMfqd1vvYZ8QIyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khMr4HDcj7gNg1bH7/m6wArQjK/aAXk3Sd8dykb+lSI=;
 b=eJww5YAHbO7mgqLH3Cs07PUvbkqnsolwKVsNKF6kWXAJ3p7t9xTOACW54KnlzGiwC5Behnu2Y83sODBMvGY/l9qf3NjtC+NPiWz4ECldSNynzR0m7WX36b+ecKGzDhazUVbga4XC5X8+dicjiyheA/axBcsZAqzR0BBMiUmgxNC8pE6q5kX0KyLHHZwmYxAIBiarrTeQ9q2pQaefPAus55ZbJVgzmnoUcCIn3e9uUy6GL4E+n5I40l5yMdatB8fBuLBuPxFhbezpKktwzKDTKrdXvcmYytfMHHHhypDkmjZOhmWDHfnyXVE8AyO0tzHhyC18163M1HdkzVa7Qqrypg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khMr4HDcj7gNg1bH7/m6wArQjK/aAXk3Sd8dykb+lSI=;
 b=Cp79+9RSZ6vUD1d1t2oiB6Z5/u/bE5B737K2vpywJ1L+ly2953VdMbdjXG+e6JFdhzcdaLPXJ9i+4XvQTqmNkP5UHpfHXJ6d1znpSl5VAq2joWJtv4iJQ0KOAA9disWEYiGYM7R8T2HHbda0YGCGaEdyR2pMfwUNSSfGGwQB5s0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB3428.namprd10.prod.outlook.com (2603:10b6:208:7c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.24; Tue, 24 Aug
 2021 05:05:42 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 05:05:42 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, l@damenly.su
Subject: [PATCH RFC V5 2/4] btrfs: use latest_dev in btrfs_show_devname
Date:   Tue, 24 Aug 2021 13:05:20 +0800
Message-Id: <5d254bebd4afefa42e8c56ae1002354c04c7112c.1629780501.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629780501.git.anand.jain@oracle.com>
References: <cover.1629780501.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0127.apcprd03.prod.outlook.com
 (2603:1096:4:91::31) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2PR03CA0127.apcprd03.prod.outlook.com (2603:1096:4:91::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.6 via Frontend Transport; Tue, 24 Aug 2021 05:05:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1565d8c1-579f-4fe2-0c4b-08d966bcd27b
X-MS-TrafficTypeDiagnostic: BL0PR10MB3428:
X-Microsoft-Antispam-PRVS: <BL0PR10MB342849B9F35C34E401795E3CE5C59@BL0PR10MB3428.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iV1whpTZOFZvnHkascboLdib8YxeTmTN+1xw/Nfa+ZrAjlrcDIcR68o8XcX7o4kxwAFh5oS5rPEBbB/kxzmJ1J8BVonKazuAjOPmzcd2hCsBMzCoXEGx4FLHFJQpEEZTLuAo+X3RbMUmI4Ry2jPnjez29dnCooHuNKLzPQpJ4PruAWBr6KOwiAjTG3dMvy/yUYR9+j6jLmxHAiFwt2bmjVQCjt81vxVilsjvBid51/xTxtFqu67NZBR7Qv+SzllWGJ1JdfGl2KK5o5UF20EVl3JjafaVu5+oJD+DkV/4mRPTOMN9kti1w48YlTBOe8AqAXlAWlmuuxTtLeCKSucnNBOv83XxeehnQ5hXlV+ZhdRIM7csSB5o2mhUIncG2X/JRJ/64iUjU1IyuyXPBqCyqeNio+FR4x5rB12LeBKFQCHbWM9Z/iWDZ41stNKai7KEYBXP2o7F9pC2laZZfeKFqMT21j+4xAtPGLCqFaTN9Ri9dT9V8JwD/3+Pxr5+luOcd0+65R+kcaPVWcrsAJwTczB2mZT9+xsP4InvCcCwFSVtu/ccYaIShjWNJdRKiJM6fSr0Y3kSliEqK5F40LW4fIzSV+D8q1bU2Tq4CVP+QIBpJfkT+ugijO9uIvfjIt/HN9CrxqNw4aP0aWJXq6uPi0fWQg5+oYBLnJS0QVaUj6/QDOuUQj9MfUZEF4Jccrn9T6PpAa+Xv9Y2ZFEKL0WEsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39860400002)(346002)(396003)(136003)(8936002)(6506007)(6512007)(956004)(86362001)(8676002)(2616005)(66476007)(38100700002)(66946007)(38350700002)(83380400001)(5660300002)(66556008)(478600001)(52116002)(6486002)(316002)(186003)(4326008)(26005)(6916009)(36756003)(2906002)(6666004)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4gc2/FDdeQIcyz8y3Kqh5KmTJW60sZIIY3UaRymxdq+ayo2Y2D5lys/nQpV2?=
 =?us-ascii?Q?LADhSqu7jpgFWrcfQ6egcbBWf8cX2aV84/NPWfCseGEHysxYoYPujv+H7eC9?=
 =?us-ascii?Q?tS9bi/iqvp3Bw77tYaXJ6pGyn8GFtekiwYljYBR/YwiHfugVBFOuhRCKv2P7?=
 =?us-ascii?Q?AlW5v1DQ5qs3M8md/tCYeT4NIIK5vjWC2PIiHsdkdtO4UxX5FlLAYsBtk1F5?=
 =?us-ascii?Q?jFdreuLJ2gXJkeB4J13++ti1j1Zi9FPOVd1uCaFfQY2fL7ksxvxvqvmCveiY?=
 =?us-ascii?Q?LZ9JnKJggiB+HP/Sg84NqtVQsbNN3DaqQOqRSYFY+cRMk2JftwcUbPxpvQhw?=
 =?us-ascii?Q?XsFnfekS1RoTnZf9TWGLPo7Tbe5EQM37HqiOwyTNApQDEMVkuqTSd/v3vAxD?=
 =?us-ascii?Q?WGMdXk9UAxUjrCFln+e+QK1k0KSt5S0gN2Rp1TfD2oRIK8rqtfpWg947fMO8?=
 =?us-ascii?Q?cinnyt3JidbnMMDdktpbpe7D1GIS1Fo3+cIPfBsryvlAHbUtqgX7XmmFh9Yk?=
 =?us-ascii?Q?VkYnARMTH3Ql48wGyFmk9nAaEzTvTAxTuP3tg+DbNpcesmjpL4tpFqd3Ku8g?=
 =?us-ascii?Q?MOuGHRohEbGpY2NV4vmD48oZQkHFJSYouKSymjwRpoKQDLdRl/GP8WhEJmjr?=
 =?us-ascii?Q?0HlahERL2lsIQqCSkZbpc4nZQKNfKD78iRZaP4d/CtFf5rmwNV3AJh+BhLm5?=
 =?us-ascii?Q?4HWrO23Ij5tvDfcfu8K+1FtWanYykY6qweh31ro2sVAygfovBTvXmYkXIBHJ?=
 =?us-ascii?Q?VOIz14c8WydQEHhCAiaKfXfdQ3G0PQ51jKglySR6t+fhIUpKuD9y0v+zPLK7?=
 =?us-ascii?Q?d0ssFN6PBw2xneP8D/WPQ99wLOIcJ938PI2tKP2vXBWh/1Rhkrf3tax8R3Fo?=
 =?us-ascii?Q?bx2RpqhtYvSDz8uxC3/CBTzrC3Q5l1QehHm+DE2jJ0jztHHb1w7xHWj+gEWA?=
 =?us-ascii?Q?mgylEGY5vWDfg6uO8RiYayzIIKK35sKJRgnohkyFKuAkVj+U6r5NOlklnp3c?=
 =?us-ascii?Q?xJBBcIvFDXEZkeKtiHrRuCsCRdYnSwqxJAHBQ42tw8KaOACShIgg2GjV1gEq?=
 =?us-ascii?Q?rrzA75RJtNmL+mlzMbtfhqcK8qeVevVe5d1iMUoL1VyQ8jomHVt4PTzgk6JR?=
 =?us-ascii?Q?b1PasChBXdsSA2dMlLvqLrbEeJz/lfF+ZNcFlp+DE8gE8AGnTfDk4hLPSvUH?=
 =?us-ascii?Q?0UoP2mao5kIC+2xxWiJSq280k+0CKYAy1hcdMFVkrz1ENlDFYA8qkBhmNajk?=
 =?us-ascii?Q?dF18YtKvkOfC46b/QzZvu1k8oJqde8JaQJBdxKoDuGUZRF9qTpi5qFyP0epQ?=
 =?us-ascii?Q?kSCJ5F53ga2CEwhcIQVjUDfU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1565d8c1-579f-4fe2-0c4b-08d966bcd27b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 05:05:42.1735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FGyBYDVBqUp5QKl9X0ZLfz/bcOAkHFKexOcKaSzQ4fWJ3kL6xTcJEjkLdQrD24B8DBuujr7TxrLQS4n97U/HDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3428
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10085 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108240031
X-Proofpoint-ORIG-GUID: UNlKEKH9aZsKLBFHaSaZjkpr5_BMybKZ
X-Proofpoint-GUID: UNlKEKH9aZsKLBFHaSaZjkpr5_BMybKZ
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs/238 reports warning as below.
[1]
------------[ cut here  ]------------
WARNING: CPU: 3 PID: 481 at fs/btrfs/super.c:2509 btrfs_show_devname+0x104/0x1e8 [btrfs]
CPU: 2 PID: 1 Comm: systemd Tainted: G        W  O 5.14.0-rc1-custom #72
Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
Call trace:
  btrfs_show_devname+0x108/0x1b4 [btrfs]
  show_mountinfo+0x234/0x2c4
  m_show+0x28/0x34
  seq_read_iter+0x12c/0x3c4
  vfs_read+0x29c/0x2c8
  ksys_read+0x80/0xec
  __arm64_sys_read+0x28/0x34
  invoke_syscall+0x50/0xf8
  do_el0_svc+0x88/0x138
  el0_svc+0x2c/0x8c
  el0t_64_sync_handler+0x84/0xe4
  el0t_64_sync+0x198/0x19c
---[ end trace 3efd7e5950b8af05  ]---

Reason:
While btrfs_prepare_sprout() moves the fs_devices::devices into
fs_devices::seed_list, the btrfs_show_devname() searched for the devices
and found none, leading to the warning as in [1] (above).

Fix:
latest_dev is updated according to the changes to the device list.
That means we could use the latest_dev->name to show the device name in
/proc/self/mounts. So this patch makes that change.

Reported-by: Su Yue <l@damenly.su>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
RFC because,
With this patch, /proc/self/mounts might not show the lowest devid
device as we did before. Instead we show the device that has the greatest
generation and, we used it to build the tree. IMO it is ok because
/proc/self/mounts should show a device the belongs to the fsid not,
necessarily the lowest devid device as devid is internal to btrfs.
IMO this won't affect the ABI?

 fs/btrfs/super.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 64ecbdb50c1a..61682a143bf3 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2464,30 +2464,12 @@ static int btrfs_unfreeze(struct super_block *sb)
 static int btrfs_show_devname(struct seq_file *m, struct dentry *root)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(root->d_sb);
-	struct btrfs_device *dev, *first_dev = NULL;
 
-	/*
-	 * Lightweight locking of the devices. We should not need
-	 * device_list_mutex here as we only read the device data and the list
-	 * is protected by RCU.  Even if a device is deleted during the list
-	 * traversals, we'll get valid data, the freeing callback will wait at
-	 * least until the rcu_read_unlock.
-	 */
 	rcu_read_lock();
-	list_for_each_entry_rcu(dev, &fs_info->fs_devices->devices, dev_list) {
-		if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state))
-			continue;
-		if (!dev->name)
-			continue;
-		if (!first_dev || dev->devid < first_dev->devid)
-			first_dev = dev;
-	}
-
-	if (first_dev)
-		seq_escape(m, rcu_str_deref(first_dev->name), " \t\n\\");
-	else
-		WARN_ON(1);
+	seq_escape(m, rcu_str_deref(fs_info->fs_devices->latest_dev->name),
+		   " \t\n\\");
 	rcu_read_unlock();
+
 	return 0;
 }
 
-- 
2.31.1

