Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B504D3FC075
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 03:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239270AbhHaBXX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 21:23:23 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:6560 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239271AbhHaBXU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 21:23:20 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17ULx0oQ021705;
        Tue, 31 Aug 2021 01:22:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=EX3zh2C6Drw9eXMwn4QjpNyI1t/xpsToYjXn+FvCN8Y=;
 b=M85pEjqlics7Y+f9BxtT7LZE3ZAHVCReusxGHblseY9xLp8r1/SZx6FUQKAd7wbn+OwJ
 1g8Td8VI50fZyAdxxG93qPSKm5PASsf89ZGLARs5lGQCDIdXvElBFf6fu4VcLNUSFK1M
 UeHzNVaWM9SCu9JL8dri0j417GAyHNO1WZT9TTDlB2p8Mi39gFklnntiMg1XHbau0kGP
 JUVNYpXahBquyIGiMLmaUpbG9RDd4Sj7hbOPTw/EqmEfDnt/1cuG29Vws1THnQ28IS1I
 PCandqM6gD+MHmx2Gly6HtVNvIU3oQD30VjJPdiO77dycr1YAkLyxTi/61un4z8o0eH/ /g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=EX3zh2C6Drw9eXMwn4QjpNyI1t/xpsToYjXn+FvCN8Y=;
 b=A/wNAB/V+4V+wy4XQXCdPOO7ibybPjJ2mD4pzH9cqAfOI6PeKO8Bg4RFsCIE4ZoaYuTd
 Bd32fhfeGRpAeMCcIwHsT65nXIx4brMeqCRI14eRSADxyqjWt04Xk7orVkKiHUJWs2Jc
 7Zak1yUo1imozmEz9FAoLV2On2IDYob2M+u+s+IsVUTqPToFdvI2mr5qQIkeYJ8RiGUv
 u6NAd3Lo4HBZW10hOfzO0sKp+y+ATBaTyFTw+Y8F43Yx1+KOFW3dl7T3yCfUUEYZPsjo
 rFtlGV6uzcD9tLJZjEiq44JafQPhktMRh/rC+AuK15orZQyQ7A1oGilVkRcdqJ+cf2II VA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3arcjwb0by-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 01:22:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17V1GCQw193706;
        Tue, 31 Aug 2021 01:22:16 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by userp3030.oracle.com with ESMTP id 3arpf3b5v0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 01:22:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DeAbir/x7ujbXe8JEAU3A/kXF6Z+EwkYdZnUGFZgREjIlw9s46WKxpAZXD3qOkvp9yUEcuU7YM5cfryXt0OU6m1gUBqVYF6rQCB9AcHUa8da7UqgcR7dWYgkS2d92WoPe1zKq4z7rzI8HJsOvpCGWvHfL6wt8p/kaglPuxyw4j+Ov6jfGZJoHZKiyindd3e713X8b+DdooPdAWi6QoMN6I4XKYp1CX2qIzgHy5NPZ8KMhAeIGX0JuLcmXtsT3aYUXP81OI/O0ZqKpFwe/0BpwQ6jBY08sxOyKTHVY64DPzCu9Vh2FjULuZpCTx2NzfVzukYCpk0FCXKgSvu0RR4VlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EX3zh2C6Drw9eXMwn4QjpNyI1t/xpsToYjXn+FvCN8Y=;
 b=czAQ520zlqtPpEZm0hAMlgE7tri6mzVgPXO0ZyKnLDuwn3cVPaJtnt9jrMcYtccP9KygtgiGqd5MwlInFRhTCBjoh8Tliomzs03jriI9bl+t4eOZdNnIY0jgLEk10zBqgNsdKmrWEHBwGnbalV9kE6q15GnO4vjXagyiGK31Ei4EPun3ZTSSqZPq+4buyUOkycanlZgKN80Jxo+iAlIGSZYKZQYFknhG2PPMvRx7HrdNlP7AcinNhk4htVA9EZrCsDIcr5grh+4dMHGHVKdWXyDWj60G1uIl1poCHk86PYi4jKdcImNc4VdmvwZ8HNNtQ0HkG9DASmBZvtGzvUR9fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EX3zh2C6Drw9eXMwn4QjpNyI1t/xpsToYjXn+FvCN8Y=;
 b=RtruG3CXcYNKRAYb+k/qKgnq15i3U/pWQNc/sm1gjjWX0zJ86nPf+MiTGGJN03liIkZZi04MxWuWpvZsAp4hWSSRWjUoKiimcAoqMcZ7E+AVMuD3NJyBMqHGc17W7XtLcDaWXbgfEfRZqv+08YsxoakfnwpJr9agITuOI+0S1vE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4334.namprd10.prod.outlook.com (2603:10b6:208:1d9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Tue, 31 Aug
 2021 01:22:15 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4436.024; Tue, 31 Aug 2021
 01:22:15 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     l@damenly.su
Subject: [PATCH V5 1/2] btrfs: fix lockdep warning while mounting sprout fs
Date:   Tue, 31 Aug 2021 09:21:28 +0800
Message-Id: <215cb0c88d2b84557f8ec27e3f03c1c188df2935.1630370459.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1630370459.git.anand.jain@oracle.com>
References: <cover.1630370459.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0144.apcprd03.prod.outlook.com
 (2603:1096:4:c8::17) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dev.sg.oracle.com (203.116.164.13) by SG2PR03CA0144.apcprd03.prod.outlook.com (2603:1096:4:c8::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.8 via Frontend Transport; Tue, 31 Aug 2021 01:22:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddaf6a4e-9290-4c5a-48f7-08d96c1dc3f0
X-MS-TrafficTypeDiagnostic: MN2PR10MB4334:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4334893C8CBABD56DC4F6E0CE5CC9@MN2PR10MB4334.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:337;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nYRibwlqpgVKbwJnrEDU3+Giq0/t3z2sNodh40frqRwIYf7tZLljo648L3/RZWbUsX0q11MlQShDPmSZrTchwv0FkwZcxnWEbThu5/kNP6A3nVvJ/8D0hCsh3pYpnNr3y30FzZW7NYlAyvvK5Tpcjn+BzC9wGnpDfESTByg/1TkItIqB8Scc40GTINCEUTSVYPrhAu6b5QChIadBkiPVWMJqi5rTOQppQX93a10YS2jouKyv8AZoL2vexHuk6hAqHS4qjO38NUUpvXxNrk5BsR7f8KfixAInY67VPzSqp9riZeASQ21KPBbcNvYFTLEUcwlVH/VBwOYTLfhV3YxjgzfXYHNt9HzxyBrwkLwifRFuSFabbGCus5+NVOLYqwfkR7ssMpE5qfNlo2APQl2b2IN440NvVu8djeuBXVbNbyKOkcki3R8hj1IiFMElVkfeL07OMsej0PA/ZRGwZprWb95+d2epepnZ7XvIPPpdjBaw+8rAvwMy1UlfwYNg4U+7yjsxqCkLaHZ+Hy5IHFUu9a3JOXK3WVOFJxOleofrLD1Uz0zMsPQ1gRRsl9h967woAM32vqSdq48s2U8pcTwm1l8U0M6LHEPbAV3LnIHBUGfsw1lt+8M4JifdU7SGvT9Av8MCU/GeBuisFGfEUAd/fEN5oV4rDANq1I0IPrnUjv3OqqfJxQAN5BZC55nuBJpAwoDIfMcN12iv+Z0/jg3LZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(5660300002)(26005)(7696005)(83380400001)(38100700002)(52116002)(316002)(38350700002)(4326008)(2906002)(8676002)(86362001)(508600001)(44832011)(66476007)(186003)(6666004)(66946007)(956004)(2616005)(66556008)(8936002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ml6FThESUpdsjfvfJb0nwFva89R2zi9qpsoO2h0OSpHNQhGUfYH3EFiUhKeL?=
 =?us-ascii?Q?7SfVbJpBjUe32iIZu5LPju4ZPDUqi+hzlaaMJrqhc58IdhizDcdGIgJjSUNJ?=
 =?us-ascii?Q?33WkZErJFcGrGSGkQ+ncklkwlHRgbytdJGjAY7F0EMIqDMP6s3kZ8FfUWZtX?=
 =?us-ascii?Q?Rm4NkfOkc4zbOf0a/LG7gEjnPu6SbDVtu+DEUq52PlTtjuPflel0YaX7yECr?=
 =?us-ascii?Q?lhyTtrKYoRF9Yp1amSPlXMfKmdVGPhcdd0PjAqa07nZw0Zr9BbtBCwoPJo/E?=
 =?us-ascii?Q?Jzc26M3JhJpm9If2qu7lnDzxiL0Uk7xz87JJ1aVMJ9khRSR0mBhqBEzWbcrd?=
 =?us-ascii?Q?HWJJmQLT/uwGqwKWihzP8Fld5HSOpfkL+aP6fdsMIh4syPGsAOhcRVAYMaPL?=
 =?us-ascii?Q?h+85St15Xtm9KViW+zgJdVZOfdX1mmFQfPjjLcMbQASr54FXQowWEUBkN+Eq?=
 =?us-ascii?Q?cHG1GM/LLxBr3l2KRxxi7KiyBWWQqY3VVscGBGJNfDhqxCabNKxfv+5XOXRX?=
 =?us-ascii?Q?Y9ULFRDCwgxniu0OUgmyda6X0sApDBY911knlsiF0VUyl8r3QvUyulqADVhd?=
 =?us-ascii?Q?YViwNIZe5yns3WnXNeMMOaFnkMUdiheeoOpxs3K2jdhoi0d06/77FH1rRgyn?=
 =?us-ascii?Q?2FyVQxwGO6rWLgfgSyipH0V4c5N/KebNtePPk/gfVnGVdhwChE9fFaH9k45I?=
 =?us-ascii?Q?OakTSHCnLun3tMJ/FDxedyapTNEtdUiQO0j1Xq1njhdSQI+p0CKkam10mFNb?=
 =?us-ascii?Q?CU4cOdQtpj/XWD/LaUXLg1kcp3SIBWgTrn2xBU85yMegVsJE4JxkedUSSdC5?=
 =?us-ascii?Q?THXm/zDMxlwD0R5X1TiiEZdYdiwZ6VKw+/KjPX/thJnnptql2P1S0Q3zSy5j?=
 =?us-ascii?Q?f0J+Cwsqg/9GLD3ZgEwOzlYeK/qBTrGCk8IQ5Ewyh7TmoK99TfH/muogNcPt?=
 =?us-ascii?Q?NBKEsmso3UyGXhR3L0e5Z/fkOqTzmdm3Hf+FtT0yCcLmCo4ZZyp+uhfLKDgi?=
 =?us-ascii?Q?CXNZp+QN+QuiXxahl+BGsif8p+DxfykQINimExDxkBLnZPTH9Wx3K5XYrsN3?=
 =?us-ascii?Q?kXHLIJn+iN+rqcaM0thQJYNVpquc6B3Bzn7Eh3qjoVspRDP4RA+7BHr9w+FI?=
 =?us-ascii?Q?0PaGPrG182RFzUUEKjcK6fNG+ImVQUYAkO+KqlUeVU6f0h1ZdxRwCO6Smk7Y?=
 =?us-ascii?Q?gTjLsXbK6rwkqeeVxpsM9aCxV7NBmeIBmj5nJTmYSL3HKn9gzJjgGPIwR+RG?=
 =?us-ascii?Q?Lc0xqpqnAdvGT/O5xndWLUh0+BgLk2p/v8xCbOxsaDw9unvCCK6bwEeWFDrj?=
 =?us-ascii?Q?HUPyP2y6NYEd3WZ4ifySxkHX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddaf6a4e-9290-4c5a-48f7-08d96c1dc3f0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 01:22:15.0097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0iglG4RJan5mKTQGsvKHr8vlN8NqzqTk5VmBPyOhmTW6YDI4Mh+AB3Ds1i1ZKsis768an8sYrWJ3tBpk/HpA4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4334
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10092 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108310006
X-Proofpoint-ORIG-GUID: 0qNNRRK_qOUY8Hrrp5SHEp_KKlKkfHzo
X-Proofpoint-GUID: 0qNNRRK_qOUY8Hrrp5SHEp_KKlKkfHzo
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Following test case reproduces lockdep warning.

 Test case:

 $ mkfs.btrfs -f <dev1>
 $ btrfstune -S 1 <dev1>
 $ mount <dev1> <mnt>
 $ btrfs device add <dev2> <mnt> -f
 $ umount <mnt>
 $ mount <dev2> <mnt>
 $ umount <mnt>

The warning claims a possible ABBA deadlock between the threads initiated by
[#1] btrfs device add and [#0] the mount.

======================================================
[ 540.743122] WARNING: possible circular locking dependency detected
[ 540.743129] 5.11.0-rc7+ #5 Not tainted
[ 540.743135] ------------------------------------------------------
[ 540.743142] mount/2515 is trying to acquire lock:
[ 540.743149] ffffa0c5544c2ce0 (&fs_devs->device_list_mutex){+.+.}-{4:4}, at: clone_fs_devices+0x6d/0x210 [btrfs]
[ 540.743458] but task is already holding lock:
[ 540.743461] ffffa0c54a7932b8 (btrfs-chunk-00){++++}-{4:4}, at: __btrfs_tree_read_lock+0x32/0x200 [btrfs]
[ 540.743541] which lock already depends on the new lock.
[ 540.743543] the existing dependency chain (in reverse order) is:

[ 540.743546] -> #1 (btrfs-chunk-00){++++}-{4:4}:
[ 540.743566] down_read_nested+0x48/0x2b0
[ 540.743585] __btrfs_tree_read_lock+0x32/0x200 [btrfs]
[ 540.743650] btrfs_read_lock_root_node+0x70/0x200 [btrfs]
[ 540.743733] btrfs_search_slot+0x6c6/0xe00 [btrfs]
[ 540.743785] btrfs_update_device+0x83/0x260 [btrfs]
[ 540.743849] btrfs_finish_chunk_alloc+0x13f/0x660 [btrfs] <--- device_list_mutex
[ 540.743911] btrfs_create_pending_block_groups+0x18d/0x3f0 [btrfs]
[ 540.743982] btrfs_commit_transaction+0x86/0x1260 [btrfs]
[ 540.744037] btrfs_init_new_device+0x1600/0x1dd0 [btrfs]
[ 540.744101] btrfs_ioctl+0x1c77/0x24c0 [btrfs]
[ 540.744166] __x64_sys_ioctl+0xe4/0x140
[ 540.744170] do_syscall_64+0x4b/0x80
[ 540.744174] entry_SYSCALL_64_after_hwframe+0x44/0xa9

[ 540.744180] -> #0 (&fs_devs->device_list_mutex){+.+.}-{4:4}:
[ 540.744184] __lock_acquire+0x155f/0x2360
[ 540.744188] lock_acquire+0x10b/0x5c0
[ 540.744190] __mutex_lock+0xb1/0xf80
[ 540.744193] mutex_lock_nested+0x27/0x30
[ 540.744196] clone_fs_devices+0x6d/0x210 [btrfs]
[ 540.744270] btrfs_read_chunk_tree+0x3c7/0xbb0 [btrfs]
[ 540.744336] open_ctree+0xf6e/0x2074 [btrfs]
[ 540.744406] btrfs_mount_root.cold.72+0x16/0x127 [btrfs]
[ 540.744472] legacy_get_tree+0x38/0x90
[ 540.744475] vfs_get_tree+0x30/0x140
[ 540.744478] fc_mount+0x16/0x60
[ 540.744482] vfs_kern_mount+0x91/0x100
[ 540.744484] btrfs_mount+0x1e6/0x670 [btrfs]
[ 540.744536] legacy_get_tree+0x38/0x90
[ 540.744537] vfs_get_tree+0x30/0x140
[ 540.744539] path_mount+0x8d8/0x1070
[ 540.744541] do_mount+0x8d/0xc0
[ 540.744543] __x64_sys_mount+0x125/0x160
[ 540.744545] do_syscall_64+0x4b/0x80
[ 540.744547] entry_SYSCALL_64_after_hwframe+0x44/0xa9

[ 540.744551] other info that might help us debug this:
[ 540.744552] Possible unsafe locking scenario:

[ 540.744553] CPU0 				CPU1
[ 540.744554] ---- 				----
[ 540.744555] lock(btrfs-chunk-00);
[ 540.744557] 					lock(&fs_devs->device_list_mutex);
[ 540.744560] 					lock(btrfs-chunk-00);
[ 540.744562] lock(&fs_devs->device_list_mutex);
[ 540.744564]
 *** DEADLOCK ***

[ 540.744565] 3 locks held by mount/2515:
[ 540.744567] #0: ffffa0c56bf7a0e0 (&type->s_umount_key#42/1){+.+.}-{4:4}, at: alloc_super.isra.16+0xdf/0x450
[ 540.744574] #1: ffffffffc05a9628 (uuid_mutex){+.+.}-{4:4}, at: btrfs_read_chunk_tree+0x63/0xbb0 [btrfs]
[ 540.744640] #2: ffffa0c54a7932b8 (btrfs-chunk-00){++++}-{4:4}, at: __btrfs_tree_read_lock+0x32/0x200 [btrfs]
[ 540.744708]
 stack backtrace:
[ 540.744712] CPU: 2 PID: 2515 Comm: mount Not tainted 5.11.0-rc7+ #5

But the device_list_mutex in clone_fs_devices() is redundant, as explained
below.
Two threads [1]  and [2] (below) could lead to clone_fs_device().

[1]
open_ctree <== mount sprout fs
 btrfs_read_chunk_tree()
  mutex_lock(&uuid_mutex) <== global lock
  read_one_dev()
   open_seed_devices()
    clone_fs_devices() <== seed fs_devices
     mutex_lock(&orig->device_list_mutex) <== seed fs_devices

[2]
btrfs_init_new_device() <== sprouting
 mutex_lock(&uuid_mutex); <== global lock
 btrfs_prepare_sprout()
   lockdep_assert_held(&uuid_mutex)
   clone_fs_devices(seed_fs_device) <== seed fs_devices

Both of these threads hold uuid_mutex which is sufficient to protect
getting the seed device(s) freed while we are trying to clone it for
sprouting [2] or mounting a sprout [1] (as above). A mounted seed
device can not free/write/replace because it is read-only. An unmounted
seed device can free by btrfs_free_stale_devices(), but it needs uuid_mutex.
So this patch removes the unnecessary device_list_mutex in clone_fs_devices().
And adds a lockdep_assert_held(&uuid_mutex) in clone_fs_devices().

Reported-by: Su Yue <l@damenly.su>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v5: Vet test case in the changelog.
v2: Remove Martin's Reported-by and Tested-by.
    Add Su's Reported-by.
    Add lockdep_assert_held check.
    Update the changelog, make it relevant to the current misc-next

 fs/btrfs/volumes.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index abdc392f6ef9..fa9fe47b5b68 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -558,6 +558,8 @@ static int btrfs_free_stale_devices(const char *path,
 	struct btrfs_device *device, *tmp_device;
 	int ret = 0;
 
+	lockdep_assert_held(&uuid_mutex);
+
 	if (path)
 		ret = -ENOENT;
 
@@ -988,11 +990,12 @@ static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
 	struct btrfs_device *orig_dev;
 	int ret = 0;
 
+	lockdep_assert_held(&uuid_mutex);
+
 	fs_devices = alloc_fs_devices(orig->fsid, NULL);
 	if (IS_ERR(fs_devices))
 		return fs_devices;
 
-	mutex_lock(&orig->device_list_mutex);
 	fs_devices->total_devices = orig->total_devices;
 
 	list_for_each_entry(orig_dev, &orig->devices, dev_list) {
@@ -1024,10 +1027,8 @@ static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
 		device->fs_devices = fs_devices;
 		fs_devices->num_devices++;
 	}
-	mutex_unlock(&orig->device_list_mutex);
 	return fs_devices;
 error:
-	mutex_unlock(&orig->device_list_mutex);
 	free_fs_devices(fs_devices);
 	return ERR_PTR(ret);
 }
-- 
2.31.1

