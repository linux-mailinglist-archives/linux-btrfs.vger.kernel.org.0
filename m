Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C733F53F6
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 02:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbhHXAC2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 20:02:28 -0400
Received: from mout.gmx.net ([212.227.15.18]:58289 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233305AbhHXACY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 20:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629763292;
        bh=SRLhVo0+7qt/pHEuONZPrYDw21VCRlZhxK9zwD+5tgM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=LFAydwZyZCNnNHFUPj3AVLS1EWV6USuuPa1zYDytNZBN2UnkLhQ2p3XXHIIUEEZj1
         2zJG+esaUrBx5sUwmFJx5DiR6Fa70EqUCPB5IIA2nsbVotvBBmkqT+wobgkPp7PFsR
         ul4j+niHcfpr069W951W/hhVSH+y294X2+jGifdg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MKKZ3-1mbunU415r-00LqWT; Tue, 24
 Aug 2021 02:01:32 +0200
Subject: Re: [PATCH 6/9] btrfs-progs: add the block group item in make_btrfs()
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1629486429.git.josef@toxicpanda.com>
 <d433af292d5e99ff194bc6362133e64704ecd006.1629486429.git.josef@toxicpanda.com>
 <72de3cea-aee0-a7e4-d585-bf9ea749e53b@gmx.com>
 <080b9285-9af0-0f51-4b3e-e9f357004920@toxicpanda.com>
 <f1c7b1c0-04cb-48ad-c728-5fc5429d7001@gmx.com>
 <66c5ecee-9f4f-0980-18d2-f1053952ee99@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <43f75a60-1429-00c8-8509-71c037619688@gmx.com>
Date:   Tue, 24 Aug 2021 08:01:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <66c5ecee-9f4f-0980-18d2-f1053952ee99@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rP+g0uhE4A3BBv7yGDgwd1+7MhTbsIBFjBMn3eKaz3WksmvZwMB
 fNrh0a1kZpHxYzZzVv5HbJTr9MFtUOrkYwdmJU68LLIVAcBpsZMXCwbd8xn34tXZS4Ft4bq
 n5lDmtWEVzFEAmcUbXccHNtCIQWyUqeLc5ZLxsuETdMQhEgWvKndSHCxMfqoxfBWYGYoNs+
 DGaQ8IH7WuDXyfQ/ST7hQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iyA8DNYHRtU=:IiiVnZoeAHyKVIJUtkrgBH
 K7l8VgMgvlGz0MPusI0epHEkJarei5WjOi+QONlABA5GJJvVc6Zj3qvb6QmcaLS7nTeffkdyi
 0B5sW9fDivdNDd7gNqHOMQ2cb31aJacEoFJB25P24JZy9bZqs0UH+zfA7KAfWvGM/uX548lKJ
 5oP6PeQ2vgJ+RkLzDl6q5Tr4VM3KqvQ02jACM+WAbHEoLsuzFY42eUj0WPL6sAI2XL7VJ3y3x
 BXqwn8Zmrs6eg9v/p9zkDk5TGVQtuXuLFpAEWn0Luh/VHTFeb0msXKQRBmIbVm5z65v67G4pE
 3luKLSONBuWYN4SARNMFqgRL5LTeSKEmbCvK3Kf8dBq74NUPi2xofpJu6DUrecYuILOxh+z5o
 Fbh+cJIXdps8ghG5Nf44t9TLSE7nRk3cUXxlnaW4RB5sAB0CrN8FxFaEfPO6zmdWWDptSAyJQ
 vY2L5v7GhXzI89uf9I8WGldUcPs5IOItPZVhfZ6nkTNj5Fr/bQcvWjPFRwmAhHEWI/RyLraqK
 05I6wb/ZYrLNRxlsA7cyxlqLHtH1PQrfnnDLF8ciTNUTCs0umLjSdoiGnfCyUqD9xyBEgjxUA
 p5zgRc+gSCbtyRBwOk1duyJA+qo0dA7AXnAfMyhvnPcYubV1c8pEe8nDB9p7kdSr/F0FF2rBC
 SltXZtrzuRaOBZcruLNmzJAFUGBPrb0HdKXoRivBLPNr4LBFWnmRs9d5wKIO69WvDOAzBVT4N
 9xYGd9725MA8AsX1eWFitldtaRExbDdWoFDMRtOTzWvl3iLNzCBEUDdGqapXO+7nMOQpTW7iz
 OZmkYlknT8Kgk4HCNmlqF6rpPTCLTdGRza+RCgNuUmEigHeF8fbRhZHFRJwsxyuME7rVRozy7
 X4pgcDkOfluGnmH3Nrkvq51u2s2NuZtZX4Ibsn95seF0kRTEDO0by1iuoxER2DseZ0PMRRig4
 /Wn2c10nK5oTSeguakBo65Cfm//zav//NJRCCftqWSPNkc416HYMcPZE/RACiC+4aI2fsemkj
 fYFy8/loyvD6kiTEt5izlfer4rEXb4WGwgkOpalwPc6mnXyA3slpub5mn4TFhPHlTAGcOsdQh
 thnn5TQHxlqffg3Yxg6Q+bfsszO4blrTPFxbHNtFwyh46xb51qdISXViA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/24 =E4=B8=8A=E5=8D=887:47, Josef Bacik wrote:
> On 8/23/21 7:37 PM, Qu Wenruo wrote:
>>
>>
>> On 2021/8/24 =E4=B8=8A=E5=8D=884:04, Josef Bacik wrote:
>>> On 8/23/21 5:00 AM, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2021/8/21 =E4=B8=8A=E5=8D=883:11, Josef Bacik wrote:
>>>>> Currently we build a bare-bones file system in make_btrfs(), and
>>>>> then we
>>>>> load it up and fill in the rest of the file system after the fact.
>>>>> One
>>>>> thing we omit in make_btrfs() is the block group item for the
>>>>> temporary
>>>>> system chunk we allocate, because we just add it after we've opened
>>>>> the
>>>>> file system.
>>>>>
>>>>> However I want to be able to generate the free space tree at
>>>>> make_btrfs() time, because extent tree v2 will not have an extent tr=
ee
>>>>> that has every block allocated in the system.=C2=A0 In order to do t=
his I
>>>>> need to make sure that the free space tree entries are added on bloc=
k
>>>>> group creation, which is annoying if we have to add this chunk after
>>>>> I've created a free space tree.
>>>>>
>>>>> So make future work simpler by simply adding our block group item at
>>>>> make_btrfs() time, this way I can do the right things with the free
>>>>> space tree in the generic make block group code without needing a
>>>>> special case for our temporary system chunk.
>>>>>
>>>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>>>> ---
>>>>> =C2=A0 mkfs/common.c | 31 +++++++++++++++++++++++++++++++
>>>>> =C2=A0 mkfs/main.c=C2=A0=C2=A0 |=C2=A0 9 ++-------
>>>>> =C2=A0 2 files changed, 33 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/mkfs/common.c b/mkfs/common.c
>>>>> index 9263965e..cba97687 100644
>>>>> --- a/mkfs/common.c
>>>>> +++ b/mkfs/common.c
>>>>> @@ -190,6 +190,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config
>>>>> *cfg)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 num_bytes;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 system_group_offset =3D BTRFS_BLO=
CK_RESERVED_1M_FOR_SUPER;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 system_group_size =3D BTRFS_MKFS_=
SYSTEM_GROUP_SIZE;
>>>>> +=C2=A0=C2=A0=C2=A0 bool add_block_group =3D true;
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((cfg->features & BTRFS_FEATURE_IN=
COMPAT_ZONED)) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 system_group_=
offset =3D cfg->zone_size *
>>>>> BTRFS_NR_SB_LOG_ZONES;
>>>>> @@ -283,6 +284,36 @@ int make_btrfs(int fd, struct btrfs_mkfs_config
>>>>> *cfg)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (blk =3D=
=3D MKFS_SUPER_BLOCK)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 continue;
>>>>>
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Add the block group i=
tem for our temporary chunk. */
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cfg->blocks[blk] > s=
ystem_group_offset &&
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
add_block_group) {
>>>>
>>>> This makes the block group item always be the first item.
>>>>
>>>> But for skinny metadata, METADATA_ITEM is smaller than
>>>> BLOCK_GROUP_ITEM,
>>>> meaning it should be before BLOCK_GROUP_ITEM.
>>>>
>>>> Won't this cause the extent tree has a bad key order?
>>>>
>>>
>>> No because it's based on the actual bytenr.=C2=A0 We'll insert the ext=
ent
>>> item entry first, and then move to the next block and if it's past the
>>> first block we add the block group item, and then the actual extent
>>> item.=C2=A0 So it goes
>>>
>>> first block X gets extent item inserted
>>> X+1 > X, insert block group item
>>> insert X+1 extent item.
>>>
>>
>> But then what if we go non-skinny metadata?
>>
>> Then block group item is always before any extent item.
>>
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 0 key (1048576 METADATA=
_ITEM 0) itemoff 16259 itemsize 24
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 refs 1 gen 1 flags TREE_BLOCK
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 tree block skinny level 0
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 1 key (1048576 TREE_BLO=
CK_REF 1) itemoff 16259 itemsize 0
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 tree block backref
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 2 key (1048576 BLOCK_GR=
OUP_ITEM 4194304) itemoff 16235
> itemsize 24
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 block group used 98304 chunk_objectid 256 flags SYST=
EM
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 3 key (1064960 METADATA=
_ITEM 0) itemoff 16211 itemsize 24
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 refs 1 gen 1 flags TREE_BLOCK
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 tree block skinny level 0
>
>
> This is what it looks like.=C2=A0 We're basing it off of the key.objecti=
d. If
> the key.objectid's match, which they will, the block group will always
> be after it all.=C2=A0 It's doing the right thing.=C2=A0 Thanks,

Oh my bad memory.

Both EXTENT_ITEM and METADATA_ITEM are smaller than BLOCK_GROUP_ITEM.

So these extent items should always be before BLOCK_GROUP_ITEM, no
matter if the skinny metadata is spcififed.

Then the code is completely fine.

Thanks,
Qu
>
> Josef
