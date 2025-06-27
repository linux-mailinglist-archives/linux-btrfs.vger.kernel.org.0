Return-Path: <linux-btrfs+bounces-15031-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BFAAEB2C8
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 11:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DD8417606B
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 09:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7552949F2;
	Fri, 27 Jun 2025 09:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="khwPU7bI";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZFXFREC5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC4A2949ED
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 09:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751016283; cv=fail; b=G0xGparME0BDqheQbrWSAPT3hdUMw4fp06wI3QnIks7kE03LqjuwkDl4u92EEmorucQ7Cox9Uh9UmUrwd0bhrxe1rqA4mwMH/Bbge6oZI9EJmCsQ2iWVpw30s9ezeXNYUO8haH5QfaRPlDsQflzuo16RoGYXrwTazxh9GYsHS5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751016283; c=relaxed/simple;
	bh=8zEgKjk5nH3muBPxk6YE500YlS0S/ftghE5lFgmgg3M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DlCmLAfBVLbkXYURKEEohpiGx0TcmCXwokkFeOHzrXAYzSLziZCZZqVZZfsypA5q50x2RFW98eu2esq6aIvkMHK0CRbx+SHBKqY6Xmdye6pmnfcAuHaSGX4SOigQEnIXUMb29w3X86x/w0E+dHEoZEc7kw/qxyh9mJGUna3XCOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=khwPU7bI; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ZFXFREC5; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1751016281; x=1782552281;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8zEgKjk5nH3muBPxk6YE500YlS0S/ftghE5lFgmgg3M=;
  b=khwPU7bIDRyFnDmmwEVQwfzCOhTyNtogJZt7/89zwKNqYBUG+LNqETO/
   UWWV+9PGktNdcd5/G6l1QS6+Eijf4LJGltM3yNcGgMJJqp4VC7xQvQkmi
   oHLB+sLZ//KlNYKXrTpDDy76HdlM5SDi5mo3fOl7jAl+uiuiXv4chxJso
   kuVR8D7TL0w9EJxd3o7LY2I8DPYz7EW+P/IRRsUg0fhP76N8tkOuwb+OF
   Ud6WNINsR8wy6cBrpymXzEmB2umqboUD85VwJn3P29i7+dc5XB4tiiawK
   ci0YYDnLFJDbqoF5MpAXPIB2Q2OoInI7o/xtIACRc3aYPLdE9P47gRTl0
   g==;
X-CSE-ConnectionGUID: ZWejikUGTC+zFrnphj4F7A==
X-CSE-MsgGUID: LpR9ysxuSBChnxDlb+MKVg==
X-IronPort-AV: E=Sophos;i="6.16,270,1744041600"; 
   d="scan'208";a="91388888"
Received: from mail-dm6nam11on2076.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([40.107.223.76])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2025 17:24:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Habu0vJFiacQfPWpB6LRWDhVEtuEFyLL0pvLtM1J7x/dbuiCPVPDE8W35iDBgfsXOe4OjLnzA0o1VgZFjhPbR7rT3dA59FncKSLF6AYrYB7JHhoHElCb6paixYDxhb8pr/8hB5w1i/3mnIwJa4FLoA8K8jBGyBEq5anJcyF5UdWslv55FOv02yMlI9nKv9VdoLBIPOndEAnqbRKzEyMXepxXjYMH9ey6StHryKJIOErwFHO5Yr7XDFVLeh2bWAYDAB/jOTyk7Bl2Uqu83S4Mj3Eo0jUhmUDqb7XpjhBb9D1nig/Tpx9VMRlzxN/jwbVXozrLrM4U7eNrB1nD2FF0qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zEgKjk5nH3muBPxk6YE500YlS0S/ftghE5lFgmgg3M=;
 b=xs5W0gLCLNrL0RClOpkpJ1KAmxfccLuU9xlp4r9apEdcUD02lM4P4csqjFqAIxF72IUTYKihVkXJyOWAK6YjOUdYrelVfCChyH52+H6lw++TTpi1zDw6kz5c0hBsYGHP6n95nmHc0GRSUWLh1vqkMK7hAZ32s1qvVFRg2k+PiWtzAxGSi6q8hQo4yv+FjxcObKiAT6VeeZx91dRnqP+qrFbR2/9KkHBl1RHPyvMCLStSuTt9zO4cslFZf62toZ1IgxYEaUd7AJv4urKYlGIroq33ctws5DUQMMbfOITWT7vifIGdv5AhdhkTiVBWCY6NL0OVLFZnUlCv+0eZjQKepg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zEgKjk5nH3muBPxk6YE500YlS0S/ftghE5lFgmgg3M=;
 b=ZFXFREC5+0G78pN3urS/e8UVLQBwTMlilNxYBgINg1X5UjO9x7Dro7gxbKaBAQHlFC/TlxF+EQtveTo6N3Xl809wEb7u2LLOEhY6PhnkIPykfEc2nywPOxDrr1MW5+Y1U6byKI/tFslMtbcEUm4pBWI48catWu40XmAssFaa7Kc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Fri, 27 Jun
 2025 09:24:32 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 09:24:32 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Dmitry Antipov <dmantipov@yandex.ru>, Chris Mason <clm@fb.com>, Josef
 Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: avoid extra calls to strlen() in gen_unique_name()
Thread-Topic: [PATCH] btrfs: avoid extra calls to strlen() in
 gen_unique_name()
Thread-Index: AQHb50DHlLFrsZGqPkaQzFLe5arhU7QWvBGA
Date: Fri, 27 Jun 2025 09:24:31 +0000
Message-ID: <c89ac44e-a356-4091-84e4-c709615051be@wdc.com>
References: <20250627085117.738091-1-dmantipov@yandex.ru>
In-Reply-To: <20250627085117.738091-1-dmantipov@yandex.ru>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_
x-ms-office365-filtering-correlation-id: 090d9574-81e8-4fea-f8c5-08ddb55c6c95
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MU5IVndmLzhkVUROOUQ4SmpibUxVdFZWNnBpYnUyM1k0VStjZ2ZqL1V5ZHh2?=
 =?utf-8?B?cU5TSXhvS3JzWWRDNS9FbFI4OXMvSnI1VGR4Q2YzVkZCcFlIT041MGRJaWJY?=
 =?utf-8?B?Q1VPeUFWUVBJb3B1UDBDV0JWS1lHTjd0cVFsYnp0S05qRC9WbWR0eURjbEg0?=
 =?utf-8?B?NVU5QTNYYjd5UFJDc25pVnJmdFY3VzNxakJWQU1nZ0VjWUNERENkckhzZ2Ev?=
 =?utf-8?B?R1pGcFIrY2h4OVc1dlVjNEFjbUVnUldHWGFBQjdJNTNpSDNheDJCS0dtZksx?=
 =?utf-8?B?VkZud1FIaXFOMkkxeWhrSDBReGNJcjkxekVVN3F4YXFPUk5hckF4OHdhVzV1?=
 =?utf-8?B?UzZiMklEYWxXWHp2NnJzc1dCZXk5U0hzcmExdmZvZmpSS2dGaTRWbjFvZm12?=
 =?utf-8?B?eDgzSU9UWVlocEZpTkVUa3czcFZHYW5FWnRNdU9uNXdObFZtYW9HcHdWNXRw?=
 =?utf-8?B?MjRHakZCVGJSaStUam5XSE9CZDY0NEFNSHhnMEw2VUV1dEpDSWdLeGt5NWJl?=
 =?utf-8?B?QWpnb3dCa0dWM3h1NFZWWitPVE1scjd0cWNTU0x4dDV5b2JuQVNSSWF0RGdG?=
 =?utf-8?B?TVllaUgxK0JPSldCVFAzckxzeDdYRzBuN1diS0JSenBYNTFRL2NuU05YSVBP?=
 =?utf-8?B?RkFFbjFETGNkY1E3bVQ4VlpPeXpZdnpLK1VkZXo1RTJFaUxXTG4wbzFGZXZh?=
 =?utf-8?B?R0p0eHVnNE1ySEt0Y3poMngxSFBwb1dKdUVxWnhsZmpKM2VmaTdJRG9Rekpk?=
 =?utf-8?B?UCtBc21ENTUya1pQRnJzQzhoNVVGSjZLbG1maHNpdC9LK1ZQYStxd0NhRWwx?=
 =?utf-8?B?TGY5djdkSzhmcDlvaGJ5aXdhN0dSNmtyWE1ZR1ZsdE8ya1lRN25FcjBNWlZv?=
 =?utf-8?B?MnhvR1dCcU1pK0FkVzNMV21ldWlGQSswSmFENGhnQ1NNYUhiZkFoaFg2ZGdk?=
 =?utf-8?B?M3hpb0hTYmkyUSs3SWVLTVAzK1dWSXNXdlYzQ0Jzc0xWMFYrM3JGN3liZUVs?=
 =?utf-8?B?Q0pUNUZyWkgxRFlDMklHMkVTQUVOaUZmZkR4eEdOZ0VJWnF5U2FpT0tuU3N0?=
 =?utf-8?B?K1FKMGp4eW1SSWhqd0F0UURxN3NwNnRpYk92STdyQVh6a3RLdituSGxyWXhU?=
 =?utf-8?B?aStwTGJVRDNYUDZ2VVBsTzBHeGVkbWdNdVhua2R5elRza05DQXpxR3FTTHly?=
 =?utf-8?B?UWRNKzd1YnE1VDJybitMekxNL0RCSkhiNUJ1UGFIRjBmd2c3WlduTmlzelB1?=
 =?utf-8?B?eXFITHdDSXhBcHFMQTRqejlCWUxrbVVySTRrcytCNjBJa1FRRXFEV1JtV0Rw?=
 =?utf-8?B?Z1l1alNFTjRjMC84QTJTUjZzQUtwT0o4Wm9Va0JDTDJoYURJMjhtTUxNUzZH?=
 =?utf-8?B?ZnNJQkZRU2pPVC9lWWE1ZTY0MWhMV2Fld09BZTZ3ZE9keW9mVW9uZTY0Z2ZB?=
 =?utf-8?B?QUdZdUpsZE91RGNtS0dFRmV5L1dQeXVLVWlNSmRjTEs4L2pqMGV5WnpEY0dz?=
 =?utf-8?B?OXh6UlZwb3I5cVRUdGNkTnpBU3FaOHlMampWaGZKSzFsNk1vV1BSbjZobFNI?=
 =?utf-8?B?QU9aV0lWT2trY3FLaFNWWnE1TUJOUHhjUldkMm42Wk53UmtMSHc1S2gyRTZo?=
 =?utf-8?B?R0lrcW1xYWhKcVdrZmNrSDYxTXJRYStydERYbWJZcFVmWGU4NUlMdDI3Mnc0?=
 =?utf-8?B?dFlncGJKRzZDaXhFbVAzSlI2NDVmWlpJVWpwUjZjMDhlY1NMSkpidE05WnFv?=
 =?utf-8?B?cTZ5V00zdndGak5zLzFqYWZmbkhBbGFLSnZUZnMrTllFYVNQRS9wNXRnVHlP?=
 =?utf-8?B?ZDNKNmpFdWp0MjNxM1FFZW50Zm1yOHI2amdsL1d2VDRwRmVQUCtTZ2FzT09U?=
 =?utf-8?B?bGY2aGcvNWZ3alE0a0N0d3lSbytvWWtvUjhsYlBsMFEzNjJkSXFZUDNoK21J?=
 =?utf-8?B?TGsxSjgxUHZ4UHRKWXd5MkdGeEx0cEJiNGtyMHM2Uy9Kb2hUbkhoa0JNYTJH?=
 =?utf-8?B?akFwczNJUDVRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a2RaS1BvZzJ5K0t3TlRRa0xseHpySDJiTFBOS2pGTXh6bG9hT01FWElPREpF?=
 =?utf-8?B?TDBrZ2NCUE4vdWwrN1A1ZWVORFRSQjhsUFFielRGaUhudjcxL0daSnMvWnRx?=
 =?utf-8?B?Y0ZzR2ZQMjE3d01SeDB4SjZYbndQWXRmb1NTKzQ1cHpuWEhFdHBxTHFmeWxi?=
 =?utf-8?B?b1ZXOFRoSzlqbTR1WFN5TG9FN1NQVkFYRW0rNExFd0VadEJqZTdnSHFiNUdM?=
 =?utf-8?B?Mk4vNlNEZzk2ZkJ6eHIxVlArVTJ6NUd0QlZrUGU3Qkdjb2krTVZmUG1SWWZC?=
 =?utf-8?B?dlYweFhudHk1aWZNRzhRRXA4cjk4Q3ZTcFUrMHp2aXFyTjJyeVpkSEtqQ2xG?=
 =?utf-8?B?RDJhMzlXdDdhdDBoMmQxdEFCLzEwYmRTbDJiMWlNYTdLL1hrMk9EZHdPeDlX?=
 =?utf-8?B?aW9TUitVZUpQRyt1azNYOE1JK1F1eW5ybXBFQTNDb2p3TjRPZm1lT1k4bzVu?=
 =?utf-8?B?ZjJVMUhaSmxtQlBIc0lnOVhQdEJ0K1N5U1BseDZBMGJLanBCVFJwU0VrcFZw?=
 =?utf-8?B?bXF4SDhpR1FYbTA5c2xlTXN5dXBJSllGc01sVjRRMWxReDNtUjFtbDJ3WUcv?=
 =?utf-8?B?UlBMNTY2YXVkTXFkcWtKVHpLYzJ4U2JydTVxZjlDb09va0JTb2pEV3o0MlZ6?=
 =?utf-8?B?b25HdGk3SkRRcU1MekxWdTdvMXcySktYcVkyTUM1TG8zQU5KSlpTLy9tcXpS?=
 =?utf-8?B?SkloTFU4ellIVXJvZ3o4U2N0aGcwNytxWWNBWnVWUmgvMDZUamJvT245MjN1?=
 =?utf-8?B?SnVteFA2YTFDOEltMTQ2NFZQTEdoSFJXcWZVSk4yZWNsOE44MEFzb1FyeDJi?=
 =?utf-8?B?aUM4Q1Z3azdWa2tkcjBFOXkrS3A3Y0hGV21aaWJmWFJTZzc4eC92UERPN21B?=
 =?utf-8?B?MkQ5NzFFUEZsL0pFVDZ6UmpOZWUveDI0NUxFQldzVlZVL0V1YzJKU2grL2Ex?=
 =?utf-8?B?c0NWQ09qVWZ4U3FreFh5ODBGRHIxL1VWZ3JwbGlkMnhHVExmd1pDMHJCeUh0?=
 =?utf-8?B?YU1iRVlxZ1NhUysvUHVuY05vZDNPOWQvemY5UUFSSFZlQUVvbmJGWUxJSmZK?=
 =?utf-8?B?Rzg5KzNGcDZhOHVGVVF6S254SzRQRWVwWFlkUmg0Qk5pY2cwdjkxQVl2WEJ4?=
 =?utf-8?B?am1qbnhxclpudnVrSE9mN2lrWkxDSEc1Vm9xM3R4Z0lJeHJncUdSMmdQdkRm?=
 =?utf-8?B?Z1BxV2tTUXhqQTM4Tjl6ekFlaUlwYU12Q1pzSGkzV0cya2VSeC80VTV5UndT?=
 =?utf-8?B?SHp5MGlvMFdNTCt3OFRoSlc1N1lGYmdUTktjUzl1d3FFR0loTnVTZU9vZUVL?=
 =?utf-8?B?MEx4QVNRMFdXOHQxQ29iWjl1dGlpeVV4UHNHMkdxM1BKcmUvZkdVeXRaM0Nq?=
 =?utf-8?B?VmFhZlpvOHZLY0laeFU3d3BXL084R3BiRzhxbkxWRCtRUDgxekxoa1R4Vzhi?=
 =?utf-8?B?M05sMVY1emZocC82Uy9YZDdZaDQ0QzRNb3BFQVB3QVRKMUtUNHJZS0NxeElX?=
 =?utf-8?B?K1NTVXBGZ1JMZm9TUFJOaVhWZzJCdnpORHBOTzJRZ1VleFpkeXoyYVg5RFNJ?=
 =?utf-8?B?WjdKZTZzcVJVSlA0Z2tZK0NKbzN4WlIzZE5xVytOcXRrNlR0MTVtNG1pa2tE?=
 =?utf-8?B?ZE5YeWUzamZlNFJSY3Iwb1k3VVFiWEVNWVhnelNKYXZ4cWxVQ2RSOGNVbmd6?=
 =?utf-8?B?Mmc2cWNvMmdQVnlCR3l0VFg4UEIxMWUxVmFkcWNYdEI2S1dZQy9FMjRGbXJm?=
 =?utf-8?B?WnpxU0NSejlMZnNwL3JZelpEdVhPTzdQai9yd1YrSVF6UjhMYUxzZ1pKRUpa?=
 =?utf-8?B?R3lKSW44WEc2cm1aU09tT2FQY0I2YzR2ekIrUjF5Qjl6YkxEamVyVWJ1OElI?=
 =?utf-8?B?U2ZSWllYVnM4ZjUzRXlWUllPUDNucXRYR3ZUZTJzTFF0ZGtzT1dzMTJVTDY5?=
 =?utf-8?B?eG5lbXFvdlZZc1FjUFBSdFdaZU5RU2tRdkgxZDAzMU1LV3BtYWNqYlhReUI0?=
 =?utf-8?B?MTJ6YkpWR3E3bkFiQ3VYaTljTmNvR0EyV2llbEtIWDViSlNlZkxLRjF3VlNr?=
 =?utf-8?B?THUxVjZlWFBQb01jSDhzb3lQVmtuUXpha0NrQ25hUVRzZFdCcXd2ZXd4bmhP?=
 =?utf-8?B?OGlZQWdTYjhRL3Nmd3V2MEx4dVhXa2xLS2hlRENlOTdOMFUzVFp6UVR2cEhi?=
 =?utf-8?B?VThGMnlQRko1QXh1b0E1b3UzajN3RUF4YWJ4VU82WFQrNmhQRGlhK3pWaS8y?=
 =?utf-8?B?YXY5bzF3WitGRU56WWlWYUQxajJnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32F84F31D2A1274CB0BA535DDBA060C0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U2w2bso0YGuhiv/tE+p4sSM3LRoj/WDMs5Eb/joxl+5HsjMtct11E93y0NoIjg4eF6lI2iM4/dBpcgcUwXSaeyDJT9TTnMyp56EN8Q0uO8F0rvrPXECAcN4ep2pUGKlkoolYkOhev8eE+UAjnkSqtzhdD3umcjEqxJgKGBevVipW5AP7xpr92EuH7AmPnwPXSq64mpsHmAg9K/3+v9XOP8uTIcjEUtlKPo2n+rEKXTlDAD15jI2/CWzgsiEgs7d1qGQmAQ2mOJgX2S1Np52VeQsB2xkl5JjCC+VTFo/bTOVzplk1hPly5dN2pi54mkCnNLvDWqVXi+2fJ8r0RpMJW/orRpv0gjcaG6vcpdSs913vnDm7iR/hGDhOZEduXEd1iXPdM9O1E70F7yZDIyCq6PAWL2oovPsRDD4afEI8CuVkd1tqInquTA5nuQi6MQtDhniQofWN0smQ7nKgv6BJK4gXnuhgZA+f43zQcszyx11Gl4ilhG+WGPcsB2zjzqQW5t+EQ8KJdyULNkAnk02NQjP11iH1b4Sd/Jvth5Cua0f3i10BRy/chMG1e9eIw61U63NsT9S+x53GbMJG90Mm+4HmDqkDu/lKv9nM0igoMeTF2pRb4c8wMpzU+Y2ajjeP
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 090d9574-81e8-4fea-f8c5-08ddb55c6c95
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2025 09:24:31.9266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5MmSrUgGOA0GUOCMmbXOAsgTqQtXTIeZt0t+hGwdZO9++HxvN/0BBXPOxGgKssP+79DF2svyH6VeIHfgkNl8mf/c3xVB2/8DF2dS1ceFjkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7416

T24gMjcuMDYuMjUgMTA6NTIsIERtaXRyeSBBbnRpcG92IHdyb3RlOg0KPiBTaW5jZSAnc25wcmlu
dGYoKScgcmV0dXJucyB0aGUgbnVtYmVyIG9mIGNoYXJhY3RlcnMgd2hpY2ggd291bGQNCj4gYmUg
ZW1pdHRlZCBhbmQgb3V0cHV0IHRydW5jYXRpb24gaXMgaGFuZGxlZCBieSAnQVNTRVJUKCknLCBp
dA0KPiBzaG91bGQgYmUgc2FmZSB0byB1c2UgdGhhdCByZXR1cm4gdmFsdWUgaW5zdGVhZCBvZiB0
aGUgc3Vic2VxdWVudA0KPiBjYWxscyB0byAnc3RybGVuKCknIGluICdnZW5fdW5pcXVlX25hbWUo
KScuIENvbXBpbGUgdGVzdGVkIG9ubHkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEbWl0cnkgQW50
aXBvdiA8ZG1hbnRpcG92QHlhbmRleC5ydT4NCj4gLS0tDQo+ICAgZnMvYnRyZnMvc2VuZC5jIHwg
NCArKy0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9idHJmcy9zZW5kLmMgYi9mcy9idHJmcy9zZW5kLmMN
Cj4gaW5kZXggMjg5MWVjNDA1NmM2Li5hMDQ1YzFiZTQ5YmEgMTAwNjQ0DQo+IC0tLSBhL2ZzL2J0
cmZzL3NlbmQuYw0KPiArKysgYi9mcy9idHJmcy9zZW5kLmMNCj4gQEAgLTE4MDQsNyArMTgwNCw3
IEBAIHN0YXRpYyBpbnQgZ2VuX3VuaXF1ZV9uYW1lKHN0cnVjdCBzZW5kX2N0eCAqc2N0eCwNCj4g
ICAJCQkJaW5vLCBnZW4sIGlkeCk7DQo+ICAgCQlBU1NFUlQobGVuIDwgc2l6ZW9mKHRtcCkpOw0K
DQpUaGUgcGF0Y2ggaXRzZWxmIGxvb2tzIGdvb2QsIGJ1dCB0aGUgQVNTRVJUKCkgbG9va3MgYm9n
dXMgdG8gbWUuIA0Kc25wcmludGYoKSB3aWxsIHdyaXRlIGF0IG1vc3Qgc2l6ZW9mKHRtcCktMSBj
aGFyYWN0ZXJzLCBzbyBob3cgY2FuIGxlbiANCm5vdCBiZSBzbWFsbGVyIHRoYW4gc2l6ZW9mKHRt
cCk/DQoNCj4gICAJCXRtcF9uYW1lLm5hbWUgPSB0bXA7DQo+IC0JCXRtcF9uYW1lLmxlbiA9IHN0
cmxlbih0bXApOw0KPiArCQl0bXBfbmFtZS5sZW4gPSBsZW47DQo+ICAgDQo+ICAgCQlkaSA9IGJ0
cmZzX2xvb2t1cF9kaXJfaXRlbShOVUxMLCBzY3R4LT5zZW5kX3Jvb3QsDQo+ICAgCQkJCXBhdGgs
IEJUUkZTX0ZJUlNUX0ZSRUVfT0JKRUNUSUQsDQo+IEBAIC0xODQzLDcgKzE4NDMsNyBAQCBzdGF0
aWMgaW50IGdlbl91bmlxdWVfbmFtZShzdHJ1Y3Qgc2VuZF9jdHggKnNjdHgsDQo+ICAgCQlicmVh
azsNCj4gICAJfQ0KPiAgIA0KPiAtCXJldCA9IGZzX3BhdGhfYWRkKGRlc3QsIHRtcCwgc3RybGVu
KHRtcCkpOw0KPiArCXJldCA9IGZzX3BhdGhfYWRkKGRlc3QsIHRtcCwgbGVuKTsNCj4gICANCj4g
ICBvdXQ6DQo+ICAgCWJ0cmZzX2ZyZWVfcGF0aChwYXRoKTsNCg0K

