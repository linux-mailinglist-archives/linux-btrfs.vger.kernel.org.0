Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03868242B77
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 16:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgHLOhm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Aug 2020 10:37:42 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32155 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgHLOhl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Aug 2020 10:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1597243061; x=1628779061;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ShwVc1I3ae5QQH5wCOOAojYqzv80fD/6pF5F3aj8U6Y=;
  b=gnfbwPdLJhtngsxR3614h4x2VjmrrPEKlnekhdelrIKxsqkXK5es01qg
   1IpUjllTnTwwb24L7wH0SIy/LdCvVHjlCDZT540m+MmDX564qvJ55Fr7A
   5+bEUaXRtl89ZWpj9MtW06/UTDU70g5+kc0TUuGVbFaC9XoWu+LkXVAeT
   ynfbndst3pf+J4qOF2N/kziZ0yji80Qgb1OmIQk1d0xOWmkZGM2aEUUNT
   7wIQTB/DosYyTUeLZYaEP7aYfWOC28s9QJlq2sGMYdGAHQhrHLxWKwt21
   CUKztq8mchwRU99phnRkKJ5bSoiFPKniZ/ztksEMMooJZzOi/uYBD8VH4
   w==;
IronPort-SDR: 89Lq2/UKsRSgnLEStH159EtfQo6EfcbJotP2OYEBH2RWAkRQTM9buXcCs0dPe/1+/lxo4k18qP
 XiJ37fY3pRQiGLjns6YMl+n36wuePKn+eTaYf7HCJpelGv3NFPWrr//Y+0iwcwd3U0j4sxG1ib
 bbCC2K/6ChuBsiz83Y4FVURfY30nG/76iHIWcEXFnhuY5imqn6n2S07AMPIsoGzUMhCGbPgJ4x
 fS2Ld8XxSTs5YbuDQ4esXJ7i6y9RXl+HE91gfGfO6TEggbo0VbC1L9vj6u3c6MW2sPdcy+s/84
 E+Y=
X-IronPort-AV: E=Sophos;i="5.76,304,1592841600"; 
   d="scan'208";a="144811608"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 12 Aug 2020 22:37:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuotHu2gyD3EkzhQQhw+Gdk/5x91MmxY+HufdABsxIpzEGyC1OCwklcU0frFcC0kr+d3YIrZEoWKANlhLbOY7OnLMd6tHmceBZxmW9oarA0uXSKFabrfDHsqEtFD7vjtS5bG93U65iu59VXLhJS8V3QXRNGH3vx2FYnaGkXl/tL5I+DgLn9gQPm23p0Pe/pavvYp2NvrVRfpOZZlnqdFiocC9XhvSWPjtdqNwiqeER1ewFcsbODAjvnG45IYp0iTO4igx8Uw6+XgcMUbvj7ptEnCOZWQTUzTVwyJGgzR4DS1VBKb1f9kSZ61Usu/Lvaz+PQMS5rxoxHZqmFQMSl0mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKCTj08EUHKha7DZGYirNO281tKuzHloF8Njoi9Q+co=;
 b=PIuldjl8Du82TmM59FkO/2jaeP+DftKFCvZDkPSiTk7q4OsceDfRGVBA7Wz7pvjNu9+0RAf1brBY242/Iw8CC0rKUaAksmi8dD8O3PcUqGmnlhKcs9LIgTDyF4TiJF4UAIigC6CTVYkaZWw9zlOmTO7u7JXZx5k9/hCT0FfBz9zRi1m81o2hkFyErQEYFmMYnU27tA46zxRTDfDxdxUjlq1phmi6Yx6rt7Lvyo/kxlEhe3KupMIbZBE8JMCW6jqlK+D+W1xsTlAx9bl5EW1AOIvNuUb2Pqe8YkYSWPAkBqUuU73SQWDz/RhfVOUWqjiNqNZnPZcOGRyVUEBQ7A+fuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKCTj08EUHKha7DZGYirNO281tKuzHloF8Njoi9Q+co=;
 b=u6ooY/tNeoCVt4WfdlJZwNnUkDTPjWQyatHvKQ/RhtcZ7jzgtLbu5DfmGYJFYm9rRbwLNN8zvzIEdfrYGnMFblwt2vOml5lotbVJD1GLd8VTJdCfvJsaUV0vvh/I49PkqsNEKR3cxV0vVN0AZ0xciXbVXls5E45BeG3K6QL+Omo=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3600.namprd04.prod.outlook.com
 (2603:10b6:803:46::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18; Wed, 12 Aug
 2020 14:37:38 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3261.026; Wed, 12 Aug 2020
 14:37:38 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: remove fsid argument from
 btrfs_sysfs_update_sprout_fsid
Thread-Topic: [PATCH] btrfs: remove fsid argument from
 btrfs_sysfs_update_sprout_fsid
Thread-Index: AQHWcKstkCQC7Xdyu02xKyyOvO7opw==
Date:   Wed, 12 Aug 2020 14:37:38 +0000
Message-ID: <SN4PR0401MB3598188428E8604EB12112079B420@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200812131851.9129-1-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:c4ea:9080:4326:e7b1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1cd8f83c-2cb5-4b00-b688-08d83ecd42db
x-ms-traffictypediagnostic: SN4PR0401MB3600:
x-microsoft-antispam-prvs: <SN4PR0401MB36009A662381087492009BF79B420@SN4PR0401MB3600.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QjF4uGEjKJShQQhbBRyxZjCVURriY6LHRwWncNI7zgSoEfCz1DtP+lmTODgc6j7Cu/r5pgISsIYy6r7mP5uF4ZUEDRwm+YrikhGXg2RddPUm2MHVUIBJCRDS3puqzCHn5+bZT5CZY4j7MKH3evnW+nT8/PRy6l2ON7KXS3lLQEsTawsl/iwiQ4GrmShtiQtEv9RqMajnSVAjWNBhnoqnqNwtBFaThDRqO+jZA4OBHfBQLD/av186E71J6m253Y5kB5bz39Vx+kXmvyRrI6Tw/+IviOpGgY1njYMdV+MJX8tL2VdswsyZXSuFAlO1mJ4rCUpgskIOkATBvKHmJeyK/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(52536014)(71200400001)(186003)(9686003)(66556008)(64756008)(7696005)(66946007)(66446008)(5660300002)(498600001)(66476007)(6506007)(53546011)(91956017)(76116006)(55016002)(8936002)(8676002)(2906002)(33656002)(110136005)(558084003)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: knj3wMVSFateF0Ua2YT5bfT1fpyQWrl3LODg/78muZOqVFz1hck3+BN2QBmjDkvJJdnov1XbRKgJ24diJexPuJt+U2gh7GWq3BiIajVpGNjysmOFyRVUEMubiza8TJ++MackPK2MZP6gFfM9t2ER5EfTYE7RFEiTzOn63ncXDQcgRAxveD9kQVLi07Z5CZJ7i7by2tL4DlV81N762jkYiLEaee+jPDrUJ7L8k03bYe/ZE69kRFUfdhxtMzImxNftdbGscAvQNJ2sGbU+oiLFlro0yRSwzY2JPHygt8aaQE1ywwP9Hw2jx0b1de0apZRAuFNvGyxJasQWtGk/0pPeOPriAj9xDKjbMDjVjF2YvR6M9v7Gi6KxCMBZYWO4nef+hKhQIkH//QL6l1VECJ4881KLzV40Lww0SGeOtnfjOL3N6ET42pCkEWyoYCUqMTwjTlCWF2OiqPV/3gleA2irlw5LvgtWzyJSwDINEqzYCxNmcEFswlnaHWiDkXF2xm8pavQc/8xnU5UbANm0nvq6fBuoSVmL1tq4n2uNFZ+QlTU6npO08yPV79otclqcKcvveUmgEelAxWSmhFRVKqB9H6SqY5C2fkPK4NWUPu9v4TDxhO1aEl27fxoZqQNij96lJ2IOSXi9zGsTXz5W3klEZ7quRjiqjuO3hwxJqmn1R018H04QCs4CjWlkoh/Inf/MZBMnxk5B0UMyoFH/hPYyGw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd8f83c-2cb5-4b00-b688-08d83ecd42db
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2020 14:37:38.3018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U642tEKRKMuHW4M2eh8Aa5LDTay8wISoXPiTgvLV5u5N1YN+2dsVdJZHoh8ZMq3VZTwJ/Z5UslCc1lhP3SSmYBNuM3mVhTls5L04bsDS5BI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3600
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/08/2020 15:19, Nikolay Borisov wrote:=0A=
> +void btrfs_sysfs_update_sprout_fsid(struct btrfs_fs_devices *fs_devices)=
=0A=
> +=0A=
>  {=0A=
=0A=
Stray newline,=0A=
=0A=
Otherwise =0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
