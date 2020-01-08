Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92A131341C6
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2020 13:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgAHMbZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jan 2020 07:31:25 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:53703 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgAHMbY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jan 2020 07:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1578486686; x=1610022686;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0KNvLDaPvKxX3cfN6DOIFeBmbZhtaGnfjSTksYxj93I=;
  b=GslZ4O62XTW6Ym/Js1ZzoJ2rArTCmLiriBgL81UQiZasxpZFwNXt9GjJ
   IbmfU+GxctvEi+a+Z4f+ZaI8IDkULse90mQMieZrsjVLI6k5FY6XqcDnv
   vH+6DUbGRA/iXtpnrcZP3lRLa6sl902n2WO1zk0Z4v1770xZnqMsKUopT
   hQ9PMCy2akS2RW/rgna5mG3xNb3u3qvQU/XXw40WEjTtZehEvQmvvFJPA
   2ZIaq4UNB3Ao1Fi3K4KaOZyzLjAOUoLUVTt6fXue2xF/YSYm5XPqESwAr
   5oht6BvGH3AWCigL0et2z04oUXdqddJ3WSV0pqTZlI4zSuyszkMmY0+GE
   A==;
IronPort-SDR: S521PfP9Xy4vxZhOHqHTf+pwMcO9hUndwYaLDGUyIAYvkfzi17ncX+bkEYTf3pUuYCIYEWHHxL
 Yc9fduSX1NW7M099UtBFU56lKANMZu6aNxxJyBkwLRACj1cbkFHi1vvxpLzo1oJFDINqfbbwBM
 9OcF9QHU6jE/4/LR0WNZN8IeUs7lYW7qLi4AUmRw6F+2iNqAGgazhTd9bZ04EsvXQ0VO5bYBaa
 /J7sP/m8DUSGBwXHQADC+8QVmOyAotiX3Ld9hjZD/TQRJaw6hM6usdi6gBdfIULWhYXEIhKMHK
 CnM=
X-IronPort-AV: E=Sophos;i="5.69,409,1571673600"; 
   d="scan'208";a="228650476"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jan 2020 20:31:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1Da6ZwIeEyXTRk7QyiJWLl0uEzQCuOIcD79cmHSJB2WnUecqHLqXTWEzookd395bHLkZSeENWUahLrNdma0jmGPuaofjdnyIxI5iXAHcl5YskL1XUu9C/6cp1Q+nhyKTj2uUv25p6z6hmUI5LPE9jJ+7lon6dyp3HE4g2ojTDKLrDrum4Ks2vogJdh5OjAzUxnDmYCSOCgSfpYzZ+efemLwp0D4ae1Ix2i/dNwC6ySTN/x8Yy0aptiZ+aF9dNz939Q5MxVAzFPL0vCSYgNdruWWHwzobmsxrVPx7hkOxcJ9/jZyMTIawqYl+dAWk1P8u1GCT2xZQyB+SmgyYg99AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KNvLDaPvKxX3cfN6DOIFeBmbZhtaGnfjSTksYxj93I=;
 b=S8aHj9cVsuhb5K9OBWHDDJeSowf8mEQlgomsTXn/TU6873TIXtuKrt39THpG7J8qLXnHQxb7So9DcFEe0SiDwL8fuylYnuxrFTfE+yoOZikX2CVTc/ZreS6J1V5uMDX+n45MJV+CUCvEvp0fH3VAD++gKZtn+LxEeeg1IpfyFiJ0FGjTPJhBM5+/zsb3pZAb7WeWN2usj2wAhE6bWXbSvzSOdEqmTTvPqln6jl0UAk7PGAw0T0i/EsCVQmGI63HS9wI4fFgCrxtCzDN0bxaoygSiGoeyhlMe58QMLAQwm1Zs3gT+Kfq+7nY3eRBGM586dGPUREnQl0y0P5tsCSV5Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KNvLDaPvKxX3cfN6DOIFeBmbZhtaGnfjSTksYxj93I=;
 b=hA0OBTmHTrA/wdN3x+Ceo0O8LLTKluKWIA97htFtC8r6LhfVFsBXGs1B+l8r6fTynD7zy/oO9sLVlIlQYoZsymCeR/J4NYKVQH20jCKW2cfMXl+WpKwtiglp7MGNzcaTxkbHUWW2C/0gM8L0yklZfaPjSLH2FKkCMfhGo7fHk34=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3710.namprd04.prod.outlook.com (10.167.128.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.13; Wed, 8 Jan 2020 12:31:22 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::7d4c:6c4:d83d:fcf9]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::7d4c:6c4:d83d:fcf9%7]) with mapi id 15.20.2602.015; Wed, 8 Jan 2020
 12:31:22 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, David Sterba <dsterba@suse.com>
CC:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: fix memory leak in qgroup accounting
Thread-Topic: [PATCH] btrfs: fix memory leak in qgroup accounting
Thread-Index: AQHVxhw9RHKQnSkdzkiJLri1StUEpafgrquAgAAU8IA=
Date:   Wed, 8 Jan 2020 12:31:22 +0000
Message-ID: <CDF75408-0B51-4DBD-ACC8-4EF35A5460DE@wdc.com>
References: <20200108120732.30451-1-johannes.thumshirn@wdc.com>
 <af99596c-c11d-932a-5a79-be71d2857c8e@gmx.com>
In-Reply-To: <af99596c-c11d-932a-5a79-be71d2857c8e@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a391d7cb-cac3-4912-4b77-08d79436abc1
x-ms-traffictypediagnostic: SN4PR0401MB3710:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB371087FE3ACD7147B72E312D9B3E0@SN4PR0401MB3710.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02760F0D1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(189003)(199004)(6486002)(2616005)(4326008)(5660300002)(33656002)(4744005)(6512007)(54906003)(110136005)(86362001)(186003)(36756003)(478600001)(66476007)(316002)(53546011)(6506007)(66556008)(2906002)(81156014)(66946007)(8936002)(66446008)(91956017)(64756008)(8676002)(81166006)(26005)(76116006)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3710;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wWT6F7e/xanUt0BFmypSn4OF4V9HJWWjVUpmni+ix57OasWrzEvnEoHGJmbi5KH/25+KHmpfVf6nzJQ7kqPvtoq4eYqfvVvoymBn/zzCG7UbhiMS0YIZWQp3C0wzxg8SOTuZURSUrXSTfXnv4sDSBXaeDIi3jvA3Qxxu/KosU9LEGlquEYCT1xSuyuUf/XN0qdvf3kKY7cJ6klZqWn/2UBsntoJleAxmM+Fot5EFCjfnhn8zBY4AHsonCCck7rFNY1iEnBFkKx6WRMWXk9CvBb2/HjHRv/W0SikF+OoM9+De+TChljis/XstGXijBgl6n2jn7cSJQqsNYvRGO5B8qgP8c+tDVAGDjhtTwjwOZDgpjhtzMvrkdEEQvUexT4DeemZpbfBLidkugVOHUVpYmf2BZ3yHaYQL+L8ajmuC3EKKVVUWrLL1BeoF0Umva/Kw
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9532693C71EBD44A069EB08926B3C88@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a391d7cb-cac3-4912-4b77-08d79436abc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2020 12:31:22.5252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ttamwPROH4gwmvUCmvzXkVNh0uU7cWIfdWS0UKVUD11GsPF6Vz6tWs/0hhwWGVPWYfUd+L/MtKNuAJkiZH1X7aGBDjv9vVtFePYIV3d1Pac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3710
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMDgvMDEvMjAyMCwgMTM6MTYsICJRdSBXZW5ydW8iIDxxdXdlbnJ1by5idHJmc0BnbXguY29t
PiB3cm90ZToNClsuLi5dICAgICAgIA0KDQogICAgVGhlIHBhdGNoIGl0c2VsZiBpcyBPSy4NCiAg
ICANCiAgICBSZXZpZXdlZC1ieTogUXUgV2VucnVvIDx3cXVAc3VzZS5jb20+DQogICAgDQogICAg
DQogICAgVGhpcyBtZWFucyB0aGUgcWdyb3VwIGdldCBkaXNhYmxlZCB3aGVuIHJlc2NhbiBpcyBz
dGlsbCBydW5uaW5nLg0KICAgIFNvIEknbSBhIGxpdHRsZSBjdXJpb3VzLCBjb3VsZCB3ZSBqdXN0
IGNhbmNlbCB0aGUgcnVubmluZyByZXNjYW4gYW5kDQogICAgd2FpdCBmb3IgaXQgYmVmb3JlIGRp
c2FibGluZyBxZ3JvdXA/DQogICAgDQogICAgDQpNYXliZS4gSSdtIHN0aWxsIG5vdCAxMDAlIGNl
cnRhaW4gd2hhdCdzIHRoZSBhY3R1YWwgdHJpZ2dlci4gSSBzZWUgaXQgbW9zdCBvZiB0aGUgdGlt
ZQ0Kd2l0aCBidHJmcy8xMTcsIGJ1dCBydW5uaW5nIGJ0cmZzLzExNyBhbG9uZSBkb2Vzbid0IHRy
aWdnZXIgdGhlIG1lbWxlYWsgcmVwb3J0Lg0KSSBhbHNvIHNhdyB0aGUgbWVtbGVhayByZXBvcnQg
b25jZSB3aXRoIGJ0cmZzLzExNiwgYnV0IG9ubHkgb25jZSBvdXQgb2YgfjIwIHJ1bnMuDQpUaGUg
Z29vZCB0aGluZyB0aG91Z2ggaXMsIGl0J3MgMTAwJSByZXByb2R1Y2libGUgdGhhdCB3ZSBnZXQg
dGhlIG1lbWxlYWsgcmVwb3J0IHdoZW4NCnJ1bm5pbmcgdGhlIGZpcnN0IDEyMCBidHJmcyBmc3Rl
c3RzIC4NCg0KUC5TLjogU29ycnkgZm9yIHRoZSBicm9rZW4gcXVvdGluZyBpbiB0aGUgcmVwbHks
IEkgc3RpbGwgaGF2ZW4ndCBjb25maWd1cmVkIG15IG1haWwgY2xpZW50IGNvcnJlY3RseS4NCg0K
Qnl0ZSwNCglKb2hhbm5lcw0KDQo=
