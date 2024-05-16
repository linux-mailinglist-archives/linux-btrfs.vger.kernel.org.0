Return-Path: <linux-btrfs+bounces-5057-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5E38C7E97
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2024 00:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AD8BB21DC9
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 22:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3A927269;
	Thu, 16 May 2024 22:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ql721YI4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374C123748
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 22:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715899551; cv=none; b=LOrl7WLGk83rJfV/qukpOjOaE69PeVss41zi4x7scB3VYj9F7mDDgh/Spz2Zk5ryhcYSVsQsgxhbfGUdKRMihlle7yDYSnIiRZHEZyphH1UOBPgm6zEwPGCdb4btPTkMQMQO47g/5G2vng3Kwf2HIx6+geo1ik/G5jbTxZkt4Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715899551; c=relaxed/simple;
	bh=qE947wzCOYwoM8uDVet0/TdCoFSIRisL8PVoHSCl2GE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E9XGtjg75PAJV31QgI9zIkOtBjvp8lMZOCXy+BBki7jrxwu6WMWfR2U7oDjO99xqbkrOgFuIjvueLe7cExuSKfHXJWU2GzgJ/4jG8/cXtoFBHyuk+5CYypJKsrD2IuCfrL6BmTCcVzHNbcmLz5JcE88xZDZQ9N072UYKtQdZP78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ql721YI4; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715899541; x=1716504341; i=quwenruo.btrfs@gmx.com;
	bh=Ww81Y2zex/oyNMux4/vyTIQZp8ePBzr5ZyQ6/FgK6DA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ql721YI4m5DakEkLtDsbOII467mZ0OldGJJ7mzARkaEmtiUR1KZNWf49QrYTKaZo
	 a5Ad7hDFCJEMPkctKtP5usBNmcA6oJ9LUA4xKjU+rccP6HrX7svj6q3pdMFXupzw0
	 hbkI2a4aMfOrjlKFZVD52iEGS+VoQs6qwHWtza7gs3DQWnb3/VdeJEmcV40KGpimt
	 M2sJaRxQZUn+rBv4WvBrByHr4bc+NdtZC0sW97vikNlIy6XIAMX9nmUb+5AlCqK8/
	 YenYLQJwde88lVIKA2hjXxjAHoWKTH50YXkZMu6ZYyI/oFBqW8iIPW/GmfRdQITS7
	 CNV+b6FW4hltDMbaAQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mg6Zw-1slkpn0VPK-00eM78; Fri, 17
 May 2024 00:45:41 +0200
Message-ID: <bcec9364-4de6-4286-9d9b-a3c3731211c5@gmx.com>
Date: Fri, 17 May 2024 08:15:36 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/11] btrfs: remove extent_map::block_start member
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <cover.1714707707.git.wqu@suse.com>
 <9333b82dcbe22bd78687f702485d308daaedc7a9.1714707707.git.wqu@suse.com>
 <CAL3q7H7bT71DicGMZZ7aHu9xcthHG4SiCAn3cC_-5rjrdiodBw@mail.gmail.com>
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
In-Reply-To: <CAL3q7H7bT71DicGMZZ7aHu9xcthHG4SiCAn3cC_-5rjrdiodBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kh6zKq/nYCRxbG2yEqNC0cvuako6/5/wSpfsSbc3hMiMUkz6RjL
 TQZ6rOgysXWNbVjpsQ4sspOUz7KujYGrJSikfT4JtMjvgf6j2P1eOn0xyq9FCaE1Gq4IzTF
 SR+DQaMEd/avCFk0BEwrGvuGgsz3NZFvFIRC5XDpmJcgOxwYfvYXJIMVjX/EzC1FAZpe+a1
 CCJTrNOCVh6lB8x5rr0zg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0/IJD6unvds=;2B7s3cY+LkInWV6+C0pMnCrVarA
 mWjtoxKShL8a9d8vKc8ojSzPTc/6tDIZe3KIJuMFYLxgIcGHePPvSNVDk0MD4OIMpk/JR9G4t
 qY9OXfgGh6dCEzWrWeBeRgBkJJbwxaIlJxVkWwxGp4KgEQJqLGsYWj58nwKnXaPMBkV06CwAI
 yU6AHsSGejj1XPXzmeTp1JWW5Jb/1CeK6FefoOaFEJTawXLlGqiAyazTZdPBEHzPAx7P1ZwK/
 B2yeK6D4Qh+5vgNeL/wRdFpIIFTvF+e691mX2tEjvjVuqNIp+uelQ6x6biT7c8XDQCzA6djv9
 eG7Gr5lXU4HcDIUwrOnQr/DGozjferFIvDwXDNkmS+stKMitgzH+MN3zxB+uOCcX8CxiTSJqZ
 XCvxDGofs71TXljRw6MvDcdh6h/+HDE5fUOdUsOcs7MyLEiCXYmspE/eSUhuWkcSYWJtMMH2N
 E8uwCtqOm8UJkfqs5rKsMIqsC6SQw/ZrL9hE7r0zVNBA/CzQ1UqECMj/QYjjXmvWkM+Jw4HzD
 mrAm3OBjxQzs7PuHT30wk89Q3rGR/KHxIMkVcJM0bZbhUs7ynC33Vjyzlv4uflf8MPu9wyiTf
 ABG4eY9HDr+H3KnFX334mCytnqFs8/qFMMMfmZXnIfn4k6Yd1nGgnoLvbW4vaPUYWzaFlOj6i
 f1W5liQ9baiUytvy/FuZtpaXjRXsDFf+lMSIu8MbI4dG4KZndyy39t3u44d0xhnHMiMicpra0
 oIeFlkvFU1QpKLHHeozHEhAd0ZMOcQi5oBi6xoItalQP8kHP+rPmxn3s9MgTZAKhy2SoiGbDH
 quxtmVXWdLYFXF2z2+bvDamOQ0IE0SR+4zbx3rMmPkkGY=



=E5=9C=A8 2024/5/17 02:58, Filipe Manana =E5=86=99=E9=81=93:
> On Fri, May 3, 2024 at 7:02=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>> The member extent_map::block_start can be calculated from
>> extent_map::disk_bytenr + extent_map::offset for regular extents.
>> And otherwise just extent_map::disk_bytenr.
>>
>> And this is already validated by the validate_extent_map().
>> Now we can remove the member.
>>
>> However there is a special case in btrfs_alloc_ordered_extent(), where
>> we intentionally pass a pseudo ordered extent, exploiting the fact that
>> for NOCOW/PREALLOC writes we do not rely on ordered extent members to
>> update the file extent items.
>>
>> And that's the only way to pass btrfs_extract_ordered_extent(), as it
>> doesn't accept any ordered extent with an offset.
>>
>> For now we will keep the old pseudo ordered extent members, and leave
>> the cleanup of it for the future.
>
> These last 3 paragraphs, the rant about NOCOW writes and ordered
> extents, seem unnecessary to me.
>
> This is just how things work, and for me it makes total sense that an
> ordered extent for a NOCOW write does not represent the entirety of an
> existing file extent item.
> NOCOW writes don't create new file extent items, so they can refer
> only to a section of an existing extent (or the whole extent).

To me, NOCOW/PREALLOC is really the exception, not following all the
existing definition for all the OE/extent map definitions, even it's
only for transient NOCOW/PREALLOC OE.

And I really hope to remove the exception in the near future, even it
may mean some more complex OE spliting etc.

>
> I don't see how this rant is relevant to have here, as the patchset is
> about extent maps and not ordered extents.
> I would leave it out, as it's a separate thing and doesn't affect anythi=
ng here.

Sure, I can leave it out for now.

>
> More comments inlined below.
>
>>
[...]
>>
>>          if (type !=3D BTRFS_ORDERED_NOCOW) {
>> -               em =3D create_io_em(inode, start, len, block_start,
>> +               em =3D create_io_em(inode, start, len,
>>                                    orig_block_len, ram_bytes,
>>                                    BTRFS_COMPRESS_NONE, /* compress_typ=
e */
>>                                    file_extent, type);
>>                  if (IS_ERR(em))
>>                          goto out;
>>          }
>> +
>> +       /*
>> +        * NOTE: I know the numbers are totally wrong for NOCOW/PREALLO=
C,
>> +        * but it doesn't cause problem at least for now.
>
> They are not wrong, they are what they must be.
>
> This is all about passing the right values to
> btrfs_alloc_ordered_extent(), which has nothing to do with extent
> maps.

I think it's pretty obvious that, only for NOCOW/PREALLOC that OE
members differs from their corresponding extent map.

Sure, it is not causing anything wrong (in fact, anything other than the
current behavior is going to cause a lot of problems).

But just for the sake of consistency, even it doesn't affect any on-disk
change, I still want to modify the call sites so that we can directly
pass the btrfs_file_extent item to OE allocation.
Even if it means other modification mostly inside OE splitting part.

For now I can remove/modify the comments, but I do not think this is
consistent.

>
>> +        *
>> +        * For regular writes, we would have file_extent->offset as 0,
>> +        * thus we really only need disk_bytenr, every other length
>> +        * (disk_num_bytes/ram_bytes) would match @len and fe->num_byte=
s.
>> +        * The current numbers are totally fine.
>> +        *
>> +        * For NOCOW, we don't really care about the numbers except @fi=
le_pos
>
> I don't see any variable named @file_pos anywhere in this function.
>
>> +        * and @num_bytes, as we won't insert a file extent item at all=
.
>
> There's no @num_bytes either, there's a @len however.
>
>> +        *
>> +        * For PREALLOC, we do not use ordered extent's member, but
>
> ordered extent's member -> ordered extent members
>
>> +        * btrfs_mark_extent_written() would handle everything.
>
> would handle -> handles
>
>> +        *
>> +        * So here we intentionally go with pseudo numbers for the NOCO=
W/PREALLOC
>> +        * OEs, or btrfs_extract_ordered_extent() would need a complete=
ly new
>> +        * routine to handle NOCOW/PREALLOC splits, meanwhile result no=
thing
>> +        * different.
>> +        */
>
> I would just leave the entire comment out.
>
>>          ordered =3D btrfs_alloc_ordered_extent(inode, start, len, len,
>> -                                            block_start, len, 0,
[...]
>> @@ -1778,7 +1778,9 @@ static void btrfs_rewrite_logical_zoned(struct bt=
rfs_ordered_extent *ordered,
>>          write_lock(&em_tree->lock);
>>          em =3D search_extent_mapping(em_tree, ordered->file_offset,
>>                                     ordered->num_bytes);
>> -       em->block_start =3D logical;
>> +       /* The em should be a new COW extent, thus it should not has of=
fset. */
>
> not has offset -> not have an offset
>
> Otherwise it seems fine, but I still want to go over the rest of the pat=
chset.
> I'm going slowly over it, and after commenting on each inidividual
> patch, I'll comment on the cover letter.

Really appreciate the review so far.
And considering the patchset is not urgent, just take your time so that
I can also address the comments at the same time.

Thanks,
Qu
>
> Thanks.
>
>> +       ASSERT(em->offset =3D=3D 0);
>> +       em->disk_bytenr =3D logical;
>>          free_extent_map(em);
>>          write_unlock(&em_tree->lock);
>>   }
>> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.=
h
>> index 3743719d13f2..89b2b66e5bc0 100644
>> --- a/include/trace/events/btrfs.h
>> +++ b/include/trace/events/btrfs.h
>> @@ -291,7 +291,6 @@ TRACE_EVENT_CONDITION(btrfs_get_extent,
>>                  __field(        u64,  ino               )
>>                  __field(        u64,  start             )
>>                  __field(        u64,  len               )
>> -               __field(        u64,  block_start       )
>>                  __field(        u32,  flags             )
>>                  __field(        int,  refs              )
>>          ),
>> @@ -301,18 +300,16 @@ TRACE_EVENT_CONDITION(btrfs_get_extent,
>>                  __entry->ino            =3D btrfs_ino(inode);
>>                  __entry->start          =3D map->start;
>>                  __entry->len            =3D map->len;
>> -               __entry->block_start    =3D map->block_start;
>>                  __entry->flags          =3D map->flags;
>>                  __entry->refs           =3D refcount_read(&map->refs);
>>          ),
>>
>>          TP_printk_btrfs("root=3D%llu(%s) ino=3D%llu start=3D%llu len=
=3D%llu "
>> -                 "block_start=3D%llu(%s) flags=3D%s refs=3D%u",
>> +                 "flags=3D%s refs=3D%u",
>>                    show_root_type(__entry->root_objectid),
>>                    __entry->ino,
>>                    __entry->start,
>>                    __entry->len,
>> -                 show_map_type(__entry->block_start),
>>                    show_map_flags(__entry->flags),
>>                    __entry->refs)
>>   );
>> @@ -2608,7 +2605,6 @@ TRACE_EVENT(btrfs_extent_map_shrinker_remove_em,
>>                  __field(        u64,    root_id         )
>>                  __field(        u64,    start           )
>>                  __field(        u64,    len             )
>> -               __field(        u64,    block_start     )
>>                  __field(        u32,    flags           )
>>          ),
>>
>> @@ -2617,15 +2613,12 @@ TRACE_EVENT(btrfs_extent_map_shrinker_remove_em=
,
>>                  __entry->root_id        =3D inode->root->root_key.obje=
ctid;
>>                  __entry->start          =3D em->start;
>>                  __entry->len            =3D em->len;
>> -               __entry->block_start    =3D em->block_start;
>>                  __entry->flags          =3D em->flags;
>>          ),
>>
>> -       TP_printk_btrfs(
>> -"ino=3D%llu root=3D%llu(%s) start=3D%llu len=3D%llu block_start=3D%llu=
(%s) flags=3D%s",
>> +       TP_printk_btrfs("ino=3D%llu root=3D%llu(%s) start=3D%llu len=3D=
%llu flags=3D%s",
>>                          __entry->ino, show_root_type(__entry->root_id)=
,
>>                          __entry->start, __entry->len,
>> -                       show_map_type(__entry->block_start),
>>                          show_map_flags(__entry->flags))
>>   );
>>
>> --
>> 2.45.0
>>
>>
>

