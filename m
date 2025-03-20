Return-Path: <linux-btrfs+bounces-12466-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22233A6AAF2
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Mar 2025 17:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB490481F4E
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Mar 2025 16:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F031EF394;
	Thu, 20 Mar 2025 16:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gqapOmx8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JIMsTK9e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EF421CC55
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Mar 2025 16:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742487692; cv=fail; b=B/otWoFvdU78TrkthS1ZRWdA3BdF0DCrGv9ViDrL0YEtostKxflGPg0/vfcP37h3XF986LZ6LCmtLZ1m8RJGQCW70a+3SZZClKWpw2k7GdvNWvNRmqtILlxApgcg0SsZNMWB2Ee+ltaMwUY6WDZW0NFYCh+Feu0ZPl4rbrqt29g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742487692; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cy2MtDDBZhkWwABzZ4jEpbFAdc38DdbqVcNb3+wtKWotplK+uDmvMc+vEIRx04JWhCYwt5CJUHi4wwwqW7mPWgOqWXIQk4Kmd55O2kUq5HjsYauuejZrF4fMzNV4LQf2foGGvtO3q0/AageKxz67OqXzEJDctpDoLbZXkqEfXNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=gqapOmx8; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=JIMsTK9e; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742487690; x=1774023690;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=gqapOmx836pAx7+thVD9THoPmkFyKOQ9USt30CfWNA4O5R5eVX1zl225
   2jA5JQXkaWKmTZm8nRCC2KmRFEXVmddvmQQqeMz5mRYGMDKPlfCJghwmZ
   HAjNeKoInf6UhqYm77h39JrwjwBL9pn0TvpfzEWJ3c8Twq7yHdwa1myUf
   8SmqWpFmVuglFtrFQJXfrqAVvvhsqCvKUVrEcjm5qsJRSoAsTJO/3+iz/
   RUJbvNEUrlIJJvM8Z/QisYAEwQ++YfiNNBiT2vCSODQGangzhXe5hmhxt
   Zzc5YiNWQNCBMmIOS10Tzhovs6Ul+jxDSrEpOx3MeDxnMMrk8VUcpUFeG
   w==;
X-CSE-ConnectionGUID: vz3tT9AEQP+Grikc36Csyw==
X-CSE-MsgGUID: bApx/YJ9TaS7FiTq0YKg3g==
X-IronPort-AV: E=Sophos;i="6.14,262,1736784000"; 
   d="scan'208";a="55240799"
Received: from mail-northcentralusazlp17013059.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.93.20.59])
  by ob1.hgst.iphmx.com with ESMTP; 21 Mar 2025 00:21:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e90VNgpGlfixkR1NnwKGjswkSbqzwJKXWLcFPMc/+Eg0UKfao0oy9obH/7PeUuPKnyrU7vlniwdYaA5whxwEyjUmmngzDlAQzTw/J1d64cOtKZ9XYFTizxSNOQkQ03b20upXApHaFqJUaZmIu96g63WB5M42ksfZR9gm+5v3K4o7fVocpZRDivXPV8QKsCmhudv+8ZnmN8KN5q/ovNbqoIA9sXOcKeBfgtK0s8N22HjZefn03MQHiUMzqV5DpihT81HPtxFF3nDZZHlOCVx0od1pZCEY5eoV4APjemVbEofZD+Vq/46zWPFhav0NRTxuEpc3VQXBHsPRBa3dowiRXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=yp9QEa5x4k8nQ7WkGdL5ljS9yOg1cUXfhihWvgrv3ewGmArfVKjMkE4VZ/HpjQqlytcSsV25N6hL4m99O2lS+F5jpcxhNf/3PpLI6YlGq4HFQlp3O20WKJTjlnz3sV51cpuZDWq5SEL6u60tD5xYVGvE4UjfdHy7/z+M/G0RYpsYTx9lBf3GdFmQ6gD2fMRanEL4mMa+s7BzSgjLUckKhLIVUlLEcYaUbaaZJAGz6MSRDZ76wJinkuH6m/j2oIBUjDL9Wwlja0oJ8YmYI4v9Dz0533MCRvhhEE5pd7mH091kRUN9YJ6A/r2ulRNTwVLXkmB2YfwoMDKMpuzbVmCK+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=JIMsTK9ekAf9iyxihB0W4+OgSi5EtkO5DstAXvVPwQJFMJhz1cXc8KhR/JsMIJc+tzuIuBxDEy4oAzNg5bkZUBpdOmf9F1DOMn/eGYEPw7eAYkx5Sq6QB8vJw2w4PudjQbENW7TO5ubdEumhElVDX6MEriw9mqCXfTXu8KWu73A=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB7055.namprd04.prod.outlook.com (2603:10b6:208:1e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 16:21:21 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 16:21:20 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 10/13] btrfs: tweak extent/chunk allocation for
 space_info sub-space
Thread-Topic: [PATCH v2 10/13] btrfs: tweak extent/chunk allocation for
 space_info sub-space
Thread-Index: AQHbmJaXm76AlYneKkKUAQEy3Vr1fbN8Nw0A
Date: Thu, 20 Mar 2025 16:21:20 +0000
Message-ID: <04a493a4-0bd9-450f-a487-e3de38e652cc@wdc.com>
References: <cover.1742364593.git.naohiro.aota@wdc.com>
 <a56b3607591af4c7ad9cd2f289e22c56ed7df8bf.1742364593.git.naohiro.aota@wdc.com>
In-Reply-To:
 <a56b3607591af4c7ad9cd2f289e22c56ed7df8bf.1742364593.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB7055:EE_
x-ms-office365-filtering-correlation-id: 8b9da0b6-5d14-43c7-2046-08dd67cb4023
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dzdZNkZBbi80Z1U4T05yU1hqYUVvb215UWhBL01uOHgvUCtEMWx1ckpKd0J6?=
 =?utf-8?B?L3U3MXlxd2ZHRWVVWEJhbFE5cEIxVUJ3VFVUSmhpYm03cWhuakE5RTFmZDFs?=
 =?utf-8?B?dWlCWFVYaEZWbUJpL2JkVm5JN00wUWdQRndrRm5MUFR3Nld6NkdMK3RZSkRj?=
 =?utf-8?B?RGFSdEZEWURSeEVZZ1cwS2xaTmJ1U0hmQVJLbXIwb0N0c1k1NEpQSlBzUWxa?=
 =?utf-8?B?OVowZVQwcjJXdmc0eGM0aTl2WDU4ZE1jb01JNnVYN2RORXA3T0d1Y3ZhMFd5?=
 =?utf-8?B?TVRYbyt2dE9VWlRBOEMxZy9wQjRnTWt1OUo5QVJZbzVoUlhHZVBpQ3Y0NVNs?=
 =?utf-8?B?aHJFTTdNSGFsdWVzYmNrR0pmT2JDNTE1aFRxVFV1QWJvc2FRNTNWaUwyUGFD?=
 =?utf-8?B?VFNnRG1kZWxxZ21CSWdHelQ3dmJJZTVGMHNqSlhOZis2R05xUlJUOE9qeURN?=
 =?utf-8?B?UXpTT3cwTGRoWmJsRjZyeENiR3NMUlVhNDgyMEhEQVZqWnoxTHgxUXJudEZx?=
 =?utf-8?B?bEtDMG9xVzZlSHk1Yi9VM2orNmxWTytLMHZ6UzJKbm1UK1ZxSUF2ampNRHVx?=
 =?utf-8?B?RnZjS3AyeklXaDNkUFdUVjI1MWRaVzgrSnFjU3lVamw3Yi9nby80VTFFL3hD?=
 =?utf-8?B?Y0NsajhFckRYL1FjUm5vV2E2WFE5UmhaT3BBWGY5VmNUeUpyRWxBeERPSk45?=
 =?utf-8?B?c1prcHRRSWpoeDB0SzVpWGhJaU5YaGh2Tkx6M2RUam45QW9PN3lDSkkxZXda?=
 =?utf-8?B?L3RtTEdOeDdpSGcwekozWXZFczd0Z2ZtTHYvWFNFUXFuZDFjZTl6cjVRbmJN?=
 =?utf-8?B?d09QYTNXS2FOYWg3Yzg4K0FJYUVMUlZMVVNFZlhLQWk4QzNmbmM2eWhqS1ho?=
 =?utf-8?B?bklXSjJBN3A2Y2VhWGI5czZsVWxPVG5Zbm84YWxRcURaRVFYRUNYZlZYRjJZ?=
 =?utf-8?B?emp1dUdJUUFQWXZGS09VOEtBelNYRHVidEFnOW83anpkdXZOMmxuSy9OcXhj?=
 =?utf-8?B?cmI0WWNWU0dJcjg4QUZraVZFa0ErVFYvQ3NvWlJkZ1NYcmVSU3I1dkdJaHZD?=
 =?utf-8?B?M3ljNDZZbmE4UjFYdW5pSUJIemxzUzZCUzhMNmVLeFFzTVRKdmtZT1VnNDcw?=
 =?utf-8?B?bzU5OTIyTlNaV1UrdFk3TmtCU3h3Uzc4eExxSlFYaGJFOTIvcnRTUHdtM0Iw?=
 =?utf-8?B?dThKdkNrSVliQVJscysvZkxNK0RWb0phRmdHSWNQK05vekRQekRUbzdUZkpq?=
 =?utf-8?B?MUNZY05tU3ZtUDhlK3J3U2l6QmtyRHdnczlJS2ZNSGg2NitFRm9qa0Yybkcr?=
 =?utf-8?B?UXU2YVFjVDlYc3ovaktVMVRLeFRidWNGNjU1bThkVTYrNUdRNG8rcFZqaXFQ?=
 =?utf-8?B?KzdBSlgrbVJxZ2lCSHlIYkhodnZsYW9TS3BpSVV6UXVyVkx5WmZDV3NUMEl1?=
 =?utf-8?B?YTZRYlgxRTlpVW9rYzJCeGFtK2NLdmJJU3FNRDZYOXhYRzhYKzdCb1g2MlVU?=
 =?utf-8?B?NkJhN3VZVWpGUkpUZENMTE0ySUxvTzc5Q3ZsUkNkNkxLK28weDZad1U0Qml3?=
 =?utf-8?B?bGgvTlVkeHFpaEJFL3ZIVUUvY3B2K2I3eEpFUVBZQXBzN1VOZkQzeXg0QmJN?=
 =?utf-8?B?eitPWXJ6enhtNm9iN0V1K2xhNkJYSUNKZnJCUXR0ZFF6NTFOaHZ4NEhnUldI?=
 =?utf-8?B?bGIrSVR2U2lGS0xuTHE5TEpsZVhJZGlOWmRMajgzemtaWEFIekp2NkUwTVJs?=
 =?utf-8?B?RkRHQ1Vvd1Rwcml3NVI2bDRoTnRlNjN1TzRkVFEzSnJOM3Eyblc3a2FXMTVG?=
 =?utf-8?B?YVgrbUV2Q2tHSkpDVW0vZnV6bk5yVHIyYVY3cVZ1Y2dTekdqbVZTcWhSaFJv?=
 =?utf-8?B?S3hUekVjSE1BdDl4VmgzYUtlZ0w2YzFyTS9XZ3JiTnJFNHhkZlRpeDdQbmMz?=
 =?utf-8?Q?j0OBHOkQiAt7OAqIDm1U5/TqGEaym8ld?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UHNOYTdWM29BTGFlY3dkNkNlQktLQVFIQnhReWtIL3p3NldJTUZseTc1elZk?=
 =?utf-8?B?K1lQakV6NGRoc2FvUzF2VWZVN2V2QmxCeTVtamZFUDY0SGlUVHhPdlJQKzRD?=
 =?utf-8?B?NXZXYit5WDJlTHdrOHR2TTlYc0Rma00vMWd1YjlrTFNyWnMxeGM4L25OMGZw?=
 =?utf-8?B?emI1UTdIMTZtdWZIdHY2ZXRLUi9VcndGSnZiaG9qdGczeFBGTFpMVHpSUEN1?=
 =?utf-8?B?eW1JYUxNc2hVYm9rWXpDWmdnM2h6c1FCTlVxY1Q5eFU1T1FHU2dIeUs5SXVa?=
 =?utf-8?B?M3FtcXp2UnhhdFFaVzNnY3RnZzZWOG5yOGFzQUZ0WnA0anpLbnRQb0l6Z3VS?=
 =?utf-8?B?VjRQUlIvUDFuLy9odVJ3cWlUcCtGSnpER3hMZFRQZUQ1QUtBcnNHNytWY1pG?=
 =?utf-8?B?MzR1aXlmYzNOQ3FZODdBSUk2Z1drOFlQeWc5ZHZseXhEMm5tNTVQZjR6czZB?=
 =?utf-8?B?RDNiQWdPNHZ5ODZzK1F2ZVVLdlA0YTlhaldvK2pVN0pVLzVhZGdFMFRaSmRo?=
 =?utf-8?B?RWhIZjFxaDd5OFVmczNBODl0dmM2cnplWWVEQnBjb0FuRU4zTFBpOHVvanRs?=
 =?utf-8?B?WUMvSEdScFpHbHRrNS9hN2VhTE1uQ2QxeEVlbjZwcDVsSkVKRHRqR3RTVTlq?=
 =?utf-8?B?TEtsQVgyT3gvUjlDNldXZ1k4VTFuSVZvVEV3OW8xdFdmV28yVDVLcFdmRy9n?=
 =?utf-8?B?M1p5NnBrZURpNi92OW9BdDdHdGs4ZmdhOVdJS29SRWJqY3BNL2ZZMU5ISVV4?=
 =?utf-8?B?ajhTd2hSZmNJazdXbnBLWjNYdEhqZzJVWnJjMURSUWpMcHJCbGRuenM2djVm?=
 =?utf-8?B?eFMyNFFhZVZLclJOcmd0MXVUYVlkMXh1UnNiNzNJdXBFQkdxQkdXZTFFREln?=
 =?utf-8?B?M3QzbmtPZ0lDYWk4VUtpNnN6SHQ2cGtzVHZNeUVybFdveGRpTWdQbHdoVExK?=
 =?utf-8?B?ZGlTRytrRndtVXRDUXdueXJSUUUrckVDR3BEYjZhQWtQVXNrMnZZV0Vva1hn?=
 =?utf-8?B?YkdrRkRPYmtSMkhpU2xkSUoxV1M2V1ZWNDhoYVJDUUIzbnFCbnp2bEtobFMx?=
 =?utf-8?B?QmswZU1kZjFta05OKzh6Um5GVmYzVThRUnZHWnpyMnNFeXpuTy95V1JLakh0?=
 =?utf-8?B?aC9ZQ0ladHo3ZXExQkZ2NHVVaW1rbnlkRXJRSTkrdy9hN3ZaMUJVTEFkbG5j?=
 =?utf-8?B?R2EzTm01bVBoUkJJTXN4VU5VNjQrdXRidi8yUHdqS1dzZ0FOTTI1K09PVW5o?=
 =?utf-8?B?R04zWExqUXVHc2ovMkVvK2FRaEFyL25JUGh2aDJDT2d3ZGUyWWtkN1dQZTE4?=
 =?utf-8?B?elNmaUYvd1JqR1A5K0FBWGRoZWtWeXB5amhCWm5JSVdHa28xM1R0TVluTDhK?=
 =?utf-8?B?NGFXeHN6TU5abU44cDRjaEwyNnBUNUt1d2QvaEd1d1hsendjQjV6dDU2V1Rj?=
 =?utf-8?B?TFhveXN4MmZmTW0zaTlGOE1JUHNsUWswVCtoaGZkemYrOUFUNkkybll5NU5p?=
 =?utf-8?B?OWlPakdtQUxEWTROMnNoakJTUCtPdWlSZHN0aTVHMUdQcXlQeVdWbTFZNTFX?=
 =?utf-8?B?Uy9EOHNGZmFMeDB1bzA4TmMzMWRPektJQ3BobWd4VkY3NWZLckRyY1RsTWVh?=
 =?utf-8?B?a3V6ME40blNNaTFOeU8yaUY1OWZqcjdzYlB6U1I1NWszU29zTWxGMFF5NjQ2?=
 =?utf-8?B?bFRRRktkT2RiUDhPWm1kdW8xYzVuTHpUTVQ5dm13Z0lpTlV2SWlYVDIxZFIr?=
 =?utf-8?B?aGdmTG9wTHM0b1VhZ3M4Z29pNDJjb0VoblFHQ3I1VFNxZ0pVL0lRbkcxZHNw?=
 =?utf-8?B?NHQyaXMwdEZhd1RydUxEa1lqL0pCTmZ1cVZOdkNPbUZXRlZRVDRFbE95WXZP?=
 =?utf-8?B?ak9xc1UxVDRydlJOdThJNzRtVng1c3R1bU42VGVWbnYxUWVoNTlxdU96dTRC?=
 =?utf-8?B?b2o1MGNHVkhGOVpRL3R2eFo1MStkVjhxK3pxNnR6ZnRJdmJCK2lRK0pFL1NQ?=
 =?utf-8?B?UFFVbUpGMXZ1c3FoNXpvK21mSmxKVHVCYkRVb2VMQUFVZjVMZXJTb01LcTEw?=
 =?utf-8?B?RVpFMElHRDVFdkNJNkxZd3Jvcm1KcTdrSjBlMUR0L1ZpYUdmZmg3QzlxWG9m?=
 =?utf-8?B?UTBkTEtraFloTnYzS1JCN0FLcXczNE5WTUpZYm85OGEwMnlsTHY2TlNRdFZz?=
 =?utf-8?Q?wdilzRSEsH938CO0PB/DWb0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D040EF21C6410C479D5AB78EE4AA9766@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xfXUehu9YxVvyquRVoi18DovFz7TKDUKQMMnDo+6C3jEATgdEon2AN4cwu73RAFNmPwL7nqWzjWDHwN67RfHwtvmEtBl8RvTWNU2P0J2OHuD8Dz1nJn/jquqA0qQSKkfXT6mG1X0glTWqC+Z1/TZuHzgNhfrv0mxMIrD8XudLboSdmwKrP54Dsnh509M70jX1n4HjO5Y8Wf2Mj/u85zvPZWbZNpnE5Sc80mgdD2sxwiVZpftgsTub0DlknPmGZXYWRy6YZUylKg1K9bUjCv3WJZFe+YZ2DxzsqJQAtvcfZTxOWnCv4Kjbyv5dtgWXuokngpuns0F5N/D/Wsn/b3QD5PILmSHpSczoB1XHAT4C1lnEZ7NcynXTqqwoylmXZQAY9GDayE96I17uf+amM2XSN0Oj3Q3+Ki6O4QVEoX6+1JOV3KUem7WYvp/rtLxE0htT3/XtAsuKdi5QrNIGMJHi8zj98nlQpHesm6/n1qAVTxnpCHBjHONAwfE4Ws9zyCujpo7ZIJGAYM/lr9KF6ZKscGOCRRaGWhAZnQEmUGaiVubHtc2MqyvGlyGgvDCq9JpWYOK94q2UYIMpewbyObJ7EX8a38ppHtzS+14+QWZdfLeuOk9HIvckN+Xan3w8tYS
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9da0b6-5d14-43c7-2046-08dd67cb4023
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 16:21:20.8289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ucq3+brSksdXHvrtYq52LC1xgan1OG4lfQvU9lwdu8FENX2qpshn29keQFS90OCX9oLYoqvb1HHdZfFRQBJbtP0d9yqwn1TdTT25JF05O0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7055

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

