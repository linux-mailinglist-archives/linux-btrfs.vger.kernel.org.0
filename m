Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D7E1DAD33
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 May 2020 10:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgETIXn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 May 2020 04:23:43 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:57272 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgETIXm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 May 2020 04:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589963022; x=1621499022;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=DCaSt/JzTgmDR/XgN26PAsv9ZHBEqckxHolCa692fHk=;
  b=aOuTq3UaWumXF/qTTFr2w/iAcbvAjT6Z62qW0ylXBStM/aMQVXZSyKbK
   GfMoxyySE4XspN+pybG+E3dNdCgi8/yBTYqiRWJ6Aftay5j7md8soT9jQ
   TPjpo0iiBgy+5Kb+SwhTWaC7sBUS5czj9iU7CeCWMsbqv4JR1XMGxG/6x
   ol+Ghg759FC7LbFXFrus8qxlAqW5MvpR6f8f8qhlN7eA+s+wRjYW0+OtT
   AipK8VS9lbaSZwvfwCkKJ/+XFyAkv4q/sPSjsiO6buDCOUs7vnAs3whIp
   j9wOxBIDdy2SmIGpb04iyd5qYyQw6kjL4M8Ruv29cRgIsmjxWsywM4B7T
   g==;
IronPort-SDR: t6HOUAFDr4GHqafk4uODH+SkLM/99oe/SZ1oBf6RVi9RWyY2kqzz5Ys5JWc6i54rAYegzMVTJJ
 RO39dYy3+n0TTksJ7F8Juyi+5SQ1g3vVezSvS215c8qajTljyM5O9CxmsQR9Xw4K09TfCLF+/f
 FOpYXAc2q1pQ74kQEjH+9JVfIY6bGp79zrXtqc986xmr5gHX69rvdcNZVEXo6JfcuGe+gKwoTH
 qIQAKhJNq49itcd3QljYmj0xCELBuZW0g/w2o0UV9TNCh6jHuxTH7ga94QYUKXgQmLNcm/1fYO
 1j8=
X-IronPort-AV: E=Sophos;i="5.73,413,1583164800"; 
   d="scan'208";a="139545401"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2020 16:23:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8YnjLEjFOEkEaI1cWF6qPMMZsW5bPFP0ew9joGfPxl1gFThXdu62+WqoE70c1+QC9YmGRNJRnis27RHc6e+veW69IAKWaif1gheRbOJX1c0grXcUmqKMVZv7v61PHg81ER5C31vuOU8sk0glyVaAOPMWbdqw0mDAxq05fOavysO38Szp6DrHHPRRuA8p0NGOATH5TV/4cQIZfJ+4X/xEG1F5//Vuh1KuhFKH9+vp4e3ZmJqvbHHh270S57kCI4pycsvuUgt2fFhAnqBcxzO6oxtND/gkkXGJ7vl6Up4ZLAT54G9yNBaxtJBym8p/16axG6Putfnk6TkTijWL9RDSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCaSt/JzTgmDR/XgN26PAsv9ZHBEqckxHolCa692fHk=;
 b=YoOK7V6Bu9rp+/LYqT7/PhYXBWF8yJcWoBymbudaAnc/Qesulefp6SQzEAbElWmnLrSEQaDw0b7Sf6jfATYbEHkYh9YMr429I8TLq6QiXVJRE3U5/M9UkeGkigNbNFudUwkFxuNCf/rvUPMKDpnSFkYB8/R4T0rWhqt4w7AErrWy6z1aNR8tS2FVRtAIyTTsow9I+TOGySBUAXiy5xVW6iJBo3elL0Z6xOFlBCr0IprLLXeXKWKmjIV3A+BH3CJbrIkLiqNQrol/9W3wcfk7Jf4Z/rf6ow6me2kZ9WEMzWUTEMplTgDCPALuPDzspsl+c7rgsdGiMv2zmhtXSoNVyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCaSt/JzTgmDR/XgN26PAsv9ZHBEqckxHolCa692fHk=;
 b=r2z5HC6e7bvWNsrDRZa7K+5Z3rAT4Kl48e+vIDAp8nSLeeEO7954jor8JKwuIUn0NagAZDqYyzQ0zqY2/EAlvAedJzOmAH3Aq0N/vCUo7rBFAp+ACcgeW6BX0iNqI3crFI854t/cyPwEDxxWjqCGo+6HWncf32xs9xIOKP8/5+o=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3711.namprd04.prod.outlook.com
 (2603:10b6:803:4f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Wed, 20 May
 2020 08:23:40 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 08:23:40 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v3] btrfs: Add a test for dead looping balance after
 balance cancel
Thread-Topic: [PATCH v3] btrfs: Add a test for dead looping balance after
 balance cancel
Thread-Index: AQHWLnxhWBB54hSuCUW3hwvirRROFg==
Date:   Wed, 20 May 2020 08:23:40 +0000
Message-ID: <SN4PR0401MB35989E0557FE8C2ACB9BE2149BB60@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200520075746.16245-1-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da5f182d-da03-410e-4e07-08d7fc971a2e
x-ms-traffictypediagnostic: SN4PR0401MB3711:
x-microsoft-antispam-prvs: <SN4PR0401MB371198BC1C802B444CA787129BB60@SN4PR0401MB3711.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EmEvvtNBJFag4bPrPENn0wl1kXEUzTmgfNogRPjQpxi0TrVXmGwE6tj5hFjv49OeBCR5uTc9SohmH1amTNCjcMc8KRY8MvGQqHH3DCuTLD2T3CbtCA43PxtJW0bGQQVuzdISLh2+ecdbjVj4tMlWexiofzUYcbi7F01tjQD9p8ItfnpiuN5eoJcuyJx3D4Mv8Bzsz8xZimggPp9O8EadaYMUZoLJOUHzmdIpQkLDJdaO5yeKA0SCG3RcruROUvmK4guJtXD/6JH4qL0mXSmQGnFNPCGK32hGTrMON4H4/sBdzaIVOwJhk1EYrgxHt+3Ob0nA8k+onkdXBHc+8GbLnaqP41fQtiLFp6tG2aPa/2pZvvPJcM92PaWsvExNRrCoJuOusp3e+16285NbR8l29k2adgbYToWyirJlIayGTw1n0oyG5eTOfIr0ImzU8EVq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(9686003)(52536014)(76116006)(26005)(6506007)(66476007)(55016002)(71200400001)(8676002)(66556008)(66446008)(86362001)(91956017)(64756008)(33656002)(66946007)(110136005)(558084003)(8936002)(2906002)(53546011)(7696005)(5660300002)(478600001)(186003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: V9eq3x8iEDFAbqQpWmCWxn+0IoDfa6G5tSVocc5OJK516KOh5MY4JAw5S4Yr77AX46LY0+im3bkdtLJBwOcD3GF89L0kD1BXWs5PTwZ70uaNLS2od58tZ3tdB2srTRrHRMNTRGhF9Qov7g97zU4PLcF2NgvW8iGNcHKE/pWz1eEQuBQUjasY8HkuNwV7a1qrFJ/8Xg+6JuGkXldGJp9HaXsiE2aPxs6A4UViQqHq3NvvhHyAt0W3aU6ofkt/yP0hLLEWhHINGoxZr+W8WEZ1F+fbm3dsfS0LOdGmt6+wTNpfxSr5mCDt0ztoasa990ToYvfHX+FMFXCUb1/lqMoUayTWm0Mau7RDw+IwQne21zN/6ZgzOKJEfeVJOQCtooHnzWRgtQlcUZmnKrEfM9Y+tLCxMfhEDgcDW6Ve0K68aCkEU12n7DROx68iQ49H7VldDYI87V5CAZzV8tT4NQEWT4jfLpLHSf/VPD7Pz1JHJ1mBEJQcr1zSFGQJbvByNx7t
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da5f182d-da03-410e-4e07-08d7fc971a2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 08:23:40.4458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: warqWLaUAKOj0qeTiyvAKs/JKAmRE+Nn2b85qVEBbPCufBQZH5nC14x4gP+Z2ADjri8WSe7c0yonlK4BNDvpLzSV+inMkDh/VtYhq92rE7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3711
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 20/05/2020 09:57, Qu Wenruo wrote:=0A=
> The ifx is titled "btrfs: relocation: Clear the DEAD_RELOC_TREE bit for=
=0A=
=0A=
Nit: s/ifx/fix/=0A=
