Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFE2154521
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 14:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbgBFNmb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 08:42:31 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:22725 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgBFNmb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 08:42:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580996550; x=1612532550;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=COyoLhP9SJws1bNN3g6Kn/e6A7LC72dyTKpLSkpfhYeHyz183fdxWwgQ
   D1tdhm5JN0DZrT7iqcEvuNMA3HHabKH2bofF75kFZ27oo86vXS7tv4Img
   p3ds65rQyqIDYdDRGkHzr6EprGuZXjCn2UW0tPEif1NSguXhNrkt2Xcni
   gSPv20A2iPFnoEtSeWhbm2U6ykpGUsZNGQ/v8+l3imV5IMAmZ9fvOmzSM
   imMiJfUjz3OQFyl6UMAmPnFB8ZTS+69g1qJ71DBb6Evz+9CkosE2jAOqA
   kCTIGURmn8OGez6AHUJqakIN5p7rXiQswdFF71rKONU39Bvge1y3AzefJ
   Q==;
IronPort-SDR: glcWMHJMYEezj0HUtv7jCnzniga/Za5kknilWRUgDxV7knG5J3cQ4G65ff+JuuQZU5uPSFcCqy
 41Pv5/IyejNZnF54X3Oy64atVU+kCzLkALfAGla+2fz5ZlRUPtkEnfdHRrvSLQhKcJkJ7IwCM1
 B7qtrCPpzorg86MxRR1elWoFqBOgteTx5N07b/SqQJpgUAKwxcMKeSDEuMEHaL8CdRHBZceJOj
 Zg/t/GJuZg/cGO7uuAk5Cme0s4iT3mRgjYqVcsc1aqpTbB6cKDoGakdxG+gyztBS32aZcNPSdJ
 gOI=
X-IronPort-AV: E=Sophos;i="5.70,409,1574092800"; 
   d="scan'208";a="129252448"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 21:42:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYteBC9eTcF32anFHrdPslwwzk1kp6n65+zMUCDq/KNa2QV9xsno9j3BByGeqz533Ajnrxy1SrJL/n+unZBVBxbg48zhrNGQg+tlznJJmYxITbvZFPL+evJDctgGuSPizmJwfXW5oP+nAtRMIVQl6I+QbvjdPAKiNopRzQfmUD1dITKYcN+E2SY6RuYJngyXBLLrkBMNBgZKN0yIi0zh0oozKJJr6oU7wBEgkrkU87YO3wJO/Vg38WSVQ3Hw7zjZYh2Rqf1dJKreo+egpT25+o9T1CmcG67qohNA5fgvGt74iWnq9iJigxFia9W3jz+GikAx3qIh8/Y5/tuGnTzHQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Hur9V1XstKjXpal45TUPGPH1jJ3v2TKCXgDPa+whHWn/IpZ/WxZrQx31s7V1gkTQNxUlIh2y1M1rarw/dGj7IHiBd9N1ogoQMenQQuXu6/GcCRWnidTioexPeApQwmKF6G7xwkBiGd8Qr+A3qVNbqPvh71OKOaE4ffumUajB0h2/9rS4isA0ACgNtVPgx5CrjgXFY1Zq0/QouX48Uxqw8EL2JHZI2XpTVBv8JjtkM4gDos4d+H8btG2m8J7Ty/DBjrDdpVVRZHPxe99SQqiMSilOt40flTjroGQGir5jNUgwJOm/8pKmqC1orHKAVJ7Z+BniWxhPsJra+2Hnoxostg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=tA/hcnVmFj8V2xsDU0C1Ws+JRjxA5rOGw1lJS8qt9kmzWrz8U9Z4aGu612EKGgeVloHRkYigU3zWD8CxhfYm4iZKEKoIvHIpgkr2DFEraj65y5wyWgMyfApH4UcE3plf5v8UslKSz/CtMFTmZAue6cXw7gkxHmADD7z/1wXgV20=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3518.namprd04.prod.outlook.com (10.167.150.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Thu, 6 Feb 2020 13:42:29 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.036; Thu, 6 Feb 2020
 13:42:29 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 7/8] btrfs: sink arugment tree to contiguous_readpages
Thread-Topic: [PATCH 7/8] btrfs: sink arugment tree to contiguous_readpages
Thread-Index: AQHV3E99PqZiiCNki0691RkSQmU4+w==
Date:   Thu, 6 Feb 2020 13:42:28 +0000
Message-ID: <SN4PR0401MB35985035B3FA5F1B5A00B7C49B1D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1580925977.git.dsterba@suse.com>
 <02eb803895120f3c2bf85eb7f8fc79c7e1b3f6a6.1580925977.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d7609d25-d45c-4f79-e260-08d7ab0a68bf
x-ms-traffictypediagnostic: SN4PR0401MB3518:
x-microsoft-antispam-prvs: <SN4PR0401MB35188483084B0C6D070640219B1D0@SN4PR0401MB3518.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(6506007)(71200400001)(19618925003)(33656002)(478600001)(558084003)(186003)(7696005)(2906002)(76116006)(66446008)(86362001)(91956017)(66946007)(26005)(64756008)(66556008)(66476007)(52536014)(5660300002)(4270600006)(110136005)(8936002)(316002)(81156014)(8676002)(9686003)(55016002)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3518;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I2uuaA5hbvWeVf07GsmIn81Wvu2jMWUL21yDlGUIHKxHu7pCqMq/893f+I3hcVQjUqfSMemI6Y3zHZxcppD1LZN4ebIAkMh2bZKel6KosjuNxx7ghvrX/ae//60xywMXLrSm/JwlxQy2n6AgBN8zM4ZodYCHMJzL6OSZ4XFKLDmFfYZAFjav6uWpxBEzkb2JWmRdzwtz1jVmUPmjbOo00iacMLTpZEFryJ6/YL6BujapL1KOftKgkrFeHW1j5tDEv59B4XeCGrvci5Ev8nnUWNlCoTJMWm7LbmbzhogoBSTcx+jBYHmrbSnaYqylZOpdvgeDe6s+xz0bzBGvvOmb4KaXBbt+iVLZDsIqRvMP7gTUuS8U5on/fc0Fr5Rvx+peupMRS8rpgTy7fu+8PukrtJM0rp2PY3dqgRJWuXgxDPGakOtJ9RdLgetgRDFZzyRh
x-ms-exchange-antispam-messagedata: oZEod9ip2o/m8FDbn0q7ZebkrhagAYN06y93to60KQSYcKXDRWXAqqz3qtu2lec1Skml3MYraz8wz02Eg32oOSXeP7CHXe7CeoMB4DZeFODF/CzSRbmEfK6EYEGCx674pWWmez+eoQA2cGsmmbPvBQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7609d25-d45c-4f79-e260-08d7ab0a68bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 13:42:28.9933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YqOPWsxwuNsXRkJs/K2NCFVqol6savvGaZPZfjm4tbyZ8gLxPih1eZ+jdVHvBq/7+53Qt6FIiboGhZmW4f/uqK+5HDluWAQN6mg5rH1w7E4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3518
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
