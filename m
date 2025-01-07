Return-Path: <linux-btrfs+bounces-10757-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D34E5A03405
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 01:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342E71885722
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 00:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE1B219EB;
	Tue,  7 Jan 2025 00:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W33hce8E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fremCEu3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113CA28E37
	for <linux-btrfs@vger.kernel.org>; Tue,  7 Jan 2025 00:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736209810; cv=fail; b=bBELMxSn1Dtwpd+t4zAU2hHwi3mtfyS8Uu4D3guM3NRZUshp8p1JuIL4tn7kSGdGJahQFr1+THDwKmusUnGnjajs4Ozew2n+dfuVLkqLHjc+NW5VMsq+1Q1WacDyzPiqanxdtvudYKNOygRNwrd6E3C77vZ5o8FovUJn38JqFMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736209810; c=relaxed/simple;
	bh=CrDho6xI4fnwEqFvEdTGpTcRSi7pSHShzHhy4OBuL1g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ek/zGeghDeLM3foA2pNrQEtJOQq2Fq1PeR7i/17PZebTYM4lyA4O+fjuoVK/Va91VGfjk2yHVYyJmOhCcalkkKLDv/2pkT9UJz+yP4nB3QkSP3o97nYWN9brfqItv3C9wzP7+V1fZXSkRWy6udhPRrbdoMsHF9DyvS0MDjSYgTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W33hce8E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fremCEu3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 506LfmdJ019656;
	Tue, 7 Jan 2025 00:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=AwmqZNOGSP8M8BfYQ4qW+vfyuRmwiP7r14Z8mw4W4sw=; b=
	W33hce8EfxBi1vsXuFDIbqy8kCnooE/oD/mmQmhkqU1WRx2RFZ3SiVKDxc1lObjL
	/EoCL/7+xA3zhA2wEYrrEDOcZ2kyKhchmVRuGVDBF1+jsyhy0nGsDb7UPNaCXO0T
	g952xFgdPuBqHQAE0wOrOwpZHiQrk4NDuhpCR4EGJf1x76TP3e9Iihoy5f+oPplN
	NXvgI2cQDVgj5JuK8OhMGVSaGtkZgg5MQGroin8p68OtbjClB8YlwNItLGNsJ+IE
	tX/lywpzPLRTAGOGS8MYbkxK7D81nc7J0hXniN68jXb9bOK8yW4/7JwlUd6NF4Mi
	BkQFbkCQ72sWbnWOGVCyVQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xwhskd8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Jan 2025 00:29:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 506NfDgP022790;
	Tue, 7 Jan 2025 00:29:51 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xue7w0x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Jan 2025 00:29:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KtkgR4ejthstLTn29fIAu2CVCBAXOE0mrfGl9yyLERhpCeEz3gMHV8ar69qWPGkm4V13Je8WEzEH3HO3YCvGG06h/1DOJ9JRheG5bHAyQyVsvU5zaL1hcASjISPtRk3ARLK5c3yI2h8e7+eRehCw3kwtV2BxlwsL6dcYlcylRJdcixwD6JJgu0PEh2K9kSGL9YUhfkIWnA1lPcBQ0HbM8vNeG9mzGZ8Danr119vLZZ/cashcbH78tn3nIKmHsIhKzbZ4KKwS1HEH3y6b61mB/Bvkwl4/5FuKItESkqtI8pynPCvEXKetymV4rvtn/j6/wqzFV31HcrrO98BvzkPo/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwmqZNOGSP8M8BfYQ4qW+vfyuRmwiP7r14Z8mw4W4sw=;
 b=AXAfI5cM8DZos7FVhvdGzVLYTffcTXX4pzU4OBFNPqH7Z5XI5T/BnSp1GELoCS7kAAS62uoYpK7YCybCekOKWa4kTmLEcxYpejcb9qC7SVnlVrmBgDZAXxr40fPFzApYbhzGi49Bng3yDUaRNSIGbMYR+JqUyw4Fpb9F5YhisjiBmeS/3XfjWpJCaAIF4Hpgm733AGyJItfN2WvuiCG1NtOc0usX+aL02/soX8NDteAewH+DjrhSha217P+NNn6WSr4zgkkrXawR/yQqN7UH/A9ZMQhAvN82jVtWv0znmZqi2Kk7ZSqXsEunHNm0qx5mfTphoATpvX6M6b6Y9inZWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwmqZNOGSP8M8BfYQ4qW+vfyuRmwiP7r14Z8mw4W4sw=;
 b=fremCEu3voKj96QsC8X3EgfnaRI8giQr4AlbRHyVYQWkPswHqqtdVApBB5EHFL7SjraYhX+3BPY3IAEgAXIy/JZ8P4lwzkpEwGhadxA+WonQg3dS7BH2BWNk87MxbCRnnq86Vi1j9YCgFFTIHSQdtGHK2diNkGP/q1dUOp8RhmM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN0PR10MB5959.namprd10.prod.outlook.com (2603:10b6:208:3cd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 00:29:40 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 00:29:40 +0000
Message-ID: <d919adff-b092-4dcf-b722-857de1f86744@oracle.com>
Date: Tue, 7 Jan 2025 05:59:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/10] btrfs: add read count tracking for filesystem
 stats
To: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev,
        linux-btrfs@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, dsterba@suse.com,
        Naohiro.Aota@wdc.com, wqu@suse.com, hrx@bupt.moe,
        waxhead@dirtcellar.net
References: <f7198ea9-e6f3-4857-af35-0f119e2b88e6@stanley.mountain>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <f7198ea9-e6f3-4857-af35-0f119e2b88e6@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0087.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN0PR10MB5959:EE_
X-MS-Office365-Filtering-Correlation-Id: a0e5b789-5be7-4abc-eeba-08dd2eb25fb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REVZbDJjcXV5VzVDYlBUVFIreStLUm1COGdrNGJYZ1RjZG55UTdtV2hJVTBU?=
 =?utf-8?B?Tjc2c2NoVHI2cnlFU1NnWU9rZlJCUU4vc2IrOURCMS9wQU1LczVicXpvWlF2?=
 =?utf-8?B?R0FXUG5mc3RDMVpqSndmV2M5SzdVVDE0dmIrS1FnYWVyc201UXZ6cXRYR1Bx?=
 =?utf-8?B?K3JnV041eWZ1MHRYWm5zU2JoTmozZ25YaXdDREE2cjBtbkp2cXlOcSs5RWxj?=
 =?utf-8?B?azdRbzRja3YzRi83eFBRTEs2bVNYUlBEYnVFQ3BKNlptSmV6NHZVbHAvdU5z?=
 =?utf-8?B?ZE91MzB3VU56Ri9oSUp3T1M2Z0I3MUZmSzVwRTEzWUVjZ3lYRi8xbmVTYk1T?=
 =?utf-8?B?RVVuVlMvTTNGbU5EQ0ZkdVNRd2NpdUZxZkgvZmJDTWo5L1lGMGFnS3FROCtL?=
 =?utf-8?B?SVlLeUZRSzVOaTlRQVcrNjFSWHMwZnBYUitIcVprU29LVC9kb0dyRnFtejh3?=
 =?utf-8?B?WEtXc3NCUXkxTFY2aGtReDMvQy9oWExSYzdGRTlLRzJjUkJyTzR5K2grL0R3?=
 =?utf-8?B?Mm93STA4VVB3STBIWHFjelk0aStiV204cFdKaG03KzZPKzFRUTlNVW0xK0Nv?=
 =?utf-8?B?SEdrZGlCcUpVM2Q4MVZTVGpYNEoxTzBvR1Y3YmlFL21KeFFPdlBGWXpsUVEv?=
 =?utf-8?B?aFZxeGtxNURGbU91RlQ1TldjK29TU2JvVTNMNzZDVExucW9ubFVGVU1BU3Ns?=
 =?utf-8?B?VVBLamVuZjlhQW54M2pSTGRMd3BaTTdhbk4vOTdWcEh5R2NhK2s4cHY2RDMv?=
 =?utf-8?B?d01sQ2lLc1FWUXNUTTBoRmU5MW1HZWNOb2lzWXZwN3AxSStxSHV1WExiaDFi?=
 =?utf-8?B?dDZyK0xQUGRURVVWQVNyRXdEMHlaK2hQMlRMZGhWMldaWHp1MkJoNDVzcW9G?=
 =?utf-8?B?dzJiY2dTMkJ3QXRjeG54eDZUSXlVNWpLRno5UzJPMUVZNDJOVm4rRGVnOTlG?=
 =?utf-8?B?aS9TZHBYdFhzcW5HNld1d1JFeWtIaFF3bmdxdVhkK29NajdNVTk0eU8yVEVa?=
 =?utf-8?B?MW5qQkh6cWFzT3dUNnI5dFVrSURLUXhzZ1dyRzM1UUlWbS90UnNUb2VGRENZ?=
 =?utf-8?B?MzNmZ3VRRFlQZFZWNnhUY1pPYzlISk9HVDBldHRQS3grRFA5dkhNd2xPYXV6?=
 =?utf-8?B?VlFtazZ2VVdzNmcvY1lHUThBOVQza0s3QmVPbXhsT3prUllXZ2JBLy9SNWJa?=
 =?utf-8?B?YWE5cksybHAyMTdjeDRWTVQ4NTRiSW1WNStZVFlheUpGOWliSHVoYnpKc1Zo?=
 =?utf-8?B?aU5jR3hHd3F1T3d2ZjBIVU9xNHlUcWwxRTFlaUhjdkIvVHBtUjBtWWVUcVdp?=
 =?utf-8?B?bDFuQjVwWkFWS3VIS2tnVWV2UExjazFKY1U1bUxEc3BCWllpYXhqM2gwaTFI?=
 =?utf-8?B?WTNheVlzNTRFUmdqYXJua2RoU1EvNGVjZjd3YVBPc3hDUm5zN0lkM1hUUVhC?=
 =?utf-8?B?d0VzYzF2ajZ3Ukp1Y3FZNDRMMUxldERhT254YTJDajNGaDJDdEZvYzJjUUNS?=
 =?utf-8?B?dXA4QWpyMWRSMmdvRGJWZkVjWW50OEIzeGlnem9qVm50Zk9sU0p0QytnZHVK?=
 =?utf-8?B?aHRCMWl1eURKMTV6Zjhnd2hCTThxTVg4eVNMMkNUeHJTbW1jMU16NkFIZ3hK?=
 =?utf-8?B?cXphYS83MnNuQ2QzSkxydkZQNHlhbXJGb1J3SnI0dTU2eDUxVXg0UkcxMk1o?=
 =?utf-8?B?WGdEWUlLaU4zUHZXMXdHLzJOd0EzcEd6ZGptWitRUTQwa1dYVFJDZkR4c1F1?=
 =?utf-8?B?N29Od1dvU2lLRUZVTDdpSW9ubmlmWFJ0b1cvb2tITVU3dmNuQ2xFS1FSVUN3?=
 =?utf-8?B?MS84STJiK0czUkNsdG12Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bU5RQzhIY3FwNElBZFJkQWJTZDlVWUNDN2F5WWZuS3A2YVRnbFd4Nm5RVEN3?=
 =?utf-8?B?OWZOamkvTkphZ2RTdTd1M0V0LzM3Y05PdGFqYWV3N2xBZDZ3NzdCbEEwMUdh?=
 =?utf-8?B?UEpyQ0hvVk0yWCs1NmRhblpUYXZpZTFxcllLalQwS3VjMTBBZ05IM1paRXk3?=
 =?utf-8?B?eTZYVFJVSzNkeHpUWk9OaEVPVG5EOU04RVJuWUliNEdzdnJ3UmlPK1VOQ0tF?=
 =?utf-8?B?RkdTR2JzV215S3gwdGZNajl5bTZ1bGtndWcxZWM3dWxtZURsUDRrenhINml6?=
 =?utf-8?B?VTFjNnRBMGF3NnpyaEdMR1dFVkRzVFNveXkzalFYUUtSNEk2b3ptdGVRQ3Zj?=
 =?utf-8?B?ZDg0K3M0MHNSMEVNMUFQcE5PSUhOYXVJYkZTM01yQWJsa3RGZCt0eFNvTFoz?=
 =?utf-8?B?a0dITnZoM0twWFg0cW9RSS9zTGdXTjhVQmVCSEZ3WHAzN2Y4c1JRQ2ZvUEtt?=
 =?utf-8?B?YWpPZVZtNVBZbGtMTXJNVWw3Z3BRK2tLeTJrWDkwbjVJZ095L1FDZC8reUNN?=
 =?utf-8?B?YkcwQkhCaVZ0TFQreXB3TkltUjhQSEFzeXFDZFR5aEhtRVkybWR4TmkxYVpx?=
 =?utf-8?B?MCtjUjFZRVRtRzY0WmltUG5sMmJuTGRXWjlJRU9YN242dTZVMlIvRlg5WXJT?=
 =?utf-8?B?cjJ1WUE1UC9zdng0UGxMT3UxN3dLbTV5T09DK2grSWRjczUwdURFYjlNYlRY?=
 =?utf-8?B?cXBpajBScnpSNW9kRS94Smp0UjdMYmpTZGJHR0lKTzhOU0tKVHN5V3V5blZI?=
 =?utf-8?B?Q1E2WTFPZ2dXWFQ2NkdFUmdWNGlxcFFhMjNKSmlMS0JxWnFERStYVHBoQzhC?=
 =?utf-8?B?US9TOEczcVlHR1RWczJrcTZ2UFg4R01sVjRGYUNjNjBsMkhZTU5JNitQaXpz?=
 =?utf-8?B?bVV5RitiREFhY2VEb0FFZkx0bnVoYUd0SlVSWkFyYlhZVTROSjVEaUU2UjRK?=
 =?utf-8?B?SkdMNDBzSzhtMkZzakdvNGtveU9QVm9HTWMyWEVwa2ljeWVqRlhWYUdwdmhN?=
 =?utf-8?B?aFdsOXpsakZaQ2RnY2pMVmhuQ3MzdW9vNmlZMURJaTB0QW5tRkE5U09aNzRF?=
 =?utf-8?B?QzBxMEZpTzE2TFBHdXFFaEQ2YmozMTNqMFZiVjNWRHBLRzdNRC91UXZJNjI5?=
 =?utf-8?B?amZBNzZCcGQ5YURaM0NQWlVYMEN2OHFOdU1oTitHR0ZjRUdNcDQzM0szNFRT?=
 =?utf-8?B?YTBBREovWkU2R280UkVnU1YrTjhKVlZ3QWdiYXpHMEh3T1NocC9wSHViMkdC?=
 =?utf-8?B?ank1QXFtblkvR3Z2bFcxUGNFRXViNldWVWVHSUk4dGxvWVY2UU1iTHFxNXJ4?=
 =?utf-8?B?QmZuRURLUlRRQjhYNWY1d2lnR0d0akQ5SEtBa2tPd2drSW1TM2VpczhQRTAx?=
 =?utf-8?B?bDlmby9kL2M1NTlLVHAycjBSY1dsTmxEbWNMemRkTzJ5Mkcwd3lxV2Y3Umd3?=
 =?utf-8?B?QjZwQ3Ryd0J0SHVxR016bUtxek1HTGVWUXoyUmsvbkw0UHQ1cHd4TG5FYUVJ?=
 =?utf-8?B?bU83RzRnUHZNQUFDUTZXWkViT0dxY3dOcHBQNXk4QXRnd2dmY001SS9YanVK?=
 =?utf-8?B?b3JYTHUwcFFsaEJmb1lPQ1JMKzZGbHE1ajRNMnhOdjlWcUZBeHl6cCttYXJF?=
 =?utf-8?B?eDNxa3ZhTThGaEhYMFRIU1pPVUc5d2NPUVpDY1JlM1l5WGtQSWdpWXJTOXdN?=
 =?utf-8?B?KzNaZnlpbXlUU2ZhWmJxWG1GUjBObGNic0djOGtyV2lPSHhpT0RFSU1nRHIx?=
 =?utf-8?B?SnVDcHhOQThCSkJYajZNTkQ1dmJMaDA0ekgrUnVOSnBQcW9rNjlDTzRERWkz?=
 =?utf-8?B?dTZ5R1MyY1JOb0ZjQmdtRGdnZlpZWXE0dFRsN2lMYVFsSVN6UG5MaU5WNXJE?=
 =?utf-8?B?b1B3bmx0bTZ3MU5vMXlraGxLaW5xcXhUbjcza0NOS01sMTBQdnY3U3l6K1V3?=
 =?utf-8?B?UVMvYWVZRnBBZlRFZjViYUZ4b1JMaC9IaGcwZVJmd2lsVHFvRkExYTlCYWls?=
 =?utf-8?B?b2F2YS9ocDJHVWhzamZERGhEMVF0UUloM1JSOXA0cWhNQVpZN3hBUW1POTJp?=
 =?utf-8?B?SGJZZ0ltcHQ0UTNjZjh2SFFrZlBQZU83Q29uNmQ0SkdDNVRKRktxNll4cEVN?=
 =?utf-8?B?NzZhK29wQVcxU0V6OWRFZ1FmTkN2OUkwWXNyZ010T3J4eTJwb056RHY2SEZU?=
 =?utf-8?Q?x9gKZ7s7Z4rXJrbbps0rKjKBJ6CWuiSB6eA2xLZSVXMq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uVv0wJHO6BCXZpkP5b2yt92q4kmd1Hg8J5SeHbIOGuW82eKR1vwvuokZbeJKVI3snjr2JtSshR/uA7Q0+vRuLWzpTQdIs7+FTICbstB+e0VXY1Yp7lP4Wbh9nVhyG2Tug5Mo6mL81M5CW8CGp+yow7MQovAhkzz6jaTfNYTflzPXQV1pscSKlqIw76d9NS+IlPv1kzd7iKseYO3tcATdHd5ZHabg48hRr1MrtvyPKmUuYf0TIFw8yPG9ZP+T6PJGx2gVyDO7u1iL7iJz93ndWtsFXCejmebc7y20UIJSYGf9gX9B2W62/sJ80ca2FyF4I5cURUuc4Bpo1Oori7hafTiDpk9ag9gP0FGfGY5j6lXY/6xoXt82DLDj/JFRdQj0aMGYtNZwu13wnquneezVD1As4SqgrABOGTr/TcsfO2+ol4M0jluSkvS9oUrSZIfp7pnIG4vAwaQgQfV3ZPUd3bUNmu2MBHTqeVYqJIuNcVdFazmDmvaZx48AhNma7rfCI0rUv7Qeyi/ASBqS2tTvXwQgsoCUKD+1ri+uhKKseHz4tHthY6a2AEGdb+sANO+qlgzPxQieHAzIhaLlKtf8U8Ul4rprZeawSpDuRR2WUF8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e5b789-5be7-4abc-eeba-08dd2eb25fb3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 00:29:40.5144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQBlZrA5sFRK9eBSVjhPFHQLqrMRaEO1cXXJxdsOlp3v/DAQwDDm+DOPArmu3s3PCRpAsFjjxs1detsylRX15Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5959
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-06_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501070002
X-Proofpoint-GUID: RgLyve30iteJnT_l8to9AU5dLz255SuZ
X-Proofpoint-ORIG-GUID: RgLyve30iteJnT_l8to9AU5dLz255SuZ


Hi Dan,

  This was fixed earlier. Thanks for the report.

-Anand


On 6/1/25 17:08, Dan Carpenter wrote:
> Hi Anand,
> 
> kernel test robot noticed the following build warnings:
> 
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Anand-Jain/btrfs-initialize-fs_devices-fs_info-earlier/20250102-021904
> base:   v6.13-rc5
> patch link:    https://lore.kernel.org/r/c4010cee5398e35a695def3ad97d4de6f136ae2c.1735748715.git.anand.jain%40oracle.com
> patch subject: [PATCH v5 05/10] btrfs: add read count tracking for filesystem stats
> config: i386-randconfig-r072-20250103 (https://download.01.org/0day-ci/archive/20250104/202501040304.Ju24l8yd-lkp@intel.com/config)
> compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202501040304.Ju24l8yd-lkp@intel.com/
> 
> New smatch warnings:
> fs/btrfs/volumes.c:7691 btrfs_init_dev_stats() warn: inconsistent returns '&fs_devices->device_list_mutex'.
> 
> vim +7691 fs/btrfs/volumes.c
> 
> 124604eb50f88e Josef Bacik    2020-09-18  7663  int btrfs_init_dev_stats(struct btrfs_fs_info *fs_info)
> 124604eb50f88e Josef Bacik    2020-09-18  7664  {
> 124604eb50f88e Josef Bacik    2020-09-18  7665  	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices, *seed_devs;
> 124604eb50f88e Josef Bacik    2020-09-18  7666  	struct btrfs_device *device;
> 124604eb50f88e Josef Bacik    2020-09-18  7667  	struct btrfs_path *path = NULL;
> 92e26df43b1a97 Josef Bacik    2020-09-18  7668  	int ret = 0;
> 124604eb50f88e Josef Bacik    2020-09-18  7669
> 124604eb50f88e Josef Bacik    2020-09-18  7670  	path = btrfs_alloc_path();
> 124604eb50f88e Josef Bacik    2020-09-18  7671  	if (!path)
> 124604eb50f88e Josef Bacik    2020-09-18  7672  		return -ENOMEM;
> 124604eb50f88e Josef Bacik    2020-09-18  7673
> 124604eb50f88e Josef Bacik    2020-09-18  7674  	mutex_lock(&fs_devices->device_list_mutex);
> 92e26df43b1a97 Josef Bacik    2020-09-18  7675  	list_for_each_entry(device, &fs_devices->devices, dev_list) {
> 92e26df43b1a97 Josef Bacik    2020-09-18  7676  		ret = btrfs_device_init_dev_stats(device, path);
> 92e26df43b1a97 Josef Bacik    2020-09-18  7677  		if (ret)
> ec90aa75ef29fb Anand Jain     2025-01-02  7678  			return ret;
> 
> mutex_unlock(&fs_devices->device_list_mutex);
> 
> 92e26df43b1a97 Josef Bacik    2020-09-18  7679  	}
> 124604eb50f88e Josef Bacik    2020-09-18  7680  	list_for_each_entry(seed_devs, &fs_devices->seed_list, seed_list) {
> 92e26df43b1a97 Josef Bacik    2020-09-18  7681  		list_for_each_entry(device, &seed_devs->devices, dev_list) {
> 92e26df43b1a97 Josef Bacik    2020-09-18  7682  			ret = btrfs_device_init_dev_stats(device, path);
> 92e26df43b1a97 Josef Bacik    2020-09-18  7683  			if (ret)
> 92e26df43b1a97 Josef Bacik    2020-09-18  7684  				goto out;
> 124604eb50f88e Josef Bacik    2020-09-18  7685  		}
> 92e26df43b1a97 Josef Bacik    2020-09-18  7686  	}
> 92e26df43b1a97 Josef Bacik    2020-09-18  7687  out:
> 733f4fbbc1083a Stefan Behrens 2012-05-25  7688  	mutex_unlock(&fs_devices->device_list_mutex);
> 733f4fbbc1083a Stefan Behrens 2012-05-25  7689
> 733f4fbbc1083a Stefan Behrens 2012-05-25  7690  	btrfs_free_path(path);
> 92e26df43b1a97 Josef Bacik    2020-09-18 @7691  	return ret;
> 733f4fbbc1083a Stefan Behrens 2012-05-25  7692  }
> 


