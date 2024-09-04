Return-Path: <linux-btrfs+bounces-7807-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D4696AFC6
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 06:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5537FB232B0
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 04:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489548121B;
	Wed,  4 Sep 2024 04:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BABpEqGN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="u1W9Y+cU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2227343152
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Sep 2024 04:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725423911; cv=fail; b=geLvbNXnCzTcMkvjvp4y/fqDKMAbc/qRUireCvkbN0UuNC/PcGu8j2wn8qkKHs22tAQBhQxpklJvxtVSb3V3S7uYgEP7yb3gF/qss1JiPi+VkD32tJKutd6Hs+tGW4bGq+lb1/6ftsap5PxRr2XBzJqK35TXXDPvkA6QJbGQJZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725423911; c=relaxed/simple;
	bh=s3o8NmTPpGf9VE2xkl950yNTPl6XZo/vi2hFPsqgEEs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MSc9uUWU6SpbwZYLtQ1b/ssznSDuvWv3yuzY6cjh52Fdg/DiXYkx5KWy06Wg80LML5fbukQx7rpJ8ALX2GRcArhPz2PLWGXR974qPd9jCV4UpH8gkIcCABzziKY3Vs0HP3sANBC98flwQWW8VgczE57SZFFnuuP0Zlz6TIfhv4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BABpEqGN; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=u1W9Y+cU; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725423908; x=1756959908;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=s3o8NmTPpGf9VE2xkl950yNTPl6XZo/vi2hFPsqgEEs=;
  b=BABpEqGNZtBtcyrXr8wCPig7AWSFX54ypJ+vX+ZGw6bIsP1rFu+TSkdM
   tE8JmXh5EWMZlmzxCACgVzhrmeKyA6pugL9poMq1lSdRvWDlOV5e/93jv
   wUKzOFLioE8E8dhIOrJDfknHR2+LWz56CIudye0Jbqnh0S93U7TxHFN7I
   b9m6A3uwmaJ6EJLHa2fk3HngV1mLiwGJZj0waQuR5/G+yNK7OSBnOlpWY
   PVi6YtyW7K4duxo1d3eqOIBu9/mxIyQqUTD4uJ4qgBuj1mh/mYPAkAUWZ
   Iioy1lyiLdgzBBbamOP+zuyxIlV2wjIOPNjLG5KW/WoFNZvf8D3ZjoKmR
   A==;
X-CSE-ConnectionGUID: A5q8WvNUTg65gSzJR8YpfA==
X-CSE-MsgGUID: 82x5e33jTLSRIXJsndokTg==
X-IronPort-AV: E=Sophos;i="6.10,200,1719849600"; 
   d="scan'208";a="25898013"
Received: from mail-eastusazlp17010004.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([40.93.11.4])
  by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2024 12:25:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ujpz6ZYWwPru8NlVcZXIOBCwwvIYkOIDAw+yUxS9wCXA7Za2ujndTeTLs8GGxEMZYvPRRYZMAYn+RctcduD6xB89rhc+NT6KBcVAXlwd5/iusykGs13cx2k0uEs1X4229FO+IV74JrKH0QVkcRLZylR81HJ7v3bR3+hSbzXJickN8ccDR5kPqZ3otfuLpc4Qk7oQQsVDGQvDDe4K6rc9qUfF3WomBzaOZWft1l25+8pE4rklTC4NKKE1jElB48sKGHskXfwBTOXp38lIp/fJRxlzmnG6nGeEWqiVOho3DDpA7env74wNNrmiiGH3bX/AIduuqcHNkedac2zNFgCVHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2V/qdavF1zwMTtsYRvZl0jhHGjwq/jJWSauSSKQZoO0=;
 b=UwZHIffJ1yfkaOenvZAyv0n8X/Kk4wb1ebVMhATmrqrhomx7SOY+oV5EqGASROjuiEyT5mGAST+BIbPWxQEvIN/+otzn6qD2F/SoEPjF8Enj9Y2jbrPMqdlRZMXu9cPsiOXDeczr5iUjC0mAinibjPcA67QmK52szVo3hxiF3XvJxJpDwKP69d0SJh8opFqpnI84vHAEXrnF+ntwk8P6Qf8DXeTErVRtgQAjkT1zbCZGhPh3E0ctASRuZiKy/DN6oRRe4X2pFYyVVy70VdNnbPL0bwSX474nBvmKSY9n9gh8jOc3bGbPP5hrI0FBPSA1NQjoB7bg5KXkLXYLo5TCPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2V/qdavF1zwMTtsYRvZl0jhHGjwq/jJWSauSSKQZoO0=;
 b=u1W9Y+cUvZrWSKJS8ivhVzIDn7J/UzPoDLfSOSs7Nedie37IxKshohPE5uF+WuRfnE+50fVj8vxgA56jk+9e6xEXfCUjxjktab+T3x5NSkW821n2za1RvzcEIf+6F6Tj0Qghhujw8mpexNPGKgNcjzAdKQIrciPTQTlhwoVo2f4=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CH3PR04MB8925.namprd04.prod.outlook.com (2603:10b6:610:1a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 04:24:59 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%6]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 04:24:59 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: David Sterba <dsterba@suse.cz>, Xuefer <xuefer@gmail.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: is conventional zones used for metadata?
Thread-Topic: is conventional zones used for metadata?
Thread-Index: AQHa/U3SVQcIEt+pC0CywxJb2n3ZCbJE6qGAgACPjwCAAPqRgIAAUJKAgABE3YA=
Date: Wed, 4 Sep 2024 04:24:59 +0000
Message-ID: <x6vz4bobmfztr47djm7tpxqyynuxriimwv3qkva6web52lpboz@gfhsysk65rn2>
References:
 <CAMs-qv_QuHCA2pU4w4fiQbqnvo2PikmhM=AE+YrNzLsKxQ149w@mail.gmail.com>
 <20240902195929.GA26776@twin.jikos.cz>
 <CAMs-qv99kdgrWeqN+piJpDSnWRCGT2adqka2eTUnjk09WphHQg@mail.gmail.com>
 <20240903193007.GJ26776@twin.jikos.cz>
 <p3uy5u6mcxz2thyrazvkm2sxcc3qpbwweqw7vept3aeh6tkmbs@2kpxtze7cx53>
In-Reply-To: <p3uy5u6mcxz2thyrazvkm2sxcc3qpbwweqw7vept3aeh6tkmbs@2kpxtze7cx53>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|CH3PR04MB8925:EE_
x-ms-office365-filtering-correlation-id: 19220d9c-6f6f-47f8-d9b6-08dccc9989c0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4EUrfKD58z12QfgsL+If7mBiOjcdznFjBhy0b0nVEjLGRTcHweNP9IimqYGv?=
 =?us-ascii?Q?OGxG8aupMMg0Eo83bU8rT3e+FM4GDBeu3QQZvwUo56orDelVShGzfxhXjteW?=
 =?us-ascii?Q?52rphYImPSaiUay4kRKpgs9PqgDePm9ESRApBrzxwGu6qa5OhbjpqSE6VCI1?=
 =?us-ascii?Q?m70e88w/GSVC9qTnzWU6zAE1Dr5oFPxw/vHGkxfZ+D/34cdcOWPvIdJAQ5It?=
 =?us-ascii?Q?DyfFLSC7frMxMwXRN11U1YTUMjn4Bcy5hJrjkstI/nqgF7cPN4pGYdPx5Ysz?=
 =?us-ascii?Q?16gtZdjvChBNbxz5OSqrRJhKkQrkQ9UfBTn24cy6nAGFPfvOCSioDQckSzop?=
 =?us-ascii?Q?m0RcUjA/8/WVtkxMFWm4oqsoP+ka7YgrcZ1exMgzxB9RI5PLI9sgiVc/haG9?=
 =?us-ascii?Q?S/AiYmguzJmKIPd5tXM01W4l2FRyu/Tb/YFrZbi5ZmG2QDzQvmd1UQYu43OM?=
 =?us-ascii?Q?uyRqgn134bm0rYRvqP1W3KvgOOAji/jB8WlFTTsmc8sG/YDfh0Mho/A6EjSh?=
 =?us-ascii?Q?IEw3Hb9FwB2xPKKu+0iaMAym/CIrigTurhMH3gavPr7/B5urPrSjyy1K/WV4?=
 =?us-ascii?Q?96cTW12acLpMnAX5SlTJanqG2r7J3sFb2ywI+pJxAD7ZMjZHpAZbqZ6fWyIP?=
 =?us-ascii?Q?yKO+HeaP+5yfIy90qVLbIKQ489JLge0GNDU8jeS+VMnvwdZ2rqn6rEaFiVjE?=
 =?us-ascii?Q?+euSmIRw1E1BzH5bQmolyCNbjvRjFPT3goYxJV+ODU8DE+vGc1mdRdodKGVI?=
 =?us-ascii?Q?ypSieN6lkoHTFpJXjcqheFfm0ZB4oaxJZ5Plq9ckGv9fj624pPeArg838vjT?=
 =?us-ascii?Q?2OTWd6xVHywDGk3rdxVhnH13GchQ46j7LVjxRei/GS1ibCStyV1UQck+paLC?=
 =?us-ascii?Q?3UjI6Wc6NEFHsM/BXbPXa890fUvreRhkLvsxm+Q26IaMoD4YziArrtGIv8Bj?=
 =?us-ascii?Q?g7IqwNYGsej6uFlncsUiW1xthbmxwSYEwmyFP+mWL/3gTXAAR7zAMZdlB4O+?=
 =?us-ascii?Q?bpQ0D7wbZEcL1/sr6rHzO++YI5KCcUajBORsY7dpqGlDjvyieKeEFlLoK5Fy?=
 =?us-ascii?Q?pzvAseH41xhFLsvF399Uimhp2F/sdDQleIRsV0dDFdR4M9EaSULBzcQWgsZt?=
 =?us-ascii?Q?clRm3ZeLrQJpfEJsmABo9Y7eI2lO7gMlIB8S9FHb86fBsHgkXn2ERF59Y3Le?=
 =?us-ascii?Q?8+RKbiq1EDQbpgwwr6Z8cZNcx/1DGwSdENMlJUwCxja6GBEICy0UGPvND9Av?=
 =?us-ascii?Q?wtVq61jj79n760tadsKgV3Ezw8okAs2VmibVP2MDSoqlGrbjvFf8E4FTKg0P?=
 =?us-ascii?Q?oZ+Uw+/wcR2DykVIOcswopn3HLzfjjHhUS44ZTcsuJPPXsQLbBBS6X7ahUTs?=
 =?us-ascii?Q?sF/BWIAjt421sU+o3H/q//xZXjiDF+jQlWJ4o1tajlTZGpx3XQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4Fo9ffwaUuTnrgR9DySnZVUJYj6qyHB6OmfdTM9E+X0Px5ukvX4efEbqhMuZ?=
 =?us-ascii?Q?x+Gm/yysAQ3CubDVkMqspCz80uAkfC3jUXkk9KEsb2fwYzk6e34loWtNPXYf?=
 =?us-ascii?Q?7Bom+spIFphpXMjXdZDp1SLSYwh/j36S2FkjtwGFtzpT34Heu8U7kJAuqFKg?=
 =?us-ascii?Q?RQFV4POY7c2H8sPUPeKfxM7b65xm6XVY5wH9OB/Lxni3LFVWD74C0fwEwDvQ?=
 =?us-ascii?Q?s5syaQlj5AN72q+NaxNH48Z4kdNOPpFvwHMMzfUGypRtpKtwKeFgrbHYmf2y?=
 =?us-ascii?Q?IMaM/hKJWgmkYojl9Aw4dLHAGQnorQ8rbGp7+nca0+mjBbvSH4Yg7YXF9pZv?=
 =?us-ascii?Q?6+85UqMryOoD+Eq/RIm4ieU1Yr5+YWRwXO7vkf/rm3rxd7P1scI5SrKLS6VQ?=
 =?us-ascii?Q?2pv1MfojwXZ/PCB0ViyaWj81qQF3LuWqXoqrDep71oVeImyBhuKfyA531+mx?=
 =?us-ascii?Q?B+iBOIUia3eCpBT2xIivztBbsApoOz58Ioiy4nqhfmb6ybqgAuMPF6Be9ARy?=
 =?us-ascii?Q?fJecNwnKE3JS8uBSqpoDeHuTJXE6BBVxz3jKjog2hyvphn9UMedNOS9VpxiU?=
 =?us-ascii?Q?myDgsrHR80lM1eYTbJtb1rx5UZwqqxL724b1HSuLgUpACwFwhbJmEbDes5hG?=
 =?us-ascii?Q?PYveKjq6UbqgaSyTW0GGePAapjg1/WToc1lnb2ZUbRvZE2A3LS5kdSs72KSZ?=
 =?us-ascii?Q?lGur126CNvnmBM1OVsiocl7myX5OlYsRsaMOrcoDuGiSgy4SVuVct5aoAray?=
 =?us-ascii?Q?9CuV8TWx2U4eimQAD6gIm/beBHOz6eAxOo8NzKS4s6853pp5ps3ysgSXfs9v?=
 =?us-ascii?Q?zEdT+LTN3XbzE537khyi96V0e7q05H7DUc8jp5RvVpPmPGqJ6aMgoabe5DXF?=
 =?us-ascii?Q?OVeyp5D0K6OsG19YRuWm+WRIW68YpRdnnoG9g6ow0/sS/xNuGqeClliHqhXw?=
 =?us-ascii?Q?M8HQHgt9WZSuwRmEWcNKHppoewWKjxFMfYGPIa0AjHUalf6mk8n0uFzVtIJP?=
 =?us-ascii?Q?+SIb2D7VthuoWizXMkA2F6o8HeYGNShcx60o6LmKYqmQnux76ph41PElaz+X?=
 =?us-ascii?Q?tX9nduwnmB3n2O34gBkuJ0VUEmA7iit8TPFozC7sijqrB6e63hq/aYltptf/?=
 =?us-ascii?Q?5eCSFOXjcxM+jRIg0CL7dY5x0b7G+CoeCJeDPS6QwUCx+aBCfXFcEQqdKvmm?=
 =?us-ascii?Q?yEJFvSwP9LNqVs1WB6TWODC7y0qfyAEY7iQycVUeQ699cvypQMOE8VCsYOoZ?=
 =?us-ascii?Q?TXIVqqA1DLKxzVbAjc7NpNo0yOxw/jZw3jm2peTscLWC31hujcnv2hSYI73m?=
 =?us-ascii?Q?AYV3kZx+pfck26L8SBTu0gLkZAL+uyzXRzzDae6DVZtaRAW6CVorWWTSZpel?=
 =?us-ascii?Q?eVOO0CarAQtnbIo1w78OwMl5flALNyRbS/u/2PUs+7dcVMf4RS9oQUf8VJwh?=
 =?us-ascii?Q?+UrCQ0DWPr/WBKwfVFUETRUKn6Tc7DiuvCZOucSLeONtXnG8OWOZlJlhVK8S?=
 =?us-ascii?Q?Y6duMzqJEKOP2HltoyDX4NyN/htfNkKx4+js5YYtEpf4rPl9T6u2peb36ngI?=
 =?us-ascii?Q?JKoVm6HCwhwrFwZKdCHcuEco9MfLINDgCRXW6l09?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4BCDB6D433905B4E9B31F79CEDE331E3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0bDlJCbz74LPbcDZRn7dda4h8p5yIqXU8i/i38efZrW2ingyd6LkWxXIESgSf7GFydQc8IdunG52GGC5lTS3o2FJMa3lt9+ysqWwMzmgkWj59uSuAxiWNCVklrJw6ybaReUPAX92Cu7qTo7t8PIwBnEaz9snjg18UeIcybaCTvhc+J+6szwyhkdL5W1jwp6TtBLlPFlKhrvNbrVLTBvMeH+Qnr8W0JTTMhYNRN5hnmfA8RUs+JwJf+G9XSEpXTXJI3LKpX+4rVL1un9DNq9WEBBoN7N8Mea8crrju/qUT0JhG+S5A94CvcRWvFEyQbW75VoSibxUeEVX9Z5X6wL+xQ8JbDRtTG+j1PcQliR0Xs6lZajx11AtvhMDsR7ygjbviYQ3ZsJYoL/IwJDi8t+7OuI+d9ERv8MIFBjoSvM/k7RMdkrgpZSroqfV9Imirn42RmOIMv/tzxH7vzikeUhwfjE2Fkd6FAHpb/5BSpyicpd/O0vj+CRtY73iihwL+xt1XKOl4wov77M3LoqJDa/E8jQ0VYPaA+bBx5g+j3Kj/A9eY8F55IIq5b9sUe7NArCsUIC/D4ccFymF0nHx4y9dTDhOVPmps/QmTAHsKCCxUxCwrcAuUQfAm0UdhwkhvwHd
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19220d9c-6f6f-47f8-d9b6-08dccc9989c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 04:24:59.2686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Xe+bEApu6nAdEpYqZznZ9ZMcmT+RviBVbxa4rch8r17tp/4jB7Y6EEIyrD3ZIlKjGXFmMpML3BAHY/5jbX1hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8925

On Wed, Sep 04, 2024 at 12:19:23AM GMT, Naohiro Aota wrote:
> On Tue, Sep 03, 2024 at 09:30:07PM GMT, David Sterba wrote:
> > On Tue, Sep 03, 2024 at 12:33:18PM +0800, Xuefer wrote:
> > > Thanks, that explains a lot for what I saw happen and what I read
> > > about emulated write pointer.
> > > about "intermediate step", it may be true for compatibility and
> > > migration, but conventional zones are IMHO really good for metadata.
> >=20
> > Agreed and it could be implemented, but the question is if it's worth
> > given the number of existing devices.
> >=20
> > > regardless of the idea bout advantage, there's a bug about convention=
al zones
> > >=20
> > > sdd 3:0:0:0    disk ATA      HGST HSH721414ALE6M0   L4GMT10B VFGH8XBD
> > >       sata
> > > strace -f mkfs.btrfs -O zoned,raid-stripe-tree -L bak /dev/sdd -f
> > > ......
> > > [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
> > > [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
> > > [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
> > > [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
> > > [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
> > > [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
> > > [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
> > > [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
> > > [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
> > > [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
> > > [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
> > > [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
> > > [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
> > > [pid 12871] munmap(0x7ffff71d3000, 266240) =3D 0
> > > [pid 12871] ioctl(3, BLKDISCARD, [0, 268435456]) =3D -1 EOPNOTSUPP
> > > (Operation not supported)
> > > [pid 12871] ioctl(3, BLKDISCARD, [268435456, 268435456]) =3D -1
> > > EOPNOTSUPP (Operation not supported)
> > > [pid 12871] ioctl(3, BLKDISCARD, [536870912, 268435456]) =3D -1
> > > EOPNOTSUPP (Operation not supported)
> > > [pid 12871] ioctl(3, BLKDISCARD, [805306368, 268435456]) =3D -1
> > > EOPNOTSUPP (Operation not supported)
> > > [pid 12871] ioctl(3, BLKDISCARD, [1073741824, 268435456]) =3D -1
> > > EOPNOTSUPP (Operation not supported)
> > > [pid 12871] ioctl(3, BLKDISCARD, [1342177280, 268435456]) =3D -1
> > > EOPNOTSUPP (Operation not supported)
> > > [pid 12871] ioctl(3, BLKDISCARD, [1610612736, 268435456]) =3D -1
> > > EOPNOTSUPP (Operation not supported)
> > > [pid 12871] ioctl(3, BLKDISCARD, [1879048192, 268435456]) =3D -1
> > > EOPNOTSUPP (Operation not supported)
> > > [pid 12871] ioctl(3, BLKDISCARD, [2147483648, 268435456]) =3D -1
> > > EOPNOTSUPP (Operation not supported)
> > > [pid 12871] ioctl(3, BLKDISCARD, [2415919104, 268435456]) =3D -1
> > > EOPNOTSUPP (Operation not supported)
> > > [pid 12871] ioctl(3, BLKDISCARD, [2684354560, 268435456]) =3D -1
> > > EOPNOTSUPP (Operation not supported)
> > > [pid 12871] ioctl(3, BLKDISCARD, [2952790016, 268435456]) =3D -1
> > > EOPNOTSUPP (Operation not supported)
> > > [pid 12871] ioctl(3, BLKDISCARD, [3221225472, 268435456]) =3D -1
> > > EOPNOTSUPP (Operation not supported)
> > >=20
> > > BLKDISCARD is not supported for conventional zones on my disk. I'm
> > > afraid the emulated pointer is not reset to 0 as intended
> > > https://bugzilla.kernel.org/show_bug.cgi?id=3D219170 this bug may als=
o
> > > be related. the ending result were the same: failed to clean btrfs
> > > signature on "btrfs device delete" which sit on conventional zones
>=20
> This is, at least partly, intended behavior. While conventional zones on =
a
> HDD does not support discard, conventional zones on other type device may
> support discard. So, we need to try to issue BLKDISCARD. EOPNOTSUPP is ju=
st
> ignored.
>=20
> Also, the emulated pointer is calculated from the extent information
> (extent tree) of btrfs. The pointer is placed at the end of the last livi=
ng
> extent of a block group.
>=20
> As you said, for the traced linces, the superblocks on conventional zone
> kept intact when BLKDISCARD returns EOPNOTSUPP. But, I think they are
> cleared anyway with a later call of zero_dev_clamped()... Let me check
> that.
>=20

I confirmed mkfs.btrfs is writing zeroes to clear SBs. So, I beleive there
is no proble with mkfs.btrfs.

OTOH, "btrfs device delete" does not clear an existing SB on conventional
zone. So, the next "btrfs device add" scan the device, detect the UUID in S=
B and add that device into the FS device list (in userland program's list).=
 Then, the device is detected as "mounted" because it is in the list.

This is because btrfs_reset_sb_log_zones() does not consider the
conventional zone case. I'll fix it.

