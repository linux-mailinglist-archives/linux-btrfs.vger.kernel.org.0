Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8141F14155F
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Jan 2020 02:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgARBQl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 20:16:41 -0500
Received: from mout.gmx.net ([212.227.17.20]:55693 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729035AbgARBQl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 20:16:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579310192;
        bh=JEjM7DL3Ent+HoC98aBCkjQIwwvWsHdFSSLA/h85cQk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=AqhKMuyhLh1ssaneeJWlDzClxHInHrr//kbJpuw6asbsTl2HGx1oQUQIxIxxU860K
         ysbw2/ywCKMR4+hqyic/TM1TdTLwXpvxJ4UaC7ehrzb1nrSYMvsyZpxpmSF3VcDxtf
         WyQeo909dzvOabFEA9uCEMPOhUEiXjqV/4jG2A/w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MplXp-1jR8io3doT-00qCTC; Sat, 18
 Jan 2020 02:16:32 +0100
Subject: Re: [PATCH v2] btrfs: scrub: Don't check free space before marking a
 block group RO
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
References: <20191115020900.23662-1-wqu@suse.com>
 <CAL3q7H6jrMYXcLVJ4nYjVXWDxz_Lb-49zD=sq++68ZywL7dKEg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <241a644d-d71c-56c9-5820-aa3b19aacf39@gmx.com>
Date:   Sat, 18 Jan 2020 09:16:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAL3q7H6jrMYXcLVJ4nYjVXWDxz_Lb-49zD=sq++68ZywL7dKEg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="adQHhd1O4aH520U7288uHz0KFZinUBhXP"
X-Provags-ID: V03:K1:CdubYfWH4kg6Alh/jljiYSDG+9JzqLq7RhlI8OWQLfwtEoFuzWJ
 vOl3MGjPVMXjfTpSyc3EF+axo5y85WBZtUZGJQJ3Ob3BJHiqwGrGE+T83CFs5vqv43gxfeG
 gbZnTQQ6oAbe0NC5Vd99w9fZNTX5zwLzDk5yfC5+x28howpjW6UNXWw+ErU29GIZxr0gczy
 NAsLzyBFpan268lvWH5/Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:O5rWONuRgNw=:VXHdGByq+GNDovDiz9C05T
 /UtBdB3Q5uZVRwK+jU5qY+rimAEZGjlcLrTDZ4WtzVFD4/7eiajyGxdCNKg2WaIJYBln+Kg6e
 a5WnnXTb1USnaJhf4oUlE1Y+7RT3F+TfwT+YHYNu06O/EZ/Mtd6PIAmEJYZrUXEkT7KIGMhog
 HAoeiXGI6Vm9OLcv1tfiRj/UHA0ZnNJquUnnspoBSjMkuDvHgzPI421ngUyzikCNamt3gJs2s
 P+omm694qww0Gs83VsUXKCgrI4sG1hjf8CgovYi3UcPZ1P2p8pvz9RHDnDgMEnnQylAwZ6rLz
 c7P+vdRxHsacxLnFYW5q4H4erSF8T+bnNB3qWgq6jU/3HWyvdl1qjZAsWwWP4dPnOwMS17I7X
 DSuKzUlBMr0SE57lFDrlwAkxwYN03zJFfd/v1CNimxZE+z188hk9JuCOL9ipXogIadPeMTGQU
 RK0iBFzEP8GvcQUXMSeEI/++6kdWSD8E/zmBJlQLJFMAT8Ik50akB/eqwcDMGWmgRD1t6jIga
 lsQmnQJCWIutDuTDAOkpbM9IiX/UZM2CIc0bRX+XeflzD+lQT9oEV96xvwNQGTz4EyuYWrf01
 QZT3aKbzUXvko2av1ZLW1jXvPA+Mzzrrp6enUxSGDxJ0Jv5loA4pVeQiCIlQ+JuIvdVsnAmTR
 sDc+8OG8er1Y3MeMaM+l2K3aj9a6ceOqmDnCiObOYNlmRm/XRiVrv7IWwcAUvZ5fDGRb3YUau
 g6nXItjA5Qqhag0jQ92QGMrteaf3OEAKbST/FOPkAOvIrvzrROJSF/FgW6u3z+YBEbC2JIRQj
 vEUPvq7uoFX5vQ1QVUMOujIUjSJnL0Ohwv4H+BirvzqTLa8kf/lLZ+rxaKXvuKaBuaUG9V4cQ
 u3V97Khx4jMLhYqiEmbNhaEhm193FGmqUhYJDVa5easW4+tz9u+g4GqadmOH1g9u9O8yNHxWK
 yP+fuI7M9bdBzZSpXqymS4u96xyP3hcft4gTAlDRX7BnGUmJQCxppwYNKBgH3I7rgQ85NMTUI
 Wx2v0j0wfbiPDfL+boEdtiSrKnDJMfBAQD5nbRIXbs+S54x1BFMIzHif1PmBsygz90JlW9Roa
 qHj8TjYl5919h3srluirH4SVOkKKXAVr0VtAlPsLuybPVHbolpU+XpWhmBAGyTe7sEAyCbG9g
 8mzcyK6dA0K6zV33AmNAktYYcqchCSazn0DNtmmQooSrhBknvpLkAif+uU9oINO47QXVEoQ4c
 v/Zb5/RsLsFJlvgAtRcKrsvJb+NAmlDVw+0tip49B9ilqEtwvu/FXPSxCQiQ=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--adQHhd1O4aH520U7288uHz0KFZinUBhXP
Content-Type: multipart/mixed; boundary="K5j0w86pKdD6z53yjLjJ89JKGIoNoZKmB"

--K5j0w86pKdD6z53yjLjJ89JKGIoNoZKmB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/18 =E4=B8=8A=E5=8D=881:59, Filipe Manana wrote:
> On Fri, Nov 15, 2019 at 2:11 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> When running btrfs/072 with only one online CPU, it has a pretty high
>> chance to fail:
>>
>>   btrfs/072 12s ... _check_dmesg: something found in dmesg (see xfstes=
ts-dev/results//btrfs/072.dmesg)
>>   - output mismatch (see xfstests-dev/results//btrfs/072.out.bad)
>>       --- tests/btrfs/072.out     2019-10-22 15:18:14.008965340 +0800
>>       +++ /xfstests-dev/results//btrfs/072.out.bad      2019-11-14 15:=
56:45.877152240 +0800
>>       @@ -1,2 +1,3 @@
>>        QA output created by 072
>>        Silence is golden
>>       +Scrub find errors in "-m dup -d single" test
>>       ...
>>
>> And with the following call trace:
>>   BTRFS info (device dm-5): scrub: started on devid 1
>>   ------------[ cut here ]------------
>>   BTRFS: Transaction aborted (error -27)
>>   WARNING: CPU: 0 PID: 55087 at fs/btrfs/block-group.c:1890 btrfs_crea=
te_pending_block_groups+0x3e6/0x470 [btrfs]
>>   CPU: 0 PID: 55087 Comm: btrfs Tainted: G        W  O      5.4.0-rc1-=
custom+ #13
>>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06=
/2015
>>   RIP: 0010:btrfs_create_pending_block_groups+0x3e6/0x470 [btrfs]
>>   Call Trace:
>>    __btrfs_end_transaction+0xdb/0x310 [btrfs]
>>    btrfs_end_transaction+0x10/0x20 [btrfs]
>>    btrfs_inc_block_group_ro+0x1c9/0x210 [btrfs]
>>    scrub_enumerate_chunks+0x264/0x940 [btrfs]
>>    btrfs_scrub_dev+0x45c/0x8f0 [btrfs]
>>    btrfs_ioctl+0x31a1/0x3fb0 [btrfs]
>>    do_vfs_ioctl+0x636/0xaa0
>>    ksys_ioctl+0x67/0x90
>>    __x64_sys_ioctl+0x43/0x50
>>    do_syscall_64+0x79/0xe0
>>    entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>   ---[ end trace 166c865cec7688e7 ]---
>>
>> [CAUSE]
>> The error number -27 is -EFBIG, returned from the following call chain=
:
>> btrfs_end_transaction()
>> |- __btrfs_end_transaction()
>>    |- btrfs_create_pending_block_groups()
>>       |- btrfs_finish_chunk_alloc()
>>          |- btrfs_add_system_chunk()
>>
>> This happens because we have used up all space of
>> btrfs_super_block::sys_chunk_array.
>>
>> The root cause is, we have the following bad loop of creating tons of
>> system chunks:
>> 1. The only SYSTEM chunk is being scrubbed
>>    It's very common to have only one SYSTEM chunk.
>> 2. New SYSTEM bg will be allocated
>>    As btrfs_inc_block_group_ro() will check if we have enough space
>>    after marking current bg RO. If not, then allocate a new chunk.
>> 3. New SYSTEM bg is still empty, will be reclaimed
>>    During the reclaim, we will mark it RO again.
>> 4. That newly allocated empty SYSTEM bg get scrubbed
>>    We go back to step 2, as the bg is already mark RO but still not
>>    cleaned up yet.
>>
>> If the cleaner kthread doesn't get executed fast enough (e.g. only one=

>> CPU), then we will get more and more empty SYSTEM chunks, using up all=

>> the space of btrfs_super_block::sys_chunk_array.
>>
>> [FIX]
>> Since scrub/dev-replace doesn't always need to allocate new extent,
>> especially chunk tree extent, so we don't really need to do chunk
>> pre-allocation.
>>
>> To break above spiral, here we introduce a new parameter to
>> btrfs_inc_block_group(), @do_chunk_alloc, which indicates whether we
>> need extra chunk pre-allocation.
>>
>> For relocation, we pass @do_chunk_alloc=3Dtrue, while for scrub, we pa=
ss
>> @do_chunk_alloc=3Dfalse.
>> This should keep unnecessary empty chunks from popping up for scrub.
>>
>> Also, since there are two parameters for btrfs_inc_block_group_ro(),
>> add more comment for it.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>=20
> Qu,
>=20
> Strangely, this has caused some unexpected failures on test btrfs/071
> (fsstress + device replace + remount followed by scrub).

How reproducible?

I also hit rare csum corruptions in btrfs/06[45] and btrfs/071.
That from v5.5-rc6 and misc-next.

In my runs, the reproducibility comes around 1/20 to 1/50.

>=20
> Since I hadn't seen the issue in my 5.4 (and older) based branches,
> and only started to observe the failure in 5.5-rc2+, I left a vm
> bisecting since last week after coming back from vacations.
> The bisection points out to this change. And going to 5.5-rc5 and
> reverting this change, or just doing:
>=20
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 21de630b0730..87478654a3e1 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -3578,7 +3578,7 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx=
,
>                  * thread can't be triggered fast enough, and use up al=
l space
>                  * of btrfs_super_block::sys_chunk_array
>                  */
> -               ret =3D btrfs_inc_block_group_ro(cache, false);
> +               ret =3D btrfs_inc_block_group_ro(cache, true);
>                 scrub_pause_off(fs_info);
>=20
>                 if (ret =3D=3D 0) {
>=20
> which is simpler then reverting due to conflicts, confirms this patch
> is what causes btrfs/071 to fail like this:
>=20
> $ cat results/btrfs/071.out.bad
> QA output created by 071
> Silence is golden
> Scrub find errors in "-m raid0 -d raid0" test

In my case, not only raid0 raid0, but also simple simple.

>=20
> $ cat results/btrfs/071.full
> (...)
> Test -m raid0 -d raid0
> Run fsstress  -p 20 -n 100 -d
> /home/fdmanana/btrfs-tests/scratch_1/stressdir -f rexchange=3D0 -f
> rwhiteout=3D0
> Start replace worker: 17813
> Wait for fsstress to exit and kill all background workers
> seed =3D 1579455326
> dev_pool=3D/dev/sdd /dev/sde /dev/sdf
> free_dev=3D/dev/sdg, src_dev=3D/dev/sdd
> Replacing /dev/sdd with /dev/sdg
> Replacing /dev/sde with /dev/sdd
> Replacing /dev/sdf with /dev/sde
> Replacing /dev/sdg with /dev/sdf
> Replacing /dev/sdd with /dev/sdg
> Replacing /dev/sde with /dev/sdd
> Replacing /dev/sdf with /dev/sde
> Replacing /dev/sdg with /dev/sdf
> Replacing /dev/sdd with /dev/sdg
> Replacing /dev/sde with /dev/sdd
> Scrub the filesystem
> ERROR: there are uncorrectable errors
> scrub done for 0f63c9b5-5618-4484-b6f2-0b7d3294cf05
> Scrub started:    Fri Jan 17 12:31:35 2020
> Status:           finished
> Duration:         0:00:00
> Total to scrub:   5.02GiB
> Rate:             0.00B/s
> Error summary:    csum=3D1
>   Corrected:      0
>   Uncorrectable:  1
>   Unverified:     0
> Scrub find errors in "-m raid0 -d raid0" test
> (...)
>=20
> And in syslog:
>=20
> (...)
> Jan  9 13:14:15 debian5 kernel: [1739740.727952] BTRFS info (device
> sdc): dev_replace from /dev/sde (devid 4) to /dev/sdd started
> Jan  9 13:14:15 debian5 kernel: [1739740.752226]
> scrub_handle_errored_block: 8 callbacks suppressed
> Jan  9 13:14:15 debian5 kernel: [1739740.752228] BTRFS warning (device
> sdc): checksum error at logical 1129050112 on dev /dev/sde, physical
> 277803008, root 5, inode 405, offset 1540096, length 4096, links 1
> (path: stressdir/pa/d2/d5/fa)

Exactly one of my observed sympton.

> Jan  9 13:14:15 debian5 kernel: [1739740.752230]
> btrfs_dev_stat_print_on_error: 8 callbacks suppressed
> Jan  9 13:14:15 debian5 kernel: [1739740.758600] BTRFS error (device
> sdc): bdev /dev/sde errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
> Jan  9 13:14:15 debian5 kernel: [1739740.908263]
> scrub_handle_errored_block: 2 callbacks suppressed
> Jan  9 13:14:15 debian5 kernel: [1739740.929814] BTRFS error (device
> sdc): unable to fixup (regular) error at logical 1129050112 on dev
> /dev/sde
> Jan  9 13:14:15 debian5 kernel: [1739740.929817] BTRFS info (device
> sdc): dev_replace from /dev/sde (devid 4) to /dev/sdd finished
> (...)
>=20
> From a quick look I don't have an idea how this patch causes such
> regression, doesn't seem to make any sense.
>=20
> I changed btrfs/071 to comment out the remount loop
> (https://pastebin.com/X5LiJtpS, the fsstress arguments are to avoid an
> infinite loop during fsync, for which there is a fix already) to see
> if that had any influence - it does not.
> So it seems the problem is device replace and/or scrub only.
>=20
> I can trigger the failure somewhat easily, 1000 iterations of
> btrfs/071 on 5.5-rc5 produced 94 failures like that.

OK, that's more easily reproduced than my environment.

> With this patch reverted (or passing true to
> btrfs_inc_block_group_ro() from scrub), 20108 iterations succeeded (no
> failures at all).

This is very interesting, the iteration number is very convincing, so it
should be some random fix.

>=20
> I haven't tried Josef's recent changes to inc_block_group_ro(), so I
> can't say yet if they fix the problem.

I guess his fix would be similar in behavior. But extra try would always
be good.

>=20
> I can take a closer look next week to see if I can figure out why this
> causes such weird failures, unless you already have an idea.

No idea at all. The only observed clue is, the csum mismatch always
happen in data bgs, no tree blocks so far.

Maybe it's related to data chunk pre-allocation? Then only do the chunk
pre-alloc for data chunks may lead to the same result?

Anyway, thanks for the confirm on the needed iterations to trigger, and
the possible fix for it.

Thanks,
Qu

>=20
> Thanks.
>=20
>>
>> ---
>> This version is based on v5.4-rc1, for a commonly known commit hash.
>> It would cause conflicts due to
>> btrfs_block_group_cache -> btrfs_block_group refactor.
>>
>> The conflicts should be easy to solve.
>>
>> Changelog:
>> v2:
>> - Fix a bug that previous verion never do chunk pre-allocation.
>> - Avoid chunk pre-allocation from check_system_chunk()
>> - Use extra parameter @do_chunk_alloc other than new function with
>>   "_force" suffix.
>> - Skip unnecessary update_block_group_flags() call completely for
>>   do_chunk_alloc=3Dfalse case.
>> ---
>>  fs/btrfs/block-group.c | 49 +++++++++++++++++++++++++++--------------=
-
>>  fs/btrfs/block-group.h |  3 ++-
>>  fs/btrfs/relocation.c  |  2 +-
>>  fs/btrfs/scrub.c       | 21 +++++++++++++++++-
>>  4 files changed, 55 insertions(+), 20 deletions(-)
>>
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>> index bf7e3f23bba7..ae23319e4233 100644
>> --- a/fs/btrfs/block-group.c
>> +++ b/fs/btrfs/block-group.c
>> @@ -2021,8 +2021,17 @@ static u64 update_block_group_flags(struct btrf=
s_fs_info *fs_info, u64 flags)
>>         return flags;
>>  }
>>
>> -int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache)
>> -
>> +/*
>> + * Mark one block group ro, can be called several times for the same =
block
>> + * group.
>> + *
>> + * @cache:             The destination block group
>> + * @do_chunk_alloc:    Whether need to do chunk pre-allocation, this =
is to
>> + *                     ensure we still have some free space after mar=
king this
>> + *                     block group RO.
>> + */
>> +int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache,
>> +                            bool do_chunk_alloc)
>>  {
>>         struct btrfs_fs_info *fs_info =3D cache->fs_info;
>>         struct btrfs_trans_handle *trans;
>> @@ -2052,25 +2061,30 @@ int btrfs_inc_block_group_ro(struct btrfs_bloc=
k_group_cache *cache)
>>                 goto again;
>>         }
>>
>> -       /*
>> -        * if we are changing raid levels, try to allocate a correspon=
ding
>> -        * block group with the new raid level.
>> -        */
>> -       alloc_flags =3D update_block_group_flags(fs_info, cache->flags=
);
>> -       if (alloc_flags !=3D cache->flags) {
>> -               ret =3D btrfs_chunk_alloc(trans, alloc_flags, CHUNK_AL=
LOC_FORCE);
>> +       if (do_chunk_alloc) {
>>                 /*
>> -                * ENOSPC is allowed here, we may have enough space
>> -                * already allocated at the new raid level to
>> -                * carry on
>> +                * if we are changing raid levels, try to allocate a
>> +                * corresponding block group with the new raid level.
>>                  */
>> -               if (ret =3D=3D -ENOSPC)
>> -                       ret =3D 0;
>> -               if (ret < 0)
>> -                       goto out;
>> +               alloc_flags =3D update_block_group_flags(fs_info, cach=
e->flags);
>> +               if (alloc_flags !=3D cache->flags) {
>> +                       ret =3D btrfs_chunk_alloc(trans, alloc_flags,
>> +                                               CHUNK_ALLOC_FORCE);
>> +                       /*
>> +                        * ENOSPC is allowed here, we may have enough =
space
>> +                        * already allocated at the new raid level to
>> +                        * carry on
>> +                        */
>> +                       if (ret =3D=3D -ENOSPC)
>> +                               ret =3D 0;
>> +                       if (ret < 0)
>> +                               goto out;
>> +               }
>>         }
>>
>> -       ret =3D inc_block_group_ro(cache, 0);
>> +       ret =3D inc_block_group_ro(cache, !do_chunk_alloc);
>> +       if (!do_chunk_alloc)
>> +               goto unlock_out;
>>         if (!ret)
>>                 goto out;
>>         alloc_flags =3D btrfs_get_alloc_profile(fs_info, cache->space_=
info->flags);
>> @@ -2085,6 +2099,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_=
group_cache *cache)
>>                 check_system_chunk(trans, alloc_flags);
>>                 mutex_unlock(&fs_info->chunk_mutex);
>>         }
>> +unlock_out:
>>         mutex_unlock(&fs_info->ro_block_group_mutex);
>>
>>         btrfs_end_transaction(trans);
>> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
>> index c391800388dd..0758e6d52acb 100644
>> --- a/fs/btrfs/block-group.h
>> +++ b/fs/btrfs/block-group.h
>> @@ -205,7 +205,8 @@ int btrfs_read_block_groups(struct btrfs_fs_info *=
info);
>>  int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 byte=
s_used,
>>                            u64 type, u64 chunk_offset, u64 size);
>>  void btrfs_create_pending_block_groups(struct btrfs_trans_handle *tra=
ns);
>> -int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache);
>> +int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache,
>> +                            bool do_chunk_alloc);
>>  void btrfs_dec_block_group_ro(struct btrfs_block_group_cache *cache);=

>>  int btrfs_start_dirty_block_groups(struct btrfs_trans_handle *trans);=

>>  int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans);=

>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index 00504657b602..fd6df6dd5421 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -4325,7 +4325,7 @@ int btrfs_relocate_block_group(struct btrfs_fs_i=
nfo *fs_info, u64 group_start)
>>         rc->extent_root =3D extent_root;
>>         rc->block_group =3D bg;
>>
>> -       ret =3D btrfs_inc_block_group_ro(rc->block_group);
>> +       ret =3D btrfs_inc_block_group_ro(rc->block_group, true);
>>         if (ret) {
>>                 err =3D ret;
>>                 goto out;
>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>> index f7d4e03f4c5d..7e48d65bbdf6 100644
>> --- a/fs/btrfs/scrub.c
>> +++ b/fs/btrfs/scrub.c
>> @@ -3563,7 +3563,26 @@ int scrub_enumerate_chunks(struct scrub_ctx *sc=
tx,
>>                  * -> btrfs_scrub_pause()
>>                  */
>>                 scrub_pause_on(fs_info);
>> -               ret =3D btrfs_inc_block_group_ro(cache);
>> +
>> +               /*
>> +                * Don't do chunk preallocation for scrub.
>> +                *
>> +                * This is especially important for SYSTEM bgs, or we =
can hit
>> +                * -EFBIG from btrfs_finish_chunk_alloc() like:
>> +                * 1. The only SYSTEM bg is marked RO.
>> +                *    Since SYSTEM bg is small, that's pretty common.
>> +                * 2. New SYSTEM bg will be allocated
>> +                *    Due to regular version will allocate new chunk.
>> +                * 3. New SYSTEM bg is empty and will get cleaned up
>> +                *    Before cleanup really happens, it's marked RO ag=
ain.
>> +                * 4. Empty SYSTEM bg get scrubbed
>> +                *    We go back to 2.
>> +                *
>> +                * This can easily boost the amount of SYSTEM chunks i=
f cleaner
>> +                * thread can't be triggered fast enough, and use up a=
ll space
>> +                * of btrfs_super_block::sys_chunk_array
>> +                */
>> +               ret =3D btrfs_inc_block_group_ro(cache, false);
>>                 if (!ret && sctx->is_dev_replace) {
>>                         /*
>>                          * If we are doing a device replace wait for a=
ny tasks
>> --
>> 2.24.0
>>
>=20
>=20


--K5j0w86pKdD6z53yjLjJ89JKGIoNoZKmB--

--adQHhd1O4aH520U7288uHz0KFZinUBhXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4iXGwACgkQwj2R86El
/qhulAgAnzvJwDwP5pWUm+ULzI9MoOCxK3TODaW+/tXWobTglQ0ODvGrXHXuFwW6
mFP7iew+BJvNtAV2SsSMtBV+q6cKT7yjU6Cu/qVnnlLDlXpitu2v1TcElzYidsNb
3N7QbJKBF0YdzcSjDlo/MWB4GTRwICZ8XdQH9Ko9NW+BNIvP9V0vgO+JZ1nrFI0Z
R3WXW1QG5xJt+Fo+f/mUPDy4CPqUVnuzPwW8xRmvYdITlzeIRqUTqkmy9sb4dknz
Gq8TasCpCZmZiHH/MQ32C6L/ULEcD61DdfmagEwaDATXI67jgjJpH7QN59Biw8JD
qxLZ87LGPWUjupm4bDwy4CJu2+zniA==
=g3x3
-----END PGP SIGNATURE-----

--adQHhd1O4aH520U7288uHz0KFZinUBhXP--
