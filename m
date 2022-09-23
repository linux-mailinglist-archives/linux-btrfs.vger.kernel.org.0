Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37E55E7A0B
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Sep 2022 13:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbiIWL5G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Sep 2022 07:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbiIWL5E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Sep 2022 07:57:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7C625298
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Sep 2022 04:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663934219;
        bh=QLu5UPkH6eJ+xytkpprQM/yxh2t4J/gNu7j5uF+//i8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=DKniKn6i9jyXJjKgeVwrKl4vafZKZGfRcrNt2a1/6KgJ0RahfIyjxSsXkoTUFor8H
         gOHl9KMULI4Mr2L6RrI2jRcaUIvt+TmD4UspZ59GQnKkQsHIJz4YJtDgwV4TyORrZq
         zYWZ03+pDH6ymSW6VFVmtkZAOilRPjBfQw6EwvWg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MN5iZ-1orz8J31oz-00IyOr; Fri, 23
 Sep 2022 13:56:59 +0200
Message-ID: <5f23506e-a505-0a37-5ceb-c55a02b114ed@gmx.com>
Date:   Fri, 23 Sep 2022 19:56:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] btrfs-progs: btrfstune: add -B option to convert back to
 extent tree
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <18c52a4ae1bb038beb16ad6d011d6dbe10321922.1663917740.git.wqu@suse.com>
 <20220923103945.GQ32411@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220923103945.GQ32411@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ypiVH47jHRoKAAB4zkkeku9SHlKiZWbxebBLVlUJaZ1AIfF7ZTL
 c68kGGFCTltMxylIw4w9Ys0+gMt0lC/bdZw2VCO2nxgy8a6as6tL0dstcIAGc2WIxWSomzw
 Qxc8BOKrk9WW2BeyKuoEqfh318B4+t6hGdZwtTWzZInNIT7B9esV+GFXDr3F7O7TLNPj5Tv
 vM4u9Y6sG/7zwl0bYoFRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5ock2hSFEPo=:SN9CWdVAtnTlrugmdoX1IU
 9B6HtOzYYz8mTgDMoTN8tNoK2NK64wU5KTYfFTZojfpVtgmbETD/7wQ4asyS534w7ok0FFp6G
 g0k5gd9h90ibLXNDPozz07V4je/lFPpJ2PmvGgrFuRBk4uVhG/BxL6GnNSPI5KYNUjWZWXr2q
 xzfu1kKn+4h+HT0O+xKKnPbH7Jn24som7/SD1ehDRqyDdNmfL84PAeha/333lIxmSmhTRvOnI
 BGhpslIncXos68H/98wZ2adfBMD9hYYCHIEc0etzel1g5cPo18CWNXQHp/pj3bQzhFoy5OmQ8
 raHk3McdHtaKfUysOFQyuTv9W3aNcTazYr+ynI0hAE4rFzfz0Kjse14mEL9981BycmP0ZrSaE
 Ky5lPhcl2Vo6ijpb6MhhTmeMrpFiujK7tiSC7assxkolzFakz2jS1ycpy/J4YpiChmjJRwLck
 Y/8KuP0lu17HyaaNPT2nB0wul2OXiXNuYqViHvc6lxZDVydeJjBRs7ksECB3DiyuG4ABVpet7
 9MFZ/mbwGxTgfe7X2q/qhTf788DZJ5p1NuEqLLxtnSu42Iozubx1gJ+8Ulm3v+ZPLjJbE0vy9
 zOlS3cZ2sxHInUGTZUZ6XOmWQlk5/vj+JL1UqMzrn9H3YFxzhn4bVDrAK9s4ifmXLtLl6HruV
 SlujKTTxO7kuCbGYOfPH4KtmeMr/anJTCehZqUyVv8LLOtGZTq+FHmrm0VhSVWyMkDI6Zotnr
 jlvB3X2QCf88lx9pACx8wCM4YrFoOKZyiQQ0wsd9xkHsbOvahV9dpWrxDbbBkEd1y6Gcx5boX
 FV2DLcRpgcCl9TCHXIhAs+L4dkj5q0QoPLwEieXRoNHDWZkDLcrKVMytfFFs/U/SjswRBrm3S
 N/jt9U2ElGJ9jV/nC7XU/WSeqPcYdFTuMB8CcP+PHCp1ZmLz9OQGGPRXjK6hSXJdO3ghoiQn8
 r4BAOI7RmYs6s5jNpgElS0VZm2cCPAbU7znD51JfkulaygrJVmP/+dsPanwMhs8s4aFzPwKzO
 0tbfAniq4uEi1p6lf4Sgv4bfrXEnsuE//l1qjRJs8TvIhlipF7QE2lQ2eudA04f08D7ISPquI
 0aTjfG+bEABlDEMGaHC5Z6aKQAMveZMyEzJd5m5qpbo9IlvOA1iWxZItZ1KIIsUTCVLZ5YmTr
 Ifn29HJU8e+EBfOxKqYFg1jbcN
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/23 18:39, David Sterba wrote:
> On Fri, Sep 23, 2022 at 03:22:44PM +0800, Qu Wenruo wrote:
>> With previous btrfstune support to convert to block group tree, it has
>> implemented most of the infrastructure for bi-directional convert.
>>
>> This patch will implement the remaining conversion support to go back t=
o
>> extent tree.
>>
>> The modification includes:
>>
>> - New convert_to_extent_tree() function in btrfstune.c
>>    It's almost the same as convert_to_bg_tree(), but with small changes=
:
>>    * No need to set extra features like NO_HOLES/FST.
>>    * Need to delete the block group tree when everything finished.
>>
>> - Update btrfs_delete_and_free_root() to handle non-global roots
>>    Currently the function can only accept global roots (extent/csum/fre=
e
>>    space trees)
>>
>>    If we pass a non-global root into the function, we will screw up
>>    global_roots_tree and crash.
>>
>>    Since we're going to use btrfs_delete_and_free_root() to free block
>>    group tree which is not a global tree, this is needed.
>>
>> - New handling for half converted fs in get_last_converted_bg()
>>    There are two cases need to be handled:
>>    * The bg tree is already empty
>>      We need to grab the first bg in extent tree.
>>      Or at convertion function we will fail at grabbing the first bg.
>>
>>    * The bg tree is not empty
>>      Then we need to grab the last bg in extent tree.
>>
>> - Extra root switching in involved functions
>>    This involves:
>>    * read_converting_block_groups()
>>    * insert_block_group_item()
>>    * update_block_group_item()
>>
>>    We just need to update our target root according to the current
>>    compat_ro and super flags.
>>
>> - Various misc changes
>>    Like introducing the new getopt() option and help strings/docs.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   Documentation/btrfstune.rst |   4 +
>>   btrfstune.c                 | 154 +++++++++++++++++++++++++++++++++++=
-
>>   kernel-shared/disk-io.c     |  11 ++-
>>   kernel-shared/extent-tree.c |  93 ++++++++++++++++++----
>>   4 files changed, 245 insertions(+), 17 deletions(-)
>>
>> diff --git a/Documentation/btrfstune.rst b/Documentation/btrfstune.rst
>> index 01c59d6dbf3b..be2a43750b16 100644
>> --- a/Documentation/btrfstune.rst
>> +++ b/Documentation/btrfstune.rst
>> @@ -29,6 +29,10 @@ OPTIONS
>>           Enable block group tree feature (greatly reduce mount time),
>>           enabled by mkfs feature *block-group-tree*.
>>
>> +-B
>> +        Disable block group tree feature,
>> +        mostly for compatibility reasons.
>
> Please use only long options, it's becoming unwieldy for btrfstune,
> we'll need to add for the rest too. And maybe it's time to move it under
> the main tool as there aren't only one-off actions. The big question is
> how to organize it in the command hierarchy, I'll need to think about
> that. Until then the btrfstune will be enhanced.

Finally we're going to integrate btrfstune into the main program.

Personally speaking, I have no preference between long and short option,
so it would work for me either way.

But I really want bi-directional conversion, not only for the bg tree
feature, but also things like no-hole/skinny things.

Thus what about "btrfs tune/convert feature 1/0"?

And of course, we should give warning/error if one is turning off some
default feature.

Thanks,
Qu
