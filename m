Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC21F33859C
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 06:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbhCLF7B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 00:59:01 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33344 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhCLF66 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 00:58:58 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12C5u1OE124063;
        Fri, 12 Mar 2021 05:58:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=l0ATy8tsDnoS+NKo3xreHDzz7288g69t6V15rRtPAnY=;
 b=IfZ4xUH1jd9wUkMsa82r5gF9akwyNin6JL7NJkptAQAgb9muFadpY0KN9Kf4prx0GXGt
 HF9PZ0QlocB/zCprs010IHG4mIaWrgKnfVZ7bBba2jMSAbzIQl4wNgI3UK6JwD+4rjPE
 rlUonqR/3v0h3hJ+mCY7KXIAvRv2sTBhHDqgmw/hvyqOw0NnsNCfKYw3bVVayQeVHWuK
 rwAdcPV4JTL+y73CeiUqoF1g88tu++Itmlo3Xqhd1jjulri+VK0wQ+kGD/9s/yTs1YBL
 7bA9W9Hx+821HKxthtXBrRFfA9/oR3BtQX5TO9aIArG0eIy84a4IKtpmo3AbFlnkAoGn 8Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 3742cngv15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 05:58:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12C5tYGb103893;
        Fri, 12 Mar 2021 05:58:53 GMT
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2054.outbound.protection.outlook.com [104.47.44.54])
        by aserp3030.oracle.com with ESMTP id 374kasu0f3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 05:58:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrOdqQqJCDi9TEL+yON03HmLesVlvRMWqiKWpfGIiK42tMX71I0Zz0tPR/pbhqoRYhSLbRFXahGYfyZOMaFtPJRTJf2ecFe9z5vF2UWRqiD7985uyGTbnNoWpnn/nkD69i1HRHVkrdXdjUbfZ942limFlx3crJB6iWh0dqitIEZLBm/g1fYOQ0Iu0IhQgBqClmL0YCJPeZfjlifYoJgjufNru4lfEn3+Fnh4WuXNoYkPzEDONUNcG3NHMYytyLvqgn8nqI4xYkVVSuLKsYThvMkFio0z3GUfqdTY8NNDvj9ZGsdlIjY2uyYAMfUoBt0iFpWqdn54su83XZ4TL/Vs8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0ATy8tsDnoS+NKo3xreHDzz7288g69t6V15rRtPAnY=;
 b=OaJSj5MkqN9tUNHIZqx4BWFz+E+XTAtvwwdg/3uReNuyrFKSrmqCFSn0Ju7exCqWXQ03+GziZbvUPG2ZbT0Py9uSGj9lKX0sKWLz6jNPY7koQZ6FzMP+M5NvgENmH4q2sh5C8fRAlNoAVYzVDfRYXY8B6e7OObk0fpuKKqWgCpm6VAW013F1GkJ4CSoPfzqVe9NwWxFels6fHxp/UKZdmghQdlV6jaw2GRopdYsVFBvJgh996r0s2qACb/QIa9t6lKXHmpPzWhWzMhSp2n7f3trGRsornlmOk752LNmPHaCZBo0cyAnnlsAVGMGzqsICU6PnYxk6tmtx+3UOa29Mpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0ATy8tsDnoS+NKo3xreHDzz7288g69t6V15rRtPAnY=;
 b=NmLff+cAI36Ii3rK8d5OTfoqod6Dt0eKeI3FxfpdaRtvFjh5PaS9iLRpEjG/TC2Dgo66E3Kj16AN27T/1P4z2CSOjQVbyzG7oORy+ABh61spyu/n0xT6Hl6sd54oxDkmgoFhzbd+irKhXtMjIAPPmmiE7bpRAfl2lDF563Kr7aI=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4190.namprd10.prod.outlook.com (2603:10b6:208:19a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.29; Fri, 12 Mar
 2021 05:58:50 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125%8]) with mapi id 15.20.3912.030; Fri, 12 Mar 2021
 05:58:50 +0000
Subject: Re: [PATCH 1/3] btrfs: init devices always
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Cc:     Neal Gompa <ngompa13@gmail.com>
References: <cover.1615479658.git.josef@toxicpanda.com>
 <e5abaf864da01a3ee1cb8ef341ef1024c9e886f6.1615479658.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <aba09817-91c2-7cef-5398-79720e8d09ae@oracle.com>
Date:   Fri, 12 Mar 2021 13:58:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
In-Reply-To: <e5abaf864da01a3ee1cb8ef341ef1024c9e886f6.1615479658.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR0601CA0015.apcprd06.prod.outlook.com (2603:1096:3::25)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2PR0601CA0015.apcprd06.prod.outlook.com (2603:1096:3::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 12 Mar 2021 05:58:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8829cd3-bd14-4245-b25e-08d8e51be8b8
X-MS-TrafficTypeDiagnostic: MN2PR10MB4190:
X-Microsoft-Antispam-PRVS: <MN2PR10MB41901472EDEBB85E2E1C4F2BE56F9@MN2PR10MB4190.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CUIOOZGnNZGTWKOC3rlrazd7dLNtn9EaM+BD0QxQM68jWToicNrWyel4u05E6BRMSsyv07V6R7jqSkBqIKPEmFuXV6QJiYZ6+r87dkbO/P1t+Jz13kCxODsWb+3ThDzGiyyIyf0jkkF9ui2O6NGJJ9MN1HHgO+RKWfk63nYMva4OqiZ9mza0a2BKKaqtDxytvfSW/52e6wIAgYH1dF/P6hySiXzof++1NJpB+8FQ+FYwR8BoX129n7Ead4xvjkHSbKEQUUtoVBYKYT6v0QJtDE6SvWAkQmKeuDJxurIldA4zsWuXoEVkXLRvFCR2UXoHESPenMpJG69M+puZ6tqnvP5JWknnqcTQjQb76yvqAa+KoOAGInp5/eRzkKXQnGsVtztxlKgXdFO71juAb2k5452OlccPG9jjKuUkfnOvEbGgeCelLNTrSV0MwATQP7n7uPVcUyI+zVZvITteOAilaHbNWG2DC5gUXKpepXaIaCMJ5CMxnRGjPjjQmUTL23oGZkkIXvfADMvF9e26K4RmVsUjs37AvagkIR4Wb/dLLzF8efmP8euGcm81Rgszn1jcQS5NHX5pYXlYIIUwHtCYkBubB+9Nvmo6RPuG3mCJSVo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(346002)(39860400002)(376002)(31686004)(478600001)(26005)(2906002)(86362001)(6666004)(16526019)(16576012)(8936002)(36756003)(316002)(186003)(66946007)(8676002)(53546011)(6486002)(66476007)(66556008)(4326008)(956004)(5660300002)(2616005)(31696002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MGhIYnhhUWhDWnRlMFVzNU9QSnp6cTFGTnJTMlZMVno5OFpaaTl3ZS9qQkFB?=
 =?utf-8?B?OGJZa1lyNUgwQXVmbkJnL2NiWlpiV2xETzUrcWhYUEpaclZiL1RtUk4rS1Vq?=
 =?utf-8?B?cFdTYi81K3FtT0svSmpZRUdKOGpVM0RWS3pjWnRKeWtOeTV2U08vdGtHQ3JF?=
 =?utf-8?B?eHZHTU1CK3BVMUEycHl6MER3cWxDSXR5cW82QUo4OXVyTFk5TktjdEN0WFkv?=
 =?utf-8?B?SzdyU1ZaNVFlK1NOSGo1dkNwbldOMzFvUjZYK1ZoZndQcldGYjVaUnFjY3Vs?=
 =?utf-8?B?R0NzTEJmTytSWmczVHE5cm14MzE2aU5xRTRXcVU2a0hXVFRFT1BlUFNSTUdF?=
 =?utf-8?B?Q1BmOU1QOG5yUWRUdHIxcDRUN1pPNEhBSHVVaVVScDcybU0xV1dIdWNIbkJ4?=
 =?utf-8?B?cG1HRjF2bktiMW9OYTM3Mkh6YVRzTFBLK0FaRUJMMkJlNTl5NnRoemVBQlBY?=
 =?utf-8?B?SEM5Q285NFYwZnYva1Q5WGtWMDI1eWQxMTgvQmNmRzhwRzZKWm9jekdiemVo?=
 =?utf-8?B?YzZGdUlwQ2FtZitIUTVMcHZCSDA1aVgvSU50a2lvL051QVY0TzQvNnhHTFRs?=
 =?utf-8?B?aVYxVklsejRxMlJ2VTJzTXh3ZkJSeGJTbFhjNVBIMk5LRXptQ2JDYVlKSVUy?=
 =?utf-8?B?NmFXcmN1bG0vVU1oeHpYV1UxdjlpV0t0VDA3NmZSVWlMSWF0WlFwNVZCSlhV?=
 =?utf-8?B?SW44OEFialRXdE8yZ2ZBTm55T0FTR040NzNkenVZeE9GdEtweVR0UlFFMnoz?=
 =?utf-8?B?L2Y1RGNRWVNXcHVtTmJQM0ZWdFo5aWdyK001ZXRVY1k3SFZGRW5PNXZLQWkv?=
 =?utf-8?B?YTdwbjFiSGlTR0lLTWxEUFZkRUhSU1ZmWXQvcktWMjMzVXN5UG11eFA3TXVS?=
 =?utf-8?B?M2RrZ0RmSU9SdzMxMjlDaTJ0VjlZSUJnd2tFSlFud05ldmRIUjYxc1Q3ZGdq?=
 =?utf-8?B?aTJPZmRDMWRBbUJQUzV5ZG5BN0MzdWhOK2ovelY3ZTBuRlZTUzBqZzdIOFd4?=
 =?utf-8?B?dFE4MllncXdIejRLUEJ6Nm5PT0xWc1NiRUhLMWJjK1VYaFg5YlpINVFZbHlO?=
 =?utf-8?B?NmliWEY5ZjRURXU5K0lQaHM4MHN1N0VGeFkzY1E5dityVUxoRlljaUxwdDNa?=
 =?utf-8?B?eVdFamhyVnBQSTZMcWZkVitUOS9Tb1VUdzlaMnFWZVN6QUxSTHFXQUhORW9M?=
 =?utf-8?B?OUl5c1hUUkxiVGtkU0FPWjlqUGhBc0VUSUd4UVFDNGQrNHdDRzdOeDNJMmhQ?=
 =?utf-8?B?cURUQjdYdXA3dG5PamdHTmN1ajJGSmlldWlxWW1WOC9za0V1L3NJSWRtZ3k0?=
 =?utf-8?B?V3djeG1KN0FiMFBRbGIrbFc1SjRCejZNQWVsay9OYmJkU1ZVZDJKbGRHQVIz?=
 =?utf-8?B?RStFTXdaTnVIVlZ2V2E0aHMvZmJHRXV2UFEvUlBCaEFjejFnY2o1bDRjR3pP?=
 =?utf-8?B?dWNqZGhTY3hidHdORlVVWnl0ZUFkeVMybndTd2pSSm90d1V1ZWZDL1lqQk50?=
 =?utf-8?B?aG9qd25QNVZ6VytEbSt2VmJ5UzFtSitRSXUxTWFuRytrb01ybXdtZW03Sktl?=
 =?utf-8?B?Q3hNOXlhZm1MNlpsRmZkTkx0UEtaNFpyaW84eEdYS1R5SWtpWWF6ZHlPbGky?=
 =?utf-8?B?V01adWpubWNrUkNRM3lCTEtIMmNtcWFVazhiN1RJUkNRQjE5OEdXQlVCdTdk?=
 =?utf-8?B?WG5NQzFZT1VMZHJXc21VeHRtS3MxWlpndktGNE9jaUdoNGlsZ3BOK1RkS0d3?=
 =?utf-8?Q?pI5ZvkdCVWgegWn/KfE0fZ21CX8SNvzIW0Ey70D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8829cd3-bd14-4245-b25e-08d8e51be8b8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 05:58:50.7357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xB6ydr4s3lHhKC0H9vUYfY0jAmHJTW6Nqqip15HQnYbumJ2m0yJQTmBatsE0j3cLwPDKQ0cOG+o3TfFc+UXYrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4190
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9920 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103120041
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9920 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103120041
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
> read the device root.  However we don't actually need the device root to
> init the devices, this function simply assigns the devices their
> ->fs_info pointer properly, so this needs to be done unconditionally
> always so that we can properly deref device->fs_info in rescue cases.
> 
> Reported-by: Neal Gompa <ngompa13@gmail.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

