Return-Path: <linux-btrfs+bounces-5016-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B25128C6BC2
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 19:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEFA81C21E1E
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 17:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DE7158DAF;
	Wed, 15 May 2024 17:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HDmkRfeW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tsGI8/E6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ABA433BC;
	Wed, 15 May 2024 17:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715795913; cv=fail; b=KwuFQWh3BHtV6cBKB2Bb5kPNSW6SPfhDyAyRTLTXXVk7R5w2nGjYMvSG5W5bAIuTXw2x/QxqRzHyCGkw0BUnZaoH3vlqyBlaFknT6Su6CgMY/w69sEuXoXYNPAwJTSYVlBtLSOochYohS3rktoVbtN+87aukm/N5BSz33LgWG/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715795913; c=relaxed/simple;
	bh=T5GNTB0EPROWOQ3kmYgadY/w4RgA/GGGVIcb/hDb9TU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=onorBaS26XDrOw3ZvYHh0N+JHeEzPALKa6alro8MKqszCnQRvrqc6aKlua/8zeDV2qB1ASn/YwComp744wEMXZhFdR6WLgYy7+9D32ZyhecDqjFIkc06m+4qsVuVCYm0SMzjheDwP9pZU+d5guLv6gi6SC1gwfduQpPQ/j4nLrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HDmkRfeW; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=tsGI8/E6; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1715795911; x=1747331911;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=T5GNTB0EPROWOQ3kmYgadY/w4RgA/GGGVIcb/hDb9TU=;
  b=HDmkRfeWgQEkyttDeL7R0v9Blz7g2HLJ7Leo/HpyQVtudBERQ6Ucu8GN
   /eign0cR5gNyw60xI4ViDZNSVPd1O80E+js8vtqPO64qhJ4unildL4BOi
   Vkw1n2MgRPFZPuaC2KlFUzO8UrpZDF31uyl16Y6ygq9RxbxpQsgyNp8Uu
   qqLExq7zvb2sM5+2UaJs9Lqs+g1F/HZuQQn7wGsBCaUXjD04a56HkZN7v
   2iHgmVlxvD20vsJIH01Asx7YZRUrA5OP5FpxQh1Jx4tOp9T/X41PCVT1U
   Q+2BN6Lz4HT6aCgj/dbY8e/tvLLcINwg1aKitAHZzgT3yVsIIS0pjdxv9
   g==;
X-CSE-ConnectionGUID: 3K7fn9zzTHmIh09mGMqTSA==
X-CSE-MsgGUID: Eot63qFKQ9afQyFTAonsFA==
X-IronPort-AV: E=Sophos;i="6.08,162,1712592000"; 
   d="scan'208";a="16417753"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2024 01:58:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcVxnZo+I/BF3MRE72Wm7B6vMlTHLB97lABLpLcWTJ8P+xrYmWOJN+7CYlFL2Mf1A2Z3PNEQnwAhxPHwI9ETeJlGresYDw1eVMCkM+OWFd7bNpUeJ+8v6ymau06CCY1qp1wNBmWcixFWnci/3bI5MaktxrxkCznRoI5VeTNm/0hu0XpTmNVJFjd+rpwmgPc2qHzoGI9c3oSdfvOZpv+zqtas6MQfOf/vP6nj8kVqcmpRL24t3g6G1Yd7KP6UUjTNJMc/7YH9/gkggfDCQzJSEvH1+J8S3/rrw1BGFRMzLpS4CgMQy4dP3kgVXQqOU0pQzz9SHbVf/0xj0lR/XM3UGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vFoTyffJx4F7XZHFLCmJWol8kCyUqbfCQH7gZpnPZc=;
 b=LnT70z9M+hpaETeVz/0EL+CzlpgMHXcFmz2rP/7+WwqhLIL2XGSZ9i6Qbx8SBZikh2wKI1RFE+NKME0DsRE1/DICWCqwfj+dFvgPRNw8qz9kc3zmONrUZVa7mdxj58zr92FGUk8cHg4IW0m6wKw4Xst+Eo/CtHfVSrLHVve/XgkOCdAxIi1bXTBnfCurLq5lfiV2xTQefGYkr3PFuB13vfLdGG7yrFHf1tXYWr3I5mmD5PvMZePJovssuVA+KpUZ1yPyXL5xEBsZF9+WwDAcZsCh4JiEyvj394gjMm1pLVsMZTCmr3w+iuvqaLNlNjjzQWffHsnf3vLDVUPYsTMxFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vFoTyffJx4F7XZHFLCmJWol8kCyUqbfCQH7gZpnPZc=;
 b=tsGI8/E6JLHZg++GFD97Kdg4wOKFkYkTGs9MlTzQuaBGH9xRWSLFpB5bbKy5FEClZI7u+/3JeiokkF8kJX5ZAfo9W+l5SHuVNDQcrz4ZeG/YCnb4K6Wdu/z16D3Dd7fNtvSpQML6flPYwt2RRV2jdaxLv0n7f3mKq2/tXVnVEC0=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by PH8PR04MB8613.namprd04.prod.outlook.com (2603:10b6:510:259::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 17:58:24 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::7dd0:5b70:1ece:6b57]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::7dd0:5b70:1ece:6b57%3]) with mapi id 15.20.7587.025; Wed, 15 May 2024
 17:58:24 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <jth@kernel.org>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, Hans Holmberg <Hans.Holmberg@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Johannes
 Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH 1/2] btrfs: zoned: reserve relocation zone on mount
Thread-Topic: [PATCH 1/2] btrfs: zoned: reserve relocation zone on mount
Thread-Index: AQHapkOfs6XfoKOaFU6yKgJdnaEZG7GYllqA
Date: Wed, 15 May 2024 17:58:23 +0000
Message-ID: <5tffp7f57i7f4om4tiqyamn463onnzkswbn4bathr2xkrhx5cv@fqfykq5t23al>
References: <20240514-zoned-gc-v1-0-109f1a6c7447@kernel.org>
 <20240514-zoned-gc-v1-1-109f1a6c7447@kernel.org>
In-Reply-To: <20240514-zoned-gc-v1-1-109f1a6c7447@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|PH8PR04MB8613:EE_
x-ms-office365-filtering-correlation-id: 91bc79c5-f73b-4045-02f3-08dc75089d65
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?jkXgK8t9M6loIZOhbhpx9M+szyw3LWfpPwNn9h0rW6WIrWvw6KvG6Y4g4YVW?=
 =?us-ascii?Q?7M6OCXqjlE6NDHR+uYg0ytQixHTSeLIIq+IgpkMX8epWgqoDtgzaPzzQVLIo?=
 =?us-ascii?Q?qxKm9r0Kzer+OZMbDEALgRusTFXYd7H9Va8uOnZN5+BTmo7maapxfcNHr3/s?=
 =?us-ascii?Q?hSB0O6toxfpO1Yf4Je7Tu7/CCorBbFajBWVi1DzqXYCRepKU2CXpA2V4wp4N?=
 =?us-ascii?Q?v8VTxVlUcLt5D9ajOgzehjoCIavhYgIM/2jEgo1uM1zmL9OpJB+SX8nOhhF5?=
 =?us-ascii?Q?HJJoFCdl+pHkGBenILBQbu5k52H1ETXosbarKgWNgNuLbnCxS5gF0ZtkJzFJ?=
 =?us-ascii?Q?WFwMzTJI3W7pji1ZW/+gWWY6unci1egxBJiiHhaJfIXuhHAh9xLrDKHMOjBn?=
 =?us-ascii?Q?Nh9CFV+NFdnLiANYYvMjDUCj1OuKhswBmR40879li8u1qo1b0wQuhn0ks+74?=
 =?us-ascii?Q?v2OqLWPZMWtJomLieKM9I33VW3kylWwFDzUfMJR3949J+mI0efqve0vNqkOl?=
 =?us-ascii?Q?a/K/0sKNLCZXEFrlRkdV8yxb52k+wjoheLqnG6yY7M+LKn2sjrCFRbS5xTRJ?=
 =?us-ascii?Q?v7PQbm4DR6BIqIdGzT4KQoKn+AjrneJiDbguYLlEv7JA/kPdLCg55IaLZd9r?=
 =?us-ascii?Q?p5x5WxFMMLMJiLfa6AzNYmvKkp1uH2LXbV2bxwps3Y1kfFgHkuh0zOJk1858?=
 =?us-ascii?Q?rE7aooJott+QA3IGT6q4pI3rebla/jX64t94tY4NUJDc1jTGGWoN95+bwgm/?=
 =?us-ascii?Q?1nFKLAY5YIVVYHyNRDs/bUujVqycQ5o3rA5O/7SRp9cLWpaxDM2FbHrFOg7v?=
 =?us-ascii?Q?tY0SuEAeoBY3qDNGqQssk13DJIt4pqnK3D7HbTq/qsLFmfybBEGjYuBlEjTY?=
 =?us-ascii?Q?YzDWl9D3npYsFcijQiYYu3xEgxhYyaXb5RVEgQYxyatYg5nh2f7abV93csv+?=
 =?us-ascii?Q?Q19jd83DHEYC0CF+UncuqJtG5q3gyYHNiylhMZ/FznNoPjFbPmDUoNIANj70?=
 =?us-ascii?Q?JRxKTrcOM4C2/fdbssUQ7v6JL8w8ja7REcHTHHi5oGL4CoHb3MA8ZNueVc5I?=
 =?us-ascii?Q?YN5ckkDo7nd8rFoxEXXMC5NU11y4X4tpupUgOdrR4nCZMH0FL1SatQHdlbNp?=
 =?us-ascii?Q?FbxUyX2tHpzPebYopqDR0S3LCDjo9FLJMCaMMzmrMxpgIGcYAcs+7BfnEWdK?=
 =?us-ascii?Q?Y44V7/hJcFA6TY09I8jIjoQCMGXDZpNpL7Nrx5QE/OOlKavgM9mAn8wYmdwZ?=
 =?us-ascii?Q?fyBiNQOsaLve9iyYtgudql8BdF7rG0m4+gSdGVz00MfICV81yJDzHQjWK19x?=
 =?us-ascii?Q?r0z5yTKYRvvtElvMsFxvebpR?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?59oIFv3/3bHN+9u7k0e7M7N848wgGxH4Om/FjTpT3C5Pblosdw0u7ak11JsC?=
 =?us-ascii?Q?xsKyVJlwl4uJs/K+YS5CYtX1+Mqq3UN25NoP6j3Ku+ppfbOpReU4L+lcGKnd?=
 =?us-ascii?Q?WfpHjD9/J31wsU7TdNfuOciA0rRfhGQZTheA8vc2NoHkO5xrFb5pwSCPCh8M?=
 =?us-ascii?Q?v9mBdAEJ+dqYfP8tWLlVmwl1hKZzd644ATH9cv3C3fCfEm8ZphIjh2zqThTt?=
 =?us-ascii?Q?xMtSPnIStDJ8HqZfRmbbyJA0VSECGFEXkZGiuvh3M8K/+kgMciywg26/PZyr?=
 =?us-ascii?Q?yf5QN+Bm0RSUKaDEkc52XEBzN6dl7MPMseY0uip14oBA+tpBJqa0hRwil81u?=
 =?us-ascii?Q?pZ58JYov1Z3kDVkZNtIIT5Dm4xzPLRhQpEiIXg48jiHMUTqOxLzH1f/42rKk?=
 =?us-ascii?Q?qO3L0Gw+DQABiCAP61c3AsdYQ734NVmz5ke8BYOK75iXPf939Dr9vZ6sTAtN?=
 =?us-ascii?Q?UdSaia6vUHppEv9LR5TZI1t5V0ZJmGhGP14RXNHyJ/SXCGXlBLaaTTPbE3Ef?=
 =?us-ascii?Q?e4cI2s6XOOAHvoInSi/Isyyz9LjInCVjV8h5t0gE5a52Jy03oP6HRd91U+t+?=
 =?us-ascii?Q?kZF/clbRQZcInb2nvo2H1gkNz14NWIzLkiZNRhwYCUkld/Xe624mu16Fpegr?=
 =?us-ascii?Q?ie97BvnTMifIfo/fOESCmewDhLKLVL27iKaw3FFykHYmLwNrnGbVW1NHJDUh?=
 =?us-ascii?Q?iIk/0ob+5d5lYlfYIMTyG/M9OeyGFAgP9j3GotZjaaeUKt2HNOa6wPjvn4r8?=
 =?us-ascii?Q?5+FB9/ogoVFfaTi4qB548F/QpfCbvu4PiNsZpIt617XrG0Vo0Y+Pz+3ntDbI?=
 =?us-ascii?Q?CK3LYlA6+eMC8Nl3lIWXd4TJP1XHYzjiFRFHZgqGxpqQ2glTcXS1ISAYF7XP?=
 =?us-ascii?Q?UkwTYBrPm40ImQiVGmVUJd4WSZdLLtrWRMH5Y6c1OWk8/e49FShrJOj1ERFg?=
 =?us-ascii?Q?joYo8sNIPuDTxskZ3byRfTT2ZpiP0EJYmiQfdlXiDMnERim/vYyqmXoVAu7h?=
 =?us-ascii?Q?hK1jc/e/Gg/5wp6yPnOBReoyaL44jLXNn23j5kAErIAHIxfmn1Dny4awDDm2?=
 =?us-ascii?Q?FxPEjjkH3GKJReu/n20epqy8JLYXzOd/CHTAWEu3h1WK1/Jl59zoime2XaO0?=
 =?us-ascii?Q?VnmAc+L5cNv1O54KXCLohDZWl6RF+nvyCpwWfecZKPBsbso2PH3TCzqicPWG?=
 =?us-ascii?Q?+oLK2FirOACr7WL38Vwur+3ByQ41YyabrPwxShV+9o2+ECLyDsutYLDkBitg?=
 =?us-ascii?Q?wSbXTNUY9Rhd0X3l0xTMW2kn4zFO4gbcvg3pENkx5U9EPigjLk46Ih6qRVBv?=
 =?us-ascii?Q?+9YtYlkZ4UivXHFlNnM3HHyu9ktKX/3TCL2ujcCJglOfrxWak5Jhmiy5a9Nq?=
 =?us-ascii?Q?o0RYokS9fBwkS8D4TszisoD4H2Pvgs+Z8XpVarZeLHmimgudehK5h3k33dt3?=
 =?us-ascii?Q?JoLCwEeHO1+edBQTWQSNmzxbnESPgNmZBQhrrAYJBdgjmVJQjWzWy/WmBubJ?=
 =?us-ascii?Q?v/yEPkNgL/cjeFJedYUh2Px7edHvzNZwQelqHswV8bARc73FJHCHIk+Cyjm1?=
 =?us-ascii?Q?yCNM6Y/WYeTPSYlu0HOVkl1+HHE9TOZY6eofkOYd?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0B033B655EA7284EA5F8CC79DA470225@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	t5q0y8pJQmSB7pLo0SCPfbNow57yFr5Hdtmp4hyZeSUi5ZQ4b5E9IeZ7i62rmy5vTHcWij1lbt0Bs2Xf/ZnrPnO0IxGK/6HDEadCS6oQJHVWtf6yn/Gt4NaqqQKI2gA3eY3fUH0DeY7nTezUbna8WB54eY7tNyjwgBjQqFaRB2GcBLmFwyQHKcCHrSNCRid/x5UvXGLa7Z6IMSX44BCw2lQu+aL/SRKUT+L8xVbMWOmNsCHurJlWsKU84vrGS4asqtwwl/IGY5mAAv14ye4t3LplU8QHUNC5mmAsCDbhEFCTkeXqgbDDolIyPgIaRn7eFq6Fl0Dk+eiXXIfVPyO64PmeHZHKHUhWpPIfpSRbSMQ/VPUy28ly8t6lOkLpt9o6R6zLIO0x1jbI85aqA8MgzEr6kKq0q6yLV0rNHaRJnHPjGBxCVChY2bfdx1e7/i+Z41cJHj3Or+GxUvMOnHY9/CKliFd+cgXHaoFrjtndso67g/GeqzyiB8sGIYvrSzlnpYPNSWvj2WALzhoTd6i9rQekjius1YfB+EsT7wcc2i5Y4xXRBsujbAx8UMxvULwVdRUJY4X+zKCF+3YoIssDrn3avgU7S1TZe9LxZa2EZzWz3+aJRqDNi24qDGkXr+Mn
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91bc79c5-f73b-4045-02f3-08dc75089d65
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 17:58:24.0503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jmYXzgN68h/6q8nXAPV/8EukrIHbYRoNNcjUdeRvu7nmV2np0NSwxf2ynvEErdbG80oKb0ZW7nMl+kpHP70atg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB8613

On Tue, May 14, 2024 at 11:13:21PM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>=20
> Reserve one zone as a data relocation target on each mount. If we already
> find one empty block group, there's no need to force a chunk allocation,
> but we can use this empty data block group as our relocation target.
>=20
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/disk-io.c |  2 ++
>  fs/btrfs/zoned.c   | 60 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  fs/btrfs/zoned.h   |  3 +++
>  3 files changed, 65 insertions(+)
>=20
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index a91a8056758a..0490f2f45fb1 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3558,6 +3558,8 @@ int __cold open_ctree(struct super_block *sb, struc=
t btrfs_fs_devices *fs_device
>  	}
>  	btrfs_discard_resume(fs_info);
> =20
> +	btrfs_reserve_relocation_zone(fs_info);
> +
>  	if (fs_info->uuid_root &&
>  	    (btrfs_test_opt(fs_info, RESCAN_UUID_TREE) ||
>  	     fs_info->generation !=3D btrfs_super_uuid_tree_generation(disk_sup=
er))) {
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 4cba80b34387..b752f8c95f40 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -17,6 +17,7 @@
>  #include "fs.h"
>  #include "accessors.h"
>  #include "bio.h"
> +#include "transaction.h"
> =20
>  /* Maximum number of zones to report per blkdev_report_zones() call */
>  #define BTRFS_REPORT_NR_ZONES   4096
> @@ -2634,3 +2635,62 @@ void btrfs_check_active_zone_reservation(struct bt=
rfs_fs_info *fs_info)
>  	}
>  	spin_unlock(&fs_info->zone_active_bgs_lock);
>  }
> +
> +static u64 find_empty_block_group(struct btrfs_space_info *sinfo, u64 fl=
ags)
> +{
> +	struct btrfs_block_group *bg;
> +
> +	for (int i =3D 0; i < BTRFS_NR_RAID_TYPES; i++) {
> +		list_for_each_entry(bg, &sinfo->block_groups[i], list) {
> +			if (bg->flags !=3D flags)
> +				continue;
> +			if (bg->used =3D=3D 0)
> +				return bg->start;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +void btrfs_reserve_relocation_zone(struct btrfs_fs_info *fs_info)

This function reserves the data relocation block group but not a zone. So,
I'd prefer "btrfs_reserve_relocation_block_group" or "..._bg".

> +{
> +	struct btrfs_root *tree_root =3D fs_info->tree_root;
> +	struct btrfs_space_info *sinfo =3D fs_info->data_sinfo;
> +	struct btrfs_trans_handle *trans;
> +	u64 flags =3D btrfs_get_alloc_profile(fs_info, sinfo->flags);
> +	u64 bytenr =3D 0;
> +
> +	lockdep_assert_not_held(&fs_info->relocation_bg_lock);
> +
> +	if (!btrfs_is_zoned(fs_info))
> +		return;
> +

Don't we need to check fs_info->data_reloc_bg first? If we don't find an
empty BG and we fail to allocate a new BG, this is going to kill the
existing data reloc BG. It's OK for mount time. But, this is going to be
called on runtime in the next patch.

> +	bytenr =3D find_empty_block_group(sinfo, flags);
> +	if (!bytenr) {
> +		int ret;
> +
> +		trans =3D btrfs_join_transaction(tree_root);
> +		if (IS_ERR(trans))
> +			return;
> +
> +		ret =3D btrfs_chunk_alloc(trans, flags, CHUNK_ALLOC_FORCE);
> +		btrfs_end_transaction(trans);

I'd like to have a comment on the error case, especially relates to the
above point. Is it OK to override fs_info->data_reloc_bg to 0 in the error
case?

> +
> +		if (!ret) {
> +			struct btrfs_block_group *bg;
> +
> +			bytenr =3D find_empty_block_group(sinfo, flags);
> +			if (!bytenr)

Maybe, same here. This is a case of someone stealing the allocated
chunk. Isn't it worth retrying? Especially when this function is called on
runtime?

> +				goto out;
> +			bg =3D btrfs_lookup_block_group(fs_info, bytenr);
> +			ASSERT(bg);
> +
> +			if (!btrfs_zone_activate(bg))
> +				bytenr =3D 0;
> +			btrfs_put_block_group(bg);
> +		}
> +	}
> +
> +out:
> +	fs_info->data_reloc_bg =3D bytenr;
> +}
> diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> index 77c4321e331f..048ffada4549 100644
> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -97,6 +97,7 @@ int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_i=
nfo);
>  int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
>  				struct btrfs_space_info *space_info, bool do_finish);
>  void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_info);
> +void btrfs_reserve_relocation_zone(struct btrfs_fs_info *fs_info);
>  #else /* CONFIG_BLK_DEV_ZONED */
>  static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 po=
s,
>  				     struct blk_zone *zone)
> @@ -271,6 +272,8 @@ static inline int btrfs_zoned_activate_one_bg(struct =
btrfs_fs_info *fs_info,
> =20
>  static inline void btrfs_check_active_zone_reservation(struct btrfs_fs_i=
nfo *fs_info) { }
> =20
> +static inline void btrfs_reserve_relocation_zone(struct btrfs_fs_info *f=
s_info) { }
> +
>  #endif
> =20
>  static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, =
u64 pos)
>=20
> --=20
> 2.35.3
> =

