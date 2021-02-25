Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9796032486F
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Feb 2021 02:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbhBYBRq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Feb 2021 20:17:46 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49296 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235346AbhBYBRo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Feb 2021 20:17:44 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11P1FMaA009300;
        Thu, 25 Feb 2021 01:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=5/Mtkyv8h+AsnumLPAX2WsPq0KTw/k1nIYkZa1a9cF8=;
 b=No1xnUym+E8mqko+LIX6WTWCK4AabybajnBFaVrSH5oLrVkRveb7h+4ho5/r3px0OD0T
 bafcNl8xp0atuO44QW7PG7ANtU28VdKZ2IC77My222KZkkeFeNtr7G0z7CLfoii5hwZc
 3NwtCqfRFyzVIuofnC/2QaBRyVE06rpUHOSCj9OPaYcFYYFhHNJOGXvY8B2RJAa0iNxN
 UOz0zYwJVaVUILmNSQKHSBxW3QSep0Qglk7JUKMHijoWqaif+HvW8iRU7Wxbs7M4OGF5
 3Spqtwcqkw+Sd3V/+d3J6R+hYTDljxg/QWnKO1dtiJTlrocwjOySp7LkGrCtVNM5Xeg6 Iw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 36ugq3kr5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 01:16:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11P1EfEk171746;
        Thu, 25 Feb 2021 01:16:58 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2051.outbound.protection.outlook.com [104.47.36.51])
        by aserp3020.oracle.com with ESMTP id 36ucb1e8t9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 01:16:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0Dhgh1eYe2I7DrY4dEESlQ1PQtRCi9jjxeRpFlov1KwJH4sMKqABtVQBKJlaF8ZK7gPKW3+Etz5LiVpK1PSn9w8eA81i1oMi2tmIDVYQNeeabNajCbjzYlgE2DApR4Lsp/qokMz0W2l9G5BMZ1l5gAzXoYngRK6MiryKvSCwBNV1UJ+o0vaWvOUXWCwsXywm3iyP4E2ibLGHbTC3/F0eh/T2ctU20T9/l8OGrHrVJXpYog7EJznu9QG+PHw3xJAqEtqdsySQgHlOo0Q+BkVvzgcV87ybOFBUHR8boj0JOI79OSVVe5Plolc9V358V98b/hnDEW/61W63PQqKR37iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/Mtkyv8h+AsnumLPAX2WsPq0KTw/k1nIYkZa1a9cF8=;
 b=lnDj6nm+f3qtXpaRqALt2U6InQyCq7cDNZUnglaB2mz5YIrWpRK86NP1XAUvZDe+0kAw773sNa25oD6bncomNyxC4ZvaIFyfBCqJZAGcPX2e5HBaF3YER7qkYffUmLdE1fJCbdt21zG8vV7d+3ulAjjFWXgum/QukLdC8py6z2urbAwiiNVc1d158/fO7Ld7KNMRcyZoDe0EnM7qOV/iO1C/AaQUUJFKzo2GFnIJaSW0Mk+MePhSDyfoy2fI3Mby/Z4APvBqqN/w0ygXdqqUs+3zEFWQCiXuYV8ZFAGMHedGQ4GiyDRJw69C7CB2qTE41v1yEA9jRIVEkRgPymjaeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/Mtkyv8h+AsnumLPAX2WsPq0KTw/k1nIYkZa1a9cF8=;
 b=V07Hyqx8BOSCPXiE2x5xjn/2Cc7A4BYWMpvVc87j+d/s8kKZVU8MGM9aTahFzlyEVVOP2h2Fj71OknRz61g5R8xvTPPvY2ffF+bE120i5iyxFGo5AFpn30f1nlvDHITT6AIDcNm/An877sbWblpnkFhq0Gi6x79hOqytVoTjmh0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2993.namprd10.prod.outlook.com (2603:10b6:208:7d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 25 Feb
 2021 01:16:57 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125%8]) with mapi id 15.20.3890.019; Thu, 25 Feb 2021
 01:16:57 +0000
Subject: Re: xfstests seems broken on btrfs with multi-dev TEST_DEV
To:     Eric Sandeen <sandeen@sandeen.net>, linux-btrfs@vger.kernel.org
Cc:     fstests@vger.kernel.org
References: <3e8f846d-e248-52a3-9863-d188f031401e@sandeen.net>
 <5e133067-ec0c-f2c6-7fb6-84620e26881e@sandeen.net>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <407b5343-4124-2e30-0202-13f42d612b7c@oracle.com>
Date:   Thu, 25 Feb 2021 09:16:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <5e133067-ec0c-f2c6-7fb6-84620e26881e@sandeen.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR06CA0103.apcprd06.prod.outlook.com
 (2603:1096:3:14::29) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.102] (39.109.186.25) by SG2PR06CA0103.apcprd06.prod.outlook.com (2603:1096:3:14::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend Transport; Thu, 25 Feb 2021 01:16:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25a4eebb-f56d-426c-35b4-08d8d92b0aa9
X-MS-TrafficTypeDiagnostic: BL0PR10MB2993:
X-Microsoft-Antispam-PRVS: <BL0PR10MB2993CC5E8CBAFE3EC00F6087E59E9@BL0PR10MB2993.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VeU7rW0HUTxyi5ggEX92L6WtkWst0h8N0blZFax4RcmJo3iEHJh0VJa5/rLl94/B7Si/NuVtI7iatQcLWXR2yQo5KYB+GQHp/ip2r8wvoOZYpwOfkQunEiIOjSn3DV2OpitJ7j3atl2xoqUtaFiigoFJziMKIuVUKSltmVRN3EkenoD80eUack1wddTD87KO4J3A7viYJ0wk19VZgJ2V7hLymgBLjAgP10g7Nnx9QmqnnMaAbesDbFRivVXo2CYt1FX3FVW1t698FqybYkW7bmizfusBJJIHaLYsbb4z6y6G4tEMPL+rIoS07DaMfajrH2QTwx0GLF4FuwQ4uSV+0gTwgDAE06UgRK3H+ep6Z2hojFhdI4/s9BKQRjgDRD0+yMqNZAW3nEMCcWMuiLt9hjjDNjOvpZSmKBCNYBUgXQYv2gqYRMSxmVCFuMA+LNefde3xu9mFGIyNnCfNECG9ZccAABXAEY14FQMPjHJrohcOsO5LQ2skoIByHhxU35SKDjwBvIv7CHW4B/ImIStz8aOXPRXYDQzPXCiERMLKyR9cXVvwamjZPB1FrYPl9wq+0dwSHD2Tm0uOTGv62J3v3HutgRRJfu7rVVQA72oWMTY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(346002)(396003)(376002)(136003)(5660300002)(44832011)(316002)(86362001)(16576012)(6486002)(4326008)(66946007)(31696002)(956004)(2616005)(478600001)(26005)(186003)(66476007)(66556008)(31686004)(2906002)(6666004)(53546011)(8936002)(36756003)(8676002)(16526019)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?b0FWUjVkRElVTVpJM0hhWkNLQ2RidmZBSnQ3RGRCdEZxSUtYRnFXQ2lKMzBX?=
 =?utf-8?B?dVJuZlFzVjl3L3FKU052ZHFldUl6clZHRUpNcDlDZkh3cWJNRCtiVE1mbVYv?=
 =?utf-8?B?VVBlWFhmdkpZSFhncDJjdk5sR1l6THV0ODZSaEc2RkFmMURTYnFWV2F2RDcw?=
 =?utf-8?B?cEtrNVd2S1djQWpZZ2hEa2FEWURidjhlWjQwelEweVhjSjFtenFmZHAydFAr?=
 =?utf-8?B?VHF0M1BPSzlpVTRHK3paZytjOEtEaG9zRmhwSmFVc2hWaDkrdHYxNDhjZDR5?=
 =?utf-8?B?UlNGalZqTkZlU1JXMGYzeWhvaVRhOXJ3Sm9iV1VsUkgrUUQ0aEM4SGxMcGxK?=
 =?utf-8?B?c3RSMW1RaXBPTllRdmVzZ2JGZE1hajdWdjFNT3FQUEo1NlNqTi9DejFrK1Uz?=
 =?utf-8?B?b2dvWU5sb1hoY1V4ZUdSb1BmNHBpdFNVczJ6UEYzUnlMRjBmRVp2d2dsdXZC?=
 =?utf-8?B?RG1ZRDhiWWNhZzhWNysyRExGVlRhaWtBNUtuZzRWNHFwK1dNNUJGWUowdEJM?=
 =?utf-8?B?SW1qRFRNWGxmODIrMGZWQzFNSExmcHcrM1dENVR3Nlc5TUVmdiszRWUwTXRU?=
 =?utf-8?B?Tm0xYmR4YWpzcDRMMmE5djl0L1BSM2RRaU9nRTQxd0dZSnNMdEhaWEFHb1Js?=
 =?utf-8?B?TWlWMGlEU1RnYUxHbnRwM0xKcElDUlRuN2s2dVVZeXRBVzJHbXoyU3ozNDVj?=
 =?utf-8?B?UTVBbXpheEE2TlZxOTJHcVNyUjQ5ZjU3TEh4anEreGZnVllkYTJ0OTJKYmJY?=
 =?utf-8?B?dy9OUm5sKzNEK2o5N09tQTNLWkphMW9PMnNZRUwxTlh4REJKK0Z6K0xpYllS?=
 =?utf-8?B?d04zdHlwR1YwQzFKSmhqby80Q3k0S21ETkxPYjdtUldvekdFMlZDV2d3TWpk?=
 =?utf-8?B?bmxvdGo5ZC9QZ2M5aEcvemEvYUxObnczUVczWFR2QnRHbitiSDVuVE1NaWR5?=
 =?utf-8?B?My90OVgycXQ0eWJaMDR6dmpzZ2RQd05qazBZczJGTHMvYjVuZzgwRnI5NU5F?=
 =?utf-8?B?VVRKRXJnR1dLL05WdUlES1ZuTXNCVEErSHlWTXEySDcwUWM3SG1KbEtaSVBz?=
 =?utf-8?B?MThEODd6YzZISW0xN0FMaXY5SWlhcG15VGFRVGNOdFpzLzI1Z0hBcDVRUEUw?=
 =?utf-8?B?a0NJUW1HNW9TRDE5NUQ0Z3VudXI0NTVCTnVTWUk2Z21zY1VxQ2xkRmUxVzZW?=
 =?utf-8?B?bjdHRTFYQnlqbnBrUkJmWlFNS1VPQ08vMDBjeFNtTmwxSXYydy9vVkF1eUQy?=
 =?utf-8?B?bFFFbU9BNDFuQmtmREdsN3V4akdZbHhvangzc1BKUVJkR2dVemJwUkNqQ3Nr?=
 =?utf-8?B?a3JoY1Y2QVAxN3BYcEVWRnk1ai9PdU8vUW1LbFFTa2dZeVlIYjE3aUQ4bTJN?=
 =?utf-8?B?NkR4QnpJKzB4TWtoUjlra1dqRVdaRWZOMitPdHpZb25lUEJiZ0lSeGxRVXFj?=
 =?utf-8?B?cjl4Qm11VWpNaXgrL24wZ21Sa3hMdmRSMzhmTFBaMWpoUEtRbnpOMUZjY1NI?=
 =?utf-8?B?OEhDL3hmamw2MG43eEhZQzl4dEcxV0FyRlBxc0ZudE85RE5pemxuOG1tV1Rx?=
 =?utf-8?B?MVJHRFREY2w2QU5lNUp6bVZ6VHVoVVVXc2NtL2NGSjhWREZTYjRqWWIwZWI2?=
 =?utf-8?B?TnhxeUVGSTdFNjdCaHY3Sk8xTFFzY1piZEtnSHgwWjNjZHFXZUtIZzJJOVNF?=
 =?utf-8?B?MW12cFhsNXhOZFpSMmpaUmJKem8wR05HZ3M5SktTeHpQVnZtVGVRdFcra1I3?=
 =?utf-8?Q?HY68xpnLsDxvho0YmLLxJTp+Z+rWcnpiNDYMGGU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a4eebb-f56d-426c-35b4-08d8d92b0aa9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 01:16:57.0973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: shDlqzQnDt3O7NLpGk5Zq0133HJ27OcCPy+2PPCPRk1jcS3qcnxHyhSE0SM/2WmnSnuPIV5fP4VRF25PHJ7WMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2993
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9905 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250006
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9905 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 clxscore=1011 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250006
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 25/02/2021 05:39, Eric Sandeen wrote:
> On 2/24/21 10:12 AM, Eric Sandeen wrote:
>> Last week I was curious to just see how btrfs is faring with RAID5 in
>> xfstests, so I set it up for a quick run with devices configured as:
> 
> Whoops this was supposed to cc: fstests, not fsdevel, sorry.
> 
> -Eric
> 
>> TEST_DEV=/dev/sdb1 # <--- this was a 3-disk "-d raid5" filesystem
>> SCRATCH_DEV_POOL="/dev/sdb2 /dev/sdb3 /dev/sdb4 /dev/sdb5 /dev/sdb6"
>>
>> and fired off ./check -g auto
>>
>> Every test after btrfs/124 fails, because that test btrfs/124 does this:
>>
>> # un-scan the btrfs devices
>> _btrfs_forget_or_module_reload
>>
>> and nothing re-scans devices after that, so every attempt to mount TEST_DEV
>> will fail:
>>
>>> devid 2 uuid e42cd5b8-2de6-4c85-ae51-74b61172051e is missing"
>>
>> Other btrfs tests seeme to have the same problem.
>>
>> If xfstest coverage on multi-device btrfs volumes is desired, it might be
>> a good idea for someone who understands the btrfs framework in xfstests
>> to fix this.

Eric,

  All our multi-device test-cases under tests/btrfs used the
  SCRATCH_DEV_POOL. Unless I am missing something, any idea if
  TEST_DEV can be made optional for test cases that don't need TEST_DEV?
  OR I don't understand how TEST_DEV is useful in some of these
  test-cases under tests/btrfs.

Thanks, Anand

>>
>> Thanks,
>> -Eric
>>

