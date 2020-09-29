Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C23127BD38
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Sep 2020 08:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgI2GgK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 02:36:10 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:56336 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgI2GgK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 02:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601361370; x=1632897370;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=lZ5hkYpIwK6AFAYzHEsTrmxjyUqP7y2CHCvUQdSjqX8=;
  b=LNQ3hc+ay+eqiLVqoR/Aynjrh6aRr+IX4ScD7MuOocPVf6i396Fsa0nS
   4KMWyXD5JSY59ERyT3mkZ+gOYvqAkzJdGw9Lp4EPlXqnzVFRXng4yWabH
   347PWj1MOKBy/yOCOx+pzCd81ZsGHcx1fDj8U8ZOPUSt/jqQoJid4SzQr
   JfHC16u//8C0mbolSf6ESALBYugL666i9hP5DkqXr39DvrIcXha/kWLNl
   chZqb0FPXtCz+QfGfnyJzWA5xUyfKG/rFM6IBXMG+0qxwb9r2XO7EZ31y
   wLeiL2jvVx88fGTAH5vCE8NpfS6bfqcPQfE6AaWW6f6z4YVxEjgQBfz1u
   w==;
IronPort-SDR: 4Rw1V8Ovi2ce1FhtpsvAcSZUooGh2/wxv+ORBCVmRGezAdcSlrSSGpdx41rgvgtnfU92z0UlVO
 nf9y5E20Hp5eOngfBVPSspXxB4OfwrV5TcOWTfH6CLrx0kvLPRF4amKM9hEKve9/EeYI4iWefs
 N2Fmp1qIRoOiXBaQW0+PQOOhV7ki6y+f2aojOOEnNIMRqoUb57nIJtDd/JZa0wha3eFpRDjG4V
 qum+5O/RAMLFtUseHEzbWch/z78E/RfNevFYRjq9opZf4A0Y+PMbmrl57SBWRhrlDNF1EEDW/u
 lfg=
X-IronPort-AV: E=Sophos;i="5.77,317,1596470400"; 
   d="scan'208";a="148550407"
Received: from mail-sn1nam04lp2058.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.58])
  by ob1.hgst.iphmx.com with ESMTP; 29 Sep 2020 14:36:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Li5fVUXsGJ375m9w3N1xD7PnBYSLruJTQuJ19zl7776acKAI6UTN0HYOdyxK8GvSmAFfsvWob8MC1r0TE1Sz/HNuV+D0qTRqarDMod+EsAy0kMLXHj9L99v06skNtddPGTCb60Ru37v75YAPrFcOhpj6r07GlwomkP0MWN6cl8AfvGS595SuSAQZdyYXREk70uBgnXQ5tKLCpu5B3k7Cdk4xYJzMClxHVvfphDWtF1QVnHpS4NSBCCWuMAdNh9Qr5KwcCgiKD9963yQ2tHJi4vdF74oGjAOqFVQm9paJZzuv2dklZuSJLhiDo9bvGUA2X88faRT4fGB5TwdLOPxmuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQKMwlKNYsKu0J108sel9qdCqL+QH7YKD3XFEGUy4eQ=;
 b=ZpnExYCAXyjTKXG9FgXoVQWm4y7t87u/vn8b4wUQWXxBv+Xgzy1DPbFjZGUVZgUsEhbEkolNYTKCpdRte9AU9HkU9qkT2Z8VW93fHyXKs4V3S8M0wH6rFBRvZeG8bQkICUTdU2T5eS9I//BnNHxaD3jTRrN0owJXOgjsagTh6qUWseHoPbkE0n+DKIl1SkMc757DNxGldwpYdJQ1WWOGsjBG+BDKeEbp67SMu5+vMgHeDpXCIMKPRtYJ5OtjBZI7YNFNLtj+djMQTihqNbNqOglQLq0yTzOUj5z2Mcy8JDxBZUQV9ox/rfNrLHT7s4H8FttJIgpb2poDHbB9sKzGEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQKMwlKNYsKu0J108sel9qdCqL+QH7YKD3XFEGUy4eQ=;
 b=bPKwf6dVhj+dusVUqlIIpas1RTcIJ+Ctpm5J//xHOwQipSAXBGiabbtPT4UP600F/NEBz+9c3BaXCWbgLXlIN1xYMt96VHDiUmSSOImoOL8y4n4CNsWt1EY9T3fgWx5Jtj0JNIwAhgPf6LJ4Ak14laGYjw9uEasOVPNOyqk4rfQ=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4463.namprd04.prod.outlook.com
 (2603:10b6:805:a5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Tue, 29 Sep
 2020 06:36:08 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 06:36:08 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 1/5] btrfs: unify the ro checking for mount options
Thread-Topic: [PATCH 1/5] btrfs: unify the ro checking for mount options
Thread-Index: AQHWkogD6DR4VnBkkUCrp0wy4BDLBA==
Date:   Tue, 29 Sep 2020 06:36:08 +0000
Message-ID: <SN4PR0401MB3598DAB60C2357B1023A0E0C9B320@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1600961206.git.josef@toxicpanda.com>
 <d307f1d95415232dabfb700e79cda73618aa7d50.1600961206.git.josef@toxicpanda.com>
 <DM5PR0401MB3591BBA587DD3D36F47FAA549B350@DM5PR0401MB3591.namprd04.prod.outlook.com>
 <be964e53-0adb-a829-8057-fe5c9115fe70@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:3d01:18a9:9f8d:df16:87f1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 786a0621-9ff3-44e9-2852-08d86441f2f0
x-ms-traffictypediagnostic: SN6PR04MB4463:
x-microsoft-antispam-prvs: <SN6PR04MB44631B6959D4C61DFD98E8CB9B320@SN6PR04MB4463.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zZKpJXbwsdwj1uP3rf1w+JtVzzqDFfSIWXMAoe18ndSeO+zYqjl9msoaZ9H/zAAAUShxsuqXBfOfHNBadhyJqfZ+uwigyBfg56MkE9kxlNJchghadWN8Ixr31bvFtQyocIBwCtU8uebYHZSriJmLqmovhequcwSqdoICNwB/wi9xDTuIsQpR1lRoKNyoZY0jqdwYu6ePCEHA4n8XS8mOxmgJ+VYZwA9u8DNVhM/KaUlVIxGc1LsvF8yxHL6fr2NCljgOAV/PbnE+WyXAIvwMVZExOBSHlSxEdQwQWmAGjZkpQaZQ0wXa+tGWs9N8lF9ktUhRWaXEHVvRwdwDYQ3Yaj9GdR1uGujXHNUELRKr50ydPxNBBozD3IMLxYrkGVzS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(5660300002)(52536014)(7696005)(8676002)(91956017)(76116006)(66946007)(478600001)(55016002)(64756008)(66446008)(86362001)(66556008)(9686003)(4744005)(66476007)(110136005)(316002)(2906002)(71200400001)(186003)(6506007)(8936002)(53546011)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: HiExjKOLw+UmGghDx7VATyOBZ/iR3g7wD43TgK3bO5N4dOEunMyntL6sDJxgi/lbiircdr3VZ5tW1x14Cc6B9GajhLKlYReJj4nv/mWXRVORyqpiW7B3ThlyPtL1FBRovVsrYQOYl1JLkjONsrrdS8oqCn/uRf1xPrjzN97J3CYOOSZTxXw4zXRJf3aNRd/CNlNhO2scPvfI3LPJWuxL4x6tgxIvvERRk6RHtQyc6Ay4VV4JjD5MENaxh2STTwyBuFO7q+3u3JXGXq/u1105HNfCADpl5L2wNQkd96st+e5iOC5wLX9X9G7rr0Re+i/7z2ovOYCxgeEhQDhX8vvdxezLv7Cf3i99j9tYU0vA/aYnBsDbaYwCkq+2nFVNzx3T/o3gDefDW3bFfEiRQr9YVDdgdIzFfc/WScLiPSj4U3D4s2DV3nf5/jv3hY9Q42ywInLeTf28wYTDPoF2n/2WwkSzta0pe1dzoJTUP7xbi6yfjLPWQWUD84kB6eDmYLxyiZmie54OORhcgrW8dkkrLZAdrv3Fh22ydjJ/UYhgoHW3ZR0shexc/yf5m9sx3MJPaRyjnhZ+NEg6s0rPbW29umv1fviUtySHoavKm26uKQ6Xmc/h5M45tNPla9AvCIDzlVECwrZvNzlVuYVUF3fhDDQjJfb857q4XQEIz8lRTQXZdGL53JpuCc3EeDASNf/GA+X3BcBQEDXFwkkaaf18/g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 786a0621-9ff3-44e9-2852-08d86441f2f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 06:36:08.3352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6qDZCArFSWBAKzpzgf/gl2NX4myU9OQXSSChCaWjjGGaYgA09qLfXivNWlcJzvA7+cE1lpNA0pZEUiO1uglV+HgVxDLUVkKYf5781es8V4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4463
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/09/2020 20:23, Josef Bacik wrote:=0A=
> To avoid the multiple calls if we're not read only, otherwise it'll be mu=
ltiple =0A=
> function calls to check that that SB_RDONLY is set.  The compiler will pr=
obably =0A=
> optimize that away, but I just went with this instead.  I'm good either w=
ay if =0A=
> people have strong opinions one way or the other.=0A=
=0A=
The name check_ro_option() really suggests it checking for a read-only opti=
on and=0A=
having multiple calls if RO isn't set really won't be a problem IMHO as we'=
re not=0A=
really in the fast-path here, but I don't have a strong opinion on it eithe=
r.=0A=
