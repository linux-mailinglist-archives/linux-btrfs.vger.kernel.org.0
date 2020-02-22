Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F338168DA1
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Feb 2020 09:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgBVIi2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 22 Feb 2020 03:38:28 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:26743 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgBVIi2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 22 Feb 2020 03:38:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582360707; x=1613896707;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=rgFy2ZkjOfaBd0dFYTg0VqVFBcxRWia3IFmt3I+e6HlWPW10mcg0aZex
   qwM8+7i20Pp9NGNZuM7G4VjiUsJimUYBxgA0WumXHuIDp84Wi8EmTcLPV
   Fn69qvl9TwLEdZ5HWvGZ5nc0PuC9GyKe305hc0igZFhh3wVVO4Nf3cY7s
   mHYy+LsnsOv4hiIxFYjOwp7s6AIchG6G1zv0PLpZamDya7sTfsRbcPm6m
   jIrfosbPkjyeEYfouLQE44nKoamM0z7LWGA3yO5zS9mgm+UJP6GiLZqtp
   PEsE6d771Pgak9QZTLqWQiqsLHXM4ojitaQZ07Cec04Qwz3gTcpW6ilyf
   g==;
IronPort-SDR: SZuhpC82+t0I/qpGBheZ70OVANPzZi8IOWMOKfSOcooSBMEpXofuw3pimEnZwS5xTt++Iu5nLf
 de0Z5+HeCWQQ4wkKJ2Oyk6XSTaitAbZ8dEuRbAzatIfz5qhsgm2AhAORVr+Nev9o7Sw7rdjWDm
 7Auesm6ylWl62WToegUx4fFwL1h+Lr4bHtNMcPJPlVDfhU2obtB3q5uvWhjYivG94zr53NZ6NZ
 wm2Mue+mUPeSlmoxqbyBZ9NQKwHVXiw6zB2q5MhGVyAVw9IJTsHWAoKf3kD8HsKeuFATbV9DzT
 dso=
X-IronPort-AV: E=Sophos;i="5.70,471,1574092800"; 
   d="scan'208";a="131890285"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2020 16:38:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkBzBKM1qE6PeSUgDQ9V+/VfC8iR99/wy/p0vHlEb05G+WwVa3Gy+QYXRYd9LQyV26gKY7xIDCL93Eu0ZwiNdDYifYO/r7KlWvafE84VIY8MCp8LprFdKT+UcL/0YI18g9Ak/bDUl/GEFKnrfPqys4Gj2CVHlG7ba0caa7GRpk3HV5XzkQ91edhFFPCCa12iqbPhUodYzZdcVx68Nhq2Zj2bTgX5ysIT8gd8hUohjO7s/k2exsfkQvlJ7jo9AB2JYTDCaX0fw0b//cIVgMZtpUPw4a2T2Do8ZpeQChQfhZ3ac7bVwmvZxlPNDPuOpVVe+VidGJEHff/0gInfg3qRsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=nqVt5R8WVTFjXP0dfnC0BHNexnWqos3o5jExlCQU84ywmdtUq6KMRTCgoNSKx6w8q37yyJSImaQd7Xw+Zd7CC+cy/1LjfE6KBMLKb/BY09ksIRwJ7v0ya9+QD1tuOuIxbZk0D1PUn6QjVMMKVnZx22WoHayLPQCZdLlGrTvwgv+cCmBglV8yfLwgu4QHk6Oo/X8S77A20baW/Vw9jiEdsdDJh069ANRaBFQqQ5X35Nd9ngHIRoR52GZahGX160mOtPQJIe4laaxUsBGXop8h77TEnV28apfl5a9kigi0dlOtd3QlhobQXRzQXn9aypDRjKRX54aZlkYgi2hu0LnL/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=k83r22wS/S0S+eJG0c7zJacTADGI34YZcwMu1erTaukFLy645Sgp4Y2gBCGONakzV0/ICiBZo81DPqyaaP8e4m1KVxlVoKwcRC7jDtA7MOzPledvtkJCz4MnEb07LSDJ2ic3pelu5By/cnbXwaqAScwXu049fVwcjNbVq/Dnyew=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3549.namprd04.prod.outlook.com
 (2603:10b6:803:4e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.31; Sat, 22 Feb
 2020 08:38:25 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2750.021; Sat, 22 Feb 2020
 08:38:25 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 01/11] btrfs: use struct_size to calculate size of raid
 hash table
Thread-Topic: [PATCH 01/11] btrfs: use struct_size to calculate size of raid
 hash table
Thread-Index: AQHV6NRdC41YPgClzEyi7heK93kb/A==
Date:   Sat, 22 Feb 2020 08:38:24 +0000
Message-ID: <SN4PR0401MB359803A0DFEFBA13EEA731239BEE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1582302545.git.dsterba@suse.com>
 <235ac518a3bcd772e82df812a12d2283ee993087.1582302545.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [46.244.212.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3c63d423-6eae-460e-ce75-08d7b772950f
x-ms-traffictypediagnostic: SN4PR0401MB3549:
x-microsoft-antispam-prvs: <SN4PR0401MB354946E26C64A5431A878F989BEE0@SN4PR0401MB3549.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 03218BFD9F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(189003)(199004)(4270600006)(8676002)(55016002)(6506007)(558084003)(86362001)(478600001)(71200400001)(81156014)(81166006)(8936002)(7696005)(66946007)(2906002)(5660300002)(316002)(76116006)(66556008)(66446008)(66476007)(19618925003)(26005)(52536014)(110136005)(33656002)(9686003)(91956017)(64756008)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3549;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xFupnSUNwuQVZ1nXTE9rgs7o078u1pP5MPDlSxM7J8icOH3/t4nKjjdB7NfgEBPaTtsNfRuMRXPCfBpyiA7soDOj08ikBqu54Ruc3RoWtqZ51DfUB4Trhuo0WcO94HwzZv7+liqUXagXIH3G9XLRaTuwJk9/1dFYJidadDF63j7QscnS5PFsuFgoSf+Wc8xTEVHWBATWM/bE173Ns9Q/1XMQNFMwt1i+nFuRGjXTR2fS9tc+VfBhjHx92E7GNptESJbUs9OH0W0xvW5BKc1SO2NVPXd0ugVVeBUf3W0CHlacrREriGsG8Wdivv+AO3h1y2SPlvxMCSL2LvJaY+O/ggw2ve6K0TA/9pqouOMLGTu+OO0LYjYz2P2AuHES4g5HJVcBNqqE8OCSO8goNsqjGaEt0F33amADUExIYX5/fTFcUlugFVGoy3GKAwhW7gmr
x-ms-exchange-antispam-messagedata: r637qyUinsdOEs8XhfCRVxDoo559UNkN5RLJD1LDGh9szJACohHHZuZyB00zIP6h5Y9olenmkuEJx1U6OtMexiLjDQfM8FI6AR6HDm0/9d/wR3RircHgYQ6IqRwqjXEFuvk0tPTt9lM6qMnYIQynTQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c63d423-6eae-460e-ce75-08d7b772950f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2020 08:38:24.9601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KO+SF5gJBKwl5zAMQ4JiXE93V44/GRK78khNZDv35PApZzN2G96PBW4vj5UMoz0oMEYxuMOjqOOU/DQsYM71qlZYL7swGc7QxoQK9Rr1lUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3549
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
