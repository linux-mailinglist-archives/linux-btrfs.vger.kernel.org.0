Return-Path: <linux-btrfs+bounces-9252-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 950EE9B65EF
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 15:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CFFA284773
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 14:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1AC1F12F5;
	Wed, 30 Oct 2024 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BU4UZOTa";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="d2MHp8Zm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71AA1F1300;
	Wed, 30 Oct 2024 14:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730298594; cv=fail; b=JMmhufCR6DJmfPGOT8MLiRPUrky5at5vr7qtS/OkBcE4RIeGEDXeD1cuYI9iF5mYo3y4VeSM6PQSztUQpTB24aW5wTWWXrsNZRFq9H+xlwxTLjPi3/Ap282AXwQcbkMhbGs+OlewCVbZAobuTN5JfSm37BRoeH69zscf+RAlOb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730298594; c=relaxed/simple;
	bh=EVrKTBv4R1nVYzMbNJSOUW+abWbqVeZIyBD997SPy08=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hl/7qvJBCR8UNAJ5pc2jLLsbA81KamSDxzrOcZqUDZ8WcR7aobz3M8owE9oLXWI8Le4WNP80n5befs3zqui4v+wHLiJTvNV1wFnWj0Yy//5zvg464BOqaqZGs8yIrId4+C5I0ccYxIgzzJUHe9UtDJpzc0Emyxg5Okk/pP8VroM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BU4UZOTa; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=d2MHp8Zm; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730298591; x=1761834591;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EVrKTBv4R1nVYzMbNJSOUW+abWbqVeZIyBD997SPy08=;
  b=BU4UZOTaW0HAKaSt+3DYNTZgO38OdboFfnLKg1qSAfHyp+p3NEkPQUTy
   rLNJbzFn42gDHzSaSkOGNyIAgiVCxqMt9+7f79RP8nqLfpeCfdpScIks0
   N6kLHBwn03wy3Y+1Lh2NKBOI6DmWapgKE+8GJUOy64Cc2hiFO1B+qNWLG
   KSg1wv4phaOcRdbNgdVYFR/zjsi2gLbNSz2KvM+Gd1btanBYPmgoNmY75
   M4iqmImfJcgrl+9MZPPKRSXBCTEDvdGUjcik13kKnnZNiwuOOqRtcAHpU
   NimPi/npRR3hM41rqcFicTocbOAfBDknjryaXg9JKKvGKI/wFTpjEeR62
   w==;
X-CSE-ConnectionGUID: in9FdJgFTESRfIiEb1TUFA==
X-CSE-MsgGUID: DMGMsLBTT+GVKLhDcoAclQ==
X-IronPort-AV: E=Sophos;i="6.11,245,1725292800"; 
   d="scan'208";a="30229438"
Received: from mail-westusazlp17010001.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([40.93.1.1])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2024 22:29:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LgbMyBuBByuwGeJ1qRsZoZQxyDWNtOkY41A/1wN5+kBMP6TI9/63B87iPbGvejUOXqq486E9FdpfoRRMHa6HYXC92ARgC/ur8k6y4OOkyaqWp4TQZt7OA0ssQ+Ditt2rDBtfWuRzxncXPI13prwu/Gc/Xu/D/mJEQoHWZN/VcwkesNHZAZx0oUs5Sq8evPX6Tlz4sHJciy3wj7TUDcRibsV4UVq4+OVj7pPXEYoxqJm8Jyh9vlcuRTOU5ysM+FA9fZ7bI2Gr+w3I5ocujNk1bH+gSdbKy3xVlWnZiCO90mnQZx98pWmKpGU/3BHQ+BKjiP9H+rsjH2mgsEd6/wk4eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVrKTBv4R1nVYzMbNJSOUW+abWbqVeZIyBD997SPy08=;
 b=dw4CEslGO0pKr59Ac7Q9A0bNEBJEuUhZ6vL/3pf43TUYUWmGCblp/5d1hFi1XvtGykXodPkN4l0RdWXhR2uaSrELkENpgenUFNLQLwCcAFZfHCjoOUkyOt2qARSAUg7gaNMbxVCnEkArYXHhwOgl2JAnG1GruQMBpvkeLiDLyH5Nz1Riu9+nIU1eRLXtiNqWPtuUr9SQana8j2w0g1xCMmuuYyBSUNg3AbJc7B6HkBf7l/y1kqkudXCBQi7Kh0iH16/jFs0cVIxMRu0TVVYSugQPBxJ6C2CYx4QEw4g8Akm/BE0OE5KhLCOFoibLC/GSWWTz8cn2MdKasxFt8LDFBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVrKTBv4R1nVYzMbNJSOUW+abWbqVeZIyBD997SPy08=;
 b=d2MHp8ZmlHNcCEYyJ7MjyQG57jLio6xruO36aTkAXUJlbQKNLZICu5q+mesgvisVtb7bUxau+LK4JQCu3Zb4rKDpOhs9NSN+q11hp9TW2UHEEON8/0ZijV7JeVWGpZ+KZlbqEUeDn7+inqWDt2agdcnixGm+vWvdjh/UkiYbJkQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH0PR04MB8114.namprd04.prod.outlook.com (2603:10b6:610:f9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 14:29:36 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 14:29:36 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: John Garry <john.g.garry@oracle.com>, kernel test robot <lkp@intel.com>,
	Johannes Thumshirn <jth@kernel.org>
CC: "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "song@kernel.org" <song@kernel.org>, "yukuai3@huawei.com"
	<yukuai3@huawei.com>, hch <hch@lst.de>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "hare@suse.de" <hare@suse.de>
Subject: Re: [PATCH] btrfs: handle bio_split() error
Thread-Topic: [PATCH] btrfs: handle bio_split() error
Thread-Index: AQHbKeKi9TIjMidpj0CKdqAwMRBjTrKfVHeAgAABpICAAAPSAIAAApcA
Date: Wed, 30 Oct 2024 14:29:36 +0000
Message-ID: <d3eb6a21-4d76-41a3-beff-e6912e6c999b@wdc.com>
References: <20241029091121.16281-1-jth@kernel.org>
 <202410302118.6igPxwWv-lkp@intel.com>
 <c9936883-d766-41f5-9a54-35702585ff6a@wdc.com>
 <92ea9e18-6174-4619-84a1-2c55a1e86693@oracle.com>
In-Reply-To: <92ea9e18-6174-4619-84a1-2c55a1e86693@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH0PR04MB8114:EE_
x-ms-office365-filtering-correlation-id: b116d1d7-027e-49aa-3388-08dcf8ef47c4
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aWRzR1NwaENNL2lEL2pMK3pSR1lUbXJXUVJCeS8xNlJtMXRMQUJzayt1eWRP?=
 =?utf-8?B?NXFHMHZTVDdBbEtTL2ZmeTJXemY2anhRWG5FaDEvQXZaa0Zjc0ptR3liNnVR?=
 =?utf-8?B?STRtczQxRnlrK1o0YXdUb3NLemtrSmVERU5rK2FMQ1ZqeGQwdmpGVlJDaExY?=
 =?utf-8?B?RWIzeGhnOTMvMC9NRzk1WDBVb2c0Y1E2blZtZ0U0YXlaNGVRTHV6WkVYMlNW?=
 =?utf-8?B?VmpFdTlzMzhEaWNPYlVmUzF5NGYrdVVxUURxOXZVR3ZlNllLd0k5eUFqK080?=
 =?utf-8?B?NFRaaFlCVjI3YnFNWE9GQkNOa0F4NzBjU0xib0lXRzZ5WjVqbDYrSGo4TzNK?=
 =?utf-8?B?dWtZeVhLaERocDVNUWY0MFEvaTRReW5SM2k2K0oybE9ORkRBdHNrTnVOcEww?=
 =?utf-8?B?NFI0WnlNUGRCaXcyMU5pM0dqZDhMYm9xME5yQk41Z1NmL1BVZ2o3RFZybmpz?=
 =?utf-8?B?U2JFUWZkTko5MW5xT1pURHVEaEJ1MllPQThuTm11M09ReUszWVZnMTByMVBG?=
 =?utf-8?B?U0hiNGhVSUF2aGc5aG1kVXZkYU5iMUtRNEN3WGxKekF6N2ZZTWVvVFpnUE8y?=
 =?utf-8?B?NDk4N0E0Q2JsZ2hBNmIzTUJMQlA0SERWQjRONTMwRWxWZlpuMU9GRjZiaG9Q?=
 =?utf-8?B?RUpZU1ViN2J0cnBmY1RNeWVhNVMxUzVnT2dkRjVYQzgwNEg3T2w2b3BpNHlR?=
 =?utf-8?B?RDJuRWtreWtUOFFMNjlRWHhMaXdYaGIrTTM5eFJYZ2pDVTBITnBUdmZvRmUw?=
 =?utf-8?B?WTVzUGI3b2p2aFR6YUd6dklIT25USENDZGl5dExJM3N5Z2d6MDY2bnpZbXcw?=
 =?utf-8?B?dDhiVm45Y0hrang2bERzdkhiL1JsSHJ4MnhNNGVMUkY3QUpucEhoanZhdi9y?=
 =?utf-8?B?L09hdjErckdabjhTYnZCTEFhdy81U2k2UUczRWtCcUQzZFJuemFaYXNOTHJT?=
 =?utf-8?B?VXpFMGdyVDRyVThwc2hVNnc2NWV4dFlBdEFNTkVZN0ROT011Uk1wM2xTcnBG?=
 =?utf-8?B?ck5HUHNYazQvRVh2QUZkY3hQU0UrcmptS1lmVGxta3BxbHZqUGY1cjNNazNB?=
 =?utf-8?B?OEZpSUllTnZ3M1ZVdzBzczlzbEJHR2crOU95TzRIZ1FoRG5haEhXWWZNdG0r?=
 =?utf-8?B?SzdoTlNnR1ZPQ2ZHRnI4U3lMQ0lXbUZtdkYwbG1rQWdJYndoY0dtVFBJMFV1?=
 =?utf-8?B?TmxuQUV0L3NBSkVaSDZ6ZERJY3d4OFFEdm4xaW5EaHRSK3pXUVR3VUN5QXJW?=
 =?utf-8?B?SjhmcWdKTWI5c2lsMklLa0ljSzhWNmpSV1hwUC9uWVZXYmh5SU9kRG5vVFZp?=
 =?utf-8?B?NW1Tams1c2EwNm5jeG44U0UwbXIwcUo2TzFiZEdDa1hHTmMyQ3Bqd1RkQzM5?=
 =?utf-8?B?Tnh0dTFqZCtuc1BMNnRVYWhTYkFZOVdhclZpTFJGZFZTRTR5ZlZIMHFSUG80?=
 =?utf-8?B?WFdua0crSW5qTWlSc1gyQXRDYURsS2d5TVA3ZjcyQlVmTXZiZFI3TklOelpP?=
 =?utf-8?B?NGJUWUFtdW9JS2dmUFJITHd2cmR6RFdaZCtUc3RNckZWTHhwZVQ3WE5EeEZU?=
 =?utf-8?B?NFVLNnhJb3RucXJHaHFZL3RoNkU1VzArOFAyNjNJQzVQYWdMbEV4blA1Vmwy?=
 =?utf-8?B?WE4vbGVZWkJBSkhlZGtYMStDVTEyOVpaM3cwOXUyOVFMN2hpVUJzQmgvc09M?=
 =?utf-8?B?SERua25CN3loM1VWdHh0aWd2NFAwMjdEbE1rMHA3ZVdsUnJSVUltTUhLb0dH?=
 =?utf-8?B?bHZIM3F4RzhodG4wYTFkRVRTaHVyUzBOQTRnbGkvUXgrT0R6Z21mVHY5dVhB?=
 =?utf-8?Q?BgW1Bd4rbOL5GiUwdXIJrUaSZNrJySCD9vXLc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bXczZ1dlZlZKYnByZzlMODRQMkRqWXkxOUxqOVIza3c4dmdxbGw3WHRldjYx?=
 =?utf-8?B?RUZ3T25JSUlYYzA5bGhzL2JianpYL25kcTcyWWRYV3pzSC9lWVg3d2ZvNU01?=
 =?utf-8?B?VUZYZXpEZGxheUJteDljN3RUNEtKNktrL3JGWWV2ay9zck5wTVJheTQxZEJz?=
 =?utf-8?B?YjNqVzlYdlE2VjgwMEdGOFlRY3VOeXVEbmUwd1g1dWdLWW1nRUlxZHNmVFoy?=
 =?utf-8?B?Q3dXbnhhUWx5c09pdmlqbngwTFB0MFJUM1FXSVhORk1adnY1a095UVFxRDBF?=
 =?utf-8?B?a0taYkRzbm1GZ3V1MjVlNTJjeVYzSHVNaTN6RFhiSFB2QnNWTEt2cnBOVExH?=
 =?utf-8?B?WmtTZC9LWFJDRURQMHJEeHJMUzk2MFJ2SG1rMU41QlQ3STRVbnViTVBYRmtW?=
 =?utf-8?B?YXRtbkJYQ3Ywd1Zub0pSTW5Ydjg1QlRjdVdqYkYwNXQ2RlFFOUxNdVk0YWZh?=
 =?utf-8?B?QlJkQmZGKytPamJ5ZE9sMG92R3UzRFZCTjNXWVdsL3ErYy9lbFh0azExYVRu?=
 =?utf-8?B?QVRPZEhESS81TGtJbmIyYks5TlkrcVVjL0VjOUZjNWY2Y3FBTEFFQWxQdDNF?=
 =?utf-8?B?QjBOcWFYSy8vaHNNUVNNR1lsSHV6OHBjbmZtcVJWYTlFYlBxb0p4KzVlTE01?=
 =?utf-8?B?Sk9KN1VsQVkxRkVoN1J0VWwvME1jeFhwcWJWNGpiTzZXV0FlU1dDMm1tUnVt?=
 =?utf-8?B?L2dsaGMyOUg3OGdPZXNKRVJ6eXZwZUoraUFDNlJsQ1VLK01iRnVqU1Fyamts?=
 =?utf-8?B?WGlqb2ZobTkxelJaRmt6QkUxOHYwRGVJZ1N1ZUxPSEgzdUNUcVdOMW9oVU1w?=
 =?utf-8?B?NTROMk1XNUE0cWNrQU54MVQ4d3FDNlFKQ3NSdkF6WFhYRmNTTHQ1Ylp6ZWVi?=
 =?utf-8?B?S0ZZaHllQWEzZThQSzlWUWJMMis2bFNzOHRQK3MzamNDc3hHL3pERGNBVjhn?=
 =?utf-8?B?NDJiVEJqK01GQlZ1VXAybzdKSDRsYVljSExqQXVjd0d0bXp0dHpnakFFQnlr?=
 =?utf-8?B?TmliZlUyclowRFVXY2VoeW15dFdkcHkrdGNtTStXK3hObHdVaVV3STdseEky?=
 =?utf-8?B?RXVveGcvZEg3WmZxQ01NZjVoVDd2bWhRVGYxMW1MZ1NrOGhYekl6UFUzdjNO?=
 =?utf-8?B?Y3h6b1p5WG9TOTczNXJ5R1krQ0FGQ3FKZlBHUFVMMXZzdkVKbmphSTNwUk1l?=
 =?utf-8?B?aWFPbnVQd2Z5VWlRa1JUZ21STjFVZlpjdE1TTWVVV0Fac29ncXUxOEVvQ05R?=
 =?utf-8?B?QlR5aFQ2d21PbU9nd295Y0NnN1RlMUNpVlJSdEZ0eFJ6RFd2NXFnVFVrNmpK?=
 =?utf-8?B?dDhzWXBMYk03YkRDd25FVENUN0VJZUk1dlBkY3owdVFNaWMyTzJ2bTdpWUU1?=
 =?utf-8?B?WE5xODZtNWRMbUdkOHFkUkhuWWdZYmhFWjdiOC9EY2tjU3gxay9PSGNPRWpK?=
 =?utf-8?B?cWFhSWNNL0w4VzFqdlBDa1hiSFRvSW5OelBKQ3RyMDVSYUE0RUdzd05Yendq?=
 =?utf-8?B?c1ByTEl5UmRSSlhaVXdLWCt6aTdxM1UzNXZnWGxFczc2eFdabTZYYXpqOURT?=
 =?utf-8?B?UGppQWdHV0NSSktodkRCWnpqdGFBNVlTRGZqVW4vUllRV0Y2Z1VtRlhLZEpN?=
 =?utf-8?B?T3BESTlSY0drNTVLT0Ntb0ZXeUpjV2RreDdUb2JYeUpIbDNlb3dHUW5ialJL?=
 =?utf-8?B?RlZRWHJVWlBkb08waVlSbTYxOGJLL001M0tnQmkzNlJNS0tHbWE1clZjdlBK?=
 =?utf-8?B?N2JiWTJ2cnNOZUh5dzdPamIxL25jdGxieUR4ZXZMc0gyay9CLzY4NmsrWERq?=
 =?utf-8?B?azJwUTJML3MzK1FkZXVJV2hNZzdZcWozVnFNMlVxUW80VmpaUDBZY1ZMTHl5?=
 =?utf-8?B?bGtoVmV6VFZQelRkbGlPeFJxUlRkV2JkdU9jRE5VRFptd3Z3aEpGTG9Ha2VX?=
 =?utf-8?B?WTQxOURscFBBOTZIZXZranBCOVZmVlYvbm9iaGY3QkQ3eEorZHhrd3FQYlhC?=
 =?utf-8?B?WEJCTENYVjhCSHUzOGpnYkVnTjFQSFBVN09QRS9lNVcrc2UvbHNRWUhRUVFX?=
 =?utf-8?B?NlZhMG9qU3Yvbi9Ha3p2RHhpYWpzamhzenJKTE5TZzlTSHRFVVEveEZ3NjRR?=
 =?utf-8?B?QVNLUnNWRXFCOXNIcFM2MzIxdFozUFZjM0NaR0ZRZEhYdkdzOCs1b3BuMmZS?=
 =?utf-8?B?OVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7512A9F9C6B70340A2E5C788F5ACE1DE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X6ea6kT+w4jsysPERHaGd72O1F++g/8nS3lyd74kNRkU907WC4YLsDQZvfPX6sYNaz1JLLZ27cWXVLIc7Le+YPXw8+fIHqF6neT5yUyzF1Y0E48kNsgnVDFi9ApPmiK//Mbaj9qJ/3iQC45CCzIxR+te+BU8v+sqyLQcx/uiYH9xOBGF3+pJu9NJR1w5EXwdo/+yYeXWf8mt7x1nfibUU/xHg/17LuNDVPoJp+KLUDmtwf9pGDe6aEbfdTYhuHQOxSLEm3fxNzhbZVT/sn+k4ZlpjRg2uAzTwBNnV2RRFgSk+6LjSvTI+7H7Rohf+xjlqd01YE4qk77YDbMPy+Kl7u1ttI27ruaFiWREyaj5EMgcLc3YrPVW+6lFEob4mCHEvGRCN42GS5eMBEMds8QeLVt83ZD/n2oTeFntwwB1IfxbQ7YxfcAQXKSr9bih0cxVP+uWwQLsEn7WwLUUwsAExKIDEdJ2N6R2lzXvmDfVtfRJStdY7h31xaqd1C/YklVAnlp8zCqOl0t2dahMMZ65cLwPx5WyM1PD+X9RI6QIPFQzTzGFjEFP4MwahfjDpTr1pZ4UcKbiODaRQIu1JqzK7MquuAIAbRsLOonaezQ9JyC5L3KmgUS8mpHVLx9NdxeO
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b116d1d7-027e-49aa-3388-08dcf8ef47c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 14:29:36.4090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U6/EkvZjB84hNwMESEjXyqCGrh67jtrnAq2VSXRoPFO2OTfmvkp/j0sxxt5wp7+fVyh95v9F9mqqRuPi+GkbeeMHL2ERLnVCdy5KmPtfXxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8114

T24gMzAuMTAuMjQgMTU6MjEsIEpvaG4gR2Fycnkgd3JvdGU6DQo+IE9uIDMwLzEwLzIwMjQgMTQ6
MDYsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4+Pj4+IHJldCBAQCAgICAgZ290IGxvbmcg
QEANCj4+IFllcCB0aGF0IGRlZmluaXRpdmVseSBuZWVkcyB0byBiZToNCj4+DQo+PiBkaWZmIC0t
Z2l0IGEvZnMvYnRyZnMvYmlvLmMgYi9mcy9idHJmcy9iaW8uYw0KPj4gaW5kZXggOTZjYWNkNWMw
M2E1Li44NDdhZjI4ZWNmZjkgMTAwNjQ0DQo+PiAtLS0gYS9mcy9idHJmcy9iaW8uYw0KPj4gKysr
IGIvZnMvYnRyZnMvYmlvLmMNCj4+IEBAIC02OTEsNyArNjkxLDcgQEAgc3RhdGljIGJvb2wgYnRy
ZnNfc3VibWl0X2NodW5rKHN0cnVjdCBidHJmc19iaW8NCj4+ICpiYmlvLCBpbnQgbWlycm9yX251
bSkNCj4+ICAgICAgICAgICAgaWYgKG1hcF9sZW5ndGggPCBsZW5ndGgpIHsNCj4+ICAgICAgICAg
ICAgICAgICAgICBiYmlvID0gYnRyZnNfc3BsaXRfYmlvKGZzX2luZm8sIGJiaW8sIG1hcF9sZW5n
dGgpOw0KPj4gICAgICAgICAgICAgICAgICAgIGlmIChJU19FUlIoYmJpbykpIHsNCj4+IC0gICAg
ICAgICAgICAgICAgICAgICAgIHJldCA9IFBUUl9FUlIoYmJpbyk7DQo+PiArICAgICAgICAgICAg
ICAgICAgICAgICByZXQgPSBlcnJub190b19ibGtfc3RhdHVzKFBUUl9FUlIoYmJpbykpOw0KPj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgZ290byBmYWlsOw0KPj4gICAgICAgICAgICAgICAg
ICAgIH0NCj4+ICAgICAgICAgICAgICAgICAgICBiaW8gPSAmYmJpby0+YmlvOw0KPj4NCj4+IENh
biB5b3UgZm9sZCB0aGF0IGluIEpvaG4gb3IgZG8geW91IHdhbnQgbWUgdG8gc2VuZCBhIG5ldyB2
ZXJzaW9uPw0KPiANCj4gU3VyZSwgbm8gcHJvYmxlbS4NCj4gDQo+IEJ1dCBJIHdvdWxkIGhhdmUg
c3VnZ2VzdGVkIHRvIG5vdCB1c2UgdmFyaWFibGUgbmFtZSAicmV0IiBmb3IgaG9sZGluZyBhDQo+
IGJsa19zdGF0dXNfdCBpbiBvcmlnaW5hbCBjb2RlLCBlc3BlY2lhbGx5IHdoZW4gaXQgaXMgbWl4
ZWQgd2l0aA0KPiBQVFJfRVJSKCkgdXNhZ2UgLi4uDQoNClllYWggYnV0IHRoZSBvcmlnaW5hbCBj
b2RlIGlzIHVzaW5nICJibGtfc3RhdHVzX3QgcmV0Iiwgb3RoZXJ3aXNlIGl0IA0Kd291bGQgYmUg
c3RoLiBsaWtlOg0KDQplcnJvciA9IFBUUl9FUlIoYmJpbyk7DQpyZXQgPSBlcnJub190b19ibGtf
c3RhdHVzKGVycm9yKTsNCmdvdG8gZmFpbDsNCg0KWy4uLl0NCg0KZmFpbDoNCmJ0cmZzX2Jpb19l
bmRfaW8oYmJpbywgcmV0KTsNCg0KT3IgY2hhbmdpbmcgdGhlIG9yaWdpbmFsIGNvZGUsIHdoaWNo
IHdlIGNvdWxkIGRvIGJ1dCB0aGVyZSdzIHdheSBtb3JlIA0KdXJnZW50IHByb2JsZW1zIDopDQo=

