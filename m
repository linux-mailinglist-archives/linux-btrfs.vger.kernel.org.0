Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE82154503
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 14:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgBFNeq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 08:34:46 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:21992 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbgBFNeq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 08:34:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580996085; x=1612532085;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=lD3JCmnNrLF91UMkr1/ACETx46ADDx1LNauDTcNmqwswS4QwStm7wfsU
   Vl1VdO0PbG3b/jXwTBF5T+zJnK4eOdkDn/nXDdReN4GMDHbvK/JyfUmUj
   C8Pk9XvNXx6e/28MJ7DwznJHa1eMp2lrVzgMoiUH8gCM1rXIfjypG9+ZO
   yxKpYQeN2esoB7ekP+Kk4u8Kl1KxuOfsYCCcDyaqHc/6TezfdiANo/L+O
   cyGtklmwIoYvjZz94FQB8eq4Zn/NpT9e2gVtaG3T80FddzR16ylU2D7th
   1M5QgZHznNDO75vB1Vh2v4FOi7PRZLEpvMel6GFws67viatQmHgp6xgYb
   g==;
IronPort-SDR: 4g8cENgtAxr3DDCwiyufWun6xnpbBbvwW3rFObek1kBObOmGVU2wfai4UaHa1VH/FRodMoaedT
 xu3VodPWGL8eez+p0xL3qO50d9zSRBBSsiaC8im2pqzx4Oe/WskdVvOGDzD8g9/vAd3mHV0JJg
 exxz/PBhaWqowUw3OmigApme9KzmDQzmLBvKVY978wJ4p7Yjt0isENKdke1GEdm2SEq6LagXjX
 taLZDteBmpKHpHwFF7xQJBBMNPhXNRuMoX7lwhgVX/C5GCgBQK9u21qmal+d6YusnBd3UASBID
 Ii8=
X-IronPort-AV: E=Sophos;i="5.70,409,1574092800"; 
   d="scan'208";a="129252032"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 21:34:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xh8cTxMyWkJJDuT8sMztGzR/ADeNlWjcykfuKxQqGMe8mMBD2IOpMpyau6HULI37Gb7do9zVCJb6YJmip+dHhwrJfsGy92uTnRfEDDUuemrYEg11VAIOObdj8AEbhAg5Q5NUAr2c5bYTSY826zvxWaecaernj5kni9lnu2ZyAQtlYnWCPhRm011kC3LKa1VIKnjaYbTCBNTDDn8TVmRtv9QcNoF19ty7hcUAI1pKderaNhuJ3IdHlsBTkhhPpZjKXPK+EDuXr7pWK61OIC4zY3lfy2KtO6I+CzJ2MvYioBx8+qeGQ/fZOfmA43rdfwIFeNL2v+LBQxUQUQpR9u6A8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=FppQK5sz47anS75nCASezkDbEDFU+tGpVDCvIMus5H8A2xqpwpuQZmG2zsDLyWyNkS93a/tM1KHAMDJivXocqiQC4YQigxOuY4UVHaiUwtS49dpZPGwS2DQXm4wiZM/HKPD0E5IKSjLcKqaSAp4breF01pLwDrSYCHKBr7y3VSLFkEAhMd+nqvTIEMk8aInrNAG+E6mO5rR7WrrcT4h00IKTgMyKas7H7GWVaDybHBe+zCyxgL/EYjAktKOUk0lKL+LQb66kCpOcLjjoRdT4mDbOpYz1Rsv5xI3MAqkE3yFUhN0dz9aIAxgXca4fRbR8qNpdcjmIoLjQ3BvV3US32A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=qTLLdzXt1/Y905saVRVjxGADJ8I3pgEsaSij11e1DhDYMFRqtt72ualseQhniTX/uQY2mRhLdfVrU9b3cqKJmCjrCRELV4ws2jghiw1AFghRj8EfK2C7dZvr1zreD40uXzngh87RKYlKFkaPokcB/58D7FbuaBnfppMRZ8ClUl4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3693.namprd04.prod.outlook.com (10.167.139.159) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.30; Thu, 6 Feb 2020 13:34:44 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.036; Thu, 6 Feb 2020
 13:34:44 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/8] btrfs: add assertions for tree == inode->io_tree to
 extent IO helpers
Thread-Topic: [PATCH 3/8] btrfs: add assertions for tree == inode->io_tree to
 extent IO helpers
Thread-Index: AQHV3E91Fl8pj38TV0SiCCspLUspYg==
Date:   Thu, 6 Feb 2020 13:34:44 +0000
Message-ID: <SN4PR0401MB35988F55A9F49DB5BD975B169B1D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1580925977.git.dsterba@suse.com>
 <d1acc29c9c15139a988add159de8dbfe2129a36f.1580925977.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7a6a7e86-2e78-475e-4787-08d7ab0953cc
x-ms-traffictypediagnostic: SN4PR0401MB3693:
x-microsoft-antispam-prvs: <SN4PR0401MB3693ECDF23A1FE6F06C7D0DF9B1D0@SN4PR0401MB3693.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(199004)(189003)(86362001)(52536014)(110136005)(76116006)(91956017)(66946007)(316002)(33656002)(64756008)(66556008)(66446008)(66476007)(558084003)(478600001)(55016002)(5660300002)(9686003)(7696005)(186003)(8936002)(81166006)(8676002)(2906002)(81156014)(26005)(4270600006)(19618925003)(6506007)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3693;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mfLYelyoi5i3xn0/0vn09Xepsst5LaT+bE9YaY/eqdLK5HDQ7N1JQlfCgELvxNkvM+x8YDICWm7B8ocI6FJi1kmrKn9U4KHmx8zazW00SzVDO3BrBoR1S7V4pu89BsPeOXfHcKufTxGfQyrWxTbSRhN8Ppjs87WjzK5CC6zwYNpDg/w8g63zpWsOm3bOtSeCLAALb5OeRnbHwnvq3iiiAcC+gaahmhZKNy02JR4eozq4KNgEB111V9A/bHsFxXzatLrDOFz3/uQcL5H8M5lpqz8u6bsw1KUXUH0tZueMkv1UWuSGPDbr7VOO1Is4HC1eF64sNPpzgLdULTFQ8vcFp0q0j3KFwpJojExObbwhr33D6e3VKDuCjJE3iyurMpcSm4mMU8V0/tBB8Jn7rT3rZUMoe99J5VWrX5iiOXXRlfsMMr3hIL8zW+WGyJjAY7BO
x-ms-exchange-antispam-messagedata: 2fAA5WjrdHPtoaHVhW/fHfvg0biNie9N5OY9yCaGcvtQ+riX/t/Ri7e1KkYx4JH0f3jo6rnanGop8M/pEQa/GyzyE+M6mXZsOMEk0ZV9g8amtJjbrG+6xHFDo2gAEECggrcWDiqCEFi0PvL/xi5Wgg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a6a7e86-2e78-475e-4787-08d7ab0953cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 13:34:44.4197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 93icziR/V4mNEkuDCk7Jyimg87wQDAnTUyzVasLokIIeIp1TykwOcjbExvooSGmdg85B464MHPXFLi4JIJInDb30v5FJ0zwwzMBVs22E01w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3693
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
