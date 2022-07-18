Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B79577C9B
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 09:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbiGRHdJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 03:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiGRHdI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 03:33:08 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C6018342
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 00:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658129587; x=1689665587;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=CUkUKzNS12XfjjmCpwWqTezap2FyROhEl0NpukD3PA8=;
  b=gf+v+yvJ+qvIiEkrohPCBcH3mPEWqZaMhqMnaZUOp7zlBMIbAp/5TPtn
   RmZz+WBRNX3nFP3DRwrxCOBoHwUp5CpbdEytm1uZMkzl8StdgPU2J9i6k
   BJWxjJ5WWC0NSMAgIJui2byq22v+7imef7l+O9nRlthv4EK7G4iniqz/d
   O3ItXZw4mNmpFigKGo2fNsFANuD+JJ2h0JdAOhAh6noNNOxIGL5xBeTGq
   b4vv1vhQzs6g8EtkrOueTZ2AETcjIOyVM54sJApQQ8A7OshAmeOyoT9qf
   3lhY3k4UQYRsGaOXRftLDa3ibZ3OeoPy+7mcz58QXbH6sD3vcfCX3QSCF
   g==;
X-IronPort-AV: E=Sophos;i="5.92,280,1650902400"; 
   d="scan'208";a="318152110"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jul 2022 15:33:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEF6RzGLCOL7OGfOhVKDFVVtU3SUlAaViC/mG2rsKUwXFE7xTjk+o7qkLu4vMem0b48ll58kuilMbnJFzqdf9Vrnyn3elMDDh4AkwGzYPCKkzm8Po3KCQaSwrutPyHnbHOzRXtoXcz+hcx5rA5PcJBGGEbQZdlIQ4xl3dHXWSPFlH8o261rFE3YcW0lkpw6DTOgBCD0QGv/V6Qq22L93q4dZmXTMsyw78bQ0cAX0VwQJODs7PYlJ3J5yARpKW3qhGoQhM2D7ef8q6Ztwi4rSEP9b180Gz18XEwG/Z/cUOu6RAuQMUxap2Igr30t5lRwHCmJ8fL3I0XS0o6YuBE2nBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUkUKzNS12XfjjmCpwWqTezap2FyROhEl0NpukD3PA8=;
 b=nBEoheJSnSHn32RyvmR38wZsLyV2Et8vkhtPLO12lS6ywgWvXcesin27haH2bADiQRFl8UeANj1We9K2jdrFsUmq/MT/dg/Y1LAnQLNIBGUt8YxpbVK6HriYXy5ts+w/hKal7f3QvnVuAyRX+6hgec3F26CCNyAE/VmQsvfo1pvB0jcJUMOz8PuKteItvgdrXFkKpHPrvClFJ8l1H09Ku84dQpNTWfyIeO+grS8ShUUkMqjLE5YBTD+sObheNH6JC6nTnLBmonfL/kJTG7lyOYp+/TleJJ962gvPrQxO34Gsfz6A3rtafeUD7kwhAwQai6S4RSYKHdR+t2eZ+jokqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUkUKzNS12XfjjmCpwWqTezap2FyROhEl0NpukD3PA8=;
 b=fq0zrcJx2QyHFdEMaSd5PxGXrAFbp9EowQN4SCXuAL1afgIO49IDGTWbV4P98/gS0xXkXgjjoOvLdGZvU7m5s8220vjx5gekiSYQ7QMzbfAaa/dboTLwjM5izIYVMyy52qdZB7aBYZhotkzOMWwJjkUIz4PMzt268z1j0sWuPNM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM5PR04MB1084.namprd04.prod.outlook.com (2603:10b6:4:46::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.22; Mon, 18 Jul
 2022 07:33:04 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5%7]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 07:33:04 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Chris Murphy <lists@colorremedies.com>,
        Goffredo Baroncelli <kreijack@inwind.it>
CC:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8] btrfs:
 introduce raid-stripe-tree")
Thread-Topic: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8]
 btrfs: introduce raid-stripe-tree")
Thread-Index: AQHYlqb43VRMNwcKo02MAxAIJIVEbQ==
Date:   Mon, 18 Jul 2022 07:33:04 +0000
Message-ID: <PH0PR04MB741662E24861B573FE93D0DD9B8C9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <78daa7e4-7c88-d6c0-ccaa-fb148baf7bc8@gmx.com>
 <PH0PR04MB74164213B5F136059236B78C9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <03630cb7-e637-3375-37c6-d0eb8546c958@gmx.com>
 <PH0PR04MB7416D257F7B349FC754E30169B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <1cf403d4-46a7-b122-96cf-bd1307829e5b@gmx.com>
 <PH0PR04MB741638E2A15F4E106D8A6FAF9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <96da9455-f30d-b3fc-522b-7cbd08ad3358@suse.com>
 <PH0PR04MB7416E68375C1C27C33D347119B889@PH0PR04MB7416.namprd04.prod.outlook.com>
 <61694368-30ea-30a0-df74-fd607c4b7456@gmx.com>
 <PH0PR04MB7416243FCD419B4BDDB04D8C9B889@PH0PR04MB7416.namprd04.prod.outlook.com>
 <8b3cf3d0-4812-0e92-d850-09a8d08b8169@libero.it>
 <CAJCQCtTJ=gs7JT4Tdxt3cOVTjkDD1_rQRqv6rbfwohu-Escw6w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4c5e7f2-bc09-4aa6-5bd2-08da688fc082
x-ms-traffictypediagnostic: DM5PR04MB1084:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E1Lzie1qtm6Iy+C+3DbHYnl020ymnB40hajs0j6m/Dvk0A+64kBL8pAhEWfu+zoGkAkJr74PcAJTyRCxhKjF9UMIbME9JjBPGur92D5R8tW9myWdqGZF/CiRWtq0YfPzoKiJUqj0lVLDaTMdcH4PAH0opl3mItNt/tTX4LFjIj0+SKDCUj01S1CqH8Wm8qauEZbzlKMQWPUnmwaIgBAyelRiTAsVgiFG99i6SP3zsYzx60YFd+XjgR2AUdJnU5558O10D9YJ4EXOseP9D8f6hH1qLgLM9gqCrVz7FhgLmeAa/jJDnne1NkOJn71jQoY4SX49xAxVKCKzYHe3K9USixeYFFkP+OE2dl+nZHM16SdYpdBwXyVHSY/a71ofHdqR2BKRmaPMLIwe0bZj1WzsitXuiVf0H5vFfZgZRnDabodOwc7Fr02EQ9Dbx6ZIzd7J6TwJsWSxy4dW1L025yy8oiNttfhSYIw6vqf5yKsfy0fjNxnqrbqR/uJrqneGjYynroSNhX/NLjQPiyh8a2u1ofK84YDFzGlzk2k9fmXtXMJNZLwwt1bnhEW15dyIHD0L35PAkENVaeezSWK5Klzu+0a01ID2BH1EQ9Ll1ZcxZJ5uSFauQgcTRoA83MVTPAe2XQ+vbUa/9pBnugmGLB0sNYchD/GvWQVUrk4JdFMRreTmF+4zqkY3zuN6cdgTIk/LdBQF7zNPwYnEGgBvnXv05QsKL8gqa7DC95LBxUiWenu2ByPCfwiUaTDqDQCTiWHNEUYGJS/llYRE+UtfI7WHi+MQqF5PvkgTmvkyDfy7sp3LfdMDOp78FDmgdfyMxPzj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(71200400001)(76116006)(91956017)(8676002)(64756008)(66446008)(4326008)(2906002)(66556008)(66476007)(41300700001)(33656002)(52536014)(66946007)(478600001)(5660300002)(8936002)(110136005)(86362001)(6506007)(7696005)(9686003)(54906003)(53546011)(316002)(82960400001)(55016003)(122000001)(38100700002)(83380400001)(186003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n1ncfQdQqcBXGhsKei8IPQioXBuIIESBfeRejZUAnyWx7DDRDGopTaOae/mY?=
 =?us-ascii?Q?HLVp1ujsyEYsl+D/D+VRKUcFAjZl6x0qvzoISyIMGy8UoHFgdB886PeyGGzG?=
 =?us-ascii?Q?6eVK34qagIp8uVOOWsnDTsh0qWKQFPZhcJbvFQXMkaQVfBMLKSpzok7dkR25?=
 =?us-ascii?Q?W7Yd82JBmcwyIZDUQ4gI0NZqvfRdEpjwSF3X4+tpmosGnRAHf8xT23f4Grib?=
 =?us-ascii?Q?GYGYgQfJyU8yBZ5SZXqYBuOUW6TNJ7iiDVmYw1TVo8PppM3LwAot2toUX5ZU?=
 =?us-ascii?Q?pN7gm33fcDI3NhbsmyOmUIxQ4QHvnB5vgqnTwXNt/t0T02Wq4nE2JZ//tLth?=
 =?us-ascii?Q?qyWJ7GTQowty5psASbP+lVYfvR/JaTkHcgm9/Icen2YVAK6Phwwe2LOXwu5U?=
 =?us-ascii?Q?NKjAmaYzULLxvCrKMeUJyu3vm23nBBdJfCn/8yhzQ86sOEZpAIILxFreVhR8?=
 =?us-ascii?Q?3kG7LWPuQeorpEKAbntk6N5Op5OYAbQpeuPHPlRC5cytoaGk/lQA1PhvRqzJ?=
 =?us-ascii?Q?7eqdjbRSu6z3ABgOm/hgmu5c8Id5+P/Hzk899TSC1gRFApXWOAdBi/9zBs0t?=
 =?us-ascii?Q?ceAyAT8J9s0ACGmlA+1Rwn5aTb7RmwThxT+cgSrL6+gKa/LsBJCYWQifHW9P?=
 =?us-ascii?Q?YwcnzbiKPMqLE5YuBrsOShIiJC9ShqC5AUBCXTmzL+81IFpYnoTHIgBozZ3A?=
 =?us-ascii?Q?GQdMG5H0q5bK0coUpvDfKoe360nqr9Jz1Sgk2+6T9Wma4BvAwsOS3Z500O6x?=
 =?us-ascii?Q?13MOXj+FVVxGKqG56CmR6YCnpmJ1MGyqljGUfSe2o9otNyP+K4CJVD41iYS2?=
 =?us-ascii?Q?3wtP3gstw+5iAS9uI0c8ihVCAFwwSYZLvtgodGvNnKAr+4YeWrkjXYP1DOtW?=
 =?us-ascii?Q?lxDW/ZLkxqqRWZL51NikSfPsWlcYcp9nw7Bc2B0xtWE0o8VEJ1nYbaF7VGkR?=
 =?us-ascii?Q?X7zJ4LBTsT2XC8TJIZoiF27+RIHO+5oMuvt/GJkXi0zs9oF3piEfCSUxKtVh?=
 =?us-ascii?Q?T5l4XOVjnzJkCQ/mwgVAaN+7c28tQ3lZoMPmiiovxULOYLDgfHPRrnwCbdUK?=
 =?us-ascii?Q?MriZ/byjy3ntLbvGevyX+tTcympFr1affjeDPsMgspNu1l1LHMnXBTs4cXzP?=
 =?us-ascii?Q?tIepadwqOzBcqYvUbD+FNqG7Ad/lF8Paa0AjrjXQ32pYeWJpt6dYtCAOCH4V?=
 =?us-ascii?Q?panbXWjdT2FiL4J6ug6jKlSwu0TymmxstQ2WwzQRSQ+UWXDzqsBl2vik8La+?=
 =?us-ascii?Q?p36VERXojFlXTaH/xAAh/Y/yfjERRK6tWS2MKwxJSTU9LsUHlOsGnV1WfkAQ?=
 =?us-ascii?Q?PZ9YJtJoi+2eH4os7GEbbbYnpM2LZM2W/KfM/uTlFTwI6wEc5lvPD+sC5LIL?=
 =?us-ascii?Q?iHSUI7YMzscjlGxSggfA8wWTriYcpecYDKMOKSZEOOXjQUOcILeVAEbPzA/a?=
 =?us-ascii?Q?os8UeyGnc3vk5zOg2HE8rXpC++9fHTsfTRBloimsyCJ+18jkJx14yDD4eMqy?=
 =?us-ascii?Q?ZZoZmjdTUgKFIYt+uP0JkZ5jwOjPKY8MCsmNp7mItaLmclltNF7a1LyuDbQq?=
 =?us-ascii?Q?cX0HVbSpNI21TV96iJFiZ0Xww9+HyoT07v/BhGkvURR9v4TVGZQx+X33iEfa?=
 =?us-ascii?Q?hNmcEap/8l/748F1yZ4/CD8cUbWcvNLzvOQV3KxAuGLsaoCPiYuHJAIMx0pa?=
 =?us-ascii?Q?oITToULTbkVVSc16EdryGelaFjE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c5e7f2-bc09-4aa6-5bd2-08da688fc082
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 07:33:04.5101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T6U1Qp8O6b2AIKG33ExZFow+TdTr6z1lPWVgt37ag/LhxY1We2ayv4nyt2eWRpDpu7Mr6JBdQbj7ldbK1zZm5yaE9zCXUzs0v0bDIkF4enA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB1084
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15.07.22 22:15, Chris Murphy wrote:=0A=
> On Fri, Jul 15, 2022 at 1:55 PM Goffredo Baroncelli <kreijack@libero.it> =
wrote:=0A=
>>=0A=
>> On 14/07/2022 09.46, Johannes Thumshirn wrote:=0A=
>>> On 14.07.22 09:32, Qu Wenruo wrote:=0A=
>>>> [...]=0A=
>>>=0A=
>>> Again if you're doing sub-stripe size writes, you're asking stupid thin=
gs and=0A=
>>> then there's no reason to not give the user stupid answers.=0A=
>>>=0A=
>>=0A=
>> Qu is right, if we consider only full stripe write the "raid hole" probl=
em=0A=
>> disappear, because if a "full stripe" is not fully written it is not=0A=
>> referenced either.=0A=
>>=0A=
>>=0A=
>> Personally I think that the ZFS variable stripe size, may be interesting=
=0A=
>> to evaluate. Moreover, because the BTRFS disk format is quite flexible,=
=0A=
>> we can store different BG with different number of disks. Let me to make=
 an=0A=
>> example: if we have 10 disks, we could allocate:=0A=
>> 1 BG RAID1=0A=
>> 1 BG RAID5, spread over 4 disks only=0A=
>> 1 BG RAID5, spread over 8 disks only=0A=
>> 1 BG RAID5, spread over 10 disks=0A=
>>=0A=
>> So if we have short writes, we could put the extents in the RAID1 BG; fo=
r longer=0A=
>> writes we could use a RAID5 BG with 4 or 8 or 10 disks depending by leng=
th=0A=
>> of the data.=0A=
>>=0A=
>> Yes this would require a sort of garbage collector to move the data to t=
he biggest=0A=
>> raid5 BG, but this would avoid (or reduce) the fragmentation which affec=
t the=0A=
>> variable stripe size.=0A=
>>=0A=
>> Doing so we don't need any disk format change and it would be backward c=
ompatible.=0A=
> =0A=
> My 2 cents...=0A=
> =0A=
> Regarding the current raid56 support, in order of preference:=0A=
> =0A=
> a. Fix the current bugs, without changing format. Zygo has an extensive l=
ist.=0A=
> b. Mostly fix the write hole, also without changing the format, by=0A=
> only doing COW with full stripe writes. Yes you could somehow get=0A=
> corrupt parity still and not know it until degraded operation produces=0A=
> a bad reconstruction of data - but checksum will still catch that.=0A=
> This kind of "unreplicated corruption" is not quite the same thing as=0A=
> the write hole, because it isn't pernicious like the write hole.=0A=
> c. A new de-clustered parity raid56 implementation that is not=0A=
> backwards compatible.=0A=
=0A=
c) is what I'm leaning to/working on, simply for the fact, that it is=0A=
the the only solution (I can think of at least) to make raid56 working=0A=
on zoned drives. And given that zoned drives tend to have a higher =0A=
capacity than regular drives, they are appealing for raid arrays.=0A=
 =0A=
> Ergo, I think it's best to not break the format twice. Even if a new=0A=
> raid implementation is years off.=0A=
=0A=
Agreed.=0A=
=0A=
> Metadata centric workloads suck on parity raid anyway. If Btrfs always=0A=
> does full stripe COW won't matter even if the performance is worse=0A=
> because no one should use parity raid for this workload anyway.=0A=
> =0A=
=0A=
Yup.=0A=
