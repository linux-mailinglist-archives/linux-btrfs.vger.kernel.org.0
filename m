Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4FF43E482
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Oct 2021 17:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhJ1PD3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Oct 2021 11:03:29 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:25931 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbhJ1PD3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Oct 2021 11:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1635433262; x=1666969262;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=3xSBQVQl3OYBrXV4yHEMv9EVV18nEgM4kbC/sBmq9AU=;
  b=ifFFYX9gO4e4jdwmUcW+Xa61wphJb4d5nqOmDZnRFy2fIxaY42wS6xd4
   UpWc9sO95dJ7ZRHynxNZmZ7b+BiYvNpGqTByGQu2Ur00g6LcHiaqly8bM
   f7E9EJ4HDXnc2rfwzCwvTIEXL98zCsIdEat1TAt/fA+GsoeA+Q6LiIBLr
   1pjmjPfNVDiq7btbK1sj4D1eF05DFPC/oa2nZ+swukPN5WKIbqUekXSFq
   b4rEEPfHscYI7Vcw5rOL+c69UDPvkzsrnYfa5EytLQD0kgXEHyHZXO+Ug
   8y1QShua+i+3WaQYWCsqgEdem66nvqDiPZR286gUeZwe89o7Z5Q7ivFjt
   A==;
X-IronPort-AV: E=Sophos;i="5.87,190,1631548800"; 
   d="scan'208";a="183084127"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2021 23:01:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrqCIsy7kxooEJCP9OFbMDdBqzxnwfMHQSxb82HJprouRtz4yNolJDBKkuFjthI/r8s77s9ki0b/rnpFskeutZ/r95JWcujtFpXMYvgZOE3yJBsW+68OqviiLcoeOf38yJfl0IQ6AV3h61JNzb+GGQI9bADet9AFBvWNvcvcyf2qNKkfpFbOzmETEg5gB5OqlYUJsht+/LhGUcwZ5djNgsOhQ5zLZuxfRA+FLVP9+HU0M1oT0OFJ6pwdKek8Zu9AuL1kThCC6KHL6W6ZJxozii5Ce/la+EUmkec6VW6kleCO2K8+5uu2hTwuPgHyCPvZiYsBdIAjel4mkhawNRRDjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsySwJsA6SiQbcKQ8eHHs3b7YcC77Ia/4m4MyAzX6vw=;
 b=c/2L7PfiegP4ZsQbKo43bAwdoBgvQ9XggEZ/XUfDhLTLLMGGfr6UZLSvN5EkZxdxoopYglddVgtVJGuv+LhwAmKZxyA1BRS0dC6clSggjpmEOFA8+hj6hsUaNK/IAZ4jIxK2CtxmUN5Ewf+4zVfdJf+TRuOw+L49JoGqwc5UJjMXF8JUJpab0i/dvenuwkDBYH0Cfqz8PNeSJpHpRswU66bXTiGnID68K9LdYyt4eFff3gugnELNiJyJjr36SZNjQMC0KfuNVHdhHtCvMtfhH8p1L/kUKfnpc5OpUzLZWjumHSFYM9yLuSmvwFbbe53pycyWamaEA2XJWbTzh/n6Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsySwJsA6SiQbcKQ8eHHs3b7YcC77Ia/4m4MyAzX6vw=;
 b=GXWffh6e4nJQekGkeMfIXpX8EUD4I2ONc+680y60sRUk2j13sQ6dHGlU5XoKTxOceHRCglS1sMSMXKgIVPuV6TQjXofF0bobMDUDAH4F8QKhTsUxyFR5p9oif/VIjUobwnFkCQv+YP+fju6Tlyz11xOld5jSrfpxneTsWDZkenU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7685.namprd04.prod.outlook.com (2603:10b6:510:5c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 28 Oct
 2021 15:01:00 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::79d3:3357:9922:a195]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::79d3:3357:9922:a195%7]) with mapi id 15.20.4649.015; Thu, 28 Oct 2021
 15:01:00 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>, Stefan Roesch <shr@fb.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2 0/4] btrfs: sysfs: set / query btrfs stripe size
Thread-Topic: [PATCH v2 0/4] btrfs: sysfs: set / query btrfs stripe size
Thread-Index: AQHXy29brpg8XrKOlkmVKJzfObsJQw==
Date:   Thu, 28 Oct 2021 15:00:59 +0000
Message-ID: <PH0PR04MB7416FDDC06510EFD61785BC19B869@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20211027201441.3813178-1-shr@fb.com>
 <YXqpFxiAVrC92io6@localhost.localdomain>
 <YXqzWv7t77ZpKIig@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a670703-b21b-447a-5709-08d99a23c0e1
x-ms-traffictypediagnostic: PH0PR04MB7685:
x-microsoft-antispam-prvs: <PH0PR04MB76851D6A22F531BCD499D24F9B869@PH0PR04MB7685.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Kc1p9eCet+5tywsLjM/ICQ53/bR8TltOjZDYNDHKGXo2nKs3+AiLgQwtPFMecPdcYXDXB9FyBTY15yopXiB7Yamir/Wl8lIfrptHDQx+UvtiKxTNuu0G0S4azRHcz8Nvg9FcOjELpBYkN6m/DU1jwgZTuMxiiehhGTMYwpqD/OENPGL6kWO1Re7xKB/yUCX0VdQriaqLa+MCjLkWT46589LYsz/ycy9n8u3sFG4D80CwPJYCt/bA/bLna7f6f1MW0zRwMHVj6GqWUOD/ATeLy+EmucNREnNPDm7F1nJDuJ+re6A/FIFRUEF+NGsnSEFWIXfgWK1BxedYP4wz3VZqN09UppcMp2jv1kQEEukLKk0CxXBfkXSJq/zE8RZ+FuOm7l0GpBEKvWKPEYxoizIuAne6y89nd4GiMtWXZY2JMP1CklYIPNuR6qIN5hVa9fyAtNI4kK5y2kucydaN/jy0qqvDk5jspkt6t0FcPhqq/7l5Be7+HmzwqwrFcpnucFUrUm1EnAqTPC6njTyhxgWlPYbxxmr+B3RsKEv7ohFsHEc4I5OuW4/vYkkkWLI2jZ4S/kubscHBslzRRyiNliyEhkGN3ZTbxhMmLidInEy4RtsPt+h3OhMDagkVtySa84RFWTskeebuSudFe8OWedxppjMyS7qhtw2df8zaHbNtflesDaBIO0ruucFe0TexpjGb+gEUhG9XZ7QCYUuTohiMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(76116006)(91956017)(66946007)(33656002)(38100700002)(66476007)(66556008)(5660300002)(64756008)(53546011)(66446008)(8676002)(2906002)(8936002)(38070700005)(7696005)(508600001)(83380400001)(122000001)(4326008)(55016002)(82960400001)(9686003)(316002)(54906003)(52536014)(71200400001)(186003)(110136005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NkkfBxv5DKC4UQTV7TwMf8tCdoDzhfTuDw/fSbSik+t6+Qe04WXssmV53qqo?=
 =?us-ascii?Q?UQ/45XvTIldSdjMangjKfl8236JJDGihDJdZAub5SmLbaftyOIQZS9OhysJ5?=
 =?us-ascii?Q?qxeHvbaEJPEGFpKQGJtQ9fQ6AaTXuikoJp40A/y3XrtLGIp5HyA74cz+3IRE?=
 =?us-ascii?Q?YzGy381oGjpLLY8AkyHC2R4NhFSn64h+ZhO7ewt+Gw4ITcak7QoOVJG0XMLm?=
 =?us-ascii?Q?EWcCwIYkdWbTqvMTFiX4wMgKo2qXMrpBs2eGgsuhuQbh9IrnzOE00Z+UoUcp?=
 =?us-ascii?Q?7vMrXAtZCcshggrY+OEMmfYLM43ZAC1uX7Y3qEBNILwm7gOb37Mr+DT8E7es?=
 =?us-ascii?Q?WlXshgiFKxaCG+z23AHMUvTJMeK+jXFCxu3On+eT3anKaBKvDfO+niRu7TbO?=
 =?us-ascii?Q?2u7lISy8FNKDv3EwhdsnL+0gfkXkxc2jSfkwRMnob9BFIWvpodFDHgkSoinD?=
 =?us-ascii?Q?gLU+340+CgM4MMu1/1swct5dYDUvPy7Rdu2oNLBnreYBdt/01KyhvtgtHbAw?=
 =?us-ascii?Q?vj0/lB+yK9pgljEIPU2clBe2upah6b58ABjFCf4DNY6M7trwF3Vx/+rH2/as?=
 =?us-ascii?Q?7ejzzCsiZHq8Kfb/c4JKEtsbLdxjDSHtNDSySN585OWcWfQDkAfavsaIPzpR?=
 =?us-ascii?Q?O2sk5kZ8I40W20D537m7iHroPP7rxIAJ+9YgNDtaisbCiAuwRnBsim1FOv8e?=
 =?us-ascii?Q?KfUekyR2qfwKPLl2OjH1c/wm+PlLVg8fmjIC6s4DuSJaP2DYS7ELh439ZRnH?=
 =?us-ascii?Q?V+2YB7xSM5M4gt8gYCyTHte1rYe3ej2HAb2uWjDApBYDcndHyJ1i1njyU7o3?=
 =?us-ascii?Q?MoZyDDQnSH6KPRHbE+QQez1ximj580YMabm3NR1qJ9mgj3r/bqPYpHWTcx0o?=
 =?us-ascii?Q?83/QYsqTYCsmQHpnXI2Ht6E4cpgVygF6f+ErcioHfn0ifNDFrfXvUl9UYF2c?=
 =?us-ascii?Q?XWA2RZGk/M09lniLGZpWHBZxQwHvlQ+hetzi0EDJJqKhB0diGY8dWcihnO36?=
 =?us-ascii?Q?gH8UxD3zJD1PPqspr7OrZgzBcYcZPMt1ksR7+KUFS1owAjvQ8l5Im1Sz+owk?=
 =?us-ascii?Q?WDwy3JH0MwEMKpaa80JNGqqpyMQFioyNt8iUFlHmlTxBb4fZGFIKeKJqa4Is?=
 =?us-ascii?Q?GWiD5NFe/g1IMBPAa3bBaQ7a5pl0wGILo0Zh54XaYLx1PiT6Nbj0np95tlR4?=
 =?us-ascii?Q?IS1C/EAkt0zg0qQJAwb8tP4X5tAW267/PrOOVB9TxK+XptOgDJHrfEfbL9Pe?=
 =?us-ascii?Q?IHgY1qMWa9InHjWFKzEkKx3S5pHf4EECJ5SAdfcXHh/xLzMULq4kxJaeHWwY?=
 =?us-ascii?Q?OMp1xA5hes/vdRZ1w5gzdi2vZJG7cnwot3nh//zdgx0ANJtR0WoVztkbx813?=
 =?us-ascii?Q?X7YPjo55XyHD0f9fK+zzd+JyHqjPVUWpClRyz2cftjTZR8bLRQJ20JPCupvs?=
 =?us-ascii?Q?vVlDVeIbPV4dXjQv6cw3JPpuWBshzEqucu7bg9nkyy7ZWzZjsb5oXfnjqlWR?=
 =?us-ascii?Q?4ULYt0a6vPhEGe86Spn28VQ1bDXZt7O3UOeO/BugaI8HvBYultkXgYvzeGdE?=
 =?us-ascii?Q?kU6f24xh10tIzJkkWdo54Am4SZ+SzYxt+bAl3EQ/4NgusU17uqUMZIKN72M7?=
 =?us-ascii?Q?TR26gGr1RW2PLkU7C9dNoFA6YC4tgNohV/7paheSShajYi/BIH6thJFLS7zq?=
 =?us-ascii?Q?0+o1wT97tWZbfdWdkoQ4ZZmAd5XmJ0jE6UkyeTk1rt5VD+cZFRH5eQ7EzGDR?=
 =?us-ascii?Q?P/fINGuQgnuYgz5K6BJSr47o/Mlip6o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a670703-b21b-447a-5709-08d99a23c0e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2021 15:00:59.8230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MZr4go45uTZ8/AxIzqIAl0lqWelejvkPyYUkeYvpuknvsvgAOO3W9blIEoqeAZlTuBD9tDr1gQqDm8KAHg5z4IOaWGDIOmLQloKzp/MHdl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7685
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/10/2021 16:27, Josef Bacik wrote:=0A=
> On Thu, Oct 28, 2021 at 09:43:51AM -0400, Josef Bacik wrote:=0A=
>> On Wed, Oct 27, 2021 at 01:14:37PM -0700, Stefan Roesch wrote:=0A=
>>> Motivation:=0A=
>>> The btrfs allocator is currently not ideal for all workloads. It tends=
=0A=
>>> to suffer from overallocating data block groups and underallocating=0A=
>>> metadata block groups. This results in filesystems becoming read-only=
=0A=
>>> even though there is plenty of "free" space.=0A=
>>>=0A=
>>> This is naturally confusing and distressing to users.=0A=
>>>=0A=
>>> Patches:=0A=
>>> 1) Store the stripe and chunk size in the btrfs_space_info structure=0A=
>>> 2) Add a sysfs entry to expose the above information=0A=
>>> 3) Add a sysfs entry to force a space allocation=0A=
>>> 4) Increase the default size of the metadata chunk allocation to 5GB=0A=
>>>    for volumes greater than 50GB.=0A=
>>>=0A=
>>> Testing:=0A=
>>>   A new test is being added to the xfstest suite. For reference the=0A=
>>>   corresponding patch has the title:=0A=
>>>     [PATCH] btrfs: Test chunk allocation with different sizes=0A=
>>>=0A=
>>>   In addition also manual testing has been performed.=0A=
>>>     - Run xfstests with the changes and the new test. It does not=0A=
>>>       show new diffs.=0A=
>>>     - Test with storage devices 10G, 20G, 30G, 50G, 60G=0A=
>>>       - Default allocation=0A=
>>>       - Increase of chunk size=0A=
>>>       - If the stripe size is > the free space, it allocates=0A=
>>>         free space - 1MB. The 1MB is left as free space.=0A=
>>>       - If the device has a storage size > 50G, it uses a 5GB=0A=
>>>         chunk size for new allocations.=0A=
>>>=0A=
>>> Stefan Roesch (4):=0A=
>>>   btrfs: store stripe size and chunk size in space-info struct.=0A=
>>>   btrfs: expose stripe and chunk size in sysfs.=0A=
>>>   btrfs: add force_chunk_alloc sysfs entry to force allocation=0A=
>>>   btrfs: increase metadata alloc size to 5GB for volumes > 50GB=0A=
>>>=0A=
>>=0A=
>> Sorry, I had this thought previously but it got lost when I started doin=
g the=0A=
>> actual code review.=0A=
>>=0A=
>> We have conflated stripe size and chunk size here, and unfortunately "st=
ripe=0A=
>> size" means different things to different people.  What you are actually=
 trying=0A=
>> to do here is to allow us to allocate a larger logical chunk size.=0A=
>>=0A=
>> In terms of how this works out in the code you are changing the correct =
thing,=0A=
>> generally the stripe_size is what dictates the actual block group chunk =
size we=0A=
>> end up with at the end.=0A=
>>=0A=
>> But this is sort of confusing when it comes to the interface, because pe=
ople are=0A=
>> going to think it means something different.=0A=
>>=0A=
>> Instead we should name the sysfs file chunk_size, and then keep the code=
 you=0A=
>> have the way it is, just with the new name.  That way it's clear to the =
user=0A=
>> that they're changing how large of a chunk we're allocating at any given=
 time.=0A=
>>=0A=
>> Make that change, and I have a few other code comments, and then that sh=
ould be=0A=
>> good.  Thanks,=0A=
>>=0A=
> =0A=
> In fact I talked about this with Johannes just now.  We sort of conflate =
the two=0A=
> things, max_chunk_size and max_stripe_size, to get the answer we want.  B=
ut=0A=
> these aren't well named and don't really behave in a way you'd expect.=0A=
> =0A=
> Currently, we set max_stripe_size to make sure we clamp down on any dev e=
xtents=0A=
> we find.  So if the whole disk is free we clearly don't want to allocate =
the=0A=
> whole thing, so we clamp it down to max_stripe_size.  This, in effect, en=
ds up=0A=
> being our actual chunk_size.  We have this max_chunk_size thing but it do=
esn't=0A=
> really do anything in practice because our stripe_size is already clamped=
 down=0A=
> so it'll be <=3D max_chunk_size.=0A=
=0A=
We should also add an ASSERT() to verify we're really never ever going=0A=
beyond max_chunk_size.=0A=
 =0A=
> All this is to say we should simply set max_stripe_size =3D max_chunk_siz=
e, but=0A=
> call max_chunk_size default_chunk_size, because that's really what it is.=
  So=0A=
> you should=0A=
> =0A=
> 1) Change the sysfs file to be chunk_size or something similar.=0A=
> 2) Don't expose stripe_size via sysfs, it's just a function of chunk_size=
.=0A=
> 3) Set stripe_size =3D=3D chunk_size.=0A=
> 4) Get rid of the max_chunk_size logic, it's unneeded.=0A=
> =0A=
> I think that's the proper way to deal with everything, if there are any c=
orners=0A=
> I'm missing then feel free to point them out, but I'm pretty sure 1-3 are=
=0A=
> correct.  Thanks,=0A=
> =0A=
> Josef=0A=
> =0A=
=0A=
