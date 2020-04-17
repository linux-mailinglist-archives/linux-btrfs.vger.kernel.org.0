Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E661AE421
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Apr 2020 19:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbgDQR4S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Apr 2020 13:56:18 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:45398 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730033AbgDQR4R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Apr 2020 13:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587146176; x=1618682176;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=U/I41n3UNVpUvETL4JvSFrm+KBXlIxTzoFT3ZaYt9PtXsGzYuqGZLq+l
   WWpbBSoYLukB26JC0hfKNy/a/LAjf5Vw40vKlbsQTREunKK21jd1JemBC
   +TRGJitK+MmhAbZl3ImtWWljb+ciFWFeqJ6tmmhdKgjPVnNTWomGNRsTF
   pgLJqQmwTcpnCJSXXIUFw6niKvqG2dwUss3uPi7km93tCKUQOjDFI+AWn
   L+ydbKGwisA3/u2HR4kX0E0OvrbqFVgjKpF2efjqyNo4OFpjhLAGTedDB
   EsHHMo9BnJgaspMsa89YWi+IwqMnocrcj5U+/u31TOuTTUbKbeDR9Y67E
   w==;
IronPort-SDR: LJdFEMwl9LWcPOr0PMlbljFzRd4WP38M3RVY4BCkyfTLlxKw5UFh1Hb6zAvBlivdlVrOQha0RD
 VdFHy829EkGzdz6+ru1QuSGTaoaU+QSO1VvVDbF8ETfSexstuqB06IYyBgOk+f1o2WIa7er+Jk
 ibh4mEU9izs6kO/F70yO+5Z63ad5SztY7qyutSb1uI1kS/j1KwumjZSLfyVByiuxUukgzKHh+N
 FJQPw4zeG5RKHW0JAVwyi9R54VJgtLjh3D0uJh/p/8JCe1M/JrT4SVkf6G3iWsT6iVgkNsq9Ju
 WAE=
X-IronPort-AV: E=Sophos;i="5.72,395,1580745600"; 
   d="scan'208";a="135581877"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2020 01:56:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHYjJ1tV5ZDJUent+9taNkog8GCqcqAlvPrUpIJZyQDvVgnGaJBtgCTaSUe3oNP/08FULggjglgqQxHbCaICa9h39FAVeNmgcgDdOGMJtzXx5vbHsiO0PzOeDxr30wVoN+Hcpvhg5iy/C+jz3t4vt2GoPC2cI0IIuAKCbUKHzLHh8gxxM5SvFq2jbNwXax/qa9wd1/vmMzsNmnfC8xCb5W4cxJV/Kxb2Wfzk1V60EmMJzodnq7FDgvXD40ccjnxe3jmf3JLjd7JaMRFtzs/9XSzUPq4vHLvIDuXto/XRWWarAgmUE+ZtTYlCXv8/rjiHYRmfQWPixYBWvmf1TxsCQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=mLualJeXHHorvj+C/0GBBGPnjvaYFfGXD8cw42f15MZdKtXJF0s1PdaD1zMYedlbeRbnyx2QFn/m/1wy+n9T9brSZa9mtNeGvN3+BsK3dn+akr6aGrMtK7s0/Rwr7eWtyTkS7L4+VLjNXKR2FtMZFXd/bkI6Oqci4uHdgO/BMVasebLP2YpUteQWySZrK4uy9cYiFwsMuixxBzSXUvi4+z3QJJEoufSm3Kggv1SkQaVdbPs6PIGnWOLT94JKOfloWYvAKBcYB6sUzFUGZrLfpQvzbJhUoqrhKoFz6cEgzW8qHB+wveK6dbj61j2y5ntmdBOOYy7sOoneP4SPAAQskg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=DaCfOOYGUli0sCQQSEPrjG4dq8snow3fn48BcjBEDyLj4ZqvYAJXmAqq5daAp1fUuyuc3q9GvmYYaxg9Kxbnus5yzHmiexzSfd/5Q68Yn2SkGf1lzqsYfSUhhCl3ifBf7vFgSHG+30RKIJR0LWLFQ6rhRsO57Vnl95YR5tPsQfM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3583.namprd04.prod.outlook.com
 (2603:10b6:803:4e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.28; Fri, 17 Apr
 2020 17:56:14 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 17:56:14 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Omar Sandoval <osandov@osandov.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "kernel-team@fb.com" <kernel-team@fb.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 04/15] btrfs: look at full bi_io_vec for repair
 decision
Thread-Topic: [PATCH v2 04/15] btrfs: look at full bi_io_vec for repair
 decision
Thread-Index: AQHWFDiqQv8JlQ4GQkGFxsCYkGrOCg==
Date:   Fri, 17 Apr 2020 17:56:14 +0000
Message-ID: <SN4PR0401MB3598DFB36D4C07AE820B02D79BD90@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1587072977.git.osandov@fb.com>
 <fbfeded0671dbb2ef682478aebd5693f96fbdeb6.1587072977.git.osandov@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 600fe50a-6c65-4d39-a428-08d7e2f89f57
x-ms-traffictypediagnostic: SN4PR0401MB3583:
x-microsoft-antispam-prvs: <SN4PR0401MB35832A51988E7C2263B480149BD90@SN4PR0401MB3583.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(81156014)(316002)(55016002)(9686003)(8676002)(8936002)(26005)(64756008)(66446008)(558084003)(4326008)(76116006)(6506007)(66556008)(66476007)(7696005)(2906002)(19618925003)(66946007)(86362001)(91956017)(33656002)(52536014)(5660300002)(54906003)(110136005)(71200400001)(478600001)(186003)(4270600006);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ApQDofPcc+eYLdWzMivhfFbOLmJujLa5YZ1Y1Jr7YQwLAHafh3nP7/0j+1bb/Jd9EXPN2OCEkHena63jlGooCiwPeaiugPA2ryJu1eLBvj7RQWOdn5OCht929nB/JNCMKvKk2kJ5rFS7qFdfOiUnPhRHDyRi8e51uLI8vPoB+3bQ0fb/MGRiQ44uv3Sww5F4ue/J5/MyeCloiQ7gNZgshIcEfTGVp00+qq36V19Ode6hzxUE+B+rIympAbZOdBIUdmxSznN+UbDBgl8h6N5aXJBruokwJylxUdNBFSeooWCtxoXiuZ+Rg9T+oPg1DToNGHjc9SfXGe/cap1gNTbmKO0AjEFmTXCrY4p9PMnpA6/ZKMawNRzLO5gv/Qu++Ce/fjDmZAG6OVch6Ww2zoqiFCtZZBOPlIaBgJwywNfHzcc1JYBudy+JOqYvcjtJkay+
x-ms-exchange-antispam-messagedata: wdidVfYIfKSXkUb5ceAw+3DRvyaoZkAm3UQielzu3aX+TjH+AoxOatjlXlr9SHBrQ9Tz1SQZPI1Dj8AtatCKsZeMmZvsAtpogrhZqT9Gkcvs96QeSzNUUPa8HDHlCTgaNbMivSxZugSMsZoD4y8a+g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 600fe50a-6c65-4d39-a428-08d7e2f89f57
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 17:56:14.7830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vwXj8wkJUs0GKkppDCtj0MmvDUqRpyDMma+GTpRwicP2budAwtDZ9iOhumhRqqInnI1/dBRd4Nxs4bQgorj08leYrBkOy327+i88kp3CRL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3583
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
