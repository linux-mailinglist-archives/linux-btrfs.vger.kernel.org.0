Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005E11CEEC1
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 May 2020 10:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgELIFT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 May 2020 04:05:19 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:4663 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgELIFT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 May 2020 04:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589270719; x=1620806719;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=xqQpMM15WxnNSmdAHdfcuvoN7Q0mb17cza0OADjFGa0=;
  b=gGsLn1s56kQyCEMslAsCcnW3uJVJkB3gfYR+LhJV/uz+UdXchzqZFXBb
   JxETrPeJzoG/i9bigKJTJQdvsqalW5O0ylaMQquQhw8oYr3aWCdIZw9Sk
   l8i5yOvINuj7NQasBo3ENJoc7uKnLEujafuA1kDQFfG7fLUw0L7tktHVo
   QvkKyfsq97qoEEvOMU9Q7XMEF9AYUYRFXgw3UkWRCGRx0/pVNUSOY1Rzv
   NoJkoVjxeuElS/QLOO8XPnU32krPJGL/+za29dlDtcq4dObbPJxhr3mHt
   eio4SppgXlkPIj7wQ3YlVTL5l9eX1BIWWxprCHftSPzKe7Y0SRSqbTYgk
   Q==;
IronPort-SDR: AaHbum281XCsOcYKoqfto/L9FD3P0fQ88LFh27Is+jLI2SaOgWTwZGaVUBHU/n40oEb2OTmS4X
 DTmtFRPs5G93lJcn4673IVzlSd2L/jS38Cx2s2CVbXA4G0/jqC7HJ6J6TuFw2JBwaxQy7lkxi1
 Lk5Z1I8QgquWXnimpf19xIDQF5I3ph0lFqQzoguT3WkAI8EjREfGkH/BGkMZ3V1z0Y6yE1pa33
 OwqgKKv3WGNkAMwFgklfPPKADvmfZuI9vZmoXrGkjMQidh5VfziflYIfOFMtIdjzvxvbF/zdoT
 TAk=
X-IronPort-AV: E=Sophos;i="5.73,383,1583164800"; 
   d="scan'208";a="246401251"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 12 May 2020 16:05:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3F14Ghr4nhyK1gQdR+0MMN15hYFydAbutQPJkb1nF+gCC6B2ZYkUIPoSZra9Nh5q02UqqLrFcUUA1TlG0oQK743CId5tu3VwWAF68wioiIE2KPLQFWzIvYpcIEwD7+Aia55Py68XyM7gKX0t11yfobTqOjZ3ig9KydOhJnwrqPuLA2YaupI5BRSyuoAqaGJjYxjel5vl+CMAuGYztdA+mVWaYZTO7YJ7sXrQ2l+myftfgsMBrzp0PcksKyZjV1YcODIw+PiBFwmdi5cLMKJ7Oi+/o1YE+65yh8tl1bBoahjB60AmPjLDBWfP/xfrU1XE7yT9OIQhybfnma9nFSV8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCwSBmzI24iDnvN84uT0fpiFtbQzwRDgTK0dmMKT/+U=;
 b=DltCHHX/205OnOJ5XW4NzfmEfvt1IIFc+SJ3xeO405rgK6Cgk8YHJLhtOL7HDYYnJzvNFNl6IlKtucBVavl4gsskv4IHezJtM0B+kZ3cwdmzjBIOvE63VTj7UFaoDuGgagoJDC75lpVQEUYSB31JUlj7Qg1ShQz0+RoI8m9Tc/c6jKhK+FsCX2ukAiY7kqBV4bc7XpiK+q2b/iYGpbnjRjbYJjlpMdWQyG/ijPgnkcBeK64srCUQDhiTyMsKHomBnSv9+vdUMRlk++Hkz5CAhp+5yPIXaKz6vgg8EDsD6mBvbSaby9AZiZoli2u8ji/cZ2FExldK4f2h1tlG8E5Y0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCwSBmzI24iDnvN84uT0fpiFtbQzwRDgTK0dmMKT/+U=;
 b=YNSR054PdSzjwQMr9VGdl2ndsKGiXkBELBIq7MTWjCAXpaT9eRg67MET7jpnmxtHvYhjGk5fUN7XL/e065DA4sgdmkPxoXPztc2EJeUn2TdoV0uiMiNsZM22Ev1UzvdCUXFoa8Q4ZB9ReF7oxfYcpniy7LRDuMwkiyZ32zgsTlo=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3680.namprd04.prod.outlook.com
 (2603:10b6:803:4e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.35; Tue, 12 May
 2020 08:05:16 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 08:05:16 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "dsterba@suse.com" <dsterba@suse.com>
Subject: Re: [PATCH] btrfs: unexport btrfs_compress_set_level()
Thread-Topic: [PATCH] btrfs: unexport btrfs_compress_set_level()
Thread-Index: AQHWKB+h2yr9rMcR2Uq7UYxD7T+asQ==
Date:   Tue, 12 May 2020 08:05:16 +0000
Message-ID: <SN4PR0401MB3598A397B1E8CDAE64C51DF59BBE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200512053751.22092-1-anand.jain@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 27bc451e-dcb4-4b00-ddf6-08d7f64b34c7
x-ms-traffictypediagnostic: SN4PR0401MB3680:
x-microsoft-antispam-prvs: <SN4PR0401MB3680935C195D26031DBA6B749BBE0@SN4PR0401MB3680.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0401647B7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +U4wZRliRiaAzNHgcA8opdTYMlbvnFW0NP7T75o8HU2MKv2lVfOA8BRLuTSEvvIh96j7XhM1rqD/cY4cfPNPPtO3TB4pw0+UHFqiBn5zk8GKSJSnrn5KhhKzSIJt7iXbhH0XfM6xjI5YSAtvpJAAni95LANcL1bO+OZYWhqqSquSvYGkOEwt1MCGTJw1lQYdChsgwq3zilWnOVnmCvCrw8cycD5I8F/eojUH4mpoX/xqbGlWQqrFU+SDguz5+6qQBVM1X8z9wR44JB2cBALnmyOfgeYhUFhZMyypq050Klk9POCmnZMrAapUy8xlZQov2XUurUvcsbxDGKxrm5WFD7SatYjCDALakS2e8MAWgzWG7OkBPehpRdyc6ZRtGXUQxbYMdKorSi02sWctU2USr22iDnyTisIZ3Bmaig9HdcrscXxjtriLePBNuv/T5PQSrZ1iGq/JFuKWDw6DOp1w7bfai3QPabTwzRUgMEV5xoFLlN9/1XlKo3wNDyfedBRli02rRJF94q7oORPFSoTOYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(33430700001)(64756008)(66446008)(4326008)(478600001)(66556008)(8936002)(110136005)(66946007)(52536014)(33656002)(86362001)(8676002)(2906002)(5660300002)(26005)(6506007)(91956017)(53546011)(55016002)(4744005)(76116006)(71200400001)(7696005)(186003)(66476007)(33440700001)(9686003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: utXrrG651xTNjF2g51NimMWrhQNKhKXazmOSldHeu07m8tKSDlbwnyYnVZ2/yHEInoQt+fHLgZnwFPSZ4O0sac5du6TxPuHr3ZJ/rrkDII18d3erihWT3KZTXih/L0/ZjpkgYcwrlt7YerHJ+hUmAmlyzZqSI6muWZcIZVILjJgO5jnBiloAckKTF/EMpVCF331FRnLIwFE9q8zUglrEsbOgPco+DI/kXAq3h/7mMLOq6A2yJbAdKpXKqpm5ug4Hv/wO3d9gl/dKsdJ+Z6Tgv1Fj6wQ1LcGdX4uRp2TLicDxXyVR/Sr2iijIZK+Mr7mm8WA0kxzjjro7dfuc8MxeR6Cw0G79PMHkxdFSgH7g6VL5Pa9411I71TrqenQkSTQa6/iK6K9IyxELvY+BMF090KcCkOIPn66fENlntuSnky/QgI6hjAufDLSt/o1u1vHI/et3QgyP3u4CZDCFGjzxkzddhZycRhbxgEGcAf5PjrsQfbY0oRVOFtBhgudG+RVu
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27bc451e-dcb4-4b00-ddf6-08d7f64b34c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2020 08:05:16.3219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZZLn4ziPDae1f5cxxelhzWCLQxv/I/QAIgAFLRn0AgmN1YT4W47C8fNeMARETisaqUatnjp+o9PDdYEzF6qoudSg9xMj8fVpEW0fDR7W+tQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3680
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/05/2020 07:38, Anand Jain wrote:=0A=
[...]=0A=
> +/*=0A=
> + * Adjust @level according to the limits of the compression algorithm or=
=0A=
> + * fallback to default=0A=
> + */=0A=
> +static unsigned int btrfs_compress_set_level(int type, unsigned level)=
=0A=
> +{=0A=
> +	const struct btrfs_compress_op *ops =3D btrfs_compress_op[type];=0A=
> +=0A=
> +	if (level =3D=3D 0)=0A=
> +		level =3D ops->default_level;=0A=
> +	else=0A=
> +		level =3D min(level, ops->max_level);=0A=
> +=0A=
> +	return level;=0A=
> +}=0A=
> +=0A=
=0A=
[...]=0A=
=0A=
> -/*=0A=
> - * Adjust @level according to the limits of the compression algorithm or=
=0A=
> - * fallback to default=0A=
> - */=0A=
> -unsigned int btrfs_compress_set_level(int type, unsigned level)=0A=
> -{=0A=
> -	const struct btrfs_compress_op *ops =3D btrfs_compress_op[type];=0A=
> -=0A=
> -	if (level =3D=3D 0)=0A=
> -		level =3D ops->default_level;=0A=
> -	else=0A=
> -		level =3D min(level, ops->max_level);=0A=
> -=0A=
> -	return level;=0A=
> -}=0A=
=0A=
Why did you move the function?=0A=
=0A=
Apart from that,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
