Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DAA52B83D
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 May 2022 13:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbiERK7U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 May 2022 06:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235152AbiERK7T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 May 2022 06:59:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B2B6278
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 03:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652871553;
        bh=bIHjORdFkFbnsFba8LXzyuwu7lAgA+3Co6schutC/dY=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=QLPENQaj1Q7bkHc6Wnrc4klAj8jxkq1/J41DWwZh7BjUuClWGppqbvp9q/diiqcYF
         LqZGWuL+/ePl16+majzG/Hsu0+YbYx4Bv9v0ZhS5TUDNuL0r71ahbTOP/XDNykFk6d
         G0bTOgu9qExex8vQQ/OIz5anSvkYZbZJKJEWr4eo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MmDEg-1nQmHY3Xwe-00iGZv; Wed, 18
 May 2022 12:59:13 +0200
Message-ID: <e62b429d-358e-ec38-30ca-671d43a5b5be@gmx.com>
Date:   Wed, 18 May 2022 18:59:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Johannes Kastl <kastl@b1-systems.de>, linux-btrfs@vger.kernel.org
References: <17981e45-a182-60ce-5a02-31616609410a@b1-systems.de>
 <21dd5ba9-8dc0-7792-d5f4-4cd1ea91d75e@gmx.com>
 <53dabec5-14de-ed6f-1ef9-a300b96333a6@b1-systems.de>
 <00dcf063-aa51-e8f3-9664-d6ca97306711@gmx.com>
 <05775b94-7e69-99ce-f89e-5c7e634f5461@b1-systems.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: 'btrfs rescue' command (recommended by btrfs check) fails on old
 BTRFS RAID1 on (currently) openSUSE Leap 15.3
In-Reply-To: <05775b94-7e69-99ce-f89e-5c7e634f5461@b1-systems.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EbHzEY9TWvQJgeRrDYQtD1ToFyfrqKf3ceqZ8cgwogwqYmYQPjK
 4nnAOfKQj3w72oUBzQOVZNraw9EXYFTRuLMYCmm41PDv6y7bftiKLCWh71JEA4xwUs08YCA
 76DtWMlLLU6b+IQLpoVndjB5TjxU2u1awObBMNkIRM1BOCa0XnEblL+r/7fhqNe0/6hSMKD
 yuGX34YrCj46Kqda4iuIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8OXgNjCun2s=:zeFnNqAnkpiIj7YGrBDI54
 SPf42LVdDFFuewuiyeA9TLr5NkJ8mud8tQ26W6lGEWT5QWv1jJylm4CAHy7YQWAlDdL0u0xpX
 1PHyRk3AYamrPU/NRMjqqUPvtheX5WlGQaswxNZpAOqXgEDj8+FezvCSbl0VO95dA6VcuLPcx
 vJJHc530NTektY/GVxxAcn59CwYoGTASvMoJ8rlK6INPGpVzwoRCh0eVhqGLxJ4MQlfHAUlcw
 fhFuvok8R2iDCOviiLU0ZR/qU/Zw2y7L+vxSC5T5KiXM3PrtBNPvndahJSp75sz+qkg/PXBCo
 JhQyxMvNLXs9irvMOO3fsYRggOk3mbKNhIk/p2Vm6IcK1R93951N8SfXNnssc1Zdcbed0IQ1z
 ymwkaLSobIzJOdcqWUnyqYkR9lMTH1k1xZSgLlrxAsTz2jCHlc9TkbFj/st0ecBzi0xMWuncr
 03AIXM1IV3pXHGuilATyAPRSe8CigIBVnSrTn7S1qZinVI+lcgY3yL8i70+bB0DyG6+dILqq7
 oFmMArKfmswsMOtwy52o2sh4ILdYFb/9cJoq7rukdbbiXUQyCAekvqJcZbkrq92y6JPXHvKmE
 UALZuGGWOW15CQKgK6JWJvdYbe1QCfTkHYL6hlt+rG2mj2iBy1pDYgEEsIn/ZO6yFY7IPsM5j
 fU/ou12yesjCfgpPXaU1jDtckL2BXCUUe8kCnSTSxSUlH5v6UcrjZj6NsRjx01Wtmu2RBbTs/
 TmXPePPYp61gy4ebYIDZar68xF41CbIsRGVgBGKBYKydnV1iWLuw2SuiQs3geEBJsa5e0yNbx
 nio/4p9aV7INFW/MyJCXT/aDs5ZIeSKNjPWtFFm5byb0feaPVqV3oYAgzRZ4vvcbj3Xmzi/Hw
 OON01/BOj97kCl7aRyJSrHDXdEGPqjt12fm/nocH8vK2NqN4MUwTACUWS6jdcCb15Hdr0mrlV
 H2VSYb9TJ4wbG5OtYdCqL2cA39R6Vku4j+TOrb1z2HvazypL/JLldTt+r7kwloNyU+F1BG5PP
 Pt15zPIsntYG3tsnx2E1lwRnsPKk358hUroSChX+pdDXfARFxbX6Sx0EtCW0teE5ENSVs+lws
 az1fPZ7IeBPWnIsjd8JNdx6SknQ4H72AzUDM8bDPBkRT8z8WvFSgD1CJQ==
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/18 18:38, Johannes Kastl wrote:
> Hi Qu,
>
> TL;DR: took a while until I had all of the data backed up properly and
> had some time to test this. Unfortunately the filesystem is now no
> longer mountable...
>
> Any ideas?
>
> Johannes
>
> On 24.04.22 at 11:21 Qu Wenruo wrote:
>> On 2022/4/24 17:10, Johannes Kastl wrote:
>
>>> So would resizing the filesystem (to 8GiB) workaround this "limitation=
",
>>> so afterwards it could properly fix the device size?
>>
>> I'm not yet sure if it's a bug in progs causing false ENOSPC, or really
>> there isn't many space left.
>>
>> For the former case, no matter how much free space you have, it won't
>> help.
>>
>> For the latter case, it would definitely help.
>
> So, I deleted the partitions on both disks and re-created them with the
> new (bigger size), keeping the start sector and the btrfs signature inta=
ct.
>
> I could then resize both disks to the same value successfully. At least,
> the commands ran without errors.
>
> Fixing the device size fails nonetheless (see below). And I can no
> longer mount the filesystem, when I try I find this in the logs:
>
>> [87396.889043] BTRFS error (device sdb1): super_total_bytes
>> 15393162784768 mismatch with fs_devices total_rw_bytes 15393162788864
>> [87396.889974] BTRFS error (device sdb1): failed to read chunk tree: -2=
2
>> [87396.892741] BTRFS error (device sdb1): open_ctree failed
>
> (Don't get confused by sdb1, this is from a rescue system with only some
> HDDs attached)
>
> Fixing the device-size on Leap 15.3:
>> # btrfs filesystem show /mnt/DUMBO_BACKUP_4TB/
>> Label: 'DUMBO_BACKUP_4TB'=C2=A0 uuid: 50651b41-bf33-47e7-8a08-afbc71ba0=
bf8
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 2 FS bytes use=
d 3.17TiB
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 si=
ze 7.00TiB used 3.64TiB path /dev/sdd1
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 2 si=
ze 7.00TiB used 3.63TiB path /dev/sdc1

That's super weird, we have tons of unallocated space.

So definitely something wrong in btrfs-progs.
Normally `btrfs fi usage` would provide more info, but it needs the fs
to be mountable.

Can you prepare a building environment for btrfs-progs?

I can update the code to skip transaction commit so that we won't be
bother with -ENOSPC at all.

And since we're not really doing any metadata update, we don't really
need any new space.

And after your building environment prepared, you can fetch this branch
to compile the btrfs-progs and try to use the compiled `btrfs` command
to rescue the device again.

https://github.com/adam900710/btrfs-progs/tree/dirty_fix

I did some local tests, it shows no problem, but not sure if it would
work for you.

Thanks,
Qu

>>
>> # umount /mnt/DUMBO_BACKUP_4TB
>> # btrfs rescue fix-device-size /dev/sdd1
>> Unable to find block group for 0
>> Unable to find block group for 0
>> Unable to find block group for 0
>> transaction.c:189: btrfs_commit_transaction: BUG_ON `ret` triggered,
>> value -28
>> btrfs(+0x51f99)[0x55edf7a43f99]
>> btrfs(+0x525a9)[0x55edf7a445a9]
>> btrfs(btrfs_fix_super_size+0x98)[0x55edf7a2f438]
>> btrfs(btrfs_fix_device_and_super_size+0x84)[0x55edf7a2f584]
>> btrfs(+0x6ceee)[0x55edf7a5eeee]
>> btrfs(main+0x8e)[0x55edf7a1108e]
>> /lib64/libc.so.6(__libc_start_main+0xef)[0x7f672ad962bd]
>> btrfs(_start+0x2a)[0x55edf7a1128a]
>> Aborted (core dumped)
>> #
>
> I tested fixing the device-id by booting from a Tumbleweed rescue stick,
> running kernel 5.16 with btrfsprogs 5.16. This also fails, but spits out
> an error message that is a little different:
>
>  > [...]
>> Unable to find block group for 0
>> Error: failed to commit current transaction: -28 (No space left on
>> device)
>> No device size related problem found
>> ERROR: commit_root already set when starting transaction
>> extent buffer leak: start ... len 16384
>
> (I had to type this off of the screen)
>
> As the mounting failed with an error related to chunks, I tried the
> btrfs rescue chunk-recover command, but that also aborts and dumps a
> core, even on Tumbleweed with kernel 5.16...
>
> The error messages look something like this:
>  > Unable to find block group for 0
>  > Unable to find block group for 0
>  > Unable to find block group for 0
>
> followed by a "...BUG_ON `ret` triggered, value -28"
>
> So this could all be related to -28 (No space left on device)?
>
