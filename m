Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B339B3B3A4A
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jun 2021 03:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhFYBCZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Jun 2021 21:02:25 -0400
Received: from mout.gmx.net ([212.227.15.15]:41941 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229521AbhFYBCZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Jun 2021 21:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624582799;
        bh=rMOhFIkIO8rKXfQ09ZWphS3I43TWEhBq/8SRUGy8hWg=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=jU3RRTOJc8t6Li2UigwzYYYilP+hikMB4uIuN++t84N2euhmg6vxnUGOLmnJbPJOB
         Y1Xc3WIWEvkhliQMeBGTwgamswE2iIGPeoSsvqI5gPFRFxI8f7ayYMkx4sefKI5TWt
         E4R6n7NroK80j8MuXZMcHfn/kQnXigpwiud1jAbY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mplc7-1lSj6R2VLx-00qE86; Fri, 25
 Jun 2021 02:59:59 +0200
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
Message-ID: <f139fbe5-1ac2-54b9-c57b-2c93724cd2e2@gmx.com>
Date:   Fri, 25 Jun 2021 08:59:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <e3df9e2f-7ae6-c3cd-766f-c881f965846b@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uRdCSxEu2bWyXZm2q2Hh3PjdJCaWs9OtZrpWR6pakOieACf+jrJ
 Eb4ab6b8P9OfS9Xw+KFGT+RQvD0WyxxhM5McQtgasdlXksVX5EAuZpZngwpG4or+s6RDX6L
 sjj0I0ir4pvgokg+aIbYuI1+GwF5OgWw5JX79Db2OkLIDiTBcoUdaINhA5gWmLs1rxRwzKj
 TttdmYx89934NFL86tmeg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wgjVNJzo3cw=:8tR01PZGgSI/2zq6QVCRip
 mX/rnIkfi1at1h7KbHkYVf00nFIrvuNnnRhl0DtE1iGRK0EHUeowkwuW3oS/1fuyQLGrIkH/t
 cCKJKnr8vgfXX/HFBj+5Q51Pe1FS+6ocENtZMX6MuU8D+5pPrkw0BLF6a588XMvxh8Wgqqu2h
 XZjHsOfFDLYoGD706y1uu7hKKlAlULNwYdjvNH/59HrxKor3d+ZZftH5W7//IXMH8SGlnpq1Q
 M6yH2PnNgrlub8BY9BdKQ/FHRbtv68liTeoz9XQpgj03+z24UGxrrdXeZpIjDR8lN58OxNJ5Y
 DI2CzG3X//xJT0JV6NGbJQahKCdSoxSPHn7DFM/r9BZw3mAlGqNZjb6tWDFxFky9R+rxGgwiN
 S/+0S5Ll+gLkY+8QRENe0EAzDDWQ23HziMnpmmlx+UF50W1mpOsYNV3C5NBXVDrlPvKxU2Ar0
 e9Cug4zTIVmG5V4F8viam7c8iNENfPJCzPEVEL8SpLigUu9uSFiVy9YFP5JTJKOp9O9MSyuvo
 Pn8jSxSoJ4dGO4xMFt22hGCMm99MWygAbTyM7tSswowL3t4+LnrjGz7Ht/mD/RiYweCwnWcN8
 5RGsjGs342p09Lt48JziNo/8yRlMVbmODx74B4IaoX7NEt+MlnmoyFN2+1BmsiQLID0+BoNfA
 bXblQz0oVSWvol/5P0yHpnP6eI5ke4ixjf7IoOBz/qvj5kopz4NLjw3N3ji7b+Yf6Opv7xDRB
 Maehj4wCgaEc8maec7sWHNpaCH0v5NVtw69ecr6tg77htNLc9smTC67nufldaGAjgvokCq/FO
 7+ts4yKMeNc8N5ilzEf2OWC+F1vq7TQ28pzXtWeigLUT6/MxaKMMc0IjGyxF8glTkpUdMhPbD
 aXHtqeSrTPRIF1NZahv5v4Jlw6lr1PkkUO8w4VstLzE6YmkAdUy1mWqA48SW9lF1XfASgYHo3
 EY7ZwPB4IzYF2Ppylg7LagVHTVjhHVqiGk3V7KkeqYw70Af61V6nECgyNO2fo06nle9jflTDG
 wR+QtqFoE+K2EeqR7Xk+zwfknQY7FHFSXDABBnpxbJFAIJnuEew+9WsrF/ZqXr8w8nP48HzvC
 IfEl2O9aJtmijwFggjba7E1U+vVGga6AqR6hbeTm2M0MwjupXFlYYCIAA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/25 =E4=B8=8A=E5=8D=887:46, Qu Wenruo wrote:
>
>
> On 2021/6/24 =E4=B8=8B=E5=8D=8810:38, Zhenyu Wu wrote:
>> ```
>> $ btrfs ins dump-tree -t data_reloc
>> btrfs-progs v5.10.1
>> data reloc tree key (DATA_RELOC_TREE ROOT_ITEM 0)
>> leaf 57458688 items 2 free space 16061 generation 941500 owner
>> DATA_RELOC_TREE
>> leaf 57458688 flags 0x1(WRITTEN) backref revision 1
>> fs uuid 644a9e91-5e05-4f5d-a79b-e0eccd21a1a8
>> chunk uuid fa782e34-63ae-4917-ac63-bbbe56851d8b
>> item 0 key (256 INODE_ITEM 0) itemoff 16123 itemsize 160
>> generation 3 transid 0 size 0 nbytes 16384
>> block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
>> sequence 0 flags 0x0(none)
>> atime 1579910090.0 (2020-01-24 23:54:50)
>> ctime 1579910090.0 (2020-01-24 23:54:50)
>> mtime 1579910090.0 (2020-01-24 23:54:50)
>> otime 1579910090.0 (2020-01-24 23:54:50)
>> item 1 key (256 INODE_REF 256) itemoff 16111 itemsize 12
>> index 0 namelen 2 name: ..
>> total bytes 499972575232
>> bytes used 466593501184
>> uuid 644a9e91-5e05-4f5d-a79b-e0eccd21a1a8
>> $ btrfs ins dump-tree -t root 2>&1|tee root.txt
>> # attachment
>
> This explains everything!
>
> There are 58 root items! Meaning all of those snapshots are still taking
> space.
>
> Furthermore, all those roots have no backref, meaning it's already
> unlinked from the fs, thus btrfs subvolume list won't list them.
>
> For the worst part, they also have no orphan item marking them to be
> deleted.
> Thus they all become real ghost subvolumes.
>
> And since qgroup rescan only create subvolumes based on its ROOT_REF_KEY
> to create 0 level qgroups, all these ghost snapshots are not created,
> causing the super weird result.
>
> I have no idea why this could happen, need to dig further into the code.

A quick glance into the code, and it seems that for such ghost
subvolumes, "btrfs subv delete -i" may not work.

For that case, I'll craft you a special btrfs-progs branch so that we
can add orphan items for those ghost roots and let them go for good.

Thus if above "delete -i" doesn't work, please prepare a liveUSB in
which you can compile btrfs-progs.

Thanks,
Qu
>
> But for now, you can try to delete all these 58 subvolumes by their
> subvolume ID.
>
> You can try this as a quick test:
>
> # btrfs subv delete -i 6317 <mnt>
> # btrfs subv sync <mnt>
>
> Then check if you still have "6317 ROOT_ITEM" in your root tree dump.
>
> If it's gone, repeat the process for all roots, I have extracted the
> root list and attached, so that you can craft a bash script to delete
> all of them.
> (Note that above "subv sync" is not needed for each deletion if you want
> to delete them in a batch)
>
> Thanks,
> Qu
>
>> $ btrfs ins dump-tree -t extent 2>&1|tee extent.txt
>> # it's too large, i'll upload it to a cloud disk
>> ```
>>
>> thanks!
>>
>>
>>
>> On Thu, Jun 24, 2021 at 8:30 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>>
>>>
>>>
>>> On 2021/6/24 =E4=B8=8B=E5=8D=887:33, Zhenyu Wu wrote:
>>>> the output has changed. do i need `btrfs ins dump-tree -t root`?
>>>> ```
>>>> $ sudo btrfs quota disable /
>>>> $ sudo btrfs quota enable /
>>>> $ sudo btrfs quota rescan -w /
>>>> # after 22m11s
>>>> $ sudo btrfs qgroup show -pcre /
>>>> qgroupid=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rfer=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 excl=C2=A0=C2=A0=C2=A0=C2=A0 ma=
x_rfer=C2=A0=C2=A0=C2=A0=C2=A0 max_excl parent
>>>> child
>>>> --------=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ----=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ----=C2=A0=C2=A0=C2=A0=C2=A0 --=
------=C2=A0=C2=A0=C2=A0=C2=A0 -------- ------
>>>> -----
>>>> 0/5=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 81.23GiB=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.90GiB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 none=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 none ---
>>>> ---
>>>> ```
>>>> thanks!
>>>
>>> Yes, dump tree output for both root and data_reloc is needed.
>>>
>>> There may be a larger dump needed, "btrfs ins dump-tree -t extent
>>> <device>", as I guess there is some ghost trees not properly deleted a=
t
>>> all...
>>>
>>> The whole thing is going crazy now.
>>>
>>> Thanks,
>>> Qu
>>>>
>>>> On Thu, Jun 24, 2021 at 6:07 PM Qu Wenruo <quwenruo.btrfs@gmx.com>
>>>> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 2021/6/24 =E4=B8=8B=E5=8D=885:52, Zhenyu Wu wrote:
>>>>>> i have rescan quota but it looks like nothing change...
>>>>>> ```
>>>>>> $ sudo btrfs quota rescan -w /
>>>>>> quota rescan started
>>>>>> # after 8m39s
>>>>>> $ sudo btrfs qgroup show -pcre /
>>>>>> qgroupid=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rfer=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 excl=C2=A0=C2=A0=C2=A0=C2=A0 ma=
x_rfer=C2=A0=C2=A0=C2=A0=C2=A0 max_excl
>>>>>> parent=C2=A0=C2=A0 child
>>>>>> --------=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ----=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ----=C2=A0=C2=A0=C2=A0=C2=A0 --=
------=C2=A0=C2=A0=C2=A0=C2=A0 --------
>>>>>> ------=C2=A0=C2=A0 -----
>>>>>> 0/5=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 81.23GiB=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.89GiB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 none=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 none
>>>>>> ---=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ---
>>>>>> 0/265=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=
.00B=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 none=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 none
>>>>>> ---=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ---
>>>>>> 0/266=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=
.00B=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 none=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 none
>>>>>> ---=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ---
>>>>>> 0/267=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=
.00B=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 none=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 none
>>>>>> ---=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ---
>>>>>> 0/6482=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 none=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 none
>>>>>> ---=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ---
>>>>>> 0/7501=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16.00KiB=C2=A0=C2=A0=C2=
=A0=C2=A0 16.00KiB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 none=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 none
>>>>>> ---=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ---
>>>>>> 0/7502=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16.00KiB=C2=A0=C2=A0=C2=
=A0=C2=A0 16.00KiB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 none=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 none
>>>>>> 255/7502 ---
>>>>>> 0/7503=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16.00KiB=C2=A0=C2=A0=C2=
=A0=C2=A0 16.00KiB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 none=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 none
>>>>>> 255/7503 ---
>>>>>
>>>>> This is now getting super weird now.
>>>>>
>>>>> Firstly, if there are some snapshots of subvolume 5, it should show =
up
>>>>> here, with size over several GiB.
>>>>>
>>>>> Thus there seems to be some ghost/hidden subvolumes that even don't
>>>>> show
>>>>> up in qgroup.
>>>>>
>>>>> It's possible that some qgroup is intentionally deleted, thus not
>>>>> being
>>>>> properly updated.
>>>>>
>>>>> For that case, you may want to disable qgroup, re-enable, then do a
>>>>> rescan: (Can all be done on the running system)
>>>>>
>>>>> # btrfs quota disable <mnt>
>>>>> # btrfs quota enable <mnt>
>>>>> # btrfs quota rescan -w <mnt>
>>>>>
>>>>> Then provide the output of 'btrfs qgroup show -prce <mnt>"
>>>>>
>>>>> If the output doesn't change at all, after the full 10min rescan,
>>>>> then I
>>>>> guess you have to dump the root tree, along with the data_reloc tree=
.
>>>>>
>>>>> # btrfs ins dump-tree -t root <device>
>>>>> # btrfs ins dump-tree -t data_reloc <device>
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>> 1/0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 none=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 none
>>>>>> ---=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ---
>>>>>> 255/7502=C2=A0=C2=A0=C2=A0=C2=A0 16.00KiB=C2=A0=C2=A0=C2=A0=C2=A0 1=
6.00KiB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 none=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 none
>>>>>> ---=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0/7502
>>>>>> 255/7503=C2=A0=C2=A0=C2=A0=C2=A0 16.00KiB=C2=A0=C2=A0=C2=A0=C2=A0 1=
6.00KiB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 none=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 none
>>>>>> ---=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0/7503
>>>>>> ```
>>>>>>
>>>>>> and i try to mount with option subvolid:
>>>>>> ```
>>>>>> $ mkdir /tmp/fulldisk
>>>>>> $ sudo mount -o subvolid=3D5 /dev/sda2 /tmp/fulldisk
>>>>>> $ ls -lA /tmp/fulldisk
>>>>>> total 4
>>>>>> drwxr-xr-x 1 root=C2=A0=C2=A0 root=C2=A0=C2=A0 1936 May=C2=A0 3 21:=
34 bin
>>>>>> drwxr-xr-x 1 root=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 =
Jan 25=C2=A0 2020 boot
>>>>>> drwxr-xr-x 1 root=C2=A0=C2=A0 root=C2=A0=C2=A0 1686 Jan 20=C2=A0 20=
20 dev
>>>>>> drwxr-xr-x 1 wzy=C2=A0=C2=A0=C2=A0 wzy=C2=A0=C2=A0=C2=A0 5756 Jun 2=
4 13:51 etc
>>>>>> drwxr-xr-x 1 root=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 22 Oct 1=
7=C2=A0 2020 home
>>>>>> drwxr-xr-x 1 root=C2=A0=C2=A0 root=C2=A0=C2=A0 1332 May 18 14:13 li=
b
>>>>>> drwxr-xr-x 1 root=C2=A0=C2=A0 root=C2=A0=C2=A0 6606 May 18 14:13 li=
b64
>>>>>> lrwxrwxrwx 1 root=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 10 Jan 2=
4 20:23 media -> /run/media
>>>>>> drwxr-xr-x 1 wzy=C2=A0=C2=A0=C2=A0 wzy=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 38 Jan 27 16:51 mnt
>>>>>> drwxr-xr-x 1 root=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0 234 Jun 18 14:=
29 opt
>>>>>> drwxr-xr-x 1 root=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 =
Jan 20=C2=A0 2020 proc
>>>>>> drwx------ 1 wzy=C2=A0=C2=A0=C2=A0 wzy=C2=A0=C2=A0=C2=A0=C2=A0 536 =
Jun 15 20:26 root
>>>>>> drwxr-xr-x 1 root=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 48 May 3=
0 14:14 run
>>>>>> drwxr-xr-x 1 root=C2=A0=C2=A0 root=C2=A0=C2=A0 4926 May 18 14:12 sb=
in
>>>>>> drwxr-xr-x 1 root=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 10 Jan 2=
0=C2=A0 2020 sys
>>>>>> drwxrwxrwx 1 nobody nobody=C2=A0=C2=A0=C2=A0 0 Jun 18 14:34 tftproo=
t
>>>>>> drwxrwxrwt 1 root=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 =
May 30 14:25 tmp
>>>>>> drwxr-xr-x 1 root=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0 198 Mar 31 19:=
32 usr
>>>>>> drwxr-xr-x 1 root=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0 150 Apr=C2=A0 =
1 18:21 var
>>>>>> $ sudo btrfs fi du -s /tmp/fulldisk/*
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total=C2=A0=C2=A0 Exclus=
ive=C2=A0 Set shared=C2=A0 Filename
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 10.66MiB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0.00B=C2=A0=C2=A0=C2=A0 10.66MiB=C2=A0 /tmp/fulldisk/bin
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0 /=
tmp/fulldisk/boot
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0 /=
tmp/fulldisk/dev
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 33.34MiB=C2=A0=C2=A0=C2=A0 36.00KiB=C2=A0=
=C2=A0=C2=A0 33.30MiB=C2=A0 /tmp/fulldisk/etc
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 13.79GiB=C2=A0=C2=A0 784.05MiB=C2=A0=C2=A0=
=C2=A0 12.96GiB=C2=A0 /tmp/fulldisk/home
>>>>>> =C2=A0=C2=A0=C2=A0 922.28MiB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.=
00B=C2=A0=C2=A0 922.28MiB=C2=A0 /tmp/fulldisk/lib
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 23.11MiB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0.00B=C2=A0=C2=A0=C2=A0 23.11MiB=C2=A0 /tmp/fulldisk/lib64
>>>>>> ERROR: cannot check space of '/tmp/fulldisk/media': Inappropriate
>>>>>> ioctl for device
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0 /=
tmp/fulldisk/mnt
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 11.08GiB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0.00B=C2=A0=C2=A0=C2=A0 11.08GiB=C2=A0 /tmp/fulldisk/opt
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0 /=
tmp/fulldisk/proc
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 40.38MiB=C2=A0=C2=A0=C2=A0=C2=A0 4.35MiB=
=C2=A0=C2=A0=C2=A0 36.03MiB=C2=A0 /tmp/fulldisk/root
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0 /=
tmp/fulldisk/run
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 26.62MiB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0.00B=C2=A0=C2=A0=C2=A0 26.62MiB=C2=A0 /tmp/fulldisk/sbin
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0 /=
tmp/fulldisk/sys
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0 /=
tmp/fulldisk/tftproot
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0 /=
tmp/fulldisk/tmp
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 47.22GiB=C2=A0=C2=A0=C2=A0=C2=A0 1.03GiB=
=C2=A0=C2=A0=C2=A0 46.15GiB=C2=A0 /tmp/fulldisk/usr
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.80GiB=C2=A0=C2=A0=C2=A0=C2=A0 4.35=
GiB=C2=A0=C2=A0=C2=A0=C2=A0 1.45GiB=C2=A0 /tmp/fulldisk/var
>>>>>> ```
>>>>>>
>>>>>> because media is a symbolic link so the ERROR should be normal.
>>>>>> according to `btrfs fi du` it looks like i only use about 80GiB.
>>>>>> it is
>>>>>> too weird.
>>>>>> thanks!
>>>>>>
>>>>>> On Thu, Jun 24, 2021 at 4:32 PM Graham Cobb <g.btrfs@cobb.uk.net>
>>>>>> wrote:
>>>>>>>
>>>>>>> On 24/06/2021 08:45, Zhenyu Wu wrote:
>>>>>>>> Thanks! this is some information of some programs.
>>>>>>>> ```
>>>>>>>> # boot from liveUSB
>>>>>>>> $ btrfs check /dev/sda2
>>>>>>>> [1/7] checking root items
>>>>>>>> [2/7] checking extents
>>>>>>>> [3/7] checking free space cache
>>>>>>>> [4/7] checking fs roots
>>>>>>>> [5/7] checking only csums items (without verifying data)
>>>>>>>> [6/7] checking root refs
>>>>>>>> [7/7] checking quota groups
>>>>>>>> # after mount /dev/sda2 to /mnt/gentoo
>>>>>>>
>>>>>>> Did you do 'mount -o subvolid=3D5 /dev/sda2 /mnt/gentoo' to make
>>>>>>> sure you
>>>>>>> can see all subvolumes, not just the default subvolume? I guess it
>>>>>>> doesn't matter for quota, but it matters if you are using tools
>>>>>>> like du.
>>>>>>>
>>>>>>> You don't even need to use a liveUSB. On your normal mounted
>>>>>>> system you
>>>>>>> can do...
>>>>>>>
>>>>>>> mkdir /tmp/fulldisk
>>>>>>> mount -o subvolid=3D5 /dev/sda2 /tmp/fulldisk
>>>>>>> ls -lA /tmp/fulldisk
>>>>>>>
>>>>>>> to see if there are other subvolumes which are not visible in /
