Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03AEF3A3D7F
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 09:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhFKHvq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Jun 2021 03:51:46 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:15361 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhFKHvp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Jun 2021 03:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623397788; x=1654933788;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=WVQGvo4JyekxQV5+0C71cmFzBF+K6JVriYRZOcHPOzs=;
  b=gGx3t2rLinmxidaasq/CyaM5dpH+DBnn4vL21hPPUOJG+BE0vQk3NdEr
   OWNyT4e0kl8CbkF5ckU0Hoi/vS17/hJXW5K77NCRNoyE7dUQuxGAFUfR2
   x6eYkhj2NsIrtLMUj9Ie/hvi+LDl0bkUQ5PQwO66fo+nlGrDJ7E2m8XW2
   W+ds4BAWVyGy3hf5sZO1hlDhv/0rAucZJxS/zFjN2+3J8Ka/kGzz5MlYK
   0hv0LsPOYY2NjONso4FOs9e3d6Hf8Slu1EIPy06izoiClADS+7NY9UUri
   AKdfbtIscy5jxhyrjAbBfneZr1jyWnDLsfK0uH36VXxNwsvCx8bik2MMn
   w==;
IronPort-SDR: ovrUphNlkLNEzoC+YWa0/gir9lQ0/XSySNOExrQqUy7DAljx548EF4g4omTxHDq7xItDoFtssb
 9Xb5ekbXvCt64MxUnBvbCo9oQCID752tc4sBPDfI+IMoj8Ye6geF8KCUJmeuPniDomzE72xBvC
 X8q6zMgwqNFimajBghF4ss+kpQoZg4EwEdY0knEeIxLh6X6ZpMYQndpqCxt+mohUX2gxNDROMw
 sKPXxx4ARQ9ck5fRtOtBl2RSvbdBS89ClmZpnIF9hrhzfIAZga+4qxluetGtv0Kr485YaGkj84
 0sg=
X-IronPort-AV: E=Sophos;i="5.83,265,1616428800"; 
   d="scan'208";a="172124441"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2021 15:49:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZYeIqt/hBRqZLtPnAaWsW5S4tzQ/UOxLO+G+K8iaitoJdGqBrHNHhG4FfAqE4Yp4Y+tl0NqJIOQOMslE6pXjoudfyRBHBfc9Gy1fwJ1ijPb2QYvtRNgYfO8DlDYV5H2+j0UaiWNLTauKw3pubNMlWXM7S/yLO7aCl7vgSRJpEnbG/mA1Ipi8+12IUJNm8Msvx3KJUHFmvaKrhCLPen2LnvQGJSQS56Ecx5RvFuYodykGCtFqV6fB0enQrIdWrDjpjfoU+W6MeFkAnm5RzFtg5Wbh3YhUun5+R9uSfJnXEnHWJmnPBMfnS/MsZI7Gi6OxE7d5uyIY6NEnCCqjOFjRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJzDQzJzNf+U4NJpZQna9MaojGc3GeWiZj2tGJt/Tos=;
 b=PT8TWhbUBPDMbZ0J1KqL0VUnJ9PPuNb8GyuKgj4Avm21dvtz7HI1AMy/2Z1czVmpcHMlC/E1u3OQoh66kATyPHdQAyV8j/PPCvnrWRjdtHhmDFE2TurJrrXWDIUTolOn/qVWEUyD8haIECOre9uqn8aXN7oSzC6+zP6em6/HnUn3SxfzYiV85FqL+CXJRRjK584yZGjDhX7Zj95qxYSEbAVUb4gj1jGCcF2qXGOkuzl/suQFfcgp68gVoYfPN3T+gOIAm1IDtVs5kyy/F0G0FSoZr6v7P/Kr/dBdd3wQ5FfF/klhi2v50VszQS/E5vDb8XfU1IQDQufpB+7MMSVq2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJzDQzJzNf+U4NJpZQna9MaojGc3GeWiZj2tGJt/Tos=;
 b=Yq9eHsC8Dg/KsZxrkvw/Eke0zsn+EyYCuSKa9jN4urJVoP7JY7usmxH4/7rdNuoxrRXsc0cwWSTzLWdH6NmAyGr8O0Gpmm+E2l4RItK/MXCTAeKiCRP+qaK4mmD1BIsEbjwsC7Q3Vj8YXLvWGA1O/c70hesIoDAJapEXQpXSxP4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7623.namprd04.prod.outlook.com (2603:10b6:510:51::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Fri, 11 Jun
 2021 07:49:45 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4219.023; Fri, 11 Jun 2021
 07:49:45 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 8/9] btrfs: make btrfs_submit_compressed_read() to
 determine stripe boundary at bio allocation time
Thread-Topic: [PATCH 8/9] btrfs: make btrfs_submit_compressed_read() to
 determine stripe boundary at bio allocation time
Thread-Index: AQHXXmGkeNgEMm2fkEuHw4DggYnomg==
Date:   Fri, 11 Jun 2021 07:49:45 +0000
Message-ID: <PH0PR04MB741678D81425B3F3E24DD28D9B349@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210611013114.57264-1-wqu@suse.com>
 <20210611013114.57264-9-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:141b:f301:e91f:9de6:cb32:f149]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41cc9830-5bdf-47a7-df29-08d92cad7b39
x-ms-traffictypediagnostic: PH0PR04MB7623:
x-microsoft-antispam-prvs: <PH0PR04MB7623459CF2E210DCED6F80D89B349@PH0PR04MB7623.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ohP3Loipw6ko/g3c8jzVIb3inuQ+yBd9g5yxncPLRijj8hVRGz1ACRCt1gA2ATm5DZ+/bYAlCfEH8BrOg8Oa3v4jjr6mwlXm8UqkvJGQ4BwoYjDCCkOC4Ol+iCUPifqHc5TjYlQr4xoLiDoAGuYXi2ZXQyY54GudlpfXPQydcMus0aTgsUgv6SOmWA8cmlo9sCIuRd+YEgqrf7GIf0V78QYdERivTZT57ewIF37kHP8QwzVRRpHDR4YY8oVpMwTuVALZOQWYNwQ72qY+Hf1vGLcmAknQB7ZVdiopj4UEEnVK/l0FqouSsX/iBobmBIvqWEGNAe/QgdKy/NAHY3zogNY0DLkU5olsoEOcfHfj5GFQCZe0HzHggZI3v3gHpxpL1rTVlVIkiXopuk0nLgz7R42CoOoK+QkA1jhMA/pPptXrsU2he2zVxxARTvp3oxaoth5TBDf/+M6CEeLWeuRHcb1t4N14jlVfywJaQS8SvORyFQ4HdZ3zZqoAtVlzR2Anjpe3rLAR2+8WnWXba12wxYesxkF68yRrM3AOwvUD5zBmlmF/BNTm8W8LzgCR3ANWJL6WGG4LNiwyeWuDI/uYcGKZPckcMHhgzLmFg1yFhtQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(66556008)(66446008)(76116006)(64756008)(33656002)(6506007)(66946007)(478600001)(53546011)(66476007)(5660300002)(9686003)(91956017)(52536014)(55016002)(71200400001)(83380400001)(7696005)(38100700002)(2906002)(316002)(186003)(110136005)(86362001)(8936002)(8676002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XzC30XIZE38kEKsOfRWEgqS83VH9+AalMdxOJnm/HoiuW5AaZmD/C/6bZEM7?=
 =?us-ascii?Q?VIyJVzEX9Imys8vZXn3PyF5nMhFamxf/32E/EKit46/SdbUyJgFHNBLGeNox?=
 =?us-ascii?Q?Lc+270BRk4lEHgDLn4//uA72iINvup6JlQSvpf7iMKD9NM3tJtTYnY1WVx2h?=
 =?us-ascii?Q?kQU2LvQL7HIcxGEfXwwW4UsK7Pv4+QKva+QvYF3TUZyBUmk90p7eWcloMpAN?=
 =?us-ascii?Q?6hgUyzTXc95htdYeg/Lkp66G7pYGIAhPyKi/QEL98C6HRP5Q2pTDcxORY+po?=
 =?us-ascii?Q?xMLJCF9i4snt+10kiAo+41yjSFPJ6kGKTYWk0DhTkKhjO+m2u6oJ9MuGYo9F?=
 =?us-ascii?Q?d7aad4DRwIYh3tfA9VV9FDn41E2dd2ubGeD2l/yJnVzBne9GkyntIWYnuu6Q?=
 =?us-ascii?Q?GyNH4X8a31w87TyV38QKDcHv/8XiwnfY6ZmR44+XbVAa5GeH26Z0O8yIFyTQ?=
 =?us-ascii?Q?h0NI5yiOwn7qznqzTx0Z3B/GoPzfpA3OHPnmzM6wEJYdb9YUqQkk9LHslSAY?=
 =?us-ascii?Q?Spozww3g3aIkvut9uzvDJPGebDecxTDs8d/KThSuTW2B1YMJi/JDt8YO2tKe?=
 =?us-ascii?Q?iILGnAOoU6o366dDdPD9w0SSKpVdBegP8RYRVV0VEll3MaP7PR5nF2y3XOJC?=
 =?us-ascii?Q?6r3DdVvSQBLsIL0nPXmEQ+V9usFiJCgUdPb/B4XnWa707D2UhCG0u/yqHVmk?=
 =?us-ascii?Q?jVvPBjU3UlX/PjcNKXJsqs/sWmEk1BgY8Tjp1QieBynSCyLA/jJIHbsExgZp?=
 =?us-ascii?Q?ejQuHHxQb/xb+8VEsmJC1J/NFEEPUfzeWIZ245DluDx/mB1cjtkQ2c0W+orn?=
 =?us-ascii?Q?mAd4coGAXH7aUk7OfHJN+Niu3EMuRfsLSw4Gd9r/YHMN4lFbHPkCFn5EUUq2?=
 =?us-ascii?Q?1xb1+j1FfxlTGWnTVy9tsGFBlaBgAfwplwetR0qAY/gcj0GehO9LpeBMamL0?=
 =?us-ascii?Q?Abw66X2Id23zkXO5WyXP/kPdBObhS3BprX3PcDbAvVrGs2E+/xR5CET9tIbP?=
 =?us-ascii?Q?hEGkqzJtZeMvImqrF4byRQZkgfvqabRo4JLWJfPtsk32pqlaUZ6zG6L4MaYJ?=
 =?us-ascii?Q?PXmz7GAREjFkkJ5toK6RJY4KxYc+ITUIScpb7AbvPt+uftqFhPcaxSJ6v3Vu?=
 =?us-ascii?Q?arDM8X7LuBeQV3WAZsS1OxpWuGfF6jo6gOokqmX+QS1XTMgtSg2oVLSvgIKn?=
 =?us-ascii?Q?ChZjKdUrWaNr3WJr3/09TfDqW3V0peh9UJfnVhWqQklshXhEbrpHpfj2Irps?=
 =?us-ascii?Q?yIA9ubXgpJ4rZ0ZLkhr1pKympz0OoNzfz8Fd3802j2cUO9CBzsNLv8XVjr1k?=
 =?us-ascii?Q?/JGdT02k9OhyrqxQQJIozbTir2nD7F+9ATa9QpvZeFY0jRXme24TLD9Jksgm?=
 =?us-ascii?Q?dN/mH9N5y/74a/WlWQnfs5Cqkm08rJlvpSgcDGasZM/83lVpLg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41cc9830-5bdf-47a7-df29-08d92cad7b39
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2021 07:49:45.6954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iBAQ9AFTpPsKeRXyINxATRth4doVxTqwRo4lxwBFfPUjcPkR8VGR26m9aA4UuJ+DeYGFHDGIvn+Nj5HGVxFgQqUZUHCw1NoOJF15BDcaFVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7623
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/06/2021 03:32, Qu Wenruo wrote:=0A=
> +		/* Allocate new bio if not allocated or already submitted */=0A=
> +		if (!bio) {=0A=
> +			bio =3D alloc_compressed_bio(cb, cur_disk_bytenr,=0A=
> +				bio_op | write_flags,=0A=
> +				end_compressed_bio_write,=0A=
> +				&next_stripe_start);=0A=
> +			if (IS_ERR(bio)) {=0A=
> +				ret =3D errno_to_blk_status(PTR_ERR(bio));=0A=
> +				bio =3D NULL;=0A=
> +				goto finish_cb;=0A=
> +			}=0A=
> +		}=0A=
> +		/*=0A=
> +		 * We should never reach next_stripe_start, as if we reach the=0A=
> +		 * boundary we will submit the bio immediately.=0A=
> +		 */=0A=
> +		ASSERT(cur_disk_bytenr !=3D next_stripe_start);=0A=
> +=0A=
> +		/*=0A=
> +		 * We have various limit on the real read size:=0A=
> +		 * - stripe boundary=0A=
> +		 * - page boundary=0A=
> +		 * - compressed length boundary=0A=
> +		 */=0A=
> +		real_size =3D min_t(u64, U32_MAX,=0A=
> +				  next_stripe_start - cur_disk_bytenr);=0A=
> +		real_size =3D min_t(u64, real_size,=0A=
> +				  PAGE_SIZE - offset_in_page(offset));=0A=
> +		real_size =3D min_t(u64, real_size,=0A=
> +				  compressed_len - offset);=0A=
> +		ASSERT(IS_ALIGNED(real_size, fs_info->sectorsize));=0A=
>  =0A=
> -	/* create and submit bios for the compressed pages */=0A=
> -	bytes_left =3D compressed_len;=0A=
> -	for (pg_index =3D 0; pg_index < cb->nr_pages; pg_index++) {=0A=
> -		int submit =3D 0;=0A=
> -		int len;=0A=
> +		added =3D bio_add_page(bio, page, real_size,=0A=
> +				     offset_in_page(offset));=0A=
> +		/*=0A=
> +		 * Maximum compressed extent size is 128K, we should never=0A=
> +		 * reach bio size limit.=0A=
> +		 */=0A=
> +		ASSERT(added =3D=3D real_size);=0A=
>  =0A=
> -		page =3D compressed_pages[pg_index];=0A=
> -		page->mapping =3D inode->vfs_inode.i_mapping;=0A=
> -		if (bio->bi_iter.bi_size)=0A=
> -			submit =3D btrfs_bio_fits_in_stripe(page, PAGE_SIZE, bio,=0A=
> -							  0);=0A=
> +		cur_disk_bytenr +=3D added;=0A=
>  =0A=
> -		if (pg_index =3D=3D 0 && use_append)=0A=
> -			len =3D bio_add_zone_append_page(bio, page, PAGE_SIZE, 0);=0A=
> -		else=0A=
> -			len =3D bio_add_page(bio, page, PAGE_SIZE, 0);=0A=
=0A=
I think you still need to distinguish between normal write and zone append =
here,=0A=
as you adding pages to an already created bio. Adding one page to an empty =
bio=0A=
will always succeed but when adding more than one page to a zone append bio=
, you=0A=
have to take the device's maximum zone append limit into account, as zone a=
ppend=0A=
bios can't be split. This is also the reason why we do the device =0A=
lookup/bio_set_dev() for the zone append bios, so bio_add_zone_append_page(=
) can=0A=
look at the device's limitations when adding the pages.=0A=
