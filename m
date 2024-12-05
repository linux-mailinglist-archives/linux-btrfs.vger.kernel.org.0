Return-Path: <linux-btrfs+bounces-10083-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8733B9E6181
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 00:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F7A18850B6
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 23:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93C11CEAB4;
	Thu,  5 Dec 2024 23:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="j7l+s19Y";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LdfFxgav"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ED91BC063
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Dec 2024 23:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733442545; cv=fail; b=S1aTEGyR5tkrt9ieMfZ6xKfIbT90RqTMb8rToWx6zl6g/hK5CfeXbRoBfsBYTdv8MDBIU/BKSaDQcXgRWwl9Rp7tFq+k4RUASRSnF//oAsUmLxK5UWeioKH9dxOrXw8BhH4/ToLQXEq/S7535BOXywlWDLMw+Hp6mAfIIKjLm6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733442545; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NUBA1yM9hGfpBS/ZVANcsAovXfgF1oOlS0ZVqZKtqZh2y3qrGpq40VOIehjDDCYiqIo3qDUta+FwVtZlYECVTnAkeh6/wJCn1kbH9rZd8JExcg2MjVp9O4epm7YXhV9J0jAqKJg44Ck2nBlYVlZxH+PZTPYFZxa7cwIkjklKN3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=j7l+s19Y; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=LdfFxgav; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733442543; x=1764978543;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=j7l+s19YGocJF/EdXEbw19551p1in3Pvnoz5OH/H4YTgKX9J+sF/tppN
   fBwF4XWh7r8EogHgw4Z9XHtNTwKfSO1d5V6gCs0vk92Uhc+BefJ0MpFli
   ydzEnqV17jr/lOk6vmBE6Q5CyIORXiLRrBhkcfWosOgNGohz2yW88496V
   uW9vD24Am5CHF/IhXJZhgJ7aqU/w4cpOjsf3T/3dnFMaqnsGFl2DBCo4c
   OYZogi1aKV+XGipfMVapTMwLweQK743eV5RLcg7rN4pzH2lW8lUXX8KDY
   moqZ5HbrkDmMTs9DHJiKuU1tOTzJEHRUiifcrlFSZb/H8GWBZSDY7Eo/1
   A==;
X-CSE-ConnectionGUID: o3RpRHi6Qdyb795xYNVw8g==
X-CSE-MsgGUID: d//cYoUdQgSEQ0waj0p9EQ==
X-IronPort-AV: E=Sophos;i="6.12,211,1728921600"; 
   d="scan'208";a="34221463"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2024 07:48:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYAhtNsJENWyNyxCEErdBpAKlRHhVzYifZRgeBw69sVa599P2NTB2MgzsJtrHjNQ8HfJeu9J7BSqaw1aPDOC3UWWPxJJ+QHOAaAF9PqZdOG55qI8T58j3O9fgf5/2a5FQL4q2B/wAZKvnYnoJKwpBIrGWD0/ocOyo1/vDNcSkOWVxymuZhvftfPFJh7ClvzHE39q7D4m1jwpLRzWeblNBznD3oHVK9LJNQVqPg3wE1v5+XEYCgeuG99JYc1ggjPo0tR+crJItNUQyNW25DSKWTlNdgTzsggl+ssjhBGSLrRcqqsAsX1NVz1jMqjHcZb1Zh1GYDAnbOaD8+OHUrJhxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=i6Se4iFd0YTj0ZY9vBEvnQVIPW/mN6tyLDRv6WC68d1lMo7jK870yjq++XgoIH36x09iHkFgoRoJWCYLSC3gk8BZaOUKm/W8ZP8VgcSbutpBdNktZW/Z2oWbj9WYXmGFpr0VG3JLDDDCsVZVwxVCnHOHEp+bIeWlezrXDmC7UBPAAPHr2UB/0wIIORfGJNnVG6S8pU0E6rPQFpSBZWk65zkDaGGuKQA36riiTBRDMpH4A6+22FdKnE1xTbLf86vSJL2nMnayXWByYAGBsIkmr3tZmAe/HjehObPBOXq3utAvtMSZuQfBEaAYYtuM2x6kuco1joilnl32sLUhs2DiCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=LdfFxgavBox1+oiQc8G8lP5SnlID38encnqWnhS2Vr1r3KqeRhyeUDyKPzuVHlHxq7nRMYNZNGGXqdxP8AnsWjSTPfkL2rwxPpg2I11b1Fp7H4+uDZ4cTwB63RZ08pEdlZscIF+rm5oCTk+EpKNK7XvYhC9mSDOcAPaRwV/3DmU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA0PR04MB7324.namprd04.prod.outlook.com (2603:10b6:806:ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Thu, 5 Dec
 2024 23:48:55 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 23:48:55 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 01/11] btrfs: take btrfs_space_info in
 btrfs_reserve_data_bytes
Thread-Topic: [PATCH 01/11] btrfs: take btrfs_space_info in
 btrfs_reserve_data_bytes
Thread-Index: AQHbRuplol1dn4vMx0+yLBYEehqdMLLYUqcA
Date: Thu, 5 Dec 2024 23:48:55 +0000
Message-ID: <2176f24d-bb26-4cdd-87f5-1af029e8a5c9@wdc.com>
References: <cover.1733384171.git.naohiro.aota@wdc.com>
 <c6184ce683ff003641bc7177ba958121156461d7.1733384171.git.naohiro.aota@wdc.com>
In-Reply-To:
 <c6184ce683ff003641bc7177ba958121156461d7.1733384171.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA0PR04MB7324:EE_
x-ms-office365-filtering-correlation-id: aa21682b-396a-464a-c024-08dd15876139
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Smluck1vRkMzMWFSU0xTWHRsNWlOcDZHdjdnckZOYnQ2cUlMRVhvaStVS0pm?=
 =?utf-8?B?VEZkRTd4N0M2YzJqa1l3SC9xOXVRWkpEa3hpNWkzd2FiSUNzY08zNXhER3I3?=
 =?utf-8?B?OVM3NHJPYUJ1bFEvbTBSdExIQ1MzMndYaTlKdHZMNFhuN1g2ZngvNWtzTUFk?=
 =?utf-8?B?eDBEOFFGdHdaVGVLYWdzMWsvbC9XUzVZNXYrQm0rbzJrRGFWSG5pQTdVc0Fi?=
 =?utf-8?B?R05yWC9pd21tcVE0UFVVWTVhWFc4SS9jYklWL3d4a0ozTXQ4a05FYUI3SlRh?=
 =?utf-8?B?MGRlTStidlBoaXBkdHZHQ3lSSS9kbko3b1Qrb0lLZ3g1YTQ4Y2M5U01nbzBz?=
 =?utf-8?B?Nm1mWUc3cm1FTzI4M004WkpuZ2JVdXZXaFJRcWpZeWI4bHNjcnZjZElJcjlw?=
 =?utf-8?B?UjJyeUJzYysvMjZqVmNCRHpZU0NVcWVtQWNjQmdsUVA1ZGw5dzcxbXlDbEl4?=
 =?utf-8?B?M0ViQnBtRWZ5d1lyb0tUS29SQWJxNmhDSnI3dy93dm5MRjJiWGdXMVJkZ2NG?=
 =?utf-8?B?Smt2ZG0zVXRseUUrTGY3aXZjY1ZuVlEwQ3hIUVBVdkR1NlBwbGVscmpGd3E3?=
 =?utf-8?B?YWFualRqL2t5ZzRpb2RQUmFKVURFdGFocEJacS9JMXI5WW83U2MyU3ZyVVpI?=
 =?utf-8?B?Q0labzlsdlZmS2xkVlFSRmw1YzZENVl6NEprUXFMSmFkeXk3KytZN2lleGNS?=
 =?utf-8?B?YUlabmZ1L1hJWFN4MWdXRHUySi9sMmNMN3g2ZTVXSWU0d1Z1RTdLc0Q2WWlC?=
 =?utf-8?B?bmlaY2xyTUdVejFaTlF4SXl4T3VYS2lFWi9oZWFEUUhIOVhFRXBKWXE1cWNC?=
 =?utf-8?B?MXB4VzVQWmdNemVmNTNMZEZ6emNEaklPVkFZWWM0TXJBcGVXMVUzdHA2U01U?=
 =?utf-8?B?aXZQL0p2WCtUYmQvdDRnU1lkQ01uSE5NSjdkd2hOWkxnWUVWVGF4M3NFQlVM?=
 =?utf-8?B?aDAzdStKVEJPS28xREVMczFRd2lPUVFMTmVrQk9XTGJYN1RFTDNIUzByejRm?=
 =?utf-8?B?L1pMRWJ0ZjdSYzhEa2tFbkhKSGZrYTlkRHJuUTZBb2MzYVpsSWFFdkQ4OEkr?=
 =?utf-8?B?bDNURk94V3JxbHBDNlJMbUtMVnNSenVGaE94NENOMmhOZXN0Vks5SWVJbWEz?=
 =?utf-8?B?RTV6cjFkU1ptVUNYOFpSSTFlK3lnUzFYOTcwTTRYU2lWNTdhakhyRnhYSnNR?=
 =?utf-8?B?azJwck1oWlFoN0ppQnpaRFVjTVFUQmQzem5uVTRjT3JHcUNjV3Z3V3B2eGdq?=
 =?utf-8?B?ZkIvY09wTmk5ZFE3QTBEcENvZTVxN0dZb0MrNjVDbE1NaFBoUUx6RXBUR3pi?=
 =?utf-8?B?S09zQ0hqRXFVSm9PQ2llcU1mTXY0TXZDdlZ3RGVRa1A3RXdEZHUxRWRhNUNi?=
 =?utf-8?B?eVF3OVdYa0dTRGM2K2tES1NVTk5oN0w0RkhWaXMzcDUwdUp4U0xFOHVvSmsw?=
 =?utf-8?B?SkdoZGttK3ZML09LS2JldzIyUkwzd3laa0V2eFJiU0NBMU9xbXhkWXZjM1RY?=
 =?utf-8?B?Skc2b0ZYUXVtQkJkZ3g1Z2tmZ2p5NHJpeE9vSTRWMWd5OGdxRXU2UitPTVg4?=
 =?utf-8?B?YkZlaW5LK1p6NUJhSk53SVBuTWVRbUlneVBPY1JGOVliNXFYTlQ2NWhLS0Iz?=
 =?utf-8?B?cW5qcU5FZGRPMUxlcFI3Y3N0b3F0MUI2dDJ0Y0ZuRGFuYnR4TS9idE5WSkJu?=
 =?utf-8?B?MWd5dnl3b3FYV1FtSWQ5WlpVVE9naEJ5QTFsbjhyUGJ2cU5mWjdYdWpMV1BN?=
 =?utf-8?B?eTJrU21vTDdXMFhYK2dreU5EWEFxem4yQjRhblNac01tL3kwNiswM0VXOEhj?=
 =?utf-8?B?U2VXREtHNWZqMXcwMkJvV0FOb240bkFaZzRZRG41ZUVDdzFRbEYwRElhWWVC?=
 =?utf-8?B?NS9CSGkwQjZhM2JMbjk1Z2F1Rk4wZmxQR05XUnNzcFJITHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M2pPdzZXUlkyWkFkVEUrQW5tQlhOQVBLakxVNEFSM1E5R1I2VW5CeU1Hd0ZM?=
 =?utf-8?B?M1V3R3N4RmRVa3M1UzQzNGNwTmM1Vlc2elR3bmtvTFJFT3V0VXB2RHNhQ0Va?=
 =?utf-8?B?LzFPRENNUnROTng1WWhBWmw4NUhSYkNIaEtyZlBqNk5QM0ZHRkoxL0tIWktT?=
 =?utf-8?B?OEdwdFRXdDNxUzNld3FFZ0UvL0NqNFlhUFRBVlAwT3dzOVFTWmZZZnFDN0Z4?=
 =?utf-8?B?R3FPVEVMNzh6U1RTTHhva1l5OGp6SlY2ZTh4ck04dmJPWW9EeGZSOTNmSmxv?=
 =?utf-8?B?STVpYmJHN2pqVThsZWp3cEUwaWp0YS9mckZhdDZORHl0RTkwS1M2YXlGZVNk?=
 =?utf-8?B?ZkpYZGNIWjZ0dkV3K2VWejd6ODdjYnM5MmJiV1ZFSTYyK1UzNDVlVG96VFBJ?=
 =?utf-8?B?c2o4dkRRK0dOdWp0TEgza0ZDYWR4K2RYSENDRE83M1prQWxGWCt5SlNDVGtj?=
 =?utf-8?B?enZaOENWNWMzelVQUWNQMVkzVWMyTGZtVG5JbHR2NGJEZFFiWXpaOEJkY3BJ?=
 =?utf-8?B?V2JpYUNSSTZ6VlB3Zmw5VFVZcmtocnA5ZHZkWVZjVk5Pc1hYSklwdlNPQU9U?=
 =?utf-8?B?SkZBa3dvVmVNNmxjYkVOQzRkZWVqQVFVbFZPSXh6YnRYQWRWaEMyeXVIbVhl?=
 =?utf-8?B?STRhVGlmZ1FmdFFUK00xVjNBOXRzMlVxM3FDdGZWWHdqTnRvU3ZVTVUwd1pm?=
 =?utf-8?B?aGRpNzFYYlFDTmlSRzZrZE81S2EyZVVhUUtDemNWamp3eE9MemxjYThkZldO?=
 =?utf-8?B?aHJiUy9lcjg1VkU0S2Nud2svMnREazkxMjVvL2J3d3pvYmp2QWNhMU90VlpH?=
 =?utf-8?B?SHZCYTlTQ3R0THM3aWlMaUsyZllnTFJCeTNKUFF4QmpIcU5DQXlWb0hVMktL?=
 =?utf-8?B?Nm41K0VsTXRHTExsSWd4NVd4eU10VkFQNEtPVjJaY3JETGZqSnhQRlhzeDZ6?=
 =?utf-8?B?VldhZjFBQlFWQmt1OHNiU2dWNnhPaEUvL2FCR05mdnhMUDd0bURBRzE1SU81?=
 =?utf-8?B?a20vUk9RK2NudFZWQVQrNlNYbEg5dkxvb1pUclBKOUg5ZllZQTdrUE84bDM4?=
 =?utf-8?B?T2wxYU5GZ2wzR3d6S09CRFk2WFlWdUloeFRKazdrZVhMcUUzeGhndXBRWUl5?=
 =?utf-8?B?eWEyUFpDM2VPa0h6YUduTzNHWVcrZWRsZmpINWlHV1JLTmZMSG12ZEl1cEh5?=
 =?utf-8?B?SWJnWWtJOXhkT0JEOTY4clk2WjB4VitxRUdsL0k3S2VNeldZUmVmUU9iNktV?=
 =?utf-8?B?bFQxY1Z5Zm5FdEQvT2xPS1VjNlR0ck00ejdOQVR0RlN3TXlBVkFkb203WmJp?=
 =?utf-8?B?Um5zTC9XTW1aMnNpbkRCaGZ3WnQrUjhYT1IzZTdnVlRKVkxNTmpZZmpRY0cz?=
 =?utf-8?B?Q29TYVgwWloyMlZiZ095V0pYLzVUdGpqSHlEZ2g1ZGo5clVEeUZpckNKR2xq?=
 =?utf-8?B?ZlpudGk3enl2d1RaS1hGYnB6aGtrOERERTBPQ3JQWnRwQVI4OXRZbDlaTVhV?=
 =?utf-8?B?T01lRHF5cWJ5cWhBTlR0RjNFRmRoaUhFMUxOT01ZL2lNN0lUTmJ1T1E4VExR?=
 =?utf-8?B?QUtESjZFa3NqYUM5aFRjdjByWS9XdE5Zak5HbWNGVkZxallJeE5XMXc4V0Z5?=
 =?utf-8?B?U2tjME1paklHMmNtbmJ3dEJDSjVWVVFnQ0JaRVVPemlpNWJsenFJUGxNbzlC?=
 =?utf-8?B?d2UzeDdwdm8yanJybmVlQkNBU3RuSGtsYnEzL3RpL3JqMXpDOFBZYU05YXlF?=
 =?utf-8?B?b2R1R09rYm5kY29vcEpBRWphVlVhMmcxLzNhZFRCSXQyd2FPSkhnZlZBYUJM?=
 =?utf-8?B?WmYyTUlQa2pHSEFQMHpaVHlOa2ptdnFsVC9yMzNldEpOVDNPaDc4ejkzSTVS?=
 =?utf-8?B?b1JsNlM5dytUbmZSTVZWTXJ1SDRCUEdKZHI4Zk1PUlJNdXZaOXJTTHM1UUhH?=
 =?utf-8?B?UG5VRkZranc2ZFF4N0hHR3V1VGZsOSt0cWM0TTdSWWlNMGNQc0VHTkJnbC9l?=
 =?utf-8?B?Y2ttR1dwUWpXQTFyMlhlUVRMbEltQlg4UmIrWnFVMGtnc0hCblNsbjV6c2Yx?=
 =?utf-8?B?alA4RTNHYkpJZ1pwYkRMdnFJVld1UFdFVzFGQjVZNXc4MDhHOXpldm40bldv?=
 =?utf-8?B?UG1GTHp3NjVxZysrTXhIS2ovZjRVR0FVWVJhZkZIYWJBZ2Q4Zk9oZVJXN0Zw?=
 =?utf-8?B?c2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <523F4ACD2B7E684C8048E7F69FAB03CA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fGDbM1VfYAgSgBiuFRL2FEHURf/RUoSm4dTfgG/ckdIOaqSKAYhhcpk5j268mzUyhVnnxW3aRus28EN7XrIRuTvuEQ0NOYWGN3IkSP2QDzRUFISl9TSvZjsGKk+ME+dqSz04PqnT1cd+ZWwQjfo4G27y+pcTrC2XiDrCniSbbvKsPls4zMFm1S94Jpp+19RpQ2yQ6pL7Iq7IWnwGI1vqbVilXfnd7FqnJ/Bs3hmkl7sNve+oz3cyEfeT0CwkWsccDoTdlTak/l+4c8Dk9PWOPECaOt72vBi/oWrLT2HJ0w5rf5wK5AIOWj7SPiXuoAAnDjJrAkjPbvcRQd5kXDDD5KwG+ziqRKqn43ZUixdtR8s6xojwzHmU9rSHWUy14i9dYH7JZhvu1HyKNg+5YCZSOI1MPZDk0Loj25zthhWV1ieH9Um75ndOzd2GAo3KG83y1+itbrq6ujeXMpu8M9ydMnWuy3UYjhn1081ToPBsxYUtRwUQ5JemXRo3ewgeZSSzpRG5h3Xs+uIc4PLuXxwvOt9eYycXXCn92LR7zBYilWbU4HbH4QmRonlvBqqhE9de6RmGEXjifHJ+U/ldXL387glad1d3M1CqAKQAXLQHqDLMs5ns3cNV3ADfBkEUSGPF
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa21682b-396a-464a-c024-08dd15876139
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2024 23:48:55.2223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cMGTJ4lJbxrrvoVWVfg3WJTVtz5hHolea/CQbBGCEVOsl5IqgfeBf+dH4AQEIC5KlbPeaiMWR7jGFIKzRUJA13TliURjRqkzghQuKsYOeJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7324

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

