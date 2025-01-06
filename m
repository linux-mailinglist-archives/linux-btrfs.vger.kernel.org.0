Return-Path: <linux-btrfs+bounces-10731-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29653A01DC1
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 03:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B142A3A22C4
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 02:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A92C78F2F;
	Mon,  6 Jan 2025 02:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q2NUG+pc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z28K58AY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FAF29A5;
	Mon,  6 Jan 2025 02:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736131489; cv=fail; b=EbVAO7+My7iNxX4coj50/nura1sThoEmOMBSuFqHQts+/Cqh6WAryyMmpdhGxS9PnE3ffHFT99ccbb6DFOkZUm53vmbbpZtrlGtdQcraNKVlBGPKpfO9pd2kbhqglMwxdP/JQj1bUlLxoo4UvuKfrO3iXI6EBMB4wJcNs4nl/zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736131489; c=relaxed/simple;
	bh=DHLACisGkSbMQ7pK5M3E8b80Uk2t1nCz0ioGlc7GAY8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EaH426cs03jEBlWVlaSqESw3g8BoE1iTQSqrrHLl8UiZE9doNeYlsb3YOHOcuJVd03oJGDvwepZTutiwG7g27h5oCr1ourfYnz3WfjLX0+kj+SE37y4NOK52IorV1MJUSpfhkOlZEFXBZnEUAT0xx9wc+Trw1ARgYbtIrs8XBd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q2NUG+pc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z28K58AY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 505NTP1B021036;
	Mon, 6 Jan 2025 02:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XlQ54AiFY/QFcEbS+wRZZYgt34DW6eZuE31hY+iCxS8=; b=
	Q2NUG+pcdwc+dGfEZJEK1qEbyX57k0b2U6oPE5Bg/hr2RIoXHf9xjq4wIQiepRPu
	dgeaP3fMJBkCd90ZXWhn0qI004Ran9Ztgo3DM5un8FpspZem8fUso4/f7+mpGsz8
	YSo1/b3pgcdd+tpHzjLtS/Up0mPDin+RznOEYfM8Scacx1ZzjS8wvfUWTuTAPtjQ
	aErDt6Uu8o0eME0k/l0T7jk/Q0AB8moHeoNlQQWrPizDWXLPBwTSPu1t7BTst10G
	pDaIX4HhypdZxZ9QDilOEeIhIAMamCcvYlFtSRovHknKNF5YZ2y3sTix+Fd1O2R+
	zLuYj/Gu6HeKHKfnFAtWyQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xudc1yt6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jan 2025 02:44:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 505MFqYZ011173;
	Mon, 6 Jan 2025 02:44:43 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xue6hkkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jan 2025 02:44:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQxjH9SHZ7JrpzuR97SJXZMhZO8cryXjSzSZuWcc69Q4djiJDgLsbuD8IflPiM6lgFWeEy3nSxWahm+gy3JrHFgdJUOqirk1JFNeVFqDk7QqA2LYrfTnWpKAO3lxhFvWAV+NoDM2b+w4oUSKhVRo8EVt91HGFbogw882OlMTOuOecv824K6AJGi/EwFSvM2tLwW515S9E+vG0ptZMfQ6FnV/OT7wvKpIw5531mZJlJSB6dR/Li6O4QZ7LAiQBn3jrJkAsMo+TbcaQ3Z9gZgoZTnfVJqju8x/OSOXW3tiEl3U3kTCMZwkpHa2GupI51Z2o3aX+xlvJpENzBy76xNeLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlQ54AiFY/QFcEbS+wRZZYgt34DW6eZuE31hY+iCxS8=;
 b=TGcSO771qyp/l3ieHo34sYcJi7f+4CNGS4SoQtzf8uf3beVc/vUHU5Nvh2aeERDxpwrMLjhps7RYWt6wWImyFDYkSK2qQXWl9E8DTc0PdywlCipF46kACJa8akWpCH+QCkvQY1MgKRuYMc8fIDTEndPvV/N6TPgEliU4poGrts9LGfvLhZK467Q6qLyWgwNwvs7qtPc2MBObYK1qrNKhj4DioR2El+oeaIVTSxZHb08AK18UpVU5SdoxP6JDI2651hmkbhpwyyOFRTW3na5sjj/ozarbsNJ7oPN46X7xznySFiNN9NIQXPjRl079sJBVBBqD5QgMxNi1b+BXrFPnvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlQ54AiFY/QFcEbS+wRZZYgt34DW6eZuE31hY+iCxS8=;
 b=z28K58AYVwlsncQA2c50ZDLzhYeMxizo0z47+nF1AxgzrA7qK/ZVOHIWcbBYHdtUGTQQBeJ4b2SwCcmiTZ5Cn9d1dQilFqj4lCgF5xNV38l/udpiTjCtPgLtg2b9U+kQtWmf8GyTX8OXFr9VsMFK6651uc0NKnMozOhC9zzA3GE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB5081.namprd10.prod.outlook.com (2603:10b6:610:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 02:44:37 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 02:44:37 +0000
Message-ID: <2051b2a4-b9a8-4f09-b2e0-d3ed1d79e919@oracle.com>
Date: Mon, 6 Jan 2025 08:14:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] configure: use pkg-config to find liburing
To: Mark Harmstone <maharmstone@fb.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Cc: neelx@suse.com, Johannes.Thumschirn@wdc.com
References: <20241219145608.3925261-1-maharmstone@fb.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20241219145608.3925261-1-maharmstone@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0180.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB5081:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cdcf008-487f-448c-7e0f-08dd2dfc0f5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzJJZTZvc3ZUVGl5dDlkdlhuY3ZiOCt3a0Y4QWlBRGRTZU9aM3ZQQUVTTkRu?=
 =?utf-8?B?cDFtdjJaRjBSL3pxVG5HM2V6ZjFVQVZ2MGl1ZzZmc3VLU3lSNW01b0s3VkVK?=
 =?utf-8?B?bExHWXZ5NnhubnlXUHFhTjNCby9iaExUcWJvRlNUb2t6K3RmVUdseHRDV09F?=
 =?utf-8?B?eGlCcUczYU1MaUpUK1VickQya05aTWtjUlhJYVVFbVExSjZxSytObkJvWGdn?=
 =?utf-8?B?bjZHT1pvSTJUTEx2L2UvTEFOU1NpNmpDRUg1ZTFNdEJpSGFZeGhtMlU4L1Zm?=
 =?utf-8?B?WUk2WVBLQjdadXVSLzdxckJkTmJ0WTc2enBqenBhdWFUYTFOS0d6V3A1THZx?=
 =?utf-8?B?VmR6NmVwMjFybk0renF2ZXBvbUVTUVpHNk1vbEY0cm9Wbmt6bEFsL29nRjN5?=
 =?utf-8?B?QXUzK2xhWEthSEQ2VDlsVndZL203UGwxYXkrWE5zMmFhVEJLRHRIdTQ2MWdw?=
 =?utf-8?B?VUpzZ0ZqdVZXRVJXMWFqQWJXQ0hoSE9GdnIwS1lJSHUvYTFxRW1GQk1xWVl3?=
 =?utf-8?B?VHNQSWlJV2NJejhGWVVpZTVaQU5zdFhyR1FBZkhlZnR0a0Z3eDBzT2pVb0Fl?=
 =?utf-8?B?ekp4YUcrOHBNcU1UL2E4alF5Z2VYQ0U5a1crL3BYMUJ3QnJCajRFUTdHZjRO?=
 =?utf-8?B?bnJDczIvcjZYUUZ3allzSlN2ZDhYU01LSURwZ0hjNmovbXRZUmFCbng4dkJI?=
 =?utf-8?B?ckVpdmxpMHJuTUNwd05DakpQUWdUVTRFUFY2NWVkM2NlUWxwV01YZnFvNnlh?=
 =?utf-8?B?clRwaVVJRS9BL2ZGSTdwcG82aXgzMlZUU2NUbGV5Lzdjc1BWSlVlanUvMWt1?=
 =?utf-8?B?eW5EUGxzUldsTmFWV0hUZmtsRVM5RVdreHludC8rVTl1S1ptN0l3VDhmbkxS?=
 =?utf-8?B?RElLWjM0SWxzTHVkK0ZXVE9PNVBqK1M0YW0vU2h2L1BJeXc0SjAxZXM0QjJS?=
 =?utf-8?B?L3RYYXRHRWRVMFhEQ0NpZUxmMWRwNFJvWFZKRkRobHFkVWNjdWtnZnlsRk1q?=
 =?utf-8?B?bjNZMHc5UUh1MUFOU1V0TEk4ejd0ckhvNldoWEJGejVCSzBNOExtR09oUGpP?=
 =?utf-8?B?ak5WSXNmbytKMld2T1NSVlRhd0lDaWtVZGY1VmxPdjY0enRRRE84ck80RHd4?=
 =?utf-8?B?VUFQVVozSnJxVGs4Tm1DemhCR1dhRlZqQzg3ZW5jYU1ZM1dVMVdLR0NyckI3?=
 =?utf-8?B?RjJNNFQyNGhqbFBrQ29RcGtiSFdiaUtFSmNYanlLWWJPWnp6VXQ0TmV6NVpH?=
 =?utf-8?B?OWRVVUdEejFqOTQyOHo4S1h5cnVGRTA5TVp3bEJsNzJOZGgvOVFqV3hxNnZV?=
 =?utf-8?B?VmxOOUZhcTJzcWZUaFcrQzJXVWExbnlKK3JMTTNBend3dEVhZjRRb3FhT1hF?=
 =?utf-8?B?U3Q5dWtJZWJHR0JvcjkxUzZZNzM0MHB3dGROS055cGM5dkJFSXRQMVk1Vzg5?=
 =?utf-8?B?eWVrVEFlaW5hKy9TOHpoVVQ4ZzFabmtvOGNsWHZGSDJNWm42cG9nQnRoc29m?=
 =?utf-8?B?YSsxY25HYWVTSDRyNG10dUhmVFdDMmpvK1VoMjFkRHZpNEd6WHM1YjBrY0Er?=
 =?utf-8?B?cmRRbXQzcFpQZC9ScmlYY2o5K3J0QnkrRHVBSU5SV0lhc3J4RWpCd1h4clJa?=
 =?utf-8?B?WHJubms5Z05xb2pCbFFrYzFDZ3Q2ZFc0ZUJ3cFhodXpjcllJd0JLNXNxZGZj?=
 =?utf-8?B?VEJhNGRseUpsQkF3bnEzNSsxNkNqbDF1SU5wRjFFRUFaUXlJZnEyaE5lSVI3?=
 =?utf-8?B?T3BxSVpWdWlXZlBjMXVGUFRQcWkvc3dTckkvamxWTDVKNlhwVEJ0WmxtQk5Y?=
 =?utf-8?B?Nk9YZUpOOXBKV0hhRzE5VEl3NmtONTdTTlM5ZFR3WnQyWDU3MVM1bkxoblVC?=
 =?utf-8?Q?ew87Ty7TY/Sx3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUNvSUh4WHFVTnZhU2hXU0I3QVRsS2NPc0lxUmhzTG0rVVYyRjhvLzk5dXZz?=
 =?utf-8?B?cnAraWtlYnRwOVBac29mZjRRYlo2b2Rib3N5UnVyRzVuTk4xQkhGU2xkdjBk?=
 =?utf-8?B?R1JLQkErTnNTUThQY1dWSlJ2QkU1eERLTkNmVmMxemNieWp1ZGpnT0owclBt?=
 =?utf-8?B?MHZ1YVdHaktlamMwdVRnRC9rZ3V5RVNIWmZHeEthR3h5TGFmclFMTEdiZW45?=
 =?utf-8?B?KytqS2RJbkQwQURna1NSaUNhc3JaVlhZbTRhb0UvdERzR0pmRjI0Nld4K3Jl?=
 =?utf-8?B?NDYzakFOQzVXUnBKTE5Cb0JWSThqVG12blhQTzR4RTg1SzliY3kwYXZab3Zw?=
 =?utf-8?B?RWVqNmwxRlcwdkFSMzI0MTk4U2tINE5FLzRUWkpUdUk4YmFUMjNJYWdMRUta?=
 =?utf-8?B?RVJnekFSY29pZ2JuTUtMOG5Wc1B6YTRTcDFMQzBPMFZEUCs4aUUwWEpENXFE?=
 =?utf-8?B?VkNBNkkva3NwdVB2amI3R3cxb0g2SEZYb3U3Y0ZEVnFUQzhqK2R6SkNqdksz?=
 =?utf-8?B?b0c5aFFLNittRGJsQTdyWUZaTVhUM2xPdGJIbW0rVWxBSXdDR1JZbUc2NGJV?=
 =?utf-8?B?aU5Od3JzU3lYUzAyRkw1NG1oNjhlaUNaQ1Q3QlJTMWVJM2NOS3Z4N09iQjZX?=
 =?utf-8?B?Z1RwWU90Q21LUms2Uy9nbEpqazB5YStYdWFXcFBXblVUM0s0ZVkvSzhlUDRs?=
 =?utf-8?B?MkZGcElWOHN3N1BFbW8zYTQrdWJia3Y4UjFiTGVBZ213d2svWkxyWWl3YU9U?=
 =?utf-8?B?N0pkVGhCMG9RdjhVamFJNmRxcXV4ZktkV3pXVVJDTCtzQ3NuNGFaa0toZUtk?=
 =?utf-8?B?UU5IL2g0QmtjRzVpSFNNNGdyeW1rMWYrblFCbXBGemoxazZlRU91MFdBb3Ev?=
 =?utf-8?B?N0Y4dndUQzRHNVQrT0t1KzY2N1RmUGh1RElpdWRHcGNZU0ZjRFpRS3BlUGFk?=
 =?utf-8?B?Z2xISnM1aDNLZVhUWk5LYUZzNUdRK05DUG56dmUraWhXbHZIRVFBNWZGdlgx?=
 =?utf-8?B?RVh2QzhSMVE1aWJCRkgzVVZXUy84WTRxQTRIejQxTkl2TW9xWTVtM1FZZWV3?=
 =?utf-8?B?QWN3VDFTVng0VzduZTViRkpqdTVJYWhKYlN6Y1hUMW51RHhicmtyRnY0bit2?=
 =?utf-8?B?bDNINmlHQmdpT1pSU2Rwc3dnQmxqeGZuR2tqMDZvSzhmVkxIb1J4NWdSYVlU?=
 =?utf-8?B?Qm0vaTBrc0pUN0hGTjUwN3NUTTdDTGczZk5ydmlkdHVDU01GSzM2RmlUWFgr?=
 =?utf-8?B?SXhIM1ZtZkFoaFRZeUZiZEZzcmRaMUZLb2FMdE9kQjdGTDI4dU5kOG5QS0Fr?=
 =?utf-8?B?NTBaZ004Z2RzWDVBeWxzcXRRdGJuQWh1VHVid3hhZFQ3d3hGcjhTS2FjbE5r?=
 =?utf-8?B?U1hsMk1DZmxJT2FOVW5QRk13Z0oxWHBha3BETzByOVVQa29ybzRWbHBBQ09Q?=
 =?utf-8?B?RFhpcEc3bVFCQWVsei9FUHpHMnFBTnJJUEsvRFBUcVlXUTJablRoR01TTjd1?=
 =?utf-8?B?S25SOFUzREJOdnpPQ0ttNUhYYnNER2M1WkhTdCtKZWpnem9PR1EyV2RZRnlv?=
 =?utf-8?B?NHgvRE9ibHpqNmVVUUhmZkZ1bWdxWUJmL2ErRFJ2TXk4ckRYa0N6RUx1YXNV?=
 =?utf-8?B?MWpEWWU1Z1JoQVBUS0NGVjIzcm0rT3p2U0pJdE9yZlhWL1ZSM3liQzFiTFE5?=
 =?utf-8?B?eDFMb2ZqT0NGTkFoYU1oeVg0N2VETXhBTjZyOWRTOW15Z1czQ0IyWmhpT0hk?=
 =?utf-8?B?VEZwdVVKdGxSQWxQUEpPVmhwQ052NFV1QjZqRGYzSlpuNStKRGo2RGVLWTg5?=
 =?utf-8?B?NS9zd1cwNStPMUQ5TDZaQ2owQnNGVk82bFFqQUZveC9kT0E4L053TEJ0dk80?=
 =?utf-8?B?S3ozQ1pnZExWUi9acE1kWlR0bFprQUpCWjFaclQ3VzV0M05YUFNJMWMzVUNB?=
 =?utf-8?B?NEtZWHVaM0RwU0Rta0F6LzBJdUlNT29zZXc4MExEcDUzRE5UUmd1NDJYeWdy?=
 =?utf-8?B?T0Y0c2dYWjRrd2t3QkNnMm10SU1zbUNpRUdURzJDWjBpTEtGQU1xRkhuK084?=
 =?utf-8?B?Nml6SlBTWlFKQUwybE1WV20xaDFIZ0haSzNpVENtQnFEMzN4UElCcmV5Q3Q3?=
 =?utf-8?B?YXAwTm44YVdYdGRCa3lrMkN6bDVqODZoNWJKZ1I2U1dwWUg0Y0ZuM3B5UlRC?=
 =?utf-8?B?QVZ0U0dpanAzcHFDZmwxYTV4N1hObTVWQnFZM1FtandoZWxqMzNRekg4Wkov?=
 =?utf-8?B?UkxUcm5OZ1cyZE1ZVmlvR1ZKS2hRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LM0esa7zOA68cA4RCgx/wlglqYBkyoNirKr4x+jWQPGjKWCoUW98njFgfmwx25FvF5e29CsGiWVcCw23uuTSvKs/vtxJXQXMTyBAIWhG/nrAzp3z0FEF67c9zH1CmzFD82QCcF0ramjDTDuml4cOXLebGVqt4Z9Z15B92WnDPt1edX+Em3ijvKuHtR8kbP9bMkbDb1CYgTrZQGzYOlao0zWZyykBva/iQzsuyYmdaHwYPFCdSyj+F73N/4OyzJH+NLKYjed3q4kDB/CY4UTK/3SEDQjAx069lKtK3P/QM7EFsDysSdMgClQgRD+SOgIVPHeOKXUa3nC4qmw5jaMOBRtyq2bhXBh+QtAr7Iu3PEyiQGvo8tZhaUbdfabergrvD6QGp2FiiqDznhtcJpUibjLr/1bFeJKArWw8D4/HYeJnlhhvclFV+EgZXFbmbElBL/zJDtjcXLXHoeubiBtM58vbA+aWeNhz32LUVSB/VdqukwYxiJBHYOdItg6d9zY3PK4beF4+P1hTQGDwPRKtzEMIu4c0x62o0zuHHgncD1SFA7KdygUm9PlLdWWqgwiq9jghNw58MUphNSKnp3IbS6QBSOi07nBpFJglSmKwdJ8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cdcf008-487f-448c-7e0f-08dd2dfc0f5a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 02:44:37.2012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5sseN0/wEdWg6aV9G1rOBaizA8aYlL9JTYVAAoNSszdcKGL2C/+t62gB/ePM7YZsod1LyXySXls6xQ0l5As7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501060023
X-Proofpoint-ORIG-GUID: 8FXj4N3Q8_GKxljDkugAY7Gpa9EAVk6K
X-Proofpoint-GUID: 8FXj4N3Q8_GKxljDkugAY7Gpa9EAVk6K

On 19/12/24 20:25, Mark Harmstone wrote:
> Change our autoconf macros so that instead of checking for the presence
> of liburing.h, we use pkg-config.
> 
> The benefit of this is that we can then check the version of liburing,
> and do conditional compilation based on this. There's a macro
> IO_URING_CHECK_VERSION already, but it's only in relatively recent
> versions of liburing.h.
> 
> This replaces HAVE_URING_H, defined by AC_CHECK_HEADERS, with
> HAVE_URING. I also had to rename PKG_{MAJOR,MINOR,REVISION,BUILD} to
> start with PACKAGE_, to avoid "possibly undefined macro" errors; it
> looks like pkg-config assumes that anything called PKG_* is for its own
> use.
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> ---
>   VERSION                         | 8 ++++----
>   m4/package_globals.m4           | 4 ++--
>   m4/package_liburing.m4          | 6 +++++-
>   release.sh                      | 2 +-
>   src/feature.c                   | 4 ++--
>   src/vfs/idmapped-mounts.c       | 6 +++---
>   src/vfs/idmapped-mounts.h       | 2 +-
>   src/vfs/tmpfs-idmapped-mounts.c | 6 +++---
>   src/vfs/utils.c                 | 4 ++--
>   src/vfs/utils.h                 | 6 +++---
>   src/vfs/vfstest.c               | 6 +++---
>   11 files changed, 29 insertions(+), 25 deletions(-)
> 
> diff --git a/VERSION b/VERSION
> index 7294a002..afcab53e 100644
> --- a/VERSION
> +++ b/VERSION
> @@ -1,7 +1,7 @@
>   #
>   # This file is used by configure to get version information
>   #
> -PKG_MAJOR=1
> -PKG_MINOR=1
> -PKG_REVISION=1
> -PKG_BUILD=1
> +PACKAGE_MAJOR=1
> +PACKAGE_MINOR=1
> +PACKAGE_REVISION=1
> +PACKAGE_BUILD=1
> diff --git a/m4/package_globals.m4 b/m4/package_globals.m4
> index ce7a8c51..c8d5d124 100644
> --- a/m4/package_globals.m4
> +++ b/m4/package_globals.m4
> @@ -9,9 +9,9 @@ AC_DEFUN([AC_PACKAGE_GLOBALS],
>       AC_SUBST(pkg_name)
>   
>       . ./VERSION
> -    pkg_version=${PKG_MAJOR}.${PKG_MINOR}.${PKG_REVISION}
> +    pkg_version=${PACKAGE_MAJOR}.${PACKAGE_MINOR}.${PACKAGE_REVISION}
>       AC_SUBST(pkg_version)
> -    pkg_release=$PKG_BUILD
> +    pkg_release=$PACKAGE_BUILD
>       test -z "$BUILD_VERSION" || pkg_release="$BUILD_VERSION"
>       AC_SUBST(pkg_release)
>   
> diff --git a/m4/package_liburing.m4 b/m4/package_liburing.m4
> index c92cc02a..0553966d 100644
> --- a/m4/package_liburing.m4
> +++ b/m4/package_liburing.m4
> @@ -1,4 +1,8 @@
>   AC_DEFUN([AC_PACKAGE_WANT_URING],
> -  [ AC_CHECK_HEADERS(liburing.h, [ have_uring=true ], [ have_uring=false ])
> +  [ PKG_CHECK_MODULES([LIBURING], [liburing],
> +    [ AC_DEFINE([HAVE_LIBURING], [1], [Use liburing])
> +      have_uring=true
> +    ],
> +    [ have_uring=false ])
>       AC_SUBST(have_uring)
>     ])
> diff --git a/release.sh b/release.sh
> index 5b78ec79..70fbf47e 100644
> --- a/release.sh
> +++ b/release.sh
> @@ -5,7 +5,7 @@
>   
>   . ./VERSION
>   
> -version=${PKG_MAJOR}.${PKG_MINOR}.${PKG_REVISION}
> +version=${PACKAGE_MAJOR}.${PACKAGE_MINOR}.${PACKAGE_REVISION}
>   date=`date +"%-d %B %Y"`
>   
>   echo "Cleaning up"
> diff --git a/src/feature.c b/src/feature.c
> index 7e474ce5..7df36acf 100644
> --- a/src/feature.c
> +++ b/src/feature.c
> @@ -42,7 +42,7 @@
>   #include <libaio.h>
>   #endif
>   
> -#ifdef HAVE_LIBURING_H
> +#ifdef HAVE_LIBURING
>   #include <liburing.h>
>   #endif
>   
> @@ -227,7 +227,7 @@ check_aio_support(void)
>   static int
>   check_uring_support(void)
>   {
> -#ifdef HAVE_LIBURING_H
> +#ifdef HAVE_LIBURING
>   	struct io_uring ring;
>   	int err;
>   
> diff --git a/src/vfs/idmapped-mounts.c b/src/vfs/idmapped-mounts.c
> index f4dfc3f3..ed9992f9 100644
> --- a/src/vfs/idmapped-mounts.c
> +++ b/src/vfs/idmapped-mounts.c
> @@ -2206,7 +2206,7 @@ out:
>   }
>   
>   
> -#ifdef HAVE_LIBURING_H
> +#ifdef HAVE_LIBURING
>   int tcore_io_uring_idmapped(const struct vfstest_info *info)
>   {
>   	int fret = -1;
> @@ -2743,7 +2743,7 @@ out_unmap:
>   
>   	return fret;
>   }
> -#endif /* HAVE_LIBURING_H */
> +#endif /* HAVE_LIBURING */
>   
>   /* Validate that protected symlinks work correctly on idmapped mounts. */
>   int tcore_protected_symlinks_idmapped_mounts(const struct vfstest_info *info)
> @@ -8859,7 +8859,7 @@ static const struct test_struct t_idmapped_mounts[] = {
>   	{ tcore_hardlink_crossing_idmapped_mounts,				true,	"cross idmapped mount hardlink",								},
>   	{ tcore_hardlink_from_idmapped_mount,					true,	"hardlinks from idmapped mounts",								},
>   	{ tcore_hardlink_from_idmapped_mount_in_userns,			true,	"hardlinks from idmapped mounts in user namespace",						},
> -#ifdef HAVE_LIBURING_H
> +#ifdef HAVE_LIBURING
>   	{ tcore_io_uring_idmapped,						true,	"io_uring from idmapped mounts",								},
>   	{ tcore_io_uring_idmapped_userns,					true,	"io_uring from idmapped mounts in user namespace",						},
>   	{ tcore_io_uring_idmapped_unmapped,					true,	"io_uring from idmapped mounts with unmapped ids",						},
> diff --git a/src/vfs/idmapped-mounts.h b/src/vfs/idmapped-mounts.h
> index 4a2c7b39..688394c8 100644
> --- a/src/vfs/idmapped-mounts.h
> +++ b/src/vfs/idmapped-mounts.h
> @@ -30,7 +30,7 @@ int tcore_fscaps_idmapped_mounts_in_userns_separate_userns(const struct vfstest_
>   int tcore_hardlink_crossing_idmapped_mounts(const struct vfstest_info *info);
>   int tcore_hardlink_from_idmapped_mount(const struct vfstest_info *info);
>   int tcore_hardlink_from_idmapped_mount_in_userns(const struct vfstest_info *info);
> -#ifdef HAVE_LIBURING_H
> +#ifdef HAVE_LIBURING
>   int tcore_io_uring_idmapped(const struct vfstest_info *info);
>   int tcore_io_uring_idmapped_userns(const struct vfstest_info *info);
>   int tcore_io_uring_idmapped_unmapped(const struct vfstest_info *info);
> diff --git a/src/vfs/tmpfs-idmapped-mounts.c b/src/vfs/tmpfs-idmapped-mounts.c
> index 0899aed9..d8212bce 100644
> --- a/src/vfs/tmpfs-idmapped-mounts.c
> +++ b/src/vfs/tmpfs-idmapped-mounts.c
> @@ -167,7 +167,7 @@ static int tmpfs_hardlink_from_idmapped_mount_in_userns(const struct vfstest_inf
>   	return tmpfs_nested_mount_setup(info, tcore_hardlink_from_idmapped_mount_in_userns);
>   }
>   
> -#ifdef HAVE_LIBURING_H
> +#ifdef HAVE_LIBURING
>   static int tmpfs_io_uring_idmapped(const struct vfstest_info *info)
>   {
>   	return tmpfs_nested_mount_setup(info, tcore_io_uring_idmapped);
> @@ -184,7 +184,7 @@ static int tmpfs_io_uring_idmapped_unmapped_userns(const struct vfstest_info *in
>   {
>   	return tmpfs_nested_mount_setup(info, tcore_io_uring_idmapped_unmapped_userns);
>   }
> -#endif /* HAVE_LIBURING_H */
> +#endif /* HAVE_LIBURING */
>   
>   static int tmpfs_protected_symlinks_idmapped_mounts(const struct vfstest_info *info)
>   {
> @@ -272,7 +272,7 @@ static const struct test_struct t_tmpfs[] = {
>   	{ tmpfs_hardlink_crossing_idmapped_mounts,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs cross idmapped mount hardlink",								},
>   	{ tmpfs_hardlink_from_idmapped_mount,					T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs hardlinks from idmapped mounts",								},
>   	{ tmpfs_hardlink_from_idmapped_mount_in_userns,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs hardlinks from idmapped mounts in user namespace",						},
> -#ifdef HAVE_LIBURING_H
> +#ifdef HAVE_LIBURING
>   	{ tmpfs_io_uring_idmapped,						T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs io_uring from idmapped mounts",								      },
>   	{ tmpfs_io_uring_idmapped_userns,					T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs io_uring from idmapped mounts in user namespace",					      },
>   	{ tmpfs_io_uring_idmapped_unmapped,					T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs io_uring from idmapped mounts with unmapped ids",					      },
> diff --git a/src/vfs/utils.c b/src/vfs/utils.c
> index 0ab5de15..c1c7951c 100644
> --- a/src/vfs/utils.c
> +++ b/src/vfs/utils.c
> @@ -502,7 +502,7 @@ out:
>   	return fret;
>   }
>   
> -#ifdef HAVE_LIBURING_H
> +#ifdef HAVE_LIBURING
>   int io_uring_openat_with_creds(struct io_uring *ring, int dfd, const char *path,
>   			       int cred_id, bool with_link, int *ret_cqe)
>   {
> @@ -555,7 +555,7 @@ int io_uring_openat_with_creds(struct io_uring *ring, int dfd, const char *path,
>   out:
>   	return ret;
>   }
> -#endif /* HAVE_LIBURING_H */
> +#endif /* HAVE_LIBURING */
>   
>   /* caps_up - raise all permitted caps */
>   int caps_up(void)
> diff --git a/src/vfs/utils.h b/src/vfs/utils.h
> index 872fd96f..c086885a 100644
> --- a/src/vfs/utils.h
> +++ b/src/vfs/utils.h
> @@ -25,7 +25,7 @@
>   #include <sys/capability.h>
>   #endif
>   
> -#ifdef HAVE_LIBURING_H
> +#ifdef HAVE_LIBURING
>   #include <liburing.h>
>   #endif
>   
> @@ -349,11 +349,11 @@ static inline bool switch_fsids(uid_t fsuid, gid_t fsgid)
>   	return true;
>   }
>   
> -#ifdef HAVE_LIBURING_H
> +#ifdef HAVE_LIBURING
>   extern int io_uring_openat_with_creds(struct io_uring *ring, int dfd,
>   				      const char *path, int cred_id,
>   				      bool with_link, int *ret_cqe);
> -#endif /* HAVE_LIBURING_H */
> +#endif /* HAVE_LIBURING */
>   
>   extern int chown_r(int fd, const char *path, uid_t uid, gid_t gid);
>   extern int rm_r(int fd, const char *path);
> diff --git a/src/vfs/vfstest.c b/src/vfs/vfstest.c
> index f842117d..e0c897bb 100644
> --- a/src/vfs/vfstest.c
> +++ b/src/vfs/vfstest.c
> @@ -1222,7 +1222,7 @@ out:
>   	return fret;
>   }
>   
> -#ifdef HAVE_LIBURING_H
> +#ifdef HAVE_LIBURING
>   static int io_uring(const struct vfstest_info *info)
>   {
>   	int fret = -1;
> @@ -1495,7 +1495,7 @@ out_unmap:
>   
>   	return fret;
>   }
> -#endif /* HAVE_LIBURING_H */
> +#endif /* HAVE_LIBURING */
>   
>   /* The following tests are concerned with setgid inheritance. These can be
>    * filesystem type specific. For xfs, if a new file or directory or node is
> @@ -2349,7 +2349,7 @@ static const struct option longopts[] = {
>   static const struct test_struct t_basic[] = {
>   	{ fscaps,							T_REQUIRE_USERNS,	"fscaps on regular mounts",									},
>   	{ hardlink_crossing_mounts,					0,			"cross mount hardlink",										},
> -#ifdef HAVE_LIBURING_H
> +#ifdef HAVE_LIBURING
>   	{ io_uring,							0,			"io_uring",											},
>   	{ io_uring_userns,						T_REQUIRE_USERNS,	"io_uring in user namespace",									},
>   #endif


Looks good. This can be integrated independent of the 2/2.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thx.


