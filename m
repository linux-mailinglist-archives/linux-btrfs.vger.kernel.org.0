Return-Path: <linux-btrfs+bounces-9589-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D43179C6CDF
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 11:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABF83B22B44
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 10:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029451FC7E6;
	Wed, 13 Nov 2024 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="L76uPZ+3";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="o3OgeOIR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D08D1FBF72
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731493575; cv=fail; b=WmR+k6OtPm49IoTYqE7fq3QSgLdA8cHYIUVkpne3MC4Z8T6cbkzr26iuiFs+4oh3zDLsmKvkBCtf+pykkIgIv5PdoPe313DDPjPDztnkK+HwxQSMaYBl+XnRE/tyndmVvLYb3ki4jXZcBp37b4iKV9ZKjG06DJzqcL99CmjD60c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731493575; c=relaxed/simple;
	bh=RpcTcBYmAF2fZBmrb5zDcpyqF+xkzZvUxJOhnWVFzRU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xfk+yw8dd5XPkfOUfVzBjht6wS5wh+kaynsU85JKF9IlhqHxzrcvrBnJwy0rkJvm7e6TUp9FPOMnrkiOK+apykGfWFoekN6yhJe7bPSkBOuhVkBJBswV2BN5ridDHsdAhvUkbQiFMgfyYqYeL2m+LVjFEr5rZfR1XUD+bJQNIEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=L76uPZ+3; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=o3OgeOIR; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731493573; x=1763029573;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=RpcTcBYmAF2fZBmrb5zDcpyqF+xkzZvUxJOhnWVFzRU=;
  b=L76uPZ+3+I7FP6gZueMX1redPHrA11UUmPGpaUH1qyQjBe6A7TuII1lV
   rEu/Op7p0Kj6UYTyWeW50mFISa53gx2oM1ffvbjdGM0/aQda0CovjzQJi
   /hITcDWZugzzmWEwflrclH+h46wLfo0KNg8WYii4MhbZuW91KZLUUcgCx
   qiKqxENBeeW/X7u5u9XBYh3fcbHWEqloFwCLjDCAxeHqaQdHfg6f76DFL
   ag4gi/hFeYRDNPSA4QGtdzDHU0TpngH8z/f0wys0GJrMLd60cuV2N5U6y
   +ybn6wRDfZuS9hsggsLeMnn3RBK9ojdPu27MhJGEasXMNxQjgVJbgulhj
   g==;
X-CSE-ConnectionGUID: SVlOqqEYThajms4RYYaWzQ==
X-CSE-MsgGUID: u+GfRy/3T+GifNoSHXrbWQ==
X-IronPort-AV: E=Sophos;i="6.12,150,1728921600"; 
   d="scan'208";a="32368881"
Received: from mail-centralusazlp17011030.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([40.93.13.30])
  by ob1.hgst.iphmx.com with ESMTP; 13 Nov 2024 18:26:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LmLz2aDWvXVWEubqqsCJqZxehz0Ds/8VlsQ0pI1NTLW6CSf113PFWY2EYqadac43wouQrOlqXhTzyeO5Quty1RKrNGzp/cFTdc6FaYAe2ZiVIqglEiFKwOkfQ/nkTI1n/31E9UmaWw26PAdX7vSHMDzT/jAaXveb11h4H/bwE/kYsOkZSJfUVtyNP1ko9PlUvXmNY5mV5yERsYiYMZY0oeVDLOvTehzgwiQbVZ3CjJv5Bn5Q56NyEmqnelTrUjKexTmYTZkmASkRYfKTNi8hRXD3f48Un3ApEMWHUAPIlbN4iYxwwRBKDdqAUBtG2yYlk+kYOznDt57F3lnd5hOZrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpcTcBYmAF2fZBmrb5zDcpyqF+xkzZvUxJOhnWVFzRU=;
 b=hZqXI+sq+o2fnMb102HU+tAPVbQSX9aVDbrlSbVU0ISBJ1UYF4f/ucnsjJ1uGy5S39PSfZ6ODNIBA6pa0E3PKtiN8bGthwfd9WFdpj3x3zecc0c1HKXbx0HDinxqvnxJKex3NlKLwnTMN/l9xn3J0IISFIwsOL8f3bMwRFLRfmgNg11DeCPK/ypK31k/wR41onwYt6LUNkvtbLds2lSex+iGHQVPrNislGi6eZnRKcZI9bQBPIOv+HU8v66zYI41gtWvDRtCrGugAm/q8L9VMpMD5lsS5n7ZNzQLDMEO1iLNboFfWn7hGYpxy6ZUiu00ChcgEM3fJ8KIU1u2dUx7iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpcTcBYmAF2fZBmrb5zDcpyqF+xkzZvUxJOhnWVFzRU=;
 b=o3OgeOIROPm1K7jorcsswI5wn9mwfVszu2wSy9OrVJ14ERC5rgxGurBczViiRmX+exr1QT0CU2b+epgCOsmDnTQPZGV+h62yn+/QgXcqLRyYRuUIorIvgAsGEa1h39qQUzkZ9rzA9a4SQ762Yce9GQYL9GNyCzEiytEyRnnXk5k=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO1PR04MB9628.namprd04.prod.outlook.com (2603:10b6:303:26d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 10:26:10 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 10:26:10 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Mark Harmstone <maharmstone@meta.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: fix lockdep warnings on io_uring encoded reads
Thread-Topic: [PATCH] btrfs: fix lockdep warnings on io_uring encoded reads
Thread-Index: AQHbNRwgBYJ0fl0B00KKEqkmyR8yWrK03+mAgAAiUoCAAAB2AA==
Date: Wed, 13 Nov 2024 10:26:10 +0000
Message-ID: <4a060447-2726-41d1-8199-bdcf4105c22f@wdc.com>
References: <20241112160055.1829361-1-maharmstone@fb.com>
 <1c919f94-83c4-421c-8ad0-e0c8da305cff@wdc.com>
 <1b224872-bd05-400e-95fd-2c54e3b5fd1d@meta.com>
In-Reply-To: <1b224872-bd05-400e-95fd-2c54e3b5fd1d@meta.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO1PR04MB9628:EE_
x-ms-office365-filtering-correlation-id: bf23b43e-bfa4-4c18-609e-08dd03cd9799
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YlJPRVF6dWxpeHRnZWhwWmFGbDhsY3JJRmlKTTRGZ3F4SXdjUUg3TWdDWnZx?=
 =?utf-8?B?RUU3R1lxd0src0srQk0yZk1nb1V6alc4YTIvb1ZyYVdqaGE2QUE5KzBrTVJw?=
 =?utf-8?B?dEh1eXM2dDR5THNlSFRVOXJYZXZWajVsTWk1QUVxVHZrNzBPNWVVUHk4amxF?=
 =?utf-8?B?ZitSTExVcnlLUVpPY0taRG03dFYveStLTnFJSWxRVjlmNnpzY2J4LzBaU3li?=
 =?utf-8?B?U2tKcjFtbjFDTE9PMlpwaDVqZmJESHVKU1pMenhjVFZrbnVWRnZhWTV0Mzc3?=
 =?utf-8?B?RUJlWHcwVVZwZmpDbFBtNHcwK2lrTEVpaTdzOHpEdWJDRzhidlRWSXJGcXBn?=
 =?utf-8?B?dUIwV0RKakVkY1ordmh2c2ZDZ0xXNUR4d2dLY3UvOU85cWE0aWFHMTAweUd5?=
 =?utf-8?B?MFJzd3M5djRrNzlTMExWdmdXbTZHRVRsdVBQaDlUQjNSam80eVlmVnpXUlFL?=
 =?utf-8?B?VzNqRTdSNm5XWldaRUlvcTlTem90K3J4TTZvM2ptTWtVYjZQWDF3QVdOa1ky?=
 =?utf-8?B?cWw1Vy9yd0NBSEFFczFsTlhYMG9SZ0hrTDdTcTMyNDVHOVdrM1hoTDQ2ajFC?=
 =?utf-8?B?RERyUXdneXdaZlIvaXRwZmEyU3N3RzNvcWZsU3lwbHg2bUVYMkFCems2QkNu?=
 =?utf-8?B?UXgxQ1ozUlQ5Z0lXSHVxK1dnUGdxaGp2UlpMODdXT1BBQVZMQktvYWhkNUU1?=
 =?utf-8?B?VjNWcVRNR3dncFB5M2NnemkwNE1qektRR1BjRm5HMW9LUExEZTYwMm5kaE9u?=
 =?utf-8?B?a3ZFb0JvcW0zcldVbUZtMjZMWTd5b0FsRytIdWtaeW92YVFHQ0orektkMFJ6?=
 =?utf-8?B?cUxac0dHTVFKTnY5KzhZeFJ4ck5ldGllQnpiVjdVczZhdWQvcjhwRUh6MDAy?=
 =?utf-8?B?b0xVcUVSMTdoYkUwVkdTRzM4V3pDQTBlQjRoMHRxazVYbW52YmdsUHhGckl1?=
 =?utf-8?B?dy9USkFiWW5RK250NndjYzlxdlEwVVB4NXh6WnhiMmhiNlgwa1VZbm53WDRh?=
 =?utf-8?B?aFhXN0hVNXh2eWlhTFFaVWZyZlZiNEExcTA1R1FPUjRxdFNJVDdLakpjQVBV?=
 =?utf-8?B?QjlIcWpMVDRCRnF6QnJFOVpWVGhRajhkcjAwUExCclZnc0V2bjYvbmtnOXp2?=
 =?utf-8?B?b3QveVh5MW5OYXRLWmxFTVh1TE9zUzNDZUZDcC9KQURET01PMkg0cHlYN3Vh?=
 =?utf-8?B?ekg3NEZwNCs0V0ozVkNoRC9idGVlTldwZWZNRmk1ZG9TaWZJMDhPUS94MHYz?=
 =?utf-8?B?QzBveU1tMGM5UnQ1dWFyUGJMbUFkTGFCNEwwUnFadEkxU3NUYTBUVDVrbk9j?=
 =?utf-8?B?ZFFJbWdGQVM4UkUvT2hvbWQ3T3JiTkNvOGFNV2dsUTFjWTNHeXpvbGhoVElW?=
 =?utf-8?B?eDVFUHAxTk5Wdm9xdE5IdVJTcEZOcTkrVXdqeUFLRmdBR2Z0bGdTUnpuNUtu?=
 =?utf-8?B?bkdtamM3dDdLakpDNytqZDlnR3ZPTTdyUFhpN0RUMmlJY3F4N0srb0FCM1Vh?=
 =?utf-8?B?clkyVnp1Z1MyZk5mMENpTWNHOHJhaFFJQnBLT2w4LzNaVGFVcitvSHVUNkdq?=
 =?utf-8?B?ajVLZllCT2JJMENBUUpYc0JFZi9mSndnOUpDblBDb2FIU1lQTkU5Ulo1Mi9P?=
 =?utf-8?B?c3RuYlNKeTNMbGJITUNFWXJrNlpFRkwzZ0JaQXlrZFVsNE9YT1FENUI2c05E?=
 =?utf-8?B?blR0WElxMlBVMjRaaXhFZnJYQ0tGa2RoYjUzUVV1OEYza0U0UFMvY0g2ZEVP?=
 =?utf-8?B?OC8rcHphMWdwVkY4VFhyc3UvRTBRQi8zVjIrUW9aRjVtZXc3dldITGpOV1pP?=
 =?utf-8?Q?ZV0Rnh6To1MzPpeelo+FD8+m81OAOg8dcWZ9Y=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ek16b3N4STNadEc1bURBU3FpNFVWMi9YRjNpVEl1dVl3R1dlWjNVa2NQSEpk?=
 =?utf-8?B?REo5U2xYNU8rUzVVeGRmUFYvTXRBenJnMG44RHlZSkppZmprN2pNZU4vSmhO?=
 =?utf-8?B?M3gwQisyTDZrdVFPcS90MXFEZklhbkc0WUFmRVY0eXlYQ2JEK2FCMGRRWVNt?=
 =?utf-8?B?NXNpcnVVaHBqZkRoaDJQK0VlWUpveEduM1kxdXBMNVRpL2htT0RKNWYzUE0x?=
 =?utf-8?B?QUdRa3lMelFpSXhPbEozNlFrVmc0cnJzc0ovSjMzcHRqc0VXcjRGcEQwNFpD?=
 =?utf-8?B?WW9JNlJkWHhIUnRrOGVORFhiWGQ2NWRhZ29zRFNqVW9GREp1ZzRJWVR3Nk9J?=
 =?utf-8?B?bkJwZndFMFBUb2NhNE9HdDZrdFVUdXlhWHZNOTFLTnhlVzloWmhCUnc3U2Iv?=
 =?utf-8?B?QVo0MVNBWW9jRWNwbG1WTnVxbWpMK0NTbUFLNnM1anMxOCtjOVo5eWMwR1ht?=
 =?utf-8?B?Q29ULzRuWDBzZ0xndVpVbEJZL0J0TFdPNnRscExoM2lQRitjbHdmNEFtdVI2?=
 =?utf-8?B?MDU4Mm1Gb3NISEtTRFF3cHRwU1lnUURnQTUyY2l5S0pZb1dITnJvY3I3SlNP?=
 =?utf-8?B?YXRqYjlGTWdldHM5YzExa0xxbDFPOXpDSUdaekRhdGFNVDZMSG0wZVprbzQ1?=
 =?utf-8?B?UGlwdGNtQnc5WmRtYXRJTFowejZyRFNKNkxUR1dDYXdCNEx4T3dEYXRVRVNo?=
 =?utf-8?B?eHJFYUJWbWVQOUY4SkhEWjlJYmp3WUkwR1BwQTA2SUc3UHBHZFBVdG9jY1BS?=
 =?utf-8?B?TWVuUWREWFVrVkhHTDQvekpJcFcrWDI3RmVrWm4zSGlMdTdyV2xwemlhMFNS?=
 =?utf-8?B?Q1BSNExCZi8rbkVlTkxUZ3QyT25HZlJGeCs1dThYWENHN0ltQkxCVXJYeWlN?=
 =?utf-8?B?ei9Db1lUQ3ovTWtVV0hjRFhCc2JFQ096TWxBYW5MckZuYkJNZnpVb1p6azhF?=
 =?utf-8?B?TmorUjlSdzhYUXVIWVJvNFlsc2E5WDdhcXpyYjRHS2psQ1o1SUFadTRiZ3Iz?=
 =?utf-8?B?cHBjQmpxVkxxdXZkYVNkeVdLdjllQWQxeXhXNzNaR0tkY0R2YkdoWis0b2NU?=
 =?utf-8?B?ZHdFWktHQzJFeXdvWEViRzNBM1QvM29jN0dEaExiUWNaeHg5ckQ1bHBmSlZK?=
 =?utf-8?B?cUhxeUlTTTdjK3BMUG93NjhicEV5cDBwM1B6T1lwd0dGQVJmNUVCRUVDUDFm?=
 =?utf-8?B?djdlOGlNdzJRRVpJSXhZVGtjb1BtdzA3UWJVbmNQNnNRYUV1ZTdVaXB4QzJS?=
 =?utf-8?B?aDJxUk1XUjlMUmlIV3hUT0dCZnkwR2pLRE5YVTRSa05KQ3c2ejcxekN2TjYy?=
 =?utf-8?B?WWllZ2ZOeHJhT2xRTkRCQXBsbmlxblRjYS9PQmwwQmFiT1FmaEtxSTFaYVVo?=
 =?utf-8?B?bGFxd2IrWGc4T1crM0dzMnVmZWxWUjhYeitPVUpLSHUzRFZzK0g4UitnZ0ZK?=
 =?utf-8?B?U29HV2RKakc4YnY2MExlQzdjNEdIcGpIWEp2aTBoeG1HM2ZtT2Jsa3VYT1pX?=
 =?utf-8?B?T21hdmJnUUJkOW1NL0duVk0zMnZnT0M2RlBBNHpMWWRNcXRIRVNzeHNlS1lp?=
 =?utf-8?B?Z0VqeFZnSzNFWitUMy81NlBEOVRRUzREMjhDM2FqY1dhUFQraXZKTlZOaWVZ?=
 =?utf-8?B?cFNmQnJuV3JmdkJzZS9MVFUrajZsYUxQZG1hWmIySjQvZ1J5QzJ5NS9xbDJr?=
 =?utf-8?B?c2ZueCtKaFpJMVRqQnRUdmtPODZReVkxR0RpVExHNE1hZVkrYVlyNEMvSDlU?=
 =?utf-8?B?NU43UFFGZ1E3bFpFem56MlRYeDZqZWdoSnVTNGNCVFBwbUlyZVJwNDExYWd2?=
 =?utf-8?B?b3NNY3ZBWkJoUEpxSmFONGNrVjRGUzNYNzZkN3V2V1MzZkluY3Z1YkxXN0hm?=
 =?utf-8?B?V1JmWUk1VS9HQVB0cmVQaVc4clUyVVI5VlF3aEVHQkJWOVhxeHRzOXZSdTRu?=
 =?utf-8?B?dUk2Z0FjSzlmRnpmNndlUWFEVlhkU1k2Y1ZkLzNyZmlrajZDWE8rRGxnOW5T?=
 =?utf-8?B?V2R6QU1nUXEyMTNsQXE1RW1iMGkzdkFSUXdqNjZSM04yZkRMakJhYzd4SkZs?=
 =?utf-8?B?OUlkR3JIUFB1ejVtQUc4N2NxUlU0clFSZHI2TVhNeUZNSkY5THF0ak92V2NS?=
 =?utf-8?B?dUpQL05hYmdlb1NLbkZiV0R1ZmNuSnBDdmFTN29EbXUwcUVDTi9YY0tjME4x?=
 =?utf-8?B?RWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E0CA5479A1C504B8218662D64365395@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U9t7aXNZ7ywVpNrwIXwRVnIWOUGK84ZlyP9MTq1+irX7sflHmo8iLgMEO8bWJNUOf1uf4qvVysF5D915HForh8SavqeQpU79mM64ofjUv4+9NErnJ1qGQs61QSSK7RqBYrp0bs7x/ao+5uBLaUYGMV8NtAd9KW+03Yfwr9nXhL2NmpXGON0GkYmKuNONBT0jYQr/LUQnm5/QZoqT6bKPbKmZ9Be1Ll6qZ6vI1V3szIooRE0lNEgTjarR7svpZJmYywX1de8zvJkbALGfAObB6dRvbBLWsvqPf7dsovUv8UIOhI4FfKMaGzAoRR6SZlLjAl9vZUdIX9Qtnv4ZlsqG+12gvaQZIwSRtBFsD6kuoGPvPKwWKVFmm4MhARWkoWAvIlPj6YhujYt5yJUDJYdJ+xVTpJZIj4jP3fJQ58FV2k8h2LvjBVwgr3vyTo3x+jTYROn2O2ClpIiDGVzp7d4ysqraBRfqAu6RcVGcHAzzSydJHeX0WaTPQIhHAzt/IlAPPErACVPezy03HeHAhJZ8t8B4zzw7wttQaEuxbJYBvZmr8l7kQ5r3+4UGZQerwVON3G3/iXZKL4b6ZwAycSn+jusf41zbbMVTzGTpKMB4aN6JjV6jUxKDaSAL8VTz4psD
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf23b43e-bfa4-4c18-609e-08dd03cd9799
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 10:26:10.2957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PaeXAs+zRJAuytz/Q8sk62asnBXYesAUIBKDsGOam5zDoTNxyG7CYc1ELP9oOdrfYEr51XOo6gsAZtafOglFQIl8EC38xQIpJBAtl8IMSzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR04MB9628

T24gMTMuMTEuMjQgMTE6MjQsIE1hcmsgSGFybXN0b25lIHdyb3RlOg0KPiBPbiAxMy8xMS8yNCAw
ODoyMSwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4+DQo+PiBPbiAxMi4xMS4yNCAxNzow
MSwgTWFyayBIYXJtc3RvbmUgd3JvdGU6DQo+Pj4gTG9ja2RlcCBkb2Vzbid0IGxpa2UgdGhlIGZh
Y3QgdGhhdCBidHJmc191cmluZ19yZWFkX2V4dGVudCgpIHJldHVybnMgdG8NCj4+PiB1c2Vyc3Bh
Y2Ugc3RpbGwgaG9sZGluZyB0aGUgaW5vZGUgbG9jaywgZXZlbiB0aG91Z2ggd2UgcmVsZWFzZSBp
dCBvbmNlDQo+Pj4gdGhlIEkvTyBmaW5pc2hlcy4gQWRkIGNhbGxzIHRvIHJ3c2VtX3JlbGVhc2Uo
KSBhbmQgcndzZW1fYWNxdWlyZV9yZWFkKCkgdG8NCj4+PiB3b3JrIHJvdW5kIHRoaXMuDQo+Pj4N
Cj4+PiBTaWduZWQtb2ZmLWJ5OiBNYXJrIEhhcm1zdG9uZSA8bWFoYXJtc3RvbmVAZmIuY29tPg0K
Pj4+IFJlcG9ydGVkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3
ZGMuY29tPg0KPj4+IC0tLQ0KPj4+ICAgICBmcy9idHJmcy9pb2N0bC5jIHwgMTQgKysrKysrKysr
KysrKysNCj4+PiAgICAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykNCj4+Pg0KPj4+
IGRpZmYgLS1naXQgYS9mcy9idHJmcy9pb2N0bC5jIGIvZnMvYnRyZnMvaW9jdGwuYw0KPj4+IGlu
ZGV4IDFmZGViMjE2YmY2Yy4uNmVhMDFlNGY5NDBlIDEwMDY0NA0KPj4+IC0tLSBhL2ZzL2J0cmZz
L2lvY3RsLmMNCj4+PiArKysgYi9mcy9idHJmcy9pb2N0bC5jDQo+Pj4gQEAgLTQ3NTIsNiArNDc1
MiwxMSBAQCBzdGF0aWMgdm9pZCBidHJmc191cmluZ19yZWFkX2ZpbmlzaGVkKHN0cnVjdCBpb191
cmluZ19jbWQgKmNtZCwgdW5zaWduZWQgaW50IGlzcw0KPj4+ICAgICAJc2l6ZV90IHBhZ2Vfb2Zm
c2V0Ow0KPj4+ICAgICAJc3NpemVfdCByZXQ7DQo+Pj4gICAgIA0KPj4+ICsjaWZkZWYgQ09ORklH
X0RFQlVHX0xPQ0tfQUxMT0MNCj4+PiArCS8qIFRoZSBpbm9kZSBsb2NrIGhhcyBhbHJlYWR5IGJl
ZW4gYWNxdWlyZWQgaW4gYnRyZnNfdXJpbmdfcmVhZF9leHRlbnQuICAqLw0KPj4+ICsJcndzZW1f
YWNxdWlyZV9yZWFkKCZpbm9kZS0+dmZzX2lub2RlLmlfcndzZW0uZGVwX21hcCwgMCwgMCwgX1RI
SVNfSVBfKTsNCj4+PiArI2VuZGlmDQo+Pj4gKw0KPj4+ICAgICAJaWYgKHByaXYtPmVycikgew0K
Pj4+ICAgICAJCXJldCA9IHByaXYtPmVycjsNCj4+PiAgICAgCQlnb3RvIG91dDsNCj4+PiBAQCAt
NDg2MCw2ICs0ODY1LDE1IEBAIHN0YXRpYyBpbnQgYnRyZnNfdXJpbmdfcmVhZF9leHRlbnQoc3Ry
dWN0IGtpb2NiICppb2NiLCBzdHJ1Y3QgaW92X2l0ZXIgKml0ZXIsDQo+Pj4gICAgIAkgKiBhbmQg
aW5vZGUgYW5kIGZyZWVpbmcgdGhlIGFsbG9jYXRpb25zLg0KPj4+ICAgICAJICovDQo+Pj4gICAg
IA0KPj4+ICsjaWZkZWYgQ09ORklHX0RFQlVHX0xPQ0tfQUxMT0MNCj4+PiArCS8qDQo+Pj4gKwkg
KiBXZSdyZSByZXR1cm5pbmcgdG8gdXNlcnNwYWNlIHdpdGggdGhlIGlub2RlIGxvY2sgaGVsZCwg
YW5kIHRoYXQncw0KPj4+ICsJICogb2theSAtIGl0J2xsIGdldCB1bmxvY2tlZCBpbiBhIGt0aHJl
YWQuICBDYWxsIHJ3c2VtX3JlbGVhc2UgdG8NCj4+PiArCSAqIGF2b2lkIGNvbmZ1c2luZyBsb2Nr
ZGVwLg0KPj4+ICsJICovDQo+Pj4gKwlyd3NlbV9yZWxlYXNlKCZpbm9kZS0+dmZzX2lub2RlLmlf
cndzZW0uZGVwX21hcCwgX1RISVNfSVBfKTsNCj4+PiArI2VuZGlmDQo+Pj4gKw0KPj4+ICAgICAJ
cmV0dXJuIC1FSU9DQlFVRVVFRDsNCj4+PiAgICAgDQo+Pj4gICAgIG91dF9mYWlsOg0KPj4NCj4+
IENhbid0IHNheSBhbnl0aGluZyBhYm91dCB0aGUgY29ycmVjdG5lc3MgKGFzIEkgaGF2ZSBubyBj
bHVlKSwgYnV0IHdlDQo+PiBoYXZlIHdyYXBwZXJzIGFyb3VuZCByd3NlbV9yZWxlYXNlIChidHJm
c19sb2NrZGVwX3JlbGVhc2UoKSkgYW5kDQo+PiByd3NlbV9hY3F1aXJlX3JlYWQgKGJ0cmZzX2xv
Y2tkZXBfYWNxdWlyZSgpKSB0aGF0IEkgdGhpbmsgc2VydmUgdGhlDQo+PiBkb2N1bWVudGF0aW9u
IHB1cnBvc2UuDQo+IA0KPiBidHJmc19sb2NrZGVwX2FjcXVpcmUoYSxiKSBjYWxscyByd3NlbV9h
Y3F1aXJlX3JlYWQgb24gJmEtPmJfbWFwLCBzbw0KPiBjYW4ndCBiZSB1c2VkIGZvciBzb21ldGhp
bmcgbG9jYXRlZCBhdCAmaW5vZGUtPnZmc19pbm9kZS5pX3J3c2VtLmRlcF9tYXAuDQoNCkFoIG15
IGJhZCwgc29ycnkuDQo=

