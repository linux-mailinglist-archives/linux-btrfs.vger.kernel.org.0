Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49393C80DD
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jul 2021 10:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238638AbhGNJCE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jul 2021 05:02:04 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:55624 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238527AbhGNJCE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jul 2021 05:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1626253151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=51qzZOu1IxaPzqD737HfD/3bpQ6XVPQb2qMSAgG3W/M=;
        b=Ar6UVX/MBufwJDR+nUpM5LwL6JZHTNsrpaFP6PXLOhqgD/M2ZJUP2Wt+4yKy1bvzuZ6rfh
        YrPP2bHyfP4JNL8VX800liOUlMOuMA+46GkbtqhSHzKhqBnF/KZQXm0M6qIhJ5RIlWDJnE
        Dg0DV6Q9S9O3j35IIzT6ve+gcffTnHs=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2108.outbound.protection.outlook.com [104.47.17.108])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-27-NigjKzBtOb2rU9wQWv0LQQ-1; Wed, 14 Jul 2021 10:59:10 +0200
X-MC-Unique: NigjKzBtOb2rU9wQWv0LQQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qkfud+897OIMBpAXiPj/sSvIOHQKNkbXGjp2xdPpEJOUMJuoGWE+3IrqutnKkR4BuZUBjHS+rPxOGhHenFhI9yRMTGBxb4fEJskAK3eDcK/VqLawSD0uy+QuEebp3FSkt7H/0hGjvXtHdwJf3iQmgdRIAWABEGFMIkD9ajo+MuwBFWrZHD33AbbrVvLKdN/snd1X5omQbzv96sws6FHNd0bWwHOO08EXGxwsHCJ2mP9qez+G0k5fDzIbbDwv/DysHa6RyBAhUjOoZB1hfw9Pu68PA/kpBbo/kcHx/V03bh6O6DmSCjJTIiAfUcEQnx/CrllXCnJfcZQigDC2YJq85A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6H9MbhonI0TBc/gjiDQzsjgnthyhZGMdz9emQwew0Q=;
 b=NjET4Hi0I4540GeRVerrKG4l3/9aglOw910rYfJCYKLHTu+V6hI+xBd3pn03wTVQ6bctYhrAp0dq7sgNv73fSDDoNfDnGczqYTpz12fGWvNHdFq20kEQuVvLYI0BbcuCOoQ+QJrvISVyVLhnaLHA2ciAjxU/qsnGT4sPW64GZ3ZBTCN0aqeaJbBrlpr6vV8Gxvb/A9YbkjYC/4v2TpWmlcgJ2ix3ilormo/MUJ5tyyt9FxbvGz3zilJPW7+JYvuRJgupwoOckO9drcMQSEWAv1O87vaEDGqYZ0r4Jj2OIbM3b/VmX25YLQw5g5mQXnq5c9o7+0SA1ZhOIveoPMRV6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB5863.eurprd04.prod.outlook.com (2603:10a6:20b:a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Wed, 14 Jul
 2021 08:59:08 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65%3]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 08:59:08 +0000
Subject: Re: btrfs cannot be mounted or checked
To:     Zhenyu Wu <wuzy001@gmail.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
CC:     Forza <forza@tnonline.net>, linux-btrfs@vger.kernel.org
References: <CAJ9tZB_VHc4x3hMpjW6h_3gr5tCcdK7RpOUcAdpLuR5PVpW8EQ@mail.gmail.com>
 <110a038d-a542-dcf5-38b8-5f15ee97eb2c@tnonline.net>
 <2a9b53ea-fd95-5a92-34a5-3dcac304cec1@gmx.com>
 <CAJ9tZB9X=iWvUSuyE=nPJ8Chge4E_f-9o67A-d=zt4ZAnXjeCg@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <9e4f970a-a8c5-8b96-d0bb-d527830d0d12@suse.com>
Date:   Wed, 14 Jul 2021 16:58:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CAJ9tZB9X=iWvUSuyE=nPJ8Chge4E_f-9o67A-d=zt4ZAnXjeCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TYAP286CA0012.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8015::17) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (45.77.180.217) by TYAP286CA0012.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8015::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 08:59:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51e2e7de-89a6-410f-bdd5-08d946a5a3bb
X-MS-TrafficTypeDiagnostic: AM6PR04MB5863:
X-Microsoft-Antispam-PRVS: <AM6PR04MB5863A470A6BE1D7DE092910CD6139@AM6PR04MB5863.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R9UTCsDBrR7wv7DZT2qE5AgIyUipzSD9vvFR44q7+idWSTviPBuAPFEQDfKnwWXpgXb9TKyolEkBgxG0q29VFpbULQiKRGylCeQmAo+Nx/fIEIUXdEAhY4JFPojBfsEJIFZ6YKvriCiawWDG6X6VMEJ/oYrJbNErrvaLNBtSsktWtYx4HBwo58YP3an1DDqcAfxddWWrEvVam2nBhJPi77uplTTCev1BJyJjTC9fzmFqli/okxKBezhLyfrH6/HN8pNtt32cnc7SspL57qE5CYqszIqYpHLpm8+IYkwEVqiEFmSGnlybx6QvixhyqeX+KHm/KUVf56XOCsxOyYcEJfrdmiA0DFZzER4XqfbTcCm2V0wxKC3nqW4PrykEGOPoPh9Cu5REh25hZVh23eqUj6PRmNn4msaCdb744maPgJK9TmZpv72wlJJlUmZ4WpvPUnyiajD5h/2IK2FLPX52h48iqoR/NBRLw8qtKLzRLcmqMYglYBjmyQ6nvgu7BwPpbCcROfYqUPt9R/Vot/FE18pRAA/QSH0m9OibpXUIukbSp5P3mb6SU7Y5sFJWS2JiNoJZveT2xMcvAx0j2z9P9ty/FQ64iGIgqErK3ydmiOF//NvfKtvZl6J760VBJhepMH/w20vZ1H3BT5YRkDyWQGSpeUs8wXVX1rXCa2O5nBf2VayFLyHmfpcxXnt+jA/isjVa4gos9+ChVHfvKcj1HlQOuTzce8fsPbnv26gl5qrxalCrCgeltMH7b0W12TxWhaIHHO2AIEqJ36gugMmvDHWj4ZcH5AqDni1Xfm5KUBPVSGMfCetJLS9m0/urHaiSyRVkAnKnoKhDCd41GnTW8FCpbsmwnlgd5R4FM6kzc0Nk88Rsnc/oCWgHqArtXYkVPN7zSOORXhO9/608WoedxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39850400004)(376002)(346002)(366004)(396003)(316002)(16576012)(478600001)(66946007)(966005)(66556008)(66476007)(5660300002)(6486002)(31686004)(2906002)(6706004)(2616005)(6666004)(4326008)(110136005)(956004)(8676002)(36756003)(8936002)(16799955002)(31696002)(86362001)(83380400001)(38100700002)(186003)(53546011)(55236004)(26005)(518174003)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YEoCx4N3FrKKkPZRAdyfwXl2/w0EFgO5DuNadgtltmXr2NVaaCzMsF44O2KK?=
 =?us-ascii?Q?bpoAhqTTziMxs65CfszQav1lqzrWiI7Rsnmm49iogPB6b2VY6rwipv0+UMTP?=
 =?us-ascii?Q?noXmPR9V5no1702sbEsuxgbAKvCMnDyoZSmR3CrlAesRtN1jyRIH5wxZq+Kj?=
 =?us-ascii?Q?DPugt5hst0p7vsfmnSB0zDsSYPeZYWYh3ULGO0eHIKdVD4CihBvlqd0FnmKf?=
 =?us-ascii?Q?SNcxMn6g8Xias/LgcPeCx/1XEr2FddvbSX0425S7FL6N3m7orKIAKICioARa?=
 =?us-ascii?Q?88GgOh/fIQcZPHsvR4gM52TJf1r9x28PdAA630jo+RzDHzAVIszlImy5jFkT?=
 =?us-ascii?Q?1ah0BrWloTZMCbgP5JJ6WeftwWCfXG5J9ztPVOlMdwgAY2TlVUEPwi+HnK3m?=
 =?us-ascii?Q?+RR2BthedPdQtJRK1GbAghKiEStE/UfC7mNI16IzYhJnJNjKPL3KzWOAitjO?=
 =?us-ascii?Q?TlzxpPiallZDhgo3QbLGWP0LZO4aZEU2mjzr2PBUsim7qZ+pw53afQkGsYqV?=
 =?us-ascii?Q?qpad+RXzwV5PBXcMbmXbxOFFUyTJjqFmhS3xPvKPz796aMtQaak9Bc5CwVcp?=
 =?us-ascii?Q?UuSC+pPSr0vgJHYkFrVhvCQ+IgoiZE8MG8eFhSvVYaPVp7KSyCBhTp7jQ5MZ?=
 =?us-ascii?Q?TNF/XirXFHqjUrTwEJwmV0q2IMHzBw+0MPK4BaNk4UIWUJuloyrSq9FBOIwp?=
 =?us-ascii?Q?Txt42d3NTVWGVW87TuAqif9gMY7idjoVFTnn7YvZTDdIUI/pP8WfHcxMjKmp?=
 =?us-ascii?Q?ItOP1T0wtT/BXQC7Tcls4aS5QTiMvKb8aLDr+3yjGR3hPLEgwCBewGeq2ouV?=
 =?us-ascii?Q?kSs8P1pAPSx/xgVQ2tGKdsJf9csuNT6yLk2tlLudHljh4plPEiQaEYWtPRHc?=
 =?us-ascii?Q?ex51SIxporHpKoCO0YG/RVhyxbs5pNoqk53ado8UuOaVy/r00sF9SDIMu9XD?=
 =?us-ascii?Q?IiNh/MR/kSBFvVCramUAds9Hw1oy42Y/m6dxqmax9+XmNXAjIF06JHbircIY?=
 =?us-ascii?Q?a8K9Pksjurbyip/HFMIn/Mp9JOwkHRbbWfFJMKKzaUSwpeqdRnUUpMWPvdgO?=
 =?us-ascii?Q?UMoQwUfrmgGZKQ+DUMP0UiK42D/7WzW+DrZpXh2sJaltf2srHXgy79xd2u3C?=
 =?us-ascii?Q?S0IrGbNhs0N95YVCcGa+ZjAQhJPrzXI7Sce+jihZGYj1pVNNfxiis2Sk/HAP?=
 =?us-ascii?Q?mMCYvWFO5xJHsRVf3yvwmd/o7D74dX0bTwh91ldEOS7H9xpZ4jfdqpmrpqgd?=
 =?us-ascii?Q?0Jy067dr9IoKQniQiJmKEiuZLS1KbtpFcUGzBifJuW/XBlI/TCT/LqSXAHsL?=
 =?us-ascii?Q?Fk6mUPHSmZalIksv8gGUkwUr?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e2e7de-89a6-410f-bdd5-08d946a5a3bb
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 08:59:08.1179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rIZ+podBXPY2vqmwPXqQxlybDdqxezvCAIjS9SKY5ezoXLrygjnsZ+CWu8b6KNtS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5863
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/14 =E4=B8=8B=E5=8D=884:49, Zhenyu Wu wrote:
> sorry for late:(
>=20
> I found <https://bbs.archlinux.org/viewtopic.php?id=3D233724> looks same
> as my situation. But in my computer (boot from live usb) `btrfs check
> --init-extent-tree` output a lot of non-ascii character (maybe because
> ansi escape code mess the terminal)
> after several days it outputs `7/7`and `killed`. The solution looks faile=
d.
>=20
> I'm sorry because my live usb don't have smartctl :(
>=20
> ```
> $ hdparm -W0 /dev/sda
> /dev/sda:
>   setting drive write-caching to 0 (off)
>   write-caching =3D  0 (off)
> ```
>=20
> But now the btrfs partition still cannot be mounted.
>=20
> when I try to mount it with `usebackuproot`, it will output the same
> error message. And dmesg will output
> ```
> [250062.064785] BTRFS warning (device sda2): 'usebackuproot' is
> deprecated, use 'rescue=3Dusebackuproot' instead
> [250062.064788] BTRFS info (device sda2): trying to use backup root at
> mount time
> [250062.064789] BTRFS info (device sda2): disk space caching is enabled
> [250062.064790] BTRFS info (device sda2): has skinny extents
> [250062.208403] BTRFS info (device sda2): bdev /dev/sda2 errs: wr 0,
> rd 0, flush 0, corrupt 5, gen 0
> [250062.277045] BTRFS critical (device sda2): corrupt leaf: root=3D2
> block=3D273006592 slot=3D17 bg_start=3D1104150528 bg_len=3D1073741824, in=
valid
> block group used, have 1073754112 expect [0, 1073741824)

Looks like a bad extent tree re-initialization, a bug in btrfs-progs then.

For now, you can try to mount with "ro,rescue=3Dibadroots" to see if it=20
can be mounted RO, then rescue your data.

Thanks,
Qu
> [250062.277048] BTRFS error (device sda2): block=3D273006592 read time
> tree block corruption detected
> [250062.291924] BTRFS critical (device sda2): corrupt leaf: root=3D2
> block=3D273006592 slot=3D17 bg_start=3D1104150528 bg_len=3D1073741824, in=
valid
> block group used, have 1073754112 expect [0, 1073741824)
> [250062.291927] BTRFS error (device sda2): block=3D273006592 read time
> tree block corruption detected
> [250062.291943] BTRFS error (device sda2): failed to read block groups: -=
5
> [250062.292897] BTRFS error (device sda2): open_ctree failed
> ```
>=20
> If don't usebackuproot, dmesg will output the same log except the first 2=
 lines.
>=20
> Now btrfs check can check this partition:
>=20
> ```
> $ btrfs check /dev/sda2 2>&1|tee check.txt
> # see attachment
> ```
>=20
> Does my disk have any hope to be rescued?
> thanks!
>=20
> On 7/11/21, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>> On 2021/7/11 =E4=B8=8B=E5=8D=887:37, Forza wrote:
>>>
>>>
>>> On 2021-07-11 10:59, Zhenyu Wu wrote:
>>>> Sorry for my disturbance.
>>>> After a dirty reboot because of a computer crash, my btrfs partition
>>>> cannot be mounted. The same thing happened before, but now `btrfs
>>>> rescue zero-log` cannot work.
>>>> ```
>>>> $ uname -r
>>>> 5.10.27-gentoo-x86_64
>>>> $ btrfs rescue zero-log /dev/sda2
>>>> Clearing log on /dev/sda2, previous log_root 0, level 0
>>>> $ mount /dev/sda2 /mnt/gentoo
>>>> mount: /mnt/gentoo: wrong fs type, bad option, bad superblock on
>>>> /dev/sda2, missing codepage or helper program, or other error.
>>>> $ btrfs check /dev/sda2
>>>> parent transid verify failed on 34308096 wanted 962175 found 961764
>>>> parent transid verify failed on 34308096 wanted 962175 found 961764
>>>> parent transid verify failed on 34308096 wanted 962175 found 961764
>>>> Ignoring transid failure
>>>> leaf parent key incorrect 34308096
>>>> ERROR: failed to read block groups: Operation not permitted
>>>> ERROR: cannot open file system
>>>> $ dmesg 2>&1|tee dmesg.txt
>>>> # see attachment
>>>> ```
>>>> Like `mount -o ro,usebackuproot` cannot work, too.
>>>>
>>>> Thanks for any help!
>>>>
>>>
>>>
>>> Hi!
>>>
>>> Parent transid failed is hard to recover from, as mentioned on
>>> https://btrfs.wiki.kernel.org/index.php/FAQ#How_do_I_recover_from_a_.22=
parent_transid_verify_failed.22_error.3F
>>>
>>>
>>> I see you have "corrupt 5" sectors in dmesg. Is your disk healthy? You
>>> can check with "smartctl -x /dev/sda" to determine the health.
>>>
>>> One way of avoiding this error is to disable write-cache. Parent transi=
d
>>> failed can happen when the disk re-orders writes in its write cache
>>> before flushing to disk. This violates barriers, but it is unfortately
>>> common. If you have a crash, SATA bus reset or other issues, unwritten
>>> content is lost. The problem here is the re-ordering. The superblock is
>>> written out before other metadata (which is now lost due to the crash).
>>
>> To be extra accurate, all filesysmtems have taken the re-order into
>> consideration.
>> Thus we have flush (or called barrier) command to force the disk to
>> write all its cache back to disk or at least non-volatile cache.
>>
>> Combined with mandatory metadata CoW, it means, no matter what the disk
>> re-order or not, we should only see either the newer data after the
>> flush, or the older data before the flush.
>>
>> But unfortunately, hardware is unreliable, sometimes even lies about its
>> flush command.
>> Thus it's possible some disks, especially some cheap RAID cards, tend to
>> just ignore such flush commands, thus leaves the data corrupted after a
>> power loss.
>>
>> Thanks,
>> Qu
>>
>>>
>>> You disable write cache with "hdparm -W0 /dev/sda". It might be worth
>>> adding this to a cron-job every 5 minutes or so, as the setting is not
>>> persistent and can get reset if the disk looses power, goes to sleep,
>>> etc.
>>

