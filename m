Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74934C6518
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 09:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbiB1Iy6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 03:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiB1Iy5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 03:54:57 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F69F1D311
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 00:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646038451;
        bh=CPGkx+6JE4zZxFeFChJh6bOn/5TNODzGDxumsmVmPaw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=g2byL/h+HvsdeGi2IaiyhA8gEjzPUEineyWY0tgJnYR7uviNEt4Jr/N8mWgw/RhTm
         pZsFIBBmuXY4Y5p48tbGtyAvi3ZQw2ZoQ1TModWtvo/8YOEE016hopYRUJLKtpwJ+y
         oZwTqP/UxcFcTdhyQ+Fbq1iLqxL9gNgWedNcN5VI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MAONd-1nW3lw04Cp-00BvMG; Mon, 28
 Feb 2022 09:54:11 +0100
Message-ID: <a6923955-00f9-d739-c70a-3beace0b85e1@gmx.com>
Date:   Mon, 28 Feb 2022 16:54:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] btrfs: repair super block num_devices automatically
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     =?UTF-8?Q?Luca_B=c3=a9la_Palkovics?= 
        <luca.bela.palkovics@gmail.com>
References: <732d0a86c3624bc96df3cca05512edac40efc75d.1646031785.git.wqu@suse.com>
 <ebdb0e67-0e9e-4ca6-1d2e-4dd2a7a7c103@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <ebdb0e67-0e9e-4ca6-1d2e-4dd2a7a7c103@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fxlvvv4uGUWOOrb9nQnWISZhXeSlSHrT9/KHkH9EK63dwSHJR53
 wbveZS7ZUrQyfKSAw7ZpjYv2JShNKJmTHBO5Tpj+b/IQYjlKBwfUlNo/uBj6JeT7JlTvx4/
 W36FRljJL7ME0WwT07wzlSgNktiUDEwuJK/Pf8crKlEVrhBAS4eiSrPw2n4WVrlpP3J6FRx
 EKkpb+pFk0aeBCgij6uSQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eP/0s/H2V7U=:d4vUjOjdWvp6T9hBwYQKzp
 9voJqTX/zrXE8m+aCeCJMKQLlqFWtvmwcOCDsE5YKKjYyh4LPzw5JyoyqJ8Kx3uVzBmxaERZG
 d4m0/g/JhgBRaZFthzpdIBDj9tQmxsZF1+kqcPAIdrF4VWD6dTxrwfz9Grtp4DBF16xmE80Ph
 8ljIZZg6qG9pFpbH6/SP/GCZbSEJUg2xxB18aF1vn2ChEjjHvsf58LcJ3fdTq4RWDvVhlgKsB
 SlxT5W98Ow7AHK04PPZATd5CnozruZugA5MG7Ov0pkt5QrCsL4YrjDAcjsaz80Coxfc/48RbY
 IZFU1aEFRWwkz1Upo5x0njtaRcoIcXkEWarHEnR6MZImr8jlmFUCZqwVOG1kAT2+bi8vm5Bc5
 fw0qg+oxTh2Ipv23XS9i7S4ykX04jX+zIi+cs9fHoRjP6mCOxCln0SxLWgBQ8bxyIhtJ4Uj1s
 1VfMvXunCEp50bbAN1vBkoOOuTdGzA2LNGE0l/mkeOzXntecpoMiiKlRfPusubwDsD0MlEWbX
 u1mFADFx3QqPkVukhuY034P9G7ygOin1o2qjpY1JlYxMZN/moatIiPaTkTniiioijbgSM7FM8
 Uwu6J8EfVVmvaIUbf0yAJID1GyXP2dS1TfqE95EYPaFnj6Rd27u5jVa2mTbSEjmZADPAoyQ9Q
 lsKnm6xpKmoLqZsqF9UltLZpM5VVSevsuNUuT5oo33QBSyapI/p7hd9JooTpxJmy4P3DwxRGn
 mqtjbpp80LYZ3uiuhQSdkk3IUfi5t0n8lcfvZzNIw769SbF2IwFUWPpVfWGybT0AQndDctPt9
 tCT7mInaJMW0jMM25W0Fg7vZXrKi2j8l5OjWIngs6M1bwYtS03aafUQqVlWRTC5KXKvDjCrYO
 JC2B1Ta7rcKW8qC5TnUiK6DHZ/NavxVodhzcSr9LFE7kmthm/leHQKNR+QjfO81D1GgML+xVS
 AYCoHJHYq9l7NNbkrEuhc/o08XQBF4XhFjcUbeM1+g9TnnTw7z5sNZ3X7cID8c7la/lFP66wz
 wotZpknZdjEwbnZ3DABi63hmu0Y/A3K6NP/gP5oPBfeH6p1Fm8UCQvl/zsPzSrmG5t9ZHRZmY
 IDRhhDyIbSVWnI=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/28 16:00, Anand Jain wrote:
> On 28/02/2022 15:05, Qu Wenruo wrote:
>> [BUG]
>> There is a report that a btrfs has a bad super block num devices.
>>
>> This makes btrfs to reject the fs completely.
>>
>> =C2=A0=C2=A0 BTRFS error (device sdd3): super_num_devices 3 mismatch wi=
th
>> num_devices 2 found here
>> =C2=A0=C2=A0 BTRFS error (device sdd3): failed to read chunk tree: -22
>> =C2=A0=C2=A0 BTRFS error (device sdd3): open_ctree failed
>>
>> [CAUSE]
>> During btrfs device removal, chunk tree and super block num devs are
>> updated in two different transactions:
>>
>> =C2=A0=C2=A0 btrfs_rm_device()
>> =C2=A0=C2=A0 |- btrfs_rm_dev_item(device)
>> =C2=A0=C2=A0 |=C2=A0 |- trans =3D btrfs_start_transaction()
>> =C2=A0=C2=A0 |=C2=A0 |=C2=A0 Now we got transaction X
>> =C2=A0=C2=A0 |=C2=A0 |
>> =C2=A0=C2=A0 |=C2=A0 |- btrfs_del_item()
>> =C2=A0=C2=A0 |=C2=A0 |=C2=A0 Now device item is removed from chunk tree
>> =C2=A0=C2=A0 |=C2=A0 |
>> =C2=A0=C2=A0 |=C2=A0 |- btrfs_commit_transaction()
>> =C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 Transaction X got committed, sup=
er num devs untouched,
>> =C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 but device item removed from chu=
nk tree.
>> =C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 (AKA, super num devs is already =
incorrect)
>> =C2=A0=C2=A0 |
>> =C2=A0=C2=A0 |- cur_devices->num_devices--;
>> =C2=A0=C2=A0 |- cur_devices->total_devices--;
>> =C2=A0=C2=A0 |- btrfs_set_super_num_devices()
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 All those operations are not in transact=
ion X, thus it will
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 only be written back to disk in next tra=
nsaction.
>>
>> So after the transaction X in btrfs_rm_dev_item() committed, but before
>> transaction X+1 (which can be minutes away), a power loss happen, then
>> we got the super num mismatch.
>>
>
> The cause part is much better now. So why not also update the super
> num_devices in the same transaction?

A lot of other things like total_rw_bytes.

Not to mention, even we got a fix, it will be another patch.

Since the handling of such mismatch is needed to handle older kernels
anyway.

>
>
>> [FIX]
>> Make the super_num_devices check less strict, converting it from a hard
>> error to a warning, and reset the value to a correct one for the curren=
t
>> or next transaction commitment.
>
> So that we can leave the part where we identify and report num_devices
> miss-match as it is.

I didn't get your point.
What do you want to get from this patch?

Isn't this already the behavior of this patch?

>
> Thanks, Anand
>
>
>> Reported-by: Luca B=C3=A9la Palkovics <luca.bela.palkovics@gmail.com>
>> Link:
>> https://lore.kernel.org/linux-btrfs/CA+8xDSpvdm_U0QLBAnrH=3DzqDq_cWCOH5=
TiV46CKmp3igr44okQ@mail.gmail.com/
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Add a proper reason on why this mismatch can happen
>> =C2=A0=C2=A0 No code change.
>> ---
>> =C2=A0 fs/btrfs/volumes.c | 8 ++++----
>> =C2=A0 1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 74c8024d8f96..d0ba3ff21920 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -7682,12 +7682,12 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info
>> *fs_info)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * do another round of validation c=
hecks.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (total_dev !=3D fs_info->fs_devices->=
total_devices) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_err(fs_info,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "super_num_devices %llu mismatch =
with num_devices %llu found
>> here",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_warn(fs_info,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "super_num_devices %llu mismatch =
with num_devices %llu found
>> here, will be repaired on next transaction commitment",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 btrfs_super_num_devices(fs_info->super_copy),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 total_dev);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EINVAL;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_info->fs_devices->total_=
devices =3D total_dev;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_set_super_num_devices=
(fs_info->super_copy, total_dev);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (btrfs_super_total_bytes(fs_info->sup=
er_copy) <
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_info->fs_devi=
ces->total_rw_bytes) {
>
