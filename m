Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0E9A6A62
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2019 15:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfICNug (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Sep 2019 09:50:36 -0400
Received: from mail-eopbgr70094.outbound.protection.outlook.com ([40.107.7.94]:15938
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728538AbfICNug (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Sep 2019 09:50:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrtypYxlLV9SjeA47UEr4rqhhrxV9Tqfzj5OI4XkcQ55bLnGOH2tYHJ3Mp4f2+efEWmsYtNcCjJ4WzdOH4Y4kLlyERD0+DoCEDXIZc1b0jPfrLFt6fA2bpGhiiDvdNc9M7PJigaxVQzTgKEfDsYaTpGuQ6EHZdtv9Qc41kp+S3TEOc1wZFy5AkTm5tnm7QSc4Qab9hxkSU2CZoqdG6G2z19SfxXJkNts/SAUyfus3/u6gQXrV238tj+gFt15q1oxmrN053RR/U0nXBuARHo5ePV2bv6oe0QcjO6iwu8ovE1mWxNr0E9R27qunEbgMBcZ5Z/8STme41B53x3FZaaHLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwlFH0Tef6it4I56IlHzRYqIpiLUw8HCfNLQiqF10es=;
 b=lE6W5NQFpEFr9UfD2NKjLg2wr7CLBIuleMcPDnDD9DXS2V8VmKjwwwDWK585gLXM7/yDPPZYEWEw/6i98CdZ0NSJczaif8H7OC/YmsT6XyADsj1rcLqLjG628xuI75YQGnL/RMrO+rmWn7jMLEfaSlwgYMxeBgEfVAchJJ3e6t3VOEYxizaDBVxc/95E6d0uNTcBtfHY1zTJcAxNd1crf1OMXmu27i7MOwkQk9i9c+S4xdj4Y596Z3lr7yde13V+gXrWV4VshC3eMyNLrzg8Y7e6FsWUJmlCXUQRAXHwEVO4TZ/mhJe7i5HSztDF4CDM35VMpN9pHVCdwL/Me0VSQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cirsa.com; dmarc=pass action=none header.from=cirsa.com;
 dkim=pass header.d=cirsa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirsa.onmicrosoft.com;
 s=selector2-cirsa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwlFH0Tef6it4I56IlHzRYqIpiLUw8HCfNLQiqF10es=;
 b=OQXRxWGS+vsh+pq8e+WKqmd/h6LNqIl8+8ek++2TZkD5dRAqxfheJU3Mgso9xanDcKQwhHnhq6qM95DSjrMdw1IHEm7cFjv0MrlPMwrNvO3IK06ojn9+x8rehT/EkdcaFxJq2jZmCJSgRVSyBcHjkyhNUTItxz1J0Gtvi27womA=
Received: from AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM (10.255.123.23) by
 AM6PR10MB2197.EURPRD10.PROD.OUTLOOK.COM (20.177.112.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Tue, 3 Sep 2019 13:50:33 +0000
Received: from AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6864:7679:ad13:ea98]) by AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6864:7679:ad13:ea98%6]) with mapi id 15.20.2220.020; Tue, 3 Sep 2019
 13:50:33 +0000
From:   Jorge Fernandez Monteagudo <jorgefm@cirsa.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: btrfs and checksum
Thread-Topic: btrfs and checksum
Thread-Index: AQHVYl31ub/aX3nqIEu4Xhcfc51Okw==
Date:   Tue, 3 Sep 2019 13:50:33 +0000
Message-ID: <AM6PR10MB3399F9236E61F0AB7CAF4BC8A1B90@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: es-ES, en-US
Content-Language: es-ES
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jorgefm@cirsa.com; 
x-originating-ip: [185.180.48.110]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a14cd28-3938-411f-649c-08d73075b111
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR10MB2197;
x-ms-traffictypediagnostic: AM6PR10MB2197:
x-microsoft-antispam-prvs: <AM6PR10MB2197DBE37913BB254E66F815A1B90@AM6PR10MB2197.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(366004)(39860400002)(136003)(53754006)(199004)(189003)(7696005)(66066001)(478600001)(26005)(53936002)(14454004)(2906002)(6116002)(3846002)(81156014)(81166006)(8676002)(25786009)(256004)(33656002)(52536014)(186003)(74316002)(102836004)(6506007)(4744005)(8936002)(305945005)(71200400001)(71190400001)(5660300002)(2351001)(316002)(3480700005)(66446008)(476003)(86362001)(2501003)(66476007)(66556008)(64756008)(99286004)(7116003)(5640700003)(6436002)(55016002)(9686003)(6916009)(76116006)(66946007)(486006)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR10MB2197;H:AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cirsa.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hJ24L33E/SXeEKHXaTkknkjYc4ZF5G9/EmRT5ROBeitmtXwltL80qd6ax1sQVPXCzB7P6j+FgCosjpjLsE2l13LPG8ILdFfqx2Jpv9AmVu5PNuLGgiM1P3EPNv7uGS6IVZJiqJmZ1guYxWiWQlLTZJyUBjKtwi5SDLE+lFYDds8rIdKgAFrnE7L1f77jDhiK++TO1yK9CMhlGvTwcv4puLv4gG1zXQtZ6cP/QxymnInafJA0Jy6qH1HWwu6Kwrid6N6ghh4bh89rQrBhPe/GcTaKkz+y0cIGqDyclXyG31o/gKMFnXDw4n0ywHPliPaoEvJIBaU33EGese9QV/4wmHumOtX1eHWvXlmDzs4DXI/orCfoeOVDQeY95suxCrB+10vk8IO0EgRAaCYNrD4eiRJY/KJTh9W2B5fgXmg9kqs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cirsa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a14cd28-3938-411f-649c-08d73075b111
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 13:50:33.4749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e6d255d9-7bfe-42f2-a01e-09634cc3a03b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bxZJ2WbDRCmYK5WnM4Sbg6PstG52+ym49wGm6TeE8uEvIN9ewvLe+6/QxH//B+YvJg6/GkjJGw3qWbk/yGWmBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2197
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

 Hi all,=0A=
=0A=
This is my first message in this list. I'm looking for advice because I hav=
e a weird silent data corruption and maybe with btrfs and the checksum capa=
bility this could be, at least, notified to the system, and detected using =
some btrfs-utils tool or dmesg.=0A=
=0A=
Imagine you have an SSD with an EXT4 partition in READ ONLY mode and inside=
 several files. Every file is an ISO filesystem crypted with cryptsetup. Th=
en first, the EXT4 partition in mounted then every file is mounted using lo=
setup and crytpsetup. We have found, sometimes reading a PNG or WAV file fr=
om any of the ISO filesystems mounted, we get an error because the data is =
incorrect. Flushing caches and trying again don't solve the error. Maybe we=
 have a faulty disk controller and changing the filesystem could be useful,=
 or a RAM with some error...=0A=
=0A=
Changing the EXT4 to btrfs is enough to enable the checksum property or we =
have to change every ISO file to btrfs to enable the checksum?=0A=
=0A=
Thanks!=0A=
Jorge=
