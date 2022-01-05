Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A7D484C4A
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 03:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbiAECAF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jan 2022 21:00:05 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:10989 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbiAECAE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Jan 2022 21:00:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1641348003; x=1672884003;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=K6N8Y4vUY02ddvWcqQJu0W5ebBPkdwQY2+dUh4gEB9k=;
  b=qLqWz6Rj/06PR+Z1IAYYCiaCghHTMoixqxNFJVgzC1HyUgLOjp7Jh4HA
   ACQCpDZ+alYKgpcobzoXfi/MMRbGNvaXdwCHTDSU9A3Tq5HWJrQ8x+h2Z
   0Sj71utyzWj1V7btHSlHYmgmqQ7r6ztrkcfBbvP6Mv3Uy3MV+jHc+SbLn
   jW6OFry+7uKccX2Wh/yxeKO5Fog5iA75iGpIp+5sauaWBaqlBrR9ydZRe
   c145gB2AcdbOtvK29yV+tGMKI9PA8VQNF85SUhs1AMre0nq6cWg+tOjvf
   40QoDcYBzkIP9I+vT7Z3fMj3MprA+kyVX8THwBqlFXq59d54yoJA/gNRJ
   g==;
X-IronPort-AV: E=Sophos;i="5.88,262,1635177600"; 
   d="scan'208";a="194508725"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jan 2022 10:00:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUF005AeljC/3C4cb/RWGX7oA03I+e4FHuyfUdle3WjFaoNmYvLNi76dQVaX2QFD5TOXBmwBVUuv71Ds4an6v+dwweqf4Ply7eA5m0c/Cyc8uerliUk5Sn0nSX71wkswvQ2TCLKvbbqJ5Vc5/1rj1FQU0MhO2jha/f6Snig0h/QIyaNgXjF0BuUQRjANRjEET1ple77Z5sG5XPvJb0KDfxC+5iRAxPbhxl0fj/wpZFbBREGs7auNST/hCopRQK/F5cRzshvEhOastUPdmRve05ZfpI4hgjgG8FtlSGq19cSx1gmPnKFygiEprDPCwkZ+xXz7usq8A3afLLKug03x2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUQr8I3hI/CLctwB3GsCO3uLtwhxt4Is1p46v4pkvXE=;
 b=ZG4KxmNkEHbHKfrbDFofyl8rlP+XiD+6hJrmI+MzJwHHlNnBVh1+tuT9/TNldPw/M2SxdBy35ykdpRwR7oMBVWbrka8NgI9q373QuCfgxTRO1H7WCzHBxUPkkH8A1bLh5OMC3DBb9ZRDwmkVjQp7vLNycXSXx0UMP+4DqkjoVK5Ii67b7KWZmHQ+UQwkqj25MhvFC6D4QbWbp1Z71VyD/TovpaTEZwY1ubI9EDOXAcIxHcGJ8WOXfUiQmlcH/5jhsaX84rjtx+7idzkPF+DeVe54legtBuH0TvjMYC0oHz/PiTy9xpxpllLprweKCfLHc5A2glYb5rt/SPOeb9Drvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUQr8I3hI/CLctwB3GsCO3uLtwhxt4Is1p46v4pkvXE=;
 b=S7uXvPrIPxUAaPMESJnWTbTF7joTPDWm8+JGYdciis0NOgDM7LTK/6x7WXNNXp2p6Gvg2NqSxhzhOut0JCgF0ptgLKQS4RfY7NY8X0M6s4WjoTB+Z25qd/W0Ogb19dJSK2qV89GvXLhzQIsDpLvsL8ausF/Gw6lcYldNE4FjW20=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM8PR04MB8039.namprd04.prod.outlook.com (2603:10b6:5:314::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.16; Wed, 5 Jan 2022 02:00:02 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::51ef:6913:e33f:cfc]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::51ef:6913:e33f:cfc%6]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 02:00:02 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 0/3] btrfs: zoned: fix zoned extent allocator
Thread-Topic: [PATCH 0/3] btrfs: zoned: fix zoned extent allocator
Thread-Index: AQHX/Eor2QL7xhF92UG0W9y8378Z0axRs3WAgAID3IA=
Date:   Wed, 5 Jan 2022 02:00:02 +0000
Message-ID: <20220105020001.w2qjesxrfhuv25r6@shindev>
References: <20211207153549.2946602-1-naohiro.aota@wdc.com>
 <20211208161814.GL28560@twin.jikos.cz>
 <20211229002230.6qvi5jelmitwjvlz@shindev>
 <20220103191341.GS28560@twin.jikos.cz>
In-Reply-To: <20220103191341.GS28560@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3aed0445-55b9-4c07-3730-08d9cfef1659
x-ms-traffictypediagnostic: DM8PR04MB8039:EE_
x-microsoft-antispam-prvs: <DM8PR04MB80391FEFEAEA12E904CE2E48ED4B9@DM8PR04MB8039.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nyTiyuThIaDLXhRGRtrobqojlitHx1w9W09wjd8Ez04VH206tLWBe2g6D9hvzUTYaNu4wSte7LGsGRCTMNpRnk83lEIBgbLz13ArDDT32Mf9rGyXjIhGXmfQsx/6QisiXlRpUJgZ3VU0pjYVTM/LZFZ0dzMTCKIzXcMR9HQZixobmknlKnWYEye3dJYxTf1LDFaoSK3u6JvS3dviUE1fD/zB6mRT87aGg2LsyQ9QpBfsAgsry4WBH6PPMwTQ699wYuPfe8TewjQpxjYlLh8D6/34xRd1mThrq34LDd5xDHfqmNydn4IxJeZGVObovqdF3d48VYc8hE5fE5c7KkhxKUTv1Yjj/WCMiH/VVxvIbZJC3gRFGqgMOBPYuljWrG3RTVfK44F+DG6UyAClp/2/fq7bOD5cswPwAJnke1O3Z9Y6lU7rwVFsHeq3zzjYW6H6Rj+thpeaPr5uvJD8u5v8V8zfZ6+3aUlzW0A2OJ1tI26mCk/4KKlGp9YtszbEqRIsb4tFhld2uoD/eDcs/Rs0bbGlfWj9CGWtcBb/CxSDRbPdjrL3cZ8VzjW3c5MiLRlunEPXtrjIbS3kbBk6/8tnnmhULqwMST4mo4EDZ39wGQ14OweupL5FfvOqpPTlKu7XsDCulkNo0MVurTq/MC3K+PIQCM0RvAeADTEEQBJ12sSbLxBysUlr6bM4QezXYHMqGsapFegqLIHeScor6aUgxnrCRfENx/u2muJITzsvje19uk1g1WXIxVJbW14vvLgwUbRsGxVVn9LRhNIyDiz0RspjIz9urfPqoWeFFqDsNlmR72Y5THVvE8SaLwBpO+qgJwdI4Ff1TqTgcLCeRBLXXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(1076003)(8676002)(26005)(64756008)(110136005)(9686003)(76116006)(66556008)(71200400001)(186003)(8936002)(508600001)(66946007)(66446008)(82960400001)(6512007)(86362001)(966005)(6506007)(38100700002)(91956017)(83380400001)(44832011)(316002)(66476007)(38070700005)(122000001)(6486002)(2906002)(5660300002)(33716001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K1Ng2WOC7HLxax/HmGw3zpHpTVU9BquXQNeWF1rKuVa6Vpvit69NYgv50+PX?=
 =?us-ascii?Q?bTdpCEZk4z4zABC5+wPC8a2dGI5aaHKU/CcQ1aSj4hd29Jg9/VTcZJqWdxeZ?=
 =?us-ascii?Q?7DV/mJN6+v0Mh4SaAF1AggsQPo9JWeJkkKGU3OBeIeRuafarSXchuvi9bxRI?=
 =?us-ascii?Q?ZLlYwD/VB80IOPZESDXvZ+9FZA8VT/2nvpYE842FaYAFdtMf5UpDC1/ARQcE?=
 =?us-ascii?Q?18an4d9Ssx3ic2iEaA9T6QhikAIQOrCSUxqSAcjBRtlgxGaJSTl9dsIbQ6ad?=
 =?us-ascii?Q?NSQILNzUXB7csGQJ/9cSaKX0cljPfL4sX3Gt5R6zHsbVv/mdnH1Uh5ie1Epw?=
 =?us-ascii?Q?VGqMUoFCpigc4Abgvd7U1r/t4xh/inC3HVd4E289UEyJ2UXD4JhfW0e7yV2u?=
 =?us-ascii?Q?cSlVJoA4AVAwL2U/xDs1ZhsiRfRNZZ7ZLonj1IPyXrVnlXFYr/DKlwrdTK9b?=
 =?us-ascii?Q?vzdFWNRdQHTBXzmvprRxM4+j7KdLa+f5ctCG7gv9cBuKPDCDKNLdJ+jz/vSA?=
 =?us-ascii?Q?5cOOrz55xzmeLDrGzVSeZp0+tI7Knt76bk3Fq7YBgE/uJYJKaD8Mh3DhP5FH?=
 =?us-ascii?Q?RKc0JBNDe30ezaj/UsicXgkqhka0gUxNLb4q7q+SLhyc2Frv+CIl/MnmOhvZ?=
 =?us-ascii?Q?JLpmzb+okbnBPEmfwJYoOgtx0IxF53WIGKYAQi3MMG7Oe7Ob8qXd647Gf1+W?=
 =?us-ascii?Q?hAWGz8FHj28YM77nOCqgH2C7lxy+i5lU5kWxApVt/PcuQSq874f0XIUmwaDY?=
 =?us-ascii?Q?znq0rAcMHo/CNVQgS+uLA/Xl/tIzyuZchm+AxtGsHPX6TmYSuOC1GxUtwQ2Y?=
 =?us-ascii?Q?cT+o60YD2+mDMw1EoiI5VMlq300ol5kfse28ua3HfPWVigTtcWPs2o/YhIvv?=
 =?us-ascii?Q?p4c4s0A7tEMlA1wo/lTco2Xvj6BAtpTiK9r+Ba/pkSQN4ce+678DrVoiJ0HH?=
 =?us-ascii?Q?ZoRQAGeBRHCgbTkSMgSzd++NUX68+Hk8Tm2ZRJobhWUaZ1scY6oU/R8am9vJ?=
 =?us-ascii?Q?emPTrcCBXHC4pR5viggclxeHxvVU7AEoJ6rtg2CnuyeJUfT97UkVmpO3lcmE?=
 =?us-ascii?Q?ZHJ5TO9AJoPpW7RBHZlkuglDMyTfqMGJ/TIJFSm9TTVfRGOK0mCrWCFq+Q3Z?=
 =?us-ascii?Q?Jg1RVLeLEBn7+zqD+Wq4zxlGjTli9tbFsDYXovum3jfcUjX+/9tlOdI5XTRt?=
 =?us-ascii?Q?lseZTHPFSfAQOzq1xTSMoP5ebNIzgaIlSCeIwLLH3ZlBijnTs38/Ew758s72?=
 =?us-ascii?Q?TI7NNFE+XgHq58HsJWqtM+/GuDrfZJLnwoKPNF/xM4v891GfrZaNHIg/CZPX?=
 =?us-ascii?Q?RQid84EvagaO0gJROyfUXBtZ5nHTHRX8dkSttkeWCmKSmnFb73chs+UaNdff?=
 =?us-ascii?Q?XCd0g3zkzzkoJgwXLNJe0bj1laGdq10x5xoIDWMnADCryhaBwO/f3nuibcND?=
 =?us-ascii?Q?pNDyTp/O98yeJs4r+C0Z0F8JcXJ1fHHJ4g9zTHcJi8A/KG+XTcDibS4DaQgE?=
 =?us-ascii?Q?9FCip+OQSOh6g9Tnq985KmDb2S5Lx19XPIxyQFUBRgH/phJ9QpIbm201WWWZ?=
 =?us-ascii?Q?fSoFDXmpmFOXYj8t0Ok8IFrBdG0bSmKY2aa6o7nZknCpzoQc9C/JqFz0Z1U6?=
 =?us-ascii?Q?sifgY4Bo3Qg6/PAPam3ESkumqaKyuyrMQPuv9EN5F4zYrCOFWzVaqcxOIG+T?=
 =?us-ascii?Q?p3p3f/vai4s50gtXrDj3zfNRWCA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7D908D16D7A3F1418E61591C39F7F76D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aed0445-55b9-4c07-3730-08d9cfef1659
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2022 02:00:02.7465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hp79Vse1MgT7fbmMvJlSa9UEzqoxn0GA1SKH7gePgZdhPIr8PKezPMJKMCIerKx1nIaMg0j6vzYc9XgjKso6fXk70Pd+VAx51UqNJzA+qpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8039
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Jan 03, 2022 / 20:13, David Sterba wrote:
> On Wed, Dec 29, 2021 at 12:22:31AM +0000, Shinichiro Kawasaki wrote:
> > On Dec 08, 2021 / 17:18, David Sterba wrote:
> > > On Wed, Dec 08, 2021 at 12:35:46AM +0900, Naohiro Aota wrote:
> > > > There are several reports of hung_task on btrfs recently.
> > > >=20
> > > > - https://github.com/naota/linux/issues/59
> > > > - https://lore.kernel.org/linux-btrfs/CAJCQCtR=3DjztS3P34U_iUNoBodE=
xHcud44OQ8oe4Jn3TK=3D1yFNw@mail.gmail.com/T/
> >=20
> > (snip)
> >=20
> > > > While we are debugging this issue, we found some faulty behaviors o=
n
> > > > the zoned extent allocator. It is not the root cause of the hung as=
 we
> > > > see a similar report also on a regular btrfs. But, it looks like th=
at
> > > > early -ENOSPC is, at least, making the hung to happen often.
> > > >=20
> > > > So, this series fixes the faulty behaviors of the zoned extent
> > > > allocator.
> > > >=20
> > > > Patch 1 fixes a case when allocation fails in a dedicated block gro=
up.
> > > >=20
> > > > Patches 2 and 3 fix the chunk allocation condition for zoned
> > > > allocator, so that it won't block a possible chunk allocation.
> > > >=20
> > > > Naohiro Aota (3):
> > > >   btrfs: zoned: unset dedicated block group on allocation failure
> > > >   btrfs: add extent allocator hook to decide to allocate chunk or n=
ot
> > > >   btrfs: zoned: fix chunk allocation condition for zoned allocator
> > >=20
> > > All seem to be relevant for 5.16-rc so I'll add them to misc-next now=
 to
> > > give it some testing, pull request next week. Thanks.
> >=20
> > Hello David, thanks for your maintainer-ship always.
> >=20
> > When I run my test set for zoned btrfs configuration, I keep on observi=
ng the
> > issue that Naohiro addressed with the three patches. The patches are no=
t yet
> > merged to 5.16-rc7. Can I expect they get merged to rc8?
>=20
> Sorry, I did not get to sending the pull request due to holidays. The
> timing of 5.16 release next week is too close, I'll tag the patches for
> stable so they'll get to 5.16 later.

Sounds good. Thank you for your care.

--=20
Best Regards,
Shin'ichiro Kawasaki=
