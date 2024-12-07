Return-Path: <linux-btrfs+bounces-10108-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE119E7FB8
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Dec 2024 12:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCD5628243C
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Dec 2024 11:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1953B13D29A;
	Sat,  7 Dec 2024 11:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lrfO/pcu";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vC5MZd1f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5CC84D29
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Dec 2024 11:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733571310; cv=fail; b=KzVWOnCdJYebUdfeXlHlFBPt2ZdALRWjFNbatv+S0+zRcd8WbJS39zsu8UwJhzpxViwbg4nJWGTIlnd1hVHpEQzOf4KYcz+50kMEeaMcpSU4Rq7dxai6V/VRLShFixnhT/8nZXQw2sQxpI99pGGuKtsumyD5BFCEwAySgWs9jMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733571310; c=relaxed/simple;
	bh=BsdheWlx5wZ89LlmSlNmiB/oANeKHfzQJjyBuzOtk6A=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iNYRwVTiuHk/DNfb+O57x0OVdyv/WaUjS1YbhV06j5SlBCmbEtY7Xq+7aYWpIV+APlOWWBkn4pgveBaR/ilpqXjotSrNKUzcqbOHE8tehETMGBJVecxtbQUe1x8zop2aieKqCKt+tw6/setYUikRM3zmo3u5wcTQIkuwllvTBXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lrfO/pcu; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=vC5MZd1f; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733571307; x=1765107307;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=BsdheWlx5wZ89LlmSlNmiB/oANeKHfzQJjyBuzOtk6A=;
  b=lrfO/pcuYqn2u6t/2mFhLkT045C1qLQ79tA8Fvfy1eXNQheI0vbDSA+B
   8vEwtroNJUErGLTiAZd8/sXjh7Pk3hDkwMMKudu/3HqGkLvcmQJHq3WtH
   xcIM7lWFj9DPXLtxg0ncGARD6wb3L94WJJr6kWeYiN8zk4Sxu60RztcWR
   lhV7GYn636YC568EppL3mA6MyKkLDVshJHpptIrICuse90E1R9DYx3sSL
   5X6o9hd8EcfVq3Yax6Og5qIL7lYH8CkjF39cOkCEHoL9pehRSWn11DHee
   IRf1CCD2Gbnwd86X8i8Nc8PQCu/Jmk+0QjaCTxNxTRCqtX5VWCsdeRlr9
   g==;
X-CSE-ConnectionGUID: 61Z4WZ3MQna2sYXBWF6nnw==
X-CSE-MsgGUID: xie8g0NDTzyQMy9ZkTk+/A==
X-IronPort-AV: E=Sophos;i="6.12,215,1728921600"; 
   d="scan'208";a="34403517"
Received: from mail-eastus2azlp17011030.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([40.93.12.30])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2024 19:35:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UlbYGKNNHp6Bu3MIwB3inP7U+JCaoiFg3wCchn98pFBA2qYXVqZsitTO9j6PA0gw8gDVRNXgO7+v+1j5LdFJOX9LWOEjqgDiBIoZxngzNNAjfonNd5mLG3xTP3fCi9d/puCLXnJYKv1DvJ4aN1bMSC36Hbd51dRdtg7WDxwISSIhaZ7j4ecf/kE3C65SfI8T8VdaMft+ItB1OyC61hREbCEUqK29VkYat5VcZFjGmi7YqnrURRw1SXsvwcqAsG3qBl0f7nArXWZB6YkCyftWb4Mo1j3brlqa0Qpa2vLWYYncEHDIxEye+H3CicaC/mzudHxktqyw8LNmws1PZWTlAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsdheWlx5wZ89LlmSlNmiB/oANeKHfzQJjyBuzOtk6A=;
 b=VtnPaWqwiXQJyG8+R3FUPAgF8OoCRDcLelWq1wsICVwP840qYQ0PbS5AwiFjsQ4mjgCztJlhv1tMXqm2D4loi1ILesEOdLQA1Kw1UZ+ZuMYBrBzRGsYYu1EL6hP0/VHgRcpEJQJVjQphzGPrxhFZrLIZ01OpCqTSSL/I2lahIIm10NmW33uufWcONEUM4Oz5zcVnTVmsQqyNhDGM40oHKxYCZVPjiHLpcTZeLA4U2qdMtWpA3i28dY8fcEuMOuVSVlk8lYKev2OaDz/oBiZywY02tVJ4sn6wW4YpNr9Cx/JP73gI3PHIDb1PYeyzisbWl0ixIGL0P5hHtTWJ1xJH7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsdheWlx5wZ89LlmSlNmiB/oANeKHfzQJjyBuzOtk6A=;
 b=vC5MZd1fCxbXJcFOAM7XUo1Cu3ANzBGCYXO7tUwN9w21bhiWfhA2LzHF9AJHnX22x/4Wzzte+hfP7HNiy2aDvys6DNwHrqpCyNE5WiykdaIgLI2b9OEttZl+/RM4eC/aZunoLqxzO4MA8NZfiKOUiElUzhHMDxFxxWH1jFqaX7o=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH8PR04MB8614.namprd04.prod.outlook.com (2603:10b6:510:25a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Sat, 7 Dec
 2024 11:35:04 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8230.010; Sat, 7 Dec 2024
 11:35:04 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 00/11] btrfs: zoned: split out data relocation space_info
Thread-Topic: [PATCH 00/11] btrfs: zoned: split out data relocation space_info
Thread-Index: AQHbRupW2rbtRZyqD0Gpc3/MLXVIy7LaqkkA
Date: Sat, 7 Dec 2024 11:35:04 +0000
Message-ID: <7c716895-1c7e-45d7-a3a3-e77e32535301@wdc.com>
References: <cover.1733384171.git.naohiro.aota@wdc.com>
In-Reply-To: <cover.1733384171.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH8PR04MB8614:EE_
x-ms-office365-filtering-correlation-id: eb7ef67e-2682-4768-ab4b-08dd16b331ce
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T0dNMGtJaytkUGkzSGdIR0dHY2QxOHpNYmVEeHd3NzJTZzFJTEFGVEIrN2dW?=
 =?utf-8?B?aEdJbkorMzVySmFuN2tsQ3JIdGM1WUk1TEJpdGFYTEtOSUpxU2EvOHVjMmdx?=
 =?utf-8?B?Uy9YcHBNMnJEMmEyTFk1TCs3SzdPZVB2RUhFM01oeUczdG9oMmNhNXBzNGt0?=
 =?utf-8?B?RXlPTG5HYlhtenhqVE5GTVNqVmRJMmd4K0JPbVFod1RBdDFLYUx5MVA2S21K?=
 =?utf-8?B?UUErQ0xqRzY1Rm1CYXdaU0JaNWt5K1BJYmJmV2M3VnRzVldsdWt3alR0alg2?=
 =?utf-8?B?bjRRNXBDaGh2SW90dWU4VktDSU1RVEorWTVkby9ySkJaTi8rYTJQMG01bkMy?=
 =?utf-8?B?WnE2dVcxSkh4MmIwT0U0ck94TjQ4WUFncGlZMEREUUhmeHllZTRBT0ErMlhr?=
 =?utf-8?B?cERGaVJYN0YveFJpVVlOZXA0T1h5MFRJVjdQOFA2bWlvellmbUplbldDa3Vr?=
 =?utf-8?B?bFpMcGF5VGJMaUZUa3dvdS85TjFBdGJFVUduYUFtUmJ0RU9PTzhydm5JY29Y?=
 =?utf-8?B?NGdIU1hkV01ENnBXbmU4YlBHOVQ1NExLeGQ2OTl2blJpMFJvZmRKblVlVGpD?=
 =?utf-8?B?UEczYUdCMGRLZk5VZFN1U2lVdzU4bmlON1M5VGprMUNXLzVyZ3RrRW84OXRI?=
 =?utf-8?B?QjVzYklDZ0VaYVBnVkFHMXpkTkZ4aFhNOHRiZlZkQzFFaGFmMmtsQm9KaVNs?=
 =?utf-8?B?U0M4VnhBZXpHRGMyZ3l1UHRQay90dGl5QUtLU3JIUTBQTUJ5Tk5QZktGc1Jw?=
 =?utf-8?B?RlVLTUxsMzdqQjVXVWRpcG1NYm9za0s0OXVHK2dIOWJ5alZJdEtZcDlIeTBT?=
 =?utf-8?B?NnE0VGdJOXMwUmpocndXOUJPQTJaNW5nT1pCbWxPOHFURDRyZVJMN2ZjSENN?=
 =?utf-8?B?bndVYWZwVFIrbVJYbHBjUEk3c0gvVU1BVzhJZ2srbkxwOXAxNXNEWEFmS0Nz?=
 =?utf-8?B?Z2U5eWRCNDlIS1V6UmdHM2tBRWxGUDlkSEJ6YzlaN1BpY0JmNFMvVyt0SWdk?=
 =?utf-8?B?RjN0M1JaTTVhc1dqdWJmK1E2VEcrNDBicitEc3dLbm5IdldsU05TKzh3UTBK?=
 =?utf-8?B?R3d0M3VDc0QxS3Ayc2FOQ2l6Y00vdUJZSDEzTHh4aDRwTFdVcHpIejlxMDJx?=
 =?utf-8?B?cFdJdEZ2YlBmVHo0YXdEcElxV0hKZnN2V0pvK2V4SUQ4Vm1HVnFKbnFmcEEw?=
 =?utf-8?B?QmNXY0Y1N29vdzBIUVJnOTRNVDNucTRnMUY5NlVLUmVIZHVqc2daa1pkSnVO?=
 =?utf-8?B?VUVXUHJ0MUNhaXlzTWppY0x0Yk16QzU4UlJGL3pNbWFkQmlWdnlFQ3k4WEFP?=
 =?utf-8?B?T0tmdGI5aDNpZm81SGlqV0xIc1BIQzY2cnkzTUY0SzRFSFMzbVpKVk5oWVVW?=
 =?utf-8?B?dkV0bjY2Qis4dWtQVVRQWmJYQmJlWlNobWNnWkxPdCtVbDN2WmZOM0lWRmFa?=
 =?utf-8?B?a1FOZHBRc2dUcGNkTk9TSUZJUW12RWRPRitWYXJoci9VN2dSUTF0TXdFK0h2?=
 =?utf-8?B?NHU2cmxJamlha3FNeGlaVnR1eEpxaFQ0NXRId1k1RjlJNjB6bHRhL1poNGlB?=
 =?utf-8?B?YXk2eFJybnN2ZWNKMFdWd05DQWhUbU55RjB0bzBFVnNvY3RHRFZUa1BwdmxD?=
 =?utf-8?B?M3R3Y3R6V3RjOGNDWk15b1JpcWFxYXIzeURyYnVrcnpsMDY2MFpLbGlUZnRZ?=
 =?utf-8?B?Wi9KWUw1SGdSN2xVVWEwcnI5QTh3TVFxd3ZLWXJtdGtram1PWnZOV2k1YnJx?=
 =?utf-8?B?TWRJTkowWWRvWEFsb0RHang5a0xyK3RFRFpORVZnWVNja0VmNDRpck9ETmll?=
 =?utf-8?B?dDh2NExIYURGekVpVi9uL0J5NjhhSWQ5NnNTbHk5OUcycFRkVC85VE9PUjFP?=
 =?utf-8?B?YXRDSi81dEY2K2VNbEZYbFJrZVRhY0h0QTFlK25BMjBRUGc3VEw5UlRoaEcz?=
 =?utf-8?Q?GEpGYYS40Tw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RVVpQWhjY1hFR2VKSS9NNk9yUWFFUmRwQkV1ZkVnSlhzZEgxV2l2NXJRdnU1?=
 =?utf-8?B?eVBVM1hlZ2VNYUg4R1laVURMUjd2WjVVeG9CODY5YzNKUm5mNW1hQmdOc2JL?=
 =?utf-8?B?WmRadE5zRkV4OVpsUGNSNmJ2TnJoWFM5VndId3krVG0zMmMzSnQycWYrOVY3?=
 =?utf-8?B?NXJFZHU4S1BkU0htak0rV2x5L09ZSEZxLy9SZzF1UUVRclJaT1Nta3RySVhu?=
 =?utf-8?B?clFmMEo4MTdWTjIrSmtpVHJvclQvOTJORzRIWWZPWitPVFpEQUJ1UGdqUEVY?=
 =?utf-8?B?bzA3QlNSRmdiN2d6YWxmNHFVVUJ1Z1NnMXZRWHNqR1NqaHVPTEd0Z0gxWEU0?=
 =?utf-8?B?NXVCUUN5bVJZbytyMmdCTHJoMmtPNkxuY1NUcng4WlM5dGlPVDdMYmVYNzNE?=
 =?utf-8?B?R0d3ajBQR1AvemgvVmtwK2JnY1laTjFwcHlYM2JQbE12MHZKVkpzcnV6bVB1?=
 =?utf-8?B?WStFc3FZQ2hpMzc4cGlGWEhDWWRrWnZyOGQ2clNoeXpFcGhKWUMvU0xsM0hS?=
 =?utf-8?B?Z1BvbDZESEwxcVRtQy9FTithb1NTM0QvUGhtcll0amNjNStFbEw5MmVmc3ZR?=
 =?utf-8?B?NVd3aUp4ZWJhc1lWeE15QjUwaXBWUkhYK1N0REYwSFkzWkIyL2pFZjZJcXVW?=
 =?utf-8?B?RkM1cU5idS9sTGpNUTM2RHVXbXNkM1pTc0hHOFJVQ3BXMGdseWVzUU1iaDVI?=
 =?utf-8?B?SVUxeFRDeGNhdGFhRXM2US9ySm14NnZMUzYxMWxCdDBiZzJNNkVNRm9BeDc3?=
 =?utf-8?B?eEpSN0FpbEVGczVJckpTeUJHeTRkU2pIaXowZW5yWTZkTUJsemVNb2ZlaWVZ?=
 =?utf-8?B?SkEyS1FwcUVTa3FVUkg2YkxtODUyL1lkanQ2Z0JTOUxMRG5DMTZOTFFGbFp1?=
 =?utf-8?B?VzBoTlV0aUNnV2xDbWdXb2YrSW1RMmtEY1RpT1cxck9NTnFPMGdia2xIMldV?=
 =?utf-8?B?QWo0SWU1ZzdsQm4rQmRyNWovaDJpNzB5NDdHV05rUmlzVnY4L3JEUHV2S05j?=
 =?utf-8?B?eEhmMnU3WGl3VmJFdUUyUUtkZHhsZ1ZFRWtLSFRNeU9Da1ZMR3hmN285ZEU1?=
 =?utf-8?B?UjFBSGNIa0xVVzk4YTA1RTd5blJpYllkY0JQZThYZnZoT0NSUmtxYUVEd0xF?=
 =?utf-8?B?UUl3ZTZhM25xZjM5dHVRdGgzOGpDSHBMVEx5Y0lqMXBLS1pkdjkyZDBFQzlk?=
 =?utf-8?B?L0NRdGwrZkc0ME9uSzNWTjhUV1NmUloxRlFwYm9uRTR0M20vaUdjbW9Cd1B2?=
 =?utf-8?B?S01DN2sxMlM5dFdUM0cwYitFRDdQMnNHVG91YXFIeFhyZEVFbXA1NExic2gx?=
 =?utf-8?B?RG5EY3pvMmRUSSt5czJ4UGtwSkRvc2FBcDlvZVBkSWhHaXZCYlB6V2pkbUNU?=
 =?utf-8?B?L1VpZ3l2a1djV1IrQ1NGUnBMTGFHZXgrUG5jd0huNEt4aVJCQmJIMlR4Wndi?=
 =?utf-8?B?YWZXT0tGakhBOUI2K25NMnEySmVZbzZuMWQ1QzF2QlFIMjlaWVRvWWxOS3cw?=
 =?utf-8?B?amhrZm5yQzV4U1JVbmkySTAwYi9OdkZPK0ZIZ2ZpUFcyb3FjT3B4c2orTi9m?=
 =?utf-8?B?TEhGNko5eTBGKzU1TmpnV2dFZ0JsY0NpNno5ZEZnelg3Q3JlQ0pGbXBvYTJX?=
 =?utf-8?B?YWFkUzZzR2lVZURuL0hsQ05LMzZ4SlVQcm9seE9XRjN6bHU4VzJqR2hqNUV6?=
 =?utf-8?B?KzZTSWx5MFk0SXIxQ0ZpZ2c3ME96bFRvbGdHVnIxSktCdlNTRzc2YjdvN3VB?=
 =?utf-8?B?VmVTYVFpN2RYVGxiTE5oWjVxTkNNQXhlY0dFUWJsSkt1RW9QRTl6Z3NLTEtW?=
 =?utf-8?B?ekJXb3VNSjVqYWlWQnBOaFllNEdGSEF4UGJSZ2xxQVVJWStsSkttQVE4M2Fa?=
 =?utf-8?B?WENLQVExN08weDR4N1lMRkFUUEQvcWlXM0s4eGJWRkVITUNzdlpqRWhRVStO?=
 =?utf-8?B?MEZmMzF6eUxoRVJFMXZsRlpkU2VSdjVUQytPTWVRK2daVDJyUGZicUxzNjhy?=
 =?utf-8?B?cmlmTE5MRk5ZOXNCbENBV0REWGNha2NycFlucXB5b2xzNnV0VnBVRkRvUjRQ?=
 =?utf-8?B?MkFENC8velU3RU15dVhiU2RWRzJid3c5VGlZMDN0c0xyckxjd2Nzd08ybjgz?=
 =?utf-8?B?dUYrM3RKcjh0OHVJRm1xakFSSTR4YlpJaFgxeUFZM1dJcDZLUmtTZU1PV0Rw?=
 =?utf-8?B?UG45VVh5QUwyK25oN042V3hNSEE5U3ZBTkVZNTVSeFMrWGMxZDdqeDNoZU9R?=
 =?utf-8?B?Q0dRd1ZObFpVWGV0YlZmaitkbThBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C17F19AC669C042A5864BE06F59215A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z1cZA7epf1Bjw0ak5qdjAKiUFUMtU17d37ZYSiMYtFBG9kJjzadZ2YDCTBxLO59hbOLHHyCz/EauacatsGmvh2trHVLUSHMIXcy2JP2BwOHU7FocLh0px7Txz3JnfSfQZLltahtaU7X9OpsI7dGpoHYnfRYDZkdvap1vDbYokDsLOrRScMyJQPGyx4kG3Qs21qk+CgXbEEzsrOzZDPN0yxm7TMC/tSOwq3MzZHaEQpFQW/3QTGJA9YIirzOSgKjcXg4NuJ/HIF1vFQE2qihuXnEDw8nDMVvhjDbXFirYkzymHjQVckyfyQsngUYJ7o3h+UtTwOgANk7YelFQ3N6Gn+EQivzFCNzYo6dsbtw1MtoNbQcLK/1BZz9Cpzq7meA+W65WFJCfsXgFzcak69GIVwqrrxTpvkybBQL7kNEeWqueHKuQt56uBsh9ISCYk4Z63YR/Onb1xBavo9igxeMXmJBQZe4gsfjVvm6K0aU1pWerVaHGvtNIRal6Te4UOv40QCBQ9x8l3AZZgl+f7tqoFPQoIKJz6F0CD57NIeKBhBdKO6Go5uzzIU6ZcORd3q1qusodXl9003Rzmv9Xd6oOq3WVYCFe/eP6/AXqt09Xp4rQiyUjCqc37LGg61QvyApI
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7ef67e-2682-4768-ab4b-08dd16b331ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2024 11:35:04.6452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pt02N1FkYHcocKIk2hlEk/v3V9dBwHn46UOOkyToUm6CgWoBVL0TmqNj7uYHEEwY+b0VazYjwARLWs0fZA/ZJVbxkkDV7iGC0V1RO1sJNcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB8614

T24gMDUuMTIuMjQgMDg6NTAsIE5hb2hpcm8gQW90YSB3cm90ZToNCj4gQXMgZGlzY3Vzc2VkIGlu
IFsxXSwgdGhlcmUgaXMgYSBsb25nc3RhbmRpbmcgZWFybHkgRU5PU1BDIGlzc3VlIG9uIHRoZQ0K
PiB6b25lZCBtb2RlIGV2ZW4gd2l0aCBzaW1wbGUgZmlvIHNjcmlwdC4gVGhpcyBpcyBhbHNvIGNh
dXNpbmcgYmxrdGVzdHMNCj4gemJkLzAwOSB0byBmYWlsIFsyXS4NCj4gDQo+IFsxXSBodHRwczov
L2xvcmUua2VybmVsLm9yZy9saW51eC1idHJmcy9jb3Zlci4xNzMxNTcxMjQwLmdpdC5uYW9oaXJv
LmFvdGFAd2RjLmNvbS8NCj4gWzJdIGh0dHBzOi8vZ2l0aHViLmNvbS9vc2FuZG92L2Jsa3Rlc3Rz
L2lzc3Vlcy8xNTANCj4gDQo+IFRoaXMgc2VyaWVzIGlzIHRoZSBzZWNvbmQgcGFydCB0byBmaXgg
dGhlIEVOT1NQQyBpc3N1ZS4gVGhpcyBzZXJpZXMNCj4gaW50cm9kdWNlcyAic3BhY2VfaW5mbyBz
dWItc3BhY2UiIGFuZCB1c2UgaXQgc3BsaXQgYSBzcGFjZV9pbmZvIGZvciBkYXRhDQo+IHJlbG9j
YXRpb24gYmxvY2sgZ3JvdXAuDQo+IA0KPiBDdXJyZW50IGNvZGUgYXNzdW1lcyB3ZSBoYXZlIG9u
bHkgb25lIHNwYWNlX2luZm8gZm9yIGVhY2ggYmxvY2sgZ3JvdXAgdHlwZQ0KPiAoREFUQSwgTUVU
QURBVEEsIGFuZCBTWVNURU0pLiBXZSBzb21ldGltZSBuZWVkcyBtdWx0aXBsZSBzcGFjZV9pbmZv
IHRvDQo+IG1hbmFnZSBzcGVjaWFsIGJsb2NrIGdyb3Vwcy4NCj4gDQo+IE9uZSBleGFtcGxlIGlz
IGhhbmRsaW5nIHRoZSBkYXRhIHJlbG9jYXRpb24gYmxvY2sgZ3JvdXAgZm9yIHRoZSB6b25lZCBt
b2RlLg0KPiBUaGF0IGJsb2NrIGdyb3VwIGlzIGRlZGljYXRlZCBmb3Igd3JpdGluZyByZWxvY2F0
ZWQgZGF0YSBhbmQgd2UgY2Fubm90DQo+IGFsbG9jYXRlIGFueSByZWd1bGFyIGV4dGVudCBmcm9t
IHRoYXQgYmxvY2sgZ3JvdXAsIHdoaWNoIGlzIGltcGxlbWVudGVkIGluDQo+IHRoZSB6b25lZCBl
eHRlbnQgYWxsb2NhdG9yLiBUaGF0IGJsb2NrIGdyb3VwIHN0aWxsIGJlbG9uZ3MgdG8gdGhlIG5v
cm1hbA0KPiBkYXRhIHNwYWNlX2luZm8uIFNvLCB3aGVuIGFsbCB0aGUgbm9ybWFsIGRhdGEgYmxv
Y2sgZ3JvdXBzIGFyZSBmdWxsIGFuZA0KPiB0aGVyZSBhcmUgc29tZSBmcmVlIHNwYWNlIGluIHRo
ZSBkZWRpY2F0ZWQgYmxvY2sgZ3JvdXAsIHRoZSBzcGFjZV9pbmZvDQo+IGxvb2tzIHRvIGhhdmUg
c29tZSBmcmVlIHNwYWNlLCB3aGlsZSBpdCBjYW5ub3QgYWxsb2NhdGUgbm9ybWFsIGV4dGVudA0K
PiBhbnltb3JlLiBUaGF0IHJlc3VsdHMgaW4gYSBzdHJhbmdlIEVOT1NQQyBlcnJvci4gV2UgbmVl
ZCB0byBoYXZlIGENCj4gc3BhY2VfaW5mbyBmb3IgdGhlIHJlbG9jYXRpb24gZGF0YSBibG9jayBn
cm91cCB0byByZXByZXNlbnQgdGhlIHNpdHVhdGlvbg0KPiBwcm9wZXJseS4NCg0KSSBsaWtlIHRo
ZSBpZGVhIGFuZCB0aGUgcGF0Y2hlcywgYnV0IEknbSBhIGJpdCBjb25jZXJuZWQgaXQgZGl2ZXJn
ZXMgDQp6b25lZCBhbmQgbm9uLXpvbmVkIGJ0cmZzIHF1aXRlIGEgYml0IGluIGhhbmRsaW5nIHJl
bG9jYXRpb24uIEknZCBiZSANCmludGVyZXN0ZWQgd2hhdCBEYXZpZCBhbmQgSm9zZWYgdGhpbmsg
b2YgaXQuIElmIG5vIG9uZSBvYmplY3RzIHRvIGhhdmUgDQp0aGVzZSBzdWItc3BhY2VfaW5mb3Mg
em9uZWQgc3BlY2lmaWMgSSdtIGFsbCBnb29kIHdpdGggaXQgYXMgaXQgZml4ZXMgDQpyZWFsIHBy
b2JsZW1zLg0KDQpXb3VsZCBpdCBiZSB1c2VmdWwgdG8gYWxzbyBkbyB0aGUgc2FtZSBmb3IgcmVn
dWxhciBidHJmcz8gQW5kIHdoaWxlIA0Kd2UncmUgYXQgaXQsIHRoZSB0cmVlbG9nIGJsb2NrLWdy
b3VwIGZvciB6b25lZCBtb2RlIGNvdWxkIGJlbmVmaXQgZm9ybSBhIA0Kb3duIHNwYWNlLWluZm8g
YXMgd2VsbCwgY291bGRuJ3QgaXQ/IFRvIG5vdCBydW4gaW50byBwcmVtYXR1cmUgRU5PU1BDIG9u
IA0KZnJlcXVlbnQgc3luY3MsIG9yIGlzIHRoaXMgdW5saWtlbHkgdG8gaGFwcGVuIChJJ20gdGhp
bmtpbmcgb3V0IGxvdWQgaGVyZSkuDQoNCkJ5dGUsDQoJSm9oYW5uZXMNCg==

