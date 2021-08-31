Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2416F3FC65E
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 13:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241356AbhHaLGU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 07:06:20 -0400
Received: from mout.gmx.net ([212.227.15.18]:34965 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241348AbhHaLGQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 07:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630407919;
        bh=C1Mb9P29ONR9RIfd7oDtJeiX0my0QiqmqTodYypdQ40=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=Oc9sMs8TXRF41iv2UAgqqyeaRGyr/V5Bt76qRA6/CviW9u5kOZjaQt+Pee7XIl+yu
         A48GSfxmcbPKYJoBbUf8Zib186fHQnlML8fialVo5UqIiLBQG1MmO7Stxtx2Q0R2zU
         5aluX9BYxM77Mxj+Ay93J36K1haA8c4cqk/yLO2s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MowGa-1mm9Nx0SgY-00qQGC; Tue, 31
 Aug 2021 13:05:19 +0200
To:     Konstantin Svist <fry.kun@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <67691486-9dd9-6837-d485-30279d3d3413@gmail.com>
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
 <3fbd1db5-97f7-8d8f-e217-3a7086eb74b0@gmx.com>
 <aa33b83f-b822-b1d8-9fe4-5cf4ab45c3e1@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Trying to recover data from SSD
Message-ID: <64eb1b22-a9c0-e429-4407-cdfd6af4e031@gmx.com>
Date:   Tue, 31 Aug 2021 19:05:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <aa33b83f-b822-b1d8-9fe4-5cf4ab45c3e1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FuIqDsWachD7Yy/DBDGa0k80DIr1jyUThlfa5jdk/P7iSznHC9W
 /4+uy1X/ykM8rioK0lSLjM2D3tVGdd44X/wB60Kmg74imbbbCQlUdetBuh4LANkiGSdNGrK
 F7AjAfFFJlktdJ6REJ3Wv3aqZ+jVUl4yXPfD3ogqp20jquChzAQ198IDaIn8WBLFhMshQBu
 BL/DjiODzlxwCQdZAsFTg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VJfF5uqDQzw=:5UQe1msgDq/AtYgDPVA3/c
 GEIFbr079KpeyoEHPPMFOyp7oXnc9Wf+oktwtVgTVyHpIF2DlDzMHrpHrmmFGK4xAR+oJritA
 l1ZuZWQ0egifUncPXq1JCvOb+C0O35eREhKJ93xzimNq7OxKE2QRYT6TWhRaJLCXc+I6cEGDv
 V0tY2445Bn/3HDoh+syfiYJhlw2sKuXc+KJ/KIc6SgJLMQqd3HXoN3a2E5xfhE08nqHmc4JvV
 8CtEzFh3yAA+wO71LAEY1Fx460Li7mEldYPrlok1yzRaewFQD2bgMI4z7gqwIg61z3uCo1a0W
 sOD31b5P7LmnZ7ZGwu/6v3fUj87y3Arck9O9RhHihNFArFfVYq4ws0NDKbClCYduJhETltbte
 RELe4WOq+0bh0N132e+SuDUJmWd6uW4CN37R/BdNagoL0Ne4G/j4euZFm14Fn0LqSnPNuXe0r
 5VKEHvzJPX59R9FxlZABPFAwAZPFqBNdnn1doip+V2sTRps7fVQD0q//NgCnDdpZ8+8T72sUG
 TwZalk91yvLANRc+aJq/FPoGs+SNx0KCPmVQHXhJL24yvCiimaRhAYm5AUA4Fh4aZRQ/lDhWv
 fjYyoWv4ug+Tr2MDCiQ0IlHi88DuQKPufqnd4HBC0bYfsPHHGC+gtScmDcgV8Yn+VASldylhl
 T3dwHnCvceJMfJJwDhamSPiuqeR5mDW82lTkuWeCJhOIP20c2FIjgS6RyRqz3QSAYX7hZBqYo
 +CAsV215PtKwbghdcV9uB3QBrDwQP7crQYjgoF1W/mmk98sPAe6s65UW6OdkLYTRs1DYNLHo2
 rZQqKNiPL6okpJq4Y+Z82rjv2WTReh3YsiDYJ5vzb1R0e7wf9iC6JOMTmTm8xM45uo7+DpLnC
 VP2x0jjaqdQ9g6nYzKluAgiYjG2dR3N+47P0w9ors/vW2oJ1XccBP6m6eXvaNoIzBAedOCnSa
 pUc2MY8ipK9K/wc2H/I93P2HeLgEwF798MwrQ2Y2pq9vZeGB8YDUnXvuTaIz8y3bGs9xocSUg
 w4Xhei9bKWycFyFYn6X7VfJQoyIomWpCu2WNiXPYSxKCwY2HZOKtNVgmDhbisKaSh7dAO+h8e
 maTm4KC9FuUACY5maOOLbSdOVtd2Sy9oCWJ17VxvmjZ4VxL6UdtcLtOrg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/31 =E4=B8=8B=E5=8D=882:25, Konstantin Svist wrote:
> On 8/30/21 00:20, Qu Wenruo wrote:
>>
>> On 2021/8/30 =E4=B8=8A=E5=8D=8811:48, Konstantin Svist wrote:
>>>
>>> I'm hoping to find several important files at this point, definitely
>>> don't need the whole FS..
>>>
>>> So when I run this, I get about 190 lines like
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 key (256 INODE_ITEM 0) block 920748032 gen 1=
66878
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 key (52607 DIR_ITEM 988524606) block 1078902=
784 gen 163454
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 key (52607 DIR_INDEX 18179) block 189497344 =
gen 30
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 key (174523 INODE_REF 52607) block 185942016=
 gen 30
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 key (361729 EXTENT_DATA 0) block 785907712 g=
en 166931
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 key (381042 XATTR_ITEM 3817753667) block 102=
7391488 gen 120910
>>
>> Can you provide the full output? (both stdout and stderr)
>>
>> If you're concerning about the filenames, "btrfs ins dump-tree" has
>> --hide-names to mask all the file/dir names.
>>
>> 190 lines look too few than expected, thus means some tree blocks are
>> not read out properly.
>>
>> You may want to try other bytenr to see which gives the most amount of
>> output (thus most possible to restore some data).
>
> ## Naming these BTR1..4
> # btrfs ins dump-super -f /dev/sdb3 | grep backup_tree_root | sort -rk 4
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 backup_tree_root:=C2=A0=C2=A0=C2=
=A0 787070976=C2=A0=C2=A0=C2=A0 gen: 166932=C2=A0=C2=A0=C2=A0 level: 1=C2=
=A0=C2=A0 ### BTR1
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 backup_tree_root:=C2=A0=C2=A0=C2=
=A0 786399232=C2=A0=C2=A0=C2=A0 gen: 166931=C2=A0=C2=A0=C2=A0 level: 1=C2=
=A0=C2=A0 ### BTR2
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 backup_tree_root:=C2=A0=C2=A0=C2=
=A0 781172736=C2=A0=C2=A0=C2=A0 gen: 166930=C2=A0=C2=A0=C2=A0 level: 1=C2=
=A0=C2=A0 ### BTR3
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 backup_tree_root:=C2=A0=C2=A0=C2=
=A0 778108928=C2=A0=C2=A0=C2=A0 gen: 166929=C2=A0=C2=A0=C2=A0 level: 1=C2=
=A0=C2=A0 ### BTR4
>
> ### BTR1:
> # btrfs ins dump-tree -b 787070976 --follow /dev/sdb3 | grep "(257
> ROOT_ITEM" -A 5
> ...
>  =C2=A0=C2=A0 item 13 key (257 ROOT_ITEM 0) itemoff 13147 itemsize 439
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 generation 166932 root_dirid 256 =
bytenr 786726912 level 2 refs
> 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ### naming this RI1
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 lastsnap 56690 byte_limit 0 bytes=
_used 1013104640 flags 0x0(none)
> ...
>
> BTR1 -> RI1 786726912
> BTR2 -> RI2 781467648
> BTR3 -> RI3 780828672
> BTR4 -> RI3 102760448
>
> ### inpsecting RI2
> # btrfs ins dump-tree -b 781467648 --follow --bfs /dev/sdb3
>> RI2.inspect.stdout 2>RI2.inspect.stderr
> <outputs attached>
>
> One of the lines of this output is
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key (2334458 DIR_ITEM 356478=
7518) block 196816535552 gen 56498
>
>>> I tried to pass these into restore, but it's not liking it:
>>>
>>> # btrfs restore -Divf 196816535552 /dev/sdb3 .
>>
>> Where the bytenr 196816535552 is from?
>
> ^^^ output from inspect RI2 -> DIR_ITEM. Probably wrong usage? :)

OK, that seems to be out of the way btrfs-restore can handle.

>
>
>>
>>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
>>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
>>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
>>> Csum didn't match
>>> WARNING: could not setup extent tree, skipping it
>>
>> This part is expected, it just tries to read extent tree which is
>> manually corrupted.
>>
>>> This is a dry-run, no files are going to be restored
>>> Done searching
>>
>> While this is not expected, as it doesn't even show any research
>> attempts, is the bytenr from the subtree of the subvolume 257?
>
>
> Interestingly, I tried --dfs instead of --bfs and there are a lot more
> entries, including filenames
>

BTW, thanks to the output and stderr, it shows exactly what's going wrong.

The offending tree block, 920748032, is the first one.

If using --dfs, it will go through each child until reaches the leaves,
before going to next tree block.

And if the first child is corrupted, then it gives up immediately.

That's why I'm explicitly specifying --bfs, which will skip the
corrupted child (and its children) and go next tree blocks directly,
thus have the best chance to recovery the contents.

For the worst case, I guess you have to use "btrfs ins dump-tree" to
recovery your files, and then "btrfs-map-logical" to grab the data from
disk directly.

Meanwhile I guess I should put some time to enhance btrfs-restore to
handle the corruption you're hitting, so that we can continue to next
good tree block, without being bothered by early corrupted tree blocks.

Thanks,
Qu

