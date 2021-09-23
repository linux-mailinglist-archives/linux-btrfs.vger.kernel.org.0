Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12700415CA5
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 13:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240558AbhIWLR7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Sep 2021 07:17:59 -0400
Received: from mout.gmx.net ([212.227.17.21]:59129 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240565AbhIWLR7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Sep 2021 07:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632395784;
        bh=xUXj08NCjwzYxKzHJludgbK5Im2f6w7oEsw5Udj8vI8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Ty/TRlpMf8lVGJatstjqJQ0un6A+XqT4ZveQpDAenoW+1za6r2NC1PqUhooGTkpSR
         UyBnXIxFgpORiFfN6eUbGz+jkOm9XvgY43N7aPWHgxR2T/4WyJ4LuUyRqwZiICvTds
         NS4ZvV6GuzfttmS0qZU3ro0G+GR4ZqZLtlBQEcnA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8obG-1mxfU11JVm-015pnM; Thu, 23
 Sep 2021 13:16:23 +0200
Message-ID: <8a781d5e-bdee-b44c-f237-292804b822ab@gmx.com>
Date:   Thu, 23 Sep 2021 19:16:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: btrfs receive fails with "failed to clone extents"
Content-Language: en-US
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     Yuxuan Shui <yshuiv7@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAGqt0zz9YrxXPCCGVFjcMoVk5T4MekPBNMaPapxZimcFmsb4Ww@mail.gmail.com>
 <e45e799c-b41a-d8c7-e8d8-598d81602369@gmx.com>
 <CAGqt0zyEx1pyStPVTSnvsZGYKAGEv9yUunv-82Mj6ZED3WNKRA@mail.gmail.com>
 <CAGqt0zy6a8+awo6ifUn4x+WxN=c6e8PnuMW5kYRodxOQ6vwU-A@mail.gmail.com>
 <72d66f13-6380-7fcd-3475-8152caa965c4@gmx.com>
 <CAGqt0zz+=nUYbNwLSPYwzYcNLgyxsWT22p+jwwFpAOcyAHAWgA@mail.gmail.com>
 <e83029f0-8583-91b9-47c8-a99d4b00a6ae@gmx.com>
 <CAGqt0zykaioT1LJAtOM8Zc4eJBXxTEy2ugBrLpgZ=BzCJzixXQ@mail.gmail.com>
 <CAGqt0zwchNdLKz4_qHrdbuxx7RWY9YbdiZ4KBYJcrwWa3sxBZw@mail.gmail.com>
 <529263b6-4ff9-1bf6-8566-ed1ec648a539@suse.com>
 <CAGqt0zxrm=A8v7Mm6CDNUv77Sxsgt_kp4uJpCbpbCGXrnUmBqA@mail.gmail.com>
 <8af945a3-db88-d1b8-bba3-3f6180f91fcf@suse.com>
 <CAL3q7H7Ty-0HOy5xQU_JMuzYZoNbihL9-gdk+vwk64+GowEmCQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAL3q7H7Ty-0HOy5xQU_JMuzYZoNbihL9-gdk+vwk64+GowEmCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ab5gE9ID4BgRYlm1+VAHc2Y/YNpLBoVX0LT9aXAv1psjamwFeEi
 nKbamrKeppcMn7LFSgqsXLsrZN0Rtf8l78V41A2BPKopk1FPxzZOMkA7yK5CytFRtq5xXkg
 4lIBnGIHpnp3s25hVEXGlJJJoGiYh5Dut3FySin0ubQT/M1u3cFOP5mlOWwuMUItmBADOKq
 LHPyq9oBw+aUu+uMDPkqA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:90n4bs009fk=:bOJPY5tWRervC7GQZukNa8
 IzNZpHZI6MMDlHaNYCDyeB7hGn9gTIn2Qfc6tULpyZTFnM4avhwelwQnU3imaO2DmeVYaSIn5
 xgTkyx00NdnUT8nA87iIh/HS0ffDNhONp8dRFCROideAWcTOxMg2DvWQFGl843AKy8QgiTPrF
 Z2ca9D3drJaOh3elOb31Ef5HZfF8weduFd1Qg3B10POVo016O/Rhv2TCqAbwFBfKroVCRY40v
 HlX1f2rim+RdNCuQzMLwbQJOVFQa1NXHjkRE6LQUc3Id/4FXAfogdo/QiMMDEVFA89C3+iwR5
 bSS97fwkrUPUeysJzjh+KhpkO2Z8vgEDa6rWeAMh2ef1l1Z0qberb16ph2LjaGgiv2wHVZO9F
 CPlrlmpBCF4JPLJWhXBiPw+UULh9vYVeuJyok2r1+1cO2FWYIK4DX23RVaktlsNX3M3B8AN1E
 CaXN42Z0T9MohzwPGjtj6IvtxqDj51ZJFhavEn04w0R0ewO0aX2kKNB7CPbXHIci1MaMErgmN
 RlOhMDCY7xqfGcXTAlZtNHAJV9ZRnaflYz4KlcA0XyOucej4Svx66BzbVk7ECVOFhj1nxH/mm
 dK3i6Bjkr7cyDyigHu17KgKHRJXu21eTLTTinCdWo5Q96rh0Z7WxQtk7i/reJjmnteKrIJ53W
 6Nlzkqz57GAOYDiauUYDTP2KcN3C7paHehgZNn1wz0nT6B6z5mfIbwtw1SdOGrJsFnhyQZsxH
 ewb/95uxdy9zrarmA9cTRkmMxJNGoBakxsMpaXQVrdwa+G3OWeHdiSFB5grPE12gQhQkC2UjN
 2vVMf0Z5XdHkvedzp7SroUFR05VoQma/FszEiYPPOY25rnB6d6yfT24FqJCONJFJBsXH7Ri2E
 gOLIWv0dXNC+SMZJhA28FfV/4CGeQurO2UK5PPKOftNQirldy6LJzruibK7r8wJkbEHUFcPXO
 u5B/BdtvY72ZtGZuzkJSqUieLYFOiGTnvIaejJcDpw0syGw0jA3BDeTNzNtG+a+NboEWrpsKI
 FD0gVBsx9be2eqoHqEoYZiiTMW5WTeyQZMGlI9r/vlaSNKyCrqdQueWOOPQKPO+X0iRklIDrw
 SuB/wPeN35i0uE=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/23 18:46, Filipe Manana wrote:
> On Thu, Sep 23, 2021 at 11:20 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>>
>>
>> On 2021/9/23 18:08, Yuxuan Shui wrote:
>>> Hi,
>>>
>>> On Thu, Sep 23, 2021 at 10:45 AM Qu Wenruo <wqu@suse.com> wrote:
>>>>
>>>> Mind to provide the full send stream dump?
>>>>
>>>> This indeed looks like a bug now.
>>>
>>> Sorry, this might have data I am not allowed to share, and I don't
>>> think I will be able to vet all the files in the stream.
>>>
>>> But if you can let me know what I can do to help debugging, I could tr=
y that.
>>
>> That's totally understandable.
>>
>> Surprisingly, I can't even find a proper way to get the nodatasum flag
>> per-file.
>> Thus I guess things may go complex by using "btrfs ins dump-tree"
>>
>> For the receive failure case, mind to provide the following info?
>>
>> - The inode number of the clone source
>>     You can use 'stat' command to get the inode number:
>>     $ stat /mnt/btrfs/file  | grep Inode
>>     Device: 29h/41d      Inode: 257         Links: 1
>>
>> - The tree dump of the clone source
>>     $ btrfs ins dump-tree -t <subvolid> <device> | \
>>       grep "(<INODE> INODE_ITEM 0) item" -A 5
>>          item 4 key (257 INODE_ITEM 0) itemoff 15883 itemsize 160
>>                  generation 7 transid 7 size 0 nbytes 0
>>                  block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
>>                  sequence 3 flags 0x0(none)
>>                  atime 1632391968.333333415 (2021-09-23 18:12:48)
>>                  ctime 1632391968.333333415 (2021-09-23 18:12:48)
>>
>>      <subvolid> is the subvolume id of the clone source.
>>
>> - The tree dump of the clone dest directory
>>     The inode number can be get using the same 'stat' command.
>>     Then pass it to the same "btrfs ins dump-tree" command, with
>>     <subvolid> <device> and <INODE> modified.
>>
>> Then we can be sure what's causing the NODATASUM flag mismatch.
>
> Catching up on the whole thread, that is indeed a possible cause of fail=
ure.
>
> Someone can do something like:
>
> 1) mount fs without -o nodatacow and without -o nodatasum
> 2) receive snapshot A
> 3) umount fs
> 4) mount fs with -o nodatacow or -o nodatasum
> 5) start receiving an incremental stream that has A as parent and
> snapshot B as the send snapshot
> 6) files created in B end up with the NODATASUM flag set
> 7) the send stream has a clone operation to clone from some file in A
> to a file in B - this fails, as the file in A does not have the
> nodatasum bit but the file in B has it

Exactly.

We can craft a test case for it (but without a fix for a while).

>
> I'm thinking that for cases like this, we could use a flag for send to
> tell it to not generate clone operations and do regular write commands
> instead.

My biggest concern here is, we should properly include the inode flags
in the send stream, and provide an interface to change btrfs specific
flags (currently only NODATASUM) at the receive side.

With that we can set the proper inode flags before writing/cloning, no
matter the mount option.

But this is a big project, involving changing send stream format,
introducing new ioctl interface.

Thanks,
Qu

>
>>
>> Thanks,
>> Qu
>>
>
>
