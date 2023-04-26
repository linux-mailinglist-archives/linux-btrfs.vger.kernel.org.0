Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8058C6EF3A5
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Apr 2023 13:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240415AbjDZLug (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Apr 2023 07:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240408AbjDZLuf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Apr 2023 07:50:35 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B92422D
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 04:50:32 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MPokN-1penTI2lNL-00MvJK; Wed, 26
 Apr 2023 13:50:24 +0200
Message-ID: <2936900a-a62e-8d27-1098-9505cc95a890@gmx.com>
Date:   Wed, 26 Apr 2023 19:50:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/3] btrfs: print extent buffers when sibling keys check
 fails
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1682505780.git.fdmanana@suse.com>
 <14f4089a9d26606c7a15e398536ca75f9c484c9c.1682505780.git.fdmanana@suse.com>
 <84ed9592-ac1e-8344-c0f6-4e114b2835ec@gmx.com>
 <CAL3q7H7B3Cyn9RXzT24u+x2hjgmWjNCrMBJ-WHjGP5Cs-kUFjQ@mail.gmail.com>
 <6377fb9d-fec9-6c2a-1f38-6ffd775eb773@suse.com>
 <CAL3q7H64Gk9hXNgtgH2CAha=EpS9oFirgoyFjVCsqusa6hCJzQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAL3q7H64Gk9hXNgtgH2CAha=EpS9oFirgoyFjVCsqusa6hCJzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Y0+nMkjjZdq8MAWxUeedzROVMiXWRuhn6iyPwLyBavxpAOrkW49
 Ecw52QiZVTTwdXHvud0GwrSXishWvdoQpH31myTpb4v8Fx1zRQGKlxt+VuPOnmOzSCkmQ4M
 482Lw9srYXAGQFtuf9q3DTxWBKFnNj/gHw9AXCxH9DEXOpMihsrSKelYzAtT0rhZ2zYxJ8o
 ZekgiYus6MEIKTUiliiVw==
UI-OutboundReport: notjunk:1;M01:P0:V2t55CWH3Eo=;AzTr66gNQ/KO34mPYqe/p3y3dUv
 WigSIJDo3yf2ZH+Fnn1nwd9hJYouQLIhxziQsazgT4ExoiVKZvGIGLwCjcXTTwuVyHxS1AgB0
 rfDx8R/c6zVQm240Wv/42lLlvi5MRs9arYEodqjhWqbtfXgL8De6D3qniL4obHzv7C1W4SnUT
 ns+88CDvpnWDRdxMmLujuet2E31h6x4OQPbz4ZjKvS+oW3FxF0CZoB0fyvmgE/NRUAfOpyKid
 BwgVlekjUuwWW0UJaeoSf426nH674WCcIkO87ZhVAxqzNHzvTuTc87DP0o/BHiJmEaQVHNMp1
 vH+ziL7tIkvzrE76QSj3jljEsoqBh/FrFOggT1eJ3owza7wjijbXyVgqASlWMiAU55Zc/mu2J
 HFkddLBvYl0Ub1pPgx7uiHOGZyaAqSKyFMo3yDX3CdMeJgrW6Xr6pFKybGDUnnfGkd7pTCsk6
 K1ENRGA2YoEqEkNF2a6I0vlj8w5rYHX0hEAfuJ5gU4rMj3Z2Gl9yRvzrjv89iqhMhCSiyyINX
 UGKLpOZa23t08/0+I/jensZAS009+5Tdr0Uv6iLx1JVZFAVYFSGQ6RLSAm/XrvpFtASeMpq6l
 X63Ll0QyGBD54FxAOgDE5hOnDmFpHEJ8oU2VqdFjs5o5B8SZiVCaqJh7VJHMVraB0odeCaAc0
 9cG4Vfe5rjXOgBu+CQk26c0il5JixEi8M1nG4N5lqU6CmOUHc4RDnyQ7EOOwzvUlbFW69oZaM
 b/mT5qtZPYcjaYqVYHK7ShDLY5HDFiiU7BH3c1+Mp8T2mHfk7c5+RJm+aD2rKcz2yR/spjAY6
 l8hSZKrH1YaLwv+cqbJWdBV/w5k7RaIc8ANpEfxDG49BEVMyQDdqVgpvUQlQKgqcMc0O4AXNd
 Cr3bBuANnAggVa/fowBHikpelEW1i10t1jOutQl1DkSbdBsYFYl3wFOHzm6aFyx02UCNI28Ta
 OrIeK33RWgswLk71ucE0wNrqnho=
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/26 19:44, Filipe Manana wrote:
> On Wed, Apr 26, 2023 at 12:40 PM Qu Wenruo <wqu@suse.com> wrote:
>>
>>
>>
>> On 2023/4/26 19:31, Filipe Manana wrote:
>>> On Wed, Apr 26, 2023 at 12:21 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2023/4/26 18:51, fdmanana@kernel.org wrote:
>>>>> From: Filipe Manana <fdmanana@suse.com>
>>>>>
>>>>> When trying to move keys from one node/leaf to another sibling node/leaf,
>>>>> if the sibling keys check fails we just print an error message with the
>>>>> last key of the left sibling and the first key of the right sibling.
>>>>> However it's also useful to print all the keys of each sibling, as it
>>>>> may provide some clues to what went wrong, which code path may be
>>>>> inserting keys in an incorrect order. So just do that, print the siblings
>>>>> with btrfs_print_tree(), as it works for both leaves and nodes.
>>>>>
>>>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>>>
>>>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>>>
>>>> However my concern is, printing two tree blocks may be a little too large.
>>>> Definitely not something can be capture by one screen.
>>>
>>> What?
>>> If I check syslog/dmesg, I can certainly access hundreds, thousands of lines...
>>>
>>> I suppose by "capture by one screen" you mean a screenshot?
>>
>> Yep, mostly a phone shot of a physical monitor, which a lot of end users
>> choose to use to report their initial trans abort.
>>
>> E.g.
>> https://lore.kernel.org/linux-btrfs/f057bdd1-bdd9-459f-b25f-6a2faa652499@betaapp.fastmail.com/
>>
>> I guess the reason is, if the trans abort happens on the root fs, there
>> will be no persistent log files anyway.
>> (Although it's still possible to pass the dmesg to another machine or go
>> netconsole, but not everyone has such setup ready).
> 
> So what?
> I don't see how that invalidates printing extent buffers... Many users
> are able to access dmesg/syslog
> and paste what they get there... It's also useful for development
> where we can certainly access everything...

That's why I gave the reviewed-by tag.

Maybe we can shrink the output to the first several and last several 
items in the future.

But for now since it's just a trans abort, it should be mostly fine for 
the end uesrs to access the full dump.

Thanks,
Qu
> 
> 
>>
>> Thanks,
>> Qu
>>>
>>>>
>>>> Although dumping single tree block is already too large for a single
>>>> screen, I don't have any better way...
>>>>
>>>> Thanks,
>>>> Qu
>>>>> ---
>>>>>     fs/btrfs/ctree.c | 4 ++++
>>>>>     1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
>>>>> index a0b97a6d075a..a061d7092369 100644
>>>>> --- a/fs/btrfs/ctree.c
>>>>> +++ b/fs/btrfs/ctree.c
>>>>> @@ -2708,6 +2708,10 @@ static bool check_sibling_keys(struct extent_buffer *left,
>>>>>         }
>>>>>
>>>>>         if (btrfs_comp_cpu_keys(&left_last, &right_first) >= 0) {
>>>>> +             btrfs_crit(left->fs_info, "left extent buffer:");
>>>>> +             btrfs_print_tree(left, false);
>>>>> +             btrfs_crit(left->fs_info, "right extent buffer:");
>>>>> +             btrfs_print_tree(right, false);
>>>>>                 btrfs_crit(left->fs_info,
>>>>>     "bad key order, sibling blocks, left last (%llu %u %llu) right first (%llu %u %llu)",
>>>>>                            left_last.objectid, left_last.type,
