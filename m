Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A158233858E
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 06:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhCLFxE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 00:53:04 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:58804 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhCLFwu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 00:52:50 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12C5nif6119227;
        Fri, 12 Mar 2021 05:52:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=nqNRUTKEYIJsyAqBKuHNrQFTXqBsFs0Uk4IhRQ4WSPU=;
 b=uvbFtfIuJc8WtB3WPNhko3TX1cNGWQ1vtVcDrAUMsECa28hc+JLnFbJOeffc898c0zlf
 xWQT4JeNc5RhI68QLgIsTXiCi4g+de/HkcyLPGYZC/htrNjIxgLaGrwAWPgFhrVpPSD4
 gcb9htCgrxz7nfdOLmqFkOoBjwY5DXfQNBoAIZmRAXBka/zy7trUfopothS2Ax8wQ8ir
 7Ot1PxGlfeP+5X/9LnPH5ZuI/rk8wE03VN4SJurHxWmCGIDt7RXr3p0vsFFyDfM35m0G
 jaM0FiGgEvsIdIXRC6eBRbMtzqp235EuL5V4zhT+tQfJBBuSwwj5WRV4W0E0MGDMq0O1 vg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 3742cnguq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 05:52:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12C5pdAA077850;
        Fri, 12 Mar 2021 05:52:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by aserp3020.oracle.com with ESMTP id 374kn3kskh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 05:52:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUvcflt43iHUDNKkYgpMNFWAHFDwj/7mLH0nWcz3vWQyzxD480NqgV5aSZBj1BfNq+UVUIHJcJ7JULedyvtP6dpK3qk/23/7zbz8LQIXr336S7XHqxjZJsyANiAUneZbF4nlfj++wH//ApvES4nA/qmxnX6/5JyWMs8F4vpUu0APCvmIeDaXmQTROImfuhqIpgb6rji0rXM0SN4UIxXGvx9QMuBTIp/qP+uD+no9cWjkPbnk+MvDtSvaceEI0CCpZeB3ol+RBUZod1+9PFUIxzNaLlF8Ly8R+hJABwXrkg4b+ivzVsXYM5VFDP1ILy63ecUdMztSaiN3K9yV+lUypA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqNRUTKEYIJsyAqBKuHNrQFTXqBsFs0Uk4IhRQ4WSPU=;
 b=YzK0WN0TQLenAtEs8QsttxCvkkz8a3/TYhjPmkCIDWqeNyr8Mde6M/o+VzP8KGRMQyPKUYlr5ArlWBvxk6OFZP95alRZPewZf7rd+E/qVShVohjYIGL6yzNPdHuYliqYPpooqdp7gmsqnLNi9Yq+UY9kFyT4lIUZjgOFhA3h7/AD++UTdmqEUhj5YWXxY7dOGM+AcdoqHHpXJsvzQiVBSTWQRWDMOnmDRJkOF3dsWIB3paTeomqP0tgCm1mhZjYRIU1rBIaZf8eItLtY0la71RbCpbjCI845cPETQoWcPLTbLYf8/aM/W8idgEYJHfl5DWlPfPGu9zF0MN5XiPDUvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqNRUTKEYIJsyAqBKuHNrQFTXqBsFs0Uk4IhRQ4WSPU=;
 b=WNKJl63WX+zLpkB/Ya9qZHM5MlvS2imtKjwVnM+TQGuB/gOGYTb3XkezYmJfLaN0ZmH2HFnopbscjoUNjgooIJqNre9ZoRo+y1e2amAXtlGI9/R5Uwdy6YwFszd5eb600kriqzE6zhw7jxJUq9g/KoDuM9uM6aQ0pe1ho9SZ9Kc=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4046.namprd10.prod.outlook.com (2603:10b6:208:1b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 12 Mar
 2021 05:52:44 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125%8]) with mapi id 15.20.3912.030; Fri, 12 Mar 2021
 05:52:44 +0000
Subject: Re: [PATCH 1/3] btrfs: init devices always
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Cc:     Neal Gompa <ngompa13@gmail.com>
References: <cover.1615479658.git.josef@toxicpanda.com>
 <e5abaf864da01a3ee1cb8ef341ef1024c9e886f6.1615479658.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <73ec19a3-5be5-fdd1-fce3-dfdce7318adf@oracle.com>
Date:   Fri, 12 Mar 2021 13:52:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
In-Reply-To: <e5abaf864da01a3ee1cb8ef341ef1024c9e886f6.1615479658.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR06CA0197.apcprd06.prod.outlook.com (2603:1096:4:1::29)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2PR06CA0197.apcprd06.prod.outlook.com (2603:1096:4:1::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 12 Mar 2021 05:52:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94d69889-ee82-4f87-8d86-08d8e51b0e55
X-MS-TrafficTypeDiagnostic: MN2PR10MB4046:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4046C8029913E8CC85DE6864E56F9@MN2PR10MB4046.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I+f3ALMMH58mRE58sAI3/aNxuTVvpcEG6Lto1nSwYfUbJTuzKdZ7/NQLhKdZOGAJDzb1Zo6y77/k0/XFr7ypoibrzCKamAFENA0POmj4jTm8H0K2/eVUKc3FNDWwRAjQwE+qKNbFhALsEECtkA6wySFP+KHlQR+AtxwlpuOvtzs9mmbFfBgxBEmvU2toM/CJJ/tO46d8yqxk/Onz3NeTR2LlBegAcH20LbsESpUaV03Ymim0rMhhVSweLZDeVCOkXNeXBys11EJwRgXmOIeE9eyVkREJdEQWswXpjl67lb810KVYbEcctUge7+wEdnyvnrW22flcBATCCR2nt24no2/DGH9fB5F9hkaoGr3MpNCcn2pD/m1Bmb63Uor3lYHxv6a8RYgwKBEqJrBoLO+XvP46SL9v3voDzCrJZ83O9v6tNaco2YiX+ApcZg4xzkkPoenAKcoPh3tJSJA2SPKxDeEGLnIycS5L59B2f3GZZHnLAAUbeiTkKa6FTyt8MeFsotw8jBUnihcxASG9Bfcb7Vra8pYuNjo/LxwwhwOJ7sphagoPVKz417Rz0U2J5rhu7Fg/UU1hcySJchFL8k/aBXOcl9q8lQpoghp0EjGnfPfar3u1mY7XfhFqZqZ4ufIhk/wZxZO1JrewValOAe01Tg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(136003)(366004)(396003)(376002)(66946007)(53546011)(4326008)(5660300002)(16576012)(6486002)(186003)(478600001)(316002)(16526019)(2906002)(31696002)(36756003)(86362001)(66476007)(8676002)(66556008)(8936002)(6666004)(26005)(2616005)(956004)(31686004)(83380400001)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Z21YY1FUSDlmSVZOUE81Z2krUzcyYjJqUEtPb0tGNWRMeGVFazQ0a00rTTUx?=
 =?utf-8?B?a0xxRzBEMldzV2xDZGxQWDJMTHFHT1BsNUttWVIzcnlMVTc0bnQ0ak5Ic2t6?=
 =?utf-8?B?dHViNGlBYkZBdVNIV3NPQzlIT1BpZUl3UFMzckRrZUZ0WUhlQkpGb1JPWFNx?=
 =?utf-8?B?clNUc3JCalFhb0lzV2xTbldhbHdWR2tzdXF3b2IyclJ6NVloNmJ3Z1g0ejBl?=
 =?utf-8?B?UnJQV20rbUtzQ3ZBMm8xRFQwTE9zMkhUcmtqanQ5MFJWYUd6TmdLT1M0Qmp1?=
 =?utf-8?B?QUJrd014UFN4YVpwY2p2MC9sYnZXRGQvREROYjNZNjE5bEpVcTJyVU0yYnpr?=
 =?utf-8?B?QmU1TEFDVzErNnlRZU43cFlQSDVKTUhEdGdBcDhwWHFIUjRUYnllbDhtcFd1?=
 =?utf-8?B?d3IzSmdLTmxJQ0t0ZXVqWWxDb2N3VzFGSHJSTjcvbmlVdWlrSWpxK3A3SXp0?=
 =?utf-8?B?NU9NOGs0NXo1MXIwQmFaRGNDV0M5QkxzajR4OGxMdWdSV2R2YmNwYWhuVDEx?=
 =?utf-8?B?dVBJWElHTG1IRDB2dmRpMWRNblNrdjNrUnYxUk9pRldPVGQwOXNqb0Vqa0NM?=
 =?utf-8?B?NkwySTZTOG0vZ0dBU2pkWDRkMWxBdDNJdFJKZzVJTXd0REx1Ni83NjU5SCtN?=
 =?utf-8?B?MjBjM2d4cWZtdzg4ZE5sckJpZGVRMERiUWNnMTRUdVVUaHl4bjlZN0NwL3VZ?=
 =?utf-8?B?SjkvR290TFNhMkpVRFVuTE9mbVFqY0RpbEV4d3hyditaQStBV1dSYTM3Sk5G?=
 =?utf-8?B?Sndhb0duYVdlREc2ZTE3Z0FQb2YvZjZ5Y1lDRmN3eVdYZC9HWWJoQkphVDNI?=
 =?utf-8?B?cVViM2pKK3picnBkbGF4bzRLSmd4SHdsY0FRdXJMbk01NTlmSE5WNDhsODlz?=
 =?utf-8?B?MTlzN2s3akRkSC9TU0oxRmtMeXlnM0lLR2VYY2RWbG5yNDZBbXB4TjUwMHB3?=
 =?utf-8?B?VHhJb0RlS3BEWUcrWVJzd3BMR3lMRVlaMmlOSFpnRFl6Tnl6b1FkUFhhVkdq?=
 =?utf-8?B?RGlkRFRabTEwZGZRNUluS01ZTkpDTWtNcmF6bit5OWVWY1Y1RjFCYktWQS9o?=
 =?utf-8?B?UjB6UHJjWUZQWkIzOGFNRnVrZWlPTkZab3k3bmk0QlhzTnhneVZVcFZZcVhE?=
 =?utf-8?B?bHNPOXVjbTJPNDlWZVFRYlVBT3N5NTdVRlU5ZzR2SGRpdzNJRW9WbmVPRVk5?=
 =?utf-8?B?V2x3SHRuQVk3N3NWRUV0V2FpQWg3WE5UK2RlcThSbnc0S1pMUnZMVi9VUkMx?=
 =?utf-8?B?THZPTGYrUWpjNTF0NWZYbWVPMkFqN0JVMnZCankvKy9aTzVlL3BJK3R3RjZw?=
 =?utf-8?B?UitZZ3EvcWNrUVBxVzJpcjY2YzhKblZ1MTFCVExKZDVlTGM5aVdEcStjcVFp?=
 =?utf-8?B?bk9zcTY0b2haamJlbUtHMkpYeUJiZWxwL1RiaVMxNmVwNWpNNFVVWkltV2VZ?=
 =?utf-8?B?M2FnTVNCVHllS1ROekRwcEtSdXgwa3hncENKUGhMOGxoV0hsQmoxM2ovazFG?=
 =?utf-8?B?M1Bxd05vTHBWUzhVMlMrWnBrYTdyZmliNzZnOGsvekVpNTlYK1lmSlhqYy9n?=
 =?utf-8?B?Rmlhc1d0Q1hRckJkQTNuTFQwSzBncVRzeEdVOE9RRWhzTVcySSt6YjJMREtV?=
 =?utf-8?B?c0YwLy9oYWZNZjNiK0pVUXJncW5neStZMVFEeU52V0tNZlQvN0NFWFZqK28y?=
 =?utf-8?B?TUl0TE1xVmhkK1VJYkx0QUZyR09yUHlWaVZycnNaa0lTa2VVdXlxVWJxQ2lk?=
 =?utf-8?Q?+H/hcrja7K2VaxJZbeUWSn0WnCtbvFt98Q6XT8F?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d69889-ee82-4f87-8d86-08d8e51b0e55
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 05:52:44.3660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MmZrqpTPgJDMrzvsRXNpXy2XozKPKKDDL1kNI/coBu1FQ7qc3M2uvEmYZAronrnNHKHZLMu1bQG24N1nE+mrdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4046
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9920 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103120040
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9920 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 clxscore=1011 phishscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103120040
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/3/21 12:23 am, Josef Bacik wrote:
> Neal reported a panic trying to use -o rescue=all
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000030
> PGD 0 P4D 0
> Oops: 0000 [#1] SMP NOPTI
> CPU: 0 PID: 696 Comm: mount Tainted: G        W         5.12.0-rc2+ #296
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
> RIP: 0010:btrfs_device_init_dev_stats+0x1d/0x200
> RSP: 0018:ffffafaec1483bb8 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: ffff9a5715bcb298 RCX: 0000000000000070
> RDX: ffff9a5703248000 RSI: ffff9a57052ea150 RDI: ffff9a5715bca400
> RBP: ffff9a57052ea150 R08: 0000000000000070 R09: ffff9a57052ea150
> R10: 000130faf0741c10 R11: 0000000000000000 R12: ffff9a5703700000
> R13: 0000000000000000 R14: ffff9a5715bcb278 R15: ffff9a57052ea150
> FS:  00007f600d122c40(0000) GS:ffff9a577bc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000030 CR3: 0000000112a46005 CR4: 0000000000370ef0
> Call Trace:
>   ? btrfs_init_dev_stats+0x1f/0xf0
>   ? kmem_cache_alloc+0xef/0x1f0
>   btrfs_init_dev_stats+0x5f/0xf0
>   open_ctree+0x10cb/0x1720
>   btrfs_mount_root.cold+0x12/0xea
>   legacy_get_tree+0x27/0x40
>   vfs_get_tree+0x25/0xb0
>   vfs_kern_mount.part.0+0x71/0xb0
>   btrfs_mount+0x10d/0x380
>   legacy_get_tree+0x27/0x40
>   vfs_get_tree+0x25/0xb0
>   path_mount+0x433/0xa00
>   __x64_sys_mount+0xe3/0x120
>   do_syscall_64+0x33/0x40
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> This happens because when we call btrfs_init_dev_stats we do
> device->fs_info->dev_root.  However device->fs_info isn't init'ed
> because we were only calling btrfs_init_devices_late() if we properly
> read the device root.  


> However we don't actually need the device root to
> init the devices, this function simply assigns the devices their
> ->fs_info pointer properly, so this needs to be done unconditionally
> always so that we can properly deref device->fs_info in rescue cases.
  btrfs_device_init_dev_stats() calls btrfs_search_slot() leading
  to btrfs_search_slot_get_root(), and does de-reference root (dev_root)
  to get fs_info.

-------------
  static int btrfs_device_init_dev_stats(struct btrfs_device *device,
                                        struct btrfs_path *path)
::
         ret = btrfs_search_slot(NULL, device->fs_info->dev_root, &key, 
path, 0, 0);


int btrfs_search_slot(struct btrfs_trans_handle *trans, struct 
btrfs_root *root, ...)
::
         b = btrfs_search_slot_get_root(root, p, write_lock_level);


static struct extent_buffer *btrfs_search_slot_get_root(struct 
btrfs_root *root, ...)
{
         struct btrfs_fs_info *fs_info = root->fs_info;
--------------

  Can we allocate a dummy dev_root and set its dev_root::fs_info?

Thanks, Anand


> Reported-by: Neal Gompa <ngompa13@gmail.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/disk-io.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 41b718cfea40..63656bf23ff2 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2387,8 +2387,8 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
>   	} else {
>   		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
>   		fs_info->dev_root = root;
> -		btrfs_init_devices_late(fs_info);
>   	}
> +	btrfs_init_devices_late(fs_info);
>   
>   	/* If IGNOREDATACSUMS is set don't bother reading the csum root. */
>   	if (!btrfs_test_opt(fs_info, IGNOREDATACSUMS)) {
> 

