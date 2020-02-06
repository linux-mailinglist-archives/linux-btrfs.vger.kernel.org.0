Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50B79154514
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 14:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgBFNiu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 08:38:50 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:63359 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbgBFNit (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 08:38:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580996330; x=1612532330;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=nhnCxfysIsXBjgqhm/QuaToUdJEQdYGZl83NwYcfYehcwPIhK/DsVEqC
   7Sj9hEes64FUPlKxWDAEHwGMVslTC+NwPLwIxzenjYExcE8WMsSKNoGx3
   5WDfs5h8RYy8sQqJQ4wvdjJ2PZkFObf2Da8Xu4J40l2jWEP8Tb0qzc3Iv
   U/bhGnhX+4cc1x74vbaj/aqAj9tc6IV+l4UVcpfe6wdMtu/cEFSICySa6
   w/39LBzz9R+FjHJzj9nEJX7zGmkM32sXENjYpc09JkG1YvecMSjnH2aQf
   lMiR/+OCPh4ccWmyd036fvUPZ3u9XNnqrgiqd2X2+Gz72cgiiSBNsyKdV
   Q==;
IronPort-SDR: xAUgtnqePQ1Mnd4hW+QnULk4SohMy77MEXHpJSI9/a+uGot4HsdCZM6sDvGFFCw5itdsEWC7Gp
 Wtkf2kwY0I2mycVXJlDC56ZYpdiPRkbSuiti5YUpMteHwAbBvgSn0ZGkFkU+FI9jkP3f6A+eHq
 91NhngGv8NYQEM+CKjfhYwYJzN//bSkYlB0Tnmd/agQF9uforG+xAcLtpBjE+GRmvHkmpOs2SI
 +jWfQikgaQO3Dn4sSzICJOSfZDAjevuGt7RYmzvLzUs9nVhGsOJCSS9MkSjYRfl3psXObcwyj7
 hf0=
X-IronPort-AV: E=Sophos;i="5.70,409,1574092800"; 
   d="scan'208";a="133603832"
Received: from mail-co1nam04lp2051.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.51])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 21:38:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgnpbGDk5E3Buvo1QuvBrIAKPwjGtsIk9P37rZUGaI6BzwW4JTUdmPrQ6swGfFSKXTMAyBBJqNuoiohe/UEggiJiKkCOVtV+R+n6YQUZwkMbM/oLKRwn5K2VgRRjZV3WNrStj+8IicGH/5jPKN6NWr0rWFogphwPvWcWKelNfXuVsdqBM9Nnwb3ij+puEEERu6Rj4gG2CpKjBlBQDGamvGcdHXuMhdI40u8/bca//5L3Xh+kSEoUteSWxRNZDszx5FaCvlWRmYxFwvVsKRB7uObCCEMJeOPSjbTLewe9lXZX/SKhIjikaewjmQmYCsdjthiXL0/yYeAe/yX7kwTRJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=MmiG3yuZcwweXq11o65UBiGEuxzlciZVj/TYzLBBRVwe/wq5d444IWQn9uNm3ncSvdqClPHB59NRT0luI+9ar1YlqABjGToGXO+kqvFB9tDKw0qlkWyAZnO9wc5WC9NbI/apClh2m5KkCNJ8RqCBLijwD9i7n76NRL6/HZsZjsmlVeBIp/+bSvB46FZqxW2fRjTMMOEuG7/vYkp68JOZfsoFuriFXc82sMHGq/+Fw2bexW+Qgj69MIfXbd3rlKDIr8Ms/QkcL2dA8/cgKa8inaHBPxWDGVLigLE713k4vHVs4yLFltSHfwrgMWOb7Tz6JsxurMacIsnn82Ooc770dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Ty4jbHmZV2/dZxon84Z8UTYooKheOj1eL8kbfi51Zr0w4vcz5dHYUwgnVXFnK1DaypuGJlJJJT8bm91RK/IInWpClmsc7mAsQBpUb8khAq4qbkhS85u9somCaaGPI4cYq09B4GLPOOyenqQDPLB3PkZW1L6/or+YnkM2DxLB2jY=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3518.namprd04.prod.outlook.com (10.167.150.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Thu, 6 Feb 2020 13:38:46 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.036; Thu, 6 Feb 2020
 13:38:46 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 4/8] btrfs: drop argument tree from
 btrfs_lock_and_flush_ordered_range
Thread-Topic: [PATCH 4/8] btrfs: drop argument tree from
 btrfs_lock_and_flush_ordered_range
Thread-Index: AQHV3E92wHRT7mn10USn1XOPRBmBzA==
Date:   Thu, 6 Feb 2020 13:38:46 +0000
Message-ID: <SN4PR0401MB3598B11099ACA7221AFCFB5A9B1D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1580925977.git.dsterba@suse.com>
 <21ce9d3caeb6e8f303f3a1322a0728ece99d5bab.1580925977.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 76109bb1-e830-43db-07e7-08d7ab09e432
x-ms-traffictypediagnostic: SN4PR0401MB3518:
x-microsoft-antispam-prvs: <SN4PR0401MB35182C60AB0724F3D97098699B1D0@SN4PR0401MB3518.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(189003)(199004)(4270600006)(110136005)(8936002)(316002)(52536014)(5660300002)(8676002)(9686003)(55016002)(81156014)(81166006)(558084003)(478600001)(19618925003)(33656002)(186003)(7696005)(71200400001)(6506007)(66946007)(26005)(64756008)(66556008)(66476007)(76116006)(66446008)(86362001)(91956017)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3518;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: klEmio412nc2tRWGszGPQTqP/7EJNOX2TBAKB/NXPFYY2i1RIFnOl0H5jYtxU9G9Kk8rAQvqflkeGzh/395gg0zk8g0BkeJ2gpowTT5/dABA6qr9Y5BB1NDjIOHq7VtKfp6OdIc4RL5TnNu0nXvZPStmYi4Ul3XsV14+LHSwvOcGqTEML9CZ9M3SUNje1JM9I0w74R3iKtlS5kX3cyubudXKPvHhhN5ImdRwm0ujXMEvXwQt74dGZRQmN9nmHbi2X6fcg7gH7b8oDm9ExBmAj0OIjdkZOXHxHUT4m/Ccty9RSbIAEfAjqYRK+33DYCSeKELHt/wp/YAg+LVRB6ue2RPw0UZGrbjqZ2JYZdLSmRLyB/BTVrQHG/cbPg8rU0ZSt3orAx6L0Gam2zRA/IdzrkDJzo8pAs4oAf9sUuS/BdF7XCKfO74XJo7198pShLZ0
x-ms-exchange-antispam-messagedata: 8CURP6368qtjS6oCzEis7xcQrSCj7brV+dCPSNJyohFjB+dridTSvLO42gkxPFfqssaarqZphRjGpTLkPKefsFMumUD5ZmwhTRhWDiwUVOLkPxeq5s5kcML9RgG+ZEel+WywTN41z1M8PftkTQHkcA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76109bb1-e830-43db-07e7-08d7ab09e432
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 13:38:46.6944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SSqbzVEm+0eR9PkrRN2vA+6wajmhFysZmyfH9sonVCrtBl0jA9/Yz+zNVLduEzKEO3CmEi6zS0/ek4ryz29iARy52vAGonY+rFWyaDQM9y8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3518
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
