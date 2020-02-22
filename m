Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C670D168DAE
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Feb 2020 09:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgBVIqN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 22 Feb 2020 03:46:13 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:11025 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgBVIqM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 22 Feb 2020 03:46:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582361172; x=1613897172;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=e9H7ljXlfTivCLdULMJ7Ooz260so93JEZRjagKNKrD6GSXe0wDEZg59I
   7r6ZJ1KRm91tvykgaKY7OP38za4RN7GKg4VWUaXX3dMQo629a0VsD+Ohf
   jedr3Def4zTmCgrBbxSn9g7vbT9WcJj9EcvBOl3DOC+2tGlwOTTZR+NWj
   4i5Lvp+bv/CMWfTh9Sv9J9EDn/Pa8BPar5ASyt/fy/OwC6ZO2XM0SvMxH
   cpbgrVZcJiyCnkRFwNFg9Jmovj+Yz5CfYTRRfQLh8UPoeNg/I+2MdzmJM
   IO0mEpmQwe4YVoES1HprAhxr5PR2cOiaUl6f8R+8Q2g/S/ssSxGi7GJWc
   Q==;
IronPort-SDR: YdoAUJTF+Xu48zXRPZFhqqJgqlamAqU4BpoQXxsiiW4TI4KVkoMSGRVbg7Uk+Zac7hssxemaqq
 RZghC7QPLS+kL4uhjYPZiJyGbFu+2YKDbFJqq+XMT/yUZWvIgU9jb5q8iuipwo/52dLd771MjY
 tgXoK5gyb9TBz9fNaAY+pUB6IWQhlJYlrXvyNb9JSUPx23RQqBopcfL7M2XZ8u7DlfKAhbru44
 irhRFE8JPGYAchWXgmFql33op6/S2pCU1d6gi+2O8GgvWjO1WjWKvu9a7AayvRy0+sEsvkPDt9
 2dc=
X-IronPort-AV: E=Sophos;i="5.70,471,1574092800"; 
   d="scan'208";a="238577167"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2020 16:46:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ad0F8YrXRiivjFx6dW2L4ELgf4XMTesFnq5p+wNfFyD4jGGeozKA5f8RzTER7kwJCoe7hz8k96nNoSStM+hPQSKA1VEBhms287nDUM6NHJ5dvjSLOc8XkVOcnWC/1uOcNdcwHrZqH+PUNUWgQmqRU2eh8ru8EvTRLNUnTzKpki96Y8bjHzxhZK31O7k1l5THcYtPGSYKG1r4kvPkHAH1Avla1gMA4MWWfu1zps4XhzgHfdWmwBDRjwhW+Fqb9Nw8I/dGUpDF2gNVWnwWwcpuOFixLLjN5fNutF0XSBNR0iuFXkYXqX3ikXNfLgC4OmXg1TOUoQKsR9CRR9TzuIaURw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=jM/OVTEoODPqyHDVK67UT/qUAmzVIdhb2QSObPx1HpRod4Ril2DmUlfZaU3uZPLIY/LI8U/pkLSWZMtXBIWq2Y/IoPAhgkiu3sCA0aS/b4+QzOEnZu5U4tFpxKCNXNepVbzF5MxcV0yNPidiRAlxq4Vv59C0OJX8f+b+IkAXfJS8UMl8HR8+MTwXoBoe3A/ax9xv5mRGayrx9kPoyORqo+VoagwWoavzsK2gwGYoUOoSCYLa7nigApGlGYInMzQEhyYqIVVoUilJPqcWdtNncIxpmD02tW7ZNPpPbCU3U27DdBMaLhXOCwFON6oJHYae58KzmQvl/gv8b8tS2mluDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=hCHLel0vBja9tooYoS0LrE3/0WmD+lHGt95W80XhzxzGOCy8gOoCjhBIbZewUQuH1SL/7ZuwtNeRr4Gon00T2LpGrJ6laWUJPkWG3GzGWkl9rYJBo0a2yp8ZiQZJyctpleHfYAXPuQlxgflwYKrUqrtRb9URpn4HHQ6xhG0kS68=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3583.namprd04.prod.outlook.com
 (2603:10b6:803:4e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24; Sat, 22 Feb
 2020 08:46:11 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2750.021; Sat, 22 Feb 2020
 08:46:11 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 06/11] btrfs: adjust message level for unrecognized mount
 option
Thread-Topic: [PATCH 06/11] btrfs: adjust message level for unrecognized mount
 option
Thread-Index: AQHV6NRjDxmjATqQOUawd5Rc8GMmog==
Date:   Sat, 22 Feb 2020 08:46:10 +0000
Message-ID: <SN4PR0401MB3598D4F1A7997B8B8C229E719BEE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1582302545.git.dsterba@suse.com>
 <a3813ca2dcfa6d75e118f4924811487dea4c52a0.1582302545.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [46.244.212.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ef6436c5-bb6c-4893-7c54-08d7b773aac5
x-ms-traffictypediagnostic: SN4PR0401MB3583:
x-microsoft-antispam-prvs: <SN4PR0401MB3583E35B8224EB75D92345959BEE0@SN4PR0401MB3583.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 03218BFD9F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(396003)(136003)(366004)(376002)(199004)(189003)(52536014)(81156014)(110136005)(7696005)(81166006)(316002)(19618925003)(186003)(4270600006)(26005)(66556008)(66446008)(91956017)(55016002)(558084003)(5660300002)(66476007)(66946007)(8676002)(64756008)(9686003)(6506007)(86362001)(76116006)(8936002)(2906002)(33656002)(478600001)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3583;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sJU/WSOdOLUMVHhqesYWWesr7NWUXJAdb0zRsRIoItkzsGT7zQfeb2Thi0Jro8sjqr2PvQSUKFempONh5CJXrzq58I8jBRrssQOLVmZdS2O3b9Wn57SJsJmN2XWVZe08JKL++82CLYzV9CrM6tLRTcukqu/hmj9MuureXHNxfE1YVzUayHhnG3+3m3lGiSuuyDf14hQzSz/Hx2lMCZRwxCKZkOuadjFQpNRIbWDuKwH8MTfQAZK99vT18dWfE5qVvNL3+VJlNrns9jGkx43RByCytlg2Wwz0mMvSABq6ZrsR+s1iWsoX6qhdkbUmRBY5ZWdTVyG1N5yrGxV2QVnXzjg6Bj3N7Ko2nFR2Xdwj/OHYRj1rdYin8XIZW2eg6Ddv4vf3qjGHvUZrx3sITLbEaht3+TmLfvbg64yvqpecsV6fUowvIRrFsoROcH4Sh84G
x-ms-exchange-antispam-messagedata: irXAXoVEzMlQ+idyYPLpGXJIZTu9iYRGE5Blgr8qjQr+DRWSYKC5AgsX8rFNteo2hpXj09cJX91+321OldsSozB/9QZrYyk92Ohh8X1LHBmJKft7VJbAS/RsZ9k4lMRlsYvz4FSaOIsLnrN7+Gc7mw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6436c5-bb6c-4893-7c54-08d7b773aac5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2020 08:46:10.9556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KB9aW4I8g0J9hIa65YK6D4xCsYAc/abD5T1vzDHnJGGO233Sh2mShev+lx908lqZEzSB1dz5M4Rvi2QaRukiGzY1pvj5oKMTmG2K2SOHniY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3583
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
