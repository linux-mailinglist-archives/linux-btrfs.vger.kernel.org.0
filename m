Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA253687121
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Feb 2023 23:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjBAWpG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Feb 2023 17:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBAWpE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Feb 2023 17:45:04 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD2D38B4D
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Feb 2023 14:45:03 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 311LE3cX007761;
        Wed, 1 Feb 2023 22:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=LDizRYayywrb3w297dYVxAhQTZetSIl1UcghLCLTOog=;
 b=aCqWgOH5PdFJ/VkJUe/x6qNKhr7Bi6UX6aa1pp0/XJlmzCuToIvQjvuTdO1ZxfWLB+Bq
 M0UGOMBALScckBiSs2VU8kqxTrCoBSkgRunujtL1vgsF3eM7kqxxJWU6OxaozkWZ/L5u
 gr1j1GuVh/NmfpGQNPx9HYy0KaXXmCrDWEBMbWwvKr/cykuFQOsU6Kl1oK7L/5rnuBwQ
 guUBxVu+u8QIbzqQMw5YSmJaP0R4uadA0osljMwJjj18DCaLGT7lFqaldofU13Kh0Fff
 01qqVFI+67XXYKHFXwxIVf1FUkFLEBrB6DDaZzpVBJ7KeAEHzuLkrbM9yDzfpDZRnE2W zQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfq28shuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Feb 2023 22:44:49 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 311LdYcW033831;
        Wed, 1 Feb 2023 22:44:48 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct57yph7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Feb 2023 22:44:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBNLBtT9WE//Y6eHXdxYlrJbbNnfnVF42XdQ9MMVPOMlPY6uOa160WtufvtUzVogiTulYSq9iIGUgHkX+MwDLnpkN6hApYwgHAIRJiSxEkkMJ3wOQbq3/1VkGg8vT0hwbIiFWOddo+Dvr6Bag0dsXBtWoz7pNEP1h0ZazoMa9GV4fNZ2nSqNd5CiGRcC05oaO4a/b+8JtzIcC4/1aanuRK/znAoSOAfkzBcsnw5+bEQSnkCX7zAjbu9RVRhpU3W7e3TOlwCuDpaj+4XWcuw0753t0rdaDBt4OFZ4AQCLFzjrMQTFiChutkEmIvvoc4yLcOGKNYyTD+aKKOHfd7nK2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDizRYayywrb3w297dYVxAhQTZetSIl1UcghLCLTOog=;
 b=ax/JBc+4z+aY2CBLslfUvoDRAwYxrNx4nLI5sdqTWbgTIZTB/X4CFH85Z7oTgF9Afaj4tX+P+z6pBvt16zzzt89A0WGF+LleflIeMfj6fFRKh8QxqFaGVtRpY+8OIhAxTEpXqropg5STBP9XPktf72psGJhie5vMBO9Wzm+/Qf5jDW3n4gd+DaZgAV+cqI+29lE7Pg4FOWS1Mxjdh/xAj8qcj57xmuoVt7wTly3Nnp/sp01kd92T6PTFKDfZeYxC8xsPKriXlKH2UsVOniR9avYufkgU0F4z/S0fEeYVRPjDMtK23k+dCdbIjy1UZOwig/SgbXIkZD1UL/tH4JJifA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDizRYayywrb3w297dYVxAhQTZetSIl1UcghLCLTOog=;
 b=S49+v0m5zBI6fjIRPrylF1Xa//7zdOZC0S+MRxJ/t7iN93PxuETOKR+2WfA4tRxQTovplPZmx5d8arTpIXIcGfpuUEqa2oBTrLg8vREmY8kHdlvHjl4My54bwc+fNx4eY5u273oBukiBfujeBDm9T2qaxvxBkBOIted7aMrxNGU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW5PR10MB5805.namprd10.prod.outlook.com (2603:10b6:303:192::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.20; Wed, 1 Feb
 2023 22:44:46 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%9]) with mapi id 15.20.6064.021; Wed, 1 Feb 2023
 22:44:46 +0000
Message-ID: <7b2b7360-9008-7d88-02db-1ca4f07a6df6@oracle.com>
Date:   Thu, 2 Feb 2023 06:44:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH] btrfs-progs: restore of xattrs fixed
To:     Holger Jakob <jakob@dsi.uni-stuttgart.de>,
        linux-btrfs@vger.kernel.org
References: <63da9bfc./KHue3enEPkwBabd%jakob@dsi.uni-stuttgart.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <63da9bfc./KHue3enEPkwBabd%jakob@dsi.uni-stuttgart.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:196::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW5PR10MB5805:EE_
X-MS-Office365-Filtering-Correlation-Id: 560905dd-270f-4e9b-3375-08db04a5eac6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rG4WBmEPy7UoFIo15OSog8XGOL87TYkftUM/GVjXmC6gPBX0uFUyKONqegdTySlupEWLoDbrl2N4kOZdAzWlKxkARaZ51qlv0c1WypGdFeOplucrrC4MA0WB4CWib5xwwIrU1AvBHoH/hdcwIrDk39SdatUfy2tCI+VNyveutzR04VWlKcHkahNxS97nDmpNgMCjiTXyGbToB75+3RqDqpYQRDJSf7tuhqNLAX9fwdXAK+1jxKQsHAzQUd/Xe7kWyozH3BVvb8QYmFqt5Ia8BWPINu+PcEtWQ2BqyYNPuCMjFe6JpcoPED68PHFoJFqKa2LJttSDMe+44hVnqcIJIcA3s8Bp5sucUe7F0Nc5rK8hUwkhmzXPXFaTj1MvQNbXgULt5zH/5EJiosczsQhU9IYkfh4oIqM2KZIiNOUeABJAq3IhzWV6LkRexTzKTGQ+ILb0/RgOMJpaTji8A/v4mU9hBVMhoA5+5p6J4vrlsKgOWeFAR7hidGw8OqRCssAnHZx6flhMSAQVzsjHLcjr0r2XVbi9Ogy1DI1ev7gfI0yBjyMGNUodyRfiTfPrd2fILBmQLMVgrbKH2tf6TRGfvrQVRupDXc/JnIYETuk07Dj5+H/lBOIfi25rtevpToEEnTViam+qPkQT2v1LxnIJff/gag017G/jCBd/xBTwwQKgt11ZZ/aoM2wUOW+Hv6Jc5hrmn2CgHMpCm18C1n8mdF0JxuXti4x/p9hDFoN1uSg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199018)(41300700001)(83380400001)(66946007)(316002)(86362001)(44832011)(31696002)(36756003)(8936002)(38100700002)(66556008)(66476007)(8676002)(5660300002)(2906002)(6486002)(478600001)(31686004)(186003)(26005)(6512007)(2616005)(6506007)(6666004)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVdnMjI5anZYZHhndnR6WFhya2lDSW16eTRlQ2tWbU5KTlo0MnBNNGJBVW1Q?=
 =?utf-8?B?eDg0QnVkM0NEMlpRTDNTOEpnbVpyVlZUd0ZLbmtqc25mQmFvaTBwTFY1WTd2?=
 =?utf-8?B?OFNhNi8zOFd1VEttN25nVGYycDJYQVl6emd1Tk1kTXNtR1FMVVJrM1pmQjNr?=
 =?utf-8?B?MXJHS08yMnQxYmtEaHhsNExiVzA0QzZBOFlObkQ3RDFwaldQc2tKUVlxM1NQ?=
 =?utf-8?B?Q1NTRkhqMzRBRnllakhIRm9uTEV4Q2xOOGh1NmhNWGVPSVk5cDJsc0lxNmph?=
 =?utf-8?B?UHRrbFU0Z3Z5VXBYZlJYVmRsSlBOZFhJQ0x0VndyQk8zWWZzT01ob3dUMjJs?=
 =?utf-8?B?YnJ5bU1RbWExMGx4eFRTcGJIM2pPcVU0a2p0NC9XNi92L0lGaUVPU2NURi9k?=
 =?utf-8?B?VHBnYjdUd2RVZWV1L2wzRHlaZ1hoaHQ2cHZBR2RDUnMycjZhNHJ0UTc5MWVD?=
 =?utf-8?B?SmV3M2pMSHJZZ09pTnc1Y2tVcC9JUGpydk9FcG41Q0dPWkZ1NkN3TGtldGJi?=
 =?utf-8?B?bUpFbnVMTlBlS3hFQXpoQlp3SUFTSVYxNnZUV093U0NNV1dHbWFjNHdFOWxJ?=
 =?utf-8?B?OHFpSCt5YVRzTTdNcm4rZnd4UStFV2RNVVhrVmFQd09jelRkRlRTR2FoZmhm?=
 =?utf-8?B?SCtrVW5ZQ1BnVUVySXZteGsvczNXbDhjbFRueGNGQkNPYmE1QnRQMjhRR3NU?=
 =?utf-8?B?Q2lPN3d4T1lFKzhxTFJHUEovQmJaNXJnMVpISC9MeTZjQWRDK1dGekxZLzBp?=
 =?utf-8?B?L3dMZGFtb1lOTTRJckErVWFUTE1jUEEyektHK3l6MVZSb2dLY2p2V0E2VG9Z?=
 =?utf-8?B?Vk9lQ0dLMjdKb3lyd1lUZ3NxWGhEOGcxM2VtUmhsVDZyeGRpclJJQ3F2MEZr?=
 =?utf-8?B?Rnk0Rk83d281T0dPbkdISlZuWlBwUFRnaUxPUDJscElwUGx2TEVBVytXUWk0?=
 =?utf-8?B?b2NhWUFYWkhSTmVFQUpMZ1dKZmlYaXhzQVBaZFBpdWM3VVJwSTVGVmZyNTVv?=
 =?utf-8?B?K2xTbW96bm1GTEgxRTdheGhrVlVaeDV3QnNwWHEvVk5rNGpPaUhnUEpyalVB?=
 =?utf-8?B?SmFZZ3c1dFE3Ty9oaUNZWExrbGpYMUIvSzVKNDd2Mjl4UGNkNldWc1E3THJ6?=
 =?utf-8?B?a3pSSmdwY1hTdHBiazV2ZGdIMS9wSGNwRW9ocnBTaXEveE1EcVZQSE9ab2Fa?=
 =?utf-8?B?TUVUeWFVYUcrYklxSWdnbDM3MDB6Rmc5SFFQWmJEckpzQWVsbDdBYTFCamkx?=
 =?utf-8?B?bU40VDhpWm94RVB1aDJqUVNHZkE1V0ZUS29WZ1BJTDhJd2xEYUFaVjBkM3VH?=
 =?utf-8?B?Vm9oSWhFSFl6bnlpbVJXVXZheUhMUkRDcEtBK2JRVUxCNUVZSVA1Qkdud1ZS?=
 =?utf-8?B?TTlKcEZJdkNITm9nOWlXRStWYWl2NDFUZjNZemRVOE02T05PQldsVGxVTE5X?=
 =?utf-8?B?bjh6UFh5UXR1WHpYeHIza2hpWkNJbytGQTJHVTlLazF3ek5BNVloelNNTjZ5?=
 =?utf-8?B?QlpPdGNIV21kdTE3M1B4bnJNdVRsdjNnS1NjdENyRjlGVTQ0MVh0Y0tJczNQ?=
 =?utf-8?B?ZGphVzk4Y0RVMTh1bmx5N2JZV1JycEJqK1hWeUFRVWpiZUxacDVmRFRobVhQ?=
 =?utf-8?B?YXloTlNWeXhUVHlsWVNzbFZ0OFhBbDF0Qy9PZ2xSVkgzdmRJUjM3ZzFHQjZo?=
 =?utf-8?B?NzFsekxma1NoTGpyTjl5MEZCR1FacFM1cmtXcHFwL1hkWWxyMGxCbTNtRE5T?=
 =?utf-8?B?R0J5M0NwbU94VW91T1R0VExlTzNpaGRya1p6T1BkT21sM24xZWg3QXNTZzBz?=
 =?utf-8?B?VjMrQ1ZqclBPWlptRzdJV2Y5VHcySnlNSHpNZm8zcDhleEFUUTJuV3dYcVNm?=
 =?utf-8?B?VWdsMDRQUUkzQVZEckQ4b3VlbFdrSS8zR29ocUJoYjMvUUp2Q210SHV6clV4?=
 =?utf-8?B?RkQxZ1l3SzVXOTlGOTFPZDdmczN0Wk1RR0RjN3BtczNrWXVrS3N5dzZrb3Bq?=
 =?utf-8?B?cnNabHpuZHZxVGF2UEFTbkM0dzY5R2UxeC85Sml5SUJlNEo4TFdoWlhvZFpz?=
 =?utf-8?B?andXaXdDTjNqRE0zbVVST08wL3VzdjJBZUtlZWFKT2JwSnlYSlhBTFhCTTNK?=
 =?utf-8?B?YzFFVEd4WjEzTUxyczZ5VGJCSyt1dVFuSXNnL0FzUXJFSlhLQTEyYUVYK09R?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RiDkW8oSmTPhZ/dzNTHEp04wHFNp4vTLVP1dYyaZQ3l6ykAdlA5guqm5hV83EX+5wNX9hn5/8o49n2L9fmH2ZAixwmEm70LOjJfEXs4WkrjT/5yLA+PW286NynbSM79mC/LO0BfXEJdAjjsqCMwRiyM1Zj7Vmw2vLfhpTzJmz6ecd7qZlGEH3va0Z+o9yr/oXv0mKOCS/9xIuVGUGJiDUPHepPIBThb9IftHZ+RN9OiK3yiGYNTuiXAWSaCUF3BKo2BSQdQhx21x7N61SY7dqvFOmxhTWgZBzDRuVYD1c+8K3gBnpvBgst5UPOBbRoChPU8ouJNh4oSIPqfwMkyYm5UphIjKU9FDeRZbm+DWV4+AzB3akGxCMItVzVQWQV8ALh76+lqDzCJq3RHY4RE3rsOCADVwp8CAfDV8Bx7i9qM8vTstacDCXdSOrhEChKVQddaaari6flKBGz0hIAMXRKbA9RJGNVthd72b+LIirZ9jPXJr0oGNdcyoMO8yl3PYQ8t5gKvNsh1xl//ayPDbBS3OaVxziuaLxE5T/jT5K3RDIEroIj+YeDUDveu4lpW3Temliu4cT8HBN0/a/5cXk/JLVH87L/Q/1FmjWWsNA9D4UM3bM2+n7BvQyLlZj9GcgmhJRwY1GevhHV28ozv/yI01iH9RyjR8v+qvIkW0bYTtd/zG+CY8qylaTdIkMBnzLjw/bNyIgFtxdUCviZZCsIyT0DGi7iJekEPfV7FneTstGWEbWLOq00AAzJ+bVGAmu184e3voyQwNiPJ+gWiMaTff6gka+uabo01OkF3WV3EeuYMqY62hRJxWAOARbFk4
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 560905dd-270f-4e9b-3375-08db04a5eac6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 22:44:46.1310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJakPrnJTRgvbJQmBZNuVINdvInm0Z+Qp8bv1ZjapztXD2ZFc8iYA0wjXw7fiz4B8XjGN8IaB3mAV1FBPtrIbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_04,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302010191
X-Proofpoint-GUID: SvaHu-vGLLyOLjp6VFJkLRuCAur08Kro
X-Proofpoint-ORIG-GUID: SvaHu-vGLLyOLjp6VFJkLRuCAur08Kro
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/2/23 01:06, Holger Jakob wrote:
>      Fixed issue with metadata getting modified in dry run mode
>      Fixed issue with restore of xattrs not working on directories
> 
> 


Could you please split to one fix in a patch? And it would be a great 
idea to document the failing command in the change log too.

SOB tag is missing.

Thanks, Anand

> diff --git a/cmds/restore.c b/cmds/restore.c
> index 19df6be2..c643f956 100644
> --- a/cmds/restore.c
> +++ b/cmds/restore.c
> @@ -621,6 +621,26 @@ out:
>   	return ret;
>   }
>   
> +static int copy_xattrs(struct btrfs_root *root, int fd,
> +		struct btrfs_key *key, const char *path_name)
> +{
> +	struct btrfs_path path;
> +	int ret;
> +
> +	btrfs_init_path(&path);
> +	ret = btrfs_lookup_inode(NULL, root, &path, key, 0);
> +	if (ret == 0) {
> +		ret = set_file_xattrs(root, key->objectid, fd, path_name);
> +		if (ret) {
> +			error("failed to set xattrs: %m");
> +			goto out;
> +		}
> +	}
> +out:
> +	btrfs_release_path(&path);
> +	return ret;
> +}
> +
>   static int copy_file(struct btrfs_root *root, int fd, struct btrfs_key *key,
>   		     const char *file)
>   {
> @@ -1117,11 +1137,11 @@ next:
>   		path.slots[0]++;
>   	}
>   
> -	if (restore_metadata) {
> +	if ((restore_metadata || get_xattrs) && !dry_run) {
>   		snprintf(path_name, PATH_MAX, "%s%s", output_rootdir, in_dir);
>   		fd = open(path_name, O_RDONLY);
>   		if (fd < 0) {
> -			error("failed to access '%s' to restore metadata: %m",
> +			error("failed to access '%s' to restore metadata/xattrs: %m",
>   					path_name);
>   			if (!ignore_errors) {
>   				ret = -1;
> @@ -1132,7 +1152,20 @@ next:
>   			 * Set owner/mode/time on the directory as well
>   			 */
>   			key->type = BTRFS_INODE_ITEM_KEY;
> -			ret = copy_metadata(root, fd, key);
> +			if (restore_metadata) {
> +				ret = copy_metadata(root, fd, key);
> +			}
> +			if (ret && !ignore_errors) {
> +				close(fd);
> +				goto out;
> +			}
> +
> +			/*
> +			 * Set xattrs on the directory
> +			 */
> +			if (get_xattrs) {
> +				ret = copy_xattrs(root, fd, key, path_name);
> +			}
>   			close(fd);
>   			if (ret && !ignore_errors)
>   				goto out;

