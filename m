Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03D143458B
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Oct 2021 08:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhJTGzt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Oct 2021 02:55:49 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:57234 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhJTGzs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Oct 2021 02:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634712813; x=1666248813;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=tfHzQRiPvP3hqd62o1ezLsfJ1NEG6B8zxSMd6paKsmU=;
  b=DgrMTTvmhw4UuU1cq57ewdmSf1Vc5dmKqjZHqHKkMcd/VFDlaLtbI6IW
   i10heb7sOfsWQGcDu3LzcJMPcORQItIDePgCuGieGuEQ6ALEXuYXzCGcP
   jpDLhBoQDwpEPGizOacsk3RxrGssRQOOmjQFvMS+1/uIkQi1Mefpx3Vff
   bciMjbpuCuBu3AeGomzkiozhKGDT25AqaUzZM/kuRyyO0uuOgKc/xKyZp
   Wg4x59YSwHq6B1LBeVsKneR2uk2T5bbxQHw0aW2ZiBcgLDOlIxvy+bMQi
   J+mDXNuNXfVf9W9//tA7g1RbUn55Pb4bVX+JVMHoqUikyQh/uX7Q9YA+U
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,166,1631548800"; 
   d="scan'208";a="183385288"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2021 14:53:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+0/OLI4HB2fW/rOc7DxdKUWosII5o/TIVJZdEON/51h3WqqNw3nVhJcvprLLaVUBE613iXITBLgi1f8ePnYOEU6loIgxABJdy7lats7BeGHkIOhE8Gb2V64WXDBVkn+2bqAe7dPiYIcALb70iYbc0vn7RU8d57xFhvftQ63KkLS6YS5IS255Nv2xNpmZYuLChlEeCc50nugYh9br1eoxyKJqaO+LkRcRlamL+86WfkAm38owzs9zuB4ITLJmjmnNbM6Qa8LFKbGaoAT0Ct/UcYwqF+nIxEHa667y2p+VKjRM8WHVgkcKRxEK8PfgDo+YkEOovXCeA/tEXGijsGENg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2m4vJIZIKIEEp0sPecACCSO+YF+lOwuPhV8SGDWotb8=;
 b=Bz6pw8oIp8fdOzsfULR8hkQnHia538QMl62PCX8KA8EKtROMhmg3GlqkmqAaEB1ns8BwSD+e+FyG4wCD/K5Z4vqDmqq40GFhMDDmNhPj+gLWw5VEr3+xMVXrQp8AqQ/kKYeKOYAi7nD0z8ur13SbnCYG+EGqAicHpJNdlYvVkoqfW41N3iios7cHVX0hKDzdIYX6EkCZgbYal8BKmTxts5K+HG5KmycALekBEd+5o7ut6PW0RfAz9ggBjGpKNpULt0nNTj2y0BFYsYBuHmP5eevA+kOBD4A4dlDHjvfLHsqOKj+G4PpjC5kS73D+3nulknA7LdPFHq5qLAUoIjp4CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2m4vJIZIKIEEp0sPecACCSO+YF+lOwuPhV8SGDWotb8=;
 b=cZyJni9PxXib7KfrqAmGKftGDKxTmglcRJ0ZbjQW0orVCnAG0hJfjXbFmq85WPKDmafQrrAnXiH9r25bhkDNmuatg1YUrpvKMZocraApx33tNpZBDXwPyEz92KWi4EQ4UxS5I5IDIzqeZbIXBBIurz6yZHzyP1tt8OtqrShGsx0=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB7904.namprd04.prod.outlook.com (2603:10b6:a03:302::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Wed, 20 Oct
 2021 06:53:33 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::19a7:91bd:cb0c:e555]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::19a7:91bd:cb0c:e555%7]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 06:53:33 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v2 0/7] btrfs-progs: use direct-IO for zoned device
Thread-Topic: [PATCH v2 0/7] btrfs-progs: use direct-IO for zoned device
Thread-Index: AQHXubGGf1OCKj0HL0SX2g8t3GWnVKvGd6SAgBUTXAA=
Date:   Wed, 20 Oct 2021 06:53:32 +0000
Message-ID: <20211020065332.csyjedb27xshy7mq@naota-xeon>
References: <20211005062305.549871-1-naohiro.aota@wdc.com>
 <20211006210247.GY9286@twin.jikos.cz>
In-Reply-To: <20211006210247.GY9286@twin.jikos.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0741d7f9-9f69-4363-0989-08d99396550c
x-ms-traffictypediagnostic: SJ0PR04MB7904:
x-microsoft-antispam-prvs: <SJ0PR04MB7904E022C35A08ABF80C23AF8CBE9@SJ0PR04MB7904.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kge2ZRhUFWJByDhVJGCpM7q/Y+azRMIHqc1vrqi3QZlaslE3bNXbhP+vIPQs+MhzrhV6I9wvaT6egwF1z7x9kRIUzzNPOnX5TFjXZRgsBd4QabHBJDw0hegfSIeN/Fe7eKedfJHBW57InyoagaVEjLbMhrN3F4GoOf1/a9aklTsFPeDO3fvZZYTrB+YxiBHg1il/zGMUCjZwW0UtEdb180s2HhXR9oCwtOyitzsGHiIlZnXz4bdfijG3//7daQRFgwBHU2rzVT5V3EMfU/w8x+YP8QkAh9mD5M1CQ3RMMYo/soM9sjSp5DVeWC1c5vkv5jg8+MpZmEWn5kk8e+0OhyFTyRcpF6Y4axsEnpuU4PhzOZnprdFAxPMfnXRN6utyF4vflC8FfIfnk7BjlsyykYZm1E0gtxArpPgrvwMFvh0Fw0eJzExI+A2khrSKEv3E5IVb0aqSJKmNaQ+NLRMSNdmLKDVEhOHFSmiqn8i9H3fI/vNp10juDAwvISw8TL6taWwmGRQE4Q9oxsZV7MaesSBBOo3bwApS2Ro4KKfPdUD3ucuu4GCPSvri7m7ovNf+eqlFYqRWXSjuqztNNm8OLeQSuu/fZOQ5N7JPNFeAKROG3GHubLPpSWcfmP3MtNAykSiBHGspF1tObVozL9Hq5bJJGkR5RAo312RcQ6mQuRhQ+7nYqUGT9udcz6h05ZQboYCjDU98yjUmqIQVB4YkFocxmzY84fLDBrcE+S18XE2uqkYbl347T49aJfRHkpK64xqIOE8hfVTEQbGMetVMhsk5CEbuOjtKoTlRMcZgVdc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(38100700002)(122000001)(83380400001)(86362001)(38070700005)(8936002)(26005)(33716001)(5660300002)(1076003)(8676002)(966005)(71200400001)(110136005)(9686003)(6486002)(186003)(508600001)(91956017)(76116006)(2906002)(66556008)(64756008)(66946007)(6512007)(66476007)(66446008)(6506007)(82960400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?65nopCmfd4mPwdrAK1eiIvy9XxpB47pvafuVKwodJLoq2LId0Ys37v7Unx5Y?=
 =?us-ascii?Q?wuGRL6f0oqHS51f/2oknP30s8wrNkymNTAPa+zdavM7Zo+jTthv/5FenqZ2n?=
 =?us-ascii?Q?b3mz3QnOg+s4wC1dNprr6qwS5LYmBZs2OTrOgRUUA+RzadboVsXtCFrYSpFB?=
 =?us-ascii?Q?6ENxkfKd8X5/wMZOeH23TypVSWFlwwByvM+6IC9gH0V1wEIg4tgWhP+wQH40?=
 =?us-ascii?Q?q+IQ35i+4bVjuySMvwmMEjwGrHF8OqzexKMaoDNLaEPNaNwmokV+v/MLKwGH?=
 =?us-ascii?Q?Bg4zzpuYWsROm9kax62nOYvo2xBx7yegP8eSJfNUkNxs+B6QCMwrgPx+z1V5?=
 =?us-ascii?Q?oqdzITfNclMDoSNireSTzLxNyYYHyBWoToUwmIdQGxtOR75WT8F8rVMqHmlm?=
 =?us-ascii?Q?34eTi1SD2moERBaBcFQuqCNvjy/gKSPn39MjHkJcorK33mn1lyCv18r1inrY?=
 =?us-ascii?Q?fChHiJZHiM7OBFoNxNL4BUu1g8YbtK6wlUZhoAtzMSmG4vTDHYbPmaqgYdvL?=
 =?us-ascii?Q?Z5vOhEeA5Q0B5VssgK7t8to7G7fL7vnH/ezcLUvYJlLlLpXPr96yUoXwX/O2?=
 =?us-ascii?Q?bInNYyDizIeB5RwMHwBG0OUP8q4wSFMRszh+IzW5VJM3BsDYYIpzK9bzrBnb?=
 =?us-ascii?Q?968WiUnMtFfxcnPbLICUhGhXQKih9O5NJ4JfSRY8p2l/olzXyHC6wCJPucKq?=
 =?us-ascii?Q?jDvXv7Eh9nm8euWpKzICoUD2WYFD1fl/QQP339POe3q8WYCFx52Gf5pv9cGq?=
 =?us-ascii?Q?EA7nNebzRGaMwTkgoQOrZfZGbGH8rrd6MXN8mxS5EVm8tV9yLy09qcJQ6tu1?=
 =?us-ascii?Q?1p3GIecoEal6HhKlWcqXlHe5wtB4eJvY8D8MuA8B0+KKw4TVL/B4uW3HEycC?=
 =?us-ascii?Q?fG3tpU8ETHb+BKDKjSkRBx9tRGu6w6urk7NmoH05KaB9dQlHsxuNDj98yUAf?=
 =?us-ascii?Q?Y07/q2Z0ZY24P9uV56fwaernkFsDjYBxDTQ1KXozyXKRj+7a/qkEYORCI2k3?=
 =?us-ascii?Q?lssSNEp9WPnZbJ36H3bh2P5NFmX9gGXqKzKOAL3nCKR/TPoytKTRsiB2Yr67?=
 =?us-ascii?Q?kW3so1fwHQtc//F8/4sExUlB8SM8Od7XmSbLXcEGMXchSuxQ+Hjgm85wKcR4?=
 =?us-ascii?Q?960ynXkbp1LJ9d1vX9t/9sCTuugixu1FZivXEUbNJlIUFJkBi9/gCdRMzAEU?=
 =?us-ascii?Q?ZMVlMRH4KPvfEFQePYYFaPdlNQWttyJotxYnrO78ggodCSix87kKtl9wzZN3?=
 =?us-ascii?Q?b9ztKvN7SCuNt2+Y10qP2Zn2w3ei6Z7rFm/sPak/5xLFQflEFtkqAxuPoJui?=
 =?us-ascii?Q?ZfaK2tz75ixooE+zlH694faX3qHxInH0KGF6Cicp3Chsw6QUjfd97QA0is9L?=
 =?us-ascii?Q?ypIX38cApzCmyQKmK17WlMh0hRwX78pU+poKc2xxgjA275Hn+axS0qGJtLDH?=
 =?us-ascii?Q?7s5uQbMJnPePlK3suG6U8IpiyWMYM+Ks?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E366FB6856290D4BA18103B139B58BD1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0741d7f9-9f69-4363-0989-08d99396550c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2021 06:53:32.8864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Naohiro.Aota@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7904
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 06, 2021 at 11:02:47PM +0200, David Sterba wrote:
> On Tue, Oct 05, 2021 at 03:22:58PM +0900, Naohiro Aota wrote:
> > As discussed in the Zoned Storage page [1],  the kernel page cache does=
 not
> > guarantee that cached dirty pages will be flushed to a block device in
> > sequential sector order. Thus, we must use O_DIRECT for writing to a zo=
ned
> > device to ensure the write ordering.
> >=20
> > [1] https://zonedstorage.io/linux/overview/#zbd-support-restrictions
> >=20
> > As a writng buffer is embedded in some other struct (e.g., "char data[]=
" in
> > struct extent_buffer), it is difficult to allocate the struct so that t=
he
> > writng buffer is aligned.
> >=20
> > This series introduces btrfs_{pread,pwrite} to wrap around pread/pwrite=
,
> > which allocates an aligned bounce buffer, copy the buffer contents, and
> > proceeds the IO. And, it now opens a zoned device with O_DIRECT.
> >=20
> > Since the allocation and copying are costly, it is better to do them on=
ly
> > when necessary. But, it is cumbersome to call fcntl(F_GETFL) to determi=
ne
> > the file is opened with O_DIRECT or not every time doing an IO.
> >=20
> > As zoned device forces to use zoned btrfs, I decided to use the zoned f=
lag
> > to determine if it is direct-IO or not. This can cause a false-positive=
 (to
> > use the bounce buffer when a file is *not* opened with O_DIRECT) in cas=
e of
> > emulated zoned mode on a non-zoned device or a regular file. Considerin=
g
> > the emulated zoned mode is mostly for debugging or testing, I believe t=
his
> > is acceptable.
> >=20
> > * Changes
> > v2
> >   - Rebased on the latest "devel" branch
> >   - Add patch to fix segfault in several cases
> >   - drop ZONED flag from BTRFS_CONVERT_ALLOWED_FEATURES
> >=20
> > Patches 1 to 3 are preparation to fix some issues in the current code.
> >=20
> > Patches 4 and 5 wraps pread/pwrite with newly introduced function
> > btrfs_pread/btrfs_pwrite.
> >=20
> > Patch 6 deals with the zoned flag while reading the initial trees.
> >=20
> > Patch 7 finally opens a zoned device with O_DIRECT.
> >=20
> > Naohiro Aota (7):
> >   btrfs-progs: mkfs: do not set zone size on non-zoned mode
> >   btrfs-progs: set eb->fs_info properly
> >   btrfs-progs: drop ZONED flag from BTRFS_CONVERT_ALLOWED_FEATURES
> >   btrfs-progs: introduce btrfs_pwrite wrapper for pwrite
> >   btrfs-progs: introduce btrfs_pread wrapper for pread
> >   btrfs-progs: temporally set zoned flag for initial tree reading
> >   btrfs-progs: use direct-io for zoned device
>=20
> Is this still supposed to work?
>=20
>   $ ./mkfs.btrfs -f -O zoned -d single -m single img
>   ...
>   ERROR: 16384 is not aligned to 1048576
>   ERROR: error during mkfs: Input/output error
>=20
> On commit below this patchset it works and creates a filesystem with
> zoned mode and zone size 256M.

I'm sorry to respond so late. My email fetcher was broken.

The mkfs on an image file should work well. I tested the current
"devel" branch. While it needs a patch to replace pwrite with
btrfs_pwrite in create_free_space_tree(), it worked well besides
that. Is this failing on your side?

I'll send the patch soon.=
