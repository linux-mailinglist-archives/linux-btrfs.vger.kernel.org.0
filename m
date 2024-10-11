Return-Path: <linux-btrfs+bounces-8849-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2FB999F5D
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 10:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88C101F25A07
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 08:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C47620C461;
	Fri, 11 Oct 2024 08:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="q6iUtjW1";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Tn5Nbtz9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E0320ADE7
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2024 08:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728636818; cv=fail; b=fd9fdOLmHbJFiEYU/7OBml6iLnNHSeqZYGyls4nzleU9uldge+vHpV6OZMXT8oZO2AMsUY3W9KMQSimOj95pJ4zjKO2ZNx2cxb/Y4Cex/M/0Gbh077FXd5zbMMkptK/cr6JBDa2LMzB9H+J8C7HMtQDpf2S6K2Wgu99hLSE93R8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728636818; c=relaxed/simple;
	bh=57bWjEdZYv2YDlhT6zQNid1P9Tw6gC0/5sbgmPfJCQs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UWVSz1JSLhO4fY5AyChjBw0qq66oDeIM6cjyQkTQoVeoSNn7sJdtlksV1vAfIbZ8+767wopnSG/qPFdba2CvyP/UGSF8sKnWzIaIseVzACgwDtjPqLyGmles8y0Dv+p0Ebgt+3C+McAtYD6nwDyO0/IMv2q+m2VyyyiHDTMWr6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=q6iUtjW1; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Tn5Nbtz9; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728636816; x=1760172816;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=57bWjEdZYv2YDlhT6zQNid1P9Tw6gC0/5sbgmPfJCQs=;
  b=q6iUtjW1dn087xohWu2qpPUyZGKnuDRIfJ+kxqLAcitBUNc85oO/aI8r
   RBCBxGLKa/mSa0oBGSGmUGF8DWX8Zs3shsT2HYZwV8GtskcfliZFMDtWu
   uLrgyy6Clwb01r6gXSoIOudVdtP69UwCug1aaJx9sNhSJ7JUxF9F4R1ct
   KquVYDZC11gcgj7rVsw/QK1PCnyNcgbqd2q7TttQtsBZutEq3W1oYNKrw
   r1U7Tev/97/27xDguCh6i2DJubX0h9Q7vSCVzQzgty1CMGd6tWqxGxpIv
   ZGN0jaj0HNMibn1ssv8s3ciJdj6qnXUnyMoyghp+3JP3/EGG/qEhc9bI4
   w==;
X-CSE-ConnectionGUID: 1kCSCB8SS0Wj1lpwG+KE7w==
X-CSE-MsgGUID: 3M+DRhiuR3OAvp0OtlnAqQ==
X-IronPort-AV: E=Sophos;i="6.11,195,1725292800"; 
   d="scan'208";a="29842718"
Received: from mail-westcentralusazlp17011026.outbound.protection.outlook.com (HELO CY4PR02CU008.outbound.protection.outlook.com) ([40.93.6.26])
  by ob1.hgst.iphmx.com with ESMTP; 11 Oct 2024 16:53:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wVkfiegivcxN/M/Tkjl+NYDJ9hiiOhjyjrDBQlnASPlxkg5OWlx1shE199lq/s6xGWGIVoXpcqqgsb0UqMqcFm2lLkjxJUXxrznutyqTR/IQGq5foDTUuL+4I/gYZaCxvakQeQ2wQAwDccQ456829CHwUY5i6nOluyTEcHtOLniSY9ZzICRundLllWBr8hbrixIBblZ6mWjk7m9aEhJea6TGxUkIFsNgD6fn3O1bax8tUBZBwvzLLSjwuqQup0eQw1AUuKiPg8bGQ21tpBMYGEbYf+HhgM7NBF4Z/+JJXmjCAMKzlyjpJ8lDQm56HEW+BmvPrAwlvFmaLgh/DCBh5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57bWjEdZYv2YDlhT6zQNid1P9Tw6gC0/5sbgmPfJCQs=;
 b=MDd8h3MhqEVGIrBWKJSPEFZC1hp/yBZIrwcu3Ly5huE0Vrhwyr1uQhWkInrhl8rmSGJCoGj/TULfgTETWq5kfyiuEpNJQR/LvwgsqLpJB3Mp8EwRa6Wp7LTiiUeMZsJftnw1iwQrVUN4j7pVND3Keqy0lqjosU+BaGtQimFzjvPGCLG3TzUSUF5l4DYH4KljBwg1JejXtG+MN3iRsPOZcZR7+ntYeFhgvLDXq2FgmG+DGE258xXKo60jsYOiq5ll4vxLzFYysQOcuwEVnaoma0CYJu4LCkFciQGU9zcVYc0I8bwJYanZYYam4ThBrP7CIz7BwWhWrbUS6zsta/gJpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57bWjEdZYv2YDlhT6zQNid1P9Tw6gC0/5sbgmPfJCQs=;
 b=Tn5Nbtz9VLZxmqsqH0B1joFmtJRieQEUK2TvVrDPTBKS+ZFf7n3qTgooezcih06NJwe1BtJg/cFH9u+uFaExSqVFR/Xtk6xPbkLPuu1xn07edn9EzjXKI6oJ0cr4bxZzX++5TyglHYXBGkQyU4WdHzkhj1t0xqE9tAa/SmLnD0E=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7439.namprd04.prod.outlook.com (2603:10b6:a03:29d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 08:53:28 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 08:53:27 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: WenRuo Qu <wqu@suse.com>, hch <hch@lst.de>
Subject: Re: [PATCH v2] btrfs: fix error propagation of split bios
Thread-Topic: [PATCH v2] btrfs: fix error propagation of split bios
Thread-Index: AQHbGy1H1b/kH8JxM0ea7piwH31vJbKBP7iA
Date: Fri, 11 Oct 2024 08:53:27 +0000
Message-ID: <20cb82a2-0e40-4b28-99c2-5ed1ea79d957@wdc.com>
References:
 <1d4f72f7fee285b2ddf4bf62b0ac0fd89def5417.1728575379.git.naohiro.aota@wdc.com>
In-Reply-To:
 <1d4f72f7fee285b2ddf4bf62b0ac0fd89def5417.1728575379.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7439:EE_
x-ms-office365-filtering-correlation-id: 53ecd513-0ea7-40a9-db4c-08dce9d22c6b
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UVFzaWJBRC9oblNZS1Q1UEVBMWhTN3BmSDRwWnd2VnRCTzVIRG51eGJlSVZy?=
 =?utf-8?B?ZW9YeDdMVDhLc2I4N3E4emg3bGJvQVdoV2lyd3QrUWc3SHpzZHo2SUFweU55?=
 =?utf-8?B?Vmxpbjd6ZERzVXFKQ1hRQjZMK3h0OFFsN3JrQytESzJScVE1bW5IYTNHV1N1?=
 =?utf-8?B?QlRWeXNFODcxQ3plZ0dHSWdrcnIwdVhqOEVua2RudHNOeFI3djcxRFc1eWVL?=
 =?utf-8?B?OUJOQVJvNWhTS2FLQkNWQUMxazRlTjl2VVVsMXZ2c1cxL1FOQVVaT0R0by83?=
 =?utf-8?B?ZC84THpleVJaU3RNck9YeXdleVM5VUNURk9KUjJuK0FnbUV0Z2EwWkV2b0R5?=
 =?utf-8?B?SVBwbXhYbnBxaWFhUnd2ZFNMVGIzSWQ3ajhNRFRkZmk5NEltUzJPb0VXTTkr?=
 =?utf-8?B?SEZHbXZCc1gzc0ZMczdnSGN2QjhGejNhL21udFlaZFFBRHVkTTNXNm5aY0Fn?=
 =?utf-8?B?MTAzV2ZyakxnNTlJTFdIZ3ROVStMR09zQjB2dXAvc1YyVlVwNzBrNTAxUUNi?=
 =?utf-8?B?VFJ6Nk4yU0J4bVd4UWVhRjltQ2grRHIzUWRPQ1g0WW1aV29rcmRRdmJnMEJS?=
 =?utf-8?B?RFpWY1NOYWFoWkhFV2tzTEZYcGVLWk05eGhPbGpmS01VMGVnVVlnWWxCeVJk?=
 =?utf-8?B?OXdBN3BQRWJRVkdqWEFjcjNsYVRtdlpMSXBPSXNqQnJhMXNPZ3VPRm0yUmtR?=
 =?utf-8?B?bXJtbHZrdTRKbkNzN3RBOHpTRURnZGsycng3M2RnTGtvNXFSVDZXTlJxanVp?=
 =?utf-8?B?dWJJTU1GK2R5dDFMaFQwSUlmRlUrNSsybFh6aU05MTZJb3p3QTRFdjAvdWYz?=
 =?utf-8?B?RTdIeFhISjhwT09CY3M2M2VoQnNRa0VpN0hvVENvTjdOWFovRFRRYThYczVS?=
 =?utf-8?B?cDhMUHVZNDVuNnF3ZmJ3ZXRWamMzR1NQR2ZwUGlKWTFkNnIrTWx0N0xzYTNG?=
 =?utf-8?B?V282RDBTN0RqTGU2M0FlckplQVROVEw4TFplMW1LZ1lBaU1WN1IzRXRMRlA5?=
 =?utf-8?B?TUxmZWF1ZENnVnh4UFVIN2lkMG5ibW1jdlZuOC9LK2ZXaGpab1Q3THhISG8z?=
 =?utf-8?B?SWM4ajdsTjhQcElGbEs0SzFEM2ZwZjVoQ21mc292T3JBeGErWVVvMWpHZi9L?=
 =?utf-8?B?U1dGcGlEcHhBU0NQTkE2VlJ4WkxUeTZGRlpTeWdhMTVSTnpJbVgyNXRscnFi?=
 =?utf-8?B?aDdUVFJ6R3NGRURLWTdyVHF3b2hWdDdMeHJHTlpwSy9mdnZzeEVneWdhVUpr?=
 =?utf-8?B?d0l0bXAzYUZoMW9NbkUrQmxYME9JeGxWZzJYL1RYOXpiNURDS2kzVy9BcHNJ?=
 =?utf-8?B?d1NFc0dVVWhCbStKV1VlVGNnQnBoY2lSeEZkUmN6NGIxR0ZpSi9uTHJmNTFP?=
 =?utf-8?B?SFFjak50Sng4cUFhUHdrd0EzWmNpZlNQVGpQQTJjMzY5YnlxRzJaRmYvVlBt?=
 =?utf-8?B?dmIySUZoK1g5SzBwcUwyUnJnVU5mOEM3MHJEVHZ1THpYaUt4UWRQZW1Dc2h4?=
 =?utf-8?B?RXZSMEpVUHg1YzBKNEdaYW5oVUNiZVhHcnA5clZtQVJyR3F0V0FiMTdMN2J2?=
 =?utf-8?B?b0ZUYVRLd1JMT2NvelFlTUFWd3RHc0p3SllHbmVXZ0ovRUp6Vldjb0ZSN1h0?=
 =?utf-8?B?c29wMXo1cFJtam1uM0txQ0VGbmV2dTVJc1N4Z0pqT2xkZmxYUDA3bjJ0L2xt?=
 =?utf-8?B?VmRKR3BLM1JCMElnY0JydWhFSTE2ZUt6U2J5OFZIZW12c0wvREo4WEdFaU5O?=
 =?utf-8?B?azlZNHF3NlF5YnFkOTNheXIra1JIQlRXdXJwZlNHNEt2V0tCRXpJRW1vd294?=
 =?utf-8?B?KzE5eDA5d1dwd2xEWGtDdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z1hUMWVoQ25GYTZ6dzBGUTJvQmhWbFFmaEp0T2crNk4zak91TExnREtwdHJt?=
 =?utf-8?B?SkNRWXFCVFdEbFBENTcwTHY3SVBwcnprT29UcncveXZNNEwxMUJMSFgyM3h3?=
 =?utf-8?B?amsxQmp4TnpmNmg4L0d4dW5oNFhWNUdiVjBZYXdINytJZkFMOEFpRzhWSUda?=
 =?utf-8?B?RWVHVjhseTNkMTR3eUhoQ3BBdlpKMWRiQlJhZVhHOFMwT1VaMElpNVROUHln?=
 =?utf-8?B?cDh3c3lvRDN5M2RZM2JzNGh4NEw3T0JlRXVmQ2xvWUgzSy9NejQwVlhDRVgw?=
 =?utf-8?B?UEIrMmt1KzlGTTJMM2xWVEZVQS9uWGk3eUxhN2VBeUF2OWxzRlE5Zit1dC9v?=
 =?utf-8?B?MjRGd1p4N1c3SHhvN25xWWNzUGpKQTBaM1VmZXFIejM0azFDelFQQXl5cVJk?=
 =?utf-8?B?bEM2Nmhwd3VNN0Uya0tvV1pDWUJ1V1NlM0lEbWlPeW4zZ3R1OWt2aENScm0z?=
 =?utf-8?B?SU00SHByMEozaTQyNzdsOHdiMGRYNEMvT0ZvakRkSDg0MVZWblVZT0F4WE1w?=
 =?utf-8?B?Y2xHUlY2enAzME5oamk0bFZhTFpIREhNMEptcHNLRXhrUUVoR0tqbjNrTmdR?=
 =?utf-8?B?WDdNdlM0Wk9Tcyt3b3o4SEhqNWN2Vk1BWllaS2podS83dFdsMDRiakcxUS9F?=
 =?utf-8?B?ZnNzOWtHOUpPaC9GTnZvY3kxVzgwcXRZQ2J1NU9panFwYTBwdndtNTdvVDFR?=
 =?utf-8?B?Yi8wYmNmTEF5TU1ocE9VNXpuRklqTG84VUVkVXVqZzhpS2xkREVHc0JIelA2?=
 =?utf-8?B?S3ZGTGE0b3VUZkt3dGZxZm1GMUhoZ1hHTkJQT0RJbzJTdHJUVkN5dTZQMlNj?=
 =?utf-8?B?OWZDRkcvYmpGYXlUbkpiVDVJRlRrd3N0b204UEQ3SjNrVFpaYmV4b240QVVs?=
 =?utf-8?B?Y1MybkpTUDllem9VL3ROVHhxcGRMQVJ5NUZPc2ZaM2xkNUpaYkU3T2dUTE1y?=
 =?utf-8?B?RndQMlJUbGhVQVc3aUdlOTUyVzRFZll6VWswdzFna2V6bi81WHpBYkJJSzhV?=
 =?utf-8?B?My93bmhNUDRBR3hSaUJBbjlNMlJ2V1FFRDY4emk5dFl0U0FCWUNMRlVNdmpK?=
 =?utf-8?B?OGlKaS9nRDdDZHpQSmNyVmlyWUFtK3J6QUY0eEVEYzU5cVpwUWE1UnhoOHla?=
 =?utf-8?B?WGJ5d3V2MzhybTR3MmhyL1ZkWWNjZ1JMZkVPT0ZoL21QZGdQeTlaNUtHN3BW?=
 =?utf-8?B?NkJkOXpwMG15U3dqSXVIdlM3TnVUanhKZW1zaXFMUS9aRS9lTm5IU0ExN0tz?=
 =?utf-8?B?TXUrMzhTeEJ1NTZWaE1EU1NZeWtrZnViZnppaTBxUEVWMUhjcU92WTVGZlVO?=
 =?utf-8?B?RHVsSWMwK3VnVVp1OERPY0U4UkRpWERHKzlFSTNEUzc5MHo3WFdpYzRubHhG?=
 =?utf-8?B?ejlqUUs3U2F1a3FTMXhRQmx0czNFL29xWDMzMVRMVGlpeXFWQUdQMnhZbTVR?=
 =?utf-8?B?QUVmQS9yZGRuYW5xeEdCYTJIMUwvNTE3dzluRVF0aXQ3SExpcW5tWFE0OFhU?=
 =?utf-8?B?K1RXa0RuRFdaYnVuQm9Xak56NTlZQm90RmVVaHQvWk5vdG5qeldYSXRVYVoz?=
 =?utf-8?B?SjJmWURFNlNqTmlWS0JLOGVkbnJLWVhKaHJtUEc0cDFobTI2dWxsaDJPVStY?=
 =?utf-8?B?L1N1eXpHeEV2QytnR3N6OEtXLzVZenRBT00zMjY2ZnlPbm05WEVXQytRLzhp?=
 =?utf-8?B?UzBVZUJMTEU0cHd5WDlUKytna01LVjNHUTBVakxPWld3Y2JyV2dTam9tbWNF?=
 =?utf-8?B?dkJhUzNNSDJjaFRZWmsvSHRjUXNScUNSM3JyZ0YyY2oyemRxVEhrZEFtSG1N?=
 =?utf-8?B?Tmxnc2lNS2tNdTBDQ2ZnamhCcmY4TXZrQmxONk5sQVcxKzN0a1hQREF3bXQv?=
 =?utf-8?B?Vm5lcCtZYXpYc09FdWZ3N1RmVVllTDk3cDNRZmFMNjcwMUY1RG5mQ1JXeDFp?=
 =?utf-8?B?VmtsTVlkbENESHRMbFQvNlRFTlFQQmhYdVdSdGVMMkdpRVAwUkIxMW9xSzNt?=
 =?utf-8?B?dmowNER2QVVkd2hJelY4R1VUbnp1YkltZ2VuOXRrcW5HSjhpc1JhMFoxeXMw?=
 =?utf-8?B?NUU1ZTVvcTR5V0VmeTFDUEN4eGt4dHpQL1RNSkROUUNjKzQvYll4bFRuZEVt?=
 =?utf-8?B?Tmt2QUI4NVp4aHIwcW9kS1VUMlVIcUVQQ2xEei9GRHBvQnpQVW5kdXlpeWY2?=
 =?utf-8?B?OEZGVlJNUkgwWXFwN0ZTbURFSzVJYkZoTHFIMERyTHZyR3oxbXBScEpNZE96?=
 =?utf-8?B?OGxtcVF5d1d3VjQ0Z3VtS3dSTFRnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <16736D2F2C07F54FA47E374DFE2F5D22@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Pulr0lDL4DKY0RHk1vaicQSZSckW93W3bflyRWwOAe9M6Iwbg+7uK6jEv0EZJJmdYTz+zs7qKCbkGxfvFHM187zMiMc10f0+K6lGGJZfIIusmkoCP/dVbBdy0fe0bBfDaQm/BNlLoZrNKtlH/FVusDVz8F13P4JoZJqlEEKXIPECmlit748xYKUKCgsxnHjvv5tOGAKgtKdZyDYdSDDN0MmiF3IDwvuX0a0x3RB6XxWKQBxgNUy3xigfqzd+rc5ayu1PEQfcexqJlFAJK62+rhxzItfoze2vOX26xcOXefmDxOiK/4CT+X+KPWVWayd47ky+25lyC11xPrLjiprNR+lHZn1voeJQRQO7cx7txkMn+vgdrxFTz+YMdgyCYBIiCf++qIgo0zMSuGYZoPq+wDQkqfBEdB+DXJ5F2JRFlVU1q/dr7rmJj66HCA9LzIBesdVVSi9Z/lkNi1oIIAB/4ys0ha7bPfJo4jSrOOKm1IOJOKa1Y5hejrEPcIFWdEfOaRuzP+F0YlRvRIqpmH9VcTzkMvnE5bxtJB/rlwLwRIQ7PNo1Vh2fFLKMygQvjyuODWdD0OBFBw8riqGcYF/WgfHxxXOsr8/BH46vYtjv3Lb9W5fo2itSqs8Xi+rHMcX6
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ecd513-0ea7-40a9-db4c-08dce9d22c6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 08:53:27.7263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q8jcjA0XZbpJoC6JUkACpUHJsekDqh9x0IReOeopqz8gOsdqgSR4Wmo/eP3H5pBcrwFPYVdzZ77ATisSJwCx9wyyATxtVb+Aa7TItRzMmqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7439

T24gMTAuMTAuMjQgMTc6NTgsIE5hb2hpcm8gQW90YSB3cm90ZToNCj4gDQo+ICAgICAgWyAgIDIw
LjkyMzk4MF1bICAgVDEzXSBCVUc6IGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UsIGFk
ZHJlc3M6IDAwMDAwMDAwMDAwMDAwMjANCj4gICAgICBbICAgMjAuOTI1MjM0XVsgICBUMTNdICNQ
Rjogc3VwZXJ2aXNvciByZWFkIGFjY2VzcyBpbiBrZXJuZWwgbW9kZQ0KPiAgICAgIFsgICAyMC45
MjYxMjJdWyAgIFQxM10gI1BGOiBlcnJvcl9jb2RlKDB4MDAwMCkgLSBub3QtcHJlc2VudCBwYWdl
DQo+ICAgICAgWyAgIDIwLjkyNzExOF1bICAgVDEzXSBQR0QgMCBQNEQgMA0KPiAgICAgIFsgICAy
MC45Mjc2MDddWyAgIFQxM10gT29wczogT29wczogMDAwMCBbIzFdIFBSRUVNUFQgU01QIFBUSQ0K
PiAgICAgIFsgICAyMC45Mjg0MjRdWyAgIFQxM10gQ1BVOiAxIFVJRDogMCBQSUQ6IDEzIENvbW06
IGt3b3JrZXIvdTMyOjEgTm90IHRhaW50ZWQgNi4xMS4wLXJjNy1CVFJGUy1aTlMrICM0NzQNCj4g
ICAgICBbICAgMjAuOTI5NzQwXVsgICBUMTNdIEhhcmR3YXJlIG5hbWU6IEJvY2hzIEJvY2hzLCBC
SU9TIEJvY2hzIDAxLzAxLzIwMTENCj4gICAgICBbICAgMjAuOTMwNjk3XVsgICBUMTNdIFdvcmtx
dWV1ZTogd3JpdGViYWNrIHdiX3dvcmtmbiAoZmx1c2gtYnRyZnMtNSkNCj4gICAgICBbICAgMjAu
OTMxNjQzXVsgICBUMTNdIFJJUDogMDAxMDpidHJmc19iaW9fZW5kX2lvKzB4YWUvMHhjMCBbYnRy
ZnNdDQo+ICAgICAgWyAgIDIwLjkzMjU3M11bIFQxNDE1XSBCVFJGUyBlcnJvciAoZGV2aWNlIGRt
LTApOiBiZGV2IC9kZXYvbWFwcGVyL2Vycm9yLXRlc3QgZXJyczogd3IgMiwgcmQgMCwgZmx1c2gg
MCwgY29ycnVwdCAwLCBnZW4gMA0KPiAgICAgIFsgICAyMC45MzI4NzFdWyAgIFQxM10gQ29kZTog
YmEgZTEgNDggOGIgN2IgMTAgZTggZjEgZjUgZjYgZmYgZWIgZGEgNDggODEgYmYgMTAgMDEgMDAg
MDAgNDAgMGMgMzMgYTAgNzQgMDkgNDAgODggYjUgZjEgMDAgMDAgMDAgZWIgYjggNDggOGIgODUg
MTggMDEgMDAgMDAgPDQ4PiA4YiA0MCAyMCAwZiBiNyA1MCAyNCBmMCAwMSA1MCAyMCBlYiBhMyAw
ZiAxZiA0MCAwMCA5MCA5MCA5MCA5MA0KPiAgICAgIFsgICAyMC45MzY2MjNdWyAgIFQxM10gUlNQ
OiAwMDE4OmZmZmZjOTAwMDAwNmYyNDggRUZMQUdTOiAwMDAxMDI0Ng0KPiAgICAgIFsgICAyMC45
Mzc1NDNdWyAgIFQxM10gUkFYOiAwMDAwMDAwMDAwMDAwMDAwIFJCWDogZmZmZjg4ODAwNWE3ZjA4
MCBSQ1g6IGZmZmZjOTAwMDAwNmYxZGMNCj4gICAgICBbICAgMjAuOTM4Nzg4XVsgICBUMTNdIFJE
WDogMDAwMDAwMDAwMDAwMDAwMCBSU0k6IDAwMDAwMDAwMDAwMDAwMGEgUkRJOiBmZmZmODg4MDA1
YTdmMDgwDQo+ICAgICAgWyAgIDIwLjk0MDAxNl1bICAgVDEzXSBSQlA6IGZmZmY4ODgwMTFkZmM1
NDAgUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTogMDAwMDAwMDAwMDAwMDAwMQ0KPiAgICAgIFsg
ICAyMC45NDEyMjddWyAgIFQxM10gUjEwOiBmZmZmZmZmZjgyZTUwOGUwIFIxMTogMDAwMDAwMDAw
MDAwMDAwNSBSMTI6IGZmZmY4ODgwMGRkZmJlNTgNCj4gICAgICBbICAgMjAuOTQyMzc1XVsgICBU
MTNdIFIxMzogZmZmZjg4ODAwNWE3ZjA4MCBSMTQ6IGZmZmY4ODgwMDVhN2YxNTggUjE1OiBmZmZm
ODg4MDA1YTdmMTU4DQo+ICAgICAgWyAgIDIwLjk0MzUzMV1bICAgVDEzXSBGUzogIDAwMDAwMDAw
MDAwMDAwMDAoMDAwMCkgR1M6ZmZmZjg4ODAzZWE4MDAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAw
MDAwMDAwDQo+ICAgICAgWyAgIDIwLjk0NDgzOF1bICAgVDEzXSBDUzogIDAwMTAgRFM6IDAwMDAg
RVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzDQo+ICAgICAgWyAgIDIwLjk0NTgxMV1bICAg
VDEzXSBDUjI6IDAwMDAwMDAwMDAwMDAwMjAgQ1IzOiAwMDAwMDAwMDAyZTIyMDA2IENSNDogMDAw
MDAwMDAwMDM3MGVmMA0KPiAgICAgIFsgICAyMC45NDY5ODRdWyAgIFQxM10gRFIwOiAwMDAwMDAw
MDAwMDAwMDAwIERSMTogMDAwMDAwMDAwMDAwMDAwMCBEUjI6IDAwMDAwMDAwMDAwMDAwMDANCj4g
ICAgICBbICAgMjAuOTQ4MTUwXVsgICBUMTNdIERSMzogMDAwMDAwMDAwMDAwMDAwMCBEUjY6IDAw
MDAwMDAwZmZmZTBmZjAgRFI3OiAwMDAwMDAwMDAwMDAwNDAwDQo+ICAgICAgWyAgIDIwLjk0OTMy
N11bICAgVDEzXSBDYWxsIFRyYWNlOg0KPiAgICAgIFsgICAyMC45NDk5NDldWyAgIFQxM10gIDxU
QVNLPg0KPiAgICAgIFsgICAyMC45NTAzNzRdWyAgIFQxM10gID8gX19kaWVfYm9keS5jb2xkKzB4
MTkvMHgyNg0KPiAgICAgIFsgICAyMC45NTEwNjZdWyAgIFQxM10gID8gcGFnZV9mYXVsdF9vb3Bz
KzB4MTNlLzB4MmIwDQo+ICAgICAgWyAgIDIwLjk1MTc2Nl1bICAgVDEzXSAgPyBfcHJpbnRrKzB4
NTgvMHg3Mw0KPiAgICAgIFsgICAyMC45NTIzNThdWyAgIFQxM10gID8gZG9fdXNlcl9hZGRyX2Zh
dWx0KzB4NWYvMHg3NTANCj4gICAgICBbICAgMjAuOTUzMTIwXVsgICBUMTNdICA/IGV4Y19wYWdl
X2ZhdWx0KzB4NzYvMHgyNDANCj4gICAgICBbICAgMjAuOTUzODI3XVsgICBUMTNdICA/IGFzbV9l
eGNfcGFnZV9mYXVsdCsweDIyLzB4MzANCj4gICAgICBbICAgMjAuOTU0NjA2XVsgICBUMTNdICA/
IGJ0cmZzX2Jpb19lbmRfaW8rMHhhZS8weGMwIFtidHJmc10NCj4gICAgICBbICAgMjAuOTU1NjE2
XVsgICBUMTNdICA/IGJ0cmZzX2xvZ19kZXZfaW9fZXJyb3IrMHg3Zi8weDkwIFtidHJmc10NCj4g
ICAgICBbICAgMjAuOTU2NjgyXVsgICBUMTNdICBidHJmc19vcmlnX3dyaXRlX2VuZF9pbysweDUx
LzB4OTAgW2J0cmZzXQ0KPiAgICAgIFsgICAyMC45NTc3NjldWyAgIFQxM10gIGRtX3N1Ym1pdF9i
aW8rMHg1YzIvMHhhNTAgW2RtX21vZF0NCj4gICAgICBbICAgMjAuOTU4NjIzXVsgICBUMTNdICA/
IGZpbmRfaGVsZF9sb2NrKzB4MmIvMHg4MA0KPiAgICAgIFsgICAyMC45NTkzMzldWyAgIFQxM10g
ID8gYmxrX3RyeV9lbnRlcl9xdWV1ZSsweDkwLzB4MWUwDQo+ICAgICAgWyAgIDIwLjk2MDIyOF1b
ICAgVDEzXSAgX19zdWJtaXRfYmlvKzB4ZTAvMHgxMzANCj4gICAgICBbICAgMjAuOTYwODc5XVsg
ICBUMTNdICA/IGt0aW1lX2dldCsweDEwYS8weDE2MA0KPiAgICAgIFsgICAyMC45NjE1NDZdWyAg
IFQxM10gID8gbG9ja2RlcF9oYXJkaXJxc19vbisweDc0LzB4MTAwDQo+ICAgICAgWyAgIDIwLjk2
MjMxMF1bICAgVDEzXSAgc3VibWl0X2Jpb19ub2FjY3Rfbm9jaGVjaysweDE5OS8weDQxMA0KPiAg
ICAgIFsgICAyMC45NjMxNDBdWyAgIFQxM10gIGJ0cmZzX3N1Ym1pdF9iaW8rMHg3ZC8weDE1MCBb
YnRyZnNdDQo+ICAgICAgWyAgIDIwLjk2NDA4OV1bICAgVDEzXSAgYnRyZnNfc3VibWl0X2NodW5r
KzB4MWExLzB4NmQwIFtidHJmc10NCj4gICAgICBbICAgMjAuOTY1MDY2XVsgICBUMTNdICA/IGxv
Y2tkZXBfaGFyZGlycXNfb24rMHg3NC8weDEwMA0KPiAgICAgIFsgICAyMC45NjU4MjRdWyAgIFQx
M10gID8gX19mb2xpb19zdGFydF93cml0ZWJhY2srMHgxMC8weDJjMA0KPiAgICAgIFsgICAyMC45
NjY2NTldWyAgIFQxM10gIGJ0cmZzX3N1Ym1pdF9iYmlvKzB4MWMvMHg0MCBbYnRyZnNdDQo+ICAg
ICAgWyAgIDIwLjk2NzYxN11bICAgVDEzXSAgc3VibWl0X29uZV9iaW8rMHg0NC8weDYwIFtidHJm
c10NCj4gICAgICBbICAgMjAuOTY4NTM2XVsgICBUMTNdICBzdWJtaXRfZXh0ZW50X2ZvbGlvKzB4
MTNmLzB4MzMwIFtidHJmc10NCj4gICAgICBbICAgMjAuOTY5NTUyXVsgICBUMTNdICA/IGJ0cmZz
X3NldF9yYW5nZV93cml0ZWJhY2srMHhhMy8weGQwIFtidHJmc10NCj4gICAgICBbICAgMjAuOTcw
NjI1XVsgICBUMTNdICBleHRlbnRfd3JpdGVwYWdlX2lvKzB4MThiLzB4MzYwIFtidHJmc10NCj4g
ICAgICBbICAgMjAuOTcxNjMyXVsgICBUMTNdICBleHRlbnRfd3JpdGVfbG9ja2VkX3JhbmdlKzB4
MTdjLzB4MzQwIFtidHJmc10NCj4gICAgICBbICAgMjAuOTcyNzAyXVsgICBUMTNdICA/IF9fcGZ4
X2VuZF9iYmlvX2RhdGFfd3JpdGUrMHgxMC8weDEwIFtidHJmc10NCj4gICAgICBbICAgMjAuOTcz
ODU3XVsgICBUMTNdICBydW5fZGVsYWxsb2NfY293KzB4NzEvMHhkMCBbYnRyZnNdDQo+ICAgICAg
WyAgIDIwLjk3NDg0MV1bICAgVDEzXSAgYnRyZnNfcnVuX2RlbGFsbG9jX3JhbmdlKzB4MTc2LzB4
NTAwIFtidHJmc10NCj4gICAgICBbICAgMjAuOTc1ODcwXVsgICBUMTNdICA/IGZpbmRfbG9ja19k
ZWxhbGxvY19yYW5nZSsweDExOS8weDI2MCBbYnRyZnNdDQo+ICAgICAgWyAgIDIwLjk3NjkxMV1b
ICAgVDEzXSAgd3JpdGVwYWdlX2RlbGFsbG9jKzB4MmFiLzB4NDgwIFtidHJmc10NCj4gICAgICBb
ICAgMjAuOTc3NzkyXVsgICBUMTNdICBleHRlbnRfd3JpdGVfY2FjaGVfcGFnZXMrMHgyMzYvMHg3
ZDAgW2J0cmZzXQ0KPiAgICAgIFsgICAyMC45Nzg3MjhdWyAgIFQxM10gIGJ0cmZzX3dyaXRlcGFn
ZXMrMHg3Mi8weDEzMCBbYnRyZnNdDQo+ICAgICAgWyAgIDIwLjk3OTUzMV1bICAgVDEzXSAgZG9f
d3JpdGVwYWdlcysweGQ0LzB4MjQwDQo+ICAgICAgWyAgIDIwLjk4MDExMV1bICAgVDEzXSAgPyBm
aW5kX2hlbGRfbG9jaysweDJiLzB4ODANCj4gICAgICBbICAgMjAuOTgwNjk1XVsgICBUMTNdICA/
IHdiY19hdHRhY2hfYW5kX3VubG9ja19pbm9kZSsweDEyYy8weDI5MA0KPiAgICAgIFsgICAyMC45
ODE0NjFdWyAgIFQxM10gID8gd2JjX2F0dGFjaF9hbmRfdW5sb2NrX2lub2RlKzB4MTJjLzB4Mjkw
DQo+ICAgICAgWyAgIDIwLjk4MjIxM11bICAgVDEzXSAgX193cml0ZWJhY2tfc2luZ2xlX2lub2Rl
KzB4NWMvMHg0YzANCj4gICAgICBbICAgMjAuOTgyODU5XVsgICBUMTNdICA/IGRvX3Jhd19zcGlu
X3VubG9jaysweDQ5LzB4YjANCj4gICAgICBbICAgMjAuOTgzNDM5XVsgICBUMTNdICB3cml0ZWJh
Y2tfc2JfaW5vZGVzKzB4MjJjLzB4NTYwDQo+ICAgICAgWyAgIDIwLjk4NDA3OV1bICAgVDEzXSAg
X193cml0ZWJhY2tfaW5vZGVzX3diKzB4NGMvMHhlMA0KPiAgICAgIFsgICAyMC45ODQ4ODZdWyAg
IFQxM10gIHdiX3dyaXRlYmFjaysweDFkNi8weDNmMA0KPiAgICAgIFsgICAyMC45ODU1MzZdWyAg
IFQxM10gIHdiX3dvcmtmbisweDMzNC8weDUyMA0KPiAgICAgIFsgICAyMC45ODYwNDRdWyAgIFQx
M10gIHByb2Nlc3Nfb25lX3dvcmsrMHgxZWUvMHg1NzANCj4gICAgICBbICAgMjAuOTg2NTgwXVsg
ICBUMTNdICA/IGxvY2tfaXNfaGVsZF90eXBlKzB4YzYvMHgxMzANCj4gICAgICBbICAgMjAuOTg3
MTQyXVsgICBUMTNdICB3b3JrZXJfdGhyZWFkKzB4MWQxLzB4M2IwDQo+ICAgICAgWyAgIDIwLjk4
NzkxOF1bICAgVDEzXSAgPyBfX3BmeF93b3JrZXJfdGhyZWFkKzB4MTAvMHgxMA0KPiAgICAgIFsg
ICAyMC45ODg2OTBdWyAgIFQxM10gIGt0aHJlYWQrMHhlZS8weDEyMA0KPiAgICAgIFsgICAyMC45
ODkxODBdWyAgIFQxM10gID8gX19wZnhfa3RocmVhZCsweDEwLzB4MTANCj4gICAgICBbICAgMjAu
OTg5OTE1XVsgICBUMTNdICByZXRfZnJvbV9mb3JrKzB4MzAvMHg1MA0KPiAgICAgIFsgICAyMC45
OTA2MTVdWyAgIFQxM10gID8gX19wZnhfa3RocmVhZCsweDEwLzB4MTANCj4gICAgICBbICAgMjAu
OTkxMzM2XVsgICBUMTNdICByZXRfZnJvbV9mb3JrX2FzbSsweDFhLzB4MzANCj4gICAgICBbICAg
MjAuOTkyMTA2XVsgICBUMTNdICA8L1RBU0s+DQo+ICAgICAgWyAgIDIwLjk5MjQ4Ml1bICAgVDEz
XSBNb2R1bGVzIGxpbmtlZCBpbjogZG1fbW9kIGJ0cmZzIGJsYWtlMmJfZ2VuZXJpYyB4b3IgcmFp
ZDZfcHEgcmFwbA0KPiAgICAgIFsgICAyMC45OTM0MDZdWyAgIFQxM10gQ1IyOiAwMDAwMDAwMDAw
MDAwMDIwDQo+ICAgICAgWyAgIDIwLjk5Mzg4NF1bICAgVDEzXSAtLS1bIGVuZCB0cmFjZSAwMDAw
MDAwMDAwMDAwMDAwIF0tLS0NCj4gICAgICBbICAgMjAuOTkzOTU0XVsgVDE0MTVdIEJVRzoga2Vy
bmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSwgYWRkcmVzczogMDAwMDAwMDAwMDAwMDAyMA0K
DQpDYW4geW91IHRyaW0gdGhlIHRpbWVzdGFtcHMgd2hlbiBhcHBseWluZz8NCg0KT3RoZXJ3aXNl
IGxvb2tzIGdvb2QsDQpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50
aHVtc2hpcm5Ad2RjLmNvbT4NCg==

