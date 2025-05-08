Return-Path: <linux-btrfs+bounces-13835-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AD4AAFD48
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 16:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B23F9E1F16
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 14:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC8B272E64;
	Thu,  8 May 2025 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ZIookDus"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710541D6195
	for <linux-btrfs@vger.kernel.org>; Thu,  8 May 2025 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746714832; cv=fail; b=KI4P/JXVQFiezgDJ1eJN87eS+ZjhI15+fMGdWS0ckgWsqDx3f3bS4SFDc+c4bUcmaguIAC9+dCw5/y3HH9r/Tntgc5H3qldU9JdAgr0gunOdzAWLk7T70KMJjuoxUsFswPfNrRnadY0OP2CaQ8OnddDSjVEJSBQEIhuExk1/CH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746714832; c=relaxed/simple;
	bh=CD9z0PLwv6q2KEHiOOzzVvqQQvKxE3sJtJA1HrUiuiI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jc9sIK9byqCaZFk48TX92Nug5IlJ7KCv7iQVat8Dgxlyjyqf0oZRNehwUMgvc3bkOI/V0TJM6L7/XPNo2qUt5+8roJN6Wag/CYZN8LyTXNdCkADWOmsZRcTVWBs7MvlDGHyvIXkA25/c1xTWijebIi+4PCKtSo3mSGSDnrniNpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ZIookDus; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54871uk3008273;
	Thu, 8 May 2025 07:33:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=nojk+E3YnN7vUCj5Ttf/a0QBe/Fje8zq3UA0A+S6+Po=; b=ZIookDusOm1n
	ECt0r7eulxv0MAHZfjOEy5Gq/IaRl8SVf0EAVeki52oL7dLquyLwN0dyTJ1Yxdzs
	PY8WhHdx2FsOY8CNaxJ49T0AC490aAfqV/JUXmOQiV8hBTOJkajwrOmpMLTWeI6T
	5g+upe26Oy/dQ7OQy+GTq2IrFpoPbhA0Fj9aUC2RD4XJz4/LkqUqtbMNtWP+OeSI
	yuNXdGNNZwvBPE167r4wKzX0EcNFDlrDsI+40LhGtv/hvLYtVar7gbv8yJ9uxVNY
	KMvz2/FUBmlveyrdxl2bDX5O2nRDwMpOAiBoGd+hICZD0O5qnAfjgQplP99qMS6o
	c4JwdvUnlw==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46gmfg3ddw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 07:33:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUTDOxZ5ugXL1RhGTxSJKq6WpRXCYtjBSOfuVSDH820jSAep+8myqC9X3fF8AHhzwRVMna7nPYjgvFK3pq5L9Gco9VjxisXmVqdlKqCWnEWyt6iwNxs5By50NV3uIi32yEO0ncbkdxgByJk/KHwvYXtZYcmS1DqRI+NzK+yJgni7jfgBGLcyLIl2+t7gke5TXPtCIgMmiFe6kDTJBiIzvWjg4XA8Ej9FQwH9PYoPkYUz9NKu3GG7rHX396YXzDEQ7guE1O8qIhrOwN80ECEYoO4wA/0Jan5MUfGSwAN4ZZz0IoQn4CzkmSLDThPkccP9+2QHVAwaoOL8DyFW3Ht0mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nojk+E3YnN7vUCj5Ttf/a0QBe/Fje8zq3UA0A+S6+Po=;
 b=HFQH9e3XPz+hHK3kW7yYl3YGBCdfe/iI/373Her3GK1ybpe5pLjLjtrLMkStvL8JwIwGL+tC+T4I42bkmchtbv0KhlgJ0y1xZUvzsULX/v2/3gX04AUp55d5tqvwjc9PJ/HCzIby7EW5QKs/n/fjvvtIZxxX0CeWFAW6gJA14tbgsH7U3YdMR0LGEmJbsA9+13sTOrz8hzlE2XE/smg+xkW/5gZczPWKlA9dChK/TlvRQlVILiALl/DPYcox/S7EzJP1tjwZHd7O1VFKRjmzCZam7YDl2L3NkFCPxZ2jrnIRaKqrnDuTMXSUoYsXFydNYoNQRm7LtuSSnx9bD/vR6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by DS0PR15MB5550.namprd15.prod.outlook.com (2603:10b6:8:139::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 14:33:33 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::595a:4648:51bc:d6e0]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::595a:4648:51bc:d6e0%7]) with mapi id 15.20.8722.021; Thu, 8 May 2025
 14:33:33 +0000
Message-ID: <2d1a8e78-b57a-4726-a566-4d916a36be8f@meta.com>
Date: Thu, 8 May 2025 10:33:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: What is the point of the wbc->for_kupdate check in
 btree_writepages
To: Christoph Hellwig <hch@infradead.org>, Chris Mason <clm@fb.com>
Cc: linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-mm@kvack.org
References: <aBxJ8uBi5Cgz-CPu@infradead.org>
Content-Language: en-US
From: Chris Mason <clm@meta.com>
In-Reply-To: <aBxJ8uBi5Cgz-CPu@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0085.namprd03.prod.outlook.com
 (2603:10b6:610:cc::30) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|DS0PR15MB5550:EE_
X-MS-Office365-Filtering-Correlation-Id: 3540acc1-8544-492c-63aa-08dd8e3d4f8e
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUwxcWtoZnVuVVFnQjhXanFpbU5nckVwOFZRa3k3MXZHdEFtTzQrckVQWnFF?=
 =?utf-8?B?OUo0bEQ1WGdDWTNZZ0dGZ2gyazd3TlJCSjdVWWt4czRmVm9TWU1mVXlqSzNk?=
 =?utf-8?B?Ym5iMk5OTUVSZmNlOWR6VnpIZzNGb3FqSGppbmpXclJQQTIrMm51OXM0M0dD?=
 =?utf-8?B?cnVzeU82TUlDZWpMcm1HUUVvVlB6VlUwdUVXUEhJN1Q0OS9jZWdOaDNzVktt?=
 =?utf-8?B?R0h2Q0xwVHZaSGkxL1hMcWRMU0Qrcjc5cjVJSVlUSUZzdlhCYW1QNkNIcjZO?=
 =?utf-8?B?ZVlPSWJ5TFBBTU9aRnVnT25BaDVGQ3UwYTZnV3llNW1PamtyUGllQm9SMkZT?=
 =?utf-8?B?SHpYQWh1R0xOL2paWWF4WjlkQ3JmNU5MMnJYaktYbUVMUnNOUVNmdnJORXk0?=
 =?utf-8?B?dW9Ed0tDUWxOOFVvNDgzOERlbkpaQW1KNngzYnVNRWg2dlBFYnpCaXpWM042?=
 =?utf-8?B?VHRPUmdiTXppMklGQzd3MWJXcnJEL295MGUyWGFYWmhodkVINVBtY1llcHhX?=
 =?utf-8?B?L1hnWnYwMmFoWEs5OGc3S2JuZzJKSllPb0NmQWRBYUFFTHhuNmU5bFpuOGlB?=
 =?utf-8?B?MURNOThSRGhtNEpYUTlTbmpnRUw2dmpUOVd1QlVJblN2RFlZRHlFS3huVnl1?=
 =?utf-8?B?b1FOdlUzTmpSR1ZObnh2dGNyVjJqd3NIVEdjZ3lGVjFBUFM2VmZya0xRUExs?=
 =?utf-8?B?UC9MNFhsbkJFRXgzcFE1bFVVOE9uS2VPQ3lvbHd2bnZrNXo4ajlrWU1tZU5N?=
 =?utf-8?B?Y1JsZlJUNmxKc3Jadkk5VDJPNnUvbDRJUWlKc0VkS3dGREQ5a01zSUlhbExW?=
 =?utf-8?B?dkdFZXdFRmFnZHhrMXMwZ2ozaVVEbndTdFFHUDdyLzN0WVdhZlM1ZXJCcFgz?=
 =?utf-8?B?OFNjR3kxMDVQd00weUxoUUpzaXQxbVVnSnVPeCtrSEJkTk5MdzJRZkF6RTVJ?=
 =?utf-8?B?Qk1XUWgzaWhKTmk1dFZwU21TVkE4RHNmaDJkb09VRzNlTGZKcFFFTnBSMys0?=
 =?utf-8?B?b0dvVWhPdlhwdU5WVm54UjBObzFOYlA3U0loOGZxWkNncmp4WStvZTF5ZlpB?=
 =?utf-8?B?dEs4RkhBRDF0ZDJwTDFVblR4a0ZXNmpxQUlnOTdvS2Zicldyd3NDQUdaREFS?=
 =?utf-8?B?bEV6L2hFVUs2ODBKL29YTEVwZzJmQ1VrRFZrV211blhuMk1ieTVDRm5VVWpL?=
 =?utf-8?B?TlJvYzh5ZFQzOTkzSnd1NlFvUVdJNG84NXpOSEFydnNnWXExTzJ6UFl0RGV3?=
 =?utf-8?B?TkFjbHlRZWxZaTVGeGZyRDIyRlE0bUc1SUJocVphY1NaUlJpVSt2R2xHS1h0?=
 =?utf-8?B?RFJCOUkwc3dsM1ZNdWlVWHY1WVdTUkdNbm53Nzllam1LSzVya3dodnZMQ0M1?=
 =?utf-8?B?aVVQUk1SODk1L3lhNXJzSnMrTXpySnNCK0NOZ3hmQ2d0bWdOVTdVT2xhbVdL?=
 =?utf-8?B?TGFwdFpZeGJMSjdSR2lEN0tvT2ZQTjQ2ZWNOZlFQNW5pS0ZFUGVjYnBwY3V1?=
 =?utf-8?B?aWlEMXljK2ExSnVBSTJ3MmtCZldRa1U0cmtDaXI0UHpnZUovZXJCVXBwbXBj?=
 =?utf-8?B?dnJHdUxWN3c0U0dQOWhBMHRQSzVkaUo5Z0FhSmlJMXhDZjJEa2FvT2c2RzJQ?=
 =?utf-8?B?MmZJZHNnYm5oSzRwcW1oeVV2emFXRlptbEhDbkRna1hvUGdzbTQ0eDJ4UEVV?=
 =?utf-8?B?QkJrQ3hiR2tndlczUlJUb2JYS0ZMSFI4MVptYW9ncml2QXIyZUw5QjNsdVRh?=
 =?utf-8?B?YlE1ajdMMDZGazZWUno2T0JTU2tJM0dCV3l5VWN1dFI2aEphdnF0NGhUdHhG?=
 =?utf-8?B?S2lHcnFpNWNvR1JJdHdsM2ZlRDYxd01hUTlyek1tR0ZvSC9Ta21VQWthTG9Z?=
 =?utf-8?B?VURoR0llM29hS1VtbWM1WlhtN1J5Z1ZwRlZ1QWxDcmNjOFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFVQL284QkhHemJoR2Uza09UY2IyRGxBOHI2dm5NUkpEbXlLZmN5YlptWTBl?=
 =?utf-8?B?V2JHOWR5TkVCQVhLRk52L0c4dWxnT3ZHeVBZMHRlNGszR3JpY2tOUTRqU3JL?=
 =?utf-8?B?Sm1MV2VwZlFudnBMamtCd0FUZGpmVUMyMTBNN0xpNjhtUHI1LzIwWEpoSElL?=
 =?utf-8?B?ZnNjQVl1SXFQRFhVZnFuZk0wV2FjZVlWMUxadWZ6NnUrTjROTHhuRy93NFdl?=
 =?utf-8?B?b0dGcWUrZVNqa3BBanE0UWRyQkRTUHRRZ0Y5OXQ4M1JNdGJ6cUlOVEo2amNP?=
 =?utf-8?B?SmMxdG9CMm9YOHpqaEF2Mk9EWmk3a216eFQ5dlpld2Y5ZjdPUVBZOHNCR3JK?=
 =?utf-8?B?VDk2UmxuZVdjbjAyNUd0bmUwMHJlK0U5anJ0YkFCT1RHV1BFRnkxRVhuSmo4?=
 =?utf-8?B?a3R2VVdmZ3JOSndOOExVOHlzaTBld0EyaGRTWXpYRnZRR0QxakVSYjAvcGp4?=
 =?utf-8?B?SWpBWlI5SGtVSmYwWXIyaUpWcm1tOG5YU1RwSEJIemlCdVgzL05iNGJuUk9n?=
 =?utf-8?B?ZmlQSWh6L3VGaWg4Y0tZR2FwYUwxMmpDaWhGWS9GYTBvR0g1MnB5QnEzTzRH?=
 =?utf-8?B?RWd3QThCRENOU282VW1UYys1RUJUYlVyOGN3L0lVaExrQlpTVWlybDRyOWVC?=
 =?utf-8?B?R3A2eVZTWS8vOWhzL1N4amh0ODZ2QTlBWXdDTEpkYmlmMUtiWGRSd1N0eGw2?=
 =?utf-8?B?b2paZFJOaXBqa2JTeUJxOVZUVFRmMmwyRG5QRmhIbzlTZTdyTmx5VlpDVlBW?=
 =?utf-8?B?bjJoUVBrWk5Rd0dwUXRXME5LaEVuQnUrKzRyMkl6c2xHZjVpYmwxRW5MUzhN?=
 =?utf-8?B?eWNXVWhXdCtLOXRzdFYzTEZoNUJTSDY0SVVJZC83VjZ6aHM2b1pTQzI4Vmlp?=
 =?utf-8?B?aURSYndmQVVIR0hBc010WnR6Z2U2Q1prcEt3RGtiNmk4bTVnMWtwclA2TnRG?=
 =?utf-8?B?NjREZWlkOTM3T0QzblNyVDFqcHVrVkQ2aVlRUXFtRm5yRjhIOVlZS05VelQ3?=
 =?utf-8?B?NDVGYS9lbG4yajdFUndSbHJ6UW9yeGxveEd5RGdSakh0VTdkNUZiaGlKY3Qx?=
 =?utf-8?B?V25nTjlzNWRkWmo2NThvUXh6bm9BbFpPMHRhZXo3LzFvc0x4Sm5QR3hiNGRL?=
 =?utf-8?B?UXIybDF0M3RDRWRtNXVqL2tTcGl4bXVMSmMyZzVxbUU1UUk0V29JQWxPRFg4?=
 =?utf-8?B?bHNyMHRKM0w0amhmWkZsT0w4K1FveDZwQW1BZTdGQldDTmxsNXRmQ3YrVm9H?=
 =?utf-8?B?ZGE5eWhEVitmUlRiby9aaVFTeTRBNGFsWExBdG5vMVpQYU9waGFPR0NpckJP?=
 =?utf-8?B?cWRmVFJWeURObTl5cy9sMWdJd1RSWU0xTmEwU0hXRHFsZVB2emU1TSsvRkxI?=
 =?utf-8?B?QlpYSTlzNmFMVURCZEpYYmZOSWxhc3JKNmJJellPdEF3cDdmNFNDVjBZL2Z5?=
 =?utf-8?B?ekxrZEZIcUNxMUlwWnNtczd5aXVRc1loNXlQUWkwN0ZjdHRGbnlISDFhV20y?=
 =?utf-8?B?dHRZTFVCQ3ZDLy9HbXlEck03bnlxUUdEYjVkTWp3alM4NW10UnRwTGZkem9O?=
 =?utf-8?B?T0h4dHBORUhtcEI4dSs2TUI2WTdQK2UyRkxSbk5YdGNqZGg1cVBsajhEc1lo?=
 =?utf-8?B?LzdtaTU5M3VodkJOenIvUDR2Sm5GZnd1eG8xVGtPMlVVeVB0RXBOOUF4bTNi?=
 =?utf-8?B?VmJJSE9tR0U3SUtOb1NjS0xuczZHZzBnZ3p4cHhGZUpRa2NpWlhGUGFmOHZZ?=
 =?utf-8?B?VndFVXFwTnlsTTkvUjlKQkkrbXhXaTBsK04ybGE2ZVVkUVpWVWxzb3JNbWhy?=
 =?utf-8?B?K0M3dGV6eWZIbWpYZ0U5RTJZVzJzK2tJWWJQdTAvZjlJczluQkRaSlQwbnFY?=
 =?utf-8?B?WEwvRWtrNEFTakp4a0NTc1V0M2dxZnFEdm5DRSszRVl6TGZJVDZ1OTNaSWg3?=
 =?utf-8?B?S1VYQW9JcTBzK1lBM3RWUGRVYTBlSUV1Rm9CNzlSZE85U28zZEFNcXk2MFVI?=
 =?utf-8?B?TzkrYW93SDBpRS9iMkIwYXh2cVA5K3E2MTkzN0k2WEpwYU10dDlFZ2ZUQnN6?=
 =?utf-8?B?bktZT0FZY3NaclNoa2FjMTZjV29wUTY0QWJlek9CVFc3eGZGblRGUFY4SEs5?=
 =?utf-8?Q?+aEERZzm7UHtC6qKNOe8uNpEz?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3540acc1-8544-492c-63aa-08dd8e3d4f8e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 14:33:33.6912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qOxieVci4e0/afIV2b1hkoaH5JF8xBvZFSqTt+1xZ3TRvGFIc6dcOT6qRTrS3rlG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5550
X-Proofpoint-GUID: ZR7CTRkl293zVlPihwvGVbq4bCJEmfme
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDEyNSBTYWx0ZWRfXzUe3/FuNTU9D Qu9yiLQ0Xdp/RBER74ktumPTCZezctmXbD9zZmSTAgPuH4O2drE0ctsKlgbklLZVRDbHb0BJaMN jQfa1caQApkc6TJ0b8Geu4rFR+yvmde9a7VvZygiMPxT/xes7+mm22fyMNe5LmA0nZULpsHVoy8
 OO+zxyH0jyHLrMoRTwHjudWXZ5U1XihfLBKZR+jR78zbyGNSqDSgsyHGlP/crxsuBPwujntjrp9 /sFGGRwHX5QeQ1Q9P7zztT4pckxlEGLNaEoko+AnclFPRo2vsQL5E6zz8rZU9/EP/GZfFInNN65 L5GxwYSBIA6TZLhu2BIGZgP7cly+DG98gYYjUCXmaouzQEjyX1Q+4YlT0E1YZ9Gi1LcUdkkwMWf
 UX/AZG0sGa/PTC8GyH/SO+p4sKl0bWnTbVeeMj6vIpCfHdBMfKQOSk0QRSIP4WOpi8wLYZeh
X-Authority-Analysis: v=2.4 cv=VPTdn8PX c=1 sm=1 tr=0 ts=681cc0c3 cx=c_pps a=WCFCujto17ieNoiWBJjljg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=WkyblDKLlRiQ5xv_:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=htA0Q5tE-HH7ep-4aWwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ZR7CTRkl293zVlPihwvGVbq4bCJEmfme
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_05,2025-05-07_02,2025-02-21_01

On 5/8/25 2:06 AM, Christoph Hellwig wrote:
> Hi Chris,
> 
> you added a wbc->for_kupdate check to btree_writepages that skips the
> write in this case in commit 448d640b668d ("Btrfs: Fine tune the btree
> writeback exclusion some more") which is not associated without any
> information but the subject line.
> 
> Do you by any chance remember why it was doing that just for kupdate
> and not any other background writeback?  I'm asking because it is one
> of only two checks for this in file system code, and the other one
> in nfs at least checks for all background writeback and thus makes
> some sense to me.

Hi Christoph,

btrfs can keep changing dirty tree blocks in memory, but once we write
them, we have to recow.  Between transaction writeback kicking in every
30 seconds and us calling balance_dirty_pages on the btree inode,
kupdate was doing more harm than good (back in 2007).

Is the goal to get rid of for_kupdate?  I wonder if we can just flag the
btree inode to exclude from kupdate, or keep it off whatever list
kupdate cares about etc.

-chris

