Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3619156FC7
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2020 08:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgBJHQa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Feb 2020 02:16:30 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:63460 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgBJHQ3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Feb 2020 02:16:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581318990; x=1612854990;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=8xzGgvjgsfgJE3K/Xcwl3HLmItv2W5wt08Am1aTHmrE=;
  b=qsDOW/tB/g3CG+T8TK/AMtLUSpsIO8QtKCnCQfx+8Oa1UK47SrWKlm5G
   KeZobFiGsdJ8l5LNfZWo7PDN815MkzE9awpALqVDvIrpnVdT2YVyuHSUd
   T0thrc5z/hPs+YcLk18Tuo9m63VoIw9FbJ6jRAyksbgn3YROKnCErOYao
   KDY3kh6vtkV15Woka9eXqbYQBMrxjUtPaGq4EyurlucCiecjKxt5Ku2dQ
   sBuo7VPHNerQ7qAreQYLKKoEwDBnIo3kHSUgAwOM+zo3d48HbJqwA5DF0
   tKF0WcOV5StKVGmptTJMTnKNfa/nGP2jcqRqWPwQYFOKAm9rcQzwwaBoh
   g==;
IronPort-SDR: YIMoYYjlUsQWqKzpKbYD9Q2d2QGINZ+kFEOF9NSDmVsDDZl8GXtRObFc1HUHngTam+98vF5rXF
 4XAU20gvXdPNXrSAdlNU7X73A99nPuxB+rGPAN8ipoEbzOIJCcK1/ZUjFnVjeVGnJxh2oYzFMi
 Dp09BoTMaeLrUZg4HrsYhUl+mHG1L3QmSIx74OaBBgBMV5ShSD2SICQ6T9tWpF30OV4lFwjMPq
 knNlWqp0NAnoEzkDFm/h5BOzy1yWb1BYemlC5NX2MLCCeQ7W6gJrTrhrlD90c1gtQLNou6RFoJ
 s4c=
X-IronPort-AV: E=Sophos;i="5.70,424,1574092800"; 
   d="scan'208";a="130939050"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2020 15:16:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HjSr9wdbt6k2AwCg5dzPU03hvCDc8JrV03GX85uEKmb9nHtpJ0CYDbB6Lj9osjo0tV6rvHLH0/lKNY70hxNB/UDn9SUJ9hAb3e4zGPkWLhEesjHdOqGTukcmv6pXyxvEynUZx8J4CiCGJ+L2bdzWH4jWcfx7s7kowu5oWgNzWd00GgBD78Wmi//uwyyN57f0E6kemgF18sNBodeY/E6pwDQFZfLKa8Gp8jTdShR+BcnMLVdIZE3JTW317rT1kpoz3zkULiuBuNKs8RnsYxZPGEqjQ44NOC7mu/uw6pd9C9+TfjxJIRiiyhuZ2Zt5QDKJV/GIGlaqI1MGeqiQmE9u2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xzGgvjgsfgJE3K/Xcwl3HLmItv2W5wt08Am1aTHmrE=;
 b=HTUnQzTOk+gPv8pP0xJ0jP0U9mGsID1CggSLaB+iviFyiNUYgjASdbeEGgaXYk3WcnNsi+4vP7kYcw2mlIzDjqvJx1H/HBcyRCJeFFOGwcgR+WOxtQnCI8PRq/xSY7/jGyggeBg/rUhfpX41qmWDAHzMJV7usyqO+KAb+XoiZHWXQrbccR8DGWPPKCozD1mPxIvVdNmRyf97FhsYCkEkgjMps7fC/lAIkdqxEcLtcTqVq+9ZADKNZkBYcMDhzfAPop4mVeBGmd/kIACSpTfWdUzUIDFW5jYZinyTVoTYZP9w795FLgZpvEpjpHvFCeQfg5kqIydlQSJmxdz2m6Uwzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xzGgvjgsfgJE3K/Xcwl3HLmItv2W5wt08Am1aTHmrE=;
 b=WCzk1+CD6Ggbc7E/USm5hgU6oF0MHSZA+sWCZpqeViKIiFlpavSEjHCXtAxAaLLg+sXTdL7C+ORQGTIzcKHHqFxwCvUJ2Vqj9UeBHrDuaVWLL2aa/XygyrzU6OAQEQwlH4uq+g5b/w9owP1A+3uzf3SV8DeLkF0epA1KMsoW2u0=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3565.namprd04.prod.outlook.com (10.167.139.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.29; Mon, 10 Feb 2020 07:16:26 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2707.028; Mon, 10 Feb 2020
 07:16:26 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     Christoph Hellwig <hch@infradead.org>,
        Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v4 1/5] btrfs: use the page-cache for super block reading
Thread-Topic: [PATCH v4 1/5] btrfs: use the page-cache for super block reading
Thread-Index: AQHV3DH3mC4sQyE5G0ifuyrJtqLY6Q==
Date:   Mon, 10 Feb 2020 07:16:26 +0000
Message-ID: <SN4PR0401MB359872E1D656FE7F0451462A9B190@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200205143831.13959-1-johannes.thumshirn@wdc.com>
 <20200205143831.13959-2-johannes.thumshirn@wdc.com>
 <20200205165319.GA6326@infradead.org>
 <SN4PR0401MB359854D81C504BBE28B8B2EB9B1D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200206145759.GA24780@infradead.org>
 <SN4PR0401MB359856AB4365DC83FBE99E0A9B1D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200207161358.GH2654@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1c324b82-8391-4580-9887-08d7adf9248c
x-ms-traffictypediagnostic: SN4PR0401MB3565:
x-microsoft-antispam-prvs: <SN4PR0401MB3565C702A8280817A37C9E439B190@SN4PR0401MB3565.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03094A4065
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(189003)(199004)(9686003)(316002)(4744005)(2906002)(54906003)(81156014)(52536014)(6916009)(33656002)(53546011)(55016002)(6506007)(26005)(8936002)(86362001)(71200400001)(478600001)(81166006)(7696005)(91956017)(76116006)(4326008)(186003)(5660300002)(66556008)(64756008)(66446008)(66946007)(66476007)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3565;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZeyWc8ttTw43GUpgMdai5Amn/f/FZSlHWnRUEfApFHQxWzegSZPBfL2JYJFSxNriJG5yFFB91XkRDevq3imyaAfBGTAGkXKqgKYTfYHlNYvTKZfVe/oGBRnSLF6hWy8qlHF4h4AVos4Yv+WFiuc4U6b7hBbVrjfR5sWdHIoKOSbiONpTDT7MnF/YWM1w0TRWiM8Bx0ckHqkwNFUiCSgbPjiPGg0swdfxaLZv0S2ER9Kz+ZJoPuUQzjJDq6A1boCN/jke26Aupee3D37KYjaPUFucm9Tqz31uT2JHH32dnhxQ7ncTKnMG6m3ZmBztowj7DXgwnn1zUe/OR3WkW1hoFFKXmZBMUxkTeDCggQEpshjJq2jUy6TM9uJNvK2bHvQsvFqmYHudIqH/gr8HJtX5r3OkVTUettasUdMbt8wS1PQzypIJKAT3SuQWqWHOTges
x-ms-exchange-antispam-messagedata: +34Lu64eiNA760g/lT8vcMOF+EWh8rWpCuK5CZzxjiWRUQJ1itP4Mf9L7TK7bau8LEnm1dOJsZ5s47eOWW3x2ng0eOtRLWgO+7TLChUc4xyjC/avxinBgIDYb076w4DybLia/jTz1Pvgqs6utI3k5g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c324b82-8391-4580-9887-08d7adf9248c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2020 07:16:26.6651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bNeUQ6hG3T5AQ54zGYVc9nkFyLmtnGEahSPXfDKxvijHn5vqQrp8efuOnpsIgm8AH7ACo5YKIG27LJTio4tNysdObKFc/V8Mgua3IJT30Is=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3565
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 07/02/2020 17:14, David Sterba wrote:=0A=
> On Thu, Feb 06, 2020 at 03:29:57PM +0000, Johannes Thumshirn wrote:=0A=
>> On 06/02/2020 15:58, Christoph Hellwig wrote:=0A=
>>> Also I just noticed don't even need the kmap/kunmap at all given that t=
he=0A=
>>> block device mapping is never in highmem.=0A=
>>>=0A=
>>=0A=
>> This potentially touches more places, I'll cover that in a dedicated=0A=
>> patchset.=0A=
> =0A=
> Are the kmap/kunmaps anywhere on the buffer_head call paths? I can't=0A=
> find it anywhere, and given that the mapping does not contain highmem=0A=
> pages we could rather avoid adding it from the beginning.=0A=
=0A=
=0A=
There's at least one more in btrfs_read_disk_super(), but yes I can =0A=
avoid them in the BH path and remove the ones I find in the next go.=0A=
