Return-Path: <linux-btrfs+bounces-8556-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 369E69901ED
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 13:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0654B231B4
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 11:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32951156C5E;
	Fri,  4 Oct 2024 11:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="G6vHDnA4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE68E224D1;
	Fri,  4 Oct 2024 11:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728040717; cv=fail; b=HvpcYkgdEa8/GVYuG6jTAqkkatj/QpVkXQSN/oi45eK0i3uB89T2CdIKua1oB04AygJX6m+kCy/8nYzCc9Z1EjBG646m9Morh/9e19t7BiktIyJ3X/Ch/23ZIj/0Nv8hdTJbvv3cxaQyhm0YIReVL9r5nUO74HfTnoZeYZd7gck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728040717; c=relaxed/simple;
	bh=lnMgsvWGfc/JeNIKUD5ET/NqeplZMoEXRLPPaVWVGCk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I9qUi/ChudsIoaYdDdiC+ARFgVnd+Vearpo1TwcX8OxQrfltq/PGK2JZdTB2t3yS7a2mGUKy54s3LOzkOYqv0CNQw9i6zimsBaFFn3C5Run63lNSmKLDFdT/rvwnX+oVxuG6ZwHvruz0QfuEuwBrVzxFZz1azA1glNh/MrSGayg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=G6vHDnA4; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 493NEDbC005196;
	Fri, 4 Oct 2024 04:18:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:subject:date:message-id:references:in-reply-to:content-type
	:content-id:content-transfer-encoding:mime-version; s=
	s2048-2021-q4; bh=lnMgsvWGfc/JeNIKUD5ET/NqeplZMoEXRLPPaVWVGCk=; b=
	G6vHDnA4fDxZS1B/6t365+8CW3guCZ3jWl4Rr0a7dn65yDTcIRZ2NymGlK2Ghj+n
	1v988c4LUitE/NhzZRzTqhK2aKWNI9phzZQYvhqvxerlB5fZ5Q0b6qAVLpfzlz18
	rXjkHZjMM2neJgG+0DzhSlQvnrRh59M+TJFKOd3i6mcsDFPjbqoowySv/FlCrx0H
	swVTF0Fw6xmeo5RiZQn3YlJyRevdy3CdWb1qtHuUxsMMQt80v4OvFPSgVYg7v07o
	5qzroD/MyJV9oUnsq0El9S84RBZKTbYvtbdS2k+gTL1wDrUsJ7IFEFnRU1LC+4gu
	deS5GPGml1xdRS9papJtSw==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
	by m0089730.ppops.net (PPS) with ESMTPS id 4220494pen-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 04:18:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFC3TTqHqDvvmsCPx4Cu2hQnUXiG5NgLzG9goLdVTleLJArQUvCv1XRmBN8OGxUBR63tw5J5OLPYSbpydGvI23PWBcv6Au/ylAic2N5NW6nbEsu3L6h3Ff1t6JtLUQKvsFnyx73fl/iMYsUJYMydvshszhU5jWdyVK0WIq+wgy6xtyH+7gyQ+qI7HkF6f1i59NTXCtOHnOtCIZRNjOI/yAdhsncqT8+q8txJUXts3A9JSu6NWMliRdBiY5wZoUfxgDcz2QT199p88z9aXE5vzOicwND7tR/p6Sivovhot1pQClddekBPAbvCLi9J7Dq5r1+iIed3NJRG86jyW3a3dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnMgsvWGfc/JeNIKUD5ET/NqeplZMoEXRLPPaVWVGCk=;
 b=jlV4G6TONFvaYQPcECs7/eRGIgagweYSxa62c6iyanjbHPTD3s+ADEtHKolfnPw3NIicYfN02CB5rgCmz0Z6ygFCNa5XRXB22TZOK3eho38vIs6e5AZyUrFx6IWMxfJYEDMaTnJzVhkXBph2SwfWVVolIgVWofn2SzXjQ82tYJmeEXp7HZPEtXY+CV2u+RnvBHAkoW6LHc4/ZzOkAjOL8J2BinbdGs89wTcsAKaxA8kwf/oChy97SR2lHHxgueWSUo98jHJFTC+gY0TMOMkkG6LamizIDibuafzmDX+If+tRKmFTlYehrrHC6OYhI3LwwU0+y9zou76Mv+XMH9f7kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by DM6PR15MB3798.namprd15.prod.outlook.com (2603:10b6:5:2bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Fri, 4 Oct
 2024 11:18:29 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%4]) with mapi id 15.20.8005.024; Fri, 4 Oct 2024
 11:18:29 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Boris Burkov
	<boris@bur.io>
Subject: Re: [PATCH] fstests: generic/563: use fs blocksize to do the writes
Thread-Topic: [PATCH] fstests: generic/563: use fs blocksize to do the writes
Thread-Index: AQHbEsp5iu5dYsCLq0y2OujvUfdqjrJ2XrOAgAACFoCAABfnAA==
Date: Fri, 4 Oct 2024 11:18:29 +0000
Message-ID: <c13d14d8-f78d-4d83-afcb-76f1d0530019@meta.com>
References: <20240929235038.24497-1-wqu@suse.com>
 <805c5e48-050e-48b2-be53-1a2f0fa4a088@meta.com>
 <509d89fa-56a2-4c01-bd3a-828e00e7a314@gmx.com>
In-Reply-To: <509d89fa-56a2-4c01-bd3a-828e00e7a314@gmx.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|DM6PR15MB3798:EE_
x-ms-office365-filtering-correlation-id: c5404fb1-93f1-4665-8d75-08dce46645f4
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VExkUlY4b2VsTmZ4d1BwTjFEeldiVFRKK0RXZzJDaElqSXk4TXU4RXAvY0VJ?=
 =?utf-8?B?Z2NlYWhxQU5oVjI4aUJRQ1p1VFNzYzNNcEhudUxZWmtTMFY1UWhZN3JpQ0pL?=
 =?utf-8?B?Wk53WHMwQkx4U1ZONE9COFhvb25RT0MwU29maU41b3JjUmR4dWhSc0hRZkRZ?=
 =?utf-8?B?Z1k5bGluTzJweEN0TDRTRUNSak1SZlVWclZMMHB5Umg4NlJsNXpwekZxc0E3?=
 =?utf-8?B?NEovOTB5a2pLTGVRcE1CdW4zREZ5ajZlZ2s4T0wyeGZYc1V1aGE5RXJYRWFU?=
 =?utf-8?B?eFNLOEMxVW01Q2F1RU1TajNNNi9OM29aRlJSMjNKYU9ZMnBwaHl6d0ZwWXU1?=
 =?utf-8?B?dERsUjd6NmN5bDM2MEdQSnVqOWlYMTJTRjdacGZLbEpYdjdYcFVHSytxTGlF?=
 =?utf-8?B?akwzbXVBWWF2SE5haFZTSWJ5T2lWRko2UmdQQklrd3kzaFkzTXA5NHJRb2s5?=
 =?utf-8?B?YVVBZFZrSWFNS082eldKKytnYyt0MjVNR3dENGs5SThLMjNabDBCUFBFdUJ2?=
 =?utf-8?B?TmJlU1BaNmxCdzdVM1pwUzA3amRyUllaWXdQSkh6aVljYnE1NjIyZyt5Y2Fh?=
 =?utf-8?B?a3F1M08zY2pWS25YV2pRR0hmMHpBdFpiaHY0TlY3cVU1amcrbHA5d2VpY3Zt?=
 =?utf-8?B?bkFFSnRDUjNFNWI2d1BuU0xtWmRkOG1YbkJSaEdPQ1FvZHRTd0c0YXFLRkkx?=
 =?utf-8?B?aXpZSFNGMnI3cmxIT3o3bVlPa1lFSnlzTlhuTU5QSUZmejVuQTdENXROYkJ1?=
 =?utf-8?B?cjJJQTJSZnVYUkJUaEtxTzNCVGZoUFJSY0VBTEFCNWpVZGJaTUZWTU5BQ0g2?=
 =?utf-8?B?YkhSY0tONWJvbVdzWnJCVnZkZTAreFlvNjZXclgxbmFuK09MdHZWYTYvOWp0?=
 =?utf-8?B?eWw2S1QvaVRSclhFLzl6b0VXQVpHN1hKMWpGMnRpWnVjUit4MjRKRThURmFP?=
 =?utf-8?B?SEVxNnMvam01RkowRHc2ZTRnbXVadzBkYXF6S0I0cDE5UEM2M1NKQmpHYTY2?=
 =?utf-8?B?ZE5SOENOQ3I1T0JKTGVzK3FrOE0xQUhPVFk0aUpqbWNIYlloMnVBaFZOREdk?=
 =?utf-8?B?R0Q1d3F3MmFYWG1Yc2Jvd2pXcTFBNHhBN1h2TmFZaHFGSXdXbnJVQ0hEdnlN?=
 =?utf-8?B?OGV1RHlscy9IZlc3cEJ4Z0lsVnd6RGlCVXlYaWtwd3MzQlJHbm4rVHBNZklw?=
 =?utf-8?B?dWVjeUtnVkJFcXMzaTdqWk9Pa3BYSVBwZm1ua2FnK1dyRE1pWlA0ZmRHMUhN?=
 =?utf-8?B?eW1aT2U2WTZRQzBwaXhrUEYvblNtQ1AvSWFCOE9VQlFzMnljWlZhbVBqamVB?=
 =?utf-8?B?YWsxZHlXL29GbWgybk9rNHJ1ajF4R3pTUmRoanBraWlodnRJMTJpZjZFYVdR?=
 =?utf-8?B?ZGRXT0FWVTdKSW5JWE1MMUE3dHdpR2ZUUlhnckpScSszU2NxbVhIS09WNDBX?=
 =?utf-8?B?T0VFUHQ3VXNlSFVtNFZNNHlqelVHcmt2YlRBcGtwUEtWTzhPb0pWWkdvM0xw?=
 =?utf-8?B?VjUxMzV1U3NSZEhpY1QvVGZ6VWNJOGMwZW5vWFcvNEFXS2RKT2NMcjlScmFD?=
 =?utf-8?B?TmFacEluSzVJUkl1K1A5aHl2M1BSUmh1RElkdU54dUczcnU3c1d2Q2xQK29R?=
 =?utf-8?B?SGNIa0NwUjNCd0phSzRZTjQzbUtpQU5oU09uUisxUTUxVGp1dFdic0FMMmJQ?=
 =?utf-8?B?ODcvZFdrem5rRmErRWxvTlBFSE1JTTE2aDdZNG5yUGRHNVZNMFk1ZkV1aWpJ?=
 =?utf-8?B?eVp1M3YraFVITkptU1c3UnI2Z1lsdW45bGdBUFBpREl4N0VrcFJwYWExNTRi?=
 =?utf-8?B?N1VudzhwUlpQdVlDdGVyUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UjBIay9FMzh2c0J0VGxGcENHbExmY2dBVXJsZy9mR3Nqa21ObWVobzBRcWFH?=
 =?utf-8?B?WUdVVUZiaGhYNUthRWhPUEZ3SHZmTUY5aGtZR1F1b1U5OHFqdDJad1F3emph?=
 =?utf-8?B?OU5oeWdWcCtzUFlibnVwUmNEUmN6cGZvMjlCeEQ5QjJhY0wzUCt1ZVFDOHd6?=
 =?utf-8?B?eHB3UUVxd2ZmMlplNng0T1ljd1o1T2ZpUE5VTVJWNmxEaUxPY2lrcWtYNVp6?=
 =?utf-8?B?SzZpWUlERGM3WmFyTmk2NUxkaS9jellXdEhPZWVOZ0FBdU9MTlJwQzdSdmhq?=
 =?utf-8?B?VjU3MUdydUk5T0hSZGtDNnB0MGwrRk0rUlJneTRiRlZSK3NHRWpmaTR1U3Nt?=
 =?utf-8?B?WlJLQmkreVhqS2hVdTFpY0hXRXRMZ2xpNXBNaGZ1YUx3QXlyWnptSGYzcWI3?=
 =?utf-8?B?cHpJbitUdWtEamhSck1CaUs1V3ZlVXlZb01uYTYvR3A2OHlzQ25UQWtWa2JI?=
 =?utf-8?B?TE5EWXh2aStmeU54ZHpJSEh5VmNnVnU4dTE1NDZHTWRVNzlrUmtYOEl4RHJ5?=
 =?utf-8?B?OThqMXBtcVo3VlhVOGswK3l1TERCeTlYeThiTmlDMG1mS2NIL0NoSnFHRHFo?=
 =?utf-8?B?UGQza01oTWJ5NGdLdU9tTU9qT0lyR1V3dlFxMVN2eG9jUnFuWkVpaFJUQ09I?=
 =?utf-8?B?MnA4eURsSDlDTFFaYWhmTko3UmE1b3JFOEJVcnBYREpkOUVNTXJBbzhPaHBv?=
 =?utf-8?B?RC9vS0poM3ZoSkJkZ2FEeGwvYzVqbUdITnpwT3MvTDlMVXZqdmMrcVQ3emlK?=
 =?utf-8?B?SWFzR0syTHRDOXNjZi96QVB1YWpnWXM0RWJ3L2ZOZ2dVRWxBTGJxT2JoU0ZZ?=
 =?utf-8?B?R1ZUOTY4OGpjQTNMMEZVVUJhS1hwVnFKVDlHQWV4czdzdTRPMGNkYUVJUmcz?=
 =?utf-8?B?MElNSEJmVHhXMHFQbVMrVy9nNEp6RlNTVnNMUUZKbXorcXliaTQyNnEyRjhy?=
 =?utf-8?B?Mk55M3NGOGdrbURBalpPNStWQjlERVVGclAyeDZaOWFDelA4aDduQTlvN1Bl?=
 =?utf-8?B?K2w5V3pwUEpIVklUQjJmMDFRNWRYRjFYTTRwSXY1VnBxT3A2bnRwNit2aXFT?=
 =?utf-8?B?K0lLRmYvT01pNGZpb3pNQ2k3clAvdThMR2I3c0dCL3pqUnJXb3VnMWd5YmMx?=
 =?utf-8?B?WEQvYWVIT0E5T0J2aFBxUGc1ZGt2Z1EzOFBNVXVZSUtaSWkxZ3U4a3hWcFJB?=
 =?utf-8?B?ckkvVDhKTEF2cDVKZEYzZ3dvZzQxWGJQbzBlNTV2TGw4T0JXYWtjUGlXYVBD?=
 =?utf-8?B?NDRyNktFc2RpRGpVWEdJZ1RKNjVaRXZQeGF4cDRXY3BQTTVTNlZGNG1xNmlH?=
 =?utf-8?B?SGxNU01Gc2VhdlBzTGd2M2xzWC8vNmhhOVpZb1NPQStreTZ2Qk9ISTgyZEx3?=
 =?utf-8?B?SytYM3U2T2o5MzdUd1l2d3R0SXk4Z0Q4Y2FCL2lkQUwwM2dZWkJnUGRHanRh?=
 =?utf-8?B?enUxdmZ6NGVWVzlwMG1vRVh6R3l1QlNlclBFd091MHhBTkh6OGcvYWJTWnU3?=
 =?utf-8?B?T29qVSsxeDJLOVNIdWI0N0M3ZjR0OU4vL1piSTFDT1ExMUFhRVg5eldWQW9k?=
 =?utf-8?B?bm1CQ3BtY3cwaFFVbWlYYmR4WDZySUh3OXlTR3hSaDlsUkt0ZW1IVXZ2WUFH?=
 =?utf-8?B?dnNpWVpsUXJpT0NWYi9nTDNxRVUvbDh4RnloMmtLaVpzUkQ2REdrNW01cFhO?=
 =?utf-8?B?Yk9iQUNnQ1JLQUVFeWJrQktsZFZrZ3g1QmFEZk5QeGkwMFV2bytCT3dzZ1E0?=
 =?utf-8?B?VmtIbEtJOWFzVm1xWDluMTNNVHJzZG85Mlk0OTZNUVcvQlAyckV2aFN4Q25R?=
 =?utf-8?B?NC9hREE5bTNuY3I1TEFJV3pxRm5pKzlBdDVjdTJEemhNOXAxaHFKcGVETmg5?=
 =?utf-8?B?Y2JvejdYYWhSekozMmRPd0VPakcyTlYyRVBSQldrZ2xpT3FLL0MyWjZ1WExx?=
 =?utf-8?B?MnpqWGtpSmZ1aDVFc3FKRDJ0ck9QbmFDd00zeDVUcFVscGMzbGRMYWZvdDFL?=
 =?utf-8?B?TmtVZWNlTjQ0cCtpVDJUUjhyQVMxNlBoRXhtbWc2dFN2azU5L3MrSUZ5MnBU?=
 =?utf-8?B?d0FjK1JuN0VuMWNseUQrUlFqbHlTdWJvRE1NOTBxaythWEppOUl4bkhDeEYv?=
 =?utf-8?B?L0U2UVY5b0lNRjVRVXcwLzRrVWgyaFRNOCtVTVlBeFlrSCs0Ujk2LzJZY3pT?=
 =?utf-8?Q?YysRlkQHBr8HLlCaJpkWLoY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <04763E91393B9240BD60347A026D9F3B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5404fb1-93f1-4665-8d75-08dce46645f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 11:18:29.0628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ebUfZ7n9/UonVQDUaUCA5LSriECu5Evh+QISOoIRCjhK2ZdSO3qch5MkFdgwgv9YPDEzZm8tw7ZE85zAPuOGCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3798
X-Proofpoint-ORIG-GUID: YX4EAJ-QxnUN10LEBpap5nN3NAeQMdmX
X-Proofpoint-GUID: YX4EAJ-QxnUN10LEBpap5nN3NAeQMdmX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_08,2024-10-03_01,2024-09-30_01

T24gNC8xMC8yNCAxMDo1MiwgUXUgV2VucnVvIHdyb3RlOg0KPiBGb3IgNEsgc2VjdG9yIHNpemUg
NjRLIHBhZ2Ugc2l6ZSBidHJmcywgaXQgbmVlZHMgc2V2ZXJhbCBrZXJuZWwgcGF0Y2hlcw0KPiB0
byBwcm9wZXIgZml4IGl0Lg0KPiAoaHR0cHM6Ly9naXRodWIuY29tL2FkYW05MDA3MTAvbGludXgv
dHJlZS9zdWJwYWdlX3JlYWQpDQo+IA0KPiANCj4gVGhlIGFib3ZlIGNhc2Ugb25seSBzaG93cyB0
aGUgNEsgc2VjdG9yIHNpemUgY2FzZSAodGhlIG5ldyBkZWZhdWx0IG9mDQo+IG1rZnMuYnRyZnMs
IG5vIG1hdHRlciBwYWdlIHNpemUgbm93KS4NCj4gDQo+IEZvciA2NEsgc2VjdG9yc2l6ZSB3aXRo
IDY0SyBwYWdlIHNpemUgY2FzZSwgeW91IG5lZWQgdG8gc3BlY2lmeSB0aGUgIi1zDQo+IDY0SyIg
bWtmcyBvcHRpb24sIGFwcGx5IHRoZSBwYXRjaCwgb25seSBhZnRlciB0aGF0IHRoZSB0ZXN0IGNh
biBwYXNzOg0KDQpBaCwgeW91IGhhdmUgdG8gc3BlY2lmeSBhbiBlbnZpcm9ubWVudCB2YXJpYWJs
ZSwgYmVjYXVzZSBmc3Rlc3RzIHdpcGVzIA0KdGhlIGZpbGVzeXN0ZW0gZXZlcnkgdGltZS4gSSBr
bmV3IEkgbXVzdCBoYXZlIGJlZW4gZG9pbmcgc29tZXRoaW5nIHdyb25nLg0KDQpZZXMsIHdpdGgg
dGhpcyBjaGFuZ2UgaXQgd29ya3MgZm9yIG1lLg0KDQpSZXZpZXdlZC1ieTogTWFyayBIYXJtc3Rv
bmUgPG1haGFybXN0b25lQGZiLmNvbT4NCg0K

