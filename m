Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1FC3E89B7
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 07:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbhHKFZ0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 01:25:26 -0400
Received: from mout.gmx.net ([212.227.17.21]:45019 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229730AbhHKFZZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 01:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628659498;
        bh=cQ7UXlGWi2gpD07Oalw+Cecwh71fm/TFyFDo3djODmE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZMTOCJ2tJssiW2FnHcM8reIl50U4wNwBxo0Am+UiwqC2JxX80Dr+xjQkSkysSQ/wz
         npuDyCKPryS6pFo8SzxN8vfuPBwz5EEtkLmyQgXVaknfaGvGfkh+4eAd7Warapn/DC
         9c6QQL+ET+FE3lExB2KWKdPLFymrv/KCJes5WX+s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXXyJ-1mc5u23oJr-00YwIR; Wed, 11
 Aug 2021 07:24:58 +0200
Subject: Re: Trying to recover data from SSD
To:     Konstantin Svist <fry.kun@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <67691486-9dd9-6837-d485-30279d3d3413@gmail.com>
 <46f3b990-ec2d-6508-249e-8954bf356e89@gmx.com>
 <CADQtc0=GDa-v_byewDmUHqr-TrX_S734ezwhLYL9OSkX-jcNOw@mail.gmail.com>
 <04ce5d53-3028-16a3-cc1d-ee4e048acdba@gmx.com>
 <7f42b532-07b4-5833-653f-bef148be5d9a@gmail.com>
 <1c066a71-bc66-3b12-c566-bac46d740960@gmx.com>
 <d60cca92-5fe2-6059-3591-8830ca9cf35c@gmail.com>
 <c7fed97e-d034-3af1-2072-65a9bb0e49ef@gmx.com>
 <544e3e73-5490-2cae-c889-88d80e583ac4@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <c03628f0-585c-cfa8-5d80-bd1f1e4fb9c1@gmx.com>
Date:   Wed, 11 Aug 2021 13:24:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <544e3e73-5490-2cae-c889-88d80e583ac4@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B9kgD+FP3B0+q773MepOO3I5YXGKNMyzXqwAsWg3hnuVFVFW1p+
 dfQf07QIxqKdwL349WJlgDGP7b5HsROFko2xPoa7bnxz4JtrhdmOG7SjHYx6ejKXARBBUrQ
 K/wWM4Ww+8yFwQMOhKN7713kXFV5ZyoLRXW8xqtef8GCnNoePASx2GNTipyg5wA3SB8x1KE
 N65lecAy02c3skYRPltTg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:i8mH97jg4FM=:bhVDA+lxAVsj4kefnVkwdd
 AOeDT/WmHOhLn5eq7G8SqK2eNigwSNnsdBAkEKChXbB6ilhHjTBJgs+/hD6s9A2tZ3XRs1SDM
 vmS6oOYVkApMS/wr0fK1NRKtufc6cchUanCDb7JH32Suzefh0MAyfZT6Uxs0q3I+E1ujGSnS4
 ACrCv7HJjlewUznTeCmVbi9cNI6SfgRXxYkRXuxAvMYrfQrNl/ZeoruTeYFqgcMxI4VVSHWgu
 gX3ouoTxOyIPFDfAGiamIiNKjtVp83vajPOknF6k7wZ8Z8Vk4Gg0EB17HPV6MN47dN4xuOwcr
 yDS7V1hQp9JIymVftY39ax08BNTb8b2PtM8Ju1g7BmBplPnbMsviw1zZ0sj+GPPzvH99jThIJ
 Vyn9BxDjTFBLhB6I30cevhR7DDF21TeAlAIiTFCYtA6FO42LnvGW46ogqHlUp4XlPjvjNn1Yg
 368SKO6zICs2eCKa3zzp2I220HudGxDYoyTF9zag3n2JXcc5k6qdTDpyyelR6Y4meO9vzR5iW
 aQTY7/dml5wp5wDRpUBElSr7HNGzpMKMB5F4jmq5Z0BwkxWcLFL1j0UEnW5YkAE3GgqvMnQCI
 oPNvZodZNr2shgILEBakDI3KaSyRlD8Z0zr1LJsxpoEteII1vWQwu1aMwdATae+tOsVzaCPBC
 1BoPMF2kE3c/BFl+JYsz1eSV8tv5hS0WpuM3g9BF0bNtGxjJTTBTS4bEal8y4IgLmo7wkCPx7
 B8xYszL6g/PhUZIKkIQO5cd7eoAGDfy8h3SQYIt8Pgk/CLHfc1B3pCpiuMjWiCcOYA/0wAyO9
 6Tjq9A4wyada58+FPzqTlOQydQ+E3J42gGWvq9zx9gUBD2wuVqyz2D9O3cef8+iuewQja38Am
 lmY6qhRsHFPA1uylFJmk8/PliyTyxNBg40Fsd2CHN6dk56uUrGF4b6EY612s2LB6me1e4jCdM
 u2b/1FgjWMLAyWKzsxRY1qtp6SwBz52J2OTJDs+2RIzKJEKResJhWO/qWVbcJ9zU61RClinum
 qVXNadPmN90vKVdHPSsqWUseHExNzxrQcqqkOkjy/NQrsAKDUmmi+35HtnC5VezFFTkTzybUb
 Y1JIqpULcxjIGjHJOAp4BgoFVl7R0s+IQue817KkwDJNoDc4w2wydg1Dg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/11 =E4=B8=8B=E5=8D=881:22, Konstantin Svist wrote:
> On 8/10/21 16:54, Qu Wenruo wrote:
>>
>>
>> On 2021/8/11 =E4=B8=8A=E5=8D=887:21, Konstantin Svist wrote:
>>> On 8/10/21 15:24, Qu Wenruo wrote:
>>>>
>>>> On 2021/8/11 =E4=B8=8A=E5=8D=8812:12, Konstantin Svist wrote:
>>>>>
>>>>>>> I don't know how to do that (corrupt the extent tree)
>>>>>>
>>>>>> There is the more detailed version:
>>>>>> https://lore.kernel.org/linux-btrfs/744795fa-e45a-110a-103e-13caf59=
7299a@gmx.com/
>>>>>>
>>>>>>
>>>>>
>>>>>
>>>>> So, here's what I get:
>>>>>
>>>>>
>>>>> # btrfs ins dump-tree -t root /dev/sdb3 |grep -A5 'item 0 key
>>>>> (EXTENT_TREE'
>>>>>
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 0 key (EXTENT_TREE ROOT_ITEM 0)=
 itemoff 15844 itemsize 439
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 generation 166932=
 root_dirid 0 bytenr 786939904 level 2
>>>>> refs 1
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 lastsnap 0 byte_l=
imit 0 bytes_used 50708480 flags 0x0(none)
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 uuid 00000000-000=
0-0000-0000-000000000000
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 drop key (0 UNKNO=
WN.0 0) level 0
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 1 key (DEV_TREE ROOT_ITEM 0) it=
emoff 15405 itemsize 439
>>>>>
>>>>>
>>>>> # btrfs-map-logical -l 786939904 /dev/sdb3
>>>>>
>>>>> checksum verify failed on 952483840 wanted 0x00000000 found 0xb6bde3=
e4
>>>>> checksum verify failed on 952483840 wanted 0x00000000 found 0xb6bde3=
e4
>>>>> checksum verify failed on 952483840 wanted 0x00000000 found 0xb6bde3=
e4
>>>>> bad tree block 952483840, bytenr mismatch, want=3D952483840, have=3D=
0
>>>>> ERROR: failed to read block groups: Input/output error
>>>>> Open ctree failed
>>>>>
>>>>>
>>>>>
>>>>> Sooooo.. now what..?
>>>>>
>>>> With v5.11 or newer kernel, mount it with "-o rescue=3Dall,ro".
>>>
>>>
>>> Sorry, I guess that wasn't clear: that error above is what I get while
>>> trying to corrupt the extent tree as per your guide.
>>
>> Oh, that btrfs-map-logical is requiring unnecessary trees to continue.
>>
>> Can you re-compile btrfs-progs with the attached patch?
>> Then the re-compiled btrfs-map-logical should work without problem.
>
>
>
> Awesome, that worked to map the sector & mount the partition.. but I
> still can't access subvol_root, where the recent data is:

Is subvol_root a subvolume?

If so, you can try to mount the subvolume using subvolume id.

But in that case, it would be not much different than using
btrfs-restore with "-r" option.

Thanks,
Qu
>
> [root@fry ~]# mount -oro,rescue=3Dall /dev/sdb3 /mnt/
> [root@fry ~]# ll /mnt/
> ls: cannot access '/mnt/subvol_root': Input/output error
> total 0
> d?????????? ? ?=C2=A0=C2=A0=C2=A0 ?=C2=A0=C2=A0=C2=A0=C2=A0 ?=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ? subvol_root
> drwxr-xr-x. 1 root root 12 Mar 18 20:55 subvol_snapshots
>
>
> dmesg:
>
> [532051.071515] BTRFS info (device sdb3): enabling all of the rescue opt=
ions
> [532051.071521] BTRFS info (device sdb3): ignoring data csums
> [532051.071523] BTRFS info (device sdb3): ignoring bad roots
> [532051.071524] BTRFS info (device sdb3): disabling log replay at mount =
time
> [532051.071526] BTRFS info (device sdb3): disk space caching is enabled
> [532051.071528] BTRFS info (device sdb3): has skinny extents
> [532051.077018] BTRFS warning (device sdb3): sdb3 checksum verify failed
> on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6 level 2
> [532051.077710] BTRFS warning (device sdb3): sdb3 checksum verify failed
> on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6 level 2
> [532052.705324] BTRFS error (device sdb3): bad tree block start, want
> 920748032 have 0
> [532052.705934] BTRFS error (device sdb3): bad tree block start, want
> 920748032 have 0
>
