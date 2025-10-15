Return-Path: <linux-btrfs+bounces-17827-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA75BDD8B6
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 10:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAA661883CAD
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 08:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057E631770E;
	Wed, 15 Oct 2025 08:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="d99Er8FR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lwhsevos"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8953168FD
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 08:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518444; cv=fail; b=rPERQzC7rVr/68VN0bmx2Ml2ArO7v6R0JwyjHO09BBZxYO4qaWKpHl0OXWGqZjnh3rMEj9tIF9ULmPTA2+XIe5yR6SeF1MZ52GGte+7wJ1VxfR6Ia2WfftE7AXz7yfkowBwEOoJic7VXdXixv4z+MzhLCWvy7wJ4sXOGUxUSNcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518444; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lGjtf1lwsqmW04wSJMPGOB9HX2NdmQVWQgVPRe9xBEPIMSdR2dFgvfRAsOdHotE1iYtu6b1TrvTg29dry8Dl5XHsEpAt32Ysv3uhOTaQcZX5E0XjSXC5dOVtUm1l82p3x1GuyWRU+N71m0qt3lxqkf9WJr0hIbIpsZCogNLMIu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=d99Er8FR; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=lwhsevos; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760518442; x=1792054442;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=d99Er8FR2QRW492PvsBNMf8hJhXlzyFR/oWj9iNyFniWvR/xjTKILX7G
   yUMzBI+H6QNaUXIMPJ6PSVh4d9/HrNRxzo48DTu0ZZRHpFTrQnM+y5hPj
   2bZ829f3p2Go2jcv46A/HyZasa5DDTi3/vn62Yq7ix6Wr8P85nRsPmD0+
   PA8y4fX4jQ/nIFO4M7qICQuvt8A1xCLjj28eaDvBTIfL1E7HcbtJDkHuP
   kAeHQODOuFake0zS/8jUGQEqqjPo/y5EBKyVQlI3y1UeMa0NB6oW1ffQe
   MWW2Pg/ELcVnJGnn0Gor3zZYTBjN4YqfaU48v1J8K6l3CB54IDwPmKjJf
   Q==;
X-CSE-ConnectionGUID: YCq1NAAbQraLw73Fwu3osA==
X-CSE-MsgGUID: 9akEj+wKS0SCoJRGUOS+Iw==
X-IronPort-AV: E=Sophos;i="6.19,230,1754928000"; 
   d="scan'208";a="132930426"
Received: from mail-westus3azon11010054.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.54])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2025 16:54:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xzz34tj1aOBva2O53SnaGmDdLg4HV/CWF5YXWjarzqtggayrhxj4pHzCPugNSN6YRKbzA8hLUtvqmtUlSGG8kRf32j34G1AjpgIlJhS+bV9z2fajEZ/uwkNCjxe1uLxllbywtkoCN06geAMQ20vvWgklpEcOS+pGcRptAGxcOZucPVwcL7t2MwQRRsrhuW2AlxY6le9t07tQyFAavFQ/xz606r2RHcPK4sPmGT14z7M+U7ka+dkMpVpYTfpjrqasg+HgVMx3Ys0tI8up6ahMadecJlRZvMBpFpoY6pA3ElGnLinAkeL8mUnBIWJoMjH8w8h/1w8gKUqIjjCE6VHE2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=cAiG8AsBZgQDiN72Pv9PPSyPLQ8RIyAQFicYDWsQVjej4Sv/NO/PpOeZ3OPHCRCJ7QujR6Vu4aC5s5cGxMX319RuWIs/r97H5kfeZCqwsi2pP14U7fV6P321KxmMir05iGe6kOjHebkDa12JE61HsFvi3FYSEPgdjppcJcFGsex4YjDFMt8HQcPS6/QHWpQJuj7+e6cWXJEOVpSJZY8fUEwDbcXXF2T9JO9oWNW+37SNCSMKNxyYQDwn5gn+1YM4mge1tdnHFaq5ZaUXe7dMZ41xWO0KpWcW5b7uZ1t0c2LJP4bVUzgfuoClheLHqyI571XvSoa1AiDDLMiy6DKngQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=lwhsevosxGLc9TXpXuXfe6YQKlqCOjBpXlapwwTChInYK/bAmBY+L3TUI3LUWq7sqCj28WbxZaDbpcv/SyY5oUHl9dmugAFhyCmcrrZ3csjtvDx76LwGMLzZ8EofFSBhX9XIeWmQYiJYrO/e8m/LEnP8/K6bbsPbTxBDrCw5QF0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA3PR04MB8953.namprd04.prod.outlook.com (2603:10b6:806:397::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 08:53:59 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 08:53:59 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: remove fs_info argument from
 btrfs_sysfs_add_space_info_type()
Thread-Topic: [PATCH] btrfs: remove fs_info argument from
 btrfs_sysfs_add_space_info_type()
Thread-Index: AQHcPThJyhbvkt/fp0qWJYsQ8uzXFrTC6A2A
Date: Wed, 15 Oct 2025 08:53:59 +0000
Message-ID: <84a51744-5afc-4aa1-aeb8-e60e312f32bb@wdc.com>
References:
 <72ec649f946ae942b018b9f8b6c095a3ec722620.1760466450.git.fdmanana@suse.com>
In-Reply-To:
 <72ec649f946ae942b018b9f8b6c095a3ec722620.1760466450.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA3PR04MB8953:EE_
x-ms-office365-filtering-correlation-id: 9b49f778-d38c-4a74-5f1c-08de0bc861ca
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?M01SM04rbWhqb0tzQkJENnpzN3FkSXFyL3YzNWIvWUt0NlZtWE9RUXNoNUZq?=
 =?utf-8?B?YlY5MTk1YVNTMW5iWHlyL2tuK1F5b2pMbDN2Mk14WThrd0kxVXN3U0tzcllD?=
 =?utf-8?B?R1dZR3Z5cXlkeGVXbUZabHl5NlNteWhObDJXKzdWS1lmMjB4ZjZvMUxpY2JS?=
 =?utf-8?B?YldSMUpPRG16ZUlZTFRzL21HMElTRUg5UU1MTzJET1Vma3dwT0R2Uk1jWGI1?=
 =?utf-8?B?U2NsNU0xUWZ5QjI0OFpqSWdCQWY1KzNIQ0FVQ1pHeCtjeUorSG0rd1d3aC96?=
 =?utf-8?B?QlZsTHFMVG9zZGt0ZVRremRweEJOUTVpbFZLVFBmMW1jTDhpeEd1amxBbWJ3?=
 =?utf-8?B?Zm5MaXc2cEV6aTFsWXZPeE51R3VRYmNBRzdSQS9kNXEzemcyWE90bFFCWUtB?=
 =?utf-8?B?eEw2TXRVSlQzMzlLWFRid3NKdTJ4dnpOenRmRjBuRWJmdTRtcWk1SklRa0xS?=
 =?utf-8?B?VUFQSHozZS90UkljUjY3aDJwd0dmM3JYc0NDWnN5eGs5SU1BdmQwdUxqSEVh?=
 =?utf-8?B?UFVhTkxkK3dyRXhDM3ZJTm44UmQxZU9iS01YL0MzTXBrcmREUG9heDR2b0ZO?=
 =?utf-8?B?NUhFUTRVbW9pOTk3cUVYdnJib2U5MDNyUEVYZXhhWDlZbnZXd1hKYTMySVM2?=
 =?utf-8?B?YTdHUWw0TmowZk1PRkhjREFuVUpzS0JDS01QeFFDZ1R5UzNBVnpWSmJodTNR?=
 =?utf-8?B?THoxTXhaUmZ5VEg3dnROdm5rQng0M3oyWmNCVnpvY29TdGV3MzkxZ1RCNms0?=
 =?utf-8?B?WC9ReDgyUFc1WW9mMkQyRHZMVS9hY2xRN3J3dFJ0WDRBNkdtNEwxcFlhMTIy?=
 =?utf-8?B?RWxhbFdXVncweU1oQlpjWXRRL0VsbTVkN2pPK0o3L01nUTZtUERQeUFlZ1pP?=
 =?utf-8?B?TFhqMVlEbmVKdjhNTUVVTHhsWVQxVGhYTEROV0M1d3Jtek1Sb0wwaGNzb01S?=
 =?utf-8?B?STlCVkRwZDdWL2NRZ0NZdDR5OWFzcmZiVWJ5QlBzY2YyYTN1bDM0UGtuK0lp?=
 =?utf-8?B?TitZdVI4U1N5ZGpDUVlTSjJTdDAvcml4REhkUG5NUHdHR00zT09Ua2N4cVhU?=
 =?utf-8?B?RUtxVG5Ec1dmekVhakYrQlNCd1owdUQ3dXpVVWI4YVNjZ3MzV2xqcUdSN0VW?=
 =?utf-8?B?WElHZWhhKzA4bngxaGNNNnNPaU1Va1FlazRhL0VNQndvZk1FZzZCZjhNN2dE?=
 =?utf-8?B?Mk85VkFwaUJWcnNFS3lpUTFVM2Z4d2poNm5LUStZZXRZWDJEbjY5VVFpTkp0?=
 =?utf-8?B?VWtNZFlRVDR2REJQYmMzSFZ6cy9jYlRNdFFQK0dLM3R4ZTdVaTc3UzAyb1hl?=
 =?utf-8?B?Z29SMCtRQjJhOTdPaDN6aUdJSXZuWnRwNXNEOEsrNUdac216Q2NmUTBTZ0FY?=
 =?utf-8?B?U3JsVkFxakVBYW82YitKakNzdi93WlpTblIyL05oYy90UnVNSHBBK1RiRzha?=
 =?utf-8?B?aWtPUEx4U0tEY3dUZTZYY1RjOUVXRVA0ODdsSG5pMGpnQ0svUm1Tb3FIYnhR?=
 =?utf-8?B?dis1dmdlYWZOejloK0JUZ2NDYnN1bDBHYzMvY2YyR202aFMwNnFWYjl1UjlQ?=
 =?utf-8?B?SFJFaCtBcjl1c00rVzMycUFtbkFvUFFyeWZUdkhuM0Q4SUtta05DcUhWYnFZ?=
 =?utf-8?B?amFtYVZ5NFVtci9DOW5IWVdOeVZzMXIwYjB0QlNCWmR3cy8wajBsbHdUcVFr?=
 =?utf-8?B?bWNya3psclo3cFF0Wnhjemk1QktmeHYyNU1hdlFXNlZnS2QwTWNQYWpsenh1?=
 =?utf-8?B?OGF3aGgxZGtKREJMMmhwWG1JUnRwQTc2T3BHN0RIZHhzaDdnWFhuVFljY3JH?=
 =?utf-8?B?RWg0RkJ5TnNEekRBanZMaVhMaGQvd0J2ZldwbkIyYUJkdzVxdGIwZGhoMXlF?=
 =?utf-8?B?UkNEenNjVmpYejFKbmFzM0c4a2tOM1ljbUR0VUtuNTMrQ3g3Mng2RnpsNzFP?=
 =?utf-8?B?M1hheVZTekZWSm1XRUZHa3NXb1hrVTZEQW5yS3Rkcm56djNpSWRkQjdacE5P?=
 =?utf-8?B?dE5tdXlDSUh4V0w0aHp6ZWpVY0lpa0IwbnRJVlpWZHVaM2UvTkxvTUM1eUFp?=
 =?utf-8?Q?nyV2kz?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aW5oeEl4K1k1VERjcjBLb1Zqb200dFlwL3NhQWtVMEF5T29ZY3BnZkR1eTNz?=
 =?utf-8?B?d2ZrdTY2M2JCbVRUbHRFU3psQmFlRjJUK3VWMU9ERjJmRXppSm1wYmE3bUlR?=
 =?utf-8?B?UTFqTVp6dnVMbnFQTlp5OTVpK1FBVWorcUdzMEM0eG80RmZaSnVzT0cvWStz?=
 =?utf-8?B?ckFtVElTSEhvN1QvN3d1NUFTVjNod0syOEc2NVlhVUZOTmJiVmY5MG56MldP?=
 =?utf-8?B?MGxLUDdlaDZsUHFvSnIzWkkycXdIcEVWRGpXaytiR2JIUXlzWkNGUVErZ0Mx?=
 =?utf-8?B?TXJRWS92c0lVRDljNmQzQ0tOMk5qclZWbUVMZ25qVjdrczI1YW1qS0J0UG5N?=
 =?utf-8?B?Q3hPY1dJcDVQWDFtSy9SQmRBNTJlOTNQMTh5cmlZU3pLbzdNMkZXWnVCM0Ur?=
 =?utf-8?B?aTlYaGZSMVJpeE45S2NOM2NubWc2d2hNekc1M01rZ1gvSTdzaldLbjlZVWNv?=
 =?utf-8?B?WC8xOUZ0Z2M0S3k2Yk5PU083ak1ESUhHSHdqTVNxeHVCb3Ric1JZZnJXNlR4?=
 =?utf-8?B?ellxYTNYUGoxV3VaeHNYc3drV2JEY1czRUJuYVFFTmFDL25MRmY5NTdOVmFC?=
 =?utf-8?B?VGd5ODgxTFJHYXRKMS9seGxWK3ViUmxjdmpmeTJjRk5xVkR4ZitaOG9oOHVu?=
 =?utf-8?B?UDcrUzA5MEdKaWdzVnkwYkhaOGpyVmxWbUl5d3liVGp0QVZHVU40N1c5RzhV?=
 =?utf-8?B?LzR0WkphRHdkWWQxc2VwemQrS2xHSjYxZVlrMEN2OUdCejZQYmNhTTYvbGJu?=
 =?utf-8?B?REg4MlJhT3ArVUc3ODBNd0JLMnZUUWdwWURxYnFieHlRbmlMcnB4anRLNTZK?=
 =?utf-8?B?L3A4WU1EdGRyOUtDdW5jalNFK05CenoycjA4M2d0WVI4L0F0ejhZM3V2c1Ay?=
 =?utf-8?B?bklkNTBFNVdEM0dsU0l2enNrKy9LK1VVV1lYR3R4SDJSOHJUZk5QWDJqWnRt?=
 =?utf-8?B?ai9icDBaYXhRTUN2Qktqa3hFbGt3aUZhQ1FOWXczbWVsdTliNXpMZDBNclAz?=
 =?utf-8?B?TnYvZS9MZm4vQnkyVWZvcHRIbUhXaHdUa0QxMTc2RFZPQVZHN0NWTWJpVElB?=
 =?utf-8?B?TTFGVVJONUdvRDFJZ0VvcFBJeFhQN21ha0JXZkdQb3prWGdBTVpMenRTQkxm?=
 =?utf-8?B?aEdKN25mdlFhcEJqc290MFRvN1F0emFVSkxJUmRyS3NaMHdKeTFieGR3Njcr?=
 =?utf-8?B?YkVRQmpzemhoWlBYNEp3NVpMam8rNHFsOE9keGl6dWF0YW5qWnNoWlRJZFI5?=
 =?utf-8?B?K1RQRUFQZG1zMEJLL1hqTEJpaCtzL2xVMkZXS0k5RUczMTgzRURINDNMK0tH?=
 =?utf-8?B?UEhLR0hqNDZqOUxWV0dWV3cxa1JRWnYrSEFiSys0ZDdhZkVOcEVROGVHNFV5?=
 =?utf-8?B?RUtHMUJUVVRxbGtvREEwSmNzczc3T3dLcVBiMk53ZFdxMVhubWZ4aU9GRmsy?=
 =?utf-8?B?S1ZlV0VDRTdidVI0KzlUWTFmYVpYY0dueWpUYkU0Mks5YkZnMzlBQndMT2xT?=
 =?utf-8?B?ZW0yN0lFWnRFbUo0WUdlQ05TUW9JajlYZnhFS0hqQkFtRDJSOFNJL1VzTFR5?=
 =?utf-8?B?a0Z1SFR0MDdQbXpiQ0ZyZm00bmxrMjFJRE80YVNscWVDUHpwNnhTaFRIQUZ0?=
 =?utf-8?B?Z0t5YXB5S1ViQmVsOUJPODdVTlN4RHJoeE8rRkVpaFROMzMvTERMMjF2dFow?=
 =?utf-8?B?TTFrZ3BMSGRuNmNTZjU3QWV0NVAxVHowL0R3eTZLTmJ0SG1INytwOENjemtH?=
 =?utf-8?B?Zno5YWo1NUlmdHVZQ3EzcTJsbUhtbE82TmJ3VVJqaFgyaEhkMmp4d3JMUVpW?=
 =?utf-8?B?Zm1taGFxOXFhT0wxYklKYjd1b0tvYk9va1ljaWdwSVpaMGlhNDQwTEMraFRm?=
 =?utf-8?B?S3U1V2dwUjZlNlphYlRTSDEyQzR0SUpuR1htZVNqZjJLQnBCRzlkcHdGRkhx?=
 =?utf-8?B?ZHlHdFlqZk8zZjUvMm1BQUJobHZXUEcvZzRORTl5OUF2b2pWVjkxaW1EZGMv?=
 =?utf-8?B?aGpkbk1HUUZvR2pJZldJS05sUFNkTUdZa3RCOWhVRUU2eVpDQmY3L29qMUxq?=
 =?utf-8?B?alJWb2NhdzNoNXVWdmF6SVd6UStMR3ViV0hQTGFqcjUxRlpKL0hQbHFUMjhr?=
 =?utf-8?B?Mjk2L3dWVkpndXdmTk1PN1lSY0dkeHlxM0hxUDBQSG5rLzl1cFVLLytKZjMx?=
 =?utf-8?B?NmU5dE1PcmZ5SGZEeEJOeEF2MGdwdzZXZVhNSlpTS2wrQnZKUEZWKzVSWlRw?=
 =?utf-8?B?R0E3TkdxTmtJejZhZVRaa1B1azF3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4310935CC400BC41BABAAF49722B62BD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TcymE30PkLKTwVD0X4A9iNqceaFRXzmJ4OGKmkDNvyu5n5bhRao4Rxa981gyO2Z/Ut/Pt/roow6y/nP2tESm7ElHkFEVZFZRJ5HW4ZhPYDsHppmWQ8rSew2pkEdN9Kw7ezAWRczlRurUicMSD3uoz4yaI9QdBXmdaD4l+Foa+znl826KLM1HCZGxyJ6GsyiyeBBKcKqzRzxAcNPhTyeXmF2IAlGb6Qu0oDUetZWLk/Hy/i7Ez+eQaUXCAvuCe1MF8ZI+lmitGXZdE0KkA+TdsoqXJdNW7jNWzBeAyFOOK55u12RCR9owQVwlSPRD1QrcTjZHfKztaHGwLP4uJdaQZBO9lPuogTL6N2t8jqRWSMCEE/tIA0kYnDmiUrnGQdbFyicsJa5ivyrszBywgIxtidA14Gj53mEUvtuomeULYQNKP+yzQspAAzn6bznVD84N530u8axSTTpD4B/6vpBDyWapxzonJOQ1aZWijyPVMiLs8frX5ehylzmRqS9kXjKMaau+EMl+coyPossPpAElO/46A7Tfhqd+HXCE4+0cB2BrC7OlGmfdnB2tAJMbNzI3p9HdyjNxd6590u+KH2j2WY1SWfkGrQrOFDPJeB7YXhS6UvUKta1g8cC2HfCHnq03
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b49f778-d38c-4a74-5f1c-08de0bc861ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 08:53:59.4710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u9LkmKBA/rrPvEgdokO/rq6ngXX+Xf/XExnVd56R8yTMhVL+0ZNaYq7zr2m05e+bLK+QaHP9YvBrUbqmYCGohARG4vXt5b/TgIlVs+DIVo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8953

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

