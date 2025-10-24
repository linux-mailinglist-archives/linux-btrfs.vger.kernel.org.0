Return-Path: <linux-btrfs+bounces-18241-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BBBC04939
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 08:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 507894FE6A6
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 06:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4096B25785D;
	Fri, 24 Oct 2025 06:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qP1D0s1w";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jlYcSgGR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CAD266B6C
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 06:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761288749; cv=fail; b=TPL4AQJH1T/FBL2tgTtb7SJUhZidgDx0he562IWytyqdUWmgutXB9rXu1ZtxHsI06q29A+geuw829NWHRr8hNxlRS9ojeSXT3tE/orHUP3uSBf5UUBmk02KQqFw/n4FgXT2Fk9UzAHQpPQHcd3ni9jxF4TOYkjclknfbLbFM/ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761288749; c=relaxed/simple;
	bh=kaMYjQGoYzV707HLlSr6ojjVEdhh3c8vq0uCcvMAhRQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jjn0KGjlMlqYFUlhlPhPgBiALyLpFSKPLUpAmMwUWSNq+31zJnP0KZnFDf9w3W7wGhz5GlQA2cHYgzFkOn+6AeYRAK6vIgRR/ihaWox26HgH+PdJBbBoBQVSvQ+PcEKPC+Y/FDRgtijJ6adnUYiagd+HNE7FrMmWJcPRGU22M9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qP1D0s1w; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=jlYcSgGR; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761288747; x=1792824747;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=kaMYjQGoYzV707HLlSr6ojjVEdhh3c8vq0uCcvMAhRQ=;
  b=qP1D0s1w6uuzirTXlPjg5PAN+8nwcRIuNsVRFUOPr/bveMmbDPYfu/Vb
   f2V2qZYdHazwqnKbEO+84hmBufeFkpccalSYMrJCZhFrfSMa5nyXZf2Zx
   37pWBN99+ZC8FfmpW1pTsXE5X2QzxXwlkXMX0n49lEktRQ7yabR9R9J5/
   k7aXJxfxrb9tpudOSbqV5seUvEhXxFtXGAE+tYK5qcaQBuuECP9CL3++v
   AfZK27jOisUPxENBUU0AYbjbx3JmU+t1dc+492fMHj2m+J/HXrvt3PRJ8
   c8XgsMR05Cs03IXAu5Tr7x9gGo/xipA6FeCEQrkm/Rk8nuWU3PWjdqG6g
   w==;
X-CSE-ConnectionGUID: KmeqkAnuRvy8WhYRTxO5hA==
X-CSE-MsgGUID: sM3sSYvWRdqln0D/x2eWAg==
X-IronPort-AV: E=Sophos;i="6.19,251,1754928000"; 
   d="scan'208";a="130819772"
Received: from mail-westus3azon11010014.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2025 14:52:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rdm1+hRegq8tARt+RG4GA49ZiQZtU09mPw2kKZRE+iteWSamN63Jma77CraKhPRhFDU+Y3NgmlAajUAEYiqBp18VdQHW2EOKQaZJ05VPL0xXSx4UzOqhUkxu6f3dkHGdqW6TcVXhuLPc3JTNg2D6xtT7DbQaWGfJqrr8l02NyDfX/qHQAoeUGyrMrfvH3I7gJuOjZHcoNzH6nDSz5XF7BzjLFFXnRx1tTEp8N5/b4E+7zHlnkiQxvjwDT0NH2Fqi6ettN3CNh8dkGmxei/JGhGphdauPwymXUUuBzDddgcgoyHv9UNJBpdbHqgp55cFuNDJLJ0Qt/NGX9s0NhHcNEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaMYjQGoYzV707HLlSr6ojjVEdhh3c8vq0uCcvMAhRQ=;
 b=MH8osdn4/cr+tQDm7KH4PRNa0XSXZdjilsrWc1LfToQ90KM8gPZxHoYpOWDotHq9KlxdTbRMABe62Le7zvip03w0+hsH8VmBDkS7UhQHf9Pi/94cnSFGUxxN0kdgenduYLEKWHwmWK+GyC2vBQCkpXCFQ0B4qu5M7mA/5IZ0XYKF1PjC20Niq4CnDBo92OqZOnlt0pGueymDorSeWtShPHzoONZ8VFxg2oCZnnz7X5ckCGCoBKEePrLwP8CDrayWy4Y+iZ7x4CjXu+MqL2moqvccSp30G0Awb4fvKJm6ZMVRuZYfSigCOeTnPUcSUwf3tRG/D3cZLWAoj7WKt+rf4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaMYjQGoYzV707HLlSr6ojjVEdhh3c8vq0uCcvMAhRQ=;
 b=jlYcSgGR/msLAwpKEsry2+6YgkhOyhWyGFCALh48Pazr/tJYs6ePfk4oFupYBlpPLUlvzYwVbZwKE8/gkVM6/x1DA8Iar9vH2owrIboXPyCMabtWqDD2bzXyH9nHhTPCD9THaYNhzZmyy6H6+UL51/EnZcaYMQnVOA4kPLVNoCU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7167.namprd04.prod.outlook.com (2603:10b6:a03:29b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 06:52:19 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 06:52:19 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 06/28] btrfs: inline btrfs_space_info_used()
Thread-Topic: [PATCH 06/28] btrfs: inline btrfs_space_info_used()
Thread-Index: AQHcRDY/p+rL6E1zOk6w2LD0cMXdd7TQ3Q0A
Date: Fri, 24 Oct 2025 06:52:19 +0000
Message-ID: <cb655bfd-c5c9-422e-bb0f-213007162db2@wdc.com>
References: <cover.1761234580.git.fdmanana@suse.com>
 <c7387d9ae30b7bf261932c8965cac5737699b228.1761234581.git.fdmanana@suse.com>
In-Reply-To:
 <c7387d9ae30b7bf261932c8965cac5737699b228.1761234581.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7167:EE_
x-ms-office365-filtering-correlation-id: 93cdddbe-d1bc-403e-4cbe-08de12c9e08d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QmJMY0trMjVza1lJckM0ZVFKRWhvcEhTQlJraExESHJscDlObyt0cVRpYmIr?=
 =?utf-8?B?MDFIUzFkZFFjTVB5cjU1UnRpNjByMzBvMkNTdTgzUXVUdFBmdVF2TGVBZkRB?=
 =?utf-8?B?MmhQcTZsOTJUT015QnUvSkloZTZnQm5GSGhYaXMyZmp1UCtYSWVIR1RwbDlZ?=
 =?utf-8?B?emVuZWlUc2NsdlFHelg0QVhuQ1E1OStXVW5NTGl5NjJ1bmoyVVgyek9JUVEr?=
 =?utf-8?B?WXpzZEdnWGJNNVVqTFBsSFdLUGdBY0JjZjJrUXZ0WFdoV1FjU2NtYUdCMlBw?=
 =?utf-8?B?QnN6YzJyay9ILzR0azlITkFJclFEd0pWdnRlWmlXRHFmWVkwNE1MaWV5dU5O?=
 =?utf-8?B?bGQ5QWpYb3g5aVZhYlVrVWxyM1B6ZzFmaVJSeHV3ZGNudCthVGkrU1ZHemFS?=
 =?utf-8?B?RDZPRXFSWmtXcFEvb1Z6dklDdWwzdHIrckc0MTFKWUk3SEdaSkNGYzBqREE1?=
 =?utf-8?B?V1BvQWc5VDNkcnhySUFVVGdCZE9pSUpidjBWQzJ6UWF3bWdsL2lKVFYxZThU?=
 =?utf-8?B?WmlOcFczcmlRV1ZoM0VwVTk3MXNvWllpaWZHdXRVcThPc2hjWkQ2NTZHVkxV?=
 =?utf-8?B?SExnU1M0WU81VitxTXE0SklWTElKa2ZHNGVqcUFadDNZZE9JY01wbC83T3Iy?=
 =?utf-8?B?d0M1NHZyRU16SGhKUmRmdmNydFJVaUJEVFEyb0NyWGFCQjRkTjNXVnp4RHVr?=
 =?utf-8?B?ZkVYK1EwZUozeU5Pd2Z3TXF5bXBCUGhIK05xQWZGVE9Ba25iNi96T01MZjJK?=
 =?utf-8?B?ZVd4NUhwTVNGVWUvZVorV0tLWXhwTlRXY0o1dDZ0QUJCVFAwc21yMWc5K3A5?=
 =?utf-8?B?NVh1ME5YWEtBNmdQRVdsMUdCQVZYZjkzM3VZQmUvVU5paE1WczZxNElWY0Zj?=
 =?utf-8?B?TjJRamowcmx3b1hNV2FXUVhpQnNoV25ZVEhzMmREbStUZ056Uk9oanFIazEw?=
 =?utf-8?B?QzZubUs5UzM1a3o2cGZ1YTluNnJpdWZ1V1ovWEo2SnVWS2U1QldoYzVRcXV2?=
 =?utf-8?B?K21xWXFVV0ZNL1QxWFVLNUM1aXRya2orVWk1TXJiUHh6cnF5a1EyZ2xXN3JT?=
 =?utf-8?B?dHo2YWR4aHJxcy9DK1gzQWtPbjB0WHBpb1NXOVQ2MGpYZEhWaUp2TDVvQlZM?=
 =?utf-8?B?L2NPZXVmQlVXdWJ5dWEvYVp0VkVXb2RmcUFLYjdGdUJQY3RNOG1pa3lCY3NR?=
 =?utf-8?B?SmhQVzRDYTlIOGV1RHBNaDBiakNGc29sYjc0SFhHNmFXdExwQzNyeTIrTHFo?=
 =?utf-8?B?VE5IUUNJK0lPeHltd2Zqak80RDZJNDV2Q1gxK0cwMlBHNGRCMlRVMVRUeUl1?=
 =?utf-8?B?dE9PT1NyOEZlays1SCtjYmMxNFdHRy9qb1QrT3ZtWWVFWkdPdnlkZERtNTY4?=
 =?utf-8?B?ZXVoY3ZJVTMrMmZPOWhqQi8zY3RocU9wTGJ0NW05NFYwd3V4b1lvRmdZRzIz?=
 =?utf-8?B?TmkzN2tmRDkvTUxTaUpUWTNUalZTaTVpNjhsZ2ovTTdhcmZHc3J0dEZHaEcy?=
 =?utf-8?B?VmdLNklOUDlGUGo2OWk0RytiVnd1N3RFSEIwTHo5MnFtRU5nM3pkcHpnTkx2?=
 =?utf-8?B?OWxYTDB1UEZXRmNSUkFlM25pNExMazN5U3Uwb3RyMnQ0YzZLQ1FCa3A1Rk9n?=
 =?utf-8?B?blY1eUlhOHRsdHN2OFZPL09PcTBqeU1JQTdvL1YvK1UrcWJQVFFOOTJGY2ZK?=
 =?utf-8?B?WUdIZFhoQ0VNNjlwUHhXYjVBcXRVdHk0SGY2TitrUWJXMDBXc0ovNXpzemsv?=
 =?utf-8?B?WGoyUDdFcjE1Rk9pb0o3SHl2bHJBTDE5SzFsZ1hqSUQxbC9FWFhNZjAvd1lN?=
 =?utf-8?B?ZTJnRlhBRmhaS3NjWHVoUUdYM2NnLzAzcXBWVlVwM0k5eStINDFtc3YveEt4?=
 =?utf-8?B?L2dCQVBuRGFjenE4NW1xcnJqbi9UbXhuc2JmTURPZ25XUUhjVUROUEhJMjll?=
 =?utf-8?B?YUtGaEpRU0VvZkFvVS9kZ25SdXdaVTFqclgxVmZkRUF6a0wrdHdiL09TZWsw?=
 =?utf-8?B?RXhKQnB5VElwU09SZ2xWTXdBOExqenJGWk04Q2pQc0VaeGIzZUR4RVFNYk4x?=
 =?utf-8?Q?5uhwaS?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y01jYzgrUmpaY2N3bVo3Nm9qSjJEQTBnZGZMeHhIRW5qNDFRdmlZejhmWVgv?=
 =?utf-8?B?eFJnL1hBOUp3RmJtRzY2MGFxZVdFNm90SXNvNjVGQXd5K2RUY21QWU00a0xq?=
 =?utf-8?B?VHRZTzNwaHpLYnVuTFowU1EvM2pRNFVNOVdZMkR1dGc0Y0drWlNBQmE5VndK?=
 =?utf-8?B?VlMrSlBrVldEaVNhU2YvMnVQVFhEQVM1QjlKQzVJcEFhenBaNGRQVzYyWDdX?=
 =?utf-8?B?bW1tM3VTb1Bwb1RLTzNxaWRoR1QzaUkxdHNJT2wwNU5mTVdZdTF6bDdFNmd1?=
 =?utf-8?B?MjdSMHFuR3UySVluNEpqbDhVVjRDaU4ySTYvSVdoTFVXdEFMZzFYblhEbU0v?=
 =?utf-8?B?RVRZL1J4Si9ZTFNFdC9DQnFBM2JEMlJZcjRVSDV2V29VdnJoZ1VKSk4rNS8r?=
 =?utf-8?B?eFdjQTRTSkJuOTBRMEZ3NmVnbTludUFQMUFNbU5SZ21FdWp5VWJqWDdPQlZu?=
 =?utf-8?B?VVNzaGtlblRPNHpORU85SVpnVUhRZzg2eE5yYWVnT1RzQlZSendRZlpZd3Vj?=
 =?utf-8?B?ck0vZ0hGWVhXaGE0VHpVeS94K1hzZHlORkREODgwVE8xcml0VmVzNHBWS0pZ?=
 =?utf-8?B?dStUaHQ4UjFnN0hNbjRxZTN6TENMTDlSZXFSWjluOU1PdGJXMmwzVG52ZVBF?=
 =?utf-8?B?aENHWk92cUVqNjRoUEdseWZKYlpTNmd1U1NzQkVlWXhCUlJDczZIVFFvZ2Fi?=
 =?utf-8?B?L2NpVG9JL3hHdzZhN0ZOMWV2WVZuNlFyT3p5QnlLK25zbFpTbzIwbEs4VWx1?=
 =?utf-8?B?YUM4RXVCUUFJbmRWamdyeXlUcXVtZG9VMUl2WURFb2lrdXlvUktTdVhBTlRr?=
 =?utf-8?B?WmNEVkFEWkExTERQZkZjcDhhTWN0WGVtdUUyeE9TR1BGQ0RzNGRvckNqS3pp?=
 =?utf-8?B?a2tLa3Fsc3Jab1FzYmVSbmR4VG4rTVpreE5YSll3Y3BlTDlKU2NYR1ZkZm8r?=
 =?utf-8?B?cS9aKytQLzVEaHRqS1kvU2plcW1HMm9WRTc0QWhVVWJuQ2VDam1VTGlUM3l3?=
 =?utf-8?B?NEJTWXpKWHVveVlLbldkUHh4RVFDaEVyMTcxYTAyU1hjZWcwNDFKemhmUEdM?=
 =?utf-8?B?dFlSZHRrVjdQMnZLam9abEdXT1JiWFBmSnJ2UERNR1RSei9mb21jQ2JaWDB0?=
 =?utf-8?B?d0g3bk55K2NWRitZYVdXZk93QzdCWWFybmNxT3JWTW0zcWljRTJJUDdNU250?=
 =?utf-8?B?U0RXenZ6SlZ4b05JOFZnNHRkcksyZHo3TnU0SWFyYmpiUHVjU0dwNWxHQnRE?=
 =?utf-8?B?VXlnRm9NVy9GcERQTnZyNlpPUDVRVmlTMDdONGlwZHh3VFV2TFRwTGd5OVhH?=
 =?utf-8?B?THRER1JveDdOOU4wS1FQYmc4dENLak5YR1pnSUdtNTFhVUZCekkrT0o2bE5J?=
 =?utf-8?B?MDk2T2JBdUx4VWdzMW4wNy9TNi9lOW5HNnhzT3FCZEhaZXAwTXVUT3ErVDJa?=
 =?utf-8?B?RHk1dUdzSnhTZ2tmZDZMdkRhazNIbFNSeW83cG83cE4wWktNL2s0U0JaZEN3?=
 =?utf-8?B?R0NnM2M4dk5sMTVDSTNHQnEwcm5EUmhzZ0gydzJkVWZZaUl3UUlvTGsyNlhY?=
 =?utf-8?B?VVBqM0dza2hScmQrUUxVY2V0eTZwdys2MUhEOHRlRkthYlBPc2lvYVBEdjVr?=
 =?utf-8?B?V1hxOUtxbFhXemJqN05YK0VVZFNQY1A0UGViKzUrTi9WdVFxc0JqcjZSM0xH?=
 =?utf-8?B?NjZvclE5eVltWk1zVDRwaHQwcUo2aXRQUXRtS1pwSkhsRTk2Tmhsd05vVmx2?=
 =?utf-8?B?M2UxUjNldWdxYUZPZ0xkanNDNWlyNkZzazZOTGJoQTYrVnRodlBFR21zaThQ?=
 =?utf-8?B?YWEwWUdyNG9tSVJkc0pWVkRKT2l2cTQxc3dQeEJYZSthaGgwY2t4TWRLNCs2?=
 =?utf-8?B?ZVF3Z0s3YlUyd3dyTGRERm1qSytkMFpLcjN3VG5UdXpweTJ3YUo1anFXKzhl?=
 =?utf-8?B?b29vY0U2eWtvcmV5QlZrTDJYMjN5WXhaYmY2UjVtNitRN1IxU2pCakUxSWFX?=
 =?utf-8?B?eWJXc1BYZ0tZYmptcmgxSTBSOG5pdUdDZUs1SnNGR3RhWEYxNjFYdlFwWE82?=
 =?utf-8?B?VTM3b05iQmh0aVR5QWx3ZjN3UkoyekdpL2I0ZGEwYy9mcTloeW9jV0NGQ3RY?=
 =?utf-8?B?K3Z0ZlR5UzdEMGFHRWVCajMrQmxDQjlSZ2xSa2ZEN21GRWd1SXNkclpXNXAx?=
 =?utf-8?B?RlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD3569B7DE558C4980186900B0FA27B2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2X47spArXRDA9CY/UFy6VXSpSqPaIC207qQPbAQM26FVrVyjAxGR9moBKO/NuN6+vP4sPeSAKgQcslul/emNltfUnxhWyqUryhEs99tt0D5edEpi6SiqEaaQXCsrcHKitnGQYK2Dvi+LmKIO8bXhYdgpJwzTCtiBBLUd8+jcVeS3nngOYHsC6jUcYUkz04B0BXT8kxgrWOOJZ5bf3OkU+NNshT8/hXDV5egnhVfRY0/pFciM96pFWtllPEGC0Ocq0PL0Ws6cpuQQ+69nS2i+eGP50iOx454av86c9D7CpAfrGmrhiAuDZZGsWqesF/xdv7QfyT/DEvae1tReayFPvl7BKw+0RwXH+r8uK1XI50+iSUrkvIHjHNOxb0vm/lbcCk6pZGmN1xeJnWjI9VlNaS2uQ5Nk3kXFKpGyK5BhdJKQ4XVNBJP79g+V8zZyfBkIimvhPfkqK7g/ue2m0cTzBeZHjUqzC92crRP+dQ2B85rYLO+MfesDHRv4JPYGdfXgDU6nhUvllp5I7NmGDp7Z5+MA2Kgh6YcwaxqQGLRsLhZ3ZSKZxK7dOIooX7xEs8kbGmPJQWE04Kh+t/u/FB2cmzp+YsOlfagFR80BYrzL8UrD1OE8JZ6mfjrO/P8/xkvr
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93cdddbe-d1bc-403e-4cbe-08de12c9e08d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2025 06:52:19.8050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xvy4zBIKWAhgxQ8SdBjaOJ5QNmoHqT3JeJJKKy6+ELGkNvcze5pAt+e+LHTknOjERHIJo6/mA2GODtujLFNzl5pLWDZ/duEvMLQ1DxVfFfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7167

T24gMTAvMjMvMjUgNjowMSBQTSwgZmRtYW5hbmFAa2VybmVsLm9yZyB3cm90ZToNCj4gcmVkdWNl
cyB0aGUgb2JqZWN0IGNvZGUuIEluIHg4Nl82NCB3aXRoIDE0LjIuMC0xOSBmcm9tIERlYmlhbiB0
aGUgcmVzdWx0cw0KDQp3aXRoIEdDQyAxNC4yLjAtMTkgZnJvbSBEZWJpYW4/DQoNCg==

