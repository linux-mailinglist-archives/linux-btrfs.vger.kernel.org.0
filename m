Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD6178C340
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Aug 2023 13:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjH2LW6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Aug 2023 07:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjH2LW4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Aug 2023 07:22:56 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EE4E0
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Aug 2023 04:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1693308159; x=1693912959; i=quwenruo.btrfs@gmx.com;
 bh=fgpXcfBpw7YVhS2dOgQlBkWRW+g0gLm28+nZUPnXMV4=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=RWVHQ1LodyYPyYAEg5wsc5kLVpsJ4zIXGiDYQoOFsfa0ze5zJTp6Q9V1maWgs+O/upG1FK8
 PBsZhW6UxOFgCiNIPB9w7W/ZKQWGf6SwrzUpZZHr3vVrTgUAw06ITBcKJbJjIscuM0oJDaUkX
 5LU1zf+Ob7DiW1Ws5m06OqAuzW/7BL0UfMdmj813PnIWMxvBappsA47i3vS6MED9rgGsNvAQ8
 cpvWsSzC8p9vVq9LUgZTVjP4bN1TH85Ivr/mjS1pjFvh7/MxoVm1lQUd29PAolmSayiRavV6s
 cnSxCaFTyP8iNPJ3bdYCcD+WkTjLugddjPv2PcNy4amdjwzsFbVg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2E1G-1pYR2e3lHi-013bM4; Tue, 29
 Aug 2023 13:22:39 +0200
Message-ID: <66dd3928-1c0e-45ab-b56d-c35cf9a979e6@gmx.com>
Date:   Tue, 29 Aug 2023 19:22:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: qgroup: pre-allocate btrfs_qgroup to reduce
 GFP_ATOMIC usage
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <44e189b505bff8ae9d281a7765141563d6dee3bb.1693271263.git.wqu@suse.com>
 <ZO3MmTSkdN1kq2va@debian0.Home>
 <a1f5976d-a297-4421-be3c-f5611d1b60dd@suse.com>
 <CAL3q7H5EoADt8X5i945ucinX945GRVXFunWUDf3A7LOTWZ3J_g@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <CAL3q7H5EoADt8X5i945ucinX945GRVXFunWUDf3A7LOTWZ3J_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4WZF7f28iDrTozYW81H9PNPeZtLK79A/hZuOvI7eFnvynM+X3uD
 ITG3IBQh64pnlny+zfAILDyw3YY1QsIHs4et5gaRplFgcN/27TH4jLEC4FJ9uVAqN2pGTbM
 9VY+DcXpRh2zILvZpymCVMoL3O7d67HUWulXPxDS08uX2Sbzy/rUuRJpl8qz/Bm+t2Y7x7R
 KMnxnQQptksJpj5UwE7Uw==
UI-OutboundReport: notjunk:1;M01:P0:hxayR2SXk44=;l5w+o695Cqi53/UP1juWBTmGLby
 /j4H4kwmuuot291rYlXGbdWJ5OMSTr6fvC5ENpt8VveGkLfkUiDYCLnU697TGKj+J0eJjNABb
 UmC5OnpTcaHZ6Jf6mSCo5ms5DrHkjUwerVM/MiWFtWhu+At9c+nU/7OsYTMH6AOfc/xyIaYY3
 6w7en6aYxX3L9aVd/c6fLrWs2wEsOQ/XZc5b4AGc8asI1GM4LW8jikqIk/dZl2jjfFI9+NfU9
 ITJqxWw4EhiztF2E4Jw5MA2OAzm7gXqOKdm9FSFLwBarQ8XNDjE8xnqGS9ritU5IcEsuj5pDX
 1fEd5xVASpq239boak6V6Wj0Z4nFGOaHFAa44+V6Qfn9SYz/FCqJgQ0hy24WRCsZn4WqMinw9
 U7GMlvTzhQ8crMhSdmbWVkqwIho6j2JgSQ9udKtwNr0tEhzXy1pQ0Pd9a8RsBmNsjIS8BNRIl
 QqL+vdGqAIUnGtiXPikzm7S6/qB01doWPbiCEYDZ1LNHr5uuKmttwtOZ4GLFjuWX+4iscI4K0
 b0rX4eOyZQLKdwgwie2D2eDYSyOJKhkWEgDGL/YPqFK0W2Rb+CCEqpYi9/NMTQenLwNLkOPKX
 cKhf96hW2+I9Df3P4M1WMFDPzBfQDXMl/ZYcM4pAKHaixrOSq28OSCFl8u6jo8MbcuQ78bbR6
 JgqWotm2dliuG3Y5FqKZ8DXGu2yGe551gvdZCFdm+e2JjC+G7w1wEGr1WltxrWtkuaB+Bz9KX
 b2WjTEW6F9+S9tGj+If47Hw7QJ2rOWRKCdXpAyBkDVdLPP7Tn1ida8Tc7u2KWS6iXkpdaVOtM
 pQmVHKw2lfhBAIbyfjPmtqXA3WFSiQX50BTOEcD/4yCaju4qOrxZtpmKaTQ3FN+KGjSSy24sF
 Je4jMvE5Hp9Ru8crZ3VfSuWqPP0sz2Pb0fq1HhAyQLLcm0+aab6iTnvhxtQPsglR6n1a5s9TU
 jQGsmAc5fUYU3GTiQ5oSHt8Hq3k=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/29 19:04, Filipe Manana wrote:
> On Tue, Aug 29, 2023 at 11:59=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>>
>>
>> On 2023/8/29 18:46, Filipe Manana wrote:
>>> On Tue, Aug 29, 2023 at 09:08:08AM +0800, Qu Wenruo wrote:
>>>> Qgroup is the heaviest user of GFP_ATOMIC, but one call site does not
>>>> really need GFP_ATOMIC, that is add_qgroup_rb().
>>>>
>>>> That function only search the rb tree to find if we already have such
>>>> tree.
>>>> If there is no such tree, then it would try to allocate memory for it=
.
>>>>
>>>> This means we can afford to pre-allocate such structure unconditional=
ly,
>>>> then free the memory if it's not needed.
>>>>
>>>> Considering this function is not a hot path, only utilized by the
>>>> following functions:
>>>>
>>>> - btrfs_qgroup_inherit()
>>>>     For "btrfs subvolume snapshot -i" option.
>>>>
>>>> - btrfs_read_qgroup_config()
>>>>     At mount time, and we're ensured there would be no existing rb tr=
ee
>>>>     entry for each qgroup.
>>>>
>>>> - btrfs_create_qgroup()
>>>>
>>>> Thus we're completely safe to pre-allocate the extra memory for btrfs=
_qgroup
>>>> structure, and reduce unnecessary GFP_ATOMIC usage.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>> Changelog:
>>>> v2:
>>>> - Loose the GFP flag for btrfs_read_qgroup_config()
>>>>     At that stage we can go GFP_KERNEL instead of GFP_NOFS.
>>>>
>>>> - Do not mark qgroup inconsistent if memory allocation failed at
>>>>     btrfs_qgroup_inherit()
>>>>     At the very beginning, if we hit -ENOMEM, we haven't done anythin=
g,
>>>>     thus qgroup is still consistent.
>>>> ---
>>>>    fs/btrfs/qgroup.c | 79 ++++++++++++++++++++++++++++++++-----------=
----
>>>>    1 file changed, 54 insertions(+), 25 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
>>>> index b99230db3c82..2a3da93fd266 100644
>>>> --- a/fs/btrfs/qgroup.c
>>>> +++ b/fs/btrfs/qgroup.c
>>>> @@ -182,28 +182,31 @@ static struct btrfs_qgroup *find_qgroup_rb(stru=
ct btrfs_fs_info *fs_info,
>>>>
>>>>    /* must be called with qgroup_lock held */
>>>>    static struct btrfs_qgroup *add_qgroup_rb(struct btrfs_fs_info *fs=
_info,
>>>> +                                      struct btrfs_qgroup *prealloc,
>>>>                                         u64 qgroupid)
>>>>    {
>>>>       struct rb_node **p =3D &fs_info->qgroup_tree.rb_node;
>>>>       struct rb_node *parent =3D NULL;
>>>>       struct btrfs_qgroup *qgroup;
>>>>
>>>> +    /* Caller must have pre-allocated @prealloc. */
>>>> +    ASSERT(prealloc);
>>>> +
>>>>       while (*p) {
>>>>               parent =3D *p;
>>>>               qgroup =3D rb_entry(parent, struct btrfs_qgroup, node);
>>>>
>>>> -            if (qgroup->qgroupid < qgroupid)
>>>> +            if (qgroup->qgroupid < qgroupid) {
>>>>                       p =3D &(*p)->rb_left;
>>>> -            else if (qgroup->qgroupid > qgroupid)
>>>> +            } else if (qgroup->qgroupid > qgroupid) {
>>>>                       p =3D &(*p)->rb_right;
>>>> -            else
>>>> +            } else {
>>>> +                    kfree(prealloc);
>>>>                       return qgroup;
>>>> +            }
>>>>       }
>>>>
>>>> -    qgroup =3D kzalloc(sizeof(*qgroup), GFP_ATOMIC);
>>>> -    if (!qgroup)
>>>> -            return ERR_PTR(-ENOMEM);
>>>> -
>>>> +    qgroup =3D prealloc;
>>>>       qgroup->qgroupid =3D qgroupid;
>>>>       INIT_LIST_HEAD(&qgroup->groups);
>>>>       INIT_LIST_HEAD(&qgroup->members);
>>>> @@ -434,11 +437,15 @@ int btrfs_read_qgroup_config(struct btrfs_fs_in=
fo *fs_info)
>>>>                       qgroup_mark_inconsistent(fs_info);
>>>>               }
>>>>               if (!qgroup) {
>>>> -                    qgroup =3D add_qgroup_rb(fs_info, found_key.offs=
et);
>>>> -                    if (IS_ERR(qgroup)) {
>>>> -                            ret =3D PTR_ERR(qgroup);
>>>> +                    struct btrfs_qgroup *prealloc =3D NULL;
>>>> +
>>>> +                    prealloc =3D kzalloc(sizeof(*prealloc), GFP_KERN=
EL);
>>>> +                    if (!prealloc) {
>>>> +                            ret =3D -ENOMEM;
>>>>                               goto out;
>>>>                       }
>>>> +                    qgroup =3D add_qgroup_rb(fs_info, prealloc, foun=
d_key.offset);
>>>> +                    prealloc =3D NULL;
>>>>               }
>>>>               ret =3D btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
>>>>               if (ret < 0)
>>>> @@ -959,6 +966,7 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_i=
nfo)
>>>>       struct btrfs_key key;
>>>>       struct btrfs_key found_key;
>>>>       struct btrfs_qgroup *qgroup =3D NULL;
>>>> +    struct btrfs_qgroup *prealloc =3D NULL;
>>>>       struct btrfs_trans_handle *trans =3D NULL;
>>>>       struct ulist *ulist =3D NULL;
>>>>       int ret =3D 0;
>>>> @@ -1094,6 +1102,15 @@ int btrfs_quota_enable(struct btrfs_fs_info *f=
s_info)
>>>>                       /* Release locks on tree_root before we access =
quota_root */
>>>>                       btrfs_release_path(path);
>>>>
>>>> +                    /* We should not have a stray @prealloc pointer.=
 */
>>>> +                    ASSERT(prealloc =3D=3D NULL);
>>>> +                    prealloc =3D kzalloc(sizeof(*prealloc), GFP_NOFS=
);
>>>> +                    if (!prealloc) {
>>>> +                            ret =3D -ENOMEM;
>>>> +                            btrfs_abort_transaction(trans, ret);
>>>> +                            goto out_free_path;
>>>> +                    }
>>>> +
>>>>                       ret =3D add_qgroup_item(trans, quota_root,
>>>>                                             found_key.offset);
>>>>                       if (ret) {
>>>> @@ -1101,7 +1118,8 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs=
_info)
>>>>                               goto out_free_path;
>>>>                       }
>>>>
>>>> -                    qgroup =3D add_qgroup_rb(fs_info, found_key.offs=
et);
>>>> +                    qgroup =3D add_qgroup_rb(fs_info, prealloc, foun=
d_key.offset);
>>>> +                    prealloc =3D NULL;
>>>>                       if (IS_ERR(qgroup)) {
>>>>                               ret =3D PTR_ERR(qgroup);
>>>>                               btrfs_abort_transaction(trans, ret);
>>>> @@ -1144,12 +1162,14 @@ int btrfs_quota_enable(struct btrfs_fs_info *=
fs_info)
>>>>               goto out_free_path;
>>>>       }
>>>>
>>>> -    qgroup =3D add_qgroup_rb(fs_info, BTRFS_FS_TREE_OBJECTID);
>>>> -    if (IS_ERR(qgroup)) {
>>>> -            ret =3D PTR_ERR(qgroup);
>>>> -            btrfs_abort_transaction(trans, ret);
>>>> +    ASSERT(prealloc =3D=3D NULL);
>>>> +    prealloc =3D kzalloc(sizeof(*prealloc), GFP_NOFS);
>>>> +    if (!prealloc) {
>>>> +            ret =3D -ENOMEM;
>>>>               goto out_free_path;
>>>>       }
>>>> +    qgroup =3D add_qgroup_rb(fs_info, prealloc, BTRFS_FS_TREE_OBJECT=
ID);
>>>> +    prealloc =3D NULL;
>>>>       ret =3D btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
>>>>       if (ret < 0) {
>>>>               btrfs_abort_transaction(trans, ret);
>>>> @@ -1222,6 +1242,7 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs=
_info)
>>>>       else if (trans)
>>>>               ret =3D btrfs_end_transaction(trans);
>>>>       ulist_free(ulist);
>>>> +    kfree(prealloc);
>>>>       return ret;
>>>>    }
>>>>
>>>> @@ -1608,6 +1629,7 @@ int btrfs_create_qgroup(struct btrfs_trans_hand=
le *trans, u64 qgroupid)
>>>>       struct btrfs_fs_info *fs_info =3D trans->fs_info;
>>>>       struct btrfs_root *quota_root;
>>>>       struct btrfs_qgroup *qgroup;
>>>> +    struct btrfs_qgroup *prealloc =3D NULL;
>>>>       int ret =3D 0;
>>>>
>>>>       mutex_lock(&fs_info->qgroup_ioctl_lock);
>>>> @@ -1622,21 +1644,25 @@ int btrfs_create_qgroup(struct btrfs_trans_ha=
ndle *trans, u64 qgroupid)
>>>>               goto out;
>>>>       }
>>>>
>>>> +    prealloc =3D kzalloc(sizeof(*prealloc), GFP_NOFS);
>>>> +    if (!prealloc) {
>>>> +            ret =3D -ENOMEM;
>>>> +            goto out;
>>>> +    }
>>>> +
>>>>       ret =3D add_qgroup_item(trans, quota_root, qgroupid);
>>>>       if (ret)
>>>>               goto out;
>>>>
>>>>       spin_lock(&fs_info->qgroup_lock);
>>>> -    qgroup =3D add_qgroup_rb(fs_info, qgroupid);
>>>> +    qgroup =3D add_qgroup_rb(fs_info, prealloc, qgroupid);
>>>>       spin_unlock(&fs_info->qgroup_lock);
>>>> +    prealloc =3D NULL;
>>>>
>>>> -    if (IS_ERR(qgroup)) {
>>>> -            ret =3D PTR_ERR(qgroup);
>>>> -            goto out;
>>>> -    }
>>>>       ret =3D btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
>>>>    out:
>>>>       mutex_unlock(&fs_info->qgroup_ioctl_lock);
>>>> +    kfree(prealloc);
>>>>       return ret;
>>>>    }
>>>>
>>>> @@ -2906,10 +2932,15 @@ int btrfs_qgroup_inherit(struct btrfs_trans_h=
andle *trans, u64 srcid,
>>>>       struct btrfs_root *quota_root;
>>>>       struct btrfs_qgroup *srcgroup;
>>>>       struct btrfs_qgroup *dstgroup;
>>>> +    struct btrfs_qgroup *prealloc =3D NULL;
>>>
>>> This initialization is not needed, since we never read prealloc before
>>> the allocation below.
>>
>> This is mostly for consistency and static checkers.
>>
>> I'm pretty sure compiler is able to optimize it out.
>
> It's not about compiler optimizations, or being too picky.
> It's about some tools producing warnings for cases like this one.
> See the following example:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3D966de47ff0c9e64d74e1719e4480b7c34f6190fa

Oh, I'm considering crappier checkers, which may do false alerts on
uninitialized variable.

It looks like if we're considering static checkers, we should only focus
on the good ones.

Then your advice is completely sane, I'll update the patch soon.

Thanks,
Qu

>
>>
>> Thanks,
>> Qu
>>>
>>> With that fixed:
>>>
>>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>>>
>>> Thanks.
>>>
>>>>       bool need_rescan =3D false;
>>>>       u32 level_size =3D 0;
>>>>       u64 nums;
>>>>
>>>> +    prealloc =3D kzalloc(sizeof(*prealloc), GFP_NOFS);
>>>> +    if (!prealloc)
>>>> +            return -ENOMEM;
>>>> +
>>>>       /*
>>>>        * There are only two callers of this function.
>>>>        *
>>>> @@ -2987,11 +3018,8 @@ int btrfs_qgroup_inherit(struct btrfs_trans_ha=
ndle *trans, u64 srcid,
>>>>
>>>>       spin_lock(&fs_info->qgroup_lock);
>>>>
>>>> -    dstgroup =3D add_qgroup_rb(fs_info, objectid);
>>>> -    if (IS_ERR(dstgroup)) {
>>>> -            ret =3D PTR_ERR(dstgroup);
>>>> -            goto unlock;
>>>> -    }
>>>> +    dstgroup =3D add_qgroup_rb(fs_info, prealloc, objectid);
>>>> +    prealloc =3D NULL;
>>>>
>>>>       if (inherit && inherit->flags & BTRFS_QGROUP_INHERIT_SET_LIMITS=
) {
>>>>               dstgroup->lim_flags =3D inherit->lim.flags;
>>>> @@ -3102,6 +3130,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_han=
dle *trans, u64 srcid,
>>>>               mutex_unlock(&fs_info->qgroup_ioctl_lock);
>>>>       if (need_rescan)
>>>>               qgroup_mark_inconsistent(fs_info);
>>>> +    kfree(prealloc);
>>>>       return ret;
>>>>    }
>>>>
>>>> --
>>>> 2.41.0
>>>>
