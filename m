Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86201168DAD
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Feb 2020 09:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgBVIpe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 22 Feb 2020 03:45:34 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:21882 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgBVIpe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 22 Feb 2020 03:45:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582361134; x=1613897134;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=T2CCo1OJbtv7zq4h1Xayur5bPiQTe45Z0JBgVagUTks=;
  b=SpKqbAFkbc4aNprWhAqWFzBBLGAlDmg+thVH4bxkwC93/uZ064XSrygC
   fWbZ1ldDR805E6GvL6zHJGb6OCWWG2wC5u19RBezRW6TEZgvDqRYsQGlw
   0rA/XUvb6HwTcYULVvWY2cotOEuMGAHxsuzflV7Fl6x2LbhDiXPE2PxtP
   0Kyq3u37993zlSHifmRsKheVSufLhbqU/qEGy9bni84dR9nHkhBJUBb9M
   /Mc9d0wxid/fcdSMxXA0n5eNLey/LfAjxn7A3JF5Y82cVb2HliGR7mphk
   QrrVia0U7bH+uY1IS8eNfBvXOGdM4QEtmX9x/vHhMxSejEEOW3tnC6lmn
   A==;
IronPort-SDR: JJGjMwcOrLKucpXW61kMo5cDyf7YRRtQDRtKbJohoTlJ2zX3zmSSnFMMx8qnsM4skOSBHPjJy4
 ZkhslHO0p/jDE4hpCyQ4wc8NlxHyJwNtpQ6lTPBhPyhNbdZ78koe4iE4xxmA2DuBp5k3iqZYlR
 WsdZBum171izR4tBZgCtPrUvb+lK8H2wiPYA7tNGlxdK8oos+AoBWPuxPw7g1Vu8X3iGPVXdmV
 clFdZmza8OI/vNCKwqQ0HvMSVKerXnK/5u4kiZqH9Pw4LNgAbBsvIohKDOqDcGOLHw7+MRYXnq
 dVU=
X-IronPort-AV: E=Sophos;i="5.70,471,1574092800"; 
   d="scan'208";a="130968179"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2020 16:45:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQDkr7P1TwRryq6EjpeCFkW5JPo0hHVolqUjc1R0MNKTnlkon9nh5oEwnCt7acqRDNbMkFECwFakmSDXwNXhLT8XtGGfnefqiRlg4/hviK16+lIPgIQ9XtxI1dDu7gy2nNOGsAmbwArFrzmZvG1s9ldMYCGxi4YgQdEogsLolA71mi5df88EqyYaQ0GT8FlQnc/o7DGWmj/m1Zo3TtlbshCdOa7dbdDq5E0VA2C79EKNNddYrXBJROdCBCXxUR67DSdSLWMG41qDcgojZHdmC1rD4USru/zyeO3nz1k9rGfwfT1FprQmN1ELCH4NYI+nZcmICsrTOSEtAefFnDPMrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2CCo1OJbtv7zq4h1Xayur5bPiQTe45Z0JBgVagUTks=;
 b=J6nrKzslvMoV0cI5rmLVVxSxnCKKS2Ea2knjZJa77N+PzK1YtJ70WsgSrBqwClZjdtJIumU+Fn3j5MOv+bC4fXd+aqvj52nMWneOV4uLgDB2d9XXUz5ozpPre5RWUtRYleL6cEjkI65nLXzzDLwF/z1sNlQCqdf3P0xodQRIkZDyigep/ZJ5hONwI8WeJAy2UVEpMoaz8SDPeT+40PrmVT6VVLkjLfmLcqapcHuDbjcBAIVv0KysZkpnWOs1rOEeBq2E/R/DY/CauJP0nlF42uwurv224ehA5kyM18lk6ljojNEV0XejarS3yhT+KcjLZUrI+63EPCI3NlnGIne4wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2CCo1OJbtv7zq4h1Xayur5bPiQTe45Z0JBgVagUTks=;
 b=mpNMFdwIziwJXRGkKrL0CeoMKzb9o1ZxJ9dFG+0ERZZ1oVKGNNhwFdIjpTx0DL+N/QL8hnZykQlIzXGMUVur0SbzLBkz1kLoPS5omCr1wfwZtQEngdoj3NvzFONuKeeuZh25RXh7HGw6uJ0iPzE3QMJ8CX8Fj1W3lQerkPnl62E=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3583.namprd04.prod.outlook.com
 (2603:10b6:803:4e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24; Sat, 22 Feb
 2020 08:45:32 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2750.021; Sat, 22 Feb 2020
 08:45:32 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 05/11] btrfs: simplify parameters of
 btrfs_set_disk_extent_flags
Thread-Topic: [PATCH 05/11] btrfs: simplify parameters of
 btrfs_set_disk_extent_flags
Thread-Index: AQHV6NRiuXwMlGyP+UWceIFt0l6FMQ==
Date:   Sat, 22 Feb 2020 08:45:32 +0000
Message-ID: <SN4PR0401MB35988FDCB6B7180E0C2E30129BEE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1582302545.git.dsterba@suse.com>
 <e9483711e6f093259df9488c1d4d9753426fdf0a.1582302545.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [46.244.212.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 128a3852-e391-4d8a-56b8-08d7b77393af
x-ms-traffictypediagnostic: SN4PR0401MB3583:
x-microsoft-antispam-prvs: <SN4PR0401MB3583FD1985FA28C0E0CE09D99BEE0@SN4PR0401MB3583.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-forefront-prvs: 03218BFD9F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(396003)(136003)(366004)(376002)(199004)(189003)(52536014)(81156014)(110136005)(7696005)(81166006)(316002)(186003)(26005)(66556008)(66446008)(91956017)(55016002)(558084003)(5660300002)(66476007)(66946007)(8676002)(64756008)(9686003)(6506007)(86362001)(76116006)(8936002)(2906002)(33656002)(478600001)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3583;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5mcqG1swbTTDHxxvj555viKoh5ei46TJ2sn7n42EHYxROowLRA2+86X0FXm+zBGP0NzlpDiBDVRAzNMO48Ao2ho+G249X971sOHqa31uGfIPS2Wfm/l86hcF+DEvgN5ozT2J7LurSoWdsMJzSRwUeBL0Q/t3wJUDeNDYjMvMssgrKmNgOGujA21X/kI8XHi84F5wnfYsx0aGRyq6i8RV8RxQkJmc2BgrdVkNErzCwlDaHOAAgMVaWXoHr6UWmd7lUs4bocI6M0Q0iZUbPxQKkCID4sU1Imt0/V8EzXW6OrKHWO3PwOS4tRX/CslhaWYkMzOGK3byiX3yvoFEDVSxQr2JZ6bw/7oDbWS7vzuHQHvXVcC9aZdk4QLr9PvJIz3dItGwTjhsCXckLmfJvY9LT0liXMoJu3WH9/KcM3xu36JqbBh1osOu+QmhgPSxGcbW
x-ms-exchange-antispam-messagedata: nIVxNfvVXtw7qEVgCopJb3kfVthrh5BQng7Ei+Hyg10XVZCI41cQ0WRYW0OMiHkA4EC4OO2u7KwbSXdDrpcxscWxzVPvCzbwd808zQ1PVcgMYsEwhe36hdoAme9LolyniqUQjJqLkST/IW09MGFxpg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 128a3852-e391-4d8a-56b8-08d7b77393af
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2020 08:45:32.2388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I022I7ZermD6wlJvWa5Eq5RpeeJZpFPQT/azghQTm6GbQ3uWyA/KIObu+lFNVLsJLpkpVEcm8YoLqKtBVNlK2bsvpVqd/tSoAFV4TKCG4NM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3583
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A similar change should work for btrfs_add_delayed_extent_op() as well, =0A=
shouldn't it?=0A=
=0A=
Anyhow,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
