Return-Path: <linux-btrfs+bounces-3718-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C1C88FBFA
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 10:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F048B28284
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 09:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA41657B0;
	Thu, 28 Mar 2024 09:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e4eGL9qQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ai3l61PE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9824D41C62;
	Thu, 28 Mar 2024 09:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619350; cv=fail; b=jucDyinSc5luh+AFcnoFkYUFfayxOwEie443zUHrflvM+F5eRmJlOa1OS1rnn601p92uPDN8mwXsxPNk31iMAVyOQAiMjwzi91xn09xZgbfjDBezCND3NQkKdekIRF5Ls9/BZwvGO7mrDkAK9KvUqRbNFyyef0d/znvhC0Q15Ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619350; c=relaxed/simple;
	bh=PrPprzHBOPAK4fyHz71QEj3m3spSWjOhvh/13EjId+4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PK3Cjywle+NWdNtb+yTV5BbaNVHNCYCMswDEegVdV9WN3By/nIbMvdxu5UFy42BmYbvEcsD1CM5+ch7d2iFkq8fZ4AKZceUu6IA0/xb0iUhmnnXML70y6ktglAoQgHecxAxdKbmRWnQjI4nQglEYMuXBKHAxtSc5kciEIwnBdiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e4eGL9qQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ai3l61PE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42S90rR2006833;
	Thu, 28 Mar 2024 09:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=KVeErWXRg5Ob2O3eRpmSxCjZK3ZLcVEwO8FgGGU/x+o=;
 b=e4eGL9qQ8QfG0BJr5wv+0imRGTh4+jLcYwhya//TFIehPEIlhK9gELHCPmFuMFjCmQRg
 I+8Ki0lnDitocJfoBkH32ieFehF9LLMKBV/YmWYPfV9aobaV+t/vm94ydZ0w78tZOGIJ
 nz+DunIzwVGZ8N5nOTQ6h4ZUZ0Ie1MK7mSDEetImosWtH64Egj8P6NwPsX9koEOYsftm
 ukQekaTaRvk3OAc1e7kf5r+nEzxH2IjotU6hjuk/7H9ZOLgBbqCNZwVkI5ewDRUx/Ry6
 olytULmY1jyuLmxCuislrDqQNa9Ww2QREou8GkeZgw6KwxS/9SYhSEnjOoiuQ9SmJg3G AA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x28ct8n2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 09:49:02 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42S9MPio018241;
	Thu, 28 Mar 2024 09:49:01 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh9yh27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 09:49:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFvZILVbOXwAB462LWZ7gWrAsayy+BhKNQ/sYMwA2ffyps+cKZSz0KprAjU5QEAa7qsGABSlFq2brPHjZo9kK9LH3/tpXsTM8tjCrtOTo4i8/UhBaGpT4sUW1+C3MBNnfw8L1Au9G8vUGN4KPVsfuJRb+z1pC55U3w3pclfdXUfSKMJufe20VYobqEXpirClxfAWeIZvC3CHJRZ5W0LDXaWGuFGpy+6xld/Hzw9ACWgiFYlpVTCpsUI5I81SA6BJvTjjSr+aS9Iu2p4GP2pqFu7QwchNs+tmgHYxKKqBrAO4MMWhQiOsuz6NiXZ8ZcfBz5Y6cJVHtHH5sqPvO1eAVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVeErWXRg5Ob2O3eRpmSxCjZK3ZLcVEwO8FgGGU/x+o=;
 b=XiMrijz2XMtUUbx0Qj8pdnsGzjko1OsEOOZF46lvzPRw/0wgomVIGi92dwKm5ZJhSgXRFzZ/BQ9AyEHZnsVTqLvNAf0huYUEKhLG8jLMRGK16gY5diRaMr4wievGQ5X7iILQWi0HF57RDYIeqSbEWq/vlIgeMQ1UO1AdFTmkvToSsUyQ55hDxoFuitBFJ1pgxWuLblBmhSzaOR7SHeFIKa+nipMqFLoXvDVhClnHDV/IjMbN0vR12Mh/yLYB/1hitGyXCG/8GOymEaqot2rAoJRCBCZoLQ9b6xfFHppmeLApDgKuxOKvNT71mlLbnAlYThvRUYNIcn33wFh7FoFbkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVeErWXRg5Ob2O3eRpmSxCjZK3ZLcVEwO8FgGGU/x+o=;
 b=Ai3l61PEazFqDhi3wLUYEr0yXpPFXDFs+CksHQFxXbqXI4c1HSoiL0QeFHh21OagDMbW1UpH43hmCnStE2mBIgAPStzJyjA9OWfGJMHlzMIpeU2cWZLAURsE5VnRT4chf/mXBYA6+5NAYHaMIPUHenD/Jrp+9nWmqyobIX3oPL4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB5947.namprd10.prod.outlook.com (2603:10b6:208:3d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 09:48:58 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 09:48:58 +0000
Message-ID: <b976a6da-4735-4dc6-8de4-8049ae8af6a1@oracle.com>
Date: Thu, 28 Mar 2024 17:48:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] btrfs/06[0-9]..07[0-4]: kill all background tasks
 when test is killed/interrupted
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1711558345.git.fdmanana@suse.com>
 <48866623524ab565944db6f7fa61f6a0ce0c0996.1711558345.git.fdmanana@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <48866623524ab565944db6f7fa61f6a0ce0c0996.1711558345.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0143.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB5947:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fb000fc-debe-4aab-aa59-08dc4f0c4a49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	oFKRVie7iB+Mq6XPgLLgNQfZpzaub+ZTia9ZicdjPdEs6wy/Mn2CQu6j32RrokKvZVYToa1CVzl03cWV8gaD8uM7dSXb3csAudRUC510AgbjEjU1sfz0nhza3+lruRjb6Va5z6mXqVfAz0PB63WdHF3MjWDjoUOwz409rNTSUOMcD1czC/1jFll/GwF/O5yobH9uWVrvhSs3RQNIoFJ2UeS+2sRjIwohV0Dm+wYAVx5kRZgFhqEam4vIMShM4uft5TKt+sADU2YjlnndbKd6c1ht27dp5f/2dkI2cJP2qF7ECyD24L2kmMAEUTMGQjKgIn6f6nOO4OqSozhavscAHE+Bb8jFmXlw3XZBVwwuE+EUb5cdEcI3AWHIo9XIRfo6dXZtHj8XHg+T1mPWYaElsTVUiP6A70rOwDko9rl8INtX6aER+DjknM9K4hkozKmTBunJEj9mjUt+idAw4yAcWzKtazf668zLTLOB6UO3DNdPNlD+OtHdQiHb253LeWszSpU9lkxFNWyxh3oAvaiLtB03U43hykKYiO76xxu5RuzyfPQIyKJIEBUIKaytPHaJSd0ufl3nRQVzqyzjkz5kmdnVk6RPuOdJHg9VvB3y+GA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QVlVRy96bllqeHJiV0hoWXRKWUFqdU9wbUNXSjYvdnF6RE0zRndZNEtzSkN1?=
 =?utf-8?B?Qms5K2Jibm4rdWhDTC83b3F4SkZtNkFEMW8rUVljUU1FdytXMVJ4S2gxUTZ4?=
 =?utf-8?B?cGVnWGg1R204L3NpM05JWGRlYUxhNUFCdmlCYVhINVk0bXFmd01CSzRmTWZz?=
 =?utf-8?B?MUF6SDhPeGl2MEEwb1RVYVhtRDJUUmFwTXZCdmlmRDhyYUFTTFB1VVZYWlFp?=
 =?utf-8?B?STBHeGt3YzFzUkdzQWhhYnBuNCtaeEszUk1OREd4SFdXM3NsVCt3RTRhMFQx?=
 =?utf-8?B?aG56UFJ6QjV6dFE0MEJkelB3MVpxdzNHdFhOQTFkNDZ0cS9vZG10SWpLUmJH?=
 =?utf-8?B?MEg0bFlJTUhDYzdFSndiKzM3b3dTZmZTck5sTU1FSXBwK1pjc2cycWU0OXFt?=
 =?utf-8?B?aGVJeWZ6UkNaTzc4WWM4OGhBbjE3aTZ2aTdlY1hzNUMrTkdBdWNGb3Erc01H?=
 =?utf-8?B?WFFtSExXTkZPYWxQSEpMVE5mS01vR3ZzaEZxalJZa0dNK1QxWDdwc3BNbzVH?=
 =?utf-8?B?cnltSmw0TkxDQmRDaUJrM0E5T255cFdwTEY3VVEzOHArNXVPUWlXS3FMWjMr?=
 =?utf-8?B?T1R6V2doTWc3b1R5Zy9YQUZyRmJzLzlsWFNKRnNxay9yTzdENkZsbFdLWTZS?=
 =?utf-8?B?WXh4aXRFYXA5RHgyQUU0WFR3bnViTi9oNUN5bjBEZTZmd1EvdTBNSm9LUG1u?=
 =?utf-8?B?c1JtRmU2TVdWQVk3UjZRQk9MTUg3Nm9abnIweFBtTzAwYXdVSDZlRzViVU4x?=
 =?utf-8?B?YjMvSlNMVWtXMzh4cjdJYkpzVkpzN0prSUlVV1cxOGFQbDVZMmNiUm9QY05G?=
 =?utf-8?B?YU5Nd2JXNGkwWHJZZGZjVisyampNSEZHVmJTZzg0enN6UnkrOUcvK0E4T3Nl?=
 =?utf-8?B?a0ZROGdUNklacFJDTXdEYXlwTncrdWRROUpWQnlDZUZDcSsyMng2OUtTbDRG?=
 =?utf-8?B?SS9RUk1iQXRFMmlOYU9RdDFYRDhIbDlhRjNPb0VKSFRON3haVHdzazhNeDhC?=
 =?utf-8?B?bmFaQk5qelhtbkdOaUZadkN3M1c4djYzWGl5SUwyR0N3Y3NRajhzZHl2dFcz?=
 =?utf-8?B?N1ZkSTZXdFhIQzA0SFlJMXhBejQ1UG9PU0MrR2FQT3ZnNUVmMTNud3lEQWVJ?=
 =?utf-8?B?N1c4dGtRNnZXS0pJSGN0N25VU09ZZlE5OXc3Q1AwYUFmaDFlUVpZNEcvcGdP?=
 =?utf-8?B?VFNCSEV6L3Jza1hQWmRhNktydmZDZjgzZEJpS0dlT0lGVG4xeTIzaDRkNys2?=
 =?utf-8?B?aTZralhrU1BGTTlsM0wyYVZwNG5IaGY0SVBNTCtJd015ZDdZRGN1Q3lxd2M5?=
 =?utf-8?B?aGNFQi90VThvc3JPM1R2R2tUQWRJZlhnOWZGNnVqVGtwT0IrakZUQi9iUXBv?=
 =?utf-8?B?RGdyRXdRT1JWR1hzVGptVENZVEdhdG1IT05YOHFVY1BqZTZoa29Qb2lmZGVJ?=
 =?utf-8?B?Zk5HZEVldXpHdDR4Ty90RUV1NHJWenhyNHFrS3VGOXRRbGNuT3lmSENGS3BJ?=
 =?utf-8?B?TFpmcDM5djcrdHZPWjZORUdjYkVwVmw3cHhxdlR0cGl4aWRWMWwySXl5dUl0?=
 =?utf-8?B?V2FOakZERHVEbWFTUlNxTk5jSCtOMW5WenVxZHBGenFQbGkyK1RsU05IUDVy?=
 =?utf-8?B?T0ZaUHp5NVAvNzV1NjYvYzlxMFpZZklJaWUrNS9aUU1XQTVMVzh1V3Y4R2pH?=
 =?utf-8?B?b2tTZ0FXaCswQmlycDd0QW1mc1VFSmV2ZWlEWDJsd0NRaGtiOEZtR3JzRUk0?=
 =?utf-8?B?N2xBb3U3ZzE4dDVMZ3VuNk5vZFZmdVozcmhvL3VUb2pWZTZnT000OFVQekw2?=
 =?utf-8?B?M2t5Sk9LOEZjMkd4MUxLa2dxMEdtZmNnL0tzTjYzWFFYbWV4ZXpPMzhUWmpR?=
 =?utf-8?B?ZnFCSnNjT0V4MjdXTWsvUVBTcmRMNUpYaFd0dGlGRTNUTk1SY1ArbThaMzMy?=
 =?utf-8?B?RWZEZVBjamlSTENXTzZQNE1QL0NlTG9xdlFnVGh2ZVlySysvTjBRNDJTak90?=
 =?utf-8?B?RlREckVJY3cyeUZQcGUrL0x6aVhLTnNvNFl4MENQRGhheWtoZ0M3elJid3VZ?=
 =?utf-8?B?ZTg3OGlYOENNd0hCbm01UHhhR1hDUlRtbXhsRUhKRUl2eCtBOEQ0WGU2MlFq?=
 =?utf-8?B?UENQUWJwU3IxNDIxYzB5VkpqaHpCU2poWFFVK0FxVFMyeEhNbmx4YWpmOE9V?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0RD3DEn6nqUBTdUnq63TenhlYTzfs74lyrldS1oFJy0ve/LU1GlsFwtMPyNGxo7WFNPjtKjl012b/STamhQFLsnjLXM0/F6lxBzbxdvNWlgO2BP+ziQ+qwPZUqibtch5nfcgxqgDIeYQ/Js38ULrErAHj5aTiNFiRwBI/ep3TvvHEFgt6py/NGnmLmqj6KAZdwZ8lYJrXpLSiRnvwq/Yt1gj2wnrs+zwz1QP7eGIURcRndW3MBRFh3bKEEBTXprqPzpIP4dwdlOefTJpU4vwjPhQ2S/a1szr42m+q0A9QxeSPL8I2zO9bNfLADZqx5TUIRiDCBTdkPnalcKrikutEg96wOGwuzfUcVOpacu012wg8nvBN85k+dgXv6zqSS4wmNh7cHxrVc1QLO0JKZGMzxBD4NXilmcGA5V0xffGN1kJ9qioD3vTWBXUPg08tRPrAunF4bZESXrkAYYzd8Rc8eMhsR6v70ziQ7zAjVUj1+MsGzkWylWiurBEbuyTB93/VLwmWBjbv4tPH9ZKiTNOV0QXhbFirnj83RJCWaQ78t5LRy1z9X9Nii5sRNcBpSZY5Ry7BbCHCEv/n8yxPZqbB+D8Vqp3y3/kiOAupFX6NSQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb000fc-debe-4aab-aa59-08dc4f0c4a49
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 09:48:58.7508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LMBqcjw8QlKNvnm0LJvqrvrY1Qv4w4zZxkhQnuAlGk8KBzGQxOGU7M0bqzIhWds1rDvVtcFp70fNDY4LmRtO7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5947
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_09,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403280065
X-Proofpoint-GUID: k0khYwoh4gGfxhoIjKpMeLmRbP1KpZDg
X-Proofpoint-ORIG-GUID: k0khYwoh4gGfxhoIjKpMeLmRbP1KpZDg

On 3/28/24 01:11, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test cases btrfs/06[0-9] and btrfs/07[0-4] exercise multiple concurrent
> operations while fsstress is running in parallel, and all these are left
> as child processes running in the background, which are correctly stopped
> if the tests are not interrupted/killed. However if any of these tests is
> interrupted/killed, it often leaves child processes still running in the
> background, which prevent further running fstests again. For example:
> 
>    $ /check -g auto
>    (...)
>    btrfs/060 394s ...  264s
>    btrfs/061 83s ...  69s
>    btrfs/062 109s ...  105s
>    btrfs/063 52s ...  67s
>    btrfs/064 53s ...  51s
>    btrfs/065 88s ...  271s
>    btrfs/066 127s ...  241s
>    btrfs/067 435s ...  248s
>    btrfs/068 161s ... ^C^C
>    ^C
> 
>    $ ./check btrfs/068
>    FSTYP         -- btrfs
>    PLATFORM      -- Linux/x86_64 debian0 6.8.0-rc7-btrfs-next-153+ #1 SMP PREEMPT_DYNAMIC Mon Mar  4 17:19:19 WET 2024
>    MKFS_OPTIONS  -- /dev/sdb
>    MOUNT_OPTIONS -- /dev/sdb /home/fdmanana/btrfs-tests/scratch_1
> 
>    our local _scratch_mkfs routine ...
>    btrfs-progs v6.6.2
>    See https://btrfs.readthedocs.io for more information.
> 
>    ERROR: unable to open /dev/sdb: Device or resource busy
>    check: failed to mkfs $SCRATCH_DEV using specified options
>    Interrupted!
>    Passed all 0 tests
> 
> In this case there was still a process running _btrfs_stress_subvolume()
> from common/btrfs.
> 
> This is a bit annoying because it requires manually finding out which
> process is preventing unmounting the scratch device and then properly
> stop/kill it.
> 
> So fix this by adding a _cleanup() function to all these tests and then
> making sure it stops all the child processes it spawned and are running
> in the background.
> 
> All these tests have the same structure as they were part of the same
> patchset and from the same author.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

> ---
>   tests/btrfs/060 | 22 +++++++++++++++++++++-
>   tests/btrfs/061 | 19 +++++++++++++++++++
>   tests/btrfs/062 | 19 +++++++++++++++++++
>   tests/btrfs/063 | 19 +++++++++++++++++++
>   tests/btrfs/064 | 19 +++++++++++++++++++
>   tests/btrfs/065 | 22 +++++++++++++++++++++-
>   tests/btrfs/066 | 22 +++++++++++++++++++++-
>   tests/btrfs/067 | 22 +++++++++++++++++++++-
>   tests/btrfs/068 | 22 +++++++++++++++++++++-
>   tests/btrfs/069 | 19 +++++++++++++++++++
>   tests/btrfs/070 | 19 +++++++++++++++++++
>   tests/btrfs/071 | 19 +++++++++++++++++++
>   tests/btrfs/072 | 19 +++++++++++++++++++
>   tests/btrfs/073 | 19 +++++++++++++++++++
>   tests/btrfs/074 | 19 +++++++++++++++++++
>   15 files changed, 295 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/btrfs/060 b/tests/btrfs/060
> index 53cbd3a0..f74d9593 100755
> --- a/tests/btrfs/060
> +++ b/tests/btrfs/060
> @@ -10,6 +10,22 @@
>   . ./common/preamble
>   _begin_fstest auto balance subvol scrub
>   
> +_cleanup()
> +{
> +	cd /
> +	rm -rf $tmp.*
> +	if [ ! -z "$stop_file" ] && [ ! -z "$subvol_pid" ]; then
> +		_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
> +	fi
> +	if [ ! -z "$balance_pid" ]; then
> +		_btrfs_kill_stress_balance_pid $balance_pid
> +	fi
> +	if [ ! -z "$fsstress_pid" ]; then
> +		kill $fsstress_pid &> /dev/null
> +		wait $fsstress_pid &> /dev/null
> +	fi
> +}
> +
>   # Import common functions.
>   . ./common/filter
>   
> @@ -20,11 +36,12 @@ _require_scratch_nocheck
>   _require_scratch_dev_pool 4
>   _btrfs_get_profile_configs
>   
> +stop_file=$TEST_DIR/$seq.stop.$$
> +
>   run_test()
>   {
>   	local mkfs_opts=$1
>   	local subvol_mnt=$TEST_DIR/$seq.mnt
> -	local stop_file=$TEST_DIR/$seq.stop.$$
>   
>   	echo "Test $mkfs_opts" >>$seqres.full
>   
> @@ -53,9 +70,12 @@ run_test()
>   
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
>   	wait $fsstress_pid
> +	unset fsstress_pid
>   
>   	_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
> +	unset subvol_pid
>   	_btrfs_kill_stress_balance_pid $balance_pid
> +	unset balance_pid
>   
>   	echo "Scrub the filesystem" >>$seqres.full
>   	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
> diff --git a/tests/btrfs/061 b/tests/btrfs/061
> index b8b2706c..fec90882 100755
> --- a/tests/btrfs/061
> +++ b/tests/btrfs/061
> @@ -10,6 +10,22 @@
>   . ./common/preamble
>   _begin_fstest auto balance scrub
>   
> +_cleanup()
> +{
> +	cd /
> +	rm -rf $tmp.*
> +	if [ ! -z "$balance_pid" ]; then
> +		_btrfs_kill_stress_balance_pid $balance_pid
> +	fi
> +	if [ ! -z "$scrub_pid" ]; then
> +		_btrfs_kill_stress_scrub_pid $scrub_pid
> +	fi
> +	if [ ! -z "$fsstress_pid" ]; then
> +		kill $fsstress_pid &> /dev/null
> +		wait $fsstress_pid &> /dev/null
> +	fi
> +}
> +
>   # Import common functions.
>   . ./common/filter
>   
> @@ -51,8 +67,11 @@ run_test()
>   
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
>   	wait $fsstress_pid
> +	unset fsstress_pid
>   	_btrfs_kill_stress_balance_pid $balance_pid
> +	unset balance_pid
>   	_btrfs_kill_stress_scrub_pid $scrub_pid
> +	unset scrub_pid
>   
>   	echo "Scrub the filesystem" >>$seqres.full
>   	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
> diff --git a/tests/btrfs/062 b/tests/btrfs/062
> index 59d581be..0b57681f 100755
> --- a/tests/btrfs/062
> +++ b/tests/btrfs/062
> @@ -10,6 +10,22 @@
>   . ./common/preamble
>   _begin_fstest auto balance defrag compress scrub
>   
> +_cleanup()
> +{
> +	cd /
> +	rm -rf $tmp.*
> +	if [ ! -z "$balance_pid" ]; then
> +		_btrfs_kill_stress_balance_pid $balance_pid
> +	fi
> +	if [ ! -z "$defrag_pid" ]; then
> +		_btrfs_kill_stress_defrag_pid $defrag_pid
> +	fi
> +	if [ ! -z "$fsstress_pid" ]; then
> +		kill $fsstress_pid &> /dev/null
> +		wait $fsstress_pid &> /dev/null
> +	fi
> +}
> +
>   # Import common functions.
>   . ./common/filter
>   
> @@ -52,8 +68,11 @@ run_test()
>   
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
>   	wait $fsstress_pid
> +	unset fsstress_pid
>   	_btrfs_kill_stress_balance_pid $balance_pid
> +	unset balance_pid
>   	_btrfs_kill_stress_defrag_pid $defrag_pid
> +	unset defrag_pid
>   
>   	echo "Scrub the filesystem" >>$seqres.full
>   	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
> diff --git a/tests/btrfs/063 b/tests/btrfs/063
> index 5ee2837f..99d9d2c1 100755
> --- a/tests/btrfs/063
> +++ b/tests/btrfs/063
> @@ -10,6 +10,22 @@
>   . ./common/preamble
>   _begin_fstest auto balance remount compress scrub
>   
> +_cleanup()
> +{
> +	cd /
> +	rm -rf $tmp.*
> +	if [ ! -z "$balance_pid" ]; then
> +		_btrfs_kill_stress_balance_pid $balance_pid
> +	fi
> +	if [ ! -z "$remount_pid" ]; then
> +		_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
> +	fi
> +	if [ ! -z "$fsstress_pid" ]; then
> +		kill $fsstress_pid &> /dev/null
> +		wait $fsstress_pid &> /dev/null
> +	fi
> +}
> +
>   # Import common functions.
>   . ./common/filter
>   
> @@ -51,8 +67,11 @@ run_test()
>   
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
>   	wait $fsstress_pid
> +	unset fsstress_pid
>   	_btrfs_kill_stress_balance_pid $balance_pid
> +	unset balance_pid
>   	_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
> +	unset remount_pid
>   
>   	echo "Scrub the filesystem" >>$seqres.full
>   	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
> diff --git a/tests/btrfs/064 b/tests/btrfs/064
> index 9e0b3b30..663442c6 100755
> --- a/tests/btrfs/064
> +++ b/tests/btrfs/064
> @@ -12,6 +12,22 @@
>   . ./common/preamble
>   _begin_fstest auto balance replace volume scrub
>   
> +_cleanup()
> +{
> +	cd /
> +	rm -rf $tmp.*
> +	if [ ! -z "$balance_pid" ]; then
> +		_btrfs_kill_stress_balance_pid $balance_pid
> +	fi
> +	if [ ! -z "$replace_pid" ]; then
> +		_btrfs_kill_stress_replace_pid $replace_pid
> +	fi
> +	if [ ! -z "$fsstress_pid" ]; then
> +		kill $fsstress_pid &> /dev/null
> +		wait $fsstress_pid &> /dev/null
> +	fi
> +}
> +
>   # Import common functions.
>   . ./common/filter
>   
> @@ -63,8 +79,11 @@ run_test()
>   
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
>   	wait $fsstress_pid
> +	unset fsstress_pid
>   	_btrfs_kill_stress_balance_pid $balance_pid
> +	unset balance_pid
>   	_btrfs_kill_stress_replace_pid $replace_pid
> +	unset replace_pid
>   
>   	echo "Scrub the filesystem" >>$seqres.full
>   	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
> diff --git a/tests/btrfs/065 b/tests/btrfs/065
> index f9e43cdc..b1e54fc8 100755
> --- a/tests/btrfs/065
> +++ b/tests/btrfs/065
> @@ -10,6 +10,22 @@
>   . ./common/preamble
>   _begin_fstest auto subvol replace volume scrub
>   
> +_cleanup()
> +{
> +	cd /
> +	rm -rf $tmp.*
> +	if [ ! -z "$stop_file" ] && [ ! -z "$subvol_pid" ]; then
> +		_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
> +	fi
> +	if [ ! -z "$replace_pid" ]; then
> +		_btrfs_kill_stress_replace_pid $replace_pid
> +	fi
> +	if [ ! -z "$fsstress_pid" ]; then
> +		kill $fsstress_pid &> /dev/null
> +		wait $fsstress_pid &> /dev/null
> +	fi
> +}
> +
>   # Import common functions.
>   . ./common/filter
>   
> @@ -21,12 +37,13 @@ _require_scratch_dev_pool 5
>   _require_scratch_dev_pool_equal_size
>   _btrfs_get_profile_configs replace
>   
> +stop_file=$TEST_DIR/$seq.stop.$$
> +
>   run_test()
>   {
>   	local mkfs_opts=$1
>   	local saved_scratch_dev_pool=$SCRATCH_DEV_POOL
>   	local subvol_mnt=$TEST_DIR/$seq.mnt
> -	local stop_file=$TEST_DIR/$seq.stop.$$
>   
>   	echo "Test $mkfs_opts" >>$seqres.full
>   
> @@ -61,9 +78,12 @@ run_test()
>   
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
>   	wait $fsstress_pid
> +	unset fsstress_pid
>   
>   	_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
> +	unset subvol_pid
>   	_btrfs_kill_stress_replace_pid $replace_pid
> +	unset replace_pid
>   
>   	echo "Scrub the filesystem" >>$seqres.full
>   	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
> diff --git a/tests/btrfs/066 b/tests/btrfs/066
> index b6f904ac..feb6062e 100755
> --- a/tests/btrfs/066
> +++ b/tests/btrfs/066
> @@ -10,6 +10,22 @@
>   . ./common/preamble
>   _begin_fstest auto subvol scrub
>   
> +_cleanup()
> +{
> +	cd /
> +	rm -rf $tmp.*
> +	if [ ! -z "$stop_file" ] && [ ! -z "$subvol_pid" ]; then
> +		_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
> +	fi
> +	if [ ! -z "$scrub_pid" ]; then
> +		_btrfs_kill_stress_scrub_pid $scrub_pid
> +	fi
> +	if [ ! -z "$fsstress_pid" ]; then
> +		kill $fsstress_pid &> /dev/null
> +		wait $fsstress_pid &> /dev/null
> +	fi
> +}
> +
>   # Import common functions.
>   . ./common/filter
>   
> @@ -20,11 +36,12 @@ _require_scratch_nocheck
>   _require_scratch_dev_pool 4
>   _btrfs_get_profile_configs
>   
> +stop_file=$TEST_DIR/$seq.stop.$$
> +
>   run_test()
>   {
>   	local mkfs_opts=$1
>   	local subvol_mnt=$TEST_DIR/$seq.mnt
> -	local stop_file=$TEST_DIR/$seq.stop.$$
>   
>   	echo "Test $mkfs_opts" >>$seqres.full
>   
> @@ -53,9 +70,12 @@ run_test()
>   
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
>   	wait $fsstress_pid
> +	unset fsstress_pid
>   
>   	_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
> +	unset subvol_pid
>   	_btrfs_kill_stress_scrub_pid $scrub_pid
> +	unset scrub_pid
>   
>   	echo "Scrub the filesystem" >>$seqres.full
>   	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
> diff --git a/tests/btrfs/067 b/tests/btrfs/067
> index 7be09d52..0bbfe83f 100755
> --- a/tests/btrfs/067
> +++ b/tests/btrfs/067
> @@ -10,6 +10,22 @@
>   . ./common/preamble
>   _begin_fstest auto subvol defrag compress scrub
>   
> +_cleanup()
> +{
> +	cd /
> +	rm -rf $tmp.*
> +	if [ ! -z "$stop_file" ] && [ ! -z "$subvol_pid" ]; then
> +		_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
> +	fi
> +	if [ ! -z "$defrag_pid" ]; then
> +		_btrfs_kill_stress_defrag_pid $defrag_pid
> +	fi
> +	if [ ! -z "$fsstress_pid" ]; then
> +		kill $fsstress_pid &> /dev/null
> +		wait $fsstress_pid &> /dev/null
> +	fi
> +}
> +
>   # Import common functions.
>   . ./common/filter
>   
> @@ -20,12 +36,13 @@ _require_scratch_nocheck
>   _require_scratch_dev_pool 4
>   _btrfs_get_profile_configs
>   
> +stop_file=$TEST_DIR/$seq.stop.$$
> +
>   run_test()
>   {
>   	local mkfs_opts=$1
>   	local with_compress=$2
>   	local subvol_mnt=$TEST_DIR/$seq.mnt
> -	local stop_file=$TEST_DIR/$seq.stop.$$
>   
>   	echo "Test $mkfs_opts with $with_compress" >>$seqres.full
>   
> @@ -54,9 +71,12 @@ run_test()
>   
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
>   	wait $fsstress_pid
> +	unset fsstress_pid
>   
>   	_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
> +	unset subvol_pid
>   	_btrfs_kill_stress_defrag_pid $defrag_pid
> +	unset defrag_pid
>   
>   	echo "Scrub the filesystem" >>$seqres.full
>   	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
> diff --git a/tests/btrfs/068 b/tests/btrfs/068
> index 19e37010..7ab6feca 100755
> --- a/tests/btrfs/068
> +++ b/tests/btrfs/068
> @@ -11,6 +11,22 @@
>   . ./common/preamble
>   _begin_fstest auto subvol remount compress scrub
>   
> +_cleanup()
> +{
> +	cd /
> +	rm -rf $tmp.*
> +	if [ ! -z "$stop_file" ] && [ ! -z "$subvol_pid" ]; then
> +		_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
> +	fi
> +	if [ ! -z "$remount_pid" ]; then
> +		_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
> +	fi
> +	if [ ! -z "$fsstress_pid" ]; then
> +		kill $fsstress_pid &> /dev/null
> +		wait $fsstress_pid &> /dev/null
> +	fi
> +}
> +
>   # Import common functions.
>   . ./common/filter
>   
> @@ -21,11 +37,12 @@ _require_scratch_nocheck
>   _require_scratch_dev_pool 4
>   _btrfs_get_profile_configs
>   
> +stop_file=$TEST_DIR/$seq.stop.$$
> +
>   run_test()
>   {
>   	local mkfs_opts=$1
>   	local subvol_mnt=$TEST_DIR/$seq.mnt
> -	local stop_file=$TEST_DIR/$seq.stop.$$
>   
>   	echo "Test $mkfs_opts with $with_compress" >>$seqres.full
>   
> @@ -54,9 +71,12 @@ run_test()
>   
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
>   	wait $fsstress_pid
> +	unset fsstress_pid
>   
>   	_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
> +	unset subvol_pid
>   	_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
> +	unset remount_pid
>   
>   	echo "Scrub the filesystem" >>$seqres.full
>   	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
> diff --git a/tests/btrfs/069 b/tests/btrfs/069
> index ad1609d4..3fbfecdb 100755
> --- a/tests/btrfs/069
> +++ b/tests/btrfs/069
> @@ -10,6 +10,22 @@
>   . ./common/preamble
>   _begin_fstest auto replace scrub volume
>   
> +_cleanup()
> +{
> +	cd /
> +	rm -rf $tmp.*
> +	if [ ! -z "$replace_pid" ]; then
> +		_btrfs_kill_stress_replace_pid $replace_pid
> +	fi
> +	if [ ! -z "$scrub_pid" ]; then
> +		_btrfs_kill_stress_scrub_pid $scrub_pid
> +	fi
> +	if [ ! -z "$fsstress_pid" ]; then
> +		kill $fsstress_pid &> /dev/null
> +		wait $fsstress_pid &> /dev/null
> +	fi
> +}
> +
>   # Import common functions.
>   . ./common/filter
>   
> @@ -59,8 +75,11 @@ run_test()
>   
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
>   	wait $fsstress_pid
> +	unset fsstress_pid
>   	_btrfs_kill_stress_scrub_pid $scrub_pid
> +	unset scrub_pid
>   	_btrfs_kill_stress_replace_pid $replace_pid
> +	unset replace_pid
>   
>   	echo "Scrub the filesystem" >>$seqres.full
>   	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
> diff --git a/tests/btrfs/070 b/tests/btrfs/070
> index 3054c270..11fddc86 100755
> --- a/tests/btrfs/070
> +++ b/tests/btrfs/070
> @@ -10,6 +10,22 @@
>   . ./common/preamble
>   _begin_fstest auto replace defrag compress volume scrub
>   
> +_cleanup()
> +{
> +	cd /
> +	rm -rf $tmp.*
> +	if [ ! -z "$replace_pid" ]; then
> +		_btrfs_kill_stress_replace_pid $replace_pid
> +	fi
> +	if [ ! -z "$defrag_pid" ]; then
> +		_btrfs_kill_stress_defrag_pid $defrag_pid
> +	fi
> +	if [ ! -z "$fsstress_pid" ]; then
> +		kill $fsstress_pid &> /dev/null
> +		wait $fsstress_pid &> /dev/null
> +	fi
> +}
> +
>   # Import common functions.
>   . ./common/filter
>   
> @@ -60,8 +76,11 @@ run_test()
>   
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
>   	wait $fsstress_pid
> +	unset fsstress_pid
>   	_btrfs_kill_stress_replace_pid $replace_pid
> +	unset replace_pid
>   	_btrfs_kill_stress_defrag_pid $defrag_pid
> +	unset defrag_pid
>   
>   	echo "Scrub the filesystem" >>$seqres.full
>   	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
> diff --git a/tests/btrfs/071 b/tests/btrfs/071
> index 36b39341..1a91ec45 100755
> --- a/tests/btrfs/071
> +++ b/tests/btrfs/071
> @@ -10,6 +10,22 @@
>   . ./common/preamble
>   _begin_fstest auto replace remount compress volume scrub
>   
> +_cleanup()
> +{
> +	cd /
> +	rm -rf $tmp.*
> +	if [ ! -z "$replace_pid" ]; then
> +		_btrfs_kill_stress_replace_pid $replace_pid
> +	fi
> +	if [ ! -z "$remount_pid" ]; then
> +		_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
> +	fi
> +	if [ ! -z "$fsstress_pid" ]; then
> +		kill $fsstress_pid &> /dev/null
> +		wait $fsstress_pid &> /dev/null
> +	fi
> +}
> +
>   # Import common functions.
>   . ./common/filter
>   
> @@ -59,8 +75,11 @@ run_test()
>   
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
>   	wait $fsstress_pid
> +	unset fsstress_pid
>   	_btrfs_kill_stress_replace_pid $replace_pid
> +	unset replace_pid
>   	_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
> +	unset remount_pid
>   
>   	echo "Scrub the filesystem" >>$seqres.full
>   	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
> diff --git a/tests/btrfs/072 b/tests/btrfs/072
> index 505d0b57..e66e49c9 100755
> --- a/tests/btrfs/072
> +++ b/tests/btrfs/072
> @@ -10,6 +10,22 @@
>   . ./common/preamble
>   _begin_fstest auto scrub defrag compress
>   
> +_cleanup()
> +{
> +	cd /
> +	rm -rf $tmp.*
> +	if [ ! -z "$defrag_pid" ]; then
> +		_btrfs_kill_stress_defrag_pid $defrag_pid
> +	fi
> +	if [ ! -z "$scrub_pid" ]; then
> +		_btrfs_kill_stress_scrub_pid $scrub_pid
> +	fi
> +	if [ ! -z "$fsstress_pid" ]; then
> +		kill $fsstress_pid &> /dev/null
> +		wait $fsstress_pid &> /dev/null
> +	fi
> +}
> +
>   # Import common functions.
>   . ./common/filter
>   
> @@ -52,9 +68,12 @@ run_test()
>   
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
>   	wait $fsstress_pid
> +	unset fsstress_pid
>   
>   	_btrfs_kill_stress_defrag_pid $defrag_pid
> +	unset defrag_pid
>   	_btrfs_kill_stress_scrub_pid $scrub_pid
> +	unset scrub_pid
>   
>   	echo "Scrub the filesystem" >>$seqres.full
>   	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
> diff --git a/tests/btrfs/073 b/tests/btrfs/073
> index 50358286..e6cfd92a 100755
> --- a/tests/btrfs/073
> +++ b/tests/btrfs/073
> @@ -10,6 +10,22 @@
>   . ./common/preamble
>   _begin_fstest auto scrub remount compress
>   
> +_cleanup()
> +{
> +	cd /
> +	rm -rf $tmp.*
> +	if [ ! -z "$remount_pid" ]; then
> +		_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
> +	fi
> +	if [ ! -z "$scrub_pid" ]; then
> +		_btrfs_kill_stress_scrub_pid $scrub_pid
> +	fi
> +	if [ ! -z "$fsstress_pid" ]; then
> +		kill $fsstress_pid &> /dev/null
> +		wait $fsstress_pid &> /dev/null
> +	fi
> +}
> +
>   # Import common functions.
>   . ./common/filter
>   
> @@ -51,8 +67,11 @@ run_test()
>   
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
>   	wait $fsstress_pid
> +	unset fsstress_pid
>   	_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
> +	unset remount_pid
>   	_btrfs_kill_stress_scrub_pid $scrub_pid
> +	unset scrub_pid
>   
>   	echo "Scrub the filesystem" >>$seqres.full
>   	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
> diff --git a/tests/btrfs/074 b/tests/btrfs/074
> index 6e93b36a..1dd88bcd 100755
> --- a/tests/btrfs/074
> +++ b/tests/btrfs/074
> @@ -10,6 +10,22 @@
>   . ./common/preamble
>   _begin_fstest auto defrag remount compress scrub
>   
> +_cleanup()
> +{
> +	cd /
> +	rm -rf $tmp.*
> +	if [ ! -z "$remount_pid" ]; then
> +		_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
> +	fi
> +	if [ ! -z "$defrag_pid" ]; then
> +		_btrfs_kill_stress_defrag_pid $defrag_pid
> +	fi
> +	if [ ! -z "$fsstress_pid" ]; then
> +		kill $fsstress_pid &> /dev/null
> +		wait $fsstress_pid &> /dev/null
> +	fi
> +}
> +
>   # Import common functions.
>   . ./common/filter
>   
> @@ -52,8 +68,11 @@ run_test()
>   
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
>   	wait $fsstress_pid
> +	unset fsstress_pid
>   	_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
> +	unset remount_pid
>   	_btrfs_kill_stress_defrag_pid $defrag_pid
> +	unset defrag_pid
>   
>   	echo "Scrub the filesystem" >>$seqres.full
>   	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1


