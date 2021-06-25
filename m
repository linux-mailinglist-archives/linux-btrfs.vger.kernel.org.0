Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE6C3B3C46
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jun 2021 07:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhFYFjD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Jun 2021 01:39:03 -0400
Received: from mout.gmx.net ([212.227.15.15]:60743 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229458AbhFYFjD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Jun 2021 01:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624599397;
        bh=E4K3bWc0ixVzCT8ENyrUS4++imhe4PerIdlyM0Yfe6g=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=RlhNZjb6m3pg2l/9dOYMqc+sWqUD75ol3ILYfh4XUwQySTUthE850CIy6UW/psW4g
         CEAtt0yfo7fbDpYCYq+MIA1RyBoxa5xGdf+o3+AnZltTqDLWPaae1fdzh7DVMGHffM
         PL+bIDrQyOCF/vkJgct+ZVhnBRXYlBhkoSlZ9Zyo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MAwXr-1m7Kge0MS9-00BHFs; Fri, 25
 Jun 2021 07:36:37 +0200
Subject: Re: [question] free space of disk with btrfs is too different from
 other du
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Zhenyu Wu <wuzy001@gmail.com>
Cc:     Graham Cobb <g.btrfs@cobb.uk.net>, Su Yue <l@damenly.su>,
        linux-btrfs@vger.kernel.org
References: <CAJ9tZB_kPgZCsBaoOV93G9UCabdPifUxks+RH0e6RUycJ5wMCA@mail.gmail.com>
 <bl7yotou.fsf@damenly.su>
 <CAJ9tZB9M=KOWVLH_azagtBnxDzpV2=ssnBcYsJx6Ao8cQOELhg@mail.gmail.com>
 <5yy5orgi.fsf@damenly.su>
 <CAJ9tZB8UjSYCmvLRJ19zyKWyXD=Qp1Am0mFPc=dY8QRgMxcPiA@mail.gmail.com>
 <900f5c2c-9058-54d4-bdc8-a32c37dd8bdc@gmx.com>
 <93eeea80-a5af-fc14-ec71-e111d801eff4@gmx.com>
 <CAJ9tZB8Y+yNoTQmEjuV3f9QL05+=abJ-Ue4m7iRkxAC0NDhTFw@mail.gmail.com>
 <3670289c-19fb-482f-d2ca-3c84eb5decbe@cobb.uk.net>
 <CAJ9tZB-7ogKcPCF=r72jJ3pvZLD3h6VfQbks-pfkB5N_yhJzTg@mail.gmail.com>
 <93bc4428-467f-9a08-0dbf-1fae8cec42dd@gmx.com>
 <CAJ9tZB9Zpnmkg-QTcVCHYKt8e5w4fBseZkJPGUT4wrH2zHokTg@mail.gmail.com>
 <c14fd9c7-3d4c-0498-de76-56025fe2f37b@gmx.com>
 <CAJ9tZB_35KKsBjXQ+qiDPv=2ffpsJnUH8JaBvp5MP3gUwVXK-A@mail.gmail.com>
 <e3df9e2f-7ae6-c3cd-766f-c881f965846b@gmx.com>
 <f139fbe5-1ac2-54b9-c57b-2c93724cd2e2@gmx.com>
 <265bee57-2d24-9415-fcfc-f0ddcee68eda@gmx.com>
Message-ID: <65c221d1-86cf-1084-4d6c-bdfe717c494a@gmx.com>
Date:   Fri, 25 Jun 2021 13:36:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <265bee57-2d24-9415-fcfc-f0ddcee68eda@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Zbt7VeqiycHpZ3rxtFleRlx6lNz+vOnliWFh6rhLlNl5hwZaNYh
 PjfF3LnfaX+dUHG6f02xk2G6Ub8VCza/CvivZg8xlvquH8cE7SLyiPbJcDkjh+FKQdx9deg
 wqL4WwB5wEcASwZGmcdK0y5eIvBbBvcojG6HGwg/adneJeijQ2EUiCYLjzWOzwRl5JbVEEm
 av0Fd5/vcIl1K2K8s7Yig==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:S8lftGk+zdE=:l0BOTGGjlRIKuTAJZDBfZ8
 YFr4fP5TPGrEJioCL8ztY+k6Dst0Dsap5jtKXzPA2v+eBoRV+PA78tyHxvjKvsrfFZgRgxO4n
 RmtjbifuIRG37BTfgJW8MIdQEO8FdsUuF4lQniZHmO6VjNdA0o/ZZ3rv40XzvfxhYnp7V0Edv
 +REqLg2D9dsF5dzxHoY5LTQHHEYxdGZDUq460RFlI+gNC8pXsDrf0aQvyt3RjL6AZ73sfQo4V
 EFaQ0TAOOtKSapfyNRdeuLd/XrBb4/OyOw/yz0fpXr+stYL+atF6plhqI7n+C5dmHGCFSNj+x
 GMmvxIi8Myu+bYj/7e7RwSRBrkqbzgwww5kz+U+yWJ4EnHSCFX2115DQ2nu77hK9EHAr3pXx9
 fc8lEMWNk5D6rglRYV31+irRpVQwF3jVwndCwqCkh0EhnlsAalA2sT9vAIkHY2nB+FGzo8jKc
 07qeYoYQyg/Msh1fX8ANU+aWyJXvwLG2JwhSwwD1bM6rWf9XAEDrd37USwMjLwxm+7I44MBCr
 QaZOzOMycXJvUQRtQLMoUk93EgnWcMYY7T4RpJZHW+6rxQbUblXo1NkpQh7Ok2x6DVbWQ7Ujl
 NH1R7MsU1iVMj3ck2H69sBcbI/pkst40uTv9G/ZnziAVQCY6r7W/BhXffrikiYAzPeYDxunv+
 njYkXDgJg+C7GtcFnHDVzP2ApQ4uMY+qkiamUWqQVV9m97g3g1ZMBks+YQGMTZ6QXhaE9WVnN
 3tq+n8Iw8ZSGcQKmzbmt0QDhMcgG4XKN65AKGqVwRw++VBlM3FmT+J0mLLCuuJAf3+ub28tzu
 iJ1sE5lVuXcE9KriI7Ukes+FieDqWkHV2iCU5H0CVNqxb5EdG2EFIkBCaMIIBoGAgZ9fb4i/e
 FSXiIlNB7gQX9JA/UxVptxLSZpHrMOc6Iig1QDksJ889svlwlFwk00FGMRmQ4uLXGz9i3+TVm
 qZt8y8MhtVr1aWgsiBlYSlyvv27dNtqVcyykUR50ziqLa7QxHJIegfksYR2UH4Mywpc1M9DC+
 kGSlFR+juIsfzEjm2sHzW32o250zXZgpDGGF+cKPlMhc2sGoh6r+O7odUHq2SMsWFZLDuPUvT
 fVLDoBZDmJh1zKj1Sjui80gbIc/jhCNQ8Y/Wt18SRSqpWw17l5fECBkFQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/25 =E4=B8=8B=E5=8D=881:28, Qu Wenruo wrote:
>
>
> On 2021/6/25 =E4=B8=8A=E5=8D=888:59, Qu Wenruo wrote:
>>
>>
>> On 2021/6/25 =E4=B8=8A=E5=8D=887:46, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/6/24 =E4=B8=8B=E5=8D=8810:38, Zhenyu Wu wrote:
>>>> ```
>>>> $ btrfs ins dump-tree -t data_reloc
>>>> btrfs-progs v5.10.1
>>>> data reloc tree key (DATA_RELOC_TREE ROOT_ITEM 0)
>>>> leaf 57458688 items 2 free space 16061 generation 941500 owner
>>>> DATA_RELOC_TREE
>>>> leaf 57458688 flags 0x1(WRITTEN) backref revision 1
>>>> fs uuid 644a9e91-5e05-4f5d-a79b-e0eccd21a1a8
>>>> chunk uuid fa782e34-63ae-4917-ac63-bbbe56851d8b
>>>> item 0 key (256 INODE_ITEM 0) itemoff 16123 itemsize 160
>>>> generation 3 transid 0 size 0 nbytes 16384
>>>> block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
>>>> sequence 0 flags 0x0(none)
>>>> atime 1579910090.0 (2020-01-24 23:54:50)
>>>> ctime 1579910090.0 (2020-01-24 23:54:50)
>>>> mtime 1579910090.0 (2020-01-24 23:54:50)
>>>> otime 1579910090.0 (2020-01-24 23:54:50)
>>>> item 1 key (256 INODE_REF 256) itemoff 16111 itemsize 12
>>>> index 0 namelen 2 name: ..
>>>> total bytes 499972575232
>>>> bytes used 466593501184
>>>> uuid 644a9e91-5e05-4f5d-a79b-e0eccd21a1a8
>>>> $ btrfs ins dump-tree -t root 2>&1|tee root.txt
>>>> # attachment
>>>
>>> This explains everything!
>>>
>>> There are 58 root items! Meaning all of those snapshots are still taki=
ng
>>> space.
>>>
>>> Furthermore, all those roots have no backref, meaning it's already
>>> unlinked from the fs, thus btrfs subvolume list won't list them.
>>>
>>> For the worst part, they also have no orphan item marking them to be
>>> deleted.
>>> Thus they all become real ghost subvolumes.
>>>
>>> And since qgroup rescan only create subvolumes based on its ROOT_REF_K=
EY
>>> to create 0 level qgroups, all these ghost snapshots are not created,
>>> causing the super weird result.
>>>
>>> I have no idea why this could happen, need to dig further into the cod=
e.
>>
>> A quick glance into the code, and it seems that for such ghost
>> subvolumes, "btrfs subv delete -i" may not work.
>>
>> For that case, I'll craft you a special btrfs-progs branch so that we
>> can add orphan items for those ghost roots and let them go for good.
>>
>> Thus if above "delete -i" doesn't work, please prepare a liveUSB in
>> which you can compile btrfs-progs.
>
> Here you go, please use the branch of btrfs-progs in LiveUSB:
>
> https://github.com/adam900710/btrfs-progs/tree/dirty_fixes

Forgot to mention, I have tested the tool locally without problem.

But even if the tool crashes by somehow, it shouldn't change any thing
of your fs, so feel free to use it.

After digging into the kernel code, kernel will just drop snapshots one
by one, thus the limit is not really needed.

You can change the line of "u64 orphan_roots[4] =3D { 0 };" to
"u64 orphan_roots[64] =3D { 0 }", which will cover all your ghosts roots
in one go.

For the formal fix, I'll enhance btrfs-check to detect and fix the
problem soon, but I'm afraid you have to use the dirty fix branch for now.

Thanks,
Qu
>
> It enhances btrfs-progs/btrfs-corrupt-block command (I know it's scary,
> but trust me, I make the extra option to be extra safe).
>
> Now in your liveUSB, make sure your fs is not mounted first.
>
> Then go the following loop:
>
> # ./btrfs-corrupt-block -X <device>
>
> It will output which roots are ghosts and will add back orphan items for
> them.
>
> # mount <device> <mnt>
>
> # btrfs subv sync <mnt>
>
> It will wait for the 4 subvolumes to be deleted.
>
> # umount <mnt>
>
> Then go back to "corrupt-block -X" command and continue.
> I made the command to only add orphans to at most 4 subvolumes, to make
> sure we won't trigger too many deletions at the same time.
>
> If you don't want above loop (you need to go at least 15 loops), nor
> want to craft a small script to do that, I can change the code to do all
> of them in one go, but I'm not sure if it's OK for the kernel to handle
> so many orphan roots.
>
> BTW, since you have qgroup enabled, it will make subvolume deletion
> pretty slow, it's recommended to disable qgroup first. >
> Thanks,
> Qu
>>
>> Thanks,
>> Qu
>>>
>>> But for now, you can try to delete all these 58 subvolumes by their
>>> subvolume ID.
>>>
>>> You can try this as a quick test:
>>>
>>> # btrfs subv delete -i 6317 <mnt>
>>> # btrfs subv sync <mnt>
>>>
>>> Then check if you still have "6317 ROOT_ITEM" in your root tree dump.
>>>
>>> If it's gone, repeat the process for all roots, I have extracted the
>>> root list and attached, so that you can craft a bash script to delete
>>> all of them.
>>> (Note that above "subv sync" is not needed for each deletion if you wa=
nt
>>> to delete them in a batch)
>>>
>>> Thanks,
>>> Qu
>>>
>>>> $ btrfs ins dump-tree -t extent 2>&1|tee extent.txt
>>>> # it's too large, i'll upload it to a cloud disk
>>>> ```
>>>>
>>>> thanks!
>>>>
>>>>
>>>>
>>>> On Thu, Jun 24, 2021 at 8:30 PM Qu Wenruo <quwenruo.btrfs@gmx.com>
>>>> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 2021/6/24 =E4=B8=8B=E5=8D=887:33, Zhenyu Wu wrote:
>>>>>> the output has changed. do i need `btrfs ins dump-tree -t root`?
>>>>>> ```
>>>>>> $ sudo btrfs quota disable /
>>>>>> $ sudo btrfs quota enable /
>>>>>> $ sudo btrfs quota rescan -w /
>>>>>> # after 22m11s
>>>>>> $ sudo btrfs qgroup show -pcre /
>>>>>> qgroupid=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rfer=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 excl=C2=A0=C2=A0=C2=A0=C2=A0 ma=
x_rfer=C2=A0=C2=A0=C2=A0=C2=A0 max_excl parent
>>>>>> child
>>>>>> --------=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ----=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ----=C2=A0=C2=A0=C2=A0=C2=A0 --=
------=C2=A0=C2=A0=C2=A0=C2=A0 -------- ------
>>>>>> -----
>>>>>> 0/5=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 81.23GiB=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.90GiB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 none=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 none ---
>>>>>> ---
>>>>>> ```
>>>>>> thanks!
>>>>>
>>>>> Yes, dump tree output for both root and data_reloc is needed.
>>>>>
>>>>> There may be a larger dump needed, "btrfs ins dump-tree -t extent
>>>>> <device>", as I guess there is some ghost trees not properly
>>>>> deleted at
>>>>> all...
>>>>>
>>>>> The whole thing is going crazy now.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>>
>>>>>> On Thu, Jun 24, 2021 at 6:07 PM Qu Wenruo <quwenruo.btrfs@gmx.com>
>>>>>> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 2021/6/24 =E4=B8=8B=E5=8D=885:52, Zhenyu Wu wrote:
>>>>>>>> i have rescan quota but it looks like nothing change...
>>>>>>>> ```
>>>>>>>> $ sudo btrfs quota rescan -w /
>>>>>>>> quota rescan started
>>>>>>>> # after 8m39s
>>>>>>>> $ sudo btrfs qgroup show -pcre /
>>>>>>>> qgroupid=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rfer=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 excl=C2=A0=C2=A0=C2=A0=C2=A0=
 max_rfer=C2=A0=C2=A0=C2=A0=C2=A0 max_excl
>>>>>>>> parent=C2=A0=C2=A0 child
>>>>>>>> --------=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ----=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ----=C2=A0=C2=A0=C2=A0=C2=A0=
 --------=C2=A0=C2=A0=C2=A0=C2=A0 --------
>>>>>>>> ------=C2=A0=C2=A0 -----
>>>>>>>> 0/5=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 81.23Gi=
B=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.89GiB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 none=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 none
>>>>>>>> ---=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ---
>>>>>>>> 0/265=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 0.00B=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 none=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 none
>>>>>>>> ---=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ---
>>>>>>>> 0/266=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 0.00B=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 none=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 none
>>>>>>>> ---=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ---
>>>>>>>> 0/267=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 0.00B=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 none=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 none
>>>>>>>> ---=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ---
>>>>>>>> 0/6482=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00=
B=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 none=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 none
>>>>>>>> ---=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ---
>>>>>>>> 0/7501=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16.00KiB=C2=A0=C2=A0=
=C2=A0=C2=A0 16.00KiB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 none=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 none
>>>>>>>> ---=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ---
>>>>>>>> 0/7502=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16.00KiB=C2=A0=C2=A0=
=C2=A0=C2=A0 16.00KiB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 none=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 none
>>>>>>>> 255/7502 ---
>>>>>>>> 0/7503=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16.00KiB=C2=A0=C2=A0=
=C2=A0=C2=A0 16.00KiB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 none=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 none
>>>>>>>> 255/7503 ---
>>>>>>>
>>>>>>> This is now getting super weird now.
>>>>>>>
>>>>>>> Firstly, if there are some snapshots of subvolume 5, it should
>>>>>>> show up
>>>>>>> here, with size over several GiB.
>>>>>>>
>>>>>>> Thus there seems to be some ghost/hidden subvolumes that even don'=
t
>>>>>>> show
>>>>>>> up in qgroup.
>>>>>>>
>>>>>>> It's possible that some qgroup is intentionally deleted, thus not
>>>>>>> being
>>>>>>> properly updated.
>>>>>>>
>>>>>>> For that case, you may want to disable qgroup, re-enable, then do =
a
>>>>>>> rescan: (Can all be done on the running system)
>>>>>>>
>>>>>>> # btrfs quota disable <mnt>
>>>>>>> # btrfs quota enable <mnt>
>>>>>>> # btrfs quota rescan -w <mnt>
>>>>>>>
>>>>>>> Then provide the output of 'btrfs qgroup show -prce <mnt>"
>>>>>>>
>>>>>>> If the output doesn't change at all, after the full 10min rescan,
>>>>>>> then I
>>>>>>> guess you have to dump the root tree, along with the data_reloc
>>>>>>> tree.
>>>>>>>
>>>>>>> # btrfs ins dump-tree -t root <device>
>>>>>>> # btrfs ins dump-tree -t data_reloc <device>
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Qu
>>>>>>>> 1/0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 none=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 none
>>>>>>>> ---=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ---
>>>>>>>> 255/7502=C2=A0=C2=A0=C2=A0=C2=A0 16.00KiB=C2=A0=C2=A0=C2=A0=C2=A0=
 16.00KiB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 none=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 none
>>>>>>>> ---=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0/7502
>>>>>>>> 255/7503=C2=A0=C2=A0=C2=A0=C2=A0 16.00KiB=C2=A0=C2=A0=C2=A0=C2=A0=
 16.00KiB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 none=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 none
>>>>>>>> ---=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0/7503
>>>>>>>> ```
>>>>>>>>
>>>>>>>> and i try to mount with option subvolid:
>>>>>>>> ```
>>>>>>>> $ mkdir /tmp/fulldisk
>>>>>>>> $ sudo mount -o subvolid=3D5 /dev/sda2 /tmp/fulldisk
>>>>>>>> $ ls -lA /tmp/fulldisk
>>>>>>>> total 4
>>>>>>>> drwxr-xr-x 1 root=C2=A0=C2=A0 root=C2=A0=C2=A0 1936 May=C2=A0 3 2=
1:34 bin
>>>>>>>> drwxr-xr-x 1 root=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
0 Jan 25=C2=A0 2020 boot
>>>>>>>> drwxr-xr-x 1 root=C2=A0=C2=A0 root=C2=A0=C2=A0 1686 Jan 20=C2=A0 =
2020 dev
>>>>>>>> drwxr-xr-x 1 wzy=C2=A0=C2=A0=C2=A0 wzy=C2=A0=C2=A0=C2=A0 5756 Jun=
 24 13:51 etc
>>>>>>>> drwxr-xr-x 1 root=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 22 Oct=
 17=C2=A0 2020 home
>>>>>>>> drwxr-xr-x 1 root=C2=A0=C2=A0 root=C2=A0=C2=A0 1332 May 18 14:13 =
lib
>>>>>>>> drwxr-xr-x 1 root=C2=A0=C2=A0 root=C2=A0=C2=A0 6606 May 18 14:13 =
lib64
>>>>>>>> lrwxrwxrwx 1 root=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 10 Jan=
 24 20:23 media -> /run/media
>>>>>>>> drwxr-xr-x 1 wzy=C2=A0=C2=A0=C2=A0 wzy=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 38 Jan 27 16:51 mnt
>>>>>>>> drwxr-xr-x 1 root=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0 234 Jun 18 1=
4:29 opt
>>>>>>>> drwxr-xr-x 1 root=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
0 Jan 20=C2=A0 2020 proc
>>>>>>>> drwx------ 1 wzy=C2=A0=C2=A0=C2=A0 wzy=C2=A0=C2=A0=C2=A0=C2=A0 53=
6 Jun 15 20:26 root
>>>>>>>> drwxr-xr-x 1 root=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 48 May=
 30 14:14 run
>>>>>>>> drwxr-xr-x 1 root=C2=A0=C2=A0 root=C2=A0=C2=A0 4926 May 18 14:12 =
sbin
>>>>>>>> drwxr-xr-x 1 root=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 10 Jan=
 20=C2=A0 2020 sys
>>>>>>>> drwxrwxrwx 1 nobody nobody=C2=A0=C2=A0=C2=A0 0 Jun 18 14:34 tftpr=
oot
>>>>>>>> drwxrwxrwt 1 root=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
0 May 30 14:25 tmp
>>>>>>>> drwxr-xr-x 1 root=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0 198 Mar 31 1=
9:32 usr
>>>>>>>> drwxr-xr-x 1 root=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0 150 Apr=C2=
=A0 1 18:21 var
>>>>>>>> $ sudo btrfs fi du -s /tmp/fulldisk/*
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total=C2=A0=C2=A0 Excl=
usive=C2=A0 Set shared=C2=A0 Filename
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 10.66MiB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0.00B=C2=A0=C2=A0=C2=A0 10.66MiB=C2=A0 /tmp/fulldisk/bin
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=
=A0 /tmp/fulldisk/boot
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=
=A0 /tmp/fulldisk/dev
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 33.34MiB=C2=A0=C2=A0=C2=A0 36.00KiB=C2=
=A0=C2=A0=C2=A0 33.30MiB=C2=A0 /tmp/fulldisk/etc
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 13.79GiB=C2=A0=C2=A0 784.05MiB=C2=A0=C2=
=A0=C2=A0 12.96GiB=C2=A0 /tmp/fulldisk/home
>>>>>>>> =C2=A0=C2=A0=C2=A0 922.28MiB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
0.00B=C2=A0=C2=A0 922.28MiB=C2=A0 /tmp/fulldisk/lib
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 23.11MiB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0.00B=C2=A0=C2=A0=C2=A0 23.11MiB=C2=A0 /tmp/fulldisk/lib64
>>>>>>>> ERROR: cannot check space of '/tmp/fulldisk/media': Inappropriate
>>>>>>>> ioctl for device
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=
=A0 /tmp/fulldisk/mnt
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 11.08GiB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0.00B=C2=A0=C2=A0=C2=A0 11.08GiB=C2=A0 /tmp/fulldisk/opt
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=
=A0 /tmp/fulldisk/proc
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 40.38MiB=C2=A0=C2=A0=C2=A0=C2=A0 4.35MiB=
=C2=A0=C2=A0=C2=A0 36.03MiB=C2=A0 /tmp/fulldisk/root
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=
=A0 /tmp/fulldisk/run
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 26.62MiB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0.00B=C2=A0=C2=A0=C2=A0 26.62MiB=C2=A0 /tmp/fulldisk/sbin
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=
=A0 /tmp/fulldisk/sys
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=
=A0 /tmp/fulldisk/tftproot
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=
=A0 /tmp/fulldisk/tmp
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 47.22GiB=C2=A0=C2=A0=C2=A0=C2=A0 1.03GiB=
=C2=A0=C2=A0=C2=A0 46.15GiB=C2=A0 /tmp/fulldisk/usr
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.80GiB=C2=A0=C2=A0=C2=A0=C2=A0 4.=
35GiB=C2=A0=C2=A0=C2=A0=C2=A0 1.45GiB=C2=A0 /tmp/fulldisk/var
>>>>>>>> ```
>>>>>>>>
>>>>>>>> because media is a symbolic link so the ERROR should be normal.
>>>>>>>> according to `btrfs fi du` it looks like i only use about 80GiB.
>>>>>>>> it is
>>>>>>>> too weird.
>>>>>>>> thanks!
>>>>>>>>
>>>>>>>> On Thu, Jun 24, 2021 at 4:32 PM Graham Cobb <g.btrfs@cobb.uk.net>
>>>>>>>> wrote:
>>>>>>>>>
>>>>>>>>> On 24/06/2021 08:45, Zhenyu Wu wrote:
>>>>>>>>>> Thanks! this is some information of some programs.
>>>>>>>>>> ```
>>>>>>>>>> # boot from liveUSB
>>>>>>>>>> $ btrfs check /dev/sda2
>>>>>>>>>> [1/7] checking root items
>>>>>>>>>> [2/7] checking extents
>>>>>>>>>> [3/7] checking free space cache
>>>>>>>>>> [4/7] checking fs roots
>>>>>>>>>> [5/7] checking only csums items (without verifying data)
>>>>>>>>>> [6/7] checking root refs
>>>>>>>>>> [7/7] checking quota groups
>>>>>>>>>> # after mount /dev/sda2 to /mnt/gentoo
>>>>>>>>>
>>>>>>>>> Did you do 'mount -o subvolid=3D5 /dev/sda2 /mnt/gentoo' to make
>>>>>>>>> sure you
>>>>>>>>> can see all subvolumes, not just the default subvolume? I guess =
it
>>>>>>>>> doesn't matter for quota, but it matters if you are using tools
>>>>>>>>> like du.
>>>>>>>>>
>>>>>>>>> You don't even need to use a liveUSB. On your normal mounted
>>>>>>>>> system you
>>>>>>>>> can do...
>>>>>>>>>
>>>>>>>>> mkdir /tmp/fulldisk
>>>>>>>>> mount -o subvolid=3D5 /dev/sda2 /tmp/fulldisk
>>>>>>>>> ls -lA /tmp/fulldisk
>>>>>>>>>
>>>>>>>>> to see if there are other subvolumes which are not visible in /
