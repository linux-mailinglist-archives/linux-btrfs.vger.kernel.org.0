Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4784344E2AF
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Nov 2021 08:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbhKLH6M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Nov 2021 02:58:12 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:24636 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhKLH6M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Nov 2021 02:58:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636703721; x=1668239721;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=DeOyQYzwoFHOi9mwdiu9/EeCsU5MtV2bprzOFpEq1JA=;
  b=mqD/j/OiBfT5cV2nXdNvN8lHeGsr3UtRHs9IJY7/EFvDTT2vQglSKqi4
   BWt3SvLe0fg0usUeUwot/8uQtKZkdFwEzyCHw37DxbbKTh3ogHCjOSgBG
   UEiZYzH0W6LaOy6bhreYFkUj6Zo4I7DNDABE3dEea5ZtYmIQlhxgHcCsv
   RPEGEfG4pR32md7IvGPw8PbjBbWWeaXMY8zVImnAMJvlBM5M8ZcB71tfa
   iGnXx2Eu6F3gHX5XeanNvPpvtWvRy2e5RwhEuWcu/9qHwIQO2zHpFmQmD
   i1Pjkorkc6fyO+U5p68+4S7st4FpGJXR5+o574jGf77xLoPzbwtfj2Fke
   g==;
X-IronPort-AV: E=Sophos;i="5.87,228,1631548800"; 
   d="scan'208";a="185421678"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2021 15:55:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4MBRkri22mkUYGRGEXkzGiVNfvby/wuh8xvJyy7f8VKDujtCvC4+IUTi0MnSZrwRJKJKxuatcUuLaUK1y0JS2kfmtSpyIKeKGXeM+GY7JKxzT9GPhYVyL4oCmVwJes0EhPo7Em5v+Qlmj6X3VPC9emzmJ8fu4muiELMV64rS1eOCJU/BmITSAco9Pj8sTCyS+nOMdWof12slX+ISDG8yvRPV+Jdiuvbvigh2edglIUFaCeCY/gcjUot1u0tt4qwHwgADGaEPjOr2yUQuGXbDxi9h2UIHkJAlmq3XDfvTgPZWRSrDlI2cc3y8Ou5Gs4Z55CEJnUaMmBe8Ogfl05btw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+91EGVFX4bemFMBqgP7CLptFJ5CnG5m0Z+GU+wdKVUA=;
 b=b7DGQKC73EjrDDqHABfbBqPzuOipQL3udhekXIMC/Q+DKI0PwWNhSansErTtEtDk6trl3k3LIn4whQbjlWXrM77Xxbw5lhzK+ISQFZ02Mp9kdJpRoKdyc7BqFNbO416FZQ+gAYXJ96vMIoeY4WgenIAllAzpdh5AM8W/iULbPInsqF9IA2LSuoCefywPjArp5kJuV05T+xmO/QJsKCP038pDkw/EZt3j6Wdiw01XiTKT11SJzue+V5YB9c/mo+fThsPUjiBzB1zgZup5FNbUb5EDpg/SMKCg6CFg65P2Sx22D2Rj+gZnglFVmkVjsgWz8YS8E5QYwfh6zuJwwCSbPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+91EGVFX4bemFMBqgP7CLptFJ5CnG5m0Z+GU+wdKVUA=;
 b=UnsFIok1Lb5R8qc1R3CD3o9SwVb4jdzyBtJBIe4gMIHpwir2Wx2V75yY7gEj5q/aSA9vb9yPPd5seCb7C0y4APpDlvM1B9fqEvO6BTRDL5GHh72aYO0mZ/xgS10TZPbG4ziOvCF1nIiHcpd8VzvU1QMD3S7ZGdSr+7EiN/Uac6M=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB7792.namprd04.prod.outlook.com (2603:10b6:a03:3b8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.25; Fri, 12 Nov
 2021 07:55:20 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::4d43:a19:5ad0:74ca]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::4d43:a19:5ad0:74ca%8]) with mapi id 15.20.4690.017; Fri, 12 Nov 2021
 07:55:20 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] btrfs: cache reported zone during mount
Thread-Topic: [PATCH] btrfs: cache reported zone during mount
Thread-Index: AQHX1rsNIfSkp8A/OEe2FKWcLDQshqv+SBcAgAE/uIA=
Date:   Fri, 12 Nov 2021 07:55:20 +0000
Message-ID: <20211112075519.phpu3eilpjwg7vk2@naota-xeon>
References: <20211111051438.4081012-1-naohiro.aota@wdc.com>
 <20211111125100.GB28560@twin.jikos.cz>
In-Reply-To: <20211111125100.GB28560@twin.jikos.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c210eff-4415-4b61-58ad-08d9a5b1c633
x-ms-traffictypediagnostic: SJ0PR04MB7792:
x-microsoft-antispam-prvs: <SJ0PR04MB7792D87287CAAFF6F7CD72AF8C959@SJ0PR04MB7792.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8L1BWdKIHIdxX9mzxy/4kXTHKo8TTuYg73KdRPOP/za7+zh6HKTmJks44BJhqYy0iSksa4Eu/5KIO5hNoHCO57JMoolMjVYmf4Ay5LnCrB0ND8LGYwwiGXufwnRtziybW5ZHTwDvDYZFl5c/AoWnpn1q8gIGorKS8OzFDqXWi0ZpV2+h33d7hv90XTh+5N+Ug1PhvQeD0Ku5VCh13o0Sb6911bq0RvgSTYeH5gDY73G6uzL4/J1Gbomqrk3zi2nuuhajPChb79fBt7ko4G5Esf1dkGCUhHrWdVnit8aDWJUhfXeaEVvKBagND2xEd73/K/9EBNU8KbY9AfPPkxieSrrmDVZYSDORYim4pu6h/zaRUfKx/rosfuxii7LcM6DCduN6NwDMo0roI5Dllynd182ZeRgkXcboVLvOzkC3+oTC5SkBe59fgiJOsTEq2XBtPH4s4W6qmG6H9fF6Xt1Cr5SyOgcA0sK4ODSi2eruT52XDgg/x/2NoXPtjCLBYt7Xxae5zNcDvzZulJh9Up/43OU/TBnRbNYqlylJ5c07F0xPBfJgs0QH92yfeBLvahOY/rLQ6FcDEGoj7AJpBC06HG63WcpxSSM2raQwH9KV7OquMWKfDv85zy/PUVtQ9LRXP2iECPZIHMFKZE2tOBNdrJGiSr5aYzGd7Ttgo3a9S0MWBkH7RoAZL4VkKbrQdEMJNsxERiOThzTVvAufQ60xCKm6WV4t3A8491fdHLHeYE+ODXteP87snha4XWxeLhOVrBkrk+1HqFBpaGEnn8Wmq2EgRb7B0ZYQ11UCp1qRz5E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(316002)(82960400001)(2906002)(66556008)(64756008)(66446008)(66476007)(38100700002)(6486002)(122000001)(83380400001)(5660300002)(8936002)(966005)(8676002)(38070700005)(1076003)(26005)(186003)(110136005)(508600001)(91956017)(71200400001)(66946007)(76116006)(33716001)(86362001)(6506007)(9686003)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bOQ1D3w+iRtQ3c82DbpbkgbooSvQK+b9o+xtOiVeVOMPxKug893u3NYPLkeV?=
 =?us-ascii?Q?hLzk8JOeCMJNn4UW/CD800CI1bSsTfxmIcfL/JVvHeGt0gwcs+pVmvR89d3X?=
 =?us-ascii?Q?LMIz3LydpKSO+KhA9Snpea7InyxHt5V9RN6cqts8eocpUlB+Mm2DNyLSjtTW?=
 =?us-ascii?Q?33gSNkcdr6dAEd3Vek2OD+V7VlJ28coaKzxxCRfNjqCdKlgoWFCNeVxY2qy5?=
 =?us-ascii?Q?bC5emZaM2tGVE/2Q9FPRewdkzw1dW5R0Ov7u6oaLC29W0zHXaMSvvJ40BE73?=
 =?us-ascii?Q?MyBz6aYZL9L6rEJG+cIxaEZ/jlXoJ3o1TntQj5p5pKCF5qd63j4cCbTewd7x?=
 =?us-ascii?Q?VWKfIUeoz7sILcCpSTk7ZGGhcZYlScsV8xTUiTWUhQyK1uad072EKPeHB0d7?=
 =?us-ascii?Q?bpKOg2G07Zr+cRsLTLxTewDrAceee+yHuDvAQECsR3v1GwvDVbpfHdSNvpd5?=
 =?us-ascii?Q?cd4Stno5FjzqzyGNNNOvPqh6VMkmPaUI8Ivxc5i8Ah3zUCjKvJwOSEfwo3dn?=
 =?us-ascii?Q?d3gmk/u88u+0o1L8V0zMzMWM1JDlB2dDXdm8rpzHVypElsQYcSb7BqLK3gAU?=
 =?us-ascii?Q?b5wwnG6XwJZthGExh1yZv6n4lTxG+sXkVOroLqucqv+L8fL9libIMeg+F1Ni?=
 =?us-ascii?Q?wXI67O1cZMeEKpMv0KphqwBhcUWJ8giWcZg6PernMA7p4Aga4XtqUGjm8L8h?=
 =?us-ascii?Q?AqzeeldW1WnIsWlu2fODIdkS29dx1e33i3e/d0Kzzwwa45syTNydxPb4pIyU?=
 =?us-ascii?Q?GovERHnnyXNAu22WjN4SIG0s0koo4xTCHu0JmCRt77ecIn0RgnJerSZbOqL1?=
 =?us-ascii?Q?jKSFdXQoxp75yIqXNa1sqOuWsuS4RNySVOuL/BstRh2s7Z87xfEsokfms6Kd?=
 =?us-ascii?Q?XR7NTnmke8CNNkBttwvG2lb41TUwixPcNRADFXjyR44/8mbY+IZuHD+543Q/?=
 =?us-ascii?Q?oY7wR91Z4k0c/dmyvF2ETUy1AKsnDdpQZ4oP0I0EN0VHIJDZYQ9qWDChFOs7?=
 =?us-ascii?Q?1CMw1kw9w5/MaWBGM7M+d+cnb0KpzwRqRcN+UY6Ntt3g7kL50pdpXkFw9zLO?=
 =?us-ascii?Q?TTqcqaGLVIktouP4jOvVrJxAauR06cnE1iTEa3e8Dav53WvfW7jpBdUuJ+1O?=
 =?us-ascii?Q?/1SlCWbBfI6uKB1HUmU81qjk0bAfxm04msUZ1Xv9GXxGoton/jUlNFPkuaGQ?=
 =?us-ascii?Q?1w/5+eg4dpx4iiJyCVGE0WEzKARHOSbijKfiyqd9WW3A+stNHndrmmTHWCRi?=
 =?us-ascii?Q?y1DpMkA8h6sC39+EQRPtfk6LeV9KcDNwvyYw1ywhoNcEL1aXC1zAb8hQEVWD?=
 =?us-ascii?Q?LXBd6kecT019FYiO2nr6A6+Z9/zr3ra1ZB8KAbCkKRviCYS8NGg7mLd+63eL?=
 =?us-ascii?Q?iDAjOsUUqhBCKq2pKVyui9xwqfef5nzBrP9z0kTz7iNO3bkUJcutJh+Bu8tj?=
 =?us-ascii?Q?hzCRESErxkc5C7sd0FlP5KwcnvcpBoNeQxBJAooy6C5ZPwzNOh3s572cstY0?=
 =?us-ascii?Q?jAwZNEegw1we018dMtvm6SOsSI8K4nV3ZKrMTXZCtxUScMC26f4ubX7Y7rwi?=
 =?us-ascii?Q?gkG5y2uhR/iH/eslY6hOCSibOFoYfvMCY+CVvKP7Enf+MpbDuCGtME+GwLUJ?=
 =?us-ascii?Q?m7AI6MK6ksUq17RnMaT3W+0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5ED5C17B91925849914B6BE31FC1EF90@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c210eff-4415-4b61-58ad-08d9a5b1c633
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2021 07:55:20.1539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AU7WSOVJUzezigJ2ziCAZZPbt0efQLF8kwHyfy4kNVgC0QfXfEksLfNO+Sq2oiUjgL51Io4zkcKR4/8cET7fig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7792
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 11, 2021 at 01:51:00PM +0100, David Sterba wrote:
> On Thu, Nov 11, 2021 at 02:14:38PM +0900, Naohiro Aota wrote:
> > This patch introduces a zone info cache in struct
> > btrfs_zoned_device_info. The cache is populated while in
> > btrfs_get_dev_zone_info() and used for
> > btrfs_load_block_group_zone_info() to reduce the number of REPORT ZONE
> > commands. The zone cache is then released after loading the block
> > groups, as it will not be much effective during the run time.
> >=20
> > Benchmark: Mount an HDD with 57,007 block groups
> > Before patch: 171.368 seconds
> > After patch: 64.064 seconds
> >=20
> > While it still takes a minute due to the slowness of loading all the
> > block groups, the patch reduces the mount time by 1/3.
>=20
> That's a good improvement.
>=20
> > Link: https://lore.kernel.org/linux-btrfs/CAHQ7scUiLtcTqZOMMY5kbWUBOhGR=
wKo6J6wYPT5WY+C=3DcD49nQ@mail.gmail.com/
> > Fixes: 5b316468983d ("btrfs: get zone information of zoned block device=
s")
> > CC: stable@vger.kernel.org
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> > +	/*
> > +	 * Enable zone cache only for a zoned device. On a non-zoned
> > +	 * device, we fill the zone info with emulated CONVENTIONAL
> > +	 * zones, so no need to use the cache.
> > +	 */
> > +	if (populate_cache && bdev_is_zoned(device->bdev)) {
> > +		zone_info->zone_cache =3D vzalloc(sizeof(struct blk_zone) *
> > +						zone_info->nr_zones);
>=20
> So the zone cache is a huge array of struct blk_zone. In the example
> device with 57k zones and sizeof(blk_zone) =3D 64, it's about 3.5M. As th=
e
> cache lifetime is relatively short I think it's acceptable to do the
> virtual allocation.
>
> This is the simplest way. What got me thinking a bit is if we need to
> cache entire blk_zone.
>=20
> struct blk_zone {
> 	__u64	start;		/* Zone start sector */
> 	__u64	len;		/* Zone length in number of sectors */
> 	__u64	wp;		/* Zone write pointer position */
> 	__u8	type;		/* Zone type */
> 	__u8	cond;		/* Zone condition */
> 	__u8	non_seq;	/* Non-sequential write resources active */
> 	__u8	reset;		/* Reset write pointer recommended */
> 	__u8	resv[4];
> 	__u64	capacity;	/* Zone capacity in number of sectors */
> 	__u8	reserved[24];
> };
>=20
> Reserved is 28 bytes, and some other state information may not be
> necessary at the load time. So could we have a cached_blk_zone structure
> in the array, with only the interesting blk_zone members copied?

Yes. I'm thinking about that improvement.

> This could reduce the array size, eg. if the cached_blk_zone is
> something like:
>=20
> struct cached_blk_zone {
> 	__u64	start;		/* Zone start sector */
> 	__u64	len;		/* Zone length in number of sectors */
> 	__u64	wp;		/* Zone write pointer position */
> 	__u8	type;		/* Zone type */
> 	__u8	cond;		/* Zone condition */
> 	__u64	capacity;	/* Zone capacity in number of sectors */
> };
>=20
> There's still some padding needed between u8 and u64, so we may not be
> able to do better than space of 5*u64, which is 40 bytes. This would
> result in cached array of about 2.2M.

We might even reduce some other fields: "start" can be inferred from
the array index, "len" should be the zone size, "type" and "cond" are
already encoded into the btrfs_zoned_device_info->seq_zones and
->empty_zones. So, we need only the "wp" and "capacity." Then the
cache array will become less than 1 MB.

> This may not look much but kernel memory always comes at a cost and if
> there's more than one device needed the allocated memory grows.
> That it's virtual memory avoids the problem with fragmented memory,
> though I think we'd have to use it anyway in case we want to use a
> contiguous array and not some dynamic structure.
>=20
> For first implementation the array of blk_zone is fine, but please give
> it a thought too if you could spot something that can be made more
> effective.

Sure. I'll write the improvement patch.=
