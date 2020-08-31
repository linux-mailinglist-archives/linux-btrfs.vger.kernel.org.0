Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40AB2578FD
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 14:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgHaMOQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 08:14:16 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:40274 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgHaMOO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 08:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1598876053; x=1630412053;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=NNFn/KAH2KXH8fPWB5frUhIouh3KXYZWPT/KMbVq+J2SZOQiHQYcy/9C
   n8DZ7n+l6lHEhgYF13NQ4qbpRS+yTAgE7kuIfEQesp0ABQfY696zTVn7X
   WLjKqJnt7o3q3fmvrFqmTMFflPbEPKc+9bYkWr4+HkjHO9Vgh53U9nscg
   oltOmYGohButhFm31KABeXivYWoGLAbJ1/aeyuA5fK9GeeUJIuo6tnqCh
   XRAfR0rK4Ju0Z+3k/QjVYSaF+zvi80HJUoE5DlIpld23x0Gojsz1j9EDG
   Tix1fQQuRDqjKPoQ2sJPr3Z86E6ir1z7EQYOvcqHVmCLmopN2dGZ/QR0L
   g==;
IronPort-SDR: 3UPG64m1CwwOBDfOw0/hWYk4EETpvwTOnxZLL68L3JWNUKYORDSutjZkCKZBbR8+dT/BK6Xj8f
 ksHV+rXV/xfgfl5DA7q/APDgFan/ReDBGy/mCq5fKw0MlqXL9wsdt1t4wXxqnedAFyk9MA+C/c
 ElKc115yR7gc4/psxC4aUPJ0T6x07wCRGlnXlg6Mpda4h9Q9ms7dDHc06HKahMY+0BbljLIpUv
 FmqO8n17WmmSZculV9u7WKHuNmEhAASWpO5oGqdm2Il2cL3vNdNIRWI/BYhytRmDmwyNuMPbuB
 wZE=
X-IronPort-AV: E=Sophos;i="5.76,375,1592841600"; 
   d="scan'208";a="150558984"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2020 20:14:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNQaItrhLhmDxYwj5MlQwgorGgWewGfwt21bHovqt+lNZV+ByaHnexQWskknRaDBVsOluuk4GqaemvghzD6Lp/iSRRVPdI1PNAUgWa8SWjH7zxVkKHOErHRHLj11KaHOZQkjRU7kcWMthhuoyEDAIKqyRZlybr6W0mZ8Ohle70uoCoxpWagFh0dnI9iwnMwS02zF81aGohpEUZRPLpYIkLyQsS270rWdZOTvlwfMYMKRNOGGqs/JyULzwONh7zvoJtoPiE1+3fDFIUAlx4BDz1a6CcZJ3uWdYgCmh46dFPAQVGJeho11tFzhYY8Njcy7Ykxc5L2aXVtjOqie6cuJUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Arc9rqtRIaxQwveLDvnxAbZqkniEymNZMS8SUdxIqrFACvuvzbBrGum0HqQI3guxpJUqB0NY0LW2y4U0tT81iVh/rzxMfq2xQZk2zjpeZdAfGR9XoSPXES7Iex6Y3nbj2ap2QQ1ihQNc0jgo4MzQ1GxvJUw+IOMexpZ5XjZiSOi5UWOujsv4VSdw4iK1aAX7eBwlRfWYK6GMcDlru6E9SbrNYwvIWPjb6R4mxk3Tcmg93J/zL2QOuiOiL+51aDNCyRCvBCEkpU216t8vsfZto+QbppFoqrEgFB8APFWKOzRrr+YOL81v0pqcgLDdIhy49WtgQNpyyWFFp776nj3DJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=EWCtmKXtTXalFf4WeH/QKJCXBM2v2X1zOpqB1jMx0yaPdboyjC88FtTUkgoVfrI4zTtCh6Dxc8u4SDl7tLqkVRho0ktUYv3LHQSOlcoHp1SJjZZqPgdxOTpPgtlfJYcohzniKZuI8MUTs3AdoLoy1Hzo/q6+E++BeOLjroNHVGY=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3518.namprd04.prod.outlook.com
 (2603:10b6:803:4f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Mon, 31 Aug
 2020 12:14:10 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Mon, 31 Aug 2020
 12:14:10 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 03/12] btrfs: Make ordered extent tracepoint take
 btrfs_inode
Thread-Topic: [PATCH 03/12] btrfs: Make ordered extent tracepoint take
 btrfs_inode
Thread-Index: AQHWf42D3TEsmnAXmkGNbqrqJFQFPQ==
Date:   Mon, 31 Aug 2020 12:14:10 +0000
Message-ID: <SN4PR0401MB3598DB2BAD9B4206C06069CD9B510@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200831114249.8360-1-nborisov@suse.com>
 <20200831114249.8360-4-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:c51:a08a:7ebe:d4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 603b5e7f-4826-44fc-2352-08d84da75dd8
x-ms-traffictypediagnostic: SN4PR0401MB3518:
x-microsoft-antispam-prvs: <SN4PR0401MB3518051F2CF28DD9D2424AB89B510@SN4PR0401MB3518.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: czueJGT5kmWS5eZYkGjK5ILoEL5wJBc9g93YpA4bNyaxWHfQgSk3EiBCEFfKCFO9vqWLJRxIH0gRhq2DPxrAZoBTF/paBHs7LnN23QZQXMiTLDZPhYw+ZGMffkwwiZfRDsT4Tk/fSImf3ZhW9SXGPmzoK+UE2P432I314IduK55oaHBiN98vtvy6Rl3I0PJg7+oH2V9Cv/q+U229kz1srno7+eT3SkHjVCiFLwt1u7qkKEl1RfGha9EYg8Vsux+siKCb4RWUUYWa+einmejqFXoj2ggqx9HQUxA9FT6Hi3D58tx/x8EE9lq8fncN5rhtuBoKxAZBjh+bCLSPAp2TZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(5660300002)(316002)(33656002)(2906002)(55016002)(478600001)(110136005)(71200400001)(52536014)(6506007)(86362001)(19618925003)(7696005)(4270600006)(8676002)(66476007)(558084003)(186003)(8936002)(64756008)(66446008)(66946007)(9686003)(66556008)(76116006)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 1luP/Xdkt9rk09q6ZjO4M9x7fD8eQvr/NL7h3e6WqqcYLLkz0BlwMDbr/dREryNMD508OdCNIZ4UjO9GEXw0E6z1b0fQ8OwnfNnCAmj+FejLwaLvHPvPrKEDATD6d4n45V07A9PpG8F2Nw7D2tN888z06iJ9W7+qCpZYf+apbvCerOeUwChi+qx4EbvvRDmnjbiwt2v/PomQyIooXh2l3FVm/dK8IQA/9CZnVQhuCMRsymLKasZ64DVgyB+fCKiIeYyqULo2dp7BteW2f7qxttoWCiB4Yvpjr8RE8WFc8tkDjWqd53oEYpSUfIoiMYya293NHwWMWckmyBUIw96leMAnmgffxfKAghpWLuhOa6J18qTBMKRJ6NlEpQBDLnKVtq1yZoZuDnbhedp4zU5JtttH3oLU5ZEtKZ6T77Ud/2/Ti3kpIKDitvavKkngePxjGluwwMqOynRi0zs6B6kzPzc+2yDcTR/KuHhhfJICDHzYsp4Wfm4aQxLA49gkGyCB23ZPqTKkHQ9lWSoQZSL3b0/YANXZDlbXlaXFIHU+31F4zC7baMng3mzsaZxLQ0en9Ghp3eStp3oMKlwAiFr/XWjMwuaTfUGQUzQhH3JuDyiR6jjfLU6Yc7lZQWJsoLHouSZidnVX3k2/bhctWg7/WeeZUpt27UCtO/bt+u+Yhf+EnQejnj55zq0nyIbf9Vze3Pk7R20RZctrbdY5bZAhbg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 603b5e7f-4826-44fc-2352-08d84da75dd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2020 12:14:10.1108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2bTSW5t32vBANgYYiPAFQwg1j3d0iIBNugOYM13nHhqqaMNQRaZuJBBCkeR13qNp+gxQLa5KDcd0AoutbRcjv+Sp0TfoXJEnX3WA5JreHuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3518
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
