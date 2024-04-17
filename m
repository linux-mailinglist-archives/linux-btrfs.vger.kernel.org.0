Return-Path: <linux-btrfs+bounces-4378-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7141C8A885C
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 18:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 940AF1C223AF
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 16:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301E11487D9;
	Wed, 17 Apr 2024 16:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rYaMf4rQ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ad4MfDt+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1B1148301
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713369685; cv=fail; b=JYH9HTiRgU+lxnyMXMHFMv/sEmi11PIRd3WH+eCA3fLnIMI7XmZSPX1zzTq9VNr9n+2yt6wpjqZHMes9leDaHYTrvK3Ua3stCiLbiBIcRif5T01lNBLqhjIzj/i9t+jZol9Xgf872OjjksbB+wmAfxQJg+r9MHbOJTpQNL/MjvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713369685; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X/tpRR+WMSCOkR9T30/d3crI7g0tGgz18KLUkcBMk0OzxlCSL/3E5x10bIoL0PMq4O4BmrdZZDWvQF7/QsCelICiAuOBoikBTlUL56UdWrvn52ILCp5bLSzAD4Q4YKgZ4WUA2J9Fp9+7rSZCMV0OqhJT6qjif61gq7WSf4ZNmFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=rYaMf4rQ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Ad4MfDt+; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713369680; x=1744905680;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=rYaMf4rQy+2FA9ML7mX8LR+3QB6zg3DVgLmoN6ExmA9TVB4D6KWGYbTo
   GM1WWyFgEnjiGqCm3FETHpzrWfz3cJnDsjYDd0wSx0Y31JQE/osu/vJt4
   Wik/e6Dl8CWbut+5W6TzeeZfnblsdAyPuYhpjfnGK7XsaSHwOcrG6JVKx
   KEhlyNyu8BX2l1ZaZnRtNdiKsrkuJqR2Nt63YuOyvOd68naExx2ZLXQ14
   JC5iK5Ea3Yn9FGHQFfUuou4ogyH51lNi2iiwQDn0pJp2BqKP+IjjgXcI8
   uPAQPJs/c4qaNbc9P78skrHSgZQ4VCSa9G8c9I6zhUlghVm9Ak6FN4CoF
   A==;
X-CSE-ConnectionGUID: 3MOVOoQmR3uK9QMum3HjLw==
X-CSE-MsgGUID: P/W9egjuTxm46ZP2+L3AcQ==
X-IronPort-AV: E=Sophos;i="6.07,209,1708358400"; 
   d="scan'208";a="14936867"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2024 00:01:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+FVXBo5wK1PV7rf5c+jN832TKWtpZDOh5yAe1INdTYio4bmhYu0bWn2SBkaCXNXKVXWBgoxmBNVbaLKgsa3pjukgdS+khSHsUeBwQSUSVdNDS7d3i5yveiZJihmnIpMXfZgMK84rW8EhZeHE00rd9goYL6HAcFB21QKrzKoEhNed4PI+72daOA0alCTAgb5M4i92iiTNxVMnzUHLQJWJOT2/Hd9UM1YwGEWrALQnL308K+35c2Wg5iSmYIVpdgbzEJz4+vrrH/o8LpFC748YAlopFdxisJi9bQS8XmYGB85OZAQDf461EZhiF7ip1VR8ZmS/QMCZrHUGcyfF055fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=YsM6+L4stc/2m3NJexyBTilIaY4fjsQKh8JCacP2iYY2Mcjuh9QGBkQJ5EtQhddJZuzK0P39ix1HQKxGRS3Tj8OzpwrDbvQm2p4Rp0MwRIa2RBbz4XS9DzBs0R6GFNhjtK03kYjskZS01Ou17ftqfO7GdNJYRBCLUsSfDa96uq6PG+12ZoRtOB86exv/8mVzUFLraPWLhe1eDX6OwyPIlOky0zBTCNKAuy4qHvnsdmL/QfH1NhcDJ4rKMCzTxu9OV6ZygrOmp8zZ4ewX/hmQkfxSyVRHqlXy7vyin634t3GGHmF7pLIJppvskiStjiLo69B/JW2VuD21a8M35LZHmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Ad4MfDt+USLpkV9UJxbFbaWqzApXK8ffSZHoG9Kkno2O97b1VaK8FCkQegY3ZofjRomsvym2EG98KY0+f84yOeFp9Job8kz1dohVtOSclvm/nnzCn8h7y/JwDrvNnN62EbfzRhUFPCkD2R1JtxJJ1+6D77UTlaCA6kZ1Yw7XrT4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB8023.namprd04.prod.outlook.com (2603:10b6:5:314::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.53; Wed, 17 Apr
 2024 16:01:17 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 16:01:16 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Josef Bacik <josef@toxicpanda.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 01/17] btrfs: handle errors in btrfs_reloc_clone_csums
 properly
Thread-Topic: [PATCH 01/17] btrfs: handle errors in btrfs_reloc_clone_csums
 properly
Thread-Index: AQHakNSjOmodAMLoY0yMGHB7DGolIbFsn0sA
Date: Wed, 17 Apr 2024 16:01:16 +0000
Message-ID: <c24d0e12-d68c-4680-bde4-8bb4a66ccb29@wdc.com>
References: <cover.1713363472.git.josef@toxicpanda.com>
 <e76b91d488261dc5a5dd3f042a55c04cdc94c7f3.1713363472.git.josef@toxicpanda.com>
In-Reply-To:
 <e76b91d488261dc5a5dd3f042a55c04cdc94c7f3.1713363472.git.josef@toxicpanda.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM8PR04MB8023:EE_
x-ms-office365-filtering-correlation-id: 079dfff6-6b24-4e96-5ee4-08dc5ef79d48
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ZjsHXy4f+e36Sk/7gZMntUEcz2eGa/JydxqHG4HNXNAhUj3OiKzbHZn46lb8R4e5r7G3oePMcxE/IPx+okSv77v2wllkp2VYSO4ei401w4Ji5rLiSVhYoQrKcDSw0aG0dD3WbbcGujmIK5ccACMkrRE/hApToZJS+k/bZVwtCj4BgddtzlUih5NbyM0DxPIvwYNXGm9N7aE5eHdYqMfVRJeLlDbYvEJGAEOAscfZq5f/3EgUwMrtTtgHd7ZuNc7/buymT6qXu/4WLgwMjUCXrAIVo6k5P0WcG3Fvx15bNYPqNpuewxCPBVZv89l7dOoHa+v7hWpzZKYPFoecXsknjVn8mnEpKBZMM9tBRwKRk2Blg6CBBUe23d0k55EivU9t5Htq0YSYNYYB5cBfBeJ/KzF1GUlM0wsgtjnf/HbbyNgVufxnISphwkpC0czkbza90w/I7LDiAOVE0W3zuv1M56catBpZlzqzjkNkmlZ+rm/2rptqy6z2A9L2+nlhO7Hn2FmuMV3mUDGqsOKN9nblyw1TceKAzi/NGWAB6PEyfZ5JVXa30EwnNEMZe4iUPyFjCht002l6r9/NgQEYpFEk84Fn+YCxVOrqAxZ3Uo6vI25NTAV1QYdRR5k71z5FyJ3aF0gip1WlGOk+d7380M4nZ5HmyU2OKLAhmVuQFmiSfB6oOsEF4QuCnl8YI6v8+LyEXzNPXz3vlLGVKSMOwmbc+MV5od6/8CwwIw1OzndeOqY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bG92K0VRMHZXOTJpYklvS0xmNmhLWjZVNStoTlg1ZVRLZEUxYlIvbmUyaUtM?=
 =?utf-8?B?VmUxWEdMS0tSMU8xRkJXcjJmM2tncHBMUEcwY2s3QUQ2WVJxVDBlSWpRL3VE?=
 =?utf-8?B?Uy9LdjkvaFNkR1p3c214c0o3clRXaStBdVVMY3lGZVR3YjY4eTMveUlvcE5n?=
 =?utf-8?B?M0lmVDRYUFBCakhZWEF1QWRvaXkybVdjUzV4eWF1bHlodXVMVmRKRDM1Vk0w?=
 =?utf-8?B?RGZFNHZRdU83byt5cmdKdzAwSmhPbWdYKzExcS9jOXdVU0ZLeWNCUmppcjNY?=
 =?utf-8?B?VlpOS2pDdDRJRi9SRDVGbW1rSWZtcitRWDMzRlhhU3gwK0JYeFdBVHhyYlBG?=
 =?utf-8?B?MTA4MGZZZU0vRktRNWo3OUNZTjRSWWF2aVIzYndDU3BhL1hkOWpIUkM4ZzUv?=
 =?utf-8?B?SFM3ZXVoTXJsNkJmU05kOG9iYXBjYTcvUlptQW1sVG1VTTZEWUhYVExObUJX?=
 =?utf-8?B?VENXUGo5TTBKZUlHMEJ0K0dBcXQ1eDZkdFlrMXZLeXZyNkx5QkcwOTlzUTdE?=
 =?utf-8?B?dnd5Q0JmOUFoV0xaWUNKd1RFLzh3Rk9xbVU4QnZZNG40MnNZQTB2K3hDU2Fq?=
 =?utf-8?B?OVZrY2I1KzRPOEh0eFhXZmhBOXcxVHJKYzR4MC9jeVRLbTY3UE1RWFR6cjJD?=
 =?utf-8?B?aTFBdzJhYlFMR24yMHZqYWdDMnYxelg3bkZqbzJVWG9nQkEwS3laVkliYURo?=
 =?utf-8?B?UVpKWWdmQVVlNjhlNGZCTkhNOXV1U25FaEtmaFJiQk9Ma2RjeUJkOFZ6dmVX?=
 =?utf-8?B?cUJzMEcwMUhmOEdvYi9TdEJaYmhhQ2p5M1RiM2hEKzhudXh4eWFocy9sNEtw?=
 =?utf-8?B?TXZaay82U0VMOUtMelBMQ2JSRWRTdytmenorVElDRGZySWxkQkxETGNsOEJy?=
 =?utf-8?B?Q3ZhQjdRSWd6aXFINHZCeUNFYXlldXM2N3U4NExYcWc0eEU0M0hFam84NElw?=
 =?utf-8?B?dzdTRkp5Qi81NE80aXhtKys5aVhEODR0RVFVNTluSWFpTlhmS2d0QkR4NWZO?=
 =?utf-8?B?akdDWklHWkp1b3NBdk1MSklydXZEc2ZzN1BvdmZKTWpBK1dlMmt0MUFVYW5L?=
 =?utf-8?B?elJXd1QrZ0Z5YVVvZGh4UmN1Rld3bTc0T3d1Y0JTTWdLZm1GaEJPNzVpUU03?=
 =?utf-8?B?QWtwOHU2TDFURXptOGVMK1lWM3Y5eVYyVDVLazVqU1YrYmczZ3ZFMEVWRWxk?=
 =?utf-8?B?WFJEQ09NNk9LYnFqeWdYRnFnQVgrVFpFVyttOE5Ub1JsMkkxMnNPazBGbWVX?=
 =?utf-8?B?L3NoaWFuZGdnZXZ5TGc1ejF3N21PR2h4d2ZoWUl2ZVlsOWg1WjA2L0xQbUg5?=
 =?utf-8?B?S1ExbjduS0szZjVjeXZySWhONmpTTEZsVlpaeGNZWWxFY0FxemtuampLaHNV?=
 =?utf-8?B?QzVNelFsaFY5blBuZHVzNDhXSGlrZzNpOFBOZjNKWUVORDVKcEFaTURrR0Rp?=
 =?utf-8?B?azNGYjd0Rm4wanM2UHczWkpNVFZyL1FENzBkUVZpU1JUa2xlZDZhRHNiOXVB?=
 =?utf-8?B?ZWVUUWVSZEhScHJUTjVpa2hqUTdjNlRtMWpRMkdvTUg5cHpZUXEyeEdPRk8r?=
 =?utf-8?B?dFJla1E0R0U2Q09TZldtSHlwVmdQeHg3UmZzR20vMXZzNWVBaHc1UEpmbENm?=
 =?utf-8?B?L2RZSVF0MjNRTVBVZVhaR3cvQ250WkVVNTRxcWd4YzBwS3NqZ2c0a1B0ZW51?=
 =?utf-8?B?eHF1WTNNZHRTMkwvQ01LSUthLzVaZEFkWVNOOWorbi9vWG9rajNZK3c4amto?=
 =?utf-8?B?TXhxeTZTbmlNUGxyWWExQXdQNUdLR3Azd2I4c3RhNTVpVlprdVVJK1gwdVpO?=
 =?utf-8?B?UmREcGRaemxJYld6VmNqc0NZeHV3eTEyV2RYd2RjdGtQdHZCakFYT0U4RVIv?=
 =?utf-8?B?Z3JycG9WY3dSQUllNzZseVlxTm12VkNQWTdXWEpiTW5qakdRZENsWEF1b1FW?=
 =?utf-8?B?dEloMFdRZEdlbFFVUzVyckNocU9YSlpQWTNNSHRseE8rczg1V0JBa3JEQkxz?=
 =?utf-8?B?MkpqakMzT3NQdStvT3VCUkZPU3hWbE1xbStyYVU5czBVTDhOZ3Fwa3Mraitw?=
 =?utf-8?B?TTd1VThPb0F4bkdZNlZOTVJzR0xVQzlhTC9PVisrWjU1dXAxLzBHYkMxeDRo?=
 =?utf-8?B?WU9zWkNpZmZkM09uaVl5enBUdHFld3hDQjFPVFdvdVFEMkxjTmRiclJobnlC?=
 =?utf-8?B?Y0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A374361661A79344BEB2B392D860ADEF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s3GjfiIGyJEgs+IFjoyDm6AaSD3j7VwdH1wHcVqwF61Azc+niAQ+/AEwb9epzD+5mCWzg2cE1Z2uG1mxa9ybK0BS7j5SpUszpLT4UIuhYMhKUJtWUQVt5JLQ19QnnqbsC5cUgbdql0UUu54/lXndrCOulFaev/ffnW3W8D3ma08xdstogZ60v/h5iq/xcW2Ier4MOvQ9mxD1bDBlhAJQyiGGqvdmjBiCvmzEymm60dxawq3+zDXZeb7en9Ac+ZkWnK5B0UMO36FR/TMTOpPneKSMmdOg/K2qjj4a8d6Xp/nKm2FeAIYIzHXtogs+QQKstA+mwmT7tOz0Nx5X4Ox9ZEUROFmsZu/9D3BGTMoL9i3+a7JuYmGyTzljHbyD9vRhNW4eY9GCjSbvFusIFksDKaryyoxJWzQfmAR2baRm4paqJvezwNsfl4scbxV7lvj4pVlrUurloqac94JCzIEbKLVTTbO/9RusIfTOvxCZ2ZyTrvd8NKnAMdW399593R/rktvNVWHoq5OonY0DcvaAJvw/zfMxwtiDrxfXlEihnzs393eoP+GGyQPBJZ21C52xcK7xXou/lgvkOwUrVp+fAJRomTHp128hTFh/J7npw0aM31VJral8lr8NzLJA/WXL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 079dfff6-6b24-4e96-5ee4-08dc5ef79d48
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 16:01:16.7868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uh07oU+yDi//y514oZtxSChYVvMWI0OZzXluJL9AfktfFK5cIHV7lC6rgku0oDbK94gJjX95jFAPh1nodL0O0TM6yy/ka1AX+9Qyso0GUt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8023

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

