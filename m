Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 795CE15A9A2
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 14:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbgBLNDq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 12 Feb 2020 08:03:46 -0500
Received: from m4a0072g.houston.softwaregrp.com ([15.124.2.130]:51864 "EHLO
        m4a0072g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725887AbgBLNDq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 08:03:46 -0500
Received: FROM m4a0072g.houston.softwaregrp.com (15.120.17.146) BY m4a0072g.houston.softwaregrp.com WITH ESMTP;
 Wed, 12 Feb 2020 13:02:47 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 12 Feb 2020 13:00:48 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (15.124.72.11) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 12 Feb 2020 13:00:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AsHbHerGFpgm7SnaaaeqR92BpQ5ZyfgpgVtpa1Od6IsqwmzIZSrD0Juhv2mYwbRxDUHI6u8goMoSRFmPN3iwW5PGQORj+NBc8qWe6dpHwT6pXf4jMB0w64tr3sabP0xCqoD8y64mUY1E6gdnbJcoqM1ep54QwFwXSUNv2Zy0AqwQ4Mo0cRbdcGcem5ynnOj4dl96ra54+8lmJkWOpeN2EVzayJ6ZZBSRU2LHkliVnB7DdiJbMqA9xMtc68KGZ7b8BHSqYwTf3YOaZs7bW/FzKM1yAiBiR+iiR2uma311T6VEoqgHYyQKg8PXFSOeL7TRIYCbcjLSCOkQqEEENWRIFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8uJQ67NmcuIKiGk9iT6/sU/yYoJYQHtHxt+uF/uT70=;
 b=apqzND9QfaQkHhcikcD5NhCs8FZfdHQ9FOL7ws0UZvHGHeL486jjGP5b5dEils8ezO+g2p+EUYiux9sZbeYk0ArTgtPS8C/aU48krCPcw+EPXmkMXjhORBdyiEiViekhbT/HRBlFfQKzpt4VlCBnFJrapp49HHepYnJ9l7+ehGiLE49McaB/xsaFh/NL9UON/o5dnuut27nNJawBwn+mXfUhjGePVhd14vjObJLAj1Z/XxETIdHp11XHnwbCjKJmsvcqtn/RqLS7I/SV5XTHUNWjvayT8MoDrPQx+XOO3QzW/rTO+JOuXr9Ktqq3IgudVwTRbfRVYn2kN8MxUztFLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3412.namprd18.prod.outlook.com (10.255.136.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 12 Feb 2020 13:00:46 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd%7]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 13:00:46 +0000
Subject: Re: [PATCH] btrfs: Only require sector size alignment for parent eb
 bytenr
To:     Josef Bacik <josef@toxicpanda.com>, <linux-btrfs@vger.kernel.org>
References: <20200212053040.23221-1-wqu@suse.com>
 <9d4bfc49-f914-aa2f-2809-a65a267917a4@toxicpanda.com>
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
Message-ID: <32ea7f20-0b96-66dc-fa37-4a8576562cea@suse.com>
Date:   Wed, 12 Feb 2020 21:00:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
In-Reply-To: <9d4bfc49-f914-aa2f-2809-a65a267917a4@toxicpanda.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ClientProxiedBy: BYAPR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::15) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by BYAPR02CA0002.namprd02.prod.outlook.com (2603:10b6:a02:ee::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend Transport; Wed, 12 Feb 2020 13:00:45 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f17b9cf-62da-4bcb-565a-08d7afbb9356
X-MS-TrafficTypeDiagnostic: BY5PR18MB3412:
X-Microsoft-Antispam-PRVS: <BY5PR18MB34126701D4EE7FB73B2CEA50D61B0@BY5PR18MB3412.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0311124FA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(199004)(189003)(5660300002)(2906002)(86362001)(36756003)(66556008)(66946007)(66476007)(31696002)(31686004)(52116002)(8936002)(6486002)(6706004)(26005)(53546011)(81166006)(16526019)(186003)(956004)(81156014)(8676002)(6666004)(2616005)(966005)(478600001)(316002)(16576012)(78286006);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3412;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3p9UQbbGq1hN0Hvx3KXt2yMRj+v8qQCEWtx/bGQnBkCQ8lPop0nUCuNqgrYZT+sUXedMk2+/oqA74lIsntcpNzFPzzOfkhtkuJDWkuwC4HlSZBcejSBjD1oJo1E0QkXZR6NvU9hzwRnXdrdkbxRZzK7F2SB3Gmi3IBiXN1vwfrcupZrlYQ7f6UkIXz0LzmRIISR+GHS5DnR+E+WKyCaVZljn8CDvpFSYQpqYeHC+wEr6i1wlsiw6N4TSjbLDZ/51hb1xok6IaDiw9g0zqPa1xrw8m3EExty/iB3kJ5wE9HmlE9AwoAsGEHetH5+QypCm9nXzGTTJmQUzz2gDuNn4LdGzvzlIh/XDYyQ46qDoeBPACRCHEOpp+UKgePRBEHuBN8RQBtCJiw0W6M4hnGP31Z4LVQMIL0LK8E6FIx3G5vIx/Pn8HIBWxf+7gZss4iSTB/ACKMgLg4KwVExkVcOW82zDRKFTbpZ/Nlysh6eCLPzbHjZjXwmR6YAq+5OnlgRKAIizOl4ydGOc2SpksJkCdpFQAyXJrmLbE8LXLDKg2aytTvsKc30YBi7+FmhYnoI6jTGarfvmE7bwlq9w+98ie2EKqfhwD9BSQa1gREbCQgk=
X-MS-Exchange-AntiSpam-MessageData: cXA0YSbzrvmDJRHyVMhsW4FWHIw6fKbGNGfz3kY0+sa4udH5oV7eF39RWhGo0SwRCkF+Gj3U8blB7AP+fcb1aeds8/pDbKd34Lt2SzaqnkQIDh4R8GkaV7oCEtOyoZE+JvLmQHtGpBP4ENOWBgQRPA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f17b9cf-62da-4bcb-565a-08d7afbb9356
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 13:00:46.4177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y8Qygi4IG8OtcdgSn9OWqSrYrs2cSqOesJqnj+RHYqCYqjhQ3qke/5u5+rZwTmu7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3412
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/2/12 下午8:58, Josef Bacik wrote:
> On 2/12/20 12:30 AM, Qu Wenruo wrote:
>> [BUG]
>> A completely sane converted fs will cause kernel warning at balance
>> time:
>>
>> [ 1557.188633] BTRFS info (device sda7): relocating block group
>> 8162107392 flags data
>> [ 1563.358078] BTRFS info (device sda7): found 11722 extents
>> [ 1563.358277] BTRFS info (device sda7): leaf 7989321728 gen 95 total
>> ptrs 213 free space 3458 owner 2
>> [ 1563.358280]     item 0 key (7984947200 169 0) itemoff 16250
>> itemsize 33
>> [ 1563.358281]         extent refs 1 gen 90 flags 2
>> [ 1563.358282]         ref#0: tree block backref root 4
>> [ 1563.358285]     item 1 key (7985602560 169 0) itemoff 16217
>> itemsize 33
>> [ 1563.358286]         extent refs 1 gen 93 flags 258
>> [ 1563.358287]         ref#0: shared block backref parent 7985602560
>> [ 1563.358288]             (parent 7985602560 is NOT ALIGNED to
>> nodesize 16384)
>> [ 1563.358290]     item 2 key (7985635328 169 0) itemoff 16184
>> itemsize 33
>> ...
>> [ 1563.358995] BTRFS error (device sda7): eb 7989321728 invalid extent
>> inline ref type 182
>> [ 1563.358996] ------------[ cut here ]------------
>> [ 1563.359005] WARNING: CPU: 14 PID: 2930 at 0xffffffff9f231766
>>
>> Then with transaction abort, and obviously failed to balance the fs.
>>
>> [CAUSE]
>> That mentioned inline ref type 182 is completely sane, it's
>> BTRFS_SHARED_BLOCK_REF_KEY, it's some extra check making kernel to
>> believe it's invalid.
>>
>> Commit 64ecdb647ddb ("Btrfs: add one more sanity check for shared ref
>> type") introduced extra checks for backref type.
>>
>> One of the requirement is, parent bytenr must be aligned to node size,
>> which is not correct, especially for converted fs or mixed fs.
>>
>> One tree block can start at any bytenr aligned to sector size. Node size
>> should never be an alignment requirement.
>> Thus such bad check is causing above bug.
>>
>> [FIX]
>> Change the alignment requirement from node size alignment to sector size
>> alignment.
>>
>> Also, to make our lives a little easier, also output @iref when
>> btrfs_get_extent_inline_ref_type() failed, so we can locate the item
>> easier.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=205475
>> Fixes: 64ecdb647ddb ("Btrfs: add one more sanity check for shared ref
>> type")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> We aren't allowed to have nodesize != sectorsize with mixed, exactly
> because you ended up with weirdly sized holes and such.  How is convert
> ending up with this problem?  Thanks,

Chunk can starts at a bytenr which is aligned to sector size only, but
not node size aligned.

Then all its tree blocks can be unaligned to node size, while the offset
inside the chunk is still nodesize aligned.

Thanks,
Qu

> 
> Josef
