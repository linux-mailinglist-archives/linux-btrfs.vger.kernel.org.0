Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286521B70D7
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Apr 2020 11:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgDXJa0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Apr 2020 05:30:26 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:8358 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgDXJa0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Apr 2020 05:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587720625; x=1619256625;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=eWi+DQO3/i1Kth2ougsIi2nyCFOvBuWtUSiVRHYvswQ=;
  b=EeIX38VTITO4YGUpx9LivR0NWhFd0YCJSrEBc+uVMFmRPqizJe++qrz6
   lEevH3TMnynhhLvLOES+8/3+IzJeyVrTbme+khS7k62nFsONCvWdAJJ8e
   HUjloK3aHjGDzxImi9VhUIMbo4josGiTbEtKj8kSH7wonvf0xj/cdpJzZ
   inWzod02NkFr9lRVn0pWnOpHVuaeb+1OMFhjK0X7qUja5JumxvamYFpCr
   s31BY03f/QkxM1xcI4LbzvTZhJ+jz/tvu33vHoLLD8DqboyD+0+wEeTJC
   yctc06//pt15RzvOYSdpQg37yTc/kMK0Tb2dwSRa8zsV4TDo8RKyqiVq4
   A==;
IronPort-SDR: MWLFqcwmReyBk1srH/KS4dzi040CV2oWOKszjkjwe+KISmt5ip7FX/LIiEK4Hop1yHgFoj9CyU
 mfATN3zNlj5nHeXgR6SC7mUKWRC5W7px7m2IFpyxnwnzYkKWczBwCXeygyGudB1rSX6/Ffqakn
 Q8pGbqgj6kKJUtedav9MGf7qOD+OocUHSTaqtnbgriXXjAObmRZsWvZjVxLNYjrv6m5YaQDmhW
 tLZ0iQBIZ8ZXoeRA1h/N/lWo+bp+tBS2yaJ/iYygLLLZAzO+P20qlKAuEcVnEm5V3b3WhFN1fW
 JeI=
X-IronPort-AV: E=Sophos;i="5.73,311,1583164800"; 
   d="scan'208";a="137491909"
Received: from mail-bl2nam02lp2051.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.51])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2020 17:30:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZYOOcpvTg3VHIuiHy80WKEmGMzBVgW3ubMth9O4C3pasOf7tkT4c6GC3fvx2dgaIkqNhrqRzDVdWEneDu3iEIJa8NoJD+7JSDSHF9A3MKpcGUfZdQ06M4C/e6qBO97SpoiDm5VwJPtaw+ZiZIsgHOem4b5UGbSEbWpm99WOey741ZkdRYz0JMtyXfuLMt37dz8mCPcnnOTcUd/XACy2Xob7A2SFNqg6LQ0eu0Z8KeVb3wWkdCJotujVuj2C6wcDu90tGV9NSzEqRkuPkd7tNJtUTXCg5SMoHK+5XotSVg2SOrjEABxVmVzjsN+1wsOQNtnH3vxKeOhK2w5IQB4FJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrC0SyWN+6i6aEOJpAs2Dl1QNL/VXTuoQ40v/smqc78=;
 b=DKAJQ4KYUu8svuU1qjy+Zj+pnttGFfE5pOZsvfGv95OnHuMJHSYPWvgUsGEcAlQVlXVWggsRB20srCvLK2ayOOm37yaDWjPAPk36ZSZbYJId+32A89I+5CjXp2FcR3KmhLJFRVR6elQMQm5h8CGPMjsFyX59mD+cpCN221xn9sakdS1T7FPqGrJBdO5BOCZX7m0/pXKSICzdy3ZXKDd8rATEibTe+0UnkfTiDFt/S3nFhPYPEuxyz52+4pulL+DavFzGrwFFK0IQfZDrXCU9P9u800zypxUYxQLdVs7g8v/8Wa7VbOXcl3Q8RGp9HmKHU42CVtTdHU5UiVRiTvFlZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrC0SyWN+6i6aEOJpAs2Dl1QNL/VXTuoQ40v/smqc78=;
 b=kM8OJZOXYtI/Fe0tIvs2xSPQt+nsRbHScGn2a5y+n+kRP6jxZpx6bdx6liQf0LD6f7SvaqcOMwjT0cDv7ovN+TwkR5xqfM9vJYMmAWCAHL5OUowyj0IOrjvzjLRYPlhpBlV5bM8oRVYsEUw/IAJV0CMgq/hXqvi9hFHkaYxww08=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3582.namprd04.prod.outlook.com
 (2603:10b6:803:4c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.30; Fri, 24 Apr
 2020 09:30:23 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2921.036; Fri, 24 Apr 2020
 09:30:22 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
CC:     "jth@kernel.org" <jth@kernel.org>
Subject: Re: authenticated file systems using HMAC(SHA256)
Thread-Topic: authenticated file systems using HMAC(SHA256)
Thread-Index: AQHWDQbERVNaVh/cw0i4WbDgZROyhA==
Date:   Fri, 24 Apr 2020 09:30:22 +0000
Message-ID: <SN4PR0401MB359826F559608829968D667F9BD00@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <CAJCQCtSLOgj7MHKNeGOHu1DPa=xC=sR7cZzR88hN1y_mTYRFKw@mail.gmail.com>
 <SN4PR0401MB35987317CD0E2B97CD5A499E9BC00@SN4PR0401MB3598.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [46.244.206.168]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8c0d0835-861c-402a-d9a2-08d7e8321cf9
x-ms-traffictypediagnostic: SN4PR0401MB3582:
x-microsoft-antispam-prvs: <SN4PR0401MB35826B164587AB1804A721DF9BD00@SN4PR0401MB3582.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(71200400001)(5660300002)(26005)(53546011)(4326008)(2906002)(186003)(86362001)(478600001)(110136005)(6506007)(316002)(52536014)(33656002)(9686003)(55016002)(64756008)(8676002)(76116006)(66476007)(81156014)(66946007)(66556008)(91956017)(8936002)(66446008)(4744005)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6KS0jzomp1dO7SKvFFHnBuIc3hoQcwndIoX7YbGW/HFg/JaBABzB0YV9NA04Av6pGvUZynWufl2+DTq0KzW6zJa2rz+kyw1+zjARufUGEgIc6oTNDbImSSLvXpwpOjy0OsICxnT1xGZjmhU9VrARXR3AXzJ9SBJaR9mluARez8C2pL0Xp1ST9nrK7XoF/IDz9vOULpdEK6+ws5en1UVADDpudea5WA47HmZbd3OQir94LESwMUZkDvfia2pozdvFLYdgXPpr5qqTNWVIrHAphqwksoibedkRXvh7Vpt5L4gDJbarYAcQI/XLo01BCWGuerTSx+TO3BER96HCsY0vvNnvTz+a69iz+yyx0fIgED1uLvmgJ3izd1VlQSpZ+5Z1T7GD+Eszf4VYOOO8BBdMC+szjIceX7Bmbw2WzNq2syfBIWbLPuQh4gvnYSrsKS5m
x-ms-exchange-antispam-messagedata: 8IsBalD1rxGSDFD6uGnK+8z3naXqJlo2tNuSnS9PdCTtM6jjnQEYZUW/LHtLeC5ndkdnuynoUsRj7CT+mHO6A0q2pYpDftvYrgLVdEx/g2y37yEdgg3Cm5ntE62h2GbZwZZOFyButYUJUErZy7CAng==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0d0835-861c-402a-d9a2-08d7e8321cf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 09:30:22.6762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FutnfUW1QOXEccjlqd3YdnfI+UMubEliLdhi6eS3Hiu0n/VUeSqgSCOaE0IDwoKJRaGQouLVjy3G4tFLwsPCvpEkGXHAmLzXF9aIufXs8g0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3582
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 08/04/2020 13:17, Johannes Thumshirn wrote:=0A=
>> Also I'm curious if it could use blake2b as an option? It's a bit=0A=
>> faster I guess.=0A=
> Probably yes, I haven't researched if blake2b can be used in a HMAC=0A=
> context, but from what I can see there should be no problem. SHA-256 was=
=0A=
> chooses because SUSE Product Management needed SHA for their use-case.=0A=
> =0A=
> If there is still interest in this work I can re-base my branches [1][2]=
=0A=
> and add blake2b as well, this/should/  be trivially done.=0A=
=0A=
So I've re-based my kernel and btrfs-progs branches and saw that David =0A=
added support for libgcrypt and libsodium as optional crypto =0A=
implementations (awesome btw, thanks David!).=0A=
=0A=
I've provided a libsodium based hmac(sha256) version in progs as well =0A=
now. But a hmac(blake2b) is neither implemented in libgcrypt nor in =0A=
libsodium and I think we don't want to roll our own crypto in btrfs-progs.=
=0A=
