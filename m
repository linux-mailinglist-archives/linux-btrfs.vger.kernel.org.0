Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C68D2E6CD9
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Dec 2020 01:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbgL2Aps (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Dec 2020 19:45:48 -0500
Received: from mout.gmx.net ([212.227.15.18]:56257 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729492AbgL2Aps (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Dec 2020 19:45:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609202651;
        bh=pNDyGz2/WI3fMMFplRuD0HM/b+40ikHrRdLO7IGjghY=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=hmlv4AcyN2t+GhquRMXqD22wwTJUCAeWYiTO4LbYoL4wBxORwdEKRukQQS6Lrh9iX
         Q2RRldwAYgbMVVCQfDgryaUjiVeNukcBFdTU+/ZR+PlrCsKLBzhpJF7ZQN+WhCwewm
         izPQTCeeZzil8yKehmUEPt7CwmKSm31EI4ywl/vc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M9FjR-1kzG2v47fj-006Mxq; Tue, 29
 Dec 2020 01:44:11 +0100
To:     =?UTF-8?Q?St=c3=a9phane_Lesimple?= <stephane_btrfs2@lesimple.fr>,
        Qu Wenruo <wqu@suse.com>, David Arendt <admin@prnet.org>,
        linux-btrfs@vger.kernel.org
References: <518c15d55c3d540b26341a773ff7d99f@lesimple.fr>
 <da42984a-1f75-153a-b7fd-145e0d66b6d4@suse.com>
 <505cabfa88575ed6dbe7cb922d8914fb@lesimple.fr>
 <292de7b8-42eb-0c39-d8c7-9a366f688731@prnet.org>
 <2846fc85-6bd3-ae7e-6770-c75096e5d547@gmx.com>
 <344c4bfd-3189-2bf5-9282-2f7b3cb23972@prnet.org>
 <1904ed2c92224d38747377b43e462353@lesimple.fr>
 <485db52d-cf4d-3a5c-9253-13cdb40ccd5e@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: 5.6-5.10 balance regression?
Message-ID: <5f819b6c-d737-bb73-5382-370875b599c1@gmx.com>
Date:   Tue, 29 Dec 2020 08:44:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <485db52d-cf4d-3a5c-9253-13cdb40ccd5e@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7MOnViKJ9QCDpNUaA0u1UaQNsZqd28SPVz4DVDX3KRjORHwpjJ0
 XUG8Zlng5Wb/Rib8xP6dlDm47K4pyrWRxfeT+FuBKrkX05rtLDbYd5fvQOyEGWuI53WMJr3
 ASaD+ufsiSqhvDq+5djnz5eXh2+dBSu6hGhkBTUpjnUkyNtiSTwUvrRlcKYO9wdqfNyCnu0
 OymhvecvK9+doxbgQsHhw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1VBjYxRPpcM=:zP6FeF7VWvcKrOjYnHC7q4
 goX5wyXo+K3R0AZ+tdbJzefX3TFrPyd/ZyDa35WTgmgvD72Dx6oUD9bUsGjnMcVe9QjbRRQDB
 lGzTqiu5H5gL6YqdEcU5G5m8Rx3SBriq+ZaNGmTdifSXsT0RCmdAC1+DR2Q79SNdPzQUFIgr5
 X4heVG4+vjdNF5gOpl/4oKccc5KoquCNBUzH7dhDGMsokeB+qvlo2YpwEawuGkHHBk8NHEG5k
 HcBuxs5ddZQIyV9i1SPNRZ3IMywwlk7yeouf9jPGr1WqWOQQwFAuYBvWrf9koMVuDCJrEJ1ux
 PHsomBOnMubvZTqEY8sjL8gtuPVArG1OaMWYBIvgm5VRxvMxIwL8Vo8wuTxGHE5vjUfnW0/3u
 uUxo75HMh5lD0YytYV9EuybDxbSt7TVzuVGbZNOWLBhE+QG/XrxgcHKpjXc2yTmuPEJxWqD9G
 7eZl3B+LzSukLqpoZh97YrHAQkwEb6AipNhh4Sjn2wKj7HixPeBDIp/GSUqeeDPHNZY22Q2eF
 BYM+F4G65S8WTDiwEb6flmeZiVAcrwe+j5a1aaZdQop044rgFT7AZh0R5gAKPWx6i5EnSaN++
 40mG29foDM5ajahhDPvOUg7xI70W+Dk4BWtom0yDANuY05k5Fla+XLqmCQCu2e+7DVobTCSXs
 eEXSHHgsYr2s4U0/U/2tB7w4hN182JBfqT8CJd6rUsIl5ju/iyxZqQ+6cgLNOXt0BC5wYzAG3
 WNDewESWLQ+g97QTK3o4Gk64wsxEvRreA5vx2UMMkiB3nD2r3lkQpyKuTHC47PHquTUkK/CvN
 ayye2es0ScteflowMyzI5ccALT5zIxgjHo0zo2e7FzZXuT2/EDatnDXpkHK6CsIDZMNxL9BtI
 FanTR7TJN0fJn66/c9Pw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/12/29 =E4=B8=8A=E5=8D=887:39, Qu Wenruo wrote:
>
>
> On 2020/12/29 =E4=B8=8A=E5=8D=883:58, St=C3=A9phane Lesimple wrote:
>>> I know it fails in relocate_block_group(), which returns -2, I'm
>>> currently
>>> adding a couple printk's here and there to try to pinpoint that better=
.
>>
>> Okay, so btrfs_relocate_block_group() starts with stage
>> MOVE_DATA_EXTENTS, which
>> completes successfully, as relocate_block_group() returns 0:
>>
>> BTRFS info (device <unknown>): relocate_block_group:
>> prepare_to_realocate =3D 0
>> BTRFS info (device <unknown>): relocate_block_group loop: progress =3D
>> 1, btrfs_start_transaction =3D ok
>> [...]
>> BTRFS info (device <unknown>): relocate_block_group loop: progress =3D
>> 168, btrfs_start_transaction =3D ok
>> BTRFS info (device <unknown>): relocate_block_group: returning err =3D =
0
>> BTRFS info (device dm-10): stage =3D move data extents,
>> relocate_block_group =3D 0
>> BTRFS info (device dm-10): found 167 extents, stage: move data extents
>>
>> Then it proceeds to the UPDATE_DATA_PTRS stage and calls
>> relocate_block_group()
>> again. This time it'll fail at the 92th iteration of the loop:
>>
>> BTRFS info (device <unknown>): relocate_block_group loop: progress =3D
>> 92, btrfs_start_transaction =3D ok
>> BTRFS info (device <unknown>): relocate_block_group loop:
>> extents_found =3D 92, item_size(53) >=3D sizeof(*ei)(24), flags =3D 1, =
ret =3D 0
>> BTRFS info (device <unknown>): add_data_references:
>> btrfs_find_all_leafs =3D 0
>> BTRFS info (device <unknown>): add_data_references loop:
>> read_tree_block ok
>> BTRFS info (device <unknown>): add_data_references loop:
>> delete_v1_space_cache =3D -2
>
> Damn it, if we find no v1 space cache for the block group, it means
> we're fine to continue...
>
>> BTRFS info (device <unknown>): relocate_block_group loop:
>> add_data_references =3D -2
>>
>> Then the -ENOENT goes all the way up the call stack and aborts the
>> balance.
>>
>> So it fails in delete_v1_space_cache(), though it is worth noting that
>> the
>> FS we're talking about is actually using space_cache v2.
>
> Space cache v2, no wonder no v1 space cache.
>
>>
>> Does it help? Shall I dig deeper?
>
> You're already at the point!
>
> Mind me to craft a fix with your signed-off-by?

The problem is more complex than I thought, but still we at least have
some workaround.

Firstly, this happens when an old fs get v2 space cache enabled, but
still has v1 space cache left.

Newer v2 mount should cleanup v1 properly, but older kernel doesn't do
the proper cleaning, thus left some v1 cache.

Then we call btrfs balance on such old fs, leading to the -ENOENT error.
We can't ignore the error, as we have no way to relocate such left over
v1 cache (normally we delete it completely, but with v2 cache, we can't).

So what I can do is only to add a warning message to the problem.

To solve your problem, I also submitted a patch to btrfs-progs, to force
v1 space cache cleaning even if the fs has v2 space cache enabled.

Or, you can disable v2 space cache first, using "btrfs check
=2D-clear-space-cache v2" first, then "btrfs check --clear-space_cache
v1", and finally mount the fs with "space_cache=3Dv2" again.

To verify there is no space cache v1 left, you can run the following
command to verify:

# btrfs ins dump-tree -t root <device> | grep EXTENT_DATA

It should output nothing.

Then please try if you can balance all your data.

Thanks,
Qu

>
> Thanks,
> Qu
>
>>
>> Regards,
>>
>> St=C3=A9phane.
>>
