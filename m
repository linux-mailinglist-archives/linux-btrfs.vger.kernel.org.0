Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652A757AB48
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jul 2022 03:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbiGTBDu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jul 2022 21:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiGTBDt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jul 2022 21:03:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093A65A15E
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jul 2022 18:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658279018;
        bh=JnoC9Vu6xxrZF6BZIzLiwbUM7K5DZIVI+vaR41G56dg=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=a16ammyCqSmQxTJyTXDCsAzaY0ATw1Y7dr3wZnYz+6uVnBUHYZ1I7WxG/tWrlO3Xd
         HC6kwJbuGOhRC5twyIw42dTgJCthJx8VpNV7ugJXVkgdvBJMwMBFODRL1GxOs1vT99
         Ggl+W17W0YhnLoY+k3VgJQdkE5MqWxCFrSl1G1OY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M3DJl-1oEnbQ1pPx-003heY; Wed, 20
 Jul 2022 03:03:38 +0200
Message-ID: <8d2c653a-eddf-e9b4-7912-d46993705680@gmx.com>
Date:   Wed, 20 Jul 2022 09:03:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1658207325.git.wqu@suse.com>
 <621654191a02dc3cbc5c3b03f6c00963b7e6f382.1658207325.git.wqu@suse.com>
 <4b4b9f52-9c40-2f91-d8a3-a6ed29c379ee@dorminy.me>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2 4/4] btrfs: dump all space infos if we abort
 transaction due to ENOSPC
In-Reply-To: <4b4b9f52-9c40-2f91-d8a3-a6ed29c379ee@dorminy.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T7sgSlBbJeoCoQZ+PQEompidXmzj4LXlCWaWvxnWI6fnnIzvzY1
 SrNnQB8CaYOxyRQoXL7n5uaLKvaqHDyUIkwQVQEQjD439aeQZxKul93321bECtAGw4ArD2s
 T20aKFMRfEiVNwSz2cOcIBeP3NzKmOVKwYilYUasSHD4d1fnc9D9RY0bp0wiO67miLPsYl2
 XcBCQAsCCMwE3YJ5jpRMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B/EjIm9rn2I=:zBECxPxEXFytBtc+ngn319
 ydxZVpRhh9pyCH05x4TgTwa7vwDtf0mSCZEsJjE5KHmm5jc5kdAj3eKnl/2S37m/pxTMesKgk
 3BbRyZyZdiGZt3Fi+gJYVeMF5xenYvTqM93sGOSxXNlSfsd7dikEqT00Kw7zoMj+0yEriHVsL
 Swfzu8BponBsE3FG7Iaedyyl2doGETst0tgAPHSh2zJuoaMkPI7/VTx0PAuiM4kzFkCQqRbc2
 +Umj2cbEDTQSzd1Pn6nlqReShtUHA2H7d4jdtdjVjkj386mJyQPQvzUUPv40jhlO8pYW2s2UD
 LGBqVfxP62n52n9rRUJWOuMpoe0s+fQbBX3a17zyKTjFAp98k5u4Jht+sm/yT6afxd+S+Fjrg
 dOoFI98lIbbUSDm9sQtrVWf+4wUvAxL51sNL1s5s5nDENr/X9DBVuiBpBKFxs265UTB6i5VJl
 m56O2KEV7MsVR3OI1yUjhL4+GyWhuO9O4VvMznx23vUn5VXuBLUiw+XGtwGhKwoyXf3RctPf/
 GOFFgKPOt9UpNI8mGdbSLRiv2HT2MFKDQkIX/chYd3C6C1/laEYrXuAD0DLt0ZZKKT3cOVWuQ
 2gWfGAxLSDHf2eDEBcCiSxmCyjnVfooqJCOWQAyjQiwb5Ke35JyB8PVKw4aoxF0R/ttuotWqd
 LbO/gk2FYshny8bySw8P3Ywc5hyy8Hgf9O/OdfQFVrDeVY3+KNbWJ0ZZRlbG3fgr7jc/EbyGI
 SlIVuHU6CbgZx4JlzCukREtCgjCBFpM5WooukfDzcaIzfR9O6/R5gEfeaNS0PhZGV3oMl2u0d
 ZysyWerwJ+myE55JbOhjJDmjg9/5Au8uWucnlGrm+wS7PkJrI6qwiKQ2ijxA6dZU1aTMhbCF2
 Un9vjwZp05tpyI0DMfsOmvZ0q1w3tDzNTEhm6I2ZVg/vG/Lo6lalfkaIB2n6BTp79lGi1SMXx
 aKv4I9hC1hI2NYyD8RBU5DFpEKaxHE3nVSKZZy9e0v8Ov3tPgrk+1kfrPldK9Cj+pqcN7w5AK
 9xWyXNFNl5FJWydReK0V/MdF6t7rCsABDwELpbq7mdS1Pkph8fILwOhG1dSzB7X8evnKlLKkQ
 KtTuxAJJhEzS2lyQMKH1oVuI9TCnM9Y4rN2E16b9522eu0yn49X70q6Rg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/20 08:42, Sweet Tea Dorminy wrote:
>
>
> On 7/19/22 01:11, Qu Wenruo wrote:
>> We have hit some transaction abort due to -ENOSPC internally.
>>
>> Normally we should always reserve enough space for metadata for every
>> transaction, thus hitting -ENOSPC should really indicate some cases we
>> didn't expect.
>>
>> But unfrotunately current error reporting will only give a kernel
>> wanring and backtrace, not really helpful to debug what's causing the
>> problem.
>>
>> And debug_enospc can only help when user can reproduce the problem, but
>> under most cases, such transaction abort by -ENOSPC is really hard to
>> reproduce.
>>
>> So this patch will dump all space infos (data, metadata, system) when w=
e
>> abort the first transaction with -ENOSPC.
>>
>> This should at least provide some clue to us.
>>
>> The example of a dump would look like this:
>>
>> =C2=A0 ------------[ cut here ]------------
>> =C2=A0 <skip stack dump>
>> =C2=A0 ---[ end trace 0000000000000000 ]---
>> =C2=A0 BTRFS info (device dm-4: state A): dumpping space info >=C2=A0=
=C2=A0 BTRFS
>> info (device dm-4: state A): space_info DATA has 8388608
> free, is not full
>> =C2=A0 BTRFS info (device dm-4: state A):=C2=A0=C2=A0 total:=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8388608
>> =C2=A0 BTRFS info (device dm-4: state A):=C2=A0=C2=A0 used:=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>> =C2=A0 BTRFS info (device dm-4: state A):=C2=A0=C2=A0 pinned:=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>> =C2=A0 BTRFS info (device dm-4: state A):=C2=A0=C2=A0 reserved:=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 0
>> =C2=A0 BTRFS info (device dm-4: state A):=C2=A0=C2=A0 may_use:=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>> =C2=A0 BTRFS info (device dm-4: state A):=C2=A0=C2=A0 read_only:=C2=A0=
=C2=A0=C2=A0=C2=A0 0
>> =C2=A0 BTRFS info (device dm-4: state A): space_info META has 263979008
>> free, is not full
>> =C2=A0 BTRFS info (device dm-4: state A):=C2=A0=C2=A0 total:=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 268435456
>> =C2=A0 BTRFS info (device dm-4: state A):=C2=A0=C2=A0 used:=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 131072
>> =C2=A0 BTRFS info (device dm-4: state A):=C2=A0=C2=A0 pinned:=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 65536
>> =C2=A0 BTRFS info (device dm-4: state A):=C2=A0=C2=A0 reserved:=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 0
>> =C2=A0 BTRFS info (device dm-4: state A):=C2=A0=C2=A0 may_use:=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 4194304
>> =C2=A0 BTRFS info (device dm-4: state A):=C2=A0=C2=A0 read_only:=C2=A0=
=C2=A0=C2=A0=C2=A0 65536
>> =C2=A0 BTRFS info (device dm-4: state A): space_info SYS has 8372224 fr=
ee,
>> is not full
>> =C2=A0 BTRFS info (device dm-4: state A):=C2=A0=C2=A0 total:=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8388608
>> =C2=A0 BTRFS info (device dm-4: state A):=C2=A0=C2=A0 used:=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16384
>> =C2=A0 BTRFS info (device dm-4: state A):=C2=A0=C2=A0 pinned:=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>> =C2=A0 BTRFS info (device dm-4: state A):=C2=A0=C2=A0 reserved:=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 0
>> =C2=A0 BTRFS info (device dm-4: state A):=C2=A0=C2=A0 may_use:=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>> =C2=A0 BTRFS info (device dm-4: state A):=C2=A0=C2=A0 read_only:=C2=A0=
=C2=A0=C2=A0=C2=A0 0
>> =C2=A0 BTRFS info (device dm-4: state A): dumping metadata reservation:
>> (reserved/size)
>> =C2=A0 BTRFS info (device dm-4: state A):=C2=A0=C2=A0 global:=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (3670016/3670016)
>> =C2=A0 BTRFS info (device dm-4: state A):=C2=A0=C2=A0 trans:=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0/0)
>> =C2=A0 BTRFS info (device dm-4: state A):=C2=A0=C2=A0 chunk:=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0/0)
>> =C2=A0 BTRFS info (device dm-4: state A):=C2=A0=C2=A0 delayed_inode:=C2=
=A0=C2=A0 (0/0)
>> =C2=A0 BTRFS info (device dm-4: state A):=C2=A0=C2=A0 delayed_refs:=C2=
=A0=C2=A0=C2=A0 (524288/524288)
>> =C2=A0 BTRFS: error (device dm-1: state A) in cleanup_transaction:1971:
>> errno=3D-28 No space left
>> =C2=A0 BTRFS info (device dm-1: state EA): forced readonly
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>> ---
>> =C2=A0 fs/btrfs/ctree.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 ++++--
>> =C2=A0 fs/btrfs/space-info.c | 14 ++++++++++++++
>> =C2=A0 fs/btrfs/space-info.h |=C2=A0 2 ++
>> =C2=A0 fs/btrfs/super.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +++-
>> =C2=A0 4 files changed, 23 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>> index 4e2569f84aab..3d6fd7f6b339 100644
>> --- a/fs/btrfs/ctree.h
>> +++ b/fs/btrfs/ctree.h
>> @@ -3739,7 +3739,7 @@ const char * __attribute_const__
>> btrfs_decode_error(int errno);
>> =C2=A0 __cold
>> =C2=A0 void __btrfs_abort_transaction(struct btrfs_trans_handle *trans,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *function,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int line, int errno);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int line, int errno, bool=
 first_hit);
>> =C2=A0 /*
>> =C2=A0=C2=A0 * Call btrfs_abort_transaction as early as possible when a=
n error
>> condition is
>> @@ -3747,9 +3747,11 @@ void __btrfs_abort_transaction(struct
>> btrfs_trans_handle *trans,
>> =C2=A0=C2=A0 */
>> =C2=A0 #define btrfs_abort_transaction(trans, errno)=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \
>> =C2=A0 do {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 bool first =3D false;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Report first abort since mount */=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!test_and_set_bit(BTRFS_FS_STATE_TRA=
NS_ABORTED,=C2=A0=C2=A0=C2=A0 \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &((trans)->fs_info->fs_state))) {=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 first =3D true;=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((errno) !=3D=
 -EIO && (errno) !=3D -EROFS) {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
\
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 WARN(1, KERN_DEBUG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 "BTRFS: Transaction aborted (error %d)\n",=C2=A0=C2=A0=C2=A0 \
>> @@ -3761,7 +3763,7 @@ do {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __btrfs_abort_transaction((trans), __fun=
c__,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __LINE__, (errno));=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __LINE__, (errno), first);=C2=A0=C2=A0=
=C2=A0 \
>> =C2=A0 } while (0)
>> =C2=A0 #ifdef CONFIG_PRINTK_INDEX
>> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
>> index 81457049816e..af2b3f5ef2b0 100644
>> --- a/fs/btrfs/space-info.c
>> +++ b/fs/btrfs/space-info.c
>> @@ -1717,3 +1717,17 @@ int btrfs_reserve_data_bytes(struct
>> btrfs_fs_info *fs_info, u64 bytes,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 }
>> +
>> +/* Dump all the space infos when we abort a transaction due to
>> ENOSPC. */
>> +__cold void btrfs_dump_fs_space_info(struct btrfs_fs_info *fs_info)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct btrfs_space_info *space_info;
>> +
>> +=C2=A0=C2=A0=C2=A0 btrfs_info(fs_info, "dumping space info:");
>> +=C2=A0=C2=A0=C2=A0 list_for_each_entry(space_info, &fs_info->space_inf=
o, list) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&space_info->lock=
);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __btrfs_dump_space_info(fs_=
info, space_info);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock(&space_info->lo=
ck);
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 dump_metadata_rsv(fs_info);
>> +}
> This function looks similar to btrfs_dump_space_info(), and the name and
> callsite doesn't help distinguish it very much to me. It seems
> potentially useful to print all the space_infos when one space_info
> encounters a problem,

This is fine for trans abort dump, but may not be a good idea for
enospc_debug output.

enospc_debug can be triggered way more frequent than trans abort, and
the extra info of unrelated space info may just be noise.

> and it seems potentially useful to print the block
> group infos when we're dumping all the space infos already, so maybe the
> two functions could be combined.

You mean block group infos? That can be very large for large fses.
Thus it's avoided for most call sites other than btrfs_reserve_extent().

>
> Maybe you could adjust btrfs_dump_space_info() to print all the space
> infos, starting with the one passed in (potentially NULL), and call it
> instead of this new function?
>
>> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
>> index e7de24a529cf..01287a7a22a4 100644
>> --- a/fs/btrfs/space-info.h
>> +++ b/fs/btrfs/space-info.h
>> @@ -157,4 +157,6 @@ static inline void
>> btrfs_space_info_free_bytes_may_use(
>> =C2=A0 }
>> =C2=A0 int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 =
bytes,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum btrfs_reserve_flush_enum flus=
h);
>> +void btrfs_dump_fs_space_info(struct btrfs_fs_info *fs_info);
>> +
>> =C2=A0 #endif /* BTRFS_SPACE_INFO_H */
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>> index 4c7089b1681b..f6bc8aa00f44 100644
>> --- a/fs/btrfs/super.c
>> +++ b/fs/btrfs/super.c
>> @@ -346,12 +346,14 @@ void __cold btrfs_err_32bit_limit(struct
>> btrfs_fs_info *fs_info)
>> =C2=A0 __cold
>> =C2=A0 void __btrfs_abort_transaction(struct btrfs_trans_handle *trans,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *function,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int line, int errno)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int line, int errno, bool=
 first_hit)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_fs_info *fs_info =3D trans-=
>fs_info;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WRITE_ONCE(trans->aborted, errno);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WRITE_ONCE(trans->transaction->aborted, =
errno);
>> +=C2=A0=C2=A0=C2=A0 if (first_hit && errno =3D=3D -ENOSPC)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_dump_fs_space_info(fs=
_info);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Wake up anybody who may be waiting on=
 this transaction */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wake_up(&fs_info->transaction_wait);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wake_up(&fs_info->transaction_blocked_wa=
it);
> DO_ONCE_LITE(btrfs_dump_fs_space_info, fs_info) from <linux/once_lite.h>
> seems like a more lightweight way to dump the space infos once upon
> first transaction abort. Then you don't have to plumb through the
> 'first_hit' parameter from btrfs_abort_transaction(), and this change
> becomes even more minimal than it already is.

Sounds pretty awesome!

Thanks,
Qu
