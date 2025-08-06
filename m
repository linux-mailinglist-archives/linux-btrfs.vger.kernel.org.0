Return-Path: <linux-btrfs+bounces-15898-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9A8B1C6BF
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 15:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C20ED17D6BE
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 13:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A041728C00E;
	Wed,  6 Aug 2025 13:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lF7sitaS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="s05jsFxG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69C32D7BF
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 13:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754486617; cv=fail; b=cV6fa+bSe9/J3z10GuGdFgPdYSc1s5lP2j9b2P1n0GfYYi/YrkhwndMlHGzijE3N0KT+RAUwTvYTxxKGoIo30Susg+SXnKKMPAxUD6vPAI/i3wzUC2b9DyDbk6zgGdWRAs6VAxPC2EKgB6kBZFzT1rc4loG5zlrzvmwZA6i+Kbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754486617; c=relaxed/simple;
	bh=7BQ+bnnZztoiBpShiynQFpi8uYCrBRqIHPLFiHYwA8c=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=elmLg89B2+g+4v+rCXNUpHZDAo2dMtEWWruh9DGG6iCAeUjYkoF4+EekFU8CvdQfdIg87I2o7B1DDVl3sMNLJ0qhqAJNx7p4X3ovRhwPnM23biBT1ifR75o+rdEy5KUxz5WvqCTsEYKf9w3v8ZpyAAz9SxEgnRe9jJmQZ6gTMOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lF7sitaS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=s05jsFxG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576CRSte002586;
	Wed, 6 Aug 2025 13:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Fzbz2T1S9ZPE9AknUDnRVeCvTGelVnQjbyGVy/wSFXE=; b=
	lF7sitaShTjj1kZuUTk27fPuHAvAfZBm1EkWKGM/e8KWNTsmu1p96pzPgnKSXBhx
	L3/xZfiMy96EOBXREXwBOnWqj46ER7oLRRNalEry40q0UNiGcUrlJTI9vWAM9D4M
	6BlGVYpPEZV8Lb2z4+QgytY42EfAzFZx0+Fjf4s7cFEYthYzrMEYTiK82EHBAsuw
	ip/wRtsmHHcYuvaEAVwzbPiQugWh0aRWozAZxqNz+rba/g7q8Vl/inrP5ycRHjHX
	FmtpNx0g4SDofmi/uLNRl8wJlKl7/GPX1WVhIg9NWRcfP7PALbVd8IVJQcKAZ6RX
	p/z5O7ogziCeXGNRHVHW1A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpve1qtv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 13:23:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 576Ch6br027493;
	Wed, 6 Aug 2025 13:23:33 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwn0yww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 13:23:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QuZV9LtCQWJK1Zla/d7Mwu2fGrb9gQ4yOrBj/RkiyyIlKEPIVUNLBb/QScWf5FGpvM3nIUUd4jncimQ1D3LkSv+97ozk/JcUIijvtLZyDxey2VbCroWEhP6UElFt7VGL+EtDcYI4BUnBvGmPi/ryvzc0pGrgyJjnG381v37f2A0xNUXY8mr6ULfyBYRKTqYI7vQUxr3qKe7c1/F+3Mv/xsj6vlu15CvIJVMApPusxoXME2c4+pT6yWm48whJIF5XXKPy2MPeZ0dE39k/Lb7xBNIRG36TmLldSIRNhTYwJZxzBI1zxCdJiQzkFxRD1Og5yXcyBU6MjsISif1KvTtdkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fzbz2T1S9ZPE9AknUDnRVeCvTGelVnQjbyGVy/wSFXE=;
 b=kGx7ny379nkvCduqxEjcH6lqClqVUb9YdG0HhKQjF8TSiMFBV8lTHMOnYHFoTL7kt8GxagNiai7KNF8wF4Pwv8x+BcQBsSbt4jTmCt6CQYWP6RsWZ5dfJ2ZMGmTD0nxXyAZnKlYkpprN0C2bpwuatlPTT/3j6PslcSmuH34iczBIxm56Y+oX78eboz2+Jkv5hd0qpTI260WV5GsFRQdckOYGPYhr4dkZRp16kN/B6hEax2pSv00tYdAxchwgu5tYf7wsK5//U/HqSdLf3/eyDxUcU8MmKeKrsGWSRtPTKY59QyAOBvnqyp1VWikBzyL6EA8AtpOzIzTTs9yCzYWV9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fzbz2T1S9ZPE9AknUDnRVeCvTGelVnQjbyGVy/wSFXE=;
 b=s05jsFxGcvB+OJWEaox1vQpMl8OUuidRhLroojv+u5YoGnEvHcLEABF81wOUMoLXvugYYGrH0KJd5V8poy2GbqCoByrGq4a/4+YxEvFADot/oZrMjgs/YWF1+LXl3tOBh/ePx+u3/BzwxLxCG+6KSt4QUJUtIeT0XbtCkYSiEeA=
Received: from DS0PR10MB6078.namprd10.prod.outlook.com (2603:10b6:8:ca::5) by
 DS7PR10MB5213.namprd10.prod.outlook.com (2603:10b6:5:3aa::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.15; Wed, 6 Aug 2025 13:23:31 +0000
Received: from DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b]) by DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 13:23:30 +0000
Message-ID: <f2610f91-3d11-4006-8c3c-2b1264ec52b4@oracle.com>
Date: Wed, 6 Aug 2025 21:23:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs-progs: check discard_max_bytes in
 discard_supported()
Content-Language: en-GB
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <614684a6dfeafb1e4d2fe721b2b89f564449d223.1754413755.git.anand.jain@oracle.com>
 <4222f30c-8bd5-42a9-ab0a-f8c39d402256@suse.com>
 <6baaa8ad-5cbf-43b2-b7cd-c04572c9952d@oracle.com>
 <bfee8819-5a5b-47d8-90a5-66d053c90cab@suse.com>
 <2f957fae-d12b-435f-bfef-5adf368fd82d@oracle.com>
 <f9bb5ecd-1e82-4bb4-9d24-f557002057da@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <f9bb5ecd-1e82-4bb4-9d24-f557002057da@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::17) To DS0PR10MB6078.namprd10.prod.outlook.com
 (2603:10b6:8:ca::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6078:EE_|DS7PR10MB5213:EE_
X-MS-Office365-Filtering-Correlation-Id: b680445d-5cf1-4523-14ca-08ddd4ec6f6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3hBWVRlUlNkMk1TVE1FcmtEb3pMMFhVNG1XaFhzUUxvbjZkSVJuRDFIRjR1?=
 =?utf-8?B?b0lnUXFBM0ZDM2dncDVGZTU4SEswNFZIWHdXQTRzWXN3bWZCUGQ5Q1RtUGJL?=
 =?utf-8?B?NW9YM0hvZHFFRGY2d29sbkVOazZkOThBMzU0RHBpT3NQVUtobGtCUk1UZkRp?=
 =?utf-8?B?QmIwa0RjaEgrOU0yV01vSWs4RXNLa1ZJQ21mOWFRb1ZBbFI4bGl1RkFGelVY?=
 =?utf-8?B?S1ZoeVkrbzVjTEYvY3UzUzMxaWkwNnBzOWhra0p0M0JJdkVWZDMrcGdNQXB6?=
 =?utf-8?B?SmpLSk9zRGhJZXRGUkZoNlNUb0R1Ky9sZGRocktoanRZMW9nbGZlRktVRDFk?=
 =?utf-8?B?Ryt3eHNyclZGVTdRRXdkNkdreDJoZTZNYmVIR1Y5L0VmSjlPUWhDbVRuOXl5?=
 =?utf-8?B?aHNpYTFzOVYveDN5WWV2YzFEb3pFS2IzZWt4YWtLYVdLTWpVTXRlbm15TTZH?=
 =?utf-8?B?Qzl6azVGVS95UW5JdjZSNHErMHRZQkV5cGF2dXpCdDFuQ1lhSFRoWUNVSlY5?=
 =?utf-8?B?VDgweTlSc21KYnM4TkxtYWdUNjJIMUJWaUNpWllnRXRXWnduaEJ3N2lub0Rr?=
 =?utf-8?B?Y0hXaGJlbFpvTy9LdnIxSVlqS1lKUkVzb0Rxaml4UGNDY1JxNFR0bS90WG5P?=
 =?utf-8?B?bDNoUUFHbjcrQnVLbWJyMWN1c0lBc1ZmeC9vRnArTFNvaHAzVXhLWXY4enl3?=
 =?utf-8?B?ajJocmdISFk3d2lBRWI2Y3ZXMW5Bcm9RWXdhVSttd09IRy9ZdTVaR3pVNTBR?=
 =?utf-8?B?bDg2VVRaZ0NSQUltT0ZTZkRIWFZJemxLelo0eVZEaEhlSTRYUzFnUzVZZ2Ny?=
 =?utf-8?B?RUN3VXhmbTc4bXkyaWM0WUJlWlBkZ1dsSWlHdHByRjJEd0NYY2VUeG15RGh3?=
 =?utf-8?B?dDBsYXl0aDVDRHJJMUIrMmxWU3Q5TWErallUYkNnTHRGcU43d1RHMGd5bU5U?=
 =?utf-8?B?QTVhZDhmVElJQlVBZ0M2OGthQ3NudzE4WDBxeVRqZU1YckV2Tmhlc0x4cTNu?=
 =?utf-8?B?WndPRmJ3bEFIU1o2cnlOYVZnZWpiQld2K0R5ODk5d3RVMkFOa2FsTmRoc0VC?=
 =?utf-8?B?NWpsTW5aVkgzalRpaDcvalpBSEtBSVR0QWhmZzJWWUZMeWJkTStORE9ORUFV?=
 =?utf-8?B?MkduMU5aYkhyWU91eVRRTEJrWDRldXpzNmRxQnhMK21VcGN1QXp2TUp4NGpC?=
 =?utf-8?B?RCtuc09lRVBoOWQ0VW5hUmpLMjVtOTl2dE93aVpGVk9VTDd0RXF5WWVLRkVw?=
 =?utf-8?B?eUNuZmNaNzNSeEs4WW1LUjBnUU5OM0M0aXJqMUFMa2lZam9GaEZta01iTlZo?=
 =?utf-8?B?WnRvcThUWmdYb2JvemlMQmNpWWZNUGtjU2JNeGpxUDY5UFFZRGFIVTBSaUY0?=
 =?utf-8?B?RmhrK2dEU2RpaXhLUE9Pa1djNW95bUN4eG11c2w2TjcvVlFmUlNnVEpuNW5z?=
 =?utf-8?B?RW1WSk9heHpPWDR3T0JtV1UxR3ZqODZMN3pFUzZLVVBTMnBmWnRFT1MrZGxF?=
 =?utf-8?B?ZGh3cDgxUUQvRExVYVZYUDBTZGFoMXE3SU9wS3Nsemk2ZHdPSTZxTWtTNUpB?=
 =?utf-8?B?S0N3OWxNUW5hLy9xTm93SUFHbGVOVHhBL1I2bTI4aHVqa0hkaCtXeWtDU01W?=
 =?utf-8?B?cUUzZThPdnlXcmpiNkVaVDNYZ2xHbWNtMUNYUndvWUxrWkMrWkhXaWd6dnlu?=
 =?utf-8?B?YXE5MGgwYXdybUEzYzVNdVlkcDdUWVhxWkRDYmI0blBtWlJuWEZscEc4Y0dS?=
 =?utf-8?B?YTZSOGxtWDJHa2xrc3VuR01ML1U5eDZYeU1nUEYweTBZbUFsN0poYU8rbkhz?=
 =?utf-8?B?UVhHSGwxMURYNHp3OFFNcGNLcWhsWExQSUw4WXBuMTBETWFFT2QvMjkyamZT?=
 =?utf-8?B?WjZjL2M2dElMQkxwWHlkd25ta3c5YUpFQjZRWCtsNlFITDRNZmE5UWNJTWY2?=
 =?utf-8?Q?R+yIWc/Omxo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6078.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEd4QVZzYmZXdHJQd2ZhVXZ4VXNmT3hzeHMxZzhuOTJ1TURmZHZWWUJDK3Jl?=
 =?utf-8?B?NVdNVENZdHdKbEdScUtEZXlYbTdLMGgveml2NFJwaDNvMzk5ZWRKcU15RHVk?=
 =?utf-8?B?YmtxbVVIM1gvOVJaY2RoMVZ2bEF3V3BOOFlpYlgxVUgwT3QzZ0NibnY2U25o?=
 =?utf-8?B?UG1pNVdBd012VThEaCs3YVkrMTV2VCtXTEF4V3E2UGZjZzRKWmdPcVVscG5I?=
 =?utf-8?B?cktnUjE3WW5RYUNoaXBFSkNibzluamtwaDJIODdtRy9NMEZ5bXplZWxTc2NL?=
 =?utf-8?B?RXRna3AzN0VrS09UWVpPdFZEZTR2SzBrT2dYQTEwaG5EWk9hQnJjYkZRV0Vx?=
 =?utf-8?B?N0F2QlRySE0xakR4V1RLcllNT3hCZzFPVWRxbDJiYmVQSTdySUpSYi82ZXd3?=
 =?utf-8?B?cmxvSkdFU2c2K0IrME5ITlVFQitEcXVHS3Fxei93K0w2UmtIUjZHcWFVcTdh?=
 =?utf-8?B?UGdOMkt2V2F2MitKWERiS2RjaVM4dTFlb3dmeGlkNm1qUlE0TW9FSG1NWHNM?=
 =?utf-8?B?TWtmSEZRZ0RxYVJVa3RRTWdPQWRkUWFSUVVCNWdnUFZxdFh5QUcyUytCQkxn?=
 =?utf-8?B?MWMzeG4vVi9JUVdHblRjTzFPcjZGL3FtR05ncG5aQktURHNjSnBidjJSdW9Z?=
 =?utf-8?B?eHVlQzJzdlRLUGtjSWhodCs3YkNoUkQ4UGhRckppSXViOVRwbDlFcHRKcXVt?=
 =?utf-8?B?bjVjemNyN0pjMWJPckpDUE5oUEFlSnJYWlllK09PR2xWUFNYK1N1QW9BMnE1?=
 =?utf-8?B?THZ0OFFpOSsxOU0vTzZuN3JKRVU5VG9UNSs0V1pwSUE1ZldySDV4Mk95STYy?=
 =?utf-8?B?ME5CMjRXcldPSC9Qc3FVaU0vakQ3cXB4anlialc3TW1wU01JL1RNemtlVzBa?=
 =?utf-8?B?ZE81akRQNmdZck5pK2trRWdSS21CZ0dsTk9PYnBqZE81ekJEcVpPUVRtRlNo?=
 =?utf-8?B?b2J1bEhidXIzNHJpNFhRNXRzVy94QVJyNGh4RlFldFJLZGxZb3VBV282UWY4?=
 =?utf-8?B?N01ZSlpOVXJpNHAycnpqaFZ1OEFYcDVYMnNnL0t1WlZ3c3NmUDVqc1NlbHo4?=
 =?utf-8?B?bW94L2lUOE9QaTc2M1djZkV0Z3hlR1ZxTnhnaXcvYk5uZnVpaEdnNjNpWlRp?=
 =?utf-8?B?SDYzWFo4Y3dNaERDY2l0bnpsMHZ6ZXQ5NHlRQW85T0RhU2FwTUJBTkxCN1pw?=
 =?utf-8?B?bTB2SCtFTFlWeXJ4by9GSDJWV0h5NENxYVRSMXFoUU13U1pqU2Z1WG1ya1NG?=
 =?utf-8?B?a1NwWElCa0RienNKK1h2OTNJM2dTQ2s1TVhmV2FLRXc5ajNTbzkvbFVkQ2pG?=
 =?utf-8?B?YW1wdDE3UzRFYy9xMXJ3OWNyS3dCVmpKQUJUZ2U2U1BROElsczNnUldpazl1?=
 =?utf-8?B?U1d5ZzBIK29jUzgyYjVMK2ZTR1ArbDZZQkxVRFhhYlF3Wm54RWppdzhrS1ZJ?=
 =?utf-8?B?SHBNNjh5NXVLa1E2dEQ5QXdFMU9UakxUMUpReXZzMkw0VVZTRkpnRVZtSktx?=
 =?utf-8?B?Zy9HMTNGS1M0T2hmRTlyK3hpc1dpV1I3aHh1Sk5zcUNoVTBtOTZMWEdKdTNL?=
 =?utf-8?B?NHE4aFVwVnA3ZzBmUFUvNHFDMjRCVWNCU3pZVlVhZGVteUlkQzQzUzlzMlYv?=
 =?utf-8?B?bXJvZEZRTUZyU1RmcGpDbTVPZXJtM3V5aldwZWVadTZsRG5mMmhib2tNT3l1?=
 =?utf-8?B?V2RDU3NPaENhNTZ0a3FCZk9FbHN3c2VyYTRNKzJrbHh6KzhrSFBhTExiSy8z?=
 =?utf-8?B?MUtuQWo2SWR6RlYzK3dXWXBkK1lsQlJ5OElJWXpBa2xvTlZwbFBtQUh0SXlz?=
 =?utf-8?B?SEozNUkrb2xDS3BPd3E2RUpEOS9KSThjZWgrMWVrUVFjeFVVYzlJeml3RGdi?=
 =?utf-8?B?VktLQ0R1aURLdXh3Z2Z2d0UwVG9MbW1lMTRTTG45c29OaVFkbmNiSk9HZFlH?=
 =?utf-8?B?dXRUb0pKV25kRGw0Wmp5bGxsdnpyMjBnanlmSVRwSmxady9taXlKN2c0eG5i?=
 =?utf-8?B?c3RHMVBrVmx4QmJsNG9YaEJTRDBvdDBURGRqMmx2Vk1LSTU3bUg4akZJeW53?=
 =?utf-8?B?aWU0STJtNUFnZmV2VlhEZ3lIR0FscVg2d1JmNXREWEhBaUNOZG9LNGlieEw4?=
 =?utf-8?B?ZlV2MTB2aTRwcm5ObFIwSFZTSEY0YmpJd0RvTGpsaTN6ZmM1ZHRoazhZR1g2?=
 =?utf-8?Q?LrTswAipnmAkvjH0wjRjNpPhkMLrXUNtftCETl5QGrv+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5gF1ds0uq/aX0ZNS+2N6ZN311lKNp71MkvCnSYdkNGmLKJ1lw1WFcvXkQwJra3lzJYjm+nQVWgNE1sh109/e1v9LNZd1/kayFO+Ptn87V1BLWRydMk/Hes+JzYdeS6okx+NRSuPfWZtSzhKD8UpPHqqYYGDGzfMsdWsVzfN/qf0pcOp8Ir/tlT90LAKDoft8kQ+ANyKPtruFISsuTj3QcI8z+UjUae1k6TsYdQqfYBfVtPkbIxHxwmSTKmRKjP8otORGrvfGYwsuPbxnJWJFTuaNpJhu5kcKTpcN/rEzkM6loAghPEXSpaEPZ20WIXY4VATYcvmLMKww2c6mesFXqcJ2Ej254inaUMJCGSw0XUB7B+ViVgNkVYPM0np5AC3Ec392ZMTEYZZm3f3mRG5O9/fUIPZ0IJruBry3mxp/gTnv+4qQcLdX/OojHsstdFqkeMmxS9Q5A+cNyfYZwklutU1Z6CPdkSwwpk5X+1T3WM5gbqBjVlcnQkURRFXnJYGxJxSrV9hKGd516c76+ggFyQeIIiHiZu36QUxwjVt5n2JwKdMsIJKVmfAWZI+XiCdUulQnVe7ufAEYd5xPKMILD9RfeLk1kVFk7GEf2sRfg5E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b680445d-5cf1-4523-14ca-08ddd4ec6f6b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6078.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 13:23:30.7778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cljEGkx+68l0reNXkkm/8S0C6rc23o6MvVkTnP8+v/2JGyZzFHmfVKWc1yfIcjlbBSk7BUfoVQAN9hdabwuhcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5213
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508060085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA4NSBTYWx0ZWRfX2x/oeSaRbb9Y
 t8VTV3FRro4omK73KKqO437RtG9f4dOK12iNk/TzJyGh8WL8HtoT9xiSCHYTAikD8n7X2sBxDeL
 5P2Unv5RjqHHH9XqX7e260cBzOHcRRUH+BDlZ5qjKbBZ+ObkPUrPWNHUX/Riwg0+nzGAgAZOaCX
 b+7Ug8OdRwasN6GQJHH+lc2pktYWYJML1an/z+8DuiALktJAV/xUHCLXOeDjCF1vcJ11aVWrpVK
 5qrAUA/hJc6KJ1oNYcG0RtPPiGP1s8LLUmQIEApCioBwJ63rvthvmIHHYd/xDakqkvGyhjwknh1
 +RsXU2+UetvOPAKq/6EoNuKFLVG9DXPSjhKBAYeM7+Wq1Gwvy4OHJ3trOK1qFmtUaVDmi6lQHs6
 9/arQ+di4P++OJ+yPdy2Qiuyt6Wr8gbbaKEQmHARzlewL6T8ajeF8hsHGEmQtBL/F7QUUsq7
X-Authority-Analysis: v=2.4 cv=ApPu3P9P c=1 sm=1 tr=0 ts=68935755 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=qK1fgcTwrcpAq4FjHb8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: uifXHZ5N6NicxfMkow5aF_8TMHI3cQf-
X-Proofpoint-GUID: uifXHZ5N6NicxfMkow5aF_8TMHI3cQf-



> With or without this patch, there will be no difference to the end users.

How?

> And I didn't even mention that, since there is no error message related 
> to discard, we do not even need the helper discard_supported() at all.

We currently check for discard support before issuing the ioctl().
So that we can info ..

   Performing full device TRIM %s...

And then issue the ioctl().

Are you suggesting we skip that check, issue the ioctl() directly?
and handle 'Operation not supported' if it fails?

