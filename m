Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B765D3BB58F
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jul 2021 05:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhGED1u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 4 Jul 2021 23:27:50 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:56429 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229652AbhGED1u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 4 Jul 2021 23:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1625455512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9oUOfykJplQeDZiIuy5qjSoNZdrHpRsQwf00lHc0Ti4=;
        b=M02f2fhZguNE083oMzJKEWoWoRRuaP5808of9nk0DlNZBlOwb1t7iSDkDDAVztqRcp7SwO
        6TM2WrxNV/2ioHknWI1O7gUQ5KmJcYXtk8yrGrl4PLYFlUSrHxlwdpa/ipH4t2bCwetLtB
        WZn/gzDOF/K+hCLgfn1c8rx6rNuKH0M=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2110.outbound.protection.outlook.com [104.47.18.110])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-20-U2P7_RpIO2Cz70pQDr2cMQ-1; Mon, 05 Jul 2021 05:25:11 +0200
X-MC-Unique: U2P7_RpIO2Cz70pQDr2cMQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XnkZhrdzHhsiQv3C+V/qNTbLIp57aQX+hFkbfDp4c8cJILez1zTc3Yg8mUDH8cdYMqwsXtdqNDqtqMDPiOk6v1MU0JLb4hrMzCUI69et70Dvsyx+vUS+mTlAOE6pn2D4+OFE+MDNeQnNJVPLORji6fpKkjiM5hxd2mnaq+MT4FzPPZHYrdiazXxtkkbXKvjdWYhtdFA0HBOCIRxJmLVOJ5tQMWC+vZ3QN4ATdA+tbx8mjjrgjhUR1A1QiyHtwRcO7ZEoAuNO8+YCbUIH2DPJPK+7gfZihYyV5+uwDwCiW23Gi/Aac+LwuL5kxTRXEdwnrS1Jcizyxh2peBvbvj5j8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTcQ7i7Rk5zyDoHZL0jDNKKUcnoxuUvUjlIV6GXVypM=;
 b=PPoCdYRa0VV0Ladk3UJq8Zzp7kk0Yy2bKr50fwH6m+kGlJohAbuu8+OpOAK+W5jxpdE0MyVKZzVwYWgyDZMzG1qtxL+W5Podkjd+16aykvuKnf0irntzdc3NC8guvI1IaTxlwoYUPOQRNMYMLrbU0Px0Ak6PuaKK5UmA8bpLOKt18WVLDd22Uh617atRYqOJXYYJhLdYmlDWfQgeLxBIu7ZrFxEU8Ks3QnVKAzva7t+sIH5pcIT3xXJLqHJWp7IASHrrBpNi0Ox521NbdTwSsKDhtLB+me0wi/GVr0vka789HTwvdP0sMf8X3z8LRHYbS5E4yQC2av/1FfQ1jw3+yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB5287.eurprd04.prod.outlook.com (2603:10a6:20b:7::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Mon, 5 Jul
 2021 03:25:11 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65%3]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 03:25:10 +0000
Subject: Re: [PATCH] btrfs: check for missing device in btrfs_trim_fs
To:     Anand Jain <anand.jain@oracle.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <fce2724eaa78b9666c2ac4f0a1b806ae14c55cd0.1625236214.git.anand.jain@oracle.com>
 <9786b027-e380-6286-4ec9-e28d7c6d46f1@gmx.com>
 <ca245597-393b-39da-f0f7-5daf9f14c5ca@oracle.com>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <a76ffb89-66d6-c971-96e6-1fd7c3044dec@suse.com>
Date:   Mon, 5 Jul 2021 11:25:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <ca245597-393b-39da-f0f7-5daf9f14c5ca@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BY3PR10CA0008.namprd10.prod.outlook.com
 (2603:10b6:a03:255::13) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY3PR10CA0008.namprd10.prod.outlook.com (2603:10b6:a03:255::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Mon, 5 Jul 2021 03:25:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73c6d9d6-6e38-418f-bd87-08d93f647ec9
X-MS-TrafficTypeDiagnostic: AM6PR04MB5287:
X-Microsoft-Antispam-PRVS: <AM6PR04MB5287A82356433C537917E31AD61C9@AM6PR04MB5287.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:466;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dOwcTrR3DJKtDbUdTYYJf/fguyTV5/XveOKkTDY1UKNBv9eTOZdg8N7KbT65WHxAtXfzXymLqUC/cXIIQ57/jrFTrSLQQrNa1KwDS1XYxzth9GftfyV05ZV1fqXkPXxmXRYaCuXSV2bUJJ2KjU4I+UNevS8+0bTsd7obwY+0tazgjbbo1QSdbX5oGNP4zEFdb8edIGMofnrD/BurNb2pEwU8JWGWuydkRMENdCN+v+NNIL/i740FcJ287z0PHWj4LRPF6TFVTLkVbqUpV9ynFTtCmpVermJgIXrPqvuOl8ccwd5/knQe0ToRoFBdubt3QtcKy+4rg2P0ZSB3A8hOEmFQysdlTYBwhB4ag/hAU/LISmUEtk+duPW3Rek0ghJXssFau+y47wsyfss150VAIf9D87xCdEN6UMWJhKKdb46Oh4bashqEAnkwCxOghVSB1qOMEgv7sF2Amgvi4HkDRaLoxucgGr8FWPYljYtWcnePYV3+bY2VPg9DSM1bIiOcTsH68lzaMhiJ5qpQuKYKeOKcrf8He4mRKU+NZ5OHTR77qyxGexkULKKy/VG2uFZqdhoDE1UlSFOQ3hKslowUfIFgcoAaytL2Ekfye97P50KJzuD8B3DPcBuy5BrB1ma6hrTKWXyweySIzCvMbnCGhysjUXiLtikRsPIag1RtMa5guJVqpXCrHLkaX5fWOxnFDbn6tpRmLAkL9fLoITLXft4FU1yj1+BogIBXgZBEK5thhLOVg3/NCnUFN62/ra2t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39850400004)(366004)(396003)(136003)(478600001)(2906002)(83380400001)(16526019)(316002)(86362001)(53546011)(38100700002)(36756003)(31696002)(31686004)(5660300002)(66946007)(66556008)(66476007)(186003)(110136005)(8676002)(6486002)(16576012)(8936002)(956004)(6706004)(6666004)(2616005)(26005)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2s/goQnh1nfeawRNeKCD8oudRFI5Z6kwtxzGiN8QkWY9yTJQXRgbZpRUMiGK?=
 =?us-ascii?Q?PWGX4H4JocVydKixM04RcYXINNM86DaDHdoSD0N4Uk+ZGzbwS6P0jB2tSfbN?=
 =?us-ascii?Q?wKnZEkZdFJ2D3Dj97Dj4JyyNDsbnNK8vzhFPI3lsksMPOEZxEQzOEdn+GOJ6?=
 =?us-ascii?Q?71OhJWiDoD+dF6IEQGeK93J5iREMX4YrDetZj66O0xu5oSzxQCHqGBFCTO6c?=
 =?us-ascii?Q?nFgrMvqeQQq6rhRvotvc+SXg/GWCX66Scb38hTM5VO9qTnnzEekiev5T663K?=
 =?us-ascii?Q?5WBgVhJbpMN6rC0LZX5RDTgXahFkrzrR9MDF/yu/jnez38qKYJTLxaynMHbS?=
 =?us-ascii?Q?15t/1gKb/+M/LRlaVDsbktZ/FMGP6oc84QJNB0M/GObOY4rFEAHn5FwTdtsT?=
 =?us-ascii?Q?18RmRd2i3vIEYjpRIrNT2JvVSM2bOYzezD0MCLs0xv/yE9/WsbDC05LAfbYA?=
 =?us-ascii?Q?xFUbDkAO97Ejaqbsj+lr+P/1npH4PADfMwFIsXrZLdXCnTyXNUGiRXYb6ZVR?=
 =?us-ascii?Q?ibMfWhvD3QKDgAokxqSgidtUz1NHmZ9ZFi+9sz4Weme3ckMMNdUa6f773gKX?=
 =?us-ascii?Q?sGq1RDp97DoHbL4ia/xMVsCgWWv3O6UqrnZxVcBv28Liu1ypojTfE8aMOgse?=
 =?us-ascii?Q?8zNWjd2l1bGyP1Szb3L+JpJRdLBdfVBeXGYES7TLeEv2zQ9yA/JILfOgo5NS?=
 =?us-ascii?Q?AVPjjnjalYLc/8FHHQPrqLYlAiTlqhRtoZTr5J3MKBPx3D8lFesklgbGHmVa?=
 =?us-ascii?Q?pNS+U7e1lAQ0QAOeO3qaZ+WC4pKP4rid1ZQDlDhRDjII4NJYlTYY9ALZ11VX?=
 =?us-ascii?Q?DqiZBYMIr1exQjYbY8oVChg/760tWaY2L6b1c+NT9nRw2WRaSkTkM9tNtK2x?=
 =?us-ascii?Q?sAM54+VxAT8OYi7jhyBku5GJFvbCgs4IMXu22e2eaQ2XWBPZi6c+l1b8ym0p?=
 =?us-ascii?Q?N/+jplX5c0LSOvcENnwXKfDuDz23ekJ7TyquX/4cRa5zwyp2Aqw408ZHD3hX?=
 =?us-ascii?Q?utMPHXW7ihQcUWzyqGie8eCatRE45A7G9ud9tZQeVK8evcnjVFMOAPxKoGuO?=
 =?us-ascii?Q?tZ1B+VvNWQB4ZA8ixN9kRkdTdskU32shEuxt0QYv21LodeYNwOuuIDsk24Xo?=
 =?us-ascii?Q?QtRBdLgF/fmdGceK3jMYkjUEzfPoAhWX7IqZBY2MaHSS2QZssVuqII56d19w?=
 =?us-ascii?Q?ywUi9u4gMDzAZIXobAsy+hV1FyGgQFsoXzj3q1ZZcQsRyEr1Zb4AH7Be5Giz?=
 =?us-ascii?Q?IBrEhp74wyf7y2/13nDWaBhkP8DSa2coUpwTXoNO5/9Haf+M5kovZKcmlslh?=
 =?us-ascii?Q?bLqR4bYbHvr+aJeMGcsm1oNn?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c6d9d6-6e38-418f-bd87-08d93f647ec9
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2021 03:25:10.7240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WDjFg7/uV7AodL8QyDzMUjZizVyJqjrjIbMSBg0T0TS2rIqzQ2YIOGNXoZP9kPbn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5287
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/5 =E4=B8=8A=E5=8D=8811:21, Anand Jain wrote:
>=20
>=20
> On 05/07/2021 08:12, Qu Wenruo wrote:
>>
>>
>> On 2021/7/4 =E4=B8=8B=E5=8D=887:14, Anand Jain wrote:
>>> A fstrim on a degraded raid1 can trigger the following null pointer
>>> dereference:
>>>
>>> BTRFS info (device loop0): allowing degraded mounts
>>> BTRFS info (device loop0): disk space caching is enabled
>>> BTRFS info (device loop0): has skinny extents
>>> BTRFS warning (device loop0): devid 2 uuid=20
>>> 97ac16f7-e14d-4db1-95bc-3d489b424adb is missing
>>> BTRFS warning (device loop0): devid 2 uuid=20
>>> 97ac16f7-e14d-4db1-95bc-3d489b424adb is missing
>>> BTRFS info (device loop0): enabling ssd optimizations
>>> BUG: kernel NULL pointer dereference, address: 0000000000000620
>>> PGD 0 P4D 0
>>> Oops: 0000 [#1] SMP NOPTI
>>> CPU: 0 PID: 4574 Comm: fstrim Not tainted 5.13.0-rc7+ #31
>>> Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox=20
>>> 12/01/2006
>>> RIP: 0010:btrfs_trim_fs+0x199/0x4a0 [btrfs]
>>> Code: 24 10 65 4c 8b 34 25 00 70 01 00 48 c7 44 24 38 00 00 10 00 48=20
>>> 8b 45 50 48 c7 44 24 40 00 00 00 00 48 c7 44 24 30 00 00 00 00 <48>=20
>>> 8b 80 20 06 00 00 48 8b 80 90 00 00 00 48 8b 40 68 f6 c4 01 0f
>>> RSP: 0018:ffff959541797d28 EFLAGS: 00010293
>>> RAX: 0000000000000000 RBX: ffff946f84eca508 RCX: a7a67937adff8608
>>> RDX: ffff946e8122d000 RSI: 0000000000000000 RDI: ffffffffc02fdbf0
>>> RBP: ffff946ea4615000 R08: 0000000000000001 R09: 0000000000000000
>>> R10: 0000000000000000 R11: ffff946e8122d960 R12: 0000000000000000
>>> R13: ffff959541797db8 R14: ffff946e8122d000 R15: ffff959541797db8
>>> FS:=C2=A0 00007f55917a5080(0000) GS:ffff946f9bc00000(0000)=20
>>> knlGS:0000000000000000
>>> CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 0000000000000620 CR3: 000000002d2c8001 CR4: 00000000000706f0
>>> Call Trace:
>>> btrfs_ioctl_fitrim+0x167/0x260 [btrfs]
>>> btrfs_ioctl+0x1c00/0x2fe0 [btrfs]
>>> ? selinux_file_ioctl+0x140/0x240
>>> ? syscall_trace_enter.constprop.0+0x188/0x240
>>> ? __x64_sys_ioctl+0x83/0xb0
>>> __x64_sys_ioctl+0x83/0xb0
>>> do_syscall_64+0x40/0x80
>>> entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>
>>> Reproducer:
>>>
>>> =C2=A0=C2=A0 Create raid1 btrfs:
>>> =C2=A0=C2=A0=C2=A0=C2=A0mkfs.btrfs -fq -draid1 -mraid1 /dev/loop0 /dev/=
loop1
>>> =C2=A0=C2=A0=C2=A0=C2=A0mount /dev/loop0 /btrfs
>>>
>>> =C2=A0=C2=A0 Create some data:
>>> =C2=A0=C2=A0=C2=A0=C2=A0_sysbench prepare /btrfs 10 2g 6
>>>
>>> =C2=A0=C2=A0 Mount with one the device missing:
>>> =C2=A0=C2=A0=C2=A0=C2=A0umount /btrfs
>>> =C2=A0=C2=A0=C2=A0=C2=A0btrfs dev scan --forget
>>> =C2=A0=C2=A0=C2=A0=C2=A0mount -o degraded /dev/loop0 /btrfs
>>>
>>> =C2=A0=C2=A0 Run fstrim:
>>> =C2=A0=C2=A0=C2=A0=C2=A0fstrim /btrfs
>>>
>>> The reason is we call btrfs_trim_free_extents() for the missing device,
>>> which uses device->bdev (NULL for missing device) to find if the device
>>> supports discard.
>>>
>>> Fix is to check if the device is missing before calling
>>> btrfs_trim_free_extents().
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>> =C2=A0 fs/btrfs/extent-tree.c | 3 +++
>>> =C2=A0 1 file changed, 3 insertions(+)
>>>
>>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>>> index d296483d148f..268ce58d4569 100644
>>> --- a/fs/btrfs/extent-tree.c
>>> +++ b/fs/btrfs/extent-tree.c
>>> @@ -6019,6 +6019,9 @@ int btrfs_trim_fs(struct btrfs_fs_info=20
>>> *fs_info, struct fstrim_range *range)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&fs_info->fs_devices->device_=
list_mutex);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devices =3D &fs_info->fs_devices->device=
s;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_for_each_entry(device, devices, dev=
_list) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (test_bit(BTRFS_DEV_STAT=
E_MISSING, &device->dev_state))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 con=
tinue;
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_tr=
im_free_extents(device, &group_trimmed);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 dev_failed++;
>>>
>> Won't it be better to put the check in to btrfs_trim_free_extents()?
>=20
>  =C2=A0Fail early is better. Also there is only one caller for=20
> btrfs_trim_free_extents().

I mentioned this because there are already some other checks in=20
btrfs_trim_free_extents(), thus it may be a good idea to put them there.
>=20
>> And maybe it's better to also check device->bdev, just in case we got
>> some strange de-sync between DEV_STATE_MISSING and NULL device->bdev
>> pointer.
>=20
>  =C2=A0I can add NULL device->bdev check for now. It is a pending cleanup=
 as=20
> a=C2=A0 whole to use one of it, and I am sure DEV_STATE_MISSING only will=
=20
> suffice.
>=20
>  =C2=A0I will wait and see if there are any more comments before sending =
v2

Yeah, despite that, the patch looks pretty fine to me.

Thanks,
Qu
.
>=20
> Thanks, Anand
>=20
>> Thanks,
>> Qu
>=20

