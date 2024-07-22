Return-Path: <linux-btrfs+bounces-6638-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CB6938A47
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2024 09:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C797CB2161B
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2024 07:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F7614F126;
	Mon, 22 Jul 2024 07:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DYZMm5ie";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eGQtTYiJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200F51F943
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jul 2024 07:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721634013; cv=fail; b=V/pJ9RyofcGQr7RTHL/wtCll0a1ObEHACqKeFrTMHZixyuepOJGtwWowW/78EkQAgD15e2NOe2N4cDBEEMwlMcdwezEABHqsMdlGjJlstIeT8MzCp8OL/ubqBom4EfiwTfSEEAn5ifnNRLoq2tLpw/vJbED8KgWoE+AVk6u26Vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721634013; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XoyUDsRcByYajcwdkq0QBDweFF34CiHIgkdL31TTg6bvge5egHYidaPzsrFa9xPByumbbzK4CUt7Bic5AzTttjtxN9SXMzurxMX2Z6a5Wm89f9mS4lrevV8ND1zDwGLBvU4kf1WRIhVNJeuz1M1X2UAcKYknciv05Zz8wdJjyco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=DYZMm5ie; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=eGQtTYiJ; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1721634011; x=1753170011;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=DYZMm5ieptTsTqfxcPMB1+hdkWhm3R1HPBnRMsJnPzeJ6X+iMTz+DVS7
   Y/jVfPIHHLkhUkZ2TFFY7Uud9p6VSAMSg9eP0uCkCi69olEuD5AOmfWyX
   82fj2e9yflzZtKYKGWiHYwHyHdGQjXzi9TE3vM2L1zN2W1xvaLW4DfyVf
   aceaXWi1Fd1HRfLJEVjJ56QipXW3CsHYDiE1kCkAMxChNWLcf0R67Pu7b
   p41BOCtd9mSPqvMRN62ARCFdJQLsEfDSeGhQduVRlFA6ntP2P2qBwc/27
   Bil2MQAI6UeMN2p1a3Kn0Ty7JxaxNFWkuKgVLaK1IteplZHpaeI2/iWtt
   w==;
X-CSE-ConnectionGUID: e0WQyciQSraCWbhHdZptfA==
X-CSE-MsgGUID: P8ZlxwiQT1S65kK/gBozfQ==
X-IronPort-AV: E=Sophos;i="6.09,227,1716220800"; 
   d="scan'208";a="21776030"
Received: from mail-westusazlp17010003.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([40.93.1.3])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2024 15:40:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A227T2flmZwuv5gpqqK6XQ3zhqpPxLmQeAeEHwXv98a8uKg+sEizIAiCyCbD1pO2qiqi9z4HxzWPrzzpcbg7gxAYVlrJz41OvmI4aliDuU5IPB5i97G2JEh+HE884udlcMf4ncnDebCg85+kmGrX1e+MYv1wjycUvoj9/xu8KdKDV2mp5hlELC3B3pRl5lKQCKYIANzBiuFiCl68EJ4z/ojQSaIoJkOimhSNRlrNwn/uloSodaEXwCV68yK+gcfQ2GPWx70+TfvxjiLhAZUvGSNqnazXhmcinUUresnLGMqWg13zJOuUkHzKllc56zXM/qSU9ohFqNX8EUDu9ercMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=ypJLxxOvhvnSFtF4NJM0BU3Q47uQnFBsSgFL1uQM3lyaGGf/AsKsXthJbAO0LCdEOUaZUjrLjEw+OHhOWnbP/GDp49FJUtUblLis2N8cU1kM9DAcmVK9W3ZHMuaeeyOjbi6Ce8aZrfFASHQ2zbbxmifCif7+BFxBJ0ZYZ4qvlrfN5X/HN5Tilr8ePfdhzIUwR+LSltu4l4Sndr9B+qI3JeLthymJhH2yrNn2Lxu8UJBbcCGL1NTYJzxwATzIbQDjZMnfgHZgxXWees2NURcs/xa1aDtWkTtvNv0BCwG98sVp3YAyp4Jf7RoAkgUFtFtBv0HGA283UgWwyVCRcenzCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=eGQtTYiJRDVQX4aVaRT8SjAnQy+3AdXFK0KW2mC/p2Uhjw0OzzPK4LTwAgbaLcbwqY6RVRIdEARFIoP5Q0bpprgtDoJVBEauzgXAqL1y5gjHNlCO7RgZr2byKMGXHywu6gF3i67KprIA1BvVOyEecdWVSwUyUbnbiJCYL3btxeY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB7864.namprd04.prod.outlook.com (2603:10b6:8:35::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15; Mon, 22 Jul
 2024 07:40:02 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.7784.015; Mon, 22 Jul 2024
 07:40:02 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: Michel Palleau <michel.palleau@gmail.com>
Subject: Re: [PATCH v2 2/2] btrfs: scrub: update last_physical after scrubing
 one stripe
Thread-Topic: [PATCH v2 2/2] btrfs: scrub: update last_physical after scrubing
 one stripe
Thread-Index: AQHa2/v6STqguepmz0yJu9OcanCzK7ICXL+A
Date: Mon, 22 Jul 2024 07:40:02 +0000
Message-ID: <e78bd357-0827-41cc-92ae-18120cbf2c0c@wdc.com>
References: <cover.1721627526.git.wqu@suse.com>
 <09c3f2adcdba2e5c27577e3fa17fda83a6985303.1721627526.git.wqu@suse.com>
In-Reply-To:
 <09c3f2adcdba2e5c27577e3fa17fda83a6985303.1721627526.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM8PR04MB7864:EE_
x-ms-office365-filtering-correlation-id: e4112ea8-f639-45fe-8c75-08dcaa217f05
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SHBzelJlQjA2K053cU1HMjE3b2NDZmNuVC9tbXZZSEVBMUN1UEFkZFJiai9Y?=
 =?utf-8?B?ZHQwR1h4djFzc0NLYUFKaXVIOE5CaGRWOXN5TXFvKytWbHBIZ1Y0RVA1WlVI?=
 =?utf-8?B?OWo3Sis4R0I3M2w2NCtSWVdueHNEaVVGRlByMDY4RGhHcjRFNUxIbWgrZHRh?=
 =?utf-8?B?MytLQmxlS2E0eGV3RnZycHlNcE5GRG5lWFJ1WXhUcFRvaG1UYTZNYjVEOWZ0?=
 =?utf-8?B?NzRnQ0RCMWIvbVZLNUpUSCt0SkRhWnVZejZIa2JQOEd0NkRmYmh4RHI5Wldl?=
 =?utf-8?B?Y0QvV3VrZENyMjlEZmpJNUxjK0NQRndQSXplbmRFczB3NlVlUXl5ZUJnd01m?=
 =?utf-8?B?ZjBZQlR0bGEyVHBDbS81OFcxcnZoTXNqRnJQWlJIS3h4QXExKzJQQWtYTTZj?=
 =?utf-8?B?ZTRkMGtQaGpqTGxBY0RRa1hOZGoxaDJ6dVlHaGlocTRaSWI5RnV4a2FieXJl?=
 =?utf-8?B?REJPK0l1R09CaFN3UE1OTXViQ1pCYmY4bnJURktBamI5eW9GYmtUWXl5NGly?=
 =?utf-8?B?Q2JEQUt1MzU1ZnZOZVNsenFRbUdTZHdaQWtkQkxrOVhuajZNdmRzY2pYeitv?=
 =?utf-8?B?bWJCanlURDJlb3ZOSjMyaFNtVmJuSHY1OGNrQ0o5bndaQ3VlbWw3OGxvTHNs?=
 =?utf-8?B?UUlVWDdrNi9xa2t6bUxhaWd0dklFZjE2clo3eitidTlUMkRlSXZpR1dSTFUv?=
 =?utf-8?B?U0p2c1BQRHgrRlFaUjF0QnY4L3JyelJaVUNwYWVNODYzNTFwbDg1am9BZHh1?=
 =?utf-8?B?MkRZS1J3WFh5U3pmcmhVTnVQNmdoVDYzV0did0FJOXRneGhLRE5oRDZnSGxT?=
 =?utf-8?B?Y3ZVdUFTaG5lazBuNzV0U0hDc25BQUlzN21jSE1ZWWxQUDd0WUR2amZUY2xW?=
 =?utf-8?B?QzlmV1Jrc082RU5VQWtCcTE0eW01anJjZUtNSFRhVHBRZDJEZmZGckVKcUhM?=
 =?utf-8?B?UEVBdnh0Z01aZlJoNFNhbXF6bTF1S0lsVVdZaW05VnVZVTJydXJ5QnA4bU5l?=
 =?utf-8?B?OVRoL05RcWU3NDlSNGdnd2pQVWJ5Y0ZLelA2UFl0NlFJZGJGWGFVMHVaeThN?=
 =?utf-8?B?S1MyWDB4ckhXVzZwdUNsREZTb2NQTWZPaDNBVHRHaHl4NjFWeU1HS3krRFk3?=
 =?utf-8?B?dnFzZWZOY2VOd09OcFhDUXkzMFJueFhaOExpTWxIT2o2RGRuVjBHSWlrTGFJ?=
 =?utf-8?B?cHRMc3hXM0toYmdkVHZoUmVscGZObDM0eHhoOXFZT2hyay9DZUJBMlBnTWtS?=
 =?utf-8?B?WGQwalFGRFJUTHRjUURlbGFMZVRPOHd6U3UxdmFrWG9rNnVOa1N2Vjg0QVhx?=
 =?utf-8?B?bnY1dUF0K283QVVSN1dURkFPNFdnakgxckNBUzN3bHJvVWN5dUZjY1BzRmNa?=
 =?utf-8?B?RXFBd25TNzFDbUYrM1pBSFAzQzRDR2JzaTNmcFdPbXI4UVUvdzJsZmpOKzdB?=
 =?utf-8?B?QW5YWkJDOXdSQjlEQ0h2b0xhSCszS2lwT3M4TWR6NXRrMXNOVGxFZ3VDb25I?=
 =?utf-8?B?anc1c1VLU0NKN1gxQ01hRkVDdEEydjlTVG5pcGtwVW1jNXYzcVBPSTZHZmps?=
 =?utf-8?B?MnF2RVhYTVh5NDV3UHFjbG9yS0UweEErcWRmaUlRS0NtMTAzM2JRUksyZ3Zm?=
 =?utf-8?B?S1A4Z2QxekJlU1ptcGovNDNOcTVIZGQ4NHVNVExhdUlXR09xelZRNTJlMlBu?=
 =?utf-8?B?YmVHcG1VaUNLMHFreC9WODUrNERrR2FVa2djM2w4VGZ4VE5Xdm9GMEI5THk3?=
 =?utf-8?B?V3BSSXJkcENUcS9QdlhyWEYwS09hUzJTV0EvTDZLS1JHSjZsYUVQMVdYSTNQ?=
 =?utf-8?B?QU9oaVBEN081REp5VXdOY2RQdW1rTkxDaWJpVU5VRzFrbjErYjFOWHBhTDR6?=
 =?utf-8?B?ZlNyWHBHYiswYVJQYVRWUENhWk9tcDVyeVRUSkZkaGYzTkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WDZRcVg4UzdJU2kwa3FsM3JWR0RoUWVCeGIyZmdKNTlKaVloWHZFcEs2Sldj?=
 =?utf-8?B?ZHVnb3R3VWpHS21SR2FDbG10TE5lZzlZTHZ1VUFOM3FMWHhMQS82bG55ZWJG?=
 =?utf-8?B?R2NwVXhFSnRKQ2Z6eEgycHR2TmF1VWFWWUhnNnFxR01TS3lYUk1haytPTXp3?=
 =?utf-8?B?bTV2WlhqK3J2UmxKS1E5V2c3N1F4eXpNMHlCKzYvbWYxLy9sclZPNDkrVjJ3?=
 =?utf-8?B?MlQyVkd5OS9PQSsxVVA1bHJINmZJRExPbkhpd2xxck56ZXlIeWdUZE55N3hV?=
 =?utf-8?B?TVZoUzB5a29VWmhGQWVuK1hPVkRRUUN1Qk9sK0hwMTdvbFZCV3FxM1dtaU03?=
 =?utf-8?B?bnd3TVNqRlY2b09CaGxleFVnT2JmMFdtQ0ZvSVgrUVVKbjlhbDdlbGVQVjIz?=
 =?utf-8?B?OUpFc0YrZ3E2UHZjaXFYWFl1V0Nya2FCb21JSGtSOEh1a1EvMXk3QlRidzFL?=
 =?utf-8?B?YjFCeW9LczdKUW5sdVdJNFFOcVd0c2I0MGN0eWFPbTVnUE1vSW00bHFYRDlE?=
 =?utf-8?B?R3V1Sll0NUJJTGRzaHo3MFZhSkxBN0xSa000Z0I5TVpIcFBiN1hNMldwSHVW?=
 =?utf-8?B?WkJQcVpmZkhCME1sRjQ1SDQ2dHcrSkwyd3JVbzBuZlFhc201ckJwNVduSGFn?=
 =?utf-8?B?R3dVVzJ6MnlZTjFlTnRqVXE5Y2FhUWJoY2NsWGNBVFIwVGxOQ3diZmJuZndY?=
 =?utf-8?B?akZXNDRSbFoyR1ExM0ZCenMrL1JzZUFTUzZtSDJ5eTdrRWlMdmFWeGFNdisw?=
 =?utf-8?B?S25DRzBpblo2aGZyQkFxU0FlWEVoT3NJamhVczlRbzQ2U2l2aWs4MFhKYnpP?=
 =?utf-8?B?NWhvQ0tmWGtMZi9oTU1mVFRyZGZ6QStWZHJheUdnTHlITlQxMnNmVHdBdXBz?=
 =?utf-8?B?ajdBcCt2UStLQzhoTnVTWFhUWmxhS1BYRWwwN04rajhQc2RUVkR5MFd4ZVRG?=
 =?utf-8?B?WHVvTStoUHB0ZCtDWmdTTEVBZk9UTWFMMllqL1NTVXUyandHcWwwdkRybkpy?=
 =?utf-8?B?V0dOL1hEbkhmV1BkL04wWlpVVXhEc2VPVzd5NlZsanUxbWlKMlN3c2s0dDRT?=
 =?utf-8?B?ZTduRGFCM1FudzlTWDByRTIyN0R0bDJmelB2TE8yalVPdGs3amY5NlVJTkhO?=
 =?utf-8?B?ME5hVEFtbzhqMXdOZmhnbWp2NzFmQ1V3blZ3K09ZZW41WkRwcGR4aTBKMko2?=
 =?utf-8?B?dld2WmJrNEMrempkcG1SYkdKdUtIOHh3SEQ2Smk5MlpRc3JweGpQTHV4MlRq?=
 =?utf-8?B?Y2ZjTHlpMVUyTnhpVC9xL21nUFNTSDZqL0xjWlFZbUpXRWhDTnhDcUc2RG4y?=
 =?utf-8?B?UmZDT2oxWkN3Qjd0bGM5TGJsaldIUXRrV2lTazVnNGs1ajNpMW9Yckk4YUdx?=
 =?utf-8?B?MVhhWHRkS1FWRXprM21abnVzTmxLUnNQZkUrK3AwVkZkTERoM1BsTlJ1dDVm?=
 =?utf-8?B?TWhocmFSSldPdXhnZlJ6cnNkQUp4NmxZWDhKaHRONUpacGg0bWlBQVV1NURm?=
 =?utf-8?B?ZndINFZMZUc3S2N3Uzh0RHp1RGVoR1h4RmZrNy9PTktwOCt4ckMvVXFlVGxn?=
 =?utf-8?B?cTJBdjRNeTVRQnlaL3FCWUY4bTF1K2ZOY1lpWExXM0VEOFlHYUtUbTB1TERv?=
 =?utf-8?B?ZHhYb0V5WCswNzQ4Qml1aU1ZYVBDTnY5NWpnamZodWY2amw5SmR0OXBpemVk?=
 =?utf-8?B?MkV5QnI0TUNUMDZvaG0xZVJya2lBM1JwREpVOUNVUG5NS2xHek9qSVpFQ1Fh?=
 =?utf-8?B?a1o5b2wwOHlhTEwxdFg4bkxhMkVpbS9SOW94YXhNUzBqc0Zsellyd3FsSHlH?=
 =?utf-8?B?ZnlUNTNxRlEwdGJpLytiaUdpWVdDb0hyeVNiU0ZVK2lsSXlBcDk1YVY1T05y?=
 =?utf-8?B?aFdwOFBrNXg3dGErNUFUNEdaVDZnQ1FQTnllZmRZV3d1OUl2aXRlTmJYbCtL?=
 =?utf-8?B?c3VoZjExWHJtVSsrYVpWNzl6SmNXTjBWRGM5bHBtZXBYMjBZb2lBN094d3c1?=
 =?utf-8?B?Zk9hYkpiTTgzQWt1VGhOU1hYU3ZZQjNkdWxWY1FOTWd5WEQyaUZPNVhhSWFQ?=
 =?utf-8?B?WWc3RlJINEN3eTRhOVQ2d2tGdSs4TnkvQjVxSXhwRlE1SVBzMzZrRXk0M0hm?=
 =?utf-8?B?VENxK2tCdjFXWldSMGM1L0oyL0J5NW93bk0zWmM2UjRjTXRzd0VtNzMzOWpD?=
 =?utf-8?B?MWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B08535760C20B74B8135C4FA81280B29@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CTPDhMSA9sjPplYB55QLMndW9dzyJpazcPPy1p5wVQbNLi7vNd0xz4ZSaKAMOb3CYJwaimA06CevrM/TcM6cAg4jlexP8wpQIFQiLwmsNbX/ErRzog7RD4QFg/3h2nV2KyJQ8foXZh5xvj63dqCcs33+1nmVF322nxVe2yLpGMNv8i9Ze5fyAIl7A+t+FC4K7JHsWPO6qB6nlOlg8Cf6MFAzaEpgRRyJGBhKbgfk0xH32v3wjtIubvZAQ0EIeJDy6Qd6Gh8hRBo73DZCi3kbl+onCnlPzaACiJo5Sz6AN8novUlyB3HHOrOozAC6Sj3svhmHf+wnoZ/2pkNNg100rzCrJJBCrJZr/+LhdE6KVxb1/twhluySYgKbzjfkgV/G+jTFUie66+BpkdOwquEqwwjHF4eCGh7hdnqe+OlxsTDyn0Jc9knsQRVJplIbDZVynbrIh/UjvTdrpGtvvw52xC2H56bJeccEwXaC2Oi/qeMbeNOfMVEu4DXygOM0jyvU4c93lBOhnOyU90hxvK4ELPXXNFstkrDk5GvB582Eea9cQ++VKUDB2ioH3JnwVB6PDx18p5P6qzLevrI1mrxZyWtr+W8zSnDFhJr/3UoyiU3rqL7tc+oAm2Oo2wZ9LJcv
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4112ea8-f639-45fe-8c75-08dcaa217f05
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2024 07:40:02.0860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GscBpXZtplKIiIFBnkfCoLSXCGdEnJYAHtj/7TVBC1gxp/VkqzPkMbzehIwJP2PkjnBt9Q8b43vy4SyLW+SKdJ3HiVXh0z+IQV+G2sZUD8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7864

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

