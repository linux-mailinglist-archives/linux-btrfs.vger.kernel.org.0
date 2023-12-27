Return-Path: <linux-btrfs+bounces-1145-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA0181EFBA
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Dec 2023 16:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DFB4B21232
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Dec 2023 15:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7225A45BE1;
	Wed, 27 Dec 2023 15:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vkf52ut9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iKT1yE52"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDCC45BE0;
	Wed, 27 Dec 2023 15:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BRAivaf022682;
	Wed, 27 Dec 2023 15:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=3VlAmmodl43QxawWrjMdYPyjR/W7n7w0qeA0BILR27g=;
 b=Vkf52ut9l6jmChZru9um0xhkjxU5yBOpMq5NmCGx0YDgl/Y2yBYIQqZETUW4YPPx4rR0
 BpcjMDHufY2KkT2L9zUIyJ1Us+zxSSkt/8j65GrIi/xr2Ldpt8tHh6EwlFiFqVWeOYkz
 /I4oUTXyhgKzP0F2FMSCuw1NPGrRN/rwfcsUqpRUEqnJCidMXOwfDwVI6ZDf/+MvaGgj
 L5+tECt4PsFig5uXW5f2eozzXeiGfrO90jtZBVpZwJAeadq0G1PbWIUNV+OS5E628hlu
 KUJZDnkAIeHn2NNu1kkdrcuoxWg2rM438gDKMO3tpRGQ2YB6IRt8qLH3BjDGdhKc0f5V 0w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v7f3a27wa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Dec 2023 15:19:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BRDawZS007073;
	Wed, 27 Dec 2023 15:19:41 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v5p0bxqf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Dec 2023 15:19:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2QGmmOBHba01cG9YRJkHMYQxFM39mUHDo796OUOTtL+uLKlyi0Yq1/Is5neJrMBJ2zIR3t2A5f2HmHhls5EwwyD7bB8qeT4GMsC4i6LOZIrWpCOL/f7o0Q06f75jjuawryrJNNlueqao1BRuerBNuNMKai4p5AEx/NrG5qfHJhSImrL/gxAaLOuccJdsZ6XJi1NBS9aNdX7Qgd3jJdBfSo/GNFZnTddCfDXTBoeT0wqjG6hKggbYXEcEdTBy8ayt90uFYdurzsDJMjpDsUUGQG3Tm1j8SbNYx7hWC1vY0SoAH+ZSbZwTfJaU2NBCzczBiEMV7QDvG0Dy0t3rzr5qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VlAmmodl43QxawWrjMdYPyjR/W7n7w0qeA0BILR27g=;
 b=hEMjqTKvR7Hi6PHNqlN3lsbc5ELyiYdxAqfQMTrKJtFX+HtO9sOfUi4W6hbwxlAMJOR8z1GxkpoT7ctZDFpFQ71C4nklFCi/PFMnXD490wHWKV6QJekFESVkMfFrq2k2/tVdiWrtoym87lKnlGBHe6/2ruDYK8AmfWx0d+EGPCVIiPYgjZ5NL3rr54tDuaPLxgTCLX5HFrqZwfqFyahLfjRSCxmPc5zdN5iiBDZ7uqBuhbk/y5zIqcvf+FSAcM12Ej49GNSSBryUSh3nNwu26rtxnhTniaRHEhbaRyGvPfR/3iO2nX12i9AilFyGvnuBLLFBbrZu1fCycJlhJrYp1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VlAmmodl43QxawWrjMdYPyjR/W7n7w0qeA0BILR27g=;
 b=iKT1yE52gbGUZnFv6ETvGXtR3CemQgjQwOlf72VCOZePJwtkF+PsUCkDBrUyVLQeXx86T/RcqzuS60sRJxVKL+Hnn7qV9r+MJaooiAyEHdHppTWtV8yOmgaNYNwXTFdJaifAk4eg9avWuBHEPd0q6JFZXQ0Ezj/SVtdkQ/1vP4c=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB5896.namprd10.prod.outlook.com (2603:10b6:510:146::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Wed, 27 Dec
 2023 15:19:38 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7113.026; Wed, 27 Dec 2023
 15:19:38 +0000
Message-ID: <37f24bda-fe2c-fd82-38eb-d5d0e3e54842@oracle.com>
Date: Wed, 27 Dec 2023 20:49:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v6 5/9] btrfs: add fstest for stripe-tree metadata with 4k
 write
Content-Language: en-US
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Zorro Lang <zlang@redhat.com>
Cc: Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20231213-btrfs-raid-v6-0-913738861069@wdc.com>
 <20231213-btrfs-raid-v6-5-913738861069@wdc.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20231213-btrfs-raid-v6-5-913738861069@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0058.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: db077d63-9bee-429c-f605-08dc06ef3dd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	p6qP/hKaS0IJGdx0O5D/xiZg/NazhPRFBUAyp1s4egRN+w/ny8UDBj3GS/98M3qYkP1u77wFka5dK9pM/EnHkQDgw70MZsaAt3Rs5QRCSpdMxEil/sB/cOmj6ihFwknUqCnr82EvpTDZqqylmxTxzRECGd6ZLjzn8ef8P8/Xt1UiPCXSIqUFHn1yDeQDHiz89Zhgmn88M+kguMlmOsO76k5VqRSC94k5Ssy4QbSEc3tpGwIiGjR7dMI0k8cHqRUvT3b8OFu7hQUkGdEIcsCo09bH/cmP+PfZ8lyir+Fz0YIIF8CrIryuyLGd3dyXQ3GO3gxp2Il3aIzEejU+expjUleJGwyWBAsfWy6y8FLj0Jn4/EQWHDhy1UoZaNt9u2XXcnRkZZUVyMo9qlFYuaAwt4Kvf22g4uUkRPjNS2P7jsC/vE9Bzbrdb8cmDesK2ZTerrDS67DfbK22u8NODYSG+jc+DvxeeIdoH+OEFtEkNq6z9vMbGvfqcsEF179XlKxoIjQGqJsWclOgTw9kJ+cTDLUBoYkrRLNQc0wsFCKPVlytOmZVO5b5cXQIxveoHKY7h2ZZt8I+qVzpaFxB6euW8EQLbSMCLN5jgPFC4qBkjLTUC6kCoqjhq/jAvczk+qmUMT++wuil4AqlDEwJI0jDA+tAWzUl6COEt4ZfaGtsiLw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(376002)(39860400002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(316002)(8936002)(8676002)(2616005)(6666004)(478600001)(36756003)(6486002)(86362001)(26005)(6506007)(31696002)(6512007)(53546011)(38100700002)(41300700001)(110136005)(66476007)(66556008)(66946007)(5660300002)(44832011)(2906002)(31686004)(4326008)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z3c4a2JZQ0oyZFpwclVJUlBLNzh0OFRTM2xkM2I1Zk1NL2U4TndNQzB4cWdL?=
 =?utf-8?B?ZjAzenVKSC9QaUs1NG5CUDBWRWhjbXkvWGZuNHJGYjF1UVdRc3hGazU4d0wx?=
 =?utf-8?B?dWNZQkNJNS9DUUxDNGpYRHdvRnhhZmNLVDlRaGpNenZ4akhDbUdMWEFzZith?=
 =?utf-8?B?TFd6TTRIQUdXN0d1WGFTa3V4ZVJKMFk1bjBBMFhyWWVjUFdVTUxEaG1YVzhF?=
 =?utf-8?B?d2JEN3lsU1V0dnBWSmNxSk9JNXVQb1hWdXhrVnluMy81UE1LZjFRdTdyQ0hT?=
 =?utf-8?B?Nno0R0RDNzlTRFltUHNnZWxEd3Y2Y2dYejgxV1hjZUpPTFZ0WjBhMkljVGlo?=
 =?utf-8?B?NlpseExGdGpEaHFwblZFQjhCVmZLMC90NzRVYXBsQlYzdzRqRVZJRGN3SFNZ?=
 =?utf-8?B?WjNWSnd1NGpkSDBaSmJhM2hLbWZBSXAxNDI2bmV4a1VqQWE0UjQ5SDNQSUxW?=
 =?utf-8?B?QzlLeld6b1EzekhicDF6bi9HWGhiQXRyODNBUklDWTlCbHRoZ2FINUNVY1k3?=
 =?utf-8?B?RGZ5S2FTNU5RY1o3N1JLRlp5SWdVdEhYZWVpVEJlVG01UWc1TFBhdnhXeS9Z?=
 =?utf-8?B?bkp3TTJ2M0NQNk9mTDQ1eVRHdWZ5T0ZmUytHUjZVbG4rTlowRUdkb1p2R1lJ?=
 =?utf-8?B?WkoxSS80K1JHL1R5cHlKcnQzYXJJeWwyZ3JtSVQwUnJSV1lHTTBXNFpENTMy?=
 =?utf-8?B?WVNyWWptNVhIQ09XZ2ptYTZvN1hXckdCUkEwYjBZY2pvUURubDRMdkxSYUhP?=
 =?utf-8?B?dVVmTEwvQmJIUVJvZTVjcXI0Y1I3REpEcm41SlJ0RmFTdFBrNEY4VUpSTW9x?=
 =?utf-8?B?UWRaSnVueWZGY21tQmtJRGpoK2xxL0o0OTNwd1FqUUhCMDhTMnRCRUhtU29B?=
 =?utf-8?B?T1dlbUFPY3JDamhQWjV5blFQK3dQcldyR3IzTkI0RHZhQzJCQXQ0UDg5b0ts?=
 =?utf-8?B?Z2FJcnpNeGl2MGlQa0FEVzFzQ2d3RWFXeER6YVp2dVpZZW03NGMxaURCQ2hr?=
 =?utf-8?B?TGlNY2tFZWlDTWpiUm5yd3Y5MTZXLzgvTEczaDhNNEViZVIvRXlXQlE1TVpD?=
 =?utf-8?B?VEJjNGJpNDBsZ2NGMncwMG1BaHNHRFZna1ZkK0hWcFZVRzRQd2JscTBrNUR1?=
 =?utf-8?B?U3lqTG5DRzJvcEd3MEV6ZUc5VDBlcHR1UXFyeDdpTkE4K0xEYXNGbG1VOFRx?=
 =?utf-8?B?TU1IODJMeU5KNk93ODcyU0I3dDlscWhkQityc3VOdlFNaUZGbUpnYVAzVXMw?=
 =?utf-8?B?emF2cjV1UDZ4amNZUHZZYXFteXVmeEJwbnF1UjFsdWNnSzlWaVhUWkVjaVpx?=
 =?utf-8?B?a0FkdkJicVdpanFJdVVURkhRNERnR2hqMlN2aVpJYTYvdFhGc2VwVlZ4SWJy?=
 =?utf-8?B?NVZwU1k3Ti9Zb0JiQ20zcGdpQTJ3ay82cVZ4L3Z6VmdFLzA5cHd0UWhBWlMz?=
 =?utf-8?B?VjVzRENNNXd6VHU3UXltbjZCbktSVFQxdzljVHczRVJ2RVg0bmlFRFZBM1R4?=
 =?utf-8?B?Tkc3MitvTXJkT3lnRW1iWnVJbG0zKy90Q3pITVdEdnVxQmFKeDNUMG8vNlZ2?=
 =?utf-8?B?bHRPVldVcmNUMFkxUUJ2R01BUGExR2xoQUwreXNpWFR5NmRrTjhON1JDUUlE?=
 =?utf-8?B?eDBWU0NrVXVpamN0ZENweTBMMTAzLzdkNTMvL1VmemhuQWRUaXVZVEVPRUhP?=
 =?utf-8?B?RFIvK2hTZi9pd1FTa2Y3WFNLUVRhZW95dFBtbEVEM0x3L1VoQ0h4cjAxamIv?=
 =?utf-8?B?VGdST2pyZm1jNnlIeEdqL3ZHUEZVL2czOVlLejY3SkhOQWs2WTQ2WmVlYXht?=
 =?utf-8?B?MGhCaEl6OHY3a0U0Y0xDSDk0WVV5THkycFU1d0lzcUphb3E2aWd6RnpieFVT?=
 =?utf-8?B?aWcrRk5pMEozcndlbU9wZHBuc2RhNmptcnc5MzBWQzB6c2ZhTjE0a3RYQmht?=
 =?utf-8?B?MzE4QWgyYm4vTnpKSERtd0RCb204cnlxdG15TEl3T1pJeXRQSkZyc3JXV3Ey?=
 =?utf-8?B?VWFpbEh1WS9ab3RuZ3VqaTdKVEREU0FodUVhQ3NDSmtnQ0ZLYTJCN1JjZS9E?=
 =?utf-8?B?TkFyelJLMVFqTVI2d3BHL3cweVFUZ25ISXFKUkdkWk1zeHJkUC9UUVI0YkVx?=
 =?utf-8?Q?P+UBNeqnjEFaLS6vKzjibwknt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZyQJ212e6PqUuxOYNBDAGXLeipaShGrCa4xnCI9A6E284yO+YTprGU1FlMVTN1Ev0g53yf2QXvqA9GjIVV09L6awr3lxwXOJvCVpC4jNOEZdlGjaVUeJmYFRO8OXfSSSCx6wdJ3x+5LaSq8Ck9WeZm0tZK965Cr9St1EBOzRA1ju8ArH1encmqcw0gsEJYf0zQawhq0mxp+ALuiZVGAptVQ0V0w4fd3USDeQd9c4ZCs0LHStP2q7lVEDtay92eItsw/Ati1BcVcAOHpwfjsV65BsEzWCzySUz9S7eXetQLM1cq8wwvN5VCHR+87GikjLkxmMRpU7AivZ73nUidf2b5TU3FEHpNy+K2PAeD/bYVQwctHDfaq92aM/9YGxqnZ2oHv3SXprODUIpQoA+zgwCwWHg4mwJCKRsPBJNvFhyAbyuj0i3SM0gwM/P2nXptN8mT7as0LNnOhv1RDkjSn7+VUG190k1nvk8cFTAHpKpkO7oGj+oatdrKqaScKgGwV3j0xmjbTWzowQmtUQkTWl1bsYJiRFD79qjeC6zTbjR9L3LqgBKl3RGDdqejba4y4sjMpAM9bvIOrYvqbyhVnnCJoo6wP6NLH4BI4D9XcVJaA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db077d63-9bee-429c-f605-08dc06ef3dd5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 15:19:38.7309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86m2eziUMSwVRy/2uEe7myuTYU2v8cok+/h7tYLDuno/LOhGFECbx5626lHAS+YaIa95dNWKk6qB6dcaB6S0bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5896
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-27_09,2023-12-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312270113
X-Proofpoint-GUID: 4XIZFNqAhN0M6eMJoFPQ_DlIREtsLjog
X-Proofpoint-ORIG-GUID: 4XIZFNqAhN0M6eMJoFPQ_DlIREtsLjog

On 13/12/2023 17:05, Johannes Thumshirn wrote:
> Test a simple 4k write on all RAID profiles currently supported with the
> raid-stripe-tree.
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   tests/btrfs/304     | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/304.out | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 116 insertions(+)
> 
> diff --git a/tests/btrfs/304 b/tests/btrfs/304
> new file mode 100755
> index 000000000000..05a4ae32639d
> --- /dev/null
> +++ b/tests/btrfs/304
> @@ -0,0 +1,58 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Western Digital Cooperation.  All Rights Reserved.
> +#
> +# FS QA Test 304
> +#
> +# Test on-disk layout of RAID Stripe Tree Metadata writing 4k to a new file on
> +# a pristine file system.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick raid remount volume raid-stripe-tree
> +
> +. ./common/filter
> +. ./common/filter.btrfs
> +
> +_supported_fs btrfs
> +_require_btrfs_command inspect-internal dump-tree
> +_require_btrfs_mkfs_feature "raid-stripe-tree"
> +_require_scratch_dev_pool 4
> +_require_btrfs_fs_feature "raid_stripe_tree"
> +_require_btrfs_fs_feature "free_space_tree"
> +_require_btrfs_free_space_tree
> +_require_btrfs_no_compress
> +


> +test _get_page_size -eq 4096 || _notrun "this tests requires 4k pagesize"
> +

I made the following changes, to make this test-case run.
Also, in 30[5,6]

-----
diff --git a/tests/btrfs/304 b/tests/btrfs/304
index 05a4ae32639d..f1db52c1ba5c 100755
--- a/tests/btrfs/304
+++ b/tests/btrfs/304
@@ -22,7 +22,7 @@ _require_btrfs_fs_feature "free_space_tree"
  _require_btrfs_free_space_tree
  _require_btrfs_no_compress

-test _get_page_size -eq 4096 || _notrun "this tests requires 4k pagesize"
+test $(_get_page_size) -eq 4096 || _notrun "this tests requires 4k 
pagesize"

  test_4k_write()
  {
-------

Thanks, Anand


> +test_4k_write()
> +{
> +	local profile=$1
> +	local ndevs=$2
> +
> +	_scratch_dev_pool_get $ndevs
> +
> +	echo "==== Testing $profile ===="
> +	_scratch_pool_mkfs -d $profile -m $profile -O raid-stripe-tree
> +	_scratch_mount
> +
> +	$XFS_IO_PROG -fc "pwrite 0 4k" "$SCRATCH_MNT/foo" | _filter_xfs_io
> +
> +	_scratch_cycle_mount
> +	md5sum "$SCRATCH_MNT/foo" | _filter_scratch
> +
> +	_scratch_unmount
> +
> +	$BTRFS_UTIL_PROG inspect-internal dump-tree -t raid_stripe $SCRATCH_DEV_POOL |\
> +		_filter_btrfs_version |  _filter_stripe_tree
> +
> +	_scratch_dev_pool_put
> +}
> +
> +echo "= Test basic 4k write ="
> +test_4k_write raid0 2
> +test_4k_write raid1 2
> +test_4k_write raid10 4
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/304.out b/tests/btrfs/304.out
> new file mode 100644
> index 000000000000..48036efbf0cf
> --- /dev/null
> +++ b/tests/btrfs/304.out
> @@ -0,0 +1,58 @@
> +QA output created by 304
> += Test basic 4k write =
> +==== Testing raid0 ====
> +wrote 4096/4096 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +5fed275e7617a806f94c173746a2a723  SCRATCH_MNT/foo
> +
> +raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
> +leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
> +leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
> +checksum stored <CHECKSUM>
> +checksum calced <CHECKSUM>
> +fs uuid <UUID>
> +chunk uuid <UUID>
> +	item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
> +			encoding: RAID0
> +			stripe 0 devid 1 physical XXXXXXXXX
> +total bytes XXXXXXXX
> +bytes used XXXXXX
> +uuid <UUID>
> +==== Testing raid1 ====
> +wrote 4096/4096 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +5fed275e7617a806f94c173746a2a723  SCRATCH_MNT/foo
> +
> +raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
> +leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
> +leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
> +checksum stored <CHECKSUM>
> +checksum calced <CHECKSUM>
> +fs uuid <UUID>
> +chunk uuid <UUID>
> +	item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
> +			encoding: RAID1
> +			stripe 0 devid 1 physical XXXXXXXXX
> +			stripe 1 devid 2 physical XXXXXXXXX
> +total bytes XXXXXXXX
> +bytes used XXXXXX
> +uuid <UUID>
> +==== Testing raid10 ====
> +wrote 4096/4096 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +5fed275e7617a806f94c173746a2a723  SCRATCH_MNT/foo
> +
> +raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
> +leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
> +leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
> +checksum stored <CHECKSUM>
> +checksum calced <CHECKSUM>
> +fs uuid <UUID>
> +chunk uuid <UUID>
> +	item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
> +			encoding: RAID10
> +			stripe 0 devid 1 physical XXXXXXXXX
> +			stripe 1 devid 2 physical XXXXXXXXX
> +total bytes XXXXXXXX
> +bytes used XXXXXX
> +uuid <UUID>
> 


