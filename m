Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF7141FF92
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2019 08:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfEPGaQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 May 2019 02:30:16 -0400
Received: from mail-eopbgr1370087.outbound.protection.outlook.com ([40.107.137.87]:50784
        "EHLO AUS01-SY3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726221AbfEPGaQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 May 2019 02:30:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oakvillepondscapes.onmicrosoft.com;
 s=selector1-oakvillepondscapes-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNcYfA2utvY/ck27yRX7DsM5jEhEReqFG12UZdzRxO4=;
 b=X+VjqqL0wn1sHL9/bdYbGCakLroZoyx/gFpkjQQUdWZbR/jyX/Q1l+sDat++wgeagOwK71r9VE1RdkOgBUJCzl9rGNbEFdsWqoyg9eyCIToJ0QNqjzrRbk6zVgdT3ievOC+xYozbE7MYGaKeje1gkKJaSBvXTcb2l7XiWa63mwY=
Received: from SYCPR01MB5086.ausprd01.prod.outlook.com (20.178.187.213) by
 SYCPR01MB4288.ausprd01.prod.outlook.com (20.178.184.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Thu, 16 May 2019 06:30:11 +0000
Received: from SYCPR01MB5086.ausprd01.prod.outlook.com
 ([fe80::6016:fd57:4a00:d6e0]) by SYCPR01MB5086.ausprd01.prod.outlook.com
 ([fe80::6016:fd57:4a00:d6e0%7]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 06:30:11 +0000
From:   Paul Jones <paul@pauljones.id.au>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Johannes Thumshirn <jthumshirn@suse.de>
CC:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: RE: [PATCH 00/17] Add support for SHA-256 checksums
Thread-Topic: [PATCH 00/17] Add support for SHA-256 checksums
Thread-Index: AQHVC0NWkonViNOsnEiQH0Z9AhvybKZtSiBw
Date:   Thu, 16 May 2019 06:30:11 +0000
Message-ID: <SYCPR01MB5086D225BE48AD0AD9BBA4B69E0A0@SYCPR01MB5086.ausprd01.prod.outlook.com>
References: <20190510111547.15310-1-jthumshirn@suse.de>
 <20190515172720.GX3138@twin.jikos.cz>
In-Reply-To: <20190515172720.GX3138@twin.jikos.cz>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paul@pauljones.id.au; 
x-originating-ip: [60.242.218.104]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 931ad0d9-7a41-489a-9052-08d6d9c7f2bf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:SYCPR01MB4288;
x-ms-traffictypediagnostic: SYCPR01MB4288:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SYCPR01MB428842AFEAB905ECC7F650589E0A0@SYCPR01MB4288.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39830400003)(366004)(376002)(346002)(396003)(136003)(199004)(189003)(13464003)(74316002)(8936002)(5660300002)(966005)(2501003)(52536014)(316002)(66556008)(81156014)(66066001)(66446008)(64756008)(71200400001)(66476007)(81166006)(71190400001)(76116006)(73956011)(66946007)(256004)(86362001)(8676002)(110136005)(54906003)(53936002)(74482002)(186003)(7696005)(229853002)(11346002)(476003)(25786009)(2906002)(99286004)(7736002)(26005)(102836004)(305945005)(55016002)(53546011)(33656002)(6436002)(76176011)(6506007)(14454004)(508600001)(68736007)(486006)(6306002)(446003)(6246003)(4326008)(9686003)(3846002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:SYCPR01MB4288;H:SYCPR01MB5086.ausprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: pauljones.id.au does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +0POJFV4zG2vL5zJ/FCoUgEK3Ga4rQ2Y3OLHTUbGm78YWRGiqTzkVfid9kEslTW6f1ajD1NZoLYIE/ibhI2ZDQCbs+MOA2FfjqWkqnbGeb6S5wE2zwANgrz8L4sFrVUXWVqagCy+Yya7NQp3Pz3Y8dgLBcOGPnNjZ51cH+oSr5NVx9Qy8/BPCg/LAiwZ9xZQDelZFleHq02mfdyqxavYsx6YYM9DDus5rkDOTPJGw/w2A9fJMcmHstypvO2pwr1ovgEoiPpcLjyNvWVxYaBN/LyF9PCywTdZ8LKzBe8hQUnQ/N+6e6/NXDVPlqXz91NY7tZLm23HKwlS4mi5UGB3hGcO9Nqi7y8loXRexRtAXRMdy6oG6Dp4mWPi+jtLMKcl93A+DdJBgXrwWIukLuosKReZJ3jdnOLbXDPMj4S0/IA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: pauljones.id.au
X-MS-Exchange-CrossTenant-Network-Message-Id: 931ad0d9-7a41-489a-9052-08d6d9c7f2bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 06:30:11.2664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f216723-e13f-4cce-b84c-58d8f16a0082
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYCPR01MB4288
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> -----Original Message-----
> From: linux-btrfs-owner@vger.kernel.org <linux-btrfs-
> owner@vger.kernel.org> On Behalf Of David Sterba
> Sent: Thursday, 16 May 2019 3:27 AM
> To: Johannes Thumshirn <jthumshirn@suse.de>
> Cc: David Sterba <dsterba@suse.com>; Linux BTRFS Mailinglist <linux-
> btrfs@vger.kernel.org>
> Subject: Re: [PATCH 00/17] Add support for SHA-256 checksums
>=20
>=20
> Once the code is ready for more checksum algos, we'll pick candidates and
> my idea is to select 1 fast (not necessarily strong, but better than crc3=
2c) and
> 1 strong (but slow, and sha256 is the candidate at the moment).
>=20
> The discussion from 2014 on that topic brought a lot of useful informatio=
n,
> though some algos have could have evolved since.
>=20
> https://lore.kernel.org/linux-btrfs/1416806586-18050-1-git-send-email-
> bo.li.liu@oracle.com/
>=20
> In about 5 years timeframe we can revisit the algos and potentially add m=
ore,
> so I hope we'll be able to agree to add just 2 in this round.
>=20
> The minimum selection criteria for a digest algorithm:
>=20
> - is provided by linux kernel crypto subsystem
> - has a license that will allow to use it in bootloader code (grub at
>   lest)
> - the implementation is available for btrfs-progs either as some small
>   library or can be used directly as a .c file


Xxhash would be a good candidate. It's extremely fast and almost crypto sec=
ure.  Has been in the kernel for ~2 yeas iirc.


Paul.
