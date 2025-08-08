Return-Path: <linux-btrfs+bounces-15922-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FC3B1E1FA
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 08:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F7957A8706
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 06:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2F821FF53;
	Fri,  8 Aug 2025 06:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MjihkLtr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LjIwP1hu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEDB21D00D
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Aug 2025 06:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754633489; cv=fail; b=D4Ix1KI+a+K+GxJvqiqgPC+ZLO4ik991IVfuerDisashhHQwYemZTpgE/5XsT/OfNRflAFk9mjF2WIl5/4gjNn+ADzqgwFo9WK20TgILss4Cdsx91pcyAYZdGank0+08lfCt4cTTfaGzzZAc3g3IeeJlP8hRTZEY0GRJgVCF6ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754633489; c=relaxed/simple;
	bh=FWxnfgRnuTPsKimvwnQDt3RBHqQJVaD5yJy5Vkaspqs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IvFtvh4fEfwbOD6uVwylFWTfae8QCEjDXNgT3UoVU6uGL4jCMgP5/ZSh698Ly61LTD4XXjidl0Ez1kbxhg87913DzaZ5Vy4Sr11s8Jm3GGaTLW72mSaCdWbhtYU/uGHcWNRKe6NK4n1IongZknVg+cSzjk4qMMjoj24MXnVZozY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MjihkLtr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LjIwP1hu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57869rUR027178;
	Fri, 8 Aug 2025 06:11:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=FWxnfgRnuTPsKimvwnQDt3RBHqQJVaD5yJy5Vkaspqs=; b=
	MjihkLtrdZ0CTKTPqyJvnEqLWsYQBkB4+EhdvPreDjOIB3YqQEXCPjt+10FHPHb6
	BnwaqpulaaoiRRJ48i5M641gH2tSJCvSKAWBuQxkD1IwNIBP+YjQwiaIz0CHN8ol
	PyfX12cXX1Ogf4/GoiaZjWex+43OriNYcpRI18XJazaztic1muFYuXU5AxKVIClP
	vXn9QHl38xPgfPZbK2uoSWlUY8bHDiKy4Q0Bf/5H9miMS3tsXsmQr3NNNTWNOmvi
	hXs979wmygrHGnbWYS/TtnaMA+psyMPD6kotK8j/zdbK3HxuyiMGWZNrpLxJvfZ/
	10cWvItYd/UCfSHm9dLn8g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvjwgqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 06:11:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57860XBp032086;
	Fri, 8 Aug 2025 06:11:24 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwswbb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 06:11:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JAJ9UM88AUJcUPUyLbX9Egb65HzK/yNailUSc3bXcGD/0/R2/F5XMgU/ZEpNp5u8OuG+F1R1b9KVR14EHJ0JKurnWRKHZbdDFeMtjU3V0VFWi34pcIRCdYoaCpoCKFUYotz7ILYYIpl9Z59Byzj0V1cc0NGmBsoCivO/XGMzg2l5H9cpNtIa34sug+Yy4cp96MFJFefPqU8KStgbUzaVePTtA2dTOqdm8RvAneb6TllTYAc7BsQYmLZJtYKlP0xHcv7oZo1cE+mt1nQI4Gvw9Sl59YiwE6muO7pC1XqMpAZd7Qj2orR477GYqWFaNOohsg7o4M2PaLEqLtEltx3Lrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWxnfgRnuTPsKimvwnQDt3RBHqQJVaD5yJy5Vkaspqs=;
 b=p5N+4EVdtX/Sz5BjHGkW/sT9WBWZD6f/ZWl1RbfehfH5sDTxzqgKkvDz67zIlnmIkeJHA90F2Ma45NJy8jS3Eqt5i5S2lBhWt34mWctjUEoznRYh4M9ds50YbhGcsHIg9C5x+AtUh7CJ2CeG81AlRvywxetF/KLnM1/CDxUiwwlX/ogm1zJCtaKFvFZTFlA9GTrFYQVROzIg1SXfmiNl379jb1U6ZxhHudTPRSaCuE47wPhk0diTlAVBX5/o4Sz0GCq8nKZu1Ma28/iTeSB/QAIqfQsmaDmGrOoUCE7CuIq2xCrD7rhjXhs8XZfTMA+qGzk0G100E4yq9D83QVeqZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWxnfgRnuTPsKimvwnQDt3RBHqQJVaD5yJy5Vkaspqs=;
 b=LjIwP1huJeeGhKCIcr/57LIN/227zuq1K0E8FqxHxy1QhGNlzfMMmBfklVefFe8+IDlTJOJclxb5cAV+feiuGTZJP1K009HVnuvRbwBdkth4ftQVzRv5aiPleIMroOYLBP9v8TOvfWxx0Vig16hBf//uoRKTsbtZ0nDqnBxQX8U=
Received: from DS0PR10MB6078.namprd10.prod.outlook.com (2603:10b6:8:ca::5) by
 MW5PR10MB5873.namprd10.prod.outlook.com (2603:10b6:303:19b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Fri, 8 Aug
 2025 06:11:21 +0000
Received: from DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b]) by DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b%5]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 06:11:21 +0000
Message-ID: <6ef12dfe-58d8-4316-bb64-09e307774bfc@oracle.com>
Date: Fri, 8 Aug 2025 11:41:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] btrfs-progs: remove is_vol_small() helper
Content-Language: en-GB
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1754455239.git.wqu@suse.com>
 <29c59b6efc1722769b73eb938dd04655fbeff4db.1754455239.git.wqu@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <29c59b6efc1722769b73eb938dd04655fbeff4db.1754455239.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0173.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::14) To DS0PR10MB6078.namprd10.prod.outlook.com
 (2603:10b6:8:ca::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6078:EE_|MW5PR10MB5873:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c92f3d8-ade9-495c-4489-08ddd6426521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0FUaktOZi9JTm1MNnF3OHQzbzV3ZHdsY254VkM5WEdVeDl6ajM1elBXYTEz?=
 =?utf-8?B?aWxFbVY1dGpJcDJSNEVpSytic3hHdTdzZkFNWjNFUmdLWldCVzl1TUVkY2oz?=
 =?utf-8?B?aW9DNGFUdEd4R1FHR0Y3WmxSdFFFSkRpc25ydjlKZDVQQnFpZW00MkhZT1JW?=
 =?utf-8?B?ZDRTc1ptUnFtS20rQTBpT056SnhzSHZ2UFd3cVg1bmZJa1duVkwyVmIvMkcw?=
 =?utf-8?B?YU1YUHRkbEZZbzBxL0xXTlF3OGJDaHRhT09uM3RBM1dqb2d3YmVUTVgwd3ZH?=
 =?utf-8?B?L29ycU1wcEk2dkxQTk9yOTNCZ3pQeFNtTlNHQkpkY2orOTl0eWM4b3ROM2Fm?=
 =?utf-8?B?K25ueTd1U2E2ZFZaR3JDZ0hZdlRnQU0xYjczcUIwekptbDhWSjJLUUdiYktr?=
 =?utf-8?B?VEoweXVyZ2NtS1hoV2tpQ1ZXbllFbnUyVDc4cG0raW9WNk5MS1FSSi85VlZt?=
 =?utf-8?B?UGVoeDNBenl0eHZQRHFHK1VFeEJ5OG5LVTFqTXlGTWRIMG8yKzNETUVuNGFy?=
 =?utf-8?B?VHV2eUM5Y1VWRGdRcVUvaTNqR0hFWS95bTlISmlsM28vL1dWWlNlYWJTclZY?=
 =?utf-8?B?RUZ3RWFIVjRGTGZZZ2ZOWXYzMW5xNHBidUx2WmVFMmpqMkJsK0Q1cXJ2NVRu?=
 =?utf-8?B?UkQ5MkhUR0hjMDhPUFVaelFsc3p0N0dFQ3o0NWZQY0taRm0yN25xa29XRjVD?=
 =?utf-8?B?VWtWYlY2TnpSM2ZyR053ZE0rSXV0VlhSektOS201eXBLM25QN3UwTFRiK1g0?=
 =?utf-8?B?aXRCNytraFpscWh5N1FQRXZiM21Ca1greVltY1psUE5RYWl0QmtxV3QyZklj?=
 =?utf-8?B?WWUybE5nNHF3ajV3dWF1bTJDeWNab1c0UDNXTXFFNEZHZFcrU2hMU3BLbW9L?=
 =?utf-8?B?OUNxMXpZeWhCNXliRUkvZUlHemYzWm1rSzhhdndLMFRocm9VZnNlbERPYWtq?=
 =?utf-8?B?L0J3Q0piNmhiSWp4cm1pdXlROWJ2OE0xbHBZZFdnRVNOS0N5UnBGdkExTExM?=
 =?utf-8?B?bjNCU0RuVWNlOGJEcDd6Z1RJOUlUSHpLbWJHQ2E0ejg5RkFSVGZacDI5Q3My?=
 =?utf-8?B?UFl3S1ZMT2dVQ1kyaUp1cUp0Z2Jra2FYc3k5TGpncE5oSk40eVU4N1BDendF?=
 =?utf-8?B?WllaTHhQYTlOemowZ2I0TXNjb3ljKzMyUkJLM1YwWFlYRkxsa1FlYS9LM1lT?=
 =?utf-8?B?dGFja0dRWVArRUlmK0g3dXpyMFd2elU2am42REpWN0dZTlRNSGVwcWNpZEpx?=
 =?utf-8?B?TGJNTzZ0SWQwdWY2cXVtVTF0ZjIwb3diOFYxYkZ2c0N1QXhuTGFPNWJUTXRV?=
 =?utf-8?B?RnRqaHRReVZtSTJBNTluVU1mNnFhQm4xbU1vNTNia3RSajB6R0FEWCsrWk1j?=
 =?utf-8?B?aEQzU3Q3cGFHanlabGVWTWNYTU1aRS9hbmIybVF0V1hFZjEzdlBHdjlsd2Ux?=
 =?utf-8?B?UytaR0VDay93RFl1b0Q0TW43eWtMN2hnSXU4aUtPd0Nqd2MxNDNicjFhTVk4?=
 =?utf-8?B?em9WdHFHOVFHcnhzNjZLU1BMMHhDSDVhRlBlemdhQkZ3NnRBNzFGY3VPbllt?=
 =?utf-8?B?V0JCK0JpUGhoOVR4WnhVNTJ4dXJNWWw1dUc5Q2paUmpFYVlOOXphRWJUbElK?=
 =?utf-8?B?ekNLdXRxaVdCTzlaOTVpRnJTL092YWpKTDV6U3FNMzdXcEJEQ2pvdEdBUXU1?=
 =?utf-8?B?T3J3Y2hZVGhCYnNuN0pDMk9yWldNUTNValJaSFR1Z0g5TE92SzhiZm9lNUJp?=
 =?utf-8?B?MEY4dDN2aFVkcUd1NGUrYThpSGQ0QnZMdVhkNW01VW5WZ3A0YUVhNWI4dytT?=
 =?utf-8?B?a3RITEEzc0dLNjRVVWF1QTdDL2o0VVZnNmJCL0hZaUUvdDl4eFExbUJROThi?=
 =?utf-8?B?UGFzRXV5MTBqMFhlV0U2bzdDM2Fvc1FPQm8zcUZiL24yYUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6078.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGgxbWl5VEMwTlRrS2h3SGZhamhVUTJXaHMzYkg3bXlUalhaK25zTnl1SldF?=
 =?utf-8?B?emlnbmQyTis1M3lrd2kyRENGamtoSDRkdk9IOFY2aTV1UmZobFZpbnVqRzBO?=
 =?utf-8?B?YWRURHZxMTc1SnJRTFpveENPZFFnNk9NcXFOT3d4L2RnWlJtTTNLejYrYTVJ?=
 =?utf-8?B?cXlib3p6dG1NS01LcW0ySWUxa0s5VDU2dk9OdUFCaDJTVm90bTk3Wno4Yk9j?=
 =?utf-8?B?akNRaE5ReElEdERyeFAyczRaQ016b2ZDV1BZclluaVVBbzdZV2haM0lPZSty?=
 =?utf-8?B?VENJQU5BcUl6OWVSSWNxNmE2VCtFWW5MUlhYanRrUDdJS2txSXNzTUNqM25E?=
 =?utf-8?B?YVNMOU1MZnNPK00wbVhJVFZWVDNsRm9DNXJGeWIyN3NGSzFaWDY0RytnZDha?=
 =?utf-8?B?dFQ1TTJIbEpSMEJLZGp0K1k2U0dhdEpBSWk1N05IUHloam5DWUZJWGU4TE5p?=
 =?utf-8?B?NGZ5NU85YTZnNTNPSy9zR2VpOFNVd2xWU1N1SFJEUTNEQnlXbmlxaURhanFO?=
 =?utf-8?B?dlMzdEE0MXNiZ1dJWGxvR3pRUzJVNTRFVzgzN0pja3F5SngvNHpxU3pFc3hG?=
 =?utf-8?B?NzllWXpwc2ZKci9vUG9wejByNVFRMFhGOXROYUd5VWZWSXdzcVlIMjhxVnFU?=
 =?utf-8?B?cm9DV1F5VHMzK21iWW1vQlR4dkhiM3QxTC9ESnc3bDF6T3lLTG9DMkY2MzRE?=
 =?utf-8?B?VHI0SnJRZURVOS9kdjdrYzRYZ2dOOW9CdC9TaGIybFFxZFBnNS9GVWhPNUEv?=
 =?utf-8?B?ejhSaFZMZ3dnYTlLNmxpY1hBOFpkVTVrdzE0QU1zbUdIMlhaL2swQlVnQXNY?=
 =?utf-8?B?QmI4T1ZQbmY2cGI2MmNsRVlVdjFJMVZnN2ZvU3V0YkRsSkQ3OFpPdDhwN2Rv?=
 =?utf-8?B?am45a3pCN3oxZTNWZUVOd2dIYzhWaGZOZjQ5SXZYcFZad1ROOWEvTkx2d3ZJ?=
 =?utf-8?B?d0pzaFRTRVFmZDNBSTBkU3gyR3dmUjZybjA4ODZuTVZZeHlqTjZZL3drNENp?=
 =?utf-8?B?MmxFbitNYjRmU2NzNXNjaFBTZVJ2Q29lSUJra1p6dGNOazA0clQ2YU0wVjlQ?=
 =?utf-8?B?YS9tMXhEMFVoR2FmRVZGR2FqUTZjSkJTYW1Qc3Bqb29Yb1U0WTBBTGlkckxI?=
 =?utf-8?B?NmN2Zko5UGVNV0RkK0VDRHV5NU9tTjdpQndsS3RBa2wyK1JzZFY3UmFVR2pz?=
 =?utf-8?B?cythbmZXcDBIZ3ZrY2kzTVNxSTh6dG41bUNsbyttS1hVUjFnUU9uWnNoQWRw?=
 =?utf-8?B?ZElOdm9hSDl5NytKODhlYlpOZlZkdEVhK3VzdzZnSGp4Uzkvdm9ValZzd0dF?=
 =?utf-8?B?R3FyYVBScFZSK005WlVmMnAyaGVCb2YxOTN1NWN2eGs1YlVidkxOZzZ1Z2xo?=
 =?utf-8?B?OWJTSElpUi9lNDFacm1tdGtGSE5WTVMrY3pOc3d5WVpWMnJRMUs3bXFLQzBQ?=
 =?utf-8?B?RHJmVHZTdTVaNnlhTDFRcUk2dEVWNkE1Q05UQk5pMk5wcUtOL0Z0QmZUdUpB?=
 =?utf-8?B?RUtyeHl4aGw3VkFtRUhnd0hQazcxSHUxd2RVK2tzSzM3M1F4OFd1MWc0Qk5T?=
 =?utf-8?B?OFlyWDFPSjBsVHAwZlZ5aVhuSUJ3OCtDS1h3SVlPeDZ3b3dBaUV1ZHRxY1pM?=
 =?utf-8?B?ODRCdUtYUisrbHAveERSTHNveGlmelhvSU1tMUJVbEpPWDBrYy8zb0MzTWp6?=
 =?utf-8?B?ejM1SXVSUWcyTkgySlh6ZllXT0xRR0piM0pyV0NrNnVMTXdzWnpHUHpuMUNF?=
 =?utf-8?B?L1ZhSk52VDNkemZFOE9HZzdFcXltWmtlc3N0VFQxcFJ5OXF4bTBibnNybmFx?=
 =?utf-8?B?N2U3SDIvbVg1cm1RaU1vY3hrQmNwdnBLWUtSYjdUQkFrc0VZdDVuL2hEVUMx?=
 =?utf-8?B?ZkVKMVJGN3A3WUNOOHBjWmNOblNMcWpzWFljTXJtWFhkN3FFWXFUeVREeWM1?=
 =?utf-8?B?QjBjRVoyTHZST2FYSHlqMitKNExuR0FwTTRqcUVIRTI2dUFoSXphSnRXaEFv?=
 =?utf-8?B?RXNXM09XZlVpQ21yV2xhK0p0aVRDSjJDdHZRWjZhZUVpUHk5K0g5Rk5LOHNN?=
 =?utf-8?B?RXpLaE93MWx1cWxCekJFS1VTbDcyd0l2bUMvdzdFZ3d6YjR6Qi9zS21nYXZa?=
 =?utf-8?B?eHk3YU9pK3oyV2I2c1JVZmUvSWtaSjhYM3A2OVFiUzdnK2Q3aU44RTZoMjlk?=
 =?utf-8?Q?mCU24WhB4rSJrOOFiN7Wi7WbROhHtYVo56JLs/v32EPR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IU7KZ14aZE+jJ8VliXjh0eCDfARxsK1xkE0aJks9eF1vPQ4kcJpoKIyD5ohKg0y5dG1rO34AKJ4iIZD9QKIz2XJbt8GOFPs8tuiJGtWFgmuPCCNQLuebmmI3jxzKqGPInH0Cpez+umItsG/YQanFr+4cLz7RfRZQeztK6IZMv+NNm3pZ7752JOtZePeNvsdvoLDV4LHPQruYhxCxkpEh7Vf+2eZi/xjWukfORAGWVJ2+xkrxcO2eeUMWTBUufyGE46B+AbjzTo82MxcUKB0oNiS2zHLJ9AzPHbKrii2Y7KumyOzQEoWE/jMg8iuedcQyq+7RfqVeS+i9Nv9TWokMHzEHtyV/jUMXMLhgvV4nPNKQx/YHRg7ptEPyELpoQ1CA4SG0lOusV66XFdems0wz/cWd8jQgX9MFECbuk6EKCPBbHYF/Bad5OstW/BjAHwkeGmISLfcySWgF85Qjo4NjkXr02MOWDsTTIuMEt3C6PdhlLlaJ/tjYvuTSjj9lbjA86m4vZgpRpw23gv1uzhbWKJjKA0HJNjbdPSvOFB6/YHSp81m9f5mv9FvBxv6rtky2myjdAVpwUA27aSL9knj5yw41a3NMJfLPlHFn7iS7Oak=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c92f3d8-ade9-495c-4489-08ddd6426521
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6078.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 06:11:21.4422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYTlciy2b2T3BFav8GUg+KE/Cyju4gYoqIGmaXJhLagcUkDLT4mhhRETCzRGQnqmp54NeF01OMVJIaFXXAgntQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5873
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508080049
X-Proofpoint-ORIG-GUID: fPeU_ec7mtkz-zGE7za4p1EwEomJGym1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA0OSBTYWx0ZWRfX7T3vtR+VC+6C
 kh3hXqbfynaZ9BeYWuUorQBgQiZErWIdzfGcbJ02Rc2UlM7tP/EkNIvYoSwS8HivR8uTIdd+Lhp
 sGjQtfrFi/7NET+YuNuZ53J7JwldSDqmPVBqEW3rxg6f2eEyqZgEB/jsAYTXkrZHloqOAu5vYOs
 7kAm1bBbTttMIVAb2m69kfEL54f2vcsOkKZxZlKfCzkHe4iyWXzzmnE+lJPpLzNpePea873JOuF
 K9SP3bxeeXxOfVys2PqkN2c7yQWBedX3Df/v0DpbEg7dR+3rNQQ+eeebKXvD+FSPVXse9tPegXS
 3QRbYW+xJKhBLzVAIQVGngDreKXLqPczdjXGxYGf78Xy7YMEDIDDqQxPQB7wxOfh+5E42cKsoSy
 rX7/YFrlK7+X78/ssUJ6wKl79DzM02awqIaf++lGj6ARrZoDdvA7Gu7+5Gb+Nnygbbza1R6g
X-Authority-Analysis: v=2.4 cv=dobbC0g4 c=1 sm=1 tr=0 ts=6895950e b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=GHvQW532Yim61qcmasMA:9
 a=QEXdDO2ut3YA:10 a=_Xro0x9tv8kA:10 cc=ntf awl=host:13600
X-Proofpoint-GUID: fPeU_ec7mtkz-zGE7za4p1EwEomJGym1



Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks


