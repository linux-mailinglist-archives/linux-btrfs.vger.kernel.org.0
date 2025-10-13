Return-Path: <linux-btrfs+bounces-17664-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F14BD1B63
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 08:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4B993BCCE6
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 06:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC3D2E6CB5;
	Mon, 13 Oct 2025 06:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="p3wcxIc+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BKnMTFSZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50952DC790
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 06:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760338337; cv=fail; b=DL0C7Lt9Y99RNbEbD18HieoHJuxfAM1UDjFUM7httrWanSS89GxJFhyfEfewiUkrA48/LWjlS8VFXARmo6mmc8zjiXj47BQ37koAOP0yChsb0MZUboBD+2VCaggqVSrYMXpyChL/gBPgCj/6iZMX/tpVsOk+z74GiVAEt/rYVLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760338337; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R5UlXDzfEEyEwYbmnjqfhoOsJ8XMhpIlEm1kMVZT79fGVp8Vext7XNoMUPqeiY++/8pIbwAKsvzkJ5S6o2GA8piSaKKPYT67592udFvnu68nWM92o7EuokM9TmskrVy86u7bOtFMd6Jv7IjdmDNqFp9TjyTltvbyjzIjXpwOp28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=p3wcxIc+; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=BKnMTFSZ; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760338335; x=1791874335;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=p3wcxIc+R6W2fALph5WAAUMWRwGX0RHRyPA+AcEAx6ZXmeZ/1OnBjJrb
   DxokNWz+ez5fY5NK4SwEd6u+zvZ4Klt3jk4oIrL7XrCr5WL5lLgwXqnj8
   BNQ81EAw9sZwEQlV6LIo2L/HShIrPI/IhpuDNMm5XDheXrTqjgFnE5FR1
   4m1DlpDEdJqQoCz+Bc2zPjtCGDZsjZwpHy9n1swSiyur28Xa9hTjrPfdW
   LO5fYryFGRGa7NpWJ+0CD9UewQvmcBWuEaxKui6dQKQq/Wa+OTcJjauwi
   9btrk7zaGtyjSYMciAVfP1vFq9s2D71wxtllYAa7d5N3DcrptEvm78lBa
   g==;
X-CSE-ConnectionGUID: uAuitiPYQSasLfLIE0Zbrw==
X-CSE-MsgGUID: tlaql0M8Ss2JDGGgTxbtgw==
X-IronPort-AV: E=Sophos;i="6.19,224,1754928000"; 
   d="scan'208";a="133098985"
Received: from mail-westus3azon11011069.outbound.protection.outlook.com (HELO PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.69])
  by ob1.hgst.iphmx.com with ESMTP; 13 Oct 2025 14:52:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3sQ5cA0BAbC+hDcvN4zxGijE3UUq5t55cIs6NyPeRMkOE/J8Ofb/PvCiYpLaVxcyntBvlA8YS/gjbEahqY094Zyj9zRZGBa2bhmuGmvAWMgA2wfNC0c/EvDFz6Lyib9oPfI8OVgBmZ7A/V4GqTTAdSd8X5BWvoMWn0arw1wCNgiLk095bJbFDhzWV9Uszpbv7pt4Rjda/w3XxyozaruSnrweVP5YD0nPvx1QI+fS3eFjcw2xagpEpQyLgNwAW2teF8Me+hKECMNWO/9dioKkiy9yfYYiF5JRZYyalstIlP6QQPthmDAc/VVnI20cp/t4mVjnnnwSJADVvhMNwAAdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=XGTMIx0WuhyvAZKX3gh+Xpa8BcNOTv4t6lB4+gC04GIY3qun6BEPzw5fzb3sU8qkX3mkFnEvM+WEd1aaja19U1hWWfisUbgE61WGqEch5FSoe2E4sMC+NgNmDesE/RFZ0jMncK23K6RgIElZYUjqmd4oN+j3fpj3XC6DUurECP/pZScd+s6vvgxLxUa4sFB7kGGj0C9dzMiXjKshu+YaxGXU3TCzOuKTieS61cX4AeIbwPOrKtZfl7oRYos0M4wYz2mejBCjrr+ATysht59wOzipKIOeyNs5MfW0/Wx4q1sGw2H1TEKd4EO4nrrMCEkJrm29Ka04Jz9i0DEDyiK96w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=BKnMTFSZp3+Jq8ahRd7isAtX0vOGL5cv5P1bC2CEf46NRyPMt73yDGFkNga5hUHbM2e5Nwx77cFfcxv3B7yyaboVyi57/ihyuYtmmxWJ5BpWIVwduBwsPOLBn/0Uc1FfYawS2u/FfVGN9zJgHIKFLLqDm+r5I1REv6euEm20Mrw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6646.namprd04.prod.outlook.com (2603:10b6:610:90::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 06:52:05 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 06:52:05 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v7 1/3] btrfs: introduce a new shutdown state
Thread-Topic: [PATCH v7 1/3] btrfs: introduce a new shutdown state
Thread-Index: AQHcO9NVNXulPJ109U2NzSp1YLHlobS/pB0A
Date: Mon, 13 Oct 2025 06:52:04 +0000
Message-ID: <47ec52ef-573f-4bf3-81c6-16946cbd3d73@wdc.com>
References: <cover.1760312845.git.wqu@suse.com>
 <5242fe0720756535300cfaa90ddbdadf5e1a85e7.1760312845.git.wqu@suse.com>
In-Reply-To:
 <5242fe0720756535300cfaa90ddbdadf5e1a85e7.1760312845.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6646:EE_
x-ms-office365-filtering-correlation-id: 48c836d4-c4f8-4242-d5b5-08de0a250523
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|10070799003|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TDk5VUpZdG9PcGpmUUUzWEdlWlQ4RFdLZVA5eld6STgvRmtMZkhWMTlJR2FY?=
 =?utf-8?B?M2dZWHBFK2xqQWVXSU1IY3NEQ1RIRjFDQmV3NzdiQ3NHMWNzWndhWWpVWTMr?=
 =?utf-8?B?Ny9Hd1Y0OVFFcTBNc3l1QnJXSjU4MHJuZjdYUElhbjZYNm9aZTVVODhsMDky?=
 =?utf-8?B?ZzNwZS9wamdhZUZyUTg2UWZYRTZKUnZEY2tlMVY5M3RTWW8wSlhLQk5vTG8w?=
 =?utf-8?B?Uy9HWEJCK21OOWFHVnplczR0b2NMbkRzeE55QUZjUHRTTFJDcG1JcEw4TGpa?=
 =?utf-8?B?N1BrdVYzMWNzcWtPNTNHdFBpdlZsZFVMMkNOMGF4ODROSkFmNmxaZEpnQmpP?=
 =?utf-8?B?ZDFHUTlQdEFzMDlaNFoxK3g3djBIRWxnNUI2WGhWQzQ2d0hZZzNCV2swbjVW?=
 =?utf-8?B?OTZkaVFjdXRWN0NCWVdDblpjbmk1aDBySEswdHhUMlZQYXVFVXRiWTFjNUxM?=
 =?utf-8?B?bVk0eExuU1NQK0lmVVdZWHR4Z05mbzkySzhWaU1lZFRjT2dSMm1QL24rSXZa?=
 =?utf-8?B?ck16cVZMVUh4V204Q2pVbnE4aVFEUHlsVGtaWWhtSVpta3hvNmxOWDNwOXlF?=
 =?utf-8?B?NGdXRytmUlp2WXJaNlA3dUxVaEs1T3czaEtJRGtjS3pDYW5Nams1Ym8wOFNq?=
 =?utf-8?B?N3dLdW9DU0p4ZDVPOFhMMUp3dzAxQzA3bmFrZHRRQlN3NTJBNkRFa1pvb2Yx?=
 =?utf-8?B?S0dhc2Y4ckN1MkR5a1FBK3RkZjBGR25oUnZQeG90SEtvMkFqdldnMm9aSFdi?=
 =?utf-8?B?ZThlT2RxaVFXSFBUTlZQOFlxVXJzTzBoYU1saHBEenBOZUlFKy9NRVR6M1E3?=
 =?utf-8?B?Q04zc0xVcmNhN21ZbE94MDA4WWQ2S2RGTGVYTWpyZVRjVDJjNU1RVTdRVld4?=
 =?utf-8?B?elh1MXhXaU5sSEZPc0NqWjR2dk5mWmo3aFUxOXhmTnAzVFVDc0xnMkxjWVlW?=
 =?utf-8?B?dFNzWG1tc3FaaXVPdW5CbTVsY2gvYiszR0o5U3Z2U1dTYklTeDkzYmlodW5r?=
 =?utf-8?B?aDhNVEJlS3VhMU1idDBIOEFaelVzU2l3VlZhcWVCcW9FNkVoUklTWnAxQlNL?=
 =?utf-8?B?U2pXNTBOMURDZ0oyWnJpT0NTN2pvbGtXS3dqQ25qTUpiV1d2eEJuYjhaSUJj?=
 =?utf-8?B?alg5bmJpcXBCWjhiM3BEZE5RbHZicWQ5M3RVY29mbDJXRGY3ZytndEpjbEF6?=
 =?utf-8?B?RStoQzlkV2lNSEQ4cmNnVFRHcGdvYTJ2ZXZoQlg0Z2dOSjVMU2NEUkpKNmdl?=
 =?utf-8?B?bGhIazgyYWwzMVg3MDJDdm9HTkhvMk9BWHIvOW5JT3RXK3c1ZTdIUVAvaDcy?=
 =?utf-8?B?eXp1aEdCNWVxL2ZNbkhpcmtidWJtY1NJL3ZTa1VKb2h2aytaeE42QmlwcTNH?=
 =?utf-8?B?dXRWZHFyZHgrM0NKWVNpckNXeHJvcThFMVZrYmdyNE9mbnVDcFVOODVyQ0sv?=
 =?utf-8?B?cnVWWW1aamFUa3EyYThaYjA5dVB4TFJ2WEhHNVNRNGtKVlpza1NDamNIbVlY?=
 =?utf-8?B?TEhaWFdmVUZCTFA2RXBpb1hYTDVNR2Fld21VM0R0WklOVkFyMllhTEZYNVE1?=
 =?utf-8?B?Tko3b2VXZjlpQ21reWRLNWY5cUpqVFFpL2ZycGZ3R3VrYVgzRi8xa0tienVC?=
 =?utf-8?B?SWtvZm8yMnBJVE5OcTdNTnVabGYxVU5lUkVnSGk1YzJ0MjRjbFpSTzY1U2Mv?=
 =?utf-8?B?eE1pMEVlOHNPNzFPaGZSdlMwVFlsaGt2MnFoQ3ptMnd6U3FzKzFVVjJZTllk?=
 =?utf-8?B?enVUN1ZQVFVkN3lwc2F1ZnN3SnFNR3VXV2RnUjZlZm4wcVZKV3IxQjIvT2Jr?=
 =?utf-8?B?NWlpVDBRdURuYjFhQnJPWHRGV2JQK1FDa3A2RHR1N2RTaHNaOTFvaStXM1p3?=
 =?utf-8?B?eHFXRTlyK3NYbFJoWHUxRDMva0I2eFM4RDdPRWdxTXdTUkk5aUlpdmV2ZzFX?=
 =?utf-8?B?Y2pqN1QrZ2xKVHl6dUJzaGpuazYrNEM2T1V3eDVmSFJzaWZLOEhYUHpqQlhZ?=
 =?utf-8?B?SHlnWEg3N0ZyYUZSaWtjdE1xWFZ0aEkrWEZkMGdXQkxYUUQvSFh2Ty8yR0Rn?=
 =?utf-8?Q?Uc02Ef?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(10070799003)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a09DMHMzdXpZRGNzUCt3THVMLzFIVUlXWWdnK3pia3Jra09MQ0NuR1UxbTRF?=
 =?utf-8?B?NGczSWttWEpkenJFUitQTFEwMkowa1o3TkVsYTIxY2hCa3BIN0x3L1dBK1hC?=
 =?utf-8?B?K1V0dnRHZ0ZvZm5TeXpUYi9ybjNUbitWR3duamRUc284d0YxTmxzS3FlWnpv?=
 =?utf-8?B?aEppUXdIN3BTZGo2eHFsWlpxWW5rRU9LQzVlQ21BZHZxdXhZekNlakFkUGo2?=
 =?utf-8?B?cU9wODUrbE96Q2VuaGRNdEx2VUU3RXRHYUVXZHhtUVBqN3FXbUozcDZmUHFP?=
 =?utf-8?B?VHB5RE9GUEVncU56eU15TXVkZkhBb1k1Nk16dFdER2RhYmRRMmxZTGFWRFZB?=
 =?utf-8?B?T2ZYOHo5NlF3QUZsWjAzaExsenpGU0t5TnY0L2JzeDVDdlZndWN5VjBiNmor?=
 =?utf-8?B?UkxKTzNzTWU5YXFlSVJETVEzN2gzZ1ZES2Q3OTRQdjFjM2JGbHVHQ0dWak1S?=
 =?utf-8?B?ZmxFS1k2WGQzYUw0alV5eUVJWW1oYndibnRmSFRoVkw0WUJHRnY4NTlocmlB?=
 =?utf-8?B?djlqMnZJNE1teDJyL1NIMnZoeTJqZVF3em01eTlBZVlFK3lGUnAzZGNjK3hh?=
 =?utf-8?B?RndRWnphcHAwVXdXREZiek0ra2JtRWMyT1R1SkNxSng1bngyekI1TE8wNHJM?=
 =?utf-8?B?TGx4RXptUnI2Snd5bmptWmxUZjFKNGcyOVZUNHoraWVCYUw1Z042a2dYQ2lr?=
 =?utf-8?B?QWVHL1ErTGRLeDdIZ3Nhb1UyQmlhRlZnUnRhVjlxU3cwTGk2T1VqSkkvTWx6?=
 =?utf-8?B?UUdjYWhVK25XUUhXT09yVmN5VkUrWXI3UUYwYmpjRzBBaytzMEJvN1Jwd1Jj?=
 =?utf-8?B?WWg1OVY1RkdJMUovMU9nS1hZeWhPZUNNclNrQjhCWEtZVGJIazRuZ2VNSHA3?=
 =?utf-8?B?MllSbVU0aFlrTHQvdE9BTktaQ3pJQWpERlpXZU5GdjNuTDJ5aVRIRXlYR3ho?=
 =?utf-8?B?R1drSVN4UnFIcWdLQXdLb0NvQ0xNdUw4ZkhhM05VSk1XalpVSG1VRXJLZ3lE?=
 =?utf-8?B?aEJ4MlJ3OWVucWNoUGIxN2RtNmo2MStMWnB2ZVIwblBBSm5SZUpqMG1sOVRX?=
 =?utf-8?B?dEtIaWdmUG8vQ01pU2pkMkE2YnprM3NsU0hoUjM3MHo3YlhXeDdsV0FxZlNQ?=
 =?utf-8?B?MkRxNm5ZekF5Zlh1WXRTZHVabldiMWF3U3VzaDFkU3B2dXRtVVZVNzg3UlNC?=
 =?utf-8?B?UE01akRVdHpqQTFXL3M1dUsrV2VOOXNBMUY0L0daMis5bWdYSmlBV0FKajlP?=
 =?utf-8?B?R0NuVm5SRXBOMWppUkF0cmtNWHZVVW5NeUR4eCtIM2RRM2dtY0s4aytjUVpS?=
 =?utf-8?B?L2dBdkJDcHg1dll1M0M1YUhYNVVVdUIrTm5Qa2pabkN2TXlxSnltUWRaNUQ3?=
 =?utf-8?B?TEhmeDdpazg5YkxRczdUOWVYK2xoc0g2NmNhQ0YyL0tVK0YvWkFhQm9Rdlp3?=
 =?utf-8?B?ZEhBbm5JbmVsWTF6MUVOWXFnZW15clZ3cWl2V3lqYm8vbUltK09XWktKbnR0?=
 =?utf-8?B?TGFGY3Z0YjZYZU85NW56QW9vU1FDNit2eVFtN29HRDFqaDdnZHlCTkpEcE80?=
 =?utf-8?B?UlNyck9ybTRFUDBxdFM2dkNTOXJkTExQNGI3NTQ4MUF3TkVGUk01R2VEVkRa?=
 =?utf-8?B?M2NHUytjQ2t6TjVYZG90WlBqNEd0MjZDd1FCZWhPNjZrWjdBak1EWSswOHJs?=
 =?utf-8?B?eUxOaGpDeGQwRDlxOHB4NEEwZnU1eG5vQVNmZTJ5bTR2TzluWEl1NEgwQith?=
 =?utf-8?B?ZjdhV3YweXhWT3gzVldNMXJtZ1ZRNG0xcWhONVU0Ui8rTXRaM2pBejdiSXVh?=
 =?utf-8?B?blNnWkt6ckJDRlFsWnBYV3RPVE5yR3FqcUpoVm50cUp5S3RnY1FoSUlpaStt?=
 =?utf-8?B?b1BFSlNUTkNZVDhUM21OOHVaZEFLNWJ4NlUyRnhEaVVhRWtCNW9Jc1E1K2RZ?=
 =?utf-8?B?NUFGQU8vSHlYNWFoQllnajdUVi9aRkhSZm5ONS96NnIvck40bGdPR1EySi91?=
 =?utf-8?B?MVpReUlYVk1ORmNGeWdqWlc0cGVFeThWRDVzeUVPRlZLTXBBNTRVQWdkMkdz?=
 =?utf-8?B?UHBTK1k4YjlaaVh6dk9SV3Zlck54QWg1ZWpSSTZiemVaeFZVWkF4Sklucjg1?=
 =?utf-8?B?SEZHY1NIdHQxYWhTVXJNMW5LNk9Qc3BPcXVZbWtSV1J6Y2UzNXRGYjhJeFVv?=
 =?utf-8?B?VXpML2taTHl1ZkNVb2FTMENmdkk1RERjZzlxVlA1QmloWmlJbmVXZGhTdmpx?=
 =?utf-8?B?ektMRXh4REIvYzdKc1FENkkwa0NBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44E9314AC894D14B8D54D3BF96EA4F10@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/tyOOi981hUklFiSu3/HfVaJdSb1kX+efCLTE6aq/ZeUbwOf4oZNEwtUsj3ErndKO5bZQvkWDoluf3ehM65P0k2QIPQ1L3o2IqJ04dsKKoNSCNbAoFxsPcvsuu2BMEeUZ2kEz6da78Y9RmHjhPYg0oL+LZ6LIpg/UVXy6u6wJwg7Dj/kZy2CBFIP1hJkplQ7j0LJQAkC1+rG4L6cOdDDPXoWCTRrlBxAGmn4lK+xi1qk2n90WtHJ+Nlu5oRUOit+x7vTC7HYC7oArHOvcz0nFITLuSyiqjFDTsMne5AmRGuyhR3FFAFoMTXBWfJcik+6bgud/dlT4rUSG13BCSwIQvgxFIn1/Iiorw+QHRq088Q6PSadOR/4P877npLwq6L4walXCjUkqFIWqVZgMSoGmRUFbwdgJDK+53wlPIueREHHkLQgofLanHxBRWKfmR6myPIjGqIbHpUHB28F0cSBECJgFlrKNDhF/Y7WJ0PHDPWajuEPZc+eaRnf8H+RRc1t2yJcD3Zhouqx44WBwQ1pug7MY/7O6yd3e3S4aZXw7hOBUqix1Gq1aWB4K2Y8FFva2B5Lw4m2GLss/AQEfVC0aYFuumhFdEAT5H4JmdRG4zOK8K/OxzVQ2ZSqDXZ2Yp0w
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c836d4-c4f8-4242-d5b5-08de0a250523
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 06:52:04.8892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0hRzVrIIgDIdCM02W7k9XUluBY0RwpBxDtDP90IjG4tqti33HCQyoOfwJNWRoxyambqNUdXq74PGlOGkItCbiRQN0w5ssKJ70OOcFTLxdhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6646

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

