Return-Path: <linux-btrfs+bounces-13963-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A624AB4E1F
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 10:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDA273AEA1B
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 08:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75B520D4F2;
	Tue, 13 May 2025 08:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gEYK9U0+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="l9O7yXrE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEE81E1E06;
	Tue, 13 May 2025 08:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747125082; cv=fail; b=TP76yBnJBy09c1l2rBEshSnifTQoQNNlKcLQez5G9EoyswSLFhsAkk2faeR/tKqbStcWP4FE3xKgZzWjvYU4RlLaKRLcN9qIu60jk8aFaVyyCXkVWp68AAUtPKPlIzDeC0WYoCbsylZbBoZ48SozPhmUraES9RNozy6e/AM0kQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747125082; c=relaxed/simple;
	bh=DAuNKPhaXsw1Vhm60XLbXqR9/47X0FmqELxypomkfT0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kUVwoumIJDZVZJSJYDTOOOuplEcCFs7vNYfo91i+dD8BoBuYdXmQ10Mz2LNCzBYlx0hLrR9VURxGPqtehLmFZvL62ayg76Fe8xme7QFmxqvL770hwpiqxcoQHzT4cXyeXT9nrC+4vcCPCfywsqR58JNRAHHHaAuRNQ2eihyn9oY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gEYK9U0+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=l9O7yXrE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D1DSmI031957;
	Tue, 13 May 2025 08:31:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=D0koDeTA05IIcew1ju1rfheCezs/bCoXvDZh86MDllU=; b=
	gEYK9U0+g7ZXk6Odp7Ev4sCETYZUt97/8kjas2jDwxhc+sXui5DrTa23230N5jKp
	kgEkICO6Z3GOSkiwMQ/lNUc8SKWmsot+aIyovZR+GgOrF6yogvnqNdUtSeiWQqjM
	wIPBreeZwHu10IAGyHoIGiTpGeBBn0fwdMT9jnQb3G+J677FwdG65hZt9CugJu/A
	7FStF5/xs0fZtn3O3JXrYeS6+l8zEZu7ha9/+x3onsisjEDAJLYQBmRzcW86PQO0
	/Kk5SxfnAyLROKc/9cyA0KYtyVMr/i+ajfor30o062Ji7kX3uYTg7WpbE3SkTP0n
	LBj5H3JyT0RA+yuwNveYQQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j1d2c4k7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 08:31:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54D6liaO015488;
	Tue, 13 May 2025 08:31:11 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazlp17012034.outbound.protection.outlook.com [40.93.6.34])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46hw88c3nw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 08:31:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mh+Z26oIvM3KAInVr1VSE2j9S74eTd8/o/lGwVBj2GZHAgIUJtmTYVcTBLiecn7nJAUiMQ5S0Y5E9GTl36bVv5Xs5+lZI3ECAlNQB5lx+Et5g833x1Vm2hNVDboVmR0+nArX7hMcNPArsU76RNMrRVfJRgeXwNe/i2Y9VnoyKuv/uRYs9p/PFI0pHPoIbwiScO/H7PZs5++QvV1vfyijBgu9ZoT5l8HLrBSaD6ZteNWX4XCkp0X7SNGjISawXBgV1L41PFqVUkBrpWHWWbwdcqLlXhYAePg07iWxVBNeEZ7F1sFGojaUJ8Ycxb2k6svOZuOhGdkiJCBapQKU24Z0uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0koDeTA05IIcew1ju1rfheCezs/bCoXvDZh86MDllU=;
 b=QtiyYQmgGOob4ke3k2wCn+Q9baCjncoi9dIfqNVMNwW0HT6LxcGXhaZV6EvbtvgpInH8IiGZImVVqUisesmdbB70uT93qu3H5uTFWVtZ7hcOEv/9I1uGqLxCLVvpdcs3PUsniuP5kkdQA5k4J8CSWVMp0GZTjEvNcEEf2XOIxF3xEHSYRs8mDuWzKiwUSe+eSChJg+GTQb4As6zoLaafSEyhY7dpgDnV7cx4s0gLm21muhC5dy5jh4oDwlsINN07s7e2qlbVlmZAt6tniQzsKBxFMnMM9iNSe1Xva5Df68BpaqCpjEu8xQThVTgMqkRNj2a7jV3OOjkmvBO5w3NmAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0koDeTA05IIcew1ju1rfheCezs/bCoXvDZh86MDllU=;
 b=l9O7yXrE96gYTQaG0u4K3IhLwNFqQSqnJ8n/bE5w60CSXRY54jjXS/zzpq7hOImZueaMyP7whodUMuoIuoIgr3g3HL7SPLUrV7ZBITilaZvaadJ4e5RzBT1iid32Qv/jrXjW1suXE2uYfWcQYlDb8Vq0eNUus+t08lOq/Ceg79o=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by IA3PR10MB8681.namprd10.prod.outlook.com (2603:10b6:208:577::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 08:31:09 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.024; Tue, 13 May 2025
 08:31:09 +0000
Message-ID: <22cdcf91-92af-45f9-ab5b-dc08455f0ba9@oracle.com>
Date: Tue, 13 May 2025 16:31:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs/220: do not use nologreplay when possible
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20250513070749.265519-1-wqu@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20250513070749.265519-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::6) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|IA3PR10MB8681:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a2f00d7-0e04-4497-0710-08dd91f882c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VktzcnRqTW5SVktVYldCbjgvcnpubmpRZkdGN1hrOTRpMk1aais0VTh0U1du?=
 =?utf-8?B?UER0czFzRFRUcm9rN1B4TDA4aGNmREhMaUJuTXRRTVJTWGNKMFhlY1JkMmRk?=
 =?utf-8?B?bnIrQ251dWM3MlZIWjhpM2JGYzY3dEt2RWFiRHlCYkF1ZU1HK0xNaEsyYzBS?=
 =?utf-8?B?WXh4bjFldmJ1S0F4VGZyY1lhTDZKMVFadWY0Slc1emx3bXJvUGIzamQzOTZV?=
 =?utf-8?B?N1Z6RXA1MEZNcXdHV3RnZnZmcUE4UDAxbWJPcUtvejY4dlhQeElhd2VONUs5?=
 =?utf-8?B?a0swYnR6ZUxVa2I1RTBqVS94a01pNFVyWGJ2VzZGVDc2ZUp2MFJSdGdxQ3ZD?=
 =?utf-8?B?MjBlbUdIalJSYXl0L3NTWDk4VVVJTnZPQmpUeHI3RXU1RlUxZmhjRjRxb2Y2?=
 =?utf-8?B?b2wvYVNzTDZyNFhKL0R4cDlmMldNSndaVG5pcVh0QUVmMTUwWUJ1TWY4bTRJ?=
 =?utf-8?B?TG5Nak1JZHRKdGZBZktGUGhXb0FrNTlsSVVURlE2SmN5YjM1R0x3aHFpWVFL?=
 =?utf-8?B?Z1dOWHlWd25Eb3lER0pIeUtYUlFUZHlVU2JIYm41Z3ZsM0lEQlBCa0dscW1B?=
 =?utf-8?B?MTVhWHhCYnR1emsyS2tUcEFBMkgzS04xSU00SnVnVUpmcmo5UFNaYTM4ajA3?=
 =?utf-8?B?Tzg2Mmh4MEhhMVFVRjRKSmM2ZkhqOFZqSWZ6bUwyeFc5aFpOS05iMG44MVQ1?=
 =?utf-8?B?N1RGT3F3eEEyTDJZTG4rLy9DbUxMQkNFMUZXQjJheTV4Ukg1V1QxR1E2ajdj?=
 =?utf-8?B?ajhIL3FNcy9FQzAyTi83c3JDV0piR0xIZnZJV0JZUVJVZGJXd0ZvQXJYWTZj?=
 =?utf-8?B?bWRYSFJYUjVhUzV4RmQyQkxpcWY2ZmFMS0hPNVVkNks5VzgzdVpaVjFBdXR5?=
 =?utf-8?B?eURaV2QvdXN1di9rcTM5TUpmZ0pQTVRwOVVmMjh2VzJSUG52ZlBiejBRSFY4?=
 =?utf-8?B?bVpMbDJpd0l1WS9wenFnWDFza1BPWk9MUlBvdEN5ZXBFeWVhL2N0YXpEMENp?=
 =?utf-8?B?bytGRzJrYjV2b2dYT213aUNQdWQ2c21xRGNuSVFQU1dkcUttZWxVRllGSXBH?=
 =?utf-8?B?S1V0Z0I3eEphUjl6NjJWeDZNcHM2Tk1KbUJDZW53amQ2N0YvU1BSaFlPdUlj?=
 =?utf-8?B?Vk43MndUN2U4aWJxTGJ2d0RSMFVsK3VPT0hwaFRmd3N5RFBkNTRGZWFlYThV?=
 =?utf-8?B?QVVGblNqejdJMlM1cjBIZ3p4bEMxMS9Lbyt3QzRhbTVpS0xGNy9WcGFtN0dy?=
 =?utf-8?B?YlIvOUVPc21yczN3QVIzK0lNb3FTakFlQTdJWjRBTHRUZ1Y2YnNiU2phRkxY?=
 =?utf-8?B?Z2l0dVZlRHJsc1hYc1RNQ0pmbDI2bnV1UVNvdjlzc1hvQkFjVkhTZitMeVhr?=
 =?utf-8?B?MU5iTjZiLys0cDhqWjlNQkV2b0ppN2JhOEE3L0dKMFJranM4RlVkS3VUOWdO?=
 =?utf-8?B?UG8wUXFEN3ZQMFllZ2VObE5zOGJaMHFHeGpseVY5SXdYWHBnQ0lQYjM1MmVH?=
 =?utf-8?B?QVJidkZjdFdHc2ROL01xM3NGR0tEVDk2MytWSnJYMGJvYXh0d20wY2tuczFE?=
 =?utf-8?B?My85dmxxdXY4dUd4S0xhUzBvR0w2YnQydGlwR3pYWU9pQkQwWmlYK25CY1M3?=
 =?utf-8?B?NW14clRJQVZpU3MwUUdSYmVsS1RZVkprN01Ya1dnTnRtRUh1T2F6T0txcnZ4?=
 =?utf-8?B?d2FPQW9aZFppaHBhckFlbkdKa1lqSUMvQzd0WCtmdjk2VU9MSGp3SDBoRGRO?=
 =?utf-8?B?T21FbG5DK1pqNGlra1Y3VEhvMlowaDdXQ2NEd2NYVEY0RVMwSHFydXlocHZU?=
 =?utf-8?B?TGFwOFBVUXhOcUtZNGx0MW4weW1seEwzem5qTzBuRE9xN2hFTjJFL2dCQmhx?=
 =?utf-8?B?czJXKzNFZFZnMWE5bVpjUE8ra3gvYnFtK2JZdElaemYyNHY4UzRWTlREVVNv?=
 =?utf-8?Q?zHZrQll/GPE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVc2Nm44dEJJYlRMcCtwdkxoWUtiL2FvU3A0N0JYbmpBcTNlMXRFRXAwL3Q4?=
 =?utf-8?B?Y1hRMGFyZzQxY3lGMG5RSFNHOHRuZEZYOFk0anoydFEvbjhuOGsvc2RKeW5N?=
 =?utf-8?B?b2ZTWGU2Q1hNTHVIR010VHJ1L0dsRFlWRFFTZlYvZzVPL1lvNFo0NVo1blhy?=
 =?utf-8?B?TmxROE8xcENGSUVXUWp1VEsvQ3d4TWszNVhHR29iQzNZOXlwZlFXcmM3c1V4?=
 =?utf-8?B?TTZnT1I4Z3pJa3k2R0pqeTZuTHdUdUxYNHBhYkhrRks0N1dGZG9uT0lvVWlu?=
 =?utf-8?B?TU9ST0p6dkc1NEpNUUxPZ3hIN3NGQ2Y2bUdxTWJvUWhqaGNVZHFmT1ZQa2lp?=
 =?utf-8?B?S0YyczJKelZ1QjMyT1hUSWtrWm9NWW5HUjJLSGsvMVh2QXlaOWp3WjIvSjhq?=
 =?utf-8?B?K1MzMzVsUzA4ZE82K2V4ZDNCNmpZdzNXZk8vUFVUd1lQSjVza29adjh0ZmJK?=
 =?utf-8?B?SUNoOVc3U0Z0MHYycHdIZHlwR081ZWRtczI1dkhUTnh6UFIxSWd3VzFIbHRR?=
 =?utf-8?B?SGlLbXVYMDBNUTJKbXNFdTgwank5d1Z2ZVJrL1M5Rm5lMFY0bmNWeXNCVUxl?=
 =?utf-8?B?czhoNERKc2VVYm56ckpXVU1JZTlRVU5Ra1AvRGNpa0VPU3lpd05JdlpxMHZl?=
 =?utf-8?B?dDZxWVNYcUZEOGJmVmtxbEJXbDYxMXM1Mk1LemxxKzRpOTJ0OG5YcFpDUjJU?=
 =?utf-8?B?T1ZHWDdOdzJ5ZEVFcjZwK2dBUDJqQVJha01Ja0R2YUVqU2I1cldmODlIUjFY?=
 =?utf-8?B?VVBJVDhndVBka3Fob0xrZHhRUmo5N3RRMFJJM1o3SC9MVmVGVk5oektZZFgr?=
 =?utf-8?B?d0dRcjJXbHJ6bmtUZ0VheGM4UkJTRFpOVTBEZFRYK0p6eUY0ajdPRkRvb0JB?=
 =?utf-8?B?dWx3TlhzWG13eHF6QThMa3BweUdiRnBDU0JFckpTRytGNSs4eGNXNHZseGtT?=
 =?utf-8?B?bU9nL29EUERHMFdkTVlsMVBBUytBbFllZjh6cUZoOFBwSGpGSklRZlMrMU1B?=
 =?utf-8?B?ajNkWExXUDczcS9LSW8wQTNvRUdBeWMrNUw0Sjkrd00xdEtNVEhqbStmcXVt?=
 =?utf-8?B?Qk4zNmNXRml0WnhsUk1HM0YyMFNjTmlPd3FIVzVaR3pmL0phaGc4OEdvWHpp?=
 =?utf-8?B?ZWo1NUltYzB5Vkc4aVJTcUpIN0hDOFVRdGdwQnlmZXYrRWxRcTRiTVo4THli?=
 =?utf-8?B?bUN1VkhPM0Z4Vk1yNzF0bVhFODltQWtNNXNJSElLNVFSbDRsRVNjSjB6dVJN?=
 =?utf-8?B?UjR6YzlFZkxtd2FMa2pua2pXcGEvUUhUSGloWUZ6dHVydzFiTXRSM3BUOXpH?=
 =?utf-8?B?eWU5VEs3NXI4aHdRcjJMM245dlYzVDhnbmZZOXl6OGdTWVZSY0FSK1UzUm1P?=
 =?utf-8?B?QlQ0b21kVjlOUmdUZ2tIQi9XTjJOU0MrWFZBdFBVT3N1QTZONk04L2lGYUZs?=
 =?utf-8?B?cVZ4cENld082WmZQKzd1cENWT2RmSzFsUmEycGtRSDFPRkd0VStLQlo0dDRN?=
 =?utf-8?B?Q1pyWWovd294TStBT2MxSStEb3dqVmxHQnVDK0ROaVQyMnd2bG5XS1g3dmZh?=
 =?utf-8?B?Wk5EYm95N3M5Q3YyYWo0cGNOZ0lMakg1dzA5bUtjWkRyOGtLRmJnVzFYVDhH?=
 =?utf-8?B?Q3VkaFdtaE1LK3ZQczBPTXlIWHpsa3c2NUJqQUVqV0RBVlNUclFJWG43SVVk?=
 =?utf-8?B?cVNVYTA0aCtRNjVXbEZVSVAxb3BJaWtqdVBpZ2UrVStPMnU1NjJaN1ZVOTk4?=
 =?utf-8?B?dTZqWnpYbnBacmFlZWhaRWkxdmdiVlcybmVuZE92Ti9wbEV3OXZCaWFmcURS?=
 =?utf-8?B?VHFKQkVqUTdXUDZHK0FnWE9rTVFSL2xKNHZXVWhOWXMzSmZOamttb1pxK0lU?=
 =?utf-8?B?Q0cycklKTTVEb1U1ZnZtbEF1b3I2MXNMdG1haEVwMzRuWnBaQnZub2s4czJM?=
 =?utf-8?B?V0Zqd3JYZVFTYUNOYlFraWpTeXVPS2srTi9vV3hrQVdtcEpGZ0N1eUwxNWZq?=
 =?utf-8?B?UW8yZ281T09NeGVMOVVaek4raXROMTBvTHBNcE1KbjRvQWU2VXRIVTVQdVl2?=
 =?utf-8?B?ZW9tVi9RVDdYMnh1UGV1a01zQnE3d1RPemd1NEo4aUx6R0x4bEcvcndMdEdl?=
 =?utf-8?Q?/IE/wPZBLBs7WH2trT93DewhZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	f6aGPJsV5FtNok4CjbgdecYzlwsVlNzXHm1LwhofdeXPUB8fDp74EIzBq70jFdbD/S/bl5FaSMzJGkz1aHhRdwWN272P8rDaZxqwuTnSe0MGBNsMpVIaTqHI0CitXKMb2sRsVVMAFl9/s9hGK58EzPoDjEQod+c45o3bzz13UTLEbnADRpqRtmNpIaCH4jn8ESuAAVSnv7hT/5oQK9gYnHdUjXvnGZCfip3K/ypV2Biem2ML0d07xQJveCXiIzY/tSpFBy/UmfccM8gI9hcv7j7edTixiofyj39mGV4HEySfnTGWIIL/7lVqywKkVTfqQ7YxPTQwZLvAHWyaueCgtPWc0Ld4GdC5r3mHjpUIMTKRXS+LdUf7gy5nZXU8jcb4SJUJ0Q3VWemI87YxHWOLBZj0Y1ty5b8oWKQNUpFkDpPeMosqDMafY25Gl2lNTyXQpBVMUehDxmu0xrLJFy325byWF30JPEta+ze6R36J3q8gRcVvfPwmHRU26WmSF0WASzd2tLi+r8n+enQPM6egDplmW3T4mr7w3JT5i4Guz1v48PWHACcSSwPfJm0uwgKGLK1wGK3+JZvpAhel4NPtcoI1sGaUJJRrrQMTgpZqQuI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2f00d7-0e04-4497-0710-08dd91f882c6
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 08:31:09.1909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uo5tuCZPPY6Ix1JmLHYYBcEMfDd3hYgnAC9o9eSOKhsBrqwfTN1VMD1KNI2x1wQYyMSfkxMMuqi8P10j7Q1emw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8681
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505130080
X-Proofpoint-ORIG-GUID: CSvVT5GHwHkBLE3E7V_3aj7hy8HbeVyH
X-Proofpoint-GUID: CSvVT5GHwHkBLE3E7V_3aj7hy8HbeVyH
X-Authority-Analysis: v=2.4 cv=XNcwSRhE c=1 sm=1 tr=0 ts=68230350 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=iox4zFpeAAAA:8 a=reRtxco6Do3xPVlUarkA:9 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDA3OCBTYWx0ZWRfX62VUi6OlCXi1 31vyLaEytMzmbiZkfQgf98RavJYQJVZbG6/XgIPQ16090LfMggLQNYosywBonVFFWXoMC8JKmtR eX7X08egyFj3y9d4VnT6in5OKdPaHbS5wp6c77C4txOjZ4hfWJpGqJnfdDMe+dsDqJ72YxEt0Wf
 QiYmeTOSZkhs9zg5D/9d0pTB5Hy0SZNuZ5DPClLlz2LLI/sB9HDXxMq/IvOd67AUWcs9UEn7/OH QYrZG12E3hKndFEabDrc+eDb0kVO1Z38PDEsXZhLNx0Ad9P/2FfgTdFuHX+Pdp/ei+iIu4iRUW7 qLYo7N4kZKjEp4shRWVEKAifRUgk0ww/yewvzmtSh+dq7x5Y4R5lsQzNqdAAhObQRQTtEWy52Ka
 hpi69ctpgYmIicI+J+aVtKZaGsKyvKL57o86OCUsBKZ4S0KM7BgxnGEjPYTyG7fLrKmOcJS7

On 13/5/25 15:07, Qu Wenruo wrote:
> [BUG]
> If the system is using mount from util-linux 2.41 or newer, the test
> case will fail with the following error:
> 
>    FSTYP         -- btrfs
>    PLATFORM      -- Linux/x86_64 btrfs-vm 6.15.0-rc5-custom+ #238 SMP PREEMPT_DYNAMIC Wed May  7 14:10:51 ACST 2025
>    MKFS_OPTIONS  -- /dev/mapper/test-scratch1
>    MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch
> 
>    btrfs/220 6s ... - output mismatch (see /home/adam/xfstests/results//btrfs/220.out.bad)
>        --- tests/btrfs/220.out	2022-05-11 11:25:30.749999997 +0930
>        +++ /home/adam/xfstests/results//btrfs/220.out.bad	2025-05-13 16:26:18.068521503 +0930
>        @@ -1,2 +1,4 @@
>         QA output created by 220
>        +mount warning:
>        +      * btrfs: Deprecated parameter 'nologreplay'
>         Silence is golden
>        ...
>        (Run 'diff -u /home/adam/xfstests/tests/btrfs/220.out /home/adam/xfstests/results//btrfs/220.out.bad'  to see the entire diff)
>    Ran: btrfs/220
>    Failures: btrfs/220
>    Failed 1 of 1 tests
> 
> [CAUSE]
> The newer mount command provides the extra ability to show warning during
> mount.
> 
> Although btrfs still supports "nologreplay" mount option to keep
> consistency with other filesystems, we will output a warning and
> encourage users to use "rescue=nologreplay" instead.
> 
> During "nologreplay" mount option test, normally we will mount use
> the newer "rescue=nologreplay" mount option if the kernel supports.
> 
> But the following two call sites are still unconditionally utilizing
> the deprecated "nologreplay" mount option directly:
> 
> - Expected failure when using nologreplay and rw mount
> 


> - Mount option verification that "nologreplay" is converted to
>    "rescue=nologreplay"
> 
> The second call site caused the above mount warning message and fail the
> test case.
> 
> [FIX]
> If the kernel supports "rescue=nologreplay" we should not utilized
> "nologreplay" at all.
> 
> This will avoid the mount warning on the deprecated and discouraged
> "nologreplay" mount option.
> 

     test_mount_opt "nologreplay,ro" "ro,rescue=nologreplay"

validates that the old mount option `nologreply` doesn't break
on newer kernels that support `rescue=nologreply` and provides
a Warning.

Why not keep this test line and filter out the deprecated parameter warning?

Thanks, Anand


> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   tests/btrfs/220 | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/btrfs/220 b/tests/btrfs/220
> index 59d72a97..4e91b9a7 100755
> --- a/tests/btrfs/220
> +++ b/tests/btrfs/220
> @@ -202,16 +202,13 @@ test_non_revertible_options()
>   {
>   	test_mount_opt "degraded" "degraded"
>   
> -	# nologreplay should be used only with readonly
> -	test_should_fail "nologreplay"
> -
>   	if [ "$enable_rescue_nologreplay" = true ]; then
>   		#rescue=nologreplay should be used only with readonly
>   		test_should_fail "rescue=nologreplay"
> -
> -		test_mount_opt "nologreplay,ro" "ro,rescue=nologreplay"
>   		test_mount_opt "rescue=nologreplay,ro" "ro,rescue=nologreplay"
>   	else
> +		# nologreplay should be used only with readonly
> +		test_should_fail "nologreplay"
>   		test_mount_opt "nologreplay,ro" "ro,nologreplay"
>   	fi
>   


