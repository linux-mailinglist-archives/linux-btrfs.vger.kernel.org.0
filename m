Return-Path: <linux-btrfs+bounces-14632-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE60AD7DF2
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 23:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BADD3B3425
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 21:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1642D8786;
	Thu, 12 Jun 2025 21:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ezveaXLQ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LETnr0Wy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111F9155322
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Jun 2025 21:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749765586; cv=fail; b=BWRDY6Wyv878ifzj4OH/3xS/ofWdek0bNltJq+UpwexPgRcYAObIwaDsozs3SLhgbo0RkvSsfhZfc1IpBDRnBbCyQE4WLtibQdclbU6o4cTfLOVoX7E9hgm7XZl03u8oU26ZdAA2/LkrQLIXyUZ/dNoRjxwiHJ+EEFcLUWqEvII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749765586; c=relaxed/simple;
	bh=BjJIru9kquuRM3zptNYALOm4dK0sSpFpj9ZJT82W/ag=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oKoJNyDFpg4CyimmkcvkMCbXmAZWhVhEfVjYbiQ0WR1CiUPHWWCD3zhBiZqQhWuDpuqa33BiV4iL0Rc8VbLgo47SgalsF5ObeqG4kp24SYTkl85yaSq7vqbJr4ohX7MPddPXNSGpJ+gmC6dawbsVXcXQ2qhxFpe8DuDkNa39hko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ezveaXLQ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=LETnr0Wy; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1749765584; x=1781301584;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BjJIru9kquuRM3zptNYALOm4dK0sSpFpj9ZJT82W/ag=;
  b=ezveaXLQmOC8t0dhxEsmS4XmzjqxbncqbMq/PVh/LdV/9F5963YQrXDY
   QmYygCnQAD+ytkcvZhK3vMedhb6G1c3vYjSGXrRWflDaCmNHW75Z4XBKf
   wzu1eg0l5cwCi6WuBqzTAuWV5ZeCZJ8eeINEh7x4Osr6aeNucRF88Zv0m
   m8M7qXuTYcECR6I3tJMNrIE6ukhFj3jjMF+N0mRBCM/hWa4+jU8vjW3JC
   d95k3iv2XWJasC2XSHlxwB3X3+P1TQWx7EshLAxZKDHuFubIJUzD81mQS
   ATR9nJqeSRXcA9PSvNEMUTPIrE+2JzaZdN3hfOrFLiXGCYFI6DufP4km6
   g==;
X-CSE-ConnectionGUID: F05lG0vERgKR+OLe9LyqNA==
X-CSE-MsgGUID: Q3YO1nCXQOuK7E9QRjVqRw==
X-IronPort-AV: E=Sophos;i="6.16,231,1744041600"; 
   d="scan'208";a="83941686"
Received: from mail-dm6nam10on2047.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([40.107.93.47])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2025 05:59:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KgwsZgVGqgddA87tU6B0D2XHJI0NIzMiKpCs6MjnaKL4uwrryZKCnYH3F9UT1hCL8AQ/IL6n0nwy6pxBLACwt8BUZdEP7R9RQ9xeC/51jzpq5kghzUXusphzlUSfbBToAZdZuAej+PMkhSJRPbJO0j8rSIaCQO3pyS+o9L7rGh+B0+Uo6PcxoxcPy4MdsHvmuW9ZD4JCKbsn7zMTp7G0yo614hGctB9Qj/tL4PQjHPk/KKm6k3tS6KtSUDogZyiWoKznB7OWrGeKMqk10mNXLgTW63wENyveMv5LPtIShjroBbYqayyunZMsWRxtkwpXPJ64bi78XPdEaxfjcUxEdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjJIru9kquuRM3zptNYALOm4dK0sSpFpj9ZJT82W/ag=;
 b=hH4tU1F8B5Z27xWCCaOTKlpZGNEHwjFKfj17m1nCYp3HqYuGfCYWF9KQt6a2S2pEndkJZ0IeBATU0SyHZjmGhS68Y1zvTcAz4ASRkFj5bAfys7EZZwYWy6WfNYn+7nqEbj19/KmLVcI6Pu/YwfWV25hBLjGB2io0otZDm0aZ7y3WEHYI6OdiirljZvQQGxUArFq6m7MQt8uPwN0/SN0sn0SrdUlrarabKBi01HJM39n7tzDzTOGQR5H2XMAchk/QqQLV0bb+VvkuaAQNYTmruSv5v+j4biuRiB/6WVAtH42JsLcYXQvWb0AsRJ3UonfVE/ZeHlPjnxkj4WrJo3p8og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjJIru9kquuRM3zptNYALOm4dK0sSpFpj9ZJT82W/ag=;
 b=LETnr0WyOa7w00/Rny9FKF2NRBJU7JQ/8H+7ZhijQiJO8SfGVncNZNyC9TBJZ3uLD1HRTKHEXabw250Zk345efGJP5WxGE7MUK6qNkb2L8GYEPRn2dELUaLYlQi6l1ssisechq/KqvL0vtqYky15LH0MqQozVnc8EdCljL1LIkw=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB7423.namprd04.prod.outlook.com (2603:10b6:a03:29c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Thu, 12 Jun
 2025 21:59:36 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%5]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 21:59:36 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <jth@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: Naohiro Aota <Naohiro.Aota@wdc.com>, Damien Le Moal <dlemoal@kernel.org>,
	David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>, Johannes
 Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH v3] btrfs: zoned: fix alloc_offset calculation for partly
 conventional block groups
Thread-Topic: [PATCH v3] btrfs: zoned: fix alloc_offset calculation for partly
 conventional block groups
Thread-Index: AQHb1rMgi1rvAZATdEKpNBCWNunJq7QAHSkA
Date: Thu, 12 Jun 2025 21:59:35 +0000
Message-ID: <DAKW4NWC8B4G.1VPELYQWGAJWW@wdc.com>
References: <20250606071741.409240-1-jth@kernel.org>
In-Reply-To: <20250606071741.409240-1-jth@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SJ0PR04MB7423:EE_
x-ms-office365-filtering-correlation-id: 1e44b410-f5ad-4e97-4157-08dda9fc6bab
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZjV2bU9CMW4xU09WUVQzZlptNi8zckZ0U0ZVREhzWGJWTXcxcDVLemNPbmx1?=
 =?utf-8?B?S3ZMRWlFbmRnbzcvN0dUMy9kNEFxNW9ENkxqdzNQNG4xeGc1OTdEYVpMTmF1?=
 =?utf-8?B?Vmp5Q3AyVW9xdzd2cWxoTlF1b0dJc3U3MEpwaVRsZ1VkSFNaZnVrTVo4Z2pQ?=
 =?utf-8?B?WjRYMXcvQ2NYZ2NlcmRDYTZTQXpGWGRObk05bnFEMVltOUZtaVVXQ3ZhQ0dH?=
 =?utf-8?B?WlVkSytsZUYvMmEwQ0N1UFJhZkk0NUxTZCsrc0ErSllGZXlkZVNaekZNamNE?=
 =?utf-8?B?Z0s1TlRacGJSRGRsdVVQOFNUUzdaUThpcFRGUS9DV1plVUtzdGVsVnFyNS9V?=
 =?utf-8?B?RUwrYzdPUUZRSkFHcUhJVk9LYmtaRFMwekk5NHFUNldNTisyVEE2YWFVOGMx?=
 =?utf-8?B?T0xNUFo1cUtreXVwNndJL1VqYk96ekQ2S0NsTE14cEtGRGdKYnFuVkF3QWNl?=
 =?utf-8?B?U2V4bU1ZaDV6d3l3NEpYRS9Rc3hlS1BRc21OY3crdEVUdy9XZGJKWVd2ZGVM?=
 =?utf-8?B?OTI4dlJWNU8zc0FRUjI2T0x5ajkyaW1udFdBYVNJTmdRRjV6dUFZOTlETjJ6?=
 =?utf-8?B?cUdkekE2Z2EzTFF5MVpUN1pENkRvWDdxdVd6QW1rSGJjdVlRR0lPSFd1cTho?=
 =?utf-8?B?R3F3NGszTlVrMk1NcVR4RFJNMHl0Vm1uUEJWSU5ZdUl5VEpiclFIby9TWU1j?=
 =?utf-8?B?UkI2S1VaNXpOaGZrdndDZnM4NHQ1eEM1eVVmd0FYc2RTVnhtMVBTQ2ZxWXJh?=
 =?utf-8?B?dnRoUmxnREdGNjU4czR4aGJmUjJ0TTNLbjZ1UXZOZEYzZUNZbEhFRERYMnZE?=
 =?utf-8?B?Z0lNUXBROXc3MW8zU1VsVGs2dlFaTFMwTis3SjV5b2RCMEJCeHhLWEtaa0wx?=
 =?utf-8?B?b2l4a3BlNklsd0FqQU5RSDRvZmR2Q0VDRVB6YXErUXhTTkxaTzhCck45ZnNU?=
 =?utf-8?B?Y0dHd0tNY2J3YTRINXcreHJ2MGF6T011TEEvdmhLWUZhUzF0TFdVVzlYbXFZ?=
 =?utf-8?B?MHpHTThLZTJLanBqWGsvNitiaUNuNGY1ODVpSEMwZVpjVFhsUjAwVG4vaXZK?=
 =?utf-8?B?eGs3WXpnNGJZd21ZSFNUaVk5alQ5THY5YURkTmx6czgvTXdRODBQTkd1cGdW?=
 =?utf-8?B?cDdsOWN0a3k5NnVSSTF5Szk2RGs2NzhGWENQVDAxa3RLK012SVdXM2FtbUU2?=
 =?utf-8?B?VkFRaC9PMzRuVUZxNjlad2Jub3BXMnJxY3BYNnAvS3B1OTBOSm1scDM2NXFS?=
 =?utf-8?B?LzhVaFpETWhWOFRCMWMwSEZYQlIySHBGL0paS1VLZm5UOXF2TnhweXFhT3px?=
 =?utf-8?B?cHUrY1Z5WTVVWXZlZDhEYTVPdzRiQWJVVTh3U3NJQ3VkR1NXSERCZDRJSW42?=
 =?utf-8?B?NUU4Z1VNb0grQmE5OEVielE1dWNhRHNLYzhQbUxoWG8zMGp2WkR5ODRjSjNJ?=
 =?utf-8?B?b3ozZ0haU2ptNmhwQVViaXpMMnhncmtEKzk1L2pRNXdmeG9kWFc0bFJYRStC?=
 =?utf-8?B?RlNOY3dTUHozYWU0N3l6TUZDOGNpV0dXaXowSFV5SUw1cDB0elhxSUpvUjBl?=
 =?utf-8?B?ZTlYVURBZnNabGhUSnhPRjBhU2JIaFRyMXlQV01meTJHNDVmZmtBM2JjL3FZ?=
 =?utf-8?B?eERZOUt6REVQTFNONC9WT2lYUEh6MERId1V6SDk5U0NFcXJ4RnNrQjJaT3o2?=
 =?utf-8?B?NXlPVWd6NFNYNWtBMXlMZlh6SnlldnlSN201eDVudW1GQy9ta3lML1NPY2E4?=
 =?utf-8?B?d1c0ajByOEZIdFpGclhlNGduNWFDQS84eHRiUWdIbm4vRVh4V0lSaVFqbUh0?=
 =?utf-8?B?VTYyVTlPbkk3VEM5bHlCbGd0R1ltcFk0SW1XSk1TMXc4aXNOWFpLL21HbXRw?=
 =?utf-8?B?NmdSbjNwdFFSSmxJZjhaWFJCMXJnaGtHL2dpOEIxZ3BtWWd5ajhCd3R2M2R0?=
 =?utf-8?B?OVpLZnc4aElDRHkxc3dqWWRZVXFOaTVTQ1VoUk85WEpxMkljdXc5eGRzZkR1?=
 =?utf-8?Q?hdFkc01wz/3RspXTKf3qwthyKoIplg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aHRjbHcwbGVlc2h1TWxCYTJXbDhmb0FpY2Q5UytmSk5qVUVvT3pCRkQrdFVK?=
 =?utf-8?B?NU4ramFWdzgyaGJxMWtTa2tzeXNHRXhFZTF2TkR3eUFuOGNmTFV3UG5EYm00?=
 =?utf-8?B?Y2diNlo0bUFYVkIxTVoyVXo2TllmbWdhUjZKSE5pb3g1QTB6bUYxMGxKSmk1?=
 =?utf-8?B?bGYzQjVpM0dVUDJPVm11eEhTRjcvZFA3NFZvTzV0N1luL3pQVmp5R3Q4QzZY?=
 =?utf-8?B?T09HUENIdzJ2K1gzWkp5TUlCZzFPNHg1NXpyL2R0QzduNnhsejErNDkvQTQ4?=
 =?utf-8?B?cTl1bGwvTE9MREVqd3NVWkJVTkVGMHBWaXE1a3VWQ1hYUEJCdWl0cUI0T25r?=
 =?utf-8?B?blJmVEdGcng1Z1VlWFh3cmliMFpINmxGcllkKzh3L2tQOU9TaTM4WUpiRE01?=
 =?utf-8?B?VElseU5QblY2V3M2SGJRbVczMklMaHpFcDNURStrdUpxWkhjU2dTc1hFT3Vq?=
 =?utf-8?B?TmRrc0lLZWs3TnREamloUFdMWTV4b3liaTJyS0txR1lwZHRydnlMM3dZOFM2?=
 =?utf-8?B?aWg2Vld3WC94WlVYRWdubEF2VEdwckxPZG40MXRNOEY4OWVHQ05vLzY5azRa?=
 =?utf-8?B?a1l5c2ZNSHhhUGErQVFGeW5NTHZ1cXN5REE3eGt0bEJxSjBIaS9pVzlwbUFW?=
 =?utf-8?B?Z0NNSDY4VzZWaFhhT2RLQzJtTmIvbndQUWZyNU95NWtHa0ZtR1VVR2Z6L25L?=
 =?utf-8?B?YXcvNlg4bmZnM3lKeHA4YTNrZjJVNm4yalROSE9yYUtmSm5WUmxSNS9rUnpL?=
 =?utf-8?B?eFdqb1FmcDZJQmFQUU9WZjh6UFNZTUxKcEdWd25WVHZpK05OQy9VVDZic2Ir?=
 =?utf-8?B?bTJ3NnVDUFNjQTdCWmhZYXN2a3R4enFKREhHdjVpNlB3YmpwQkVpcEsxdWly?=
 =?utf-8?B?Vm1rWXdkTm44Q244OFJzTWYrc01aM3cxRms0UjdQUkwxRlNsWGU0MTZva1Jq?=
 =?utf-8?B?VThwRUJ6bHJ4V0RydERVNm9UNm1QQnlFZjRSK2s2eVN5S2dCRmJjVzQvM2Fq?=
 =?utf-8?B?ZXhuNS9ma25EL1gwSmFwcEFOMmFkbXZTYTNabFJWOUUyZFFDYVQvWlFzZENH?=
 =?utf-8?B?N3FENG5nemhhQ3JobFY4SGtsZDY2dGU5RWdEb0hBc0FrVmo1T1AzeWFQRThm?=
 =?utf-8?B?cHlJNUdrZTZHSjgvUUpzWlErSHFRU3NtWUl0UmcreUkxc0NvbXY0cWNCM2F3?=
 =?utf-8?B?T2VkS1kxUWRjV1NsWXE0QTc0UGxhZmZjVGRaWFIxZTlSdDJtclRFTUxTUEhQ?=
 =?utf-8?B?clA1OTlvaFBKVVhwaU04T2tHYjRtU0NTMEZZR0FReTUyYi9PMGxNZ1VFNkUy?=
 =?utf-8?B?MG0xRzBLMkEvdW15RFMwZ3A0Uks5REs1cUZqSXVJQWNGUEFPL00wSWFBN3hD?=
 =?utf-8?B?aDFhd0ltcHRqSmt6Q2UvMDlQYk1NVC9RK2lXRy9BTWhvVFdmU2p0K1p0RGlF?=
 =?utf-8?B?MjJYd0NrbjNiWFFMRmR4WllnWjk5S1RSMmc0dDcveWEzVmJ6OEczWGVZQnZ1?=
 =?utf-8?B?M0hXVnVEV25UYWlEUGl5OEU5OVp3RGxwY1BOZlRKTmxpVENpRGxxczdUVG1S?=
 =?utf-8?B?WHNvYTVCNXhFZU9aU2JIb0dEY0ZNdkpHOUM5QXNaK3ZFbE00cUJaaHkwNHVG?=
 =?utf-8?B?TXZ6OWNTeFBXajA1b25rQkZhOEphbUEyakhHckc1NlJwcnl5S1RpRVk5aFhP?=
 =?utf-8?B?YVVqeTlZcFY0L0Mxa3JjaEljbDVvYkNOQ2FkNlM3cDlnN0RkMmNMN3A4ck5p?=
 =?utf-8?B?OFhkM01zNHVibXYvQnNyYU9DeUJKcjFBRmNnam1QNjNNL1dDU0g2M0x0cXV1?=
 =?utf-8?B?Vk1XYWgxenZhaTduandDMmRKZG1SQkIyRTl3VDNLd2t6RFVhMTFnSjBkR3NV?=
 =?utf-8?B?aDlhL25PbWU3NFlQckRTTCthMU94bGFXa3hic3QwTkpGRDZ4dFdCeFZZbkUz?=
 =?utf-8?B?NVlmbXBxRnJWU2l4RWhwem9Qb2ZjY1pwa21wbXVMVlhTcWZ0VDJJMWNCSVdG?=
 =?utf-8?B?YXVqblBpQ3ZlcldXQk9PNytzQjdvUWpCejBZampFcTFUSVp4TzdOTWxDYktt?=
 =?utf-8?B?NzZWNUhtNWVpaWNnTTlXQmFZdWFqdlNPRFZOWWpmQmNUNmpMTUNFcVhaNlZa?=
 =?utf-8?B?eU81N2IvVmw0Vk9OOFdGMi95NzNjU000bVY3Z24xUStBM3hCTnJTYzN4VWV3?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F947E1D5B7C0C4439876EBB8EC013227@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JO4mRcSEug6pNmJiatPUBPDu/C5KT4QxCDhkWB1i/I4zn9LA4+h8AXopCx2NqSbio0tRf+7VHTcGH0MkUf3HhEhtKqHU08zN+ilB20Rh8dSEhPsGUPFmogxChRhXW7YTissh6GJQfyQx6uJQaLuXk6C9lYcXNsJgTrCpBOKne4xZN4ejBmoG326fa0BWhQIgoI7eeJGGibUp8XoXTnecJXAyy+dN9VFZR3Mu/aZqBS28u36WbPx7SXN7/0xHt5VdS87Extwqr7GOAZyUJe4WRgqG6yRFBsgwNJljQe2zX/J8ZEhRJrxsOvwXN7qNA1NDFgQe6h8DmsydWEcdVsjmPs6/Qx9nzJnZMxQSz2g68PFxFRxAZRnArdf52bPfh+WFCrrmcMvsktBu96Z/Li9y/xJwv2mGRbDexvrXieVBJPkmYgsxXf6zFC1qOMVmkbR8pb4251OHMHLrI0VuL7py5PUIMzDTsYs33fnsWtGYK/c+21K+j9zJTP0v4OY7p6JU5tAV5PUDr9+b9mZlHzSUX5IiuhimOxfinDHLGdAPWbkoPYae6gfgVU8xGaF1MGDRvbraRy9HUMtwJ6HlZTHsQqSoAL7AyXN99rFkjV24ZwPBDEjZkCQHq6RdI9m4sz1z
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e44b410-f5ad-4e97-4157-08dda9fc6bab
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 21:59:35.9323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7TTBWUlP19TDZG0Q8xcXdW3iPuUvA6sArT5IiEz9w53yQJHv+gL3rR2Q+2QFPFaGmW5v7ERVPP20+QLyg86BWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7423

T24gRnJpIEp1biA2LCAyMDI1IGF0IDQ6MTcgUE0gSlNULCBKb2hhbm5lcyBUaHVtc2hpcm4gd3Jv
dGU6DQo+IEZyb206IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo+DQo+IFdoZW4gb25lIG9mIHR3byB6b25lcyBjb21wb3NpbmcgYSBEVVAgYmxvY2sgZ3Jv
dXAgaXMgYSBjb252ZW50aW9uYWwgem9uZSwNCj4gd2UgaGF2ZSB0aGUgem9uZV9pbmZvW2ldLT5h
bGxvY19vZmZzZXQgPSBXUF9DT05WRU5USU9OQUwuIFRoYXQgd2lsbCwgb2YNCj4gY291cnNlLCBu
b3QgbWF0Y2ggdGhlIHdyaXRlIHBvaW50ZXIgb2YgdGhlIG90aGVyIHpvbmUsIGFuZCBmYWlscyB0
aGF0DQo+IGJsb2NrIGdyb3VwLg0KPg0KPiBUaGlzIGNvbW1pdCBzb2x2ZXMgdGhhdCBpc3N1ZSBi
eSBwcm9wZXJseSByZWNvdmVyaW5nIHRoZSBlbXVsYXRlZCB3cml0ZQ0KPiBwb2ludGVyIGZyb20g
dGhlIGxhc3QgYWxsb2NhdGVkIGV4dGVudC4gVGhlIG9mZnNldCBmb3IgdGhlIFNJTkdMRSwgRFVQ
LA0KPiBhbmQgUkFJRDEgYXJlIHN0cmFpZ2h0LWZvcndhcmQ6IGl0IGlzIHNhbWUgYXMgdGhlIGVu
ZCBvZiBsYXN0IGFsbG9jYXRlZA0KPiBleHRlbnQuIFRoZSBSQUlEMCBhbmQgUkFJRDEwIGFyZSBh
IGJpdCB0cmlja3kgdGhhdCB3ZSBuZWVkIHRvIGRvIHRoZSBtYXRoDQo+IG9mIHN0cmlwaW5nLg0K
Pg0KPiBUaGlzIGlzIHRoZSBrZXJuZWwgZXF1aXZhbGVudCBvZiBOYW9oaXJvJ3MgdXNlci1zcGFj
ZSBjb21taXQ6DQo+IDFlODVhYTk2ZTEwNyAoImJ0cmZzLXByb2dzOiB6b25lZDogZml4IGFsbG9j
X29mZnNldCBjYWxjdWxhdGlvbiBmb3IgcGFydGx5IGNvbnZlbnRpb25hbCBibG9jayBncm91cHMi
KQ0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1z
aGlybkB3ZGMuY29tPg0KDQpSZXZpZXdlZC1ieTogTmFvaGlybyBBb3RhIDxuYW9oaXJvLmFvdGFA
d2RjLmNvbT4NCg0KVGhhbmtzLA==

