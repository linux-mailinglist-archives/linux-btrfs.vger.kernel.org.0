Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D4B44BBFF
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 08:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbhKJHQh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 02:16:37 -0500
Received: from mout.gmx.net ([212.227.17.20]:33593 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhKJHQh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 02:16:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636528421;
        bh=sQiWrKmtmhD1kBIs7XbwKEAf69e3kq3MKQSTGymXGxE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=TQDKa77kQtQG8qe68ysgmlgHs1k+ok0WqwxFcc6bIcTPJ33SQJzEoo6kCQcnAfi7A
         XAC9mWO1Yu/H/ewqGqWWw9oHdcVIeLcxpXX6VKRqHmYqrz/+cokjOsdYwo40RMNtHP
         IIBETlnbCAg06JpOAlDJH1jbunyzDWjZlfiMABqw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAOJP-1mqSI33fJ5-00BvnF; Wed, 10
 Nov 2021 08:13:41 +0100
Message-ID: <e58230c4-1536-dca5-7e1c-1b6a4a0321bb@gmx.com>
Date:   Wed, 10 Nov 2021 15:13:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 7/8] btrfs: add code to support the block group root
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1636145221.git.josef@toxicpanda.com>
 <6e96419001ae2d477a84483dee0f9731f78b25bd.1636145221.git.josef@toxicpanda.com>
 <749db638-d703-fd30-4835-d539806197cb@gmx.com>
 <YYl8QTnLySc5hDRV@localhost.localdomain>
 <d9ada670-7d11-c1fd-2e15-b1794375c45b@suse.com>
 <YYrK1QVmJhiG2vDc@localhost.localdomain>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YYrK1QVmJhiG2vDc@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1://SnBFc3dIx2Vb4ahV07WHdqjFEMu1hW/i0aaksNaMDaUWbsPmO
 6VFvNGkoN6F3ByQMdopy6XqkoT4Owd/skwF22Vi4MjniqZBZW40HWdCllyaSG09vueJyWLP
 XpYr5XwnBKHLPvU7WnezX2tMUSD1MHuXBWpuvS/sB3XF/9G2Vroy7Py9QkT59tS+V+Mqs/2
 h6dj8PeWN6mSDvqU3k2Ag==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:59rYba8ksvQ=:BOUWrCcizWVdaTj22TzBYJ
 6ydvXlcaeWmYNucwpkc1GqnmSMyMUScTmxF/MAvhS4C3jcHKpiU84YEX+6QIKQ77EEB/S+b9i
 XJ2Bx8HfyAwuwmQS2nKy7Y3locmpT1M8TDlRjdW+ICAY3iuBCqWrBz5uXsyE+vM7xCp9hG2/x
 Skc0H7OxU1YpwIF+E0EZRSZ8Y+9web+ldK/JtKzg/kxuWbERHcn02SMANmZhINdrnzLRSQGHM
 pilUVHyJnLgO8qXf4DaO595i/zXbO26qiiCOHbLgs13EmRXGBZiNMCdw4WassgGfMdJFw+Xqp
 FZsy2UQpxixedcMD3GbYYtvVPGuVjg65djlW1HOJMzQP02BiDsaWYLnOsRbyRNIpWaKsaWRjn
 Wv19ZBrsX6Dz7tsEejHLXxHF+OrdYmoNSY7Qhb+yV2uIfMcvjaQO1dWn14QWkuG3VZJyxh+uL
 CF4f2DcTp0d0b34but+qrG7eFHu7P2ZmsGDE4J2cXQEobKmQ0+rs+78CRhddAYJljf4+r0i6K
 5q0VITLQ1VRhWzIF3Rolnws1JHE3NIYUp4hf7P6bXhUhTNj5DUjLSmQ5Gqbol6EmCGTEY7sv7
 COp2qoZ+MkjYzVvazG5eEEdAlMQvFagMpuy7CGU2NVos8bs9Hd7gm65Rki3N4S17VfHmFVQYq
 R4CdKz47wm+ayjrX8XErFN0KM2//s6OolkdUJokzqvZZuy48CWocNNKrYmlA4e7qJdGOSQMFu
 9wLbjcGHcgPidh3AUxai0NuPrS5eiWI6sh+HDAHD3q26b71U5tTweQNovGQpPMcb/68cw+2QT
 8zwiEzw2VwkuAuswcSM3lJ6SAknWIQvy3y9ywLmq3O0PuVSgJk7Q+d4QKcFFGa8OezscTdfyD
 pwpJ+JKTqfRRX7baptaB9enSXVHwVleaukVdexGOSAVK+nEu2MHmIvPs5T5swb9VBOJmfbC74
 ZLJzsbUkY81hrVNsehhwckwnIkR8oR2LTn8i//1/fGrRYcUyefnHyMki6uK641OOKgZwu3/xh
 EyPZ4xIEHEL7TeQz3w/ERLNugbXv7oBJIke+Bo/+Lmd6VOQum+CjpWC31AX+f7SjtQLUn3mny
 2e+uHdyOEUrCpo=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/10 03:24, Josef Bacik wrote:
> On Tue, Nov 09, 2021 at 09:14:06AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/11/9 03:36, Josef Bacik wrote:
>>> On Sat, Nov 06, 2021 at 09:11:44AM +0800, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2021/11/6 04:49, Josef Bacik wrote:
>>>>> This code adds the on disk structures for the block group root, whic=
h
>>>>> will hold the block group items for extent tree v2.
>>>>>
>>>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>>>> ---
>>>>>     fs/btrfs/ctree.h                | 26 ++++++++++++++++-
>>>>>     fs/btrfs/disk-io.c              | 49 +++++++++++++++++++++++++++=
+-----
>>>>>     fs/btrfs/disk-io.h              |  2 ++
>>>>>     fs/btrfs/print-tree.c           |  1 +
>>>>>     include/trace/events/btrfs.h    |  1 +
>>>>>     include/uapi/linux/btrfs_tree.h |  3 ++
>>>>>     6 files changed, 74 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>>>>> index 8ec2f068a1c2..b57367141b95 100644
>>>>> --- a/fs/btrfs/ctree.h
>>>>> +++ b/fs/btrfs/ctree.h
>>>>> @@ -271,8 +271,13 @@ struct btrfs_super_block {
>>>>>     	/* the UUID written into btree blocks */
>>>>>     	u8 metadata_uuid[BTRFS_FSID_SIZE];
>>>>>
>>>>> +	__le64 block_group_root;
>>>>> +	__le64 block_group_root_generation;
>>>>> +	u8 block_group_root_level;
>>>>> +
>>>>
>>>> Is there any special reason that, block group root can't be put into
>>>> root tree?
>>>>
>>>
>>> Yes, I'm so glad you asked!
>>>
>>> One of the planned changes with extent-tree-v2 is how we do relocation=
.  With no
>>> longer being able to track metadata in the extent tree, relocation bec=
omes much
>>> more of a pain in the ass.
>>
>> I'm even surprised that relocation can even be done without proper meta=
data
>> tracking in the new extent tree(s).
>>
>>>
>>> In addition, relocation currently has a pretty big problem, it can gen=
erate
>>> unlimited delayed refs because it absolutely has to update all paths t=
hat point
>>> to a relocated block in a single transaction.
>>
>> Yep, that's also the biggest problem I attacked for the qgroup balance
>> optimization.
>>
>>>
>>> I'm fixing both of these problems with a new relocation thing, which w=
ill walk
>>> through a block group, copy those extents to a new block group, and th=
en update
>>> a tree that maps the old logical address to the new logical address.
>>
>> That sounds like the proposal from Johannes for zoned support of RAID56=
.
>> An FTL-like layer.
>>
>> But I'm still not sure how we could even get all the tree blocks in one
>> block group in the first place, as there is no longer backref in the ex=
tent
>> tree(s).
>>
>> By iterating all tree blocks? That doesn't sound sane to me...
>>
>
> No, iterating the free areas in the free space tree.  We no longer care =
about
> the metadata itself, just the space that is utilized in the block group.=
  We
> will mark the block group as read only, search through the free space tr=
ee for
> that block group to find extents, copy them to new locations, insert a m=
apping
> object for that block group to say "X range is now at Y".
>
> As extent's are free'd their new respective ranges are freed.  Once a re=
located
> block groups ->used hits 0 its mapping items are deleted.
>
>>>
>>> Because of this we could end up with blocks in the tree root that need=
 to be
>>> remapped from a relocated block group into a new block group.  Thus we=
 need to
>>> be able to know what that mapping is before we go read the tree root. =
 This
>>> means we have to store the block group root (and the new mapping root =
I'll
>>> introduce later) in the super block.
>>
>> Wouldn't the new mapping root becoming a new bottleneck then?
>>
>> If we relocate the full fs, then the mapping root (block group root) wo=
uld
>> be no different than an old extent tree?
>>
>> Especially the mapping is done in extent level, not chunk level, thus i=
t can
>> cause tons of mapping entries, really not that better than old extent t=
ree
>> then.
>>
>
> Except the problem with the old extent tree is we are constantly modifyi=
ng it.

I have another question related to this block group tree.

AFAIK your new extent-tree-v2 will greatly reduce the amount of extent
items by:

- Skip all backref items for global trees

- Skip backref items for non-shared subvolumes
   As they act just like global trees (until being snapshotted).

I'm wondering if above modification is enough to make extent tree so
cold that we don't even need block group tree?

Thanks,
Qu

> The mapping's are never modified once they're created, unless we're rema=
pping
> and already remapped range.  Once the remapped extent is free'd it's new
> location will be normal, and won't update anything in the mapping tree.
>
>>>
>>> These two roots will behave like the chunk root, they'll have to be re=
ad first
>>> in order to know where to find any remapped metadata blocks.  Because =
of that we
>>> have to keep pointers to them in the super block instead of the tree r=
oot.
>>
>> Got the reason now, but I'm not yet convinced the block group root mapp=
ing
>> is the proper way to go....
>>
>> And still not sure how can we find out all tree blocks in one block gro=
up
>> without backref for each tree blocks...
>>
>
> We won't, we'll find allocated ranges.  It's certainly less precise than=
 the
> backref tree, but waaaaaaaay faster, because we only care about the rang=
e that
> is allocated and moving that range.
>
> Also it gives us another neat ability, we can relocate parts of extents =
instead
> of being required to move full extents.  Before we had to move the whole=
 extent
> because we have to modify the file extent items to point at exactly the =
same
> range.
>
> Here the translation happens at the logical level, so we can easily spli=
t up
> large extents and simply split up any bio's across the new logical locat=
ions and
> stitch it back together at the end.  Thanks,
>
> Josef
>
