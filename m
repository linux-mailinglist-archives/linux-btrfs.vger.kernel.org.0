Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6EF40A5AA
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 06:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237341AbhINE6u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Sep 2021 00:58:50 -0400
Received: from mout.gmx.net ([212.227.15.18]:57825 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234253AbhINE6u (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Sep 2021 00:58:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631595451;
        bh=Debwn9iyyk5iwqbmdsgielqhEH9iNu3lV4sQ9w6KCr8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=QWAXM/WdrGcCnFV6pAcbvsdusnJpaEiFA7XBONB1JgHex3TY2Vfnc/0V8ZjFkIGum
         hIacKQ5Khyb0GYY7sun3/eRGngzhD4QdXu7Zogw8I74Nd4ZVGv70N/GgLF7tRDsnVk
         S8JI5htsSkXkTdmQwpLTC9/fNWa12CF3JdCF1ngw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N2DxE-1muQ7Q338A-013hgA; Tue, 14
 Sep 2021 06:57:31 +0200
Subject: Re: [PATCH 5/8] btrfs-progs: Add btrfs_uuid_tree_remove
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210913131729.37897-1-nborisov@suse.com>
 <20210913131729.37897-6-nborisov@suse.com>
 <f84fe95a-1469-9e39-2813-4111fe258390@gmx.com>
 <922efc8b-3422-fa61-7936-692b95ada411@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <33fe3200-d929-853b-644d-358d4db77ebc@gmx.com>
Date:   Tue, 14 Sep 2021 12:57:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <922efc8b-3422-fa61-7936-692b95ada411@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4z8rpwrEo1fkQt4n5kHmj8h4a3XobSad3ljUaU5kb0EwPObsqsO
 u3w32QNXi4Fuf5OZPoEqnZqoxaqzhoepVSVtj1QtjEvdI3bAe0vzjToJbUw1DurnPPLc4o7
 n6nAEeVyNnlB98jlkI4F3149wfbEFb2WIXkskuZzs49uX4tYR42TDia587p3Js1HHDXcbCC
 NXyYIbjLFoK7EknYnZbcw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GfwR1vuM/ho=:zm2vrS3ZERApflkvNh8S4u
 K9J2SRujZ5rKhbPc+CFsmtfQY4O70HCBEZqUz/XkQcYXLs6P/HpF+ZxcLnM0VgNPv+koRW41y
 ES/0GwnsJdcjAW+JQxqOo3MGLcEReEfrJ1gmx0PRaFRikcKDap2mOhtE66UsyZToPEEmI4QmZ
 haEl4tf7m3DUMN+x7mm+Z+3blf+y5br0Ej5l2GSkhxxILSglpj3sNizSFOlc1dQvBvjgcDwPv
 vUI/dG5YsHSq3pnXyw9sd+V4FwBdiMnnFKPC4ThpdtK0shK15XmtlbzBpa81wFBE5wqSlSG6D
 7iFtWZushuaoAWrVYioH/P5Fxk74L1yZ949cqlJtcULY6wRozPwaZPkW1cM6mX7FxxoLoiQcF
 /rlwM3tBeVLjZzjF0Q9wEAZrgcFinjT8isdqHs/ETw4y0EqmncyTY7ySiGKsy0g3w3LuZsYq1
 fwCoOMQC8DjIdj2y6vM2sWXhEf6SshI6o1/imzrrR6LAKtjrvsmWvXXKVnifSgbfUcAIYiwkO
 pfUGLbgBVADRzKZ51Tn/vyN7BC3OVxU6Ohsa6VJR4HnXtkcWXEjgnAMkBdV2E4LOR5iF9QniJ
 NHYDkmftGSwSgvofRktT3kXYg2Z9ukkmbnmRC5TGtFyoAikNy5Mtx7p0WPXZ5uv5/WRNpkRUr
 eLCQwAR4CeofMohUn1lxNQd5eGvvL9IpGA1rFjf/khMaW4b9bKTaovF+eiRxlorjOljCwm+7e
 s7ieMsoFJDmv+diQJDsjP5xE3/DYZxBuA7Il3TBZKKs0PBzZXNxzB/X34dgSp1NrZvkshk8nB
 Ue0N3/HptoT+7DlG4DbmBFeVcqTf6ePAwjR9dPoknmFaAD6s02DuExDCOpFnNS2sKZ/0+s3rI
 YUYxuebfDrZbG/OLBSfXeZLr/iqRPTfdCtxdipGMyse+BQcLlZNtGnu0iPOhfgCebEeG0CRh8
 7WuhTpRKFxyAbHmlav2AQVQsra0BA7CQzZ+NOLAptu13/B7Cex/V+th2Koi98PDJOAr4ncIRs
 T4buO6cgN25NtkKYh7U3nnm1bJy4+A3heFRGiGaNid7VaaF+UgggdkzmGHMRx7/9/sornGehv
 Za8uoPNkoXRbMQ=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/14 =E4=B8=8B=E5=8D=8812:49, Nikolay Borisov wrote:
>
>
> On 14.09.21 =D0=B3. 4:07, Qu Wenruo wrote:
>>
>>
>> On 2021/9/13 =E4=B8=8B=E5=8D=889:17, Nikolay Borisov wrote:
>>> It will be used to clear received data on RW snapshots that were
>>> received.
>>>
>>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>>> ---
>>>  =C2=A0 kernel-shared/ctree.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++
>>>  =C2=A0 kernel-shared/uuid-tree.c | 82 +++++++++++++++++++++++++++++++=
++++++++
>>>  =C2=A0 2 files changed, 85 insertions(+)
>>>
>>> diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
>>> index 91a85796a678..158281a9fd67 100644
>>> --- a/kernel-shared/ctree.h
>>> +++ b/kernel-shared/ctree.h
>>> @@ -2860,6 +2860,9 @@ int btrfs_uuid_tree_add(struct
>>> btrfs_trans_handle *trans, u8 *uuid, u8 type,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 u64 subvol_id_cpu);
>>>
>>>  =C2=A0 int btrfs_is_empty_uuid(u8 *uuid);
>>> +int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, u8
>>> *uuid, u8 type,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 u64 subid);
>>> +
>>
>> I have checked the callers in the incoming check patches, they are all
>> starting a new trans on uuid tree, thus there is no need to start a
>> trans out of this function.
>>
>> Let's just pass the subvolume root into the function, and start a new
>> trans in side the function.
>>
>> So that we only need one parameter @root, everything else can be fetche=
d
>> from @root, and we can also modify the root item and uuid tree just in
>> one go.
>
> I disagree, this function is a direct copy from the kernel with the only
> adjustment that btrfs_uuid_to_key doesn't set key.type. If I change it
> in progs then this means it won't be unified with the kernel when this
> happens (if ever). I really rather keep shared functions as close as
> possible.

OK, didn't notice it's really some shared function. (in kernel it's
implemented in uuid-tree.c, not ctree.c).

Then maybe it's better to introduce a btrfs-progs specific helper like
btrfs_remove_recevied_uuid(), other than calling the function directly.

In fact, both mode shares the same root item modification code, which is
really a duplication.

As in btrfs-progs we don't need the other call sites in kernels which is
shared for subvolume removal.

Thanks,
Qu
>
>>
>> Thanks,
>> Qu
>>>
>>>  =C2=A0 static inline int is_fstree(u64 rootid)
>>>  =C2=A0 {
>>> diff --git a/kernel-shared/uuid-tree.c b/kernel-shared/uuid-tree.c
>>> index 51a7b5d9ff5d..0f0fbf667dda 100644
>>> --- a/kernel-shared/uuid-tree.c
>>> +++ b/kernel-shared/uuid-tree.c
>>> @@ -120,3 +120,85 @@ int btrfs_is_empty_uuid(u8 *uuid)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
>>>  =C2=A0 }
>>> +
>>> +int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, u8
>>> *uuid, u8 type,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 subid)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct btrfs_fs_info *fs_info =3D trans->fs_info;
>>> +=C2=A0=C2=A0=C2=A0 struct btrfs_root *uuid_root =3D fs_info->uuid_roo=
t;
>>> +=C2=A0=C2=A0=C2=A0 int ret;
>>> +=C2=A0=C2=A0=C2=A0 struct btrfs_path *path =3D NULL;
>>> +=C2=A0=C2=A0=C2=A0 struct btrfs_key key;
>>> +=C2=A0=C2=A0=C2=A0 struct extent_buffer *eb;
>>> +=C2=A0=C2=A0=C2=A0 int slot;
>>> +=C2=A0=C2=A0=C2=A0 unsigned long offset;
>>> +=C2=A0=C2=A0=C2=A0 u32 item_size;
>>> +=C2=A0=C2=A0=C2=A0 unsigned long move_dst;
>>> +=C2=A0=C2=A0=C2=A0 unsigned long move_src;
>>> +=C2=A0=C2=A0=C2=A0 unsigned long move_len;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!uuid_root) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EINVAL;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 btrfs_uuid_to_key(uuid, &key);
>>> +=C2=A0=C2=A0=C2=A0 key.type =3D type;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 path =3D btrfs_alloc_path();
>>> +=C2=A0=C2=A0=C2=A0 if (!path) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -ENOMEM;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ret =3D btrfs_search_slot(trans, uuid_root, &key, =
path, -1, 1);
>>> +=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 warning("error %d while se=
arching for uuid item!", ret);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 if (ret > 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -ENOENT;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +
>>> +=C2=A0=C2=A0=C2=A0 eb =3D path->nodes[0];
>>> +=C2=A0=C2=A0=C2=A0 slot =3D path->slots[0];
>>> +=C2=A0=C2=A0=C2=A0 offset =3D btrfs_item_ptr_offset(eb, slot);
>>> +=C2=A0=C2=A0=C2=A0 item_size =3D btrfs_item_size_nr(eb, slot);
>>> +=C2=A0=C2=A0=C2=A0 if (!IS_ALIGNED(item_size, sizeof(u64))) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 warning("uuid item with il=
legal size %lu!",=C2=A0=C2=A0=C2=A0 (unsigned
>>> long)item_size);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -ENOENT;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 while (item_size) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __le64 read_subid;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 read_extent_buffer(eb, &re=
ad_subid, offset, sizeof(read_subid));
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (le64_to_cpu(read_subid=
) =3D=3D subid)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset +=3D sizeof(read_su=
bid);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item_size -=3D sizeof(read=
_subid);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!item_size) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -ENOENT;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 item_size =3D btrfs_item_size_nr(eb, slot);
>>> +=C2=A0=C2=A0=C2=A0 if (item_size =3D=3D sizeof(subid)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_del_item(tra=
ns, uuid_root, path);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 move_dst =3D offset;
>>> +=C2=A0=C2=A0=C2=A0 move_src =3D offset + sizeof(subid);
>>> +=C2=A0=C2=A0=C2=A0 move_len =3D item_size - (move_src - btrfs_item_pt=
r_offset(eb, slot));
>>> +=C2=A0=C2=A0=C2=A0 memmove_extent_buffer(eb, move_dst, move_src, move=
_len);
>>> +=C2=A0=C2=A0=C2=A0 btrfs_truncate_item(path, item_size - sizeof(subid=
), 1);
>>> +
>>> +out:
>>> +=C2=A0=C2=A0=C2=A0 btrfs_free_path(path);
>>> +=C2=A0=C2=A0=C2=A0 return ret;
>>> +}
>>>
>>
