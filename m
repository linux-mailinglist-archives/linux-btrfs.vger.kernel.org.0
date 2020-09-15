Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7C526A120
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 10:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgIOInC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 04:43:02 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:5179 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgIOIm5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 04:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600159389; x=1631695389;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=6OkjmAWKoMfJCfQun9wS+ZyWQ440ZR4Ak/GISdC1MyY=;
  b=TZltN0KVAOPPYF611DHXn+2hLERuh/+RaAkrlBACR2NKTI1MzLjhuKQ0
   bCGmrxXUcZ4+YOvF9VsUw4Cb2c7ybmpn4lLXwcNVWH7CA5ERO1zvqFWZV
   gdgdwG7xVbK/kU+rBDew5IueQIjDVvE0yrGukAGtxO98jNKcqRz2hEc/R
   Hj5aRCNsUMzdmQkmX+aasjbnqjkIkks04EzMkIYJFoduPaN58y+JR6/o9
   OuoH8IlEWYArMhuerQUuZfF7zQdzqNakhMYB1RVmdWy08LJkRPToTzQm3
   Ud3+lF0h0Tx5j/v09jD6F9hlofDzuPGKSuY2Pvw1AVWtwM9ZRJCQzqmkR
   g==;
IronPort-SDR: NYQi4FnFGrcjtVMmaswj1usiyulzNY03PwqG3+x+HAPoIUCnr5TXy80Jz83RUIqWJIMS64SChq
 huA/rwECUmFD7yVq3xg1zQsUynFx88WZ1siupTOpV55NkmEv5u2KLtAReHSg6r95XKD/y9ZQKH
 Ly0dwlgWDgPQxqjIe1tyS4sCUZsus6iUtiGaQqBFkdOClkMqEmXZAAkm6EUgdaepwMPXhqI3fy
 TvlQcZIRMsuXmoUHdp0HIGAmr9K1pxj6AQJX3UCIGplA030buzgQYEQ7Qb15CHqdEnEJCKSnfI
 cIE=
X-IronPort-AV: E=Sophos;i="5.76,429,1592841600"; 
   d="scan'208";a="250728811"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2020 16:43:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sp3kFeMzypZM/pAHXR4YdD15DmJ7R+ngnqJnKBLYxWww7P5pIq2bp9Voe6M5xONGRzcV7lO61xDYIu1Mnvrec2P78/9E0YlWWrZ3o9Nb8Mh6gTA/6Tb7ZpHBEFNjskpYdMwVTDb/vagzGTj+twRJQr6HwuFxHYrqkO5tU2l5Lyqx+Jeiepd/qA4+4/Ib3rI30sPKWl78y8zL2KXKYN7PLodO6xkzcv4Hsi5V3v1MEuvcHXx3tZOia5hXfiKRR7iSDXMFcgqsHkKtuUpSIlzYvjuFXk3DNBLyhWYG3d0x7Blr5e6r7Mr3xIhozaTu7w+cr8kbM+0RY6FSv4fNF8ye+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPbRGcaHLBG1m0FFYwRMf936UKXktrqnSqFAansLUNQ=;
 b=NdMPXpqMjaXqZhsUXPPudbsF3anNfT41MJHXenIMZYvJSD5FUMoBkJ4uskTnFnMqTKfEjAFDIsUAEFnyOIrbKW3HApLRVbbhfvqA+DgBPimtncSPJGfqXxnRiaxhxttEq9norrdSrZko+uJMWyJ3LJWMEYr70kqoKzwPDNiZtNWuwppDWFXCwDq9LaCuthlHpGTZZFA2rRVVT1/Q/sBGn439HOGRg+c25ssPTdv9/iQGVjJAr/GcfFON6h90RBixZsnNc2Nc42R1sR6bGbWVbR35lXuLX7Lc62mcFJ28OUPfpJRecdSX3v30NawTTxfku6l66K9gImXSEcpwoJrmXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPbRGcaHLBG1m0FFYwRMf936UKXktrqnSqFAansLUNQ=;
 b=GZAVXO/NpdEJhudeTiyvvcJ692GVGxjuYzXu0aWxbBkN4DlCP5Se5HO3Z6432fyImQNwIA09u0sBhZfMF2FeG+cqDQPns1K72WVJwu37sgzbPUtJBwdwjM8h72rwTwt0aB+VFyjvBjV1jn1hrZTp0QJd1f+NCPWmULl0FCFwQzg=
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com (2603:10b6:4:7e::15)
 by DM6PR04MB6459.namprd04.prod.outlook.com (2603:10b6:5:1e9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Tue, 15 Sep
 2020 08:42:54 +0000
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::c862:9cd5:689a:8573]) by DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::c862:9cd5:689a:8573%5]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 08:42:54 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 07/19] btrfs: update num_extent_pages() to support
 subpage sized extent buffer
Thread-Topic: [PATCH v2 07/19] btrfs: update num_extent_pages() to support
 subpage sized extent buffer
Thread-Index: AQHWiyIdMcWiFckg70uvUuaCRMWL1g==
Date:   Tue, 15 Sep 2020 08:42:54 +0000
Message-ID: <DM5PR0401MB3591309523CD789D48387C8B9B200@DM5PR0401MB3591.namprd04.prod.outlook.com>
References: <20200915053532.63279-1-wqu@suse.com>
 <20200915053532.63279-8-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:3d01:38cf:f1ce:e1ec:d261]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0da4301c-6dc0-4947-b75d-08d8595356cb
x-ms-traffictypediagnostic: DM6PR04MB6459:
x-microsoft-antispam-prvs: <DM6PR04MB6459BBB04CE16F4E251BFA669B200@DM6PR04MB6459.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sfpQmXWQNITFnnzRw0UFH7cIlP5RkqrPSYAlg48yeo5IbNBZyYEZEjQo/EA6fSHwGFZHOYQTiXFigGh5j3HOKLYdJBW6NlhHsHmh2VnoMD8jCQ+l6agYjOsARjQFC1vLr8ikmKdKXVpRYD2lTAtWYjR/ZyatpJKjAZb0zgegfu+skA/korzY9QLgLe8XNLfe0X0DkpQhr+YxcyRgOz0Mwcr8QU72YKQGuFBj0nuyPndobS+tYkt2K1kcbsJ8LCHY/PRXz3aRxvScVOenUwzg9qTZLFejYRXazKrU624KOPQCtzkNBkV3vo8NWLPz2AZM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0401MB3591.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(186003)(478600001)(83380400001)(558084003)(8936002)(316002)(110136005)(76116006)(5660300002)(64756008)(91956017)(66446008)(66946007)(66476007)(66556008)(86362001)(9686003)(7696005)(52536014)(55016002)(8676002)(2906002)(71200400001)(6506007)(53546011)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: SOBpxTxDE09bKTI65IaoKFEPJmKidiUsMD/QbtMY/A1jybb0t0GGOIXFqS9eQfv3hALBcorAoViZDM9g2yMEzkAzPk9OKXOWcMX2LmfxpsUrp/JMvObynzGW8OmsqE8fBPy8xROWR6tVuw+c+6Xn/wd0P1X3lqmxUjInLBXUUjmYL0iATiwNQjcbwDwZ6+fhhzcrdWiKOA9n96gh0uNo1KqWgS66k5z5X5enzvfgEdBwpIlPEER3x4/euD4qIH5IYVkz18+3ZxCmBk3IBpi+FyaniTw+evhw/nIYp+hys0ordYPUFnvqooW4ojdBJhWpAOewP7dIqjMuz122emHaQ0CB6wXDW+YUDtO4qGvE2lLBJMM4plTYolqhAKD8YyKt1pyzz/o1t3BF2dq/1MMVogkvkiqM56OIIRlW0tY8/HTQE1x8W0YZ3Oe7z0sCnhNgyvloJNNKG3ERGSO5CF4Vz4Mn7nOghyjqdHEMpQn80KePOeGTpkJcW4T1m50/JVj3GBNWo5QhfZzJAIA8ti7FtqmVpsD1dTxPHmfzPYHDIFHAer6z8Ka9mWzwkMBTPtriy3cgA+Rr5LJt8vJ+EgJqx5ISWGRWQ52RL80v6ao/mj6SyBvb4RULBIb+582xGHZ6+IuMGHt15zx2JPnCzKBRR+7y8en5nHPoEryHFsrPh9BTi+83/EOyl/7mt9d3+Y10fum0ESJ6mY8NozLzBuDB1w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0401MB3591.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da4301c-6dc0-4947-b75d-08d8595356cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 08:42:54.5204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FA9RsF0kyj6QhTIPW43tk3E6nxzJpAxhNAyB0iJb/kGkHJFUivKQkjnMC65AXbHj/aNnBvE2fHw0LmVFhBJC5axtALMtsGUkoVgIzj3mVVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6459
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/09/2020 07:36, Qu Wenruo wrote:=0A=
> +	 * For sectorsize < PAGE_SIZE case, we only want to support 64K=0A=
> +	 * PAGE_SIZE, and ensured all tree blocks won't cross page boundary.=0A=
> +	 * So in that case we always got 1 page.=0A=
=0A=
Just to clarify, does this mean we won't support 512B sector size with 4K p=
ages?=0A=
