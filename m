Return-Path: <linux-btrfs+bounces-15451-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 561A1B015B7
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 10:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65A7E7B8169
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 08:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D865B220687;
	Fri, 11 Jul 2025 08:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mWjzDg2Y";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cjcDECUp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912CB21FF4D
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 08:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752221560; cv=fail; b=qj+XoFgEdCIhOTTRhZyzvfTvULbG6Yoacc5ZZeYxFPjfuD3Oz1sCxXY6Pyrvar9bCR79Ry+q2JzmYDRlYiH7PC+O4Z2hDQbHW2/jK4+vd+TLowjwtkmZ6M0OzMdAjqVSP2b/EEfanSbEVmJ4muNH7sJrt0LO9Zudo8AZqXdDyp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752221560; c=relaxed/simple;
	bh=dr7WW67PQxU59XkQPQvM5lBBzLwdrtqA/lBL48MRQic=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g4ne7/g8WT4Uj+kprs3IDV7dmy+uYjt6/xp/M+aOVZm1NeDz8WesRd1jddaRPqWgB2IaZkiiF1pcybDosRGHUSspTLgJsze4bqiFbo2Yt4MXWhK+Bz3r+KRfmX2UtW4g9PSzuVagScA5L8CeZYuk7+CXeMM0EaTrhX5QEX1BQI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mWjzDg2Y; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=cjcDECUp; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752221558; x=1783757558;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=dr7WW67PQxU59XkQPQvM5lBBzLwdrtqA/lBL48MRQic=;
  b=mWjzDg2YBTxOWZdYC2T9DYYqJVFLd1okOftKaAl0NnORSlQQw2s92IP4
   ION5H0CPll0bxY7rN1NKDmFz+kZU2+xN+zIvDOM0xzIEfaqO3foL5oqs2
   oHLSdQR6CpswCF9TagQ9Tkt+G0Z4rnBvHlbqqZVv47hgSbN6LOHaaA6un
   FKGM56eIPW+9YdHO3irHR0i5op22PdtDRTOtzJKj/+6ld4kR62j87xAy4
   ue9ZXVTFq4QGKy2vI2XohXBlfkVnHLAl8fayVklZqYOxlr59fRc8A772r
   l7UoCkucUccU8u/TcmV/dZtlHXIGp9kuER28TGBpi05rgAYp2GXsNCBOf
   w==;
X-CSE-ConnectionGUID: X0JF23l+SEaa0ug0ke9T+Q==
X-CSE-MsgGUID: iM+XDyCTQW68PDBHhPGdtg==
X-IronPort-AV: E=Sophos;i="6.16,303,1744041600"; 
   d="scan'208";a="91608631"
Received: from mail-bn8nam12on2055.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([40.107.237.55])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2025 16:12:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQpn4AI1sQ0JH8UJQ5rFXBAiaQCl2IZTpJj/PER2fP7aGgWafd5uCS/QOEQzDw476SY3gOPN0+NoRK261dMjfKr1HJf5bfN6anf5d5QEtmeHbQTblc/etzTHAGtVcTy5B3GSsqVtuv+Rn7ptcQwHyoD8C4lNIT9SF5IDOrjQvnwlc/PaYXf/R9pJ1SdiMIlGabfR6uwOAE7PMTFJxhtMKsmM3g2+B1uJm8VubbGc+kNmE3c/yxmhh9M1nhwkiRgjySaaS4PeJCVuRxxFv2D2+twPjVTFSTIxFOxK1Sh4NGbwuok2yjMw3Gc/bC172+ESjBNw8fMkBCS8hZHdyXNVaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dr7WW67PQxU59XkQPQvM5lBBzLwdrtqA/lBL48MRQic=;
 b=OkG+QalktxF9c46eBZYsFf+D4tEvdGtDsKcnPa94qPD3boPUz7bnfIJH1BPHG/oX7psfGBSTAsQQVzUzS9kjo7scbHHkYzCa8K6/Aq+CzXoXOz7ygMJxonjCm0JFxm/D34+JNNBJ7MfCyjSr/apW0q4G/XHXyEwOZvBoa8mLRZqW/chYRCmmhBbEdUxaHr8ATDEbCBdJPSaELCa7BjODcgDzksUjMVJ3Puy0WGImnDwQxroxrhGX5Lnb73a8INOnQGkymmMDD3Z6369YO0uh0Ra+Oi8pQezxk32uJmB3tO0M1v9RMpC/Cohw5R0mhqBwSkrnAdzpyzf/OuT6+IYWRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dr7WW67PQxU59XkQPQvM5lBBzLwdrtqA/lBL48MRQic=;
 b=cjcDECUpe5wU4VaCg6IHdBFHVvIu8Vn6tjS7fuoi5aq6xKgJXuXFk8NlvVpRjI69dODYQVd//6mMlcIs18cetUUEMeREtcogIJ9w3zH18Wo/e/GWruMrIWpqhpjjsxOmqrfUtVxHnnqFd0HufyyB3rIbnzlvESw37N8rGwY/mlI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6446.namprd04.prod.outlook.com (2603:10b6:208:1aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 11 Jul
 2025 08:12:28 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 08:12:28 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] btrfs: zoned: requeue to unused block group list
 if zone finish failed
Thread-Topic: [PATCH v2 2/2] btrfs: zoned: requeue to unused block group list
 if zone finish failed
Thread-Index: AQHb8jMd499HazhsSE6D83k/0LJ8b7Qskq4A
Date: Fri, 11 Jul 2025 08:12:28 +0000
Message-ID: <bf6edceb-3a3f-43bb-b294-72200a76f6a4@wdc.com>
References: <cover.1752217584.git.naohiro.aota@wdc.com>
 <87efe2de05c2e12253055a0693693e715b5ec8a8.1752217584.git.naohiro.aota@wdc.com>
In-Reply-To:
 <87efe2de05c2e12253055a0693693e715b5ec8a8.1752217584.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6446:EE_
x-ms-office365-filtering-correlation-id: 95e175a6-031c-4c72-ae3a-08ddc052ad57
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bWNVOHEyT25yMVVzbHVMMTdPcVFPS1JscXNBZGtSMXpWTjYrelRHajNrRWMv?=
 =?utf-8?B?UUZuUjJ4K1hEMkptcXI1Q2RIZ3I2S2dWaUcwajMyNEYrTnZxQXlKYkJhYkVO?=
 =?utf-8?B?WFpFUlJIZ1lRUk5MWjVTdHp0K0krdERCL2JKMFB1RHNzdGxPWjV6V21EWXhJ?=
 =?utf-8?B?bzZEZlBESU1yWFBmN0lwb0tIZmlqTkNPd3NSZmlTenFZN0s5dWZnd2oydk85?=
 =?utf-8?B?S3g5ME5NSGZqcEZkQWZaamJldnpOSGZuUWJZUXM1cWpzT21jcGdIOHN3ejZn?=
 =?utf-8?B?NXlFODBNZGs1NkhlVStPd1JWWndEY0drVXJUSkJkSm5vRUxXQW1WRDg3VlVV?=
 =?utf-8?B?bDlsQUF3Q0E5d3A0WVVzNzY0bVRxNytObDVDRTVxSHhLUEwzOUpxRmljSUF1?=
 =?utf-8?B?azNRV0NxK1JUblpNaTd0cTB4bmhTWlgxQVVWVzdpeWZCYjAxby9ONG5oNXhD?=
 =?utf-8?B?WDR4OXA1bWRGUjV3b09RcmRHTkdUakdGOGJ1MzFhTTRwVW1ZUW5rK3p3MUVi?=
 =?utf-8?B?MENKVTVPWURZV2RrdkRINWlEZUdvT0U1NmkzaVdTSmV2VnpCTXJ2c1QvcnJv?=
 =?utf-8?B?aE8wRzRwTGdJL1V2UHJjY0pjUG5HNnpzcWlXV3dteU9Pc2tVVEJiMzQ1eElh?=
 =?utf-8?B?V0hYeVNlUlN5WHltclVNTERGdWZtdWJHdSt1cFN5MmlaRVpNZzhRVExDS01W?=
 =?utf-8?B?N2J6Qm9qNVdVMlh5SzN3WEFZQzBxMkswT1JEb3VTVGdWN2JMM1Z1NWlINnN1?=
 =?utf-8?B?RmV5R3BxVjFnMnFHczR5RTFaRU8xNk0xaFJLSURKMWxOSUJsckFlU2xGdWlE?=
 =?utf-8?B?amhWaWhjSzJpemJ5ZWFRZkc5QlN4MzZRakdhOWZNUzNiUEVrS2luOFl4QTFC?=
 =?utf-8?B?M0dCMjczVUFELzBJM2U5ZitOSWhndjY3WmR6MFZYTDZHTC9lN3oxVEpMRWps?=
 =?utf-8?B?RCsvMEl1VnhCSmdYdS9ZWnc4WWJ5UWhCSUdsb3dBM0tvaWcxcUZhMlhDOHJ4?=
 =?utf-8?B?K0JvQm1CWExLUlRjSzRsNzlObHdqQUFWOFhMQzE0aGswM0tNQmhVeUNtK1pu?=
 =?utf-8?B?ODJleGFkWXJQWGJ6eWhobENWajhlQjUvaTIxSVB4c3JUbXdldmVGOGhBYVQ2?=
 =?utf-8?B?cmxQc1cyZ0w1Zm5RcER0Zmdha0ZmQmtDS1FobFdXSTdOMXp4ZW9LSk44dTFt?=
 =?utf-8?B?VlJBYUNpSWJxUDc3bnhPMWZLdm1UVVAzQ01LVHMxWjFQYWk2aU9IMXBzS0F2?=
 =?utf-8?B?cWR5K29MQ1k2VlpUTS91bDFhRzh2QTM2TmRjcGQvM05oU0c2bWlIVVdJKzNm?=
 =?utf-8?B?RUNWVENsellZUlZvZEJtTXNCcDFQS011ZEZySlhpTkdra3dqcHA5OVdvejUr?=
 =?utf-8?B?dzFkbFRWUENWVTRsK1dqcXlTdkdiUTZjdVdmK1l3OHJWNndGUXB1b1JVUjdv?=
 =?utf-8?B?TFZxRzFqQ2xzYW5DRE1Hb1J1MXdJVEhMYllZNi81WDRNVFA1bDBDbEVXcVFr?=
 =?utf-8?B?MnJROEE3Rkh3MFFBeXNzQnNWVTUyc25ndGkvemVyczQ2WkdIbFhaK2VTWlhq?=
 =?utf-8?B?bGlsd0FUMjEvdXdzTmFYWTZtbDBxS2xnZ1VGaHlsWjFmT3o2OHRhOE9aT0pz?=
 =?utf-8?B?cWFjYUVoSVNTS3NRMGxsSi9ZZFBvVEhzb2NtS1dMdDNJa2c2Z2FsaUJ4VEtx?=
 =?utf-8?B?L1NESXJoY3IxdVVGaVlKUUR6dnJHc2FEcjdTbjJ3OEtKb1dwMnFrMWpjL09s?=
 =?utf-8?B?d2diajlPeGdQYnh5RjFVbGM0MjVpQU1uZmNvbERGbnYzb1Zjc2E4cHRMeHlS?=
 =?utf-8?B?dHEvMUJZNmxUSUJzSGlDaGZkTDRVRkNleDFrSHQzNmVONjNpdFZycjhYcFIr?=
 =?utf-8?B?Vk9PdFQ3QkhJbUR0dHlrZ1FwMmZZM3F1aXFBcEIvMjIvTDF5NHlkOStrNDM0?=
 =?utf-8?B?dHVpby9YbnoxL1lyaDVrVXRZSkhEbTV3dWJYL2s5MGRXbUNUbTRIa3U4eVJl?=
 =?utf-8?Q?SityQq4m4clWFebeMYFPJ7rHSHrx5o=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NklQcWN4dGlkK0xoSDJ4RXRSOXBIMHh4TjRQTlZuWStvV2c1dGVub011eVBo?=
 =?utf-8?B?Sy8vT1ZQLzQ1N1plczhwRUxmMlZtd0lQcCtrSVg2ViswWms2a0NYUUF1aDlF?=
 =?utf-8?B?SldBTFlMdUJUcVE2eG1hNDkvTHJiSFJlbkgxUTJTQ2lCYTJDWGhwVkptU3ZZ?=
 =?utf-8?B?djRqQzk0UjZJbERQcUY3VmNqYnBnR1ZobCtqU2czYTQ2Ulh0czBZczhkTStr?=
 =?utf-8?B?RXE3T3NTdThORjVlRnZnK3BpdElIT2FjRFBSSkMxMlJZQStqdUZRbVNZZGhy?=
 =?utf-8?B?NjU1K0NDbytPRndDVmxVVkRZaXlEN0FMNzZ6cVVLOGRjcmxtWHNqTXh6VWNv?=
 =?utf-8?B?dVVKMjZCYlBCNUw0SmlZVVdLVHRUYndiWXpxRnFVTXl4WW9DV2YzcmZlUGln?=
 =?utf-8?B?U0Z0K1dPN2p2K3ZFNzVtWmt0TzV6a1o5S1dvVVE3SktXeEwza0FmZ3B0RXdS?=
 =?utf-8?B?ekQ1cTJDYzdNdDl1N0o3d3V1b2dwZjc5UHFKWGhSd2ZMTzlFa1RpcnRIN3lS?=
 =?utf-8?B?ZzJ2ditFZjh3OUJHelptdWJ2eU9ZZXVUSWxHZzRtQjQ1N0dhazNvSmdVbXk4?=
 =?utf-8?B?SXg0bEltZVFxSHZiSlZYMVFJVkc3cW94c1pyMjNlb0JndlJiQXg2dlo5SklF?=
 =?utf-8?B?eVdMNDFIOWtuamlrV1RybkdDQWRZa0Uyc3BEVk1rT3VJSml2L0tqSThpdWlN?=
 =?utf-8?B?b1kySzhPaVZ1NzN0anRRWVg3NFF5SVBCWktjbER3SG9iaVRub3pwNlp0S1RM?=
 =?utf-8?B?YUZZSFVoMUhMZXZNNjFOa1pGQ2Jzd1c4VkNHOWlXYlpIeHNveWdudFQ3alB6?=
 =?utf-8?B?QkluMUVGVE53WFBEYTNxU1NQb243YmRSNlJRUlBJMWZPcnE1d08wdmpUb2R5?=
 =?utf-8?B?UDJsdlQwSytkc0Z6UWxDNUZnaExzczJlRTRwNlJFWW5HVVZiTFVBN3Z4eVph?=
 =?utf-8?B?dnJpSnljT21qb09jd0F4L2lnazhHeStzVGpucFZXeFE5N09MYjRVQnhWOVRZ?=
 =?utf-8?B?ekxpYXRnSGZtdDJkS0V6SHU1RlRmTTR4aHI0MllocFd6VWJnSzRvaHNWWXZF?=
 =?utf-8?B?SU01RVd3WEVGRDBtTmNKQndnb3oyd1VFZ0dUS1JSMGZhNGRwK0FYTFVUWHIw?=
 =?utf-8?B?YkpnZ3pDNFdHTTBxM0FNSy81Rndoc09Oa0lNejF0TlE3KzlmUzhycVE4MEhZ?=
 =?utf-8?B?Y2owSDZTa1lNODJQN1dPMk1Nc202d0dFZy9BeHpkNi9KbUpUYkFHYjlZVmxH?=
 =?utf-8?B?Mi9kbnZxMnJ2aERDd1hPTU9iSndmT05IYkNqaTBsQWNKS0lCL3dpMDdkTVY2?=
 =?utf-8?B?ZGdtWlZnVDl2NlZqSEhtajNMOGdySE1xTzJDRGNzYTJoL2xIYnpSbXc3emYy?=
 =?utf-8?B?OS9oTmJ5WlFPUUlQM0tkZDJHc01POXVNOXBzMkUwcmdwZ09iNGZGeTRCcHM1?=
 =?utf-8?B?T0EwekhTVjBMaG5vYUI3eXJrUlBsVVo4Smd6dlErRkZIUHo2NTNpUGpmaC9L?=
 =?utf-8?B?eWhPNThjbk5vQmRONUtJMmxNZVd3ckIyT1F4WDJyWlRvb1hBNGR4K2luejRr?=
 =?utf-8?B?bXdWSzI2NTJlT3JnQlVzY3dYY0FjU1J6TnlqZThzd1hLZ2dpWnA1NEZxQ1Rj?=
 =?utf-8?B?UThkc09HeWhSa2dndDlwY2RpMkgyendva2RhK1BETlFaN25yZ3Y0cWZkdW1W?=
 =?utf-8?B?dWxhNWIzVC8zdG5mYjYrSmVBSmpPZHhkVUtnRFdpVFZqNzZNeVFGdVZuZHB6?=
 =?utf-8?B?MjVNQUNJaUZ4WmJNRllpM2tOSWhqemxwMFdGeThtMTdsZFFjRmVqdGowNmp6?=
 =?utf-8?B?azFYYm9VYm96dHdNa1dmZUkyTHQvNmI3amc4eU9wbkIrSW9HUzRhWkc3Q3p4?=
 =?utf-8?B?c3FvRGk2L3lQamRqa3R4TkYrWk1FaVo2WGRzWVR4MktTVUk3T2x2eVMrN0xT?=
 =?utf-8?B?ZEVnVXZNampyeVllRmV3WjFwdzhDeG96T21vcFZMRkJuanZENjA1ei9jSENW?=
 =?utf-8?B?RVg1S3FYR0VVRStrVkpWZVBadW12aE9PbHhOTTVWaXdoYjJDT2daS3VzcFgx?=
 =?utf-8?B?QnBLNWlOSVlDOXIrNXhmdWMrZ2tkRGwvRExLUGFraVRGdklVSFZOTG1zZEVl?=
 =?utf-8?B?eFVlc3RXU2JuVkExbUNLN3JzM1JWM1lDc1phblVDZ2RpSkZCZ1NMUlRPWHZT?=
 =?utf-8?B?OGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B16A1C0AE8831F4786C7FC403312E784@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FitgJirucoF3MvoYMxm6jH5Tye5+y8xqIw0xXPh8EUVFKAPiDZf6j51W3qwv8zpj+4r+ytmqxVidKgMV20mTEjspuG4a9LBae6E9gzw8rSO1Wzwwp1MQjSfhiS48i2wu5L9GRlWBW4ex/VB5SUkpjZQjb3VgyBdw+7R1tEfJVZy5l57DDUtn4VoDa5Vuvi7HSYArqaNcQEIvIrdkeVpj9RiG/sSs+VsJ3aE7xHoPoPcT/YdOI8qaorJXy/UYqAJkB/oNjMifyhu4YfO1YRKJoLdxN4RQTVHoUZaFSi8dg3lgZmWEo8R7XjdcjxQjBqwH3JgL5EKQqG8CQsooCY+N41E/FUppZK4fHVN2CdZ6xe+50eLcc9xksT0M+H8EBg0TUWtq1/rGoG2PzGR71GKe2LTMQhFHPv7djxjvIrp0XEBOHFeZZM/WYJmfvUtXpUP7QhZAI3bBoTdEvkDPp3ZUJMQyKhupGbQrPVu7iPGYYARWDYmwIEJx4KzdMxM0IARq57Zp4/4llZKVh6/w7eE8eslMu9zLWCzdp4o61RoQwnmY4TP7HVst3GnlsOXUR0kTB1gFP+o0Gn9NMcyUT0+rTi5f6ujYCNEkrRUNyXcskusxIlFImMvJb7UOZubgWgr7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e175a6-031c-4c72-ae3a-08ddc052ad57
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 08:12:28.4404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5HFMAK+xJOx5jsBGREnvBbbjNzvyxeRsBr3XHLtQ+t0bmT/F4MJwmn0Wqs+hSp7lqOTgEWGy4JGzArwOVbdNiVykAxRRTZu7P16KM7St4fc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6446

T24gMTEuMDcuMjUgMDk6MTIsIE5hb2hpcm8gQW90YSB3cm90ZToNCj4gYnRyZnNfem9uZV9maW5p
c2goKSBjYW4gZmFpbCBmb3Igc2V2ZXJhbCByZWFzb24uIElmIGl0IGlzIC1FQUdBSU4sIHdlIG5l
ZWQNCnJlc29ucy4NCg0KPiB0byB0cnkgaXQgYWdhaW4gbGF0ZXIuIFNvLCBwdXQgdGhlIGJsb2Nr
IGdyb3VwIHRvIHRoZSByZXRyeSBsaXN0IHByb3Blcmx5Lg0KPiANCj4gRmFpbGVkIHRvIGRvIHNv
IHdpbGwga2VlcCB0aGUgcmVtb3ZhYmxlIGJsb2NrIGdyb3VwIGludGFjdCB1bnRpbCByZW1vdW50
DQoNCkZhaWxpbmcNCg0KPiBhbmQgY2FuIGNhdXNlcyB1bm5lY2Vzc2FyeSBFTk9TUEMuDQo+IA0K
PiBGaXhlczogNzRlOTFiMTJiMTE1ICgiYnRyZnM6IHpvbmVkOiB6b25lIGZpbmlzaCB1bnVzZWQg
YmxvY2sgZ3JvdXAiKQ0KPiBDQzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyAjIDYuMSsNCj4gU2ln
bmVkLW9mZi1ieTogTmFvaGlybyBBb3RhIDxuYW9oaXJvLmFvdGFAd2RjLmNvbT4NCg0KUmV2aWV3
ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo=

