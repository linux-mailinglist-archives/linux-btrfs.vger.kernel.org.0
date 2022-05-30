Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55328537378
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 May 2022 04:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbiE3CEL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 May 2022 22:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiE3CEJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 May 2022 22:04:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78814D621;
        Sun, 29 May 2022 19:04:07 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24T96Shj018415;
        Mon, 30 May 2022 02:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=VCPjWRpL6jU40Ggt5mcVHp5IfeyzEsRpkvcnYCvXlrY=;
 b=fdT1xah01lDktekg5Hde+8umWznkACZqcy1qPsuAdcqJObEZ01GBA9z3Ugdj7XICWUv8
 bG1pvAgMFjWZ5717ZK28qV+rXEkCwoiJbjmS5f6OEwI8/r27FkJKzltdcEoU6kZuWUNq
 IjIfSXYiSf6nMf5gfpbdX+E2dA3WYn0fsSNlcK1YhTYoTse7Qg63bMZWF1XrPKBO6Xl1
 88Rjm1X0bsAVBE8/l31m1L7lJeRT1q14c5hV8kGU6qtO8Sf3+2X+vxyVRKC1ZZ5sDMAN
 Zf2Gdv3iZUXqmvoWNssPyE2lTZpthcvK9KOIZKOfJozFnITgaXMLFPHIZ+3V89A4sJc5 hw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbc4xhu1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 May 2022 02:04:05 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24U21Huk020858;
        Mon, 30 May 2022 02:04:04 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gc8p09tad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 May 2022 02:04:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HaFOxAQx1PlSEtkoi1xZ2qtBc+Pbuq8UutJ/Jg9gVcslDgVQC8ZGmm4bIfAhYeDNY4w7Y5CdH5muUWqzUoMFqaipcpBZOhAdzJdvTVUvWFYyyz198dJPxSIG9CY+Ir0quOUL6TONRlcVBoIMcmvlyyTZETv3DDbiG9psLCWDfip5h7LTKfxNqL0H3N9bPjnX8HT1C+dmClB7Uzrd9gOy/qTR1oLwHf9XbAjn5xAb/qR6/cST5LgioFpIcZTcx6iA1rsfRbIORtJyM7sa8ow4wrBWQLzYXmxL8sL6aqZw6nfh+Ty6YE1gfU+/vlvpEUiPoEIJ2J8GbQX++ENZQkjTEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCPjWRpL6jU40Ggt5mcVHp5IfeyzEsRpkvcnYCvXlrY=;
 b=FJS1p5/s1PoK5LxPBPWuBxg19ezV4+qwoLTTYauOyTa+zotpgtOHXQaqrbhQu0qOX17opDAirBWm0yY22Vco8iduW35JoDfaiPkGZ3WTB6kp22TqAKAOTATM7sSRICNmxfXRZcV8KWbMs/O8Gt0ortpWXqPgZV+JIDBbUHjOtiiOiAmB8npjw+xGZ3/Wf2TKPLJEmF+DjCC5b37QtTnlEiHhJ82vRj2BBbEiUrL7GQoZ0l0X61mKecdsXYbIt3uSui+y6QhVHV3OQBU0eIbiLWAo0AMSMX13v83ezaLSdykxuJ/HW48NKRrlK92xwoJ/4ihrlNHnyy+PTqaQixbT+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCPjWRpL6jU40Ggt5mcVHp5IfeyzEsRpkvcnYCvXlrY=;
 b=TPqy+VdicdVwVwYrqobADvV21cHeHAeac4arSD1FfrwoEkbb2A33ND4+O0Aa3pnjP16o6d397pjpg7ztLW08InnYU8dU8kDzfMgPxWkrz9D813cI2DWdtuW0/j95AweEVENwDoeyyZfXnz/q0WU6K2imKXMn/8Hek2l3XGfrLhw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN6PR10MB1522.namprd10.prod.outlook.com (2603:10b6:404:45::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 02:04:01 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::5cd0:c06e:f0e0:784f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::5cd0:c06e:f0e0:784f%3]) with mapi id 15.20.5293.018; Mon, 30 May 2022
 02:04:00 +0000
Message-ID: <9697108f-f72f-2523-ca16-e4086af97da3@oracle.com>
Date:   Mon, 30 May 2022 07:33:50 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH 10/10] btrfs: test direct I/O read repair with interleaved
 corrupted sectors
To:     Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <20220527081915.2024853-1-hch@lst.de>
 <20220527081915.2024853-11-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220527081915.2024853-11-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0137.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61857c22-7bc9-4d6e-31b4-08da41e0a9f5
X-MS-TrafficTypeDiagnostic: BN6PR10MB1522:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB1522A685B942DB9F13DF0B7CE5DD9@BN6PR10MB1522.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZRi/C1HKyaO74nz15u4XXmzvTGNiVtKjfSDtBMXq0j2WD2hp1VrHsUY7nJ5GeIjJvuZGJE5SqtsW+Ca1FhR//n8215HyLLDH794fxhXpOYVGEl4G7RgFR/nN2QUVetAKnyafTPqZOjIsCM9LdUB16wpuIcxACwRXw/SUoomBKXjrEitmsZsaXAqXuR6C2Ybi6JrUzVrcFFFY4RmYlAJdFB4rpNoHGHkhNDHA2NuczGzA79/ZXhuBZH20uR9iVTab54lyHirf2MmXgt9+Eal6Y8Imw7LWYoUOVhDSNASL4W5dMVaX5Gui84BWsM+Sa6B3mTTaLSkyzKlqusQKngJNH3AT8yW+NAGOHX5YGQkhpUHKRH/P+Jton2Q+Q3RSzZg+pMCym7hJ+DMcd6p18CTSZDdkCHjKtbmfIJK6r0Gujfu+MLBtz+CpZ6KZe+JBy+JiweIYmfnaUDp/p9pDmHEfXmkfLfEoMk69FR+F5syLOwt20gBHtFxgrOES5jNxzO9V+cmdGJZPMUmq5qKRcbG9VkP6GD/VnSEZVzM7D8aXrEYk9pafTW7Gi/IgPmROjfAKH2dW7C4YBGbEOvX511YLM2xfrFWHcLZIbY4EvyuidHBWLYJs01lZCRgnn0c+Rt1ZHlcSrXKjIu3cAG8BqWUnIwJztFQC2lVsYOVUhoSKEthqUv/K567Lc4HO2JnGoTGTpaOqQuioqc/QWY6MD9VFbFVW7LLV0VdfcjcYFQMj1asb8eHnEpeEi9Za0rV8dQAH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:la;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(30864003)(508600001)(6486002)(6512007)(5660300002)(6506007)(31696002)(2616005)(53546011)(8936002)(2906002)(44832011)(31686004)(38100700002)(4326008)(6666004)(8676002)(66946007)(66476007)(66556008)(86362001)(316002)(36756003)(83380400001)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0JIOC9IaGZJZm1vV0pTYXlmd280SGI3R0o5bmNqejJ3SDB4dGJJV0wxcWkw?=
 =?utf-8?B?S1VxQzNUZlp3ejVxVUx1cHJLcGpGVnBIYVdESzRYSGlDU1FOTXJYTUFJaVJQ?=
 =?utf-8?B?ZktJQWg3L29NOFZ2L1lNY2NIYThzVEVDNEh4aStIeVFpZlgxZ3dKRE1XU2NL?=
 =?utf-8?B?MUJ2Y2ZlakhHM2ZHNGhrNUdFWS93WGNtREF0U3JvRUVaa1Roc1hPT01aNUp4?=
 =?utf-8?B?dmJIa1pXUVp0Ri9sa0ltUzhBb3RQK21oT21RVFlzOHJkNXRqdDVaMXlIVk9C?=
 =?utf-8?B?TnIzWFROaUk2dWNJbDI1eHVyQTA1TGw1Zkx3QU1SZmdLMVRxbFRZbjNnY3BW?=
 =?utf-8?B?dEh1dzNjWkE1d0c5WVgxS2tOaTdJbUE5bHlmd2ovR0ptNFBFSVl2cHVYSGJ5?=
 =?utf-8?B?RFNoMWl6Z0FqUUpZU25KWWhVQ3RSMEFHQVNmZ09JQnJaL21TbFkzSk1nalhY?=
 =?utf-8?B?YjZHZ0VyRWNRWXdHazZiSm1pakFKcy9KcGsrSmx0dmZ6WGxMN3duVkU5dTE4?=
 =?utf-8?B?NWJyVUdUWEo0cDJMeVc3T0hoNXJha0lzMTJBWDUrUy9NdkJkQWxuZXduQUFi?=
 =?utf-8?B?YWtFbVJpYS9lTW13a1I0SEJlUFdKMVRua3lheFRaQ1AxMjRkOERVeW5PU3pp?=
 =?utf-8?B?SExJdVVTdElIRDBmSUVOcmFHMzNjbFZHb0drOVhSaktJU1FINWw2TjB4MmV5?=
 =?utf-8?B?N0FMS3hlZ2E5aE9qQk4rc1BrWDNtdkc4c2Z5QVoxMTd3Lzk5Ry84NzlQS2N6?=
 =?utf-8?B?S1h0ZytCMHRiK0RHYm56TWZlamdxcG9SRHR6Uzl1Ky9IQTNpYXUxSHR5YkY1?=
 =?utf-8?B?T1JsaWhLRFI1Nyt0RkNGdDBMc1NwdVg3NWdCYkdCbjcxR1l2WHljdUVsd2Jw?=
 =?utf-8?B?K0ZLbnVhOHAxV2MzU3ZvUEdxbnJNcm93TzlIRWNqQ2diTnBJcE9XTkxDVjlJ?=
 =?utf-8?B?ck5OZDROMEF5ZmxuUDZFT2xHRk4wcXhwU3psQWsrRHV5blpHTXFxQ2lWWlNS?=
 =?utf-8?B?eS9neXFyN05nTXB6djNNdGkrQWM2WURESVU1Z0lkN0NuOFVZWE5OWHVqeTRx?=
 =?utf-8?B?cGlrV2hxSEIvNGxJRFZVWENiTm5rQ3crakFaMU94LzBTWDFjNmRvOEdOYlhU?=
 =?utf-8?B?N2lhbHU1aUJjbm9hMjdIbG52Qi9FMm41NTVYTmhWbXdoZm9Ec0JMK1duV2NU?=
 =?utf-8?B?MWwwdm1FY3VBRDR5dk1DczA4ZmMwRmxtdVc3VWtQVUtHY1JJNEtRNi9uK1hh?=
 =?utf-8?B?RFRYU2lObE9zZ3d0bUx4UU5qQW5YUlBQdng1aEJ2alFHRkx2aEt4azh5dWR6?=
 =?utf-8?B?blNlenhHU3JJakV0QWVsK2RTYjBhQ0UvQTBRVFZ4TFRVWXFqNi9IaTA5RFhX?=
 =?utf-8?B?L2FnaXovc2dXZlpjUzNIWmdKZlBUTjRMQXJSUnFyM3JkaUxEVjVGVnR2MFEw?=
 =?utf-8?B?L1Z0VXZId0xFWjdYV21EalNrbzJnUDhRcWhxNG4wRlQvSVZJUmFVN0JFcnU0?=
 =?utf-8?B?L1lBcFlkaWNIcWd5YlNBc2ZEZ2tXY05pRmZnQ3Bmb0lWSVFPalBRQlFONXNh?=
 =?utf-8?B?dzJxOFh2TENDQ0lpSVdqMGVVZW8vYm0yMmxheVJxWmkyb3dCVFVCWjA4NTBL?=
 =?utf-8?B?dHFZRU9NNXpIc1lZSHkvQ1d3cEtXcTIxNWFBdzZTRUJZN3FNbk9pc01FaXBW?=
 =?utf-8?B?UkRJcThhM04wUzY2WGVQNm9BNjRXeFBIUXhuQmJUZVhCWmlTRHJ0MmNVdlI4?=
 =?utf-8?B?NDgydmVhL3NxQkkxRTVIQlIwUHppM3BXTFFnaXN3OFhBSEhxZm9YZlYwb29m?=
 =?utf-8?B?U05XcE4zQjNOM1RzaVBCY0ZzNjlEMHAweFN3QnExS0xwQlhOUDAyUXgyU2kw?=
 =?utf-8?B?YTFjbVIrbEkwRzhLSVB2Z1FiZWlDakhiYjU5TWtaTDhsSzhNQnpEdG4zZFhK?=
 =?utf-8?B?ekptR3d5ejkweG0rdlBDTHlYRkdtVCtlNVlycVdiNVhkRG4yVlRGVlE4N09y?=
 =?utf-8?B?Mk05V2RlK0xwZS9nY2xTbGQwSzl0a20wNVhLRFRBVFYxMy8zVFdqUXZwWk5v?=
 =?utf-8?B?cFpXa2hTcDJnenV3b1hHMDdzNmlhUk04YnNjM01WajRnNlJCcC9FeEVUcXd4?=
 =?utf-8?B?czE2aDlVYVV6cDFsamtuSXl4eHdyM0JpVWpIdENKWmZnZE9GODBoRmRzQ0Jo?=
 =?utf-8?B?UDZ0N094RjMzWWJyMnZTb1VPZnBJSHE3YUJQLzZyakxEMDg2bmJiUGt2Y3gw?=
 =?utf-8?B?RG1scEc4TzRWNjVhcUZzU0pERFlSODY3eEJ6K3Rkbk9HSG5GSmVPWmpxcU9D?=
 =?utf-8?B?TDM1TzEvL2EzSEkxUC9nK09XMHE2bUtwTEVCZEhEV0JGYkZkeFlGUi9yQkd5?=
 =?utf-8?Q?bCwrBJk6zqWnThOUPOn59zkW2BnLOOR7s7Z97DXWK0nEf?=
X-MS-Exchange-AntiSpam-MessageData-1: LQaSKHO7Zt9Tcm7aKvDPEuH39K/OyzrIbw8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61857c22-7bc9-4d6e-31b4-08da41e0a9f5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 02:04:00.7319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9kKrT/fB7aHI19JGNDYw4T/8Hij1sPiPoXrYro93QGaY2f+WyB8rrNDDQEAUHUSlaSf5Egc12GUbLSjSEcvT6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1522
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-29_07:2022-05-27,2022-05-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205300010
X-Proofpoint-GUID: --F8hIdVuwsdyL_lMS9GEggnqUf_XslD
X-Proofpoint-ORIG-GUID: --F8hIdVuwsdyL_lMS9GEggnqUf_XslD
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM

Reviewed-by: Anand Jain <anand.jain@oracle.com>



On 5/27/22 13:49, Christoph Hellwig wrote:
> Test that repair handles the case where it needs to read from more than
> a single mirror on the raid1c3 profile and needs to take turns over the
> mirrors to recover data for the whole read.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   tests/btrfs/267     |  93 +++++++++++++++++++++++++++++++++++++
>   tests/btrfs/267.out | 109 ++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 202 insertions(+)
>   create mode 100755 tests/btrfs/267
>   create mode 100644 tests/btrfs/267.out
> 
> diff --git a/tests/btrfs/267 b/tests/btrfs/267
> new file mode 100755
> index 00000000..cf19fdc8
> --- /dev/null
> +++ b/tests/btrfs/267
> @@ -0,0 +1,93 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2017 Liu Bo.  All Rights Reserved.
> +# Copyright (c) 2022 Christoph Hellwig.
> +#
> +# FS QA Test 267
> +#
> +# Test that btrfs buffered read repair on a raid1c3 profile can repair
> +# interleaving errors on all mirrors.
> +#
> +
> +. ./common/preamble
> +_begin_fstest auto quick read_repair
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +_supported_fs btrfs
> +_require_scratch_dev_pool 3
> +
> +_require_odirect
> +# Overwriting data is forbidden on a zoned block device
> +_require_non_zoned_device "${SCRATCH_DEV}"
> +
> +_scratch_dev_pool_get 3
> +# step 1, create a raid1 btrfs which contains one 128k file.
> +echo "step 1......mkfs.btrfs"
> +
> +mkfs_opts="-d raid1c3 -b 1G"
> +_scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
> +
> +_scratch_mount
> +
> +$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 256K 0 256K" \
> +	"$SCRATCH_MNT/foobar" | \
> +	_filter_xfs_io_offset
> +
> +# step 2, corrupt 4k in each copy
> +echo "step 2......corrupt file extent"
> +
> +# ensure btrfs-map-logical sees the tree updates
> +sync
> +
> +logical=$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
> +
> +physical1=$(_btrfs_get_physical ${logical} 1)
> +devpath1=$(_btrfs_get_device_path ${logical} 1)
> +
> +physical2=$(_btrfs_get_physical ${logical} 2)
> +devpath2=$(_btrfs_get_device_path ${logical} 2)
> +
> +physical3=$(_btrfs_get_physical ${logical} 3)
> +devpath3=$(_btrfs_get_device_path ${logical} 3)
> +
> +_scratch_unmount
> +
> +$XFS_IO_PROG -d -c "pwrite -S 0xbd -b 64K $physical3 64K" \
> +	$devpath3 > /dev/null
> +
> +$XFS_IO_PROG -d -c "pwrite -S 0xba -b 64K $physical1 128K" \
> +	$devpath1 > /dev/null
> +
> +$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $((physical2 + 65536)) 128K" \
> +	$devpath2 > /dev/null
> +
> +$XFS_IO_PROG -d -c "pwrite -S 0xbc -b 64K $((physical3 + (2 * 65536))) 128K"  \
> +	$devpath3 > /dev/null
> +
> +_scratch_mount
> +
> +# step 3, 128k dio read (this read can repair bad copy)
> +echo "step 3......repair the bad copy"
> +
> +_btrfs_direct_read_on_mirror 0 3 "$SCRATCH_MNT/foobar" 0 256K
> +_btrfs_direct_read_on_mirror 1 3 "$SCRATCH_MNT/foobar" 0 256K
> +_btrfs_direct_read_on_mirror 2 3 "$SCRATCH_MNT/foobar" 0 256K
> +
> +_scratch_unmount
> +
> +echo "step 4......check if the repair worked"
> +$XFS_IO_PROG -d -c "pread -v -b 512 $physical1 512" $devpath1 |\
> +	_filter_xfs_io_offset
> +$XFS_IO_PROG -d -c "pread -v -b 512 $physical2 512" $devpath2 |\
> +	_filter_xfs_io_offset
> +$XFS_IO_PROG -d -c "pread -v -b 512 $physical3 512" $devpath3 |\
> +	_filter_xfs_io_offset
> +
> +_scratch_dev_pool_put
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/267.out b/tests/btrfs/267.out
> new file mode 100644
> index 00000000..2bdd32ea
> --- /dev/null
> +++ b/tests/btrfs/267.out
> @@ -0,0 +1,109 @@
> +QA output created by 267
> +step 1......mkfs.btrfs
> +wrote 262144/262144 bytes
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +step 2......corrupt file extent
> +step 3......repair the bad copy
> +step 4......check if the repair worked
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +read 512/512 bytes
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +read 512/512 bytes
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +read 512/512 bytes
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

