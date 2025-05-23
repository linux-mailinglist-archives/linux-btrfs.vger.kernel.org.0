Return-Path: <linux-btrfs+bounces-14188-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5075AC224C
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 May 2025 14:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58A375026F7
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 May 2025 12:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABBB2356A8;
	Fri, 23 May 2025 12:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="lTj23hjy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E180122F764
	for <linux-btrfs@vger.kernel.org>; Fri, 23 May 2025 12:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748001618; cv=fail; b=MOusddvbIygj0XsBJ0pwPfkINZ1oCQ8b8TXLUoqNPZkYCok5N9w/VJtWJx3CccKRP0bHWCL3AesRMA3e0Wlu1Rwbh1ypQozMN4YuNPkOzbOEAnjqhb68+E/zUGDmGPqJyOZzq8FrVksozESo8E+Br89Aiaanz/MmX/dQGa0p46k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748001618; c=relaxed/simple;
	bh=mmszDZv/zRtncA7PNmGLgRseMYZUszAPWYIzP9OjoBY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=d61ljJ+Y9zwKWiGF3CEdbEa1ZBNdhVdSLyu3pzpo0bSp9HC6+1k6Ri10g2/SondIbP62MKaCk6302fjLr+3sfOBE3Ze4ic7WpZIIJgf8OMG4iHpFd7zmG6b/hhKWuVU2PVJ/JZq8y1Fm9PYsv1EREJRvrsrcI470yvDO1IGbI7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=lTj23hjy; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54N587Eq002829
	for <linux-btrfs@vger.kernel.org>; Fri, 23 May 2025 05:00:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=mmszDZv/zRtncA7PNmGLgRseMYZUszAPWYIzP9OjoBY=; b=
	lTj23hjyzw7rWyjE72fKHToU2GevPE/7ass3N4vlJ18a0YCh3svok2L4IQ82oiNA
	MUeYOd+HMsspYUtmr1RpKiSeRe+0VIaK+q7U//1sefUzrnH1zYEUgIU0loWcs/FF
	W8X/+X8JWHSKGSaD3oce1qoatyQesJq/XFXP0BDscKeQXz46AWs5lskEhx1n08Zk
	itYM+zlq/E3U2W0eqK2I/5LC4xPy4EFkch4Ayp0COlhiXhTgtCZL6HUTtWPbXgZa
	UFqlfsPy2NlWdCLp6fGDEPgbsre9OMPUzbHWTI9OAveFa5tuuvCQLOGOK6k6JEFz
	QUyS+umfITL35HbGCUTffw==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46tjkp9wnr-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Fri, 23 May 2025 05:00:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqPHrMBdoBEYhXT3Etk5SR3FmSCRV1dga+dKmmOqSPm5z8jJPGLT6YEsakHpq/SlO6a8/C2K+wGdbmMmB5a36bXeTBd+m5x5fCOMR1IuyLIVmKxIKtOXdD6042B02SrWtcveGEu9P5dMpKe/ZOVdiBnxiAPwCSnnPrDwn83fK+JwiwN8crhk9hbVmPAAaYvnozhpqNFkc5BalqMCWk3UuOJsN7Xw1FVaS10Ab9VlYA5gh+0Fubn3sscr3oTljmSwGdAk8CKc1IwL3PT1c5QTNtr/VyZZxxJwpRkLWNeRrIimN3IqqTS+AM0xTVEKC4Sd6zjN+ZLHA1CInaWd+i6ebA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nVJLZxZl26YX6ihODI2UkZnoAO2g4NdjwJktrFIRYE=;
 b=xYcG1E5l+SXZUBuSsOoteSxDRdmWX2YQ4W66aciJdLKzazAC6uF1XZG19N86De7lOeIvz56bhK94dpk3n6XxTFeVzWa2VdyzveKQTOBazr6Vev2z2bzTxlL/GZCBbT3V2n9LFTbPb5i75/gzH7hPoU+WiZTKAAI9SY9xy6YpGwv2o7u/9w5lbWurwlgFWW5gzxlC6suI5lF4KirSsz0et9KPtDh8bjxDiajbkkGGcqzuZ1aC7qIGERRhh5Nzt0t7sBmmLPnz1eiYi3r+rKYBidSzUVZqYnDGW4kHERG7dS6R8x5nGOrENDYjQck5cr8/aSammKw0PShUevegj5f5zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from PH0PR15MB5659.namprd15.prod.outlook.com (2603:10b6:510:282::21)
 by DS4PPF9EF34FBD3.namprd15.prod.outlook.com (2603:10b6:f:fc00::9ae) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Fri, 23 May
 2025 12:00:11 +0000
Received: from PH0PR15MB5659.namprd15.prod.outlook.com
 ([fe80::dffe:b107:49d:a49d]) by PH0PR15MB5659.namprd15.prod.outlook.com
 ([fe80::dffe:b107:49d:a49d%5]) with mapi id 15.20.8746.030; Fri, 23 May 2025
 12:00:11 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [RFC PATCH 04/10] btrfs: add extended version of struct
 block_group_item
Thread-Topic: [RFC PATCH 04/10] btrfs: add extended version of struct
 block_group_item
Thread-Index: AQHbxbeUTTsdIT+lD0uHwy2HbCs3vbPgBbGAgAAjVgA=
Date: Fri, 23 May 2025 12:00:11 +0000
Message-ID: <c0280288-cb7c-4135-81b0-46e4cf6e4c54@meta.com>
References: <20250515163641.3449017-1-maharmstone@fb.com>
 <20250515163641.3449017-5-maharmstone@fb.com>
 <1b511b2f-0738-42a1-95af-546bd7b4e51e@gmx.com>
In-Reply-To: <1b511b2f-0738-42a1-95af-546bd7b4e51e@gmx.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR15MB5659:EE_|DS4PPF9EF34FBD3:EE_
x-ms-office365-filtering-correlation-id: 253f9f96-7189-4fad-dd8a-08dd99f15f03
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SXdaVE12U1FJZkcvWVNsRjN1cWVtckRXeXFmcXNNRWRRRXpBYTBqRldCYVJD?=
 =?utf-8?B?V25wbEhCL05MbzVLTjFBMlJFNHNCQnZkNHc2MWlpRGtidEdHbTd5ZkN4QXhJ?=
 =?utf-8?B?NzBsTkVzcE41b1cyaGYxV3pjNTM2dk1jV2cxT2REeXA3eVB6T05lZTYrSDZq?=
 =?utf-8?B?MjBvemppYS9mTGU3cXR1WENaYnptU1E1L0l2Ymk0a1JES2FyRzBwOHdTQ0Q5?=
 =?utf-8?B?NUJjYTBVVlBTcHZBOVdUdTRWNUNZTWl6ZDdya3NvdFo5M0xWdjlCY3pwNmlh?=
 =?utf-8?B?b1ZOdFNENFdjcEhScEZDVEo4NnBQaUJ5MlloV3V5T2NCRFBTdnAwNzFFaytj?=
 =?utf-8?B?dkNHS0IxTmtFblNkRTBDSmcvay9aNEQ2SHNuRU05UjBYL3Yzb0VRVTNLaXBJ?=
 =?utf-8?B?M29WMUpWRkpCMldGOHViOTBrZ3g1a1grQW1QalJzNHdvWWR4RSt6eDhGeDRx?=
 =?utf-8?B?Z0lwcW8vemxxVm8rZ1kxOWhvc1pGYmtvM2hsUnExUmk1THpYdjM0TWQ1NXd6?=
 =?utf-8?B?Mng2eFBuVmIreWJ2NjVtZmdDVHBidkRzYjFlb2RuTmJqWU56YWZlMTVzNTNy?=
 =?utf-8?B?SmY0Q1RHS0dOYTByS0JKVVdGTmtkN21NcWtjR2pyQ2RlZTdxMjJuRzU2eldW?=
 =?utf-8?B?dVVnSjR2cWwvNDlvMk5JR1MxZ25ha0VlU0kvSE8zMXdBVG9jVmNqa3MyOEoz?=
 =?utf-8?B?a3lKaEN4MjBsVHZEcmIycXo0NUdWc3VoU21tNE5UMEZlS1lWNEY4dXROTEs1?=
 =?utf-8?B?VXoyZEc3eTRvbHZFZ1poY2gxUXcvN0pSYzkwY0hYNFRzUW85NUVQbjlRZ2Qx?=
 =?utf-8?B?S1B2V25EQ3ZjOGoyUEs1VHR2b3VpL0FTYjVrTmdiNGg1RE94YVhkRXpQQkww?=
 =?utf-8?B?Rk5wb0xBYmdabURzZGRPWkY1TGIrSVlId2l6WllyQmV1S2tscjdmamxJdTJz?=
 =?utf-8?B?L1IvVnU3RG5kRkdJekhDaXQyMmNjaDlIR3d3NC80aTNFMUZmMyswUmpvdU0y?=
 =?utf-8?B?TjhpUnNGeHQxTW53TVk2Uy9mME5hMU9IZGtpaHg4cHNxN2FXVWNUMHB3MFNC?=
 =?utf-8?B?RXU5RkZSZmtWbUpSL3BWaFFmYldqTnc3STl0SFl2VUNwUzlaTU04dVZMNENx?=
 =?utf-8?B?b3dMbzMzRUtHUnNIc1VrOHY2YkhEbDErbnRIc0RnRkx2ZExETTMyZkhLR1c0?=
 =?utf-8?B?QmxTL3VtZ2E2cEl2UWU0SGVNMU1RWnJXUmpXcHlCYUxOb0NuT0tHNlB5Q1d0?=
 =?utf-8?B?dUcwVzFIOGhZd2srckN5Q083Y2N2Rk1sbjVwTml6SXloZkNOOHRBZlhSSUpQ?=
 =?utf-8?B?S3U3aXJ1RXh6ZzNjbUROY25DajNNOGNjaUxTcXgyRDBydmlvb2RVZHdJT0hp?=
 =?utf-8?B?Ukp6amhpa0FEVnBWRTFyajA4NnRYN3JUdGd5Ykx5UXBQemI2cFo0TkNCcW41?=
 =?utf-8?B?R1dsNGY2NU9EemFNRW90TkJwLzZTazVIdUJVSUgvWk02SHJsMWtEU3FDTllD?=
 =?utf-8?B?eGZPRlpZWDhpM29YQUtieUtBQ3hqTWJTeWtXRGZIQTZtOVJ3Y0k1cDJlcFk3?=
 =?utf-8?B?Zkxja01DangyckZQRiszYnZFWUswaVFZLzZ4N1JNMHExQ1BCYkVSSS85clcy?=
 =?utf-8?B?S3hQNVhQd0tYbDBHNmxyTHp4RStjUjFoN1BaSlpBVHRYRXQ5TkZZM3FZeFU0?=
 =?utf-8?B?R2xGZExEKy96bExicFE1dFZCdk1qdENILytjOWFsS3VDQmVHWDNuTC93SGhK?=
 =?utf-8?B?SzRtTHJ5T3NxOWtlRTJadjZXMVQwdlJYMHp6ZGNzRnN2YWtQbW43bkh2Z1NU?=
 =?utf-8?B?ZmgyN1BFS0lnWDUxb1ZzNVU5T0RRUkVBZy9aYldkMDhuVExIUEVRSHFhN0RB?=
 =?utf-8?B?ZXpRMHdxSW5UQ2lwWlNMdGtBVW1jbFlFaDIzQUpnOFBVYkV0MEVwSmZBQTZK?=
 =?utf-8?B?azA1WEpBb1o3aVVmWjRGNTk0bTdrMk53RmRkK1JtZUV6S2JzTDZJTUVPbFUx?=
 =?utf-8?B?bnF4S2U4dGNRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5659.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z1ZUS2xCNGdmNE9YRHdrenRvQmFLRE1HWFBiRHR3Skp6d2VnMHFqUTdSVnlU?=
 =?utf-8?B?cVFFSjY2dld0R2N4bGFwYkU0Rldaa3ZyZExHL0FoVDVoUm5xYUN3VVM4dGh2?=
 =?utf-8?B?NWFzdXdZbzJNMnAxNENkK2VNTU1VblFWRC9ON0FYWmhaTkhhQjVIcWRENTJ6?=
 =?utf-8?B?NThMdk5mYldXVlpEcEJDc2JlR1hhNnh5R1ZTczBuSEh5cDgrY3RVTSs2K0U2?=
 =?utf-8?B?V3pYa0IvRldBeDFJYXJJNVNoZ1dRYU85eGRXL1NvYTVaeENXSTJ2SEswWGdI?=
 =?utf-8?B?MFc0cE4xRC9qdy9XcWZhbThmOXoxODJZMUlRdHFOZGhQYndlTEE1Q1NHTzFS?=
 =?utf-8?B?N3JocW9hNVVoTXY4M0EyYm5JZ2Nwcmh5N0hRVEwyOUZTUXdpVTJMWWFOM3ND?=
 =?utf-8?B?bXFJZmlxVmtlWG9xZ2Z0NzVicmZBSjU0TDBpbkNRYnAycEtoWU5GYUpmZEFw?=
 =?utf-8?B?UURlc3RxUHZQSGRiSTlmaVk4YmV3NXJFQ3pTZ0J3TEs2SGJyWXJSaWNBbmRG?=
 =?utf-8?B?d0FvcFVpSXpVWEN2d0h6eXBGMzFGbWliVndKZFdVYXNVd1V3K3N2dlZLUE5u?=
 =?utf-8?B?d0pRK3VwTVNucEhWb2NrMEl3V2lwTzdaVlJ2ODBJTGZhUC9kQlJtOVZHUHhK?=
 =?utf-8?B?d09DRS9mNTFRSm5xUVpXcVMzQW9oMWExclRER2VoMUZ0MmtyUG1rSGt6eWlS?=
 =?utf-8?B?VFdrZ3Z0aUxkTlJjdndZMWU5TDdPc21aTUliN1A3b3BXaWp6QWpwQk9nbnV2?=
 =?utf-8?B?dlBNaWJHQTdlY1pXOUxoUDRrOUNKend4SjNIVnkwSyt0UXM5bWhvK3drbnBI?=
 =?utf-8?B?Mm1WeTVjUGVsU2oxSHBkNEdkMy9jeHNiZE9KZ1lTSHVBUURqVlo3VUJnNWFS?=
 =?utf-8?B?Q3BGUEx0MW5FNXhHTjRiQlowcWI1dFR5U3crU2RMM3FoM2FFUDFmNitXVDdL?=
 =?utf-8?B?b09tNURNbXdiTVZTZVRMWjNETTc0MnNZTWtpaTR1UTRlV0pLc1IrV0pqaUVY?=
 =?utf-8?B?cHBPVk0yUkRxVHBYWlhXbmphRTJNS0hrZ1JLVFlHck1yQjNKUlZBa3dBNFFI?=
 =?utf-8?B?RndIVjV1MDN6RDJOOCs1Qlh5a0VyK1J1Ujk4TFpaSEFCRTBNWnQzTWwzWDZF?=
 =?utf-8?B?cEVwVm5JcFlqMFBZWFpiZUorK0pnM3ZaVTB2SlRWdUVtM2hsVE52Z2pZVktM?=
 =?utf-8?B?U3VMc0NkWk9RQUZzbE1SdEp2QjhoRTRjRWZXOXB0KytBa0JYd3RnK2V6Qk5x?=
 =?utf-8?B?Z0p5d3hsTmVjbHhqaHVHU0NUS1F2am9odW9jL0w5Wm1KWFlDeVhxMDlZSkpQ?=
 =?utf-8?B?RU0wNWtvZlZiQi9sUlBvV2R2MG9hUlpFK0tMWFdtd3BSejRCVUhQcHVyL2Zj?=
 =?utf-8?B?OXByNktNUVNWWU9oNUVaNXdrSnl5YXp1aDdPM1BhVExLQmt2Z21zUVhyL09B?=
 =?utf-8?B?Uy9qRzRJZGlCSk53ZjNlOVREUS9KcVZuWXJlSjB0ZDZaZXdLWFZ5RGV2OHJl?=
 =?utf-8?B?K0ZZVWRIWXo3MmxEdnlTZzBNdlUyZmxUcnBjK0dLazFhVjRBYk94WXN4a09T?=
 =?utf-8?B?eVU2dHl4djg2V3BMc2xSWmxCb1l1cXFobUVFck5TbGJuUWdRYkdTK1paN0hP?=
 =?utf-8?B?bHMrREdSSXlVT0JhVTB0OENNWGhRQ3VXWlVtSkFEQTlKSGZBWVBtL0ZhM0dG?=
 =?utf-8?B?M2UyRDJYV3dmU3QxcE5qekhlTTNIRWJzcXg4Wk5tVU90SnVOZkJabU1EQ0Iv?=
 =?utf-8?B?bEcwdkZaK05OaytCNWY2eitqaUxVUDM1emJYNFpSSlhFZmhTQUI5ekRzdWNU?=
 =?utf-8?B?VnBDcUg0c25EdVJGamxrOTlFeko4OE5zWWlSTHBqYXdTTVR2eUk1T1JsaXFM?=
 =?utf-8?B?d05adVhlbzgyOXZ1c2R0bHJCVHlpZE1iaFpiQnBjMjZqV2Yram96ZlkydW1M?=
 =?utf-8?B?ZmhBV2VEOFdqZkhkeXdyMVVsSEJ2YndBWUZUM3hhMjI0MWFZcmlIYjNETnlF?=
 =?utf-8?B?SHl5bVdEajJheHVhQU9zQkk1Qi9DOEYwRnZGTTVMRWVmYU56YkRlamQ3Y1Fm?=
 =?utf-8?B?enEwNkpzaUZBb2dSU01KeUdaUk5pb1lhM2RVWnlHSnhnclNic3I0dGszdm9G?=
 =?utf-8?Q?bhiQ=3D?=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB5659.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 253f9f96-7189-4fad-dd8a-08dd99f15f03
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 12:00:11.6324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aKkOZAaK7SMObNbwmk/2fG/a+B2dVJzXOPWXEtFVc2w3q0xBI5HTQ9PAp3eKW0toqahbWQsNNj+UF8rilXP8vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF9EF34FBD3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <1F0BDC0CFA05D44581163CFC4836E3A0@namprd15.prod.outlook.com>
X-Authority-Analysis: v=2.4 cv=Q+bS452a c=1 sm=1 tr=0 ts=6830634e cx=c_pps a=0de+TxTBwdPc9w0nPmKirg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=FOH2dFAWAAAA:8 a=XwSrxwvGr9Sa_0Hq1G0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEwNSBTYWx0ZWRfX9UoYdfIP88gP eHDHeVRQnyEs8wOXwRHIyWho6ncRKPdV4JkQyCi+WP4+2z6IDd6BDon+tiNuh4UzvJOsEwyViZX d56gcu1a9W5SUoF1aNoNqHGZlalTfMyJRi4845j19LytKtbZSiGPyWlIyERGLrSId+2snIABPxa
 ZRSAEReXxAru+GIA9VYwi51cqCtvDTMzrsLxg4HyXwvUDkViXriq7j4rTM2tcun/ehr7vrG/KgA dH8RGZUkFKpOeBevrnKfHoT+3AVRvfugI0n9UghSFer5LLXVFBzC7o3WevVfbZUDWOkGJf5Ud1j lAxYti3YYKiWmg16aMb991aok1ZxeI+F80toguIHUoHvsXd7sOFnnfj1tj+2zh85mjrufyszWYF
 ijMxZ9gkx+5jjMSUnqbn3ZmylJbOIBxUvFTk8pYD92Hs8KMYGStoNOAff52mjqCEISb5/+g5
X-Proofpoint-GUID: 1OsKPLO69Fv13ha8_hqxubVnyHaSyMz9
X-Proofpoint-ORIG-GUID: 1OsKPLO69Fv13ha8_hqxubVnyHaSyMz9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_03,2025-05-22_01,2025-03-28_01

On 23/5/25 10:53, Qu Wenruo wrote:
> >=20
>=20
>=20
> =E5=9C=A8 2025/5/16 02:06, Mark Harmstone =E5=86=99=E9=81=93:
>> Add a struct btrfs_block_group_item_v2, which is used in the block group
>> tree if the remap-tree incompat flag is set.
>>
>> This adds two new fields to the block group item: `remap_bytes` and
>> `identity_remap_count`.
>>
>> `remap_bytes` records the amount of data that's physically within this
>> block group, but nominally in another, remapped block group. This is
>> necessary because this data will need to be moved first if this block
>> group is itself relocated. If `remap_bytes` > 0, this is an indicator to
>> the relocation thread that it will need to search the remap-tree for
>> backrefs. A block group must also have `remap_bytes` =3D=3D 0 before it =
can
>> be dropped.
>>
>> `identity_remap_count` records how many identity remap items are located
>> in the remap tree for this block group. When relocation is begun for
>> this block group, this is set to the number of holes in the free-space
>> tree for this range. As identity remaps are converted into actual remaps
>> by the relocation process, this number is decreased. Once it reaches 0,
>> either because of relocation or because extents have been deleted, the
>> block group has been fully remapped and its chunk's device extents are
>> removed.
>=20
> Can we add those two items into a new item other than a completely new=20
> v2 block group item?
>=20
> I mean for regular block groups they do not need those members, and all=20
> block groups starts from regular ones at mkfs time.
>=20
> We can add a regular block group flag to indicate if the bg has the=20
> extra members.
>=20
> Thanks,
> Qu

I did consider that, but the downside of doing that is that it makes the=20
timing of updating the block group tree less predictable. It would imply=20
that when relocating a block group we have to lock the BGT up to the=20
root, as we'd be changing keys and the length of items rather than doing=20
everything in place.
This didn't seem worth it to save a few bytes, particularly as it's=20
anticipated that in practice most block groups will have the REMAPPED=20
flag set.

Mark

>=20
>>
>> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
>> ---
>> =C2=A0 fs/btrfs/accessors.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 20 +++++++
>> =C2=A0 fs/btrfs/block-group.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 101 ++++++++++++++++++++++++--------
>> =C2=A0 fs/btrfs/block-group.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 14 ++++-
>> =C2=A0 fs/btrfs/tree-checker.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 10 +++-
>> =C2=A0 include/uapi/linux/btrfs_tree.h |=C2=A0=C2=A0 8 +++
>> =C2=A0 5 files changed, 126 insertions(+), 27 deletions(-)
>>
>> diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
>> index 5f5eda8d6f9e..6e6dd664217b 100644
>> --- a/fs/btrfs/accessors.h
>> +++ b/fs/btrfs/accessors.h
>> @@ -264,6 +264,26 @@ BTRFS_SETGET_FUNCS(block_group_flags, struct=20
>> btrfs_block_group_item, flags, 64);
>> =C2=A0 BTRFS_SETGET_STACK_FUNCS(stack_block_group_flags,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 struct btrfs_block_group_item, flags, 64);
>> +/* struct btrfs_block_group_item_v2 */
>> +BTRFS_SETGET_STACK_FUNCS(stack_block_group_v2_used, struct=20
>> btrfs_block_group_item_v2,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 used, 64);
>> +BTRFS_SETGET_FUNCS(block_group_v2_used, struct=20
>> btrfs_block_group_item_v2, used, 64);
>> +BTRFS_SETGET_STACK_FUNCS(stack_block_group_v2_chunk_objectid,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct btrfs_block_group_item_v2, chunk_objectid, 64);
>> +BTRFS_SETGET_FUNCS(block_group_v2_chunk_objectid,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btr=
fs_block_group_item_v2, chunk_objectid, 64);
>> +BTRFS_SETGET_STACK_FUNCS(stack_block_group_v2_flags,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct btrfs_block_group_item_v2, flags, 64);
>> +BTRFS_SETGET_FUNCS(block_group_v2_flags, struct=20
>> btrfs_block_group_item_v2, flags, 64);
>> +BTRFS_SETGET_STACK_FUNCS(stack_block_group_v2_remap_bytes,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct btrfs_block_group_item_v2, remap_bytes, 64);
>> +BTRFS_SETGET_FUNCS(block_group_v2_remap_bytes, struct=20
>> btrfs_block_group_item_v2,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 remap_byte=
s, 64);
>> +BTRFS_SETGET_STACK_FUNCS(stack_block_group_v2_identity_remap_count,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct btrfs_block_group_item_v2, identity_remap_count,=20
>> 32);
>> +BTRFS_SETGET_FUNCS(block_group_v2_identity_remap_count, struct=20
>> btrfs_block_group_item_v2,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 identity_r=
emap_count, 32);
>> +
>> =C2=A0 /* struct btrfs_free_space_info */
>> =C2=A0 BTRFS_SETGET_FUNCS(free_space_extent_count, struct=20
>> btrfs_free_space_info,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 extent_count, 32);
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>> index 5b0cb04b2b93..6a2aa792ccb2 100644
>> --- a/fs/btrfs/block-group.c
>> +++ b/fs/btrfs/block-group.c
>> @@ -2351,7 +2351,7 @@ static int=20
>> check_chunk_block_group_mappings(struct btrfs_fs_info *fs_info)
>> =C2=A0 }
>> =C2=A0 static int read_one_block_group(struct btrfs_fs_info *info,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct btrfs_block_group_item *bgi,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct btrfs_block_group_item_v2 *bgi,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct btrfs_key *key,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int need_clear)
>> =C2=A0 {
>> @@ -2366,11 +2366,16 @@ static int read_one_block_group(struct=20
>> btrfs_fs_info *info,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cache->length =3D key->offset;
>> -=C2=A0=C2=A0=C2=A0 cache->used =3D btrfs_stack_block_group_used(bgi);
>> +=C2=A0=C2=A0=C2=A0 cache->used =3D btrfs_stack_block_group_v2_used(bgi);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cache->commit_used =3D cache->used;
>> -=C2=A0=C2=A0=C2=A0 cache->flags =3D btrfs_stack_block_group_flags(bgi);
>> -=C2=A0=C2=A0=C2=A0 cache->global_root_id =3D btrfs_stack_block_group_ch=
unk_objectid(bgi);
>> +=C2=A0=C2=A0=C2=A0 cache->flags =3D btrfs_stack_block_group_v2_flags(bg=
i);
>> +=C2=A0=C2=A0=C2=A0 cache->global_root_id =3D=20
>> btrfs_stack_block_group_v2_chunk_objectid(bgi);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cache->space_info =3D btrfs_find_space_in=
fo(info, cache->flags);
>> +=C2=A0=C2=A0=C2=A0 cache->remap_bytes =3D btrfs_stack_block_group_v2_re=
map_bytes(bgi);
>> +=C2=A0=C2=A0=C2=A0 cache->commit_remap_bytes =3D cache->remap_bytes;
>> +=C2=A0=C2=A0=C2=A0 cache->identity_remap_count =3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_stack_block_group_v2_i=
dentity_remap_count(bgi);
>> +=C2=A0=C2=A0=C2=A0 cache->commit_identity_remap_count =3D cache->identi=
ty_remap_count;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_free_space_tree_thresholds(cache);
>> @@ -2435,7 +2440,7 @@ static int read_one_block_group(struct=20
>> btrfs_fs_info *info,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (cache->length =3D=3D cache->us=
ed) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cache->cached =3D=
 BTRFS_CACHE_FINISHED;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_free_exclud=
ed_extents(cache);
>> -=C2=A0=C2=A0=C2=A0 } else if (cache->used =3D=3D 0) {
>> +=C2=A0=C2=A0=C2=A0 } else if (cache->used =3D=3D 0 && cache->remap_byte=
s =3D=3D 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cache->cached =3D=
 BTRFS_CACHE_FINISHED;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_add=
_new_free_space(cache, cache->start,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 cache->start + cache->length, NULL);
>> @@ -2455,7 +2460,8 @@ static int read_one_block_group(struct=20
>> btrfs_fs_info *info,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_avail_alloc_bits(info, cache->flags);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (btrfs_chunk_writeable(info, cache->st=
art)) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cache->used =3D=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cache->used =3D=3D 0 && =
cache->identity_remap_count =3D=3D 0 &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cach=
e->remap_bytes =3D=3D 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ASSERT(list_empty(&cache->bg_list));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (btrfs_test_opt(info, DISCARD_ASYNC))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_discard_queue_work(&info->discard_ctl,=
 cache);
>> @@ -2559,9 +2565,10 @@ int btrfs_read_block_groups(struct=20
>> btrfs_fs_info *info)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 need_clear =3D 1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (1) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_block_group_ite=
m bgi;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_block_group_ite=
m_v2 bgi;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct extent_buf=
fer *leaf;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int slot;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t size;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D find_firs=
t_block_group(info, path, &key);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret > 0)
>> @@ -2572,8 +2579,16 @@ int btrfs_read_block_groups(struct=20
>> btrfs_fs_info *info)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 leaf =3D path->no=
des[0];
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 slot =3D path->sl=
ots[0];
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (btrfs_fs_incompat(info, =
REMAP_TREE)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size=
 =3D sizeof(struct btrfs_block_group_item_v2);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size=
 =3D sizeof(struct btrfs_block_group_item);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrf=
s_set_stack_block_group_v2_remap_bytes(&bgi, 0);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrf=
s_set_stack_block_group_v2_identity_remap_count(&bgi,=20
>> 0);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 read_extent_buffe=
r(leaf, &bgi, btrfs_item_ptr_offset(leaf,=20
>> slot),
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(bgi));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_item_key_to=
_cpu(leaf, &key, slot);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_release_pat=
h(path);
>> @@ -2643,25 +2658,38 @@ static int insert_block_group_item(struct=20
>> btrfs_trans_handle *trans,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_block_group *=
block_group)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_fs_info *fs_info =3D trans->=
fs_info;
>> -=C2=A0=C2=A0=C2=A0 struct btrfs_block_group_item bgi;
>> +=C2=A0=C2=A0=C2=A0 struct btrfs_block_group_item_v2 bgi;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_root *root =3D btrfs_block_g=
roup_root(fs_info);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_key key;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 old_commit_used;
>> +=C2=A0=C2=A0=C2=A0 size_t size;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&block_group->lock);
>> -=C2=A0=C2=A0=C2=A0 btrfs_set_stack_block_group_used(&bgi, block_group->=
used);
>> -=C2=A0=C2=A0=C2=A0 btrfs_set_stack_block_group_chunk_objectid(&bgi,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 block_group->global_root_id);
>> -=C2=A0=C2=A0=C2=A0 btrfs_set_stack_block_group_flags(&bgi, block_group-=
>flags);
>> +=C2=A0=C2=A0=C2=A0 btrfs_set_stack_block_group_v2_used(&bgi, block_grou=
p->used);
>> +=C2=A0=C2=A0=C2=A0 btrfs_set_stack_block_group_v2_chunk_objectid(&bgi,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block_group->global_root_id);
>> +=C2=A0=C2=A0=C2=A0 btrfs_set_stack_block_group_v2_flags(&bgi, block_gro=
up->flags);
>> +=C2=A0=C2=A0=C2=A0 btrfs_set_stack_block_group_v2_remap_bytes(&bgi,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 block_group->remap_bytes);
>> +=C2=A0=C2=A0=C2=A0 btrfs_set_stack_block_group_v2_identity_remap_count(=
&bgi,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block_group->identity_remap_c=
ount);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 old_commit_used =3D block_group->commit_u=
sed;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block_group->commit_used =3D block_group-=
>used;
>> +=C2=A0=C2=A0=C2=A0 block_group->commit_remap_bytes =3D block_group->rem=
ap_bytes;
>> +=C2=A0=C2=A0=C2=A0 block_group->commit_identity_remap_count =3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block_group->identity_remap_=
count;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key.objectid =3D block_group->start;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key.type =3D BTRFS_BLOCK_GROUP_ITEM_KEY;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key.offset =3D block_group->length;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock(&block_group->lock);
>> -=C2=A0=C2=A0=C2=A0 ret =3D btrfs_insert_item(trans, root, &key, &bgi, s=
izeof(bgi));
>> +=C2=A0=C2=A0=C2=A0 if (btrfs_fs_incompat(fs_info, REMAP_TREE))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size =3D sizeof(struct btrfs=
_block_group_item_v2);
>> +=C2=A0=C2=A0=C2=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size =3D sizeof(struct btrfs=
_block_group_item);
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D btrfs_insert_item(trans, root, &key, &bgi, s=
ize);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&block_=
group->lock);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block_group->comm=
it_used =3D old_commit_used;
>> @@ -3116,10 +3144,12 @@ static int update_block_group_item(struct=20
>> btrfs_trans_handle *trans,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_root *root =3D btrfs_block_g=
roup_root(fs_info);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long bi;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct extent_buffer *leaf;
>> -=C2=A0=C2=A0=C2=A0 struct btrfs_block_group_item bgi;
>> +=C2=A0=C2=A0=C2=A0 struct btrfs_block_group_item_v2 bgi;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_key key;
>> -=C2=A0=C2=A0=C2=A0 u64 old_commit_used;
>> -=C2=A0=C2=A0=C2=A0 u64 used;
>> +=C2=A0=C2=A0=C2=A0 u64 old_commit_used, old_commit_remap_bytes;
>> +=C2=A0=C2=A0=C2=A0 u32 old_commit_identity_remap_count;
>> +=C2=A0=C2=A0=C2=A0 u64 used, remap_bytes;
>> +=C2=A0=C2=A0=C2=A0 u32 identity_remap_count;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Block group items update can be t=
riggered out of commit=20
>> transaction
>> @@ -3129,13 +3159,21 @@ static int update_block_group_item(struct=20
>> btrfs_trans_handle *trans,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&cache->lock);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 old_commit_used =3D cache->commit_used;
>> +=C2=A0=C2=A0=C2=A0 old_commit_remap_bytes =3D cache->commit_remap_bytes;
>> +=C2=A0=C2=A0=C2=A0 old_commit_identity_remap_count =3D cache-=20
>> >commit_identity_remap_count;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 used =3D cache->used;
>> -=C2=A0=C2=A0=C2=A0 /* No change in used bytes, can safely skip it. */
>> -=C2=A0=C2=A0=C2=A0 if (cache->commit_used =3D=3D used) {
>> +=C2=A0=C2=A0=C2=A0 remap_bytes =3D cache->remap_bytes;
>> +=C2=A0=C2=A0=C2=A0 identity_remap_count =3D cache->identity_remap_count;
>> +=C2=A0=C2=A0=C2=A0 /* No change in values, can safely skip it. */
>> +=C2=A0=C2=A0=C2=A0 if (cache->commit_used =3D=3D used &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cache->commit_remap_bytes =
=3D=3D remap_bytes &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cache->commit_identity_remap=
_count =3D=3D identity_remap_count) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock(&cach=
e->lock);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cache->commit_used =3D used;
>> +=C2=A0=C2=A0=C2=A0 cache->commit_remap_bytes =3D remap_bytes;
>> +=C2=A0=C2=A0=C2=A0 cache->commit_identity_remap_count =3D identity_rema=
p_count;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock(&cache->lock);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key.objectid =3D cache->start;
>> @@ -3151,11 +3189,23 @@ static int update_block_group_item(struct=20
>> btrfs_trans_handle *trans,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 leaf =3D path->nodes[0];
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bi =3D btrfs_item_ptr_offset(leaf, path->=
slots[0]);
>> -=C2=A0=C2=A0=C2=A0 btrfs_set_stack_block_group_used(&bgi, used);
>> -=C2=A0=C2=A0=C2=A0 btrfs_set_stack_block_group_chunk_objectid(&bgi,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 cache->global_root_id);
>> -=C2=A0=C2=A0=C2=A0 btrfs_set_stack_block_group_flags(&bgi, cache->flags=
);
>> -=C2=A0=C2=A0=C2=A0 write_extent_buffer(leaf, &bgi, bi, sizeof(bgi));
>> +=C2=A0=C2=A0=C2=A0 btrfs_set_stack_block_group_v2_used(&bgi, used);
>> +=C2=A0=C2=A0=C2=A0 btrfs_set_stack_block_group_v2_chunk_objectid(&bgi,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cache->global_root_id);
>> +=C2=A0=C2=A0=C2=A0 btrfs_set_stack_block_group_v2_flags(&bgi, cache->fl=
ags);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (btrfs_fs_incompat(fs_info, REMAP_TREE)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_set_stack_block_group_=
v2_remap_bytes(&bgi,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cache->remap_bytes);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_set_stack_block_group_=
v2_identity_remap_count(&bgi,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cache=
->identity_remap_count);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 write_extent_buffer(leaf, &b=
gi, bi,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(struct btrfs_block_gro=
up_item_v2));
>> +=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 write_extent_buffer(leaf, &b=
gi, bi,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(struct btrfs_block_gro=
up_item));
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> =C2=A0 fail:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_release_path(path);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> @@ -3170,6 +3220,9 @@ static int update_block_group_item(struct=20
>> btrfs_trans_handle *trans,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0 && ret !=3D -ENOENT) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&cache-=
>lock);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cache->commit_use=
d =3D old_commit_used;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cache->commit_remap_bytes =
=3D old_commit_remap_bytes;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cache->commit_identity_remap=
_count =3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 old_=
commit_identity_remap_count;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock(&cach=
e->lock);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
>> index 9de356bcb411..c484118b8b8d 100644
>> --- a/fs/btrfs/block-group.h
>> +++ b/fs/btrfs/block-group.h
>> @@ -127,6 +127,8 @@ struct btrfs_block_group {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 flags;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 cache_generation;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 global_root_id;
>> +=C2=A0=C2=A0=C2=A0 u64 remap_bytes;
>> +=C2=A0=C2=A0=C2=A0 u32 identity_remap_count;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * The last committed used bytes of =
this block group, if the=20
>> above @used
>> @@ -134,6 +136,15 @@ struct btrfs_block_group {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * group item of this block group.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 commit_used;
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * The last committed remap_bytes value of this=
 block group.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 u64 commit_remap_bytes;
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * The last commited identity_remap_count value=
 of this block group.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 u32 commit_identity_remap_count;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If the free space extent count ex=
ceeds this number, convert=20
>> the block
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * group to bitmaps.
>> @@ -275,7 +286,8 @@ static inline bool btrfs_is_block_group_used(const=20
>> struct btrfs_block_group *bg)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lockdep_assert_held(&bg->lock);
>> -=C2=A0=C2=A0=C2=A0 return (bg->used > 0 || bg->reserved > 0 || bg->pinn=
ed > 0);
>> +=C2=A0=C2=A0=C2=A0 return (bg->used > 0 || bg->reserved > 0 || bg->pinn=
ed > 0 ||
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bg->remap_bytes > 0);
>> =C2=A0 }
>> =C2=A0 static inline bool btrfs_is_block_group_data_only(const struct=20
>> btrfs_block_group *block_group)
>> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
>> index fd83df06e3fb..25311576fab6 100644
>> --- a/fs/btrfs/tree-checker.c
>> +++ b/fs/btrfs/tree-checker.c
>> @@ -687,6 +687,7 @@ static int check_block_group_item(struct=20
>> extent_buffer *leaf,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 chunk_objectid;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 flags;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 type;
>> +=C2=A0=C2=A0=C2=A0 size_t exp_size;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Here we don't really care about a=
lignment since extent=20
>> allocator can
>> @@ -698,10 +699,15 @@ static int check_block_group_item(struct=20
>> extent_buffer *leaf,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EUCLEAN;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 if (unlikely(item_size !=3D sizeof(bgi))) {
>> +=C2=A0=C2=A0=C2=A0 if (btrfs_fs_incompat(fs_info, REMAP_TREE))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exp_size =3D sizeof(struct b=
trfs_block_group_item_v2);
>> +=C2=A0=C2=A0=C2=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exp_size =3D sizeof(struct b=
trfs_block_group_item);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (unlikely(item_size !=3D exp_size)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block_group_err(l=
eaf, slot,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 "invalid item size, have %u expect %zu",
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 item_size, sizeof(bgi));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 item_size, exp_size);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EUCLEAN;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/=20
>> btrfs_tree.h
>> index 9a36f0206d90..500e3a7df90b 100644
>> --- a/include/uapi/linux/btrfs_tree.h
>> +++ b/include/uapi/linux/btrfs_tree.h
>> @@ -1229,6 +1229,14 @@ struct btrfs_block_group_item {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __le64 flags;
>> =C2=A0 } __attribute__ ((__packed__));
>> +struct btrfs_block_group_item_v2 {
>> +=C2=A0=C2=A0=C2=A0 __le64 used;
>> +=C2=A0=C2=A0=C2=A0 __le64 chunk_objectid;
>> +=C2=A0=C2=A0=C2=A0 __le64 flags;
>> +=C2=A0=C2=A0=C2=A0 __le64 remap_bytes;
>> +=C2=A0=C2=A0=C2=A0 __le32 identity_remap_count;
>> +} __attribute__ ((__packed__));
>> +
>> =C2=A0 struct btrfs_free_space_info {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __le32 extent_count;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __le32 flags;
>=20


