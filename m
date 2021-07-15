Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A9A3C9852
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jul 2021 07:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236135AbhGOFZY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Jul 2021 01:25:24 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:51302 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230076AbhGOFZY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Jul 2021 01:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1626326550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vluo7V3gTPWiwqza3Z0vWU4raAbWySDoP8MXbFVwgiQ=;
        b=fKXcZ8uI58GIn5JvNdFhlbRtM0ABvB3TjXA5c4wTq1E1nTIA2AdlK3nZdjNSWgfUk+Jb6a
        VOGdr3N8ZiCezzDp5L5DiWecNsiup5cTpYSMQR0PRKgFy6oDOlpxsJX/xE+9xZds3oArxA
        joQVpBypDnLY5unLNJzGEIigBnufPbs=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2058.outbound.protection.outlook.com [104.47.14.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-18-H2sYoXLnNwq_OTL19CcEYw-1; Thu, 15 Jul 2021 07:22:29 +0200
X-MC-Unique: H2sYoXLnNwq_OTL19CcEYw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiHi/8+rY71Wx/MJ4yXZyWayzv7AV8eJMShtDOLM6V9O9K4X4FQFVWeKMUDeDIvJLPb52ULoilP+m4ESoyOudC3XblPWbg2Vx3wIPnLg7OGyRTXrUXYwxpGgUack56uSrwLe/umfUHgNucDIpL3kznMzRhJwhoYwrHFx9pUVrIxU6rJsIiu7sFm92D5x0QzkEXuVATtfLlPWed+JxmRhqXWz5zjGIMuDTgjo8+VHzlyMrh4M5Funhlne/5kExgPxmHkcrTpHeYqirJ8+XIdLTYTpymNdmayZOKakATqOBGqonj6Iv9jwiEFrBnCohKHJeoMi3pRWNonjfH+KQZG0/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8jAJH1MB3LxBdzMHGn056XjpstY+J+iiOWdJUbLRyU=;
 b=fHhre5lNuzaV0QOpuYsxxpI23iEOYi36kWzFWeCSH4piKd7y3K0mPtsAswcLE2ZEZQNnMW6NPVaJylkGOfhzgzk4w0pOqv0MppRZXkzJv6DwtpQHEQ+Ox7HPjyjv8UR1ddqAkxmJCX/Mma+0YDFb8ljf5nnG0uUcYTIPx6FnTdKnI5aWqrZ0arDIYR/M5e9eAivHUskNqPX9vnELPb4lzIICFk/kQqgqZlFJehzkZHnZK5NiiCHJMp7KVeCUYusy/P0y7QTKSyeS6TGp5yPM8ZcQ2HTDc4LB/KW6vzhwsRDPWqqNVnaZCRjiVXD3WlyFHZ9JGXn7h4lUEF8TvoaCHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB6645.eurprd04.prod.outlook.com (2603:10a6:20b:fe::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Thu, 15 Jul
 2021 05:22:27 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65%3]) with mapi id 15.20.4308.027; Thu, 15 Jul 2021
 05:22:27 +0000
Subject: Re: btrfs cannot be mounted or checked
To:     Zhenyu Wu <wuzy001@gmail.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
CC:     Forza <forza@tnonline.net>, linux-btrfs@vger.kernel.org
References: <CAJ9tZB_VHc4x3hMpjW6h_3gr5tCcdK7RpOUcAdpLuR5PVpW8EQ@mail.gmail.com>
 <110a038d-a542-dcf5-38b8-5f15ee97eb2c@tnonline.net>
 <2a9b53ea-fd95-5a92-34a5-3dcac304cec1@gmx.com>
 <CAJ9tZB9X=iWvUSuyE=nPJ8Chge4E_f-9o67A-d=zt4ZAnXjeCg@mail.gmail.com>
 <9e4f970a-a8c5-8b96-d0bb-d527830d0d12@suse.com>
 <CAJ9tZB_C+RLX0oRTKuUZv0ZxGQiWOL=1EGzM=rHD0gMhgbhGmA@mail.gmail.com>
 <c0024688-3361-7e15-21d1-c55bc16fa83e@gmx.com>
 <CAJ9tZB-O+xphuHJ-DhpjvoFFuFAJrSpoMuurx_44s040YWBtqQ@mail.gmail.com>
 <b25141f0-d4c7-05bc-05af-848b6ed26b1d@gmx.com>
 <CAJ9tZB9V7xYVLq_PFHQ97Y3Rau-ZBjjGmaWayDtLBaj7f00xWg@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <8aad905d-c920-5605-bbf3-7be49daeffb9@suse.com>
Date:   Thu, 15 Jul 2021 13:22:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <CAJ9tZB9V7xYVLq_PFHQ97Y3Rau-ZBjjGmaWayDtLBaj7f00xWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR08CA0001.namprd08.prod.outlook.com
 (2603:10b6:a03:100::14) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR08CA0001.namprd08.prod.outlook.com (2603:10b6:a03:100::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 05:22:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ab32640-07a8-4bfe-cac7-08d94750892d
X-MS-TrafficTypeDiagnostic: AM6PR04MB6645:
X-Microsoft-Antispam-PRVS: <AM6PR04MB66456F16D48E61D8BA3547FFD6129@AM6PR04MB6645.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tqgMs7QyoRtKvq/tlFqd5sDkm924c4ClGC1F8thv/7UPq1ps+c0Y+F2bdZzZvaiuTGNqY2EI0+VSXfgdLyglyyEd90/wHn5RrmDJ1dvXa+6p/wzGa2BjItQVRGAS9l9ASUVsbYUWSL8Uyg7NyGRNQbBzR+DWvx9rVDkq2GK2L5pl3ioK4r8sIKpi786Y/Xx6JsBn5NQIeY7IbtsrQp9dDZTd16wFPLd1rA9+CtSWqj/LvbR3f5yU9WirhnIamafvB24l5t5dhgWdTsMTAT9Qm83ANOOGFkF52cKOLYY3PfNWtlkhaDDmTPxJ3hid2tCjURDNkJRBhPkQRylApKsPLIBCbdEp8YwtFO/2n4c3InKgXq8VRgtBqd5d5svRzp2t8064sriTD5cw03rfhKF7CIlKGPxYGTc24QXjZ5fWIxrUnnpZj7DzgXhyDy+QIAMb70fiSRB2kok4lkfRBC3Bsuog9x38sbn3Yg2/mTzo1e2E6TFVCSKmqZztB30Jf71SCS0CtiQ1mFsq6tLQ9dGWps2CgARU5RsbC7boYYGmCgHpY6OieY9TnQRMtepOW++Pha8PHE7GNuK1DHu4l4pdl3aDMyY4ytzVUX/Qn/L9/pdPwIBlHKEKIlRgohUjPlcmWYfgs1YTzWh3MC5JU9UoAScwSgUxlzW8iiDAlFfeEBRyI601x5Lk/4kmqRSS06fu2HfuRne4KRvI6Mo2YObPZ+6pnB2rqjb/roZY6rC/NODkgvLlXgDEsGmfgAA3hV3sVhT9o7XB0/Nise2SPAPSXEC38ZF4gdQhzlyF5xDEG44DfEQfBTCd46n/yuOhosvZMv5LFjjX+gm30NuX/zP5pGaReQyGauYUQmNk3jVz65CqpwFKzzhKE4iwTarru+fSJn2euRhCkvCe4kqr92RArkZzYyl0tj1k13JSQhwKpTMVVQ1IL67VHSTU6V5b54DY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39850400004)(346002)(136003)(376002)(366004)(478600001)(83380400001)(16799955002)(5660300002)(966005)(36756003)(6666004)(53546011)(6486002)(26005)(4326008)(186003)(31696002)(2616005)(316002)(31686004)(956004)(6706004)(2906002)(110136005)(8936002)(16576012)(30864003)(86362001)(8676002)(66556008)(66476007)(38100700002)(66946007)(55004002)(518174003)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ytWeVVtpeL9yMqlMHDrluRt27zF3hQy5arIfnzdtqxaDiU3zzQisd4JpewAK?=
 =?us-ascii?Q?hK2AIDUeJXtj+HUkDNloLKBIZaRoWhQM6wZXMtIgBkWwQ/ctGfNQi61uHFAw?=
 =?us-ascii?Q?qmEwD4oay9SpM918RJ5Hq+bL0Fk4DkO8JN3O/ae3kofLH5RIyvhCCrvPi6zr?=
 =?us-ascii?Q?/qtULJuqPZG7LPiQpZAt8+FOwu+WG7/s5l3Uyi1p1TXfrR3LyVpz23Th3dMH?=
 =?us-ascii?Q?MPrBBZnZWCYFrrNsKJGgEwUKiR/TELplaJtzdtqDc3E8YlGFUrP+CHR04DbR?=
 =?us-ascii?Q?i+0G3jFIEeQCvOhpMaZYKx4R2vgyEHPx6L7rcHMNkfvwGMlTvKZtv/Inwdmv?=
 =?us-ascii?Q?blp96ojKPxDtaWqqctYpOeFRJiVTgEm+yIC91rD9nYtAEULlk0MKzjvAXXwY?=
 =?us-ascii?Q?34MmE7dVGgeoAphAUjxo9WYXpCfdXshXf6ZOzNioaaKQYPnKx5I9t9iZMqRU?=
 =?us-ascii?Q?g2xlQuQem8FjOjcKcZv+rskFMhaSrukn6PJhW+1aDXRzYtmyzJa9SaZhxIqF?=
 =?us-ascii?Q?hGMAQ2K3uSrwN8aFzk2w2YmWW9Ww4bda3HvCnoonQLcib30a9uuE9E8XIvaS?=
 =?us-ascii?Q?Qu3GRmp/Of9YwrJkHr7JlsR39g7TD7om2/gl+27FucHXZXOBU/xnI0PmKXyc?=
 =?us-ascii?Q?0EDBMY3wZqMgdz0/4zhmJhE3sswUfQIHgbZdgj1WTly+o69roT40tiVn83G7?=
 =?us-ascii?Q?G0m5QodniiKx3uIeXy043kRt53/BInayo54LQcTcqZbpEddbefwI4oynbtji?=
 =?us-ascii?Q?3Cm3afsbXNrWzyDwHp2xbtpmCuQpg8Lf4TdSQiIT6nf7aEbz/nYgqgV4AiyS?=
 =?us-ascii?Q?0xpdHrO1eOfLtc9F8BshndV55mpwmw1DOrw5JlMbp774VQAMUFJ6GNbS+MeO?=
 =?us-ascii?Q?DBnHcmnytR/gxazRUN2OpzZsEHz7P/pCHSrEp9KkdmjmsNle8/HA/cPn30D+?=
 =?us-ascii?Q?rT/iIqiebYUOerbs7VRNqciJiQf21PnQYnyQMMTwQT4tMYnacoR9eFZm6fe0?=
 =?us-ascii?Q?qZ3cNCeBq43GMibo42aW2O7LqQtJL/POQR5ykx4sxbI9/722yS4eV3Xhpyfc?=
 =?us-ascii?Q?c4Hm3pKRxP6nY69L6LztFTWWAXCROgH9SbNhwGUDsGzs9QErpPSQyySb5y5m?=
 =?us-ascii?Q?H4LEPUFOcSLyZkwl8KgjnlugIlpRWxyZjgw3/eFtloG18cZSWeHU3D19FAqv?=
 =?us-ascii?Q?7MVB6tQkaCkwZqsLwOOapoJhCCgvEqmSd0URbLq0loySrTn1UN440SLxedn/?=
 =?us-ascii?Q?D8qxLZ0SDUHhmo6cPC49WsH7ZG874PM0chsZSBlM/IHsj685N9JZe35t/wdI?=
 =?us-ascii?Q?2cVvMFBnTuOVOBrHCsGo/n4d?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab32640-07a8-4bfe-cac7-08d94750892d
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 05:22:27.5415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HmT2plxYdlJ76/moMCVTNnPtBu9o6QYb6SGPcygtk+dClL45pDjNq/WgVeofP57j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6645
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/15 =E4=B8=8B=E5=8D=881:17, Zhenyu Wu wrote:
> ```
> $ btrfs ins dump-tree -t root /dev/sda2|grep -A3 EXTENT_TREE|grep
> bytenr|tr -d '\t'|cut -d' ' -f6 > num
> $ btrfs-map-logical -l `cat num` /dev/sda2|cut -d' ' -f6 > phy
> $ xfs_io -f -c "pwrite `tail -n1 phy` 4" /dev/sda2
> wrote 4/4 bytes at offset 499117572096
> 4.000000 bytes, 1 ops; 0.3517 sec (11.370161 bytes/sec and 2.8425 ops/sec=
)
> $ xfs_io -f -c "pwrite `head -n1 phy` 4" /dev/sda2
> # same as above
> $ btrfs check /dev/sda2
> Opening filesystem to check...
> checksum verify failed on 1370128760832 wanted 0xcdcdcdcd found 0xe656843=
3
> checksum verify failed on 1370128760832 wanted 0xcdcdcdcd found 0xe656843=
3
> checksum verify failed on 1370128760832 wanted 0xcdcdcdcd found 0xe656843=
3
> Csum didn't match
> ERROR: could not setup extent tree
> ERROR: cannot open file system
> $ mount -o ro,rescue=3Dibadroots /dev/sda2 /mnt
> $ findmnt /mnt
> TARGET SOURCE    FSTYPE OPTIONS
> /mnt   /dev/sda2 btrfs
> ro,relatime,rescue=3Dignorebadroots,space_cache,subvolid=3D5,subvol=3D/
> $ dmesg|grep BTRFS
> [    7.166566] BTRFS: device label gentoo devid 1 transid 2375312
> /dev/sda2 scanned by systemd-udevd (147)
> [  990.864811] BTRFS info (device sda2): ignoring bad roots
> [  990.864836] BTRFS info (device sda2): disk space caching is enabled
> [  990.864849] BTRFS info (device sda2): has skinny extents
> [  990.910642] BTRFS warning (device sda2): sda2 checksum verify
> failed on 1370128760832 wanted 0xcdcdcdcd found 0xe6568433 level 2
> [  990.920955] BTRFS warning (device sda2): sda2 checksum verify
> failed on 1370128760832 wanted 0xcdcdcdcd found 0xe6568433 level 2
> [  990.990469] BTRFS info (device sda2): bdev /dev/sda2 errs: wr 0, rd
> 0, flush 0, corrupt 5, gen 0
> [  990.992263] BTRFS error (device sda2): qgroup generation mismatch,
> marked as inconsistent
> ```
>=20
> It works!
> now can I boot my computer from disk not live USB?

This is only RO mount, and can no longer be mounted back to RW, not to=20
mention it needs kernel newer than 5.11.

This is mostly only for you to grab your data.

Thanks,
Qu
>=20
> Thanks!
>=20
> On 7/15/21, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>> On 2021/7/14 =E4=B8=8B=E5=8D=889:52, Zhenyu Wu wrote:
>>> I found btrfs-5.12 in archlinux (surprisedly)
>>>
>>> When I try to mount with ro, rescue=3Dibadroots, I will get
>>> ```
>>> wrong fs type, bad option, bad superblock on
>>> /dev/sda2, missing codepage or helper program, or other error.
>>> ```
>>>
>>> dmesg will output
>>> ```
>>> [ 1087.646701] BTRFS info (device sda2): ignoring bad roots
>>> [ 1087.646725] BTRFS info (device sda2): disk space caching is enabled
>>> [ 1087.646735] BTRFS info (device sda2): has skinny extents
>>> [ 1087.770464] BTRFS info (device sda2): bdev /dev/sda2 errs: wr 0, rd
>>> 0, flush 0, corrupt 5, gen 0
>>> [ 1087.834263] BTRFS critical (device sda2): corrupt leaf: root=3D2
>>> block=3D273006592 slot=3D17 bg_start=3D1104150528 bg_len=3D1073741824, =
invalid
>>> block group used, have 1073754112 expect [0, 1073741824)
>>> [ 1087.834550] BTRFS error (device sda2): block=3D273006592 read time
>>> tree block corruption detected
>>> [ 1087.848452] BTRFS critical (device sda2): corrupt leaf: root=3D2
>>> block=3D273006592 slot=3D17 bg_start=3D1104150528 bg_len=3D1073741824, =
invalid
>>> block group used, have 1073754112 expect [0, 1073741824)
>>> [ 1087.848762] BTRFS error (device sda2): block=3D273006592 read time
>>> tree block corruption detected
>>> [ 1087.849006] BTRFS error (device sda2): failed to read block groups: =
-5
>>> [ 1087.851674] BTRFS error (device sda2): open_ctree failed
>>> ```
>>> does it mean my extent tree is still intact? so I need to btrfs ins
>>> dump-tree, btrfs-map-logical?
>>> thanks!
>>
>> Yep, you need to corrupt the extent tree to rescue the data, ironically.
>>
>> Thanks,
>> Qu
>>>
>>> On 7/14/21, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>>
>>>>
>>>> On 2021/7/14 =E4=B8=8B=E5=8D=885:58, Zhenyu Wu wrote:
>>>>> ```
>>>>> [  301.533172] BTRFS info (device sda2): unrecognized rescue option
>>>>> 'ibadroots'
>>>>> [  301.533209] BTRFS error (device sda2): open_ctree failed
>>>>> ```
>>>>>
>>>>> Does ibadroots need a newer version of btrfs? My btrfs version is
>>>>> 5.10.1.
>>>>
>>>> Oh, that support is added in v5.11...
>>>>
>>>> You may want to grab a liveCD from some rolling release.
>>>>
>>>> But even with v5.11, it may not help much, as that option won't help i=
f
>>>> your extent tree is still intact.
>>>>
>>>> You may want to use "btrfs ins dump-tree" to locate your extent tree,
>>>> then corrupt the extent tree root completely (using btrfs-map-logical =
to
>>>> get the physical offset, then dd to destory the first 4 bytes of both
>>>> copy), then the option would properly work.
>>>>
>>>> Thanks,
>>>> Qu
>>>>>
>>>>> Thanks!
>>>>>
>>>>> On 7/14/21, Qu Wenruo <wqu@suse.com> wrote:
>>>>>>
>>>>>>
>>>>>> On 2021/7/14 =E4=B8=8B=E5=8D=884:49, Zhenyu Wu wrote:
>>>>>>> sorry for late:(
>>>>>>>
>>>>>>> I found <https://bbs.archlinux.org/viewtopic.php?id=3D233724> looks
>>>>>>> same
>>>>>>> as my situation. But in my computer (boot from live usb) `btrfs che=
ck
>>>>>>> --init-extent-tree` output a lot of non-ascii character (maybe
>>>>>>> because
>>>>>>> ansi escape code mess the terminal)
>>>>>>> after several days it outputs `7/7`and `killed`. The solution looks
>>>>>>> failed.
>>>>>>>
>>>>>>> I'm sorry because my live usb don't have smartctl :(
>>>>>>>
>>>>>>> ```
>>>>>>> $ hdparm -W0 /dev/sda
>>>>>>> /dev/sda:
>>>>>>>      setting drive write-caching to 0 (off)
>>>>>>>      write-caching =3D  0 (off)
>>>>>>> ```
>>>>>>>
>>>>>>> But now the btrfs partition still cannot be mounted.
>>>>>>>
>>>>>>> when I try to mount it with `usebackuproot`, it will output the sam=
e
>>>>>>> error message. And dmesg will output
>>>>>>> ```
>>>>>>> [250062.064785] BTRFS warning (device sda2): 'usebackuproot' is
>>>>>>> deprecated, use 'rescue=3Dusebackuproot' instead
>>>>>>> [250062.064788] BTRFS info (device sda2): trying to use backup root
>>>>>>> at
>>>>>>> mount time
>>>>>>> [250062.064789] BTRFS info (device sda2): disk space caching is
>>>>>>> enabled
>>>>>>> [250062.064790] BTRFS info (device sda2): has skinny extents
>>>>>>> [250062.208403] BTRFS info (device sda2): bdev /dev/sda2 errs: wr 0=
,
>>>>>>> rd 0, flush 0, corrupt 5, gen 0
>>>>>>> [250062.277045] BTRFS critical (device sda2): corrupt leaf: root=3D=
2
>>>>>>> block=3D273006592 slot=3D17 bg_start=3D1104150528 bg_len=3D10737418=
24,
>>>>>>> invalid
>>>>>>> block group used, have 1073754112 expect [0, 1073741824)
>>>>>>
>>>>>> Looks like a bad extent tree re-initialization, a bug in btrfs-progs
>>>>>> then.
>>>>>>
>>>>>> For now, you can try to mount with "ro,rescue=3Dibadroots" to see if=
 it
>>>>>> can be mounted RO, then rescue your data.
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>> [250062.277048] BTRFS error (device sda2): block=3D273006592 read t=
ime
>>>>>>> tree block corruption detected
>>>>>>> [250062.291924] BTRFS critical (device sda2): corrupt leaf: root=3D=
2
>>>>>>> block=3D273006592 slot=3D17 bg_start=3D1104150528 bg_len=3D10737418=
24,
>>>>>>> invalid
>>>>>>> block group used, have 1073754112 expect [0, 1073741824)
>>>>>>> [250062.291927] BTRFS error (device sda2): block=3D273006592 read t=
ime
>>>>>>> tree block corruption detected
>>>>>>> [250062.291943] BTRFS error (device sda2): failed to read block
>>>>>>> groups:
>>>>>>> -5
>>>>>>> [250062.292897] BTRFS error (device sda2): open_ctree failed
>>>>>>> ```
>>>>>>>
>>>>>>> If don't usebackuproot, dmesg will output the same log except the
>>>>>>> first
>>>>>>> 2
>>>>>>> lines.
>>>>>>>
>>>>>>> Now btrfs check can check this partition:
>>>>>>>
>>>>>>> ```
>>>>>>> $ btrfs check /dev/sda2 2>&1|tee check.txt
>>>>>>> # see attachment
>>>>>>> ```
>>>>>>>
>>>>>>> Does my disk have any hope to be rescued?
>>>>>>> thanks!
>>>>>>>
>>>>>>> On 7/11/21, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2021/7/11 =E4=B8=8B=E5=8D=887:37, Forza wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 2021-07-11 10:59, Zhenyu Wu wrote:
>>>>>>>>>> Sorry for my disturbance.
>>>>>>>>>> After a dirty reboot because of a computer crash, my btrfs
>>>>>>>>>> partition
>>>>>>>>>> cannot be mounted. The same thing happened before, but now `btrf=
s
>>>>>>>>>> rescue zero-log` cannot work.
>>>>>>>>>> ```
>>>>>>>>>> $ uname -r
>>>>>>>>>> 5.10.27-gentoo-x86_64
>>>>>>>>>> $ btrfs rescue zero-log /dev/sda2
>>>>>>>>>> Clearing log on /dev/sda2, previous log_root 0, level 0
>>>>>>>>>> $ mount /dev/sda2 /mnt/gentoo
>>>>>>>>>> mount: /mnt/gentoo: wrong fs type, bad option, bad superblock on
>>>>>>>>>> /dev/sda2, missing codepage or helper program, or other error.
>>>>>>>>>> $ btrfs check /dev/sda2
>>>>>>>>>> parent transid verify failed on 34308096 wanted 962175 found
>>>>>>>>>> 961764
>>>>>>>>>> parent transid verify failed on 34308096 wanted 962175 found
>>>>>>>>>> 961764
>>>>>>>>>> parent transid verify failed on 34308096 wanted 962175 found
>>>>>>>>>> 961764
>>>>>>>>>> Ignoring transid failure
>>>>>>>>>> leaf parent key incorrect 34308096
>>>>>>>>>> ERROR: failed to read block groups: Operation not permitted
>>>>>>>>>> ERROR: cannot open file system
>>>>>>>>>> $ dmesg 2>&1|tee dmesg.txt
>>>>>>>>>> # see attachment
>>>>>>>>>> ```
>>>>>>>>>> Like `mount -o ro,usebackuproot` cannot work, too.
>>>>>>>>>>
>>>>>>>>>> Thanks for any help!
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Hi!
>>>>>>>>>
>>>>>>>>> Parent transid failed is hard to recover from, as mentioned on
>>>>>>>>> https://btrfs.wiki.kernel.org/index.php/FAQ#How_do_I_recover_from=
_a_.22parent_transid_verify_failed.22_error.3F
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I see you have "corrupt 5" sectors in dmesg. Is your disk healthy=
?
>>>>>>>>> You
>>>>>>>>> can check with "smartctl -x /dev/sda" to determine the health.
>>>>>>>>>
>>>>>>>>> One way of avoiding this error is to disable write-cache. Parent
>>>>>>>>> transid
>>>>>>>>> failed can happen when the disk re-orders writes in its write cac=
he
>>>>>>>>> before flushing to disk. This violates barriers, but it is
>>>>>>>>> unfortately
>>>>>>>>> common. If you have a crash, SATA bus reset or other issues,
>>>>>>>>> unwritten
>>>>>>>>> content is lost. The problem here is the re-ordering. The
>>>>>>>>> superblock
>>>>>>>>> is
>>>>>>>>> written out before other metadata (which is now lost due to the
>>>>>>>>> crash).
>>>>>>>>
>>>>>>>> To be extra accurate, all filesysmtems have taken the re-order int=
o
>>>>>>>> consideration.
>>>>>>>> Thus we have flush (or called barrier) command to force the disk t=
o
>>>>>>>> write all its cache back to disk or at least non-volatile cache.
>>>>>>>>
>>>>>>>> Combined with mandatory metadata CoW, it means, no matter what the
>>>>>>>> disk
>>>>>>>> re-order or not, we should only see either the newer data after th=
e
>>>>>>>> flush, or the older data before the flush.
>>>>>>>>
>>>>>>>> But unfortunately, hardware is unreliable, sometimes even lies abo=
ut
>>>>>>>> its
>>>>>>>> flush command.
>>>>>>>> Thus it's possible some disks, especially some cheap RAID cards,
>>>>>>>> tend
>>>>>>>> to
>>>>>>>> just ignore such flush commands, thus leaves the data corrupted
>>>>>>>> after
>>>>>>>> a
>>>>>>>> power loss.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Qu
>>>>>>>>
>>>>>>>>>
>>>>>>>>> You disable write cache with "hdparm -W0 /dev/sda". It might be
>>>>>>>>> worth
>>>>>>>>> adding this to a cron-job every 5 minutes or so, as the setting i=
s
>>>>>>>>> not
>>>>>>>>> persistent and can get reset if the disk looses power, goes to
>>>>>>>>> sleep,
>>>>>>>>> etc.
>>>>>>>>
>>>>>>
>>>>>>
>>>>
>>
>=20

