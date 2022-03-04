Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECC54CE0C7
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Mar 2022 00:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiCDXNG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Mar 2022 18:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiCDXMy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Mar 2022 18:12:54 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC37927C537
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Mar 2022 15:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646435519;
        bh=dz7ftsBtUMydlPH7zE0hakpDqSnKoP2rtWYQSlAX3QI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=HGlsVHUrw19VHQxVf5Q8DUwjfsOTZPXoXAcxOQKKVOPTiiYYWeJObq3xlnAe9ommK
         HkQ8GohZKa7dIOc0MGPXZLvzGVrfoLZ0kEJ/7nlIdO37F5TNYQt15Zje9m+vuiJ6KY
         FYLDnQAg0+NuNkfh6FPmBevfE5KrzLn/W5hasrss=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MQv8n-1nn9I006wp-00O2sD; Sat, 05
 Mar 2022 00:11:59 +0100
Message-ID: <068c1331-e7b1-dce2-2cda-a8d2df4603ce@gmx.com>
Date:   Sat, 5 Mar 2022 07:11:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 3/3] btrfs: check extent buffer owner against the owner
 rootid
Content-Language: en-US
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <cover.1645515599.git.wqu@suse.com>
 <1040e11d4075c8e61158126c5ddc2ee803a86143.1645515599.git.wqu@suse.com>
 <CAL3q7H5CsrCN61zUY1-Vf5aEb6uJu9u2MdNSZtP1aEmyYi1TQA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAL3q7H5CsrCN61zUY1-Vf5aEb6uJu9u2MdNSZtP1aEmyYi1TQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M3naNvFP8TXsfsSuBDYSXxGZ2PHL4tkbcZ1YU6rrWQfH9YsRUdx
 ZDLzNKPEZOCXE1MPUnifsCsYia9MfRpQdGg1vP01G8DC1KZwegjezBveeT4Cj08wyLuGiKB
 BOlHtg+blMKNL5LOAmcbP3C3Pcb16vAl425iRbVxq1fEKozpiPXVz+6j4yXO6AfLnIkEY1A
 wXZXOxFfghvEd/OzkevPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hpwB9ROYenY=:wZ38TvZ3SHRZGKRZg9jO2I
 yYgSrxRpJUpzoP4yG/I8M8zZjO1gTO9k0Ta6PsFuWZDdIk9NgfTREPvAehKouMJLYibmeTIYk
 5nIIe0DXs3DG0e+Kh5WahzuzFtLcvAZHB5s8l3T8cI+4gxnIvwFDYRwxWvn73jkVVic88J8/l
 7lmbcTgfFhdB/+28rk+sY9ekIH6PzjoaQTDit/c/y/Bvtp4b4Cj+XAc7usUSKaOfe7TPk2sGO
 gRBdpKkXKX+efNCHrWZleJkJgYZsLJpHyDzb0rr6dK3JDPDHhnAHEDmZyUXs3XwTCC/IUFdSS
 mH0U3BE7kLMQCBjeYG5steNgXzv+kpRJ0P1ua9n0Ra5TM2nl4+/V2JOCwokZ/7c2lYO38ZvZe
 9ugrxmvw68fz1b9dYjusJwO/znmBRs5R0EVB1ClxMinOfdVi8HAnvTUh8rEPJxkR1MuOqecqw
 /PSdpMypRa4m7sUeEPTYUTEOda6+TffWjpJP5PWZU7xN3II6WAaADvXMxfqQd1D0SpX4CH8Q8
 Iz1vqhge1k2mA9xGo+7yPTb2piJ3TjdLveXiSjAKTB2iqKnBNcZfq3WPN+w8HNE1CKNNaAPsV
 lDmOmNBI6Lsrx3Dit7K6SQGTBCe/HcIshTJh8NQfRQuvt3GAXW71DpPl5Kdi9VUK6QLWxgnlo
 R+l4C/RhtrJQiy6R/A+omYu9zrG0asYe0rUvTlowHLPEM/Mo+1vxow6GHdKyolBr82pxjIb+8
 5LZ7J6V4wCcFTqYN3TJ0QkXn56S2VybyvYxTrrWzE7tuZjNzDmkQmfGQDiMCzxWJtVG5srWh6
 3hNBWXTj4gjEYClDhM80lUWFW+FoBnmfwTpt2tGQz2/OHeqvOFYCBDTgfa7HkRMppgMytf6pe
 AjzX6taoI9AnJhfOntZ7bsPWs01ZZUYZygGylkVD38kWMYG4juvq2TNPdMO2jUbnFuylesHnU
 7UqUVbm0MmQHROUdPqgqZooxj+4XPvVSHhusH2RfFyExyRGldb39uEx3A7d1y3p/rVZCt1ftn
 BnYH2Sag9ZKeyJMIAqyUcNI2j/U7YT6fkRroqKXOEMVuYAbOJkbHom+WSxpzg8h/pdWjqnZU9
 c03p0XcRDiuRl8=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/5 00:25, Filipe Manana wrote:
> On Tue, Feb 22, 2022 at 7:42 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> Btrfs doesn't really check whether the tree block really respects the
>> root owner.
>>
>> This means, if a tree block referred by a parent in extent tree, but ha=
s
>> owner of 5, btrfs can still continue reading the tree block, as long as
>> it doesn't trigger other sanity checks.
>>
>> Normally this is fine, but combined with the empty tree check in
>> check_leaf(), if we hit an empty extent tree, but the root node has
>> csum tree owner, we can let such extent buffer to sneak in.
>>
>> Shrink the hole by:
>>
>> - Do extra eb owner check at tree read time
>>
>> - Make sure the root owner extent buffer exactly match the root id.
>>
>> Unfortunately we can't yet completely patch the hole, there are several
>> call sites can't pass all info we need:
>>
>> - For reloc/log trees
>>    Their owner is key::offset, not key::objectid.
>>    We need the full root key to do that accurate check.
>>
>>    For now, we just skip the ownership check for those trees.
>>
>> - For add_data_references() of relocation
>>    That call site doesn't have any parent/ownership info, as all the
>>    bytenrs are all from btrfs_find_all_leafs().
>>
>>    Thankfully, btrfs_find_all_leafs() still do the ownership check,
>>    and even for the read_tree_block() caller inside
>>    add_data_references(), we know that all tree blocks there are
>>    subvolume tree blocks.
>>    Just manually convert root_owner 0 to FS_TREE to continue the check.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/ctree.c        |  6 +++++
>>   fs/btrfs/disk-io.c      | 21 +++++++++++++++
>>   fs/btrfs/tree-checker.c | 57 ++++++++++++++++++++++++++++++++++++++++=
+
>>   fs/btrfs/tree-checker.h |  1 +
>>   4 files changed, 85 insertions(+)
>>
>> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
>> index 0eecf98d0abb..d904fe0973bd 100644
>> --- a/fs/btrfs/ctree.c
>> +++ b/fs/btrfs/ctree.c
>> @@ -16,6 +16,7 @@
>>   #include "volumes.h"
>>   #include "qgroup.h"
>>   #include "tree-mod-log.h"
>> +#include "tree-checker.h"
>>
>>   static int split_node(struct btrfs_trans_handle *trans, struct btrfs_=
root
>>                        *root, struct btrfs_path *path, int level);
>> @@ -1443,6 +1444,11 @@ read_block_for_search(struct btrfs_root *root, s=
truct btrfs_path *p,
>>                          btrfs_release_path(p);
>>                          return -EIO;
>>                  }
>> +               if (btrfs_check_eb_owner(tmp, root->root_key.objectid))=
 {
>> +                       free_extent_buffer(tmp);
>> +                       btrfs_release_path(p);
>> +                       return -EUCLEAN;
>> +               }
>>                  *eb_ret =3D tmp;
>>                  return 0;
>>          }
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 8165ee3ae8a5..018a230efca5 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -1109,6 +1109,10 @@ struct extent_buffer *read_tree_block(struct btr=
fs_fs_info *fs_info, u64 bytenr,
>>                  free_extent_buffer_stale(buf);
>>                  return ERR_PTR(ret);
>>          }
>> +       if (btrfs_check_eb_owner(buf, owner_root)) {
>> +               free_extent_buffer_stale(buf);
>> +               return ERR_PTR(-EUCLEAN);
>> +       }
>>          return buf;
>>
>>   }
>> @@ -1548,6 +1552,23 @@ static struct btrfs_root *read_tree_root_path(st=
ruct btrfs_root *tree_root,
>>                  ret =3D -EIO;
>>                  goto fail;
>>          }
>> +
>> +       /*
>> +        * For real fs, and not log/reloc trees, root owner must
>> +        * match its root node owner
>> +        */
>> +       if (!test_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state)=
 &&
>> +           root->root_key.objectid !=3D BTRFS_TREE_LOG_OBJECTID &&
>> +           root->root_key.objectid !=3D BTRFS_TREE_RELOC_OBJECTID &&
>> +           root->root_key.objectid !=3D btrfs_header_owner(root->node)=
) {
>> +               btrfs_crit(fs_info,
>> +"root=3D%llu block=3D%llu, tree root owner mismatch, have %llu expect =
%llu",
>> +                          root->root_key.objectid, root->node->start,
>> +                          btrfs_header_owner(root->node),
>> +                          root->root_key.objectid);
>> +               ret =3D -EUCLEAN;
>> +               goto fail;
>> +       }
>>          root->commit_root =3D btrfs_root_node(root);
>>          return root;
>>   fail:
>> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
>> index 2c1072923590..f50bde52f466 100644
>> --- a/fs/btrfs/tree-checker.c
>> +++ b/fs/btrfs/tree-checker.c
>> @@ -1855,3 +1855,60 @@ int btrfs_check_node(struct extent_buffer *node)
>>          return ret;
>>   }
>>   ALLOW_ERROR_INJECTION(btrfs_check_node, ERRNO);
>> +
>> +int btrfs_check_eb_owner(struct extent_buffer *eb, u64 root_owner)
>> +{
>> +       bool is_subvol =3D is_fstree(root_owner);
>> +       const u64 eb_owner =3D btrfs_header_owner(eb);
>> +
>> +       /*
>> +        * Skip dummy fs, as selftest doesn't bother to create unique e=
bs for
>> +        * each dummy root.
>> +        */
>> +       if (test_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &eb->fs_info->fs_sta=
te))
>> +               return 0;
>> +
>> +       /*
>> +        * Those trees uses key.offset as their owner, our callers don'=
t
>> +        * have the extra capacity to pass key.offset here.
>> +        * So we just skip those trees.
>> +        */
>> +       if (root_owner =3D=3D BTRFS_TREE_LOG_OBJECTID ||
>> +           root_owner =3D=3D BTRFS_TREE_RELOC_OBJECTID)
>> +               return 0;
>> +
>> +       /*
>> +        * This happens for add_data_references() of balance, at that c=
all site
>> +        * we don't have owner info.
>> +        * But we know all tree blocks there are subvolume tree blocks.
>> +        */
>> +       if (root_owner =3D=3D 0)
>> +               is_subvol =3D true;
>> +
>> +       if (!is_subvol) {
>> +               /* For non-subvolume trees, the eb owner should match r=
oot owner */
>> +               if (root_owner !=3D eb_owner) {
>> +                       btrfs_crit(eb->fs_info,
>> +"corrupted %s, root=3D%llu block=3D%llu owner mismatch, have %llu expe=
ct %llu",
>> +                               btrfs_header_level(eb) =3D=3D 0 ? "leaf=
" : "node",
>> +                               root_owner, btrfs_header_bytenr(eb), eb=
_owner,
>> +                               root_owner);
>> +                       return -EUCLEAN;
>> +               }
>> +               return 0;
>> +       }
>> +
>> +       /*
>> +        * For subvolume trees, owner can mismatch, but they should all=
 belong
>> +        * to subvolume trees.
>> +        */
>> +       if (is_subvol !=3D is_fstree(eb_owner)) {
>> +               btrfs_crit(eb->fs_info,
>> +"corrupted %s, root=3D%llu block=3D%llu owner mismatch, have %llu expe=
ct [%llu, %llu]",
>> +                       btrfs_header_level(eb) =3D=3D 0 ? "leaf" : "nod=
e",
>> +                       root_owner, btrfs_header_bytenr(eb), eb_owner,
>> +                       BTRFS_FIRST_FREE_OBJECTID, BTRFS_LAST_FREE_OBJE=
CTID);
>> +               return -EUCLEAN;
>
> This causes a failure when using free space cache v1 and doing balance:

Oh, no wonder why my default fstests run passed.

>
> BTRFS critical (device sdb): corrupted leaf, root=3D0 block=3D12320768
> owner mismatch, have 1 expect [256, 18446744073709551360]
>
> It's triggered from add_data_references() (relocation), for root tree
> leaves that contain data extents for v1 space caches.
> In that case the header owner is 1 (root tree), root_owner is 0, so
> is_subvol is set to true, and is_fstree(1) returns false, triggering
> the false corruption error here.

Right, the root_owner 0 is from relocation call site which doesn't have
the owner info, and since it's for data, we default to is_subvol =3D true,
and caused the problem.

It's much harder to distinguish data used by v1 cache in that context.

So please drop the patch for now.

Thanks for the report,
Qu

>
> Thanks.
>
>> +       }
>> +       return 0;
>> +}
>> diff --git a/fs/btrfs/tree-checker.h b/fs/btrfs/tree-checker.h
>> index 32fecc9dc1dd..c48719485687 100644
>> --- a/fs/btrfs/tree-checker.h
>> +++ b/fs/btrfs/tree-checker.h
>> @@ -25,5 +25,6 @@ int btrfs_check_node(struct extent_buffer *node);
>>
>>   int btrfs_check_chunk_valid(struct extent_buffer *leaf,
>>                              struct btrfs_chunk *chunk, u64 logical);
>> +int btrfs_check_eb_owner(struct extent_buffer *eb, u64 root_owner);
>>
>>   #endif
>> --
>> 2.35.1
>>
>
>
