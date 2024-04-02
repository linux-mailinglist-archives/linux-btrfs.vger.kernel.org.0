Return-Path: <linux-btrfs+bounces-3833-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEE0895EF5
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 23:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E14C1C2242B
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 21:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B437815E801;
	Tue,  2 Apr 2024 21:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="opv0ICxh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5905B79DD4
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 21:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712094833; cv=none; b=akcLbhte7GFYcp8GQ4AUhGJI9BAYrsf/rprrIfkc7wIs6wdY3vOiASyfqqk/GVaQASQZP3RJN6J/K4DXYT/NekBK2V+T103lDIRMc2Up9aqHkR6Z5ceysEGV0bYFj6s7VXwDPTj/gssw2Wp3a87Mo6/OuxFqQ0MLQwAs7JR3eos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712094833; c=relaxed/simple;
	bh=8L7AP3BnqICq8e0xV1Kw8Wz0vhSQ78FGEoVoqkek/R4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JYUHp/u1ueYEhkrTFgy8x8xJNKPdgVYMnGFNTJDMlCWWhaBc4PlFuaGFNKMteTYvmuZbjIaElcV529w4og4IHLn6kQLaUFqV58VyHmvvZCcwoS9AR+RtdJ+z1s64zePEhN1s7LZAyB1QbK+ISh7NTDjtApifswgeCWdkjw/p+5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=opv0ICxh; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1712094824; x=1712699624; i=quwenruo.btrfs@gmx.com;
	bh=imfWIFcQrbQeDJmbbrpnlhMj/0p+mFpWx9/xVTl+qlk=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=opv0ICxhL1oo8oWP9d3s2/EyrO8tgudl8PxrudSX5vzaeN5bITUXLRhTVqPT8k3F
	 aCDYfPJ9IoWLWA8ARpvbRDrDOmUn62WmQxsy99DixXK1/9RC7YbmuwuLN8n4CD0HL
	 DUXPr0aEauVmRHEY3zmDozd9+y0ZLsARUiloCYCBkcYy6TFaKdQUbXUT05BnU4Kmt
	 9pyYGaqpTqysWuJ4/KsZoQI1X5cph6lHS0iT6ynnQTSLsJkNU3jfgXcP3uRc/gDxn
	 Xy1Hjcx33VbEAz+jeMbSQf2UBcHcAjtByxHfXZODOZdV6sgy4TGUuWAxYHZJ1dhll
	 CgZMYRFbW3CSNL0iiQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQvD5-1sDPGK1aNz-00Nyji; Tue, 02
 Apr 2024 23:53:43 +0200
Message-ID: <000d9059-f896-429c-b69e-9b9910f6d421@gmx.com>
Date: Wed, 3 Apr 2024 08:23:40 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: remove not needed mod_start and mod_len from
 struct extent_map
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <2b5929e96bbede278f63c68a149cb50645b094d6.1712074768.git.fdmanana@suse.com>
 <ddd3fbbc-612a-45b1-955b-bc938c4ddb7f@gmx.com>
 <CAL3q7H51p8nyusrAi6dbR3RR4YxtXBHxGUVALt+Xj2Z8EPvZjQ@mail.gmail.com>
Content-Language: en-US
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
In-Reply-To: <CAL3q7H51p8nyusrAi6dbR3RR4YxtXBHxGUVALt+Xj2Z8EPvZjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bQhNkT3i7My9ozRYLRTrY0Q4iwJbYWNb6G6U4/8NvseB/Biy0kB
 gAhgLh33YouGyJPZqPGvX37JkirE0SOtuKfUTySfI/Td4npWgCJwO2l4cvFXjMvjba9wYkH
 EqYlE0iqTddCnhLPB9IkqKdrjSrRADeoSYWf0gtj2K3bemI4PhtS5hcN9baSeCD1G02rP0L
 630tOsm12Lghav95ZNJGQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pSAuM+kk+qc=;UAJgS0doOPMQi3Dj7QmVQBH05Zv
 22kOpfbr2vcYuissc2KaUvp3qX5bdKpzdKB55l4zDTqh9Byq0xPodiPM6YnHyAN7hQjUKTJRR
 Ie2a+0rIiJj8gdSlszpFJ8H2aSZzZBg+kmCvmd6D7Nr2Z07hb9moNr2G/5RF1UnALF7+ZJxP8
 fF3RU6nArLVzgWsFyOOydXAVD4L7LYdQ3sZebYW8d0YXel0m28wuUtwShlzPnodRRFfhcLK6p
 cBhKNyKv2HIwQY07+rPI0/TNwOs+HPSpxZo6OSRoQdeg/6T+NcvtCATMUCt5KM+TOO2Q0uAsW
 N8nm8vZjR/t/dkOP1f5ToS+HUOJiBOpBqd1KiAEY7FbpUyP6U/nowrq1VLksL86AIHT3eh4VI
 YXbcF148jb86uyUXZWNkQXDOQ6Th2RVE472MJP6CBqm4NGou9aUAHRO2FuyRm3eHfSCcb1GPc
 9hn8iyGn8+uXXIMLkkMDJpYjPCzaT0PnbfolZ0jV0mHyVhG6qbPLnyWEMxTia3NDIVnbVLaa5
 jDaAg/YjKwMlJG30Ijfv8m560gyTlzOVlobKFgICLnSiBPxu40LxnNofg7KBAxqepCtS1UEhm
 z3Cd1Y4nUEG1ahnbcnTxCOJf7415eURKPqpWZeAxoisV/0h7b4u0CeHGTYVtfkruasW4tam9R
 iZai7aT9G3p8sDIQD2zSTgse7S+sApxIs6sy25qEXwPtfYHKmIN/D3AuJ6Mb6Q4S3+CqJSvq/
 pBKt8q7Fy2vGS7GpVQaEPiD9QP3C679F/ly3dN00sHhUzWl4CR7BRUjxQBi7qOLg+YIbB3VQ7
 m5zERAKWvYcb/p33ViY6eBhuwSUS8gAOlWzUxA/ixkmEw=



=E5=9C=A8 2024/4/3 08:13, Filipe Manana =E5=86=99=E9=81=93:
> On Tue, Apr 2, 2024 at 10:18=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
>>
>>
>>
>> =E5=9C=A8 2024/4/3 03:10, fdmanana@kernel.org =E5=86=99=E9=81=93:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> The mod_start and mod_len fields of struct extent_map were introduced =
by
>>> commit 4e2f84e63dc1 ("Btrfs: improve fsync by filtering extents that w=
e
>>> want") in order to avoid too low performance when fsyncing a file that
>>> keeps getting extent maps merge, because it resulted in each fsync log=
ging
>>> again csum ranges that were already merged before.
>>>
>>> We don't need this anymore as extent maps in the modified list of exte=
nts
>>> that get merged with other extents and once we log an extent map we re=
move
>>> it from the list of modified extent maps.
>>>
>>> So remove the mod_start and mod_len fields from struct extent_map and =
use
>>> instead the start and len fields when logging checksums in the fast fs=
ync
>>> path. This also makes EXTENT_FLAG_FILLING unused so remove it as well.
>>>
>>> Running the reproducer from the commit mentioned before, with a larger
>>> number of extents and against a null block device, so that IO is fast
>>> and we can better see any impact from searching checkums items and log=
ging
>>> them, gave the following results from dd:
>>>
>>> Before this change:
>>>
>>>      409600000 bytes (410 MB, 391 MiB) copied, 22.948 s, 17.8 MB/s
>>>
>>> After this change:
>>>
>>>      409600000 bytes (410 MB, 391 MiB) copied, 22.9997 s, 17.8 MB/s
>>>
>>> So no changes in throughput.
>>> The test was done in a release kernel (non-debug, Debian's default ker=
nel
>>> config) and its steps are the following:
>>>
>>>      $ mkfs.btrfs -f /dev/nullb0
>>>      $ mount /dev/sdb /mnt
>>>      $ dd if=3D/dev/zero of=3D/mnt/foobar bs=3D4k count=3D100000 oflag=
=3Dsync
>>>      $ umount /mnt
>>>
>>> This also reduce the size of struct extent_map from 128 bytes down to =
112
>>> bytes, so now we can have 36 extents maps per 4K page instead of 32.
>>>
>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
>> Great we can start cleaning up the extent map members.
>>
>> Mind this patch to be included in my upcoming extent map cleaning serie=
s?
>
> Well, the second paragraph needs to be updated to:
>
> "We don't need this anymore as extent maps in the modified list of exten=
ts
> are never merged with other extent maps and once we log an extent map we
> remove it from the list of modified extent maps, so it's never logged tw=
ice."
>
> Plus s/reduce/reduces/ in the last paragraph of the changelog.
>
> Why does it need to be included in your series? Can't I just push this
> to misc-next (with the updated changelog)?
>
> I've also been working on a large patchset for extent maps for quite
> some time, which I hope it's ready in 1 to 2 weeks.
> Several refactorings and a shrinker.
>
> What kind of cleanups do you have?

My plan is to sync the em members with the file extent item members, so
that there is no/less confusion on how to convert a file extent to
extent map.
Orig_start/block_start/block_len/orig_block_len to be replaced by
disk_bytenr/disk_num_bytes/offset, and keep the old members which are
already the more-or-less the same as the file extent items.
(ram_bytes, start, len, generation)

Unfortunately this would result quite some name changes, and would
definitely going to conflict with your changes.

My bad as I'm not aware of your em work, I'm totally fine to wait for
your patch and re-base my work then.

Thanks,
Qu

>
>
>>
>> Thanks,
>> Qu
>>> ---
>>>    fs/btrfs/extent_map.c        | 18 ------------------
>>>    fs/btrfs/extent_map.h        |  4 ----
>>>    fs/btrfs/inode.c             |  4 +---
>>>    fs/btrfs/tree-log.c          |  4 ++--
>>>    include/trace/events/btrfs.h |  3 +--
>>>    5 files changed, 4 insertions(+), 29 deletions(-)
>>>
>>> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
>>> index 445f7716f1e2..471654cb65b0 100644
>>> --- a/fs/btrfs/extent_map.c
>>> +++ b/fs/btrfs/extent_map.c
>>> @@ -252,8 +252,6 @@ static void try_merge_map(struct extent_map_tree *=
tree, struct extent_map *em)
>>>                        em->len +=3D merge->len;
>>>                        em->block_len +=3D merge->block_len;
>>>                        em->block_start =3D merge->block_start;
>>> -                     em->mod_len =3D (em->mod_len + em->mod_start) - =
merge->mod_start;
>>> -                     em->mod_start =3D merge->mod_start;
>>>                        em->generation =3D max(em->generation, merge->g=
eneration);
>>>                        em->flags |=3D EXTENT_FLAG_MERGED;
>>>
>>> @@ -271,7 +269,6 @@ static void try_merge_map(struct extent_map_tree *=
tree, struct extent_map *em)
>>>                em->block_len +=3D merge->block_len;
>>>                rb_erase_cached(&merge->rb_node, &tree->map);
>>>                RB_CLEAR_NODE(&merge->rb_node);
>>> -             em->mod_len =3D (merge->mod_start + merge->mod_len) - em=
->mod_start;
>>>                em->generation =3D max(em->generation, merge->generatio=
n);
>>>                em->flags |=3D EXTENT_FLAG_MERGED;
>>>                free_extent_map(merge);
>>> @@ -300,7 +297,6 @@ int unpin_extent_cache(struct btrfs_inode *inode, =
u64 start, u64 len, u64 gen)
>>>        struct extent_map_tree *tree =3D &inode->extent_tree;
>>>        int ret =3D 0;
>>>        struct extent_map *em;
>>> -     bool prealloc =3D false;
>>>
>>>        write_lock(&tree->lock);
>>>        em =3D lookup_extent_mapping(tree, start, len);
>>> @@ -325,21 +321,9 @@ int unpin_extent_cache(struct btrfs_inode *inode,=
 u64 start, u64 len, u64 gen)
>>>
>>>        em->generation =3D gen;
>>>        em->flags &=3D ~EXTENT_FLAG_PINNED;
>>> -     em->mod_start =3D em->start;
>>> -     em->mod_len =3D em->len;
>>> -
>>> -     if (em->flags & EXTENT_FLAG_FILLING) {
>>> -             prealloc =3D true;
>>> -             em->flags &=3D ~EXTENT_FLAG_FILLING;
>>> -     }
>>>
>>>        try_merge_map(tree, em);
>>>
>>> -     if (prealloc) {
>>> -             em->mod_start =3D em->start;
>>> -             em->mod_len =3D em->len;
>>> -     }
>>> -
>>>    out:
>>>        write_unlock(&tree->lock);
>>>        free_extent_map(em);
>>> @@ -361,8 +345,6 @@ static inline void setup_extent_mapping(struct ext=
ent_map_tree *tree,
>>>                                        int modified)
>>>    {
>>>        refcount_inc(&em->refs);
>>> -     em->mod_start =3D em->start;
>>> -     em->mod_len =3D em->len;
>>>
>>>        ASSERT(list_empty(&em->list));
>>>
>>> diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
>>> index c5a098c99cc6..10e9491865c9 100644
>>> --- a/fs/btrfs/extent_map.h
>>> +++ b/fs/btrfs/extent_map.h
>>> @@ -30,8 +30,6 @@ enum {
>>>        ENUM_BIT(EXTENT_FLAG_PREALLOC),
>>>        /* Logging this extent */
>>>        ENUM_BIT(EXTENT_FLAG_LOGGING),
>>> -     /* Filling in a preallocated extent */
>>> -     ENUM_BIT(EXTENT_FLAG_FILLING),
>>>        /* This em is merged from two or more physically adjacent ems *=
/
>>>        ENUM_BIT(EXTENT_FLAG_MERGED),
>>>    };
>>> @@ -46,8 +44,6 @@ struct extent_map {
>>>        /* all of these are in bytes */
>>>        u64 start;
>>>        u64 len;
>>> -     u64 mod_start;
>>> -     u64 mod_len;
>>>        u64 orig_start;
>>>        u64 orig_block_len;
>>>        u64 ram_bytes;
>>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>>> index 3442dedff53d..c6f2b5d1dee1 100644
>>> --- a/fs/btrfs/inode.c
>>> +++ b/fs/btrfs/inode.c
>>> @@ -7338,9 +7338,7 @@ static struct extent_map *create_io_em(struct bt=
rfs_inode *inode, u64 start,
>>>        em->ram_bytes =3D ram_bytes;
>>>        em->generation =3D -1;
>>>        em->flags |=3D EXTENT_FLAG_PINNED;
>>> -     if (type =3D=3D BTRFS_ORDERED_PREALLOC)
>>> -             em->flags |=3D EXTENT_FLAG_FILLING;
>>> -     else if (type =3D=3D BTRFS_ORDERED_COMPRESSED)
>>> +     if (type =3D=3D BTRFS_ORDERED_COMPRESSED)
>>>                extent_map_set_compression(em, compress_type);
>>>
>>>        ret =3D btrfs_replace_extent_map_range(inode, em, true);
>>> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
>>> index 472918a5bc73..d9777649e170 100644
>>> --- a/fs/btrfs/tree-log.c
>>> +++ b/fs/btrfs/tree-log.c
>>> @@ -4574,8 +4574,8 @@ static int log_extent_csums(struct btrfs_trans_h=
andle *trans,
>>>        struct btrfs_root *csum_root;
>>>        u64 csum_offset;
>>>        u64 csum_len;
>>> -     u64 mod_start =3D em->mod_start;
>>> -     u64 mod_len =3D em->mod_len;
>>> +     u64 mod_start =3D em->start;
>>> +     u64 mod_len =3D em->len;
>>>        LIST_HEAD(ordered_sums);
>>>        int ret =3D 0;
>>>
>>> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs=
.h
>>> index 90b0222390e5..766cfd48386c 100644
>>> --- a/include/trace/events/btrfs.h
>>> +++ b/include/trace/events/btrfs.h
>>> @@ -277,8 +277,7 @@ DEFINE_EVENT(btrfs__inode, btrfs_inode_evict,
>>>                { EXTENT_FLAG_COMPRESS_LZO,     "COMPRESS_LZO"  },\
>>>                { EXTENT_FLAG_COMPRESS_ZSTD,    "COMPRESS_ZSTD" },\
>>>                { EXTENT_FLAG_PREALLOC,         "PREALLOC"      },\
>>> -             { EXTENT_FLAG_LOGGING,          "LOGGING"       },\
>>> -             { EXTENT_FLAG_FILLING,          "FILLING"       })
>>> +             { EXTENT_FLAG_LOGGING,          "LOGGING"       })
>>>
>>>    TRACE_EVENT_CONDITION(btrfs_get_extent,
>>>

