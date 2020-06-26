Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289D020B389
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jun 2020 16:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgFZO2z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jun 2020 10:28:55 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:17612 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgFZO2z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jun 2020 10:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593181735; x=1624717735;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=NMvkJP9ctQgAx+9zSFfqK9rUQlZk4FFCZB5LPRuCdPE=;
  b=dBgsrsMG/Ij1YWeYk3CB+IHIGaQZmtPvUZPUxiNCH+D19EM4/guw4hgo
   VsRaPosXQZOuyqnFUwwuIlOHsoTVEVmSv5+JzJr728otqmLXy17WOgGlk
   FUa+cL5qcfuQy9J5/3GPvld127MVy/T8V/NW3QW/E/Dc3KtWzrQzR7s3e
   AAYUedKidkytxT1zfaHwR4Gz2U39NvtSupC8PDoOmiNBswwkpG/rUlBlc
   wBw/DKvtGqqdItHbxvEbBDZAmaiOVE9qScxvx+fQE+uKusrFKLBx8P0Qb
   M0r2ihDkiTOcbqDv8bxnrRhMCcYQWC5geTgY6+nFaeA0TsdmMLOyikrEB
   Q==;
IronPort-SDR: lHtqdBJ5Gxe/iFIRPU/LkvFxujmWaAiOXrN9phV38uMYjrgQa6Ob3+3jnWsHSgnXRbAQSrAvia
 3GJGNht1y5BAIS96sr4fS1iYE4vhDLgE5OobyiwCwDTjdMBKsc+veerctgcRCA0SUMnhdISo5e
 H9dYjFlLmF3P93hUHuuEAFGnLOtM9EgNJe95mF8vGkuTtFvKk2jiJSPt0fLTSphTjTTMGjkv00
 LrB95omZd+HLbGm6Lv/sB+dnIEaXfsAmA20FZ5t7AcARLULosA2pC8tB6IW1w71m0oygcUcf31
 JvE=
X-IronPort-AV: E=Sophos;i="5.75,283,1589212800"; 
   d="scan'208";a="142371193"
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 22:28:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XeZX6UpbICf7+CAnHrhqSE/Zck4YxC0Eqg88Pr5JMSKKaHzZlqjKgcek3N2YBH7RMcq398Jz+VxBPrarEiCwIvOQDdNVpsgsWJBqxxMd0a2RLyerdDi1HWMoP4fcMXFUmU9s7NQVbawmvlcXUV4ZKn9lIDUEsD4vB05eu4MRMLNY4TmJAXn5SLgYaj7NwSQWH8h0k56MvCXx7f95ZDERnxtiWe1C59HVB4CVvIkgBpszFQvwym2bpl5ouuGh0UW+ONvR2NVNur8dsLHUfwu4cMKWKiSXNy6WyZlNrCxu08JQ60Mydfrtd7r7KWmrLHpkO/ZsEWfpP9pCbjGlhnXj4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpzYgPmK9aMdf3Rr5KQRP7Y6D3ADyuNxnmN27UDScqU=;
 b=chJ1haIHMZfsaT7SyDTRi9c73hX5cf5Cw6MATn3hsnip2wkRCsQ7b+4OcrmDbhy5QbatNSeBbh75/PUQm7HYGdID0sg3mYd/BPj7tFE0mOBDej06hVlIB+0Noyvzc/GKvNj/XxwFVQqItRnQIX/jDH3zDTtQkDU9SxcTFN89PRYod3s0kVzPKippRPrKlAUDNpGM+tz0bjqaa7Bh70K4CVPkfJ4qEhejqC2d/rDRNsihQgE5fmT81OQQUvun7NaDG0IkxQPSFd+ZkstQu3k0OHyURK1R3L3FQwiOsxL6E6Ec+l74E3Dif8zu34gwv0ToFJAV+48kI+OSuFjKo3yYrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpzYgPmK9aMdf3Rr5KQRP7Y6D3ADyuNxnmN27UDScqU=;
 b=R524nx+hBnxvqP3EweduFWV94FAueIKrjYoh1HpOaqXqDSC8sY+xQeh4qPels9mxbRflkEWd0X/sqOfnY2N7RaYRBluXVpO3i7sxB7DfaCnZRcW9ghV2StJhR2OZAL0OChDbcjpFbFpcRagCyyXL23AQc4HSiYRBgKmpzh8PfuE=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5327.namprd04.prod.outlook.com
 (2603:10b6:805:103::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Fri, 26 Jun
 2020 14:28:53 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.021; Fri, 26 Jun 2020
 14:28:53 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2] btrfs: pass checksum type via BTRFS_IOC_FS_INFO ioctl
Thread-Topic: [PATCH v2] btrfs: pass checksum type via BTRFS_IOC_FS_INFO ioctl
Thread-Index: AQHWS4urkdVurrx4w0yxTGqw/Kf0Xw==
Date:   Fri, 26 Jun 2020 14:28:52 +0000
Message-ID: <SN4PR0401MB35980509CB1E66A69F96B31B9B930@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200626073019.24003-1-johannes.thumshirn@wdc.com>
 <20200626125446.GG27795@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:a471:867c:4e70:8019]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: efb6e66c-54c2-4bd1-d773-08d819dd4059
x-ms-traffictypediagnostic: SN6PR04MB5327:
x-microsoft-antispam-prvs: <SN6PR04MB532778E2CC7D4BCC2BCB807D9B930@SN6PR04MB5327.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: goExVKRrre8AIkyf3z5oIxKQ1ovscHAknEfMQFMYoAXqSKUIvF6m+qskoRvn8ueliBWdeVr3IFIYC+hcJ9jFcBX9rYOl8/UkowqomxxlDvT8cfiu1AlzO6jT0JrzFEb7+qZZIz4AnpW5k06zBllSwPt870aWg2puivZcUxQfQdgtbp1YnGajrU3LnopHKlkF3iFkhD6N62gyDTQcxJdK0w/Vw+EGPdJzF2rY4n+xzra7YaLzAiiLQnQKYz2ibD9irPANjY92zG9pI01Y5cdNbZKRFjDCeRexmIVYqqK/dcloRonvZlItzAd+0BAqlNecAu+4MbkWQAhFyUFapCV09Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(53546011)(6506007)(86362001)(6916009)(5660300002)(55016002)(4744005)(66946007)(52536014)(66476007)(8676002)(91956017)(66556008)(64756008)(76116006)(8936002)(66446008)(316002)(33656002)(9686003)(4326008)(186003)(71200400001)(2906002)(83380400001)(478600001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 1E5BbmZ12sJsN1TrFjlpLWrGbA8gQtwKLt3AT3karLJ4jRpAUJ5zfuh0EIURYdeD7v1KheNNS1VUQlXMnYkSC71yaMrCBuPnlNzQpytM0RNcY1K3H3X2XsgUdmBd+L6qmEOff0/v/zdvMcSVNFrA99jwyeM6SuCPO0/CSUpGDSQx6jvRVyW4mZRTGyzWSKzgfuK/c0DV8bMq9VyXnUGbUO/3RxUb0T1qTsA7cTJ0R11GRfqX94LCCKDCaUYV14GYSrDA1nTjNsnLM2h9wcYHKd3N3huzRRJLe4khtpDHDvRYUZ9T22L3jKSY64ufa3DOAJoIdoXUMU58tq4Indpkn4j/gZVNAuJgphJpx4xU4faw1nA5n8cfBdP2RzKtfaXdBo5OiQlHgyEvW1qaX48i+lZAdb0rFzGofBbM0manPCpybqvSdOIKsi4wyOqFJx4o5SNCWuAlEZZHmyNBTmxF30RouQSxRh2nphvUSixWiE3Ejl70H0jQ1EITZL0Ncpie6XkyNkBLPiZP3l43jEwz4ha+Jf7qVNuVKw3/4QWOMpXB15i4l2DTYb3BsOVdsYIs
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efb6e66c-54c2-4bd1-d773-08d819dd4059
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 14:28:52.9612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WMtKRiOm3RpP+JpjJPoaI7VoWa5dukYWfVIwjQ2/A9uUv8cZ94lkyBD6NkPtQl9T6CCHUlRO8TljhVH6NsTDHToCrMJtU1eKl+hd/S0lR7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5327
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 26/06/2020 14:55, David Sterba wrote:=0A=
[...]=0A=
> This leaves 2 bytes (one u16) unaligned to the next 4 bytes, which=0A=
> shouldn't be a problem, but I think having the csum_size would be a good=
=0A=
> and also getting rid of the gap.=0A=
> =0A=
>>         __u8                       reserved[974];        /*    50   974 =
*/=0A=
>>=0A=
>>         /* size: 1024, cachelines: 16, members: 9 */=0A=
>> };=0A=
=0A=
Good idea, will update and post a v3.=0A=
 =0A=
=0A=
