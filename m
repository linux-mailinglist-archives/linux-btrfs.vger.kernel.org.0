Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE69B3FA9E9
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Aug 2021 09:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbhH2HUx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Aug 2021 03:20:53 -0400
Received: from mout.gmx.net ([212.227.17.22]:35375 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230378AbhH2HUw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Aug 2021 03:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630221598;
        bh=/GVSdfcP4uaqgT54iA/3rdHjrDBAmWJW6GXAk5SPDNc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jmE6mhDdV3ytyOeIO5634Yjjp93sfOrhrHlEwTc7k9ZDyHXH7dLNIxP+g8BkftlOC
         Ked53OlWdo2PPin4HuIuGAlLNEETMfieXSf/gksItcRYhZkE8cibuUQLUxijQokHs7
         r8w7zAiI+HSeQvOu/hvy+bgJJpC4tEN3M5Z/Dc+E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MwQXN-1nC49D0fCv-00sMqV; Sun, 29
 Aug 2021 09:19:58 +0200
Subject: Re: Trying to recover data from SSD
To:     Konstantin Svist <fry.kun@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <67691486-9dd9-6837-d485-30279d3d3413@gmail.com>
 <04ce5d53-3028-16a3-cc1d-ee4e048acdba@gmx.com>
 <7f42b532-07b4-5833-653f-bef148be5d9a@gmail.com>
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <597bd681-c7ba-075c-4376-142695b91f93@gmx.com>
Date:   Sun, 29 Aug 2021 15:19:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <d0ebdff7-10f0-c8f3-e098-18f651a149d8@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X+RYIixN0qYw/7KnWDhcN/ExhkXbjnU4UYEdzrq3gpkQItffC2Y
 Bx3nKWRwjPE2YVS3sZh/D8MBYOAiNvv7y+sSofxFDfZS23PEWjgaf6za93kcDRpaGbUyu/n
 N7RWTn/qTR5rlIKzPsN4eulNbmgOb+18eXrLXFNwoYhFTZnqwNNTXAPP8Ey5lqVLBrr6O7i
 z3yRQ1O5/L98Axk0d4wig==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bbb0d2iAfKg=:VprL1HoU85JdkViGW7Im96
 AEQ3eypU/SClY8kElRSPnnmgeqBhZjMqm8Gbo6nWpyYMyHEQJAT6rBdQSJCfius5UTBKPCsfX
 aVesGAz9OPgD6OCAHwhaFigjDYL4L/5A3A0Ji9fYA/vHUwFuY1WooFWtWiD9AZP91HjPyhS8P
 XpzBHCogT02CxhhbFvEZaSgkgNkSr9Xb5DW4C5LLOmRQOIB0Skle9b/T+o9HvSvJX3dVv3f+j
 npxlLg9DwHO5KX1S+H3HhxwPfx+XNrhUNJAQDMi/mvfT52P1SMB/P4LoW6j/iQuJbGoBxAGnE
 JFhUHdJUk6ScgAfhyyx6IUqMuVfPVq39+kBBa8n66xVxxcgQMSyclX2D7wbSYg414xyJ/5vhD
 ZD4S761VaMXHinvxx922+pWL3wRTCSpZYUd+Cqr5ty6F77sefw+fTFK941w4tjPjg66qDfarT
 DhNCIAMPy5bXrs2/s93sQnspNgrXiVMIFk8nUgODj96tvWkzJG5Jz77WrBQbDyLvy/SpfE3eG
 gv2Ph5TMtOBRPGWaSiahsnBcwOgwo712SqNoLpVyB0mopG3Ud3rV6UHkiXfymsmlTPxYbyTor
 gB//ye4gwxrEa+fLqwDFenWmkC+Q5YzhJ9G6bKjfN2Dw2qEpX0enlzgFtAz6xtFXb89uGjG06
 HhUOQgPG4esGdL+1xyxMBphKO2og9dZc3JXOH6WyGEW3FI+gsAM3HqBpDrbynB3a4rp65LYlA
 MT1Knzq9LPZ7ZJaMNNRkTLGXp6xklro6d1ltsdtjA30e5tG+9JhFVH2fynCpjfYy/ETWcGrGr
 JFUi3cwuqwso1ORzFZvRSY8KGLJBEQuj33tHO6qywLDWVOrhhF/ksB6uX2e5bJSAUhoKa1L82
 9IMH5PyE7SRdplT0kRzQarfbGAzNjUn7nK0ZjFs3OnHSRaz3orNF4504yTCOYqE69gJicZAlV
 xgUGofzMhZXrUfIXsw7gx6pSzlaQZL6pGii+c2UTlDt1sSb1DgKZXmqy0umgn3KLJtwORt+kA
 X41QZ7ZKwPIetXnKd3irbz6JdbVgmmpNzIoRMlM2a2Lh5icm9CNu+vRE1uOea9oVuvcFEr3hF
 wFDMz8YmX1hFX7t7U2GP7td7Hsku1ngTjrjgI2PK17pRRRkp9GQxKD28w==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/29 =E4=B8=8B=E5=8D=882:34, Konstantin Svist wrote:
> On 8/28/21 16:30, Qu Wenruo wrote:
>>
>>
>> On 2021/8/29 =E4=B8=8A=E5=8D=887:16, Konstantin Svist wrote:
>>> On 8/27/21 23:16, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2021/8/28 =E4=B8=8B=E5=8D=881:57, Konstantin Svist wrote:
>>>>> On 8/20/21 19:56, Konstantin Svist wrote:
>>>>>> On 8/11/21 18:18, Qu Wenruo wrote:
>>>>>>>
>>>>>>> On 2021/8/12 =E4=B8=8A=E5=8D=886:34, Konstantin Svist wrote:
>>>>>>>> Shouldn't there be an earlier generation of this subvolume's tree
>>>>>>>> block
>>>>>>>> somewhere on the disk? Would all of them have gotten overwritten
>>>>>>>> already?
>>>>>>> Then it will be more complex and I can't ensure any good result.
>>>>>>
>>>>>> It was already pretty complex and results were never guaranteed :)
>>>>>>
>>>>>>
>>>>>>> Firstly you need to find an older root tree:
>>>>>>>
>>>>>>> # btrfs ins dump-super -f /dev/sdb3 | grep backup_tree_root
>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 backup_tree_root:=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 30687232=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g=
en: 2317
>>>>>>>  =C2=A0=C2=A0=C2=A0level: 0
>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 backup_tree_root:=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 30834688=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g=
en: 2318
>>>>>>>  =C2=A0=C2=A0=C2=A0level: 0
>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 backup_tree_root:=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 30408704=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g=
en: 2319
>>>>>>>  =C2=A0=C2=A0=C2=A0level: 0
>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 backup_tree_root:=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 31031296=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g=
en: 2316
>>>>>>>  =C2=A0=C2=A0=C2=A0level: 0
>>>>>>>
>>>>>>> Then try the bytenr in their reverse generation order in btrfs ins
>>>>>>> dump-tree:
>>>>>>> (The latest one should be the current root, thus you can skip it)
>>>>>>>
>>>>>>> # btrfs ins dump-tree -b 30834688 /dev/sdb3 | grep "(257 ROOT_ITEM=
"
>>>>>>> -A 5
>>>>>>>
>>>>>>> Then grab the bytenr of the subvolume 257, then pass the bytenr to
>>>>>>> btrfs-restore:
>>>>>>>
>>>>>>> # btrfs-restore -f <bytenr> /dev/sdb3 <restore_path>
>>>>>>>
>>>>>>> The chance is already pretty low, good luck.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Qu
>>>>>>
>>>>>>
>>>>>> When I run dump-tree, I get this:
>>>>>>
>>>>>> # btrfs ins dump-tree -b 787070976 /dev/sdb3 | grep "(257 ROOT_ITEM=
"
>>>>>> -A 5
>>>>>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found
>>>>>> 0xc375d6b6
>>>>>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found
>>>>>> 0xc375d6b6
>>>>>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found
>>>>>> 0xc375d6b6
>>>>>> Csum didn't match
>>>>>> WARNING: could not setup extent tree, skipping it
>>>>>>
>>>>>> The same exact offset fails checksum for all 4 backup roots, any wa=
y
>>>>>> around this?
>>>>
>>>> When without the grep, is there any output?
>>>
>>>
>>> # btrfs ins dump-tree -b 787070976 /dev/sdb3
>>> btrfs-progs v5.13.1
>>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
>>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
>>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
>>> Csum didn't match
>>> WARNING: could not setup extent tree, skipping it
>>> node 787070976 level 1 items 7 free space 486 generation 166932 owner
>>> ROOT_TREE
>>> node 787070976 flags 0x1(WRITTEN) backref revision 1
>>> fs uuid 44a768e0-28ba-4c6a-8eef-18ffa8c27d1b
>>> chunk uuid a8a06213-eebf-40d8-ab1a-914f621fbe1c
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 key (EXTENT_TREE ROOT_ITEM 0) block 78708736=
0 gen 166932
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 key (277 INODE_ITEM 0) block 197491195904 ge=
n 56511
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 key (305 INODE_ITEM 0) block 778174464 gen 1=
66929
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 key (366 EXTENT_DATA 0) block 197491949568 g=
en 56511
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 key (428 INODE_ITEM 0) block 36175872 gen 16=
6829
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 key (476 INODE_ITEM 0) block 787234816 gen 1=
66932
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 key (FREE_SPACE UNTYPED 99888398336) block 7=
80812288 gen 166929
>>
>> My bad, I forgot to add "--follow" option for "btrfs ins dump-tree"
>>
>> So the full command is:
>>
>> $ btrfs ins dump-tree -b 787070976 --follow /dev/sdb3
>>
>> Then you should be able to find "(257 ROOT_ITEM".
>>
>
> # btrfs ins dump-tree -b 787070976 --follow /dev/sdb3 | grep "(257
> ROOT_ITEM" -A 5
> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
> Csum didn't match
> WARNING: could not setup extent tree, skipping it
>  =C2=A0=C2=A0=C2=A0 item 13 key (257 ROOT_ITEM 0) itemoff 13147 itemsize=
 439
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 generation 166932 root_dirid 256 =
bytenr 786726912 level 2 refs 1
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 lastsnap 56690 byte_limit 0 bytes=
_used 1013104640 flags 0x0(none)
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 uuid 1ac60d28-6f11-2842-aca2-b157=
4b108336
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ctransid 166932 otransid 8 strans=
id 0 rtransid 0
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ctime 1627959592.718936423 (2021-=
08-02 19:59:52)
>
>
> # btrfs restore -Divf 786726912 /dev/sdb3 .
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

This all zero means the data on-disk are wiped.

Either not reaching disk or discarded.

Neither is a good thing.

>
>
> 1st set of "checksum verify failed" has different addresses, but the
> last set always has 920748032

Have you tried other bytenrs from find-root?

Thanks,
Qu
>
>
