Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0F7C15BD8B
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 12:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbgBMLRB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 06:17:01 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:20075 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729526AbgBMLRB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 06:17:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581592623; x=1613128623;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=TRfv8BB67NZZyZ3iXVQRaDw/+LDiScrPR/qF97dtYCo7FjeE3ItGIN5z
   b0K2srzKjyloSkrR/f2QlRSCZnxuqatplybbfRcgHiLPdV/X1JablcruE
   k98L5UAegNtlbfdaCQ/7dI2xPgbcO6Du3qs6S/FWyTZ5bjo4UhU3D7iTA
   Wdv80vuiJla18AWqnSPbYT67mmnM8xQEFQgRbrG4ajltHmMk16ZFKCDuu
   +8MtFsOFw4gItwoHJ43cbPX0fabxTmoxKPJ9qhLIsllW9jbasL22aSK9g
   8ox7bryDv2X4afAPIhVuskYnFht4/czDQzF10gaGTdZ4GIrSS+o8ZNACb
   g==;
IronPort-SDR: BCqE6mKFUAl3offPyi8XuKAUmt5fI0bozFDMuiaLOoT3hLeYh5KIT70Xg5vkBw1uQnL6F0CDFD
 ZkudnHKcOeiOBFc/ulEJNGrLFDIFoz3Mcnw3ZEYEOj2F0VFd8YBv3M7n2XpKy3YDXSqo/H1N1z
 Z95i+wFfOyNAMg+nikcazTpxr14R31bozuAtltB5fGwf8sP3WqFCKvGda6MPA1PSu2BU0FuX7P
 jnHVwYCdpGa+0PvbO+WjPLVGdh1ucBBOS7Yp/bAvqaZD+UfqpG0+fEDFTgiIo84eEpl/RfxCxR
 uOo=
X-IronPort-AV: E=Sophos;i="5.70,436,1574092800"; 
   d="scan'208";a="231569375"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2020 19:17:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7wTqA34qk6081fIvZ5NbAxf4sgBkUSHQHlHNhJf8W+LXA0QqjX+ABjIHbc8+yQbqScAA83JZerlhyf+jnAYjwzk7qwdF0iY/PWwREgxA4QKj/3jnLTAXOIQIwzlBTsBhqM5hpNTHf92g13MMj01IdIw6ZML5uoC1o224S2FiWn1Sksj9llpPo/4PyG/AW/NwNQbNpT5G2uUCim3Rte82esUmKvbEYfvDgOZL4JyWpre9XfsmSda76jfQju5DtuBG2fB8vKASq3IFim0xCgBxt9bMWREj9SFiYCJKtq0fejt/Hfrv9qGMy62u1hyCbVjovvdyMhHiDDJ2ztIO6riFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=i8Uzfc1GQGVvA4Z/z+P0XLz2se0EljhQrp2X0rOw0kony7JRjYTdcGINi1s4p6jH3cTz/CyNTgaD9ivTHlB4W4jgFW/jtN+P/QvJo18DMxcLHYXo4ZembnR5QsoubX3CzD3tKUVY9f/Xi3i6woBo/21YGaqkJVzM5r89r7o70G+VNxrKRgypU+ckL5KwMkmUv7nSln3aCsMV4PjGUWiBguRkuPgnWdKdNi5xYCktDhZjXOYRykpZVkm8piOi4yj815otlRliPIE1MQ6lAwB72VRdtEzo/tE+G8ycTk/1wtTqWldbDTR99NqnCBKTgYxwjA+VmNiTVaxd65/XFEwPsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=yN75bffVdUDI5u17uoT03QBMF+GCiaBHL4p3Q/5Tb/3kkMw/mw4IttBjzQPzRFlf8Vm8qOeb11c40gTssVqNk5jS2m5onT3tFacBtJ4Lg3mZB00Vaboe4D1GUG+idoJiV0BOXN6iESy7w0s/8d1su7JDpyeg9a10ughDyDCjCCc=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3568.namprd04.prod.outlook.com (10.167.133.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Thu, 13 Feb 2020 11:16:57 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 11:16:57 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 3/4] btrfs: handle logged extent failure properly
Thread-Topic: [PATCH 3/4] btrfs: handle logged extent failure properly
Thread-Index: AQHV4SPyP7ePYh/++0ml8G7zVqoFsg==
Date:   Thu, 13 Feb 2020 11:16:57 +0000
Message-ID: <SN4PR0401MB3598FBBEE6940E8243FCF3DF9B1A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200211214042.4645-1-josef@toxicpanda.com>
 <20200211214042.4645-4-josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0c49dca7-54f8-4c18-2af4-08d7b0763d2a
x-ms-traffictypediagnostic: SN4PR0401MB3568:
x-microsoft-antispam-prvs: <SN4PR0401MB3568D4E50859D56D667F93249B1A0@SN4PR0401MB3568.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(189003)(199004)(66556008)(64756008)(66476007)(66946007)(76116006)(66446008)(33656002)(186003)(2906002)(55016002)(110136005)(9686003)(558084003)(6506007)(316002)(91956017)(4270600006)(19618925003)(26005)(8936002)(86362001)(5660300002)(81166006)(71200400001)(8676002)(81156014)(52536014)(478600001)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3568;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ap/PCp8FA+RZFfVb3dxF5p/kEQQzIc87zuDgE6rfewJSOdhb/iyEygarmT6NIa2BPOyIMuPYKXU0TLBP9eRJSxh/i8R9fNUHD+7ByxjFthK7/uNGOvLhirkQyM29enMOo5pK81by0bGf8o83k7h8BLEbZDUPZVBHNrIz1pPmfzkE7strgsS3A5sN69GMmd3FNSSqNnEU2O/b/hmKNt0hrYmkwBKJKsGY3BFEgH6tcYyOipvjLmIGr3S/2BqbcEhQM8GcjItdgnhaBAgjSWKLs2ywgQdj/ITw6dVu7+bV/eDwiwwYVDVVjOqQ7bc1YP4ktrYDcZ2lztvNCFjrzKRJ4zUubmP+T5LenN6+H5zB0xCn2zu+tkxhkQvEXE3GDMJ4hiG+gXIPGjIei0LxtzGXlaUg1+3HNvraBKPScLXeFov2L9Xt1tAn6KwsiqoQAPwr
x-ms-exchange-antispam-messagedata: ubL3iyvLOO9oAuS/XBy+SUGOre5v3ZCTbkstxKF4OwjWEoIFuCDBhsBtzSpl87zaVxOPHLFepr11cX9icV/+ev/egqjDJG4o0jC81d/xEIt2pyyxz/VS15wlOu5mPysMCSEeBuaOJLzg6zsmnS2VAg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c49dca7-54f8-4c18-2af4-08d7b0763d2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 11:16:57.3988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ESYvmVGHe3r2A8JCIsb4yOowR44MhW9LSO8VkfImxNIzv7kThhpYByOVbtjQllozG1Wteck70K1Pg3JKcq9u/mL7gexpTdlN98fQxGD8skE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3568
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
