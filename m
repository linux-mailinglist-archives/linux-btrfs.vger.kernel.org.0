Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFF53180086
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Mar 2020 15:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbgCJOqD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Mar 2020 10:46:03 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:31507 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbgCJOqD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Mar 2020 10:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1583851562; x=1615387562;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=PDkKEbHE1RL7TW2XWhWvuQ96+zmaizgdW2b4681fAcp4GYkLqW833hQy
   SRgxFFpnM6UsxsG8Q6v990dglNt9idVlsbnjwpMO2m40/b+cwNok8A8SU
   vy1UHp9qDV2pWuTJ11HJEoYGFPf3MNNH0xVs2hSykR2b4TYxHGxk2oApe
   SYbI8CdBVGQYqC1kUICFPHgLVxKBeYajuUXYd2mF83vCj0z5kI0VIIC+N
   kkAdq7rD5R6UTyygJfS0eLVi/NsHnNlUZNQuAE+OK9ogB7PTEsVIo1RIf
   UHsRbT4PpjVa7cFJ4HyX83dfOzFrWS5zeGMWNGt8mIaS3tncKx6/pu0bI
   g==;
IronPort-SDR: qXnD2prOPxwfx1jQkCT/cS86VfnaFTKgXNSUA+nVS71hDwpEDqjk3X8kCEw+30dm/u9hycPudL
 hZee//WjfVHQ8abaSs5Y4vBxpw8lcT0aTKWm6Vq9/6uGA/1Fi6zbLve9Fjjkq3E1nRfwkARWf5
 SR+mzo/rBeqIhvaNwsj96R32SZhOtA/L+fQ/8oYkc9wHzz+WpMYDfRzLFMP7IeqfuVXzXu+BDh
 hwYZVbQSMW+xfQayyFnjRkd+W7W9B4MKJ769YCRmXdSmWFfDkCWRlH8p+tkQrgA0tfBRygw0dw
 YUs=
X-IronPort-AV: E=Sophos;i="5.70,537,1574092800"; 
   d="scan'208";a="240340284"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2020 22:46:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i35jajCsEA1cas92YDDaGFE3FD/uiC7HBcErGL9aYl4uN/hdPcj9weg91ETiHaOLXstnjkJwnEdOEm49/JZH1UrTNDoUTyN/uvl/A20So59Br16mCJ2LWotWNWOnJJiB4EnZ+cdZD5YnmOqeU1/i5pHeSpgGdMj+PapUSlBXNWrGhcx4C3VqpoW0AXtLCpvGmGFDpKSWwT0aomMBrq+ehOQlJQukCfQTskIyGXuJiqnu/xpqJ3V8jsZh7C1YN2yBgwSPkWrPEePkgqUfdhQhcxX/bAcEy9RIAglaMQMnWrmDsK5nKaAgEJXC2naH7MdDEgXIwt+3kESrdKaoHD1miA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=AfIE7wbMK3CUW/o1OKsH/PL6KmYbVSeXRVLtI438uBoEI4gTTl/yrYUmoMrxPNYiZzN7ND/A7ZZ2CE7ctD6OAkervKA2zOVQ6R3CEFyczgc5zjjoQKIthb8P9TeGoUF07d3habiT0hjYaxWHY3ZS4z2y0Qq+Fa7v4DBxw4deVt/7qh24b0FOBuw9rj7V4QlgV+SYIHEIUrCMANuMqPgLyAKYHqHi6VkZzxA1x5f2BSrbvMx7daRcrSE76kagbYnONntJo40FMVSo4GT6pP2Lk6ooec/X8wQFGSqvcZB48sZXSNKRXs9i8pIWTXz5xe+80TDcHXvx1dKUG5utk0boKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=DksVErCRZkywDeNENqE3K2p4TKGnW9zsk8zdZYLI8GfoM9TSeyyQb/lh1j861IQ+XQWMqhKAVMGA4TcmGWe+3Erao68HJT9Os9PgPlaQxYMZPsTSQTIhzm/sTxGymhdrDb/x3BJUGIOA809SkWapQpjL8lYngUUcNXOxj1X8+oY=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3600.namprd04.prod.outlook.com
 (2603:10b6:803:46::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 10 Mar
 2020 14:46:00 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 14:46:00 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Omar Sandoval <osandov@osandov.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "kernel-team@fb.com" <kernel-team@fb.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 06/15] btrfs: rename __readpage_endio_check to
 check_data_csum
Thread-Topic: [PATCH 06/15] btrfs: rename __readpage_endio_check to
 check_data_csum
Thread-Index: AQHV9lpUHp1fU/B49EWYUtabj3FX4g==
Date:   Tue, 10 Mar 2020 14:46:00 +0000
Message-ID: <SN4PR0401MB3598011B26CDF3FC09AF79F69BFF0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1583789410.git.osandov@fb.com>
 <f0404525ae352a08750f56a822512a52263d7277.1583789410.git.osandov@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5d7b49f6-a448-463b-5cfd-08d7c501bfe9
x-ms-traffictypediagnostic: SN4PR0401MB3600:
x-microsoft-antispam-prvs: <SN4PR0401MB36000DAA46033406C2D05A2A9BFF0@SN4PR0401MB3600.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(199004)(189003)(19618925003)(64756008)(54906003)(81156014)(316002)(110136005)(52536014)(81166006)(4270600006)(5660300002)(8676002)(66446008)(6506007)(7696005)(2906002)(71200400001)(76116006)(26005)(66946007)(478600001)(8936002)(86362001)(4326008)(66556008)(9686003)(55016002)(186003)(558084003)(66476007)(33656002)(91956017);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3600;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zEGlWAJHnn6tPdGWqS2TFxWaGWceutS3SlHLMfDn2aT4fYmYg653OxgmvgZHHy5RUzqu9pN0C1Y+Zt24rxbAcnKZ97hxG8KcIqQauIOHu5x+DjnHAOW2WPWqtkSbX1SMitQIuySL9A8UE4CX6IbABjBICWXujguBRNC1yPDv6rdxcFwZhjeaRNMlTBtnkaxLRzdA9dku3cIQ+1BgVn9Qc7OCGjVW+yVk3XasGFAFMluj3WXSgPShkBECnDD8iW3Dvgn1ceit2Cu5Zur9DDTlkJodvA0knOh53tsZUp8xLhaKyn5+HixCLh+luy1yPQ8Jj7H4G10SDTZ8K+dUkvqE1f3dnd/GZ9A7p2fUQeJCjy0sHBECWubwTdzB+5ao93QQXJmFMO+Sngvu8GUw427ITCU82j0mJ9tWQHxshcn82W+79pNpSbM3E7RIIwjiqxmz
x-ms-exchange-antispam-messagedata: 40aLqQ9Iz0DrZRzYXdeiml+5LPbV0Ul2aO+HM1QPfALIeZy8j9aPHlT2rLIpGBItTkNLggelSgD6QCIG2Oeft+94OoLJgCcCkv/Ss0qAqD902ayFPntFKS1o4DXG4uBK1blJlSz+Eq3dIb1dZD0v0g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7b49f6-a448-463b-5cfd-08d7c501bfe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 14:46:00.0216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E95CkgxRTgkaTUuL7KofUYs0icTQ6FpunhztopE3CfrRHDixxbygdkI8JXDBULxxpQoLAUKZfUdZXmdz03EkBXlAXLwFrjZCUGsYdYy2Bro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3600
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
