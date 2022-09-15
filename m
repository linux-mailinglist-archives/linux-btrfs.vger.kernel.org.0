Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85ECF5B9912
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 12:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiIOKr4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 06:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiIOKrw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 06:47:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD517675D
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 03:47:50 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28F7ciKo005373;
        Thu, 15 Sep 2022 10:47:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=dSc3jY+PfCCjnkSOo77B/rmdhu74xPAQ3Z66ulWZ7GY=;
 b=GaRpRNBD4QBSIZXsDdN2eo3D8WjVsx/8Iv6BSEq79iDr7ma2tv6ZRSQn4VgAHDQ0ZOra
 ZoefJFYnalWTWMEjbuDbj9TjPpcSNtDvUFioL9I3OThuRyuHIkVkUSPuVHWKBXvKkMQe
 K8tdQzQJXQD5NpWzjpOsuBy02xl5BRl15m/zv3cwsBCBuiCQ3a6bNUPfRkqatRL/zIWe
 EwPdQr6tRHEk6FZqa47RJP8KlzYrDPGy9NTbWO9/Kcsg63Yg8D0pLAQBvbB/2Wo9nSLE
 5c2XDh363nnTHVt56jofk6hw8aL1/T5JsO3/7QijAITi++W560akZl4AzMzVR8GAcDHK +g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxyccu8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 10:47:48 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28F7qHnG007207;
        Thu, 15 Sep 2022 10:47:47 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jjy5f8jws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 10:47:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/kHS4vnz/kf5Gs8Ip+Tmkr9Y0DzJBBAFwptAz+wwCJzVkyEzK1Atq2vD/Jr7m9V4XgHE2aJqdPNCQu5GMGp0Md/7HN99oGns2OsYR06Ju5N1kwvyxTv+mj/KKCZYoC+GvMABYS4n2SY/TRPBCE/59tUqQLxP0Hh4KGxvi06QIMG0V/jD2n3IesqFvd4/1PbzHQ9L6m9txfqmykORfWjJo3KJxLuXiKElAKrjewNibts+d3IJLsQe8/QopFivBtA8bYgBzCxI1oGASN1XTIFMKs2LTfRbSlxGiWeKLJaqLLxBM51sKkWFLmLBRoltbk+MNsmT3d/q2VXBYSoBg7n3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSc3jY+PfCCjnkSOo77B/rmdhu74xPAQ3Z66ulWZ7GY=;
 b=MYj2jB89VT1AOrVZNOLwZZw62YGNFRsVDDLtkaW54J6dc+ckf8wwZYG0c5ANRieZuL1Qe4WYjZ/pKfMyGLGE8mIK/6EnrtkrgM5q/KQ3CDFGCpji8c1dfgnN5lJ91yOHStSi8G580jwTwjsOHD19CbcNW88lbB/2W0mUWL+dTDQXMOD+13Q2TgaUIvxbOKmevGpzce5GbG7te9ajHry3gIwZ/nGNW03ApQh0LTKMA8S8swIUV0o31EmpZYgMltI1I0qCGINbBMQhUpl/6TQmFadidwbMesYnVKZXEaGG2Guif5p1DVa3pBdpuCaRoH05zzXlfjEUvpAYXxsDl6zf9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSc3jY+PfCCjnkSOo77B/rmdhu74xPAQ3Z66ulWZ7GY=;
 b=nsHdJxFyyuida+6FHHkvcizGxxYwSFFirV8rC582p73sfHBooSQ1z6la8bG6RsdBmdAL9QpRNtDy2KeQax8kDk7VpczEqxMahDviOuNINWDKguUyQz+zkO7UQN3KFTCW5/g6I2ExEWlKZ3YrKHPDAka02MTyhz0vbpy8pLnhedU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6036.namprd10.prod.outlook.com (2603:10b6:510:1fc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.16; Thu, 15 Sep
 2022 10:47:45 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f%5]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 10:47:45 +0000
Message-ID: <d0b58cb7-7173-79bd-e6fe-6899a1168a4f@oracle.com>
Date:   Thu, 15 Sep 2022 18:47:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 09/15] btrfs: move btrfs_csum_ptr to inode.c
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663196541.git.josef@toxicpanda.com>
 <c3cc874650f6266c390ff3d3631b7220001e21ae.1663196541.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <c3cc874650f6266c390ff3d3631b7220001e21ae.1663196541.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: fc9ee23f-f63a-4bc9-9c33-08da9707b90d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kpNRtCo6bBnA9x7zn0YnML3i+bC4TrqRps55hz7+dNt56oUTpwrPt3xLQUxduLVGzvgJShgyr6AU4XA3noqa2A6N9BU6PnNuCovsqoDVIdmf5QeLhmZKp/DpVRtzpzEAzDCPSpwj42mOcEuSBDnCJNAE3aFBa5TU7PjVtk1RoBj0FFsqCvcMA6c2ZolivVc+apRO1ajmlE+fbb3ta72wQuqwIinAGmlfNSfiCiTAbwdP0yms+G/aNhJ8QT+2G71N48pJ+eSwu8FUqXzCgPZSL1YpFNpu0Dj32dnTr4pNJ4/wjjvepUZYFa9VV3n9HDvwMFYwTGktQSCa2gcV4dIrv8k+rzITo9jnfzQ7Ngbey8wH8UvDTJrowGuBrlZwyu6dtSXPwm+w4tzlzYi1ijCxhMxUtPJaXSAdjYMcepWYobmS18DWCK6b8ekOI30ZgEihHOzj4E9vMIMRFcuR+vlhLhjCFfwiFFfqmLA2hcHe1/P7PZqMDwk+3TFtQ6LfZPUsb7obVP57xhH88PLcQ1PSp4+b82nASYvZK7+36nIJIUjAi7b/FABcU8DdeO9QMV+W0YpyICwm+8LlWOMOvo49J4yFJfdQn9fm0bs/tOLDN4iadBHLXp+vkWbFR5IneUk820GvG+sf/E+zJk3KkNgMAXO3CQpkVdD4EJSoqtDKmM4c96rteGQ+evtCVGS8D8xlXNzv7xLj1QJDKAU0UK3aKDeI94Uy8DfdjmcqkLuG5WLERUVxaLplkEB6L3NQsymvzRw/q/dnJlagwjSzvviF/sKnp6XrxXcyw6grB7pAnic=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199015)(478600001)(558084003)(6486002)(8676002)(26005)(8936002)(53546011)(41300700001)(6666004)(2906002)(5660300002)(38100700002)(44832011)(66946007)(36756003)(66476007)(66556008)(31686004)(316002)(31696002)(2616005)(186003)(6506007)(86362001)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0xUSXBWMXkyTXVPaHplTTVLdFluSnlIMDBGZlU0eE9nb3FvZkZyNDllUm9U?=
 =?utf-8?B?dG1zcE9jZmtqOEJhMFhMWU82aXhCK1M3WGtQVmgvVTBUM3dHUU1MU2ptc0do?=
 =?utf-8?B?c0hSYkZCUWdVbzhEM0RBUVQwNUh5VzBTOGVsdjgxck9WM1ZLT1dYYmtHR2lK?=
 =?utf-8?B?TERKRTYxS3JJb1hET3J6N04zWkFEQWJMeGp2dFBjVFRpMnZFeEVrL0QveWh6?=
 =?utf-8?B?WUVkVXY5M2dyZG41Y3I1dit4a1B1OGRTdHNxcitLdVhZcjhwZWJOTUtESTFM?=
 =?utf-8?B?ekpYNFZHQm0rVmhZcUR1VGk1UUNxNDVPQ0o0SGRDRDBHMURhWFBBSytpcHJv?=
 =?utf-8?B?cGFQaVprNWhQMnJ2bnYyT0h5RFZIMTNIMVpJaVRrK2RoUTFiZlByWncwK3lG?=
 =?utf-8?B?Tkp6RGxIb3ZKTm9UamxoQjFZWWdtV095UE03cWk4WDl0VUEwYnRJblZlYkZD?=
 =?utf-8?B?TnpoQzFxTHc5dGRleGcxdXQwU1VrN2J3UEJ3V2dMQnluNkdrNUFzQ2RQTFJ1?=
 =?utf-8?B?ZFJwTWRjV0IxU0kvcXhFUmh6UGVYRTBiYUVRWjlCTGdvWFIvU1RSOEVITFpy?=
 =?utf-8?B?Z2grTU45OGplTWtKUWUzVHRvODBCclRVangrc2JuZG5QZkw0NW8wa1BXZmVq?=
 =?utf-8?B?eStiazZ3bW5Cc0dRdHJueUFlZFpPdHlLR2t6MVowcTBjZXorYzIzcXd0N2l3?=
 =?utf-8?B?SUxIWVZJY1puQWE0VVdIZFpZMWdFRTU0WnBlY1paeVczVzhURVlIQmw0YUZ5?=
 =?utf-8?B?K0kyUjVJdzBaYW1HTkFLRjVzQzNoenl0OXVYdDVKbkxRYkY4TDRpYi9RckV0?=
 =?utf-8?B?Q0N2QjdxT0ZaMlc2Z0FPK0VFN0RsRmt0WVhPcjFwUHdmT3B2bDJDQVJoYlMx?=
 =?utf-8?B?dmQ1TG52dHI5c0Ixa1ZGUWpSVm1USFE2RkJJWnA5T0tnOWZJMi8vRGlyaDBj?=
 =?utf-8?B?WktwTmVTeUpCSmtTa3pWM292dDh4NVhmRzZXalE0QVhyRjBRc1F2aEx4VFNJ?=
 =?utf-8?B?c1ZSODlqK0REejYyM1pndFdnWkJabHEzOHAyNlBYU2lnTndwbzR6YTAvU0ds?=
 =?utf-8?B?SlVvemplRHRRWGExRnBJSkUrSjVEcGhJd29jSnh1Q0lWRkhJZExNMGlSMXdO?=
 =?utf-8?B?M3lwZFVaclUzUFYrOFowRHFIN09yemhvdDI5RmNTZ0Q4Uk1ORlo3aERHRlla?=
 =?utf-8?B?VmJqd3FQS2Q3ZGhFT3VVZlhXUndtQU9CcVkyQjZyc0VIZWNXRFhnb2RwSGtF?=
 =?utf-8?B?VjhHdUFRNytPd2szT2JJZG90aDcrVjBpb1Y2RGJIdTI3SEZnSEJDZnROb0Vv?=
 =?utf-8?B?TXc1dXIza0U5eW5nUVljbnRKTHBobjM4eGRSbDU5ZzZ5SVJXdVE0QXdTQXJR?=
 =?utf-8?B?c3pQbmRPODRTQlFwVkdlQXRaV0hHLy9sWUNwelZiSmV3cHlPSENlTm50WWFV?=
 =?utf-8?B?blFmNWdDMGl3U0NTNlVWNUdzTklPK0p5NUtydFVTeStZdXo0SWhwN0xVd2NX?=
 =?utf-8?B?YTh1R1gwODNYVGVFRnZtcVVSVTAxcUFPSmRXQzRmMzI0Nmd0Nmt4UlZUWnEy?=
 =?utf-8?B?M3BjaWpUbTBQZW8xTWxOREVxbzhMUmVMRERVWXY0WncyRkFIK210MUVtQ3pn?=
 =?utf-8?B?VWdkZ2dNc3l6RitQRC81STN0NmcvM0RCY1JHUlhZUkZTWUJkaWlXeXdsSlhS?=
 =?utf-8?B?aFNNQlBDSjA1LzNsSktnSFR0MzRWVTJTTHZPZXZJdElvVWxOTVBINkx3WFlM?=
 =?utf-8?B?WEhWNnFQR0xsSm5wZzhHUU40cUFVbWVoOVNrMWg4eTcrMWZxWThBUVdJLzRu?=
 =?utf-8?B?dml2dExBMEdnQWtuQVhmTkQ1Tk9neDZwMXRjYXlORHJxM2pORktDcXNHOVNu?=
 =?utf-8?B?ZU11YmNsamlqcFJDa05PelJWWlVidVh2Q0xrTmF2dWorN2xRNGVCZ0VVSFFF?=
 =?utf-8?B?cVdod01zbDkraFFIWDRIcU8veFZwZDRIRTM3WHZaTXN5TXo3TE10V2ttcng5?=
 =?utf-8?B?bnBWZW9mbnNBSnNGOTlsQVhCcWc0VGgxTnU5dVVXeWdCanNLbFdUOEpJdk8y?=
 =?utf-8?B?cnNZZ080QUV0cHhyc0gwMmFyczZXTUM5T3AzQ2NIeHpheVM2Z1pTWG9iNmpV?=
 =?utf-8?Q?j+fosE5TYLXl8NSyqql7KEdis?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9ee23f-f63a-4bc9-9c33-08da9707b90d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 10:47:45.5193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ziqtXWgkYRDvw3SpSe4egrAsukJdG91OAPn8Hl2hm0WoiL+8P62jk7Ov+35QTcrXwJooQBqOa2MXhL8KKsLPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6036
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_06,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209150059
X-Proofpoint-ORIG-GUID: uPcYnLCNnRCuy2MYmyvVHwbd-mznd9Ml
X-Proofpoint-GUID: uPcYnLCNnRCuy2MYmyvVHwbd-mznd9Ml
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/09/2022 07:04, Josef Bacik wrote:
> This helper is only used in inode.c, move it locally to that file
> instead of defining it in ctree.h.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>
