Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF96652D89
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Dec 2022 08:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbiLUH4V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Dec 2022 02:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbiLUH4U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Dec 2022 02:56:20 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE27C3B3
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Dec 2022 23:56:18 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BL0j60q005823;
        Wed, 21 Dec 2022 07:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=RkIiD2x1ukL0Ih4PEFfrJYFOJnnQajwmhHxBOr6IE4M=;
 b=s2yd9o/beJyFmbLf9Cqlwb8rYmNHAQ0ikqwPpGzp0yFm9wkR+kjZvkbayxqY0/rU3g/N
 SwAxsavzMwvXYqBJt1PrOx6DX06V750NivFZ02+lYkioJN27kGAeCuzdXFfWlHaqWzT2
 2pHXlz4Z2BO6Dx+1Z35FvPbkdCv2Zs1n9/XNYu5LDLF7Wtxr7KfipkHAhA18X1efx7rs
 mebLHtpGV1vs5XcufPcskeVd0uvXe5uLXrJ9Ny0yqwMSMMcITIDcBP8o47gD5PpSliJm
 FvVeER4nOogwvUpGOwxI6xJ/vyYbEGnEZYt9oFN3dvNVLhbw1QzY8elKhz5nkgbW3HvE +w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tngcnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Dec 2022 07:56:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BL5w2I5004709;
        Wed, 21 Dec 2022 07:56:13 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mh47cjrgr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Dec 2022 07:56:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCcGN9GFjvfE8uRgjo16LYxCAPYytrRshhNyd92e0j2bmJk3yJ6zCpaAFKYsUFWschV14E662u8ApUegPHOQNMyuM7nPNga2LcQ4FuNMBGdzbUWs3LMt2pXaP7X7vFhXFtKLvyR2XJnr58skWjZo0m9XBsy8/ERGacitGr1ZQU6soug8w3lrsq30Mibz0pGhfEKWA3d9G/XKni0ZuPK1biaun7S54XdYEjOaqcdAzq75RS64KsPX7HWCyeFOXB9oisY+7hg1F4nQRV3x2lPCvf3Zr27i3ZN7MH+Qk1AzMnSqYN4oq9israq37Kc4IPsPbJcdhnSBNOyV7zpgzly+sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkIiD2x1ukL0Ih4PEFfrJYFOJnnQajwmhHxBOr6IE4M=;
 b=mUwYsRcaJkrYOPTG3fmEVUn37tMl9Uz1KX7yBiaHxNP++Sr6q9urbYCoWQn8Bv5vAED6y7bPwhVuh/0USEKgjEZJu3Zc89d2dAXh0zJ0ta3uQWpZmR3veyMtNPhTutuG54ZYJXOfV3ITtVS/+rbe2cz2hU1jiry31FgQP2HJMQ86hvu8rp+kKweD8ZfZsBqixpeNBoJVaBS+25INUVCLgyuoUhfKIwR66WiIrfAOP57n9HkI5k3e99NrWc2zeWPKKSUj5nK6SdmpMM0oAMZIwWZfPT3oKAIRigvCLjfR1QHisH1SRiI2oafrN2kqDBwXEPcdqyyhzZFz3S6g9PPuMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkIiD2x1ukL0Ih4PEFfrJYFOJnnQajwmhHxBOr6IE4M=;
 b=eZgBR3WIF3kBq0RXnbl4nEbtbeaAAWdYidNDGmT9rbwBoEciSyTVtMwZYm65L0TuUbQVR6sx9Cis7cWSEh5QKvq4rNgMEusExqe2VVVux32o8wR808CxRHFB6etIRdgG46yKRd00dKE21xCtJuBpfUItoCWtQ5Mfk8IU232nksA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4808.namprd10.prod.outlook.com (2603:10b6:510:35::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 07:56:11 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::797d:8a0a:fc5c:7e65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::797d:8a0a:fc5c:7e65%8]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 07:56:11 +0000
Message-ID: <aba9f83d-76f2-48fe-1819-bc405cb7efdc@oracle.com>
Date:   Wed, 21 Dec 2022 15:56:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH] btrfs: fix compat_ro checks against remount
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Chung-Chiang Cheng <shepjeng@gmail.com>
References: <8ab95b9b1469cf773928e720a9d787316dfb44bc.1671577140.git.wqu@suse.com>
In-Reply-To: <8ab95b9b1469cf773928e720a9d787316dfb44bc.1671577140.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4808:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ed7019c-9408-4ce6-31e4-08dae328d32d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tbbxZ2sEp+LO9ujbtnVU9nA8NWhzO0W++L+KYM3xTfJ6QUbbe+nsXxah8jNGGol6cLVM0bIQmNHqgqhPoXdSTRzuOjt0KiSzY+fh+zkW9CVbRokKE9Di5L9NP9dWz07tGfpoOGVt2bfEd/g1pXnSsk92us38tWq7+TBohCSgV+DNExiznUZiDhYVJIKg3KB0kbV0uDpO5yJTciRC7soYfUXRmuAJmo1d6dIp1iMJvHOB5Y7fIGbGXW/sRBatgG645effPBfyC4gVxCk7PonmyW+B3aMXSeiyoson2Wrh589N0MY+D756xP1+tJV74CUemzjBqATI4VJ5x9Hj/YWmeyOvoD8Gy8camCi40OY69i+wevPfSStZ2e5dpRok60NYf6Z8EeF1nWXpfldsz7gNrsq6Q+1kay6O+Esh0Fucw3knWF3RiSWPRNMgjQhEzPzFw+STeW9mf5q7x5eWXWAm9t4Gzyz2pJE1AKaAfYApdUTuTMJDZnkRNJ4ni4ytL7tDwQJxqcYLNYG/iVQk/C+qmNfls7P9UMxSI9e/BgeV/fP77rxuvKh++4ubyhbiYnQuMbvpH+sLQuCQgbOctlCMBK7GeR04LZodSrH/22Bp6iMWcWt2hYszNBp5tSLsPldbw5t414rXD7umw+i4epYx2nroqcX584aHkbEf0Runq0xC6cJxruFn3uXxbF/h9q0m008KMVGzb+24sE65dpwREggwmukXaan+c+GviLuKn7c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199015)(41300700001)(66476007)(8936002)(5660300002)(8676002)(4326008)(86362001)(2906002)(66946007)(31696002)(44832011)(316002)(66556008)(31686004)(2616005)(38100700002)(83380400001)(186003)(6512007)(6666004)(6506007)(478600001)(6486002)(26005)(53546011)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0s5dHN2dG9sNklKM09EQ0g1TEc4V0E4L0RMOVNORGRKYmF0djh5SEhPV1E0?=
 =?utf-8?B?dFpsb2lLSTkveDNwR081azg3b2dqQWNCQ1VIZ09TczNSK0M0RTk4NGdpWFN2?=
 =?utf-8?B?UDBxZno1TU9odnh3S3QzRWR1YUxFZEJvVEp1eDFvS3JLME9rUVlmeGhXcitn?=
 =?utf-8?B?UVVKYjBqbUJCUHJ0Sk9mQ1kzQ1p5T0d5Mi9mSW1DT0t6dWV5NWxzT1BVSmNU?=
 =?utf-8?B?aVlsOFZSSDNuTkwzWCtGVTdpdXA4ODE3MjhjbmtUYWVLWE1CQmFPTHNsNHB3?=
 =?utf-8?B?eDJGbjN1R0hxNy9xc2FnMUVyOUhac2dic3k4Szl2ZlJ4SjhZbHgyUjRtR3NX?=
 =?utf-8?B?aE9Rc0Nvc2RFN2xzUmhNZDAvRlBkOHovak03LzFvdW9IN29pVW5lTjZjS2Jn?=
 =?utf-8?B?TTFnRGFZVmZxbXNlVXFLY3plZXBTcmZIV2xaU0dTbENiOS9rQ0JBbVUvKy8z?=
 =?utf-8?B?NlZCMlBxUUxudlozT1RQZ1VZMVhzVENSUVZHSitQdXlmZGFOam9POG1UTHBX?=
 =?utf-8?B?OERSTTNXdkdlVGp3ZnFxRDFJekJudCt5MkpnRStQeTNEeFFXL2lYcHNjTVcx?=
 =?utf-8?B?YjFSSVRzQ3R2ZmFkaVRETml3OEkvUUQxMkNGNkhDVWoxZnBpMWp3REs4c3Jv?=
 =?utf-8?B?OWQzdkVmeVZZRW5xMks1S0IvMFJDSDQwQzhRUElZem95ME1jRmQvcGc5aE13?=
 =?utf-8?B?Z1g4NmpjYVl0Yk5sMjVPZHVHRWVKUUVaMGNJaWtDODA1VmlOaGRHVUpVQmVw?=
 =?utf-8?B?Q3ZlZndFdXZhTmxOa0RjTjhXMExkTnU4SEpvNjJUV2hUaEs1N2dFMjZPUnlx?=
 =?utf-8?B?bVYyTzIwM1hBQVV4dHdoWXhjdkVQVHFvUjlGMUM5c2FncmRvS1MwUkx4ZGdU?=
 =?utf-8?B?TTVuY0NucE40T0R4S3IvRVQ3UzhZU3hDVUIwUXZhOFJhRG8xN0dSNUJQUWF0?=
 =?utf-8?B?ZjhCOFI3aGZFVXVMcXF3djVCc2o3WFlSVUVGYnFoVGl0cWJwQjJWckN1ZXBM?=
 =?utf-8?B?ejd2KytWZVJlVnIwa0FwWmt4RXVxa1dqL2VkQUJWS0tNa1k2QW1jeVhleWox?=
 =?utf-8?B?V2dwcW9CVUp1c3FjSmtKa3R3QkRRdXBuT0ZEREljSzYvTmlMdFZTM1RkNDlz?=
 =?utf-8?B?bXAxcHpLTFJBanVBM0hCYmIrUFE3TlJVa1RIdEVPOXFRSENmSEM1Q0dlNyt0?=
 =?utf-8?B?b0JjeTJ6VDF0WFF0aEg4MS9TL0pFdy9lU1Njc2JuUlcyMG1raXdsOFAzZDFm?=
 =?utf-8?B?S2l0S25oRmgvTVBycFhESVBadmFnemNabmlnRHRxUlhyQ1E1MklaUVhubE95?=
 =?utf-8?B?UXNzZmZkV3pnQzgxV2ZpVDRsakY3ZVIrdFAwOWo4V2JZUDNyT2RuaUhVb0Ro?=
 =?utf-8?B?ems0THVkNWFINWRWd1dad0hxZlBhSGJQN1lFdEU3ZmZmNEYrNjJibDhvSUlV?=
 =?utf-8?B?elQ1czFkZUlnYkZlektsaHpiTW9nSHFiMXpyb09BSVJNQjN4TUlmdzRIdkFM?=
 =?utf-8?B?a3J4Q0VrS3lJbVoyLzl0NXUvOTJROC9XcHhZQzgzNkNHTzlxajVPOTQ5K3pp?=
 =?utf-8?B?L0ovVWFYYkN3Z3pWYnZ2OXhLcUNWYzRoTzQ4SmJXU2FmMzQxUmRGZE9XKzdT?=
 =?utf-8?B?eEZWaG8rNjdTQVRpQjY0R21IajhyMnY1TmNSVWRsRitSb3JtNGt3TVhlN1Nt?=
 =?utf-8?B?eFV4eTRnYlBRekJtNU9Ob2FpN2gzZjEzWEtSMXEwcGZiN0dXVkJuQzJEaFRr?=
 =?utf-8?B?TUNFSlZndjYxQW96SXdyV3hZQ2c4S2diSjRtYnFYdlY0eXQ2WW1melN4dnph?=
 =?utf-8?B?cmQ3aFJPTHRDYjlIc3ZBZWVFd0kySjByYVRuYWNlMCtnRGZodkZleUZYVzVj?=
 =?utf-8?B?aC9NbzFjcm9ialFqaDdIUU5vUEFUNjZTamZtcm9CNkpIdDZmWGt1RjUzUzNP?=
 =?utf-8?B?OE95Sjl3YVV0YTFXWGJNRlM4VW9iMWZzQkFxblI0RERHZFgxcFJFekFiekpS?=
 =?utf-8?B?eDBvSllRajJKSFhQNFJ5NWVxb3RGV0pUU0VYL2NDRmp4QWxrTy9adm1qcHo4?=
 =?utf-8?B?cjFZUWNMTlNhaEpYeloxSGpVRVNjNlZPTkNWSU8zU2tQVlc4aEVsSnVsWGpJ?=
 =?utf-8?Q?s8V3J8Tl6yBONt/YTRAPPrpjt?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed7019c-9408-4ce6-31e4-08dae328d32d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 07:56:11.0309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4rPxxCydxa4uT3l8nXDYv7wF36IZkKSAWY6fDP2YY5jbqcncE6AoHt1xCAAyZRV856GdJQ3CL8knZIs9Eyfcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4808
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_03,2022-12-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212210060
X-Proofpoint-ORIG-GUID: IF3PuM3qgLXlVAkybS7FKyQJ4Xm0OR1H
X-Proofpoint-GUID: IF3PuM3qgLXlVAkybS7FKyQJ4Xm0OR1H
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/21/22 07:16, Qu Wenruo wrote:
> [BUG]
> Even with commit 81d5d61454c3 ("btrfs: enhance unsupported compat RO
> flags handling"), btrfs can still mount a fs with unsupported compat_ro
> flags read-only, then remount it RW:
> 
>    # btrfs ins dump-super /dev/loop0 | grep compat_ro_flags -A 3
>    compat_ro_flags		0x403
> 			( FREE_SPACE_TREE |
> 			  FREE_SPACE_TREE_VALID |
> 			  unknown flag: 0x400 )


I am trying to understand how the value 'unknown flag: 0x400' was
obtained for the 'compat_ro_flags' variable. A crafted 'sb'?


> 
>    # mount /dev/loop0 /mnt/btrfs
>    mount: /mnt/btrfs: wrong fs type, bad option, bad superblock on /dev/loop0, missing codepage or helper program, or other error.
>           dmesg(1) may have more information after failed mount system call.
>    ^^^ RW mount failed as expected ^^^
> 
>    # dmesg -t | tail -n5
>    loop0: detected capacity change from 0 to 1048576
>    BTRFS: device fsid cb5b82f5-0fdd-4d81-9b4b-78533c324afa devid 1 transid 7 /dev/loop0 scanned by mount (1146)
>    BTRFS info (device loop0): using crc32c (crc32c-intel) checksum algorithm
>    BTRFS info (device loop0): using free space tree
>    BTRFS error (device loop0): cannot mount read-write because of unknown compat_ro features (0x403)
>    BTRFS error (device loop0): open_ctree failed
> 
>    # mount /dev/loop0 -o ro /mnt/btrfs
>    # mount -o remount,rw /mnt/btrfs
>    ^^^ RW remount succeeded unexpectedly ^^^
> 
> [CAUSE]
> Currently we use btrfs_check_features() to check compat_ro flags against
> our current moount flags.
> 
> That function get reused between open_ctree() and btrfs_remount().
> 
> But for btrfs_remount(), the super block we passed in still has the old
> mount flags, thus btrfs_check_features() still believes we're mounting
> read-only.
> 
> [FIX]
> Introduce a new argument, *new_flags, to indicate the new mount flags.
> That argument can be NULL for the open_ctree() call site.
> 
> With that new argument, call site at btrfs_remount() can properly pass
> the new super flags, and we can reject the RW remount correctly.
> 
> Reported-by: Chung-Chiang Cheng <shepjeng@gmail.com>
> Fixes: 81d5d61454c3 ("btrfs: enhance unsupported compat RO flags handling")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/disk-io.c | 9 ++++++---
>   fs/btrfs/disk-io.h | 3 ++-
>   fs/btrfs/super.c   | 2 +-
>   3 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 0888d484df80..210363db3e2d 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3391,12 +3391,15 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
>    * (space cache related) can modify on-disk format like free space tree and
>    * screw up certain feature dependencies.
>    */
> -int btrfs_check_features(struct btrfs_fs_info *fs_info, struct super_block *sb)
> +int btrfs_check_features(struct btrfs_fs_info *fs_info, struct super_block *sb,
> +			 int *new_flags)
>   {
>   	struct btrfs_super_block *disk_super = fs_info->super_copy;
>   	u64 incompat = btrfs_super_incompat_flags(disk_super);
>   	const u64 compat_ro = btrfs_super_compat_ro_flags(disk_super);
>   	const u64 compat_ro_unsupp = (compat_ro & ~BTRFS_FEATURE_COMPAT_RO_SUPP);


> +	bool rw_mount = (!sb_rdonly(sb) ||
> +			 (new_flags && !(*new_flags & SB_RDONLY)));

The remount is used to change the state of a mount point from
read-only (ro) to read-write (rw), or vice versa. In both of these
transitions, the %rw_mount variable remains true. So it is not clear
to me, what the intended purpose of this is.

-Anand

>   
>   	if (incompat & ~BTRFS_FEATURE_INCOMPAT_SUPP) {
>   		btrfs_err(fs_info,
> @@ -3430,7 +3433,7 @@ int btrfs_check_features(struct btrfs_fs_info *fs_info, struct super_block *sb)
>   	if (btrfs_super_nodesize(disk_super) > PAGE_SIZE)
>   		incompat |= BTRFS_FEATURE_INCOMPAT_BIG_METADATA;
>   
> -	if (compat_ro_unsupp && !sb_rdonly(sb)) {
> +	if (compat_ro_unsupp && rw_mount) {
>   		btrfs_err(fs_info,
>   	"cannot mount read-write because of unknown compat_ro features (0x%llx)",
>   		       compat_ro);
> @@ -3633,7 +3636,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>   		goto fail_alloc;
>   	}
>   
> -	ret = btrfs_check_features(fs_info, sb);
> +	ret = btrfs_check_features(fs_info, sb, NULL);
>   	if (ret < 0) {
>   		err = ret;
>   		goto fail_alloc;
> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
> index 363935cfc084..e83453c7c429 100644
> --- a/fs/btrfs/disk-io.h
> +++ b/fs/btrfs/disk-io.h
> @@ -50,7 +50,8 @@ int __cold open_ctree(struct super_block *sb,
>   void __cold close_ctree(struct btrfs_fs_info *fs_info);
>   int btrfs_validate_super(struct btrfs_fs_info *fs_info,
>   			 struct btrfs_super_block *sb, int mirror_num);
> -int btrfs_check_features(struct btrfs_fs_info *fs_info, struct super_block *sb);
> +int btrfs_check_features(struct btrfs_fs_info *fs_info, struct super_block *sb,
> +			 int *new_flags);
>   int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors);
>   struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev);
>   struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index d5de18d6517e..bc2094aa9a40 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1705,7 +1705,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
>   	if (ret)
>   		goto restore;
>   
> -	ret = btrfs_check_features(fs_info, sb);
> +	ret = btrfs_check_features(fs_info, sb, flags);
>   	if (ret < 0)
>   		goto restore;
>   

