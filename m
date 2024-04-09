Return-Path: <linux-btrfs+bounces-4053-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5009D89D7CB
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 13:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0840B23709
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 11:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF358614D;
	Tue,  9 Apr 2024 11:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QL16TGH3";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VKL71slX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED74585924
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Apr 2024 11:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712661873; cv=fail; b=T5FyOHnvcno7qecE+L56YyAqga2UyN9Ys8Eq/SIwOyuIGNZUPcOU1RPw8BXvKwEqK9e1HVwvAeAesuK0rhXKaKXOo07nYjhZsdNf7Grg1yODqpa+Qh7vCppByyy2Ng4wNA51ljOzlY7qBXvoQjm4uX2tXPcFZMkecaNrdp8JfBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712661873; c=relaxed/simple;
	bh=w9DF2SbCxbTugIkgG5NuJIlSXEFmDFOKJ6o51wBRoPU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RZtgs5mOKT6TxcH82de/XPoamZkXOe8ar2QB0cuKZ6LHRKBcjwwoab0LQZvyfGezOgpyfVTRPYGU5DISHZVmdGxjroMhjdqedIV7MlO81dQ6lHc+vuSpZmAlcLkdrZY9DbxbuxOkTjbKchEjoqWt10B+gayL5NmrDU6PhVEfViw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QL16TGH3; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=VKL71slX; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712661871; x=1744197871;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=w9DF2SbCxbTugIkgG5NuJIlSXEFmDFOKJ6o51wBRoPU=;
  b=QL16TGH3eVbyJ3Fj53J885kjXApD6HyrIvb+LDPqTXJF7EwlLnGg86BI
   60p485heYz3J4ltqRE6zaYne0r2E1KHhT3/NdOYVSqN7uHzYqyrQjlzcG
   LQmVPbTtI8wTCvd+BHfbFUbi32WOzIUO5f1f3J/1uk2s4w/Wft/Cll8/S
   d9vN5HfJIISbTZN9Ho4lLrVlWYYsPmi9nWZcr+MUObufLLmz7v7lSVbCV
   1A2bDocKPhW//yX0/OkNtLIgDzk2N48ssMRxy2JikTlhXNvB0gDI0UtSy
   7hv4Y0jTiZ6zG354/LBvtb4ry3OVcNGh/8CeaSvlCmuMZSQhpp/QgismZ
   Q==;
X-CSE-ConnectionGUID: 8Jeobu0tQu2o01w8vmlqWQ==
X-CSE-MsgGUID: AJeT9LQ+SQCFNKWOFQhGcw==
X-IronPort-AV: E=Sophos;i="6.07,189,1708358400"; 
   d="scan'208";a="13408333"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2024 19:24:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KaiQoXF93/JAru0qZK49glx308GsbTDXCCHw4BLgpcW48XNBkx93Np+t2TvNLzoof5+A44Hngxz700+gPKAOrA/IotSy5qvySQo3PTYGr3GVicLZISWxaRH0TNwD0beI5C5TUmmOjNCsRLExi4dlVOxyb0BoQaq4bQFSL9CDU0DJsjmrXP63vTxBODWH94L9FyxR6Z1Xthauv379S/55IXXN/8yRBZIUeUxD1B1NqyzJgkNyarvIkXPfKBzAUKbm5Rz/ZODG+KKTvCwc01FPZ/ijkszHKsniedJ8vuVx/Zhqj+stKyKCXYBR1S5jS1b3/az+7MzRM0e4Q3WRMtQG1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9DF2SbCxbTugIkgG5NuJIlSXEFmDFOKJ6o51wBRoPU=;
 b=Q1U2uSEuiXMfCfsrOuwBJRqQgoWq889QaULNkL3AeHELH2ef7438mTWGTwk0pqnc3MD2wcxTqhUDNfinEghpaitpFjUDhHoyF1ncu2N29OOI6uTH6zQhgW6nl+6/HKryHt2cc9KwgoIAvxex16AB5O3PH07dMXReEWlFhu3VqjHrjnhmBwsc0J4nRbDHK4GyQro7CR5YvUNgjx5pGO+AYuaAKTiXJDlgvz8JVrdqgwGWDDupJKV8Zf33XknePg1v4MR/UK7BNpfZTu65z7y7O+uGIoIlArsXYSjuCWPFas1sjs4/oA9vpwlQ9jXUNROFasRSACMBmo9Q3JD4wSafbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9DF2SbCxbTugIkgG5NuJIlSXEFmDFOKJ6o51wBRoPU=;
 b=VKL71slXVvbxhvgoHTai/gILk3Vapd+XV0Qh+hy2uGRbgozR5s5D3gOUq+k+YpUYDLddQjpYJ9pTxrS1rol8E/IJ78+veLg1XbP6tyvNaxBs5rJbJDALdF6dp/alLgBIXwMoZOvQUXpTWkuXvKBcpUsZdd1phdRIms8AwaLwI5U=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB8244.namprd04.prod.outlook.com (2603:10b6:510:10c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Tue, 9 Apr
 2024 11:24:22 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::48bb:3ec7:409:1907]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::48bb:3ec7:409:1907%4]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 11:24:22 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Boris Burkov <boris@bur.io>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 1/6] btrfs: report reclaim stats in sysfs
Thread-Topic: [PATCH 1/6] btrfs: report reclaim stats in sysfs
Thread-Index: AQHahf5gQlpuGEYBtESQXj/KTZErXrFf1PKA
Date: Tue, 9 Apr 2024 11:24:22 +0000
Message-ID: <5231b36e-26a7-4705-acf1-ca98783dcdb4@wdc.com>
References: <cover.1712168477.git.boris@bur.io>
 <b685cc587cee3fcd6e67f969a2f58063e80e38d1.1712168477.git.boris@bur.io>
In-Reply-To:
 <b685cc587cee3fcd6e67f969a2f58063e80e38d1.1712168477.git.boris@bur.io>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB8244:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 NeK46QXgeYofwA8TlmVptGHtyyqsezjfIu9ChDOb6EaeQIFU3klPIaKEC+FajG5aZVUCVJLpxr6GJzW+IYKpBaF6QGgP0j8mt6qfifHDL295unpZoUoCJjkGyVepSdJQWVcb777BjXkVZMwxeYz7QnGG0S+p2pHtQQZg3UkbJTLQAoPT7zpxmYC4wghtLuJt/UPZfGTRMB8NT3Cpfsj+Jc8I3NBQn6WVa6iIjWBEA/TR6CMoq9GgC8SPvvIiwILNtXntgt7tt+TyK1nUIIE6os3rOgBnpv0LZRsw1qgYO1ylIcEXqHTzuA2ge+YxrwtSjjgt/K7CLS1/a1bXsIdFd6Q8Az/uFQL9HSQTNun5k+hqMCc+43HVC3VskYKSkpjUHTs8DzywwjanqVnHmRVI9PdkBmXBuAM5z66mp6eW7fOW0hBRO8nLpJreG7wKM14OiyQYUDaAWTEXNppdaTf7C0r9Bnw9P9PXUpYRRvy91dZvnvhyKc2+4YHdFs+JJp8GwzOAVnhorqXCosA6K/4sJECpUJQoCLAg/r822hSduWoyogxn/H2d8zFjC911BIV9icGgvwK0yESnUJfuQT2+9DBqnnbT9B5tvgNGs88g/zh4d1X+xrdaYhA9bK0KPmhybsV9ODeUmm4OzZ/ANJSfnqMZcE+ZFAE2uzjMMpOtccc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZmxoMkxmdzVRMXBpTVBwYllLV3FiUm4zL3BrT0dLQXFoTU5hU2lpRlNXK2J6?=
 =?utf-8?B?ZHc1MDhoajM4NG1pRWNvZ2xDZUlwTDl3Ry9SOUlmcnMyZnZOTjFQVUZnREdI?=
 =?utf-8?B?VDlobTluemhKZGlhbGtkakZsTnhuOHgzQ3A4OFRBRllsZUMxSUVZVE9veXdo?=
 =?utf-8?B?b01Fa1V1RWMxN0wwVGFlcUxIOGw1Qmk5elo2WlRCK0xKT3hvL0V0aHpnWk9l?=
 =?utf-8?B?eWdJQ2wvSkUwNTZqUUl1djU2TGhqb0dBYTVFdWtnQzM5TFA1K0JUVWJWWHk2?=
 =?utf-8?B?dTZkSVplRm5yY1dQSGxzcnJiakYyRkN2TkthQUdZbnJWVFBISkFwY1lMMHFB?=
 =?utf-8?B?ajF1Y2FvRUwzV0RJUTI0NGNyTllUSmNtQzJPTFZQdHlIb0dTNzl1bWhLdWZj?=
 =?utf-8?B?a1FzeHk1MllCbmh1d1Z5MXM5ZUlON05uN3lwU3prdGVOVEMzMlMrbWNQaXFo?=
 =?utf-8?B?Nk8wL25IbU5IZFQvVmp5TjBUODA2aktGczhZSTNQSDh6ckxXNklwU2tEcHIr?=
 =?utf-8?B?T3NLbGs5b1JJaEhRbFFyejFWT2RiWk94cFJVK0I4SWZ3RTZoUlphNGFBbmxK?=
 =?utf-8?B?ai8vRXBldWFhbWV3OTJaazFyTnFxejQ2VXhOSWxMTWxoR2xYOHVoeVEyMVFv?=
 =?utf-8?B?cGhsUE0rSTlDdjZuUWtpTTQvVjNrV2MxamlVb1RmaGtyVkl1MHc0ZjVabDNo?=
 =?utf-8?B?bHdNWjlJSXNHZENHZnpvK3EwdjMwblN2UGlOUUFZelVRaVUzcjZhdnFseVhO?=
 =?utf-8?B?bkR2Q0hhOXkxUDNzOEppcmNQTmp2VmVJUm85ZkZYYUhhd2M3Mjk2OVpTdTd2?=
 =?utf-8?B?N3J5NUhSYTRwZjYvLzZLZW50QUNBUzVpUFN1MFhwaS9DN2FOb3BWMThHbDN5?=
 =?utf-8?B?NWxXY0FnNC9DelY5bzN2TGJSbHh2bjNaZGJLS1BrVHBCWXZjS3l5Vnk0M2FP?=
 =?utf-8?B?bEQzQXB5eFU5SFBNUWU1SGZLbkNuYWJoVVRGeHVUTTZGajRBN1Y1aDZXby94?=
 =?utf-8?B?VUJHNFJRVnQzVjZNaGZpSFJ2cVlsYUFzdFBEb0FkYldkU055T2tUT2I2VTJo?=
 =?utf-8?B?SGNsNnhJRm5Pa2RxOWlNcURzeCthU1VnNXgrSW03bE9VWUxFblNaTEp5dVpS?=
 =?utf-8?B?WFRWSENTeVcyZnlVMWYrb0pEMGxXUDZPN3N6WVg1RHM5ZytQNk1CbUIwS09D?=
 =?utf-8?B?VUY1ZnNFQUg4c1FNNmkvTENnMzhNaXArbGdqMXAwVUQvdGFOaXR4cEtuTTA3?=
 =?utf-8?B?cGEyMXc3SEFqdEFTR2VtSUczNmFWWVg1dXQwcnNjTTA4aUk4czZmU0xIV1k2?=
 =?utf-8?B?UTM0SndXcXZneUFWM1E1Ulp1bVpMY0h3SlViU2s2ejgyZXBvNGNJclNXa1Y3?=
 =?utf-8?B?VEFFSjJTbmcwd0lzMFBEdlJZQ01lK1VGS1V0QlZCdGhIVEtPWDZKcGVVMXl1?=
 =?utf-8?B?Y2pydkFyaEJRY0ZkMzh0T3lhakZlc2x4Wm5ra0RTQ0NENHR6T0srYmlxcEl2?=
 =?utf-8?B?T2FiR0l6eEsrQTlVbC96c2FFOUdkQ2Y3ZE5iR1hUbDJNd01nd0ZidzNSL1A3?=
 =?utf-8?B?OWJrQ2xRNk5vdmNlL2wyRnNQNnRwdHZBSi9Zb2M1SDlpOTVvUjdmS0JQM0E1?=
 =?utf-8?B?UmFXSEFXTkhPd0UrYlZsaHZUYjZ6eDBiUzVodHVZNHFCd1l5YjhZWTNhbnY4?=
 =?utf-8?B?RkJpbEg2OWloaVpUZGNYaGpCeFZEOERCend1YVBUWnZReHhFSWxTSU5zZEh4?=
 =?utf-8?B?dGwrdVlwOXFaUDJBWUhTdytEMUdoaUxJMVdNNUQvZUVZbjhPb0c1RGFNKy9r?=
 =?utf-8?B?OHdmTVJLaWJkZEJjV1FWbnZoa3Ria3JzWk1PcVJscmpCNzgwMDlaUUc5ZTZZ?=
 =?utf-8?B?NVBxTGFYWEZWbUpJSGdhVzcvMHlidkFyRklBSUkzTlpub3RFYnJDZWJYdTRz?=
 =?utf-8?B?MWdnNlo2MXltL0w1VjRPRS9QRy92aFdkS1dBOHEybExISXRibTNGRG5XS1Nq?=
 =?utf-8?B?di9vaHdEWjRJcU1rOHhIc3JBUEJkOC9GL0FieG1ELzRKZk53SWtVVUM3Z2Qz?=
 =?utf-8?B?QTIxcXR3Y1hsRkFCeThpVnZ1enZZVDdDUWUzeFcrME1ianRHRG5lL3pFT0hj?=
 =?utf-8?B?RkY3THIwdzV0SEdTeG5tbnlFUDM5VlFSNmowblE4bEZOYjdpelRSR0JZOTRM?=
 =?utf-8?B?NUtubVMzZ0cyMmVJN3IrV0tGaWVWZ2ExaDFEaXVuQThFMlpzVjNFeGRDcmxm?=
 =?utf-8?B?bS80a1BGNWM3cmdVZ1dSYldON2NRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C337E21012C08B4BA3B11E19953E8509@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OvwCDqMj0w0ahpyDQ6L5sc/5r9ZqINcwphIDqbmnfpO8WvPniLE8iClmo2fM3j0tZ/VNTbB7aVEzP18/F8eUGUhia8bRfTwnMmRe0EdGYOdbK8Hv/geXvKbVAsqxTV7nwQZmR0NEhZzWGyibdIylTRGkRicQQQ+lFnavIC2HOklgkjbUNCPTdESPKVkHo2zMch++JE224sF8s0AfftmiyULrw13jzPnse68xkg1GkF7NOah4nVyCtQV5HyI4/dPowQpN/g6K2oJ3cDY4B/TmS0nmzUI8L4N4hKZ8TSkos6K8/TXDi/GurqwUZXtkpW3CaivmpdMEHITlZbrt5VPoNI6MMz8I7CgvmkU837qp19u0Xn5MqsT9VxBo0shAcGSolBVi5YqKMCqiu0qmHyWQ2bQ/92mdEzPCAQOs3n4EsP0f9FhEMwtKQCSAJELug7V9Qq0nBTtJsjJH1W+NDJz5fUjhwve3FW/IhRXBnPYiWBxLczEN0H9KYRWaRDFrF5ds09rTxMlEF5hnX/OJTQMqvIXFCNvPzSvwHWD4UwdXfkzQz3+FOojFPw4fLjZL1/eWXWj08dqOgFLmI8ZXaCU50ExFOkWEmvkO9dFC4Qc8MgJ1hQj9X43ejeK11nbd0eR8
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ccfb48-62d2-4580-8036-08dc58879ae5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 11:24:22.1713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AZT8ZqewX7q9W+/dXK7YRYjPCxEyaG4n2SKhR4vIwIlFhf8KxjWzWxY/Mwy49jqtDQWA+C/JuI/n3wyLmAwD0uQ/lzA6do077c3VExKLQSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8244

T24gMDMuMDQuMjQgMjE6MzcsIEJvcmlzIEJ1cmtvdiB3cm90ZToNCj4gV2hlbiBldmFsdWF0aW5n
IHZhcmlvdXMgcmVjbGFpbSBzdHJhdGVnaWVzL3RocmVzaG9sZHMgYWdhaW5zdCBlYWNoDQo+IG90
aGVyLCBpdCBpcyB1c2VmdWwgdG8gY29sbGVjdCBkYXRhIGFib3V0IHRoZSBhbW91bnQgb2YgcmVj
bGFpbQ0KPiBoYXBwZW5pbmcuIEV4cG9zZSBhIGNvdW50IGFuZCBieXRlIGNvdW50IHZpYSBzeXNm
cyBwZXIgc3BhY2VfaW5mby4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJvcmlzIEJ1cmtvdiA8Ym9y
aXNAYnVyLmlvPg0KPiAtLS0NCj4gICBmcy9idHJmcy9ibG9jay1ncm91cC5jIHwgMTAgKysrKysr
KysrKw0KPiAgIGZzL2J0cmZzL3NwYWNlLWluZm8uaCAgfCAxMiArKysrKysrKysrKysNCj4gICBm
cy9idHJmcy9zeXNmcy5jICAgICAgIHwgIDQgKysrKw0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgMjYg
aW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL2Jsb2NrLWdyb3VwLmMg
Yi9mcy9idHJmcy9ibG9jay1ncm91cC5jDQo+IGluZGV4IDFlMDlhZWVhNjljMi4uZmQxMGUzYjNm
NGYyIDEwMDY0NA0KPiAtLS0gYS9mcy9idHJmcy9ibG9jay1ncm91cC5jDQo+ICsrKyBiL2ZzL2J0
cmZzL2Jsb2NrLWdyb3VwLmMNCj4gQEAgLTE4MjEsNiArMTgyMSw3IEBAIHZvaWQgYnRyZnNfcmVj
bGFpbV9iZ3Nfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQo+ICAgCWxpc3Rfc29ydChO
VUxMLCAmZnNfaW5mby0+cmVjbGFpbV9iZ3MsIHJlY2xhaW1fYmdzX2NtcCk7DQo+ICAgCXdoaWxl
ICghbGlzdF9lbXB0eSgmZnNfaW5mby0+cmVjbGFpbV9iZ3MpKSB7DQo+ICAgCQl1NjQgem9uZV91
bnVzYWJsZTsNCj4gKwkJdTY0IHJlY2xhaW1lZDsNCj4gICAJCWludCByZXQgPSAwOw0KPiAgIA0K
PiAgIAkJYmcgPSBsaXN0X2ZpcnN0X2VudHJ5KCZmc19pbmZvLT5yZWNsYWltX2JncywNCj4gQEAg
LTE5MTMsMTEgKzE5MTQsMjAgQEAgdm9pZCBidHJmc19yZWNsYWltX2Jnc193b3JrKHN0cnVjdCB3
b3JrX3N0cnVjdCAqd29yaykNCj4gICAJCQkJZGl2NjRfdTY0KGJnLT51c2VkICogMTAwLCBiZy0+
bGVuZ3RoKSwNCj4gICAJCQkJZGl2NjRfdTY0KHpvbmVfdW51c2FibGUgKiAxMDAsIGJnLT5sZW5n
dGgpKTsNCj4gICAJCXRyYWNlX2J0cmZzX3JlY2xhaW1fYmxvY2tfZ3JvdXAoYmcpOw0KPiArCQly
ZWNsYWltZWQgPSBiZy0+dXNlZDsNCj4gICAJCXJldCA9IGJ0cmZzX3JlbG9jYXRlX2NodW5rKGZz
X2luZm8sIGJnLT5zdGFydCk7DQo+ICAgCQlpZiAocmV0KSB7DQo+ICAgCQkJYnRyZnNfZGVjX2Js
b2NrX2dyb3VwX3JvKGJnKTsNCj4gICAJCQlidHJmc19lcnIoZnNfaW5mbywgImVycm9yIHJlbG9j
YXRpbmcgY2h1bmsgJWxsdSIsDQo+ICAgCQkJCSAgYmctPnN0YXJ0KTsNCj4gKwkJCXNwaW5fbG9j
aygmc3BhY2VfaW5mby0+bG9jayk7DQo+ICsJCQlzcGFjZV9pbmZvLT5yZWNsYWltX2NvdW50Kys7
DQo+ICsJCQlzcGluX3VubG9jaygmc3BhY2VfaW5mby0+bG9jayk7DQo+ICsJCX0gZWxzZSB7DQo+
ICsJCQlzcGluX2xvY2soJnNwYWNlX2luZm8tPmxvY2spOw0KPiArCQkJc3BhY2VfaW5mby0+cmVj
bGFpbV9jb3VudCsrOw0KPiArCQkJc3BhY2VfaW5mby0+cmVjbGFpbV9ieXRlcyArPSByZWNsYWlt
ZWQ7DQo+ICsJCQlzcGluX3VubG9jaygmc3BhY2VfaW5mby0+bG9jayk7DQo+ICAgCQl9DQo+ICAg
DQo+ICAgbmV4dDoNCg0KVXNpbmcgdGhpcyB5b3UgY291bGQgc2F2ZSB5b3Vyc2VsZiBhbiAnZWxz
ZSc6DQoNCisgICAgICAgICAgICAgICAgIHJlY2xhaW1lZCA9IGJnLT51c2VkOyANCiANCiANCg0K
ICAgICAgICAgICAgICAgICAgIHJldCA9IGJ0cmZzX3JlbG9jYXRlX2NodW5rKGZzX2luZm8sIGJn
LT5zdGFydCk7IA0KDQogICAgICAgICAgICAgICAgICAgaWYgKHJldCkgeyANCg0KICAgICAgICAg
ICAgICAgICAgICAgICAgICAgYnRyZnNfZGVjX2Jsb2NrX2dyb3VwX3JvKGJnKTsgDQoNCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGJ0cmZzX2Vycihmc19pbmZvLCAiZXJyb3IgcmVsb2NhdGlu
ZyBjaHVuayANCiVsbHUiLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJn
LT5zdGFydCk7IA0KIA0KIA0KDQorICAgICAgICAgICAgICAgICAgICAgICAgIHJlY2xhaW1lZCA9
IDA7IA0KIA0KIA0KDQogICAgICAgICAgICAgICAgICAgfSANCiANCiANCg0KKyAgICAgICAgICAg
ICAgICAgc3Bpbl9sb2NrKCZzcGFjZV9pbmZvLT5sb2NrKTsgDQogDQogDQoNCisgICAgICAgICAg
ICAgICAgIHNwYWNlX2luZm8tPnJlY2xhaW1fY291bnQrKzsgDQogDQogDQoNCisgICAgICAgICAg
ICAgICAgIHNwYWNlX2luZm8tPnJlY2xhaW1fYnl0ZXMgKz0gcmVjbGFpbWVkOyANCiANCiANCg0K
KyAgICAgICAgICAgICAgICAgc3Bpbl91bmxvY2soJnNwYWNlX2luZm8tPmxvY2spOw0KDQpPdGhl
cndpc2U6DQoNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1z
aGlybkB3ZGMuY29tPg0K

