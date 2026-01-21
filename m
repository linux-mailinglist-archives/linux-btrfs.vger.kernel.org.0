Return-Path: <linux-btrfs+bounces-20836-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPC/MxAFcWmgbAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20836-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 17:55:44 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4447C5A326
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 17:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4DFF74E4B0
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 15:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF594C0408;
	Wed, 21 Jan 2026 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iIYbx+xI";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="trRIzlo9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8462D4BCADF
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 15:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007868; cv=fail; b=tMvW9w3fGZlrXOOORkqM78gf4i9vWXQjxmav4WeGGDvAHjAURvrbE2qDWpp2y2TmkOAySUWEV+bHhwZWMiV92iT9FmZSj1zfs6KnUKiM/24TxyeCDJQaEBJj+1kdkZWAIoqYbuY0kG134HhnLAcBrucGiJ8CLSmp+j4JarrIj8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007868; c=relaxed/simple;
	bh=AZiAGh+y8hjSo7WD2dRpeirJg3VpbRDUwhPfehsAgsg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ulma4y2itg5y9P3mX8PcLfKolgBsaQUHQyR7rioeGx7m1UXpsoV38YveNo9fYd3wxi4yJehn+jZrDfvHXlWtNrQVYYucGkIqCJC7PwFxenDv9BYZk9wuXH0inIpM74p5C5recDNgT/JcEQ93UGpMPypilNAUW3sAlAyGPkugaYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=iIYbx+xI; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=trRIzlo9; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769007866; x=1800543866;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=AZiAGh+y8hjSo7WD2dRpeirJg3VpbRDUwhPfehsAgsg=;
  b=iIYbx+xIiPHd5/pdW0lfQZd41RXqMVg9pe5pfONN+9dmP/bUG4QWiMTA
   XmEhoScLydfVZ10Zv4ezusaWSpnGY7fX32to0yio/Yn3jaNozj3hNR4xC
   s47Z+f/KDkdfeJWUnh1XAmy5czV2kxfvja8Dzo4Vt0u6CH3AzezvlPLEe
   0oBE7zIa1mn/pcTEStNmqDhSCe8E1QMfrX50t7/LfkRWNJNMVWky9KyYU
   lkJ2qd8UOkRtxRI/Ad3myH2JHAE6av9d7fJYZrNC1uMiuYSt3sHHP9xNH
   6eu6uZsdI9KdZi7hEIOGWvMeFBR4hwP7Y3+fn3k7qlX7fwvhRkdQ9UeX1
   A==;
X-CSE-ConnectionGUID: p1A+tPD8Qs2DBydO0XS5KQ==
X-CSE-MsgGUID: zvMNJcnsR1S9QXeICAyFqw==
X-IronPort-AV: E=Sophos;i="6.21,242,1763395200"; 
   d="scan'208";a="135816483"
Received: from mail-westcentralusazon11010007.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.7])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jan 2026 23:04:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p54+xSQR1RhA9X+SYMbsYE6x/+avCRx5Mp2vl3f3mdIVptROAzU0e6uJXGZlRR6ImuJxiTYJFXadGwAoKdQboQu+kW1/NrED7wT20gLMnsPA2WKtPcSq7izNV3vGpwQynzLIPa7mSibK2DPj/kGMPfgFcwJn7rCGIFRRBN4S+37YtlzJsBrXE2JCSvWh/ml801Da0BOjvEbv1M+XTk4YzMqsyEBIBKr9AuzF+GvSMD1JvwiKJtwSWePI0mKS4poS7FVecuTew8ynvz9grimIQBQ6jDqHHWZn5QpBG7xKkmgtvKkRj8CQvA/YEbTQ6KTV0mw81An22uJvhY2upRBppw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZiAGh+y8hjSo7WD2dRpeirJg3VpbRDUwhPfehsAgsg=;
 b=DJEc9gV9ImJtRiROtyosxIiMmKq/W4jejYcwYT9ZJyM+Qtj0YeqHu96Ks2H7knuCR040mRi6gBV1nAsvDCkCKOS7Pa/3FLGH1p3et+ixESVY5ydIW//+nycB1kYQQBfIXbqNvfs7hNdeZWpjYisenkZu/TEimRbMC689hM6ZEzvyAQlQe5wESBcUnfErB//Fj0lgZAp40eZzhNgdOA4F5aLJQiMp0ccpABHlBs8EYKcyMcCgIy8CfIiSL0hXjQJ5kZ93ymHINKV0jSdEPaN29R/U7yOzYwsK7PrElpIjh5NTM8rhXy2tBNRp8eKUdZvlU8cebq3gjPbmqF7fUpEZtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZiAGh+y8hjSo7WD2dRpeirJg3VpbRDUwhPfehsAgsg=;
 b=trRIzlo9gw07n9+7PEqbFn5GTAzyfCn7DYYH9W4Ce+VxrW0sYCLeWaYCG6A0UioDKdNAVbcCPUOq3X1Om+WuGBV5xS4yur5sVrpwV/RRluCf+hh1LMDHXthhtWgpsHBgD+ZKAhuLhh4rvMoVstfIJTkajgXd/KZ5/8xfRD8WVLs=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by SA0PR04MB7323.namprd04.prod.outlook.com (2603:10b6:806:e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.3; Wed, 21 Jan
 2026 15:04:17 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 15:04:17 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 03/19] btrfs: remove pointless out labels from send.c
Thread-Topic: [PATCH 03/19] btrfs: remove pointless out labels from send.c
Thread-Index: AQHciskGPL/DjALwr0q/TJRihaUt67VcuNqA
Date: Wed, 21 Jan 2026 15:04:17 +0000
Message-ID: <82b91a4e-095d-4a3e-bb66-a046f3d332f5@wdc.com>
References: <cover.1768993725.git.fdmanana@suse.com>
 <9684a687dd031bdc506fd15472be9356369a163c.1768993725.git.fdmanana@suse.com>
In-Reply-To:
 <9684a687dd031bdc506fd15472be9356369a163c.1768993725.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|SA0PR04MB7323:EE_
x-ms-office365-filtering-correlation-id: 9c0b9440-df2a-49e7-42dc-08de58fe5977
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|10070799003|1800799024|366016|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?R1duNXdUNDhMNzhwKzVCK1owWHUxSEtmNWJXTFNwSEY0bDJxUFFtbDNBY29M?=
 =?utf-8?B?L2JwN01UeTBKNWlYUGJKTlA2WGd0NGN1WXZKS0NEbkZwOVN0SjdBcUVzZFh5?=
 =?utf-8?B?TmpSbklIR1lJekQyWkNBMCtNQVRjWDZ1OWlDU0p6TGZGUTBLbk5RRUlua0lN?=
 =?utf-8?B?N1lVbi9FaUdReldnWEl2VjUxcVRmQk9pV0NZR0FzL2UyYm5sV080V2pVcE0z?=
 =?utf-8?B?MGY1SVFSWDg5Vk5wWkk4M2lHNXdvRkE5a2xSaXNoVHZleUJ5T2R1UFQ5ck1K?=
 =?utf-8?B?ZEpMcDdLVCtNdHlGVVFBVDQ1NjVET0lJQ3ozSVhGNWdTSm9JMUtYSDVoRjZr?=
 =?utf-8?B?MnA1bjRHb3JhUVdIMTh6Nmd2eUU5ZWJTd3FiSXMzUDZlMmhyNHVWYkRsTkZm?=
 =?utf-8?B?WVkzY05GdlBMVmNPTUZQWU1wcC9JeVZHRnRhY3doMCs5UkRCQ2xPNmg2a1Iv?=
 =?utf-8?B?Z0V4QzJiRG02WWhsdGN0UFN2K3ZLUTI0NllWUGZHY012dFhWamszeDg2dUIw?=
 =?utf-8?B?cFNJNHlHYjU1SW4rbml0SW52N3FVaGZxdCtDaHRaTG5rdGVSMmlYRE5VY3Na?=
 =?utf-8?B?bmF4Rm5ES0ptUytLUE1TdXZvM3BWbzV6UCtKTjFPYVdxeTRxalgrRmszYitk?=
 =?utf-8?B?ZHg5dGR2dEQ0VGFtV1dvVEhMU3hTR2w3b3lzMHNJUGtoZVF6b2k1Y3prbldo?=
 =?utf-8?B?a1RieHNMWmdFVWl5UzdrREFlblY2RnZOcXdIUWRSc210TnZaU09QaSs0TUpa?=
 =?utf-8?B?ZDk0K2dFRmRlZVRHQStwdmVLVHJUMm9SWGQ2U1NXSGxmWXkwekpIM1oremdH?=
 =?utf-8?B?dkE0bG05RWY0MXBkYmRrV1ZwSmNuSHg4c1hzemtWMDkrdkJtYTd4Vmh4Mk4r?=
 =?utf-8?B?WUxqM0UxNkRUUzBPc0poUS9jd21LbHRKNDVsL2xNOUcvQ1NOTW9KUHZrK05E?=
 =?utf-8?B?dkMzY1M0bFM3YUdxRmlqZlZCVFJTMnRwbDFSa04yZ01xeko2RmxIT001bmww?=
 =?utf-8?B?UGxFbzBnbzRnK2tIZ3BlWkxybVY5SG15SzV0dk5ia3lpMnhDNFNBN1pMbEJ4?=
 =?utf-8?B?WDhnMGRuK05FNUgrV2RPbmlEL1NHdW5xZVpRQlVhK1FkUUJJbUovYmJIaFFa?=
 =?utf-8?B?OGtoR01DVVJlRjBwNjcwT0cvYU1lQ3lmbUdaTUFiRS94RUFxcUlYK0RVTFFz?=
 =?utf-8?B?Z0IyMytMR1c3dmwwSHBYZHVhV0tDbDZUa09lY0kwMVRJekx5NUNwV28yMWF4?=
 =?utf-8?B?VFZLc2NpMnNOZjhOQUNLaVpjY245QmcrbEhKWXNGcDdJL0p0WVA0VWtJUElt?=
 =?utf-8?B?dVoxRkJUbmltS25rTWYyelUxdGxMMVkrR3lsVmNZNmRXVXd6d3BvUXdiYmIx?=
 =?utf-8?B?U3lVMFNFaUVaN0JSV08wR3R5OW12MnBVYVRtUXRhK1llY1BreXBxZjJlOFY1?=
 =?utf-8?B?Nk14a0pQWERkRUtNUkc5YnB0N0ZuVnNFY1NwZTRmV1VJdHl1TlJuelo5RkNG?=
 =?utf-8?B?eWFBRlVQeXQ3UXVRWEppSTZNL3oxbTdGWmRSS0NLbExjeU9wMENZdEJvM25H?=
 =?utf-8?B?OWwwUGZiZTlWK3NldWVIU1MxN2daM2FvZkhFQStRRzFqMy9WeTYzSmE2VHV3?=
 =?utf-8?B?YVVDTHh5alBwV2JMYXcrMlZ2QWt6aExvckpIOWlNc2IyTUg3elZhNW1ETFc1?=
 =?utf-8?B?WTN6MU95VmZDcDVhZGEzTzRNWFFqVDJKZmdnN0N5T1A4R0tBZTd4TXFTVE8z?=
 =?utf-8?B?OGoxZnprd042ekpsMGZjZ2M4dGNVRkswZXVtNnJBMjMrempCVmtZSjI3Z0lQ?=
 =?utf-8?B?czVtZ1BZdnE0bWR0Y2xVZ2xoQWpmZzFyVFQrMFd5WmU0Q1Uwb2FyVG9hU1Vn?=
 =?utf-8?B?ckxoVU5GajVwV1d2OUJNVTZqb2c1dnZjOU1XdGlyYVdlT0ZSblU2eFJrQzNr?=
 =?utf-8?B?eUx4WEtlcUZnK2hnWEZiSTlSQ1k5cFhDaTQ1SjcyQndYbTlkcUJUZzA5U3Bh?=
 =?utf-8?B?M1ZBUHViTzJlVWFEZjZpQm4wcEI3RUdWMERPaVdGRFdaN0Y0MDZqcGpuYWpJ?=
 =?utf-8?B?MkZ3a1dnOUhCbDhBS2JGV25TSWtlSDFnSGFCQXBKbnNMeFRNUVZXSTFESndP?=
 =?utf-8?B?TTRITUlBWlFuR3ZOcXNEcGF3OENuOTZWd3ZjR3cwaGJhY1lubjl0OFp1enEv?=
 =?utf-8?Q?pbEhw6fwxsqVCu/+DcBBP6E=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(10070799003)(1800799024)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZWlrSUoxaVowQzNyemw1ekQwOTVnTmU4N2c2U05GWXpjTlJtY3l2MzgvRUlI?=
 =?utf-8?B?d0srcEJKU2FJSGxrODFPTWgxN2FRRkZHcWQzR1RkYUZaOGU4Z2ZweE9mVmp6?=
 =?utf-8?B?ZjBwOXh6ZVhCbkpIVUZhbGpDSXhZcHI5eEVhZGt0UEpyRjNwd2NXaStxU1Fs?=
 =?utf-8?B?NkpqUFkrcDQxcTY0SjQ3VUdiTXJ3QURuT200ajFnWXp2b0VTc2tFMkp5QmdY?=
 =?utf-8?B?SEYzK0tJanFZT2VEUlRwcURRMkJqd05DMkRPbDhWRkUraDNHUEM3MGRERjdH?=
 =?utf-8?B?MXhyVE5rbWdHMVU1K1VzSW9jUDBWYkhsa2pIb3RlaTIxOUw4b29XWGhUajhM?=
 =?utf-8?B?OVRkaGNHK2Z2bktFNTV4Q3AyV0JIOWd4eExsNlZiTXg4WXgvd040QWduOXV6?=
 =?utf-8?B?NkpFbjg1UHhwQ3l5Rkl2dzlaVnNSQjJlTnZ2N0p1ZHJVa0hzWjVhQ1V5Mml4?=
 =?utf-8?B?RFBEVEtxQ2hQQ084SG51WnBXVjNqWGpLVGtZRjNGU082QWN4V2FCS2RCeHpk?=
 =?utf-8?B?RVhHeHF0MGlIZGRvM0Rhc2pxenN5UkxkV0NaWGkwdU5wWDZ0WkVPWHljQlc3?=
 =?utf-8?B?ejhnczhLb2tLQ0tkcWpHZUN1azcvSytzb3plYUZKWDgvOHY5OFI1cjlEZWtk?=
 =?utf-8?B?ejJLTkhmOHZGdXM1TERpMnZuem5Id1MzdTJKd094cWFsTVZoNVUveGRBbzA2?=
 =?utf-8?B?MmtMTmV4WHNDRU1OaWVFdzlNYUlhUmx1QUw5Nk90SEh0bVNleVAwWkxPTEdE?=
 =?utf-8?B?TnFrUmcyTmFRaVZyOUhadmdsT2F6OElPNEVLVVdjYmdmbW5mZ2xHdHdmQ3d3?=
 =?utf-8?B?dzhvQ0plUlpQV2lvM0dBUk8waXlDTHNnamxWTXp6dStCRndMck5IQnBMK0RD?=
 =?utf-8?B?c0JrTFo4ektJTXFad1FLVVhDVzlFeVNpWkVDQUlJNlFVT2lMQ1MwdklSbG5E?=
 =?utf-8?B?aGdzK0FPdmkvdDdhZ1QrTi9UR2l3T0dMZTkxQ1hUZDMxRXdaVnZrMFViaFl6?=
 =?utf-8?B?NGpQdE1YQWJjWVhGMU11MmsybEhuYUttNnhweHlhR2tWbXhjNVliNnhUcTVL?=
 =?utf-8?B?ckNPT3d4dDRUa3N1OTI5RGV5ZzJ5R256dy90MDA4L0d5YmNwZ3BUWWdlak9P?=
 =?utf-8?B?OGdvVjNRcVFPNW8yNjQzR3E4R2dpNVJqZEtJSWVoSlhyVmx4cDNHcDRER0tn?=
 =?utf-8?B?citsSnpjekF0WFVTQ3FyZWxnYWJDdnJQVkkyR1V5NGdtVVpQc0h5N01lTXZK?=
 =?utf-8?B?TjRjU0ZscTJvcTdtMGhQd2FjaFZnaE4zdGsrY2lVVFZRZnZCck12N3E0NE56?=
 =?utf-8?B?ZWFsaVJvdXdLbVpsOUtGVzBVdXVpNWtwVngveXhncFBkcGhpbUxKYythVlkz?=
 =?utf-8?B?YlVpY2I5aHJPY2JBZGpZbzZ3b3JtL0ZXMDZ1dk9GVTBCS2xtd0VqUDJ3SjNN?=
 =?utf-8?B?QXZ4REk0QjNNRkkvNDEveFBWdEIrL2o3TGlJRERDYzhIQVl4S091Y204QVNx?=
 =?utf-8?B?K0tYdmI2ZDQwWEhaNWhtenFnNjc4andCSE9rMjhVWGFBT3NrMkxDRFpRemdJ?=
 =?utf-8?B?eVgxRmg1TFNYQndVenZ1Yk9OWHkwZWlZUmltN2t0OWVUMS9xOHhqVndlRU8v?=
 =?utf-8?B?d0FvYlliSlRFMENaTTRxbldmbC9aekRTR0RIVTFvZHNGcS9YcGF2K1pPS2NY?=
 =?utf-8?B?UEdmSXNOTC9uV2ZFRXVObU1iNWNIa1FaMW9idklOWFR2bWk2ZnhrNEJXZlNS?=
 =?utf-8?B?SHd6amdacFNlOU9jWjgreDI5RDBsaDVYZWk4QklDSDZYZ2xjMjJEbnR2NW91?=
 =?utf-8?B?VEQ0d0lHdlB2UlV6bWVhcW05TE5wT1ppTFdRVmcyOUNQdEdsVWhMQm1LU0Fi?=
 =?utf-8?B?OFdqZDBTempDSm9nYXQ2Q3l0Tno3b3crdm16ckkwZTE4UEJKOEJHVHNGNVp0?=
 =?utf-8?B?WWk0L3I3UUlwR0djY2pIUFdSR1dsOEdkZzBsenFhVmdrc1JLRWNPcTJ5Q2t3?=
 =?utf-8?B?ZUNTZm91RGM5QnF0em9XUXphMTI2NmFaVjUzWUhmRW1tYU5DTEttYm14bmpL?=
 =?utf-8?B?SFlVQ2x3bU9haWhSSGZVWUFVeTBZa2FBekNFQXZhYlg1SjlqMGN0eUZLRTBt?=
 =?utf-8?B?YmtQNXArK2lCdTZyNk5wWkRIUVJNb1FMTlFPUWVuaFhPYzV3UUdYK2RtVm1x?=
 =?utf-8?B?ZytwWVFocWdXU1VMZnpTM1V5TkdDZyt5cGdJNHBXODlSNWdiUWpJQUNHVXF0?=
 =?utf-8?B?MWxUeVl1VHBHRExKQ2VEWmlCaDN1NG5YNnR6WWhtLzhjcjFWL1QyZ0JmcDdv?=
 =?utf-8?B?M3dNQXgzanh4MnB0UUZFc1VDbGcrZW5lazFoUFlBdzRYdHg2VU1SR3gvT0ZD?=
 =?utf-8?Q?lss1I84NmI+lPdX+Oh1I4rVrDyFDKb1SIy/tka6dK2O+4?=
x-ms-exchange-antispam-messagedata-1: R0OLc+GB5x+Gpzdp8/jfIXZ6VRobAPWEwPo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <468686B015F9A44389776014A0A66B3E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	r2JXnO11pdwrp9hSrEA6g36eoBniwIheMx2V4GkbkLmYC00FHaA24GZi2bFdIeMQwLT44QdiPBe7CGIqU0EXB09S53XfE9FjXJyjXWdjC19WIOfZFSWKCc1sOeRiuUJxIIrJl1QJlpWZWMrd4mYB2WOcy/AgPW+TiSsLC7PQk7UEo1LE2aZgfGIZyyDniMSVnu/BoxYHDv8dYZP5zhPfBMz8Fjol+mKSf/C0WY6Q+8QdK2HYR8vXqJz91LIpgNw2WcgQ8r+LgsLKm+N6lvBgdXo+Jh52IV25kEZGf8nY6wYnrTKmmyjaABXqIMLzMXSX5Gg97zpo/2ZFoEpHSsddQWBoR8yY+D0fTINef98DKwxYGTVvtK1cTuzy/BjZ2myzbwyARdz7kptCsdCo2x596gTI/RkRUMorGSM3Lf8YABkE0/TrX7NJ1ftiI9W0ObxE8tjwpbogExEc/ftrTO+PMv/si6LPalelzK6d4o0DYPRhAT9ZTaouYIB9aACOlU4t/34rxT8A1nTU0RI+Ka63MMolYBMLylwSM03C6GWViGbnS0TxUneyCLdSYLi7NUdFaEQdL7WVQxNKUq52wdmQqPFV7xZ28HILRIKtzkoPwK3sL7ty3iiJZPG5emYWUkq3
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0b9440-df2a-49e7-42dc-08de58fe5977
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 15:04:17.8594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ukTvu8hkFpiY9QfaRWFu3aFh+dw1AlRireSHJI5DVkxze1nN0cBd4nuS3s+hdd+/XYx9u0PNZZ1cSXOpNYZm9OG5LCEgPScSXYYKR0DYPHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7323
X-Spamd-Result: default: False [2.14 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[wdc.com : No valid SPF, DKIM not aligned (relaxed),quarantine];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-20836-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	R_DKIM_REJECT(0.00)[wdc.com:s=dkim.wdc.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_MIXED(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[wdc.com:-,sharedspace.onmicrosoft.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,wdc.com:mid,sharedspace.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 4447C5A326
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gMS8yMS8yNiAxMjoyOCBQTSwgZmRtYW5hbmFAa2VybmVsLm9yZyB3cm90ZToNCj4gICAJd2hp
bGUgKGN1cl9vZmZzZXQgPCBpdGVtX3NpemUpIHsNCj4gKwkJaW50IHJldDsNCj4gKw0KPiAgIAkJ
ZXh0cmVmID0gKHN0cnVjdCBidHJmc19pbm9kZV9leHRyZWYgKikocHRyICsNCj4gICAJCQkJCQkg
ICAgICAgY3VyX29mZnNldCk7DQo+ICAgCQlkaXJpZCA9IGJ0cmZzX2lub2RlX2V4dHJlZl9wYXJl
bnQobGVhZiwgZXh0cmVmKTsNCj4gQEAgLTcxMzAsOCArNzEyMyw3IEBAIHN0YXRpYyBpbnQgY29t
cGFyZV9yZWZzKHN0cnVjdCBzZW5kX2N0eCAqc2N0eCwgc3RydWN0IGJ0cmZzX3BhdGggKnBhdGgs
DQo+ICAgCQkJYnJlYWs7DQo+ICAgCQlsYXN0X2RpcmlkID0gZGlyaWQ7DQo+ICAgCX0NCj4gLW91
dDoNCj4gLQlyZXR1cm4gcmV0Ow0KPiArCXJldHVybiAwOw0KDQoNCkRvZXNuJ3QgdGhpcyBvbWl0
IHRoZSByZXR1cm4gZnJvbSBkaXJfY2hhbmdlZD8NCg0KIMKgIMKgIHdoaWxlIChjdXJfb2Zmc2V0
IDwgaXRlbV9zaXplKSB7DQogwqAgwqAgwqAgwqAgZXh0cmVmID0gKHN0cnVjdCBidHJmc19pbm9k
ZV9leHRyZWYgKikocHRyICsNCiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGN1cl9vZmZzZXQpOw0KIMKgIMKgIMKgIMKgIGRpcmlkID0gYnRyZnNfaW5vZGVf
ZXh0cmVmX3BhcmVudChsZWFmLCBleHRyZWYpOw0KIMKgIMKgIMKgIMKgIHJlZl9uYW1lX2xlbiA9
IGJ0cmZzX2lub2RlX2V4dHJlZl9uYW1lX2xlbihsZWFmLCBleHRyZWYpOw0KIMKgIMKgIMKgIMKg
IGN1cl9vZmZzZXQgKz0gcmVmX25hbWVfbGVuICsgc2l6ZW9mKCpleHRyZWYpOw0KIMKgIMKgIMKg
IMKgIGlmIChkaXJpZCA9PSBsYXN0X2RpcmlkKQ0KIMKgIMKgIMKgIMKgIMKgIMKgIGNvbnRpbnVl
Ow0KIMKgIMKgIMKgIMKgIHJldCA9IGRpcl9jaGFuZ2VkKHNjdHgsIGRpcmlkKTsNCiDCoCDCoCDC
oCDCoCBpZiAocmV0KQ0KIMKgIMKgIMKgIMKgIMKgIMKgIGJyZWFrOw0KIMKgIMKgIMKgIMKgIGxh
c3RfZGlyaWQgPSBkaXJpZDsNCiDCoCDCoCB9DQpvdXQ6DQogwqAgwqAgcmV0dXJuIHJldDsNCg0K
SUlVSUMgd2UgbmVlZCB0byBrZWVwICdyZXR1cm4gcmV0JyBoZXJlLg0KDQo=

