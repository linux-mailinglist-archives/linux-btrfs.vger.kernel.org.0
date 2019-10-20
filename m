Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 935CADDE1B
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Oct 2019 12:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfJTK2f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Oct 2019 06:28:35 -0400
Received: from mout.gmx.net ([212.227.15.15]:41423 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbfJTK2f (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Oct 2019 06:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571567311;
        bh=wZmyzll/lKSvGAkgr+OkDJwg/NOSK4oAY9KSjPBky+o=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=A9hEuuL3utgMxQMzQEBlk4uCfAdOgHZP76jtm73h0wSKf4SG2/2aySV+tctn2Z/vX
         3vgRBkYcB3Gk7SPkOAeaFiO3uyMJffhNkeC2rTKrOkG7fzvLqVY5kUpkBNaI2j+W4P
         N+FWan4+EyIKRPlGoHK/RHyB0bxnnw59rvZoO+z0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M7b2d-1iNUxf1FG9-0085y0; Sun, 20
 Oct 2019 12:28:31 +0200
Subject: Re: first it froze, now the (btrfs) root fs won't mount ...
To:     Christian Pernegger <pernegger@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAKbQEqE7xN1q3byFL7-_pD=_pGJ0Vm9pj7d-g+rRgtONeH-GrA@mail.gmail.com>
 <CAKbQEqG35D_=8raTFH75-yCYoqH2OvpPEmpj2dxgo+PTc=cfhA@mail.gmail.com>
 <4608b644-0fa3-7212-af45-0f4eebfb0be9@gmx.com>
 <CAKbQEqG8Sb-5+wx4NMfjORc-XnCtytuoqRw4J9hk2Pj9BNY_9g@mail.gmail.com>
 <CAKbQEqGwYCB1N+MQVYLNVm5o10acOFAa_JyO8NefGZfVtdyVBQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <fe882b36-0f7b-5ad5-e62e-06def50acd30@gmx.com>
Date:   Sun, 20 Oct 2019 18:28:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAKbQEqGwYCB1N+MQVYLNVm5o10acOFAa_JyO8NefGZfVtdyVBQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qNgFYAgGeEZdC5Zwp0E2AWcR4SCJiPu7D"
X-Provags-ID: V03:K1:T5ULP01aTfchb+hSpWApY0zduuvEWy/uaEXH+MH7t9+iCIXGDlT
 12qfFB4KJVFy5mnaeeN+gnaMgw8MWf+AjHCAPdYmHf3AVr2m6oHUsQ4EBz9GvdgMvArmwrm
 T1evAL0Kpl9J0ZTEf5zgbH5pJiKkyukZ5rpwqJgH6E1lp79akIpFHy6n+zghvtkXnigdwKk
 xXKKNfH3tkN8zPcWEZPkA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:B3VMhxCsapo=:eq64ef26ZAWreJbFvYPxZW
 F9HXGjrqTdeIXWHOUjYazTu+kC6tk4fEfh1afPD+pvZu5gMJHHg1zsqDJK/nlQU0hgx4+uv8z
 YKqVqd6x1ZlalfDDLpi3yRFZvcocilWwTII3jmb6dLk0IXxkczCpBjCiRTyF3naNoVeuukqex
 8lCOP2uv3fD+03VvrQnZJ7v/itr4mrOrVw9n2tg1fVkFN1VcV9W5kTLMkDOpywYa4GLmoKI/m
 bUyhMNX1qPj7028GoRpYAmnmSBh3U7+CdRwGjdYO9r6n5k7SRtnCfTej5bbGGLEhUPGLPu+oM
 xx6b6Z7qfSFCKgaoAT/ccf6rpg1mBAtJ5kVipvw0Y6DzP9F88y4Y0OcOMQi/m1f/UdUCHw50a
 aXXa3VpoW7lhX4dBCXYXGtCzN/sYtaXCmf8YHRdF8kNiw2T9VpuZeTMll1D46WpXXq0pVccuU
 aBvVdpyeh7cEfBqNu4PTOyJiicRnAfCbkmkvC23pHnrqkZlCEU92iNlJyfI65PPBDLoLi4TF9
 VnhF4BxeRhXGNKoLrHobEwqf3GejbleLTpamX27Ysop8aj/gbVB9SB4Qo1WYIaYLjaBIuBflF
 4xTTKy5QakoPC+CkHR2+il9k4xXq+wb/HCANzU9Z8kvzhbnJz6saGlV8MxG/KfEqWrViv4ASE
 Jp8mVOWnViUicRLa4YtE9h2nXtBvBAKR4aNlhbOiua0hfEn4ymu+EnuBdGP1mEJupkR3wZNgT
 4SmHgkG6I6VhBINtJheIqwyhARFyi/JbEkHsB55+r73MfeKz/vOxA+f3dO0f7XbFwE/BcWllD
 +qblnmrO4tikgt3wglJeZrsQ/drE+KY8J+/A7Ust9So6RBbAQuM/aCbt6tKc35U8+v6zyJK6+
 C1zm8DRiFaJVse8XuVaSau6nsZOSB+Z6ykrwv3rF/4OBr1VtWdS7W6DGuh8RbAenL84exAni/
 gWHKHULrFdKdOsBYSVN4e7JQI6q3H00sc23LmXzTTpkCjIe5j+4zPviLdVcxI+ZvqTKO1X5uk
 g0v9JkQY0oki46TA35g+gw5WCmHVlSHJJe21/FsXRIdesHyeBdo0gV4OZALpH+MsPD+qxQgIR
 SAbiBbuMogXhxRhT5EyUNAdzh4+T0qAUAdk3Tg6Mfn/3Fa0fMD8ttezBi86gNyCxCLwf7FeeV
 R7QNiQ13Poyfgpkp/nGU1YjuReGgDhBcbwlwvuV5UlRB/q8eqJNNsiGvDcbtpbp6ONy5vx9D+
 Cfc34pr+6Q/OBiJeYtCizaIgN8c09U4ZU9P/Af+N90jdBIE7fzPqbJkqxeK4=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qNgFYAgGeEZdC5Zwp0E2AWcR4SCJiPu7D
Content-Type: multipart/mixed; boundary="9kUPHpI2E3bTxZC8gqdiVefZk2UmfnEE1"

--9kUPHpI2E3bTxZC8gqdiVefZk2UmfnEE1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/20 =E4=B8=8B=E5=8D=886:22, Christian Pernegger wrote:
> [Please CC me, I'm not on the list.]
>=20
> The current plan is to dump the whole NVMe with dd (ongoing ...) and
> experiment on that. Safer that way.
>=20
> Question: Can I work with the mounted backup image on the machine that
> also contains the original disc? I vaguely recall something about
> btrfs really not liking clones.

If your fs only contains one device (single fs on single device), then
you should be mostly fine.

Btrfs doesn't like clones because it needs to assemble multiple devices,
but for single device fs, it should be mostly OK.

Thanks,
Qu

>=20
> Cheers,
> Christian
>=20
>=20
> Am So., 20. Okt. 2019 um 09:41 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gm=
x.com>:
>>
>>
>>
>> On 2019/10/20 =E4=B8=8B=E5=8D=883:01, Christian Pernegger wrote:
>>> [Please CC me, I'm not on the list.]
>>>
>>> Good morning & thank you.
>>>
>>> Am So., 20. Okt. 2019 um 02:38 Uhr schrieb Qu Wenruo <quwenruo.btrfs@=
gmx.com>:
>>>> It looks like you're using eGPU and the thunderbolt 3 connection dis=
connect?
>>>> That would cause a kernel panic/hang or whatever.
>>>
>>> No, it's a Radeon VII in a Gigabyte X570 Aorus Master. The board has
>>> PCIe 4, otherwise nothing exotic.
>>
>> Since Radeon 7 doesn't support PCIe 4, they would just negotiate to us=
e
>> PCIE 3, thus really nothing exotic.
>>
>> Just a kernel bug in amdgpu.
>> But since you're already using Radeon 7, it's recommended to use newer=

>> kernel for latest drm updates.
>>
>>>
>>>>> [...]
>>>>> BTRFS error [...]: bad tree block start, want 284041084928 have 0
>>>>> BTRFS error [...]: failed to read block groups: -5
>>>>> BTRFS error [...]: open_ctree failed
>>> ["big number" filled in above]
>>>
>>>> This means some tree blocks didn't reach disk or just got wiped out.=

>>>> Are you using discard mount option?
>>>
>>> Not to my knowledge. As in, I didn't set "discard", as far as I can
>>> remember it didn't show up in mount output, but it's possible it's on=

>>> by default.
>>
>> Discard won't turn on by default IIRC.
>> So it's not discard related.
>>
>>>
>>>>> running btrfs check gives:
>>>>> checksum verify failed on 284041084928 found E4E3BDB6 wanted 000000=
00
>>>>> checksum verify failed on 284041084928 found E4E3BDB6 wanted 000000=
00
>>
>> This matches the kernel output, means that tree block doesn't reach di=
sk
>> at all.
>>
>>>>> bytenr mismatch, want=3D284041084928, have=3D0
>>>>> ERROR: cannot open filesystem.
>>> ["big number" and "8-digit hex" filled in above]
>>>
>>>> Again, some old tree blocks got wiped out.
>>>> BTW, you don't need to wipe the numbers, sometimes it help developer=
 to find some corner problem.
>>>
>>> I was just being lazy, sorry about that.
>>>
>>>> If it's the only problem, you can try this kernel branch to at least=
 do
>>>> a RO mount:
>>>> https://github.com/adam900710/linux/tree/rescue_options
>>>>
>>>> Then mount the fs with "rescue=3Dskipbg,ro" option.
>>>> If the bad tree block is the only problem, it should be able to moun=
t it.
>>>>
>>>> If that mount succeeded, and you can access all files, then it means=

>>>> only extent tree is corrupted, then you can try btrfs check
>>>> --init-extent-tree, there are some reports of --init-extent-tree fix=
ed
>>>> the problem.
>>>
>>> You wouldn't happen to know of a bootable rescue image that has this?=

>>
>> Archlinux iso at least has the latest btrfs-progs.
>> You can try that.
>>
>> The latest btrfs check is not that super dangerous compared to older
>> versions.
>> You can try --init-extent-tree, if it finishes it should give you a mo=
re
>> or less mountable fs.
>>
>> If it crashes, then it shouldn't cause extra damage, but still it's no=
t
>> 100% safe.
>>
>>
>> I'd recommend the following safer methods before trying --init-extent-=
tree:
>>
>> - Dump backup roots first:
>>   # btrfs ins dump-super -f <dev> | grep backup_treee_root
>>   Then grab all big numbers.
>>
>> - Try backup_extent_root numbers in btrfs check first
>>   # btrfs check -r <above big number> <dev>
>>   Use the number with highest generation first.
>>
>>   It's the equivalent of kernel usebackuproot mount option, but more
>>   control as you can try every backup and find which one can pass the
>>   extent tree failure.
>>
>>   If all backup fails to pass basic btrfs check, and all happen to hav=
e
>>   the same "wanted 00000000" then it means a big range of tree blocks
>>   get wiped out, not really related to btrfs but some hardware wipe.
>>
>>   If one can pass the initial mount and gives extra errors, then you c=
an
>>   add --repair to hope for a better chance to repair.
>>
>>> The affected machine obviously doesn't boot, getting the NVMe out
>>> requires dismantling the CPU cooler, and TBH, I haven't built a kerne=
l
>>> in ~15 years.
>>
>> The safest one is still that out-of-tree rescue patchset, especially
>> when we can't rule out other corruptions in other trees.
>> I should really push that patchset harder into mainline.
>>
>> Just another unrelated hardware recommend, since you're already using
>> Radeon 7 and X570 board, I guess using an AIO will make M.2 SSD more
>> accessible.
>>
>> Or keep the exotic tower cooler, and use an M.2 to PCIe adapter to mak=
e
>> your SSD more accessible, as CrossFire is already dead, I guess you ha=
ve
>> some free PCIE x4 slots.
>>
>>>
>>>> About the cause, either btrfs didn't write some tree blocks correctl=
y or
>>>> the NVMe doesn't implement FUA/FLUSH correctly (which I don't believ=
e is
>>>> the case).
>>>>
>>>> So it's recommended to update the kernel to 5.3 kernel.
>>>
>>> FWIW, it's a Samsung 970 Evo Plus.
>>
>> It doesn't look like a hardware problem, but I keep my conclusion unti=
l
>> you have tried all backup roots.
>>
>> Thanks,
>> Qu
>>
>>> TBH, I didn't expect to lose more than the last couple minutes of
>>> writes in such a crash, certainly not an unmountable filesystem. So
>>> I'd love to know what caused this so I can avoid it in future.> But
>>> first things first, have to get this thing up & running again ...
>>>
>>> Cheers,
>>> Christian
>>>
>>
>=20
> Am So., 20. Okt. 2019 um 12:11 Uhr schrieb Christian Pernegger
> <pernegger@gmail.com>:
>>
>> [Re-send, hit reply instead of reply-all by mistake. Please CC me, I'm=

>> not on the list.]
>>
>> Good morning & thank you.
>>
>> Am So., 20. Okt. 2019 um 02:38 Uhr schrieb Qu Wenruo <quwenruo.btrfs@g=
mx.com>:
>>> It looks like you're using eGPU and the thunderbolt 3 connection disc=
onnect?
>>> That would cause a kernel panic/hang or whatever.
>>
>> No, it's a Radeon VII in a Gigabyte X570 Aorus Master. The board has
>> PCIe 4, otherwise nothing exotic.
>>
>>>> [...]
>>>> BTRFS error [...]: bad tree block start, want 284041084928 have 0
>>>> BTRFS error [...]: failed to read block groups: -5
>>>> BTRFS error [...]: open_ctree failed
>> ["big number" filled in above]
>>
>>> This means some tree blocks didn't reach disk or just got wiped out.
>>> Are you using discard mount option?
>>
>> Not to my knowledge. As in, I didn't set "discard", as far as I can
>> remember it didn't show up in mount output, but it's possible it's on
>> by default.
>>
>>>> running btrfs check gives:
>>>> checksum verify failed on 284041084928 found E4E3BDB6 wanted 0000000=
0
>>>> checksum verify failed on 284041084928 found E4E3BDB6 wanted 0000000=
0
>>>> bytenr mismatch, want=3D284041084928, have=3D0
>>>> ERROR: cannot open filesystem.
>> ["big number" and "8-digit hex" filled in above]
>>
>>> Again, some old tree blocks got wiped out.
>>> BTW, you don't need to wipe the numbers, sometimes it help developer =
to find some corner problem.
>>
>> I was just being lazy, sorry about that.
>>
>>> If it's the only problem, you can try this kernel branch to at least =
do
>>> a RO mount:
>>> https://github.com/adam900710/linux/tree/rescue_options
>>>
>>> Then mount the fs with "rescue=3Dskipbg,ro" option.
>>> If the bad tree block is the only problem, it should be able to mount=
 it.
>>>
>>> If that mount succeeded, and you can access all files, then it means
>>> only extent tree is corrupted, then you can try btrfs check
>>> --init-extent-tree, there are some reports of --init-extent-tree fixe=
d
>>> the problem.
>>
>> You wouldn't happen to know of a bootable rescue image that has this?
>> The affected machine obviously doesn't boot, getting the NVMe out
>> requires dismantling the CPU cooler, and TBH, I haven't built a kernel=

>> in ~15 years.
>>
>>> About the cause, either btrfs didn't write some tree blocks correctly=
 or
>>> the NVMe doesn't implement FUA/FLUSH correctly (which I don't believe=
 is
>>> the case).
>>>
>>> So it's recommended to update the kernel to 5.3 kernel.
>>
>> FWIW, it's a Samsung 970 Evo Plus.
>> TBH, I didn't expect to lose more than the last couple minutes of
>> writes in such a crash, certainly not an unmountable filesystem. So
>> I'd love to know what caused this so I can avoid it in future. But
>> first things first, have to get this thing up & running again ...
>>
>> Cheers,
>> Christian
>>
>> Am So., 20. Okt. 2019 um 02:38 Uhr schrieb Qu Wenruo <quwenruo.btrfs@g=
mx.com>:
>>>
>>>
>>>
>>> On 2019/10/20 =E4=B8=8A=E5=8D=886:34, Christian Pernegger wrote:
>>>> [Please CC me, I'm not on the list.]
>>>>
>>>> Hello,
>>>>
>>>> I'm afraid I could use some help.
>>>>
>>>> The affected machine froze during a game, was entirely unresponsive
>>>> locally, though ssh still worked. For completeness' sake, dmesg had:=

>>>> [110592.128512] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring sdma=
0
>>>> timeout, signaled seq=3D3404070, emitted seq=3D3404071
>>>> [110592.128545] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process
>>>> information: process Xorg pid 1191 thread Xorg:cs0 pid 1204
>>>> [110592.128549] amdgpu 0000:0c:00.0: GPU reset begin!
>>>> [110592.138530] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx
>>>> timeout, signaled seq=3D13149116, emitted seq=3D13149118
>>>> [110592.138577] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process
>>>> information: process Overcooked.exe pid 4830 thread dxvk-submit pid
>>>> 4856
>>>> [110592.138579] amdgpu 0000:0c:00.0: GPU reset begin!
>>>
>>> It looks like you're using eGPU and the thunderbolt 3 connection disc=
onnect?
>>> That would cause a kernel panic/hang or whatever.
>>>
>>>>
>>>> Oh well, I thought, and "shutdown -h now" it. That quit my ssh sessi=
on
>>>> and locked me out, but otherwise didn't take, no reboot, still froze=
n.
>>>> Alt-SysRq-REISUB it was. That did it.
>>>>
>>>> Only now all I get is a rescue shell, the pertinent messages look to=

>>>> be [everything is copied off the screen by hand]:
>>>> [...]
>>>> BTRFS info [...]: disk space caching is enabled
>>>> BTRFS info [...]: has skinny extents
>>>> BTRFS error [...]: bad tree block start, want [big number] have 0
>>>> BTRFS error [...]: failed to read block groups: -5
>>>> BTRFS error [...]: open_ctree failed
>>>
>>> This means some tree blocks didn't reach disk or just got wiped out.
>>>
>>> Are you using discard mount option?
>>>
>>>>
>>>> Mounting with -o ro,usebackuproot doesn't change anything.
>>>>
>>>> running btrfs check gives:
>>>> checksum verify failed on [same big number] found [8 digits hex] wan=
ted 00000000
>>>> checksum verify failed on [same big number] found [8 digits hex] wan=
ted 00000000
>>>
>>> Again, some old tree blocks got wiped out.
>>>
>>> BTW, you don't need to wipe the numbers, sometimes it help developer =
to
>>> find some corner problem.
>>>
>>>> bytenr mismatch, want=3D[same big number], have=3D0
>>>> ERROR: cannot open filesystem.
>>>>
>>>> That's all I've got, I'd really appreciate some help. There's hourly=

>>>> snapshots courtesy of Timeshift, though I have a feeling those won't=

>>>> help ...
>>>
>>> If it's the only problem, you can try this kernel branch to at least =
do
>>> a RO mount:
>>> https://github.com/adam900710/linux/tree/rescue_options
>>>
>>> Then mount the fs with "rescue=3Dskipbg,ro" option.
>>> If the bad tree block is the only problem, it should be able to mount=
 it.
>>>
>>> If that mount succeeded, and you can access all files, then it means
>>> only extent tree is corrupted, then you can try btrfs check
>>> --init-extent-tree, there are some reports of --init-extent-tree fixe=
d
>>> the problem.
>>>
>>>>
>>>> Oh, it's a recent Linux Mint 19.2 install, default layout (@, @home)=
,
>>>> Timeshift enabled; on a single device (NVMe). HWE kernel (Kernel
>>>> 5.0.0-31-generic), btrfs-progs 4.15.1.
>>>
>>> About the cause, either btrfs didn't write some tree blocks correctly=
 or
>>> the NVMe doesn't implement FUA/FLUSH correctly (which I don't believe=
 is
>>> the case).
>>>
>>> So it's recommended to update the kernel to 5.3 kernel.
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> TIA,
>>>> Christian
>>>>
>>>


--9kUPHpI2E3bTxZC8gqdiVefZk2UmfnEE1--

--qNgFYAgGeEZdC5Zwp0E2AWcR4SCJiPu7D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2sNsoACgkQwj2R86El
/qgkwgf/VYopmA3/9sUviutYmSCTarRoJUWdnAqs7gxqQrJzgomzJO1RwYcsQC6F
Uj1Hh8C243uG+y2Ni6CZxARvjLHEnBPJo41DbRs5IwgFbjNYrB8JqWHxPws+5iTW
3gJeA/1l05yVZzovxILHa/OF0rZ7x1aW0HgB8KgkUgDwK29bCsTP7YfNSuf4ekUm
B00oFY/CPeikGyvDnqPz5DBkpw/loAIALXugFGhKndE8eBdHE19qFGTZh6bG7Yjl
SACNCpyeh5UnkEWiU00FiDkEv2HhagoyEN+brDyCG908tjcquD8gPpGgxkHY2YHr
wzgHW9vZof603vLnEuG0aZbUVeWR+w==
=n3LO
-----END PGP SIGNATURE-----

--qNgFYAgGeEZdC5Zwp0E2AWcR4SCJiPu7D--
