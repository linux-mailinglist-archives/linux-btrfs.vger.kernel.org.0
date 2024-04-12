Return-Path: <linux-btrfs+bounces-4200-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BA48A386F
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 00:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99186285EC0
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 22:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A77615218B;
	Fri, 12 Apr 2024 22:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="cAWLVJL8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B4639FD5
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 22:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712959266; cv=none; b=MBvd1BWWzbFkLEqwwrYUxQp9BVj4jc2CGoKeo45olhxHEV3RBewauOag5Gf0X6wyYCWgAeX6qU8koXX1MOiENg1pxS8MlQ0Y9QGo2SHjYR7QcTSkdlANYYaBD4QoDN9HWLw5fnLhHEd+rVwViEtv3b9ptycYpDXl/guwmJ4w7sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712959266; c=relaxed/simple;
	bh=wzMCEoX2bj/PAZBKD7gMxSRMDruBDAt67E9yl93I8XU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bv6DXkplo/1h5zYsk3PCbWav5/ze6vOeiwyfVWZyMbgBugtnFq3sh6IXeRNTgCYZTEsWT78UN8ZAkl6Klki+kTJpRcJTrIUHjaThhZIyvuJ/Xa4lkLKR5DaKG1Y7y2b+egz4OLxBVLkQkfoF7Q749mbf6cZZG6cSdKbJkMOoTMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=cAWLVJL8; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1712959257; x=1713564057; i=quwenruo.btrfs@gmx.com;
	bh=6XzbIhjVpI+FXqvChn/Owt9WN5uvhGZkkUmDER5kpB0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cAWLVJL8lkLHivsgI7i26qAuAdl/N64aSf1rbNJMKpPY86ujWo7GaGSXQaVvmq3m
	 rogjpJ8I4l4xSjW31inNl/otvYYPv/Q6n7l91TFEbNyh8eHLmAKCdNxpngL/jaNkg
	 2YGME2Z7YXaoqfwSfffVoZvu6KpSf/BrfRX9b1mTrJKewGUGPc0nUu9CBRF+upz8U
	 TFDUlGpT2bL5toSea0msbfKP5l+nh3hiiCCGgpML/sSz0+6vzB9HN1m8KiUXIKpLl
	 bmz/2W14rD2sJV/jMcgrq2VD0YIXwivbUBjke1GsmT+hSx2/n3CjLDxBRD2SDH0A5
	 vtZn97aGmGIcmrEA0Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAONX-1s2EJn3dAx-00BtyD; Sat, 13
 Apr 2024 00:00:57 +0200
Message-ID: <766b8e1e-0c04-4fdb-ae76-b92cd8f85bc3@gmx.com>
Date: Sat, 13 Apr 2024 07:30:53 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/8] btrfs: rename members of
 can_nocow_file_extent_args
To: Filipe Manana <fdmanana@kernel.org>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1712614770.git.wqu@suse.com>
 <5780c450b3b5a642773bf3981bcfd49d1a6080b0.1712614770.git.wqu@suse.com>
 <CAL3q7H77oYtaf4_M3mWYsdSucwi-gTu+wgpEsJhft1vQjwajig@mail.gmail.com>
 <65a7c2b6-9700-4d52-bd5e-9bfc2e32327d@gmx.com>
 <CAL3q7H7U087v0t3N_fpdsqCBXJGm9dr5oFft5m6jaGEhS1b=5w@mail.gmail.com>
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
In-Reply-To: <CAL3q7H7U087v0t3N_fpdsqCBXJGm9dr5oFft5m6jaGEhS1b=5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JvsiZDbMHe97nZPtH8sY53QwA1sPM4JkxxQCGL63PuwZf6KTRAD
 h48+/JlA0U9CZo5NzuzE2smi9PhgbRwJFZcVOifN1DBqaCIxJcZ4b5f/JaQnWqXieLDUfHy
 VMi2lt4JyoW0m1FzVPRfuiyrsclLNhg1Wqsi0QHmLqLPlZ+0Q/JrR7JlE3+aM4R5R1KXWxI
 nsv0SMEJpgyfgUQrExV/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MuQbeeyznUQ=;T6+ALWTkKF+ZKpS7Jd3C0U3unx9
 ihOeF4E3Yd8a1GSLu3i9cWWljcR7MPxoyq+fEEgZJh7k4ldKrapJz5xghlFet40l/VVQVz+jU
 omd/haosfAPR+wdm9ehI/a76szpWCSBsIcrT2/Np52+d8jQO9sqg5awVQJxZgngeEXGfDcEDi
 MU/fACJI5FC1Q3LnFxO3a05MwGv9GoPq9qtMb8XgRwwuER5rT8MBGXfnKs7EeY7tEQvZIrgXk
 zT1buOvD1I0GbVZoGwYn5SW+v4s2elIYhZQFTlS/cj8SzKGrHo9niHlTeJeMUTVZwmFE16Y8i
 88xAidPEORh+XNqLiQxIwkeVNnjJ3aCYGW8klFqdqelwvqhgqaM7Wr5nG7x0aLvgGzsFHIA80
 oSrvHMMisgnBjHIKDkq0qxYN10ReBL5kafEKUTB4yGVnU2r5D5UQHqR31ZUK1aQBQ2MxrjR/o
 VeJVL/wTgRn5dhwWyf0sEQHO2XCdiV8n/0TPqQeRdSjZXLTwJOKLJo2sUIRooZFSYwNDqvfTu
 JnbT3ppy/5XIUAktfhgKOWrZR8IAqt2hhabUciXTpVLZP/iRZf/h16A8RVin7kE5X01kdkjsi
 /jqCTAa2ry9s9g8oYRUWVhUo+iXzZRViHG0K3c9x3DGdaBwWo1exWC9XG1q395E3mvQ/lbySx
 HSgNG1crE8ocEMsgGRmYCjmaDqKY6WJskAqtbtfc8KT3cIe2QaNgOXPt9n9mn3Zg6W0ymtSc2
 CIdFHuZ5h9oqcoj9Q+D/H8yqyJ0RGA0aVwGt6cFoIzZ/uwyI0HUTqBGEPBMuoNOCpYlIaNyi0
 shgvdY4JuPUfryQ2xTXKdLs+PpKBy2QVLdRcEGcsQqxd0=



=E5=9C=A8 2024/4/12 22:51, Filipe Manana =E5=86=99=E9=81=93:
> On Thu, Apr 11, 2024 at 11:03=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.c=
om> wrote:
[...]
>>
>> Well, the new @block_start matches the old extent_map::block_start.
>
> So it becomes a single exception, different from everywhere else.
> Doesn't seem like a good thing in general.

OK, I can get rid of the @block_start name.

>
>>
>> I have to say, we do not have a solid definition on "disk_bytenr" in th=
e
>> first place.
>
> Well I find the name clear, it is a disk location measured by a byte add=
ress.
> block_start is not so clear for anyone not familiar with btrfs'
> internals, it makes me think of a block number and wonder what's the
> block size, etc.
>
>>
>> Should it always match ondisk file_extent_item::disk_bytenr, or should
>> it act like "block_start" of the old extent_map?
>
> It's always about a range of a file extent item, be it the whole range
> or just a part of it.
> I don't see why it's confusing to use disk_bytenr, etc.
> I find it more confusing to use something else, or at least what's
> being proposed in this patch.

Well, IMHO since we take the name @disk_bytenr from btrfs file extent
item, and btrfs file extent uses @disk_bytenr to uniquely locate a data
extent, then we should also follow it to use @disk_bytenr for the same
purpose.

So that every time we see the name @disk_bytenr, we know it can be used
to locate a data extent, without any need for weird offset calculation.

That's why I'm strongly against adding any offset into @disk_bytenr.
And I believe that's the biggest difference in our points of view.

Although in this particular case, I can use some extra prefixs like
"orig_" or "fe_" (for file extent), so that those members can be later
directly passed to create_io_em() without extra offset calculation.

Would that be a acceptable trade-off?


Another solution would be just drop this patch, and do extra calulation
resulting something like this:

	create_io_em(...,
		     disk_bytenr - whatever_offset, /* disk_bytenr */
		     offset - whatever_offset, /* offset */
		     PREALLOC, ...);

At least that does not sound sane to me, and can be bug prune.
You won't believe how many different crashes I hit just due to the weird
disk_bytenr calculation here, and that's the biggest reason I have

Thanks,
Qu


>
>>
>> And if we have separate definitions, one to always match file extent
>> item disk_bytenr, and one to match the real IO start bytenr, what shoul=
d
>> be their names?
>>
>> I hope we can get a good naming to solve the confusion, any good idea?
>
> For me the current naming is fine and I don't find it confusing... So,
> I'm not sure what to tell you.
>
>>
>> Thanks,
>> Qu
>>>
>>>>
>>>> - Add extra comments explaining those members
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>    fs/btrfs/inode.c | 51 ++++++++++++++++++++++++++++----------------=
----
>>>>    1 file changed, 30 insertions(+), 21 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>>>> index 2e0156943c7c..4d207c3b38d9 100644
>>>> --- a/fs/btrfs/inode.c
>>>> +++ b/fs/btrfs/inode.c
>>>> @@ -1847,11 +1847,20 @@ struct can_nocow_file_extent_args {
>>>>            */
>>>>           bool free_path;
>>>>
>>>> -       /* Output fields. Only set when can_nocow_file_extent() retur=
ns 1. */
>>>> +       /*
>>>> +        * Output fields. Only set when can_nocow_file_extent() retur=
ns 1.
>>>> +        *
>>>> +        * @block_start:        The bytenr of the new nocow write sho=
uld be at.
>>>> +        * @orig_disk_bytenr:   The original data extent's disk_byten=
r.
>>>
>>> This orig_disk_bytenr field is not defined anywhere in this patch.
>>>
>>> Thanks.
>>>
>>>> +        * @orig_disk_num_bytes:The original data extent's disk_num_b=
ytes.
>>>> +        * @orig_offset:        The original offset inside the old da=
ta extent.
>>>> +        *                      Caller should calculate their own
>>>> +        *                      btrfs_file_extent_item::offset base o=
n this.
>>>> +        */
>>>>
>>>> -       u64 disk_bytenr;
>>>> -       u64 disk_num_bytes;
>>>> -       u64 extent_offset;
>>>> +       u64 block_start;
>>>> +       u64 orig_disk_num_bytes;
>>>> +       u64 orig_offset;
>>>>           /* Number of bytes that can be written to in NOCOW mode. */
>>>>           u64 num_bytes;
>>>>    };
>>>> @@ -1887,9 +1896,9 @@ static int can_nocow_file_extent(struct btrfs_p=
ath *path,
>>>>                   goto out;
>>>>
>>>>           /* Can't access these fields unless we know it's not an inl=
ine extent. */
>>>> -       args->disk_bytenr =3D btrfs_file_extent_disk_bytenr(leaf, fi)=
;
>>>> -       args->disk_num_bytes =3D btrfs_file_extent_disk_num_bytes(lea=
f, fi);
>>>> -       args->extent_offset =3D btrfs_file_extent_offset(leaf, fi);
>>>> +       args->block_start =3D btrfs_file_extent_disk_bytenr(leaf, fi)=
;
>>>> +       args->orig_disk_num_bytes =3D btrfs_file_extent_disk_num_byte=
s(leaf, fi);
>>>> +       args->orig_offset =3D btrfs_file_extent_offset(leaf, fi);
>>>>
>>>>           if (!(inode->flags & BTRFS_INODE_NODATACOW) &&
>>>>               extent_type =3D=3D BTRFS_FILE_EXTENT_REG)
>>>> @@ -1906,7 +1915,7 @@ static int can_nocow_file_extent(struct btrfs_p=
ath *path,
>>>>                   goto out;
>>>>
>>>>           /* An explicit hole, must COW. */
>>>> -       if (args->disk_bytenr =3D=3D 0)
>>>> +       if (args->block_start =3D=3D 0)
>>>>                   goto out;
>>>>
>>>>           /* Compressed/encrypted/encoded extents must be COWed. */
>>>> @@ -1925,8 +1934,8 @@ static int can_nocow_file_extent(struct btrfs_p=
ath *path,
>>>>           btrfs_release_path(path);
>>>>
>>>>           ret =3D btrfs_cross_ref_exist(root, btrfs_ino(inode),
>>>> -                                   key->offset - args->extent_offset=
,
>>>> -                                   args->disk_bytenr, args->strict, =
path);
>>>> +                                   key->offset - args->orig_offset,
>>>> +                                   args->block_start, args->strict, =
path);
>>>>           WARN_ON_ONCE(ret > 0 && is_freespace_inode);
>>>>           if (ret !=3D 0)
>>>>                   goto out;
>>>> @@ -1947,15 +1956,15 @@ static int can_nocow_file_extent(struct btrfs=
_path *path,
>>>>               atomic_read(&root->snapshot_force_cow))
>>>>                   goto out;
>>>>
>>>> -       args->disk_bytenr +=3D args->extent_offset;
>>>> -       args->disk_bytenr +=3D args->start - key->offset;
>>>> +       args->block_start +=3D args->orig_offset;
>>>> +       args->block_start +=3D args->start - key->offset;
>>>>           args->num_bytes =3D min(args->end + 1, extent_end) - args->=
start;
>>>>
>>>>           /*
>>>>            * Force COW if csums exist in the range. This ensures that=
 csums for a
>>>>            * given extent are either valid or do not exist.
>>>>            */
>>>> -       ret =3D csum_exist_in_range(root->fs_info, args->disk_bytenr,=
 args->num_bytes,
>>>> +       ret =3D csum_exist_in_range(root->fs_info, args->block_start,=
 args->num_bytes,
>>>>                                     nowait);
>>>>           WARN_ON_ONCE(ret > 0 && is_freespace_inode);
>>>>           if (ret !=3D 0)
>>>> @@ -2112,7 +2121,7 @@ static noinline int run_delalloc_nocow(struct b=
trfs_inode *inode,
>>>>                           goto must_cow;
>>>>
>>>>                   ret =3D 0;
>>>> -               nocow_bg =3D btrfs_inc_nocow_writers(fs_info, nocow_a=
rgs.disk_bytenr);
>>>> +               nocow_bg =3D btrfs_inc_nocow_writers(fs_info, nocow_a=
rgs.block_start);
>>>>                   if (!nocow_bg) {
>>>>    must_cow:
>>>>                           /*
>>>> @@ -2151,14 +2160,14 @@ static noinline int run_delalloc_nocow(struct=
 btrfs_inode *inode,
>>>>                   nocow_end =3D cur_offset + nocow_args.num_bytes - 1=
;
>>>>                   is_prealloc =3D extent_type =3D=3D BTRFS_FILE_EXTEN=
T_PREALLOC;
>>>>                   if (is_prealloc) {
>>>> -                       u64 orig_start =3D found_key.offset - nocow_a=
rgs.extent_offset;
>>>> +                       u64 orig_start =3D found_key.offset - nocow_a=
rgs.orig_offset;
>>>>                           struct extent_map *em;
>>>>
>>>>                           em =3D create_io_em(inode, cur_offset, noco=
w_args.num_bytes,
>>>>                                             orig_start,
>>>> -                                         nocow_args.disk_bytenr, /* =
block_start */
>>>> +                                         nocow_args.block_start, /* =
block_start */
>>>>                                             nocow_args.num_bytes, /* =
block_len */
>>>> -                                         nocow_args.disk_num_bytes, =
/* orig_block_len */
>>>> +                                         nocow_args.orig_disk_num_by=
tes, /* orig_block_len */
>>>>                                             ram_bytes, BTRFS_COMPRESS=
_NONE,
>>>>                                             BTRFS_ORDERED_PREALLOC);
>>>>                           if (IS_ERR(em)) {
>>>> @@ -2171,7 +2180,7 @@ static noinline int run_delalloc_nocow(struct b=
trfs_inode *inode,
>>>>
>>>>                   ordered =3D btrfs_alloc_ordered_extent(inode, cur_o=
ffset,
>>>>                                   nocow_args.num_bytes, nocow_args.nu=
m_bytes,
>>>> -                               nocow_args.disk_bytenr, nocow_args.nu=
m_bytes, 0,
>>>> +                               nocow_args.block_start, nocow_args.nu=
m_bytes, 0,
>>>>                                   is_prealloc
>>>>                                   ? (1 << BTRFS_ORDERED_PREALLOC)
>>>>                                   : (1 << BTRFS_ORDERED_NOCOW),
>>>> @@ -7189,7 +7198,7 @@ noinline int can_nocow_extent(struct inode *ino=
de, u64 offset, u64 *len,
>>>>           }
>>>>
>>>>           ret =3D 0;
>>>> -       if (btrfs_extent_readonly(fs_info, nocow_args.disk_bytenr))
>>>> +       if (btrfs_extent_readonly(fs_info, nocow_args.block_start))
>>>>                   goto out;
>>>>
>>>>           if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW) &&
>>>> @@ -7206,9 +7215,9 @@ noinline int can_nocow_extent(struct inode *ino=
de, u64 offset, u64 *len,
>>>>           }
>>>>
>>>>           if (orig_start)
>>>> -               *orig_start =3D key.offset - nocow_args.extent_offset=
;
>>>> +               *orig_start =3D key.offset - nocow_args.orig_offset;
>>>>           if (orig_block_len)
>>>> -               *orig_block_len =3D nocow_args.disk_num_bytes;
>>>> +               *orig_block_len =3D nocow_args.orig_disk_num_bytes;
>>>>
>>>>           *len =3D nocow_args.num_bytes;
>>>>           ret =3D 1;
>>>> --
>>>> 2.44.0
>>>>
>>>>
>>>
>

