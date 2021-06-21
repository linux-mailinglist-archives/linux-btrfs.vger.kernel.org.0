Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8547D3AECD3
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jun 2021 17:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhFUPzF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Jun 2021 11:55:05 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:41566 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230057AbhFUPzE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Jun 2021 11:55:04 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15LFq5o3007336;
        Mon, 21 Jun 2021 15:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=9jw9VG8YSETR6kuZSX/7hqrmOvW46p0Feei2AelHL10=;
 b=sgkiDpkPE0TxkfvNdNuRGK9OOLQEJHYgKE0vj6BFLH8LSWHyFao1IhAr4sfnYG+oRbTn
 byfXKOxCX/Oq2VxSby/XsYbCaiGarvrPAfV4fgcNbiDc97cmKddcAbfb+cgriK1cxMhm
 9VfPVvUM50HRHKa5y5Xdf1I9y5z9amC8bVjr3IaTmOdXyCd1XudQCtusCoO1V7/Nl+57
 riiiYGunCYCD0yU2YuMxbIzs95qNEDAvd1taDWUku06mD+BsAhsPkcg0Df7QJXQi8eIE
 Hgc9PzAsyCzjPx5RhfUdScxHP7l8u1mZmm9qxzFDIOV8JPsgAW8rcHKuQRpmYcGPRIdK YQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39a68y20xc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 15:52:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15LFpAM5142813;
        Mon, 21 Jun 2021 15:52:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by userp3030.oracle.com with ESMTP id 3995pusfm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 15:52:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWs5A3SQqrBoXOW04calPHsTzAv4iPVWYoEiieuRUZ3fe31xR4N5vF3asaF1mPSu+CWLeul4F/H7AzDvZuvLqS5DO45zKdYiuU8WT9UDeR6J1ZDOT0vSFbsci430VdihpqvifzebkEBgptXm4ugPg4JHi7+z3BfMYkf/Xf7xoe31fQWUzq1miGr+BOIWCapjZ07Qi+v+jq4CKQzDjByVzPr52W6K6TIAG/br6V7qAY2PK8w5DITuZx1WGVFFCbNUfTGAutCtpsSS6Fj8GezgvyNGuHMhzs1d/EIMqfVv06T4EaoAJ0khjygj5WVXehdh4WZ/CbjTryTVtJpE64chPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jw9VG8YSETR6kuZSX/7hqrmOvW46p0Feei2AelHL10=;
 b=a/Sfm21N5hQop56X89Ev/Eye8pCAdoy2+w3NoDJ09Y5AAVeKWiPbVUl0YOl9c9ZdT7dkjrHuqsvEXw1UnHVjvghs8Ju1vDunB9Tpg0umVZ0rkHeMq6daHMhLdjmjmu/rKHX0O8+ie2Vsj9EvZmrYyGgjLywD6034lS3F33EIC+ywxMU6mBPUss6P/nh+qJwfJIO/tUYnq2o5IAeSmJ1LwTvCdOl6Ht9T48CcyIjBpQ8H1YAOa4DksOB93YpKU8Xrcv5vzdnP66OfDmqKhFJM/J2Eh3unewOCXyBXdlc+YAN01QJmpslROv4Y7dvmgYLi4cqrz65aYAtwUtMDytChYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jw9VG8YSETR6kuZSX/7hqrmOvW46p0Feei2AelHL10=;
 b=qY0HIPiEb9W/B1FlpM+pud1hkTytgHn9bPYgRGWFJ1HsE37VH+yezEj0I4iC14nG0j38cg3DQb99ewKc467xqLPXc2+Y/mKfxSQgt22Uv2wyH0wWRKvzom5RagsOF5Ey5UiDM0jrRCxt18nYSfO3bB9CNT7ss+DoPkjzOoU+WjI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4834.namprd10.prod.outlook.com (2603:10b6:208:307::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Mon, 21 Jun
 2021 15:52:39 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8%8]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 15:52:39 +0000
Subject: Re: [PATCH v2] btrfs: fix lockdep warning while mounting sprout fs
To:     dsterba@suse.com
Cc:     Su Yue <l@damenly.su>, linux-btrfs@vger.kernel.org
References: <23a8830f3be500995e74b45f18862e67c0634c3d.1614793362.git.anand.jain@oracle.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <08c3bd5b-b0ec-9a85-6e54-9b79c78282d4@oracle.com>
Date:   Mon, 21 Jun 2021 23:52:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <23a8830f3be500995e74b45f18862e67c0634c3d.1614793362.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR04CA0128.apcprd04.prod.outlook.com
 (2603:1096:3:16::12) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR04CA0128.apcprd04.prod.outlook.com (2603:1096:3:16::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 15:52:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da1c5293-b45d-407a-203a-08d934cc98a2
X-MS-TrafficTypeDiagnostic: BLAPR10MB4834:
X-Microsoft-Antispam-PRVS: <BLAPR10MB48349044BE2AFECAD8CFCBACE50A9@BLAPR10MB4834.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:494;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mNtWggQm0sh30KVtK/rCau7Ox2J3Fotut11r2fuK8NTNkwUxwhggKYaGzmKYLRkJxGwvMQ3Gi5ML+/iJK8wGezbkNbm9/oZycpN2ru0xfum/wtibtMxO44Dqru06BxS3XDL70FT9K3mIOpZGCIb6V6+yyNsdlJ+d4PiVko/CEwZC1EVxIY7gX3Lg7pOnDqhabd+aC3fx1/t7RsHnumYDSU3lJMGAaWVs8XrBMnmn9XPWQ886++xvw6LhS4COgz6KyPkuMLdebDdlSfV0ikD/EuETlTv17vFmJ8n6f5ImoNxbEhA0Mt8LMIYuyC+hbfbXoPng1fvar0SMTqoOUjbYjUtAzAphb0r32KIj9PH+/l0nnb7WxMNtpXXeNyq8clTqF/ujokRLraowxyAbizKvB7/RGPPUpAXzw1lzISvrHLnUl8fp+xiV8GJeM8LsvljWMEK+k2ERop1hYZ90MqjaI6zEEfvQdadvFZx/FxYh9+LXRIzdWKTapCh1thvJFRqm+z+IbB+8GqpxtYS926BaV54jCeVrzjvySLkg7Q2TCcRwXnRkXuLw8MlXeQQoVYB8khwlTuNk2Y2OW0qbM3iFUZEcAGPXtZcErGYhKMn4TnJywIN5hfF+7iJU0vWJqwkbp+EiooNl/ACXAy7PN17iVH6wiScU+xmDrD0BDfXv50ZY3E+9KBtY7Xz5Kd2IjSsG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(376002)(136003)(366004)(396003)(6916009)(4326008)(44832011)(8936002)(86362001)(2906002)(16526019)(478600001)(66476007)(6666004)(316002)(956004)(2616005)(53546011)(16576012)(36756003)(66556008)(83380400001)(26005)(186003)(6486002)(5660300002)(31696002)(66946007)(8676002)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3VYSktkWE04am8xNzJtem43endoYndrS3gvemhYWVNpR2s0b3U3bHp5dUw5?=
 =?utf-8?B?aThHSDc5T0RuV21YaVNTNmFIc2tKYnJnVFF2TmhzWDdYTUFaSFZ0VHlXdXNI?=
 =?utf-8?B?VzNmUUwrRzVmVjl6ZjJCZkNlVGtpOFNEbzRkd1BnRVdqaWc4VHVwYTlLalcr?=
 =?utf-8?B?Uml3RGFQUlJFK1FCaDROTGZpMzJVMC9GVDIweTJxTnl3bTd0SzY4MjAvUFNC?=
 =?utf-8?B?YXNROUhSRGRWRU40djJiRXdqTDhsQ0NFWFJTeVJudmExWkpnY2pTU0MrTHNo?=
 =?utf-8?B?Nm1zb0ljWFRONVhuNHZkcUozT3c2VEdyNEQ5NHFaMWMwUTUxV3c1OWhnanlR?=
 =?utf-8?B?S2Urb0huaHI3VmhORUpJZi9IMXFNSzBJQ2pxR3I3S2ZNUnN1TFhlcjYwSHYw?=
 =?utf-8?B?M1V3cm9UYkFNS2tqeERLQUpzSXZYZzl0ckpsR0VPeDVEM1JwMHB0QzVETFNl?=
 =?utf-8?B?bjc2V3hYZW9wdDdqRGZyRnNrbkI5cDNFU0NTOWFtMG5wVng3RUhnbU1Sb1Q1?=
 =?utf-8?B?elFhTzM2TTZMVXl0K1l2RlVnVk1IS1BHYnorcnBGUXdjWUlqYzNKSGtwZ2dn?=
 =?utf-8?B?WVNXdzNwWW1FZUR5d2t4WUpoaDg5M1hHcG5BQ2NmZ3JseVI0cTVZVVlTcExt?=
 =?utf-8?B?elduWGhNRERucVRPWTBWSWx4ZzJBNlJEdUttbFZYM21ha2VJTVpsTmpiYVVh?=
 =?utf-8?B?SEJKMWJFc1UxdGkrNXBKbUtra3VKRVF2WDBIR1hYVzVpemptQWcyRS84Zndh?=
 =?utf-8?B?anNwbnk2K1p1ekV1QWNWNHRzcHJka25GUFF3c0pWOXpvajNNY0Z5alRxVGpS?=
 =?utf-8?B?S21Fd0JOTFBSS3dJdTV3U1VMKzZiWEdneTVSM1Z3OHhNa2VnZEp4b202MVZW?=
 =?utf-8?B?YUdaYmpDNXlQWWtDZGhKeUdQQnc2V29kVnNVTG1FNE5Zc0ZHWUNRaGF5ZDlS?=
 =?utf-8?B?UzNzd0lBanM3K0w5MW5oOEJ2T3BReXlZdmJEZ21UR0RCTHRPZ20wVVhsWitS?=
 =?utf-8?B?RmN3TVZwai96a2xyNFlyMlI3UWdHRW50WFB4OEdUY2hSTFlRSnkxQUxiYzJ2?=
 =?utf-8?B?bllWQkpyUXh5V214SFFSejNZZmhyZzFibVZpU0JGbHU3aHM2alBUakhSNnVw?=
 =?utf-8?B?c0psbVRSOEpJU3p1bitsejRMeVJ1ZFdITmw2NGh6K2dBTDE5bUhveTd0WHha?=
 =?utf-8?B?aGVPZDVnTVZpdTAwNmdZT3piVy85VmlaZFB4emY4M1dBcUhLdmVNNVZ0WVNW?=
 =?utf-8?B?ZmlwczFDWGx2WEhNTTZTMnYrQVNLblZISmlrandLbkhNYWxYaHFTdU1wbGxI?=
 =?utf-8?B?VlVpRmVzUnpmWjBFNjZnd21RWmx3QjFtTC9wREtxeG1OeW5SL1dDSjZEV09l?=
 =?utf-8?B?UjVqVzB0TzBxQjRyWW00bHg5U05PSU9GelMySDdwMDZNampEMEpKMFVsSDdB?=
 =?utf-8?B?NFhrK01wWUc5OWROckY2NWc1V0lMemVUSGlabDZod1FmSlRzTWZiOE5RNDl2?=
 =?utf-8?B?VklxbkdQUENaZjc4ZEtCdmVWUTdTSGtTWnk2ZTFSZkZvQnBqVE45M2ovU0U3?=
 =?utf-8?B?T29mVE5Uaml5YlBORFpwT0M1RGlmaUtFa1EzN04vNS90NS82THZ5OC9tTHdM?=
 =?utf-8?B?SlZ3UUdUSHlMajcyTWdJSVBaZG5HY2RlUkFmRHJ2SnFJcEJHUkFOLzJBL3Rk?=
 =?utf-8?B?MlJSOXZ2UnV0N0N4SjRKZjQvWXl5NG4rMzQ0dmtwUEV2QkJqd0ZINXpJbGZB?=
 =?utf-8?Q?bVOZgndxKiLsryWsbw6hEQsCcO7XLPCrnqq/sZ4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da1c5293-b45d-407a-203a-08d934cc98a2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 15:52:38.9445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HjzjUg+9Mxoiuj6w0Ob/tFg4zHMDV4jvp96+tM90hUKA5BfnryMs64wJoZvALN9zy1oc6qyjKiNRTlQjUgjmaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4834
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10022 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106210094
X-Proofpoint-ORIG-GUID: a3F1mmqdcjxeLArQzZSMZbRpbAe1wuSd
X-Proofpoint-GUID: a3F1mmqdcjxeLArQzZSMZbRpbAe1wuSd
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

David,

Ping. I can reproduce this on 5.13.0-rc6+. The patch still applies 
conflict-free on the current misc-next as of now.

Thanks, Anand

On 04/03/2021 02:10, Anand Jain wrote:
> Following test case reproduces lockdep warning.
> 
> Test case:
> DEV1=/dev/vdb
> DEV2=/dev/vdc
> umount /btrfs
> run mkfs.btrfs -f $DEV1
> run btrfstune -S 1 $DEV1
> run mount $DEV1 /btrfs
> run btrfs device add $DEV2 /btrfs -f
> run umount /btrfs
> run mount $DEV2 /btrfs
> run umount /btrfs
> 
> The warning claims a possible ABBA deadlock between the threads initiated by
> [#1] btrfs device add and [#0] the mount.
> 
> ======================================================
> [ 540.743122] WARNING: possible circular locking dependency detected
> [ 540.743129] 5.11.0-rc7+ #5 Not tainted
> [ 540.743135] ------------------------------------------------------
> [ 540.743142] mount/2515 is trying to acquire lock:
> [ 540.743149] ffffa0c5544c2ce0 (&fs_devs->device_list_mutex){+.+.}-{4:4}, at: clone_fs_devices+0x6d/0x210 [btrfs]
> [ 540.743458] but task is already holding lock:
> [ 540.743461] ffffa0c54a7932b8 (btrfs-chunk-00){++++}-{4:4}, at: __btrfs_tree_read_lock+0x32/0x200 [btrfs]
> [ 540.743541] which lock already depends on the new lock.
> [ 540.743543] the existing dependency chain (in reverse order) is:
> 
> [ 540.743546] -> #1 (btrfs-chunk-00){++++}-{4:4}:
> [ 540.743566] down_read_nested+0x48/0x2b0
> [ 540.743585] __btrfs_tree_read_lock+0x32/0x200 [btrfs]
> [ 540.743650] btrfs_read_lock_root_node+0x70/0x200 [btrfs]
> [ 540.743733] btrfs_search_slot+0x6c6/0xe00 [btrfs]
> [ 540.743785] btrfs_update_device+0x83/0x260 [btrfs]
> [ 540.743849] btrfs_finish_chunk_alloc+0x13f/0x660 [btrfs] <--- device_list_mutex
> [ 540.743911] btrfs_create_pending_block_groups+0x18d/0x3f0 [btrfs]
> [ 540.743982] btrfs_commit_transaction+0x86/0x1260 [btrfs]
> [ 540.744037] btrfs_init_new_device+0x1600/0x1dd0 [btrfs]
> [ 540.744101] btrfs_ioctl+0x1c77/0x24c0 [btrfs]
> [ 540.744166] __x64_sys_ioctl+0xe4/0x140
> [ 540.744170] do_syscall_64+0x4b/0x80
> [ 540.744174] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> [ 540.744180] -> #0 (&fs_devs->device_list_mutex){+.+.}-{4:4}:
> [ 540.744184] __lock_acquire+0x155f/0x2360
> [ 540.744188] lock_acquire+0x10b/0x5c0
> [ 540.744190] __mutex_lock+0xb1/0xf80
> [ 540.744193] mutex_lock_nested+0x27/0x30
> [ 540.744196] clone_fs_devices+0x6d/0x210 [btrfs]
> [ 540.744270] btrfs_read_chunk_tree+0x3c7/0xbb0 [btrfs]
> [ 540.744336] open_ctree+0xf6e/0x2074 [btrfs]
> [ 540.744406] btrfs_mount_root.cold.72+0x16/0x127 [btrfs]
> [ 540.744472] legacy_get_tree+0x38/0x90
> [ 540.744475] vfs_get_tree+0x30/0x140
> [ 540.744478] fc_mount+0x16/0x60
> [ 540.744482] vfs_kern_mount+0x91/0x100
> [ 540.744484] btrfs_mount+0x1e6/0x670 [btrfs]
> [ 540.744536] legacy_get_tree+0x38/0x90
> [ 540.744537] vfs_get_tree+0x30/0x140
> [ 540.744539] path_mount+0x8d8/0x1070
> [ 540.744541] do_mount+0x8d/0xc0
> [ 540.744543] __x64_sys_mount+0x125/0x160
> [ 540.744545] do_syscall_64+0x4b/0x80
> [ 540.744547] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> [ 540.744551] other info that might help us debug this:
> [ 540.744552] Possible unsafe locking scenario:
> 
> [ 540.744553] CPU0 				CPU1
> [ 540.744554] ---- 				----
> [ 540.744555] lock(btrfs-chunk-00);
> [ 540.744557] 					lock(&fs_devs->device_list_mutex);
> [ 540.744560] 					lock(btrfs-chunk-00);
> [ 540.744562] lock(&fs_devs->device_list_mutex);
> [ 540.744564]
>   *** DEADLOCK ***
> 
> [ 540.744565] 3 locks held by mount/2515:
> [ 540.744567] #0: ffffa0c56bf7a0e0 (&type->s_umount_key#42/1){+.+.}-{4:4}, at: alloc_super.isra.16+0xdf/0x450
> [ 540.744574] #1: ffffffffc05a9628 (uuid_mutex){+.+.}-{4:4}, at: btrfs_read_chunk_tree+0x63/0xbb0 [btrfs]
> [ 540.744640] #2: ffffa0c54a7932b8 (btrfs-chunk-00){++++}-{4:4}, at: __btrfs_tree_read_lock+0x32/0x200 [btrfs]
> [ 540.744708]
>   stack backtrace:
> [ 540.744712] CPU: 2 PID: 2515 Comm: mount Not tainted 5.11.0-rc7+ #5
> 
> 
> But the device_list_mutex in clone_fs_devices() is redundant, as explained
> below.
> Two threads [1]  and [2] (below) could lead to clone_fs_device().
> 
> [1]
> open_ctree <== mount sprout fs
>   btrfs_read_chunk_tree()
>    mutex_lock(&uuid_mutex) <== global lock
>    read_one_dev()
>     open_seed_devices()
>      clone_fs_devices() <== seed fs_devices
>       mutex_lock(&orig->device_list_mutex) <== seed fs_devices
> 
> [2]
> btrfs_init_new_device() <== sprouting
>   mutex_lock(&uuid_mutex); <== global lock
>   btrfs_prepare_sprout()
>     lockdep_assert_held(&uuid_mutex)
>     clone_fs_devices(seed_fs_device) <== seed fs_devices
> 
> Both of these threads hold uuid_mutex which is sufficient to protect
> getting the seed device(s) freed while we are trying to clone it for
> sprouting [2] or mounting a sprout [1] (as above). A mounted seed
> device can not free/write/replace because it is read-only. An unmounted
> seed device can free by btrfs_free_stale_devices(), but it needs uuid_mutex.
> So this patch removes the unnecessary device_list_mutex in clone_fs_devices().
> And adds a lockdep_assert_held(&uuid_mutex) in clone_fs_devices().
> 
> Reported-by: Su Yue <l@damenly.su>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2: Remove Martin's Reported-by and Tested-by.
>      Add Su's Reported-by.
>      Add lockdep_assert_held check.
>      Update the changelog, make it relevant to the current misc-next
> 
>   fs/btrfs/volumes.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index bc3b33efddc5..4188edbad2ef 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -570,6 +570,8 @@ static int btrfs_free_stale_devices(const char *path,
>   	struct btrfs_device *device, *tmp_device;
>   	int ret = 0;
>   
> +	lockdep_assert_held(&uuid_mutex);
> +
>   	if (path)
>   		ret = -ENOENT;
>   
> @@ -1000,11 +1002,12 @@ static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
>   	struct btrfs_device *orig_dev;
>   	int ret = 0;
>   
> +	lockdep_assert_held(&uuid_mutex);
> +
>   	fs_devices = alloc_fs_devices(orig->fsid, NULL);
>   	if (IS_ERR(fs_devices))
>   		return fs_devices;
>   
> -	mutex_lock(&orig->device_list_mutex);
>   	fs_devices->total_devices = orig->total_devices;
>   
>   	list_for_each_entry(orig_dev, &orig->devices, dev_list) {
> @@ -1036,10 +1039,8 @@ static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
>   		device->fs_devices = fs_devices;
>   		fs_devices->num_devices++;
>   	}
> -	mutex_unlock(&orig->device_list_mutex);
>   	return fs_devices;
>   error:
> -	mutex_unlock(&orig->device_list_mutex);
>   	free_fs_devices(fs_devices);
>   	return ERR_PTR(ret);
>   }
> 

