Return-Path: <linux-btrfs+bounces-11295-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B4DA293AB
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 16:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D862716E099
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 15:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0445F16F288;
	Wed,  5 Feb 2025 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="VgS3FSJB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01886155333
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Feb 2025 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768147; cv=fail; b=EmcZq19S080KQz0URPgYEbLYZBM7EMnOgf9I5Gng6MNfkPXIlNHYjGtmPvjnELbzLcC4lOgVj9jvU2SLSRYlBXUuAHQgN/VmhjjO5xpl2ohziKH2yVDe/4/XXgwiyKXHParqSwvwVDy83tVQPpmmJfirjJNEBGte0uJY2O3Na1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768147; c=relaxed/simple;
	bh=U/wWh3EEILQ9u6zkt+thR/P9XtZ2zvSc8Z0AJQteC7k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=UiBP9MTmmwrJCPaFZk8h2QAN5DPq1gokFSW1zSBkutBE6dPBkrKq0iQ5rSi6xW+7qCISAGSatnS7Nud3LZOwFtOgvJd4/1z4T7YXq9+dVSPbLgRm6+WwsHAakeSCjiBi7Sm4GUoduf7ADOaW7Ma+eX+5myoXrX4TRG2SHZ7F5iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=VgS3FSJB; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 515F66kN030063
	for <linux-btrfs@vger.kernel.org>; Wed, 5 Feb 2025 07:09:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=0iUBFoOcgk81B7zcYoCeAuK3xeEh7AYEP82myw84qd8=; b=
	VgS3FSJBiEKcTliYbVljZtaSIDZ6sBW4ns2Jt5xjTRJ1AXZAfJYlEb43gW66Ez+F
	cBbmwLxorvH6bK+abAOBTYFWWVMMGzR13WvmmwN2ZIau/I9MNt9f66aRv2K2KgFr
	l3PrNt9vve8D+XYyTrsGzqE3LsNL3SF1TtEAwq7VqLsXQO36nA9XXVYdeoCq+za1
	GBPUAc2F7g57yjm2FQPLNsEVRzMBNOvHN1ZzTBdRQMH5f4kZrIpQGZQBJhGj1KQl
	+2urcfs9irQ72rDnm12joVdkk1SW124o6Rqqh2xPRTzqO8bMFBjjiJWp0tTXoEor
	tE9mUrgv/jp5m/NqnHLGaA==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by m0089730.ppops.net (PPS) with ESMTPS id 44mab600rs-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Wed, 05 Feb 2025 07:09:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZfOUEQB8vjZqDUtb0ZYHyuO9cDzElg4B0rmx+HZjwPS0BHiO1u3sGzieQx8bOqQ/MGwixKry8VzlVS314RoFBsQYb5ze27dwXy9wv0Ds2MMnGuTvcuL+76yfK/GbGcW/Opm1Et//WVc/3men6jUzeTOzCmbnDW6FwmQNvRjgeNbUm0ew9pEcCoIScur23O44CQMfO7juNH1NmGzwHB4b5erzZAOeXn38hgln3pANX2LhFYZzWYMy/DCUIwAAvY2j7/ep3dLlZ+o+eXAtOgoQsRnENtvAKgZX9A2Iu6NDpXhnGHgL3AqbYZRW4whbXvtHtFuPbv7xjgSsncOxeuAIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0gsJuuUQ83gmZDxOQXULlAD2jZuK14PKzrnFuDQt18=;
 b=KhRmE4vXqe1alSIuC2FTpQx7oAXbSt2QhbKbI8gEK39pX80Pp5J440s0i5pYmQSGFiDrlDF8VqmN4+p1nkcqTr5JiV9C/1p+h8W9vMli30xu+Yn/DAv0BRoPyZPmvxjPiurte6easu3IBHsBnrYh1pfGWKe5SmSCD9csdffcCE/O8t5R8sCDjbM1Pbp0kJQUhvFP6PSwMYZ0n53Nb0OwIBfYxEKE1sgX0Ub9gUkKer8H8UKCD+WMxBY4kPenb+jVLd6j5AGMWwhdWNOsXPlaWzqYVYSS2Km5oYZNRXvR3htUapWmv54y4JCSRfV2foEO2vaUQcvkC8eCbj6SF3XiJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by SJ2PR15MB6401.namprd15.prod.outlook.com (2603:10b6:a03:56d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Wed, 5 Feb
 2025 15:08:59 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%4]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 15:08:59 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: Boris Burkov <boris@bur.io>, Daniel Vacek <neelx@suse.com>
CC: David Sterba <dsterba@suse.cz>, Filipe Manana <fdmanana@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: use atomic64_t for free_objectid
Thread-Topic: [PATCH] btrfs: use atomic64_t for free_objectid
Thread-Index:
 AQHbbMivsPcQp6znhUC74MzCCLPe17Miu8CAgAAUEQCAAhrjgIAArciAgABEL4CABQ9uAIAAK0GAgANRqwCAANNmgIACGYqAgAeQPYA=
Date: Wed, 5 Feb 2025 15:08:59 +0000
Message-ID: <4a42d804-ab7b-4734-a99f-c80ae354e93b@meta.com>
References: <20250122122459.1148668-1-maharmstone@fb.com>
 <CAL3q7H4tB3Cb-djYhh_bGB-BRJ7EahjUZec2qfbhH7QHP2iSUw@mail.gmail.com>
 <CAPjX3Fd+-510YrvpxR1GcK2F+XKDVknxes2sj=Eat1Un1zvEkQ@mail.gmail.com>
 <20250123215955.GN5777@twin.jikos.cz>
 <CAPjX3Ffb2sz9aiWoyx73Bp7cFSDu3+d5WM-9PWW9UBRaHp0yzg@mail.gmail.com>
 <CAL3q7H7+UZcXPefg-_8R=eZj42P2UkV2=yE1dSv8BQZagEOhyQ@mail.gmail.com>
 <962f5499-d730-4e30-8956-7cac25a6b119@meta.com>
 <20250127201717.GT5777@twin.jikos.cz>
 <20250129225822.GA216421@zen.localdomain>
 <CAPjX3FfG9fpYWn-A8DROS9Kk3RTRj2RU+MP00gg7dCk=TF36Og@mail.gmail.com>
 <20250131193855.GA1197694@zen.localdomain>
In-Reply-To: <20250131193855.GA1197694@zen.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|SJ2PR15MB6401:EE_
x-ms-office365-filtering-correlation-id: 6734bcbb-90f4-4902-20fe-08dd45f704d2
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QWs0RW91NmpYZnpkN0czYVhxSlh4TE9uSyszQlp0V1l0UDlZaGw1UCtFTTdi?=
 =?utf-8?B?MUtQbkFodiswTFp4QzFhRDcrakl5UFZOcEpPRXhMRk9hTXdzOW9saGdkZk0y?=
 =?utf-8?B?M2lzM3BmZStwblVGV3RPelkzcXU5ak9Hb2JwaTg3Tkc3Nm9tYWxEVWdRMWNH?=
 =?utf-8?B?QVFiNG9iSTlnZWdUbTNhMTgraThwbmZ4eEhYak1YM09nVk5WeUxZWUVmaUZv?=
 =?utf-8?B?UlVKMHNNS0FBdVdVS0g1ekhQeEUyOHllQVFZb0FnOS9BWmxuNERGRWU2Y2Rn?=
 =?utf-8?B?TFJVaWdzdGF1ZXIzUlNZRGhLeWR2VHNFN1JpL0gyNU50T1VDcHNxS2x5U21u?=
 =?utf-8?B?b3A0WjgvbVptUkZ6K0NvcnNBdTRvSmgvR1NJampxbVdlclVUTE16YWkveWpJ?=
 =?utf-8?B?N2RiWmpIbExwbmhpSFQ3aENsdXd5bVJpRElKMWtOYUdIMStBbU5reW5aQlpN?=
 =?utf-8?B?TUxDODFuUVYxdjZ2RUM3Tit1QkhheVNDNGczekpiZndrSTV5Y3pXbnI5bDRu?=
 =?utf-8?B?czJlS01MNGcvNnBsRngyUy9ucys2c2dBQVNOVHNuWERNeWFlQ2RQSStkMjRy?=
 =?utf-8?B?ak1VdnF6UFQ4cUloWWhnLy9lelpOM1I2cG1RVUtPTm5takZFOGRFK0VwTXNq?=
 =?utf-8?B?aXlTaDFTazdJR2VDZlFpU3VmWThDUjlNYXhhSVJodWJvOWVUU0tlVEFlUW1z?=
 =?utf-8?B?L0h4dFFFQ2tZMHQyT2VadnBCclora3RUYlFXREIvcXdHMnVweWU5Y0ZvdEM1?=
 =?utf-8?B?R255a0JENnRESnhCQTRuOWlZaDFFSUtUbWlCYkVRYXN4YnFSZnNHWGJmVEVy?=
 =?utf-8?B?RCtjOU5aaUtqdkllZStNNkcvakQrNU1GWTZSNWxyTmMxOVJEc2dzc2R3elhD?=
 =?utf-8?B?T0dGUktsZ1laRlZWTmZoZlJ0enphV0dEbWE5bW5jUk5MTU85TzBWYnNMNU5y?=
 =?utf-8?B?Ym0xL2lLbFJlbEg0ajJ4V3FkSllrUGYyc3ZKSDk0alpSVWthUlhwN3pHazV3?=
 =?utf-8?B?aUJydUx0WjFVa3hQWEZxWE41aGhWVXl3MllaN0dQTkpPRlV5SXY5L0UwT2Ey?=
 =?utf-8?B?MXo0a2dlTlFJMGxwODRqZEdzb3lyeVo4YU5ERjlOejFmQ2IrS2dmMTFaZVov?=
 =?utf-8?B?SklYc3U5MzBKY0JYejVORFlTaHd1SXpJS0RLVFRqUG1YelBVOFNWb3JNQkly?=
 =?utf-8?B?Y2NEZkI1a0dWSWlwcnBRam9zSE1GTXB4NDVzU3ZnSXhRMTFPTW9uYWVwOE5K?=
 =?utf-8?B?L2ljU0hacWg1Yml5RzlTbXMrSnE5WjhyUDk1Q2FZUWoyMm1RRUdIazAzL3U4?=
 =?utf-8?B?THAyRnZoSmoreEl4NWpid3J1VktnbVN4K3dGaFI2QytUWEZBS1N5Z1AxM3dh?=
 =?utf-8?B?L1djMm1LaUFVMTQyL09aZjRkVFNpYjZ2ZTFVQTlnTEhvQlpuYmtLbS9XVWtl?=
 =?utf-8?B?bzhWNEovaDJtVVVhNlkxTUVzaHBIc3Q1TnpzRHBBejd1VDR6MWxQd3I3Uk9i?=
 =?utf-8?B?ZXlRQU9wbmdjWm5wckxHWUJ1ZkUvdXV6a1kwV3Awd3lGOXNuaVJrM1UvQ3Jo?=
 =?utf-8?B?bDZuVk1mY2VZU3lmNm1QalNQd2xpY2lBNmFiRlpXTUpMMk5mNEdTZ3hpNmY5?=
 =?utf-8?B?cVdVeENrUzhhdTZJd05tS2FzdUpEQms1OGdMZkw3WWlxRHB6bFZPN0lVSTEx?=
 =?utf-8?B?YzQyZjFEZEN5N1JZK3pGKzFWcDYrRlZNMXhEWSt6R0tJYkRGblN3d0ROSExG?=
 =?utf-8?B?ejVucXQ0ZWJmQXNURnNrVHR0Z2h6NDUzQlNPdFlTZU9QTjh2MWdYbnNIakZM?=
 =?utf-8?B?Wk5GWlI2SzE5dGxWemFBd1JyOGcrYWxmaGlxTEUvdTBqRkFVTWp6TUxIYW5j?=
 =?utf-8?B?RWJYWlpmMjJPNTRrcW0vLzhKekIrOHBwM3FmUFdMT1IraUh6bHp1WjRGSmw1?=
 =?utf-8?Q?GYvl3bstgpGv9nBt55NqslwXGePt0cas?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bFRyYktzZEExRkJBSXpNdVdhNjBnNlVyVHJSRmUwUDdHd0RRS3gva3AyaUlq?=
 =?utf-8?B?d3FLVkxHc0JwS2ZTVzN3dVlmcnA1K1B3K1BHZEE2azNLbjM1Y2FlUGQrVkdY?=
 =?utf-8?B?Sis4U1ZSZ0EwUENRb1BVNW1jSnBhMEg5TEU3cTJaV1lyV2h5TjZqK25IRjlt?=
 =?utf-8?B?eFZucmdvRStKU0s2c0M4aVVCUmI1RkRUR01tT25wcytCT0pnT1NxVkZwdE5n?=
 =?utf-8?B?UW1SbE5hZ1NpcWNCcC8ySG82MUZudDk1Y21zOWJBaVIxZ205SmU0bDdVamRq?=
 =?utf-8?B?NDIrdmpFcGF4MmhRUHoyTG5XMXJQc2JXTmtaNDBBQ2Fma3BMck02ZFFZOXky?=
 =?utf-8?B?QXI4VUdnMFFkMWlESTBsMCtCRHBsQW80Rm9yRUwvangxTXB5b1N0TTRqU29S?=
 =?utf-8?B?dWZROTlDQkIyVkNSL01GTEswUFpXQWxEbmx5RlI3OWJFWEFFMDd1U3RabW9v?=
 =?utf-8?B?b21ZcjRIR0RPWXNIT3pVSjZMcTRsL293VzBJR1YwSEkzTDZISmYzZnNlSHNk?=
 =?utf-8?B?TmNTT2oraDhIZE0xQkRLZks5U3cyUS85ZmJaY2haVjRneStkZ0lMMUUzbERj?=
 =?utf-8?B?MC96S3NGeGlsY1dvZmkxU2YwOWhvTzdaR3A0V2FZQkxGVWVmeVEvQ2g5RUJj?=
 =?utf-8?B?a1M1VW10ZEp0eStpRi9lOUdvV21nN1hhK3ErM3JLZ3BHbEkxM1pYckxKTXls?=
 =?utf-8?B?MTIralM5R3ZRZ2tzeldWSlRCOGt4WnRtOVZsS29lUlZyWnRnK0ZGNStUQlVp?=
 =?utf-8?B?ay81K0hHWndNSlJIK1VwNGw4c3RzUWM3NHcwajNaWGNJendqQWVlbHVQZExh?=
 =?utf-8?B?dkNYa3ludXFLcExzMnVGOGxEeVJaU25CRkZFU3k1UURONHNWMi9ZdUY2U1NU?=
 =?utf-8?B?N0xEamJlMGR5b2IxTnRiL1B4enBCRHUvZ2FqNnMxaTFCc21LNzZYY0NNZ3hH?=
 =?utf-8?B?bGY5NlBGeXNtbTZOTndBcENRMHJXMzgzeTRTMXo0ZVh1SUU1eHlEeGVmYUlI?=
 =?utf-8?B?SzdvbVdDbUx2NDhaVlBEWlIva2NLUEFYakF2UlZpRDhnNmVHMVFlempQS0U2?=
 =?utf-8?B?UWJGaFU3bERJNkpJSGJ6cE9vMTQ5UFZwY2tsM1ZBakVBZk03QTY0MUVIMWpP?=
 =?utf-8?B?YTN3ek15ZTV0cmRSQ0prcmZTY3k4ZlFzcFhTNmN2dmdReWgzQzdIbzdWczVy?=
 =?utf-8?B?NmduZkNNc0NYcG8yN0pxMjR4UlZsMXlBbG16cSs4SEhDOW9uWnhVVWo4Z01Y?=
 =?utf-8?B?eC91NGV5VFpsVElTQVV5cG05WFBodk5US0dvTWlWQ1MybUJsWGRyZTQrdHlq?=
 =?utf-8?B?enpTVW1KWFY0RUdKSmV4aFZlOVZLR1BqcGlTdUxoTlZ3blRIYVFvb3lndXZy?=
 =?utf-8?B?TGpVLy9SY0t0WnZZbXhBSnpZUjk1TUR1TnB2WXRHc0NndG9yd0JuWWFUaG9B?=
 =?utf-8?B?bGpmcEF3cE4vV1lNRmpKZ2pLekIvTjNncVU4MzFQVFQ0Y3Jvc2k4SUNhY1Fl?=
 =?utf-8?B?Rnc4ZWQwdlYwZ0M2WjVsM2d3aENyNlJKRTJWQ2FtUlZYTTZlQVVVOWowNVBV?=
 =?utf-8?B?ZW84bC9TSFlxMXVjYXBEa3hjbTdUS0E1YUE1NFUzeGY3QlJDS25jaFhJMkFV?=
 =?utf-8?B?SzRaWURXcms3VUluV1NyWFp6SDIrYUJRR0Q0MkV1aHdGazFFd0sxSy9UVVpw?=
 =?utf-8?B?WWRRdkNsRmJlMVZxMEtWckJ2SzFkTXlzTlREWkFhVGM1RjdsRkVuRTJBclFR?=
 =?utf-8?B?UDA4eThac0ZldVRBSHRFZE51OCsrTEw3TlBvdkwxMUgxK0ltQUFwRnlJMFhO?=
 =?utf-8?B?V3ZlWlp6cFpZZ0dhakdHaVQxSVJxYVJMQWUyZE9wUlp5alVOeVhSWmNmUzdE?=
 =?utf-8?B?Y1hPM1IyMExRQXNHRW9YOXFTdE43SDlDZE9WbnFUQ1YxbGlKcFFtdVVhUTVR?=
 =?utf-8?B?em9WNXFOYmNDMU1qQTd1YU9BT2ZIR2VxeGZPVENkNDRZQ0pNaGdKVm5MTEkx?=
 =?utf-8?B?bXlHSXFpSXVOZ0FtK3NsZ3cxclZTR2J3N2czbHRCOEwrWWRKRlRXQ09VS0cx?=
 =?utf-8?B?YkhNbkNtN28wRFpFWWdSK2dnZFBiMm1kTXhuN1lnWGlyT01UUEtHUjJSNmdo?=
 =?utf-8?B?L2prcWttdk9PQzQ2dzVlN2VIVUJ6akJIYWJHa3FlZzFkejdQVWxrY2lnTUQ2?=
 =?utf-8?Q?or/pdnjElsT7Fiq16diRusk=3D?=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6734bcbb-90f4-4902-20fe-08dd45f704d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 15:08:59.6156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: icvXY35b4QJrwm3YiVF0ifL2ZqT3rkU8CNZOCxevPSoghlbEJItLUgLByB4FVtzNyhmNYMTJprSufgmXpbtOdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR15MB6401
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <19564CAA1D379D4FBB9D829E1320A3AB@namprd15.prod.outlook.com>
X-Proofpoint-GUID: deqxZ9Dl17hyJMBWNOYIJUcYd-dCiyh1
X-Proofpoint-ORIG-GUID: deqxZ9Dl17hyJMBWNOYIJUcYd-dCiyh1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_06,2025-02-05_02,2024-11-22_01

On 31/1/25 19:38, Boris Burkov wrote:
> >=20
> On Thu, Jan 30, 2025 at 12:34:59PM +0100, Daniel Vacek wrote:
>> On Wed, 29 Jan 2025 at 23:57, Boris Burkov <boris@bur.io> wrote:
>>>
>>> On Mon, Jan 27, 2025 at 09:17:17PM +0100, David Sterba wrote:
>>>> On Mon, Jan 27, 2025 at 05:42:28PM +0000, Mark Harmstone wrote:
>>>>> On 24/1/25 12:25, Filipe Manana wrote:
>>>>>>>
>>>>>>> It will only retry precisely when more concurrent requests race her=
e.
>>>>>>> And thanks to cmpxchg only one of them wins and increments. The oth=
ers
>>>>>>> retry in another iteration of the loop.
>>>>>>>
>>>>>>> I think this way no lock is needed and the previous behavior is pre=
served.
>>>>>>
>>>>>> That looks fine to me. But under heavy concurrency, there's the
>>>>>> potential to loop too much, so I would at least add a cond_resched()
>>>>>> call before doing the goto.
>>>>>> With the mutex there's the advantage of not looping and wasting CPU =
if
>>>>>> such high concurrency happens, tasks will be blocked and yield the c=
pu
>>>>>> for other tasks.
>>>>>
>>>>> And then we have the problem of the function potentially sleeping, wh=
ich
>>>>> was one of the things I'm trying to avoid.
>>>>>
>>>>> I still think an atomic is the correct choice here:
>>>>>
>>>>> * Skipped integers aren't a problem, as there's no reliance on the
>>>>> numbers being contiguous.
>>>>> * The overflow check is wasted cycles, and should never have been the=
re
>>>>> in the first place.
>>>>
>>>> We do many checks that almost never happen but declare the range of the
>>>> expected values and can catch eventual bugs caused by the "impossible"
>>>> reasons like memory bitflips or consequences of other errors that only
>>>> show up due to such checks. I would not cosider one condition wasted
>>>> cycles in this case, unless we really are optimizing a hot path and
>>>> counting the cycles.
>>>>
>>>
>>> Could you explain a bit more what you view the philosophy on "impossibl=
e"
>>> inputs to be? In this case, we are *not* safe from full on memory
>>> corruption, as some other thread might doodle on our free_objectid after
>>> we do the check. It helps with a bad write for inode metadata, but in
>>> that case, we still have the following on our side:
>>>
>>> 1. we have multiple redundant inode items, so fsck/tree checker can
>>> notice an inconsistency when we see an item with a random massive
>>> objectid out of order. I haven't re-read it to see if it does, but it
>>> seems easy enough to implement if not.
>>>
>>> 2. a single bit flip, even of the MSB, still doesn't put us THAT close
>>> to the end of the range and Mark's argument about 2^64 being a big
>>> number still presents a reasonable, if not bulletproof, defense.
>>>
>>> I generally support correctness trumping performance, but suppose the
>>> existing code was the atomic and we got a patch to do the inc under a
>>> mutex, justified by the possible bug. Would we be excited by that patch,
>>> or would we say it's not a real bug?
>>>
>>> I was thinking some more about it, and was wondering if we could get
>>> away with setting the max objectid to something smaller than -256 s.t.
>>> we felt safe with some trivial algorithm like "atomic_inc with dec on
>>> failure", which would obviously not fly with a buffer of only 256.
>>
>> You mean at least NR_CPUS, right? That would imply wrapping into
>> `preempt_disable()` section.
>=20
> Probably :) I was just brainstorming and didn't think it through super
> carefully in terms of a provably correct algorithm.
>=20
>> But yeah, that could be another possible solution here.
>> The pros would be a single pass (no loop) and hence no
>> `cond_resched()` needed even.
>> For the cons, there are multiple `root->free_objectid <=3D
>> BTRFS_LAST_FREE_OBJECTID` asserts and other uses of the const macro
>> which would need to be reviewed and considered.
>>
>>> Another option is aborting the fs when we get an obviously impossibly
>>> large inode. In that case, the disaster scenario of overflowing into a
>>> dupe is averted, and it will never happen except in the case of
>>> corruption, so it's not a worse UX than ENOSPC. Presumably, we can ensu=
re
>>> that we can't commit the transaction once a thread hits this error, so
>>> no one should be able to write an item with an overflowed inode number.
>=20
> I am liking this idea more. A filesystem that eternally ENOSPCs on inode
> creation is borderline dead anyway.
>=20
>>>
>>> Those slightly rambly ideas aside, I also support Daniel's solution. I
>>> would worry about doing it without cond_resched as we don't really know
>>> how much we currently rely on the queueing behavior of mutex.
>>
>> Let me emphasize once again, I still have this feeling that if this
>> mutex was contended, we would notoriously know about it as being a
>> major throughput bottleneck. Whereby 'we' I mean you guys as I don't
>> have much experience with regards to this one yet.
>=20
> In my opinion, it doesn't really matter if it's a bottleneck or not.
> Code can evolve over time with people attempting to make safe
> transformations until it reaches a state that doesn't make sense.
>=20
> If not for the technically correct point about the bounds check, then
> changing
>=20
> mutex_lock(m);
> x++;
> mutex_unlock(m);
>=20
> to
>=20
> atomic_inc(x);
>=20
> is just a free win for simplicity and using the right tool for the job.
>=20
> It being a bottleneck would make it *urgent* but it still makes sense to
> fix bad code when we find it.

Yes, precisely. The major bottleneck for file creation is the locking=20
for the dentries, but using a mutex just to increase an integer is=20
obviously the wrong tool for the job.

> I dug into the history of the code a little bit, and the current mutex
> object dates back to 2008 when it was split out of a global fs mutex in
> this patch:
> a213501153fd ("Btrfs: Replace the big fs_mutex with a collection of other=
 locks")
> and the current bounds checking logic dates back to
> 13a8a7c8c47e ("Btrfs: do not reuse objectid of deleted snapshot/subvol")
> which was a refactor of running the find_highest algorithm inline.
> Perhaps this has to do with handling ORPHAN_OBJECTID properly when
> loading the highest objectid.
>=20
> These were operating in a totally different environment, with different
> timings for walking the inode tree to find the highest inode, as well as
> a since ripped out experiment to cache free objectids.
>=20
> Note that there is never a conscious choice to protect this integer
> overflow check with a mutex, it's just a natural evolution of refactors
> leaving things untouched. Some number of intelligent cleanups later and
> we are left with the current basically nonsensical code.
>=20
> I believe this supports my view that this was never done to consciously
> protect against some feared corruption based overflow. I am open to
> being corrected on this by someone who was there or knows better.

This was my conclusion, too - it was a relic of older code, rather than=20
a conscious design decision.

>=20
> I think any one of:
> - Mark's patch
> - atomic_inc_unless
> - abort fs on enospc
> - big enough buffer to make dec on enospc work
>=20
> would constitute an improvement over a mutex around an essentially
> impossible condition. Besides performance, mutexes incur readability
> overhead. They suggest that some important coordination is occurring.
> They incur other costs as well, like making functions block. We
> shouldn't use them unless we need them.
>=20
>>
>> But then again, if this mutex is rather a protection against unlikely
>> races than against likely expected contention, then the overhead
>> should already be minimal anyways in most cases and Mark's patch would
>> make little to no difference really. More like just covering the
>> unlikely edge cases (which could still be a good thing).
>> So I'm wondering, is there actually any performance gain with Mark's
>> patch to begin with? Or is the aim to cover and address the edge cases
>> where CPUs (or rather tasks) may be racing and one/some are forced to
>> sleep?
>> The commit message tries to sell the non-blocking mode for new
>> inodes/subvol's. That sounds fair as it is, but again, little
>> experience from my side here.
>=20
> My understanding is that the motivation is to enable non-blocking mode
> for io_uring operations, but I'll let Mark reply in detail.

That's right. io_uring operates in two passes: the first in non-blocking=20
mode, then if it receives EAGAIN again in a work thread in blocking mode.

As part of my work to get btrfs receive to use io_uring, I want to add=20
an io_uring interface for subvol creation. There's two things preventing=20
a non-blocking version: this, and the fact we need a=20
btrfs_try_start_transaction() (which should be relatively straightforward).

>=20
>>
>>>>> Even if we were to grab a new integer a billion
>>>>> times a second, it would take 584 years to wrap around.
>>>>
>>>> Good to know, but I would not use that as an argument.  This may hold =
if
>>>> you predict based on contemporary hardware. New technologies can bring
>>>> an order of magnitude improvement, eg. like NVMe brought compared to S=
SD
>>>> technology.
>>>
>>> I eagerly look forward to my 40GHz processor :)
>>
>> You never know about unexpected break-throughs. So fingers crossed.
>> Though I'd be surprised.

More like 40THz, and somebody finding a way to increase the speed of=20
light... There's four or five orders of magnitude to go before 64-bit=20
wraparound would become a problem here.

>> But maybe a question for (not just) Dave:
>> Can you imagine (or do you know already) any workload which would rely
>> on creating FS objects as lightning-fast as possible?
>> The size of the storage would have to be enormous to hold that many
>> files so that the BTRFS_LAST_FREE_OBJECTID limit could be reached or
>> the files would have to be ephemeral (but in that case tmpfs sounds
>> like a better fit anyways).

Like I said, the dentry locking was the limiting factor for file=20
creation when I looked into it. So it would have to be O_TMPFILE files,=20
and then you'd hit the open fd limit early on.

When I mentioned this issue to Chris Mason, he thought that maybe percpu=20
integers were the way to go. We wouldn't need any locking then, and=20
could keep the existing overflow check.

Mark

