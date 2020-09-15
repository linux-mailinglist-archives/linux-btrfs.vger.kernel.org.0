Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD1426A132
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 10:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgIOIoQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 04:44:16 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:17415 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgIOIoN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 04:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600159452; x=1631695452;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=bzBZE/rmv0rfJbi+kQS3m4fVpPfTVdmUWQas1fSbigPzt8LkbIWP4Q3t
   tKWvNvssk11GBqXrcYBVoODefT1F9/gVpUl1WdahnPMvvtwthGNjZsped
   QeHUIkqzbCNIC2Sbj3r533hr4fBHlB+nj0EUv/9U9NKlLwcog/JwGioXG
   jA0KqMZJzYMh54MZYKjR3YCeEUoOI0pn19W6/f/3Ac16335oyzWi3tNlx
   WYqBsakPu5dUIMeQPAUPkE2sutq7uiwefbghRe8rC/rgkXH2P6ZeDuXH5
   9bm38vT70x9dQvU7FcsnQArhVdkxRE5PwCSVGEPQtbbzKO+7N1FhPtUoG
   A==;
IronPort-SDR: sVn+0gVMYt4ucIfHkJWg7GzEc6QkeKexHLhOVPcxSRjgHU2CLJbDfAnOibVIrarZwdlygW9DTQ
 EOcIo3oMI9isKL1qHGUpJsGmv6GVERwZZKg3KNzs0jcApeeC1fX5zNRrNhQzVG5FNliJGvjuaR
 DUnKk0f1gRebETEgcMoSP3STQ2zf8b/j3UPEfmU2yMJBEX47/ztMVhxMRMO2JoUpkuqSgawMao
 PknSqm+RlKuFhrNhfnrmJhJkzxKUDTBnrfN0iDRCac+VgRFig29Jcl1Z178ZE5Ga92R1r95db+
 xsg=
X-IronPort-AV: E=Sophos;i="5.76,429,1592841600"; 
   d="scan'208";a="147412719"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2020 16:44:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQwGbLayoZwNM2Xb+q9l+V79fsQENcIJzP3gz/2AKrg689Wb7XSaL+ExmcTGWl8UU1BucBOjWeWNbol6sX/1C5w7vk7q2FvFRlUCxKN/2VOe1uD5OVHSuauJ3wLbnWqUEBHUqIFsFUOaErR9yTlerAKJLBnTmAKQ7QAxqkpx6ozSdqOuzTBU1M+ZkMVc4P0oy/BcpSMafs167KHEyjbB+3nFSlKToMdyaRzo+3yklmFRb2evjarfJYD/Rbdie02ODSZOW9erCk9m/qgZpkFCxluW7s1ydPmhaTa92DyfuM8aJ2whq0ECrdsFNAuNbQiO1q002uNyqF+FMu2V+s/+JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=PO2tG4+tmulRnKprLV0NqkxwItF0UPUBfOgJufxkQfPP9G6F9QgMPVe+eQvahFl4e4HnG1P4MEP4lMI1bStc173sixAa8brUXCMh4bIk2IV7fS82/UzIlZEWEYvyAYX6EbOlfyk2bB2bogKQaWcXRvpg5ajOc1WlYagrvCgkn3WvZv42vYh//H16R8Eht5xkaoRYCSQrd2q+kDU1cOX34v76IU00vyVdEvrnTTYD2rlDnPdjXUfoG0fGm0bqNT5AuN56yAENGVEWscsyrvZMi9y7BayuUnbjAHrOLnQEMpWXRuRFsyRW8LhQrqaTFAYq18Z+iowgh3zuR0aDmUEdJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=PxiMiBuVnDPxfNagfSVJrnX2EU5bcSTeMSuiLfm7FQpjCQhxF3b3S5XDgXIhUf2FbKKWU+yqpTJdgsXc4thcijVfXJsF0fXgYAxpgJPNoN0NniRJ5vhB73+mXiHqSFpIZLKVjpjdtFZCod97UY4SEpYKlKBLriCaObWt7PnRmqo=
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com (2603:10b6:4:7e::15)
 by DM6PR04MB6459.namprd04.prod.outlook.com (2603:10b6:5:1e9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Tue, 15 Sep
 2020 08:44:11 +0000
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::c862:9cd5:689a:8573]) by DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::c862:9cd5:689a:8573%5]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 08:44:11 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 06/19] btrfs: don't allow tree block to cross page
 boundary for subpage support
Thread-Topic: [PATCH v2 06/19] btrfs: don't allow tree block to cross page
 boundary for subpage support
Thread-Index: AQHWiyIcTry07Xj0Z0uV8i2ALTbQsA==
Date:   Tue, 15 Sep 2020 08:44:11 +0000
Message-ID: <DM5PR0401MB3591C28279AA0F61C9F3D1FB9B200@DM5PR0401MB3591.namprd04.prod.outlook.com>
References: <20200915053532.63279-1-wqu@suse.com>
 <20200915053532.63279-7-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:3d01:38cf:f1ce:e1ec:d261]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 450b1f3d-eb9b-40cf-cd06-08d859538466
x-ms-traffictypediagnostic: DM6PR04MB6459:
x-microsoft-antispam-prvs: <DM6PR04MB6459AC7109C5D0600668FBD49B200@DM6PR04MB6459.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lnDJP9p2F/BRwLEBCQwsxWjn/My+J0sL83uujN29Mvid1LNvmkvgNz4yq4Trg1vPrwNhy+AOsHaqmV7S6Ymp8weWDBxD6QNHK1dX5wy8ME1a7EKQkxbkvE9781b971AUOQ8cC63wUwES3ZgZYPIxgr8bM903jLTZTSFvtOUjgg2T5iGY6+iogAt4SavN2l3fepse1uHynWiWHj62SXHd/jGS6NAxacHEwuiSJZOR59EGcHwge/8efjjqDQlO+TlWxtYIyimRZp8CkpH4LtnjrXOoeMCdzIUW3Cd/KkZShIEyhEc6wntfWseaZcyQV3kYj3x8La9RtbeJoozG0InjWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0401MB3591.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(186003)(478600001)(558084003)(8936002)(316002)(110136005)(76116006)(5660300002)(64756008)(91956017)(66446008)(66946007)(66476007)(66556008)(86362001)(9686003)(7696005)(52536014)(55016002)(8676002)(2906002)(4270600006)(19618925003)(71200400001)(6506007)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: GX709YnZB3q5WKs1gCGYt3nY6zfGmduca+o2z8tcyn/8Y/n9oU/zJigcFsFHRTr0UP7V506sypzWePavK0nixE7FMIxdxvU/dEdL/8jOgZ9zoClR8dKUyJhRqFpMiZ6K9d/6mlSjNnGqyEfG58Rc/QkWWQIpx0UdOop7WnxxXDvXryXHjInO78c9HHCDZuwECTNVzGGBKQQn2nnSriUBE0ifnbhB6N9dkArPVsBVGjRFtKWabW4I+qMSDhF6I+H0elxcLrPXpp59eSVTjg7kpIr3K6v11vN6FtSA1Cf5mkYut5ZtdG3AIuxCbxAghMcV4N55lbdIiBqy3Duqlcblck0HkycfyCByavcqcmm8laifHtkNGTpSehnbTuzmqPX/3anV7QIFybID364gzfXEnR3uY4n50Ie+6IuLFX6Cd1/+sT8LG1FdGWEn6ZFr8mWQJwG0zV/rmT9RixHuTooPzNTP8CzSWU7okWBmY/ZHmPrcGF6dZWKCd4eoOo2r6ZNlg3R7x/Jz6BouD9kYy41J91ZRSqj8hfEvUg+P+Ck2XBGMxSk/YhfHi0lyishzozonnnWxPLTJIvFp1AbZrIBQRy5f0zkPbXArMSd4ci0+5dhk2FTth8BVv/S7SiSwSoWIQg5hWfQG988DIw3Xu8fkjG8H0ec4daG6LgBpcYqHoUGN4dR6DRvzylqizb1z1GvXwSgPd9udP0Yn5zTH0+JvOQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0401MB3591.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 450b1f3d-eb9b-40cf-cd06-08d859538466
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 08:44:11.0243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4wiIS2g0yDvegJfd95rwHSMNS4XE4J3F3kRxmq5NrA/ULNp6Rm9m1xOsS3a2Za5Txi5YihbIg5jQUapUUdGV/uQuGvk0bbiXDWHGnzRehdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6459
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
