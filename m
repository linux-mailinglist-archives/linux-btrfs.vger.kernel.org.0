Return-Path: <linux-btrfs+bounces-14579-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FF1AD31B5
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jun 2025 11:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34BD1887FFE
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jun 2025 09:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A762728A411;
	Tue, 10 Jun 2025 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="LjPnDZE+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DD122129B
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Jun 2025 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749547164; cv=fail; b=SKYGi6YnOeKCJjOjZkMaWOdUAqSyQofWeY8Q3tzlPhxV2UTNaUpCj3vKI/IR+lt7Kwk041Z0XXdN01W8U40AKZNC6WnEeDQHXNpGrnU2LIi4/qo/tRExoTbp79mxYBMxlNq6oSyKiZAdxGRztXL2KK7TPZotLLHA8cCchoCiotg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749547164; c=relaxed/simple;
	bh=wOHQxr13nRGNtlaOAo5dJTFmXx9OR4JkX71W3/WODmI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=JKh+sG+iCHysx13SK669c8W1QChoQGAhw06Z/d/oFXl7gxpXgsKAiOrYEs5F0XRpJjRdFScnzTkQmd2a7aLa3GbwF9qi8tveIuZRB9rQgFSsMpZoNX4FwjZ/1k1kaNlOIJafMA51oa3oedzfdC/4S1i3Ehv31ZH++wdfXBLdAgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=LjPnDZE+; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55A6xo19001445
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Jun 2025 02:19:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=JCqiOdimI+A4ih/if7JuTcXZVq1yTYNLFxCdIIIhhNM=; b=
	LjPnDZE+WpWGgDwY+vXB4F8fh4qfMIoR0V7cTekMwH0O6tEyDeudtc5c6bflcVwg
	4tGsl73Z+VC5T8RO/TH8/Nj/moyqjBVIzw8DKApi7ZFVivs5zWZR90JHc9zCQNNH
	Dw7S8vEurRuPIxq5y4fi1bK4Qgmsv1IVQ4TebxVLlC+Z9ZlOkGwpwG3KBaVh9UNZ
	RQhucdBSwudoTG2HuS7xWy8lLVFcJlsO+xAFWccvA4UM+GK1nsTUZ4PUmRuE/S+G
	VYVmrqfZC8aoFbKc7WYHMBWR1JuYXvnjV054k3xw9Mh4/MbWYhWLoeDyqJVzwj+p
	XmovDi+Kovv+XT4ivalI9w==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47655fcbsj-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Jun 2025 02:19:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Udm/uMtOEBYQrPKPwHw8QfoHFkDbUUDvWEihM0ovft49z4irSOhg99wLIiuhaSOE/lxERawqhFJIoMIpwIC9dQi+Apie3441azCvvt+j0+S+evrrpsupSIVF7+sZ/lK27HTUmb3vpPet0Qv2HKalACuE7kukfkUPdpkXCY3VQ8Pxjhke0eqXdWCmC+6HgTHmG5L7N4MvnusuxPINoQIt00csLVI3NV9y10ZE+kEEvn+VCIl+ldR21lVrZbf6/KBK+Z1g4uhONxEAO81B+SfDqCAAJ3xe03T/mFHYHv5Ag+3tWn1rG2qnIWohpDmcJ9+JDyZc919lEtijMyEq4kO0bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djKla5HsBlBF4a2iyecJ1qBBG5/W1oV7ZOrb0JbLpvE=;
 b=W0pRzZIGPdYNebcKQC45ECL6pFgafzJ+IGWHmlPl/Clccco9PpbqnKu5zb/z4u4kNKPoCR/vdcIYsKIh/IK2NR243RNtNXwG/0cP1NUM0naryFwz9JpkwNFJqHLnxa2KOsI36cZOQ4/Jg1h3AufmGYZz2DmaoD9uvN046U2l440M26wxsVsjd17HhTffFrb/2TT3KOm7wZ2jryt9Jq852lA0FHAgWzeZcYwRYMbU+1XAsGHHWvkyLzGL/GhJYTSBT8zj6g4CfGXFi2y2npvzDKKa5bEBxeEseRbC4s/thf6xZGwMpfyKB0cBM6s3PlXJVr593U6be6/3wMUzFdkPLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by SA1PR15MB4516.namprd15.prod.outlook.com (2603:10b6:806:19b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Tue, 10 Jun
 2025 09:19:18 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%5]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 09:19:18 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 00/12] btrfs: remap tree
Thread-Topic: [PATCH 00/12] btrfs: remap tree
Thread-Index: AQHb1jY9ptj9DkqFPkuHGxeXOfmKP7P7MqoAgADyZIA=
Date: Tue, 10 Jun 2025 09:19:18 +0000
Message-ID: <c347498d-2fcf-425d-8963-e6b1b5b406b6@meta.com>
References: <20250605162345.2561026-1-maharmstone@fb.com>
 <20250609185144.GZ4037@twin.jikos.cz>
In-Reply-To: <20250609185144.GZ4037@twin.jikos.cz>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|SA1PR15MB4516:EE_
x-ms-office365-filtering-correlation-id: d7505fb9-5230-4b48-0d05-08dda7ffe08b
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YmpqenQ4a2FHWlZUeHdON0hpNTBnL0dSclVxYXFjRjUyUkhDNnBxTEtibHM5?=
 =?utf-8?B?NW1JUFR2aldwUHk1Ym9xcUF2NEdKQmUyVkxWZGlVZnZiUVlGVDd1cWZ2R1JJ?=
 =?utf-8?B?QVUxMHE2L2tuMmhWMlByeTVSUlNGckxQSmxLTGhjUDJDOFhBM2w3Y0dVeVhT?=
 =?utf-8?B?NU9OWUxYYml3TENOckhKWWhyMDU3WDJFL3ZwUy9NYXVxM0hvZ2tSSVhlZk9T?=
 =?utf-8?B?Qk9CWGJXczkxbTZ2QThrSWhCcC9lMldXQ3hIcEVYS2JLN1R3R1pyTGRKK2pj?=
 =?utf-8?B?MXo1KytsTm8xOFV5M2FGL3gzMTBmWXhkT055bUVDNXpRUlFtYlRKNUVwelA3?=
 =?utf-8?B?QkRLbUlpaWNGcllYbG8wV3NyUFNIYy9xRjk3VStSVCtQS3FKNE0rbWlLUkkr?=
 =?utf-8?B?dzArdDZBMUwvakV1elNFWnU0TE9heXg4R2VrZFpSNVJTWnA1cjh0dDZYRWJ6?=
 =?utf-8?B?V0pmNHJEK2tYRUZyQ1NVZVhDMU1IOHlheXhBTXBJOTJkZXNWK2ZDeHdRdlZF?=
 =?utf-8?B?Y3B4UVprbHlWUmpnampSZ3NKaVk5azQrM05zMU9BQ0NXME0vVDdUTFI3Vm9a?=
 =?utf-8?B?Qm1adWJtR3lwcEZKSVlScUlnS0E4dzkvOHZaUmo4Rmp5WXZoYlUvblBzNlFt?=
 =?utf-8?B?SWJyNDBncHlvMnJzVWM1djkzS1A5M2wvVVl1WlhESERMN2QvVlM4QlZ4Qkdv?=
 =?utf-8?B?ZVg3Q0N5WGRhNENwWUdIU3lmOXNPL3J5REI1MjhjeVprUEdsSzJnYXFHS2Jw?=
 =?utf-8?B?MVVTOVhYV0d5elV6bFl0cVJKbENPV0c3U2o0QUlDMUFVOUJ2aVZudTZZcXcv?=
 =?utf-8?B?MjBhL1Z0eEpLRHVXYjNqWmxSTjlTR1MrMW5CQUJqYTJDRk5jcHNwSTFCdTBy?=
 =?utf-8?B?ZnlZNnNtdGZBcklMS1RiMElJYXJvWnhmcDVIU3Y3a0NiTHdQYy9VNjJCSjRq?=
 =?utf-8?B?aE0rM3RHSTZycHNWTTIxM1BNRk5sQjIyTWxwYXNVT1RDTjA0L2dzQmRNdmlY?=
 =?utf-8?B?RWdLTW1Qam5LYTN0RFRtN2R2Y21DMjlMb25wc25lSlVtclRxQk05S3N2Yk9M?=
 =?utf-8?B?ODI1d0I0Um1XcVRPVmM0Sm9FcHBjVVlONHBwUEtRZjd6UVhhVU8zL3pyL0hp?=
 =?utf-8?B?YURGbEx5UUltbHVVUHlqNFRIdjZCcU1MTnh4TCtiZnZMTFJHbXVtNGNxTkNq?=
 =?utf-8?B?Qk95bGQxZmtmaTBlQlRYRFBrOUtQeStYNys4T01LTGh3QlJsY2R3RmxXd2xV?=
 =?utf-8?B?eWg1TGd4OEVoV0p2azZZeitneUprZVZKc1VwUU15NTVmZ0FKT3o1a0xyRXVq?=
 =?utf-8?B?M1JRMlhON1JRUVRBR21sT0RCbXFsOTlwR0V1MkszYXNqaXBWdGwwNHI5R2JX?=
 =?utf-8?B?elJnTklubjlKalk2bkFRN3Q3ZWNIKzVwZHBGZFJTRjAwK2VuUTRZeUZpY0FG?=
 =?utf-8?B?UUhaOG9lQlY3T1FISEZrMUpiN2NCaVRFRENORnNZYUZHWmR6eU5UN1hSSkJm?=
 =?utf-8?B?by9wMkZXbU5FckpvVG9KeE8xV1MwYUhwM1JNNmJ1Y0FhcXN6dU1GY3dXd09y?=
 =?utf-8?B?NEJBZ21vMEF6U1VGQXRFRENrL0hHNU9oOW95ckJXbDd3RXpFK29PaCtxeWls?=
 =?utf-8?B?RTJ1bW11NndxQnhmUEdtSkZBVXRrVFVoSVdwOS9JTDUrMGdCMklJcHBDbmQ0?=
 =?utf-8?B?WEY1eTFQTEpyQkhFd1BQSkMzQVV1ZUZybWpZZG02d1dLQmQ3Wm1rWUhlcW81?=
 =?utf-8?B?Z3Zsc2srL2NuNGdFaTNTMVJZT2l1UEg5UWJJbnQwY21JQklKR1d1MzQ2N3dm?=
 =?utf-8?B?RjdHMWZLeENaY1B6b1lLR1pOOVFQcjBta0RUSGw5eEZLM2FJWVhKeWZmNlNR?=
 =?utf-8?B?VGF3QWJoK2hDTlVTQTNQNm1WaDBjcEx0TUxkRjVwM2Nqb3E1RExYNVdKWFNH?=
 =?utf-8?B?NmlhM2V0M1U4R2ZFNXZWZDMrRW9WQ0xPeDNjcjBHWlN0bEV6a2xOTUsxZmt1?=
 =?utf-8?B?bzU3ZDdHaDdBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?akJma1JrYlZSUEpTOVpQeEtrYm8rNVRMcTRBcllmSExIM3BXWEN6T2MyTnY4?=
 =?utf-8?B?a2JPSEdvNU1NNWkvdUEycUhYcDJuWkl3Mk5Eby9pNkV3bnlXVXdpTGlHeHJM?=
 =?utf-8?B?YlJWUDhjUFNqSzdrMkMrcGZCQzZENlhQQ0hJYXBOUWMvWDJCcWMrM3dFYTlZ?=
 =?utf-8?B?MnltWjBCU3lPd1NoNThjSktSN3g1cUZVQk1DYytKeFhobDJKSTNqNHFhNkd0?=
 =?utf-8?B?TzZhU1hENVBSY1dtcjJyQjd6NFhXWVBnZG1jT0FYbUVxNkcwc2ppNzc3VVBl?=
 =?utf-8?B?ZGJxczN2SHRRNFk1ZHZmN095Ym5sT2pzQzRZak1TZWhTem1GSzRqdkNCWG5H?=
 =?utf-8?B?d0Fpb2llbk91SHlXcnZUWE9qOVI4NU5MRTlJcTh1ckFDR2FsdGw5N3U0ZVlZ?=
 =?utf-8?B?RlFGM1h3RDFwcE5SSFVPNFhxaUdsamtDVisvYnpSTjlVVjh0dFIrNUxjZnN3?=
 =?utf-8?B?WTVJZVBQNWdaby9mbElqdTVteVE0WFpDMGk3UG5TT01UalFURTBnOUlpVXpK?=
 =?utf-8?B?V1JKOVNoTFV5MzJNdHlDMjdiVC8xUFF5UkZwcWpoNVVSMU8wa0NDKzVQcHVk?=
 =?utf-8?B?Q3FBdk5FQVNNZDhPMWF6eGY3TzcxK0ZxU0dNcHBDM3V6bk05Zm9ROGgrYzcv?=
 =?utf-8?B?WlovYWd1djQ4VWUrQU14SmpPYnh2emNQNlFObm9GVU1KY3l2VEpFMXlPWUl2?=
 =?utf-8?B?ZXl4bTd6LzF1RGtJZThHRjYxYXcyNS9Uckt2ZFRiOGZpd2dlcXNKVWdaQ1Zn?=
 =?utf-8?B?Z29aV2V1b1lJekJFTGM2VU1Obk1pWlZHSHhzaFV6RDAvMThKOTRjZTdNZ1ly?=
 =?utf-8?B?bTJnVnA1R08rajhiNHlzUnRjMlVtZTUya1ZhcnNCbTVlOXdLSVVkMnpvL1hI?=
 =?utf-8?B?SzRBSDNlYk9VMFdBcy9NSmJ0Rk94RFc4NkZoOHZac25nVEVqRkd6TlJKTzdj?=
 =?utf-8?B?WHcrR0RaazJQak1CTDRyZlVWUjl5N21BZWxiZFJGek14NkI4M3RnalBlVmZW?=
 =?utf-8?B?S2M3ck9oR2ZlVzZVSXg5U3c5OFRtWWZLdVlSY29EUW4zclY3ZXBJRUZ0RjJX?=
 =?utf-8?B?K0hOVkFPcnBUdjZ2UDE2VWswcXFWcUZUYXZZbHNJMXkyQy8xRVdHaXpLOVdq?=
 =?utf-8?B?eTcwTEEyZHRRNm1YQnJGY09yRnZSRXhibnpWdWg5d3hRTUs5bE4vUjdZY1dJ?=
 =?utf-8?B?NGFyYmJzWGZqamVNWWFicko4a2trQmswSUJpb2N2ZjlpRWZybHdSakswak4x?=
 =?utf-8?B?cmpMeE01VHd5dEFBMlBTU2lxY2g5Yzg1b3JpSEZCT2dkZGlFV3pvaUE2TFFx?=
 =?utf-8?B?UHJXVkMzL29QemJQYTBpWFVnZUlMbVJIdmkzd1RGNXBVRncvNFdDME1ic3hF?=
 =?utf-8?B?OEdhcXlaVE1aTmVyQmdoRmpEY3ZxOEdFakVoZWgzcDIzMmRpL3FGYnVTSU1U?=
 =?utf-8?B?QmpQRGRKR0VEQnM3cGM0TDAvNDYyQitRWTVMZ3VBUjVudW5WNWk0NmZLdGRR?=
 =?utf-8?B?R3VGaXdWOVkzOVJMQlJRUEJlakFUVGdxSTFveFZVWkRZeTY3WjUra1hQUnc1?=
 =?utf-8?B?REFoQUNjdXRoNGl5UUt3OXpNTTR5SmIwSENRbHJuQVRiZXNJUzNkdVN0MG1t?=
 =?utf-8?B?SmxPbFdtY3NuaWNQVWx4a2Q2dXpRWm4zWTZvaVdnWit4WUN3UHZDaDdRanVP?=
 =?utf-8?B?R0Z3ZmhVb0l3elB2U3FKaWFPMGtHNHFNYUVDYmgxU1I4dllpRlVoc0k2dkZM?=
 =?utf-8?B?VnlzUmxQam1rRFA1azBhVWxzcVZ1KzhxelVpV3pKZDRieGNlZ1pVa3hBblpz?=
 =?utf-8?B?NVIzU2FYVVZ6ZlU2alQ5aG5udHI1R1BSSkV5Z1VQcW5XZ1BNRXF5eFN2UDVp?=
 =?utf-8?B?c2dncFFBR3ZLOVRkN1dCM3YzOE80Qy9ZUUpSdVV5dDhMbVd5VWpPMTdLR25k?=
 =?utf-8?B?clBhMzVkVUlwT2J4cnVKT0dyOGc1dzJZRVVrR3dWdjRyV3cxS3hqUUVjUWtG?=
 =?utf-8?B?MEZLL0tzRFZldVBLMCtnSGN1RjhJYmNHNmdqZC9PMndMZCs2S1hSRDVJd3h3?=
 =?utf-8?B?UmNtcVlsMVR6WU5CQk40WkF1b2lCTDQ0c09jcmNnTW55QW1mVmtvak9EbjU1?=
 =?utf-8?Q?Z8kk=3D?=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7505fb9-5230-4b48-0d05-08dda7ffe08b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2025 09:19:18.1716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: utWKq3vjL5pRKwJcKhSKJC70OjFx2GabmKygILX3v/jvLAWq5CqNjf98sDpHbNgGCqHmH2tnUYQ4R9eKkdk92A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4516
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <BCC3D11A2F77F242B5AA8345F9B870F0@namprd15.prod.outlook.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDA3MSBTYWx0ZWRfX07fnxwnomXy6 826V3JbYTFdkitxrD/TzFBMVUmGNOcR9EdtFEZEEURotFoHD4Kz72ARq9Adc0RoAHR3T/yh+jgL 6n6c3sloB4lW4kcss7LWjZTvAvoLfpHFFF2UaokiSnmMGx4OnLMPJIoIdqLibexLQd7jiL+eWbA
 MrbSAmZlkGNs/w3jm4MJyk24mrcr/WGGJOIi4atBJXeYkKzStJL5s4+O3z0RWh2F3EeH2KvJe8P p6mhOsdQgvd8megWfkFPTsgyjx19ps6kHvOljW0Guih3rVi2LRr0UX1EMMmTtTqwEG5X+ki44lX 3X+wUt7Cg4Q2ndCRuLThbd7UBqMzmOrB2jVwXH5SBtozW5EW1F8giY8qFFoGiGkN5VdlF4K4T9l
 SbUOdQMrwt0vsKBaRTpgEvKPApqjbVbDi4rHN6T6yURRI09r3iWmhBuJ2D1d3S6hVyshQLql
X-Authority-Analysis: v=2.4 cv=XNUwSRhE c=1 sm=1 tr=0 ts=6847f899 cx=c_pps a=fuPBXZG3M7Sc+qedpsXBqw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=VwiJK5UArv0d6jTE0K8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: dG8s0ywu2Gbv3fFpc9ZWeEMRfM0XKzts
X-Proofpoint-GUID: dG8s0ywu2Gbv3fFpc9ZWeEMRfM0XKzts
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_03,2025-06-09_02,2025-03-28_01

On 9/6/25 19:51, David Sterba wrote:
> >=20
> On Thu, Jun 05, 2025 at 05:23:30PM +0100, Mark Harmstone wrote:
>> * The remap tree doesn't have metadata items in the extent tree (thanks =
to Josef
>>    for the suggestion). This was to work around some corruption that del=
ayed refs
>>    were causing, but it also fits it with our future plans of removing a=
ll
>>    metadata items for COW-only trees, reducing write amplification.
>=20
>>    A knock-on effect of this is that I've had to disable balancing of th=
e remap
>>    chunk itself.
>=20
> Not relocatable at all? How will the shrink or device deletion work,
> this uses relocation to move the chunks.

I know, it won't. At the moment this is more-or-less limited to=20
single-volume devices that you don't shrink.

This is something I'm going to address with a future patch before this=20
leaves experimental. It won't require any more format changes, it's just=20
that this bit is tricky to get right.

>=20
>>    This is because we can no longer walk the extent tree, and will
>>    have to walk the remap tree instead. When we remove the COW-only meta=
data
>>    items, we will also have to do this for the chunk and root trees, as
>>    bootstrapping means they can't be remapped.


