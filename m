Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57BC3FB1D0
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 09:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbhH3HV2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 03:21:28 -0400
Received: from mout.gmx.net ([212.227.15.18]:36239 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233318AbhH3HV2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 03:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630308033;
        bh=BtqoBT8ykB7ZwtYRWTpSq8TEGpEu33AldVtkEN4+xVo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=IvCNxIntsA0NKsN6QobIEyqdQEO9TwmN90v7GKcAMlmdISNC2NnbnxHwYqJJP30Zt
         P8EqtNiRvcth4jd0ToZXg8vghXZk4smQ9SrxwUBLaxQaV+7TVG3b1SCVCAEIWfTw0O
         RzpTJB3IO2stCfze5u3o8pRqWT79tqDyTdPddBJI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mof9P-1mnOyv0tSL-00p0hG; Mon, 30
 Aug 2021 09:20:32 +0200
Subject: Re: Trying to recover data from SSD
To:     Konstantin Svist <fry.kun@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <67691486-9dd9-6837-d485-30279d3d3413@gmail.com>
 <c7fed97e-d034-3af1-2072-65a9bb0e49ef@gmx.com>
 <544e3e73-5490-2cae-c889-88d80e583ac4@gmail.com>
 <c03628f0-585c-cfa8-5d80-bd1f1e4fb9c1@gmx.com>
 <d7c65e1d-6f4e-484b-a52f-60084160969f@gmail.com>
 <2684f59f-679d-5ee7-2591-f0a4ea4e9fbe@gmx.com>
 <238d1f6c-20a9-f002-e03a-722175c63bd6@gmail.com>
 <4bd90f4a-7ced-3477-f113-eee72bc05cbb@gmx.com>
 <fab2dab5-41bb-43f2-5396-451d66df3917@gmail.com>
 <60a21bca-d133-26c0-4768-7d9a70f9d102@gmx.com>
 <7e8394c9-9eb3-c593-9473-5c40d80428a5@gmail.com>
 <1785017b-e23b-e93d-5b78-2aa40170fe62@gmail.com>
 <14a9a98c-50fc-eb7b-804b-2fe36775b5fa@gmx.com>
 <36652872-850c-fe92-9fcd-c9c95dc25d65@gmail.com>
 <cebedd98-1fe4-731f-fc54-5366c8f18a2f@gmx.com>
 <d0ebdff7-10f0-c8f3-e098-18f651a149d8@gmail.com>
 <597bd681-c7ba-075c-4376-142695b91f93@gmx.com>
 <4a5d64fd-637c-bd8a-fe6f-db1bb20942c2@gmail.com>
 <5858520a-ca82-0552-140d-9702fc7dad94@gmx.com>
 <74809aba-047e-ca7a-e5b4-d64287ddd81d@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <3fbd1db5-97f7-8d8f-e217-3a7086eb74b0@gmx.com>
Date:   Mon, 30 Aug 2021 15:20:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <74809aba-047e-ca7a-e5b4-d64287ddd81d@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hHx0D8NH9SGw6Qmv2LabbUBE3cTV5uzc/ruyoy6N6InZjN7a/e/
 Ffmkp4OO0qir6hh7YpOsgloozNYuQNxrDlpQk5Bd9+orcn9K2rvNzHGMl6dz3Kk/WEgSSJd
 tnWXKsCEKYK4WoezRSPpvdWNgXEpHZvG5tnCpSWEhBjfm0DQWnU+NLgMU9KqqqKBMYgoCdj
 DfxSckVIfhwXVVlj75gKQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:o6rUQBpn9VQ=:dgcKd333EoHFToMIp4Z/Lb
 xnIe7mNUigVnuwr55r7+LP5Av/CuitU9qOUwg0qHDFBsRGKKvqWTGHAllb04IhM5BGP0GducW
 z5Fut7JZesKfLsuJsCaRGFa946hVmE2wKvIvLVqu+tUDtD4xi0GZ3+UHyL1YW1864C6J4gOGY
 1R2HmQ2u+1XSYL+DZ+V1vUEa6I9/4jXMum0wOPEkrctiCr75SeNYK4AmrRzd4Z864n5ztmYo4
 JFRiO8HnTDHpvxBF7lO3/7rMFjKqW/D+AmfWmu9R+W1SGSOaK7hefOqom2aJkejxyE95ESivt
 wuQm6VzBEP5nD0GTdHqxwlVoYB/DDdGFhwpR15eonoY0wjgcx4UId5+WhpKyIApVA0m2Q8JTU
 Kefij2sum8hSylnrI09aizpWv/yQkn5Ibyh7GAoN1TchI58tNs7hmjgaUWQg9ZXYktRLt+C1W
 gfVdH7h3nuvN1MruTgxL8gx4wEfxnt3gzpLSFjDgspNzqRkH7Z157pvIsvRjoOZ2/0GQfAahg
 fU/XXIor0wHsjFRwbVdtkLPON/Q4mfu2/YcTziczImcXdACefMLpQnZk5Hkps0cGL4QLWUZlk
 BzCRQWqGYhOonexhb/3+m0XtGly2S7XLhY9+6klboKjnQIpVZ3pKz03KJP8Tuf+L80JvBXH5h
 AqbVk/sQWC5NQEF26DnvkHy3cwPNLkhbiUb1lbdzygPk+4y4+Q1OoT+iQz/+EliZ+ZdUDB3L2
 9sXT1Xw5lcX6h7kHpjFjO1gYaikA07Vgs1sABpNmEi9Zl8f/C9QmImJomxCnYzWCp+qtllBbU
 BXjA6GeUJE6gNUb1Dt16Tws/KggKrU0H61/wB0BhqtJwT2WUCm1z1rF743Fn8wt+lB4Bj38CZ
 YODZTbVUXOAM2SzsoBWmF+nAptzRaEjm0N7QVj6i9F+LHBmde7hT4DUgi1bhkfQDn43AJeglL
 ZJHKHBBxr7IyZcbxobty0dReDfvgA7hb/arSmeO5FEoI1zlCYnhH4aSDOaJYXt/eETlXUrolU
 xkvSukmLtVG33MvBG+ZQSLWIBvqC/2nD1zQXMVXj63CQ2PLDrEBEtjBpOmRHrWfBDLkdEKDXJ
 nlevCVaVFIrATd+LdALRYPALHn/vEaU9AzLtj/QhM3OHAZWA3J7ooCNGQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/30 =E4=B8=8A=E5=8D=8811:48, Konstantin Svist wrote:
> On 8/29/21 17:22, Qu Wenruo wrote:
>>
>>
...
>>
>> But this is definite not a good thing for your data salvage...
>>>
>>>
>>> The other 3 attempts:
>>>
>>>
>>> # btrfs ins dump-super -f /dev/sdb3 | grep backup_tree_root
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 backup_tree_root:=C2=A0=
=C2=A0=C2=A0 787070976=C2=A0=C2=A0=C2=A0 gen: 166932=C2=A0=C2=A0=C2=A0 lev=
el: 1
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 backup_tree_root:=C2=A0=
=C2=A0=C2=A0 778108928=C2=A0=C2=A0=C2=A0 gen: 166929=C2=A0=C2=A0=C2=A0 lev=
el: 1
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 backup_tree_root:=C2=A0=
=C2=A0=C2=A0 781172736=C2=A0=C2=A0=C2=A0 gen: 166930=C2=A0=C2=A0=C2=A0 lev=
el: 1
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 backup_tree_root:=C2=A0=
=C2=A0=C2=A0 786399232=C2=A0=C2=A0=C2=A0 gen: 166931=C2=A0=C2=A0=C2=A0 lev=
el: 1
>>>
>>> # btrfs ins dump-tree -b 786399232 --follow /dev/sdb3 | grep "(257
>>> ROOT_ITEM" -A 5
>>> [...]
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 item 13 key (257 ROOT_ITEM 0) itemoff 13147 =
itemsize 439
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 generation 166931 root_di=
rid 256 bytenr 781467648 level 2
>>> refs 1
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 lastsnap 56690 byte_limit=
 0 bytes_used 1013104640 flags
>>> 0x0(none)
>>>
>>> [...]
>>
>> To manually inspect the tree, you can use btrfs-inspect to see what's
>> wrong with the tree blocks.
>>
>> # btrfs ins dump-tree -b 781467648 --follow --bfs /dev/sdb3
>>
>> This also means, even the remaining part is fine, a big chunk of data
>> can no longer be recovered.
>
>
> I'm hoping to find several important files at this point, definitely
> don't need the whole FS..
>
> So when I run this, I get about 190 lines like
>
>  =C2=A0=C2=A0=C2=A0 key (256 INODE_ITEM 0) block 920748032 gen 166878
>  =C2=A0=C2=A0=C2=A0 key (52607 DIR_ITEM 988524606) block 1078902784 gen =
163454
>  =C2=A0=C2=A0=C2=A0 key (52607 DIR_INDEX 18179) block 189497344 gen 30
>  =C2=A0=C2=A0=C2=A0 key (174523 INODE_REF 52607) block 185942016 gen 30
>  =C2=A0=C2=A0=C2=A0 key (361729 EXTENT_DATA 0) block 785907712 gen 16693=
1
>  =C2=A0=C2=A0=C2=A0 key (381042 XATTR_ITEM 3817753667) block 1027391488 =
gen 120910

Can you provide the full output? (both stdout and stderr)

If you're concerning about the filenames, "btrfs ins dump-tree" has
=2D-hide-names to mask all the file/dir names.

190 lines look too few than expected, thus means some tree blocks are
not read out properly.

You may want to try other bytenr to see which gives the most amount of
output (thus most possible to restore some data).
>
>
> I tried to pass these into restore, but it's not liking it:
>
> # btrfs restore -Divf 196816535552 /dev/sdb3 .

Where the bytenr 196816535552 is from?

> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
> Csum didn't match
> WARNING: could not setup extent tree, skipping it

This part is expected, it just tries to read extent tree which is
manually corrupted.

> This is a dry-run, no files are going to be restored
> Done searching

While this is not expected, as it doesn't even show any research
attempts, is the bytenr from the subtree of the subvolume 257?

Thanks,
Qu

>
>
>
