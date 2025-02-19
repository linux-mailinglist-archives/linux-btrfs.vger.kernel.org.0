Return-Path: <linux-btrfs+bounces-11595-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D30BA3C58F
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 18:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5410916D64C
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 16:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D49214202;
	Wed, 19 Feb 2025 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MkpvKKUC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YmkecmT5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6291433AC
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 16:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739984317; cv=fail; b=srPsOA2O90bzQyZjUP8DU1of9t2KBLLKHnIkWSluqtcApxZf+D70pvID6vcuG2pyNzgadVMnVen2vnM6TkQNnJhRmHwzkaac5wkRS6w8G/np8YMCJy6Fv7D6xEbHAyAqRHHEqDXVkhRFYB0jFr1WvJYJbJVzM9XnH5ACVf05nk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739984317; c=relaxed/simple;
	bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fL0ICoL3IBBF9heS3HgLC7vv16Oi6uKyR4fX++mIY4zJ/vbWbDg7aXaPzqowAs9Pmeov9LRf2UlOeP8ZKc7RrqBZ+Hj7jrwUhCcIqwKZzatt2vCrxAc8eqRNwgqvlNeGNX0qeHM2cxaGzqN5EWAhynAAi3G+cL7hkbKuvFrfCV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=MkpvKKUC; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=YmkecmT5; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739984315; x=1771520315;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
  b=MkpvKKUCXmMbYcoivipRA4suVipQEDB/XTvrSkKVIrkDnrxmSqCZ2TKD
   TH0SdWFynCcJLpG/tCRfVv1i0Qy++jC4bB3kWnOrco0R9kQb1yukTAcGN
   zguB5+M+Y3hQOUo7LVUzeu6V2nVoxyEsSun5eGseoFggbOeaTZ5KvctSl
   F07HuQs+4zt0K/oCIugN+AeikMm3aOuhXRsaYcuEudv6QGAh9FG+z5Fay
   9gyQIgOvTOYsst+Eko7yUe1Fh16+e/obx4dCQGCV7qQRfs6FW3+UMRAEs
   Hn69wuv5lwxlkZOdbT9rPw3vAr9f7luGTCb15zoNgMMTrUq6g1bMtkuVP
   g==;
X-CSE-ConnectionGUID: l1FOADcbSc+1Qs+QvnO+9w==
X-CSE-MsgGUID: 8lDGq5rmSWqPnV2lq4wEhw==
X-IronPort-AV: E=Sophos;i="6.13,299,1732550400"; 
   d="scan'208";a="39552322"
Received: from mail-bn1nam02lp2042.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.42])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2025 00:58:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTDUkx9vLpDE22SGSNLaHNtS752KfZqiDNy/a8BfAt0iax0RrlhUuc8H4WTiQMawwiJlnbMic11k3lQTQdTL1+sgiTLkT3BiMisXXQGY9BuXP4g2o6rB+Nfch1phNIefdY2sU5elmRt1VqUOqJLZND1bcJYoRZrpzMFVExQklFx1ArwvP+6VDHCYP2XojIFEAo7vp3BaIb4hI/yabRoRf9NM2tz9/IhGfXqw4ZizYPuTJwx9qvl6l09+N2v/G8qVxBZe0Mm0pCYn6A1V6qRReOEuiNsxTQtvvoJ5vSOzn1XHGFqxxaXEimk6SVFO06fuklIPefIM2GKv+c6LZbMTsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
 b=IyAWphtC0TethPb6/QEiIemWpe7edQWs/S8zmDkUHnrl4EwgNUqJNNM7aKKfIc7RKkv7Q4UAfHXlnQUjpKNvEIaZiS9X7t4Fua6qHM8kJdN6yyHXeH4hc5T9qWed4he/m+yKudX7PH003RKT4gd4I3nbldxuacNjGJHMBaZsesiuhrbrV6bgP7hICednKAA8D6rTyPKc9MaOWoEZiqXuVKxY2XVPQ7lIZZ/zFtXRhtAUpcBfzBTHq5N6gnxUkLn53raC7uc7u5G89hhHUe6XC6NzCRfV/aRfxaSm+xqG9uA3WcBBHqDhQi7hrpjm0ZGLkriUXQ6vYYrA05JOWi+gkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
 b=YmkecmT5zX6jlGX9thy3596epYPe0J11tMNoHcbsLcH2CprRD9npbjOtM57m+Y6TT8P3tsSxd9poM6AC+kABgaOWacghOiqyQJpcwgC0oRxg4xgxVvUJa+hcED5+uaS+WOM9+rOaZYNiNZnLUcyBJ0vjZrKGCSvtt8jc6eg8JH8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB8372.namprd04.prod.outlook.com (2603:10b6:510:f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 16:58:26 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8466.015; Wed, 19 Feb 2025
 16:58:26 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 00/12] btrfs-progs: zoned: support zone capacity and
Thread-Topic: [PATCH v2 00/12] btrfs-progs: zoned: support zone capacity and
Thread-Index: AQHbgqQOSVSkIikCQkK/lftb7dR+nrNO2bMA
Date: Wed, 19 Feb 2025 16:58:26 +0000
Message-ID: <a2b24248-c3ca-407c-a3eb-4943b3ba13b1@wdc.com>
References: <cover.1739951758.git.naohiro.aota@wdc.com>
In-Reply-To: <cover.1739951758.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB8372:EE_
x-ms-office365-filtering-correlation-id: 4d701f75-7ef7-40a8-4ccd-08dd5106a0e3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OTJPbElBTDFFd2k2YWhZNWpzamxpWUdEaWcyM1IzQVd3QTNLRE1WU3dLOEUw?=
 =?utf-8?B?Zzd1M0dXMkJmTFdSdW9pKy96MDlEUmJUUno5Yk9TNjlReDd5bVlxbXJkblIx?=
 =?utf-8?B?bWlkUmQ0dnlqYjFTOTNBck5pKy9WeU5DK3hxY1NKSG5NS0Ewelc5elVkcXcz?=
 =?utf-8?B?cXJ2clphR3Z4WmFkdlJkdFNrUG9qclR5NWZwQURneEhYcVRhYTd1NWtpd0ZI?=
 =?utf-8?B?TTRTU2F3dUhncUtzZEd3a095UUZpNlhRSDlLaGxkVEp4L1A4RldqdVNYWDFp?=
 =?utf-8?B?Z2cwbVVpN3RvRTI2TytyYXlmYUxjckhYR0RDdEsvdU5qS0V5ZjNGeGJtUGRC?=
 =?utf-8?B?RjUrQ2tUWlZTMXlOM1FSUHZHUm43TjZva0hWVmVJWXZLdjJVaSs0eVNoYkkv?=
 =?utf-8?B?ekVWc1lycDJIdkJuRSs3bklpcTZEdGQ1TWs4bG0vZ3orMXRZMTdGZ0NVbkVu?=
 =?utf-8?B?d2MrWFhrbnIyZ2dGNGEzZVJmeDIzZy90dE9jQm9iWXNZTFIyc1RnZ1RVYzg3?=
 =?utf-8?B?elZLODZOQVcrUFJBbHhlRkNsbkJRbm85aEdsRkVuMERIQVd2L3UvTkd5MGFs?=
 =?utf-8?B?eVVmaEtKaW1iSjRUankvT28xVEh3RUQrSDJWS0MzVG5MQnRPNWU0SnFlVGdi?=
 =?utf-8?B?RXRKcWhzcVVNd3pZQzhYMFcwbHRHWHFqbjZRNG9SZ1ZGbW9jNnZMdUM2RVF3?=
 =?utf-8?B?ZmNXY01yV0xyQjF6RjU0NXgwUW5EZi8zeDF4U0JWbWJnbm5sUDhubDk0eVhE?=
 =?utf-8?B?UlBXaTRrMzVLanNOMUJrRUpOcFpyN0Q2djdUVlJoTnB2ZVVpQzM0Q2g4MVdM?=
 =?utf-8?B?RWs3clJZVlJmaGFxNHFOMW9ZSzhZMkdmYmRXK1paaGVSSFkrcFlSVUg3ZlM5?=
 =?utf-8?B?M1JCTkFSb1dKUm50b0ticzhhKzliREdDT1BGMWJCTUR4dHcvUFZlQVQrNVRP?=
 =?utf-8?B?Y2hUYnVVMk5wR1hvS2xMN2tlMTlBdWJaZjVPaTBQRER6bGlldmIyeUNiUVZk?=
 =?utf-8?B?bDNRYU5jYWlSaVNsUzFubjhwdHo3QUUzZm9ZZy94UE5QcjhHTFJKRS96cXVS?=
 =?utf-8?B?dDZETmV6NGlSS3p0OWVJbjZ2cDUxNU9qTDJiUWVZTHRDL0xDQVpDYjhkZGc0?=
 =?utf-8?B?Q1VrUTlCY0xjMVRQV1E0cmU1SDlpMlUweWsrdnEwc2VhN0FwSmN2eVJBMHdC?=
 =?utf-8?B?UVdmMkVLdFlKZXVCcGpBNFhjTlh4MXFTL2dFK1hYSTV4L2kybVBtdkNsTUdv?=
 =?utf-8?B?MnF2MCtNcjBMdkl2L3ZPOW90QVpDRTA2VldaNHhpYi80SjRaSEJtWUFrSFpH?=
 =?utf-8?B?eEdMV2NJWFVSbklOQTY3MytzZFJDSkl3cWlNdzVRL3FZTEZFZVZwY0d5QnVM?=
 =?utf-8?B?c0pHcnlva3krczZBRnRDVERnc2kyZHNwSTdsUnEvZkhQTGdNa09za3VxVzhn?=
 =?utf-8?B?RldRR2E2eFZIWUt0MzJHUGZrb3ZVckc2Tmp0ditHaWV1dDJuMDJEUXdBVmh3?=
 =?utf-8?B?QTFZQ3V6b1J5M29EYStHN3VXdXlTSVpPRzdGQXdYcDgrYlNuK3prYi9mMnNW?=
 =?utf-8?B?TmlFZlEzZFdTL3FOY2E4Qk5Remk3NzQ2aUE0NXREaFRZRVBHQkhENm5kRUtD?=
 =?utf-8?B?czRsNDhkRUtqcVlxUUQ4YzRkZHM3Uk1la1FVWEk0dEV6QUVVTWRYSllzc0xm?=
 =?utf-8?B?T21CL3dsUWpkbFZtbDdZdmlsaERlbi95RE1ZTHRNYWhDKzZIRUwvMXNNSzlv?=
 =?utf-8?B?VjllVS9EMVhEVWpwY0VtN1pHbnFCZTNEckd4cHZBeXdEZkhkRXJLdG5zMUZl?=
 =?utf-8?B?VWt5bytQSE05TmcvYkNrRHQ3blUvaDdoNUtqRU1HOXJvVnlOSTB5ZjgxcGtH?=
 =?utf-8?B?VTZIKzZ6R0ZkSUx3RDBaQURLemJnMWlNaTZKbTZYNVFtMUovUGdkaC9TbTda?=
 =?utf-8?Q?NxfQxwff8rUB30n5BpXrrLeQvTskjVS6?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Vmd1bmtmdGNSVVA0TzBFYWlXdk5vU1RqQ3RMU2JsZ05XSHBIaXZPWGhwVFpQ?=
 =?utf-8?B?V1RvYUpSVEF1YUFZUXdVMkF2N3B6OHhNY3pkOC84ZFhvMDdDclRxajhHZnNa?=
 =?utf-8?B?OVAzRWlxN3lwZEhSb3BDQytPWlFMWHRJNmhPYkZzd3gyUTB5NTE1RUdFVUpu?=
 =?utf-8?B?YWV0T2JDc0RuVnhScG14QzFaeTUwVjBRQXhiV3ZpME8zVEdQT2tXVnZFQ2VT?=
 =?utf-8?B?TEZoVkVqcXorTmUwejAvd3Y3ZndWak8wb0JZdHEvdGZwVmdEeDdkMU5wbGdK?=
 =?utf-8?B?dVN3aUQ2SG1aVXJmL0RPRW5ONG1SZlVZM3p4a1lCaHN6MGE5Z1d2T2E1SnJp?=
 =?utf-8?B?aTZMTEprRllQRUJud0hvSVV0MUV0VmFTSWxvbG5yVzJuazJHT3ErMHkwUlZx?=
 =?utf-8?B?SjhLUEtDZ0NwRG5pZ3EramZjK1lkcU00cy8zWnZZNTEycWFWTnA5NHdhU0dX?=
 =?utf-8?B?aFlseWlxS3ZLV3pUKzhoTUEraWhaOWhpejluRlFqZDVPMFJYOWl0dml2ZktF?=
 =?utf-8?B?czg4U3hjOExvUDVydkYwRTZoSytuYnFtYTJ5aUVhQVA3emVnQzEzNDA1aDNt?=
 =?utf-8?B?QnZkNmhzcjdmUkJIUGxGeTAzMURqbWU1VS9MTkhRbWFSVllpVVBPRTQ2WitW?=
 =?utf-8?B?TTBESkJIejdreWliMC9teWREa1Y2SmNhM0J3NWd0VWp3ZWhDQ3czWUQ4U2dr?=
 =?utf-8?B?cGFsNHdPYjdSWE9wdTNGaUF2OEo0cC94UHh1akVYcWVrQmRSakoreHFPUy9I?=
 =?utf-8?B?a1V2SE5DanU5TUpXTVFKSjFDby9zQk16TnhFVXRJNkpkRE82QS9aTUdiUU1R?=
 =?utf-8?B?SHh6Vk9TVEtqMlcwYTZRTFZrbEk4MzZKZnZiUXlPazM4MGpEZlNiWVJCdnA5?=
 =?utf-8?B?ZFNhTTBPYnhXYTJLOGRMNnFaYkVMV0VDaFBLbWRiWkt3TmFPTG5HaUlHQ2VU?=
 =?utf-8?B?c05MT1hJa1lpVjd5NXZFaDI5aHFCb3RMek90dVpjQnM1QmhpVmoyQ0kwSmdZ?=
 =?utf-8?B?WUlBd0g3dlZqbzlSYnZOSkxzMFBocHZnNC9lcjRzU3phTXNjUEo3cWc3WlNq?=
 =?utf-8?B?eGhsYnpIck5qV3JJdkNNQ29yNVZNMmJrTHc0WEFvSk1jNW9tZEwrZ3IwSDJk?=
 =?utf-8?B?WXp5NFhvU1FQWGNZTnJIc0lqaHExLzhGYVVtRjJhdlNZcnFsbEFGU1lDMTFl?=
 =?utf-8?B?T0lQTEM1enhMYzFHanluenN6WnoySDc2NmdwWXA0K2d0aGQxT1RLUGdNeklv?=
 =?utf-8?B?M3k4S3ZIVWtzK09qSENMeEVKOWZIMVVwa2gyQmdaUnFwZEx1d0R0U3ErNG9t?=
 =?utf-8?B?bExvSm9qeUJiQWtxY2VtT0hzUDVJdGlaSWlmS005TTJxRjBoSVNlY2F6Rmhq?=
 =?utf-8?B?Wi9tdGZMM3k5WXVsdmRrM1l1dXhXQ2xSUXNOVDc1a0ZDWE1waTJCdjFUbG1U?=
 =?utf-8?B?ZVpYWnVvTGpMbyt2bE91WlYyaEt0NGIyaVNRRVZjcmRmQUxCQ2VLeW1mZzM2?=
 =?utf-8?B?bDNjLzBwUnlQK0lxYnRxTW1MTlBKZzJqTUlEWWtOUGVDWXBIRlNqeGczTTZv?=
 =?utf-8?B?VlJKRTJLTFVnKytnUjBSMGdhVC80dnNyVUNvYlBZVUkrejRRRzd2RUxxM0pD?=
 =?utf-8?B?eEhFb1h2NVZaRHR6WXpyNGs5UTNONVhSM2xyY3pTYlA2K2ZISDAwLysvTU1R?=
 =?utf-8?B?eE1LNFRUZmVXaGJjbTAwWlhRSlRxaEhDMFV5aWE3UEEreXZvcVozUHR5UmI3?=
 =?utf-8?B?NlNGbHBQMkYrNFA2RDdzbnZSa3JhQjdIZUpJb0dveWFvajB3Y2c2VDlCWTlh?=
 =?utf-8?B?dTFIS1lSQmwrMlVFU1F6VEU1UVhrYVk3ZFloMmxOTno3TzVSV1RVZmtkanpW?=
 =?utf-8?B?WWtkV0NOY3U3Wmkrd0pqSVYrSDYwN2duRFlicGZSZ1hpWXZoTHdCOFFtWGZP?=
 =?utf-8?B?Qk1aU2xhaS9PU3IzQXRRczQ4T0pIQ3Z5VTQvZXVkMnZ4ZHg1UDlmSHF5WktR?=
 =?utf-8?B?L2lFdGQ2Q2dMYWtsUzhCOFkyTGlKeEdsNXR4b2ZUa1NzTVdRNVZKbWQ3aVI2?=
 =?utf-8?B?YXhRbDB0SDJEQ3Yvd2U0U3U4N0ltbDRDZDdwbXJtT3VwQ0U3Mmk2WWRyRTBS?=
 =?utf-8?B?a21VWEJhVzV4Y2ZRZFNFQlYyRXhHTktwUW16MDFkelppWjJ3SUdGNzNXbWtK?=
 =?utf-8?B?WkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACCE92A256F3FC47BD6D0CC4FF06EB38@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w64q5FQWbIBTGsyk0efnW8bCtu/DQqt2JXQbrnXNMzcDSvQSqzaP3nHL/4yiJwxTOAP9dTPOTVfyXnUoRBiyTusVjUMrz3pxqhcYbDSUijC+sN5KR9QIZb9JlPYi+HcUI0AUsKKE73PIOa0E+9L18eG4SwecuRuTa18Pg/OfJRjjy4PWhyeEC5Rc9qu6/naWYqJyD2NX4orNxoi1lzYPCmo7voWJgga+XMGv7t83UHkztrhjhdXzDt/UmU9kl0kZPSVqgdUA8py4vmnUJ94P4B6Kct/YAobnx5kLHbThBY2ase5LWxFUu2U/l7cbeOeFk7pkMUo8ugBh9n2/ITVcXnsbZjVAPI5ZUU400GTODY3DHf5gLXdb7sqWHf7uNCF/tsLG+zyfKWqwPwXgpRvON1Kqlmg3tKEr/KCMpoJ4OdzNSoa2QuxKjGIvhDXKW4hqI7xw6T02UYY4afDeFRU1FnyTiqZ8LMRMsq5Nen86BaWpcSPxU1YLzTfRQwxInXmf4f52h1rEbZAM5G/vWSod6jkQ7Q+IW2sHAFqwvNpt/+cIAJYGdkO38L5nMKK6KKJNdtYpv/SqfBvQzBvZoBd5XSk5AetXn9eQBXy0tWHum+ERGc15r2ESzqMHQiJJUS43
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d701f75-7ef7-40a8-4ccd-08dd5106a0e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 16:58:26.7344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: phBq5yVpHgWZCg9XLJcvolPnv524ep4TeQJEcqfiJvEWCHpaa8EIajO19fdbsvjX9dHA9gw+kxxoGOefKHPrI/T8/J1QLyoi4lPorD68yGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8372

TG9va3MgZ29vZCB0byBtZSwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFu
bmVzLnRodW1zaGlybkB3ZGMuY29tPg0K

