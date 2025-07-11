Return-Path: <linux-btrfs+bounces-15450-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D217B0159D
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 10:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6666A5A6426
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 08:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F42F20D50B;
	Fri, 11 Jul 2025 08:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="opSCERy2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TmGJGYUN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E777207DF3
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 08:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752221424; cv=fail; b=g2YvV71FzrlUcuivKUuTApkEF9ufhbab8OFE8QqirZtF7lWkKKcCjNlFS9UIJiE+uwtDQZUGCy2AJl5CfuSIlrYWuqig5hFHg9+23VD4HiheROGR+xTiFgLP1yW3pQKdl5LgcZqhuMXDzOfjT4x0kuWhEldVAGdTytsOQBE5zTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752221424; c=relaxed/simple;
	bh=HNucuvMatomU//p5AAZ7OVzDyHgp5rxGpTg6TyfLTEs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D+qpBb2Mp1MCIOTNLbR3baN7HSoG9GojHq4/kOKhbPM52Y8h8t8wNnkmvgbp6n4OWhP8XoLT/H7K5ohj8kna/uhw3C0/mdVt5Lpz4zGEWjrK2sPH3bBsEezCyEPhmmRSdS2SZTvNkcNp3PViXH8mrYzV+Ste9/mmbQeDWOjGMHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=opSCERy2; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=TmGJGYUN; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752221422; x=1783757422;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=HNucuvMatomU//p5AAZ7OVzDyHgp5rxGpTg6TyfLTEs=;
  b=opSCERy2mQKZ7uWI///Cv7KBdLkzZONx7kw0bHqzg5gjVJSzYwMznPrF
   7ENW8iR98O8AJg1Vrmyf6wyWp4wqzqRmV/OUCI2lUW4MMxdSjhOTcZrTw
   o4KcoqfEdbfKAk2eKAkXnuIoAyjgHYMFUX+t2o6BJgMvF/r29KCAfQf51
   Ekr3m1gO5hh84drVdNWhhp27JCQGi7UWeb9UCB8thZWyDkbRLOhKwY4mZ
   8aJFayc6F3ZXkuuBNQTgKpxaOIWyB4VoaIJr7CZybZpnRtnmKN6M+KPuQ
   g1Pqb7I6ReV1wlgDG59ZjUyZpaxyXd6URRoneHiFBRM7TiAeVhje1zSYK
   g==;
X-CSE-ConnectionGUID: zs2yAS1fR5ibgQrDzhpAcg==
X-CSE-MsgGUID: BBTxy5DlQAm2FiE/eszSow==
X-IronPort-AV: E=Sophos;i="6.16,303,1744041600"; 
   d="scan'208";a="86860375"
Received: from mail-dm6nam04on2079.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([40.107.102.79])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2025 16:10:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzazSdDQAXrGoKnO9B8eTHDZS4v1BRcxLLBft4CXfBGjc9tegUGRdcInXfrWWc4UVD/QCwOvxVXJ3lL8m2FgenS5WYXL57vQs7X3osRcVRc1Q4jJBaP17XYqzP8zz40ByJL0VuUFLzqnk/3PW5F8V1MkgZLEQek/4ZTBhTBRlqZiuGwzvtcCcu+cVvGhEgqO5t4FeGwMkgvM0YMOxm7aYC01uNc7y4UhHsqW6pWAg/uDeD2OIlyesMCj1RHJvHfxEuBhyXzIfsgYdPBowH6cq+kKcGOVQSUBwh6hT2uoxxfl32UMBuW5vPVwR9m5F80yzbT+DanbTWsdqNju65KC5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNucuvMatomU//p5AAZ7OVzDyHgp5rxGpTg6TyfLTEs=;
 b=jDRsWOS3IZ6oBjpYjTCiciouuBrKLwz5iz62if93azTMCB4DA+90HG2h3lB2uVSYRDT+8gNsb6Ea3Lc86y27RpS5QSSiSQPOZrcElSlaE4UcWwMcrpkEcbrhifG6rdGk3TLY+8fsUKyh+KRLKcmhu1bqmJl/qpOfv+z10Z4SIuRSlF1yACr4pZMhP2OzLHq3Nq5xe2k5cGlOoyeX+bYM+D4mPFXzGKqXRAQs7unrmTUGeaub/1e+/S+GCFDqDrLuQH6HvHEb9dQ3a79oHtlZdC3yqfaW0uJhkcB3lEC2nQpRhfqjIxUxbz6ksFEgpcT8edmpFWXz1DBQDVukMfO9+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNucuvMatomU//p5AAZ7OVzDyHgp5rxGpTg6TyfLTEs=;
 b=TmGJGYUNM1VPAPjLXPjTwgmoge/uVdV3tG8+qS4kGpaAoOAzA2UyfPU7SNOmNJfsCSpch+WyYN760xXEoYD/NbqV/M3rOaXGdFbFP1aNfxFXUOkAtvySfOgaCWwMsour5soVBDueqUG+DtkkSCsqZYSk44iq5Zki4fMZyyJ14pY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6446.namprd04.prod.outlook.com (2603:10b6:208:1aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 11 Jul
 2025 08:10:19 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 08:10:19 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] btrfs: zoned: do not remove unwritten non-data
 block group
Thread-Topic: [PATCH v2 1/2] btrfs: zoned: do not remove unwritten non-data
 block group
Thread-Index: AQHb8jMkJLabW6BP9k6+Sf3HyQoMcLQskhWA
Date: Fri, 11 Jul 2025 08:10:19 +0000
Message-ID: <c3ef0c00-81fe-4d6a-8388-90dcecf58f64@wdc.com>
References: <cover.1752217584.git.naohiro.aota@wdc.com>
 <5fd0a65f2192fc73069f00804317e68cdb6d06d9.1752217584.git.naohiro.aota@wdc.com>
In-Reply-To:
 <5fd0a65f2192fc73069f00804317e68cdb6d06d9.1752217584.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6446:EE_
x-ms-office365-filtering-correlation-id: 136ca7bd-35e8-4ade-d454-08ddc052608f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ejhaYVVDVEJRYkNWVVZoM1gyM3dBdVdBRVJyS2M0NG1aODNyVWRrWm5Bb29K?=
 =?utf-8?B?MS8ranIrWVdRWlgzWXFQQkRiZDY2eHZLMGpibVFnRmdxRVFWcy9CNTFBVTBa?=
 =?utf-8?B?UFZ0Sk0zSWpqMCtjcXByb1d0SVIrb2JjVlhQOUh0QnlRaldQa1pWL0dRYkY5?=
 =?utf-8?B?NUsvaE9ySWQ3QVNETk5xYkx5ZnZoeldZZ0pNWXpCOER3WlJzdGN3SlpZcHVx?=
 =?utf-8?B?cUpCdm5tcWdwZy9zeVUzMWRvZEhkOTZDcTJvZlhacnl5a1VlNlgzQ3hRZVB5?=
 =?utf-8?B?dUhjMklaWHA1SzhIVFJ4U2dLWXRtdnRRb3ZsckNGckUvSENybzlCRFRGUGJs?=
 =?utf-8?B?K21yWGRMWUFTUUg2bWhldDN0T2tlb2hzdHRjVERQUkdETlZSLzl4Mlc1M2x3?=
 =?utf-8?B?ZEYzOXc2NTNQRnhiem1nRXcra3dXb0loLzhBUmZiY2tsOTMzRGJxc1A4RHE5?=
 =?utf-8?B?amVxNUtNNE82THZtaEpUOVNhVmdMU3FoNk84QlNMNnNSVFJFSitzRFJDVHov?=
 =?utf-8?B?VmpLa2hLaDZobXovMU5QdHlYWmVIUVhiZjNRVEhTejEvQVMyRVUvRFVnSkJw?=
 =?utf-8?B?bkhYSnN6ZExxcjZLS2hQYmNVUlRTOUdqMngrL2xwZktnOVNCUUQ5WVVPdVFk?=
 =?utf-8?B?c2ZFVXgySDgvVjdac3N1LzdnRFFXMitWWVdGVFNaMWxkd1lYN1Exd2ozY0NN?=
 =?utf-8?B?QmErTHRCNUNZWnMxYUZ0VEFHV2JwNVlvOFI4NHVsMHcvcFFMbEFTcjFUa0pn?=
 =?utf-8?B?dXNzSzh6UStGVTNCWHlFQ01PaXhPckZQRFJaUkduR05jSUZKQ3RHNjN4N3Va?=
 =?utf-8?B?bEpUY2kwSm1rblN5YzMyQzA3MXBQbHJGL00rZEZYK1F6TXhzTUh4MWg2V09h?=
 =?utf-8?B?dkpTMTdiWnpibGZEbmpCVFpYeGhqeFU5QlJ2RXFZZnUvU0tSeElkYkhKYy95?=
 =?utf-8?B?TEZEUjNIZlVqazNmbXAwVWhCa1lTcFBpS29SQ1JGY0YvMkRPSTBrSzFOd29i?=
 =?utf-8?B?Yjg5SHA0VjF3RW9UMXpwTXFETFdZazBJbEJTQjEveXZJYmJSMUxOVzZOaC81?=
 =?utf-8?B?V3JkM3l3TG5GZVdqVmJGeEhBbnFhQ0Uva250aHRRMUxlS1dqeEg2MzNPcEx2?=
 =?utf-8?B?ZDZOdVgxZFB0eDhacjM5UU1SbUxSZno1Ym9PKzNmZE4zcUdEbS9pL0JXSWhZ?=
 =?utf-8?B?eGo1eHo3Q050enFsejZYNm52eWg2cHNxOXd0bmlFK2dIQzE5TWNBRnpIOGRM?=
 =?utf-8?B?eThLVTFvODNscXZmR1YrbzZFVk45bEx6NGhtYVNvL2hZcVhPU0paNllmYlVF?=
 =?utf-8?B?M2EyUGRIb1pzbHk3MkNoWXFPMTVTeHhOcm1Ta2R2czVaWXdSQWprZUV1c1U0?=
 =?utf-8?B?Tk00cmxwNmhBM3lmN1BmRjhsTXBtenhYSmtzdHNYZ3ZWS3JQQzhQWklYR1hu?=
 =?utf-8?B?a0pIK3Q2YW5ZQlc5WmIzeXdLL0M5dzdHRkwzZDdXa0NWZFRuL1JnNm5TNldL?=
 =?utf-8?B?VndKc2Z5UXUrZVNrMXR0M3llak9BcklsakwxU0t5S24xdkNaZVg4aFZ3RE1F?=
 =?utf-8?B?K1hOSEp0M2lkaWVUQTN3SEpsMmtsdlQ3NTIzbUdXemo5c09SQ25vcU1CRkM2?=
 =?utf-8?B?czlmL0FxYTBodHpEYUNJNkh4QWFuMU5BTXdpVk5qYjQ2QTViN3hnVVRqMjBm?=
 =?utf-8?B?eUI5dk1mTXRRTEM3TjFTNVFPYXROZi9jOE5aRExQSHRWbFZpWTRSek9zeHdO?=
 =?utf-8?B?R2lFUUhTeDNsM2ZKanpvZm1QUzl5SHJMTC9yTHhUUnBDbHk4cGRYa2lWakRD?=
 =?utf-8?B?VitmRjl4Y1NoSXBqL2h1cFNpa2R6am9xVEg5TFBSeWZmQUFmZ0lrYnNOSGt4?=
 =?utf-8?B?OHZFVHNidUtCaE5wZ2YwMzJFeDFlMUFXeDliZFkzWDU3eHNIaFlBendtTElS?=
 =?utf-8?B?OGIrSHNVKzlJUVBCZHRQemFmeEJkNXJFUjdjNW9qNEZCK2VNM21vZnZjUTB4?=
 =?utf-8?Q?DaPNMzb7PazRvlmdvtPyt6FFORULDI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Nm5VSkdLZWM1eXl0Q0wySVdTMWxRRldsNjRXd0dDSlVhY01oOUJXYVdrdGd0?=
 =?utf-8?B?YmNsTnlTbmJackhWVERPb1FyRG1FL0VLZFkxT21JZFVoc2lPOTlmQ1FzQSs2?=
 =?utf-8?B?MlNhUHFRYUc2M1JFM3REL1M2SXN3bllaYXcxQTJXN3hBZCtyS29PMmtwYy8y?=
 =?utf-8?B?Y1VlV2djMThXdHZrdjVlM2lzYVh6dGJMNys3RkN1V3NNRUZ1M1JhNVNaSVMw?=
 =?utf-8?B?T3BNM0dZM3FGYzNpOERTV28yRjdOSjFYbms5NkJ3TDB1VTNWeEoxeHl0V3pQ?=
 =?utf-8?B?TzFrZXhFTFVpaFZwNHhtd3NTZmtGeXBYbTdWUU9ETW1vNWppNldFMDNabjdp?=
 =?utf-8?B?Q2NDYnVOVHgyTWVFY3RML3lhazFTN2hnYUNiWCtrOTZ6SkhxSS9uU05uVnpE?=
 =?utf-8?B?YmNoVUtwdS9nSkJQL0FSME13M3h3OVJWMzlYNFJ2V3VmdTBmTkU4dTYrUlds?=
 =?utf-8?B?RnI0M1BHWjE2SlhMeTg3eWhzRjRmUHh0MUFpcTllcTNETS9Ja0FsallqMUE0?=
 =?utf-8?B?ZG1za3NLd3hvQmVkQW1pMEJVWWkyMUVka2hMNlhPb01mb0dSUXA5SHdueDY0?=
 =?utf-8?B?RjJjL1dXL1lLTzN6ajhubWlxMVVKcGxqQThTSkZLcWZ5YTZCYmRmb0xDQ3NQ?=
 =?utf-8?B?MUhaRllZeXNwa0tkVmVvRk9sUXBoMEtqWEYyaHJUdStFMzVOa0ZIMW5yNlRi?=
 =?utf-8?B?M05HK2hLVnR3MmF0Qk1QS1h2WjZic1dEZjFDaG5pNGVjeHVnUUJoa2RaWldz?=
 =?utf-8?B?NDVjS0hkY2h4Rk1OalJkQVluM3BXa0l5SEFwU0lvMHhxMi9hckF6ZmZFdTlK?=
 =?utf-8?B?ZTkza0NtU2RjVlZ6MTVhSGxyNXQ3WVQ3cFRSUENyTFYrUGJ2cys4VURlci9h?=
 =?utf-8?B?SXVKWHVOaENBNW9BMSs0cGtQZlRnTkwzS3FQbko4ZE5oMGdFZ05iRGVIaFVU?=
 =?utf-8?B?cDhkcU01dmQ2ZlY4T1pYckNKKzMxNGlLTmJ0NjdtS2t6a21NcmdhOXVrZVo0?=
 =?utf-8?B?aE96dnpIZnBQRjU4UnQwQ1cyZE0zeTJ2RzZlVFB2WGxOWHNnOHdBcUNqblRY?=
 =?utf-8?B?Rml4WFpTQXVoSzdxN05HUVFaN2NYRGpYYnA2T3Rta2YwcTEzbkprRmcveFNU?=
 =?utf-8?B?SHlEaldpdmFLbzZ2dUVqbGYvNk0zRmsvM3dQeGNGMk9TVmh6VTRXNm1zMWJF?=
 =?utf-8?B?WVBrUUxLOXJwcmJTNDUwa0hkeGlieHd5MmFEL0k3V0J4eDBXNFAxZEpzQkZv?=
 =?utf-8?B?UWpVa0F6TkdiTnFyVlZEUmZxT0lwUWtUL2xhZjRLK09JYmxwaWtmWktuZlN2?=
 =?utf-8?B?WWI1MVVaZVVwWkpudjhwL3lZdnorYlNUdDYzZUNVakhNcGNlN2hnZ2FDbWg4?=
 =?utf-8?B?Y3lTVWNZZUtsdW9zcG5uVDh2ZW5BcmwxQ3R3WWR0NnFpYW5sdkZmUms1bFo0?=
 =?utf-8?B?WTFzM2E1bm9peDUzMVdsUy9YZkhTYlE4NHk0Vy9yLzZyajZMZ05xWXZQbDEz?=
 =?utf-8?B?UTZJbTVUZ1lFRHdrZWpYdE5CNHowa0hIWnhqVTBmbVlmMkNGVEVoMjR3ZTRN?=
 =?utf-8?B?NkVxTE05WWtNUVJZSzA4NElMSnFqUTR3Szd4YjBGTnB6Q0I3YS9PRnpqZUhC?=
 =?utf-8?B?Zkc5SFgxRmIxdXFrVU5GWXpWWk4rNEJzZUtjdlkrR1J0RTRKMnhsZ3JHZm9p?=
 =?utf-8?B?aUhxOFd1YithZWVodFdRY2ZBeGNMdGtIMk9VMlZGVnJrTm80ZVM3cjlGclZk?=
 =?utf-8?B?RXFmNXNvem1RSVFPS3l6TUxmSzJuRDNKU0drNHljMXpNTnkwcUwyMFBRVDlj?=
 =?utf-8?B?c20xU2g0RzBhYjEzbFVacWFTNE1mTXZ6dFU1eWR0eHo5QlV3QytYZzcwaWJZ?=
 =?utf-8?B?Y1hmVE9DSkxNNjQ2bWJWcFJjVzl5Nm1qRU5UNE1uZE5ZY2N3ckE2eU5xUElG?=
 =?utf-8?B?WXdKekRseldiVU1pT0ZqZVRraEdtMG52dWtiQmtUL2EwMjU1dG9HVnduVVZw?=
 =?utf-8?B?eld2WWtKdXRib3FrWDZTL2lZM01yZk5mVGYxL3JlbFlJaHJGN1BIaWc1WWVh?=
 =?utf-8?B?enlqeXRHUHB3R1BGMFpsN1ZkaklWSjVzYVFUYWZQOXJTZzNlRlBNV2tHeVlr?=
 =?utf-8?B?UlFoWm1VRDg1YmRVSWRVSWhLeTRSZ1ZURUpuQzV2R2FWNjh6eVpSaFdzaG9H?=
 =?utf-8?B?N2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F080414EFE8534F81019F4EF6351309@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1BeQqN507uc4nTSkO8F4WT1K7WhTQvVOX8I1ELLa9BEN5RXFJKn1uyLJSgWVKf99BUduIlWavki3qEO65vF/+Gf/imCWzs0P9ycOnxyAcdYZFkTnw7rd6/zmHkSjkvxcwMkBuwK81JP5Fe63KpM8oREeKJCjfs4UhKE2Nu9qpEzkqjBXpEcDlrFH+ZBodmFtI9BRIRLi+zVQzIfqCOhAnQUnMAr7QvLH3ExcKCKur+YlNLngB1RXDVq4HGqpMt/uKI63phiTsDCIL/+/dUsyaSUpKqF7p8ZzGbbyPNgseUWkxWPhIAIWLw0OrEXwkv8P5uKm3GihHwpCuiqn+BNuoNK4HELm/aYqT5hvNrItZ7Yt65G2pLkXqkqHod5cycYPh5MlXrRwtmZINCB+LKOIFsaCUS837jNzR1Av/7UfDjFSGtNMljNahiTOHnrZ7qApYtg9d7rPL4S5I46hfqPhuMnSLnC8Fl89qi/jQegNUetf6+xuIOnqhiY+l6aKhyylqwVXS108ULIIMfWSytEXqWMGdR88inXfHeLzbTRt41u3ycCosgwij+waqYS7YzyUM8fqdt07nF+1mtcwMKduxiBgRDAj2UKrvPLjCi0UQsElnQrZd7zb5v7EOS8dZF0C
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 136ca7bd-35e8-4ade-d454-08ddc052608f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 08:10:19.5975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /eN608hz7gglUazRz0IK3oeiCHuPnMnzkwEXZb268BK5+eRhAT42HTsbfI/ISJQqRxsc76dNOxxVApZHnvwF1V0xb9zUTXEeZgtKS2OPewM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6446

T24gMTEuMDcuMjUgMDk6MTIsIE5hb2hpcm8gQW90YSB3cm90ZToNCj4gVGhlcmUgYXJlIHNvbWUg
cmVwb3J0cyBvZiAidW5hYmxlIHRvIGZpbmQgY2h1bmsgbWFwIGZvciBsb2dpY2FsIDIxNDc0ODM2
NDgNCj4gbGVuZ3RoIDE2Mzg0IiBlcnJvciBtZXNzYWdlIGFwcGVhcnMgaW4gdGhlIGRtZXNnLiBU
aGlzIG1lYW5zIHNvbWUgSU9zIGFyZQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBzL3RoZS8vIH5eDQo+IG9jY3VycmluZyBhZnRlciBhIGJsb2NrIGdyb3VwIGlzIHJlbW92ZWQu
DQo+IA0KPiBXaGVuIGEgbWV0YWRhdGEgdHJlZSBub2RlIGlzIGNsZWFuZWQgb24gdGhlIHpvbmVk
IHNldHVwLCB3ZSBrZWVwIHRoYXQgbm9kZQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgcy90aGUvYSB+Xg0KPiBzdGlsbCBkaXJ0eSBhbmQgd3JpdGUgaXQgb3V0IG5vdCB0
byBjcmVhdGUgYSB3cml0ZSBob2xlLiBIb3dldmVyLCB0aGlzIGNhbg0KPiBtYWtlIGEgYmxvY2sg
Z3JvdXAncyB1c2VkIGJ5dGVzID09IDAgd2hpbGUgdGhlcmUgaXMgZGlydHkgcmVnaW9uIGxlZnQu
DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYSBkaXJ0eSByZWdpb24g
fl4NCj4gDQo+IFN1Y2ggdW51c2VkIGJsb2NrIGdyb3VwIGlzIG1vdmVkIGludG8gdGhlIHVudXNl
ZF9iZyBsaXN0IGFuZCBwcm9jZXNzZWQgZm9yDQpTdWNoIGFuIHVudXNlZA0KDQo+IHRoZSByZW1v
dmFsLiBXaGVuIHRoZSByZW1vdmFsIHN1Y2NlZWRzLCB0aGUgYmxvY2sgZ3JvdXAgaXMgcmVtb3Zl
ZCBmcm9tIHRoZQ0KICAgXn4gcy90aGUvLw0KPiB0cmFuc2FjdGlvbi0+ZGlydHlfYmdzIGxpc3Qs
IHNvIHRoZSB1bnVzZWQgZGlydHkgbm9kZXMgaW4gdGhlIGJsb2NrIGdyb3VwDQo+IGFyZSBub3Qg
c2VudCBhdCB0aGUgdHJhbnNhY3Rpb24gY29tbWl0IHRpbWUuIEl0IHdpbGwgYmUgd3JpdHRlbiBh
dCBzb21lDQo+IGxhdGVyIHRpbWUgZS5nLCBzeW5jIG9yIHVtb3VudCwgYW5kIGNhdXNlcyB0aGUg
InVuYWJsZSB0byBmaW5kIGNodW5rIG1hcCINCg0Kcy90aGUvLyB+Xg0KDQo+IGVycm9ycy4NCj4g
DQo+IFRoaXMgY2FuIGhhcHBlbiByZWxhdGl2ZWx5IGVhc2llciBvbiBTTVIgd2hvc2Ugem9uZSBz
aXplIGlzIDI1Nk1CLiBIb3dldmVyLA0Kcy9lYXNpZXIvZWFzeS8NCg0KPiBjYWxsaW5nIGRvX3pv
bmVfZmluaXNoKCkgb24gc3VjaCBibG9jayBncm91cCByZXR1cm5zIC1FQUdBSU4gYW5kIGtlZXAg
dGhhdA0KPiBibG9jayBncm91cCBpbnRhY3QsIHdoaWNoIGlzIHdoeSB0aGUgaXNzdWUgaXMgaGlk
ZGVuIHVudGlsIG5vdy4NCj4gDQo+IEZpeGVzOiBhZmJhMmJjMDM2YjAgKCJidHJmczogem9uZWQ6
IGltcGxlbWVudCBhY3RpdmUgem9uZSB0cmFja2luZyIpDQo+IENDOiBzdGFibGVAdmdlci5rZXJu
ZWwub3JnICMgNi4xKw0KPiBTaWduZWQtb2ZmLWJ5OiBOYW9oaXJvIEFvdGEgPG5hb2hpcm8uYW90
YUB3ZGMuY29tPg0KDQpTb3JyeSBmb3Igbm90IHNwb3R0aW5nIHRoZXNlIGluIHYxLiBCdXQgSSB0
aGluayB0aGV5IGNhbiBiZSBmaXhlZCB1cCANCndoZW4gYXBwbHlpbmcuDQoNCk90aGVyd2lzZSBs
b29rcyBnb29kLA0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1
bXNoaXJuQHdkYy5jb20+DQo=

