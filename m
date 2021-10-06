Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB25423A10
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Oct 2021 10:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237757AbhJFI4w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Oct 2021 04:56:52 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:26946 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237676AbhJFI4v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 6 Oct 2021 04:56:51 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19686k8d029511;
        Wed, 6 Oct 2021 08:54:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=o7JLUCQg9RWt79j+MKfcVxqNv+C+wjDJ1tM00+W8Wqs=;
 b=UX7pur1b/Sozndd+860A/XQHkNeOnlkwRCxlCSI4YUMPQ2k76o8BPK9NJs19TTiV/mYs
 w3eufednp+mPZIpcqts0OIFyXaod/x51dveHfb1E9Bmo4PKyc4cAqTXlCohfo7g66DzY
 77OUH5txtNe49tQOY8wJ/OVRQqgtrTIJYVoWZlvb4wkfrs6MQjqU6SCton9Iyicy6ku0
 hFcuVcofIW6KOc2CJ0qLye/bs590QY5/wxHQbRWk/raEKdc0j+f1wbS9sV+ciu8syTfv
 IPJTqiwmxhNMVR4kMal6Vi90HEg+ek4p7Ve/OfGvVtSca0WzyKeZBoomis2HWTHeN9YE 8w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bh1drt4j8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Oct 2021 08:54:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1968o00t119611;
        Wed, 6 Oct 2021 08:54:56 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by aserp3030.oracle.com with ESMTP id 3bev7uhq0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Oct 2021 08:54:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e84p15JX0tgYq9VSynUb9v8FZwW9FvkHNxx4KrhcLbEjlcYL2o2gSSfb2H1CbN/njJ078np688GxO9MtMTq9TlbTaqbwhCVPDUVPkA4R4XkyhKlV4Mt+C/HC8AtKkNL3EraT8fVxnyRxk6L2bxgKPtnGIwr2a6XobM2TZn1ZoNjUouBC0Y7Flfi0ywx574BzaWyNOub1ERZnm5viDpib2cMJrWbXeCzc4oRRJhvZMME1+NUQid0Z52Vg28pcat7noWPT3Y815wOX6xB3niL0ISFmdCf2b7A4Fc2C7q8WGHsL69QKXXHjqJs4EvTGjqFGN/TcXSSXRkEw2YBVApBWgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7JLUCQg9RWt79j+MKfcVxqNv+C+wjDJ1tM00+W8Wqs=;
 b=T36fB2mFD/Jl5HhUdeaTGMyTd0b0W3QzMt8u7mJAt94QGgiXe5iWjAh8kZQuoXrseuhnCsQRqUKDSzjDb6dhtaij4qx3Un93DzEhockoVhvMNDuq4qFqBGFY2IqUNxKH6gE446za+1plWgRaQD5NO4CY1Yul04RSk57nM2oJVyiF5YI9bKhypX1TZgdu6dhkwK3PfI3ugcZ+noTZRdhEmJT5s0L26jikfKgImoCyf0DlQ6J2mhICKAwLFm9m7jRelTX29vh8vwtBNW+nd3NUbh1p0szqbf93sqopFZPt+9S+mBosjJQPpiwBlyDFwcsF59BEki1ZxJc+3C5a7tLFBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7JLUCQg9RWt79j+MKfcVxqNv+C+wjDJ1tM00+W8Wqs=;
 b=ZtV1FQEbMoanSBC7bGuZrPnWTvixVhOX54a8bXznQXAXpF+pRkUtIlY6bGlwQgCrJh5H7g0mmPQoe1hjk2ZfEoosZHfZptUrl73hws3fFUM7BrTL4bz23iV23RwUAj4gmDMaNhOJMhbRRyrQPGxkjkw6I9J4HFhS080OZ2TejoQ=
Authentication-Results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2913.namprd10.prod.outlook.com (2603:10b6:208:31::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17; Wed, 6 Oct
 2021 08:54:53 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%8]) with mapi id 15.20.4566.022; Wed, 6 Oct 2021
 08:54:53 +0000
Subject: Re: [PATCH v4 6/6] btrfs: use btrfs_get_dev_args_from_path in dev
 removal ioctls
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1633464631.git.josef@toxicpanda.com>
 <78f4669e469232db2d8675fd7b4fd06028f2eef5.1633464631.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <e81e4690-377d-40f1-8488-21530ee6c57d@oracle.com>
Date:   Wed, 6 Oct 2021 16:54:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <78f4669e469232db2d8675fd7b4fd06028f2eef5.1633464631.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0085.apcprd02.prod.outlook.com
 (2603:1096:4:90::25) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG2PR02CA0085.apcprd02.prod.outlook.com (2603:1096:4:90::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.21 via Frontend Transport; Wed, 6 Oct 2021 08:54:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4aa617cb-612c-4506-e2ad-08d988a6f672
X-MS-TrafficTypeDiagnostic: BL0PR10MB2913:
X-Microsoft-Antispam-PRVS: <BL0PR10MB291337753B556E5A5D0E212DE5B09@BL0PR10MB2913.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HZXKbBQIzIvTTf5RFvU85NnJiMrlFnFjs8mH+L2RZuQrdFYuXHVcqQSI0AA0OxJ5pfjXvx98jAtENXQEFmgo3D6UkuC3wtEBanTxkNDxe5V9IO+6vIHzrnUolQJeuj71EYgxTEwatwXFsMB6BBB+DcYpPcMgJVGRQRlhDZBBRZD6rHnzIhuDbILf+B2OlNp+VM11/1llK0XuhaOMqRjsrgI4lUsnrOvWM2ZtC6Dr7EprMwjncWz+o5tzlthfz6zauVmKPeyHSzEVJVX5dY3u+8YAUup9AfLeqFi3evQ62CF5J1CJ7WH4lXy86XWQ5QWggvDliY+Tnz1ONlq8FuSz5YGRTHBeVInmqAqL1LzYP0+kgFkv6j4cnwSwOOAmINtcQOqAWMayvWrY5HBaiZfEtpXlbDVksklJbzf+BTP0NPqoX3vfByNQqW71+xV+ZXXZON8+GwzBdjWLmSr9QuKl3CqkQq/q+pQ6CFvohQaQYsoXyW+ArfPY3MCMYH73vXW24ELq8w5dmNQD9401ABCKo4bhfDjgTIhGgsq0cQPNf0O/t8dkEEZF1D5guT+ByvykifpjjE02f1k8HOhnvDEFko9liUfJSLXIKuILiddtkLOS0MuAMWBJOmIfWc8T6VkIJknzhTzApsReu6259X5tfrQ2U1Tnh0HnzUu/1OE+1B2F9uhchiok6QisD0dQodxjr2SsINpOwrfvIDTXP+0GKxgyE5PHe5o/ypvxXdwxXGI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(36756003)(44832011)(16576012)(53546011)(30864003)(186003)(86362001)(66946007)(31686004)(508600001)(38100700002)(2616005)(31696002)(316002)(6666004)(8676002)(5660300002)(83380400001)(26005)(2906002)(956004)(8936002)(66556008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azZMbjZ0VDlYd2gvektPSVQvSU4rcjQ5KzRZeVhNbElQRW9CRHVsd2lVeHNs?=
 =?utf-8?B?Y2NmWmM2S3RlNUgwS3NNUk92amwwZEFLUGN6dVZESjQ0d1MxYlZ6WVkxazBG?=
 =?utf-8?B?UEdKYzM3ZnpENFA0My9OOGtIZzJyU1h1NWY5dXpMUU8ydHBCQTByb2dRb2RY?=
 =?utf-8?B?ZkROOFk1WTBpOTZ5M1dzQjBJR0MzKytDUExieFRqazlEb2Ryd1N1OUZVcDNk?=
 =?utf-8?B?WE54RjhIYzhwTTJOdjAxUXRGTCtFZTI5bWhPVy9hTjNuS0p3U3hYdzl5aTZ0?=
 =?utf-8?B?cE5lbEZsN1RhTzBnalhTaFdRTFV0bElWaEpqc3VPZXZJSEx6MHk0Q3ZqZkxy?=
 =?utf-8?B?THNjQ1RxeXZldFNPZHhRcUVjaWNBYXRSaG5YMkt4aVpFR253ZDZIM0NEWlor?=
 =?utf-8?B?RHJ6RGxnZ1RCak1ramIxajVxWkUzZ0lCcHArM0pqVTd6OWhTMURtMXdxbFdQ?=
 =?utf-8?B?bkdvMm9zaGJlc28yTDcvYVphQmh4OEVwT0lRbFN5QWVyL1BIWDdpWXJ1eW16?=
 =?utf-8?B?bEc3ZUpmNEp4NGw1Wi9XUERYMmU4R1dPbWxpU1VpK2ZMNnBzU2QrbEJjOXd5?=
 =?utf-8?B?bjBkZkFJUzNXZFluMEVGRnNYeG5SY2ovYnFNeWo1Vk5SaFpycmE2THRlcTVI?=
 =?utf-8?B?aVNpaHdiREpOMkg2djBLODdSWUZ3Wm9nQmQydFR2aUp0UTV4bXFlQWQydktV?=
 =?utf-8?B?cXBmRkpoa05KbEpWMXNIcURjcDBuRmtUVW5qUlRqakthZFNmV0RGem1YVlVF?=
 =?utf-8?B?K3VNVUlEenNUVjRYQmlVVzlneWxuUERIVWRNVmdnajRIMTVVNUphdEhEZkdl?=
 =?utf-8?B?RU5OcHQvNjUwRHdDUnNPcTR1L1FJUHFlaEY5OUpUeDFRdDYvZTJBSElQTnQ0?=
 =?utf-8?B?M0tVTTRpUlY4S3NJRGNjREMvRTFrVDdYaTc5WE9UU0J2R2MvSTRISlBxekpP?=
 =?utf-8?B?SDJYOFpSOFZhdHdEZXFHN1JYcTl1aksvMlVWWjdPMVNpZjNyam1hbENuMGc5?=
 =?utf-8?B?WERNR1RXOTY4LzlpTXp2WlJnSHhndEtSVmNTS21yL2Vnb09FZ1ZVRmRhN3Nn?=
 =?utf-8?B?TTF2cHFwN3ZFS3M3N0J3bDFHWHhxWXoyQ2xDQklNbnYxdFNPbzgrY2hvQ1JY?=
 =?utf-8?B?My96ZGNrL1o1RkFmK0krSlMyejlMaHVkdUJmQ1ZLOFlnWkppUUc2QkRKRUhS?=
 =?utf-8?B?SkpPM3lmZG9FUUh4ZTBNZTg4TTlhb2NPdkRSTzdzREY0SU5YdzZIdVp4cE5a?=
 =?utf-8?B?ekZkVHlUNVh1WDRrOWRuaEZUT2VQbnVLQ2ZFLzVoRWdDM0ttNllkdHF3S1lp?=
 =?utf-8?B?KzBVcCsvUGkzaTlyRngzTDBuQm9JSHo1YlZ5S3FrQ3J0RFNpWHJGcFE3TzEr?=
 =?utf-8?B?ZE84aCszRFB2NHVEMjY4WXlueE5Ib2tOUXBVeG1LdEU4cUVucWFYL2pJUzNk?=
 =?utf-8?B?U2VQdnVHaSsveVN2ZFNkbitidmJ0WGxMdkVsN3R3YVNkYk5TakZiVklUelVV?=
 =?utf-8?B?VmdVb3dGQXFSdlIrdXdBRVQ5NFZUOVlGYVFvKzFHSE15RWNBbEdtcm5rZ3M4?=
 =?utf-8?B?aVhoVnprU0d3SXptbmF1THpZa3ZVa2N2VXFRYVZQSVVXMWk3bFUrY1dRREVk?=
 =?utf-8?B?YnpXU0lWMjV0ZGplUTRJQTlrSVIxWU5KTlFDdWpydHJWWVdZOUk2VWFVdWpz?=
 =?utf-8?B?bEQyYmhURlpXVmN4bE9MZkRTTFdEc2QvWE9qQVJuZ1gwbTRiVnBkZ2ZPdFEz?=
 =?utf-8?Q?zZNwTCDFleFSNBgLK4GigIPbjJr4z5WDDC1i+W0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa617cb-612c-4506-e2ad-08d988a6f672
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 08:54:53.1871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u7FuhGsBXxJPzBfn4sQwxtf5lgfB7os2Hx1wETjOUf+2ADBQaiSjCtHVZk6vikR4WY2KZNHckhG0Q98kNBuyWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2913
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10128 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110060056
X-Proofpoint-GUID: wbpYceoM0XH9CE9xqJgyfyS_OGnnr5jW
X-Proofpoint-ORIG-GUID: wbpYceoM0XH9CE9xqJgyfyS_OGnnr5jW
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 06/10/2021 04:12, Josef Bacik wrote:
> For device removal and replace we call btrfs_find_device_by_devspec,
> which if we give it a device path and nothing else will call
> btrfs_get_dev_args_from_path, which opens the block device and reads the
> super block and then looks up our device based on that.
> 
> However at this point we're holding the sb write "lock", so reading the
> block device pulls in the dependency of ->open_mutex, which produces the
> following lockdep splat
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.14.0-rc2+ #405 Not tainted
> ------------------------------------------------------
> losetup/11576 is trying to acquire lock:
> ffff9bbe8cded938 ((wq_completion)loop0){+.+.}-{0:0}, at: flush_workqueue+0x67/0x5e0
> 
> but task is already holding lock:
> ffff9bbe88e4fc68 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x41/0x660 [loop]
> 
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #4 (&lo->lo_mutex){+.+.}-{3:3}:
>         __mutex_lock+0x7d/0x750
>         lo_open+0x28/0x60 [loop]
>         blkdev_get_whole+0x25/0xf0
>         blkdev_get_by_dev.part.0+0x168/0x3c0
>         blkdev_open+0xd2/0xe0
>         do_dentry_open+0x161/0x390
>         path_openat+0x3cc/0xa20
>         do_filp_open+0x96/0x120
>         do_sys_openat2+0x7b/0x130
>         __x64_sys_openat+0x46/0x70
>         do_syscall_64+0x38/0x90
>         entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> -> #3 (&disk->open_mutex){+.+.}-{3:3}:
>         __mutex_lock+0x7d/0x750
>         blkdev_get_by_dev.part.0+0x56/0x3c0
>         blkdev_get_by_path+0x98/0xa0
>         btrfs_get_bdev_and_sb+0x1b/0xb0
>         btrfs_find_device_by_devspec+0x12b/0x1c0
>         btrfs_rm_device+0x127/0x610
>         btrfs_ioctl+0x2a31/0x2e70
>         __x64_sys_ioctl+0x80/0xb0
>         do_syscall_64+0x38/0x90
>         entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> -> #2 (sb_writers#12){.+.+}-{0:0}:
>         lo_write_bvec+0xc2/0x240 [loop]
>         loop_process_work+0x238/0xd00 [loop]
>         process_one_work+0x26b/0x560
>         worker_thread+0x55/0x3c0
>         kthread+0x140/0x160
>         ret_from_fork+0x1f/0x30
> 
> -> #1 ((work_completion)(&lo->rootcg_work)){+.+.}-{0:0}:
>         process_one_work+0x245/0x560
>         worker_thread+0x55/0x3c0
>         kthread+0x140/0x160
>         ret_from_fork+0x1f/0x30
> 
> -> #0 ((wq_completion)loop0){+.+.}-{0:0}:
>         __lock_acquire+0x10ea/0x1d90
>         lock_acquire+0xb5/0x2b0
>         flush_workqueue+0x91/0x5e0
>         drain_workqueue+0xa0/0x110
>         destroy_workqueue+0x36/0x250
>         __loop_clr_fd+0x9a/0x660 [loop]
>         block_ioctl+0x3f/0x50
>         __x64_sys_ioctl+0x80/0xb0
>         do_syscall_64+0x38/0x90
>         entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> other info that might help us debug this:
> 
> Chain exists of:
>    (wq_completion)loop0 --> &disk->open_mutex --> &lo->lo_mutex
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(&lo->lo_mutex);
>                                 lock(&disk->open_mutex);
>                                 lock(&lo->lo_mutex);
>    lock((wq_completion)loop0);
> 
>   *** DEADLOCK ***
> 
> 1 lock held by losetup/11576:
>   #0: ffff9bbe88e4fc68 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x41/0x660 [loop]
> 
> stack backtrace:
> CPU: 0 PID: 11576 Comm: losetup Not tainted 5.14.0-rc2+ #405
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
> Call Trace:
>   dump_stack_lvl+0x57/0x72
>   check_noncircular+0xcf/0xf0
>   ? stack_trace_save+0x3b/0x50
>   __lock_acquire+0x10ea/0x1d90
>   lock_acquire+0xb5/0x2b0
>   ? flush_workqueue+0x67/0x5e0
>   ? lockdep_init_map_type+0x47/0x220
>   flush_workqueue+0x91/0x5e0
>   ? flush_workqueue+0x67/0x5e0
>   ? verify_cpu+0xf0/0x100
>   drain_workqueue+0xa0/0x110
>   destroy_workqueue+0x36/0x250
>   __loop_clr_fd+0x9a/0x660 [loop]
>   ? blkdev_ioctl+0x8d/0x2a0
>   block_ioctl+0x3f/0x50
>   __x64_sys_ioctl+0x80/0xb0
>   do_syscall_64+0x38/0x90
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f31b02404cb
> 
> Instead what we want to do is populate our device lookup args before we
> grab any locks, and then pass these args into btrfs_rm_device().  From
> there we can find the device and do the appropriate removal.
> 
> Suggested-by: Anand Jain <anand.jain@oracle.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/ioctl.c   | 67 +++++++++++++++++++++++++++-------------------
>   fs/btrfs/volumes.c | 15 +++++------
>   fs/btrfs/volumes.h |  2 +-
>   3 files changed, 48 insertions(+), 36 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index b8508af4e539..c9d3f375df83 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -3160,6 +3160,7 @@ static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, void __user *arg)
>   
>   static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
>   {
> +	BTRFS_DEV_LOOKUP_ARGS(args);
>   	struct inode *inode = file_inode(file);
>   	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>   	struct btrfs_ioctl_vol_args_v2 *vol_args;
> @@ -3171,35 +3172,39 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
>   	if (!capable(CAP_SYS_ADMIN))
>   		return -EPERM;
>   
> -	ret = mnt_want_write_file(file);
> -	if (ret)
> -		return ret;
> -
>   	vol_args = memdup_user(arg, sizeof(*vol_args));
>   	if (IS_ERR(vol_args)) {

>   		ret = PTR_ERR(vol_args);
> -		goto err_drop;
> +		goto out;

  	return  PTR_ERR(vol_args);

is fine here.

>   	}
>   
>   	if (vol_args->flags & ~BTRFS_DEVICE_REMOVE_ARGS_MASK) {
>   		ret = -EOPNOTSUPP;
>   		goto out;

At the label out, we call, btrfs_put_dev_args_from_path(&args).
However, the args.fsid and args.uuid might not have initialized
to NULL or a valid kmem address.

>   	}
> +
>   	vol_args->name[BTRFS_SUBVOL_NAME_MAX] = '\0';
> -	if (!(vol_args->flags & BTRFS_DEVICE_SPEC_BY_ID) &&
> -	    strcmp("cancel", vol_args->name) == 0)
> +	if (vol_args->flags & BTRFS_DEVICE_SPEC_BY_ID) {
> +		args.devid = vol_args->devid;
> +	} else if (!strcmp("cancel", vol_args->name)) {
>   		cancel = true;
> +	} else {
> +		ret = btrfs_get_dev_args_from_path(fs_info, &args, vol_args->name);
> +		if (ret)
> +			goto out;


Same as above.

> +	}
> +
> +	ret = mnt_want_write_file(file);
> +	if (ret)
> +		goto out;
>   
>   	ret = exclop_start_or_cancel_reloc(fs_info, BTRFS_EXCLOP_DEV_REMOVE,
>   					   cancel);
>   	if (ret)
> -		goto out;
> -	/* Exclusive operation is now claimed */
> +		goto err_drop;
>   
> -	if (vol_args->flags & BTRFS_DEVICE_SPEC_BY_ID)
> -		ret = btrfs_rm_device(fs_info, NULL, vol_args->devid, &bdev, &mode);
> -	else
> -		ret = btrfs_rm_device(fs_info, vol_args->name, 0, &bdev, &mode);
> +	/* Exclusive operation is now claimed */
> +	ret = btrfs_rm_device(fs_info, &args, &bdev, &mode);
>   
>   	btrfs_exclop_finish(fs_info);
>   
> @@ -3211,17 +3216,19 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
>   			btrfs_info(fs_info, "device deleted: %s",
>   					vol_args->name);
>   	}
> -out:
> -	kfree(vol_args);
>   err_drop:
>   	mnt_drop_write_file(file);
>   	if (bdev)
>   		blkdev_put(bdev, mode);
> +out:
> +	btrfs_put_dev_args_from_path(&args);
> +	kfree(vol_args);
>   	return ret;
>   }
>   
>   static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
>   {
> +	BTRFS_DEV_LOOKUP_ARGS(args);
>   	struct inode *inode = file_inode(file);
>   	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>   	struct btrfs_ioctl_vol_args *vol_args;
> @@ -3233,32 +3240,38 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
>   	if (!capable(CAP_SYS_ADMIN))
>   		return -EPERM;
>   
> -	ret = mnt_want_write_file(file);
> -	if (ret)
> -		return ret;
> -
>   	vol_args = memdup_user(arg, sizeof(*vol_args));
> -	if (IS_ERR(vol_args)) {
> -		ret = PTR_ERR(vol_args);
> -		goto out_drop_write;
> -	}
> +	if (IS_ERR(vol_args))
> +		return PTR_ERR(vol_args);
> +
>   	vol_args->name[BTRFS_PATH_NAME_MAX] = '\0';
> -	cancel = (strcmp("cancel", vol_args->name) == 0);
> +	if (!strcmp("cancel", vol_args->name)) {
> +		cancel = true;
> +	} else {
> +		ret = btrfs_get_dev_args_from_path(fs_info, &args, vol_args->name);
> +		if (ret)
> +			goto out;


Here too.

Thanks, Anand

> +	}
> +
> +	ret = mnt_want_write_file(file);
> +	if (ret)
> +		goto out;
>   
>   	ret = exclop_start_or_cancel_reloc(fs_info, BTRFS_EXCLOP_DEV_REMOVE,
>   					   cancel);
>   	if (ret == 0) {
> -		ret = btrfs_rm_device(fs_info, vol_args->name, 0, &bdev, &mode);
> +		ret = btrfs_rm_device(fs_info, &args, &bdev, &mode);
>   		if (!ret)
>   			btrfs_info(fs_info, "disk deleted %s", vol_args->name);
>   		btrfs_exclop_finish(fs_info);
>   	}
>   
> -	kfree(vol_args);
> -out_drop_write:
>   	mnt_drop_write_file(file);
>   	if (bdev)
>   		blkdev_put(bdev, mode);
> +out:
> +	btrfs_put_dev_args_from_path(&args);
> +	kfree(vol_args);
>   	return ret;
>   }
>   
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index e490414e8987..3262e75fbb1c 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2076,8 +2076,9 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
>   	update_dev_time(bdev);
>   }
>   
> -int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
> -		    u64 devid, struct block_device **bdev, fmode_t *mode)
> +int btrfs_rm_device(struct btrfs_fs_info *fs_info,
> +		    struct btrfs_dev_lookup_args *args,
> +		    struct block_device **bdev, fmode_t *mode)
>   {
>   	struct btrfs_device *device;
>   	struct btrfs_fs_devices *cur_devices;
> @@ -2096,14 +2097,12 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
>   	if (ret)
>   		goto out;
>   
> -	device = btrfs_find_device_by_devspec(fs_info, devid, device_path);
> -
> -	if (IS_ERR(device)) {
> -		if (PTR_ERR(device) == -ENOENT &&
> -		    device_path && strcmp(device_path, "missing") == 0)
> +	device = btrfs_find_device(fs_info->fs_devices, args);
> +	if (!device) {
> +		if (args->missing)
>   			ret = BTRFS_ERROR_DEV_MISSING_NOT_FOUND;
>   		else
> -			ret = PTR_ERR(device);
> +			ret = -ENOENT;
>   		goto out;
>   	}
>   
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 3fe5ac683f98..223c390ec057 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -527,7 +527,7 @@ struct btrfs_device *btrfs_alloc_device(struct btrfs_fs_info *fs_info,
>   void btrfs_put_dev_args_from_path(struct btrfs_dev_lookup_args *args);
>   void btrfs_free_device(struct btrfs_device *device);
>   int btrfs_rm_device(struct btrfs_fs_info *fs_info,
> -		    const char *device_path, u64 devid,
> +		    struct btrfs_dev_lookup_args *args,
>   		    struct block_device **bdev, fmode_t *mode);
>   void __exit btrfs_cleanup_fs_uuids(void);
>   int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len);
> 

