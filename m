Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A471A3BF2B7
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jul 2021 02:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhGHAO1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jul 2021 20:14:27 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:44994 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230018AbhGHAO0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 7 Jul 2021 20:14:26 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1680AalE032762;
        Thu, 8 Jul 2021 00:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : cc :
 references : from : to : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=CAmdm6LZ4dQwQk62z/DGOSZuQn8hFfzy+5dA90HiBEw=;
 b=gPMU15Cc9fLDQbo+xK8186qP3jCjbE15bkeb+t51OXPloNTrLlhyJvW7dJGhhodsz3eB
 ANFBlYk6rE66z1I3bgakrTg1+tY725Eu9tg/Hn/diDAilb6C/T2z2Js22WSiAdBFG6RY
 4sDMOtcjjolcWHYtCF69HCWFwcCFEGcivgvf6M5amIGNCq8cCRbMIm+XEOuDY4V+USV4
 BM7FbOeGm6YtU7KgxUeQSwxiDBzQP/AWcU34CuDpGTCndqg/bY80kTwrv95q5NqJZZIs
 iuPr2JKZYzsoXITAvLqu+Ywd+wai33eqNrjhcWJJvK2IqogtbjdciafgLEOEVf1IPKOQ cw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39m2smna4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jul 2021 00:11:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1680AUMA115359;
        Thu, 8 Jul 2021 00:11:41 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by aserp3020.oracle.com with ESMTP id 39jfqbh7pj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jul 2021 00:11:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErN6b9B5mpPC/1emmj/hzT9+O6z1pg6OWu1290xLfSCHssWKQ2N5NVw2dbJ9gaPRtk2pZsBphMrFatecqgfAJKFpBpSOl11BYEXLezYYmPvya3X9drd8QxRcwT9/qgxAkcYpVhq3azYH/mVATMUbIe5PvsnCne7jdIrHxaiewoGV5LfGnSj8PDwRLiWSWxZVDb1AqnjTcCFUe2K9nyJIBozjY5gCo2C2NAvRASeGIxc50Cc303qTBIwZ3keEVsa614QXWul9SbyednXQ2BZTC0MMQTCKF44+ylptrqqJ+VGxN6BAMxIz6kzRkrFZeRLBRrIYNwGIruk6QMyVciDmjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAmdm6LZ4dQwQk62z/DGOSZuQn8hFfzy+5dA90HiBEw=;
 b=jKC50FDDx5qwpURfuaJ5a/5PEjihdWbZZyVdeBBE4X+0ynneBiygKzUnwDzix2+e+0X/SM1OS2tnVBrnlsjEaqLqpZkqX/EaP50W4fjmZcfpGcNMN15FUsd6mRToo1Eq8GKz4ntodMW2gGBAn7q8ks6202BTMW+atWzdFfm61lmW2YLyOGPGYiGAGm7Pq9bNNi/A2QApWHmVcQou1A25QDW7bbCzr4RAJv2W3U/PIquuWhgGfrRx5kH2rGclX2AJ6ynpttGUkkYBlM6tsL+pq2u0VdH+W2ItTSbON9U4QRKvBlzCfOvWqvgE0iv9dRu64nm1+9fXlAmyCXlcPUf8ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAmdm6LZ4dQwQk62z/DGOSZuQn8hFfzy+5dA90HiBEw=;
 b=xWsxbTvssKhwT2clchcBZhVnK8MzirPVjfUlGa2QiArSaGNzADHLHSyJQ2XXbU3qIRCnu9JFyR2CS9UT/82wRkDCUU5AorOLzB4Jh0gVxFol+xx06Mxs1t+tya6LGY3pMV7169crMWFL9dCgypToctrIlSceGhLsP+rmYTkf1Hw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2852.namprd10.prod.outlook.com (2603:10b6:208:76::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Thu, 8 Jul
 2021 00:11:39 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%4]) with mapi id 15.20.4287.033; Thu, 8 Jul 2021
 00:11:39 +0000
Subject: Re: [PATCH] btrfs: check for missing device in btrfs_trim_fs
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <fce2724eaa78b9666c2ac4f0a1b806ae14c55cd0.1625236214.git.anand.jain@oracle.com>
 <CAL3q7H6yweidJi85pdb-D=iOYTEqoDuRs8wvC3q9W1ng__ewkA@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
To:     David Sterba <dsterba@suse.com>, fdmanana@gmail.com
Message-ID: <829ddc25-e814-460d-4119-8828d64f2ff7@oracle.com>
Date:   Thu, 8 Jul 2021 08:11:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <CAL3q7H6yweidJi85pdb-D=iOYTEqoDuRs8wvC3q9W1ng__ewkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0095.apcprd03.prod.outlook.com
 (2603:1096:4:7c::23) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2PR03CA0095.apcprd03.prod.outlook.com (2603:1096:4:7c::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.11 via Frontend Transport; Thu, 8 Jul 2021 00:11:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 692b1a61-f6c4-4b1b-1ce9-08d941a4f4de
X-MS-TrafficTypeDiagnostic: BL0PR10MB2852:
X-Microsoft-Antispam-PRVS: <BL0PR10MB28521CCA63113166934C650DE5199@BL0PR10MB2852.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: siYhaZjl4TrlUPDUMUbc0naVaDYaQ2cxZWiGZLS9CnAI1ZbcXPqI2av/ISzegzi42hajkbJ3I1BBFBgBgdeSs3AdhaFu1zyTD1FXzxZuEgXFsfAwi81lBWYmWVuCf89uP4NSFQB5BQcKAqVq22e5xmS/slpUUgJ6dopC1CFqrjWzO9etsad4EXb4GImse0oYk0k7r0YRonYO3eKRans4hKu8Ct4xryvddaR4YpKEccKIk7I197T30IJa1MiifQR+5YJ+9pG3UCOkt6wBbH+l64r4uy9wzBc4OmnZAl0DjbXJFvMcw1n9fS4Braui+uqmrBPjlrJ/cTW60d89P3HBRyxj7k+jAY08RsKOm7/kgSioG4/TrTO+tlMf9/elVtvW/3M1vGk2ly/AQKp67AeSWi0izeJFJKvPOPdtQcbonDM3foguwZwx3d/tl6x/QG0Q1iBZ2AWOvAxCWobr7CYvo/JlM21Q160Ky0nM7hccddFgwR2JdggqKO3VnYDVIQuw7w3FAAKJuG6Eag7vBqCPPUW2zHKI27NkcfzrFgqZDe2axDnvc5yP2qK4vsQOZR5GsCi0oWU9u6qPO/NhfMNFdnWmCgSDUKLpboky5ivXkdwBd89aGOEhHhKUN0fRJSrdilsHSNGmkbIWvnQTdNpqcWLjxqqb0kiaj2EdywHoYHNbILL1cJXuFRkk5hlyNXxFYKzo5GZMbDiJ4rLXWBH8R7a54e8ldfYylag1TCBl2lU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(136003)(396003)(366004)(2616005)(316002)(16576012)(956004)(31696002)(86362001)(5660300002)(44832011)(8936002)(31686004)(36756003)(8676002)(83380400001)(38100700002)(2906002)(66476007)(186003)(4326008)(6486002)(26005)(53546011)(66556008)(478600001)(6666004)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2ZOakdrNE5GTUhjbGJmRVVuZStpQ3lNVmE3ck56K1FNSkhGdzN1aHlNZXYy?=
 =?utf-8?B?LzZLcnlLTzlSYnhyNjkvTko2ZStHSG42NXFGUlUrODRzT0h0aHhBNG9iQVpO?=
 =?utf-8?B?VjNyclVGZVlVYmIvNmxyaE1yb3AxWnpYMUh3S3B1amU2SHUraC9JakZuajdi?=
 =?utf-8?B?V0J4Yk1JcE9uVmt4a0FYWmFvWERFZmZTVXg0WjlUYjZ4TEJ4SUdxdEUwMEtp?=
 =?utf-8?B?anhDaFQrTXlKZThHa2E1dXRnb1doMGtkMjJUdW1kUEpzeXAwTDR4cVhSQmNa?=
 =?utf-8?B?TlZUaWxXUVk1S0xTMkYzZkNtaXAvOXE5NGtoelJqTFlGY1pZUGxkQk9SMzZl?=
 =?utf-8?B?R2FWbkhDaVQrWFBZa0dva0wxbG1UbWFQaUoxelQxSThCOHZteFJ3UjNuYzhh?=
 =?utf-8?B?ZzFkT1lISUJEYUdOWkxZV21SR29raUU1MzlDOFYvZWovLzlWdkt0QzFWMnVD?=
 =?utf-8?B?R0M5amZUL0dXOVdhQUl3UDJ6TFJVWkRYOEhkdTBUREJrS0hUeXplWm05Zjg0?=
 =?utf-8?B?Nmozc1BPNmxXUVNoSW1oTTU0THk3bjlOZ2pqTUtobUh5ellpbXZOMFpTRjFZ?=
 =?utf-8?B?QzM3cmNUYzg3MkR1MU00NER6SklMaE9LSEFOa1pYNlJiTmtMOWk0b2kvVW84?=
 =?utf-8?B?WTBIclVxOUR0WHNqdXNxWFFCWWFnVlJNQkM4aUpFQ25CQjhZNFlPZWNPZHJ5?=
 =?utf-8?B?UWhRNHZWVzJtTmc3NXZIYWZVVllhZVZUYktucmVEWStWeE5DWEtobllSM3V2?=
 =?utf-8?B?TUpTUUVWQ2xSUGNsTDZ2Rm1seU5ZQXRKRm1xUlFjNGhFdXdML0VyWFA4YVJo?=
 =?utf-8?B?aWY0aUdPOFJ1ZDNiNU1ZRDFDdWh3UXcvbDhGTUliUk1ISi9yTVl6dkNJdFdY?=
 =?utf-8?B?VXFRUDdNM20zd0kzK0ZEcjBPcUk5bURJNlllenN1QllPUW00SU5zejNUaEM5?=
 =?utf-8?B?MW1LNmJqM3FSeGlwZ3FpUW0yanFDOHJsTVNDQkdZVk5UVnltSzBRd0xLZVVa?=
 =?utf-8?B?RTFndnFpN0N2dGE4bE5WVGRSSExwbU80TGs3SzEwcGNERmZGanFxamIzOWFE?=
 =?utf-8?B?amVFRTgwNVZtTkFsWk91enVzbWJSdE1qa3RZaHJOZk1mYW5idXQ5RU9qcmdo?=
 =?utf-8?B?ck9ZbTdTYlBLYlB6MUhwUzF5WUZRbjhIM2x4eEFOZnhZOTVDcXkzSDZMT1Fn?=
 =?utf-8?B?Ny94WXBPc1NSZDJiRVc5QkhoSjliK1dONHVWSzRweGk5ZFM4RkFCZFAwQ3hE?=
 =?utf-8?B?K2g2YWswM25GUXA3L2lOaE9DT0lYQjBmWkZlZnZNckdFTWs4RUtrTkM3QUk0?=
 =?utf-8?B?WFh4MXg4cjBSNmdrR0hWTkQ4OGI5TjNpWWhHRWU0MXVoZVZyTGl5RmtWRWI1?=
 =?utf-8?B?bUZpampoV25abE9ZaitlS2t1RFVFRFdtcVNtMXBibno4eW5ocm1iTzRKaFFi?=
 =?utf-8?B?NFRhSE5WUjc1a0Q4MThQK0dvbFpWUnFEamthaGF6cHV6ekZHdnlZZklENHN0?=
 =?utf-8?B?SkdZMlB4a3g5OXBFUDBRMmw3a0M4cXFCYmcxTzRDVTRvYmp4Q2RwZGE4cDJj?=
 =?utf-8?B?NWp4SHNwZU9BVVB0WVlrbitZQjFta1JwV1FoZWJwUjMrRHZXMExBQm1oM29n?=
 =?utf-8?B?YWNtWEtyR05vcGIyZ1VZN1BZc1FXYlRyNUZ0Z2VSeVRXVms0UUxXMUxyN3dO?=
 =?utf-8?B?QS81USsrbEMybzNSeU9GWHhpeHIyZnJySHJHU09yTk9jRXR4OU5vdTZYYS9Z?=
 =?utf-8?Q?6L0EgWfmYPw5N9PkdLVyqhVDkiJMVNnSl+yygY5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 692b1a61-f6c4-4b1b-1ce9-08d941a4f4de
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2021 00:11:39.0345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D6jXE7RqLS/hyOjTi9FURcGBpNbzvI2icB/9BtcPLTwaJvxcLCOLhcFW2TY3WxxmnRJ4itaCgBas4G5Ydv1GBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2852
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10038 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107070138
X-Proofpoint-GUID: 2wrikElg2IycEzzx1-NhZhxPap0R7a1I
X-Proofpoint-ORIG-GUID: 2wrikElg2IycEzzx1-NhZhxPap0R7a1I
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/7/21 4:43 pm, Filipe Manana wrote:
> On Sun, Jul 4, 2021 at 12:17 PM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> A fstrim on a degraded raid1 can trigger the following null pointer
>> dereference:
>>
>> BTRFS info (device loop0): allowing degraded mounts
>> BTRFS info (device loop0): disk space caching is enabled
>> BTRFS info (device loop0): has skinny extents
>> BTRFS warning (device loop0): devid 2 uuid 97ac16f7-e14d-4db1-95bc-3d489b424adb is missing
>> BTRFS warning (device loop0): devid 2 uuid 97ac16f7-e14d-4db1-95bc-3d489b424adb is missing
>> BTRFS info (device loop0): enabling ssd optimizations
>> BUG: kernel NULL pointer dereference, address: 0000000000000620
>> PGD 0 P4D 0
>> Oops: 0000 [#1] SMP NOPTI
>> CPU: 0 PID: 4574 Comm: fstrim Not tainted 5.13.0-rc7+ #31
>> Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
>> RIP: 0010:btrfs_trim_fs+0x199/0x4a0 [btrfs]
>> Code: 24 10 65 4c 8b 34 25 00 70 01 00 48 c7 44 24 38 00 00 10 00 48 8b 45 50 48 c7 44 24 40 00 00 00 00 48 c7 44 24 30 00 00 00 00 <48> 8b 80 20 06 00 00 48 8b 80 90 00 00 00 48 8b 40 68 f6 c4 01 0f
>> RSP: 0018:ffff959541797d28 EFLAGS: 00010293
>> RAX: 0000000000000000 RBX: ffff946f84eca508 RCX: a7a67937adff8608
>> RDX: ffff946e8122d000 RSI: 0000000000000000 RDI: ffffffffc02fdbf0
>> RBP: ffff946ea4615000 R08: 0000000000000001 R09: 0000000000000000
>> R10: 0000000000000000 R11: ffff946e8122d960 R12: 0000000000000000
>> R13: ffff959541797db8 R14: ffff946e8122d000 R15: ffff959541797db8
>> FS:  00007f55917a5080(0000) GS:ffff946f9bc00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
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
>>    Create raid1 btrfs:
>>          mkfs.btrfs -fq -draid1 -mraid1 /dev/loop0 /dev/loop1
>>          mount /dev/loop0 /btrfs
>>
>>    Create some data:
>>          _sysbench prepare /btrfs 10 2g 6
> 


> This step isn't needed, it's confusing to suggest the filesystem needs
> to have some data in order to trigger the bug.

That's right. I wonder if David could remove the above two lines while 
integrating? I am ok to send a reroll with this change if that's better.

The test case btrfs/242 contains a non-empty filesystem to test for some 
regression in the future.


> 
>>
>>    Mount with one the device missing:
>>          umount /btrfs
>>          btrfs dev scan --forget
>>          mount -o degraded /dev/loop0 /btrfs
>>
>>    Run fstrim:
>>          fstrim /btrfs
>>
>> The reason is we call btrfs_trim_free_extents() for the missing device,
>> which uses device->bdev (NULL for missing device) to find if the device
>> supports discard.
>>
>> Fix is to check if the device is missing before calling
>> btrfs_trim_free_extents().
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> Other than that, it looks good, thanks.
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>


Thanks, Anand


> 
>> ---
>>   fs/btrfs/extent-tree.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>> index d296483d148f..268ce58d4569 100644
>> --- a/fs/btrfs/extent-tree.c
>> +++ b/fs/btrfs/extent-tree.c
>> @@ -6019,6 +6019,9 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
>>          mutex_lock(&fs_info->fs_devices->device_list_mutex);
>>          devices = &fs_info->fs_devices->devices;
>>          list_for_each_entry(device, devices, dev_list) {
>> +               if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
>> +                       continue;
>> +
>>                  ret = btrfs_trim_free_extents(device, &group_trimmed);
>>                  if (ret) {
>>                          dev_failed++;
>> --
>> 2.31.1
>>
> 
> 

