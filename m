Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08326257825
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 13:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgHaLUy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 07:20:54 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:39703 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgHaLTS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 07:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1598872756; x=1630408756;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=DatvLbGHuuYBmToNm9+CjBXfkcTYNU2OEj8kNqiY02R9VQGzHOd416/y
   zIjevWaus24Jw4tICpCHfpOL3uC8t0or1PrYL9XiW+qCl+mkYLvanoIpT
   h0YFy9mFmEZ6CuBLmetPwo9hN61xBvnrBeEh31OiYTtnkBHKIW2TLKjv8
   HcKWZ93EQGbRfy/gryufHxUWokXJM4tdRO9dewmoistQ+pfBu6JJnzjcR
   CK1ScP9gBjbFxYbQXolydzjvN3GFOOqt1B/6d3pv5LrdEpR7+Xnf7mLrD
   Q0+xDRor0dolGWHZwpPQq+dQlYGDaeWv0Y3ew3wFXYDQueHKaETyCFZ0o
   g==;
IronPort-SDR: pR9jYFso9ohzaw59C63z15R+yhHusFTj8bteBT5Kev9QDQXreDjVvfxBxJeEKlPn4JNVPMRQup
 iXQacydRr/dTD30F6wNhOaSUfZTUg0fR+YvUp1PmDqAucSv69Bl6zEboPDi8Ld6YA1eV4OXagN
 1CR1+IbBkB5z0IARawZrvsn99LiPJ8KeMRcxFVw2TIg7PYouP2UH9+PB6vaFpM3SuhWSPnT0wr
 uAlxVcP4+0G+Yxh4Bbt6/2Yqzp0vs7C5qCuVKFBKGY75xaOPFlSRt37cKHtTVILrfcbiXWrZVu
 wUg=
X-IronPort-AV: E=Sophos;i="5.76,375,1592841600"; 
   d="scan'208";a="146153661"
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
  by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2020 19:13:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzMgPyc0wf3nh7Fc+79AyJ3YatT6I5urOVIaujoZBhtU9tDgXlG5mGJRAZJgUte7NP6C7piIQXVZjzkKh1PO97WBm/91MPJmxjoNWHO/b3RZ+CxLmRqstZikhmAwlLbJGA7SDBBoRwW6fK6+aNYDa6df1hGhYJe8sLlMoGAcfUI7ANsjtm5I0+RGhghVU5fyR2l6/gXY54POfcyO1XelpB44GwdSUxdj02iZAZXrFSwrzUs+9tgArPC/D/FAwtvaH16BHQ5s3B2JDhmc6RZXBGBARy+nuGmq591z0sjIqXm3fnLvnp0ZjihxkLri35vHLHCH/g/dNiZmwldlAsXtJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=e66UpD5axtaGu3kdvZParuN6vZih2alfH7QE/WYkOTMHd6r4LmVyXWJHa5cB0EFBzUupnpOAu/3CZrwbrJTswCkDF2ra44imy23HCtvXcE38M2o1pJVhycUSuVLOdX3lKhGTTqy0RUt2HGkic7wIlnlG8mpee7M3lmvoMI376DdPaOKZf2b9ZMp3MFsIgZob/uxUDH1BIHBfAd/mpNz2CDj6clHexW44yxHwf8rbGdlVGvsoV6nbeGWc4d9Aibho7+ATCmjbaFlvcLKkfkFt5sdvDm2NUfhricOcWTz7gK8shmEUI+87rFntCiiwUTNz33frhxP5ElFopPRS5uISKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=MOa3xrSUF20skLej1VcxD4177iyU+v4YpYjwnj/e86ssME8OQ4nbDa/AJy6cgP/etBtT8TgT5nDyr3s7HUq5VlVxUSFQlKg3EOx5ZW8dZ/xvb5T5S0xepvhX6fAKgyLxgnxj3K45b6B5W4MC6Xo/XR6xM+sH5aINkNY/priO9ic=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4688.namprd04.prod.outlook.com
 (2603:10b6:805:ab::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Mon, 31 Aug
 2020 11:13:57 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Mon, 31 Aug 2020
 11:13:56 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH] btrfs-progs: add a warning label for RAID5/6
Thread-Topic: [PATCH] btrfs-progs: add a warning label for RAID5/6
Thread-Index: AQHWev/y5liUz8WlN0qmxh+8YLpbmQ==
Date:   Mon, 31 Aug 2020 11:13:56 +0000
Message-ID: <SN4PR0401MB35983742E9D5193D785C5E3C9B510@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <bf9594ea55ce40af80548888070427ad97daf78a.1598374255.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:f048:793a:58d7:f0ac]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bb7a1345-6ad8-4352-643a-08d84d9ef429
x-ms-traffictypediagnostic: SN6PR04MB4688:
x-microsoft-antispam-prvs: <SN6PR04MB4688B5DB3540087D3920C4E29B510@SN6PR04MB4688.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J5+3UgcFsvEbCT4jDnL2duUUEjczuL0oj+rzP/I8EruxOmr5tlVRW/H3++wNLDwQMoI713vgCB5oEaU1K0x6IjRrl0FODabZqUodqneS2JRIYbdEBfMqNE4g/ruLNYExUxsCWs61YDx2Y8Q/uohVG8eE7blxirlAfDOuVJAy/O3vnWgsIfU7VjiPTN0vCkqlMYaLLA3tKa7DLhVpVd1N9GSG4za06JdXmR16FTgyRl9Xxt6jG+8IFEkb1YjZPNo1JQF3GXcj/JChVN6uG904eFOLn6juFM0OfMr/YMBCwwL+a+93QIOH80H25VGTXUCagkTUT/hJJwFjwWr25rf7Jg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(91956017)(19618925003)(8936002)(33656002)(76116006)(110136005)(71200400001)(66946007)(4270600006)(316002)(2906002)(86362001)(55016002)(66476007)(66556008)(64756008)(66446008)(5660300002)(186003)(8676002)(7696005)(9686003)(6506007)(52536014)(558084003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: L0UoyYybXfsPqNGd2hM8XGZM+YtHDsT7hTsPLLLYP5oxfESImQIi+mVO3nuiRrbBBxWKXPvkyW+/SmvsRvncz1Whi0PTeaj31DYs2iN6nmt8pRC4OLnUoGYpCmQkQ5VhQoyxil6QRJyQ0pmdl0+2MczlNNtWFTHtseIViZM1p2jD/dk8qR82yisvnRZ22AX+EoRHQQNAeewYWV5k7RDhUKyguYFGo7xOxFdX1D9f/K9yCOmCzb0GWmNqJ6/Z10qtX+4QEoU9fNnsH0Sf3pyZnqey01dZf3Ftb0crV+nAHYCysAKvCLBS31BgJQ6R4shRpp+wk/ba33IYDbeN0ox+Cc1z+wLFmQoA+qAtoEJ0HPA/JS9kIfrNupSavzpCnKiL25T5KsBQa4QnoptaibW931bv9zZiejjjD/r4gt8GIBbFcmKXjByeK1o4xD0o7T+TyvDKZK7Lg2y6PNlr5kZ4qVj/gKOdxRgjs8smYTcNjsnoHvM6UvW2J7T/S6i58cfby76vnHqw+fSSPdPqIPEHouCzG59Vw9VVdJWKDoBPi5CsBurRXK8Qn2YsWIDynGhjQwHPzReOLLid55NjrDSAGsRT619HzpN/+GeRFAat8HjvEZ1SMjT1LBXhvsoBKxNK1uGJf9zgc2rkAxPWuAw3yf0ttzfQI+kck5mHACejupw+KWN9nscb5QdGKG9soClMyWTRINapk154u07LKmrCUg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7a1345-6ad8-4352-643a-08d84d9ef429
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2020 11:13:56.7950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GTGBtOFFd8qpIv99KOM1+ZjH4cWpeUf/M6wzGI13RsuP4Ms+RtNCWiA3mt3JITcKaJKyUGuf9AZOkPcNMELs8QT1mdRqZEmqL0HR6qoneTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4688
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
