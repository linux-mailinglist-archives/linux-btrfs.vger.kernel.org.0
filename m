Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC2D345BD3
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Mar 2021 11:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbhCWKWU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Mar 2021 06:22:20 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:34855 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhCWKWJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Mar 2021 06:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616494929; x=1648030929;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=0H+vjFE7FaWiSk73XmvmRxcjQVDF/Eb0WNbbQYC/Riw=;
  b=lqeTT8j8baVjI3X13c1PQelMGvXVtq4r67HG6MHsYHWn2G6jPW/I2o/7
   8A+UapJq34vjfOfxHa2bCclt1ud6v2BaOURim/znrxm4r++SW7sd6jwrz
   /bOAHsz62OplqzqUopVFUpp/OMPL8cfSkIpas+yYQznftTa8IexVA3oQ2
   rndJFNTHyP2ylfT7o2RHhpyCVXprpFqUVa56auNnvuSh36+2LK6peY/AF
   y/kUxbHhxTl6t4nCER2H9FSSqcmP+XGFTnpDtnz3wdtlT/iwovjC3PYWE
   OsLCxSBKAIZqR5RdXYiW/nPXr4ikq5TdrpozRSke9XVHOazV/KzHk/3Ld
   w==;
IronPort-SDR: a4QDHvneuo9luD9QRVcbqnlbFHlmluyO95IRcK/j50DaavlLdpe3195yKV5CUZapvbH5+CMpDV
 ev76bxauJR4HjYJCaMQYZ96acxuLxCdW61EzwXai/eXSBh33kGZbHWjSJcgKoGoYxac8TNDcxy
 yDuCeUgvnPo9ETjc4JtDl/nQAjndRJb5i7Yu8PA7u8G8ALwGSLlI38L9n/H5cmB+86KNeRKLDT
 cjOAdtC/+4/2743JnHDopOPVcSP0CX6rmp7yrQXW9y3/QPI/9HjIEmOlYYpE74poX0YmVUNdFT
 8D8=
X-IronPort-AV: E=Sophos;i="5.81,271,1610380800"; 
   d="scan'208";a="167261324"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2021 18:22:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYlH6jCSdGytbS768IBHwbONEJxBAbqp2JoVvs9BUfk9C5ss6ZgxZhiwVDb3LaGwFZ1wAZRPPDTnDTC+q3mWApeGOofwRsgLL0t7dR8UZRMfvFlNvLp1O5mg52pXBYNX2ba9RnD/B9D4JU4dmVOPODdhFfhguBFDDrSUhcA87rtT0cFedrvFmq4TPphOFeEenKq4l8/JB4Y9HJtPjDX6QC7ypseNRaBQ1J6P6ygQgc3ilB3cs0lMmF9CqYgvVg1tGaewM4+iEdDXKQmDVbZule5iaWqFoc4BEZmnuJyw3Q6BaplBsF2pdD8YMh+ZpUfJ4BMG5Yretor3F1fIjIKeDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoRzgijVBaEEzCzOK3+NP1UgwxBdy4Bu3b3cs9x1aI0=;
 b=aso9VzacXJHtPwGUIU8OI2gG9bkd/txKpRgXn+0etlAYBGvnfTG9l6N2sNtULiVwvbrIvBgqGD1anqB1wUwDrQSSqUExsLLVhThQ3xfQcBVGstuD7Z2jC4gi3yWb3bWqPItdzwz9IEvMceDeGYb4F7xKF2HhVwz2PGS0FcOUp3Si/9wCnCpzNZTrYdHg129I9994aJp0rhKCEyVmNo7YP9oBKdUXCo3KjE+L4ZQZ/HrwODUN68RCaG2kdC1LCy0EKCLzJ7KIE7vDWDYochXlpHrDVMUqfjE+CX3mG8LO1kaEhq98bDGboKXIhMdL2HmEUUZNQ/FnKexwLr0afv7F6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoRzgijVBaEEzCzOK3+NP1UgwxBdy4Bu3b3cs9x1aI0=;
 b=NgjmOLNToizK429ssXLS7kmtqnOhUSfzRggZH+3lwS0/6L2t0Sy7olG3Vc6ozXCrNz0650C9VqvgcTj4Z8OCd4aJUZf0kXWPLwGZm5GK2bdleFR0x0OSpT0BYotHbagFBNw701E3wT2g2nKShD4PVEhwXdRJsMnN30evATQekUQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7157.namprd04.prod.outlook.com (2603:10b6:510:d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 10:22:05 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725%7]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 10:22:05 +0000
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
Date:   Tue, 23 Mar 2021 10:22:05 +0000
Message-ID: <PH0PR04MB74166BD048A352EB9B43786D9B649@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1616149060.git.johannes.thumshirn@wdc.com>
 <58648eb48c6cb2b35d201518c8dc430b7797bcaa.1616149060.git.johannes.thumshirn@wdc.com>
 <CAL3q7H6ocp=t_-gdhbTVNiZCeTRRfFFm=F0j7g197qjKp+JzUg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.84]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 914c0b4e-5f2a-480d-9d73-08d8ede581c9
x-ms-traffictypediagnostic: PH0PR04MB7157:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7157AAB4D140DF78EC541DAA9B649@PH0PR04MB7157.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:209;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VZ9JwWIh8KjhFluN3xVmPw8CPHtMdQlskC4zd9GsrLtogDiUM0Dotx/DOJgQWwaIAY+PQx3ot2n5asnpva383WuF+e7ubil79PmyQLEOqloGLLzMzheGa7PCuC+OjVyJ1RZBmsOSL1Wn2wIGL6jjwogreKEYXHJzaQXg/t6uVMWu5GmtwlP0gmcgi3eo9DVNDgS4i0PmDhGPOgQl7ncCLOW8brdyR2n3wtPPrNnfQzeHZ4FkuMzsjEzDfuCW0ddH6ScyplbcWrkanjUijg1slVChx7jV4c2klqHilOGI0z9w2ad8I4y7PAxR1wzqoRNMxB0y4bL4VypLsawAS2bSY6QlwBUxnnF2AAxK7EBpDLKVJPgvjGGD7ezkdqVEg+TygnkuBRHcv56gXeEA++a4Zf80X1lOafn8XkTAA9xGLUuh4iF28VpQEM7iu5QFnALkOZF3XCj1wNBxK9/VkHmbROqilZjgoB7B/bpkaeSZ+0pu/+HVFCVeoINPRhwQKFACTmy19ycpYJ2FF+09eLZbwWnQwwf39YgLKN+9T3/SV0KEp/1jgcgg71d59kZB1w+CtBDe+zZUeQ90XGsSnObmvvnv/QDhmRgN8/y00jlF4TmgCNsPsopVEldsQYE2kuwEexdauzCnssEXp2Zs8QMApGz9G824zbgqywItsyPKl6U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(7696005)(54906003)(316002)(26005)(186003)(55016002)(33656002)(4326008)(5660300002)(53546011)(71200400001)(6506007)(9686003)(8936002)(91956017)(86362001)(52536014)(83380400001)(8676002)(478600001)(38100700001)(66476007)(76116006)(2906002)(64756008)(66446008)(6916009)(66946007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?O13HwE72IFEijFPppwAHu/Bmq9VOZIBaW0X0sUJYUHISJhJ39abvvNt/UFu+?=
 =?us-ascii?Q?EfEtd+tyHqm4y6loeLZCoZkApOqXkWtfWCsgbb1G+H0VjbHeYRzeh9Z/X3IO?=
 =?us-ascii?Q?n9ugFdr6cI4aWAjb0POk/RZtoqPO85x+FTgJgeUK8VbYwYc+UhiQmCJZ7nVG?=
 =?us-ascii?Q?Y5XQVY7mQzrWcVYmSgEOc35Iq3BuAVL1iSQT/ECU2e2Qsw9K+BfWMENVvRw8?=
 =?us-ascii?Q?kJeRkxEm2pHxYmPjUEzdbLpGtM3kAw1LoUGAH5Kbr1TIRhQ0NvAD+Kq2Ao2u?=
 =?us-ascii?Q?TTCBL1uXKdifBNXtv4n911fFENh+ut9p887TQEZ12ha8ISbJ2IiWLKwzshJj?=
 =?us-ascii?Q?d6SmTQKLWuxhz7r+dlYR+QLC/LOxgbEqClcEVBQHq6fOm371422S176dbX4/?=
 =?us-ascii?Q?jQ2uhNjTBCtjNLwn6MJSUA79Y72UqRFGAJOMyzNgwb++HKhrs+9ETV/PxmLO?=
 =?us-ascii?Q?BHHrIGtisEi8D+kODXe5RST9ccoS8j8WroZY7CK/D+wgLP/RZtcA/JM7LeWI?=
 =?us-ascii?Q?6dqSQktpsC3WhI4QWMOjdoQPdOcGMblEAr2DAecwxyjEW22gD8tyRA3yFvgl?=
 =?us-ascii?Q?mlmlejK7GI5s3q/fzRcZCIWaLsahuhOaGpVRRmE9bVmDzguCUJtmtEd7pCss?=
 =?us-ascii?Q?YcQbT2La/rDcDiOTBfpDl0LXJNB0nzJiiTRM8q1m6xhR5RqnH+Q9mzGCyJB2?=
 =?us-ascii?Q?hu3dWr+ca4K2QJwAftYPE1XeLmsArFYw5z59C44+Yx/JMjPTLZMh9NtSTbQG?=
 =?us-ascii?Q?8RhoLVIg+MuHCfMCz1SVUBUy7d0GDS1y+5hO1+iQq7l0hTxT7xs2zLoYed8r?=
 =?us-ascii?Q?0ZIgrPxs8zp5n5iMTN9/xvk1q8LiNXeBrA6jD3U3XFP6Wm3QzI4KTWZvIkC+?=
 =?us-ascii?Q?bGV8O2vywji3MrYObeQlnZH4eapprCU/MWpffC1jzwe3sFzEHCQor3NmueMF?=
 =?us-ascii?Q?sl+Az+Mx9JuOLtnlDEzrS5Gyqo/bR4s4V3TvOZj1+a+nHyXATc+idfUDERV/?=
 =?us-ascii?Q?gLs74KVkppYKx2OQs1K/AEG1/LAhZ1+5K1BRFy//DIE2GJBngfLQam38ae66?=
 =?us-ascii?Q?BmiFPvwrfLB39k7SWF+1YCrhJBb8gkoaotubyjMtacZfRdFC7ZIMLEZU9LhX?=
 =?us-ascii?Q?dw+fWmyAlpO1mQbXSzaJghWv0WaVsZfsmZwKhR0nJNwzpEUTNPIwEKLsWa0S?=
 =?us-ascii?Q?rKpIGHHXW6RGhCWUG6p8AU3rnNB4Qor6t2QtvGvVkT37KrLC03MNn/F1Nynz?=
 =?us-ascii?Q?QywFriNwXUEEcoB/vl7uy0ADcVV800CQ3cBxTH2klO5IBdiAibeNlgHvFZ+M?=
 =?us-ascii?Q?9GJM/mJRMvYwgU1Rptq2pSkp2oF/SxTWNVKyVyU65Qm7Jg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 914c0b4e-5f2a-480d-9d73-08d8ede581c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 10:22:05.2448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7i0KJOxl8nfycKpk4NZejMWueaXd/4h09NSj1Z+yOzP6rB45q6ujsGFq6qEsU/aRpTF31XRY+RC3U8qdnGEwJLPXOT0pMKeS+YF+qkOr+wM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7157
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 23/03/2021 10:57, Filipe Manana wrote:=0A=
> On Fri, Mar 19, 2021 at 10:52 AM Johannes Thumshirn=0A=
> <johannes.thumshirn@wdc.com> wrote:=0A=
>>=0A=
>> When a file gets deleted on a zoned file system, the space freed is not=
=0A=
>> returned back into the block group's free space, but is migrated to=0A=
>> zone_unusable.=0A=
>>=0A=
>> As this zone_unusable space is behind the current write pointer it is no=
t=0A=
>> possible to use it for new allocations. In the current implementation a=
=0A=
>> zone is reset once all of the block group's space is accounted as zone=
=0A=
>> unusable.=0A=
>>=0A=
>> This behaviour can lead to premature ENOSPC errors on a busy file system=
.=0A=
>>=0A=
>> Instead of only reclaiming the zone once it is completely unusable,=0A=
>> kick off a reclaim job once the amount of unusable bytes exceeds a user=
=0A=
>> configurable threshold between 51% and 100%. It can be set per mounted=
=0A=
>> filesystem via the sysfs tunable bg_reclaim_threshold which is set to 75=
%=0A=
>> per default.=0A=
>>=0A=
>> Similar to reclaiming unused block groups, these dirty block groups are=
=0A=
>> added to a to_reclaim list and then on a transaction commit, the reclaim=
=0A=
>> process is triggered but after we deleted unused block groups, which wil=
l=0A=
>> free space for the relocation process.=0A=
>>=0A=
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>> ---=0A=
>>=0A=
>> AFAICT sysfs_create_files() does not have the ability to provide a is_vi=
sible=0A=
>> callback, so the bg_reclaim_threshold sysfs file is visible for non zone=
d=0A=
>> filesystems as well, even though only for zoned filesystems we're adding=
 block=0A=
>> groups to the reclaim list. I'm all ears for a approach that is sensible=
 in=0A=
>> this regard.=0A=
>>=0A=
>>=0A=
>>  fs/btrfs/block-group.c       | 84 ++++++++++++++++++++++++++++++++++++=
=0A=
>>  fs/btrfs/block-group.h       |  2 +=0A=
>>  fs/btrfs/ctree.h             |  3 ++=0A=
>>  fs/btrfs/disk-io.c           | 11 +++++=0A=
>>  fs/btrfs/free-space-cache.c  |  9 +++-=0A=
>>  fs/btrfs/sysfs.c             | 35 +++++++++++++++=0A=
>>  fs/btrfs/volumes.c           |  2 +-=0A=
>>  fs/btrfs/volumes.h           |  1 +=0A=
>>  include/trace/events/btrfs.h | 12 ++++++=0A=
>>  9 files changed, 157 insertions(+), 2 deletions(-)=0A=
>>=0A=
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c=0A=
>> index 9ae3ac96a521..af9026795ddd 100644=0A=
>> --- a/fs/btrfs/block-group.c=0A=
>> +++ b/fs/btrfs/block-group.c=0A=
>> @@ -1485,6 +1485,80 @@ void btrfs_mark_bg_unused(struct btrfs_block_grou=
p *bg)=0A=
>>         spin_unlock(&fs_info->unused_bgs_lock);=0A=
>>  }=0A=
>>=0A=
>> +void btrfs_reclaim_bgs(struct btrfs_fs_info *fs_info)=0A=
>> +{=0A=
>> +       struct btrfs_block_group *bg;=0A=
>> +       struct btrfs_space_info *space_info;=0A=
>> +       int ret =3D 0;=0A=
>> +=0A=
>> +       if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))=0A=
>> +               return;=0A=
>> +=0A=
>> +       if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE))=0A=
>> +               return;=0A=
>> +=0A=
>> +       mutex_lock(&fs_info->reclaim_bgs_lock);=0A=
>> +       while (!list_empty(&fs_info->reclaim_bgs)) {=0A=
>> +               bg =3D list_first_entry(&fs_info->reclaim_bgs,=0A=
>> +                                     struct btrfs_block_group,=0A=
>> +                                     bg_list);=0A=
>> +               list_del_init(&bg->bg_list);=0A=
>> +=0A=
>> +               space_info =3D bg->space_info;=0A=
>> +               mutex_unlock(&fs_info->reclaim_bgs_lock);=0A=
>> +=0A=
>> +               /* Don't want to race with allocators so take the groups=
_sem */=0A=
>> +               down_write(&space_info->groups_sem);=0A=
>> +=0A=
>> +               spin_lock(&bg->lock);=0A=
>> +               if (bg->reserved || bg->pinned || bg->ro) {=0A=
>> +                       /*=0A=
>> +                        * We want to bail if we made new allocations or=
 have=0A=
>> +                        * outstanding allocations in this block group. =
 We do=0A=
>> +                        * the ro check in case balance is currently act=
ing on=0A=
>> +                        * this block group.=0A=
>> +                        */=0A=
>> +                       spin_unlock(&bg->lock);=0A=
>> +                       up_write(&space_info->groups_sem);=0A=
>> +                       goto next;=0A=
>> +               }=0A=
>> +               spin_unlock(&bg->lock);=0A=
>> +=0A=
>> +               ret =3D inc_block_group_ro(bg, 0);=0A=
>> +               up_write(&space_info->groups_sem);=0A=
>> +               if (ret < 0) {=0A=
>> +                       ret =3D 0;=0A=
>> +                       goto next;=0A=
>> +               }=0A=
>> +=0A=
>> +               btrfs_info(fs_info, "reclaiming chunk %llu", bg->start);=
=0A=
>> +               trace_btrfs_reclaim_block_group(bg);=0A=
>> +               ret =3D btrfs_relocate_chunk(fs_info, bg->start);=0A=
> =0A=
> I think you forgot to test this with lockdep enabled, it should have=0A=
> complained loudly otherwise.=0A=
> =0A=
> btrfs_relocate_chunk() calls lockdep_assert_head() to verify we are=0A=
> holding fs_info->reclaim_bgs_lock,=0A=
> but we just unlocked it.=0A=
=0A=
I thought I did, but you're right. I'll need to send a v3 anyways addressin=
g=0A=
Josef and Anand's comments.=0A=
=0A=
Thanks,=0A=
	Johannes=0A=
