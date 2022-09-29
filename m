Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEF15EEC07
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Sep 2022 04:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234848AbiI2Clk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Sep 2022 22:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234891AbiI2ClP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Sep 2022 22:41:15 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C2C5C379;
        Wed, 28 Sep 2022 19:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664419253; x=1695955253;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rbaZNuUWK7tRshIyMQ8lUSQ/OP1l/wH/qeHldcgXUgo=;
  b=oGKZeI51g5lyKooe/7XoJwNbC9t7KAY8PqDADh/J0zrfyIq/Gj2BD+Zy
   M4dsO0CL4xMjkOJIxcWdw5Uk+dXePXZGo88JSPt7Jz0hvtCbO0pgAPw4N
   0Tic1hZnVo2+pFhdNplcAmproImL7UszlsDL4L7KQtsCVL+Fde7XtYEaV
   Cqem7yi2EJxeCQjE9DeOiwTeEQJqtmxk5YCYk8wPMpQ+lc4ZiLnm0pPT+
   ExUwPzBQn/wv2PVCnf77ppKDRx9PZNkyXpKKONlw6ZCb7Xy1TKzwWASbF
   SrQ7/Qxjaxnpdr9c5P6vtpABwaJw1VvAEgOKZQIwnr+y61iP7fn3KJdTR
   w==;
X-IronPort-AV: E=Sophos;i="5.93,353,1654531200"; 
   d="scan'208";a="210897984"
Received: from mail-dm6nam04lp2040.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.40])
  by ob1.hgst.iphmx.com with ESMTP; 29 Sep 2022 10:40:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYYz1yU1EhJrIBMAIwvYYJtD7oSVeCAZbulCPeddhYQSRhgy2odbCp+yGeC/VyNp9oiKEP6qMsOGIMu4JxZGyFdRQMp+GrCya7GZI/ftof9L2VOsxLswu+4HnSJhq2/cLNVnhbTMwJbuHex2tNeOZ6gR2EDNUYcfvO0E/uYlf2F7NJ1nBhl8ntLXH546O4sMIyKA/6sWnRxPtIzXeCGP0PmWXCIowrvs0SEavZT/8DdVlKfetYOxV9a7gS0tlfwGW/UhVrPXfXvM+if1o+3uEM4gdDJ1hxEpoxXzvHc5fpx3nJZJXaADIvwDh+XZV21zH+m/D9r8eCPmOMRRQLVPUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbCCe4SefR/iGVcB8JJCCpN6nXHehxh4tfJlnAgRdaQ=;
 b=fGJP4/2xxgTYs5GtlOHSFEn6r0dDzWb/AT9E9WfNN3sMlaYhH6XXc/ppAkG/kmuhZyAoHawpZvG0MWz7E7I/E02O5+MFhRoeCbbGD1DySARoEfEwQhj7JiYfRArZzAEDNCJ5kkY6FtDoyNrNmDKtx1qKFpAK0ZXO3HTiP9hZd9zDqJNwQ+Ke+7o2LEMxicuBs3BVf9SW0pdqXBQnSleSA6+iMM3KAcHlmA63TaxR6J17eG+zprx6vVlKn/z4uyQV/OhE1xVMKQT2tDjV31et5gB+irv2ZewHfedXgVYCX+DRoDV4XqHxBIjqjQChAcLRyJ0FYWGseElDO6DhDqN6Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbCCe4SefR/iGVcB8JJCCpN6nXHehxh4tfJlnAgRdaQ=;
 b=cN2k1pXvOF7fNAZtp+HkLy8VORfHsbZyf9t+C/H9oFKDJ98EwEwa/aCJqlNmTrM/qtAx7CDPZA82JHEZOXXk3GPB2BAWVCFpL/3NghoDDZdP8a9/x0+aCdxFpOTsfbeqHetH/eQGgegQ4YaG+y5WlMGTCVszyf3IPPyF/wvWCSY=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DM6PR04MB4617.namprd04.prod.outlook.com (2603:10b6:5:25::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Thu, 29 Sep
 2022 02:40:50 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::11a7:2daa:ac81:48da]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::11a7:2daa:ac81:48da%9]) with mapi id 15.20.5676.020; Thu, 29 Sep 2022
 02:40:50 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     Zorro Lang <zlang@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] common: introduce zone_capacity() to return a zone
 capacity
Thread-Topic: [PATCH 1/2] common: introduce zone_capacity() to return a zone
 capacity
Thread-Index: AQHYzkfyz9/9pluCVE+RCPN0eF/VSa3s6Q4AgAdXI4CAAB7FgIAAo5mAgAC6pAA=
Date:   Thu, 29 Sep 2022 02:40:50 +0000
Message-ID: <20220929024048.xgnoezpvt4u4rx7i@naota-xeon>
References: <cover.1663825728.git.naohiro.aota@wdc.com>
 <97ede9bba67f0848fc0b706d757170d7dfacb7fd.1663825728.git.naohiro.aota@wdc.com>
 <20220922154132.dpadkhaccwzysq4d@zlang-mailbox>
 <PH0PR04MB741656D7881D11281ECBBD489B519@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20220923115126.s3ctf4erpepa3zy7@zlang-mailbox>
 <20220928035707.v7kv4ult46w3hjlj@naota-xeon>
 <20220928054715.ol6gammnf6jmrjab@zlang-mailbox> <YzRpH5SvkKwhlELi@magnolia>
In-Reply-To: <YzRpH5SvkKwhlELi@magnolia>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DM6PR04MB4617:EE_
x-ms-office365-filtering-correlation-id: 6040fbc3-4878-4a51-43ea-08daa1c40553
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qBwTxPSjCNKxlJaZ2c343hpVmpLxwqiYBg22LsK8jWdBb9XPcOBzeolaJj5kFvX5Sp3Gi33tyCzbWz4my6PnsR5KIa9tp82+2IsLszu09p2sFm1Z+f55QbfMuPMyOVGuA+t/+9zPyTJuK6v8Q78ua0mlWWn34C6QSZqQeVFZP724WhoV5Xl7uZ+p8cw7Ce3cOB6sVS4tJ5E4g6LGbihyC66pYMpgF3Shzx8YjwOo2DIwM+sooBXFxNyTxKzXtbV03uDyx/aI0mVd9H4ZXCvSis4W/BT7B7bJbEMME0aHMw3oWaJXkYTX0I/N+hpOA9NHsbieUukbkj1/6korDTTWv4HcIAvJKXQwqpyaHEKAX9lSRNCECbMv/PjXQ02zkbzA/SL3vMpDsTQM2yzuGyBlVIL5IdOLiEdxxi412Dk4FdD1OKdDfl+/o0QJ6ARKJknKi76pVVo3jDt9o5g1LtbE3IdaEot8KwuZ4D2OyYHsSbRjb7GQT85YzHZet2MVpBl+6I4dAIIB11JFxyAJA0BVa4UMiiCzmZmFL2rvpJL3j/rGunuYSFxolxBTqEYVh7Edzj3vSOu9j4fWUHqe9nzmWUdgZmHldCdMFouUskAGbIMP0szC0WGMy55yIR//z1cgfkioGC52T8QGq+HggazUVr/7cuqw8QZXCYTPQKqv9tMb7+Tl+hVz62umYaTeV3tdACdkc03OxDpJmih2r65Tpq6iXcf8YbNy+NGvov2uEPzl++qIgmfBkZF2BByZYVfyvw9CnFS7lxetZd+jOlFF6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199015)(54906003)(6916009)(38070700005)(82960400001)(316002)(5660300002)(76116006)(8936002)(2906002)(66476007)(66556008)(66946007)(8676002)(66446008)(91956017)(4326008)(41300700001)(64756008)(33716001)(9686003)(6512007)(26005)(186003)(71200400001)(478600001)(6506007)(53546011)(6486002)(122000001)(38100700002)(86362001)(83380400001)(1076003)(66899015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dCUoU4DircCNSyD9oJcAXLFeuFyteHRfHIKAQaTJ763gC2y7PGNPCN36uZrM?=
 =?us-ascii?Q?K/YcoVnaXFiEwM/1aAimTDuVMywKz3TZV/GFLWAxatRUnHYz5qZWZXM4z9LD?=
 =?us-ascii?Q?O7IW4AE6tYBrF0FvoSF41yEDMNUAsWF5oib0AX1vvPfhaI4LgjpXLzhivAT9?=
 =?us-ascii?Q?A3gToQwuUtT4NN55MRngi+T71TSJ4D7Cj/T3R+8yahQ+iS0W3vemzJcQ1h+6?=
 =?us-ascii?Q?+XQFl6XVlXXiYeIhfbSUNedG722rGRsGZd03zprGn7OqtWpaH7MDViTIFbdJ?=
 =?us-ascii?Q?j4O0e+qx86tYmnnIaqfZqgxR9bT1tKMSeN19+SWNTqZIDGhSHwzCnDCuGm/j?=
 =?us-ascii?Q?vDM/L71ubJWubhkaJ/i85Sr0LrHS+KnClXsGGRkxHCMWmK8HP+XzpcmgoAMy?=
 =?us-ascii?Q?tdCRUjuTLK2LMMajIeOH6GjoiJtxWG3ofpyC4TkSARguxsyHu6UKI5o3U9hy?=
 =?us-ascii?Q?nmie8aFu2jTACEDfOAVrEBV+kNwbPW5+j6/jLYanwZfFnZCfuDImjqhEE//A?=
 =?us-ascii?Q?8zPdOO6RGviozt9KQjkBuF1dJdrtcXLok7Tvhs7KmNHWz5z9SzX6Lm0pTq00?=
 =?us-ascii?Q?NLvErCJTTBgyYwXoC0fonCHTRA/2EqNViA7I61iCOHKEQh0eAMbSuwbcAbAv?=
 =?us-ascii?Q?iuW09ZeOkpc6Opi5oDA2bCXW/pfkLb5YCnjdyxXufLNvamLRj4d6XtRbmtQH?=
 =?us-ascii?Q?FeQ8MjCpw5dHXHbIBa7jdh84DkVlDTrwTZA6k4pIDYLdwMeNwXpk1opXEhc/?=
 =?us-ascii?Q?j6JvYhHs6GkqHm7CvuNGT4DUTmtRyBHYH7gMf7ySnU2SrdCvVb4d9Zxdx86s?=
 =?us-ascii?Q?eI73zArbT/mkGph4BY36x2bqnSRtaUmgP9UBF6weqCXSXEkt7jkTn+u5hs/M?=
 =?us-ascii?Q?iaL53Ubk/qhaNOGvjdL5C6Hxj4PvnPd3m0bS2yzu5DKarV1vwCane+2+S3c7?=
 =?us-ascii?Q?18tJrp6TLGXTGYdeD3W/9heNyvQoSfscPnrHJOG5bRoMzJ1DD4Tv0K1YLQGF?=
 =?us-ascii?Q?dFqDoXkSvJ71mEZ33e57VmCTiJspy0/GXahDTjeNgJJcQYc1gAwzbvXGL43U?=
 =?us-ascii?Q?WrFimQaAiIjLweyKcXJJZWJKqfLhdJKjnwkLn1F5yWTxRBQEDP/yeUWcAvGy?=
 =?us-ascii?Q?fnjPMxj2BBj67ifGE/+GbKH3FXIq86OJ8ESCkDBjD0+oftY7+offlmqHM3n+?=
 =?us-ascii?Q?EtAVphHwM4U00QfQkxJOPDIbJX44mecfVrmFOxQlXP/WnyJjU73twlNb0U1e?=
 =?us-ascii?Q?C2Fw2EJwAJs5+E94pqZcCJBp4ZTwGFtYEDMRy0/5OOyJwdKFBA6Msl+BL78d?=
 =?us-ascii?Q?kVcFvYIqZ+JnV2aynkIsa3HyxpVividhGJNjyAV4inknsmHomQ+No0vbThKa?=
 =?us-ascii?Q?QfdfdoDA4nQIqwDRbAy7K1RLi+uIN9qTglZNZtupanPpHpWvGKR+cyY/iZ3y?=
 =?us-ascii?Q?F3FGmROK3Ud109GFHSauWuW7sEQtrC2jJ/HS0M619zaunjgbmPtdUP5Go2ii?=
 =?us-ascii?Q?xqM+1LtI4CITstGASr1Rsib/opcIODuicaPS79RyCEJxlCvBXxMsooh6bZ30?=
 =?us-ascii?Q?VJQu6gSQ9kFaW9tT93d9zLUvipuZzi0XK1e7wIsYyA+ktG17cEVQK/momB4M?=
 =?us-ascii?Q?4w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5805C0DC937C3845BF49BA013F6EA26B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6040fbc3-4878-4a51-43ea-08daa1c40553
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 02:40:50.0882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gq/OsSEyS6HPOusQI4VU9QiHu7seDLHmNvXTlYIQF6O6Ir24NgAyq8d08afVrlrrEmUoUM30JC3WuJ81qj0Eag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4617
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 28, 2022 at 08:32:47AM -0700, Darrick J. Wong wrote:
> On Wed, Sep 28, 2022 at 01:47:15PM +0800, Zorro Lang wrote:
> > On Wed, Sep 28, 2022 at 03:57:08AM +0000, Naohiro Aota wrote:
> > > On Fri, Sep 23, 2022 at 07:51:26PM +0800, Zorro Lang wrote:
> > > > On Fri, Sep 23, 2022 at 08:02:10AM +0000, Johannes Thumshirn wrote:
> > > > > On 22.09.22 17:42, Zorro Lang wrote:
> > > > > >> --- /dev/null
> > > > > >> +++ b/common/zbd
> > > > > > I don't like this abbreviation :-P If others don't open this fi=
le and read the
> > > > > > comment in it, they nearly no chance to guess what's this file =
for.
> > > > > >=20
> > > > >=20
> > > > > zbd is a well known abbreviation for zoned block devices. I think=
 most
> > > > > people in storage and filesystems know it.
> > > >=20
> > > > OK, but we haven't been that "a single character is worth a thousan=
d
> > > > pieces of gold", so we can use a longer name, likes common/zone,
> > > > common/zoned, common/zoned_block, common/zoned_device or something =
likes
> > > > that. Anyway, that's just my personal opinion, if most of people pr=
efer
> > > > using "common/zbd", I'm fine to have that :)=20
> > >=20
> > > Sure. I'll use "zoned" as it is more common in the kernel code.
> > >=20
> > > > But I hope you can move all zoned block device related helpers to t=
he new
> > > > common file if you'd like to bring in this file, likes what Darrick=
 did in:
> > > >=20
> > > > commit 67afd5c742464607994316acb2c6e8303b8af4c5
> > > > Author: Darrick J. Wong <djwong@kernel.org>
> > > > Date:   Tue Aug 9 14:00:46 2022 -0700
> > > >=20
> > > >     common/rc: move ext4-specific helpers into a separate common/ex=
t4 file
> > >=20
> > > Yes, that will be better to have things in common/zoned. I considered
> > > moving zoned functions (_zone_type, _require_{,non_}zoned_device), bu=
t
> > > _require_loop() and _require_dm_target() use _require_non_zoned_devic=
e() in
> > > them. So, moving _require_non_zoned_device() will make a dependency f=
rom
> > > common/rc to common/zoned, which I considered not much clean. How do =
you
> > > think of it?
> >=20
> > Oh, below commit [1] brought in the coupling of common/rc and zoned hel=
pers.
> > Hmm... that cause all the 3 helpers (_zone_type, _require_{,non_}zoned_=
device)
> > have to be in common/rc or be imported in common/rc. Looks like we have=
 to
> > keep them in common/rc, except we make a bigger refactor to common/rc, =
or you'd
> > like to make your 2 new helpers in common/rc too (likes these 3 old one=
s:)
> >=20
> > BTW I doubt if we might need to use more zoned related helpers in commo=
n/rc, due
> > to we deal with test devices in common/rc mostly, likes dax. Someone mi=
ght want
> > a seperated common/dax or common/pmem file one day. The common/rc impor=
ts
> > specific fs helpers according to $FSTYP (common/config: _source_specifi=
c_fs()).
> > If we need to deal with different kind of device types in common/rc one=
 day, is
> > there a better idea to determine which one should be imported? Welcome =
any
> > suggestions if anyone has :)
>=20
> Leave those three in common/rc and put/move the rest to common/zoned ?
>=20
> I think it's fine for common/rc to have helpers that *detect* the
> presence of a blockdev feature, and require tests to source
> common/$feature if they want to do anything clever with that feature.
> After all, the _require_non_zoned_device tests don't care about
> _zone_capacity, right?

Thank you for your suggestions. Yes, _require_non_zoned_device() just read
/sys/block/${sdev}/queue/zoned. I'll do so to leave the three functions in
common/rc and move/create other helpers in common/zoned.

Thanks,

> --D
>=20
> > [1]
> > commit 952310a57d9323ae0bb174b50be93107a8895e0c
> > Author: Naohiro Aota <naohiro.aota@wdc.com>
> > Date:   Mon Aug 16 20:35:08 2021 +0900
> >=20
> >     common: add zoned block device checks
> >=20
> > >=20
> > > Moving _filter_blkzone_report() would be fine, though.
> >=20
> > Yeah, moving this is fine.
> >=20
> > Thanks,
> > Zorro
> >=20
> > >=20
> > > > Thanks,
> > > > Zorro
> > > >=20
> > > > >=20
> > > > >=20
> > > >=20
> > >=20
> > =
