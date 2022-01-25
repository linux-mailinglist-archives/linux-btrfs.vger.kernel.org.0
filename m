Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812D049A758
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jan 2022 03:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbiAYCh1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jan 2022 21:37:27 -0500
Received: from mout.gmx.net ([212.227.15.19]:41475 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2372477AbiAYALn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jan 2022 19:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643069495;
        bh=ZxMlhYcTUelaP35ijENP8ndNG5MFWQaVNOglT+iSfW0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=CgBgQWEpLm+nKcPsae/dLvJvryeBBxdzuG99B2mNK+ROxrVXLddylGmTUm4x7YHuz
         ccJjB4ubLh7wTVLW0oMOv6ogHauV1Cg+iewug3Nol1GSSGvNntUuI/Uzmu70VduYgp
         zQhHcgLg/2YmiLSlTk90qE5de22gvOKzTCdq4noM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MK3W0-1mqeIz0Co2-00LYeE; Tue, 25
 Jan 2022 01:11:35 +0100
Message-ID: <430a1d5d-2376-a255-2109-fcfefc14905c@gmx.com>
Date:   Tue, 25 Jan 2022 08:11:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH RFC] btrfs: defrag: abort the whole cluster if there is
 any hole in the range
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
References: <20220124063419.40114-1-wqu@suse.com>
 <Ye6J6a7vG1tj49XM@debian9.Home>
 <58c6952b-9cfc-bb64-1e4b-4bb18f774d2d@gmx.com>
 <Ye6UL/UD3yZDcub0@debian9.Home>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <Ye6UL/UD3yZDcub0@debian9.Home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Z1DP528XB+mlWY7VwrL0JCAUoWA8WdMt5VtMm43UhdkN/329hIO
 mHApDYxDuByUBFkKc+nWBHxo0yqifRG64gSsCrhEyNRKyFoFoSc8TswPhGDQaccni202E24
 +yhM/h5XlPDR2W09Fto9Y2qZeHqjGiYEAcNUVpP7ejUvDGz9B3ucYUuPeEmXnoCM4yzmU/l
 TMcCjgjh8DimcbNDyFK5A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ksj7lHqQAB4=:n2WRj3wSwfLK4k1MFiZ968
 IzRJHjHnv1B8BXAxZKt4h0xC9SBf5l7TS2c/3LkyAJU7zPnGwPUJMRPhvawh1otmZQVgFuohy
 IH3FOpB3JQ+eFPu+CPPcAPFPnroPAlVfXL9SQXN/PkNrMH6P0ip+S4UNs5oIkEEx3Pe27hMYe
 9BGTLR4f1t4gvJMTkz4p+DNcwQIhQBo1lWvixAN2T0+NVxLAg4mTa5ZCn/akE8SPYjUXSGBfo
 E4EsTmx7boNE06ynNFyFswbt53iwxRtRdlhO0yueE2+61Ke9XL2bQGMc7+JCCTW12kLYWWEUQ
 KqDodHnXmoZT7kohZgpivBgxlAFIez3DRuO1VQ7WV8WjuXAXXSteBB6Tw99/n9u+iA6v32Oz6
 bW2G8MvS+UtFbBXM9+Rx7bS3EoLM53cdGcvb+tjrOP+AuKAKZIlJtkiDoqoDA+iMenWsAqLlK
 Y7KQ+2Le+R/fHP+cI50oaSxCeTLgVwEJWcqMlipZJvtMjMI0Irimi1+wp8GrfDxWQSQxcNx8T
 MVkLu8itpY57Q3uf03V/pDX7FURGV/N6qejz4gAYQuwaD7hl/Xv1APzMZMhoJzV9QO74ew8Rw
 UUjigf7J90bEWwIUQaxzI7ckjU1991tJv/LIvip0vK9szyDhBMhcXuQsRLr2jYMxHhkS1OQSj
 B2NByH9XtxvOY6B2rMlygnSWDIdBwgfV7sf66LMPPSCyB8ANHImzZqZ6Dd8tETBF4wWiTPbdP
 tVIVxArsdHd1v1lLbGNyGyqxgs2LrLeRhOPHkoMdQVqTb4x0vFM6Tj8hDevSIayx0Gvl5BjKO
 dTCV+yzgXBFaXF41uWB7bVbJoMuIvP58kB9u86g/b/PV9sfxCJAfFrZtUl1yMBBO8zjHmnCPB
 IWRh1mj/ADaJVWKaVhnlhl9yrFmTBmKroAHl+SKyeeKEuG7hoquKGJCaqDnPw7/xkCwcXJXj9
 /kP4LzN1l09Co2DrPtMuLSluIlk08dBMc2anwYHEXDa0kAHVAgXh8wFsCkDYnLDUbM4jwHAEx
 Wk0aMaK08P5kIPWdxxK6xpsup/L1uwTr8T0SKbHPTs4XeB1AIu7UNUWvUjC1Fa+1QI+0zKLLu
 FX3g0s9ez5EbjA=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/24 19:57, Filipe Manana wrote:
> On Mon, Jan 24, 2022 at 07:32:32PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2022/1/24 19:13, Filipe Manana wrote:
>>> On Mon, Jan 24, 2022 at 02:34:19PM +0800, Qu Wenruo wrote:
>>>> [BUG]
>>>> There are several reports that autodefrag is causing more IO in v5.16=
,
>>>> caused by the recent refactor of defrag (mostly to support subpage
>>>> defrag).
>>>>
>>>> With the recent debug helpers, I also locally reproduced it using
>>>> the following script:
>>>>
>>>> 	mount $dev $mnt -o autodefrag
>>>>
>>>> 	start_trace
>>>> 	$fsstress -w -n 2000 -p 1 -d $mnt -s 1642319517
>>>> 	sync
>>>> 	btrfs ins dump-tree -t 256 $dev > /tmp/dump_tree
>>>> 	echo "=3D=3D=3D autodefrag =3D=3D=3D"
>>>> 	grep . -IR /sys/fs/btrfs/$uuid/debug/io_accounting
>>>> 	echo 0 > /sys/fs/btrfs/$uuid/debug/cleaner_trigger
>>>> 	sleep 3
>>>> 	sync
>>>> 	echo "=3D=3D=3D=3D=3D=3D"
>>>> 	grep . -IR /sys/fs/btrfs/$uuid/debug/io_accounting
>>>> 	umount $mnt
>>>> 	end_trace
>>>>
>>>> Btrfs indeeds causes more IO for autodefrag, with all the fixes
>>>> submitted, it still causes 18% of total IO to autodefrag.
>>>>
>>>> [CAUSE]
>>>> There is a hidden bug in the original defrag code in
>>>> cluster_pages_for_defrag():
>>>>
>>>>           while (search_start < page_end) {
>>>>                   struct extent_map *em;
>>>>
>>>>                   em =3D btrfs_get_extent(BTRFS_I(inode), NULL, 0, se=
arch_start,
>>>>                                         page_end - search_start);
>>>>                   if (IS_ERR(em)) {
>>>>                           ret =3D PTR_ERR(em);
>>>>                           goto out_unlock_range;
>>>>                   }
>>>>                   if (em->block_start >=3D EXTENT_MAP_LAST_BYTE) {
>>>>                           free_extent_map(em);
>>>>                           /* Ok, 0 means we did not defrag anything *=
/
>>>>                           ret =3D 0;
>>>>                           goto out_unlock_range;
>>>>                   }
>>>>                   search_start =3D extent_map_end(em);
>>>>                   free_extent_map(em);
>>>> 	}
>>>>
>>>> @search_start is the defrag range start, and @page_end is the defrag
>>>> range end (exclusive).
>>>> This while() loop is called before marking the pages for defrag.
>>>>
>>>> The Ok comment is the root case.
>>>>
>>>> With my test seed, root 256 inode 287 is the most obvious example, th=
ere
>>>> is a cluster of file extents starting at file offset 118784, and they
>>>> are completely sane to be merged:
>>>>
>>>>           item 59 key (287 EXTENT_DATA 118784) itemoff 6211 itemsize =
53
>>>>                   generation 85 type 1 (regular)
>>>>                   extent data disk byte 339034112 nr 8192
>>>>                   extent data offset 0 nr 8192 ram 8192
>>>>           item 60 key (287 EXTENT_DATA 126976) itemoff 6158 itemsize =
53
>>>>                   generation 85 type 1 (regular)
>>>>                   extent data disk byte 299954176 nr 4096
>>>>                   extent data offset 0 nr 4096 ram 4096
>>>>           item 61 key (287 EXTENT_DATA 131072) itemoff 6105 itemsize =
53
>>>>                   generation 85 type 1 (regular)
>>>>                   extent data disk byte 339042304 nr 4096
>>>>                   extent data offset 0 nr 4096 ram 4096
>>>>           item 62 key (287 EXTENT_DATA 135168) itemoff 6052 itemsize =
53
>>>>                   generation 85 type 1 (regular)
>>>>                   extent data disk byte 303423488 nr 4096
>>>>                   extent data offset 0 nr 4096 ram 4096
>>>>           item 63 key (287 EXTENT_DATA 139264) itemoff 5999 itemsize =
53
>>>>                   generation 85 type 1 (regular)
>>>>                   extent data disk byte 339046400 nr 106496
>>>>                   extent data offset 0 nr 106496 ram 106496
>>>>
>>>> Then comes a hole at offset 245760, and the file is way larger than
>>>> 245760.
>>>>
>>>> The old kernel will call cluster_pages_for_defrag() with start =3D=3D=
 118784
>>>> and len =3D=3D 256K.
>>>>
>>>> Then into the mentioned while loop, finding the hole at 245760 and
>>>> rejecting the whole 256K cluster.
>>>>
>>>> This also means, the old behavior will only defrag the whole cluster,
>>>> which is normally in 256K size (can be smaller at file end though).
>>>>
>>>> [?FIX?]
>>>> I'm not convinced the old behavior is correct.
>>>>
>>>> But since my refactor introduced a behavior change, and end users are
>>>> already complaining, then it's a regression, we should revert to the =
old
>>>> behavior by rejecting the cluster if there is anything preventing the
>>>> whole cluster to be defragged.
>>>>
>>>> However the refactored code can not completely emulate the behavior, =
as
>>>> now cluster is split only by bytenr, no more extents skip will affect
>>>> the cluster split.
>>>>
>>>> This results a more strict condition for full-cluster-only defrag.
>>>>
>>>> As a result, for the mentioned fsstress seed, it only caused around 1=
%
>>>> for autodefrag IO, compared to 8.5% of older kernel.
>>>>
>>>> Cc: Filipe Manana <fdmanana@suse.com>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>> Reason for RFC:
>>>>
>>>> I'm not sure what is the correct behavior.
>>>>
>>>> The whole cluster rejection is introduced by commit 7f458a3873ae ("bt=
rfs: fix
>>>> race when defragmenting leads to unnecessary IO"), which is fine for =
old
>>>> kernels.
>>>>
>>>> But the refactored code provides a way to still do the defrag, withou=
t
>>>> defragging holes. (But still has its own regressions)
>>>>
>>>> If the refactored defrag (with regression fixed) and commit 7f458a387=
3ae
>>>> are submitted to the mail list at the same time, I guess it's no doub=
t we
>>>> would choose the refactored code, as it won't cause extra IO for
>>>> holes, while can still defrag as hard as possible.
>>>>
>>>> But since v5.11 which has commit 7f458a3873ae, the autodefrag IO is
>>>> already reduced, I'm not sure if it's OK to increase the IO back to t=
he old
>>>> level.
>>>
>>> There's a misunderstanding of what that commit did, it was to fix a ra=
ce that
>>> resulted in marking ranges with holes for delalloc - the end result be=
ing that
>>> we lost holes and ended up allocating extents full of zeroes.
>>
>> That part of not defragging holes is completely sane, and I have no
>> problem with that.
>>
>>>
>>> The whole decision to skip in case there's a hole was already done by =
the
>>> old function should_defrag_range(), which was called without having th=
e inode
>>> and the range locked. This left a time window between the call to
>>> should_defrag_range() and the cluster_pages_for_defrag(), where if a h=
ole was
>>> punched after the call to the first function, we would dirty the hole =
and end
>>> up replacing it with an extent full of zeroes. If the hole was punched=
 before
>>> should_defrag_range(), then defrag would do nothing.
>>>
>>> I believe the changelog of that commit is clear enough about the race =
it
>>> fixes. It did not add a new policy to skip holes, it was already there=
 at
>>> should_defrag_range() (which does not exists anymore after the refacto=
ring).
>>
>> Nope.
>>
>> The should_defrag_range() only checks the first extent it hits.
>
> Once should_defrag_range() finds the first extent is a hole, it adjust t=
he
> *skip parameter to the end of the extent's range. Then the main defrag l=
oop
> continues and does not call cluster_pages_for_defrag() for that range.
>
> So no, the race fix did change the logic regarding holes.

As discussed, the point here is not one regular extent then a hole, but
two or more regular extents which are good candidates for defrag, then a
hole.

In that case, we can pass all the conditions of find_new_extents(),
defrag_check_next_extent() and should_defrag_range().

And cause a defrag cluster of 256K (if the file is large enough), and
then get rejected.


I'll craft a POC patch to make the old code work without rejecting the
whole cluster, nor defrag holes, and check how its IO changes.

Thanks,
Qu

>
>>
>> Check the tree dump I pasted in the commit message, the first extent at
>> file offset 118784 is completely fine to defrag.
>> (in fact all the five extents are completely fine to defrag)
>>
>> Then should_defrag_range() return true, but later since @newer_than is
>> set, we will try to defrag the range [118784, 118784 + 256K).
>>
>> Thus that's why your added code is in fact affecting the behavior of
>> cluster defragging, not just the race fix.
>>
>> Maybe there is some other code modification caused this, but since my
>> debug points exactly to the code you added, and I can't find any relate=
d
>> change after 2018 in main loop of btrfs_defrag_file().
>>
>> Thanks,
>> Qu
>>>
>>> Thanks.
>>>
>>>> ---
>>>>    fs/btrfs/ioctl.c | 11 +++++++++++
>>>>    1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>>>> index dfa81b377e89..17d5e35a42fe 100644
>>>> --- a/fs/btrfs/ioctl.c
>>>> +++ b/fs/btrfs/ioctl.c
>>>> @@ -1456,6 +1456,17 @@ static int defrag_one_cluster(struct btrfs_ino=
de *inode,
>>>>    	if (ret < 0)
>>>>    		goto out;
>>>>
>>>> +	if (list_empty(&target_list))
>>>> +		goto out;
>>>> +	entry =3D list_entry(target_list.next, struct defrag_target_range, =
list);
>>>
>>> Use list_first_entry().
>>>
>>>> +
>>>> +	/*
>>>> +	 * To emulate the old kernel behavior, if the cluster has any hole =
or
>>>> +	 * other things to prevent defrag, then abort the whole cluster.
>>>> +	 */
>>>> +	if (entry->len !=3D len)
>>>> +		goto out;
>>>> +
>>>>    	list_for_each_entry(entry, &target_list, list) {
>>>>    		u32 range_len =3D entry->len;
>>>>
>>>> --
>>>> 2.34.1
>>>>
