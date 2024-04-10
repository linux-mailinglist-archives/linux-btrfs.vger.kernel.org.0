Return-Path: <linux-btrfs+bounces-4096-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A595F89EC9F
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 09:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 597DF283F9D
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 07:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E644013D2A8;
	Wed, 10 Apr 2024 07:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gdwiBTNl";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Tg96P6Ol"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF48313D281
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Apr 2024 07:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735243; cv=fail; b=D0y5VOg8DXPpxGqRf/rg/g56woxLxofeKYpxIxUIeCEhpoC9rDERWkoI4cb/RLlxSUfXeK3ZhzTgQ5xxBeQxf1HwL9Pkv+upEXZC7U3ugui5B9KplemgjGGFN2cl1QdriSSlVbvGWbNiDkS5pN8yV3PX83LsKWscxMKIyHQpbA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735243; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QbJ+EOONDlTkH9x5TNX9bY8jArUPnW31cEJDiD/kpcYiRMdhiSnAgWjnUvbOv2KKYT5961j5RUKwm0nUoEuHjlFmLlhj6G5WO65NQIL7vdeso/4t/pqk7PXAn16ppGqCPonEKiXcVgBEnw4E13oKkv3xCjtuZTkRnAWRJbygO30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=gdwiBTNl; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Tg96P6Ol; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712735240; x=1744271240;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=gdwiBTNlH0fNpU6hmPTshaSZVdwtEKDH6LlCReAaot9XDPjh/zr4ur+o
   TVpmIxUiFV+SZ+z1ATDboL/hZeFv6JGb47je/FqrzlKHEDvP8BA8pPxwy
   hOpJdFMYGdNmgb5yAGpBPWjyWBivnplrJYnwKXS2USzTToK7nUA1YHI9i
   QgS8nLQgWWc/Dj/Ntpt6CODb32Fxfpgna+ZD+so1oc5MiwuDIchqQEyJF
   uE4ONUigMDtgXjE7uKW6X6fN4OqXHg9qVuRD+geDfqZv0wQB/FZJ8Yuia
   Gq7hORWLvv/zUsQAzyXCdIL7CfheavoOlzLayX9EcqzcDxKWVyiiukhe4
   w==;
X-CSE-ConnectionGUID: xGbc7re0TTmoZbVv6/Q6Fw==
X-CSE-MsgGUID: Ea/3LuL9QYmX56qVU92LPw==
X-IronPort-AV: E=Sophos;i="6.07,190,1708358400"; 
   d="scan'208";a="13663680"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 10 Apr 2024 15:47:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDa6juVXFsXjHyKB80gT5mTDp3sCR/8C5ttHKx+zGJ07NRL3b3/jMRcHhasSvJsDofz6Fi6fZQKBxeazJG9Bni8PKCv2O63NJRvdjp1YaHVLruglchu9Pf2um0BqDszodzd0tdUPuvqxxj2RJfbN3GuEdT6db8YcdIx0hBvfsmzToeNqQhydCdyPWYVPcsPRH26E2FE1xasZmBjX+gu8AUk/IJDSaOp4MgGR1Cdl/UHlRkI5ZucmI0bBSnL8BisCG7mW090p4EyfH/dP+MaR0Y8J9BuEcKkBTFCgYGETOVlTN/6FtXHP6r3NxJ0jIOYyY7K5wPpOuz8w7L3mDXg0eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=FlHrTh0IZC+zOfqgQ4uY4G+adwtLZalRxzNQXeR4k3sP8jDh80QbhRy4cG4Q87cqzNWqzM6xqJvQOXv6M4sryAPIYsvXqtKRxJ/qNuyMzqxQFihDVpX0q1XCbcOuHCdDb8JNGNrhKfh+gr6rNSm9euwyYDBSFjfmGz720qIVimDhx8CJ2Fg0MwhH3Ho4Va3/QS0aJJ4mSaO7zYvdwg8XTo+QH9MHwn+8bmbmlYE4hiDsiotYO0vW1LXgVfIp9Zyxn15nBeDeB7jxOgFmmEAo+TfRZQfufkHGkm7oydeukTgPsi0LGlm/3lJLnMx/7yiZe6h5b02Xk5zPVW8KSB3CKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Tg96P6OlXYW/lTZPP4kzWSQZ640auXsrUqzrle72o6PPZldhaiwOdgss8j9gN9JRqdr01JxqJJ19E7mqeXRJ36XjVMQ0kB36qWq1vTRb5u6AkCX647Y8imPb4Zki8FHa/EEKOVfOPx44EnXaHx8hi1FFwRoY94eV6sx2lrfcyhw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB8539.namprd04.prod.outlook.com (2603:10b6:a03:4ea::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 07:47:12 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::179b:320a:832a:fe82]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::179b:320a:832a:fe82%4]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 07:47:10 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: "wqu@suse.com" <wqu@suse.com>
Subject: Re: [PATCH] btrfs: scrub: run relocation repair when/only needed
Thread-Topic: [PATCH] btrfs: scrub: run relocation repair when/only needed
Thread-Index: AQHaiojwt0hEAmwbckGPHRc+WrpIr7FhIYQA
Date: Wed, 10 Apr 2024 07:47:10 +0000
Message-ID: <59bfe431-57cb-40e4-9858-c7553efe4f72@wdc.com>
References:
 <4f457478390d84f5ecdc3818e239cdb652654ea0.1712672186.git.naohiro.aota@wdc.com>
In-Reply-To:
 <4f457478390d84f5ecdc3818e239cdb652654ea0.1712672186.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB8539:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Ryod6ODjV6DtEcfKx9BXrzOkU7lcseo4E7Jd2AfcfrqDyN0M0qav9cqC5YHo+InO/Hn9VSPEsdDWxMUkTlr3UjG1o41s3y/jfXWdl1smaFosxQT6PwFPZvG9BUiPJ+VKTY0wfqYr3a64Xi1N7Ka+lPVSRVvrOW1To1qdWfYCx7rAY64mMA6rhHpK236QoMcSEz42styJVbOLVhW3gFIY8QsRcX9s4nU79DI38cCcjQlGnvqxPI8pMSEbTTPFqZwiWasw6/4WNhRVvexjq4NLz0qN1K8wJFyHTcnrv8ohkkkoLM+zYOJJ//Kokoa9JlBxzKG4kyaIeSy3qzhf2J2XI0c+5l4As+U0UA6WvN7E4QmW/YA0V2j+PtaMJKMJBryZhnr9sFA5fqRRbap8eOrxQGYWBUFyWCFvJABc//vKxBtVvFP/weIo2R4Riexwg29xLVgyGh1JYenHBeaAcexhdz74yx7X6TKMVmv/IjuO+x5OrwS/KTBUZaIZwe19SZi8I+b6cbOqrjazR4Mbl4dy5Dn6oOBvvFtUqkNDh0q2uN7iM418pveTQYex/Vp2qHYTiBLnvhJHxO8WH9AYDuaMvJRENz9zc/PJGNh+mPkBUzX6uXskF2RO1IHyrOg+F6s8Vkx6zoPxS8ci/J3dOs2VIhh9lE1/rDxHpivzZwapG+A=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MmgvenFKK3hDbzI3bWNWQmZLUXM3UEw3aHR0OTRSRUpIMGxTQmo0VjJhcFVt?=
 =?utf-8?B?akF4OXRmdkZ5aWx2aVZjekFMVE13bTRhYmxGSkphS3BDS1RqbDJQVzVnb3Jv?=
 =?utf-8?B?cXRzWkxMNVFwMG9mOUxmRmwwVVJzdjB3MWx2NW93bllYT2RoeFNNaVZhQUgw?=
 =?utf-8?B?UGtkSXZyQVZTOUVMOVdjSnlsaG9iVzlTYURpZlBaejBaSFRoSEduUlJ1QlE5?=
 =?utf-8?B?OER1Q293cGhLL2hzWEJUMnRHb1dvTTZ5dGk0V05jcGxDVDhiUkpKRytqNXZN?=
 =?utf-8?B?SUkxbW9wNzVuenBQbDc1ZEhsaHVDMjJZYXZGR1JsS0hxVzFXTktKNjhCRmFu?=
 =?utf-8?B?b2ZFSldReWhxVUlGeWk3dGdnWnk2aHo2akI5ZGJWMnJKaHlvQlpBVjQ0OVFM?=
 =?utf-8?B?ZURRTTJYdkZuUUNUODR0Z3hUZ2V5VldZK21IanRmNVd6aXJlekJSVEJ5MkEx?=
 =?utf-8?B?c2FoQ2ZuNnRMRGlHTWx5ZE44UWxwNGNBd3pTKy9sbXRwaVZpNlBmMkdNaGdn?=
 =?utf-8?B?OFRnencxNGNoUVh0MXNUSnUxWnhhcFNBT3FRRnNoT2EvNHFNSmlaZjJRUktY?=
 =?utf-8?B?dFBsRUpkN3pZS3pRTlFsdE1USEIvOUd4QXd1OE9yeDhuK3IyTnVoZGhYQlRw?=
 =?utf-8?B?SDFUbWxJdzgycGpBcU1ZL2d3Rm01SnkvZDZCcEp0Yms2VmdQcmNLY1FtbWlB?=
 =?utf-8?B?Nnh0MVFYSktzU3BPQ3c2eTN3dS96dkpxT2trVVdrMTF5ekxpYkJtdkJRbVJ4?=
 =?utf-8?B?Znk3MUt3V0lEa0dKZUdqZCtQL3VXUUMxOE9pWExtT2pwaWVmOU5WNUxzck5X?=
 =?utf-8?B?TUxCRmtzUlh6SE9MN3ZXamoxd3FBZktwQTNIdXF6RWhzVTk3RFk2WE9ldDVi?=
 =?utf-8?B?OUNBM1lkR1VqRWhKOXVVaEw1bmx3d0paOHJhZjh1VmZlb1crdjZJOWIxY3ZZ?=
 =?utf-8?B?NFI5WXBSQ29kMWZKQTBLUWtFTm1RY09pSFRDRlNHK3VOU3N6aU9nUG54MFA0?=
 =?utf-8?B?MGNZT1BoNkEwRm9RQ1hqdVQ0Nk5MMkl2RnU1RllEV1pvdG9td1dXdEJ0TkhU?=
 =?utf-8?B?djV6b0lGRkpidjlGQ3Q0eWNrOEFPd3Q1T3BRelZDbzcwYU0zVFBha1NVa3Ez?=
 =?utf-8?B?eFRVVGNUUm5YYUMzOHVlQzQ5OVBFWHIrWDBMRlgwQWJpY2RkdzNZOTFmb29Q?=
 =?utf-8?B?RnFNUTNoSnc5dnpkSktjK3h6aG52UUNvN3YyYUJta0toWTFKQ2ZPMzdveTE2?=
 =?utf-8?B?MG9HQlROK1ZYbks1YkU3d0UrRC94djJ5RGpQbzBpdXRiSVF5UlRwdzNxRVJU?=
 =?utf-8?B?Q1VzVkdjcDJ3M1RyeklkWklqdnNxWFFESm5YNjQ0M1lMNlJvNzA1cEIwbDdR?=
 =?utf-8?B?c2krbXZXT0tKOUNoQUtnRVpaclJHUDJjaXpLVlVHd2ZYZUdINEx6WDZQbDht?=
 =?utf-8?B?UUpjeHlwd29SbTJXK3VrclJHbDRPWE5ER2R2d09wMG1tSEwvblYrMkY3akNR?=
 =?utf-8?B?UVNXNHdKaEx4YitQNFlOZ3J0Z01RVytzdWU4WDBma0J2SWJwUURIeXlJNnll?=
 =?utf-8?B?MEJiQzVoVTdLeE41MlVsUXB3anFXUksrWEZrWXZrN1RsT3UwU3ZGNi9ubnVO?=
 =?utf-8?B?RlZScHRWdWcvVUU2V0d5WW9RMXVPdVRPRlFWQWJrYzlJUXpLRld5K2krUWtp?=
 =?utf-8?B?QXh2by9ZS3lMSkh1Qzc5QTcrWko2TjMva1dBQk5DVmZQQ2h0bk4vbzZ5RnZs?=
 =?utf-8?B?Q2VLekFaTjNKRmJaVmZJcHZScmFtY045S08wWVYrU21sSnQyWU5JT2VzSXRT?=
 =?utf-8?B?RWN5OWxQeGRtM1ZCTTh3cFRMYUZFL05rMzNzVFhENlBWSDh0NTlJdysvanov?=
 =?utf-8?B?WEplbytGcjJ3VmtHMTNsOU1kVTVoVVRMWTZPWUM3MTJSS1Q5b3JEMitGY05v?=
 =?utf-8?B?RmwzWnRUeDdwTVJmWlNWTU0wSzVETU5TbElhYXZMSThpZ1JGYXAzUTJxVlZ6?=
 =?utf-8?B?bjJiVkdlbG5aR0Zha2RmaTNwWUN4cEtRSzhFRkl3REtKUlQxN3lCUGxCQlNN?=
 =?utf-8?B?Q2c2ejFDRERWZUVWT1ZneVQxNmhjMXNBY0J1VTZ2MG9PUW5obUN1SVF3L05o?=
 =?utf-8?B?UEl1c2tyeFFJSzZub1NhMWJKYnpub3FjMmQxajFzWERCN2dRd3d5U3Bna2x2?=
 =?utf-8?B?N0RNUzcwTFEvSUwwN0I4bWFNWkhUVU94dHZVcUxJdFRMTzg5bHJSU244RFhV?=
 =?utf-8?B?akQ1QndlZEtlRTRtUWRQTnFpdk5BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C26EC5AA942AB64FB2D5EC9C18331B70@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8rTHo8oj5lfN4chZfi2rbhVFlFXf1XzPOJq9VLZngdtH5tSmgI6K4HzWbQPY7QETpAQ61sYGJOo2bJXL7bXdCgJ7NiWniu0qqZNYzPyFHWR86MaxldUxaZLt5oVWaP5CIfij416I9ht8Gdkub/pyXLcxzOq3IlsEptcAnWw4HV2XnYiq3O69nD6NVILpDhCtSan77yCb2RETmCTXTJsHld3YhdNOhwUTiae9s2KWQ9Bn1bGRlh+7N86fI3QCqnvSjpC+Np7z9j0cWD91HZih9WBVtF13HRrYyat7OO98PP/kGyWkE1bUJysFbFzQt2oJi3y7RehtPDIHEfBGvNK8kftc4uQ4b0Bff8nX8OSVAXRs63eiyt46uhRrELBW/dFtCaO4JAaRnBWNt6rOUmpcg00UhMTELM4EsDwRc11qiS3P1ToA1qpeujmUgapCd67ZUwLKNjXKLzK9S/j2Oc4r3AltCX+MJPO5es97tn0O89bJktMD4OsyyIMhkd11Sjr5bk+Xw38EGO8HmtOEu02mlSoWL6qBc8GVEEyczXBQQEyINT/Ll3N1w5iphud2mVvegtxW0B0mXPuNDSIp1wupky5uyPc73nIBwu8demdvUZZ6gIyuJhs++rHKiqV61IB2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 002362b9-9bae-41d7-190c-08dc59326df8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 07:47:10.7543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 05sj4yDiH0oCiWbBVY7EYEJDDalq57uf8pc8wFfwRREcNR2tiJ5D3V11g94H0YOQOI1GuXX89w6Wo6+q28BuTLjUd/oAmjQ92kX7t/OYXPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8539

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

