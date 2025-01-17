Return-Path: <linux-btrfs+bounces-10991-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC583A149D4
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2025 07:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D429316AE89
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2025 06:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD501F76AA;
	Fri, 17 Jan 2025 06:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eslEYVof";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="AbyefORj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9401F76A9
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2025 06:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737096840; cv=fail; b=DiWDtK2MjIWlEdv6tYD79Y0CKvwYDgX7hnWjnHpULXVOVaWuibVfwnOqbz/KUvW9jd1VOTXAienZLSCnyDpdlaKZf93H01kWc2nyAHEbvkpLTodluHG8wiFjG7gmTWLr62AOgaWE7pRsvda3CL84C2LGzlA3zn6gf5zdZcIt6GY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737096840; c=relaxed/simple;
	bh=4y1mUTUMR+/Oc1E2H+TtwFybe/QBYsOiVV894VLunsw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y/ROSmmVMaAEBAqkhziO1gN0SzYis9pncMtHT8ApwUpgmoQc3GAWBEb3pUNa74oqbuSxq8f1x4EdcuLloYoQcPjp3qP766VWW5wnyyE26vddTUX/4z8uIFGvQ1INydUOoK0NG3AjT0p/5CbGS2/cfLdEgWNjJiMXT35Z8g/FNb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=eslEYVof; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=AbyefORj; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1737096839; x=1768632839;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=4y1mUTUMR+/Oc1E2H+TtwFybe/QBYsOiVV894VLunsw=;
  b=eslEYVofvPKlYur2j46f9AaTpQ9XRplRjaiA2q329xKwmLbAAF5+0F2x
   d0kOUbhp3h6CI13Dzr7d616/MNxU7G54KYtKVf+6q7lAk9R92bdfPTi6X
   pJoQgJXih4nGqBn/STC/6ZFziodX5cP0tRCtAm53deU/WGihN9uYwtMwd
   rFVvmuIdhrQfIA65fak7bTBUh8JXI1/9M+UiZrNYoad8QTPKJZ4hER5Ig
   FHjXIVtmVHS8k89IJGnbknY6fjoin1IlWLnJm9M1SkKzUjkURJLHdf4Ti
   196k1in/a3zt6XSwFyMFuxKgEcNo5+woVjRaE6igID9Q4c+cjiCuTLKku
   Q==;
X-CSE-ConnectionGUID: cwJnDGtdSx2sOTcG/UFBcQ==
X-CSE-MsgGUID: bDmYxIOlS225iP3ZfuSw3w==
X-IronPort-AV: E=Sophos;i="6.13,211,1732550400"; 
   d="scan'208";a="36151700"
Received: from mail-bl0pr05cu006.outbound1701.protection.outlook.com (HELO BL0PR05CU006.outbound.protection.outlook.com) ([40.93.2.8])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2025 14:53:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNjoPol2HGDPx6hsXGD3XQ0AEvvnOUws7TNca2hIIO3MZfeEKXMLroSdux3DaZqfaTc3gSo2IjmIrozCmybN9rF2sQzJ5nk8Tgcko/h1+SwdSmsX5WcrW4nMhZ0nbNgP0C5w+FPr8t4EMglL03eVdlkF+vSXNs3sc5r8mlpFo10f6UmKqzjiJiEHtfWMV7miv6zFiOx25ftIpHBp4qcyYiJTZoLj8KPIDtVW0zuTPfmRRFEl8rQdGgctQwrZ0+buthja6s5W6JovboHfs4ZxrfM+ymssOcBKspFNSw+q37ik0NzdS++r+oX7gdCTzp7K5dc0pZFWdKrec3O+ToOTFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4y1mUTUMR+/Oc1E2H+TtwFybe/QBYsOiVV894VLunsw=;
 b=QumzQyx2db8kBDZk6WUTUMCbOkKjn7l8zbEFR7FPPy/CAfxWJE77hQoa9Twy7NeBJ4WeGYnJf7O6g9zBMvuPuutXR25XJ+oY2KIhkq7bIjL2fwqxj1qyK1Kt8ESEll1QGu/93yfj2F8D2U0WnhJGp/ePWVIkhzeIpzImffjHFzCrX5BoCus7JfKy/e3l3jjtmnrjWswLSXNj17CF+xGQBhg/nnIPp334n3ekW1TL8Qctidsu0ZBy6gNRumDRnetk4SWX3MFy42HaR0DESOispgoJE66HYcdJYczbGW/aMmQ7NN7SIsUKwdxeeRq/N34JUGKi58nYoR6TQRjvf7pdmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4y1mUTUMR+/Oc1E2H+TtwFybe/QBYsOiVV894VLunsw=;
 b=AbyefORjFiYOAtGlAHw9Ho030HEgX73G+cJsxAFqZqTZz/rqe3PVmYSo9a/QXJabmFQBkQB8QPku3fmnKo/4Fw22K+DhAEoaGkb8FTnt96liPSbAW3f0jQ2qDAkh8iBuT1Fb6csXGrJBXfMn3x/1gPQx0xoIGrmvemBZd997dwQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA6PR04MB9239.namprd04.prod.outlook.com (2603:10b6:806:41a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Fri, 17 Jan
 2025 06:53:49 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8293.020; Fri, 17 Jan 2025
 06:53:49 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: export per-inode stable writes flag
Thread-Topic: [PATCH] btrfs: export per-inode stable writes flag
Thread-Index: AQHbaKNLw/+arO9rV0Wo2oALFwS4FrMah9cA
Date: Fri, 17 Jan 2025 06:53:49 +0000
Message-ID: <ae5ea555-0a3b-4e51-96c0-d318a99d5a7e@wdc.com>
References:
 <a7dd26219b1dba932d48b373fa8189a2bb6989bc.1737092798.git.wqu@suse.com>
In-Reply-To:
 <a7dd26219b1dba932d48b373fa8189a2bb6989bc.1737092798.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA6PR04MB9239:EE_
x-ms-office365-filtering-correlation-id: 3f0319ec-41d9-4af0-c8e6-08dd36c3b228
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eEZGbGFZSE4zMU1lYy9GVXFzaEJ1Q2xYOTZxT0pjQ1JvS3FuaWdOYmQzekRO?=
 =?utf-8?B?bEVuUUViSVlpYkRDM2dIYXN5dWU2cmFST2tTUjNBYU5PREFVaS9RdVNxc1Vr?=
 =?utf-8?B?VUx2NkpsaDFoQnFyTWNLTUduMnF0aDcreGFyQmNxeTVORzVFcEQ1eUx2a2di?=
 =?utf-8?B?ZUY0blZ1cGUwTER0WnVLSmpDRjZtakMyVERZSVp1NUdOajlkL3k3R09MWDBK?=
 =?utf-8?B?SVU0VGxrQmluVFYvMVhhTytVeXVwTWV1UW8wRzlOMzFUeDFLc3NnSTc4QXZX?=
 =?utf-8?B?NE9pU1JveHhNTTIrb3Zjc1ZVY1B1c01WZUFLd3lPSVFRSDIrUlE5a0pxc3di?=
 =?utf-8?B?eVdPUXViTDkvbm1uQkFQcTB6RGlNUEJGd2d5ajNMc1VEODh4SEVoV25Qa1gv?=
 =?utf-8?B?SDQ2MjllQ09pdkNSRGFMK0p6Q1FtbmRsbFRxT0ZlWmtnWERxRStHQ1Bib2sw?=
 =?utf-8?B?WTZVRmVtRmt0aWFPMXE2Wml4dEtacUJIRnN6UlplZE1qYysvMFJ2RHowM3Jn?=
 =?utf-8?B?dlFqREp2TitpN3RVelA5OTlzTWNJTkVvK0dDMVd4emVLS29tSlFyOWVQY3lh?=
 =?utf-8?B?UDBTejJyMWtUWlQ0SDVncU5xRnJpVmVIWm10ck1uRnFYNkFGc21JRzBKSGVa?=
 =?utf-8?B?MjRuNUU0U0lkd3BTRG1adUovbTVTbS9NZ2MvZDZNZkhZRDJZcWl6ZVFVano1?=
 =?utf-8?B?NmRLWFMxV3Jla1lwNnNVVlR0a0FBdUkrRTYxSGxDM2JkeVZqK3o1SnZ4L1Rs?=
 =?utf-8?B?cEVxaERwbTE2TlIrZXlCUyt4dXp0OGU1RHRMZzZZcmpnSUJGSE9MQUhycThN?=
 =?utf-8?B?NTY2K0xQajY4bXpJWHNRQUdjMmtXNW1sbUg5cFBJb2JodjVIZElrcmZUNndF?=
 =?utf-8?B?MU9LSHNXRDE0MHl3VGY1OXJoQ2dGQnpmV2xYSXdhL0JNbkRQN0dWTi9jaGV1?=
 =?utf-8?B?a2RwVm9pdzkvZ011cEl3RlFqYTRCdDdkVHEwUFdqSWZCNFhxUGFHc1FZVVBU?=
 =?utf-8?B?blMrWCtSQlIxbHVnSUxFd3BGN0p5YmdTRHIxK1VsYjdmYVBVMlpQYzlQOWZC?=
 =?utf-8?B?RkIySFhqcmNrc21xdEpMNDNhcldNd0pqMFlZQnlveEtEakhlaTZSaWFmOEpQ?=
 =?utf-8?B?SXI0YWZOdUVzQkEzdThkYTNvK2VQdUgzZTl1SERzUjNxSXM3U0czL1A3bkNq?=
 =?utf-8?B?WitZZXVhOFhhbnk2MnZ6VUxvem1qbmhzaW9Bc1M2aWJSTWFzRWNoV3FjTDZM?=
 =?utf-8?B?a21vVzUyV280KzBadlFHdjBUWXBzakxkdnpnZlNRelV1aUkvTjM2ZGRONW1P?=
 =?utf-8?B?UllYTjg5S2M1U0toWU9ERGJNZktXUjBnQWdta2pZYUFxVXhVUHdINTRLbUhS?=
 =?utf-8?B?QWhpVXROT1dwVzQ0Y0ZyQzRLUENZbzhxaWVIVWJyQTdmc25rL3NSSk1GazlZ?=
 =?utf-8?B?S0JpWmxIaHA1RGhETGlkUkRGRnYwc3ErNmh6ckxaT3ZEN0tYc3JpSGtveUVY?=
 =?utf-8?B?L0V5RDBxRzlLQ3BrVEdxSCt2VjZDbGF2OGlaMnEybGlsWVM5dWg3TUtBZVJz?=
 =?utf-8?B?YzdqdmhkdXZ5QVBCMzhyYk1XTFJuS3Z2Tlhhdkh3VFFDcFpJNDl0YVpvZHNo?=
 =?utf-8?B?QkJUQXBESmhldGkxUW02UU5uTzRzMS83R2FMUHhWMTZnREpVa01iTEVTNWJy?=
 =?utf-8?B?dHhDVlVLYzBzODk4VG1ZbVBTK0dwR3lyS3l3b2VHamZEVXZwRnZ2Rjl1dnBp?=
 =?utf-8?B?dDFJOWFsMVlEbFd1YjBSUGoyM2NZY0h6QzI5TFJja3VuSTlWckpiYWZtRWIr?=
 =?utf-8?B?Z29Rb2cybEI0d0FyUmRIQWRaZlc2Lzd4aEowazhwaU9hU1RBaDU1QVVNU1R1?=
 =?utf-8?B?azluOHZ6dnl5Sy9wc1VWRTRWNzlLRHlqWFJSdEdybFBmSnU2RzV2S3UvaUJo?=
 =?utf-8?Q?jtpl7RYEhF8lqYePxCGku0FzQ7rQsC1/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T3pPa3JZWU1lREEvYUlvTGJBS0dwaEFZNXliYm00R0tiYXdGcmNobno1VVcy?=
 =?utf-8?B?OTNrM1ozYWd3M1djcUpzZkRVWDhPL1V5akdNV1RBYkdhc0NMMGJnSjNGRVBP?=
 =?utf-8?B?RUZ1eXVQRmdBSmhTL0FGcW1CNXN3ZUIzZXBRRGJHMzA4S09Ic0RtVVRjN01D?=
 =?utf-8?B?MkFHckJnS0lYYVgwSnZINXdtSm9EdE5sLytkMXh1dTR0eXNKa00vV0NjTnE3?=
 =?utf-8?B?QjlaSDMyZzdBSVRzeURHUWJVVjVoQWV6UytDQXJmU09vTngvQndGYmdLNnlv?=
 =?utf-8?B?QitpNEJXZCs1c2hiZHRraTg3ZUNEbSs1ZlBOQ04ycFhIZ3FEbnFVak92Q0Ft?=
 =?utf-8?B?dTZLTXIvdnVkRmhOOEFJb0xMdFczWmtGNzdhMys0YTRnQXNVVlZFOW1JS2NC?=
 =?utf-8?B?K1Y2THRGSnhqUnpSVHA2VjgrOTFZVXorb3JSc29JbzRVbkhPMld1TXM3WHFz?=
 =?utf-8?B?anAvdXdZcnNzRlNMK3hFZzhidjZESnQ5L1JBc1BCZnRoUStqVEl4WWJJVW1q?=
 =?utf-8?B?bEpVazEzOTFpeGNYUlN2TDVvQWJrYlNrczJtQTlURFJyYmFxUkdpR0tDVjcr?=
 =?utf-8?B?eXNVZlA3OERrc0V0Nlg3Y1dpS2dMdnJheHVML2Q2bGRQZ3VKTXRGaWNnbjZO?=
 =?utf-8?B?S1h2MzdDRW94VWtkejYwZllDYXlianpkRHg5NGszTDY4eDZIQUNCdlNzYkli?=
 =?utf-8?B?YzFoOUcreEVITmNlcjIxM3MwY1hPdmRqTVRkUCtEWUR6MEg5MWpLSUhQYXZJ?=
 =?utf-8?B?SnE0WktEK0ZYcGZjSHBxK0xwYXR6RG91NTFYaTltQ2hJVXltdVh5RGFnNFNQ?=
 =?utf-8?B?SkI5Tk5SRXNvM0xGU0JqSHpQRFVDZ0QzNXA4dWZNMDM4MWg3WVJPQUFXc05M?=
 =?utf-8?B?M0NoSWdhQXpwZ2w0OHRRSjJiZzBqRXdzdW9wQXYzYnhWTTY5dHJrQ1ljbnVJ?=
 =?utf-8?B?aUV2TnRhY0NRQnhURXV4TkhJNUhRdEVnNXJ6elBVOTFpYitFa1lKUis0Z2J5?=
 =?utf-8?B?c2F5NXNMSHNJcWJObW5ZWlZDc2FvWE1LakkxQVBVaDBNYkNTbHZ2dE9CcG5I?=
 =?utf-8?B?bW1HeUFGVHBtcFNXdkRuYStVSUxETkJRV0V1SDJaMDFoMnNzTitLRlg2c1Ro?=
 =?utf-8?B?Q2xENzIvWjU4SXBmUVQ4R1V0N1ZuOUNwS0YrcG1yME9udytkdWdxTy9KMDJq?=
 =?utf-8?B?L2IvenpUNlRTcFo5LzNqbFhWUHdSeVk5QVhCRFZrTzZQbkRaZkp3Tm1sTWFO?=
 =?utf-8?B?S3VPQUpkVGxTdG5NZzB4RTZVMy9NMEUwK2cySVVLNkRVRzM1R0pDUThJOUNV?=
 =?utf-8?B?NkNONTkvb1pZWjNnZ2xucGorOG9iSUF6SFZOT0xrOVpOQW5qeTNLN1hQWUNh?=
 =?utf-8?B?R2dxTzVvV1l5Nm50UG8vU0VJUFo1TDVLSDJFSUpZY0k2R0lhWlJLU0M1M0J0?=
 =?utf-8?B?dHVwUmlKS1R4K3RzZDNTWFpaNGRQOTlUamlYczJIcVdhNFFsNlYwSFcvQ0xX?=
 =?utf-8?B?SFpKdjRRMDdkdEYvQXVwLzRUNGg1ZWdZRGZqakpVRFAzN2JvMFJadTZxbmtx?=
 =?utf-8?B?OWpMWVdrUmxjdVNZcFdlcUVneUNiR0ZmcW54dzJ1SmNRenRPWDRoM1U2UzlV?=
 =?utf-8?B?djF5NVFuN3BtNzZ2enNBMDlVNFVSNjNRdVpRNjExbGtJa1lmYzZPWjMxb2E2?=
 =?utf-8?B?MnVsRksxZGFQcXZ2cTBSZkZ6S29hTW5QbGFRbkRFMmppOEFIdnpRcW9jRDNF?=
 =?utf-8?B?dDhrUmtReUNNMzZvcmgwQmZRdWNDRjBrYXl2cE9LTFpOWkFIam9STmFTbkZm?=
 =?utf-8?B?eW5xdGxDWExTUmxIRmo4dWxwZmNxeTMxMS82WCtlR1pITGduMmI5bmhGc1JS?=
 =?utf-8?B?RXIxNmdCb3RtQlNCWC96bmRETGtUbk9XU2ZpM0RybEdCVGRuSFFIR1oyczAw?=
 =?utf-8?B?eWZITWRCVkdjTGJxV1FJTGFHZmZlTXEwWm1pNTVkcVRPUTNkb1p0VlpIV21B?=
 =?utf-8?B?K1AwY09Ic3RFRlk0SERMcGVhYWp6dXdjTzZkK01ZNjJJQzFXQ0FtcG5rbndF?=
 =?utf-8?B?TlRPdUlyd2x3MUUxTit0Q3l3cis3NVp3clZxYmFOK0dnMDV4eGJId3BRUlEx?=
 =?utf-8?B?MTJKbUhxZm1BakExZ0k0Q21OalFVeDlqSG5oRmpYNWxOUlREcUswY3VzeTVC?=
 =?utf-8?B?dGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A074F2A7D148F4CB936ECA754CF583A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CGDkXk7yh8AWoomKVib20G1+uaz79mZ+fzuLZpLQDNzlvlb6vJXRQhcmo2h5t/+avZgezuzwmTA9UyR2v2vIsT+bcLXD+69qGCkWrKnuEfe6gRhGy/6BzRYrLBalEDlzuNyEQyYy+mCFf0T1tkWfNbXiqdkA+YQ+sv6aA+W98Ofn1GYJ2ya0Q1os4mCWfOfDbCxv4R/iAOJSvBROymUUtMXv+3H9dVkrLVW9VHco/8dp2z636JX7v3C9HdVrBw1IS6wObq/XC+0jAx6cfC/M+pVRNWPDM2pTn7Kt06p2GksPfCrNTDlwOl3K4LFUtst5CUrlyMh78QyEnXIgxcze/I5rPmrCogftMonp38iRjmXxzXEzkr9raryapgcb+82sbWVqyrW9thf/4Ct1mcZ8OzIcj4PAyVd1I5JUTuNisuAV+JivIFUdZJrmTRkQrHQ6qnV+Gx2KLiv5MH1XQty7WnB5sg59E2+kcNYm671qi70xLo6FMoIxS3cgU6FdkP/Mxye7UT15nZO5KREfWKZ0F19SBQNrBVSgobi6bADEDYa6YPQP8vsWsYtD6DGnH3QJLPGTZEblHFHUVt9zGDTy5lTLOhUniay+AT2Z2NRLO55VY053GWQP8sc4SHn2UnEs
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0319ec-41d9-4af0-c8e6-08dd36c3b228
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2025 06:53:49.1417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y+/0eVmxvSiAtq+KoFbvfc4ndlhZmD9u+JFp+Ck4efu5ZTNfQKk9Us+MSlfSleQ4g/23BnZWKnZxOeCfYWI/3tEeRRGI+r1G/VQs3qvkKV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9239

T24gMTcuMDEuMjUgMDY6NDcsIFF1IFdlbnJ1byB3cm90ZToNCj4gZGlmZiAtLWdpdCBhL2ZzL2J0
cmZzL3N1cGVyLmMgYi9mcy9idHJmcy9zdXBlci5jDQo+IGluZGV4IGY4MDljMzIwMGMyMS4uYmQ3
MWU1N2QyOTc4IDEwMDY0NA0KPiAtLS0gYS9mcy9idHJmcy9zdXBlci5jDQo+ICsrKyBiL2ZzL2J0
cmZzL3N1cGVyLmMNCj4gQEAgLTk2Miw2ICs5NjIsMTMgQEAgc3RhdGljIGludCBidHJmc19maWxs
X3N1cGVyKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsDQo+ICAgCXNiLT5zX3hhdHRyID0gYnRyZnNf
eGF0dHJfaGFuZGxlcnM7DQo+ICAgCXNiLT5zX3RpbWVfZ3JhbiA9IDE7DQo+ICAgCXNiLT5zX2lm
bGFncyB8PSBTQl9JX0NHUk9VUFdCOw0KPiArCS8qDQo+ICsJICogQnkgZGVmYXVsdCBkYXRhIGNz
dW0gaXMgZW5hYmxlZCwgdGh1cyBhIGZvbGlvIHNob3VsZCBub3QgYmUgbW9kaWZpZWQNCj4gKwkg
KiB1bnRpbCB3cml0ZWJhY2sgaXMgZmluaXNoZWQuIE9yIGl0IHdpbGwgY2F1c2UgY3N1bSBtaXNt
YXRjaC4NCj4gKwkgKiBGb3IgTk9EQVRBQ1NVTSBpbm9kZXMsIHRoZSBzdGFibGUgd3JpdGVzIGZl
YXR1cmUgd2lsbCBiZSBkaXNhYmxlZA0KPiArCSAqIG9uIGEgcGVyLWlub2RlIGJhc2lzLg0KPiAr
CSAqLw0KPiArCXNiLT5zX2lmbGFncyB8PSBTQl9JX1NUQUJMRV9XUklURVM7DQo+ICAgDQo+ICAg
CWVyciA9IHN1cGVyX3NldHVwX2JkaShzYik7DQo+ICAgCWlmIChlcnIpIHsNCg0KSnVzdCBhIHF1
aWNrIHF1ZXN0aW9uLCB3aGVuIHdlIHNldCBTQl9JX1NUQUJMRV9XUklURVMgcGVyIGRlZmF1bHQs
IGRvbid0IA0Kd2UgbmVlZCB0byBjbGVhciBpdCBpbiBjYXNlIG9mIG1vdW50IC1vbm9kYXRhc3Vt
Pw0K

