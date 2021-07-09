Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1137F3C1EAA
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 06:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbhGIE6V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jul 2021 00:58:21 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:57797 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhGIE6U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jul 2021 00:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625806537; x=1657342537;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DFQ2DvUpeGfXmEYQdWUgNHByxbGzwdkzd6+L2dAe5Pg=;
  b=Q9Y6G9g3mNGyYzeOQo21vEcwoJ/bW4Take/gRQPdUlHnU+8dzLj7BKJB
   jtQc88yMfL+eKPm89p69XPffpafcdrxwLkL3zCMf6n3dTGzRKYsdswbVb
   isRO5RCAf56ohXvTcTHbiDIW9pA7vJaUj9xKmGMHF9/BuGwVt4gYhxCVu
   S/SD4qC6MrXlf077j2j99v4fU6ieYUFc2KvA62L+eAsCw2wXQpcKlF5JI
   kwgaKYCMmL7o+swZH8f7WI6sShOZJNg/IciNOhxgtO/zGh0Lt2DLSLE8M
   efBNwumNlY0KmJBVx6vC43sWNELKQG4kwALWHhKy8/IlSBEmt8j576WZk
   A==;
IronPort-SDR: hO9iIL3gZ+B0z03xUNjXkW7sn8+hiYwIC58CUac7nt78emkj0pKRiTaNfwIqpqs3F758UtIY/4
 lSeoiKmZO8WAPRIdom0MwTyOSKLTLL15xYdLKuf8RidJ0N21pwJFMN9QVVtvG8T5JcRJ9dnF6g
 LHk9CQpdv0Z//nPHUSMbsvqaDmgtJbOmP290r2K2bKyGfgAOTrMyTBg/X5kiP9kB6ILhxje6bf
 tY6UW85+u09JR5VatcJnUFzOk6gGjIRrbkCAE/QcvM0nYdwOUMGj86GnXxQznIUlxoNkzylafP
 fsU=
X-IronPort-AV: E=Sophos;i="5.84,225,1620662400"; 
   d="scan'208";a="173370257"
Received: from mail-bn1nam07lp2044.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.44])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2021 12:55:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGLXDMQe2BY/Jcw+QjltS9FGUUOiiF9Ib+WOnRYOkyVt6xhaOZSKkCUB2yAIsLURliT+LV72bVzj/z7eu8n2lzaCH07ikFOcyoVHTXoFYRfSAf/y6VDdzqiRRb6/z51ROjh7upDvGf6U67nKggT6FyluDmAeiayg3PrniXzzDv1okc4YTVcpZbYi9tquIGYFVlGhEiXdHFby/1L9WeO5P6uKX7Ga6oTxjS6jeR1CSB25POFKl6k5zJhiLWcAFHYLB19O/EujANR6QDxorB2z9Cker3e0y4uGqBeZXIUDsNVQ9yoRxX5dOqjAJe00lcOGto8H/e5ggrUGXM5SRlZwhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQpE31zdY5bldfuIVAjgOeNK/YBBrhMn0y0cJjEFsJs=;
 b=f3EM1l3QGKmsXbtkmxq5bqlLXkN/nJljQjksEBSQxaS8Tp4rDgAsSyZi89PKlXeZOEfTz3gTuCQvcSLlt5R4zeoBf8OswbZg7m0TNNe4cApMFIiILBlKud4MMpaXroKeirKt9oKCVX8pNjiSfXnZqG0fXgd7vTVVPYrZkmUs1YxDDk0siwcus2n2RUZUrSO2BrseZHIs7c//xw2CgGxMtyy5PjfvLyfFB3cfYcsF42LqzP0zObpx/4G1D0X0mif3BvolBfl6RAfeNRZG5v/aUiSz/yl3e8kBTXKqAPyMXlFAU5Ju9k7oVbW5KtehXpf/YTDHNjOK4XGBHEvA1tc2ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQpE31zdY5bldfuIVAjgOeNK/YBBrhMn0y0cJjEFsJs=;
 b=Y3y4BFzN72e2OOMv5Mg2gNje/idFp/ysC9Lz10a1OKtUXFXrIep8tL4tPk+zFEg0LgbGF38t5MROE3/zhX/dZ6UMVnp/5IqL+Ja0NK0+msk5umAMUUJcQy+aYjrENahf+kxnFDYokSskBxyikxuNy7WlenpfwBNL8D7YUyhODvI=
Received: from BN6PR04MB0707.namprd04.prod.outlook.com (2603:10b6:404:d2::15)
 by BN8PR04MB6355.namprd04.prod.outlook.com (2603:10b6:408:dd::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Fri, 9 Jul
 2021 04:55:36 +0000
Received: from BN6PR04MB0707.namprd04.prod.outlook.com
 ([fe80::2dd7:4b71:80b1:9a71]) by BN6PR04MB0707.namprd04.prod.outlook.com
 ([fe80::2dd7:4b71:80b1:9a71%3]) with mapi id 15.20.4308.021; Fri, 9 Jul 2021
 04:55:30 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 1/3] block: fix arg type of bio_trim()
Thread-Topic: [PATCH 1/3] block: fix arg type of bio_trim()
Thread-Index: AQHXc/rs9j75hehid0CdbWHLvuNysqs5KyYAgADlyICAAARiAA==
Date:   Fri, 9 Jul 2021 04:55:29 +0000
Message-ID: <20210709045528.gxlwlmzwgs2gzkwa@naota-xeon>
References: <20210708131057.259327-1-naohiro.aota@wdc.com>
 <20210708131057.259327-2-naohiro.aota@wdc.com>
 <20210708145722.GD2610@twin.jikos.cz>
 <20210709043947.edhwb5cj6zuf22kv@naota-xeon>
In-Reply-To: <20210709043947.edhwb5cj6zuf22kv@naota-xeon>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4af51463-0c63-42ed-fe33-08d94295c6ad
x-ms-traffictypediagnostic: BN8PR04MB6355:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR04MB6355524B833691FEA87F52348C189@BN8PR04MB6355.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XnLoJK0165XSXMEPW3aUNFrW7fgVRESkXD/5JnL4TDGlj1pUuv9bMnUiHH9m8RYMpKZyvELkRaq/nhZQEyCRskfqXPlCPVszn7gHYIlNE8KgwgHDjc4UqQJppb4UzEdFCalwuEXQb5Q0ZhikV8fsNAlZaXh7v6Q0Nz5ed+HgcfcpSnOXizi1BYNBZ6ow+AO/DlpV6+dkBqiAy/ydMVTaiAkzHa6pJHsf2LaFzQviX7MoDlSqi5a2l2Svsecz9kbwBOzE0+MJwXaKX2NrWkhD8u/PXl1qcKmPNllue88Q71ftyMOrnPra6po2Qx3v7KX0htHm00wK7Rb2pMHVi8e7yWrOrD6/TtKRl8Cin5RGkzJcVWEhc8n8QTE8iWO4wRa3CUV08GNjjUBP8cACcl+U46WZr+wvRsm0OMnwci56p884KWfTqEHmQGQsz+zXnkHo/WITSHhi6AKrOX6z5r2BD4O+DHKOYi8MFMIvoaYaCwdw8+O9sQOWj0+qg/vxnnG1tR0ByIJEIQf0fVjvCTznXhXbG0DbvYMDY+IuniZ/32iVoLfQRaOm07f7/wAdUDeunugeJhBLZR7xvF51YamDHEJyBOCiVlfwyZpqckpG+y+GNtEQztJQIEZLBDGUTPEFemvMKNNkIZ5LE0rh9K99yg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0707.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(66946007)(64756008)(186003)(54906003)(76116006)(478600001)(5660300002)(33716001)(122000001)(83380400001)(38100700002)(2906002)(8676002)(71200400001)(6506007)(8936002)(26005)(4326008)(66446008)(66556008)(66476007)(91956017)(86362001)(9686003)(6512007)(6486002)(1076003)(316002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kmu9vr93XLlFzN0yKPxd3YYq7lAu4gSsjy4B5VC0cndBxISY6fzgWNE6z2Tp?=
 =?us-ascii?Q?jUZmoI3APoeLSiggUhAp0xbgDerfU9ThwOck+fN8SPcoVPzhpoIhhZ8xuZcX?=
 =?us-ascii?Q?FD8vujozliMS758Nav10QmnqnRDxQD5VZvQj1s4XQ8F/RRmaDj9IzA7gH8Yz?=
 =?us-ascii?Q?EWNIvUEn+2lZgzLdc/OQjVyG4yjMzXvLdXmjK2uLTYeatIFdn50AbY/u61dI?=
 =?us-ascii?Q?1cD5tVtM0tzitX26HcrGuKkmEa0vAKrwk6r8yobn4E1D67ogsI7TVLx1O+eA?=
 =?us-ascii?Q?ddptBfXhmG9GW+SjkLroqT43ryt+MPxDPUdCW9UmxOc2iGK78bZoRLoi9GVy?=
 =?us-ascii?Q?TUDYRX5ppc4A5MAYwnAYEivMWFK8Lj4EqWVn0hO26K7ybdEkkmf+o2/BVKjK?=
 =?us-ascii?Q?vtKAkW4ZP5WrlsdV2zam9w6dBXqvJx4tJv7I0q2J5p76/LlZO4u5DmPnu8W3?=
 =?us-ascii?Q?Lu5pT9WKxYG0h7wVE4TN4IxEzBXZYGSlYevwR65De5EWgjvL4dOlE1BTeq3i?=
 =?us-ascii?Q?Ev4ZhZnbQs2XATPlpV29kVf0CIr9xTqj+ODHRGRFpT/EtcOSjtt+WmrUQKpu?=
 =?us-ascii?Q?/rbeQA+RjgGuh2ip5MAhaW8S0nwQ0tCFBM+PjYT9e1y52WGOGl0qxj+X4MT1?=
 =?us-ascii?Q?De/1MOZ8k6vfXUzh0IcfHXafSGqtqmQdsHJNUllmjgD4VbkcNAamnWiDDtZM?=
 =?us-ascii?Q?SYtZtxC8TB70AGqB9utBFqCZA6SzibiC2CiA55T1sfI9TBVC1YmwPLUbIaLb?=
 =?us-ascii?Q?jXNQb/9XKZ60/OJugKQ+UJN/byWfrEvFtrBpun/f+93v3NnHkkKflpE7TbKe?=
 =?us-ascii?Q?xa+hqy6t2QdpQot+/vf0Z0zCopK/JidozEt8P8C/dynk7pZQM26w/sJqkTW2?=
 =?us-ascii?Q?dZFvdxxUDokOnufvAT2e1LeTPHDf+Jh5IfRSb6iZCYSBIoB6RreyLI5oef5R?=
 =?us-ascii?Q?tvpT/XjcBsithwPOeTBLBimtehs9tj12cTCbeKmft32QJG2oB+gV8aDrbBK0?=
 =?us-ascii?Q?sclj4/YwWaofPTYyninOwxwVg3KUskzsrKLssrFvQFmCgWKJyeOcItQJPGnm?=
 =?us-ascii?Q?nDlzzRv6mpw3/8su8sdrDIJSF33Y2dUsnpiUbTDp6z/w9mYPSqi2TDkJpk/5?=
 =?us-ascii?Q?Uh0DHIgtMRuCm38OWpCFzXcaqQC328d/xGjx1qMqV1K0ocaTw6gHTCpOmPqr?=
 =?us-ascii?Q?w7tizNRQhQJ9z8N1Ypul4PdO9dbPLAbkdIgjqVpUofTqsrUVHy8iOgqZ1q3A?=
 =?us-ascii?Q?mA6EBZ0QVeOdUjynCd0DgYJMZ+/fJC75nBUx/fcDZJ0NgOUnBhpKFCVzvP+U?=
 =?us-ascii?Q?TjmAFNJwhU1TPMxp4Hyf4FO0e0eMCgyAJiaAGWz9yHqhiA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AF32D2698E83154198CA9C59A5ABB56D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR04MB0707.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af51463-0c63-42ed-fe33-08d94295c6ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 04:55:29.8898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P/uVdlPBrvK/agh5B9qlBxTWM6lK7abfiBIN+0WWowdIcm8aTaq5FlVzaKHcYlCNNRuU/R5imIddLvZdUeUNfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6355
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 09, 2021 at 04:39:47AM +0000, Naohiro Aota wrote:
> On Thu, Jul 08, 2021 at 04:57:22PM +0200, David Sterba wrote:
> > On Thu, Jul 08, 2021 at 10:10:55PM +0900, Naohiro Aota wrote:
> > > From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> > >=20
> > > The function bio_trim has offset and size arguments that are declared
> > > as int.
> > >=20
> > > The callers of this function uses sector_t type when passing the offs=
et
> > > and size e,g. drivers/md/raid1.c:narrow_write_error() and
> > > drivers/md/raid1.c:narrow_write_error().
> > >=20
> > > Change offset & size arguments to sector_t type for bio_trim().
> > >=20
> > > Tested-by: Naohiro Aota <naohiro.aota@wdc.com>
> > > Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> > > ---
> > >  block/bio.c         | 2 +-
> > >  include/linux/bio.h | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/block/bio.c b/block/bio.c
> > > index 44205dfb6b60..d342ce84f6cf 100644
> > > --- a/block/bio.c
> > > +++ b/block/bio.c
> > > @@ -1465,7 +1465,7 @@ EXPORT_SYMBOL(bio_split);
> > >   * @offset:	number of sectors to trim from the front of @bio
> > >   * @size:	size we want to trim @bio to, in sectors
> > >   */
> > > -void bio_trim(struct bio *bio, int offset, int size)
> > > +void bio_trim(struct bio *bio, sector_t offset, sector_t size)
> >=20
> > sectort_t seems to be the right one, there are << 9 in the function so
> > that could lead to some bugs if the offset and size are at the boundary=
.
>=20
> Sure. I'll add the following ASSERT to catch the case.
>=20
> diff --git a/block/bio.c b/block/bio.c
> index d342ce84f6cf..54b573414126 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1467,10 +1467,14 @@ EXPORT_SYMBOL(bio_split);
>   */
>  void bio_trim(struct bio *bio, sector_t offset, sector_t size)
>  {
> +	const uint_max_sectors =3D UINT_MAX << SECTOR_SHIFT;
> +
>  	/* 'bio' is a cloned bio which we need to trim to match
>  	 * the given offset and size.
>  	 */
> =20
> +	ASSERT(offset <=3D uint_max_sectors && size < uint_max_sectors);
> +
>  	size <<=3D 9;
>  	if (offset =3D=3D 0 && size =3D=3D bio->bi_iter.bi_size)
>  		return;
>=20

Please ignore this one. I failed to add the type and cannot use ASSERT
here. Updated diff available in the reply to Damien.=
