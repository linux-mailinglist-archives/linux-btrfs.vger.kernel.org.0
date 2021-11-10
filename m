Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617A044BD85
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 10:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhKJJEe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 04:04:34 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:31376 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230445AbhKJJDL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 04:03:11 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AA8kTkG011840;
        Wed, 10 Nov 2021 08:59:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=hifgDK0WA2AfRi7ipwdNM99KV7WEmWXnEsCnVhltxU0=;
 b=YNITGfwUO1qiN7CDXpookWWyYNCZD9YIRk0wbYOF5ruDrNxo+fozaHRLxHPLOFbY01tB
 ooh8Z+TSxTyMU2N1JIrttc+cWhMTn+LH5mWMh8sZGKclX5STefdRcBOFvSX5niqO12JZ
 DzGC/tP9y4Rl93plyGXxS4Yta8gy+qDp8kDA7ggZzbiRZ8KPN/aoV1JYRMo47pf2qDyT
 EcRRHdwlZGLywtvwOjxYNR1LCXd8lCOz0M1BuoM7B5QcPtAfsXnitJJK8JTh303BBWCP
 d36V9gmYpU/qz0ixTdyl4H307xLHTkmHo6E8lNEQpXBQh9HZQypfY8KN+IKaZxQ/77tb Zw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c89bq8gr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Nov 2021 08:59:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AA8oKUe003366;
        Wed, 10 Nov 2021 08:59:42 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by aserp3020.oracle.com with ESMTP id 3c5hh4yvyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Nov 2021 08:59:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsQ67ZQNtssjv1irC0s0saEI9Ox3gfvX5A9h1b8GdoybreTBq5U8+B0UrPMj4gcKSyKXoCspBQPSedKyFUYyttfH/CjnP7GCiUh3ntt/oB+l3KsyI7GfIk1W94VI0p8nKcNR5pWNqUJYzBJKExhvwER9+Ev2YtAcyHRDXZeBLnphqPNZIcpxpTQhotfn1bGQsUu2PrhfXOwmNfSPyluWbyH8jxkfXZDS4mtZ1mb6d5yRvCDnwZ5KBAMqlgELdWQfazizW2jmXuxqjODoNdZrsiFEth4qbQJtxRirfQlTQIY6R2trPTMqYi8D0upbC2m02m9DYXno+CwDWAaQ36xYbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hifgDK0WA2AfRi7ipwdNM99KV7WEmWXnEsCnVhltxU0=;
 b=XwxPPJ7pod4QId/7kNPkLDODEF18NsM4Ayg/phrVZcJJ7A37FvquZu3D5GX68ww0EXRKu4IIk12+QvaB7MUs8kDLpBtAliyJmg6flZkwCG5Nf36Nd4Af8V0b5ZzBy0+LxtwWMBfzizQsztMOQpKTJaxfiV5UrbK+SMRIeFcO53KkC4MxOc9FOhNR6C1JH6yniyk72B9f9LZRxpphPS7oCSZGeVCNeHnThvAoHUM7PBCc8xyOOGilLZ+FqEQdFOxWhvs5/IUFdXJMd/g3Y8BiXStuFn7nyhBbDq7osvsiAmqiwjfKfyQhlYWZzsVeubbIJTejPq1LdxlK7997pDcDvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hifgDK0WA2AfRi7ipwdNM99KV7WEmWXnEsCnVhltxU0=;
 b=X0GRMmS7MqykTtoTJjMAAw10Nw2Ws44Yn+ghRC2+wj2etXesGw0u7IdNoAAwO/G0brgQJ5UC0yETwhxszMMQedSKhs1XhDTS+LhVT2HSmFGkLSybAyrUbDuyTxRgel8Yd0ZG0Ahl9qKnDxtv6BZbuldU6qpehbabG1NxNupJFKI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3982.namprd10.prod.outlook.com (2603:10b6:208:1bc::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.15; Wed, 10 Nov
 2021 08:59:40 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038%5]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 08:59:40 +0000
Subject: Re: [PATCH] btrfs: remove unused parameter fs_devices from
 btrfs_init_workqueues
To:     Su Yue <l@damenly.su>, linux-btrfs@vger.kernel.org
References: <20211110064217.98007-1-l@damenly.su>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <5ebf4a6c-31df-7748-ae10-1d15a481ce24@oracle.com>
Date:   Wed, 10 Nov 2021 16:59:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20211110064217.98007-1-l@damenly.su>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0227.apcprd06.prod.outlook.com
 (2603:1096:4:68::35) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.137] (39.109.140.76) by SG2PR06CA0227.apcprd06.prod.outlook.com (2603:1096:4:68::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Wed, 10 Nov 2021 08:59:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95ee4565-11ee-4b3d-5973-08d9a4286e3a
X-MS-TrafficTypeDiagnostic: MN2PR10MB3982:
X-Microsoft-Antispam-PRVS: <MN2PR10MB398205BACFF4C40E90F98C6DE5939@MN2PR10MB3982.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:153;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wuYXqk2KbC0oejkcm+xPs6PsdXW72r+hvpCNnPCPNs5JHDvZvbNBK6emF4iSyoXAC06YQExpMWpI47l+d6q0ByfcdMzZKxg+JdS7hsJCDhvooch2qulFlmjMtJgSLO6gmgJZwRXSaiQC4XO63QqLCVQg/z4Y0/4XLxGLYv+vb2+eYpFJQxpvhG4wsN0a6Ai5fGKETzuil6DQi+qpERKyMkXkyOeUCoD2GY0d533/M+w/WLTWAMRAhwVzumpxyRVXfsbTUHiTlTbKp5oasP7n/iEw/rPzvGTqujGNSCl3kZBJMcHE2oSqB4S1gL0k1YF5HFKATDwRWCjiK+AdJtILqCDgJaKucPZSOQ5IAHcz94eQwrfrvS0yRHF+N1L8z9/zIXirOAno2RI4Qp8u5ES8o8w0bgxS0WY/ZKI/jbxWHDtXLLK5NcENovF6dYCjuQZMAwSR6OJEpf8HHxgIE++CCE+9yrH03iWak9uDA+nr+LQAf8RW2rqXrPyREC+ulztFdLaNihQXKp45i8AM9+sEHjU9nGaXFsPsBI8mu6M1ApqF1OdhUCt9tabQjSGnPUNt8T3OMbKJNGx3lZp0vM51+5gytvymXNLcGh/diagXKL8dM8qxLuRQeqA2o+Dr8Tq+oLKeoBpFX227tCT46n/JKse9jBeDPhKjUBp5mEIc9kTg4d8WnAwjdcXVscICBwnUbwEuL7tdBOhYxhbeEl+88laqcJdcNq8RU58OVuWkj969+Y/I/ptfbckBxTELHHHt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(186003)(36756003)(2616005)(956004)(2906002)(508600001)(4744005)(5660300002)(38100700002)(8676002)(44832011)(16576012)(6486002)(66476007)(66556008)(316002)(66946007)(83380400001)(53546011)(86362001)(6666004)(31696002)(26005)(31686004)(781001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTRXK3VGQVI2TkZpVWEzbHdUR3VXcGV0OHN3a2lQVVVoWFl0bkJIQlJuemtQ?=
 =?utf-8?B?SzZoUHZNYS9WcWY3WXpPY3ZhSEFOd0VoQ2ttdHF5amJ5OGcrbUduU3VQdno5?=
 =?utf-8?B?NGQ2SW9TYW5KV3VmL1BYemprSXl4TnBieU8xc2ZTT21IUFNYaEQvT015OGha?=
 =?utf-8?B?ZHhEemZkS2RTUXJ4VmVzcW0vUW5Fb2dEVTRBWnZVcWtIWndXekV6bW5RemI2?=
 =?utf-8?B?MFFmTmpONjZQQUpVSHhMNDhMV1NFSFRhTmhtTHMxZW82ZFFMN1phNUt4NlBR?=
 =?utf-8?B?MUxXRjk1eXhDbXNrQldDVzBvTXQ5cFJBTUMrM1BWbjlxRGI3czdnVzRxME9s?=
 =?utf-8?B?dTZ1S2NLYlozUXZSWDVSTkFpTEo4YkxKc01TRzBjeUVQMXdXMjAzclF3dWxl?=
 =?utf-8?B?OFIxRUJEQk8yV0RnSFppdCtHaHI1WjJKYk44b2VnMHRQK2ZEc1FNVUVIb0ND?=
 =?utf-8?B?VVV1UENMSFU1eGJTZk5lOGlsQ24wL0duU25SK2wwWXVDL1pPQlVldE5aT2x0?=
 =?utf-8?B?MEU5eXBWNDFieXlJajJQMVQ2ZThPT3VuR1UrNXQvekRyMEFLV0U3b1RYMUZH?=
 =?utf-8?B?Z0tXM21yVlpMTkhveWNsd2pLcytMVVh1ZDVwVXYzaWE5bmhjbEFvUGpsOSts?=
 =?utf-8?B?R0YxRklWYzA1OEZ4dUVEL29CQ2dJbXh5YkxYbUM5T3dvV2drVm9ZNENxQXlF?=
 =?utf-8?B?d0xTK3JYZTZmaE5kQ3dUYlQrdldlY2Z0ZytqVHIrWi84YnRBMDdoVU9CY0Mz?=
 =?utf-8?B?bUtMR2FGZGpwWW1xRVp3MGtrOHdNNEhZbXpPU2htbm81VXVPc1NlV3krZ0Rn?=
 =?utf-8?B?RW9TZ01MQ0lSQ0J0Z1d0Y24zMEdyVDdjeGUybFV6bWI1UEVZeW9WSWptdmhx?=
 =?utf-8?B?TDludk9yYSt5MTZVQUFRYWFVejNYSkZGdjVjSnQwL0Rsc3I1S0tzVFc1dlAv?=
 =?utf-8?B?cHJFTTgwN3MwYlJGYmhoTGltMWZ4QTQ1TUhYcEs4VGE5SFNEeHFQdGcxWGdy?=
 =?utf-8?B?K2dNZDhCNTAwa3NjanlrTlZHQXYzYkpFN0RxN0V5ZktjUFc0MUpybE91cG8x?=
 =?utf-8?B?TFNUZU13L1pRTHBNbWpGdnVxSkVIaXVqK1I4U2FSR1FXcXVFZjVEQWp3aVVX?=
 =?utf-8?B?b2w0Q2owSUpsRTlZdXkyMTdrVVNXdFlkakVza0VNWURzMEVqVXdrRlIzRldQ?=
 =?utf-8?B?WXVKQnd0aEtENlR1dlpubFBEcUJsbkxiWlpNUmIzK3luUjBMVzd5NnJLUDh4?=
 =?utf-8?B?WURubmtYN2Q4R0pUSTl6OUUyN3NEVytIdi9scGQxQk5tWGhwc1MxMHZNRExV?=
 =?utf-8?B?d25pS3hNOHlURG1aeFJPa3VuMzlZdzNZdThQVzc0SzB5RzhYdXY4UDlDRm5D?=
 =?utf-8?B?T0tzNERZbjhjUG5VY3JCYWtScFFhbU1TZWpRL0ZHZ21FZ3A1aHRjV1RDa3BZ?=
 =?utf-8?B?VkdFZDRzQXpZeC83QnBVQVVLVUVuaVpCTC9CWXFuU01ESWF0TGJlOGVTTEJw?=
 =?utf-8?B?dDE5N052OXBtejBSRk10QjVSMlpqRmhRZm5FNUt6Tm8wdVRyYi8xdmtYWENY?=
 =?utf-8?B?Qm80dDZGU2Rhc3N0WjRHZDNnMXdkYnIzWXVuemxYeTF1bmVmOG1HWlcxT0hV?=
 =?utf-8?B?UWRyODFjeldwaDF3bHJIRnJvdllaNWhLcXJWUjJvWlNJTGxyTkJkK3ZxRVNa?=
 =?utf-8?B?eVRqSnhBKzdjTnlkcUdNSWlWakV3d0NNMHhZUSticjRZaWxYS2ZLbGtIRWtF?=
 =?utf-8?B?TGVDVFh5ejNKeVlvOXNDWjBRM0ltekJ1NGN1VDlJTFlnUjZEMjVlaVBobWNP?=
 =?utf-8?B?UmZsYmYyd2l1dC93SWVnSzJ1aE1mNEtmWEdwZFRYOERZaDc0TDNIQmVpOWpM?=
 =?utf-8?B?dDRSeTNwb3NKbE12eUxhcCszUEFXSzk2MXkyQ0lMTzRwSFE0ckc3eStpQ05R?=
 =?utf-8?B?WmpFT2Z3UzlBU2xtdjYvN3MwVFgyVXVjb0FhcmdML0htZ3lTUjhvZk5wbGda?=
 =?utf-8?B?cWc0SlZXZUJJWjVyL1J5QnB5ZENvTG1VMmh4NHZiRDNjYUpnNHh0OUtnUUR4?=
 =?utf-8?B?dkRzTDA1UjVCM01hRXQ3WGZoS1NSL09zaVVIeVphMTFObmEvNW4wbkd3RmRk?=
 =?utf-8?B?MytzeWpXK2x6MXBwNzRwZUpuMjFvWmNHQ2tFc1M0ZTVQNEZIVk9rN1Zibmpw?=
 =?utf-8?Q?NfLlbTyfD+9SPltcM2umdtw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ee4565-11ee-4b3d-5973-08d9a4286e3a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 08:59:40.6940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uzny59xHDbrI5scGfhZ4/dGNvrTmmPDlSVqR6/73Lp9rTiJa/NDgqff2x1E9EWNeuKXzG7EaELh+u/Ep7jcZww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3982
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10163 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111100048
X-Proofpoint-GUID: ZjwHuSJYYu-8pFn42zXKj7sgtnzr3JMU
X-Proofpoint-ORIG-GUID: ZjwHuSJYYu-8pFn42zXKj7sgtnzr3JMU
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/11/21 2:42 pm, Su Yue wrote:
> Since commit ba8a9d079543 ("Btrfs: delete the entire async bio submission
> framework") removed submit workqueues, the parameter fs_devices is not used
> anymore.
> 
> So remove the parameter, no functional changes.
> 
> Signed-off-by: Su Yue <l@damenly.su>

Looks good

Reviewed-by: Anand Jain <anand.jain@orale.com>


