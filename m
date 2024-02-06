Return-Path: <linux-btrfs+bounces-2173-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC8684BED3
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 21:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77A49B25B66
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 20:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E671B80F;
	Tue,  6 Feb 2024 20:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="NS08uPLf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38B51B807
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Feb 2024 20:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707252079; cv=none; b=aM1lqyhCbR7frQqY8l2aYGNOuEU8agjaOBODTf73QTiBQdPmcZydgoiuMx9S5mj/gVwADgAdmQrTUw2EjfKUfvsFlLYZ5Cmd4v+YfOr4iaT33dob8FLXf6eckXm7o7htZnJvANm8GEfxddUhr5nq8Ak7weFCBvLc4k5C8G1BlL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707252079; c=relaxed/simple;
	bh=rVCFHbdlgxGUw+vsDRQsd5sZfGNR0IR8ttGHlX9hewk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=chD+TwYL8GvWoOnEXSfEnsUhgb1PSsrENoRzLcvCh89gRenBsIbeKpOOy6Ttiv2sFoKnV0UrkLykLHQwADh/sYYE13PX2/pOOxjXZQMsk8ptVPpzw5fyh+dlEKAL2V2Om4+heSUOravkc/rStoa8sGJz3EG/WiqMs3M6yXn0rOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=NS08uPLf; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707252070; x=1707856870; i=quwenruo.btrfs@gmx.com;
	bh=rVCFHbdlgxGUw+vsDRQsd5sZfGNR0IR8ttGHlX9hewk=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=NS08uPLfks65WLHAG2+AFV2qLdsrsTWooq0QznArnCG2w9PzmCNn21AcxJqc8QXX
	 O2WYs576R37kn6HT67KDhWXXGN/rgsAbATU8XFrn7Yom8A5prJwgm895KXG2dsRQd
	 9/9zWKXHkEhIVtI/Tvak9/jUPPmwOM/CjWTnsM2ctnfKeiBjq3CTYFLsjWkEd2XAK
	 0wHp3vkTuJcIFTUyCZh3pKGWRvLH1NPhoxdMyUNUPR+ICWdGxvtbvOU3BJzmxw++l
	 LOB/b0wVNQJ1L5rKnwpeGHhbV/hEX36yFgIJWG9QQ0Qw7IV+ynn7rfnZ2fVFij2G/
	 nBkRn+jZy23Aa9/N3Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([61.245.157.120]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M4s0t-1rYHjO2iQR-001ym0; Tue, 06
 Feb 2024 21:41:10 +0100
Message-ID: <54a1bb50-7fd2-440f-8563-a82c54bb2179@gmx.com>
Date: Wed, 7 Feb 2024 07:11:08 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs: defrag: add under utilized extent to defrag
 target list
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org,
 Christoph Anton Mitterer <calestyo@scientia.org>
References: <cover.1707172743.git.wqu@suse.com>
 <2188d9521696a2c5f9bbb81479c6c94ea827a0aa.1707172743.git.wqu@suse.com>
 <CAL3q7H72pQ=3wPZpN9zow8+G4xnhSP5UKH1ev808Y5GYYB2BQw@mail.gmail.com>
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
In-Reply-To: <CAL3q7H72pQ=3wPZpN9zow8+G4xnhSP5UKH1ev808Y5GYYB2BQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ckC9+BCY74H9RLTXuva4fa3NaChXyvrEXU/A1k29BYJdq3gVhWi
 oFt4xVij838a709AGli49vX0AT5TcU0vcZku7XsNoEsklLImJtL24K0RbSUbHN9Rg94I/+e
 e0pyrb+YEFP7xvZz3Rlfsy1/pjdm0h6dEGyGxFkKTNwwbojphsz9OLm/8DFkwH4mPKNvt2O
 Ar/RLczanrFySEGQFpnHQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yspnAKXY1jM=;fW4SP+QDwB+qPfkMzV08Y2lmy1E
 3CMdZftOh9n6EQXubuWzRyq3EMWZDVUQbswYnAWlLjNCCI9pUv2/fFXkeaA2ku7mbZv3M4wHr
 rFmvyZfJtiQnUO5ox0opITbR4xOq4+gLAefzlPS25gzbE4bNI2dS0gxVLAd3XSV9f6OMWqB3W
 4conDYSJjBbQb691kRjDG0c/P9qa0dkiAgh0hVyvSOcDevzeXyJpi9XLo6SYmNl9PbJexetfi
 rTXJAXm3+wR49b5kj5e2L/EgAxvbGC8zBPXSEOBqJOidh7vQR0uvI1FUpzbWdbFsaOsqnJ1k0
 +nmtTYlZ2sgrf+uBnUJHlzReyOT9zKCCs4WVu0fAKVJ2Z9xHxHdtHJrMYtjjnRMaaMSipEzyw
 nrarkM3azooVeJKMhjc2SHSg/SzG0zVnAlmq7eyTebKKbkQCub7sCwUfr7wVZzENbkJYFfAiN
 yUJmTj4c9GqAiJTjnomBSj6pw8ZHxXE235iliFxVeTRzRJdT0L6oT+TETBcdATN1bhv7OF4Ck
 3qH6TeMWapTyu3vQ8tkLqUgHrVCDTfQ2plYa8LN1YJ0SUdXm1RfqgjxAyn67bCcjMKeJcKWnU
 Q88Har2ZfFhvaIWyPXra3Z9rniVIHVHv5s1ZjXgZrk5L99RJIslGZ0ie75WtJtkw91hJ9U/eE
 TmNWJAwazGrsQxNpkW372+R0En1fPkVJxTBqznM1siIZfOWflAdQqajurdQlH+aaNK1+1/gwq
 tN2MXU+ufEHH2kZPFcMUCm4kjcwHSO42OmlRxntDk95C988i8dm9IbBeps1GRi59xX5agp0gi
 MygQhzjcnm408GPy67+6rLlrQlRIz63aX4Ycj9G9qjFMk=



On 2024/2/7 02:53, Filipe Manana wrote:
> On Mon, Feb 5, 2024 at 11:46=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> The following script can lead to a very under utilized extent and we
>> have no way to use defrag to properly reclaim its wasted space:
>>
>>    # mkfs.btrfs -f $dev
>>    # mount $dev $mnt
>>    # xfs_io -f -c "pwrite 0 128M" $mnt/foobar
>>    # sync
>>    # truncate -s 4k $mnt/foobar
>>    # btrfs filesystem defrag $mnt/foobar
>>    # sync
>>
>> After the above operations, the file "foobar" is still utilizing the
>> whole 128M:
>>
>>          item 4 key (257 INODE_ITEM 0) itemoff 15883 itemsize 160
>>                  generation 7 transid 8 size 4096 nbytes 4096
>>                  block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
>>                  sequence 32770 flags 0x0(none)
>>          item 5 key (257 INODE_REF 256) itemoff 15869 itemsize 14
>>                  index 2 namelen 4 name: file
>>          item 6 key (257 EXTENT_DATA 0) itemoff 15816 itemsize 53
>>                  generation 7 type 1 (regular)
>>                  extent data disk byte 298844160 nr 134217728 <<<
>>                  extent data offset 0 nr 4096 ram 134217728
>>                  extent compression 0 (none)
>>
>> This is the common btrfs bookend behavior, that 128M extent would only
>> be freed if the last referencer of the extent is freed.
>>
>> The problem is, normally we would go defrag to free that 128M extent,
>> but defrag would not touch the extent at all.
>>
>> [CAUSE]
>> The file extent has no adjacent extent at all, thus all existing defrag
>> code consider it a perfectly good file extent, even if it's only
>> utilizing a very tiny amount of space.
>>
>> [FIX]
>> For a file extent without any adjacent file extent, we should still
>> consider to defrag such under utilized extent, base on the following
>> conditions:
>>
>> - utilization ratio
>>    If the extent is utilizing less than 1/16 of the on-disk extent size=
,
>>    then it would be a defrag target.
>>
>> - wasted space
>>    If we defrag the extent and can free at least 16MiB, then it would b=
e
>>    a defrag target.
>>
>> Reported-by: Christoph Anton Mitterer <calestyo@scientia.org>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> As I said in my previous review, please include the lore link to the
> report, it's always useful.
>
>> ---
>>   fs/btrfs/defrag.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 42 insertions(+)
>>
>> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
>> index 8fc8118c3225..85c6e45d0cd4 100644
>> --- a/fs/btrfs/defrag.c
>> +++ b/fs/btrfs/defrag.c
>> @@ -950,6 +950,38 @@ struct defrag_target_range {
>>          u64 len;
>>   };
>>
>> +/*
>> + * Special entry for extents that do not have any adjacent extents.
>> + *
>> + * This is for cases like the only and truncated extent of a file.
>> + * Normally they won't be defraged at all (as they won't be merged wit=
h
>> + * any adjacent ones), but we may still want to defrag them, to free u=
p
>> + * some space if possible.
>> + */
>> +static bool should_defrag_under_utilized(struct extent_map *em)
>
> Can be made const.
>
>> +{
>> +       /*
>> +        * Ratio based check.
>> +        *
>> +        * If the current extent is only utilizing 1/16 of its on-disk =
size,
>> +        * it's definitely under-utilized, and defragging it may free u=
p
>> +        * the whole extent.
>> +        */
>> +       if (em->len < em->orig_block_len / 16)
>> +               return true;
>> +
>> +       /*
>> +        * Wasted space based check.
>> +        *
>> +        * If we can free up at least 16MiB, then it may be a good idea
>> +        * to defrag.
>> +        */
>> +       if (em->len < em->orig_block_len &&
>> +           em->orig_block_len - em->len > SZ_16M)
>
> The first check, len < orig_block_len, is redundant, isn't it?
> em->len can only be less than or equals to em->orig_block_len.
> The second condition is enough to have.

Not exactly, don't forget compressed file extents.

>
>> +               return true;
>> +       return false;
>> +}
>> +
>>   /*
>>    * Collect all valid target extents.
>>    *
>> @@ -1070,6 +1102,16 @@ static int defrag_collect_targets(struct btrfs_i=
node *inode,
>>                  if (!next_mergeable) {
>>                          struct defrag_target_range *last;
>>
>> +                       /*
>> +                        * This is a single extent without any chance t=
o merge
>> +                        * with any adjacent extent.
>> +                        *
>> +                        * But if we may free up some space, it is stil=
l worth
>> +                        * defragging.
>> +                        */
>> +                       if (should_defrag_under_utilized(em))
>> +                               goto add;
>> +
>
> So this logic is making some cases worse actually, making us use more
> disk space.
> For example:
>
> DEV=3D/dev/sdi
> MNT=3D/mnt/sdi
>
> mkfs.btrfs -f $DEV
> mount $DEV $MNT
>
> xfs_io -f -c "pwrite 0 128M" $MNT/foobar
> sync
> xfs_io -c "truncate 40M" $MNT/foobar
> btrfs filesystem defrag $MNT/foobar
>
> After this patch, we get:
>
> item 6 key (257 EXTENT_DATA 0) itemoff 15810 itemsize 53
> generation 7 type 1 (regular)
> extent data disk byte 1104150528 nr 134217728
> extent data offset 0 nr 8650752 ram 134217728
> extent compression 0 (none)
> item 7 key (257 EXTENT_DATA 8650752) itemoff 15757 itemsize 53
> generation 8 type 1 (regular)
> extent data disk byte 1238368256 nr 33292288
> extent data offset 0 nr 33292288 ram 33292288
> extent compression 0 (none)

This behavior is unexpected, as we should redirty the whole 40M, but the
first 8.25M didn't got re-dirtied is a big problem to me.
Will look into the situation.

>
> So we're now using 128M + 32M of disk space where before defrag we used =
128M.
> Before the defrag we had:
>
> item 6 key (257 EXTENT_DATA 0) itemoff 15810 itemsize 53
> generation 7 type 1 (regular)
> extent data disk byte 1104150528 nr 134217728
> extent data offset 0 nr 41943040 ram 134217728
> extent compression 0 (none)
>
> So something's not good in this logic.
>
> Also, there's something else worth considering here, which is extent sha=
redness.

This is a known problem for defrag, thus for snapshot/reflink it's
really on the end user to determine whether they really need defrag.

Thanks,
Qu
> If an extent is shared we don't want to always dirty the respective
> range and rewrite it, as that may result in using more disk space...
>
> Example:
>
> xfs_io -f -c "pwrite 0 128M" $MNT/foobar
> btrfs subvolume snapshot $MNT $MNT/snap
> xfs_io -c "truncate 16M" $MNT/foobar
> btrfs filesystem defrag $MNT/foobar
>
> We end up consuming an additional 16M of data without any benefits.
> Without this patch, this wouldn't happen.
>
> Thanks.
>
>
>>                          /* Empty target list, no way to merge with las=
t entry */
>>                          if (list_empty(target_list))
>>                                  goto next;
>> --
>> 2.43.0
>>
>>
>

