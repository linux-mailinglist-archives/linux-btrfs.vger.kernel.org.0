Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3E3151FBF
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 18:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbgBDRoX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 12:44:23 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:6921 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbgBDRoW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 12:44:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580838262; x=1612374262;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=Jd78e6PU/PCNPBG7oQrARAGlpa6FehCn79vXrtm/C6C6Pst9Z56DMivD
   vGSF1jbiX5HcApdXNzUhFhJsLqv4+JS5Q4l4NSGDDdhg+EhOjSeUf9NXh
   Vnc3JylXngMyMWxZLzgWqGa2R8rETutbG4Aqzkk+LPwGEeh50652u85YZ
   QT+KNNM80bET970jsD4Bpv67rqRH7MHwaXMdaOi4v2ZxkstxGWXJQ8tmc
   2wpJLwxxwfm5F2020UFn9t5FtwfdpMq+tIcTb6QQF23ampF8qK32gKD+5
   PZMbXl2+mQGVLA0u+xIbX5iPO52o6dA+C1uGWL76ccjc4DSCQvk6/OIHR
   w==;
IronPort-SDR: 1Vw5WVtKGxsoAAHJ87PTJY/hzmrBd0VRkAVU945l9ama68TUjL/gOzEefccq6BPGyKwWsN405n
 fl7IrVYfgwKcJtSryvEYi/2L9+cQQt9KyOfS4ZYswjKLcU6c8gYQKI51Vv+0+278xtNePDRllK
 yA1mX3kXS3pYEKw5He+1/m5z1HINQ2R+dt22cimB9enEuRfcBz5NHLIiJObVT3S3hQ/9PgvOwb
 +KE35YElSYqIszw+BueBD68MFSJCgwTq2RUYdFBwNywC0xOdCy3gEHGLr67Y6KOWnql+vmW2H1
 HYs=
X-IronPort-AV: E=Sophos;i="5.70,402,1574092800"; 
   d="scan'208";a="133436334"
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2020 01:44:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEHLDiWzxwRCOwI1XuO1TI1tjNaOC6JHHP+T6sGdNoO4MtQA+20msikUITmyrb60ATHkL9wppFcBbee4kn1a9u+Rr91U8svJ3dD3nUJORh0cWGH2cEMFpQBr0q9S2Aq0OWcOhFzNPLiXrkb8iSpx2WmAYi5OZJDeKbsRAhX5I08gjyYvXTZsarv6IValJ/i+BP2ZXhm6H7mIDydr1416keCeMG7ooT9P2elJLi917aVL7ekxsiBU/Bf6Ogh5O+ye52A+VxKRmUnKtarJ62TxqeHXZLqi/3JCr7wyHsTL4noJ29ACCEt2p+SDXV+p5wkl7fGXe90MVcodNmeF9cmp0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=NOTh4r1QYdf+8giGnGXF5KLFZrTklPaiRjHdT6x26YhMMrOA73x2eIrXRRL1xt4/KqVDsfkNJAPYb9hpoakMOWLNkHMOYTsIjLOQBIg+ANtUDP4Posn4GgMFJ1b0+hyM1jyb092psIs9x0ACa4qbjrAS8nJYQJ8UxGMZ/jnXPnaOiBuqCPphcOUjAc+znA9EPUQZHdjudtI+FgxP8HP7W0p9zO4YWox6E1r7O+a8O12BbPd4VMoa6l3hG7AD4QXZqJdexUVgeFBjMLrupEmzGuVtgiONMfr0KguKli6DoMVi6I1jYUoK5fpWRLKaIixu+Vv4qcR0GXmicvnSQ/bPoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=nCK6QOWxovFn3LeH21/ggZ8k8gH1qZ/KOhCizpGfZddnjm3TzP8zag3x/cPH5O1LXUYRy1+x2f7D+PHDPE9Qdw2TfqoAHDpC9lVhcL5KrgXXsHZnCJJMgi2y894l6qzjf2aDXJCpjJ46CtPLmu8jCfiFAVOO0VImK1bvHtTRuCI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3662.namprd04.prod.outlook.com (10.167.139.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Tue, 4 Feb 2020 17:44:19 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.031; Tue, 4 Feb 2020
 17:44:19 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
CC:     Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 17/23] btrfs: use the same helper for data and metadata
 reservations
Thread-Topic: [PATCH 17/23] btrfs: use the same helper for data and metadata
 reservations
Thread-Index: AQHV23cG5PKV3ndr40O7ipMHO7yGHA==
Date:   Tue, 4 Feb 2020 17:44:18 +0000
Message-ID: <SN4PR0401MB35988B8A3897C4F90DB1C93E9B030@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200204161951.764935-1-josef@toxicpanda.com>
 <20200204161951.764935-18-josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3de6313f-506a-4d2a-275d-08d7a999dc84
x-ms-traffictypediagnostic: SN4PR0401MB3662:
x-microsoft-antispam-prvs: <SN4PR0401MB36628F67DF42EA73E6A0B2D59B030@SN4PR0401MB3662.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 03030B9493
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(189003)(199004)(5660300002)(8936002)(9686003)(55016002)(558084003)(86362001)(7696005)(6506007)(4270600006)(52536014)(186003)(8676002)(71200400001)(66476007)(66556008)(2906002)(91956017)(76116006)(81156014)(64756008)(110136005)(81166006)(33656002)(19618925003)(4326008)(478600001)(66446008)(26005)(316002)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3662;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4EWyr9qVVZ7b0CSzL+eiC+gO/qR44i7O0ibPZCau3ixQUK4T9b4lfLjU1jZB2MLGBZlnFXoe5xLan/qMD8kKJ3CsKtENdcTMtp1qcA4E8U47FIWnxX1HgpvzXZrdaP8HFZ3zDYXMfstZ2FAmWw4haudliQDwwWw5USBTLndglwdPdP2fJ7UOXN5zJn47Jgh0kz3U9C3LXZJ0Q+49Tr3PTsdOScRZSJDF7Cf4hPbM4NJd8EFasyYa0u/5vVjELpDLPfBdIwlg4HPtsh/W0VYuGbsxWCYGW/Ux1KfEccN671TEe6/bigvHk511kZE75mLgz1KvtrTU29Utzek1eFFwjEgAt9MnygLfgYNO7gCvvdlJxaLFWB4djrdFoL9A82QeuwXlszCvCoe3R/azk2KF1/IKvJPQNEbIXU4YiP0MCFefBEJ5y5ro7qW0SBxX7uS8
x-ms-exchange-antispam-messagedata: ZUjcQMyeYFsHioXzcxIHjJ+jfwW1oU7PTssatXyQpK1sMKx05TphXHdouIold+MzVIuElyQYc8U0rVMxzbgqQoJpKvk8igkHkoUN7QQALd7qJHtg66rYuwrfQ9vQVUY5RIVWMJ89asn2dXJVUkLL6A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de6313f-506a-4d2a-275d-08d7a999dc84
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2020 17:44:18.9624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YvX/Aqrtxfn41Dc/ETZmOk3VhKkupVR4E3auqk7YfgBMmAn4Ygp4vu4787TIt1FR4kbJmEUxPm5ZtxeGsns/fCGg+rmzPPO3yiTIihiEiFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3662
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
