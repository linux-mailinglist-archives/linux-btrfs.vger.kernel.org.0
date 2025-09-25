Return-Path: <linux-btrfs+bounces-17170-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AC6B9D7F1
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 07:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA529323FDD
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 05:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B342E8B7F;
	Thu, 25 Sep 2025 05:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ODuIEBDl";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PKH8T5oY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B972E7F05
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Sep 2025 05:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758779743; cv=fail; b=jTiwaNDlN6E/i4nyJfinJv+pFanzqzTilBiQXvBQtvYurYB83g0zY50UTMqZRMl1Pzdk8WQaRY7Xh3Qc+nq+oTJdem0wRButSdjfZ9B6mJwC5I7LkkQDpkuu8vpZjUlX0bIqMyUU8URF7/l2Zng1BZsBnx9ZFw9D0VEaa2fdku4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758779743; c=relaxed/simple;
	bh=v8yYp7aT6PZ/ZktWzgAYTqJW8IA+6qBYikhsZNkjIM4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AqxiJ7DhKWd18mG01KBoXV4DT4OfRAnNsGUQiHpXnesBHcLQ4lORLv+1RmcVovrBTts4myhXaI3d3EcPoer4Y4yFWjIKH0gjmt+pys4zCvk6kTwcnVqa66ImE/W32kbhvzlWLvn5leBol4f7Oy4LzQvC39kkZ5GQt5BGDpAsOQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ODuIEBDl; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=PKH8T5oY; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758779742; x=1790315742;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=v8yYp7aT6PZ/ZktWzgAYTqJW8IA+6qBYikhsZNkjIM4=;
  b=ODuIEBDlYJ9I8WV5y/v3+ZFD6MVJd6vW62DW1FyQBFG3bIzwpezAjESQ
   DSMgWzg8VqwynmiYusS/atbJ/hbJzq9QEyPWZrmehepPEmGKS6tJODvk8
   ZjxAQl646e0WCxZ4bxVju1Orh84i7BSURFlClFNVmEW8JXYAMSayfFcCX
   M0pDUGEYFscx/T3Y5E7TqYqMNlhhczyxI8uww87J/oI7RPqkEJpbAtEuM
   r03r40CYNqg4YeYGcEemwVkf4mm6NVpfTqlsah3ARz55EBskZIrQs+I38
   9pkXEvKTeuJtfRkrFUNLRDHuK0ItgQuBEKDFvdna5bJMA3C6CaZJdyZbT
   g==;
X-CSE-ConnectionGUID: 31ziHbyVT3WFyPsaqt2Cdg==
X-CSE-MsgGUID: DJCV6tcyQ4KfzV61q4KIDw==
X-IronPort-AV: E=Sophos;i="6.18,291,1751212800"; 
   d="scan'208";a="130048075"
Received: from mail-northcentralusazon11012068.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.68])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 13:55:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vYEwmyHLjqChdwnvZA4L4BQSKpmc46I77fDQMoP3UC0y8a2buK5Iu/9mycDEq54lrbre4QNC6pTZCR8iQlEzCpTh9i6c1cAfbyCrDjCnlVC76dW9JTSRoO+y/8B+MYpDwIz6MQXFNnAmLg5uEsDeWNquNQAYJiYsqyMHzycVx8ge+Yyn6FJ1t3WCP32I4dD3cc/VTYeWc4on/UaQuESnVp/E1m6X3nkkwfFzwApxxe8D1POi67015WEF2us9CeappHbdu8pORKsqZMDr3we0JhVTeWTH1BoP+GPGxg6I5udTL21lcZvsZsXVb7zjrBaMpVxDPp5we8v6X+5Z1/0BXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8yYp7aT6PZ/ZktWzgAYTqJW8IA+6qBYikhsZNkjIM4=;
 b=Wm9XPmbW7wyJpniC8C071UZDy2wc5rreJohL0jQdh/9WQQySCDnRYFDjOk6G3bhlAKm/r3+G9Dmza+ABQ68dEoaFAsnhtzshvZBReukQg2+3KwkQ0MAp6yWB6zUjQUC/Ei/CpU9Xljirj0vl6zWf/pTJC76X2mcwJdLQwB2ceyYiBllsYoTL5SmIgZeqxbaOzPHbk4TBcmhm/JpoWgtf5XBDxZy5vWqN771CwX7Sjw4cY+kbksj89swYXIKG2hVp0jw0PJ5VK+0zr4/tbqVb+0xvHz5f4TRtVpB/8hXJFonwq9ouFhP2Jiv3vywKuEB5BjHBIQjJoLOOZyG2LV94Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8yYp7aT6PZ/ZktWzgAYTqJW8IA+6qBYikhsZNkjIM4=;
 b=PKH8T5oYLaEEbT+Iqm8cdhVBaxY8GbmxhjVQTHD/CVE5aV3BpYuHaqZFOJ2QA8kD7bP7Gapwu0SYGOMG+jAeaRjbliZXcMHaK0AORTca5M59ocn4M7a0aWxmQqeChDze7hqHJuu6GS+VytrssX05cKXGfXFZbQ0aU56EVHDmS5Y=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7754.namprd04.prod.outlook.com (2603:10b6:510:e5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 05:55:39 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 05:55:39 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] btrfs: relocation bug fix and a cleanup
Thread-Topic: [PATCH 0/2] btrfs: relocation bug fix and a cleanup
Thread-Index: AQHcLXP7BTi+7x0kdkqHdD49hWcHerSjZyKA
Date: Thu, 25 Sep 2025 05:55:39 +0000
Message-ID: <3ab19f74-829a-4d53-adc4-e4d4b8adfcbc@wdc.com>
References: <cover.1758732655.git.fdmanana@suse.com>
In-Reply-To: <cover.1758732655.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7754:EE_
x-ms-office365-filtering-correlation-id: 780f61c3-54a3-4e8a-eacf-08ddfbf827ff
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|19092799006|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?S0JYVlRXMEc5T2V6dTgvcUtLdmpvUWEyRmh0eGplak9TU0RPajg0QWIwSUhk?=
 =?utf-8?B?THVQSStXVmw0OFgvc1BwODRaaEphKzNHZUhNUzB0ZjY0L2JjSUFQbVZ1ZXFW?=
 =?utf-8?B?eEdVZWxhb2xwOTU5RGpYemsvRXZoUnFuSjIzcWVUZXN6bUk1SVk5MVdjNlFY?=
 =?utf-8?B?RXhQSjZ4Qm01SXFJMlpsSGJPc1g4TFVKbEpQa1E0bG9meVNSUG40U3RqY2o2?=
 =?utf-8?B?bTNTYk1KKys0cnMwUEkvUXdsRUp5ODBZYWhXeC9ZSytFTFoyV2VheTlhUUxx?=
 =?utf-8?B?MC9DVXlCVEQvT0lmSUpxZS9vbTRQYWU0QzhlN0gzOUN6U2pQVHFidHpHb1Yy?=
 =?utf-8?B?UnUrZ210SGh0Umh3YlZiUFE3ZFhQVmpNOXpFT0VkK1REVEZycHVPQ0NjUjc0?=
 =?utf-8?B?cjlPbDFJVmZFUWNLSGZMZVp5aE5TMHhiT3FvRzFBcmliMXF0L1pkU285TGxv?=
 =?utf-8?B?M0ZNWG1kWUtFOHduaUJDaHJSeVN0MS9mK0R3dHhqUlJuVFE5clEvS1hOV1d3?=
 =?utf-8?B?RTd0bWFEQ1g3NVpQTmZxZGlwODdFSTB4bE83SnpLWXZsa25wcStPUDBsbW9p?=
 =?utf-8?B?bityZXMzL1ZZaWN4NEFHTmU1NmJ1S3FuYTZ1V1lkYVVHMmN1d1lxTlVDelVQ?=
 =?utf-8?B?V3l0UkRJUXNzb25acGo1ekJrbGF1M0xLQUtFNnZJSWRwQ1NTOUFwZFdqMzM5?=
 =?utf-8?B?eWY0bnBCN0R1NDRmT3M5QUN3bFRqbVNjRWFkK1JyQmJJM2orQzVva2JNVTlT?=
 =?utf-8?B?SEprdVlKcWh3c1BlZGNSSzZsU3J4bmgvUytCV0FqYW9Xb1pkbTdiOVZHMm1W?=
 =?utf-8?B?RTVJTmwwR2NYVmVWZnIvQjJnR2ZIWkJFTWZZMi9NNEw2aWdSNmRhRlo1OGY3?=
 =?utf-8?B?QjF4eHJ4VjdjRUlzZ2lyYzVId0Q0M2pEY1hCeGgxQVdpN0REZEdSMFhmekNq?=
 =?utf-8?B?MVBYTkJvR0J4NVhDVnJxNnlnNENxWVlYZThTWnpXSWcxcnh6OFFUYU5jbmVy?=
 =?utf-8?B?SVkrbVdVcXFTMjNTVkpPdE5XcktxcFo4VE9lM1JKbHlRYlBCNGFlUmIxYXVN?=
 =?utf-8?B?M3VtYWV6YkM2UEpSekF2cXdlKzhSbzBNYk9jaXpJd085c3hRbjJnbGYxTjJD?=
 =?utf-8?B?YmlZWEhUb0c1QkVObzMwTjBVYTlHNWs0TWVvY25HNWhJVDlUSUtha2x4b0kv?=
 =?utf-8?B?TVZWMExTdUFNV3AyRS9ZNEFGb3dmWnNIT2tJZDJXMG5zNmkrcGlzdCtEKzEx?=
 =?utf-8?B?RGkxWmpGQVNhYXdqOVBtLzNMSVZBcFduNmorZ2NTd29oVjNTempFRDZCU1lO?=
 =?utf-8?B?RUthQ0h5bE1TWFRKVDBTQmI0VEs3SU5wYXlFMDc2YUlrWGNlWUY4cmx4aHR4?=
 =?utf-8?B?VzQ2eDdjWEoySGdSanYzZHMxZkdTS0c3dTZqMkRkMzhCNThCTDRYS21wbVJE?=
 =?utf-8?B?NEFYRHhaS2U1RGlOem5zSXkwZGIycUxTam5yM3ZicFVMWHlmWk5aS2NjRXdU?=
 =?utf-8?B?bjhFelZkcCtUUHJIOWJVcndlQ25JRk9kVTdkU3VsZCtRaTNHdmZxeHBlSEtq?=
 =?utf-8?B?eTJ5SHNKbmJVQ0d5TmtCd0orNjNtNG9tSWpneVVxNm1QR2J4VVhRemhLaCsx?=
 =?utf-8?B?MmFkb21DZHVQMmd5NEJibDNGMWtlMFZJcE9RN255RkJMV0R1Q0xPaGpGdE9w?=
 =?utf-8?B?YWlVUllyNTdJclV4Rndxd1ZEaW9zeXlybVd4dWhlMzdIYWdickNuUkJYQThF?=
 =?utf-8?B?eUU2ZytFcTM2RGI3TGYrOHN3T2k3bTJBNWhjRzVsSkhQcE0vaHdQeGR5Q3BW?=
 =?utf-8?B?WnRtNXRqTmdiWTgrdEJ2YWMyVTBYbU1xOGp6YlpJc0RFL0p0d05hdVlyR0ow?=
 =?utf-8?B?d3laTkd0aUN1TnRjUXFuL0xkMXJmcGlQQ2VncVAvSzZlQlFUdEowQklQQUdz?=
 =?utf-8?B?ZTV1Q3d3K1JVVGJKU2RaeWhRM0UzTlRmZmJ6aVRxcjRNMXgza3ZSaTJxREFx?=
 =?utf-8?Q?Rt75JSLXC5fbsc1wfrRNe47/z8CGpg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZTI3cTdnc0MwMmU1VXNQV0xDR29VQTNMQ0gralVHNURGYUtHQlJVbWI0a0NY?=
 =?utf-8?B?Z05KUHlnVnNBZUhLa05YaWlwOXFSNzFHWUloUGcrdTdZbk5ucGR4eXErUU1D?=
 =?utf-8?B?S2dPRUM4aVl6Z3BKOE5IM3NTZklicTZMTVRhZnYvZ3p4K2JGNDlRSmZtZEZh?=
 =?utf-8?B?eHZxUWtXOUJmV21uaHlHeVpJdTJlUzlBcEpPbXZ1SFQvVHIvU21yTVIzVi94?=
 =?utf-8?B?SXc0dE1ZZ1hHVFdzaEhxeUxyWnZSNk9QWmtqWXZ4SVQ5Vkk0MC9lRTZJY2tV?=
 =?utf-8?B?c3RoRzFQOU1nS2ZVMHFndmk5TDJuTVRPc3dqRmx2Z1poODFKdWh6aFRUVDlQ?=
 =?utf-8?B?Um9FZGZ1eFhhVkwrRzd4SUdrQlBzb2JLckZsSGVOdXdONUJ4MFN5elo0ZmZE?=
 =?utf-8?B?eFlLKzB0ZGp1VnZTR2JWMFRjMHFBdXYyWGV1Y2ZOaDZPOEhMRnkzL0sveUFn?=
 =?utf-8?B?MWM1N3Z5amt1VkNjSGpqZGYyNGFsK1M3dlRvQ01CNSs0U3MxWjJ4WFpXRGZp?=
 =?utf-8?B?L1FlYnJEU1Voekdxb3AzWHBoVmg1NGNxTzNQdHRkeVg2T3M2QWRVV2NER3lv?=
 =?utf-8?B?eDNPTklVaUZFLzZtVkQ3Tmg2OTk5LzFiSW04dGhaaWdWc2EvbG93K2NXTG9P?=
 =?utf-8?B?YW1rWVJXeVI0Qm5oOHFyZnR5dkhoQ21KaHE5WnRHTFZJSmRjekR5cGtlaWtW?=
 =?utf-8?B?aEJmSjR4MURqeWhpTCtkdmJid1dmRU5pSkVFN2YwbHlSN3p6VjJkdGYyQlhU?=
 =?utf-8?B?NTRnVnZpVTJFclg3QjUySTY2TmZmbGw1cWZPQTlpbVF0M1NYNWtGOFMzdEt6?=
 =?utf-8?B?UW5TeEFHY3JSZHY5RHg2QkRGbCs5RCt5VEMrTXVLUXZnOVRqQ1gxZmQ5L0JT?=
 =?utf-8?B?WUpsTVBTRUdHUmNURXFzcStBZFo3bUJocXZydlpPVEswdUN5WTJqRlZTUkk4?=
 =?utf-8?B?c3R3MlIyWG1WZ2dLNG9oWmRGUTdaaThsSnR5WHFQdnE0c1V5eG1WMFlleGN2?=
 =?utf-8?B?dWloNUsyNE5xYTFIWkUwZkF1UkdLWi9iSVcwTjErZWR1Mit1L0pOV3VRMHpI?=
 =?utf-8?B?V2tnYkFER1RmUTEwanJuaDlZVExwRTVpMUhUelZPelJrb1VWNEV3WlhsRnEv?=
 =?utf-8?B?bHk3dE0reFFoTWx2UXFqSVcwQXZtTWNldFZHM1FwVU9vUE5CV1pDY2xHaktL?=
 =?utf-8?B?dnBoZUZiZElIcktVVDh3SVBuaFErR29wa01Qc1JNVmtTVysyTnNrOUY3RDBY?=
 =?utf-8?B?Zzg3b0VNVE91Q1ZHcDVReGpoTk5KNFpkWmlFRGdhYnIyVWt6Y3dnQXNQd1l4?=
 =?utf-8?B?RzJmYTAwRUNaMjdZMXZ6NlV5cWlEN1pUTXdoSWJVM1QyLzhYUzNDY1hnWU1J?=
 =?utf-8?B?cXFFUGtaMzVrZ3RrbUF4bDFSZFhpaW8wMmZLczU0bmpMYk1NS1h2QmsvNnBu?=
 =?utf-8?B?REpHejZ0ajY1UTJFVk9PZUNvZHRoQlFRN0NQYTZPeUxta3V4YklXdk5IWHpw?=
 =?utf-8?B?Mi83MTl1TFFSTU5jUmI5QjRqSTltQ0NJZ21PT2E4OHhjcUJ0MWJoQkRsSENZ?=
 =?utf-8?B?NnNpdGxHaFZMMmFNOWduQ1o4ZFFYUkxvWTI2M3BvMGJHTHFlaDVib2FhdFhJ?=
 =?utf-8?B?Tlg2enVRVm1tWHo5ZHhON1dxaFA5TExrNnAzK0RndWthNGNTZndheFZsR2Z0?=
 =?utf-8?B?blZkN3k3TDlIQjI2K2RVanZRYmdFWTAxRmdDSDZjSCtHMXlQUjhQdnFOUjE2?=
 =?utf-8?B?V09yMUVGeisrRnRUM29QUHAxUGl0QW9qd2l5Z0MwVk1XV0gvVTFPbWpSQUI4?=
 =?utf-8?B?clpjU0p2WGRsbEFIN0dZdHpLc1ZaUzRFaHVpSTNYVTFjczZIeForbTFVSG5X?=
 =?utf-8?B?SEVBRVR6eXlqcHBpZ0F4VnZrSU5JWE5OZWRES2loN1h4Z3pRZXFpcE5ZajFW?=
 =?utf-8?B?K29qNDE3cmlQREVzZSs0TGdNYXR2YzVTYnZHME5aYUNOMXFHUTJiakNIYzF2?=
 =?utf-8?B?cFRXTGxIeXpRck1OMGxEak93Zm5ONGdyQmdKQWhOSEd6RDdGQjZoSVdtQloz?=
 =?utf-8?B?YmFUcXlhdEo5bE9LTGJJZ2NFb0M2ZUZ3bk1ENmFKM0J4dzg3dXpaVFZxc1VT?=
 =?utf-8?B?TnVkWkRIWUhpN2xsRjJTN0tTbUM0V29JekY2QlNIY2o4QVpqS1JzSGpWYURu?=
 =?utf-8?B?QXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4178B9A7A3AA594FB1506D0203F30E89@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p/PJzjGGP+dEeFt/r53FTw4GbMqS425CkelZoPv6iqmxYwpF1zMpdeteJuz3eEAaSUYQwaIfO9v7rfTCMxIUjrAX1VBRosbfP/1LsWVt5OLl4QIwR36EaeK4LHRMok/GfZWoDIt9xOpLecHEIGPCrMNqM0eaKzu5DB3QbPZU76wmL1nNQ7OWwPrKcD7Bn+uE6eF/TuEM2uzC543vE/kyzkGvjart1rIuiInzG/QLH4bikBldZs/7VZUDKuw2Ntrf1MZjrNrejWebrcGDT05E98BiGUVCT92WcV9FrypoKYjNk81vA//9lcZRsCKo4EnVxbsgYQ3/xV7jOONNeUbaARDApDieVdH/AkiL5qPW8ZDczR0JUgeVP7GtPfs8w2lp9QZrnz7pZ2WnybiyxH0lBbtoTzeZQPS/GRhlZroSS34LprfLTv7X+zyeS+xrjgDrBXGlUbxMtQ5qbFNDdjxsYsCib9s+qTN0MEkMQKteejWN6jE/fsxeFBH8FI3bxnZilh5R+164m95Gtwb2cy7FoP2fipDxBq5QNa+myPpEJmuBzqSoqBs3Gj2+Ds5aTYT+ciso3aW8nVgK0vwl4Jl9Ai5DdIijgMMYJgS9Bs1cnjKfxnn3KU63maiMQFYKvlW+
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 780f61c3-54a3-4e8a-eacf-08ddfbf827ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 05:55:39.7798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CnFlO6Q+n8iPU5sAtc931KKHzLbub22L1DJDG+fMbG3dx2NBeqPIXitNs4VWONMh0qIh4fySWg5TEwZ77NoVW2cHl3VgQzw+HpNT7vC4XRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7754

T24gOS8yNC8yNSA2OjU1IFBNLCBmZG1hbmFuYUBrZXJuZWwub3JnIHdyb3RlOg0KPiBGcm9tOiBG
aWxpcGUgTWFuYW5hIDxmZG1hbmFuYUBzdXNlLmNvbT4NCj4NCj4gRGV0YWlscyBpbiB0aGUgY2hh
bmdlIGxvZ3MuDQo+DQo+IEZpbGlwZSBNYW5hbmEgKDIpOg0KPiAgICBidHJmczogZml4IGNsZWFy
aW5nIG9mIEJUUkZTX0ZTX1JFTE9DX1JVTk5JTkcgaWYgcmVsb2NhdGlvbiBhbHJlYWR5IHJ1bm5p
bmcNCj4gICAgYnRyZnM6IHVzZSBzaW5nbGUgcmV0dXJuIHZhbHVlIHZhcmlhYmxlIGluIGJ0cmZz
X3JlbG9jYXRlX2Jsb2NrX2dyb3VwKCkNCj4NCj4gICBmcy9idHJmcy9yZWxvY2F0aW9uLmMgfCA1
MSArKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDI5IGRlbGV0aW9ucygtKQ0KPg0KTG9va3MgZ29v
ZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3
ZGMuY29tPg0K

