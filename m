Return-Path: <linux-btrfs+bounces-8771-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8702D997CBC
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 07:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2225428446D
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 05:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAAE19DF9A;
	Thu, 10 Oct 2024 05:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SQ8d8L2/";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YraQf7Z7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E7F18C03D
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 05:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728539523; cv=fail; b=GuQ3kTCRiSeQntnJFYXSy4T2w9VjAI1fCBX7vbiI6kUNiVcHcjmZdoFfGcyd2WIyX8m3p5xHgyrlWx7GXdy+jO3p3qOCWFQ+G7QuxVjw5h6F7r4JWdWSBy4x6Huowd4eN5wKops3T8Fj8rA4Ngf7zD88JjX4ODEnDwOiVjkFJ+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728539523; c=relaxed/simple;
	bh=D6C55zs/K538auYUQ42zAx7uhqdvg5XfrG1LoZu5L68=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IoubRhS4pB2LiAHU3lBQDUmUGckU9RLdEv1PXVtnOdKurNS65Ehj6A2mqccMUYvX894ynAOjpstB35b2p4dyJFvirx+u1f/f2WJffjmNxg9xik7QvCBCUvZWldw5uj6QZTra9ofnUUKt5pQyE1Ew0K5llWMYQu5Zn2tguE90PpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=SQ8d8L2/; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=YraQf7Z7; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728539522; x=1760075522;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=D6C55zs/K538auYUQ42zAx7uhqdvg5XfrG1LoZu5L68=;
  b=SQ8d8L2/tF+prQTvOeI340Q2ascpXU7fOxlyvsoJzGCeaFkynnessOcr
   HOov2x7iz4Z/v053AP2E2aAPXySokSG77p7qicrUWAqoxfiGwXYupwvAY
   tqzjobI+RtKK/BIfbvT3YQzRZOCCP4ewdcLdlW/4vzEdr9JcPN3A/KPGk
   1/BJSTkCL3Y6VYFtr4PK+JcFseGlIgV8u213ZQwQ7egCrtsnuadOlT0MN
   zKd6wmCGzYk2Au6Oim2EEm/JXfu8driCzwQkoZ9lxN4fjeJIN7/1H/cm5
   +LlzhyJD6dW56Loayi9TSNAMxCfgd0Js44nz6MJqf9gZPK2w6topJMHtD
   w==;
X-CSE-ConnectionGUID: TD/Tm7F4TsmVz661Ia5cKA==
X-CSE-MsgGUID: lAabB3TQSfa2sOmdDu2vgw==
X-IronPort-AV: E=Sophos;i="6.11,192,1725292800"; 
   d="scan'208";a="28741457"
Received: from mail-westcentralusazlp17010007.outbound.protection.outlook.com (HELO CY4PR05CU001.outbound.protection.outlook.com) ([40.93.6.7])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2024 13:51:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8LzyssTXr2vpSaUc6+rt1yDlRsb18ywkFNyzSM/5gWPWR1atW2HYOBfWd8bJ8br/u2bIxlaVv8LbdicPuJ/zFoXWiyph6ZoSX4IhOJ2dPIT176nr+lLxKRVSbiBQ86ZAjZtbliFq/+5XPITLEZTXhmYkLiKIQ1TIq/j6JzGyXX273HjnvNXHiN4Y1YNRPq3F2i7/3Y0F9dvAgI4l2+Nt2tFwvujLiTiKH46R7nds5ayHnhiykNRB9UV4IZ0HBoB1afgB6ppiU0WW23C312UlB+jksG2G2cLbfBTgpc9XToLkG/XHGpnVmbAqsVQ0/m28IbZ+nDaHB3cGc6/esJ5aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yE1OdofeQDi7p8eTNIkI4H2lWU1kp1L29lsXR8yOL2o=;
 b=gWAGBik2tJNZd3GdQZl6DIXvWiTcV0dIY+x4stDguj923dbcnER0tANCSXaOo4Vm7VuIzcfDWTm+4rxWYZgmHpEeCZo+F9fzmMEiomhROtFNn+Tz92cAcSVbgNwH9+8lOGissLDzFAUkGrf6UO31JUU200v8lEySeothyki6rh7u+pf89cYgNUY3Qs9ZO05tkBSPbbzqTMFG3L+U4i/nIKkUE1L1shD1bREBYRWs2x8ksmcuBGPLKJY6svRwjbaqVRrlXK5WaEvo9xgy6xMhcDrtDQkup7w93uKT5Ueo7HbJWVLJEOAxG2oBlftuq67CR6Cpoy5b4lGBlHsB/vwXTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yE1OdofeQDi7p8eTNIkI4H2lWU1kp1L29lsXR8yOL2o=;
 b=YraQf7Z7FDKYhn7JIfEnl86JK0zhsdb4RxjRH7B68lXaVaaFh8NIOO2+XlGr14i83hFJHnxbVn/awXUj/aFeJaIg/uJE5vaKDulpJUXD89AyA9/J0738RLmsSpLQ/gMuRQNlfRMtLHf+VCE8TZzKbyf+IhMVmuExw/r+n/nyZF4=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by IA0PR04MB8835.namprd04.prod.outlook.com (2603:10b6:208:48f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 05:51:51 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%5]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 05:51:50 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: David Sterba <dsterba@suse.cz>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, WenRuo Qu
	<wqu@suse.com>, hch <hch@lst.de>
Subject: Re: [PATCH] btrfs: fix error propagation of split bios
Thread-Topic: [PATCH] btrfs: fix error propagation of split bios
Thread-Index: AQHbGmQKc8ebTW6DfUy+t8NONhFyRLJ+pIyAgADXqoA=
Date: Thu, 10 Oct 2024 05:51:50 +0000
Message-ID: <l37wmp4eebrjz3be5nbezvpdz3dm4u2ilru647yjh3dzjkbg4u@wtxtu4hxuyf4>
References:
 <db5c272fc27c59ddded5c691373c26458698cb1a.1728489285.git.naohiro.aota@wdc.com>
 <20241009165955.GM1609@twin.jikos.cz>
In-Reply-To: <20241009165955.GM1609@twin.jikos.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|IA0PR04MB8835:EE_
x-ms-office365-filtering-correlation-id: 7ad413dc-0e18-44f3-7671-08dce8efa2ef
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?VSfrEnJKYWT0J8rDIfbeDs+GYWwkeGCPZmWOdJ15H0CV0WZXQv8ljnd7x+QQ?=
 =?us-ascii?Q?+4uXbbieGYno5E00NHYP7o1wlgDxje4+WI7ufOOAy4Kd+Ix2NlcO90/hzB/r?=
 =?us-ascii?Q?LKAH994PaYCc0s3LeYYiAZFNwZaCOI2NBvlYV740AY5LB2fE9MOkFVUZeDlP?=
 =?us-ascii?Q?Cn7N1EsMWK4E6Ez9yrPYe+T9H8Sewc/cllHNYNYimuqc35IhqPyW8H79b2Yi?=
 =?us-ascii?Q?dcL8+kiG4rQn2TmXCndvPEcvuERUGqeEdZCJwgQDvbDWN7OEVQ+1F35otMSn?=
 =?us-ascii?Q?BNU3REyDMNxmcMj1gkkbpdLqkwB79tiJfHzwhd8LzDLo0gwiKYLeIRgORHKX?=
 =?us-ascii?Q?A3m8AlcILh4r+Ci5VnsncXf0Py4C/fESabKHZ6Nk4qz7PamVFPjAuV8cOioM?=
 =?us-ascii?Q?Z3M59UX2MbYr3MBJPBEwrvetY//Hg2IEu4UXR5/wJoS18xpTqEA7+PT0TjEx?=
 =?us-ascii?Q?pCkuEyvQ4+Mxl4xVGdtHOZRXlaC8Heu6PcO9gLWWMm44CESKcidu1/BUh/K0?=
 =?us-ascii?Q?zzn9p0QftiTaNRyDLL/fu8Xgh10kfdZkzbWlbyZiDoFoVf8kPuuZJZ6F9aBf?=
 =?us-ascii?Q?YJrzKIQpOBgfkvA5YCzX8XK8nVt14CNoJSx3WDofOtG1ZdaTEh9M7f0rdg3j?=
 =?us-ascii?Q?kXWWqNKnHtpdEw25ztsJ0Zg0y4AoPqMmsmQtkOQBg+U1GIid4jiNpYJYgQbo?=
 =?us-ascii?Q?LvMkvWACLTvkIhuVy5OXSE7viQJUYxMhtT44s1miFWqolmDS+noJM4A0y9Ot?=
 =?us-ascii?Q?Y7tvLO15G0myIoZ8D1kh5sgfqCM/7wz8c2bYC05ZECw/jhSf9+zwEn0XiXev?=
 =?us-ascii?Q?QCj1bB/3Jg/ZTv0LXZD4TpYI+3anuuXBNb5pgNgER40Htur16Kr/i2JxF+ui?=
 =?us-ascii?Q?8BjVeOBmQG5z6Lj53FfiXbt381p5OQE15OysPA4wVHb7Dlh8Krg8JD3LI71S?=
 =?us-ascii?Q?k8REbayAXmY5MfN371dYTv/k6i7nSKN0MopY7CHVxL4gP82xn+Hehm2VdPSO?=
 =?us-ascii?Q?WA1ylILGESBKStqzNMfJo/Ok/AsJRCX32VOMPtYQVCGS3aFUUFhOons5eL3v?=
 =?us-ascii?Q?RCigcXBvJnwQs1mrl/1bE5DsxW6zUheTa9N1l5v/mTPVfHQ1xKt4VaqTnG4T?=
 =?us-ascii?Q?4J6r1Z8A908yE971leK1piIouuq7l4QCBUevGfch1daJ/Yx1mM8r9B/8I/vc?=
 =?us-ascii?Q?OFBWPcgkGu+UXWSyZHRJ6z+vGS4V8n0G5bY7cgu8IvY5PcwX4TQP/GUk+SgG?=
 =?us-ascii?Q?Iyn10upk4/vsDW8YFvX7HPu4OhpdsDPcPnUMZFKwkqdPuGqlHId6AdwJTvp6?=
 =?us-ascii?Q?owM/7lYxtxjbPns5g/iOvhihNlobnIHPQcnpS4k2ZN0oeg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?e1oUIUOINKOOsaxAQBAfa0RwEsW7kCGaXrvJXjna7X2df+Naz/MAHTDvlsyQ?=
 =?us-ascii?Q?5p45HA4vz9MomwtShrvibiodg9x2tVux9ES5koqEdQIBwzFiw/llHmEK3qvu?=
 =?us-ascii?Q?Up9ukoUgtz4CNt2VVBHp/akaiEp69xR/Zal8nW04lWFuT2xjScbIRJpDi/4y?=
 =?us-ascii?Q?UNXSSDkZXjScRC9rb7fx6p8jVk0F0j5+NS15Iwoi8xqnTZAaXmahajg6ZrSg?=
 =?us-ascii?Q?a/EBlzfDSkGOLVUnBlVzmdg9XQB3GoDakqerweeBnOFuRjHk5Z6AC+siWKYQ?=
 =?us-ascii?Q?iCkWVTR8y0lXN5H82yEnemjF+1ddYJhz20LWSIqgJumDbQ7Wz1HrFvO2BgMz?=
 =?us-ascii?Q?jqZbnHJY7F8CE+vgFrwMKX87EtUGnZfFpOOHaBE5+2h0nwP6QMc++0yN1dcw?=
 =?us-ascii?Q?eEtAESslxHyIlkt8Kb0UZgmjNRvYCh4IJhLLiLyK3ee3iyBA3zhR/5H/DCWe?=
 =?us-ascii?Q?qxFN1eHOMSF/ogoYDqZ1V0HcxnzqKtmyShhJB2JmtMgyukMDPKJbg0Wo4wfo?=
 =?us-ascii?Q?lLyWnT3xT+mRP363vmmUvjqcntscYfyPI5gbe7ZglGgFAbdgRKIN6ojdfdfI?=
 =?us-ascii?Q?KYXlyLcbZJvG2tfK1W2kPHxSHXpm7QhuV2k48SKKtTqjHDxwfA2zCJd5APhp?=
 =?us-ascii?Q?xlgdVnB2uCHb0Fo2imsayhKhe1kUGcHdF+Y2XrnJgft2dLPLc0nBzo8Q1CxG?=
 =?us-ascii?Q?/qqnZr62IdI6X+VmoYGcBAK//SBAOIxR2L4h8IKHYlcTmPuktjZIZ7PYyofN?=
 =?us-ascii?Q?MRA5UiB8z1vXcAuHXlFqx59x0p2GbIiHhVlmkg945TmMq4nMNxzYi+dhk5/L?=
 =?us-ascii?Q?xRugLF6b0FCIVjlGhSrW99VIZgq+GL8ivVYmYFqj9OB1wetJQJwcS1LqpWUN?=
 =?us-ascii?Q?iH12tQ9PS1AzW13RmFgQFHKrouD0UKqMGDWVO0B9+vJkEZ6002B4710giEyl?=
 =?us-ascii?Q?C6Wglk2RifNuwcX+cZek3vhhJxgf41I3LqDf9PKKc4edJSZnDPyBHMfCZTik?=
 =?us-ascii?Q?4BHs6T856w40vwz/S9kPAafWV6UlcNj7uQC1jP6tmi1hJ3Jo42fIM1ZbeVy0?=
 =?us-ascii?Q?HJ8j38qx9NXX9/KZ09FRRkZ9BfiDPUuuLX6885SLvd7tmtBC8s+vW01eVjAr?=
 =?us-ascii?Q?Oke35WVQQJYXpgKNtE+dcvBFcnhgAm3VwEJTRmWyZ0PgApvrH/NT2X7Rqwug?=
 =?us-ascii?Q?GcKlMcIDE3Q/Ynk2jwEX3STQ5hqZH8mfI3gnCrFRtasVjLEvzkKrbQb2d43G?=
 =?us-ascii?Q?EikILc2HW74QEtQDrpFT3aX0tArRn4bu+H4tzFK1LCUXKtAQT4y5xMh6SHMz?=
 =?us-ascii?Q?A9oLLEjUUPtW41wwekRtMgOMecI93vnEOpNUoSBrB/JJD/MxuBxdEqWLr6FL?=
 =?us-ascii?Q?k8lhFdIqkKjjrwPFCXebBDKRXjj5c4qxnY325uZN13nY+xS8k1k+iHvU9ybs?=
 =?us-ascii?Q?6IYkG9L0ckJUKZ2vRT5P0f9Qjau3CwOXxATAlELBDvr44d05PHQdG7FCP2wX?=
 =?us-ascii?Q?DEMoizTlLgUx6APCvuA0Pde4s0deHjv2tfp5hieKK2Z9N4nOU8AVpKdIGM0a?=
 =?us-ascii?Q?edKTKX//Iezbq/gs32ndl58tjoY7fhv/mJX8tsafrKbARxYvblm5j450DV5O?=
 =?us-ascii?Q?CQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <05CBDEE6C410EC4FB1199E378F931CE0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yWVSEbagLr2Dqq3QFtzGJqEAvRQR5pJKmxLSSP5aW3uTyPNCCm3uP9fvB+QULvdjLBg5wQ4zNFOoQPxXwz9u5cdWgWbsygZMKIbwXZWXl03ySTToyeE+vJbp7qYVEsVVbsMeCTFT3kBsUVltWK7RdVgAOnKdA334PVNbWvzXGRpYHm0wMgL3o+UVhMzHC8YS9k7cGVpL60esNsCB6Y1y4mT2nvgc027Ia60hwAyqx8VNsiNTbItVVWLVzvQmXKsBwQU8w3LpSDvyt47CjRloXhwds4CsOnLD7jWWmbOpbpbvjC7lZdjBHbuORGwXL+6HNiEDhltrNuGr0KbUOSZERP5lJAdg1wISNSxYefQHZCDUgnjiSBKnAbJrbmsqri39i7WNDO/mUSOmRhtd8qBSS1BxuegAFAdJ9Khu+2OjNX8gueRQreIQjl5F7nRXg9qnaNwcXCYx8ID5qzVBEqWwkRnMONK5kKHh4mFTjI3jyJ6wQikENSpUWOnNHoXFWORhvQ9dQvwVnxmYETwFkEETLo3MswCldcAl1yG2agMU3/HmH/2MkPqn464oFyFgG1RLkBHdNcriPlQlvcQBXPexVDZcOT+dmNx8bRi9dvK0xIhF+HBVCD4b+0+sROS5fkVj
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad413dc-0e18-44f3-7671-08dce8efa2ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 05:51:50.8010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 335St8sVEgNu9y/5/fiD/y5yEg+8BCTAtlUYRu2o6gucUQIGeOzccOIdp/HBJguY8Ej7bxY5/fA5EFN0scGzxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR04MB8835

On Wed, Oct 09, 2024 at 06:59:55PM GMT, David Sterba wrote:
> On Thu, Oct 10, 2024 at 12:57:50AM +0900, Naohiro Aota wrote:
> > The purpose of btrfs_bbio_propagate_error() shall be propagating an err=
or
> > of split bio to its original btrfs_bio, and tell the error to the upper
> > layer. However, it's not working well on some cases.
> >=20
> > * Case 1. Immediate (or quick) end_bio with an error
> >=20
> > When btrfs sends btrfs_bio to mirrored devices, btrfs calls
> > btrfs_bio_end_io() when all the mirroring bios are completed. If that
> > btrfs_bio was split, it is from btrfs_clone_bioset and its end_io funct=
ion
> > is btrfs_orig_write_end_io. For this case, btrfs_bbio_propagate_error()
> > accesses the orig_bbio's bio context to increase the error count.
> >=20
> > That works well in most cases. However, if the end_io is called enough
> > fast, orig_bbio's bio context may not be properly set at that time. Sin=
ce
> > the bio context is set when the orig_bbio (the last btrfs_bio) is sent =
to
> > devices, that might be too late for earlier split btrfs_bio's completio=
n.
> > That will result in NULL pointer dereference.
> >=20
> > That bug is easily reproducible by running btrfs/146 on zoned devices a=
nd
> > it shows the following trace.
> >=20
> >     [   20.923980][   T13] BUG: kernel NULL pointer dereference, addres=
s: 0000000000000020
> >     [   20.925234][   T13] #PF: supervisor read access in kernel mode
> >     [   20.926122][   T13] #PF: error_code(0x0000) - not-present page
> >     [   20.927118][   T13] PGD 0 P4D 0
> >     [   20.927607][   T13] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
> >     [   20.928424][   T13] CPU: 1 UID: 0 PID: 13 Comm: kworker/u32:1 No=
t tainted 6.11.0-rc7-BTRFS-ZNS+ #474
> >     [   20.929740][   T13] Hardware name: Bochs Bochs, BIOS Bochs 01/01=
/2011
> >     [   20.930697][   T13] Workqueue: writeback wb_workfn (flush-btrfs-=
5)
> >     [   20.931643][   T13] RIP: 0010:btrfs_bio_end_io+0xae/0xc0 [btrfs]
> >     [   20.932573][ T1415] BTRFS error (device dm-0): bdev /dev/mapper/=
error-test errs: wr 2, rd 0, flush 0, corrupt 0, gen 0
> >     [   20.932871][   T13] Code: ba e1 48 8b 7b 10 e8 f1 f5 f6 ff eb da=
 48 81 bf 10 01 00 00 40 0c 33 a0 74 09 40 88 b5 f1 00 00 00 eb b8 48 8b 85=
 18 01 00 00 <48> 8b 40 20 0f b7 50 24 f0 01 50 20 eb a3 0f 1f 40 00 90 90 =
90 90
> >     [   20.936623][   T13] RSP: 0018:ffffc9000006f248 EFLAGS: 00010246
> >     [   20.937543][   T13] RAX: 0000000000000000 RBX: ffff888005a7f080 =
RCX: ffffc9000006f1dc
> >     [   20.938788][   T13] RDX: 0000000000000000 RSI: 000000000000000a =
RDI: ffff888005a7f080
> >     [   20.940016][   T13] RBP: ffff888011dfc540 R08: 0000000000000000 =
R09: 0000000000000001
> >     [   20.941227][   T13] R10: ffffffff82e508e0 R11: 0000000000000005 =
R12: ffff88800ddfbe58
> >     [   20.942375][   T13] R13: ffff888005a7f080 R14: ffff888005a7f158 =
R15: ffff888005a7f158
> >     [   20.943531][   T13] FS:  0000000000000000(0000) GS:ffff88803ea80=
000(0000) knlGS:0000000000000000
> >     [   20.944838][   T13] CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800=
50033
> >     [   20.945811][   T13] CR2: 0000000000000020 CR3: 0000000002e22006 =
CR4: 0000000000370ef0
> >     [   20.946984][   T13] DR0: 0000000000000000 DR1: 0000000000000000 =
DR2: 0000000000000000
> >     [   20.948150][   T13] DR3: 0000000000000000 DR6: 00000000fffe0ff0 =
DR7: 0000000000000400
> >     [   20.949327][   T13] Call Trace:
> >     [   20.949949][   T13]  <TASK>
> >     [   20.950374][   T13]  ? __die_body.cold+0x19/0x26
> >     [   20.951066][   T13]  ? page_fault_oops+0x13e/0x2b0
> >     [   20.951766][   T13]  ? _printk+0x58/0x73
> >     [   20.952358][   T13]  ? do_user_addr_fault+0x5f/0x750
> >     [   20.953120][   T13]  ? exc_page_fault+0x76/0x240
> >     [   20.953827][   T13]  ? asm_exc_page_fault+0x22/0x30
> >     [   20.954606][   T13]  ? btrfs_bio_end_io+0xae/0xc0 [btrfs]
> >     [   20.955616][   T13]  ? btrfs_log_dev_io_error+0x7f/0x90 [btrfs]
> >     [   20.956682][   T13]  btrfs_orig_write_end_io+0x51/0x90 [btrfs]
> >     [   20.957769][   T13]  dm_submit_bio+0x5c2/0xa50 [dm_mod]
> >     [   20.958623][   T13]  ? find_held_lock+0x2b/0x80
> >     [   20.959339][   T13]  ? blk_try_enter_queue+0x90/0x1e0
> >     [   20.960228][   T13]  __submit_bio+0xe0/0x130
> >     [   20.960879][   T13]  ? ktime_get+0x10a/0x160
> >     [   20.961546][   T13]  ? lockdep_hardirqs_on+0x74/0x100
> >     [   20.962310][   T13]  submit_bio_noacct_nocheck+0x199/0x410
> >     [   20.963140][   T13]  btrfs_submit_bio+0x7d/0x150 [btrfs]
> >     [   20.964089][   T13]  btrfs_submit_chunk+0x1a1/0x6d0 [btrfs]
> >     [   20.965066][   T13]  ? lockdep_hardirqs_on+0x74/0x100
> >     [   20.965824][   T13]  ? __folio_start_writeback+0x10/0x2c0
> >     [   20.966659][   T13]  btrfs_submit_bbio+0x1c/0x40 [btrfs]
> >     [   20.967617][   T13]  submit_one_bio+0x44/0x60 [btrfs]
> >     [   20.968536][   T13]  submit_extent_folio+0x13f/0x330 [btrfs]
> >     [   20.969552][   T13]  ? btrfs_set_range_writeback+0xa3/0xd0 [btrf=
s]
> >     [   20.970625][   T13]  extent_writepage_io+0x18b/0x360 [btrfs]
> >     [   20.971632][   T13]  extent_write_locked_range+0x17c/0x340 [btrf=
s]
> >     [   20.972702][   T13]  ? __pfx_end_bbio_data_write+0x10/0x10 [btrf=
s]
> >     [   20.973857][   T13]  run_delalloc_cow+0x71/0xd0 [btrfs]
> >     [   20.974841][   T13]  btrfs_run_delalloc_range+0x176/0x500 [btrfs=
]
> >     [   20.975870][   T13]  ? find_lock_delalloc_range+0x119/0x260 [btr=
fs]
> >     [   20.976911][   T13]  writepage_delalloc+0x2ab/0x480 [btrfs]
> >     [   20.977792][   T13]  extent_write_cache_pages+0x236/0x7d0 [btrfs=
]
> >     [   20.978728][   T13]  btrfs_writepages+0x72/0x130 [btrfs]
> >     [   20.979531][   T13]  do_writepages+0xd4/0x240
> >     [   20.980111][   T13]  ? find_held_lock+0x2b/0x80
> >     [   20.980695][   T13]  ? wbc_attach_and_unlock_inode+0x12c/0x290
> >     [   20.981461][   T13]  ? wbc_attach_and_unlock_inode+0x12c/0x290
> >     [   20.982213][   T13]  __writeback_single_inode+0x5c/0x4c0
> >     [   20.982859][   T13]  ? do_raw_spin_unlock+0x49/0xb0
> >     [   20.983439][   T13]  writeback_sb_inodes+0x22c/0x560
> >     [   20.984079][   T13]  __writeback_inodes_wb+0x4c/0xe0
> >     [   20.984886][   T13]  wb_writeback+0x1d6/0x3f0
> >     [   20.985536][   T13]  wb_workfn+0x334/0x520
> >     [   20.986044][   T13]  process_one_work+0x1ee/0x570
> >     [   20.986580][   T13]  ? lock_is_held_type+0xc6/0x130
> >     [   20.987142][   T13]  worker_thread+0x1d1/0x3b0
> >     [   20.987918][   T13]  ? __pfx_worker_thread+0x10/0x10
> >     [   20.988690][   T13]  kthread+0xee/0x120
> >     [   20.989180][   T13]  ? __pfx_kthread+0x10/0x10
> >     [   20.989915][   T13]  ret_from_fork+0x30/0x50
> >     [   20.990615][   T13]  ? __pfx_kthread+0x10/0x10
> >     [   20.991336][   T13]  ret_from_fork_asm+0x1a/0x30
> >     [   20.992106][   T13]  </TASK>
> >     [   20.992482][   T13] Modules linked in: dm_mod btrfs blake2b_gene=
ric xor raid6_pq rapl
> >     [   20.993406][   T13] CR2: 0000000000000020
> >     [   20.993884][   T13] ---[ end trace 0000000000000000 ]---
> >     [   20.993954][ T1415] BUG: kernel NULL pointer dereference, addres=
s: 0000000000000020
> >=20
> > * Case 2. Earlier completion of orig_bbio for mirrored btrfs_bios
> >=20
> > btrfs_bbio_propagate_error() assumes the end_io function for orig_bbio =
is
> > called last among split bios. In that case, btrfs_orig_write_end_io() s=
ets
> > the bio->bi_status to BLK_STS_IOERR by seeing the bioc->error [1].
> > Otherwise, the increased orig_bio's bioc->error is not checked by anyon=
e
> > and return BLK_STS_OK to the upper layer.
> >=20
> > [1] Actually, this is not true. Because we only increases orig_bioc->er=
rors
> > by max_errors, the condition "atomic_read(&bioc->error) > bioc->max_err=
ors"
> > is still not met if only one split btrfs_bio fails.
> >=20
> > * Case 3. Later completion of orig_bbio for un-mirrored btrfs_bios
> >=20
> > In contrast to the above case, btrfs_bbio_propagate_error() is not work=
ing
> > well if un-mirrored orig_bbio is completed last. It sets
> > orig_bbio->bio.bi_status to the btrfs_bio's error. But, that is easily
> > over-written by orig_bbio's completion status. If the status is BLK_STS=
_OK,
> > the upper layer would not know the failure.
> >=20
> > * Solution
> >=20
> > Considering the above cases, we can only save the error status in the
> > orig_bbio itself as it is always available. Also, the saved error statu=
s
> > should be propagated when all the split btrfs_bios are finished (i.e,
> > bbio->pending_ios =3D=3D 0).
> >=20
> > This commit introduces "status" to btrfs_bbio and uses the last saved e=
rror
> > status for bbio->bio.bi_status.
> >=20
> > With this commit, btrfs/146 on zoned devices does not hit the NULL poin=
ter
> > dereference.
> >=20
> > Fixes: 852eee62d31a ("btrfs: allow btrfs_submit_bio to split bios")
> > CC: stable@vger.kernel.org # 6.6+
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >  fs/btrfs/bio.c | 33 +++++++++------------------------
> >  fs/btrfs/bio.h |  3 +++
> >  2 files changed, 12 insertions(+), 24 deletions(-)
> >=20
> > diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> > index 056f8a171bba..a43d88bdcae7 100644
> > --- a/fs/btrfs/bio.c
> > +++ b/fs/btrfs/bio.c
> > @@ -49,6 +49,7 @@ void btrfs_bio_init(struct btrfs_bio *bbio, struct bt=
rfs_fs_info *fs_info,
> >  	bbio->end_io =3D end_io;
> >  	bbio->private =3D private;
> >  	atomic_set(&bbio->pending_ios, 1);
> > +	atomic_set(&bbio->status, BLK_STS_OK);
> >  }
> > =20
> >  /*
> > @@ -120,41 +121,25 @@ static void __btrfs_bio_end_io(struct btrfs_bio *=
bbio)
> >  	}
> >  }
> > =20
> > -static void btrfs_orig_write_end_io(struct bio *bio);
> > -
> > -static void btrfs_bbio_propagate_error(struct btrfs_bio *bbio,
> > -				       struct btrfs_bio *orig_bbio)
> > -{
> > -	/*
> > -	 * For writes we tolerate nr_mirrors - 1 write failures, so we can't
> > -	 * just blindly propagate a write failure here.  Instead increment th=
e
> > -	 * error count in the original I/O context so that it is guaranteed t=
o
> > -	 * be larger than the error tolerance.
> > -	 */
> > -	if (bbio->bio.bi_end_io =3D=3D &btrfs_orig_write_end_io) {
> > -		struct btrfs_io_stripe *orig_stripe =3D orig_bbio->bio.bi_private;
> > -		struct btrfs_io_context *orig_bioc =3D orig_stripe->bioc;
> > -
> > -		atomic_add(orig_bioc->max_errors, &orig_bioc->error);
> > -	} else {
> > -		orig_bbio->bio.bi_status =3D bbio->bio.bi_status;
> > -	}
> > -}
> > -
> >  void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
> >  {
> >  	bbio->bio.bi_status =3D status;
> >  	if (bbio->bio.bi_pool =3D=3D &btrfs_clone_bioset) {
> >  		struct btrfs_bio *orig_bbio =3D bbio->private;
> > =20
> > -		if (bbio->bio.bi_status)
> > -			btrfs_bbio_propagate_error(bbio, orig_bbio);
> > +		/* Save the last error. */
> > +		if (bbio->bio.bi_status !=3D BLK_STS_OK)
> > +			atomic_set(&orig_bbio->status, bbio->bio.bi_status);
> >  		btrfs_cleanup_bio(bbio);
> >  		bbio =3D orig_bbio;
> >  	}
> > =20
> > -	if (atomic_dec_and_test(&bbio->pending_ios))
> > +	if (atomic_dec_and_test(&bbio->pending_ios)) {
> > +		/* Load split bio's error which might be set above. */
> > +		if (status =3D=3D BLK_STS_OK)
> > +			bbio->bio.bi_status =3D atomic_read(&bbio->status);
> >  		__btrfs_bio_end_io(bbio);
> > +	}
> >  }
> > =20
> >  static int next_repair_mirror(struct btrfs_failed_bio *fbio, int cur_m=
irror)
> > diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> > index e48612340745..b8f7f6071bc2 100644
> > --- a/fs/btrfs/bio.h
> > +++ b/fs/btrfs/bio.h
> > @@ -79,6 +79,9 @@ struct btrfs_bio {
> >  	/* File system that this I/O operates on. */
> >  	struct btrfs_fs_info *fs_info;
> > =20
> > +	/* Set the error status of split bio. */
> > +	atomic_t status;
>=20
> To repeat my comments from slack here. This should not be atomic when
> it's using only set and read, a plain int or blk_sts_t.

Yes, I'll change this to blk_status_t for better understanding.

>=20
> The logic of storing the last error in btrfs_bio makes sense, I don't
> see other ways to do it. If there are multiple errors we can store the
> first one or the last one, we'd always lose some information. When it's
> the first one it could be set by cmpxchg.

Sure. I'll use cmpxchg to save the first one.=

