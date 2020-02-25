Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25FC916B6F1
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2020 01:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgBYA4a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 19:56:30 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:51163 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbgBYA43 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 19:56:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582592191; x=1614128191;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=tkX367Pbkt7K4wmQIv6MI2wXNe3EA2YxtyYxcg8gk3s=;
  b=J1RnjHUSvYlN8IHXlVAbqbfOh07x6wj+okIoCLraGwdPNrGA3oy9ngDt
   d+5F6JZxQEYSuqkKHs8YhfU8Hn9YRYpUe6lb6BpZkLEBVGB/eHdGwD5kU
   SRkfmmB/MgNg7MBr/nPdIYASBzEqRVpvzDC53LP3B/Rt0feY1I5PJ5lfu
   FOs5sW071ms9I4LZMS6eqT5hGAplvgzJ0qxbdD4UvnLnDD9cBMgaCH5A/
   FI9O3PuCpI/26EAs1ze8Jd3DJIiA/KSbSRQcoDlQSERwdWNjrqrGfMJyp
   027+4pwPSH9zQGZbBf1ml8ejPBizU4CQ6Y4KqB3i4YO141qQ2L4K99EBs
   Q==;
IronPort-SDR: Mxd6+zt/pcLjU0Ych62MajSSPlhLjse0xzxnCmht8CgZSivg/xiCVuNXkenYLl8JnOW0lOxd1z
 4N43A8UDhN25jjoLr7/oFhTWQ6Dg3EDGMA3qGDm3cw2mINztrHbQ7N1IaQyrXSkgBayixxAR1U
 Ot8mAh4fG3WiQcmYGAuj1yHu2MfFRicuvf+6hFxR7eOtUHm1N3x8GHLPGq/RbbIXRTiajC0gG/
 tNAKLRd7yvmSbYHAk9dxguTcY6FGw/BQ2X6xaHEsqk/8Hq/c+Mt7i/ZL+EYAFJ56Sstv83QlDh
 +0g=
X-IronPort-AV: E=Sophos;i="5.70,482,1574092800"; 
   d="scan'208";a="232531495"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2020 08:56:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHahC9U2O/8le8wUFPMzK85yWcIn841p7IoY3ngWEEezdUoaBPgJD3HVikqlgQutKcDqY0xs85t+s8M8ucJyWJ0vgl0wZdzSgNqw6ynhus1dYWJpijIWyw+SwUN1gC89r9pClRlrcbOWbbSkFTJH7iuOXeb1uhU+I1zNZ12KlPo6rGsTRzAnqfhH00K0CCGDQf6ishuCeNQT9j3BjtTTa9TTZXeIhy6U8QHbWmRwx0QP8Odd46VYmSGXBVIkRIDuzIp2BCWTYk5DffIsI+HTGrbYyJXsfOHsUVbOPrvLcKLx8jKG61GHtAkh0+dLHle+vh8T8k/dpHVMsREQjzAdKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwp3WGM9MXdqrWUrhaRAmILU+jbj6J09hEKYhR3gyEI=;
 b=KYrWWAAuUduXqR7LxauiyNk6Dy3HH2c3gwg3NpQ7hF+yTzgq4q92dBxFBTp6lDidu5UDMVmYr67ysHB1LOvhRdYpzmjOmSIQ7fLptZ+rGEri1YchNMvM07OCZAGdsB4SW65ns6ZnG0eFjeCNaztALmbPrTjs+UitqJtfogm0RHC15PZ5gLrDIRrmnwri0tzHiQOXviUrtqS6pSs91mKaohEODvx5pzhFYSU8y69mQeVHkkLCsUa1VDzmqLh2YFBv6OZE4207/0UOby8A0IhfWCu/zmM6YfhNv5atrh7RNfaA5QaNzzfDoWn+qATARbtrqlfqP3SZicN3NTi5XxRTzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwp3WGM9MXdqrWUrhaRAmILU+jbj6J09hEKYhR3gyEI=;
 b=cjprZv2GASf7+gCvTgiGr9BUTAiFVdKYH4g6ur/Zz3O0qI8k899yWmc2MX0ZF/4nkjWJJZ16JQzAKSLLwoZ64/3wbL5rAgco9hCoIA2nouN8+72Yu7INNG7GUhiiTHKxrJ8oTW2MQlhdDw/Zvjqf4Lb3oLOwpnBFEH8ypCDK/SM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3535.namprd04.prod.outlook.com
 (2603:10b6:803:4e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Tue, 25 Feb
 2020 00:56:27 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 00:56:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] Fix memory leak on failed cache-writes
Thread-Topic: [PATCH v2 0/5] Fix memory leak on failed cache-writes
Thread-Index: AQHV4oZpxF/89/7YtUyR/3LulYl7tQ==
Date:   Tue, 25 Feb 2020 00:56:27 +0000
Message-ID: <SN4PR0401MB35985B02068C1D6AD4A06B719BED0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200213155803.14799-1-johannes.thumshirn@wdc.com>
 <20200218165026.GS2902@twin.jikos.cz>
 <SN4PR0401MB3598373E76D2D63694F8DB3C9B110@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200224174934.GB2902@twin.jikos.cz>
 <SN4PR0401MB3598FFD979457FF00ACE9B819BED0@SN4PR0401MB3598.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [199.255.45.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9e76f40f-93e3-4478-24d5-08d7b98d8b4a
x-ms-traffictypediagnostic: SN4PR0401MB3535:
x-microsoft-antispam-prvs: <SN4PR0401MB353501BFE5F54DE6D6A5D5069BED0@SN4PR0401MB3535.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(199004)(189003)(81166006)(5660300002)(53546011)(71200400001)(4744005)(81156014)(316002)(4326008)(2906002)(6506007)(478600001)(66446008)(66946007)(52536014)(7696005)(6916009)(64756008)(55016002)(33656002)(26005)(66476007)(8936002)(186003)(91956017)(8676002)(9686003)(66556008)(86362001)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3535;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dtNDSGv0/umkqR2xRsNN2/sx22SuRRT6nWSrDp1S0r/UczszrJ+p6Bju72tRVLDegFQaHTYJZD6/ucsHVTCdCwy3HLW71Qqry9KXowe7yiEzkY3Ccz07rw1bm1SZIsdWlx+dITFqJG5PkXWgLpX4CNRo0k7vTXn17S4K8aNzdEYWIE2NefT2SMAzzsx9vD9Uwp/JKKwUdYjRn7LNGOHur3r0C4oR8WOzqxzYiGRmMmxTWtTS20DQ10aJ1B4d2pFJmsY3UbtZZYZOsQl174Mie8KmKm5NEMpwteINg3JwvBEyu7fe7WI38f+Q5wtBhldFEvdOTZGfS3gXwEBJB5oo3ApM3FggkQd8Rj277Nor62B4BLDzIwJ4mmNJY1IwlGHQTFSfdN6WAX8OpAJGBTerhdksFHcGqJvrbb6qYtScZ6SmKPJSdGoiOgGeB0MWb28H
x-ms-exchange-antispam-messagedata: T+IjyZOvl4Q65eoI0x5ueQBjeucyjYNLoigonMS/YTBJ118Wv6ogsm8XW5fhagakjWi9r3D9BnGPTtMK8O/Tf7GAUhSEDYwOqeulbUk660rQSeIbd4WHyy3FDxrx/OZo2WCg+TsBZo2+Zkf5KovJ3Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e76f40f-93e3-4478-24d5-08d7b98d8b4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 00:56:27.3954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iw2CyOU3duiujGCZrtiJ81eqO1LoisU9WBAredEsOrsdz5tyF8rGxkZjM9BFRHruutFf7WdEXf3Frd34NDKxAKLnq1vdZmfD5Rk0HO7Qx5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3535
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24/02/2020 16:23, Johannes Thumshirn wrote:=0A=
[...]=0A=
> OK it need some time (up to approx 150 runs of btrfs/125) to resproduce=
=0A=
> this failure but I can re-create it.=0A=
> =0A=
> I've seen it once without the patchset applied as well though (a.k.a=0A=
> HEAD =3D=3D 480be04e7fdcddfed86fd59bb668a134b6d7393e).=0A=
> =0A=
> I have to verify that though not that I'm seeing ghosts.=0A=
> =0A=
=0A=
OK, so I've hit it again with the above commit as HEAD, so I don't think =
=0A=
these patches participate in the error.=0A=
=0A=
I'll try to figure out which patch does though.=0A=
=0A=
Byte,=0A=
	Johannes=0A=
