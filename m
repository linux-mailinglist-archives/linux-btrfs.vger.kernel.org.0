Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F62415451C
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 14:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgBFNk7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 08:40:59 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:40971 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgBFNk7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 08:40:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580996458; x=1612532458;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=XuHtvAbtKnvDhzvxcS4OSGF0lbScc1Gbl2PXxUkAP9HW+sgNU84xCajl
   vUu22qj5zqrzZhup86QyJa8N9qlcU8vvJoV7gB4nDLBGsBbsRzQzeh0ou
   U412Q9RaN9bSGmlSkd1VCR+oDI0iVEci26ctT5d8fuM4sVbXp7znIi0o+
   6Xrqql6wiQBRLVPG+1yymMTvQ31QKY+JWi04JkR+iGVC4kfzQQ1SzE8J5
   UWvCQ4TsZQF9mhp9byoQgyzNKtdLcR9kjtAHjtvhGB9V84Wob/iwHGZaP
   6JCz3NiY6IlFtwro+Cvk/fJ6Xif2SR/0IvzQ0o0sAimgJ6v5ktCVl8/vb
   g==;
IronPort-SDR: YpHhdqVxdrVdbqLBwkuKJ6ML9jwGFJGQgnRutLUXFfRF7BiIsX1Rp36lGxYhqAb0RZTGUGduaj
 I9Tt9xlShvhSZPZN9rvvppIskYwfmQM4jQGgNlrkCJ5/5K11RWZiArBHz4FS2Mh1rrFm/zWMcq
 RQVkMUyy9UHp2SsDIzk1PnWRGddVWGANl+vBz2oFjuMiEFLmdUTBPoSWOysBI1dSlwNkesARYl
 5AlntjzHYu/+pUBGeVTroS4IqydseJwBKPo8NWRhkW5D/CBGer+XVzH0K++0evi54/hDq06r1H
 6vk=
X-IronPort-AV: E=Sophos;i="5.70,409,1574092800"; 
   d="scan'208";a="237221543"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 21:40:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/rDtstj3pL4VcEg0G+gydFeY3Uij+pIVj4ueX7LN4LXhsZvcYR9pDMKzP2FtjHeOECzB+jXVfFwMwdlrXEeYzk+jaXYSvztQzwlqTYHgl4qNdQZSR2HBinwYUeB2VSIyWgFw7j2ELyXIpLQXZ/vXSk6zo7m6ZrXVkBH25E+hSW3o1pRHMRDkRrXkWejusoYwr+ehx5Li7w/sdGhDsBSAj5Q3Fv5PuEHVIoT0F8H8g5kzs54htBKuUjiTD3rALUZxuaNmqzpVRaJe07MFDhf7v6fEuuVWpnmvksG+fVFG/1jMKi6j0vlu+07bi4lXku2fa2ilLTZRUY3RgivWP+jQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=FJQ+1VE3XX0ghh+RlGIeF0UMxbpyOeH2onHDVj0Fagk+RUIVOanuUCt3SFfeQnN9JxGlpc7RaocMm5Ttvdy8R50rwL5mdx3OiYK5+LWadZ1K1vHZi3t0ksI8ch9GUgbOrVHWguYvC9pMt29ys5l0KP9VxpJJ+iPut/ovllx+Hg/irrl/NNCwGUDmjnklCwHZaHFohiGtVm/1cKp5mTKofo4RXBV3yyvQKFDosBMTz4PUV0js4waZnPlugf6WIDlw/5UebsTa+tUZoH6l3D5JKn8gv7YGfzqLbYelU887ak86GQ17tZuqXPiptJLv6pxxl4J0pr0a2SIHxOXceXfyXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Xhto80j+FM0SCgKseIjNOwJj7Zqzas/L5Nkt1MRLvPO04RBwxLEKRmPo/AsCTgc6oXiujehPt33mT9Kg5W4AE1lAB8Yz/qBHTP4WTiarfnCKg94lJ0t3r08NhnzbFSOPdw7c5AGBXbAuF4m8nsKbG1lCvjGfdr8hxOYcQxNTAX4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3518.namprd04.prod.outlook.com (10.167.150.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Thu, 6 Feb 2020 13:40:56 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.036; Thu, 6 Feb 2020
 13:40:56 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 6/8] btrfs: sink argument tree to __extent_read_full_page
Thread-Topic: [PATCH 6/8] btrfs: sink argument tree to __extent_read_full_page
Thread-Index: AQHV3E965gJl7srqrE+ha8kht/yhmw==
Date:   Thu, 6 Feb 2020 13:40:56 +0000
Message-ID: <SN4PR0401MB359800BCB35F3CEE3DF49CFB9B1D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1580925977.git.dsterba@suse.com>
 <7df51ff5476573747dfd5a0a78033431a2363fc4.1580925977.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2bd271b7-5b93-4801-8588-08d7ab0a3150
x-ms-traffictypediagnostic: SN4PR0401MB3518:
x-microsoft-antispam-prvs: <SN4PR0401MB35184C81379CE61EFE6C7F6E9B1D0@SN4PR0401MB3518.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(189003)(199004)(4270600006)(110136005)(8936002)(316002)(52536014)(5660300002)(8676002)(9686003)(55016002)(81156014)(81166006)(558084003)(478600001)(19618925003)(33656002)(186003)(7696005)(71200400001)(6506007)(66946007)(26005)(64756008)(66556008)(66476007)(76116006)(66446008)(86362001)(91956017)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3518;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hFbU8qXV7yBrgZ6TGzg3hxYKWcOw8OmUlGjkR+ckJQ++XuZW8vBm48fMqY5ucue3HpxsLqtKeDJy4LF8nUMvjVtu6KTut9RxbpCXkuVtlU7fK4C8c9CawKwDoGJOAvIuVQZpCpDa5523Yh1XaG87ENBiJe+mKpf87ATMPB7MnG3wLwRp1GLBylo6tl23esEXxQQakQffA8OZ3rejtY2daaLjIzvdwIBg+XLUTcnkZ6C86mDJEgBewqdGXe9hpGZIvPoOq+nUsqQI3jwUnHpncZuZpOxGu4Jl2u3RsnfTYPt0iEyJizOXQwDO+icU+crKRM6A0qfrJU1/dp/lUnshMd5IZWdXUTfYqwDU33DU9KgPhsbfKX57itluSpm2xCeX+6u57Qkzb2/K8+FphfTdW3vUdZDIgmaB+Ga4sl82pGPyRO93wqzLiiLkEQ8e/XeL
x-ms-exchange-antispam-messagedata: 3bWannC7nvA11oyMbC7YygTW9rZyqJdPUxhWg/1Mige0pdmNerflIbRmARVv6psXhr8olOmY5gjd8ilIC7foBO67pnKbGeKtXjCxM2G4WvW3XtxTPRR99asuH5cUMtsY+eDe5Jff92QAi4oqkDe08A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd271b7-5b93-4801-8588-08d7ab0a3150
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 13:40:56.0358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7JjhZx0XCPx7tj2+QBCwbCaX/d2JU1I1Ub7yz/PdggmyQ07Jx/1j/LBvaC1ZQYtIap/KlWdckVW9x/f9XCtfu07xRNtsn4Ywz0nghchvIu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3518
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
