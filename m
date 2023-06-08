Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E85727E79
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 13:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbjFHLIC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 07:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236044AbjFHLHD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 07:07:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F3B30D6
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 04:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686222302; x=1686827102; i=quwenruo.btrfs@gmx.com;
 bh=c9FQpRmZrSPLu1UsLDInjLCBDesuSI/glMh1LJ2ctv8=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=MQP25G1LFt6ROMXl8z3qo0kurgyElZF5oGvaliCXIGGYH+/vAsFDG79VdHs2DYpuBc73n0A
 1bV6T3gnvdc1nb+b6p31GEZrs5EP1Wyw7TtAUMX2czC5dc5FaNIlfp1Xz6cTHFq3mnjz2N55O
 eMbM7K52b5dizPpD4+UsU5NRr+Zlsv6eESRMZiVeaYsU2WI3x4CPkTafG5/WMkiEGKDThTzAk
 +674xP0TXxcdyCEr/gzlPJG/GHjv0/ajyhcplKR+o3nOhaayr7jNiaRAb+19azZyh7h7Fxow2
 b8YjfFbPrPCVB4J6q9DgCB9oxiP+KaSgNCgRqbq2RycBO1yTcRSQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MLi8g-1qOspB26HQ-00HcPT; Thu, 08
 Jun 2023 13:05:02 +0200
Message-ID: <6fad1671-c0ee-a450-1936-17493563e3d8@gmx.com>
Date:   Thu, 8 Jun 2023 19:04:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 07/13] btrfs: avoid unnecessarily setting the fs to RO
 and error state at balance_level()
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1686219923.git.fdmanana@suse.com>
 <f566e1432b19f82d9c647b1c0e8e43743818bd7a.1686219923.git.fdmanana@suse.com>
 <dda1adff-2813-0ff8-1f88-fe14cc73c9eb@gmx.com>
 <CAL3q7H7=T8HP+Q-OTqNxjtQDOZQS1KbRHEwX=kLv4UoZBd6MEQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAL3q7H7=T8HP+Q-OTqNxjtQDOZQS1KbRHEwX=kLv4UoZBd6MEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w3kIaYjud1hfji1X5WD4fdKRz2iW8//cwDtfYW3g/Umhy+Nfr55
 Inl+P7JKcYa9NNROxZJqWKLZIdj/gFUK/7TORuLrjztD0EBbhS1YCZv/QC1/iWgEBzf1jV9
 wEQm+Gh7lTlmre3ZSh9OprRp018A3y2TBNJKHd5ZnQNttcmngyR45qvcYABgLC/o8IlGzQY
 iabSu8u/NWbOV/9VkDqdQ==
UI-OutboundReport: notjunk:1;M01:P0:aL43s5344+w=;pf7KsiKNJfqdLHgqSoZk58FWOmG
 HWZQSsLWDHesdntHvFzg6shSpBcCz83hUI6go/RcEjZZmtSq9Xi6TkTX6pTT5+FqyeSs8ek55
 JpV5ibWqRBIdfUxAiYP9/Hzemw0o7BfA4QIX+Dy4yTAoUZdZo1HyNOO1s0eJ51OgJqRl9ieGy
 JSnrN6SCH5cnzgmOhXv94UYuZuNWRt4ZugvH7IoAEzqacavI8qWiTagWnIhQekMDAFVtPD8Ov
 tbcG12dBSM55AmfsNC9BiZR5whRmtg3hD1ZglIApWoItKXhbe8DYgRQbmOawKBAG2bJU7sh/H
 TaXR5/kXggukfDZAZ5466CCVEEOdIQ1MDisfnc82OuqjHb49KslFdy+9AnPivW8baBWsQUUe+
 MXTyaqBtETa1EVonC2pw2fBSY0aS9AqJ1NaUGDFc2PO5IFUreF01q373XSExAk3tUJ9oL/oyj
 tUL8XFc+/XrEqY/pimciFIRGU0SRBucm7lu6xJXhCkARu3ddTwghcBGNPR/eq5p+klbJhP73h
 GOsIjy2ZVMxWBnvETHeF7RAfERme/3oC3BBBZwzRCB6RGK+Uc0v8MnEDjnvpROlMFUJB7Q063
 /oIi6KdR/ohjASYgiBb+O0iK8x0+amFsvAMwG2RSsbP2ishVovM+CwW1400Tapqx5VOu3ZOZg
 aUp+O+EO0VbqzL4GpF6ui7KQALxGZ7/JGkypkQuT0E7M1uGELE6vbqMIbLElXMXkQw3pNUpGc
 DP2oxQuZ0nr3nEAjVVDgvyYYk/iPgMyhobBbYD9Btgr0IIn1+0i1Qx33zavBsU07TGoBdUvUC
 XKn8Eyi5dw5FJXirRGUqwUSRCOoimUlvsFQynERkkQBmSWkyTzeycPbHNxdMUFPigXwPy6/PK
 A5+PMQv5dGQdZ7ZS/upOKI+RvKsw3UWrZger3rRHId5oHfkK1FReyk5LKIx14MoyeNfbJf/Tl
 NWzyKju+HZ7VH6MW5JNK+5mqqQM=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/8 19:00, Filipe Manana wrote:
> On Thu, Jun 8, 2023 at 11:51=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
>>
>>
>>
>> On 2023/6/8 18:27, fdmanana@kernel.org wrote:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> At balance_level(), when trying to promote a child node to a root node=
, if
>>> we fail to read the child we call btrfs_handle_fs_error(), which turns=
 the
>>> fs to RO mode and sets it to error state as well, causing any ongoing
>>> transaction to abort. This however is not necessary because at that po=
int
>>> we have not made any change yet at balance_level(), so any error readi=
ng
>>> the child node does not leaves us in any inconsistent state. Therefore=
 we
>>> can just return the error to the caller.
>>>
>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
>> Although I'd like to add some comments on the error handling.
>>
>> The catch here is, we can only hit the branch because @mid is already
>> the highest tree block of the path.
>> Thus the path has no CoWed tree block in it at all.
>
> Even if it's not the highest level, there's no problem at all.
> COWing blocks without doing anything else doesn't leave a tree in an
> inconsistent state,
> as long as each parent points to the new (COWed) child.

Oh, you're right, I forgot that the newly COWed tree blocks should
always be accessible from the root node.

There is no problem at all from the very beginning.

Thanks,
Qu
>
>>
>> If the condition is not met, we will return an error while some CoWed
>> tree blocks are still in the path.
>
> As said before, the COWed blocks are fine, the tree is consistent as
> long as each
> parent points to the new blocks.
>
>> In that case, a simple btrfs_release_path() will only reduce the refs
>> and unlock, but not remove the delayed refs.
>
> btrfs_release_path() is never responsible for adding delayed blocks.
> That happens during COW, when we call btrfs_free_tree_block().
>
>>
>> Thus this is more like an exception, other locations can not follow the
>> practice here.
>>
>> Thanks,
>> Qu
>>
>>> ---
>>>    fs/btrfs/ctree.c | 1 -
>>>    1 file changed, 1 deletion(-)
>>>
>>> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
>>> index e98f9e205e25..4dcdcf25c3fe 100644
>>> --- a/fs/btrfs/ctree.c
>>> +++ b/fs/btrfs/ctree.c
>>> @@ -1040,7 +1040,6 @@ static noinline int balance_level(struct btrfs_t=
rans_handle *trans,
>>>                child =3D btrfs_read_node_slot(mid, 0);
>>>                if (IS_ERR(child)) {
>>>                        ret =3D PTR_ERR(child);
>>> -                     btrfs_handle_fs_error(fs_info, ret, NULL);
>>>                        goto out;
>>>                }
>>>
