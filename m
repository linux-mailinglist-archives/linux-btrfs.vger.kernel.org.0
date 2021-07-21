Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7023D0E39
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 13:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbhGULPr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 07:15:47 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:45257 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239812AbhGULHF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 07:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1626868062; x=1658404062;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NJwWE9AALdNBkL0+ANt+tOpOrVoIoPaL9OwApaVQOSY=;
  b=hqlzrynLbOxIXY2INZypnMTHc9+oEsfYWqQ7XBS4HXeZ04icPo4Sh+/B
   uJHfyNMOgmVDQz2IRmbXLaW9/fwURPln1xLuu2xv36rWmxkKqVpptVqnr
   4hTCR3YyCm1A24M31fUmGhckXgCj4bXyq+GzmKq9HkifKX03aqEH+Jbr6
   95PtXefvcRa41To2rvPOEoSPHLiljUNy5daG4zriFAlGkzX0/ytQfrhdD
   h8D7dB72+hMkalKkMOsXSpdr0I6Av0REoia0Nj2gS7nqkwztCTJ2x97S+
   HNfDPN3NWzdWaGtSqu27L666aOCI5ngDFAQJZM78QF0Ndef48GM0Etm0S
   g==;
X-IronPort-AV: E=Sophos;i="5.84,258,1620662400"; 
   d="scan'208";a="278957380"
Received: from mail-bn7nam10lp2106.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.106])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jul 2021 19:47:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyzodfelV8xH/kcq++avcLyiXI8BlQmEHm5bJLSmZVBHbSmBxN0hdbpDYjD1emf9QlIHwz31pTrvOvgV+sQNQfPdxkxpMXmAYmiIwLD7dGA7kKE5LVtuEuKh6qHP8rLyu2EHeztY5mS5o8mO4asCIeiedmE9OX4bLThbXNZ2c4JFfupP9gDHcaYYXcUPce2eZyDJ7kN0IZ078ymoNq6CD0F2A/r+v5boD6JnqWdkVSXtj2gI7OsIkPunnxyM5PGVjGvO6jimCh5QUEEivo+Luhoxkmw42aQmHmnNckvvN6Shm2xi0OtA9Dz6KJ+aLl5zTmakwXMgzYneeXXgNAPXig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YDbwP1Gfxcmy1yMKj4bKHPTdEY5bmVjUwgtFOI1giE=;
 b=G2LKscyT3DI0BjGrfXI5vAfxfqYQUgnQdhXSuKk3j7fyHZxnf0snBknO+huhP8j/8bJQOauweLNnaL1UFORjUWYoJkXOZHAlGgOCDxmtJYTfPs2yYPBpYsKKvcGuzp1cfHHwafY/21Xy/D+Oh6gv5E30cpFIgBKLVSU7ZKgdxePBXXXJz1OOAo4CFCGTVQ3gbD23wQA8znBDqD0m2h1pKUv4vwufZy5QM/s46MvCkbdJ91uRUtCQAZqOdjefWvAhK+EZu7Zr1uDntrd81k4tX/PeHSunPBxKqrdV4+IiviQis/5mE2JhOUDAxjmyF6xwjQBYPnyy9C8uXi/BSJAcsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YDbwP1Gfxcmy1yMKj4bKHPTdEY5bmVjUwgtFOI1giE=;
 b=xzR5QTwK3U+1DxGnmL0VMNAQKonF6Ag0FJ/N1MJZK18mqq46hMxLJU+jvSx1ctdPwwPtOtU+pIRuyIy3H3cXsVxlbz6BH6ZgGEd4SNv9YvSz2+l9u+iIbiHdLxxSaegyKjgYxSzfYiaasJU+CsCDNEWhrpAsrkN06ceiGGI+1Uw=
Received: from BN6PR04MB0707.namprd04.prod.outlook.com (10.172.197.143) by
 BN8PR04MB5618.namprd04.prod.outlook.com (20.179.75.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.26; Wed, 21 Jul 2021 11:47:38 +0000
Received: from BN6PR04MB0707.namprd04.prod.outlook.com
 ([fe80::24d8:93d7:ee91:2b22]) by BN6PR04MB0707.namprd04.prod.outlook.com
 ([fe80::24d8:93d7:ee91:2b22%9]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 11:47:38 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v2 1/3] block: fix arg type of bio_trim()
Thread-Topic: [PATCH v2 1/3] block: fix arg type of bio_trim()
Thread-Index: AQHXfflzh5p22s7PrUC/Iw46ccALQatM+WmAgABXCgA=
Date:   Wed, 21 Jul 2021 11:47:37 +0000
Message-ID: <20210721114736.scrkhlgkyoo7aork@naota-xeon>
References: <cover.1626848677.git.naohiro.aota@wdc.com>
 <6bd02746905e41dfee04f2500d6d15f9b9b73fc9.1626848677.git.naohiro.aota@wdc.com>
 <YPfAVSlYdM+TAe2z@infradead.org>
In-Reply-To: <YPfAVSlYdM+TAe2z@infradead.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab051a5b-c337-47a1-0cb3-08d94c3d56d6
x-ms-traffictypediagnostic: BN8PR04MB5618:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <BN8PR04MB5618A0E7FA83E126E5E413118CE39@BN8PR04MB5618.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lnWWgdi39eTypJPb6CI1NGWmYQLBrVTod2eIdwnySoKyHAHBkiO4rIxsClgEyxDHWgqcWPozfh+0MdD4DYFskXc2Pc0c1NEQSgdCV3m6E7JT5hVgRMI6vCzoeZkX9lkdaBoxkgobdsKFkX1AS03kE43oAfKCUmYhjV9lliW5QnHVLCbyBZJ7KBOVFj+CQWVqsuewJ+Y5VbGWOPAoiYiKwdGCU3xQCuvF36zIUIA22OuKKHAhqLH1ZMi+2BXlKVWNXAridRfPZCsmOxxmjHXDGqkhmHt0k70EJLcatNq41fENzLst//y3HxICBa5HO524XJ9fNjD1oKlC9sVI3fTUVpD3k5RJjT7BMO3KQw1OLWjMIKmDrWaDZ0y4hfWQPjamuGJq51FhSs/WNkjVE6+4VQURT/Xnrcve8GjzFlDAdt69cL5AvyuJACVW9Rosuo2AHftKieDBD1Dju/qHZZrw75K+znMhpujbVLYVQR/W7visQeawshKIrE4t0nx+648ruu2gy0J5bwJ7SKzxa9kCz2qdbYNdm4x/wI2lkOOGAwmhXj55ZGiIAZNe5QCWv1zgmzwpkl7oNB307RlE65q64OlsUcolccd284SBtcYNiu3wvKdfX33LDl+CKVXmKMwfrEn+Rj4V0rlNf3TUK6w06wuVcugEtsCf3UfmHhPf8E7DrPuvPv9WErLywQh5YX2vpeCbbeMec9AnLXanO2jNxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0707.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(396003)(39860400002)(346002)(136003)(376002)(366004)(66946007)(71200400001)(6512007)(316002)(54906003)(66446008)(122000001)(2906002)(5660300002)(26005)(38100700002)(66556008)(64756008)(91956017)(9686003)(66476007)(83380400001)(76116006)(6916009)(86362001)(6506007)(8676002)(6486002)(33716001)(1076003)(4326008)(478600001)(186003)(8936002)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ugPP4jVM3Xddgb50MSlyTJ9TszptVEGhbtjMlyMrCUrHb0TlRITteFuDa/C+?=
 =?us-ascii?Q?oyRbo6CCuRgF3N/dmzWrbMNuthjMX+wvJQAwG+m/X2i6rNoRCaX8FCEd3Vyc?=
 =?us-ascii?Q?STB7vojn6L5UdWBknwFJhD4x1HG76EfGzoUKZS4+/bzPDwwVIxSYuAXC8mFj?=
 =?us-ascii?Q?yNsBPUFMR7M+SxGPRifZrpwgx6kcGNdo62vIp2lHp5cISjm1cRAca9qXI5pR?=
 =?us-ascii?Q?WRBVA14EjCKoxjC3gUvuPnNuJkq30z5s4/ovJ4M2uyMIwe02M4KOuBkcM0x0?=
 =?us-ascii?Q?PGYvZefsJWmNOz/FSIK7Sap88t95+WymGj31e4RREe5iHiCWJTATigru6yWY?=
 =?us-ascii?Q?ynuSDUqX2R9oAFvuq2W4hHMwRuw9tXFOd/HDB3m0Iyx7pzWOmhnHAKHLqVBi?=
 =?us-ascii?Q?BBKCXYNLrfhbhqxvnTa2Zm0vdJ7+k0sJE6F+OqSbs+A8fmNZ4jHVHeLORmkX?=
 =?us-ascii?Q?I7n6iGzFD7IDt+fgi5CcDPeo8i+gJwlt013qKvOeTf0JchBu9z/nLkOFexow?=
 =?us-ascii?Q?ce5r9EmOY1Prax1z8JQGE9H5nLZEdzmk8TIajTC0Gw4OdKKHImpZ5QXiYQf9?=
 =?us-ascii?Q?4JZIvf7WNBNJTV+I6aVMsbTqCbbDxuLUiyF5+S7oj2I2JsfwXw1C1DhXPeFU?=
 =?us-ascii?Q?jQA/V/Sj+TnLlYUK3PCveaiRMx8Xag74lRx6MSaTw+T+Q4ZJFCcqVEH8/a5B?=
 =?us-ascii?Q?HBs/3sZggMpt6gFi/EZbzwriHjShUhzRNWz2eyARpuHeiRt8gdkCLm23SQnE?=
 =?us-ascii?Q?2NcVM5wwlvdqRJgmtVoXFIZOULnUig+/bKaciaeUtyYMdaiCe9RsqSqVeyxc?=
 =?us-ascii?Q?hiYmcSD1Y6FaxnNo/nTqu9SbwzLrTT+0Vi5QSzwy/c3uHCSPPRnYLNA3hxgv?=
 =?us-ascii?Q?1Gfb9uoJBI9isPhZ3EoP2rtwEIP2K+FcU8Ix78SZFoKsHJjnt2mXelJem9I+?=
 =?us-ascii?Q?QqWuAFZGIVNw69amYeIiizIt97TBb2kDsMfLA6RUbj4zjXoyt6TYTTUB6Xxs?=
 =?us-ascii?Q?sSs4GxD+EH514xlE5fYmnsy/VJgMwu2Gr24+I0WtUY0ti7GpmG0ccwALSVQ+?=
 =?us-ascii?Q?Unop87Ff31SPe3jEQHmuLp9XPBv2qQjTJRORNTzxRZxnKv+7jUL6h8Q9ZRNj?=
 =?us-ascii?Q?d80tK9URMl7vq0u2EaLPp74LQv/IwcsMZA4gw6vTBbOV/qI3oJ8pd8oMzyAQ?=
 =?us-ascii?Q?Pnp/Rk6Zw9Jki6XZintr4aLRWsiEhvfze7Y7pA0HcKdl0Bk/HlJvUWcRkNeG?=
 =?us-ascii?Q?vd9aAIstbX8vV/W4fTTDr3+mKhkMdZupwgTJ026N34S+bUy8/3Az/N8qw/uA?=
 =?us-ascii?Q?RsMieHoZC8N/LK1zRYHRMWQ8?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3B114DA0CD6A4F4BB7ECE2A95F23EB88@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR04MB0707.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab051a5b-c337-47a1-0cb3-08d94c3d56d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2021 11:47:38.1801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gILhpcS+gMVw+1PP6Dp1jMZ52ma2XuMuSlXgUTqEKjBedDBMicq3CX9miQuGIS32ueB7VkRG6gwKajNkQg0Buw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5618
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

-Chaitanya, as the address is unavailable.

On Wed, Jul 21, 2021 at 07:36:05AM +0100, Christoph Hellwig wrote:
> On Wed, Jul 21, 2021 at 03:26:58PM +0900, Naohiro Aota wrote:
> > +void bio_trim(struct bio *bio, sector_t offset, sector_t size)
> >  {
> > +	const sector_t uint_max_sectors =3D UINT_MAX >> SECTOR_SHIFT;
>=20
> I'd make this a #define and keep it close to the struct bio definition
> named something like BIO_MAX_SECTORS

Sure. I'll do so.

> > +
> > +	/*
> > +	 * 'bio' is a cloned bio which we need to trim to match the given
> > +	 * offset and size.
> >  	 */
>=20
> This should go into the kernel doc comment.
>=20
> Something like:
>=20
> /**
>  * bio_trim - trim a bio to the given offset and size
>  * @bio:        bio to trim
>  * @offset:     number of sectors to trim from the front of @bio
>  * @size:       size we want to trim @bio to, in sectors
>  *
>  * This function is typically used for bios that are cloned and
>  * submitted to the underlying device in parts.
>  */

Thanks. I'll use this.
=20
> > +	/* sanity check */
> > +	if (WARN_ON(offset > uint_max_sectors || size > uint_max_sectors ||
> > +		    offset + size > bio->bi_iter.bi_size))
> > +		return;
>=20
> No real need for the comment. WARN_ON pretty much implies a sanity
> check.  I'd make this a WARN_ON_ONCE as otherwise you'll probably
> drown in these warnings if they ever hit.

Done.

> > -extern void bio_trim(struct bio *bio, int offset, int size);
> > +extern void bio_trim(struct bio *bio, sector_t offset, sector_t size);
>=20
> Please drop the extern while you're at it.

Ah, I didn't know that. I'll keep it in mind.=
