Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07D25F51DE
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Oct 2022 11:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiJEJjn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Oct 2022 05:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiJEJjm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Oct 2022 05:39:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017035FFA
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Oct 2022 02:39:39 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2956hmQS016892;
        Wed, 5 Oct 2022 09:39:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Xda28969axlWHbYUyvf4XYHCF4OFPtfNIn0nBjtG+jA=;
 b=sNWSyslPzkbHTT8Fcj4yUwf89GR2KFo+MKy91hE2sGDxyXopSE8cxLj+BvqbUdamPw2t
 oQ3v34cOahUKO/n2hlY4/cp6tE4M0xyxrC8mTWUzgfKeAu8MYBdSL3A8BIC2t2Llwx9j
 cXQPg24Bh+jA1WQ/lGajlWqKpQVRiRhhz1+kue/2BRryb+uz/W+4HQW4zJK2+gkmGyCn
 9lz/qZ4iAKznVj0oqBU9CAZWW9VjXiMUBP5AJP8L72+bBbdIDqOI854vBsCSUmEEg472
 Rvh+s7tFvxZRdET5mmmRhA6QVsKpfBTV9T6Y4rLVBbjpFOZn2/jFlROQ7ipcfqJVGp2i tg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxdea8tf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Oct 2022 09:39:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2956cHew028271;
        Wed, 5 Oct 2022 09:39:35 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc0b0s86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Oct 2022 09:39:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPtPBzn5BcwzFNblbAXS9of5Y+yfx7JoRYcRDeKDdr+meveNAuePZfjX/qFBhD+3bfDpfjL0j/oyCL32Z0SFubipNzHWuwuAhURsUOFWjJh3Lry87PgX+5TSeKRygKWbvyC7tKawFapCBZt+2p5T8OuTIV+D4fkK2orSFw3JIXgWe6L6vpgTLdKvj60msfwRcJVDjPQ4lGxeOlEWN0B8dsUynek/aTI2ilOBJ8FjUEUksuoIto+v0II14isgig3c+HaWyp+9aUWUXV1dOvu+69L78zDteWL7QuVoGRwqnbeeytuZFQTOhlt/oBxVuBDt4QBwNfshsXEndviK8g+ecw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xda28969axlWHbYUyvf4XYHCF4OFPtfNIn0nBjtG+jA=;
 b=JMV7stdsE+nO/+9JZK4dqphL8LXVrOvSbMzlCOVInlsArIZVrXnFayc73V1YKR7/HW2nN0Clh2eDL6/0hTyID+2JhjOEzph5xsW8yfzlXwZd19E1vXvavHqIclwyMt9TrCFAifcDFZAs212di1NH1/++563aeMV+stTpStgUiRGFUAK0skG0OjDnqfnAZHla97OGn3sWVQ/IRx9ZI91lZmbDwca7VZwer2L7c3QSRtsU5V83rW8xGKnBsrKjt0cWXxLsiVNNAf156uS8k+i9Pywm3si3KElu29+AAQlVGjZbrtqO4HDxqeBG3MmTYk6La1aCnxjhY9JzxExlyqse9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xda28969axlWHbYUyvf4XYHCF4OFPtfNIn0nBjtG+jA=;
 b=rsLQhCIesOe9/fpU/MupE6BbFSXqgTOv1CJAfCTZ7tZzGT2Q9cUynBwRJY9e4pORI9T1SnbPHGQbBimsm5OyXhgV/Ji0JSxGBjltMEDhfBwXSvKBgOFautBmxUG8ttIXkUsK+DSJCOQvNYP7nZMB0lm8X8MnqBHYRXWnSgaIRGk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB5782.namprd10.prod.outlook.com (2603:10b6:806:23f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Wed, 5 Oct
 2022 09:39:32 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2515:220f:4d94:63a7]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2515:220f:4d94:63a7%6]) with mapi id 15.20.5676.028; Wed, 5 Oct 2022
 09:39:32 +0000
Message-ID: <ce51e303-1a66-5dc9-60d0-2aac6d0a52c4@oracle.com>
Date:   Wed, 5 Oct 2022 17:39:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 1/2] btrfs-progs: properly initialized extent generation
 for __btrfs_record_file_extent()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1664869157.git.wqu@suse.com>
 <c06aff30ab435f40f77f56fd8c049a00161cb90c.1664869157.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <c06aff30ab435f40f77f56fd8c049a00161cb90c.1664869157.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0203.apcprd04.prod.outlook.com
 (2603:1096:4:187::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB5782:EE_
X-MS-Office365-Filtering-Correlation-Id: ca70b21b-093e-4c42-463c-08daa6b5817a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oUwnun+DgEHrx7m2+Cku0144/MDKfPVXRRT3OIF37m4ls7P0Yi5kAma9nJXju5W4Tz860WcFuDcwXtpoCwq8VxOIW7vpK3vai3em4EwpctMprfCR433IovzrCVMDXeHitBJLryQL3MDeDuCZ4jfH1fzudBPqUgPt5YwgTtaRefv/y0JJWbU/ToLjXmbhcOhoCnadM1LL80HWNpUpyERPqEcvcobaGLuRF665fDatx73UjxU5vFnd4cdXPimt8HtAEZHFrMAHnpUBwbOtyW7tOyfKHLlQKSnJxUPl3ZHrPmYZLk4PZLkdpbmLp4KTKZGl9eWy2qGd28tJte6mw11xNplAYuqgVvrOY704P90A4e2X8W1SxKLfpsTLAud0pcuXlQFBn6q980I0oQZ4Up6CHp3g3B9elogtzhpeEssybI8kulpvcg6gBrBB9ZTI2LmBbtyoVC42JSo85CfRiB+olfUnMwOiU+WFUAFbQTZiFVfAGxaEfNB2fxkVbgNsjmB/93oqfPVcJkdRjWMP5N6OxOHw61hxImR7aOyIgJM1gkieXna+qS1OZjHdskvjHQmxXq6H7Kn4VgEzpNyqkpjxAD0VU2zkT/fj9KUD0yc3hR0YAOH2V41zMKPO4BzZOlf85PFd3FVtvTywMBBaQRfmHRVzx35q5XAwMixx+eYOOyrIdAxzzVB7JHsSQ8IhjeznxdBHYQcunJct2Du6aNY9q0zrkXHIyBc2OdVyWgXvSljJhzAsKD15aWCHE00ykZqniukRKhxrnkGG4QoJiaObo23s8bh69KLgvB5DJixq1a8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199015)(478600001)(6486002)(86362001)(41300700001)(5660300002)(36756003)(8676002)(66946007)(66476007)(316002)(2906002)(8936002)(44832011)(66556008)(31696002)(2616005)(26005)(6666004)(6512007)(38100700002)(6506007)(186003)(53546011)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGpBVHF2T3drNHVlS1pWL2dLWnRkRmcvRWUrdnlZU3hWVXVRbEJuSURDZE0x?=
 =?utf-8?B?QmdpcDlIaWVhVHR1eE9yWXlnZzRVbmQzcHlYRlF6OEJBNVhXT0Job3dnclVI?=
 =?utf-8?B?WHY4R1RrWVJwTUFBMmNVUXRMREc2aWg0WjlUUDlTYmdEcmFrSzNmcTlmQkdD?=
 =?utf-8?B?VDNkNythN3hCVnZEVVJkaVpYaXp6L1NuZ2NRSVFqTHdQTWtSMHV4MjBLdVB6?=
 =?utf-8?B?U1g3UGVtNmJkZXNSS0U5bUcyM2d4bERFdVcvbHNCTFp5YXNrNGxESGx0Mkc0?=
 =?utf-8?B?MlJiYkVvMzI2TXJpREJIdlpTbTNCMEE1dXBPRVV1cFh4WHZITDFnQmtSVEFs?=
 =?utf-8?B?S1JpcjVFV20zdURzWG1NTDZkSGppa3Z5bUxNL09HQnozV2tsQ3NBdTYwMEli?=
 =?utf-8?B?NVY0eTBnckMzQ2VMMFZwRGQ4NUhMUXZoNFk4VERZZlRJenlYejhYMWpIQnVB?=
 =?utf-8?B?UkhPUGQ3bklIR253bStNaElnTTNlTTc0cWJaYVUyVzhxV2Nwdjh5ckZKRlJs?=
 =?utf-8?B?VmEwVnJJNHBIWU9ZeVJVRVQ2RDVvUUlobjBxZ3c0MEl2TUJ4TWttQ2gvelFV?=
 =?utf-8?B?SWM2QVlZMXhNTVZneTBDNHRYV2hkY3o4eFdaelhmSzQ4akEzOTRoRjRhbHds?=
 =?utf-8?B?U3BsdVo2WWE4VTdteHVFYktaZlo2cjRwQUp6ck96alBOekpyaGM1VkZZZjFx?=
 =?utf-8?B?all5SGZJNWZXR2lnN1loTEppcmlBdEdOUm9oMDRSNVJ4RVJXL1NlaTJpRmFq?=
 =?utf-8?B?YWJCN2dVbUlYK09NRVFKWTVWS3htd1BUc054VzY4TUFHK1lIK2tlamxsSVJ3?=
 =?utf-8?B?YkIxYWUzVGlaNm9IeDgxMHBJeXc0VVdIdFlCUWFOV1hiRFZFTlJvbkpuT0ZQ?=
 =?utf-8?B?Y2w5WWFIcThZQnU5dXhscG1yamF3b3hYU1pnRjRWRHF5S3VxdVVpdXUzVy9T?=
 =?utf-8?B?cFYwRS9XU1lNT0lla3g5K2hkRlJoTFUrem55bGdyNytXVHErLzFRdCtWZmhN?=
 =?utf-8?B?ZlF3QWVFWldnQUQ1bjYvdC83dE9KTHN2eHpnM0tRS1RhbmdqNmViTng4aGpu?=
 =?utf-8?B?Mll5aVBvN3B5NnVuRFFFNGZmbkM4ZDlSTGl3amRBUU9NK3pISUhpekVTR3Av?=
 =?utf-8?B?N2lEYmlodnpVZ0ZXZk1OZk0vSnZpcFVsalBiSGM4RkNDQ2VSNWRhYmFib0s3?=
 =?utf-8?B?dml4VU93NHJPbXQxNnJWTjZFelhhckdHeS9pV014akc4QWovN3N2WVNScDMv?=
 =?utf-8?B?ZGlUL3dTNS9uY090cU5najBFQklnRGRMK0VwMUFSRkI2VzNrWlp5SlQ0em5W?=
 =?utf-8?B?V0FFWlFvVncxWFIxZkxqbjE4eWxqWFNTc2dLZlpMSmhHY2lGazFtTHhlSE5J?=
 =?utf-8?B?YWIxWUtiOHAzQ0ZMTi9aVXF6TVM4UkVoU043ZHl3QlRZeEJKT1VDSGR5RHVM?=
 =?utf-8?B?U2xKSTNQZEYxcjJia2MzeEJQS25MWkMwMGNZZjFLTldkOFQrNFlKeVpqbG5w?=
 =?utf-8?B?OXliU25sUVNJOGRXT0RoZHROSDd0QVNuMTVGZnhObkt4M1ZlYnJhMGt0c1ZD?=
 =?utf-8?B?cUJPeHl4aUROMFBJWC9GaGkrZE8wN2JrL1NBWkNhTDdMVWRCVUlXTHE5MElC?=
 =?utf-8?B?dlhqVUpzcnJIQnBSbThHMWpvYlliV1BqWjdGKzhma094L1hSdm5CMEd2OXpz?=
 =?utf-8?B?L3oxR2ZwUXV1eDJLaW5uV0xmcFFxd1JlZkxWNkFiM1h3bEFNcEVRSmJIZXlz?=
 =?utf-8?B?a2ZpQTM4ZWJVSGZJcnNaR1VKWFl0UGxtSUdGZXdRdXM2RjdTUEd4MFNWYXhp?=
 =?utf-8?B?QnBhNytRTG1ONjdVTHJoU0M4b2Vnc1RPOG9CZGdVMllKWTZTRUM2T0dLZmYy?=
 =?utf-8?B?ZDQ2ODhhSnQxb0tqTWw3VFNYeUEvMlZYdXAvUXNyMEMxdEltUnJ2cy8wMXIy?=
 =?utf-8?B?WUZOL1VVNG9TY1ViMmphNDI3ZTJMbi9GVVpHWUVodTQ5ejk2TkZ6RE90YnBR?=
 =?utf-8?B?QlJDY2gvV2FlaEJXT2FzZHNrYjg5VVVBNUwyS2IzdnVNMkx3RG4vTHE2NEs5?=
 =?utf-8?B?RXZRdUtKanBPNTFrTGFRcHJ0Z0gyOXlCRHFCTndnNWZWeEVXcC9GN1NyalJt?=
 =?utf-8?Q?c2K60XSlRM5vx/xjtV/EQ/Mjs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TKid8CwldJr+WI+y/zSSMuqR6RvaPjOZ6CS9VFkuB/IKpuMc1/7n8jUH82adXG0UnDiEzGkRFl/rKkLurUeVeU1KtAAnjESK4p2t2MhLt3wxXzM8QuSv8RlP6ub+yQHok5eVkZplvJ5N2iitQkmjN1xTO5xRQBKqcg3vZyUyFTK9q/4pBc0BXrJ0KgmqMhQVd9Tif+teKe067je5bbBzDhWMRwGtxVFHbA8NF25/Uqj1dWQ9zqWcqC3fhsIKIUHmIyV9foXavKUxDlXbSIx6/IhU2TSGfvRKg/1aEFSTu0fKR/GKU/my2JBegV4DZHZBA8is2D8EoqurtaPOJiIFft3PIDKcSSg0PUUc7kOhPPc5ARPBwXobxYn4BU8QWbCT1V8xeJu19/Ly+vXrPaz0s8wJDkOFvWk83psmKveRCshSqwyFr9hsxTqO8IcUCsGG6vjX02v7lp7ssNUxsiMggM0NHLooKkYaU5rLg85+0FkC52CfDDpYvvvAtQHAN6sCzFQEKtMEzGk1mQJQgqm23tBdEPH3+tAcZo1l6CnDYVWkX9e1nqgGivoYCdlzpYL3x5Jz0P1Lj4rsw07q4DV02nKSwS0PNnxUXfXZDCaMLw5UHg0koN9rbItF6ASJObV4hnlJcS3v+FbnjNYKFWpMSAHHtZSLbvWjTQmEPfGQi1/rj36sIQBw70VENLIPVByZoy3TM0sAFZKc94pRUOr2WrpI+4xzvFpsKalyeamkej/lBEj07r0ZfU0WpsJhup3tLI2LvplZhUaisCdpuAi4iNRFbtDUY1UyT/SujmCJSuc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca70b21b-093e-4c42-463c-08daa6b5817a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 09:39:32.3548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o1lFBMqRRyso0cwtF187ZAv+70Dsf8jSWH4Uf9cxiFrFc6V34SGRZNFU4Mc80ufUXAzwIYgAxx4FeTZYB6sS3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5782
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_01,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210050060
X-Proofpoint-GUID: hgnhArRs94whxnYk3ar2IFP9pI2dmzeL
X-Proofpoint-ORIG-GUID: hgnhArRs94whxnYk3ar2IFP9pI2dmzeL
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 04/10/2022 15:43, Qu Wenruo wrote:
> [BUG]
> When using mkfs.btrfs --rootdir option, the data extents generated will
> has 0 as their generation in extent tree:
> 
>    # mkdir /tmp/rootdir
>    # xfs_io -f -c "pwrite 0 16k" /tmp/rootdir

This should be:

  # xfs_io -f -c "pwrite 0 16k" /tmp/rootdir/foobar


>    # mkfs.btrfs -f --rootdir /tmp/rootdir $dev
>    # btrfs ins dump-tree -t extent $dev
>    btrfs-progs v5.19.1
>    extent tree key (EXTENT_TREE ROOT_ITEM 0)
>    leaf 30474240 items 13 free space 15536 generation 7 owner EXTENT_TREE
>    leaf 30474240 flags 0x1(WRITTEN) backref revision 1
>    fs uuid c1f05988-49f9-4dd4-8489-b90d60f522ee
>    chunk uuid 40f81603-fe75-4f58-aa9e-e74e28df8523
> 	item 0 key (13631488 EXTENT_ITEM 16384) itemoff 16230 itemsize 53
> 		refs 1 gen 0 flags DATA <<< Generation is 0
>    ...
> 
> [CAUSE]
> In __btrfs_record_file_extent() we just set the extent generation to 0.
> 
> [FIX]
> Use trans->transid to properly fill extent generation.
> 
> Now after mkfs, the first data extent backref looks like this:
> 
> 	item 0 key (13631488 EXTENT_ITEM 16384) itemoff 16230 itemsize 53
> 		refs 1 gen 7 flags DATA
>          ...
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>


> ---
>   kernel-shared/extent-tree.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
> index 3a058a8698ee..92d5c521abe8 100644
> --- a/kernel-shared/extent-tree.c
> +++ b/kernel-shared/extent-tree.c
> @@ -3582,7 +3582,7 @@ static int __btrfs_record_file_extent(struct btrfs_trans_handle *trans,
>   					    struct btrfs_extent_item);
>   
>   			btrfs_set_extent_refs(leaf, ei, 0);
> -			btrfs_set_extent_generation(leaf, ei, 0);
> +			btrfs_set_extent_generation(leaf, ei, trans->transid);
>   			btrfs_set_extent_flags(leaf, ei,
>   					       BTRFS_EXTENT_FLAG_DATA);
>   			btrfs_mark_buffer_dirty(leaf);

