Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9E14C6595
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 10:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbiB1JWC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 04:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbiB1JV7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 04:21:59 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE7157B2E
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 01:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646040073;
        bh=+Eyvcg3/38KDfhIpplVapoCtGkHGmW+l/NMctbex0sQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=k4Dmp5jVVIVZ+3ckhtX9Uv27MHdacrylsUlcL0AQF2g09Q2HP+Utzm9hFkrDl81Uy
         pRCjYive1mEe6LHvMTHyNjbhv+sMvm6L4uIoXrhLrwHOHw6kQaRUT0AkiG1L0Asv/S
         OcaW0BqyujajdHRAWcs3gkHz+DnpsunRKkj3iIJA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MBm1U-1nU9bA0zDI-00C9rx; Mon, 28
 Feb 2022 10:21:12 +0100
Message-ID: <f8c0610e-466b-256b-347f-d10c517023ae@gmx.com>
Date:   Mon, 28 Feb 2022 17:21:08 +0800
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
 <a6923955-00f9-d739-c70a-3beace0b85e1@gmx.com>
 <82df81f6-74a1-b77d-c4e9-48d20ab1bd68@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <82df81f6-74a1-b77d-c4e9-48d20ab1bd68@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WbfHvNS5v7bJBmsche9hkl+TjVzEiUhG0s8b2eMLFmV1UtbLdfg
 qOw7rNSTUS4qIBlIn38/rAQJTmU9bqvv3tsOtBcKBdo/8zzUL5EupDjKyuFzyN+bZgXFBmm
 Qf3qB8hNOvLCvcJE52TK8jSjBxdh4vcNaEc+PYurKepNzbt0EmYvZl0cRRM7j7xU0QAnC6+
 v0eoPbghd3fibtEUIJgWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MUpH1rMCNqU=:4H86c3W8+3VvlXFiuK/d9G
 wqBjF08/NOuociAAE82mmO2KrknojpN/r5/CJPuzu2si9UeZjcsdnMPLFHqZxlVDODVHjEl1W
 6Q2Bk7MwiGBl5b/GL977h45eCKU2NLz2eiI6CgrA595G9dJ/UZkhfZFZWA7WNmRAfiZMsBpbb
 mwcj2dddpR3KeML2PTgw51r2dldp5EPY2buFTG08WFS6pFu3Topvbza4DQ76ikY/z/KBy2tfn
 FMeROq7zZytNR+9zFYX0ruFINhs+0CCijs5qtl5CdGCWHDkCJFhTZrye4i/HoxJrAH6375Pyg
 IycWCjYIp9dBA53OSQDihJ3J5V3U+gF3xjCAA9u/wjJ5jiJ9K2n0sBsaUy3DbPq6E+9BR/ETI
 gGW/0jYGVNoUvvy8GDH0AluF+qQwBwmnoku7lKrCtyFC2o2g7DLa3kjBHXFeE/2P3VdyvKfnf
 KpABUkOFj21u4hoGR04cvwBcjHbruV02pP8yG+FDi/a0dERySuR4+qHkrwgKsSEa5KT/f1Sqp
 KHkYwlAIna706hs0nMHjCtypVo2qVV+IUkdftb5JJ3jFsnAQt5MtCMDmDQ0iptmV/5ZhQPbO2
 5xS4OjCMXjw53FbJ8JKnUmhx5tMW6xz0B1zEUxTvvsUScmDNmphNH3dVL4lFVXHfr4qSdLeSv
 zf1BNh/OtPMK0iwOolsoC49D09ZjWcZJ2PCXHjxnN0acZlJSqlwF5RZwKfyxDL/Uq5y/yefCv
 C2sr+7BAJShU8t1lAqhN3CpACW0TOqdFdhDu4Uhsed2gthzwXtKk2Uj4TRiVMD/umU+BLf25b
 80PPKWptyNLtxwlH4ZwvnYkrUAWQBsn+EBhSZQecBpsybVeh48xUWCxSthaHsOkhYqSRFZLXS
 PHkgZmSYB8MFlgAPQIqNX+PK14SGCNjpflN6F/x2wx4+Hyi1CmYQ987KFHytyHV6f0CGLtaCr
 Y+/c5quO6lIykdvCKUnxb+pOlBqeZIloOYWxPjHMItei+BAF3Mm0hXqLqzx0OvmtjYN/19W/k
 JX9HK4ZqZjUpeKoeSUhHt/qB75FZqY4cUhoAyrqiuhr3GEhNUNnCD1yhQ3i8+uHFitAcKzdtx
 26NwMzUsEWshsY=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/28 17:01, Anand Jain wrote:
> On 28/02/2022 16:54, Qu Wenruo wrote:
>>
>>
>> On 2022/2/28 16:00, Anand Jain wrote:
>>> On 28/02/2022 15:05, Qu Wenruo wrote:
>>>> [BUG]
>>>> There is a report that a btrfs has a bad super block num devices.
>>>>
>>>> This makes btrfs to reject the fs completely.
>>>>
>>>> =C2=A0=C2=A0 BTRFS error (device sdd3): super_num_devices 3 mismatch =
with
>>>> num_devices 2 found here
>>>> =C2=A0=C2=A0 BTRFS error (device sdd3): failed to read chunk tree: -2=
2
>>>> =C2=A0=C2=A0 BTRFS error (device sdd3): open_ctree failed
>>>>
>>>> [CAUSE]
>>>> During btrfs device removal, chunk tree and super block num devs are
>>>> updated in two different transactions:
>>>>
>>>> =C2=A0=C2=A0 btrfs_rm_device()
>>>> =C2=A0=C2=A0 |- btrfs_rm_dev_item(device)
>>>> =C2=A0=C2=A0 |=C2=A0 |- trans =3D btrfs_start_transaction()
>>>> =C2=A0=C2=A0 |=C2=A0 |=C2=A0 Now we got transaction X
>>>> =C2=A0=C2=A0 |=C2=A0 |
>>>> =C2=A0=C2=A0 |=C2=A0 |- btrfs_del_item()
>>>> =C2=A0=C2=A0 |=C2=A0 |=C2=A0 Now device item is removed from chunk tr=
ee
>>>> =C2=A0=C2=A0 |=C2=A0 |
>>>> =C2=A0=C2=A0 |=C2=A0 |- btrfs_commit_transaction()
>>>> =C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 Transaction X got committed, s=
uper num devs untouched,
>>>> =C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 but device item removed from c=
hunk tree.
>>>> =C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 (AKA, super num devs is alread=
y incorrect)
>>>> =C2=A0=C2=A0 |
>>>> =C2=A0=C2=A0 |- cur_devices->num_devices--;
>>>> =C2=A0=C2=A0 |- cur_devices->total_devices--;
>>>> =C2=A0=C2=A0 |- btrfs_set_super_num_devices()
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 All those operations are not in transa=
ction X, thus it will
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 only be written back to disk in next t=
ransaction.
>>>>
>>>> So after the transaction X in btrfs_rm_dev_item() committed, but befo=
re
>>>> transaction X+1 (which can be minutes away), a power loss happen, the=
n
>>>> we got the super num mismatch.
>>>>
>>>
>
>
>>> The cause part is much better now. So why not also update the super
>>> num_devices in the same transaction?
>>
>> A lot of other things like total_rw_bytes.
>>
>> Not to mention, even we got a fix, it will be another patch.
>>
>> Since the handling of such mismatch is needed to handle older kernels
>> anyway.
>
>  =C2=A0Ok.
>
>
>>>> [FIX]
>>>> Make the super_num_devices check less strict, converting it from a ha=
rd
>>>> error to a warning, and reset the value to a correct one for the
>>>> current
>>>> or next transaction commitment.
>>>
>>> So that we can leave the part where we identify and report num_devices
>>> miss-match as it is.
>>
>> I didn't get your point.
>> What do you want to get from this patch?
>>
>> Isn't this already the behavior of this patch?
>
>  =C2=A0Let me clarify - we don't need this patch if we fix the actual bu=
g as
> above. IMO.

Big NO NO.

The damage is already done, we must be responsible for whatever damage
we caused, especially the damage has already reached disk.

Just fixing the cause and call it a day is definitely not a responsible wa=
y.

Especially when the damage is done, you have no way to mount it, just
like the reporter.

You dare to say the same thing to the end user?

>
>>>
>>> Thanks, Anand
>>>
>>>
>>>> Reported-by: Luca B=C3=A9la Palkovics <luca.bela.palkovics@gmail.com>
>>>> Link:
>>>> https://lore.kernel.org/linux-btrfs/CA+8xDSpvdm_U0QLBAnrH=3DzqDq_cWCO=
H5TiV46CKmp3igr44okQ@mail.gmail.com/
>>>>
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>> Changelog:
>>>> v2:
>>>> - Add a proper reason on why this mismatch can happen
>>>> =C2=A0=C2=A0 No code change.
>>>> ---
>>>> =C2=A0 fs/btrfs/volumes.c | 8 ++++----
>>>> =C2=A0 1 file changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>>> index 74c8024d8f96..d0ba3ff21920 100644
>>>> --- a/fs/btrfs/volumes.c
>>>> +++ b/fs/btrfs/volumes.c
>>>> @@ -7682,12 +7682,12 @@ int btrfs_read_chunk_tree(struct btrfs_fs_inf=
o
>>>> *fs_info)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * do another round of validation=
 checks.
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (total_dev !=3D fs_info->fs_devices=
->total_devices) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_err(fs_info,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "super_num_devices %llu mismatc=
h with num_devices %llu found
>>>> here",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_warn(fs_info,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "super_num_devices %llu mismatc=
h with num_devices %llu found
>>>> here, will be repaired on next transaction commitment",
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 btrfs_super_num_devices(fs_info->super_copy),
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 total_dev);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EINVAL;
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_info->fs_devices->tota=
l_devices =3D total_dev;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_set_super_num_devic=
es(fs_info->super_copy, total_dev);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (btrfs_super_total_bytes(fs_info->s=
uper_copy) <
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_info->fs_de=
vices->total_rw_bytes) {
>>>
>
