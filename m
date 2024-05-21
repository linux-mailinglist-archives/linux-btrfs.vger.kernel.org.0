Return-Path: <linux-btrfs+bounces-5146-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7AD8CA9C6
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 10:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51472283442
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 08:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA54154747;
	Tue, 21 May 2024 08:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Sy+Cnspt";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qWLPgJhg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06685466C
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 08:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716279111; cv=fail; b=Mg1/nwF1aJBAYRLb71iw08ESzSnVPiYeJzPc2kKzOgdAIs9HYBSkc1zQ4AHARK2VYUD0LUr7QgJa9P0J2hQ3EooPa1jHtFVHAw25bTah2Q1YSqJWop8DvboXgRjbpsUgHegEJPQ/xx7boYjwzszwQ89KWffY7QTdytsySkvzyc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716279111; c=relaxed/simple;
	bh=PYuNdqd9ygMtZfllNNcm+9Ae9KYf2aOSs8S+dMQJoqU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rNfqqE3eZSrwPYkgEPGOYewlo4lvf7pNmyn9Xa3PutpYBqa15AixkhdvWFkHRO1GvgTAdc6mxk2M2NbcVSxCnDetvD1uYXiZI+lPXve1oDrYkO/zvaIF4aoV9Gj4L1Q8vFtFzGxIXL4Jq1tmzdfAz9m7hAngwpQTtO3U5lGsIS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Sy+Cnspt; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=qWLPgJhg; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716279110; x=1747815110;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PYuNdqd9ygMtZfllNNcm+9Ae9KYf2aOSs8S+dMQJoqU=;
  b=Sy+CnsptquNNPU8J1WikdvuGan0zCc3LHd8Ng1a+a5DNxF+a2FhO/f7b
   tqp1K4RphXCLhY8YbTFHSEfDAjlWKHtEthiBuHmOmyoXr3WIyTMsSM2s4
   yxw5fCFiwxfbDaejQKlYaTwgaSoSUpOLJ3nJEiLmzYDsOoFMFormt8fHy
   GoAy8GKJk8TrPvmzjuK0yUEjZn2s+y5Cf5cYw0/O6jyDqMN4OlBZv6aXH
   bmbz7j3mPdakmoxUE/QO4saIPHY6qQmqxm94bMHzlIVGfLBDzzkN09dBy
   FYMBWQ5e7fXbi88XTqoooXTpWC6koKvGzANG3xvRwzSe8SG+YFNxyqS33
   A==;
X-CSE-ConnectionGUID: EZNcYGX/R2CE9q5eBefcuQ==
X-CSE-MsgGUID: HGMmkqDxTtWTtFnjxsqEYQ==
X-IronPort-AV: E=Sophos;i="6.08,177,1712592000"; 
   d="scan'208";a="16570965"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2024 16:11:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQ5qnwQCaw9B9AAL1WJ0diU6eXKah3uKrpOEldu9Uc4PKbf9SfuHZyCg4bUsKIH4PPGH+/inZZAHJqMzznraxFw0funsnPymVjGBghbIsodF1lNFhJ/AhoYGbTYeBRTy+EzfjvCTydSRK7r5U4xh/dO6Q8uv8sDXtfhndmeHEppFnas86NvQUrR6H7Lx50/0e6oXDRkK6iKChrZm9onf77nepjfJq+gr1xJKvCM8yclNSy/9vxf5eoXLbYCL1/WML4Mx5e3ZPd00mkdYWzk6bF8fxlO1ouErOzsylce41pQ+pIulTQ4u4gZNc3ymo/KGSg7zCFzp8Vuh+Q/e7oEQnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEEDrZKrIh+2dfXrS3QFyPmPdjPSNUohjjzXCE9R1Ow=;
 b=OYEMEeNNAGm/dLZJql3uLlQY8yuYE+hgsPV2LPcWzuQ9KPk8S3f1KlsYG+8cUcGDNH6OM4MF4P4NMRydiiA9aLVlfsEgcvA2OHJnwSwWXr7DQj8S3CMlqROdR8MSczHfvOahQtv/MNNiEyYOVbt/zaeHrmtgUEm965pn+WODI0waBzxkggTgQhJsgc5dQ5uKtHYzy1YxBH0cRHKcRhITbur1PzTN75Wa+xRkw+VFaTzHEn9XrINo/dCGtelLpPJD/h7A3sDRr1MLE6WcTpEr6iXkhIKyt5ZzoI5L233AE5vxNmxTQldx3BbowlGdD2m/Xwoj4ruTxdNxOjG2UPpVCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEEDrZKrIh+2dfXrS3QFyPmPdjPSNUohjjzXCE9R1Ow=;
 b=qWLPgJhgJbBPZrzIpjzGIlzuPR5JBKWoQH7peCkuEPTIkOJxb7DuxvWsCX7bC0PIKbcN/JqsUUgx0Ej130fGqhIe+nTvDR5sxZENlBT7Dwnlvd28TEGxB1Ad6roGMl2m/MP4Azg87BrIdYYSM7zYAmypP+0pl0BMTyyiwmGZl2E=
Received: from DM8PR04MB7765.namprd04.prod.outlook.com (2603:10b6:8:36::14) by
 CH2PR04MB6728.namprd04.prod.outlook.com (2603:10b6:610:91::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.34; Tue, 21 May 2024 08:11:47 +0000
Received: from DM8PR04MB7765.namprd04.prod.outlook.com
 ([fe80::8bb1:648b:dc0a:8540]) by DM8PR04MB7765.namprd04.prod.outlook.com
 ([fe80::8bb1:648b:dc0a:8540%3]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 08:11:47 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Qu Wenruo <wqu@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Johannes
 Thumshirn <Johannes.Thumshirn@wdc.com>, "josef@toxicpanda.com"
	<josef@toxicpanda.com>
Subject: Re: [PATCH v5 3/5] btrfs: lock subpage ranges in one go for
 writepage_delalloc()
Thread-Topic: [PATCH v5 3/5] btrfs: lock subpage ranges in one go for
 writepage_delalloc()
Thread-Index: AQHaqOFs5z6tA+7MAUmGvzzVgUkS6LGhW0gA
Date: Tue, 21 May 2024 08:11:47 +0000
Message-ID: <7oxv5xm6n4yg5r523pzm7hxql5pihrfylrducrsiwlk5k4jl7a@wxvlrl6w6cbu>
References: <cover.1716008374.git.wqu@suse.com>
 <b067a8a2c97f58f569991987ad8c3e9a2018cf06.1716008374.git.wqu@suse.com>
In-Reply-To:
 <b067a8a2c97f58f569991987ad8c3e9a2018cf06.1716008374.git.wqu@suse.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB7765:EE_|CH2PR04MB6728:EE_
x-ms-office365-filtering-correlation-id: 2631bf75-749d-40a3-edb3-08dc796da8e7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?euJZCxNZ/u5kzazeAg3hkW95+w1wdYBI7qGwHKyQx0nGBXbI20DaV7qjjkSw?=
 =?us-ascii?Q?6Hhn08OrnGZbF0Un84FFMxObZ11mRy+lYfwPUfKdZT9TivRlrXBDBSsrsPq9?=
 =?us-ascii?Q?aVH8OGtcdeyTDN/9TfEP00TYndvD91qa0Y38x5VgMYo6cbNiT7JrYGj/LF2f?=
 =?us-ascii?Q?GC0UiR7GuWEaA7dZAg1CNorDUchoC09Q/hB7SDOeIJ6RR+Wf6glTo5lxQr6R?=
 =?us-ascii?Q?Hdu7YArnJ7G/4X16UGgRgKeJXK6pw+plHVnNFYoPa8YYfnCjW0RNpA0tKQXv?=
 =?us-ascii?Q?Xy67wWFnEvONu6DZGxXbl1+6ms/3wS2pU0JjdVMg9p2Q+6/IRezZoq90k/uv?=
 =?us-ascii?Q?GXRfQHHrOIO7ixK2gT4IU8dlWT+KSbG48udLev7eFTyUaAS34XI915TKFpvE?=
 =?us-ascii?Q?0E/1FlM5NAWwF0J08/TVIk4P/+jB+z0XZ1DZazOoA9j2WmJSbS6CPyN4ZhtX?=
 =?us-ascii?Q?ZyMMkl4acz+NBWkeEz4xPjzq9/DkrdKD/AZkWTr5S01x18TzmnycdweyheL3?=
 =?us-ascii?Q?D1kSQGITFCTvoq1gjIk19K3MGE4c/Iu+70LTeKPTbITx7O1BEhC7fhCCkC4t?=
 =?us-ascii?Q?c0opxy8fYEzuwPDVb7L+nccZ2vP3HAP43EqqFYiqzPGRlWE7fXek3jbZgbmd?=
 =?us-ascii?Q?E3agIhz3suKGSAxJo8qo4e1+svDf246Y1jF6+NkCIDUH2xzpVbG59j7NANlS?=
 =?us-ascii?Q?YfSaEGRyy5KEuDxf4nXCgkqMUILBmtn82af1qvIPxNqqdsGKmfkWO/g4IfM8?=
 =?us-ascii?Q?o9fosBMLC3a7rCnqUZahKU3VM5rnkElIxxe/o+1m/TwG2MDiZV7p6dVUAM7V?=
 =?us-ascii?Q?GnZr77BLIpwMkN3zOx+0XkCIq7vqryrjpVHbKSVOrFrfV53VGd1EW/ppfXAv?=
 =?us-ascii?Q?KaofQXbfUn9DA9Xwf98kD4XJurLScHAUSFRDdj9uW3pLf4cBOg9RFyCVYgBx?=
 =?us-ascii?Q?m3f8hyF8/xu89Agj4tpIv7MT6yeVyq0v0RjULVnlvhMBxIgrXkJt0JFYJ3u1?=
 =?us-ascii?Q?VrremyBx99+EdtELT8Cawywnkc9B7Bf+w1MISRjaaNZ4X0HcAYpzZUTeDkGn?=
 =?us-ascii?Q?Xf7olxpMN74vSEjy71Ut9plH5W1aUbuQ/B2qlhZF+9m2jA3DNLrqWe7bsjJu?=
 =?us-ascii?Q?kI8+qtsR95uBO54pFYwkybeY4Q5LVYmcJFxX/wkYw8TOt2PnAQxUlLnicbK3?=
 =?us-ascii?Q?CLDpxdnYIl7I5NOSrKeADXRs6xKzWZtycuxmGz6vv2kMbkAz2sZZZ5EOZ7Cd?=
 =?us-ascii?Q?x4UYNw7ZWOp/3CAf5fchckshh8MhpuymIBn9RbpC2xoBeCSCMkhSeruwGxFf?=
 =?us-ascii?Q?ICwP0KTN4oAdmHoeqx5KYcFXx+HgR9hisZFvH10TjXbzbw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB7765.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wy7kB4Loi1dpDgMP4NdIhb6hTmluywflRLM9C6ObpBqBZp1pnHRJhLAPbAvz?=
 =?us-ascii?Q?ndpkB2ZmMP+HDpA9JAxb/PVeJX9YSfLscXmNk6mUH2X7WPNVHSt2QzufbrJO?=
 =?us-ascii?Q?RLSlVQJDGT80PDpAbO29fMy42EkKv6ffHlO+muoQGDzkMQKPsMvwneY9U1W4?=
 =?us-ascii?Q?ZlFxEZ0/yA4x5/OnPpL8Kvs5FFCocW0KZP6O9YIAQiNgg3otsvubi/lO0uid?=
 =?us-ascii?Q?DHqEpmYoPJWamfd64Niyi291UW0q2gtpXpC85CZgDFkzoS1VnyF7Xv5FqvAU?=
 =?us-ascii?Q?5jhKwFQRDc5HUHnXC5HAPZbpk18LXKBsH2J6ZB/bihUnBzlEOsCcORtE/pTN?=
 =?us-ascii?Q?xp1oqz+Qnv2eyLujjxvmBnx5n84BOZsN2Lo9x3Kh5/VInDeGZ32fy1fz8OL1?=
 =?us-ascii?Q?Y03z8cEeDMDPlBgzt0X4gq8xlItj1tsGVi1A3rKDDLroHYA8YRRFruKapKjY?=
 =?us-ascii?Q?5IuviwghkoTO/gxeWnS1zwpl3N+GBQwG7VXuAb3WJcA+VVgxCBr3CE627KiZ?=
 =?us-ascii?Q?OWY7Q+zA8xVAADQGLk1NidS8vwKAGOoLTGU7SbS0hfNBGIZb47uWgxWpU8TI?=
 =?us-ascii?Q?FdD5otgwbHlB/JvIklAMT32Y6t6Dx/7Voy2/b1BWXzonI4tgxMXh3e9Rvd1C?=
 =?us-ascii?Q?WvCGplPFu9cYC2MyZl4fkxmHw8xrc21MC0p2qDVhjU+7YojDBzKsoBmjDp/F?=
 =?us-ascii?Q?PjHHWON4wweWv41ZYl9y9erlgBDy4afmTuF6CKmMR69uvzI6R9vhOrnqOS7J?=
 =?us-ascii?Q?vRP4Bbht/aVJNvZtzvhtuPI0X0T/iDMhEwsEYDJTYPj/yvjpMb+p8kR/PZAw?=
 =?us-ascii?Q?lTYdjSOw3WfTciJAROfv2+hKYVwggKfwlbr32QoqSDKyHE/t2wLVLi8l2FYS?=
 =?us-ascii?Q?vJZsA8cbP5w8IouYJJ+8E/Gnu9EcSVtiECLGuasuZz7d+WmL+g+THVQpNfhr?=
 =?us-ascii?Q?nrGmJahOEYIdwXX9iHfnzOn+TJpU4XdZ5vPxD68FqXTU+mLq8dsb4pfcxLMI?=
 =?us-ascii?Q?tsdUZC9llmg0vsQspWcFVnAivMLVFTX10fFxzHu4w5wY0K1J7kMe/koxFF/S?=
 =?us-ascii?Q?KgWnj27UYD4mbKXWApcT6yNoV3GdBhc6d7ldy75PujDr/OwlgLB759Z+RIDn?=
 =?us-ascii?Q?QkvY6a+lmhW8gOtLZIVDsa1nrsYLRP8lwY7Za0bI0WI/lVmV/kklLC5u111p?=
 =?us-ascii?Q?+l7Jnn8hmxaYE3tERf0aAXFCPxaMiCf/wJ5gATAEOQqqPH/64gCoaXxlp22h?=
 =?us-ascii?Q?FP8RhaQ5KGtyiQLip0ufoSTREqlQchn9nYP9sijuNxP0okLikb6ypppFUWky?=
 =?us-ascii?Q?BOx1NFKO05eUyST+q9IGiEzk5z867P4UiLpFXyAeYSQ+LGtZsBnbgnakYlSS?=
 =?us-ascii?Q?mizGyX+wydH1E9m9wEkh758BeQzmeM8Ur8fhvCaHxnjT/hasbj+DclrnsWRS?=
 =?us-ascii?Q?LzLvAIFsj7Ws6/FOzf7YPGExQZquT+fHCFLpdPrEfsPHkRqLALH0oNgohj7j?=
 =?us-ascii?Q?D6RBVeJLv+8ff0w/4Ug0mozi9PmDCzuXESECaTDBBhr49vu5JGA+fflsKgqY?=
 =?us-ascii?Q?PFmc/0aKD+Ve/j73xEFhy9vXoWKzaFEo2pC2ZoMy10S2YgjRmCFmlzvZ8e/J?=
 =?us-ascii?Q?+g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5027306275980F44856944B3930B5D06@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ltUcgAvBIr4FIpsg452ej6qJ80qL1c56waxYM4VQbjg9FjrO8MCixYVzD3kaRS8iiygDW3eO+38rqdkFiKBpA04kuEsOe0JH/DQdJ4ZP/K1gy2WL2UcddLa7QKIVogBgm1U69thsVyemftM6huPczDY/KPP/bJS3GCZx5+YhZcJQgcmvetkDEcZxIwKPDRZexk637vOx6Q97eEps6O0PwjUmy4uJaUKj6UdNR7t9P4BKjrXf6nSatPTbbOn/qCDjDZn9zlQCgP9aCGrhyhH6gUR9r+a5wcTQ1nPvX102yni3hhQebvZ11it3BBMg/EPXJx4nWvFV3D6OAPa8Q9xXaTuuUogWmP+Uy7mberbAH0RHwseAb3y8HWWXqxgmXpHwbvtC79khaBQv34IGor8MSi441IG7zhpilLyVfd7Cu3/6FNMOjhf8uTvE4UU1Z9B8XJyPRKqT/blU9N4MiToQLKMmYybY6Yw/rka5QJE0w3vYG9ZaZkOgpMGm+ku5FtxTbWdbI3mw4Gx+bqhf9URvovDOrhzisIO0VbkSBbbslYkkFvjgixjcsSBJZRHb/RdsM6z9Yul6s5oDsG+O4uD/zq0ecohwaaghlEKT9Hqh1tR6UcTn9+RUalKO7r/kh9bu
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB7765.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2631bf75-749d-40a3-edb3-08dc796da8e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 08:11:47.1354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VDV+lsU7mIR/Nxeok6FeLTOgW/c4ZJljCCFWvSv41EhLnCQS+oOrw4Ud0++r7GhSxC3SmkZJco6RTtftPmesEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6728

On Sat, May 18, 2024 at 02:37:41PM GMT, Qu Wenruo wrote:
> If we have a subpage range like this for a 16K page with 4K sectorsize:
>=20
>     0     4K     8K     12K     16K
>     |/////|      |//////|       |
>=20
>     |/////| =3D dirty range
>=20
> Currently writepage_delalloc() would go through the following steps:
>=20
> - lock range [0, 4K)
> - run delalloc range for [0, 4K)
> - lock range [8K, 12K)
> - run delalloc range for [8K 12K)
>=20
> So far it's fine for regular subpage writeback, as
> btrfs_run_delalloc_range() can only go into one of run_delalloc_nocow(),
> cow_file_range() and run_delalloc_compressed().
>=20
> But there is a special pitfall for zoned subpage, where we will go
> through run_delalloc_cow(), which would create the ordered extent for the
> range and immediately submit the range.
> This would unlock the whole page range, causing all kinds of different
> ASSERT()s related to locked page.
>=20
> This patch would address the page unlocking problem of run_delalloc_cow()=
,
> by changing the workflow to the following one:
>=20
> - lock range [0, 4K)
> - lock range [8K, 12K)
> - run delalloc range for [0, 4K)
> - run delalloc range for [8K, 12K)
>=20
> So that run_delalloc_cow() can only unlock the full page until the
> last lock user released.
>=20
> To do that, this patch would:
>=20
> - Utilizing subpage locked bitmap
>   So for every delalloc range we found, call
>   btrfs_folio_set_writer_lock() to populate the subpage locked bitmap,
>   and later btrfs_folio_end_all_writers() if the page is fully unlocked.
>=20
>   So we know there is a delalloc range that needs to be run later.
>=20
> - Save the @delalloc_end as @last_delalloc_end inside
>   writepage_delalloc()
>   Since subpage locked bitmap is only for ranges inside the page,
>   meanwhile we can have delalloc range ends beyond our page boundary,
>   we have to save the @last_delalloc_end just in case it's beyond our
>   page boundary.
>=20
> Although there is one extra point to notice:
>=20
> - We need to handle errors in previous iteration
>   Since we can have multiple locked delalloc ranges thus we have to call
>   run_delalloc_ranges() multiple times.
>   If we hit an error half way, we still need to unlock the remaining
>   ranges.
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 77 ++++++++++++++++++++++++++++++++++++++++----
>  fs/btrfs/subpage.c   |  6 ++++
>  2 files changed, 76 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 8a4a7d00795f..b6dc9308105d 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1226,13 +1226,22 @@ static inline void contiguous_readpages(struct pa=
ge *pages[], int nr_pages,
>  static noinline_for_stack int writepage_delalloc(struct btrfs_inode *ino=
de,
>  		struct page *page, struct writeback_control *wbc)
>  {
> +	struct btrfs_fs_info *fs_info =3D inode_to_fs_info(&inode->vfs_inode);
> +	struct folio *folio =3D page_folio(page);
>  	const u64 page_start =3D page_offset(page);
>  	const u64 page_end =3D page_start + PAGE_SIZE - 1;
> +	/*
> +	 * Saves the last found delalloc end. As the delalloc end can go beyond
> +	 * page boundary, thus we can not rely on subpage bitmap to locate
> +	 * the last dealloc end.

typo: dealloc -> delalloc

> +	 */
> +	u64 last_delalloc_end =3D 0;
>  	u64 delalloc_start =3D page_start;
>  	u64 delalloc_end =3D page_end;
>  	u64 delalloc_to_write =3D 0;
>  	int ret =3D 0;
> =20
> +	/* Lock all (subpage) dealloc ranges inside the page first. */

Same here.

>  	while (delalloc_start < page_end) {
>  		delalloc_end =3D page_end;
>  		if (!find_lock_delalloc_range(&inode->vfs_inode, page,
> @@ -1240,15 +1249,68 @@ static noinline_for_stack int writepage_delalloc(=
struct btrfs_inode *inode,
>  			delalloc_start =3D delalloc_end + 1;
>  			continue;
>  		}
> -
> -		ret =3D btrfs_run_delalloc_range(inode, page, delalloc_start,
> -					       delalloc_end, wbc);
> -		if (ret < 0)
> -			return ret;
> -
> +		btrfs_folio_set_writer_lock(fs_info, folio, delalloc_start,
> +					    min(delalloc_end, page_end) + 1 -
> +					    delalloc_start);
> +		last_delalloc_end =3D delalloc_end;
>  		delalloc_start =3D delalloc_end + 1;
>  	}

Can we bail out on the "if (!last_delalloc_end)" case? It would make the
following code simpler.

> +	delalloc_start =3D page_start;
> +	/* Run the delalloc ranges for above locked ranges. */
> +	while (last_delalloc_end && delalloc_start < page_end) {
> +		u64 found_start;
> +		u32 found_len;
> +		bool found;
> =20
> +		if (!btrfs_is_subpage(fs_info, page->mapping)) {
> +			/*
> +			 * For non-subpage case, the found delalloc range must
> +			 * cover this page and there must be only one locked
> +			 * delalloc range.
> +			 */
> +			found_start =3D page_start;
> +			found_len =3D last_delalloc_end + 1 - found_start;
> +			found =3D true;
> +		} else {
> +			found =3D btrfs_subpage_find_writer_locked(fs_info, folio,
> +					delalloc_start, &found_start, &found_len);
> +		}
> +		if (!found)
> +			break;
> +		/*
> +		 * The subpage range covers the last sector, the delalloc range may
> +		 * end beyonds the page boundary, use the saved delalloc_end
> +		 * instead.
> +		 */
> +		if (found_start + found_len >=3D page_end)
> +			found_len =3D last_delalloc_end + 1 - found_start;
> +
> +		if (ret < 0) {

At first glance, it is strange because "ret" is not set above. But, it is
executed when btrfs_run_delalloc_range() returns an error in an iteration,
for the remaining iterations...

I'd like to have a dedicated clean-up path ... but I agree it is difficult
to make such cleanup loop clean.

Flipping the if-conditions looks better? Or, adding more comments would be =
nice.

> +			/* Cleanup the remaining locked ranges. */
> +			unlock_extent(&inode->io_tree, found_start,
> +				      found_start + found_len - 1, NULL);
> +			__unlock_for_delalloc(&inode->vfs_inode, page, found_start,
> +					      found_start + found_len - 1);
> +		} else {
> +			ret =3D btrfs_run_delalloc_range(inode, page, found_start,
> +						       found_start + found_len - 1, wbc);

Also, what happens if the first range returns "1" and a later one returns
"0"? Is it OK to override the "ret" for the case? Actually, I guess it
won't happen now because (as said in patch 5) subpage disables an inline
extent, but having an ASSERT() would be good to catch a future mistake.

> +		}
> +		/*
> +		 * Above btrfs_run_delalloc_range() may have unlocked the page,
> +		 * Thus for the last range, we can not touch the page anymore.
> +		 */
> +		if (found_start + found_len >=3D last_delalloc_end + 1)
> +			break;
> +
> +		delalloc_start =3D found_start + found_len;
> +	}
> +	if (ret < 0)
> +		return ret;
> +
> +	if (last_delalloc_end)
> +		delalloc_end =3D last_delalloc_end;
> +	else
> +		delalloc_end =3D page_end;
>  	/*
>  	 * delalloc_end is already one less than the total length, so
>  	 * we don't subtract one from PAGE_SIZE
> @@ -1520,7 +1582,8 @@ static int __extent_writepage(struct page *page, st=
ruct btrfs_bio_ctrl *bio_ctrl
>  					       PAGE_SIZE, !ret);
>  		mapping_set_error(page->mapping, ret);
>  	}
> -	unlock_page(page);
> +
> +	btrfs_folio_end_all_writers(inode_to_fs_info(inode), folio);
>  	ASSERT(ret <=3D 0);
>  	return ret;
>  }
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index 3c957d03324e..81b862d7ab53 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -862,6 +862,7 @@ bool btrfs_subpage_find_writer_locked(const struct bt=
rfs_fs_info *fs_info,
>  void btrfs_folio_end_all_writers(const struct btrfs_fs_info *fs_info,
>  				 struct folio *folio)
>  {
> +	struct btrfs_subpage *subpage =3D folio_get_private(folio);
>  	u64 folio_start =3D folio_pos(folio);
>  	u64 cur =3D folio_start;
> =20
> @@ -871,6 +872,11 @@ void btrfs_folio_end_all_writers(const struct btrfs_=
fs_info *fs_info,
>  		return;
>  	}
> =20
> +	/* The page has no new delalloc range locked on it. Just plain unlock. =
*/
> +	if (atomic_read(&subpage->writers) =3D=3D 0) {
> +		folio_unlock(folio);
> +		return;
> +	}
>  	while (cur < folio_start + PAGE_SIZE) {
>  		u64 found_start;
>  		u32 found_len;
> --=20
> 2.45.0
> =

