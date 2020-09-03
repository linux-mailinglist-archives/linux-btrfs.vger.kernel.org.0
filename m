Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429FC25BBC8
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 09:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgICHee (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 03:34:34 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:61317 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgICHed (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Sep 2020 03:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599118472; x=1630654472;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=VLG076wXrq/rSHg1EZa0227A8AfE9BEFQEYPXZ0+Y6o=;
  b=E6nKIpHa5YRRvWK/CUFwaZXbpS3H3BV0tkWnDQ0NDZ5vkkJK66ihqcBn
   +jjWygrQJG/BVL6nULbGV/T6l1Gx32aucdNqamOVRoQH/l1/EBp88Erm7
   ZQidE88bbLFxozvgIPllV3ypjbaeeWxEZhJWkG2OUpNrrs+yTMN6Wd7D4
   KLE4z40Ezook6OrwbrfzBL+UVa/eJX8mEKmgxWFysTzRbEgKJ+GYC8/W1
   PecOM3XQT0QdcydpkwNrJnPZNBMTp6N6EzNUyWClkQxIPdzPX8N4FDCCF
   8RJYvYBZcRECACxxMj5c7ZFvh6cuCubuBwVDIoRUXY0VlovOArZYqRIf7
   Q==;
IronPort-SDR: ldgFf37RI3Pzf60Idbtb8CMJ0j6FsboSgfw/hK8rVTdJRYyhbZPQW/AXjTfxw5mFGa/w8De6BW
 9bu8QSqqLi65k+9P9/hDnTR9mtaLtPmJvTzVqnzyzb+KDEVzklMt27N6utBYASBzic7YbH6xUr
 FpwofwyyG+4ixp1hPvran0oholVLJ+KyHVJiXljNErKy4QptkLMjona8gedKVAAZi0g8yFl1xO
 kCWAKkeiMw6Eil+9NS72Xuf16llEZhk97HJj+/LH5t6nnk019csMKvEOhV5cqQV1G//rvefaZJ
 mJo=
X-IronPort-AV: E=Sophos;i="5.76,385,1592841600"; 
   d="scan'208";a="256021245"
Received: from mail-cys01nam02lp2059.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.59])
  by ob1.hgst.iphmx.com with ESMTP; 03 Sep 2020 15:34:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dA07RpE7rr3jJsFechDoAmrqAUi6Wu1NqrVvSG7dfdFIpegqXF2FLmTa3fx68v+9szTu7JCl89RKIpbukXMMSvuZKAtCGxgLf7a18bbKhhezoa8texINBRonNpoxafzFOjv6I2OO63FSQiJwndfK/4DqbJCrngnl1cxExVR4WZbsmzCo05/CT/ufTEs9gPFw78zjWlV0rYSyFCEjVkBp5JbwwBIf4GVIwHB8n+7QZaUkjMhjqvmoupe7SNF0I2Qr+ddOe4TuXgXHupKaLS865lQsK/VSXulKxUNcjQJPXpxlS3vSdKzOXb9idqonCmYiXz12n7DVs7q01z3gl1XlHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLG076wXrq/rSHg1EZa0227A8AfE9BEFQEYPXZ0+Y6o=;
 b=Z+vTKg4Kxp7fznj2ejniY4NXO9El/jG+MNJeTMYSpYnVouPM39eCOwU9ImljC7DUmo8L4P0oHEl0bsoTVp6cTtBzu3mAlK+/vsclR5vAFYpO8llIG1LUo177jjIehKX4QRZMsYBBtGsRNHjBppJXcE5ubw16fxI9Vx0HTw4gXRFeTK23J+vO4ZAFe3vBLfPtp2KpvCECnCLkmdzXWYmnIvuI/qgPtKe44aFfrj3FIDA8XtXaIXcEjIcUKu7+Lz1Y4D7lau8eB+2N8SM+kHNdbEQIp4fyIIKHWv+ywUIh6FCyCiGCS/RJr8GcKzS/kniG6765z4S/Cs6ga4gniTczzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLG076wXrq/rSHg1EZa0227A8AfE9BEFQEYPXZ0+Y6o=;
 b=g8jXKT3R2Oh/AOtSHmdlsDI8MSpfeepEawX7kvH/9FWq7lEzm+UlwR0F1hrBOjTTKVqfUEIGzx58hONzeCnEAdLmw8yObhUSCKyeSSKLwjLAs3vh2pGsLfX0F+dGiHnV8TMeIpuoYLTvEHCX6D3CGXJPJmOMOBxljUG86NaGygI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4864.namprd04.prod.outlook.com
 (2603:10b6:805:9b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 07:34:29 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Thu, 3 Sep 2020
 07:34:29 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
CC:     David Sterba <dsterba@suse.com>, Robbie Ko <robbieko@synology.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Subject: Re: About the state of Btrfs RAID 5/6
Thread-Topic: About the state of Btrfs RAID 5/6
Thread-Index: AQHWgTtjvPzclkBTJkCq2FYp15mtdg==
Date:   Thu, 3 Sep 2020 07:34:28 +0000
Message-ID: <SN4PR0401MB3598C82C1186CA04215145489B2C0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <CAEg-Je8OsZjWU_ZyLJHrbOJb=_C56MOmJ5w8UUbzz3JNuAi5Ow@mail.gmail.com>
 <b9ceb790-e376-69b8-0648-56c9a026b40c@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:1584:4722:fd5f:b30e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ccba7fa1-98a4-4fc0-821f-08d84fdbcac4
x-ms-traffictypediagnostic: SN6PR04MB4864:
x-microsoft-antispam-prvs: <SN6PR04MB4864A83A839F6EA5B4C1AFE99B2C0@SN6PR04MB4864.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zTXvM3jQuQhOb4yPz0YdZ6ERhGWJL9ZR9d/q64Ht+hZLhZLS5B4JJYI632wYs8a/GHs1OEjyPZoAZrekQmQtOcC2yltpsQ8lwiUR3XLDJZBHIbPKTNwZfrT9hHdPkum2eeD0wML78LDZkbm95di2HX3t8W507NEUz8KVpQFd+HlkgJYoNX1VziTMukBVQpFzKgyk4Ad0KV+KVh8MbDAvxZH1T9VSk9Tz7ubRV0EhcAkU1F8LTTujf4ew0mx+2vxG/Dza5F64oe9aT8/rkX8e3aOZWgcVOWPxoytZFSehfnV/pDjKxkfjUXzrcJYOYFKKoUZP8sr8yQM3NOUf9X4dgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(64756008)(86362001)(4326008)(478600001)(55016002)(558084003)(2906002)(110136005)(71200400001)(33656002)(5660300002)(54906003)(8676002)(66946007)(66446008)(91956017)(186003)(76116006)(53546011)(8936002)(66476007)(7696005)(9686003)(66556008)(52536014)(6506007)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 8qww8tMTErDGHU1Iui+aOvnd8f4mi/fTEtLflHd9UvCI74QVFrzAltI9Gkx28MXzHcpgeyFxNOckx/5/GVpMFWY86iuWbXRrEulVaFhg40+awak/8h5eLJjOALVyMFZbRELBMO3gBJhdOKrXS6U2hL1spUmjcaAUD4+2uPTCF23IbHjOPJBF5kmsX1847HMzOpjb8FBazexYBh/LmxJhbYQQa1BL80o099xZkvl0wEic7DFfP2UG9Jrb9kCyboJaxfgJ40b2FtgvH3wzipAHzD+0/7zFvi32nTicKMQQ+LGVqC9ZATC9PH98IBObAYTeyXRvyaz7OW6C/Y7td3YGTSfJIHgnYUV2m6Jw2tLSxuNrq+j6OZ4IHOyviYtowCEPKgfl6+VbwzeXtOiBeArfKonhnk8Z3V5Iu6SQDvli3/Lg2Z4o4h605mmyXWl2De3ZGhVEIaOXhHf0XjlF6V2pZU+NADDBmApa/d5jtQlmiQW5GZgN3EsZUknmoRQFJ6n9/CfiBEg8B9cRC234CpiXDGmObzX1hGlsd0eLpVdRtnwt/b9ITG00IolNLug8E+uxISvvNhyG41MzMvLPyyABP3aSag+2aHiC6jnRTd3X/KrdznIXhfSCyt+Wo1SsGCOAwsPsosCBXNpSIG27hOdtLxry69EF9r9p90txggBwIXc4xpc9dGegYjjbWDSQ3wA8OJ02NbcO/h4UFAnJbkbJXg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccba7fa1-98a4-4fc0-821f-08d84fdbcac4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2020 07:34:29.0063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4sVXXBEB7zHm9dJYnHFUy06vKzSL0UO5T1YBHTjE+pfxJ+cuAJjDf22w4TmE8jhJuAjKxgbAHjhZphpwkISbcI1zV5aCvRRQmau0y2sbH3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4864
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02/09/2020 19:37, Josef Bacik wrote:=0A=
> I know Johannes is working on something magical, =0A=
> but IDK what it is or how far out it is.=0A=
=0A=
That something is still slide-ware. I hopefully get back =0A=
to really working on it soonish.=0A=
=0A=
So please don't expect patches within the next say 12 months.=0A=
=0A=
