Return-Path: <linux-btrfs+bounces-11153-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A65CA220FE
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 16:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E36271655AD
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 15:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8532A1DE4FE;
	Wed, 29 Jan 2025 15:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="nIYHjZQP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E698B1DE8B9;
	Wed, 29 Jan 2025 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738166139; cv=fail; b=ntqE3n2hxd591SEiv0YvWHpelJ+PVbeOvgm8TmmyA8YcPw7n+8ybt8GESEKjN6rTb+hHr+JcQ+dyZ9cuiFgRJN4VsB2sfHdaamUUx44jBgTRG/aLI7MJHQMQPXDDbs53dxZF3rP8cigpwAophznQZ4Oy9CrbowX6gmSoR+Sc8k4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738166139; c=relaxed/simple;
	bh=r+oKeNYyTXfpo5U05ewgGVMlwxCTb8CQubsJXBpn3lM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=lyBEXMDSvWByXFsfBmTi/NBtCu95tfju8joA6TT7z93cVJBLluX+qQ+xTRhXt+lkFwTOvx/QAzlW/br5jKIsilUjt+o5o6Tpc64L/raEYK8yC5RNbh2vrFZM97Vog+53cSE/dntcWpkiQYgk50KaVBkRnTcljegAN9EK+PKl++I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=nIYHjZQP; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TEmYk4027556;
	Wed, 29 Jan 2025 07:55:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=37B67IiZJF+IesyRnTZoOrqPeL2HLXha6Yz8RM+cmJk=; b=
	nIYHjZQPe7IzIHNGKRLE8aciykdUVUCJTgrSfbHGrx11olUpK+6vXYkWnZg1HIVt
	hI7ia5SPBSu1ifHv9xrJ9ip+yqm9gpoNtGj/8KAeDYA5yMQafr6W95/26mQ3xAhe
	7bbDFhZfp2uQ2/H0a+CRYw+VA4i+D9wa2NywLzyQZ6VuzwE3DcwuuLDn/rRsFLYD
	JGYaPeJMxgyHHZz7HAZoHrTByfLt2/Xs/YalnRZr5XyCzmtZDxrkupjdUoMKnpi8
	P5UVnwmq3LZTN/BTiVc0GF3BpGedxRNMI9pSwNzw4A4BXAPIBMxUkeVVcJTqXCTu
	eQyNaszsF9qRditdKK+qKQ==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 44fpdtrghs-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 07:55:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7H4f2VbYlVv4meSLfRX1bHeA+Mo58DBaXMiQW9U9NBSNgXGHCLkDOvrF+9L9yXnZbDL4aXP/lX092ZI1ekte9/yb4W1jZvoW3cQDFmVGh3mDCaAo7S7EZCebvAlg+hbBEge4WpyIWArMZohFXvmR0GVMOxs8CQLiN7hSc8FqAgW/Qf9pHVK2coM6HCqs4Rce6JDEf8+pquxvzuyY7GNCoUAn3ERY0xV+TQyJ4wTLH+sLbFgwmDDME993aV2iLLa0E1wX5McfWhnrNqr7jKCrwtZnm4AYdApLaSCmSM6W/vvSsc9i0dV/V1sXKOS3xUV87Qc9CfxLzdq32/LlJ5+PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6rOXBgEi/vMGeCztAzjiRp+ppS81eKbAh8xEmKjnBo=;
 b=AwFcVyce97RrjaqCAQYNHgj3bKiqf4rSot7hiaOvIz+4ulhj6d4l6+WXB3BFuphZG7pY4D9e8h3YQg86HHoe6jQIWwDUmhrVYDbFSlQw3cz8TWCuuMBmV/wDpEH1L7wWm4uKL7RJEcXALciT8Xwg5mRYj9wyHUVkqz4mPtKNpkcsyFSGDThVecVuciEyVal0FkRi+N0ID2HVL5MjoW7E2hZOrK4Pt47GgE1H85pXlTNHgCnThg7BjH9pwVxQ/UMh2pv7ZhIQTov2iSV8VVkR71dL5JHx/SpiqtDnsVHF1c3N6TLUrMqSJTUScNx1vD7u9Hwek1Az4XmmBZNUsIIGYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by DM4PR15MB5613.namprd15.prod.outlook.com (2603:10b6:8:10a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Wed, 29 Jan
 2025 15:55:33 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%5]) with mapi id 15.20.8398.017; Wed, 29 Jan 2025
 15:55:33 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: Kanchan Joshi <joshi.k@samsung.com>,
        "josef@toxicpanda.com"
	<josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>, Chris Mason
	<clm@meta.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "kbusch@kernel.org"
	<kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [RFC 0/3] Btrfs checksum offload
Thread-Topic: [RFC 0/3] Btrfs checksum offload
Thread-Index: AQHbclgedhpqBicDREm/WSLmQC+SvbMt58MA
Date: Wed, 29 Jan 2025 15:55:33 +0000
Message-ID: <cdc17997-cb43-4254-a90a-b010fc6c9f5a@meta.com>
References:
 <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com>
 <20250129140207.22718-1-joshi.k@samsung.com>
In-Reply-To: <20250129140207.22718-1-joshi.k@samsung.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|DM4PR15MB5613:EE_
x-ms-office365-filtering-correlation-id: 6c477a17-4555-418a-7c69-08dd407d5d51
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cGpwTytGM2xtakFGdnUvRzhBYkQ0Ly9GSWRuNFVYMWJ4cGNZOUM4YmQ5TUdD?=
 =?utf-8?B?TGFkblA3aVRoZGlzZTVXZ2ZaaDhKS2c0SEdCL2xBNkhMSC9iUUxsM1NpbzY3?=
 =?utf-8?B?V3lia2g0U3RhZXd3elgyRHhnRWw2Mlc0QThTREtaM3VXOWlnSVpFU3dnemRO?=
 =?utf-8?B?ZXRySW56MDRTWDBTWWF0Wmh4TGNVNytsMmZ5SEEyOXlHaXpjZnJUQzg2M3NB?=
 =?utf-8?B?MjIyQmxlUTdwUkR0cWtybU9MV0tpTDQ0SkxDWEU1d2hzNmxlaWNUSjJ0TjdX?=
 =?utf-8?B?UTJmUFJaRnZEa2R5a1pzL01WM1JkZjJJNXZyUlVoOEVMZlAxZVc5U1pCaGlL?=
 =?utf-8?B?OHdHOEJjMndqUmdISmNsS2ZqR0toSXNwYjlNeUxPajFCemJUNVlzbWd3bko1?=
 =?utf-8?B?Tk9KN1pMcEpOWEdNY3Y4bW5vcTd6RVF1ZElqa0Y2VGsxdllmbE0vQkNqQUNs?=
 =?utf-8?B?MU12dkF2MkJxUGY2YUlmN0hzTGI0Q2ZyNmxobEsvKzhMbkl6NmhwNFFLUzk2?=
 =?utf-8?B?QW80TURmWkM4cksyMktBVkVxdFdtZG02MEhpKzBRWDlhR0R1emtXb1RldURa?=
 =?utf-8?B?Z0MvS3hENWZWNG9rRnR6bldJN1hzUmc2Rm1aTnVMZXgvK25TOTRXZzdCbUdy?=
 =?utf-8?B?ZlZzNU5YNHVEZW1wTVAzaUVLR2RLYnFWckhXYWdVTk1Cdjg3VUJzcGNrekFi?=
 =?utf-8?B?WjBROGtOWVlkQXVoeC93KzRFNUZiZE5YWkUydXlVYStUVmdMVWZHNXBoTFpP?=
 =?utf-8?B?MjN0RnZxUHpVMzkwKzEwNzdtQXlGeVFqblg4eWpVdnYrN1hmUHdUeTZTc1da?=
 =?utf-8?B?VENrTDAySi9FY1h3dmVvVk1ZWDdmRTNvbkhpWXlkLytvbFN2KzdnVDkwSUVD?=
 =?utf-8?B?Y1FLNWtWc053TDl1NmdTVzNYVGJvRGlvR3d2SkhRa3VJdk10YVhRcTNtVWFi?=
 =?utf-8?B?T3NtMWxLQ24rZWFubEJaNkg2MWtMcnFtYThpNDdxLy8vVmN5YnhqT1RNKzZm?=
 =?utf-8?B?YkkvMXJLd3pYS0paV2JzV0QySkZGc2ZWdy9IQWJsbENYZythSHJvRndkZTNx?=
 =?utf-8?B?YkxENXlNMUtkeFhBbkJObmVGSmM2WXl0VTVHamVPRkd2V0JPY3Y1dkd4eGNr?=
 =?utf-8?B?VTNYV0pTbDRPbk9Qai9DOVg2dzdaMmhwdUQwcEV0ZHllQlpBMnpvZEdCSDdM?=
 =?utf-8?B?QVIrYlh5OTA2VEhodGtyWHIxcTUxSzh4WGplUkRoaUxQK2lSSVNTYjVIckhW?=
 =?utf-8?B?L1A3RzlBcy9kcE54TEs2Sy9CSWFpYXBVKzRjd0VSM2lQUFU0SXBVeWxYY0cx?=
 =?utf-8?B?U2tKV1F1aFJhZ2dlYkhBYnVkdCtjUHN6clJXaE5HUEI5UWdPTWc2MVFqRWk3?=
 =?utf-8?B?M0psb3ZybHl0bnJoc0Fsc0w1SG8rdEFsSkFMaWhjM2xwZnNucVBUY0lmbGs0?=
 =?utf-8?B?OTdzQXloUWp4bU92OTZzVFFnUXoya1pBRzk4dit0NlRidHNsMmtkd0dINzZj?=
 =?utf-8?B?Zkdxb1NWSmllMVhtQ1JzTnZZZG5WWkdLbUJPK0ZGdzM2OEh5WWtHeEQ0V1BV?=
 =?utf-8?B?QS95OVVsQkQ4VUdpUkRrd291d1ZQL2hSbFdVS2RwcnUrTURtQnZKUU9uZnN2?=
 =?utf-8?B?WW1BUStmcEQzY3QwbGdDUHczUWIvb1JXclBpVktDdThLcDltVkhBWVJ4VjJl?=
 =?utf-8?B?UFZpVVdDbzlSeW4vQkU4N1dzbGRVNzVqNUthZE41R2VnM0lhNnR2SlllN011?=
 =?utf-8?B?RTJhRjVlak1tYlhGeHpNLzh1QVRwbEJTV00yVXUzNVRYWkx1UmNDem8wekNR?=
 =?utf-8?B?WGNLcE9VdjAzNWlORnlQL0V3MDlJM05XMzhsYzQvRWZlUjg5RmljSlB5dStU?=
 =?utf-8?B?Q1pST21wWXYzN0RNcy9tUGxXd1pYL1U4WGJYSFNtT3gwYXhLbVlxeDVNQVVC?=
 =?utf-8?Q?+f+0i+mQOAtvXvxubiM4Q+ZtRDG84wqr?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UGtZM3E4V28zTnRnVDh0OWtHSWRxZzBvVjA0Y0x0V05hWGN6SEV5YS9jNmNz?=
 =?utf-8?B?ZWQvSXpCNkRFaGU0UEpTWUp4TDNhMDNsR09jaU5MWG5pZ1UvTTBvK2tZemUz?=
 =?utf-8?B?Q3ZEeXFmN0JMSTBpeGtqaDdTYmhZMDJFMHhTMFV2L01oMy9FL054cmJxSnhO?=
 =?utf-8?B?ZWJjbWJPYjdHU29sTXBsak5qZmdsRVRrdGhEenljaDdiK0o0OWYzL2tjcWdi?=
 =?utf-8?B?OElZU0VnWlZ2R2dXeFd2eVlNRW9oeGNNaURhYnlDdnJHL1pZZm5QZVdiSHFG?=
 =?utf-8?B?d09nV2hlazVwUkpKeGs4ZDE3cDcxUjhnc3NucGNqUUxBeU1NYUhSUndOeXkr?=
 =?utf-8?B?ZlFpazZIT2VCbWM0L3VmNW5HSXJSWkVEeUtIcjJEUkJOL3J3UTRiOXhiT0Fz?=
 =?utf-8?B?cnlTVXk4WGJEdUJnY3kzMXpVam43c2NPZy9OR05kSC9KbURsNW51RFZNcFUw?=
 =?utf-8?B?OXEvRnBrcURYeUtNSDBwenBOaFVhMDVpYURaeGZkRnJyakk4VXRzeXlrNWw5?=
 =?utf-8?B?aWZ6SDk2L0FiU2RqRHdRdFdqMzRWQVFEMXNhTEF4RVBUK2dPWG1tQXhPamY4?=
 =?utf-8?B?c1E1RzFoUUhCeEZtVHNIT2hrT1diYU94L2NPdzdjNmxjK2FwTlRtdDRWMTlD?=
 =?utf-8?B?L3lOVEVBQjlQK2dMZC9PK2VTbzJhbzFZdkkvbEJOemd4anIzd1I4TnQ5Nlo5?=
 =?utf-8?B?bVl2dW04dFo2QmZ0bzJwSlg3YzkrbGxXOU10WCtKcUVweG45QW1hQ3JaUnFQ?=
 =?utf-8?B?MTlvQWNkV0F5RHhac29uSXpIS3dSaEtLQis4UHRiSDhFY1pWTk00MkdJdGYy?=
 =?utf-8?B?N2tRbEhucmdiL3pBMk5GSHFGaEhBUW9UdUpPaDMxMW5USmIweERMR2lRUksx?=
 =?utf-8?B?Q1FobzljMjNhQy96Rk5PNHoxNGJwaUVpL0R3RzRIYmh0eURIT3RVbDFLNFhy?=
 =?utf-8?B?L2F3ZTgvcEZPMFlCcmVKNDgzbVFlRnBCL0JtTkU4VjFnckErVldkcGxocXNm?=
 =?utf-8?B?anVDWkJBSVhTVU5nZjlTakp3eXU5K2tnTEFkRzV1dnJ2S1JxN2huQkNhWUFD?=
 =?utf-8?B?bXRDa3VWZ1VMbkljZUV5QzN5SXdJQlJDYlQzcFp3TnRVSXNod01qNDZDMlNP?=
 =?utf-8?B?Q0NqQjUxVlBPRjBaMURadVF5TE16S2h6SW9BcUhPNS85aGs1L0JjTUdtcmlS?=
 =?utf-8?B?L0JEUm5za040cjhBK0lqUjcxNlNyYWhLUFkxQWpKQjQySXZ3RnA1SzI4ZUNJ?=
 =?utf-8?B?NWlZVHdIZ285ZHgweHJrRlpONHpZNVROUzFvWm1aM3R4RHR6aGpxcUFLa2Va?=
 =?utf-8?B?d21DQ0JQZVl2cExKWmt6MWlReTdiSVdTYndDSDhUR2Jtd1dXYzNrelZ1YkZO?=
 =?utf-8?B?amRXaEhNNGJ4RHM0TUkzSzd5WGxBckVqWldvUWlzU3NNZmpFSTY2TG5DNVFX?=
 =?utf-8?B?YTJXM2c5YWtFZEFSbXVQYlh2VmI5dGFlQzBRVkVYV2xFSnFFb0FhSTlYM3Z1?=
 =?utf-8?B?NzdaaGVYSXQ3NXZzR1hkdVVEcWYrcTFmWTFSRjJpZ3pUUkNjQ2RWMVpIRkxH?=
 =?utf-8?B?REFkQysyZnVVczhJMzUva1pOY1VWTnp5RlJhaFFnTzNGMndmTjFCRW44dEpu?=
 =?utf-8?B?ejAzSnpPbC9NYWMzU3YwV3Exb1YwQXpCY2VGL1BGZ3lEcWJ5dGMzQ08zZWVx?=
 =?utf-8?B?MVZ5VkUzdmt4MWZ5L0k0NndnTlVMc3dlcG9aM283ZzBYMkNRUlJBcUIxKzZP?=
 =?utf-8?B?aFB4bVZqMC9xUDJjSnMra0pKTFJRWTZmYUpKcFREL055OTBKMTJmQVJ5WHlH?=
 =?utf-8?B?WlRmQVRuM0FwK1NRdEVjQlFSd2w2OFNFWlA2bnpYV203RUp2elpEUFNKZnNE?=
 =?utf-8?B?VXhoemdtOFMxaGQzTS9oS1NKRWsyTHBYS2w5N3NIMUJXc001WUJ3WXYvSTJ4?=
 =?utf-8?B?d1AzR1Y1UFJHQUJNUkJIQ010d094MHBoeHZpT3pNNHR0Z1NjemRLVXlXeExJ?=
 =?utf-8?B?cHdnNG1MQlIrcGY2dHBqL25ic0lQMk5lTUVGamI3dHBCNWM1MjV6dCsrdTNQ?=
 =?utf-8?B?ME10eDNta2R6Qm9GcVlBRU1CNzN2Y0NIN0lKek4zbkJmL0lpTnVRZU9SQzIr?=
 =?utf-8?B?MWxFQWpneEo4emYwTkF2bUFHN200NXlQZEE5Y1lhVDdySndIVEF3VGVmSzF4?=
 =?utf-8?Q?/4BUOy89twkW8wYnmHQhORY=3D?=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c477a17-4555-418a-7c69-08dd407d5d51
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2025 15:55:33.6697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qceRhDzBJrmmEPUf3mDDpM8tabtbt2CGgBejz9/fZV7MAtwYq3GSNEmH20n8sMpntp+mN3P0mV8TzAoRmapCYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5613
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <89BC246E2F34D64AA665035F973EA536@namprd15.prod.outlook.com>
X-Proofpoint-GUID: BiU3h--e8Wf4JF2luL77eC_9qHM6nF_6
X-Proofpoint-ORIG-GUID: BiU3h--e8Wf4JF2luL77eC_9qHM6nF_6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_03,2025-01-29_01,2024-11-22_01

On 29/1/25 14:02, Kanchan Joshi wrote:
> >=20
> TL;DR first: this makes Btrfs chuck its checksum tree and leverage NVMe
> SSD for data checksumming.
>=20
> Now, the longer version for why/how.
>=20
> End-to-end data protection (E2EDP)-capable drives require the transfer
> of integrity metadata (PI).
> This is currently handled by the block layer, without filesystem
> involvement/awareness.
> The block layer attaches the metadata buffer, generates the checksum
> (and reftag) for write I/O, and verifies it during read I/O.
>=20
> Btrfs has its own data and metadata checksumming, which is currently
> disconnected from the above.
> It maintains a separate on-device 'checksum tree' for data checksums,
> while the block layer will also be checksumming each Btrfs I/O.
>=20
> There is value in avoiding Copy-on-write (COW) checksum tree on
> a device that can anyway store checksums inline (as part of PI).
> This would eliminate extra checksum writes/reads, making I/O
> more CPU-efficient.
> Additionally, usable space would increase, and write
> amplification, both in Btrfs and eventually at the device level, would
> be reduced [*].
>=20
> NVMe drives can also automatically insert and strip the PI/checksum
> and provide a per-I/O control knob (the PRACT bit) for this.
> Block layer currently makes no attempt to know/advertise this offload.
>=20
> This patch series: (a) adds checksum offload awareness to the
> block layer (patch #1),
> (b) enables the NVMe driver to register and support the offload
> (patch #2), and
> (c) introduces an opt-in (datasum_offload mount option) in Btrfs to
> apply checksum offload for data (patch #3).
>=20
> [*] Here are some perf/write-amplification numbers from randwrite test [1]
> on 3 configs (same device):
> Config 1: No meta format (4K) + Btrfs (base)
> Config 2: Meta format (4K + 8b) + Btrfs (base)
> Config 3: Meta format (4K + 8b) + Btrfs (datasum_offload)
>=20
> In config 1 and 2, Btrfs will operate with a checksum tree.
> Only in config 2, block-layer will attach integrity buffer with each I/O =
and
> do checksum/reftag verification.
> Only in config 3, offload will take place and device will generate/verify
> the checksum.
>=20
> AppW: writes issued by app, 120G (4 Jobs, each writing 30G)
> FsW: writes issued to device (from iostat)
> ExtraW: extra writes compared to AppW
>=20
> Direct I/O
> ---------------------------------------------------------
> Config		IOPS(K)		FsW(G)		ExtraW(G)
> 1		144		186		66
> 2		141		181		61
> 3		172		129		9
>=20
> Buffered I/O
> ---------------------------------------------------------
> Config		IOPS(K)		FsW(G)		ExtraW(G)
> 1		82		255		135
> 2		80		181		132
> 3		100		199		79
>=20
> Write amplification is generally high (and that's understandable given
> B-trees) but not sure why buffered I/O shows that much.
>=20
> [1] fio --name=3Dbtrfswrite --ioengine=3Dio_uring --directory=3D/mnt --bl=
ocksize=3D4k --readwrite=3Drandwrite --filesize=3D30G --numjobs=3D4 --iodep=
th=3D32 --randseed=3D0 --direct=3D1 -output=3Dout --group_reporting
>=20
>=20
> Kanchan Joshi (3):
>    block: add integrity offload
>    nvme: support integrity offload
>    btrfs: add checksum offload
>=20
>   block/bio-integrity.c     | 42 ++++++++++++++++++++++++++++++++++++++-
>   block/t10-pi.c            |  7 +++++++
>   drivers/nvme/host/core.c  | 24 ++++++++++++++++++++++
>   drivers/nvme/host/nvme.h  |  1 +
>   fs/btrfs/bio.c            | 12 +++++++++++
>   fs/btrfs/fs.h             |  1 +
>   fs/btrfs/super.c          |  9 +++++++++
>   include/linux/blk_types.h |  3 +++
>   include/linux/blkdev.h    |  7 +++++++
>   9 files changed, 105 insertions(+), 1 deletion(-)
>=20

There's also checksumming done on the metadata trees, which could be=20
avoided if we're trusting the block device to do it.

Maybe rather than putting this behind a new compat flag, add a new csum=20
type of "none"? With the logic being that it also zeroes out the csum=20
field in the B-tree headers.

Mark

