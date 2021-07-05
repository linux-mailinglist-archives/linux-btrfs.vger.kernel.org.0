Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032F13BB58E
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jul 2021 05:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhGEDYD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 4 Jul 2021 23:24:03 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:53400 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229689AbhGEDYC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 4 Jul 2021 23:24:02 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1653Ha3k002593;
        Mon, 5 Jul 2021 03:21:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=al3YuuIleY1fR/QxFzO6EWnaW4wmGF7QC4eAfUktZmU=;
 b=uwT7tAkR/NB73HUs1wxX+J8Mv14k8wWmn0LolkI7Z0iHFn/W5bbZnbIxU4ay/sNWIgBR
 pSXbuh8d3zjr8pLjVky5NmEd0bn2fii0rY7Kl7FNQ9nPPfur7ClCC9NU8KtJcFkXIeWc
 g62IwUC99aziqz9nup30SPR0ntLY8aHlnl0QezvUGfhxmyJREwWmiWXQmJEwlC/yrW4n
 mBOB873RJIeAEEru8pGda9lKje1ZV3limr8lNVwOrY5Vk3AoLCur+hNh76WutZlJOWA7
 CNknq/W/Lxhkv393s+/aryxjKbg1u4NtvXNGckfjkX+mxghRpPHvIhr708rPZ0rEYNGX dg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39jfgs9me0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jul 2021 03:21:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1653GCMc179506;
        Mon, 5 Jul 2021 03:21:23 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2045.outbound.protection.outlook.com [104.47.56.45])
        by aserp3020.oracle.com with ESMTP id 39jfq5v5ew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jul 2021 03:21:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUY17ZE6bY6vs4pGAWAXUzqIjIcrdXexnbAky6GTKwaQmYjDcKcE1sAVQYA7U6BOq2ji7cjD7QNcgI0fq2cLu+1kjEQ0fyLLHxNYsIiwG4CeZCLtt7cC9nNwtn/TIcrZLcWvZOCrpjfGZ1fK5dJ4Ok0FwnWVRSqpDUFE27KnOFR+qDHnYJ+hWT61bt3WDTiQtFgSzrkiXeq8OmfGvQgU10zpACLKSay8g1vyd8xVtQHND5H44iT5ziOwbiT8MCTHDEjveH9ruRQzF+bJE4BYyIw37KGtX42DfKpCBlumn8Y3Ys004Rl9U//WNmJVQf4b8Ll0ZxoySwESC3ZqPOu9cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=al3YuuIleY1fR/QxFzO6EWnaW4wmGF7QC4eAfUktZmU=;
 b=mfR5sF6DrbDrzsk1w11hHoBAYd2sGeTvL4cFXk9Mntj2jX8IT4yVCLIfYYFnKSL4KxyTWZv+yn8QaGB2wc5ULPQm06JesMhzzxsSEW3U9f/8nhIQNggLMcIDEPzofAur9O5MPaK5/8q72QKwW38XrPkE/JvgVyJ6ZkGec9c+AJKpr3E7Ng8U2hgmZAFOygL5IwZrtVWEFD/7CcFvnDOISvZt9KRC0jqIcziLX0fQU1pYQ50xC6tXPo67EMoJI0YYk425ZFTAeAjVLsz1niLVjjRbY0kwnbXmGv6sSYqKkWLHqlUf/6jlD6jnzj6Mfr9lBkaK6wT9S+hHkediCvWgVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=al3YuuIleY1fR/QxFzO6EWnaW4wmGF7QC4eAfUktZmU=;
 b=jzlG5QjfEL/xKzb1OL9ye4HL3nYHziCxt8U8BpACWDqixaTdM7qKE72syTjd12ffq02zAL2nyhFwHvodqueDBmT3TeuUh2fhVuUUGWFIhnTKBdP3HUDvZ831CjxKq0SoR8VtNuY8gVBB6C2iiFUDE7A6u8RNs2bGiuXbGRi9WQE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4223.namprd10.prod.outlook.com (2603:10b6:208:1dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Mon, 5 Jul
 2021 03:21:21 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%4]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 03:21:21 +0000
Subject: Re: [PATCH] btrfs: check for missing device in btrfs_trim_fs
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <fce2724eaa78b9666c2ac4f0a1b806ae14c55cd0.1625236214.git.anand.jain@oracle.com>
 <9786b027-e380-6286-4ec9-e28d7c6d46f1@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <ca245597-393b-39da-f0f7-5daf9f14c5ca@oracle.com>
Date:   Mon, 5 Jul 2021 11:21:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <9786b027-e380-6286-4ec9-e28d7c6d46f1@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:3:17::20) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR02CA0008.apcprd02.prod.outlook.com (2603:1096:3:17::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Mon, 5 Jul 2021 03:21:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09442aee-31c0-48a3-4b3e-08d93f63f5c8
X-MS-TrafficTypeDiagnostic: MN2PR10MB4223:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4223A26CA0EC939C02D19ABBE51C9@MN2PR10MB4223.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:411;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GtdGsHEaJJ4MKGMGAmMdw3a6PyxT23RRedwI3TbdXaisWumJREvF3DvMZf5cN9vxuM4DeG6JsZ6sTQHuV4b4QQK6GfxiaMq+Zfdq45b4+MPoV6dOrUkI9VBPRb2b+kmmZSdK37elYxoWRyWy3N4Ws6K8ZnYlVxIWsSRJnu6EQGu9SyVti/L1wbljBksMDMQvY2VQ/Nil1EK4BHiPoXexqqt7jlBalvDK1lt45z/pW/u+kWLX0tLvNkYsRLiBaAb8S+GK4G5Nn5w9Djn83t1ASaE2YDSQACuUMOjFiAqUPqw9Ij47tCoJiFsMtEmVWy5rdZfcYM7rA+ty0MHKHGTBlb/V7hXTDOILeDzZYFER5deo7VdoYMMlFgU0jUw26EHJef3c3FukU+2ZtWMkjluFubdBOYf3EP4Q0RQMGtfqiTzM0vdiO4uZEZKR5IKqeWoZyy9LQ3AYcveWw+cWYBZLn5/E9zjmQn26PDfodvEQNaVO7fZK3mp9PqNOiYGZNb/M6ratYlFjsE8mIGvMxNQMkhednnzHn+T4sh0fHBU4AGKGK3/hkuiI2wPw2h0519M+QXp/wiNl0f/G6sc+7ErSma8OF3PaGOUCg1XfjaWb2JwYjp8BE6QbrS50SUPW07jArwxbq8WmE4c35sYMVtS2uYfFsGFF3W+erWU5oWkvRs6dEodsdBbOVon/LtVh6VnV6w1NH5ZAJZnmlM6S6yC34uCNTrf0dknhTbj15yffp+Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39860400002)(376002)(136003)(366004)(31696002)(16576012)(86362001)(38100700002)(5660300002)(16526019)(26005)(316002)(478600001)(2616005)(956004)(2906002)(186003)(8936002)(8676002)(66556008)(6486002)(36756003)(44832011)(53546011)(6666004)(31686004)(66476007)(83380400001)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1lSUzhiZUNTSzgzbnJSNVppK3ljcDZ4ai9rUnNGcjBuNDhKRXRSVDB1VkQw?=
 =?utf-8?B?UTdpazZXYkNNeFJIc1pvUk55ZTlBYWhEM3prM3lXN2xRRVFpbGR1UEtVdUJU?=
 =?utf-8?B?M0hIYjJVRTU4b0Y0V1BXU01xL2FtZEdFMHFCaXY2dDg0NHd5VnU4YlNrZjJF?=
 =?utf-8?B?dFlVSUhjZVhrTjRkc3V4ZjFHdVRUZTBwZUxIL1RUNnpHQUNZQ092ck9YMWov?=
 =?utf-8?B?QTZSU01nY29Ka1BvSFkzSXorMUdNR2F3ait6cEVldXZSTUc5c0t0SkJOTDQ1?=
 =?utf-8?B?YnpzblltWVhoUHZFQUxBUTlsK2FCY250d3p2RWl4VlkyM2FwRDBodlRpTDkv?=
 =?utf-8?B?KzlVajdLUi81enR3a0UxUnpnQlJ2S3owcEFSbFlOMFo0RFdBRzh2dkw5eXYx?=
 =?utf-8?B?cWN2MGxCNkpySlRIejgvNXVmYzZsbXJYVVlvd2VWeXR5bEZTa3NIWlppU3Y4?=
 =?utf-8?B?V1JzM1ZlSW1GcllhQnlXdkVxZW04aTd0NFQxQkloZklzUlYzTXcvbUdDUWJ5?=
 =?utf-8?B?NjNHZE5lbExoQkJxQ0dxN3ZGODAzMXVFNExoTktLSFI0V0ptemJtWXFvajd5?=
 =?utf-8?B?MU9QSFJuU2NQamJ4M2F3NDEzOE54RHBCSWtUNnI0Tlo4RVRLdFgrQjVzSGRP?=
 =?utf-8?B?NXdINUZQUDRnSlp0QjJWRzBWM2h5NVhMZTF4MnBTRkdwWVFnVGNOT0d3Vy9h?=
 =?utf-8?B?K05HL3hWWVZlRFhCUnlpYnUxeHRrTERWd3MzQ3VEQVFNRUhTa0s5cFA5a0x3?=
 =?utf-8?B?dkloVzVGaWpxNGtRS0xRZC9IRldrMEkyZ1FqbHNTcjNpVlVBZ3E1K3BYckl3?=
 =?utf-8?B?d1E3Tmc3ZEtFdEJIajdqaE92WmpPV1N6bkc0MmZzNGdiRkRwRlNEOXhEclpQ?=
 =?utf-8?B?RmVxNW1QRGVKYmZOYmVXdW5ENmpXekU2cXdWMVVWMUdWL1lhcDkxU3cyamM5?=
 =?utf-8?B?T09pbURsTVRzSUVZSDcxMlJKWG1TNE9ndkNBeC9rMjBzRExwdml6cGUrbTky?=
 =?utf-8?B?cWVyL2EyaXZaK0JRY0V2ak9mcS9TZnF5UUdzNTdoQXpXTEVEa0R0bjNnUEc0?=
 =?utf-8?B?VEplaUdnVzRXSE0va0pkWXFybldvN0RCV3RoVGdVaVA0Kzhab0JzZVVKNFc2?=
 =?utf-8?B?UXpzNzhyUW1tcE1yLzFleXdyWHNlZERreVFKNUw0RmRZK1YxcjJpOFhBQzJn?=
 =?utf-8?B?Q3piaHRhd2lrT1AzQ3hPUG1oYkJaRzBpTzlISStheHEwS2F3Snc0bHJyd1NW?=
 =?utf-8?B?VlJXK3BxYWFhbTR3V0w4U3pNOHB5QXd5S2dES0c4R3ZtSnEwWjRoQ0JKTDJW?=
 =?utf-8?B?akNvTGtRV2ROYWw4clIrVk45ZmlrNkRDd0ZKa0JNSVkzUkh1aGEvdDg5dWNI?=
 =?utf-8?B?VzNmWkNwd2RsNGlJWTYxQmxiM1U1YWFDMFVtMXR1TmtUTjdPRDlyWHNwSURo?=
 =?utf-8?B?aUY3eW9COEZTdjB0Ym5aTktRTGdGU0wwRXVCQjUwVjFVdWdZMU1HS01UZ3Vt?=
 =?utf-8?B?SkhFT051ekF0dDE3eWNLdXlEa1pNMDlEM1g4bk9uUHlSVVFZbmlUZ3kzSjZh?=
 =?utf-8?B?ZGlTY0FQN2FKdmo5c3o5eGE0bkdSL3FaOFg0YlFGZUFQWHdLWmlOR1drNUpX?=
 =?utf-8?B?TXh6UWt1K1kxWWpyZWtPcHUzMGg3b3VHc2l2R0F1Tzc1S3ZmMGVWeFpDNDlV?=
 =?utf-8?B?Mmd0NDZNaHQvSWRTRWpDaXlwbFVLOGFnLzNPNkFsRmFPQjlIWjY3eXl3UHRl?=
 =?utf-8?Q?kGO8SVz2SWGlFOmVcHN73ivvvcTB/4PaEB5ifzt?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09442aee-31c0-48a3-4b3e-08d93f63f5c8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2021 03:21:21.1514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ONHjkCfK5z6qsjQmwWb8xxOfOV+ycznkL0gjWvQgAhyVD7ImjUjNTgpRAYVVWz1+XBQ+Aew3UqYIBZfF9M5RrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4223
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10035 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107050016
X-Proofpoint-ORIG-GUID: N6lZwUC3C0wtcLoIS_dSlmXrjWrxf2_E
X-Proofpoint-GUID: N6lZwUC3C0wtcLoIS_dSlmXrjWrxf2_E
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 05/07/2021 08:12, Qu Wenruo wrote:
> 
> 
> On 2021/7/4 下午7:14, Anand Jain wrote:
>> A fstrim on a degraded raid1 can trigger the following null pointer
>> dereference:
>>
>> BTRFS info (device loop0): allowing degraded mounts
>> BTRFS info (device loop0): disk space caching is enabled
>> BTRFS info (device loop0): has skinny extents
>> BTRFS warning (device loop0): devid 2 uuid 
>> 97ac16f7-e14d-4db1-95bc-3d489b424adb is missing
>> BTRFS warning (device loop0): devid 2 uuid 
>> 97ac16f7-e14d-4db1-95bc-3d489b424adb is missing
>> BTRFS info (device loop0): enabling ssd optimizations
>> BUG: kernel NULL pointer dereference, address: 0000000000000620
>> PGD 0 P4D 0
>> Oops: 0000 [#1] SMP NOPTI
>> CPU: 0 PID: 4574 Comm: fstrim Not tainted 5.13.0-rc7+ #31
>> Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 
>> 12/01/2006
>> RIP: 0010:btrfs_trim_fs+0x199/0x4a0 [btrfs]
>> Code: 24 10 65 4c 8b 34 25 00 70 01 00 48 c7 44 24 38 00 00 10 00 48 
>> 8b 45 50 48 c7 44 24 40 00 00 00 00 48 c7 44 24 30 00 00 00 00 <48> 8b 
>> 80 20 06 00 00 48 8b 80 90 00 00 00 48 8b 40 68 f6 c4 01 0f
>> RSP: 0018:ffff959541797d28 EFLAGS: 00010293
>> RAX: 0000000000000000 RBX: ffff946f84eca508 RCX: a7a67937adff8608
>> RDX: ffff946e8122d000 RSI: 0000000000000000 RDI: ffffffffc02fdbf0
>> RBP: ffff946ea4615000 R08: 0000000000000001 R09: 0000000000000000
>> R10: 0000000000000000 R11: ffff946e8122d960 R12: 0000000000000000
>> R13: ffff959541797db8 R14: ffff946e8122d000 R15: ffff959541797db8
>> FS:  00007f55917a5080(0000) GS:ffff946f9bc00000(0000) 
>> knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000000000000620 CR3: 000000002d2c8001 CR4: 00000000000706f0
>> Call Trace:
>> btrfs_ioctl_fitrim+0x167/0x260 [btrfs]
>> btrfs_ioctl+0x1c00/0x2fe0 [btrfs]
>> ? selinux_file_ioctl+0x140/0x240
>> ? syscall_trace_enter.constprop.0+0x188/0x240
>> ? __x64_sys_ioctl+0x83/0xb0
>> __x64_sys_ioctl+0x83/0xb0
>> do_syscall_64+0x40/0x80
>> entry_SYSCALL_64_after_hwframe+0x44/0xae
>>
>> Reproducer:
>>
>>    Create raid1 btrfs:
>>     mkfs.btrfs -fq -draid1 -mraid1 /dev/loop0 /dev/loop1
>>     mount /dev/loop0 /btrfs
>>
>>    Create some data:
>>     _sysbench prepare /btrfs 10 2g 6
>>
>>    Mount with one the device missing:
>>     umount /btrfs
>>     btrfs dev scan --forget
>>     mount -o degraded /dev/loop0 /btrfs
>>
>>    Run fstrim:
>>     fstrim /btrfs
>>
>> The reason is we call btrfs_trim_free_extents() for the missing device,
>> which uses device->bdev (NULL for missing device) to find if the device
>> supports discard.
>>
>> Fix is to check if the device is missing before calling
>> btrfs_trim_free_extents().
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/extent-tree.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>> index d296483d148f..268ce58d4569 100644
>> --- a/fs/btrfs/extent-tree.c
>> +++ b/fs/btrfs/extent-tree.c
>> @@ -6019,6 +6019,9 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, 
>> struct fstrim_range *range)
>>       mutex_lock(&fs_info->fs_devices->device_list_mutex);
>>       devices = &fs_info->fs_devices->devices;
>>       list_for_each_entry(device, devices, dev_list) {
>> +        if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
>> +            continue;
>> +
>>           ret = btrfs_trim_free_extents(device, &group_trimmed);
>>           if (ret) {
>>               dev_failed++;
>>
> Won't it be better to put the check in to btrfs_trim_free_extents()?

  Fail early is better. Also there is only one caller for 
btrfs_trim_free_extents().

> And maybe it's better to also check device->bdev, just in case we got
> some strange de-sync between DEV_STATE_MISSING and NULL device->bdev
> pointer.

  I can add NULL device->bdev check for now. It is a pending cleanup as 
a  whole to use one of it, and I am sure DEV_STATE_MISSING only will 
suffice.

  I will wait and see if there are any more comments before sending v2.

Thanks, Anand

> Thanks,
> Qu
