Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414B8564356
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Jul 2022 01:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiGBXx0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 Jul 2022 19:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiGBXxZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 2 Jul 2022 19:53:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A901F1017;
        Sat,  2 Jul 2022 16:53:21 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 262DX97H006215;
        Sat, 2 Jul 2022 23:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : cc : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=UUGk2M8NQ64BNiCRx+TxHQ77aLRXhRZtHdPOo9KUWeI=;
 b=t6BmbGLr809HbXYrVwH1e2iWFGOYkmTE6RiFvdlW1lgsN4/MzmikeLJxchQPJgef+0LR
 1/vmPxwxLRuqAhAhdvcIhHNTx0R+PFHLm27eDxC1jbVSZq/WH1jHIsqa/amfXOlcWiSL
 bAjSzMdbCKViElyWdTzekBNrGR87jg/PMiVc+3GonrWcRqS4GWq+di5NbxyP8qu2GYeS
 BYGiY9/JHZzm94aL1R2pZwshH81IOLogMebj46QwQHiCLApspHWPLs2yanNAF3P7zooL
 xm7Ev5x+9ZXojA4WODsk+TGwP2LqxOd6JTfMw6nKRwNctmySdkGyx7pZhl8l6OYAvjym iQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h2ct290jv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 02 Jul 2022 23:53:18 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 262Nj6uW020111;
        Sat, 2 Jul 2022 23:53:17 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h2cf0pfee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 02 Jul 2022 23:53:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYnsADHrcjGzRBsXYGJJ8vKTFoNVNe2Jct5OWJtra4cZSjsPRzAz+qYwPc9i05v6yeWh5eWJKXcczhd72tthD9kMbrpgWvfWrkH/BwtOfDS3EWzwPKraGrq69G6aCeFdplnB93gAf/VnfjnJd4KZfvcADrTM5qDtyrnDcnaUAFs0B95TMPrPQDkavS0MGW81Qr1i6VV6UpTnm2UHNyWyH+g8juqNmIk7L3l3XYAhwfuKMqwZ4GjZgEoOA4oPunY68EjBPhZTmrOP1yEc5TW9MPytF4crJU1fU4SN14ZCumnywFJ9xDUtmi6OzryHdF5GvkWpe1vI/4EXqFtYQ5qSSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUGk2M8NQ64BNiCRx+TxHQ77aLRXhRZtHdPOo9KUWeI=;
 b=DZMMEoGXeYPq5iVhXnWSejIHTDMdMLokwmfeUibp2OV3fGQFLuHFCWo9AQNfuT7ZFUdAn+HOBcF4InscyYrfnxMUVGXxlKnDUPBKKwU9B8mIoKkQ0nrQWSpuSkB3prdSVBOH9N3OD4LF6vaPm+2At3WesxrDDKonmPoNn9a2HJefxn048KqnR71z81clKXgwsuFPmbYg+KFsoYCE7lXlRfI+3+cPgu9MMum/cjs19VhiYHh5hQFqr2ei3J5WkeOtngvR4Dc1SqPDE7NxmE+EzPsKivQ4/te4E9/IHizsT37Y32YTE7cKnxT3exZWF8XvQP5b3J2MgKrClp+MCl15Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUGk2M8NQ64BNiCRx+TxHQ77aLRXhRZtHdPOo9KUWeI=;
 b=EnJfwWwcfsyo0LQrbfgryxmQDnbdWWUhgdwY3EwGJoOr1F6lhouvrLu2LRAoT4LVcU+q5VFG6SfEEPNQKIFf3O7m4mpSn3Ox5tvNBInuqEB+ndB1x3zcZpafnBrXX/d05joRBGy2btunpPmseZvMApyWGDUbDZl7ScPJar4cQoQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6266.namprd10.prod.outlook.com (2603:10b6:208:3a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.19; Sat, 2 Jul
 2022 23:53:15 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::957a:9b8f:bb27:2173]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::957a:9b8f:bb27:2173%9]) with mapi id 15.20.5395.018; Sat, 2 Jul 2022
 23:53:15 +0000
Message-ID: <fd955cf5-d6cb-b380-68a8-e6c840521589@oracle.com>
Date:   Sun, 3 Jul 2022 07:53:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] btrfs: test raid1 write error handling
To:     Christoph Hellwig <hch@lst.de>
References: <20220702093330.3010115-1-hch@lst.de>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220702093330.3010115-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0230.apcprd06.prod.outlook.com
 (2603:1096:4:ac::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 753796fb-ee23-45c6-fbae-08da5c8607df
X-MS-TrafficTypeDiagnostic: IA1PR10MB6266:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h4kItqp2nASEyZcnzJe4w8+K7ZyRUNhBwlBuBp5AzVtcOSGyKI+cWpxfjVKMEqE+KDO8Jzuvq8TamJ7J3IIbmqOSErz8SFWOjturKsaE5FZ9uTa4EFByeNQTvSK6DUbY4OB1UCqb8gXPfO5XXLzKXJVJW0ldWoDxsOYAxzdRdABApq85LtJQ4KyeIE7dOtiTpJ2hFZNThnUBUYbtTA6Zaczo4GhwjJRQ8FeY+zJ+zygSVT1/6ONSkPHQwRyyHaqYIm7jhc6Wctg1kVpiqjyoHtNEm3435+aJ4URdnrcxV1drbOlym1DKlouTa00vAx8NZKGAlQ5jGxph5ZTTcG87+sGi/I7xtKGxikvEiHnrjUM6B38RSblrynLyg9rLv4UTBRK1FOpZpw8DSe6EFul9J8FEbkcNgMlQ7kQMdK5N9YYHWafH9FufuAZFHKjOJlcVS2WuznweUZZ5HAaXPkKb8XPj1CENVEP/5pNqsxwJftBUhHWUyRhMgnLaw4ImrXi8H3ZjrZjT9LigHhN4tN+1l93hNbecl0BIHAzAPzNwiDk6QQtlZJ+k0ZQavyHyMJzXqP2/VRtd1k9+Msh+gUtMjTQHUq2ezMNI0VF0oeyTGj7eAix6ylsFsUHFk+wXSMqNxNkdbHYNs7MfHTJ1JxGIelphWsw8gSKYn+IAOJBa/bQJpI0/0pHe9uRMxNQejeETPOMQdTlDbU6keldEGPxl8fi4+Wj6nowwoNdhle/PGRiHkZUpjF98Z87seuS1EkHBjmpMIVx2tvYlaMq3E4SFuGdXy77gXOcaCZ2Lkk3OOULk0RbrInvEXmbHz7NwFefT6TN+2RulQQWzZx0k62txkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(396003)(376002)(366004)(346002)(26005)(83380400001)(6512007)(5660300002)(53546011)(478600001)(6486002)(6506007)(8936002)(44832011)(6916009)(186003)(38100700002)(41300700001)(36756003)(86362001)(316002)(2906002)(6666004)(31696002)(66946007)(66476007)(66556008)(8676002)(4326008)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTlxN0hPWHVZMFlsQjJZOE1ZSndpQUkxWG1KNjIzMmVHYXlCQ0NteDJTQXB2?=
 =?utf-8?B?dm1aSGJRaFVXTnBFMkxhQ0FxaFdsd2x0anJWRVZGZERzTWN5d3M3RXB2QUNE?=
 =?utf-8?B?V25VZXNEVkpBVFZ6a3o5alZqK1hsdW9xWlpOY1E0djllZWovbExvTnc4eS9k?=
 =?utf-8?B?aHVSdEZWY2NHMGZlcURmNGhoVkhsSE0zbDI2NUc2V1doTURpckt4cnRYbzZa?=
 =?utf-8?B?Nk96bUhvdU1ZVDVlSHFNU3VtN0NTelVDbVRPZWlaa01hTmNqNDEzeEhjN3BQ?=
 =?utf-8?B?d01lSXFFclNJeExmTHZSMTlTNGx2dGI2VnUrbnlyRE9OdmNGUWhLT1ZxVGZt?=
 =?utf-8?B?WVYyQkEvejA5YmUySG9SZFNOUVNYYU15dXhRallucHpObHQvVVl5YlY2L2tV?=
 =?utf-8?B?UWtHTzJuWk5sVmhwMUZIU0tQTEhpSzZOR0Evd2pqNmcwbFR6VndScDBzMTdP?=
 =?utf-8?B?OENDT1dKSk9aeEU3ZW84aXlRRlZaWU91TGlJbTF3UktnZnBwc2Q1aEJzOVpV?=
 =?utf-8?B?OXh5d0hFdzd0VXB1Vnh0ZW95cmZmU3VYZFN6YzBsckpwK3A0SVFyVGRGOUJ5?=
 =?utf-8?B?SUN3UmZhOE04UlVpN3R6YWNYTFJ2T0VLSW9nWWcvcFVqdkJ0SzdhM3dsTWk3?=
 =?utf-8?B?bWdaYVJsZnZ6L0ZlYytyaEgvRWN1VHF3VkZrMjl5aCtqYVhudE05bVZ2Q1Zi?=
 =?utf-8?B?b3NXYW5xV2t6UWt6cXZ2QkRSYVFEL1VLZU9nc3lwQnNMcnVyaURYVnBNMUwr?=
 =?utf-8?B?Q3JLMlFMNkZyaURYVjNTckRxY2NHUHpPUEpJTmJsSy9hd2ZKVVh6M2QyOW5M?=
 =?utf-8?B?RDI5QVdGSmRpcWJjenBFMEpkY0NQMTZPdmJieUtoVWFUUXhXTzNtVjhFVlJ5?=
 =?utf-8?B?dVgrWFhjL0g3bGpwbzBxS1pCSEhHcDZnM0ZnVjhoSm1pREptR04zS2RPUHEw?=
 =?utf-8?B?QnVINHdmdGJEb1pHNThkRG5WU2NBU2FaRjF3VlZON3ZlbFRhT2UzMFNnWVQ2?=
 =?utf-8?B?ZHdiU0dsdmRGbVRkcmpROFM2R3FZRlZSUVQ1eHBvSG9pR0Fmb3VGYVhmQk1k?=
 =?utf-8?B?ZjFRMUtLQy9lZVdYdWdFNlNCOVo2ZFpTUTUyNkw2OUJlQjJMSzdQU0lCelNt?=
 =?utf-8?B?YlBQT1RxS3grTk44V2JCZ1ljNERaZHBHUytEalV5RXVhY3plb01hRU5tUU4v?=
 =?utf-8?B?aXFERys5K1VhamJhR242YTNrOXhjKy8yb21yTHFoNmhCVW1HelQwN0IyM1pw?=
 =?utf-8?B?alN2S2pPM3lhQUo2b2JscWVZYjVqVUZsMUIwRGFqdnN2SGxvUSt2TDFaTWdD?=
 =?utf-8?B?Y1VXQjFsaGx2c05tZEgvYzVxN0NsUUpJQVhPTTRzam50cSswVGhUY3Z3cmti?=
 =?utf-8?B?MnR5M1FLS1BSc2Voa0hKWjQzMXJZU0pEakZyb0p1U3o4Z3U2cm9VcFlpL2Jh?=
 =?utf-8?B?SW5RYW45eUEweGVCZTRNcCtWT0tpOW5XU0FZUUlFa3MvQlJXdVZ3dHJwdXN0?=
 =?utf-8?B?SVJTQTR5bGdobkZySGY3dXZqUmZRWjZnZmYycEZWZ05iQWg3ZFZCc05qaHF1?=
 =?utf-8?B?bVRra09GeGJPbjQ2cFNhWmRvUlpsUDMvSXc5K2lsTGxRUXp3VkxpYjFvU2g1?=
 =?utf-8?B?OWEwZ3l6akUrdGZRVTJVc1A0OTlzZzZQMUQvTGV5eGYyN0ExVTF0TW1abWF1?=
 =?utf-8?B?THdvQjZFb01oSU5zUUpDaXNqM0ZQTHhoVjR1VlFGaXZFVWp1UzZVd3prcjgy?=
 =?utf-8?B?TWkxUFpvWDNHRWgvV2I5bHJDQjM0aVAyM3ZQc0pSV0gwUEViaVVLK0NvcHR0?=
 =?utf-8?B?OWpOdCsycVpDOG91YTNROCswMlV5MnVzcmVsem41cmVUWTY4T0cwd1VTazNr?=
 =?utf-8?B?NkpobnRwb2pXeUkrMW9vcFZlV2dxSVF6dEhmZjB3TGpHSmRzTGVrZkw3QWZ1?=
 =?utf-8?B?YzBOUkhNWlpkRXJ6TVZyY2NYc2Q1ZnpSWUJQcmU4ZjR3aVhVTzArM1Brekxi?=
 =?utf-8?B?aDhmS21uYjlPbEhtbjVuRENtN3Rzb0R0Q1lhNHpMK2wwaGFjYWd4dGQvcFdL?=
 =?utf-8?B?UjBIRjVrK0MxRnhvZXd4MmZ1OFVxK3paQTNWMndNY0g5UlRhMlNtT3BwMjh4?=
 =?utf-8?Q?bTg9NVj/L01dZnZ9RLCj3ByJf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 753796fb-ee23-45c6-fbae-08da5c8607df
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2022 23:53:15.6483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ArEXbu4x2G/u4E/ZJaEA/382GZjOlhnqR1hWn9EIvrTjXe5CygsHvJrvwM2UgVCi2pU5EWtP78SZImPbBoB46A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6266
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-02_21:2022-06-28,2022-07-02 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2207020107
X-Proofpoint-GUID: sPr8V-UDmvuiwAjIeB077yvCiEY_M_3P
X-Proofpoint-ORIG-GUID: sPr8V-UDmvuiwAjIeB077yvCiEY_M_3P
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02/07/2022 17:33, Christoph Hellwig wrote:
> Test that a write with a single bad mirror works fine but reports errors
> in the error counters, and that a write with two bad mirrors fails.
> 

Thanks for the test case.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

A nit is below.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   tests/btrfs/271     |  78 +++++++
>   tests/btrfs/271.out | 521 ++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 599 insertions(+)
>   create mode 100755 tests/btrfs/271
>   create mode 100644 tests/btrfs/271.out
> 
> diff --git a/tests/btrfs/271 b/tests/btrfs/271
> new file mode 100755
> index 00000000..c21858d1
> --- /dev/null
> +++ b/tests/btrfs/271
> @@ -0,0 +1,78 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Christoph Hellwig.
> +#
> +# FS QA Test btrfs/271
> +#
> +# Test btrfs write error propagation and reporting on the raid1 profile.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick raid
> +
> +. ./common/filter
> +
> +_supported_fs btrfs
> +_require_scratch
> +_require_fail_make_request
> +_require_scratch_dev_pool 2
> +_scratch_dev_pool_get 2
> +
> +enable_io_failure()
> +{
> +	local sysfs_bdev=`_sysfs_dev $1`
> +
> +	echo 1 > $sysfs_bdev/make-it-fail
> +}
> +
> +disable_io_failure()
> +{
> +	local sysfs_bdev=`_sysfs_dev $1`
> +
> +	echo 0 > $sysfs_bdev/make-it-fail
> +}
> +
> +_check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
> +_scratch_pool_mkfs "-d raid1 -b 1G" >> $seqres.full 2>&1
> +
> +_scratch_mount
> +
> +dev2=`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}'`
> +
> +pagesize=$(get_page_size)
> +blocksize=$(_get_block_size $SCRATCH_MNT)
> +sectors_per_page=$(($pagesize / $blocksize))
> +

> +# enable block I/O error injection
> +echo 100 > $DEBUGFS_MNT/fail_make_request/probability

  Probability 100%, so fail all IO.

> +echo 1000 > $DEBUGFS_MNT/fail_make_request/times

  For 1000 commands.

  I hope I got it correct. You may consider adding a comment.

> +echo 0 > $DEBUGFS_MNT/fail_make_request/verbose

> +
> +echo "Step 1: writing with one failing mirror:"
> +enable_io_failure $SCRATCH_DEV
> +$XFS_IO_PROG -f -c "pwrite -W -S 0xaa 0 8K" $SCRATCH_MNT/foobar | _filter_xfs_io
> +disable_io_failure $SCRATCH_DEV
> +
> +errs=$($BTRFS_UTIL_PROG device stats $SCRATCH_DEV | \
> +	$AWK_PROG '/write_io_errs/ { print $2 }')
> +if [ $errs -ne $((4 * $sectors_per_page)) ]; then
> +        _fail "Errors: $errs expected: 4"
> +fi
> +
> +echo "Step 2: verify that the data reads back fine:"
> +$XFS_IO_PROG -c "pread -v 0 8K" $SCRATCH_MNT/foobar | _filter_xfs_io_offset
> +
> +echo "Step 3: writing with two failing mirrors (should fail):"
> +enable_io_failure $SCRATCH_DEV
> +enable_io_failure $dev2
> +$XFS_IO_PROG -f -c "pwrite -W -S 0xbb 0 8K" $SCRATCH_MNT/foobar | _filter_xfs_io
> +disable_io_failure $dev2
> +disable_io_failure $SCRATCH_DEV
> +
> +# disable block I/O error injection
> +echo 0 > $DEBUGFS_MNT/fail_make_request/probability
> +echo 0 > $DEBUGFS_MNT/fail_make_request/times
> +
> +_scratch_dev_pool_put
> +# success, all done
> +status=0
> +exit

