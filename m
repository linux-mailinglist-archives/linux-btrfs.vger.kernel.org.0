Return-Path: <linux-btrfs+bounces-14408-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1D6ACC353
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 11:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9CC1885C23
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 09:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7E12820B9;
	Tue,  3 Jun 2025 09:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Zl/xEmDs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9849B7262D
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748943651; cv=fail; b=XSwC7d8gkbi/jAMh81vta201Ve8IV+njjKJkCRhkkxDZjtK0GY+b4PdnGW6K1y7p8PGnRoPu4pb4umwZRsjOoPZJfeeVPuTGN2jtZViY1mTLQM9LTPEe9wvWz4n0RgziacgwL2QeVoV2uCVf6+6LRoGsuKA48LHaM0NAZjz9Bcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748943651; c=relaxed/simple;
	bh=VphB2R7a8LTfy7mcEjFsQtqWIJ4tgxLwoEFvaigu4xk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=HY661PmZ66KnXK9pRIzkPRMzgMnYUuXTLGe0F+YYUJupr/v2hKPP1cB22z5H4BlniLpNSis4kzx/5XZiBojkDM4mNTgakKMZn1vdb44pY/UVBVCchuIp/qPbcDh2lqTrPTVm2lguOcSiLwjIhHSE5LX6/tQObInz6kCHTDgw3pM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Zl/xEmDs; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5538NjjX000308
	for <linux-btrfs@vger.kernel.org>; Tue, 3 Jun 2025 02:40:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=MdRtSUCziZSPVxhiUA1BCb9MGTgaK1BYFri+Di8rJJk=; b=
	Zl/xEmDs2GWH5oGJE24T7vehoq8pUuw8oj86x5lnykp6XOiNKfMSXot5nL/kaMZm
	P0dy0PvigtnRmVJ6l7ebwumY3Znuy4HsanfXXQ7ooTM4zSz/JBsNo9QubrXdtapk
	63krJ9yicuJmZ3WCNFEQIS5d+s+VRU59px9Ro9BD8HPAuwLYbCnYaQv/RTomlehG
	4UZuq9bAnrQVkO2mDLbkQXFYndw49z94MXQ3KMSNPDRVPK8CjuJFPtww5xrbBl06
	gNUQUQmvmNT4BImL5KknjzPgYymI1Vu8W4gGrKfYbdWqevnDDgvXIueOdM0+11Je
	akWdJCkW8L1RNhZMIVOCbg==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 471v43gume-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Tue, 03 Jun 2025 02:40:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIIO7gDQRiMUfd2iF0V0LcbQtdENITARnG9TNRvp2tHTTx3f5s3OY3IAixPIv93daxyqSApr1lkuNwiXIL3lGvOPyPxDMu9OgtfFw68umurqhRdhyWAaPZrBBCDO7QWxK9VzBiljrmhdmpslginuYnhljklHTpJxZe6/htOyjopESP6ivtYL0/yxLixjYInJ79wnxtNIl02wQW7Q7xpuBIrfMKw8M+wviJDJUWNzL4kz58qJCwI13o3YdQ+5sPmbjMH5uiSzo1lMmEo7BQ9e3zaZgFxXqvxa7MqZqxStUBQytAmv68ROHBr1lhXGaXSHSgrWtQKuPnHdQmVRT49LGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAXD/ON7MetCtYEyQhRLWD87WWz5av0SC/mUmubnYDE=;
 b=xFZ8njDdv6w3nqBBIqD9LxnpET3V8IvkTcS+i4zeQzJN5JCOkqcx+ZZlyD5KGeFd6G5Khd0IE05F/WbwFwl75lB60+qS5eEuojhhW1oPE+Oxhsvch4GS+k7KwxPLRjEye8dl+QvW+WS2HIREQ9U0hRDU/Ow3xoxhDKXs0tc/zx7xSQ1Kr90ggM6QTR0YlRVf37axz1WBuy73+df0fXQ7kbswSSXUxunWZb8WiSo+ki/vt7JfWFpickh3/sXVjVhfrqFTTZ9Gn4pFhpmr1ZITbSl9hzPiZ0mzv6rRz7QY5El2D2YTbYjKikfVpYdUG1JRqAZHt9yHKQCnT7zvDGwi2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by IA1PR15MB6272.namprd15.prod.outlook.com (2603:10b6:208:456::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Tue, 3 Jun
 2025 09:40:44 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%5]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 09:40:44 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: update superblock's device bytes_used when
 dropping chunk
Thread-Topic: [PATCH] btrfs: update superblock's device bytes_used when
 dropping chunk
Thread-Index: AQHb0H1wiWZG/TzWgk+LqMqsaHkj17PwVV+AgADgzIA=
Date: Tue, 3 Jun 2025 09:40:44 +0000
Message-ID: <e3e558a0-f7f8-40e6-ac1e-b4494ed77a92@meta.com>
References: <20250529093821.2818081-1-maharmstone@fb.com>
 <20250602201609.GH4037@twin.jikos.cz>
In-Reply-To: <20250602201609.GH4037@twin.jikos.cz>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|IA1PR15MB6272:EE_
x-ms-office365-filtering-correlation-id: 4961a8d8-6784-4016-2ce2-08dda282b644
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TGwwV2ZrRERmdm0yOFdsS3BsV25zTlJRQnVKZGpYK3dUYjJUYVZuajMvaUxM?=
 =?utf-8?B?aG9QNXVadlYrQnk2ZmEyblRFMjdGTlhMU29WQllGOHN1RW1oc2kxUDNjTjNl?=
 =?utf-8?B?dWdvOCtHOHJXYnBUWnkyc1FUcCtJM1JtSE5TWVBqMzI5ZlhkbDdaZk1rb1la?=
 =?utf-8?B?WG82ZWNnRTNPcGJ1V2FRemFIbE51UEsvVmRKeHJYMGY4c09FZzdIQStCUUZl?=
 =?utf-8?B?UXZBTGxDQ2p2Unp0aDVueC9lUktpV2x5ODlyZE13aVIyeGZqWDBVSnpENUY2?=
 =?utf-8?B?c01NT3FhWXVRdnMxLzVQQU4yMXdmaTJIVjN5WWtLQkJmSE95ZDNlQkhFaHFW?=
 =?utf-8?B?ejZBSEZMZjhFcDR5ai91RmwrbUVkVlZpSkR0NmVjQWR5dk1ZM3piM3dYVmJS?=
 =?utf-8?B?M1g4clhHK3pWaWRWaGU2dUswbGRERWRQekpHemRuUjY1cS9kVEdyb0hJSkww?=
 =?utf-8?B?VG9NdDYrMnpCMlJQT0xTYnFtRWxobXFJOG16S21lMjRDSEEyZ0RwOXZqZDdu?=
 =?utf-8?B?Nng0SHkxbkw5NWJ4aUVlS2l5M3VaM1V4cThIeTZGSnFmS29HQ1A5QURlYUVi?=
 =?utf-8?B?UWl2N2tDaExGSFBxR01qa3RBSVBMc29PRFVPU1ZSYXRDWWk5aTlPRnVTMVJr?=
 =?utf-8?B?VVVhNFRkV21wNDdnNmpLQm5mN0YrbXNHQ2k5S2tXa2dHVkdiWUM4TmhRdEpR?=
 =?utf-8?B?ZzkwVGQzKzRsZzZtNUVkMGIvZXIrTTZUUU84aXppcHljQXVFc0ovTU9xRWgz?=
 =?utf-8?B?VHplRVNqMlllbGNoWXpJcU5pTWR2V0dCT2xXcFpOUFpMQ1VqSWRxR1hhaVEy?=
 =?utf-8?B?eUpVVkkyUDBucEs5U2NhYVFYakZDWXdsR25Ibmp6NW1sY0ZKUVlGT1NtYkxS?=
 =?utf-8?B?UC96UU1SME4vVzRrVnJmQWhieFZ0S0dzOTlyQVB4TzUwMzVtdVZQR2ZUSEVj?=
 =?utf-8?B?NUEwN2tQY2ZvWUNvTytJMkZMcDdzRmM1OVY1eVZvUkNkaHNxWnJsL2NCanM3?=
 =?utf-8?B?OWlJZ091WkdlWi9pM2VtZHNkTUFwUTVseHFaeGY5S1hrN2I4YjRPaVUrSytV?=
 =?utf-8?B?NDNrYVkyZ1l0YXQ4U0E2R1l3V2N4NVFPUHJFb2ZSdFBUOGhBd1hRbTZjWHFp?=
 =?utf-8?B?eDBaU1dxbEQ1MkY0Z29LN2hqeFlJVGZXRVZobERNMDVCVTh3OWJSVHFieUF6?=
 =?utf-8?B?My80d3MvbUFWd2FPRlJiTVdKMHFFdXRrQjJqL1hBOGcxVnFYcFAxZ1pqaWVm?=
 =?utf-8?B?WC93VUxGaHowSFJEK0poL0wzcUY2RmJVSjJaWnp3c3pxeGlmYklnYzBLZ0ta?=
 =?utf-8?B?VStHNzVpVVhOaFZOL0dpSmVNMzlFVG9VUTkrOTVvWGJYR1hNa2ZJakx5QnJ0?=
 =?utf-8?B?ejlxVkZ5bHozdW5aUjZ1MC9iU3F5MFo0RGs4U1hFYXhsdkIvaXpnU0pNajFq?=
 =?utf-8?B?UnJCajVsZFRCT0tBYnZGR3JpNXRuUml6aWRHZExKTERlN1JHK0RTaUlIK2x4?=
 =?utf-8?B?NzA0ZTFqR2N5ZHZ1YTY1WithZ1ZyU0hGOXlwZ2V1VjFla1NtS3NYOEJwMmJh?=
 =?utf-8?B?dVFiY2hQektBVU8zYVpzaG9GRGdpMjJqblV4NkJjU29SVkFvYTRreEQ4dFgz?=
 =?utf-8?B?RE1XRjRrR2hyR3djKzJaNHRDWmJTRDkwbVlhbXZnS0VsM2YzandGcURRRTQz?=
 =?utf-8?B?ZVBFbStkWUdRc3Vsb0M2bDNUeG5EYkUzdFV4UElYVjAvV1ZWY1RIQmt3d2tj?=
 =?utf-8?B?WG9OOVNLZXdzTnk2S04rVi9OLzFZV2VGVlA1Z2o5NXBJQVJXOFJ0TUNQS1lG?=
 =?utf-8?B?SlZPMjRaUGZYL2NtTzd0WkIxTGpoRU5mT1puM3ZpczYrdmJ2VmY4emZYczVj?=
 =?utf-8?B?UUxpczJ3dlhETURwSGpCTkVpdENoTHJhSWhYYm1obyticW9CbzVtQm9GTjRY?=
 =?utf-8?B?VmJhcURtaU04YXE3QVYyWUZIVXg5WGJoVklRMlNIUXdlQjRQSDFCM0VKOEx3?=
 =?utf-8?Q?L3cl6QXbAq+E0JaISXUu9TrxPV2w8M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V1FLWkMrWWpORFhDWUNGUW1HV1ZDd0pSR3o0Z00xSG9EQ0s5VmQ0ZFdpMWNy?=
 =?utf-8?B?K3E3L2tMb0hDcFQ1TWltc3E5eGx6RFNKS3p3YllUc0t1aXVCc09IblBKa0Mv?=
 =?utf-8?B?WWRkTXlycWtGU3luKzhxV1g3QVMyZ201TWRtelFQWnNoOXgySzNISUl6MFZ2?=
 =?utf-8?B?SHF4bkxMZmtETnAvcmlsUEQ5b0xJOWNxNk5xT24zUlptcDhtUVdZazlKS0hl?=
 =?utf-8?B?R3EvUzA4dXlVQnI0M3VHai94cWkybmZIU1MwWVRKWmkyUlhjbExMcDBKaW1F?=
 =?utf-8?B?R0ZTVVhUTWloSDdVVitER3R4WUdGdkJ4bkJ3T0FWL29scDN1Qk1DU2ltczYz?=
 =?utf-8?B?WkUrekZ0clVoWjFHR25RcVZuQlZ3djJXanpNcitXU2FuN2tYb3BXUW1WTVow?=
 =?utf-8?B?bUFkWnFWbHZQNFE0VTRDV2dGVXdMRXcrQVF1SFFjNVZERGEwNjh4bCs5WE9K?=
 =?utf-8?B?eUdqZ1lscGtBMUlVNm5ZaFdBaWJ2a1RQRTZpUWxpNW5TUm0rZEtCeDRSL05t?=
 =?utf-8?B?MWsyM2NCUlpLeW1YZGw2SU1IMllwcVcvVndJWkI4QlFseitIZk8vZnV3dzlP?=
 =?utf-8?B?dm9wRXI1ZXhFODk0cXZOK0R2TEJxR0FMTEFGWUJPNUZuMEpJYkFTdUNiZnIr?=
 =?utf-8?B?R3RMVzdtWkh2SlYrdVJLN2xKM3B6dXNuNE5hUnU4THFCMysrWGFOdHhnTldu?=
 =?utf-8?B?RHVrMVlOV0szdWdjMUcrUlB5N2JxU3pXK2VCQ1J6a1kwYW5qVkJFUmh6RVZB?=
 =?utf-8?B?N0lnSmxzb05RdkVSZ1pleHFvemlMYW1mNzdVdTAybXhRR3VSbFRQdE1DU2NK?=
 =?utf-8?B?WWFKd3orV1piY1pSdi9Tc0ozNUNmVEROdnc0SXQ5ZFJLbkNjVzl6VVJ1K05P?=
 =?utf-8?B?b3ZiRHVscVZ2MWFUVUVRNFJPR1dlOGt4VmY3MUovVTdwc20wUGhEVmp6WFBT?=
 =?utf-8?B?NksrSHNTc0IycW0rZkY5VnE4U3R2MGVkTjViZ04xTTNDUnV4SXk0YXJBNy91?=
 =?utf-8?B?VEZFYXRVVWpiek5tWjhlWUYybnpiVS9ad3B5ZjdxMk5WU3cvL0s4bytlUWRy?=
 =?utf-8?B?V1BXempzcm1qRHZEQUxvd05QdVptdDRHUDFuWitPZDRXSVhHaU40UUxrMUQv?=
 =?utf-8?B?M3EwTVR2V3hGajVGUlZYd08xeXAvcFN6eFl4Rm0wZ0hyc2lGNnM2QzVNYU9O?=
 =?utf-8?B?WVg5dnJydnVib2VndWEvc1B1L2c5ejJYSFVSclMyQUNPV0FlY2hONGdVZDgx?=
 =?utf-8?B?aWZXNlIxNW5YY092QkFlSWtuMklLV3JDREsxUWNxT3M1SVhqamtDd1Z3VTJD?=
 =?utf-8?B?V2t6Q3daYkNTTE5mYkwxQnBtaEd5eDZadkQ1ODdCdkptdmVYOFdsQ2hnbnNz?=
 =?utf-8?B?NGFKV21xRTRqUlUwanIwaGM1cGk5UFlZc1VKaEJiTWNxeFV5UldOcUFNMlNG?=
 =?utf-8?B?d0NqS3lwN3hJTHNuYXp6aENIWmcyM0hxTkF1WEVVZjNjV3NJOVNlelBkOEp0?=
 =?utf-8?B?bmYxdVh4cVBjdUViVytSREwwRmxyek85NlF1RGpZOHkwTTluKytMOUk4QzN0?=
 =?utf-8?B?bHdUTXZEdTBTb2ZmeTFrZk1LZG9hL2owOXRrK29OZm5hSVJwS1pERlpES2h5?=
 =?utf-8?B?Y1JlQlFIcVBXZUxJNS9CSmdSeTlXQ2J4ZE5ZRXB0TnQyTmRaU1RUVU50UVk4?=
 =?utf-8?B?bFl3Mk5MM2hzSlFlSnc0MllEL0dUczRHdkpVSlNLbVJXS1k1YzdQUmlpUUFr?=
 =?utf-8?B?RXY4ekFYZXBKK2dSN1lrWk1IbVVnVmsxVUd4VVBRVGhiOElUSVVyTFNOTzlv?=
 =?utf-8?B?QkZNZkdKVDBzdUJ4K013RW1FRDNZeGV3Z1R4WStReWoxZDRLRXZPc3RXVnl3?=
 =?utf-8?B?NWV6dUdIWTk4RE9udjBLRDNRa3ZxS1ZjUnU3R0NWb0ZxVjV5cDFjVTB1bUsz?=
 =?utf-8?B?dWFsTUdkS01NdjMvMm1oSmE0RmR1QXVFT21TazhpTkduRFRoZmEvdWtNeDkv?=
 =?utf-8?B?RE1HOXA1blNPZWVXTjh2R2dQdk9ML3M1bFdVdTJHaWt1cGNrSU5EQkhjMlVD?=
 =?utf-8?B?SStRdWFqODN1K0pwMmxyUm04V2t5bmwvZUtBOFZyRDF2WC84QU56NXd1UXRs?=
 =?utf-8?Q?e0iI=3D?=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4961a8d8-6784-4016-2ce2-08dda282b644
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 09:40:44.3594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DBzaupe5qfDt2W7yy+GIxGj/vX+0CLpTwVBb3lG5lwObOPn0EL4S4lIaK0Bv96++BLBEJgskdfAppUibva8d7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB6272
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <CBCAE0563E89194EA16056604B7540B2@namprd15.prod.outlook.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDA4NCBTYWx0ZWRfXzAwKS4Y3oRXR sgozXUoLJdcZmyHJwN172gFAG7I9YpLvdvUc9bDnzQv0yxeL7jcmwkiyBMu896wvYxEjvz9T8PM nAZJVOLwkK4V7xC/VQpCMjlSwkJ7iLsjMnOYbHd+BcrOvbI4y5QH0biKSx+0fBurM4usMss3MnB
 1moMQxevzAm0+9am82cdKbbbqSImacGh5MSEbUtcY4OTibW/2bhpTo4wbHtG7Xm8O2tjz7yKqbD 7DV/xLyom0aueIA6xoU8xqbqoOyQ/sIgQpeZ6evPyA8Q15lDf0ZmBL8mzW+isNI/ih7qRRqv4pc B74h+faovggYGVP2fQap8cOSVXrWNMzPJGa0TeXixQNwd7ErIvFTSkdfGcqD5BAbfLeZ+PSIzHd
 +W8jwvN3Jrj8pE5ce/nYSxOoPdaQ5l/iUlCAP4GYwLSrha8cSUYoP0YJ7Ir6sURZr8V9Urp+
X-Proofpoint-ORIG-GUID: EMvEcdD3TKP_pv2jbksaqBLX9fRgnCbv
X-Proofpoint-GUID: EMvEcdD3TKP_pv2jbksaqBLX9fRgnCbv
X-Authority-Analysis: v=2.4 cv=MZ5su4/f c=1 sm=1 tr=0 ts=683ec320 cx=c_pps a=n1/gUQMs0EKbrxaRV/iiRQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=NEAV23lmAAAA:8 a=FOH2dFAWAAAA:8 a=iox4zFpeAAAA:8 a=WeTxxjrQD9yqjB9YBwUA:9 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01

On 2/6/25 21:16, David Sterba wrote:
> >=20
> On Thu, May 29, 2025 at 10:37:44AM +0100, Mark Harmstone wrote:
>> Each superblock contains a copy of the device item for that device. In a
>> transaction which drops a chunk but doesn't create any new ones, we were
>> correctly updating the device item in the chunk tree but not copying
>> over the new bytes_used value to the superblock.
>>
>> This can be seen by doing the following:
>>
>>   # cd
>>   # dd if=3D/dev/zero of=3Dtest bs=3D4096 count=3D2621440
>>   # mkfs.btrfs test
>>   # mount test /root/temp
>>
>>   # cd /root/temp
>>   # for i in {00..10}; do dd if=3D/dev/zero of=3D$i bs=3D4096 count=3D32=
768; done
>>   # sync
>>   # rm *
>>   # sync
>>   # btrfs balance start -dusage=3D0 .
>>   # sync
>>
>>   # cd
>>   # umount /root/temp
>>   # btrfs check test
>>
>> (For btrfs-check to detect this, you will also need my patch at
>> https://github.com/kdave/btrfs-progs/pull/991 .)
>>
>> Change btrfs_remove_dev_extents() so that it adds the devices to the
>=20
> There's no btrfs_remove_dev_extents(), the code is in
> btrfs_remove_chunk()

Sorry, that should have been remove_dev_extents(). I have it renamed in=20
my tree so that it can be un-staticked.

>=20
>> post_commit_list if they're not there already. This causes
>> btrfs_commit_device_sizes() to be called, which updates the bytes_used
>> value in the superblock.
>>
>> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
>> ---
>>   fs/btrfs/volumes.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index e59aa0b5c4f3..ee886dc08d15 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -3272,6 +3272,12 @@ int btrfs_remove_dev_extents(struct btrfs_trans_h=
andle *trans,
>>   					device->bytes_used - dev_extent_len);
>>   			atomic64_add(dev_extent_len, &fs_info->free_chunk_space);
>>   			btrfs_clear_space_info_full(fs_info);
>> +
>> +			if (list_empty(&device->post_commit_list)) {
>> +				list_add_tail(&device->post_commit_list,
>> +					      &trans->transaction->dev_update_list);
>> +			}
>=20
> There are 2 cases, one is being fixed here. I wonder if we can add some
> sort of assertion or transaction commit time verification that we don't
> miss that in the future. The pattern seems to be after
> btrfs_device_set_bytes_used() and btrfs_clear_space_info_full(). We'd
> have to have something set a bit in btrfs_device_set_bytes_used() and
> check it in commit unless something unset it when adding the device to
> the dev_update_list.
>=20
> Otherwise ok,
>=20
> Reviewed-by: David Sterba <dsterba@suse.com>


