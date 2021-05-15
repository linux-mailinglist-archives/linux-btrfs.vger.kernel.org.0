Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95435381785
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 May 2021 12:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbhEOKQa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 May 2021 06:16:30 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:42845 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231222AbhEOKQ3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 May 2021 06:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1621073715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Zj2ksN5Q7sQ3mgl7Cr5gHGyqV/hyuOl+DxaUTZyf6w=;
        b=nImXIgEX7tgKQxrIU64QJSCV1UzqqfaXd0iP8hBg1k7a8+B2rWMxNOawZtA88IaiZjR3/C
        iLMy/ZkfqspNu0A3XCZxYLFalXVvEe7yUcSAhkKwK+rQfaYGjQ+BKvmxtGVNqrm+jhLmnI
        67wzneKSSOp0Pb+UDR38ypJcofvrw4g=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2169.outbound.protection.outlook.com [104.47.17.169])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-36-kDPI0P1uOoS5BcL8P_f4bw-1; Sat, 15 May 2021 12:15:14 +0200
X-MC-Unique: kDPI0P1uOoS5BcL8P_f4bw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dC462ISJ6/hzlkWDW++Ci357exAvfuALs5DL7hMRg2MRP8PtnkUipv54IL4Ks2CZoG84bNOHyuGKQ0BEo+os+tSHaYy3GNsbRK9md5tHSEioLx3w8bDvPFoFVpJguMwv0/mu1O66AALJQvsym6mk2xYsjZkjgH7p+nBh7/U5j82zenEJr6VYi9SgKhTJto0EYXd+XVvUeqrv6LlOhNo2EkBc5WoQVzu+SX5n2tNbxTwfM5Du7gfZrC14ox9J64Xw9NVKDcBoHyl7z6O81jokHhVbH/A/vGYBYLQtuNc3Nvab3BMsQOMMv6M+H/eSoSPM+qerGYLpboWAX+EROomOhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Zj2ksN5Q7sQ3mgl7Cr5gHGyqV/hyuOl+DxaUTZyf6w=;
 b=hWMVqcp4ZP2VOHS9h9p/hTzMwThxxCnQ3FkGhy7se5TibVhA0648uWGrD5OhISsvCj/NnoikHFCcg2MTWaBBX66AUCuJqz3mgObfW4v8nrDsVeGCXGLsKg+EjKtjveT24cSRo5AWawxb2PE3JRmzeqOEjq7AkCqKWsMba5cNb9gt7uwcaiHBDPa4QK+SKLl05lso9PDyMjtURWTZIpanw3mpkUgkEk2P063E/+9NOAxkeNZQxuABIxagx9GSW8zjWvkFueupWIQsHi9wotKImeEjuacXPSM442P5q8CWlbhqKqpy5ZLex2WB23uZs1icJnGsM6E4aWcRJj3vWQmvDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR0402MB3558.eurprd04.prod.outlook.com (2603:10a6:209:7::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Sat, 15 May
 2021 10:15:12 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb%7]) with mapi id 15.20.4129.028; Sat, 15 May 2021
 10:15:12 +0000
To:     Ritesh Harjani <riteshh@linux.ibm.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20210511104809.evndsdckwhmonyyl@riteshh-domain>
 <334a5fdd-28ee-4163-456c-adc4b2276d08@gmx.com>
 <fae358ed-8d14-8e14-2dc3-173637ec5e87@gmx.com>
 <20210512070931.p5hipe3ov45vqzjt@riteshh-domain>
 <20210513163316.ypvh3ppsrmxg7dit@riteshh-domain>
 <20210513213656.2poyhssr4wzq65s4@riteshh-domain>
 <5f1d41d2-c7bc-ceb7-be4c-714d6731a296@gmx.com>
 <20210514150831.trfaihcy2ryp35uh@riteshh-domain>
 <20210514175343.v32k2rmsfl5l2qfa@riteshh-domain>
 <80735b91-ad23-1b49-20bb-fd3a09957793@gmx.com>
 <20210515095906.ifmqf36t2jup7tzw@riteshh-domain>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [Patch v2 41/42] btrfs: fix the use-after-free bug in writeback
 subpage helper
Message-ID: <51186fd5-af02-2be6-3ba3-426082852665@suse.com>
Date:   Sat, 15 May 2021 18:15:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210515095906.ifmqf36t2jup7tzw@riteshh-domain>
Content-Type: multipart/mixed;
 boundary="------------D781700E7C5F19217569F4AA"
Content-Language: en-US
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BYAPR01CA0059.prod.exchangelabs.com (2603:10b6:a03:94::36)
 To AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR01CA0059.prod.exchangelabs.com (2603:10b6:a03:94::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Sat, 15 May 2021 10:15:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 288d4f50-67f5-4e99-300d-08d9178a535c
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3558:
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3558F98C732B35DFC8D3D731D62F9@AM6PR0402MB3558.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 06j/u7tBmstwOS45IsMh+2hRgGHLWCRzOxmKExjd9jX1lrbbgDRSSWQP9VPAhC0UQcDnog0XVBUKh3tnnhBTpTQEoJ8AvQnpQHlnNo2IpChvqA7RH23MCeKiTYs3rLV7Xop6ZHy797NwYGq5IRlBogrtvR0otidOg9DsXtnxUj2KQ+LvDSTajxTeNldg7vs8r4rTplYAREXzg7AxrU+LRA/UdxeOoZKefn2iOmuB98x8w6ZW0mLrMeYAZq3wP3+qEiScwMHWAwAClQbiC0PvNPKNR8k+5qyFemCtFDKj66CQ8tLMwXXI8zuqAed88lJ9pkMW6cbGe/JkPggaMjtt631WRO2XCVZzkv/0j6+n9OPxkeDxWhf+fpQ4jJMPfu8jPQB8r6pq11X55WvRNGodAysIxucBCVT4PIeK4G68GJ+wQDGJW8cCJVKFIL0U9sXppmuu3lrACT1YKh4v7GOln3pUkUKU/AsrAZ6k+6n12xIrj8kMeCz9Aquvd6P/RxrG0+0qTeY88rLHbW3GaTN87Bz6P3ZbxfRqc7PIGWhSVwl8XGple87or0oqkR2GtXMxYjznOP89RwUre9lQBK1wk15DU2vOMGu2GH+SwemqQJeBu4yb5x+iqjAUmRwquwrHOdB4FXVpcfGlRCwF9Ikk8DU6k6hoJUlGFF6FD+N9/sB9tf05ttJr9idrbkIdAe2/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(376002)(396003)(346002)(366004)(136003)(16526019)(956004)(31696002)(5660300002)(6706004)(186003)(110136005)(316002)(235185007)(8936002)(4326008)(66946007)(86362001)(66616009)(2906002)(8676002)(38100700002)(66476007)(478600001)(66556008)(33964004)(83380400001)(26005)(6666004)(31686004)(36756003)(6486002)(2616005)(16576012)(21314003)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?S3dKVnU4U2Y0TUk0elBQS2dsL0ZxeTBSMXg0V2RTNCtFaUJsLzdxQ2QrZFNj?=
 =?utf-8?B?KzM4czRYaDNuaWRONDVDY1NUUTk1d1BJaGFGSVBUS29OemJOWHdnSnhHSDM5?=
 =?utf-8?B?WFJuOHdvQXo2L3hEejFpOEFJcG4vZU9pMFZRRWNIUDJrRGUvcUZKaTdnNkk3?=
 =?utf-8?B?em5XNTM5NFcxWFpUVFd4cUZZNU9hbVl5MDBJYjhOd1REdDA5djZpc0dUcVBz?=
 =?utf-8?B?VUhxQzlQNnpja3hIRXZBYjI2UlRVLzRkMkhzS3dtZzczWUlqSUZJcDg5aE9v?=
 =?utf-8?B?VmtXK2VoT0RUbUcrbnVHZjlWa24rb1JaN2REeU96aFVvbHc3RGFwclBCek5C?=
 =?utf-8?B?V2toM1BubW1BYlF4VzZENGg3VmYxZ3RNb2NDYmtNVWZVckw3Q1RJNHNBeENH?=
 =?utf-8?B?OUVzV1ZidFZkRE1PbWVTMFhIMmpsZmNMMjA0TlBRb1pHdGFsR0E0U3Y5ZUwy?=
 =?utf-8?B?eFVnd29HN2FCOUxpWTdERGZVVnJSM2VjNGVoVWlJTXZobU45SUZlSEszMjN0?=
 =?utf-8?B?RXJDM05YNTAxb2xHa3g3YlliY25wc0dSQzNpa1plcDNjS3pMeVJWbzliQnVF?=
 =?utf-8?B?dXhUb0R6MmgyTk52N1NwMmtHUUU5QmI3MjM5eE5EbXBhNGQ4YW9MRFhaNmwr?=
 =?utf-8?B?TUtMcW1lWnhzUHNMZDNoUGU1WEIzemJsbExvL3ZKR2w5NGN5N3JTVFI3bFhD?=
 =?utf-8?B?c2pTaWJkdE1RSTZ2MGRnZkNIa2xCa2N5NlZVcFNTM2ZsL0ZzdDBRM2k2QlBl?=
 =?utf-8?B?MVg1eWU5UGZlWU1WVXN1ODhreStINU0rQ0ljcVJqcGtGOGx0UG4yZGdsWDdP?=
 =?utf-8?B?MzR6L1QxVUF6UEpiQWFjY2trL1lWYnVqcGpaaWlGejVXTDJ5d2RjRVFqNmxt?=
 =?utf-8?B?emJ0K1llY0UxVGYyRGxIRE5VT05SbGZhaWVNWURsNGtKSzdSRm1WNzNKQkZm?=
 =?utf-8?B?QnV1WDU4NEZyeEh0WVB6TnpKeHpUMWxSWHFHSHl6aW5WSEhXcEJ5RjRZbXBn?=
 =?utf-8?B?NjBhZS9nTi9EVFJqUlhRNnA4ZTlXTGZNUHdqTXNVaFJ1RU1qSEtEVTNpbDJQ?=
 =?utf-8?B?NjFzZFc4TVZmdjN4NlU4YktsSVNpQWJzSHZtTS9EVGtvNWdKL2EraHJKSDBa?=
 =?utf-8?B?T2JBL3h5V3hzVWlUM1dUdDJJUnlJRkNMSXhVMUFQRVdQZTRGVFZadWl6dytw?=
 =?utf-8?B?NWp1aTBmZUpKYmVVZzVtL0FmZXFhOU5wdXk1bEowUFRGWG4weVRhYjFYaC8w?=
 =?utf-8?B?WmljRnFhcXNINmNQRmNrOVRDK3pZSDBDUlQ4MVhhMDZVZHpZc0xFbnVWdlI0?=
 =?utf-8?B?czlTSlFVMUJXNFNudG5Ib25ScG41VFBmZ05TbXI0YkJPdmh2ZWc3RkFBQVNx?=
 =?utf-8?B?eVJ2Q3hkQ3VrWVFSS0tsM05nOUZXa3dBTjR4dGhHeUFCL2MwYWJSNXMxS1dl?=
 =?utf-8?B?NlN1WllnZE8zd05jc1UwTXlTdlcvTHdXSGFuTHVXUHRLQ0hKTkJ1ME9uUXB2?=
 =?utf-8?B?K2RDYWgyY2krUnpuZkt2enl1MngwZk0xQit5Mm9sV3YvaGxacDdWN1EvS0ZI?=
 =?utf-8?B?N2JUTTZCM1BLNXRYVVJ2enlQK3VaS0VXbkpZSUtnZ1lLc1hzSzNGMEtvdTQ3?=
 =?utf-8?B?SDdKaUVZamZqVXNDY2xKa3JxY3M0R0lLcW9FQ2oxZlBBZ3R6aDEvNWs0RGs3?=
 =?utf-8?B?bDB0Rmp5SXBMNGVtYUNNSVd5Sis1U1NjZGU5d1pvakxSM3pHaEhYNXcxVGRC?=
 =?utf-8?Q?8nsqRguM3+kI9YTyLPc+VePoT4DOXNnmSEEyTpW?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 288d4f50-67f5-4e99-300d-08d9178a535c
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2021 10:15:12.2436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /qtW7zzxzKGXAhxNBkG31bRUakX8RBgSzeP7qficuQ2uW3hi58I5fsH1ZTiiGNfh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3558
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--------------D781700E7C5F19217569F4AA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2021/5/15 下午5:59, Ritesh Harjani wrote:
> On 21/05/15 06:22AM, Qu Wenruo wrote:
>>
>>
>>>
>>> Hi Qu,
>>>
>>> Thanks for pointing this out. I could see that w/o your new fix I could
>>> reproduce the BUG_ON() crash. But with your patch the test btrfs/195 still
>>> fails.  I guess that is expected right, since
>>> "RAID5/6 is not supported yet for sectorsize 4096 with page size 65536"?
>>>
>>> Is my understanding correct?
>>
>> Yep, the test is still going to fail, as we reject such convert.
>>
>> There are tons of other btrfs tests that fails due to the same reason.
>>
>> Some of them can be avoided using "BTRFS_PROFILE_CONFIGS" environment
>> variant to avoid raid5/6, but not all.
>>
>> Thus I'm going to update those tests to use that variant to make it
>> easier to rule out certain profiles.
> 
> Hello Qu,
> 
> Sorry to bother you again. While running your latest full patch series, I found
> below two failures, no crashes though :)
> Could you please take a look at it.
> 
> 1. btrfs/141 failure.
> xfstests.global-btrfs/4k.btrfs/141
> Error Details
> - output mismatch (see /results/btrfs/results-4k/btrfs/141.out.bad)

Strangely, it passes locally.

> 
> Standard Output
> step 1......mkfs.btrfs
> step 2......corrupt file extent
> Filesystem type is: 9123683e
> File size of /vdc/foobar is 131072 (32 blocks of 4096 bytes)
>   ext:     logical_offset:        physical_offset: length:   expected: flags:
>     0:        0..      31:      33632..     33663:     32:             last,eof
> /vdc/foobar: 1 extent found
>   corrupt stripe #1, devid 2 devpath /dev/vdi physical 116785152
> step 3......repair the bad copy
> 
> 
> Standard Error
> --- tests/btrfs/141.out	2021-04-24 07:27:39.000000000 +0000
> +++ /results/btrfs/results-4k/btrfs/141.out.bad	2021-05-14 18:46:23.720000000 +0000
> @@ -1,37 +1,37 @@
>   QA output created by 141
>   wrote 131072/131072 bytes
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
>   read 512/512 bytes
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

The output means the bad copy is not repaired, which is pretty strange.
Since my latest work is to make the read repair work in 4K size.

Mind to test the attached script? (Of coures, you need to change the 
$dev and $mnt according to your environment)

It would do the same work as btrfs/141, but using scrub to make sure 
every thing is correct.

Locally, I haven't yet hit a failure for btrfs/141 yet.

> 
> 
> 2. btrfs/124 failure.
> 
> I guess below could be due to small size of the device?
> 
> xfstests.global-btrfs/4k.btrfs/124
> Error Details
> - output mismatch (see /results/btrfs/results-4k/btrfs/124.out.bad)

Again passes locally.

But accroding to your fs, I notice several unbalanced disk usage:

# /usr/local/bin/btrfs filesystem show
Label: none  uuid: fbb48eb6-25c7-4800-8656-503c1e502d85
	Total devices 2 FS bytes used 32.00KiB
	devid    1 size 5.00GiB used 622.38MiB path /dev/vdc
	devid    2 size 2.00GiB used 622.38MiB path /dev/vdi

Label: none  uuid: d3c4fb09-eea2-4dea-8187-b13e97f4ad5c
	Total devices 4 FS bytes used 379.12MiB
	devid    1 size 5.00GiB used 8.00MiB path /dev/vdb
	devid    3 size 20.00GiB used 264.00MiB path /dev/vde
	devid    4 size 20.00GiB used 1.26GiB path /dev/vdf

We had reports about btrfs doing poor work when handling unbalanced disk 
sizes.
I had a purpose to fix it, with a little better calcuation, but still 
not yet perfect.

Thus would you mind to check if the test pass when all the disks in 
SCRATCH_DEV_POOL are in the same size?

Of course we need to fix the problem of ENOSPC for unbalanced disks, but 
that's a common problem and not exacly related to subpage.
I should take some time to refresh the unbalanced disk usage patches soon.

Thanksm
Qu

[...]
> 
> -ritesh
> 

--------------D781700E7C5F19217569F4AA
Content-Type: application/x-shellscript;
 name="repair.sh"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="repair.sh"

IyEvYmluL2Jhc2gKZGV2PSIvZGV2L2FybV9udm1lL3Rlc3QiCm1udD0iL21udC9idHJmcyIKZnN4
PSIvaG9tZS9hZGFtL3hmc3Rlc3RzLWRldi9sdHAvZnN4IgoKbnJfbG9vcHM9MQp1bW91bnQgJGRl
diAmPiAvZGV2L251bGwKdW1vdW50ICRtbnQgJj4gL2Rldi9udWxsCgojZWNobyAyNTYgPiAvc3lz
L2tlcm5lbC9kZWJ1Zy90cmFjaW5nL2J1ZmZlcl9zaXplX2tiCiNlY2hvIHN0YWNrdHJhY2UgPiAv
c3lzL2tlcm5lbC9kZWJ1Zy90cmFjaW5nL3RyYWNlX29wdGlvbnMKcm1tb2QgYnRyZnMKaW5zbW9k
IC9ob21lL2FkYW0vbGludXgvZnMvYnRyZnMvYnRyZnMua28Kc3luYwoKX2ZhaWwoKQp7CgllY2hv
ICIhISEgZmFpbGVkICEhISIKCWV4aXQgMQp9Cgp3b3JrbG9hZCgpCnsKCWRtZXNnIC1DCgl0cmFj
ZS1jbWQgY2xlYXIKCW1rZnMuYnRyZnMgLWYgJGRldiAtZCBEVVAgLW0gRFVQIC1zIDRrCgltb3Vu
dCAkZGV2IC1vIG5vc3BhY2VfY2FjaGUgJG1udAoJeGZzX2lvIC1mIC1jICJwd3JpdGUgLVMgMHhj
ZCAwIDEySyIgJG1udC9maWxlCgl1bW91bnQgJG1udAoJeGZzX2lvIC1jICJwd3JpdGUgLVMgMHgw
MCA1NzU2NjgyMjQgNGsiICRkZXYKCXhmc19pbyAtYyAicHdyaXRlIC1TIDB4MDAgMTY0OTQxNDE0
NCA0ayIgJGRldgoJbW91bnQgJGRldiAtbyBub3NwYWNlX2NhY2hlICRtbnQKCWNhdCAkbW50L2Zp
bGUgPiAvZGV2L251bGwKCWJ0cmZzIHNjcnViIHN0YXJ0IC1CICRtbnQKCSNidHJmcyBzY3J1YiBz
dGFydCAtQiAkbW50Cgl1bW91bnQgJG1udAoJY3AgL3N5cy9rZXJuZWwvZGVidWcvdHJhY2luZy90
cmFjZSAvdG1wCn0KCmZvciAoKCBpID0gMDsgaSA8ICRucl9sb29wczsgaSsrICkpCmRvCgllY2hv
ICI9PT0gJGkgLyAkbnJfbG9vcHMgPT09IgoJd29ya2xvYWQKZG9uZQo=

--------------D781700E7C5F19217569F4AA--

