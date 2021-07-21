Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6513D3D06B3
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 04:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhGUBnD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jul 2021 21:43:03 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:26238 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhGUBms (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jul 2021 21:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1626834204; x=1658370204;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=k+lAMJoI5IQXqMogiAiKtogk87XlZt8JPrGZl/ZWbjI=;
  b=VJcSEWjbvu91iw0+jrq5yvSXdEraOJTvZKc1Rq42UH93qIsJQrOdRSH8
   9QZcGIGksGBQC6daVT9U4iJHMd/7rXEG7dlaqVOoezsni3TucxRuqJ8X6
   0qEXH97pzbD7s1hZMheHbOBFmvvjVw1rIa526qTdKSDUMmjr18V1h4jHX
   6Om06tBC1ffjAAIZPOWnz2a/6FhhKjJygpzecQwXL8Y2c5RYUIhMs8ext
   yZsYH7al/C38UUE63KWn2c+wG5lBo5y7kA7ZtRSF2kVaO8/AyNx/lhBPY
   FTmb00+O4zFPYPQDUYdx9Uv81IdjAXlgiOm1a48tFH0yRtyw6gwIiKczG
   A==;
X-IronPort-AV: E=Sophos;i="5.84,256,1620662400"; 
   d="scan'208";a="286644786"
Received: from mail-bn8nam08lp2049.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.49])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jul 2021 10:23:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IeVQtHKcATLAKzQfikHYRKe3oOkgJQFCiIRTclJVvLoZfALlmOUspqx6/3R06Y3KlCLLPR0aN6fX6Hay2gyaEHZ3gYhWG3EiWTrAgB0S1SvhRO5nlzoD20fCZWuf/vR0qcmIsu4ndpBrqCbkURvnnlT15kMYRtvnEs+NquBc/QNBEJlaS2620qxpHy2CKDui5WuQUVLRoaaoauTm7eYluIX06fB+VvKVvOVV5j74j+kZs2GLhroW2kor5/2su2wzIWZm78OIwsDZI0Tu1GIuS9agg8uAcBfooFeiyF6VEVYhdwxi3fn+4aFC+msp825ZGFdYZe5DK8JHGsIlRT5j9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFen4p4ZQaAmV76OGXqgK0aSmY5YJBhJDaCkqofCuGo=;
 b=A2uvEqc77KdITxgn4+DdANgwXBtKBe8iO6v+4llKHZKvo3VuwYNR+aQyF9IrbQan9s0k/LWTE6QKsigzzF2bwZCMfp7aJi6ytkiHoDe/xCFMR/bGXMM5aAQNLK1Oya4RRD82rkpiTCTpACutNzJAkniSP1U5/nIiyh659DzpCDZIaGaKmHTltG7NpFODploXziMV4ucKQX+mjQJHHccSZwYkga2QT/H68GVZ5ZlmeJ6nVn3S7BPMRvmsW2DxzLiZTHvxoYmnWF5GkvGe6+u1q93ZszlvHB2J1UVIgMeF6sw5+i7moObjy28tioVfFbSfE/Yric2fB+USXtmScsSSbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFen4p4ZQaAmV76OGXqgK0aSmY5YJBhJDaCkqofCuGo=;
 b=ObYaI29c0GL1vcQGSAuICR9dyx4AEBhllDOqaXEnR8BgWD6FDqzt9rM1opYDzFZ5p7ucMAUbqLCQABRsonn6jpHYRIrG8hBkqRMT5DnnRpTMey4bCr+EEvMkl0MkqGAfas64Ma3sutrQnp5WDe8bF3TNaU54OQHFeblAK8/vSpE=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM5PR04MB1245.namprd04.prod.outlook.com (2603:10b6:4:42::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Wed, 21 Jul
 2021 02:23:14 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::44e6:14cc:4aab:3028]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::44e6:14cc:4aab:3028%9]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 02:23:14 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Dave Chinner <david@fromorbit.com>
CC:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eryu Guan <eguan@linux.alibaba.com>, Qu Wenruo <wqu@suse.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH RFC] fstests: allow running custom hooks
Thread-Topic: [PATCH RFC] fstests: allow running custom hooks
Thread-Index: AQHXfG2fWDdjhzQOeEu+kl67J6FQkg==
Date:   Wed, 21 Jul 2021 02:23:14 +0000
Message-ID: <DM6PR04MB70812AEDDAB6DE7951F4FBBDE7E39@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210720002536.GA2031856@dread.disaster.area>
 <3f2d4ebd-bf75-b283-45be-3fa81e65d5bf@gmx.com>
 <20210720021437.GB2031856@dread.disaster.area>
 <cb2bf09e-91fd-2976-4366-4daf29664890@gmx.com>
 <20210720064317.GC2031856@dread.disaster.area>
 <20210720075748.GJ60846@e18g06458.et15sqa>
 <3fd6494b-8f03-4d97-9d00-21343e0e8152@gmx.com>
 <6b7699a9-fc5e-32d9-78c5-9c0e3cf92895@gmx.com> <YPbt2ohi62VyWN7e@mit.edu>
 <f37bec82-85cd-b818-8691-6c047751c4a6@gmx.com>
 <20210721011105.GA2112234@dread.disaster.area>
 <ff57f17c-e3f2-14f3-42d8-fefaafd65637@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b05dc18-bef9-447f-51aa-08d94bee7eac
x-ms-traffictypediagnostic: DM5PR04MB1245:
x-microsoft-antispam-prvs: <DM5PR04MB1245A276A3514A1EEDAA0A98E7E39@DM5PR04MB1245.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iYmTfiJL6FU7RfVZuj590BuoFNPFXho3ye68jks0rtNgFyFsRRfDqXx/BqzgINFa2LQhrCB985SIpfwIZI7cg4c4K/Y85AAFIs0kqvKt2T8fxIbBq2orkxk97Y0gmnrNfEFEqkqRVIbuwnf6XTAHRHdE8fyUQz2pbh8CvLQAgAa40w3FIlAmYYBvjEF16FZXvOyNwzRocsn+5kDRLMsBph8X/TSfaFdy3PF2h6CJSQKzrHFyMZeqTf8uk/nspdQ2ZO+LaNpmT6VlC/tGX9rnGOPKLG2Dt5wab8AG6Y2A+/4HXdzlky2zfTd01mGk0F3oSFZ0Sjl3z/hfWVv5xvEmWAsPAhQuoI+a4Vi0Z56NV7BDjBgzdXKTX5O5/4I8sI9dNIzFhc3nnWR8C1scKE3CgMiDmjmHf22cfA5vV9NA9cKMYybmefIJlJhdAYNaKBejvUgWULZ7dOBA5AecOxB16W/o4OFncfw5Jz1YQTpbzwyWnCoD6hlDG3hs6jQrEgVWWzVE7PfBzHKlXjemTgHe75L/lTRiY0feKenGDNQlfewG/2a0ZWpVs57OOR6vfz9SDZaYC20VMPHdj4ZVEY0e4TxiR3q6FGDVRGoPZUIM25+1TlhxEWbg7N0kpCLdvHuoqxe/mFtVBsMJcwXwKDI2lhwQVP1xXf5atN6t9hg5Li73E82f3wnEDn00CIogZIosNHWltyjZzH8B87x9ASGSNwoGOhuiotoMVlXK1Ctrejo8gMK+n6PRgrQSxr8pVTnyLTEDggWKHJYYpg6uJHOWr95mC/nEVUmmmIKnIJTevyk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(66946007)(7696005)(71200400001)(66556008)(64756008)(110136005)(66446008)(66476007)(91956017)(55016002)(52536014)(9686003)(186003)(316002)(33656002)(4326008)(76116006)(966005)(8936002)(83380400001)(5660300002)(508600001)(6506007)(38100700002)(2906002)(53546011)(8676002)(122000001)(86362001)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?QnBKMlJidlY2aUJPZXhwSTlrQjczZW5jRjA4YmIzRzBYQmdDNkN1czNp?=
 =?iso-2022-jp?B?ZnN6N21nWTdTUm5FNmdwb2Robm9yQWExRUJMamx6aUJjZ1J4bzErdEk0?=
 =?iso-2022-jp?B?ZzRMQmtZNnFkYWM5WWI4KzMxZ1Q1RHFQS0JwbEdmRUNpVE5hVk1ZZnJG?=
 =?iso-2022-jp?B?OFd3TDdzWEQrc2p4Vi9wQy9ycGtLNDBudDBwc1l6TmtQZXNDZy9CZXVo?=
 =?iso-2022-jp?B?QU1wVXVaN0IzeXZLUkc4cmNKbDd1YjZlSzNXSkZuYW9aOHNVV2wzWXZz?=
 =?iso-2022-jp?B?MXZpTHpoTWtlV0ZsMHhFTjlnemgwaUp0MSttMlIyTzNxQ3R6aFBPMG13?=
 =?iso-2022-jp?B?SkFlanEyOFNiRWliOWhCNnRpSVFkRVk3ZzVVR3BpRnRJaHlrSWpxM3Ny?=
 =?iso-2022-jp?B?NGhWMS8rSmUxZXAwZGwrL0JscDkrd3VSdDJlSjRMRE9TTWJqYmJFc0Ro?=
 =?iso-2022-jp?B?Q3BPQ0htWDJoYkliVFUySzUrQU9hazBZUzl6Mk05N0Z6YW8vQkxQY29Q?=
 =?iso-2022-jp?B?YUttVGlzcVA1cVMvK0xUd2VkOStwMFY1eDg2SGRzV3pEYUV5QkR4TTNm?=
 =?iso-2022-jp?B?eVN6VEZiN1UzeGdMYUVidVhGRkh1OWxRRHYrTzZBWlE2MHNDVWV0cG9t?=
 =?iso-2022-jp?B?c3R3Tjh4eUJlT3VONzZVNGRrbjNIQWdib3dSY3V2Njk2ODlhWmdPUG1J?=
 =?iso-2022-jp?B?L0p2RGRyNW1yRVZkRzdPc05pN01uNWczTyt3UEloaW94RkpJS01kS2pV?=
 =?iso-2022-jp?B?MTgwL0ZObUovdEJMV3hrdTdxNms5eU16dFJ6R0tHVy9GVnJOOHZnTGR5?=
 =?iso-2022-jp?B?SXZYZ2w5WEl6TVJqcElmUEI2WGJ6SDd5RUdYVkF6b1A5Ym0rT0VxdTFL?=
 =?iso-2022-jp?B?Z09FZWk3MGJEcTRya2dwRGIrcXd3UnNKZDJPWktHVW1jVG5pY2Z3U0pI?=
 =?iso-2022-jp?B?NnpGclNzbWNqZnB5dm9vbng4YUhsOVhsZHVkdFEzQVYxOVJlQlFCQU14?=
 =?iso-2022-jp?B?dTgzM1UwSXUrZldDQjF6VmVRL0lFdUY2V2NRTUo3UXI5OEZXNXVBV1hF?=
 =?iso-2022-jp?B?NVpLVXUzMnRUOU5nRjk3bENZQk9tYmpiTVhMbVZwdWdOQWhvSDZXU0t5?=
 =?iso-2022-jp?B?TDAwQ0s1OFBkMGR2ZmxYbVBCWWZOcUNGWEh2UjAzQjNTSHFWaXV2SFoz?=
 =?iso-2022-jp?B?UzhWL3J6MVplVkJ4dmp6eDNEMWhkd0IzQTd2SHFaMEJhT0N1TXVQZ1JW?=
 =?iso-2022-jp?B?ZkdhMzNSeWIvVDNMazQyeVY4ZGk4MlZXbVpXVE5mWFAyVm92RGZqZzA5?=
 =?iso-2022-jp?B?aHdra1VTUmxQT1hTeWNUUzVNVDVsNTdGUWd4M2wzNmFMNCtxL25UQVQ4?=
 =?iso-2022-jp?B?ckdzTnRZYkFldDlqdFMwL1NZcHo5OUo3SS9xN0ZDMnNNK3UrNXlCVjY5?=
 =?iso-2022-jp?B?ODFFenZkdFdac3hrSUtSOTl5Yyt3MmptQzFBcC9UVzIvVlJaNVhmNG1L?=
 =?iso-2022-jp?B?b0tVNmxPc0hWSS9IRlNXWTV5S29mVk9BVzE3ck96S1hrNGpNQURvNnJr?=
 =?iso-2022-jp?B?RTF6eFdYRTNna1N1V0x6UitjN290SHJ5RU9JKzMvTEI3c0oyN1RwN2g3?=
 =?iso-2022-jp?B?Z0hMTmZNdWpVTmlubFJHUWVJT3BEZHFRakNyejVaM29KSzJwQm5yaG1n?=
 =?iso-2022-jp?B?MXRQRlJzM2lqQ1JvTTNGQ2J4UFdXY2tnTnB5WHZmZ2hCaFdweXlDekRX?=
 =?iso-2022-jp?B?enFxN1AyZkt1cERmYzBNUG94azNsY2szMGVVbUl4MkNGR1NTUW5DMFlT?=
 =?iso-2022-jp?B?ZVVLUjR2Z2YwR3k5dVUySk9TQU9CeVhNUEdjQmRqdlY5OG1yeFVpY3Jm?=
 =?iso-2022-jp?B?TFRKaS9HWHd3VzlmN1g0UUhCWGpHRWlnbWFCc3FQR1VJYUc1Nk1WRVF2?=
 =?iso-2022-jp?B?UzA0U3pkVldneEoyUHRQd2RZMGJNdDdCRjRpNmZrWXBEOEVhb0ZnaXps?=
 =?iso-2022-jp?B?T294K3BHdXpIRUhuNGIyc1VlR29XdXNnT2FFMU42MlBuRTQrN1d1Z2Rk?=
 =?iso-2022-jp?B?dFE9PQ==?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b05dc18-bef9-447f-51aa-08d94bee7eac
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2021 02:23:14.8152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NnvVlKeSkI9ygjoFHI+BPgcf7xOX2/z7wbMp1OBQzt/KOyVHfzdoCz0DYP3LBL3oX5UnOwoufC/0VTmnCqETRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB1245
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021/07/21 10:53, Qu Wenruo wrote:=0A=
> =0A=
> =0A=
> On 2021/7/21 =1B$B>e8a=1B(B9:11, Dave Chinner wrote:=0A=
>> On Wed, Jul 21, 2021 at 06:34:16AM +0800, Qu Wenruo wrote:=0A=
>>> I would no longer consider to upstream any simple debug purposed code.=
=0A=
>>=0A=
>> Qu, please stop behaving like a small child throwing a tantrum=0A=
>> because they were told no.=0A=
> =0A=
> Well, if you think so, go ahead, no one can change your mind anyway.=0A=
> =0A=
>>=0A=
>> If there's good reason to host debug code in the fstests repository,=0A=
>> that's where it should go. See the patch I just posted that adds a=0A=
>> dm-logwrites replay script to the tools/ directory:=0A=
>>=0A=
>> https://lore.kernel.org/fstests/20210721001333.2999103-1-david@fromorbit=
.com/T/#u=0A=
>>=0A=
>> This is really necessary to be able to analyse failures from tests=0A=
>> that use dm-logwrites, and such a tool does not exist. Rather than=0A=
>> requiring every developer that has to debug a dm-logwrites failure=0A=
>> have to write their own replay tool, fstests should provide one.=0A=
>>=0A=
>> That's the whole point here.  I could be selfish and say "it's a=0A=
>> debugging tool, I don't need to publish it because others can just=0A=
>> write their own", but that ignores the fact it took me the best part=0A=
>> of two days just to come up to speed on what dm-logwrites and=0A=
>> generic/482 was doing before I could even begin to debug the=0A=
>> failure.=0A=
>>=0A=
>> Requiring everyone to pass that high bar just to begin to debug a=0A=
>> g/482 failure is not an effective use of community time and=0A=
>> resources. The script I wrote embodies the main logwrites=0A=
>> interactions I needed to reproduce and debug the issue, and I don't=0A=
>> think anyone else should need to spend a couple of days of WTFing=0A=
>> around the logwrites code just to be able to manually replay a=0A=
>> failed g/482 test case. I've sunk that cost into a simple to use=0A=
>> script and by pushing it into the fstests repository nobody else now=0A=
>> needs to spend that time to write a manual replay script.=0A=
>>=0A=
>> If we apply that same logic to debugging hooks and the scripts that=0A=
>> they run, then a hook script that is useful to one person for=0A=
>> debugging a complex test is probably going to be useful to many more=0A=
>> people. Hence if we are going to include hooks into the fstests=0A=
>> infrastructure, we also need to consider including a method of=0A=
>> curating a libary of hook scripts that people can just link into the=0A=
>> hooks/ directory and start using with no development time at all.=0A=
>>=0A=
>> You need to stop thinking about debug code as "throw-away code".=0A=
>> Debug code is just as important, if not more important, than the code=0A=
>> that is being tested. As Brian Kernighan once said:=0A=
>>=0A=
>> 	"Debugging is twice as hard as writing the code in the first=0A=
>> 	place. Therefore, if you write the code as cleverly as=0A=
>> 	possible, you are, by definition, not smart enough to debug=0A=
>> 	it."=0A=
>>=0A=
>> Put simply, anything we can do to lower the bar for debugging=0A=
>> complex code exercised by complex tests is worth doing and *worth=0A=
>> doing well*. Hooks can be a powerful debugging tool, but the=0A=
>> introduction of such infrastructure needs more discussion and=0A=
>> consideration than "here's a rudimetary start/end hook for one-off=0A=
>> throw-away debug code".=0A=
>>=0A=
>> Most importantly, the discussion needs a much more constructive=0A=
>> conversation than responding "No because I don't care about anyone=0A=
>> else" to every suggestion or potential issue that is raised. Please=0A=
>> try to be constructive and help move the discussion forward,=0A=
>> otherwise the functionality you propose won't go anywhere largely=0A=
>> because of your own behaviour rather than for unsovlable technical=0A=
>> reasons...=0A=
> =0A=
> I'm pretty clear about the hook I supposed, it's not for stable ABI or=0A=
> complex framework, just a simple kit to make things a little easier.=0A=
> =0A=
> The single purpose is just to make some throw-away debug setup simpler.=
=0A=
> =0A=
> Whether debug tool should be throw-away is very debatable, and you're=0A=
> pushing your narrative so much, that's very annoying already.=0A=
> =0A=
> You can have your complex framework for your farm, I can also have my=0A=
> simple setup running on RPI4.=0A=
> =0A=
> I won't bother however you build your debug environment, nor you should.=
=0A=
> =0A=
> Sometimes I already see the test setup of fstests too complex.=0A=
> I totally understand it's for the portability and reproducibility, but=0A=
> for certain debugs, I prefer to craft a small bash script with the core=
=0A=
> contents copied from fstests, with all the complex probing/requirement,=
=0A=
> which can always populate the ftrace buffer.=0A=
> =0A=
> =0A=
> If you believe your philosophy that every test tool should be a complex=
=0A=
> mess, you're free to do whatever you always do.=0A=
> =0A=
> And I can always express my objection just like you.=0A=
> =0A=
> So, you want to build a complex framework using the simple hook, I would=
=0A=
> just say NO.=0A=
=0A=
I think that Dave's opinion is actually the reverse of this: hooks, if well=
=0A=
designed, can be useful and facilitate adding functionalities to a complex =
test=0A=
framework. And sure, the hook infrastructure implementation can in itself b=
e=0A=
complex, but if well designed, its use can be, and should be, very simple.=
=0A=
=0A=
Implementation is done once. The complexity at that stage matters much less=
 than=0A=
the end result usability. As a general principle, the more time one put in=
=0A=
design and development, the better the end result. Here, that means hooks b=
eing=0A=
useful, flexible, extensible, and reusable.=0A=
=0A=
And one of the functionality of the hook setup could be "temporary, externa=
l=0A=
hook" for some very special case debugging as you seem to need that. What y=
ou=0A=
want to do and what Dave is proposing are not mutually exclusive.=0A=
=0A=
> =0A=
> And you have made yourself clear that you want to make your debug setup=
=0A=
> complex and stable, then I understand and just won't waste my time on=0A=
> someone can't understand something KISS.=0A=
> =0A=
> Thanks,=0A=
> Qu=0A=
> =0A=
>>=0A=
>> Cheers,=0A=
>>=0A=
>> Dave.=0A=
>>=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
