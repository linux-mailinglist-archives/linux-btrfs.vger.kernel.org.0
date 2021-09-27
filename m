Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4207741922F
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 12:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbhI0KY6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Sep 2021 06:24:58 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:32310 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbhI0KY4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Sep 2021 06:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632738197; x=1664274197;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=hgvAywRHBxP9hqpLXQ17s9ok4f68C9NZOAZWnUlR+G8=;
  b=DykRA76Gpd0vOwFwHg7ft0ornvMs4iMfiG6TSnucINZudcuVsg/t3H84
   +YvGajwbHLUkveJmE62CFA2+m2AKRB1lE0EzSjeQlB0Gvg7jCIjJLUWYm
   KzNOvC8SSwVaIoHT/czshdYBuMgwv1dQ5SsYWD2b0mBg4LbuLG6ndbBDt
   BhjrwOSsmD7tYavlReXBHXkGCPHRHAmrcBUqjGhtBTWZ4yRk2NySnzdvz
   oe9lh4UWdoXxgHVq8s1Fn8cDasVI2LBh/yrXqveg5eWQo+jxS4xTmQlTC
   A1qr/OdKMGqSzvyYXKqlxbiYDI0t5ZHvzRadepTgHNauWb2UAkXC2jAsA
   g==;
X-IronPort-AV: E=Sophos;i="5.85,326,1624291200"; 
   d="scan'208";a="185847314"
Received: from mail-mw2nam08lp2173.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.173])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2021 18:23:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUB2I5uWBSuC1K8zXpTIfdtTUn4zvpDFkdEOOfWrJuRjPWPq8IHBspsTodhtDNTbrmCjLsbNopXPrxxLf6yKsVS7e9eXNX/sW2BsK20FOc9fQeE921/AKAH5lm/AWvOu6H4y4ZjX1MvX8c+tg7LHtVo2L3+YUMeXvckilpRZzITPNc5MaHeraJhUcxgCAMKqQr/Sb3rYJZix/FlZVdseRqt8Wr0EByHdZFAbWFwRPVc2y1IifiiIP9raGgHjEnKOGJfDTo+PBdkYbdReIex4WfuF7zZQN6VbDlPpFpXEcOEafzwD+xr4V4HPM/eX7dMBdlFVq25jNMdSltJ3XBEc0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=hgvAywRHBxP9hqpLXQ17s9ok4f68C9NZOAZWnUlR+G8=;
 b=gNqxeDBRBkpZljwFO/OVtQd9efpHdIQmACstfUVeQAxvj2VUlZkMUKtgdDVCf66rR/2RXSunOJ50a1tE6Q6Ule/E7h2+Uio9CIv/Td0JdL/MU9TCwh1couu7tnQ8QwGZaSBJ4OF4fTG7GBcBT5IFPiUd/Seu2RG2PPthH7PMDW1zuvryYjFNBbhMdk4uAjPy4nMNQZGDFBJnSXK3izXLKip+w2VlEs7McSQ+H3AGTIRRyEwivHENCvA1Mt2Jh54tFwrbcb1wgTnBCd9tNB8ZyhbhMmj6TVbqYidQL7DRNYln2n3JMsAtyRBlArn92Gflgu7Dsc64pHTBYsfkL7hrGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgvAywRHBxP9hqpLXQ17s9ok4f68C9NZOAZWnUlR+G8=;
 b=yy2f/5y30D1utv+4m0YQHhb17Db3t8cg0WOLA47D2E9mM7KVkr6PCvZQu/wRhqDl1x1RM8K60pqpWf1Ar4we+/AjELy0l9TX8if2y2m1RS86oIc/3X8E7N+ePs/u6Hp//Qx/ZZ2UfjuNLqVttYUFM3bdGg4sYT3+JojXeuaTIE8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7495.namprd04.prod.outlook.com (2603:10b6:510:57::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Mon, 27 Sep
 2021 10:23:17 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a%5]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 10:23:17 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 3/5] btrfs-progs: introduce btrfs_pread wrapper for pread
Thread-Topic: [PATCH 3/5] btrfs-progs: introduce btrfs_pread wrapper for pread
Thread-Index: AQHXs1ZrDOla2SXGwkunadbgRlXgCA==
Date:   Mon, 27 Sep 2021 10:23:17 +0000
Message-ID: <PH0PR04MB7416B3EFBE477A4309A81A329BA79@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210927041554.325884-1-naohiro.aota@wdc.com>
 <20210927041554.325884-4-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51899b5a-5d5f-4a5e-eea1-08d981a0d288
x-ms-traffictypediagnostic: PH0PR04MB7495:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7495BFB8A8F6020A79366A3E9BA79@PH0PR04MB7495.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eE4tkSPeqGLCC3id3IjAXD90jdZilI2wdMJXHbg+CAWahXaz+4AWQEF7c4RGdFW44jPoRk/JWoQRWge4oQIIAz+kB/K5w0r/7CSblO+i77UqTMZJjkMvzV7rRgz4qxT5rtis/fufXVsh6EZG6VY5xFKmSXwYYLXR4sW7aTyiHEqmHjCtSjllCyT0QlKve5foftpHWUVHbY3sm4vcSMZ41VaDRaMgy8WpcbBZKEsojwBhhLtx4gwNXjNJ89HIKWA8fvdkzQRvGB0ZZp/YVKfZ8QRB0a2Ci0sJsAK1lBApqrSEKxRUv0n1InlWMwKAVIy3XhaxEA59MwZY+Mxo7EUC7afFe0rzwimOpkImIVSSpDyIzwK3XpQhlt8bHyFDUf/FX4Lu3yLp1TmGGY0Km+aIVRMwRCxZntyO4la/OAeRjxHyk/GjPe4E3XcS2ZfbIAgBPN4CWiLUwjQVPKyIuO+8ktkk2QM2dTlM4BpCNwhkIcRDuCTAbxlL64iy4VwoKboPBzRrjDUbW68e/7u8y0quIRu+VFoDjN9CWUqZIPyhJ15yBPV7FR/iuYLj2nVHPO+OaHM6cpk5tTh0SE1CFI5bu3yQKmZZVKHmBr18/joAh7l9n/h0v9MjkAd/mEBBtsw5kuMvxHyFdYD51fS/iNrC+PfhnANOqel0DgsZOdASRwVqfdrX9MVI2nc7YUSANOyZX7iqzUV1NfCa+bSFUxkglw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(66476007)(508600001)(76116006)(91956017)(71200400001)(122000001)(66946007)(4326008)(558084003)(66556008)(38070700005)(66446008)(64756008)(316002)(86362001)(7696005)(8676002)(186003)(9686003)(33656002)(55016002)(52536014)(110136005)(6506007)(8936002)(2906002)(26005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0X5s9STX4speU60Cec9GXs2io+1UtBmbs496KKwlZc0zzAQxWnqeVaGKmUOo?=
 =?us-ascii?Q?Fes5LOyvRrhjOfV79Ctiuop7Po8vi/Ls6pkIa5+dMYHpxALgkNe9QU1vrnvF?=
 =?us-ascii?Q?bVML2PxSPbxbPDBILLTa32o9EuYqYSXXmo/bDEG/JTjSmKzZfkqZvIJwsaoz?=
 =?us-ascii?Q?jM/ucgXHi1F48o1E5ZzzyqRgahAkCSN9GFl6qsrjwKBD5tJV2X9c/i4CMARx?=
 =?us-ascii?Q?Npcqjdu15qHNCR7SkkdUlAmMLPuExNvt2tnznFS3MI5yl78uGVouTFW2sa1o?=
 =?us-ascii?Q?ptCeORVBO2hzUeAWhtUT+Ei8EubI+1wXNL+FiliKCpHQBMJnDKBERUpPma37?=
 =?us-ascii?Q?KMZsn+Hj4aX2TpyfTenZAcgW/0i2P2BApjiFetYXFgU6p8qblu3VHWUf1J0k?=
 =?us-ascii?Q?TGDkCKTyjRMS+imFUuuN1Jclcep8jB7x2Nn8fNDXDfd889UlII8w3khcHNZ/?=
 =?us-ascii?Q?1RENgwE80OoUIqQxCgU32wp7PO4d6DlDvxcWW+v/OYs+6QSGnHh78ZIDJ9qX?=
 =?us-ascii?Q?qLD+9+bFCJ7/p3Lbo3nMQvqGw0Fw1ceFrvLD+l5CYih6S6hJ88JgbAl9LMEW?=
 =?us-ascii?Q?UTE1CMGlN2XtRhnQVYfttUUJNAifWZtrvISa1a4X+S/UW15kxW+cPiSralvN?=
 =?us-ascii?Q?9F3Nw0b5K+y4howO+TURPQ62NYwOV3m/qPZQiDnunyP5GV6glsrzqD35CIT4?=
 =?us-ascii?Q?NPfzAizG42Dh6qSa1zVkbgKra6zksn3ner2sp0YXjyM2hwijc+4DXHY/P/+l?=
 =?us-ascii?Q?FogVjujq+zbmxpe9aBy5wCFxQpwZ5Q+cXI9pHR+hLIxpUtAhGv8UwsSlGsrm?=
 =?us-ascii?Q?Ut6pz/SRT81VZfZR4pHn3r8R3Vsl+IXkamUdBfnmfBix9mIGCMWPV1SeT4Gb?=
 =?us-ascii?Q?nxpyvN5tMC8Vy+WolXu5N4wUdaM6scW8H7qMDovitkaQxpLLnLae+waLuXFK?=
 =?us-ascii?Q?UcSIICAZxG+yyfj+ONMnCo6SlUIgXS+ul0U6U7nARPHfUCyvhRdzKGgfdwwy?=
 =?us-ascii?Q?7D20+/xukm62h+R4rsXxMKmDsRekj4GX8CZ5+sKAKcCPfqL6jUQfDOxWFoFS?=
 =?us-ascii?Q?mLvAYHffXHQU8L3VChcH4ud481g0rvsNq6PrpsPl11pCg3xL+yl1RlHFYtqS?=
 =?us-ascii?Q?M7asW1BlGLMOw+kwp1Kg1zOjN6ltdtAFpX0eoMUj45gqGPRze7Syijccs7Ve?=
 =?us-ascii?Q?xR5QbKRg93k6b/Hu80UvtJBhz8JQIH+ePWUD8BStyf7+2Szx7gJmCE5Vzifw?=
 =?us-ascii?Q?jG2jf3E6kGnzWwhaW9h/3TcOSNSqdU8Y0IO/hXW2w9Y71fYam8JJQsaiBz4B?=
 =?us-ascii?Q?mfgT9sMSvIrF0n0vDSmGBsHN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51899b5a-5d5f-4a5e-eea1-08d981a0d288
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2021 10:23:17.5012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6EuiBpJEB9gfUr8D2FxPY67+zZQw6B0ZgSUH02CuYky4yOotRm+MJCX4JC6RSu5lgSoLX7MzuPpfPRVfKT2FJlPWm3pdszIVL8HGQyFUVAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7495
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'd squash that one into the previous patch, but that's preference I guess.=
=0A=
=0A=
Anyways,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
