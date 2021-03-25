Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248A2348E04
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Mar 2021 11:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhCYK3g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Mar 2021 06:29:36 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:54573 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhCYK30 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Mar 2021 06:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616668173; x=1648204173;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=FgRughdqsIYGrA/ciRbK3zikGPB8qfO5XLeKYMN8hsc=;
  b=nNAq6InXQ0VdNWN0hW/mCOOcwg4sZ1PwxT9Fn/C5cLUJJbiFKWKWemlU
   6vavYNK2+St/mPF69UFDrGj6vl7t06w9tmFnr/hC6RNxiUJZFgFUGTHwr
   adT5PdH8f5yYOtbED31qyPx18JB7b+P36f/XIG17J0wZf6F0X9/BQn1GH
   kdpjaVnbIa74oNV9R93XCzIIr/7h8b/RPQhClm7QTzsjv5iZtaHGfwv40
   LV7mAUMfJNqrkLgtasSX5GnTOx+PEO8jL+E0nx7mB6WtT71dO7wxFZW/m
   mNtqAIm1Y6iNPcKk7kt3Fg/H7hhfEb3d6hKKoKxlepk8puA3cdUr3f7cF
   w==;
IronPort-SDR: L/Vw8lLeWmGjc+kJj9BYDmfTuwJayDWT9J1D0ZNrMEqiPWD2Ao9RQxzRfJm4sevEDFUq/crTBZ
 +ZK2jWMtzExTKDvl7hwYZ9oKu5dRg5weI2X++GTj+ZQ5aqg17biDQ8d3oB79SA4y7zOyn6UGnh
 mhGwFsFAJkVj+QKFf7ew0ZKrBolgXO9ciZyMPMJStLhJc0UY+431jz8ZCl2HxnY6IiKmlecie9
 F5Ml9dWO7OLGz6DnLbI0IgsM02F0PUltHQ2cGRXgLfu6Ei+5ByU9uquaQPZgU+yFE3h3E58xfM
 8RY=
X-IronPort-AV: E=Sophos;i="5.81,277,1610380800"; 
   d="scan'208";a="267399508"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2021 18:28:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgJhcq+g9rmbQhRLkqkR7duC8UedxEA1eH/NykunRnbQbe9FpDdRcM2TcJA4d9SaCV+GEBTosHXP3VUkKl8umAZUoAv1etsU7uaCb/t+cmDOj/z6NLybnlIm4xzCrPE32Ni5LHRUtpHtNJAKwHHGhg62GWH9H5IkiLYnOxZL+vsGR4ywAzmPN0hM1GQjbvW8iU4lVBC2JbixSV0UzZSz8IlPoEp0/fRtgzxeddALGZH9jZeU2SFtTP8xWhNsQWzRgVAaPC5NyatLQ85BjehOmQxhq6oSYWa23cFmc/fgTtji+k6wsbILTS1bP+l7NI5ZiGsjw7dpqO4l59bDKfEyjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzNdX4Io/Xpn3hNxKJL0r5BIRl93+leV1aXSiH4/06M=;
 b=cnJAxw7fzQHxdAfAZb+ZABrxgZolM3wZVH3jzQOWgAbGGs3r26nuSf/xmOptitmOEABRHnNIieq/OigbgyM5GrEoE2NVd93DeM57y7QXsyEshOcv122A/Vl7BrWEVR9nHZ8AZs7u5zy/IYxWFgxDf4bsrQZrMVrC8VD8u4Qv1CEBT4zQse7FAuq0Cns0sf9TWjs30JE3MqDbnUf8f7h9gT7F5Ef83lc6rex7/7Ades/orlQcw1wlJJfqt69II0863+JGd4wxRF4HmbGJeXq8cv22P8EcZoUkhaf12W5i9TBb/qQGBLUyz4qTqksTUPVOXYAe0AjhO6ncWlaxuIWX3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzNdX4Io/Xpn3hNxKJL0r5BIRl93+leV1aXSiH4/06M=;
 b=THJIfJVXzVPFeg3u6En3hNjdDmEPuqhXUEt6Eu8TC0nlMy3G0WBRAIQ+5jxFGgn5qx0yXeh+naVhmVzgwQlPsuRHF2NlzVgY4mb3ARI0ZQw3esofJUG2GzMNHo8WhP8xVQOL6ue0ZQ5k09Kh+oba/KmC+9lk6VJ3h5aq3nwzzlw=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SA0PR04MB7451.namprd04.prod.outlook.com (2603:10b6:806:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Thu, 25 Mar
 2021 10:28:45 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::d5c:2f7d:eadc:f630]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::d5c:2f7d:eadc:f630%6]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 10:28:45 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@gmail.com" <fdmanana@gmail.com>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2 2/2] btrfs: zoned: automatically reclaim zones
Thread-Topic: [PATCH v2 2/2] btrfs: zoned: automatically reclaim zones
Thread-Index: AQHXHK2AfFCIp/xNUkKXsYwy3dEAHQ==
Date:   Thu, 25 Mar 2021 10:28:45 +0000
Message-ID: <SA0PR04MB741837B5B80B4EF2196C6A3B9B629@SA0PR04MB7418.namprd04.prod.outlook.com>
References: <cover.1616149060.git.johannes.thumshirn@wdc.com>
 <58648eb48c6cb2b35d201518c8dc430b7797bcaa.1616149060.git.johannes.thumshirn@wdc.com>
 <CAL3q7H6ocp=t_-gdhbTVNiZCeTRRfFFm=F0j7g197qjKp+JzUg@mail.gmail.com>
 <PH0PR04MB74166BD048A352EB9B43786D9B649@PH0PR04MB7416.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:49ae:1f03:f20b:3ca]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 082603fc-c15a-41ea-4864-08d8ef78c500
x-ms-traffictypediagnostic: SA0PR04MB7451:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR04MB745157F2254FAC0DD6A027589B629@SA0PR04MB7451.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:813;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aTw/6mmTaXzCWf4A+oCpmj55VQukhXS/LD2CKTsEYz5WjLQ+Z5gHVmfWz0Ik66ILkNvqEp5adP5aghEeGY4kHIn/9yRJzdsbq5cej/TqrEcLAmTPHH1djjr9LcCdo9XnLCD5oJ+gG76M9g6Ek0Nk7hDh63h8E+q2SYEZQo1fFi4JVStSBXKoAe0WNU6ZwQhjKC0a+sckzAl6aCZVUExtJfXE8Laq2Cw77dgjKE/nhOE6s7ccWsKQo1xnNxmumXOVwUEgqmRgz0xoWhH4zQ0AHyhyvD+IQ/Sypompwin2eO9ExJ82s1G1+eliLblh2AoJ3JoA7Air6a0FjGWEGxBB7rYW2XjgnZSVOJ6hDGxdD8JRdlEW7OMOuUoC60OAbFEyCjR76NIqZtmG6AwsKknW8Q6etqimNIw6l4mhykp5vdnXN7f2yKXk0iPnGrr9pY+o3XbcBwohT730rr9ZCwiNmfzvYirQJoPF562OikS7CuABph0XsqUdU6pZWb0BVwAQsv7jtQh/bA9i+xjUhgieCjUhXj5RMDZmSEjcmQNPSwj8VUXAJlP06SKbNRMyYMhpA5KX2Sdimvp4XOlV0bWcnUfcdgmjmYMhUylWWL2MzzfbhHqEMyklPcnKa11R2wfucnungs8YH72pMs/jLJ26NJ/hZSQ2MNWLGjVtYbtG8Rs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(8676002)(33656002)(8936002)(83380400001)(478600001)(6506007)(53546011)(66446008)(64756008)(54906003)(52536014)(91956017)(71200400001)(66946007)(4326008)(2906002)(6916009)(7696005)(66476007)(66556008)(38100700001)(9686003)(76116006)(86362001)(5660300002)(186003)(316002)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?KWBw/SRWqWdu89t4Qtl4xjPVDIe2MAbjScXmYw5KMq5woVqci0CgR5K8eRV+?=
 =?us-ascii?Q?ZT5y3MZbh2J6T+fxYkUjBu9yAu04iVBzxxEFEEgTjt0zE31jgW1t3nOWCeOd?=
 =?us-ascii?Q?2jZpRtUyeoz5amJhhKGdmrsieJAVhmzhenidZDwKkG3ZjJNNtxbNIA5/3JPq?=
 =?us-ascii?Q?6gNenXaByV5SR1anwCcWWFIPptQf8uYPkFXuMbI0SkotCXfuZq8mGjVjqKn2?=
 =?us-ascii?Q?E2c64FB54Ok2DQnrQnpZ+XhT69ZimRnPELioHjlMOd0HsJDyBSFuA0bijUUR?=
 =?us-ascii?Q?hpqpaKq7kv/RQiUhCbCI5Orjod7AexMQcvurGEHzKvym5e4sJehEfVi2rdLZ?=
 =?us-ascii?Q?Z0UHjpGupa8iDnE0vwBgck90Nf+BxUdmeIduM7Kh2MiyUott/1sIUkyDkwpb?=
 =?us-ascii?Q?SbW0sVpTdhYAc9Mnptlv1RUcCL2pDbomgSowjK8mI1JqiG6OSol+eIvpA5NF?=
 =?us-ascii?Q?q9vhUDw2ioU0/soiZ7egisFn1O3JysbfGkugWWzEvZ601IDc5VnwmHA3kaDf?=
 =?us-ascii?Q?saGbIu/Cqe6V/cQ0KPaK+jRyVCr+iJFSSzx/IzQoki56j9nUFur2rd5516Q6?=
 =?us-ascii?Q?1KJz0nXJvAGqJOGPInXOBnnWnJX9mCBzOWZ7f2RrY/cbCymmlxA6+tEc+Irb?=
 =?us-ascii?Q?OwgO4sibMClxYNB9tnQuwG1PsIYY85ro7LrrDU95CcXGnZVKfed3z5ZwXUx/?=
 =?us-ascii?Q?ObdXkX6DvV8o1c/B4woLwhaA5YragYO9rhJQWIvVL5rkP4orBqADe2tRfmap?=
 =?us-ascii?Q?vlvn9C/RqOXDyvKIpMcU4LXh6lN0FbBA+LM17GB0vf1NfuCO1nWc7a/GsifQ?=
 =?us-ascii?Q?Wb2lAzj1l2soR4c7I61n56jVtEU1jThw1N8abPmk+01eyrqvr/qtDrN/Gmex?=
 =?us-ascii?Q?jupEleyi1IVXmkvX6swjORPINzC87YMFoE34FWIk3+x4XnOBf6F2I3ptS2u5?=
 =?us-ascii?Q?/32dfeNB7IY+gsdV8ln7MWy06tdGCfhOJ8GCaToCDhwEXIRM5NPctUNQXSi4?=
 =?us-ascii?Q?kNAfPsRRLDcmWke6hDrjJ5KMwLyE4qhl9k9Qi8pu2RXmsMCVJ2BNQ1Agx0gM?=
 =?us-ascii?Q?h1KYQxOq63GXbdFubLIBrh9eJ6td4YcppoTS19Q5rOmDabT0hZRbPAAR1n8d?=
 =?us-ascii?Q?jk61ZIw277eE8lU0omKYKVJQyDuUrH9ii8/sMemw9DekNjsJFYU5aAAggh0b?=
 =?us-ascii?Q?AjPD5SpwZLBOMzXPfRndA6xql7uOsQ+ly7zErWM1mx5qrLVjKbYSGD53fgOl?=
 =?us-ascii?Q?qiMLQwvvrmnNx2DvoSzEzUb3xOmklGFy3nhtP6wBMbaK3tiVfUFhITLx4V4X?=
 =?us-ascii?Q?SvBCsQLQw1NRSBjKqhg2x6uxxmndVHI2gMWg/ofEqUqcawkStcG3Do73txHV?=
 =?us-ascii?Q?Y308ccj62t5dmB5e6APf6ngLzc2FYilDSMcV8hBkpa/cQ4dwiw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 082603fc-c15a-41ea-4864-08d8ef78c500
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2021 10:28:45.1178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qCi/TZgAuOBsfBwjQpM0Cor4PZTzFNCPTwuzcTlKrH4+TTpetvN4hZ2UUTrd4zO6JS0bmVSvr2w1ZbxAYyofVd+UQjDyp+ovKuAY0//OQes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7451
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 23/03/2021 11:22, Johannes Thumshirn wrote:=0A=
> On 23/03/2021 10:57, Filipe Manana wrote:=0A=
>> On Fri, Mar 19, 2021 at 10:52 AM Johannes Thumshirn=0A=
>> <johannes.thumshirn@wdc.com> wrote:=0A=
>>>=0A=
>>> When a file gets deleted on a zoned file system, the space freed is not=
=0A=
>>> returned back into the block group's free space, but is migrated to=0A=
>>> zone_unusable.=0A=
>>>=0A=
>>> As this zone_unusable space is behind the current write pointer it is n=
ot=0A=
>>> possible to use it for new allocations. In the current implementation a=
=0A=
>>> zone is reset once all of the block group's space is accounted as zone=
=0A=
>>> unusable.=0A=
>>>=0A=
>>> This behaviour can lead to premature ENOSPC errors on a busy file syste=
m.=0A=
>>>=0A=
>>> Instead of only reclaiming the zone once it is completely unusable,=0A=
>>> kick off a reclaim job once the amount of unusable bytes exceeds a user=
=0A=
>>> configurable threshold between 51% and 100%. It can be set per mounted=
=0A=
>>> filesystem via the sysfs tunable bg_reclaim_threshold which is set to 7=
5%=0A=
>>> per default.=0A=
>>>=0A=
>>> Similar to reclaiming unused block groups, these dirty block groups are=
=0A=
>>> added to a to_reclaim list and then on a transaction commit, the reclai=
m=0A=
>>> process is triggered but after we deleted unused block groups, which wi=
ll=0A=
>>> free space for the relocation process.=0A=
>>>=0A=
>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>>> ---=0A=
>>>=0A=
>>> AFAICT sysfs_create_files() does not have the ability to provide a is_v=
isible=0A=
>>> callback, so the bg_reclaim_threshold sysfs file is visible for non zon=
ed=0A=
>>> filesystems as well, even though only for zoned filesystems we're addin=
g block=0A=
>>> groups to the reclaim list. I'm all ears for a approach that is sensibl=
e in=0A=
>>> this regard.=0A=
>>>=0A=
>>>=0A=
>>>  fs/btrfs/block-group.c       | 84 ++++++++++++++++++++++++++++++++++++=
=0A=
>>>  fs/btrfs/block-group.h       |  2 +=0A=
>>>  fs/btrfs/ctree.h             |  3 ++=0A=
>>>  fs/btrfs/disk-io.c           | 11 +++++=0A=
>>>  fs/btrfs/free-space-cache.c  |  9 +++-=0A=
>>>  fs/btrfs/sysfs.c             | 35 +++++++++++++++=0A=
>>>  fs/btrfs/volumes.c           |  2 +-=0A=
>>>  fs/btrfs/volumes.h           |  1 +=0A=
>>>  include/trace/events/btrfs.h | 12 ++++++=0A=
>>>  9 files changed, 157 insertions(+), 2 deletions(-)=0A=
>>>=0A=
>>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c=0A=
>>> index 9ae3ac96a521..af9026795ddd 100644=0A=
>>> --- a/fs/btrfs/block-group.c=0A=
>>> +++ b/fs/btrfs/block-group.c=0A=
>>> @@ -1485,6 +1485,80 @@ void btrfs_mark_bg_unused(struct btrfs_block_gro=
up *bg)=0A=
>>>         spin_unlock(&fs_info->unused_bgs_lock);=0A=
>>>  }=0A=
>>>=0A=
>>> +void btrfs_reclaim_bgs(struct btrfs_fs_info *fs_info)=0A=
>>> +{=0A=
>>> +       struct btrfs_block_group *bg;=0A=
>>> +       struct btrfs_space_info *space_info;=0A=
>>> +       int ret =3D 0;=0A=
>>> +=0A=
>>> +       if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))=0A=
>>> +               return;=0A=
>>> +=0A=
>>> +       if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE))=0A=
>>> +               return;=0A=
>>> +=0A=
>>> +       mutex_lock(&fs_info->reclaim_bgs_lock);=0A=
>>> +       while (!list_empty(&fs_info->reclaim_bgs)) {=0A=
>>> +               bg =3D list_first_entry(&fs_info->reclaim_bgs,=0A=
>>> +                                     struct btrfs_block_group,=0A=
>>> +                                     bg_list);=0A=
>>> +               list_del_init(&bg->bg_list);=0A=
>>> +=0A=
>>> +               space_info =3D bg->space_info;=0A=
>>> +               mutex_unlock(&fs_info->reclaim_bgs_lock);=0A=
>>> +=0A=
>>> +               /* Don't want to race with allocators so take the group=
s_sem */=0A=
>>> +               down_write(&space_info->groups_sem);=0A=
>>> +=0A=
>>> +               spin_lock(&bg->lock);=0A=
>>> +               if (bg->reserved || bg->pinned || bg->ro) {=0A=
>>> +                       /*=0A=
>>> +                        * We want to bail if we made new allocations o=
r have=0A=
>>> +                        * outstanding allocations in this block group.=
  We do=0A=
>>> +                        * the ro check in case balance is currently ac=
ting on=0A=
>>> +                        * this block group.=0A=
>>> +                        */=0A=
>>> +                       spin_unlock(&bg->lock);=0A=
>>> +                       up_write(&space_info->groups_sem);=0A=
>>> +                       goto next;=0A=
>>> +               }=0A=
>>> +               spin_unlock(&bg->lock);=0A=
>>> +=0A=
>>> +               ret =3D inc_block_group_ro(bg, 0);=0A=
>>> +               up_write(&space_info->groups_sem);=0A=
>>> +               if (ret < 0) {=0A=
>>> +                       ret =3D 0;=0A=
>>> +                       goto next;=0A=
>>> +               }=0A=
>>> +=0A=
>>> +               btrfs_info(fs_info, "reclaiming chunk %llu", bg->start)=
;=0A=
>>> +               trace_btrfs_reclaim_block_group(bg);=0A=
>>> +               ret =3D btrfs_relocate_chunk(fs_info, bg->start);=0A=
>>=0A=
>> I think you forgot to test this with lockdep enabled, it should have=0A=
>> complained loudly otherwise.=0A=
>>=0A=
>> btrfs_relocate_chunk() calls lockdep_assert_head() to verify we are=0A=
>> holding fs_info->reclaim_bgs_lock,=0A=
>> but we just unlocked it.=0A=
> =0A=
> I thought I did, but you're right. I'll need to send a v3 anyways address=
ing=0A=
=0A=
OK as this was bugging me, I've found out the "hole" in my test routine. I'=
m=0A=
suffering from the internal lockdep HLOCK_CHAINS too low problem/bug, which=
 turns=0A=
lockdep validation off. This one triggers in xfstests before a block group =
is dirty=0A=
enough to start reclaim.=0A=
=0A=
