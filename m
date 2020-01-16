Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56DAC13D96E
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2020 12:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgAPL7a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jan 2020 06:59:30 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:22046 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgAPL7a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jan 2020 06:59:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1579175970; x=1610711970;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=841fLDIkOTMrPcFfPUtUSi3k6Byo+S0s13POUrFsu48=;
  b=optrFP7xxl7HZWi/+LFT/nJv6aApsHnHPzLjuvzRwiiV9pQyqjQKjI+j
   WOi/WTzGz0KlXPMrA3BrxsHSB4lQZEepVyFH/BwO2SUuJoNJfm26w8+8+
   fSCRIl6KdDVTmDak/h7dS7t/lmnfaZGz7UOG/7q1vH1Te6MC5BoP5M+Zt
   cijugNLzLR5F+AAXVeGGJqleAi6kc/Fyzv+wOPFrhe663COi/5yk02BAR
   AbW6a4QT4D3WQBxLLfj7OVITmtJjA3+r2cOR/va0rJqc+mnFkbdKUzb6J
   g+u0M1mY12ugHDGppejHaGmHky2m9hqlMKrAyJCKgtXhGxKGDbi+k6GQv
   Q==;
IronPort-SDR: LbQXIapELxY6Sj1bUz7oYlLomrYm6s79jxMpg5VgX5AlsoA51D62VTdvWtN4F/bMSOMbjHi2mS
 mGzeRcAM3FzAgsMxzXMow2gTo8dvrGeZg3OVJBQi1seV6xHLU7JWxswLZ4oAdFM5DWSTiBGxlr
 neBPsqpW5q24Qm1Rt8smuoRbGN2Sk3CsbA7+rz8bcKU/WXGRetsopFTiFaY7RM6W9cxkpZv3ge
 ypEE+a2Lx1+RH3zNYulfU9Sy/STwoAuOgDSe4cS45sQ/ZI6eGCc74PNyQ2zzcAzquGg38Vy8CN
 Cds=
X-IronPort-AV: E=Sophos;i="5.70,326,1574092800"; 
   d="scan'208";a="132080480"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jan 2020 19:59:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EeYdV4lPKow+W3KJmYxMwndp5Wm1YIA3phYZ+sIIh7RmxF7a4Vfbgq0IJlx7JKlBg+muYnpR62boFid7YqPCysa532mtz7U5lzgV9BcZ8sbHvYVHPpaTtV5RFcspAmzp2VaeZoWjkvfEHA1kVdl1OBWTNs1+lMttsSWwXpJ3ho6QuGNbHjOw52HeQyqBCYsktCopLwnWr2coBRgljSLApxCLxejraI1toCtaYvxLh1kMckkDNhaQJzRuq76BBzBsvbXnqe8sy5ozF33gXRXm41dSJk8Vko0M99HRvQeVhIwlNzRNCAy+tuJpIuOkqExI2tnCNxrrOJQDu+qLh2bZbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=841fLDIkOTMrPcFfPUtUSi3k6Byo+S0s13POUrFsu48=;
 b=KhxV4acndaKVGryH1IBy6hY6ymZdh4VQUOClkSSF+IfjGK/+Z/rORrOHaB1tYJY9ymY//j4iD1C/KqaN87ZSPGgsONq0sn6Z4PgojFBTTrqE/lY4ghU68Av5xaEF/m/aG4Y50rR0SScTa0g2CWvHS0mqsN9JXC2F4c+JyavSyf7bbUXirbu+wiGGQeK7XyaTgljLP1Ognf1FkoxCKHTEt/RHBPI0kP6YkpHlTEDwvEoJGiPZLkBVhZkpb9GtgVagf7GfZ8QcFOdAivaSu6NV6VBJRCV6xtkM8Ge5OdBAqQqlaaWgKtk3k+U72JA7dKhnC+7jf1aFGIaaWv52mIMcWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=841fLDIkOTMrPcFfPUtUSi3k6Byo+S0s13POUrFsu48=;
 b=f5e90hr2dZ78BNV+t2WJNijf/37voKBEJZULS2O3E7V3SOYOzxA+EoG0So6tWWE75AdNp4aTXn9ZxlsRLHL1y9JotM11KEmtlC/7L1dCb+PaFVMB+rYRRmXSqYKkJlYGY8d+jz3Tg6UAc4ezslMHuhhvXPqeiYV+s3pYsara7xY=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3711.namprd04.prod.outlook.com (10.167.150.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Thu, 16 Jan 2020 11:59:27 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2644.015; Thu, 16 Jan 2020
 11:59:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@kernel.org" <fdmanana@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] Btrfs: always copy scrub arguments back to user space
Thread-Topic: [PATCH] Btrfs: always copy scrub arguments back to user space
Thread-Index: AQHVzGA3jgU0GTgyd0qq9NJ7KrXMAqftQM8A
Date:   Thu, 16 Jan 2020 11:59:26 +0000
Message-ID: <43D93D40-9A62-465F-A880-0D7758FF63CB@wdc.com>
References: <20200116112920.30400-1-fdmanana@kernel.org>
In-Reply-To: <20200116112920.30400-1-fdmanana@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d1d1dff5-1274-4379-031f-08d79a7b894c
x-ms-traffictypediagnostic: SN4PR0401MB3711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3711622FAC83B66B6DA6F9719B360@SN4PR0401MB3711.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(199004)(189003)(316002)(36756003)(86362001)(2616005)(6506007)(110136005)(66556008)(558084003)(71200400001)(19618925003)(186003)(5660300002)(33656002)(478600001)(81166006)(8676002)(81156014)(6512007)(6486002)(8936002)(4270600006)(26005)(91956017)(76116006)(64756008)(66476007)(2906002)(66946007)(66446008);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3711;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MmX3Gvh/L3CHPfPsT2P3tOmScQ+SwK25z//cWl232JoFFRpEl1dXCtqjp8U3dNQTbVeq2DAoIiX+6tLMMhyB7475q4N159RUpYD2D13dbbqIAIMKlWOs+PkZ4+zQ3fZqtR2SgBBHSU5nIBC5K/RAZ1Q2BnMkGN5X7plL1FkIwrF2AbIpR0s6l08luhbxbon0b0bz6O3PMafxnl6VZejJfqJfsa6rd8+XoQTR2aXnrH1J8swXb0PQozLEg7ioABTppr+tTXMiuZceCk3BOwWxu6R6i2JKwKwcSG3rvJSeNTElw7KV1dDfrmoHBSfpbiGTrl0ps70tStEKtwehuOXRs4sk/xiKkdEaUDEy8BjNPm1F3y5ch8NNo5neg4DHrU5fIoV2Qi8/P4O7D2dW5uXI+CPGW198MKysSrL7K9ot2lVrFhciZ3RlfaK4hamoEj60
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A003C819231D94BB62E8FF9BCA7B763@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d1dff5-1274-4379-031f-08d79a7b894c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 11:59:26.9910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p2GdR1IFp+T0cfTU33Zv18d3rhwBCaZ2zx/uLKfoveG2e47UQbUzl5HR3S60dgrSMHrE7xKwZVw4yQeAmmvGn6NAHXL4lbVfCg5V/oP9z7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3711
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0KICAgIA0KICAgIA0KDQo=
