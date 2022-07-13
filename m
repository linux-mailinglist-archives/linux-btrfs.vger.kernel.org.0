Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17460573686
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 14:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiGMMnR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 08:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiGMMnQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 08:43:16 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB4FFE529
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 05:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657716195; x=1689252195;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=zeLEwKqHsdiUl1mk7PHcVPD1/nsGWskAebLv7drqqTE=;
  b=KANYOS6GKO0BuCYiVdbu3wsJBqXXJcomDEcajxmO0FoMh3OxGUdP4+iM
   UC2yMSvCvYT4ES84cyfbjg6yM+wdPHKUyd7MdC6/lqRszJYkDBNRK+pSC
   KNLtLF0ptYXigUpUIStEdcLgQn34pN1xdt5zfk2SOw2JrueYonH0GJGQn
   DB1rDZzzG2/ZHp+64g3PULfImztoobniGLwg/61CKoet+6AKkAxMkVe75
   ynVNaoo42G/5pNQQv8ue/6H4NBMOosWaQke5m273etX+wGDr8w1foHi+M
   UfQXxG+e/Jpk2Z36hxin5hTVbVEQSX1HTmgTyNbYmOFIr6YxyY443hPQe
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,267,1650902400"; 
   d="scan'208";a="317735523"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2022 20:43:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwV8aEYllEEXef/mhshmIw86nIme1ZTfNTk6ESeZFBmintp5WiqSiN6doKxQxQgXr0bfwpfirrRztSksZG7pz7eLAQ5EPq7D6ALANAnysO7n1jCRXrVPm00mK5LgIMayP09vITpWMUNFt8mTbkSTvUGiR2fJ4Taqha07Umkma5TgGAkKZAnGW+vIs1S2z62FuADsfg8LQuSdrF0PjAC5Qu8z4Zp6wkiyUyH6G9bYkwW0XuyX5EsvpZVlzQ2wEOwnZE5ojK/YuEveWfYVdnSe1ry0EiyJfqxqVVLd4q/0zddj4tvlLgeFr/sqOl2YYFuxvQiol2bdGGf3qRYebBx2CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMH5yvkFxACJnBTn3UFQ6k3RplGHeWEugvw6cOo5/J8=;
 b=Bfp6TVnkmyN9jnGQjhklBg8P1il90/riAwj+u3oyeF5qMHHHbN4stT7x5gq6HzMpXBv7Ff29Zn5mMjEdDeMBsHo9qAp8xamP6GMDnlta3VGUvf6baRORQYuVw1SOybcJDtYXUv25a7b91Jqt1fuYrgviT2usM51ewQfth/tyWPLZk9xmYvLn4U9onXApcrytZulaP5Y2rYu/QXwpassBzowT18ug/9yEP50jVeILEK7iSeyvRvBFDM3mBrzjI/Ed6G4J3DqTm77zrmcbhs3E/qh415UkbpxGQr6QZxnOjpHxjhe0bP2NZapUoe/askAacxLp5krx3que5U1cCTpSVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMH5yvkFxACJnBTn3UFQ6k3RplGHeWEugvw6cOo5/J8=;
 b=nMvorLKf5Qd8m70P7E7H2g8o1pYYPI9/dTt9P9b6wl6qjDxe7qotl4qWBBF59juBVDEC9nBdBbliv2K1/w1FkJxDc1svo0MLx7gTBUC20f0nk78i9Ytt3CR4rx0WIlBG7kNfYl+gxHYAkJMACdVP0bFynxaImhBoreFZCyr/RNg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CY4PR04MB1095.namprd04.prod.outlook.com (2603:10b6:910:51::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Wed, 13 Jul
 2022 12:42:41 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%9]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 12:42:40 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8] btrfs:
 introduce raid-stripe-tree")
Thread-Topic: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8]
 btrfs: introduce raid-stripe-tree")
Thread-Index: AQHYlqb43VRMNwcKo02MAxAIJIVEbQ==
Date:   Wed, 13 Jul 2022 12:42:40 +0000
Message-ID: <PH0PR04MB7416D257F7B349FC754E30169B899@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <78daa7e4-7c88-d6c0-ccaa-fb148baf7bc8@gmx.com>
 <PH0PR04MB74164213B5F136059236B78C9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <03630cb7-e637-3375-37c6-d0eb8546c958@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 007b72cb-4c4c-4df9-f56f-08da64cd2cc9
x-ms-traffictypediagnostic: CY4PR04MB1095:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jybDB9rLdtZdshv+zaqLF7luOrcQL3+OigFg+chBln0FB+KDl9qpDEccfRrj7pA+X1xobYUaWf2hdf3OdVCjDbDRcNM/FihbsOPsmIvtQipsAOf2IyImgxPBHTGIREzPqoDAk7UwbH1skmvwR/no2+sewSyWyo5owmIOwsnTaKohYaxPjkHSRMqXUfNUh/PdXyeSKW319PVlIznskyoG4U4kYmuibXsBOZfHhGAW+rSnHbYu5XYDVl6x+6uc8uKi1nolWV6YJVomMt3IgNqwL5cWavn2lEDEz7QkNUqt9EUEl0xyRLUIe6ic+dVdMrlRwPchJB+11vkJ9o5I/hjG4E3VW12Dk/xXbdNY5p7L4c/qgdg08ZFG+iDrynlIFD9MTPBN/BochAy4hFOK3VCBkts7lMe6KmURCnhDF60YemXG5NxTBrr77VbMsubYy7mno22qWyQVTKcKx/vJfpcF0j2MMhf321jlzAFuOPeJH7Hkd2g27wvbc47sqOR+9jlYXZ721XZbYMclNNrLI7/e2e4jfawpfQAlsa33vBg/D03c2t7sozMoagmANFGCQLoIm5FhPTte9VioWG8kSL4RlAbmfPcyMZKzeu7ghIqmcm0VvnkP1buxxaqdHCkvEz6KN0QhoYH43SP5RytQgz72FTKRiC1H7TuVyrwkab9DGUyr076MUld4QtcYqb0v8jDvC+gJVM2ybj880EetaVgel4/MPgM9RxTKC4WQaK15cXR4c0PJOWEnPjozpFG56kt9Z20KQoJxcrhocI4XyYZ6BpvLmQaMjKCUztg0zM6d5pbvCWtD8bomrYPNcxXew+vu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(122000001)(83380400001)(66446008)(33656002)(82960400001)(26005)(55016003)(66946007)(52536014)(38070700005)(9686003)(86362001)(186003)(53546011)(8676002)(71200400001)(6506007)(76116006)(2906002)(5660300002)(316002)(66476007)(8936002)(38100700002)(64756008)(7696005)(66556008)(478600001)(91956017)(41300700001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0inoJt04WYEJ0iV+2jKgbry5wxaBFvbY9tGzwmJrHvfVQoe/qbZr2o4grOtl?=
 =?us-ascii?Q?UGTQik/9C3dzHf/eb597LdpO4BdvBPpRRO5vXJ4jnHAXrdV+cSiWa6r/Ul+D?=
 =?us-ascii?Q?8JiTGLMpmnOvlqlWAW6qjU1SoUS/CCM1iFs9ShCiLzRVwdebzEZQI4nHF4cV?=
 =?us-ascii?Q?wGQzhy8Plow6P+PAAqaexm0ZzFwtp3Vk4SASmv1ZyT7JUyoqVvQ1OAAgbix/?=
 =?us-ascii?Q?lvlSW3FmWVtbwfsjmTPHvVqWtCAJbrRLcLIxybSLbHNKDEf5aU4yGLbPNM1H?=
 =?us-ascii?Q?U879S9vA/JyVx/3zk0DJF6q9Pg5SUVYVGUl6qdy0RBeAK62y26qKiUO0NL4b?=
 =?us-ascii?Q?fa8mTGyQCOrEayxWwPViGj0IHMoQ70w3cnduUJi2axFyQ5lQumxiYgFr1PKE?=
 =?us-ascii?Q?ORTYblpFhvWc8D557hlwdhPE7AAL6qpnWpnbOgrzHtGShQKBDI19VHMU1Y+J?=
 =?us-ascii?Q?64b5vqY3blZV1mxYcgzEzxHV6Emh1+y9RDJBQ8MgZc7cTXd2yQtnq3838mYq?=
 =?us-ascii?Q?p+ud66gPfzctG9RDXnJe1j6DHjSaP1x/7WUnmXLeec7vwtbjRQSYfC4t/Ajt?=
 =?us-ascii?Q?+bcvbACU0eTYPFnJzOYcuV5ppf5IocRpTAcqvBFb+DIyn8D8Ew1FW2e1IPO8?=
 =?us-ascii?Q?3ksJLBlVZjvf11ChJp5sDpQVbfGN8CHeFioFevuvJkxRUkt3jJu6aohh43IL?=
 =?us-ascii?Q?HADCw+j+lWLCMmpajBXj6IEnvTM1IV+/0KJdUuUvlXzJ6C4yB41tF17iCOPV?=
 =?us-ascii?Q?QXKxx34+y3JhbaMf3O7L7UK9/tCn/advGiYGik1KonR/QHqCljty5DEaA5Vb?=
 =?us-ascii?Q?r/xn1LdyMWTM8mDjdRfOVRREUR5LxBtlVUfgWgd0xFNEqg5tKvtmAFekRJ96?=
 =?us-ascii?Q?Y07DZt6Pv5tXmFNvEA2YrVqEWhueCORva1dCi6o1m8E/h1NPLOWqYo3DIE05?=
 =?us-ascii?Q?t8l0eOTJecaqsOFcrqvy6/OBpOqmf2yUh/dASgJkmx7VmrIhalrOBa2C5ihs?=
 =?us-ascii?Q?ZADhDkKpWdSZnqlXZAmpZzVOKgzGFxa20h8jmgj1yekF3cWQanrWBv8AwFhv?=
 =?us-ascii?Q?2Cdi0xEF8kcVsLMebmpLBcqaVeNTBPL6T+sQXbRdtyvvKsfw2a2hC2EQLV/0?=
 =?us-ascii?Q?lxpt6HNjWOohAaYPGRfTC9cGprgApIgrZo4/YsyUxNWrhW/3GmM0S1QdMGEz?=
 =?us-ascii?Q?ywLh9R2IYh2yJp3TONOnw+nuieDc6Xi1dyraCEuXLJhCeEy7vb5DgeOcJT6/?=
 =?us-ascii?Q?YPTMHS2qpkO+phNores79LwhejMsVpJxQ1hysSVw/1K2+1BAv44m4mtboJS3?=
 =?us-ascii?Q?zeuSEvUUIMQcsW2GvcV149BaUeNBwMIav20jC/6yRN9kB/gVmUiD3oNktYAO?=
 =?us-ascii?Q?MJYwH79MjlfCN/berwf7XSssia9m921JH/MHzTMark8BaHBQ1hm1XM3kkRpt?=
 =?us-ascii?Q?7cfP/oLOj9jOdJUYE+WNrU1e0PGFhytIrQZL2K6myGXbPhV5JcQerU/zLwm9?=
 =?us-ascii?Q?Ar2Gyp3LgC3ID49Uoby+3XTEl3b3mwZfa6pG5I6Aq1e+zfyCFRIH9H27bmLn?=
 =?us-ascii?Q?KNytDj0ApAM4/PfY848MET6XTzkV9NA/V/641Zx+HQ755t+giLqn0508fc/e?=
 =?us-ascii?Q?4H6xCndrjVH6NdtsEIOY+28=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 007b72cb-4c4c-4df9-f56f-08da64cd2cc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 12:42:40.8540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U+Pt0KtSgBfueFldDG192KkgopFlx7cunulERdzZhFP/fxpekrWcbnO7awR4p6L4SVrO9LVKfZbe0ZJcMGT7gI21T00/3sqvRBNbvxwFhfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1095
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13.07.22 14:01, Qu Wenruo wrote:=0A=
> =0A=
> =0A=
> On 2022/7/13 19:43, Johannes Thumshirn wrote:=0A=
>> On 13.07.22 12:54, Qu Wenruo wrote:=0A=
>>>=0A=
>>>=0A=
>>> On 2022/5/16 22:31, Johannes Thumshirn wrote:=0A=
>>>> Introduce a raid-stripe-tree to record writes in a RAID environment.=
=0A=
>>>>=0A=
>>>> In essence this adds another address translation layer between the log=
ical=0A=
>>>> and the physical addresses in btrfs and is designed to close two gaps.=
 The=0A=
>>>> first is the ominous RAID-write-hole we suffer from with RAID5/6 and t=
he=0A=
>>>> second one is the inability of doing RAID with zoned block devices due=
 to the=0A=
>>>> constraints we have with REQ_OP_ZONE_APPEND writes.=0A=
>>>=0A=
>>> Here I want to discuss about something related to RAID56 and RST.=0A=
>>>=0A=
>>> One of my long existing concern is, P/Q stripes have a higher update=0A=
>>> frequency, thus with certain transaction commit/data writeback timing,=
=0A=
>>> wouldn't it cause the device storing P/Q stripes go out of space before=
=0A=
>>> the data stripe devices?=0A=
>>=0A=
>> P/Q stripes on a dedicated drive would be RAID4, which we don't have.=0A=
> =0A=
> I'm just using one block group as an example.=0A=
> =0A=
> Sure, the next bg can definitely go somewhere else.=0A=
> =0A=
> But inside one bg, we are still using one zone for the bg, right?=0A=
=0A=
Ok maybe I'm not understanding the code in volumes.c correctly, but=0A=
doesn't __btrfs_map_block() calculate a rotation per stripe-set?=0A=
=0A=
I'm looking at this code:=0A=
=0A=
	/* Build raid_map */=0A=
	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK && need_raid_map &&=0A=
	    (need_full_stripe(op) || mirror_num > 1)) {=0A=
		u64 tmp;=0A=
		unsigned rot;=0A=
=0A=
		/* Work out the disk rotation on this stripe-set */=0A=
		div_u64_rem(stripe_nr, num_stripes, &rot);=0A=
=0A=
		/* Fill in the logical address of each stripe */=0A=
		tmp =3D stripe_nr * data_stripes;=0A=
		for (i =3D 0; i < data_stripes; i++)=0A=
			bioc->raid_map[(i + rot) % num_stripes] =3D=0A=
				em->start + (tmp + i) * map->stripe_len;=0A=
=0A=
		bioc->raid_map[(i + rot) % map->num_stripes] =3D RAID5_P_STRIPE;=0A=
		if (map->type & BTRFS_BLOCK_GROUP_RAID6)=0A=
			bioc->raid_map[(i + rot + 1) % num_stripes] =3D=0A=
				RAID6_Q_STRIPE;=0A=
=0A=
		sort_parity_stripes(bioc, num_stripes);=0A=
	}=0A=
=0A=
=0A=
So then in your example we have something like this:=0A=
=0A=
Write of 4k D1:=0A=
=0A=
	0		32K		64K=0A=
Disk 1	|D1                             | =0A=
Disk 2	|                               | =0A=
Disk 3	|P1                             | =0A=
=0A=
=0A=
Write of 4k D2, the new parity is P2 the old P1 parity is obsolete=0A=
=0A=
	0		32K		64K=0A=
Disk 1	|D1                             | =0A=
Disk 2	|P2                             | =0A=
Disk 3	|P1D2                           | =0A=
=0A=
Write of new 4k D1 with P3 =0A=
=0A=
	0		32K		64K=0A=
Disk 1	|D1P3                           | =0A=
Disk 2	|P2D1                           | =0A=
Disk 3	|P1D2                           | =0A=
=0A=
and so on.=0A=
