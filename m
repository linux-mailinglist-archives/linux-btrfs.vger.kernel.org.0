Return-Path: <linux-btrfs+bounces-4376-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3998E8A8735
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 17:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4C31281788
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 15:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD85146A86;
	Wed, 17 Apr 2024 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="p8stMQ8t";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="B/+Sddk5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E058477F2C
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366922; cv=fail; b=cgJW8ck7P4Y8BZQJjNzL048FOZygk4JL8OUfKeXQugsa2Tt3HmDIzsDHzdYz0V9f5GxOD/0MnbZvCsZJDPPz3J4DXRTs03nWyFrnj1dVokGB3FveNnQSHcPfHL3GQa9yIFb+AKUdFkoGN6d8wFGYdJYk0hOJSMhAOnrVBcy45L4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366922; c=relaxed/simple;
	bh=0mGJaYGgfD53nd9b6I5LE9xRZ02vFP3FQbG+EEQL6XQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OY9Lad4/1p60Pw3G48OLhePGXKODCrQ74Dii65uhyN7wMwrUAG0Ie7FMfRV+vN55zJc2Ol/avCC1yl2Pfvvd9IMBBpX+PdOlo6R4uzu8jixYdYj0B+kkcaLlC8V56Zgrm67ZJisli+mSee7kuWgB/LrZI93ivEADiJumb0esVMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=p8stMQ8t; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=B/+Sddk5; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713366921; x=1744902921;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0mGJaYGgfD53nd9b6I5LE9xRZ02vFP3FQbG+EEQL6XQ=;
  b=p8stMQ8tvVWtWx2fqT2XF6S2aFyNaQg+blgt16HFWuRQ2yPYV+5eL0WK
   Q+8KFEYZDdX7rFPYFyA3GroKFPHTq9OGtRq3Ljltt3w8Fn2Brq2HT8Y6s
   ac90MQzpVzLMdcbDiw4MIqtrzPSOygAJIydS2J/9GH4tGxVPgy2V5Rptx
   aFSR3VV3TilAAQuZDoNjpAWA3cEWF+AkoQ5i3I3z56gR3COiQeYGxb+uF
   2KWxuvf0+z2T+ejCbOW4L9LyIi/NpJT4Qw1txmwhLXvkwHR+b/8CzL/Pm
   N+dPgDWD86KikR7lkTls+UaU5JwezdP0TnpGoOnG1o0SmgfroiBIAJ5Wy
   g==;
X-CSE-ConnectionGUID: KM8fmTm8QrCdUWGIta11QQ==
X-CSE-MsgGUID: om2VsjuCQZK6K34vy3d1Cw==
X-IronPort-AV: E=Sophos;i="6.07,209,1708358400"; 
   d="scan'208";a="13665747"
Received: from mail-mw2nam04lp2169.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.169])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2024 23:15:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHcPqstkOs5WL0ICuuxvgmwwEFAH/ifKYfMi72Sb1hjuFJXK0S7hu9xyefkY2fJB3/EpGfDw7xF34yZzuYwxu//j4B4QZHrH5tpkA3vhKzgy1gCSptU9h5bAk4YEPKJFuit5Xc0dTLU7Ru0e21McK95mFP9U438o1WgWgUuHr3DPhsL/FvC5HB1T4cdAi4+MmQT2dGysR0poZ5rXdErLkWxDkoV1M9ET0Jtesj1aSOEe/5+rN+o7Z7kFoOaJ6tJ2LymeMXcpiRyaPgGZNaaMKRGlzZW6ovsL358NoRLCgSsNALRwZ+wfQJNNPfIGyzRBPY+T2AUssx1zBWLn8jgZ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mGJaYGgfD53nd9b6I5LE9xRZ02vFP3FQbG+EEQL6XQ=;
 b=PYcihxEss4BorHWkDoSnhyu1cQDda455N7rcZhkkyaCoptn4i5hPDiP/AHj/4PFX+Naw2Ej0ByR69R2Bokife7vGw5rQX/7fCcL1bEM70rXMdU6uuLaShK4VTJ2rjZ8I4zwhClKkDXhHavQL/a+F9uA3o5c6hXEBDCMDPTEngT3ERF6LuUGCjdZekluJpUO3mm4ZZp1uHPMy34X7b4IQlTQebVI58IpR4FOvI8iqRUB/LrxLBVfEKvVvkZnYHHeM6fNAOJ3X3I7XAqgrLCzOcyGeQMdtLrkhsxEHzFki/jPRtN1WdQFIDnoqXIGqSPvMwG/G4WnkS4mc9bJNvI6zZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mGJaYGgfD53nd9b6I5LE9xRZ02vFP3FQbG+EEQL6XQ=;
 b=B/+Sddk5Af6HPLDsq+9waHFT2fsGU/nndoIckWT1hYqLqZDL6zbXlZg/yR0SUOrmUQuas14/Ed4sfq1RKEF7LSfH0+I36FSJ3vrIdFUCjRLZvyYAiEhfKDatdRS85oLHxniSHB2iP1qpcEeEcY9MHuqo5BPeGGstKpTK7Gar4j0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6491.namprd04.prod.outlook.com (2603:10b6:610:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Wed, 17 Apr
 2024 15:15:17 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 15:15:17 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>, Johannes Thumshirn <jth@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Boris Burkov
	<boris@bur.io>, Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: reserve relocation zone on mount
Thread-Topic: [PATCH] btrfs: zoned: reserve relocation zone on mount
Thread-Index: AQHakMVdPKstrEoEqkWMt1GLiM8ZPbFscxGAgAAff4A=
Date: Wed, 17 Apr 2024 15:15:17 +0000
Message-ID: <31418f49-c97e-4860-86bb-f23d437b1ae6@wdc.com>
References:
 <1480374e3f65371d4b857fb45a3fd9f6a5fa4a25.1713357984.git.jth@kernel.org>
 <CAL3q7H708=OB+XSLjx5ZL8g_Z8j1TC8RHmx1fHE63h6PT8SB0g@mail.gmail.com>
In-Reply-To:
 <CAL3q7H708=OB+XSLjx5ZL8g_Z8j1TC8RHmx1fHE63h6PT8SB0g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6491:EE_
x-ms-office365-filtering-correlation-id: 9c72d719-3f99-46fe-d215-08dc5ef130cc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Bhx3SUv+eM4NC6md2bHSPzaPn+cf2MqGUeXFZj0oTuU3Et3H8RbEKgs2eyNGdtjeOhBF1r8mLvDj074BQKdOfTSH5c8q+scG0l82hPxuSjoEfFq4+T4QYTYDd4ywU85IDh8PKs/lmNMfVeHBjQkdDKInNcGjNowVDSlo6RijhDd8NqDuWFlID9z9RWIql/+UKATwrMe/JdKXv7h0bAn20yM1WXFhYoLMPDtfWpM0e4tsfIGk5Djmz51K1/n75qLF3VZbKReOZY2xnzVIABA3MGpU/R1rDUhCMjKSMoKBfw/vFKX1N96dWuOU32cxPvY487qgkJx0m/Qmz8jIHrp+/f5sske6aFqtelui2iHCkYHQBkr7NuVd3CedyVdsua6nW48ZmOp6mCrufIS43w2HJLjBQsLdms5SRxFvMqaysCFis5jOYKYf/3cSxW0SVQ/KMUTyEhcAj8G/0nVOXVuwf83/Y9nsVRdfVesUk6EUDcWs0FCWlPWaUTj+yGRdIHqvg6lEyA1aF9enKqHKn/PxlsAoPuWAy0XoEjQBeQRJfn+j7Nk2PuDvBt9B1X30Pgyblw5F88/mkEoVrukJdNC23fnTlxiXMHxdhL6RSP/CwMASFjW3h+NfeI9FEJM2QCm0BfgWpPiRMkM7/ra1eL6P8eaEFT6ZAgp5KW6P7wA6YW/K196nmP+jILenAwWwVHq86vMlxu61TryAjcL1kxUcsf5uVhwdI5KVFK4E/KRb+QU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QU1qUXJPOG1YdzUyRlQvLytrQkprbUhyNm52czV3c1ZMME1QQVFvbGg2T2c1?=
 =?utf-8?B?MEpkM1F1Uy9GRC9lZzR0cEpSZWRQWTlWWFhuTkh2aWY4ZmM4S3J4TlhLbkRW?=
 =?utf-8?B?TzVKSGQ5VjFZZ1ZNbU1PYkYzM0VsRkVQcTBlLzkyQTlaZjNwMWx3Uys2SFl1?=
 =?utf-8?B?V2tnQkxmc2ROeTNndVRlRmthNUFhVWJEVklMckk1T3IyRlNkNHhsaS94ZE1W?=
 =?utf-8?B?K3JXMnpXaEJpMHFha2ppS2dWWmZ6VlZmV081K0tZVkZNVlU1YVdHb3lDTnpK?=
 =?utf-8?B?UzFwOW5HLzdlK3ozRlczTHRXa0M4R2ptVm1tdnZiM2JGa0lCOHE5d2Ntbkw2?=
 =?utf-8?B?eHJKZHdsbUNmS2QxaGxRQURaRUhNaVpTQTErSk1ELzJnaHhuU2JNNjM2cTA5?=
 =?utf-8?B?U2VIdDhXODlGTUMvNmRNNjR6WC92NmFrY1BaaGhDcXRuOHdvWTY0ZEZiY1Nw?=
 =?utf-8?B?MExyZ2I1UTVUbG5VZEdvUFQxZG9MS3Z6L0lsSFlGNVQzRVdxbzVmaS9jVmZq?=
 =?utf-8?B?WTZWRXRZdVFrTkVNQWFURGVCRHMzVjd0M2lwVitGWVBXMU9rSXZkOTJwcnRO?=
 =?utf-8?B?QTNhZ0o0MFJIZ3BzcXBnMUgrbUFkYnRxSFdqeklaRHlydWRaTnY4Rjl4bytw?=
 =?utf-8?B?bU1VOHgxRW4yRW9JRngvYmRwZGZqR1hCb3FGS0FiUVVnb09SRDhOQXRlaGVx?=
 =?utf-8?B?M2FkbWNHNis2dGlaOWFyZHVKNFJsRDFCL2FvM213a1BEeGp2NlBiQkNxRW43?=
 =?utf-8?B?SEpFbkJPd0E4UXpSY1lpVWVJZ0pCT2tBN1JLbldsL21VbnpTL3FFZWdQTTBw?=
 =?utf-8?B?b3RXRlBJQ2F3a1gzeE5zbHFnMlY3YVpWQXBpcmVwOHEvR3R4WEV4NFMyS2hY?=
 =?utf-8?B?RHB4RDhkMEJ3UGJ1RmV1WXJjZkFnczIxaFU2R0pkTjRveGxLRnpydGl2MUxK?=
 =?utf-8?B?NUc5Zm9ETUZvMCtCZTM3UE1kQThXaHhuM285SSszR0ZNV3Rzbm9nK3dReGF0?=
 =?utf-8?B?bTh1R2JFWG03a1c4eTlFSWlrbEZPWTZqMXh6Yno4TzRhcVJzU1MzREY0cWZq?=
 =?utf-8?B?UXBvRTZPZGdvS1E2d3VlYWNBQkFjRnlJWVVQYWRwSjRzVklXc1p1K25veHls?=
 =?utf-8?B?Y29iWTB2anlwSzdZR0x4QzZFb3hrL2FGUFNPeWpUa1Z4Y1dQZWxsa1VtZ3g5?=
 =?utf-8?B?S2hNQ2g5UnYzRFhGcmVwZlJPV3JXZmlwOTVMc0ZqWnVHajlmVDBoRnJ0S3pI?=
 =?utf-8?B?WEpPRVdSUUd3NFVmckxad2pzdjhYWWNjS1dJVCs1ZU9YNGdlRHRwRzR6Nzg5?=
 =?utf-8?B?OTBHUnlXRXFTTzV2SFUvbzBWbEloaWpodjN5ZTJDaldRZmR4RUpMK1NGNVhL?=
 =?utf-8?B?ZW5oa2NYZlI0NEdtWDI4UGQxKzFMMkJkQ1FVUFRtd1hyNFlxWU1VYVZua1ZM?=
 =?utf-8?B?aTdKUlVhTjU1VUkvOEdXd01FS3l4Vzk3MUFBSkx5UGtzdzdvdFE0OGVaU3JT?=
 =?utf-8?B?bWxCNmhybDhLMHBBMUI0ZWc2TXpWUDRrNDVQZk5uZGd2dFI2emUyVk12OFIy?=
 =?utf-8?B?VndaSUt5NEtiY3RNenYrRjRCbkFLZDhDcm1mNGtZZkZObWZWT1hiblp4YW9R?=
 =?utf-8?B?R3FxUXFCaEVSVEdkSThGY3pvZG9yYi9sTFAwY1hQdEFIWTJ6STJRdS9EUE1Q?=
 =?utf-8?B?L1NiVjNYVks1djgvZ1hPbE5TZk1hSHZ6QUFYNjM4ZWxqVi9VN0daNWQwekti?=
 =?utf-8?B?WFdaSkNqcUdPN2dpblhNaFNxaWdjbDBLZHAyTkpKVlpveWxHRDZoM1RYaFpC?=
 =?utf-8?B?QTVvelBSZHhlVWx6N1FCK0xoRUEzQ0Z4ZUpwUm5iTURrK3k5eWZOUXpWZVRZ?=
 =?utf-8?B?ZnZ2VWpwcnlsSi8wc2daQ2lLTnBxSit5ZUVIVzFzL25lWm1DeFhzekE3bTBY?=
 =?utf-8?B?S0V6SU44TGZuT3ozTWxDajNUMVV0YjhBdlcvTzlFaUR1K0VxZWJWRzlUY1dM?=
 =?utf-8?B?WkQwbmsvYXZoZjFjWEpydDdPT2JScmh4aUxVKzRtNkRwR0srVm13RmtJVWh5?=
 =?utf-8?B?cHpWVnpqYWpTU1k4TENWSGFmekpvSytDdFp3NkdNZk1aOTBDQWU4YzYra1hh?=
 =?utf-8?B?YmRyYktOTE1VbEV6Uy9vMmpRSFFaN1VkdEVRRzdWbUJndWJnMXkvK25wN0dl?=
 =?utf-8?B?N3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F7F766DEA285F428BA9EA4521D32CDE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JPqTixTp+SrSgYbAsBVJ8FS6cTSC71CIJrDQzyeFiuKwIzFzBJfAlg43XKaQN/FW/cSj8s17Cm7WK4XrBaafjdSds702ZitxvRUCaZDAzOrHNMFDJEQq4yA6PSAEqrVc0Do5PcaUzRiRxbuU9Agw+c7mM81xtrd5yuGkSoaCxcyvGBkq4hGKce/hjqDcZDxR5QAH97R0uXYdDfqAxyB7RcYghy/Qc8SBYV3dPIigO7OMfrbnF7wjBeluiss0H7TMLhSdDdu+31GpjAlYfLJ7gm8oFDoNpz5Etwu5D8oxo9KzU7Ep8qp1vO+bpu7eR0jc4e9v48ya7apIUD2wc+9q/21MSjFZ5Ymkl0/Co+wqyNTDpGDjWX6T9x5PGXZHGk8y7t5wXO25t114ygoqsspaLaeyQaiAN9E+pNEFgZjg3WDp9K8RwWEdSUiqNhAAnYuWgSVsga5BHRNZEj9I3GZeLLe6PZAT89AEMTAzaSot1ua5Li0daTfY8kEh/C2BfHuV8S4n51VoHCsGFKWSziXd+i7YZkjzkxlhgQ56gAnvVz18fOluGDINjjUkDq/TxEnA6bN4Ak7CpLmQZzQJ2lk4aTGJ1XF3jlxUzoslBw+lgC8k4QXXgHCAlTbOrogF5II2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c72d719-3f99-46fe-d215-08dc5ef130cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 15:15:17.8502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XbIewolLUHsE8pl7BDKu8JbYH0gkcuak4gZG5r9sYv6VG62ryJlo0sCVRE7LJ4axJGL43phwp1fDTSGOXb2aPAFG7G56N5nH6w8cEA6iEoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6491

T24gMTcuMDQuMjQgMTU6MjMsIEZpbGlwZSBNYW5hbmEgd3JvdGU6DQo+IA0KPiBBdCBtb3VudCB0
aW1lIGJlZm9yZSByZWFjaGluZyB0aGlzIGNvZGUsIHdlIHJlYWQgYWxsIGJsb2NrIGdyb3VwcyBh
bmQNCj4gYW55IHVudXNlZCBibG9jayBncm91cHMgYXJlIGFkZGVkIHRvIHRoZSBsaXN0IG9mIHVu
dXNlZCBibG9jayBncm91cHMsDQo+IHNvIHRoYXQgdGhlIGNsZWFuZXIga3RocmVhZCB3aWxsIGRl
bGV0ZSB0aGVtIHRoZSBuZXh0IHRpbWUgaXQgcnVucyAoaWYNCj4gdGhleSBhcmUgc3RpbGwgdW51
c2VkKS4NCj4gDQo+IERvbid0IHlvdSBuZWVkIHRvIHJlbW92ZSB0aGUgYmxvY2sgZ3JvdXAgZnJv
bSB0aGUgbGlzdD8NCg0KUmlnaHQgSSB3YXMgdW5kZXIgdGhlIGFzc3VtcHRpb24gdGhhdCB3ZSdy
ZSBub3QgZGVsZXRpbmcgbmV3bHkgY3JlYXRlZCANCmJsb2NrIGdyb3Vwcy4NCg0KSW4gZmFjdCB3
ZSBzaG91bGQgZXZlbiBza2lwIHRoZSBmc19pbmZvOjpkYXRhX3JlbG9jX2JnIGluIA0KYnRyZnNf
ZGVsZXRlX3VudXNlZF9iZ3MoKSBhbmQgYnRyZnNfcmVsb2NhdGVfYmdzKCkuDQo=

