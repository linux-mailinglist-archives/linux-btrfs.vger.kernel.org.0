Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6953C4027EF
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Sep 2021 13:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbhIGLlz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Sep 2021 07:41:55 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:5352 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbhIGLly (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Sep 2021 07:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631014847; x=1662550847;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QHGWTF3GhMn4aV/2m62Qn1AQ3JAgepY5CewOMi8H52Q=;
  b=AshF6u4f7x57CbjMrDvzvwpNgcwik6EWa1Awv3ddT4+oiWgS4yuBquHy
   dhyduAGMWhbI5SIoLNjUOsGBVFWg9sCuf0Vc0yGNzStXEf/nTUt9jO0PT
   xobq08Nhio7QwNv+J9+9ibm9XrnYIvy2eKdO+djdCp8ntPV74X2ZZ21ZM
   aI7ncrxJtCybtN7zZoEviYUxmqa0GczgzriT5SCI23lcmV3K/GO5TTQli
   8+MPc7zpeAvcyXTjzCRXgFtHkwqU2p/FQCDmgJSzQof+t6WiA2yFplzSQ
   wCnoEhVjld/SgsPu34bjDx5PoV1nzPd8he4keWKKKmmVi66TTz8RNHOdR
   A==;
X-IronPort-AV: E=Sophos;i="5.85,274,1624291200"; 
   d="scan'208";a="184151927"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2021 19:40:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGFykb+lYiMsw0tNU8MWmP1KPqtb2jORhyGrV1/HrWHFdqSJh8HisMRwiOdrtLV4JOTqgYWZ/V5+Bm2DCiAzDrOvY90LglIKpEqIfCsAOAt9koac0Q7fYJSGBN1Erc0L8Qr33VlXT9FAJ3v394UVSwGBc99cEW7MjEAiLcMGw1/hhmrUESloxzBztjTeBiffD0k58fDNk6hk+z4VJ5ct1A6N6qNGaSjdSZENLkel4yiavGumtNgXSsMuqKJ1AJ5GWP0X+yypSGLM+O89H5NOsQeK6WsxRedOnZRwVYYgsPkNcF/dzhQAQu1W3bcyPThU8uybxjNF2bi/cBz1ogutuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=jyIBDL5blyo0/FFsCdDkuTMsREBoOaNfTwOmr4RdfHc=;
 b=Pfdixd3Ou073MEog2gybaudJFX7VbDjVUDeNFdy2tkvtf2BLE6oC5VabgHfO4FRUWB3Pzi8prXdL4fAqNsQOOw8GuZI1Dv4vMrhG0law3zoki5JGX3mWPWdWcPBr6rzCv/pBfZCKd1LH0gvFSBxE+m8FU8loZuIdfHnolnwI5WAasDDPS4h0xgPPiq3cTgm2NnjoWoxWfDK/Qp1xxaLPHPiTEkGz7eYa2VS41P/MmMjZrD8nGmdd0fUOuMj/ZJav0A7UkAQMoquIinuaDfg7yFEs3K3Z8gmTM2V/bBHKz7u8rYciBRIZJXVncorcTG7ybTsOyAG4RUv8jkH1W+Qy4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyIBDL5blyo0/FFsCdDkuTMsREBoOaNfTwOmr4RdfHc=;
 b=rQw9y7GnZRyzN85jMJBVdkB8PSLpi1acRw+2OXxNlJyNX2EknlvSV7ns6P4W/EdBJqeLsl3oMz4kgv7itadSbhpu3jlCJTptigZlEOBWTUVxod0uKIAaZILZeugG8/2S1K0o/h+pjymB+Pj4c5/VMy9uMC9efF0gQpDmbivnrpA=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB8248.namprd04.prod.outlook.com (2603:10b6:a03:3fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Tue, 7 Sep
 2021 11:40:47 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::19a7:91bd:cb0c:e555]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::19a7:91bd:cb0c:e555%8]) with mapi id 15.20.4500.014; Tue, 7 Sep 2021
 11:40:47 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 4/6] btrfs: check for relocation inodes on zoned btrfs in
 should_nocow
Thread-Topic: [PATCH 4/6] btrfs: check for relocation inodes on zoned btrfs in
 should_nocow
Thread-Index: AQHXoNJOAQOr3SNPZEyru9Jna/mNTquYeMAA
Date:   Tue, 7 Sep 2021 11:40:46 +0000
Message-ID: <20210907114046.z4mj3wtpw6r2e3xe@naota-xeon>
References: <cover.1630679569.git.johannes.thumshirn@wdc.com>
 <4ab859fbb26ec582130b8064621cac9de1100baf.1630679569.git.johannes.thumshirn@wdc.com>
In-Reply-To: <4ab859fbb26ec582130b8064621cac9de1100baf.1630679569.git.johannes.thumshirn@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8135d67-72b1-4528-bb0e-08d971f4558c
x-ms-traffictypediagnostic: SJ0PR04MB8248:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB8248E379463BFAE8CB501CDE8CD39@SJ0PR04MB8248.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9PYnFHAn+elAVIYnpxOus1cmMs4xhdQebFXApGkRJBlT684UZBUZSwVCVkE4SkNnLJUQn+uwjpYv9/jAs6LrjsYI6oqwSI9CuH9ks517BdA68rLxHFPSxbIOtrE6jhTyNeo1eoam6U6MhBXdahN2ZCqBoTJ5r3WV4wZRCAFTGMA+VoZD8RxhFnkjrJWcTZ8rn7sy9LqANohtw83ClRNlCctEhwYILlfJrhkYFDrRr0AaR1vpYOCmC/SPiohjtFfZHIqO+iJ41C+bc1dMwljiFUUPaWa9O5hJ5qDgO8b3q7bbSvklw+HAM+NGFIxrWkeAb5alY7dk8m6pghoYnl/2u8bBi0VucltWfC6MHqiC3cgeok4kI4MAPVDQ3qycu/JuJZQTebaVV1hT9lrNlT10oqTSyvjMePBVQ7fFHL65i4fxXQcn9T9lnh7JId1chyUsho2LeBMtR29W1h3Nmf+bipUwmbo6xYQMfYpM+EqQjUaJSCW2CsnlCKYT8py2PL/kmN9c7sm5BxFwe3Gy70Wiv4qJw8aEoUUIFwD/vVvMDFccL4Ad55c9fzu8MpK0uR7HBWmsmv2AfFp+k6+qspmjsre2N+OCEPA5ZDNBG325HD7pP0xrIC0GsYRxhA5nAO6iZf3a87/Hk1j34Y4wK8wrTh2SlqSfQz/Du0+ml4KMDcyPcA5jjtndzuuSSbzJIXKbJr3bn1jHo2cl325wrLt1gw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(346002)(396003)(366004)(136003)(376002)(39860400002)(9686003)(6512007)(122000001)(54906003)(6486002)(5660300002)(71200400001)(6506007)(26005)(8936002)(38100700002)(6636002)(66446008)(8676002)(186003)(91956017)(76116006)(2906002)(64756008)(66476007)(66556008)(66946007)(83380400001)(38070700005)(86362001)(33716001)(6862004)(4326008)(316002)(4744005)(1076003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fP5fuROqbGHakjUc+v8Rc9rKz18zqoeXWLG9Gv4GRiAC8byXolV2rT2jbUba?=
 =?us-ascii?Q?2Ke/q4N2v/s4i7XcbDh1+uictDQVtRy9CDp6xY6hiTXf2JghqQ47HVC6uMd3?=
 =?us-ascii?Q?q+XWLhVLVyPWsQns97WihL32iUuvcyLUr7ldzUbCwLbI5a5Udn62UyLMukZv?=
 =?us-ascii?Q?FylgK5smu0wiygtTVOAd1wL4ag7SSiVLtBa7zApnMJTeojm0hI+0+GXdYsCK?=
 =?us-ascii?Q?l43Bl895AGdX0MwGjffBZ0Xm/ptx7p7l+pSlBeoHL/TjfdyhPxrDm5+ZynV9?=
 =?us-ascii?Q?rOzTxrV/NpgMgjc1lmmvM9Y4r0vFYG7OaM2fvPf0VDosWMnegxJGu/pgHfRW?=
 =?us-ascii?Q?DzfkwK3hkBoBD72UYmTBvcqvXDcjLoWeiXwilltoluhQkdOZqxa/MuEifUR2?=
 =?us-ascii?Q?r2yUU6duH7sIhRXKpXtmKrCbzPRsg5S0Or1x62cfISW6Wx00Uyy+RRNnvThY?=
 =?us-ascii?Q?/tYhErr4Medm7cnmHO1HWVqm5nvRxv8JWhoNGGZyRUybG5UYMlYvRny8pSFt?=
 =?us-ascii?Q?VbyKhl8OPzloFjmEDTKwUoVnTS6DkoEjePWWqIiB0MgtrFJX4a6liYt5w+ic?=
 =?us-ascii?Q?dDxT5WCHVbbzDHWLD4Qg1CxeQ0P4FmRFqp943q58/Ng/Wo/4wBaHg5mnCM+/?=
 =?us-ascii?Q?GZNfpodU8FFCoB+RyEZ6fbqRQnINSe4zh7aGlldfSS8we0uHvw8axQknZC4N?=
 =?us-ascii?Q?bxoUfJ5cNtMrWtvqvMuW0o6Le2AXGQ9kpo2QLP7WpZxF/AmFn1cu5483XBLG?=
 =?us-ascii?Q?tlwTvswVj+YJYE9YUcZspsG595XHSNi2BBGFV6tPVHEOuLbA/1WnLR95OY8o?=
 =?us-ascii?Q?dJiP2/Mrwl5GrjCCK5nTlB9qYovxmLl+2QBIBGK7Xw+sTz2YhbWQcgaECXPZ?=
 =?us-ascii?Q?37IExCwqJeS0W6qgBOidj5qRNoXCw1OEEjB/IJQiFvcZCGcz/GF2S279CWOP?=
 =?us-ascii?Q?r/wPtt1vdM7QlMAeo6NgQ97dZwBmBe+0QwpK9CTjrvXa4/vYE/5bl13mgLf/?=
 =?us-ascii?Q?eNeKHOYDyo0WZs06x2kODtNM7aYY48u5vhSND/mDlKqP7ElYsfloCK/13eai?=
 =?us-ascii?Q?BwZhmD/xhrJ1ButsNXnNlzHWHq9Eiol1/Fw0pIEIZVeeg9sVXiJmnXkR9TMy?=
 =?us-ascii?Q?7YMuhkVwn+x1g3Yy+myFseUrNdLYRlMFML9kssArevE5LDzHhJlForauwQix?=
 =?us-ascii?Q?NYO3qQFLMGqT+7aEnHzDqcA3cwPLq8GXAjTESCbulybeXA3vNJljK8smAOQu?=
 =?us-ascii?Q?0Wcm036Y8z6fZoGgq5TmVqfmwtKcAGvNJg56O9SAOd8qJXu36zsTfnBFbn4s?=
 =?us-ascii?Q?lK0kZl1AMAVuqwde0l+4V3fFPzcwEHwjG48OMvqFlX+u7g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0D019E7633EDC042817F2621585106D2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8135d67-72b1-4528-bb0e-08d971f4558c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 11:40:46.9447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TCHsFB9CmDrL2ktPOuzLNkczd1tZjhcFJ3PBG22d76DBgejo+j4CvvFiF+iUeCSYUFide1PaQmvPy2lVnq6Enw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8248
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 03, 2021 at 11:44:45PM +0900, Johannes Thumshirn wrote:
> Prepare for allowing preallocation for relocation inodes.
>=20
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/inode.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 8e1a46e9c63e..5f4c8e12ebcc 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1944,7 +1944,8 @@ int btrfs_run_delalloc_range(struct btrfs_inode *in=
ode, struct page *locked_page
>  	const bool zoned =3D btrfs_is_zoned(inode->root->fs_info);
> =20
>  	if (should_nocow(inode, start, end)) {
> -		ASSERT(!zoned);
> +		ASSERT(!zoned ||
> +		       (zoned && btrfs_is_data_reloc_root(inode->root)));

I want to have a comment why we can allow nocow for this special case.

With that added

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>

>  		ret =3D run_delalloc_nocow(inode, locked_page, start, end,
>  					 page_started, nr_written);
>  	} else if (!inode_can_compress(inode) ||
> --=20
> 2.32.0
> =
