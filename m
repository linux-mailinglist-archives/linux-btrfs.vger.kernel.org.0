Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E39976D995
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Aug 2023 23:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjHBVck (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Aug 2023 17:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbjHBVcf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Aug 2023 17:32:35 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC341734
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 14:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1691011946; x=1691616746; i=quwenruo.btrfs@gmx.com;
 bh=4dweIAwkuwNYoZeRGnUQLz5Lo/lXtEedROlsyPuo/+w=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=sJC1K9cMAQsMOoXzg+hvOXxpgiZqDsB+nIWm/BLX1ONNOjftyKxhhsaIj0pvy/zxnd/ZRWu
 WBibxXXSq9x7hP2WW28yQFBHSPR6JGHtxErflbxIM9eDWaimuMkohfAGRZQyMrm4SDHs/2xEE
 Q3EaEY4KC4HoU84wZ81ZatQW0zEI4wT9fqoisV68uIOI75BLIV9JVikGT1bQp8RHk6+f7Ybb/
 4CqmZI1hA5KleXCUz2whhuAv62qGCHxvk5hyyLLSslzI11qVbg2ftwsV+ReXkIuQ2tzOuGZUn
 rOOt/dfgxqbN8PtvtAbEBlHsf84cNxYW+Oueico3MUBilnLzI3Iw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYeR1-1qMcKw3GLr-00Vhyl; Wed, 02
 Aug 2023 23:32:26 +0200
Message-ID: <3eb1c37e-c35b-45a0-3040-905ffc07092c@gmx.com>
Date:   Thu, 3 Aug 2023 05:32:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] btrfs: reject invalid reloc tree root keys with
 stack dump
To:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com
References: <cover.1690970028.git.wqu@suse.com>
 <a15ff1e397312309c554482e55d929488e22dcca.1690970028.git.wqu@suse.com>
 <CAL3q7H6Q__RBAJBhWJBhOPtTLg7nhXei81wKmy=W6iO5RX=yAg@mail.gmail.com>
Content-Language: en-US
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
In-Reply-To: <CAL3q7H6Q__RBAJBhWJBhOPtTLg7nhXei81wKmy=W6iO5RX=yAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f7oGz17/Lb+nOAd2FWKgR+vDa5yBpgu4+gBAKKPB67VbAoW5/7i
 4ILLOUbsQ0VPYV/cNHDnEcvmwwjjdINv+jK87DXtV7ktjoCum/gckvQv0hBN7rwcXSTe6uK
 QXE7z19m3V/cqu2gHbeZf+lzrG/z0vehKyjHUqti1HFcg27A9xoR2nCVInx3ry7TvcMJD0S
 4wDaEmxaNGi8aNcDYyiCw==
UI-OutboundReport: notjunk:1;M01:P0:mTHwYSl36PQ=;kUtvYcsdLqA8RRvyzeE8d+khZpk
 MiQguyWX31OJFyxkrHNkPp4azR5vM3Duv8Fp0FDQc8r4B0+Z9uRWhlqIoJJyQ8XY4Q3/itCA7
 uOblGAFoqPI/hqMgZJFlB4kOUJI0CFVLJWMmMpq4BRrdRZsRwTWZFkpWE1LiNdCLIDkVdbI46
 s87diuEHOY8MvHMtKvEAZBdMrw17dDJyhJMF5HZyNUgl+txwhXKuyvnNnpt+3Nf74rLpyi+o/
 W/uEC8FW3NcmP5r3StOX7fxK8Y1gZywEZH11gJ53z/LYD8FpNHLNmKshi2O/8b0LTSacQs11s
 aab9IWXzpl+zUGSKhge+bWiorWEokdEwaJ/VrwUhEU8t/9vIaZ3JLcmbi6j/VXB0ASqm6p9DJ
 QJOdgga/aQDbvyUIuJaXPzYQ+pbkO4qsXvZdivmNuLg0abzOhBff/dK3v6Jw5oekIlPgj8t1V
 s38QFLaOe2SizK4ILvJ6kyuEQJ+qOayOItQck3/hYhgevMXw1QQBs+hiQfht3KupGRCe6Avbu
 FiquhasvgBhn/EBNb48dB6bFlroC6Ejn+Mtlc1HKsbNhUwoTugVxddZhUhBMye+Ab5h9MR9QR
 pIuvJT5Do8WkNIcmL5sD40swl1MZ1t0mfOGBRUcKmNXdI0fJpcdzqKeY5s9btTKiD/Lk9VUBq
 so0Wiy4aNd4vC/80dvRIdHqEvxYc08VgtbCQv8g0ZjgtUSFaWxgY5tJQgxnPOxgSJ3013vt8Y
 psq1nnVbMZREnAhnvWXpjDDfeQDastvpPwIdmpDZYxBRbfMag1e1IC0LjzenIdv+jTwt/b/7j
 5uf0h8UrqkszERjXxhVckpmmAttxYVL0P64RkJ4EXWc4/d/tqNcCmEJj8KPs/Qt5aGl0nzVHM
 Y3rFXAPYy7M7fjpL4shmTEYpnbfBNxfKcXKRvFqRS/7i1n0UlUn8KHB4PrS9gt7HtgO4LM3dJ
 ynN/I7aWAIQLsWzlr4zUuDKywUQ=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/2 20:11, Filipe Manana wrote:
> On Wed, Aug 2, 2023 at 12:24=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> Syzbot reported a crash that an ASSERT() got triggered inside
>> prepare_to_merge().
>>
>> That ASSERT() makes sure the reloc tree is properly pointed back by its
>> subvolume tree.
>>
>> [CAUSE]
>> After more debugging output, it turns out we had an invalid reloc tree:
>>
>>   BTRFS error (device loop1): reloc tree mismatch, root 8 has no reloc =
root, expect reloc root key (-8, 132, 8) gen 17
>>
>> Note the above root key is (TREE_RELOC_OBJECTID, ROOT_ITEM,
>> QUOTA_TREE_OBJECTID), meaning it's a reloc tree for quota tree.
>>
>> But reloc trees can only exist for subvolumes, as for non-subvolume
>> trees, we just COW the involved tree block, no need to create a reloc
>> tree since those tree blocks won't be shared with other trees.
>>
>> Only subvolumes tree can share tree blocks with other trees (thus they
>> have BTRFS_ROOT_SHAREABLE flag).
>>
>> Thus this new debug output proves my previous assumption that corrupted
>> on-disk data can trigger that ASSERT().
>>
>> [FIX]
>> Besides the dedicated fix and the graceful exit, also let tree-checker =
to
>> check such root keys, to make sure reloc trees can only exist for
>> subvolumes.
>>
>> Reported-by: syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/disk-io.c      |  3 ++-
>>   fs/btrfs/tree-checker.c | 15 +++++++++++++++
>>   2 files changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 5fd336c597e9..a01eac963075 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -1103,7 +1103,8 @@ static int btrfs_init_fs_root(struct btrfs_root *=
root, dev_t anon_dev)
>>          btrfs_drew_lock_init(&root->snapshot_lock);
>>
>>          if (root->root_key.objectid !=3D BTRFS_TREE_LOG_OBJECTID &&
>> -           !btrfs_is_data_reloc_root(root)) {
>> +           !btrfs_is_data_reloc_root(root) &&
>> +           is_fstree(root->root_key.objectid)) {
>>                  set_bit(BTRFS_ROOT_SHAREABLE, &root->state);
>>                  btrfs_check_and_init_root_item(&root->root_item);
>>          }
>> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
>> index 038dfa8f1788..dabb86314a4c 100644
>> --- a/fs/btrfs/tree-checker.c
>> +++ b/fs/btrfs/tree-checker.c
>> @@ -446,6 +446,21 @@ static int check_root_key(struct extent_buffer *le=
af, struct btrfs_key *key,
>>          btrfs_item_key_to_cpu(leaf, &item_key, slot);
>>          is_root_item =3D (item_key.type =3D=3D BTRFS_ROOT_ITEM_KEY);
>>
>> +       /*
>> +        * Bad rootid for reloc trees.
>> +        *
>> +        * Reloc trees are only for subvolume trees, other trees only n=
eeds
>> +        * a COW to be relocated.
>
> ... other trees only need to be COWed to be relocated.
>
>> +        */
>> +       if (unlikely(is_root_item && key->objectid =3D=3D BTRFS_TREE_RE=
LOC_OBJECTID &&
>> +                    !is_fstree(key->offset))) {
>> +               generic_err(leaf, slot,
>> +       "invalid reloc tree for root %lld, root id is not a subvolume t=
ree",
>> +                           key->offset);
>> +               dump_stack();
>
> Same logic as for places that do WARN_ON() or dump leaves: the
> dump_stack() should come before the error message.

Oh my bad, the dump_stack() is only for debug purpose, should be removed.

Thanks,
Qu
>
> Other than that, it looks good to me:
>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>
> Thanks.
>
>> +               return -EUCLEAN;
>> +       }
>> +
>>          /* No such tree id */
>>          if (unlikely(key->objectid =3D=3D 0)) {
>>                  if (is_root_item)
>> --
>> 2.41.0
>>
