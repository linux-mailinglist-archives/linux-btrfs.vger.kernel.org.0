Return-Path: <linux-btrfs+bounces-11902-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7003CA47AEE
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 11:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B411188C815
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 10:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4A022A4F7;
	Thu, 27 Feb 2025 10:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZAjcIkRF";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gS0gD2VS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99201DC997
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740653821; cv=fail; b=tB5cmEQvTAyvAyd/u+w4RrK+tsZQ8QKlrruuUy/pBpjTzxJ7CiC4gQaUQqjcS+87S74y6KeFo27PwiY2+EQ/HSc7mpMHJidFs+Mry7Cv2KRUrv5Ag5DIhCBTUrnB49MzU+AH6QHe/hZ9jC3gTb0ulIQ3g8fxEkk0ljCEL7z+PoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740653821; c=relaxed/simple;
	bh=ZGfADmlmpTmwUJUjZ7PVqR57n3jeMAn3D/Ei1/8pHUo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I/l3K7NUPw7LpAvAX2ao9ie4xmAqnADVVYZWXrnKRcd32BjByAp8R+oEkMUyDd0hLZV9yWZLGiRG2G+q56jotqWuwZfe4rItcPMRzTU9tCgA1pttfbM70nUB/NGI3MBH91VGLVxaSctHrwcEwCLF3LIcmBbQG+nXJISGAmKF3MQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZAjcIkRF; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=gS0gD2VS; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1740653819; x=1772189819;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZGfADmlmpTmwUJUjZ7PVqR57n3jeMAn3D/Ei1/8pHUo=;
  b=ZAjcIkRFunPZRbBV3VeaFaETsi42ygwnLeEJOopB1+hAa+Tx8XqYFDIA
   z7TX6/ZSRe7h9akbFy+wJO2iI7Qcz+xtBi2yuYG04jLrwfGBFQfkaZi22
   GH2KMO8i0lOssEBsNUYeyvGQAZUXZp7XgXZDsaZDc8PJzE5nnnboYx+Ei
   r26Fy0ruetwalzlnVIkLbSmnQhs3htlTfpr/5LmlXxPIuBQCFfCfVqPfF
   9YKJWlV+V0RbZvyTdp+j4r3VfJKcDMfAGOINhwivVZ9WfWQPtFGYLeYFp
   l0Yv/1YabwAaSaaICxcVr587R88rRSuZtztLSG68jOAh6CjKTQ0DAzdEt
   Q==;
X-CSE-ConnectionGUID: ZOrLGOb2QQWnggkyLpVJ3g==
X-CSE-MsgGUID: ISUT6eH9SySfd9FrbQ67RA==
X-IronPort-AV: E=Sophos;i="6.13,319,1732550400"; 
   d="scan'208";a="40620080"
Received: from mail-southcentralusazlp17011030.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.14.30])
  by ob1.hgst.iphmx.com with ESMTP; 27 Feb 2025 18:56:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IW09z6K5VvD2nbYsrHKK2dalkeiFPmB1FGiWzzFqeeIBDE83ysh7pj/lGwJ3tEYPZsVuLEfIO8/3TYyJ4d82S2EIQ2KfrmEah3XB2PbsUW5TQuCewS7Dt1IhCxOQbQsQfewscTXKeyu6jBHL0CzSkh7kErB68SNtkoMBwfjeLJ5ZOWD78ceqS3fyvzx96YCYH18Fy/LQHNmniE+bxQprJSRdps2yofVEehsqQGonxqEJIzyFsnDyrfP440RyxOnz8/xt3VVIab7gonsXukPGfybQTwGkxav6si4dwT2HK9w6dfr+WY4jF4bjb27WjsjLsk4/4zFmsKbnA1lNnaunrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGfADmlmpTmwUJUjZ7PVqR57n3jeMAn3D/Ei1/8pHUo=;
 b=WEqRLfaQTIRqe0FHEpob75EwBWOxnviLrK7HHhKTTRds4AVlglArZbe+OMZB9zjMPuJtKClIo/cYt45HwsglID4VqaaYci4fPthzyV0EQAkGfJuyLNesqWiOMokswcztf1LsVbRytZ/BesY57zyb+GR0DDSKI2Xy7ncn0pgC+WM7Vtnbweh57NRSEviqGCReT6ZRPlhWqMAquuAHUCRYHUn0oN1Qi5FRFDlHsYCG0sOXRx7EVIe+1fAzkvg90uws8fSEoQBiRAWTMAaB5Ag67BW4uvecI/ZOPgei4bjRxKiTAP0e9v+uEBpDRbdpE5QGlclNwoSZEECSHE0Cq8/UxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGfADmlmpTmwUJUjZ7PVqR57n3jeMAn3D/Ei1/8pHUo=;
 b=gS0gD2VSpHyc+nRhmLPd+cMCQgFh6u/7BaNilAtGm0/JwEhMcxCUqKgD3OeCSbSsC5cVSELtkKkMvGe5xkncotDxkQUh5y2jo5B0O0iy/PJlz8HCDCN8uPQ7EN5nOwYlqBVf9XuUdrbDIPVfwrWGqnW7+eEb/ewkQBooK9Xkdog=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB7895.namprd04.prod.outlook.com (2603:10b6:8:39::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 10:56:57 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 10:56:57 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>, David Sterba <dsterba@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 00/27] Struct btrfs_path auto cleaning conversions
Thread-Topic: [PATCH 00/27] Struct btrfs_path auto cleaning conversions
Thread-Index: AQHbiDPyv4W8X0ySzE+XptUtRYEALrNa6wYAgAARNAA=
Date: Thu, 27 Feb 2025 10:56:57 +0000
Message-ID: <99ff81f2-39a7-4a60-9cf0-b61f87fc0133@wdc.com>
References: <cover.1740562070.git.dsterba@suse.com>
 <20250227095522.GA5777@twin.jikos.cz>
In-Reply-To: <20250227095522.GA5777@twin.jikos.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM8PR04MB7895:EE_
x-ms-office365-filtering-correlation-id: 9c5687f3-8db7-4648-2937-08dd571d7438
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R0lIRkhLRUg1WFBocGJJU3h1dkVQT1dKNzljQU9NNHFVc0FXNmFrYVpVbjV5?=
 =?utf-8?B?RmlYNTJhejZsUTVreGZSaW5IRTBQQmlEc00rUC9YL0RITFVXNkZPTjNZb2dX?=
 =?utf-8?B?ek9taWRrNU0vdndsT2R2NnVkMVIyWVBjZ0w0VkFkak03cDl5L0llWjEva3hL?=
 =?utf-8?B?UWw1YWZpNkcweXl1WWcvSWNvQnBoYllSUnFMQ3dCQW1IWEJQcmVpQ0N6cThF?=
 =?utf-8?B?WkhXdXpxck9adyt5d0xFbmkrRHJsbUxhVzRGZDVDaGFxWFkyeGl0UUdBMnFm?=
 =?utf-8?B?UjlyYndVZDRxSWl1d08xR3lGSERRRUpLMFUxREFhUDhreXlZeGtnSGVodE95?=
 =?utf-8?B?NmtoYWhxZXNNS0xTYkZaV29IY0NjZGRab3oxS1ZmMHQxZkRFWFNiOUJzN25T?=
 =?utf-8?B?WVpQdmFXTDRVZ2ozTUUxQzhHVnhiQ2l4VWdKMWtuemVvU096dGk4T2VEdDk4?=
 =?utf-8?B?UmVaWW9oSjRKNFJCVGtDV0FnbGxIUTBUajRyUVF2cFg5aDR4MnNtVU1yZ1BM?=
 =?utf-8?B?TDdiOXJ5ZVZqbi9mWk0vcEYyQnV5d2drOXZWejh5bEZsUERyY1BTaHJsM240?=
 =?utf-8?B?dzVuc2RyMW5qWUJINXI3M1NTajRxbjFpK3NMeDFiNXIyVTJZakFHMlphcVdp?=
 =?utf-8?B?RkYwS2ZIYzJYSWJsZ1VBS29QNGRBd2JLMzJkaEFlZmdkVFA2U2RpUy9GUHQ3?=
 =?utf-8?B?ME9BSjhIVzZFTnQ5dysvVjc4dFhpR2M5WklzbDExbXc2OGYvZHZZL1JUeTZk?=
 =?utf-8?B?WHFqZ2d1bExTWUJ5MDRmTkFDQXJ1ZnBlK0dVaXVLVlJjYmFnTlJUY1BUWEZW?=
 =?utf-8?B?eGpSWk4rUGI0UTBHQm1mejc2RWlhMFlxTzFUT1RrNEJDVDZKMThFVkVHMEli?=
 =?utf-8?B?czZ2OTdqU3Y3cHZPaVBZaS9hL3ZEQUhxSXU0c0g2a0RLL25UbWQ2M1lkMnNM?=
 =?utf-8?B?ZmQyenZXdDhOeXN3OUdGeG52QnViRWVYRnVXbUNJVXp2K3ZmT1lsdlYvaE16?=
 =?utf-8?B?azhEVndRblJQWS9GMGorVFI0VUhTandRUTYvUnBhaEFzV0w5eWhyeGZvRHFF?=
 =?utf-8?B?a2hNVmw4dFdac3Y1Z1JvbTg1Q2g5SVFYMjltckovY3V6NTRUTGdEUkhBTTU3?=
 =?utf-8?B?dXRFeWlZM25aanp6eWt6Z2hSbTRJTnFVTGhFTDdoTG1TZ1RodmNvOXJGRklp?=
 =?utf-8?B?K2VCUnAwU3oySjFXSTRPR0dEaDdzZTdseUdwMTJTVWd0clhHV3orYVF0WlYy?=
 =?utf-8?B?Q2lRM1FpQ0tERTNmVWp1enJxZW5wWWVoZlhrMWJyYjNBUFdURU5iaytUUzhl?=
 =?utf-8?B?amt3UldSSnFjeDVkOU5tVndHWlBzU3o0eVRuN1FRUTYyVElTemV4VWJtVVhN?=
 =?utf-8?B?THZaTDlYZURzS3BjeUdRWWpTdS8rU1c1L1hZU3RLYzdROE45OVc0TjFIclpz?=
 =?utf-8?B?OTZRSjR1eDZxb0orRjZpcWhNd2pNZm5hVTZkK3h3RG9JdWI1ZnpEdllIYnZX?=
 =?utf-8?B?TUFCMnNSeHZPRDZWRUVMckJUTXNVYXlvVk03V0NZRUVWT1Q0ZU1ja0dnenFE?=
 =?utf-8?B?a1R1aTQxSGliNVZwNVBBa1E5Tjg3cWlvNldkMk9OQ2g1Y09WZlpKTG5jTkhl?=
 =?utf-8?B?dlJJandPZVBFRE80YU1LMVFPSm5FNGhZVWlPT3VOemZWZW1yNGRuVGlKa2Nw?=
 =?utf-8?B?aHRqWEp5d3E0U0V3cmdiZHZYL2FDMm0vejQzclV1Y3pUZDkwTGhTYXhPSFda?=
 =?utf-8?B?U1Rya253K3pZUENKNjJYSDUvN2NyejF3M2ZLRTFvQmtzM2tzSkYrNGQvYVJH?=
 =?utf-8?B?U2RRNzg1TG53anBQSjVwaTZaSm16NW5xYTRNU1J4Wm95MGhvZWQySENXLzlM?=
 =?utf-8?B?Tm8yVVMyb3crWXVMbXo1d09xc2ljanBiUVFLNUlrUlRRVFRsYUtRYUkwQmIw?=
 =?utf-8?Q?BRTTqIk0GKdy8GlCBPZvilC2y8Lj/o1d?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MGYwd040Z3JrcXdaTkxCK0wzYXBEei9xNUpScTFzQVNWTXR4VDI0TjdiZ1du?=
 =?utf-8?B?dUdPQ1lLTmlvY3R6YlBqb1YvUWtRbVVjUmRydk5BZnpxK1dUZTZjRHo3OEVE?=
 =?utf-8?B?OCtVU28xWVNDcVBYQzlXOGFRT0p3Vy9tNFBoT0FzUXVyNnRtdzBUZVJKTTdq?=
 =?utf-8?B?d05KQW9PV1UvMUc2a21ZaVF1c1ZsT2NzTmMxVkl0dUVKN0pOOTM0Tjc1SEMy?=
 =?utf-8?B?VHYxRjlXdVl1cUgzM3ZYQnVOOEs1OW1xSTZ1VzNudkhWUmFqSDd2dzRIRER6?=
 =?utf-8?B?d2VjcDhLeEVJNlFCUWMyalY2eUNuTnhxY3VSMkZTdG14K3psZTRUcXdjYjV1?=
 =?utf-8?B?bEVRN1Z0bGRiWXRDdWhHUzZIUnhrZVpCbEtFTWFKaisxNjI3a2Y4dWVoVHBh?=
 =?utf-8?B?bzVaWFB0enJZWVd0M2RuK0o3ZHBVL2VDN0xMclZqNEEzNnVHamhuUWJEZG9u?=
 =?utf-8?B?ZjduMlpxbWttejRpQW9zRVROY2JsMmgrT2pTV3pTeE05blkyakxlOE1VR3l2?=
 =?utf-8?B?NkdVZ0diNGFiZ0JXTVlZTzdwbkJFbHhOVWRzYzFXTlZPTlFTWWNlUk9wTkZD?=
 =?utf-8?B?QmVuZ3RNRGdrNDdsM3VmUGxVZmp5cTJucE81Y1J6dDMxRG13Mm5UakkxSmlx?=
 =?utf-8?B?aDNSMllRVGNQcTU5RnhLelU4aVp1QTF6aG9ER090cmM0OXVKVzhWc1VBdkdF?=
 =?utf-8?B?UnlYNmVybXhaekZxK1ZTZUZkb3VjU3hlZ2Y0N3VGb2wvM3hxZkNueEkvUlpv?=
 =?utf-8?B?VmphRDZjNUpQMGdabmNRNXFJZ3U5YXJsaGlHUXNvNzBKTCtaWnVCeGJZR1VD?=
 =?utf-8?B?M2pFWmdrYXQ5K2RYOUk3dEREVk13cG1sVlBWcTIvN1lKU0VGckw3emxpUVcx?=
 =?utf-8?B?cDhKQ0V0OHJkRUYxTFFWZEgrODJ0THBwbGpJa2JZT1NuUDdRMVNnZmY5SGdL?=
 =?utf-8?B?R2JCbldYbVhnYjhGRE1sbW5FRDF2dEljaXJranAvZm8vN3Rid3ZPUWVXVXNs?=
 =?utf-8?B?UEMrS3FSVlNIZ2pxSjZ2dU1pVVcxZ00xaXJNbU9JSHZrcVdPTjFiaXNlV1Nj?=
 =?utf-8?B?bDMvUVkxR21lcWZMZWlUNjdqdi96UEk0S28xamRzOGxTY2V3QklhNDN4bmRV?=
 =?utf-8?B?OHN2OTk5Uy8veVNBQ3k4Yk9SVGVPdXdVR0FUWnVXYjR4bVZkOVZkT3lhQnZF?=
 =?utf-8?B?M1JXdGdTZUJjSjF3L1dGM21NanhVMVJDZnpBaEwrNUtmeTlUL2JHRmpLdUh6?=
 =?utf-8?B?R0dWaVJHWUJrNWNmZVdWTkRKZkU4SUlPU0hUaHJzQUlZOEhjM0FLejVsSmRu?=
 =?utf-8?B?UEJ5cklkcVk3VCtYZ1IzWForcElXR0o5NzNLdEZqMldEc0hONFBHbFR6bXZo?=
 =?utf-8?B?b3grYTFWUGJjeDlOQVJJeGhncHExOEtYQVg3SUEwUVZUMnZvMUI1ZlFEcmRM?=
 =?utf-8?B?NXAzcWw2ODBicU9MYm9jN2I0VjZBSTJOS2tRa21Dd0s4YWpVN0lCN1dNdGlQ?=
 =?utf-8?B?c2RpVzRoNVNkMHRZUHBrbVByNFlwZGhYRHhSRGE0ektRRDN2bThVeTdCMXRm?=
 =?utf-8?B?Nk95U2kyb2FQcTlyZ0hISzdoNHZoSGhENFRiM1dqNGZxckRnajFhNHp5NUlt?=
 =?utf-8?B?WmhMNWJxbGN2VFpYcFNTdG9JdTl4aWxFRGVVRE1IdjBzaTg2QytOWU1MMkJv?=
 =?utf-8?B?UTFoQ0F6Q3pjV3RFa2Mxc3lFYnloaVpBRHdZZXdXNU5PQzJaYzU1WW5zTDdt?=
 =?utf-8?B?amxnWWdZenBFN0E0QmJzWitZYUt1QW9URGkxemRpbUNrSU8xUzkzRFRkWEdi?=
 =?utf-8?B?cHdUdUQrV2h6Y2NtTWpYTFlkMnFrYlViNEtJTUFMS2MweWNBdFVCMStnSVRO?=
 =?utf-8?B?b0E4UXp5WHdCVVo2WnFZeURRRC9ORzJMaCtkWGNNV1l4cmEwaFBBSHFIaTdy?=
 =?utf-8?B?QXExNlgyRCtrTEUwSGsreTMxWG4vMlZwek85Y3hTMVVwNTZyZzZ6VGMrMHNv?=
 =?utf-8?B?UXdHWk1ENFFKbmg0V3hyZU9wQkMyb1g3blhWR1B0VFJtSDJMcUNCM3BRUGZ3?=
 =?utf-8?B?cG1YaEtQcnVaYml5MGgwbUlkNGFTay92QlZhKzI4NlBYc1BUdDJUejRxakY3?=
 =?utf-8?B?SVRQSkNSTW1SMFJDT2srY09nZmhhS2tjM0RxRERsWHdKYm1mRlo3ZmhDQzYr?=
 =?utf-8?B?U2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E22837D2FD9D347B7A4C47CC92CA522@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3a3f+wKFXKpR44+QwWwetJ9MpBGBUO6Ldr5Cauvp2Gsq9eHFl/CCnqiBM7tZMnMQ6sXbJJkOSvk3s+qv1VEBpN+0mlmCs7J2elQCEcRP/XOi60oFztnl9Cw3sXmyeawkRmL6G4u0R/OKHFtof19y3d5jFgmgO1dT4kADicEszGCgx1rT/UnTjMDZiFEbVYeMqwI1DXe020c92Vzs9+kinlD44meh6lS8GDIeD1ejwLoiKclZ5K+/GXSyGGyBf1yLZEaFwDknzPZ+OB9DLJbgFEza1pMZ7+eZQ3ZFwOpeQPBMfzOzJUu0gscYs740R0k3A+McTMvzdxyKaOPpkRq620Bj0dJK6EnWZwBU0axgwsrzO7nd5a6exwHMbsdotj0LcxhSXNBtBrSm4NDc/eNvR4fSWnt7G5siWsZH19I91yM/mcpX39cqyJ6VVBl9AugVBL5KkgmklSKD2GwNdcrb5LcDQXtn5W7OWKqzcsvkNOQmKjM1345o9A/L4s5PiimZ8ANjKh6D1UIMH/hhTQ/yCscc6QYPPykxTEMKcEpP86L+yCDFqI/1emcewhIpNdhxlhPpE2L74g9d/VTF7M/uLN3OMnpqQee/FfZRCHKQuttQ58YXH0VCMdf56GaxwarX
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5687f3-8db7-4648-2937-08dd571d7438
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 10:56:57.1643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wVkz8s0vhXlWYgCdJchm9fcKPfjGVWOC/cqBowZc0+ePapXnbar9q57MozaQ77NmZeD3x4eQXwNs/izbdKZxsFSYE4a3gTEf4Zr3tnHQhAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7895

T24gMjcuMDIuMjUgMTA6NTUsIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4gRGFuaWVsIG5vdGVkIHRo
YXQgdGhlIHRyaXZpYWwgcGF0Y2hlcyBhcmUgbWF5YmUgdG9vIHRyaXZpYWwgYW5kIHNob3VsZA0K
PiBiZSBncm91cGVkIGludG8gZmV3ZXIgcGF0Y2hlcy4gSSBhZ3JlZSBhZnRlciBsb29raW5nIGF0
IHRoZSBzZXJpZXMgbm93LA0KPiBzbyBJJ2xsIHJld29yayBpdA0KDQpBZ3JlZWQsIHRob3VnaCBJ
IG11c3Qgc2F5IGl0IHdhcyBzdXBlciBuaWNlIGZvciByZXZpZXdpbmcgdGhlbSwgb25lIHRpbnkg
DQpsaXR0bGUgY2hhbmdlIGF0IGEgdGltZS4NCg==

