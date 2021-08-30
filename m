Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3B13FAF39
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 02:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbhH3AXA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Aug 2021 20:23:00 -0400
Received: from mout.gmx.net ([212.227.15.15]:33061 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236130AbhH3AW7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Aug 2021 20:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630282925;
        bh=QDi8g/lY3Tw9iCgR+2KPWJoeS0FodEmE7AHNKneXENI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=cgwwO11VhpLVr6IS0SRh7dt8AhDDlNQLXNbGEvbK/44wCoHsgtvib0DJc+N5xi79t
         g6ofaCrr0Li1aGByIAnAg7UgyhLwp3odQcpF6+kqi4bVN6a7P5TGbkJpJMdenMVOPi
         bg/kefxnZ4W2E5//AVqGifSZzhyMGbFbZPfqd6AM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MHoN2-1mFWyg36sY-00EqkP; Mon, 30
 Aug 2021 02:22:05 +0200
Subject: Re: Trying to recover data from SSD
To:     Konstantin Svist <fry.kun@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <67691486-9dd9-6837-d485-30279d3d3413@gmail.com>
 <1c066a71-bc66-3b12-c566-bac46d740960@gmx.com>
 <d60cca92-5fe2-6059-3591-8830ca9cf35c@gmail.com>
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <5858520a-ca82-0552-140d-9702fc7dad94@gmx.com>
Date:   Mon, 30 Aug 2021 08:22:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <4a5d64fd-637c-bd8a-fe6f-db1bb20942c2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W4e6CqK43uoE6Nq++wNfTUJgOO8rx1+IRbmC/7H/YqwFt2A5H9x
 PbhxN9QKa+D213qJaW/DIickt4diHOPi0U69ZXGn4qTs9sDQJINUivRmPcKvPggssXGjsiZ
 Ri0/fwiFEODhSrPDKbsId+5aIHD9j0bdNhM3jEDUkprnoVYt4gvEjhTfdz8SqNNWNKRmyZc
 xsdyW+CaOQ0iPUQC7Axyw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UU+j7OtOgwo=:om15PkwWAZU2UzHITo0sE1
 qe+CfusXKvWiuLh5izv8oEP8K7CkOo2ThsmmDWgViSrPmMHOvg0BfprCrWXiz1vudz0E+h9Uv
 yIPUAiBKuWSp50nabSgWmwnuIKDEk2bLjhFktyWLYJZfMg13fm2ShMg16wJg21iSaf+sdEm/W
 ar3Aa0fDruckR8WuXJK16Na1c+UOtgxsFsPK4k4rO5DIrzRWaa6UdzxPSzVjsTjZWVH2wdrZ6
 F/p/bAhhVM0nSX4cD7No+//IyGBCEEIw+vTUmuXiy/JGNgTgazkIZlIYnLk+JbMa2oVo/S6+A
 ke6Ugg4mhmM19jUEWc1UTpP/Z/moWFdULCxDjvSTGO2ssYEIWkJ6nUcFCjHIbqmB9pFO+94wm
 ogxCjqc+lLMufNCMpMYMkU/imoXsaaQT8K5KsQD5OiAuU5KiaFZ/IpProZWL+jEVAGshhJOho
 JxJg5WgE8mFEeU+VwLAaPwTDKTz60JECrmY0EfTWpIQrvnyfDAM8gs/SbsxCuW5biq3Qkbxjb
 WogaMlXW+nLleNh+HcybH++GA9pSOO+kWEhOLgOjcYoHmPndvhyn97Fr5YGdqYJ3miNeGKDjN
 S0vi/9sEEpwld4r2PdDQWeZWmNbs1pAWABSsqxrjeAxUJDuqBzmLuK8f0uXOUWCMqlV8i/ep+
 cmpA0SgR2ZKdT3/tY9SMtMgEtXuxSwXt/C2mCEN0Yw99DJRjdpEjimRdnjR0P/qACfvrveveu
 UYkLjlW3N08dtKokGwBn+EWItp/mk/GlqQpuyT+rWtOpiyIK3d+0P96gqa7EbVZNhYLHB2XAp
 rm4gduH+Lct6YkwvySbUhLqWP0KctNb7QTi0T7i66RJogxipAwuvaVu4yXCkShuiHLNj+aTlA
 dXmfpPx7UShBUZwuAIKbsSNUYoJQITV0cHyYSfqI4HykCJcHa2Y8XoCyHmzBdBcd2qp2lBP+Q
 9rKNQP0jfxF1Pb+mAxW4R8coWkT6i+yy9iRpx8RE/uxBv3CkWkgH1iy/UtixPCTs0EpNcYKek
 3O4tCiT34f03On9LOysBiULiHRu2kwUh654MPPf52QNwS5XH2mStws04WbczamixkEyP5uzty
 MW4DIKFaUAuUGNf2RjFRPLx1Ka4z6kFwIYFe4KpZrA6vEbsKG8Zg3dVWw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/30 =E4=B8=8A=E5=8D=884:02, Konstantin Svist wrote:
> On 8/29/21 00:19, Qu Wenruo wrote:
>>
>>
>> On 2021/8/29 =E4=B8=8B=E5=8D=882:34, Konstantin Svist wrote:
>>>
>>> # btrfs ins dump-tree -b 787070976 --follow /dev/sdb3 | grep "(257
>>> ROOT_ITEM" -A 5
>>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
>>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
>>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
>>> Csum didn't match
>>> WARNING: could not setup extent tree, skipping it
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 item 13 key (257 ROOT_ITEM 0) itemoff 13147 =
itemsize 439
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 generation 166932 root_di=
rid 256 bytenr 786726912 level 2
>>> refs 1
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 lastsnap 56690 byte_limit=
 0 bytes_used 1013104640 flags
>>> 0x0(none)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 uuid 1ac60d28-6f11-2842-a=
ca2-b1574b108336
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ctransid 166932 otransid =
8 stransid 0 rtransid 0
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ctime 1627959592.71893642=
3 (2021-08-02 19:59:52)
>>>
>>>
>>> # btrfs restore -Divf 786726912 /dev/sdb3 .
>>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
>>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
>>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
>>> Csum didn't match
>>> WARNING: could not setup extent tree, skipping it
>>> This is a dry-run, no files are going to be restored
>>> checksum verify failed on 920748032 wanted 0x00000000 found 0xb6bde3e4
>>> checksum verify failed on 920748032 wanted 0x00000000 found 0xb6bde3e4
>>> checksum verify failed on 920748032 wanted 0x00000000 found 0xb6bde3e4
>>> bad tree block 920748032, bytenr mismatch, want=3D920748032, have=3D0
>>> ERROR: search for next directory entry failed: -5
>>
>> This all zero means the data on-disk are wiped.
>>
>> Either not reaching disk or discarded.
>>
>> Neither is a good thing.
>>
>>>
>>>
>>> 1st set of "checksum verify failed" has different addresses, but the
>>> last set always has 920748032
>>
>> Have you tried other bytenrs from find-root?
>
>
> Is it normal that they all fail on the same exact block? Sounds
> suspicious to me.

This means some higher tree block is corrupted.

Only manual inspection can determine.

But this is definite not a good thing for your data salvage...
>
>
> The other 3 attempts:
>
>
> # btrfs ins dump-super -f /dev/sdb3 | grep backup_tree_root
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 backup_tree_root:=C2=A0=C2=A0=C2=
=A0 787070976=C2=A0=C2=A0=C2=A0 gen: 166932=C2=A0=C2=A0=C2=A0 level: 1
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 backup_tree_root:=C2=A0=C2=A0=C2=
=A0 778108928=C2=A0=C2=A0=C2=A0 gen: 166929=C2=A0=C2=A0=C2=A0 level: 1
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 backup_tree_root:=C2=A0=C2=A0=C2=
=A0 781172736=C2=A0=C2=A0=C2=A0 gen: 166930=C2=A0=C2=A0=C2=A0 level: 1
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 backup_tree_root:=C2=A0=C2=A0=C2=
=A0 786399232=C2=A0=C2=A0=C2=A0 gen: 166931=C2=A0=C2=A0=C2=A0 level: 1
>
> # btrfs ins dump-tree -b 786399232 --follow /dev/sdb3 | grep "(257
> ROOT_ITEM" -A 5
> [...]
>  =C2=A0=C2=A0=C2=A0 item 13 key (257 ROOT_ITEM 0) itemoff 13147 itemsize=
 439
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 generation 166931 root_dirid 256 =
bytenr 781467648 level 2 refs 1
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 lastsnap 56690 byte_limit 0 bytes=
_used 1013104640 flags 0x0(none)
>
> [...]

To manually inspect the tree, you can use btrfs-inspect to see what's
wrong with the tree blocks.

# btrfs ins dump-tree -b 781467648 --follow --bfs /dev/sdb3

This also means, even the remaining part is fine, a big chunk of data
can no longer be recovered.

Thanks,
Qu

>
> # btrfs restore -Divf 781467648 /dev/sdb3 .
> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
> Csum didn't match
> WARNING: could not setup extent tree, skipping it
> This is a dry-run, no files are going to be restored
> checksum verify failed on 920748032 wanted 0x00000000 found 0xb6bde3e4
> checksum verify failed on 920748032 wanted 0x00000000 found 0xb6bde3e4
> checksum verify failed on 920748032 wanted 0x00000000 found 0xb6bde3e4
> bad tree block 920748032, bytenr mismatch, want=3D920748032, have=3D0
> ERROR: search for next directory entry failed: -5
>
> # btrfs ins dump-tree -b 781172736 --follow /dev/sdb3 | grep "(257
> ROOT_ITEM" -A 5
> [...]
>  =C2=A0=C2=A0=C2=A0 item 13 key (257 ROOT_ITEM 0) itemoff 13147 itemsize=
 439
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 generation 166930 root_dirid 256 =
bytenr 780828672 level 2 refs 1
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 lastsnap 56690 byte_limit 0 bytes=
_used 1013104640 flags 0x0(none)
> [...]
>
>
> # btrfs restore -Divf 780828672 /dev/sdb3 .
> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
> Csum didn't match
> WARNING: could not setup extent tree, skipping it
> This is a dry-run, no files are going to be restored
> checksum verify failed on 920748032 wanted 0x00000000 found 0xb6bde3e4
> checksum verify failed on 920748032 wanted 0x00000000 found 0xb6bde3e4
> checksum verify failed on 920748032 wanted 0x00000000 found 0xb6bde3e4
> bad tree block 920748032, bytenr mismatch, want=3D920748032, have=3D0
> ERROR: search for next directory entry failed: -5
>
> # btrfs ins dump-tree -b 778108928 --follow /dev/sdb3 | grep "(257
> ROOT_ITEM" -A 5
> [...]
>
>  =C2=A0=C2=A0 item 13 key (257 ROOT_ITEM 0) itemoff 13147 itemsize 439
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 generation 166929 root_dirid 256 =
bytenr 102760448 level 2 refs 1
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 lastsnap 56690 byte_limit 0 bytes=
_used 1013104640 flags 0x0(none)
> [...]
>
>
> # btrfs restore -Divf 102760448 /dev/sdb3 .
> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
> Csum didn't match
> WARNING: could not setup extent tree, skipping it
> This is a dry-run, no files are going to be restored
> checksum verify failed on 920748032 wanted 0x00000000 found 0xb6bde3e4
> checksum verify failed on 920748032 wanted 0x00000000 found 0xb6bde3e4
> checksum verify failed on 920748032 wanted 0x00000000 found 0xb6bde3e4
> bad tree block 920748032, bytenr mismatch, want=3D920748032, have=3D0
> ERROR: search for next directory entry failed: -5
>
