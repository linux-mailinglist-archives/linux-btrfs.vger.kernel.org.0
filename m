Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC50E3B9005
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jul 2021 11:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbhGAJw1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jul 2021 05:52:27 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:19607 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbhGAJw1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jul 2021 05:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625132996; x=1656668996;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=dUvQUb8ewHqyr4OnHSZh5FapA3QXjnj6g9qSNxlbjxM=;
  b=mzWBd+bzVP1YEuWGWmloKLgkzKCSs8GdxriX+/HDHHbg1tvEeA6iEMcV
   fXnzavIOHfa9gC1HaH8m6V6geX0s9pqFHFAee/xHSJgc3nqlH9Zm0leaf
   EtYJKegpPxGPiVe1vbivbdU9CtxTogfx8TGrECVnGt7+mSLOnRk6aIqtj
   KJNJEV/jjhAfRcS+vYz9YmUiBiImlY5MtQNzyFv7wmb8rGyWLwoUFsVOd
   ZEHrL+XuqafCG8GvhJkUrlpJO/oVoXtt+mX9GIRbGd5tXEFMsQRmRCw9c
   LxHTsImcLI/q8uzOMq+/3aamJB3kElRyMvg26+indJypAJAfJu/GXO8qj
   g==;
IronPort-SDR: C5VMnAmUXxXYqFdW34ij6KCCtnPU/1vWPSCp/jL8axk7ipmiqd24ZWCcVzkCxngEn/tGhNMgj1
 nW2cj4TpBOiBTsw7l23Yz15D4cx1YU98rIK0mcb1fcrkoAM/aKanZcQeXjfVYCKrtJl0shmFw6
 VXQtzzj8WkNWT5ufGa/4X5lkac7A0qgbE9FvMXqS9xay99ZI7/BS53BdoI7L9gYPtESW+qxO9C
 X27WiqM8DOToekzs8u/m7dW7tQoWyeANbOQ1KOoAHbrw13f9Uf81+wjtRafA+juwnt06aWdQbL
 gzI=
X-IronPort-AV: E=Sophos;i="5.83,313,1616428800"; 
   d="scan'208";a="173431935"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2021 17:49:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SyFjSCu0vsvHaFpJDW7MZgdVBb9Zt5N11g3iT64n3l63XGGG7nX5+VuqB/QPTFO8ogEacdvKafdXP2qW0GQDP9cACUeY+gUtA5Ad97O5BuZkhf7BwQAVw/BiNg0YhyseivLtrt7MgvxuZaq2mAU+6P9KZlT7QgXBPvTZ12J6m/DfoDaqdEx6gHOJmJacAiWw60tgw+gsfvszrAco8Y0ZlpevMExcx2l6/YsTaX5Bk1RaGEJpZPWPnMTSgAPGh7NkiYQ9XM5Ti4U130DXK98IliXzKuMFfL0Wkh5s/oZNSgXN/umBGXKm9XNQa6Bj/T6HEZuCUn+NTrKMiE2hNCxd0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8E/rNqeplzQX1+CMCqkeCva/byUVf1f44ZC9zRrk5A=;
 b=ndsHEZIU31jKpsmeEdOG7YDFxdfmG1+HcATD/TGmVH3uVNWoulJ8B0coRCMU1kRgfM/WFxibU2Hb1Vq+W8EovoOZdRpXR+yLNW/XNJ+o6t7Y7QDNomrZiscSZmBLFhR8MW9qBLf8v5rwLVYfRYYsZBp4hx/Fb7MkDu7G6VEWN7+BkkHBeom4riVkZxOzj1eqaPD6mP25AymaSt6AqtFcuyagYpVH+FFTOhh3te1wvjTDXOkteqmlVyhwvyXwK4Qcy7wHE2pXx+VSihec7To+PHFbIoeNjUy1xUhoAKeOo3SELeTZAVyHSPHppsNyXKPn3c4UuLVOoGbLh+xdt+YCMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8E/rNqeplzQX1+CMCqkeCva/byUVf1f44ZC9zRrk5A=;
 b=uNKBwbzRN/JcOSIreZY51w7Fdkeh4kKUXqHaPd4WCjjwoY7ZQfrtYVqowhyH2PS4waMF9Mk0W3l3K0BjK6LKGBufFGmlCX4cyUMgVHPGn8pL6sbphXkr8kO9QxxWsRLMwKlvB636xKg4dhs4uPLOJrRBoDl94EoXFG8bLItvcaM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7239.namprd04.prod.outlook.com (2603:10b6:510:16::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Thu, 1 Jul
 2021 09:49:55 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ad2f:e5e4:3bfd:e1de]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ad2f:e5e4:3bfd:e1de%4]) with mapi id 15.20.4264.026; Thu, 1 Jul 2021
 09:49:55 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] Revert "btrfs: zoned: fail mount if the device does not
 support zone append"
Thread-Topic: [PATCH] Revert "btrfs: zoned: fail mount if the device does not
 support zone append"
Thread-Index: AQHXblEHOYRdsGClKk+xpbdyITTRdg==
Date:   Thu, 1 Jul 2021 09:49:55 +0000
Message-ID: <PH0PR04MB7416DD6E45C7BC7F142704639B009@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <00c2351fa6070a149866df5e599e09c908e9cf26.1625127204.git.johannes.thumshirn@wdc.com>
 <20210701093426.GU2610@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2.247.255.248]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65d9af88-caa6-4feb-3004-08d93c7594c3
x-ms-traffictypediagnostic: PH0PR04MB7239:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7239F1522D48767236B6AB499B009@PH0PR04MB7239.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EHQ4X4rsta1Exkcuw0tLG5iovODL6nEA28D/5tTlbRJy2i1rzfCZjHDGx26wLLS4rlTZCPNRPbycYWL0L2Qe5TCfxIxkCIos/4BaQ+qAWQZe0Koge4881Gg2Qs+OB1fTV4wvn79fnSTn3or5/XjAYwQ1I6axzoLUbB040vnv2nkXX8/jRibcM05tB3r8CabdVrOOow5xHckJfaJVaboqImKV/wJP9Z8WVCZCILkavMwR19t+7FlnupZNPP890gOPFX3A8cLw7rNevm5u7AaVj0/z+VmdUNBN+XhGoZFxbtbZiaFyIGfXAk8CjyEmFSqG/NdqebqLxykcu4MjtN+iezdAisGK7IbqhaH4QcjvMFYi6EXImcRjZhzBp1gPSAtw0kv6ykNEPFNPG1axGlEZAMtoAifqMqHvD+TVrORWbWs2zDx9ZgmOGiNYKb7JPnL7mFZhVLI77OL1zIkpypgfNZ68KJNK69yNfoQ9NY9cBvsq+CgbmHZrRT7CG4+p+EmTSMgZhRIdDWH9UYEV78KHMoionRGqAIPfx3OhwSyV+mC1iUTM9C7kvh7QCRTPtNmfhx2NLSE9oTYmNh48qiPMhHUc2T0OFNnT1a2PmrTRNb71sUqtGREHfC6buRxY6fhZe8sCe4qFOzjlSAWbgWP/9MJrq7HB+2lRs6SYMRym1UmHj8i3FhneGoHCMqGf2S5FXUThAM6P+X4dESLGCuf/fbCb8PnOiGqPWB2D6iX/R5ix/Plhzhgu2Unx/MU5qo3h5ar+4Ewi2C4OTD8gGhrWzw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(64756008)(316002)(4744005)(53546011)(66946007)(86362001)(6506007)(26005)(966005)(66556008)(83380400001)(76116006)(5660300002)(33656002)(54906003)(122000001)(6916009)(2906002)(66446008)(91956017)(66476007)(8936002)(55016002)(52536014)(4326008)(8676002)(7696005)(186003)(9686003)(71200400001)(478600001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iRBHLfTOlgMbcFSD+7YwiGhA75RdZPrALTxu5FPf2y4qujIwaB9zWX/61Ago?=
 =?us-ascii?Q?+3fbVl8/dAZ8DshOotr8ek3AekYeEnh0P7Wtw+i9ov8+URg+RgMa78tSvt8v?=
 =?us-ascii?Q?pymA9E4UsMh39uUriA0aVsb9HJ7smWM1Uxej3XlPEGTtRMYcRiDjP8WRVgzj?=
 =?us-ascii?Q?JS6KgVEUZ3lh1zTft3Ymqq+pqgWuT8md3SYmABJWfteSNx+vnrn7o9ENqB1R?=
 =?us-ascii?Q?39TwXpFsR73yN0TYajviiMMLYAZWjqDg++Je5gwv0GA8zpawBga7LDtlAvhu?=
 =?us-ascii?Q?zh6QSn7uQEJQeLKCNm9PSioFdOvZuxsKUP/5JVEbwfl8b9dc6oYzSPmApZKD?=
 =?us-ascii?Q?3LtofykAnRYroVqX2lfccjvtKQikRlt2e528DID/FrrfxVjr9cXWEOsVufii?=
 =?us-ascii?Q?P+MruoRjC/010iCRZAy9Z5mMikv5odmK3wi5OHdlhyb1gcYMKn6TJmuNLIRc?=
 =?us-ascii?Q?Ckn7mJth6GUOxJ3gQAdlRQtvnm2bYo8H3jUqXEnaAQFzHYA736MATqlQ9nEH?=
 =?us-ascii?Q?vysMy0fa2L7zMDuYr32jaHaxYnplehF2CR8+vyaPMXPYW3B/uSSdXKw8PQpy?=
 =?us-ascii?Q?TPO/o9uFp0QRnq9RqGVQH9M11cDBepZf98PD2QYLNHnr/lBedmzfedM2pYEQ?=
 =?us-ascii?Q?4DI4oOuaUKzz5NLpoiz7G/E2N/Wl18F12VqvKAqcW68O4KGQOc9Kxei5CQXW?=
 =?us-ascii?Q?M4aLowWxHq2bladGRvfwtlIPew611Co3jxP2103MRkjbBGJwY5ytgzgTymtb?=
 =?us-ascii?Q?cVigcQr2wFas1ETubeotfhhcjM0Y7T1mu5mRG/Y6vNmq5ms/ihxo7s0kq/3h?=
 =?us-ascii?Q?JyYHrRtTeLXmPhyGPU504vsBCjSMwyqGMxhyudPcvzlZ21Obz1q0qAKfA381?=
 =?us-ascii?Q?ZfeUH9mkjG/zCUs1sjwaoppissIZJCF5Z/gGgcZz8MAmmbg9vd7+jr8vLWOG?=
 =?us-ascii?Q?oqpjaFOCiZAmUFlPurDk3fjWTl+b05uLc4hyYTfTscoMY5oFKoHo94dLHgHf?=
 =?us-ascii?Q?+fCGSFCfzpcpnu2KE0c40tOu2Ji2ubEPP19k+AXA1+RmO5kSmQ9mfLsg+dso?=
 =?us-ascii?Q?m3iU/LidjRGjsCbXaFWKvM7aoaJ91fPDp93/uO0kh7jRqJFpsJtx0CbDwLiy?=
 =?us-ascii?Q?56XfTXakPbv5eW7QypPwreannt+O65OTkBxGdamwBhAke/T2IXmi4BOpn15d?=
 =?us-ascii?Q?qJQkORT9/D9hcKkdetlg9YDYzAE1UgymeRlpaAuGwPG5hh0D1FUpqOCUqszU?=
 =?us-ascii?Q?0rQUIVJmy3QAwPVlvsMuxuebsEnkbWEgJ1Vi5+e1BcF7CZWdAKhDQviaZudf?=
 =?us-ascii?Q?PrPwCPVSl5M5ec2sN6RkMPwI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d9af88-caa6-4feb-3004-08d93c7594c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2021 09:49:55.3509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: im+/WpnSvpKplzCQPCADIb0JV9j73OtmuAbB6iKivZRDthocMbuTKqpKFsAan7yV1Z28y1mFxphdtrjmuTcoGZK+yJ7leXPJvmFO6O1DFEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7239
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 01/07/2021 11:37, David Sterba wrote:=0A=
> On Thu, Jul 01, 2021 at 05:13:37PM +0900, Johannes Thumshirn wrote:=0A=
>> Now that the device-mapper code can fully emulate zone append there's  n=
o=0A=
>> need for this check anymore.=0A=
> =0A=
> Which commit implements that? I did a quick search for 'append' in the=0A=
> recent git history there and found nothing.=0A=
=0A=
The series is on it's way to Linus:=0A=
https://lore.kernel.org/linux-block/YNyparaGoPleiSxX@redhat.com=0A=
=0A=
I'll resend the patch once it hits Linus' tree and has a stable commit id.=
=0A=
=0A=
>>=0A=
>> This reverts commit 1d68128c107a0b8c0c9125cb05d4771ddc438369.=0A=
> =0A=
> Please do commit references as 1d68128c107a ("btrfs: zoned: fail mount if=
 the=0A=
> device does not support zone append") .=0A=
> =0A=
=0A=
=0A=
Will do.=0A=
