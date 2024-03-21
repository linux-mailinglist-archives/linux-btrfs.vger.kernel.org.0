Return-Path: <linux-btrfs+bounces-3492-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33544885819
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 12:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC0D42817F1
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 11:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27B95821C;
	Thu, 21 Mar 2024 11:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XTXqTXBn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xWGhBzai"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE7057867
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Mar 2024 11:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711020001; cv=fail; b=Jld4XDZ4wYDfm2oRYeP97B4hyvDB5aWJqjackWEL3/oiVVSl2p1XrOuWA0/cMjQbx2/XienVoWKhXQYTnDo3a+Td1Oqklsp46YjgvX4E27HH0UOL0qpX40xfUK29bT15HsUuYYK7A794Bq6FFiPQJoYADL64qtwwrpy2P8U8Dnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711020001; c=relaxed/simple;
	bh=ROkcNNGJjW0ez/aBb2walx5nJJ81KmDnfNOKulp8qSc=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=suPmBhaf4EjLjtoV9RIGMNdbEih5Ci0lkpkj7d0aVkxftnsmJfKwrfT/QMyJnntU8RJ196k2xCqG8NISIH9/UVFZOzIRO4TBLMhsRbhROQrh9w6HieqGLYPytJVjccs2+pvO9A3JiA603ukekOQaj1ZZWeMB0AkNzA4ANglCO3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XTXqTXBn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xWGhBzai; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42L24TH5027198;
	Thu, 21 Mar 2024 11:19:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=g72UYgdCfI1uqJ8iodJ1Hwii8cm5kPGapg204hpS/Qc=;
 b=XTXqTXBn50eEC7ylABd3Zquo5cH8FVQsSi8X/IzETytn4yJD8y+jhlVcWg89pQHAnejJ
 RqkRXjExQBl2QUzWiRzAS4rD1vqAuHdzQTtt1/WAflgRtMI4A3LC92C24FPHCZc9jDAE
 +pMucTxE3lyrpmNX7kdghu05pp5ZzU4UAClMnkyzUlR6+WWJqeFCLf3PP1B2Q9kg/Yv2
 pDgTDjmO44pvUmaE8mzlsSZeJDaTh4Qq0x1eZwRy+X0znllOo0f7biUgQkQve0ykTiWs
 um32lesBXnulEiG80tA3EIjPubbdJ0A2modGky7B7JwXKhnlD07mXorsvyS/sNGVWoz4 Bg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww3yua3k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 11:19:51 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42LB09ps005987;
	Thu, 21 Mar 2024 11:19:50 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v936x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 11:19:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=en6O9+tkg2t1+GqQhL6zgH7TxaChIhp1cYCU7DjGPfe3INAJbWm3gEKb0sRxW+bUGGCAl4mMKHXObC+BoF5XGydtKphbLYmLCNe6SeFtv77J/0vt/UjnRNd0ETqTdOxhvGrYw5mgN4q/OHhkcYCwUqrwICnIP4dW9m7FtIfGVJWDIHSrJlEikD+H9b22/hElBBYYXWFEY65f6SXMrkevSO0XTsi/VghBQq17iYfPFK7G1PuIGqAOslg0xKMdN+hDpWZKfJwEifJukJY0WD2NpTi4KvL2fo0meyviC6fpLaZHQAZsPr4o8KH5rNl7aBDyc5fJ60qKErrsaYDvDjoMtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g72UYgdCfI1uqJ8iodJ1Hwii8cm5kPGapg204hpS/Qc=;
 b=M3FMyTe3xGI1z7o3plRjROwDENF61q9pwoMc3Qk2EnRj6QolbloitdR039G/9V5+Nw3pAuBYCQ2DfcyfcBwNH3fo3iM6MPfU5H45Re0aSI76tMj1vI3CUpSPfnuxUkcgApA/wPVJQ6qHIxViO194M/uDYLq+Fj/8teUBbVJb83FJbaSRrPfnG0l6O/9Vpqx+BXc8S3dVHgKytlGK3q32B53NqSu7mvfFbw0KE80UNgd2F19GhaWqHuJMZDCvK9PPX2GcSwBBoqmLW23YxW7Cams/Zi5jxu8UWEHS6mTxJWigIqutnYJF7KVrnt0TKZUEpPXvysHMQk7boFar0T0unw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g72UYgdCfI1uqJ8iodJ1Hwii8cm5kPGapg204hpS/Qc=;
 b=xWGhBzaiA1UlRkPDcyqm0v9qrnEYL/DY5BrA8MxH1qyemTASLR6frWfw0CyeyTwSDimN/OOfVJN1N9jwQHLBrlantS+I7AHaLNmXfeIkge75vjGXPjPlrF2AIQOqMGwcPr3knKJd3lMdGNt8ero9eR0jvdDcYdyPDOTTsZcyBIw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6711.namprd10.prod.outlook.com (2603:10b6:208:418::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.15; Thu, 21 Mar
 2024 11:19:48 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 11:19:48 +0000
Message-ID: <b2b049b9-5e59-4472-a713-6b4a6cbdb940@oracle.com>
Date: Thu, 21 Mar 2024 16:49:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] btrfs: validate device_list at scan for stray free
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1709991203.git.anand.jain@oracle.com>
 <87d75575e16637a84b82326d5c53cb78cdf9a7e0.1709991203.git.anand.jain@oracle.com>
 <20240314171158.GD3483638@zen.localdomain>
 <718c4aaa-6891-49e6-a513-0bb0e3ec8036@oracle.com>
In-Reply-To: <718c4aaa-6891-49e6-a513-0bb0e3ec8036@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0177.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB6711:EE_
X-MS-Office365-Filtering-Correlation-Id: 9888c2bc-140e-4b87-10bb-08dc4998d195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vM8fVKUUCBTwBtI+Rcrq+sX8gwEa6WKyE6KVmoMm457Zhgf63n4no29coAWiEoXD2ULTA9CEE9Zm3gH3PdaxEMQVd1It319dOVyZ9RFzRtRQG+z7FBgoCpgigic5t+uLN/OzM04fFLcwzAvf4A+9jFxQeiMiK5qFAmgjiP60CVX08RWmmgr9QWyTOJNlqqyq6q5oXYRLtSJYdApn7ikP58y0HtdPWnxGR1/1nJ/4nn2jBlYC8AlBmieeDyLJl3q/THO64FEn1hkO0t2B4lzYTrcD3fusc2M1PCRxXXsLybLPQvtW+WGQPFKG5Us57YREO5ZwrsO8G24RTH09zKZFwA+srB59oFZfkZ5RCZxV2AeS4ewO5cIxjMVn5XvMP9ZhRbr3Pqg6N3VXMc4nBbIy2QohSqowfhzW20BoP7J0zgNXkDtgffc0F6GTpxv2oRbf3rMXH40F/dqi8x407aOtp/Hfd/TjwjIzpZedqMoVhQk/skNHpoIOanKG27kghrHd/p10QiBBxtGd1y7/MYAdSfRycwihgmo/hk6Rs4Pl0NK7iBZbVjl5f33An/WzwesI0jAyNJ5OQSoZij9HJdoXep84zkTK8G1ciWOOQPEPp6hSjuM6tHASw4m8Rx5xi/K16TbIqSZ5uTUrv4ieykvYIomsTwUe6YnMrD9VG0gHvDU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bTFGSjJPUDBUcVN4THdqQ0xhbm9kdUhIMzZoNTBDNG5mbHFWYU9ZQ0FndVNJ?=
 =?utf-8?B?VnYxZEdBaFAyRTRqRjFkU2JKMlE0VERvTXloUFBlWG9qaFBKeUQzV3AwWTFh?=
 =?utf-8?B?T09kbnpoVVRkalVJdTBFQVF6bFpHc0txTTRnZ1A5SUdoWXNHRDJNRSt4blZP?=
 =?utf-8?B?c1BHbGgzNUJHc0VRSkZRcUFSak9sRndmc1Q1eEZIU1ZmdEZtZ3p5SVloOVd3?=
 =?utf-8?B?VnJwaGVPSE1QOC9YUWFrcktLOEV1YVFyT0VIZ1I2L0hUY2E2ZThTNEp5TEFN?=
 =?utf-8?B?M0d0Ynd3R2xBTnorNktHZkpERG9IQWIybThQNzVQR3dDSUN5am9TK2hnTkNo?=
 =?utf-8?B?Y3pibTBBU256d3UxSWI4N3p0RjVWYkEwaWpKZU1aN2RFdFZ3b3hnamlDMWhn?=
 =?utf-8?B?N0tncWlodFhFRVFkRGJhNmxjS2t6RXJJZkpNQmFPWHNSSG85VEpGb0NuTksz?=
 =?utf-8?B?ckxOVlhsNzNIMGJjU1Yrbm0zMk5JN2RCRnJKaEVYaHdWbnF5b08yemlMeWtT?=
 =?utf-8?B?b1ZFRlpxakswQlQ2WWRWMWhrLzA2YW04ZEI5SUp0a1YxQXVmcG5XbWRRWlR1?=
 =?utf-8?B?bVczbUoweVVhbHJKRXdiZEpoeElDdGdnZTJSRVIrbEdMR29nMmJxRG13SmRS?=
 =?utf-8?B?TmxudTFvN0syMFFDSS9RR2FFMkZPODk2a1JCZzRia0lPU2xuUmZpalE4azNT?=
 =?utf-8?B?VTBQSUkycHB2d3FEVHBsYjNDV00zbnpRcUNFTUpVTnlGTGFyakMwVEVwQW56?=
 =?utf-8?B?TXJkK2s2MjJTUmNPQnNlbXVKN0I1SDVrV2UzV1gzdmtqM0lzUFNuaUVKZHlS?=
 =?utf-8?B?aG5KTEpNWUVocmtiUmlhWmt0OFhMTUZ2aklWM09BbU4xWktNcFYrYUYrTEhz?=
 =?utf-8?B?TUNzYnZTVXdBcHVPRmE3emZzaEppeUdOU3dKTlpJUVJKaGZjYnAxcjdjY0Fy?=
 =?utf-8?B?dWVCUHFHUEk1azVlNXk3VVRBOGdzc25SU24waytKNDZPb3hURk9FaVJQUkxQ?=
 =?utf-8?B?OGZUT3p4Rit6dUJ4TG9Fem1qcFk0eTNjQlE1aVYrVEE3YmZaV0k0aTFZcGNy?=
 =?utf-8?B?NFpOdzI5TUMxL3NWTEYwN3Z4Vjl2U2kzcGlkNmdpamVhM0IzRUFZMmp4YUFr?=
 =?utf-8?B?U3FhNUF0d3J1L1NLMUdOQmxYcmxxKzZtMFh5MGVFaENSMGRPK29hdTk1Um05?=
 =?utf-8?B?bWpVWnBKYWlNQWFYblRkb01UbTVIYkpuZTVxZk42aUgwZnlXOWNVVkhFdDRN?=
 =?utf-8?B?WTZST0tkcHNURHJyQnpXWEE4eTg4dlUzOUlwNkxweWNQbmZBMGYxVVh4ZElo?=
 =?utf-8?B?ZGFrek1RNmRqUlpVYmx4d2Nidk4zSmYxTW1kN3NSYVJqVGg4RG50ZGcvdEdP?=
 =?utf-8?B?TEloTVI0cTlaZGYxdkNqVmljSEJRb0RBMHF6bS90UDhUc2krSnJPTEVid1h0?=
 =?utf-8?B?SE9GWjRhUGJGSUxSeFNLa1E5OGR3eTFSNi9weWl1RDFvbUxZcWNRRTF1RHJI?=
 =?utf-8?B?b0dyMFZFRkNDS2JPZEFyVG5SdzRUdkdyWS8zUWo0ZlFJVklPT3lTRUQ5MEdK?=
 =?utf-8?B?ZXJjMjl5cFVrMHdlL1BLeW1jbGNSYlRTMFh5bHZ1bEgyOTVNS01kRnAzVnM2?=
 =?utf-8?B?ZGpvVWNsdGdKMXVjdGxOeWZnNDhTUnI3SHdQNElTa2ZKcDJkMGVxWGMxQnBH?=
 =?utf-8?B?OFlqazNuOGhJM0d4eDRKR0xja2J2eXN5dXNLQjR4c1JIM0prZUNleVlCMHZM?=
 =?utf-8?B?QXdrZlh4WGlXOGZMaFpnbmhpai9DQ1Q3c09iSnd6TTlXZU5hRnNEdllWV08z?=
 =?utf-8?B?dlhINEtmYjVXOC9XU09DYURmQUZvN01lWUovbmJKdzNYUzFRN2kwVG9lTERh?=
 =?utf-8?B?VTFaMGtHTUw2UHVQTWVGMncxdlZaZkViSUxZUlhxMlg3R2w0NmlxcmdXbk5H?=
 =?utf-8?B?Mk5MdDRxRE9reWQzK2cyT05IMjJMWk1JVnRPMUxoU1kxU0x3QU1WWWJ5SHFY?=
 =?utf-8?B?OGllT2lkcWtBOEVpVWx5SklvV3UxRWxYc20vNXVUU0Z2Zk9WRzZZdUVKT1pC?=
 =?utf-8?B?UXpOTTNuQ3h3cC90RDVmM3BpYUpHdnd6UmpLUENXV3VMZ25UK3JxL3RTcjJj?=
 =?utf-8?B?RGlvUmFGY0VGdkRKZ1JBQ1ZBcEpoS040T2xpSE9scUJWZ3FqOXZ2cnkyalhF?=
 =?utf-8?Q?tNXhMc+EgqCTW7TkCf2H1Eo6WfjbFtuHSTHPgwxsNEui?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	EYPwYaSVAOHJWZ3MScy2Gu0bVTp/aUhyMxA8JwV10fNt6X4ThgzY8eVtlEuobtRvjpTNI9F5vFX/YY8nTfFw6CKrxmAaGic0p5t8226/0Q6BYyx43ZVSlOUaLugXelUtXm3Ijr4qp51G9L+T0CmEkERacAqcntJb8A51YcthVDGv5RJIFV7Pybs7SmDXScOF5yjfCFOwRylrL5j8hFsYbDhJ7LEc9KhAQX+ivjfqV1Zrxq/ILTtLQ9GqmEdQHf/9H+A+g+awg4BWHgvREivx8PbFImx5Wvsl+SrmbSf15cmef4g/vIOncJFB6B7lmHoKRUC/JIj2BDWuEB5BZDCAOKox+2blW8wLigUTYg8uo03glEUoIdO8BoDk9otXWVVQNkTN0JoC0IYt0eFUJuYIiqnzhtLBbEf9s+46Htn170xP5s8M5IOzv9zd1fyAQpP0MFdiY62y1bYjWPVNyUWnlrM/8gc9DrmEv2KeRngvZvMhaIxLC4ZzIrY6TjVFsdCMRzI9fWCJUUDo0ZH8rsxom2M+wIe+jmi29jozllQuKZGp9uyHZZnwTc92R9h18u+zyvWjFPASpiTQxGYJ1rLRA83iFi3z/BZZdHmumg+YLv0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9888c2bc-140e-4b87-10bb-08dc4998d195
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 11:19:48.3176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pfYQxbMWgvl9Et5bwB9cIwXOVCuFrcFoGXBUJcLqAjFhdE6C8A70Ac1DN7Gka2j0E0YshbKpBGPrTys+duDfDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6711
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403210079
X-Proofpoint-GUID: nFGMZD9oMb093YBoNglNz5-Dl0t_dOa6
X-Proofpoint-ORIG-GUID: nFGMZD9oMb093YBoNglNz5-Dl0t_dOa6


Boris,

Gentle ping?

Thanks.

On 3/16/24 19:43, Anand Jain wrote:
> On 3/14/24 22:41, Boris Burkov wrote:
>> On Sat, Mar 09, 2024 at 07:14:31PM +0530, Anand Jain wrote:
>>> Tempfsid assumes all registered single devices in the fs_devicies 
>>> list are
>>> to be mounted; otherwise, they won't be in the btrfs_device list.
>>>
>>> We recently fixed a related bug caused by leaving failed-open device in
>>> the list. This triggered tempfsid activation upon subsequent mounts 
>>> of the
>>> same fsid wrongly.
>>>
>>> To prevent this, scan the entire device list at mount for any stray
>>> device and free them in btrfs_scan_one_device().
>>
>> Is this an additional precaution on top of maintaining an invariant on
>> every umount/failed mount that we have freed stale devices of single
>> device fs-es? Or is it fundamentally impossible for us to enforce that
>> invariant?
>>
> 
> Hmm. That's the ultimate goal: maintaining such an invariant. However,
> there are bugs. So, this is the place where we can detect whether we
> are successful. If we aren't, then we can work around it by freeing
> the stale device and avoiding bad consequences.
> I think I should also include a warning message when we detect and
> free, so that it can be reviewed for the proper fix.
> Does that seem reasonable?
> 
>> It feels like overkill to hack up free_stale_devices in this way,
>> compared to just ensuring that we manage cleaning up single devices
>> fs-es correctly when we are in a cleanup context. If this is practically
>> the best way to ensure we don't get caught with our pants down by a
>> random stale device, then I suppose it's fine.
>>
>> A total aside I just thought of:
>> I think it might also make sense to consider adding logic to look for
>> single device fs-es with a device->bdev that is stale from the block
>> layer's perspective, and somehow marking those in a way that tempfsid
>> cares about. 
> 
> 
> How would we know if the block layer considers a certain device's
> block device (device->bdev) as stale?
> 
> If you mention a Write IO failure, we already put the filesystem
> in read-only mode if that happens. But, we can't close the device
> due to the pending write. (Some operating systems have an option
> to call panic, which dumps the memory to the coredump device and
> reboots.).
> 
>> That would help with things that like that case where we
>> delete the block dev out from under a mounted fs and mount it a second
>> time with tempfsid after it's recreated. Not a huge deal, as we've
>> already discussed, though.
> 
> Yeah, thanks for brainstorming. Basically, we need a way to distinguish 
> between the same physical-device with multiple nodes and different 
> physical-devices with the same filesystem.
> 
> Thanks, Anand
> 
>>
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>>   fs/btrfs/volumes.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index 60d848392cd0..bb0857cfbef2 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -1382,6 +1382,8 @@ struct btrfs_device 
>>> *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>>>       lockdep_assert_held(&uuid_mutex);
>>> +    btrfs_free_stale_devices(0, NULL, true);
>>> +
>>>       /*
>>>        * we would like to check all the supers, but that would make
>>>        * a btrfs mount succeed after a mkfs from a different FS.
>>> -- 
>>> 2.38.1
>>>
> 

