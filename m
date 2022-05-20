Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0D552E52E
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 May 2022 08:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244389AbiETGoJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 May 2022 02:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiETGoI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 May 2022 02:44:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D7A14CA2E
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 23:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653029039;
        bh=51JzG+6xyNVO0zFEhSw095fGHludrU1nJhp/VHN8eHw=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=jhYnThDSTXJbPTodY1pXBkypIpr6y9eSgf5SjtbBwu1OtZbfZHRLfiSLvqlK9YNqz
         S6pLBFfBicdm4oyLA+2GzSUMcrnklK9nRh+vylFBrToiDh558tFU8J2CwCF2gYB3XT
         tsVwURXieYD4Zr0pM0TsxAcO9SzvI5EiIqSdGHHs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MVvLB-1oH0Hq0s6P-00Rqks; Fri, 20
 May 2022 08:43:59 +0200
Message-ID: <e636ebd2-2e67-0e94-9758-925df5a89557@gmx.com>
Date:   Fri, 20 May 2022 14:43:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20220517145039.3202184-1-hch@lst.de>
 <20220517145039.3202184-13-hch@lst.de>
 <e2c4e54c-548b-2221-3bf7-31f6c14a03ee@gmx.com>
 <20220519093641.GA32623@lst.de>
 <d99b2ba3-23d2-0ea1-9aa4-13a898e77ab6@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Why btrfs no longer allocate the extent at the beginning of an empty
 chunk (was: Re: [PATCH 12/15] btrfs: add new read repair infrastructure)
In-Reply-To: <d99b2ba3-23d2-0ea1-9aa4-13a898e77ab6@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZsrUaGDkKx3/lDlgtGvO2dbfUQzmweGc1+FNZYq+ik+q7x2GZi4
 oTP3O5tNdQpxNd7Hk4nJsbLJU5HmW5IX7/p+Rr2OwOYFZmTIArBHnVBgEwW053wK4j6wINC
 4qeC0z03PtOYCdRwsrqGcCu6js/XXQri9XB1zGliYqzd6JlKZxw3Xta3fnJ6yv/6tbLfO9u
 kzQ0gG0HmojSbaMmwdZbQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JHFaWU5mAUc=:LIXDtm5Gic2nAjc/H7snhc
 D927mTSqkqJYVIGKvG/0POSMCX8HqvaZK4nc1E63oIoATELmCMXwnm0MrgFXrVbuBBAwPmIIU
 PzPsdYDYiMlm+EYMGfY2qiW7EewiCvqWPOjl1kHyJTP8+GYHRT3AeekO6rqJU+QXEFnKIc6fa
 4vG77cvhtZnxEatd4KVjfzShIOna3qENP4kY1F/0I0hfE8yKhEr9zrKHgYVFx4ts4Hw7VvJED
 v617ig5ivk4d2HKCLYhV69EcFWzQ4lb6eM8GdsMjEzvRo4cY9dOWd6mXfpWInHBKLl7s0hF1n
 I3R94OVcxVT4oVYfoFwLg1YNj7L9NYC88r2Iyn1hmmIPXHPXbNkgFvTvkklv5OK+r1x+N3Q9S
 8Ed20do/lxe9nkVHmeE9y2Z966uKNAP+erbd/bsPLxAIw0kJgO5FuDG0HOKTp5Bpbrg9tWJJo
 FZ2AiRNYBz+VPyu+BnCyYd+YcsSyopFDY+ol+fbdm7PsGWlLeSlJdNr1WhM9cfzB5HETmYMVn
 5BARdt7WXzV+9LGdusrhoiINb67wdn9rBhwhHVHkY/FmHyXaq//gIicjwfqu2pgmYIwJbTtAs
 YvOOUHtotLjRBM8uihvNpnP32jmAGc79i/QNml/bE5vJ3vPG7KHIVQyvS200MRl+HA+C7hUBS
 UFAqKuGcEdp0MQInHgv1x+rHN62GP6ap7cbxsWEJrfOSBui+4mrp4udDfjCqJZTu1NvjcboCs
 h+8b6t/nQ26oQtYrS9FuwARxtHBnAaRsrc0+JzYYs7UayFSjPCJKTjzmhgCewrjFKNsMy99KA
 9Pj4D2w0I1+5YXUjGNfSC5SK27Nbfno9RR2duN8eNVHqnGH29lqUfmr0nfGaLdehF+HGt7Y7U
 xJpXKDaqs5l95y/KdkuuwYdSseghNT5/kLRZPcRK3nTXOT3Keuty9TnTn56zEZMN5Ve3+yd40
 rKw6WViwogNBi4bWtYsW/P+3plRHgLlN/eFPtzpui4VqY8FWo3NNhjda7TDIQq+rakvb+1RIW
 PKzkj7nX3lCbECxTAmnHuVNsGNmfPbezu8P0S85vq16E9/tBgA7rXuV4EPCXqv5X4kubXKxxb
 xjoKYDkK3WYc7LZXDtU3SuXc71EdJoGmE5L4Lo9FrSzFPu42y0SDIBxug==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

>> I tried to write a test case for this by copying btrfs/140 and then
>> as a first step extending it to three mirrors unsing the raid1c1
>> profile.=C2=A0 But it seems that the tricks used there don't work,
>> as the code in btrfs/140 relies on the fact that the btrfs logic
>> address repored by file frag is reported by dump-tree as the item
>> "index" =C4=ADn this line:
>>
>> item 4 key (FIRST_CHUNK_TREE CHUNK_ITEM 137756672) itemoff 15751 itemsi=
z
>>
>> but for the raid1c3 profile that line reports something entirely
>> different.
>>
>> for raid1:
>>
>> logical: 137756672
>> item 4 key (FIRST_CHUNK_TREE CHUNK_ITEM 137756672) itemoff 15751
>> itemsize 112
>>
>> for raid1c3:
>>
>> logical: 343998464
>> item 5 key (FIRST_CHUNK_TREE CHUNK_ITEM 298844160) itemoff 15621
>> itemsize 144
>>
>> any idea how to find physical sectors to corrupt for raid1c1?
>>
>
> I also recently hit weird cases why extent allocator no longer puts the
> first data extent at the beginning of a chunk.

Thankfully, this is not a bug, but a combination of seemingly
straightforward behaviors, which leads to a weird combined result.

It takes me a short adventure into the free space handling to find the
problem.

For my example, I'm using 3x10G disks, and running RAID0 for data, RAID1
for metadata:

    Label:              (null)
    UUID:               bb10a539-0344-445a-9e77-bbda65d79366
    Node size:          16384
    Sector size:        4096
    Filesystem size:    30.00GiB
    Block group profiles:
      Data:             RAID0             3.00GiB
      Metadata:         RAID1           256.00MiB
      System:           RAID1             8.00MiB
    SSD detected:       no
    Zoned device:       no
    Incompat features:  extref, skinny-metadata, no-holes
    Runtime features:   free-space-tree
    Checksum:           crc32c
    Number of devices:  3
    Devices:
       ID        SIZE  PATH
        1    10.00GiB  /dev/test/scratch1
        2    10.00GiB  /dev/test/scratch2
        3    10.00GiB  /dev/test/scratch3

The 3GiB data chunk (at logical 298844160, length 3GiB) is completely
empty, but notice that, btrfs needs to avoid allocating extents for
super block reservations.

And we have one logical bytenr 434110464, which is at the superblock
location of /dev/test/scratch1.

So the free space of that 3GiB chunk is split into two parts:

[298844160, +135266304)
[434176000, +3085893632)

Notice the latter part is much larger.

So far so good, but there is another thing involved, the cached free
space behavior.

In find_free_space(), if we are searching from the beginning of a block
group, we will use `rb_first_cached(&ctl->free_space_bytes);`

But free_space_bytes rbtree is not sorted using logical bytenr, but the
free space.
And the leftmost one will have the most amount of free space.
So instead of choose [298844160, +135266304), we choose [434176000,
+3085893632) which has the much larger free space.


Thus we got the seemingly weird bytenr, 434176000, for our first data
extent.


And each behavior itself is completely sane and straightforward.
We can not use space reserved for superblocks.
We should use the free space which has the most free space.

But in the end, when combining two of them, we got the behavior that not
returning the beginning of a seemingly empty chunk.

So in short, we should not rely on the dirty dump tree hacks, but a
better version of btrfs-map-logical to grab the real physical offset of
a logical bytenr.

Thanks,
Qu



