Return-Path: <linux-btrfs+bounces-3005-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 295EF87161F
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 07:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3811283A9C
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 06:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539087BAF5;
	Tue,  5 Mar 2024 06:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VyW0krwO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GBQ8bdyS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E177945BFB
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Mar 2024 06:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709621876; cv=fail; b=MrRMDeSqHBxRtGajfKX+LRZ6NUBnNiuxqYzwWJEI8RBnwNVBvzTCvBoKs8KyyPC7zxiNkUnJvhFtHO3aAFoklqlkILUbuayOGZ1A878kRXnl1TJadg+JXIb0ICREIX6q2esIzb9nc/Iq3CPjEQy1Acke/IkpfKFuTJdKPup9dEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709621876; c=relaxed/simple;
	bh=tgJWk74fwqLUCTVXRRQibe7XnqVnyspyKfeYEL+kWs0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MxXIl88uM6Tn4Mt7ywopxoFuryuRde2E4itt3x/Z3i21T05KI2XOuqdWhqEqpoftl299nff429dVxJlPgIssWAGJSVQerhIjHCVJ0J7Oq856KjuabNtOiUQGomll/iY4LeTmv6yBHcFevnnP6BTzJKL1x4/uKyKnmhTW1HVtZ2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=VyW0krwO; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=GBQ8bdyS; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709621873; x=1741157873;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tgJWk74fwqLUCTVXRRQibe7XnqVnyspyKfeYEL+kWs0=;
  b=VyW0krwO5DldP7xMjyiiS+uNzQKX3tDLwQOGgr6hzyfYOWszFdPYnB8p
   ij7pPMs0neqMDYvlD1LWDciv0IwZySreBijvr3ZOTR+7xsoay9tIAqH8o
   AzXoDJt0u80UfgFyladHyY9tk6DYOekGwEI2Wvow3dANM4g1SDWx+l+sK
   wpyyZ+TjeLruLRL/65PE+pfh5kL4pNa4NHLIwmP5CAVoAuOrBbcOg9kva
   6Dnp1/yybt0TRO5flWaj541ZyR8tujffj1M3IIjpzLC5fwI6CGcy62Tvx
   bL08j8L1J2GaT7UiHcrMxUz6OYMGwjfdwmwel/Hm0IicN5yT+eoYgjSPx
   w==;
X-CSE-ConnectionGUID: cpPoNS7CSaqDw6y+SnbGKQ==
X-CSE-MsgGUID: bKJGCRmOTaG2bBBrDyv1Uw==
X-IronPort-AV: E=Sophos;i="6.06,205,1705334400"; 
   d="scan'208";a="10817914"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 05 Mar 2024 14:57:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjZKl1C5oZH2PibQLSBBN3B7sLSsZhS9/PJxZPty/yELYZ5dOlILXvb/JRCyjEj2bY/MWpwk/xsIN0qrAd8Llv+YO/Bt3dTbqXhcHJkpjds2PkOF6OP0Jvtc694VX/qBX8ITvexhwH+red2hZuVmEmX2th2EAPCVxY/nTq15RrmSj1zEfEoPforMTeNybnO+bsgdyFtN2jfcnNun0Er9gTbZWtVPwCUuKbPRKYqfLUKGM8IhrFoLY2EzNpZc4Ln5FmueEn8RUTvaOA4bUeV+yW14RLiqYC0Nle9d+iCK6GagPGNZ/EpR7/i3gItQOnpwKzNl1ieHz9G09E9clOhyew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9bCt9UgqGf0Ok8U2xuZow/1ECCosTHa8M0DiwCZtp4=;
 b=FTe8MVTwb0pZXgqOZbnlq0hDfLkErOFOgSkn5OVq5qMTpyIMyhjmzcInjvQG9dadTJRCMGE+ZptQszBJe8o68IxFWHd3ZAm+E9NBdz+8Rf2ddiRfnqu6iZvTp6UnIzTqvpWqrodRA3e/tesDwiHfRPYI0EmsUR5p0o87lDyQZGT7a1Did1HOxVhF9rm7NwLwczGUvffrC0Ho68Rwpe1FaDwQP5bxRhJ2I/2BGxn9K627SBADNdTW/kGSuxC3CBZLJgWi8VKW5h+Z+bM3QB4xFgPPfEB/FGm3Y3d6wZ6D9EQf9IleUAIKdfJwvA78/F4BLBH+p0um4Aip+uPD8F532A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9bCt9UgqGf0Ok8U2xuZow/1ECCosTHa8M0DiwCZtp4=;
 b=GBQ8bdySD8JfcpVPSUiuj8yK7I+TXZex0KpKINlOiuixsevBbEkKnIry4TSCbNNER1HcrVKxthUGgKapkWW15wDwuB0ub9+FU+Mq+X1jp3fj9/QY5zSeXdTN6jg5xXpcoZjbvZ8my0ZaFcj4kvTM7Ozf0HOY+CKVn25ya0ZAozM=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by MN2PR04MB6381.namprd04.prod.outlook.com (2603:10b6:208:1a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 06:57:48 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::117f:b6cf:b354:c053]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::117f:b6cf:b354:c053%7]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 06:57:48 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: David Sterba <dsterba@suse.cz>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: prevent extent buffer header to be cleared
Thread-Topic: [PATCH] btrfs: zoned: prevent extent buffer header to be cleared
Thread-Index: AQHaakUdCXHqX4MHOk+djGt97CXB0LEfveiAgAkCaYA=
Date: Tue, 5 Mar 2024 06:57:48 +0000
Message-ID: <dtdsgmky6x7nziaaz7piiceexsc5gds5nzrbsmvhnpp4vbjbwg@i4e6ktyt2sdz>
References:
 <3f4f2a0ff1a6c818050434288925bdcf3cd719e5.1709124777.git.naohiro.aota@wdc.com>
 <20240228132249.GJ17966@twin.jikos.cz>
In-Reply-To: <20240228132249.GJ17966@twin.jikos.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|MN2PR04MB6381:EE_
x-ms-office365-filtering-correlation-id: bc69bf42-e02b-4480-e608-08dc3ce19170
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jgTY8epFGk9/AUSCnFDXhyJKMbQH2xl63g0fGEeuGAMXw+mXNzY0zbJU3ViPxT3J336P8ziF/s6BNg8TUqnWSSmNNWMFMU73piP2/Buj5ehXviE/H1PrTgVujifcKNW9f4kmHPq3hKjRlm8kcgpus1bqCETEjtfshucgnK6SRYVjpsvuZXt5S7ut6R3YfhVk2Ts4pQsPMsLj8q93V2ga6FEIPCaDL4ZGtsljNwZCj7FD+y76C5BMsQt6HovbiYLpfX6ODuNmIZBu9HeCzD8+2RFofF+6BoCM+6v/I4g7+onOfsKJPL7k1YlhzX2otRtHSZUiRtMEhg9Zbgaf8tfuZVwjOvvG/z49jHnaAxZCyngFiFWLFJM3L7rAfLmHIRexhmGpVriKxS0TZhnOTNu397eVhkdJFHr0D3iELbfJMCrsygy5ewbVGtvfHk5yX86qzgasxcXtyad7uTvYnoGNtV8u7FCm0p2Phds857qSpPaWc8fwI+Y5PTYyaimomMzCnufgREeLNs90J5Z8gGzCGcEgi84AX+jWMU3q1RaPBjdqirylMvPJTPkbtcC44koROPJr5wdvEaFK57B5fV+WdWi9D1FSSVgVxELnopmx3sVah6rxXHEJDcNmVAaznoDOp4U1mmV24hHZxDDvL6htVO0F0SCRom8jZwtbLehUYNo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rNmGnVKY4GJjHa+YacB+9ulYp/mvbAWZRsukdNvFmhYuMxsOZ/70+lTPwbXT?=
 =?us-ascii?Q?rEliSJOKqfe0hBNLaZjVI6VxxlC1Q+EIWQsKQwnGGL2S4wrIGLhLPrRgsf1E?=
 =?us-ascii?Q?N8B9My3d9rlK+cJRQJ47UYr41wkEEftRQ6MzgwX7f/jcFxDWsJcAloI4i9yu?=
 =?us-ascii?Q?DVy02pFWF5STgd+Lj74eEfoacY2U+d3jnDZ4fJFyTs8GyusPxUS3HmAZBDKU?=
 =?us-ascii?Q?YBXJwxYXjYa3Rqfb7pboaAajpr4kZKIW5G7WWUMaH4/Qtpp6dq3FmqGce2Ps?=
 =?us-ascii?Q?FPtkDmPbUAmqFYRkGfH1UHYDcpfIkadrxzAndpq0w1AwodPLJrf/KOhQa+x3?=
 =?us-ascii?Q?v9NZ9XsV38jv+JSB4HHdqKPD67YxeNvalHZUQM8CtSl3lD1SHBCBA0EnB0tG?=
 =?us-ascii?Q?iFjX2NgFFA4nXKHNBe/We3ZTk5+k4ZLYvd0fIjOvKp784Oj0HgVFTWhzE8i0?=
 =?us-ascii?Q?AFGYwCTI21VdhLwB8ZeEJzYCbpspkLoeVBTv5zHk9zztwh/Yo+a/NNgnJifY?=
 =?us-ascii?Q?dp20uMN3zEwpugv6X1YpC9YL3225XpcmOu5Yt5H1WuQX2zA0zcHb/LExXUS/?=
 =?us-ascii?Q?5r1OFWpwddQHnBelpnvK73uC8QyBZdOMoL2pYihEja+HKP03tOLQJBq47qic?=
 =?us-ascii?Q?JeHBb/fIZZGX5uMeqJB9KZjyTRjdltDYuH5W9K+aKxu+NxCtW+QAI1kMwAwj?=
 =?us-ascii?Q?Ll2VBDTt/q2C9sIEBfDJ8UmRYcK0HBdK1YECEJy0bBGfqKu0HDkfGwslC+mU?=
 =?us-ascii?Q?iA5mK49Gza+bmk1LZIHo/OBQFK7jcvgMmY8LmFIoDAJHYnQw15uulXm3DS/H?=
 =?us-ascii?Q?U+H46JDYI9YV7PNgoT1vipgO643Xwjn4LKPUUhNbjl1h/Gu+qQXks61ZrA9n?=
 =?us-ascii?Q?4hlHqIJXCl7TzBc3S4HvIbFXpnNm18k+aOvFThqj4JY7zTrJ5GJNbKifkLM6?=
 =?us-ascii?Q?4xE2MOGA8qgMjB0w/fqBQZPJPVpzNCW7CfRLpiY7EtlRydYs62OIHbTcuGBM?=
 =?us-ascii?Q?kTsPX452EWgmw9tcEodq+OkOaRpxYskwjikG+qusPVM+YlvJFGLydI4kKD7W?=
 =?us-ascii?Q?fgPOTrEtiqD2hLhJbfz0Ut/Rs4xZNGYrLYs7swwiETIwzP7yWdIDE4hL8xX/?=
 =?us-ascii?Q?hKLXVDefTDpszXXv3Og37/FVyHHmoKOOKN7J+4T6woMGwNFJpVR8+KeoMJbv?=
 =?us-ascii?Q?jF1OrvanPWS4F7VWvplEh/DjC0Ydsc59Yb+CkElP/tPZezR4nhWbXkI+VRuw?=
 =?us-ascii?Q?kfyCoPgFOV3GpZQ//hN6bMHWJZ/p5zyi3IxY5zD15Q6foEOEYyq5E4zc5FSf?=
 =?us-ascii?Q?PbYZpi9vNXcm38KrKrVAkiBcd750jKrh+lar9ghomGKloGdzA7rYQ3V7kd+Y?=
 =?us-ascii?Q?LlaF9X4Vej4FJ7ERkS3yqyhxZ20p3hkpqJLEDxiiAxgsg+TAbWgW93+Zk4Bt?=
 =?us-ascii?Q?QT5qbrPlDcDjQKMB5Ua4DxE2AEOEFFvNIE1ZSjrRhG9QsOEtytWxzQPh3X9T?=
 =?us-ascii?Q?/do/WVIq9rymPqD4Nn0Wyz/5ejnwXSMiAAzvykjJV/Ti3X/TJxk5K2MTACho?=
 =?us-ascii?Q?LfvXftnbfQ/gNriEzfCRtf6wj+NP4IGbaEGXrPizDWMzQ6xcZxJzYLFkZj5z?=
 =?us-ascii?Q?zg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B8A059A793504643BAB947245635BFBF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RbVf0iZqW6ddwwDKwRDKFXJc/S8u1XvuxYWvGowrCYb2bkei5g3lW75yNzVPm34yUL7Jw0x5etdw9eVX/QS8XspBcTmw2/FfkyC2dtHSWGOVDtavatUW4B0Lz+c/NymdHs3tGv3Pog8xyQhcCSCjWrtsN+Qbmd8RpB7nRi8fmJIYWvggXLrKsZRiEwgnx36OZfHGwcbUEOK2T2iGuntOyZSnkIHiXoipDfK6SNFCoEZ8eAfY8tghDRSUBKZMyTwACuPU4+UUcFiKwdflpPBnsU/c6LGAlxHCbKiszQnXGJw5B74Ko7kySSDBK8wV2fYaAs4ZyFNkUUl7eDC2Ab0rtbXKDVPGZUJ4dwlRglXrjrOJLmyhRMJrHXBSNydYAxUtMbMn4PSiD5PY6yle7x7A2uAUtcsuOdCxsRtYOoWw7WQPyr4oVSJncFW9YA1Wx6D6bN7jI2f45m6KhOUb8/yV1qR9EpHqRKLiB9DQ/vTntC+UJ7DckViFyTRd4cQV1DG/8GZYIAxhAIjqMzCbl4lBITGgkfEKEwnz5TcG85h4zkyR+FDCffugOOTGZFG56fw32p6ZlYBM7bEdrImnf2MdfFHuDWaN1EKP2+EFwZwgv1KNEKCWhpE8REK584QvtbIe
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc69bf42-e02b-4480-e608-08dc3ce19170
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 06:57:48.4792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ut4F8u3lgsupq+rY2k/BV3tYeivmtyBR2Km4E/YLdU9akBVlkRG6klG8ZHiVPgDOq6tCP0VDeqX6PhSy3ZclTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6381

On Wed, Feb 28, 2024 at 02:22:49PM +0100, David Sterba wrote:
> On Wed, Feb 28, 2024 at 09:53:03PM +0900, Naohiro Aota wrote:
> > Btrfs clears the content of an extent buffer marked as
> > EXTENT_BUFFER_ZONED_ZEROOUT before the bio submission. This mechanism i=
s
> > introduced to prevent a write hole of an extent buffer, which is once
> > allocated, marked dirty, but turns out unnecessary and cleaned up withi=
n
> > one transaction operation.
> >=20
> > However, btrfs_free_tree_block() can be called on an extent buffer afte=
r
> > its content is cleared. Then, it inserts a faulty delayed reference ent=
ry,
> > which makes the FS corrupted.
> >=20
> > This bug can be triggered running generic/013 several (~200) times. It
> > failed as following:
> >=20
> >     ------------[ cut here ]------------
> >     WARNING: CPU: 9 PID: 29834 at fs/btrfs/extent-tree.c:3248 __btrfs_f=
ree_extent.isra.0+0x604/0x1330 [btrfs]
> >     Modules linked in: dm_flakey algif_hash af_alg xt_conntrack xt_MASQ=
UERADE nf_conntrack_netlink nfnetlink iptable_nat nf_nat nf_conntrack nf_de=
frag_ipv6 nf_defrag_ipv4 xt_addrtype iptable_filter ip_tables br_netfilter =
bridge stp llc overlay sunrpc kvm_amd kvm irqbypass rapl acpi_cpufreq ipmi_=
ssif i2c_piix4 k10temp btrfs ipmi_si blake2b_generic ipmi_devintf xor ipmi_=
msghandler raid6_pq bfq loop dm_mod zram bnxt_en ccp pkcs8_key_parser asn1_=
decoder public_key oid_registry fuse msr ipv6
> >     CPU: 9 PID: 29834 Comm: fsstress Not tainted 6.8.0-rc4-BTRFS-ZNS+ #=
403
> >     Hardware name: Supermicro Super Server/H12SSL-NT, BIOS 2.0 02/22/20=
21
> >     RIP: 0010:__btrfs_free_extent.isra.0+0x604/0x1330 [btrfs]
> >     Code: 8b 3f e8 bf 69 00 00 48 8b 7d 60 45 8b 4f 40 49 89 d8 8b 54 2=
4 40 4c 89 e9 48 c7 c6 30 64 65 a0 e8 61 fb 0d 00 e9 8f fd ff ff <0f> 0b f0=
 48 0f ba 28 02 41 b8 00 00 00 00 0f 83 86 04 00 00 b9 8b
> >     RSP: 0018:ffffc900090cfb80 EFLAGS: 00010246
> >     RAX: ffff888365c719d8 RBX: 0000000f9677c000 RCX: 0000000000000001
> >     RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
> >     RBP: ffff8889a044b220 R08: 0000000000000000 R09: 0000000000000004
> >     R10: 0000000000000000 R11: 00000000ffffffff R12: 0000000000000001
> >     R13: ffff888ad87a4c98 R14: 0000000000000005 R15: ffff888a0c7d2a80
> >     FS:  00007f823f5f7740(0000) GS:ffff889fcea40000(0000) knlGS:0000000=
000000000
> >     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >     CR2: 0000560ce0610b38 CR3: 0000000a907ec000 CR4: 0000000000350ef0
> >     Call Trace:
> >      <TASK>
> >      ? __btrfs_free_extent.isra.0+0x604/0x1330 [btrfs]
> >      ? __warn+0x81/0x170
> >      ? __btrfs_free_extent.isra.0+0x604/0x1330 [btrfs]
> >      ? report_bug+0x18d/0x1c0
> >      ? handle_bug+0x3c/0x70
> >      ? exc_invalid_op+0x13/0x60
> >      ? asm_exc_invalid_op+0x16/0x20
> >      ? __btrfs_free_extent.isra.0+0x604/0x1330 [btrfs]
> >      ? srso_return_thunk+0x5/0x5f
> >      ? rcu_is_watching+0xd/0x40
> >      ? srso_return_thunk+0x5/0x5f
> >      ? lock_release+0x1e5/0x280
> >      __btrfs_run_delayed_refs+0x64c/0x1380 [btrfs]
> >      ? btrfs_commit_transaction+0x3e/0x12d0 [btrfs]
> >      btrfs_run_delayed_refs+0x92/0x130 [btrfs]
> >      btrfs_commit_transaction+0xa2/0x12d0 [btrfs]
> >      ? srso_return_thunk+0x5/0x5f
> >      ? srso_return_thunk+0x5/0x5f
> >      ? rcu_is_watching+0xd/0x40
> >      ? srso_return_thunk+0x5/0x5f
> >      ? lock_release+0x1e5/0x280
> >      btrfs_sync_file+0x532/0x660 [btrfs]
> >      __x64_sys_fsync+0x37/0x60
> >      do_syscall_64+0x79/0x1a0
> >      entry_SYSCALL_64_after_hwframe+0x6e/0x76
> >     RIP: 0033:0x7f823f6f8400
> >     Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 0=
0 0f 1f 44 00 00 80 3d e1 d1 0d 00 00 74 17 b8 4a 00 00 00 0f 05 <48> 3d 00=
 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c
> >     RSP: 002b:00007ffe3c26e9f8 EFLAGS: 00000202 ORIG_RAX: 0000000000000=
04a
> >     RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f823f6f8400
> >     RDX: 0000000000000193 RSI: 0000560cdfcdb048 RDI: 0000000000000003
> >     RBP: 00000000000002e6 R08: 0000000000000007 R09: 00007ffe3c26ea0c
> >     R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffe3c26ea10
> >     R13: 028f5c28f5c28f5c R14: 8f5c28f5c28f5c29 R15: 0000560cdfcd7180
> >      </TASK>
> >     irq event stamp: 0
> >     hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> >     hardirqs last disabled at (0): [<ffffffff810e5e0e>] copy_process+0x=
b0e/0x1e00
> >     softirqs last  enabled at (0): [<ffffffff810e5e0e>] copy_process+0x=
b0e/0x1e00
> >     softirqs last disabled at (0): [<0000000000000000>] 0x0
> >     ---[ end trace 0000000000000000 ]---
> >     ------------[ cut here ]------------
> >     BTRFS: Transaction aborted (error -117)
> >     WARNING: CPU: 9 PID: 29834 at fs/btrfs/extent-tree.c:3249 __btrfs_f=
ree_extent.isra.0+0xf8e/0x1330 [btrfs]
> >     Modules linked in: dm_flakey algif_hash af_alg xt_conntrack xt_MASQ=
UERADE nf_conntrack_netlink nfnetlink iptable_nat nf_nat nf_conntrack nf_de=
frag_ipv6 nf_defrag_ipv4 xt_addrtype iptable_filter ip_tables br_netfilter =
bridge stp llc overlay sunrpc kvm_amd kvm irqbypass rapl acpi_cpufreq ipmi_=
ssif i2c_piix4 k10temp btrfs ipmi_si blake2b_generic ipmi_devintf xor ipmi_=
msghandler raid6_pq bfq loop dm_mod zram bnxt_en ccp pkcs8_key_parser asn1_=
decoder public_key oid_registry fuse msr ipv6
> >     CPU: 9 PID: 29834 Comm: fsstress Tainted: G        W          6.8.0=
-rc4-BTRFS-ZNS+ #403
> >     Hardware name: Supermicro Super Server/H12SSL-NT, BIOS 2.0 02/22/20=
21
> >     RIP: 0010:__btrfs_free_extent.isra.0+0xf8e/0x1330 [btrfs]
> >     Code: 48 c7 c6 40 5d 65 a0 e8 f0 f1 0d 00 c7 44 24 18 01 00 00 00 e=
9 ed f7 ff ff be 8b ff ff ff 48 c7 c7 68 5d 65 a0 e8 52 69 c1 e0 <0f> 0b e9=
 30 fb ff ff 48 8b 45 60 48 05 d8 19 00 00 f0 48 0f ba 28
> >     RSP: 0018:ffffc900090cfb80 EFLAGS: 00010282
> >     RAX: 0000000000000000 RBX: 0000000f9677c000 RCX: 0000000000000000
> >     RDX: 0000000000000002 RSI: ffffffff82464302 RDI: 00000000ffffffff
> >     RBP: ffff8889a044b220 R08: 0000000000009ffb R09: 00000000ffffdfff
> >     R10: 00000000ffffdfff R11: ffffffff8264dd80 R12: 0000000000000001
> >     R13: ffff888ad87a4c98 R14: 0000000000000005 R15: ffff888a0c7d2a80
> >     FS:  00007f823f5f7740(0000) GS:ffff889fcea40000(0000) knlGS:0000000=
000000000
> >     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >     CR2: 0000560ce0610b38 CR3: 0000000a907ec000 CR4: 0000000000350ef0
> >     Call Trace:
> >      <TASK>
> >      ? __btrfs_free_extent.isra.0+0xf8e/0x1330 [btrfs]
> >      ? __warn+0x81/0x170
> >      ? __btrfs_free_extent.isra.0+0xf8e/0x1330 [btrfs]
> >      ? report_bug+0x18d/0x1c0
> >      ? tick_nohz_tick_stopped+0x12/0x30
> >      ? srso_return_thunk+0x5/0x5f
> >      ? handle_bug+0x3c/0x70
> >      ? exc_invalid_op+0x13/0x60
> >      ? asm_exc_invalid_op+0x16/0x20
> >      ? __btrfs_free_extent.isra.0+0xf8e/0x1330 [btrfs]
> >      ? srso_return_thunk+0x5/0x5f
> >      ? rcu_is_watching+0xd/0x40
> >      ? srso_return_thunk+0x5/0x5f
> >      ? lock_release+0x1e5/0x280
> >      __btrfs_run_delayed_refs+0x64c/0x1380 [btrfs]
> >      ? btrfs_commit_transaction+0x3e/0x12d0 [btrfs]
> >      btrfs_run_delayed_refs+0x92/0x130 [btrfs]
> >      btrfs_commit_transaction+0xa2/0x12d0 [btrfs]
> >      ? srso_return_thunk+0x5/0x5f
> >      ? srso_return_thunk+0x5/0x5f
> >      ? rcu_is_watching+0xd/0x40
> >      ? srso_return_thunk+0x5/0x5f
> >      ? lock_release+0x1e5/0x280
> >      btrfs_sync_file+0x532/0x660 [btrfs]
> >      __x64_sys_fsync+0x37/0x60
> >      do_syscall_64+0x79/0x1a0
> >      entry_SYSCALL_64_after_hwframe+0x6e/0x76
> >     RIP: 0033:0x7f823f6f8400
> >     Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 0=
0 0f 1f 44 00 00 80 3d e1 d1 0d 00 00 74 17 b8 4a 00 00 00 0f 05 <48> 3d 00=
 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c
> >     RSP: 002b:00007ffe3c26e9f8 EFLAGS: 00000202 ORIG_RAX: 0000000000000=
04a
> >     RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f823f6f8400
> >     RDX: 0000000000000193 RSI: 0000560cdfcdb048 RDI: 0000000000000003
> >     RBP: 00000000000002e6 R08: 0000000000000007 R09: 00007ffe3c26ea0c
> >     R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffe3c26ea10
> >     R13: 028f5c28f5c28f5c R14: 8f5c28f5c28f5c29 R15: 0000560cdfcd7180
> >      </TASK>
> >     irq event stamp: 0
> >     hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> >     hardirqs last disabled at (0): [<ffffffff810e5e0e>] copy_process+0x=
b0e/0x1e00
> >     softirqs last  enabled at (0): [<ffffffff810e5e0e>] copy_process+0x=
b0e/0x1e00
> >     softirqs last disabled at (0): [<0000000000000000>] 0x0
> >     ---[ end trace 0000000000000000 ]---
> >     BTRFS: error (device nvme1n2: state A) in __btrfs_free_extent:3249:=
 errno=3D-117 Filesystem corrupted
> >     BTRFS info (device nvme1n2: state EA): forced readonly
> >     BTRFS info (device nvme1n2: state EA): leaf 66957836288 gen 3873 to=
tal ptrs 203 free space 1102 owner 2
> >     BTRFS info (device nvme1n2: state EA): refs 2 lock_owner 29834 curr=
ent 29834
> >             item 0 key (63394947072 168 40960) itemoff 16230 itemsize 5=
3
> >                     extent refs 1 gen 3835 flags 1
> >                     ref#0: extent data backref root 5 objectid 552 offs=
et 1802240 count 1
> > (snip)...
> >             item 164 key (66948923392 169 0) itemoff 8229 itemsize 33
> >                     extent refs 1 gen 3872 flags 2
> >                     ref#0: tree block backref root 2
> >             item 165 key (66948939776 169 1) itemoff 8196 itemsize 33
> >                     extent refs 1 gen 3873 flags 2
> >                     ref#0: tree block backref root 5
> >             item 166 key (68719476736 168 110592) itemoff 8143 itemsize=
 53
> >                     extent refs 1 gen 3841 flags 1
> >                     ref#0: extent data backref root 5 objectid 440 offs=
et 3100672 count 1
> > (snip)...
> >             item 202 key (68722249728 168 110592) itemoff 6177 itemsize=
 53
> >                     extent refs 1 gen 3842 flags 1
> >                     ref#0: extent data backref root 5 objectid 953 offs=
et 5431296 count 1
> >     BTRFS critical (device nvme1n2: state EA): unable to find ref byte =
nr 66948939776 parent 66948939776 root 5 owner 0 offset 0 slot 166
> >     BTRFS error (device nvme1n2: state EA): failed to run delayed ref f=
or logical 66948939776 num_bytes 16384 type 182 action 2 ref_mod 1: -2
> >     BTRFS: error (device nvme1n2: state EA) in btrfs_run_delayed_refs:2=
246: errno=3D-2 No such entry
> >     BTRFS warning (device nvme1n2: state EA): Skipping commit of aborte=
d transaction.
> >     BTRFS: error (device nvme1n2: state EA) in cleanup_transaction:2006=
: errno=3D-2 No such entry
> >=20
> > This happens maybe because clearing the contents is too early. It shoul=
d
> > clear the content after all the reference to the node is dropped.
>=20
> If you have such suspicion you can add assertions to validate the state,
> bits and other constraints.

It is difficult to assert the node-to-node reference because we need to
query the tree. But, I'm going to add other assertion to check if the
delayed ref is not faulty.

>=20
> > Addressing that root cause needs more time. Until that, leave the exten=
t
> > buffer header intact, so that we can add a proper delayed reference ent=
ry.
> >=20
> > Fixes: aa6313e6ff2b ("btrfs: zoned: don't clear dirty flag of extent bu=
ffer")
> > Link: https://lore.kernel.org/linux-btrfs/oadvdekkturysgfgi4qzuemd57zud=
easynswurjxw3ocdfsef6@sjyufeugh63f/
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >  fs/btrfs/disk-io.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index a2e45ed6ef14..8aaed8719394 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -278,7 +278,9 @@ blk_status_t btree_csum_one_bio(struct btrfs_bio *b=
bio)
> >  	 * ordering of I/O without unnecessarily writing out data.
> >  	 */
> >  	if (test_bit(EXTENT_BUFFER_ZONED_ZEROOUT, &eb->bflags)) {
> > -		memzero_extent_buffer(eb, 0, eb->len);
> > +		const unsigned long header_size =3D sizeof(struct btrfs_header);
> > +
> > +		memzero_extent_buffer(eb, header_size, eb->len - header_size);
>=20
> So this means anything that finds the buffer will have to rely on the
> state in the header and if it's with ZONED_ZEROOUT then stop processing
> it. btree_csum_one_bio() is the only function that checks the bit
> AFAICS.

Yes, indeed it's cumbersome to check the flag for every btrfs_header_*
usage. So, I found another solution and I'm testing it. It looks like
adding EXTENT_BUFFER_ZONED_ZEROOUT even when an extent buffer is not DIRTY
is causing the bug.

> Otherwise, if this is a sufficient fix we'd need it for 6.8.=

