Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2543477258
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Dec 2021 13:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237052AbhLPM5P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Dec 2021 07:57:15 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:4566 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237121AbhLPM5N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Dec 2021 07:57:13 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BGCLAbL012513;
        Thu, 16 Dec 2021 12:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=AwoV8nyp2Rwk3kdTuofVtNRbjXvbX9U6fgRTeECtr9g=;
 b=yJz/NKHyXpFVs8y8Z8HA5GgfLH0gYWZKFP2HWh5caMnlcdFLwO9mFR8S35YcWxehiAQy
 PDX3e/IEYYOs+hcyHxLIghY+/DO0Dyn/QokDaP7F5fM2zgTj7np1gIY2yO9x4LWZthyG
 yDLtqAqNzebc00ep1Qg7SaDeha2fhE0Z3EyACidFKTjrSDTRpi2xHzlzL9K4lAaKmrfi
 F2ByX8yaxmlnFr+IP683e8sjxnJ46cbfqn4apfzVuERRjVlx2ttB/Ogj2TbsFuO5duQc
 q+58fk2rAqkkrkEYNFuy9nwY7r9Q/Z/ohul0s2BvgtzK6+2NW+vNreUtSC5n18OMF4uv PQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cyknp2ne7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 12:57:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BGCoanf031481;
        Thu, 16 Dec 2021 12:57:12 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2048.outbound.protection.outlook.com [104.47.73.48])
        by aserp3020.oracle.com with ESMTP id 3cxmrdb9jc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 12:57:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSCwc/Ml3JyacjGCSgqlI1O2cXX7qE3wuvoxMoCX8/xTpGV28IRZtgI1s7/TCi8w5xgE/6XLZcsyR+qRF4hQNH9C+bhBw08ZI9xVvqlhi/x0phma+Hp+Wv8sPpjL/F7E5Aj0Yh1oH1biUfTJpQB2U3wk9xTRfg0oFwa377YirEuBXpcM6I4vmX5IlJgqSdwJGL6IUO7ZFdGE+HRaqRWj8z4ym7JjU8MmExREYvlIMVp4E96ao1lpIKwVz0ECxRJMSbuctpDUXTxLRR6h6UWnlkT1TFhfIm/L/sPSuzd+DbShjqK+Yi2HG17Z+m7h6WS+2KJ3KCpOxhWqhq1ZEyTb2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwoV8nyp2Rwk3kdTuofVtNRbjXvbX9U6fgRTeECtr9g=;
 b=getK5XUbcdYdVDMcc32DzMhnJ2fVj7yRixnKDjLSn6z4ltfdlh2MLwxjHbEtMFj2OGk3G/vPtIzlJUoPtrV9y8XH6r1FIyEfUJI4T9ui/LeUgbIP0MLogdnAXViv98JRuvQ7LkDrDyOuhsGye0q5hZQ2EghtBwjbMilhHgS1XXLuxrHDnKMA8GxIDZFmUcIyZLD71b08l1EjqKC7fO3df6HnOlobXPwPGWNo52flBq140W8ZD2HmcxZZpytCkfaV8IlCjoYDd00IY7KWarisQDrOXndIneeY+4IWY3KpyQI+ctH1d/KKrAfqF9fmetsIPXr+L9E97EoBnrsn/g/dtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwoV8nyp2Rwk3kdTuofVtNRbjXvbX9U6fgRTeECtr9g=;
 b=D3LCbTwWln7AyCRBin5+g03amPvC9BAx6o1Bd7P+w0sXSdqMbgnEW24nnmEnWoTqk+rJLWDrJOmljzhfyh0zB44HE0+6yKeUlb3+e3DSBZ6iUWozzsW/8QF5lq3IJ5S/8HxZhc2NZDFAFsev8ZacHfbaHQjO1vQtH8MeBqxNLTo=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB3425.namprd10.prod.outlook.com (2603:10b6:208:33::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Thu, 16 Dec
 2021 12:57:10 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4778.018; Thu, 16 Dec 2021
 12:57:10 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH stable-5.15.y 2/4] btrfs: use latest_dev in btrfs_show_devname
Date:   Thu, 16 Dec 2021 20:56:45 +0800
Message-Id: <b7925cc522db365166b8ecddde9ba6f4f6a6a058.1639658429.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639658429.git.anand.jain@oracle.com>
References: <cover.1639658429.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:4:186::22) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b795967a-ba5f-4ff9-011e-08d9c0939295
X-MS-TrafficTypeDiagnostic: BL0PR10MB3425:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB3425F171797BB3A81E91A86CE5779@BL0PR10MB3425.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sZLl/sBOYKKzoOfKrYD0DYugTy/g9Qa0Ay3O8j13xpv6UCxmDZt8XPSWNstzfyrsB3gvnldZQSX75dBZh6PstULHhXG7LKuNrpO/thw9zMeYOSpQPlLybfGqq+GJNAsQKWz2gufXeOvXVWH+YvBu6kcfEXaMo/6rxka5JcimAX44XYgEQ5pMHxQmYvNVXXtK2WExp/HHA7vaNmE5NOCQLq6WR6/GLuxi0ZVq/BFLf30pQMZEGit8Ieof+9rB+rpyRiDmvOUXIgauHTGYrUB6gR1QOHYIDv4jfYWRkJZFhCKqHdG1Wlm7F+ujdwQoOKd7g3U3PssF4lmZhZhAheoYZ++0wxku21b0BEbpxD6xGSxM1DS3MGG15PuG/QJEzcE5U2kMMOLgHaB0ldVtVAzQv5mw3suuoJQTyZfSQ8ttYj+B2eDYe6kYmB4EjTPOyH8mvh2rZROEWnFBlCsiQz0hEGshxHDUiwtlJWD8KDC6JyBXHrM+LdjmwLfG6BU8WGWU3o3/qoM5cnPK/zPSMlwMRJfKICoIB+aKLJgwyDkOxEK8D49PNT+izEutY6GmPPiZkTcUsdw1u+O0pGA3I09k/zX/8CYq/OOgWylkIi4588HYLq/BIDEhEFeZcqqeOUTRLAw7rp9GJ8Pr8WuYKJ870g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(66556008)(316002)(5660300002)(186003)(6916009)(6486002)(6666004)(66476007)(508600001)(4326008)(6506007)(86362001)(36756003)(6512007)(2906002)(2616005)(8936002)(83380400001)(38100700002)(44832011)(8676002)(450100002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IPtqmxJ+XrdgO4kTDlpQvKQSNoXmDNu+zLAMA2d9mq9GSI2t/GyGJFvmOqEM?=
 =?us-ascii?Q?KOnOtNY9ClUr2Wkt2Zvexi93JxaDpvipAK0MXAQiYRo0wPN6FNfJ9gQYJXxq?=
 =?us-ascii?Q?ukuGUr5H+ncKuBLtPfIsHCxi9X7XVAd4G0vrvl2eEt6YbImMmHQKSbpI2cA5?=
 =?us-ascii?Q?erihcmwAbqvmkREL8p4RadaX07QI3VEciU9x+6Dbfz0ID/H4+CpZ7jEu2q0b?=
 =?us-ascii?Q?myaXwKNhzIJwYYPLbRqtLiqvEbEDrrlWWXNAvUSooxgqyGdf5lktEbx4MHjR?=
 =?us-ascii?Q?C70rGrG9Drt8fiH2gdVYnpD+ZSw7LzAkaGaZyPnj6oCHLdJSh6smsi2DwoQO?=
 =?us-ascii?Q?jPbqReNv/mbIffz4bqqL0EqjYgWjleqnJrQ41tmhvrshjJchkCd0Iz3giNkr?=
 =?us-ascii?Q?m9qJHgL3NYa0Q3fUCVv8NbBJ09aOk51n4HG5xQ6ePmGch642bzoITuFs5Rzq?=
 =?us-ascii?Q?FbUBpXJQjo3D4zFss9JdGLdG+Op7ZHkThQjY3yGVQR78AbOOCBvMQIUoyTa3?=
 =?us-ascii?Q?OqQarPwg3uSoAZbnPOzMiWyvkSUmQA6y6Pibmpj99/MGs6v767sAHxkjavh9?=
 =?us-ascii?Q?htxMO8NoAXnggDaUCvXiuClPKh/Y9Yhbw1RfNFd9jWVATrwynQe8KUUM2PAz?=
 =?us-ascii?Q?+3LdIAGKwgR8LctcTWgGohq40hQ6pt/eepNuHxIXbEfEtKxTtgXxbiyIpoaR?=
 =?us-ascii?Q?ylyvuZHLPx+vJhN2VS1et719c9cAjqUuJl5nUbC75+DI4fjcjIC19Xy7yNHf?=
 =?us-ascii?Q?cwID/Oz3E5GuisUk+w8Z2oCkSnFw7VN4XRFcL9j1YPFhWCSkZXqWLx39b8Fh?=
 =?us-ascii?Q?qEDDFkWUXONzFJU2n99ySoPDzrSze/NspL4xyuNvQc0xeA6NQPIo6051IU0s?=
 =?us-ascii?Q?k7hJgdq+jTAtfK3qS7xMKZVVEcQlMFqvG1jqHMd8Y9et4RC3A/nEVsGYWZUm?=
 =?us-ascii?Q?qjMgCtVu0F40v1gF2H+p5hhvEzR54guRKZcuNaP2aoa3fnyo7ptn3W33CEKm?=
 =?us-ascii?Q?hHMX2/gTGCzyR9HhhrvVBz+2Pk3XaTQv7PkeYbDoiTXXiNiuos9Kc7AA+qRc?=
 =?us-ascii?Q?zdMbXJ1NkIdV/vOtMptulbyWawKidTl0Eh9ElP3rpHlCdK8JENWNJy8X1OQx?=
 =?us-ascii?Q?ciUwVGzJes94MPrD+YekVk6hznLi/MvYR8IZd+sc5zJGHM4omD9Pe3sUVW1M?=
 =?us-ascii?Q?VIPp+jrD/cbI8oE0FSKCjU5wm6KiumlIR+tYvnBYIMQiAqR0nsl2Z+xNKyB/?=
 =?us-ascii?Q?O5H3DcvXGxyErEo1fk19O6FLkkOcbXGa5Xtm5eKVwhx5D4OSq55iTO6C87XB?=
 =?us-ascii?Q?Y29fwSvRouMLJIOD2OA8VXMF+2L9OLEYNuLLdsYMuC7/xcsjAaZl14cg+xvL?=
 =?us-ascii?Q?2SvsGa+3CDfLNwsxdfoEVbNO1Nv3UUYrFNBp4qLK489+IKGqXY7CIXHP7RXX?=
 =?us-ascii?Q?E6yaR8WScnZ7CY9knV8siIMJcFGt8wGShnDWXIWc5ECzetnMyKDK7MInbUxH?=
 =?us-ascii?Q?IdBIzP3kxAwPp83vamexcv5MkJ4rqQ5m6sx3o2RYI8+JRMfhVwAvBEVnrIp1?=
 =?us-ascii?Q?hkEoDIQk4fIq/ARqJ5HLEp3E3EGbDmJsLy9kzIEOERg5iZhBgQlK3THAbggG?=
 =?us-ascii?Q?2awrlchOeL5RHawm32uN55RY3hMeSeI9K6Qe6zzTa6EmNu7pfjuZENBF9Rsb?=
 =?us-ascii?Q?CFVEag=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b795967a-ba5f-4ff9-011e-08d9c0939295
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 12:57:10.2693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: moxuwvAzkePjSLtQfKdvvnE55MhIoKF3CSxUdxNDAEpXwVo4xRbEBJSG80BcIo4UC4fKCadbIfiy/owoM0twxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3425
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10199 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112160072
X-Proofpoint-ORIG-GUID: vBDO5RFBgWg-bk3AWWqAZTzE8cbob2TI
X-Proofpoint-GUID: vBDO5RFBgWg-bk3AWWqAZTzE8cbob2TI
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit 6605fd2f394bba0a0059df2b6cfc87b0b6d393a2 upstream.

The test case btrfs/238 reports the warning below:

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

Reason:
While btrfs_prepare_sprout() moves the fs_devices::devices into
fs_devices::seed_list, the btrfs_show_devname() searches for the devices
and found none, leading to the warning as in above.

Fix:
latest_dev is updated according to the changes to the device list.
That means we could use the latest_dev->name to show the device name in
/proc/self/mounts, the pointer will be always valid as it's assigned
before the device is deleted from the list in remove or replace.
The RCU protection is sufficient as the device structure is freed after
synchronization.

Reported-by: Su Yue <l@damenly.su>
Tested-by: Su Yue <l@damenly.su>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/super.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index e4963da4dd08..7f91d62c2225 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2463,30 +2463,16 @@ static int btrfs_unfreeze(struct super_block *sb)
 static int btrfs_show_devname(struct seq_file *m, struct dentry *root)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(root->d_sb);
-	struct btrfs_device *dev, *first_dev = NULL;
 
 	/*
-	 * Lightweight locking of the devices. We should not need
-	 * device_list_mutex here as we only read the device data and the list
-	 * is protected by RCU.  Even if a device is deleted during the list
-	 * traversals, we'll get valid data, the freeing callback will wait at
-	 * least until the rcu_read_unlock.
+	 * There should be always a valid pointer in latest_dev, it may be stale
+	 * for a short moment in case it's being deleted but still valid until
+	 * the end of RCU grace period.
 	 */
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
+	seq_escape(m, rcu_str_deref(fs_info->fs_devices->latest_dev->name), " \t\n\\");
 	rcu_read_unlock();
+
 	return 0;
 }
 
-- 
2.33.1

