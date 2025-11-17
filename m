Return-Path: <linux-btrfs+bounces-19075-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C21BC649DA
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 15:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C73E4E8262
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 14:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F8C333727;
	Mon, 17 Nov 2025 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="T+qqGh88";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LH0LADW2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7661CD1E4
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763389174; cv=fail; b=MZxhNyXqNz6iSoWTNxApyUZ+qQ4Yo0HkHFFcHX4hGW0OIeFKz6dHxSB0N/vh/NQS4PwfjkvEKLt/ngU/CYBnF9t1BTV37VnMSGWjKUq9+A8uqGxSfA9Wz883n13bl0AOOPumbRGP/QpjRUqPev5mlyelLwystVmeOhpm+GQwEg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763389174; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uD9eN29+uDYGONaj+MVdj490CanirwX8zDCp/08iH6bPVHg595uIQeaEZPnthp7NzrJwwhQ/SMDIwi+L8dtry2PT7qZSRbeTK9/zBOASQQ53ocAWzPAVzSp+mxC6Gu2Op51rRWznE38AkaSvAVtY2tDb40kvcpriDscD88u0Nf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=T+qqGh88; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=LH0LADW2; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763389172; x=1794925172;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=T+qqGh88RdQsKfvhLBvHu43hF46G42y/x9bHXfrDlyzbve+qtrX4r7iY
   DGaGgJj7ZZcO7Lg7prIxJDONbNs1GERxcfU2dywQ4qNWXcfWDkWQR5bBT
   ZZYEKwEG245WLoEahiefl+aPh02r99Su/HfuHFgaAJVh3e1U/WRH/ynIA
   BUAiJQH5Vt7f4/qjLoW2ghGgqFNffbwNSeJVDrzW4zQeTN7MK+G3kif0U
   h/1DMDpoZy+SeBJaOOAZL+q4N25qf4uXDFBhuoUOiuqR/usyIdoZ2xckJ
   eoU6EJt6OlFDwwWP5K4V4NleCGlRGZ/gEnJys2k+VA0s2MmJVlU962m32
   g==;
X-CSE-ConnectionGUID: od3t6e6sTqaxe+HHGRVn3Q==
X-CSE-MsgGUID: vZM+U4OmR+SLSL8SoMGBsA==
X-IronPort-AV: E=Sophos;i="6.19,312,1754928000"; 
   d="scan'208";a="135269508"
Received: from mail-westus2azon11010071.outbound.protection.outlook.com (HELO CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.71])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Nov 2025 22:19:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDn2waqPw4wwl1byqOVvr2eaggwsCyeZLM7m9ct1BbUcjtjVhP+pcFRf8GPZWvqCJKYgt9bSHuAE5UFrFQeUVIA1HODqrXz4nm9VJxyLVestCRtdejkvWM7DODJNNKneBQDd43FtbiWMNE2kSogQGwxpcILhHIkaosIuXBDK4rueFhvB5SefXeKwCteqRJ70WW9merydJGXeqQ+cFfPdTfxRbWDLWpcNhpm1mzSRkEpHU6Psd8WT7LC2tUr/SELt/MfN8Z06qStQJBMxdFXjgXZekhsTGGT2wATHLwxMBC6V4V6PrzGpqVw4Z2S3sSq0vvq0XNkCGVepaLSL2Y1sVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=Q9ldmP3E4Lkula2ROrjeVtP8sov+uzc3QRUyX1cyrUtNpqr8Uj9KIH9Ch6ry5A7F5Ffxn5qXkNehe018kXIP+KvGIgp7TDFMV4Dj6jErW3KZSJh6mc36YUsuR3KRiGB5GTacmnOCTrE6/HpAk2iEURIPWK1I+RYeM2XBOOGYLOtc2QBv3aJX9+L1r1z8iceCNlmnlPDC/hENkgVWYNYaX+W4Z/ImuyhPE+Mij+ArYD19+RogzRG6dUaF/PVn+w5WvIhMsTYILRCgeaXZWFbM04EK/+KGWDSPlo84+PiRADEzbk8z8WQk/59eW78D9iVVeFPtZ94eCurySqwz5cT0yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=LH0LADW2dn6sS8L8KbC0HU+7MZYO7CV/XNviU27jQZcVyOrnsg2t2ETU7QapSWdvIPOqcpDQoo48fxDoJ6+oraXtPYNxa+52pqNaqQbU5070Y8TVA7bRSct1TuEebPO+U0AwyxdVpSGqpoOFgTC7MPDhk7MgGwGnHU0PQNrcQxM=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SN4PR04MB8320.namprd04.prod.outlook.com (2603:10b6:806:1eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 14:19:23 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 14:19:22 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] btrfs: reduce size of struct find_free_extent_ctl
Thread-Topic: [PATCH 0/2] btrfs: reduce size of struct find_free_extent_ctl
Thread-Index: AQHcV71kqYN/iFSZc0mawOklKccIrLT26tsA
Date: Mon, 17 Nov 2025 14:19:22 +0000
Message-ID: <7ce98ccb-553f-490d-ad4c-4c4fbddec468@wdc.com>
References: <cover.1763381954.git.fdmanana@suse.com>
In-Reply-To: <cover.1763381954.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|SN4PR04MB8320:EE_
x-ms-office365-filtering-correlation-id: b4bfffc0-42af-4ac9-0bc4-08de25e44e3d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eEVVcDhOWVBkQkpIU3pSYUgvejZOdEhBSlBOR2s5enZmbUQwcGhTOGlxRzgw?=
 =?utf-8?B?UGZDV2JZYUdOZkEwUEUwS1AzYURVZnZVMXoybkI5aDBVWXpVU1lpU3lkSjBN?=
 =?utf-8?B?aHdTSU9xeElrWjFrckpzNFNhTWpTVWJKcXlFWU9LT28yNnNIMnJGdkUzZUdy?=
 =?utf-8?B?WTZsNUhLUmQzdUkzMHJ6OSs0K05nNmJoS20yMENSaGErem54ZXVBd1FyNmhV?=
 =?utf-8?B?OHhOenFoVW83dzY3TTA3d3N6OUJKQXlpRkhCQmZjb2ZoeWwzVUpPYzdST1I1?=
 =?utf-8?B?NzBSM1RPbFRzZnk4ZnY4cUVidHF0dDRMMnZyclUzZzU2L2RtOCtuTFRoR0Nj?=
 =?utf-8?B?WUdsL2YrdnA2QzhBWVR6QjY0d05OSno0T1B5cm1QMXIzM1hTRm8vUEhuQWZi?=
 =?utf-8?B?QnVCaUdJRWZyR2xNMnRMTGVmRjZwdTRiZ0RTVnMrQzl3aVBrRWZERXZGdXdt?=
 =?utf-8?B?YUJxKytIOFlVU2VYYmx1TEVQdlZmd01RNEUxelRBWUR1T1BHM0loTkI4OTU2?=
 =?utf-8?B?eXVzbU9WUnRDeERsc00vc2ExaW1URFJxSSsyWW9Kcyt6bzhTU0k0YTJQV01m?=
 =?utf-8?B?NE9KSkliOENIMElIZEl0Q0tmYzduRDYxTW50STYzTG9kcHQyVTNxUzBBZlFl?=
 =?utf-8?B?S2V0VE0za0taV2hpZ3pjS1A2U0tOOFNJYVFza2haQitIeVVWdXFocFBDUlNt?=
 =?utf-8?B?Mjd6WHBMemgrRGUxSXgyaUkyYXdST0pNVnphRUxJWktKQ2dVeWtOcW5lclF2?=
 =?utf-8?B?c2dVdEJ3L3NRSGlsQUtEUXhIL3pOQlNLMXd4K2NncUNRR3huMTduNXNnMEFm?=
 =?utf-8?B?RU4xTmVpMzZoem9NNDFGWXNZSStJam9lT2VheU9WR3FvaFhNUzNkVGFyZzhY?=
 =?utf-8?B?enVkYTA0bDdpSGRXcHRDT0M2Uy94d1U1a3VtazI5MFRSOEFVQTRWM2hadmtE?=
 =?utf-8?B?WkE2QWltWE51THEycFRyOWppMlRsalVaRW9oaGgxekNmRVJRZjFzbmlkMlFE?=
 =?utf-8?B?YXRUK1ZiWlNNVkthbFBkZk00SWYyZWVoREZTcVJSZkM3WmRBZ3ora0hCU0dw?=
 =?utf-8?B?ME9RNnJ0M0R6NW1ibDdRQkdPY1dKbmlwU09aKzFUVjRCMmhLcFM3dm55TUlr?=
 =?utf-8?B?a1BrSHpkamR6b3RpQUlNMDlWRG1GY0ZmMVhwblg1V2pUVWtBTStNQWtZZC9N?=
 =?utf-8?B?dmVyTGhpZ282MHRhRVpSR0hHbDNiUWQ4Vjd4YWN3T2EvNERSaWF5QnhCN1pr?=
 =?utf-8?B?WG9pem8wc2YrQWZCSTNYZXZYcUZsTk9jKzJkZ3JVNlVhc1NoQi9ObGlrdm1I?=
 =?utf-8?B?TkhCNG9ET2h5aXZsRUw4WExNTnVtOWIxU1lGeUxxQy9rajc4K1lKdWFQZXhY?=
 =?utf-8?B?aXBURWYra1BHdHVnV1RWd1NvQzNHU1ZhWXJMdUNHM1ZXQmc3Z3hxN0xKcHZq?=
 =?utf-8?B?cXBRWTNjaGNVV0JhditmQjhQODk4bkZrWVFmKy9zRzJhMkF0ZzdYd0ZFcGlO?=
 =?utf-8?B?RGJaejRobFJQeTFRbHhpRnpQcmRBQ0gwenRrVGoxMDBoSjJJbmlIUnlVZ1ZD?=
 =?utf-8?B?MDFyUU16aHBsRFJyRjYxZENCOFZreXg3Wks3UFJhaXpva2lVdlRicXA0Rms5?=
 =?utf-8?B?ZWt3OFV1MTZtTThrS2VsclNoOExFZzZiZSs1dEdIREtJaXN4R0NRSmlpZ0wz?=
 =?utf-8?B?YzUxcStCUXFpWWJPU3VNVXVhWmNWUjU0NDZjVkF6TmlNTk1JL25kWklvUjlD?=
 =?utf-8?B?STZyNytIOVduOGsxWVFncGhENWova1lydURIQlE1dUppZVRmdnU0d0VXclBr?=
 =?utf-8?B?TTRXZTU3bTFkL1E3cUZOY1ZpZlBLYWF5SmM5Tkxma05kUmtjcVJIRk5vaERn?=
 =?utf-8?B?bHltT2g4ZUNtTi93ZkZ2T0Q2M1BEdlY0YXdJNzE2N1MwQlMybVBzMkRycE11?=
 =?utf-8?B?VzBPTEpUdXpkYkxSaTdVMG5rRE00ekxYejlsNFVzV28wR25saFV2NG82Zzkr?=
 =?utf-8?B?bEx2aC9oRDFXbDQxNi9zczFmVFc1MmUyUy9SOHUxYjZYVG03ZGNSeE1CSWxZ?=
 =?utf-8?Q?hNJs52?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c1VOTys2VmFCeVFaTTArYWNlUUxSUTZtbU9waXM0b1dYaGVzNHRBUmJsQWEy?=
 =?utf-8?B?VnE2VW1LbEZOcGY0NjVRRlR3eXBleEhGWDN3Q3MwMENTdXBsdGZ0TjdFalht?=
 =?utf-8?B?bGMzLzYyUEpGWHE2Vnhqckc0UnJoQmhldEJZL0NOWmZqZkFidHlHZkUvZG1i?=
 =?utf-8?B?OU01aG82ZS92WEp4WUdVQVJGOWdtNzdVVGJCYjFxYTl1TFJWQWd6OSt1ZEFM?=
 =?utf-8?B?ZnJTNzcyWnpNSlpHbE9scEI4M2pqamtKWSt2eW93TTJOMXNZZHNpT3ZObUp6?=
 =?utf-8?B?NExJNVhhNG1PUWs2bmpIZ2JObWVaMi9rSkphZ1FCNUkzTHJFa1FzWFczMGhn?=
 =?utf-8?B?YlYxeGlLbFJZS2dHWTV0NFA2NU9MdnBYZFRZbnZsYjVBTjhxWUQ5b21mZk1Q?=
 =?utf-8?B?MEIvamhIZVI3Yjh6Q2hWZ1FxWkpUYWl1R3YyVU1MZjN6bnJjZG0xQW9OWGNw?=
 =?utf-8?B?YTlLOGx5eG5VaDJNaUkwdm9JUUZPZUloN0w0MGtvbXV3M3Z0L1lTQzU4R2JX?=
 =?utf-8?B?SkRyOFZDeFBZZ09rdVl2TW9iQ3lkZ25vaHpLWUNIYlg5V1MvdVdCV2YvQTFm?=
 =?utf-8?B?M1lHRzVWVDRudURCNmU4Qld6VHZoQ2I5MmN6RERZdDR1WC9vVVlVRUkzU01h?=
 =?utf-8?B?cWtYOE5kdnErQmRvOXNKZmdMZmg5ZllsTWQ2WGo3M2w4TlhjTmc5bWR6RzZ5?=
 =?utf-8?B?U0huUzBGTDVqUVB6L0hwTmVOTnVxQUxxaTY5MjZtYi8xczhNRHNoKzF5dzM4?=
 =?utf-8?B?bmtHRHZXb0xibGY1eUR3YWNvQllCNkFWdzh4dkt1Yk8welBFUzUwakMwSHdJ?=
 =?utf-8?B?YTJDOTI0RW1YL0RWaHk1dTN5MXNvcTRGOE93WXJsdy80QjBtdnhhZi9MYXVK?=
 =?utf-8?B?R1dRem5nTHg3ZEYyQXVuSklEODE5QkUrYncyTjhhcmRDNFZ2QWFGQUU0Y2JC?=
 =?utf-8?B?eC9PSDIyZE5BQkcydTZ0ZnFrakh1Qi8zMFlIY0dsRmhUdU8wbFkyRWQrNVB0?=
 =?utf-8?B?OStRTFU2NlJZSFl4S2FheUZhVGJHYUdtR1VYME1vNCs1VWxJWnJ4U0NtVExS?=
 =?utf-8?B?OHJRSlFkYVJ6L2dWS1ZRSkduQ2pTUy9kMTBtenBtMXpyRms1VXk2THFtOVhQ?=
 =?utf-8?B?dkJjS29FcXpHWk1tNjhRUitrdjd4WE96T3pWMXhMZ2I1WGVDVmhOam5HWmww?=
 =?utf-8?B?NGd0TWV5TjMrNUFRNnlMVXlWZ3FTVURONG5ObjE2L2FIdmM4NUdYMXgzaFdz?=
 =?utf-8?B?bmxETE00SWU5L084MGVaSjhXRG9hQktHbE5tVTQyMmVudDN0R01UV01MVHIr?=
 =?utf-8?B?VEkwVnRIWUVzcTNaREQyS0lWaER1VVBsclZJVHVJNXpEb1k4UlV5ZTFLVFhU?=
 =?utf-8?B?WEcrL2Z0OEtZMTBWYzRLVUpxTy9pYnArL2FhMGlYR3FEMmhacHhVMXI4WXVB?=
 =?utf-8?B?dW5USlZhRDBzTitLbjJ2WXNYMXFiaDhwb2Z1NC9KWE9GTkJJWXlsa1FPMS9I?=
 =?utf-8?B?MGdGWE55N3lsei84RDdlM3FLc1J4UUJzQXp2M1JqbzErS2JZVFg1TTVjZG8x?=
 =?utf-8?B?QUpWQ01MeDNvMUR3RVMweXJvZjBtYWo4RnBObHdaU2NvVnVwa0lldi9CMEk2?=
 =?utf-8?B?eEZJMWtCN2xNQVBBTzF1SFBWTVNiR0lpbDJJb2RERHZOMVlJVlAwQUdWTVFx?=
 =?utf-8?B?VW9vUGpPMW9HRGhSdnR0aUxGczNyRHdzRGFiZzlwdUdIa29EK0pkSmNrdkhz?=
 =?utf-8?B?ZnExdkZ2WTNXdko1ODNPMWRVdWg0ZGhDQysxZzBSTG54ZERUQjVwVkhRSUlD?=
 =?utf-8?B?QU10b1luSnVxNG1xWEp4azRCOW51c1daWWpIMmdNUUtJY3RvbDkvWTZFLzQ4?=
 =?utf-8?B?MXdBVkNyR1g0TkhhaFdCWWgzOFYrQTFuNGJVamozTkNCQkhkODFmOVVHaHNS?=
 =?utf-8?B?VU1Cc0RZaWY2dlA0eU44SHpOaHc1MDgzY0dDSnV2TVl2SlQzZ2ZtdVJyVkVL?=
 =?utf-8?B?cjl5Uy9SRms3eGVkTGpna2JUeEZ5ckJMU1Q4WXQyRUY0U216ckZ6RDFFWkRk?=
 =?utf-8?B?YWoxKzBwclVJRWprbHEyTXluRVh4NzdYc24rRlNXeDh6NmphNnVYYjg3V0Jk?=
 =?utf-8?B?am1mVStseFVnRU4veHhkLysrVXBEcXBuU3JTQlBlazZkemh4dXkyeEFRVW5F?=
 =?utf-8?B?R2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <90A71E47F834EE4BBB3D16105835FF24@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZvsT7v6IzWRotJyRT3As7QXFaM76adJUvv9TDB+zyXX7uVxMptgYJ3H9UHbRipvpyMa4p9EKixDt+t/zDZQSLtqHaAS/BQu6WHgfToke8Dofz+90QTUdBYP32WVuVn+SValxpLS/Itt14zOsqAVJ86ynNa6p+uGgDNTa+UE2R3KJh+TRk+pyKd4N8S7qiqlOWQoItol8KaZpej4gTdY0B4e+7VyMj5GBllfMWLAZ1rhaVLgt6rj3uPrbgkYbvma7xMMrDiJKUNpM46OkXXNzIpWtPiZkI61mp0EpX/FCWsmk2CX2HDwcE/8JrVsox8udUMcebjF3QNxFFV1R2Fd/+bZK+5GscukRGtXbgj58WpWXA3eg5QPVGzcQHz96IyJY4Tqcv3waUxgsEy6EA15GndY2J4ClEh/c2QmDwtQ0qtCnhUP2ognlir3Sv8RNhHM4okBTPOi80jv0TMyN6i6A7pLSTbQUfztYYdPo3PwCOMPQShCnlH6HX+JDquS8jhTwmEhglRJJ9cK/yd16xJzZ2lTFadVmMEwt6gwWz9rmUfCZUN3c0yoiWXSDgISx1NtX4MU71sMiDfOesYuIQLc9mFa70b3NMVkLM8QD5HQ12Nllb6NYwwTHBmq8L6EPWsFS
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4bfffc0-42af-4ac9-0bc4-08de25e44e3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2025 14:19:22.8557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MRumOBx21n2q/GB4As3hdDesRzSkqZbF8NbEDCCg0tCJs+PMkFb0b5mZ4T/iPy2pr+JmT1I9cWauJvdyqNT770Tbf4VPPBvuCxCsybCIrfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR04MB8320

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

