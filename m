Return-Path: <linux-btrfs+bounces-18245-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFE8C04B2A
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 09:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DDCDC3453DD
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 07:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CD82D24A6;
	Fri, 24 Oct 2025 07:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FFdYbs6g";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ipOttXOF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14D6125A0
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 07:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761290515; cv=fail; b=sBDSf0FMf+lGSqIhD+1QzTn5rvBZkm/Ix+gRNldOjywdRPgQ7zfHeTlmdWrxuaEwf9Ot8JJtdZ3hcpxPJ8vyCjEdJMSNBy9Xh54tsweepPdNaLB4Niw34IQZHzeTJLzFfrnrPwW3SGfBnUYP/aTzYGfpIWPQWG5lw0GYvr8rYcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761290515; c=relaxed/simple;
	bh=tGycwww0q1JVqx+tK0cwSUnDWnJWHIvra4aXBrxOmpQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BBKd/OE/8KjNas/geQfnopR6NuLGEaEfzOnvWRGHTqYhRNEvjjfeAG1JwY8rB4TQl3t9fkwiRqsmXmuhhZNcZQ+6NkJlguOV3sPY8V9zCm+U8mO5onshjxoXYFY/pcg45s2nVWBPl+8r6A/PMr7u6VodjizRQ1CtjV0N9Nj83gM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FFdYbs6g; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ipOttXOF; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761290513; x=1792826513;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=tGycwww0q1JVqx+tK0cwSUnDWnJWHIvra4aXBrxOmpQ=;
  b=FFdYbs6ghrQDQgujscM+K+nRzqDxXBDL7UY3nGEEKSlAhB+Kj8emb7jF
   kkXWpeiEe9Upa+2mt/jJ6Eg2Wsu2q8QNnCSJ2aLT20+fiSYyIP7YEBY3Q
   iKQGGoum5rjV1VjoH0h2uuJAoc/zDYv1HrLy1usKKEv5hBZEGk9ykiOLB
   S9mW2vpwnzp0q0O+C9pCrpMJzUF4x7ONBXUOdWyFiU/ILE6kdurpdqN+W
   nW4iFD7xMONEn+ziDgHWVRaIP77oJRuCfVvnmoIZkZ1tO46AD0JsOXPhq
   dv9Y7diYy4F+bJs7pF4/YBn89DdAL9Z8CHFl15ZI10V1Ngo3j/Vwtfyxz
   g==;
X-CSE-ConnectionGUID: qlRmWLCrTwOTcalR+DX4/A==
X-CSE-MsgGUID: zA0gB88ZRtuXFN18IE6nYw==
X-IronPort-AV: E=Sophos;i="6.19,251,1754928000"; 
   d="scan'208";a="133833834"
Received: from mail-westusazon11010002.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.2])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2025 15:21:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVjucvAoIyFCiX9it1rXwHkgb7PdsA6MySXJtPNJVdxzNRiC3xSmD0OOaOmCEY5ed/KYjTEpJ/cjvALOJgG+sgYTkO0IcWXY/do8dw6uuGVKB7SO6r7okqk4sdVisXfUm3w6QBztBW0U9UK7JRyEHJpaN+izq7ELsCxCjQBiuxU8CrOsQhXx71Kkq/nwwEosDVQFf8S5hTyDT27PPEpwR6C1hu4e/UsPZKUsXmJYoe9sKbXoMpCc5oQDfzqthmZP0FocuPCAvmVn02pzIPjFqv8i6RMHEgSNnEJp8EeF8anCNrCa+wXkwYNVfOZ7D7VBpV4rC8m4tP5f3hljb4pmHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGycwww0q1JVqx+tK0cwSUnDWnJWHIvra4aXBrxOmpQ=;
 b=lqzapFvHJOp4Hj2sZZs/7GG5AY+6xY7rsgdvDMYGZ7eeIlDsVhmJHw4SLN+SZwX0guxiyuf29eVxHaaIl9OIG0m4rTK1sxK8tB3nn+MkZf5KaEhxDarwZYCakkmOIMhJ7/W28YbXVO1mMpuyAqkT8lY3K4y/BP9rP3f4W0sZAf0Q2HoO8oo1U7yw8Xso1R9JDUjydiwcGxNfxfFwBAgsMl/M9CL4/j8DWe5NUjgiLnAfBH6/QrXKZJ5HkZ7+7hUn3IGiHIMov5XdCE0u/qZC4HdwMeh8bGGiwWG+s3RvVjKGCtb4miSzZ/Lz2oWm5Glggaavyq6j9EUgNo3tCQQWVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGycwww0q1JVqx+tK0cwSUnDWnJWHIvra4aXBrxOmpQ=;
 b=ipOttXOFHJd4NmmfPzDXG8UIBsLIZj4rQLzDZ/p8EA7vi7wKFGG2Bys0RRS02YyNJMKQb/lMs9px8ZdEWjJSCIwZw6nvTneHu/p5s8TdXHu46IIRPFEEBa+vEPuVjxe0u/XkPWL0i2wnDfkfqrZS3N9gRDcAc1BIcGsL7YTmW7s=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN0PR04MB8205.namprd04.prod.outlook.com (2603:10b6:408:15c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 07:21:51 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 07:21:51 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 19/28] btrfs: reduce block group critical section in
 pin_down_extent()
Thread-Topic: [PATCH 19/28] btrfs: reduce block group critical section in
 pin_down_extent()
Thread-Index: AQHcRDaAkvrCsM5fOU+rWjYVU7JXnrTQ5U0A
Date: Fri, 24 Oct 2025 07:21:51 +0000
Message-ID: <14fe0899-0f5f-4c57-bce5-7a42efec0b16@wdc.com>
References: <cover.1761234580.git.fdmanana@suse.com>
 <6ad94bc6f4671e932d76188ce9aeb7026b22b27f.1761234581.git.fdmanana@suse.com>
In-Reply-To:
 <6ad94bc6f4671e932d76188ce9aeb7026b22b27f.1761234581.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN0PR04MB8205:EE_
x-ms-office365-filtering-correlation-id: 7a8fb5cd-9e50-408c-ac9b-08de12ce007d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?a0s3VTkzNFJzZ2tLbkhlbWFqTWpuaXFVeW9ucmJVUk1ZMzBwbjN0M0pIWW5T?=
 =?utf-8?B?Nm9pVkJoYWY0TnNpWXJoVjNlRUo3YmtpOGNhK0VwNlZRK2xuNHM0KzJpc2xO?=
 =?utf-8?B?MnZxOTIxSmJJV2ZmNVZwNGViMUlaK3J1bFNoWG5zZTMxbUtpT1EveVVhRTRJ?=
 =?utf-8?B?eVRsQXNnbDZ4bW5PeVFCemRLTG9SNnd2WUt6RUJlYXNQOUVxcXo4dnc5NFBP?=
 =?utf-8?B?bElTdzVZMHh3bXJDZ2FuWUdVN3lPSm1BV0lwTXJucWZ5YW9tV3Exc2QxL21y?=
 =?utf-8?B?SXdBYXR6VWFWaHp0WnJDaWFVaXZYRnpqWWdLckVZR3Q1a0JrSjg5MDZDc2lr?=
 =?utf-8?B?RitxRENyT3ByVGJoMFB5Tm9qUkVlV2ZveUR2eDBHSFFjSG5iUmhnTzRHdlpD?=
 =?utf-8?B?WmlsVkJkY2EyR09nUndaVmJUb05ibjZFRklqVThJZW1TRFlIdnN1bnpwNi9K?=
 =?utf-8?B?b3JXcm96bi9iWkk0eFhBL0FPd1BqQTZXRkVadC9oUnVCTmdabFo4UGFrM0pT?=
 =?utf-8?B?akRBdHh4MUp1MkFKMHlWWTZNRCtDdExiOTVBNUNzbWRaVU5NcHo2Qk8xNnFN?=
 =?utf-8?B?NFY2SHpqQWt6V1lvWW5LYXk3WVYzcWNZbnl6czE0dUd3RnFFblYyNG5jcFlF?=
 =?utf-8?B?NnNXblJ5SHgwdzdDT2ZhcFhLcUVudmg5ZkJLWGFlRTVaNmdIUkEwb2NOSSs2?=
 =?utf-8?B?M3pZNFZGTU8zNUJFQzhlekdhRjV4TDk4c2FxL0trbGMxK1VjY1VwUlN5Zklk?=
 =?utf-8?B?NXlUSjhkQ2FQdytZMU13Mi9GZUFiYlFLL2RLVzkvRzc5V1NoRW9XVWZOUFI4?=
 =?utf-8?B?dWg1Z3MvS0VBaGJaNmY2QVIzSXJnVUdwUFprelN3Y2VEeklaUTNkWTJkNUZx?=
 =?utf-8?B?dEVKajh3OUFwaDk1NHNvRjZKUVJ4cEtnbm9XZXYrZG5nTSt6cXBRTzRmRjF4?=
 =?utf-8?B?RHdlOUpMT1puYXF2RTVnNWJqNCtPdHc0N3VjNFlyOTNsM21MRFI0azA4d1lm?=
 =?utf-8?B?WDBUODdlcmVuK3RKUTZWWTNJS3BYcU5ENWxhVUZSenlNRDlIQXRJRTFoK0Jj?=
 =?utf-8?B?bUJ4c0VoQ044KzI0RTdHalpTSXhhZ3paNWF3OXhaSVBTRVFZZlBDaktpNHF2?=
 =?utf-8?B?dktEUExINm9VWm5Bb0JxbnJPaFY4Ykl1TUs4NjBsNjBGUTlGNWp2bDlGMkhK?=
 =?utf-8?B?dW03Mi9aMzJ3UHZjRE1CL1YyMWI4cmRuZlNJTEI0cUIzRkl1MGF0MjBCeEpD?=
 =?utf-8?B?ZFBtNGUyMkt3dkwrN1hqalRZT1kzQ09MblduamJhUTdQaklxdGhrM1ZKTTFS?=
 =?utf-8?B?NFhxWUZ2djJudnJiV0RJbTFqR1NIMktUcnZwSGxLenl5U1dFRHJUeTdkTWRJ?=
 =?utf-8?B?cU5rMzdFZlNGRExldDdaL003dEV2VlcwOENJYTNLdEM0V25vemFleWk0RGFk?=
 =?utf-8?B?cjZ6WVl3elUyNXFrazhYUnJvUVJnVGFDWktZVFJGbWkwYjFjNjBsdmh3SHhV?=
 =?utf-8?B?OWg2K0xrSDRkbUFobEZRZzUrZDdqSWNSREk5VDU0Rzk3YVVBTXluYWQxeW5T?=
 =?utf-8?B?bzRWN0RjUFA1R21sSGtsOWg2WDRQalpaenEzZ3U1OWN1by9aTHRKcTF2OXVu?=
 =?utf-8?B?SHZTWXgydFd0TkJrNXBrVWxzcStaeXE4b29VaklZTitLVGNhVzZkelEva3VO?=
 =?utf-8?B?MWR3MWtxSHZWN0tFUEVJUGxIN092VFg3MVIvaGM0aEVZak9wZ2FMdWwzSFk1?=
 =?utf-8?B?WWtTT0tLYTBaQjgxMTI3SlRTQ2NsUHh3SHp4eTRzL25SMHI0TVRPT05rcHZx?=
 =?utf-8?B?RVdrUTM0VnlQUi9NcVhJV2ZEYWVsclNMUGlrL0NneDVGTnNlcmllNldDNGFC?=
 =?utf-8?B?eDRBeHRDOHN1ZlNqaHFjYUIrS2xEZmwvZ1k5UTU3cGRWMFpwYWhtaWhJTFk4?=
 =?utf-8?B?V2JoTEFoeVM4RHNQZmR3L3NvcEs5VEhBTDEzc2ZMLytzZ3NieWd0UmZKcjFD?=
 =?utf-8?B?MmxvcXRxV0V0QzBiVk9TRmM0dm5FVGJVOGJkZ1NTTnUrYVFlS04yczhrOER2?=
 =?utf-8?Q?uNk0Io?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dDd1VGJZM1J1TkhMUy9yK3MyUnQzVDJ6SkV0bzQwcnArT3dmY0FmS2ZSQ2FY?=
 =?utf-8?B?YllORnk1RTVaQ29kSXNCMStUamdkSjlvNk9pcDhUYnhWK1FKSVNERiszMG4r?=
 =?utf-8?B?dEt1YStYQ0JuTnZNc1U5K1RXVjlUZWZ0dGhpY2pXZ2xPUUxPa1R3WHhtdVZi?=
 =?utf-8?B?RmROUXI5SWhaZ0JjWDdsTEtsUjMzNXdqc2ZGbVRMTFQxS2txcXk1S3pRbFJG?=
 =?utf-8?B?UFpOeTRMZ1dpWTdmZjRJdk84aXVIMW44dG9ydHdQRXdFNDhDR2tJdjlHY3Za?=
 =?utf-8?B?Q2hubVJvSEFua1lCQWE3WlBZQTdlcGJaUUcyaTV5WjJwWnJXaDJIaEgxVklH?=
 =?utf-8?B?SWZyOG5lNjZGQVE5L05rT3pjUWREVkY5cjkvWGMzbmE3VGdvdGdmOEszMDF3?=
 =?utf-8?B?ZHl3U2l2WUpPVE1NVmFZR2VmM1E0eFVHb3pTQWNHNURSQ1VSbUtpYzVFV3Ax?=
 =?utf-8?B?bjdlaHNNT3RQYUt6SnVML0VqSUVyeFFPYkdTUlk2S0pEWGNnVlRDOHBnMHQy?=
 =?utf-8?B?U290ZzNNdEExckpDY1lyUVpHUGQvS1VTTjFkcjMrWjhiOU1VRG0wT0VzUVNp?=
 =?utf-8?B?YmQxZnFjZExST0Ivc3AyckxVSTFydkYrekE3MFFNR0Flbk8vMFlvYThOdW01?=
 =?utf-8?B?OHJERm1od1BvNjB0TTVxYW10YUM2MFRHTTVmOUF0OTZydlVydjEvNzY4SjlV?=
 =?utf-8?B?bngybnBMMXZ5WE9YcVJvckJub3hUOWdhVlFELzhJZVR0T0NTenRsVUIrZldD?=
 =?utf-8?B?cDJ3Zy81UUpNTFRsQVFaNVZ0SEttWVEwWmNZaC9iUVF3TlUvTjNibytLTHg0?=
 =?utf-8?B?MEh2U1V4STdLRGN0ZXJRMW02TlA1SVpJNXZPTzB0QllLd1pHWVNrUGcxVCs3?=
 =?utf-8?B?SDArRnpCalk1cVVBaWthUE9HNHVzU3JCWXdjdGdNNUFZMEhMYlg1ZG50aEE3?=
 =?utf-8?B?NUJxVy9xSm9hcS8zZ0Rqdjk4YXBuNEduWS9wTHR4WVBSaGdQVEJLMU5jVU1n?=
 =?utf-8?B?bjcvdWJ4cFIyM01wVXF6VVNxWG93YUFmUTdscXNsNXg2NmZ4TUdUd2ZTNDY1?=
 =?utf-8?B?TEgrVm96aGlYR3krTDhVTVZjTHdaMFJOT1FtcUx3OVIvV2tmckxuVEQxc3dl?=
 =?utf-8?B?bmlXRXRpYW1Lc3ZrREFYTkV5NkF0enNjOVVOWkN3MmVZeUdvM3FwZDQ0Wmc0?=
 =?utf-8?B?ZUFmd2ZUNFlsRjYybUFwZ3hOQXQ4WCtlVEhBZG5vR1RhQWQ0THpYSVQ3WEhz?=
 =?utf-8?B?L2luSDJMeVdUYWwwUEt6KzB6akRabGMzRDc1Zmxkc2xjcTVnYk9lZ0x1NGd4?=
 =?utf-8?B?RUxUTEZFOUlLTzFCby9KdmNYNmpYRW9aUHBhMkNNNk1mZGZQN2p5STZDUCtt?=
 =?utf-8?B?NE0ra1RybUdaV0llNmdKZHJUdkZiYnZGQ0RiL0M5Z0ZtVC9xM0huL2VnTXdP?=
 =?utf-8?B?WTBCRmd0SmpuTjZHS1VocUxzOElWZnR6ZzFqVUlCOHQ5Yld2eDMrVUk5Sm1Z?=
 =?utf-8?B?enVrV09Ia3VpN2dBZ1ZKcGxQTDF3ZmVLVEhVRU1MOTB4dXlkeUMxZHExUTJi?=
 =?utf-8?B?NVlWRVBQV3lpd2hkeFU0aFQyekhOa1RlWm5OYXExbGhjSi9oc0hveWJZcmZu?=
 =?utf-8?B?SjhIdURMM3o4MFg3c1ZtV1ZPRHlxbGNJMC9NRm1lbHNUV0xQN1c2VUdSUms4?=
 =?utf-8?B?MUVqK1RqSndESnZPOUlRemhNY0hJdk5zMWEvd0lKWWRGNWxDNytxKzhaR0tT?=
 =?utf-8?B?RVFNSXNMT0xLeHZQUmpFN2VYZ0JQTVBJN014RWR2TzRuaDRUMDFTa0s0VEFM?=
 =?utf-8?B?UmF6NFQxVGczUXlGdVl4Y2VPUEhPczVZWlJOb25IRytjT3NBdVNObmlyc1ZR?=
 =?utf-8?B?TmxITytTTk9KUVlkdFByd0RSZHNRN2tQQk9NSXlWdEZwWTFGUFV3ckRhWVB6?=
 =?utf-8?B?QUFscXpqdkovOVRzR2pLNnhpcVBpL3o4YXlnTDF2QUlGd1pMT0JpVHJlSVpj?=
 =?utf-8?B?djcyYlpwQVRoclV0UFJ0SDU2WUJKQS9aTU5FK0VkY0lvY2ptb2Q4R2tmcENh?=
 =?utf-8?B?MGV0bHA4ZlcwQmpib1h1SlQwcGhXTTJza3Fvc09TbDd5dHUxalc5cHpseGxY?=
 =?utf-8?B?Uk1RUjNML3RlYUlPcWVKL09rL3N6ekdKVUpMYlJoV3lMSHJ1RGFxMG8ybWF5?=
 =?utf-8?B?N0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8303ACCFA01F234C99986356A9FC784E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SbLrYICPc66Nt7EDGeAjUP2u3NK3PDDmcYx8o8U3yxEs9VGNlUXHGUYd2tAWR524f7U+Hh1NPabYK86krj+ZkBzoSWSoIbkxkUmers+DaJbnGom+U3ytsU7jV2o8QT7fTH10xbs5A/O/15UxMKOiCrf/nEvms9JrPVV+ttvZ3ILrbv5/EoXZrr+O1f6W/jT29ZqdzJI83foMUHBhYEIQyCSLTaukYeiFgsfpihH5ii9HEuaf5vq/rpyrH976Qxd9OoNJVIEJRHri+y8m7i76auF4aJ4RnVutvhWpa7VWWx7qi/unw9eDr0SUaL4Bb9YL6GNoVI6QiFdJogxFYP2IV1zNX7z/hVIIUQw3C9RH+B+5bpElElkaRx5ppeUyXhg5DlbfxWAb8TqzARho+AMpj1/R/ZnHmKKpbZI0Qb68JMTH1YCRzK5ZUX7Zw1toYItJ8Cb0umqMstJJz8YWxlsqjaY6cryJMBPQWKqhZv89MU67ZawfW/UrMyCSRxTWSstN37p7owdexMk94fVY+e9ZvSEfgkj6NUFqtiReY1ZfoVwCMFQqvn0u4C5Rw1LtAV4+Cy6ByQngt0c9xryj2iqmmpFx9fvoz9PpwSjjh8JgrzSCnexjSNTVRuKQ864BoDql
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8fb5cd-9e50-408c-ac9b-08de12ce007d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2025 07:21:51.3862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r8VdQ467NhRj7akJDFFXebWB4uyMzGJi77ltIskdR/5LPqcEe0HzT54Hgq08N16f1sbnMY177jTjM7GMoqg0V4QXsmjjfr9cb98ypOWJqas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8205

T24gMTAvMjMvMjUgNjowMiBQTSwgZmRtYW5hbmFAa2VybmVsLm9yZyB3cm90ZToNCj4gICB7DQo+
ICsJY29uc3QgdTY0IHJlc2VydmVkX2J5dGVzID0gKHJlc2VydmVkID8gbnVtX2J5dGVzIDogMCk7
DQo+ICsNCj4gICAJc3Bpbl9sb2NrKCZjYWNoZS0+c3BhY2VfaW5mby0+bG9jayk7DQo+ICAgCXNw
aW5fbG9jaygmY2FjaGUtPmxvY2spOw0KPiAgIAljYWNoZS0+cGlubmVkICs9IG51bV9ieXRlczsN
Cj4gLQlidHJmc19zcGFjZV9pbmZvX3VwZGF0ZV9ieXRlc19waW5uZWQoY2FjaGUtPnNwYWNlX2lu
Zm8sIG51bV9ieXRlcyk7DQo+IC0JaWYgKHJlc2VydmVkKSB7DQo+IC0JCWNhY2hlLT5yZXNlcnZl
ZCAtPSBudW1fYnl0ZXM7DQo+IC0JCWNhY2hlLT5zcGFjZV9pbmZvLT5ieXRlc19yZXNlcnZlZCAt
PSBudW1fYnl0ZXM7DQo+IC0JfQ0KPiArCWNhY2hlLT5yZXNlcnZlZCAtPSByZXNlcnZlZF9ieXRl
czsNCj4gICAJc3Bpbl91bmxvY2soJmNhY2hlLT5sb2NrKTsNCj4gKwljYWNoZS0+c3BhY2VfaW5m
by0+Ynl0ZXNfcmVzZXJ2ZWQgLT0gcmVzZXJ2ZWRfYnl0ZXM7DQo+ICsJYnRyZnNfc3BhY2VfaW5m
b191cGRhdGVfYnl0ZXNfcGlubmVkKGNhY2hlLT5zcGFjZV9pbmZvLCBudW1fYnl0ZXMpOw0KPiAg
IAlzcGluX3VubG9jaygmY2FjaGUtPnNwYWNlX2luZm8tPmxvY2spOw0KDQpBZ2FpbiBkbyB3ZSBu
ZWVkIHRvIGhhdmUgY2FjaGUtPmxvY2sgYW5kIHNwYWNlX2luZm8tPmxvY2sgdG8gYmUgbmVzdGVk
Pw0KDQo=

