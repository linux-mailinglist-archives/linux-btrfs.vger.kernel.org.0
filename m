Return-Path: <linux-btrfs+bounces-9221-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DE89B58D4
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 01:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA00B1F23D51
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 00:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FEB282ED;
	Wed, 30 Oct 2024 00:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bs21doJR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nBYIUD6S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EB53FBA7;
	Wed, 30 Oct 2024 00:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730249345; cv=fail; b=Bme0ghZFIiBsQ2VWdaoC9HQYjFuOp3NsZbVRnfZgcOWsm7NMb3v/32Fz4nXjmwftPv5YUb8uxLE3YXRQh+K/4UD/sGVvxqxnajMD+jDd5hXu5WCoIxqaC2/K2PIgN3mXOmsNvcSGSKfq7zin5pBsF2AmRHcV2NOKVE9T3EoOQ9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730249345; c=relaxed/simple;
	bh=VQmQyIun+55Bp7uvedKf0emfhB3USHBk7ObKE7Uq8tM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tAmn59subq4G0LGHnuCNvSodXUUAdelaL6KlbmYz+kNYMB71la9WAgl91UNhyq9jWWd4bdAPHy9tSpi2izcsRwTsqyMfHP9yGV0f1Mn6ccow/Mx+iXs+X4RCpHi2SXm1Ewa9oqF9YAXRUzf0qBQGnKUEtI4CpZrZfoo+YNld7+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bs21doJR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nBYIUD6S; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TGfZi0028572;
	Wed, 30 Oct 2024 00:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=sXL3A4Pf3UavwPH2FlLq2kReVHy1PWxG1J4VPaZoM9w=; b=
	bs21doJRkxoUsvLKkNNAjOW17rEconLxjCpWvCyybaq4HbfxmO/L+mpVsDE10CL/
	DdC996ap960PwQ5ifODfh5gZZYNcYYmcT0NbkTYGEHs3epxoxPQmplJUV3Ix5MTT
	S54V+DDxpDVZNDR6LyeALmnMvNVF67p15HD6iRzSeDbZWyYb+Gvk2ISYFzRUXyXD
	0IMfSV4Ijr+4GXaR0RZhl0vi3Ff0aBcoWarhzr3r7SbGJKbmV1O1dXAYx74IGkyh
	Arq61U8GzSM8p0G1OvEQ7zbxHpf8CL7J00YIjREYnz3UdqQr+ZVR6PF8+vxsTZHR
	WQIKbPgVofVsWYORLWOELw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdqetbf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 00:48:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49U0fK8e004210;
	Wed, 30 Oct 2024 00:48:56 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42jb2v203w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 00:48:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VCShOJYC5LX867dKPWC5VIRs9VpAkjJjnKqJwSikpuXMEss0/I3GZn4CU42rRvcTl+KSexMVgxKx4yFyZQmEoJAdgtc1kVMt2QurGyoiikjw90faDnpp8S6nLi/hj4vOp4i0aO/265h5z6mhE5yfhYCzTkmSOmqz2bQOSR59NMczNuEmym6HOqLGhsUlCBSZUJkTX1WLbf0lqGFXSJxEZcGWx8hjfYtGdDMLIBSxy9BP7lxRVW1KfRXzvIPfe/q8giC6GDtZ9/BwVP37eZrWFR1Afk96nFT5CTaINSZsw4Xh4Ke1UpBLLlv9/UseIzpiEi6MyRAYCXhUrTqdWxOisA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXL3A4Pf3UavwPH2FlLq2kReVHy1PWxG1J4VPaZoM9w=;
 b=RkqRIyad8PjP0ek+M3n2OAPFxA0qsA7A2tX15dGHqtbrBePx+ekdFwtsGDh7WDq62ZkMaduYUzaufWf68W3tnLDlUFUvGkYJ2SFjwwnYGBWd/Jic4oOsLZBPwsY1h5fBcZN7fIatXixsx19VF4fkdFzCeC3R8yArBinSSd//cYdTDb2r+WlTK1WcF0T0fG0VyNhYVyDizbftSIgyBVnJr9fOdNM+yepwfNjYMvdlfEVc+36ruPdOpqMhOcmnbq+0YEymVFc4u/ff2H6peZw7Is7fuR7h5x9JC/Aq6uB7fw+9siOrWph3ARoMCxAJCNHjSrhAseHCzuQsdasTZKXBWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXL3A4Pf3UavwPH2FlLq2kReVHy1PWxG1J4VPaZoM9w=;
 b=nBYIUD6SsCqLDW2UXomkM8LXzk5o7NkZH/G0FfJ1/tjEhXJE5Dmsp9RmFcSQjhOh4ZaKqyZ39qynCbW9Dtapt1D+ketD9KF/pAiFUB6JS43FpTyzfxwjLhE+ehTU/LD4Piw8maVfHnNOJk6EOS7dmH+bkrk3I7PUbdTF4ROMw+M=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4480.namprd10.prod.outlook.com (2603:10b6:a03:2d7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 00:48:49 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 00:48:49 +0000
Message-ID: <a88924e1-4ff0-4cca-9d28-cd23f7a67b58@oracle.com>
Date: Wed, 30 Oct 2024 08:48:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: add a test for defrag of contiguous file extents
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <e592bcc458f5c2ec41930975003702a667c92a8e.1730220751.git.fdmanana@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <e592bcc458f5c2ec41930975003702a667c92a8e.1730220751.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4480:EE_
X-MS-Office365-Filtering-Correlation-Id: 7846efae-ff98-4f9d-3baa-08dcf87c9dd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFJDT3ZIMU5IYjdITWYzd2hRWjJvT0R0a2sxcFh0cWs3KzdRNzgvRk1JRVp5?=
 =?utf-8?B?YURISlp6YVJEeHVVZFR4cmQ0Y2NGdVZkOGszUytNRmJHcGZyeldweENCd1RB?=
 =?utf-8?B?SHlPajFDQ0x6OEFEb2wzcEN6M2xKRnFLcWlhc0VvWm5zdjgwTWFjZUI3NHNN?=
 =?utf-8?B?UzdTS3BGenlOWTZxcnA2SCs0bVVTVXlqcmV3NWp3STcvRVVMcEpVbEdFTHR3?=
 =?utf-8?B?SkVtMmU3dVFCSzEwdjRvMWRUSzZSRFhWYU9sTVhlZ2Fyak9nT0MyalVUYUo2?=
 =?utf-8?B?L3V2Q1F1dy9nT2F5dlZkV1UxbmFZSjVqSy9KVExBTXErS0FVTUF6YnVPZHcx?=
 =?utf-8?B?L0FjOFF3a2pNZVcyN2E4bENsVnJaT1JNTDMxRDdmaXd6SXVqblRjelBXRWk1?=
 =?utf-8?B?R05nTXFCZUVnakdLOXljbEs0MTBiZkxhR1BWdGFQQnZPejlrNzhrUEsxY29M?=
 =?utf-8?B?QkFRMlJpZVpqMHFsYmRHSVlBenMweU9RejF6SVgrdDFwcHdZU1ZpSkpCd3Fa?=
 =?utf-8?B?d3Y1TXZzRkRnU2VSeUtXZUR4ZzlObWgxQUxPU09kZ3ZjbEVXRmcrQlF6d0I2?=
 =?utf-8?B?T3IyQmYwMCtheG5NV09uUVdRVTAyOUJ1bXNtVGpIVDd1YndpZ1dlUG5XWjdq?=
 =?utf-8?B?M0VZMzNCVk1OL2pXMjk4S0s5TUFrMmpkbFlsNVc4STRRUlJ2eHQ5OXh2MlND?=
 =?utf-8?B?NmZvNVY2MFNwYm5qZlg4UjZwdEl0YVdjb0M0UUdjU3FqY3h1cmRaTGp5SzYv?=
 =?utf-8?B?akxKbkI0VFdkaW9GSVFBZVQyazFjeEJOcXhRNnVKR0VHVVlNem9ydWpYdXZW?=
 =?utf-8?B?NzF5WTE4R3hqMmpxSjJROW0xL0ZoSTlQeXVDU01odzlUcEVwOHJSUkYrZVZR?=
 =?utf-8?B?WXdHdnpUQ1VMMExuK2xGY0doejZLRzRLTVRCWDhza29zM3BUYzJJSHV6K2ZO?=
 =?utf-8?B?Q2lPTm1qUXdzWmcxVEZ5NDlMaVBsQXNWbHMrUVU3TnlscnF1KytKVENCcVpj?=
 =?utf-8?B?dWlJTmFnQnRBdEdvcy80L3doblhTclFJK0diRXA4THJGYTU3aXc2M2pSNDNr?=
 =?utf-8?B?cFlDZ05SV3lySXhVUGlCZEsrVDBFTEF0MXB4eTZaVmVlbUZMNDhQL1pibUFt?=
 =?utf-8?B?eFBWUUlocmlhS1FFRk5ZMGcrMU51Q0tPWWxXcitUb3NpWnRVeFN6R3pEem5E?=
 =?utf-8?B?c1RiZlZNMUhmUURQNGt5Y3NwVlRQMmUzcUhPQ0ZZQWx2M3IzU0NUa2srQVUr?=
 =?utf-8?B?Z3VYeUx5cEg0ZlNQczhtVGhsNEowNTVEMHltU1ZlZlZRVS9STVFGY1BLWXVK?=
 =?utf-8?B?TUhxRFlyWjhyMkUxZ1grU1BNMi9XUTZDRjFSdi9mQldFbTRFTzJNTVY0Sk9x?=
 =?utf-8?B?djdYMnhrNXhMUkhJbkpOaXlUYkhOc0FodFFsaXNnL2NUb3ZvWWhvUmhCMUhI?=
 =?utf-8?B?cytxSVVkWUZrSHVmOWx6WG9YVWNtOHVocGZpbEZFV2VIUW5xUkNFTTJZaFRZ?=
 =?utf-8?B?RFZBdVdUa2NOOEE5Z0JiUHQ2KzVjNW9IQm0xZTlwRnpmWEFtQ0IxWTltSERK?=
 =?utf-8?B?NWllb3pRRzdmd2VZamlZRlJYMVJYVFRSRzdhellRQzBPb3c0ZmtJbHpCYnRu?=
 =?utf-8?B?S0MvaExFOXJJR0JBclVYbmx5VkN0MVp4a3ljcW9ieEd3NXA2aUNHM01hRUxv?=
 =?utf-8?B?aGZzcjc0QWgyOVFUNkxDbXFUWi9ZbHhDRE9uditzenFXbFc5eWErT1FSNUw1?=
 =?utf-8?Q?hgxI3ROBl7ZxZNKFE5wTABgvjP/8dOnp+DBCtpt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXpPT1VQNEVXTXB2akVoYk9rZXVlNmFiT2JxdVhhbnVWUTdGMnNxdG5lMG5o?=
 =?utf-8?B?WHorUncwNjRmOHVMc09rMktoWG83RVJzSUw5cWFETHo1YWtEOFJFNk5IVmVx?=
 =?utf-8?B?TXNlUHZBbStpcnk0bHdCbjVCMlVIOHd1a2V2VHVteWVZZVh5SlBKSVZaU3VT?=
 =?utf-8?B?VEVRN055NnlGYXQwM1BNZG51NXBkQ3ZmOU9Sa3QxYklCcWpqYnBGd24xeFhI?=
 =?utf-8?B?YTRrb3daTmUvcVNoRXQ1NkVxZDd0dXBCZ0QvUHlKRjhQVVRwSlVOOTJjcWN3?=
 =?utf-8?B?OEswYXYrZFVjdGFOb0pYNVVUMmlzcElQWmZwbW02ZVVyUW1md3hzUWZ3QXhX?=
 =?utf-8?B?amI1dUJnUVJETzRqTGM5ZG1WTjE1YjdvSWZkQXRZNE1GTVFWcVJ1VHpCSlFL?=
 =?utf-8?B?WDZYOGpNMnRTb1E0UmkzUFVWaWJ6NVZuNUVZOVVIWVZtYjg0OGdPKzlVeFFW?=
 =?utf-8?B?ZjF3T0lUeUJ6Z2dQZUxZTlQ4VVk3dnhxWlo1MWdyTG1rSnRUMFZpMG9PekRG?=
 =?utf-8?B?MFc0S0dGUlVlUW9HV1ZUeHJDbHY0THFYTW5XdXR3YXNiVWN6M2Y5eDFkV0ZY?=
 =?utf-8?B?RlB0eDBpQzdpMmhUK1RlK3cxcUlhQTFXQ0Z6bDUwQ1VtWDFWTHBHNEFGQUw3?=
 =?utf-8?B?YTFzaW50UVRrNnNLUWF3ZzlCRmIyRjF3eTJxOXVMOGNiK2F5UldPVlZxbThi?=
 =?utf-8?B?QUJaczVnc3VtcDlUZS83V1hJaC9zOUhGNkhNWTR0V0F4R0E5T01wenFBVnJ1?=
 =?utf-8?B?RHNuWTFVYmMxZFVZeklWZ1BWaGV6TGVKeTU3RnBCVFJhcVdRVlR1WllRL3VL?=
 =?utf-8?B?eWpxeEpoeTFXQXdYVzE2ZU9kcGUwUmxmeVY1a3AvSGdGaUl3MGpxZVQ3Znoz?=
 =?utf-8?B?L2lDUWk3RGN6UitHS3JJQU9WNnMrWGlTWlBvOEV6TzNwRFJVanJnR3hZcUUv?=
 =?utf-8?B?bVR5RUtzVDVDUFQwamlabkoxWExyeU5RQ05mcWsyd1NIWTBLS1lXQ3liN3M2?=
 =?utf-8?B?Y0FWc1VFblBvekNUQml2eDRvdE9EckxqMEJKUWh3UGwwaGpMSjdlZXI2WGlF?=
 =?utf-8?B?bUdrSFMrakhvZlFyZDdtaEVsQXVJRjRZRmlTSkZUSnVLVlp2WDlSR1lQbTBS?=
 =?utf-8?B?bk9UYUhLUzRNU2pOMUJtYVg4UmwwaE5oMFZsMGhiSmordWEwN2dqS1BLeERD?=
 =?utf-8?B?a1E0THQ3Z09hSHB0RHQzQ3lCTmpzZGIyVzBmbjdnRzlhbFBxS2c4cE9YZGcx?=
 =?utf-8?B?UFdYaEhNVlJ3V0lScDZqQW9TNEplVWUvNU9kMW52TUM3c0pTeG5iQWRBRmJT?=
 =?utf-8?B?TEJKc1E5Qk1OcTRDZU5xQmlmSFZFZmxoYXhWYm1DMmZwRm9URG5Gb0t3VFhJ?=
 =?utf-8?B?ZUozQlJyMW44Q3JlaUJWVUxkY25nc3BDdHZyNldVeG9keWJXeTMxQ1daWkhv?=
 =?utf-8?B?ZFlKalVzR3BMd0VnUm9WRXZNYlRSUE4zMGZTSkhLazR5QTliSkt1VEVUbHNK?=
 =?utf-8?B?cVNxTVBaWVFsS1hyNTd2azRWdEhDbzhZUFhnZURJWjdMUi9kbWhRNSs2ZGVD?=
 =?utf-8?B?NjUySUlFWHF4TEJOdFFhamRYL0F4Wjd5WDlkOUtiaXBaeW9qUU9VSWFqMW1P?=
 =?utf-8?B?R2dVRUFZZ0dPeS9ZYjl5SmYyS1Y4Uys3QWJBQnBLSGwxQlVzVVV6Vy9tZDFL?=
 =?utf-8?B?dFYzaXJNWnplbm10SlNSUVlPTDF0NjZWaXhvY1BlSEdBY21zYjFyYStJOEh3?=
 =?utf-8?B?S1h6cnBCSXRxMkRPL2VlWDFGVGJDZzZCZUNoUEo3Rm5ZeTFLUWs4M1ZhVkRT?=
 =?utf-8?B?STgvSWpFVEwxTXZ1aC9QNVo3WkI1b2VuU0FSRGhSZnpvRFZhUkFkdlgxVmdH?=
 =?utf-8?B?Y2M2MTJhaFdnQmZMZThyWXRwaUpmbFlFOGdtY05aWnFVdHhGZlNJNmVYcE9I?=
 =?utf-8?B?VWl4QUxLVFZobnEzNTNzVTFERXdxdDBCdVlsQVFhL08zVzk3YXNKWTRkWE4x?=
 =?utf-8?B?Q2RiSHhkWURabW9kcmhWL1FPSjVRQVZWS2pIekpHNE5wRjhudFpoTHFCaWww?=
 =?utf-8?B?UmxRU25DbGFwTzV4Y25OZDQ2QkVOQ2lYK2UxMGxVSDV1QWtjcUY0cFBYTWhD?=
 =?utf-8?Q?JIYqsfao9afpn6S4OSTP9Ml/s?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	79nxdMizCkEexh27/xx6D/5ehZmUVv/56LKg++7PB0Li5eIRaIdv9pKCMsGCNTS5X/N9dG9gC0f2BxtXypqo+NqG3ePxRv+cte8KUUpz+HwGvES2r/SM78HkDR0FDnF3/j4ch1+O6EUKKIQdZUe/3Km1FRRHgses2qbn2iVri7Zrtc6vonDzfxrtvnR7GlNa0OxvgFsd9A1TSyQywG6P4ZUPJ+XqM3K6YjQ0Gy1pnrC8mek2uEPzP2gTLucAx8vqfMMmAAq1iU0PfDuyoyYnPhcams5z88cq2GCk4rfbX3e+yjtnIovxzd2CRSsJv+P2NqHTC9BQT2IfTCPkCWqJNLiq9djGgWYToyuC67JsisUaJw+0rDVLNmLnsp8lMqHySMno2muIo8er+6/FNGcFwV18japa7cWZBjR/pHjHgOAT+JzgQ5B2BDdK74SbgYkO2trjOxg5Lw21ZAdOtbh8bf2XDUIURT8SiXRkDwYSADBNPDthM1UFZAVLqvbpubjhhoC2ZQAt/daTyhUYxG7RYn3lTMig1l6RVXYrBbGooTO7YIwjJ8iCTL35AsyycgQydK2UO52zn94lC93NCMq7oRKd2zSAPsoywO9itwK80lc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7846efae-ff98-4f9d-3baa-08dcf87c9dd9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 00:48:49.0465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PMjTnwqsTU5UUK5irmooEa1IFMb/43fLtWxdQZ2dp/Nc/15PHIplO4nvztCRlS1hSrozkbG7dE2X2io0hh1R7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4480
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_20,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410300005
X-Proofpoint-GUID: Tj4MzpvEIXgmvcJbXR8A6k6pEi8LyxQL
X-Proofpoint-ORIG-GUID: Tj4MzpvEIXgmvcJbXR8A6k6pEi8LyxQL

On 30/10/24 01:23, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that defrag merges adjacent extents that are contiguous.
> This exercises a regression fixed by a patchset for the kernel that is
> comprissed of the following patches:
> 
>    btrfs: fix extent map merging not happening for adjacent extents
>    btrfs: fix defrag not merging contiguous extents due to merged extent maps
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   tests/btrfs/325     | 80 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/325.out | 22 +++++++++++++
>   2 files changed, 102 insertions(+)
>   create mode 100755 tests/btrfs/325
>   create mode 100644 tests/btrfs/325.out
> 
> diff --git a/tests/btrfs/325 b/tests/btrfs/325
> new file mode 100755
> index 00000000..0b1ab3c2
> --- /dev/null
> +++ b/tests/btrfs/325
> @@ -0,0 +1,80 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 325
> +#
> +# Test that defrag merges adjacent extents that are contiguous.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick preallocrw defrag
> +
> +. ./common/filter
> +
> +_require_scratch
> +_require_btrfs_command inspect-internal dump-tree
> +_require_xfs_io_command "falloc"
> +
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: fix extent map merging not happening for adjacent extents"
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: fix defrag not merging contiguous extents due to merged extent maps"
> +
> +count_file_extent_items()
> +{
> +	# We count file extent extent items through dump-tree instead of using
> +	# fiemap because fiemap merges adjacent extent items when they are
> +	# contiguous.
> +	# We unmount because all metadata must be ondisk for dump-tree to see
> +	# it and work correctly.
> +	_scratch_unmount
> +	$BTRFS_UTIL_PROG inspect-internal dump-tree -t 5 $SCRATCH_DEV | \
> +		grep EXTENT_DATA | wc -l
> +	_scratch_mount
> +}
> +
> +_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> +_scratch_mount
> +
> +# Create a file with a size of 256K and 4 written extents of 64K each.
> +# We fallocate to guarantee exact extent size, even if compression mount
> +# option is give, and write to them because defrag skips prealloc extents.
> +$XFS_IO_PROG -f -c "falloc 0 64K" \
> +	     -c "pwrite -S 0xab 0 64K" \
> +	     -c "falloc 64K 64K" \
> +	     -c "pwrite -S 0xcd 64K 64K" \
> +	     -c "falloc 128K 64K" \
> +	     -c "pwrite -S 0xef 128K 64K" \
> +	     -c "falloc 192K 64K" \
> +	     -c "pwrite -S 0x73 192K 64K" \
> +	     $SCRATCH_MNT/foo | _filter_xfs_io
> +
> +echo -n "Initial number of file extent items: "
> +count_file_extent_items
> +
> +# Read the whole file in order to load extent maps and merge them.
> +cat $SCRATCH_MNT/foo > /dev/null
> +
> +# Now defragment with a threshold of 128K. After this we expect to get a file

> +# with 1 file extent item - the treshold is 128K but since all the extents are

> +# contiguous, they should be merged into a single one of 256K.
> +$BTRFS_UTIL_PROG filesystem defragment -t 128K $SCRATCH_MNT/foo

> +echo -n "Number of file extent items after defrag with 128K treshold: "

Nit: s/treshold/threshold/g

> +count_file_extent_items
> +
> +# Read the whole file in order to load extent maps and merge them.
> +cat $SCRATCH_MNT/foo > /dev/null
> +
> +# Now defragment with a threshold of 256K. After this we expect to get a file
> +# with only 1 file extent item.
> +$BTRFS_UTIL_PROG filesystem defragment -t 256K $SCRATCH_MNT/foo
> +echo -n "Number of file extent items after defrag with 256K treshold: "
> +count_file_extent_items
> +
> +# Check that the file has the expected data, that defrag didn't cause any data
> +# loss or corruption.
> +echo "File data after defrag:"
> +_hexdump $SCRATCH_MNT/foo
> +

Nice.

Nit: This can be a generic test-case.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thx, Anand


> +status=0
> +exit
> diff --git a/tests/btrfs/325.out b/tests/btrfs/325.out
> new file mode 100644
> index 00000000..96053925
> --- /dev/null
> +++ b/tests/btrfs/325.out
> @@ -0,0 +1,22 @@
> +QA output created by 325
> +wrote 65536/65536 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 65536/65536 bytes at offset 65536
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 65536/65536 bytes at offset 131072
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 65536/65536 bytes at offset 196608
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Initial number of file extent items: 4
> +Number of file extent items after defrag with 128K treshold: 1
> +Number of file extent items after defrag with 256K treshold: 1
> +File data after defrag:
> +000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab  >................<
> +*
> +010000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >................<
> +*
> +020000 ef ef ef ef ef ef ef ef ef ef ef ef ef ef ef ef  >................<
> +*
> +030000 73 73 73 73 73 73 73 73 73 73 73 73 73 73 73 73  >ssssssssssssssss<
> +*
> +040000


