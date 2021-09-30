Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF9F41D7F7
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Sep 2021 12:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349896AbhI3Koo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Sep 2021 06:44:44 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:27613 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349764AbhI3Kon (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Sep 2021 06:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1632998580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JJmZuHxsLQatJy3WNjKBjU4dCGKE9l2haxeIYZUq4m0=;
        b=PsdA0UoH1BoveDp/ACPhG+eOR9rjFQ3jVEHBUvm4dhNM3AVI30xCFTabPyX5yOKmkEeCCn
        ZhHRfNMMeV7M2f/pNGvEtPYYlv5NY/huNxLAvlRwW1W7K42jkd0crG4XnTM/SiowH7lmlV
        BWM8FcolcbEn/hHOlpCRGcsndSgxJYk=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2055.outbound.protection.outlook.com [104.47.12.55]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-18-jW6SxUJ4PZybXOxmRdCG-g-1; Thu, 30 Sep 2021 12:42:59 +0200
X-MC-Unique: jW6SxUJ4PZybXOxmRdCG-g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7t8iSTPSvHTPvAyAIg55qf39PYdDHOhPMBv+5IYE8A0mNTswgJKeA9mM6VQs5eBP401i22YN1MEMKVxNFxsyLi76awvQ8OM2TISwOKfelGf5aBYK1UWtv7d512sNEjsSij8OV+blbrVZwesdJYe52jFF5BiOCKh7cnglaSP//ljkr2wx1fWqMmxA/inF1+CdQgh7wShL2T5iV8EifYR64Am2w8U8WeJFfBH1+2S6HVzyDw615M8R2/ydbXEsLc7WnReGzNgbBpAGmQaEFuGDx2t3L3GBAyyzi6+9Jbfgjtwj1tEXz8iVqK+EaNQu4RHCzVsM0gA76LTX2hJX810ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=JJmZuHxsLQatJy3WNjKBjU4dCGKE9l2haxeIYZUq4m0=;
 b=AqT6RgRGhCp6R8O9e4NDX2uS2FmvIykatWcNhK8SAaAmE/DyAP3mV1i1yH45uWTOVOxdaVYvGCEiA92jZuek38R+ESbzRrK7HrBWZFeO5y3qgldx5zDnZqdZwbw7HYK9Lnrae7v93y3EK9F/5NwVpSzGIxLqPun5rhVna/PkIgLDThQ+p/FBC2B5nplQqJN19vBInv0zFg4sjZytM4gxmjw10bWHKptisz/V7lLLSOX8ziAvdM1OImauFlj8/PY5Z3F9kujpe8QsKlJV4p1/UfAIYKY1vuWJurJIe7AdW3C6Jx4GV8SV9sZ1/GVMTsP6MzB1+7NwBzVzmQISOuXE8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR0402MB3445.eurprd04.prod.outlook.com (2603:10a6:209:7::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Thu, 30 Sep
 2021 10:42:57 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097%4]) with mapi id 15.20.4566.017; Thu, 30 Sep 2021
 10:42:57 +0000
Message-ID: <1e6bc90e-1029-6b5c-9fed-ae1e4112e1da@suse.com>
Date:   Thu, 30 Sep 2021 18:42:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US
To:     fdmanana@gmail.com, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210930000042.10147-1-wqu@suse.com>
 <20210930000042.10147-3-wqu@suse.com>
 <CAL3q7H7ccjnLQM9Hawe3VtRkcYVM__jCqJRZ-BjaYJzfYQ+2Yg@mail.gmail.com>
 <7c1442f6-9d2c-03f8-200a-1a6132a1a419@gmx.com>
 <CAL3q7H7qytwkFCV856rU2COvV9ry-H6120UtuH5RmZnsoFUmoQ@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 2/2] btrfs-progs: misc-tests: add test case for receive
 --clone-fallback
In-Reply-To: <CAL3q7H7qytwkFCV856rU2COvV9ry-H6120UtuH5RmZnsoFUmoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0056.namprd17.prod.outlook.com
 (2603:10b6:a03:167::33) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by BY5PR17CA0056.namprd17.prod.outlook.com (2603:10b6:a03:167::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17 via Frontend Transport; Thu, 30 Sep 2021 10:42:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 776ed699-18c0-4a0f-4387-08d983ff110a
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3445:
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3445B8093A15289C18E08047D6AA9@AM6PR0402MB3445.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /5tu22IIR5WeRYk999bEOwsuHlDyS1/NzSbY3ezAgz4Zkm5Rg+Q0F5JX2CTk7brhItMrjQMKkPYUeMXy7XSek9WNLSk6EeHbItuO/d3tv1UXN7nrsk4bkNKA502gwBLPIKk8WWpRrICYWYK2VgAWp2MNWV1KJHFtI0C8GUSuPNoblzR4bcAF/sZbc37weZXwzZYFNG7rYdFA1+JE3d1YmI5fGIWSzVJ/0XC9hdJ/wNYkUtLqA/Em8gH99h52US5rgA1lF1coNlU047zZ0ViGzjlavhiYAvZiVoVZ79CV1/1NjjlbgSvJ3/ACseQrIEUVNI79y/z30kMSF1b+Rnt0WwOUjYJwXALA03Fyo7IcwHfMdgv0M8UWnwjjt684S/nxviZKH0ks7ZGV3KvSrl5ISVr9u7nliRXzE9Xb+mFIiEy11+jmgoregRupW/2tLN7aIr4e9ZKrJerSPJc4HaEqhRXmWN9ZoDHIM94brXrllwmlNurFfWMYwEZYLNnZHtuysEstY2djRqLP4X8ix899L1KU97HlTKkdz+cL7EQzvkY9+63Zgz7gd0p4EYLk/RHys06W/4h+9nwKEus8ScJ9H3Em6M1UvHWAne+HlSnxScot37AnEQ8BafkhdZDV4voElLM97lrjo5JPrfLARRTxn+KyWAmUkMxHmEYCwbmbrl5Gzm9FNVJx03irrdQxy5gQIu3zw24JUCUJcYpNTpAymSXq/XtYD0evuS45/e7OtK1X5znu0tqx/2DtGg1ZR5zhN3JlnlKQdfNXH1fs2NDMz+G4yilrOTmeX2e1dMjl/1s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(53546011)(316002)(36756003)(83380400001)(16576012)(38100700002)(31686004)(31696002)(2906002)(5660300002)(66556008)(2616005)(4326008)(66476007)(6916009)(6706004)(6666004)(66946007)(956004)(8676002)(86362001)(186003)(508600001)(6486002)(8936002)(518174003)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2lmc0JRL296ZXVvdE1oQjdZNE1KQ3Z5NzZPdi9oMGNoaFpaeHNyN2xkbk1r?=
 =?utf-8?B?ME9IUVNHbUJBb3VaN2tiM1N5UWtxR2N4UzZXYnFidnVXczdLS2Q4dFJpUzJ3?=
 =?utf-8?B?eEdicGJ1T1NWa1JtQmI5cjhWTGRWWS84cEEzT2gzL0o4V0dDRTR2SElqejM2?=
 =?utf-8?B?NVI5bTVQY2g2UU45SmdPemdFK1FJaTJBRmlJOE12amdRSVFmWnRCd3BWZCty?=
 =?utf-8?B?ZUhuR1ZFaUVLLy9uby9YcU1xMmExRTB0Z1ZCdkt5NUN2cEkzeGZiOTloWTRn?=
 =?utf-8?B?YXVXUE1FYnBQcVBsd1M1VGJmZVYrUkY3bXRab2JnTVdWZ2hyVC9GTW1VaWg5?=
 =?utf-8?B?b1R6RmhmUWt3bHJ5eTRRY05SaUZVSG1vS3VKS3RRQnNta1N0L00zdUxLdjdT?=
 =?utf-8?B?dlpKenFnR1R0SE9aOXhDakZSMU9QL1dSUEYyZ3IycjB0RDFOUTlEMWlycEFT?=
 =?utf-8?B?L1dDTTBISUNqV2JTdHhEUlZnZmpPZmJXbVR2Z3ZuSElWQjhvcmNqR0o3WGJT?=
 =?utf-8?B?WHlVNmw0dG9CVjhobENwUVVydWpmdWNSdkMrUUxzVVN3NUlqeEF2azlGWitE?=
 =?utf-8?B?OTdkQWdjdmhPTi9QMEdCMHFmVW5HQ3grRXZQSWkwMlpyOHRZdHpWWTJwNllB?=
 =?utf-8?B?NjNmbnJBSlhSNUUxK0lpcDdwVlhKdVFXS1plMWtaMkhWK0grVWlySDJOM0t4?=
 =?utf-8?B?UHpDaW9waWFqM3Uya3g0YlZvWEdsbE5ETlh1STgvTFBIY1F2M1JaY1pWeDU1?=
 =?utf-8?B?QVdDZGlXTUxuYkFoRGdOTkRuZjdRZCtrUEhsVlNFK0R6VGtWb1R1cWE3WGFF?=
 =?utf-8?B?UCs2aDRIdFJxQlh5UXprU3F5QU5QWXg2T2xLMHI4R3RqTjhrRFhPejlmbUdI?=
 =?utf-8?B?ZGJiUzdLdElwT2NhcTVzdXBiSWlOMGFWaXFjQm9GZmpYOUhOSHVjVFhseEp4?=
 =?utf-8?B?UkVuZVJtYTJ4TC9MYi9HZFVvSkZRSFpQZGFMdjRpanR2NnhLeStUVTBBRWN6?=
 =?utf-8?B?MHRobTMzQ3AwcTNBc2dDc01FNXRMclhoYUJQVVJHVkZhL1cvUXFSN0J5ZDNV?=
 =?utf-8?B?TUVQVWgxUWpsWmc2Rkc0aitOSGZENzBYV2ZneXlGSU9YTGQ4VWxwOEpHRzRR?=
 =?utf-8?B?YXg1R2RhVzZtQXlodWdSRmJoR2pCREU3UHBRQmludWpFQUhORU5xRml6S0Z1?=
 =?utf-8?B?SWFNTE9idXc0MWVQNENLaHZQbUxHTVlxVFBxNmtwMTJYV1oxVkE1TlZQRW1Z?=
 =?utf-8?B?TnJlMDd1aDFhZ283d3UrMklHaFl5TFpxZWdrcFNDR2dSM256ZmtpUnZ2cWww?=
 =?utf-8?B?V1pQZlF5RTJTZTFpL3psUWptQllwNUs1R2JVd0VQTHNrVnJnVi85Y29LSFkx?=
 =?utf-8?B?dHAzZkVnN3FadUh3alNSRll4V0UxZUhBK2JDQjJtZzFoaEVEM1dyUHdnMHNU?=
 =?utf-8?B?UjlrczEzVk81eDJ3eVo3MjV3V3lWcDY3VFJPeDBoRFhJS0hKQnc2bEE1c280?=
 =?utf-8?B?emEyNDI3U2prajJJVVBMNDdoa1E5YUJ6bDVvanZaNEpRYnJ0NHpjOUFwUkpN?=
 =?utf-8?B?SnNOZ1ZMZGxMT0c2QmVmWGlZYS9UQ283dTlMbTExWFJMRkVteFBHR3UxWTdm?=
 =?utf-8?B?bVNDM01VbkdzYWdPVFpDdEhzVy9Bd2NtZW5RaDBVSVk2Wk9TdUZmQWZkMENJ?=
 =?utf-8?B?NVFWNG90OENmd1BETFBkZkRidFI0ZDBrSkJHMXcxbE92TndRYlpUTlZGWndJ?=
 =?utf-8?Q?gYiS1V15PK86JyeZPpxal/nWHDeTD+aPlTxpMEl?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 776ed699-18c0-4a0f-4387-08d983ff110a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 10:42:57.6475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3kYcDApg8hYFiVT2mQ3aecDMpOQtD6ruztEfwtg5xhXGBSVnh3Ks514Q4xJy5m7i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3445
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/30 18:30, Filipe Manana wrote:
> On Thu, Sep 30, 2021 at 11:18 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> On 2021/9/30 18:03, Filipe Manana wrote:
>>> On Thu, Sep 30, 2021 at 1:06 AM Qu Wenruo <wqu@suse.com> wrote:
>>>>
>>>> The new test case will create two send streams:
>>>>
>>>> - parent_stream
>>>>     A full send stream.
>>>>     Contains one file, as clone source.
>>>>
>>>> - clone_stream
>>>>     An incremental send stream.
>>>>     Contains one clone operation.
>>>>
>>>> Then we will receive the parent_stream with default mount options, while
>>>> try to receive the clone_stream with nodatasum mount option.
>>>>
>>>> This should result clone failure due to nodatasum flag mismatch.
>>>>
>>>> Then check if the receive can continue with --clone-fallback option.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>    .../049-receive-clone-fallback/test.sh        | 60 +++++++++++++++++++
>>>>    1 file changed, 60 insertions(+)
>>>>    create mode 100755 tests/misc-tests/049-receive-clone-fallback/test.sh
>>>>
>>>> diff --git a/tests/misc-tests/049-receive-clone-fallback/test.sh b/tests/misc-tests/049-receive-clone-fallback/test.sh
>>>> new file mode 100755
>>>> index 000000000000..d383c0e08a68
>>>> --- /dev/null
>>>> +++ b/tests/misc-tests/049-receive-clone-fallback/test.sh
>>>> @@ -0,0 +1,60 @@
>>>> +#!/bin/bash
>>>> +# Verify that btrfs receive can fallback to buffered copy when clone
>>>> +# failed
>>>> +
>>>> +source "$TEST_TOP/common"
>>>> +
>>>> +check_prereq mkfs.btrfs
>>>> +check_prereq btrfs
>>>> +setup_root_helper
>>>> +prepare_test_dev
>>>> +
>>>> +tmp=$(mktemp -d --tmpdir btrfs-progs-send-stream.XXXXXX)
>>>> +
>>>> +# Create two send stream, one as the parent and the other as an incremental
>>>
>>> stream -> streams
>>>
>>>> +# stream with one clone operation.
>>>> +run_check_mkfs_test_dev
>>>> +run_check_mount_test_dev -o datacow,datasum
>>>> +run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "$TEST_MNT/subv"
>>>
>>> You can use the default subvolume and therefore avoid creating a
>>> subvolume and making the test longer than needed.
>>> Your call.
>>
>> I understand we can use the default fs tree, but I just can't find my
>> mind at peace when doing snapshoting of fs tree.
>>
>> It always remind me of the bad memories using hacky way to solve the
>> qgroup problem for such snapshot.
> 
> I don't get it.
> The fs tree is a subvolume like any other, it was always possible to
> create snapshots of it, and snapshotting it is done the same way as
> for any other subvolume (both in terms of api and at the
> implementation level).
> So I don't see anything "hacky" about it, and it feels very natural and common.

It's already way off-topic now, and it's mostly qgroup related problem.

The problem here is, when snapshotting fs tree, the destination dir is 
also in fs tree itself.

This means for qgroup, it has to do the snapshot dir entry creation 
differently, even they are happening inside the same transaction.
(like doing a mini-transaction commit inside a transaction)

Details can be found in qgroup_account_snapshot().

But that's all qgroup details, should not really trouble end users, just 
some really bad personal memories...

Thanks,
Qu

> 
> So I don't understand the relation with solving some qgroup related
> problems in a "hacky" way.
> 
> You can leave it though.
> 
>>
>> Thus I always try to avoid snapshotting fs tree.
>>
>>>
>>>> +run_check $SUDO_HELPER dd if=/dev/zero bs=1M count=1 of="$TEST_MNT/subv/file1"
>>>> +run_check $SUDO_HELPER "$TOP/btrfs" subvolume snapshot -r "$TEST_MNT/subv" \
>>>> +       "$TEST_MNT/snap1"
>>>> +run_check $SUDO_HELPER cp --reflink=always "$TEST_MNT/subv/file1" \
>>>> +       "$TEST_MNT/subv/file2"
>>>> +run_check $SUDO_HELPER "$TOP/btrfs" subvolume snapshot -r "$TEST_MNT/subv" \
>>>> +       "$TEST_MNT/snap2"
>>>> +
>>>> +run_check $SUDO_HELPER "$TOP/btrfs" send -f "$tmp/parent_stream" \
>>>> +       "$TEST_MNT/snap1"
>>>> +run_check $SUDO_HELPER "$TOP/btrfs" send -f "$tmp/clone_stream" \
>>>> +       -p "$TEST_MNT/snap1" "$TEST_MNT/snap2"
>>>> +
>>>> +run_check_umount_test_dev
>>>> +run_check_mkfs_test_dev
>>>> +
>>>> +# Now we have the needed stream, try to receive them with different mount
>>>
>>> Reading this is confusing, it mentions receiving them with different
>>> mount options, but they are the same for the first receive.
>>>
>>>> +# options
>>>> +run_check_mount_test_dev -o datacow -o datasum
>>>> +
>>>> +# Receiving the full stream should not fail
>>>> +run_check $SUDO_HELPER "$TOP/btrfs" receive -f "$tmp/parent_stream" "$TEST_MNT"
>>>> +
>>>> +# No remount helper, so here we manually unmoutn and re-mount with different
>>>> +# nodatasum option
>>>
>>> Seems pointless to mention there's a lack of a remount helper in the
>>> test framework.
>>> Just say that now we mount the filesystem with nodatasum so that the
>>> new file received through the incremental stream ends up with the
>>> nodatasum flag set.
>>
>> Or maybe I should just add run_check_remount_test().
>>
>> Thanks for the review,
>> Qu
>>
>>>
>>> Thanks.
>>>
>>>> +run_check_umount_test_dev
>>>> +run_check_mount_test_dev -o datacow,nodatasum
>>>> +
>>>> +# Receiving incremental send stream without --clone-fallback should fail.
>>>> +# As the clone source and destination have different NODATASUM flags
>>>> +run_mustfail "receiving clone with different NODATASUM should fail" \
>>>> +       $SUDO_HELPER "$TOP/btrfs" receive -f "$tmp/clone_stream" "$TEST_MNT"
>>>> +
>>>> +# Firstly we need to cleanup the partially received subvolume
>>>> +run_check $SUDO_HELPER "$TOP/btrfs" subvolume delete "$TEST_MNT/snap2"
>>>> +
>>>> +# With --clone-fallback specified, the receive should finish without problem
>>>> +run_check $SUDO_HELPER "$TOP/btrfs" receive --clone-fallback \
>>>> +       -f "$tmp/clone_stream" "$TEST_MNT"
>>>> +run_check_umount_test_dev
>>>> +
>>>> +rm -rf -- "$tmp"
>>>> --
>>>> 2.33.0
>>>>
>>>
>>>
> 
> 
> 

