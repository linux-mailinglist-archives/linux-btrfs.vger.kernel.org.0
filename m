Return-Path: <linux-btrfs+bounces-4880-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0E88C1941
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 00:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE3CA1F21F3F
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 22:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D50129E76;
	Thu,  9 May 2024 22:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="nqThWMBW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E0A129E6B
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 22:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715292727; cv=none; b=EZOpABkb2JMIo2vJEedPrMvEuCIACr2/WY7VQ4r3zBNtZQnL5XKl+KiXgCZGU/BxU3uSUrum13AT6JPmLEsZOX6Cgk8HIjoNA9pSVXoBUcaUlC0+elWzqcyZGYtetTsxZ3JcJPkM7cxJXwlp6yD0A0Hdy8Xf07VuYgAxt65GTh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715292727; c=relaxed/simple;
	bh=zUMjNhwIwzI1BZCjFsQdOpiz5BhKmPt3xpzd9Y8BcSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OeQ/B4dJiSFw3NOC2LZ8YmKnpMFcMjbCqzeW8OriuSfdg0BrLNL9dmPfsQfHpPqNJWPBjLfOn1r/S+ZImbNygMoqYrbPkkVBrB9mOX63fQFJul9JJEMZ2u5VE7bB8XCBdABlwfZ4GDzZk3Fjo++Up0Pw48rhthv1Psp7jaZJi1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=nqThWMBW; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715292715; x=1715897515; i=quwenruo.btrfs@gmx.com;
	bh=uIvj1gpujVnjJ8Q7YZRRsvRZgpGMsGleE3VuJpTkhkU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=nqThWMBWKfhK9R1QPaFQ1LXrVB3tmTb1ozjviETN0B/5ba3kiMNxHFa59ORFkDaE
	 k46mT24BNJ84kqzxkiQ/BqljZY2hu619pQQHp55JGWtBRFHYt16eegYa74Ip9s6e6
	 Qx41g8uSbOU+8/3hMI+TAb6aqq162ZS49dvnPg/RLAhtoc9W7jlZgIysDYo5AMYl9
	 AWEMHiDPzrri7HluMr7XHmUjscL2U9sQggNIZix/Eawyws4/4U57KJnqoWc+H4+dV
	 ch1ujyI0PwjNM5s3Mx84Q0Ftr8Ea67SDbR17699Qh7ap69StHZGyvS/6Sz9lMpMDb
	 qCS+quJHuaHtPBjlfg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N3KTy-1snqDR0Lli-010LwQ; Fri, 10
 May 2024 00:11:55 +0200
Message-ID: <1fe28d75-a4a3-4304-9998-a88a5fee4919@gmx.com>
Date: Fri, 10 May 2024 07:41:50 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] btrfs: introduce new members for extent_map
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <cover.1714707707.git.wqu@suse.com>
 <f0be8547f0df8d8a4578c5e4d9b560c053dab8db.1714707707.git.wqu@suse.com>
 <CAL3q7H7uWw=LnWYXZnZV+kYKho+F4iBcBgZ5GziWeTofVPLDYw@mail.gmail.com>
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
In-Reply-To: <CAL3q7H7uWw=LnWYXZnZV+kYKho+F4iBcBgZ5GziWeTofVPLDYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DGpQt0AQ++BdpCMroYf0Y6RBz4doJBtiyUsKx0krzw0DWoqEDdB
 1I3jgyUFxye0aw+EQzmga3m7fsUDBwodjogGBlOjr0+s8SahRjWnFbn8yEO6hTvVy0hkkYw
 YRLc+a25DfO1PDBvvD+xC8pu8ofgwYD4EFEsDKzcPZ+n7apSbYGo0bWgGgAsjxZE4nQjWYM
 JdYHknyVFuw2FsrIQ0OfA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:y3YS6IENeLc=;7CPWuFxL2tfjoFlVkHUqwrqZojt
 RGnAf11zMk9F+TkxitvhfTS//ahTHs1x6FZbAXI7DyinKwgCyw8bKcg+4WfY6HK/YQd4OAYFM
 GqYcYPZuNCakgm0EhNuNqTQAhsxCaQ9297KKkNZTGcfe2nnJlKloge+gLq8d9VQioy5QA/5C6
 qo/OoqPxtOQudDtUzLfgklqPQYKanpuPgOx9dPr0bRxEdwty9eglDCdew6ouYQ7lB/SqCHkuv
 GF3mWdCjsn/4PEAwedTvvTX+Gyfvok9iGZcPAlnSjWdLd1rC4nUqnG8kdPdOFkyWjrlAmUFDR
 V+w8Mr8IvlRCzPMod8+7tGG8RBgERNh2Ck2dvPsrZ8YTi49upwVnc3elmJ0OPG0M+dCFzgN6a
 EgMCrhA2QmSeA+dXEtRN7DlqASjV+eFlIjs01I6lqZHgZ0e2nN1KBKGusxi2X+Cqtc+AAbcaN
 Ia46FSM3M66WpVm0B8VSAF+8bPTv6MZiRvZqECUiHp/NuoRKQjjbyR08C05Q3k1RRKykyAKTH
 42MNd5QUzfJ8WAltThDgAQhjUZpVaOXNzZcFTtxQnzA14R82AqnJfdsoCESUHD30fi7dNF1/J
 4MGVxgLcPfQjcWvqnmD3jmqiP9Tkx5K3aq+mCqohV1a/C9ACXbhSyeC+cgZPWMx85qxSNlFY+
 +Fry/EEnYIY1Qnvqf3XBqpCReKrafOz13IUJnGlobqNMl0kdEmCeT4aDKspP/19VZhPMfhCpA
 n+Gv57+1uaTYhLX2yV78+jpn0iKFQNXTwV3dfyAnteN1bx9tvX8qWHXnEtRld8pC0eIB4Q2aq
 YSEq3Jjl/qaVOXaxTtOgy3hMgzKrocVHajXxQa0dIyZ1g=



=E5=9C=A8 2024/5/10 02:35, Filipe Manana =E5=86=99=E9=81=93:
> On Fri, May 3, 2024 at 7:02=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>> Introduce two new members for extent_map:
>>
>> - disk_bytenr
>> - offset
>>
>> Both are matching the members with the same name inside
>> btrfs_file_extent_items.
>>
>> For now this patch only touches those members when:
>>
>> - Reading btrfs_file_extent_items from disk
>> - Inserting new holes
>> - Merging two extent maps
>>    With the new disk_bytenr and disk_num_bytes, doing merging would be =
a
>>    little complex, as we have 3 different cases:
>>
>>    * Both extent maps are referring to the same data extent
>>    * Both extent maps are referring to different data extents, but
>>      those data extents are adjacent, and extent maps are at head/tail
>>      of each data extents
>
> I have no idea what this last part of the sentence means:
>
> "and extent maps are at head/tail of each data extents"

For this case:

         |<- data extent 1 ->|<- data extent 2 ->|
	|          |////////|////////|          |
                      FE A      FE B

In above case, FE A is only referring the tailing part of data extent 1,
and FE B is referring to the heading part of data extent 2.

In that case, FE A and FE B can be merged into something like this:

         |<------ merged extent 1 + 2 --------->|
	|          |/////////////////|         |
                        FE A + B

In that case, merged file extent would have:

- disk_bytenr =3D fe_a->disk_bytenr
- disk_num_bytes =3D fe_a->disk_num_bytes + fe_b->disk_num_bytes
- ram_bytes =3D fe_a->ram_bytes + fe_b->ram_bytes
- offset =3D fe_a->offset
- num_bytes =3D fe_a->num_bytes + fe_b->num_bytes

>
>>    * One of the extent map is referring to an merged and larger data
>
> map -> maps
> an -> a
>
>>      extent that covers both extent maps
>
> Not sure if I can understand this. How can one of the extent maps
> already cover the range of the other extent map?
> This suggests some overlapping, or most likely I misunderstood what
> this is trying to say.

That's the for impossible test case 3, but as you mentioned, it's more
sane just to remove it.

[...]
>
>> +        *
>> +        * The calculation here always merge the data extents first, th=
en update
>> +        * @offset using the new data extents.
>> +        *
>> +        * For case 1), the merged data extent would be the same.
>> +        * For case 2), we just merge the two data extents into one.
>> +        * For case 3), we just got the larger data extent.
>> +        */
>> +       new_disk_bytenr =3D min(prev->disk_bytenr, next->disk_bytenr);
>> +       new_disk_num_bytes =3D max(prev->disk_bytenr + prev->disk_num_b=
ytes,
>> +                                next->disk_bytenr + next->disk_num_byt=
es) -
>> +                            new_disk_bytenr;
>
> So this is confusing, disk_num_bytes being a max between the two
> extent maps and not their sum.

Check case 1).

Both file extents are referring to the same data extent.

Like this:

FE 1, file pos 0, num_bytes 4K, disk_bytenr X, disk_num_bytes 16K,
offset 0, ram_bytes 16K, compression none

FE 2, file pos 4k, num_bytes 4K, disk_bytenr X, disk_num_bytes 16K,
offset 4k, ram_bytes 16K, compression none.

In that case we should not just sum up the disk_num_bytes at all.
Remember disk_num_bytes are for the data extent.

> I gather this is modelled after what we already do at
> btrfs_drop_extent_map_range() when splitting.
>
> But the truth is we never used the disk_num_bytes of an extent map
> that was merged - we also didn't do it before this patch, for that
> reason.
> It's only used for logging new extents - which can't be merged - they
> can be merged only after being logged.
>
> We can set this to the sum, or leave with some value to signal it's inva=
lid.
> Just leave a comment saying disk_num_bytes it's not used anywhere for
> merged extent maps.
>
> In the splitting case at btrfs_drop_extent_map_range() it's what we
> need since in the case the extent is new and not logged (in the
> modified list), disk_num_bytes always represents the size of the
> original, before split, extent.

[...]

>> +       file_extent.disk_bytenr =3D ins.objectid;
>> +       file_extent.disk_num_bytes =3D ins.offset;
>> +       file_extent.num_bytes =3D ins.offset;
>> +       file_extent.ram_bytes =3D ins.offset;
>> +       file_extent.offset =3D 0;
>> +       file_extent.compression =3D BTRFS_COMPRESS_NONE;
>
> Same as before:
>
> "If we always have to initialize all the members of the structure,
> it's pointless to have it initialized to zeros when we declared it."
>
[...]
>> +       file_extent.disk_bytenr =3D ins.objectid;
>> +       file_extent.disk_num_bytes =3D ins.offset;
>> +       file_extent.num_bytes =3D num_bytes;
>> +       file_extent.ram_bytes =3D ram_bytes;
>> +       file_extent.offset =3D encoded->unencoded_offset;
>> +       file_extent.compression =3D compression;
>
> Same as before:
>
> "If we always have to initialize all the members of the structure,
> it's pointless to have it initialized to zeros when we declared it."

Fair enough, and an uninitilized structure member can also make compiler
to warn us.

Thanks,
Qu
>
> The rest I suppose seems fine, but I have to look at the rest of the pat=
chset.
>
> Thanks.
>
>>          em =3D create_io_em(inode, start, num_bytes,
>>                            start - encoded->unencoded_offset, ins.objec=
tid,
>>                            ins.offset, ins.offset, ram_bytes, compressi=
on,
>> -                         BTRFS_ORDERED_COMPRESSED);
>> +                         &file_extent, BTRFS_ORDERED_COMPRESSED);
>>          if (IS_ERR(em)) {
>>                  ret =3D PTR_ERR(em);
>>                  goto out_free_reserved;
>> --
>> 2.45.0
>>
>>
>

