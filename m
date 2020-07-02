Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA19212585
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 16:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbgGBOE2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 10:04:28 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:33231 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729432AbgGBOE0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 10:04:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593698665; x=1625234665;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=iHBygvFwiNw+8NOhURGqOO0lTKqwCYavy5M1VWC21Lw=;
  b=H5AixXSset/2f2QK2WFhCLbf2afrkYas+JpvWJir2QjxFDFenTah+bMo
   k65vdy4HdFPo3lAnLwr6aNQwSmx5+rHLNyrcQUXzO0QXyr4d0FQKvHos9
   co4/fxcbVYIdjNSExONTrj3+XWx8iSJ5WL9P9SmaabtwzAcvaew8slhyL
   YLpUxc2tfgo7kjchdpWlKbWQquuIMzYR3YvJKYzUfLdsOrs32RCfGJZPa
   6WQpaVcuudCU2jgyhkKXFo8f8Rvq/pmKdaO4S3fM1LiToRdlH71cDi7MD
   UsIapnIlMQYDIgxyrFQvthCnDuv90ItQJF8jSoslSb+NVaLUpneaFdamd
   g==;
IronPort-SDR: OovblJrCJL1VvTiVtESspb7y5bHl0FHQePiJH5aL224I71D7YdmJuXQIJa8HRtFyiEj4M7nuMw
 5WN0QpXY2O5Kt/D3J9YAoLixdT6g3AKiP35GaDPA7gQVoSsml5gks2KysbvVCTFxZ46pTVD6yO
 gnjerpqSEHRIqqDjtID96PQu1+JomdchkSIzgqX3suSGt6aJXfHyGkxhzVURTdSdhb6AOIJgDr
 aJrxdxV/PmN0tzrtwJTHuqyGtfz5tOd/6ASOO8vygMpJjs9FkIDhz6xD8C/hWKzf58cMYCm/uv
 dQY=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; 
   d="scan'208";a="145812484"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 22:04:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHmahRclp0iK3hA+C6RHLhIA47xRd0Db/G17Ry55fyJUz9fs6LgKYHC9NdtrSACku6HJ8r0W7PXklaF8TpqTmmZOQaeBnCzuRBT14gJUf7xYJtOUx/01GsO1P0z3ZInCRuGBRRASR8N2ugt5OO2mI29o/xy7y8fdG5Lgz070QmKvPMMHAqk5jkkjN3RUJS+oN/JjPE/qzxEKm7tJSCxvwuQh7ZqIB7EA1YHiMzQr0ZAVsksl++3oWC+TzXTyaaXgXL8VhVPpoHFrDfT3YDUmWTvpnsTD2icK5pCRtmwiwd3C4gMXA7Hw0q0POj5EWiNhoDNBsIhNCX38PjyqpOPFng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AOfWWBAhiLxIBNVbo+2IjCWF8DiGcbkYhRwf5cRsvU=;
 b=je8OldFwbjCrs6gNtBX3c4I828WWSVVJGXmCJXM3TQQREyzBxRES6zI0sC/vgA2nF/AEp2nnRj1XZVIkkhbNv3biU3tl6XKC01YIbjGZiOt78iql861vQeQQShBwiJ4oFq4r1wNv9TrfORHDIJy8sdyXjtWjD0/6nU3Neq9U8oE3IJRdM+puNBf3p6MadQrR+sFsCjzbUsZphhfSMT6CHmlll6rmq630AALuuur0HKhEtFPfq/Ut3Ek4TgHUMAg1dNpncR7EPbG2evmwqP5vtAYAn3ypK6ntOHdpxokurHsk1Ct59Ak61KAbI7FD7djc89xfSkew0IImftKTNvf4og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AOfWWBAhiLxIBNVbo+2IjCWF8DiGcbkYhRwf5cRsvU=;
 b=kGXfgJkJzFtzHR4E/feXhHSOcL+Yh1uA9gxW6Fmg2pRR3fuM3Zc6hkZLXOKum8abVVAhsgsBYQR0r6OtFDzcLTfF4iO18GhsTVddn8EMy8xiO2fsnUQ0a6QxQFx2n+pKdJ+TpdfIpJiMQjEkYyry+jf90u0ILQb+M1M1LSC1KC0=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4687.namprd04.prod.outlook.com
 (2603:10b6:805:aa::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Thu, 2 Jul
 2020 14:04:24 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.036; Thu, 2 Jul 2020
 14:04:24 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 01/10] btrfs: Always initialize
 btrfs_bio::tgtdev_map/raid_map pointers
Thread-Topic: [PATCH 01/10] btrfs: Always initialize
 btrfs_bio::tgtdev_map/raid_map pointers
Thread-Index: AQHWUHdF5CzXOIbGJEiGQaCbkMHjwg==
Date:   Thu, 2 Jul 2020 14:04:24 +0000
Message-ID: <SN4PR0401MB359800E3D7D379E9161318379B6D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200702134650.16550-1-nborisov@suse.com>
 <20200702134650.16550-2-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6013bb8c-ad50-47a4-41de-08d81e90d350
x-ms-traffictypediagnostic: SN6PR04MB4687:
x-microsoft-antispam-prvs: <SN6PR04MB4687EE90B7E72F55E1D0D1189B6D0@SN6PR04MB4687.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I6kxwrVqLOP/Z1/qpc0dpdpLrhLC3Dfz6/1F52jmXtodufsUPq+rjSEbuQJQgkczorAxAJDIz1+s8Yi6WoEoqCSeZ1E6kpheF/fz5rzr3sz7lh4feEJDEQWS+zA8hJEX8/P0gWBjdbEcQzm3YH1LMvoMqlnHCZItdicROBCyQs1+AHm9UzPUBzoN8WsQhcoisNzigO2sBV+snEsNQiW5JkYPcKW1ZmmWqiG2pfzrIJRhWlL8fbzSepTyNodioGw3rXa6/O3GIKjZasJz7gncpZq0sMrqN2kk043GgXksLMTwNd1qsTNkgVYQaoLn983EOMF0ijMtYVQIy3fglKX8BQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(71200400001)(66476007)(64756008)(66446008)(66556008)(83380400001)(316002)(26005)(110136005)(478600001)(7696005)(76116006)(6506007)(86362001)(186003)(53546011)(9686003)(8676002)(52536014)(5660300002)(55016002)(2906002)(33656002)(66946007)(91956017)(8936002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: SAAWC2gFLzYLqmmp3LJBXrBbcQpCmisTTyT6GexcAGiy1n1MxKqXYhLNvArMxsfm1/V2DdH7ox2wGSafP0lBwzZuK0JuMBE+8pNviHArbetNhuPrS/z5MqYRqbemPVnBN63LRMRtJsCKokchHTzmuGL+4AGRvL0CQ19Vzm4WJLC3EIk1o2LXYC0qS4mWJD/mcVVxz/dXOsUJaufrQhut3zdzACduO9eLxi8GTd1+3cCiZxoN60AntUpKfZUyMQPOhGzxFDRsqNx03p/SJbZm5wQVD9WA17HwRYfixU4qfz1QTbDozPmc37eF06/UZkHBTjBB1J/p6oBrJcZdD5PzejzbqX7BbPysgEGm3NFHB7ZxU13wA7MY4QEKwRNWpA07fyTjB9WwzpVLNQLgHjWPr/ZTNfTeMxPvWQNC0eF0aNtYqM9zzErKXJiVnVy71lV7QlNLEru70Ve07oWmUTK9RNBX3OBDV5sq1gDpmZ4Tua3OCOg8vNb25FE7qdH1TJC3
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6013bb8c-ad50-47a4-41de-08d81e90d350
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 14:04:24.0522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kI8wTOZQ0KAeofHVkW1gcfwqZQbEJQf25RjnhOV4zEFgN2ej+iVAqWwYLZRluNcqruiWX/0uRf8j0TPat5tF/KrR/5oJi2Doe+UKzGZaeyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4687
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02/07/2020 15:47, Nikolay Borisov wrote:=0A=
[...]=0A=
> -		bbio->raid_map =3D (u64 *)((void *)bbio->stripes +=0A=
> -				 sizeof(struct btrfs_bio_stripe) *=0A=
> -				 num_alloc_stripes +=0A=
> -				 sizeof(int) * tgtdev_indexes);=0A=
=0A=
That one took me a while to be convinced it is correct.=0A=
=0A=
>  =0A=
>  		/* Work out the disk rotation on this stripe-set */=0A=
>  		div_u64_rem(stripe_nr, num_stripes, &rot);=0A=
> @@ -6171,25 +6178,14 @@ static int __btrfs_map_block(struct btrfs_fs_info=
 *fs_info,=0A=
>  		if (map->type & BTRFS_BLOCK_GROUP_RAID6)=0A=
>  			bbio->raid_map[(i+rot+1) % num_stripes] =3D=0A=
>  				RAID6_Q_STRIPE;=0A=
> -	}=0A=
> -=0A=
>  =0A=
> -	for (i =3D 0; i < num_stripes; i++) {=0A=
> -		bbio->stripes[i].physical =3D=0A=
> -			map->stripes[stripe_index].physical +=0A=
> -			stripe_offset +=0A=
> -			stripe_nr * map->stripe_len;=0A=
> -		bbio->stripes[i].dev =3D=0A=
> -			map->stripes[stripe_index].dev;=0A=
> -		stripe_index++;=0A=
> +		sort_parity_stripes(bbio, num_stripes);=0A=
>  	}=0A=
>  =0A=
> +=0A=
=0A=
Stray newline.=0A=
=0A=
