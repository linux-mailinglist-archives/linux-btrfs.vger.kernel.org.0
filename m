Return-Path: <linux-btrfs+bounces-1596-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE173836335
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 13:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7F2EB292FD
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 12:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9D33D38C;
	Mon, 22 Jan 2024 12:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Xm/eauRu";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mTpFXIfp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EDA3BB21;
	Mon, 22 Jan 2024 12:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705926146; cv=fail; b=oxhgJkVZuzpv/uGphPu6MvalHddJRqak4H7emcrcNTSHHFrRWVCASHY2e/dBOaty8bePR+BzjvOZ8dzAD+ZtBUWXEz8RRnpw5pmhknKM1hpBL7SoagiTTg8aKetam2xDiEpoKV4SfwhZhApbrzUJX3Zj99fZtn6J3stxw6DgW4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705926146; c=relaxed/simple;
	bh=wPnqdBr67U2N53wZMATMhe91oEs5cC+6BOI+RYxUs8M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y1HbI2D65cl8+OoK6xsa5ox8SdmLfIIP0+wneyYREqNQh++nY8OUGOJnTADEJAoSln7XbDTWKXz+kwZugmI/hcz+WD3N9oUL+F67FP3bCySFU/DuWvnoFRICb3Al71LAPzDm7p03ZcAZZoc3cNSqZVIUUk62N5TNHiBC4Bp3/aA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Xm/eauRu; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=mTpFXIfp; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1705926144; x=1737462144;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wPnqdBr67U2N53wZMATMhe91oEs5cC+6BOI+RYxUs8M=;
  b=Xm/eauRuRUIfsWTx0Q8DTUn3WKMljZt2ViNfjz+4SDVaKoW3RuLSyJSU
   Vj7bQdVsSrJ6PWe0UQHL3QC6qsZ/F1XFEvwIYRw5uRF+XqasTE/J1z5Ig
   0EF94/OfNtf5x+nbbsfzDEY383LtlWdPusL4hZfXi7zD/1S54IeeLsS7k
   IzEfBcuG1SuhrTP0htgM9fCymBnRjUWc1RHqfEV8dNJ5PUtCpTBwlsZGe
   YlD8tl5jRtmuJ1RHIhHO8Bd+yRUhqgHKbXb2FtKhdsPc+rT0oDk2uayKS
   qZ6ltUJRGB37EuiCzUfZf+JRAIPtgBFxIyrt4GahadjvkD8UtbFUPrUww
   A==;
X-CSE-ConnectionGUID: tC1DuW9bRaWQuFCnGXqgqQ==
X-CSE-MsgGUID: 85nC8ZdsR7eKl8ppntVmOQ==
X-IronPort-AV: E=Sophos;i="6.05,211,1701100800"; 
   d="scan'208";a="7657950"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2024 20:22:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtjfOl4Fj23eAr/gqxJGd48SyhIOpXGO3ir861+r42UVJ0anvzX91pw2komqtpctzEAN1vREm2GtvN3t8Bqa2BIwSyqnJGNxJ8S8eeMgvvGRJviet4vpJxYNNUf+OsJJxLgBvAH5J5kM9fgns/lvflX+miLT/yuvDJAHq4JfpgcgxzryrIs9l99QAkkhMeLGqk88trtKwJp0PQpaeDFq9w4SFucTh96yx9UmFl5KdtiSAQa11rmLrf9TH28UFVMI8msCyrgik+Ch5Sq+chZVVy81ap87WaAv47dofN+BYA6bm9LlENP2b/JqfqQps+j6FJt06vFUpul8GeoF4vDxHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Dnjr0sE2pJva0zmWt+LD0iHRtDJUyfu/WvEiudrvik=;
 b=euyLwFr2oZiEdmN7UwYa3krs1npqq3i8RVd2hqeUOGLeefqYzxVHE99zwYzbvnCndc81nA6r5NkBJBq6yVNdP1VREBy+3h2Hp+NH8cUoWklAwk/KsyZl53ayj/uNVooRck/RolFjywT+vOZl+xOANMnXDJduXSOd6IagE05Nw/y51QIvo6WlwqFdvTEVlxgtvPoP3CZzx8t9dgwaUMdM/CziLXAAD3YmdAaeoPIpLzzbPOccjVmBGuCYo0hhAAIcSKvjA8HCALR/6a2p3NnsrA4vPFXSH03wtHu6Oe0ugfVBXqK3BJKaPXuqK8i7nfTiSeaixwYBgmJRILyCEoZTfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Dnjr0sE2pJva0zmWt+LD0iHRtDJUyfu/WvEiudrvik=;
 b=mTpFXIfpAner98CJBohkaCnxHIaIX54N9xGCSlWgiEfuEwPeu6Lq0Xv3s9Lnlh+1TGygYJCOIqrOR10PPJhVG3SsKVIXltm4oYWM0m8rrhA6tvG5p81Y31ZkINsPevipj37WEDvrraqDoRpdG4hCA7zzprQTWMYEiDHYsCo8soU=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SA3PR04MB8929.namprd04.prod.outlook.com (2603:10b6:806:382::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 12:22:20 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::6c12:a7ce:2b9c:69bf]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::6c12:a7ce:2b9c:69bf%6]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 12:22:20 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Damien Le Moal
	<dlemoal@kernel.org>
Subject: Re: [PATCH 2/2] btrfs: zoned: wake up cleaner sooner if needed
Thread-Topic: [PATCH 2/2] btrfs: zoned: wake up cleaner sooner if needed
Thread-Index: AQHaTSDvOd+kWBN8wkSOr2ka96SkX7DlwQgA
Date: Mon, 22 Jan 2024 12:22:20 +0000
Message-ID: <x6bi4u2u65q37tde3s357lzhce4wglpobfgp7qgzhun4iadg3m@2pewiu6xuts4>
References: <20240122-reclaim-fix-v1-0-761234a6d005@wdc.com>
 <20240122-reclaim-fix-v1-2-761234a6d005@wdc.com>
In-Reply-To: <20240122-reclaim-fix-v1-2-761234a6d005@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SA3PR04MB8929:EE_
x-ms-office365-filtering-correlation-id: 0da9fa64-57d7-4ac2-6a00-08dc1b44c806
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 m1V8ZjrJeNRYnOLZDp6QPZtn5N2GpqkIf44fXjj4fF7bEewlPVSwskKnP+4MFivWNZqkXHkQrhiuhUOqGhtPKvNpmSeyX24rYMDmkDL6ri+b4owPs9hcI1vaUZxPfFph2hwdeEwz/z7R18wvjRMzbqeUAkOsTVDkA3FEpQMs7y7/PN73urWIAe4lXLauKobWsN2/FJrRZ9+MWopGCEBrXvguecSdDg08FARxhsuuhVkPtVlgp6tsMUkVNM9Q5RfvGz/Pqfn/f1NBLtuW9G3iopnmLtNnq/TvF71nr5PBr1B88pDsrK5JeLWm2+j4uF7vdvNSnNmDRC1aAC0YhO3nGavLIKFl9tVeLZA+cSsNHhw6T74qeYLahJtL+C2udf/HjWIwfI8pbl8QHiTI3eifZAcL4XcepID/rm4xEGVvtqW85aB0ILuaV/guilfbsVo0Noxge9ATGScTjI0JXWZS3Fw1IfAfwtUjxnx54oKgNaM1ByRIPSKsZIqxM+xLbzV7JBVacQlXXT/swzX7t68oVLb6TvUOBIsYSEBM+lQFpLTT4fcoin2/ZE84a79jDQ+vTtDWzxss3TktgPvKNGEwkGyo01fRDfWH6/ixhV9AoRfQK/hFJArtMWwP2kmGZLI6
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(346002)(136003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66556008)(66476007)(66446008)(316002)(6636002)(66946007)(71200400001)(64756008)(76116006)(54906003)(9686003)(6486002)(6512007)(6506007)(2906002)(5660300002)(8936002)(8676002)(26005)(83380400001)(91956017)(122000001)(4326008)(6862004)(38100700002)(478600001)(38070700009)(33716001)(86362001)(41300700001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KxHE0a3NSV29MHt2LZXFQHMTIbWmFEv8jRtvwCcGjMBpz6lQoaW/Bxt/cFxb?=
 =?us-ascii?Q?1XNO+xkRmBDJruB3sRnHynRo0Lcj3T7ooaLVCqXDMi1zoCfhs2WwwY7yjKtn?=
 =?us-ascii?Q?EIhRQusZSpqDMkvvVPhxpTYlxmwwXxYyTQA6Foopso4fy+6frRMsESlLJgFw?=
 =?us-ascii?Q?BiiYohrTk3o/rStsvFiyzVRoB6tJ1QyX/jW1DuMe3jnnGMec8ZiXqoDvWGmI?=
 =?us-ascii?Q?+oslqpzuupl6HglvRyXN4jzyC36aJKt0D2T1L5YahRC54AJnKE4+2OuBdTDA?=
 =?us-ascii?Q?PS4yvhmtRCfs7me6TmrBiPLhYjvHpolkSB5LnoJ6bJHDmJV7fEHhNPIHyVDB?=
 =?us-ascii?Q?PIp7M9rsNGWiUQbmI2qh1TdNEiZDUtAKI0YttkvzE4s2AmU9wisykxBgh23S?=
 =?us-ascii?Q?I3ZwPYtsFXyJBP2PJuqgebbTV0z4GhdSerfmNwlQ218K+FWY3V+KyXNvEWtz?=
 =?us-ascii?Q?okb1nx/kv0a/D8Zjsvf6KSPI0Lui4aP8FCW/yApHvUHUR5udNgauYELH3v2t?=
 =?us-ascii?Q?Xqlv3t4Fiabp4G5AUBkelaJ6iHT6FGvedOkhbmWfpFo+vzpDXCS6F/08NFPs?=
 =?us-ascii?Q?OuoGMCmYg+rq9WRRIycFgRbdnyRCeEVjRSLjVvc67uRKUWBGDfsPRNStiZCK?=
 =?us-ascii?Q?5S+pNcACQR2J627JGGWFyof+elTNW0k6X25An9ucEWzJ6ojeoXdNFUh0XIWh?=
 =?us-ascii?Q?H6aWv+jvyBQXOzc7yXLBxCMqVhyAeurberXb6n7Zd2257vMK7/vASmzxEFY7?=
 =?us-ascii?Q?8keql0abnM6RzLvuP9uNeeVSIjyvRk+pcIwwOfg+lgnI6i6jHMvgh5LPiUzN?=
 =?us-ascii?Q?dir5B18hvXZNMVeCisS/ryLP5ecpbzjjTzG9MSYiF2wxKziK3DA/qTGuC+ep?=
 =?us-ascii?Q?wuJjNjRzIXp7wJ3v24JSVbxbLfXJp0XLRS8E+u9hbH7MFqCDLxWmUORFtaoG?=
 =?us-ascii?Q?QXKg3c0RoAtmoN+DhRXazpufGzEczhCB6PEj188VvHBfW/FRgZJaP+E4MjYY?=
 =?us-ascii?Q?cJoPMyabcHwxnF6PomGjXKobEHrxZBUesHOZft4/PHNkPgOWGXzRHCC677FL?=
 =?us-ascii?Q?6DAl4RJgpl2aJtj5OWzlnRUXt8ba7nv/Wj4nRF0A/f1R6654pvRxCLieLovv?=
 =?us-ascii?Q?4dUavoGoIww63dNzesLC9GeAyQZ71L5ekzW/cKnJpRnLUkX+HN313lVdHZLV?=
 =?us-ascii?Q?TRMAkg1EbJmlA+kdmfFQWE3uHeOyHCz69ITzeJOj31Q311sdzne2QJwvjvXw?=
 =?us-ascii?Q?4UyHZ4os/35xSXLIvHtv0VafzzrCv40eTojNnwcU9WNWmKe3lXugX3c55EoT?=
 =?us-ascii?Q?9PcB4pbQJlQetjXzK/3IXob9lY0VWKghIzmn7ipH0K0VPueXXetAJ1TYHFWK?=
 =?us-ascii?Q?PjQqtO/0/hOJk5yomNINEB6VEB5AeIaq5oRRNvwsve30qoQ0eYFnEgysYF6Q?=
 =?us-ascii?Q?x01x3e2+2SZ5EfPGTxvT2v7mv641UsO6qcc5scPvh+99O3vt4kJbba6mDiSs?=
 =?us-ascii?Q?cFWufF7E9FR90uWDDgZWWk9BCmoYkUKlOVabmb2DIVahvwBwzb4f+F9+wTnd?=
 =?us-ascii?Q?LKb4KncpOAzqqP/j2G9ZisnXmv53xRvW7BRbbbZ4RInrg8YPv1TlSa1kN2sA?=
 =?us-ascii?Q?ig=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5D0E8357D88FAA42B0F5E56EEA5C6F27@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	t6MvfmXrLZn5MoiFK/4JHcZXa4i/k93PCTzmqyEdddPx+9o20kaIEWUKcCsU5f2jiLef3urPIFhe3VQVlhK7h/RSVFjZqGWQpm/QZO8kJ35WvCE3zmJMFhc53Z/WC3vzNYA7krzLDJUaahTZNIx5nmiIfhTjp3GuACUTILh3zeB79qKSUGn0LUAwXpMb4R2dh/r9t2FRLaVgirDAh2e74iKoFDGJmo5ari3E/WZV3ix/w+MftfJiU3zvxCq/6iuuMOrCbblOYten+zSpCqTf2H1PIpfp2aCwxcn1HbtlLJyt+Mf4gKh2oPer6KrfyNbiTmI/2URz5SDTaYyhUnT2HQ2ymYoAm4/QW8NfSx8NxyDLZMuu3Xbk+dMCfh2jNYD4NZLGSh/10w13c7QX99eFRTnmY9hduZ6evYG4ZvbAkdFUyl1uuzBbi+Urpvo7Fq9ywLiVUlDBnkFBUL/seQNJDVlLBQp2v737dGIfPGWrzl28oF6rAP5BkbTjMWOGoj6KF0uZajxwwWi+hsByVfYzEEioT8wMTmJxic0g+VJn92I0ubKXdLStK6htO684Fr3g6aAiaVOOhhXdX+DoP1FXRtaDAVYGRBK5ks1miMY17vdwaTTOy8Rw5MpIRo5tc83d
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da9fa64-57d7-4ac2-6a00-08dc1b44c806
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 12:22:20.6781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mfyufsv2u4wIjmzDpsq4YMauy/n8JlNX6FMniKiTuMxU0/0ygpZ5lg4TBaUfji0Bcz4q8TTGIBBE8b7K/gY7Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8929

On Mon, Jan 22, 2024 at 02:51:04AM -0800, Johannes Thumshirn wrote:
> On very fast but small devices, waiting for a transaction commit can be
> too long of a wait in order to wake up the cleaner kthread to remove unus=
ed
> and reclaimable block-groups.
>=20
> Check every time we're adding back free space to a block group, if we nee=
d
> to activate the cleaner kthread.
>=20
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/free-space-cache.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index d372c7ce0e6b..2d98b9ca0e83 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -30,6 +30,7 @@
>  #include "file-item.h"
>  #include "file.h"
>  #include "super.h"
> +#include "zoned.h"
> =20
>  #define BITS_PER_BITMAP		(PAGE_SIZE * 8UL)
>  #define MAX_CACHE_BYTES_PER_GIG	SZ_64K
> @@ -2694,6 +2695,7 @@ int __btrfs_add_free_space(struct btrfs_block_group=
 *block_group,
>  static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_=
group,
>  					u64 bytenr, u64 size, bool used)
>  {
> +	struct btrfs_fs_info *fs_info =3D block_group->fs_info;
>  	struct btrfs_space_info *sinfo =3D block_group->space_info;
>  	struct btrfs_free_space_ctl *ctl =3D block_group->free_space_ctl;
>  	u64 offset =3D bytenr - block_group->start;
> @@ -2745,6 +2747,10 @@ static int __btrfs_add_free_space_zoned(struct btr=
fs_block_group *block_group,
>  		btrfs_mark_bg_to_reclaim(block_group);
>  	}
> =20
> +	if (btrfs_zoned_should_reclaim(fs_info) &&
> +	    !test_bit(BTRFS_FS_CLEANER_RUNNING, &fs_info->flags))
> +		wake_up_process(fs_info->cleaner_kthread);
> +

Isn't it too costly to call btrfs_zoned_should_reclaim() every time
something updated? Can we wake up it in btrfs_mark_bg_to_reclaim and
btrfs_mark_bg_unused ?

Also, looking into btrfs_zoned_should_reclaim(), it sums device->bytes_used
for each fs_devices->devices. And, device->bytes_used is set at
create_chunk() or at btrfs_remove_chunk(). Isn't it feasible to do the
calculation only there?

>  	return 0;
>  }
> =20
>=20
> --=20
> 2.43.0
> =

