Return-Path: <linux-btrfs+bounces-5985-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4639917893
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2024 08:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52AF5287D18
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2024 06:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3164014AD1B;
	Wed, 26 Jun 2024 06:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="S0dJ0HwO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hUQ/YicT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2144B14D29B
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2024 06:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719382286; cv=fail; b=YUYiaY5IqbYXLLKlvUU2Ts/rLaXArBXhVJ/H7mv9dejFT1dLcKcz0e95GhhJpWhBWY6KqAEnENnjIqzmKzughXNP14Q+wXtcOhCLYO4pWrwa+Hop1pDN3E9AbnASKaQD/jtG3nLtEbSixMYkIQdjGkCQofm/+tsgz0pfymCO5xY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719382286; c=relaxed/simple;
	bh=qA/4LxOKvlBoDsZwka6ajVYg2X+V37UTbI7UjHDsasA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=clWqmf1ISVRMl9uAYyPJE0QcA9r438sqs0BTjQhwd0NFb4JaWq2rBQnhT+S5k2lH4n2Gn3mUu/lNdcfka0z4KsAjN5T0WlyAT2Fy9BUj/og0Hf0KJeitJgbLZ5h3ctEHXILc6AZN3B9V43K+Afz0cRFf/XglpmRJIazbkg83uqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=S0dJ0HwO; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=hUQ/YicT; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1719382283; x=1750918283;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qA/4LxOKvlBoDsZwka6ajVYg2X+V37UTbI7UjHDsasA=;
  b=S0dJ0HwODiEc79a8NbqRJN44afOdlQKa+IV58tdgHm+Zhbq3u7WDSmXk
   eGtrJDlyybZMVmlIRFG3+wcDAHuJrc2dkPwy0TdnGUGam1hjoTpPB7naj
   BV8Yg7O7yyhkw3XpIKa3b2U/r3lr63ehJcAiUlSaqBFgsR/fi1WWnH4jb
   zK351tsTUmR3HlgAvL4sn52sK+wjkEC3FNdqmKdDeJCN0QZ2+Lsd1k1sc
   CROqL7swwwxbtHghhKkQq9vXqxfGGD4K0XiNT0NygRtD89Y3mJeNykK/S
   DkcbE6KaWc9bDtizcLZ0VxeBiIB1/9eV4FwrArEiBaUgnUHCm/4v5fV/Y
   g==;
X-CSE-ConnectionGUID: jW3P8h89TW2LzDdlwaxMxg==
X-CSE-MsgGUID: yV6KahLYT5CISRipfBqy5g==
X-IronPort-AV: E=Sophos;i="6.08,266,1712592000"; 
   d="scan'208";a="20851615"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2024 14:11:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTQLbua06KXUVYPOEETKuGr0qzK67eh6qmALWN10qCx/gF5LoAh+CfDbm2vJ1x3Px7BqXPrzaM9Z09gKdz2RQD7OAo3JCyrN6Ig3jpGlKg2/KNiRGeRjvBohTh5Y1z2MQIhpLvMSxp2q9tqQs5UMjeKeHvxGS+sNVgzQ8szSQgKa3bjyYjGh2QIvBgiSGj8esrKMaYYckNO2p+tLkBixjsFmqO/MW+I+FnkXzyWJoK/owZeEuV2CGou5hX9Z7NKCo/XeA96fWwJlvQNTOrTS+LBms3dbA/Y6JM3Jx7ZcudqqELWwMJ18hqFGlVenuVS75xWwJdtIAprtAEHvAFcdkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qA/4LxOKvlBoDsZwka6ajVYg2X+V37UTbI7UjHDsasA=;
 b=TaiSohq3ccpZIZEDxlrUJ+EI+LmmcD+jvb6LjF4qR9AJVlQLY9C13Lijc4mQqmrm3PBm4SpIA76r+J6rtdvc0r1PublXLPV0zK5AeYufDeXi2d3hp+OizKCO+YsHI7fovcYoiQdF+6JXawU+vXCz/TfLHCmN3nIftj8w5WU2++BvKv4gqdsZJuFmYmUU0pLVIQYkMWMvOagsMMyRcDK2kKuqskBRN3sinb5/HeIfaYHawmmczSDxxkedI4XaW+QxARcwavKt9EajQ63AH1KRwa3R81KisAW0fjXpqfuJ4VwG39El61QGT2BIQvi/Bl6dSJ6nBAhCcA/Mnr4Vh/OHjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qA/4LxOKvlBoDsZwka6ajVYg2X+V37UTbI7UjHDsasA=;
 b=hUQ/YicTHhyxr/QPnu7qGQxLNN9PXwZ6EZlcUUbTXzvp0TczKpXhJKx45O7+I4hQHnhahRWOKAKnISnJynUwtfhk7/wel3VyyWY5bq0/+/Ia9aF6wvepRQbvg1kijqXLystenx4/W/+PGbu3zKkw2PUhb3jh3Gn1a0LuLG7WdiE=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by LV3PR04MB9014.namprd04.prod.outlook.com (2603:10b6:408:1a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 06:11:14 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%7]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 06:11:14 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Boris Burkov <boris@bur.io>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: fix calc_available_free_space for zoned
 mode
Thread-Topic: [PATCH] btrfs: zoned: fix calc_available_free_space for zoned
 mode
Thread-Index: AQHaxxBO7oLsBcNTQ0+LVLS1/7d8HrHYqCcAgADpA4A=
Date: Wed, 26 Jun 2024 06:11:14 +0000
Message-ID: <xuerlygcpqotju2cuqeu3zsoeirpvifory753hqhm7c2biq7bx@5wqeczmnt6zl>
References:
 <0803c4de21aac935169b8289de1cb71c695452be.1719326990.git.naohiro.aota@wdc.com>
 <20240625161714.GB1488399@zen.localdomain>
In-Reply-To: <20240625161714.GB1488399@zen.localdomain>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|LV3PR04MB9014:EE_
x-ms-office365-filtering-correlation-id: 03b55388-ec63-43f4-c655-08dc95a6c8bd
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|366014|376012|1800799022|38070700016;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?gg5z2KzvCSKGPEMEWOAvDxBNdBJGnezs127Vld3eqO9WxgQn02WKvtKdgNeI?=
 =?us-ascii?Q?PpRB55TlQvb2AwLMqNrq+/f0FtJ1wdKAyET9/Vx7FxyKVT+iodRUHhC0inZE?=
 =?us-ascii?Q?iHJESK57SQ1hQfj7o6hOYhUTy4XShQD6aw7u8hIGKqzWGLtfFcwnMs/6cD7e?=
 =?us-ascii?Q?gnmeZ1d+RsMUXIoxKEnCRD3UzmoXKPARJdthNUpv+qvYiHtxJ3VJoIjiTo8w?=
 =?us-ascii?Q?lCH/Q0qdvSskqonowjWO240CrmN6FnnunNxZxSSuhsEw0DGyZ70gwPTyr2bA?=
 =?us-ascii?Q?ni7nW2OsGYxHVRfPiOfTfdJjxr/jPkwXkyqSkyDDdEi4pvYC/5RmytZhrWUo?=
 =?us-ascii?Q?jwCNQH9uYcpFoDQuBIFLWgoBJK+Vpmd9mVLyhRo4i/8r92b0UdpruyuDIP+s?=
 =?us-ascii?Q?QMIomHR83XtzyT8q9zsgJ+zW6uLr+MzaIRcezxAJ0P/9pQ1osD4ftvcAwF3Y?=
 =?us-ascii?Q?sNjAujqn9xpHq7VgOFM0rrkRiMjKr7VnxpHJDIvHgjtUc/a/xnAj1BkqZjhU?=
 =?us-ascii?Q?bQrqEZGZTs/jV0mOw5pLm2OsnoK6BLeaKYm1PIO+g/2zpk9TRrTRKHyz7E7v?=
 =?us-ascii?Q?qKugI9F6HkOwE5L8b03SHUCZD+DA4slarBiyJwJym9ELMzKEZdeTZ6+BME8M?=
 =?us-ascii?Q?4ZXciyCGKQxKcibrvDeOjlCLz5AVHP2OpmOIfdCx6GNLpgq0BtX6xH+U7auy?=
 =?us-ascii?Q?pOF63pX8BvMxOZLzOt+hC8A9U5H2WXtIH/x8ZQUonaZKGqYRh3twfB/CfYIK?=
 =?us-ascii?Q?vhw2/N4CO4fTisbVquALC3sXp9TV9VMk2W4wL1DobFAP8iNU8sQogD4xipqB?=
 =?us-ascii?Q?K5Avh+pkLKHA/7a+dt3EPCW6nq2fRERl5g8aTVXcujh/Rgw6d7w0QnshQNxv?=
 =?us-ascii?Q?S7cZfi7sEjLRCagxyIrltiIyCYhahhwVVSO2GSc9twe068ns7JTIAyX/qbN3?=
 =?us-ascii?Q?FX8Ri84bjYE6LwudbVb61qS9H0f94kCUUYvE4Ba+FCqaSAcg6C9KHMtqoyw2?=
 =?us-ascii?Q?NqGNagMTR+SuAS38jsu9ijdt/muSIYhPqcUsdAzWJGW5wpGtwCCk5G46C1av?=
 =?us-ascii?Q?5220Y8D25spP7REgTwuQZ0zD4h/flZixzEdm2EPiqQRaXFiSVkyeafUv1amb?=
 =?us-ascii?Q?eLXYaAig6lz/Az+hhaFaZXJVI40TuwylUAYF+2PB9bum7Yd06m8hgyhb/1Qh?=
 =?us-ascii?Q?D9CdcxNcRbT1UsUTy6fBwKZD+s5IIZ6MrO9FYjrAaBzcypRD+xDJvXwjFHFO?=
 =?us-ascii?Q?Nl8VcXXbLCDCR6jNytU1Hiwer6+iDVedRe4qGcL+Z4NFqpGZNd8amg+3phxF?=
 =?us-ascii?Q?msVwIvaVg9xTxE9oo4Mv5Oghv8C6ti3K8Z8l8oGh7bV48410B6PXL7DX88/y?=
 =?us-ascii?Q?cAfT8OhlyfNzWE7SUXKphNjm9Op0FAFRM7b3i/nxwCXwBd3VLg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4XoIiZHJZyfYrIhnniEbnCONuhNU2jZJEk/9fJUz02th0OyJ2iTh+/ffUGcb?=
 =?us-ascii?Q?XK67Grzb0bSBcIDqgXksJZxotiGCQAAZibhrkx5qS3aJhhwHzyn3O8BbPtlw?=
 =?us-ascii?Q?eFwaLrl2WgpOERkD5U25f7XF5UaXj2q0IY4O42sBD6rSpfqkcCKxGNHqoFgI?=
 =?us-ascii?Q?IWkb709uPMK/3GF+NMLmlmWfBLTNxaJ++gEYyQbNcC3gxWZy74x2kzI5QkEA?=
 =?us-ascii?Q?02+oXkb/J0fEvyQuDUvJhubeNEapXFHFFfkmilDQ/3jROT0awH3YktegL3Bw?=
 =?us-ascii?Q?by0rc8LsPiyokIy5oqaJKkL+p3IulSpHo86x4XS7FUo6oSpHdI6A0VjaXBP0?=
 =?us-ascii?Q?LCPR5hoPtxVw2yOfmfd/AG0GR26hGXwkI+MIP967nOoGiqWRVVYPOVrnb3zg?=
 =?us-ascii?Q?MHUW64qcVrUSJk3gXPUoZl0F6AtBy77zWLk5TuSJYK9/ONZaL05yU3OotWzq?=
 =?us-ascii?Q?J5MFDlOdjzNY+JkwlbZlxINRa0IqbkfCq1usUsXKkW1e5HFA5bjaw0Bb+Kpm?=
 =?us-ascii?Q?5StFtZn5DQgef9PbfTMV3xoTuACK0rRYZSJ9L3iwog38035LJUuLKQapRR+Q?=
 =?us-ascii?Q?4ezZBa3tnH1EnDRwk3yKi5HxRvtp72SjjEX662uGo1r3KMvhBFVRxUzX6ntL?=
 =?us-ascii?Q?SENojZjRImIE8az8T5bG0wNbZ4iQg5mYUzfqEvXIRp/xly/KpwLPZH7aZgFw?=
 =?us-ascii?Q?lvEyQEA9bndKUOXQxR2uFSyr7wLJO9KKWGcHK4TQMhNZqsr3HXZCj6TKezrO?=
 =?us-ascii?Q?6UVQSQF26Y7Ec8GOIoZaou6zUEhqvwpl3nSxYsQbVk1IzkxTSxcPcTYejkwk?=
 =?us-ascii?Q?vzQyjZpxwewKAOwtCkiGBpqvZMs2f1V/6w/vbJAQbfcd22+Yk8cj2FVKsTId?=
 =?us-ascii?Q?gbt5zEIPpFjXerNLZcRSy0i7Oa5G8/nDW3krM/viyACHpEuJWxE1FzqJVNi6?=
 =?us-ascii?Q?raHymgYnqdt/7l3zlwOFKOABCspgDMITaKw2Vmjpi/gC/Y9B2M6ZZbxcrjGg?=
 =?us-ascii?Q?/ieskoPxUDg3DP1xuNjAKVAOW5ySQGbTWbDc7gqr0C+LFAYLICjp/zQrVAWa?=
 =?us-ascii?Q?1nI7Vygrs9Cal0YHpLPXgxca2DJwMtZN2uinoaUAY1GtYI34jppQ/xlb8X79?=
 =?us-ascii?Q?vBC6wTqgnw5xuiJwTgHJjoWnWoZfyQv3X2xf+Rgt0K859ztqVYnT1eos+Hxi?=
 =?us-ascii?Q?geVR16U0CaePljFl9iOHIpaukC5nVM/ykc24qD1SLvnFqWUsjWiXvrolZMEF?=
 =?us-ascii?Q?vmSoXJ76OK0ozFJ1WRldDTwDWXiXnBBnIMdJlSfqa8MKyZGcNqtpOMuBRaZk?=
 =?us-ascii?Q?Jy/EltnH++qBCjmUledtxOwFhRm7F0fIrZizbIWOfsdbk6xmGcJaH3e5cWGW?=
 =?us-ascii?Q?9XbsM6qXAbYqN3VeBiK2+kJSpc75xAjwrY2XPOJOpUTau+SZ5TVbvalnlf5H?=
 =?us-ascii?Q?zaa3J75GMh0I5wS5fchc703ApuX+heD7UHiN9Nkyd941aPO670AahSUmscOa?=
 =?us-ascii?Q?2DMJmFcrQG6OFZsXep7BxIh2Y9zDP/ewObiQKQh4819EsoRluQCHMadCrrUb?=
 =?us-ascii?Q?YZXmDGeIlcSRlE5RpTuPn6+IwldH3bJnIVszAtAAJbNRZxatH4UWB8rF5PBY?=
 =?us-ascii?Q?bA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B9521ECA92E8AE4E90B03F620564DE96@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vSu6ZebCcOFrumrjUlRcrbWVgF0tzjpZX8oyzBeJ+7L2UAp4m2yZm0Wxitc42h9gJerSuzCOGAAcLEKNzF/EGhDnaTgzILqJYcd23Ftyj9sNnmy2eNVNFf5uvCI8VdS6hJ8YZ6YReKe3xtVBq4lQT9M43pt+IQYgNM8on87cDUSHlGJS8ahe5TJO1A7fz9JPLuTliAigDltdUbb5yABrrepOrlPd0Id+wOKZX8y6nCYlsmqJNmPunCTkh7e6qZeZSX6F3iX0+B1rTVSHNwHF0WtKwBGoyjOe0ZziZi82JIYyoZaNJpq43fofbhVdJV++QdB0F2I3Cg05GIGd30U+fdD9baKM2q62Dch1fstunLfnjMYxZu0uK/MpnpzuquSBF4Zkf9CY16uLlKuCdpildN92bKSJkcpt+fs2cSmi6zULhE2SAraVt5nRWwTa4vN/HirJ7E0WGXN9JMxbTZmNNurXyZaezb1kTKLHIt5WN7upPs1NBup0z2jXLO4m9vqPdK8oeAiE4r+f+URxggZtWZVON6RblIHsL6XmfQJsXIJAGeR/FmEtLaCmx/vt80VQZHWtB7qg4rBPUcOUPQPA3kQ40JQWkEvbS8plxI2eQS4BQ5XceDuLI8KoSeiC864v
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b55388-ec63-43f4-c655-08dc95a6c8bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 06:11:14.4463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rgNWT2iZ7JWxDfsWsUlu1aPTUoB655f4Xp/ftSmpOms0aILMYafGxEkBIGIvVoR7KWhw+skxjg2bzl8Ule5OqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR04MB9014

On Tue, Jun 25, 2024 at 09:17:14AM GMT, Boris Burkov wrote:
> On Tue, Jun 25, 2024 at 11:58:49PM +0900, Naohiro Aota wrote:
> > calc_available_free_space() returns the total size of metadata (or syst=
em)
> > block groups, which can be allocated from unallocated disk space. The l=
ogic
> > is wrong on zoned mode in two places.
> >=20
> > First, the calculation of data_chunk_size is wrong. We always allocate =
one
> > zone as one chunk, and no partial allocation of a zone. So, we should u=
se
> > zone_size (=3D data_sinfo->chunk_size) as it is.
> >=20
> > Second, the result "avail" may not be zone aligned. Since we always
> > allocate one zone as one chunk on zoned mode, returning non-zone size
> > alingned bytes will result in less pressure on the async metadata recla=
im
> > process.
> >=20
> > This is serious for the nearly full state with a large zone size
> > device. Allowing over-commit too much will result in less async reclaim
> > work and end up in ENOSPC. We can align down to the zone size to avoid
> > that.
>=20
> I sort of wish we could get rid of the "data_sinfo->chunk_size is wrong"
> thing. If we never actually use that value, perhaps we can try to really
> fix it? I didn't do it in my patches either, so there must have been
> something that made me hesitate that I'm now forgetting.

The "data_sinfo->chunk_size" itself is correct. It contains a preferable
default chunk size and it is used always on zoned mode. OTOH, on regular
mode, we need to tweak the size depending on the situation (unallocated
disk space). So, I don't see anything that needs to be fixed.

>=20
> Obviously not the focus here, so with that said, the fix looks
> good.
>=20
> Reviewed-by: Boris Burkov <boris@bur.io>
>=20
> >=20
> > Fixes: cb6cbab79055 ("btrfs: adjust overcommit logic when very close to=
 full")
> > CC: stable@vger.kernel.org # 6.9
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> > As I mentioned in [1], I based this patch on for-next but before
> > Boris's "dynamic block_group reclaim threshold" series, because it woul=
d
> > be easier to backport this patch. I'll resend this patch basing on
> > for-next, if you'd prefer that.
>=20
> I looked at the merge conflict and it's the fact that I pulled the data
> chunk logic into a helper function. Just fixing it is easy, but like you
> said, makes backporting this fix fussier.
>=20
> Since the conflict is pretty trivial, I support re-ordering things so
> that this goes under the reclaim stuff, whether we pull my
> calc_effective_data_chunk_size refactor into this patch and put it
> under, or just edit the refactor to bring along the zoned fix. Let me
> know if I can help with that!

Thank you. I placed my fix patch before your series and modified your patch
accordingly.=

