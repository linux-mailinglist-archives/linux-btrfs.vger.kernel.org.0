Return-Path: <linux-btrfs+bounces-11246-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8BAA25D33
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 15:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36F777A1E03
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 14:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6C720D516;
	Mon,  3 Feb 2025 14:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OSh6IBlf";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mo5SoNNP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810A420CCFA;
	Mon,  3 Feb 2025 14:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593704; cv=fail; b=rbzbMR/FT3DvwkfXUQgs/9Q4rRzalATKWu0QNtzGIG6jKG7R1IktVhMsFa7so83TXiiKThICruVy/h01INvrHMM98yizItCyXxEWnCbWv8qn4hrjWyPM4/vu6AaDPs+ED+YPtZA5npMX34Dfv77aX8UVk7Rx1O+IJu4aiAoMLIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593704; c=relaxed/simple;
	bh=Tx5T6qLciYED91tsefwMiu0wMXSYGFFHe1q2g/NqVTk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bGSVXa9x3D8CVAcnjO0r/sibuwhvsQgA9LpsDF2tVmQjIX0qLcRj27wV3YrXwf+BQxI+if+iB8atjOv76VXkR4iQrZAh1eerSzDqiiXfUeS3819fAqsUxg5hwHLu/d8FfrhpeFkqHjHdazUes22eI2cOivKbB6U+uMoya8XZaK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=OSh6IBlf; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=mo5SoNNP; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1738593702; x=1770129702;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Tx5T6qLciYED91tsefwMiu0wMXSYGFFHe1q2g/NqVTk=;
  b=OSh6IBlf/CTl9HYO5MDHQ7MC9VHu9MYUfiwE7M328TXpEOD7ql5G3ttp
   dzeLOi8ndcbNT1kYlwbw3TPOSletgYX7ZI378mZGxNUxY5+J1V48vdVk/
   wEsRrzqs+iCXLdz2IaXDe6S2/WPtmrt4UH5lh1mpikB8FcjlGLwG016eo
   5IqJZMjldgrbw5ZLpI2i9hXKJzFX1LIxSSfkL0OYwKfy3K6ppcqEvzimJ
   VlHLNZh53ixV2sAw3VclV41OEzzd/EivjL9r1XKfJ+j7AhqqNOzhV1get
   6cTYLe3SyBPAVy3roXpFvZZ/5lubcUyhxUq8DUJYrJLHCPlUfhg+l2o6z
   A==;
X-CSE-ConnectionGUID: 2+xspIm7QMmbqBMFwF9vRw==
X-CSE-MsgGUID: YJfgnOkkTTq8gmG8wF5bkQ==
X-IronPort-AV: E=Sophos;i="6.13,256,1732550400"; 
   d="scan'208";a="38470194"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2025 22:41:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqOCoAFQI0E+SWHYnzGgchYQvv31YurHgOolFCyxwrHqw0ooH+Vu1qxJJcIz0YG8VOQLXwFLjENcNGPmgJbG7ZMHIBmG4JjJoHsaVBXdEp9Js+VywKfACCa0qLLfUdE2iSwLZZiUJzexUyKVOhjkutc2/aF4LlJSJShaKIm8PhVvd+37+nfARP7CJ5D7MKhOn9Hu95liYNwvzG84aeYLJ7WClSPH56a+FIIdynDfvvwCwPbx6oS4aUQp23uCDqy3ZyaaCdxmlivT7rS0Pqif0e0dYsV9h+Yn8px+3AIB0Esk8pO1Ge+g9G0GNJTSOmgs16PQWbCX9DvNfb3VhGnedQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tx5T6qLciYED91tsefwMiu0wMXSYGFFHe1q2g/NqVTk=;
 b=E4orDQOLkZ+qsGK38K4OiPhdSoXMYDx8ZYao6zo1WGyNwPpycmgNgvy8CLH8eO0XIgILCsZ0tkMbOZ42hJZRHuKtSDVtjwSib5krtvv/Ns50FNr5vgRFxNzkEDpUEvp0yhLuJoR9cr1wYZtaCQ4KD00BmMyK/zcMMNSwHw7P2w2kCv3F9SKvdzuvsphaB48mZBByPBU03X2HgE/5RSGWoFJ8fbHns5bdomL25H95ritc0syPEzzd+F4gOzY/gI6s4VLOoIGHSgBhS+lGHOhEDqkdkugWG9+UPrstxxIQrHGWMNIK57Hrru6J7V1rLFQzkoms8QriaYEK21T6irAd/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tx5T6qLciYED91tsefwMiu0wMXSYGFFHe1q2g/NqVTk=;
 b=mo5SoNNPUf3xDIMzqQyRCDoPFdfipOwRllRAo+scg8/Zi1/CM/CInltyTDPu/8FJjcoJQWYmCFClC4pkLaf/stKrHctI5dJnfZhFcYrgkaAbRcJQcHVHbN/9T2Et2Mp8+JOWxXryLxlD3jxdqTfZVP6Z231e5Nj0sCSILB36MQw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DS1PR04MB9274.namprd04.prod.outlook.com (2603:10b6:8:1e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 14:41:33 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 14:41:33 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Kanchan Joshi <joshi.k@samsung.com>, "josef@toxicpanda.com"
	<josef@toxicpanda.com>, "dsterba@suse.com" <dsterba@suse.com>, "clm@fb.com"
	<clm@fb.com>, "axboe@kernel.dk" <axboe@kernel.dk>, "kbusch@kernel.org"
	<kbusch@kernel.org>, hch <hch@lst.de>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [RFC 0/3] Btrfs checksum offload
Thread-Topic: [RFC 0/3] Btrfs checksum offload
Thread-Index:
 AQHbclgBeWHKAo6I/kGqcNmmsyoZKLMt1wkAgALXZYCAAALFgIAE6FcAgAAEL4CAAAZ/AIAACoiA
Date: Mon, 3 Feb 2025 14:41:33 +0000
Message-ID: <593c961d-ea31-4e73-85c5-5b330ac07ce6@wdc.com>
References:
 <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com>
 <20250129140207.22718-1-joshi.k@samsung.com>
 <299a886d-c065-4b75-b0be-625710f7348c@wdc.com>
 <572e0418-de26-47ec-b536-b63291acff52@samsung.com>
 <73ba28f4-0588-4ca8-b64f-2a6dd593606b@wdc.com>
 <8e548c8f-7a05-4e82-aed7-6044a0d247c9@samsung.com>
 <f2ccdba4-86df-49ae-a465-1f8003fc1fb3@wdc.com>
 <330a257d-e276-40d2-855c-8d108abfde02@samsung.com>
In-Reply-To: <330a257d-e276-40d2-855c-8d108abfde02@samsung.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DS1PR04MB9274:EE_
x-ms-office365-filtering-correlation-id: 14501769-9ef3-4b33-54db-08dd4460dae2
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q1FmWGIyTEltVnFVamQ3SEwxdzdWK0I2RUtZQUVBSklPYlZ1UW1HQVg2OUhP?=
 =?utf-8?B?VnNFSEg4ekpFaHlKbmk3RXJrOVJmdWRUL2VkNnhDRzFlVkQxUnZ2Z3dKSGRD?=
 =?utf-8?B?MUh2Ylk0MWNnYnozWUR6algxQW4yNmZKNVBUMGNnWmV6VjBibG1MYXU4ZHRa?=
 =?utf-8?B?aENLQ3dBNG9YTjF5bWpGTjZMOTYyTVdOS0ZHRkpBdHdMQklwYlV4cW1PT3pN?=
 =?utf-8?B?dEJmTCtVR0pQeWNBNlUxUWJwalcrdzNIMitqY01vaVlGN3VpcDFrWHVueVFs?=
 =?utf-8?B?Qld1cC9CZDZFcnBsWWVsWXZPUEswM1ZacURUWlp5ajY0b1lmRFRTZ0ZqKzhL?=
 =?utf-8?B?d01BY0I0Nk13WXZzTlN3bndkcHFiK01WZUxqcXNLMFd4RFdGa0wxZ2NwNE9D?=
 =?utf-8?B?c2R4TXBLNHNiUEdXaVBwcmxZdWtWTDNhNHFNQU5YTDJ6TVpNeURHODN3RUZE?=
 =?utf-8?B?VTZ0Nnc3Z2FCOStHRDJkK2d1UmxzekxMYUFpemphaTdacm9NZTNiQ2p4YXRu?=
 =?utf-8?B?TFNENllHTlpTZnZNYnRwTCtsQ25GaWVHZEdlSGxsdG56SjFNZlFHdEFVeDV2?=
 =?utf-8?B?Wk9aYTFCOE9JSUZ3MmhQZU9waFB2UHlVVjIyeFp0NUpWOC9TV1lyZmE5WTBz?=
 =?utf-8?B?UWZkY1BZN0s2dHJ4aHQ5YmhBWXhodEdlbDdlWGU0SXQvUDcyUHI1N3lIdXNC?=
 =?utf-8?B?OEpwYmhXU3JFRTVyQ2RqMTZCdytlemdEY2xFeHVwMExsenlCUnVITTNLK3Fy?=
 =?utf-8?B?TGhlWlNPQlhMNXgycEZpRnVDSFJtc2p0clg2UE9za3VDcHI1eEEzK0UvT3J6?=
 =?utf-8?B?T0VjNmNpRGppWEZoZnJuaXlFTCszbzFXY29tNDdGRlVReDZpNnpWcVlRYnBv?=
 =?utf-8?B?SFZBOW5aa2JBSWROdDBLdDNZcVpMZTBkYTFQMnhDeWw4cjZnWU9lRDd6NWFO?=
 =?utf-8?B?R0xFc2ZKSWFxanhMYUNDaURHUUlnMVVscmdrNGtuRHF6ZmtaYzlndDAvUnVO?=
 =?utf-8?B?QVZNNDB0NS91SFYvdkU1OWExWi9CMGRibXdMWi9WVXJVZVRJbXdiTjVqMDVa?=
 =?utf-8?B?RzcyTUxjanVCRDk4WUhIQ0lUT1NjdU12bHNzMTNxQjJlQnh3ZzhPM1VEREhW?=
 =?utf-8?B?TzZiQ2dDd1hZREpyUGV4aXR3U3R1YWNqWWpXZjBZYUFEL2VlVmd0ZzFGaHNu?=
 =?utf-8?B?d0loVm01L0xIRktabDZGMW1rZVlkM0tsaTNQS0NDNmZuT1h0Rk51TmJjWnBm?=
 =?utf-8?B?bTNhS3hUWlVOV0FsQjVjUHpWM0NuRjB5K1F4SzdTZnZxaUlPVzBIdkgzRXda?=
 =?utf-8?B?cDgrbEE1eVAxMS9IMGVzNldYbkJ6bnM5am0zOFErSURaaFRVTlFXOExyYm5k?=
 =?utf-8?B?V3d1Tkh1STVKYzdOL0daZjZXeDF1WnYxc3pqbXZoZmIzUy9BK2JqOEVUaDFT?=
 =?utf-8?B?VFdLMWNxSmZTYndQbmhhWEl1NEtpSHYxY05QTG5NSGxGbFU3RnRLc2s2UWdy?=
 =?utf-8?B?bGZOdjF1K0g2UzVzTldJZjNtbW4zRGxZRms2amt0ZTRISWtUQ0tWSEhmVlAv?=
 =?utf-8?B?M2tnNWRsQ0ZhN1U0WXdycXdsK0ZMQ256c3FmV2tiVjR6N3pEbjY1bE1BRk1M?=
 =?utf-8?B?aXkyV0tyTVpjUXJvVHNCMXVqaUd3Tm84UjFSYTFwRUdzK1RuaXg5UWxDcE9L?=
 =?utf-8?B?NURmWGFla0x5SDJNVVFwU3F3NkE2d21vQWxXeXkvQVFaMmtmMHdzV2lwek02?=
 =?utf-8?B?QjdRcEhaYmJYeGp4ZmoxMmx3d3lnM0Z3cjBnNUtmRzk3Tkwydk5RMXVZdFhp?=
 =?utf-8?B?dm9JVG9MbjNlUnh1clV4UTdxczBmVjFQOHF0bGVheUxhL205WG04cjVoNXlU?=
 =?utf-8?B?ZTN5SWZscVh2ZGJxWVNtYzNIM1JUcGlXNllkQ1ZKdUNmNTdmdCticzNzbUFQ?=
 =?utf-8?Q?vJUpANjUWe0uEKCQDI20hYv+iGtUduqJ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WEVCMkcwWVl0ZVV0dDNFUFdNdng3dE9TMlpKTTFRbTR2VHBmRGZCL1puWjRZ?=
 =?utf-8?B?YVJlSU82Z2RCS3lianNOcXFITEdpMS8vSFBkRDMxVE12QWtlNGM4WVZXMmpV?=
 =?utf-8?B?cGN5by9QalN1TW4wRnQ1cU5iRTRNdVFZR1d5amFDdENtUWxNZXIwTFRHdjNN?=
 =?utf-8?B?S3pVWTNWZkpHTzBabER5Qk5lTWxNc3VUK0lKOEVUSGpVNllJZGI4bFZqeE95?=
 =?utf-8?B?OUI5dUJabUNHa2FOZ1hWK2pmOXVFRHNMamc3U01zNVR6VXlyMFdxTncrL0Q3?=
 =?utf-8?B?dHdyYkFSdGxiUHpTR1pNNWJSOGpmbE1ycnVWenRvVm1CNFRjYThHWDVOQ3dJ?=
 =?utf-8?B?b0kyWFhTVTJaVUdSRkl0T2dvWVJUQlNxYnBrWGpHdkM2c05UT01Hd2JsaTFT?=
 =?utf-8?B?L2ZrbEcrRzVKUnhEblVDdVd4b1ExNmk0emhIUkhqNCtnVEk4aXNPcWNhMHZR?=
 =?utf-8?B?WHBsZlpvd2M4UTY4U3ZIZ0VXd094dktYaHlDV3VzTjFGY2pyZ01UNWNUYm9q?=
 =?utf-8?B?bXVKMkRTY0lVcUhYMHRSSWhQKzJ4NndGOTNjMmVMVGdlWmJ5cWdMTnpqcWtR?=
 =?utf-8?B?UlcxZndESlNEMkxoV3ZSQWhBRkdVRFNyOWlZRTVvMWtRQnhvZm1TazkwK0JD?=
 =?utf-8?B?UmdEVERrN0kxTXAzemgwM211bTE3d0tMYVdNZHBnVTBwTllydXJkbHdoWDNv?=
 =?utf-8?B?a2lBcTRVeFUreWxWQzJET0NYYURvSWJuQ1B3Q0JNcXpWeTd0Y2tsTkZ5cjJq?=
 =?utf-8?B?UkkvWHpKcW5uajBtUTljeVY1QXVMZzd6QXUzRUIvaUVhSnhFZDFZQUtOYjkx?=
 =?utf-8?B?QjlyZ3ZXUjBtek00QkxEVVZMcHJPeEpjT29xWHYrRjBiY29TdU1PeW4yRmNH?=
 =?utf-8?B?M29FZ1d6cHdMTDNEeCtqZldKZmVFQWMwYzZPZWxWR0d5bE8rcFd0UnZvTXRn?=
 =?utf-8?B?Zm9pSXBFTlAyaFJYZTlzRW82UmgzUWJVa1VWVVBBRGIzdjg2ZFN4QmkxREJF?=
 =?utf-8?B?TGQvM1d6djZKcHdLeTBMaWpoT2s2YlgrVGtUQm9FTHlMOVlEeDEvT3pTSXpF?=
 =?utf-8?B?dkRlTk9TalM4KzFMdzdScFhoWDhFZFZ4TmJaLy9NckNSUFlGbkpTR25YZTNo?=
 =?utf-8?B?UlVEaU12VEVpeXlHL0V5YXNBN0p0WkZQcGlEZlhKL09zakwvbmgzNEVHYjhs?=
 =?utf-8?B?aUU1YzZwZ0RieHFJR2RzWGJHY0RvSUZ4K1BKamFSTUhqcmJUQ1RieHNGUkZT?=
 =?utf-8?B?SUR4ci9ER002NXZITHgwKy82NndiRC9JcFk1aml1OWdmZGNsaGwyOS9QVHVx?=
 =?utf-8?B?V1VpK1dTU3VLb1JEMi9pRm9sU0Nxa3h1MFNZMHgzdlN4d2VhQlgzenNBVytO?=
 =?utf-8?B?Rll2bVpCWmpRcUVHMFVHWmdlYUpvd3FMeS92Y1ZNQkQzYlZxWVVaODJxR3kx?=
 =?utf-8?B?UFlFSFNic2lDVUpDR3VLS1c3RkF4WXQwOGl1NG5vNHpKNlQ5aUhNSzJTR0t3?=
 =?utf-8?B?K2FJeElwUlY5Qnp5UlZIU2pXWnZLbDVQZ1RJa0FjSTdBMVgxc3JFa3dyOXRa?=
 =?utf-8?B?S3VKQjdrOHo3QjRVamlzTndvYW5yNTFyQWJETVVNZzZCNnd1NWpBd1IxekdY?=
 =?utf-8?B?YU9QS2VlZTVaQmVUZlU3b0lzY21pWCtOMjdSRCtIVzM3Z0IzL2p6NnZCYmJH?=
 =?utf-8?B?RnlsanIvYlF0Yk5JamFyeFJuWXpaVDJZRGM4YWMzdjJuREhoOGFjd3Q1c1NS?=
 =?utf-8?B?ZGNBRnpvMi9QeHlDbWpjenBpbXQzRkhHTmZHc3pjbEFLVjl2c1A0Z0RyQU9t?=
 =?utf-8?B?dGhoRHdWeFNFUmw1M1RYWWdKaHkwZVIvd2Q0dkxyRTVQYk54MTd2ZEY4QUtC?=
 =?utf-8?B?SVBsUVgzWG9yaEwrM0tGcGJHN2oxb08rck56RFV6SzBEYWlTNW14TGNrSldE?=
 =?utf-8?B?Q2EydGVxSG55VEtDVDd1d1ViMGJpdXRRODh6NE56OWFmQkRZMEV5VGI3NzRS?=
 =?utf-8?B?MHhkQ3B4Rm54QWQ4TjVrbmVEQ241djNnaDViQzYzSXVjQ3h0SzVxWnlXanhM?=
 =?utf-8?B?Y3I5bHhRKzFCeE5NVjJnenRDL1lnaG5XSHhHMFgzUUhRek0yaUczYllzWWN1?=
 =?utf-8?B?cEtRT1g1aTcycXhTM1Y2eDlQRFRPS3JaNFZ0bVV3TjcyMW1nOEVyRjdFeElr?=
 =?utf-8?B?clE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0188826617F21648931FD0C020B8041D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5k82K6K88Vo6zuiy955FgrVjCCCJIIvo3f7zfM+zKUD9e2efEWpv2D5Sfa/zUwakFLNzSrLE6WPGpvwp4vrwh2fa3Fd85tvreTYg3g/1GxnhcQH4Ku8veA/eEqSLH/8F/PcCyWerxzgdhls652f3lXARoOfrkXteSbpTOXNuqFtZOKUaQ+RtQxAERZpgAM1AdtBrckZsYhsjPBzUyXwbsxdJe3vEXHc22730Bk+I/KcCia91Rub7YNE32Y0nKX8cbZbzUpoIIfg8JYh8+CemN5fQu1/oMC2bcT5LMoPDQhAP2iAvSFJuPWdlGBAkhZvbCLPu6bn73MOUSQjExI2fD6tH8///ykW/eHXEhyAY3AAh0GXriJ2+jAadXM2y+Xhq74DnBLnhZGucThv14ogvbxsP7ee3yNyNKYi1MaexQxDWF4vaUhZgCV0RnoPzzksOsyOExtdmmonB+RXtC7PHjIt4pSWoBLb4iPxAofMjBr4ouTKu2V+9WrVrSAI2unKgbv5Ub4L/LWoKwJI36TBDXUQMXRE8S90Eip4tGoqcgLZrE4VuL0OnjTkP2hDBjxe8OF+yU/WZDlRM+HRVtNmRZiLptVhdKSN+S2mXkk+JuDZY2BTORFJ8GqrvfpqpV3dH
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14501769-9ef3-4b33-54db-08dd4460dae2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 14:41:33.5655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dkAvtmU5AJGJ7mvB3OuTvVpoEDQc5ex9sOqVBE/NWAH66aCVSn1iE8cgSSal9/Z5jmQSDu5fV51k8TgY+B9erkfXhb9o3Z0PrOk8kahQNFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9274

T24gMDMuMDIuMjUgMTU6MDQsIEthbmNoYW4gSm9zaGkgd3JvdGU6DQo+IE9uIDIvMy8yMDI1IDc6
MTAgUE0sIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4+IEJ1dCBOT0RBVEFTVU0gaXNuJ3Qg
c29tZXRoaW5nIHRoYXQgaXMgYWN0aXZlbHkgcmVjb21tZW5kZWQgdW5sZXNzIHlvdQ0KPj4ga25v
dyB3aGF0IHlvdSdyZSBkb2luZy4gSSB0aG91Z2h0IG9mIHlvdXIgcGF0Y2hlcyBhcyBhbiBvZmZs
b2FkIG9mIHRoZQ0KPj4gY2hlY2tzdW0gdHJlZSB0byB0aGUgVDEwLVBJIGV4dGVuZGVkIHNlY3Rv
ciBmb3JtYXQNCj4gDQo+IFlvdSB0aG91Z2h0IHJpZ2h0LCBwYXRjaGVzIGRvICJvZmZsb2FkIHRv
IFQxMC1QSSBmb3JtYXQiIHBhcnQuIFRoYXQgcGFydA0KPiBpcyBnZW5lcmljIGZvciBhbnkgdXBw
ZXItbGF5ZXIgdXNlci4gT25lIG9ubHkgbmVlZHMgdG8gc2VuZCBmbGFnDQo+IFJFUV9JTlRFR1JJ
VFlfT0ZGTE9BRCBmb3IgdGhhdC4NCg0KVGhhdCBvbmUgSSB0aGluayBpcyBuaWNlLg0KDQo+IEFu
ZCBmb3IgdGhlIG90aGVyIHBhcnQgInN1cHByZXNzIGRhdGEtY3N1bXMgYXQgQnRyZnMgbGV2ZWwi
LCBJIHRob3VnaHQNCj4gb2YgdXNpbmcgTk9EQVRBU1VNLg0KPiANCg0KVGhhdCBvbmUgSSBoYXRl
IHdpdGggcGFzc2lvbiwgSUZGIGRvbmUgdGhlIHdheSBpdCdzIGRvbmUgaW4gdGhpcyBwYXRjaHNl
dC4NCg0KRm9yIHRoZSBnZW5lcmF0aW9uL3dyaXRlIHNpZGUgeW91IGNhbiBnbyB0aGF0IHdheS4g
QnV0IGl0IG5lZWRzIHRvIGJlIA0Kd2lyZWQgdXAgc28gdGhhdCBidHJmcyBjYW4gYmUgdGhlIGNv
bnN1bWVyIChpcyB0aGlzIHRoZSBjb3JyZWN0IHRlcm0gDQpoZXJlPykgb2YgdGhlIGNoZWNrc3Vt
cyBhcyB3ZWxsLiBMdWNraWx5ICdidHJmc19jaGVja19yZWFkX2JpbygpJyANCnRyZWF0cyBiaW8u
YmlfaW9lcnJvciAhPSBCTEtfU1RTX09LIHRoZSBzYW1lIHdheSBhcw0KIWJ0cmZzX2RhdGFfY3N1
bV9vaygpLiBTbyB0aGF0IHBhcnQgbG9va3Mgc2F2ZSB0byBtZS4gQWxzbyANCmJ0cmZzX2RhdGFf
Y3N1bV9vaygpIGRvZXMgYW4gZWFybHkgcmV0dXJuIGlmIHRoZXJlJ3Mgbm8gY2hlY3N1bSwgc28g
SSANCnRoaW5rIHdlJ3JlIGdvb2QgdGhlcmUuDQoNCkluIG9yZGVyIHRvIG1ha2Ugc2NydWIgKGFu
ZCBSQUlENSkgd29yaywgeW91J2QgbmVlZCBhIGZhbGxiYWNrIGZvciANCididHJmc19sb29rdXBf
Y3N1bXNfYml0bWFwKCknIHRoYXQgcmV0dXJucyB0aGUgc2VjdG9yIGNoZWNrc3VtIGZyb20gdGhl
IA0KYmlvIGludGVncml0eSBsYXllciBpbnN0ZWFkIG9mIGxvb2tpbmcgYXQgdGhlIGNoZWNrc3Vt
IHRyZWUuDQo=

