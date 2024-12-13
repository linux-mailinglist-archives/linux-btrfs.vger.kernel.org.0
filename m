Return-Path: <linux-btrfs+bounces-10353-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D64F9F1017
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 16:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801A9169E02
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 15:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08081E47AD;
	Fri, 13 Dec 2024 14:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SDWhHevb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="obQml3zq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D26B1E1C1B
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2024 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101786; cv=fail; b=mpcy63gtfotaSblLT5TNIx+JsEPgTGaej67wccM6aNOmD8Nuu+xguQdDWhnWv/gsYH5vxt/CGCRvhpZaJHuuyi8yGfbVQ3IYJn2jzOku9ZIfAWHoR+RdBavIZT2hy0I5t5SwZJKkulsgmkyxEP2LysygLdK6VdcK8M0q2JZGwLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101786; c=relaxed/simple;
	bh=MP6zFTALhq3XLTosMOXiMPWKFizFZKRFf8oDAfrxitI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dD5e2U/MGewlXv3u4OW4eI4O/XIBoZjZ8aCpY+bNoV++n/SOEu47Box1ku2fUwt/Q0DSnE+j//ZP4POeQBIVi5K6uYiU2fDtWKH4gPXMsP9Uwz2GddeWqZxTfrvnySKzGPz/j30QAe/n7Az2pwVBEY/nOWG1lXxvjbWLp2a4I/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=SDWhHevb; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=obQml3zq; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1734101784; x=1765637784;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MP6zFTALhq3XLTosMOXiMPWKFizFZKRFf8oDAfrxitI=;
  b=SDWhHevbs5e8A2Ug/88QfYuxhg5tXd7VSgIaloygRL5JxHa/p8bNicdD
   NxB7zydBKC/AxmChXSJcQSMFFnYWcgjaDntHzff5tbuYpEAM8g4H/yYd0
   Stz+5WtXFjxvLM2ArJzSGd+vlrEGJLTKXUGMPVKjV99aMEN8JJVRWBTzW
   AtczIKRgMqNP89XkbwvlpEZM3Jcd8Ge0lMPO+JbBLSQuFG4oAlJ7F+J0d
   0MATSSQ2maW+KuMYvGeK/mUMGP2n547dHZW9MrUr03kVNCCZai/CdJMMi
   WYzHyrQRtab3ZMu7P09+fyC30Zv3/M/DtxYi+LlwdYRSGrFJqcqnfwGeS
   Q==;
X-CSE-ConnectionGUID: J95ooRGRQUeCudNOhOVpnQ==
X-CSE-MsgGUID: 5eHy15juT6eOm7Wd9aR6vg==
X-IronPort-AV: E=Sophos;i="6.12,231,1728921600"; 
   d="scan'208";a="34291301"
Received: from mail-eastusazlp17010003.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([40.93.11.3])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2024 22:56:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6KfVCz+B3005MuY/811UfXeVQ67+yE97X6ijON5cGIgEeVqcTk6/69icSjyTHxFjLAVpJ75HHfZxwCGqfFgKIKVO+Z+tKgW4zH61HySaBB2WFdCs3gJ7th+WKxWJoNxSd3qkxA3NGceRU1PghNZ9c8nWVXLYIOIvsCrqoEOfUsJqpP+CgNf/7HYzhNGlJAOjzlS6BFfKOgZqAOkynwAbREqEMHX4OUpZpJpnpAUYkUmeOAwxgIj0mJ83yCkRZrtjXbvPx8Dr/7tLdJDxBOlGAoq0h+S0XpFTQa2DVlgKtSrUcqVWuIKEgT7SkdcBbP73VHWERfzpeg7ppwIGJ1EPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgTJoNdpt/XFK+0jjX6LYEUnQIHHVKdk95ELP33etJ0=;
 b=FCtLeBpCK/j3pNw8NydSV7UQ6ArLNMsifuroxDCqbkXFGtbtY7jGXhng5TERa901ZaoW86QQIl6pTGkFR4y638GBQIYYNUQH+daSHM5dpO41BeiNT5SabBBJcvO1pYc64qWVgsNiM1ey68ID7qnJkGMoM8NCv3x4rt1ouP+hWv3gc5WUdwatc3VE9z92j6NcSpFA4MOjZzKgoHNLHIWVW7MgaPciXChWgjno2PihGNt/jesZX3kMRpVKA0+MSoeZQwcbeFiY/jMCOtO6Y7PcsSvmQkQYYZisS9Sx+TQbtaOzhCV7R9FtRApHiYQfFiMWT922euLs3oUhZxRXZcNHiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgTJoNdpt/XFK+0jjX6LYEUnQIHHVKdk95ELP33etJ0=;
 b=obQml3zq4LZBuyGWPBL/CEijOxGNmVI0PiEtIFmO9qhCtH/q4jYqQp+dpupECKhkVOiHdwqKFf3CegAzXgtzUdq8kIdrbeTNDXhUHvO4kKkoZmOm2t/MZ/kEQ4ttO/r8/VrBbd4Q4Avo4oOihaxCxItYg7xP4IfxI/nq15Xzozo=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SA2PR04MB7579.namprd04.prod.outlook.com (2603:10b6:806:135::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Fri, 13 Dec
 2024 14:56:15 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%7]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 14:56:15 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: hch <hch@lst.de>
CC: "clm@fb.com" <clm@fb.com>, "josef@toxicpanda.com" <josef@toxicpanda.com>,
	"dsterba@suse.com" <dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: calculate max_extent_size properly on
 non-zoned setup
Thread-Topic: [PATCH] btrfs: zoned: calculate max_extent_size properly on
 non-zoned setup
Thread-Index: AQHbTSpfHhy8TBJv0EC2ztaxHd+UxrLkQ/oA
Date: Fri, 13 Dec 2024 14:56:15 +0000
Message-ID: <6dpllfj2xt7rlxsocwxqyfaemeyin4zdhokqmgjv37azi53vvw@2x3ja53aomdn>
References: <20241213064343.1498094-1-hch@lst.de>
In-Reply-To: <20241213064343.1498094-1-hch@lst.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SA2PR04MB7579:EE_
x-ms-office365-filtering-correlation-id: 057e8c90-29a3-4354-fba2-08dd1b864b16
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?jDfbT9N2JR9pb5DW2KH/cnCxQZUUmzEe6ZrG2r1kZKhrRgyJJ4Ex97Gy9UpI?=
 =?us-ascii?Q?lMJD3LB1z9V6yzWjUpoWfrCKYCz9g7l72KmQsITxWRmpNQgmiVreFziDi0d8?=
 =?us-ascii?Q?p5ug0w7P6bavj/VoDgaVRxB+cvzDGhefIHTeT8iW2sGQQh+AHKVZZiwKilyL?=
 =?us-ascii?Q?3522OA9RhqT9KwsUgMsWFqzcrBwlvj1tQhZqzVAIlfoBwWg5jV7URGVfIOXn?=
 =?us-ascii?Q?xCE/3mqCoOkBUf2qV64ZLalQdqyaFy97p0AyVYyUpfWSRcU/7HzTGI8cLnYZ?=
 =?us-ascii?Q?8HqP2d1A/VwLMQv+L8vl/362v5ELq1WemTOvbG3P4VErB/Y+UKsZ+EO7HEdM?=
 =?us-ascii?Q?VrC1KH+qPeeHasDUppESNDDjWbrVUlZSMhh5qyhCqyGz+0dkVVI+LrP3bUzh?=
 =?us-ascii?Q?c3//e0o3Wou3gUNh1FKMlR+pImJPucTAxSLFXqAVuRH4ZryEWXG3JdPD/7Of?=
 =?us-ascii?Q?UPX9waTpCWDkX2tyn0O3OKw84wHEiAgzDA+GehYqBHF4GMTv+9ai0vQbIs6g?=
 =?us-ascii?Q?7OxLHgEJw8LTEiIoQQAN+UmdQr5sD+ZtLPIHsU50AvlCMeoINatu2ruFG0tu?=
 =?us-ascii?Q?+T+2VSfqewpzbIlKlA48owIM6nFyDunbEt9aSeI9UQd1/gYdZwf2gR+OWyGI?=
 =?us-ascii?Q?8t+6g9raSxTcl0mi01NERe11ulTDvvDewl7DuExmCwfmqPKluKTNmEnMNl0w?=
 =?us-ascii?Q?oetPE7VANfomK/uYIJSID0enZWm5jwfZNw0bLo+5HuKVZ7JtjJEo659vKeYl?=
 =?us-ascii?Q?H3TuZTp7P9vKH+izxs1u46gyd2cOsh99t86tU5q6KQSGP1ZbBaLej/mjWPN+?=
 =?us-ascii?Q?TRLh1KquxbyCZoyTRG2j6LnHI3HZbKePpqI9t4GyLywkcUecB/mwraygCCvr?=
 =?us-ascii?Q?LtDIuhtGG0pvf4VC7mocVjKkVFpk2a7BzWj6mI5ATbEj+5Qh5XDp3QFxi03+?=
 =?us-ascii?Q?XyvVp5FyHed8dq/uAwkYeDgiL6YDPogEldGalCx18fkjYZQKVTzYDKuOXX67?=
 =?us-ascii?Q?SR/tNHkOPW1dmAOMzs0yrdJwbAq36REnrceHzFJXwL9Ea3Jx+knXETANvkW1?=
 =?us-ascii?Q?58uDH3kS/s1Nu6HuBb9xpSS4JnRsu1fPO9upVSDADCVEmEXUCPGidudvaa+M?=
 =?us-ascii?Q?zZcLUtLYOC0FYv2jN+weMXwucCUi+ya5gxamsmnyB07daezm6TcVtSwDRnt+?=
 =?us-ascii?Q?mGTnBUUMxPfALEpaZEx50CbGe4sxe6KhWwCDHhxoiiLEwLeIxE73k40Xh+uP?=
 =?us-ascii?Q?BvKXylPtCP5zDC9dOav8aMs+5vWa118J4qeImnRNd2SMr6YPtWOo6rJJ5ej5?=
 =?us-ascii?Q?Znis6BWN93RuP1SzEHAe38Nn44iRmGGVUoTWaWzrUPdZMIL6zIJNcphA4Q86?=
 =?us-ascii?Q?SpUhvly894GlAOwhuXhlCDelddAcBaGe4/SoGRMk98TQG7gi8w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RzOAf6eAFmSNG36FbY70Z9oU0aMGWTQ+nPnG2fHbSmAUyeM2yGG/WeeXwtQG?=
 =?us-ascii?Q?Bz0TYRfGJAy7sEVhjwoQfxHsxj1egiBm7YDL0GrtubMB6uh2Vxdnij8NUUTA?=
 =?us-ascii?Q?edQ1p2ZbApyBN2cO4JdlS5310+2OwUOro9NQuF1dFK59vZL/ffP9nM2p0DpR?=
 =?us-ascii?Q?4Gj9GrhiiNC384NVTBs3/TGOacBXbeVKY8164gP1A+J3CTUwXOUqNrtoak4J?=
 =?us-ascii?Q?Cp73BWn22bEq51r8+n5tLXYfjCICDeFlllG1yzgo/+7hWkeLhA+4J1nDawjK?=
 =?us-ascii?Q?4T4TEYzimw9icJ7Gj+jCMNxHKh2OH8Mva0Y3XMsxJ14qBtLsJA1QAKL/Z5Lf?=
 =?us-ascii?Q?uyE4pTDWBJwTEQsDrXtKO1xlSCPtvqRu29BsIKkcogqyUvsIiBCVa465mSxi?=
 =?us-ascii?Q?OZJg/9N9sJwG6HsXU7icH4G+EYxaUm2FsrCOfNSk4RUq9FNfaqCwARxRHNec?=
 =?us-ascii?Q?G83xoQkQKGKhKvSTnJExS/BgPRhtfvJPGXyRT1C/Tjymdy2dBcfWTzYePk0y?=
 =?us-ascii?Q?iIuHUiNCwncBmlZ9ux7xEpjfwQR8wnQCwUJEaklpWfB9c8ec0ycmEdnU6hAW?=
 =?us-ascii?Q?MOVmCqPJYRGdVYde15aV1t3OyBMSNGsObl97jyOW3Fydl/dZOth0giB7WbIM?=
 =?us-ascii?Q?j2tVZE6laktKh2RGL8syKuV1MVSmpjnK+0M5/ujvitnnpMdjwZ9V+IQYQUYu?=
 =?us-ascii?Q?YQYZWJVjRyY9Rv1EUa8rnNYCTDic3TsZ7HNSNSyMsz3hPZhJZRxoP6deMdxK?=
 =?us-ascii?Q?In+NvPyNa/6AhJgSN75QRVeTlooArAkF1BJDN0s8Ldq5RGvZaWeMj3RMP+Qg?=
 =?us-ascii?Q?JupGt/wLC+xtvHsPDgzVqfypZWiQw18cpxMtcowY0IThG3AajjJ8JsbPzF9/?=
 =?us-ascii?Q?kHsjGpK7z7dP160sAOMvOzot8eWgaLwEgtbZDQPes4ZDhxoidcZ7Yvd9Q8bq?=
 =?us-ascii?Q?zjEKKIOMFftE2By+dolRtC9HGzcbw+fXNpn9DneFekslCZcl0U/iljRSxtQa?=
 =?us-ascii?Q?bSo4MG2l6i4gI57/ur1vWgWdrU6mxLo7xiE/X7BqLmTFrNMxxANmUOZNUx4G?=
 =?us-ascii?Q?/B85dN1omNKjSa9xss6lKLMvTkfNpuR72NXhPvFQEpNucn0nqwjEOHVghOhg?=
 =?us-ascii?Q?SIF0IkMr+2fxgXdbi+BFbCmUCxqDFm1Ujm953EP+UtUbfbhsbe9oZsi3Ui38?=
 =?us-ascii?Q?X951L8hjQrysygOmGF3HwOGIzKFcwvHatBDrIiEUnfXwG1XlWm0gIsWF1uwq?=
 =?us-ascii?Q?BjvXAJHAs/F4GMm6LCqc17lGi/YpwfhLLiuxpxX+5oD5eo6EeaXFX73YqUCc?=
 =?us-ascii?Q?V2HlfypxJrikO0dDHTtth46XUoE5XKl9UCo3qZNFoCGGVhg47w1jcjLONn2U?=
 =?us-ascii?Q?54kCRF6ZvS64imy1wr/v+GbQyTzp8sf0Hs/973+d1vO7LPUxGxNSgogSOjTK?=
 =?us-ascii?Q?qJPXyZ7ibXQg6G1ufxOjYLpCywfj4HQggcc8uGilvIyN7cXDSIPEOjbExsLY?=
 =?us-ascii?Q?f9jcp0V9RV2zOmN8Wn/Q9+YQxoTQEyO83U8BDH6rYpl3dNJjjDxO6oukTtmv?=
 =?us-ascii?Q?wHhVjQ+u84g+DAqX0Z/QREwEavRfYjOWER5mblfZRrXvAfyi2/88R+DNktgl?=
 =?us-ascii?Q?iA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <55AFD0FC70E71340A1E529B3931C19F9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	S08baddB/KIdxTAoJm7bhMgagNPXZ6us+/RLSrmo0wQEOia1FYv7e0grg4RuWd1uxfrqYGpHu8JpB9zDqbb1m8xOsdE7P9gKCIT+hXh6au2X9vBlW+WovdQoGAeHYTvvKZDTcLaFeKvt6iqylLNpwo3uR7Ys74/wf9bs0oePqzEIrszj2YcfzclsmEoStGFNUAecOMwFNrxXyKU2qaYuPzogFaowoTq+gGVcjHywpb81KCjVmtL2WMcgZSKRikgQLPGELXKz/T8LzptaQOelfeht9Pwz+rFgNH37nE2pn5fYszFkjZKLoAduGVhgv36EHtE4IMwIK3xlLLkKYWxSfaagLXoI+8be5n7fiZOlwGymOsxn0p5O4v0C+mXl+Z6k8xW8mga7khm4MMA5FD7D5i6s6Mb2Oduqj2AHznGD12WkQ8NcthV66kMjOf7mbGNFlTMTLT/18Ch4eaLFz0qvvp/ZpnsIHuLPT1bT2gHN4EhTsO3a1t+OqeR9YmjqfGRK8XL8U2bWb0tSwXL8FlKmycNnUhCVJLQ0P3KzGbG/A8K6Pgj5/AMYEEKiKCwiuj9OqwrZpct/AV3B8GheKLXEicjwHFkUhZWoEBVjmYuzLudp7BYccChv5PJJ8TI6b+eC
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 057e8c90-29a3-4354-fba2-08dd1b864b16
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 14:56:15.5414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xNmCwXCEEgFi47evGFoiqOrutnme6+wecb/yyiGneGnsW8mZFb49kpjlg6AOSYNtFGtuJcAdoUCGRUAC1zaERw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7579

On Fri, Dec 13, 2024 at 07:43:43AM +0100, Christoph Hellwig wrote:
> Since commit 559218d43ec9 ("block: pre-calculate max_zone_append_sectors"=
),
> queue_limits's max_zone_append_sectors is default to be 0 and it is only
> updated when there is a zoned device. So, we have
> lim->max_zone_append_sectors =3D 0 when there is no zoned device in the
> filesystem.
>=20
> That leads to fs_info->max_zone_append_size and thus
> fs_info->max_extent_size to be 0, which is wrong and can for example
> lead to a divide by zero in count_max_extents().
>=20
> Fix this by only capping fs_info->max_extent_size to
> fs_info->max_zone_append_size when it is non-zero.
>=20
> Based on a patch from Naohiro Aota <naohiro.aota@wdc.com>, from which
> much of this commit message is stolen as well.
>=20
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Fixes: 559218d43ec9 ("block: pre-calculate max_zone_append_sectors")
> Tested-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/btrfs/zoned.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>=

