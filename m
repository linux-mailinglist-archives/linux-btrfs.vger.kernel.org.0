Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCD141C2BB
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 12:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245529AbhI2Kb0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Sep 2021 06:31:26 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:55837 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245475AbhI2KbZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 06:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632911382; x=1664447382;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=kE42V8aUpJMEuJDVwU8d5vYn3YmmwwMw51F6jNgf48Q=;
  b=aImUhErQhjZY6KzjRbvzCl3X3M08igQ/3tyjTb8pe3uIDa55IpaRrWnZ
   83B0DD3FLdMnMZLu4mdLv8QVZUhgAe1RSNJpca8squJTW+FamJAiiXyPZ
   ef4lR5c4BVK3xXrl6sJHeQMg7rPlO5BuZFCcGAcM/WeB4bNCOGcgt7oNH
   6LpnzjAd1R6REpP+QILY1WplrUryL1uUofYhAb0Fw2vwjQ/JrCC+7nq8x
   5EnY0279XZF4HtaG9UHYuWMMiQEvDR4A8cKufnZEYDzzirnW1EiHzordl
   jLoOMKJRtl0rJnTJw7P7xR90H4fnWl5EE4LdongPVb6vumHj0eWusf40X
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,332,1624291200"; 
   d="scan'208";a="181296849"
Received: from mail-dm3nam07lp2042.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.42])
  by ob1.hgst.iphmx.com with ESMTP; 29 Sep 2021 18:29:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvhXCgWEtb0+3JvUCW7BRzRj1j5NfkttSOui+5eAtvbrGUQaCjnkMW89Jj+P7tttP1NscPyUbrgVdjQi6s/aL93P5fIUpKkmr7z1222Ag6u8PiCc0UU6qLvV7m7bRdPwrAoV1590heoDdhJZdp7bhYKMU9hn2aSQL4HFhHCQgfCENHgFmpribFVxxw11EKMqmiyyEO8JNI6mtvvUr8O+q+G34KA7LFpQakmqiDL1fZAhdklKV/5a2okphJuhI4Drl62Lfy61eigdNJmcPuolAlMc3IsYRw5Zy6RTW6fflmi5FT8v1TasEb1JzkjcOSVrgIxyXG9z4jCdtnf44Dj/Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=VA/SmdK93DMGl2Y22Z/+pfcltlMYw8erphETplFZ4gg=;
 b=a0ocBZjg00U1FIT1wa/BUhVHfe0Ql1pImBDp9cMTuhcT/EYvjA/6NQFl8WjIGqjJrG5g3sB4Yr7TmRv/zBHHh4HPCNTkCRWBLAK00Kr4k1+hHzODisqhPSYcSa6PzYjwrdh1btXXRUdywLhjNVeUYTpwsTiiBPs8qymhmeomJ3BfDinymhfBau4ddsaOalvbr4K4JUjMtKcxQ58nlHksSez4yngkHXolsB7LkKpQuPS2rVZsxSoggpOwENRfa+2rrQfFb6F43v6WSX7H1ywb0AdljOXvPkBUFFCXA20yaf6n/W66qY3VtaaROkBrfU7P+HEBeCdoEEdnHLCDPuK8bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VA/SmdK93DMGl2Y22Z/+pfcltlMYw8erphETplFZ4gg=;
 b=SFExRxzNO6Gq6V0ue8UdCwBUgfIzhK8nyxkiBvyMvgWgJSFEylQZ+VE5LjzlV8bizAEZJGw44pJuUv8ETId8jnhjYNVLN9bUcyTd1bSzzvMagWO/cTzt/pQm2NpGOp31ABzt11yJF8D51C0ChDGjxAJq4zUArslgUcIxPFOPeVM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7351.namprd04.prod.outlook.com (2603:10b6:510:a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Wed, 29 Sep
 2021 10:29:42 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a%4]) with mapi id 15.20.4566.015; Wed, 29 Sep 2021
 10:29:41 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Sven Oehme <oehmes@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: Host managed SMR drive issue
Thread-Topic: Host managed SMR drive issue
Thread-Index: AQHXsXGwJGr/oBwu5kOQfX1ME0hbsA==
Date:   Wed, 29 Sep 2021 10:29:41 +0000
Message-ID: <PH0PR04MB74161E1FC9F7A2CBA1A9A7199BA99@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <CALssuR00NvTHJJuoOFhw=4+fHARtBN2PLqTr4W06PT5VMagh_A@mail.gmail.com>
 <6db88069-e263-ae85-4f69-adb9ec69ee76@opensource.wdc.com>
 <CALssuR2gAEoxhDK=z0ryx30GAWiXcZ70pbUEq5mAxd-5pmsyRw@mail.gmail.com>
 <CALssuR2K8Dtr+bGSYVOQXcWomMx0VnLwUiB1ah44ngrJ5trnSw@mail.gmail.com>
 <a9764186-90ab-6ff3-7953-07f39d69ea5f@opensource.wdc.com>
 <CALssuR3A4Um8raXi1W7O74PbgbcNmummasfZrY=sPj5t6f+eWg@mail.gmail.com>
 <b010054f-ba99-6cf9-8318-267e3b4cff90@opensource.wdc.com>
 <CALssuR1sqLDkyf4iyFhJv108BePHSoMPD=r+pDfeb=mcPWNaVA@mail.gmail.com>
 <7038f4b9-a321-ef7d-1762-c0c77d666d55@opensource.wdc.com>
 <CALssuR1Fpz=wXsCY6N+6ApU-1_tBzjj_==+3s2NOws9fPReYDw@mail.gmail.com>
 <PH0PR04MB741686C587780B61EEB337A19BA89@PH0PR04MB7416.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68bf9d28-14bf-4724-af59-08d983340c52
x-ms-traffictypediagnostic: PH0PR04MB7351:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7351E7308245C69B4A7925829BA99@PH0PR04MB7351.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: skAjliDe3D74qKQ29xWc1KnfxPKbZ3XB+AJqS4bZgW6LDJablY6tw6RWmpWOtL94Bo/u7ncJulnXtuS/QsP3Hj5Y3exO22fhMBQa4Lo9QS25wiQKhq0H8bAA4IXV/hL9oYTqVOVEZYxL3S36pbCNAKiTnO38cDCyV8hOZSbFPFVe2GFPLkW5KONsix24PnKdLQ2UArXFtZGTeqrCH0tTPvNipVdArdBOd7ktPi4gMdmglIbtSI35ryEFmY/jE25Bp2420cdlofIx4v6cVdasm451Wo9Qxq9qzdVZw9bGaxd5AbfTagNLdvA0o2k5e1WXhPWhb4+firpjPTlUTiiUe96ZfaXifpBadfEddiz9+niveF0EXvHn7SGMoLnhH+apYGSisn1oWqF0cL6wzEbwk7q7piW15h5iwf6FhxwjBle65HIAIR1iLZ9HgUE1uqlnrgF6moM15VpdnA5lGaXxYDM1DL3yRXE/+V0xLMN6sKv/4s41RrlOgJCcJKrSx/iHwuCiWOcxM2+A17yNmfr7rnpeS3fdjAX7Bn1yE9zbHDyO7gmKwfX3uljlsVJoN73LzlpW9mITGDGGKK5I/aEpi5jkBe7+fz3zfSzHi6U2eiKaNC7pjI75vP25iTlyeJHFvUOAncnS9Pxx2eu1IJpBlLI2tXQwQ/tAPCwOTGyt8ehQ39Kz/yRvbMBChGPKw26VSZGhaQXqQLW3O16NflHOUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(33656002)(5660300002)(83380400001)(8676002)(38100700002)(4326008)(122000001)(186003)(9686003)(508600001)(52536014)(66556008)(66946007)(66476007)(316002)(2906002)(8936002)(7696005)(76116006)(64756008)(91956017)(86362001)(54906003)(110136005)(55016002)(53546011)(6506007)(38070700005)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YOIPmfVs5PWaZizPoG0mkaFWw1ofNvCwwC3JP8Yp8VG6NnYmGyy3u3TEyjoz?=
 =?us-ascii?Q?zuycmWYPyVqM0NPDG8gnp+YKvHeEN9C3R4sk+VWf+eYnEsQF5SZudEtx9aSN?=
 =?us-ascii?Q?lkmV/qT8bxrZA8K2dIbt4P1JGm4qCZasAM7LGZ+9c2SCxpQrg/Syc1tX56K+?=
 =?us-ascii?Q?fKuzPCZMgcaum5uP56bmBpoLsBEqu0FxXwnG6w5qt/4NBb1CADkK6d4FUbv5?=
 =?us-ascii?Q?ZVR4qMqLEcf0O7oEdVGuVyq1CAl9Nd2rFx/aYVbsNYaOeolzKMnUoug8Cl3u?=
 =?us-ascii?Q?28nfuz1dJKM1TE959oHpCCR6UenjEONy+Wm7AhRcqhBncLK0zlHbwERCM33h?=
 =?us-ascii?Q?udRxtjyrosuV2uiv4CE8Jkx6QAqChzLy7BoWEoi1/NQU67eFkH1ebAA3qg4P?=
 =?us-ascii?Q?jm9eSZBzCH2qOV1LR8CqiGQ+HovuCWj3Zpu/rSa87xj7a8ojcWaBUCtp0tOd?=
 =?us-ascii?Q?1T55EjIohwCaWBOQonvfDJfNmJ5frhE+7M+SZur+JmeiTPD1JMwLsxKVPdbl?=
 =?us-ascii?Q?HnD+qjyC0XfOpg1LbTTdqPuN+yh0b7fSsFR8hUtHTXb65pRxPlbh7OkUdnxO?=
 =?us-ascii?Q?16/y5rjPp2/I/Z+XxYn0okjXz7T1Mm0kB/e/UgS2x+HGmJzQzs3IX92TFN1X?=
 =?us-ascii?Q?OlgMOsQS+4y40tikyfUlhcm4hAfaJ0pEKdxm2mYdbtx1eKQ/S6XsrnnqahMZ?=
 =?us-ascii?Q?ZdPPutPPtpAgdyP4FBln0oRfX6ec3PXvVmWMSxTLNSRxHJMHOoCkJvL6Bfss?=
 =?us-ascii?Q?MVE5NIZA012G1e8olkBiVJ+OzLqECwqsdx5ZKipEyWotsDcalBw5VtnXlJ/T?=
 =?us-ascii?Q?e4/dOd9aQYd8h+MlfMGN7rez3fMmhqiBSjz55WyecznXhA5d863D55BqzvW4?=
 =?us-ascii?Q?FSpf7qkLlmv6JIIqUbegaYOeqaR0ixCVztMpP0EbSOm/LEGsBp8jKG2NmKK3?=
 =?us-ascii?Q?LAoVBT9mFCGHWrD6AOttJz2GK/Otlp/crm3UjUajhLkhQ9XgQY06p6dzKK00?=
 =?us-ascii?Q?JQN1OL6s7INWPbzWxHQVtTizlOtziJv1J7THyNsO842ynwxN8hylcGKZtil5?=
 =?us-ascii?Q?wAsDizBvBN+Q+vs0TXD5OiiP7dOjm/opyFjhGGKVP+U7YWOSjYjwpJo/EniA?=
 =?us-ascii?Q?Qo1EwBPB8mNci8ewTqfKOOIr/KNnEKDG91lxqPlSA+Et8RhMynIAX3RdNvCd?=
 =?us-ascii?Q?ozvR295pp9E44gF8M5E0IAFCNWLO9vzIeMwzJS9YCfZt+RkwyJoivXwF2hCb?=
 =?us-ascii?Q?XwHRAdCubxsBV7WXelGHArDSMUHpjPyT6cNuwRVavpnVdg7M7OvaMSIdBj4s?=
 =?us-ascii?Q?YLAoDJKTgCTjxCLpcRDL6pN5d1UgtpgYJnGAB8RnzBhKiwqwg7CJ7/2z0UZk?=
 =?us-ascii?Q?nTGuewlJWCVIQ9G1nb7PG+3OZUZSom6e42VoEYLmT5OtdR7t3Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68bf9d28-14bf-4724-af59-08d983340c52
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 10:29:41.6555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oQvl7/sZXBZNbntO4d/M2xB2xMOeGhATWa3zQIw954SunefGen6OktMt3ousC1G5xL1oHKH9qohN9hyj+GlWcISm7rIULjavAAHl38meVZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7351
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/09/2021 08:36, Johannes Thumshirn wrote:=0A=
> On 28/09/2021 01:34, Sven Oehme wrote:=0A=
>> the workload is as simple as one can imagine :=0A=
>>=0A=
>> scp -rp /space/01/ /space/20/=0A=
>> where space/01 is a ext4 filesystem with several >100gb files in it,=0A=
>> /space/20 is the btrfs destination=0A=
>>=0A=
>> its single threaded , nothing special=0A=
> =0A=
> Thanks for the info, I'm trying to recreate the issue locally.=0A=
> =0A=
=0A=
OK unfortunately I'm not getting anywhere with my tries to =0A=
reproduce the issue. But I have a hypothesis what could be happening.=0A=
=0A=
Can you do me a favor and try this:=0A=
=0A=
=0A=
echo 'r:myretprobe sd_zbc_prepare_zone_append $retval' >> /sys/kernel/debug=
/tracing/kprobe_events=0A=
echo 1 > /sys/kernel/debug/tracing/events/kprobes/myretprobe/enable=0A=
echo 1 > /sys/kernel/debug/tracing/tracing_on=0A=
=0A=
and then re-run your copy process. Once the hang occurs please dump =0A=
the trace buffer =0A=
cat /sys/kernel/debug/tracing/trace > /tmp/trace.txt =0A=
so we can examine it.=0A=
=0A=
I'm expecting we're seeing a lot of 13s as return value =0A=
(BLK_STS_ZONE_RESOURCE), which would mean the zone append emulation=0A=
in the SCSI stack can't lock the zone for writing and re-queues the =0A=
I/O to retry later. Which never really happens because.. =0A=
I have no idea yet...=0A=
=0A=
Fingers crossed my hypothesis is correct so we know where to =0A=
start looking.=0A=
=0A=
Thanks,=0A=
	Johannes=0A=
