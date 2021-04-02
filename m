Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B4E35253A
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Apr 2021 03:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbhDBBkR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Apr 2021 21:40:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52608 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhDBBkQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Apr 2021 21:40:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1321dX2r083318;
        Fri, 2 Apr 2021 01:40:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=nsGYsEmNPXnVMXPnMbHBBAE9hhxFpK7teXxZoISJj3E=;
 b=ZGKVZ8jMiywqmlcktI/COQ6Z8DBPm7Kv0+34qhzwGGpi8elawGI2qHToEVMeATrqWwXr
 l5KAP0f4WiU5c8k+hOhza6L7gIAxCZ6l6ljnQewbkxX8eByviCbupJnR46aKK0bRPxtd
 Uh2SD3+yGY5wKmDsYKSDIaGFqpuIEDLX0GboF6Av9gDrBkIhKO9bQXKvcS6icC3sTRVy
 mD++HsaNyDDF8/jqnWhaGiwM3np9uALkF+n6SV1TrAK4tLOIbLwH6/HsrTwj8hHwklRm
 6ZP6fHhE7EiEnkCAOp17vP3CG4lepy5kzlB7KN9vFmbXywwqr8mdOFFqomGH4wGkhAXI 0Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 37n30sbg8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 01:40:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1321Ywhd035720;
        Fri, 2 Apr 2021 01:40:08 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by aserp3020.oracle.com with ESMTP id 37n2ac0462-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 01:40:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaoBOYEgXXH+Zm39iUpT0CXFdY6jEyfqhP32nS/pYWrEh7qA0iMDQoxtlYmoixtwUa36i0VpXJaS1pVbdrsexbgw8uuPXXCBJHwFra6bIVxZ8SSAgb5Bm6ShUeT7OkFUvdRSdZ4Tggp5dBiE5ehUY0zWCHfyJ3zvCC40W7wYuxUFCumUKYaqM7uTYUeeKRqUY4E3XdDE4/1lrnxpex2l0AIdnmYZLCutHGvz9XskC3NVxBwHD0m/qcon62TsMjTKoLeu8LDzgPwzTukI+qf9FDrAST4dxTY2Mi8x3WZCP8hBrqHshVuGBvfA66SbO0TJ5elCcMOmq3864mRNrsJ+5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsGYsEmNPXnVMXPnMbHBBAE9hhxFpK7teXxZoISJj3E=;
 b=TOM08DhV1e6nDXReHYaK6Tb5iY4O1GvGZz2pm+pwNg84AjYgIPUQGMvQ5NuI0XJuxlYd9PAhfidhkQbg9nDQnF67Pu+QLTQNXUjaABrdKsGnEs1KrJZPNKg8XS5rlVzYnCwQRWFqHPld9E4vZZEgxLkEWIkuGFwWofGPytCUaPJ9+3vk8C+Yn4q3pO3aSWYXPsknXidVWGpNnFdkZ0PR5NyVFjl5KWhFTHoJhVzFGqBm+tvfmCTTPZ1Ps7BVIaBB6bLPgqPghvE/iA6reTdroH7o9k6dn1D1l6E6EPdwg2J54elbPl7Q2CJ+y9BJIgEQTx7gcMaiyWgNsvbef+S/Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsGYsEmNPXnVMXPnMbHBBAE9hhxFpK7teXxZoISJj3E=;
 b=bKEnFYG1iHTZi1QOqOS0b7P4ILFkOqkOvSLo56puqERJuqZduiZb2DaJ4F4YSJRGAe6YKJKQQJELeygiF3a5b2ZA/7/+MBrQAEekDKRtYruo841R4GCZfA4cT972HcuvIqeK4zoncknhn/tCDKbaVYVj2s4GDNcuAmm/4KbTNRU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4285.namprd10.prod.outlook.com (2603:10b6:208:198::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Fri, 2 Apr
 2021 01:40:05 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::9aa:6ac:8d40:c076]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::9aa:6ac:8d40:c076%6]) with mapi id 15.20.3977.033; Fri, 2 Apr 2021
 01:40:04 +0000
Subject: Re: [PATCH v3 00/13] btrfs: support read-write for subpage metadata
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Neal Gompa <ngompa13@gmail.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>
References: <20210325071445.90896-1-wqu@suse.com>
 <CAEg-Je_Bx6Yu6JHB0XXjBt0+0Ox_=kAUAVWWZan1DsiqvybYrQ@mail.gmail.com>
 <bc0306b6-da2c-b8c1-a88d-f19004331765@gmx.com>
 <20210328200246.xz23dz5iba2qet7v@riteshh-domain>
 <12dca606-1895-90e0-8b48-6f4ccf8a8a27@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <663dec3c-96f8-3d46-561d-dcc2db7c47a7@oracle.com>
Date:   Fri, 2 Apr 2021 09:39:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <12dca606-1895-90e0-8b48-6f4ccf8a8a27@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2406:3003:2006:2288:d47a:f48:c77a:6201]
X-ClientProxiedBy: SG2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096::11) To
 MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:d47a:f48:c77a:6201] (2406:3003:2006:2288:d47a:f48:c77a:6201) by SG2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.0 via Frontend Transport; Fri, 2 Apr 2021 01:40:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22ba2e2e-dc75-479f-d42a-08d8f5783d56
X-MS-TrafficTypeDiagnostic: MN2PR10MB4285:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4285CC1A74E565D8DEC07BAFE57A9@MN2PR10MB4285.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ROL2SF9mqKGQSiiFBbErseIlxbvq8Md3P2/fSJ+HS8yUTtHjRCKLqYWm0BXDpAjg7M5xN36jBdJdHu6v34eivH4CWzpM6ycxZQMOIRoAe4otAhAoed1S8DNz8YreD1k3+jAUw82lQuzh/owg5f6ZQNV0EixrV7h80RXtnnes5mXy0TmPChW36WF+RrfmZhdZujXNO65MC122Hums8Ohn0V+yH/BxzORWGv7S79CaBMja3WlXr/4bnugQm4GUfxEL87QJj5EZwlRSUV3Y8DhT1ADNFRMdGfgFBH+qPulZT6a+dJrLt2ivJNhkYk6k0WAAM1hA0oOKx1DCAKv5KR11/JeTjCbZlo1me8QiBHUGLGCpJ91SHiUr6kvjDHl5366TBqaDg8cXBG1C9c6KUQhp+o5cx9HG/PhrZZXkp0ED/vW81YgiDByA4AtA7/f92wqQ/flxpW4o5DkxP93lWq3NCusjBMLquTwFbq5GgIGZ1uiJydOi9/QgJWZiBsjFMOPnFU/a1f9dqXTI2DlCUvQtifJQkPXmP5dPK+EPSMY1/2apIFNZs5lIYj+1iWz9Kig+hAzbTHF/cnMQ0RjqGo2pi/RNutPCg7gfO/x5zpTtcW3slnK75ie/f8KSHMDc9C8KJL3Kp4Is2CuHc3uAgfwS/7G68bMIDWEaRBLseeFAjbjxttIJhVKUS5ADTCzQNTAaXBzMYniP4DAxHhJ4nHqTmwrJR9Ra0drVO5JF6EplmcQmNepllx81OWBT3Ocw/66J+XaLCbRzW2IVoyPKz5vXLxLMe4+hR8dg+yJTZeHqIw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(136003)(346002)(376002)(66946007)(53546011)(36756003)(83380400001)(2616005)(4326008)(66556008)(16526019)(186003)(6666004)(86362001)(31686004)(478600001)(6486002)(6916009)(8676002)(8936002)(966005)(2906002)(31696002)(38100700001)(5660300002)(66476007)(316002)(44832011)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VFpqT3ZvblI0V0R2SGNZMFowTE1QUEh1QVkyQUhQQ2ZwMm5hajlpR1BjMHND?=
 =?utf-8?B?MC9XTmg0MHhVK0RnRldEK0R3L2VESVdBNlk1QTZuTHh0c0o2NTUzZGk5WW43?=
 =?utf-8?B?OGpWdTUzWFY5K3lOdDk5cmNSUnh2NXpDenVHY3pidjU1Qmhmelp5Y05UREpB?=
 =?utf-8?B?ZVV3Qmh1cWJHRzMwYTBpSk1RMWFEdXJNdzJTeFVSQktERXRYRktTeWdVQWJT?=
 =?utf-8?B?ZHdkSzlFVU12Mm1QWFI2TGorUFRpUHUxTmg1YmUxSGtUdjZTQ205TDNLYmZF?=
 =?utf-8?B?T2hKVWtyd1JHajdPQzZDM3pkZmhsUlBhdWZIVXpNZERoYTk3TGp3MXZqMDEy?=
 =?utf-8?B?TW9DSnYrdTRjQlQ0cksrT0NIeUhFalo3RTNuZUI5ck1YRTJleVoxMUpxemxG?=
 =?utf-8?B?VDZnRmpoTm5zRGVkRTk1Vm5RYXkxclY2aExWOHJWSE9QZGwzbnlhOXJLR1h6?=
 =?utf-8?B?NUJ2TlBtdlkwc2locGpyaVY0d3dEMlFQNFRBUlU2UUYzRUllQThkYUVZcnI2?=
 =?utf-8?B?MWwxb2lNamY3Ri9IN0ZhU25XYmNnbDlBY2RnNHZqYTJOWExraTcxWVNmbzNj?=
 =?utf-8?B?VTdZS2IycVp3VzJVRFZ0NkVZWEdrVE5jNHNpKzdxMC9zTjV2bEhRV1J6cWdV?=
 =?utf-8?B?MnhETGlkaWk5cXByNXVLZEtwSnlwQ2xBcG55U0lzRlUvUGtvc2k3a29VSUVa?=
 =?utf-8?B?WUJqWGZOVHVhb2VzeWRyYUxUVFJyaVJIUDZURkthcjN6cGJKMjRtM09CMXhj?=
 =?utf-8?B?d2FobFpOTTlOUGpReVBRZGJLNG9MY25oT0haemVwSlkveXlQbU5jbDBJU3h2?=
 =?utf-8?B?T1NaYnRtN1h0UnZoeHBmN0hJbStsZkdUZFJ3N0o4NUJ3RE8xZjQxL1VMRVlQ?=
 =?utf-8?B?L1VkWWxwcDhINDlTd1ZrV3JBcWhvNWR3a2doQ2QwbERFT0lsMGhqbUhaZTU4?=
 =?utf-8?B?c3VxOUtSUlJ5RUQ5WFR1b3hhN0Rqc280bytQMXRQZm82OVVhb2lpOVZZMzJp?=
 =?utf-8?B?R2gwVFlPb09vUFdoY2J5dVhVeGEwV1d6ZEZnd0dwRjN3YUhlMWphdGFnS1I2?=
 =?utf-8?B?VktJMURGb2Z2SkJheHpoQnlOWjZBY0tsY2syRmsrdmxJa3J1VHZnSkhmbG8w?=
 =?utf-8?B?OXlveE9sRUJLRHFjSkk5dEoxOHNZSE5YNkpGakh0K0pYOGVwa0RtZzExUkwx?=
 =?utf-8?B?VWo0dUxvdXNNbGtnQW5lalBaYW9yRWlxZHVsZUFQTEZzQXJaUXNHVmppSm43?=
 =?utf-8?B?OHdEK21HRzEvMi9jTitXc0Q3c3YySE1KWklLS2gzdSt5OHdSZUFDN05uNmo3?=
 =?utf-8?B?K25NR1VjSUJER01Gd3NMcE1IcVFOYmlhWWwyeWtaQ3MyUmRXSVVGRjZ5dlF6?=
 =?utf-8?B?NUxVdnpVKzE1NlJ5a1N2NTdEOVpVcTJXNmZ1VG95TDZYQ2M5Z3kzN3I3R2Fy?=
 =?utf-8?B?NUxwQ0t1M2EvRzBDTUYvcmpmSldhTzF3QlljUE1pNDR1cUtaTjNOVFovcmZj?=
 =?utf-8?B?UmtsazVXY2NWQVFJd2NCVU8rRVB3Q2dheXNTWVVxWXFSZEFqSjdoOEZ5elZ3?=
 =?utf-8?B?TENSN0FaVjhCRkxGSkI1MmpwWUxVSWp5SEFrVm50T2tTSjlXVHBwWGhsRGFY?=
 =?utf-8?B?R3BvOE9pQVJlM250UFUydkd4bzA4NWhiU2EzL09oeEVqbFREbG5qa2dDRktw?=
 =?utf-8?B?NFdTRkNMSC9Va0l4bEIyUkwrWEJGTUptRnB6NEZxYUNiang0QVBoUUFHT2Fn?=
 =?utf-8?B?RzlCS01TOTZNZHdVM0c2RFlTSG5obUpJaXFndVU1TTE4MTBLMzBnckVuM2xD?=
 =?utf-8?B?Rmd1SFkwK3JxMC95Zi9aY2RJb2VheUFDdHFKRkRZUGpXc2VNNS9FRXpHbFE2?=
 =?utf-8?Q?+qbTfJKkl0p86?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ba2e2e-dc75-479f-d42a-08d8f5783d56
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 01:40:04.8628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgoWUA3hwCDkcJM5U02/TN2HVc9kTIMlrB2oyg3CdcPHwlYC1Eh8DJIQd4jfbCg8dGvdA9BKCCSl2qWcQ0cprQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4285
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104020009
X-Proofpoint-GUID: AzPaevXaH-yacytHPeDCYO6j5AXhNoeK
X-Proofpoint-ORIG-GUID: AzPaevXaH-yacytHPeDCYO6j5AXhNoeK
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 spamscore=0
 clxscore=1011 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104020009
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/03/2021 10:01, Qu Wenruo wrote:
> 
> 
> On 2021/3/29 上午4:02, Ritesh Harjani wrote:
>> On 21/03/25 09:16PM, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/3/25 下午8:20, Neal Gompa wrote:
>>>> On Thu, Mar 25, 2021 at 3:17 AM Qu Wenruo <wqu@suse.com> wrote:
>>>>>
>>>>> This patchset can be fetched from the following github repo, along 
>>>>> with
>>>>> the full subpage RW support:
>>>>> https://github.com/adam900710/linux/tree/subpage
>>>>>
>>>>> This patchset is for metadata read write support.
>>>>>
>>>>> [FULL RW TEST]
>>>>> Since the data write path is not included in this patchset, we can't
>>>>> really test the patchset itself, but anyone can grab the patch from
>>>>> github repo and do fstests/generic tests.
>>>>>
>>>>> But at least the full RW patchset can pass -g generic/quick -x defrag
>>>>> for now.
>>>>>
>>>>> There are some known issues:
>>>>>
>>>>> - Defrag behavior change
>>>>>     Since current defrag is doing per-page defrag, to support subpage
>>>>>     defrag, we need some change in the loop.
>>>>>     E.g. if a page has both hole and regular extents in it, then 
>>>>> defrag
>>>>>     will rewrite the full 64K page.
>>>>>
>>>>>     Thus for now, defrag related failure is expected.
>>>>>     But this should only cause behavior difference, no crash nor 
>>>>> hangis
>>>>>     expected.
>>>>>
>>>>> - No compression support yet
>>>>>     There are at least 2 known bugs if forcing compression for subpage
>>>>>     * Some hard coded PAGE_SIZE screwing up space rsv
>>>>>     * Subpage ASSERT() triggered
>>>>>       This is because some compression code is unlocking 
>>>>> locked_page by
>>>>>       calling extent_clear_unlock_delalloc() with locked_page == NULL.
>>>>>     So for now compression is also disabled.
>>>>>
>>>>> - Inode nbytes mismatch
>>>>>     Still debugging.
>>>>>     The fastest way to trigger is fsx using the following parameters:
>>>>>
>>>>>       fsx -l 262144 -o 65536 -S 30073 -N 256 -R -W $mnt/file > 
>>>>> /tmp/fsx
>>>>>
>>>>>     Which would cause inode nbytes differs from expected value and
>>>>>     triggers btrfs check error.
>>>>>
>>>>> [DIFFERENCE AGAINST REGULAR SECTORSIZE]
>>>>> The metadata part in fact has more new code than data part, as it has
>>>>> some different behaviors compared to the regular sector size handling:
>>>>>
>>>>> - No more page locking
>>>>>     Now metadata read/write relies on extent io tree locking, other 
>>>>> than
>>>>>     page locking.
>>>>>     This is to allow behaviors like read lock one eb while also try to
>>>>>     read lock another eb in the same page.
>>>>>     We can't rely on page lock as now we have multiple extent 
>>>>> buffersin
>>>>>     the same page.
>>>>>
>>>>> - Page status update
>>>>>     Now we use subpage wrappers to handle page status update.
>>>>>
>>>>> - How to submit dirty extent buffers
>>>>>     Instead of just grabbing extent buffer from page::private, we 
>>>>> need to
>>>>>     iterate all dirty extent buffers in the page and submit them.
>>>>>
>>>>> [CHANGELOG]
>>>>> v2:
>>>>> - Rebased to latest misc-next
>>>>>     No conflicts at all.
>>>>>
>>>>> - Add new sysfs interface to grab supported RO/RW sectorsize
>>>>>     This will allow mkfs.btrfs to detect unmountable fs better.
>>>>>
>>>>> - Use newer naming schema for each patch
>>>>>     No more "extent_io:" or "inode:" schema anymore.
>>>>>
>>>>> - Move two pure cleanups to the series
>>>>>     Patch 2~3, originally in RW part.
>>>>>
>>>>> - Fix one uninitialized variable
>>>>>     Patch 6.
>>>>>
>>>>> v3:
>>>>> - Rename the sysfs to supported_sectorsizes
>>>>>
>>>>> - Rebased to latest misc-next branch
>>>>>     This removes 2 cleanup patches.
>>>>>
>>>>> - Add new overview comment for subpage metadata
>>>>>
>>>>> Qu Wenruo (13):
>>>>>     btrfs: add sysfs interface for supported sectorsize
>>>>>     btrfs: use min() to replace open-code in btrfs_invalidatepage()
>>>>>     btrfs: remove unnecessary variable shadowing in 
>>>>> btrfs_invalidatepage()
>>>>>     btrfs: refactor how we iterate ordered extent in
>>>>>       btrfs_invalidatepage()
>>>>>     btrfs: introduce helpers for subpage dirty status
>>>>>     btrfs: introduce helpers for subpage writeback status
>>>>>     btrfs: allow btree_set_page_dirty() to do more sanity check on 
>>>>> subpage
>>>>>       metadata
>>>>>     btrfs: support subpage metadata csum calculation at write time
>>>>>     btrfs: make alloc_extent_buffer() check subpage dirty bitmap
>>>>>     btrfs: make the page uptodate assert to be subpage compatible
>>>>>     btrfs: make set/clear_extent_buffer_dirty() to be subpage 
>>>>> compatible
>>>>>     btrfs: make set_btree_ioerr() accept extent buffer and to be 
>>>>> subpage
>>>>>       compatible
>>>>>     btrfs: add subpage overview comments
>>>>>
>>>>>    fs/btrfs/disk-io.c   | 143 
>>>>> ++++++++++++++++++++++++++++++++++---------
>>>>>    fs/btrfs/extent_io.c | 127 ++++++++++++++++++++++++++++----------
>>>>>    fs/btrfs/inode.c     | 128 ++++++++++++++++++++++----------------
>>>>>    fs/btrfs/subpage.c   | 127 ++++++++++++++++++++++++++++++++++++++
>>>>>    fs/btrfs/subpage.h   |  17 +++++
>>>>>    fs/btrfs/sysfs.c     |  15 +++++
>>>>>    6 files changed, 441 insertions(+), 116 deletions(-)
>>>>>
>>>>> -- 
>>>>> 2.30.1
>>>>>
>>>>
>>>> Why wouldn't we just integrate full read-write support with the
>>>> caveats as described now? It seems to be relatively reasonable to do
>>>> that, and this patch set is essentially unusable without the rest of
>>>> it that does enable full read-write support.
>>>
>>> The metadata part is much more stable than data path (almost not touched
>>> for several months), and the metadata part already has some difference
>>> in its behavior, which needs review.
>>>
>>> You point makes some sense, but I still don't believe pushing a super
>>> large patchset does any help for the review.
>>>
>>> If you want to test, you can grab the branch from the github repo.
>>> If you want to review, the mails are all here for review.
>>>
>>> In fact, we used to have subpage support sent as a big patchset from IBM
>>> guys, but the result is only some preparation patches get merged, and
>>> nothing more.
>>>
>>> Using this multi-series method, we're already doing better work and
>>> received more testing (to ensure regular sectorsize is not affected at
>>> least).
>>
>> Hi Qu Wenruo,
>>
>> Sorry about chiming in late on this. I don't have any strong objection 
>> on either
>> approach. Although sometime back when I tested your RW support git 
>> tree on
>> Power, the unmount patch itself was crashing. I didn't debug it that time
>> (this was a month back or so), so I also didn't bother testing 
>> xfstests on Power.
>>
>> But we do have an interest in making sure this patch series work on bs 
>> <ps
>> on Power platform. I can try helping with testing, reviewing (to best 
>> ofmy
>> knowledge) and fixing anything is possible :)
> 
> That's great!
> 
> One of my biggest problem here is, I don't have good enough testing
> environment.
> 
> Although SUSE has internal clouds for ARM64/PPC64, but due to the
> f**king Great Firewall, it's super slow to access, no to mention doing
> proper debugging.
> 
> Currently I'm using two ARM SBCs, RK3399 and A311D based, to do the test.
> But their computing power is far from ideal, only generic/quick can
> finish in hours.
> 
> Thus real world Power could definitely help.
>>
>> Let me try and pull your tree and test it on Power. Please let me know 
>> if there
>> is anything needs to be taken care apart from your github tree and 
>> btrfs-progs
>> branch with bs < ps support.
> 
> If you're going to test the branch, here are some small notes:
> 
> - Need to use latest btrfs-progs
>   As it fixes a false alert on crossing 64K page boundary.
> 
> - Need to slightly modify btrfs-progs to avoid false alerts
>   For subpage case, mkfs.btrfs will output a warning, but that warning
>   is outputted into stderr, which will screw up generic test groups.
>   It's recommended to apply the following diff:
> 
> diff --git a/common/fsfeatures.c b/common/fsfeatures.c
> index 569208a9..21976554 100644
> --- a/common/fsfeatures.c
> +++ b/common/fsfeatures.c
> @@ -341,8 +341,8 @@ int btrfs_check_sectorsize(u32 sectorsize)
>                 return -EINVAL;
>         }
>         if (page_size != sectorsize)
> -               warning(
> -"the filesystem may not be mountable, sectorsize %u doesn't match page
> size %u",
> +               printf(
> +"the filesystem may not be mountable, sectorsize %u doesn't match page
> size %u\n",
>                         sectorsize, page_size);
>         return 0;
> }
> 


> - Xfstest/btrfs group will crash at btrfs/143
>   Still investigating, but you can ignore btrfs group for now.
> 
> - Very rare hang
>   There is a very low change to hang, with "bad ordered accounting"
>   dmesg.
>   If you can hit, please let me know.
>   I had something idea to fix it, but not yet in the branch.
> 
> - btrfs inode nbytes mismatch
>   Investigating, as it will make btrfs-check to report error.
> 
> The last two bugs are the final show blocker, I'll give you extra
> updates when those are fixed.

  I am running the tests on aarch64 here. Are fixes for these known
  issues posted in the ML? I can't see them yet.

Thanks, Anand


> Thanks,
> Qu
> 
>>
>> -ritesh
>>
>>

