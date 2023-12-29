Return-Path: <linux-btrfs+bounces-1163-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C017A81FF6E
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Dec 2023 13:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 358A11F24597
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Dec 2023 12:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06319111B1;
	Fri, 29 Dec 2023 12:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I3beYBom";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mQHTY0tD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D298A111A1;
	Fri, 29 Dec 2023 12:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BT8PDcb014684;
	Fri, 29 Dec 2023 12:30:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=cWEgut6jAC9TW7SOYYeUqwWGEXQwxYAnaEHdB2CFvpc=;
 b=I3beYBompyLuhgoQF9NQoh8F5JVmuRaeTbYaIn11o84iUU+M6xvqMFzRd8mI4YfzlSft
 Tu+pTP5FaMD9qS4VF/WKeqtaKo7gQcKSZMZaMfg4d6j8IwdfZv8vnEdeS2UhbquVGo4k
 Q7CuYE63LpAbDjZ8RP5AY9HSj7EKQKvHSkyP99pLoR47SIDmJhf4AVFCweTU6Lj2/ZkV
 +tp8qaNsYso1km0sMF/POilYfRUiNv26QcTBo57LjC5DGC1VIEBIl/3+/F35OIs1xlgc
 sk0P31IMa5ns9ujXmeTi6d3gT/03vsnfKtl8Ebmm+3G4GdBbmDzIWPziVc4VeulQT1Ah Ow== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v5pfcfmct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 12:30:04 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BTCQiKp026619;
	Fri, 29 Dec 2023 12:30:04 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v5p0dg2je-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 12:30:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rdsvjuv7Og8/V4U/2/JGsnuBmPcTlcXHeNHu6N7xZpo6/SkhKOmb+guKZ6GWR/A64oho11XXcFZV8qI+duT0mruYAwUqCcTiM+SMdFpVRoU/X6FyfQrpBB3rLF4HyCumae9pz9oyds5jcIvnjCow48lmXyML2UJT0Dz7K+8u17IMSkee7FI5U1iWiz3u9Nq9nr3ax9g2vgB5GCFp8HOvRBf0VyeyqfT1PxyNeNmxXv7UNQVhLWk0FkZ3tu06pxEiv1zhfcLwtN6kEw+kYoS8slygFnb+AhmE3e7NulSv8kAeHiEFwnfqwFZKSARxuRjKghzSzeMFZt8v9JSEPwFo7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWEgut6jAC9TW7SOYYeUqwWGEXQwxYAnaEHdB2CFvpc=;
 b=fWVz4QEyOrjUXtP2jSghsN4yHn6jSAdjAzsyexKXf19SaYMSDVsTSed8JYieE2k1ovyLYkbA1Y+fXyC2GAeHbwVei/Lzu8WKVx+Ax1lvu1CFkiydPgvCBYHgoOIptWIuc8eoX6xbgRIrSvF0u6opV/8MPhEICevjQxhAOHTQM8j85pe9Lzo25RBdgQ8eqIbxuSnaaNX3DbpsFYMw5DmLa5uYCtPbwS+cGaopewkd98NbrUNTSLLbCVy2GoLSZ1nhUSyV34lXArMOVam3HlWLzUAVddewY94tlLc0mwyf1licdcopqrEna0wHhByhXr+cLxu0/HX7gFe794Q9/1+Jcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWEgut6jAC9TW7SOYYeUqwWGEXQwxYAnaEHdB2CFvpc=;
 b=mQHTY0tDG0paBL0hQ1n8Bo5ZYllO4wfm1voPKTOa7r3GoDRWPvO1zob16xJhxv9ecKw1rap+biQ9vjFzwbAzPb5p5kt4wDHdYTiLzhZx6F1NSByicpIxD8E6Jjxm0YIr+oJkhihUl6YlsTkPtXt6cIhFchfRcFyVR4uTtQX0wNU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4695.namprd10.prod.outlook.com (2603:10b6:510:3f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Fri, 29 Dec
 2023 12:30:00 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7135.019; Fri, 29 Dec 2023
 12:30:00 +0000
Message-ID: <c4e9ad2c-8c36-2cb2-caed-f42c4fd91052@oracle.com>
Date: Fri, 29 Dec 2023 17:59:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 05/10] common: add _filter_trailing_whitespace
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
References: <cover.1703838752.git.anand.jain@oracle.com>
 <cf58eed9c9b9134b94fb6872d37b75a0c0bbe914.1703838752.git.anand.jain@oracle.com>
Content-Language: en-US
In-Reply-To: <cf58eed9c9b9134b94fb6872d37b75a0c0bbe914.1703838752.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0193.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4695:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ac97de2-48b3-4a49-c882-08dc0869dfb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Lcd3pm9GYcG8Yy300bLD6SR8KPcrS1BcbAIJ/e21djZj1QcvIwIdfI8c2OIBAzybgD2hasS9xSNoSgUMSmIEjcfrdzxyUT9Y/2R9CUqPk1VUFxjaJemClfr65X2laBvRvfqgRTEqdqLK5Oo+MBsRqcOMoCRFMcycWSKjijEJSlRq+TSAVJcpC99bbIVNINS1UXh9DjnDmdHowBoORx+L4GtD3EO0hPaAm882WEISH4b1VqUQDQzktp8RBkgk6EN7R/9D60k+WvOrUovKjziyclUsTA1wd30i95Pbza6mKSXuhy1MW3YSz/pyjp/2VrY35vGzQb5BSJ3f/pSFk1vwbBOQUjCUokH4BcBPJMuazV1bFsdBXcn+DWgu06+DnpfzO9ELs6r3B+DSpB2DC2u6tahpBqtmIrgesYkWzjy3BdlvOOgf00zObJzr5xUAATINl20+k9FYuR7piXjcmh8YXwrsHLUjJWBvVqCMPJ0qEnWNhyTgeqk+nYMrfgt5DTkL/mPz/wd+wB4nPPmzrujYH4ZsUrbB5xYWHWSR+nLOc/KmBTZh1i90m5z9C8EIlDIns/uy1Acc6VY+gZMyj3/+UUVwaealwuIWdYoe99MTy/HAsY04fsDCUegw6WH8WowCfRUZin/rWGGRGd8W9ga+1A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(6512007)(6506007)(8936002)(6916009)(66556008)(66476007)(86362001)(66946007)(6666004)(31686004)(478600001)(6486002)(2616005)(31696002)(26005)(36756003)(4270600006)(316002)(450100002)(4326008)(44832011)(8676002)(19618925003)(558084003)(2906002)(41300700001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SzdmeGJYazI5d2FpT2NpckZsa3pJYjJhWHhJVVJ3cjF0MkZ6RzZCRU4xOExT?=
 =?utf-8?B?SHNXcmE2ajROZWhIL3BEZHVPN0czUmg4RDkvb2xIbkNibnVkMFY3WGttTXZU?=
 =?utf-8?B?empqY0FhM0psOStzbExVZkRBdW5sNldkTDlhc2hyNVZsRGFkU0Z0ZEt2eEl3?=
 =?utf-8?B?UTBDVXdYaVFCNW9YY0V2YVBYUkg0WThKZlBvZ0RQMWV6c2NJdlFnejhFTEcw?=
 =?utf-8?B?V3NwRUowcGxVTkpjUWpFaFYwYjA1bkNqNEcyL0Z2YW5NdkNRc2krUVU5WmRL?=
 =?utf-8?B?d29HWS93MzdlanQ5NDY1ZGNtVE1SNTQvYmI2OGtFOFl0ei9VdFNQemxqQWdp?=
 =?utf-8?B?UlFINFVvUmtjYXNrY0FURnR6YUV5QjZCZkZYMENYOEFyNndkbUpGMXFOcFpa?=
 =?utf-8?B?RFRzVy9ydjRsdWtyTkl6R004Sm41NmdacTNYVHRaWXNlZ3lQYnUyWU1qOUo0?=
 =?utf-8?B?cDhhYXBuakNWY3FJWm5BMy9WRXMwaThIZDY0Mmpnb3JXMDJ4L1Q1Q1J5M3ZT?=
 =?utf-8?B?R3hkZEtSbGFyWGZ6QXdYK0lVZHh5c21IMCt4Zk52clhnMlByNndFU0lYNGZH?=
 =?utf-8?B?WDJheWZ1QWV0U0pzQTdiVDV6S0M2TDRrMnZsZmJ0WmlDT292UnhjRVpnZmpa?=
 =?utf-8?B?WlpBMTFMUWR5NlI4UGVDL1ByKzBla3RhVnhGZ29VejczYitKQTQvWTB6ejJB?=
 =?utf-8?B?TDNMeEF0L2xINXJrM0RnRy9aMHVVZVZCZXplMlgzOWhLZ1RMcWpkMmhwbnZ3?=
 =?utf-8?B?L0lvR0dTcElZdE5ZYUtXTjNmYlNnYW9odG5JMDR2TXJ0cUVuQmg3OEsrbnA2?=
 =?utf-8?B?aUEyMGkyMUx2VVZ1SE16a2k4ZXdMWFI3ZFlGd2hlUVhmdXp5TXdBZFllTUli?=
 =?utf-8?B?dmYvbWJtWTArKy9iMy9hSjJWekp2UjlBd2w1bGpOdVhqeDFlbXdMcSt5Nkxl?=
 =?utf-8?B?NVBHRkc5NElqeXpROGNqQ0N6amhpL2U3bUZINEZ6SVNlamxycHdSL3IwcGpu?=
 =?utf-8?B?VUk3U0hQc2JwbDQwdVEvRUxFbVFYbmR5Sm1iSHltZnRaY0F4aXNwTStqOWlF?=
 =?utf-8?B?VnpuYzdoS0kwQzBJSWVONHV0Z3JiMmtzV2tpZHBTdHNwMTRSMGEwSEZQalhk?=
 =?utf-8?B?OFdmZUF0OTExTXEwR0JEZ29laU0xelNrUjNVbTk2M2VJWVJkMEpMV2xqVWxq?=
 =?utf-8?B?RkxITXc4QzVSL1JUUGRtZVR4ZkxHSWVHakRMK0VsdXBNMGc4Y2paMnc2dCtJ?=
 =?utf-8?B?ejdub0dGNVA4QU9SUERJSGYrV1BzMDg5Skh2YkQ2TVF6cmlEcWhqRnl2Zzlx?=
 =?utf-8?B?WFNMVXpqd2lhVnlXU0xnMkNZZEQxbDJNc3ZjRGFNYVZ5Vzk3NitjS1hQUE1P?=
 =?utf-8?B?RnN3NFhCVmdJdXZqd1BhZEhLVFRBWkg5NUZRNkF0YWhLZ2NOeXZyQ3RsL3BR?=
 =?utf-8?B?YjQ2Z1l2ZG1GdHg0NzNTSmhUaFRjR21neWZzemJDUjUzbFR0bWZpRHZDaXRy?=
 =?utf-8?B?d0FNWnkycmUrSzFBTnlGVlMyaUNPZDlMcWxuQ0JFSHZkcVpuWkNrd2xtb2ZP?=
 =?utf-8?B?YlBKZ0dhcnRMNnJXay9rMEJiNmszWlFPd1FCK3JLeTlOc2lIOThONmtFL0xa?=
 =?utf-8?B?L1UvYlE2UW9FZVRhcDRCL2ZnaERUdnhWMnhNRHRBd3Q5ZFFBdDVoNUN4ZzhF?=
 =?utf-8?B?eFg5VGpPMzliWUUrYU9NNmRRWlRoSnhQbndLNzRTV3oxRS83ckRpWEU0T2Nu?=
 =?utf-8?B?V3hZaXIrbkdJWTQyZS96Z0FQNUFkbDRucDRuYjNDNHVvTzRpR2J5dWNGaDlQ?=
 =?utf-8?B?QjVaQzY5NGZzVlI2cXBGZE12eko4QTlMU3RlRmY1VzhlREFJa2dOZjZ6OWU5?=
 =?utf-8?B?RkoraWlwTldHcUZ2MGpHTVVrOFpYNytaTUdlTk5CSE8zUkhPZU9WT0VjempQ?=
 =?utf-8?B?a2RGZEt6bVBDNUI5ZituWDlDeW4vdUZGZFJIbUhFUVpWby8wOVMrcXJINGlS?=
 =?utf-8?B?anBPRHNtZy85R0JOdFMzRUw5Njd3a2IxYUNXNkdzUnI2WEF1S2NlN3FuWVFO?=
 =?utf-8?B?UkxXd3YyYTlHS09JRVpKUW40VzJJNE1GV0JNMC9pU0doSjl6MSswbUVuTE5u?=
 =?utf-8?B?R2wyUlpWQ1RZR0E2VTBzUzV0TjNuS1Y0WmEzaitpUFFTNkZxa2c0dm5pWHpw?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	EWPIC9q2nzA9AKcn2X+bxXhsmrp3g+F3+MVtAJGA4LKOwyDWyCB0OMUrlN0Q5F6ZRJ7fln1uhyT/1GWJDB0Keh15QfPy7RlDlA4FmtJsfUlNTpVyV4511WBjsUwdBHr7FMC6jhai/TzE2uRhAfw6seaizAg2fz4MgMUZdouh2NQKRp2OHhteAX9rJuUUQhyiPDAsg44dQ4i+lyA6VCSscCT3hjZ5uzk9Kv2ZM9fqb+iXYtAbCjTWfpJ035liRN5PaWBO8IXcGTgLGoEQS4NHAeY6Mg3njwk1Px3Dwc7BJmMIDXi5u2a9sR+y2KLgwgWKDcqzZxY5sMnWE87ur1S1vNJNZ/HJEGuww4Iso3RfoWDkHvjYBSJH9aiPrCDyYqRhZpwB042SYuoj28A395wwuqMme7dkOCHv8AFpwGUlGvg0Q4+1vUKs9AuFPuztjpDP9DC1iL1RMaQ8Pi1cOfZfd+fz22/1vdu+Wq4oN6SfAOXWf1xkmp1DFq8R8Ao1cawuN+ynAd9Sxjnw4ah3cjnj18v3SbBdseC4m0JdFqkUF4eGbCmQZVK59yxWzQsyk4UUaFFHup4TZz3DYk+lEJEXOpJWMiTthdxt9DEvxIAivRs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac97de2-48b3-4a49-c882-08dc0869dfb0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2023 12:30:00.0588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ja6xNAnrYe6Qg8P6ZCs+pf/p66ywjuNTqm7+tBpE6ziM2BqsgpxhrojQbkzbgt0smlfHZL7nVw2o4bZTWWoBAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4695
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-29_04,2023-12-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxscore=0 bulkscore=0 mlxlogscore=683
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312290099
X-Proofpoint-GUID: Wbdt8Cw0w2EAWIOiNd88Z6DFxWRv8RGZ
X-Proofpoint-ORIG-GUID: Wbdt8Cw0w2EAWIOiNd88Z6DFxWRv8RGZ

pls ignore this sole patch.

