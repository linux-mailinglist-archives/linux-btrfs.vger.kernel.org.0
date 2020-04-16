Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBF31AC166
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Apr 2020 14:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635689AbgDPMhc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Apr 2020 08:37:32 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:56961 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2635825AbgDPMhE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Apr 2020 08:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587040623; x=1618576623;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=9jHJiKmceC3k+R7p4wgSkJgNBmB4+a9DlWjbl92iy08=;
  b=O3w6uowNPtGvmGPetIzr0e9/qT0cFwBt+FtAngH7wIghlCArR4uTPovJ
   JnGbQDxbIb78rHT++J4yLN7eNhwkiJZ7NKt3ZjwNkXiqr68F3zBtEI9Qy
   7A2Se+FDEXDvH6mN61Ah4SOl3lHolOBtRg9A9U0nMzhq9kFqpXVl1vFod
   Hd+Z1cfEDTxYQvw/OHiyD/isBjvaaoyEB69YMO7ghXrBdPsqphbb16LWl
   gKev70W/lfpYVnAcxD8czN4j3SlEkUto/cwxEuIBnUIcD+1lCnRFYov5y
   gAN+NxyaZyZtwZEKi35f8/fSeQ7iZT81tj5YmFQXJXell6RLg9cy7oqD4
   Q==;
IronPort-SDR: sZp+Tf3vUtg8IdQWW/QzeAnKUf3aIScN87neeT2XkjRqFtGl78PmctFMpZ6OAA4gB9ENE+oSS0
 xfr+s80aDtRP9ix7QcazYPISZyL0EphOiNAgMI2321ZIGdN+3aFyaa14/rM8wGxAUf0m2cK78Y
 Uw3mVoZ9zWpzO0lpuI6dEXdEiZOvEeLokpoUFBPSJYcFkTYoi+1WPISIBKgi/MF4Uaj7wb18q8
 VfFA7Yfyz6KM7I3LixY0LYW50WJjgULsBbhF7fua58Htm+++iDoPiv+7O7lay5cn0teHYSvp2V
 MLY=
X-IronPort-AV: E=Sophos;i="5.72,390,1580745600"; 
   d="scan'208";a="135475120"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2020 20:37:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQHm7zlAjt0cdxaHsbJq9ui6Gl+0OPItgx0kGieur+mceyWtY4XrB1YOW98FwWhXfZDYGjMT3ozbqEARYB9yiwKPdmtEsrNCTZAVKaVe28W0dq6Riok+z2ec5GE5e2PpUe1PgdVHDmr+ILa+k1TyjMRI2eTkltnlnICGwtO2lE79iPa8h+F0ZHETQckmFDMewl1MnEQ8P27NWr6N+jMwseGc84WJJQ/M3nPi2HUMsuJ7Z0g/6V1g7H1xMMalmMgogIOqkuw5cCYqRc8DmLWUZaEUUw2rXm6jWjFbZolOCFZcnalX5p158+AEO1N8fwl1VX6ODaJwrSBodpI5f/t4mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jHJiKmceC3k+R7p4wgSkJgNBmB4+a9DlWjbl92iy08=;
 b=dzryC0cIXf2DO+94+TBhsgt8rL0FzycBdGQVm3/fxQXaJathP4ykF0TCYRwerd/9/gJdeY6cJ35ObopEoH0Q35NJw9KaMxJO/blNwJFHPVnycqbI1JXJnie9zFxdGfIO5OIAbejGEn9Ee9i5bDLBPilQrLkr02JNSA8sOKKRINQCHp386beUek8eNUyOfTRjBFpukfanWk2Ci3igp/uBIXIztCj/ZG1EYtrtx94J4QO4B5NYyj4QRak1Z06q4UnFC2OEHuV98Rw9BlysSPZxUPgy464Q4qz8ScQeHYe9fFmV1CZH2S9ORyqBBaFMJLEqIv8R+Ab91PpIro7FphAPLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jHJiKmceC3k+R7p4wgSkJgNBmB4+a9DlWjbl92iy08=;
 b=Bn7O/JsTwnXhdut1MW/3He5HAKRWvIEUxUxPjK2+2na+34G6ZOgm3F7/da03s1RzYIKrgvml3iLJxD3feGANM1FIdeIEuMK4cFoGSZWmoRxR/SuXTC8Ky7w48psB5CT346WavI5qhpZyYvqf2WIKSW8/hP7pSOUR5ZRQUgqzHZw=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3616.namprd04.prod.outlook.com
 (2603:10b6:803:49::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.28; Thu, 16 Apr
 2020 12:37:00 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 12:37:00 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH] btrfs: fix setting last_trans for reloc roots
Thread-Topic: [PATCH] btrfs: fix setting last_trans for reloc roots
Thread-Index: AQHWD062t2QIRpkJZ0CXc0QD/zJaAg==
Date:   Thu, 16 Apr 2020 12:37:00 +0000
Message-ID: <SN4PR0401MB35985AA68F3ECB8C8AAE9D3F9BD80@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200410154248.2646406-1-josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f6b7c630-d98a-45a6-e573-08d7e202dc05
x-ms-traffictypediagnostic: SN4PR0401MB3616:
x-microsoft-antispam-prvs: <SN4PR0401MB3616BB4E78F18CCA2B54A4BA9BD80@SN4PR0401MB3616.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(186003)(76116006)(64756008)(81156014)(91956017)(7696005)(66946007)(52536014)(26005)(66446008)(66556008)(558084003)(5660300002)(66476007)(478600001)(71200400001)(8676002)(110136005)(2906002)(6506007)(86362001)(316002)(8936002)(9686003)(33656002)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zJ52OcUzmYNxx5a5D9CVQUy2h7ldZruQ+OEqLidDYt2ByWslzZvNVZ2MA4/UmSu/ZDKylKHOEJZzJbP7lpZslHqqyy8AjrVw3u8MzxWxJKQHJWtjcX3pP9tAXTUkltSrBlZ+KlVKX39wyXojtCc5B6o8D+nIPxSKoj76GpafFHmzBrypa9YM3rW3wZA2BZXtB3NZ7tiTlJ0D8r1i71h0oqIB0bW3zIzKMVP3Hae70QH/qh+K9DIk6/X4IuGyGuKJBHDo6u5Vri8d6+c3ZczWUw9d/Z+/7fDSTE2Luu4kzb0KGnMGRBN1rHONCq/judjMqzgv32sRZGALfEHsCbJu7fz9mS+SHqp0EqBQnBOemgIstDxNdT33Ry3V5Ursoj9A4P/EUyVJ7drCvzHFT/YZ5BZAbz6l3XIuOBvu2v11vnBmYRugWhBn8prvnBZ1dv+y
x-ms-exchange-antispam-messagedata: d6BD1bLE+1qtg9Pkub0iDI9hFCHeeN3ubrF4eISh/qkFmQoS0bV+Q6BK/ZSWgiCobpYrx0r4KImU0+gqyr1K64tD2UscggLWEsNVaEaKGiE0tOW3Af53A9oqM796nTxNDxk7AcMSG2fNK/Tepv5WbQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b7c630-d98a-45a6-e573-08d7e202dc05
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 12:37:00.3753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KzEgP4SxHMQgsrzGwOdFNp5gfXz277tG8N3ChOZC52HRDHRz7x4V4+Z2UiEyyYugLshdmp+gdQgMHncJC9txuI82Tug9Whdw/VAOsgkbL6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3616
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This fixes a kmemleak complaint from btrfs/074, complete re-run of =0A=
xfstests is pending, but one down again.=0A=
=0A=
Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
