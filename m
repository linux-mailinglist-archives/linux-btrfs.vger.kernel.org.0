Return-Path: <linux-btrfs+bounces-21058-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GI0MNao5d2mMdQEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21058-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 10:53:46 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 541AB863D8
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 10:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B3BF302FE97
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 09:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA4F32E120;
	Mon, 26 Jan 2026 09:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YRqpGanO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QHr8UNa+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB3032D438
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Jan 2026 09:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421108; cv=fail; b=SKepV1zoPXIGsmKiELM0ENZYuohLOWpxxsgyoc4T/iUgoBRkFTkEwtWWFHXNv+x9ZgSpL3rlzWDo4X/kmT58vgnuaR7AEPD02aAWbH3q7dnyyCc87ktsQNpfZwPfJ3vG2coBvexVJp5WpwxdR8jsDDxWwl/B6drq6mTf7yZD8TI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421108; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CMKCD9YVxXQRiu09ynd1FRSkblkyO5fM1JgBhHw8lae8eMLSwM0NAwNIO6ox5ALwrCyKN+FHsF3SaMU9DXlC6JjZaSnmcZ9DByUGfW1K/LPD0mSCm/3iOl8yQZV5BMSLdSKurpn1dV2puF7Ja7zXS07BmCi5i+w777Xo+kl933k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YRqpGanO; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=QHr8UNa+; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769421105; x=1800957105;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=YRqpGanObM9g40woMASw7tbfdZq+2xqQV34FbE+ZYgc/jsEuUMh/fv0X
   ABIUmuaFQGXlQxLcko4LsicpUlnUa28UJC0iVrix2wOVBDyI1kiHYmTBt
   TIlPoe3b2PyqqrFx0f5poYrRouaUR+/A5hqzSaOH7648OUM0heIbBu2at
   2h0g+rHFbbbEJA9OvShanJPZWaWjfxtB11D/4aLdNvrXsCmY0g18qjk/w
   YyQAub3UdpZDleFrr8al3NVL9iUpDgv5zTTS9+yP9Z4E8coaTXisk0LL2
   ROIS8mPhGj3nPhe0+1p0nZylqgcPt6f+3sCeDaTB4UTcz9bHKCjm0EjaZ
   Q==;
X-CSE-ConnectionGUID: 1bF8Yu6HTOitIyqPcZHOiQ==
X-CSE-MsgGUID: JEIfV0NuTNKe1SOBex8yNQ==
X-IronPort-AV: E=Sophos;i="6.21,254,1763395200"; 
   d="scan'208";a="140141312"
Received: from mail-westusazon11010071.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.71])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Jan 2026 17:51:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=st2uDnwU/NdpzxWxdqQcGupk+8kwmcH9rw09SWk5wtrVJoCS2anTedANHRv/Nbp5Eb73pUcUWrwMNlGmbF+CzEGsBh1SRviamHHaXYck2B0vecwG4TilwqjgMOSsc+iHXGZsqIX0ZO2IJuFHuN2sO8hRfDXXle/Cu6K/z8RWMiSk9tywBnJmZTVNAfKYqq8APLmTqf2qoDxXg+UTg9CqJa6mvFIZMIWimof5QUklMpsjJO1jkPD5cRyQznXS4T2r3UgCW03C5bnNT4KTy2YIoB3GxG099aQH3lYWP7K7oNmgecM4SAn478GjH12scjCRxqg8rHOl4CZqjZYp3eY0kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=ebr5wBJwshdQov8fHn5zLDjRAS0HdmlN2l2V6f/lCRlhwDQExfbF7+Ls4Z1ZnPo+uWG2FefY7hTlPE6jPumiObzPNSH9LQgpRRXJFY+AAeqVX34BNWN0Ets5w7ZrjyXBLDLVSn+qB3Y6GRQM/dtqzXc1OQOBKUCDlaV9KA5g5cF2lRAmSZkFm/xqAlkKnDj5K8DubVdAK4BtE+KZMpfzXmF5MEcdfJIZZ7P0vWnLgsBe8RkRTGspjaD9nDwP5DcQIQ4RTc7MzPWQDprLhhSIVDU+ZC5J0Fz1CWzEcBEDngDUYNmTyT3e0Ht/oBPPZUls9ct38nOF7jBwnPx5ovXyhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=QHr8UNa+Qg+REWN7XToY8ifJirTbeRtPVyKrH8Qk6/Ms5756nMQLIvb5puWYSwzLXa5cP1++XmTwJv0Z1sAZ9f+DV2YHoRpqTP3F34klLgZfhptMLkGqdNwbbYLZZODUxjq7w6heMYXZs91+TFeW6ws8k2IwE66kZ8rSuadr9Eg=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by DM6PR04MB6986.namprd04.prod.outlook.com (2603:10b6:5:24f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Mon, 26 Jan
 2026 09:51:33 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9564.001; Mon, 26 Jan 2026
 09:51:33 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] btrfs: zoned: factor out the zone loading part
 into a testable function
Thread-Topic: [PATCH v2 3/4] btrfs: zoned: factor out the zone loading part
 into a testable function
Thread-Index: AQHcjoe3tDhNpy7h8UiQOqABBubq3bVkNamA
Date: Mon, 26 Jan 2026 09:51:33 +0000
Message-ID: <104b3598-1d43-4478-bc75-b282fac5d7d6@wdc.com>
References: <20260126054953.2245883-1-naohiro.aota@wdc.com>
 <20260126054953.2245883-4-naohiro.aota@wdc.com>
In-Reply-To: <20260126054953.2245883-4-naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|DM6PR04MB6986:EE_
x-ms-office365-filtering-correlation-id: 9e840d56-6dcd-4e3f-2821-08de5cc07cdd
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cXdKWjJrVEc1eHVuYXovL3ZzVHhFSVlmd2UzL1EvQnVtNHB0RHJEVlkxTk9N?=
 =?utf-8?B?U1NITkZuRURpOEcyV3Zibk8yVmtENHJDaFVTWGNrZXdZWXlzYVFTc0RTMW0z?=
 =?utf-8?B?M1lmdTJwVUI1c1ZGc1AvVFZmTFE3R3cxRGpvcTNhWVVnbDBVczFQbjcwczlo?=
 =?utf-8?B?RnNsV3l2bVNFelllR3NSais3WjBodWZkWVNLMHNFVXBrRG9UUWhBRGxLd3BQ?=
 =?utf-8?B?YkZUR3RXakdGZC9kalk4U2lxNnRJU2pLS2Fwc1ZVZGliZkk5RlByUUgxV1Q4?=
 =?utf-8?B?Z21CYlZxUDlVZmlxRFZQQWJBbmpQU1FMb2dkK2piRVNEUjJhaHBTSCswaHIz?=
 =?utf-8?B?SlJaN2kzQ29EcmdtaEI2V3RqVysyTzBsRE1ETFB2S0MyN1IvYTErWDlncTBy?=
 =?utf-8?B?NVovUXR6UTNzb1hyOUh1L0FTSnpFS1Z6bktLckJQZ0I2NFpSYjk4SWx4dGwv?=
 =?utf-8?B?dDhodjdVSk9Zd05qZzZ4NWpRbDkrN2txdkFDSDh3Ri9XVGtYZkJDNHd2cEhZ?=
 =?utf-8?B?RWV5NWFYc2xBM3dtNk9WWEwvYVBQcitZbzMySU1Ha0Y4MnY1OHBzbzRqSExP?=
 =?utf-8?B?UWxXaml6Y2J4Lzk1QzNVcHRCODlYQjN2aWMzdy9uYS8yU2ZTTzlZS1lrbWhj?=
 =?utf-8?B?NW10MUNlaXFhWnBGNzN6bkpQZnRITFc0WGcvRjhINHlpeVZXRTJieUszSXdP?=
 =?utf-8?B?bEJrMnFScDB6YmYrYnNRYmZEaGVOZFpYWG1QNWxhNnpQZWF3MnVBWDRYY0Ex?=
 =?utf-8?B?TGV6Nko1SElsZnNJdFF5dzNRV3lGL1VoVDN4cEMrZFlSOS9INzZCN3lsSEpp?=
 =?utf-8?B?ditIZVhMRWovdU1PWklJZDhZVUd5UXhKbWt2Q2xVdXhGeG1WbTBPalZCa1pl?=
 =?utf-8?B?K0ZxMlFjdGdCbFl1b3UvaklTc296ckZoUTRDMzFjUXFycUoxcE1KV09kOU1E?=
 =?utf-8?B?OXdsSmZ0OEo2MndEdjZSRDM5KzUrbDF1Y0l3eWs2WmsyWCtaWHlMaHR3NDFz?=
 =?utf-8?B?N1Y4aGIwY2ZqUFJPWjJIaEQwV2xzeThJREk1Sysvem9BQ3VWbkVkZEU3MUg4?=
 =?utf-8?B?UVFhM2xhWFhzeXh0eUNpVUlZcHhIQStrSzhrU3E3elhxZDJOTm9GQ2c5d1E5?=
 =?utf-8?B?R0ozZzFtU1hHdTU4TDNSalRlTnhGbXNxTTNpeU44WFN4MGVHRnVOYTJlbWVy?=
 =?utf-8?B?MUcybmc3RkdrdW9sSXBBeFFaY0k1MkNNWWlWcW1oM2pveVlmcWtuKzA5TTQ1?=
 =?utf-8?B?ZENKc3pXMy9yaXVYMkI2Ulp6U2d4UWxMR1VuLzNJRzNQbEplOThXSXIyOUY3?=
 =?utf-8?B?QTdwSWxpb3EyalhDTVlFVTRhWnJydVdtYkw1WlNjY2FXZ3MwY1lweUNvbkwv?=
 =?utf-8?B?VEZ6cWZWZHQ0b1RneHh5RE1hbTZ1UWdyWUd5MkZHNHkrc1ZmZzJ2c1ZRYmNP?=
 =?utf-8?B?UzhtcWk4V0V2SHJhT3duRkZnTzBJZ3ZVZ2dnRnJDQzhLWDdMREN2OHNadmRH?=
 =?utf-8?B?TndyaGZ6djcxM2tjSnRYWDBQNTl0b2c0TWFEdFE1TTgrS0Rmb1oxZ1NCVXJ6?=
 =?utf-8?B?c2ZrVUlrTlNoTTFTQ0dhcWlQQ3RLeWpvby9hbDFQSlBBWmZoTkVmSFlZTnI2?=
 =?utf-8?B?MTViN3g5NkwweC9pQm1IZjM5SkdTZjdNVWhYVldESVlYbUY4L2FFYThWTnRl?=
 =?utf-8?B?cEszc2lRRGdJbkh6TVlUcDlsMmZQTFVxWS9mNEdjbTdJWUNCQWg0NnNOenVl?=
 =?utf-8?B?OXV6T3VxOGt5VjJqOE8vaEtEeTZ3R2dWYzg5QVFxNkdlRHJEWVdVNjluMjJW?=
 =?utf-8?B?V0wvZ1Y2MnlCUHRmSGlSdTZ5R3lILzA3ejhxNVlhS053Q2N4OXJwMm9IS1NW?=
 =?utf-8?B?UGo0TnplczNKRkFRbzE0clFLQVB2eHJNMVBUZXkvWkRxcjNzU0x3cVQxSWNT?=
 =?utf-8?B?b1podTNzRUhnNmRHdGdhcTNhNWRXNU9XTDlGajF0MDUwdXpva2NybXc5UjJj?=
 =?utf-8?B?UTdZTk9VSzJnZCtBbzdPUy9VMWlXaHFncUU5WSs3dlBKM2V6b09OOGxENGJm?=
 =?utf-8?B?ZDJ3Mjh0OUVWcC9lTDYwOFNmYlhlamc3TjBaZlRETSt6bUVTR3N6Mk56K0VJ?=
 =?utf-8?B?RmNtcUo2T2g2ZTVrRzlWYzhlY05TS0VTWWNyTUR6M3VHYzlWZWJ3bzVXZWxu?=
 =?utf-8?Q?b58hR0+MDbXpBm6q2nzyR3s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NStvOHRJODBOT3ZwODFPLyt2WWt6bVlkRXh5RjQ1aDNDdFhZQisvMER5UzR2?=
 =?utf-8?B?alFKVmN0K1NaN0JwRUZUWDdWWVFSS3ZOSnR5VkhSM0F4alBlWDVNTnpnV1BC?=
 =?utf-8?B?azMrandVd21OSGp5LzhRRDFMVmpDTzZuTitSVGdVUmJvejltaDFaUElBYVZi?=
 =?utf-8?B?b2k3aGQ0dGRiUGxjR2V4d0xFdVlyam5BTjVwZm9Na0ZSREVJbWl0QXcrZE9B?=
 =?utf-8?B?dHNxUzZYbC8waDRVbDdYMkR1YnVLQVlFVnVpMzZONndVdC9JUzZxZERxZFZy?=
 =?utf-8?B?eUNmbE9TTjh2dldwSnpsQVVCNTVSb05FRVltczNaL1lPcEZ4UU1Pc2g1ckF2?=
 =?utf-8?B?aVFIRlR4Y29KVFdOblQ5V2N2MnprK2lMU0kvcTEwQkNVSTNYOVZTNkppbkdW?=
 =?utf-8?B?Z25aTXFlcmFXUWVlTHZTVWU2QnVwNkNZbGtwSXRncDVYc0hTRWhyZFVDcFRG?=
 =?utf-8?B?M29ia2dXY2JSdk5RM2lwN09WZmRIdlgxcGNRT3BLRVFpTzdmWGpCMjlTLzV4?=
 =?utf-8?B?NkVCZ281eEIxQlRyZ0hqSE1xNktQVy9IVXBNS1hZZWIrS1hmVCtlMnZhMzZL?=
 =?utf-8?B?L1hJeVBCQUxCQnRqOEZEZlBVUzlMTWhlMVdKOUJoR3k4M2tyaVgzS1RVNjZx?=
 =?utf-8?B?cWx4OVZCZllTYjNwdUxjUWZFNHRJTG56RkRMTkFBWUJxb1Y1R1FJTFJkQ0dz?=
 =?utf-8?B?U1FBYWo0SGZvejBaV1d6U2o5RnR3MnpqZkpwcGluc3ZFMnhwNktTYzhJdVdZ?=
 =?utf-8?B?Nmd1dVY4WjFSVUY2enhLZ2xOekRHcGpJUncvMm1ad0xCR1pZblBUM3pUQU5s?=
 =?utf-8?B?MFE4MzI0RHpoZzR1MUtqd0hMRlhmYVlNbzJ5ekQzT0NmK2V6dmFZWkdCajNL?=
 =?utf-8?B?TXlJQkxsZENMUU95b3hSTzB3aU9ETTd2dHk5NXFtYUhRdXJ1M3RCbVNmU21l?=
 =?utf-8?B?eUkxZ1dTWjE4clBKNkx0MEwwQ2ZRZWxnUFh0STE0NUtkWHk3TGwvdEI0WlNz?=
 =?utf-8?B?ZjBIVG1UR1UyQTM0S3puNWt1OTBxQlBsNWEzb0tzaXhXMHBKVWpzblk4YXlr?=
 =?utf-8?B?dWlFR21FbGR5UWY2M2UzRGpEYjRSRzArVS9DWEEzeUE4VUZ0b1V1RmowTUV0?=
 =?utf-8?B?UEJiV1FmYmRlcFBxTHI1amZySGxoWXlkSG1lOUFtdHI0REx1N3lvbjBTVXVu?=
 =?utf-8?B?Rnp3aXlhTFR6ejRRbWhxQm12NDhkQzdBOVZteDBnUFhveWVUV3RYWnB1T2w5?=
 =?utf-8?B?RTZBYVFvMXdmL0lnWWxYT3hhM2hBOXNtdkpnblFHamhTU2llNGpPOHZPd0VD?=
 =?utf-8?B?RW9uOVZyK3IyZmFkeHhxenBubzlDNU0wVVp2RWVUZ050UDIyQmFNZEpaVk1u?=
 =?utf-8?B?ZU1YK0VRNml6UXM4STd4cnRxWlMyUmNUU08yZk9EcmVHbFVNV0lXNHE5WE9o?=
 =?utf-8?B?Vm1RVkRZRVp3dWVtOFRsWjUrTHJPcWtnMytRaFhQbWJaRTlCS2JqalBsdjRl?=
 =?utf-8?B?RmN6T3JyM2Vra3ZzUC9HVmhxWlU1d0cxd0ZUckxmNkVMdWVnN0k3cHEzTEg5?=
 =?utf-8?B?enVJbDdNTGdpbm5QY1dZVlNUYUo1MHl2L0NUaEx6SVpzU0RKK1NBL25JMjVF?=
 =?utf-8?B?bXY5SHlRT1FrMHVKdDJ6R1V3b0lEeTBheDlLNUt5cjhZUGhuUXd4WC9nQk9P?=
 =?utf-8?B?c005ZGlCQlBTTGNVRHpOQW0raEZXaitpSExWOEE2Qnd6Q3FsUXVxREFwMWV4?=
 =?utf-8?B?NFZRTzl4ZjV0YzEzVXdvSHlsWnFwRWNERXl3cWNqNFU5aDE5YWRkSHVGMHVI?=
 =?utf-8?B?aXNITGVBbjVIQnJsZzZVL2hoeElDTkUza2FhM01KblV5eGdzd3ZBVzlMR2RR?=
 =?utf-8?B?Mi9TYndYY0U3MlNTeUM1L3JOUS9zaGFHam5mL05NT2NJSHJQQkViT2Nrcjky?=
 =?utf-8?B?UWFtMnROeHVIUDhybjZMaWFvQWE4SXUxN0IzSzZsdTM5QkJxU2MrQjUwZkJu?=
 =?utf-8?B?WnJMTzErU0k0VHN4OFlPNktYTnliaXJCcWRGTUlPOHl5NmNwUmZ5ZStkWDNn?=
 =?utf-8?B?QTgzQlF4U1Z5VGR2QzBhdENianlodnlGbURGeGtIKzV6REJxT0grR2JoNWZj?=
 =?utf-8?B?bjhQaXFZakk4c1JwUDlXTTREemlab2x4cGp0OEYzQ04rMnJ4Wlhtcm1TZDlS?=
 =?utf-8?B?NG40YWYxcW5mQk5jNUhteVBuTkxlYURVdWRGRlJuZFVXUUlvVWFFc2tDVmxq?=
 =?utf-8?B?V1pBMUk2cS8wazNHMVB2THVaeHppaW4rRkNBSit3RHR1MG5HejdkalEwdnJs?=
 =?utf-8?B?OHBQanZ5L2k2UTgwZ2hZeFZaWHB2enpSeFNmdjA5MGYzanc3N3pkNzlYNGp1?=
 =?utf-8?Q?xF8SKkd9vPdXkLFI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F0D0D9CC7FF8449A0245576C57C58A3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NPKgvcQk/ax2L5CUZks39zm8+3/oiSYdwKKJt2KV8WzqjGcaoqE8mtYSYqu4lYBm73at1jEjg9N63BZUpol3jFbtz0vNc8ULi/0Bjl1GKEqHdu+zbkrTgQaEFCCkWzwxYwn7VTbc3WDMj73EuquToyGlG6qZnQkSDwuGcP8Gz14fLCDZqi/oj3qA6OzPgtqXqfi1+Qq3M4ubGG0fR4l1G+JRaM45KHrZfOn37/bsqvodlL+/IC6rbCOKOZFyzBoM0/fjQakwN8bzni0yI4SsvO8yzYLrBN8m84eU6m8ez1++S1ys5rXyN0ExxRIOB44CXJLxu2udviowqJ6WTW7rtlHHy8Zd6JpOOhO97MaFX+HbL6vH6NeSuYxfJ+bF407JDkmkUsPK78SlhVR3XEqA8rZmr9oBtbdDQjgF+GQYHhWhr+X/aaVr248CnOyzTLctHInl5tUVLCvfge2pU0qb0SDV2ZfM8dcdAYWQVXKhIDENrFBzEC05wZK6lAMjmdeLhNXUtQ6NQ02uvkBre9cDQ4hQSmlwrIN4YV/KUmzXhdv7mNuv8fe5ZAzucZ1/9TMScp1Bzot36U81WVfZyTxR7iPKqDA6ZW7QJEe9qMnrCF0RiVjD35ViwpBIcUoqa0zs
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e840d56-6dcd-4e3f-2821-08de5cc07cdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2026 09:51:33.1307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rU3cSzr/klC63ZBL0kqXCXGBo0QNF6ekr1yrw4z0tUfoD+sz9L6QwIrLNhl+vmwCNa9fBuQglaFDPC39rbPcb6LGgG53K+MWxh3SoD693qA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6986
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21058-lists,linux-btrfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,wdc.com:email,wdc.com:dkim,wdc.com:mid]
X-Rspamd-Queue-Id: 541AB863D8
X-Rspamd-Action: no action

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

