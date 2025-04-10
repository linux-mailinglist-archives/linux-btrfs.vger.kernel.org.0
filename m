Return-Path: <linux-btrfs+bounces-12940-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B34F4A838E9
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Apr 2025 08:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5589D1B616FB
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Apr 2025 06:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3D6200132;
	Thu, 10 Apr 2025 06:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LJ+oo7/7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PyrKOxVh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84779188006
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Apr 2025 06:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744265182; cv=fail; b=Xpg3fQIXgtoUsRcoP1/3T79GXkzBsnt/IBvP23h6phLQdE5Cx2fZ18gEfSye83VhAdIAJYC9ZldxYk3NTtWvwrPhTnv6NkNXchkiekWZq1W1vzZP9+o2uzandVl83t04/At8ylKWMrQn4VIT5eDEZoaB3YP8pGvMhhFnIOcpFlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744265182; c=relaxed/simple;
	bh=Ibgi/JggM/eYaKVpCNXNU+F0cP8Ho/F9EaZ3afnfuYY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C71R00k0kx0HQIarpi5FYEHfVbvD/6u7QX8hsf5gpaicejGajK/vw9ojUP1Jja0MsOiKDLlBfg+24HarH04c0tvEYdf3T2SYgzhdHzgGfMIlWf8AZ6zTLRP6g6/LU+Sf5QjWV1K9qpfP3MYVHMoyux4vRB9o/Dri6KPjRgYbyvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=LJ+oo7/7; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=PyrKOxVh; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744265180; x=1775801180;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ibgi/JggM/eYaKVpCNXNU+F0cP8Ho/F9EaZ3afnfuYY=;
  b=LJ+oo7/7tRoh55y14tuTK/wbSJU9pAZCKAw7BYqmkN33znssXZWu9mqc
   PBsATtb6q3j9QozG8+fDCY7fVt6gttPyxXLx/qUVyaTNcnxznPYVrRROn
   NrgxHyJlvMweG3uWqDUMDUcnAnx+lOtEqq/2lzX19PiU08VRgNyrh4OS7
   8IZFqEw0alKTc7knogm9OJMO6rHu8DA0mv6Ej7gZi607k0KeYkHwDb305
   LbHekoK7HfT56jlJl+p4igbIHERj2+iDm1xc9xSTbJ+gSoxJaHpm6FZaj
   VQS7ZsJgMnNlLx23BYXVF9hJnGIpd5M4BW+BYUMu7vlKv5VeRKV0mr+MO
   A==;
X-CSE-ConnectionGUID: GSFRmTw/Ql2eLGK4SrRG+w==
X-CSE-MsgGUID: xjl4E4P6Tkir6FZfLaq9Xw==
X-IronPort-AV: E=Sophos;i="6.15,202,1739808000"; 
   d="scan'208";a="75666391"
Received: from mail-westcentralusazlp17010006.outbound.protection.outlook.com (HELO CY4PR05CU001.outbound.protection.outlook.com) ([40.93.6.6])
  by ob1.hgst.iphmx.com with ESMTP; 10 Apr 2025 14:06:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ag+Qznzh7ECIFBWt9iVTRYjO2NsT519aGpworvrUaNYG+/PB8jojGU44n1JeTeKqOdAmcJvnGJiqzAkP1mnPw1ehYRsPdEM9QJStolyThDxq2e4osco2ZyTLs437McPGK2UYDO1/gzBCAWYFHCYRYxw6sdFZ3eyYK61gPU/tQYlq4t7deD3A+5aEccOqTxwczPXp4eWRFJS5i0upb8RraKHXwpLj4EgUBCuvis7ebKdiny8xViVPuijYWIXA24fy38btgoVyN1hNSVuSJoYgOY2ftmB1/EY1JMsYzSlvM8DnmvhzSpPXw4sXE6AHEdFQdKqL2Jl3gyzn34BVozJwlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ibgi/JggM/eYaKVpCNXNU+F0cP8Ho/F9EaZ3afnfuYY=;
 b=twTUFD4OuQQUyOnog97Tm5Aqij1RbVfbmPl4h0opu50nz/sq9S3JKOjtbXm0MWRAyeNkV9nT0EYgeRwIkXPBhO70eGz3Z+Yq74Nn5PatpYgzyjxf1L8pBv7Ucst4CaTncheTagg0xMLqG/R11S6BQEZARNXlrNTbaQN8zyegy73fqCSXxtuASpeR4Pz3cQHgcHHbvIKkX/wcfbP5aGLYguSTF2yhTgFidXEtUVPkfw9Obubug4tf/tolz6PoBcfpNLNXlRZwCcUMm5mXYNe5EwJgQszvrrmlJJJ1pXSM7su+bP7kjaz8gFYJEELqYnW3T3+Fws7B/09lf2lFjO7TrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ibgi/JggM/eYaKVpCNXNU+F0cP8Ho/F9EaZ3afnfuYY=;
 b=PyrKOxVh/PzHpmX9kr/zWZ84J963KWRiVHYe3wvvbtGm0qonhSVSri3Cpx4l0PxNFxWB9HRpoFguJjEthttigXQZwyNMdzzeTavj1dzghCG32n6SkzFKg0ZHnPVpFrgdKe5GnidNzdaEm5nhCZHTcz4kDrQcWE2+3Z5YQhmvZBE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB6401.namprd04.prod.outlook.com (2603:10b6:408:78::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Thu, 10 Apr
 2025 06:06:09 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 06:06:08 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, WenRuo Qu <wqu@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/8] btrfs: pass a physical address to
 btrfs_repair_io_failure
Thread-Topic: [PATCH 3/8] btrfs: pass a physical address to
 btrfs_repair_io_failure
Thread-Index: AQHbqUA0rREaJ/vxUEe7bdA+WRXVd7OcaswA
Date: Thu, 10 Apr 2025 06:06:08 +0000
Message-ID: <02a4b8ab-6f70-4cd0-9ae5-27e219c38a67@wdc.com>
References: <20250409111055.3640328-1-hch@lst.de>
 <20250409111055.3640328-4-hch@lst.de>
In-Reply-To: <20250409111055.3640328-4-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN8PR04MB6401:EE_
x-ms-office365-filtering-correlation-id: 95eb9fbe-5144-4d29-98c0-08dd77f5c986
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q1FVNTZZOXFUblNGU1UvU0plWlRuTjZ4QjJaWVJEMGFFR1VneXdQK2plLzMv?=
 =?utf-8?B?VncwRkhRRVVod09Bek9idmRNN3QyWU9MVlBSbnJSM3VlRXN4VWtXMTVUOTJI?=
 =?utf-8?B?eDUxY3Q0NkpVTGNIYzd2VXZhQWNUV0xBZDZVeUkyUEJwUHpUWkhtU3FqM1dC?=
 =?utf-8?B?SmRGckJXUTkybXh5R0FBTkYxN0ZCR3BjckgyaC85TXN2TmREcXI1WnN1R2hW?=
 =?utf-8?B?OEdOYkdYQjQxc0lJdm9KM2tjZnoyZEE5blp6Y0JMYmdpZUpxNEVVVmZZdHI0?=
 =?utf-8?B?YmJSQnNORVlhOUJGWDM4cVlMVkd3dlRmaWxpYkw4d05CUFI5OHNxWitLemUw?=
 =?utf-8?B?L1A3ZUFBNC9nWnA5c2RtNjYvYklYNzNPMnphUVVQVlF1b1NxaFlmOEdlVjd2?=
 =?utf-8?B?dkN5N0dSVk04c3BjRkdnYXlUSG9iUDB4TGtwTmNCK2xBckUxOEZNMHBlZFdq?=
 =?utf-8?B?c3JqNGJ3K3VEd2FVMFZteVhRdFM1SjVSZEFjSjZYam1ZVUR1RXIvamxQQU1I?=
 =?utf-8?B?bVM5RDgrWHRqR2l4aWtITFFmQzhFT21LZUoyL2M2Qk9CSkN6clQ1OEg5SFF4?=
 =?utf-8?B?Z0VBdHJDTVBlclRTcmxTZHZjaHBWNHhPQ0ViODFWNndOQ05Ndy82TlVIQUYv?=
 =?utf-8?B?SDNmbHd5cVNSbWNwZzkydk9xM2pqK3g4MEJ3Y1lhMC9XQnI3NVA2TS9idlM5?=
 =?utf-8?B?Z1g3NTFmbVM3KzY3ell4TXNxcHBZQW5LdXBONTFZZmYrNWt4Y0xIaUNwUHdC?=
 =?utf-8?B?OFNtUmhKQlV0THNCZm11Wnk3dHQyQ2NOTmVXdHZ6dVYwRXpvdEY5WWRTenZL?=
 =?utf-8?B?VHFGZS82aS95dE1NVE0rZCt6OWRsbGFnNkxVaGlmZUxITHNOakh1d1hsSDd1?=
 =?utf-8?B?L0ZNQmZGSTU2WHZWM0F5T2U0QkU4Y1UwR2NpZytCK1gybUpMaGp0bHF0M25x?=
 =?utf-8?B?Mm1oM2pML3JyODVnaVkyS0swN1E5alBUUlhmdGMycmdaZHhGeWN3SnR1Y1RN?=
 =?utf-8?B?dW9EZkFpVXVUOFV0cnB0VW9DWTUzN1AvMUtxbW9BVTlwRkhQaXR0T24wUWpt?=
 =?utf-8?B?aURzUnVWZHFYaCtUdVBnN1JCTHBFUjNicTYwNUx5RDZSa21sTTFPaDdpMVpj?=
 =?utf-8?B?R2Fnb09mOGU2aDhEUWtySEo5WGwyVnRqQkNSclJjcTAyS1lSMGU2N2hvRUY1?=
 =?utf-8?B?QTFjVUoyQUZ4bDVoSW1neVBoakpaRW9qN09iOGI3dmpqN2FhWmRvMUxuZHNW?=
 =?utf-8?B?WHVLMTFoNDk1Qk9RbDduUmExUXM1RlNUcHdOaWljOUFrNDhSUnFHc3BQNUE3?=
 =?utf-8?B?NU9VMCs0bjE0RjNZZm5VU0RwS3Ard0FzTzhyUzBGZmNQNklVdm9LdlJkZFgv?=
 =?utf-8?B?eHNFdUpLT3JnMUgvOU5RVXV5My9WYWJNcEZDSTR0bnRhSTB4TjFFZTV1YnNR?=
 =?utf-8?B?azdldGdnbkRpU2JIVE9Rc1BmSWZHYSsrSU14T2FNWCt2MTc5UlhubGFlYmlF?=
 =?utf-8?B?UnI4bHgzQ1BKQzladVVZZmpHeWdPQmk2VVFIV0R2bXZoZmVxWWdjUE1TWUZn?=
 =?utf-8?B?MlV2TDJ3M2JZTVdKMCtIclVrcVFoZEhmSjJNbFladCtEdm5Sc0Nremc3bFRq?=
 =?utf-8?B?ZDVtN0paT0ZkWTVYcHFLaCs1eHRlUjNvd0dNNlpaZDVXcFF5S2FwMlFtc2R1?=
 =?utf-8?B?QzdXaVlaY0tWVnF2L1VERlE5NGs5cDZIVi8wdFlmalhWemp6OVUzcS9jcTZv?=
 =?utf-8?B?YUxBQmg1bHJldWh4cFFjajlaZEJXNlVKb3NKejNKNHhkdkptS2htdjRWVjYv?=
 =?utf-8?B?QndBdUtoRDR4VzE0bjAzSVNWMGVhRWVtKzZCR0pteFdNRnB1RTBYeUlyTGZ2?=
 =?utf-8?B?WkErRTVzRjA3cUJCeWJtcmFDb0tzZ1dXVUNySVAwZC91VE5HMlA0VFdCNS9N?=
 =?utf-8?B?anFzYm9Ya0k4dTdMd2tYTHZhZExFYlFEd2NiKytqcFgwQ2NTRXJBWXNpenRv?=
 =?utf-8?B?ampMM2pXYllnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aEdqKzk3ekErOVcyT1R5TWR5WlJ4NHRBbmt4SFFyU0FpVmF4YzJmQzVmTmdS?=
 =?utf-8?B?WEtVY2RBYVNTRjhmdDdSbU1OL2dTNFhlRGZ4WEhGYjZURmlkVExCTkxUalJI?=
 =?utf-8?B?eE5mRWNya0FkSHRjbU1HSnVDb0tqWS9SNlEyVGhCSXExUk5TOVR6a1dXMGhp?=
 =?utf-8?B?VjR2eFExamI3TUJ3MFVGckhTaUg0Rlg3TlI0eTVIYlJORXpFVWRyS0ZyOFpa?=
 =?utf-8?B?Z1B6TjMxTTZOZW5QMzdaYXJvVXVxYzRuVm1xMGhudGxzcmNwYzUxRFR6dHZX?=
 =?utf-8?B?YVhzc0ZleCtQSmxwbVBOTWg4Z1RWN1lFbVBzUjMrY25ZTkFkQkYvUWo1Zk1E?=
 =?utf-8?B?aHZ0RGRsRTRVSDAyZlF4cll0eTR3cU5NQU0xaFBMeG4vU3ozcEdzSmRlSDN3?=
 =?utf-8?B?dW94UGxEbVhxeXcwdWlaWXhKM3FTcTA1bXJsUVV0SjcxMFhWemc0dHpXQWpZ?=
 =?utf-8?B?TzFwS2lIaEo4bWlPeGkxOERLM3J0ekdKazNDd1FTK0ZYaDl6ckpiQmE2ZkMz?=
 =?utf-8?B?MExLdFZPd0Y5WmVBWDZ1bk9uSlJ2QThTS1BtN0NOaG5UWG82ZXdQL0lBV21K?=
 =?utf-8?B?WXp2aEdGbmE3SlY0eTBOR2RtTmlwd09pUDIzbkdkZ1VPRzNOakVSbXJUeVFS?=
 =?utf-8?B?TDdyRFV5ZG1kTXVqeDNnVVBzK3BZalZsYW1UcEVxVjUxaHlnQjhaeDZuMXBK?=
 =?utf-8?B?ZkNld3ppSGxCZmNUdFR0MmwzV1hQalA4QU5xaUZhbTRDYVRablVEMjFleFZ5?=
 =?utf-8?B?TXcydEhKQ3ozWnZDekVoNUc5aUp0YXRGNWxQTDBGS3d5OHZqWU4vQndRYUN1?=
 =?utf-8?B?dUU4NTRDem9VNUZnREdkdXFvSHVhTDBTd1RBdmwzQlYvL1NROHBhdjB1UytI?=
 =?utf-8?B?WjY0eTQ2QnNqUlpXMVlmdlVER2dSSWd5KytST1NRN1VxZVZhQVZKazdmOEJ2?=
 =?utf-8?B?RStjK0djUnFONTI2U1VydEtrU0QwRmp1SDhYWWtUbEl5blVJMzVRMGQyV0RL?=
 =?utf-8?B?bWJub2Q5OHcwMjNZWVJtdFRqVkxnK2xneHU5bUhCOGJvejF5dnl5clFJZW1r?=
 =?utf-8?B?cmpiempuNGFjVkl1ekd3WkZmcUJ6MmRRWDk4N1J5M3dyZGo1OHhYd3Ziendt?=
 =?utf-8?B?T2o4cndPRG5nV2RoMm5sSFk1U0dvZ3VPRitxMDVGRGMxdm9pU2JlMEdQZjRZ?=
 =?utf-8?B?UHFOdWhtVVAzbnhBVE5DcDdscFJVbHg2WFRyYVNnN3FJeldpYVRyYTVHckp2?=
 =?utf-8?B?dXRpNGYrRHBVSnAzSVZGRjNHbm1jTUZQSG1sZUQ4T1dudy9RbXRhT3cvVHRT?=
 =?utf-8?B?eklWK0VLMzEwYjIweWEwSDJ6QjJLN3hGMHMvektOVjFQeURFTW8vbTZlZGRk?=
 =?utf-8?B?R1ZTYkxTMmxsQzgvU2ZpVHk5d05mUUlzTnpJWjRvVnM4VXRON1BaNWxSd1Z4?=
 =?utf-8?B?Yjl6eXZvNlZocTcyUmFzTjFOTjJJb285UmMwbWpZRkhuMmI3c1VlenNvcTEv?=
 =?utf-8?B?ZzdGVVZzUkdSTkFQQWR1MnNFbFVQdEd3cnJaaE51aDhkOG5WemNrSFVTWlpm?=
 =?utf-8?B?WTRIbXdHU1JGODRLWnB2cGNHVGhMak55aXJkZnhyeHVCMzNMaWRzOURQUk83?=
 =?utf-8?B?cjEvU0NXak9LRUtBUy9aeVEyZlFsemc5UEd6SzV3dmNTRm5kOXpaQThsbVdo?=
 =?utf-8?B?SGVjQmhtR0o5bTJGMWY2RExWZzhiWWh2cjRxL0twV0JMNTB1RGg1dmk0Qkl3?=
 =?utf-8?B?L0pCcHFlcFhIY3hpZWNXQzlOcXhWSmx0VUVLYzVyQjFZMmZLTklnYzJUeDd3?=
 =?utf-8?B?T3ZtbjZLTE5qTUpaMGROd3MxN0tHOTM2a3Vja3NMU05yR2xiOVB3S1ZlQ2gz?=
 =?utf-8?B?UUhWYTl4elpwMEVwSVMvM25aZ1p4b05FUitpaWQzMWNtbFNITmU4YmROSXJY?=
 =?utf-8?B?SmdmVW1YVnE2K0FDNzlTd292NFM2bHlVd1hwbGl4MlVGNkZEeXZaUnhkTnJW?=
 =?utf-8?B?Z0xmRkNqZHI0Q0E5LzVGakdtcUllRm5URXdQOVB3N2pjckoyWUtvb3dtY0dn?=
 =?utf-8?B?NnFXb0tESHQ0bWpBYXZ6RHlGZFlkck8xMUlRYVZXeU9sRU1ueEFzRE10clVm?=
 =?utf-8?B?ODEydmkrSVAxM3Zvd2JNbmV4d2hMOU1RT25YV0tuSEROVDJQclZVQW9aazBP?=
 =?utf-8?B?WjM4RDJiZ1B3M1VEMEZ5c2ZKVW5aWlJ3ZVNNaW1teEJrOGJJZE9GWGlyNFd6?=
 =?utf-8?B?YWxWZWFld3NSMFN0d1pGUkR6SkFRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F96A6B74C3275240882C002F5ADB8E3C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qcOgzP0bG6PUB4Pv8lvviUhkAdUzdepciLu5DPVWMbEtWb4oMD8S4VKC/em2f7OkxeFRbRfElWqUx06rEQVTCygSPABBnNLObKGqTVS24OuXW4JFfQgmWARepaYgMyyfnAfmYJ5cQiglx1uZgoiJ1gIdTtde6GzeiP2pkJ5N2Lofh1xukmo9mFzyCzI68Ka8nknULwYOD0HDaLFAeZyAEoYD3brmOMiwVoCefoy3TMHL15rMC3BeZb5Fc1MPVdw4iPN0Y57TFMl6FmROjQGeP/2J6TFHqqTFAvfDrFGIgIvHiHQP4I39QQAbANE8sInZ5npkVnmzvvk5wOxgkEndFs6dnWoZJyDxz8IMALQz4vME75glwOqqlh4uhA9sPyeEUCEX+rSS3iTCfxRHsC1wfdMGtXGrOvztNxNE7Y+YfAA1m9YTNYr85a/PEwHvB7QkrGxb7tO3eoAj/C031s8JAgDhfUJsVpM7JJg7dj4DyyFFy69enVpw2uqDchqcAMIefZ8Masn7JZgR4eappmN8W3Ih7oSzmZZ38eu9EywXRPMDaSt1z095TlW+pflF6M2AJstyoUpAv4MdD6rw7YGgqpAsryBnG6LJyMke5phuLfBYKrcNHxOc0XjZqVvJwG6F
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95eb9fbe-5144-4d29-98c0-08dd77f5c986
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 06:06:08.7926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TxYw+NlKf7m23gYpQdzAAU9k8ZvokjjOiOxjo6kP0bKX5dxqe1GzFxbCLZwTcb4MpFsL9Lf6HNg1jie/nqtUz5FBtfOPlYzZqNlmk5JId6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6401

T24gMDkuMDQuMjUgMTM6MTEsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiAgIAliaW9faW5p
dCgmYmlvLCBzbWFwLmRldi0+YmRldiwgJmJ2ZWMsIDEsIFJFUV9PUF9XUklURSB8IFJFUV9TWU5D
KTsNCj4gICAJYmlvLmJpX2l0ZXIuYmlfc2VjdG9yID0gc21hcC5waHlzaWNhbCA+PiBTRUNUT1Jf
U0hJRlQ7DQo+IC0JcmV0ID0gYmlvX2FkZF9mb2xpbygmYmlvLCBmb2xpbywgbGVuZ3RoLCBmb2xp
b19vZmZzZXQpOw0KPiAtCUFTU0VSVChyZXQpOw0KPiArCV9fYmlvX2FkZF9wYWdlKCZiaW8sIHBo
eXNfdG9fcGFnZShwYWRkciksIGxlbmd0aCwgb2Zmc2V0X2luX3BhZ2UocGFkZHIpKTsNCg0KV2h5
IGFyZSB3ZSBnb2luZyBiYWNrIHRvIHVzaW5nIGEgcGFnZXMgYW5kIF9fYmlvX2FkZF9wYWdlKCkg
aGVyZT8gQ2FuIHdlIA0KbGlmdCBwaHlzX3RvX2ZvbGlvKCkgZnJvbSBzMzkwIGludG8gYXNtLWdl
bmVyaWMvbWVtb3J5X21vZGVsLmg/DQo=

