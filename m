Return-Path: <linux-btrfs+bounces-6107-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA9E91E378
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 17:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4A0FB2842C
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 15:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D207716CD3B;
	Mon,  1 Jul 2024 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TUR6bTAb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="P6E5GfIJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4211516C86D;
	Mon,  1 Jul 2024 15:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719846508; cv=fail; b=ThcYshnrvu2dEVxJFwHqmahHb1c3wtWx39RJv36WhsCOAhnkQ9mR81A143d8OfRM2jUKtNzxDlwJWwT0EYiNPZPG350fZErt+tO521vJUV0eOrzPwi06fLXofgh9Dj0EHam8ZW6vlLE7WOfl0yReP9h/mSgX8u36x6f4/TYMPrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719846508; c=relaxed/simple;
	bh=Yq8fxHWZV+vVFAHEmB79Tq8h8jvTMJNopW52n3ojJTU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JTIqEF5joQ8HOYAVWviiYoMrOdxkdgs50cj9hsKu+5vy3fSvIk3VIPTqqLBVveI1Dhguy448yNGZb/gqngiCIXMGFxS64wcJJQFVV+MRMYwsZFomB/7pZpEq8ijNqJAA6u/KSF2B+HU3rGp+Yxzm7Z/3hhqkvBInFXPE8I5bSZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TUR6bTAb; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=P6E5GfIJ; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1719846507; x=1751382507;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Yq8fxHWZV+vVFAHEmB79Tq8h8jvTMJNopW52n3ojJTU=;
  b=TUR6bTAbd/AFD9DkpZ8mdVsq58MbW0PExuYdGLmZ+FQWeoNl2/qlRfPL
   WEbi9HaRrNUDdijI1navg0pJ7L09ubOCo1tWELd/lKDlcagnWxGvUbizL
   R9WJ6zz6ocBAGB4v1L1rlPykkQOSAS9U0Or+eKOBj86gmwPU6aqqYoF0q
   gVj10TcerfFVCa6jp9/2O37IRDP13rXUNiFJ3b2XsIFeHEm+lesvKyb59
   Fc3wYLPZ16icNodNu7PnVlegGnjTibv3DNwYAF1xTwaZ3V1JhPoswnZFi
   ro5w2e7ekc7kUx7VcFbBtRJhpyVsxC2Eo8GC0YVdewJgnhchL8zzZL8HW
   w==;
X-CSE-ConnectionGUID: Ko2PISEnQku6R7S7q8HDag==
X-CSE-MsgGUID: bHKNshWDTr2iD6D3/LJrfQ==
X-IronPort-AV: E=Sophos;i="6.09,176,1716220800"; 
   d="scan'208";a="20267618"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2024 23:08:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vzt6Tg7zSxkqwYI/gb4mkjBv4A8sLlHyE5TCzTcpJYf2zhs3WcMruwmRxMKDoC3yC9GmEkakL5WcwOa73lxLqR6UopWxH6y2sopkiIFDEAyXmnGBn9Z1vVcDICeF9mf59mGZ7GrVKFmQVSnBCANwxW5ky8JgyyNnTGEYWcrHthyzfDO4ofQORBBeHW4hVqEOnssmf3YoOZuai2WbjxgV66OY/6R8AocOz/yxHrKFCmSODsYsGXJRQ5EGpg9GJiWblMzWvNly7oWtJU7fMT+FvyUARKaRF7hCKJ+ksk0p9kFkoMs66kiVppY+FFaB2ZXhr2+Hk/scRlp+8LhCeEmbTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yq8fxHWZV+vVFAHEmB79Tq8h8jvTMJNopW52n3ojJTU=;
 b=DUekfN7FK7mFtKdfVH0cu8lQ5R8eTRAldutT/hzzcLzG2NM/pf7cYj0jpVWH4wBg3VUifylAOrkPa83V3/sUSxXMgsrk/fGZtHSFyqqvHjV/KbQLXZsI+schXpzL8Gufb0HoeQVUVmj7JwWP3c9uyL6kllhSxs6OuybOQd66g5hoTvsVVFeBLF4TwyAbla4LGYVzLIS383b4UCL9GA/gDpIpM42Emh/rpizPFMOnShZ4/9+zDrabMhqZJfYgZtRr99z3LsjuukOxgKqk3349jl71tXpIUVV5euCFS84DqSeVZx/MWMowMqiSFAeFPv+7Tv1jJapsjwLusawOI8wFqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yq8fxHWZV+vVFAHEmB79Tq8h8jvTMJNopW52n3ojJTU=;
 b=P6E5GfIJafPfcY/XacQEeHWN/sKFpEms7369viOs2AvOw+H0ebtNMGV9dAi58NrklSVwLQdrfHtAzK2y3PtnAWxsR8b/Gy31qhKzHPZC7P8bYYuIVS1g8S3yFD2oqGXL8lWskUmzbW90hMs5TnxPgrtOhqd741/ZUQQtKqQazzU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7477.namprd04.prod.outlook.com (2603:10b6:510:4f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Mon, 1 Jul
 2024 15:08:22 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 15:08:22 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Josef Bacik <josef@toxicpanda.com>, Johannes Thumshirn <jth@kernel.org>
CC: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] btrfs: replace stripe extents
Thread-Topic: [PATCH v3 1/5] btrfs: replace stripe extents
Thread-Index: AQHay6EAp8S4JW/Ct0a3xUYtoSH4nrHh5hWAgAATrwA=
Date: Mon, 1 Jul 2024 15:08:22 +0000
Message-ID: <0819d7c2-bb91-4dea-ac20-09191c0b2240@wdc.com>
References: <20240701-b4-rst-updates-v3-0-e0437e1e04a6@kernel.org>
 <20240701-b4-rst-updates-v3-1-e0437e1e04a6@kernel.org>
 <20240701135755.GE504479@perftesting>
In-Reply-To: <20240701135755.GE504479@perftesting>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7477:EE_
x-ms-office365-filtering-correlation-id: e5c35e4a-9361-4c76-afb5-08dc99dfa674
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M3o5b0x6aHZ5WVVwbDNmNDNaR3YxRVZlLzZhYzE4Q3g4aDBRRXljL2hCM0NU?=
 =?utf-8?B?RHRsZk1CY0FxWWxLQUo5SHBYMTNNWEdGWlVKb0RONXVmYktOVjdRb3diLzBH?=
 =?utf-8?B?dFhraGQ1aDMwWmZLdTdqZ1JTcFBnL2wwczlyU05XUndPZmhIUkJhS1Bad0p5?=
 =?utf-8?B?UGwrQVBHZklSZXZET1RLME1LbDI4dEtmZ0VUbDRjbEtwRVJlZWMwSms2OFdW?=
 =?utf-8?B?RDdSayszN2g2S0FlbmM5c3c1WFhsR0JKR0JDUEFtUnY2SGZZS2JqaDVDQytJ?=
 =?utf-8?B?dVFMLzMxUXBXK3VlcGtML1YweXk4RTcxQ2VFeGIxZll2c2tKUVFRL0hSZHRp?=
 =?utf-8?B?VXh2ZUVHVlJ4ekc5U2NYUkZlNWZ5YkNKa1NqWnBLNUdXREtPZDhKNGJsejVH?=
 =?utf-8?B?T3JrZCtJWk9xYjNnS0g0VStNdit6ZkNzdVBpYkgrdmtyTWRKTG1xRU9KZEhp?=
 =?utf-8?B?SzNmVnM2ZE11NmtadytxTnBnL3o3Mi9xTUVmWUpzallQLzJXTG9lb0FyY3dq?=
 =?utf-8?B?czNKdjRjVlJrRytpUElPbDN3dXhxc0RqcURvOWM2c0FyRGlCSDdRSnlUS1R0?=
 =?utf-8?B?RUpLcW9WQVFQTWlWbUNib2pMb3d1M0Y4T3NxTUhHOEZydk9FdFcxNlZnRXBJ?=
 =?utf-8?B?ZXdLWGx5TkovUDZxakFRY1E4U1hnM0pNelRScG96USt2Wk5wZzlwZ2NDTXRh?=
 =?utf-8?B?UmtLSWNJdFFoc2lycjdOYUZTYmFZTllEblZKMHJ3VzZ5a0dqTHNvRXMyRFJ5?=
 =?utf-8?B?SlhiOHV2QjViOWpna2s1MTFUS2VzMU5KTnlmUXd2V3J0WmZ0ZDV2TTlSOU1O?=
 =?utf-8?B?d3doOXJ1Q2V0Rkh3VTZUMjhOdlRIZnplWmthUE1JYm1lRGl6NG9VTkZ1QW5N?=
 =?utf-8?B?dGJVMDZvY3FSTXhFdTI5OU1rNWV1MDEveTYxQlNVcEdQTEpoWFFCTVNWSlh6?=
 =?utf-8?B?RnIwNitGM3dabVp2cFQzVEJxNkhqditKSEdIa3Z4SUZWSSsxVmlMVStSWmRJ?=
 =?utf-8?B?TWtrWTgvRVl1eDM5RkFKelZzZlNVRnZMTFdWai80bmU5MHNMTUNWZVJCZnA1?=
 =?utf-8?B?ZzE0bmZ6cHVpbHZZMUczRWtxcTlTTUlOM2JpZmNzREFBMXY2Qkk3WmdYeDdD?=
 =?utf-8?B?eWhHNWp4Y0c1ODBWVm9hdG5IdHBBNFdHQ0N5KzFyRGllQnJtUDNYMGFBQmxQ?=
 =?utf-8?B?clFWQlJ4TnVlQjE0cGs0M3ppN28xVEVXZzlWYmpSQ2FqN2dsOUdqK0RHRmVr?=
 =?utf-8?B?dFl6amRzZndvd2hObEFZMWR6VlMySWdRV0drVVREekpDOGtBNkZsK3lDU25s?=
 =?utf-8?B?Q0hBQXNGaDRCd05WRk1kOWQ0SFk4R1hMQktFa0hIbkhkMFpselBIZmZTSmp4?=
 =?utf-8?B?a2pId3VrYVhQb1lLcTdqelJGNS9YNGxyL1BjOXFEa0ZHc29vTm1TLzl0NVd4?=
 =?utf-8?B?b1pCOGtOZmpRQzdQandVZUNVSWRGUWlxeityNjRNN0xwT1E0bWVDbFY0WklY?=
 =?utf-8?B?R2VNSCtFTXkyMFoyMFRwVnMrL2VDSFJWSmFNTkFsTjJwSWRyWlB0bURERm14?=
 =?utf-8?B?a2JJZnZQdFdLaS9hQUY5WGNqVU9waFZlZVE5VDI1U0FJOWdjdnJQT01Tc0V2?=
 =?utf-8?B?UnV0TklQNXpyczBqRUJrbWo0TklMWG9rc2tOeXJkVmJ2dVA5bmptblVVYTR5?=
 =?utf-8?B?MFRDNk5jR3JIZ0d0VG8vMSs3YlVXV2EwM2ZSaXIrRHNndUpScVY2Mzc1NUdi?=
 =?utf-8?B?YlFhcWp2MksvN3h0OEdEWGFSYW8yVUhvaXZoYUFFWThnZ3k3S2RzTnJEY3dT?=
 =?utf-8?B?amNKTkVrZ0djaGhJck8reTdZR1ljNWJSOVdSZjVmaWphWFNZOWFQb3Naa2VY?=
 =?utf-8?B?Qm5xVmQwczF4T1ZNdXYwMkZ0MTg4MVVlUEZpcnhycHN4bEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MWhzbWl2NFJIcHJtU1VQNTFoNkx0U0h4bDQ0b2hLdFJ1dnNSMHVhMDFzT3NU?=
 =?utf-8?B?QmpHaEJENzFnc054aDljcm9vMXJjbjl2L3kyYkI0TVF2YXdLVjRkOElhcFQ1?=
 =?utf-8?B?dnVXYWVVRHh5amVRSWNIYS83M2Z4aEFyNVAxcTdja1RDOE43QnYyK0Q2Z0dW?=
 =?utf-8?B?eGFQRmFHdHRmRU82aDFSTllnRUg5MTBvbUFVV3k1R2ZnN0lXRFdQT0xzSFp4?=
 =?utf-8?B?ejZYcXVuSktLWkVqZThNY1ZDeG9vd29MSHoxbnl1QVRLOVlFRjYrT2s4R1Qx?=
 =?utf-8?B?NTllQithY2F0QmRQN21DcmN1Nk5nN2tKdCtPR1pSVE5qYmRpRE5iaCtGTzd3?=
 =?utf-8?B?TFdmbEp3N0w4V0RvR0J6dnRuaHVyN2h5VFZ1bXE1UWw3T1B5ak80aWJ5UDhB?=
 =?utf-8?B?VC9lOWZGWFgySVZ4Q3ptTWVoenlBN0o1K1RvME1nUU05T1JRYmhHKzBPTU03?=
 =?utf-8?B?YnBLcXFqUzRJbTZEQ2xrOHh6NTZqVHFHb0hYUG9YMnZ2c3E0emg0RjhxdDla?=
 =?utf-8?B?Tk1wMUFwT2N0bndLSDVvUU82ejFYbzBJdW1pbnEwWUlXVFl2R3Ywb1pReXhi?=
 =?utf-8?B?L2l4ekVUdnJBVnc1YVVFaHZWZFc0Umo0TGpVOGxKR0hxTzR2ck15eUdncUJu?=
 =?utf-8?B?WWVteHV2WHV2Vk9uNngzcmNzRXlZNVpGOVJ4N3N5cEorS2xVdk54N0Qvcy8r?=
 =?utf-8?B?OGM4Y2VJb1hZTG9mUzhTTE9UOXpXNkVCaEVUa0pzd3VaRm1iT2VHVkQ0VXRn?=
 =?utf-8?B?WlczMi8zbGZDWFV6T09pOWlYOGxhNDhxWnlPaXJJRjM4TDRoYXo2U0hsdVEx?=
 =?utf-8?B?YjlTU0FNaFpsanlQME42WVlncVdWVk8xd0R3a3psVE53d2NKUjRmNmNqbDVx?=
 =?utf-8?B?amhTYTNueU5DcEc2Mk96dVBvK013SUNMNmxjQXlHcEE2SlZSZE5CVkl2WHZH?=
 =?utf-8?B?Rk1GRE5lNHRMbUsxY2d6a0x4TlFQLzFpQzZOOXdnQlY5N3liTDIwa1oxTjBO?=
 =?utf-8?B?L1M2Y0gwZFdJcHUwZkdQNDZWMWRCWGpSZEdtK0d1TmwvSER5ZmRwLzh5bnJp?=
 =?utf-8?B?VnRraEcxeUJKNlM4WDlqUFdjUU5jMEZpWmNmR2loNlkwMldzRFBwVWxPTFE1?=
 =?utf-8?B?Wjh4eHY2dy9aZGg2eFRCZmFLOGQ0MUhadFJkMFF1cGtlMDh5cGQza2NMWEF6?=
 =?utf-8?B?U1g2OXk1OHNHYTJMYVc1b1NSQk9hMGlQNEtCTVcwTnV5N0xET3lJUXdSK1U3?=
 =?utf-8?B?MGk2c3Rkc2dwOW1BZVFHemk0eURrVXJtQXUvUE1YalpMd3lraFZkRys4Q0M0?=
 =?utf-8?B?MktzMTAvemdmRmExNnl3eFRKR3VDSmhINVl2TGdpYXBtcDVsbk9SZnVQMUFF?=
 =?utf-8?B?ZkhnKzVRTms2RXdoeDJ1UjBqcnFYVlRRc2sxdHJHOTd1R1V6QXpDeVM0TDhz?=
 =?utf-8?B?ekN3VXlmb0RpNUVmZlducllHUCt2SnNRWmpNZjJoZTNRNEN2NjBtaFZidDNh?=
 =?utf-8?B?Ym53NXNYM3RVU29HYTlvUXU2eDBaNlVaaVZwdlVlb1hSOGtTUUJ2OW5FaHZo?=
 =?utf-8?B?WnJNN2NxdXp0Sks1R25xT3NWdWl6U2lmM2lpZ0RYWERqeHVwZFNGdzFIdHA4?=
 =?utf-8?B?aEJnUnZhd2lyRzJNVXRkeVFuRmcrbUJYdzl0VkVIeWh5OHZyM3pySktpb1BV?=
 =?utf-8?B?dG1vVjRLNmJxRmEwaUlNWHU1bEQ5RkNJOWZOQ01OcWg5WGlmc1lPOXozWFNZ?=
 =?utf-8?B?ejVnLzQ4ckMxbitUbFZ5c2hxL2hzb054UmttdFFuZU5KMWMrRFdVa29kb0NT?=
 =?utf-8?B?RkFheXpRVTRHYTllUnBaY3RnM0tVeDhZczE4K2MwYk1yblJ0YTN3U05pVHFM?=
 =?utf-8?B?WTVxMmV3L044eXN1NUxKOUlSZmdOaTY0cFZXQ3F3UWtiMjF6SU53T0ZIaytk?=
 =?utf-8?B?d2hFMEREL08rbStVbEdkYmZXYUpUQWJkK1pDUjlZQXJPQjJuY21Nb05SdzUx?=
 =?utf-8?B?ZXgwelQ4TEVsb1F2emN4UDRLZFJrMzNScXY2NWJnNjZvYysvdW1DOEVOR0h5?=
 =?utf-8?B?dXVueFVOUDV3L3puWWRveDBxQ2VGUWZTUklRSXFDMThwK0R4bE9kaTROT0pI?=
 =?utf-8?B?N1RFRWJCWklYOHNQV1ptZmFWOHpSYjBiZ0lLbU5HaVpGQXpBNUkrem52emp5?=
 =?utf-8?B?ZUd2amdITTNCZFNFUDFKVnhKdldyamEwK2ozbUFPSnFwSjlxbTFvM2pRSW1X?=
 =?utf-8?B?WnMvVzltelhBWDhLU3ljMU5KRVdBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FB4C9CF60853141A3E7AD45EBF2799D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lf1o5BXTy2JdeUvXEDz3Tu7ehXdzrsovZ+O/1AjB2ndPmhRpRrJA8rRxGjdHwHQOClGZbS01drgMq4nLpkSzVw3gDxLwjkA5EHlBWugbyqL+thVynrrAwHvQAe6P0usl+hl2Cnvs54bDtnBU5FoDnSgDCIm00OSAYM/h8rP595a63EMMmDTruHV+BdHgE455cDYq5nINNuNiwuMSXu7pZotdScERFjo5O3q4y5t/Yg4nKmY22g9oqipyImLaB5Oh7W3YxOhaIc7RQb5+CHnyQjW1ze4yegVSvBmpPIwS/JdQjgYdqvtyCM12sm8pvema2t8rav20KWNpy/COv5dGvdF0uKgmYwYh+mjyZrcVUkozgAaMkFTdHFHmWctmcrko8FLohP27RM1Pab+hHFHJWc9d//ODryTjBTyl/0+WDIzhRxLAkiqoF22s6B9gsXwrZl6cU30c9IyO1pAr+clHSLu2bmAZe8alvI0vtwApXqrDU0Oje+w7YIbwR/0ssrGn6Ko4WYdm6iSUzlgcp00dNxKL2J3UYGl9LRgGMPIsYNPK4Mm3mXUeFhCzHF/QWP2pDK6JFuUMkgB7jTo/gvwYSTs7RUHmEcwpvoRX43BC1nCNcNQFyNwvhZjfYUw/eUVx
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c35e4a-9361-4c76-afb5-08dc99dfa674
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 15:08:22.8653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I2WbA/fQTmxqQ2wO2Q7YnRYLzheMvhaWXfhbrVsbWF+sdlCGNYlDV+NubyTzPj8njOFRIyyyI0rk6IZ7T/kU1aW6cFVWvAd65/IifM63cE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7477

T24gMDEuMDcuMjQgMTU6NTgsIEpvc2VmIEJhY2lrIHdyb3RlOg0KPiBPbiBNb24sIEp1bCAwMSwg
MjAyNCBhdCAxMjoyNToxNVBNICswMjAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+PiBG
cm9tOiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KPj4N
Cj4+IElmIHdlIGNhbid0IGluc2VydCBhIHN0cmlwZSBleHRlbnQgaW4gdGhlIFJBSUQgc3RyaXBl
IHRyZWUsIGJlY2F1c2UNCj4+IHRoZSBrZXkgdGhhdCBwb2ludHMgdG8gdGhlIHNwZWNpZmljIHBv
c2l0aW9uIGluIHRoZSBzdHJpcGUgdHJlZSBpcw0KPj4gYWxyZWFkeSBleGlzdGluZywgd2UgaGF2
ZSB0byByZW1vdmUgdGhlIGl0ZW0gYW5kIHRoZW4gcmVwbGFjZSBpdCBieSBhDQo+PiBuZXcgaXRl
bS4NCj4+DQo+PiBUaGlzIGNhbiBoYXBwZW4gZm9yIGV4YW1wbGUgb24gZGV2aWNlIHJlcGxhY2Ug
b3BlcmF0aW9ucy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpv
aGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KPj4gLS0tDQo+PiAgIGZzL2J0cmZzL3JhaWQtc3Ry
aXBlLXRyZWUuYyB8IDM0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICAg
MSBmaWxlIGNoYW5nZWQsIDM0IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZnMv
YnRyZnMvcmFpZC1zdHJpcGUtdHJlZS5jIGIvZnMvYnRyZnMvcmFpZC1zdHJpcGUtdHJlZS5jDQo+
PiBpbmRleCBlNmY3YTIzNGI4ZjYuLjMwMjA4MjBkZDZlMiAxMDA2NDQNCj4+IC0tLSBhL2ZzL2J0
cmZzL3JhaWQtc3RyaXBlLXRyZWUuYw0KPj4gKysrIGIvZnMvYnRyZnMvcmFpZC1zdHJpcGUtdHJl
ZS5jDQo+PiBAQCAtNzMsNiArNzMsMzcgQEAgaW50IGJ0cmZzX2RlbGV0ZV9yYWlkX2V4dGVudChz
dHJ1Y3QgYnRyZnNfdHJhbnNfaGFuZGxlICp0cmFucywgdTY0IHN0YXJ0LCB1NjQgbGUNCj4+ICAg
CXJldHVybiByZXQ7DQo+PiAgIH0NCj4+ICAgDQo+PiArc3RhdGljIGludCByZXBsYWNlX3JhaWRf
ZXh0ZW50X2l0ZW0oc3RydWN0IGJ0cmZzX3RyYW5zX2hhbmRsZSAqdHJhbnMsDQo+PiArCQkJCSAg
ICBzdHJ1Y3QgYnRyZnNfa2V5ICprZXksDQo+PiArCQkJCSAgICBzdHJ1Y3QgYnRyZnNfc3RyaXBl
X2V4dGVudCAqc3RyaXBlX2V4dGVudCwNCj4+ICsJCQkJICAgIGNvbnN0IHNpemVfdCBpdGVtX3Np
emUpDQo+PiArew0KPj4gKwlzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbyA9IHRyYW5zLT5m
c19pbmZvOw0KPj4gKwlzdHJ1Y3QgYnRyZnNfcm9vdCAqc3RyaXBlX3Jvb3QgPSBmc19pbmZvLT5z
dHJpcGVfcm9vdDsNCj4+ICsJc3RydWN0IGJ0cmZzX3BhdGggKnBhdGg7DQo+PiArCWludCByZXQ7
DQo+PiArDQo+PiArCXBhdGggPSBidHJmc19hbGxvY19wYXRoKCk7DQo+PiArCWlmICghcGF0aCkN
Cj4+ICsJCXJldHVybiAtRU5PTUVNOw0KPj4gKw0KPj4gKwlyZXQgPSBidHJmc19zZWFyY2hfc2xv
dCh0cmFucywgc3RyaXBlX3Jvb3QsIGtleSwgcGF0aCwgLTEsIDEpOw0KPj4gKwlpZiAocmV0KQ0K
Pj4gKwkJZ290byBlcnI7DQo+IA0KPiBUaGlzIHdpbGwgbGVhayAxIGFuZCB3ZSdsbCBnZXQgYW4g
YXdrd2FyZCBidHJmc19hYm9ydF90cmFuc2FjdGlvbigpIGNhbGwuICBUaGlzDQo+IHNob3VsZCBi
ZQ0KPiANCj4gaWYgKHJldCkgew0KPiAJcmV0ID0gKHJldCA9PSAxKSA/IC1FTk9FTlQgOiByZXQ7
DQo+IAlnb3RvIGVycjsNCj4gfQ0KPiANCj4gb3Igd2hhdGV2ZXIuICBUaGFua3MsDQoNCkkgd29u
ZGVyIHdoeSBJJ3ZlIG5ldmVyIHNlZW4gdGhpcyBpbiBteSB0ZXN0aW5nLiBDb3VsZCBpdCBiZSwg
dGhhdCBkdWUgDQp0byB0aGUgZmFjdCB0aGF0IGJ0cmZzX2luc2VydF9pdGVtKCkgcmV0dXJucyAt
RUVYSVNUIG9uIHRoZSBzYW1lIA0Ka2V5Lm9iamVjdGlkLCB3ZSdyZSBtb3JlIG9yIGxlc3MgZ3Vh
cmFudGVlZCBpdCdsbCBleGlzdC4NCg0K

