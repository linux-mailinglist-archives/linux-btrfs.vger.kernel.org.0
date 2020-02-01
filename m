Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E31B114F7CC
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Feb 2020 13:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgBAMj1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 1 Feb 2020 07:39:27 -0500
Received: from m9a0013g.houston.softwaregrp.com ([15.124.64.91]:38187 "EHLO
        m9a0013g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726297AbgBAMj1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 1 Feb 2020 07:39:27 -0500
Received: FROM m9a0013g.houston.softwaregrp.com (15.121.0.191) BY m9a0013g.houston.softwaregrp.com WITH ESMTP;
 Sat,  1 Feb 2020 12:38:25 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Sat, 1 Feb 2020 12:38:52 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (15.124.8.11) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Sat, 1 Feb 2020 12:38:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhjI6m5d6IhJns8/IXqtWBId2VnfZOXQiyIV1XKxh13iNXwTsOWnCx3Nd+Tan4DVVYsKrFt3mWMM/dVBt4x2JMbUR2qBtv/uS3zzk9AV60QGJ6eivvSNlwy4UduM5yxHQHC0tBrMNFr/urCE2Xso1CxdlSnfbjFZeAFcKb+akEJRXZUsE9fZc5eOQvBmaN1zlBep1vXXhyQ+oR9MixWQv3bDX32RXsnDOjCSz37t3zV4N6cYc2a8Oed4Z7S7KYiCGzAuO5ML+k8VN2GjDVzI8haAaJbE2RMmZ7oZRfEVDWFzbenjVj0mv/FeiUq3ms+jtEwGGzQWqohk8AmMJaIE2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bv03XRyTTVwKW6IkvA7ZM5QQq4jGdSUhPQW6LQo9j7A=;
 b=IU+3bEYgUwqr7fDsN7TvR2iACZCZJqE0Ynxo0wf6itgDs/i5ohHPH5uYxPzDo5mAq7nnqG1NNAHVGsQh8eECFpDEeK3jrDbjFAHfia9LHTVaKohh5ZRlaS+gzAkkm+hhl4bk4aI1nlhdbzgJeMHC23IDamZ27n/fwGLO85j/JAGIEhaq/aUrQqayEz3LVCsrkG5UT+t76cSfydG4sxuiVlQi7cvYwZRBUoJI9+yuTvt7I6+3+KKvHHVGRKwBz20S8xAxQLmQWBW76XEl1Sf0WS1eRT89TM37tP7KujJbVC7T5Xkl9dJd1aSHXfAtMVg3J+2VVR3WbEdobUGM2qTgHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3363.namprd18.prod.outlook.com (10.255.139.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.26; Sat, 1 Feb 2020 12:38:49 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd%7]) with mapi id 15.20.2686.030; Sat, 1 Feb 2020
 12:38:48 +0000
Subject: Re: [PATCH] fstests: btrfs/153: Remove it from auto group
To:     Amir Goldstein <amir73il@gmail.com>, Eryu Guan <guaneryu@gmail.com>
CC:     fstests <fstests@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>
References: <20200114125044.21594-1-wqu@suse.com>
 <20200201073649.GA2697@desktop>
 <CAOQ4uxj_MFHrWthckSVUaHp3us2eNFeZRc_wuD90CxcUveYUTA@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0GFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPokBTQQTAQgAOAIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJdnDWhAAoJEMI9kfOhJf6oZgoH
 90uqoGyUh5UWtiT9zjUcvlMTCpd/QSgwagDuY+tEdVPaKlcnTNAvZKWSit8VuocjrOFbTLwb
 vZ43n5f/l/1QtwMgQei/RMY2XhW+totimzlHVuxVaIDwkF+zc+pUI6lDPnULZHS3mWhbVr9N
 vZAAYVV7GesyyFpZiNm7GLvLmtEdYbc9OnIAOZb3eKfY3mWEs0eU0MxikcZSOYy3EWY3JES7
 J9pFgBrCn4hF83tPH2sphh1GUFii+AUGBMY/dC6VgMKbCugg+u/dTZEcBXxD17m+UcbucB/k
 F2oxqZBEQrb5SogdIq7Y9dZdlf1m3GRRJTX7eWefZw10HhFhs1mwx7kBDQRZ1YGvAQgAqlPr
 YeBLMv3PAZ75YhQIwH6c4SNcB++hQ9TCT5gIQNw51+SQzkXIGgmzxMIS49cZcE4KXk/kHw5h
 ieQeQZa60BWVRNXwoRI4ib8okgDuMkD5Kz1WEyO149+BZ7HD4/yK0VFJGuvDJR8T7RZwB69u
 VSLjkuNZZmCmDcDzS0c/SJOg5nkxt1iTtgUETb1wNKV6yR9XzRkrEW/qShChyrS9fNN8e9c0
 MQsC4fsyz9Ylx1TOY/IF/c6rqYoEEfwnpdlz0uOM1nA1vK+wdKtXluCa79MdfaeD/dt76Kp/
 o6CAKLLcjU1Iwnkq1HSrYfY3HZWpvV9g84gPwxwxX0uXquHxLwARAQABiQE8BBgBCAAmAhsM
 FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2cNa4FCQlqTn8ACgkQwj2R86El/qhXBAf/eXLP
 HDNTkHRPxoDnwhscIHJDHlsszke25AFltJQ1adoaYCbsQVv4Mn5rQZ1Gon54IMdxBN3r/B08
 rGVPatIfkycMCShr+rFHPKnExhQ7Wr555fq+sQ1GOwOhr1xLEqAhBMp28u9m8hnkqL36v+AF
 hjTwRtS+tRMZfoG6n72xAj984l56G9NPfs/SOKl6HR0mCDXwJGZAOdtyRmqddi53SXi5N4H1
 jWX1xFshp7nIkRm6hEpISEWr/KKLbAiKKbP0ql5tP5PinJeIBlDv4g/0+aGoGg4dELTnfEVk
 jMC8cJ/LiIaR/OEOF9S2nSeTQoBmusTz+aqkbogvvYGam6uDYw==
Message-ID: <c3310387-da7b-3184-147f-67f00eed1aae@suse.com>
Date:   Sat, 1 Feb 2020 20:38:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
In-Reply-To: <CAOQ4uxj_MFHrWthckSVUaHp3us2eNFeZRc_wuD90CxcUveYUTA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ClientProxiedBy: BYAPR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::21) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by BYAPR02CA0008.namprd02.prod.outlook.com (2603:10b6:a02:ee::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.26 via Frontend Transport; Sat, 1 Feb 2020 12:38:46 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad3ff0d9-071e-4632-78cf-08d7a713af14
X-MS-TrafficTypeDiagnostic: BY5PR18MB3363:
X-Microsoft-Antispam-PRVS: <BY5PR18MB3363CCE46FA8FF88737504A7D6060@BY5PR18MB3363.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 03008837BD
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10001)(10019020)(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(189003)(199004)(16576012)(2906002)(316002)(5660300002)(956004)(54906003)(2616005)(110136005)(6706004)(66556008)(66476007)(66946007)(31686004)(36756003)(86362001)(478600001)(31696002)(53546011)(966005)(26005)(81156014)(52116002)(6666004)(186003)(16526019)(81166006)(4326008)(8936002)(6486002)(8676002)(78286006);DIR:OUT;SFP:1501;SCL:5;SRVR:BY5PR18MB3363;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVRVYnkrb29sSUgxclZ5QXVOZlZ4U1lmK2ZNVFZ2UkEyOTZ0dlQyTlVVaTF0?=
 =?utf-8?B?UnV6bUE1RUthSDVCWVhXZmhUU1kwOFRVSTg2RmRYZEIzc2VyNitTOHJSa25p?=
 =?utf-8?B?b0Fpd2t4QTdqdGErZmV0N0RFc2xrbEVuRlE5Szg3d3UwZ0JDQXNXUWhEc2dz?=
 =?utf-8?B?bXJrbHRabWlwdEQ5VkM4Vjd6MDI1ZEkrc0kvWW5rVVRWMVZYbXZvdTJPWHY2?=
 =?utf-8?B?ejg0ZGtsTFhHeVlKZXZlMFBZS3Z6bVhzd3pJUE8zOUhSbzV6TldBakx6NjJ0?=
 =?utf-8?B?RlVjRFlCSEo2ZUdEL094QTNMSzFtL25pRS9sSGhyY2hLQWlDMURDdVhVZ2Mz?=
 =?utf-8?B?RElIY0ppWGFVNnhHZDdlVGNOQWx5c2tLbGswWWxCZTY1MTFRVEhhRDNkckox?=
 =?utf-8?B?WENROGI2MXhadnZNcFNUYUlRRk9VQ0NaNFAzYW5uOHFyZlJXVmhSRGFwc3Bx?=
 =?utf-8?B?aFJKT2FySytjWnduZjNPNWVIOExtR3lPQkRDY1pUM00ydlFyeDlTazVldEhC?=
 =?utf-8?B?SUkzVkJqSW1oMHhYK0NWK0xVU1lES2dCU2RuY0RuaXoxcE84Q29IT3U4U1B3?=
 =?utf-8?B?YlZtMndoN2M3YjNGSmpjSzcxamV5NDl4VVJ3T3g5NTNSYlJ4WDJaZGd1bGVY?=
 =?utf-8?B?OFRHQUxLQ0IzRExCMmwzTU9KNFI4eEk4Mk1nYjlIWEtacisxMlpEZ0hnSnBo?=
 =?utf-8?B?Wlhod1Z3ZEZaTk94OWZLN1NYSEtZb29Cc05CUlhFbE0vMnR2Sm9GT01wVjJ5?=
 =?utf-8?B?aUtwSDVSYUFTZWVNclBkaS9QK0k2dkV3dlJ5eXZRM2hFeUdEVXVLZ0kwSjdi?=
 =?utf-8?B?NFhQL3BkVmZ6UFJQR2hlbzI3SjgzeDl2Snl3K2NCeVI1MmtTQzZ1cGRUOHhJ?=
 =?utf-8?B?N2pwakNjS3BJZ3d4b2Y4VEVOeERKSlRJZ1lUTzJPdm91T1c4ZGpHK2tBaGFp?=
 =?utf-8?B?VVhOdjdJbGZRYXRzMElWR3l6anJySys2RzFxNVZQcWxWdHErWkdyM3RkaElK?=
 =?utf-8?B?VkM1K012SXg1Z203RHU5b0xiTTIydFlhQjV4NkNGczByUG9xMmJ2QU5meWxt?=
 =?utf-8?B?RGlCQ3VCc2pkcTg2Z3dIT1lqekNrZkFvZTNCenJpL21RZGxEclJJTmV3VHZo?=
 =?utf-8?B?bHRVY1V4TWFSSGVLbHlUTzdqWWRycmMya1IranIzeXZHZkdjSDZvRDM4ZnJm?=
 =?utf-8?B?bStqU0EzMndUUDBoZ3lCU0srK1hGNmRMQkdReGE5TU1ZUDI1TjZQRkxJRlhM?=
 =?utf-8?B?c1VjR2lDMmlYb2I1MStMMmZpV2tRU3B5dmVYMDF0K3hjamlqVmFCUWVQNGhI?=
 =?utf-8?B?dkVSOEljWE1rSlhBZ1VxZldCSWh6RVpCK282WWk1M1dTSi9mcDFpd2dFY2tI?=
 =?utf-8?B?bVRQODBoMWROQkU3Smx0RS9ENEtxMHV0QkZSNVpYRXY0NlZVU1hTREhLQWY4?=
 =?utf-8?B?QmNxNTBSaytOQVA4ckFLNWttUUtuTlZ1alYxbFJvTWhJQzZPQjJFOFJ3Nmwx?=
 =?utf-8?Q?prft+k=3D?=
X-MS-Exchange-AntiSpam-MessageData: MZKXXjlFUGvqYWCbsWiNmNhdT944hxrPqZuVriOgqXSo0pKL6O+SeIHKFJgHVAxhXu2enUHNz//Cp4LPoNHnuYKPUvGfXg8NhgEyAZ4f2QFoGQt02edOQkTksYA0N33la6+klD1LAuqayZsdXv0lHg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3ff0d9-071e-4632-78cf-08d7a713af14
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2020 12:38:48.1885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NM15o5g1HoOqfcT46Zk8msBwmvQ1+Le9O8R8ZVFOQUWdMzikHNZ9rmdMMXTX/upR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3363
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/2/1 下午7:10, Amir Goldstein wrote:
> On Sat, Feb 1, 2020 at 9:41 AM Eryu Guan <guaneryu@gmail.com> wrote:
>>
>> On Tue, Jan 14, 2020 at 08:50:44PM +0800, Qu Wenruo wrote:
>>> This test case always fail after commit c6887cd11149 ("Btrfs: don't do
>>> nocow check unless we have to").
>>> As btrfs no longer checks nodatacow at buffered write time.
>>>
>>> That commits brings in a big performance enhancement, as that check is
>>> not cheap, but breaks qgroup, as write into preallocated space now needs
>>> extra space.
>>>
>>> There isn't yet a good solution (reverting that patch is not possible,
>>> and only check nodatacow for quota enabled case is very bug prune due to
>>> quite a lot code change).
>>>
>>> We may solve it using the new ticketed space reservation facility, but
>>> that won't come into fruit anytime soon.
>>>
>>> So let's just remove that test case from 'auto' group, but still keep
>>> the test case to inform we still have a lot of work to do.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>
>> I'd like to see an ACK from btrfs folks. Thanks!
>>
>> Eryu
>>
>>> ---
>>>  tests/btrfs/group | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tests/btrfs/group b/tests/btrfs/group
>>> index 697b6a38ea00..3c554a194742 100644
>>> --- a/tests/btrfs/group
>>> +++ b/tests/btrfs/group
>>> @@ -155,7 +155,7 @@
>>>  150 auto quick dangerous
>>>  151 auto quick volume
>>>  152 auto quick metadata qgroup send
>>> -153 auto quick qgroup limit
>>> +153 quick qgroup limit
> 
> Hmm, if removing from auto it might make sense to also remove it
> from quick, because people often use quick as a sanity regression group.

That's also one of my concern.

However recently I tend to run more same VMs on different ranges of
fstests to speed up the testing progress other than using 'quick' group.

Anyway this depends on the end users (QA and developers).

> 
> The issue at hand is a recurring pattern.
> It is also been discussed recently about generic/484:
> https://lore.kernel.org/fstests/20200131164619.GA13005@infradead.org/
> 
> I also handled something like this with:
> fdb69864 overlay/061: remove from auto and quick groups
> 
> I suggest adding a group 'broken' to mark known/wontfix issues
> then a default regression test could run -g auto -x broken
> or -g quick -x broken for a quick regression sanity.

That's much better.

Just one question, if a test is in both quick and broken group, will -g
quick -x broken still exclude it?

Thanks,
Qu

> 
> Thoughts?
> 
> Amir.
> 
