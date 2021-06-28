Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A95C73B5872
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 06:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhF1Eqb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 00:46:31 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:43036 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhF1Eq3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 00:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624855445; x=1656391445;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ku/fXwxj0L95pa1Wi03NxYDPzqlKeVwU5H46S0pKtLs=;
  b=cE94amFwyIqfbGTucYSfm3yh5z5hiDRpGxVsqIKUaIW30UHdRH2dJZtJ
   ByZKkLEq1BrDKwaSxRsaCwu/6v3ObxNBTS5uSmCocHQ9qMg8rrDXuvt+p
   hUnrEZDkcCG0FBjFZrpXA+oAmAAU3DxJzL3d2MeemskDtS4eYitEFFMa8
   yybQpp3NMs7ay87Duy6H/5xmTzJtrgqmR9Cx1CaVpyrcajcIuNAwgmXlz
   N/uRgE04Lc1k8u84UrdqT4R78j772nZGGuCqXMZTfhQExST4pYCq9tGJx
   WhKDSp9GtSXxj5BABomgyBPjHZvbLOKo3B8MKDsRFgFmh+nsijghJIn/5
   w==;
IronPort-SDR: tTyW8JmZNPfbUD6SUZ2tAmk0+bgBUDG9wPXmv+2kcm2q2zsTNZE3cpxzZwEIyzKvJ9Hy2kfV2z
 TRRIN1c2shMSrLLwHNIxR20mC9QudJeBtodTKBm+Tkqx0ctQpDD0RBBCexk4Wk74FRwkUrjEnI
 PsZcLdL48nEkcUwgYHKbOf8sRJrYJGj3i4F6HXp8U8FStxnRu+0dzBpNZ7CyNmtjUX73l28UpR
 OoZv2rf6qUM6VOBn20GC/MtJEWsX246kAuEJFRdWJaVkuXZsT34dQWc4jjcx//TOVkngDfHp5l
 AaQ=
X-IronPort-AV: E=Sophos;i="5.83,305,1616428800"; 
   d="scan'208";a="276850140"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2021 12:44:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uw2mALizjByN89ZtKKMRnAHV6rokclu+FZy//n6IverFij/xXIlcqVgOwVTA6Ebdn1v0wIAQI27gbrWaPWG7YpAgGUp3kMVEX6c/HWBVjB3SaZUsIss78VyJeCiH2hNEafWL6/WJGIaMEO2c3HIeEJw0oQIf1bPDNPdgBIzmWHu2w38WgsZwRa1EfO9C85cRpweXSCYwNW33Pn1pUHJiXAYAWiiYTgtQg9s61/8/1Tg2QPzrcR9U25K7DpJdyOJLieeVYPnk43qduT8N/S0EmQ5xA9umMCV9eSxDMiuz7uLAqi9nrt4RonNBq/Wp//hI9WbDnAklrpAGTmpNGtMOSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoggfUpKZYGnTnVPNOPFBjqt4pLyWmDGySMlpMdjaw8=;
 b=EcTJ/nGRjH8+n2OctL3WM2fSEItdfu5kHiBmjOYzK1GqmxA0qGP2cw4DRSgpIAj962ljemyXch1NXzlA7uc7gy/Z5jgnxJ/gO08lXitUPltcpi+aTdOSGPwdkx76jYgJzTd241klV5kXkLlmFv5/JDTiOMorTUPq+F8u/KE0LbsI7KJkSmcHyfpDn//zL1GXKTPpf3/IuHgtGta/kgkoz3pFg2bxRWagI+8CNouy33xNO7sg13zOogLv9RG8KZtcYVp3kgIW7W3dxIl1AAzSstjjn+lP4XDJummXL+Hbh6vtOdyhtIuSznqQjgi2KbK+DduBGjt4ciNqbeBGo8LMXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoggfUpKZYGnTnVPNOPFBjqt4pLyWmDGySMlpMdjaw8=;
 b=x+0ppDJ6D8vQcGv8XAOIrzAWryYpYJxuvbDzEt+FeApMVk+AcPql8ZipvXu1WrbQnaOBOzLeyHof/bal5NFlAtSOcPap0sFaZQcktmocXndbqgfdcEsVTG65TJ3J2+gNJttp3Wf7hEgiMWhaClU7TNGDbXn2/w1z4XdJImrOum4=
Received: from BN6PR04MB0707.namprd04.prod.outlook.com (2603:10b6:404:d2::15)
 by BN7PR04MB3841.namprd04.prod.outlook.com (2603:10b6:406:cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Mon, 28 Jun
 2021 04:44:00 +0000
Received: from BN6PR04MB0707.namprd04.prod.outlook.com
 ([fe80::2dd7:4b71:80b1:9a71]) by BN6PR04MB0707.namprd04.prod.outlook.com
 ([fe80::2dd7:4b71:80b1:9a71%3]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 04:44:00 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Sidong Yang <realwakka@gmail.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: zoned: fix memory leak in btrfs_sb_io()
Thread-Topic: [PATCH] btrfs-progs: zoned: fix memory leak in btrfs_sb_io()
Thread-Index: AQHXapyB+t0UIKJWrEiLUKU7X3iQ9aso2zKA
Date:   Mon, 28 Jun 2021 04:44:00 +0000
Message-ID: <20210628044359.wuhbmthp6metdixg@naota-xeon>
References: <20210626150344.25860-1-realwakka@gmail.com>
In-Reply-To: <20210626150344.25860-1-realwakka@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [164.70.191.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7dff7e9b-bfe9-4235-64e7-08d939ef593a
x-ms-traffictypediagnostic: BN7PR04MB3841:
x-microsoft-antispam-prvs: <BN7PR04MB384199503F47E188DAC8BEBC8C039@BN7PR04MB3841.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +f2dNdYI4uGXdBbvlbCyT/CQBdvEtg5v/aEDeqxaACPvh+oyART/0kI1oFJPCi+cPXXd6G2r8i3r3TdV3+CQx5JucjElrxc2UB0+KDRM3hYQIG2okQVx3aQtTBs9KctiaUlyWsrwAEam6P9Y0HZMSxr2NpR+R6mBQ+JlFLI+qxhx4UOqD85fF455RkaA8FdjVcFn/295EBP2g9tkeo/65l73eqfCLyRjze2HSBPCPerPCNwLVSM42U882lXaONNZDo3nMZAv9zCVca/YWzb6kiXEOmTN40THNeuoo7ECA6/S5+CCguOPBW5QRtifpYzr3pXazmFLm9Ece+kiNhAWK6wevfOeFUq9/B+i9anZU+WnZu3DEbH3EmlXdEAo0l0QhsLSjccXVguIx8qQ9qsB0LHLkZLP3DstsiIgXqG79KjAEXZcfMPFo81gOmyU1k0QmxNaiH/ftzV0pJzZN5JM7O7KCAebjrLvc+Ecda77p4eb2Ng2njculvLR+QSC6hwu1ZgWgENvFXKHC0qJZQkQaUlalRbwuTwoOj1trH8msNX/dCtM7EIk6w1FUuwwRTJBLjUH1po2CJ9+EHcBynEPEvTzU9CVtJ1Ltja+snHeknRwoMVR0xetP3gih7LbJV1HFAIBgQm9bnT5c5xaervXYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0707.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(396003)(39860400002)(346002)(376002)(366004)(136003)(26005)(316002)(1076003)(4744005)(186003)(76116006)(4326008)(91956017)(66476007)(66946007)(2906002)(6506007)(5660300002)(66446008)(64756008)(66556008)(83380400001)(8936002)(86362001)(122000001)(6916009)(71200400001)(33716001)(8676002)(9686003)(6512007)(478600001)(38100700002)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o65EA3jp4g7j2OaUz6VDOzgfF40pL67mhmhw+kHFT5pL2OcEtCfENwhda812?=
 =?us-ascii?Q?+Y+8FxsEHbeugpq+G9mansP+AT5J2Wzf7CFUqYB+Ss9zpdVJXqfcSbld7D8l?=
 =?us-ascii?Q?QeQJR3Ow0Uu6+c53JIql6yPpqPdk9bqwk3NCV3swPZNGuJtZvXKiNtn3dIap?=
 =?us-ascii?Q?3PyXNW/k0ShWg8oOGi0SVgXW/FqA0Nii+DIgEenSMIxftsNkUXj5a+01/GGC?=
 =?us-ascii?Q?gOdiGwD6RjiFSqTZHLrUSpX1FCpjVMw+pAVDGlG++yBgi3JsNHRlSmHE8ams?=
 =?us-ascii?Q?eD8q/jNXLvG591b77GzFN38s1CKl+xxGgMaKDN9acaEEOUOkFKySoMDU9ni9?=
 =?us-ascii?Q?ESDDboJObHkfrcZv5k4J+f6G9vusAFjbTUgZdX0zar8JsLy77PavsK8tsiP/?=
 =?us-ascii?Q?MAEaUVdoNH6kbclxHTyoGszlRX6gjks7wPs0V3dyS3YMZy8bj0kmAewg4PWQ?=
 =?us-ascii?Q?Ma+exjcD9mUSxhtVVRZ5noVKlz9KyXaZAr8rC0wdrK1Enpg/fRl0oYD0TVlv?=
 =?us-ascii?Q?Fzr0xS5EZJXt1vC3J5TX3WyW8nM8zdXYdEi2KwmvumZve9TksbgkFuCGC9df?=
 =?us-ascii?Q?LmfaXlJ5Y25S9J8TzpFhi9v0LJMQYdwZrTTSX9+BUZtQZtipVwvjtW2Vh6d7?=
 =?us-ascii?Q?/w3Ro+BD/p7bKerBgjOJX6o+he4uqEET1mOtucB3qTEBg5PFHDJQQXfg8xBB?=
 =?us-ascii?Q?2vLuuV6ilio7qQraWT0HWrFSNA2pMcUd3xjSVHtjjk2cjpqXO9XYoDNGRpjn?=
 =?us-ascii?Q?3otLzEKky8kNeT0+9E1SDjSCwt64fYr8pKH92tzSyF8k5qCG8CJ+kzzfWUe+?=
 =?us-ascii?Q?7NYxHhKFgrjLdXXUa5rLbXjLI0onWnXGYXFRNvKmv86BljT2vugr2bknwPmc?=
 =?us-ascii?Q?TbvHnrwbehNYiu1DUinjQLb7xmMqcJDy5AL1Ec3j3OUc2lIUQ7bjexwHxAQi?=
 =?us-ascii?Q?tnvdsHKAbKoEl5GRe7e2Pl6zGo38VjasL/3eciZt//zxspSoqgH+KaSRViP1?=
 =?us-ascii?Q?MDbvYj+x8RwcuNHF2arTtHCc0YL1wC+O6sPJZ7+juV2RY+/4/Xe9cK5hPoiV?=
 =?us-ascii?Q?876nSHoLrD0pMuZoCWtMDK2/sJycAAO15PHCLjNwdMRAnzmDhtZ8J1OS0u/C?=
 =?us-ascii?Q?mYn1qjDjw+VrrHpyBVGpOG7unPSzZsR8XMW0wI3d4uW4MZyK+j6zAmMLeKYV?=
 =?us-ascii?Q?8Cy/63NQfvqkMbtpYKU7W1pgeoE8r3HIQsl3pd028vYu0Jdn/IQpqYbOh3aT?=
 =?us-ascii?Q?Zqar1N7wl2wZHSdgrhyXREXrWz5t4/zRdk27kCd13LFeF6kXk/ueB8DprDFG?=
 =?us-ascii?Q?DSIrUJhHDgh9f30QYlqMhmpD?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <042AD4397556534A9A8C313710E0CC54@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR04MB0707.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dff7e9b-bfe9-4235-64e7-08d939ef593a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 04:44:00.5742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /y2rvVO0loN0YpZ1SZIxgpOMK+eypKE4hR1vMNZqm/9t63x3MQF+6bh282MyuceYuy3L8JTRsEtis0BKUpSEpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB3841
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jun 26, 2021 at 03:03:44PM +0000, Sidong Yang wrote:
> In btrfs_sb_io(), blk_zone_report is used for getting information about
> zones. But it is not freed if code goes in usual path. This patch frees
> the variable just after it used.
>=20
> Signed-off-by: Sidong Yang <realwakka@gmail.com>

Thanks for catching this. Looks good.

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>

> ---
>  kernel-shared/zoned.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
> index 2a6892b3..75eade84 100644
> --- a/kernel-shared/zoned.c
> +++ b/kernel-shared/zoned.c
> @@ -543,6 +543,7 @@ size_t btrfs_sb_io(int fd, void *buf, off_t offset, i=
nt rw)
>  	zones =3D (struct blk_zone *)(rep + 1);
> =20
>  	ret =3D sb_log_location(fd, zones, rw, &mapped);
> +	free(rep);=09
>  	/*
>  	 * Special case: no superblock found in the zones. This case happens
>  	 * when initializing a file-system.
> --=20
> 2.25.1
> =
