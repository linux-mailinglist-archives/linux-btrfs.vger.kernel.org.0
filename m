Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAC67164A25
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2020 17:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgBSQXp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Feb 2020 11:23:45 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:42996 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgBSQXp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Feb 2020 11:23:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582129425; x=1613665425;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=C38uddcVCmLSE4BBzoEqgKVfQ5YD2nGgsIa8IyPwMYJo+7BrL5Lru0ii
   wK020p2ZbNjgjfdNTHBS6+YuSRkqcLCTRDvUbpfXiCOaivjLbqNvhMXo8
   usFMg8JehtUDy6k+JA7hd/e2wM3xoOznGGConRxYg8K4mqQpPrR2AeA+1
   fleE5navK1+WHFtA16c+u0V7FVkd2LuZIrBKnTOpCyeztSrqgl/E2wcLH
   mpMuOVsbFtYXvpevUEbSwHIzLg8QDzCzPuvshcoBVGKVIMOcZ76LJCQQH
   a1tEFPApo+c56MOCq5nt9TcDuOcLb+sLjd1Ejj6HQkBi2YWN6rxAaJ5xN
   g==;
IronPort-SDR: pisXkhwoF4w2Wwz4UW2mWvwTJmF9pQmqC+tUtlDRI4PkW+uzr1YKUF/0tJFwM9prj5pa/5Bn3V
 YzVamFgqFQenYzyI6ilTLwd5MqjFJpdEipZPgfBqO1E+2lSUmCGCeWA5fq+zokDt5D/LX3RT4N
 z+8wKD9EouoG8f810vK4u9azNNQV95QbhjD7yWOUL4otbMnZ0JmJlQoDMIas75O7RgLO53d1to
 CArNE7OrDZnuTXTbLihkV5brIFgGTc2WwgR5uHN7Wce9DdPhY2WmA7DvkgmaZRy01PiX2HoSDn
 qCI=
X-IronPort-AV: E=Sophos;i="5.70,461,1574092800"; 
   d="scan'208";a="134557244"
Received: from mail-bn3nam04lp2051.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.51])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2020 00:23:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxBaQ5LMiA/lk557nD+dAmOXMaQw1zFfZk9vCh0k+87ywOvA6NXpq6sSjKNQ+QSqImXegTJO/fBhuwVA3PZYj7zfmtl34d6AzqnyBtyT44KL9lbUbDXsPF3Zp0YwaCGFx1uwiKKL787WZeR/n7PGsK8wyCHbOQSCeTyqNaKVvwxclA1F/YDetiIW9e1zBlp6r1E64KJOTT1SFssIHZkK7aMgndFVYDw2vi/X/xOfNU/zsUP7VvFlhipczxBgMW+7/OPE+9sfvz+l1n2dexFUJHBuOqr61EPmNyUCPeA8BU/PqaJPCx3zMV7Q5+Y6+xw8CBFtiUwvsfwrUZxHDwol1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=mCSIyH6bo13LMSbv5DR4ealUmlEpMkD5I2Bp52ECiC1c11E033ZwWj9Y/r5JtJenb9RggFQ2Hm6XRIXMKXI1MlVAmThWtGM6f1rE6QAfF3gduXWjtQFoCKNU/VCR5doUJTafG/WcylEaoME5w+CC8PPw+hS4YTryKtEgQyO2sIIVoLnbYKqjIfHBP2HNx9zdqoG9iowJuC+s8+AgeQki9vvkwDuuftTPUXcBodxxBAx1qH1VR95egOj5K8OzVz47L0JbNWfbaNmZwrGNJ4+mt+yx4p1nKfxb7qclV3e8hcw27ej4PxxIB63IHPIeoxR5eJKSDm6Qoj991htRnP3vPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=VqyIxkARX5VCFSbQjxBkPQpbJsYe1oMhtQowN0XUXJIb2dZm9LBjXUEmmbiMg2VVUJmFzUX8kWgjcaFx/vYAKXStoxrAaBBuVR8XKQ2P0zOCe8fCLytFxWT2TGN6rli2zsnxviX/MO/Wz8hGtIefRAusxnluk+aGrJYFfiof83I=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3677.namprd04.prod.outlook.com (10.167.129.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 19 Feb 2020 16:23:42 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 16:23:42 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: raid56: simplify tracking of Q stripe presence
Thread-Topic: [PATCH] btrfs: raid56: simplify tracking of Q stripe presence
Thread-Index: AQHV5y9cVYI04IX97kGUrZHs9F5X+Q==
Date:   Wed, 19 Feb 2020 16:23:42 +0000
Message-ID: <SN4PR0401MB3598C29FBE4CD9FAF268A3D89B100@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200219141720.21549-1-dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [46.244.220.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1ffd7aa7-0b76-4e60-d32e-08d7b55815b2
x-ms-traffictypediagnostic: SN4PR0401MB3677:
x-microsoft-antispam-prvs: <SN4PR0401MB3677B89DD196798363AA5AB79B100@SN4PR0401MB3677.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(199004)(189003)(8676002)(33656002)(66476007)(186003)(81166006)(8936002)(110136005)(316002)(52536014)(81156014)(4270600006)(5660300002)(6506007)(66446008)(64756008)(91956017)(76116006)(66946007)(19618925003)(26005)(66556008)(55016002)(558084003)(9686003)(71200400001)(7696005)(2906002)(478600001)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3677;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xakKbKGGN7dFzAtVIHHWnXNs3fgHSQA6OC+KiA9RkdOaHRE6/pisvgHtCqclOzb9n0PJ8x+WdA3bEF4TNp6Tqjp4IrO+6MfglSXuz8HPZF26B8ExKR6RUj2cbZZy0I3XzA2qB2CLrH253+Pp7bYiZbQeU55dFDj4QmFWurY9md0DCIVuKCKzFzL+zEcZkgra66Y85rCx+zaXbUlxw/3SEaclPGPPL3LoE141gg6/zlvqKl3ZunM8+ZMKgpvJALqEb+H+EneUsXeBdeZoproA8RfMYNRu4FLwujp9jBdtriHcwVwf9ulcLl9+bHnlhM74aIyb7Sy/wLJyZFK2ClotHj9dOIM8NCD7lBIrRmQ7GyWL4yyzl8UtwZ99k2n2g7d5RzAhfm+62fevCfa/1pxpgSEyx98Xwk+uz6IIboNADQtWkFXKH77Z/nq50ubAsaKu
x-ms-exchange-antispam-messagedata: U/skKbropFWK6+IF2l2nQjml8IwmtbXtgXTd5UtQBxiYyGUtp2eJ5IaZQCtnzfkXTPFv9tbq4KE8h06oTpdbv2Ymgn+02IcO2ez8n6HhF9SCgS8K0jDCBHUUfG3v4P2KtyY/8yv7ccRK2uVmLm2S0w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ffd7aa7-0b76-4e60-d32e-08d7b55815b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 16:23:42.0845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RJdIXtkgnUHf7INgtTBRAvpi1geAR27gjtKki1dvqj4xOMGlwLTbLVszf2weFp3RNcm4/lhly+Ho2EGbDTV5ny0Lepr3vyTPYo6ZXLZHGo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3677
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
