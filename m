Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753ED3FAB44
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Aug 2021 14:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbhH2MIl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Aug 2021 08:08:41 -0400
Received: from mout.gmx.net ([212.227.15.15]:49365 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235182AbhH2MIl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Aug 2021 08:08:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630238864;
        bh=WvzRbkijNixFrJ7d1skM8xur/v0WyIhF6/esI/HrmCA=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=JffPGSLiCtW7/YExNTCDr2/trZx4YUOexj9yvxVO3J6wObc4LYK8MoXfD+HUs4zcW
         3oN4XYwVgWNhVHrmJMjVepQBrS3X85NOIEVOC6z54LtnFgvriChWGwduncpoTOpMNV
         o9+otxKbuwq7+1NkQKbiMIrD/wNIq8Ldf8IIYvaY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MnJlW-1mlv7j31JU-00jEgq; Sun, 29
 Aug 2021 14:07:44 +0200
To:     Forza <forza@tnonline.net>, dsterba@suse.cz,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <afa2742.c084f5d6.17b6b08dffc@tnonline.net>
 <20210822054549.GC29026@hungrycats.org>
 <1097af0f-fb9e-3c68-24b9-2232748ed77c@tnonline.net>
 <20210822083356.GE29026@hungrycats.org>
 <ca2452a6-3f5d-76df-e91b-dff2dcb53052@tnonline.net>
 <20210823202329.GG29026@hungrycats.org> <20210827100855.GV3379@twin.jikos.cz>
 <3d3b0bc0-4804-2c40-a343-d6e52bbfa642@tnonline.net>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Support for compressed inline extents
Message-ID: <8b17d198-4ae6-7e08-e015-3a2165331f1e@gmx.com>
Date:   Sun, 29 Aug 2021 20:07:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <3d3b0bc0-4804-2c40-a343-d6e52bbfa642@tnonline.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l96h5Dw0mqwPhlt1UTlToSYrpYAfGLlEqLR4wFuw6EsEvzrJ32b
 V3RVaJcGswnKqutPHSZmOT/jPuKCWq1wFrpdC2oDlQ8ylvJmVJKrJ6eGP65F/FtGYBnvksu
 UtDZe6uuPTKCEf9zUDsm+4bUCHAS3cKgL0jtjWBkV4EssvETr1WG6FIjnDSsBDSSrVRiUkT
 bEpJrpYiELGD0XE2YCWQg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RfUTgsmTqxI=:RtM3z0rGroK+AY2CNhqMP7
 7pBXhflnpfxHjBwKj7QsTQd9tRAnQyJOeRjSNuiQfWWCAAR4B9DNVtpuIevT0K7PTioFVusaJ
 kLDQz2FEcAW5BnfdZh9OipNE5GyFm+P5m4xhibTPH9tdIOwEbCixXwpKcoSzOL7t5c1xi8viM
 vJxyKlSwgdGOCaDargMTrV7PpopzuLeU1xX/U7vbYezVLLuRzDdXJbSTrAVKAMIKgv71Mr6ds
 RZAEMaOG+0654wBCaMujaEcQNxc+JQOwfNgzYMfkoISpyji3kmwn6MJYV7dyRm9Hkl0Dnwvgy
 rWuZtIcU4/hqNnCvVUpU4s97MHz6kwe2aibupLAtWGrxPX/9jYeHOZj9W+mWIckS0LUVzMb3T
 tspf9rUe3rBsMuqpERWR7t/GgQpK18jKcg0syocIg1IFxAzTc+Qm7khONfRVVIo8CHgMNnvpG
 BWYGb1hW030LoDLCvQQDbl0VCWf4Q9DHwBMtfKnpQ5aJzvMA7Um4CICw0/hxkkMPUTvXNuMt9
 xWE9ovo1cUY2LKh3GM5jblTctbT4TAC4SPikiNaTRspDQk9FCXtPxljNrH92xS1XvYWdAG5NA
 fXs1I7EKwUyJo9B7YpD6RjZ4hmBML9SokK0B5LjPbIkkJ4zmDRlab97r/Y7G5IBuZ/eqJgs+t
 yqyIRU8fZN1zZ3WB9XIyvjxMeC5bq9xwJpeKJTYgvzO/g4Ome/IvAjCGe/jkXw7Ec1xgsL5eq
 JNONugezf9lpw+R/gkBjheCej4NWNhgdF+vDAivatlRKfwIjX8Ebd4FvMg1YWmr2SrN54pvRN
 yWt338ZpHMreU/LbXQd9RZFlj0fqhGRD8BDX+D+zqbXEs/FNqynnsicv//a6qIKogsKanlZID
 MZvdFclRYH2FQ5Vsf3pSfqj34djgNwASs3vsVTgGHNNl+O52Rqt/QXkNHbGA257RQ3tYE2wbK
 BUh4UJVsdTVWY8dtsSuHz6+J9eEttfrdAm/iGLgRMExANjCoIhBwzQOmSflbprcmNV5MnFIYf
 unXhIfE3ZU7eN9L13GoCjSHPwtZM2VIy32/daE+SC/S5xogvV56hg6hNDtFWGuwianlWR6xs/
 6dJShKogfbpb1zzcNS7NQ3WRlshL6UXoarUHzxJPfANzlQtBToKvrFD2g==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/29 =E4=B8=8B=E5=8D=887:22, Forza wrote:
>
>
> On 2021-08-27 12:08, David Sterba wrote:
>> On Mon, Aug 23, 2021 at 04:23:29PM -0400, Zygo Blaxell wrote:
>>> On Mon, Aug 23, 2021 at 09:34:27PM +0200, Forza wrote:
>>>> Further up you showed that we can read encoded inlined data. What is
>>>> missing
>>>> for that we can read encoded inlined data that decode to >page_size
>>>> in size?
>>>
>>> In uncompress_inline():
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0// decoded length of extent on disk...
>>> =C2=A0=C2=A0=C2=A0=C2=A0max_size =3D btrfs_file_extent_ram_bytes(leaf,=
 item);
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0...
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0// ...can never be more than one page because =
of this line(*)
>>> =C2=A0=C2=A0=C2=A0=C2=A0max_size =3D min_t(unsigned long, PAGE_SIZE, m=
ax_size);
>>>
>>> There might be further constraints around this code (e.g. the caller
>>> only fills in structures for one page, or doesn't bother to call this
>>> function at all for offsets above PAGE_SIZE).
>>>
>>> All the restrictions would need to be removed in the kernel and suppor=
t
>>> for reading multi-page inline extents added where necessary.=C2=A0 The=
re
>>> would
>>> have to be an incompat bit on the filesystem to prevent old kernels fr=
om
>>> trying (and failing) to read longer inline extents.=C2=A0 The disk for=
mat is
>>> already technically capable of specifying a longer inline extent (up t=
o
>>> min(UINT32_MAX, metadata_page_size)) but that was never the problem.
>>
>> Regarding the idea of compressed inline extents, I'm not much in favor
>> of increasing the limit beyond one page (or sector). The metadata space
>> is more precious and that's also the motivation behind low default
>> max_inline. Another thing is mixing data and metadata with potentially
>> different block group profiles.
>
> We already mix profiles today with inlining small extents. It is not a
> problem as most people use a better/higher redundancy for metadata than
> for data.
>
>> The inline files is IMO a nice little optimization and helps when the
>> size is below certain limit to avoid wasting data blocks and the
>> indirection.
>>
>
> To be fair, I think the benefit is that we inline instead of creating
> 4KiB extents for small amounts of data. This benefit would be true even
> if that data was compressed data and the compressed size was <2KiB.
>
> I do understand the earlier points that this would perhaps be a big
> thing to change, also incompatible with earlier kernels. Given that work
> the benefit is rather small.
>
> Perhaps if we are doing incompatible changes in the future, this could
> be considered at that time? One reference is what Qu wrote here about
> taking in more factors to consider for inlining?
> https://lore.kernel.org/linux-btrfs/d0dccd5e-c67f-a18d-8d6e-559504b5ee91=
@suse.com/


There are way more things to consider for inlining extent larger than
one sector.

- Reading the inline extent
   Now we must consider multiple pages other than just simply copying the
   data to the page.
   This also brings extra error paths which must be considered.

- Writing the extra pages of the inline extent
   Unlike current single sector inline, what if you overwrite the 2nd
   page of the inline extent?

   In theory, we should make the whole inline extents into one regular
   extent, then this means we have to read the whole inline extent out,
   re-marking them dirty.

   We don't have the exact facility to do that.
   The most similar one is defrag, but now we need to do that in write
   path too.

   Or you can treat them as regular extents, just cow the 2nd page?
   Then it completely wastes the extra space in metadata.

   Either way, it's way complex than you thought, and all my respect to
   all those guys solving the corner cases with compression and inline.


So my idea towards inline and compression is pretty simple, they are
good optimization, but not critical part.

Thus if they are affecting regular core functions to be more complex
than they should, then no.

And extending inline extent size beyond page size is exactly bringing
extra cost to the developers, with little and uncertain benefit.

Thanks,
Qu


>
>
> Thanks
