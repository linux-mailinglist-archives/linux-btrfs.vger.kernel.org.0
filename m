Return-Path: <linux-btrfs+bounces-5655-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39139903E00
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 15:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DB381C2202A
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 13:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B782517D890;
	Tue, 11 Jun 2024 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cPs9UFX9";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bQszepfQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA17417C221
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2024 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718114062; cv=fail; b=A1ltjhBU81PiFP0dod3Y3WuL4a4BB/BUle6ZCW1APv7fP5XN7PBPLCE25UloUZx4u8LLAVn1DTqFXxq25vkTCcVAAQrJU/iMM3+6bSoywBzFnLitfQduvv3R6FlCr/qIviD5LSNP1rXA04FknEKSJHSJiVWKUmr+6eBRa9yGnD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718114062; c=relaxed/simple;
	bh=3Kf759WW1pwXVVP+8KN0Tz4/0YU2ZGT9NmvLyUo6otg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L2mzFZ0ipa9o3qfK+w5klu4+FgUV3/z62KEPVox5MYTdz6hoM2TpgWhvRCdjI8w8Uu8yupDMpfUWrOj5JTDWd6vKYft6HExwnqqPfRNXKzYJ3loDsDHzKx5shfBgCgfuCRbmTtdlux1+MixtPZNASiWVgZyd/EKHLXSiKdzRuxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cPs9UFX9; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=bQszepfQ; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1718114060; x=1749650060;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3Kf759WW1pwXVVP+8KN0Tz4/0YU2ZGT9NmvLyUo6otg=;
  b=cPs9UFX9lKtm/TxvJBXKJr1fIjGhAxytIC6IRr8suQHUBrbsrX6SYqc1
   +LbkTvCcjE45AsIbpcutgnCH68zW5zV9d5e1Jhdovp3Ih3FT0fb6wwbjB
   ifw7zu3IzMcHiQwr+rYComzbIbqcx0z1EkZaOH4+Mu4YuU+jsj8iHHfFO
   pliQcHSGTgrSxwSZUAsYe7PE2MBGqnklU/GN56EL9fjJQqYCZoLsyf21M
   JSA7HL+GdNJaHrOFKtnP6zppW7OrXA/3iu2QrX1yaUId6NLlfL5M9brkV
   Ol/MTMAcMETdEoKHfO6KCREHiiD467GoL9bywmZWfp7qz8xBCG+jGbRct
   g==;
X-CSE-ConnectionGUID: gClEZsmJRWaL0oNn0aSuBw==
X-CSE-MsgGUID: gf5OTLI1THK0ofLX1oM1og==
X-IronPort-AV: E=Sophos;i="6.08,230,1712592000"; 
   d="scan'208";a="18846477"
Received: from mail-sn1nam02lp2040.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.40])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2024 21:54:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0ZlAF/UICVqxvS4UhK2mjANil6esadPyCOCqzHkASSFkuBf9NTJDzY4rp/pIxuGwBCXVU34u5VRqQK2zV/FuaWtZWgaNuf7aJKupH3t9pyLTxFOvavm34S4FrG2FYTgBOMB32EakOpnnJW5wEui/gPq9zt/Uc9uuFNLyQIMF7OT/VF2QCIzcZ96+lt+i5zIHkbj4muEU81cCDcIkNuhagsONO29nM8+/6NjcC1cdZyyyhjGQH9T/n7QSkN+8X0DZFbiuMx+tz+akZtxUZ0UZHDxid6sUQFa2/khta/JkLVn4F1K/yEd9w6o6LI2lN4RQwi3t6/wKWX6ZLXFFwVyaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufxeiIn95BQv6UL9MCqwra/iWsJljfx6iwZLZYrjoss=;
 b=nMtdFJMHaMBDlvsGS5RT8bw62qMITFfk9XSDtxiMJCbyErICtgceJXcE0SCM4Rpcq6+hWevuoIo0BpNBFu48YidNqfpUOmRcmSN37UU6wGc++oXP4/w/NCEN0+BsVsPo2Ph8bhS2ydscrXvJ0FDabH9KQcmrTsDWyPhdY4BWBcc89WFi1Rw/BaUz3GHbKVZbmT4137GLCOMAc/H1DreNbK/M/tXJbv8zvZa0VTyJjRdpLUvScmiohIz7sfhvgmHPSmbfZ/LaUa2uTdWWUeCzNtaMvo0Sr/kLy+E8KsQTIijlw4pGy8tmd+GPzRe7rXSf04Bb6wi0/B47jwxqDJQLOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufxeiIn95BQv6UL9MCqwra/iWsJljfx6iwZLZYrjoss=;
 b=bQszepfQXqkNNaMDlVkmIP6294QpkMwZgbrQMyDaxseMtGW4d2asE2RTRQINyBYv2p6uFQtbG3+jxrc8Lcu/mkpZ+Cp7FL72ZWaFJ8ipvlUeyqM+byAqbfdLds3zJCN1eTaL2rYAu/FQpKsokbg5Se6f7cJrt2vPYJwRE7B73Xs=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DS1PR04MB9276.namprd04.prod.outlook.com (2603:10b6:8:1ed::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 13:54:10 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%7]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 13:54:10 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <jth@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, David Sterba
	<dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>, Damien Le Moal
	<dlemoal@kernel.org>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: allocate dummy checksums for zoned
 NODATASUM writes
Thread-Topic: [PATCH] btrfs: zoned: allocate dummy checksums for zoned
 NODATASUM writes
Thread-Index: AQHauNBjjKiRsD1Uh0iBDXwy+7C7J7HCnAmA
Date: Tue, 11 Jun 2024 13:54:10 +0000
Message-ID: <62pms6ujnfrkhqfrn33lpkuv6gubz3gsiuy5ncinasgls7z4qc@xzyihuqztsma>
References: <20240607114628.5471-1-jth@kernel.org>
In-Reply-To: <20240607114628.5471-1-jth@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DS1PR04MB9276:EE_
x-ms-office365-filtering-correlation-id: f707d895-2fb3-43af-a0fb-08dc8a1df845
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?csEJ4KeM3mZR86djbZjJqkVKOrbaxEjas9qCjQNz7gwf1ObQtbcw3z5zLzjR?=
 =?us-ascii?Q?vqS/5hoy5/TftbVd1VBhYCwXAY4JdAUrUltwSwZg+z7GTV1LEJo5l3J2M0LI?=
 =?us-ascii?Q?PEqCCF5wBbzmgY7mlvDiPUkPdkkBb/bGzJeVzoN8xLx008qmeqS7Oqzv1NS5?=
 =?us-ascii?Q?pMeMbxj1b3x8jeA9nXeIYFRQK0bt+WLngmoh8ySQpte0OZloOcSCVAPqnh6X?=
 =?us-ascii?Q?duCpm731eJjw2lFaf9+FU+/lvFqhHQ10y9dqNYp/otjuV7gIySOfZz/SCLpD?=
 =?us-ascii?Q?69IaTtfckx+yjEq2FBIWbsxYeX6m6/yZp2oKJWzKs/4dmH75/IxT03HPalp1?=
 =?us-ascii?Q?CXtgavCUdPwSCzygM9CkTDHRwbqryboHXvumgbVbyPGL8QUJsOgmHXgehyKD?=
 =?us-ascii?Q?sq4c0dMDNxRyorSvlc3U6Oa+1P5ZE7fo6YCYu6cy4HHJni/f+PlwaXvUzI10?=
 =?us-ascii?Q?38gPo+BrF9/xGnKZ+tQM3rhuZJSB9PI9Xdx0HbGyMYdv2wGRAn3YKNEGnwwm?=
 =?us-ascii?Q?SOem0fiIu3h5iWNit2tIz0nkhqi5gmus3CFPKg1drVZ+TA8v3uveSjd+1lzi?=
 =?us-ascii?Q?H6WmFi3QvsFk5GSZ3R/9ODdfrA3A1VuQ56Yw4U1eClaEiTPL5G5BoLcmybQ2?=
 =?us-ascii?Q?kSdWKWCaHOocI2db7DvXjbSyQZ9P12/08i67C4eZr6FHLgclHej0ovNO7iJG?=
 =?us-ascii?Q?yYdvml+AV5D2UooYhEVvij0XzitafDXhpc5PxysPNf8KI8kogjWxer0PCce2?=
 =?us-ascii?Q?oPVIOLp0bBtQUu4nEWYh7iwi42NWvoS3laee0/YFYm1wYhqIaYx5WKwH2dUQ?=
 =?us-ascii?Q?x1Xs0yzesyzCGZtJljgj1ypOrranwtcdgbtGWtLgV2wpQexTmT/e9ucKLc9C?=
 =?us-ascii?Q?xzibU7A1I+FlMRQPzcie+rBIphRt07r6A7Tw6X9sYWnrHRZguuI9HEski6tb?=
 =?us-ascii?Q?e2+1JwpXQ/1mu0voZkElFQz2P2evc1qdWVD6KUCewoyBkt5VS34fH758a3SB?=
 =?us-ascii?Q?BFpebVDXJ8VPJsptHJlW8GCYGyxM4SlLD9SRLQ5iM5JFpazMv6iwKn9rI/vV?=
 =?us-ascii?Q?wG1muijEva/f0+UeTLjCLnou7FKbGXVaTk4MYxVk+Ov0qoBQz8ITHrlHNZ9Y?=
 =?us-ascii?Q?XGNbv8vGPSGhtAb5mrhL4yEmdLoTk75MJDTSxJLPHAWqNb5MmWa4Omx/MoOB?=
 =?us-ascii?Q?62rL1iRAOmQm8clSgC7UM1CKFwCq00MYHFZVDL+RZIyOhNq0Pobmpuksq57Z?=
 =?us-ascii?Q?OuKqiKb6IoDnyeH6K9WyQXo61uHKExwe8nXwdmt/ybFkz4N8ITAXM4eSradw?=
 =?us-ascii?Q?rzWA+jabRGDOBVpZB/Cl4fHXnpuE6I8FPBNqzkXzJdt7IIg/Rt6B7F9QPypH?=
 =?us-ascii?Q?728wdVw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?z8ihlhnE9T+n0h9bKh20rqi/PtpagjgY1upN5JP3XqnuU4kkXTehQ8qhDg96?=
 =?us-ascii?Q?6GQM3whRI57Wr+ra218BO287z3b6kJ3sG4izNNohs3IgvreEBx7gLe+0k20x?=
 =?us-ascii?Q?3fowLzhax3E2IQ1xEv0mOb9ObU55maEaB1Fo8ZlshuQ5Ue7glZVMEEVVFnxF?=
 =?us-ascii?Q?tbFWsX3Vjdw+xwR4pFC7O0PUH9O7Yn0RelNu8f90JxNrK+OPAa3sQ4iQ4GYu?=
 =?us-ascii?Q?BxgAROLLtijwTHXp/QCs1qcx1o9O2Gg8mQ/Krl2Roig3F4WL2oGWpmKJgouv?=
 =?us-ascii?Q?o1bx3QRFvdDw5SjWIe6Hv/zibi52eR3ALDnPTes2fPHr+rn3dRlzvp/f+WBL?=
 =?us-ascii?Q?y+jF5kXHPxo8sEKBC6CQ5LikaEjGKjo29StbbrnKbUPP31nH6lszC+NGltwL?=
 =?us-ascii?Q?LPN3eD7cAd6bi79xh4ANjIZkCkm6JBTMTpLnz47ofzsWh5x3nxOzdWHFUeSa?=
 =?us-ascii?Q?w+2vT984KIOku/R5qQKdZci5CkfHb/VSIWvL4jaLC9nhSdCkCAMMQaMDC+mW?=
 =?us-ascii?Q?gDzwilIWUxmBBy+xcD41QHM3GHuv1zoPhbBUdGmSxjWui30i8LdCe2gx6Pyb?=
 =?us-ascii?Q?fNLk3n4CHB0FaK4s3xoEgm8GZUFZrjWvf+twoRvTqLXo45zDadPV1FAdqgzg?=
 =?us-ascii?Q?2yGTZmeIV1xsBNyyIWyXwQt7F/QR1ntjzGrz/EMSyM3ggdenF2Ofna6iTIER?=
 =?us-ascii?Q?k4p2hChW3uT+P0aF/ACeD1b7zBbOHVZQz2uNjS21ox2P78xqQAFSwJ82QUB3?=
 =?us-ascii?Q?VIGiwBC29mG4mgKwgwsAUtpX4XGUM6wM9rdL5ycZkzRCp3LnfpDy3YGLId6n?=
 =?us-ascii?Q?09zUe17IvO/J/rNNpuzaM8RQ7x0saRfl8BwE7qyTrf77SQkop0RwcgHLNWIt?=
 =?us-ascii?Q?H3OPUTeQNDpgu7IQWmcjbDOokC6znTQLNl4ZCRQ8VwvEvh//UYapTrae3gnV?=
 =?us-ascii?Q?H6rm+W6oxtgBVkoOZrDlpANSb6LNqEcz2BjUUEcXp93JcTu3zCTCTYPtcUTl?=
 =?us-ascii?Q?3sc34yMG5HL0IoJQRu1yuT1aN3082Jg2HApz4a3dK5vFsvONUxZZoohzDPpU?=
 =?us-ascii?Q?WS/5pqyJLS0Uu7X2xlkgNl0W17stNR6+Ptlx9rjDB7pDWspowaUtwmQnYdfg?=
 =?us-ascii?Q?jv1RfepOUgQYzJs+7qCTjb8Zdhao99CW2NvvewWxOpOY4iNctdi9rBSPpXpE?=
 =?us-ascii?Q?4vcgzCC8UZSwMcMF5q9xwg2WpnL5bJRtbDkdfeYj1pxZswHPZTmqCHsxw5sc?=
 =?us-ascii?Q?S+KV9E+f7Xhq5n+gsrVCwH2hRExThNAhj3y3QmdvLF35LWxe9Eo7cRqN7rwz?=
 =?us-ascii?Q?/8lpbcGzPpTD9kC3rg/wtl6rQ0PJwv411p5T6o2rqtrE7UApXSBE0UZ+ZXC7?=
 =?us-ascii?Q?SE4b581ZcE1GlKZ5kbTk5LIx+ZQ9MDdignmueFgn4L1Lb2eQrpbWT6HWxD9w?=
 =?us-ascii?Q?z85o+hZDvxVPKMrMHxcB1eyQii6sBtB4wUCe2wqSlghqzNXzN7K6WPJdmd8H?=
 =?us-ascii?Q?zxeUx/FzzWnE2qf2O2yXK9vckQhTpyT9HXZoxUAlADxci1C8HwHkIc5/BcR1?=
 =?us-ascii?Q?Ow9DGCulMWOHpj+A/7siSVdSN1EYdZrGuwJdmAMFtmZR6HW+x86nkGTtmihm?=
 =?us-ascii?Q?uA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4545C6748F26AD49A1B071B83ED718B0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fEEj8ITVzYv8kY0cavhq6jYY+wSLeVxvlbFv5fCA7AnIBNaqqgLhtP4+BKvwKSOFlMqi6q3GNyhU37p+TUECbcIgOE8IuwTxHHYE96njV1NnWevDIxsibkAguWSpHR/tSb9DL+LS4b7rmfwl3YJmvmIjKnE0dML5aK3hVlKx3WlrtF+llAwpkYOdAo//Cu6qp19rpz4nz2z8KsFtMUbqkxofqFJI8+VVvdcemh0WuQ108trqelNvw5BNUMMkAOyv0/e3zdDkjNC9Oh9gDy8Rs94Phe5kh438DhQNNsJnpMtal7cxiL0KqhGCJ4yBaTDeJFN6/pSullCZqusxqKR6RYiVokNissqVmDyPJPjF1mpB1BU6Ko1y57iMTEVhR5M5Xex+7MSJrMxlywCEFoVMKGwEibxGaleklJCejdjFIbR5sfWLQZcLrW0M3ebLGxjt5VA4n4SWeUu118WiL606XkuzNW5TeNrW7QykpU0irLplePI3PmAW139bWP42w/e//ggY2kjCHyZ9jSQQDEJKD2xOTmmwOmcZxY7I75t9q6mPxy48adWSvGWYdXN4t/gTb9UbE47aOJul9wsD57vA+tC6DLC0Q+7PM8zDpSl1tGqdqTbZbFPMS0R9qBi/ECmv
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f707d895-2fb3-43af-a0fb-08dc8a1df845
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 13:54:10.3353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lu5ill118Nd9saBB/rl2UsM8GW4XY85cShtHf0bhnj92AQPBl6WW4S0LHffB/FTuCIvIgaKXmIS4TTrrCnvAlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9276

On Fri, Jun 07, 2024 at 01:46:28PM GMT, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>=20
> Shin'ichiro reported that when he's running fstests' test-case
> btrfs/167 on emulated zoned devices, he's seeing the following NULL
> pointer dereference in 'btrfs_zone_finish_endio()':
>=20
>  Oops: general protection fault, probably for non-canonical address 0xdff=
ffc0000000011: 0000 [#1] PREEMPT SMP KASAN NOPTI
>  KASAN: null-ptr-deref in range [0x0000000000000088-0x000000000000008f]
>  CPU: 4 PID: 2332440 Comm: kworker/u80:15 Tainted: G        W          6.=
10.0-rc2-kts+ #4
>  Hardware name: Supermicro Super Server/X11SPi-TF, BIOS 3.3 02/21/2020
>  Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
>  RIP: 0010:btrfs_zone_finish_endio.part.0+0x34/0x160 [btrfs]
>=20
>  RSP: 0018:ffff88867f107a90 EFLAGS: 00010206
>  RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff893e5534
>  RDX: 0000000000000011 RSI: 0000000000000004 RDI: 0000000000000088
>  RBP: 0000000000000002 R08: 0000000000000001 R09: ffffed1081696028
>  R10: ffff88840b4b0143 R11: ffff88834dfff600 R12: ffff88840b4b0000
>  R13: 0000000000020000 R14: 0000000000000000 R15: ffff888530ad5210
>  FS:  0000000000000000(0000) GS:ffff888e3f800000(0000) knlGS:000000000000=
0000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007f87223fff38 CR3: 00000007a7c6a002 CR4: 00000000007706f0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  PKRU: 55555554
>  Call Trace:
>   <TASK>
>   ? __die_body.cold+0x19/0x27
>   ? die_addr+0x46/0x70
>   ? exc_general_protection+0x14f/0x250
>   ? asm_exc_general_protection+0x26/0x30
>   ? do_raw_read_unlock+0x44/0x70
>   ? btrfs_zone_finish_endio.part.0+0x34/0x160 [btrfs]
>   btrfs_finish_one_ordered+0x5d9/0x19a0 [btrfs]
>   ? __pfx_lock_release+0x10/0x10
>   ? do_raw_write_lock+0x90/0x260
>   ? __pfx_do_raw_write_lock+0x10/0x10
>   ? __pfx_btrfs_finish_one_ordered+0x10/0x10 [btrfs]
>   ? _raw_write_unlock+0x23/0x40
>   ? btrfs_finish_ordered_zoned+0x5a9/0x850 [btrfs]
>   ? lock_acquire+0x435/0x500
>   btrfs_work_helper+0x1b1/0xa70 [btrfs]
>   ? __schedule+0x10a8/0x60b0
>   ? __pfx___might_resched+0x10/0x10
>   process_one_work+0x862/0x1410
>   ? __pfx_lock_acquire+0x10/0x10
>   ? __pfx_process_one_work+0x10/0x10
>   ? assign_work+0x16c/0x240
>   worker_thread+0x5e6/0x1010
>   ? __pfx_worker_thread+0x10/0x10
>   kthread+0x2c3/0x3a0
>   ? trace_irq_enable.constprop.0+0xce/0x110
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x31/0x70
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
>=20
>  ---[ end trace 0000000000000000 ]---
>=20
> Enabling CONFIG_BTRFS_ASSERT revealed the following assertion to
> trigger:
>=20
>  assertion failed: !list_empty(&ordered->list), in fs/btrfs/zoned.c:1815
>=20
> This indicates, that we're missing the checksums list on the
> ordered_extent. As btrfs/167 is doing a NOCOW write this is to be
> expected.
>=20
> Further analysis with drgn confirmed the assumption:
>=20
>  >>> inode =3D prog.crashed_thread().stack_trace()[11]['ordered'].inode
>  >>> btrfs_inode =3D drgn.container_of(inode, "struct btrfs_inode", \
> 					"vfs_inode")
>  >>> print(btrfs_inode.flags)
>  (u32)1
>=20
> As zoned emulation mode simulates conventional zones on regular
> devices, we cannot use zone-append for writing. But we're only
> attaching dummy checksums if we're doing a zone-append write.
>=20
> So for NOCOW zoned data writes on conventional zones, also attach a
> dummy checksum.
>=20
> Fixes: cbfce4c7fbde ("btrfs: optimize the logical to physical mapping for=
 zoned writes")
> Cc: Naohiro Aota <Naohiro.Aota@wdc.com>
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks good to me.

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>

Thanks,=

