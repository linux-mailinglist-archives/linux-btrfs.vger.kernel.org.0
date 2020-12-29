Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F732E70CB
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Dec 2020 14:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgL2NIH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Dec 2020 08:08:07 -0500
Received: from mout.gmx.net ([212.227.15.18]:46873 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbgL2NIG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Dec 2020 08:08:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609247192;
        bh=XHbpiYkZC/Le2T2LeXx7Od72giuY+bokVGd7pSdQ08w=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Jp9UHCSrRv1ZrHMbExuLhoSVzG7VOy/cvCsEXcoVDhHdd0GNS0v39B1feesyvKYDu
         XNycy7Y0u66PWN0nw5/Cs8C5v0D85aoak9eYqaaws4EJmDpN7E2yb4mLVVhWoUPASg
         c6JBiC11JC4lE2a+81ZH+psj5DwQ6rT2TTfCRNEQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MGyxN-1kozmW0o5r-00E29Z; Tue, 29
 Dec 2020 14:06:31 +0100
Subject: Re: [PATCH] btrfs: relocation: output warning message for leftover v1
 space cache before aborting current data balance
To:     =?UTF-8?Q?St=c3=a9phane_Lesimple?= <stephane_btrfs2@lesimple.fr>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <43269375-cefd-8059-5335-ed891fdd26fe@suse.com>
 <82e6288d-7b37-5797-13d9-f786afb33f5d@gmx.com>
 <90cf0737-6d33-94d8-9607-0f9c371c82aa@gmx.com>
 <20201229003837.16074-1-wqu@suse.com>
 <6b4afae37ba5979f25bddabd876a7dc5@lesimple.fr>
 <4f838a67672053e268ffce77ea800a8a@lesimple.fr>
 <e811efd8b2936a559d665e7303ce0873@lesimple.fr>
 <9c981dde8dafe773e2a99417e4935f6b@lesimple.fr>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <02f6b3d7-c502-fe29-ec74-cce99922296c@gmx.com>
Date:   Tue, 29 Dec 2020 21:06:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <9c981dde8dafe773e2a99417e4935f6b@lesimple.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6lvxSP/Ur+nzyqBkWVh9Iye1cyBBjjli8gRGY1TnwrGXoJJodUk
 CLQChQmzVAqvepIvWrYN9Vggut05hv1cyrz0gDiQrZzteotBFhUB0hAlu8GRJuZMK7G7vA/
 LFvI6lIaR2v5i7Heo1bZQmBpveC5carNLR8VeP4mnJGfPC9pXQgoHtNbbgz7+ROq6WxQOzF
 1ZVvUhcwDNQm//RtZfyBw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6wXkS1Q+M6s=:y1QpFaK2/9bQU6ekIoB9p5
 wersSdUiy0GHqWAS/8ftp3u8GVuERKN/PTSzzWvB0IypbHN7c/GrCNgTM13fmHJBvzXO5LmE8
 jylR3Jrn8PPQCD+94UfWuY8EZAeIXsUSCGjkC1iD7h/SSFl+UQIdLh7tk60RoRrQK5s10J8Pp
 f26V635ij6fSwIYamor9FMEBiqG9Qy+p5dTuOtQdBp2L50JsOI5W+LCGX7J7x/kGTdHBqjslI
 dW3N99MFnolFqkOPNVNehVrosjvxCDJlGa/Ue48KJ9mcIcTTWV1TXlZu465PqVMMDpmKLgkE/
 +SpRVso1LtLHA9p7MJKqmAHkOqFtvUvt6DtRHOxw26xRVOdm5mSkMO06QB+GXtWH8q5mgZNyN
 k9nY/i74jlTR+mY6TEBS6ViN91+0ediepoqr90cvVIawzJYt4e2jNSoI/ZAfSCeX4+LWHXlWH
 UAhACYC4DrEE2LECq/fHgTvyzlKPSI+OhAj44MlNbFAPTeqqBre1LfKVJ1yuDcvwLLjADoLZF
 Kp/DJwL+AFqhTxyY13CmJg+CH13D4vy86a2HNM6a5c7tTr3WnL4DUcmPqm0omiBxlYV1iDLAB
 xl1vgAetZbKvPXTTuGNzas4wr/hz7zsOpM8eUZGIuPmk14FCZkwdYuiWCIbZv0YkFsZUWY0yb
 Vo2hqOW7YVSJEk8tHp73aRA8kLmrn1cchtfhDe8LiBlo4c3HRJWWYrNcY29jLguS2NrmmaMga
 le0dBah9FCMx7atHKlDqX8TPqFU7RgLGEJJhDqx9Oe2nQCbWLroyuznLSgZ+6fDgMEqqMFqr9
 0wST+e5YxbJUhhSWyddY/JlRRzMIefyDcAYfZGAktptDvSp0QKhL5elcdMyH5PCth3uuQdAWR
 7vg2+SlQRCf47VbIzUwg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/12/29 =E4=B8=8B=E5=8D=888:51, St=C3=A9phane Lesimple wrote:
> December 29, 2020 1:43 PM, "Qu Wenruo" <wqu@suse.com> wrote:
>
>> On 2020/12/29 =E4=B8=8B=E5=8D=888:30, St=C3=A9phane Lesimple wrote:
>>
>>> December 29, 2020 12:32 PM, "Qu Wenruo" <quwenruo.btrfs@gmx.com> wrote=
:
>>>
>>>> On 2020/12/29 =E4=B8=8B=E5=8D=887:08, St=C3=A9phane Lesimple wrote:
>>>
>>> December 29, 2020 11:31 AM, "Qu Wenruo" <quwenruo.btrfs@gmx.com> wrote=
:
>>>
>>> # btrfs ins dump-tree -t root /dev/mapper/luks-tank-mdata | grep EXTEN=
T_DA
>>> item 27 key (51933 EXTENT_DATA 0) itemoff 9854 itemsize 53
>>> item 12 key (72271 EXTENT_DATA 0) itemoff 14310 itemsize 53
>>> item 25 key (74907 EXTENT_DATA 0) itemoff 12230 itemsize 53
>>> Mind to dump all those related inodes?
>>>
>>> E.g:
>>>
>>> $ btrfs ins dump-tree -t root <dev> | gerp 51933 -C 10
>>>
>>> Sure. I added -w to avoid grepping big numbers just containing the dig=
its 51933:
>>>
>>> # btrfs ins dump-tree -t root /dev/mapper/luks-tank-mdata | grep 51933=
 -C 10 -w
>>> generation 2614632 root_dirid 256 bytenr 42705449811968 level 2 refs 1
>>> lastsnap 2614456 byte_limit 0 bytes_used 101154816 flags 0x1(RDONLY)
>>> uuid 1100ff6c-45fa-824d-ad93-869c94a87c7b
>>> parent_uuid 8bb8a884-ea4f-d743-8b0c-b6fdecbc397c
>>> ctransid 1337630 otransid 1249372 stransid 0 rtransid 0
>>> ctime 1554266422.693480985 (2019-04-03 06:40:22)
>>> otime 1547877605.465117667 (2019-01-19 07:00:05)
>>> drop key (0 UNKNOWN.0 0) level 0
>>> item 25 key (51098 ROOT_BACKREF 5) itemoff 10067 itemsize 42
>>> root backref key dirid 534 sequence 22219 name 20190119_070006_hourly.=
7
>>> item 26 key (51933 INODE_ITEM 0) itemoff 9907 itemsize 160
>>> generation 0 transid 1517381 size 262144 nbytes 30553407488
>>> block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
>>> sequence 116552 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
>>> atime 0.0 (1970-01-01 01:00:00)
>>> ctime 1567904822.739884119 (2019-09-08 03:07:02)
>>> mtime 0.0 (1970-01-01 01:00:00)
>>> otime 0.0 (1970-01-01 01:00:00)
>>> item 27 key (51933 EXTENT_DATA 0) itemoff 9854 itemsize 53
>>> generation 1517381 type 2 (prealloc)
>>> prealloc data disk byte 34626327621632 nr 262144
>>
>> Got the point now.
>>
>> The type is preallocated, which means we haven't yet written space cach=
e
>> into it.
>>
>> But the code only checks the regular file extent (written, not
>> preallocated).
>>
>> So the proper fix would looks like this:
>>
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index 19b7db8b2117..1d73d7c2fbd7 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -2975,11 +2975,14 @@ static int delete_v1_space_cache(struct
>> extent_buffer *leaf,
>> return 0;
>>
>> for (i =3D 0; i < btrfs_header_nritems(leaf); i++) {
>> + u8 type;
>> btrfs_item_key_to_cpu(leaf, &key, i);
>> if (key.type !=3D BTRFS_EXTENT_DATA_KEY)
>> continue;
>> ei =3D btrfs_item_ptr(leaf, i, struct
>> btrfs_file_extent_item);
>> - if (btrfs_file_extent_type(leaf, ei) =3D=3D
>> BTRFS_FILE_EXTENT_REG &&
>> + type =3D btrfs_file_extent_type(leaf, ei);
>> + if ((type =3D=3D BTRFS_FILE_EXTENT_REG ||
>> + type =3D=3D BTRFS_FILE_EXTENT_PREALLOC) &&
>> btrfs_file_extent_disk_bytenr(leaf, ei) =3D=3D
>> data_bytenr) {
>> found =3D true;
>> space_cache_ino =3D key.objectid;
>>
>> With this, the relocation should finish without problem.
>
> Aaah, it makes sense indeed.
>
> Do you want me to try this fix right now, or do you want to have a look
> at the btrfs-progs crash first? I don't know if it's related, but if it =
is,
> then maybe I won't be able to reproduce it again after finishing the bal=
ance.

The problem is, I'm not that confident with v2 space cache debugging,
thus can't help much.

But at least, the problem you're reporting doesn't really need a
btrfs-check repair.
Just a kernel fix would be enough.

>
> I don't mind leaving the FS in this state for a few more days/weeks if n=
eeded.

That's fine if you want some one to look into the btrfs-progs bug.

I'll submit a proper bug fix soon.

Thanks,
Qu
>
>> Thanks for all your effort, from reporting to most of the debug, this
>> really helps a lot!
>
> No problem, glad to help. Thanks for looking into it so fast!
>
