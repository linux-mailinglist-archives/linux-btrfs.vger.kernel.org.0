Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4514041916D
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 11:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbhI0JVY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Sep 2021 05:21:24 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:9210 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbhI0JVX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Sep 2021 05:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632734386; x=1664270386;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=TP+OwipYY/M2vu90C08bVroEV1DHv11sslAtv1q3b52PIxci+kewX93B
   I3nJqycGT3e3hzeJA5OFAUq2u2giVT0glkmjZoHXdOHaXp/dwApFLcRBW
   Q0tOEv6FCF6TqDA4dVl8N/t2hSeCuBqzYPQH4MUG1wZ4CJiN4GEp13Zjq
   Rjxbaf3++3S1wrwllFnAZ8HByzKiSmN0R7th3IG6IrZVgxYGoYfrYPA7R
   Ij1apCGNV/QgjoaJ41IuyWNIhlDk80w8KWd860j8p6HysDwyJDA7tiuoJ
   fZQ1qpeot4wUVd3zbJ2YkuC678EcMAkrcaZA/DwC496+RDO2xvt1bP3Ko
   g==;
X-IronPort-AV: E=Sophos;i="5.85,326,1624291200"; 
   d="scan'208";a="181663937"
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2021 17:19:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwulErfc41Zo/tJur6dqNiElZueifnvObAZsbkLSr9hQ1VMj7TA12icWII1U7UrVN4gyw4HPaplY6t2S4hjQnz+rnUzrJSv7v7GYoSZNV3lx4BbYUvNVyisP6jwmtJNd5muKIaUQTg+HTGeh0aAYPWHPD+2YVi1WyakUCWXRZSRNaynQf98tQL51JNY/K+mdJ1P2O+fHzt5aZT5xo46UpsIc/wzTknWoSYnqKvpIRxhnJg5QOUGaQsC4S/vLomxpwYpQnLC7u5oai5Stw4ZGA+DrmOnnjUMba61W9iV1ednuXLeD7r1L8EkMyiQ5yYyCEmO2h8dKWfKVZsRheY+AoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=G/XTLRwy5NrV9iqxb3zKb/qiqTT4MEK016STTWIb5G5RDr72oAx8BfZxeMl/OQkvrh3ODspU27gOdwgMHMc4XvZejfwiGIr7rkgkl1zXq5qB5muxilHa7Uyt17b7Tl0HDTxBGLMzoOXo+f49w7nQznQ5hv7m73djqdV1mAWbl6q6acqbW5CHi4QAyOvAMaxjQwVqEvy9QBqv9a/ApGJyDEMvJJ0POezuzm5RbPsHa7Ulova8iTWk98M0NZWw74FV4+lsT9KF7rK2hhMB7KbTCVM3t+BtQGlHqG/NM2koRCoYVj1JRORY5y5EakIxhz8d2hFghTzBAA5ackwApsM/Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=XIM3ziIBGDrx1QxxKokXdfq+xERMYuQ80dvRVDwnX62mrxHgb5pMo+eyXSoDhKdCgL7gDYT6R1MsCqfLGC+UcmttzD08A43iY5j/7ZESZbtTjz1U9MfJMQ26bFkWuN/f/YaR3g6XKGAiXe4IkwKo143vrlKxdnB29VHFTZ/DU5Y=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7398.namprd04.prod.outlook.com (2603:10b6:510:b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Mon, 27 Sep
 2021 09:19:44 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a%5]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 09:19:44 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 1/5] btrfs-progs: mkfs: do not set zone size on non-zoned
 mode
Thread-Topic: [PATCH 1/5] btrfs-progs: mkfs: do not set zone size on non-zoned
 mode
Thread-Index: AQHXs1ZrZRDUX4zcd0aJV1RIFeerVg==
Date:   Mon, 27 Sep 2021 09:19:44 +0000
Message-ID: <PH0PR04MB741694FB65442643CC85386D9BA79@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210927041554.325884-1-naohiro.aota@wdc.com>
 <20210927041554.325884-2-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ae21c34-6a1b-461c-1413-08d98197f18a
x-ms-traffictypediagnostic: PH0PR04MB7398:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB73980EA2988AB165B1A79ADD9BA79@PH0PR04MB7398.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +0exmIWXhCkX8txJa3gh7a+0178iVUfBCkMh80cfI2XR1k+IF2K9Sh4iP8F8xcXFLJ0ZUq/fqtCE4ZXNutBAVdLKtKeVnFiDmUDA6NhSOk06MtGdFGGHKVoeMoGTLKg2P63tSOU3h672yl23DOyS8d3RERn0EVXxQqyyQr6RbjVtpQKNeejagWoR8L2sfzPDmwyAUS3AtneSjamnnGgxWK7CVbTkwkYSDjnqF7JChpp7qCcREOXV5PJGzI3j9RJNN+GffUr9bGnBQqjMezBbqG5wpnd+58Qt0OjDm6K4RAp5tIsgdtO6sgQunNvP1N21UbqIrH1vChXKUgeufMQpu4FFh1TQ7rSvfdLc/tUduDKa/VDt1oY8x6SzKhPiwQjcJQx5NuQMShWS3pd7M0GFNJireEa1M17sf/psJgLbCKoTOsI1HVrog6rAQ0b2SAWIRVOuDPr6Iq1NHhtfAnFRbCWvUxAkZ7ga7haRXYxBZqDdiYsDevTYoOhGQSJAxT4qw5TdpOLrujxtMJp6SKTVqrPGHlLxMkj6ve59sGSUtudzZkK6D2uKgXshp9UmhwYO6fjV3gIvHb4VEJ+UbXhVkuMm/EdXZSqHHZ4QYzUU1RhrkkQRKzhlbgw1wGxdwEvcySvSI6eau3YM+73C7MaS8fg5NY5zZ9s3a3NwqGLYPla5K+VHb+gkmmEd9hwWDyWluysiuvHRMIrxlHvZ35C2Rw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(8676002)(6506007)(38100700002)(86362001)(38070700005)(9686003)(7696005)(110136005)(66446008)(91956017)(66556008)(19618925003)(66946007)(66476007)(64756008)(76116006)(316002)(2906002)(4270600006)(55016002)(122000001)(4326008)(8936002)(33656002)(558084003)(71200400001)(26005)(186003)(52536014)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nQTWJhQDRioSol3pIUdVwFCwqBXVtVyu4LV34GAUSJ5v78z8GWB3G+Xc94px?=
 =?us-ascii?Q?IVzK8FxspbZ8IvdyJOvIqmMUORBlenr/fu39x/oA2/VORDhyEKHcJcdnPYIp?=
 =?us-ascii?Q?6g0iZSVPMLRgQHGoFwZsnBac/9d9/WtxQGj38QJY7FYr1Z+aXHqTddJKenOO?=
 =?us-ascii?Q?mq8q8IixB+toJQMUG6mSHjIKUbSEkBUSLg7Ng7o7R3wpuvzzswJ9X564KvxZ?=
 =?us-ascii?Q?SUMXtF18hNBwGF4rW4jEJv2nn5g3z+Be8DVttgoQADcbQvCe/k6ZjcJjMOWl?=
 =?us-ascii?Q?womFyznIdtHU7RiXdFZ+bODTLnQJFFeyFTR7A1iF09UJ2uGF2KYonyzipnY3?=
 =?us-ascii?Q?DuiFru0blKd29v5x331ZVk7DoSKiOryhIQNIYxJXZSkYRPqYRMoMkOS4hfD3?=
 =?us-ascii?Q?UPNvvDw6Rd++Q2XqEFm0NOaCLXdjy9jozaR5zoTcGohYivrHumwTHvgvxqtO?=
 =?us-ascii?Q?rmfZuEW0Znu4rSryWpo1YEHzZsFcNM/D5V6xpchMC43mrUAZWEnrlM9QEiKQ?=
 =?us-ascii?Q?zfIRwz2kwP/s4ZrcaY8hKWQ6kcXhT+VCp9zhtoNXMziCupaZN+mr/SDOHNuU?=
 =?us-ascii?Q?KQ4mDJkguIz6IJhW6niiGmEl3YyAGE0VHZIXNA3aLRvX83Dz/dPWO5/rIcrn?=
 =?us-ascii?Q?QGVVXFAHvnbLLKVMnG5c5pHPAI3u3Twrz/Zmv1MCmljUw0X4/XeQxM3NELRi?=
 =?us-ascii?Q?ORPWeGqLVgOGdQ65f0cIMNOdgN02bXAOFZthsIzNMcbyXmexc1oFDad/7lcN?=
 =?us-ascii?Q?sKREoZilsIvkEoRhem/ZRRKanqh2LF+F5Cqb+9EqY24mGaJM9m/htiUpSGMP?=
 =?us-ascii?Q?nrAn7CbLQ9Bmxm1tLlpfzhWAnreWalYUVqY2wmK5hT4YdXLDpnPvtmO7FUmv?=
 =?us-ascii?Q?xogescnkRQEAxup/ueUK6ncPPV6dNtWWezCdUT7Yw43T4VgQvSOKXOVDYT8J?=
 =?us-ascii?Q?YZhw5IgBcjO1x12n0Twx+Hx4hmeIrvwlHIh4iPXRP0nWEXYxTx1FJZF50Hwd?=
 =?us-ascii?Q?Dg67+B5tKkgt+gdZxeTj7di7lZs5/an6uIqPyl5CIRa/FOPr0Q+PLx1dF2bf?=
 =?us-ascii?Q?GNBIdL/SD2y7+VMwkgFEL+C57xUakTz2pTwezFMB60WMuWmaf2GwM9i+jwBE?=
 =?us-ascii?Q?9RDxlE09q8HYxdf2b59CZSfQsEWx08JF2ApUKYem173zC+ur9QgOgl4JkS3x?=
 =?us-ascii?Q?4rQXweAFB0uEjXrWgssLkWJMh10nu8afYhDrsnyseA5OW5/5F5G4yEF/reCn?=
 =?us-ascii?Q?QqCjQJsw2rNs/KYoLSPbiuTTcFSeJWvZsdzxIIQqkqsaLTm62cfC3LmEulkh?=
 =?us-ascii?Q?AZdujuoCwgiSYXMIwF0ymxMR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae21c34-6a1b-461c-1413-08d98197f18a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2021 09:19:44.0853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p/uazBwVDP1tLuzUwag0NFzGIr0uxPq+gqQMieHvKDWi4DalM62i8GRbw87G5Gjg4+ayPhsB2s4Eb2X6+WYD31Jrtm/fsKOjj0+0kYY0qPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7398
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
