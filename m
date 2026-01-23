Return-Path: <linux-btrfs+bounces-20952-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GfGKzJCc2mWtwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20952-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 10:41:06 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A43E7388A
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 10:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E3893094BCC
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 09:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0761336F407;
	Fri, 23 Jan 2026 09:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hvPRolRM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JqvLtxOT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECC4374186
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Jan 2026 09:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769160882; cv=fail; b=nxc+ZU7VT6sYW4gGNHmiNhSQ7yTbnta0RQcwK0SBKUgifLP/saFFHqC10W70bBHxhlKwzk1PTewLs0IqIahISlAzecLvgnJSf8e2HsW94NAP66B/k5ZCOo4jbyrZEGEWNoagtsW3BT6RJP0FgyOTESLSGNVqkOgkYuXWINelf4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769160882; c=relaxed/simple;
	bh=HaPPCRKJIdlYHe8MAdTxqEnsXwX47FEWgF5C7ZK6Kqo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y4TD+1g3NbWMlyY2KCZwKayg5SS1h1bmlll8mnIinacl80n/O1MFy/fybSUrXjQT8Wvnh2izatM7cUBcoy20GmJ3GK6zU5P6IegAvR6OvMOdiPKKLYPoAU2gKAVpVU7ISRGOZ5gnSs0wucWhXp9lEJKQp1muAh/KLK65nxLMnt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hvPRolRM; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=JqvLtxOT; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769160878; x=1800696878;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HaPPCRKJIdlYHe8MAdTxqEnsXwX47FEWgF5C7ZK6Kqo=;
  b=hvPRolRMWNYEgdY9C9T5m+N7XJHp0JVUx2MAMdNneHoQ35iMCmQJMqUe
   55f+/aOgHLzXzEnqQRXRJQCVoGSaxvPohynXql6w6QALdozzSXCdwRcvT
   cLxFbOYEqtk5sjWOy7ztmqD56AFGUjQ908cxaMHvXtomgrVX/5RNtyrk9
   +84lQfkI7cRrtFhvgIaUicrGLBTVc1le2wzzEDe+KJADxHkgxI23u2Ol5
   5YvkWowImECGqTQNjsyXFNAl3ZwTZpc0VZ6znfGK2Zb6a5XW3BftxYm/+
   KGQIk6PWkoULJJTu9dVYBSiDI2sHb9O9o7gHHw0S0/ibwDjlrjbIradUi
   Q==;
X-CSE-ConnectionGUID: 5L7pYSsSSlyLfiQSDRj2dA==
X-CSE-MsgGUID: nHhXUkavQoqCv14uPUgobw==
X-IronPort-AV: E=Sophos;i="6.21,248,1763395200"; 
   d="scan'208";a="139079152"
Received: from mail-westus2azon11012033.outbound.protection.outlook.com (HELO MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.33])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2026 17:34:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJZ4Gf6EebhCo7DKHrmFg/cn5N6A7narANmPiTV18ahKKysQHR7OmAxTzxqkGwFEZts6z8DRccjeDKTl2mHgl9s9DYGCOXc2l/XWdI8tZz8bz8pI/IChJ+EyYouF+6aj6V/r4Ac3s/jo3FE9kgOpLLPhsl4WEDLIVe6635KlGcyr4zBEBtgu5i2Cq/1Ku1/iljwH419fvV4cPUKkAN7vNZ6Ss7sJ1sN1HT/88traD0yJaWyRCMVwsNrnjHAMZL3gpVPB8i4DqJ7ioz9HZqTMfeXQqnCg+Dmo3FAUBGr4xEVNLY2lRHxLL9YwGGhvRZWYB2PUggVdPx7RIeCWhKI6wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaPPCRKJIdlYHe8MAdTxqEnsXwX47FEWgF5C7ZK6Kqo=;
 b=YptgsRkulwXFFuWD3Q6FeHymy0T2y6eI/54SAVZHeKiGrfdeZhS4SIO+T0Q+fSo7uQwbMGyXAum09XdEBD3tvTG0mcLCS2ozlaqEWH3ieSK2ODzDEw0rSQoKF9z6kgVxqzZuxCxZEbC+99ZodDLeZgAWmEUKjPZyXccIODrRAcQuyv+nHMPRbPjhwjMp54PjIvFGWsCoNcoEOK/VPGnJBuJCiJ0V4zyqlP2MP6LlaIwi/lm/rphz3rTE09u62lyeeZ7Qda5dcH0KNmmrPlQRpQfVb+N/rMk7aTupEPju0ZyIIpV1OMx18AJibcIS8IG4egRaWT0opvNafvUGv3ShMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaPPCRKJIdlYHe8MAdTxqEnsXwX47FEWgF5C7ZK6Kqo=;
 b=JqvLtxOTRNhye072VrnomLIkGFpM4QmSb8da9ftYmhXbWQoefiK52o4+hjei93EBwGWMA8W57IdtFVNow1786LB1cwqC0ao+uxZumuZXRmxqF3WBB3Gdv3TwMApnEJXBYQGBS4hFg4LPZpPvTdNwE5CZt38zqdiUbBBjliigU+I=
Received: from SJ2PR04MB8987.namprd04.prod.outlook.com (2603:10b6:a03:557::20)
 by SA2PR04MB7612.namprd04.prod.outlook.com (2603:10b6:806:147::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.3; Fri, 23 Jan
 2026 09:34:33 +0000
Received: from SJ2PR04MB8987.namprd04.prod.outlook.com
 ([fe80::2209:bd98:89ca:9421]) by SJ2PR04MB8987.namprd04.prod.outlook.com
 ([fe80::2209:bd98:89ca:9421%4]) with mapi id 15.20.9564.001; Fri, 23 Jan 2026
 09:34:32 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Naohiro Aota
	<Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: fix loading of DUP block-groups with
 mismatching alloc_offsets
Thread-Topic: [PATCH] btrfs: zoned: fix loading of DUP block-groups with
 mismatching alloc_offsets
Thread-Index: AQHcjEBFaoFypvnOOkKLvorFiFrZPbVfdjKAgAAIQYA=
Date: Fri, 23 Jan 2026 09:34:32 +0000
Message-ID: <7ca9a905-f6d8-486b-8223-3a88a19ad6a7@wdc.com>
References: <20260123081404.473948-1-johannes.thumshirn@wdc.com>
 <CAL3q7H5+c6frv1ozconpz_sUBLtNyVTt8rfu92aVAF40=ccWQg@mail.gmail.com>
In-Reply-To:
 <CAL3q7H5+c6frv1ozconpz_sUBLtNyVTt8rfu92aVAF40=ccWQg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR04MB8987:EE_|SA2PR04MB7612:EE_
x-ms-office365-filtering-correlation-id: f09f80ed-9f3c-42b9-9784-08de5a629d82
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|19092799006|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VXZkUWV0L29IUWxKeldYTkY4MnpYelNrOGU3ODVrTjhpNXoxYVZVK1JuQ3p2?=
 =?utf-8?B?T0t1VXBscHR4UDA0QXFCTkVUcFFDaFE1RmFvWHp6bTlRVFVIVmJmRjF5bElv?=
 =?utf-8?B?V01VL2swWlJHYzZLL3RBRWtMNlhxdk5kOG4wM3ErRGJQdVNFQjdjVkpaUnkx?=
 =?utf-8?B?M0RJdEVVL2ticURCV0lCTHhXNTIzbCtGN3phdWNwNjRrbDZBa3VvQ0IxakQx?=
 =?utf-8?B?ZGRFWENoWGFjVDh5ZUtqNmxpcVpKMG9YOUtqVlhDRUtGdTlEUlU4eVJQNkxy?=
 =?utf-8?B?T0l1c1NZVm5qSDFGL0NGU1RVMXk3VEJCSDFKdGdsb1g5dVd0NWhxUHpKVDJ5?=
 =?utf-8?B?RXBRMnN6ZGxrUDZCMlRrV2NNaUxzczV6cThrVDV1cnlUK3ZDbXE3cCszcjF4?=
 =?utf-8?B?enJkVmM5dGdIeCtMNVlKcEZXUHlmUkZoSXBaTUQvcUpDZGlkQ0l6L1VqeDZH?=
 =?utf-8?B?eVlzZG4rVTBxVmJnT0Jmak9SQTRhanp6Vk9neE1YTythTlNvSWhkVUZNVUtz?=
 =?utf-8?B?TXJwWkplQW93WnUxdnVjYTVETHZORGEwZkk5VmJGUjRWemF4ZUtrNmNVWTJi?=
 =?utf-8?B?S3RZcThHRkVHaWMwRE5uRzBrdkFJNlZ3NXRoYkpreGZUeGp5dzkrVkhCVStp?=
 =?utf-8?B?NzFHQnJsbVpRSEhTMmpKZHpuaXlpYVFEVmFUeks2Z0krV1A5VUdhNzV0amRW?=
 =?utf-8?B?QnZwdUhROEZrdUJtQ3Q0V050alV2Mk5Rd1RGWk50YVQ0SXcySzV2WW02eUlx?=
 =?utf-8?B?bElvS3pRVkhScWdGS3U0NE82ZVZ1endaaVlJKzM0L0gyRTdCb2ZLK254cDBa?=
 =?utf-8?B?VFAvTlNDRmM5cHRjUHBxeEdnRVFuUkZiZEd4cFlac1dLb2JBOHVjU0haTm41?=
 =?utf-8?B?bHJsOHRkZ3VqSi9GdE54Szc3dGN5SjZxWXVHZ1JyK3N2bzMwRmRFbmk2YXdZ?=
 =?utf-8?B?ODJnZWV6c041U2hJUHdUTHYzQU13aG05c3NlVm5CajVLaWQycmVJS05TSnpq?=
 =?utf-8?B?d0RXWlVBMjAyekMzb3grWUUxNHViZ05oQ1pHZE5YMFpGdkVrdXlJdzRKa0p0?=
 =?utf-8?B?Nzh3ZmMzNnVCek50a3U4VTBOQTkwQmRQNmhFZ0V1QytkWkVyS1NscWQvS1Jq?=
 =?utf-8?B?NWp4TDc1RkVBWXpiclA2VEVrdDVER1h3c0pqVzJMYW5BcFBIYlZHSnA1UDVV?=
 =?utf-8?B?NHlzUkJCK1NtZXpNV0xpK0Y2SVFkS0w2ajRYSWtCYzFwNVVIVTZ2UlRUMjlu?=
 =?utf-8?B?Tmo2QnFJNDNOSGhuUGtRME5KWlRBNGFhQ0M3WHpBT2hLbDYrbVFkenp2cjdt?=
 =?utf-8?B?V0JZSCtHZHpUOWgyQTIzY3gzZjdhM0ZodllwWGFGaXdTbnZ3WnA1TmducTFP?=
 =?utf-8?B?RjVhWnF2djhmQmY4Rm1oNGJNRlY0RHhGRXVudVdpUFVxK0MvQmllTmJWYWtv?=
 =?utf-8?B?NXc5Ty9EUi96dkJlTmZtejl6aVV4QWk5em9BaXN3MFhoZGg2UVN4SG1xSkl2?=
 =?utf-8?B?U2JGU29aRUd2MlVPZnYwUDF6MDQySnVIZFJzSDhaSGZaMENNWGYvRlRYRDJG?=
 =?utf-8?B?TFlIQ1VLTVAwNXJSUlBnN3MvcUFuUERNNU9PeHAyM3lLVzlMVFhuVHYwblBP?=
 =?utf-8?B?aUhqbW16ZytFUUd3ZGlQYTlXbXRTVEM3cU1POXFmSHhtMm95K1IvY3Zqallj?=
 =?utf-8?B?bXY5OTg4VzR1Uk1WSlBHU2tPa1pnb1k4ODRXL2l5TjJyZVlEa0ZMbW5EdkdP?=
 =?utf-8?B?VE1pS1NqaVFCdjRzemtMWmRGNnZtcm93cGw4VjQvb1l5TUhqRDgwbUpNWk9Y?=
 =?utf-8?B?YS9vaDUwU3Q5QjJwbG40b3Y0K0xmOGlNa3dFVldPbmQ5Z3RZd2tTcjEwcEQ2?=
 =?utf-8?B?ZXl3OXE3a0RZb2FRRnlIaWNINmxBVnlhaHNWVkRDc0l5azhBdFV4VDFaOGJ0?=
 =?utf-8?B?TWcvWHJtbFl1Q1g4aGVNblNFcmdZL3J3Q0t3NWo0MkpuQmQwZFZ2L0dyUCtj?=
 =?utf-8?B?eVNvdUdPSUlHa3NKbHNKSXhKbFZRU1ErUG9acU1EYmFVN0ZZQyt2NEc1Zldr?=
 =?utf-8?B?UHUwNVpTRUlBQy8wcHF2aitONEpVUjdQYUJhWS9FZlRQeFVwd1RtQVJGaERO?=
 =?utf-8?B?SmpRQW5VOVpPaWlUQjBiclN4RVZLdWV0NldFZXVjR2duVk54UHVza2tzV1kr?=
 =?utf-8?Q?sdnt3dqqemYkUxOeEyBsHXk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR04MB8987.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VG11Y3M2cXNCV09IQ2JrVzhwWGJLWEF6MzdHWm1PMW5iM2dGZ0kxMmhWR2tE?=
 =?utf-8?B?NGRTYXZBZnR6UU4vNWVtWlZLT2h6V3VZM2taNnNldGR1enc3RW1yOSthV1hY?=
 =?utf-8?B?a0FseEttOEJZUzFvZ2xNTlArSXBDTmxvL29YcXoxSythaHFOSmd0bkdOYmw3?=
 =?utf-8?B?OVBlTk83cFJDZ2ZFL242a1FSWmhWcHZIWTNqemFOYlhobms4SGdEMW5HTmlM?=
 =?utf-8?B?ZDIzQXNJU3pOQVBtRXB2Mzl6NXovaXZZT1ZUUHpvdDF0ZEE1WWtERWNhU1FE?=
 =?utf-8?B?ZTBmWTVHUnFiZG0vLzBTa09KZEg5U0VUdzFTQkQ5UmVncENqL1U5Q1ZDQzZS?=
 =?utf-8?B?cWFNOFJDTHFzUmh3L2ZCWVhTUm1nL3pXRGFjWG4xUm8yNFdPcEpkTXZoK0x0?=
 =?utf-8?B?Y3B5b1VjYWJGd2pzZzExNVBiUVpIaE4vZ0FnZ21GeGdTeGFIeitHRGcwTEZE?=
 =?utf-8?B?MlQxNlNsREN0TUg4MWM3VDJZaE5EdndIcENhZGsvcUtZV21vM0NCUGNSdnNM?=
 =?utf-8?B?TlQ5T2MvdFdiY0pBeG5KMGtHdW04T3dkK3IrN01uK2Y1SWFIZWJJbUE4TTNO?=
 =?utf-8?B?dnZsL1ZLSEgvRllBaGovenhpUU9WUjlleVllVVhKN0ZVdHBjM0ZxcThvd04w?=
 =?utf-8?B?bjl0NEdNbEJxYS9keU9sMFZZcmZiTTMzVmd0NDlxWDd2WWJhd0lBRFdKekZy?=
 =?utf-8?B?M2dpWVgwVUJHRzI4Z0xlcGg1RXg0SkJtc3d3TzAxcHYxbzB2dU1aZUFhajNh?=
 =?utf-8?B?MERDWDhjWnVPWlV6bE41dW1LM1YwTEhFTHoyZ2VKOHpDQ285SjdJQ2R6SWpD?=
 =?utf-8?B?c0hlVndMSzZ4VDZ0REptdUVCZ09YY2hXaWtQcStrL1ZIb2tNOU9LWHBCWDQ4?=
 =?utf-8?B?NVdHeWNaV1dzNWw5ZlJyUFQ0Ums2cjZmeWlLZ21JbVc1ZFM2NStRcnkwbG1k?=
 =?utf-8?B?ZmllVk80N2x3K1AyeURpV3lwTGM0TWpwbG1zMkFNb3hnNnYvU3VQTm14d3dW?=
 =?utf-8?B?S1EveFdCVWozdldiQU1GTkV5ZGMwSkRXWXJOc3pucU04K1o1a0ZBTGRZUHJx?=
 =?utf-8?B?RmI4eXdBRmdOMjA1cXBGVjdjekROaVN0QmxGb0czdjJha3RJdDZ0VDR4dGYr?=
 =?utf-8?B?aHB2NVB5R3NpVnUvOVFFblhIYmVoTEpGeEJNVjMzYkdGczg4bmZvSzA4WU1E?=
 =?utf-8?B?ZXVad2pVeUVmNkgyN01UR0hzaEluaDhGcnhUdmZBYmYzL3BmalJuMEdrb0pt?=
 =?utf-8?B?RkF2Q0ZsbVQ4eHM4VHRSMmNKa0dPODkrdCtLUzZyMUlsNUFjbUdDTE42bXVO?=
 =?utf-8?B?dUtoTDlrTVg4OEovRTFzYWlkU1VoZ3UvS3dYMi92WHVweS84TEo0ZXNEcnBP?=
 =?utf-8?B?aU1ZWTNvd2V2YVhKSDBBL2xuU0poOHRTVzd4VlR5TWY3SnM2ZE9ORHpUblBJ?=
 =?utf-8?B?OGxVSWFIR1AyWkNqQ0c2SjFTc245eEV1MG5TVnNWN2FUTUQ1aTFSVVc3bDJE?=
 =?utf-8?B?UXJtWGhkRVRkVGRvRkc1c1dmdzBDV1o2QUVsZHBtNmRXZkZrRVpyWGI5RnFn?=
 =?utf-8?B?dE9yOUhYY3BmTkVSc3hlaVM1cEw1b0xjRHNqMTZ5a0krYTArZ25kTGZrK0Vi?=
 =?utf-8?B?ci9Tblh0MDdSVVNMQW14U2pDRERFRFpSU0laSFl5aDVOU1EyRUZRQjhpMGlt?=
 =?utf-8?B?RW5BaWwxdU1IVzRMMjlNY0sycmppSTB2b2JmMlFyT1FNR0s0eEk1bDNrNFpt?=
 =?utf-8?B?dytxWkRhbGhUZXZpeXZrUXVSdDJMaWVIS0pCUnczamxXQi9VYTFOSkF2dTU2?=
 =?utf-8?B?YUtUSTc2djJoQVoxQ0l2MXVuaXEydlVua1JubE5jblAvTVB1MGR2SUZEYS9s?=
 =?utf-8?B?RWh6d0VDQzNjc0hIVldVMjBmR0ZEWkx2Nm1zMnNpZ2pHYkYwZHRoNEVDWTBW?=
 =?utf-8?B?NmRRSk13M0F4MkgzcHlpQ05TN0pRcXNjS2NKei8yZHhZOW8vVDU4c3EvbE03?=
 =?utf-8?B?QXlCOU5OV1orZUNEaFlnUGRDNTRLR0laQzh6YW1ZZU5vaHpRWFFSbjdTdVRh?=
 =?utf-8?B?NVdXR0tGVGg2NC9pNXlHamxmN3VXYVpJN2RLeStZWk44a0NybVcwV3JveDBs?=
 =?utf-8?B?MzdJS2dpN0RKT1dYc2pyWEFlZzNGUUtVUUszcDBVTVhSMWJUdU1uNTBQa1NI?=
 =?utf-8?B?UkhJSE1BaU5KWi8zaGZsTFZ1c3pzSEJWMEtobmNFRm4vbzRIa1lXNjFCYXVI?=
 =?utf-8?B?Z0V6VFZUbDZZaGd2d3lTRnI1TjVtUnpkY1l1UXJ0bUFPQ1ZqczNRRzNHdEJX?=
 =?utf-8?B?Tm5mMmlTMWp6K09YeXBXWk5tYW9jSkdpaDhxcXV5STBlRnlxQnYxMWJ1ak50?=
 =?utf-8?Q?kph6nLupybTTLtFg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B572E02D5510184FB6E1F37326DBFBCC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i+MOiOhs+lmrvW+FyR7gwrjaF1S9Vmhw9muD84FLvOPAR4XYG29773av6AZmpWsLkmtZU5HBNf8jSzBgDtbtcsIGCdqnu3E+hrxRNwHNtrtuXGUe9XZD0gAZebxFR+C71PIcFtRWH7QYNtkhAOaXa1T43z0qFxXLVdi6MzHugcc+Khnb/g4g1BbA5KgiVqW8pvXjeO15h7Y9KGcvw7REU1et8TlgWqz5+BQV34CIEtjO9sipi0mTaEezkMjsUrhACvEAPg/k2EJBAylkGSid8bqTJkuwVtCOSUb7to1jOd/8NAo69KnNgHSmMEvrAb6OnceD9C121hP3vJGx8WAvEQimGGfWnOiPsgWSNWGTGAXrNtGw7tLtngHH+3qymCdlwAOw5DBJRMOruGuDKa2ZRwkpoy01lFUVbxQJbyqqhNAU8kguni2YcXsS3KNHsmV8JzjFA+mmvOYzHpAre0Drsq6AUPpNSiHYovr2pPC8MuBqt/KZLQdYyhdplPXyCCioLJWO9qXRSW21TZdSuEIBpH1ZJqxcLT0QrIPdPzrWfsGIncwx9QF40PSvtNwIQaSXgq6LXlCyuPqgWH4ooAE46ByEEdF8Pq1+/LA8gwP0iQ80k7ZHjELqsRH2srDlenWU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR04MB8987.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f09f80ed-9f3c-42b9-9784-08de5a629d82
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 09:34:32.8729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f8wX3ujhbwRPUW71aedBz+aHLhrOj8Gu2YfkQoP2CI22mXjuPsC5jApgo/fXTYOCFfupLKZRAcvubKUwZHSTrfgSjRo7oUqIQ/dAZh8lRxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7612
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[wdc.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20952-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_MIXED(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_REJECT(0.00)[wdc.com:s=dkim.wdc.com];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[wdc.com:-,sharedspace.onmicrosoft.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sharedspace.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 2A43E7388A
X-Rspamd-Action: no action

T24gMS8yMy8yNiAxMDowNSBBTSwgRmlsaXBlIE1hbmFuYSB3cm90ZToNCj4gT24gRnJpLCBKYW4g
MjMsIDIwMjYgYXQgODoxOOKAr0FNIEpvaGFubmVzIFRodW1zaGlybg0KPiA8am9oYW5uZXMudGh1
bXNoaXJuQHdkYy5jb20+IHdyb3RlOg0KPj4gV2hlbiBsb2FkaW5nIERVUCBibG9jay1ncm91cHMg
d2hlcmUgb25lIG9mIHRoZSBiYWNraW5nIHpvbmVzIGlzIG9uIGENCj4+IGNvbnZlbnRpb25hbCB6
b25lIGFuZCBvbmUgaXMgb24gYSBzZXF1ZW50aWFsIHpvbmUsDQo+PiBidHJmc19sb2FkX2Jsb2Nr
X2dyb3VwX2R1cCgpIHJldHVybnMgd2l0aCAtRUlPIGFzIHRoZSBhbGxvY2F0aW9uIG9mZnNldHMN
Cj4+IG9mIGJvdGggYmxvY2stZ3JvdXBzIGRpZmZlci4NCj4+DQo+PiBJbiBjYXNlIG9ubHkgb25l
IHpvbmUgaXMgY29udmVudGlvbmFsIGFuZCB0aGUgb3RoZXIgem9uZSBpcyBzZXF1ZW50aWFsLA0K
Pj4gc2V0IHRoZSBhbGxvY19vZmZzZXQgdG8gdGhlIHdyaXRlIHBvaW50ZXIgbG9jYXRpb24gb2Yg
dGhlIHNlcXVlbnRpYWwNCj4+IHpvbmUuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSm9oYW5uZXMg
VGh1bXNoaXJuPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KPiBTaG91bGRuJ3QgdGhlcmUg
YmUgYSBGaXhlcyB0YWcgaGVyZT8NCg0KSW5kZWVkLCB0aGF0IHdvdWxkIHRoZW4gYmU6DQoNCjI2
NWY3MjM3ZGQyNSAoImJ0cmZzOiB6b25lZDogYWxsb3cgRFVQIG9uIG1ldGEtZGF0YSBibG9jayBn
cm91cHMiKQ0KDQpJJ2xsIGFkZCBpdCB3aGVuIGFwcGx5aW5nIHRoZSBwYXRjaCBvciBzZW5kaW5n
IGEgdjIgaWYgbmVlZGVkLg0KDQo=

