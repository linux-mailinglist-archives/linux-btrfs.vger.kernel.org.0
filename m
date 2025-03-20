Return-Path: <linux-btrfs+bounces-12460-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5632A6A5FE
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Mar 2025 13:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA321168C66
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Mar 2025 12:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14E7221549;
	Thu, 20 Mar 2025 12:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aOls/xW5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="r/VbVspk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB0C13C695
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Mar 2025 12:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742472768; cv=fail; b=cNLg9NLET4klLP71t39XnksQp/XRw7PUNlnminIpnQ6/8iNf5ZIl1x+Mkc2pnN3AfU3OJ49DP+XcMyiCHZixJVLU+92dCax8XmO5GXLf/rm61vpQrBRWv6a7/NU3tTWdN7010XNWL0rYiOgnfMgplIrSlMVjENru9Me69VYwXF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742472768; c=relaxed/simple;
	bh=4b6lswKJDTqczH6TL1ZVeKmjwp1dYJ9qM1C097ndCHs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iBhOxvyG+lQ/FQ2I4FudG3NwQnXA8PJI0GHOSgdHEfzYOdDlsTVlFHlLi79X/5M4/F90S58khM8H2cfEflH4EkRju+0/4rcdCj3XQ1c61tuQ1WQYggMcR0K5BDZEk7SIjlpAdcuwhwwyxjpC3EoffkWzAykeQ2YnSr1Iq2QN/RQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=aOls/xW5; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=r/VbVspk; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742472766; x=1774008766;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=4b6lswKJDTqczH6TL1ZVeKmjwp1dYJ9qM1C097ndCHs=;
  b=aOls/xW5NhMXqXVMi4HP5b/7Z1X5AfFQrfDIB5B8k/lcrtl9pPyQOmAn
   DZ0nwIaF5EwExaGW5NAcwxpJu3sk6x4skwlMdZuBNR0C4zk7OOKIP1ANB
   TNexU/l5+jTvfzaonyEVfuhmKS/G8D9v1OUDI7EwotvHv96YOU/C3sp1D
   uxijPPnp0407UfzlADxtJioGsNKl6LnWlkjC6pc7XLUeT0fCIchj5fFla
   TG0+7V+U//1YgmgNqiYnaKtQL1RjwKvctX7TR6fMV3cXLtL+KPtBqZQ9O
   ohwiJxtswd02cp93cH0uaDNkC1xoqtUk95MSCDfNuxEpFwX1rfAu3JyxY
   g==;
X-CSE-ConnectionGUID: r+Z4eULVTCOJcATOPEZRWg==
X-CSE-MsgGUID: nCal3/b7SA21fZbZpzWsOg==
X-IronPort-AV: E=Sophos;i="6.14,261,1736784000"; 
   d="scan'208";a="55071205"
Received: from mail-westusazlp17012032.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([40.93.1.32])
  by ob1.hgst.iphmx.com with ESMTP; 20 Mar 2025 20:12:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wPhPfd7LUmuRyPvEkVNVuc1RvXVWjZ/RsYP3rWUM5gudy2/nOhub1bIsOawhDXQ2RIKGMXnh6wI12jeLh0eOs28Lc7ie0PINcfkcQ3gSs8s7E6ifYic1+0z48/wQIs4IwMO1uIs7unPpobK55IA9z5/vgksXQJOH72zQXaYdyE/CM0MySY18GeoHcHbTcwd/Jhash8NiSadvDFYZON+sY6RnO4Ys7ASREIXh4T/92dqR2VJQ/CIeb4c9O/vhCugcAJfMxjUNjbf2j+cnHcCfY7Yl2DJa1GE3b1nmIrUBhijJ4U3Kn4kGUWh9+wRnESOzVgO8iAVKIOqgaL39lr12lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4b6lswKJDTqczH6TL1ZVeKmjwp1dYJ9qM1C097ndCHs=;
 b=yVdgxf01NHyrITvR3R2coGAzm7+2PL5kzA1ZP/D5lVRpWh0ApEOtN0HeyrZhu8TsiO6E45BDm6icmITtPQL6C3SRYVKFg+83AF1tJkGNiAj6AxE6B18uHHh426DBp1k3I2+Q37rvoBUrRBPjAh5HO8kQY4k9lvGiQi3jBn5MwYdEYya3RvULMUWs9ksLE0d8rRkdILq/xRWGkftKIJT9pDvJGP2UmignY/1r5NCTs+OZuTCO30NQYwOTI3C3p3/LBDsN2feap4cO9S1/Rs/iNoy/ioLw1A3PV0Kc0CN0eF6L9CxhPYvqXZmWuJGDZ81N1HOqxlghH/1izHe6T9jo/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4b6lswKJDTqczH6TL1ZVeKmjwp1dYJ9qM1C097ndCHs=;
 b=r/VbVspkUaki4pePmxEMOzlD9dvpvZgFizeVwBJ8QSb0T4zEB+BUP3SRGB4i3Gr2Xj82kjBjeU7SVC1HhzWGiiZSKoDGqAZewq1a/HkSEn+0C9ySSchZvIWLcVu2Ibash7x3T6hAj7FkOMiGu+EtBPLBq6J32aF2YJpb+KzigX4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA1PR04MB8919.namprd04.prod.outlook.com (2603:10b6:806:386::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 12:12:43 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 12:12:43 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 06/13] btrfs: introduce space_info argument to
 btrfs_chunk_alloc
Thread-Topic: [PATCH v2 06/13] btrfs: introduce space_info argument to
 btrfs_chunk_alloc
Thread-Index: AQHbmJaMjY5TE4WiBEapE4EcFjDrbrN78ZaA
Date: Thu, 20 Mar 2025 12:12:43 +0000
Message-ID: <1b16d4a5-af1c-4e3e-a369-854dd6a83172@wdc.com>
References: <cover.1742364593.git.naohiro.aota@wdc.com>
 <cab0fc0b6199100cf9c740a8ceb205bbbdcffa74.1742364593.git.naohiro.aota@wdc.com>
In-Reply-To:
 <cab0fc0b6199100cf9c740a8ceb205bbbdcffa74.1742364593.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA1PR04MB8919:EE_
x-ms-office365-filtering-correlation-id: 0058364e-7f42-4434-4f29-08dd67a884d1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?K2swOGx1eFRRSXlxOHJlQ3RhcmVCYlpXNHNLbTJqSnBSZDgvLytUNlNJcHJM?=
 =?utf-8?B?SWhJWER6M2pLUHZPRFcrc2RkVndKTFVCM2tZWmFBUEkreGNpU2dFWk9xT01y?=
 =?utf-8?B?akpWamhQRVhsRlo3d1pCaVQzNzcxVG1mYlRkeG9DUGE2VlNjRmNaWlBnOWdJ?=
 =?utf-8?B?dFgzeW5reDl3RExuQlZXbVJQblgwaUFrTExTMnhKZk9xU0QvN05Eak9NZjRC?=
 =?utf-8?B?UjcwcERvWjJIQ21rVjVIWjJCTVVKenJlNmxjUXZ0dWJPT1dySEhjQjdveWMv?=
 =?utf-8?B?Nit1Z1FlcDFJOEV0b0lzZW4vK3cwR01KaU83NjdYc25KelB2NTFqMURQNW9P?=
 =?utf-8?B?amZOa2g2c0FRWEtGcVU3bGNPdHZoVndjbXNPZlNsL1JqV2dIblFKbzlPOFpK?=
 =?utf-8?B?N3BlYjh4YXh1Vko1dnhRY1FWeDRsUVRUY3JPOUNmUFkvT3QxYWt4Z0pzR1dJ?=
 =?utf-8?B?c0diaG5INGNtVUhwWTNyTlR4amhVRXJBUHZmalR3NEJ0Y1JyMVA2SDhPbU5V?=
 =?utf-8?B?bTV2dkxqMjFvRXI1UVN3VlpSUkErN0hXOGIweGxRbzdXSUlUUFFvYlRCQmtN?=
 =?utf-8?B?Q0lvNldFZ290ZVlvMmh3elpHTVU5UkxhM0xCdmkyZU5wcEtxZDdMMjViRGZs?=
 =?utf-8?B?ZVduY1RpL1VQcDRrcERaS3d2aDA1b1AybzdjV010cFk4YXdRSk9UMTlLSE40?=
 =?utf-8?B?azdNSFZCazhQNG5KSUlBTHl5ckxneDlrQVNrN200TktCbTkzSUFweGR6MEpR?=
 =?utf-8?B?UnYvejBlb3hLRTN0d2pGbnVHckJjN0Q0VWh4SXhDZ1dyRDBVc1QxSmRPU3Zv?=
 =?utf-8?B?akMvN2QxbzJpVlJNVGhPMHJUOE5QcStHSzBPeWJGbllhSElsZTh2WW4ydmJp?=
 =?utf-8?B?RkY4OU5VUjZ3SE1TTmQ3dlp4UVFUenlkbXFjYzRIZmUzNVp5Ri9mRzV3OG1R?=
 =?utf-8?B?VVd5WHRSdVVMQnhmdEpWOTd3UEV1Mko0R0tFc0hUNUs0RFphSDZhdkhqWitW?=
 =?utf-8?B?T1NrQUhXTGZ1SUpUaEQ3TjVVeHhVR1lyWWNRcm1Pbk5kUWdiL3dXMVllc1NL?=
 =?utf-8?B?RURRR05IRDdacnB0VzZXc1JpZEkzdVJydy9wSStsRld0QW5nV0d5YnpHekts?=
 =?utf-8?B?RFF5YS9JOW5keWpXYWd4K29tdmNtWTlDQlBJLzFKMXVZdzdha3RFejZVWVFC?=
 =?utf-8?B?dndhSStXUGpPc0lYZGFTd1ZLRmhheC8xdVQwUHoyVUk4ZCtEZEFiR1RabGd4?=
 =?utf-8?B?VS9hU0JHUXlYR0NGU3ZLWXcvU1JqR3BzbUV1MXlESlVFMWlaczRTQTlhTHMv?=
 =?utf-8?B?Zm0xZVo5bWFBNGdhSjNGVnB3bzZSVmlsK2xsVXJhM2VUMHZIOTFVZWdtdkc5?=
 =?utf-8?B?Q2ZtaEZ5NThEM2o1WGN3dWlGdDBCblA1bDd3NW1LaDNtWWljODVHbnBYblBK?=
 =?utf-8?B?TWhVcFF2N1ZFWU16NjhBbkRPNkkvV2hQS1YwUFpJeXFRQWorbkoyOXFqdnNM?=
 =?utf-8?B?M29sYnFud09ORmVEYzUzdHpoVExzYytVSVhQdkZ4bDhheENmem9NU1Y1K25h?=
 =?utf-8?B?a2VncG1jT2krN1prVms2bjZ5dkgwSUQ1MzNBckVWUm96QUp0KytkekpMVzNs?=
 =?utf-8?B?K3B2aGxvVmpKbW1zNDhJSUFGVDBCMER1a0lGWlR5NS8zZU5JNCtETGxUUWJv?=
 =?utf-8?B?RjFhazYzMXBsbnE0WDF5L3FaV1dvNlltZWp6MitxbGJaVUkzZUVadWVXbzBa?=
 =?utf-8?B?L2lIYkEzMUR0NWg2dWF2YXI4S00zSWRmTVVmSXYzeU01cjBReVlyQlRBNWpY?=
 =?utf-8?B?cW5ibnlKZUVTV2hTQ2IvVEhtVjVaem1ZQTFRN0RkaFdmbHRmUWFWbVdWZDRy?=
 =?utf-8?B?SWVCVENvTENDNi90QmZZWjhYNklrVGRzcm1ObE9jU2cyaHV1WlRNdzV3RkFO?=
 =?utf-8?Q?r5TmUi9O/qXuJK+BC94v+ZUpEYHa0lzK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T1RuUzU0RVNzMC83bjVIdEMzWllsZ3doNEF0cDJXS0tzNGZiMXJ3QWR2aXBi?=
 =?utf-8?B?RHM1V1ROOFV6dHZleTNBNU51YlBzTWNMUEh6bXB5WlE1QlNMVGVURVQ5U0o1?=
 =?utf-8?B?RFV1Z0o5RHQreWtPbE5acEtaOGZPaFQvQ0lzaVlnYzExK1ZIeW0yMUtHQ2FS?=
 =?utf-8?B?cTFVbjFSblRLdUxNQVRlTGlFcGU3ZHJXTTJrN0ViNmxERmNwbmVmeitnRHgy?=
 =?utf-8?B?WDJsdjlJcml0RHBVMmh6a1VwWDUyNytoMEExc25jUzU4NXFEOVpkVkE0MUJT?=
 =?utf-8?B?cFZnWWdMS2w0bVhxTmlXV043NW1EYzFxQm5GS3V6OFdEMnhxdG8xUmxid2Fm?=
 =?utf-8?B?ZVR0OGVHd2tvTEV1M3lRUWpoV3RrWlA0VUM1Ri92SDVzWHBHcTlaVlNmeHZR?=
 =?utf-8?B?QTBGaUNDS2NNV3ZYaDNrdEFWdWVDMy9zUkdJQkVrcXNXWmwyek1OU05ZL2J4?=
 =?utf-8?B?Zmk1bmlWanlHTWt1ZklxbFh5YlppUHRmejRIN3pkSGdFbUU2SE03VVFLbXox?=
 =?utf-8?B?ZWFGaGp2Y09OZkVVUGhWR1dVR3lGblVydGhrNEE1Z3p1Z2FkSld4R0tINFhV?=
 =?utf-8?B?Y2htbElUTWJZZnlnVzRtQ0d4dGRBWFFpM0hib1I2ZmhQcXljSVRhOFQ4Zkt1?=
 =?utf-8?B?QXV5Z0wvTUgxTUN1N2QxTUgrUWgrN0ZSMWQ2UU51ODdzeHRoMG1LVGpFRnZu?=
 =?utf-8?B?cUU5aFVHcEk0RTE1MUpsamVjV05DYWNqbGN1MFZrNFIvWFc3OUlRVVBndjRY?=
 =?utf-8?B?dVJQV2k3WUNNTjJvUDBsV1dWT3NvcWZta0JNQ0didXVRN2ZURnBQc1dBaEQ2?=
 =?utf-8?B?aWdGQXlDcTMvazZ4cjF4bmROYm9pSWQzNFVkRUpuakxMU2tSUWlObzhCTDBz?=
 =?utf-8?B?bm5vUCtzOWNRd0dZTUdoZDBQa3NvV1hRV1h4YlFvZVFEWFJwTUpwYmhtdTF1?=
 =?utf-8?B?NFJEajRYa1FuL1JDeTlYV3dBOG9JaVhtaENVVXhpSmNMeWhyTEw1Rm1VbGU2?=
 =?utf-8?B?YWFoMlVMRDRnK3R2cUFJNU5HYXYyNzFCd3NlWFhkUlIrZkdaUlF5alZBc3RP?=
 =?utf-8?B?SzFyaytjSUxHL3UzenpDbjNjcXZINlBSN3VXb2JUT25BYll1Y3NSbmVPSDJF?=
 =?utf-8?B?TExsVWVmTTV4RTR3ZUI2M1B4dTNpamt3ejBXM3J6d1ZNdjAzUGlMaWNvN0xD?=
 =?utf-8?B?SC9RYXRBc21XdFJPdlFzMFhOSEIvV3pWdWlNT3I1dWxmYkl1MzU3aHZWWVlB?=
 =?utf-8?B?RHNrbGdnYTJYQThVNFlUUnVlQmZnUkYyY0NvS2FaaTFqQU5sNStweGZzdFI2?=
 =?utf-8?B?N2F4QWNVaS9pb2xGWnpXcmJiL1BIZ1UycXRzUE9hRjdrU3NkcHQzQ0lYS09H?=
 =?utf-8?B?d0ZkOTNvV0hBWW93YmtDRnFFTHFlRVlFa0FmYWlmL0hJSTZPM2hzVGppd0g5?=
 =?utf-8?B?UytyQVcxM0Z4M2hlUHNWZDFla21kYk8zd0hjUGZNNVV1RjdxK3dJT2dJWEQ5?=
 =?utf-8?B?bWdia29kMnFPTk5NWG90bnovbloyQ3kwZDRpRmVhallnNjM1dDI3azNvemdp?=
 =?utf-8?B?ZU5GMmdqUjlQdmx5aWJIRVN5cjl4K013QWVVUDZ0TVNrNkhyREt2OHhwWW9a?=
 =?utf-8?B?OTJEcnpLSWFwai9JK2RHVk01d3NlVFBHUDhZUXF4ajJZaGdIMnVtU1JTYzlN?=
 =?utf-8?B?MFFnRXZVWlcyT1lqQy9kMngxUjJWQWtPc29QVEEreC96Q2YzejdQamVnQ0ZV?=
 =?utf-8?B?NWlXaVF3RnE1REdHRXIwNjJRUGUrUVFNQXNsajlsY1JrQ05HbUVLNlpWaWZR?=
 =?utf-8?B?eUlxcTNVMXhId1FtOXU3NzZUT3h6ajlGSVlQcmhLdTZkbEMrNy9oRTR1N21X?=
 =?utf-8?B?WFZaM3hBMWlnSS9LVHAvTlJGdC8vd1E1UUQza01sSHJET2xWblpLSDN5Vkta?=
 =?utf-8?B?SXRIWlJaU0FoT2RydUNTZ2xSUGpLb1hUMUVSWXhxMU9uZ1FUY0ZzQllMc1VD?=
 =?utf-8?B?M0lvQnk5TWdvYi9Ick9lZFAzNVRTYi9uQ3NRVnFsK3JsQ0h2Y2Z3U0lneE9q?=
 =?utf-8?B?SUdKNks3anIySWhrSlZsdVpBU2crMGtHQ2NKZ2RCanJWSGxtblRybDl3U1Z4?=
 =?utf-8?B?UHh4cUxoOU1mdlByWUs3YURmUkNGa1dKWXlYTWJLRDVZbTlTZmpXMjlwWm56?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <519F97B0BB914947BC92E21A9E778C1B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LmbmVp4dFract+LYfR3/nY4SouEgp1HRMhGzulxBgq0XYuCftgaJAO+dYdLQUj6sg/ZNu94lzQpIoQkFHhcrJoTDqS/qSG88KOK5xa2GQU3H2XItLL+s09EvafpaH8gprrX5aaN0xMHXbOfAOh8scCuVsrgPuukcxxDOHReZmlY4WEDffNu0Dy1JBwakZ5LkSvzJTB8fkADqBb48Z+dl99j/87O1kpEQ3zWEN1Ldhce2Fno2QpyV+O9NBpcqOMvfaLmm4mRw0asW8Ud4J4jyzZhDEFlRAkSOA1ddtJeT1WXui+BQTdtoaoT8p4pnctYwYhdr0TUsy+/Va8D5tngVBHKFp9Pi3uoN8kgzwfB/I+wEWL5k/eFFmkWwSZzSwcxQVRhjdg5nrG0e7dPh0gED4PvP60Z/4+/hOgSz+APSkpSKWkvX4X84urMLwKJ+LB98mjWyIkmzWe6P/a6v98nqTqeClAxbOwWQHnkSRazD5EhpixH1fdvnQ6m5bW6MWPld2tRpLHBpSiWy7MnRHMhNLcSyvcrxI6Y1pWGsDmiLn2UMpD7jpFoeqEaoYWyWeOLrExAd/g3h1YS2VKkpzpvr73JrWbjgCVc1GYLzwuMr7wqQbND10LX3QXSo5tYWKywV
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0058364e-7f42-4434-4f29-08dd67a884d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 12:12:43.6618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rxqjPUHTng6FEvVhWK/GRsmKF/b59n7Hk/sCdTWMdA377ZViM5YEhXzsgRPBvVtUrFji6AFOMxf/KMW10rcano4TfuZnKgpovKMx9eHoQ3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8919

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0KDQo=

