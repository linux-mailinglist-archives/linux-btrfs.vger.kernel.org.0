Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 151BD37BC7C
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 May 2021 14:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhELM2u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 May 2021 08:28:50 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:53666 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbhELM2t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 May 2021 08:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1620822484; x=1652358484;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=lgdAUBAGydWPhmzgy6Brjs+soBpHifSy6P2kC2NhKMg=;
  b=dGazVHmPH4kIOLLoTOTfQC+or8YmG+i9y6FTKlOcw9qjjC1oj8FufNWF
   /96mx0RthTrBVEaNKHJ4qW0HR7OW08KsvjZLdhL2RPYtGvg9wtrPRKwC6
   TSQbNz3hxleKCuUmlg+pDerWCLy58rJX2OaljtyVS6Do4h4kHdbtgYzSE
   3eC85vCAhpWKW7BJ7VabK6Wdlh1gtij5kVBSh2CrT1JszbSWKnwR8L7fR
   YYGuEEps8zPy4Xs/z7/P/HYMoUaflKlpqr+NfgF1oY/Ku4qUvsu606nty
   jZFsqGm557YgHWe189JsdYnynjmoy04WqkMuwk+S2Xo9S1txCEpCjhHHq
   g==;
IronPort-SDR: T03A21rxi2Ub13UPdkslOI25xEv/pLw+9N81NLt6T0mVquxZjMvN568FXUVwpS4IhezfU+I0O1
 klKSPK0uoXUANSS/reDcyRWOH+mq5tr68Qdx24vLFYjwYUeMIo9gojpu7AeVRQwCgWzzw+roXs
 PMIU6oXxL044ctjg9Wn7bEH7KEUcMV/NdTKMHKPQhArtvkiUKBlaujzHlxmnxvPhJj0RXpmRIh
 A4VaYiuXtTaaY9WcTpjMoMjKHc9e86LHP6V171vSc4pJe4/YhrDHTZkavxrbyNyjaP5pbxF8bu
 boo=
X-IronPort-AV: E=Sophos;i="5.82,293,1613404800"; 
   d="scan'208";a="271869700"
Received: from mail-bn8nam08lp2046.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.46])
  by ob1.hgst.iphmx.com with ESMTP; 12 May 2021 20:28:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfRJv3VyjCdEfTX4mWfK0tUF+Zh+Z3KOpblMDcFQ/inH7simMVDgdvX1IfUNg5ZLgoiqsk+LakJ76LMOBXBNDOUkmV/nLSYqqVzzM9LSo4R0z97GeijUMMtqWon05IrntHJjqq6Fch1bR0+vrA6wgSWTkQeX9TcoGxUlKEyOmsZq18zvdVBlk6qTIf8FUPKRAaxUU5T7G0KgDKwLXsQqzUXPbafnQAYI1TVhMpsDSIO73y7MeRlQMa2nI+PVA0ALG0fzhCxdkv1lwcr85P5T5lLqIN7gn4/GZq8mWwAYjx8ZhBa6uSPylhdvm0YYlbIPmb80u1/4JHe1VfdxYMF16w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgdAUBAGydWPhmzgy6Brjs+soBpHifSy6P2kC2NhKMg=;
 b=GoxsCLyWCubE8eNk2bLfdmGyVCtFFQIj9nkb5jQpFiOmPtFNY6naD8z5/Ry2ikXFu6H7Xr2ISUPCeYF2uyNW3l63U4NLjMIAEAtuDrug/U6GOn5D746fyt3UCRFLOxz/zz9eWW4L3eCXmivRcpSpvjqr3rrbj5XKa3nygz7L+XvFiDjsB9h3lSDkmV04XCjDtR3XW9d7O9Y+ILMA2AzzNHJWWc3QKs237qBNwnl2rOnugtnPkiqnDdWsHJiBT/tTczroU2ZLu8ynXbUuJMe3Ia3WSuBSKkPRPsu4ijXj2GhlgLaC2+5HZLlrmuP8f3jkBcpA0U8+kDlXlcCEcge/hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgdAUBAGydWPhmzgy6Brjs+soBpHifSy6P2kC2NhKMg=;
 b=KV4vftV7D/3ITj+ALY1BYa29Wske/sAydHpkJwJ8AGtK57bTb00FnkJ/1eFv4pbWFQQV5Wm/Yqet1q6vaOFx5UotU6VKiXUtETjs7u92HlecUogYRd0fkDyhafq1HIPN2QYJeAb5QK6pNvuUzaCgtEtolcOapOsT6O1ds4ELh4M=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7462.namprd04.prod.outlook.com (2603:10b6:510:15::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Wed, 12 May
 2021 12:27:37 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4108.031; Wed, 12 May 2021
 12:27:37 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: check for minimal needed number of zones
Thread-Topic: [PATCH] btrfs-progs: check for minimal needed number of zones
Thread-Index: AQHXRwPeNAVqoOeoTESU5UkfnVBC7A==
Date:   Wed, 12 May 2021 12:27:37 +0000
Message-ID: <PH0PR04MB7416B3B35FC2173F35A818919B529@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210512075305.19048-1-johannes.thumshirn@wdc.com>
 <20210512103653.GO7604@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:152f:cc01:2079:86fb:b3fc:1190]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7132907d-2339-41f7-8e20-08d91541541d
x-ms-traffictypediagnostic: PH0PR04MB7462:
x-microsoft-antispam-prvs: <PH0PR04MB7462566E894E7926D1757FAF9B529@PH0PR04MB7462.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZpgdTVe3Eovj9HqGtO8gfG3AbJxiNFv8bSfDg8XI1O+QS6kHyh3UA7+dKhJ/qfP2khMKyBhVijxnS/mwu9bizwTIrbk1QvSx3Sq2Yq6Dj04KgjBDWuicX9uHJZb9X2cb8eivPuT8B3c34ONtvWj1gVUV7A3EmE0L7+l9xAP/rt1Z31hxqhs5nrMRRPrMVQPCoFl8nGFkgrWRM/4tw8yEYehjAxmCnS4P/oZ7wU3f2SfsLwLtqrDgHYqXpu7ayiC2HhDAgqInxfPhUAWnJLu35bAAFsJ3sXzuIXkPfuJBFs7V4NxEq0SffnaOg5Rfi9JGzKXIcGHAmgg2Ii15ivmOaYJMrOHtROBsSVr2wlVwlgCbDSX9yrizdPQ1/qMd5MHqBFE0i+qRX4gOP5VDLPZ8LypMQeAZa+Y4WyE4GxamjSqcNxVrF9ij9zDccArSBaM+B1L2iNOLzwupr/JC4L65hRMXbr63HkSkhUSt3ZhX+j0Caut8mN8YX62UKKyLK24IFqNOb0tMU9DQxyWtAWPHPeVf6iurVpzll/DGUsLYaZOJ/v0BspKNMQG4rxgNNkN0vFlxi730wh7Yi7qzQLkCva80fElTsO2lDSUqrv0QZ3o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(64756008)(66556008)(5660300002)(66476007)(478600001)(7696005)(186003)(38100700002)(66946007)(122000001)(66446008)(4744005)(2906002)(83380400001)(6916009)(86362001)(52536014)(91956017)(33656002)(4326008)(53546011)(55016002)(71200400001)(6506007)(8936002)(316002)(9686003)(76116006)(54906003)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?QdXzyOV3FM53li6hxAR+q6fcP+SgoxkMg04iO+wsoafOTirtxD3cGLyFZ53U?=
 =?us-ascii?Q?1oUthXVeJfrBZ6/XVmefUX1WTd5lUxspeg6RRThQSx3aqSpin6jsemavvFQ9?=
 =?us-ascii?Q?nTMl6i/K3jKO/jp7OdGVO3q+680WG0pE80TItABIeIcQ+TSBkkxAPo/nYTDt?=
 =?us-ascii?Q?+rzxZIWgFvH3oNAIsPxzTX/g4QEZOroWiqHOo4YE5KUQ0OTl8XBlE7upx/vk?=
 =?us-ascii?Q?3B7nlDsILRy9GZSCbWBc0OMBFhuGvdC+VEHRfH97K0vvp2cIIVElVu292oeo?=
 =?us-ascii?Q?BStjEn5za8VDukQIZ/yyPSNu7h+ZInF0hdovWqh7msRlUH0QFZrJe1mHhVS1?=
 =?us-ascii?Q?feJ+yijrPjLeP7D5mOvtYGpi9vU0YyNO9a9pmh3I6HqMcXIBOFu7iSnRUZb0?=
 =?us-ascii?Q?Txf+YzNsBXruUAodp8ZHpus5bOZnN87BA8PWiNfQth5asnFfboUcbXA4J9jQ?=
 =?us-ascii?Q?6BP/6OnbEr/KUKkeI4lXXxF+CnocFbIK/whFMi0irlyZ/xVeuED90b19lawi?=
 =?us-ascii?Q?6BO3jVwxWhnx2kEl+KuOS1mXhiJ7g5Kw7JmdX0P1hYDNuBT7ZBClcIQM+bx1?=
 =?us-ascii?Q?br9nUI6645w7Uo6iU2ijGBGcopBM92wkaxUlwTFOvtK0iGuC+1O7xpBLa+Gh?=
 =?us-ascii?Q?9jixhR2iY613QlUi8qYKs3f9c9SO1tjZ2QrB/ma71pA+gaxWH48S7Zf5pXLj?=
 =?us-ascii?Q?NCeKxDIhoUHVR7bWCXdj34dVcSDw75N85wI9nkD0ENP8TMOiboQ7L+tcjVai?=
 =?us-ascii?Q?Uny3nL+SmHSD+uMjyuzwYMu1ewPSvW7OADr+IBtRseU2lzhw9tgAHK9QXGKu?=
 =?us-ascii?Q?7hjGW/J5VfZEguaXItU4PckSpDUasU3m4OIXIotJ8JudyLzDDpA7TD6quSRn?=
 =?us-ascii?Q?TAU9VjlHsj/aZJehVxnuXUTJEHeGJuRTQ44Hv4cv/IfagyeSvMhYJAsARJkF?=
 =?us-ascii?Q?qvb5L/XbzzdFzXn0qLl6BrnbdngviURXvmi6Ext8yiTmZSLL04K3ZLyIfIrw?=
 =?us-ascii?Q?r6xo5H34C6iZcQv7GD5iCjGCSdr3aYoa2Fpvx9cLAY24W937L2KLgO1c5d0o?=
 =?us-ascii?Q?WeBzxA7rhvLcqROdTGHgMwWRjiB4iG4SBC+wv9A6SE++xlDwAAy7OZiQKJxF?=
 =?us-ascii?Q?HaMq5hEXljtKaLkGl26ZfdfCtI63P4E82cdSVyBZPAVfIySVyywgMMxrwldE?=
 =?us-ascii?Q?zOPEN6QvOeBOzWwlM7Y9VCkyIsbe3uQMVkHI67ktgmMjNQNHy7Rl3R6viWKz?=
 =?us-ascii?Q?LvQQ2rLk2a3BzYtJh3qRcx5aueCDA9sm7gMH9RaBzVobLd3NQAiiE9QoNawN?=
 =?us-ascii?Q?9gjFd8unVOB7mssqtpoNcQ+AiPHU54gjmrqJs2bp4YaR3UwmN3tyjLLUArrq?=
 =?us-ascii?Q?3mAMd2KpmO5bzmwfsTilL7Sw//NuKjfhs/+imq3R+8JIVx4fQQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7132907d-2339-41f7-8e20-08d91541541d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 12:27:37.6771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S+LEBPNS2yW6nsBB/anZYu5M0sSAcGXtlgGnlJ0tLeQnk5Pa58XJx4GNKpZ55N+Db40wyKBKSKebAJfxzLycnD1dpupbsvUaFHZZ9UL2U8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7462
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/05/2021 12:39, David Sterba wrote:=0A=
> On Wed, May 12, 2021 at 04:53:05PM +0900, Johannes Thumshirn wrote:=0A=
>> In order to create a usable zoned filesystem a minimum of 5 zones is=0A=
>> needed:=0A=
>>=0A=
>> - 2 zones for the 1st superblock=0A=
>> - 1 zone for the system block group=0A=
>> - 1 zone for a metadata block group=0A=
>> - 1 zone for a data block group=0A=
>>=0A=
>> Some tests in xfstests create a sized filesystem and depending on the zo=
ne=0A=
>> size of the underlying device, it may happen, that this filesystem is to=
o=0A=
>> small to be used. It's better to not create a filesystem at all than to=
=0A=
>> create an unusable filesystem.=0A=
> =0A=
> Agreed, though there's no spare zone for relocation once any of them=0A=
> becomes unusable (which is a known problem and can happen for any zone=0A=
> count). Once this gets solved the limit will be increased accordingly.=0A=
> =0A=
=0A=
Indeed, I'm planning to have something like a 'global' reserve zone for =0A=
relocation. Hope to get this done before the cut for v5.14.=0A=
