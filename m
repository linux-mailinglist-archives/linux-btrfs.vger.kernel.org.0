Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355857B27C8
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 23:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjI1V5L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Sep 2023 17:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjI1V5J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Sep 2023 17:57:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F098199
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Sep 2023 14:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1695938222; x=1696543022; i=quwenruo.btrfs@gmx.com;
 bh=UUC0z4sVUzEBHkw8070grbnLHlycZA5Za7vihpgYUas=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=rx5/gV3d3GtMRyvysOETilsmMrpfLQO1LfCdFhBT2Ujqtlb6CmJ7k9Q0vb9hfJCPjOCqI6qNt6s
 8ymMUbx0+qriljF1qHRbCljBiJch6lr6AMB7cVxRR/FANvgIbl6ng0nsgI9l4Z9rhpepO2XJwue7H
 +w2bqi3lASFeYsb94m6sfp45TkKmNpYjK6Q00oG5lisXcC68p62JvmfVO3ZhQ6JkryvMQcCd4L+sv
 ZGoSDy6FM7w+9HYkY/H5ckAl49+taRaa/uf3y0zd7HOuhHsrDuxXeQGGlXzdc9lBoL0AxJnYQ2tMJ
 70m+li66LlK6GPViwvX7DnwmHR4PgHvWzkug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4hvb-1rkVXG44Od-011jGo; Thu, 28
 Sep 2023 23:57:02 +0200
Message-ID: <e834fd8a-3c10-4b5c-9121-9812f460f73c@gmx.com>
Date:   Fri, 29 Sep 2023 07:26:58 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: fix failed resume due to bad search
To:     Konstantinos Skarlatos <k.skarlatos@gmail.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <840a9a762a3a0b8365d79dd7c23d812d95761dcf.1695855009.git.wqu@suse.com>
 <fc926390-38ea-f764-4377-25576b872b31@gmail.com>
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
In-Reply-To: <fc926390-38ea-f764-4377-25576b872b31@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aRBmEhwvJdp7/6QGFJQ9n5YRv1+Nt9S136xzZvkcB3/4FErXp3K
 NJP3VR+T4rbdBdU6cFIVJnRkFJb+x7HFum6kaYciEOyD+fHBHrGfWuSFS43XIAy+JjgQ/x+
 g6BcCcM5YlJigmqo6nRz5hlIGhrvKorIs4zJadC9q5Kiji6dpzI3J0jurVquJcbEX7luRvB
 ZeteAg75KwaLKtcX04eLQ==
UI-OutboundReport: notjunk:1;M01:P0:AzYopjSq/KA=;Jbnrb3GzBN2/JoLDZvkYlZBF5Te
 2RZIOeZgq/z0ZmMqH8l/bILEwf4JjD6jrZCmtRMX2LGzk2yNfD2/r5B3coVINzc2kzxFkVlNY
 O8CJWY3yKRdHBsoRdUYtGXBaSGW4x0+2D3134BIyWPsCsaE8EETDWNikdKMbAumCGfkBDuZGj
 7nCHOewTnTEyRGFKjDNyRvVHTd2LXBLiLze/8tOLB9P/eIOuXa+GMi5o4o9MuRs9aBtQdPpZW
 nMSi3SN2/YOYX8X2GQLJzyMO2LsWuRXXkjjd98IA8Be6PK3mxo6Blbx5r9SUYmyKaxlGLaOOw
 bBXuG5Lc3YsZjXfJlsEvRUxh68Hw0YtaqflXU4QGKUXonIFd6yzx1pRZl+dtRYYGpjMd/OpQr
 Lm5ZVeuwFgfmNmQh9SZq1H3/tPY5vmfjr9WRQs6FXr32HDTD1GzhMVeid6r2sQMbrKFH/Yffm
 HSM7l0XhtjQ3e/M+NXMwxynzZPD62wUKSCpySzKfoXUVmxR9nMP52jH7xvMZupD7JFm4gyKSo
 0F4GplEt1HxIYGxOV8lr+fgzfpifEakvxzfgZQRgW9EGsCIJLzlcdcZx5OWM1mo3mPyQha89I
 c7cXLWdZ2/eYHFjZss8iWPmWm9mK39AS6bn+ftjcUhneknd2iCOUb8xxeHxpq6S6WO+jFxSpS
 fhegUNrA7G2tW6quAN6MGyfyAcaPIAj98WmeNOtq31wsJGxuJ7Y1+Z1EhEnGNsPBlFIkt/R6R
 uqMDlffnV0cc+pX42KHzfJHJ1Byibf//gVRT3/MigtsLXRzqrkD66dqJOSjPxf99WTTJilHJT
 zvu20Tu5d6t6dafHJdIiI+FgGQvs6K/UO2uovL2qYQ4wf2mBH+oVq4wh4XFAaS4cNNhVwCzOl
 cCt0jiBv6wLXuyGjxP79WVu0DaCF4RemCpSluDCRA7hyC3hwFN9o0RAkrTuISg9lbUe1N1DUF
 MHDZ39axVKGtODtXGGtPKh71O3w=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/29 00:23, Konstantinos Skarlatos wrote:
> Hi Qu, thanks for your patch. I just tried it on a clean btrfs-progs
> tree with my filesystem:
>
> =E2=9D=AF ./btrfstune --convert-to-block-group-tree /dev/sda
> [1]=C2=A0=C2=A0=C2=A0 796483 segmentation fault (core dumped)=C2=A0 ./bt=
rfstune
> --convert-to-block-group-tree /dev/sda

Mind to enable debug build by "make D=3D1" for btrfs-progs, and go with
gdb to show the crash callback?

I assume it could be the same crash from your initial report.

Thanks,
Qu

>
> Sep 28 17:46:17 elsinki kernel: btrfstune[796483]: segfault at
> ffffffffff000f2f ip 0000564b6c2107aa sp 00007ffdc8ad25c8 error 5 in
> btrfstune[564b6c1d1000+5b000] likely on CPU 3 (core 2, socket 0)
> Sep 28 17:46:17 elsinki kernel: Code: ff 48 8b 34 24 48 8d 3d 5a d8 01
> 00 b8 00 00 00 00 e8 5a 37 00 00 48 8b 33 bf 0a 00 00 00 e8 1d 0c fc ff
> eb a8 e8 86 0a fc ff <48> 8b 4f 20 48 8b 56 08 48 89 c8 48 03 47 28 48
> 89 c7 b8 01 00 00
> Sep 28 17:46:17 elsinki systemd[1]: Created slice Slice
> /system/systemd-coredump.
> Sep 28 17:46:17 elsinki systemd[1]: Started Process Core Dump (PID
> 796493/UID 0).
> Sep 28 17:46:21 elsinki systemd-coredump[796494]: [=F0=9F=A1=95] Process=
 796483
> (btrfstune) of user 0 dumped core.
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Stack trace of thread
> 796483:
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 #0 0x0000564b6c2107aa
> n/a (/root/btrfs-progs/btrfstune + 0x4d7aa)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ELF object binary
> architecture: AMD x86-64
> Sep 28 17:46:21 elsinki systemd[1]: systemd-coredump@0-796493-0.service:
> Deactivated successfully.
> Sep 28 17:46:21 elsinki systemd[1]: systemd-coredump@0-796493-0.service:
> Consumed 4.248s CPU time.
>
>
> On 28/9/2023 1:50 =CF=80.=CE=BC., Qu Wenruo wrote:
>> [BUG]
>> There is a bug report that when converting to bg tree crashed, the
>> resulted fs is unable to be resumed.
>>
>> This problems comes with the following error messages:
>>
>> =C2=A0=C2=A0 ./btrfstune --convert-to-block-group-tree /dev/sda
>> =C2=A0=C2=A0 ERROR: Corrupted fs, no valid METADATA block group found
>> =C2=A0=C2=A0 ERROR: failed to delete block group item from the old root=
: -117
>> =C2=A0=C2=A0 ERROR: failed to convert the filesystem to block group tre=
e feature
>> =C2=A0=C2=A0 ERROR: btrfstune failed
>> =C2=A0=C2=A0 extent buffer leak: start 17825576632320 len 16384
>>
>> [CAUSE]
>> When resuming a interrupted conversion, we go through
>> read_converting_block_groups() to handle block group items in both
>> extent and block group trees.
>>
>> However for the block group items in the extent tree, there are several
>> problems involved:
>>
>> - Uninitialized @key inside read_old_block_groups_from_root()
>> =C2=A0=C2=A0 Here we only set @key.type, not setting @key.objectid for =
the initial
>> =C2=A0=C2=A0 search.
>>
>> =C2=A0=C2=A0 Thus if we're unlukcy, we can got (u64)-1 as key.objectid,=
 and exit
>> =C2=A0=C2=A0 the search immediately.
>>
>> - Wrong search direction
>> =C2=A0=C2=A0 The conversion is converting block groups in descending or=
der, but the
>> =C2=A0=C2=A0 block groups read is in ascending order.
>> =C2=A0=C2=A0 Meaning if we start from the last converted block group, w=
e would at
>> =C2=A0=C2=A0 most read one block group.
>>
>> [FIX]
>> To fix the problems, this patch would just remove
>> read_old_block_groups_from_root() function completely.
>>
>> As for the conversion, we ensured the block group item is either in the
>> old extent or the new block group tree.
>> Thus there is no special handling needed reading block groups.
>>
>> We only need to read all block groups from both trees, using the same
>> read_old_block_groups_from_root() function.
>>
>> Reported-by: Konstantinos Skarlatos <k.skarlatos@gmail.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> To Konstantinos:
>>
>> The bug I fixed here can explain all the failures you hit (the initial
>> one and the one after the quick diff).
>>
>> Please verify if this helps and report back (without the quick diff in
>> the original thread).
>>
>> We may have other corner cases to go, but I believe the patch itself is
>> necessary no matter what, as the deleted code is really
>> over-engineered and buggy.
>> ---
>> =C2=A0 kernel-shared/extent-tree.c | 79 +------------------------------=
------
>> =C2=A0 1 file changed, 1 insertion(+), 78 deletions(-)
>>
>> diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
>> index 7022643a9843..4d6bf2b228e9 100644
>> --- a/kernel-shared/extent-tree.c
>> +++ b/kernel-shared/extent-tree.c
>> @@ -2852,83 +2852,6 @@ out:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 }
>> -/*
>> - * Helper to read old block groups items from specified root.
>> - *
>> - * The difference between this and read_block_groups_from_root() is,
>> - * we will exit if we have already read the last bg in the old root.
>> - *
>> - * This is to avoid wasting time finding bg items which should be in t=
he
>> - * new root.
>> - */
>> -static int read_old_block_groups_from_root(struct btrfs_fs_info
>> *fs_info,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btr=
fs_root *root)
>> -{
>> -=C2=A0=C2=A0=C2=A0 struct btrfs_path path =3D {0};
>> -=C2=A0=C2=A0=C2=A0 struct btrfs_key key;
>> -=C2=A0=C2=A0=C2=A0 struct cache_extent *ce;
>> -=C2=A0=C2=A0=C2=A0 /* The last block group bytenr in the old root. */
>> -=C2=A0=C2=A0=C2=A0 u64 last_bg_in_old_root;
>> -=C2=A0=C2=A0=C2=A0 int ret;
>> -
>> -=C2=A0=C2=A0=C2=A0 if (fs_info->last_converted_bg_bytenr !=3D (u64)-1)=
 {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We know the last co=
nverted bg in the other tree, load the
>> chunk
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * before that last co=
nverted as our last bg in the tree.
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ce =3D search_cache_extent(=
&fs_info->mapping_tree.cache_tree,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_info->last_converte=
d_bg_bytenr);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ce || ce->start !=3D f=
s_info->last_converted_bg_bytenr) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err=
or("no chunk found for bytenr %llu",
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_info->last_converted_bg_bytenr);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn -ENOENT;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ce =3D prev_cache_extent(ce=
);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We should have prev=
ious unconverted chunk, or we have
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * already finished th=
e convert.
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASSERT(ce);
>> -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 last_bg_in_old_root =3D ce-=
>start;
>> -=C2=A0=C2=A0=C2=A0 } else {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 last_bg_in_old_root =3D (u6=
4)-1;
>> -=C2=A0=C2=A0=C2=A0 }
>> -
>> -=C2=A0=C2=A0=C2=A0 key.type =3D BTRFS_BLOCK_GROUP_ITEM_KEY;
>> -
>> -=C2=A0=C2=A0=C2=A0 while (true) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D find_first_block_gr=
oup(root, &path, &key);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret > 0) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
 =3D 0;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 got=
o out;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret !=3D 0) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 got=
o out;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_item_key_to_cpu(path.=
nodes[0], &key, path.slots[0]);
>> -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D read_one_block_grou=
p(fs_info, &path);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0 && ret !=3D -EN=
OENT)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 got=
o out;
>> -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* We have reached last bg =
in the old root, no need to
>> continue */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (key.objectid >=3D last_=
bg_in_old_root)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bre=
ak;
>> -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (key.offset =3D=3D 0)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key=
.objectid++;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key=
.objectid =3D key.objectid + key.offset;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key.offset =3D 0;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_release_path(&path);
>> -=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 ret =3D 0;
>> -out:
>> -=C2=A0=C2=A0=C2=A0 btrfs_release_path(&path);
>> -=C2=A0=C2=A0=C2=A0 return ret;
>> -}
>> -
>> =C2=A0 /* Helper to read all block groups items from specified root. */
>> =C2=A0 static int read_block_groups_from_root(struct btrfs_fs_info *fs_=
info,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct btrfs_root *root)
>> @@ -2989,7 +2912,7 @@ static int read_converting_block_groups(struct
>> btrfs_fs_info *fs_info)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 ret =3D read_old_block_groups_from_root(fs_info, ol=
d_root);
>> +=C2=A0=C2=A0=C2=A0 ret =3D read_block_groups_from_root(fs_info, old_ro=
ot);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error("failed to=
 load block groups from the old root: %d",
>> ret);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
