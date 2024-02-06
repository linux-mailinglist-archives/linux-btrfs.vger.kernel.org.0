Return-Path: <linux-btrfs+bounces-2147-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AF184AE32
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 06:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7E9EB21D86
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 05:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C1A7F471;
	Tue,  6 Feb 2024 05:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="bB9VjwUN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD1D7F464
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Feb 2024 05:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707198884; cv=none; b=JLmxt4h6XYnxGnpCE7p6DxQa4AIol+Ywo/HXBhBzyjaCKV6S7NAoA+SVd4NQCMBKIg5/2PhSh3Tn04mM2s1JCU5ULF2bmlWV6LT92Bfwf7gsTAthx7b/rws2zJhUpnJDHN7K3i/2CVv4LgwLQvrZVLWhNoILpkYc3YsFQ/MDh4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707198884; c=relaxed/simple;
	bh=7lR7XsL+Z7urBZJLbXbMRq31JkfmCwRaIPAfY8SJ31o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g5fyRngqbdM7VcvgxXzTVwfALpxWOhnY2F7o7a9zcf0zmwa5lT9qXPl/Um/OdGfwR09grnf9e4KlbQ0XPBTiCLJ5tIouunf3dnCmsHxLtPYxReBteLYJ0Bbv0wSsmJTZjZasEH3keRVk3tkAoescrEflX4w2AFqFkCwUR31RlMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=bB9VjwUN; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707198876; x=1707803676; i=quwenruo.btrfs@gmx.com;
	bh=7lR7XsL+Z7urBZJLbXbMRq31JkfmCwRaIPAfY8SJ31o=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=bB9VjwUN2tYbOl/+9pUwoT8tVmWytUDmQvvKiharDzIB/UKc2OdPqH5rXFf0+C27
	 6bhAQkjp6WE4hw2i1IF3euzcthIcdE6MLcqh2Qp39YUalKnMrIB0UWi6BigmBLUFt
	 Q7ZKYp3jxkrt1O7TAdCdwKtYyvKAUoo0njq69JiKsDLKG2ajTkdBT+WCtfuOiFytv
	 uRFFRviE7D614oLzjpsNtYEKdbhHwblIP1GOWsAbrNFMQaPgH8MLksEdWXd108PI9
	 uojjU+Dh4TBnDvviwp7/PS/Qgo1kqhgwCZmZ39WHJw7DqL+GhpQzlRuFXovhUn8R0
	 MELwosMll5XeL74ydw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([61.245.157.120]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTAFb-1rRyB22q6x-00UWTD; Tue, 06
 Feb 2024 06:54:36 +0100
Message-ID: <8932de78-729c-431a-b371-a858e986066d@gmx.com>
Date: Tue, 6 Feb 2024 16:24:32 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: tree-checker: dump the page status if hit
 something wrong
Content-Language: en-US
To: tavianator@tavianator.com, wqu@suse.com
Cc: linux-btrfs@vger.kernel.org
References: <f51a6d5d7432455a6a858d51b49ecac183e0bbc9.1706312914.git.wqu@suse.com>
 <20240206033807.15498-1-tavianator@tavianator.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <20240206033807.15498-1-tavianator@tavianator.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yJG07XzeChOEZzxfiZ4PXn+Awwv2Jk2oFfsHikq3DkqFnGsXyQJ
 4uN4lAujaAmP8dKuq1oRIJ1uNL4X5Kp80qrnTgC5OcGb2iTP1aAh8o+mSf59HoWmYcAfqkn
 Ge2eJb4xQD2qsly0K/Xy6I6gr8QYfKnoN2qY3lAZ++9HTMk8NQgrX5nwwjOfAPR6IavrN0I
 SlYkvHVmoyG2xO+09zvIg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gZva4tCc2wg=;YjhEWffTmjYgpq3RJsnlweDvb3K
 JLw43l/Owxs1INm1EHuYJKMsmYbBX2sU0QrsQkpRmfpnAbGJWISpek2xWLHuaZ1Hnc3hnWivK
 xNj1ZzLX+TaNnVVC4Wkq+MTOyF1GvG2TUoeDutnMujvBo5uZV0IZv7952mhodTZxHReAUloW+
 qXa00z5Wze1IbG9cZSfmclJGNa5PPHHz1yQn7nBYfGlX5lwsvIy4U3dbjVCBm5d42k4BpGbHZ
 GTCQemtBOh0kW73BL/BZFlyv9OKXMoz3BVpE7WR0kdVYe18i33RBwcqpQo8RlnqBlVkHjm3sE
 55HtKGsH5MfTnzuLQ8e0rn8EW2IzF33/T0jAbsutFDKz2s+cAQ2tsISYNDrKgpQOtX3zy1tlO
 MHCeeoY1nfgaITZqCRAFoaVitJalA+DOvg+aPMexiiSJmoC/qVP/IXVryor44T2wAFwwBFoX/
 sMn5EcfN0uohsWqc/6RvBUdYseG4qePcwWkP2ZlliuUVf6piDyrlfhgZO+O58aWufj7HzXcqv
 WJOduoqvnDVZ2HoNjTj6bCZ091aGC/ebUwqDSeheNrhiywl7MkigPhqMow8R/GDMWPXks54UF
 t1Sd4LvIidBTiPSOmGn9HVLrxRXRqnilcerMx1TLkRuNCt5uLut9ywjZWU/bUro+F0jkk24sW
 EDDtSUoW0ua9SmjFXKcClaTuvJ7c6n9TLaFuM/xsIaVpeWkvpR4OLQI09cinyW3X4+zZivlQR
 1ETiNpbNMRssiToqTDMaTuQg1zNC49rrtgEOL98MxsIgv9NhKf600Rgia3AylZrJaxqh+mv6n
 qvTPym7JB/4YbWTin9a054YFmLgS1szaOYTW0wPMj0Puk=



On 2024/2/6 14:08, tavianator@tavianator.com wrote:
> On Sat, 27 Jan 2024 10:18:36 +1030, Qu Wenruo wrote:
>> [BUG]
>> There is a bug report about very suspicious tree-checker got triggered:
>>
>>    BTRFS critical (device dm-0): corrupted node, root=3D256
>> block=3D8550954455682405139 owner mismatch, have 11858205567642294356
>> expect [256, 18446744073709551360]
>>    BTRFS critical (device dm-0): corrupted node, root=3D256
>> block=3D8550954455682405139 owner mismatch, have 11858205567642294356
>> expect [256, 18446744073709551360]
>>    BTRFS critical (device dm-0): corrupted node, root=3D256
>> block=3D8550954455682405139 owner mismatch, have 11858205567642294356
>> expect [256, 18446744073709551360]
>>    SELinux: inode_doinit_use_xattr:  getxattr returned 117 for dev=3Ddm=
-0
>> ino=3D5737268
>
> I can reproduce this error.  I applied a modified version of your patch,
> against v6.7.2 because that's what I triggered it on.
>
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 50fdc69fdddf..3f1fc49cd4dc 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -2038,6 +2044,7 @@ int btrfs_check_eb_owner(const struct extent_buffe=
r *eb, u64 root_owner)
>          if (!is_subvol) {
>                  /* For non-subvolume trees, the eb owner should match r=
oot owner */
>                  if (unlikely(root_owner !=3D eb_owner)) {
> +                       dump_page(eb->pages[0], "eb page dump");
>                          btrfs_crit(eb->fs_info,
>   "corrupted %s, root=3D%llu block=3D%llu owner mismatch, have %llu expe=
ct %llu",
>                                  btrfs_header_level(eb) =3D=3D 0 ? "leaf=
" : "node",
> @@ -2053,6 +2060,7 @@ int btrfs_check_eb_owner(const struct extent_buffe=
r *eb, u64 root_owner)
>           * to subvolume trees.
>           */
>          if (unlikely(is_subvol !=3D is_fstree(eb_owner))) {
> +               dump_page(eb->pages[0], "eb page dump");
>                  btrfs_crit(eb->fs_info,
>   "corrupted %s, root=3D%llu block=3D%llu owner mismatch, have %llu expe=
ct [%llu, %llu]",
>                          btrfs_header_level(eb) =3D=3D 0 ? "leaf" : "nod=
e",
>
> Here's the corresponding dmesg output:
>
>      page:00000000789c68b4 refcount:4 mapcount:0 mapping:00000000ce99bfc=
3 index:0x7df93c74 pfn:0x1269558
>      memcg:ffff9f20d10df000
>      aops:btree_aops [btrfs] ino:1
>      flags: 0x12ffff180000820c(referenced|uptodate|workingset|private|no=
de=3D2|zone=3D2|lastcpupid=3D0xffff)
>      page_type: 0xffffffff()
>      raw: 12ffff180000820c 0000000000000000 dead000000000122 ffff9f11858=
6feb8
>      raw: 000000007df93c74 ffff9f2232376e80 00000004ffffffff ffff9f20d10=
df000
>      page dumped because: eb page dump
>      BTRFS critical (device dm-1): corrupted leaf, root=3D709 block=3D86=
56838410240 owner mismatch, have 2694891690930195334 expect [256, 18446744=
073709551360]

The page index and eb->start matches page index, so that page attaching
part is correct.

And the refcount is also 4, which matches the common case.

Although I still need to check the extra flags for workingset.

>      page:000000006b7dfcdc refcount:4 mapcount:0 mapping:00000000ce99bfc=
3 index:0x8dae804c pfn:0x408347
>      memcg:ffff9f20d10df000
>      aops:btree_aops [btrfs] ino:1
>      flags: 0xaffff180000820c(referenced|uptodate|workingset|private|nod=
e=3D1|zone=3D2|lastcpupid=3D0xffff)
>      page_type: 0xffffffff()
>      raw: 0affff180000820c 0000000000000000 dead000000000122 ffff9f11858=
6feb8
>      raw: 000000008dae804c ffff9f1497257d00 00000004ffffffff ffff9f20d10=
df000
>      page dumped because: eb page dump
>      BTRFS critical (device dm-1): corrupted leaf, root=3D518 block=3D97=
36288518144 owner mismatch, have 1691386650333431481 expect [256, 18446744=
073709551360]
>      page:00000000fb0df6cd refcount:4 mapcount:0 mapping:00000000ce99bfc=
3 index:0x7609cbdc pfn:0x129e719
>      memcg:ffff9f20d10df000
>      aops:btree_aops [btrfs] ino:1
>      flags: 0x12ffff180000820c(referenced|uptodate|workingset|private|no=
de=3D2|zone=3D2|lastcpupid=3D0xffff)
>      page_type: 0xffffffff()
>      raw: 12ffff180000820c 0000000000000000 dead000000000122 ffff9f11858=
6feb8
>      raw: 000000007609cbdc ffff9f231de92658 00000004ffffffff ffff9f20d10=
df000
>      page dumped because: eb page dump
>      BTRFS critical (device dm-1): corrupted leaf, root=3D518 block=3D81=
11527936000 owner mismatch, have 10652220539197264134 expect [256, 1844674=
4073709551360]
>
> Hope this helps!  Let me know if you have other debug patches to try.
>
> Here's my reproducer if you want to try it yourself.  It uses bfs, a
> find(1) clone I wrote with multi-threading and io_uring support.  I'm
> in the process of adding multi-threaded stat(), which is what I assume
> triggers the bug.
>
>      $ git clone "https://github.com/tavianator/bfs"
>      $ cd bfs
>      $ git checkout euclean
>      $ make release
>
> Then repeat these steps until it triggers:
>
>      # sysctl vm.drop_caches=3D3
>      $ ./bin/bfs /mnt -links 100
>      bfs: error: /mnt/slash/@/var/lib/docker/btrfs/subvolumes/f07d37d1c1=
48e9fcdbae166a3a4de36eec49009ce651174d0921fab18d55cee6/dev/ram0: Structure=
 needs cleaning.

It looks like the mount point /mnt/ is pretty large with a lot of things
pre-populated?

I tried to populate the btrfs with my linux git repo (which is around
6.5G with some GC needed), but even 256 runs didn't hit the problem.

The main part of the script looks like this:

for (( i =3D 0; i < 256; i++ )); do
	mount $dev1 $mnt
	sysctl vm.drop_caches=3D3
	/home/adam/bfs/bin/bfs $mnt -links 100
	umount $mnt
done

And the device looks like this:

/dev/mapper/test-scratch1  10485760  6472292   3679260  64% /mnt/btrfs

Although the difference is, I'm using btrfs/for-next branch
(https://github.com/btrfs/linux/tree/for-next).

Maybe it's missing some fixes not yet in upstream?
My current guess is related to my commit 09e6cef19c9f ("btrfs: refactor
alloc_extent_buffer() to allocate-then-attach method"), but since I can
not reproduce it, it's only a guess...

Thanks,
Qu

>      ...
>

