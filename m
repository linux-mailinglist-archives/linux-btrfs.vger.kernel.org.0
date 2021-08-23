Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE4E3F53B1
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 01:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbhHWXiZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 19:38:25 -0400
Received: from mout.gmx.net ([212.227.17.21]:48945 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233093AbhHWXiZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 19:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629761857;
        bh=52tZtgxqc6N7uHGa6Yzz8oQVDeKtlXDCAPVIzVqVZ4M=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=hgnLBa8Ih1YkqAX6tdlaD6xZUcwwgZw+noGc2h2vlhOF8G6t9s9XeHztAvrI94nX0
         LfxRtaC7smNmnWn5AoPHQcliGBhjg0AH0cyI4YYSEmoAzONPZ2kQCM0g8X6iQMst5s
         c9T4ZkBAAxlWZv2Vb45DEJzZjjJnq4Xjhaum79f0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MkYbu-1mkTrq41BW-00m2XT; Tue, 24
 Aug 2021 01:37:37 +0200
Subject: Re: [PATCH 6/9] btrfs-progs: add the block group item in make_btrfs()
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1629486429.git.josef@toxicpanda.com>
 <d433af292d5e99ff194bc6362133e64704ecd006.1629486429.git.josef@toxicpanda.com>
 <72de3cea-aee0-a7e4-d585-bf9ea749e53b@gmx.com>
 <080b9285-9af0-0f51-4b3e-e9f357004920@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <f1c7b1c0-04cb-48ad-c728-5fc5429d7001@gmx.com>
Date:   Tue, 24 Aug 2021 07:37:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <080b9285-9af0-0f51-4b3e-e9f357004920@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O2iKei5oGC5QKtX/7KRRNHz1Z60DgtCgvK61TMANSfSK2pNWFVe
 sFFf2U4/z9hDRum7tx8QBrOBxqSK0JW/MnRTOerL3PRb2vcdXky1+tEQII4o6iwEgloB4ja
 vsjQ11jKHAfgZ9W7R1Kk9v8Nd2BhzeEj2ukD7jJIv6Rog1B+ajd+rcAtCfpk0i1QDMX9vp/
 HuSJRs7D/tEcwRYsIBjPA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Wy2fIrTgYSA=:Tu9CU4ceQXv/RSDNQrZN/z
 w7lcOU9tJpyCvFr1K1x6DX43TtEh0S/HRx9F6RUDYT6H58OsbDA4sAjmirjcxu3s1EmZTSqyt
 6tWOHMlnsIN6k9qX/5gcABxZlHHXGXOTE8OWLOJzrZ2k+Ik4fC7/ZC9t1k5ABeprbptSu2ndg
 rIE7673oVxWMbzvVmSMuuZFGQ3GQbc3Y/xlMbMMIHXxWQKIBhKeSj3OwCs6aQ9epGYvMZfyez
 XkhmRoRDIASqo/HxhRYl0vn4GTOBroAYbB2lExVukirVjzE+6uyzFLuOF0Pxaa/QlYN1EbJXM
 YmyWYIneGYGDDRY47uHzz/LezIDbnEWJOmrzBy7coJUYeOZoJReVvEVgXkOCargda+IMcXuGY
 3JJe4yxHhH4IvNzE4cXOfPDqO/kCvKPq7SIo9qfyatAxNqbPfYoX0dekhMFz5KribTlguxQe7
 n7c8p8AWREH28eN6X2SS406emVd6VfaHN4LX12ygsNvaXFhUfhGQsgZEbQXp7uE+XyUAivryD
 0OB13Ucfs5LMHMp+GnbwgY2l/UHmIS/6GXYEW9ysvlZ3oxtucvRPTefNmU8rIVu6MrIQiP7xh
 FyG7ITnlaV090B6helnKA0MMwAoEwsYnd8ojmDhhIquGYztoVl0Shq7H3Qg+NUp14/cNi4b/Q
 DFgDSO/XywVQx+XDDC/nuxdUyNx9ETY3QWeMnNjo4RgwprtiHETcqscWdAQpjwmIb/esThZKl
 pqeBATjxY4Jq2dfy5qZkTjia4Yg0on9c2E4dbrZxtNqmTy1YnnoL4QZEFjn3nLVMr9q/IngD1
 LzAgwDa9Fh4SZIqS8KEC6oIQWwUdEc+qUn61t+vYPU/Rf1K5idJ7zzL9b54jOrK0001tCVvf0
 UuCp1Cbhu/ZpMU3utZTZbVDaXnBXVk1ur5Vo6zGVqzzSIU4KWCK5ESDHYBZnBwnNG1IPA84qe
 DacHinE0qanIBmfwfgzvidL/eOItXo2+S7mnMYFMww/vAnVPjy/JLregTTjeUdCLZMrXgVGHD
 7PIkRHRefmZowpJuLPmbxPGBH0YEJrxukJJkHgdsP5Cn/MtQUsiN3cZyEHae9+kYMKDDw/Oo8
 gr16ZT24QX2y1feB8NUOW0xuDpEj0WAwvtgT6ecdzEZEnNIY+1VA5+RgQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/24 =E4=B8=8A=E5=8D=884:04, Josef Bacik wrote:
> On 8/23/21 5:00 AM, Qu Wenruo wrote:
>>
>>
>> On 2021/8/21 =E4=B8=8A=E5=8D=883:11, Josef Bacik wrote:
>>> Currently we build a bare-bones file system in make_btrfs(), and then =
we
>>> load it up and fill in the rest of the file system after the fact.=C2=
=A0 One
>>> thing we omit in make_btrfs() is the block group item for the temporar=
y
>>> system chunk we allocate, because we just add it after we've opened th=
e
>>> file system.
>>>
>>> However I want to be able to generate the free space tree at
>>> make_btrfs() time, because extent tree v2 will not have an extent tree
>>> that has every block allocated in the system.=C2=A0 In order to do thi=
s I
>>> need to make sure that the free space tree entries are added on block
>>> group creation, which is annoying if we have to add this chunk after
>>> I've created a free space tree.
>>>
>>> So make future work simpler by simply adding our block group item at
>>> make_btrfs() time, this way I can do the right things with the free
>>> space tree in the generic make block group code without needing a
>>> special case for our temporary system chunk.
>>>
>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>> ---
>>> =C2=A0 mkfs/common.c | 31 +++++++++++++++++++++++++++++++
>>> =C2=A0 mkfs/main.c=C2=A0=C2=A0 |=C2=A0 9 ++-------
>>> =C2=A0 2 files changed, 33 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/mkfs/common.c b/mkfs/common.c
>>> index 9263965e..cba97687 100644
>>> --- a/mkfs/common.c
>>> +++ b/mkfs/common.c
>>> @@ -190,6 +190,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config
>>> *cfg)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 num_bytes;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 system_group_offset =3D BTRFS_BLOCK=
_RESERVED_1M_FOR_SUPER;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 system_group_size =3D BTRFS_MKFS_SY=
STEM_GROUP_SIZE;
>>> +=C2=A0=C2=A0=C2=A0 bool add_block_group =3D true;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((cfg->features & BTRFS_FEATURE_INCO=
MPAT_ZONED)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 system_group_of=
fset =3D cfg->zone_size * BTRFS_NR_SB_LOG_ZONES;
>>> @@ -283,6 +284,36 @@ int make_btrfs(int fd, struct btrfs_mkfs_config
>>> *cfg)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (blk =3D=3D =
MKFS_SUPER_BLOCK)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 continue;
>>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Add the block group ite=
m for our temporary chunk. */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cfg->blocks[blk] > sys=
tem_group_offset &&
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ad=
d_block_group) {
>>
>> This makes the block group item always be the first item.
>>
>> But for skinny metadata, METADATA_ITEM is smaller than BLOCK_GROUP_ITEM=
,
>> meaning it should be before BLOCK_GROUP_ITEM.
>>
>> Won't this cause the extent tree has a bad key order?
>>
>
> No because it's based on the actual bytenr.=C2=A0 We'll insert the exten=
t
> item entry first, and then move to the next block and if it's past the
> first block we add the block group item, and then the actual extent
> item.=C2=A0 So it goes
>
> first block X gets extent item inserted
> X+1 > X, insert block group item
> insert X+1 extent item.
>

But then what if we go non-skinny metadata?

Then block group item is always before any extent item.

Thanks,
Qu

> Thanks,
>
> Josef
