Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAF74D9D2B
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 15:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349064AbiCOOPl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 10:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348218AbiCOOPj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 10:15:39 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7C550E12;
        Tue, 15 Mar 2022 07:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647353666; x=1678889666;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=CWYLpJgd5sYoqXLyN3nx6BB4f1lw9+rfVaGYCIKlX1g=;
  b=pKh/e5TfwvslvqiudoI8HRKKUVrG4Lx9ZxBy2smNXobCKXaBbR88xCJ7
   keyDDjnJvtLHzZ1HckKonHCwlZ8kY+F7mkr0ISeYU5IrJPSO5IEY47P8M
   o5oDhnGRmbKhwN7o0RkHQl+rTqcJCQ2ib09S45M9KA979wA25w8o/KEgf
   yuFuYOdPFDZDBTnifNW4mXrP/JitWN8k4AdheSzxs66f5UvLXhhkuJeX4
   ESpoxT2nQk05AQepJTi6bhtS/MRNG49Zjkj5pNGDuFtepW9An87jN7AmN
   k2RFFMAu4HPR3h0itaWiib39bPXCIc4Iwe0TUHh/QZaA/NxDeS5GEMFx2
   A==;
X-IronPort-AV: E=Sophos;i="5.90,183,1643644800"; 
   d="scan'208";a="195415327"
Received: from mail-sn1anam02lp2045.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.45])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2022 22:14:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wzpmg6NC2OfWj2at40z7H8YzkkC+Pga3x0NlKb5KDk+NhmOk+1J2BIcUi/8JCZy+vEgnhDcRcYzG0mfn0EqXZzFzHetw1d5cleue/cQ22aQvtiWtBPGC3DWFIKACH0HMhG9IZtVc410VeKcTKZnzrny0Kl2iQ/FMgjI/qogFi/Y0HLCFjeR83gUR+iuljq3nQL8PlViYcxJIuZNy76bVL3VlLLP5dkIk73itG7vmZAEzQl+C6Pxq+BLGj8Pw1coawLdvskmwdhBIiJ6FALP6WCB2o5np4b/ID2zGRAmfX8gICgDrTKVPJMuilkSw4Dzt3rdc6PScmsjqmEoVfy+cbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5faboX8xt2d6Aq1+K/EyeKm3UqAtyawcUAdm8zchfLE=;
 b=nLFtK5ZunCTOgbm+9aDz3Ksy4AeaR2r7bLn8qOVfyo/r8SJ5olAqwrhQM2rScHnIelkddutebaI/JDt1N6VSfNCIRwrDaoBxUUBahQAFf7Y4Q4V9PebMQd8B+lbDclFueYT1xFuyho5kxxLAdLN3+sWabDaBvmcZIA7Z+awiXaAUn/sSedAnf6DqZyNiSGp6Dw0wYBmLo1Tcdgkb5mWNhwj5743ftMl/mMrMKXbkxsLxX0gGv7JjXXV+/Luq8xhR3jX6CV6gzOZLy4kAk5nH7OrFR5OEQycHKmXH+XkSnV1iWGhuZahxF6rm5MUY3wNzrlWrxN66oC9a4owk9cj1Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5faboX8xt2d6Aq1+K/EyeKm3UqAtyawcUAdm8zchfLE=;
 b=fkKiONmv4e6rdSt4Gfq6sr5tXINJJNCEtYOzGuYelNEutNIvYFYv0HgSngs4YP+iwD774ljCLUILVGf76EZqTL11OTRJqRrGaLRIaZhpgjAskueKZTbettwwkRSXfnZKLyHLO2NGWSPh4UhY5rInDb0K1P9QF+AR7/WSqAoehVA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CY4PR04MB1127.namprd04.prod.outlook.com (2603:10b6:903:bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Tue, 15 Mar
 2022 14:14:24 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6%6]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 14:14:23 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
        Christoph Hellwig <hch@lst.de>
CC:     =?iso-8859-1?Q?Matias_Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Thread-Topic: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Thread-Index: AQHYMw0u9PVwGbb7iEezZy7Ka/EIBg==
Date:   Tue, 15 Mar 2022 14:14:23 +0000
Message-ID: <PH0PR04MB74167377D7D86C60C290DAB29B109@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220314073537.GA4204@lst.de>
 <05a1fde2-12bd-1059-6177-2291307dbd8d@opensource.wdc.com>
 <20220314104938.hv26bf5vah4x32c2@ArmHalley.local>
 <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
 <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
 <BYAPR04MB49689803ED6E1E32C49C6413F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315132611.g5ert4tzuxgi7qd5@unifi> <20220315133052.GA12593@lst.de>
 <20220315135245.eqf4tqngxxb7ymqa@unifi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ebc9861-928b-4755-d1ab-08da068e1b45
x-ms-traffictypediagnostic: CY4PR04MB1127:EE_
x-microsoft-antispam-prvs: <CY4PR04MB1127667EC65A0B5DB204ED0D9B109@CY4PR04MB1127.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e0+LeU4k59fcgsPRoTEwEcI/hSyMgsOx5ct+AVRQxhYDWA8EIP2Q5S+/TbFoZEs90WUAfUtG85YtECd8pJ1UteWCmSDQe6qvgJrNj84WQiReuN3ZZtjjCayPLSOlUZ0BD+srtiJsYyvzskeN9xsx3QWAdYyA2iwkt9JJXji+AgiRiIkhigxO5jEYzzd9qT6qQWNva8RqgQYrhBfDHFBr+NViGd/Uq4hmAEMyQzqvboNppb+awX3NAM+/CtTSi/yP+AMG5DSkL6xThiuC7LtqQbwfy71aCPweoKi6wTw2N/SvY/GXIvAoVCbUqgPnhHaHJvnHVWLBhgyc5NSQciMYwgGoBh9SDTKQfhc7RHgbesIyV+Ixf/ZJUUuUEAZmWfqBVITVfrmZFQZVUtFJ2KZSa6bK3UQa/mTOiHFaUcY3dh2eQvG6n711f0SL4zdYnWw+ohO2RkLI9w6uag+GSAj/78eYZW0F3uJRAaNKgk03TcS2AIi24YQfZKNyaYym+e4f5sLeUAUlItgJK7octA0jfv61C5jo1qVd+YXEd9D39G7nxrDP4Wf0nCbVh1KoD+rWD1Duf4OeASs48PEOEx73ilBjI5TMrnIrmtKUba/z0JLDModlUdDX0XTARbFcENG6SOJWzksWOkBGFghzQhflCF04jbsxmz5KpCWakvBhXMwcVwtzHHMJg0DuDUf5hRq/45p8e/rUFzSfeUnSdtRBdQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(6506007)(83380400001)(66574015)(53546011)(33656002)(9686003)(52536014)(55016003)(7416002)(5660300002)(2906002)(8936002)(76116006)(122000001)(86362001)(71200400001)(38100700002)(64756008)(66556008)(91956017)(66476007)(66446008)(66946007)(38070700005)(82960400001)(508600001)(4326008)(54906003)(186003)(110136005)(316002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bmNWMBzsEFi6ILdSxQ31jCf/LF08Bj2f5nSEgiYkGQk0Hpm2a9HHi10y72?=
 =?iso-8859-1?Q?w1LIypi1evxZH02vfSVeiuF3Pz5FlXO0oIq2SoataHR2fAiIzNs7IRF+ut?=
 =?iso-8859-1?Q?wQhNxo0/pDA3ITePXVJfNH0ydd/2OMzqB4w7sH9EhrmG/J0CuifiuOMXEW?=
 =?iso-8859-1?Q?gUsIphnANkoMt/LD+CKQGGw05TYnTuyvCIdljE+1ahg2IYtDdSiqndyli7?=
 =?iso-8859-1?Q?GoFqYc9QGRS3hJLA/WV8f6FhkW6RqyQgiPrsYtw003VKMspQWSrlri0UP7?=
 =?iso-8859-1?Q?Yogpg6j/8CK91SR+YWQbIYMaksIpanzlPtj2kiE0q0+bSVEajcmT97edgl?=
 =?iso-8859-1?Q?C4Q2g/GQl3a8ebLzTEd9L3I0QYnN8Am4L0mn+zSBZ9Qu6JgDJh4Bxv6GrL?=
 =?iso-8859-1?Q?1fQ0hOZ98iyPh5l2FkVPH5zh6M572Tbf1O5QRj0lsjZuP8k0RMW1+4QNpe?=
 =?iso-8859-1?Q?KLNsgmjnevUr51dzBGVAlS9tjTjh8p2gd5cUo/lFSa6KFa5IYhVH0AVRYm?=
 =?iso-8859-1?Q?dA9OKCXLrtCTftwjh8SaktghYgMSg4UkMO3reRupIKhmcvnuvVXT5CDItL?=
 =?iso-8859-1?Q?dx7EVARPHoOl05Zd26sggN71UFPPl6qjcp8Uoy4TGqrrxsSCU97EDugIs+?=
 =?iso-8859-1?Q?bZ+dIv6fqfKVc5NgGu9MGNIwEdZq02i2hJWXBCvTS7DW+TDFQwW4hQ859B?=
 =?iso-8859-1?Q?o+YsGqAB3yks8ROPZJIWHh6byaRJ2o7p7PID5VSxxa5kmmuaAS+LF2eyLf?=
 =?iso-8859-1?Q?fIIcDRpBsORvF7ajGflNO7bL94Iam3DmPjrUapO8k47BoLiMbgw2JIJIPu?=
 =?iso-8859-1?Q?NwaT0jF+kpLyFLHtmWPOzAlhn0dPLOYzwVvt4HzqIvIMzvXZyDjk4KK6zz?=
 =?iso-8859-1?Q?BcZc+6SXOeAg/0PlaQF610ioBR+ZmbiQCzUpJ5ga7d010mmy0f5WtR89t1?=
 =?iso-8859-1?Q?lRX2q+RC5eauj1ftpDTIAFD82iiXb7MVEgS4AB4vDFUuXn9H9BO7GBoacV?=
 =?iso-8859-1?Q?ueecxWo+ngC93HBpwyxbBCAVh05ZLUGw9OJjQbmjgPiy+yXIyFccqbtHAy?=
 =?iso-8859-1?Q?2/ZJyOQnmRKxUEMZc0XBdt3+DMYccdbFNtyxyLT8Lt3tkCAnVJsvABpp0z?=
 =?iso-8859-1?Q?vXj2DzgMSvRN7iP/OCnV90bMOZ0xVy7pR5wTAvPMUrLY+J75YwS6IcsQHm?=
 =?iso-8859-1?Q?BfZJV3actX0selIKXa2s7YH3JHunxRdSWXHdyvrXlXCw84HePD9Ze8Y6k/?=
 =?iso-8859-1?Q?Bs2J+3Op+Exj5A7iSVWzMpp0sN3y7XGz7DsoKv+o9cJdvAc8NLP103A00S?=
 =?iso-8859-1?Q?GCCM2GsHzFj6odNje66zA/ffrk2rHYz2I9Np7uYqh92AlqzAHScbJyWXop?=
 =?iso-8859-1?Q?GIBqhGF6VAs70HKsOGCtxI3Yk2ZKkzMc6dfeXPXo8rtoY6wvRPe8NTCDb/?=
 =?iso-8859-1?Q?QfsX0elDzJ3Wqp1Yro7m81RZcf9vkmKxY07Ml41A4/yLRkGMeNwI+5g0j5?=
 =?iso-8859-1?Q?ZzIucW9Fsv9bkSTyMCk6wCNKLJKKRElW8/vIyzcXefKRE/erLHo4FrVrEy?=
 =?iso-8859-1?Q?YcqLtukIme2SMR19HUaJnKRZTv7dmdmmQokuD75ZT+PZ39jAEmRiugIJYW?=
 =?iso-8859-1?Q?K5mhTr3AwjzIY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ebc9861-928b-4755-d1ab-08da068e1b45
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 14:14:23.7467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cg9+KpA3WZe3pnRasXoBXNGgPvZXa1g84cXgyozu+fc11McZ9E36wFQuJyA+NXioDAOqjWBUSuO0vQQTTMYL1WjY7kXeLyiM4EA4Y1qdfgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1127
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/03/2022 14:52, Javier Gonz=E1lez wrote:=0A=
> On 15.03.2022 14:30, Christoph Hellwig wrote:=0A=
>> On Tue, Mar 15, 2022 at 02:26:11PM +0100, Javier Gonz=E1lez wrote:=0A=
>>> but we do not see a usage for ZNS in F2FS, as it is a mobile=0A=
>>> file-system. As other interfaces arrive, this work will become natural.=
=0A=
>>>=0A=
>>> ZoneFS and butrfs are good targets for ZNS and these we can do. I would=
=0A=
>>> still do the work in phases to make sure we have enough early feedback=
=0A=
>>> from the community.=0A=
>>>=0A=
>>> Since this thread has been very active, I will wait some time for=0A=
>>> Christoph and others to catch up before we start sending code.=0A=
>>=0A=
>> Can someone summarize where we stand?  Between the lack of quoting=0A=
>>from hell and overly long lines from corporate mail clients I've=0A=
>> mostly stopped reading this thread because it takes too much effort=0A=
>> actually extract the information.=0A=
> =0A=
> Let me give it a try:=0A=
> =0A=
>   - PO2 emulation in NVMe is a no-go. Drop this.=0A=
> =0A=
>   - The arguments against supporting PO2 are:=0A=
>       - It makes ZNS depart from a SMR assumption of PO2 zone sizes. This=
=0A=
>         can create confusion for users of both SMR and ZNS=0A=
> =0A=
>       - Existing applications assume PO2 zone sizes, and probably do=0A=
>         optimizations for these. These applications, if wanting to use=0A=
>         ZNS will have to change the calculations=0A=
> =0A=
>       - There is a fear for performance regressions.=0A=
> =0A=
>       - It adds more work to you and other maintainers=0A=
> =0A=
>   - The arguments in favour of PO2 are:=0A=
>       - Unmapped LBAs create holes that applications need to deal with.=
=0A=
>         This affects mapping and performance due to splits. Bo explained=
=0A=
>         this in a thread from Bytedance's perspective.  I explained in an=
=0A=
>         answer to Matias how we are not letting zones transition to=0A=
>         offline in order to simplify the host stack. Not sure if this is=
=0A=
>         something we want to bring to NVMe.=0A=
> =0A=
>       - As ZNS adds more features and other protocols add support for=0A=
>         zoned devices we will have more use-cases for the zoned block=0A=
>         device. We will have to deal with these fragmentation at some=0A=
>         point.=0A=
> =0A=
>       - This is used in production workloads in Linux hosts. I would=0A=
>         advocate for this not being off-tree as it will be a headache for=
=0A=
>         all in the future.=0A=
> =0A=
>   - If you agree that removing PO2 is an option, we can do the following:=
=0A=
>       - Remove the constraint in the block layer and add ZoneFS support=
=0A=
>         in a first patch.=0A=
> =0A=
>       - Add btrfs support in a later patch=0A=
=0A=
(+ linux-btrfs )=0A=
=0A=
Please also make sure to support btrfs and not only throw some patches =0A=
over the fence. Zoned device support in btrfs is complex enough and has =0A=
quite some special casing vs regular btrfs, which we're working on getting=
=0A=
rid of. So having non-power-of-2 zone size, would also mean having NPO2=0A=
block-groups (and thus block-groups not aligned to the stripe size).=0A=
=0A=
Just thinking of this and knowing I need to support it gives me a =0A=
headache.=0A=
=0A=
Also please consult the rest of the btrfs developers for thoughts on this.=
=0A=
After all btrfs has full zoned support (including ZNS, not saying it's =0A=
perfect) and is also the default FS for at least two Linux distributions.=
=0A=
=0A=
Thanks a lot,=0A=
	Johannes=0A=
