Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93500212498
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 15:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbgGBN0M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 09:26:12 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:33839 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729365AbgGBN0J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 09:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593696368; x=1625232368;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=ErKZC2qfTAhOhJrcypIriwR1N98DC+dAj+TeKIp9UbB9RtkkeqCmShaY
   Km9bF2BoKLfSM9mcb06Hp6RAsmXcaHHlmF/RuTB8oO2VkD8ny33XSjAVe
   I3TVuLwUfI3dJ4aaaDZIkSt9KgsiEgjQPimYhtRgebDFqxsuKPSkPpYM/
   tkcy7v23D8VdjaHxZInHm99lEu3itKx/lKqyRJmGz71ZPC/ZPgEMGQ7rE
   I2AFn4cm0qzhrtyG2Un/NXTyJvKnscO+blMPil6fm5s4jibks5PCc2QWz
   iBoG7f2bpEJjmgS3xjws0D4FTh0lcH5WpE9Vj81eHmZOW/p6WoXyXlPcN
   A==;
IronPort-SDR: rfvaLL/q+YNwLKBz4Is2hxPkAY2+WMm67eg00MDOY7D7ghgHxIN/VElehrBaoAp2NCRpBbfhpx
 5obdGR2CefGDlSplG8ha34IjcJ1XOzRpgPtRUqNEaTepLoeSmhhp4fpBmKO+xmyiNooe931F/u
 WC88NXgd0+apUTjAtw5+kjzdTyusA8jgj5sfFdBKdGiiBYebDcoZDf8rKVVZIlWR0SuskzhcXz
 G/CGciSHQvp3jas1xRdj5Jgw+dA+9H61aQ6CnJ7nV5pdGhV2fYB9hh9bLfeRDnK1UiEVkuWE/U
 EB8=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; 
   d="scan'208";a="250717053"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 21:26:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=inYy1eOIc/SPfkoB7NIAvndCrBP53AXbAP8Nes0B6TeiA2/xJ841oKcxnvr1KYj4x3rVHqz2zq+McoXxWNzS3wPC3o2gzkW3ruHGjjTAOSdc5xbQspnhNFCtRgbhB7GoNRrz7jVQ6FTly8fi0DOuKOLpGfquyo5GfV1I5ewSw5bXGEtixvPrsL6QgIZQLfAB+L9O87TVUnVSWdAH8HrWvJL3pG3tvxQ10Gbh90tSXMSuP8Nh6TQ8tZtBG7fbmjnMeoQdj2wNVgfL+Bz+8VyZvUO9b1hMl89N9uVTfrpIz+JMDQZdm3UFW8ys2TA3QE7g0IRipJgeqWWhCuE530Cfjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=dFWglzMjtdhOuP6UqC0RM76Y3Z8jXs5ObrvKEbgw9G3Uok9TYmfhe7W/x7AgZFIkK+3skfWYwN0VnJqCGiBOVkmR6Yyxcy0mCAtMOKNiqdy3tLkyQ7SyNxsADJMlVXrTOK8Ekka87M0Im2V6aQRMTsbJZagG7zdXgigSkCrh3klheDr+QbRFmUOyu0rpmU0wAafPKhryhcJi3qhAk3WhAayVwnI578nv5o/HQXuu49s4fBD8jHiFa1VVI+MeQIRnDTd7V5PiFUm5sgLTWmIXRqdKLUzL84XKIDKgViG2Cbn+HWzT/HWXX4HzSQ9iw1b0BN1Z/du5oVHK1T0iZS9VeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=qCPEO1/aif7mHYOC2XKJs1tCAoWkibIBgsEZ1MdMmhddlU5MnuDcqPJCB0Al+0Qp2VitYMZhbyaD4rv9STh6UKezCRFIKjqlQgfNsQogI8E0B5/3F2S7ms4glIAeMIZWtbR0q4ebbXZozfzsoaWffUDonuiacjOi45mbyvi8mV8=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3807.namprd04.prod.outlook.com
 (2603:10b6:805:43::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Thu, 2 Jul
 2020 13:26:06 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.036; Thu, 2 Jul 2020
 13:26:06 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 6/8] btrfs: Remove needless ASSERT
Thread-Topic: [PATCH 6/8] btrfs: Remove needless ASSERT
Thread-Index: AQHWUG5+G0XDZ2BIjkO+6DXB/I52lg==
Date:   Thu, 2 Jul 2020 13:26:05 +0000
Message-ID: <SN4PR0401MB3598511C67C4BA53955A0DAB9B6D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200702122335.9117-1-nborisov@suse.com>
 <20200702122335.9117-7-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d747e8e7-0c08-4301-b61e-08d81e8b79a8
x-ms-traffictypediagnostic: SN6PR04MB3807:
x-microsoft-antispam-prvs: <SN6PR04MB3807E0B2FB2F19AD172AE3769B6D0@SN6PR04MB3807.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /LFyyIUk+1TxJdnLqDA1g3T8lfkIykiQoIHB7A+rRfkn4PC80IdkX/QJTYrL/t/MCEoFR9oFle5Z6JnZ3DQdYNyjIhQEzSBjxm4ip/QbWWe9C/+nUmw1Mx4DGo9IpWQm/oa5jAKqbHuQ7zaMpbhxD7UQx9avtiIpwO0oMV9wRW2vPi5JlesXSfc9PkpohQDIEunhOE6hNm4HTMHzYSxN+PDHq/IPHYbKPJZXKlMnKJzey3stZr+L6+i8RDIKnBhZyXNvKDwEbMYHbExkK+qdYnfTIkyo+kA2+qjzwi7VARwaorZ7X2P5MbhsiGPcMxj6tFlk90tIShGVcMhgk9jIMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(66446008)(52536014)(110136005)(66476007)(558084003)(5660300002)(64756008)(66556008)(6506007)(8936002)(33656002)(19618925003)(4270600006)(71200400001)(2906002)(26005)(8676002)(55016002)(66946007)(186003)(91956017)(86362001)(9686003)(498600001)(7696005)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 9Hoyixl6elnhbRYj4bYpFYSxJO97wY8vD/SomMYeMv0XoOH/dy4BWqraPsRsz4PoOfUDyOmmHV7DevePqXlTBMTRwQl4rt9spJQMwhr23AyfbhMI6i1URYTmCPYzsuRo8bfOVeY2yh3X9KixbEZ1K8cBm/gCM4Ghxsnu53P5wZYUo3TdE5OgVbzSXp5hLdmvnm5fccfhAldVWA3dUN3uwbcJhhsn66XK6Wz16XMeOww8BaeCWj4hYnPnL+TFHPoR/fiXGXu+aZXR9iwQ/33h2Oy5FGgPcpgw1OB4MYRdb0862IWTPfCjEWPUb2YrVfXRGY6okf7D8Pn7ynDWp0e7EMmbmq6Jgz57KsFL1kwFvlpklUfo6+4QYMnmyNBdqaf17H+uKOcX0ztRjfAiXcm9mNIbW+l8OULPcS+V6CMFZtyyjFTBU3MuLbC5zyczUlVGrVt7GaAugs48IY/j8n3T6Q4E5RkWUmdMJPC2PiCM+t3IShWHTdZNrHnzI2b0xpg1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d747e8e7-0c08-4301-b61e-08d81e8b79a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 13:26:06.1633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hlf5Hv2DAxi7XDVhmNc3PR64AF7Gwz/k4LSOBAwGjLFiVLwYseWV2xFeXvow9QdL05PuKAf0LIhzI9l4uL+Kqnx+dqmJZaTTEgwoHaSAFb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3807
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
