Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0661C8786
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 13:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgEGLFQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 07:05:16 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:57123 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgEGLFP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 May 2020 07:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588849515; x=1620385515;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=eaeu6D3cQg855Iw4jYj3oB0Rb7GozH4OPkO8gipx31v/85dPgHXOaZP3
   W6yI2PM+13+Ihanho/IYeDenJf3NBJBUFdvHIzpEbHr0Uwb/QyP8nD/qe
   olnv2rGg0gFw58i4M8uzjPIJPe3Ej2wgnUWo2+cx05Pl41Yty81Y4tWzg
   d7N53Cj5HM60n7jr2wCkc209zjR5HQTd5V8HaXBmOTq6SP90illp2g36L
   i/cl/ZjYXxNkALg3075hzb3YHhJYf0DCItq1dt0ndSjfRMX3p6alz2iVw
   NrqOeXhyDx0AgYIkgnIGSJ8IKlHO2uWtCibVKWh5LZlQWS0QfUQR5ARRp
   g==;
IronPort-SDR: RGk/480VWgWwQPOxa8QE+G5mpy1x2yTXneYl58J8tKuH2egYt2TEsvVPtd+pdwXAzyDEs8bwvf
 PY2S/88y8OJxM/qDYFCLoh0d3Df+g4zxO2r0q/52yB3bqF+M5IN+awsrTanp61BKrx3MNSe5rR
 oirDZ+rp9NgtkEzZgQxsPvf8nMCQsuaHUlDtkyoWjP0dc/lT5X/mkoLNdPX14v5Pk29u5V/nxR
 gGkbl6SHeEDDx1uPgf/0yO8zTY7VpWDs2RP7KqXZq7dhjr2qBMWbNT/JlsP6tFlpEwL79NlFw/
 jUw=
X-IronPort-AV: E=Sophos;i="5.73,363,1583164800"; 
   d="scan'208";a="245994154"
Received: from mail-bn3nam04lp2055.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.55])
  by ob1.hgst.iphmx.com with ESMTP; 07 May 2020 19:05:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOzs/zvAqL54jatcHI5n7+QqOQieK2kTd4UA2A1oqauKaeJrTV9Z1geuoOJEsVtlZ2MtwxJIRWYwENmGqgiaxz5EgCqt0cFBSBcex+7IHZ6XQDQ91A+/qLuXdjcg2XBHppeAnGEU0CGy0mazJQ5FEXgLQcyiLeyN7nAI9s9I2eQNS6ReEDlliBMVtj6Ph9c2EvXPgIRbuOX8NliK7I+uUVZzS/c7kmk2UhtJ4elo68NI4nvWo0P4JG8Nusj3YojfTZugUZFEIai3qCx7pBJXTo3drzJw0hgQBUXRF+QCXKaP3uYRIxHCqQLuj4sFjkgD1BAGXKHeY+dhSj/mQyWkkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=RWPeBo/OB7J3TrwLCDV1TbcC5ZquDvWQZKwYhGpb+l9qUBYg9X6kznN5HI2tuK+jKNS7H98kzXqzBojU0ZsOrbXjEdU+WtmqbNPHUnU7ve7hFNW0UEDcCA3zNnPT+VrTqba0Dg0WTM/zT7l0OB+zl3kV/iD5ex4yAwvMXSqgEzgoUkNyVU3366YD57H72VEIq6ZY63MgCxs+yZuDtmTpADIF7l0cwjeP47A49EJbDZJaGefeVTBYiTaxoTGweqHoZor0CGX9kkQXAJdKQBYtiIp7HhCXPf8IUjSS1ad5/n4Ykikslfx+qIE8wDDCL8B6Qdm2k4mrlrXc0scVw2LU4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=DpTgMojoN6WUnvtL3y8avWScBqXy03YvHISBuDjsiL4vsGX6q9aJWgT9dEvrnAM1cW3htM1Adn/KDCCBE5NJQzqbPfIVPQj6tNPNYbTwXVSnUsrH+4uC80HYJolDh4NJK8W8rBnlj/ZvlVGlv8vi8X5vtIJGxdt0mk+iT9JioO4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3695.namprd04.prod.outlook.com
 (2603:10b6:803:4b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.30; Thu, 7 May
 2020 11:05:13 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2979.028; Thu, 7 May 2020
 11:05:13 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v4 03/11] btrfs-progs: Rename btrfs_remove_block_group()
 and free_block_group_item()
Thread-Topic: [PATCH v4 03/11] btrfs-progs: Rename btrfs_remove_block_group()
 and free_block_group_item()
Thread-Index: AQHWInCD4XAYfeWld0OUIvxOh4L4OQ==
Date:   Thu, 7 May 2020 11:05:13 +0000
Message-ID: <SN4PR0401MB35986C8AB5D4CF196DFDEF909BA50@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200505000230.4454-1-wqu@suse.com>
 <20200505000230.4454-4-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 37e9d3ad-08fc-4758-9bfe-08d7f2768448
x-ms-traffictypediagnostic: SN4PR0401MB3695:
x-microsoft-antispam-prvs: <SN4PR0401MB3695D1020A9DF5BAF45CD95F9BA50@SN4PR0401MB3695.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 03965EFC76
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2QNiYBaGgdpGAPxszxKhnI9fdlokUURX2Mb896qLrUbglfDBe+uyFheNkw30g71LSPZQbYp6abtEd9uL3P57WomNJmyNIjDS9JzbPuZ52avlulshntKlh95uqfelAZRHyMyzJWGcjGTt4IgzLyQUEtL3koRERq5XegcPdcdOdGFPF5DsQYHGuE/GsF1kQ20bHa/JfqVSixzx+3qs7SCUEnp5JJrEDK3llTwbEgnOfWPL+anz3hfSBIUZa5APCk3ZEJLmaqkknm9dOGQp+b039XcQNbp9476DsW8xC4PGgA19wCS3KOAiP2CLTISbS7nzmFzv5xoWVLxqFH00TIthJqQyYUjEAQZPWUMxNPPEjTcUJCwlsOAnodZG5u3EsRz1PahpgmDzViCxTW8Aj9xYmSwODpDGkoHjt3q5/1/Aoo5RdeEUbqfLzz0Gd9+yI4E2GQ8vv5725FvDCmDL1jggjj3rD23yb2Vao4X2iAXAbO+GxL11QGn5vUNfr4VsKI/Xi1ZJaHOTxFjfGMvtqurHCw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(33430700001)(6506007)(26005)(5660300002)(86362001)(7696005)(4270600006)(186003)(83300400001)(33656002)(83290400001)(83320400001)(83280400001)(83310400001)(52536014)(2906002)(76116006)(91956017)(66446008)(478600001)(66476007)(71200400001)(64756008)(66556008)(33440700001)(110136005)(66946007)(55016002)(558084003)(9686003)(316002)(8676002)(8936002)(19618925003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: aWS9BBnHc9ZuZGES5rK+dkKwW+kEY8G50yf8e+lVhVp4385R5D+gx4qB2eXXEthvhjzK91SrSfil7X/8UJah6UNbJ5zkbT0yvZZ+jyBQhaGNVwejYOlVwUimBgWRK00IFsDnKZby2UM7aZTd4QJrjj1isoYRlkZtPP+Hx1b3Gjkb81cJD4HL2ocwKcTIwl0WFTzabgNQRRwwlVX6rGY3pGjkQFpNec0PjmLMyGO6AokLLjVKn2KrGXHxafB7KDcwmzGA8U5CFsYves8vVi3ML62HZpiWD7qWRT7F3v/i4OwWMMFz3nTWXQ9/3vkMyih2yeImFwoiTVoiDf4c17N81I3DIRmbwhIBu/yZ20lk30mbicGsc29Zsah1la9RpTaKUEvjjIwwLjfc9DdEvb8HWdRztH3Ih1j5GTXS4AB2kPlTMOfvxVsjPqhwrfTWUSUGmprbOjN2mG1ns84NqK4VY8Pg4Cbuf+wIaG0CIU6nQmPJrzafMqmsVsO4pC4dOdPE9BvMJR8f1LHxP1vBD9FgB0Tr35djwF4r1zUjgDoZo3Ie0jI2MGL1mFTSUwjT2fo+z1lT5VSBAga3GNjU4tWbuOtFOD/MpUOyfCs+kxPqVF8UVyfjIceBItz0zcTBBcsNS6ah1AJSevskDr2iivAvbVRV5rxg8VmQ9PyLOWCbnPx7O2+bEkoPnUfOHzvMqzSnS2CEbz2r8LafaDrrLaOW7EPY9bagWwH5WEtE9oDUAKzRFYpgTJwqXrPcSdQNJqR0lscfsu834BPIiByJupDZIgniSpZBuJnn1MOLPOi+xCw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e9d3ad-08fc-4758-9bfe-08d7f2768448
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2020 11:05:13.4269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HO295bCfz86xlUj/a+kjqSumWJyUbxYdikT5x3hhkM/HMAVEyWoTC4jj89ikm/1V6HLCAznxduGHLcU+fyPeKmELfwCYE4cnqCh2AMcDenw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3695
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
