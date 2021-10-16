Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3FB4305A1
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Oct 2021 01:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241172AbhJPX33 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Oct 2021 19:29:29 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:27758 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241099AbhJPX33 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Oct 2021 19:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1634426839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fO0XSDdZeqGXmsyPRjEBHIYvzhCcsAzP1cC0BqzpJR0=;
        b=fJ1wMnfQ6cG+kuXeVEeDWwMHnjHQhvCvE7VC+C/rVpbVWce5Ecm65h8g7ZBuqSVzWsIyg6
        uF4+ISKXLSsJhqgrZ2UMPlEx7E5daima8ikLb6GU4sIkS6jTEhZ9AnrPa0o2SJrQwngm4h
        CyMn7JZ8Iy2nTdrk9jQAakNY+klQiV0=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2111.outbound.protection.outlook.com [104.47.17.111])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-8-D6c9kqvzNtO3XG65XdFhxg-1; Sun, 17 Oct 2021 01:27:17 +0200
X-MC-Unique: D6c9kqvzNtO3XG65XdFhxg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3ce5gXn59D8i/Kv9JeDlDG6F4yOjS4fvERAdy7++jhY+WIQCgS/8zTX3n9FbRMWQSsUymJe1ulTi3k081kSXYiitgoz8DuNbzuVw6aEfWyUF39xs7SZhYUbg88Tll8D9X8FYGNVrxlSkKWRdIBqsSzI87X+LTlwAnQioNTy2T58QToKjrEEbUx/yFI35Id94eh9hcysNGjvw+mdpDNT5UHTGDjwKUS3xSR6JbOYiwWWRpxkoxA47L7/lGPSOeSd4d1TCCwQR+nMupNEKjELIgJyuKQ5W1exeondY4XNg78CYsFQ3XXJma/lSOw9d3kt0CwIKWo2KGHwBcukGtJX2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fD+Xob1htFuHoUD4oysgzCL0vi7zNEmMmvNDj5MrIUU=;
 b=QYgmyRwOAIN2CuTQfqLS8FHCWh4T09IOfyKp1hySx1UEzCI1pMDqg2DIgmocECz80zjvt9afPB0gKTM6PX4lWAvCxnq/twtz7WcwJAxGNtYvOe/y7/YYKO1Wa/OdTIkftHqvUL96OI6MeZZOS/1MxPz8/OhQRKUQ49ivbDv0PEwIApxV2NF7Lbz/MeVTTb+MHCzKXccRZ4DRiGV6WgCK4irTTFEDRdkvghl2J00mPcY/4AxGogv78vKUFlYQ7iKCr4veD3eizmZVadSiEBbgchRQTfQ3D1TOfxAmVgxoyV/BQo4j0Mzpo+5Og9mYZPDDsc80srT8f0kPUvbBbNSvuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: icloud.com; dkim=none (message not signed)
 header.d=none;icloud.com; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM5PR0401MB2562.eurprd04.prod.outlook.com (2603:10a6:203:3a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15; Sat, 16 Oct
 2021 23:27:16 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::2d84:325b:5918:7a19]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::2d84:325b:5918:7a19%5]) with mapi id 15.20.4608.018; Sat, 16 Oct 2021
 23:27:16 +0000
Message-ID: <7bd9c183-91b9-c646-5e22-8bc9d138f15f@suse.com>
Date:   Sun, 17 Oct 2021 07:27:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: need help in a broken 2TB BTRFS partition
Content-Language: en-US
To:     Christian Wimmer <telefonchris@icloud.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
CC:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20191206034406.40167-1-wqu@suse.com>
 <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
 <762365A0-8BDF-454B-ABA9-AB2F0C958106@icloud.com>
 <94a6d1b2-ae32-5564-22ee-6982e952b100@suse.com>
 <4C0C9689-3ECF-4DF7-9F7E-734B6484AA63@icloud.com>
 <f7fe057d-adc1-ace5-03b3-0f0e608d68a3@gmx.com>
 <9FB359ED-EAD4-41DD-B846-1422F2DC4242@icloud.com>
 <256D0504-6AEE-4A0E-9C62-CDF975FDE32D@icloud.com>
 <e04d1937-d70c-c891-4eea-c6fb70a45ab5@gmx.com>
 <8B00108E-4450-4448-8663-E5A5C0343E26@icloud.com>
 <bd42525b-5eb7-a01d-b908-938cfd61de8c@gmx.com>
 <12FE29EC-3C8F-4C33-8EF3-BD084781C459@icloud.com>
 <4d075e71-be3c-cc41-bbf4-51d255e25b2b@gmx.com>
 <B57D8AFF-FE6E-4CC2-B6C1-066F3A8CEDF0@icloud.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <B57D8AFF-FE6E-4CC2-B6C1-066F3A8CEDF0@icloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0163.namprd03.prod.outlook.com
 (2603:10b6:a03:338::18) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0163.namprd03.prod.outlook.com (2603:10b6:a03:338::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Sat, 16 Oct 2021 23:27:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0d8328e-16e4-49b2-315b-08d990fc7da3
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2562:
X-Microsoft-Antispam-PRVS: <AM5PR0401MB256250CB631018615341677DD6BA9@AM5PR0401MB2562.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tTMa2eZYe1GT0FjERqa5HA1npw/eFyilUdk7IDgZd6cqmp0t5noEctIUYe/bnFtmlyREQ5OvjfwyBSj/oIZ6mT3SHOy0zr2YGq96bV2+K+idvoDnYIBZZYikAkvx24Kg4LRdt6R3XWii6/L/4Gs8DFvWas+Q9nZr+LKMBX1NJifs7uLDrXjcuLjwL2bWfamTXIhA7QgRIITVEeNLPM8tfsasTGtsUo00oxfgfoAGGQqlqYvccnZWAiFXeRmneTGvNhkGQEJFZUcN/D97n5bwFxJtez1JTYm8DjWPCAcSYG41nnVE3DPQ006JVp+nl5Qalq1zzVFkBYd41cJcyBFP3Nb5emapIRUWPczTqeW9FMFmaeuTxx6VxFKl4S6BvJuutsjF4tMXNihJ1NxfW801JnHHRkvH4LzzB78lszOpZJbvEzgLBMwfBNyrIWC0kGE9FzPRQC9WWMvltveZECHQ8cs0m2C3ixK6bJ0R2gbbDE+tIACvN814cwBr7bj/MezFj14kND81i8bK6cZCImUYKxn2HvzUzv6zZVYtwPydnlZ7rPJvGY6NoMd02DtN9z3gFn4fCUSYxYH/A6xUHE02LCJ0L4TLTG3trwriNgQ3fL42jPgMfgeF+Qr0sXcYfgjaFdltJ8TnlUM61z8izp5OiUH8BXHkQCrnEEfJCDtaXiVkSPvg0xLdQuKSyoottIp8RI3YI1JqZ9HoCzgR4EMS0A6vNMHKdMa4BuA11Ow7uIozp+i7kP7P9P4CCDjmHsJeWqkEfSXfrJ8374jrYAej8zMrJMyHNs1Jhb/IBBs+tgM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(956004)(8936002)(26005)(186003)(5660300002)(53546011)(110136005)(6666004)(38100700002)(54906003)(2616005)(4326008)(66476007)(6486002)(66556008)(16576012)(66946007)(2906002)(83380400001)(316002)(36756003)(6706004)(86362001)(31696002)(8676002)(31686004)(518174003)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sBgPQwDKSVcExACdtutBDJ8UlliRusNJ/DzkXcGxWwfwqLRQR0akjbUgUp1Q?=
 =?us-ascii?Q?IlOlcnRtFv3yGk0L/0Vzfz10x6lsH8kkArtqjzKc+39uNF+j3ndUkR21Hyec?=
 =?us-ascii?Q?UhBYdnMjNctdEQRO38hzjHuimJl+0e8gKGQvUJnzOP6JEQLllngYCZYDMuvu?=
 =?us-ascii?Q?Q+f7+wsYOeH4i8Xb7I7RNQXrMJvxo0k2a5a74/d8vqc51e1meXSLM2bJat1W?=
 =?us-ascii?Q?Y7oHSFGC2Nx0NktOPgVnmVNdp5iidaL7bQtdpZnCaE6Iegnkbd0Pq4zuTElk?=
 =?us-ascii?Q?3KwjPB6o76ctiwax8V+goxJiAmfkMtQRHJmp/0hLK6Efk/ObxpN8Eo/6d8YP?=
 =?us-ascii?Q?ZLzTE87qbqF9FpG/B3qQKacgYpl8R4LdZgrf/uLwF77xcZ6iOC/aSY75kewk?=
 =?us-ascii?Q?ILiDpDXkEnERgUTn52I6SQ24oEbImgBu4CvjZaPtlohxLRoimWTq1fUh3Jvh?=
 =?us-ascii?Q?0DOzgq2O9Gl2qQzK8tDMUOH4nzLpZZbN6aMn/cxEG/w9BEa6x+cSHhWosiSr?=
 =?us-ascii?Q?g/vQqiXFyE2ldyqVTDr1LgX+g3xVnnWDjef8stQZaY62R9pUGtGi52CTDkUh?=
 =?us-ascii?Q?QLORWWjCiDZKzRzL3clIYI0MXFnB75P4QwkM6krruXOi9VHsmAGT1cpf44CX?=
 =?us-ascii?Q?DYA2QkAbI1a3+TiQOiJvx1jK35OMVooUtJsvvdZDv7fJCwA/aV6EQr8li0bs?=
 =?us-ascii?Q?qEoBBxHu3EecyKmy5gLpKTLLQF9D42O9Ge9AKQtte0wbmmpLtD5s29D4Zp9e?=
 =?us-ascii?Q?4vMRZ+GUgm0OEJh+Ax/9PzijNB78y4LitoFICWkFvgdMaoZPcE2bqnrbHP6A?=
 =?us-ascii?Q?hqVptiMBSSJEtIDix8IbPiGHfiVZu+7ntIH3hv0y7dzw6a52RjN0Dm0W1FX2?=
 =?us-ascii?Q?WSNPQL3Y7zq0ytQY86Nd6iQexFGNpNYHK/gSGu2zZIS6/xfS3MX3yxHYzWWv?=
 =?us-ascii?Q?gfUiwI0cTZGo9gjVm4Jz3Q0dWqCLmBLuLeTbJuW/CmEnrqoa1NN4EGLvOmZm?=
 =?us-ascii?Q?vqIPGuDowA5i+k884guKc2q2GK9GQlvstzDf/h+SB0xFzgi6oqQmnslLal6s?=
 =?us-ascii?Q?d+xSkfPTG9WHm9FyX7qWdnhk4QoRu0zQy0ks8mWtHM28409xJ1rNv/Cs8pCK?=
 =?us-ascii?Q?Ky5fX5Ln1VJxusJVqkYZayw9N6uaVGatXnOOm5QueAGTiXlsRumC70+eZ7DA?=
 =?us-ascii?Q?mxS9GJ6mL5xMczmKAY5ceBSGMmNOOpr1b/bFL6Eqy1MJ1i7HaqukgOLdhrDg?=
 =?us-ascii?Q?4k/vgOHfOPS9Sg1H59VI78fZdiR3rlD/7ugYHgrjeq/R4HjMWvxqUBA6xh9p?=
 =?us-ascii?Q?QVrKmHnafvPJfjgEr4Gi8YR4?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d8328e-16e4-49b2-315b-08d990fc7da3
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2021 23:27:16.5174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ujQA9ttgienT/CijFXn6HEk9nothSmTMhuHdvMYqdJ053T6e6YV5x3yHQTXq3Xqu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2562
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/17 01:35, Christian Wimmer wrote:
> BTW, due to some unsuccessful boot attempts this disc /dev/sdd1 does not =
work any more with =E2=80=9C-o ro,rescue=3Dall=E2=80=9D
> so I decided to try some nasty commands like the following:

Well, any attempt to do any write into that fs would only further=20
degrade the fs.

>=20
>=20
> Suse_Tumbleweed:/home/proc # btrfs rescue chunk-recover /dev/sdd1
> Scanning: 4914069504 in dev0cmds/rescue-chunk-recover.c:130: process_exte=
nt_buffer: BUG_ON `exist->nmirrors >=3D BTRFS_MAX_MIRRORS` triggered, value=
 1
> btrfs(+0x1a121)[0x55830a51d121]
> btrfs(+0x508dc)[0x55830a5538dc]
> /lib64/libc.so.6(+0x8db37)[0x7fa8984cbb37]
> /lib64/libc.so.6(+0x112640)[0x7fa898550640]
> Aborted (core dumped)
>=20
> Unfortunately the program crashes. Is this expected?

No, but it doesn't matter anymore.

The problem would not be chunk tree related afaik.

>=20
> What else can I try if the mount command reports:
>=20
> Suse_Tumbleweed:/home/proc # mount -o ro,rescue=3Dall /dev/sdd1 /home/pro=
mise2/disk3
> mount: /home/promise2/disk3: wrong fs type, bad option, bad superblock on=
 /dev/sdd1, missing codepage or helper program, or other error.

Dmesg would provide the reason why it fails to mount.

Thanks,
Qu

>=20
>=20
>=20
>=20
>=20
>> On 16. Oct 2021, at 07:08, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> On 2021/10/16 05:01, Christian Wimmer wrote:
>>> Hi Qu,
>>>
>>> I hope I find you well.
>>>
>>> Almost two years that my system runs without any failure.
>>> Since this is very boring I tried make my life somehow harder and teste=
d again the snapshot feature of my Parallels Desktop installation yesterday=
:-)
>>> When I erased the old snapshots I could feel (and actually hear) alread=
y that the system is writing too much to the partitions.
>>> What I want to say is that it took too long (for any reason) to erase t=
he old snapshots and to shut the system down.
>>
>> The slow down seems to be caused by qgroup.
>>
>> We already have an idea how to solve the problem and have some patches
>> for that.
>>
>> Although it would add a new sysfs interface and may need user space
>> tools support.
>>
>>>
>>> Well, after booting I saw that one of the discs is not coming back and =
I got the following error message:
>>>
>>> Suse_Tumbleweed:/home/proc # btrfs check /dev/sdd1
>>> Opening filesystem to check...
>>> parent transid verify failed on 324239360 wanted 208553 found 184371
>>> parent transid verify failed on 324239360 wanted 208553 found 184371
>>> parent transid verify failed on 324239360 wanted 208553 found 184371
>>
>> This is the typical transid mismatch, caused by missing writes.
>>
>> Normally if it's a physical machine, the first thing we suspect would be
>> the disk.
>>
>> But since you're using an VM in MacOS, it has a whole storage stack to
>> go through.
>>
>> And any of the stack is not handling flush/fua correctly, then it can
>> definitely go wrong like this.
>>
>>
>>> Ignoring transid failure
>>> leaf parent key incorrect 324239360
>>> ERROR: failed to read block groups: Operation not permitted
>>> ERROR: cannot open file system
>>>
>>>
>>> Could you help me to debug and repair this please?
>>
>> Repair is not really possible.
>>
>>>
>>> I already run the command btrfs restore /dev/sdd1 . and could restore 9=
0% of the data but not the important last 10%.
>>
>> Using newer kernel like v5.14, you can using "-o ro,rescue=3Dall" mount
>> option, which would act mostly like btrfs-restore, and you may have a
>> chance to recover the lost 10%.
>>
>>>
>>> My system is:
>>>
>>> Suse Tumbleweed inside Parallels Desktop on a Mac Mini
>>>
>>> Mac Min: Big Sur
>>> Parallels Desktop: 17.1.0
>>> Suse: Linux Suse_Tumbleweed 5.13.2-1-default #1 SMP Thu Jul 15 03:36:02=
 UTC 2021 (89416ca) x86_64 x86_64 x86_64 GNU/Linux
>>>
>>> Suse_Tumbleweed:~ # btrfs --version
>>> btrfs-progs v5.13
>>>
>>> The disk /dev/sdd1 is one of several 2TB partitions that reside on a NA=
S attached to the Mac Mini like
>>
>> /dev/sdd1 is directly mapped into the VM or something else?
>>
>> Or a file in remote filesystem (like NFS) then mapped into the VM?
>>
>> Thanks,
>> Qu
>>
>>>
>>> Disk /dev/sde: 2 TiB, 2197949513728 bytes, 4292870144 sectors
>>> Disk model: Linux_raid5_2tb_
>>> Units: sectors of 1 * 512 =3D 512 bytes
>>> Sector size (logical/physical): 512 bytes / 4096 bytes
>>> I/O size (minimum/optimal): 4096 bytes / 4096 bytes
>>> Disklabel type: gpt
>>> Disk identifier: 942781EC-8969-408B-BE8D-67F6A8AD6355
>>>
>>> Device     Start        End    Sectors Size Type
>>> /dev/sde1   2048 4292868095 4292866048   2T Linux filesystem
>>>
>>>
>>> What would be the next steps to repair this disk?
>>>
>>> Thank you all in advance for your help,
>>>
>>> Chris
>>>
>=20

