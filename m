Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699B53A4118
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 13:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbhFKLRu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Jun 2021 07:17:50 -0400
Received: from mout.gmx.net ([212.227.15.19]:56535 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232007AbhFKLRd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Jun 2021 07:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623410134;
        bh=zRdHY9fAeWOpQ3t4Qj0ozuGEtxoSOoleIbthURLVnkU=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=hEgb1kMoGT4JGBGFqJz3cpSDK9VGO6J1SbfXQ1oW07H3jcXNm2gtjC/IS3VJkG9lj
         pI1cdxgzmkbO6j1ZNQQUsa2DJhkJKdhEV1e8RWYWPoj+6Nuae+r3a245DioflgyKyT
         HAIH5H1CmMsmZ7HvbjLd8zCjNvSE8H6P3W+E5RYU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MxDkw-1l7Yj72gcC-00xY5i; Fri, 11
 Jun 2021 13:15:34 +0200
To:     Martin Raiber <martin@urbackup.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <01020179f656e348-b07c8001-7b74-432a-b215-ccc7b17fbfdf-000000@eu-west-1.amazonses.com>
 <80834345-2626-a0a9-c3ae-fb2cc9435b49@gmx.com>
 <01020179fab66f82-98bc2232-7461-42ea-8194-ec5d1670d9f6-000000@eu-west-1.amazonses.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Combining nodatasum + compression
Message-ID: <016d413c-a4fe-6259-6bb8-b16cb4aa592a@gmx.com>
Date:   Fri, 11 Jun 2021 19:15:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <01020179fab66f82-98bc2232-7461-42ea-8194-ec5d1670d9f6-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WE8P2s1CeuTisDrlZRnIReSpBGBgJVMh0Flo7qyz/J3OyAhNl7T
 Ho46U1FqW0+MHR7dWuloiJm45ltJKmWSXLKHSxjEFt9tP8+gFHXNCSZqrI41OtbbpP5vib6
 KV8ByuVABurEPKAqQosvtS7r/gcc+R1fcdS6/uh4OyKRlh2dvATul2VIDDOMt3LhRJI690H
 Rm1UGYFrzWlIf4uVbEtAw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ie5fK/tIbXU=:nClw+brBqyLHFKzIK6azns
 MCk7TGzXMiVXUi/u8gGiD/uPbqffgiHcFzahVegrxsY9bg5aYF2vF/boOQLvNXPXyEsp7m4Dr
 h5aPC3MumRr8VLUHftFHvoo7yS7T71DeKGdxE1ZPr4ZuVh2C8CTAoHC7F5Ri5QBKJ8UOWyQlS
 BxgIkB9RsSejYLfhKxSF8Zz0b/rLNkY5+F4Y2MLwMxLu1kIA/jxoretI0Dl+z9cv8ya3MpF94
 2TTHkJ6J1TviXe442bWbIBYyqj/vkOHWPXQaqAt5KzuPbdf/tYb2vWtwPJ4V5umn5lNGva2o5
 pbHbkARmbn9NKvK/J+VA36avqXCeSOWRxgiqHCAAJ+uYmRLYP/8sceRHCpZ9dt+7L2faTED54
 lxZ2Mqjc/2+BUbJdx6MonYp73Drl4SdkMyFhh0QkOrB3ehI0QFl3v9Yp7YDVQWg7sOMLQOZ9y
 9bLtMXuUbkgvUCl8Mmd+RxlW71/wClxQAaq+pPzPNMGigT060BrQrXDUjNnsOL7x8TepJ3W2S
 h3NRUNh5Och09qNwADS/pZ8CZ/ywnDi9OgWCt8vGEI5t5fl96HPh9eSr2HJR8qH0OzqTvQPsC
 8lplP5KNIOyWPdMOJcF8pPqyZQEJBTY2UbocFCJpKkkGKzJykR5U+n6N8ZZpgV7F6IknSKv/o
 MdLpgvqs2Je9u14sh2CmLC/Gb4Lxh29A3/JNmSX1D2PYPZPIX3RkC7Ir83DKhe8skYV0ph03j
 Jwi2o9jRf9Wh/iDX1Txi2nF+c3KGzikz8P9JGeMB9PGbll6QSlBSgvXILv9LH1moPh6x9E0jM
 rHtMVm8cGp4qApfMojoWYkxFRfMqGXxKO4y8QYPS2wP1Jmk2z6+Vm6CPRBf+rN7aunCh2q+Bn
 BY9flFRwAnZKyeH/DH7y2E3FxrlSssVRLv0/8sCHRaS0l9rye0YiaaEvEqrOvcwpO8TEE94NP
 R2Ak0qmJS+ZgHDmNdjuQQHx6ha6Ns2ZDgOALcuZfNbOUCdM8qS+pY+hwAzCYFE3MJSkmhKi1T
 CPJp7Y+y+1Wg346DSIoQzC1Qn1/hA5YmNGYkrHoOS7uGauFK722KFUTu5Z/BTlMsPYIRkMwiQ
 xYpg07JC7SWsSTtCL0PmImv1clzDzJ/dthF6KSg7WaUyLVD+9wbUVVHjw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/11 =E4=B8=8B=E5=8D=886:55, Martin Raiber wrote:
> On 11.06.2021 02:18 Qu Wenruo wrote:
>> On 2021/6/10 =E4=B8=8B=E5=8D=8810:32, Martin Raiber wrote:
>>> when btrfs is running on a block device that improves integrity (e.g.
>>> Ceph), it's usefull to run it with nodatasum to reduce the amount of
>>> metadata and random IO.
>>>
>>> In that case it would also be useful to be able to run it with
>>> compression combined with nodatasum as well.
>>>
>>> I actually found that if nodatasum is specified after compress-force,
>>> that it doesn't remove reset the compress/nodatasum bit, while the oth=
er
>>> way around it doesn't work.
>>>
>>> That combined with
>>>
>>> --- linux-5.10.39/fs/btrfs/inode.c.orig 2021-05-31 16:11:03.537017580
>>> +0200
>>> +++ linux-5.10.39/fs/btrfs/inode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2021-=
05-31 16:11:19.461591523
>>> +0200
>>> @@ -408,8 +408,7 @@
>>> =C2=A0=C2=A0 */
>>> =C2=A0=C2=A0static inline bool inode_can_compress(struct btrfs_inode *=
inode)
>>> =C2=A0=C2=A0{
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (inode->flags & BTRFS_INODE_N=
ODATACOW ||
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inode->f=
lags & BTRFS_INODE_NODATASUM)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (inode->flags & BTRFS_INODE_N=
ODATACOW)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>>> =C2=A0=C2=A0}
>>>
>>> should do the trick. >
>>> The above code was added with the argument that having no checksums wi=
th
>>> compression would damage too much data in case of corruption (
>>> https://lore.kernel.org/linux-btrfs/20180515073622.18732-2-wqu@suse.co=
m/
>>> ).
>>
>> It doesn't make a difference whether it's a single device fs or not.
>> If we don't have csum, the corruption is not only affecting the sector
>> where the corruption is, but the full compressed extent.
> Doesn't really matter if it doesn't happen if btrfs is on a e.g. ceph
> volume.

But this still means, all other regular end user can hit a case where
they set nodatasum for a directory and later corrupt their data.

This will increase the corruption loss, if user just migrate from older
kernel to newer one.

Yeah, you can blame the users for doing that, but I'm still not that
sure if such behavior change is fine.

Especially when this increase the chance of data loss.
It may be fine for ceph, but btrfs still have a wider user base to conside=
r.

> Furthermore it depends on the use-case if corruption affecting
> one page, or a whole compressed block is something one can live with.

That's true, but my point is, at least we shouldn't increase the data
loss possibility for the end users.

If in the past, we allowed NODATASUM + compression, then converting to
current situation, I'm more or less fine, since it reduce the
possibility of data loss.

But not in the other direction.

>>
>> Furthermore, it's not that simple.
>>
>> Current code we always expect compressed read to find some csum.
>> Just check btrfs_submit_compressed_read(), it will call
>> btrfs_lookup_bio_sums().
>> Which will fill the csum array with 0 if it can not find any csum.
>
> It seems to make that conditional w.r.t. BTRFS_INODE_NODATASUM
>
> if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
>  =C2=A0=C2=A0=C2=A0=C2=A0ret =3D btrfs_lookup_bio_sums(inode, comp_bio, =
(u64)-1, sums);
>  =C2=A0=C2=A0=C2=A0=C2=A0BUG_ON(ret); /* -ENOMEM */
> }and in check_compressed_csum: if (inode->flags & BTRFS_INODE_NODATASUM)
> return 0; This seems to have been moved around recently (
> https://github.com/torvalds/linux/commit/334c16d82cfe180f7b262a6f8ae2d93=
79f032b18
> ).

Forgot that patch, I should look one function deeper to confirm the
behavior.

That indeed reduces my concerns from the code point of view.

Thanks,
Qu
>
>>
>> Then at endio callbacks, we verify the csum against the data we read, i=
f
>> it's all zero, the csum will definitely mismatch and discard the data n=
o
>> matter if it's correct or not.
>>
>> The same thing applies to btrfs_submit_compressed_write(), it will
>> always generate csum.
>
> Same here:
>
> int skip_sum =3D inode->flags & BTRFS_INODE_NODATASUM;
>
> ...
>
> if (!skip_sum) {
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ret =3D btrfs_csum_one_bio(inode,=
 bio, start, 1);
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 BUG_ON(ret); /* -ENOMEM */
>  =C2=A0}
>
>>
>> The diff will just give you a false sense of compression without csum.
>> It will still generate csum for write and relies on csum check at read
>> time. >>
>
>
