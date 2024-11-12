Return-Path: <linux-btrfs+bounces-9507-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CF39C5261
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 10:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76E181F2283D
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 09:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFED20E337;
	Tue, 12 Nov 2024 09:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="e2MPDMRQ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rZ119uer"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F66320E314;
	Tue, 12 Nov 2024 09:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731404865; cv=fail; b=a1tNnXG6N1saeOJr3+9CJmLk/Yjb/sv3/eiXFQYYCM9u4BGYuzKXiRFyaYRymwOQLO6clyLzmL64nRphXWKD1OnGY8UnSoKmWM0uT0ylBZxNaVPj6efSLLxXcW2oaRAuxVz/jmQSKGt4CZFZm/dt38QCFKuxNBR2U3FulutwdqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731404865; c=relaxed/simple;
	bh=qrIeU1B32typYxrLBGMZhttlLdYjpyIPU1Uuzjk2c6o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MCKTBBWh7+KoSxkzi2pMjPczsuql8tgh8i9zlBI+491WIUNJxmfmBGIRQ8cUhE0x8SBTz4NJ7dUh+A441y1snWZSt/q6IhycWFcP3ahxRmYBs4d/ncqPEnd02c3RleSgAAzrLhgIdzqMS7YJNuKyf209+tG1tl8w4jXWTkuFTmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=e2MPDMRQ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=rZ119uer; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731404863; x=1762940863;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qrIeU1B32typYxrLBGMZhttlLdYjpyIPU1Uuzjk2c6o=;
  b=e2MPDMRQH7pwX5COd4+qagOCtb+SFsY+AGbhRI7EEldhNjxjs1Ku7Rzc
   JXvhmBTRiljq5j598MOn8ZH2k3CpM5IUqn4U3OjvHJs1mGLY9H/rPMBa6
   H5FWUk9zQQzlogu8aUa3AOS85bPu13SUd9StVbyAkavrpWdDbYFCphLwU
   zrHwjQX/kOO8ZK6bm9Vcpg7KOFuWTBZjzsmsR/jXt+5YQ0BqRwqCguZ97
   rabJQi5ICKiQsUkV5znuaJjm1ItkFLAPj6mffar6Dpw9gMdaglfSRa0tU
   nfg66OI3sYhDmwuYWmIwCMbE/+miwQwv29rlo3uTAQ3X7GnGHszdBGp0Y
   w==;
X-CSE-ConnectionGUID: SvtQZW3+SlCr61//I7izUw==
X-CSE-MsgGUID: tESh2ItSTbmTFlF5IkDjaA==
X-IronPort-AV: E=Sophos;i="6.12,147,1728921600"; 
   d="scan'208";a="32263055"
Received: from mail-westusazlp17010001.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([40.93.1.1])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2024 17:47:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=onLG06M5YDmdDhcRR9oelkB2bSQqljjTfCNDcgQdJVDAPQXQap4FgWOL3D+/aR44dNnyubPVMt6p4mS6N5815CYEfsTXzD9dYwCg8iENUvB4Y+teoEnEyWjgNvJWdFHJAT4C46EofuFaP+SS1Lal1rqFb71KGDk3CloADHZ3GIP/6dbR3NhibxvgfLH+I/ozljT3ARmqvSr82inAky+WzaGerK5IN5RiVvH36bFjKuzm4FWHn8Zzz/7fMgSB3CplZUgByMQPsOwQVWvkp4y7iFXjz0oUcgCuHBRf+nRpMNXTGzIEVAkZ4cUmZK/owcemJWZdl2ONv9T4Px8/mDRZyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrIeU1B32typYxrLBGMZhttlLdYjpyIPU1Uuzjk2c6o=;
 b=rcswQVo1aDFHaVFbsmZx96+mWFvntxH+3Jy8ZwchYvu9nONthkEahQE6WA7l+/Jc8RAkZJQNPrS16zRKkOWWjfvu+wvGfhUDCvotFe8YwV2eU+P02TALwFPBfrQbXgriGR7k5i+h2TwKu0M9pLs75AJ/ZZnV5evBBuUZOCWy4KiM+dsiPQJrTYccfT/xotyOKPIsjmXUro2QKjbvoga71EKirLTHJMhLXRmKcskqVZqHiPIuxApKa3XayYewG/Tj7tcoV+7ZelAlL3b5ojDCX1z4YPbKoGhoLhH6dLwK1b+zoKfJhYMXe3gcvj7s6Xeue9gVrwPIfNA2hKjLHp3A2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrIeU1B32typYxrLBGMZhttlLdYjpyIPU1Uuzjk2c6o=;
 b=rZ119uer7fX1w2CB5/yOZSkIL/xdZg8PUeorSRPK8fezlHXqolVaSesXUuBRqQ2CE1NrPZDdt6AHnjyEUYknrM8ag/tkEILO8tiQbaOsiFf7P54zwO9pkrZaCGpvSZuepaxSJhzG7gr2Hu/Ky73D3N2UmzcSq01kaHlyiVWG4eM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB7635.namprd04.prod.outlook.com (2603:10b6:303:b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 09:47:35 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 09:47:35 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Mark Harmstone <maharmstone@fb.com>, "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: add test for encoded reads
Thread-Topic: [PATCH] btrfs: add test for encoded reads
Thread-Index: AQHbNEniaq8NpBtZMEa4JGq7F4qOsLKzZzmA
Date: Tue, 12 Nov 2024 09:47:35 +0000
Message-ID: <c9c316f1-3e77-4c74-9f6b-b74e39a051b2@wdc.com>
References: <20241111145547.3214398-1-maharmstone@fb.com>
In-Reply-To: <20241111145547.3214398-1-maharmstone@fb.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB7635:EE_
x-ms-office365-filtering-correlation-id: 81d4e6df-fba1-4579-f952-08dd02ff098d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UmpoRGpmTXFCTXJZTW1HN3hpSjZKcmZ0eWd2Zy9tRWFHQzNieHZHRWZ4REJ6?=
 =?utf-8?B?ZWtXOVhZU2Rwb1RmQkdZa2NBUzd4dkhYQkdhbjlnZVpZaXRQbWdnSGVNRGNR?=
 =?utf-8?B?MXR6MytxZW9yTXdxZnpiZEZ4TDJ5SUQwQzlBdXpONkFRVnNhWlpia2xxREZH?=
 =?utf-8?B?VXFrY3FUV09ZcU8ySjJwTklrWTBsazJLczU2QmRvWVZuSitVckJkemJXVDgr?=
 =?utf-8?B?ZjVMVXVpSGtwOHkzVldiU2dKZk1mQXc2TjB5cWdDV1NEZC9FZ0NVWE1jR3cv?=
 =?utf-8?B?ekZqY2FzT0ZEN2VId2tLOUlleUtkdTNGQlNGR3FwcmNGZmZaM0s0d3ZqY3l5?=
 =?utf-8?B?amMyb2dxNktWZDl3Q0U4ZmlRYmFSWlRyYlNRNjRnV0VFSEVXcVdOU3BSdnVD?=
 =?utf-8?B?Q3hCRnkySktacEV6Vi9CQlloNmN6VEpDSUUwQi9mRUI1VVhwUVhHWE5EVGww?=
 =?utf-8?B?dkRmOWhLZnJKT05iVFRwM1R5Y1E1aEdHYncvWjNEanp2YzFwNkk1c3pVSDQ2?=
 =?utf-8?B?U1kyVEhoZmhKVmNCbVJTNkswMWFOVEpHKzUxRlpWY3Jia3pZT1kwZVB5SHJ4?=
 =?utf-8?B?T3RWOXlNakhQdWt4N0EvMm5nNTUyRlU0cngrOTlSSmFnTlcvanZNN0d2SGhx?=
 =?utf-8?B?bTkxSU9EemtYdmh3bCsvOUJBUzhnUXNvNzdVZWJzeEh4VG0yNEpkZ0VFVXJq?=
 =?utf-8?B?STVXODhvemVoVFVJcVJBcUVIMG5LOHpBcDNvS3FLUXlsZW93TzFyb1ZlZHRS?=
 =?utf-8?B?Z3JTbTlRTGZOSXBHbmg3SnoxVU1zN3didmN4dDlFQk85RnpBOVd0enVuWkFZ?=
 =?utf-8?B?dVl6L0psUW50UE1vTWJnVWo3RnVuM20xanQ2S0FiUXdkbi9yTVFSclU4Q3RL?=
 =?utf-8?B?czhlNWhtUUdwME1kdDFEZTV1RkpVZFRwRGUyWDNuUEJMT3BzS1NabVBaY0ZV?=
 =?utf-8?B?KzZUVjlrdUNPUDR2bmJKazNkcHBmcTNJbVZYRVdJcjk4YWFJWCtnNzU3aW1l?=
 =?utf-8?B?blkrRUlWZDRjdTA1Q05xMkpNMEQ0em5kZzhWWHladkJ3UFh5MU11ZHlQcDlv?=
 =?utf-8?B?VzY5Rm5ObldWdjVvUzQ2UzJOVTZ6SGtuNzk0UWFZd0dyZ2oyRm5ZNlp0VGxO?=
 =?utf-8?B?RHQ1SmJEejh3OTNUcFUwMm8wTGkrcHB6ZE45RVExMlFSOHkwT3ptWkw0VTR3?=
 =?utf-8?B?d1cwQ3JFNUNlQjBxRlhrQnp4YSsvQUhEV3lZSC85OHhEQ0c3WFpFZU4wMDRn?=
 =?utf-8?B?WWJDYk1aUE9SRHd6QzVkYnNIOTQrUEhNV0RCWXAydHVtQlZicjQ5RXhjTDBY?=
 =?utf-8?B?VTJsZnA1NVI2WFNPSXhUQUJLSVFLNWprdlUwQ2pVc3hpVm96dG0zTDlmWFRS?=
 =?utf-8?B?MUJsZnVTUERWVXdqbkl4M3pQQmdaN0pvNW5VVmowUis1eHBRdEVCQ1dCYUNX?=
 =?utf-8?B?TlphZUR2TlFFL0dZZE51bmUvR3ZZVHJiNkUvVXAwZ2twdnQzeHpNaUdFcEd3?=
 =?utf-8?B?NmN5azEwNGY3aDhYMDF3cm9xc1d4U0tvNkFvVGxnbzBLRGJJamlWZkIxcmRn?=
 =?utf-8?B?eDJ6aXIvU1hvOFFFOSt0UUh1WEhqbUNmRFZRbElpOFYvb0FKR3RKL2M0bGcw?=
 =?utf-8?B?b1U5UGZaWGlQUnh3UUM5a2QzWklucTRramRQVHNQTTYzRGZXb05wZjBFTFB3?=
 =?utf-8?B?OVFibVBBa1RxYy9FcXVwR3pmL25JK1p4TjB3aGJjK0xzelNqdXRuTHBGMmU1?=
 =?utf-8?B?cTJlSjZQbk1wNlQyUTBZeCtzSWthY1MrK3VLUklnZUxqTFdpOGJQTnFGWHZQ?=
 =?utf-8?Q?WDnsj2qhfgvFOj+x57xBtEunfa97U79p8y0Vw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZFkxR3FUQkZOdmkxYWh3eG5CWDNKYmZHUElidzFrVzZXL2hnbW9zS2NyamJK?=
 =?utf-8?B?NjJ4SWI5QWpvSzNUZ3FWZmNlUUQ3MFNmVFBnM21FMzFVdkRjbXluYk5XZTdX?=
 =?utf-8?B?emI4ajdHbkNNMWhka1JWcHNZVFZSelVOcFUyQjdURmdSRE00aXFaODBBRFI5?=
 =?utf-8?B?WEdaT1JQNHYwWXFUZ3VnMVpRMUdBREhrQ1hSaFI0ZkphMnpHUS9nTzVJcmxG?=
 =?utf-8?B?TEtaMEFSQVh3U0hGV2FJN2g5dGNiWENKK1RTWFluRGRnQnVFdGQyT0FlbUlC?=
 =?utf-8?B?UDdHV2VMMlFyeEVsVWs2bnBwdjI1RGZHNUp0T0ZuL1ZvdjAzdHJuYjhrWHV1?=
 =?utf-8?B?ZW14MzNQY3VabWRjTU91amdtdDl6dmhiVFlSRU5QakJEem4wVGJ5NUg2TUtr?=
 =?utf-8?B?ZTFteGlrVXR6b0sybTNjN0U0Q3lSczIrV0JqQWR0ck1mY3grRHdzbk5xUGdm?=
 =?utf-8?B?Tm5NMTNrcmNHdlZueWxrL3JIWjVSeEp2NXh2QnRxRThRV3JQZEN3S1pQWEZ2?=
 =?utf-8?B?ekJYeWV6OXpHZFF0dTVMNkdMV3d0K01pWk1MOGxqSVloTHZheE5VdW5MWlQ2?=
 =?utf-8?B?cDFpWWVkQ3ZHU2ErcGd6ZmxiQXhQRGR1YU14RmJKUEZaaUVQcWFrWTlRS3pM?=
 =?utf-8?B?MjR5Tm81UkVEajZ0ekpvVFRjS2dTOEVoNWc0bDYrZ1dsNDlMdEk0WWhzUU52?=
 =?utf-8?B?NkJabk1rMFA2TlozRVVLZm9EOW9ZcGlKSlZGQ1lLVlRFaWpBb1lZaExYT3Ex?=
 =?utf-8?B?RTZMMHRUZVBkby91NWZEYUxjaWpoUUIrVTk2WWdHRkZTSkJTeTRKd2VCQVVx?=
 =?utf-8?B?Q2xOb2R1VFRnNDIxbmJIMGFLOWE2VUFjREV2M3poRi9zMHgvNk5ubmgvYURx?=
 =?utf-8?B?RWg0MEZYTXZUNklYOTRBMkNTcmRIWld4RHphTDhkU3dBUE12NmpVMStJNThI?=
 =?utf-8?B?aDhRQVFDZmovQ3lEL042SHg2SFpJclFsZTJrdzFXSVkvZU5wZUdRYklCbU11?=
 =?utf-8?B?c2JGc1RSNXlPeXd6RHp6eExwYmR3NjluYk5YbzFFZ3FkQi9GcXA5bGo1Vm9T?=
 =?utf-8?B?Tk5lV0dvTnRhZTZmOW11UEtPSDNRaDZRcDBQb3czUmFuTml0MjBWcmo5SFhT?=
 =?utf-8?B?YzdzSkNwWXJaaDBzMWthOFhGZWtQb2VWRHQ4dVV0c3A5TzRFM3lLaTdLck5J?=
 =?utf-8?B?b0loK3Npc1V1aXFnb05OaG5jOGNNd3JHb1BmYWYxZmpmSkZnYjJmQmc2aThE?=
 =?utf-8?B?UmxNVVlMRXFrTTJTZGJXbXdWNTJibmdoS0JmcHlGYTZoMlRYeW8vNnBJYUZp?=
 =?utf-8?B?dUhYTW9wQm9sZU5JOXovbkZYYTVPZE8zZ3NqVXdzQ3lmdjhBeFNIbnFlS0Fi?=
 =?utf-8?B?ZTJKVzdKcE10OWkrdDczMnFUdGNRT2o5ZzRQZTBsMFg5ZE5pTVIzT2ZXdTZO?=
 =?utf-8?B?a29UN29HK096NWxIMWNCR0RncXhSK25ncHZsdDdkY3hIL3ZKTmM2ZkwrcHp1?=
 =?utf-8?B?UUYzNUpoNkhJdC9iRHRCVHZBNG5Id3dlUXBPTnFUVGlrMFMzK2VvbVJyZnEw?=
 =?utf-8?B?NWVOYWQ1WHFHUDNqUnNiWmRmd1lkNmJ2ODYxVkMxVVczM29ZSHF4am9DWWd5?=
 =?utf-8?B?RGN3OWhxQTZRdkJKL3R4NVRwaWlnVTRWd2plK2d4QnJzRHdkTURsNnZnaU1n?=
 =?utf-8?B?YmNaUVZScjBHbnUwL0hNYzlPTHFJR3VSUDQxWnJFb0RvNmFqcWJWYnJnZFhD?=
 =?utf-8?B?YnI5Vi8raEJrN25CMTFZb0wxVXhRZHZ4amg5Ujg3Rjk3TUdaY2pTZ3p4VW9R?=
 =?utf-8?B?cUsrcUZLKzJ0RnFVaERFUTNKYmtZamdVeTdXa1BIQ1JybUcwWUFNQWhMTmtB?=
 =?utf-8?B?V3NrbnNzYzVpNEdQYlF2ZzAyTnVpeGlFZCtReXh0Vk1FY0xHVHkxR05ZNThU?=
 =?utf-8?B?cmIzb2RUNlJKdUVTbG9DVjFuNTZsa0E2OVVoK1BFU3FVUU5CaUJuTXVBc2ZX?=
 =?utf-8?B?T3hieXRFZ2FPbVBjQk5melBvQURZSVBHUjdCVUFaN3JMNDZzNjVCQXpoVnVZ?=
 =?utf-8?B?bk5TalZqNUNmcVo2b0RsZCtLenVHRkUrUUpBT1ZsQXN4QytObjd6YmNQVGg3?=
 =?utf-8?B?Y1BHdG1NcGM0bXBDZlpiZ2ZaeVB4T09obHhTSk5xYVUweWlSQk5TNTNud1l4?=
 =?utf-8?B?NWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B16E21A7F3B1BB4BB46B05EFCAD8AABB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	t8SSqibfx9wLQR5gN5JyYYh+MUZMu/pthA+A+f+ZH1mM/3E6owNxDBVZOtvC3ybSb/6tUf1JAUlLF6BvQO2EYWTroOJC3CEIIqYBQsx8Tu5OucFLnzhd0MVsBwLSPLZJGi5772FO4aSYKjLAgJTvfkfjob/i7KPmKE3QGK/U+Ie/hYv0tYSbvZfR0HBdT3mKTaIWk5myUz7mClyNZb2KLfCCeAnhCnEXKcS9zd+s8Gf/Xf2sABfkCPgkFs/fWdqdcfEex/ruPLlV7/3pLWoTzt4DUFOOjW3LsHe29wi9K/mxT0XRXTMYa44ow0vXEANJWPdjma5i/O3G76B8+cTytOG3aA552CTq+7ZyJFf8vwyxWkGwXjH80qAHM+dV0YGp+8rrSjH5sYh5Q/GeulBEg0uH5eoYcI+1YUOlX31mNj28oFIbJi5m95VDwizhZD9+wdbESP66xAc24XxWMXIR/Jz6s7pYQ/J9BlKd0k//3VIWF5IJWURZJGYQunKWKp4eM/Ft9C/uwp02ZUBVhY8m+t90SiyqRgDyFbka6cFwuuiZ95F33GlwM/Eg5UyV7IeLK1NvK9sjNWVtuoSYGT/iB8k98RXHDpni42IO50/W+WlbtFD5nta2RaGd/OKy3X0c
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d4e6df-fba1-4579-f952-08dd02ff098d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 09:47:35.6240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4r5ipOcefGISpsSbpZ0NkXKetpP8ln0ZknmlfJiDtAp29Fjro+7W0idlYTBWs4xaP/KuwLi45GWhMg8DLEauqHLtK86Q5Ojm64dqNpFxPvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7635

QW5kIGFub3RoZXIgdGhpbmcgKHNvcnJ5IGZvciBzcGFtbWluZyB5b3UpDQoNCldoZW4gcnVubmlu
ZyB0aGUgdGVzdCBvbiBmb3ItbmV4dCAoSEVBRCA9PSBlODJjOTM2MjkzYSkgd2l0aCBsb2NrZGVw
IA0KZW5hYmxlZCBJIGdldCB0aGUgZm9sbG93aW5nOg0KDQoNCmpvaGFubmVzQG51YzpjaSQgY2F0
IC4uL2ZzdGVzdHMvcmVzdWx0cy9idHJmcy8zMzMuZG1lc2cNClsgICAgNS44MjY4MTZdIHJ1biBm
c3Rlc3RzIGJ0cmZzLzMzMyBhdCAyMDI0LTExLTEyIDA5OjQzOjIwDQpbICAgIDYuOTkyNjY0XSBC
VFJGUzogZGV2aWNlIGZzaWQgYzkyYmQwYWMtOTMzNC00MGU1LThjMDEtNzVhNDUwOTNjNzA2IA0K
ZGV2aWQgMSB0cmFuc2lkIDYgL2Rldi9udm1lMW4xICgyNTk6Mikgc2Nhbm5lZCBieSBtb3VudCAo
NjU5KQ0KWyAgICA2Ljk5NDk1MV0gQlRSRlMgaW5mbyAoZGV2aWNlIG52bWUxbjEpOiBmaXJzdCBt
b3VudCBvZiBmaWxlc3lzdGVtIA0KYzkyYmQwYWMtOTMzNC00MGU1LThjMDEtNzVhNDUwOTNjNzA2
DQpbICAgIDYuOTk2MTM5XSBCVFJGUyBpbmZvIChkZXZpY2UgbnZtZTFuMSk6IHVzaW5nIGNyYzMy
YyAoY3JjMzJjLWludGVsKSANCmNoZWNrc3VtIGFsZ29yaXRobQ0KWyAgICA2Ljk5NzA5OV0gQlRS
RlMgaW5mbyAoZGV2aWNlIG52bWUxbjEpOiB1c2luZyBmcmVlLXNwYWNlLXRyZWUNClsgICAgNy4w
MDA5MjBdIEJUUkZTIGluZm8gKGRldmljZSBudm1lMW4xKTogY2hlY2tpbmcgVVVJRCB0cmVlDQoN
ClsgICAgNy40NjU3OTBdID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQ0KWyAgICA3LjQ2NjQxNV0gV0FSTklORzogbG9jayBoZWxkIHdoZW4gcmV0dXJuaW5n
IHRvIHVzZXIgc3BhY2UhDQpbICAgIDcuNDY3MDI0XSA2LjEyLjAtcmM3KyAjMTA0NCBOb3QgdGFp
bnRlZA0KWyAgICA3LjQ2NzQ3MF0gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQpbICAgIDcuNDY4MTM1XSBidHJmc19lbmNvZGVkX3IvNzAzIGlzIGxlYXZp
bmcgdGhlIGtlcm5lbCB3aXRoIGxvY2tzIA0Kc3RpbGwgaGVsZCENClsgICAgNy40Njg5NTVdIDEg
bG9jayBoZWxkIGJ5IGJ0cmZzX2VuY29kZWRfci83MDM6DQpbICAgIDcuNDY5NDg2XSAgIzA6IGZm
ZmY4ODgxMTYzY2E0ZTAgDQooJnNiLT5zX3R5cGUtPmlfbXV0ZXhfa2V5IzE0KXsuLi4ufS17Mzoz
fSwgYXQ6IGJ0cmZzX2lub2RlX2xvY2srMHgyYS8weDcwDQpbICAgMTEuMzQ2MzU2XSBCVFJGUyBp
bmZvIChkZXZpY2UgbnZtZTFuMSk6IGxhc3QgdW5tb3VudCBvZiBmaWxlc3lzdGVtIA0KYzkyYmQw
YWMtOTMzNC00MGU1LThjMDEtNzVhNDUwOTNjNzA2DQpbICAgMTEuMzc1Mjg0XSBCVFJGUyBpbmZv
IChkZXZpY2UgbnZtZTBuMSk6IGxhc3QgdW5tb3VudCBvZiBmaWxlc3lzdGVtIA0KNWM3MTY0MjEt
YWU4Ni00OWVlLWIyODMtMTNjYzQ3NThkMzk1DQoNCkJ5dGUsDQoJSm9oYW5uZXMNCg==

