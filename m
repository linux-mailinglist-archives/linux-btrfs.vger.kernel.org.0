Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C009E497E0D
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jan 2022 12:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237573AbiAXLcr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jan 2022 06:32:47 -0500
Received: from mout.gmx.net ([212.227.17.21]:57599 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237603AbiAXLcp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jan 2022 06:32:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643023957;
        bh=jsT31nBPxMNxR6RIFMmyT/XJfmexbTG8FB0GJk4zrP4=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=GTqn5TAv/wx47RcApOKsNcY0qX6e1n6L0z1dHxpxfK1PEURCLyKpstenS6vquymRR
         KAvRr6v0Hc4W30sCX0aZq/zWUyGr6UiWEgOxg6KuG4eHlV0EEeYJYBI+9UT+Mubhfh
         fo4AwkgFbNXBVILiAd6bDZDCPD0UlVEJ1Zur9OGs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYeR1-1mpo0N21pb-00VkkT; Mon, 24
 Jan 2022 12:32:37 +0100
Message-ID: <58c6952b-9cfc-bb64-1e4b-4bb18f774d2d@gmx.com>
Date:   Mon, 24 Jan 2022 19:32:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <20220124063419.40114-1-wqu@suse.com>
 <Ye6J6a7vG1tj49XM@debian9.Home>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH RFC] btrfs: defrag: abort the whole cluster if there is
 any hole in the range
In-Reply-To: <Ye6J6a7vG1tj49XM@debian9.Home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6VI20GYV+JVTEkI7d573za1qk3bc7jyR6DUgj64CLIZLWEGq85e
 dpIS7S88H7P2mq/kfq78oI5cK5pL0AvW7FmlfqX8ZrOvr6M84ZF9uWAwQ8SvVrg30IGQ4nG
 EMTm0t9fF3M7M/eKw674a0jy1smYIZpA4uhYPdTND+Kp+R+6gG7ebMwAQG2VvIGi/IL1k0B
 H8rpyg57rnRZQ8tEBrYUA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NJf56GLJcbU=:fBdzyCI01y86urDgypyVOv
 jyf4wIbVmVF0/nTLWeDyePySEQMd6pLeDN4RmuIi4T7sNMbHs/WMK39kMK0oZ24mQNFyr6J6F
 MsA1iwzBUwFW5nXYfNxcDRhleujZ6VoqnntqixrrFvSy8ZJt6AlJm2bAHk5ZpiRA5eGEHMOZS
 m0omdiGMJceo7nT3ysjTUUZ45fdQ6foKG0PovM9xQzLxwy6TKIxbVayiZTwytHoVlJa8jbDjM
 UM4DvW1cWq87UDAfPJSaUz2CEQvT6/RW/wL1CNZQTGBW0K5xrQFQkB7Q/tWlRuz09ldiLVSoW
 q1B64IkX6vEaJl+4u2FkvYswF48MtGgXO4+DWNq1OhQ+rCMT0iHHPo6CuCruU8+oYM2Re5XPO
 vAaeorlV6YmaDMcE85ZySibuLaLv5vWWd8+qROmGW7szJcS0jNZ7dC//Xvcy13CT1l4ZDLjEM
 k40wKmr10GYyZ+ORM68XFQpzSBa5HeGcuDjfw2KbVwhNoisrAydIK5pM7/reDQ1w02gO4hzTv
 Ye7XLO+3UE38bMcJ8TxjIc8DfDB1WBmNX53M8af23dEaYkgaK/Cj5B4ade6bqmmdYA0ApYPc4
 kcKlS1vQuQrm8YkLanMLt83darUcyOQb9CzKZQSOaHOP35TLAfutWrW/VwERBmtfLU6eONgib
 Sl1InYaS6zNmJu4ybxQv5Y4lVhSwZ78NIPqzCnUAUo7HEgPgN9DoiIocDyJzkHV5ccElWTliF
 EAHW6VF96NaPA+eS2C8nUwYsg6j1Sqrrf8IJpMr0oh0EA9t4VMJdUMeDQwXOiwLD4dppTbrMF
 bSBMfrBVCsUTliukiRIrgKfBXdTHX7ajY8xyw6pR57DTsPf1msmjTorF/Q4wopDKapEt9eQWm
 a87B8U33p2GS9peuXyX2NaZhC/FBDBZYMZ97b7MMI+HauQXkGTH2D0pj28qBueyEaT3RNDNCD
 Fkwy7xkoz/+coacbUlO+YJpax4yc4XN+BA9y4okbLpkNR15onW2hpnMR8WUd+iBlxySeQ3YrO
 BYQJnMTHvDknT8rBxZfJHoktzP3PwR1UXpdHoTQ3HvBDWBtccaLgbzpRZteiNvBrXQt/wU7ls
 IZhJmHn0r4NrWs=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/24 19:13, Filipe Manana wrote:
> On Mon, Jan 24, 2022 at 02:34:19PM +0800, Qu Wenruo wrote:
>> [BUG]
>> There are several reports that autodefrag is causing more IO in v5.16,
>> caused by the recent refactor of defrag (mostly to support subpage
>> defrag).
>>
>> With the recent debug helpers, I also locally reproduced it using
>> the following script:
>>
>> 	mount $dev $mnt -o autodefrag
>>
>> 	start_trace
>> 	$fsstress -w -n 2000 -p 1 -d $mnt -s 1642319517
>> 	sync
>> 	btrfs ins dump-tree -t 256 $dev > /tmp/dump_tree
>> 	echo "=3D=3D=3D autodefrag =3D=3D=3D"
>> 	grep . -IR /sys/fs/btrfs/$uuid/debug/io_accounting
>> 	echo 0 > /sys/fs/btrfs/$uuid/debug/cleaner_trigger
>> 	sleep 3
>> 	sync
>> 	echo "=3D=3D=3D=3D=3D=3D"
>> 	grep . -IR /sys/fs/btrfs/$uuid/debug/io_accounting
>> 	umount $mnt
>> 	end_trace
>>
>> Btrfs indeeds causes more IO for autodefrag, with all the fixes
>> submitted, it still causes 18% of total IO to autodefrag.
>>
>> [CAUSE]
>> There is a hidden bug in the original defrag code in
>> cluster_pages_for_defrag():
>>
>>          while (search_start < page_end) {
>>                  struct extent_map *em;
>>
>>                  em =3D btrfs_get_extent(BTRFS_I(inode), NULL, 0, searc=
h_start,
>>                                        page_end - search_start);
>>                  if (IS_ERR(em)) {
>>                          ret =3D PTR_ERR(em);
>>                          goto out_unlock_range;
>>                  }
>>                  if (em->block_start >=3D EXTENT_MAP_LAST_BYTE) {
>>                          free_extent_map(em);
>>                          /* Ok, 0 means we did not defrag anything */
>>                          ret =3D 0;
>>                          goto out_unlock_range;
>>                  }
>>                  search_start =3D extent_map_end(em);
>>                  free_extent_map(em);
>> 	}
>>
>> @search_start is the defrag range start, and @page_end is the defrag
>> range end (exclusive).
>> This while() loop is called before marking the pages for defrag.
>>
>> The Ok comment is the root case.
>>
>> With my test seed, root 256 inode 287 is the most obvious example, ther=
e
>> is a cluster of file extents starting at file offset 118784, and they
>> are completely sane to be merged:
>>
>>          item 59 key (287 EXTENT_DATA 118784) itemoff 6211 itemsize 53
>>                  generation 85 type 1 (regular)
>>                  extent data disk byte 339034112 nr 8192
>>                  extent data offset 0 nr 8192 ram 8192
>>          item 60 key (287 EXTENT_DATA 126976) itemoff 6158 itemsize 53
>>                  generation 85 type 1 (regular)
>>                  extent data disk byte 299954176 nr 4096
>>                  extent data offset 0 nr 4096 ram 4096
>>          item 61 key (287 EXTENT_DATA 131072) itemoff 6105 itemsize 53
>>                  generation 85 type 1 (regular)
>>                  extent data disk byte 339042304 nr 4096
>>                  extent data offset 0 nr 4096 ram 4096
>>          item 62 key (287 EXTENT_DATA 135168) itemoff 6052 itemsize 53
>>                  generation 85 type 1 (regular)
>>                  extent data disk byte 303423488 nr 4096
>>                  extent data offset 0 nr 4096 ram 4096
>>          item 63 key (287 EXTENT_DATA 139264) itemoff 5999 itemsize 53
>>                  generation 85 type 1 (regular)
>>                  extent data disk byte 339046400 nr 106496
>>                  extent data offset 0 nr 106496 ram 106496
>>
>> Then comes a hole at offset 245760, and the file is way larger than
>> 245760.
>>
>> The old kernel will call cluster_pages_for_defrag() with start =3D=3D 1=
18784
>> and len =3D=3D 256K.
>>
>> Then into the mentioned while loop, finding the hole at 245760 and
>> rejecting the whole 256K cluster.
>>
>> This also means, the old behavior will only defrag the whole cluster,
>> which is normally in 256K size (can be smaller at file end though).
>>
>> [?FIX?]
>> I'm not convinced the old behavior is correct.
>>
>> But since my refactor introduced a behavior change, and end users are
>> already complaining, then it's a regression, we should revert to the ol=
d
>> behavior by rejecting the cluster if there is anything preventing the
>> whole cluster to be defragged.
>>
>> However the refactored code can not completely emulate the behavior, as
>> now cluster is split only by bytenr, no more extents skip will affect
>> the cluster split.
>>
>> This results a more strict condition for full-cluster-only defrag.
>>
>> As a result, for the mentioned fsstress seed, it only caused around 1%
>> for autodefrag IO, compared to 8.5% of older kernel.
>>
>> Cc: Filipe Manana <fdmanana@suse.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Reason for RFC:
>>
>> I'm not sure what is the correct behavior.
>>
>> The whole cluster rejection is introduced by commit 7f458a3873ae ("btrf=
s: fix
>> race when defragmenting leads to unnecessary IO"), which is fine for ol=
d
>> kernels.
>>
>> But the refactored code provides a way to still do the defrag, without
>> defragging holes. (But still has its own regressions)
>>
>> If the refactored defrag (with regression fixed) and commit 7f458a3873a=
e
>> are submitted to the mail list at the same time, I guess it's no doubt =
we
>> would choose the refactored code, as it won't cause extra IO for
>> holes, while can still defrag as hard as possible.
>>
>> But since v5.11 which has commit 7f458a3873ae, the autodefrag IO is
>> already reduced, I'm not sure if it's OK to increase the IO back to the=
 old
>> level.
>
> There's a misunderstanding of what that commit did, it was to fix a race=
 that
> resulted in marking ranges with holes for delalloc - the end result bein=
g that
> we lost holes and ended up allocating extents full of zeroes.

That part of not defragging holes is completely sane, and I have no
problem with that.

>
> The whole decision to skip in case there's a hole was already done by th=
e
> old function should_defrag_range(), which was called without having the =
inode
> and the range locked. This left a time window between the call to
> should_defrag_range() and the cluster_pages_for_defrag(), where if a hol=
e was
> punched after the call to the first function, we would dirty the hole an=
d end
> up replacing it with an extent full of zeroes. If the hole was punched b=
efore
> should_defrag_range(), then defrag would do nothing.
>
> I believe the changelog of that commit is clear enough about the race it
> fixes. It did not add a new policy to skip holes, it was already there a=
t
> should_defrag_range() (which does not exists anymore after the refactori=
ng).

Nope.

The should_defrag_range() only checks the first extent it hits.

Check the tree dump I pasted in the commit message, the first extent at
file offset 118784 is completely fine to defrag.
(in fact all the five extents are completely fine to defrag)

Then should_defrag_range() return true, but later since @newer_than is
set, we will try to defrag the range [118784, 118784 + 256K).

Thus that's why your added code is in fact affecting the behavior of
cluster defragging, not just the race fix.

Maybe there is some other code modification caused this, but since my
debug points exactly to the code you added, and I can't find any related
change after 2018 in main loop of btrfs_defrag_file().

Thanks,
Qu
>
> Thanks.
>
>> ---
>>   fs/btrfs/ioctl.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index dfa81b377e89..17d5e35a42fe 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -1456,6 +1456,17 @@ static int defrag_one_cluster(struct btrfs_inode=
 *inode,
>>   	if (ret < 0)
>>   		goto out;
>>
>> +	if (list_empty(&target_list))
>> +		goto out;
>> +	entry =3D list_entry(target_list.next, struct defrag_target_range, li=
st);
>
> Use list_first_entry().
>
>> +
>> +	/*
>> +	 * To emulate the old kernel behavior, if the cluster has any hole or
>> +	 * other things to prevent defrag, then abort the whole cluster.
>> +	 */
>> +	if (entry->len !=3D len)
>> +		goto out;
>> +
>>   	list_for_each_entry(entry, &target_list, list) {
>>   		u32 range_len =3D entry->len;
>>
>> --
>> 2.34.1
>>
