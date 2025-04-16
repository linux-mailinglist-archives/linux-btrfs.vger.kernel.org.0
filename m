Return-Path: <linux-btrfs+bounces-13071-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EFBA9044A
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 15:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2663B20B3
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 13:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233791A9B53;
	Wed, 16 Apr 2025 13:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="RJx2Re5Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2046.outbound.protection.outlook.com [40.107.117.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACDAA32;
	Wed, 16 Apr 2025 13:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744809939; cv=fail; b=nuuK4Per8nE4/x8KjfqqCDfKV5so7KWrJk2CEQdHSlUsLUaAJomsQsf9TnF+5W8H9WHdRhiLnM06OypLrGviktGrfMS6RptIawYb/1onHq/v3+gWyYuKM5BIqyKzyXLthnfrFxmJJ1l5e9x3mZrrem6tlvG0YGvU9An+3+e6C30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744809939; c=relaxed/simple;
	bh=vT4c12ypZgPqRRhSDCg4tdbL0qL8ZMw3KlabKzEUyeM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CudWYlyf1lgb9dZ+6ZEjgzaBMwwLoMQwY99fQiSDQZ5FdrNwWTqzUr9hRDdRCQThHdLQNv8PQK1/kRp1lL909LVfq9NxtalNYpQAhEhxXZppDtJEJw/LoL4sZIXyBtR7lvDXSl/1Ntv/BjNTFDxOchoezc0iAmHU6fOqEBGWlZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=RJx2Re5Z; arc=fail smtp.client-ip=40.107.117.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qvPdvvbkLCvsyd+yqRgZnO31ZUT/yhdA7PAxgYZOLoqGt0LqUvMejFFm5YpJ4600dyKhOrd/VG5hLepqOeSxHX6cQyLds12V527Js8NUCu9jDVEuYBbsutD2FLUSdrnpBPdnMK3jpzu32MqqYwgPZ7S7s3ocHai5VC1k9hsjASZzhF28kHaMyXEk6IGZz2bKDfVO9Aqor+3Xey0b54VGnCX5F2W+mz+1zJtZMIBAR+4fU0TRy/hhuOI1I2doNkU602id1snohEcGkypVbO8HmQ2Ce+9afREK+q8VVkgZfmdC18us/vIPeSg8+vjxF6A3SkOCxQgKIU1DnUnpza1WXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vT4c12ypZgPqRRhSDCg4tdbL0qL8ZMw3KlabKzEUyeM=;
 b=cHaUinn8LYzBYEUTL00VPx2a9Bqkg9RVmBXrtzZF7GCYB1jmdvYl83EtlgoohY3S213gzAGcxqwM4khGfbsK1UUX2tewcidrKWHE7nQqoVXdSLXU5dj+QprDFGoTb0/Hupj+pHdEvPK2BfG1r14Xwb+ndnv+bJTh518R82GGyGTXzwgHDRgiykBqr3/WGxnQeM/ArJFqAMvE9QB720lmHfQYx2VH+XSud3bZBSu4G/XztvJ0bnqasjnU5DfQ23vRBnRE5GNTmRsAFnZvKKo7iBZuZL5AcE8+fpexP/RWB4DQg4MUlx0nJb9JyqDX68ajBXWmmUfwoo4UZ49KyghXaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vT4c12ypZgPqRRhSDCg4tdbL0qL8ZMw3KlabKzEUyeM=;
 b=RJx2Re5ZMY/RnUUom6X65PMDLLLwQgim6jZHl1HnsGY4l2+RQr/GZmRrVd/dmEhMiKzSrb/ef+r40LZE4IOSPcnHDsOppy2VPu89coU2zRWJXefmA2twJi4B0Fqh229pmt/KwP0I3Ka+CBfjqDDRb+83WmHzaqBlSRdzu4DaCOl6YNfSCGfxp0TtCuKXfP424CvVfdT1SQl8WJWrkLxsuYiNwPFb9pu1T4Ut/J54maqvyEzIOskY7v/F6gDUxYJFkRhXjD+uQQu8XGY8uJ/v+nXv15Exci88kyl0qhJsIbOEnG6SOKBGfpcaJwxhw29OSaZ0bUooTws7y7eFrRYP+w==
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYSPR06MB7300.apcprd06.prod.outlook.com (2603:1096:405:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Wed, 16 Apr
 2025 13:25:34 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 13:25:34 +0000
From: =?utf-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>, Qu Wenruo <quwenruo.btrfs@gmx.com>
CC: "clm@fb.com" <clm@fb.com>, "josef@toxicpanda.com" <josef@toxicpanda.com>,
	"dsterba@suse.com" <dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIGJ0cmZzOiByZW1vdmUgQlRSRlNfUkVGX0xBU1Qg?=
 =?utf-8?B?ZnJvbSBidHJmc19yZWZfdHlwZQ==?=
Thread-Topic: [PATCH] btrfs: remove BTRFS_REF_LAST from btrfs_ref_type
Thread-Index: AQHbrd73jkcBLdMm7Uid+r2d6yAy4LOkaR4AgAAB9UCAAAdpAIAAchcAgAFleqA=
Date: Wed, 16 Apr 2025 13:25:34 +0000
Message-ID:
 <SEZPR06MB52696AF210BDA98300C58FCFE8BD2@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20250415083808.893050-1-frank.li@vivo.com>
 <472ae717-5494-44ae-973a-85249a65d289@gmx.com>
 <SEZPR06MB52691756B32BA90DBE82BDFDE8B22@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <2e158208-4914-4bfb-984a-0d35e8b93225@gmx.com>
 <20250415160508.GH16750@suse.cz>
In-Reply-To: <20250415160508.GH16750@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB5269:EE_|TYSPR06MB7300:EE_
x-ms-office365-filtering-correlation-id: 97ef0974-d181-4f52-16c6-08dd7cea2b3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bzhhKzQvaEljQmUyZithUmY3SDRMTEh5bEJ4eHpiY2xDYm5SdlFxak1iaWto?=
 =?utf-8?B?TnpwQkVjSlVobjIvU1pNaGdzQjRYT1QvRUhiT2hqanBvV2ZNWmF3V2hHbVRy?=
 =?utf-8?B?V1IvZ3BzZHMwV0Q4ckZnUVFvclptMjdVK3NPZnZzdnpTRXl4K2xpekZmUExK?=
 =?utf-8?B?ek1mWkRqVkFtdWxPQlNMZC96ZlE1RTZrc2dqL00xS20yWEpMSEEvZ1JFNnlP?=
 =?utf-8?B?amQxMnM2SVRuLytSMldCd2hpQ1BJQjVPdlRzMVZmSld3a2JoV01VOXk2bDhy?=
 =?utf-8?B?aFlVZ0s2SDliWFJWZ3ExT0phZnI0M0IrbFZRNzMrUGlBR1ZhOUEyL25rQ0RM?=
 =?utf-8?B?R0ZYb2JHUFo4Und3WWpWLzNyT1REYkUwY0pUNytSemY4Vmh2bk9NME01TVpO?=
 =?utf-8?B?Q1NGTjlhb3Z0WEd5Z2o3bnFubjMrSHdxeU56VGY2TW5CZ3djNTl4RVdSVEVX?=
 =?utf-8?B?UWlKTmtxVE4rUzlReE1KM0JseHJ1VGU4bjRPWG16OXpsTEM4cjhwL2Z5ajBI?=
 =?utf-8?B?aDE0VFBQYUw2UVlsejhHKyt2OFkvQi95SXp3elVpK09CYnVuV0tOSWxabmZK?=
 =?utf-8?B?WU5vazkwakgxN2xzUTQvUENZZW1CNEZIb0xJZ3VYTWZBWGFpRTExT3M0QzlD?=
 =?utf-8?B?M25XZ3VHVmtqWmVVUC96b1pkb3MxN053TlZFMkhPZTk5aS9saE01K3B1djd3?=
 =?utf-8?B?dUhDVGZJUytqRHU0aXYvNVlTbUhGSHFybjdXVUNsMnpUS3ZTdHd4RCtIY2pq?=
 =?utf-8?B?WXRLMm82KzgxYmx6ZDFjandnSmRjYXFKS2RNcThlTkFjeExuUGtvZVVFWWRy?=
 =?utf-8?B?ektDL3lHTVlIY21ScU1vaFpBcklqdXVlVVorZGUzZHN6cVh5aUxwRmNaMkVt?=
 =?utf-8?B?OXAwMmQvZVlIMGRVbjlyNkhoNUtKSHN1OUFTWDJqN29VVUllMUxJYi9oQjdv?=
 =?utf-8?B?N05WOFZld0V6b05FOTZYR2dBaktRRU5XYWdHS2ZpUjIzTVIyczhkcXpjVDJB?=
 =?utf-8?B?Nlo0NnNrUTdDZGwxaVpCQTErcTMzZnBUd29OQXdNOERqN204bVFMcFJSb3Ay?=
 =?utf-8?B?U0FvZWxWdFppSWMvVTNiYkxjdlJQVTNDZjM5c0V0VTQ2TlhucFZpblRJOUxD?=
 =?utf-8?B?L1JCMU5XUG5nMU1mamVUNDg0dzQ5WTBUUHgyRHJJL2FvK1MzL1Mvb2hmZmxk?=
 =?utf-8?B?ejFQNURyQ2ZzTVpTN2NKZTlIRHpSVnBNRUwybXNTOUZjSW1kVlpUNnVJQ0lV?=
 =?utf-8?B?MjhCVUdSWjZ1MDFVWDhKUEpGNm1ZWlNnVXFkWUtBNExJOWx2Z2o0NEYzcWE0?=
 =?utf-8?B?UGJUUVVJcyswTW1Kek4rWlBDb0h5OHRWZHZwYmQ4Sml5bVVpY20vaGVIcjNJ?=
 =?utf-8?B?NnNIREZyb2lpQmNFME1EZVA1U3ZycUsvYm9vdis5NmhZc05GUzFvUTV5RmF5?=
 =?utf-8?B?d1lWeGtaWEhHQXNPaWdjTkUwNlNRbWNJT0J1K213NGNCRGowQmxNQmxzZXl0?=
 =?utf-8?B?c29aTEovQW45dWFZakZSVUlFK09ScFJXY1pxWWVEN1M3MU9kcmhHM3dqSDJj?=
 =?utf-8?B?cHZESnRRY0t2VlkvMWNPc013UTYxM2FHdVNjcC9JazcybVBBK2pYVWhnMllj?=
 =?utf-8?B?U3FGS2NUR2FQdmlVOGdJNHZKNkZRZUZHeUpsQlFvcTAyQ25QQkFOby8yWHp5?=
 =?utf-8?B?eU9ZVGNoUWh1QlNpb1ZlTFJ3dThkWG1PSWlGRkVlV1dzazNXOHl3YXhEcG80?=
 =?utf-8?B?VUZjM1NENDJTek9CZkdUUzZGaDhvak1BMjBBVndyM1JYT2VJTW9tdXB0NGYz?=
 =?utf-8?B?Sk1NSXJENFVwVHM5TTBWeVFhNVIzVngxSzVSWEE4ajg0SHdzaXM5YXlaMnNx?=
 =?utf-8?B?Zmh3WDdsclcvb1RjRDFsdVlISFMvbUJXVjk3ekxLajMvOXIydGFDd2Flc3F1?=
 =?utf-8?B?ODE4NlBHNk5IS0dsQ1pMZGROYW9maFplU0dCWmoraHlicllSczBCWmlDdUJQ?=
 =?utf-8?B?Zk5YbHlYVi9BPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Rkdsd1pMa3ZpTW9IU3lJMmdyM1RRVTk3QjhHVk8yYXRVblFQNE1vVzZzU0FG?=
 =?utf-8?B?WU9sb3FrTUMreU9GaTdzck5hczAvREZhQ1lJM2g3Y1hOQjNoKzhEcnVkZFpH?=
 =?utf-8?B?QXpJcnpoa052Q3NqSGNESVJ5RUFLaTJvQzZSVSsxeDYrMkdsWlNaZkZNQlVy?=
 =?utf-8?B?bExMSFVrdC94TXQyYzdNN2RJRGFkcTBRMzlSU0VNdjMrZFRsa2lqK0g4L3ZX?=
 =?utf-8?B?ZGY1eHpCMm1UK1laQStlWWYzWkJZc1d0cTJ2V0VwdXhwRHpGaGpzUDFGYTI2?=
 =?utf-8?B?ejcveUVWVEtsckg0TU5VYzFsMUFwS2kvNGNMb2F4WXd0a3RtdDhoUldvZXhG?=
 =?utf-8?B?R2ZmWE1LZldBVTRxUC9Cd0hLdk9oWks2VWl1NE4zZTNDM0pSVDVMRm1HVlU2?=
 =?utf-8?B?WkovY0Nsc3VqQ2hBd0xrV0E2LzlDT3FhZTBYSXIxRnRIVndQa2t3aDYrOC9N?=
 =?utf-8?B?Y3ZnSzBYd2VBbmw0ckFBUTJVTEZtRzFCYTJPUW91YitQV2QwSnVFdFlpWTVs?=
 =?utf-8?B?aHY0MCtwcis3VTd4UUE2Z1JUVkxWTi9BYjBWREk0WmJMNURLRThPUWY4QUJ1?=
 =?utf-8?B?Zldaa0JpVEY1Z1U5eWdCSjFxVTZoWTNqcnRxMGFodTBOOXljamdZUmtDVkZi?=
 =?utf-8?B?TExvOTc0UW02V0FKNjlGYlpvek5JME9Zdi9zUUg2YUMvempQTXAwKzVuaVls?=
 =?utf-8?B?Tmw0ZFBaRWVwYmlIMVlFWjdRK3FlTlhHbm5CT29Rd0RFQlpESW9RQVJ3OTJy?=
 =?utf-8?B?NDJCOHBkbnptOWRRV3RlSTdpQTZVNTZub3k2TVJlek1aaEppdkpnMFFLWWgv?=
 =?utf-8?B?L2s4TVZSMXcxR0JQVUYyYTVHYkNuSG5PMW5aMUpKV1hiMHk5dzdXeXY4bkR0?=
 =?utf-8?B?UWdjZC9VNnhmYi9yQlh3Q090alpaOVdyOW1NM2NOSG9kZ29GZk5OZjVCdTc3?=
 =?utf-8?B?ckJMaFloYlFzT2tpejluaGtZdTZQRUVKVmZpQTJLcnhzbEh1SGYxZEQ3NG0w?=
 =?utf-8?B?Wko4NlFpb0xGSmFIZWdVSTZ3TzFOSXA5b2pZVTRYbitNNDRrWmJJdkdVNVlw?=
 =?utf-8?B?cXFmcmx1Wm1rOFUzVDU3emFuQ2piMkpzL3Z5WENqWm5jSW52RVNFdVhWS1Rl?=
 =?utf-8?B?OXpaU3BKS3g5RUxPSnN4ZTdyQVZvRUd5c2dkLzJyc2d4Mm1vTWh4SGpvc0dx?=
 =?utf-8?B?S1BHNmVwV2FmaWoxMHlNYkJsbzlJbC8xbE9DUzRZNjRtRVY0bkxtMHBxbGgy?=
 =?utf-8?B?b1BLN1dlU0tITVBDcEQwbStpSmlTUERBT2J0V0xEdzhYMUY5MVhKVHNhYWFz?=
 =?utf-8?B?Tm95NE90QytQdEtoQjdmY3hKbTRndGNYdWt6b05IaVY5Zkd1emRUQTF0Y3FR?=
 =?utf-8?B?UXRsWk42N2lVK1FHL3cyUVI2QWwwR3dQN0Nscmh2MDAwRy85c0VJTDFaR0Uz?=
 =?utf-8?B?U3Q3cXdOVmZiZmE1NkVVS1JFWHRUTmp1L3hiQWJ0Ni9XczVUNjFFeU5GRjlr?=
 =?utf-8?B?TThFdklsa1ZhMXFCdkhsTFdHN2JLNDZqOXFLd1MvVlVLTkNpa1BzWVR6OVdZ?=
 =?utf-8?B?SXNYM250UlRUL040bDExZTEwWVdVSzVyaERtdE5HdG42dXFCMTZlOXVaV3h5?=
 =?utf-8?B?RGV5enB3TUJOZ1lwbVVrOUF3UElFRzZuS2c3T1RYTWFOeHdlV2V0TUZ1emNy?=
 =?utf-8?B?aUdrRDIySVpaZkRUUTYrNHZzazkrQVBreXFrcFR4VkdYcXpRQ2ZZOXNWekZv?=
 =?utf-8?B?cTNLaWVwYkhnTzNOT3p0ZGlWL05wL2xPMFdmdU1MaWt4UWo0MXUrZkh4djhL?=
 =?utf-8?B?c3JSYWkxK3B3dGMzQjBDMS9WT3hhTVpRT3IyZ1MvUFh1RDRDZlB3NEhGWE5u?=
 =?utf-8?B?TjhFOXNDY1ZNWXlScXdJM0k1M2M5aUVoRUZUQWZpZlA5SkdONGthRlZ0WlNS?=
 =?utf-8?B?MjZycExKL0lUbHZzSHZLd3VERys2Yk9LdGV2UzRxWGRwMXJkc1RVcXIrMU1m?=
 =?utf-8?B?cE1UMlJpM0xza2xyMUcxMFBDNUx6MHNzdXRYMDBTZ1F4ejBCZFdFbGdLZGRJ?=
 =?utf-8?B?YVBDU3d2U1B2WWxVRzR0UjNGYWFLOUYyVWRxOXRyUGxrQy9UOHUxWHFTak5V?=
 =?utf-8?Q?H1rc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ef0974-d181-4f52-16c6-08dd7cea2b3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 13:25:34.5879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yIXYAFDSDIX5vFw79E7JsXCEJRQRWjTQLw3xlroPY5vVGrnGIABr0Clr2AYzzO1NcwWBPhxK8BWIf/7WlzYF1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7300

PiBJIHRoaW5rIGluIHRoaXMgY2FzZSBpdCdzIG9rIHRvIHJlbW92ZSBpdCwgYWx0aG91Z2ggSSBh
Z3JlZSB0aGF0IHdlIGhhdmUgdGhlIF9MQVNUIG9yIF9OUiBlbHNld2hlcmUuIEluIGJ0cmZzX3Jl
Zl90eXBlKCkgdGVyZSdzIGFuIGFzc2VydGlvbg0KDQo+ICBBU1NFUlQocmVmLT50eXBlID09IEJU
UkZTX1JFRl9EQVRBIHx8IHJlZi0+dHlwZSA9PSBCVFJGU19SRUZfTUVUQURBVEEpOw0KDQo+IHdo
aWNoIGlzIHZhbGlkYXRpbmcgdGhlIHZhbHVlcy4gVGhlcmUncyBubyBlbnVtZXJhdGlvbiBvciBz
d2l0Y2ggdGhhdCBjb3VsZCB1dGlsaXplIHRoZSB1cHBlciBib3VuZC4NCg0KRG8gSSBuZWVkIHRv
IG1vZGlmeSB0aGUgc3VibWlzc2lvbiBpbmZvcm1hdGlvbiBhbmQgcmVzZW5kIHRoaXMgcGF0Y2g/
DQoNClRoeCwNCllhbmd0YW8NCg==

