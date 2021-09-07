Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3BD40268B
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Sep 2021 11:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245346AbhIGJyc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Sep 2021 05:54:32 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:26502 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243607AbhIGJyK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Sep 2021 05:54:10 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1878gPka014966;
        Tue, 7 Sep 2021 09:52:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WW5uCzQHMdP3PGVbpfadr4ZDX0JwnudtXflHTPpCN2E=;
 b=DZ2/iEIY6hanJKVGzpmBvRqXiQIklK30IDhQzh+fgr/dlFBoosSYVmwuq4N2W0RsrKUb
 DoU2HGLHEyfd3wrz0+PnlREuXPUWBRMNPmwXjrdQZJs4PQqHveBbQv/tO46ExIBcT1EX
 Qit3zpx5K8xcdTt6PyS5BV+FweCYHoxAP6qazTVEe7PWv2kMCbDOiPR2x5sjrdugGmkg
 1zCInyBVSjx7iPu5NiZhJT7osbYF6MbzcG76FyITrZUl5nInYASBgrNkF7piIxLGwqhe
 Zu1KYBD8RDV1gRUvFYIN4XifIJedtEdqW7p4Kda4Bs0Uoiujq+iE3PdP+eUIyjwIjagM DQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=WW5uCzQHMdP3PGVbpfadr4ZDX0JwnudtXflHTPpCN2E=;
 b=tl1kKwJKfDFOsHWlf/lry78g8BbtA/lK7XVJdr4VFnuGZEUGqQBfXc2i+23u1kVa06aH
 +BnU5EqxuXh/5s4Cdue5Gq8vJpHmixS1TqP0e9deFW7mpUegnUkb4r7x9tDxRd/37s3E
 QPrqut77LsNeIx6s8zsOaGK+rmX7TC6N2jI79bTFhw1RYWGWG4npRsrpsgOw4M10yUJ2
 tWn/LePX43XMwMttXOAyLlrL2QOLUBntel6dtspwy+BQiGUi0wXiwYIOrN2v33zy4127
 eQqtyGS/4M2kknrJkhhJOqKCsqWmQYnpXwUPejdtW1+tjT76zhyM7jR2HwUzODb8hrcy ZA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ax1de8pw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 09:52:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1879om7E171621;
        Tue, 7 Sep 2021 09:52:58 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2044.outbound.protection.outlook.com [104.47.56.44])
        by userp3030.oracle.com with ESMTP id 3auwwwk1b2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 09:52:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQnu1pEj/PFXbrwEOetEaxXcorB2Yaz7htCIzk9Uu37hI2NElFI3hhDUcuElm7PwKch3tMS9CWEkOYp/jp/IlDCqLkECFPkJuT+bCMbJt4RnTjD6jixuGi3YttYuxf4fyVg2Zbv4vHrv6sI0S/CI8h/BYRPX+Bw77iIguZMyPdxfYH1GJaSbQrtDzhJxzG5O5uIm6fZanYWa2lYq4g0QtdnYHjEjRH0KfFnQ2VbuVJo3OcN0OnZsC3gfittOVlmmTssgkNT0ELQ+K0eXHwBoQ4TcG2EtzNDcpm+VdwHv/4G0Tl6B2oaCC1FVEFrMC9BN/pVHEPhHCAewnLFy7e3/Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=WW5uCzQHMdP3PGVbpfadr4ZDX0JwnudtXflHTPpCN2E=;
 b=agcRObLXsrsAiL0YeSQwm8Q2T9uJdKfYbdH2Os4N98LEV3TmR7Up5oxFstV7dxfzkPzqU0lcXsxcZdSHLYzsnq6foo1GZETnNtFVUA/zsnT2C+lWD6ZYzfZwYZEhAZ2kX3QSDD2lZad3kJvTj7E8OC2mDRGm+PrMkJ8txZE92FVF3re9RkF2COxX4j4djXWZ1OHY2fx7w0KjAaWT05lFLdHzvvFP9JPQaoCC1dCid1U9TzOUnKWAYQKEDSzCVjMSU1XC35Os9mBn4TNW+rXG2yEm9W9YqSMCVLa0Y5iwLgGDeJkAD4hDBzlSgLsJ9xkYT9ZYmXmxcBh07Qk9aIS7wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WW5uCzQHMdP3PGVbpfadr4ZDX0JwnudtXflHTPpCN2E=;
 b=deTzr0PNk7Fe4peZTBiwoM0K9oTzJ7mPBUODmZcoVVAtf3vqW4193w5rrGqUdmMtXXmAIpyIhdVD5xStVFBcaFQXqbf+c3d2oq/cvzdtUIo5ubYR/4Nv2JfDKTDQ8qkq9veWtyQeBeQf6k+/FIeuOAO1YZNd9yAFoDLL4DHMhhA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4979.namprd10.prod.outlook.com (2603:10b6:208:30d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Tue, 7 Sep
 2021 09:52:56 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%6]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 09:52:56 +0000
Subject: Re: btrfs mount takes too long time
To:     Jingyun He <jingyun.ho@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAHQ7scVGPAwEGQOq3Kmn75GJzyzSQ9qrBBZrHFu+4YWQhGE0Lw@mail.gmail.com>
 <ce0a558f-0fab-4d52-f2d1-1faf4fb1777c@oracle.com>
 <CAHQ7scVkHp8Lcfxx2QZXv2ghkW-nYpiFGntyZa0Toz2hU3S-tQ@mail.gmail.com>
 <b0feb23e-4a18-efd7-eeaf-832ef0cf6860@oracle.com>
 <CAHQ7scUiNLVD_4---ArBet-0DqzfmmH5Y9JgQY0grYrUv8yhiQ@mail.gmail.com>
 <c2d2a244-f77c-e0a4-d266-db011fc4154b@oracle.com>
 <CAHQ7scVOYuzz58KcO_fo2rph44CCC46ef=LFVZF8XzoKYq27ig@mail.gmail.com>
 <250cfece-1d7f-b98a-b930-36baa34b8b72@oracle.com>
 <CAHQ7scXp9gTANB9gWHqQgXUsnF-YvTOKrK1waUScmqvHU_0ifw@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <e0134e1c-8365-3d55-2271-4cdddf4c3b07@oracle.com>
Date:   Tue, 7 Sep 2021 17:52:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CAHQ7scXp9gTANB9gWHqQgXUsnF-YvTOKrK1waUScmqvHU_0ifw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0097.apcprd06.prod.outlook.com
 (2603:1096:3:14::23) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.109] (39.109.186.25) by SG2PR06CA0097.apcprd06.prod.outlook.com (2603:1096:3:14::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Tue, 7 Sep 2021 09:52:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e631ff5d-c9e8-461e-cb67-08d971e5448f
X-MS-TrafficTypeDiagnostic: BLAPR10MB4979:
X-Microsoft-Antispam-PRVS: <BLAPR10MB49791BDDDD5B03AAACB17A01E5D39@BLAPR10MB4979.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aleXYwiXhUWODjX0dPBOLtKpM2+mTqmt9vwthmUQsWrh1wq3SJrwajA6XGV7cRonHSPaF6vP/FZo8BCmZotgwiGeOpSoltsf0p3/P9cuylk8UZS9NZYhqwHEEOsXpK7oWObS78xMeft9Zu4nhcRLCTh8Ri9Gh3nJDHd3YJsgV3wtP1L83boogOQB57QYwhTCmCF2B0l653C2QjB1MVYSez5h0LtwiBxI9ku6HOLz460Vqbb31hw4MZnfF852AK1t5XWr4vODMWQPSLmk78Cn4lomCH2/rjVe5N26ZE61oH7rsMnNp2FUSDb0hvC6EmlwrX1D4u2XRPPn3Vs5/dJw95bbxGnpM9n1lmbMMDXg77fs36O/8D3U4xKpkeQ9bvY2c6O1gS9ZtIUZxjbNfMZy3qCaWVM1/IT+HwZF6AXQv66e7VT8IpSVrYFdNeWVtzPJ8BeqV+yZx1XRCUnuzEZ7v7UUffCZDyY/7OgXZQ25s2IB6XFrhppMQ6MD8imU1Fo7b9OnLS62csKBc+ydJCohXzYSn1ae9IK7+k/CQ5sfEOL/N9SU2jJdpuj4KYXaTFAK1EyY0ERgwQy1r9E4fOlBUibPFJu1Q9NjmjOgK6nqrBCNI7KowvCCQkvNeSpUHz7ZLn9YL7ywHGDuQoLexJFQTidUXFuwCG6yNkUNq2hIMLghZQaEbJtJ2OkKQD7QGoYWId8x/c2RwNSixe8uAV5NJ1Z1xTfAz611OeFcP4fK/J6RHak+TRe70o6v8qBC5xU8tXDrKXg54c7iKgg2B6gyiRTgfanXeNsVfuKkwZo+d24Uhsn4ibowulFQLfFEsDVY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(39860400002)(396003)(366004)(53546011)(966005)(5660300002)(8676002)(2906002)(478600001)(186003)(26005)(6916009)(66946007)(66556008)(44832011)(6486002)(8936002)(31696002)(66476007)(86362001)(6666004)(956004)(4326008)(316002)(2616005)(16576012)(36756003)(31686004)(83380400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXJvQ2V5TDh4MzlSSUlWcEQ4dGdReG9GNDBqZDhJcEhGRHhLRTVoaFd1dXJM?=
 =?utf-8?B?M3Zra2h6bEdSRVg0TGkxOE5KQWRsMU9PWURMQ1dPbUZJTndqWkluY3VMcDVt?=
 =?utf-8?B?MXpscncrMUNOMzZqVk9iMVVvSUh4RmxoR3U5dGxJSytaNUpyY1l2REFrTWRj?=
 =?utf-8?B?eDREY3V3YURxQlp4ZEN5aGNsL2dKdzIzdC9kUFp0OXZ0SUxzZ1NHQ0FLbDlP?=
 =?utf-8?B?Nk9FUGg1anFqY2NGZGhnSFZkWlVtVXBCNjNBb2h4MUg1UHkrMU43dlhJV3lo?=
 =?utf-8?B?QllMWHI3UkxGanJybjkvTG9PSW9pS3V0dUtPdkdKcmZGRWVCdTlEcTQxNjI1?=
 =?utf-8?B?dEszb2srcitDRU1MUDdrMWNjSWVPNm00eVZlOU41b2w0aHBJazcyT21DZVpq?=
 =?utf-8?B?YWI0VWRsNk1EM09raEIvQTR4SFpwempsTGRzcTE3RVljSVFhUVlPc1dHR0hh?=
 =?utf-8?B?WlZ6bmZKL3IrMXovUzc1dTQxck1NZVorM01LMnc2MldLWVZCYkRZaGQ3MkVv?=
 =?utf-8?B?bGVGYzJ2VnY5blFPUHZzc210cjF3QjA3NDJ3a1NqOUtCT25EMHVOeVpsMXRJ?=
 =?utf-8?B?UzdQRnVFcVdZVUtNdFpXUXI5UkllQXFqNzRvTFFqbmFUSEJtaTg0TzdWZGxo?=
 =?utf-8?B?di9IZmk5aHVscGZnUndYYWNUeC9JMnIvam1sZHMva1Z4U0xsWlNtUmIwTllB?=
 =?utf-8?B?Z3hmUnV0YXp2clFVUFpxM0cySkpMbitobXBjbTJMbVVHQ1QvbmhGclFJY21J?=
 =?utf-8?B?cUhvVWNsNk9PTTZKQmNJM1krVEZ6S3NOa1YxcTBvSnU4S0xYOGdaQXRpWXlv?=
 =?utf-8?B?ajhwT2RVRkNtbVdBZ2QvSGUyVVh3RlVsbElENC9MbnFBL1hJcGl2dEpvNUJY?=
 =?utf-8?B?OXJPODNQbzBFbGYrMExGOEV2bzRmYzRkcWxFRjhxbEl4cEh6TC8rQnlmU09k?=
 =?utf-8?B?bHZPYjBKY1ZWZzJPQnVmcnN1YWhVUStDUEwwYU5JYy9WdHVqUGlGK2Y5dzRH?=
 =?utf-8?B?T0JrSEFUMTF2N3M0MGRlTmVkdXdvdHJLVnR1OCs3bDRVTXRhY3craFdHUGZY?=
 =?utf-8?B?NW1pU20xSnFwVXZXaW44OHZTb245RHlsMGlNS1BVNjZnQldDTnRJaGcwNTRo?=
 =?utf-8?B?UEsvenZtYWlCd0F1czl5UlM4cDdYR1V6SmVJY0Nsek1NV1VnNDdvaUpMNXJ6?=
 =?utf-8?B?em00U3JFdVlqMStrenhTTTBoM3BpdUMwWkk5TnNtK21qWnRhUXVPaWNYbGs4?=
 =?utf-8?B?YnZlcU4zUkFSU1pObnQ0S2I0VUNnbUl0bWYyaVNEbTJJVm42V1p2Kzh2ajVJ?=
 =?utf-8?B?WkVRbVorZ0V0NEVoSlhUTDRFWkFXRnlCSVhwTE9ka0swRGNZOGhMMXNyMHNs?=
 =?utf-8?B?SHFPbDdYQk1WaFFKaloyUXpUMjNuenNNdXJsWTh3RXIvMUkrMVhnMDJ3VGFN?=
 =?utf-8?B?WVNrREJML0dUMnhqbHJ5cWtNUTA1SkU0dWVRWTkrUDc5d2VaeDQ4YWlPc0E0?=
 =?utf-8?B?UnBzb2pib3JPTENpRVdzeHVNTG5rSjhtbGl3V01ueWhaZmZEZFFBQWtSVXI2?=
 =?utf-8?B?U1pRQmNlMlMvYkVLd3JtMW84djZHZ2xycnk5TTMxWEI5VEdoaXlpbGsyTm40?=
 =?utf-8?B?cWo1T3UyRlM5UFZ4UXdBM2tndTkzMGREL3ZJMzZMOUloWUxhOWRqeSsrQTZU?=
 =?utf-8?B?VWQ5ZEF2Rmh1Rk1GVldCeEdQYlcwRllJZHBGblhnOVFFRi9OU2pJOVM5SXp5?=
 =?utf-8?Q?XuhfgIgtBv08GWaBHCCI5RD/D1pJjESsl/fpAeZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e631ff5d-c9e8-461e-cb67-08d971e5448f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 09:52:56.2644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJ3dxBW7Q8Mr9GX8MNEgbggs5kw18zfjm1FVvsv9lPJCm2gDQljuQSdk2gNWDCPlbNWhoZb+RtAF997+Ui3/jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4979
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10099 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109070065
X-Proofpoint-GUID: cjFGGGbXixaXLMdZhgfDC9uBHMr3BRv1
X-Proofpoint-ORIG-GUID: cjFGGGbXixaXLMdZhgfDC9uBHMr3BRv1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org





On 04/09/2021 20:45, Jingyun He wrote:
> Hello, Anand
> Sorry about the delay,
> I have attached the result of
> $./ftracegraph btrfs_load_block_group_zone_info 2 "*:mod:btrfs" "mount
> /dev/vg/scratch0 /btrfs"

The last trace has 8514 calls to btrfs_get_dev_zones() and, each takes
around ~1.2ms to ~3ms.  Naohiro is planning to cache the report zones.
It would help.

Thanks, Anand

> Please kindly check.
> 
> Thank you
> 
> On Tue, Aug 31, 2021 at 7:09 PM Anand Jain <anand.jain@oracle.com> wrote:
>>
>>
>> btrfs_load_block_group_zone_info () and btrfs_search_slot() were the
>> slowest and, they are called more than 2127 times each (trace buffer
>> has rolled over there isn't all the data).
>>
>> Sorted in the ascending order of time spent.. and bottom few...
>> <snip>
>> 19472.64 us | btrfs_search_slot [btrfs]();
>> 23294.26 us | btrfs_load_block_group_zone_info [btrfs]();
>> 23315.21 us | btrfs_load_block_group_zone_info [btrfs]();
>> 224534963 us | } / btrfs_read_block_groups [btrfs] /
>>
>> Most likely because the zoned devices are slow, and we have to read
>> all the block groups during mount, so there is not much that can be
>> done about it.
>>
>> But let's see what part in btrfs_load_block_group_zone_info() is taking
>> most of the time. Could you please help get this output?
>>
>> $./ftracegraph btrfs_load_block_group_zone_info 2 "*:mod:btrfs" "mount
>>   > /dev/vg/scratch0 /btrfs"
>>
>> Thx.
>>
>>
>> On 31/08/2021 01:17, Jingyun He wrote:
>>> Hi,
>>> I have attached the result of
>>> $./ftracegraph btrfs_read_block_groups 2 "*:mod:btrfs" "mount
>>> /dev/vg/scratch0 /btrfs"
>>>
>>> Please kindly check.
>>> Thank you very much.
>>>
>>> On Mon, Aug 30, 2021 at 9:05 PM Anand Jain <anand.jain@oracle.com> wrote:
>>>>
>>>> open_ctree() took 228254398 us. And 98% of it that is 225418272 us
>>>> was taken by btrfs_read_block_groups().
>>>>
>>>> -------------------
>>>>     1) $ 225418272 us | } /* btrfs_read_block_groups [btrfs] */
>>>>     1) * 16934.96 us | btrfs_check_rw_degradable [btrfs]();
>>>>     0) 0.967 us | btrfs_apply_pending_changes [btrfs]();
>>>>     0) 0.239 us | btrfs_read_qgroup_config [btrfs]();
>>>>     0) * 21017.34 us | btrfs_get_root_ref [btrfs]();
>>>>     0) + 15.717 us | btrfs_start_pre_rw_mount [btrfs]();
>>>>     0) 0.865 us | btrfs_discard_resume [btrfs]();
>>>>     0) $ 228254398 us | } /* open_ctree [btrfs] */
>>>> -------------------
>>>>
>>>> Now we need to run the same thing on btrfs_read_block_groups(),
>>>> could you please run.. [1] (no need of the time).
>>>>
>>>> [1]
>>>>      $ umount /btrfs;
>>>>      $./ftracegraph btrfs_read_block_groups 2 "*:mod:btrfs" "mount
>>>> /dev/vg/scratch0 /btrfs"
>>>>
>>>> Thanks, Anand
>>>>
>>>>
>>>> On 30/08/2021 14:44, Jingyun He wrote:
>>>>> Hi, Anand,
>>>>> I have attached the new result.
>>>>> Kindly check.
>>>>>
>>>>> Thank you.
>>>>>
>>>>> On Mon, Aug 30, 2021 at 9:27 AM Anand Jain <anand.jain@oracle.com> wrote:
>>>>>>
>>>>>>
>>>>>> Our open_ctree() took around ~223secs (~3.7mins)
>>>>>>
>>>>>>      1) $ 223375750 us |  } /* open_ctree [btrfs] */
>>>>>>
>>>>>> Unfortunately, the default trace buffer per CPU (4K) wasn't sufficient
>>>>>> and, the trace-buffer rolled over.
>>>>>> So we still don't know how long we spent in btrfs_read_block_groups().
>>>>>> Sorry for my mistake we should go 1 step at a time and, we have to do
>>>>>> this until we narrow it down to a specific function.
>>>>>>
>>>>>> Could you please run with the depth = 2 (instead of 3) and use the time
>>>>>> command prefix. Also, pull a new ftracegraph as I have updated it to
>>>>>> display a proper time output.
>>>>>>
>>>>>> $ ftracegraph open_ctree 2 "*:mod:btrfs" "time mount /dev/vg/scratch0
>>>>>> /btrfs"
>>>>>>
>>>>>> Thanks, Anand
>>>>>>
>>>>>> On 29/08/2021 17:42, Jingyun He wrote:
>>>>>>> Hi, Anand
>>>>>>>
>>>>>>> I have attached the file.
>>>>>>> Could you kindly check this?
>>>>>>>
>>>>>>> Thank you.
>>>>>>>
>>>>>>> On Sun, Aug 29, 2021 at 7:47 AM Anand Jain <anand.jain@oracle.com> wrote:
>>>>>>>>
>>>>>>>> On 28/08/2021 19:58, Jingyun He wrote:
>>>>>>>>> Hello, all
>>>>>>>>> I'm new to btrfs, I have a HM-SMR 14TB disk, I have formatted it to
>>>>>>>>> btrfs to store the files.
>>>>>>>>>
>>>>>>>>> When the device is almost full, it needs about 5 mins to mount the device.
>>>>>>>>>
>>>>>>>>> Is it normal? is there any mount option that I can use to reduce the mount time?
>>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>       We need to figure out the function taking a longer time (maybe it is
>>>>>>>>       read-block-groups). I have similar reports on the non zoned device
>>>>>>>>       as well (with a few TB full of data). But there is no good data yet
>>>>>>>>       to analyse.
>>>>>>>>
>>>>>>>>       Could you please collect the trace data from the ftracegraph
>>>>>>>>       from here [1] (It needs trace-cmd).
>>>>>>>>
>>>>>>>>       [1] https://github.com/asj/btrfstrace.git
>>>>>>>>
>>>>>>>>       Run it as in the example below:
>>>>>>>>
>>>>>>>>       umount /btrfs;
>>>>>>>>
>>>>>>>>       ./ftracegraph open_ctree 3 "*:mod:btrfs" "mount /dev/vg/scratch0 /btrfs"
>>>>>>>>
>>>>>>>>       cat /tmp/ftracegraph.out
>>>>>>>>
>>>>>>>>
>>>>>>>> Thanks, Anand
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>> Thank you.
>>>>>>>>>
>>>>>>>>
