Return-Path: <linux-btrfs+bounces-9522-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E5F9C5E8E
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 18:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10E9BB3DE79
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 15:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9EA200CB1;
	Tue, 12 Nov 2024 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="C8R2Offw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCB32003DC;
	Tue, 12 Nov 2024 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731425042; cv=fail; b=D4n3NzoXzhegVQfkx/ymje3hXmz33T69HsiOnnfRVLKPIGZcNDVS4p3F1+bynlVNVv8srdS99W9uYipeYuja/gCcZUFhuHJzfU+kZ+D+361QfqdgkZFZZDfnXmDXUrFXU8LPQD24u457OBP0uq3HO5V0cw7Aup2SACXssYNjH2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731425042; c=relaxed/simple;
	bh=U6YbAQTLnjxgfMQimanZt++apepW42P+B3Njo2UyUGk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=pvnj6hCVfdCsi1y/AZ/lgCyerbEL6MtiTo6fGMLlSWArdEwvCXM+kC7tr5N7jp3D5ZTiXmw2sVOLgQ7Dwnsc0TaFfBPhIBCtK3dBf88DbJpHoEBHp3O0iMtjPtoZkovJ0PK0vqii0qZCFTEuEJFk/hgRdKoFcLjl3BSI8z1ugwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=C8R2Offw; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4ACB1Gmc008730;
	Tue, 12 Nov 2024 07:23:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=aYYmtjRVeQ+X9XHItWxGEPMKv5J+b8LwbBg2bGBwYR8=; b=
	C8R2OffwxOycXCzcSzoUbQNcrOipe+DWLM4RCowtdv1vN/MPdzQohqlzRpkOfmFi
	by6dfD4tzbB7lArp91FqYvY63rDKYEYnhYjAP5eug/OM6h4WYbnKoV9n3lcQbCgr
	FZNsm2/IQeV98HDn8ISC/PY6YSn0rrFarW0xm1OvwVDkieuNuWbxAagLmPvAZPnS
	eEYUqpPjExTyAVIozvtdYUk33p/xectrP1S0ZbY+qzcvdbFduESkHg8u23UAqhd3
	4XnWvnAdHHX3KpQZqXoVvnkVbaGywCEgcypy9pidHzSyHjPKBPpIZLiqAcy+igKO
	jDAzRjoajDer5o6c5DfLyA==
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
	by m0089730.ppops.net (PPS) with ESMTPS id 42v5sb9sd6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 07:23:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMJdGifjtbL/JJ8uEYrGw9HFuam0r0/fOEtHkbHQMqR+LFUs8T4+TDDAWVJclBVhDUEdjcroXCrD6/q1alfDttl7GxBnXrAKjpx2rFhXLI+x2iAnMOSsPffncu1mdwnu2714akDSV6I8wIZz38r0hdkERpcRQUoli58rQ9o+tB7pish1VgKgoZ8HHeH89XW4G/aR3KJAa8DTII4hGyMJcCPm3qHLFnZJxKl6WXACyvHKIubBiYmCu1MdviESLHd04jBjFatUrIT4T3S21K7IAD4/ib/OTQxaI8Is+7IUXFy1hLUfoC1DoHs3pVaAHcv98hvKY7g8Ol+Pos1EIRiy4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdXrksWPtiJsO9UZ14RHwGZVpDs/BAq/cMyadquoD4Q=;
 b=KMHV5ogv+VrHLiTjMJ0fScNMWY2AT0GiSxyzNActeJzvJXpvgTa0UPNX8/hQgE1DCvjxIV9+1UMBORZ5HI0gVWGQq8jLgNPOwndR1G/M54B/NBaJhoNSSh9j6KTSeWpcFNe8kMod+m5/QLKqJcQuH3GB3w2YLdpBWQRA7T2V/pz+BogynKY/BpBIOUGsDU3TtCXeerVO+nZ07Wa2cRcWQXtSPPq9flFWeafbZYuJ2ZZJ16wAl7NV0om2Q1oNfT8DUbk1Kz+zbgv/JJZyEduSd0k1JwPaW4Qs+KyhdlMCnHXdiTcvcSWhwkJrGCyIgxH1ndY4ySekxg2747qSfLY9YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by SA6PR15MB6690.namprd15.prod.outlook.com (2603:10b6:806:419::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 15:23:55 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 15:23:55 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Mark Harmstone
	<maharmstone@meta.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: add test for encoded reads
Thread-Topic: [PATCH] btrfs: add test for encoded reads
Thread-Index: AQHbNEnT1dyQ3VMT+0imJxcV1/5F67KzZzmAgABd+YA=
Date: Tue, 12 Nov 2024 15:23:55 +0000
Message-ID: <31069f07-0f8d-4344-a881-cba1beb32fc3@meta.com>
References: <20241111145547.3214398-1-maharmstone@fb.com>
 <c9c316f1-3e77-4c74-9f6b-b74e39a051b2@wdc.com>
In-Reply-To: <c9c316f1-3e77-4c74-9f6b-b74e39a051b2@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|SA6PR15MB6690:EE_
x-ms-office365-filtering-correlation-id: 2f5a7164-bb21-4892-5e00-08dd032e05e0
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q012L3M5TTlvY1Bkd0VndTFJMGdEZkJyZ0Y5M2ExRnVhK3lOWUltaFdCRFJU?=
 =?utf-8?B?TXd4SERScGhrNnY5N0lrMmZFZVlpa1N3YzNZMXFzNkVaVmRUYTJJcmpaSjVV?=
 =?utf-8?B?RlYrWG9oK2cyMVpwbGZFcWdob0toeTRpSitmU3lXSEdvQWpkODFuYkdLSGto?=
 =?utf-8?B?TE9nQjRXTkc0aDJWeXZjV2dSbUFtdDVnbUF4aGNSS1BrUEdWbWZnb1h5R0Zj?=
 =?utf-8?B?NHdTZlZhSWZxamxTUnE1Ymt3SVgrUXhWdDNGZFhkUEJuRkJycWFLeGVvOVlo?=
 =?utf-8?B?eGRueVZEZFFZUTE3SURkOUdtZUw1NUdYbHJPV3hRZmZpcVp6OUJwNVBlTG14?=
 =?utf-8?B?Qmk4Z0YweG5CZDBFL2o2RmsxZG5JUEJHUEVva2ZLSm5oZTVGYWI2VE53UGtN?=
 =?utf-8?B?UjdzdFRUaWY2Sm1aRVFYVFIramZ5Q3lxWk5jb3hxOHc1UGk1M2o1NGhXM3d6?=
 =?utf-8?B?Ui8vd05OeHFyejFtZk8xV09MMGZxcnp0RHFRc1pnN0F1eVBKTk14RkRmNmZO?=
 =?utf-8?B?amkzdi9sR0h2MkUxQkN2S0V6SXFleW04Q3l2YnZzd1IxdW12bGhXZG1DS1VW?=
 =?utf-8?B?NnV5WDJjZnd4YmxSMkRSa0VGdzJYNk1uTlYvaWtveC9nbkFnRVg3aWFBbjNv?=
 =?utf-8?B?ZXgxSExxbHF1WGdjM3ZKOUMvVjNtSHFjMTlDSmJwbzNOR0tLL3JhRk5ucHBy?=
 =?utf-8?B?bzhMWllLWHVmTlFqU084dUl4bjZJZHp6aWFrcC9wKytBVHpJUnBQejRlSkZD?=
 =?utf-8?B?NWZjaDQ2aDYvSU5tYjNCeDg5VXJWRjIxZXlXQUhGN2tqV3U0OWZQQ0RqVGlG?=
 =?utf-8?B?K1lPcGtaSlA2OEVLTnhCRytORkxGQnI4SnJ1dTEvMElGV3U2VzY2SVpUR3RC?=
 =?utf-8?B?eDBPVkNTMVE5OGxydVVoamlHOGVlWXBlVE56K20vZzBFTTF0MG1aNGNtVUNp?=
 =?utf-8?B?VHpjR1ZnQWI1dXFLRFdBd1JBNWk2OHlmdkNSWjQ5cGpvZldoQnVaNnUwbEV4?=
 =?utf-8?B?elBnM0hHOWxuVVpXalhuK2EwZmxObHY4MXIrdElDVTR6RTNtZEJQd2w3RVZ5?=
 =?utf-8?B?Ny9qc2JsZzlESnQ2S3U4MEhyczUyZlVZRW1PdlZ5STc3R1RFWmFkQnJTMlJM?=
 =?utf-8?B?R3Z4aUNGcmpSZktybDdETktxMWw5dGprNmlvTm9TelVzTVJPdkc3TTFYQVQ1?=
 =?utf-8?B?R0JCcGlBL2R6Y3dCMXRqTEFQcXRoalpwaGd4cTZZZGpaVXRRSnhyUE1QUzI3?=
 =?utf-8?B?ZncvM2R6ZTA5Ky82Q3BJNm5HWGkwR0dhaTczbWhQYkxWWWNYRjZEREtaS0p0?=
 =?utf-8?B?Y0FwVThYek5odTFBRVZHQUNJQkZ2VVl0ZmZ0V1lZQVB1RnBSaHBTL1dMM0Zi?=
 =?utf-8?B?V3YxMmE1RlBacFRPaXhjQzBmak9zVUQ4cHVDTWZUTU9seDdxcXNmandSSHla?=
 =?utf-8?B?dWd1d1p5c05IbVR1dVBsUHdxSCt2WW00ZUxZNXQzUmk5WE0zNU14dU5SbVpp?=
 =?utf-8?B?MjhjVHBOZU1FKzRRZTgzWVBiQWJsUHlXVE9YbGVSWjgrVTdyOWFMVkZqWkRv?=
 =?utf-8?B?QnhoZUhaTytBNnpwdGp4aEdTNTdnakhGdE5CZFppTTdtWm9pREVvc3pUL0tQ?=
 =?utf-8?B?bXJGSEQ4eVRvRWtKbVhabkdLN05VTjBITEM1aGdFbGpzTHhZT1YzZzltSk82?=
 =?utf-8?B?UGw2YXQ0NVZBWEZNb1BaSUkzOXduSjgrME5JUHE3eTE1TXpSL2ZnUmdZK3Vt?=
 =?utf-8?B?UGdQRXQzNHhPVGhXbGl6SmJveDUrY2VGM1hqZVJpVVIrQlJiSDE4U1JtN2FU?=
 =?utf-8?Q?Z2+a/Dzl1UqdXKYbsZ/nOGuqJg2ZIWD6hlDrw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QS8weEltekNGR3FWakhlNVVDKzViSjJ0dWNUa1pxQVdVVnBKYzd2MklFdkYr?=
 =?utf-8?B?UWVnMkJzVDFnTCtXUy9sRHZ0UUR0R0VkaldDREI2L0lzV3pLY2Q2RDRkZEx2?=
 =?utf-8?B?Z2RiY0FBOGlzM0R5WUFQL1o3Uy8zQUwwN2FXdmprcXJ3dW1KOC9uRUdWeDJ0?=
 =?utf-8?B?Y3ZHM2htMWRZc04vd2VNRFlGcXJ3eWx3UnRMaks0cFdnMWVIbXlQWlRnUEJJ?=
 =?utf-8?B?cGJCRzE1Z3YxZnMrdjhIU00yMXBMdmxwWktjRWs5dVpaMStYYjUvajB2bVV1?=
 =?utf-8?B?REtGVG03SE0xYzQvYzVwWkVGVFk5Ukt4NFo5cE53blQyRThFM1dJQUpycWxu?=
 =?utf-8?B?K05IT3FMMjR4blp5V1M2NDNrcGNrVnZBcEdMcE9vUS8yMTBmSFlPNmZZY0Jj?=
 =?utf-8?B?ZEk3RGthOUNleDgvTHBOZkV6dWdvZEV2MDZyT3c0eFFWL09KNW51WW1uMFdh?=
 =?utf-8?B?RUxLdUFBeHRsbHJzK1QrZmRSVVpXaHFIM3NpTjVLcU9KTzFCRzBmUE1zM1dm?=
 =?utf-8?B?U1FpMTk0SThKMzZNd3ZQMytyZ2FIL1BmNWRGZy9uWG1JSkt3UE9GbWFkMFEr?=
 =?utf-8?B?b2E3dFdMZys5cFBKbkZWWVg4TW5QcDBhN3RuU1JtVDhtKzBQcU44UE9rZGUw?=
 =?utf-8?B?d1h3QzJLTGV2ZzRqMjhhbTNTeWVnV2Nyb1RpM05Bbko5VXlHMGUwbS94YUpy?=
 =?utf-8?B?dWNsaTRWQ1B4RUhEZTFQeW53Tm8vV25jTzVXWGYxYlBtQlpMYzFaZDcxeno2?=
 =?utf-8?B?enB3d0Q4b1RRWjNYTW4rRDFsV1ZCSjAwT2RIYld2ZFF3N1FBU0J2WUgvdHZq?=
 =?utf-8?B?T054QW8zK2NkWXFmM3NuSVUxNVZNUnIwVTJoWHFrZ1IydEJWTzhZd21tOEV1?=
 =?utf-8?B?dmJaY0lEZkRGTXgxOXJYbVJIOEwzNUNrTTUza2gyTEhnN1NlTzFLR1licmp4?=
 =?utf-8?B?RFVzQy9UZ0p3OXpVei9vVWdpNXAxR1YxMm84c2hQcXFoSDRlSWFhRkxOdWhl?=
 =?utf-8?B?MHlVQjl1ODlEUEprQURLcXlvWklDMHZGUi9VZXVZNmRmSHA5bkhady8yUWgz?=
 =?utf-8?B?VFJzZXFFZGRQZ0ZVb2tCaHB2cnFTTWdpMjRmRFJ1WHl1K2YyUFhEQktuNGZG?=
 =?utf-8?B?TDA1RURxcVpML201T2VQTmVkTDE4VEIvOHI3b3psMnVBSHRMNkprZWE2dWFv?=
 =?utf-8?B?cWJObVljakthSUZNUE5va3FXZXluSHVCNktzZk4vR0VmMkg5SXZkc1hDTk5C?=
 =?utf-8?B?SUlwNjNpRDFXVTZnK3lRam1rRTVLcDVyQ0hDaUxZbTJLQjE5elA2RC9BZWs5?=
 =?utf-8?B?b0FKNEJRRzBhMnlRc0lNNjNtU1JRa1dVZkF5U0ZpRkFYZzR0b2xMUUt2NFhB?=
 =?utf-8?B?MzNiUDFKVFJzdDMwNjVsZGtObHF2QlRJWVRGcm10RWJ3UzBLZlFLUWNMZnFj?=
 =?utf-8?B?RWJhc08yN0Z0d3FLbVJISlY4d0wwd1NZVStENnBPd0pLaC9ITjlnaVYxdFVo?=
 =?utf-8?B?cEhUQ3pCN1JiMVRvczhsTG1aeCtuYnEwaFZ5cER6QUJWb0tPRFFqS3N6WEhG?=
 =?utf-8?B?RHphTjFxblJGcmZ4MlA4eHhjc3p3YTF2Y3Jzd2JXcTZnaU8vakRZeWUxK09P?=
 =?utf-8?B?TXV1ekFNekppb2JMVmxOaWpNSmUwcDcrWnk1QzRIU1Zib1lqYjdqaDhrcHpk?=
 =?utf-8?B?aktrN2FuUEhaa0N6eDJ0VEh1UWtUaDlBb0p4U051Zjl4UlQ1Rm5pTkxkaFlU?=
 =?utf-8?B?bGQ0d1U1aXFhNWNrRnRWTHVyb3RMV1lKa3ZNK3BSOC93Uk1CRmhGOWlYY1Nq?=
 =?utf-8?B?Z0twcndDdkRZMXpHVXJQUHhtT2tFb3B5WExZNHJrVFhxcEo0UklNOGFYb1Zp?=
 =?utf-8?B?U2d3YkE3eCtjNFp5Q3AreXA0V3RHOWJnNFpTUVU4eXp5NEMzYm5QTDVVbHFj?=
 =?utf-8?B?RkhvenlIMjE2Tm05bk9JRVVhdGRSM2YvUGhFUGwwYk4rRXJOT2NlN0NPYXZP?=
 =?utf-8?B?L0UzWTZJSHpUN05vUXRmUVZJUnk4dkMxL0FyQnJvNjAvMlpaY3lXWHV3bUt1?=
 =?utf-8?B?ZUhNdXFuYkEwLzJOaDN6NHZucTkvRUs4MmxUVzVZcmx3TDRBd1NkZEtOK3dO?=
 =?utf-8?B?L1d3NW9oNUhzdU1NM0d5WksyVEpvR2UzYUhTQkl4bWM5emtRU3dacm9Fbi9j?=
 =?utf-8?Q?zStqC7K0JBOEhv2sEQqqaOk=3D?=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5a7164-bb21-4892-5e00-08dd032e05e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 15:23:55.7892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sE14TeatL1kTLdzCrM+e4wxxsgyhzE5fXMO1UCEtZHsTtPnxlyIXf7Lva8B+srWgh8mhLTgO9ugskC9dOWt7nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR15MB6690
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <DFC7300B1265FE4AAC12E96278BA3F21@namprd15.prod.outlook.com>
X-Proofpoint-ORIG-GUID: C15RLuPiiLLE5HtO44-YE1vUJURWHvth
X-Proofpoint-GUID: C15RLuPiiLLE5HtO44-YE1vUJURWHvth
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

On 12/11/24 09:47, Johannes Thumshirn wrote:
> >=20
> And another thing (sorry for spamming you)
>=20
> When running the test on for-next (HEAD =3D=3D e82c936293a) with lockdep
> enabled I get the following:
>=20
>=20
> johannes@nuc:ci$ cat ../fstests/results/btrfs/333.dmesg
> [    5.826816] run fstests btrfs/333 at 2024-11-12 09:43:20
> [    6.992664] BTRFS: device fsid c92bd0ac-9334-40e5-8c01-75a45093c706
> devid 1 transid 6 /dev/nvme1n1 (259:2) scanned by mount (659)
> [    6.994951] BTRFS info (device nvme1n1): first mount of filesystem
> c92bd0ac-9334-40e5-8c01-75a45093c706
> [    6.996139] BTRFS info (device nvme1n1): using crc32c (crc32c-intel)
> checksum algorithm
> [    6.997099] BTRFS info (device nvme1n1): using free-space-tree
> [    7.000920] BTRFS info (device nvme1n1): checking UUID tree
>=20
> [    7.465790] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> [    7.466415] WARNING: lock held when returning to user space!
> [    7.467024] 6.12.0-rc7+ #1044 Not tainted
> [    7.467470] ------------------------------------------------
> [    7.468135] btrfs_encoded_r/703 is leaving the kernel with locks
> still held!
> [    7.468955] 1 lock held by btrfs_encoded_r/703:
> [    7.469486]  #0: ffff8881163ca4e0
> (&sb->s_type->i_mutex_key#14){....}-{3:3}, at: btrfs_inode_lock+0x2a/0x70
> [   11.346356] BTRFS info (device nvme1n1): last unmount of filesystem
> c92bd0ac-9334-40e5-8c01-75a45093c706
> [   11.375284] BTRFS info (device nvme0n1): last unmount of filesystem
> 5c716421-ae86-49ee-b283-13cc4758d395
>=20
> Byte,
> 	Johannes

Thanks Johannes, I'll send a patch for this.

Mark

