Return-Path: <linux-btrfs+bounces-9592-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8FC9C6F33
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 13:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A00C0B24AA1
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 12:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35468200B9B;
	Wed, 13 Nov 2024 12:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="RP8USBLo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846A41FEFD1;
	Wed, 13 Nov 2024 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731500920; cv=fail; b=Enu+tl1zECw3lmg3svE6FjTfIjsMJNtrTo0VeB4h0Ka60fd9nNx8zVInKLOaexGjqtTuRsVtW1tc34eWPLmrpdlXvqSzyF+R40lJGKCfizZkbsqkVIUjzGao5KhmPjDyVUZzUen4NIgMFoYPgKLhDGPPtl/K9E135LEmO0XGjC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731500920; c=relaxed/simple;
	bh=N+TFgKV4HaY2rnmbBNcK42TavTZRmf2/S9cqxDXF7Xk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=O4M3vPI1bfG32olHQhcf4Zf1exQlzeBUzwcMuxmSj0WUn1nUl/kIJZmLFKi0Wk5K9iZWG8h2q11jhs9FZWduD5FIjuIIzCPfvJ6938CoHJyGcDuFZ0EvMHNfhbS7Yw79uvUlMArVQBcDFUyQe8/5jT9CtosHoFq6tWS7KwcuT5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=RP8USBLo; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4AD7pevl012269;
	Wed, 13 Nov 2024 04:28:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=72ymGbvhnWKJUEWLSBUyy9JTUsVVIIseyT686TLNljU=; b=
	RP8USBLoBOMxebH9X7ylSaK83AE5xKYMPEDs1MKavTflubFU5YekHnFSXSF4M4TG
	GAjyiANur/HJ8HSTABizk206/pD3WxYXISSaIMTOVqBOYX4P2GacXp9dfmuRI8jX
	jcBh5qQfocPfx8oxoJsY8C1zjC7cpb462Zn2YUTGlJgVKJ2HWXNogeJA6/rdovG/
	cAP/GZCu/R04DTOvknWgp+QJ/rgoCDLDfw9hX/JFXxS9wucx6DYI3EHgCQvwaqx5
	EJx206Enwl6Leu9gDJqkSqTeI8wrQQ7ChBmNp89VlFwOH6M1+aUyd4vGfGnklo65
	hbB8TYOM4c/l5MOyE9etXQ==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
	by m0001303.ppops.net (PPS) with ESMTPS id 42vr3j98mk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 04:28:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6rr6GcRL5L9NbXmHsCuH7rynU7JFPXwTw5LVGiJwzQO3OxV1ScZxrCNbEgygdCqcbZN+PZfVdqh1qA67kXJI7u6D+9Xy1Ig7CE+qdPMRzREKc6nyyEj3gqhiPhpwXSUzIKB9X6dFE5sDSjMC021C1ZaU9iHoSJSv1nUyr1LHi/zYg9FAlq3jWtP9yw/hF1mtj2fsJk+0ZhQThzgQ6vc5TUB0Fg5PapwinlYV1vPToBb9azzHVi0eGjiy3Jj7N0lxkH5VCBy5vzfjA+YZqN7VXpekLFvoKAM9+x2fUJS+0AHBfPWARvlTb70jt1q15xEyzbbLFlWT8WiKNbUcJQ1zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCfLyLX6bcGveK51x26uU41a5JSaIDvU3yjswGFPf5s=;
 b=Gkoc5a0yjSVnIfQdKeOaRon4L2pQ27ubgeRWTyDmSPFI1fFjFH3VFPKZDh624F/Z1pJZZip0U0uc1mrCzOKPiYXHtNAHmS0/J4H9JysQ9ahzx9aqPz55AJRKlv8r0E9FWrVJ+P8su/3IUFSmzdWuZtLFk9/XQzEhIV6ddULmEZmIqZFi88hrawaR1L87nR2xCZHxxx9CfnssvCFUxIz47BCl2iVgVkFMrrnEiz+QKwWSCKigGGrsM6to3Dyv1un696C8ouNok6Bo3ourE1sZ47A49UZcGnggBc6ReU+kBKAYuaOpx9MDwuD5WiRkYpmCigHIyqaZnIyHukUdA4IuaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by PH7PR15MB5716.namprd15.prod.outlook.com (2603:10b6:510:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.33; Wed, 13 Nov
 2024 12:28:33 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%4]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 12:28:33 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Mark Harmstone
	<maharmstone@meta.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "zlang@kernel.org" <zlang@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: add test for encoded reads
Thread-Topic: [PATCH] btrfs: add test for encoded reads
Thread-Index: AQHbNEnT1dyQ3VMT+0imJxcV1/5F67KzZGmAgAHCHQA=
Date: Wed, 13 Nov 2024 12:28:33 +0000
Message-ID: <28c2834b-3223-4191-bb10-81ce53c010a1@meta.com>
References: <20241111145547.3214398-1-maharmstone@fb.com>
 <bf3e4e63-6496-46f9-972c-c0b5c7c4de39@wdc.com>
In-Reply-To: <bf3e4e63-6496-46f9-972c-c0b5c7c4de39@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|PH7PR15MB5716:EE_
x-ms-office365-filtering-correlation-id: f71a258a-70d5-427a-b643-08dd03deb048
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QlJtQVhMdkpWNXRkOEMzeGpUSW9xdFNUQnFqS05BYjdCeWdXZVltc3ZxaE1U?=
 =?utf-8?B?OTlxbVRoT3dNeTB0Syt6UEtWWEFPL05Yek9GSHVzaFM3Nm9lWktXSENGTU94?=
 =?utf-8?B?L0RNU2owMVNZdk90dG1YSGFJMnB3eExBQUIyK0NSNWJiNGVheXF4eVg5enQy?=
 =?utf-8?B?ZnJWaXpsalphcGNEVktGL1BsOXpIMFJsYUFyQTFOSUNFVVdLOVBuc0xCWWpw?=
 =?utf-8?B?akRxVGM2UnN2R0oyRElFRVpReHZxeVJIMXJWSyttNDRRVFhSSVQ3OEJocXJm?=
 =?utf-8?B?VWlEODYwaWxOVUdhMTA1cHlhR3JuTG1FL04xWndvU00xUllSbzUyKy8wNHJy?=
 =?utf-8?B?Y3dLd0doQ1ZmNUptL1FOdFE1TTdKWnQwUzJvMUlhOElhYS9nN0ZmQ0xZVDNz?=
 =?utf-8?B?aitlNlZ2Nm5abG5rMnV6NnA5bURUVGRuQ2NXemltTjhhek9iSHVLWmRNYVBw?=
 =?utf-8?B?bTVvRUVLZzFEbnJaOXpqUlh2aWd6NzcrMGxHbEJSZVhWYmdCVWRNWElENlYy?=
 =?utf-8?B?Sld1dWhTNG9GU2pjUzR3aWhwUzNKU0ttTDR3dzNRcXNIa0YzTjFQN2I2UmJ4?=
 =?utf-8?B?K0tiU21lNDRoWmVCRFJBL1hxMVNrV2xvN2plMFFRbjFYcGh5cmRabERTTlU4?=
 =?utf-8?B?bkloYzJnaGxTUmNRN3VBTzhzOW5kU2RTUU9TRDloUko3bVRIRjl0OVl5ZHJI?=
 =?utf-8?B?R2pwVTdsSkJsM2pxMUhjTHU4MWYwZU9SNisweXBKa29uY0lvbCtHckRxYzgy?=
 =?utf-8?B?VERVQlNxM0dPbzVzT2xEVTg1RUJPczdGY1l6eFNpeWpEMXloblpmcWpnTnNS?=
 =?utf-8?B?aVp2b3ltTkVaRjFna0l0SDUybCtWa1hvOEs0M01PM1JSSGxoWWpBK2F1NjVh?=
 =?utf-8?B?cDNGcnF2R2xjTmhnOWNKZEJZT3UvYjltekwyS2pINWpoS0ZIVjREbjVLeXdN?=
 =?utf-8?B?M2FsRnZ0emJpS2JHTTYrRUJpaGMzMmJFdndMWlZhZUJMOEd6L3BUbWJnRU9O?=
 =?utf-8?B?dXZONnZ1M2xJV1Q2SUtLdXVMd215dnU5K0pydWVnbWx6c2J2ekFnWVExbzIr?=
 =?utf-8?B?MlF3RExReHA1QjRoZy8yeHpkYVNIWmdEelB5ZkZkc3dCbDljWkpyMGJFRlU4?=
 =?utf-8?B?MktMZyszZXVsTEoxZmlsRFZKN01pR01uM0RTa09jYUw5QkNjem5rNmI1Ulpm?=
 =?utf-8?B?TDUxRnNnL3IxUjh4RG4yeVFtUjZRQ2UvWUJkMjFqR0hoQVlzR09FWWs4VGlM?=
 =?utf-8?B?WE9PK0c1VEZXQnd0R3NhcCtncFJhMHVmcDdLZGNYRWdSM0g1cThvMHdVdTRr?=
 =?utf-8?B?clhmM2JvUS9CRzdYU0ZkRXZpeGJJcmpiSnc4ZGo2aXdVSGJUczJPdzBvRSti?=
 =?utf-8?B?RTArZ29mNG1TbjZUTmR5TmlWM2F5QTN0VVprV2JPdVMwenNETm5LWXU3c0lR?=
 =?utf-8?B?SlZ2aHRDNVloaVk4WlZFREFMa2s2clFyNWcyd0V0T2dNMU9wMFI4eUxHTU1S?=
 =?utf-8?B?RWNJaFFOdnB0SzhMbk54QnJFTVhEam16cTVkZmlKNWFFcEFLclovdk5SeUhI?=
 =?utf-8?B?QmtacEQ5VjJGL0JTL2crbnI4VWpFNEFITEJOcDgvcVYvMktFTkkxTVBucFJY?=
 =?utf-8?B?VkpxSnU2NDRuemFVZktTb3ptRnJ1dW1jdEQ1NjBkQzAwazBkUDJVNklIeVBT?=
 =?utf-8?B?cStLdW83ZVFpNUFXSEtuMlcrc1BRVWxLWk1OaHhsT0xwTHVFR2RralpEeGkz?=
 =?utf-8?B?RWtmbkFlTEwzZkxWNlRxWHdSNGlRSXdBbTU1bXB3ZjFINGc2d28zcFZhOUlH?=
 =?utf-8?Q?IMt6sWGqwF0i4Yh6lo0706sjdaJxfG36rph3E=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MlhHRTlvZDI0eVk2aHBYNTVZOTBaVDA2UFUyNkRMMFExNXlnMWFtQUxjdFZM?=
 =?utf-8?B?Y0lzQmwrbmxiTHE2SjFwT2p2SFJ1R2JyNzFlTnpQdUZBSmhBOG5BVENWRHBP?=
 =?utf-8?B?TWl0U2Q4K2JTSFFmeW1VbHNPd1k0U3FPemhING1XU0w4RUtFaklFT25kV1RH?=
 =?utf-8?B?WFFzOUJHQVlORVFZVEFUcU5kd0lhOUZTU3VCOGdoT0plSlBUVDFma1ZiZkRC?=
 =?utf-8?B?bDE3d1ZuVVJuTW5tVkR5WDkwUGZkYkMwbmtOaWZuWm5ta0hVa3ZWTi9vQkgx?=
 =?utf-8?B?VW5XTUE5d1lvam1obm40YkVrWExRTnd3TW8vNHdSQVMxODRuSUNHR1QybnBS?=
 =?utf-8?B?Y0JzM3UyWGlvdzZ2ditFcWhyRXBFam05c0lVdUhkOHh5RTNQR3lUenNNR3Bk?=
 =?utf-8?B?UkdyMmVMdkpXTzBYbUxLMFpLZ1o0SWd2RlJnOVpNVEk2cnNsNUF2ODNlUzF3?=
 =?utf-8?B?cDFSSkdnQ3kvZXhHYTZwTzkvajg0bWExZzk4TXhjU0hYeWd1aUlmc0Z0NHpG?=
 =?utf-8?B?TzE4T2RqWFA0ZHovVWpPMERHb25Ld0FqeHRFMnBHcXQxMTFuajVRT3d4L0pM?=
 =?utf-8?B?UTFNdGhnUkV6T0hQbTFTMVcyd3VqK1MzaFJIUmhzdi9JbmV6eHdweDg4Ni9v?=
 =?utf-8?B?SUFWZEtiN0cyK09GTnBveXNRZ3BxRm5XUWl0QXNhQmNZQWxBaHQycmwvdjY4?=
 =?utf-8?B?aS9rb3E2QzJodkQxQ09leXhUTGp5RU8rSWIyem5Jc29ZOXROTzFndkhHOG1k?=
 =?utf-8?B?MituU1lJajVPQWJuUzhZMzZSTVVvbk1qZFk3RXEvamkzaCtsUWhqdndrWFo5?=
 =?utf-8?B?dDV1Yml1VHB0NnhXUGpTMW1UTmlCVWxsdXlqb1krUzZSWENXR3hSa1NqQ2Uy?=
 =?utf-8?B?YlFneURwRGMyK2FrMWt0dEgxOEt4bXY1L3pxSmhXc0hKQ3RybUpoYnZHbU5P?=
 =?utf-8?B?SFdiLytoUFZmMEVRY2oreGdlNmtZdzNFZjQzaCs2c1NGWTY2UW1wRkVCSUt1?=
 =?utf-8?B?VjdEeHJINjJmS3ZUQ2NseUgxaDdaclFWYlpOSFBsTUNldHhqZDBBeWNuT0Yv?=
 =?utf-8?B?TFlRdm9CS3Z2WGNrSGpjUHZJRndaNXZmbEdFT1VjZlJBSGY5Q29kUkVMRXlk?=
 =?utf-8?B?UjI1Ymd3YmdNM1o1Y2laUlluYTBRb0Q5M05ocERNSG43VUkxRDNSZ1JXbXVL?=
 =?utf-8?B?b2lrTklvRWFQUE9GNlA1ZTJRSnY3K0ZJdjlUTDJWY05ZVEszaDRxZjVnNjZx?=
 =?utf-8?B?ZEFsQjNPQjIxN0Q1SUdMKzdNOXF2LzVxMjhwckJIN1d4blRJaDlDQ1lMTjUz?=
 =?utf-8?B?Nm1UR1kvR2VDSi9NdCtWa3MvQ1FEMGVRYUhBWlRPaDZvMGtqaEpwM0dlT0s0?=
 =?utf-8?B?UUJ3YUZsekRsUFJCeTBlR3lRRmdEdGg0anFiQzNOdFN2S2NjTEd3YndRZWZY?=
 =?utf-8?B?N1ZZSFhYVytUanpFMmQ0ZmdMTk9JSWFoUGY1RDZWKzNJZFpoSFdubzFmTXVn?=
 =?utf-8?B?YS9HNTZ0VXIwNHRRa2Z5dDZrS3RJWHpYdVJ6YWdvdmpaVGJKWW9CNTdWTklK?=
 =?utf-8?B?WVYxdlNwOFg1cVVvbmo4WkJUZXkwaldpbEladGhTK0ZzMlBCdDAyVGFTNFVn?=
 =?utf-8?B?cGdrM3FwMzVMUVZFOVRSQmVEeEIwcm9PdTdEVlE3Si9MYi90VU1JNFdXU3Nu?=
 =?utf-8?B?elk5ZGlDOFNBbUtpSVp2RVErWUIwTzRTcmc1VndxS2hwaG0zYnJZSi9EUE41?=
 =?utf-8?B?MGE0TUVnK09xdWRZdkJYM3NITVp3MFVTbHBXcHp5cmxSdXV5T0FwK1pWbWFl?=
 =?utf-8?B?bHBKckpFTXVQeVRPeXdiT3Zwdzd0YTRIQ1Fjaldpb2NRTmNPMXVGK2VIOTlU?=
 =?utf-8?B?U2RzM2E3bTRMUTNaWnA0QzJELzR0dUNORjZoOC94NkVMV2NaNXVKbTU3WmpR?=
 =?utf-8?B?aGs2V3h3S1ZxUmlLUlROUlJhMWVjbnJtbWlGMUZobzdFQjlDTDJGOStRelNE?=
 =?utf-8?B?SFBib0pySFdWWkk1MThBeEwzVzBEWW1EWCs5clVLdytwb3QvZW9GdU1pQlJq?=
 =?utf-8?B?bThycTBZdFowQ1ZjV1JOS0tzM0hiUEYrRHZYWEU1K3NtZDhCYXp2T25id2N3?=
 =?utf-8?B?V21PWEY4UWYrWkZqTHlvQ3pWZEFSWUhCNEpkVWREMHZNK2ZBMHJiVVJXWHZX?=
 =?utf-8?Q?pHJPuks+jPsuoI63p7k9U9k=3D?=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f71a258a-70d5-427a-b643-08dd03deb048
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 12:28:33.1515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +3E9mB2250goR6jjD7Y0+TNACN/D6mA4Y1XXdYMM6IqwtdXshb+YfCdNcWxoqIXpSvf7GN35Ss8Tc+QDpTANJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5716
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <D68B00B88A52324AAB3C9CFE0968404F@namprd15.prod.outlook.com>
X-Proofpoint-GUID: QckGlqDF4HbdZwA-Vn-uWmEssM3uAUTz
X-Proofpoint-ORIG-GUID: QckGlqDF4HbdZwA-Vn-uWmEssM3uAUTz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

On 12/11/24 09:37, Johannes Thumshirn wrote:
> >=20
> On 11.11.24 15:56, Mark Harmstone wrote:
>> Add btrfs/333 and its helper programs btrfs_encoded_read and
>> btrfs_encoded_write, in order to test encoded reads.
>>
>> We use the BTRFS_IOC_ENCODED_WRITE ioctl to write random data into a
>> compressed extent, then use the BTRFS_IOC_ENCODED_READ ioctl to check
>> that it matches what we've written. If the new io_uring interface for
>> encoded reads is supported, we also check that that matches the ioctl.
>>
>> Note that what we write isn't valid compressed data, so any non-encoded
>> reads on these files will fail.
>>
>> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
>> ---
>>    .gitignore                |   2 +
>>    src/Makefile              |   3 +-
>>    src/btrfs_encoded_read.c  | 175 ++++++++++++++++++++++++++++++
>>    src/btrfs_encoded_write.c | 206 +++++++++++++++++++++++++++++++++++
>>    tests/btrfs/333           | 220 ++++++++++++++++++++++++++++++++++++++
>>    tests/btrfs/333.out       |   2 +
>>    6 files changed, 607 insertions(+), 1 deletion(-)
>>    create mode 100644 src/btrfs_encoded_read.c
>>    create mode 100644 src/btrfs_encoded_write.c
>>    create mode 100755 tests/btrfs/333
>>    create mode 100644 tests/btrfs/333.out
>>
>> diff --git a/.gitignore b/.gitignore
>> index f16173d9..efd47773 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -62,6 +62,8 @@ tags
>>    /src/attr_replace_test
>>    /src/attr-list-by-handle-cursor-test
>>    /src/bstat
>> +/src/btrfs_encoded_read
>> +/src/btrfs_encoded_write
>>    /src/bulkstat_null_ocount
>>    /src/bulkstat_unlink_test
>>    /src/bulkstat_unlink_test_modified
>> diff --git a/src/Makefile b/src/Makefile
>> index a0396332..b42b8147 100644
>> --- a/src/Makefile
>> +++ b/src/Makefile
>> @@ -34,7 +34,8 @@ LINUX_TARGETS =3D xfsctl bstat t_mtab getdevicesize pr=
eallo_rw_pattern_reader \
>>    	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
>>    	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
>>    	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
>> -	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault min_dio_alignment
>> +	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault min_dio_alignment=
 \
>> +	btrfs_encoded_read btrfs_encoded_write
>>   =20
>>    EXTRA_EXECS =3D dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
>>    	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
>> diff --git a/src/btrfs_encoded_read.c b/src/btrfs_encoded_read.c
>> new file mode 100644
>> index 00000000..a5082f70
>> --- /dev/null
>> +++ b/src/btrfs_encoded_read.c
>> @@ -0,0 +1,175 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) Meta Platforms, Inc. and affiliates.
>> +
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <errno.h>
>> +#include <fcntl.h>
>> +#include <unistd.h>
>> +#include <sys/uio.h>
>> +#include <sys/ioctl.h>
>> +#include <linux/btrfs.h>
>=20
> For this I need
>=20
> +#include <linux/io_uring.h>
>=20
> otherwise I get:
>=20
>       [CC]    btrfs_encoded_read
> /bin/sh ../libtool --quiet --tag=3DCC --mode=3Dlink /usr/bin/gcc-13
> btrfs_encoded_read.c -o btrfs_encoded_read -g -O2 -g -O2 -DDEBUG
> -I../include -DVERSION=3D\"1.1.1\" -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64
> -funsigned-char -fno-strict-aliasing -Wall -DHAVE_FALLOCATE
> -DNEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE   -lhandle -lacl -lpthread -lrt
> -luuid -lgdbm_compat -lgdbm -laio
>    -luring   ../lib/libtest.la
> btrfs_encoded_read.c: In function 'encoded_read_io_uring':
> btrfs_encoded_read.c:100:26: error: 'IORING_OP_URING_CMD' undeclared
> (first use in this function); did you mean 'IORING_OP_LINKAT'?
>     100 |         io_uring_prep_rw(IORING_OP_URING_CMD, sqe, fd, &enc,
> sizeof(enc), 0);
>         |                          ^~~~~~~~~~~~~~~~~~~
>         |                          IORING_OP_LINKAT
> btrfs_encoded_read.c:100:26: note: each undeclared identifier is
> reported only once for each function it appears in
> btrfs_encoded_read.c:101:12: error: 'struct io_uring_sqe' has no member
> named 'cmd_op'
>     101 |         sqe->cmd_op =3D BTRFS_IOC_ENCODED_READ;
>         |            ^~
>=20
> during compilation.
>=20
> Not sure if a ./configure macro thingy should/would solve this.

We could do that, but elsewhere we're using liburing.h rather than the=20
kernel version.

It looks like IORING_OP_URING_CMD was added to liburing with version=20
2.2, which came out in June 2022. I don't know whether that's old enough=20
that we can just declare it as our minimum version, whether we should be=20
probing for the liburing version, whether we should be working round=20
this somehow, or what.

Zorro, what do you think?

Mark

