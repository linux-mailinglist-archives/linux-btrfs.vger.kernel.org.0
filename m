Return-Path: <linux-btrfs+bounces-16560-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B97D5B3DEED
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Sep 2025 11:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6582A1884A1F
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Sep 2025 09:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039EB3043C8;
	Mon,  1 Sep 2025 09:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="l6tou1LA";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tooHIjsN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC112FF177
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Sep 2025 09:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756719879; cv=fail; b=hqamRQJ5hlDRg4kXcLWQQ3rffdQmfQbC2GsQ7NyekxwR8LQqlymkU2wSsVAt0hGTr04Vv260h3lHpXJBOqCh0BkZoHTftBQ52r1WhtRsMb4a5fYwp9sGnErh+MIeAyrHYZusbNOAE0MNnGa1qBzYKh75uzVR6R4pBQRSCYDaTE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756719879; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c8jhkmZVhpAxq2Lroe0RfP88I+nlcnafQippEbiBGblWJeljAukE2ILGFA4s57/7hvZOi22kFdl7NpuRkANA10G6Mp57SPvpeDWtzLgfYl06nMmVSzCYl/V9W7sKRfis9t1ZJhR7U/qBcQU+ZBN+fo3Ye9uZMPMGN23WZohNmIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=l6tou1LA; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=tooHIjsN; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1756719878; x=1788255878;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=l6tou1LA8I0xR2oJTEPTY7CSnS7bu5/1SCjxH+uuI1ZPcvDgNJU/m3b4
   GbYhsEZUqPLM0ZQe3Dhgz5WTWpbx/hskpVNszjOqalCiDTCDhlrcmF8Sz
   7nhI0+2ezSvUbSUKfiLHVG8trUc9vRpaFD4tbMHwyRzleDaG3PY8TTCId
   P0J05VmficL2y8p7bQ/OjPSB0Cx7HtPZYizO7UjqIrjCZ2WrB7W7lE28Y
   zHsnJgs4UgUW22dMO4lh9vFwKksRU433YfEt5e4JrwDBrwL1oirC7rTT7
   82aNSk1EIJakosM+or6LDDMQ6Ju+T9anN55xqfJR1f99di+by12fKdElC
   Q==;
X-CSE-ConnectionGUID: oaKxvz2kRh6o/mw+o7ZOpg==
X-CSE-MsgGUID: I8bL+VerQjWP0FZhbCEhGA==
X-IronPort-AV: E=Sophos;i="6.18,225,1751212800"; 
   d="scan'208";a="107298123"
Received: from mail-dm6nam11on2089.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([40.107.223.89])
  by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2025 17:43:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SbDoZdtZMwAoGLH5WCNVYeKKqbyrsWDUcI+vWeqAvOYOTBSxw4/b6VOnQlWqAIhNxe6mcco3xM7TnyChTh+fAOKJyVTZ3CXfwRUxxKjDiO6bhm1Z7noOA5SrkQfEpNDjzKAkGupVRFghgsOJ++y7fRJlWSlK/5SDa1WN42zch/KA2Nrw6rOlNqTwtGKRPy3239m67qPoi4G42X5TYlCuVboBb8I1prOMRxbSbhL/id7nbfqXHnFKXzN57BS0no/vosEaL4dadubgrqXTL1oaOqou7CqJlElFBDNVBg5N79aWVWuP8qkMzNcjuobaBTfa1mWvJSSv3TOLrs9SXOdg5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Zy+imargyg9GT+glG3QNMxlYl1/Ltz7i0EYg8i8Or5qLl6fCXQIKx+1Mu5/ON7O0u2MARONR2SKKGYBYLM9m8g3gJvGBrF6dKIHKyCOX4GCBexEsQ3O5URAhlUQkDFxD6uUahTgOrCujpB51zSJNoKTvex0juOpnA6KNM0unCW60OviGtoqIUq6qEZWpdOaAKvBJ1oji+/z4fSl6zMaoA/fz4roSiN+PhvOfDOGRGwlLF/67o5C0W57Zj8+gktTpcYYxOcwFLWt9Ggbchjygb1L0xYiScO2Jy3sKE979CqZ/qipQzAqii2n/BAxKRmMV6svrmsL9G0s9a/StcfJEUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=tooHIjsNY2/Qb+km9gzhz2N4bdEWChEen5eZuoJdyod5GKKL/HqpnorVwQBw5A0BebM+Ba/QEE84ot7iK+nzpqKJjtQUcoH9PikcIdJaJIvvTLNSMRMBHhB0hMjBuTqeXOsvNW5rYCvk71/L/h6SwHODCr2All5rkmfqod7uH3A=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB8412.namprd04.prod.outlook.com (2603:10b6:303:143::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.26; Mon, 1 Sep
 2025 09:43:26 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 09:43:26 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: mkfs: recow strip tree as well
Thread-Topic: [PATCH] btrfs-progs: mkfs: recow strip tree as well
Thread-Index: AQHcGxN55soNZE3KP02NHGO563r9XrR+E5MA
Date: Mon, 1 Sep 2025 09:43:26 +0000
Message-ID: <4649f5f7-2068-4ad3-9d7c-324c15a209fc@wdc.com>
References: <20250901073826.2776351-1-naohiro.aota@wdc.com>
In-Reply-To: <20250901073826.2776351-1-naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB8412:EE_
x-ms-office365-filtering-correlation-id: d472fb75-9e9a-437b-6a1e-08dde93c0012
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|19092799006|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WGlHa2h1U1pDN2M3ams1ZFA5Zm1oQVJ0VEh2anlaaC9RTW1NcEJBdWNNNGRn?=
 =?utf-8?B?eTJPQ1FQS2hsVFZLdWVraGd6TTAvY3kxcGdGampFejk2ZEhvenpNbThNc3R1?=
 =?utf-8?B?djhpeVduSHVRbDhmVnFyMEJBdmJjN0Q0OTNNa0NLMHpGV0xrNm56MWFZNzFn?=
 =?utf-8?B?UGJpdFd6NFh4OUwxR3dKWW0yNXpmdkNpMEQvYTluZmtlOXdUWnA2VDNkUG4r?=
 =?utf-8?B?bS9nNGN1aDVoYnhDaU1KZ1JTRmpzUmNHbEdWeFlqcEw3MENjanpQaEtlVEls?=
 =?utf-8?B?Vm1sNWdJaHhMY3EvbS8xRFJ5K2ZLVGlrOTF5VzA5VkVHSUh3T2NUZDNZZjdi?=
 =?utf-8?B?ZmJXVFRIY0VCaG0wak83RGFxb3grejkwVVdmWVBrWUZhQnRmSjYySVUwZzZu?=
 =?utf-8?B?N1FNOHY3WEd0R1M2a1BqeEk0TVdzeWFOS1Fodzc3dkh0M1A0bFBwTUUrR0RR?=
 =?utf-8?B?QnhkMUZjbzdmZ3l3VW1lSHZjUUZFcFczWTVJUmxnd282NU9kOWZuWkN2ZmtK?=
 =?utf-8?B?RjdQV0FYdHZ5WXZMUzg4ZVR0dWpxa2pyOGJsV1IzSWVzbStsVGRyM2V2RmFs?=
 =?utf-8?B?RVhkQUJ3cU5iR00yWS81WmRiZFFRcDVwV1JVU3VUVzF1OEtEUVV5VlVuOEZN?=
 =?utf-8?B?S2V6WVpiU2twZWxlRmlOSDUvNk1jVmZOOTNkZEhDbXRpOEhHZjh1WGhRN3Na?=
 =?utf-8?B?V1JucnM1ajFTdG12RkFuVk9mWE1VZ2svQWR0N1dVVUo0Zy9HRmpXMllUb3JB?=
 =?utf-8?B?UEpxazJudFBXTmZVU3VZK1dJeWRObnNtY09YdkFRQW0vQ0pJUjlmYmRMWDA5?=
 =?utf-8?B?YW1CU0dxblhoZFkxaG95VHFYWDRoNXRMQ2cvK2FUL1hodnBFdjUxWnRNa2lt?=
 =?utf-8?B?VCswRkJ5NmpEOE9naUtZQUx5OGJjMXJJVUg2ZXQ4V1E3YUV1YWo2TG5WOVdu?=
 =?utf-8?B?T1QrWGNTdGdrUnE5ODRiRk1jL2N3dmZBT0tjRVl2Um5rSmx2QWY0bjVFTlRs?=
 =?utf-8?B?UHQ0UVFVQmJUMGphOHQ1TlJMSllBUnBCQmhObTF4Q1YzV0xOSVJxWk5ocDZI?=
 =?utf-8?B?aHIvaUIzbHJtMTBxcXdKSDNIQkRtTDZtWG16M2E2NnB3ZWoyR2wxY3BCMURB?=
 =?utf-8?B?QkgzVUtLeVRQeHprZ1BYd2Jpd0lTdFRZWC85M2FpK3FNQkdDa0ttUW4zUVpR?=
 =?utf-8?B?V2VMd3RWdVpSa2owcUtWTVAxaExWL3ZCaFZMZWc5L04xVXp0cUlPcUFKYWJW?=
 =?utf-8?B?Rm9rNUd0RG5JNm04aUJlZDBjaHdpbjVWczNlUzVoenVKbEg3S2pUM01STXBD?=
 =?utf-8?B?YjhXMzMyb1JkbUgxQk83a3dpUnVuL0JTL1Y1RVFnc0NacGtHUjNiS3lNbVpZ?=
 =?utf-8?B?azRzZDhWV25aTG14dmtBVTVaTVRSZFZJelltbU85V1hyaUUwa0tmajJmaThm?=
 =?utf-8?B?ekNNWG5ReG1GY3NrZEducFgxWURaTTVTTGNEZTlXQkJwRFlaRUM1Mk5qdnVI?=
 =?utf-8?B?NG1PeFJYWEFzdk5kd0VOQkVXOHA1aVo3UFdSVGZSMncxRU1leUErdEVQMnZh?=
 =?utf-8?B?QVNtV3R2WG5hd2VIanpEeEg1TGo5dVowcnhKSFR1VkRwWDY2SUR3Q1JOZ2xi?=
 =?utf-8?B?aTZ5TmsrMlV1UVQvVi9MS0NiTi83N0ZiaVpybWFibkN4RGRmblZNenk1ajdI?=
 =?utf-8?B?MEF5ZnYzeGIydGY0UHBXNzZaTWpqVkRTSnQ1aThjVGlCRld0MkNZRUowYjJs?=
 =?utf-8?B?S0twdzFKZjVxT0ZFU0hlMEJ0N0pLLzA5L3orVngzSGZvQ3BCb1lSaWdTcXNO?=
 =?utf-8?B?WGxnMzBWVmU5MTRPMmo0VWVkNXgxV1JTaWJHZjcvcmZ4N1pkN0FZbjVHQlp3?=
 =?utf-8?B?eXpPcnVtYmJrQW5Nbmc1bklmaHFCZWROYkZzdkVUZ1F4UWpZQnBRRkF0RWt4?=
 =?utf-8?B?WDdaN1pJL1hvMC9TWkVmSUZXMExCY2JRNGprZlVpUEdrYndzMmZKOENwNHZR?=
 =?utf-8?Q?AXa5Z9e2VmI7+HIHKvzjBCHpN2el5k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(19092799006)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZGpJck1ZejJxQ2hZUm9LcVlxT0lkd0FIZkpPMCtCMFppRHBPTENYZVBNWFhC?=
 =?utf-8?B?ZXNEenllbHJ5OU83aVE1TGNReC85UXFhRHhUZ3RmdUVpNUYxUW5ORHY0NnVZ?=
 =?utf-8?B?UGliSW81MmVGbUk5eWpqZ3VMV1RVZFJwa0x2WVlLaEZ0aFlJdnQvWGhaWTYr?=
 =?utf-8?B?N1o1MlVDR1dZNXJsdmFQVUdjNjdXdGlKcFB3ajYwMTRuNk1ZSlI4czBPOWpu?=
 =?utf-8?B?VlhERVc0eTNFUEduMkxmcWRnZm51N0JVVGpuUjlFaXdBSEpEWXgvUmtiMWxD?=
 =?utf-8?B?RS9lN1oySTVtTURzRVhWZUlPNUozbWgvNDR2Ny82VTZHQ1U3dFYvd2V2RXdK?=
 =?utf-8?B?MGhpL0hmay9DRnBmelpCditVTHcybk8yMENTNWlyZWZnR3h5cVJTN0J1RXFh?=
 =?utf-8?B?QnJtQVFibTRuVDc0OWJ6UkdEWi9wSXpUcDdhVWx5UlhwaTJzTE1BQ0JMRS9u?=
 =?utf-8?B?OGp2ZXltNktzajdZeG5Kem8xcXZqeWJBQjFVYlVPeWt0eDNKTXI3Zmh6MzBR?=
 =?utf-8?B?aXRMd1YvTExsTEE1NitrRDZNdXNpb1MxaW92enBYRlk2UEphaWM2UUZjMWJB?=
 =?utf-8?B?enFFUnU3OGt2NTRQZlppc1VWQ29aYllJWE13K3RLODVDS3phVHhIK1BkZzRo?=
 =?utf-8?B?TDhxTS9GWE1ZV1hGa1lleFZ6Um01WkEzUEFFT25kY2owdHZrQ1pHY2E4Z3Rw?=
 =?utf-8?B?UG9VaEo3b0syODZhRWZsaGxjcThSbnpFUXdnRFNNdWU4RjZlZUt1eis1TXY3?=
 =?utf-8?B?K3dvMTRIOHFRUkswMHc0eHFQMkYrcU9KRUFDWDhaT1VpcURrSkVKaXpJbjRq?=
 =?utf-8?B?TklicHkxakJwb3J1Q3ZicUVDSnEraVdBZHlkeFBmMEFzT0VXQlUreDd0akZL?=
 =?utf-8?B?S2RpZXZrNTM1VnJ1dWZZdGZaRVNZblkxaWJoY3VLK1pRb3MxK1hvdjk0TUlE?=
 =?utf-8?B?QzZ5eklpaGJRdyt1V3ZFaC9QcUhzMStrT0NrNDFiZnFLUG5tZWpPWGxQUzRE?=
 =?utf-8?B?bGVTK2xOQ2FtR3N4bEVTWm1pa2FtL3ltbFBDZSs2V0xuVUVmUVM5VDBjZXNp?=
 =?utf-8?B?UWxnN3hPQXA1SVdDWlJTTmZqcEFBSGxnalk0YWgrTHpVVUpxQ0FVM05XYnVT?=
 =?utf-8?B?b2gvNHZRNzFlMGMzZHpSbStRR2pzdWdNUnNkdXVZV0NpOHlNc3Q0NU5iL1lX?=
 =?utf-8?B?SGRXdGlqWHI3d01Tc1ZhcCtrQXVTN29MZkdTM0FSeE1Ka2QvS3dsSEwrNDFn?=
 =?utf-8?B?NERhSFB6cUVSbWVaQ2luTFJNSjVlV0RwU29wZWovNU43QmpSakxESmo0YTVq?=
 =?utf-8?B?d282d2YweEpjeFIyYXFqT2luL0FHdGxOaElaSXRUZjJuWWcrRGZEOWljd1B2?=
 =?utf-8?B?NitKbVVDSko4Y3ZpTW9wR3ZYaDVuVXgzTm5sc3hWK3NHZm1ZUmRDZEtkK1JR?=
 =?utf-8?B?clErRG9LU3hBSXpKT3IvaVQ2MHoyQTNvQ3M4L29SNlVNMFYyMHJ1UjlrQlgx?=
 =?utf-8?B?dTd1KzY4VmlvVTAvdzFkOWxFd0tkSWkzUXZnSE92WVZKeVYyQkJZUm04eUtz?=
 =?utf-8?B?NjhiM21XZEV2M2lickJIMDFlczlRb3hMN2I1NkU2RlFST2Z6ZzZSbmFyVHRo?=
 =?utf-8?B?cUR5MHBEV1ZqbXhrZ3ZZTm5COWI0eUpJL09JNGQ4ODFFR1RGQi8zVlhncVh2?=
 =?utf-8?B?SEZDbmZDeXFSOW1hWG5YTDN6VzVVVDdPWG9rTGZ6NldNVmNKZ3lrSXRkakZq?=
 =?utf-8?B?MWp6bHpoTGlRQWd3SGNSNUg0NDlSdFdrMzRqNE12WHovTk9wQmZLT3lUNEdn?=
 =?utf-8?B?TFF4UnFJUkxwVzhJMHdpdlByWWY0b3ZrQUorTUQxM0cxQkR6VWd2a002MG9q?=
 =?utf-8?B?MCtST3IrKzE0OS9WclY4TEpYSElVeTNwRTZMZ0NUeER5MzU4V0ZpdVhITXlJ?=
 =?utf-8?B?WnR6OFRkdDkxT0FoWHplTUZvSnQwL05sS0t6YVVpY05iakhld2k0S0xyQUZJ?=
 =?utf-8?B?NDBUZlZVVmxQYTEvMEQ0VmExR2gyZXVFOVRxYmZjREZhNDNrUkJaZG1ib1pj?=
 =?utf-8?B?R3BubnZwekppOEllU3VTQm9oWkJ0Si9NOTExTU9tNEY3VzhpMVFOQzRXT1Qz?=
 =?utf-8?B?QldFRDlFeGZUUTNJV3lTT3ZaQnJ4V1dIMFRCWE1vMmxnK2NRMnYwZFZmblZt?=
 =?utf-8?B?ZjZaVjB3UmUvejBJT0hYWFc3clkwbWhySytreVNPaHB3SndidW1MYkpTWGFy?=
 =?utf-8?B?U0d5ZmZGMk5ZMmVUTGdhVXVUT3B3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <34CB23ACD031AA45BB64176016A9A04D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zQIIbWoQNzIEAZPiKOLa0fq/1WVRd/T+lK1Cdejexft9av+gon8NPZ/m7Yq62lJhLoFqrbDMHw/Y7rQb5kU1h9QFM1lJ5JtsyR6dlg9WCVFEk9HZPkCQfF2ydCSnrddqejlbl8Y6mF9JPPzvCTOiE7dTSBvI7XqW77OhKcNIZ4OqPLW3q+XOaqnjKDH9Yo706OHlKEuiR1+L8+NcFStjjjERZ+5CavTyz/r2SA8nU6G77Az/gZzkqCO3pYao3tku0tUsY7pUTPEWto4v5E3cslfZO+JBgSgAg+WOgj12jY8fQiDv7p8UOpFwsfEYlxu+og/NnxcsTjek5o0tjQA20QaYg9XORqtNK9RFWHcBR0qmAh9h7JA8wj2wCqhUGsh/KUMJyT88FOhTexT4Y21bvyEOqpIDR6CxL81DrL3fYHtHOrxzuH1r4Oa7sx4FrZMppnIogq51rJbDCY7dVlDnztapg+8L+eXwRQsldpm7FdNHAqYUijciV9vbZ/iTPLzSL44yjUfJxNRcD6X2/r+uVR+sLlFAnDO0rCXMC1PKqh0UiHWghb3UrGqZCzclaNMjJ0/2mtnhNtQzi+ka4yLmeMPnB4j5+QA14S7f2OXn0EBuyFwsrNkzNikSvoFrxYQy
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d472fb75-9e9a-437b-6a1e-08dde93c0012
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 09:43:26.4597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cgo2wh1RIzSspE9mhTrt4nzCzBGZiZ95O4GLFCwl64oc2mHsqkbpFFNaabxLGZhvkQEmllB+9RWCDfkKuKWcjCq/x8z/QIGic/iSMsfTdfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8412

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

