Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEE078A8A3
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Aug 2023 11:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjH1JSz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Aug 2023 05:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjH1JS0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Aug 2023 05:18:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AD8107
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 02:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1693214296; x=1693819096; i=quwenruo.btrfs@gmx.com;
 bh=sckNl/dE8JyNYCi5O9sQRgLCnl6PoWSEKUBPSJymMZI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=UWvS5GaVK4Mp5bkyuge50CRD1yOxVYxc8Z7SYw5972or6yK//lxLVu1grdIpmC9CBNA4Hlu
 RykMrOnbCF5puiXyYxsNP8GUUdpRKw6g5+qKcZH78C9hEMJX1/5k6z+z2vxEj7HMdJyQTrj2A
 wmhstlx1F+PaYuwaOohsxNApJXJ58fbA19i8qj/VyhJvyQ7HLK2l8RQufVk38Ezdfj6o0NY0R
 6Q443Z1R9t8W9pF9r3B4FycW3TnUxuZzhc1EkgW8AWKSD8RF/Lx20xIQuMhB77yy6Ls7qud3K
 C0qELMPfhwr/G3TNOGA6V3mbBuBilKf3RsxURmoF2n+X84iyfP6g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MmULr-1psw6w1wiP-00iXEO; Mon, 28
 Aug 2023 11:18:16 +0200
Message-ID: <fabbf786-f1b5-4302-9d9c-c863a54eb5d5@gmx.com>
Date:   Mon, 28 Aug 2023 17:18:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] btrfs: remove BUG() after failure to insert
 delayed dir index item
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1693209858.git.fdmanana@suse.com>
 <ee7caf888c95075685cd068d6e78f96be283b4b5.1693209858.git.fdmanana@suse.com>
 <74ce2e98-97ed-4f3a-9929-ec5b92fb5dcc@gmx.com>
 <CAL3q7H7pzOOzMaG2g0k+9bv_CYWDwWS2m9p3DnnqLrAN3+0yOg@mail.gmail.com>
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
In-Reply-To: <CAL3q7H7pzOOzMaG2g0k+9bv_CYWDwWS2m9p3DnnqLrAN3+0yOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UkZ+xyptc6FvnwpXhkQbdNMmhvnZO4JzIcc2nw1oNV2nnrULZyf
 vCTeXyca+bWeEIglZMTDNEkOP7WMuM0NnVf7aMY4ejzRUk2MWKXYgEum247Or2J5XCaVHag
 xcvUuLjC3iikDTbg1pUMc64xm9HXBfX7tG4cRR65G852UnrWHsdvyRTz14//3R4uPwLxxTe
 RT0VxfJAD3XpD0BevPn/g==
UI-OutboundReport: notjunk:1;M01:P0:CK5cmk+4iZg=;Yh6lORKYhTry8M7oMPKq3v/YQua
 3dXar4spDIg4o2Y7Uc742F6SOZTbUxEB1ggpWd+59HePG+Zv3m7XxorYCUIW8sSKxocbkRaBj
 fxU+EGdGOFpajCDGvvQAsDL6ztFfTf9Yl+bYHfp9YB8XTJyQgSCVdXn3zBKVI3VapPvhTZSrv
 qg5M1aq8GPs+eyVc6/JWQoUc3CZj5nJQ1Z/789mfnJ1NyroEBe+I7eaqWQvegzKytEO11u7bG
 zU/DNHgNmYsL6THHAfgUWM6Eyzsno7+rt+uje9LW+d90xYJzXRBtn2sK1hQMxnmGd6lccy4Xr
 dLzWh/RjG5RasW4QPSeGvxB0hDTS14FodoNx8QL/M1Gu6TjmD85ZISx5PwQ3fiiGcCjN+DYXc
 7ATR3DFseiqS/gdV8iufz/EZfn+Bd8SAkuHZ5XFi2UN+NyP9JBjSNjKAHdPdscvX1krnfausW
 WtYx+MYoXu5RuqIl3/my1FnwnsC92SPPCfn/uTcuNEODPmy15+sOxlmCmD4UwhbH9GCAJn2gY
 uzngHxvhTldc9eZJcAYkdDJZmlqwrJyj+rNR+6YTY0jS52863vi9XtZH3QNiOhorDfORrSv/D
 gC2VzeYCCkyhmjQOcayg9beI3eotQlyqWxPTCIImBkyTEqTxzakAwTFPwsDtsQ2c7ITR3e48U
 nQbZ1Tk9gVDEZzU/B1AipWlnsSnZURT4g/b9RwlXtikZ+RXNXy0qrnURiOGomjsX8vZgU+NTw
 n/gVimFyt6ghvjpSrtoYHtRIn7gEpT8ePpgU/7LkjWLHKfxKv7iR4MJD19LVvtl+2mCJTDpql
 9LG8O0waqAhuOGepMdcPRwE1hVDGwW/hMQ4z5VN1xlWcMC+OCg4mSg0IDzitH1j+NuspfIDy2
 DFJyLPoFGoltfImLXqQHGo5enhhYAtab2EU9Qj5TZYe5iTsFTp30YJVKWUTk73BqKvZAitCJ5
 FhfH9x4hX0RM0iWLD0WBcwQDKwo=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/28 16:53, Filipe Manana wrote:
> On Mon, Aug 28, 2023 at 9:42=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
>>
>>
>>
>> On 2023/8/28 16:06, fdmanana@kernel.org wrote:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> Instead of calling BUG() when we fail to insert a delayed dir index it=
em
>>> into the delayed node's tree, we can just release all the resources we
>>> have allocated/acquired before and return the error to the caller. Thi=
s is
>>> fine because all existing call chains undo anything they have done bef=
ore
>>> calling btrfs_insert_delayed_dir_index() or BUG_ON (when creating pend=
ing
>>> snapshots in the transaction commit path).
>>>
>>> So remove the BUG() call and do proper error handling.
>>>
>>> This relates to a syzbot report linked below, but does not fix it beca=
use
>>> it only prevents hitting a BUG(), it does not fix the issue where some=
how
>>> we attempt to use twice the same index number for different index item=
s.
>>>
>>> Link: https://lore.kernel.org/linux-btrfs/00000000000036e1290603e097e0=
@google.com/
>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>> ---
>>>    fs/btrfs/delayed-inode.c | 74 +++++++++++++++++++++++++------------=
---
>>>    1 file changed, 47 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
>>> index f9dae729811b..eb175ae52245 100644
>>> --- a/fs/btrfs/delayed-inode.c
>>> +++ b/fs/btrfs/delayed-inode.c
>>> @@ -1413,7 +1413,29 @@ void btrfs_balance_delayed_items(struct btrfs_f=
s_info *fs_info)
>>>        btrfs_wq_run_delayed_node(delayed_root, fs_info, BTRFS_DELAYED_=
BATCH);
>>>    }
>>>
>>> -/* Will return 0 or -ENOMEM */
>>> +static void btrfs_release_dir_index_item_space(struct btrfs_trans_han=
dle *trans)
>>> +{
>>> +     struct btrfs_fs_info *fs_info =3D trans->fs_info;
>>> +     const u64 bytes =3D btrfs_calc_insert_metadata_size(fs_info, 1);
>>> +
>>> +     if (test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags))
>>> +             return;
>>> +
>>> +     /*
>>> +      * Adding the new dir index item does not require touching anoth=
er
>>> +      * leaf, so we can release 1 unit of metadata that was previousl=
y
>>> +      * reserved when starting the transaction. This applies only to
>>> +      * the case where we had a transaction start and excludes the
>>> +      * transaction join case (when replaying log trees).
>>> +      */
>>> +     trace_btrfs_space_reservation(fs_info, "transaction",
>>> +                                   trans->transid, bytes, 0);
>>
>> I know this is from the old code, but shouldn't we use "-bytes" instead=
?
>
> Nop.
> The last argument, a value of 0, indicates that it's a space release.
> Allocations get a value of 1 for that last argument.

Oh, my bad.

Then it looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>
>
>>
>> Otherwise looks fine to me.
>>
>> Thanks,
>> Qu
>>
>>> +     btrfs_block_rsv_release(fs_info, trans->block_rsv, bytes, NULL);
>>> +     ASSERT(trans->bytes_reserved >=3D bytes);
>>> +     trans->bytes_reserved -=3D bytes;
>>> +}
>>> +
>>> +/* Will return 0, -ENOMEM or -EEXIST (index number collision, unexpec=
ted). */
>>>    int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans=
,
>>>                                   const char *name, int name_len,
>>>                                   struct btrfs_inode *dir,
>>> @@ -1455,6 +1477,27 @@ int btrfs_insert_delayed_dir_index(struct btrfs=
_trans_handle *trans,
>>>
>>>        mutex_lock(&delayed_node->mutex);
>>>
>>> +     /*
>>> +      * First attempt to insert the delayed item. This is to make the=
 error
>>> +      * handling path simpler in case we fail (-EEXIST). There's no r=
isk of
>>> +      * any other task coming in and running the delayed item before =
we do
>>> +      * the metadata space reservation below, because we are holding =
the
>>> +      * delayed node's mutex and that mutex must also be locked befor=
e the
>>> +      * node's delayed items can be run.
>>> +      */
>>> +     ret =3D __btrfs_add_delayed_item(delayed_node, delayed_item);
>>> +     if (unlikely(ret)) {
>>> +             btrfs_err(trans->fs_info,
>>> +"error adding delayed dir index item, name: %.*s, index: %llu, root: =
%llu, dir: %llu, dir->index_cnt: %llu, delayed_node->index_cnt: %llu, erro=
r: %d",
>>> +                       name_len, name, index, btrfs_root_id(delayed_n=
ode->root),
>>> +                       delayed_node->inode_id, dir->index_cnt,
>>> +                       delayed_node->index_cnt, ret);
>>> +             btrfs_release_delayed_item(delayed_item);
>>> +             btrfs_release_dir_index_item_space(trans); > +          =
mutex_unlock(&delayed_node->mutex);
>>> +             goto release_node;
>>> +     }
>>> +
>>>        if (delayed_node->index_item_leaves =3D=3D 0 ||
>>>            delayed_node->curr_index_batch_size + data_len > leaf_data_=
size) {
>>>                delayed_node->curr_index_batch_size =3D data_len;
>>> @@ -1472,37 +1515,14 @@ int btrfs_insert_delayed_dir_index(struct btrf=
s_trans_handle *trans,
>>>                 * impossible.
>>>                 */
>>>                if (WARN_ON(ret)) {
>>> -                     mutex_unlock(&delayed_node->mutex);
>>>                        btrfs_release_delayed_item(delayed_item);
>>> +                     mutex_unlock(&delayed_node->mutex);
>>>                        goto release_node;
>>>                }
>>>
>>>                delayed_node->index_item_leaves++;
>>> -     } else if (!test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags)) =
{
>>> -             const u64 bytes =3D btrfs_calc_insert_metadata_size(fs_i=
nfo, 1);
>>> -
>>> -             /*
>>> -              * Adding the new dir index item does not require touchi=
ng another
>>> -              * leaf, so we can release 1 unit of metadata that was p=
reviously
>>> -              * reserved when starting the transaction. This applies =
only to
>>> -              * the case where we had a transaction start and exclude=
s the
>>> -              * transaction join case (when replaying log trees).
>>> -              */
>>> -             trace_btrfs_space_reservation(fs_info, "transaction",
>>> -                                           trans->transid, bytes, 0);
>>> -             btrfs_block_rsv_release(fs_info, trans->block_rsv, bytes=
, NULL);
>>> -             ASSERT(trans->bytes_reserved >=3D bytes);
>>> -             trans->bytes_reserved -=3D bytes;
>>> -     }
>>> -
>>> -     ret =3D __btrfs_add_delayed_item(delayed_node, delayed_item);
>>> -     if (unlikely(ret)) {
>>> -             btrfs_err(trans->fs_info,
>>> -"error adding delayed dir index item, name: %.*s, index: %llu, root: =
%llu, dir: %llu, dir->index_cnt: %llu, delayed_node->index_cnt: %llu, erro=
r: %d",
>>> -                       name_len, name, index, btrfs_root_id(delayed_n=
ode->root),
>>> -                       delayed_node->inode_id, dir->index_cnt,
>>> -                       delayed_node->index_cnt, ret);
>>> -             BUG();
>>> +     } else {
>>> +             btrfs_release_dir_index_item_space(trans);
>>>        }
>>>        mutex_unlock(&delayed_node->mutex);
>>>
