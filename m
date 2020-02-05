Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13B6415272A
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 08:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgBEHoO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 02:44:14 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:43751 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgBEHoO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Feb 2020 02:44:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580888663; x=1612424663;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=XqexVmN/5hw3hAxzrXvD0sIusHWgnfRUVk4l6pi3Ikg=;
  b=ZPdRLXrBVck9Jtx7ChJiqhRYPAy5kTwqQd8fCiHWQpvJAjgXRdOIPTar
   +twSEq3DBZamx51QFhdDObQwlpmJvtnYQvPZZH8K/Y+Euois8Cc02+iMp
   s4vHmxu2Uc4uCbR4xa/xyP217H8lpuKzWt9fIqQUtDuel7/gefOOkDym5
   qDeoPbFL6kJ+9SSF7ljefaUSCjbBc1j32xFwzo4jbzzPt2XRfN0uwpDKh
   CzTuyV5K1Z6xHW6Njx/G90vNby83IosLCI4HcH/Ixwh7EQAOV1jdFNBk+
   JcbO+anqnBlAVdisEn3Ay+j5NXW5LAlErhGgEDIVN6G+iNyYCamfWXbUL
   g==;
IronPort-SDR: geEe1VYLYgnDIF8x1+ZUHtsMjL8MjZv/0frPJNDmhfVOn/IwdAnR1YURaRe7LyDG868WOES2t5
 r/o//GXecSXKSHqaQpgdo6HXbeHwT8cCW90rIMRQ4CcR5erA5Hr5jQZH3pn1xoEKz5UtS0JqMs
 8z8AFo8NzaEnfI3QeQs1ExFqRehK/z2Y56UhuUzKqyEVnFxXh3PRcXuKAnQC8v6zk3Bz9yXlGt
 V/ujC5XZIXL9b8zWHLM4gjpuH0E6u4i4hDPx4Ht0EQtuJu9rrrRcaNp9qAERxBYrnmcU8kpqPu
 kOk=
X-IronPort-AV: E=Sophos;i="5.70,404,1574092800"; 
   d="scan'208";a="230874772"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2020 15:44:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lv0bJuZpj1zg0n+6N3tq1pPZepW1cz2eXjSERv1ZmX8hIwGqqP33OTY3POFATEjA+bvSONcOEMxwx0FxrwzjAxhV9RAyPrf5m010JYIOc5pOhLpMeQtxu6btlQXExT8T3AbGZpr5l/ClXKSFUmXeSNDXiCH56/BEpO1+VbDT8QPKKZ1g4xs/5ijpV1oaAaPgwbyKC/PZspLhuV2AEEPM7fpvxQ1ksdq538KfNm778x476ZyIR4auMDYfKM/qDcPT0BvRWLBJIXlTSK822Y7oCnshHJ8MsU+slCHexGYyU/+mD6OZOdZQI9ZmecA/KXeFBwtQhb/S+S0j6GWwYjq9Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqexVmN/5hw3hAxzrXvD0sIusHWgnfRUVk4l6pi3Ikg=;
 b=BTUKv7AbdihpFxiar5ZXL2cql2MObu2DnAUwTutkdAMozxKsQpsf9P9mNeePIl15ZPtZggoG0nrjlsjr9bJ9IwC4H+iGRx5o0oT8b6YbC1penDVBPVOM2mb2dA7lukPDmQQP6OW4m41ntvbFveVoLo7q3jKXN9qYj5cTDQK5wbgdGJ59Zxs1fPIyJUBA7DJQd6laqhUD8Bn6t6pvC+nqAtmPte5e30GDxPg+66PaqCin97El+hDubxCiix9DclaGzzvLCB24iVvxoX9TPJpndDidmZcXzvX4EkZAmXEp6je3rLE1kARLYIHxd6RxVDH5Gn+UpO3A88gPLSuPtLLvyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqexVmN/5hw3hAxzrXvD0sIusHWgnfRUVk4l6pi3Ikg=;
 b=ks84U2MTiIfZZfl/MOCvlSoez4Tlicv/oLKFvGB8B59ltQfq4QXxgNcVym109GzJajEMwG60n3wHu539A8wr0KUg/gFc76m1W2MvU5vhM5JVxle5I5rKol6GgCkLFJkxG8HWzwbqPpfc7RZQY335vi+Xmqs9S02+EDghLKyJM4U=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3535.namprd04.prod.outlook.com (10.167.150.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.34; Wed, 5 Feb 2020 07:44:11 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.031; Wed, 5 Feb 2020
 07:44:11 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
CC:     Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 18/23] btrfs: drop the commit_cycles stuff for data
 reservations
Thread-Topic: [PATCH 18/23] btrfs: drop the commit_cycles stuff for data
 reservations
Thread-Index: AQHV23cIG6o8CqgaYkyXvFJ18WlSRA==
Date:   Wed, 5 Feb 2020 07:44:10 +0000
Message-ID: <SN4PR0401MB3598D867A6925BEE3891733D9B020@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200204161951.764935-1-josef@toxicpanda.com>
 <20200204161951.764935-19-josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ad19aa10-ca3f-4ccc-cffa-08d7aa0f3084
x-ms-traffictypediagnostic: SN4PR0401MB3535:
x-microsoft-antispam-prvs: <SN4PR0401MB3535DB471FC878ABFF14F4F09B020@SN4PR0401MB3535.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0304E36CA3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(199004)(189003)(19618925003)(186003)(52536014)(86362001)(2906002)(71200400001)(81156014)(8936002)(81166006)(76116006)(8676002)(4270600006)(91956017)(64756008)(4326008)(66556008)(66446008)(33656002)(316002)(558084003)(55016002)(110136005)(66476007)(6506007)(478600001)(26005)(66946007)(5660300002)(7696005)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3535;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OC7sFIX7dgh4JB8oXda9uw3DBkb+nPyCo7H0lE8M3t2BsTyB0piaK5iDApatwSvBufHauWoDOK6VhL7D9s1td5qjrrgH5iPL/Ci9gqnnh9bTPWdgKwvrCHLkImMJrk4ZPfmQAdXjRwNzyx22qoqNaLz+f+3z1as2ECdgO7/meY/9V/pCt484BvHKqlVCwjTLtbq/5PZYtqEsWmWajvt0abZykDrkABwEFDRPiXQaO5KfoR037DGv0xWh8wdQsQihwwtsAT1SFdRYPSPkr7JVH5tx+YfKMq7yOgxP+oxd9Kl+mFlMhtd9ouPGthsUP5bzY8eYV6zFM14xFI99Mc9ZYEnG5lCbNZRIXFI+gLNR9KGsfC1CuFoWBemf+af/5GYxaxcA1S3xBdLgQzUUoYzW6uuuhDNFtUVZ1ROGmS2n4h/3COaxcyWvWtG7bsU1uum6
x-ms-exchange-antispam-messagedata: a1l8ZT4FBsgu+eclK+s5R9UT/MO/rXQwDybuBk2AB/k+yYlURnRCcuxS+52t16PUS7GMmM8oE01xs9N8ZINwvG8R9tcfkB+2sXOUFSwj7EXhys1EOCfa3/tM+kbj0hHob4hQ34rOqJberFC3qGC4Tw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad19aa10-ca3f-4ccc-cffa-08d7aa0f3084
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2020 07:44:10.9697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7S0jjfIZZZP4PJMDX2Cxa3jhqpwTz5kAj2xGHLaXHyPjIdnBo0zlWB8Bcy5TzHJ/yAVwvLnTfrXz+lIcMsJW6kX54sQxn4UiL6E5XMTPrvc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3535
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
=0A=
