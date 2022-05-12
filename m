Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA6F52580D
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 May 2022 01:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359341AbiELXBW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 May 2022 19:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359340AbiELXBV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 May 2022 19:01:21 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D063981C
        for <linux-btrfs@vger.kernel.org>; Thu, 12 May 2022 16:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652396475;
        bh=8hbISZX11UQUheF0Pa+fPhlglqFcEzYpgDFG6SwZYoE=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=i97ltXqTVpmRcp7deuXAkUiGQg7opLli4o6DKbvWlH6vxT5pdnkUF2+7ptCYXqUGJ
         Rm0wM7O0/i94I9tU4KZwwBjUUQ8TaD+UKjNjCsfOhFeDVJJURGuujV/RZ5b4xsR/y3
         IUEn+ZMw4QUoj/wSoniC9OGAAc5+PLIEjORhOMB4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mkpf3-1oCZOP2V5D-00mOCe; Fri, 13
 May 2022 01:01:15 +0200
Message-ID: <fc35699e-236d-655c-bb2e-7dc1748b50fd@gmx.com>
Date:   Fri, 13 May 2022 07:01:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1651559986.git.wqu@suse.com>
 <20220512170857.GS18596@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 00/13] btrfs: make read repair work in synchronous mode
In-Reply-To: <20220512170857.GS18596@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KxAzbk0jPBMUx/CxfhTW5IIr2l2yHfMfgZG5rMtxSSwmEMvC9vw
 PItQRxy+TiZwB6rPZPBtYoeHQDfTd5rQ1zuzipp0qgxta7gGI51nt4MKUJ+CjADJPpvMRta
 GMNu3eRzRzc/vjbCY4qeXV2FJ0HuyYuIyDZZRFednpnNSaLY89SgoZGPq7GfkdJVX4R0TJw
 epRX10a01H/PsgHjLm4Aw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mNnGlJHbwaI=:YQSklQXNAqketBU10/NLl2
 5ATv5Rjh9CuobXWaNtkv9uEuHUweiWAFLRdyQvOLnET8nnTgaeWao0igMpKO7J7Hf4o/H0JCj
 jpCjmQVLYrMK+kDa/23/rbpDiXe5EvfCyaM7ZH6Tl9+QXM62jYq69A2HwAfTrkWtD3upVevjR
 ngnXn3QMVkHqHMTUI2MPCH+9NJmFBMaKIjizde4QxFri3vZc/Eftn8IMF7Q1syj0vemhe4STw
 FS7oV8TA4Fe6vzluUwzC5G9iAdjoSEqhGg+Qmf9+b3joTvJKvVyWsa5Gc05f5nqSbHfRFdAEN
 okIH0tdOK8yTyJQEZUm3AhX9Ytze/eIgzRexrwygFYKRpb83rj5wQyLLpT7p+3i8aMddE8xc/
 KhFjmsffuj3WlqjGdTv1lm5qT+Ji1OROygHh7SauG3re8sHNAXOI19LWldgF7H1aXjTqhMULl
 i/nprAGMdU7ROqNWfzk7NV/ckNKSOcN18wG+m187nIBA0uYQ4ILOamtnBopXns9UCqF3dat1r
 9L3vfsPAxB78DbAKjVA+xV2KBusdoGA1kX3lX/7+qWFA7fvmc8GNcOCr1QP1I0s93zRWRYUws
 D1neRNrmrSIzsYXp8Suj7B4yuhJB4HGS9tnSMvhD+JQQp3sXIKzAu8fP94spCjKHyBWhzHHmO
 ohITo4ReJkde3KMze0s2ia6zOjrelWnb/CzPOaQeyPPkvSZncwdl+XuAGyGGFUrZWp5fAXMmY
 yiFrzntDBR8RHsPc8yDQs8wPjXIOcPt+HbEQ75E2TapDdZx8jvsr7XDDoRvn/wVqz2P/+t1ec
 afRTjJq9ZfBylRBn2tGA+kjLQdPvbczkRknexrErVtCQ229vIF0FfKSJPWBezWqo1GryEBJWw
 w3dqWTTSFGM4Wr36aK2Y1njTEVmeccEVX4NbqxbDYpDjrKnu86EfC3t2F77UCp8Pu8wp0UPFJ
 vvRecrfKqgDm2cwSesCXUsay1LCVOC5mYDrH0gh3YIVg5oTbhFg0vNPJ012A8K0Lkt6wDkOIO
 KBHKEN3Lcm5G4X/Gl6MNtTEc5YcDtDTB69hpoDe4yP15gLD6lzZzEYgVWeLLlgirfXP2DAkwa
 9ofcxZLW68YxSBQ/5VrotslauKJ6EzNMcQCAmPjHVuehm5Zk6FGXwiXNg==
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/13 01:08, David Sterba wrote:
> On Tue, May 03, 2022 at 02:49:44PM +0800, Qu Wenruo wrote:
>
>> By this we can:
>> - Remove the re-entry behavior of endio function
>>    Now everything is handled inside end_bio_extent_readpage().
>>
>> - Remove the io_failure_tree completely
>>    As we don't need to record which mirror has failed.
>>
>> - Slightly reduced overhead on read repair
>>    Now we won't call btrfs_map_bio() for each corrupted sector, as we c=
an
>>    merge the sectors into a much larger bio.
>
> I thake this as the summary points for the whole patchset and frankly I
> don't see it justified given all the new problems with the preallocation
> and shuffling with the structures. What we have now is not perfect and I
> would like to get rid of the io_failure_tree too, yet it works.

Indeed I have no better solution for the bitmap.

I have one very limited optimization for it, e.g. if we hit profiles
without any extra mirrors (like RAID0/SINGLE), we skip the preallocation
and just error out.

But that's all, we have to allocate the memory, and since I'm neither a
fan of mempool (nor a good fit for variable length bitmap), we really
only have two solutions:

- Allocate bitmap when we hit the first error
   The way I did in previous RFC version.
   But it also means, if the memory allocation failed, we will error out
   without reading out the correct mirror. (Christoph is strongly against
   the error path)

- Preallocate bitmap before we submit the bio
   The way I did in this version.

Now I think the first solution would be more sane, no change in
btrfs_bio (which is already big).
And the memory allocation failure will not really cause any bit damage,
VFS will re-try a read with much smaller block size.

>
> The main point is probably to stop reentering the functions, though the
> idea of having a single tree that tracks the repair state and there are
> callbacks dealing with that is not IMHO bad design. The alternative is
> to complicate data structures and endio handler. I'm not sure if it's
> worth the risk.

The point of the repair work is a first step towards less members in
btrfs_bio.

In fact, all logical read/write should not really care about read
repair/csum/mirror num etc.

Thus it can be hidden into lower layer, thus my ultimate goal is to make
logical layer to only use plain bio completely.

But the existing read repair is a blockage, thus why I'm purposing this
patchset.

Thanks,
Qu
