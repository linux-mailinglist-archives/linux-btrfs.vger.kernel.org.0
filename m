Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6CA2152BF
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jul 2020 08:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgGFGiZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jul 2020 02:38:25 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:43135 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgGFGiY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jul 2020 02:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594017502; x=1625553502;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Oii+SYRXSIb/lCDbMJ+S1tnP9yrNlZIrYaGZF9J2yug=;
  b=lWWUPL/ZFEyzsSjYCXI4QrN3P+I9bqkXyovnGS9X4oQ0gwPmusxvaMcg
   qUIg0h5ekEvWOdjVDgjG7LV8EpoELBbJkkWGJ+DGHrOIqT/fB7xycSdwk
   +33mKywi7kioyHGL0ICDlUtaNO8jJdmN3XUCRTeKIIq7YIjjJnMGEb7Vr
   X4C8eeCDdrJUEcaPHerPcRGAsfsxQuONSp+Z7a9Uh6N8bIZGSwV47cRtQ
   4MaARXQhn5dmiZFEXr26bGzDKqujB382d9w6tN1ea1oe836BOV7Yw9FQ3
   BywnwgVub4ycpYLV3+SxAt5D4pIJCzqg1q5dh5iw0kLv00uWHyehbwSdY
   Q==;
IronPort-SDR: Jd1S5iVMKb1XiWY1xRDOznqS527ekigIw5iBWtOhqIPxIJbDD521H2y0N+wMK7WLFEl6gBJNQr
 10FYcqSy9rSu6I7lb55PCW+nGZBeEEOB23W8WauL3BzyrxKA3vGfkZdIjU07GTO1v3xwRC2ZHG
 gyy3A/SvS1GOtzXWq+FfAJkzDfoC0l6R1Q3H6LYWMOqMl/AXHRxSusxiqQkk2R3Aa7zEtOAS7z
 CD0KbuPZ9r/yplAC0+2rB08WWnck1TmoTvdcaptm2A/M0lByowTpXazhFhVSbOl8Qb5EDshAWi
 p6s=
X-IronPort-AV: E=Sophos;i="5.75,318,1589212800"; 
   d="scan'208";a="141712063"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jul 2020 14:38:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiAEzGVxTXYaCMbGIXzDh8pQEr18wNsZrH02djWkBnet2r+0cBNsRJZY8dszh6IrJ0n1NJt4bY+Jsxx6oNdYF8XYWS3wLQGfNpqW3lWL4e0SFhPXtmYTnSWzG70GYIfdYx/N8XpsysN79wkgOIh5ubAUjqhO8cc8n8zyjiRO/LUWHw3qNRsIqm0wHysEPpMG4ZFJltgGkqQOAVx88RMHNljTfpwnLsH0nFAgceMihXMO27+0nl+x8YsGfLNR+hAn7reUh3obcjOkZa08KVXJQmIj3+3gZtVH5jHOW8gWcQRLOnbpaSGxEwW25NZS4RaPI8ASI9ZGQrdItxsrq/u+qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQAaGbLKKIXUX64DYHjoa1oxH9ax+y4u3dQFZ9Ar04U=;
 b=KVfnuCUQoXzZSNl8GnjbSL1s6edeiU33jgJHQc+352x6t9RN2wkFJxefmZowLN6UhnccKcRimNPttVpdVcSGy2UJTvNvQVLF6r8f8PV9cMm+3HLPuybwzEtAcWAtIp8Ad2dSJfa1NQUgFeDUo7PM2i60KdB/LLBAOqj7I668T+9Nh3J+MXkATxgsxHDBq/r1zjE4RmxlPJN8lelX1RPW8r852dtCJV6s8AmdvcB4Y9HX8dCOzFVd0CvSSxtaiyIGf6S4SJntj27DJC+g7rhadIohNUg7+l9eiCsbSq8LmhcZ890bQIwKO4W7kblMbvEELecg28zmD29voXtPIK1p+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQAaGbLKKIXUX64DYHjoa1oxH9ax+y4u3dQFZ9Ar04U=;
 b=QnIa1J9R+EzLj86aK/wHRp9TTflXBb6N7SXKg5hLUKf3hraM8Ifj+XUBM6iqRM6PVLeR/aV+Y7tBzQAPMh5XiRl/t40/uLv/nmvJ4s63vIeieWjchHGHEts8/IquZIFhXQYmmmeaG/aFFVuNYtpsX3YXhPlWxDeN4zDfbZ1ffkw=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5327.namprd04.prod.outlook.com
 (2603:10b6:805:103::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.29; Mon, 6 Jul
 2020 06:38:19 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 06:38:19 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Nikolay Borisov <nborisov@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 01/10] btrfs: Always initialize
 btrfs_bio::tgtdev_map/raid_map pointers
Thread-Topic: [PATCH 01/10] btrfs: Always initialize
 btrfs_bio::tgtdev_map/raid_map pointers
Thread-Index: AQHWUHdF5CzXOIbGJEiGQaCbkMHjwg==
Date:   Mon, 6 Jul 2020 06:38:19 +0000
Message-ID: <SN4PR0401MB35987003E71CA291A89EF5079B690@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200702134650.16550-1-nborisov@suse.com>
 <20200702134650.16550-2-nborisov@suse.com>
 <SN4PR0401MB359800E3D7D379E9161318379B6D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <ac973720-9d3b-1824-e7de-16e15b364c9c@suse.com>
 <20200703155757.GE27795@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.235]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 07422ee5-abc0-42de-3488-08d821772c2e
x-ms-traffictypediagnostic: SN6PR04MB5327:
x-microsoft-antispam-prvs: <SN6PR04MB5327D10ADA895A602A64743C9B690@SN6PR04MB5327.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 04569283F9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qEjt1TpNs9HQlJCMEH2VJBpQJbsHB/c0Ue/6R3Rg8idO6XRLZYySKVil93cUGTq2ogpYWEF1+5u0SXien4njY1NAFCfPp0Gdm39M39iyvToT+fRKv6RnYkb9cnyD9IDmabzqLT7pCo+UHGnHLLilYTKSXPlH5/G9OENhlTiSZs8xawsMdmzm71sn6jZKXEktE9J8ZIr2d1sTrq77EruZhKxa/DHL5sDwr+GY0Ux8i8xCXSJ47Puykw8vRIcPi5lrn+s2RU2esIzpuIbUAJAS089kBHC42y9YBuaHAFlwBEAfVW11b9PRZA2MO603NuCvGLMbm8QYiC5QQfzpU/j49Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(55016002)(26005)(9686003)(83380400001)(4326008)(110136005)(4744005)(8936002)(2906002)(316002)(86362001)(8676002)(5660300002)(66446008)(66946007)(186003)(478600001)(91956017)(33656002)(76116006)(6506007)(52536014)(64756008)(66476007)(66556008)(53546011)(71200400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 93yDUMBgPSHBRDvmCCrDjytwzdEEyb68kuehRSh1X4/iYT2CGIHM16GKmzZJwY/zkXQUi1yJoL7lpelLjXIG/ALFzOWmdwi0aGSc6JQZ9jkG4yT1/LQFIneshbpK8bjhPTdd1nILhoXaUnHebbw2JIowkNnTQ5RDzLRBSlTMasjb5+liUIvBtYiXZLZ4YFeZAC5U/M5k6YnQv6lpxk0ZidqsmDM00UKZ+hHYMRZHV2Is/36ZfdwkudA6WQyJwow3h7j+OwqrLfBEJBfTaYZgnhPiGHlEdqT0+QFb958RIQu0r8vFopHoeZ0TgXRTlYAlqwJRYKWo1IxqjhDQnDQyDQoFgATs5Q6pyn4DjX4NShe6uEUWGlOHN3qv326eXlWOy4Yn0VUPc3anzfDBPNDUIwr+u8GO7m7ugiCk5vwCIuK9395Bs4ycVLHoqEfMSdxFfZH0YXRykUdRjErbtSdzHxuxBiW2WyJWyjiBu6xWFWT2fEh4trLvpnotusUSB2mc
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07422ee5-abc0-42de-3488-08d821772c2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2020 06:38:19.7278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x3zUDz2zoVlm1Cy8gKq/oZUXEufoUOFp1zygd2lmVAGLsx+QGu1Uh8Sf8NYBSymqxhluDjym7C6mNoq4CV6r4t1SzByCrpjDmGsnPm+OeDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5327
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 03/07/2020 17:58, David Sterba wrote:=0A=
> On Fri, Jul 03, 2020 at 11:31:02AM +0300, Nikolay Borisov wrote:=0A=
>>=0A=
>>=0A=
>> On 2.07.20 =C7. 17:04 =DE., Johannes Thumshirn wrote:=0A=
>>> On 02/07/2020 15:47, Nikolay Borisov wrote:=0A=
>>> [...]=0A=
>>>> -		bbio->raid_map =3D (u64 *)((void *)bbio->stripes +=0A=
>>>> -				 sizeof(struct btrfs_bio_stripe) *=0A=
>>>> -				 num_alloc_stripes +=0A=
>>>> -				 sizeof(int) * tgtdev_indexes);=0A=
>>>=0A=
>>> That one took me a while to be convinced it is correct.=0A=
>>=0A=
>> There are 2 aspects to this:=0A=
>>=0A=
>> 1. I think the original code is harder to grasp ...=0A=
> =0A=
> Agreed, the rework is much better. Though understanding that's an=0A=
> equivalent change is tough. I'll update the changelog with the=0A=
> explanation.=0A=
> =0A=
=0A=
This was my point, I'm sorry if this didn't come along correctly.=0A=
