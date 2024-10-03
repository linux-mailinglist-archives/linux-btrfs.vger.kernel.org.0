Return-Path: <linux-btrfs+bounces-8479-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A55CC98E82B
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 03:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8A251F22AE1
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 01:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7826014F90;
	Thu,  3 Oct 2024 01:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="egLja3vF";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="sjwWBMt2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E020BA4A
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Oct 2024 01:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727919494; cv=fail; b=jzgpcN7f64FLFS9UDN3C9NVecq+ZBbrcLlXoYomvjAn+4q4VoC311tsLTy/u9Xhbt9YYTyvTP6JGRcZfWUtrJ8Ax3YRTVrg+Z5QFKQAaeIVVx6rXusPv4PORsYh3MKeJqA3caABavTdam2tH5fiHkGsXIMwTFcSLLXHainmI14w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727919494; c=relaxed/simple;
	bh=WLMbjUTDvFiG5whe5LDUKm27WJ+vVrxUAZk+w4OqdHA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qXxTHZy9V1LFwAgQAJ/8q+66g7lFxtXXnLsmZaXdFFjralZgzjhrKr8E6Ob7zk+qxC6593NJndLiRTtXgcXwuM7NAgVGRKqiquj42IQNKyMAOBv6hn2pK3FihtzQhV8GJ7TFFoudafHSeodiYIY06AzgIzA4pczL9CitWbC0aq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=egLja3vF; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=sjwWBMt2; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1727919492; x=1759455492;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WLMbjUTDvFiG5whe5LDUKm27WJ+vVrxUAZk+w4OqdHA=;
  b=egLja3vFWYOyWCXT0pRtp7yBx9uxYVcHfI75A2CT9kjhBhhSfdqiVaTe
   BnT7yPYQopdMiE1nqnMq9eBxgxfD/ae48fs/0OHVWOO8elXRMfAWIYoFh
   RIo/VohkgkZnXhjoa6Q45RJW9/VX6wSRWG4biQgFwbwI6wdJ/UT2NNmT4
   0UkB87XKS7e/mFuWbyKxqXzZJuPi9RBQWbBxU6t0DqNMF3LD/V9r8Hvml
   keAjBkDt5/sA2WoA7hQaQ58MQd3QzA99RQUErTLKvCXfon6ARF34ET0n4
   iO6+cx2LPR9F6XHiWr12A8h6nnRYytuQxMKR3n/Tmv+pVd+qrT3ermogT
   A==;
X-CSE-ConnectionGUID: 3+Cg0HemSyWtKwi2tw0ebg==
X-CSE-MsgGUID: KIjebizoTBSdxI10rVnfFA==
X-IronPort-AV: E=Sophos;i="6.11,173,1725292800"; 
   d="scan'208";a="28134911"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 03 Oct 2024 09:38:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=klWb0doSt5SMvLfjGJZE6AM1fqclG/r1VBDBWuQ9l7AF0XkxMS63MZfa8OeC66eWXj1lS8AZ3O+ZnqVlHP2hfwrwvjggM6PSw6SpbK8jOMI5Zc+ez6A6wFTGuleWPjpz0pxuWzgb5BS5/70kMm7PaPVL+9p7o+M40prQNgYr2IrpmPjBKhQcSUissYpDc5SlcgC6htW5twWDJt7gWycapjONIa4FZtH7f6/+9Vg6yWDJjsm3g+41cX6f7QbkVC6vBpwGJUIigEm6GRjZuzTx4Z5SF4quK3+TaZAWQxOPSOyJH30e8fDk6CyAXOh2EWS3ysCSt3CKAaA8TGtOtoLXJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMdx1TUJFopADpoMdf75trHgFfcSK+T0AkRXPCPcAes=;
 b=cbgND2E2iNYPjJO57KjrpBKY27opdBc0b5azhrO22HNTCeQiVTBIo18B9EFHbN8PJ+zGYWdw97ud3CWV/TIzKhHx1noYO3e27GpNOc5vm6WnWK2qPOfOcXWWrXgKpkoGnTO3cYvnW5HhE9iJs3uldWOFLMD+sgThVJ3psKXTB1beyafLvRNs0eeWGjm1U/Juwg39xsB7REqpf7uoZQREra6l/kcRhTrq0yOVrXU2wfCQsZKcgXF9tOMj4yazytklRwkDJfoBVNCUp5RHEUBCgulDg8WQ2T47+j5Je4dKw45qcLDpGNmxAfTw0+gnFA07rJ+6R/OFACiX1aerYIhWFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMdx1TUJFopADpoMdf75trHgFfcSK+T0AkRXPCPcAes=;
 b=sjwWBMt2gJ2rnQO/Tj3rhP6R1OzLqVb3z4JQzJ0Bww+ElTlQZWj4H4IQxhEyRsR0CNZT2bhMYSQvSCvadX3Eag4eTi+3CiAEl/tIN7aFoI5u//ZVpyWIl4xWir/CZjJRyGjcpDenFWBZ79OiNQ5HDijXC1dewySwJ5KSNhMbjXY=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ2PR04MB8511.namprd04.prod.outlook.com (2603:10b6:a03:4ff::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 01:38:02 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%5]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 01:38:02 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: fix missing rcu locking in error message
 when loading zone info
Thread-Topic: [PATCH] btrfs: zoned: fix missing rcu locking in error message
 when loading zone info
Thread-Index: AQHbFNZvM5Pyn6phG0+j6hPutuiLZLJ0QBaA
Date: Thu, 3 Oct 2024 01:38:01 +0000
Message-ID: <cu4kadew3wrssqf6koyfcnji5r7irhtjecroluxtffbo35l2vj@dztxszdxwdlh>
References:
 <446a65bde464d5a19554687ffd1944bfbf9062ae.1727878321.git.fdmanana@suse.com>
In-Reply-To:
 <446a65bde464d5a19554687ffd1944bfbf9062ae.1727878321.git.fdmanana@suse.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SJ2PR04MB8511:EE_
x-ms-office365-filtering-correlation-id: 6a01c90b-c54e-4bc3-acb0-08dce34c04f1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|27256017;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?S3mYR9D9D9boa/R+lSzhnY2c/KbOifRvdyWo7aMMcMQkm6hp9kiuTtGIG3pT?=
 =?us-ascii?Q?B9iaVN8/LLdowgJru+7K1hChgkeCNr+WlmcMZIALOMV3bMFjsB0480oIW2Aj?=
 =?us-ascii?Q?Nkz4T1B2D7CQBRWiFOpg+iDAsedaGwq9wRJ6AUeFXCbDPPG1UC79rUa1vnfu?=
 =?us-ascii?Q?gPPhhABGawTi8bokuNVLHW32NKlvw5+ThqFTWdZxQK+cI6VDde9J6LtDl1qC?=
 =?us-ascii?Q?L/1RJLNO440twJIgM8WpkmFiJ1VyVAdwmG4kle0HQWebJEGVewxs77n6ItNc?=
 =?us-ascii?Q?L+CTfOTCUt3xQ/A1ZJ3FB2XLkB6YjakXRRbzIv0MGLzTvKUFefXJxELeuSTN?=
 =?us-ascii?Q?fiva7BBTgjy/i8cigL3g/KiPl+GRq9BMSKzmLO8/Y01fS1za8cfZn8DcEoIF?=
 =?us-ascii?Q?6GgEzfdoxjcVCfwba1LTqDWH603WLuuR5GqCHW48co1GqIgEjgInbMOX5qZs?=
 =?us-ascii?Q?KIyTKBEpt8i/KOrvQyE2ogmPUvlMUiqYsO3j6qkIB0+Xxi4a/uC+eCjvuYiu?=
 =?us-ascii?Q?fhsl3QmTkqNZOeiAM3fGgjrK9TZX0bsMJCyM6G6U4mFepgBWEQPfwvq7/qbL?=
 =?us-ascii?Q?kQJ8NoqWE+xTRojSRm35vbLbe48cWeO/9g9zXpBY5pssNNgZk0lVsG0uJa/d?=
 =?us-ascii?Q?ut+4q7CplzvMtvwXFitDp/W81fH/GHdF80n7u3m3acZqhJDkPupLUvTXZIFA?=
 =?us-ascii?Q?wh+86Y0dhflO4GCbtJlzfmkLfSUYHv9JKduOwF9ks09+bVrJaP3GVw2k8ZXK?=
 =?us-ascii?Q?nbYNgISZbMdu3Big9LaAJKvskoxMl1vyY4SXZurCHcbedgAEhcDNC2P5BThj?=
 =?us-ascii?Q?/wO1tyoZt+scMC4qGYkLaEmdunNzrG/3/pNltEGXui2Hs6U6y80Oi2pQTtBG?=
 =?us-ascii?Q?APfDwC5SJfLAZWssAF07VZJwJ3WXhxzoOECpnqL8oIKlth2hPTgRWUM18SFZ?=
 =?us-ascii?Q?xuQYFNTJFpdq2sJTUWK9SyuT7fbrU/a5lvU15EMyQ/Ezf/0kXLKQ19yX+6/5?=
 =?us-ascii?Q?fDkJHgl2uzs7hhEuZGZ/R5sP2QU4YvHVu8Lulda7/6CUBydDBp4+7PAf0XZs?=
 =?us-ascii?Q?6m5GVksCLMYPe9KqGRt2d7fVxOpQlmTLtR+imIRGHy6ITYhSGvCqX2Q/Mnn4?=
 =?us-ascii?Q?UW3DWa0NJqASBYOs1YlVWlLadLouQ9rwEP5SHDHALYo2LmsrlH6/OdbyFyKo?=
 =?us-ascii?Q?3+XZNVXr6Kp4HglZ8A1XIi72zCBkA6rq+Ke/2lsY3f/6ebdqu6eSc5tjV0tJ?=
 =?us-ascii?Q?6NtLxSbbP0n5cMyUULhs9UQyNUfIUumrEpYnAjfCvLlZeeJ8z0UrULW+qORS?=
 =?us-ascii?Q?xDEk0DK0dNaNLWFIjctXpxxibr++yCWB9lqdLZWKES6QtLB9AJI6gXL9/i2r?=
 =?us-ascii?Q?8mtJn+0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(27256017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yTSOVrmQaz3M28jUEQQiqUu+AuACttUGimVNt2CsfzlF1LsUH8vcKeHiH0FR?=
 =?us-ascii?Q?EFpZu5nwKRO73OeJ5FyPjvLWLZFDxF61fAMPS3vAqkeZNaPS8BR8JHhmXKxG?=
 =?us-ascii?Q?Fv4uhO/9xy80W8PdXMhgWeF4kfVmM+u0QF6Oahf/zcyZYgGJyjxpOiDdRNOb?=
 =?us-ascii?Q?NAqh8oT9O4ostJS0yfeQQruqE5zstHIULtknUXSRHLGg+Xn0mWWLpUsUnh2O?=
 =?us-ascii?Q?YNFv8q+1JA03Wsc6szOiGoTBs1FHKKg2K5Jfdx75liUHvkA70EtXh+VkjJvB?=
 =?us-ascii?Q?xL+7PvLjYfq3EtwXE0NPk6poRaCuDgSIBR8WXmgIwF4BshF00uh+eO7WJX4B?=
 =?us-ascii?Q?jeFXAvkksYfdm9JEnd/SR3K+cY5WsKXDDH067AXvznfCTxAwpE/cbJBIVWB7?=
 =?us-ascii?Q?GCmrHND6s8qbcvqEtZwnuzidJxEigV9439qbZAU1G/pP5iYVNWguBUVaFYWh?=
 =?us-ascii?Q?kx0XG9ec81g7TuhbhlkH/FDbg+IM/EeV3yw4RG7M1Tl2WTOAxexpba+kkNG+?=
 =?us-ascii?Q?91k8o1TmOaR7RgSpSeLhIyP+wgQoUsYfEEk3JhTTBuqTabN/zUPruKT9mu88?=
 =?us-ascii?Q?4JKHzT55/7m3tPnOaqT9VqeRHKXa6NMvmCvSr8A2LLh/SecNax13pDHrL2RP?=
 =?us-ascii?Q?USJ7u0HKqxf9YVFSJpGT29778hoSfhsErl341Uc/1Uq8NUAuDmw3C0KzqnzN?=
 =?us-ascii?Q?CyByE598IirDQ0Nl8/91037ZPvFHNyUczHi3ALnk8ECQUZwidUf6LseQwf9+?=
 =?us-ascii?Q?J2ZG/JtxOMK4A+7oZ3KEjBZnMtRIMQP2aZUXq72+bCEl7f2uc8DZLYAbUUe4?=
 =?us-ascii?Q?s9tKds77fWR4KLsq15Xr7zBC2LeZxxTLe3WsKnbvfS+JUk2U+p3Ul3PeU0ya?=
 =?us-ascii?Q?tCHojxVy7JhxmWHno5lY8ECBIRdrlX3inatewkoXn6p2lFY9w7c6eBEQ0OZK?=
 =?us-ascii?Q?W3IS6jgxLexEzEnpQ4Dv1nYixs0BFPmhXi5WmtoN5r6Y328faj64AKORH+wk?=
 =?us-ascii?Q?w3ISH7mGSQfwFxnbFAhleWYti8wcntEeiauRHoTKLsW/YZeDvJj+vXzUMssK?=
 =?us-ascii?Q?ArTa9/PAH+UbY3TqVRYKta76A8lom3I26oIlRgCu3OJj2bwUpJeA6GIRjEBX?=
 =?us-ascii?Q?l4jQxZpK8bi/nkq2FnbWNjBM5Uyzp1bmWp89ycc/FEF6espndMEqg4n0bSX0?=
 =?us-ascii?Q?isnH/S7Wtrn9RetBSjHQn6HxS9CJzus14KNi81zeRjbaLWVLrbZeKA2ISua4?=
 =?us-ascii?Q?gtjECsg0U40F7fCPkbVDVdmuy+wRKf7yPos/SsvYhPKvYaECgHlVkwXiWYUx?=
 =?us-ascii?Q?g5KlnAnx3+EWWzzaoH4D+xjkP40dxGy8tdP+GA4dr5qw6++QwiJBjUVVVzeE?=
 =?us-ascii?Q?wJWtElazGlrHn6SBWcXBgNUtg9//4qnAKpavplMN196iHqwA7+eUcnfOH4Rh?=
 =?us-ascii?Q?ExYyvm8sROw8HW7FGd0TEIwC4nPCdi3Bv5DSlAXVWNqiCXoBZVSyNel6Y5Uh?=
 =?us-ascii?Q?3I5p/yQfpqUDtw68zrD+MDzqDSFuiJaSYjgAkGXkePSKByK+/3TMsvaoZzwF?=
 =?us-ascii?Q?r0aSV1lBtsmAsPg1kaE3k5JL4zHn4XHhUxuiQxnVVmODaQ38k9RyF95Yi1rB?=
 =?us-ascii?Q?+A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1B7CC94167AD0C41B9C7590DB187DFEE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BJwTX3R6G3wYr5M4rsC8AXBopcssGD/h8M0OLOwXDxaNUyKPL5BL7S4aXJX71YkaU1yqu0QxcTgQ/jHmVvKC3YcP8tiq7eqHVxON79DXl6N8Qg82V6MR2IxTEMlIAvvx+ZIupSmPtSCzTKLw8fU942oMtQYoM3+LCuyg6/kbQcjgHKk0v76qp70TIgaWAIOO4nUX3IhG4UpzEuYM3H4wqNQzBNdd+yePfJpyA0LtF42gFGelmUY8YHI+mKhKxrujSytBCbL/DgDnO8dnHn2cmf2gXtAez/JSFIIsP6j6BYVtCga9FBeGam9OSHl0+9GA8v0/eD+WEP7gCXBLIqMKNkWWPuHKq2rZe5Wig2YwfYpHWcoSldGN8eUo14kj0RSQ8jPUeQofZzvbaVk0K6fmBubMkd9XofrijdquWMxrAOrIBHXgBJht+DbsqMnSH6okKTW3VVcUFDAKpnNTa5gGJ1bWQXzXiT5jNQYQ1+9JLIbnFO+4Sur/Hr5gpjKaNwafb07PS8f/8ZAMKC6hRf3pD286VdmGAYJLhw8fIxa3rq+kixtwsbw9AuDpZpaow0/gEfXe62JYBSEgUKcLXcKMsR8Ef6XSD2/VAOaXKv7obdZP92/sVGfMRaWDkyKoTLej
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a01c90b-c54e-4bc3-acb0-08dce34c04f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 01:38:01.9154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qmIn5sVuv1OYv80Re6BiimUSvyqJPcnWsS8R+0qODNbyJ3MlXZuIm+dpGsiTvYiStPyt0Vk7XIx5AQP6Cy0xRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8511

On Wed, Oct 02, 2024 at 03:15:07PM GMT, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> At btrfs_load_zone_info() we have an error path that is dereferecing the
> name of a device which is a RCU string but we are not holding a RCU read
> lock, which is incorrect.
>=20
> Fix this by using btrfs_err_in_rcu() instead of btrfs_err().
>=20
> The problem is there since commit 08e11a3db098 ("btrfs: zoned: load zone'=
s
> allocation offset"), back then at btrfs_load_block_group_zone_info() but
> then later on that code was factored out into the helper
> btrfs_load_zone_info() by commit 09a46725cc84 ("btrfs: zoned: factor out
> per-zone logic from btrfs_load_block_group_zone_info").
>=20
> Fixes: 08e11a3db098 ("btrfs: zoned: load zone's allocation offset")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Thank you catching this.

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>

> ---
>  fs/btrfs/zoned.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 00a016691d8e..dbcbf754d284 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1340,7 +1340,7 @@ static int btrfs_load_zone_info(struct btrfs_fs_inf=
o *fs_info, int zone_idx,
>  	switch (zone.cond) {
>  	case BLK_ZONE_COND_OFFLINE:
>  	case BLK_ZONE_COND_READONLY:
> -		btrfs_err(fs_info,
> +		btrfs_err_in_rcu(fs_info,
>  		"zoned: offline/readonly zone %llu on device %s (devid %llu)",
>  			  (info->physical >> device->zone_info->zone_size_shift),
>  			  rcu_str_deref(device->name), device->devid);
> --=20
> 2.43.0
> =

