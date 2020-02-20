Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B76F165A7A
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2020 10:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgBTJt6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Feb 2020 04:49:58 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:55474 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgBTJt6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Feb 2020 04:49:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582192197; x=1613728197;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=3up1M7wQxa/CNdivPPxJj2svuV5cqwkk/zjZorZs9RQ=;
  b=o90EvyJSIVOUAVTH0o+JpR+eGwM7/17Lp96Kb80h0fqqNcH4QsoJwsEc
   Pl9VGAR0ZuJJyyuMXqqhQiF5/kxS3IH/ecFsxpj/f9VgGIYvauc6SebNi
   oTmr16X/0xeGG5CnPuut2STl8UBJIF14nRTkSlOX71QWj1CJG+KcMTA35
   0zd9N2uykYv0jhdjEI0GZO3N8MnptcAeRmZVcycvu31eP4bWEoyXA8hc0
   hzeU87RGCzmLxlvH0WsCZApnikR0Hu+gLeWIEfENeioNrEyXzLhvIEV1w
   wtx4vAOX/Xjl4JjYi3UMvS1AaT2KSVJftXAvMfhI1p9/RAariKRxU13FM
   w==;
IronPort-SDR: n727gSKtdQZ/aUH9vKIi9jE/PlBllVg6UQS45gD85f5RoTik25vUNEF2zd9H378JgI9nmpS3zp
 ARcOVGoKWuhZYpMuGducq2WFJS0PMqG6YUHX6Oz2i8JhzlI1ufzaxxw5I3IWq/ix0vyyyCxJjS
 wNfVUSCZ3r/3Ti3s3Ntcj3+kYAaLAnbXhqsbL9+BwUcKz6eg1CVgw5QvRFHqtCqJXMfJpA38BX
 qXsf2hKZ06yQ68zUV/n3bPJnD9+qa6pnwmEEvPmYpH5hgfhDjdjTiSnVZ+P7XDUxxAngWhadCb
 +Kg=
X-IronPort-AV: E=Sophos;i="5.70,463,1574092800"; 
   d="scan'208";a="131705930"
Received: from mail-bn8nam11lp2176.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.176])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2020 17:49:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kN9BMGJLYkBf3qD87S060+AW41yMcyMsUDgNkq2Ur12F1nSCbMSD2vEaKO2ai5ftcbN0rufKxkhn1VIjwCDDp67ocY0Lt6Pse6am0oTRM4yJoeGi8I1NvJnYMzE4g0QeTdvXF4rvigqyvy6rO4y7GHV0hpjvAGAba2m2PIg+GoxeTcdQQbqkXMEFvpZybGuZi+x2/UmeclHcRTbHZEjKJ1EtaloB2lQbW5ChBMzq0EArAVH3cOygdzZP7qEY0ZwB0sdtSWJU9ScbOX52xkPDW7+Hn5dpZxAJwUlsqPo8xMihZ5MXLLgmYSXXf6YqF/K0XAh0eK79i+e7jsiu2VbSdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3up1M7wQxa/CNdivPPxJj2svuV5cqwkk/zjZorZs9RQ=;
 b=cZ7Kh35offti/rxyXduo2J/I0okOmjpTrsOMCV4vobG4k4dfuRFr99BmaZYpKmQWIpypcHMuWqB/OZLUtkmd2p6BRjGq5766HjTexrfVVeDM+dma6Ea+wIrknXS6xmBw1fLYcTKp1K0owiYQNWrr4zkWheIYd6AsueaIi6N2+wuppPaTxzPIf806BmEtsrJablsjBQGQHpSbpqSD0BkhkqVvCyUtQuvRy1B5LhtxI72WZIzaOBrf7YDvm4SpKZ5Yx/S3hsp0MDcnhS+6KdIoVBg/ION0w91kn0sDKX07SpludclONRjA1WzdBTay/kmeX/iJ6JT7eO8dr7rRpax4iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3up1M7wQxa/CNdivPPxJj2svuV5cqwkk/zjZorZs9RQ=;
 b=glTbP/U8BAJpxX8s6PPSKb9QVVd2Yz5VYQBGow0T+9ayiZTlLksGRAGgXBGMtW5MUNoMT1074MneAUPbgHlc8REnbzm8Nf7ckdAOUQRX5f+gjv8MgADYUrhzqW5JaYcbvaZ1Lo8mELDGr5BGrw0pjKAuE/uH1QmkAFftwsvE0e0=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3712.namprd04.prod.outlook.com (10.167.140.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.34; Thu, 20 Feb 2020 09:49:55 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2729.032; Thu, 20 Feb 2020
 09:49:55 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/3] btrfs: export btrfs_uuid_scan_kthread
Thread-Topic: [PATCH 2/3] btrfs: export btrfs_uuid_scan_kthread
Thread-Index: AQHV5muUIsTjchxp60Ge/S7/Guz7mQ==
Date:   Thu, 20 Feb 2020 09:49:55 +0000
Message-ID: <SN4PR0401MB35986973BB035FCE0D48023B9B130@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200218145609.13427-1-nborisov@suse.com>
 <20200218145609.13427-3-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 86e4d7f2-2b71-44b8-cf3a-08d7b5ea3dbf
x-ms-traffictypediagnostic: SN4PR0401MB3712:
x-microsoft-antispam-prvs: <SN4PR0401MB3712D7DB8AB9FC62E5B5EB489B130@SN4PR0401MB3712.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(189003)(199004)(110136005)(316002)(7696005)(558084003)(71200400001)(81166006)(86362001)(81156014)(9686003)(8936002)(8676002)(55016002)(478600001)(6506007)(5660300002)(91956017)(76116006)(52536014)(66556008)(64756008)(66446008)(4270600006)(66946007)(26005)(66476007)(2906002)(186003)(33656002)(19618925003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3712;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jCwwy8lHLaHIx6YZ24oM99/8se1Z6lAV21TOUsQ247EWCBAAxAA3FnCA2LizI0SeOSo4cW1iTbgpV6dX0PqQiID+NRbGcvDekWr34AazGkHUpYa5TTZDRAz8QHwJjDMuOxV8uXn9/ROuFw+D8ynfBc5qx/qKwK1oc6fsqANcjEegdwv3tsZZhctcUFD1sRgqw4kL3Kh87FD0n83YXRJ3MSUV6b7wfVwdA0xdtzGEFTfc7l4/o7PbZ89D8GwF5KpGAsx7pcMnliERuDPhWnC9bd5yz35KfH7WKnpyc4ERptpeZCaSoLPdCB19Eyl3Wle3mERqwJcrhppHNz/C8wvvvbFGlnbCzTrTRx+lWQVTaU49g/YU7JZLWK8TWfFyAmnA61O0dzZ7yDpQdSvWW8VpD+NURPOb17C8EaG6DLPkLLV/d7Fq1WV0Ya3KEi5rKjTr
x-ms-exchange-antispam-messagedata: ClWabvkwwb6dtpnAlV0As7hTz2QtGXCCZfOrkT/phe0bhdhpQGBUUFmqp4R8HLjzWA/ML2Wsk4nCosVorUFydMFZIz4pdoDqO5gltx/lJVdcSjUVZAUOoARejY2+lHDtn776X1NGFK5jlzkHX/Xewg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e4d7f2-2b71-44b8-cf3a-08d7b5ea3dbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 09:49:55.8200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QZBeWjOLszeReW1K+l4KZB2nOcSe1eHAcmyw/jEU0nIIhFWMWTmW41MPc+fplSPCtCRMrsgCWjhFb7+SNI3bwOZ1nP8WknGQcAfqtYtnlZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3712
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'd squash this into the next patch=0A=
