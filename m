Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4525A9B3F
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Sep 2022 17:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbiIAPHK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 11:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiIAPHG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 11:07:06 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2126.outbound.protection.outlook.com [40.107.20.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2053684ECA;
        Thu,  1 Sep 2022 08:07:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rl/v1Pe1YmAEBF+Hcv+NDLkaPaR+QhUduu+4lK+2H0WSMPM8u+ubCLJL3rsYcobiRlknZNGbfX2a4yKptL3JHf0KJvdDtX6AtXjxZ/gLSsRNjqPYmOJuu2NvnOHkv7FFc3Al3KRE7Bo0JnBrLI18ElzZvW/uhAgrDWqjsFffcxq5kJD4Mk9td9Ao3rHYZn6jRKYLlcFBljREL/BudC2XXhpMZamPQqFYgrjMTYGnVsgiSbqjOak5tLQUrtFJg32u7FCNDcAoCsRnS+aEMRKccJMnHZw2Qjsjhfz3wUr5UdkIFSR3VfZhppt8bcWQNwqO6+hQr91gPVU/opLW7XkNuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RR8p74KTXL9aWR7LE/GfTzVGhTW4+0VDh+u7WmcSTUQ=;
 b=eAHe1X8Zlx0wkahLlk5TN7SzPqHry7y86kjZKSEEY0txgcANH/gciQp1REtB/Q5+dXmXjQFyg6j9qNmNfOO9c703UOIdskIoFH9zajwJ40197NaJLGvSgv7MoGMNhvPd3uZVHqeSpsayMfDiWDyBWKpMGBOGERPnNezyST1wVBcaYqeu5yVKT0f2WRoTxWcOqfHGCeRm+U9T0bYCqdwXpxmmrPoHjYkgg/Q1mItUlVg7cY+SpVjtFswjqX79dZhp9VLN06TUJUHBcUQSSaoL1ESNJkhmdlObebGlpZCS7owQEWbHZ4MHGj4Azv2+64FLRYcGWJB+C4Uto1hT/1m/BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RR8p74KTXL9aWR7LE/GfTzVGhTW4+0VDh+u7WmcSTUQ=;
 b=blZWvIHT+b9nLFn6yMHhzw9mpXYjFeFuVoooGQkYaw7zW4lv0pzUZ3LzezEof4XnuXgFgJA8zn5KU39c4f3F3q7B3yTFMT+IYKSOp0iHPEZb+PSZQDLw15hVHCrxcEWIWtXDRKx1fuSXNeUKDTrlbfqqlanmT29yqqMiYAxb3SQijG/piBUAlpKoLfPUDrEbEfRy5ql1Z+N0AfPSlCchJzeCEOWCAPb/ZWcQYSiOEMRLelu9Dh+m7HX353xhxu2YTDSvre6DJ2xB5aga50QjCIqWk8peoT+fzMqlv1br6sxtJne2UOP3Cv2JevOzIPNL3ZxCBgomWKEeNcQBidPXlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
 by AM8PR08MB6497.eurprd08.prod.outlook.com (2603:10a6:20b:316::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Thu, 1 Sep
 2022 15:07:00 +0000
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::d94a:b37f:a70b:3c53]) by VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::d94a:b37f:a70b:3c53%6]) with mapi id 15.20.5566.021; Thu, 1 Sep 2022
 15:07:00 +0000
Message-ID: <a83e47f8-28be-dfbe-24f6-1db908fe818d@virtuozzo.com>
Date:   Thu, 1 Sep 2022 18:06:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: fiemap is slow on btrfs on files with multiple extents
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Chen Liang-Chun <featherclc@gmail.com>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        kernel@openvz.org, Yu Kuai <yukuai3@huawei.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominique MARTINET <dominique.martinet@atmark-techno.com>
References: <YuwUw2JLKtIa9X+S@localhost.localdomain>
 <21dd32c6-f1f9-f44a-466a-e18fdc6788a7@virtuozzo.com>
 <YuzI7Tqi3n+d+V+P@atmark-techno.com> <20220805095407.GA1876904@falcondesktop>
 <20220901132512.GA3946576@falcondesktop>
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
In-Reply-To: <20220901132512.GA3946576@falcondesktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::12) To VE1PR08MB4989.eurprd08.prod.outlook.com
 (2603:10a6:803:114::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d966793a-7cc4-4f12-7d33-08da8c2b9ea2
X-MS-TrafficTypeDiagnostic: AM8PR08MB6497:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wAMLRMI+GgN5uurENKSDK10ToCwQVHYcomfSsZNsMEw2MfzATw9fAvS5L1GvbNL/8HZ1dItQQwv5L8fwX6k5jkOr5AgbUqG+eNzxHrquJRUISDDRGHkudfRuCC0t1s3GmMZNO/wJfistsFSKx6q4Q//xQ0cNBuJmI4PJLhjw7033QYF65hgN+y6YA9LaKRXcLizDQ6wSq//SIA3Ezubjjsk1+NnNCr26NHI2Qxpl5xQRDLQFPvIaGgnJhVM1zEj2jd7LFIOTZAnEhLBRlRUZZoCXmpkiUSDFTNFcALAVgu7/zSB5opINT0EIkuHJcVzyKTjT9smNDNfM0veH/HbNy2ZU51KES8qMySayj5h/F1j6QqYnPm9dTsVr9lKxHpMv3NOKfPrtM6JxNaa46dA0QwgjSKuE3fWDScd3cv+nNWBwGSJTEQu3dh0y333ND4lSzarIBwevwbDdcZTTZPAElcecoLS4kPk8C2Xx99IB5Uu0RklKT4vU4nJsh/9qZ5YTuLW9z89XyGx2NvFOOyqawi8i/gIzeCp7qOhq3kVkFnIJ56lY+A3o1VGkarQAxxCvl1DqtNSq7CyZGDrEQqTswpECwAetAzn4CUpicOOMe6Ev+nJ/j4fzck4MuZg7caVhsybaiERnepMbbyKWyW7QgcHJoAr777IfZyURXtFOgmVDWa6xS4gHjvOxhvzVzStrrSTj+6d1yziM5uEwuhcQ5fanNNxyrqNhpBOVkk1UVD4/DskLwjoOXyLOty/Tsj1LrT1waerNOHodbTYoNfa8WZ7Z4oqpNYElR+UGAMIioAAhPRjsRUvAwk0xDxIPJQQ0ZD5MFaHBMOQh3Lw13zHT1fOCs0vgbbJ6x1/S0cH5Uy8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4989.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(366004)(346002)(376002)(39850400004)(53546011)(5660300002)(41300700001)(8936002)(7416002)(26005)(6512007)(2906002)(86362001)(38100700002)(6666004)(6506007)(66946007)(31696002)(186003)(2616005)(83380400001)(54906003)(6916009)(478600001)(4326008)(36756003)(31686004)(316002)(66476007)(66556008)(8676002)(6486002)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1R2RndmbldaNVk2M3NSblFBcWRrcm5ONkdLalJtNytiT3NkV0g5Uk8zRFFn?=
 =?utf-8?B?Z0RydnpTUGhZblcvUnFFM0JaaVRBbnRDSFl1RWw4T1JuYTVEYTFuc3NpTjNu?=
 =?utf-8?B?akN1bXVsNFc3aytnSkFQTEw3b09PTkdKdU5nUHRKZnUxUks3aXFuelNuNk8r?=
 =?utf-8?B?U3R3SnBjUnVaeHU5b2tvWk03YkZwOGpBbG1hZEFaR3IvaHpBMkt1Q0gvUThQ?=
 =?utf-8?B?dEd6MmRueFE3VCtFUEFvZVJoT2ZOcitFS2NUdUZucElYaGorYTZlY3ZLZnkr?=
 =?utf-8?B?RzZpTlFrSmRON3ZIblljSmRQZXc4VDF1YXBHT1RSUHdtRGh3TjBkcVJJeGR5?=
 =?utf-8?B?dkgvM1FUL3VWL1QrcWs5VXB4dFVYZFNXT3psdkhpVnU5VmVRUDJKbXI2b0tC?=
 =?utf-8?B?aW1BQ0MzWjI2SFNITHh2SlhTRDVmcGRYeHVPK3oxVWtZYVJ6VjNqWFVWd0F3?=
 =?utf-8?B?SDRFQXNqd3BKMFdqYitkTmRoN3RHcWNvRzRiTE80bS9TY0dhTEE3NEhUM3pK?=
 =?utf-8?B?OHoyQ1cvMXE4OGdxVzIxMDlMYUtteWdrUklwL05RUlFqdlBONWtUd0I4U0c0?=
 =?utf-8?B?MUdkVUViMm5BRWU0ZE8ybm85WXYxRE1Benl4YU9heExJak9URVh6cFVXK2lG?=
 =?utf-8?B?VHVUMmxpb0FaejM1Zk9xT1JZaVhJRW1ieVBtdlVaZUlDdmRydjRMbzlGNUhL?=
 =?utf-8?B?eXdBa3FvU2QxSnhoNHoxc3F6NFNHWjhMRUR0cjhaWWJzbmZrd2RwUjlVbDgv?=
 =?utf-8?B?M0RSL3c1M2ZlQmZTeXA1R0IwUVFlZkRHMGdYRS8zT0EzTTNxUE5kZGlmTVpC?=
 =?utf-8?B?NFZVdWd5Y1BTSlhRVlFpRFlnV1B4YzlrNVNrZFRTR0s2ZHNGQzV3ak5KaXpN?=
 =?utf-8?B?UnpzL2FidTBqelFscmJ6eEh1Z1ZRREN4QVhsbEQyUk42VUM2YjRrTHU3bVAr?=
 =?utf-8?B?OXpJOXRtcHFNZktFZ0oyU1VtTCtqdXY1ZnZES2lrK3g4R2ttdmtyMFhVeGdz?=
 =?utf-8?B?WVJia1I5Q2JJWm9TZWtNUHE5VXZOREs3K1YzY3RzdXN5UXk2dWxpdS9vcHRr?=
 =?utf-8?B?N0s0Y3F3dVR4akx1eUpuWHpvU3dERXgvL00rdXMxTGhwQkNUR3VZU0gzTzQ4?=
 =?utf-8?B?RlY4dkhGQXFiSjZyUWJNalN5bExOZ0o2RnkwR3JnZkdnTlhIcWxmbWVQdTlS?=
 =?utf-8?B?KzFneGpIc1NweFFKeENNN0tUT2pSVFRDZVhDNG5NTEgwYmtkQ0ZSS0hzaHZq?=
 =?utf-8?B?Y0NWY3VtOVc4TTh3ZlZSS09LYVRIbzhxS01WbXlJVDZHZzB3N3pVejBDL08v?=
 =?utf-8?B?TDV5dGZ0eG1Ic0tyUTFvUTVFRG9Nc2NNeGM2N3kyUXgwRjhTRFpMcjlvdStQ?=
 =?utf-8?B?REhoQk9pZFhoU2VBL0NvQXpFK2Y0T2RDSUdyQW5qMlZEVERVWlRXL0lmL05E?=
 =?utf-8?B?RkxIMDhtMEtpUTUreEhjNlRFWmZDaXBJK2VkUXBPY3lCYm5lUkROY3A1MGdH?=
 =?utf-8?B?SmVMVjB4WVgxSlZWY1ZaaFE5YlhZWU95NGgxWFgxOW54NTdGdkJOZ2kxOHYv?=
 =?utf-8?B?T0RFVm1keTl5YTNmSmlCUU9MSUJNL202L3FPMCtXZWZxbEswdXh2VGUrTlFu?=
 =?utf-8?B?Wk11aVFhK1dZbjNIRHhySVdiTzB1bjdOT2lHMXVpMUZhQ0hES0ZwMEtqOFY3?=
 =?utf-8?B?RVZaZEFhTlpoS0ZjaUp2R0M4aFFNQTZjKzdKRGNQQmlsSG1OVXI0czVsNWs3?=
 =?utf-8?B?Wlp1L3RTZ0wrUUdKNERXcHJLTjZuQ3RSdHE4ZSs5ZUczeUZyRDVoeFlxZk9B?=
 =?utf-8?B?UUF3RDJNL0Q1Tjc1TEVMQU9wd0srd0JRSXpuOEdJVW1JdmFtWkpIRXFEbXJS?=
 =?utf-8?B?OHNoM091R3RGcjdyUVZicU56c3hiaVVXd0ljM0tLakQ5Tzc4NGJYL3FVanZq?=
 =?utf-8?B?TmVFV1oyalRVSDZIR09NdUkrU3g1MUkvQUpXUHF6VVV4TkhxMkYwazBMSDBY?=
 =?utf-8?B?bnNPUHVWaFNkcm5sMGdVb2JjaFM2bGg2cXYxUU1oNlFTZkgyNGNqQklETTNX?=
 =?utf-8?B?Q1pUSVZFOVRxT2kyWU9pZjhSclFuOXJmYUN3Nk5CMENJOXdjc0ZlTlF2dm12?=
 =?utf-8?B?bHFjNWVlWDBiVTF5SjBENEhKL0VKcngxaWNmQmh6T2QzaGRabjZKMllhNFBK?=
 =?utf-8?B?M1E9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d966793a-7cc4-4f12-7d33-08da8c2b9ea2
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4989.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 15:07:00.0527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0nLFkGZk6eXLQTIgvHbSTDqBM4DCQRZrJZ6wpUFk/2KqDiKFUngq5bDTEHct1afWrrQXJlg4SyaYdyyHpMzcnBuWvV4FIg501yLpvIK+v8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6497
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 01.09.2022 16:25, Filipe Manana wrote:
> On Fri, Aug 05, 2022 at 10:54:07AM +0100, Filipe Manana wrote:
>> On Fri, Aug 05, 2022 at 04:38:21PM +0900, Dominique MARTINET wrote:
>>> Pavel Tikhomirov wrote on Thu, Aug 04, 2022 at 07:30:52PM +0300:
>>>> I see a similar problem here
>>>> https://lore.kernel.org/linux-btrfs/Yr4nEoNLkXPKcOBi@atmark-techno.com/#r ,
>>>> but in my case I have "5.18.6-200.fc36.x86_64" fedora kernel which does not
>>>> have 5ccc944dce3d ("filemap: Correct the conditions for marking a folio as
>>>> accessed") commit, so it should be something else.
>>>
>>> The root cause might be different but I guess they're related enough: if
>>> fiemap gets faster enough even when the whole file is in cache I guess
>>> that works for me :)
>>>
>>> Josef Bacik wrote on Thu, Aug 04, 2022 at 02:49:39PM -0400:
>>>> On Thu, Aug 04, 2022 at 07:30:52PM +0300, Pavel Tikhomirov wrote:
>>>>> I ran the below test on Fedora 36 (the test basically creates "very" sparse
>>>>> file, with 4k data followed by 4k hole again and again for the specified
>>>>> length and uses fiemap to count extents in this file) and face the problem
>>>>> that fiemap hangs for too long (for instance comparing to ext4 version).
>>>>> Fiemap with 32768 extents takes ~37264 us and with 65536 extents it takes
>>>>> ~34123954 us, which is x1000 times more when file only increased twice the
>>>>> size:
>>>>>
>>>>
>>>> Ah that was helpful, thank you.  I think I've spotted the problem, please give
>>>> this a whirl to make sure we're seeing the same thing.  Thanks,
>>>
>>> FWIW this patch does help a tiny bit, but I'm still seeing a huge
>>> slowdown: with patch cp goes from ~600MB/s (55s) to 136MB/s (3m55s) on
>>> the second run; and without the patch I'm getting 47s and 5m35
>>> respectively so this has gotten a bit better but these must still be
>>> cases running through the whole list (e.g. when not hitting a hole?)
>>>
>>>
>>> My reproducer is just running 'cp file /dev/null' twice on a file with
>>> 194955 extents (same file with mixed compressed & non-compressed extents
>>> as last time), so should be close enough to what Pavel was describing in
>>> just much worse.
>>
>> I remember your original report Dominique, it came along with the short
>> reads issue when using using io_uring with qemu.
>>
>> I had a quick look before going on vacations. In your post at:
>>
>> https://lore.kernel.org/linux-btrfs/Ysace25wh5BbLd5f@atmark-techno.com/
>>
>> you mentioned a lot of time spent on count_range_bits(), and I quickly
>> came with a testing patch for that specific area:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/fdmanana/linux.git/commit/?h=fiemap_speedup&id=6bdc02edbb52786df2d8c2405d790390d9a9443c
>>
>> Basically whenever we call that, we start searching from the root of the
>> extent states rbtree - if the rbtree is large, that takes a lot of time.
>> The idea is to start the search from the last record instead.
>>
>> I haven't actually made any performance tests, as vacations came in and
>> I noticed that such change will very likely make little or no difference
>> because algorithmically btrfs' fiemap implementation is very ineficient
>> for several reasons. It basically works like this:
>>
>> 1) We start the search for the first extent. First we go search the inode's
>>     extent map rbtree - if we can't find it, then we will search in the
>>     fs b+tree - after this we create an extent map based on the file extent
>>     item we found in the b+tree and add it to the extent map rbtree.
>>
>>     We then pass to fiemap extent information based on the extent map
>>     (there's a few extra minor details, like merging, etc);
>>
>> 2) Then we search for the next extent, with a start offset based on the
>>     end offset of the previous one +1.
>>
>>     Again, if we can't find it in the extent map rbtree, we go search the
>>     fs b+tree, then create an extent map based on the file extent item we
>>     found there and add it to extent map rbtree.
>>
>>     This is silly. On each iteration the extent maps rbtree gets bigger and
>>     bigger, and we always search from the root node. We are spending time
>>     searching there and then allocating memory for the extent map and adding
>>     it to the rbtree, which is yet more cpu time spent.
>>
>>     We should only create extent maps when we are doing IO against, for a
>>     data write or read operation, we are just spending a lot of time on
>>     this and consuming memory too.
>>
>>     Then it's silly again because we will search the fs b+tree again, starting
>>     from the root. So we end up visting the same leaves over and over;
>>
>> 3) Whenever we find a hole, or a prealloc/unwritten extent, we have to check
>>     if there's pending dealloc for that region. That's where count_range_bits()
>>     is used - everytime it's called it starts from the root node of the extent
>>     states rbtree.
>>
>> My idea to address this is to basically rewrite fiemap so that it works like
>> this:
>>
>> 1) Go over each leaf in the fs b+tree and for each file extent item emit the
>>     extent information for fiemap - like this we don't do many repeated b+tree
>>     searches to end up in the same leaf;
>>
>> 2) Never create extent maps, so that we don't grow the extent maps rbtree
>>     unnecessarily, saving cpu time and avoiding memory allocations;
>>
>> 3) Whenever we find a hole or prealloc/unwritten extent, then check if there's
>>     pending delalloc in the range by using count_range_bits() like we currently
>>     do (and maybe add that patch to avoid always starting the search from the
>>     root).
>>
>>     If there's delalloc, then lookup for the correspond extent maps and use
>>     their info to emit extent information for fiemap. And keep using rb_next()
>>     while an extent map ends before the hole/unwritten range;
>>
>> 4) Because emitting all the extent information for fiemap and doing other things
>>     like checking if an extent is shared, calling count_range_bits(), etc can
>>     take some time, to avoid holding a read lock for too long on the fs b+tree
>>     leaf and block other tasks, clone the leaf, release the lock on the leaf and
>>     use the private clone. This is fine since we start fiemap we lock the file
>>     range, so no one else can go and create or drop extents in the range before
>>     fiemap finishes.
>>
>> That's the high level idea.
>>
>> There's another factor that can slowdown fiemap a lot, which is figuring out if
>> an extent is shared or not (reflinks, snapshots), but in your case you don't
>> have shared extents IIRC. I would have to look at that separetely, we probably
>> have some room for improvement there as well.
>>
>> I haven't had the time to work on that, as I've been working on other stuff
>> unrelated to fiemap, but maybe in a week or two I may start it.
> 
> It took me a bit more than I expected, but here is the patchset to make fiemap
> (and lseek) much more efficient on btrfs:
> 
> https://lore.kernel.org/linux-btrfs/cover.1662022922.git.fdmanana@suse.com/
> 
> And also available in this git branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/fdmanana/linux.git/log/?h=lseek_fiemap_scalability
> 
> Running Pavel's test before applying the patchset:
> 
>      *********** 256M ***********
> 
>      size: 268435456
>      actual size: 134217728
>      fiemap: fm_mapped_extents = 32768
>      time = 4003133 us
> 
>      size: 268435456
>      actual size: 134217728
>      fiemap: fm_mapped_extents = 32768
>      time = 4895330 us
> 
>      *********** 512M ***********
> 
>      size: 536870912
>      actual size: 268435456
>      fiemap: fm_mapped_extents = 65536
>      time = 30123675 us
> 
>      size: 536870912
>      actual size: 268435456
>      fiemap: fm_mapped_extents = 65536
>      time = 33450934 us
> 
>      *********** 1G ***********
> 
>      size: 1073741824
>      actual size: 536870912
>      fiemap: fm_mapped_extents = 131072
>      time = 224924074 us
> 
>      size: 1073741824
>      actual size: 536870912
>      fiemap: fm_mapped_extents = 131072
>      time = 217239242 us
> 
> And running it after applying the patchset:
> 
>      *********** 256M ***********
> 
>      size: 268435456
>      actual size: 134217728
>      fiemap: fm_mapped_extents = 32768
>      time = 29475 us
> 
>      size: 268435456
>      actual size: 134217728
>      fiemap: fm_mapped_extents = 32768
>      time = 29307 us
> 
>      *********** 512M ***********
> 
>      size: 536870912
>      actual size: 268435456
>      fiemap: fm_mapped_extents = 65536
>      time = 58996 us
> 
>      size: 536870912
>      actual size: 268435456
>      fiemap: fm_mapped_extents = 65536
>      time = 59115 us
> 
>      *********** 1G ***********
> 
>      size: 1073741824
>      actual size: 536870912
>      fiemap: fm_mapped_extents = 116251
>      time = 124141 us
> 
>      size: 1073741824
>      actual size: 536870912
>      fiemap: fm_mapped_extents = 131072
>      time = 119387 us
> 
> There's a huge difference, so after it fiemap is a lot more usable on
> btrfs.
> 
> It's still not as fast as ext4, but it's getting close to. On ext4 I
> get:
> 
>      *********** 256M ***********
> 
>      size: 268435456
>      actual size: 134217728
>      fiemap: fm_mapped_extents = 32768
>      time = 16877 us
> 
>      size: 268435456
>      actual size: 134217728
>      fiemap: fm_mapped_extents = 32768
>      time = 17014 us
> 
>      *********** 512M ***********
> 
>      size: 536870912
>      actual size: 268435456
>      fiemap: fm_mapped_extents = 65536
>      time = 33764 us
> 
>      size: 536870912
>      actual size: 268435456
>      fiemap: fm_mapped_extents = 65536
>      time = 33849 us
> 
>      *********** 1G ***********
> 
>      size: 1073741824
>      actual size: 536870912
>      fiemap: fm_mapped_extents = 131072
>      time = 69085 us
> 
>      size: 1073741824
>      actual size: 536870912
>      fiemap: fm_mapped_extents = 131072
>      time = 68101 us
> 
> However we do have extra work to do on btrfs because we have reflinks
> and snapshots, so it needs to check if extents are shared, while ext4
> does not have those features, thus less work to do for fiemap.
> 
> Thanks for the report.

The results are amassing, would try it on my system. Thanks a lot for 
the fixes!

> 
>>
>>>
>>> -- 
>>> Dominique

-- 
Best regards, Tikhomirov Pavel
Software Developer, Virtuozzo.
