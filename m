Return-Path: <linux-btrfs+bounces-14134-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 628C1ABD596
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 May 2025 12:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7620D1895C16
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 May 2025 10:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DE4270ED0;
	Tue, 20 May 2025 10:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P4JMEdVr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bsCI9NM+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4509E26FA5F
	for <linux-btrfs@vger.kernel.org>; Tue, 20 May 2025 10:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747738409; cv=fail; b=BzTwgzjhAgF+1GHjTzFcVIhQ1mKkvg4MXoDM6RcWBIRanIHGAGjrgHOOxuDnpjjRdH9DgQmaefoRVA+spAExLqBvpZOJawg0bhDi/haRBvbqM2gqa+pSA3pMxBVVfPL85Zcn44rSDUdxua902i4U0A5AkY+zPN39KJDcCb9Fxks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747738409; c=relaxed/simple;
	bh=WTquiOg4+EPT7aDm7Ti4ARZOCJh8gdem3d/JYC7+1Uc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WKGmaWa+6LKux024UKZBDaqRtFuaCiOzEwyrH96vVxSFwyQELXG9XrZGdP80vGUZymxvku0nRRmIg0kXJFZSN8waGif4eIe8xrAWEMSLt45Fg0W8H2CZGLnS780t6kfQLon/n5UEPxTUYbmo2lJVzff5k0emxZ6QZdOt6OeImtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P4JMEdVr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bsCI9NM+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K9Mxuh016297;
	Tue, 20 May 2025 10:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=knkahl3GR0NydfKqwQ/8IwSHxtTa64X7gqKFRXzrGwk=; b=
	P4JMEdVr75e7qrAOfxSWdK9qwWH0BPAEH34PSYrX7nPymoInkJo09FFX5pGvWOIK
	jwfU9/iE8qaMzACHo/hWwYNZpDZ7vGx3fLFLtp+dzHxqVL9pvwZZmO+ITXQcOWEg
	R27By9SbipEyT3x37S0xZULUzhramfS7S6QWsYhc+iWRWWvMYMW1cK2Am4Fn/1ot
	s7Q+gh7biIZraQwU1kaZ3/vthlAMpzOKxJ5KImds+dz78r+3VkL1hWh/PIeG3mBm
	bcVQ9dEVsE2Dyy18szYCq4w+wg3uBopVxK7SB/nXBA6R9VDLj+CptEfhuJ136c+H
	7srceBzSFHxteWrOD8W4xQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46rdny91yd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 10:53:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54KAOaU9028887;
	Tue, 20 May 2025 10:53:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw7tu2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 10:53:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jUfDqjCj1PKPe+/Rhe6MSBqyhZp8CNUA+rPy5HCAKxrSQ35b5ua6uGk2EfJgnFHXBXdDnDuaYmNbjJUFNVZOOP6tP4rXZ4rsAytORJeMsAgk8apYPEz/WOxYPxaog/evZZyZPpwPIyXA6AWLWRaSi1aEIYZ40xXthmgJ+ymt0ZSenVSLvq+BcOgMbMu9Ruc7lDIU/MzjNM+pIE7QrC3e66BUMW934JycAfHDNF7Gibaht+VqEJdQdwD0Z/Hmqlna1JI3kh4dhVzSckbIJn1Aw8S4OVodQKOIDVKkVyKCmjRjn5xI4MtrhR3TISnzj/miXcEvQgcUPoGKpzAeiV14Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knkahl3GR0NydfKqwQ/8IwSHxtTa64X7gqKFRXzrGwk=;
 b=alEHGaZcovz5fSsVs+jtznvx7p1u3Vx+K/aFwv5UJWAJMf7Q9gSXbYX4AlsKYKQEtAFJDHFVhMopZYBn1Tvu4+iSYQBhSbQUAHxeF+Ap5BF6u8LhqW1qRPae/X7niCjE5Oy62/06ULLiGywTSF9e0MJRFY/Z2JCUZb3Nrec/k9jnK7j9ulch08vieOY4MxYpkAfRrdqD7rY9Oj76rXzghvunaHhWZ63PlCbgOV/F0ig2HyaIkCJg1Q9QhI5C3hpqhs0CsoMF+W824iMRDZCO7PMwCMYhlsq/5uQWGRu3RO2l8lI4vwaitObvbYrpL4xQV4frLzeQyJ/kcj+TKzDDQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knkahl3GR0NydfKqwQ/8IwSHxtTa64X7gqKFRXzrGwk=;
 b=bsCI9NM+K+A58PZaJ3D0HUE+FLVWEyZFtRxmXdRkiGce+RtId5bumat2dTHL7mVlUNUOO9vAR15dOPzNkfYvkzIYSn7xHdKNq+UzWByj5v+o2LGCm0r12zWkuU+AUsRtlCS270eYXVNEr31Hki2tbxOQFbYONDQCK7wIjq34a9o=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by BN0PR10MB4902.namprd10.prod.outlook.com (2603:10b6:408:12a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 10:53:22 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 10:53:21 +0000
Message-ID: <a8f90e36-c6fa-4f74-9e9d-0a2e6e982df1@oracle.com>
Date: Tue, 20 May 2025 18:53:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: mkfs: use path_canonicalize for input device
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <0d9762cf51f6e0e92ac56f02f44836d98af957d5.1747318570.git.anand.jain@oracle.com>
 <87850150-493e-4c8e-8bbd-1bb36bc88b5e@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <87850150-493e-4c8e-8bbd-1bb36bc88b5e@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0096.apcprd02.prod.outlook.com
 (2603:1096:4:90::36) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|BN0PR10MB4902:EE_
X-MS-Office365-Filtering-Correlation-Id: 643bf21a-4cbf-4d73-fb7b-08dd978c8953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2pTbnZlY2p6bVVhZzIxREdMZUg5YkJFTkQrcmRWd2lzM0xtd0VEd1d3S2hL?=
 =?utf-8?B?OXlpT00vM25oSTVUaFJaUjNTM3ZWK01MVGZjWDVKKzhYUTlpRWIwbW52UEZz?=
 =?utf-8?B?K2hwNFUxQVQ0aXBVSndIZThqRlZQMjVQYUI1QlVQNFIwU0pkVldtTm9mK0dh?=
 =?utf-8?B?ZjlFY0xVNXAvd1huU29GS3NSWEZpRWxFYW5DekZ6R2l5NC9rNTBuTi8vUnl4?=
 =?utf-8?B?dElWekcvM2FMaDJaU3VKVU5QeStiTHlmVHZQbG1mOXZwVHlBdi9TOWV6anMy?=
 =?utf-8?B?WkRYd0gxNzI3cG4wSy80TDdoMW8zS2ZOOG01MDRqdnBiRGhWVGcwYzFSZ2M5?=
 =?utf-8?B?aUh6WHNENGhVVHQxL0t6VWRmNTYwbTZ2OFVHb083aEFYVGNDaWR5ZGFIRXR0?=
 =?utf-8?B?cjFmdXArWHEwVWZDQ1hGNytVQTkrZXJ0TXl0QSt1em5VSXFzUFRKRmI2ZEll?=
 =?utf-8?B?OXc0cmVZT29WZ0VFMFUrVFlCYlpjdlhYdXFkTE5TaXRxckZSZjdBZmQwUnVi?=
 =?utf-8?B?ZTcvS05LRTA2cW5VVHVMVDVHc05Wa215dGRUbFZlYWE1bHFyMEcrQk9yNSsz?=
 =?utf-8?B?cGVFWlZPWHE3Q2w5Z0dBYXFGNnRCVXRyOWxoSlF6QkNYOHlmU1JCd0JWV25T?=
 =?utf-8?B?ZXZNaCt5QkF3WW1JeDEwV1REMHEwMXZzYllUVGZ0M1NPaWZ6ak1lbk5iZHg2?=
 =?utf-8?B?QzkwU0x6dDd2a3duL0FFVDlBamowRFJzVnVwODdFcTF3R09ROXh0WmRHSkVB?=
 =?utf-8?B?S1V3ajlka1hlUUt6VUtQLzdMbUx1L3RDY0FWN0lpNEhSRDdrdGhORGFxUkpF?=
 =?utf-8?B?V0w5a3pUankxV0Z0a1dSWjdqWG43RkxTNXliZ0tsdXFpZlFDQUo2ZXJ2NmxS?=
 =?utf-8?B?ajRBWS91eG1Td1haeFdHaVd4aHNOVnM5REJSbVgxbnBaOXEwMTlFczdldkd2?=
 =?utf-8?B?M1E1a0ZnNE5ZNXNXZnpISGFPN2lFRndJOTliZHVqS0NBSXF3NGljWUN6N3R6?=
 =?utf-8?B?RVpuc2duOXJQb3lweFFCOVpUWjdKTW9mdFFkUEJGaWtrcWtNOW5Ma0U4ZWE2?=
 =?utf-8?B?OVlrbkM1K0Npc1pZcEJyVkRKVkVTL1F3R0tKb0JhZElCYllSSFluckZPZHJZ?=
 =?utf-8?B?Tlo2bEhKTVhlM2VUSXhheEt1dHpOSy9VRlNReExKR01sc2JVQzY4cWNmMU9Y?=
 =?utf-8?B?WHMrVUV0WUE4RWZZc3drOHRPTHNTYWFvakxWTW5kSzBUUERaSEdVNDBCSG5M?=
 =?utf-8?B?dDBteGI2aUVkcW15MjV0Ulp1cHUxVHJ4R0g0bFR3anA1c3J2Z1RFNWg2cVBo?=
 =?utf-8?B?dEZzb0pmcmY2ZVNhcEdUbW5iY3czU0tObFRPUmc5WTczWHp2VGRRRjNGSWcx?=
 =?utf-8?B?Rm04UnMzclFQb09IcXE0Rm40c0pTSE14Y2hoV3ZyWHBhanU3ZTVxTFAxWlo0?=
 =?utf-8?B?R3RHTGdsMnhFcWwyKzFvMVpObTVRdlJ1eGJXbW1ERjlqemVHNjN3UU5PTVkx?=
 =?utf-8?B?aUVJL3pwQUU1T2hMWHFNN2dISGFsVThkSXgrazFnOE5jeFN3RXBZVHdzYWpB?=
 =?utf-8?B?QjUwQXJCd0VFM3Z5VEJicS9XSU1WMy9BeVJJazNwRmdNbGRqeTlKM05ZbEZM?=
 =?utf-8?B?Y0JYTi9md0lNZzJ3M0gvNGFpUStDQjdYanplZ3FHdG0zdGxGK1ZIREl3TitC?=
 =?utf-8?B?TXdXOHlXTHlVcXVZSjVZbzMzaFBBOWtnV2QxTFJaOG0ranpiUzlCVFQ5eWZW?=
 =?utf-8?B?eEgrT2g4S3Y3Qi81d1dCMUs3dnVNUUppaFpWcFUwTGVSL1N4NjlnU0R0ZHpQ?=
 =?utf-8?Q?p841BLlS9AGtKG2k7rd1Zyuzm0WCCpz/3VCJE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXErZnVaYVF5Q1R6WjJZRlgyTTViM05IczZDd0lOV3YrcW5tQ0p6Y3hJQUtL?=
 =?utf-8?B?b0xZL05XbmZHZkFhcGNZZzB5Tmt2S0p0Mkp4NUN4c0g0S2xsZjloTTR2TEI5?=
 =?utf-8?B?ZWU5ZWpuVSt0N2laajkvVVZKWE1VQklYVHBCL1UxS1VFUDlTZGQ3NmhYNm50?=
 =?utf-8?B?OVlrWkQvU3pYdXpBL2lpdjUrVDhYTUZreTNzMkhPNHRJVTQ4dTlFSGJqcGVS?=
 =?utf-8?B?OE9oWTk4cUNGV09nYVkvUDFoRFQ1dVR3SmFLaEllY1ppNno2THhydDVLQ2Vu?=
 =?utf-8?B?UHlQbjh0S0xzcG5wdG14amlNeVhrWDJqb1h6d092dlcwZSs0L2dZWXQyc3hR?=
 =?utf-8?B?TUR1RTRmdFdTdWJhZzZxTDExOGp3Y0RDeUtjS1BhbnJGSVRCaXJtUk1EWUVx?=
 =?utf-8?B?ZUdlN1VZdjdVaXFVMmx5RzhYZ2oyQ3gwbWluS2FLb2l6OFJZSUdkd1ZPNUdH?=
 =?utf-8?B?ckJwOXdKQWNpcTgzT0pjbzRHZXBTYWMzM284aEdUZWFZeVJyaE1pOVBkOExW?=
 =?utf-8?B?UTZWWTVxYmdPcVpYTEFJT3VHeEFFUDBpWkdVK0k3NEg5Y3VSN2QwcXpJeFlm?=
 =?utf-8?B?WmF6a3VOMFRxTHN6YzBjcVdoNjE3ZXF2Ym9XaUU0V253alV6UEZCTTYvNHov?=
 =?utf-8?B?VklJM0h6Z1FPOGNhOERRaURUUFE4TzFlNFI1U3ZGUm9Gc213Z0Z5ZmZMc09h?=
 =?utf-8?B?dmg4VnF5cER5NmlTK3VlUHNpWExOOVNVYVR2eG9VTzNpQjRISXNaOTFCbHpN?=
 =?utf-8?B?MlZTbEJwc0FOOEM0bE1EWkRQYmYrRmFuMjQ3TmRsS2lzbmd6cFRnR1FRUDhX?=
 =?utf-8?B?Z0pmbTcycm1KZm9tN2RUUmdVaGVDajRpTTQ1YWJuUjF2OXRsRVJFOGRyWnds?=
 =?utf-8?B?ZGlOQkNSSjRxWm1XbG1zSVl4TkM0ZFNpQjQ1Q0VuS1RWYlRrVG9VcFZoR0J4?=
 =?utf-8?B?WWlKMFlOem52ZVVmbkhpQ2tIQnB6ZDRtTGplZGlFSjZjZk9MU3UyNG9HTVd0?=
 =?utf-8?B?aVdhSWtnWGk5Rk1ZWnFDSE1saDMrZkdQN05hN1F1TTJzMzk3cXhJSWV2ekhy?=
 =?utf-8?B?UVREQUZVSDcrczcwQWF2U3loSzUvQ25MUkZlTTZzaW1KOWowYnpOUnFhSkt0?=
 =?utf-8?B?dlBmdHlOb2JzdWk5SmtJZkp6Nzhxc1ArU2Uyb0JZamtwZjJ4REFiZTZlQzNk?=
 =?utf-8?B?MkVCbFB4NThzc2ZJZkhYZjE2NEVnRUlWYVYwV2FzTVdBWXdFQnVOVUZud28y?=
 =?utf-8?B?N3lYLytPamNnWE1qK2V0RklKNVp0cFVqa2UyVFpNSDdMYWN2MW5qcUdrRDNY?=
 =?utf-8?B?VUJYOVllNThQWHpJd0hmbXFqaFRVVEZlNGRrYnNsbEhiek1jNGNUUGg4RUFC?=
 =?utf-8?B?WEZyR2pweVdqQlljTjJla0lhNHExTHBYck5HNThBOWVldGpYVmM1TWFuOVNH?=
 =?utf-8?B?YTgxS1RmR2tpeEhEUW9CRGZTalpNOXFJWUMyK0xOUHJpRE5JNk5raTJvK0J6?=
 =?utf-8?B?SHJYQURSR296S2hvWTVVdlFET3BTK2lBVkRvU004QTlqTUNORnlXNVE0eWhR?=
 =?utf-8?B?aUk0WXR2a2UvTWQ5ejdvdlUrelVHc2ZDbS9qdnk2MVdTTndJbTlTTkJnT0t4?=
 =?utf-8?B?c0JiNFpCR1pSZ1hYVjM0WHF2dVI1R2hmR1VBU1BCQStKVWJWVFpYdXdTcnBN?=
 =?utf-8?B?WTB0MXJuMkRWdXVRZ2JKREdKRHJHNW5pdzh4MEhlTmRVMWM1R3N1RDdNSFhk?=
 =?utf-8?B?U01mMXZyMzArTG9wbnVhTlFUMUUyUHd1c1hGSThyWlpJQXV5RkhpekIvcDM3?=
 =?utf-8?B?OTJTZmpjUkRFckJOVGRNeEpZOThxZ29Pa2ljWnBnMm1yVitkN3krZ2dkNVk4?=
 =?utf-8?B?SGE2QUt5Z09vRzNLUGk4a0ZOSE9aMmp2ckZpeFZKVVhkdUUzWUx6V1JTQW96?=
 =?utf-8?B?eDZaWE8vU0tDeTlaRVRLRWVOUFp1b2tnNVRpem95bGplR2FIVWF0OVZGZm1q?=
 =?utf-8?B?SGM3blRlN2VjWEV4RGhRWjROZTRqMWpmZ3prZVdCb0UyMGFuRU1mNDRlVUdU?=
 =?utf-8?B?UTVRV3p5SXQyeHdtSnN4NE9YT0pDNndoSHV3VTdETjE0RW9tWnA4blg5TW1Z?=
 =?utf-8?Q?O/hxavV2xUPDPQ2DV6n9dJmmj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	giRsWgVb7AQ0Ykmp4H/WFa9cWirlIISAKcAQdR3//jYez7pdVyZ8J0jcsbyJ5mNpxH0CASYUpMFakaIfrpc01bM75yusQbeLeSyrTh9VO+zr71UfbgFoLhnggAdU8Y/QGgUHCn6n0/37deIHqqVYXZrwvQiVUB3u8zOyCiQh94eqsGZtvITsxvcJ5A8e4lm8iNHGFkTKXThxNWmD15SMKAKdZk4Cq1wT2qYrszyQ2WxVxLs+yQE6Y+kIws6FgRRZut5+U4TT8/Vr+oXlbwhhTXrTtQykpAbx2JAq1YxcKgNaPvILkRnlsztRtNo1o1tvltAufaW3p4mjliHsEa2TQVeFDH7UZfa18zNEkopeY8dFpH4YkeiXgcjT8+Fm1qmPSTd5oE3jhqmHaHWy1+m/WbOkA+5JeLAKsWqShLVtTfqBOf6Vuizov023WQq21jjHRK0rSWeviF6AoaxvzbJckTgm5xfW2kCxUnjNtPFiyOUvn+podnCa5GIVqXVNNZkZXD8XaGPzeaCmXGhTUBecGZ43/zIjU+4X6cjZr9sB1pT+/wh70yiLnJWeQ//fR1bnpb+REP8928Ji44pTS8jGV8Mb97LyklWMw1ZMnw7Klxo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 643bf21a-4cbf-4d73-fb7b-08dd978c8953
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 10:53:21.6768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /zxgPN9sL7zYOYcYb/Sngy/r7ZTHy1Iq7Wj4h5je2XyRK030OeJx7yEW2HiTbjBqXp1eTwSiKA73W3MGTgPeLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4902
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505200089
X-Authority-Analysis: v=2.4 cv=S93ZwJsP c=1 sm=1 tr=0 ts=682c5f25 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=jh2AYUqq2aMDcSq_khUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA4OSBTYWx0ZWRfX3JMEIH8R5Eyk A7R58xCMBxFoXDvxDA7Z1tGhcZEgNcZytohNx9porDMFYrBYpgxSnbtXwzxze90V11IaGQdWBtI HopYnb73jnW+6lj/3if8wS6cNiT0IRYtg5SnAvvnulGCS3NcIUSiMZVFD3ABzK3f63XYY1v1Rez
 DuzkAOUQENiC+MziJo8+WiJN3jY+3IeqxYHy6jaELeXMOTQR8uUG9mn0auuF5YdstvgpjG58F0U JlQ5KbuaOZPZvvFJJPVEoz/3tc93hnxsGGl0VtV4d/50B6zbAcfAyTV7x7jqnqRnx577SETG6QO WzzvX/AliCgVcGB1lOa3cs1qQMv3MEPo8JGt43ThuED2neT+CTyhilkk+6/yw0+ajoSA+2KEE3/
 sHvf4ypl+TDjGkduo4rlaCNMOiuRY+Az/OxyHwVbayDP6qfI8EGq2eMVnue5vC5XniSchGJI
X-Proofpoint-GUID: Tu193WAcI_Hnpc0hW59CJf3w5EkrONp6
X-Proofpoint-ORIG-GUID: Tu193WAcI_Hnpc0hW59CJf3w5EkrONp6



On 16/5/25 09:43, Qu Wenruo wrote:
> 
> 
> 在 2025/5/15 23:46, Anand Jain 写道:
>> Canonicalize the input device's path before using it.
>> So that we show the device path that matches with the /proc/fs/
>>
>> Before:
>>    $ mkfs.btrfs -fq /dev/vg_fstests/lv1 /dev/sdb > /dev/null
>>
>>    $ blkid --uuid c3bf2107-292d-4c7f-a288-0fa922ebd71a
>>    /dev/mapper/vg_fstests-lv1
>>
>>    $ mount --verbose /dev/vg_fstests/lv1 /mnt/scratch
>>    mount: /dev/mapper/vg_fstests-lv1 mounted on /mnt/scratch.
>>
>>    $ cat /proc/self/mounts | grep scratch
>>    /dev/vg_fstests/lv1 /mnt/scratch btrfs 
>> rw,relatime,space_cache=v2,subvolid=5,subvol=/ 0 0
>>
>> After:
>>    $ mkfs.btrfs -fq /dev/vg_fstests/lv1 /dev/sdb > /dev/null
>>
>>    $ blkid --uuid c774b4a6-3ad2-4b15-834a-894dfc898aa9
>>    /dev/mapper/vg_fstests-lv1
>>
>>    $ mount --verbose /dev/vg_fstests/lv1 /mnt/scratch
>>    mount: /dev/mapper/vg_fstests-lv1 mounted on /mnt/scratch.
>>
>>    $ cat /proc/self/mounts | grep scratch
>>    /dev/mapper/vg_fstests-lv1 /mnt/scratch btrfs 
>> rw,relatime,space_cache=v2,subvolid=5,subvol=/ 0 0
> 
> I do not think this is the correct way to go.
> 
> It looks more like a bug in libblkid.

This is a bug in util-linux, as I've already reported in the Link below.

Before kernel patch 2e8b6bc0ab41 ("btrfs: avoid unnecessary device path
update for the same device"), the mount command could update the device
path. After this patch, such updates are blocked — the path set at
mkfs.btrfs time is now retained. Meanwhile, mount still resolves /dev/
dm-0 to its equivalent /dev/mapper/..., which matches what tools like
findmnt report. So idea in this patch to register with the mapper
device path.

In util-linux 2.37.4, if findmnt's path doesn't match what
show_devname() returns, mount -a (by UUID) fails with -EBUSY. In 2.40.2,
the failure is avoided — but verbose is misleadingly reports
"successfully mounted" even when the device is already mounted. By
contrast, ext4 and xfs behave correctly — they return "already mounted",
which is accurate and expected.

Thanks, Anand

> 
> Please explain why the problem happens, not workaround it without any 
> reasons.
> 
> Thanks,
> Qu
> 
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> Link: https://lore.kernel.org/linux- 
>> btrfs/5f401c48-29f5-403e-8c39-50188028ad00@oracle.com/
>> ---
>>   mkfs/main.c | 13 +++++++------
>>   1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/mkfs/main.c b/mkfs/main.c
>> index 4c2ce98c784c..e6466d88313a 100644
>> --- a/mkfs/main.c
>> +++ b/mkfs/main.c
>> @@ -1537,7 +1537,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>>       }
>>       for (i = 0; i < device_count; i++) {
>> -        file = argv[optind++];
>> +        file = path_canonicalize(argv[optind++]);
>>           if (source_dir && path_exists(file) == 0)
>>               ret = 0;
>> @@ -1553,7 +1553,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>>       optind = saved_optind;
>>       device_count = argc - optind;
>> -    file = argv[optind++];
>> +    file = path_canonicalize(argv[optind++]);
>>       ssd = device_get_rotational(file);
>>       if (opt_zoned) {
>>           if (!zone_size(file)) {
>> @@ -1752,7 +1752,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>>       for (i = saved_optind; i < saved_optind + device_count; i++) {
>>           char *path;
>> -        path = argv[i];
>> +        path = path_canonicalize(argv[i]);
>>           ret = test_minimum_size(path, min_dev_size);
>>           if (ret < 0) {
>>               error("failed to check size for %s: %m", path);
>> @@ -1816,7 +1816,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>>       opt_oflags = O_RDWR;
>>       for (i = 0; i < device_count; i++) {
>>           if (opt_zoned &&
>> -            zoned_model(argv[optind + i - 1]) == ZONED_HOST_MANAGED) {
>> +            zoned_model(path_canonicalize(argv[optind + i - 1])) ==
>> +                            ZONED_HOST_MANAGED) {
>>               opt_oflags |= O_DIRECT;
>>               break;
>>           }
>> @@ -1824,7 +1825,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>>       /* Start threads */
>>       for (i = 0; i < device_count; i++) {
>> -        prepare_ctx[i].file = argv[optind + i - 1];
>> +        prepare_ctx[i].file = path_canonicalize(argv[optind + i - 1]);
>>           prepare_ctx[i].byte_count = byte_count;
>>           prepare_ctx[i].dev_byte_count = byte_count;
>>           ret = pthread_create(&t_prepare[i], NULL, prepare_one_device,
>> @@ -2198,7 +2199,7 @@ out:
>>           optind = saved_optind;
>>           device_count = argc - optind;
>>           while (device_count-- > 0) {
>> -            file = argv[optind++];
>> +            file = path_canonicalize(argv[optind++]);
>>               if (path_is_block_device(file) == 1)
>>                   btrfs_register_one_device(file);
>>           }
> 


