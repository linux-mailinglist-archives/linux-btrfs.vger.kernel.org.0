Return-Path: <linux-btrfs+bounces-12267-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFF0A5F990
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 16:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7DE119C4835
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 15:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E99C2698AC;
	Thu, 13 Mar 2025 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Kg0UxGKs";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zNTP4LDS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68A0268FFC
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 15:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741879112; cv=fail; b=trfipQDQ1ewmVPYgOtAZhQFxAKlNTsK4MTyR6QRzPcN5PfglKIPqoVNYbiKgOaza62Own8HhyXi8Q4WWAONpNT0seJQPg1VRsVwDqT36JZg83ec+4CBX7T8YIp6nhV+YQiHMNFnV/7EsWdHqWJV0tejWWo0la4O0KQ6xHMuHM9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741879112; c=relaxed/simple;
	bh=NSBTP0qUDJzwDOM8SbMf1YkCdltkkv5twyMmLm9xp1E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=On57V8Z7Ua9BP6C3BZRCgKyWyAazxjQQa7QtrV7gEx9gkT2a7UwdTmjAmjuqspCN9O6N9bQtdslhMCg9A8mu2CSlq77kGnxV+CrPxApaC73gLM5T79/BcLG8TnnNa9e79kqq7oxVjiLl6bvN/7mYLPixNEkEsY8/wZSs7DJh6vQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Kg0UxGKs; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=zNTP4LDS; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1741879110; x=1773415110;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NSBTP0qUDJzwDOM8SbMf1YkCdltkkv5twyMmLm9xp1E=;
  b=Kg0UxGKsQRFEVvV13C1adv1hRz1HZT6QXKJaiAgO8xKilRaujvyW9dJV
   oLa4wVh7cXq62NzLwWo7WGXXEsgZxseTXj8EkREzEae7oCHWaFdVGRTRg
   u+xZCv7UWBxfu38L5AXtD/7PQ9zuE/7hAoH0V5YMZ2bftnRof/lkesQFt
   wjHE1nJSc6V3VmrZi7BUAvCrj4p4PySNUcHG1YrLOxDFna2MgJeemBnGE
   Gs57uH0wtjFOjWA5D3Mu/5ny7K3hRLPuy4KWbF/rjna1RHQu6VhFRuYaP
   3txEy4CCibgkVPX/saE2tnR407POncBedCyR75+wbfY8nqqRSxqrqfeFr
   w==;
X-CSE-ConnectionGUID: P/zlbqFiQtus/4dmKDZ1LQ==
X-CSE-MsgGUID: blUoqqqPT5iqMB6PvJeJrw==
X-IronPort-AV: E=Sophos;i="6.14,245,1736784000"; 
   d="scan'208";a="48938077"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 13 Mar 2025 23:18:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2S9LB9XDrRyIrhZeUswZrGtjGbtzO8DMQarrmPAmfIXLmYNAKSt3hpHcO9NrnPTe/6gX8CzG/kamQlVOUhL14s2/Z8qnc+G7M0fbVWxNQRwj/AQDlXLFtDkAlJgArZcc0rVvNH/JV90xSlpWjO6fruiBfzhTNt5UqjRyw+vO67Z5Px3od/zltvjab+lV8Bet+9i1I836BMDeTAi1b8gsLEwidIBPZdd7p1lZKuLzGpY87XdPUx17es7iENsxMh4S6LCJlXVs/E82hnoU5vs4c2Snm1fvzvuBmePQRZ8S3ECFl81jSqxvGh4w4k6DQbKUlmxDV4/Go5yyxzT0hM4tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSBTP0qUDJzwDOM8SbMf1YkCdltkkv5twyMmLm9xp1E=;
 b=FlS+V5s53ytWEpHHwleVIesovIxj8o/pckSmKIKhZ7oxN/maoR7I6YYmcmnJAAQvN63B7xSlARp0MmPkBfVuOQ3PHxI62evm7/njeqU5SBIB218l9IK+p7HaTWCd69VPum1k8BkqmqNtjUgJpyZ90Ve4VIejrlGiGxFJPJ4afDMAQqxNLu0fne9iA+nwAZnIOX+b7Wr9OmnaPvkeLaOZdbTLvE8rvHfF5YXZa5wi6VMzygCunw0gNXsPq02cCo6Gw9wYDHmsljnNg3QBGEfNBGlcx8ebSmZxxWYUyvDfb8u2n62Ngqu8x8ulNwgSluixPsJJ+Zxne7eiufTvXwPw3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSBTP0qUDJzwDOM8SbMf1YkCdltkkv5twyMmLm9xp1E=;
 b=zNTP4LDSnmxcbHUPmN4dGlKGzY4QezVU+QC9V6LqP8wmR5oqZuM5VQNirY9ptXlNRqAxn/B7QfOcdh8M1HLPiX2YzyQGoV3A+l6/yzctoHYzc+ICAFhf9Akz7fThdBRg1qMGnZjRO943d4UBLME7ZKraIKrqliCY85dsqnwZ698=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by MN6PR04MB9310.namprd04.prod.outlook.com (2603:10b6:208:4fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 15:18:21 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%5]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 15:18:21 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: =?utf-8?B?6KW/5pyo6YeO576w5Z+6?= <yanqiyu01@gmail.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Naohiro Aota
	<Naohiro.Aota@wdc.com>, WenRuo Qu <wqu@suse.com>
Subject: Re: [bug report] NULL pointer dereference after a balance error on
 zoned device
Thread-Topic: [bug report] NULL pointer dereference after a balance error on
 zoned device
Thread-Index:
 AQHbkWcHHm5kGZj2pUWXjQyYDI5QKLNshJIAgACkFoCAABbtAIAAl5aAgAArbgCAAUPEAIABWVEAgAAqWICAAAKRAIAARXuAgAAf6oCAAAGEAA==
Date: Thu, 13 Mar 2025 15:18:21 +0000
Message-ID: <302cd0ac-e17d-49e0-9fb5-f6d539d9f620@wdc.com>
References:
 <CAB_b4sBhDe3tscz=duVyhc9hNE+gu=B8CrgLO152uMyanR8BEA@mail.gmail.com>
 <7addae55-e0a4-40c4-b4b5-279d4eb91fd4@wdc.com>
 <CAB_b4sAba_AtdQfM+23LhnL_F038wuE677DZx-1T_Q1TH6rtMg@mail.gmail.com>
 <CAB_b4sCNenuqK79ce7ijSDQzXgLAq8jEe98z4P6_UqAz-OvhEQ@mail.gmail.com>
 <88371447-4d78-491c-9d86-ee2ad444c50d@wdc.com>
 <CAB_b4sAgb370vOS3OVp2Vx6W+9iLUrCUvfRwVx9WtWbFOXPQsg@mail.gmail.com>
 <6ab5accb-de28-4d79-92c4-1d3b085fbb08@wdc.com>
 <76e81f2c-17fb-4c11-b1c4-0b4c18b080b5@wdc.com>
 <CAB_b4sBkBOMCpbsf4hmC+wnL9FiH3vk70mq+QrZEAbb8Jfw=jw@mail.gmail.com>
 <4b15f181-8e28-4c8c-b86a-780315d5cc7a@wdc.com>
 <4463e487-b260-47f4-a7b7-285ebf987967@wdc.com>
 <cf28bffc-0a2d-481b-bb2c-17a66f113b39@gmail.com>
In-Reply-To: <cf28bffc-0a2d-481b-bb2c-17a66f113b39@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|MN6PR04MB9310:EE_
x-ms-office365-filtering-correlation-id: d95ff724-055a-43e2-0ec9-08dd62424a4b
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?akIzTVhZK0ZlRlZpdi9semZSb1I1NFRxaE1xL2pkb3EzLzdING04eHpWcGpU?=
 =?utf-8?B?T0ZEVHFNV3FPR1VreDl3Vmx5SUMvTmhzcmR1ODEwdTJ1ZzY1ekh2RDlmNE1w?=
 =?utf-8?B?OWNHdHhrVzNwMzgyTk1lTk10ek1IejQ2aEJTUEtub3d4TWU0VUFyYXdlMW1z?=
 =?utf-8?B?NjFYK3l1QnduOVIrOEdZbm5VdTJxRVI1aS9aSllyQUc4dndLdDRyRS8reWdP?=
 =?utf-8?B?QWZpUTFQTGYxTzFSRXBFQkVxVW4zajJyeEo4UUNXOW0wcENuRzBYcE5WRkxn?=
 =?utf-8?B?RERsc3VnalNSVGh2bUhYSUhIOUhxRHZtQ1M3MzNHUFhNQ3FwVTdVTkFwM3JH?=
 =?utf-8?B?YWdGdlBzV2VVVHZGbEk3aFBIQnh0Uy9NZ01XVFkwb09mMmNpRWY3UUVIdGI4?=
 =?utf-8?B?Y2JIclBoRkRPUTZJKzFrM3g5RjJBcGk3K21Ya3QzeHphTXJoQVVJcjROblBG?=
 =?utf-8?B?TjdndW9nT3NTekZFQzY1S0MvUGd4emdwVUNGTHpNRUJhUWdKdzgvTmk5RHc0?=
 =?utf-8?B?YU9EZzEyRDRvekc0SFhtLy9lQUVycStuMExrWGQ1RjlLVWtQbmR3Tmd6a25Y?=
 =?utf-8?B?L0Zna3hWQmpLdGZxank4THdVeXBpSEJKRm0rd1Q5VWpmSVQ1VjIwbEcxZXIx?=
 =?utf-8?B?RkRaMy9HdlV3YW9pMTJQVGV5U1J5bzZCck5ZcThkamFlRTlEdmJIRGV0K1JW?=
 =?utf-8?B?ZlF1N1JkWEkwNUdWQ25aL2V3Z0phcDZtRW50dUppU2x3UGJuWU5WRklJc0F1?=
 =?utf-8?B?RW5pR3JaSFpUZGx0RUtXYUtXemhnMkI2eXlySTJnc2oxaG5YNEx2aEFGdXVN?=
 =?utf-8?B?dlJLczg3S1BsaHRmbExyMHcrWk1UQTFZdzdXaDIvb001RmdtWEtTVHFIeVAz?=
 =?utf-8?B?cHp1aHRHS0RoL2tnMXA0MmthZTgzMGMwRWIxRUtTTzZ4c3RuMncvekU3U3JL?=
 =?utf-8?B?bHVqdm1ZRVZ5SHBkaURVeG9Za3ErVHlWOFNBOVorOGxaU1ZFRXhkMVlRSEhX?=
 =?utf-8?B?cndoZHB5aGxrYmFZTENlV3VrdzNJV0dYQUxXaWo4Q1NWUjlJdHNFSHBIa1Bo?=
 =?utf-8?B?NWd3YmVMNCtlVE11YW15RGxSNmtwa1BYNjQ2RUpObTQ5TEUrOXQ0VzdrM09O?=
 =?utf-8?B?RC8wVUJuTURHOU55aUFZWWltRnJlOEE5Qk9nZ3gyeTkvd3E3L2Z5TVFRSjBr?=
 =?utf-8?B?VTViaDhpM2hQbzd2NW8ySFVsODBKSHFoZG0rUVV3ZERwRklLbC8vV3BZRmM1?=
 =?utf-8?B?b0xkRkpoNmlmY094V2xROGQyUndCVkFkYzVBcnpta1dUZVFNVm9BdUhzaDZi?=
 =?utf-8?B?dzJsSWMvZTJiY1AyVHJwb1dJNVdJaHM0bG1lYk94MEdMb3JZQzBKMUh4czFz?=
 =?utf-8?B?US9kRHliVWV0MC8xL0Fzdk5OZi84bDdSZENML3h6UXQxYm1qVmtHVEpTbjBO?=
 =?utf-8?B?NWVtTFBheTFMcTA5RzgwNEpMbEpTMkZ3TkN1N1c3a1J5VWQzdUMrMGZXQll1?=
 =?utf-8?B?K0lkNjJoUEptZ3hpV0NMNC9JdGxnS3htZjY2WmRvTmJtWG9DdE93NlQ0aHBh?=
 =?utf-8?B?THp3S3h3Vm9Jbmhpb2tQZGVPR081elVxWkprQ2svNVFneWxuZjlHeWcrOHQ4?=
 =?utf-8?B?ZEtaVHpZSFZsb2hNL0kvbS9HZGkrQ1l2ZEU5blBqOGlVUDVMZWNldVpqNExy?=
 =?utf-8?B?ZE4xdnM2QWh1THVRaFA3dENZTWRrM3VJM3pDUytLSHR2U1JpNjRhQVEvYkFu?=
 =?utf-8?B?UXBPanBoemhSTFFmQVN3aW05eENYVDhhQVJOa0xkZGw5OTE5V29MYU5wTmlv?=
 =?utf-8?B?M2NDK011bjVTaXJZUjdBVmdvYzVvUGJZY24veUFLYmpMVTM4Q2lpblU1L3kw?=
 =?utf-8?B?M3dWMnljQWtXTTlpZXRWdUhwcEdtbGdZaG9HUTE3YmhZUGJIbDd5WkFCYjlW?=
 =?utf-8?Q?7kOjvEh+zZo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OSt5STc4UDJqTzFCN2lsdFRuSndJaTNHNTc0UkloQ0FOMFEwM3BwNUVCWkg0?=
 =?utf-8?B?S2c3eFcrM251cy9PcWVieTJ4QzlXQit1cVFmcXBhUUIvTnAxMVRnU04xaS9M?=
 =?utf-8?B?d3FrOUhNSStjdmtiQnNPSUZEY2JBamN3ekM4Wk1PWXMwdVZEZDBxckpJbkF0?=
 =?utf-8?B?STZyZks4ejhVemZzWVVzcWJOOXFBNDhSdXN0S3NHT0lEVHprRTdYL2ppQkVl?=
 =?utf-8?B?MmpSbDlXc3JOQ3dUMzVJS05ER3UyeUh5Um5hTk03eUxURDU4c2kwM0JmTlRR?=
 =?utf-8?B?SmE1c2ZINm1WK3FCZ0t0d1FhVTVnaUZ2eWVRUm1GdFJoMmlmTFV6NVF2cEZn?=
 =?utf-8?B?end0ckdRY2MvdVBrREpsdGYwL3VLRHpLZnYwbm4wTmFiTkNiWksxQkN3V0lK?=
 =?utf-8?B?eUVJUWxLWVNZdVBtZ3FPMmVkVFBqeG9kSzFsTHZPaUhOcks0SGlJd2h4SGdj?=
 =?utf-8?B?WS9YMmI0c1Y5TWw0cmVvVllOQXRwVkkzb0NwRzhWaUlQTk9ReEpVMFNiRTdR?=
 =?utf-8?B?Y3dFVCtEWHdJTnRPcC9JNDNnS01Cak9hdkxmWkhwc0FObTdNT2lIc0cxS2ht?=
 =?utf-8?B?eUVqaUs3UThDUE94UDRsWEJLQUg2Uit1U1Uwd3R0bStGL1JMWjBBbElncFd4?=
 =?utf-8?B?NUZDamtRRThXSkp4bUZWRGVEby9zenJPb0xIc0hHbktPZzY4Ym1SZ1ZpVmpX?=
 =?utf-8?B?aVZycDFFeDBkNFpSdlduUEpNSGovZEZMUkZLTWw4VlVaNG9SdWFXaEcwMVRF?=
 =?utf-8?B?N0F0bUg1SFEwVEdsWUR0a2FOdzgrVDlmeGtTUlNaSXpJTkowdDRBQVhqYU9r?=
 =?utf-8?B?bzZvMHBwRXpJdmlMdk90ekRlTUh4Tlhpb3BPSTJMRUdNZzdydis1T2Y1Y1FY?=
 =?utf-8?B?dmRZNVY3ZFNNS3NlZHdDb05INzg2SDlPVjEwUUhTc1VuV09vOVhwSnFrY3JX?=
 =?utf-8?B?eUVVUGRCZnJYRHF5TlVKV0QvWWpnUklGTkZlZS9tbm10UEYzWG9DbzRMRUYx?=
 =?utf-8?B?YnR6eHJzVDB2SzJzQ0E1T2xUYkdVUjJmMDZHNjlGOXBkZDh1WHVrQm5iOGNk?=
 =?utf-8?B?WXQrOE9zcVRnZ1NtdnYyU0UxSFhWcmxiMGlyaU1BMU1QQThVNmNFZkZ4NW1l?=
 =?utf-8?B?dEF0ZFhGRldKN0F0NGNzMDF4K2JUcld2b1ZyTzdHZXRrcWw4L2VzZVpObEVQ?=
 =?utf-8?B?QWZFZlBmS1dWZVYyalFFdWxWN2tJTHVQYUt3V2lKcy8zRHY4REh6L1YxSE1q?=
 =?utf-8?B?TzhlNisrNTFHblJ4WmVIbTRnTU5aYmNLMmZUSkd0Y2NMdng4MktLbGN0eE1S?=
 =?utf-8?B?SWtkb1VDakErMjlFOUprRnVXTTk2Mm40clZTU0RYOFowWndNK0pWajlDNGth?=
 =?utf-8?B?d0JpVWVzenpScm9BQjM4cmtVdGs3RzZpK0V5T0g0MXhsTmNSYnppNFhNSGYx?=
 =?utf-8?B?QlJjMjg3a2tDRjdKMWxZSFVkYSszRDBqSEdQdnc4WlBRV2dzdFc1UlZnSjdh?=
 =?utf-8?B?c0liVEJlR3NGNlpoRlkrUXB4RTVUNGN3bmw3cUNQaG0wdGhrSFR6aHFkd1pj?=
 =?utf-8?B?MjQyZ1AwVTdxdk56c01pZTZQUEs1ckdBUnVwZjNtZklXTzQ0N0VQM044MGVI?=
 =?utf-8?B?b0tYSG1CQjh0QWJvT3lqa3pCOGM4U1NLWTV3Mkxjem45T1JxdEhLczRDQ3Zt?=
 =?utf-8?B?TW9OVEdXang1dEZiTzN0SFlJRTZKM0RtaERMaGdTQ0taZjhLNHZBSStyTXVm?=
 =?utf-8?B?SWgrZElYZTlnNEFoZi95d3hlUVFxWDl5WThqVDQzYnpxcGpYMmpHb2R1ZXJw?=
 =?utf-8?B?alNseWd0VDc5aWlNTlNaK1lKdFBUUUt6VVlTek5sb1Y3WWM5OUlVa3IxQ251?=
 =?utf-8?B?dHVnVy83eXJQZUN6Q0VIWlNEay93V1NnNWRRclE1eXF2cVpwcFB0RE10ZU83?=
 =?utf-8?B?eEZwMWdOMVJCR2lxNnNYRTVzNWtJd2xraHhWc0k4NG5sVFl1YTZ5YkZqbWJW?=
 =?utf-8?B?UFdkbnUwd2U3TDk2SXFvbUhaL2tvcUdkME9YeFZteXo3UzJvaWRLeHo2TlVM?=
 =?utf-8?B?ZCtGbTJ1d1M4YVFZUStUbUp6ZUI5cDJnQzUvMElyd3RKbnRvaVQweHZzelcz?=
 =?utf-8?B?UzNCdlhWNG9DYUI4ZWpRV3B5cVg5SEFHTm1VWXVsQ3pGdTdSc3dORWxLNWs1?=
 =?utf-8?B?RXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <50399B033DE31E4699F528C58615F9DB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9/eYKDoW/UZyH1ifpTpWBRrwaofhUbQrcX65yK73M9YI2SBAO2JeZ9aRb7RxeDJz7s4gZ0gCYhvYHdyedCqBC7WfbvAfw+Z8DxRc1+PwC+nTSr321OU1fZs4o4A4u1IMFfmkdOnC0zlfKfSyyDofJcpg6iZtQZ3JRSvNqi0POWja0ihj8nAS9NR6CWq2cjblWhbeRLOKf398qP0Mr2UznArxkD+7NCBpHCverttscNX2QPKsYUNhZz0hd0GHtSZEdZsmOTF5eigB7tHj+Ays4xsCuiRwkwYjyhQaC43EgGh12dla1LdcZQaIOpHWQ+BapD8eQA93jg0iBMTatS8hbqQdzOdCuL4AqrfLkQlGW/WySsLERsjYnR1Ty+V7cEPGixGF3hRuFkE03NyAagvzQeDumJeFx8ADNF0QB/plQr9l9vktboidNmK1NFngdiySHF2VcQB00PvBN1K58X6CyrFFUqh7ov7XTVRyyEaKCZrQqu3XsVawHhFntcbkVk/caz4/FivPHnQS7RZBCLrhtciNNHKOREndNbGhPoVoNwrvKYvCgmh+nYXzPi4h20nmMr4PvZCEyzpkVVxl/xTixQwp3Rtwru3RJgv9rB8LKd9i650Fv/DiOd95C/q2d4Zx
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d95ff724-055a-43e2-0ec9-08dd62424a4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 15:18:21.0236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C4Tq9ft1HdIxMK10edULBQwcDjVhWh8HtF6U4rnYiIK3vv0tTQyhfFAWIL94AE5auLeZLwCyvuEzojyI1XGA9OP0ttOwSSOnxRqzkG84yr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR04MB9310

T24gMTMuMDMuMjUgMTY6MTMsIOilv+acqOmHjue+sOWfuiB3cm90ZToNCj4g5ZyoIDIwMjUvMy8x
MyAyMToxOCwgSm9oYW5uZXMgVGh1bXNoaXJuIOWGmemBkzoNCj4+IEdvb2QgbmV3cywgSSBjb3Vs
ZCByZWNyZWF0ZSB0aGUgYnVnIGJ5IG1hbnVhbGx5IG1vdmluZyB0aGUgV1BzIG9mIGENCj4+IG51
bGxfYmxrIGRldmljZSBiZXR3ZWVuIGFkZGluZyBpdCB0byB0aGUgRlMgYW5kIGJhbGFuY2luZy4N
Cj4gTWFudWFsbHkgYWRqdXN0aW5nIHRoZSBXUHMgb2YgYSBudWxsX2JsayBkZXZpY2UgYmV0d2Vl
biBhZGRpbmcgaXQgdG8gdGhlDQo+IGZpbGVzeXN0ZW0gYW5kIGJhbGFuY2luZyBkb2VzIHNlZW0g
dG8gc2ltdWxhdGUgdGhlIHNjZW5hcmlvIHdoZXJlIHBvd2VyDQo+IGxvc3MgY2F1c2VzIEJ0cmZz
JyBhc3N1bWVkIFdQcyB0byBkaWZmZXIgZnJvbSB0aGUgYWN0dWFsIHZhbHVlcyBzdG9yZWQNCj4g
b24gZGlzay4NCj4gDQo+IElmIGRhdGEgaGFzIGFscmVhZHkgYmVlbiB3cml0dGVuIHRvIHRoZSB6
b25lcyBhbmQgdGhlIFdQcyBhcmUgdXBkYXRlZA0KPiBhY2NvcmRpbmdseSwgYnV0IG1ldGFkYXRh
IGNoYW5nZXMgcmVsYXRlZCB0byBibG9jayBncm91cHMgYXJlIGxvc3QgZHVlDQo+IHRvIHBvd2Vy
IGxvc3MsIHRoZW4gdGhlIGJlaGF2aW9yIGluIGJ0cmZzX2xvYWRfYmxvY2tfZ3JvdXBfem9uZV9p
bmZvDQo+IHNlZW1zIHJlYXNvbmFibGUuIE1hcmtpbmcgdGhlIGVudGlyZSB6b25lIGFzIGZ1bGwg
YW5kIHRyZWF0aW5nIHRoZSBzcGFjZQ0KPiBhcyB1bnVzYWJsZSBhbGxvd3MgdGhlIGJhbGFuY2Uv
cmVjbGFpbSBwcm9jZXNzIHRvIGhhbmRsZSB0aGUgaW5jb25zaXN0ZW5jeS4NCj4gDQo+IFRoZSBu
ZXh0IHF1ZXN0aW9uIGlzIGhvdyB0byBmaXggdGhpcyBpc3N1ZS4gQSBwb3RlbnRpYWwgc29sdXRp
b24gbWlnaHQNCj4gYmUgdG8gc2ltcGx5IHJlb3JkZXIgdGhlIGZ1bmN0aW9uIGNhbGxzLCBlbnN1
cmluZyB0aGF0DQo+IHxidHJmc19maW5kX3NwYWNlX2luZm98IGlzIGFsd2F5cyBleGVjdXRlZCBi
ZWZvcmUNCj4gfGJ0cmZzX2FkZF9uZXdfZnJlZV9zcGFjZXwgKGFuZCB0aGlzIHNob3VsZCBhbHdh
eXMgYmUgdGhlIGNhc2UgYmVjYXVzZQ0KPiB8YnRyZnNfYWRkX25ld19mcmVlX3NwYWNlIGNhbGxz
IF9fYnRyZnNfYWRkX2ZyZWVfc3BhY2Vfem9uZWQgdGhhdA0KPiBwb3RlbnRpYWxseSB1c2VzIHRo
ZSB8YmxvY2tfZ3JvdXAtPnNwYWNlX2luZm8pLiBUaGlzIG1pZ2h0IGJlIGVub3VnaCB0bw0KPiBw
cmV2ZW50IHRoZSBudWxscHRyIGRlcmVmLg0KDQpUaGF0Og0KDQpkaWZmIC0tZ2l0IGEvZnMvYnRy
ZnMvem9uZWQuYyBiL2ZzL2J0cmZzL3pvbmVkLmMNCmluZGV4IDQ5NTZiYWY4MjIwYS4uYzIxYTk3
YjMyZjlhIDEwMDY0NA0KLS0tIGEvZnMvYnRyZnMvem9uZWQuYw0KKysrIGIvZnMvYnRyZnMvem9u
ZWQuYw0KQEAgLTE2NTksNyArMTY1OSw2IEBAIGludCBidHJmc19sb2FkX2Jsb2NrX2dyb3VwX3pv
bmVfaW5mbyhzdHJ1Y3QgDQpidHJmc19ibG9ja19ncm91cCAqY2FjaGUsIGJvb2wgbmV3KQ0KICAg
ICAgICAgICAgICAgICAgKiBzdHJpcGUuDQogICAgICAgICAgICAgICAgICAqLw0KICAgICAgICAg
ICAgICAgICBjYWNoZS0+YWxsb2Nfb2Zmc2V0ID0gY2FjaGUtPnpvbmVfY2FwYWNpdHk7DQotICAg
ICAgICAgICAgICAgcmV0ID0gMDsNCiAgICAgICAgIH0NCg0KICBvdXQ6DQoNCg0KYWxzbyBmaXhl
cyB0aGUgaXNzdWUgKGhlcmUpIGJ1dCBJIHdhbnQgdG8gZGlzY3VzcyB0aGUgc29sdXRpb24gd2l0
aCANCk5hb2hpcm8gZmlzdC4NCg==

