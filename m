Return-Path: <linux-btrfs+bounces-5274-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D5E8CE269
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2024 10:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5238E1C21748
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2024 08:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090011292CC;
	Fri, 24 May 2024 08:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="k6rbPPXK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="obBbb4kO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7414482D94;
	Fri, 24 May 2024 08:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716539605; cv=fail; b=GPB6M3Dkd4vgsnj32wq0iNGmV1GHlfIOa20E0b8MDBc3HmzLYW815RJVOCC6ZkkrFCe/m9BWa/BrBzwy53H69gChhfBV5PwSRIUGKC1y9x3o1qZDCfwmJoQdmpMtjmgZSihMaYG2OaAilcY68Otxxbgxr7GNoEqr7t3ZZSwUVC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716539605; c=relaxed/simple;
	bh=6SBPfFBU8fJBj+WsnsE8NDaNCeyieian1h41tAmYxdk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DrWwkPMfP1qAfdGOFzmDXWWzbYr7DDqzhCKt5Ff+Z1ktI2oNsMCVCtLsTb5bPJYkHgSfEmkk6oQMFvKKkpQQ7ljqh/g/uW2HHHBfg82xKJeOBXSW4HowAM7L1nSD9XkJXx/qbdtYA8cIJRT4eVc3MpFJTnwBorw+VmNbZmQuKG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=k6rbPPXK; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=obBbb4kO; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716539604; x=1748075604;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6SBPfFBU8fJBj+WsnsE8NDaNCeyieian1h41tAmYxdk=;
  b=k6rbPPXKKYW0k5aL72IBjh4dsfmphhDemg74YT7MJYP2jnqcOMlenNTO
   qgXdFEJjEXfVVg4WcZ5FHTfyTzQLOSItEnaX094/hgprmtRwvTrBQNfik
   yMESYNE4TOUK/ehIa302rATrUTx3gVgzMBK/tXrCAuhvl45RLBoy3siZy
   GckKud/qvvDUOl0enF4Ad3LtB/7JdSeXAO7mYSbMvL03SXINk8KRD+vCw
   m3VzowEWMDBc1zMvEQy2/Y9L49dvBMXJraQUkh5TeKj3+96wqNoCJEnmJ
   ATYZN5OBtK9DGMkMoWf3w3wFQN+GOIq8r1txGzS30Uf9tsHITXiwdgyJW
   A==;
X-CSE-ConnectionGUID: eaajZya4R72jaf7rIAb0ZQ==
X-CSE-MsgGUID: 7KFdp/uxTVuFxg7Gaz0cLA==
X-IronPort-AV: E=Sophos;i="6.08,184,1712592000"; 
   d="scan'208";a="16887182"
Received: from mail-mw2nam04lp2168.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.168])
  by ob1.hgst.iphmx.com with ESMTP; 24 May 2024 16:33:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbB5/auRLspBrgTdo0D79ZJQV3e7L4kgkqdOqO3Ro4M6jlsG6zQ+nUJ+TPon03Yutx4gYUcOju1MWeuyFc3gsCN8sELyz4PN3K4rkqXK1Y04CSPZxcb/qPuHwuGqSb3XGi+xOv0qiZKitjKnwEUqtSM8JAtjIQeg3CL9aQEFhsi8QbCAF5LWoJ7SM+coitkoGCXc3Cnkd7ukUR84LXOgyC72QwffSUooYWpAHzxaJmKcCF2Qh3i78C/R2rSSEDNZZiHPvSWEzFB1NgVdKXZjQkdepfwIGBgXPbNoAnbW3JIfaYnrBenUv2CUXDMBrzPU+gvY8GUMEXAMRtVDtrWVJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9aKwOdH6dpeE1p/4y/TEIycgzMEfpXW1FSOzQEML23o=;
 b=F93b40KZZtDMHqrho/xrydUabGbzGxb76QL4q8MPJZoVU6Jdav25QHhri7ZiPCdnbQ5r2HWa+Dm5Y80L3Dx2OGMcGScCVuPStc5nBQeog79Hi8vmgjHJ5AdB94ZIoEycD8XFjjPsemEzqJllVho7qRKeTNgam1mHLNUovlR8csVn04kb7roA024moYXeOh4LIS7LiY4B+seZ8RO6fTYPCzrdetQ5mbVjpzC3oK/jPoUrYoO5EF2uOUE6vTfLGPpQ7qUDQDPt5LTEOnEsdmP2scOeBs6X7+wLVh00aZpwVH5xeZSjA2b3i3tTHVTUlpFmN3UrP4Cqa5BFQHhCM7NW3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aKwOdH6dpeE1p/4y/TEIycgzMEfpXW1FSOzQEML23o=;
 b=obBbb4kOqY7OO2xJlWPLG7pcXNlcYtq1rYS2sJRC6KY2QDBZbk8qxqQwYOv0cQbSRmuACFPo0BwVpe8xwMbsv5iuZrIZ75lT4Bkk9WmZQ4jefTaij191OQ36ZpBgNrVVMilvVSItWhoUYY5+pO5DAxcHOgOl/kgA6TQPmkuCSHM=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by MN2PR04MB6655.namprd04.prod.outlook.com (2603:10b6:208:1eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 08:33:19 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%6]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 08:33:19 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <jth@kernel.org>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, Hans Holmberg <Hans.Holmberg@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Filipe Manana
	<fdmanana@suse.com>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH v4 2/2] btrfs: reserve new relocation block-group after
 successful relocation
Thread-Topic: [PATCH v4 2/2] btrfs: reserve new relocation block-group after
 successful relocation
Thread-Index: AQHarST8zRWREytAS0un9b8E/7cIVbGmD8QA
Date: Fri, 24 May 2024 08:33:19 +0000
Message-ID: <hw4t6fcvydkd5j7iyyt7hx3itrfy4rtigm4lw7u3fgsql4vksr@vuj7lftxpvss>
References: <20240523-zoned-gc-v4-0-23ed9f61afa0@kernel.org>
 <20240523-zoned-gc-v4-2-23ed9f61afa0@kernel.org>
In-Reply-To: <20240523-zoned-gc-v4-2-23ed9f61afa0@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|MN2PR04MB6655:EE_
x-ms-office365-filtering-correlation-id: 79a54c99-54f0-42a3-1b73-08dc7bcc2a42
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Qmytz52WZIlmKmptiV7nvBFmaDpJUaKFRf5fdudbsHU7v11yTax5dmgBmd+f?=
 =?us-ascii?Q?OvFtH+2WH/tNLmPfaVJZQEHSYQsHvJBZub6/Hg7n37i3/RIdKXwflqokAopm?=
 =?us-ascii?Q?hYt1FAbjpwQjIQxuPiL4ru3VbOHRATbHte3LNLfolI2tJQTQynN2BXXMC7Nu?=
 =?us-ascii?Q?ONmTf/SF/emyXvknUeAdLS0fNM8FyftB6I+oPKdHozraGgQyT80gk4rPfaSr?=
 =?us-ascii?Q?cXGi7yEdbHLeZfWGyEsCAdW4QSdim/voxl1X7otG32ZXE9uDagqv6i28D3CQ?=
 =?us-ascii?Q?2RX7UQK8mpEPAonGO6lpdx0lqQP4s5vstlvA4gRUisA00dPPZEIaxqTp/8z+?=
 =?us-ascii?Q?KBOxN4/L7161ksEQqMef0U+IswvXjJmka8GP1H+MRDDgCLniq1M7pSGiklC/?=
 =?us-ascii?Q?QUIlP0tcp7iRyHuZ444M5lrPYrnOnYjeyPwt2K0oaKg0WvRkf/djOhn1TKvz?=
 =?us-ascii?Q?SAnsfYYFOs64h+DNl6UnWCqADbEbzlbLWQg0DLRen7Ln2YftNizDNWYDyJBT?=
 =?us-ascii?Q?TulCIRJ0/yYSU8xxoTXNRU1x5kYsq0/Qrsu/qEXvr49AykbOQqYxrujHR1Hl?=
 =?us-ascii?Q?7K9pV8Lv1wLphYFtijKd0j8+FOFVUP/SX8lT4xufBNASYSFLFVRFEk8QM1VR?=
 =?us-ascii?Q?ERvwPImAq1udP3R3cm+/9VnghwMg2DBleBHpjNQW0GaIN1Eh68UO+ilhQLr0?=
 =?us-ascii?Q?6g2DKJPgak6o2MPaZ0N5fQhWeULBsMxHuyfnUrd4maCV9BCLXSFyp0mcz9/a?=
 =?us-ascii?Q?Ajli58i6cbnOXmcmXvU/LcgbbSkWFQasddmExeqcz6IDGVNV5LRLmXDRvTZP?=
 =?us-ascii?Q?U8B01HWZ8WtTT1weHcVWLQ4fZ+SCh1LXFenvlJo3d4zZdFQGrR6xWGSfzeox?=
 =?us-ascii?Q?J4c9QoMs9t+3ZsbJE67A9Ce5w6bV9IIwbT59P16hNJBCw8Y97gaVRHt6UqYt?=
 =?us-ascii?Q?yTeT6VW1lEXGbn+PTOG11Rtu7n90tMBUHZK5Q/qHuh+rVHnw6vU+Isy7FYfU?=
 =?us-ascii?Q?+fUXUhRKVM/TpyngXPutrz8BKea0h5TEE2B2HePclzF9aQs1AETjlYWAvmHG?=
 =?us-ascii?Q?gReBKoAPqjdkGooGYlFXLo8/nNblpWGTQKtRlWR6xFr3bYPcm0vO2wG5q9bk?=
 =?us-ascii?Q?kIoTxnmH4PzC1rQ7ihuOQ5q3wcGpKHhk0ADfnlO7J8IrXr/o2VRzsM2lI7dk?=
 =?us-ascii?Q?U7R+tieObwrc9znjHC+Syzk4RDGg/JIGixhOxpYWP95frJYCIMWlQ+PDxKUX?=
 =?us-ascii?Q?SnWg/hAQzPlknnZhOWtBRKSgbep9Qm7WGnu75M3pg9FTdcIOU4VTKK0DSHMz?=
 =?us-ascii?Q?GaY04ZqI/Mn5C+UUmYLN0rsSMjZL6thT+svrE4hnzgf6UA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Sw7HhDWMtvyNtl+bHWFmb07OkT7s4oWyRRjTtC3aDE0FqL5TUkZQnstkQXGV?=
 =?us-ascii?Q?wYhUh7nQQGX1rbnzIpRr5LeQ4Fg7NWp7abSzKN1kbeSDumwDP2/ZYYj0YeMD?=
 =?us-ascii?Q?/i6mBpgnuSMhah4rOxc6cwvh1qvhtNFTDNO7GHKhVUthEyRpNMa8w1ONdbKS?=
 =?us-ascii?Q?YYzGmW2zsBi5Os45GLjJiNejS8+S8OsGcHGgN4qkve/rp0wdPpb9WLIboi8x?=
 =?us-ascii?Q?cLc/zEvyTkUdJtoL5qNpYA8aQYhhemlhkhKMyLX0UsBqOPrU2FJxaXB658mN?=
 =?us-ascii?Q?U0frAbrCJNPKuw9uSxMZcQR3WL8fVulOr4DZhtphP0qQE3nw7YSV84AudYxf?=
 =?us-ascii?Q?ugoPWKmx8xF6BWMOG+nHAPU/ntkR9g4BhJ033HtB2qMiFKAZhoRaelqPQ1OB?=
 =?us-ascii?Q?na4g4UoXJ0kupRYW9jQj02/94xf1+q5eNd6iPGA7+JlExo8W33frj4gFdHaN?=
 =?us-ascii?Q?o1coOioiiGdihh+NjII2Im9m64KtJQtq7+GTbrdUvnFTu5zl+3Rsk/s4hgdi?=
 =?us-ascii?Q?dlGVoDk/4q6jxvjueL2t/cSS8h0FDH1mhRSgViw2790x+/EeYmGS2W3H8UeK?=
 =?us-ascii?Q?DSugDfHD9sBnl/a9QDiin5kPqg9ZhGKKG99H2F4i8uY3Gb2DPnJO+r5kFwJI?=
 =?us-ascii?Q?4F1Ihqde6CoMPwlgVUehL/DKpLIbDZeIt9Z3gtSVc+i6e04qTmEyDKHm1363?=
 =?us-ascii?Q?u8adE6nVEKXmy5h5KaCSEjqbrrKZuoDwqxSYmQ5BLCZnNEEA4BVRI/B9Mo6F?=
 =?us-ascii?Q?oraOTia4o6Suy0cvgAZV3E6nGzM+QJem3kvyCxIEavH4+hmIgtrpI+exb36Z?=
 =?us-ascii?Q?xNFRFlB7LqL3aD8RocQ+VRXPP1pRdqbYmtYv9t/E9TjAQGhYVzcAv7QTn15v?=
 =?us-ascii?Q?e/2zjXcybH6h++MrHmHw5GK05P+WTGq/qZ2RXG/bKclX2OcGq+pjFjasQAWd?=
 =?us-ascii?Q?etUQfpA/MjYMkD5y7nEVs6FafuCKBb4Jb544Q4YgREsdgiuzdEbX7LHXDmAa?=
 =?us-ascii?Q?YHirdB9Ie/p6fD1/TB7LDqAfun+U+pHqTu3aFqzAKRlPRFJqtt2qkAQyT25p?=
 =?us-ascii?Q?mA5Wpvr4UN+D1ANTl7Ah4VfBb8Hn54YeMj8aKbt5JjPqn6HqyBsCbiM/Tklb?=
 =?us-ascii?Q?RUFqTAfV+A/BemgHS8KmYkfXmbhogSuu8bzslNNd5zch0wFQxijQSCPLFDUB?=
 =?us-ascii?Q?ssp/J+OK/ogD9sOx/IxM4Ku+lc/e2JB8OW6wDBEAObaMq6e8yIjvgG10dQmX?=
 =?us-ascii?Q?b23zr0HT6lh3oLS0MEobl6CwGpjLRAmFDi5v2Kte5e1Zvud1693HbDZ03DWh?=
 =?us-ascii?Q?cKsYhShHdljnEtyWXrXOi5cqNFb3aiOWQJjU9i4ygWQ7G892+RztSonSm9r6?=
 =?us-ascii?Q?ebzDNP96Yf+EjHzE7Po0+AnDD7SY212vlCv9GEIIGAZcjO340Lg8GMoRyjVZ?=
 =?us-ascii?Q?JtGdQuVSq4On3jf6x0CRkzqi0V3tKmSLWppQfYUAVjB/OrVdC63XoMxq/whS?=
 =?us-ascii?Q?Z1zaXZ8wsAer59cj4eecHQVNmHOUwF/UkgO4f+8IATpmgsV+fIGngvQPahXS?=
 =?us-ascii?Q?BCgZzbISJyWJyKdodptIMrRFKrHKi/QyDElMALScCR1RY1Pl8e94yKU/nwA3?=
 =?us-ascii?Q?KA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C32EEADE86C3BB4E857B2C812E0042F2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SRvnQ1EN4VXHY1i9Gj/Lwh14rv5+RLxY+Pbo19X1j6UlZ9J/meGrZENcTAVdGfwd13UgEEYjA4zZ2nF4V9+iY20tbFqrrccXa6TTf2yoTHcbxTtUvdbzSPjvUp3gj28wlKbq0UNKQyNy86OSKGoRoSF9dWdBNhkKlzVmPL0hNHe7LU4uXoEurr94xDvPqn2AxZlfPfKhri7TDyNVo9FzvSQux2/AZo2zXlyC8dnVrGavuaBt7JnlYI52g/BgyjCIu0c0K67lrMPQdTr8zJByTa9qsEWSkaxsa6M3Nh5UALwCV82Fpopm0jhHTAhVfSbWHhQYUOpR+vNwanKvRNizAEmQmQn6pUasq74nPlq3rWoWKHvaO1jQmU6kPw4wgReSMYQlm4mtYi0rDX2PqvC288cfITjrCWRb7iT6i3ILUxFmN+35dWV9WxhsJjUzWb7ygx3Z1SyxQJTFG7YR8PZv70llBWJhhsw2OAQ9rZ5ZpSUnIrfbUh5a0L9ynB5hNIqzKFgAU4ImxnLbmhXTkA1mI08u6GP7LL6SzvQ/e12Uc76TuqQIZFAjOVKojPrXnvrK6P/bZUMqm33K7IL6iaE9HSwUvMuPMprEr8y1ehaK54SoSX1b6+OPSj0koUoLrL0L
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a54c99-54f0-42a3-1b73-08dc7bcc2a42
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 08:33:19.1676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JsSCiBXIotrn3YQnvHt20IyyoDBVWe3iCsVK72sJViF7tMMD0dzmQ4kOioln29Rneinse8ECagIGB6Oyz7JJdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6655

On Thu, May 23, 2024 at 05:21:59PM GMT, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>=20
> After we've committed a relocation transaction, we know we have just free=
d
> up space. Set it as hint for the next relocation.
>=20
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>

Regards,

> ---
>  fs/btrfs/relocation.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 5f1a909a1d91..02a9ebf96a95 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -3811,6 +3811,13 @@ static noinline_for_stack int relocate_block_group=
(struct reloc_control *rc)
>  	ret =3D btrfs_commit_transaction(trans);
>  	if (ret && !err)
>  		err =3D ret;
> +
> +	/*
> +	 * We know we have just freed space, set it as hint for the
> +	 * next relocation.
> +	 */
> +	if (!err)
> +		btrfs_reserve_relocation_bg(fs_info);
>  out_free:
>  	ret =3D clean_dirty_subvols(rc);
>  	if (ret < 0 && !err)
>=20
> --=20
> 2.43.0
> =

