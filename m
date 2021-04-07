Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21757356B38
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Apr 2021 13:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343652AbhDGLao (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Apr 2021 07:30:44 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:59677 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbhDGLan (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Apr 2021 07:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617795042; x=1649331042;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=1NfJeWbvylZHzlFNzBo8NYr5SIltOF10S2ZgYJKyiMM=;
  b=Arjx8M4epnPta8GF572BoXTwH32fQS0GWZIjAp0c3qonQrn5TCYRF1/w
   AElql7Sgm3limkxnRY13wK9nsHqv6QEnU5fkPwRavckyMQ6L3kTS1ykiT
   aTJ9oKuqg4+5dZ2Bf5rafws1DN31A5Cd/82A77YNxY1yE5xOIYmIVhIbG
   4HxB4uxwZqwCmtdzb9i6MW3xpQByoK5j8osdb4AfijgwITrnKEtwhlity
   IVPyUY3lIaMmb+XFe2MEN9yUQ6FwUVjkgvpkyuqH2mQvlUAuuxUnheu7S
   ZMnLY8Mi3AgM24dPivmMOkFiSpACEewTb1L8m1/Bxv7qjiUqiWKMhAS5g
   g==;
IronPort-SDR: EI9bBTZTnYs+0dkFcg1mPLwGmXAp11jSPQd9mCTiq4mBheJwOs3ZbxgdM4S7plNXL8QF9vVsKm
 BSh82Nqtncn7N6aieJTdyRKH/hQ2RT43gsKHfuMA+dph+8loNgMI2i+LkbrgrwM7Al8G8vqtSq
 OYW8RCn45j7p+w1CA8mlnbHuo8rw/INjfPjxS/+JWcoyAgEYHlaBP7Lj8NX7fLiMXywFndOuIL
 PUO3I9TamsLlUpcDSH+SU7uI3VgWc/cxCM9ihNta4uT4ZEtEViM4dvjuX2koSanGnHJ5w+QZE4
 ivI=
X-IronPort-AV: E=Sophos;i="5.82,203,1613404800"; 
   d="scan'208";a="268390749"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2021 19:29:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jValvwPbvHlfDlN62IMyzmhaCfJVpOkgfPpk9slAUu5KX4oBIYOZXk3ka/v4C3wrkXsmK3ehEBQupV1GifeMX0VSPoLHetIxp9CkhJkmjki++tvEspl3xQn0roaHk0IFDiqU1XK9Z5GGAEr14vC6xFfp6C08126Wgi2BF1NeBjaXLohnyERft1GGeH6VFratv/frTKTRiGDfWK7Kx1O8AfX/JYl0cf870nbr3BktrWBSbhGhJOfIeJhyqkZCu3r4MBgHZ4CVYsCZyOgOVVJfwH5M5pp4IAB3OXMhLAv49v7Jc5B/TtDHJNuL/wT10ujdOIDewS18aMA18avjyGMVhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NfJeWbvylZHzlFNzBo8NYr5SIltOF10S2ZgYJKyiMM=;
 b=jCAyBzegXmy5TC6TiSYJstS0Zh1t9HHklWLd0xg5/soTvxQYL5YYk68whj8Q2na5Zrix9AdmkzMQNikcjaCIFP11hTxfggBeHrS4BoxogTvu8ZHGb6dUnvSKYnwcQeRfv3jc2aLt7B+V9BZB/9ZnMEHLzFdMY02jU3OHyloZruEtwMOte5BNZ7n0JMdwdV4KPYY85k0AM/w/Rn45/sWj9stSFWCn0mwxB1jC4hXIhFFFJzmewhMszF9Z8zzUUgZN1Kf2PZn1twnawDDVFDqMfBO+DFfPcvpfDjjk6nybMUXH0DdFlPnDJjk+1ilLcYGJShEfMJEXxetezRyGGo36fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NfJeWbvylZHzlFNzBo8NYr5SIltOF10S2ZgYJKyiMM=;
 b=j0ZbaOBDHsUZg10T34N3ThWOAkrylxKgEHph3TJQgBp/T+aOsRNxiSbAsRYwLeMePbj/qWeA+bgq+n9BeZXgvwbLJDsGAWsHnI4mZeutnw1OL/+KMue+q9zSo/jRbi/5Fu5IP4TIZ+Tr3aDxtEKZbDH3CMOK4mFJuIawPaINGds=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SA0PR04MB7420.namprd04.prod.outlook.com (2603:10b6:806:e8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Wed, 7 Apr
 2021 11:29:26 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::d5c:2f7d:eadc:f630]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::d5c:2f7d:eadc:f630%6]) with mapi id 15.20.4020.018; Wed, 7 Apr 2021
 11:29:26 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>, David Sterba <dsterba@suse.com>
CC:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2 2/2] btrfs: zoned: automatically reclaim zones
Thread-Topic: [PATCH v2 2/2] btrfs: zoned: automatically reclaim zones
Thread-Index: AQHXHK2AfFCIp/xNUkKXsYwy3dEAHQ==
Date:   Wed, 7 Apr 2021 11:29:26 +0000
Message-ID: <SA0PR04MB74181910EBE1A9DF746FB2E69B759@SA0PR04MB7418.namprd04.prod.outlook.com>
References: <cover.1616149060.git.johannes.thumshirn@wdc.com>
 <58648eb48c6cb2b35d201518c8dc430b7797bcaa.1616149060.git.johannes.thumshirn@wdc.com>
 <f747fac1-fd6d-701f-6c8c-2cf779b3a145@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b080158-7770-4ce2-2d3e-08d8f9b866d1
x-ms-traffictypediagnostic: SA0PR04MB7420:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR04MB74208B239643E9E0961B0A209B759@SA0PR04MB7420.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yM+g+QPEiVcn1mlwivdOY2mDdQyi7XzKpXT7G+kNhe8jHvYN7W8/OD5Wl79J7qphswrjonuGpXIzMFlYMdMmY9YlnPXa7Fv/A1YOzpztlc49rH2GDQ35BMp8pLW3DKMYWODkEOzPZDB3ifMxe2RF33Hm1CKlT0P6H+sSLKBwAI9Igj/bBix/J5Mqz/M68Jrk/f9EfX0LAD/kgNH1xXp7m37Bmw/r+J0inR7n0D6z8R8DCJIRG8X2+RRFdMXlDmlsd+S7NP8X9rom58KtZkavh3UhNZb539gkus5ru7DuR9IuPSLK32+RXzLNsHREkV5zxfmVrWlGIewSFylqwFl7q2fk+qg4hSHizHx6b+x4YPRDv8WYpK2/FP4zRRC+Olifed/jcebLIUpoer5buR3r6r2vrlMcra1Hqnto7txSejgD+SsevuC6HDWQQ8xM4NIq2hDKwBZ/B3RgN/L5YD7hHg0BTp3wbGvMks2wtifAXYbMHnqpmPvasAplSKgPhCz2T9QjH73HYW05Vcr4xA88zKxBoLlI9iOo1lt47R9SgxH/nmf5Oj08a2dtixzYaGccMxq/ZHl8hGME15rlxzyEIccWXnRv0Yrw3RIekLh7yQYGFrZJM5ajuUMD4CLbJh8hLtAp/R3UfRKvjSprCLWOG/aL2RDEchtVxSMhPjEKXko=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(76116006)(66446008)(66556008)(66476007)(66946007)(91956017)(9686003)(64756008)(86362001)(478600001)(7696005)(8936002)(8676002)(6506007)(55016002)(53546011)(26005)(38100700001)(186003)(83380400001)(71200400001)(5660300002)(110136005)(316002)(52536014)(4326008)(33656002)(54906003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?4cMqa6of4OlQmtveh8NqwDYgHwQAQwhk2jmcPGwJAZI+gsBq5gi4AW+fGvlX?=
 =?us-ascii?Q?ep2LcgnIZb1nC265TmBhgCBb0VsnlYmevvG0mc/+PG2xqWP0I04CGz7mKmbl?=
 =?us-ascii?Q?CbYE3zATxzbkuuT563s8cujuF4eluGqivYClMSwIIcKfUTeH6iOK0HQRpnJr?=
 =?us-ascii?Q?tYZrxGgIh4c7NKnQefNdveKcOEsHztUds2E7+6Z0J1+YajOAstMoA1c07QEU?=
 =?us-ascii?Q?0u7rxtt6993ot/GvTb5/CMKCZzThFaGmoTZa08UyVyGb4Lr2yL6lZY4OiNHJ?=
 =?us-ascii?Q?mmEaNA+GxRfsDOVtjO5YTRJU50zIalquXliR+DXsu7S2n4QM/BXxPryW28NG?=
 =?us-ascii?Q?94QtQ3oZPtdmI2XKaSFicrAqyiGCdzM90lv2k8CvIC51gQ+UnakhjweYGOUI?=
 =?us-ascii?Q?JCs6iKYXu67u6hZhY3Ufaqa7dGcqwLuIrl6pzPAPDU6o3mvmxiBngvOJjN/p?=
 =?us-ascii?Q?6tBG2Q8FrxrXP1IqeBVJGNCMCEEbm2Arwm49bMcmgdLL2MblnSAwoyCYaw2p?=
 =?us-ascii?Q?veXIyfHiu80y6kDweiFv6+9pJJlVK7Un5xRWHoz5Elx/lYhXHcU4rKaNi4yT?=
 =?us-ascii?Q?/cp51nZQvhvBBmYJazFwjOzPROdhWfTcG7rNrBuvwUPQRVg2v+oMNmKsCpN6?=
 =?us-ascii?Q?IzIceDe/7O9ic0kzZETJw8mbsPBF7COyqfunSjRlCOeFiFpwOZR679c4sJTa?=
 =?us-ascii?Q?h2hH4GP4oDqewzbtMYwEcgFOg9VHdp96Um4B6rF3Q66SzckBMlowQAgT92UP?=
 =?us-ascii?Q?xmg8vkVGFaNF2ivsnp0M9IJcGJswjgalME5GPOXKYK8jWoD94B3uIxiGc20k?=
 =?us-ascii?Q?rUASPGTEKHUPH8Am/XDK3wKjFhsQ6iIvBZZYY2dLQWVcmS4vk3xQvxsE/1q8?=
 =?us-ascii?Q?uosAnL5dmWsJN9bdBoBWtuGG7CiEQdVvxbYIZGNWjNO/gaEBk8LEHoumwiyR?=
 =?us-ascii?Q?KWhu13fyc+sACFgLb+JJZAlTtycwXeY+Z0RxUJCcl2fT34Hqmf6IOG9gBSSR?=
 =?us-ascii?Q?elOYP0vb8SZWe8BZFr8l/58GaFla50JGxX9RnGZa8gy4oC2oDkN54Il/1K06?=
 =?us-ascii?Q?3Zx1Ul2jkAK9QD8YHpjGGXFdc6WN/usz3xOJxo8AQPYalRHY0MgTY9j7Yjdf?=
 =?us-ascii?Q?W6yvKAI3AVX/gbS853b6mptyDLdXbs8z1seY2clfK3B7FisdsOPxy4tcaqrT?=
 =?us-ascii?Q?d4cxvoSI1FGtrLSW8AE31ILYeXy6gB4CTfVyF6r9XBqCy83+gURVj9xUhzbY?=
 =?us-ascii?Q?Mv2Wji/LwjSQMMC/sgBgUTf5CcFqKiBp531XBEUVWq5ptMvkRm2/eL5YQaVy?=
 =?us-ascii?Q?3kcbX8adcA3IyEIpiMGP42El?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b080158-7770-4ce2-2d3e-08d8f9b866d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2021 11:29:26.5715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 26uV9+qORROJbDXXqWlxCFlKjZmwajj0Z8+8+0XWWA6hXOhQwz7Q1CNYRQQm579skHiy2vzg2HU2zjsc29KMPaCZUO1X1haU5L1otM01CqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7420
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 23/03/2021 07:45, Anand Jain wrote:=0A=
> =0A=
> On 19/03/2021 18:48, Johannes Thumshirn wrote:=0A=
>> When a file gets deleted on a zoned file system, the space freed is not=
=0A=
>> returned back into the block group's free space, but is migrated to=0A=
>> zone_unusable.=0A=
>>=0A=
>> As this zone_unusable space is behind the current write pointer it is no=
t=0A=
>> possible to use it for new allocations. In the current implementation a=
=0A=
>> zone is reset once all of the block group's space is accounted as zone=
=0A=
>> unusable.=0A=
>>=0A=
>> This behaviour can lead to premature ENOSPC errors on a busy file system=
.=0A=
>>=0A=
>> Instead of only reclaiming the zone once it is completely unusable,=0A=
>> kick off a reclaim job once the amount of unusable bytes exceeds a user=
=0A=
>> configurable threshold between 51% and 100%. It can be set per mounted=
=0A=
>> filesystem via the sysfs tunable bg_reclaim_threshold which is set to 75=
%=0A=
>> per default.=0A=
>>=0A=
>> Similar to reclaiming unused block groups, these dirty block groups are=
=0A=
>> added to a to_reclaim list and then on a transaction commit, the reclaim=
=0A=
>> process is triggered but after we deleted unused block groups, which wil=
l=0A=
>> free space for the relocation process.=0A=
>>=0A=
> =0A=
> Still, in the code below, I don't see the zone write pointer reset of=0A=
> the zone_unusable done here. Where does that happen? Or what did I miss?=
=0A=
=0A=
This is indeed correct, relocation doesn't call trim/zone-reset. I've added=
=0A=
a patch to the series taking this into account. Thanks for spotting.=0A=
