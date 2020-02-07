Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9E8155555
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 11:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgBGKJO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 7 Feb 2020 05:09:14 -0500
Received: from m9a0013g.houston.softwaregrp.com ([15.124.64.91]:46318 "EHLO
        m9a0013g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726816AbgBGKJO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Feb 2020 05:09:14 -0500
Received: FROM m9a0013g.houston.softwaregrp.com (15.121.0.191) BY m9a0013g.houston.softwaregrp.com WITH ESMTP;
 Fri,  7 Feb 2020 10:08:33 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 7 Feb 2020 10:03:46 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (15.124.72.12) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 7 Feb 2020 10:03:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vr0aURAjgoRpEO4cM9SEYLQhBHAQ3F9siq/qfrRNfqWWwhfnVuMVtKjqFK/cV86fY7eHc3/STLcZQxHilccXXIXZg0C1F7en98Fds4+D433yhrTWUjKTtag83iXwXeNV5gQ+67Ou1OlzgVU7HdLAtAW9TS53xckco5HkdlMilltBvIZqhuFwBf9ieXkluWsyjSglkkB3A6nGAWxD1ozYC3bdGrwSWhZD2B7J68LbmeQ5CP8blulZZeQkkl4zKHAQOGtvaofIJvCAtoWyK8zvoGmcEJxwnNRYntdjed1WvVhaA48cxqG+q0QeNwZApEpnzCxSi8qvoBU9qylAUhJ/hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5DHvL5xJQQlUpd0ZQjA0g8l5R8sQQOozY62LZlw0tk=;
 b=G4WhkFDn/UUrA/O6vhY3V6mMON6kPOb9WN00w6gZ+TGZw8nxtFRsA+uH0MIWlgXfX6e81OnaN1f7nfLgd2UDBep9BcWugWdtsL8WHz2uuLW9riPWA1czuFEgmdmj411L7eu7CgLcw0sm4fecY3/KUvDqe/5rWskXE4HoyBLlE1VfyhFGikYNBRhuEA64MaW581KVzE4QBN8u2K2CD9u+mEgxYJncdN2cIDZnPULLWgX4HG6iJelgHL33fJxPSjQMCGHttxak4gAJIG7G5CqRMrre2ScLI7m3iCJZt2d3LGE+hdOFvQ3uaKkyNCDhpoLQ/NswOfe1XjOFYFI6AnRdfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3427.namprd18.prod.outlook.com (10.255.139.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Fri, 7 Feb 2020 10:03:44 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd%7]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 10:03:44 +0000
Subject: Re: [PATCH 2/3] fstests: btrfs/022: Match qgroup id more correctly
To:     Nikolay Borisov <nborisov@suse.com>, <fstests@vger.kernel.org>,
        <linux-btrfs@vger.kernel.org>
CC:     Josef Bacik <josef@toxicpanda.com>
References: <20200207015942.9079-1-wqu@suse.com>
 <20200207015942.9079-3-wqu@suse.com>
 <fa00355c-5c99-1c5c-9af5-eb0bf221b528@suse.com>
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
Message-ID: <8e99dc23-017a-35c3-74a9-4742e0164095@suse.com>
Date:   Fri, 7 Feb 2020 18:03:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
In-Reply-To: <fa00355c-5c99-1c5c-9af5-eb0bf221b528@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ClientProxiedBy: BYAPR05CA0069.namprd05.prod.outlook.com
 (2603:10b6:a03:74::46) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by BYAPR05CA0069.namprd05.prod.outlook.com (2603:10b6:a03:74::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.15 via Frontend Transport; Fri, 7 Feb 2020 10:03:43 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90847e7c-9e37-4371-3169-08d7abb50457
X-MS-TrafficTypeDiagnostic: BY5PR18MB3427:
X-LD-Processed: 856b813c-16e5-49a5-85ec-6f081e13b527,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR18MB342756DDC53877B108A9153DD61C0@BY5PR18MB3427.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(199004)(189003)(316002)(81166006)(6486002)(16576012)(8676002)(81156014)(8936002)(16526019)(186003)(26005)(2906002)(31696002)(52116002)(86362001)(36756003)(66556008)(956004)(66476007)(2616005)(478600001)(4326008)(6706004)(31686004)(5660300002)(66946007)(78286006);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3427;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 55zuKRsIv0yL9gbAmrqhP/lc2eEG855hkFZ6lARIIWUQ6+6lwG82Om4LYxfrBEArQpdv5ojDvBMtmCkGURg6N+rKxyEXyL+BLSKTr+PRDAPIBcvzEZO79PkNCLWjPiT+U6rRFX2fztr9WtdsgaqmNRD81e3jwPaeiwz9u7qkbrsyM3Q4CGbi8uHB3Dm6ssl4cuixseKS9IUQFzBR6q4tWQ+wxxWYkcGTQPj3ZZMZa+wx3z1uCaXIOtVdQsWehUXUHMfy+EjqwsTCnMV8DLrwsCESgzxbVKZaZjh5NIOlfTmOC08V5mEmv1XlwXXQwOBi7/s+XRwEYTmZ1a2WymNRXvnQjnZdWA4QpLom7kNFu47UeX6MGHP13DjJ2XvbZmd4I8dq6PHx6EYNFqArBeQl/Q1I1z/q4BHRlRcHm5LatKM6nshQI4PpJBfg7znJizOsQzw0Ru+Lmhdn/ppYB2k6G2hI6jV/sKwjUCxJ3OvKyDpasyXpQZREnujzTFGuNFEmmHbJQV4+7j45lIPD0VV9a6vAklQumWbYUVK6alm9deo=
X-MS-Exchange-AntiSpam-MessageData: CmLi68ZbCEqceYC3SWHn8GLzoHe05NKCYXD4C4Z9beyzxOdQ9x8QzFY1H4sY9zaDwgrOB0bxLuRE8AzunLKagjDM9XlPdpIJT935Vo8NtqJcQ+XCh+zjXBm/7/0l4m/bud9rZEN6nqA1PsOfHCHf5A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 90847e7c-9e37-4371-3169-08d7abb50457
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 10:03:44.8226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dkvm/SN5kfA5q5/JKkidc459sq8sIsxuNpgT5ODIyf34uvQyZWdx7AoU+Lkm23T+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3427
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/2/7 下午5:46, Nikolay Borisov wrote:
> 
> 
> On 7.02.20 г. 3:59 ч., Qu Wenruo wrote:
>> [BUG]
>> Btrfs/022 sometimes fails with snapshot's reference mismatch with its
>> source.
>>
>> [CAUSE]
>> Since commit fd0830929573 ("fsstress: add the ability to create
>> snapshots") adds the ability for fsstress to create/delete snapshot and
>> subvolumes, fsstress will create new subvolumes under test dir.
>>
>> For example, we could have the following subvolumes created by fsstress:
>> subvol a id=256
>> subvol b id=306
>> qgroupid         rfer         excl
>> --------         ----         ----
>> 0/5             16384        16384
>> 0/256        13914112        16384
>> ...
>> 0/263         3080192      2306048 		<< 2 *306* 048
>> ...
>> 0/306        13914112        16384 		<< 0/ *306
>>
>> So when we're greping for subvolid 306, it matches qgroup 0/263 first,
>> which has difference size, and caused false alert.
>>
>> [FIX]
>> Instead of greping "$subvolid" blindly, now grep "0/$subvolid" to catch
>> qgroupid correctly, without hitting rfer/excl values.
> 
> That 0/ can it ever be a number different than 0, if so a more correct
> regular expression should be:
> grep "[[:digit:]]/306"  ?

In this particular case, we only care level 0 qgroup, thus it's enough.

If we're extracting it into a generic wrapper, then your
[[:digit:]]/$subvolid will be needed.

Thanks,
Qu
> 
> 
>>
>> Suggested-by: Josef Bacik <josef@toxicpanda.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  tests/btrfs/022 | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/tests/btrfs/022 b/tests/btrfs/022
>> index 5348d3ed..3e729852 100755
>> --- a/tests/btrfs/022
>> +++ b/tests/btrfs/022
>> @@ -49,10 +49,10 @@ _basic_test()
>>  
>>  	# the shared values of both the original subvol and snapshot should
>>  	# match
>> -	a_shared=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep $subvolid)
>> +	a_shared=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid")
>>  	a_shared=$(echo $a_shared | awk '{ print $2 }')
>>  	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT b)
>> -	b_shared=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep $subvolid)
>> +	b_shared=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid")
>>  	b_shared=$(echo $b_shared | awk '{ print $2 }')
>>  	[ $b_shared -eq $a_shared ] || _fail "shared values don't match"
>>  }
>> @@ -68,12 +68,12 @@ _rescan_test()
>>  	run_check $FSSTRESS_PROG -d $SCRATCH_MNT/a -w -p 1 -n 2000 \
>>  		$FSSTRESS_AVOID
>>  	sync
>> -	output=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep $subvolid)
>> +	output=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid")
>>  	echo $output >> $seqres.full
>>  	refer=$(echo $output | awk '{ print $2 }')
>>  	excl=$(echo $output | awk '{ print $3 }')
>>  	_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
>> -	output=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep $subvolid)
>> +	output=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid")
>>  	echo $output >> $seqres.full
>>  	[ $refer -eq $(echo $output | awk '{ print $2 }') ] || \
>>  		_fail "reference values don't match after rescan"
>>
