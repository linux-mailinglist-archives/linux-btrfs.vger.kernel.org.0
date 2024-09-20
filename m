Return-Path: <linux-btrfs+bounces-8144-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A7297D47C
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Sep 2024 12:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8071F282F35
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Sep 2024 10:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF2A13D52B;
	Fri, 20 Sep 2024 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jvyjuUk5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MNRzcp3Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1E043AB4;
	Fri, 20 Sep 2024 10:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726829953; cv=fail; b=lry+grWQdNLYtUprjsFBSnO3DkPV6cJgQtFjCKGoqSMeqyrRGUKQpTPZ0+pUlGB3gu5U4gyVSmf4HUrdmTsB9cOfwEIe3lm0s8oZJWdKU8C/ytugecIGLwxiG6QFeGYtdiFSLZ5NBUlKeJYv/0Pz6r70BzobEMVVVHrA212OcUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726829953; c=relaxed/simple;
	bh=VVqc4eWB3bwZU0SNgMgwfCHYx5DZdL7fAxjlT7784MA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lz0ZdtWn0Kz2wVUWQGC9CM506GMMFPaqz8tye42TKps/ovbcacvqkHrb6nn1OpB0/vz5azbVyiTs5TYOXxH2IsG4kDO1uhCEp4/NzK3Hj3KNGOk2xLkvT3d6yfR2YobrpDFwQdhJpY+0jsuWZfGAnKGTPbG9gsZBfNLsm5Z03Mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jvyjuUk5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MNRzcp3Y; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48K7tZQl031636;
	Fri, 20 Sep 2024 10:59:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=p4eCgvFtJLOj8/2EEsNTgiGw33e5uDIOFygVFhax9tA=; b=
	jvyjuUk5ZYfz7iiAUAnZ1HRvkt87xxFlYj+x4o4De6dCMU3/Eg9XsiVXwreiBBz0
	BPDUWLhPZFC/Jdur5NteHri6iwoySpHUexH1l9qMbY/XlRVj4lc1Cf9mXXuSRLaF
	mWRJ0HASBCurijxWIuw7Qdv1hYhjT8FyvTiNJGmjBkvw879jdFeGWf6quG4+3B/D
	VZTMOiApqH6D55DtanvH31aR/761SMZ03IrohfNyhQD4A6JqWaZ6iIDtUtVOzD61
	V7GcggBr9unhQDbamKBtvk90hiebwwkm58cKi8VMtnlxSz0IPIrtxy924ZxCjjpH
	W0SpqaSHufXVsw3fVygftQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3nspjrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 10:59:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48KABJYd010508;
	Fri, 20 Sep 2024 10:59:04 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nybaxr0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 10:59:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e74dkdhSSbwNTt56HLpuAsVcO73TLAPThiDazwYrv5JycIZKk69HvTqMZqxX/uOOH7Sp6meDqYnI/ZoYI9B8g6iY186uCVha9/AyAKlOSnStI3rqdFthklAKdbHtIMaWuuNMYWUXb5w3M3Z1V36GifptCgXnF8MEdhl4X1hOtJ/eNOb68ATsQON2MGJIl8CIDXIA2OVHwsnc/3NWGDOksV2nV5XEHM1G6tZ1wTYs9A8945LtMExHyZ8YZKPaeCcte4vdStUNPjZl+vxgaZUzSo1OpJPS1bu+7hHspdejbvVuWCvTRAITLRVEI3fbColomK3ChbVoo6FHDlpOV/YRvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4eCgvFtJLOj8/2EEsNTgiGw33e5uDIOFygVFhax9tA=;
 b=mQvLW6hNL/J5TqyxzqX3/RrG05ziQjNxT4bWfXoBzdoLFYyFgb7p6fQaZQREIy8G+03v3RIrkAKiELn8Ocl+j4erWYPrvQA3Vpcmxz+5g/Q3cPBHlO74FZaeOoRc7qYxPyPDqDgJXwumI7W9OJSCb2SIMWUIMyCQUyNynde2+7nym/ro8of+ywmH/CfSc0T0x+lXNj3XpfJuDKZp2niSAsASKLvzS/CJZUZBT3zszCTRTEaJfU2uqJujuTtEa74Cloa+2LY3bL/76o10KEeZ6+Ll+RaHSMi2KWCaCqpdX3EAk9rFiS4FQD3bjxn8EcX1CwoDJFtELv9nwfIDsP/zZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4eCgvFtJLOj8/2EEsNTgiGw33e5uDIOFygVFhax9tA=;
 b=MNRzcp3Y2Cc0gapFqbjTnlHeHJMqYtK2FhFYF718ebHxu7OwH9Ktt8voVbQzQemeyK143iBFnTZ8v0JWJPgPoUIQ88jphUKs2JvKevIvZlV2ZXpwNViLH0kt12uAsYoL8XTDWdAbcRW13EXTTDw/YWt6pxoddKJ8AO9vAweodJs=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by CY8PR10MB6443.namprd10.prod.outlook.com (2603:10b6:930:61::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Fri, 20 Sep
 2024 10:59:01 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::a6fc:c6a3:7290:5d1d]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::a6fc:c6a3:7290:5d1d%4]) with mapi id 15.20.8005.006; Fri, 20 Sep 2024
 10:59:01 +0000
Message-ID: <9d671d97-c92a-4fc2-91e5-9248500b4b7b@oracle.com>
Date: Fri, 20 Sep 2024 18:58:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/321: make the test work when compression is enabled
To: fstests@vger.kernel.org, Zorro Lang <zlang@redhat.com>
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        fdmanana@kernel.org
References: <21f8d987309ca0699c6bb95666278d02da03ff32.1726145029.git.fdmanana@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <21f8d987309ca0699c6bb95666278d02da03ff32.1726145029.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0127.apcprd02.prod.outlook.com
 (2603:1096:4:188::7) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|CY8PR10MB6443:EE_
X-MS-Office365-Filtering-Correlation-Id: e2f458ca-ceea-4959-2a1b-08dcd9633bd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V095SE1zZmZna2M3T2pEYWRYc2puVWM2UG1vRVFNYlh6V3dFazBoamhqZ3Bh?=
 =?utf-8?B?WFFVWnhBY3VkVTArSTZIcVBKejNyVEZUa0kva3FyNlNuZWtDNitGU0ZWUzk1?=
 =?utf-8?B?bHovdjZKN0JxUXp2VjFPRnB5OGdkUXNadmlNMnlUM3UwZ1p1VTBReEpHQlhM?=
 =?utf-8?B?eUZIR29kVzFSb094RkZiR1FEaXcyckUxUWZ3RFRWVWNqRTFaWmkrT0JON3Fz?=
 =?utf-8?B?QWx1cmFKSFBtUVUrc2xsS2Q5cDlaUGFaSXI0eU5PTTd6RnRaZDhnM25uZ2N6?=
 =?utf-8?B?a0JUY1A5QjgxR1hpaFhxLzlmYnd6WGhVeXBYWVRsOVdGY1lqR0JsNHpGTlhW?=
 =?utf-8?B?eUFXUFZGYjJHdDVGQ2dCWEtQazZGcUUxT3BrTkJUNGpWU2k5SktJQng1T1Fw?=
 =?utf-8?B?RXYxempCaWlGOVR5V3lNQWNoc0RhMVFIYjltZExoRlIvVVlIeUc0cWlIRmZy?=
 =?utf-8?B?Wm40SnJFQlpRN3I1SFhQVldsb2laKzFiSERNOE42QnRrcUh6SFlNaTVsV3lG?=
 =?utf-8?B?SkhPNEJPbVBpaVhwZWpxYmdFZ0ZGMklvUzJhTU9iN3dmYlBFRzBFeHNSZlBp?=
 =?utf-8?B?a2VkZFRaZE1CSlloTHhBaUNKcFc5dmF0UUxEenUrT3p1ejNySW8xaXFNSzdR?=
 =?utf-8?B?bHpwZjFUNjJTbG0rcDhNRENQb3M0YnlCSGdlbDFLMWl5d1BWdGNpeFRGcmhE?=
 =?utf-8?B?V29GcmtDOVF5NFJIbVliVEhBUjJhWEJyY0pvZFZYalNta0NoZTlwRXRTeFlJ?=
 =?utf-8?B?dXFERkYyT3RZRUxoVldYaU8xVUdvMlhTWXg2NmNkdmEveVBUUGxPK0R1d3FB?=
 =?utf-8?B?N0kweVBmZVNKUU0rbmRPeXZ4UVdwVGNaQ3AvUjlxcktlb01DVkRvSE1HcE9l?=
 =?utf-8?B?UElvUm0vNDcxbkJNVXFWK3BjSFZZK0lBUTZtOE9xUzN2MWVZOUlPekErV3ZC?=
 =?utf-8?B?eGJVUG1jeGNLYmVTSUE3UEMvVmZid2t0ZzgwQWxndlgwMFFqaDlQcDI4NDlE?=
 =?utf-8?B?bm8xUkI3NUFtUkpZYmwvZG9Yejc5OG9MNnp5NS9nSzlnZllQcytrQ1Z4c2sz?=
 =?utf-8?B?RW4zcGtMUXJxeHZxVjFnTkl1QTA0eUdpempVYVRmVGxOUm5LZXU3RXJpdVpY?=
 =?utf-8?B?R0dhMnBWUTNqeTR1d296WTVNRTVjV29va2NqWE42LzdrZmJFc1BjU2NjUTls?=
 =?utf-8?B?Z3VuRlZzNzNnTGIwL2hPd2QwU1pQdy9YU2hDb3lmdkRvb0thWWN2MFZUTkk0?=
 =?utf-8?B?cTNwcGYzbG1LM1NyRzlTL1lST1JIOG1FVm9TZXJ6QUgvbHM0UE1HNEtSQXhh?=
 =?utf-8?B?MWovZDVvZnJ3dWk2Q1dpYnYxWHVCVzI2bGlUWk1OVXNRajNKNklLT2hMTGdq?=
 =?utf-8?B?ZHhHcHQveTFQMWxROG5Vb1lGN3ovT292eXMvcldCVm5XQjhSUnR0OE1Dekly?=
 =?utf-8?B?YzhwODNVUklSSXM0VEZBT0V5VmxsTjR6bXlsa1h3dTRuQnlOWGFyUG1RRVVF?=
 =?utf-8?B?MDFVN0E0YWhrcjZmdVhDclNkNFNLelVGVitjOWFRckRzZnhVZExSMS9iZW5p?=
 =?utf-8?B?TGlESWo4S0ZPd1cwWTRPOERob1QrS3JlN2FEZVJpWUZOaTZtYXlNSkhieDBT?=
 =?utf-8?B?QjV4RCtEQUNsZWNib0NKYWxYNmlwNHVQS1pqcCtyQUJEQTRXTjVhU0Y2MmRW?=
 =?utf-8?B?ZTdFciswSWpuYTBjdlc5MkdoNDU1eEltU1lsMnh0TlJidlA4UTVWUVVBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3FmYlE1NUVsWDNIQUYxTEtCSldCQ0VCSGFrRS9UOVZyZU9sYW0zODVFZ1g2?=
 =?utf-8?B?SS9OcnFzNWcxdmtMU2ZMUCtUbXFuYXVjbzZXNFlaYUVMbFdUaktDeW5xVmJi?=
 =?utf-8?B?SG9jREVwL05qNHowR1ZzTVNwVURCMUlkTm9rL3BXckZTMzZhQ3RBcmVHa05k?=
 =?utf-8?B?bzB3SGd2WGE2ZXkzVjhYdzRMbENKN2RRNW9LRDBJLzdXSVhMTHQzTTZBVU9L?=
 =?utf-8?B?czh5Ykp2eXFXNFpWSDRPS003ZExMeWFscHdFVXpzQ3FKcCs0bkNqeElqZGds?=
 =?utf-8?B?eW91Y3psY0h0T2w0RGp3S29Zbzl2T0x3R0xEbmNMa0s5dm4ybFVmMnFTT3Ja?=
 =?utf-8?B?eUNpYVZibXFrR1c3cGZKWHBmZkJnR3lpbklveXlHbHZkblRhbERFbDRQYXFJ?=
 =?utf-8?B?cC8wOGphUmhOTVFYS2ZVZkRJQTM1eTFKNWt6OEh5TmVGN01oTkU1L085T2t3?=
 =?utf-8?B?QXJOQVFUeUVMRmdFRjcwWDZocGgxNkRKTkQwQjBoaFFSWUhEcGNRTDY4QkxB?=
 =?utf-8?B?NEtjUjNiejdwR3dOc2N6SzZseU44Z1VScWtUdGtMeXF2TW10TlVoYlV2emVr?=
 =?utf-8?B?c3RrSjB2SGIzcjhSTWZDMmI1UEZzSUFrQ2VKbCtPSTNZcEJ0M3N0VmdPSkho?=
 =?utf-8?B?UVJvMVpGZmdxYnhLRFNHZS8yeUV2d2R6cFhHKzhUQ3JsbnA4TU1CdjZkRVl5?=
 =?utf-8?B?MUJud1JOUWIxRkd4ZXdFZHYwL1RUd3ZrZy9vOG5xU0twS1FBOUpnSS9LZ3B2?=
 =?utf-8?B?WXhhMk5UMm0xb3lHM3hiSnhIQkg4ZEk3U1c2aytxNmF6Y3daVUQwOENubUw1?=
 =?utf-8?B?T3N4RjBOWEZDbURVbHJld25lejJDTlVPRWltSGJIUjAwT0ZMTTBDWWxTYnpC?=
 =?utf-8?B?U3kwK0dCd0NNU25VTENyV1RTS2JGZkE1QVBlbHJkUU9KRi9YUWpZaU1OdkhL?=
 =?utf-8?B?VklMa3FaVUhVMmJJT1VkQWxWRUF0cVhNV1dUeVZzem8yR2haQWNqZm5VcFhr?=
 =?utf-8?B?UUladlY4Z1hJSXk4eXk1cTI3V0ZqSmNmMXNzbUZHRUMyUE1EcGVYeVNGTURm?=
 =?utf-8?B?bjduZVhUM3BqNTg1VmdUYVdqNHBiSThlbzRvUkJ3TjhFQUgrc2hnbFQvMXdU?=
 =?utf-8?B?emp0MkJuazlBQ0VHZ0V2bXpvcm8rRTJsRVcxZW96OWNaMzNzYWsxU2laVE5z?=
 =?utf-8?B?bEZGU256L2tRTzBvMStWZXlKRDE5Zkp6WnNQTkNMTW04cUVHT2l3YUhVN2JE?=
 =?utf-8?B?Z0hDRkQ0NElKQVhJdG02YURrVVVFdEpFV3lRelVXa25vaWpuWTJ5MThBR01h?=
 =?utf-8?B?S0lqdkc3cThicW0rQk95NVBkeWNoZ0g2a0pYTUtzZGVlRHpNWlpwbThRRUJX?=
 =?utf-8?B?STJ4bHl3ekVlMlZkNUFPZCtINWpYWDNsR3NqTSt6V0lxK1o0U1JoQWJSVSt3?=
 =?utf-8?B?dUk2M21FSUs3aHNOcERJRXhmVDhFOUVOcEpTaUNtNENtV2M5eU1pY3pjWlNB?=
 =?utf-8?B?L1cxQk1DRzQ4S2o1OWlRMFcvVWx2di82eGRlQ01ZSHh4QXZVODI3RTdEZ2FY?=
 =?utf-8?B?STNKOUhNSkRia3hycXNNOENzcnFoOUtaMS9LSVNIWUQ0OXhkbng2S0pWcWN1?=
 =?utf-8?B?TWIzM05sQVkrbnV1MGYyMExDK1hCVkRsOGd3QjdzNjdBTCtRcDNTMXBPTGZT?=
 =?utf-8?B?Q3lIcForUEF4Z1VPcVZmdVlpUHhYRlJKL3p6RHJ3WkEyQzBSenBBZ21GSjBJ?=
 =?utf-8?B?ak53MUhVVmYwUDAyZlFSMFF0dktGWFY1K1E5NktRbTd3S1NkUmV3MWYvUXlj?=
 =?utf-8?B?dmlYYW9TVXdEVyswZEkrR1RxeVdxK0YzWE1JcEpaNitmVnJlZGVrK0d4bDN0?=
 =?utf-8?B?d0l0TS9DSTMxZ1c5R2tHZmFOLzBFa1VuWDV6ajRZenZkS015WVVKWVFFM2JU?=
 =?utf-8?B?Z0dHSzBDM25SSkgyekV0R2hqS0JqTVdOclJvejA1YWxnWHZkcWZsdkhCemZi?=
 =?utf-8?B?U0NSL0wxREZ6dkJYbXBxNTJnZ0NZdksxZ0QxT1JhUnVqeTV3bU5mU2xUMzVO?=
 =?utf-8?B?NUt2TGVRMW8zYXk5N2pKTlhIYU45YlIzNVRCS01LcHd5TGwvNVlIUk9Mems1?=
 =?utf-8?B?UURFQVhXNkJ2RXR5K0gvYU5SK2JKZnVYVFBIeGovQzQ5MHVyNmVHdU42ODU0?=
 =?utf-8?Q?OTH3XVaikH6s7iMnrbZPT09822lubVbgIRfPX3slzNgI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tEj/0Wi2KweqvFWo41F/mAKK4b/I4kjcQTHQSrag7Y89UpAYjhURqnpY8Bg5/jOLoNOX4Or1p+6UDISV92idr9icINj2m6wFsHg4XiabYEPmEQaqcEoz30xoTCCisvXne1CWp/EmEkYlk5PraT7P2U+UEDZBZBpBbP3VWPeIvpNBBzJYXfLy+1eEyCmPfR+ZyjDvNJcSfqimlWAWECc8U8EifR75QfPVUTNoHLYlC0XzW9mWgoOQt8BCBhDSNbgmW56k0NJJPZAmqouJcePb2tgkmXR48AW7OGPLzeItHi/yd6erRnwz+pDT4dUpBmBYT9y5GV4yOU3UuNVvImDOvDWPasRs6nyHX0spg34QuJpnMgW1yBlcJxuCAopxvZ9dSYUjGap9NxEh1g0O7wZCiZedCjVT1bd3i3MszU1Cyk9HLrQV0/NM5h0hCtci2Z8pb64IGLt4pNnzBRuZlJ9zApS/PG5SK3Iei2YahX+6ZKtZjsIVIQsBK6cP2Pm+x9N2ylsUQ5eAfAzxx+yvwmQbPDhdCEDIUwk3TCiZaPX37g6zhhhARqfx0l50aDqrhXGh/fNTTDSmuEWmKpBw8YhhA5o7m95KJC2MrW80dnHC3Mo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f458ca-ceea-4959-2a1b-08dcd9633bd5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 10:59:01.3256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pfVI0ymnBGYTgCuF5i/Gz2wHA7InF7liWw3g9U/lWxrUozOG6gb1FVzyC0nwiZDcKVhOtxcQiBgR1fP1Y54RlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6443
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-20_05,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409200079
X-Proofpoint-GUID: -yCH95wIR31NPZD2x6o0oiwWVdvHPfxn
X-Proofpoint-ORIG-GUID: -yCH95wIR31NPZD2x6o0oiwWVdvHPfxn

On 12/9/24 8:45 pm, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When running btrfs/321 with compression enabled it fails like this:
> 
>    $ MOUNT_OPTIONS="-o compress" ./check btrfs/321
>    FSTYP         -- btrfs
>    PLATFORM      -- Linux/x86_64 debian0 6.11.0-rc7-btrfs-next-174+ #1 SMP PREEMPT_DYNAMIC Tue Sep 10 17:11:38 WEST 2024
>    MKFS_OPTIONS  -- /dev/sdc
>    MOUNT_OPTIONS -- -o compress /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> 
>    btrfs/321 2s ... [failed, exit status 1]- output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/321.out.bad)
>        --- tests/btrfs/321.out	2024-09-12 12:12:11.259272125 +0100
>        +++ /home/fdmanana/git/hub/xfstests/results//btrfs/321.out.bad	2024-09-12 13:18:40.231120012 +0100
>        @@ -1,2 +1,5 @@
>         QA output created by 321
>        -Silence is golden
>        +mount: /home/fdmanana/btrfs-tests/scratch_1: can't read superblock on /dev/sdc.
>        +       dmesg(1) may have more information after failed mount system call.
>        +mount -o compress -o ro /dev/sdc /home/fdmanana/btrfs-tests/scratch_1 failed
>        +(see /home/fdmanana/git/hub/xfstests/results//btrfs/321.full for details)
>        ...
>        (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/321.out /home/fdmanana/git/hub/xfstests/results//btrfs/321.out.bad'  to see the entire diff)
> 
>    HINT: You _MAY_ be missing kernel fix:
>          10d9d8c3512f btrfs: fix a use-after-free bug when hitting errors inside btrfs_submit_chunk()
> 
>    Ran: btrfs/321
>    Failures: btrfs/321
>    Failed 1 of 1 tests
> 
> This is because with compression enabled we get a csum tree that has only
> one leaf, and that leaf is the root of the csum tree. That means that
> after the test corrupts the leaf, the next mount will fail since an error
> loading the root is critical and makes the mount operation fail.
> 
> Fix this by creating a file with 128M of data instead of 32M, as this
> guarantees that even if compression is enabled, and even with the maximum
> allowed leaf size (64K), we still get a csum tree with multiple leaves,
> making the test work.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>


looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>






