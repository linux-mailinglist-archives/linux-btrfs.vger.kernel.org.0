Return-Path: <linux-btrfs+bounces-8312-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D583E988EF6
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Sep 2024 12:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4B081C20E16
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Sep 2024 10:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FD718E05D;
	Sat, 28 Sep 2024 10:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oakvillepondscapes.onmicrosoft.com header.i=@oakvillepondscapes.onmicrosoft.com header.b="M8N5Q277"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazon11020084.outbound.protection.outlook.com [52.101.152.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5D014D2B1
	for <linux-btrfs@vger.kernel.org>; Sat, 28 Sep 2024 10:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.152.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727518541; cv=fail; b=P2rvGK74Pq3e1IBc4LwN86dkeWycFCHEEQuDzDzSS2ZvDvQxCM+9exOwtgR0tbwM/KpKcmdK8LxYhhfQVmPJb3XVyi4hpT7pH5ZXAw9441jPDLp37DzUbm1riU9mvaEmaveTnHtDdzS+eGMoPXPnSq4LZ5MOTLNrDRjADV0oKMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727518541; c=relaxed/simple;
	bh=fMvLKD8CtJuYq2/idkJDd1qsp3N+aOENs3QTmbn3t50=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P/nsodYsKfunt9/xtDTAoLCRM7VIrc5xCmvJZS77UTLPqWp69QoaEUFJPXgQOx1OkYh2qpwMMFHCSkFgtZ8PVhjUM8xFRone6SDxMpdxeL1RLoGrFlFniNCvMCW73y6yHb7tb5bEnnSPrzunqlFIZTtPl+IZRBAD7754wF0ilOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pauljones.id.au; spf=pass smtp.mailfrom=pauljones.id.au; dkim=pass (1024-bit key) header.d=oakvillepondscapes.onmicrosoft.com header.i=@oakvillepondscapes.onmicrosoft.com header.b=M8N5Q277; arc=fail smtp.client-ip=52.101.152.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pauljones.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pauljones.id.au
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YR4kiSvDAVjM4FRuTfa7v5QvkxZjxqrDoU5crqa1MAn2brIVS4SKxPwQ67054VBjB1uR2pjtQa4QsIQL7iHqgr4aAEAOpLb3oRg+GKJDaDdvXjw9wW7URPhDntlbV59FS9sf6bkE4ewpIppDv1qy4yI+ahzRyT+JF4Xqo1cCsZNOYX2IOhC4hsAvKrOimdhbUT4y20E9ydpH0G50H4zighrW9nw52TCceRejSEqOoPhnsTz9XAIV0Wyqw50mi39N4Trp90oOtceP4yuAu1w9pLaT8bHAiz6DUqvHY+X81pTFwYeY6A5nW3DECSyltJ/0kkLU4Yv6+Xr0sEyTmllcjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMvLKD8CtJuYq2/idkJDd1qsp3N+aOENs3QTmbn3t50=;
 b=Fx1KeXvPX4i+ouAx8s7PIyo2bbKeAIp/aeiu+EXml6POKbOHFuWueb/FxOKDGIPPn/cLpsLoTagObqHfWDD6g0Buy+/tnxxD6hG9INSBT8M53jVeLuu6bT/5k+8Jr7qf7LfgrSreA702mYgOf02JmS5JhXGJ7Xa40soaCY00/O4pDx8T1WhLq7hx9VnZgWzKhVo6P5tOsqkm0GYcxlRX3QFLEQ3xwi5p2X0fXDkNhcf1AoteQrV/bDV3RjEEEXS832Asz3BXKsLXRXK4pntwk4X2qKrO57FDWxD5fyuVQiIfNRF75hoETwy+QCXEE3/QihIp3fvaC7Toku2QhmdwOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pauljones.id.au; dmarc=pass action=none
 header.from=pauljones.id.au; dkim=pass header.d=pauljones.id.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oakvillepondscapes.onmicrosoft.com;
 s=selector2-oakvillepondscapes-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMvLKD8CtJuYq2/idkJDd1qsp3N+aOENs3QTmbn3t50=;
 b=M8N5Q277eTTL0lIw2ZwmC4ywt1ZD85hxuuVbq4KewYEDfMudZmZvZIEl5Xd7MLR1dE59hggu3SDdgQgZx09w0yseUwNfrFMQY8ciRCJghZgFc9sKK0MBWdSmqdmBFvjMNqszg/BEoXT4kzAQeJRbsZ5oLNv+z5WFiyEYbcOXBfc=
Received: from SYCPR01MB4685.ausprd01.prod.outlook.com (2603:10c6:10:4a::22)
 by SY7PR01MB8865.ausprd01.prod.outlook.com (2603:10c6:10:215::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.11; Sat, 28 Sep
 2024 10:15:32 +0000
Received: from SYCPR01MB4685.ausprd01.prod.outlook.com
 ([fe80::edae:79ac:1adf:31dc]) by SYCPR01MB4685.ausprd01.prod.outlook.com
 ([fe80::edae:79ac:1adf:31dc%6]) with mapi id 15.20.8026.009; Sat, 28 Sep 2024
 10:15:32 +0000
From: Paul Jones <paul@pauljones.id.au>
To: Roman Mamedov <rm@romanrm.net>, waxhead <waxhead@dirtcellar.net>
CC: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: RE: BTRFS list of grievances
Thread-Topic: BTRFS list of grievances
Thread-Index: AQHbEPpFSwT/L/LquEeAeXD1as/u+rJs+f5w
Date: Sat, 28 Sep 2024 10:15:32 +0000
Message-ID:
 <SYCPR01MB46852423226644914D496AC49E742@SYCPR01MB4685.ausprd01.prod.outlook.com>
References: <aebe9671-6f44-9d20-f077-b19e09fa1fcd@dirtcellar.net>
 <20240927212755.5b24ecd4@nvm>
In-Reply-To: <20240927212755.5b24ecd4@nvm>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pauljones.id.au;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYCPR01MB4685:EE_|SY7PR01MB8865:EE_
x-ms-office365-filtering-correlation-id: 0a96c84a-f700-4fa8-24e4-08dcdfa67c58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UFPpqvod3hpOs/1XWcrXNI8lAjCUS5STsNh6K8NuP871T1tjw4O9UbXvcgbl?=
 =?us-ascii?Q?GLwn6OeDiNWbCZT5tThIYv2DAQMWlKbWdEm5nGCk814+wR4CIvwu8n75q8cf?=
 =?us-ascii?Q?+XV1ZcinmAx1N9Y/n8h+pgHjl7kjfGFXI4whbMRLEfWNfLJP+QwmRYYNGyOG?=
 =?us-ascii?Q?l2MIyq5Y8d14ffS8zeFLaNmELjmhvJUknGr7ovqgwgGf3vEk/78c48RUo9Ig?=
 =?us-ascii?Q?XomGopPWgN8IezxQglA/N7D/1EqA8SguCRFV2HozJA+9a7SrO9HuYLIiH59F?=
 =?us-ascii?Q?/0IwTu+9CgmpJW7dfukk/U8d1CdpKp3lrAkz4lBPNqpvkchHpAuO9E805HPd?=
 =?us-ascii?Q?yjApuWbUbVLvE2ROj5JezK4LTAYbUtavlJKCN3kS1z5FVfZmKgv89Asj73wq?=
 =?us-ascii?Q?W0Ri+OuTOewSUQbm1lXtr2qpBk3Z6GcG2vGkB3bxODIli6yBtZrCoTVizEav?=
 =?us-ascii?Q?DePe+gireHDSNleUe6nxnEtFIzKEFDN2pflW6qleBdO8MjZW//sRibMLvpBc?=
 =?us-ascii?Q?1kIWfJv3rT1O9aN/QniNv2ZXu0PvhTuxMxpgD8GCsTkl85uQBsGE19E5nX8v?=
 =?us-ascii?Q?WZ/Z45xg319FsclLG4VZrFXIle9rYt9xQa2Qdpb5LX24unmrmSNK7CxLATYW?=
 =?us-ascii?Q?3WhPgZoWMk6sIHcQJ9BCBFQnH9OXjM3tZvDyeYQh+YW7vj3fBDZjLfA+2isi?=
 =?us-ascii?Q?AM1G/eBn4sW7DefD5fgRyrO2HZBuotU2/pe+i23gD+KANCXm7Y5yLl7hixvD?=
 =?us-ascii?Q?EGCDTKzX6j4sJ2UXhqi3oW2V1ZtrY3PsN3OpX/iUrR0kG2fSzPWKC0sFvE0q?=
 =?us-ascii?Q?r48Z+BiOvsM7HgRTImZkejo0s8owEMnYwsHupsx2Ed1Yo5xddJlFZZeOltL7?=
 =?us-ascii?Q?sj4a7UistasQigv9/hvopkk3C2uNAkzvLintQ3MWguRca83Zpphw96u7ZeWE?=
 =?us-ascii?Q?Bbr1BThbFV2agnWEJ0TXEAX7L5ySPW0BH5iDve/5dE9VBwFMjHwpWAM2+9WD?=
 =?us-ascii?Q?wsaUf/w8zXi0SVurBeRZY6rCzwMCeUlh0bANJVATWjj4zQp8nBzUWPrpzCFZ?=
 =?us-ascii?Q?uhtNNbM/XSFP9MkK4PXPuB1nRTtz6Rfg3cXb66T7nE4WVb/hnS7fSLUjyfBT?=
 =?us-ascii?Q?d9jgpMj3jnr/eY6SYAqo09QBGeTQ6E6BI2NYsa9syarEuNqupRd5Bj5oCKX3?=
 =?us-ascii?Q?DOX5AB50kxjE/8flX4CUoU10ROH0lMUsVDMxcSaf7GPIT7gYkPJpR4+fsv3e?=
 =?us-ascii?Q?5VmJ34gypgxDzPBEs3KqF0GySxa82H8en/LunYI2rgMAtptohNbo8D2Jdy6u?=
 =?us-ascii?Q?q1JM17o+106JSjZc1yG2kTyl?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYCPR01MB4685.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0oi16g/Hl+EN5Y5fe5noDvPQ4ABUq5/i/bpiFewGvjyMxGlng6jrG9MrVUIj?=
 =?us-ascii?Q?TMg1NBQucLnpKCqY7fYKI4iLq/UEf1eqK584oNAl4NjkGqUU9vqKyiOEcp2d?=
 =?us-ascii?Q?euXivFenXYYriNkom0I53SR6vKS1fmkb6ZqoKXvsc3nye7bnA69SJOAc2Tmn?=
 =?us-ascii?Q?KmUPgnwfjcKXf/LNWUkZKkWhJCqQz6sqSZ9ADD0cn90X6Q8cqC+yXqYgeX2E?=
 =?us-ascii?Q?rxZqKAsEQA/ZXite+tH5BOxsxDCc2sOITecASCG0ASYTl6HCNNkyijaZyWA8?=
 =?us-ascii?Q?MGmo9ieunvBg9MpqHvNmiebYTEAEl5/lcnIm8pSFwNJg6BukET1RKw1f/Dya?=
 =?us-ascii?Q?4jWeDWiASSIGSpU3Bt47h6if7Q6D8h3p74ap98K2e8fjQTXO+A0otXexTAi6?=
 =?us-ascii?Q?oAJiepxSyFG7PmaN9jF4W7k2GnUnuMHYjrfp6Stw/OPVjrJBW0dJrURz7vKa?=
 =?us-ascii?Q?+hPzYZ2Vw8N+9olnnJvvBuNb/foDv4x8KG5kW+oXP5fiY94W27jKpOyK34Cb?=
 =?us-ascii?Q?ypFMtbWo5QyQa0Vv5O1bkgbYy/wZkGCAOb7NtlPDEOUiBAjLhurXoJt/GTul?=
 =?us-ascii?Q?NH4Z8+A5BIQwXGl9vWeqs3PPNtWp4myqQD+69Mviu+XBZdZ0zaF/rVznVGwa?=
 =?us-ascii?Q?cC1FlH2oB12I+0jQwYAJtiA9bRnZpn9wL8IklyuGpVReDDy2lp41HiQ+y4Q7?=
 =?us-ascii?Q?9KObOGzhrFASJxWTtttV748Y8fHwgsttvXFGi6RwuaSHMDWw1a39ST88IfPi?=
 =?us-ascii?Q?lvuLZVOvxjUmm3/KLiKEK9v90bvuAzoFpBizQSdluQ3JfGTX5U52jBHQ+x8b?=
 =?us-ascii?Q?ImuG4+UPT0Fu6+XeCLhBc7dbtBumxE0kzzp8Kz8B1Tc+Q37XsILilAcv0GGQ?=
 =?us-ascii?Q?njQiG2G0lYnc4t6uvVbDu5DguC0uwe1yvUE9l54W2/AeCUDjJXkp1tsZ0QWO?=
 =?us-ascii?Q?D7EI5LnR2sv0pkV6bc8Le6OkAYpfHYpMdf/VsVBkyqoKAINgi0TCly+nYWlW?=
 =?us-ascii?Q?4Gctul8PX02ZWuS2l1+6ydNEI5mEJg9iRrJ0pSm9fn5TfSKHHFb+G1Pz7Ulp?=
 =?us-ascii?Q?CSKwuTEl4PDFKYzewEEZlb6w1Do5jl0pA9izOUshuooDq0+gEB6iMGh4PCSV?=
 =?us-ascii?Q?d+S3jVvmA9LcdF/kHO6PhyHm8hytbqSEb+hJCsc2RaLjFvCap79ebPEdsIdk?=
 =?us-ascii?Q?9MkbfK9HOAUqxQJSQn8AaEI1cqDNvLiJFgVggawDYs1Har7hzHQAook9Q3FR?=
 =?us-ascii?Q?tvGKsUvY0raA1Mv2ptgYS4tLMGb1DhhbONdnY75ILLm/FX2K+bajfoRS9x+b?=
 =?us-ascii?Q?2JPXW1KPCVuUfMh21TFfY/P8WEF292jq/MqiEa6I7ltzjy+A1DaZmZmbUNWs?=
 =?us-ascii?Q?QiXJgC6kFbS7sz+ZUIZNLU70L9aUqp1nT+IuxLHhpO6v9+xLAz8aWgVllNYd?=
 =?us-ascii?Q?l+oOD1ngRv3QIemcxvMmWnooVxh3ovhAK3J1addVdTM2l6c9HHA0eqvIVc97?=
 =?us-ascii?Q?Xs0G9PiHsAsios0jDLlf/wh058uYsQz1vPrylzpr9ml5UXU5fox3DKrWma9Q?=
 =?us-ascii?Q?FPxDVIS7M72035bdTIpMiLS15zc/6zAt1lA6h6Tf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: pauljones.id.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYCPR01MB4685.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a96c84a-f700-4fa8-24e4-08dcdfa67c58
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2024 10:15:32.2892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f216723-e13f-4cce-b84c-58d8f16a0082
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PYC4TfX72dLMg2E3bGv+9bUvMsHCCydT3Zljsl4ptwPTyZheMzMEqmK8I1T3AhaxKF5aj0AmBx4v3R334eGIEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7PR01MB8865

> -----Original Message-----
> From: Roman Mamedov <rm@romanrm.net>
> Sent: Saturday, 28 September 2024 2:28 AM
> To: waxhead <waxhead@dirtcellar.net>
> Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
> Subject: Re: BTRFS list of grievances
>=20
> On Fri, 27 Sep 2024 13:20:14 +0200
> waxhead <waxhead@dirtcellar.net> wrote:
>=20
> > 1. FS MANAGEMENT
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BTRFS is rather simple to manage. We can add/remove devices on the
> > fly, balance the filesystem, scrub, defrag, select compression
> > algorithms etc. Some of these things are done as mount options, some
> > as properties and some by issuing a command that process something.
>=20
> I will add my annoyance or rather a showstopper.
>=20
> Consider a RAID1 of two 20TB disks. One disk disconnects and the system
> operates on just the remaining one for a few days.
>=20
> Side note: will Btrfs even agree to operate in such state without constan=
t
> stream of errors to dmesg?
>=20
> Then the disk is reconnected to the system.
>=20
> For a start, are we even able to cleanly forget an abruptly disappeared d=
rive
> in RAID1, and then re-add it back when the same disk it reappears (under =
a
> different /dev/sdX location)? Without remounting and reboot?
>=20
> Secondly, it feels like you'll be extremely lucky not to die a fiery deat=
h of
> "parent transid mismatch errors" right away with Btrfs, after this.
>=20
> Or if not, then how do you get from there to a consistent state? Run a sc=
rub,
> make the system reread the entire 40 TB of data, correcting errors and la=
ck of
> duplication where necessary.
>=20
> Meanwhile, mdadm RAID1: thanks to the Write-intent bitmap, after a re-add
> the RAID resyncs just the small changed areas from the continuously runni=
ng
> disk to the temporarily-absent one, and the array consistency is almost
> instantly restored, in many cases just with a few GBs read and written.
>=20
> Or maybe I underestimate the current Btrfs capabilities here?

I have some experience with this - once the disk is reconnected: unmount, b=
trfs sync, mount. Yes, there will be a firestorm of errors when recent data=
 is accessed (I've had over 100k errors fixed by scrub) but all the data st=
ays intact. You do need to run scrub eventually to be sure all errors have =
been found and eliminated, but btrfs will fix any problems it encounters on=
 the fly so immediate scrub/rebuild is not needed.
It's not the perfect solution but it's definitely robust. Re-adding a disk =
without unmounting would be amazing.

Paul.

