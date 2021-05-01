Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF30F3705B5
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 May 2021 07:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhEAFRO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 May 2021 01:17:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53708 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhEAFRN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 1 May 2021 01:17:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1415DZSV003509;
        Sat, 1 May 2021 05:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=iow3cd3UE5zIXBDHAiIMbo9Cs+6LwQ0jhHpqpS8qkWk=;
 b=ry/9CdkdOdqA5vCLvmHD0zS9/rewMP+nFkoV8pbzG8cHSPw9+7QcP0uLDWSNbkUMUvbA
 3ZfeS84EWdQ3EWXpjwYf0g7GzYuadVeJKyLWSgblW55lZ32y0RhTIS6syWZo+jp5bLbV
 fxu8JcQ+UY2rjE9YzcIG3Y6oDdB3BIkWiXH1G8Lb+lOcJFDCJgSuiD8+U/L0Dhg/bOBK
 uRVcSDhLHU71NYCFqyELXTLHuUHEum68Py86Mb9aX35imPhK7+pi2n1eIwK7L+tTc3FB
 xCcManXdavpPeYD0vszXwIvdvdBfls+LeEaoy8F+WZmg4DjC3Gj+CXzWvas2oS/UqhaX UQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 388xdrr33a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 01 May 2021 05:16:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1415AwC4161418;
        Sat, 1 May 2021 05:16:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by userp3030.oracle.com with ESMTP id 388v3sy555-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 01 May 2021 05:16:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iu0cityiG9SnxS06mbQWfNHjiNCjIWPV5q3fAXH2ttL4ZaoTyOdoEG+EIdjuHvRtbo6X8ADoNOAjHPib5jyXWxxFDn+23doITPgQojGLI5l33kDYNdSIuP0nka3Rx/tINRj9RHhSWrlyzrxQcoZT+w3VpyoamMiKe8W7CxSUqTHUkOE2gKA3DZNuq+3RbhXEfHm/PT1b1md24zEv3ruRgokxGKZwJa/2Sof3s5esgiZk2eDaPf/MTGzrwXFtBvwJCBQsna/jcNuXp6LNxfO5SKWjVYdlkRqETLgXhgP9IlS1+KuCi8AHSTqNEToA/cqjT8enSpCJiU6UA3VvPNgZPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iow3cd3UE5zIXBDHAiIMbo9Cs+6LwQ0jhHpqpS8qkWk=;
 b=P1s8TdYLKRBH215rtG0qi4LwxpvgW96mmkzc69Ukqx+UsFrOhSDGrJrfLbzYRCcTB1xGJDAOdxvqvDXkKY5lFBPyRoo7ivxyNSyO2f59+Fbqv24dJOmIy53oNxqaNx1Kqc1AHKgNhKsdX0t7IqYwM3aL0TyD3AHvNhRahtGgvk3HC4QlysuQsGlWqqTj6jtLGjKkOhtkSDnYn/wDs4GTON4QHKz1nAyv8Qn6cMj2A5PtcEunm4NYnqP/DkgSIhJtaTlXzdg8BRUXa7evkkzOk5j8wSTuEcDj55twISlClehZ/OHTy7EN2pNv3+q2h17VGqcq5TrBDsYhnhT+VcttLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iow3cd3UE5zIXBDHAiIMbo9Cs+6LwQ0jhHpqpS8qkWk=;
 b=bvN8/MUwo3E9Qad06BzvOsFmK4JzjB2JW0SrAeIrRLA13TELRB3xxuruIlRKNailPBr/6uymBjGVoFfIZ63ietgOLDIURPu95qEWNjcRZFl4JWOEA9Wuq30DDfL5uYwI1XBiu0kizii0+l8HVJURioU5Z0LhiZgvjfWZMhT9Rpc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4868.namprd10.prod.outlook.com (2603:10b6:208:333::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Sat, 1 May
 2021 05:16:20 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8%9]) with mapi id 15.20.4087.035; Sat, 1 May 2021
 05:16:20 +0000
Subject: Re: [PATCH] btrfs: add fstrim test case on the sprout device
To:     fdmanana@gmail.com
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <d6fcae756c5ce47da3527e5db4760d676420d950.1619783910.git.anand.jain@oracle.com>
 <96fe1c0c8747d24ad6c45bc3f0a5551b8e1ebbde.1619793258.git.anand.jain@oracle.com>
 <CAL3q7H4-zRWVpTnxmQ-VkCmQ8hWvd5L_5ouC7CEWPgHwxMbqqQ@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <58a1c6ed-cafa-f092-6e36-a648666060e9@oracle.com>
Date:   Sat, 1 May 2021 13:16:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
In-Reply-To: <CAL3q7H4-zRWVpTnxmQ-VkCmQ8hWvd5L_5ouC7CEWPgHwxMbqqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR01CA0134.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::14) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2PR01CA0134.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26 via Frontend Transport; Sat, 1 May 2021 05:16:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16a2fc8e-cd75-45d2-0b87-08d90c60410d
X-MS-TrafficTypeDiagnostic: BLAPR10MB4868:
X-Microsoft-Antispam-PRVS: <BLAPR10MB4868DB5C354A3A9CCE1CA8F4E55D9@BLAPR10MB4868.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3mCZ1iWDhhWdpubl9OOHLn3UXtPjs40VxV/jff0ZLfaZtN7nLD3O/zhiH2tXMsPcsrmFRoolLDcCXUvfZQBBoJ1ku5L7GG1+BMDm2yj94lt5tIwaW6C/O6+TUiH4Wvj7492p+9JVmNvI/9Rx70BtMLUapJwyMZ1s1EU+Uol+Ea+7Kg0d4tN5wsGa8lc7+P4UZog0ejMBntbp2CbvcB9WzobEthGPNB7JWRmt/yQ86yKSoietk9dqZpcrQBj1ocAsfiMP/wDS8p+eqq0SSULikbkRLlNaa3LLtsW5jaw1PJyjl6our92/rK2cJtPLuBAz+X1M+yQDFuAMsnu6GeloUk+E9V1fludvtswXikSai3hbMS4iSu2ZiRNPmPkmteBsSsnbxyM3CoM7XaVYIzFl1CeMbvyTqNlQkBmuz8LbVp+xRfoFFhs6u6FTnmkA0OsmdGIKtm77LzONWuKBslphzYbNqco7vUfsgoL1pHL3tP8UJOFFy2ZNxVvNcm/Ty2XCp0VAfOBRc0Am06CigZwk3/0ksA4kF3dzmVe/xANTAL1NWGZf6MsvCHu8ltxTHB5Hdis1hrMu1GH7IGF8jm/BnL50ttiM2PaZ6WiiqeG/yvRgp7ypyb5gx6vPV1UkkasdzMQ4UdH450EFhO3AY7Txwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(376002)(366004)(136003)(396003)(478600001)(54906003)(8936002)(66556008)(83380400001)(66476007)(31696002)(26005)(316002)(36756003)(186003)(16526019)(66946007)(5660300002)(4326008)(6666004)(16576012)(8676002)(2616005)(956004)(86362001)(6916009)(31686004)(6486002)(38100700002)(44832011)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dlQ0TUZoNHBRMmtYZFNuMmhDc0M1OE0rWDhYR0hTdmxIV2VMVHlReGlnU2hq?=
 =?utf-8?B?cjd3WXp6VEgxam5wZHhwOXNEV2NmVXlhQTdIaFdTZVM5RGxIMkkvQlIvaE4w?=
 =?utf-8?B?Y0ZDN2hMMDZGZHdGVStQdGxpaVE2bnE1NGMzVGVCOXdDTnlyaWlpSDUzUUJX?=
 =?utf-8?B?NnpEeWNESmI0N2lyRSsrUlNpdVBpc3NuK1VrbGRwQWxMUUh3czdZU3dmU3p3?=
 =?utf-8?B?MUdPZG90M1lnRFk5OEZXdTJRM1V1d0VBMzRJTm9KU1B6R2IvMzJPcFdVOCs0?=
 =?utf-8?B?L1U4R3pBNGxxc25UMC9qeTg1a2d4VHlTenBEd1E5eTBLQmU0OHpkVkdQaVNu?=
 =?utf-8?B?ZVJ0RjNROWtHMHpqYlU4enFSNmozWUJpTkVtNW9kSDNTZjUzd0FnN3F1ZVNH?=
 =?utf-8?B?di9ZbTExcU05TmFDTUw5V011MmpNVVlJY0p0MXF0YTZuY1k0a0pWeWNrT2Jh?=
 =?utf-8?B?WVZ0YnNjWGJLbkdLb1V3MVJUTmNzakxEcjV4WGhiVFVvaGlibldncWJNUE5L?=
 =?utf-8?B?YkI1Zlp1N2JMTEpXK2g1RFFvenZaY2hFUVpWTlMzNnRwNjJFUzFjYlcwTFpX?=
 =?utf-8?B?WTNOdDg3di9vWEhRdUt1anYyTlgzTDdzbUNxRytLd2syNVZLRnloL2pmekRF?=
 =?utf-8?B?TTRzUGZtTDFRblVqaWpqTllHbndOQmtWenMwR0JzeFhBbkV6TW5NM2dTSVJp?=
 =?utf-8?B?UHBGODZFK0wxSHNYNkVjR3h3WUZCczdQL1VtT0xsUHBreE5zWXVZR1RUTTdQ?=
 =?utf-8?B?WGhueVcvSlp5UzBRTWMwSytaT0YrbndKak82MHFyWTdob0c3bExLWTIzNy8v?=
 =?utf-8?B?YStlUDRMS1JMTlhPLzZFZ3RvVExuZURkRHoydU9XRWhBdzJjdkg4Z2hUZks5?=
 =?utf-8?B?Z2VkL2kxSnMremM2YjBuOUFwM0dZOWxIeURjelhWRUlMZ2xSdnBZdkRyaCtq?=
 =?utf-8?B?YXVZTFNiNzlKZ1FNdDJ0T0o0WXAzVXVMa1A5NXpLZnBySGhxa1VRZWVtS1NR?=
 =?utf-8?B?U1VweTR0Y1BWaU1ldGR4di9DSjBRMWMzYmJvSnFQUTNkNGRSYVh3bUVnVmtu?=
 =?utf-8?B?SXpYc3JDOHlaZjJGcHRRT25NM2hWbWpKMXNiWlVCVUVDeC9OSXNEWWZjdE9o?=
 =?utf-8?B?cDN1bzJzdnpoWjRJUitJWFdvTUpneHV0ek9yei96M2w0WFB6VkN0QU9ncFNY?=
 =?utf-8?B?SXFtOUQyZzB6bnM2NnNnRTUxZ204TjJWVU9rUkprZFNaZFpMRFRQR2xpcGwx?=
 =?utf-8?B?RHhJUUMyZ29MOStqY2xzZ0tsQUlyZWlJZ0ZmRjdpaEVJMEJxb01RNXdOM3lP?=
 =?utf-8?B?MGpYUHdMRXdVRTBxYnlCakliMWpWN2I4Z0NqUHR6QjNWUmZmMWFuNFJtNXgw?=
 =?utf-8?B?U2R5STFPVlRTbWgyMHdZMmY4NUxaUTZ5RnB6YVVVS1hiWGZrdnhJVHJITnRs?=
 =?utf-8?B?Z1FCbVBkNmtyNjExaWxpOUxRNExVbjZFRWNZTHZsRHZRZE0zMHpjMk1mRDF4?=
 =?utf-8?B?d2czQnEzdS9EbElTVjhpRW5pc01BMXk4OGcvK0lmc2NaYUpnZEc5SkxCejlX?=
 =?utf-8?B?Z3grbFU5MWVxdkl5ZHpWaldwVlhKYjlHUlZqRm9BSVZSVUplaDZSdGt1QytC?=
 =?utf-8?B?WnBVUElkMFlOY2pIeEEybjdsNWg0dmtzNG1NTTVPOTNDVUxWaTUzL3pSak4v?=
 =?utf-8?B?ZHJleXhGYnl1RGVRSi9hdGhQV2VjR3E0TFdDZTFlUzdvS004RDFFNEMzL25X?=
 =?utf-8?Q?lqSNnyXmMB4NPxq/LVL1FJ8wjcw38buYdFuAytJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a2fc8e-cd75-45d2-0b87-08d90c60410d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2021 05:16:20.1455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Je4vixRPo253y5D653cukkQNOrB+ViudvzywsWRHTaMWapF3doTdW8fpNOjLukUdQyEp+JFt7I7rDb2hQszs1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4868
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9970 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105010036
X-Proofpoint-ORIG-GUID: NGxFfuKPjb2s2bJOBXeo4jWLq_IMoOX9
X-Proofpoint-GUID: NGxFfuKPjb2s2bJOBXeo4jWLq_IMoOX9
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9970 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105010036
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


>> +
>> +_mkfs_dev $seed
>> +_mount $seed $SCRATCH_MNT
> 
> Missing the check for discard/trim support:
> 
> _require_batched_discard $SCRATCH_MNT
> 
  Oh. I will add.


>> +fstrim $SCRATCH_MNT
> 
> Should use $FSTRIM_PROG instead of fstrim.
> 

  Right. Ok.


>> +
>> +_scratch_unmount
>> +_mount $seed $SCRATCH_MNT 2>&1 | _filter_scratch
>> +md5sum $SCRATCH_MNT/foo | _filter_scratch
>> +_scratch_unmount
> 
> Missing a call to _scratch_dev_pool_put
> 

  Yep. I will add.


> Ok, it fails as expected without the btrfs fix.
> But with the fix applied, it fails differently for me. It looks like
> different mount versions output different strings maybe:
> > root 16:18:40 /home/fdmanana/git/hub/xfstests (master)> ./check btrfs/237
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 debian8 5.12.0-rc8-btrfs-next-86 #1 SMP
> PREEMPT Fri Apr 23 17:35:49 WEST 2021
> MKFS_OPTIONS  -- /dev/sdc
> MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> 
> btrfs/237 - output mismatch (see
> /home/fdmanana/git/hub/xfstests/results//btrfs/237.out.bad)
>      --- tests/btrfs/237.out 2021-04-30 16:09:33.103380077 +0100
>      +++ /home/fdmanana/git/hub/xfstests/results//btrfs/237.out.bad
> 2021-04-30 16:19:31.577988213 +0100
>      @@ -1,5 +1,5 @@
>       QA output created by 237
>      -mount: SCRATCH_MNT: WARNING: device write-protected, mounted read-only.
>      +mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.
>       096003817ad2638000a6836e55866697  SCRATCH_MNT/foo
>      -mount: SCRATCH_MNT: WARNING: device write-protected, mounted read-only.
>      +mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.
>       096003817ad2638000a6836e55866697  SCRATCH_MNT/foo
>      ...
>      (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/237.out
> /home/fdmanana/git/hub/xfstests/results//btrfs/237.out.bad'  to see
> the entire diff)
> Ran: btrfs/237
> Failures: btrfs/237
> Failed 1 of 1 tests
> 
> root 16:19:31 /home/fdmanana/git/hub/xfstests (master)> diff -u
> /home/fdmanana/git/hub/xfstests/tests/btrfs/237.out
> /home/fdmanana/git/hub/xfstests/results//btrfs/237.out.bad
> --- /home/fdmanana/git/hub/xfstests/tests/btrfs/237.out 2021-04-30
> 16:09:33.103380077 +0100
> +++ /home/fdmanana/git/hub/xfstests/results//btrfs/237.out.bad
> 2021-04-30 16:19:31.577988213 +0100
> @@ -1,5 +1,5 @@
>   QA output created by 237
> -mount: SCRATCH_MNT: WARNING: device write-protected, mounted read-only.
> +mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.
>   096003817ad2638000a6836e55866697  SCRATCH_MNT/foo
> -mount: SCRATCH_MNT: WARNING: device write-protected, mounted read-only.
> +mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.
>   096003817ad2638000a6836e55866697  SCRATCH_MNT/foo
> root 16:20:06 /home/fdmanana/git/hub/xfstests (master)>
> 

  Just found there is _filter_ro_mount, which comes in handy here.
  I will use it.

Thanks, Anand


> Thanks.
> 
>> --
>> 2.27.0
>>
> 
> 

