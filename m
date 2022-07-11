Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAC056D896
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jul 2022 10:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiGKIpK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jul 2022 04:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiGKIot (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jul 2022 04:44:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FD61A040
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jul 2022 01:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657529081;
        bh=x1D5jhylmYubQiM9fWG9t5OL4RAC+egdyrX9T5kgMko=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=fXggmVuKtxbLSfg7tWDx7BVp3Mi1zVIkLrkF2znH5J+l8eukCw/KOTnUS/X0Extx1
         CWWA69PTMAj26LWtS7mj9FH73ukffh+u2/EU/1IFhnyCZq+Qm2/mtI/DkacOwBVld6
         32ZGDBQNCGd69ZYJ+X9CqOgVrN1sh0Wcz+P62yLw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MRTRN-1nyOwn0upR-00NRwk; Mon, 11
 Jul 2022 10:44:40 +0200
Message-ID: <4cd0eb6a-4893-a5c8-a758-947d8502368a@gmx.com>
Date:   Mon, 11 Jul 2022 16:44:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] btrfs: don't save block group root into super block
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
References: <40ce67d5bbb8f9c471b3c9a33504b0bb4022a51b.1657520391.git.wqu@suse.com>
 <866899c1-6952-e0f1-3a78-9caa483a7db9@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <866899c1-6952-e0f1-3a78-9caa483a7db9@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fN/ytsZNKjIAxCTPhTK2hQ6fnx+50efbTndLnIEpia6NaX0sXYq
 /Jpg3LHT0dFwQ76qftXxI2N7hqcx7MzsBspNc5QEvFhk6PH1julYW3uLXm01GRmkfYzmDrD
 6fStWjkvlpnL+3MPSPOc91rvKLSVvIuRMeU8SAYK15CDsE/VAZ4buTE4nLJ7XjTA/jhe3dn
 T7/kUDsg9Daf3mZdCUzfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V4nJ86mzkzQ=:P5r4TujdhNtQOIpJ4KL6NN
 nct0jEZQyzAqUmYDNzW9pnrTtC69MlX47o3QEFKjlQ1cXUfaeLZXKNIw4L5kn5xmJdieGurgL
 SraQgWQVZ4OiFV9f3UbVLvVWCcHVOiAPyv0wuYN2cnD1QkOSq1HKRF4PxswF6FkxkdONjY8ux
 FogketZ5CJp+JdlkcpHtGCBeYm158hC8Sb7eA99Of/lA/Hjr9kxvsr3cYUD+saACvkLpn68Hn
 j2BFlTIMz0+chvIpVAeP8B6DxNxPQAEKv/eK5saUPFEkVDzuAbTeFdQ2XvJT8+QmHB6yL6o+g
 cJ1lp6SA/sjPsYaenuEqZaBE6qDzYuftbeYR1HrEyNQrsOO7QJGxvhFSbYaYzfNsSycmRCEwY
 NaJaylpTBYCcp+NGtgf3pWbo6IEM09riakEg4Nv2SliacoKik6tlXjtvHVX7JPN79tpwuVJ8z
 qKbLhXZzLSR3JJ/ZKSdcJROyH4wLmj+KvcIblG7R9YaDDYtg4Iovs9e8iso4aPh/n1NRPZS5n
 xPnd8nV3+Q0DQqzbsJo3MhsVnoCIYiDRgUhYCd+YJZAGcAgjSvLEqLd7AtSMISHerd5nriBx7
 ilPcSmNyywWSKbTWAGMuJ/xSu5MbWVEKUbiyHczv4medbDVZRT2nKcaAsLc4O48jLbY2Esmic
 rbJaIuUFO3wWtq6YC3BAvJog9IUdaZX6T/8HeDH6EjsmVmxGbcdI2R1L9elPIHygtLNRZuYnZ
 4sHLRJ+9yLCPgeK/b9SS2fT/xQCKfHfMHJsGgSMjO4d/vwd6dm+5Z19Cpnon/Qi9duWIIKP2K
 ictMPjTz3RS7Khlctozpb9Ej9cmuwIU1j3fDg7Powb37yuSRuFTVnorwqE0Lxqpjmj2Fpfr4V
 er5G55ZmWEspXYJ0UwNu3Rh2JxmUcCddrryJfF9pUMJSlM4zdtnSGzASNf3Bv8nWRPbSC3Bhr
 xBwC7eptlMJCrWQDjr2/un7tVSJIAmLLXK5ciaJccTRVOwrk+OetA6prbVhBSAmaZH9AntGpq
 utyefkqs6iQWKYiQDosCL21KIDhgM4SLUGJU07YNtzzeIdQ7wBveyiDDvda7ltmmBxuOws2Ku
 BQQJMG0mksqIsieEboCab1xLWYR5AqM/307o6qR8efMDEmO9fS5kzq+Ug==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/11 16:27, Nikolay Borisov wrote:
>
>
> On 11.07.22 =D0=B3. 9:21 =D1=87., Qu Wenruo wrote:
>> The extent tree v2 (both thankfully not yet fully materialized) needs a
>> new root for storing all block group items.
>>
>> My initial proposal years just added a new tree rootid, and load it fro=
m
>> tree root, just like what we did for quota/free space tree/uuid/extent
>> roots.
>>
>> But the extent tree v2 patches introduced a completely new (and to me,
>> wasteful) way to store block group tree root into super block.
>>
>> Currently only two roots enjoying the privilege to stay in super blocks=
:
>> tree root and chunk root.
>>
>> There is no special reason to store block group root into super block,
>> even performance wise it doesn't make sense.
>>
>> So just move block group root from super block into tree root.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
>
> Overall looks good but I'd like to hear Josef's take on this, but indeed
> it's better to make those changes before unleashing extent v2.

Yep, that's exact the purpose of the patch.

In fact I have more things to discuss on the extent tree v2 things.

I really hope we can split the whole extent tree v2 into the following
parts:

- Block group tree
   I'm already doing the work to splitting the code from extent tree v2
   into a new compat RO flag BLOCK_GROUP_TREE.

- Reduced on-disk extent backrefs

- Split extent tree into multiple tree roots.
   In fact I'm not a fan of the idea at all.

Personally speaking, this should be something done in the very beginning
of the extent tree v2 idea, instead of spending years and put everything
into a big death ball crushing every one.

(And I should also defend my previous block group tree patches more,
other than really relying on extent-tree-v2, not solving the real world
mount time problem for years, and push everything to Josef)

Thanks,
Qu
>
>> ---
>> Changelog:
>> v2:
>> - Fix a wrong check in btrfs_read_roots(), which makes us to read
>> =C2=A0=C2=A0 block group root when EXTENT_TREE_V2 is not enabled
>> ---
>> =C2=A0 fs/btrfs/block-rsv.c=C2=A0=C2=A0 |=C2=A0 1 +
>> =C2=A0 fs/btrfs/ctree.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 ++----=
----------
>> =C2=A0 fs/btrfs/disk-io.c=C2=A0=C2=A0=C2=A0=C2=A0 | 32 ++++++++++++++++=
+++++-----------
>> =C2=A0 fs/btrfs/transaction.c |=C2=A0 8 --------
>> =C2=A0 4 files changed, 24 insertions(+), 33 deletions(-)
>>
>> diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
>> index 06be0644dd37..6ce704d3bdd2 100644
>> --- a/fs/btrfs/block-rsv.c
>> +++ b/fs/btrfs/block-rsv.c
>> @@ -424,6 +424,7 @@ void btrfs_init_root_block_rsv(struct btrfs_root
>> *root)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case BTRFS_CSUM_TREE_OBJECTID:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case BTRFS_EXTENT_TREE_OBJECTID:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case BTRFS_FREE_SPACE_TREE_OBJECTID:
>> +=C2=A0=C2=A0=C2=A0 case BTRFS_BLOCK_GROUP_TREE_OBJECTID:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 root->block_rsv =
=3D &fs_info->delayed_refs_rsv;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case BTRFS_ROOT_TREE_OBJECTID:
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>> index 4e2569f84aab..2ffd8daaa26e 100644
>> --- a/fs/btrfs/ctree.h
>> +++ b/fs/btrfs/ctree.h
>> @@ -288,14 +288,9 @@ struct btrfs_super_block {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* the UUID written into btree blocks */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 metadata_uuid[BTRFS_FSID_SIZE];
>> -=C2=A0=C2=A0=C2=A0 /* Extent tree v2 */
>> -=C2=A0=C2=A0=C2=A0 __le64 block_group_root;
>> -=C2=A0=C2=A0=C2=A0 __le64 block_group_root_generation;
>> -=C2=A0=C2=A0=C2=A0 u8 block_group_root_level;
>> -
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* future expansion */
>> -=C2=A0=C2=A0=C2=A0 u8 reserved8[7];
>> -=C2=A0=C2=A0=C2=A0 __le64 reserved[25];
>> +=C2=A0=C2=A0=C2=A0 u8 reserved8[8];
>
> nit: This array of 8 u8's is simply a single u64 so just collapse it
> into the subsequent array.
>
>> +=C2=A0=C2=A0=C2=A0 __le64 reserved[27];
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 sys_chunk_array[BTRFS_SYSTEM_CHUNK_AR=
RAY_SIZE];
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_root_backup super_roots[BTR=
FS_NUM_BACKUP_ROOTS];
>
> <snip>
>
>> @@ -2596,6 +2599,23 @@ static int btrfs_read_roots(struct
>> btrfs_fs_info *fs_info)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +=C2=A0=C2=A0=C2=A0 if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 location.objectid =3D BTRFS=
_BLOCK_GROUP_TREE_OBJECTID;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 location.type =3D BTRFS_ROO=
T_ITEM_KEY;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 location.offset =3D 0;
>
> nit: Factor out the setting of .type/.offset at the beginning of the
> function. Subsequent loads of the various root tree depend on only
> .objectid, that makes the code somewhat straighforward.
>
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 root =3D btrfs_read_tree_ro=
ot(tree_root, &location);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(root)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D PTR_ERR(root);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto out;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set=
_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_=
info->block_group_root =3D root;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 location.objectid =3D BTRFS_DEV_TREE_OBJ=
ECTID;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 location.type =3D BTRFS_ROOT_ITEM_KEY;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 location.offset =3D 0;
>
> <snip>
