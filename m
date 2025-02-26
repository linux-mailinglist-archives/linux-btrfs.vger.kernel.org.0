Return-Path: <linux-btrfs+bounces-11869-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 610EBA45BCA
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 11:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F097176010
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 10:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1588E2135B7;
	Wed, 26 Feb 2025 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Lz5uJZGw";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="P/Mnh20N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905FC258CDD
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740565829; cv=fail; b=N8G76UNGLuXk+4J8xmKOyoUgkbBEP7sDSyZjMLiVNgWLnos2cWUquYf30dET9ga7xWOGplNrDtD2tPcWdsAYFNMmTNvVdjV0wqhBAq1Q93ILbXJB1AGPOBynmPfI3sU3XxJ4ctfkabkqiJgpdDWkAZ0Qzyzh1U6+Ad4PVWmh9iU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740565829; c=relaxed/simple;
	bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fzWQ76tnKvOpSlR0D63+AjtRlYA8btiRtJoj9nz+DHR22AU/B0LxSPxqv+ohnoXA2849jvi2i4FwsKyYekHhxsFzF9SbsyX0iyWZtxnhBanQuLvn/j1gZPAnPDHLzB1jNkKEpbitAycspH3VWT7KStSJN4QE4h5LzgiufvCRNYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Lz5uJZGw; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=P/Mnh20N; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1740565827; x=1772101827;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
  b=Lz5uJZGwEcWads6fmNqeA0Wj4B/RG6F/f6PA2yU1fAGKtYsnJXU+ZgwD
   jL/7DUfPqV9VKTzyZOstDkxwCNLRSAww2kS4oQQLk+W90B8PJOYqDDvYo
   ky4Il9xs05q0NRM5KgWU4jncEkizLKWTdVrg2FJp/U65Cyy8Kti7/+j6R
   TbhHqgjbaxZwEpeZKhJhh4FjaeBsFTwStorn6PBD2eT48gzB0FXgvL+Pg
   1KCU0rQNdD81Go4huu0y87WQgk9XsEkU2wGOlV5N5U52QN+F+3eDl56/j
   1RibQIYQEEtDrXz28oLKYOLO2eMtMs/tpZKR0t4eMOvpPx83hKP9bvPtt
   w==;
X-CSE-ConnectionGUID: sQwc/1N0SpS3xANwdCA3Cg==
X-CSE-MsgGUID: L7myzbbrRf6ahVJslqMzPQ==
X-IronPort-AV: E=Sophos;i="6.13,316,1732550400"; 
   d="scan'208";a="40201410"
Received: from mail-eastus2azlp17010023.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([40.93.12.23])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2025 18:30:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDSzapu7DaryR9zJZVggQiZ2sbw3AQiTpSjWFN/N0dwc+b3Q1Ad8ltiGd7ykO5BKgBFl7zKKzIcXpfejcJBhLFANC0GVYpn2huYU8zp67trmXVzi+zRvqA7hg8lhER1WBz3K6+lhGHWYMzKEgSvLjneJrLZfr5PbFLBAjjBHeS+ejqzOJr+gRTji4f2fS31Dv5r0kf2cwBxxjzbab0Qww0DKiqnAFeXZbRXJmG2FnF8P4LMvwjUOWanrdI6aaV8ZudzSFyFLUPBf3Fyx8h+PtlGpzxkJI5TABtOYN4albhBdB27RqH1D46K+7tOeXfcykwdnTynNb1PGZXcIS2xn/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
 b=wZCCqKw9889AcDZqdrsf60qej/SnKDDfmWWZcbaVOsqFuHWvDaoLHBBdtvWyJAYb+Jn02DA92kmQ2ttKfl5qegqgcpDp53oyygVAvH51I5wBAFtQLeFkvQYuBJO5loY7xXKWybgaquF+FI4KPNWZm76j0BOc7WKFLxTBgHW3MkelLhJ8zHy4d1RCrKADaNbQU6UEntOOXMWjAa7j6bWZbtCkYp/s/KoXMSXJLsJ+3bnTDKh6cybD2mGxbfr237k9mEUp842N+nhkVHfI7Afy8kwg5P+aWQr7YF64OG+qt6c2bAfmcxgVck0c6ltyz1PIBMY52Uk3wh/hvTkMC1iIoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
 b=P/Mnh20Nn4qB5P0rKnrhtBq4ySeRUMi3WY2ubSvXxXTBRk36/ijC6gYLSE1ckRpHXa+kIS5m/5s3gH7VZ4g8eMUwwOZx4YNodAP8nfi2acbmjXpxvFRvaxtd7KvtJfmhD1Vn5fVM1FgoLRQHHGo+frLxScpdENvlqyYa/QyftZY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA3PR04MB8747.namprd04.prod.outlook.com (2603:10b6:806:2f3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Wed, 26 Feb
 2025 10:30:18 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 10:30:17 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: David Sterba <dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] Extent buffer allocation helpers cleanup
Thread-Topic: [PATCH 0/2] Extent buffer allocation helpers cleanup
Thread-Index: AQHbiCeay58gAXnfPEO0lckNF4Kp57NZYouA
Date: Wed, 26 Feb 2025 10:30:17 +0000
Message-ID: <610c204f-2a21-4c22-93a3-1f78278a7cc6@wdc.com>
References: <cover.1740558001.git.dsterba@suse.com>
In-Reply-To: <cover.1740558001.git.dsterba@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA3PR04MB8747:EE_
x-ms-office365-filtering-correlation-id: df9950aa-b7bc-415f-08b0-08dd5650906b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q096UW1HZkI4aVdPclVhclpaSmpIclR2ZGE4WkRVZVJ1bHlTS2V6emVQUC96?=
 =?utf-8?B?U1NIUFRsa1MweUt2OG1xOEpnNkQ4RlAvN2tiWDNyeTdrdWhGSFNCZmhKVERn?=
 =?utf-8?B?UjJhQ293QkErU2NUTlVCTCtEcG0wOXFDSFc4M05hRmZQQ0xFa3BJQURiZ253?=
 =?utf-8?B?WWdWRGZOQy9kMmwxUDdNdTBaYitCeEJLNllKaDhwUnk3N3MwWkU2TEpSYXRa?=
 =?utf-8?B?M2ZMeFQ5Qi9BS2xVczZ4U0hLS1orVnFNQ3dWVHlpZHdmd1JjSHVJYjliREJq?=
 =?utf-8?B?aEdYb0o2M2sxM3U1QVdrU2E5L3NOL2h0dWdaUVVXVktHenBKU200b1RUMkZr?=
 =?utf-8?B?Qnljd0haN3Q0Y3Y2NDhBaU40Y3QzUDIvSFlVMUJBeW9yQ0lXMFByYlFEVmtS?=
 =?utf-8?B?Z1JvNkhnVCtJc2lhMEdUTHBBYzJZckphUmQraFpON1RWUmRlcUJ0ZVcwTjly?=
 =?utf-8?B?QlprZkhpZ2pYRjVxZTNhY1RFQnEyRzZuZk1FRmJDYWFCbTV4a0ZNVnhtTzl4?=
 =?utf-8?B?TENUbk16dW5RaVN6YmlubkVpVGp0bjV1NFlJaGQzbjdacGF4S1RBMVpjSVVk?=
 =?utf-8?B?cWhlSWN5T1lLN2FYUWFKdFlPUUlRK1NqOUY2UEJMQ1p3dlZ3bVcydUlRdUov?=
 =?utf-8?B?Nk5IU3Zwb2w2bXphZm1Mdmx1Y0NDd0Z1alEvbDVmbzBnRzZQRjl2MFhBQ0tq?=
 =?utf-8?B?OUwyM0ZVSUNCS0R3TTZONmhST0ptK1A2NURTVU1lYzEzVDFyZThmblYvWkVp?=
 =?utf-8?B?dTJnVnhDaWUzaW1ZemNpYnlYb044Q3llNkNJUXozZitLai9JOFYzd1BUTjMw?=
 =?utf-8?B?QjFiMjAwdTNkQW9nODZOekxnUjNqd1ByV1Zzd1lRcktTOEIrMVRBQXVNU2tM?=
 =?utf-8?B?bFAxQ0IydTV5aXdCVTVHb3FKYmtjd1VmbVJWeXY2aG9KNXd1bjJIeVBGaGE0?=
 =?utf-8?B?dTBsaXNoWEk5a1FDWUVtajVjbnFobDVHRE9MNVlORlA2TGFDZFRlcjZSSjFv?=
 =?utf-8?B?RzlscjdHdmtnVnJEQUcwTkgwT25tUXhJTExIbVd2UzYvR1NmZnpPbzI2NWRq?=
 =?utf-8?B?YmF3eXp4RmZaQ3I0c2ViNTJ3S3lUdHNWelJkOXAzZXpnMk5qZnBWdzBiaUli?=
 =?utf-8?B?dWlCdzJET2RqVkNOb0FGMTlWRWFpd292d1o3Qk1SM3plL28zNXp2REdkNjlL?=
 =?utf-8?B?dE5nZ2xwUU1UeFU1SDNEaWFSbEJFT3V0MEp5MnF6SWxvMVo1ZWlxQldtOEdZ?=
 =?utf-8?B?bWV5VUVQTGFYMDBkTHlMSTZRWitSNXRyaGpkRVY5eGtKb2lxWW1oOUpjN1FT?=
 =?utf-8?B?YU5hd3I4MldpdnZsdTNuOU5qckU2dGhIajlCZ2xLamt0bG9ES0l3eWszR0Ro?=
 =?utf-8?B?RnRNRGhkNVNocndZV0RnZGZuWmo4end6VE05SHh1czk3aFJVN2lDTXQ2VmZT?=
 =?utf-8?B?Zkl4VHFhcG9lQytrNjFvdmx4aWZXRy9BUXBQWXhCLzZ3M3N6b2lVSXVLMjQ1?=
 =?utf-8?B?YndRdFYvdEJSR01zZXczRmNLUlc3aEJUWlVMT2UzVm5pYnZGS3E2LzROTEM0?=
 =?utf-8?B?VFlGNkFvTmF2RlArTDJKZjU2OXBIV1hXYUNORVFiWnM4S0VBb3NrMVpPUWIz?=
 =?utf-8?B?Lzd6dElEbWNYUzY3YkZ5djhZbXZzREs1N1BYL3d6VW9HT3c4TlMrVXhJWHBT?=
 =?utf-8?B?eC9JUG9lbER4T0dlYTRWRld6N1IxVEFXWXZOUEgzR2FUMHlPN25uTXBrT3pi?=
 =?utf-8?B?RFRRMzFxL0hsL3VwcFYvMVBVeW9Kb3pOaklidS9Wc0tvdERhd3pObjJLb3JM?=
 =?utf-8?B?Sm5sZ2JaSHBTSVBOMDRicjRHNUExaTA3b3ZvUnpBWlJWYWsyVWxGMUVVR3Ru?=
 =?utf-8?B?YzNWZ0UrMFo2a2phWTB4MlN1ak5HWk52NXFhck5GRjhpZXdyTHFjS2JsRUVP?=
 =?utf-8?Q?Aj5KD+VYqFZIOLIJbnHH6lLRP+G6qvTA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RmZjRjA1Ti9hOWUvbWNrczlNV2VrcmNqSjVFaTFDejJ2QTZWYk5FNHdmcW5I?=
 =?utf-8?B?QTg1NmZmMlpCcVMvaWN2MVdianF0YWZla2FQQnN0eXBCbFZNY0FqVVowZlFz?=
 =?utf-8?B?MEx2Q01jdmRhYm43VnlZdnlrNE9yWURhbHlhbTZYbjNsVUUyT3VwNDZRUU9R?=
 =?utf-8?B?VldXbVc4RUhaZmI1RWkzZjFrYTlFOXFNQy9MbkY4ZTArNUtqTWN3WmtHOGhi?=
 =?utf-8?B?a0pSWW5lNHR4bmpMRDZ2bnV3VVQyQUtWZkFJQWRMMlFPNVQvRWdGRHp6U3RY?=
 =?utf-8?B?RWZkb3ZRSmptZTJ2dEVFMSs1dnpvVkExdkxJSE9kenZEWEhmU21WSWJYaXh1?=
 =?utf-8?B?ejh5cWNnQXoydEovcUw0Z1Z4QUc0SlhvRjBObTkyeFFzeVVyRk1LWG5xVlF2?=
 =?utf-8?B?WlNjN3Mwc1A0Q0dCaytmZE9DU2VhV0tEazlJclBqV1NlSVk0aGwvaE1pQitI?=
 =?utf-8?B?bnIxNEtFSlB2eFF2bVpjTGEwS0xaaUk5VEF2R3c2N3Y5bDFQZUlJdFBYV01v?=
 =?utf-8?B?YVVmeG5laXBTVmVTNjlWUkJmaXMyZXRRN1pxSjlPRUNRWHhPdjZvSTNhYjdH?=
 =?utf-8?B?eDc0UkFXRXJKU1FOK002dXpGUXoxNGhyQnZCa2xkUDhuRXhNOXFqSEFHZGU5?=
 =?utf-8?B?b3d0MWFEK2tRRUxvaSt6R1dQVU5xd2tlMis4OW9WU1pYTXZuUHJnSWZiNEdi?=
 =?utf-8?B?SWYrK3YwcXJLTDZqY0Vzanh5NVJHUC9SSnhGQW9GVkI4Z0lQWGJvaFBXWWV5?=
 =?utf-8?B?Ymh2WmVlSGZHcnB2emNFM3UwUVFWcEhqMUthdE9iOXJOb1VTKzZMbTVEWHN1?=
 =?utf-8?B?dndrTmlzVVg2QUdZUUZjaGc3UVd0QzhXaXdVNjBCZHViMGFyajJ3MEhHaWwr?=
 =?utf-8?B?dmxidXhra1NDdnRjSDROWFZCM3ZvbFBlTlFTQnQ2Q0dDUGZ3dTZRcWt1dFBR?=
 =?utf-8?B?Z25hM2dqZ01mRlN4Mmc4YUxpWTl4YTVqZEl2YjZ1TVBIdkdOK3Q1MWFTWWF5?=
 =?utf-8?B?VlRPaTFETklMWjZZN09XQXpYUkw3UmhJSWticjdLTWQvWGsxNlNqVEYwa3Y4?=
 =?utf-8?B?L2EwZnZORUFWS1lxcjkvdVUzV3BPOFlocDl4WUVTUW9OUnU4OFpDQ2JXRDF6?=
 =?utf-8?B?ZngwR0d0ci9nOFdOOFBUKzM5SldZK0FwQlB0YzVqTi82aGo1MjR5eWJDQjI2?=
 =?utf-8?B?dnhQSXRqT3BzSDVxU3FwK1lBN0VGU0x1UTg2S0xhakk1MjZIWnF6a2RsdWVL?=
 =?utf-8?B?VXlHZlUxMTViamhwVXJYSGtJR3pkdTFMYWNLZVJreGRGNy9kRHI3Z0pPa2w2?=
 =?utf-8?B?emE1TGpFOGl1NUtWZU4zTHIrWTlvZ3p4N3JQaXdyaHlnbUFwOWYzQk9iRVo2?=
 =?utf-8?B?c0RpWTdwZ2x4bzRSM0FaMDRQZDlvRjVxR25ha2s1YXU0ZGlTbUc0ajFBREJo?=
 =?utf-8?B?ZFJpQTRlV2JQdnJnbWU4LzU0UnhaM1c0UElhRy9CNm9MZi9BbVBwdWROdSsy?=
 =?utf-8?B?WFFOUnpYWlN3MVZCTGN6d3RPQVAwL0RaZVdsaEMycXU0QmZSZXZ6TGx2T3pN?=
 =?utf-8?B?bmIxRURUSEZYZFp2cm0zY2dFdG8wQklMa2dzcHg0ZzhhMFczWDdtbnBpUkZM?=
 =?utf-8?B?ZmI4VnF0MStwSnJmeW45TXBCanFvdDVkNE8ydzBzcExpVlVBZElERU9JNllF?=
 =?utf-8?B?dHdnL3hwaDVxbUQ1TE1yRU90VSthZjBxNndLdEhRc05KOEJkTkZtNjhHb25T?=
 =?utf-8?B?QnY4ajN0U2VkL29aZ1htQ0JaMlJvb1pUMXBZVlYzUmQ2eDhHWHExcHZwZjdi?=
 =?utf-8?B?ZUk3Q3ZoV1N2RkZ3QUVkNWNVeW13cDVVU25lRkt4dlFyVk56dzg4a2VKNGtN?=
 =?utf-8?B?cW8xamlwZVpnNndXVjMzL09kUXhaZ29vMDhlYTkvaHdMQVA2SXZzZFBydXd1?=
 =?utf-8?B?YkxZT01Xdm84bVJidmlQWXBwOXBFWkUrU0tPenhNdml6eTF1ZVZxcVpTaG54?=
 =?utf-8?B?YjZNbVlWT3ZxbUNDOURBUVBiSWp1cjJtMTl3V0tMTmFRb3FqaHorVCtwbEQ2?=
 =?utf-8?B?Qm9adG5hYThNQmw1Vkk4S1NRV1hXdnVVWERpeWNmWHNwa3EzMXJXZXU5ajds?=
 =?utf-8?B?NTVzUlorVlhKQisvNjhCSTVKTUdPL3pkMFkvTkJ3S1EvNS82WG91aC9zRytL?=
 =?utf-8?B?U1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1624290B118B304BA7ED30FF3A1C002D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WU1cSdVtoEp+B3WHuTApUAXZfx3Ne70m7LL9UFtbnwK7cdFdXr+IJEDclEHXEfqd8XTxwhSKE/NkXOkvpOz6JAQfn5TnhN73/zUUTa89PrbZRjmKCHaSj7IwwaPafvFYtEHaa95ulqRu6meQ5YtM8Qk/+TJCJl2paMK++FnX2YgAVgvYb2V/Ql5Qz35Ka3F6H3/MAypPXnmATHCq7s1Zn3x5LP9BQAnNtZxEy8bHIAj+YhO9rbqz3lm+6r7QJ9jcoOZMrf/lRmsfkx6ns0j4UjDMOcV8pU/IhNMjMEHmat7TOwBo0cysLM4rfrnhX3MBdOsK++NGFWzvwBlWC659pyiKBvAMqUnLoUA08HcBxlU7g6y4cAI2h/o5MnKM8HxBsej19gUAIAtfc0v4gkqsxLLZz6Lfx5pvmm9C2mSdxrUqxK6785CGKUf8stB5/tiJ5ewcoOkEv00cuV9oYRlggY7NEXpJBNj8kEXsJ8K+SG6hLJrdLcn+RYxfmUdlV3vVDotykCBVWX8z42aPIrCMYDk1nRzK2p+sESLQe+wO7N+OtuFni5R17UiT9TKi9NZefXMa8JGQG/luGIH5qmelbQwiCmWYBMTFQrlugLGN+r2rJiaAOTzz1LzC4ZfJ4/ge
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df9950aa-b7bc-415f-08b0-08dd5650906b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 10:30:17.6692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9DD+zTtvF2agblWAj8MN5VqM6XmvGsu2z59lUpr/xyvjhkWNxDcE82SZxLsYlAeKw6owWjEA4cvnxoEfte3ucwa9mblT5GANCTkhIM/nLGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8747

TG9va3MgZ29vZCB0byBtZSwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFu
bmVzLnRodW1zaGlybkB3ZGMuY29tPg0K

