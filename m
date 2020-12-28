Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670BD2E34D8
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Dec 2020 08:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgL1HwT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Dec 2020 02:52:19 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:20168 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726363AbgL1HwT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Dec 2020 02:52:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1609141869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wYDzFny9kPJrAu3RS2+uX499Pu5iJSwUQpJSTcoDjmc=;
        b=cQjvHz8K1WUgT0VHEFlowoqZZr75ArfF6T0n0LydLav+reS0wCByjlkxSU2cCyMhWPm/vj
        BbgsSRfW7n0qTDVN4zpk7iFZkgrd/FZXMoJO1C9V6J29rkGtzeg57JdK6Mwavjwagw39BZ
        R3Kk1tDdthhJaA+tdFYwAbZyolViaYs=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2177.outbound.protection.outlook.com [104.47.17.177])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-23-lvKx3NDKM46OTzUTajSWtw-1; Mon, 28 Dec 2020 08:48:59 +0100
X-MC-Unique: lvKx3NDKM46OTzUTajSWtw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Do6/6tZULyKuWrLRwrM1FtjAQO0TZrMtHrtsd6oPKVkOvPPOxDhVQ+0MvCMRV1lN8RnSf5Hd832tBY762r7fTNOSwm+YAlwwXRl5ubzXalZPLYb5br0Foqk50gS7lsOT2bsg69s8r6pcBW69Mhe1fEdzMtJpcVp0ivtnh/mGFy16PO8T9sXLu+QNqv/VUGqwKrPJ4nAfAdVK019F3HsRh/sonBHKwv9LXCBe2TRm36DJ3QU2hcXNkZaHdrldLmQHepULU/A1XBzJ15+q9x3EUsG7jy79RyXZSL3ApZ/Ahr/YEuV8TKa8ZtUko3K6xnaEJTL9VGu6e9XrBv8Ph8Azmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOBN3omXXdqvcf/lYP8nZkheRK1ENLIcy1pC2r6PsEI=;
 b=I0jO5/UivnE3x7jIoNKATZt/VBrsUOhRDkKN0IeZq2LpqJNitLhbbMbm5C0ow9YVit648LNzWpTbP6ZtOGuPOSfr4Z6V7NXs1y4ZOolOtBjq4hOkr5VYwQxy21vGb8c3/6xGeEMFeGgNbKBgN016fWGR6XAaab6KhwHzw9JtR9hlX7B2R8eFmtCoZgX2LLvZ8FjI6udpva26qy/xUwCaQE4UuPfzX0bkHLE24eI5GsEaJbSW/V2Fp2PZOc/QE/pea9QW27Lhv+CKMbNFtjiAVRgnlwWOJD4TlQrnFigLqivjoXcMiuaIcvShoH/WY77B6ICdB/t1FyacLDJ0XX592w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19)
 by PA4PR04MB7821.eurprd04.prod.outlook.com (2603:10a6:102:c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.30; Mon, 28 Dec
 2020 07:48:58 +0000
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::397a:950:d8c8:d709]) by PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::397a:950:d8c8:d709%6]) with mapi id 15.20.3700.031; Mon, 28 Dec 2020
 07:48:58 +0000
Subject: Re: 5.6-5.10 balance regression?
To:     David Arendt <admin@prnet.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        =?UTF-8?Q?St=c3=a9phane_Lesimple?= <stephane_btrfs2@lesimple.fr>,
        linux-btrfs@vger.kernel.org
References: <505cabfa88575ed6dbe7cb922d8914fb@lesimple.fr>
 <292de7b8-42eb-0c39-d8c7-9a366f688731@prnet.org>
 <2846fc85-6bd3-ae7e-6770-c75096e5d547@gmx.com>
 <344c4bfd-3189-2bf5-9282-2f7b3cb23972@prnet.org>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <da42984a-1f75-153a-b7fd-145e0d66b6d4@suse.com>
Date:   Mon, 28 Dec 2020 15:48:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <344c4bfd-3189-2bf5-9282-2f7b3cb23972@prnet.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR13CA0207.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::32) To PA4PR04MB7533.eurprd04.prod.outlook.com
 (2603:10a6:102:f1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR13CA0207.namprd13.prod.outlook.com (2603:10b6:a03:2c3::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.14 via Frontend Transport; Mon, 28 Dec 2020 07:48:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6c55bfe-4f0a-4268-d79d-08d8ab0508ab
X-MS-TrafficTypeDiagnostic: PA4PR04MB7821:
X-Microsoft-Antispam-PRVS: <PA4PR04MB7821C8D3085EF1B22A0CEBB0D6D90@PA4PR04MB7821.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LndfgUhdzwfEq94VVSsrly8r3Ix74jRNgdrAcw6M6GDs6I3X6nwfsEi5e8qa5AcFPOdRaTTayHXrG3tvJAht1ntacy+7UiP9T40yCWJfzeEiFjwjlGzpV7l1/QjDB9z2FEcKoZJAS4Q7IesIoSIVmJcYlVL5eXUtgnkwC6ep6sNPU2MoV8ZVaoj11fru5cJ2aUvH59eBWwiKRfyA/AjMQ8cydS4mMNZrGBwFYfPde9eezyzZ+MWyW7iCoMx8CAmsaudl+X3WmyvadQVM8Xh93pShCTubyJ2q1JHTmIPuE3vRpJvlIb036/KVRLvDg5iz5Xn4tiMve4EuuKqKp7wENnninZ8aLb2M190wtjRwER7MO4Zj89C3D2iBLrOBqByvsxjihP7SM7iu5LkSwG9I1edqlWePg3den5guE0Qu808iBsbSqaP5wFnf9D1/Td4Sxkf9erDq7IKoXnZzAScRpu+1A7vEGw7Q3DU7Z9fPrI/9vLRl017JVjfidu7mJTms6KfG2FuRhiGpguJ+j5GKWkK0Q1eoKXx8uTHMUlfTedlgdJ/iJRPpmRuNbUKdKiL/4WNRHxzJpkuv701G8A79rkxQkqRjY/s4WrID0HkzgK8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7533.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(396003)(366004)(136003)(8676002)(53546011)(86362001)(36756003)(5660300002)(66476007)(110136005)(16526019)(66574015)(478600001)(16576012)(31686004)(186003)(316002)(66946007)(6706004)(31696002)(956004)(8936002)(966005)(6486002)(2616005)(6666004)(52116002)(30864003)(2906002)(66556008)(26005)(83380400001)(21314003)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?uYpUxQ+UOWjmb0I2EvCXJM+Xllz9I2HP6rnCwV0v/Jga1/qbi/hlw/tgl04C?=
 =?us-ascii?Q?plXB31wN9MqSXGi2DQs8l2TFv0JDDE3k24I971T/1IGRPb4YuKlWFxXB0tU9?=
 =?us-ascii?Q?14vleU8Riv5VlJrbJRew4i/o+5sxuftmFk4AjWsJW57/Ojyh+mM4bCau3W6o?=
 =?us-ascii?Q?iIbe2gjD5BH37j3Fg3hXUKSEBfR3FhRMUVGZZGsdlMWxwHsYs4hMBIRsQcRc?=
 =?us-ascii?Q?fVPLQsMrJz+rvY3eBynoKycwrd1IyBjrfXw0YOvSmM91L08jDu8dbjcYvimC?=
 =?us-ascii?Q?og3pvl0nkaR6CfJXWQIdrrQGFtRJfHncVYCO0vSL4NmSgyAgw+MD8rVHmwJl?=
 =?us-ascii?Q?ZXbBM0qjc2WXwB4IyY9yzJOVie5RDk5J4oa6Cn0+NGRg96R8V8EHBaAfCKAl?=
 =?us-ascii?Q?xdft8HLptAxbrPCe8bKgSK8WZtCc1L3XpLRtsjvm8odEpur3vruNcNaf2XhH?=
 =?us-ascii?Q?TM+tI33KNVo2PsqLl/DQ/gnTFkUAKuWiPabXIcnBF7YYyw+bbjneEqEZjmCQ?=
 =?us-ascii?Q?nleMj9bqxjyjNQzBoG++xclzSEOKB3AU9/p+dUR2Bk1Ta4E5grrhl7uL/uuH?=
 =?us-ascii?Q?FAaxVjKbLgYlIjKmD6dKVaGvttNHtAgWZqpTfMJJ3r7lK+XFpeGnNRoeRmPC?=
 =?us-ascii?Q?wfiCZlZgpYpt/N3iDPzPn0WAaeUdz3QUqqEN+CfzCu7/LMqkjp/+wUE+S7wm?=
 =?us-ascii?Q?gRAK/dYHxsRVBpCtf/h2nt+R1I3Bb+x+wEvm+6/v0Cu9tTODEyWNtU0DNAg1?=
 =?us-ascii?Q?rsToPfEK26P7TohiwQswHa5buk5k9n7cHCtX+zok0w3y00JQlvqvTwlRuglW?=
 =?us-ascii?Q?E1jHhoZhw843MrUGe3cBUJ1ZUp3nJwRJJCLOA8BJlbKB4JsS9rAhPB+3A3lX?=
 =?us-ascii?Q?h6G+ZJ9kjrave0xsTyFPQFui2hoW/Qql8VstK3pBM34MvUyvr9W8AFRPVuJm?=
 =?us-ascii?Q?BvTRFGJG2jE66sU3XvuUd34EqpbHXGmmfd/efb3QHcBhWv4EakaKI/rH475i?=
 =?us-ascii?Q?6/nT?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7533.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2020 07:48:58.0674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c55bfe-4f0a-4268-d79d-08d8ab0508ab
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DdaWBNKL+SsDWbG+cNcFVRW6rAoi6iWfM9KfJSCWihe4xAGHqcfnXJkTgbXhQig0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7821
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/12/28 =E4=B8=8B=E5=8D=883:38, David Arendt wrote:
> Hi,
>=20
> unfortunately the problem is no longer reproducible, probably due to=20
> writes happening in meantime. If you still want a btrfs-image, I can=20
> create one (unfortunately only without data as there is confidential=20
> data in it), but as the problem is currently no longer reproducible, I=20
> think it probably won't help.

That's fine, at least you get your fs back to normal.

I tried several small balance locally, not reproduced, thus I guess it=20
may be related to certain tree layout.

Anyway, I'll wait for another small enough and reproducible report.

Thanks,
Qu

>=20
> Thanks in advance,
> David Arendt
>=20
> On 12/28/20 1:06 AM, Qu Wenruo wrote:
>>
>>
>> On 2020/12/27 =E4=B8=8B=E5=8D=889:11, David Arendt wrote:
>>> Hi,
>>>
>>> last week I had the same problem on a btrfs filesystem after updating t=
o
>>> kernel 5.10.1. I have never had this problem before kernel 5.10.x.
>>> 5.9.x did now show any problem.
>>>
>>> Dec 14 22:30:59 xxx kernel: BTRFS info (device sda2): scrub: started on
>>> devid 1
>>> Dec 14 22:31:09 xxx kernel: BTRFS info (device sda2): scrub: finished o=
n
>>> devid 1 with status: 0
>>> Dec 14 22:33:16 xxx kernel: BTRFS info (device sda2): balance: start
>>> -dusage=10
>>> Dec 14 22:33:16 xxx kernel: BTRFS info (device sda2): relocating block
>>> group 71694286848 flags data
>>> Dec 14 22:33:16 xxx kernel: BTRFS info (device sda2): found 1058
>>> extents, stage: move data extents
>>> Dec 14 22:33:16 xxx kernel: BTRFS info (device sda2): balance: ended
>>> with status: -2
>>>
>>> This is not a multidevice volume but a volume consisting of a single
>>> partition.
>>>
>>> xxx ~ # btrfs fi df /u00
>>> Data, single: total=10.01GiB, used=3D24GiB
>>> System, single: total=3D00MiB, used=16.00KiB
>>> Metadata, single: total=3D76GiB, used=3D10GiB
>>> GlobalReserve, single: totalG.17MiB, used=3D00B
>>>
>>> xxx ~ # btrfs device usage /u00
>>> /dev/sda2, ID: 1
>>> =C2=A0=C2=A0=C2=A0 Device size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 19.81GiB
>>> =C2=A0=C2=A0=C2=A0 Device slack:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B
>>> =C2=A0=C2=A0=C2=A0 Data,single:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 10.01GiB
>>> =C2=A0=C2=A0=C2=A0 Metadata,single:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 2.76GiB
>>> =C2=A0=C2=A0=C2=A0 System,single:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 4.00MiB
>>> =C2=A0=C2=A0=C2=A0 Unallocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7.04GiB
>>
>> This seems small enough, thus a btrfs-image dump would help.
>>
>> Although there is a limit for btrfs-image dump, since it only contains
>> metadata, when we try to balance data to reproduce the bug, it would
>> easily cause data csum error and exit convert.
>>
>> If possible, would you please try to take a dump with this branch?
>> https://github.com/adam900710/btrfs-progs/tree/image_data_dump
>>
>> It provides a new option for btrfs-image, -d, which will also take the=20
>> data.
>>
>> Also, please keep in mind that, -d dump will contain data of your fs,
>> thus if it contains confidential info, please use regular btrfs-image.
>>
>> Thanks,
>> Qu
>>>
>>>
>>> On 12/27/20 1:11 PM, St=C3=A9phane Lesimple wrote:
>>>> Hello,
>>>>
>>>> As part of the maintenance routine of one of my raid1 FS, a few days
>>>> ago I was in the process
>>>> of replacing a 10T drive with a 16T one.
>>>> So I first added the new 16T drive to the FS (btrfs dev add), then
>>>> started a btrfs dev del.
>>>>
>>>> After a few days of balancing the block groups out of the old 10T=20
>>>> drive,
>>>> the balance aborted when around 500 GiB of data was still to be moved
>>>> out of the drive:
>>>>
>>>> Dec 21 14:18:40 nas kernel: BTRFS info (device dm-10): relocating
>>>> block group 11115169841152 flags data|raid1
>>>> Dec 21 14:18:54 nas kernel: BTRFS info (device dm-10): found 6264
>>>> extents, stage: move data extents
>>>> Dec 21 14:19:16 nas kernel: BTRFS info (device dm-10): balance: ended
>>>> with status: -2
>>>>
>>>> Of course this also cancelled the device deletion, so after that the
>>>> device was still part of the FS. I then tried to do a balance manually=
,
>>>> in an attempt to reproduce the issue:
>>>>
>>>> Dec 21 14:28:16 nas kernel: BTRFS info (device dm-10): balance: start
>>>> -ddevid=3Dlimit=3D
>>>> Dec 21 14:28:16 nas kernel: BTRFS info (device dm-10): relocating
>>>> block group 11115169841152 flags data|raid1
>>>> Dec 21 14:28:29 nas kernel: BTRFS info (device dm-10): found 6264
>>>> extents, stage: move data extents
>>>> Dec 21 14:28:46 nas kernel: BTRFS info (device dm-10): balance: ended
>>>> with status: -2
>>>>
>>>> There were of course still plenty of room on the FS, as I added a new
>>>> 16T drive
>>>> (a btrfs fi usage is further down this email), so it struck me as odd.
>>>> So, I tried to lower the reduncancy temporarily, expecting the balance
>>>> of this block group to
>>>> complete immediately given that there were already a copy of this data
>>>> present on another drive:
>>>>
>>>> Dec 21 14:38:50 nas kernel: BTRFS info (device dm-10): balance: start
>>>> -dconvert=3Dngle,soft,devid=3Dlimit=3D
>>>> Dec 21 14:38:50 nas kernel: BTRFS info (device dm-10): relocating
>>>> block group 11115169841152 flags data|raid1
>>>> Dec 21 14:39:00 nas kernel: BTRFS info (device dm-10): found 6264
>>>> extents, stage: move data extents
>>>> Dec 21 14:39:17 nas kernel: BTRFS info (device dm-10): balance: ended
>>>> with status: -2
>>>>
>>>> That didn't work.
>>>> I also tried to mount the FS in degraded mode, with the drive I wanted
>>>> to remove missing,
>>>> using btrfs dev del missing, but the balance still failed with the
>>>> same error on the same block group.
>>>>
>>>> So, as I was running 5.10.1 just for a few days, I tried an older
>>>> kernel: 5.6.17,
>>>> and retried the balance once again (with still the drive voluntarily
>>>> missing):
>>>>
>>>> [ 413.188812] BTRFS info (device dm-10): allowing degraded mounts
>>>> [ 413.188814] BTRFS info (device dm-10): using free space tree
>>>> [ 413.188815] BTRFS info (device dm-10): has skinny extents
>>>> [ 413.189674] BTRFS warning (device dm-10): devid 5 uuid
>>>> 068c6db3-3c30-4c97-b96b-5fe2d6c5d677 is missing
>>>> [ 424.159486] BTRFS info (device dm-10): balance: start
>>>> -dconvert=3Dngle,soft,devid=3Dlimit=3D
>>>> [ 424.772640] BTRFS info (device dm-10): relocating block group
>>>> 11115169841152 flags data|raid1
>>>> [ 434.749100] BTRFS info (device dm-10): found 6264 extents, stage:
>>>> move data extents
>>>> [ 477.703111] BTRFS info (device dm-10): found 6264 extents, stage:
>>>> update data pointers
>>>> [ 497.941482] BTRFS info (device dm-10): balance: ended with status: 0
>>>>
>>>> The problematic block group was balanced successfully this time.
>>>>
>>>> I balanced a few more successfully (without the -dconvert=3Dngle optio=
n),
>>>> then decided to reboot under 5.10 just to see if I would hit this
>>>> issue again.
>>>> I didn't: the btrfs dev del worked correctly after the last 500G or so
>>>> data
>>>> was moved out of the drive.
>>>>
>>>> This is the output of btrfs fi usage after I successfully balanced the
>>>> problematic block group under the 5.6.17 kernel. Notice the multiple
>>>> data profile, which is expected as I used the -dconvert balance option=
,
>>>> and also the fact that apparently 3 chunks were allocated on new16T fo=
r
>>>> this, even if only 1 seem to be used. We can tell because this is the
>>>> first and only time the balance succeeded with the -dconvert option,
>>>> hence these chunks are all under "data,single":
>>>>
>>>> Overall:
>>>> Device size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 41.89TiB
>>>> Device allocated:=C2=A0=C2=A0 21.74TiB
>>>> Device unallocated: 20.14TiB
>>>> Device missing:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 9.09TiB
>>>> Used:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 21.71TiB
>>>> Free (estimated):=C2=A0=C2=A0 10.08TiB (min: 10.07TiB)
>>>> Data ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 2.00
>>>> Metadata ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.00
>>>> Global reserve:=C2=A0=C2=A0=C2=A0 512.00MiB (used: 0.00B)
>>>> Multiple profiles:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 yes (data)
>>>>
>>>> Data,single: Size:3.00GiB, Used:1.00GiB (33.34%)
>>>> /dev/mapper/luks-new16T=C2=A0=C2=A0=C2=A0=C2=A0 3.00GiB
>>>>
>>>> Data,RAID1: Size:10.83TiB, Used:10.83TiB (99.99%)
>>>> /dev/mapper/luks-10Ta=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7.14TiB
>>>> /dev/mapper/luks-10Tb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7.10TiB
>>>> missing=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 482.00GiB
>>>> /dev/mapper/luks-new16T=C2=A0=C2=A0=C2=A0=C2=A0 6.95TiB
>>>>
>>>> Metadata,RAID1: Size:36.00GiB, Used:23.87GiB (66.31%)
>>>> /dev/mapper/luks-10Tb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 36.00GiB
>>>> /dev/mapper/luks-ssd-mdata 36.00GiB
>>>>
>>>> System,RAID1: Size:32.00MiB, Used:1.77MiB (5.52%)
>>>> /dev/mapper/luks-10Ta=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32.00MiB
>>>> /dev/mapper/luks-10Tb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32.00MiB
>>>>
>>>> Unallocated:
>>>> /dev/mapper/luks-10Ta=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.95TiB
>>>> /dev/mapper/luks-10Tb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.96TiB
>>>> missing=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8.62TiB
>>>> /dev/mapper/luks-ssd-mdata 11.29GiB
>>>> /dev/mapper/luks-new16T=C2=A0=C2=A0=C2=A0=C2=A0 7.60TiB
>>>>
>>>> I wasn't going to send an email to this ML because I knew I had nothin=
g
>>>> to reproduce the issue noww that it was "fixed", but now I think I'm
>>>> bumping
>>>> into the same issue on another FS, while rebalancing data after adding
>>>> a drive,
>>>> which happens to be the old 10T drive of the FS above.
>>>>
>>>> The btrfs fi usage of this second FS is as follows:
>>>>
>>>> Overall:
>>>> Device size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 25.50TiB
>>>> Device allocated:=C2=A0=C2=A0 22.95TiB
>>>> Device unallocated:=C2=A0 2.55TiB
>>>> Device missing:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B
>>>> Used:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 22.36TiB
>>>> Free (estimated):=C2=A0=C2=A0=C2=A0 3.14TiB (min: 1.87TiB)
>>>> Data ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 1.00
>>>> Metadata ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.00
>>>> Global reserve:=C2=A0=C2=A0=C2=A0 512.00MiB (used: 0.00B)
>>>> Multiple profiles:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no
>>>>
>>>> Data,single: Size:22.89TiB, Used:22.29TiB (97.40%)
>>>> /dev/mapper/luks-12T=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 10.91Ti=
B
>>>> /dev/mapper/luks-3Ta=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2=
.73TiB
>>>> /dev/mapper/luks-3Tb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2=
.73TiB
>>>> /dev/mapper/luks-10T=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6=
.52TiB
>>>>
>>>> Metadata,RAID1: Size:32.00GiB, Used:30.83GiB (96.34%)
>>>> /dev/mapper/luks-ssd-mdata2 32.00GiB
>>>> /dev/mapper/luks-10T=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32.00Gi=
B
>>>>
>>>> System,RAID1: Size:32.00MiB, Used:2.44MiB (7.62%)
>>>> /dev/mapper/luks-3Tb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32.00Mi=
B
>>>> /dev/mapper/luks-10T=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32.00Mi=
B
>>>>
>>>> Unallocated:
>>>> /dev/mapper/luks-12T=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 45.00Mi=
B
>>>> /dev/mapper/luks-ssd-mdata2=C2=A0 4.00GiB
>>>> /dev/mapper/luks-3Ta=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=
.02MiB
>>>> /dev/mapper/luks-3Tb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2=
.97GiB
>>>> /dev/mapper/luks-10T=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2=
.54TiB
>>>>
>>>> I can reproduce the problem reliably:
>>>>
>>>> # btrfs bal start -dvrange4625344765952..34625344765953 /tank
>>>> ERROR: error during balancing '/tank': No such file or directory
>>>> There may be more info in syslog - try dmesg | tail
>>>>
>>>> [145979.563045] BTRFS info (device dm-10): balance: start
>>>> -dvrange4625344765952..34625344765953
>>>> [145979.585572] BTRFS info (device dm-10): relocating block group
>>>> 34625344765952 flags data|raid1
>>>> [145990.396585] BTRFS info (device dm-10): found 167 extents, stage:
>>>> move data extents
>>>> [146002.236115] BTRFS info (device dm-10): balance: ended with=20
>>>> status: -2
>>>>
>>>> If anybody is interested in looking into this, this time I can leave
>>>> the FS in this state.
>>>> The issue is reproducible, and I can live without completing the
>>>> balance for the next weeks
>>>> or even months, as I don't think I'll need the currently unallocatable
>>>> space soon.
>>>>
>>>> I also made a btrfs-image of the FS, using btrfs-image -c 9 -t 4 -s -w=
.
>>>> If it's of any use, I can drop it somewhere (51G).
>>>>
>>>> I could try to bisect manually to find which version between 5.6.x and
>>>> 5.10.1 started to behave
>>>> like this, but on the first success, I won't know how to reproduce the
>>>> issue a second time, as
>>>> I'm not 100% sure it can be done solely with the btrfs-image.
>>>>
>>>> Note that another user seem to have encoutered a similar issue in July
>>>> with 5.8:
>>>> https://www.spinics.net/lists/linux-btrfs/msg103188.html
>>>>
>>>> Regards,
>>>>
>>>> St=C3=A9phane Lesimple.
>>>
>>>
>=20

