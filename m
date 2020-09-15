Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4105826A2DE
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 12:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgIOKMh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 06:12:37 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:2516 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIOKMd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 06:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600164753; x=1631700753;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=0nD+urLlYbpVlppRp7r43q/6+hPh8xXL4dj2rnyFFzs=;
  b=PUGIo4T+W3YxcujJUxyMVujgsxfIvVSiqNMOYi8zpsFC8qiSaqW+PeGs
   GWRABShbqD0Ko29F7NAXOn10CTNA9H2mdb+ZHAXs3Nd7v9pMzOuamI2sa
   hvTnTbEb1JWxO/gP0Z1Ob2OfAidmOEi9aYyQzsrmfroc/9XKOchfDum1q
   76NWMLPWxBDdc0woOgjz+cbJeNYsnhNpk5yNt2Sk8k/+7oW9LdyZmdeDG
   oHfo1HRbn6PvaylImdu2Yu2/Hf+GbGghEI13c6OXxA+H6xLEfiJjL0QG3
   BHXEvw5x1HgOdgxdwCEjkiV4Z5T/HxaXUAQNp7+hBy1ON/MZ/dwVwDZLN
   w==;
IronPort-SDR: Uov92f62bQWwKKiQnKZ6KoEjpA84YmzSULEkL2Lqa1Kjceh3TQ3QEd/g7aGAyRcg5AR+ClPxV+
 O5pUV84g606kx/69maqq8nKxh0up07GoMScytbeTEEPPt4IMRAqSYHSSkg7giFunViPSPKvips
 xorpCz0NP80FuJwTMYsCwfCwnwy9lEnLO6/7C8nGLIqygFt4hn8dWl/xnuK6s08z9a2j9NC5Hg
 O3NXWE+eI43o/iG6whiVl2wu7cn0v3SIhzCw0EwEBkaWcr+/Wexo0Jzj61JlaGHaKdosm85nCN
 rXs=
X-IronPort-AV: E=Sophos;i="5.76,429,1592841600"; 
   d="scan'208";a="257052346"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2020 18:12:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEHqH21ldLW21+aCM6la38Wf4HROSGgSWOxaXGWfZ4B3Si0F6r9mLLIP4lxW6p8GMH+TKf46MxbUhKWYku5D7yX57ZQLASHJO9LB3j1lZPLwjJl1DHxOtyZZRRncFPuUS4UV1m2hXrruz+YGRJg3V8UI/3TfxfNyuYWT8rkqzisMRYnvND6yY5/Lg7zXDbpHttWRAjsXRDdwtbHUZ9RXU/PE/I68aVxP817usHs5GUrwOqDJm0p1JxyLCM8Xbfos47i7kZQ5r3uAGE4BLZsRomeMUt3nP0DqxDYFF18HPytmGfEsy2v1RRxhYRxj3WRKoy5mg4qnKmFprn4VAEhcSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJKpgsJTvIQQSbpmIuIs2FHr0PWNDpTfPVrFPFENtek=;
 b=SVrD+OyMtHL8yHmNL02XJKmScLwvKJljXlLo8eHmqx+UYI/sAxlckww/791LTGq32JfEbWu87e/O20GC1b/VtDVA3r83yjO0IP+D2CNo4zoBQ8KXJwpIZbUlwftscpAWN09lITPoanK5KUQOk7b/b5xTOiG095i/fTmjjJg6enFv5zWuo47LPNBdz1dmNY61leqVdtlXmyF0g5a6wNlEcgECxkuOZUJ0J+riihxXMq+A6Z5jtPcYzJi+vHTzvWM+3Euu9pz9hUSUUQJr07+0xTNPXQWiAn7gTZusx7FLpxTc43/nVGwFcZDlSeUyyxngkS7yagbjVficvG44zVsXYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJKpgsJTvIQQSbpmIuIs2FHr0PWNDpTfPVrFPFENtek=;
 b=MbZCEFPQ1RHEqnoQoAWZICST7aJe6Fc+pA8gP+y4+hajgdt69f3SARihXjk+AMz4iaDdhfdNXYpt0B4Mdx8Ruebuis34sDY6GU1JNB2SsRiIXrYuqJ3wuVlUVRWHck0qYNIAIVGa6zV+Ox5J7rNmutWwORzrtsWXzKbAnXnKJKc=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4045.namprd04.prod.outlook.com
 (2603:10b6:805:47::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 15 Sep
 2020 10:12:32 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 10:12:32 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v2 05/19] btrfs: make btrfs_fs_info::buffer_radix to take
 sector size devided values
Thread-Topic: [PATCH v2 05/19] btrfs: make btrfs_fs_info::buffer_radix to take
 sector size devided values
Thread-Index: AQHWiyIaFB5Tct8Sd0CX7t+FPfvMLw==
Date:   Tue, 15 Sep 2020 10:12:32 +0000
Message-ID: <SN4PR0401MB3598BD05FE3D2448EAEB3FFB9B200@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200915053532.63279-1-wqu@suse.com>
 <20200915053532.63279-6-wqu@suse.com>
 <SN4PR0401MB35989CC0C4C17E2FA93A2AC09B200@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <03ad022a-6ad2-5eab-66ea-008a97104189@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:3d01:38cf:f1ce:e1ec:d261]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8b7fceba-52ae-435b-b7ce-08d8595fdc17
x-ms-traffictypediagnostic: SN6PR04MB4045:
x-microsoft-antispam-prvs: <SN6PR04MB40451442B49D270205764E989B200@SN6PR04MB4045.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sDLVa3DLW1G7fSpdXggrVWDW1PipnGZehx4bSxEUFvApbyknILrhexaPGN9jgEuIk+TtqhD2LYmJ3lTO/UBqhMQXkLll8z86hy9OaubGg/xa47RsyYyGMX2dGjLp+em1Of01Bz6x+YrjcIb3iYB3HH2+hFlEwMo+wl0pQKPVT6wtecUZop5ePqw0HE3bR+CRK8pnHUlotr3TNhg4GMNLHayd0VgjZ/KXcv2kkSCVjoi7Is0Z9X+vacTGFw0BVwFVawmqmGF3U4hlda4PfMrZXToPQGoDvQ3EmyGY94WCGA2hQ8KUmQmy2S5DuK1nog0P
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(64756008)(8676002)(33656002)(55016002)(9686003)(316002)(2906002)(4326008)(8936002)(71200400001)(6506007)(5660300002)(76116006)(66946007)(86362001)(91956017)(7696005)(186003)(66446008)(66556008)(66476007)(52536014)(478600001)(4744005)(110136005)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: z8uijjaisYOT75hJoMNY6fHDteMUjBRkGwb7N8a5v0n2X7gn1o1AgucAVnn5chZSH4QyQWFUTSiW5Afon7MDXep/TR6WP96NTKOVJvKEniKuriamD+O5YvABR6Ezz627s/foKJ0OusyIj6X6vQvzEXfPjbIht89venRl4bda5VP/zSfQOKjM5KZ5hHxhWb11U02gxNio/z26as5XuZ1wor0OEgIzIwk5f2ckrktEEclrBuQlVvir+GiZ27sgXiXrcPSRGg9w+1hzIbHLQwY2IUjf7iaYnNI5NGlghVCZ9Qq4Oz8X9T3m5tRxeVStyMWQwT/2YlhwvoHOjLZNzwhU/qOnmjhnjLx41ajTFbuUPkTg5HOJ0GDAcdaFQseiAiM25OxguFOkupP3PbWw3maWN2kK2HXr1IevehiA6YgfbADNmtBpadHsFflgR2y7c11c7UNPCfIR9juGW1Xk67yM9SmnVSqmDqMdQyMHqoE2EMyjBZxhwXpSGff5UnRMnrgJmWbT4lolxn7q4No5C7LAoosxMh7wFkL1NpyBYCIAQg13BWJUfMNSjuCMdf1LDTJgs9siUjxvPBFxa1QI2B7uZZ1/av1PL/C+LFe2rnGA5PqqC9B2a394A9QGghUF2JsxhLxWHd2hbZ0qNCGVYcpwuS0nx2TSIeGymVLvScVY92Mu1oXB3Obz2XxHbGMFxqAGXOnabFSJugUrcZ7SKi00kw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7fceba-52ae-435b-b7ce-08d8595fdc17
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 10:12:32.0313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hDXkIUfxYIqHL/0hENoRGWZJaDeexGucYpYnZuPB5I8TLs8wK8B9YDhikgmbieT3LPQxzn8uEQs25HCYJ4stz1p6Wu1/cRxiKEW2FKZKQ/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4045
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/09/2020 12:04, Qu Wenruo wrote:=0A=
> =0A=
> =0A=
> On 2020/9/15 =1B$B2<8a=1B(B4:27, Johannes Thumshirn wrote:=0A=
>> On 15/09/2020 07:36, Qu Wenruo wrote:=0A=
>>>  	eb =3D radix_tree_lookup(&fs_info->buffer_radix,=0A=
>>> -			       start >> PAGE_SHIFT);=0A=
>>> +			       start / fs_info->sectorsize);=0A=
>>=0A=
>>=0A=
>> These should be div_u64(start, fs_info->sectorsize) I think.=0A=
>> At least 'start' is a u64.=0A=
>>=0A=
> Do we need to call div_u64() if it's u64/u32?=0A=
=0A=
I'm not entirely sure either, that's the problem.=0A=
=0A=
> =0A=
> Anyway, the final version would utilize something like sector_shift.=0A=
> =0A=
> Thanks,=0A=
> Qu=0A=
> =0A=
=0A=
