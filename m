Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD2A7160DF1
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2020 10:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbgBQJDc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Feb 2020 04:03:32 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:51525 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728640AbgBQJDc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 04:03:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581930212; x=1613466212;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=DNoilUm4sNYXl46syQdNO3wBqN3+gm5drPOcFZwGFLCF3VLXUESn0q0n
   YymryiagviIl6KciyfrA2O7cp/8QYvNP3i96LNhsX8U8ZXfN7e9ulrsyK
   FKGsgvAOQA86IrF6F00MmpCZyE0lZ8dwT6YLcQD7iCsCPQyzgToage2mk
   ZLTDBTY/CeByW22xHDjpHkv4MGU0f2gaxraQfosFYvc6g/mN1JN9xy/Uq
   TH7Il053Pb7p97fUM/v0ootVsIFguugAw2LDM0JUVVDY3/RCso6WcUVfA
   lJ8OwvChSCPLGcKsSiEc1H+QTQjlkI0FG1vj6g7/OZtl1M4erN6Rpt3Ht
   w==;
IronPort-SDR: BQcDxnFnw+qHil6rhrq3gvpq2Cb08F/vu8kYUdZbe8hNNZZ4qt62PB51FNZYFtpM0zWBr+uyDQ
 J7PiIYCFa5WUQ48NUr+bc6HU/Mdg5WZ9cVvEhBQeEEigvt/4DXXteNW/+VkUV+CE2dEyYCq2mQ
 yunTt3Wd+eMXSoYPZ1O8Xm77ujLLhfaom/KSxm1ocNTr51fjD8PqSSta36O5W8vFHGEO8No39i
 FoDOwBDFM984d2Y6QQDr+ft8ktht32bGo378i+860XSpud4YLvkbOZt3FfHmxwAyk/a+WQITkp
 8aI=
X-IronPort-AV: E=Sophos;i="5.70,451,1574092800"; 
   d="scan'208";a="130530856"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2020 17:03:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PeIEz63u8sMsBXlY4CadbvWSpDH/eBFVP2ZFM92fH+Z3MEw5ELGHHLGzhMMpjGcmawMdyZnxFnwct6fBRfSp0ogFNHkFz4KTyfLrKuhx6TW8UVWSn9ba9X2/3p56G1umwQKiPEhZn67bGqrsgAq1V7XlM8U6755YRKUiRgrsOKvy7AsyZy+68B2pZyLPGKmKdP7Oiv2gS+W9s31ijTA2q/sEXp0B0bkU6fgbCZQkiNE5uHToCGJ/SbGT0fsuGGIyopVNpLB+puSdlfgS81r6LhmVwwXGqoVjN+KzSP2zR0VNj7ml7MSK1ajXiJFCkqx5jg8/euS5WcCfH5iuFWAPoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=UrtAQMPYr5td/MtMhgBFcrV4WbTbZy8Bhhrb5QgMzNQBOzm6VgTqc9EDhKOvNspMytPnVTxP88v0in/ZjKJRPCCThTlZxj7BhxwuAGhR/X8aTjvkRMjRxd9CnGhYg7Qd7xqv7ZLzfuVYFA0xF0J0Oor1IEP005aCXH6Am/alJDTnWZcmcSltsemWeaxCspDeED1AfBtcgdOw7WxmtW+syGzB9rlH1Xlr91PzvIL3c3s/ylY5efnvOyJGwNupc+z/+vDzNzpxOzh/dAr/cFDkXZiNZkBsuoRAEaGn932zJ++uLQ+RoTpolCcB6FlEXiTMNZjXryGGojGQ2WIUd7IiDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=dGz9fOpuAR0e/YE7hFpcrlWRqFGBDJMOyZJVdYsZ2808OPuStU4k04Af1hXTdnEntaKx0Is+YdC+397UXch9rJ1JlnTr4hMQicEuleofPidSskIPwcTBVTn49jW62RhN+U+poGuqxuteE1c/mUImJxx5i8UrO6OScp5cuLneyBE=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3646.namprd04.prod.outlook.com (10.167.141.157) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Mon, 17 Feb 2020 09:03:30 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2729.032; Mon, 17 Feb 2020
 09:03:30 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] btrfs: relocation: Check cancel request after each
 data page read
Thread-Topic: [PATCH v3 2/3] btrfs: relocation: Check cancel request after
 each data page read
Thread-Index: AQHV5VnineWeexEPm0ed5xjFrIWfZw==
Date:   Mon, 17 Feb 2020 09:03:29 +0000
Message-ID: <SN4PR0401MB35980B87B79129FA9FE3A5AC9B160@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200217061654.65567-1-wqu@suse.com>
 <20200217061654.65567-3-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5a0b0b31-6002-4894-0720-08d7b388421d
x-ms-traffictypediagnostic: SN4PR0401MB3646:
x-microsoft-antispam-prvs: <SN4PR0401MB3646807B26E455B62C8ECB2F9B160@SN4PR0401MB3646.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0316567485
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(199004)(189003)(64756008)(66556008)(66476007)(52536014)(316002)(186003)(86362001)(66446008)(19618925003)(2906002)(66946007)(4270600006)(33656002)(558084003)(81156014)(55016002)(5660300002)(8676002)(478600001)(6506007)(81166006)(91956017)(76116006)(71200400001)(7696005)(9686003)(26005)(8936002)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3646;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HE5cz7wVF/uhpQ1+jGrXIMm5OiSvDb7g/qhyCiXXlBy2+OWPoGWons6NoqCm9xL7PY42aA9aIykmP59MWF3rV/UwxLD7HSQlisQ4O23XN7MTsQ5n6W7X83YFVy8Rk6WrLi2zXfXB4IppNsS3GNM7921y1kfugkZX4T/Vm0E1ZvNR5qiok23iI4zxC+swjXcuwX5nJn2L1dmX2bZxvj6DIueiGn7Frr9uC4JsAFKyRB6cq1YMmEH930cktnmzBP2Lfi0xkQSYwAdXta9hj4citfPjcbA9ySX50/qOJVlIEe2+iwW6HzLFk6bhLWRRx6ZVvc7D9eKavUe0g8W2QlUI+5dkq3oQm3ChMnWf2PAdFUtAN+OeEPN+qDAysBUvTwa/SbcdH8XvcRXFohcI8D0ilQfRX2VSnq21+efHDYzU9e+IrFDGshbfgtfJJGqiAaXm
x-ms-exchange-antispam-messagedata: 2WzOU3xXRLPwO+rtxxyJpYr2CRLHoQtO404DvVf9Ss0s5erRfvgxxCDuiht8JVAOUiZ8AYX/nS4Uoj6OXG1+v9JoHLsYYF/TslU4vGChwax1suu65qGIM2b5v1kQqOZtLBJnY3rA7pR2VJtnJkdGkQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0b0b31-6002-4894-0720-08d7b388421d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2020 09:03:29.9948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R8FYKamcJ/R1Q5ePbadAQBTq6uqG4s9YaWO0WvBjvQhSvYS6mKTYENdoWWPyMm0sQDmLRgfDRD72P88nFoRXLf0Iarr6WhBBEfUPd2HcXi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3646
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
