Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2878456592B
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 17:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbiGDPBR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 11:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbiGDPBQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 11:01:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3C56330;
        Mon,  4 Jul 2022 08:01:15 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 264D24fE001934;
        Mon, 4 Jul 2022 15:01:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=qxwn3801cRla/bMxngxfGKLO+96VfHLuaNEmgeDL6Co=;
 b=DfLzFABIlmKhfP4diR/KHz9TW+R/RpDR3Q/LkIrwFUvYC0aVRZR2rClVenD32f3OXwhk
 9q5O4bC2S0txWTjL+1Dh0VdmYTzhI8ZyUsUL4WPrzEM6U0UI0s0ietlRXvP8cSQfLRtZ
 T9woaU8WD1x9TpkcuknpbTsicsucQkk7cIdVJhdCQcRfv4VtX0lBzhTKtKjgpZAdCfia
 qr/SSzT3QRpmlSxOvwbKKObGgEZm1a3wvGrvYx+x8Redn/3Hv5dR38cT3f57tmEcoQQG
 xhUQb5VTlV8kF1JNO5tikkmGJkhSNDMy+TC9S0QpUGQdTNW5e09zo4E7CFEj9YSRmgMF hg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h2eju3n14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jul 2022 15:01:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 264F1A99002429;
        Mon, 4 Jul 2022 15:01:11 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h2cf1e1y8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jul 2022 15:01:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gofe91SHeOLiEQWhk2UPGMDFEO0xqtGRCj8soCSevKdl9QN+CLtRY6N+VJH0dtgv2xYSHowoW7/eBjoGwhG0Xu7kO8vz/Pm9iHXa/luzUUBXXakl6cl5uM0BGaosICleY8Q8y2cLQ08NZY8HHBy0omqVk46UZVIXADIwHYDmsMM3WAlvLePbS35mMsLpzqvoi1B+lkcRZ0f9WI0Xnq+wYgPf8KsrptqaKaVRsYvsSSWgSspJDcFqLtqZBZ5oFBeUolsQPH3a4jVJEC2i/PnENkccqFbQen4PtljyJ0ffzEAQLVU4NqDlgpVdBZw2gxJSl3JYli43Rs28G14Q7ABbGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxwn3801cRla/bMxngxfGKLO+96VfHLuaNEmgeDL6Co=;
 b=U8OuOC41vBoJ01hjKhBR0F09zUdc3ZhLwd398vJqn9+9pH8o1KIYIBhE3h94ylnrP6ClkqhXD16xN2JvcZGgKKwCefd1ZNNPlTacrn5L+4oN8kdUnkfYJ87IpLTf0El2AJQO8GHwIZV3xya+i8Fut/0a85lVmtl0T9pPaUujADLo0zIOONPgsYZ0Zf9HwgwkpU3kfk/7KVZpvKRQphf0hyOOMPvgk7e0+7pNHJ8Aw+xTQHU+TUfAxiQcU//I0sC2FyFbXktbgVhtSPiSph4PkDA1NSVK6UY4WsHYTxVqhRR7EdoT7lsp9IEOZr9XwaRhh2xutikyW1d/eXJkOSD6OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxwn3801cRla/bMxngxfGKLO+96VfHLuaNEmgeDL6Co=;
 b=oopc2QeYeHW/sURlTirpY0QY8exIWCWy5OMSqiF+y6yNgZjxOdSEAkmOpHXs3ITbHrnfx5dUBKgFEE7iW2sSr8AS+uSCRnX0+AL8HYa++lYFJ1p5QHtr2/gmIMGX/0G21/11GSKFlO/fyWMcVMxK84L+l1libq+Bgmh7lqQkciA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB5313.namprd10.prod.outlook.com (2603:10b6:208:331::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Mon, 4 Jul
 2022 15:01:04 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::957a:9b8f:bb27:2173]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::957a:9b8f:bb27:2173%9]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 15:01:04 +0000
Message-ID: <21e90405-559d-d8ec-1c82-81cfab9819f5@oracle.com>
Date:   Mon, 4 Jul 2022 23:00:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] common: provide generic block error injection helper
To:     Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20220704090346.108134-1-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220704090346.108134-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0232.apcprd06.prod.outlook.com
 (2603:1096:4:ac::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b4d2bae-fa69-4283-3c43-08da5dce03e6
X-MS-TrafficTypeDiagnostic: BLAPR10MB5313:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 08OhV8Mv6c9MVw70JPmFyrZ4GHKhbORE64GDP8oO/07MEKRZtOVvGjH7lcvk2ybJar78mJhXDglAQ5/qDl7HMMIamxOwpQeh9xGYcq8j61B8ouAUmgR3vP9ghYwUz9aG78Yy2+svq27J3XSbMxiOHpK/InZ7pdqhhTmH8nFmHX4wzmIbnmTwdK9RWW8w/pxVZqIrp1sCZDZX3DVd8mhrVRvHkvDy66fwS+78iTlMa7kXaGP+Gz4G/FVvxRb0Tj2R5ixMPOMJaWJFnCR6tplaQ/piNGyQnplaVWKgz4H9etvepvy7NsUmBs5DHuMJJUZAyto+uEUP9wv0LZp4fUwU4gPClSi6q03EcXe8PhjJBowkfb25JxOCfZISWE4UDgGsHBQccUlzEbC4vdZhMYTng0jzSN8H/5r/SZSD4uOaGd3mniecCICBd4q+ybvA34xEhlS0wkEKXgz9SLgTPQeT3V+A9uBCWOCQguzQuaFj+2cqV1N1QVTDDjnDwdwNR19A2omXV+OXGs4iM2VGBl6nJLY/M8X/srp3cWAQa1ep+Wz7fD1Y7i6CdKmo9bRH5JjEI8jnbFymxglUFKYxiv4JAasoipNaj4TD83aF+1Cp0PT4Gozsu9J7pIc5hDhCMQCQihqRR08wDVkdtpOODbwF3WQYewn3nne9+VTw8IpBAGT3OwaeE53hdcMft22WcmtYU+tAFJ9qHQSNjLza2q9BX1nW7cvCuUen2D/NIwufmCnd+J2MokQ1peWmr7W1hvWHTS3D8NPYmYvtJPuKSS2YLKX6u9qoHQB04OMd995ynSG5WHcXMZbmZstjYOhjhl0S8CHYEtN9uiKU+qWwHOa+pGkBjv0gzwCuOMlVELEyZ+A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(39860400002)(376002)(346002)(366004)(86362001)(5660300002)(31696002)(38100700002)(36756003)(186003)(2616005)(83380400001)(8936002)(31686004)(6506007)(8676002)(6486002)(478600001)(6512007)(316002)(53546011)(41300700001)(26005)(66476007)(66946007)(2906002)(44832011)(66556008)(6666004)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2dlQkx2eDl4QjVyRks4TWhzU2hZTEUvZ0c5WXlBQ2RjUGhCM1Y4R3FvSzYw?=
 =?utf-8?B?bzEybEttcHJSN0tQS1dsOE5WR0VpdHpNZEo2cWkvdnlSL0FUSjlwaUw2Qi9Z?=
 =?utf-8?B?YTQ4VVZua1VMNTJZaktJaDhCSE43NVl3THkyckdyaWNXUlZsVWVVZEhLbmYv?=
 =?utf-8?B?RzhHcWl3Y3pqcllkQUtnUmx1NDhDTURoSmtVOWVLbVlQMmhaZ0RoTWROS2Fz?=
 =?utf-8?B?NC9PMjRMK1RmQ2RGdGVQZzBoaFArZlpzUXArWDlJN2xQdDRTRDdzOGtXVDM0?=
 =?utf-8?B?c0JFYnRKOU1OR1VOMnVQb2hxTkI4ak9wRHJDKzRVcDBLT3p5dlBhWUdOb1k2?=
 =?utf-8?B?a1dqSXFWaWtOT1o5ZlNveFRRMmVDTnlFVFVDSzMyakE1TUxDM0t5NERiMlpM?=
 =?utf-8?B?UDEwVGp0dkZFemE2UFIwbEFXUVBHNnMwOTBFUU9CVW5ERlVIUmZRU0xNZlMx?=
 =?utf-8?B?QTd4S1QvVldJMWNMbFRGUk9YS1F4Ymc5WmgwcHQ4YVk3TTJJeVVKQ1VGUWhN?=
 =?utf-8?B?S3IyZHVMNFR1ZFN0OTVQRnpXNDlKcXhhUjNwTU4wYkxPODFjbjFtRDFIL3R2?=
 =?utf-8?B?ZVQ1MktRd3Jwamw4N2M1N21NaE4rZmxxK3FyRklWeVFmdHRPMmNwTGIrcU9l?=
 =?utf-8?B?S0hrNzBwNk1CK0lRMm14R2NuME56N2pYaU1kNXh2dUhWS3NMK29hcXBDMHZX?=
 =?utf-8?B?SUdVU0g3YkFHM3VSRFIrRUx3ZnhtZXhaTUtBdFk5VEswV1VDQkhJUUZmdnpT?=
 =?utf-8?B?ekJuS0p1WldackJUclJ5SzJLUEFobjJML3BhdEYzd3o1b2N1d1NIaU5yWEsy?=
 =?utf-8?B?R01rOTJ1S1Q2dWtITFI3Nkpud1VmODI0MGFjSzRyM3lrMENhK2JvYnRSS0NS?=
 =?utf-8?B?bXFsUDJlNjJRVERxQzJjWnRSa0xoeS9oWUdtakVjd3FjWGxMVlM5OTZhRW9l?=
 =?utf-8?B?UkxhOHJlZkJndmZOeng2Q3EvSnBZOUN6Tm8zZ3ZicDV0eDhpWVVwL29rQmNv?=
 =?utf-8?B?V3BuZm03S0E5aUE4REtkSUwwd2MxTzlEK0t6em5UbkZmVktFSHUxZTZHMlRY?=
 =?utf-8?B?ZGpiWGsyY2VaS3BnZUNuNVFKQXVmRGQ1OG5zQWpaNEkxb1k2a1JiaDlTWno3?=
 =?utf-8?B?QVkrdXhjTWI0dXliSDljbWpBbkQvV2o0Z0Jqckk0Q3VQTzFyeFcyWmdzVmRH?=
 =?utf-8?B?dzVoMU01OHVJU002cWpGUldhSzJHc3BTbTYwYWhLWU5yWFdVWWNkaC9iVUdn?=
 =?utf-8?B?N3N3TllUVjFWSENuNGQyZUZYc0NTRmxIVGFHTkRxMUYzT2JWNmpocG0xbFZC?=
 =?utf-8?B?OGUrckRlczNJNFhnb0NCZWFZNXVwNGFGNFgrSjgvYWxqVUp0MGI3VnZVOUFz?=
 =?utf-8?B?MVdPNWxHWkZTNkRDSG1KQTNuM25SSWlyNlZ1QTVJcHJ2bE1pTkx3WEg3Vmhx?=
 =?utf-8?B?YmxOclNRUzV3eVRSN1FDeWxvR1ZBM2wvWEhpZWhndHdZbXgrbDQzOVQ2NDlZ?=
 =?utf-8?B?eHFjZXZrTHNnd1p1TU1jYkJvWkQxSW45dzRoZFkrRHNCVnVhaFg4MjVEQkZK?=
 =?utf-8?B?MGZJYllSM0ttWWJFOWtwN1FPRG52V2tuY3BLbTlNSUlhOVdxQ3R5U081R2xk?=
 =?utf-8?B?T1VWTGJZbmpndlJzK0NYOFQvaWJsbXpVRHdQMHVzLzZyaGJUVjhMaTVEUDdF?=
 =?utf-8?B?TWpDOUJYQ2tRcGozUk9hNXQwN2c1SHpubzBkRnNDdklFc1RteHRHMldwdlYy?=
 =?utf-8?B?MGZZSmVROTVMRWNvcWxXbHBBVTY2UHlxczVlRUM0ck9YTy9peitLejZVR1BM?=
 =?utf-8?B?anNBM21OdEs2a2NPSXNxcjZjZFJOSTR2MzRoSVBodzNwbEVpZTQ0dlZpd2x6?=
 =?utf-8?B?a25sbEdlRVVLMWFrRXd3N1R5b282VVd2ZnlneWxEeGUxVm1PU3piUFM3M0Zp?=
 =?utf-8?B?ejFKSHhTMzRQc1hnVkZUNGhmYVNTNU9WWG9zMStMNHhOY3cyS1RCWDc1Vkp4?=
 =?utf-8?B?WXduT0pvNlcwU241Z1kxbjFsWXFmQ203eUZDcWNMK0g5NndRYnhtWlR1SE9Y?=
 =?utf-8?B?N1NxMWQ3TXFQUFp6TUtWekRRSWtGWWd3VEFvMGpQcEUzL1JTOTc2ZFpjaHJu?=
 =?utf-8?Q?dapG2sy5He9JgnFTwBOnNzQe6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4d2bae-fa69-4283-3c43-08da5dce03e6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 15:01:03.9838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9qMWLD+g4Ig4PpYAc6fkWHhJqTnOPS3bAiGmlgZfpVgus/r4d982y05gPe+RwKNfX9OSUPU+kq3khqWyXxlo1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5313
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-04_14:2022-06-28,2022-07-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2207040066
X-Proofpoint-GUID: pjqOfCLU9kz1xGVso51eXhbxB4cWBNsC
X-Proofpoint-ORIG-GUID: pjqOfCLU9kz1xGVso51eXhbxB4cWBNsC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 04/07/2022 17:03, Christoph Hellwig wrote:
> Various tests have more or less copy and pasted code to enable and
> disable block layer "fail make request" error injection.  Move that
> to a set of common helpers and use those in the drivers.
> 

> btrfs/150 differened from the other two in a few ways, like selecting
> a not quite as big number to fail all requests in the small critical
> section and clearing a bunch of never set attributes in the failure
> injection configuration, but none of those matter for the test
> execution.

Hm. more below.


> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   common/inject     | 33 +++++++++++++++++++++++++++++++++
>   tests/btrfs/088   | 24 +++++-------------------
>   tests/btrfs/150   | 27 +++++----------------------
>   tests/generic/019 | 44 +++++++++-----------------------------------
>   4 files changed, 52 insertions(+), 76 deletions(-)
> 
> diff --git a/common/inject b/common/inject
> index 6b590804..137ff5fd 100644
> --- a/common/inject
> +++ b/common/inject
> @@ -111,3 +111,36 @@ _scratch_inject_error()
>   		_fail "Cannot inject error ${type} value ${value}."
>   	fi
>   }
> +
> +# enable block error injection globally
> +_enable_fail_make_request()
> +{
> +	echo 100 > $DEBUGFS_MNT/fail_make_request/probability

> +	echo 9999999 > $DEBUGFS_MNT/fail_make_request/times

Instead, can we do
    printf %#x -1  > $DEBUGFS_MNT/fail_make_request/times
(as in the documentation).


<snip>

> @@ -25,24 +26,6 @@ _require_fail_make_request
>   _require_scratch_dev_pool 2
>   _scratch_dev_pool_get 2
>   
> -SYSFS_BDEV=`_sysfs_dev $SCRATCH_DEV`
> -enable_io_failure()
> -{
> -	echo 100 > $DEBUGFS_MNT/fail_make_request/probability
> -	echo 1000 > $DEBUGFS_MNT/fail_make_request/times
> -	echo 0 > $DEBUGFS_MNT/fail_make_request/verbose


> -	echo 1 > $DEBUGFS_MNT/fail_make_request/task-filter
Only extra line in btrfs/150 is the above line (or did I miss any)?
Which is deleted in this patch.

Per 'task-filter' documentation
--------------
- /sys/kernel/debug/fail*/task-filter:

         Format: { 'Y' | 'N' }

         A value of 'N' disables filtering by process (default).
         Any positive value limits failures to only processes indicated by
         /proc/<pid>/make-it-fail==1.
--------------

<snip>

> -	enable_io_failure
> -
> +	_enable_fail_make_request
> +	_start_fail_dev $SCRATCH_DEV
>   	result=$(bash -c "
>   	if [ \$((\$\$ % 2)) == 1 ]; then

>   		echo 1 > /proc/\$\$/make-it-fail

  So this won't work now.

Thanks, Anand
