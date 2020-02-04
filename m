Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAD7151E8F
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 17:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgBDQyk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 11:54:40 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:46724 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbgBDQyk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 11:54:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580835279; x=1612371279;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=lEMDIIOlLuCmHiQUFRP5BTDejW7oVzIzyQoIRDt75KRIe15tA+gniDLP
   77nEyMSLvU8W6aLKE9EhT+gmNhPjSoCtvFD8lhtWMK8tOFOqSbRO2ORi8
   l2Ap+pDR8MOaK/Un9hkYO7+LNCrYdMLaG/RcD8r3NncV5oeZkm/FaFRTr
   XwXstJX/8c73yDlpmRz/3EsRTUsWkEqp+sMPNFxb8UzjM/OVCRJ6/MRa7
   ABxX+w04E4ortdbkBjpPQl0/zKDfY3v6894nF7vSVovr/+pd2lGG/yK6q
   BO6ZpGRGLRS0ROxEDeXYLpwiyJI4cB7Dmpd2erNKz399XvOHnkY+NeJlq
   w==;
IronPort-SDR: HLi/sDzuEwkpGppw17H3pJhxajfQLYhvS5q3S21FaKxoJQwnOgWGeS38bMkG+C5HjUbCrMIBfF
 vrjtsDbKNAQcGD6ststi+2taTdTSgszHAhpxlt9J5sjDPl3+mlgguHnjCrOabnLOzt/VKgSJQn
 G5ou9vaSPvXnf8TJe8wL+EKLs5+GkIw56TG0as+Xke4BH2SKHF1mBLX3hCl8BpU4HN9m3X0B6M
 BwNCkuNhmGQJylHsxBokcJZoEjqtgzrLYxVpa+BqT52TWISX/bN8Uyth3kpqcMddeKLPsfqL12
 314=
X-IronPort-AV: E=Sophos;i="5.70,402,1574092800"; 
   d="scan'208";a="129076609"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2020 00:54:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+tyzmOYfFnYW3JAAJxj36RNUN2+9CvmNZtqG2fhKwqQRkb1jqY5Hn/wNlHgMo5YkaqjhoXAIM7KIJAOLiiiB01PVewZobdWoKMEns5QFZybhiv+CQj6uSuyGyD5gUnXXI5rfOhq7hve4XAdCKErH7UwHuyUKC1G4WhQltxqys8KpMKv7cNZKNQCFzi3KE2pFNvemqzp2RN6ENv/H6RF/EPpzHbKGv/+yothJeqggfWHH5VbtcV1S9TJNXVWoxlqNNp9WolkzHibHpz6V2JwIEQU9RtA40SrzFnzigdYWCu8ogR6Xb+lSJKf5e8/mZnMNfiGd0BsHiKnVBhOMSS/jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=mKzZ7oy5opdop/TIonWADUixhRHUxOP6tvsABCKUC6BZeumzmUQc0CReZ79EZUlnDeoDzALdbOrXDQhfkLmPl8AOpjz/bP3YQ+XT8f/gFeu5wmZMePWyc0CJ4EXPv/WDJAru0TDamrqyDQecEqHCkJhK90RgCPZycD5auDMe6tCaq1iBAj4GWjLYGqfRnqlelNpohvJVgPlJdg8jR39ZtnVFot1r7vOeheunWyNYNX/V2rO9cOYDT9tv0o3iuQrBV8Rt/BBxR0r2zA55dYfLBZjkIw57F4R2gc1gBkvQw8O1FALc/bMbXGYE1Akkt2sXAR9aYsVvaLnSUh6S0014zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=s1FsWqYH3v+c44b0MT6gc4dWeuqvxNjcO72fD9+yL2i94S87u6Q5+05k3UGa1xn/qj80vCxpKByj4OqyqWg7DAdcxsai8sJMCw+yoS9+D2ycQxLsSTcazf32+5Dj6Yr3ek+cJ0q7vGKEPZHVfEeq6tC/WuyvDoyUEhAmMaYlUfM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3678.namprd04.prod.outlook.com (10.167.139.156) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.30; Tue, 4 Feb 2020 16:54:38 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.031; Tue, 4 Feb 2020
 16:54:38 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
CC:     Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 12/23] btrfs: add flushing states for handling data
 reservations
Thread-Topic: [PATCH 12/23] btrfs: add flushing states for handling data
 reservations
Thread-Index: AQHV23cYu+J6BBnH8kCTq/UkKUUcZA==
Date:   Tue, 4 Feb 2020 16:54:38 +0000
Message-ID: <SN4PR0401MB35986B67B0132E870DC895379B030@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200204161951.764935-1-josef@toxicpanda.com>
 <20200204161951.764935-13-josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b4bdb7bb-20d8-4bfb-04bd-08d7a992ebf2
x-ms-traffictypediagnostic: SN4PR0401MB3678:
x-microsoft-antispam-prvs: <SN4PR0401MB36780EF6652BACD18D15AF109B030@SN4PR0401MB3678.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 03030B9493
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(199004)(189003)(55016002)(8676002)(5660300002)(2906002)(9686003)(81156014)(81166006)(8936002)(52536014)(86362001)(110136005)(316002)(71200400001)(66556008)(66946007)(66476007)(4270600006)(7696005)(33656002)(186003)(26005)(76116006)(64756008)(66446008)(4326008)(19618925003)(6506007)(558084003)(91956017)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3678;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6fuIVCkGkRt1FdWRfqqEE40Sd0aH9/Vc4sjmrZJ3xdNpsAonxPUXW96l/Zczv7H7Z7SLsDjb/Fkc9SZinxd9vcqwoNJ7sQsWtRTa/nP2RJyjhOoiLGI7pZlPUdowLaniL4kauh8bQYZE4lRZq5irnPPDjVdLMrU06D3b9eScefk/yt8mEWG7BF+HtECDFvzHdCBzUX+XZnB33PhqS6Xdd95GFm1d4zNHk8OPz9DhnGfUxtqmfGQWZ+sOQL34iSV0996ZOxGWwXKTanITQzzcyu52JInJVKYJJUXz7eyHdgUyVvNel4hgpuVRmhqnVnxHsL/8dhPJSnxgAuxTEq3qCRFJ2/Nmn2XUEGk/fGcpDOXTPF+Ti+zhD7LmBZ3t1j7ZK/QlOyCchTYZzucebh4OBesqlkcXDg7dp0pHQBfayxc/uFQY2eeTBHLWdCl/PJ79
x-ms-exchange-antispam-messagedata: BcOuNm0FPIYO2mt7wNDTa4xdhNtOiZfn4IZ/uEcM/pQuqaepcag1ljUX8Gn98BWmkKfy8eAfUoJY4Nee1t1hm+BHFeSCKTjVodAeSu3bDguuTuNo+a2Vem/6kDeenxj9XVWN7bFzTmlsZet3Q99QbA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4bdb7bb-20d8-4bfb-04bd-08d7a992ebf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2020 16:54:38.3421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QRyf+epFvdJuTbYiMf7geai833uE7XMdrboYF6SD9dd3JVbzGFyeLyB9fECm6KfvSPbgufuJcnq1Jr9EEk7+NwOhPKt1JHF0VeMe5dPSF7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3678
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
