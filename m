Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D1A3C3BA5
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Jul 2021 12:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbhGKLBl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Jul 2021 07:01:41 -0400
Received: from mout.gmx.net ([212.227.15.18]:55285 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231183AbhGKLBk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Jul 2021 07:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626001132;
        bh=7dbZ1wsFlny+FDAutMF2W+DVmnNgvgNf857+WPqv4Y0=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=BigVxMKfv3Hg1cCHrYevsqN/H0bHjk0rsYJC2GxMZ3EKo//Prpng8USjw4xo5b6W+
         9bO932NYFGGu43YYMT5Jp7FlpUxqS77oxN8j8ii5Vwmntz+iJgmXRChE0VGJRvoUEu
         qvkQ0mQpTqWV7w54Y34hQr+avEg2uyVVIcenW/U0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M4JqV-1m2oHq3nxB-000MsX; Sun, 11
 Jul 2021 12:58:52 +0200
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210710144107.65224-1-realwakka@gmail.com>
 <8f248d54-ec4d-9a53-840f-6d162de14267@gmx.com>
 <1d679d44-c608-8d51-32d9-84c15d636e33@gmx.com>
 <20210711090247.GA66300@realwakka>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [RFC] btrfs-progs: cmds: Add subcommand that dumps file extents
Message-ID: <98e30ba5-9309-47d2-2ea7-37cfb2cddc3c@gmx.com>
Date:   Sun, 11 Jul 2021 18:58:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210711090247.GA66300@realwakka>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2TQE+fKQev1yuLpoI+vTCsU5g3/i1o4mjioO4zi21ILPmhieWPZ
 jEMJBtMKRE1CRFF+DmJ2nORh5+6RMNV8+263PR/He2mIWElMAj2QsXrobTDJXqLiTrresqK
 lroRw8taSWuPVI4XeHTkEDittP3n+bdsQgd4WbKcSRvgK0BdQZw1enlhayVCFeWSS0LqdR8
 cBNxL/Ab6r55R3hcI5TJw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ue7hy66PHpc=:MoEiphH4tC4re/0njj5yF3
 d0kuA8HExi9jsTsnfrOnic80LKkYx42FDZAANcMT4HAmYbqMkOdsvW9ewEv/kAkfHeDyx8B+9
 oQJccQKU2T5lWeRpdNV2OmQOneFuExrbsr/8TnY7N2QlmznnyNyevQyPs6JBWJaqnRgmAfVH+
 505gc/FJfxuDF3EvbObQtb0EFeYpkAPbbM2Eod3iXicV2sV4sRlai53iweZ19UQdDILLT6rq+
 kdSOcPhdWuDidHqQEiO7oVaLqW7NieT8D9iUSYPcWWqZW1q+mkBDAPMxnQba8NUCad1i5tc23
 LUizzJP1wyNtqZAayZJZOmfG25XVwgtyry5r7/wGekA9Z+LZgPt3mkO92UqIrRXqppTyqkJ/v
 ce9uNAGfHLS49KjdFzYTuNjMz6XsOoOS7Lf0E6qkNgCk33cDw+1peDcXc33wtx0xwUYopM0og
 ZSW/oVEweouc0WrCkiUPY/+HNE6xS2robJIFTp59Peo0I7JYQZRbGRwGWyChDuqHn8cLMYupv
 /UYaTTEcqfM/k3ZYiNSTF+2TwFgZ3VBgpbxLcUSqeql1tblAICXAv/Y4PFjhqc4DTa4ms8yzT
 9b47QIpk7saBtFgEa3DnNmk5WER7dJrMOCeRk1sha0XJwfiJc6oakL7K9WQ6NVQTBJ3NYVx8x
 ZrDPAc3jleAO2vZ0BFU1+EOmlIuM0COfrLvIVGkLmfoBSYsBjmleKZmqDHa+ZINQ+PVZegj7I
 u3UYtPgvITTFanRMhpS8TdVmi81tP+5eGxlvYWSl025Jqlq6mtpqWD1tW1eSNlVx6Wvhhjw7E
 xYUvrbKoFwyu0rZCwBOjtQWhU1xJ/cH/FPNpTRPUPgI6jN2l5qecNFV1FNNpTpPOXip0P+Afk
 StOeBKOpcS5pO+UmkZC0ArZNSg2xt+IIqDvMwmcNd+sVD4lGTrBbxyiCciEqO14EHI8C9J3si
 MPDmWgKwvwKEyn2USbg3JSDg6lWzThuFfGsha/ZVJV8KD1HQYzWrohPpIfhCl8KoxEBKXoGkX
 MZFJN3R+EGtlIZzIcTuOeGfi47Nel8VQRYelF//ho1avXw0SiBQEALjhnPEIPMtR47zTJTD1o
 DNtLpNczjFYMjVrn4doZenGzUu6tvMP1ucpI/6pPVG7in9YOTDSXlzmRA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/11 =E4=B8=8B=E5=8D=885:02, Sidong Yang wrote:
> On Sun, Jul 11, 2021 at 09:33:43AM +0800, Qu Wenruo wrote:
>
> Hi, I really thank you for review.
>>
>>
>> On 2021/7/11 =E4=B8=8A=E5=8D=886:38, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/7/10 =E4=B8=8B=E5=8D=8810:41, Sidong Yang wrote:
>>>> This patch adds an subcommand in inspect-internal. It dumps file
>>>> extents of
>>>> the file that user provided. It helps to show the internal informatio=
n
>>>> about file extents comprise the file.
>>>
>>> So this is going to be the combined command of filemap + btrfs-map-log=
ical.
>>>
>>> But how do you handle dirty pages which hasn't yet been flushed to dis=
k?
>
> I have no idea about this. Is there any references to get dirty pages
> information?

For dirty pages there is no way to know their file extent info.
Until we write them back.

This is delayed allocation utilized by all modern filesystem, and is one
of the core concept to improve filesystem performance.

If you want to dig into the idea deeper, I would recommend to see how
btrfs_buffered_write() works.
It just does space reservation and copy the data to page cache, then
call it all day.

The real writeback happen when extent_writepages() happens, which then
allocate real on-disk file extents and emit the IO.


For the dirty page writeback part, you can check the common
fiemap_prep() function in fs/ioctl.c.

If we have FIEMAP_FLAG_SYNC, then it will inform the filesystem to
writeback the inode before calling the fs specific fiemap code.

With that FIEMAP_FLAG_SYNC flag, then it's pretty much the same behavior
of your draft, it just cares what's already in the subvolume tree,
ignore the dirty pages completely.

And in btrfs, extent_fiemap() function in fs/btrfs/extent_io.c, is doing
the main work.

It's mostly the enhanced version of your draft, but convert the output
to fiemap ioctl format, with extra work like merging extents if possible.

It would be a pretty educational experience to read the code, as it's
not that complex.

[...]
>>
>>
>> OK, so you're doing on-disk file extent search.
>>
>> This is fine, but under most case fiemap ioctl would be enough, not to
>> mention fiemap can also handle pages not yet written to disk (by writin=
g
>> them back though).
>
> It would be better that this patch also can do it.

But since the fiemap ioctl currently can't report the real size of
compressed data, it can be sometimes pretty confusing to read the fiemap
result.

E.g.:

# mount /dev/test/test  -o compress /mnt/btrfs/
# xfs_io -f -c "pwrite 0 1M" /mnt/btrfs/file
# sync
# xfs_io  -f -c "fiemap -v" /mnt/btrfs/file
/mnt/btrfs/file:
  EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
    0: [0..255]:        26624..26879       256   0x8
    1: [256..511]:      26632..26887       256   0x8
    2: [512..767]:      26640..26895       256   0x8
    3: [768..1023]:     26648..26903       256   0x8
    4: [1024..1279]:    26656..26911       256   0x8
    5: [1280..1535]:    26664..26919       256   0x8
    6: [1536..1791]:    26672..26927       256   0x8
    7: [1792..2047]:    26680..26935       256   0x9

Note the 0x8 flag, which indicates FIEMAP_EXTENT_ENCODED, and in btrfs
it means it's compressed.
But it can't show any btrfs specific info, the compression algorithm,
nor the compressed size.

And the final one, has one extra bit 0x1, which means FIEMAP_FLAG_LAST,
means it's the last extent of the file.


But if you check the result more carefully, you will find that the
ranges are overlapping.
This is the limitation of current fiemap ioctl, it always assume every
extent has the same size on-disk, thus causing above overlapping layout.

That's what your draft can do better, but personally speaking, I would
prefer to enhance the fiemap ioctl other than creating a btrfs specific
interface.

>
>>
>> Although this manual search provides much better info for compressed
>> extent, but unfortunately here you didn't do any extra handling for the=
m.
>
> It also good to show compression information.
>
>>
>> Thus so far this is no better than fiemap to get the logical bytenr.
>>
>> And I can't be more wrong, by thinking you're also doing the chunk
>> lookup, which you didn't.
> Sorry, I'm confused. Is it needed to do the chunk lookup?

No, it's me getting confused by the "physical" words.

You don't need to do that at all.

>>
>> So I don't see any benefit compared to regular fiemap.
>>
>> In fact, fiemap can provide more info than your initial draft.
>> Fiemap can already show if the map is compressed (but can't show the
>> compressed size yet).
>>
>> Your draft can be improved to:
>>
>> - Show the compression algorithm
>>    Which fiemap can't
>>
>> - Show the compressed size
>>    Which fiemap can't either.
>>
> I understand that the point is that this command is nothing better than
> fiemap ioctl now. but It can be improved by showing more information
> that fiemap doesn't provide like compression algorithm.

Yes, but as mentioned, it would be better to enhance fiemap ioctl to do
more work.

It may be acceptable as a debug tool for a while, but a generic
interface would be the ultimate solution.

>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 case BTRFS_FILE_EXTENT_PREALLOC:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 len =3D le64_to_cpu(exten=
t_item->num_bytes);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 physical =3D le64_to_cpu(=
extent_item->disk_bytenr);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 physical_len =3D
>>>> le64_to_cpu(extent_item->disk_num_bytes);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset =3D le64_to_cpu(ex=
tent_item->offset);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("end =3D 0x%llx, p=
hysical =3D 0x%llx,
>>>> physical_len =3D 0x%llx\n",
>>
>> Currently we only use %llx for flags, for bytenr we always %llu.
>> You could refer to print-tree.c to see more examples.
> Thanks! I'll fix this.
>>
>> And I don't really like the word "physical" here.
>>
>> In fact the bytenr are all btrfs logical bytenr, which makes no direct
>> sense for its physical location on disk.
> Yeah, the word "physical" is not good. would It be better to write as
> "disk_bytenr"?

That would be really much better, then it completely follows the naming
in file extent item.

Thanks,
Qu

>
> Thanks,
> Sidong
>>
>> For real physical bytenr, we need something like (device id, physical
>> offset), and needs to do a chunk map lookup.
>>
>> Thanks,
>> Qu
>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 begin + len, physical, physical_len);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
uf_off +=3D sizeof(*header) +
>>>> btrfs_search_header_len(header);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
os +=3D len;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0 ret =3D 0;
>>>> +out:
>>>> +=C2=A0=C2=A0=C2=A0 close(fd);
>>>> +=C2=A0=C2=A0=C2=A0 return ret;
>>>> +}
>>>> +DEFINE_SIMPLE_COMMAND(inspect_dump_file_extents, "dump-file-extents"=
);
>>>> diff --git a/cmds/inspect.c b/cmds/inspect.c
>>>> index 2ef5f4b6..dfb0e27b 100644
>>>> --- a/cmds/inspect.c
>>>> +++ b/cmds/inspect.c
>>>> @@ -696,6 +696,7 @@ static const struct cmd_group inspect_cmd_group =
=3D {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &cmd_struct_i=
nspect_dump_tree,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &cmd_struct_i=
nspect_dump_super,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &cmd_struct_i=
nspect_tree_stats,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &cmd_struct_inspect_dump_=
file_extents,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>  =C2=A0 };
>>>>
