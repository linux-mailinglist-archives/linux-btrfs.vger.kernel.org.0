Return-Path: <linux-btrfs+bounces-2884-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CD386BE78
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 02:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C73DC1F246D3
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 01:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BBB364A4;
	Thu, 29 Feb 2024 01:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SJ6B7fzl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DswRuh+r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F1036113;
	Thu, 29 Feb 2024 01:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709171400; cv=fail; b=rP35jz+SUEBWAe3Vn/4L3RTNxXJmjX2L/nlBGHwdF6VAhd//1xDsOYrM0ZrV3RykrhE0lVE8xn9iUehPhzCZQ5WJ8BHTk5gzLjEzernkQHRI8Pu5R0l1Bo8MS3Yqu5zrChBWRBDmse/FHzfcz0evskJzmo5tF2k0RfElB0LGR/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709171400; c=relaxed/simple;
	bh=Vv1NeSQ3JqGTjGLe1Zc8GQZPbyLUovVxmi0TIwPlcck=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nFnjgs7rzdcmTj366YzJ74zOQmjLFI/IyAAsje6F0QyErw+FKIw0CNmVZVYD/iZDaREKNFk4+VErTF1pMiEYXVnD7wU/sJv2SqRbgH6JJJOqnmQVEB32t5SCEzbOFTWcv9C/rahCCyNCzUolILhXJ0NzW+UjaNFnRxdc5c2bC3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SJ6B7fzl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DswRuh+r; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41SKWr20010540;
	Thu, 29 Feb 2024 01:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Y4xqVW7DJsxfzk1lh85GqPFo6Y0cdZ9BnYmulZsG9hc=;
 b=SJ6B7fzld1hk5kqGmAjwkFB1FOcI8qR2wX9VwzK6Dimy1L6jhlpwtLRoZdlaqxlDh/7a
 pOlVLm/CXTwvnEaTSeUHyprGfWmucku1e+RoCEQ7eBNawv5kicZnwrj0mC7bN0IVoH7i
 yQl+U46tIJq7ZwxlTL8m3VvDzWh7kf6ayWEegxGZgQc5n/6M1bodvyK1+4w6MNnoP+6E
 DQmLXH6BAi8udCUIeNq8HKPo4OTiOj5IgZfR7uGCY2v5nef0MEYJCVNM4ogskPv7TEud
 jh9m6DSP27fopUbfh23QDSDucI632Bc9E3NygRZFfrl8CRDD0zZf+nIhdEKw93tr1Y3X Jw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf8bbbr7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 01:49:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41T0sjMx001682;
	Thu, 29 Feb 2024 01:49:54 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w9tapg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 01:49:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dY3D1TaBNjJx8qYIRjaVOo318e4jMxKcfym2a1nSQs4ChsMYIbatUPRRPoYSyTdmHhk/WumhYHNegc1jXylLzh7Y5Eu2jCez8PXCOOGwWNp1zbCgGGGAXoKuorxOdRd1BuRKhRNcGCTneSlAlMnMrHTVPwnotqILOEkdQdOCdLPD6V5kHwy7E+O2w83fvXoHOg4kTm1gyIJe6b1W8YcHcwNH3ndL+5uxDPM/VfXXBLp9l8P9A8zPIEuk6jYG/oElCONs2XkTjUHvZeUtmGqO/Gko9AN9cAQmq/r1DTStTJnPMkm4XSqBwhG6wsz+st7c9mHkToxr9TMWMQFND+pjaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4xqVW7DJsxfzk1lh85GqPFo6Y0cdZ9BnYmulZsG9hc=;
 b=CBPsIYZLjp0B1p5eTvXdlXDoPfGB52AFkqyvIbcjnS8OZTRIFEIB3JnD3trxMXfZgAl7NcHY73Qx1cdWgsBeU0lG5bGM/MvdiZYUyBW/qivT+Tem3xhgeJjWCj4Ti7XcrIIyd0mKnYN9ymeO8/FX0oauHARIN95NumlTrDszKxpY7qhPHwAI+hYtXF0d0WVDE7ViWnaoQLjkPpG0s9OcqznLdz//PU1I1kTHZwwBU4GYi9Jn5johoa4Xu9JtnOCaNAGXrVqfu2jhVFYXhVVCCvJT2+xrEh6rDky1xZ8yL06DEZItvVkwvjFfMM1ieHublEmvATsJuLJ9khF4RbwsYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4xqVW7DJsxfzk1lh85GqPFo6Y0cdZ9BnYmulZsG9hc=;
 b=DswRuh+rlXjI5CFjWhKCr/mhXZDwq4Wzy2DEGi80AnyYti7VhqOuCn9nOSipeNLif3NRGoK9ew03JOtPsUj7j5irPRBGT1EbgXeEnhQb75HM5sDGGB4H+O5suZkTzW1QpcSOp3RUqzdmjMC3+43i6NLBjhZHRQf2GgivfiUFRi0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY5PR10MB6239.namprd10.prod.outlook.com (2603:10b6:930:41::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Thu, 29 Feb
 2024 01:49:52 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%6]) with mapi id 15.20.7316.032; Thu, 29 Feb 2024
 01:49:52 +0000
Message-ID: <0f357a52-9d44-4783-91bb-ad945d7a90e6@oracle.com>
Date: Thu, 29 Feb 2024 07:19:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] btrfs: check if cloned device mounts with
 tempfsid
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1708772619.git.anand.jain@oracle.com>
 <efb3d493d6ff44dbf87645669d4d363b0b83ecc3.1708772619.git.anand.jain@oracle.com>
 <CAL3q7H5n1DuR0uzfRGedGL7U6EDeJzyFpWuJeLeHLTG6ZZTTXQ@mail.gmail.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H5n1DuR0uzfRGedGL7U6EDeJzyFpWuJeLeHLTG6ZZTTXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY5PR10MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: afbcae58-411e-4694-75f6-08dc38c8b8a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QyIE5UFeFqzqPtBJX3WRMGTg510vhDfNyzexRkWGysSM7doCwweirUbm6WK3qWmmeAa+4k3GgdSkC3Y5MYltSsafjw26ozd6Q8FJAvEbY5WFTUzVSUpdNkn+KA3GC6Iq3XaGy8nQj24OOG27vPs+2Z+2FqZb2dJEYpbyAkEeKtIGwITuoxUsDOKDX4Ssi2A4kNF13B89lWmLaIJwuIO+JaAp95gp6z1Bap9WtMfyNmhc9Pg4PJKordHcktFydzNyuUftP1ztaDxzK3AOi6uwMP4w5taFJCaUKcwKWwSBcIE8d79vaqHwVXpcMequK4bnke/v6lv45LhBiWRYcXtA3Bn8MPtAcpeFrHzd/9AcKoct/po7u6J6d+aM65yo9/l72Awh0cLJfF+Mpjm75moh50XY+97CRPKxMEvtTI/6KSp7cmUZlGJkHCbXdk3K9r2amPKHvaO+JkEwkNd7KyvIZKzE6IyyI+eGz2IQ2csd1FhvYaSRyHbZ/hIPO7BghHygR6Cl0h8B13HEpYM7ZeztD1AY9d1Oo8F/KR4BJa46MtykeoYHDlx1Pyl1uceSE+3HTVfTxTgdpN3by7g7nypz47cRgp45trXZcwAFOccYeoD+yec8tkDx/jOrUMyABa7qj1dv+T+9Ro5nyPwlYFtE9w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?STVpNit2blVDcVd5YWpzMUZmdTFYaTZwWlhtblhuR3VSaHBxU2ZsSnE3V0tI?=
 =?utf-8?B?cDEyQlRJRHl1QTZyNTVoQS9Fd05XNkhsUHVYckd1dlV5cWw4cDEwcUdFMFJi?=
 =?utf-8?B?cG1jMEV1S1d3Y0VKUDNuN050bjBrSDUweGU2TzVFUE42b0huYnhrV09BdWdT?=
 =?utf-8?B?Q01ybDdRVmJZczZjb3F3dzVjbHVUZS9SOFA5VkpjS1BXVnplcEtSY2g4NEgr?=
 =?utf-8?B?bkZUbmFRMmJPWVRGTWdJUFQzK24zWHc5N29MY1plckd1K1hvdFA3cEJyWW02?=
 =?utf-8?B?cXd4KzBMcUV2bmdDVlkxZUE3NUVDdGhCdFBoOWtLUkRxTkJmTW1vM25qT1Vy?=
 =?utf-8?B?VWllVXo3T3l1c2VQUWNxbUtKeDdJM3RmYVZJSUJyZERoWk4wZDFtL0Z2VWts?=
 =?utf-8?B?SEp2dXRHeitXdjRabTl0Ujh2WDhwZm1ZMmlvbU1ESkR4Q1AzRjlGMmlhamw5?=
 =?utf-8?B?bHhmWnhMVmlLS0todUl2NmxKTUlCZlh6WkdGeWRJN0NNRUdCMElJVlpOZHhH?=
 =?utf-8?B?SzR4YTZ0YWs5cnZRbGdNRjBTQ1ZTbmlSbkh5TWh4M2hMQlhkb1R2WmVTQ2Vp?=
 =?utf-8?B?OFUxSUpLTm0rdXVocWkwZ1k0Vzh1VDM0dDluMlBzYUlFbXRXVm5ZZXNtbzc2?=
 =?utf-8?B?Y1hhdlMyenM0cEdlSHpaRVdqNFBJZEZISW1MVEM5bEZEQmJsWkt6dndKWE9x?=
 =?utf-8?B?VXkzU0RRRk5tbFFkMG5KYTlBeUllNkEwRjNPUld2TzlyQ2ZFUDQ3ZG8yRCtp?=
 =?utf-8?B?YTloYi9WSE5VSlBsQUdGWS9sWFh4VllvLzRHUGtzSWh5N25ZUitnVFhjTWda?=
 =?utf-8?B?VmNCeUo4bDl4YTZCaTM5VFJmV3lGMXRWdmlqdjZCWVVZNWZKM0QzZmZnVGc1?=
 =?utf-8?B?ZjBtQ1JzdlRwcjU3cGxaNXNwWitnbjg5VSt3SU9qMXgzZDRQUVJzNTI5S3Uw?=
 =?utf-8?B?L1RDNngwLzNMdVdQV3R1R3Fuc284cmxPMXdJRjZzQlhENUYxdHBNWHBWZnlE?=
 =?utf-8?B?TjV0Sk13WnFtMHIxNUQ4Z2QrVVlLN2xBZkpDbEhPWUZRajRHUGhKQUhSOXJv?=
 =?utf-8?B?TnlGRFBueHdrRG03V3pITVJHMWJqUHpQTDM1TTJONm0vbUVLMnlqV1RyR1pn?=
 =?utf-8?B?OEpsWXpxQkd0cnhkQzR0alREaHhlYjdhMEhFemJPTFhnWC9iNHEvR0IvKy9C?=
 =?utf-8?B?T0dEdTJ6citkZkVIdVQyM1FlV1FSRmxHRURxSVlYNVdyTmwwM3hma0MySWNF?=
 =?utf-8?B?R09sUlZMN3cyaHlLWk5ySkRpcTFnV2hJc2RXbU5uSmpmNE1zTmh3RFZvWEZw?=
 =?utf-8?B?QlBQQmdaNTVFUnp4VDAvZWlNWmp1YmZuY2ZGWmlMMHQ1VTNrMU5NUzJBUjNL?=
 =?utf-8?B?VWVvWHdrNmpIcFpCRnZHYjd0dTdCYkVjY2xsRXcrMFJoS3ZWUmdrQkh6ZHV3?=
 =?utf-8?B?NjE4ait5M0lBeWVyUmFxVEJhZHh1SFNyZCtZMGRpNUw0RE1NL3M2VnlFMWx2?=
 =?utf-8?B?QkVBY0FNM2t2TWc5M3hPcWtPL1BRSXVFVTEzOERBUS9ZeDhKUTJSQWU3VzMr?=
 =?utf-8?B?WUpXQVBBRXR1a0cxVkd3QWJrMGtLL1gzMUk5MEFBM2QybGtaVUhEOVd3RDVO?=
 =?utf-8?B?R2lnT0g5Sk9UbkdINkgzK090dGQrL2luVnV4SExSOEFtNklIZ21UWnRuZkNI?=
 =?utf-8?B?L2k5UENJZ3NSVzdzTU54T0YzRHQvUDhjWkNNaXNORnJKeXlUR0p5RUZJVGJR?=
 =?utf-8?B?RWxhQ1hpWHE1RElNbStnL0hoQTV2NEVTRTdaaG5GNjZUT2grR0RIeFY4eTRh?=
 =?utf-8?B?MFlSTGs1MnhydU1KbWhrOUdZOWtJSlpIQ295YUdiNXhIQ1M2L2tRbjFSci9V?=
 =?utf-8?B?ZkgrOXljY1lBdDBXZjgwdVZpSk9qQXlYR0I2cUVkUEx4TG9ycnBmVEphS0R2?=
 =?utf-8?B?QWp0TFNieGYrM0xHQXZJL0o1OGpZREhRQTRyenZ4cWpOV1RKbzFJVGZEamRT?=
 =?utf-8?B?UklkSkFDNFlucUVWRG4wR2RFa0JYQlpGZ0RXV3hreWdUVFliWDBNeUJYL2dK?=
 =?utf-8?B?TjNFUzVqa2ZITEFhT3d6emFYT0VPUE0vNU5Gby9pczhaeVZydUwyNExKVVR4?=
 =?utf-8?Q?ET3qitSaYRlUPMFtZOeZA0UWz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1AjdwNUqr9XnkKlCX8rdBScBL53AWY72eHTPFYI2DyGYKABvzSWQJ6WdoMIFMJvOidWuHdquw6jLZIA3q2g7lkJlnimNiNJYqzvknnomsLP4F1Q2HBZRqa+G5ZCZeZ3Nft9Xc6qo11G/fswMYOxpbyILKZ0aTcUhUVyp7WjhIlrce20qfOzkNC7VJZ30OVBNvzWoFo7AFcBBOtpSQS7QezqHpdcc4/E5CayuFtFHej7T/ptdRlUNSCRL3stOgw6SrzuzZnSDQg/iDB1wdOlG3ipajn686ryUPunDrrAizgmo0HrkR8E/rFsFqpZkqC4mrnBgGDAKVk3THE/vqZdJJcgTAnCi59GYZzXKueGxzkmn80Ws9xG05lQpWZ0uM5HxLWqakuM6xC7bRr+NJO7b/fELhjqQcsf80cXVjsihREZnwks7RokJvbK/sh0sUYsVS5DShZumG3nBDSx37aVYzcnKrF41hpaO/wFVDXChdquawK1+rmEqexAj8FaZjzFBgNdRW+S4K10nBzl7Q+zJAnoN+zc8x4slpBhG4M+8hfnDWBrkIfNCB2TEE7GJgm4F4MAFWaLVvm43uBIri/p1OEHsDTYRR/TjpNPLEChsrcQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afbcae58-411e-4694-75f6-08dc38c8b8a0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 01:49:52.4943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iKiYfCQ0ae0QqWRlMzYonkvmutl9HSzWUcx5Y4JPD1QAmlbuNOJdvndVa/QfKnjuQCNW6md32htTAFuZrcolyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6239
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402290013
X-Proofpoint-GUID: qXoiHP8Twb-0NmKIS9JDBA2xLS_rneiZ
X-Proofpoint-ORIG-GUID: qXoiHP8Twb-0NmKIS9JDBA2xLS_rneiZ

>> +create_cloned_devices()
>> +{
>> +       local dev1=$1
>> +       local dev2=$2
>> +
>> +       [[ -z $dev1 || -z $dev2 ]] && \
>> +               _fail "create_cloned_devices() requires two devices as arguments"
> 
> Now that the function is not generic, in common/btrfs, and used only
> once in this test, this check doesn't make that much sense anymore.
> 

  Removed.

>> +
>> +       echo -n Creating cloned device...
> 
> Wondering why the -n here, makes the golden output a bit weird.
> 

  Overall it limits the output to a line; organized well w.r.t the
  helper function, deciding to keep it. Thx.


>> +       _mkfs_dev -fq -b $((1024 * 1024 * 300)) $dev1
>> +
>> +       _mount $dev1 $SCRATCH_MNT
>> +
>> +       $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
>> +                                                               _filter_xfs_io
>> +       $UMOUNT_PROG $SCRATCH_MNT
>> +       # device dump of $dev1 to $dev2
>> +       dd if=$dev1 of=$dev2 bs=300M count=1 conv=fsync status=none || \
>> +                                                       _fail "dd failed: $?"
>> +       echo done
>> +}
>> +
>> +mount_cloned_device()
>> +{
>> +       local ret
> 
> Unused variable.
> 

  Removed.

Thanks. Anand

> Thanks.
> 
>> +
>> +       echo ---- $FUNCNAME ----
>> +       create_cloned_devices ${SCRATCH_DEV_NAME[0]} ${SCRATCH_DEV_NAME[1]}
>> +
>> +       echo Mounting original device
>> +       _mount ${SCRATCH_DEV_NAME[0]} $SCRATCH_MNT
>> +       $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
>> +                                                               _filter_xfs_io
>> +       check_fsid ${SCRATCH_DEV_NAME[0]}
>> +
>> +       echo Mounting cloned device
>> +       _mount ${SCRATCH_DEV_NAME[1]} $mnt1 || \
>> +                               _fail "mount failed, tempfsid didn't work"
>> +
>> +       echo cp reflink must fail
>> +       _cp_reflink $SCRATCH_MNT/foo $mnt1/bar 2>&1 | \
>> +                                               _filter_testdir_and_scratch
>> +
>> +       check_fsid ${SCRATCH_DEV_NAME[1]}
>> +}
>> +
>> +mount_cloned_device
>> +
>> +_scratch_dev_pool_put
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/btrfs/312.out b/tests/btrfs/312.out
>> new file mode 100644
>> index 000000000000..b7de6ce3cc6e
>> --- /dev/null
>> +++ b/tests/btrfs/312.out
>> @@ -0,0 +1,19 @@
>> +QA output created by 312
>> +---- mount_cloned_device ----
>> +Creating cloned device...wrote 9000/9000 bytes at offset 0
>> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +done
>> +Mounting original device
>> +wrote 9000/9000 bytes at offset 0
>> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +On disk fsid:          FSID
>> +Metadata uuid:         FSID
>> +Temp fsid:             FSID
>> +Tempfsid status:       0
>> +Mounting cloned device
>> +cp reflink must fail
>> +cp: failed to clone 'TEST_DIR/312/mnt1/bar' from 'SCRATCH_MNT/foo': Invalid cross-device link
>> +On disk fsid:          FSID
>> +Metadata uuid:         FSID
>> +Temp fsid:             TEMPFSID
>> +Tempfsid status:       1
>> --
>> 2.39.3
>>

