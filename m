Return-Path: <linux-btrfs+bounces-9423-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8219C3BBA
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 11:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0918E1C21B0F
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 10:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2185176FB6;
	Mon, 11 Nov 2024 10:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QYPrOJ8w";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IiP3QHIi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7C01487DC
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 10:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731320024; cv=fail; b=k1E5/pHDGJecje7ZJ+CSR3zM/hVDwDxQc/uH14bT5RHOOcTFlO4BAYOk2yN43ieIlReDrNwIt9aM6x0+ZnFNnr+X6gpmpRpT4G5kU8QDRhWJzCVLxxXEoUX0PhCxmoOZgtokuk2BL5wLmJv4JfRrKSOOGfIb2v9913pVkf/PGVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731320024; c=relaxed/simple;
	bh=PAf2qNJow5GyyYrARqDk6zJFJBSbEmMUQIdPktdp9gU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DdAzzKFOLAFw1HWmOW8ZVcPGzK1rzy/sokxRv/cz4Y7F96MONKcKJG3ZjmlOZh0wo++D60eqS7gxx3FnMx02mZdXVwfBKRY+WnJe6N8q7IjGSnyV8VcB7zI6Lw+gtND6eJP1DUB5qC9b9ESk6Gl5s6VL0N98J0Xo/qcMj/ddyRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QYPrOJ8w; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=IiP3QHIi; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731320023; x=1762856023;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PAf2qNJow5GyyYrARqDk6zJFJBSbEmMUQIdPktdp9gU=;
  b=QYPrOJ8wJoj36omKHowOt6y8bsRmsDLkhq1P50PTyumgq/BEh6o0PD8H
   Vyq+k2Igl6uh6uAY+nf2zC5JPS7/X2zv0wCZ/ryiSC75kivSM8LfeuuXN
   rsXoHqPW5FpI+XTlDXqbqcPFJOUOfwsXzz78z0Dkn6bN9PBdPenQljvN6
   ZbPggaFzNF3sZiUq83JtAXdq9m+0i7CpBfe9puN0/MwRL4D0seT3aXX54
   cwzjBOnWpjb2Wrr/9RSjlrHpD0g0uM2wYs06mpjSsnzAtSbmPRHNy7G1J
   Y7ufzKXasmMc7uEWT8KI5JgBA7li5P3Bq3LP6z4wP4ZqhBmpGuabKLxKJ
   Q==;
X-CSE-ConnectionGUID: DH4DfM5QRmq6YUAwCUVKpg==
X-CSE-MsgGUID: jpK3LXQQShaUjZBRDvNYlA==
X-IronPort-AV: E=Sophos;i="6.12,144,1728921600"; 
   d="scan'208";a="32245531"
Received: from mail-bn7nam10lp2041.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.41])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2024 18:13:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RvMm54w9NDK9FXfAZ1GhOU8e09LFq+UjH8w0v+4yHUaChYdrIS2Lej8Bj5uvXA0/LEyPBaSCsesItWL1FEbdkbdSLZ4aMYAYEarZsZjUmusJDqNif3ZQu/qEbTbBiJk6VmAfFklnsNDNfdzJM2LT2xaXrxCghaKM5AENg8SpGJ0NcyCF4udBjnbPPu/E/oz0dko9qYV7+sx18vCUsJmDqwNakQ2+G++2pk3WBM4O5KDAI9PvqkuSgffKPMa5Xun4QrLZ4AHlryquQIlZWQUtVT1fq46Z5RBkRMhJWQ2YxA9hR7wfvsKV6eMzSdmVj43o/P+iRqKzP9dpxiz+q4t10Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAf2qNJow5GyyYrARqDk6zJFJBSbEmMUQIdPktdp9gU=;
 b=PBQX/Le6l+kv8ucpcCiecxNBDkc9mMIy+7wY5UVZjqCnhAJ/9gS8zFnjaRbeHpKc3k+NMUFrS6MF5SQK0XcOSjviamerhdewp0RnJp1RfyAHGT2w0tzAnVKcN4Tkh0BjJ276UR7x/uuRmCgbYeHFx/fLTIhQPkGTR1aFRSRTFYW0ONmsh6mmr5m7pfMIszKbdTiaCZNRQIHFp6QSTWFjECy/Ed8K/uGQQGdrkAnFXlsfndz+ocgR/bNq1kkSoTMfz0lH72G8ZrUrdhcFIvi6G+wtCkpvKXm+swFYoDeFUa7yAwyfEZZS99fTTalDtwkojaQtXtrsfkNmfrVA0iWBMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAf2qNJow5GyyYrARqDk6zJFJBSbEmMUQIdPktdp9gU=;
 b=IiP3QHIiNjhs2PoDaPke6eJuhIim1wvxQgndv3oZSIlPQnCF6p8ePDxrp5ya9QF/dt1IzjN2MKPmRHN0oW2fp4p9nfuOAsKFTKbRewlv0ss+eDlSfwel3XTm5smphsr5Eb5/76LfzHxDBsor+XvcQy2VdqmXl6g2kqfdTC+NDkE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7685.namprd04.prod.outlook.com (2603:10b6:510:5c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Mon, 11 Nov
 2024 10:13:38 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 10:13:37 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Johannes Thumshirn <jth@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>, Omar Sandoval <osandov@osandov.com>,
	Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 2/2] btrfs: simplify waiting for encoded read endios
Thread-Topic: [PATCH 2/2] btrfs: simplify waiting for encoded read endios
Thread-Index: AQHbNBwcu/3TryzgTEyuBNHpG7OGPrKx184AgAAEuIA=
Date: Mon, 11 Nov 2024 10:13:37 +0000
Message-ID: <2184be44-520a-4dfb-9c58-69f9028fc8ad@wdc.com>
References: <cover.1731316882.git.jth@kernel.org>
 <22c7231a2ce9c0c7c187dff159be1c868d783765.1731316882.git.jth@kernel.org>
 <61b214b6-6036-4afd-b3fa-4506567f066f@kernel.org>
In-Reply-To: <61b214b6-6036-4afd-b3fa-4506567f066f@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7685:EE_
x-ms-office365-filtering-correlation-id: 93f28e4a-fadb-420b-c059-08dd0239824c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L1VyQ01aSFBzdjYzamNtNWZqTmJuNTlYS2l2WnVQQnYzV2E5c2hYMmhNTmho?=
 =?utf-8?B?aXFtL09zWVVYVmJkYVlMTllHNXo5dWppZ2wyNnZWWng5dDRGbEhFRlBwSnd3?=
 =?utf-8?B?b2RrSE0xdUFmTnNPU1JkcWlRRVltM1JMNHIycUFWYVVwcGpZbFF1Wkh4NnYw?=
 =?utf-8?B?Um1aRXFPTGJkUlFMd2kzZHA2bDk5c1h0OWUyWUkxWWdzZlNWV0hFM3RWL1VZ?=
 =?utf-8?B?K0RWUlhYSXZUNDhiZmx2aE1IZGFQZ1hPdFFHOUZPRlAwWlh3UUNGRkk2K1kr?=
 =?utf-8?B?YS9GSWtldUxxTzV1Q3Z4dVI2UWZLdVFlTC9NS2IvN1UxODYxTWl3TFBjMWp2?=
 =?utf-8?B?bVJmVlN6a0NUMlp0czlxcUM4ejh4SkI5WS9lNmlRV1F2MHhEYmhQL0xiY0Rj?=
 =?utf-8?B?Y1NIc1NNTVZrR0ZPV3hQZWVVeFZ4Q2ZhbWI0VmRVVUZOTkZodTNzYm1iSTIv?=
 =?utf-8?B?dGZid3dkT0hTcVRkL1g4ZDJseldRUW1hNXIwblZuSTNzOUpoTXd2UFplcVZa?=
 =?utf-8?B?MUV2cWFnVlNmNVZQRVFIcHVmc1JtcUE0MXN3a1hwWmNMT3dTTTlvL1VNd0pS?=
 =?utf-8?B?R1h2RUU4WFlSWnVIbXJ0cDVMS2xmTGdISXM2TzJWanJMNkxlQVJ1dEl0c0VW?=
 =?utf-8?B?dm9oZ0gwV1ZWY1ZueisvM05wOVJkb1haMDVreW5VTmVPdzY5U1F1MnVONkhV?=
 =?utf-8?B?MzFUcUtHQU1lc0xWVm1tYVBwMXdqQW1RVUlRLzhEcm9IQmh6ZWNQaytuazk1?=
 =?utf-8?B?citWa21Ga2N0Wmp2TjJoa3V1Q3A2OEhWVEkyMUFuOUYrNTdXVFRsNkp2Qnoz?=
 =?utf-8?B?dnQrTmlVdlJRRVplbnIxT0Y1MStpL3FqZjd3amJFS0UzMlJ0WFNuRks4NDNV?=
 =?utf-8?B?cW5zVGY2REZEWkd1UklkSzcrd3d4b0xSeUNRVzdvc205NzZYMmF0bjE0a0Np?=
 =?utf-8?B?R2hhYnBZQno3bkdRRHVSUm1hQzZCYXdlbWUxbUtmdTFhRW5XOC9TZ0krMnBt?=
 =?utf-8?B?TmpnNUZqdzRUbFE4SDVNNGRFWWlyRXNhdTBQa2llVzJSVWROMWlkblp3WS9X?=
 =?utf-8?B?RisxNzV6dExjYWVCRkl1S1NDbFhwR1BUWURzQ3VzbkJ5TnJySkc5TDdudnVo?=
 =?utf-8?B?U3pVQkJhYkpaS2JVWVZ1V01vUUNxR3RtMmJ0OUlVczBPdkF6bmxVdkY5dnZy?=
 =?utf-8?B?T2ZXZ2NMTFhSVzArRXBUMzcrZlI5R3Byb2MvUkRSekp4TFJoZDRkYXBCeFJ3?=
 =?utf-8?B?TTh6blF1eU90dXpJclRnLzlmU1NreUI4YmM4czJKVnd5M3hMSjNvcDRobURL?=
 =?utf-8?B?eGJtMjlzMFFrMk5pYjduZS9DR3BIYW4zaHQyRm9ycFJCNVozYUdwWEtualcy?=
 =?utf-8?B?a25OdXhiSkJja1JIVDhReHIrdXNWVlI3K2FuL3JOYk03STZ5ajMzS1R6aGs0?=
 =?utf-8?B?RTM0dHN4WDdDV3FDaFZESEw5ZlFGZ3FQSndBdHFBUzJTSFR0K1lOUTF2K2pW?=
 =?utf-8?B?d3BlV3RndnA0YzVBUUR0L0NRSEFLbWhFNGZlT0oxTk85SUhCTkRLbWNrNTNn?=
 =?utf-8?B?MXlhQUw4RlZoK3FEWS8wOXdnMHEzUDNLUzdlUG9rTFFnR1NCWU8zY1lqRGRt?=
 =?utf-8?B?d1RuZDhMTU03RzZmdHdDMGxmV3hOVGZYZktBUGZRYWJHbUIwOFBTZVFNU3kx?=
 =?utf-8?B?Y1dQdDdWcGtYeUJtLzRoU2xiWUt3bGNJS2FHcFR0anZUN3JkT3JRYlNVcHVm?=
 =?utf-8?B?c0tOc1NZRnMyRnp0QVBlKzc3Rmp1M1JoQWZlT2RNcDh1TTRVSTFLKy90S04w?=
 =?utf-8?Q?LggnTiIwNzy/nMbvrYEFInmTBhs4QFoqcZzIc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z1FsdWNLV1QxMndqbkJnOGpsNHBuQmZSQnp4TmNURHN5dHMrN0hHZFVjbFdC?=
 =?utf-8?B?bkZPRC84bk03SFdRR29rZ0kzSmVXaW9zZWt3b0NQUVFsYkJteFdqU1MyQ0JQ?=
 =?utf-8?B?ekJnQityWThIZW5pNGJIZjFKKzBiS3dORkIzVmxkMFZyVlducDZsOHhNaG1j?=
 =?utf-8?B?Yzh1MTNndURJMlBKMFdDaVJBV1VmdEF4Qk1Hdm0zMmFZcHpvdkFEUjdNendY?=
 =?utf-8?B?ZEdtZDhvYS9ZNXkyekc0S1RzOExOQVQxVkM3RU8yL29tQVYxWTVaeTAzWEx6?=
 =?utf-8?B?QVVaM3lQMDBaeVdXQjRoOUdaaDdod09jZkVKdVh4R3RENjFnUnBSM2ozeUxM?=
 =?utf-8?B?Tnd0a09FY3diQkxCbXNSa0xHWXAvODZ0MWsrcDRmK0JPV0VmTk5DNUxuWEFB?=
 =?utf-8?B?RTdGM3kvTmg2TGkvK3pNaGJ0eHhiMy9DbVIrV3NyY1VMUXZvUVl6eGRISU9X?=
 =?utf-8?B?WUtIY0EwYnQ3VnkvT282eVhMVUJQVGtaTTVFbkdPM2hsQ3dxcGdreHg2M092?=
 =?utf-8?B?REpHSkFlbkxxZFRoaVRtRDRqS2JSUUdINzZPMEc4S053ZkFUekh2ZlNnRm5k?=
 =?utf-8?B?NmErY2xpdkd3U1B0T1pVU3JTZHJzT0dtS3h6T0kwNkNSNVp4cXRBSHBNdmQv?=
 =?utf-8?B?b3Qrb2w3YndlYWRvUEMxWUZ3cmlXUHkxa2lXSHlKa05DZXBPVVVCZ2JaOXNm?=
 =?utf-8?B?ampFbkMydksxYzdrMUZ6VVRZbFRoanRFWDZOWEZTL1hNYXF5M1EyS1FJOGpF?=
 =?utf-8?B?SThuV2dOa2o4UVZtQjZyWEFnSjZsVVZtL1grdHFUVFZ2UENMMjAwOGJ3d3ZI?=
 =?utf-8?B?Qlh0cVRLMVhUdmt6Snpya1ZxdUlmeVVoWjJybUsvSGlFdktCZllPNTBkRlpZ?=
 =?utf-8?B?QTB0eGN6dVNkNER2WEprRi9tc0U3Zzl3Qnp5aEJWc2Y5eWlyV2ZySEs1TVBM?=
 =?utf-8?B?U0d4UVRpS1pxZGcrYm5keDhmTlFtOHBZbDVYQXF5aTlKSjR3aE9EQnQzakZN?=
 =?utf-8?B?a1BDUFVSMS9qcTQxcWVPQjBVeUhGQUovU3QwNnRLR3Rkc3RRcGlKdDRMWWEr?=
 =?utf-8?B?MEIzZDF1bzV4SENRRUVscDVCbzZrMWFabnN1SHR3SVVPekt1TkdrN1ZHYlds?=
 =?utf-8?B?U1FVWGxvRjBCQ0JScVAvampiRnA3dEUwSUE2QU1tcTlGaUZiWm55YysxZVB1?=
 =?utf-8?B?NWUwTDdYTHM3TTVCcTUzRGpiNlZ0SEI0Yi93TTVRcDU1cjdKdmU5OUdGa3Zo?=
 =?utf-8?B?OS9MK0FoUUxuY3poVHN4cGsvRThoMjMyZGpyMEVqaXNCRXVqV2N5NUxCU0Ni?=
 =?utf-8?B?Vm5XWlBwUXZFSFVRTnJXTlV4Nnk2enVSKzBTL3g4Vk1JaFhOdlFiN3AyWis3?=
 =?utf-8?B?VEJpclZrWlJ3TDVSWlpNblRjQWV6d0tYVnpGbWVYU05pY2lqZXRQS1R3SSt5?=
 =?utf-8?B?Rys2ZUg3NUJiWFY2MWFydU1tUktES3UwOXFWd3pQSTVuNVREYk9ZbnBVakVP?=
 =?utf-8?B?Zzl5UzR3Ti9rb0lEdlY4MklmdVlUMDZSZ2U3aFFqQm1LWExPUzJ0Nmc5a0th?=
 =?utf-8?B?WGpFa0FCZzM3TVQweThZZkpKWDNvcnY0TGFwWk16MUQ3bm5KZWdvZWdpamsx?=
 =?utf-8?B?SnZTcmVsY1ErNmp3Z3ZsMG1ueWc3TWY2WWZzWEtHVk85bms2Z1VtYU9oQ2lZ?=
 =?utf-8?B?TkszTFlRalQ3WTh0LzJHd1I5ZldoUzlwb0paOEFtbFRvQ3hVcW5odDgzRXlk?=
 =?utf-8?B?Z0tDZm90ZkdiZ1R6aGdVcnJmZWtNMnlObE9XSC9JNjdvRTAvYzBCMXp6K3Rm?=
 =?utf-8?B?bnBxTHRhRXVpUmdnREI2b3hrUmJQRlI4eElrMWVxcUNneWpiQ1hCaWJBeUJp?=
 =?utf-8?B?eHJOYmRsTVdQaXZHVTlndVBvQ0wwK0RZcW5YeFBvTVR4VjBGVEdodGhRaEZu?=
 =?utf-8?B?UkJUNTdqN2hPSVhidUovR3BMaHRyYWNMQnVlT1RMNVdRNlFCcndyMGNwcUYy?=
 =?utf-8?B?eWJSeHh5UUxBNWVueFB4akRsRVkrVVo2WE9aSENGSnBxbkphRHRSVVVObEpa?=
 =?utf-8?B?aVhJZjgzOTVFdE1JVVFoVTN3UDdmZG1GOTkwckgwaTRKV3RodW5jMVpkYy9U?=
 =?utf-8?B?dnRQajRJdWlmaVRQbHdCSTBRR3I5UHVoVFdFbUpsL3R0WklaalFCbHVndGc2?=
 =?utf-8?B?Z3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <34AB261DEF4A8A42951EC16B67E64561@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+p9OHJXH01XK1x9pZt2jUfCG6MafHrZ2PKFr4q9WnuyPvXmaiOTcQYLNI8qHAww4TaRFr+8FuK1XHmA/JBXLvyjG1UdEATJDjbRxHpe4Yo0OGCSV7byFvSAf8/9QYWSrBedkJPIEKKASBeDm7dL8+x2H/DcTSTKyXIW801nG7L3OPs58URbmSqReirDhceAky/POMCEXxCQ53krsy80+FvhLZmUxnTRK2BK8r2XVV8/EN8MzIeFt440qo8kCwRUH7Zo5aYD0046re7jE9+bvPF2EDmeEaBhhTYN5PyGcAgcXZxIi948GJ9zW/Bu6Tn3mos8Me102k/UzE26W2aXHwmMJBiVCcnFUpDf5AKyPNWQSG2n24vw9ZhwanvhVHxlF3PAuITQ5AyPFN/6TREAmbqhpoa9vmfoflKC9soC8/86qiunDS9EHCwuy3vpRxsRpgIaDZcOv6XBo3NuK8OmcRoxSIGf3dC988+omYqeTJodhox1Uo9Vl89ojMM0mdWt/3XcOiLy5sIgjlUW2CeljwFVSZhqdNNG9h52j/69FKKCrkL38y+b/+AN9KFvJ/9kZMa0ykOS/Y9BNXRnSO26E/mJ666NxZoExNkYnZchpVlu1tNRevaiOZVVOyqc8mwg+
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f28e4a-fadb-420b-c059-08dd0239824c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 10:13:37.8484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /TX0IgyJ92wWU11TC3CuB/bs2P6Kqx0kndi3VK9XkUz57k13JTrfF3yYp+ANgMvL2/UPXx5XDYH3i6n8nVcDNqSTy8RMcsBSudWO+zsCX7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7685

T24gMTEuMTEuMjQgMTA6NTYsIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPj4gQEAgLTkxNDUsMTEg
KzkxNDUsMTAgQEAgaW50IGJ0cmZzX2VuY29kZWRfcmVhZF9yZWd1bGFyX2ZpbGxfcGFnZXMoc3Ry
dWN0IGJ0cmZzX2lub2RlICppbm9kZSwNCj4+ICAgCQlkaXNrX2lvX3NpemUgLT0gYnl0ZXM7DQo+
PiAgIAl9IHdoaWxlIChkaXNrX2lvX3NpemUpOw0KPj4gICANCj4+IC0JYXRvbWljX2luYygmcHJp
di0+cGVuZGluZyk7DQo+PiAgIAlidHJmc19zdWJtaXRfYmJpbyhiYmlvLCAwKTsNCj4+ICAgDQo+
PiAgIAlpZiAodXJpbmdfY3R4KSB7DQo+PiAtCQlpZiAoYXRvbWljX2RlY19yZXR1cm4oJnByaXYt
PnBlbmRpbmcpID09IDApIHsNCj4+ICsJCWlmIChhdG9taWNfcmVhZCgmcHJpdi0+cGVuZGluZykg
PT0gMCkgew0KPiANCj4gVGhpcyBkb2VzIG5vdCBsb29rIHJpZ2h0Li4uIFRlc3RpbmcgdGhpcyBl
c3NlbnRpYWxseSBtZWFucyB0aGF0IHlvdSBhcmUgZG9pbmcNCj4gd2FpdF9mb3JfY29tcGxldGlv
bigpLiBTbyBJIHdvdWxkIG1vdmUgdGhpcyBodW5rIGFmdGVyIHRoZSBjYWxsIGZvcg0KPiB3YWl0
X2Zvcl9jb21wbGV0aW9uKCkuIFRoYXQgd2lsbCBhbHNvIGFsbG93IGF2b2lkaW5nIGR1cGxpY2F0
aW5nIHRoZSBjbGVhbnVwDQo+IHBhdGggZ2V0dGluZyByZXQgYW5kIGRvaW5nIHRoZSBrZnJlZShw
cml2KS4NCj4gDQoNCkFyZSB5b3Ugc3VyZT8gQmVjYXVzZSB3ZSBpbml0aWFsaXplIGFzIDEsIHRo
ZW4gc3VibWl0IGFuZCB0ZXN0IGZvciAwLiANClVudGlsIHRoZSBiaW8gY29tcGxldGVzIHdlJ3Jl
IHJldHVybmluZyAtRUlPQ0JRVUVVRUQsIG9uY2UgaXQgY29tcGxldGVzIA0KaXQgZHJvcHMgYSBy
ZWZlcmVuY2UgYW5kIGF0b21pY19yZWFkKCkgd2lsbCByZXR1cm4gMC4NCg0KQlVUIEkganVzdCBz
YXcsIGl0J3MgZG9pbmcgYSBkb3VibGUgZnJlZToNCg0KSW4gJ2J0cmZzX2VuY29kZWRfcmVhZF9y
ZWd1bGFyX2ZpbGxfcGFnZXMnOg0KaWYgKHVyaW5nX2N0eCkgew0KICAgICAgICAgIGlmIChhdG9t
aWNfcmVhZCgmcHJpdi0+cGVuZGluZykgPT0gMCkgew0KICAgICAgICAgICAgICAgICAgcmV0ID0g
YmxrX3N0YXR1c190b19lcnJubyhSRUFEX09OQ0UocHJpdi0+c3RhdHVzKSk7DQogICAgICAgICAg
ICAgICAgICBidHJmc191cmluZ19yZWFkX2V4dGVudF9lbmRpbyh1cmluZ19jdHgsIHJldCk7DQog
ICAgICAgICAgICAgICAgICBrZnJlZShwcml2KTsNCiAgICAgICAgICAgICAgICAgIHJldHVybiBy
ZXQ7DQogICAgICAgICAgfQ0KDQogICAgICAgICAgcmV0dXJuIC1FSU9DQlFVRVVFRDsNCn0NCg0K
YW5kICdidHJmc19lbmNvZGVkX3JlYWRfZW5kaW8nOg0KYmlvX3B1dCgmYmJpby0+YmlvKTsNCmlm
IChhdG9taWNfZGVjX2FuZF90ZXN0KCZwcml2LT5wZW5kaW5nKSkgew0KICAgICAgICAgaW50IGVy
ciA9IGJsa19zdGF0dXNfdG9fZXJybm8oUkVBRF9PTkNFKHByaXYtPnN0YXR1cykpOw0KDQogICAg
ICAgICBpZiAocHJpdi0+dXJpbmdfY3R4KSB7DQogICAgICAgICAgICAgICAgIGJ0cmZzX3VyaW5n
X3JlYWRfZXh0ZW50X2VuZGlvKHByaXYtPnVyaW5nX2N0eCwgZXJyKTsNCiAgICAgICAgICAgICAg
ICAga2ZyZWUocHJpdik7DQo=

