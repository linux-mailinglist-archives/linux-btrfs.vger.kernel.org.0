Return-Path: <linux-btrfs+bounces-18631-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA04C2F443
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 05:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1837D189D407
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 04:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7090B270541;
	Tue,  4 Nov 2025 04:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JHGUUAhj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011008.outbound.protection.outlook.com [40.107.208.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D202727E7;
	Tue,  4 Nov 2025 04:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762229463; cv=fail; b=d1Fc/5qbTZu7nRFYKjWY0iP+IC/X9aonr63n2SoMJSAwcPiESt4036piEjJEDNP2dY6ApRIEYt8WvzXVbRkxvpka4kyWZnP/+UiTohFS/KLV9ncps5B6PW7lzI80lxUuacWWT41qMC0keExKCFnNvbFunf2Ku1zw2VDnKx76c5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762229463; c=relaxed/simple;
	bh=PpOpxZOyv+Ww32USshlm5x79OKcRw9lsTyqn1R/V3DY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=unwV8GmXmwxbXdg/U3wA1Z/TK3Zq81I72KlqHjznL+e04wBRkVlEuZRMYEmMPwISztZcflnT3MCmEnFBUisvK6qALwJ7pGlLJ6Fh7jQQu9K0qmFv7iZ2dmE3X5c/uuEtEJcuBcJ121FTeVwMfHAdsRZH4Zijng8/NhC4lS+Pn1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JHGUUAhj; arc=fail smtp.client-ip=40.107.208.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UYmLWOuvKLsdKuqasggDjzFy4FbYKrFzd4iTj3ejDivK3iE5+ukn8rMQ3gSLu60U6xzMgGwNnaO0R4L4gtCvCDyqgeuxBwwaQqApeHiEosIXVcNfs41ok8eBrJEoyvR+otOWWUXdc4x4HEd8619i5koSSBGLPAxuCk+Af69K5U6crmdL18tnIzNJj/iCGjBNV2V6VCvRVA9xZN/h8d3pqImWpTYpczE3M8QwMC+iEGWmJA/4wQL7qjGUtZHNZSaQoNTTG6S+xww7WiW3wHDcyKy3behaoL+rIlznEFhnGZ+VnqsnmF5N0XGmZq06JW4oWuCK4Gf8Ub7fPLIeIo78qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpOpxZOyv+Ww32USshlm5x79OKcRw9lsTyqn1R/V3DY=;
 b=hWqW8TwQIPLLSwuTSoki+5grHhys7GkLUy+1odODyNtaRuC6p1ORUvkT72IZHY6WkbleHbuS0ZPg5ale8V4ghOvreP7ecnR5bOvPb3tXaIE9kkIoI+00zvhRsrkXs+zA1VhukRzVRf2lBWjy3tCXsA/kPHuXU5Sdz8OkckIkaGWX2WM8DGU05niebgxC7KhI0So2JzFEFvml/8w3AYXdoknsX/6bhMHDVrx4B2vaQazyiWXoTYhUJ9DJPYeIwcHu/7ab/5w0U9RaxuVgXPimzhqd7s4P7PGCQNac3OoP6kXZ1yX4KwujFXPHlK5LyumThVjj1BkYgfECWrASJBpUBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpOpxZOyv+Ww32USshlm5x79OKcRw9lsTyqn1R/V3DY=;
 b=JHGUUAhj30ea+dCNxiC0ethx0qpTG+AS4mVeKimprunOw5FfNRcXXEqjSPgMaXI3OCriLRtgCnK6yTOzWPBNBiS49m1cN1m6MlLYV9OvqCyPeobnt7AFmtKn7v5e4zhcmjJ7oQWuTEongKNkRe4jxpWeUynlxF0GLvyJmpfpa7kQP1yzIiI6aert+mxH/Qyu/uPjJT9yvGcBbuT2UUZqVrAQXSnVEkvc++atlDMNideE/wCUAL+Bq5WzDSCwbItK75j/goNz72S0dyaQp7d3r1srT9sveW+ZODpmrfg0V3slrPZz94vbT/AtCwvzAD9GdQDC28hxNCnVQwHH93m3Kg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS0PR12MB7632.namprd12.prod.outlook.com (2603:10b6:8:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 04:10:58 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 04:10:58 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>, Mike Snitzer
	<snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, "Martin K .
 Petersen" <martin.petersen@oracle.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>, Carlos Maiolino <cem@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, David Sterba
	<dsterba@suse.com>
Subject: Re: [PATCH v3 09/15] block: introduce blkdev_get_zone_info()
Thread-Topic: [PATCH v3 09/15] block: introduce blkdev_get_zone_info()
Thread-Index: AQHcTStrpDZ3l+cUykmXCKtgwU+bQrTh57OA
Date: Tue, 4 Nov 2025 04:10:58 +0000
Message-ID: <4d1d4b21-2655-405a-aabf-0395e3d55b1e@nvidia.com>
References: <20251104013147.913802-1-dlemoal@kernel.org>
 <20251104013147.913802-10-dlemoal@kernel.org>
In-Reply-To: <20251104013147.913802-10-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS0PR12MB7632:EE_
x-ms-office365-filtering-correlation-id: 489068f6-de91-4298-5055-08de1b582861
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?cnBCQ2NTbkdhYk0yUlYxRStnTkg5TWhyWnBGYVZScmlHOTh4QTJ1cUNPSUth?=
 =?utf-8?B?SDRWL2RSaTJlSG1Qb0tmenR1OXpHM2wwWEhMTStkdjdjL1p2eUpLTTAra1Ax?=
 =?utf-8?B?bThvQmY3SkdOUEgyQ0lnOWd4Mks3cWpkOU03cFc5ZEEwVk5qaytvMUZ6bWpZ?=
 =?utf-8?B?ajFyQ1NBWWxPUit5Kzlwejk5dHNXcW1wa09hckNJTWloTHBoTy9lOEF0dHBY?=
 =?utf-8?B?clh4TXRvR0E4UjB1cWdrelRCa04xUlFaZWh3WmliMnNPNGpPRml0SDFPWlQ5?=
 =?utf-8?B?WXdpVTlRSm11Y0s2QW9ZL0xDUUFvLzdYM3VxZjZPUkgxYmUvWGd4ZExobElY?=
 =?utf-8?B?YjdrYmRxK1EvREhDZ2VtZ2VjY2lUMDRXcXIwQ1Q0YWZuQnNKWjFvQ1k5TnBL?=
 =?utf-8?B?QVN3R2RYbXJpT2FHN0dUbDVUeHlNUGRPVEh3UUhvUkpjdWtQcHo4TEdwMExM?=
 =?utf-8?B?K09Qajk5NGxCYnpoSExTbEsyVjcvWU84clYrbWRORGRiV2MybUR2QW01V0FU?=
 =?utf-8?B?Q3FrRWJGeVgveTlPV1QxTFlhY3ZqOVRzRm1LVXBlZCsyWTNvWGlvTVJscG93?=
 =?utf-8?B?Z3F6RVEwODM3bWkrWVVFTzVOUDI4amlsZXZrU3J5UUhvUGYvaUNhSFliN2M5?=
 =?utf-8?B?SGllTVdrNFhTUTR1M0dZMEU2TGg2ZnNWREMvSWc2dTB0WG1QanA0aFZ0K3Vp?=
 =?utf-8?B?WnZxMkVKcnhlZm5vb3I2RUJ2QzFHMXBxZ0dsbGhJdlZiTFk4QTVLOG5pM3pz?=
 =?utf-8?B?ekcrOXNubThHVHN6eW9QMXF0dnJrWGM3WVlYTUdnM0NSbzVZQWh1RVVzZEc5?=
 =?utf-8?B?WmRoQ2xaUXBDc1RwN3I4cUIrZkZLSEVLSlhOMDZPSTFPeXdya2RrZndZWWVZ?=
 =?utf-8?B?Vk5tZXhqQk56d0c3MTVXZmFQYTNCSXVnM3BZUDNFejM2dWxYbDlTTXJJVzFv?=
 =?utf-8?B?Ynh4WUxVR1FQekJhWEZ2N3A5Q2doRTBqdW5OTDdQTXdXMWlSS2lDYUQ0bFFJ?=
 =?utf-8?B?U3Y5NEluV2VEekxrSWFyekJ3TExSMXIyeHJOQ3pNTVhQcXJFR2Q0NjcySGNi?=
 =?utf-8?B?N3JXZGR3bzNBL1pmaE54S21mV1ZrVjRTaVBsUXNvSkE3SjVRNDhoeUg4YlFL?=
 =?utf-8?B?Z0VLcHE5Z2xRcVFFaUFtTHRHSCtwd3ArYmJ5K3laa1UzY1RhMW9KMmJuNEdZ?=
 =?utf-8?B?RllIeHVSQ1oycDVrY2VvYnhYNml3TUlzSXg4Z21taUNTOHVPOWVhWlE1RER4?=
 =?utf-8?B?RXhZZ29wSGQ2ZzI2MzFZK0FWYzZVY1FPcHduVVp4NE4xalJLbS83RUxIY0Ry?=
 =?utf-8?B?STRqdzBVTkM5cHhvYm1CUWpXdnhwWHIxa3JTMFNaWFh1YnBBek5XaC9JVS8y?=
 =?utf-8?B?aDFkNHhHL2ZSZ1A3bGJRVkRIQnJ6ZlgxN21JRlhHR2p4VUc5dUpaUGt0YUVq?=
 =?utf-8?B?T1dvWkRnQ2xtZW5mc3phQ3FNUXNUSHRLREV4dEFvd1FoT0FOc0M5VmxKTUpN?=
 =?utf-8?B?dGJCS3IzMkFlcXlzcHdPZmxhdXZSQUFPMnV6bW1WcjV6UU96RU9oOGw2MU9D?=
 =?utf-8?B?RVo0RCtWc3FKWXNNcVpYbC9RL2ViZ09OMnJTajlydS8rMFUxb3BGcmh6QnVa?=
 =?utf-8?B?R2htM1JwSXE5NGZoeUIydTY1bk85UmxmcFlvTDExNXRiS2k0UTV0cDd4eTdl?=
 =?utf-8?B?VlhPRnpCRUlOYzZLYnJrNWhBL3QrOWp0clllRW13dTRxVXZ5SktjUExMWUpx?=
 =?utf-8?B?bG1URCs2K2doeUJwWktKOVRvZWE2K1VYZ2ZuOUZWM1B1amJHenhmWEtDRzlk?=
 =?utf-8?B?Nmo0RFZYbkVTMkJsdWo2aTlDV3B0UWhzTk45a01VNWM5RkdJSmZuaGRxMjlh?=
 =?utf-8?B?ZnBiRFl4SXhjQUlLeDVEUUVqa1I2THFxQTNrWXo1dVFuZnl2NEVlekgyejNY?=
 =?utf-8?B?TFphK0FzaEJ4U0xnQ1pjYS91NngzMDdlZ3luWnVJNFF1U1hhQkExQXZDUUpQ?=
 =?utf-8?B?MFB0RHV0OWVtcGc5WG1iL2h5cnFLdjdRVFg3WUFtUUY0QnMwbWJjTy8zdm50?=
 =?utf-8?B?NEhjSitGMkRGK2poSjlRalM5bThXUW1tNk81UT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SE1EUzk1LzNzK0tVKzd1UXRDSm8zd1owM2tlMkYwMkhDdyt0RFVCOWlkdHRR?=
 =?utf-8?B?cHg2dXZBNWtST1VaMFdaYXcveVMzOEJKVWxWRnpBQzl1YjR4UWN6MVZLc3gv?=
 =?utf-8?B?RktLQUlDOTBuZGwrYUtPYjFOOGozZFRheEVReTJXZ1orY1BvZ2lnRG5iWlZR?=
 =?utf-8?B?N250S1gwZCt1VzJUTEJWeHlZbnlIQVU5UEV0aDlubWhxOTdlNWNMUS96TlNz?=
 =?utf-8?B?V0dzc0tYZDlyeGxEM3ZkdG42bEpoZUcrVk9PMDdwSjBjWDhsaGlJZ1VsUHl5?=
 =?utf-8?B?ZEdTVU0yeVJZeTZ2RkJzTzdHc1oycDNVaUg4S2E3OWRTR0NaVnVHWk04OHJ5?=
 =?utf-8?B?OFRyaHNzWDVUS0hmWnVzYnRGaUtqZm1vV2I2MXl0WWo4bkxtNk5XZXRWRyto?=
 =?utf-8?B?WHdZZmkzK1JDSmVZREcxTk1FS00zQ3ZQNWl6QVdGb1BuSHpNMU9qMDVZQ2hT?=
 =?utf-8?B?eTlIKzluUTA3WXk1aksyd05XeDI3aE5KNlJmR1JSSWJUZndUT1NqSVhlWnBT?=
 =?utf-8?B?N0NIOU5KVTYrVXNXVlZhQk5JTGtkQWpnY2w3S3F6YUUrZnlPNHQwZ2o0M1dS?=
 =?utf-8?B?NjFaTU1GdW9LUG9VYitQQllrSUl3YkExSmZXZ0FZQmtIbFMreXpwNUtRcHRZ?=
 =?utf-8?B?UTdlK05ueWg3NXNPZlc0WFpMamN4d3dBWU0zR1ExMnRpVmNkM2ZlU1NuTXVh?=
 =?utf-8?B?L1pQUkZMaTIxNUV1c1NVYnVWSjJ5a2lJQ1B3S1dScENCckxlWXFBdGVxbHdP?=
 =?utf-8?B?ME1MWDFZQ0pwdzh3cEhlZWhSdGZxbE1Id1JwUngwS1laajVyVDBWcFFWeWFy?=
 =?utf-8?B?RnUzUmZhTzdLd3FZK2tWMlhsejJ0S2x4WnlBdmltdWkwZk1NNnhFUGZPdnc1?=
 =?utf-8?B?M0tEN1pjZ3FhVGJ6MWlHV1VUYjFvNWxxOVdYVXhtVDhUYlhpcFhtbGNYRFpq?=
 =?utf-8?B?RHNxb2ZXK2IwVWpESEZxSUVYcG40VnFxcXJXOU1ydytzeGx1MWV2SnZTNHA4?=
 =?utf-8?B?QllJckhtS2tZSXhwclFHdEE4RWlvRVozd0NvbDhiZld3VDZnV2xobjV2aVV0?=
 =?utf-8?B?Q0RTT3FWRk9iLzVmRjJ1aktWY25BUDQvS0k0VkhlcEs3ek4vcXdYdkpBMEh1?=
 =?utf-8?B?REhNVUpxdGVSdmlBODQ0WUtJQmRsbEU1TVRJdWdZWkc4OTF4azZhNHNwSSs0?=
 =?utf-8?B?cUhRN3NQM2J1NGFCL0RwcVVrNEhMOG93KytGU293cWg4d2RnWDQ4L0NBb0Mw?=
 =?utf-8?B?N1QydHVzZGIzVDEydjlMcWc3WXVUdHdESFVnb1ZKYk5DUkdaMy94T0NVSXNs?=
 =?utf-8?B?eVRYWmVuejZERGJ5eTBTMWVUV05RTnlxTm9PMUdSWE95TlJsYUt3K1REb0No?=
 =?utf-8?B?YTBkWUw3N0JJTThPVU1IazhWWkpLYVIybTdFWUlFLzhma29DbGxoTmQxL2NH?=
 =?utf-8?B?VmdTOG5leGtqdHl0dzlaVE5OYjFPaXdmamlDNytuckpMYXpMS0hrSDFZQStP?=
 =?utf-8?B?ZzA4bFZWWkxKd0xFc0lXKzQ2QjBxSWlEODdneUxBYzdERzAyRXNwRG9ja3ZZ?=
 =?utf-8?B?OElhY3U2OUZ0WU83V1FYMm9SdHdsRU0yVkFDM3RHanpFZDNzbUpwOERmNEov?=
 =?utf-8?B?aG5JZG9qQmRHMmZYN0xMNExaLzFlSFZGWmU3ejdCSEJXRmRVdEluRmRMazNl?=
 =?utf-8?B?QWozbHZMTVdXTGdDK0ozdkZmblAwbnl2RFdUSjZyN2J1bE5URTFabnB6V0ZP?=
 =?utf-8?B?cGQxSUpQbTZtK05qK2FKb1RkWGVEc1UvZk9MQ092c3I2VnN2dlhqSnZvRFNG?=
 =?utf-8?B?T2FoRTg3L3JIQVdDLzZVUjkvVjI1K1RtZTJNOGI3aHAvRGg1dnhqdUxsa25U?=
 =?utf-8?B?WU9sZ0QvaWhBcFkyKzhVWTg3MTRCazBUY1dqYTFoc09CSUlHa3d1Qnl0anJG?=
 =?utf-8?B?RFpKTWhqSGQzQkp3Wnpkbm9nanZIbTlwTjY0Y211aWFYWTZCZ01uS0ZmdkpO?=
 =?utf-8?B?WTZIUnpjZnNNTVFCOVE5bXJkMEx2bkFSYkNxbmovZzl1dzNKSjcyWnVRVEcw?=
 =?utf-8?B?eHFjekZ1ZWd6NGdDMlQyVm9CMUkyVG11UWY0K2FqNkxlMlpQamh4L0lLWU5B?=
 =?utf-8?B?cU52NU0zQnFDd01YT2R5NmtxemNXcDNtbWgvYXRIQXlPdGlIekl2ckh6SWFu?=
 =?utf-8?Q?i8dSU9oPVXNxSP2YpGIsoyFNOxFKwHRvEAQ0b/Scw6KV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4C9FD590E26AD4FA35625F4821AA32F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 489068f6-de91-4298-5055-08de1b582861
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 04:10:58.1252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fpcwIMucac85C+iVRRjE2FDtj7wBhA17vqe2bjmrNsUCqcM2joowUSvsc8taNqdIxkWS3Q5aYCmnj8H+Zzfwbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7632

T24gMTEvMy8yNSAxNzozMSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IEludHJvZHVjZSB0aGUg
ZnVuY3Rpb24gYmxrZGV2X2dldF96b25lX2luZm8oKSB0byBvYnRhaW4gYSBzaW5nbGUgem9uZQ0K
PiBpbmZvcm1hdGlvbiBmcm9tIGNhY2hlZCB6b25lIGRhdGEsIHRoYXQgaXMsIGVpdGhlciBmcm9t
IHRoZSB6b25lIHdyaXRlDQo+IHBsdWcgZm9yIHRoZSB0YXJnZXQgem9uZSBpZiBpdCBleGlzdHMg
YW5kIGZyb20gdGhlIGRpc2sgem9uZXNfY29uZA0KPiBhcnJheSBvdGhlcndpc2UuDQo+DQo+IFNp
bmNlIHNlcXVlbnRpYWwgem9uZXMgdGhhdCBkbyBub3QgaGF2ZSBhIHpvbmUgd3JpdGUgcGx1ZyBh
cmUgZWl0aGVyDQo+IGZ1bGwsIGVtcHR5IG9yIGluIGEgYmFkIHN0YXRlIChyZWFkLW9ubHkgb3Ig
b2ZmbGluZSksIHRoZSB6b25lIHdyaXRlDQo+IHBvaW50ZXIgY2FuIGJlIGluZmVycmVkIGZyb20g
dGhlIHpvbmUgY29uZGl0aW9uIGNhY2hlZCBpbiB0aGUgZGlzaw0KPiB6b25lc19jb25kIGFycmF5
LiBGb3Igc2VxdWVudGlhbCB6b25lcyB0aGF0IGhhdmUgYSB6b25lIHdyaXRlIHBsdWcsIHRoZQ0K
PiB6b25lIGNvbmRpdGlvbiBhbmQgem9uZSB3cml0ZSBwb2ludGVyIGFyZSBvYnRhaW5lZCBmcm9t
IHRoZSBjb25kaXRpb24NCj4gYW5kIHdyaXRlIHBvaW50ZXIgb2Zmc2V0IG1hbmFnZWQgd2l0aCB0
aGUgem9uZSB3cml0ZSBwbHVnLiBUaGlzIGFsbG93cw0KPiBvYnRhaW5pbmcgdGhlIGluZm9ybWF0
aW9uIGZvciBhIHpvbmUgbXVjaCBtb3JlIHF1aWNrbHkgdGhhbiBoYXZpbmcgdG8NCj4gZXhlY3V0
ZSBhIHJlcG9ydCB6b25lcyBjb21tYW5kIG9uIHRoZSBkZXZpY2UuDQo+DQo+IGJsa2Rldl9nZXRf
em9uZV9pbmZvKCkgZmFsbHMgYmFjayB0byB1c2luZyBhIHJlZ3VsYXIgem9uZSByZXBvcnQgaWYg
dGhlDQo+IHRhcmdldCB6b25lIGlzIGZsYWdnZWQgYXMgbmVlZGluZyBhbiB1cGRhdGUgd2l0aCB0
aGUNCj4gQkxLX1pPTkVfV1BMVUdfTkVFRF9XUF9VUERBVEUgZmxhZywgb3IgaWYgdGhlIHRhcmdl
dCBkZXZpY2UgZG9lcyBub3QNCj4gdXNlIHpvbmUgd3JpdGUgcGx1Z3MgKGkuZS4gYSBkZXZpY2Ug
bWFwcGVyIGRldmljZSkuIEluIHRoaXMgY2FzZSwgdGhlDQo+IG5ldyBmdW5jdGlvbiBibGtkZXZf
cmVwb3J0X3pvbmVfZmFsbGJhY2soKSBpcyB1c2VkIGFuZCB0aGUgem9uZQ0KPiBjb25kaXRpb24g
aXMgcmVwb3J0ZWQgY29uc2lzdGFudGx5IHdpdGggdGhlIGNhaGNlZCByZXBvcnQsIHRoYXQgaXMs
IHRoZQ0KPiBCTEtfWk9ORV9DT05EX0FDVElWRSBjb25kaXRpb24gaXMgdXNlZCBpbiBwbGFjZSBv
ZiB0aGUgaW1wbGljaXQgb3BlbiwNCj4gZXhwbGljaXQgb3BlbiBhbmQgY2xvc2VkIGNvbmRpdGlv
bnMuIFRoaXMgaXMgYWNoaWV2ZWQgYnkgYWRkaW5nIHRoZQ0KPiAucmVwb3J0X2FjdGl2ZSBmaWVs
ZCB0byBzdHJ1Y3QgYmxrX3JlcG9ydF96b25lc19hcmdzIGFuZCBieSBoYXZpbmcNCj4gZGlza19y
ZXBvcnRfem9uZSgpIHNldHMgdGhlIGNvcnJlY3Qgem9uZSBjb25kaXRpb24gaWYgLnJlcG9ydF9h
Y3RpdmUgaXMNCj4gdHJ1ZS4NCj4NCj4gSW4gcHJlcGFyYXRpb24gZm9yIHVzaW5nIGJsa2Rldl9n
ZXRfem9uZV9pbmZvKCkgaW4gdXBjb21pbmcgZmlsZSBzeXN0ZW1zDQo+IGNoYW5nZXMsIGFsc28g
ZXhwb3J0IHRoaXMgZnVuY3Rpb24gYXMgYSBHUEwgc3ltYm9sLg0KPg0KPiBTaWduZWQtb2ZmLWJ5
OiBEYW1pZW4gTGUgTW9hbDxkbGVtb2FsQGtlcm5lbC5vcmc+DQo+IFJldmlld2VkLWJ5OiBDaHJp
c3RvcGggSGVsbHdpZzxoY2hAbHN0LmRlPg0KPiBSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNo
aXJuPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KDQoNCkxvb2tzIGdvb2QuDQoNClJldmll
d2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

