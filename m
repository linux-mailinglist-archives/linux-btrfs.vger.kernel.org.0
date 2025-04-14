Return-Path: <linux-btrfs+bounces-12990-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E87A88437
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 16:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AF5B188A553
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 14:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5725623D2BF;
	Mon, 14 Apr 2025 13:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="fAww/TFe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011025.outbound.protection.outlook.com [52.101.129.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6651253941;
	Mon, 14 Apr 2025 13:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637699; cv=fail; b=qqRgnpjClRGaxQ/LkQ3T7zQvYk+VT1G3tmGdgv8e9pgpzcD/qs7wNh6GLiDSeCmmNjEitq9mB9V4U5THWU5ALgfgPDngFbUaPAqjWXw/sm6XPFWeErFix6Ft7YMCPtagLu9bHIjyYmnKQ5AlOqZC72ZqNIyXGGUIwyfdbmAb9EA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637699; c=relaxed/simple;
	bh=rscZi8r7STK3azsWmKAdAgFsYNcHIxhcauxfc+k1bjk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gDPEkzmaDYBI5Z7dl9XhS+yQyUxzk9kXizLcUaeHrXtnIAcsjHL7oMm4Pl7YzTh4YNTkN/2KVgytq74rWSF2blBcfTTqECth1dpYZoGDeeQi7SonZBMnQbur1hFhBB/DIUei0UY28JAdICtK5zC7gMqC5CNNrwLLphp/yrNzVPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=fAww/TFe; arc=fail smtp.client-ip=52.101.129.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uSCuGKbTh3qNBDjF+UT700x7GhDPoM5PEzp+f8qEBpVGKi9eAy9gfAPOyri0GWxb7WoVxKpwn9YyC+tANgQPJry9OFhKRfK/uljtsf2uhdfsZ68UWpY1OgltawV59FYJopF/x8vx4q1X0p4f2tCGmkbLm5UGknI8ijVBaDPrW+vVjwfgYS2mzBbYiy0/guOECp71Byd0aAzkKRwu0cy03Uruhycuogaih0kVcmhw6iw6PgzRlW7MJuPxJsuh4+yebyaJrh3e8g8mPlmb9vivszTI6hRCyqnlyuonikXJLX4lYaTzslMiU1NtAfuCUFhEX0tjyzOuZ585l7HcoUaAPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rscZi8r7STK3azsWmKAdAgFsYNcHIxhcauxfc+k1bjk=;
 b=MBHGO8rPU3TOVaZtzJBMNwko17uG6sEoCRwrLsrlfXG0sqF93mnc/eV67fLNUK+zCjuo6Khd1u80H8liBedWCWRnGS0pFi+IxiBSnJHR/uqxtyPW7WGJCqUgLtb86Tnj2WS2wMA1rE+IywClQM5KdPq83mpY1JTXHiV+zh9OcvJGr79UMFhyZfciwEL0U3OLoEO6i0yaTqcc8I8NliS1S5c/wrlIc1ej8OEWw8ncY5dMSnX9Lakedst84aGOyNQfvuaeb5OWYQbq/sjMfJOrDhOy3vD3JctC+BFgXt7aeNxZZMFkpzztKseAHRWBAeEx5tobLVASeL7Z0JZalrAo5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rscZi8r7STK3azsWmKAdAgFsYNcHIxhcauxfc+k1bjk=;
 b=fAww/TFeT1XjtWmOelU34Vmz22A/Du16CCsfwDCYktBY/KtVTRTflW5kLQk/xznjpXz43eCbkCIv1axCbAl/x5IYi3H1dbSnUkhwMjYd4hIq/tcCyvycDj1jbr0r6mZStdoBNIC69xlO6bXNYcmK1OG6uvS8A3twrKf451Pp2FnQGEP7ex7X5xI1UvWUdel5UB6sWCygCkdseOvNPEn7ficuUItaU/TJBnM5ThgrycoYQDoIucycJjGOrCLTvuIgNMd1xTca9kKJ4TOWjioLg0xeJLVCc3TN/sTZysPnZ6jvF6rgC+oglHi+hCEBoAs81XWQ03k7gd5qCd8SNvAPKQ==
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5716.apcprd06.prod.outlook.com (2603:1096:101:ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Mon, 14 Apr
 2025 13:34:50 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 13:34:49 +0000
From: =?gb2312?B?wO7R7+i6?= <frank.li@vivo.com>
To: Daniel Vacek <neelx@suse.com>
CC: "clm@fb.com" <clm@fb.com>, "josef@toxicpanda.com" <josef@toxicpanda.com>,
	"dsterba@suse.com" <dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIXSBidHJmczogdXNlIEJUUkZTX1BBVEhfQVVUT19GUkVF?=
 =?gb2312?B?IGluIGJ0cmZzX3RydW5jYXRlX2lub2RlX2l0ZW1zKCk=?=
Thread-Topic: [PATCH] btrfs: use BTRFS_PATH_AUTO_FREE in
 btrfs_truncate_inode_items()
Thread-Index: AQHbqpFIg9HIbLnZH0irURSLMAJ0/7Oeg9IAgASqZFA=
Date: Mon, 14 Apr 2025 13:34:49 +0000
Message-ID:
 <SEZPR06MB526928EBDA13B6463D7EE00BE8B32@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20250411034425.173648-1-frank.li@vivo.com>
 <CAPjX3Fe34HVF2JUi2DEyxqShFhadxy7M7F6xTA_yVn5ywHMBhQ@mail.gmail.com>
In-Reply-To:
 <CAPjX3Fe34HVF2JUi2DEyxqShFhadxy7M7F6xTA_yVn5ywHMBhQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB5269:EE_|SEZPR06MB5716:EE_
x-ms-office365-filtering-correlation-id: d3ddad67-0375-47f3-011b-08dd7b592145
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?eWVnT2RlVFp1Z3VTcmpjbFdJNzVJNXpxMnVIdkNadTFnR2tXclVGdnp0d1FG?=
 =?gb2312?B?SVp6aXNvdjYxbmRPejFpL3VQNjNzTFNNR3NXaXRJNUt5VVhDcXNtK3RTd0po?=
 =?gb2312?B?V1Bsa0ZrZHpvREp1NDJUajdIV3pBdzQ2MTdnZHNpWlN4WnQxbG1VdmRmZHY1?=
 =?gb2312?B?dlQzR09jNXZ0dW1YTmtENGkrZ1kzOVVIbnhWT0ZPRWVkNjVyRGtnUTc2bG5K?=
 =?gb2312?B?R0JDUFFQSHc0NlV2NmkvM2pBU0ViS3J4NnNLOTlvZ2dxLy9YSlFPS09PeUxF?=
 =?gb2312?B?UGxVZG9SNkFCa2hJQ2dic3NYTEEvRkE3eUhMcWtNL3pJdThKVFo2L25yVFVC?=
 =?gb2312?B?UG4xcWJsM29Gbjh2THZqYmpxekhZeHVja0VaaHJNbm1oOFV6dWhSc0FxT2hh?=
 =?gb2312?B?NE1YU1ducms4V2FqZHZnWmQ1clBzblRSM25xMmpuem1WdHRrNHFvUnAvbmZR?=
 =?gb2312?B?V01SOFBBajJVS3hnWHRxSzhYc25UaWJHbkJQeUpzUzRHdzVOWDExYUU2VEt2?=
 =?gb2312?B?K25PTnVuT0hyM1p6aXRTSGZJZFczZGkzdkNWK1ppbWdvd0VSL3dxWVdmREtp?=
 =?gb2312?B?K2ZiSUl2UHk0UVFvVDZBL1BXcUU3QlQzVFErNEFzU3p1UTlCU2g4ZGZRaHZm?=
 =?gb2312?B?emM4MWljSHhHOFIyc0ViT1F3R1hqWFdNdmNVMmtOc2NMV2cwY290SVFnTkJ3?=
 =?gb2312?B?c05MT3ZUWSs5emtQMzRxZHcvd3V4eDVMN0szbUNyejlrNjNjSVlaRGI0ak1I?=
 =?gb2312?B?ZnhKWjc5NEJZZXh3RE54NWRDaEp3UXV3cGV4b1F0WG9UWDhJTkhIZmtEV1Zx?=
 =?gb2312?B?VFJDRVl0dWF2UUxMOFdBQzVFaFR2VUR5c0ZsbVBOV3N2bHJuYnlvbDQ0a1RB?=
 =?gb2312?B?eDdxN2psdXUyUVNTZnBXbXFnbzd0RWRTcktoR3kwSjN4MWpFN2pOazV6RUJy?=
 =?gb2312?B?cFVwR3pDblJ3RjBoSnkzcWQzeVpramFEakJGc25KdWsxWTMyVjVCYzhXRHRq?=
 =?gb2312?B?Z0ZHRTVxN3pKcE5HUkFvMWxPdWRzU3Z4U2JkQThvd1h4anFHcG5PaVVXbFRE?=
 =?gb2312?B?OE4wdFVKc29TUSthdnhSalA4clhJNlJ3Q2NtaGJJNnFHWEFGSWRTV3hlRjBm?=
 =?gb2312?B?ZlU3Y1J5aHQ5VWpXUG5Jdlo4VUUvVW1Yd1NVR0pYZUE0ZHliYVAyOExNSlpv?=
 =?gb2312?B?L20rV3ErVDZHVVZsalNGbUJGTVBXd1IwM1VTVzVzdEFnS0NmSllXdmxTOGlN?=
 =?gb2312?B?aDE0aE9TbFFzZ1RMSGRtUnFkZjB6b0x4alVWekV4OFBhdDJ2V2x4bHFXRFhU?=
 =?gb2312?B?dWJVT2ZpR081S2hnMGFzZmVpV0F3TkNrM2Z2bVJBU0xEU2JwZ1JTUTcxUzFU?=
 =?gb2312?B?aUsxU2o1RWh3ODVkQUlvSGZuSkd3T2hhMUd0anJsbU5pNXNObDVRYTBJWWRs?=
 =?gb2312?B?OFp0NmZHOVRFb1pJNGt5RmJOUWpGQ3o3TlpGbzdTckl0ekprZUhNWGE1bTkr?=
 =?gb2312?B?U3ZKMldhSEVveXFhU3A1dzdndGZVeVNhZnhyRVNkTHppeW45dnVQcGw2dVpQ?=
 =?gb2312?B?dUUyTGlKT2xDYmh1N2xjTTBGenEwUHVuUStsWnh4MmVpaTgvbmYwY0MzZytI?=
 =?gb2312?B?NmtFdSt3R08xbjdDRzBBUDBTOG82a3Q0QStzczE2NDcyVHQ1eSs3elZGaEh4?=
 =?gb2312?B?d1dFU2puQnR3RHFEc09SeUZjME9kS2dVbkRuRFZkamlUQ2dxQy9HRjhUU0VF?=
 =?gb2312?B?OXB2R3ZCS28wclJBMlB4aE8xYlFKTlZldXJqSTBRR1ZLcmo2b2dNZnpDQmli?=
 =?gb2312?B?RS9Fb2RQVmFYQmlENXV2ZFRBbE01eHRJeFA3MVBsSHQ3OGdsUXIxVmNSRGdC?=
 =?gb2312?B?KzZ2OVpNVlR0QU4vUVNuNGIraDZQNDNWcTA5Q05Ia01nVFNhU29sZVVIaGxu?=
 =?gb2312?B?aGQ1Q0l6dTZ4UVdRL1BIUGxPaTlmcnlOZkVkWFVYWHNRb085b2ZLVGpDTUJR?=
 =?gb2312?B?RUJXSWtwVTdBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?YW52WWNWMjJEWWVWYVIrMW9Wcy9lSUVtVmN0MkJLTkZxOS9SVEhYandjaFVU?=
 =?gb2312?B?RStEVXhuZzMrN0I1dVR4bXF5VTFoRHdPZTVWNnVLU3FCcjV6YWV4aTk4alJL?=
 =?gb2312?B?SzdCbDNIYmNFWkNhcFlWSk1kMzBqSlVXVm1UQXFac1ZVZXJ0ZW9FbDgwb1Nz?=
 =?gb2312?B?dlpNRGU5bndUOWpGYVZoYlUvcEFsSUdtd1VWZEp4bXlDRFQwemtpSDNvVW1a?=
 =?gb2312?B?cnNhWHdzRllUS2xIbVMweXBMQ3F6bjQza05obm40RWp2OGN1Qk5xeHFvV2dh?=
 =?gb2312?B?K3JkM3BxUHhJUGJOWkpMblNJZjdmQmUyNWgySjgxeVlNTTcvNmNWQUlLdG9Y?=
 =?gb2312?B?c29hdnkyMUl1c2FVYlhwVWM1UFZ1b3JMa040bjVwSlJXK3cvRzdvcy9TZDVJ?=
 =?gb2312?B?MkdWem5oc0FpdmYxQ2hqWDhFc2RCcHdFMWNFWm5SaWJZbmxLZlJKR0RyZ1NK?=
 =?gb2312?B?bFFDMTdOSVFrU2NNNDg5VU9qZXprTkFlbXMvSFQzVkFBVmh4bVVVbVFyU1Vk?=
 =?gb2312?B?a05EdjVyamlpTXhvc2dxcDViU2E3dk1TV0U4eWpoS0NzLzNmS2Q5Z1JCdER1?=
 =?gb2312?B?OGJZSU52Vm1ZNnN6aHZCK1lJQlZoNUhQVjhCTzlBb1dOTWhaaWhtRksxRTN3?=
 =?gb2312?B?V2s1NzczcjdiSjRPdWhjTERlb3FXWFoyS2sxNGdKdHdxcFhuTUxPYS95dTI3?=
 =?gb2312?B?WkYxb0JzZFBoNUxPcWRCRnVLN1NhQnVhY2VJaTJZaWZVOW9vNUZkVzBjb0U3?=
 =?gb2312?B?cDdVNEVkeEhENjQwZjlybGJtODJxNUNTdEY0SnZFazJzU3psTStOQ01NUW5r?=
 =?gb2312?B?eVBzdE9jcG5KUGVkQ2EwRkhRRXNDSE1kc3RaRGEwZUlRaHJQMmxwSkdNKzRL?=
 =?gb2312?B?R3dhWEcwT3Z3ZVZ1OFdrYm4xeTZKNndQNVRRanVCWW11OXRkZzN1K0VVT2Qr?=
 =?gb2312?B?Qlc0RkFMWEFPa3VyNWgyaDhzWDkyWm44dUNpMFlhTGhVTzBNTVVsL0N3U05K?=
 =?gb2312?B?Tk5BWVlMV3pwRWMyQTh5WDk3UzNPRGI0bDJZMjhobVNnQnR6TzhwODZyN040?=
 =?gb2312?B?R1pKWVBGSnkrVS8yT2VTR1pSbitORFJyY0h1azB5TjZ6TFpRek9qQVd0VUo3?=
 =?gb2312?B?Q3ZObDBZYVZmU1JHSXY5cHJmamVYam9mT0lUT2pHcnQ5dkVGRittT1ZSaHpK?=
 =?gb2312?B?VkNhdnVNblRlVlVhSkF4cW5aekhvN1hVaUZYcHBpVUdkU25yam1KTkZ0aEI0?=
 =?gb2312?B?NkM4S0tiSDl0eUNKd1BiMHZGUHlDWU9HRXBxdUFzSmhtS3ZjK0QrMEZ3UGY3?=
 =?gb2312?B?V3ViSXZ3VytoZjFpWW1UeHdFWHo4S1R1N2pDblFYSnM3WFdBQVhiVS9WN3Ax?=
 =?gb2312?B?c0E0NFVVam1YYThNYWluNjZaR0EyVEo1QlFNTzhCd25ScTU2QnEzVzFDYUdZ?=
 =?gb2312?B?TzBEdTBEckdMNnZFZ3RqZTc4TlZWL21YeU4wdzRhaGxWQ2tVcTBJVGhLM1Ri?=
 =?gb2312?B?Y2FrblRDSnFPclBHMnhzREk4ZHdiS1B4VkFHaHF3THBoeUlmdHN5R0VvQTRj?=
 =?gb2312?B?b2MzbStwV0JCclk5TW5YdDh3TVFWRzVMT2s4U2VhNE5iWVJlSXZyeGhGaVVz?=
 =?gb2312?B?Z1paeitCb0FiekhtSTJxY2dhWDR5QVdWSXZOSEV4V1Z5dnFlUzNab2hFeHZ6?=
 =?gb2312?B?STV3ME5CQ2t3QXY5MUFTTXB1cnBJcUkrMmlDMG52Qk1xZ2JBZnlycnN3Q3hD?=
 =?gb2312?B?cTRBbVhNVytrMmJqWU5IRlB3eGVQb1FYbkdJV0hZVXAvZExFeGhCalVxRkxP?=
 =?gb2312?B?YU01dlh3K1dwdVNQdVBpMDNENmUwV2tvUnhoMXV6Q21HYWkyUGx4YU03eVhh?=
 =?gb2312?B?aTlsYjliQW1HZi9IWGtrcG1mNGJmYWQrVVA5eDdxNHRCd0Q5bDZ0NW1Jc09a?=
 =?gb2312?B?K1B6RTdjUE5HQjhjMHliSEJmb2E2eERMemFwVW5Ya1B5TmJ3d2tIZ3pzTDgx?=
 =?gb2312?B?ZEtNQVNoV1l3bHM4cjJoRGlneCtzejlVcW5kd0xzVDBWYnM3dGh2aldsZ05i?=
 =?gb2312?B?S3MrSEYvTFh5ZVM2dmxwcFJtUDAwTFcydTZiYm1QdGpxbVByRHUyUHhwKzdZ?=
 =?gb2312?Q?6Xgk=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ddad67-0375-47f3-011b-08dd7b592145
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 13:34:49.6348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3PDBagUQpx//ueM7B0G3x51ypbpkTgg2vDL1N21mNQsM40PoahNg86KRGvteb9rT7Sq8cth8EWB8oxDbvREQTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5716

SGkgRGFuaWVsLA0KDQo+IEFuZCB3aGF0IGFib3V0IHRoZSBvdGhlciBmdW5jdGlvbnMgaW4gdGhh
dCBmaWxlPyBXZSBjb3VsZCBldmVuIGdldCByaWQgb2YgdHdvIGFsbG9jYXRpb25zIHBhc3Npbmcg
dGhlIHBhdGggZnJvbSAuLi5faW5vZGVfcmVmKCkgdG8gLi4uX2lub2RlX2V4dHJlZigpLg0KDQpJ
IG1hZGUgdGhlIGZvbGxvd2luZyBjaGFuZ2VzLCBpcyB0aGlzIHdoYXQgeW91IG1lYW50Pw0KSSB3
aWxsIGRvIHRoZSByZXN0IGlmIHRoYXQncyBvay4NCg0KVGh4LA0KWWFuZ3Rhbw0KDQpkaWZmIC0t
Z2l0IGEvZnMvYnRyZnMvaW5vZGUtaXRlbS5jIGIvZnMvYnRyZnMvaW5vZGUtaXRlbS5jDQppbmRl
eCAzNTMwZGUwNjE4YzguLmUwODJkN2UyN2MyOSAxMDA2NDQNCi0tLSBhL2ZzL2J0cmZzL2lub2Rl
LWl0ZW0uYw0KKysrIGIvZnMvYnRyZnMvaW5vZGUtaXRlbS5jDQpAQCAtMTA1LDExICsxMDUsMTEg
QEAgYnRyZnNfbG9va3VwX2lub2RlX2V4dHJlZihzdHJ1Y3QgYnRyZnNfdHJhbnNfaGFuZGxlICp0
cmFucywNCg0KIHN0YXRpYyBpbnQgYnRyZnNfZGVsX2lub2RlX2V4dHJlZihzdHJ1Y3QgYnRyZnNf
dHJhbnNfaGFuZGxlICp0cmFucywNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBz
dHJ1Y3QgYnRyZnNfcm9vdCAqcm9vdCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBzdHJ1Y3QgYnRyZnNfcGF0aCAqcGF0aCwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBjb25zdCBzdHJ1Y3QgZnNjcnlwdF9zdHIgKm5hbWUsDQogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdTY0IGlub2RlX29iamVjdGlkLCB1NjQgcmVmX29iamVjdGlkLA0KICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHU2NCAqaW5kZXgpDQogew0KLSAgICAgICBz
dHJ1Y3QgYnRyZnNfcGF0aCAqcGF0aDsNCiAgICAgICAgc3RydWN0IGJ0cmZzX2tleSBrZXk7DQog
ICAgICAgIHN0cnVjdCBidHJmc19pbm9kZV9leHRyZWYgKmV4dHJlZjsNCiAgICAgICAgc3RydWN0
IGV4dGVudF9idWZmZXIgKmxlYWY7DQpAQCAtMTMxLDcgKzEzMSw3IEBAIHN0YXRpYyBpbnQgYnRy
ZnNfZGVsX2lub2RlX2V4dHJlZihzdHJ1Y3QgYnRyZnNfdHJhbnNfaGFuZGxlICp0cmFucywNCiAg
ICAgICAgaWYgKHJldCA+IDApDQogICAgICAgICAgICAgICAgcmV0ID0gLUVOT0VOVDsNCiAgICAg
ICAgaWYgKHJldCA8IDApDQotICAgICAgICAgICAgICAgZ290byBvdXQ7DQorICAgICAgICAgICAg
ICAgcmV0dXJuIHJldDsNCg0KICAgICAgICAvKg0KICAgICAgICAgKiBTYW5pdHkgY2hlY2sgLSBk
aWQgd2UgZmluZCB0aGUgcmlnaHQgaXRlbSBmb3IgdGhpcyBuYW1lPw0KQEAgLTE0Miw4ICsxNDIs
NyBAQCBzdGF0aWMgaW50IGJ0cmZzX2RlbF9pbm9kZV9leHRyZWYoc3RydWN0IGJ0cmZzX3RyYW5z
X2hhbmRsZSAqdHJhbnMsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICByZWZfb2JqZWN0aWQsIG5hbWUpOw0KICAgICAgICBpZiAoIWV4dHJlZikgew0KICAg
ICAgICAgICAgICAgIGJ0cmZzX2Fib3J0X3RyYW5zYWN0aW9uKHRyYW5zLCAtRU5PRU5UKTsNCi0g
ICAgICAgICAgICAgICByZXQgPSAtRU5PRU5UOw0KLSAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0K
KyAgICAgICAgICAgICAgIHJldHVybiAtRU5PRU5UOw0KICAgICAgICB9DQoNCiAgICAgICAgbGVh
ZiA9IHBhdGgtPm5vZGVzWzBdOw0KQEAgLTE1Niw4ICsxNTUsNyBAQCBzdGF0aWMgaW50IGJ0cmZz
X2RlbF9pbm9kZV9leHRyZWYoc3RydWN0IGJ0cmZzX3RyYW5zX2hhbmRsZSAqdHJhbnMsDQogICAg
ICAgICAgICAgICAgICogQ29tbW9uIGNhc2Ugb25seSBvbmUgcmVmIGluIHRoZSBpdGVtLCByZW1v
dmUgdGhlDQogICAgICAgICAgICAgICAgICogd2hvbGUgaXRlbS4NCiAgICAgICAgICAgICAgICAg
Ki8NCi0gICAgICAgICAgICAgICByZXQgPSBidHJmc19kZWxfaXRlbSh0cmFucywgcm9vdCwgcGF0
aCk7DQotICAgICAgICAgICAgICAgZ290byBvdXQ7DQorICAgICAgICAgICAgICAgcmV0dXJuIGJ0
cmZzX2RlbF9pdGVtKHRyYW5zLCByb290LCBwYXRoKTsNCiAgICAgICAgfQ0KDQogICAgICAgIHB0
ciA9ICh1bnNpZ25lZCBsb25nKWV4dHJlZjsNCkBAIC0xNjgsOSArMTY2LDYgQEAgc3RhdGljIGlu
dCBidHJmc19kZWxfaW5vZGVfZXh0cmVmKHN0cnVjdCBidHJmc190cmFuc19oYW5kbGUgKnRyYW5z
LA0KDQogICAgICAgIGJ0cmZzX3RydW5jYXRlX2l0ZW0odHJhbnMsIHBhdGgsIGl0ZW1fc2l6ZSAt
IGRlbF9sZW4sIDEpOw0KDQotb3V0Og0KLSAgICAgICBidHJmc19mcmVlX3BhdGgocGF0aCk7DQot
DQogICAgICAgIHJldHVybiByZXQ7DQogfQ0KDQpAQCAtMTc4LDcgKzE3Myw3IEBAIGludCBidHJm
c19kZWxfaW5vZGVfcmVmKHN0cnVjdCBidHJmc190cmFuc19oYW5kbGUgKnRyYW5zLA0KICAgICAg
ICAgICAgICAgICAgICAgICAgc3RydWN0IGJ0cmZzX3Jvb3QgKnJvb3QsIGNvbnN0IHN0cnVjdCBm
c2NyeXB0X3N0ciAqbmFtZSwNCiAgICAgICAgICAgICAgICAgICAgICAgIHU2NCBpbm9kZV9vYmpl
Y3RpZCwgdTY0IHJlZl9vYmplY3RpZCwgdTY0ICppbmRleCkNCiB7DQotICAgICAgIHN0cnVjdCBi
dHJmc19wYXRoICpwYXRoOw0KKyAgICAgICBCVFJGU19QQVRIX0FVVE9fRlJFRShwYXRoKTsNCiAg
ICAgICAgc3RydWN0IGJ0cmZzX2tleSBrZXk7DQogICAgICAgIHN0cnVjdCBidHJmc19pbm9kZV9y
ZWYgKnJlZjsNCiAgICAgICAgc3RydWN0IGV4dGVudF9idWZmZXIgKmxlYWY7DQpAQCAtMjMwLDcg
KzIyNSw3IEBAIGludCBidHJmc19kZWxfaW5vZGVfcmVmKHN0cnVjdCBidHJmc190cmFuc19oYW5k
bGUgKnRyYW5zLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaXRlbV9zaXplIC0gKHB0
ciArIHN1Yl9pdGVtX2xlbiAtIGl0ZW1fc3RhcnQpKTsNCiAgICAgICAgYnRyZnNfdHJ1bmNhdGVf
aXRlbSh0cmFucywgcGF0aCwgaXRlbV9zaXplIC0gc3ViX2l0ZW1fbGVuLCAxKTsNCiBvdXQ6DQot
ICAgICAgIGJ0cmZzX2ZyZWVfcGF0aChwYXRoKTsNCisgICAgICAgYnRyZnNfcmVsZWFzZV9wYXRo
KHBhdGgpOw0KDQogICAgICAgIGlmIChzZWFyY2hfZXh0X3JlZnMpIHsNCiAgICAgICAgICAgICAg
ICAvKg0KQEAgLTIzOCw3ICsyMzMsNyBAQCBpbnQgYnRyZnNfZGVsX2lub2RlX3JlZihzdHJ1Y3Qg
YnRyZnNfdHJhbnNfaGFuZGxlICp0cmFucywNCiAgICAgICAgICAgICAgICAgKiBuYW1lIGluIG91
ciByZWYgYXJyYXkuIEZpbmQgYW5kIHJlbW92ZSB0aGUgZXh0ZW5kZWQNCiAgICAgICAgICAgICAg
ICAgKiBpbm9kZSByZWYgdGhlbi4NCiAgICAgICAgICAgICAgICAgKi8NCi0gICAgICAgICAgICAg
ICByZXR1cm4gYnRyZnNfZGVsX2lub2RlX2V4dHJlZih0cmFucywgcm9vdCwgbmFtZSwNCisgICAg
ICAgICAgICAgICByZXR1cm4gYnRyZnNfZGVsX2lub2RlX2V4dHJlZih0cmFucywgcm9vdCwgcGF0
aCwgbmFtZSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBp
bm9kZV9vYmplY3RpZCwgcmVmX29iamVjdGlkLCBpbmRleCk7DQogICAgICAgIH0NCg==

