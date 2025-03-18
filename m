Return-Path: <linux-btrfs+bounces-12373-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C132EA670C7
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 11:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9021017EAE7
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 10:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF647207A25;
	Tue, 18 Mar 2025 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y3o2SbPB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BrXVZpHE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F10B157E6B
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Mar 2025 10:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742292614; cv=fail; b=nFYwC6K4RGk4vJrKkHQtG9GGN7AzdlDfw2qEWb/orO1LNYXpfoPQgGx2tvZ6x28OTRWGbtVpscD0Kxxyca0Wm1j2JIvqyWNs25HYIih9gN6d4aIjbsDLnwCiehKS44o/NJHKVp1FyZiY7Dc5gcGRxCG4bPKd/DKLvvpC01rUFbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742292614; c=relaxed/simple;
	bh=VX4KBFW7AgYw+HIXo0xAlnlJylhtrR9q2s0bNNKhqgQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MneKBtjaJ1Xucx7p+E+UahpVem+1kXvSHcJrlPfpHQnFH0Vk/OKEZN37zNHqpRt/h7gpl2y6qmdo6cn1O2r08lo0TvdhTB9cgCAqcSt3f4od2T3d8/yh5terWMYN6eZRWL58KPOJzS1iwFd4o8pqNwRcw3b4DRdlQWPSk3j2lIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y3o2SbPB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BrXVZpHE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I7tknH025102;
	Tue, 18 Mar 2025 10:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=YZG4y0zrhT2LOhb3I01LohmnlQaFEu10cZFxd+Qges0=; b=
	Y3o2SbPBdDHqHRHKsGLjheOwUnRl1l5t70+Jh6faD+nKQL2qf2qbT7t9SQ0jZprd
	BAw1OzQUNfUhnOiMsV/PDXiOcoDhedvGJOs4ene/fsNqD7Kn6UWU2BKAKuDxlw9n
	YFbklvPgDnQvePjQCmYPNiNcT8qu/sge5DIjMTUlXqiZQa6qh/Fj7BRi2gPrbbQ5
	b/btaMFBKd20YHildSddWNM83gNmY+ud434gQLS9HNq18KFyx8dUwtEq8wTCj4kU
	iUCOPpA0VJC51V5Bww9vmokLC3rGkRGaxbWEnsADi/+ghoj+7QgG9JoNtAKznYdf
	wl1jRitrac9o8WK3b2bzlg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1hfvu26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 10:10:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52I8d29R024920;
	Tue, 18 Mar 2025 10:10:06 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxbh5cnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 10:10:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JliiOS+GIJ5nhT2ynF5jqylWaR53KGtwLGMObKZMPdIgkI4O6SFxaH3CEfGlLKAl6nBeYHVGBMJZUw+ugBse7pQGxdHC71aSKqu+hIkIeTTJWPCuAGQJUQD5vvI9Z732B3xJ/sPuq0+e+WeBJcsQw8W/6nUsK/5FxLwKQ8T1/or+bKaLjzqTiH1Ib4cz+ZbPdI/X1wAu65ZWPTQjjVKKMbNkD4HvaUR6htlPMCJTO4hU0dVjeOE+3rNcAiTngCI/qwxx92g8ZzdTgyxAiMYEDb4MAEcTJnhWXLi8zBv9gZMzra2euyj9ZRnM+DBelWhYMeMoPuyam2ktoNhSF63uSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZG4y0zrhT2LOhb3I01LohmnlQaFEu10cZFxd+Qges0=;
 b=aREjGtlYxiVJgGzJNwgmqV3PYRA10KNKIAnM5RpmYO/9zaf+vu0eWg438NPNFMw6fCVhVIFeS01bxyic9G7H9IfXSNi7pf9/d9iVi1VulYlFMsavxM0r6CXOWwSMxstanyswRzLydxgTrm2UsIi2SY13gbj19e9CeO1STPHETza7uwkIOT6YHg+lQKARDTMW/MU9Ee9WlM7S4Moobbbwnv1jpP1LF7tWl2yIGO4lRw/FuvPHoyyy1bycLKt1aBKATYv4k7ifVsl8pufOC5dpgJPTa8O5TMX52bNU0pFnsiiUr73Iw0vJwjqykjA6+pMurvg6UTeV/QUoch0L9cP7lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZG4y0zrhT2LOhb3I01LohmnlQaFEu10cZFxd+Qges0=;
 b=BrXVZpHEOlmEbzGwN/QkSIi0O5hSdTxmO2tDQ3FBLaulau0kBHFtriRbZ8PanBOOHBPuraDXFTZxyZGwQ3l5udZF5JxFRtnlaBDyqxR7vK1xBr2izl+EniZ0u5eBr8Q0ZVYQVmVqrYe2XYb/b4zP5R4YgviRoy9r0uMEVyHrJIU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB7662.namprd10.prod.outlook.com (2603:10b6:806:386::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 10:10:05 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 10:10:04 +0000
Message-ID: <530d415c-b9c9-42de-a111-a5fad0996358@oracle.com>
Date: Tue, 18 Mar 2025 18:10:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] btrfs: zoned: fix zone management on degraded
 filesystems
To: Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>, Damien Le Moal <dlemoal@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
References: <cover.1742210138.git.jth@kernel.org>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <cover.1742210138.git.jth@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0240.apcprd06.prod.outlook.com
 (2603:1096:4:ac::24) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: b9bd608a-8aa8-414d-6460-08dd66050d95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGVHckZycFpRZzd5VVIrRVV4TTBpUzNNYStJZFFWRU5Yb1JEUFhkbVZQejZ6?=
 =?utf-8?B?RXd4L2FYYUl0bVJwTnVycWFHNTV2RHZsb2NqWHF5aEltYjFWSWJXbGRXNnVo?=
 =?utf-8?B?RHhIKzdRRnJXNldlQldHZVJPK09ITGdXVmU5UzdyaDBjcFVHNGMrQmxrTGZM?=
 =?utf-8?B?V0EyT2owZ2U4cGpEUE9oMmZiaGg3QThHM3lWSmJXS3lOUjhtWk9jcW1sZ3Rx?=
 =?utf-8?B?VnJtdk9KQ2MwUE44NjFETHFyR1ppOGJzazhQSkpHWU9GcUg2RllkY0F0RzZR?=
 =?utf-8?B?d2VhZEVPVy9FcXRWa3Z2ejFIWWZPYi9vUTFPYVk4ZWpYY2RWRmhidUhmenhX?=
 =?utf-8?B?U2E3eEZKaHh4dzZoT1RsNDdUdEVONVFPVDBudXB0c2xRd0QxVExVTjRSZTA3?=
 =?utf-8?B?VFZVZmFkUXFiQ0hiTkRHb09zcHU3MmlOWjVEYnBpQUVuT1ZyZkxKNFlhVTc5?=
 =?utf-8?B?OXkwTXltVWIxTEFuRXEzY2dvOFNPTUZJZzhSOU54OHpONkNMdmlIQW1ybC93?=
 =?utf-8?B?a1pNK3RHQi9nVnJSaS96eWhRRCtmV0tFdG9veUxUN1JuWW5BTnRqRk9iKzRx?=
 =?utf-8?B?cmVhT3hHQkVKYXlhRnZ2WUhEdFNoL2pwN1dzTCt1czF6Ukc0NjExTEVSNWIx?=
 =?utf-8?B?R3hSK3lLZjVoSE9jRk1WbjRMQnBrQ09YUG04OUJyVjRZQkI1WGs3UHRWdFJL?=
 =?utf-8?B?b0ZCNFZ5T1pvbGVDSTY1YjNYeHJKVUNzR29KcEpwNzRzdkI2NENoNTBLUVRq?=
 =?utf-8?B?Sy9yM1RxYXQyUnBtcGdETmRXVXQxTHhoODJZaHpPUWl0cGZsNlVrNS82NXZv?=
 =?utf-8?B?UmM1QnhqMkd6MDQzT2kvUng4cHozS1lhN1h5d0Rqc0VuOHFBS0hLeVpyT3dL?=
 =?utf-8?B?emppUzJwamdma0ZXL3NVUkxuZUZST0ttZEpnQnFDNk5Icjhyb2xXTGplM0d0?=
 =?utf-8?B?bXp6WVhFYlJiekRPSCtiLzBsWEpRUS9RbllXb1FjY08vWmRNSWRCcnVqU3p3?=
 =?utf-8?B?MUo3ZlExZjFBMlh6QVFoSUdHbVh2TEN6SEhaOUdWVEErRHpENWZrVkQzbVFC?=
 =?utf-8?B?QTd3RGMvZEowTkZrVWEzdTFEajZ2K2p3Nk44OG5BWG1WcnloeWVTUXU3QmJZ?=
 =?utf-8?B?ZVYyamlBdU44M2hGcHlOMDhzV2NsUElaWGdpd3RCMFlNOGIvNk00WnhNWXpN?=
 =?utf-8?B?Q2JrRW0xRUlXWFU4ZkwyVlVFVVVOMWN1VUxZdWVpOEo1WDQ2WUpTbWFwUk5M?=
 =?utf-8?B?dEZOQnFRQ0tYVXcxRnRsRTdBZWhDSWFOZU1iSUFSNW1OeDc0OTZ3b0Z5R1pV?=
 =?utf-8?B?V0NUazE2WXA1U1RpRlpmbWRNeHU0bGJVM0hJaG1Wcys3VXh2M0xGcC9Pbi9J?=
 =?utf-8?B?eFduR3JXcnZ2T3N0b0pHUmdFYXd5ZU5wd3VJVHIxcWo5Z3Z1RzJuN1pzWXc5?=
 =?utf-8?B?NEJwQzZKd1A4VkFIQ3VKYWpNblFPeGJaZHVTVWZLcDNoU0J4cGRjbVRUQTI3?=
 =?utf-8?B?K2l2amR1WnhGaGZjWjBFQXRtWlAwblg1K09oYkhWSWVLQVcvOG9yVTlCR2ZK?=
 =?utf-8?B?U2xpeHBSS0J6RHZER1duckl0ZEJvVzNhdy94TGJ0U1FVaVl4SjcrSm93UWdG?=
 =?utf-8?B?Tm0zdzhUNU4yNlBCUHJYajI0Z3JkUGdOL2dqMmdyZHA2NWc2cVRoaEEzMVZ1?=
 =?utf-8?B?RmljdjhqS09BV1grNlFnSEl1VGM3V2trRXNHclgzYVNUMTJTRTlERndiMVhu?=
 =?utf-8?B?T2lCTk1NVGtkdHMvaWRmTTFsU241K2VKVXdjZkZSWW04ODBGQWdDbEtuSk91?=
 =?utf-8?B?S3pnTmk5aTY1dnZIVHhVNFlYWjlhQzRnU2RhUVE5SXFvQ1Y2a0VuTXJCanlV?=
 =?utf-8?Q?UkIgfFB34BDgq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEFPQTY3a2ZtdEplV285UE5GSE51Z2Z1dmlTdGl3TW45Q2dhRjM2UWFjWTVm?=
 =?utf-8?B?ZnJaVG5yYlY3WDVZaEptUUtVbUxDMmJWYkV1R2pwWnNuMUxqc3BTdHplMmNB?=
 =?utf-8?B?cWdHTWU0V1pFUG5LdDFmeDFPNU9RNE5Jc0M3Z1VMdW1KUVIreGlZblM0bFU1?=
 =?utf-8?B?TUZqbGtOTWo4b1Q2K1dBbnBFZ1lVbFFtNjd0a1p3VnE5bVAxemsrbTVSRit6?=
 =?utf-8?B?V25hQURoajVVeVk4WmtIQmlkcS9JVk1OSDVBRzJPS0hRS1JtN09hMERQcEtT?=
 =?utf-8?B?MHVFTEdYZVBsWE51Q1RIRXRxRWdYenZLZGNyQnFqQk94TlNGdW82MzFMOUJq?=
 =?utf-8?B?clVtTjhSYjJFTlBQOTRSZWIrWHJEeFJOVXU4YTBKYzMzYUlxUm03R3Vka2NL?=
 =?utf-8?B?M1ROZzV1bVBFcEFrYVMrVjVVZ0U3UFlhQTlQdXVZNjlOSFJpWlFIZGd0cHpE?=
 =?utf-8?B?ZUc1aXl4NEJsS1FsbndjeFJieU9XUTUrWWxGWlJTNmhqdFoyOEF6aEpiM1Jp?=
 =?utf-8?B?RDc0V3cvU0pHNVpEbU5Ed3VuV25NNjcyZ0g0TXZmMndSYmNxdkVvYVBCcWxN?=
 =?utf-8?B?TEVSZEhwV3J5ZGl1V3BTYmcxTHJCbWFlNHlsbFU4Y0tuUjdBZHRGQ2JxeEND?=
 =?utf-8?B?VmliWUtXSXlORjFhRU5OOEduaWs5cVlpSjhRUWJDbkFIZGhDNnhZczdrWFVs?=
 =?utf-8?B?SlhzYk5LWnpvNG53cGZGY1N4by9GaUhRNThXRWJLRjlzSHl2UjdIY0NqZVQ3?=
 =?utf-8?B?YlZBL1J2VzY4RWNMdFlkYXE1TGVLaFFBSHVQUU9YejlVSWYrMEw5MjkwaUp0?=
 =?utf-8?B?ZzRnOUcrWFdHVWZQTFNGd3VaNWpvZnJGcEppU3M2OFFsck8xN25zajluWG10?=
 =?utf-8?B?ZHlYRC9HR0tySGdFaXdONFFaSUZDZm0zRlkwSHg3OFNCZVdtVFRNdXZkYnNn?=
 =?utf-8?B?dHVJNEJXSmNkdEthNmJVb0E5VkN5aUJsclFVTEJyNlZNb0N1WVhsVjJCUWlx?=
 =?utf-8?B?VVViY0FLVXppdnFvRS9zcHA2QkJCZU00bVgwN2k5ZVZqeWxlWnRVWlZlbHB2?=
 =?utf-8?B?M00wamxseFYvYUVMeWZkR0kxOEZ0eFRjdWJXc3hOSjREUDRwTnE5MnhRV1lZ?=
 =?utf-8?B?OUY1RWlWV1IwVlRvN0pkSXM3M3U1Vm9oeEoreWthRW9OSU9wU3BPeG95bXlo?=
 =?utf-8?B?MFpkSWkxUkxhOEUya0U2UWZUVGtBZGtzN0taN3hFd0gvS0ZLTElDRDJINmV5?=
 =?utf-8?B?bjRuS3lyZWFoWGlzdDVkWFpxTlNiSW8rY3JvSE1ucHNzTnkwMFE1ZUtIMEtp?=
 =?utf-8?B?c2FsNDdzM3JXVVJPUEhKYytyMkorN0ZDSDhKbytycWFoSmVRZDNaZ2RDRGpw?=
 =?utf-8?B?a0d3bnl3TURlbUJ0cWZlMzF4UlgzSEJ2QTFpM3J0dkN0N3FEYXFRQTc3bmpD?=
 =?utf-8?B?YzBWUWVIc256Ty9BY2pyQlhodDgwYWlsVVJ4cmZ1MDY1NFNHWi9oTnRsNU90?=
 =?utf-8?B?RnZIdFhBRnFWakQ1RHhwaGlXa0FNKzBMMEx4R0hNcU8xeDFYSHJFUGJiK0hH?=
 =?utf-8?B?ei9aRmtzTlpJU2Q2eG5ubjc1anRNMGNvNEJ0d0hmeHNoMVhOb0N2Q3NVWDF1?=
 =?utf-8?B?aHl1cVQ0cWJCZEFsb1M4OUcxQUQ2UjNHOFhtTFd3TTNHMkpnMFZ6NllDOG5M?=
 =?utf-8?B?MUQ5ak5aajc1Vk9YcTlFdkNkR3B2czJESzNwSzhaMVZkZ203UTV2WFRVbkgv?=
 =?utf-8?B?U216VCs4VFpaMU9DTnMyUU1obFVSSFVjMldrMHdtUnNHeU0yaDF1T0cvM2lF?=
 =?utf-8?B?REErdmZDTXRhQWZ0SnZYR0tNdWZIL2d5V1hYK0J0MGxCRFNNVFMrYms4NnB1?=
 =?utf-8?B?QnF4cVZuZ3h6WkpGYUJReEJmNmhISTJpazQwZTJ3aHZ0L3FMbHpIRW4raTB4?=
 =?utf-8?B?RFVhOENRWGNNUDdtTWthV2FYK09BcXFpclo3TnVWdWY1MEgrMEh6enhiaXVk?=
 =?utf-8?B?Zk5PUy8wWWxqaUh3RWRUSktkT3BMaXBTK3lSaC9obVREOFRvUnl5VVRtbG5P?=
 =?utf-8?B?Z3BZeVdKYUpWRnY5TEluS1JWaTFOMXBsVlBqSk42SVA0dFhpaWNQSloxS0hH?=
 =?utf-8?Q?2Gp6yejx+ivpgyD38fvKrS5S/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ljujjhQRZQLBsVD7kRQj7NbcgUNg07UZe0fAl7lYU2fNplLIZ4I2jd3M7Agg/A6RFNlO41n5OEiv54f5xbxDSRf2uwNZHbc42cY+l8RkRIKem+3/zyadC8ZTymzQ1kkUY3msjz/0lIjmkOqU5ORb/ejPcGiRF+j1KpFn1A0NhhiHaLEGXBkqMLRR489bc8qd9caEFEgDWV1qtEgXW733OM9Z79vfXcT9bQOotRTNoWuJhIEcdBG4AvSQXrcXpnhFobWUeb6gaR2ry8PNdU7K58yXBT3oylNjaS5iId3gkziFn145cTVPPCxsRSqWvrekIeIf2PwyLHOJFlj1IOdXrSedMqHFkFL3s5RUQDigyQGm7dOXiWFwTv99WkEbRh13ceFGxP7g6D7F5n9eNON/wNuODw/3adXxScJvfiF36NHQm/XWa5qb2pYDm2yue5s6IchuCw0/zmVmXtoxgXPjaVK7feAoUq5sN3/pazD39AtjSA1jo/3EqsKEMpqmGUsZfI49RcfdWB/3vErbuDTPjBZY3OJ/WdNs+/U1jlM2bD20FPA6JqHc4TF5hBRLY6gzsoTG1/SImsZ514qSmVQzbvBJW6Ca88sQ/k0/R7co9vg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9bd608a-8aa8-414d-6460-08dd66050d95
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 10:10:04.8131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fcrudv5SUo+t85EHxFuL0nZK3lfCUZxjX9H1igsD3k8hHeuU84vHNfK28iXDmheCIm004q6pRjPNVnjdEss1rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7662
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_05,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503180073
X-Proofpoint-GUID: DUhc6ZS-Cr4UBGfn8fcg7q743dYRONko
X-Proofpoint-ORIG-GUID: DUhc6ZS-Cr4UBGfn8fcg7q743dYRONko

On 17/3/25 19:24, Johannes Thumshirn wrote:
> Two fixes around ZONE FINISH and ZONE ACTIVATE for multi device filesystems in
> degraded mode.
> 
> Both times we're dereferencing the btrfs_device::zone_info pointer without
> prior checking if the device is present.
> 
> Johannes Thumshirn (2):
>    btrfs: zoned: fix zone activation with missing devices
>    btrfs: zoned: fix zone finishing with missing devices
> 
>   fs/btrfs/zoned.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 

Looks good for now.

Reviewed-by: Anand Jain <anand.jain@oracle.com>


PS:
We have been using either of these methods to identify the
missing device.

   test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state)

or

   device->bdev == NULL

IMO, it's a good idea to consolidate to the BTRFS_DEV_STATE_MISSING
flag. I have some incomplete patches for that. Also, I think we
should discuss how to handle reappearing devices;

Thanks, Anand

