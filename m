Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCD55142786
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jan 2020 10:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgATJny (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jan 2020 04:43:54 -0500
Received: from mout.gmx.net ([212.227.15.15]:58113 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgATJny (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jan 2020 04:43:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579513426;
        bh=/8Cj6MWiBVcU7t4PoxIY3nYAx3eanffxDYDYgdbQO/M=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=givvxcyHAp7ljJgaAR56j4MdDcubTTcDTo/bgHw7Q3PtI/jurwP4hLOLUAUozmybU
         7iBRyA5kyTJ8Y54EwCCS8ZqRLCC4Rn0+WhgvtnNkPWsdRQjDQ7NXdJhfPkIPlpaUbQ
         Zj4cUkP3Bfv8qqaWbWTH4NuJ9r9UoWCS/F12INsY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MEFzr-1ijGSq2LWX-00ADtc; Mon, 20
 Jan 2020 10:43:46 +0100
Subject: Re: [PATCH v2] btrfs: scrub: Don't check free space before marking a
 block group RO
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
References: <20191115020900.23662-1-wqu@suse.com>
 <CAL3q7H6jrMYXcLVJ4nYjVXWDxz_Lb-49zD=sq++68ZywL7dKEg@mail.gmail.com>
 <241a644d-d71c-56c9-5820-aa3b19aacf39@gmx.com>
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
Message-ID: <71084455-3033-d5ee-5694-6c2176562e50@gmx.com>
Date:   Mon, 20 Jan 2020 17:43:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <241a644d-d71c-56c9-5820-aa3b19aacf39@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Xnn9ighDmZptlfLCEkuFCstyErglMa4GR"
X-Provags-ID: V03:K1:ZsTiEiQCYJcapoxcKrX9Pfru6s4N0lxPEnjGUjQs3yLIAQ1NuSq
 glSkvNLpIPGvCvwPmhGh6Xawt0Q9Oj0CUqgzjigGi/eSEQUUbOJLeHYzpVzWyfG0GM7Httj
 ocAth9tbNil+k0HrsmD0iunrqScjDS0HeX10QC3FhpBFrywKS+cGll5RSboQ3+LfynrO5tD
 RTafLxRjLl4hjH33AZQSw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DCcHDyxYRGQ=:Q2rOTnzRWjaefpO5FJsQ7r
 HtqjbCDQY8hjs+p8J8OW0FzxxOSP9+KGKXxy3mOxtMn1VS6VJuGGjZBAtUCmY4xtwmToWrjus
 qUQBijegfF9PW1EaRdD6qEUcri3X9FdFl+3idbw+r9Mo/taeD3fbRya3slJOA/FNN67Z0Ek5B
 Gdsewgzm08GRC1R1OkTGJcZPI6YbBPfKPnfvckq4niIRYCsqJ/CvqUMw3nv6hzWlY+mUd3Mr2
 Zm7rLzXEGTO9yF15VLyU2ifh0CVT47RrLntE9wlublXSOP7JhpRGhPSATy6YBU21o5YbRVJaU
 GObIUBeDy7SdKPtEPza1t9GleIcQ7Q+e1GICSygQeES/cPxNAnBVIB+3G+UG7BC+9b7CwNJ2M
 6rJJD7lKHy5PTgwuCjuMIXM7Y4KR/nyFjyBHuOeGEJqb8XGY3cxXtwcwAhyORG+2RVAGIXrzK
 gRP2nh4g6Cl4C5EmQp1gQ5sEHETJj4xAUTA4cHfCw9Mvqg4yZW+7sd9HbhtmhsRyVR3WmTJB3
 OygV9TymwCz3tlxyKH3jQsXa6gdMDffBw+Tr7Yn9rQyNBufk6Cx3+eFRyzG01wyjvjY90QMGV
 EGl5pZFLhYcHy51KoOxOLHko7+FtPcxY18+G58HH3J0bQXVTuXYyYWHEUbD+KVoR5BqUQ9uTR
 66HuOueLPh3w7F3V4HI0z0JO2hrqftmJ9HSHYmLhPgmhRByBBAklLWH3nyxvjiSUYbe+nY/Le
 ErbhgTqlR7Etrp7t/+1kVd76tzhdX7exA4ydP7qsURaD88TwdJnDTrNK65qUFDRMcQ2uy2h/f
 P74VZ7ZKwleHuck+QWZ89kXU8PITRTRXvZGxNmJWULT+oldveECi0DL8ln9xV/Pc0pgnY4Knm
 pYO0RiRP1dBM6d2pbLvgApxjewxq7rNjMZNQCcqlJbAVn73y7TJSU2+p31lTzLezC2XgaKwE1
 06uF75ozFX6ua/Q7iamLF1rB50DZ5xLpPtLOS6AKpH/xYfGkLY2L/syO7xyDHnQt4/VXx5UeI
 WgbVoYXHmt5yQ/KdhbPP3VdqloHwPU+GNgLO1Jd2LdPASLNJFXXAF+fPotH2netEG8sNnTrKg
 10i2QqJR2PsfQyr4HNYDNi+DBBeKujOmgZhZORrgVeJmm7fB7fqDmWKLHW1TkLWsqF6JcKHrU
 wtEm6i6w4MkVamypXsiknjrXzJ88qAj11vBreOuYZmoO7Gkqjm4PJ4oR9h4doEvZuNIG/FRrZ
 ThYHS9qjTsjfewZyuQltBRw18zcBbUho1DMqxtaDz69NZos7deucdm5cl/ao=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Xnn9ighDmZptlfLCEkuFCstyErglMa4GR
Content-Type: multipart/mixed; boundary="KlfHwDLCBXBNZMHWGPKBhXDAgJTIRlgXN"

--KlfHwDLCBXBNZMHWGPKBhXDAgJTIRlgXN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/18 =E4=B8=8A=E5=8D=889:16, Qu Wenruo wrote:
>=20
>=20
> On 2020/1/18 =E4=B8=8A=E5=8D=881:59, Filipe Manana wrote:
>> On Fri, Nov 15, 2019 at 2:11 AM Qu Wenruo <wqu@suse.com> wrote:
>>>
>>> [BUG]
>>> When running btrfs/072 with only one online CPU, it has a pretty high=

>>> chance to fail:
>>>
>>>   btrfs/072 12s ... _check_dmesg: something found in dmesg (see xfste=
sts-dev/results//btrfs/072.dmesg)
>>>   - output mismatch (see xfstests-dev/results//btrfs/072.out.bad)
>>>       --- tests/btrfs/072.out     2019-10-22 15:18:14.008965340 +0800=

>>>       +++ /xfstests-dev/results//btrfs/072.out.bad      2019-11-14 15=
:56:45.877152240 +0800
>>>       @@ -1,2 +1,3 @@
>>>        QA output created by 072
>>>        Silence is golden
>>>       +Scrub find errors in "-m dup -d single" test
>>>       ...
>>>
>>> And with the following call trace:
>>>   BTRFS info (device dm-5): scrub: started on devid 1
>>>   ------------[ cut here ]------------
>>>   BTRFS: Transaction aborted (error -27)
>>>   WARNING: CPU: 0 PID: 55087 at fs/btrfs/block-group.c:1890 btrfs_cre=
ate_pending_block_groups+0x3e6/0x470 [btrfs]
>>>   CPU: 0 PID: 55087 Comm: btrfs Tainted: G        W  O      5.4.0-rc1=
-custom+ #13
>>>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/0=
6/2015
>>>   RIP: 0010:btrfs_create_pending_block_groups+0x3e6/0x470 [btrfs]
>>>   Call Trace:
>>>    __btrfs_end_transaction+0xdb/0x310 [btrfs]
>>>    btrfs_end_transaction+0x10/0x20 [btrfs]
>>>    btrfs_inc_block_group_ro+0x1c9/0x210 [btrfs]
>>>    scrub_enumerate_chunks+0x264/0x940 [btrfs]
>>>    btrfs_scrub_dev+0x45c/0x8f0 [btrfs]
>>>    btrfs_ioctl+0x31a1/0x3fb0 [btrfs]
>>>    do_vfs_ioctl+0x636/0xaa0
>>>    ksys_ioctl+0x67/0x90
>>>    __x64_sys_ioctl+0x43/0x50
>>>    do_syscall_64+0x79/0xe0
>>>    entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>>   ---[ end trace 166c865cec7688e7 ]---
>>>
>>> [CAUSE]
>>> The error number -27 is -EFBIG, returned from the following call chai=
n:
>>> btrfs_end_transaction()
>>> |- __btrfs_end_transaction()
>>>    |- btrfs_create_pending_block_groups()
>>>       |- btrfs_finish_chunk_alloc()
>>>          |- btrfs_add_system_chunk()
>>>
>>> This happens because we have used up all space of
>>> btrfs_super_block::sys_chunk_array.
>>>
>>> The root cause is, we have the following bad loop of creating tons of=

>>> system chunks:
>>> 1. The only SYSTEM chunk is being scrubbed
>>>    It's very common to have only one SYSTEM chunk.
>>> 2. New SYSTEM bg will be allocated
>>>    As btrfs_inc_block_group_ro() will check if we have enough space
>>>    after marking current bg RO. If not, then allocate a new chunk.
>>> 3. New SYSTEM bg is still empty, will be reclaimed
>>>    During the reclaim, we will mark it RO again.
>>> 4. That newly allocated empty SYSTEM bg get scrubbed
>>>    We go back to step 2, as the bg is already mark RO but still not
>>>    cleaned up yet.
>>>
>>> If the cleaner kthread doesn't get executed fast enough (e.g. only on=
e
>>> CPU), then we will get more and more empty SYSTEM chunks, using up al=
l
>>> the space of btrfs_super_block::sys_chunk_array.
>>>
>>> [FIX]
>>> Since scrub/dev-replace doesn't always need to allocate new extent,
>>> especially chunk tree extent, so we don't really need to do chunk
>>> pre-allocation.
>>>
>>> To break above spiral, here we introduce a new parameter to
>>> btrfs_inc_block_group(), @do_chunk_alloc, which indicates whether we
>>> need extra chunk pre-allocation.
>>>
>>> For relocation, we pass @do_chunk_alloc=3Dtrue, while for scrub, we p=
ass
>>> @do_chunk_alloc=3Dfalse.
>>> This should keep unnecessary empty chunks from popping up for scrub.
>>>
>>> Also, since there are two parameters for btrfs_inc_block_group_ro(),
>>> add more comment for it.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>
>> Qu,
>>
>> Strangely, this has caused some unexpected failures on test btrfs/071
>> (fsstress + device replace + remount followed by scrub).
>=20
> How reproducible?
>=20
> I also hit rare csum corruptions in btrfs/06[45] and btrfs/071.
> That from v5.5-rc6 and misc-next.
>=20
> In my runs, the reproducibility comes around 1/20 to 1/50.
>=20
>>
>> Since I hadn't seen the issue in my 5.4 (and older) based branches,
>> and only started to observe the failure in 5.5-rc2+, I left a vm
>> bisecting since last week after coming back from vacations.
>> The bisection points out to this change. And going to 5.5-rc5 and
>> reverting this change, or just doing:
>>
>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>> index 21de630b0730..87478654a3e1 100644
>> --- a/fs/btrfs/scrub.c
>> +++ b/fs/btrfs/scrub.c
>> @@ -3578,7 +3578,7 @@ int scrub_enumerate_chunks(struct scrub_ctx *sct=
x,
>>                  * thread can't be triggered fast enough, and use up a=
ll space
>>                  * of btrfs_super_block::sys_chunk_array
>>                  */
>> -               ret =3D btrfs_inc_block_group_ro(cache, false);
>> +               ret =3D btrfs_inc_block_group_ro(cache, true);
>>                 scrub_pause_off(fs_info);
>>
>>                 if (ret =3D=3D 0) {
>>
>> which is simpler then reverting due to conflicts, confirms this patch
>> is what causes btrfs/071 to fail like this:
>>
>> $ cat results/btrfs/071.out.bad
>> QA output created by 071
>> Silence is golden
>> Scrub find errors in "-m raid0 -d raid0" test
>=20
> In my case, not only raid0 raid0, but also simple simple.
>=20
>>
>> $ cat results/btrfs/071.full
>> (...)
>> Test -m raid0 -d raid0
>> Run fsstress  -p 20 -n 100 -d
>> /home/fdmanana/btrfs-tests/scratch_1/stressdir -f rexchange=3D0 -f
>> rwhiteout=3D0
>> Start replace worker: 17813
>> Wait for fsstress to exit and kill all background workers
>> seed =3D 1579455326
>> dev_pool=3D/dev/sdd /dev/sde /dev/sdf
>> free_dev=3D/dev/sdg, src_dev=3D/dev/sdd
>> Replacing /dev/sdd with /dev/sdg
>> Replacing /dev/sde with /dev/sdd
>> Replacing /dev/sdf with /dev/sde
>> Replacing /dev/sdg with /dev/sdf
>> Replacing /dev/sdd with /dev/sdg
>> Replacing /dev/sde with /dev/sdd
>> Replacing /dev/sdf with /dev/sde
>> Replacing /dev/sdg with /dev/sdf
>> Replacing /dev/sdd with /dev/sdg
>> Replacing /dev/sde with /dev/sdd
>> Scrub the filesystem
>> ERROR: there are uncorrectable errors
>> scrub done for 0f63c9b5-5618-4484-b6f2-0b7d3294cf05
>> Scrub started:    Fri Jan 17 12:31:35 2020
>> Status:           finished
>> Duration:         0:00:00
>> Total to scrub:   5.02GiB
>> Rate:             0.00B/s
>> Error summary:    csum=3D1
>>   Corrected:      0
>>   Uncorrectable:  1
>>   Unverified:     0
>> Scrub find errors in "-m raid0 -d raid0" test
>> (...)
>>
>> And in syslog:
>>
>> (...)
>> Jan  9 13:14:15 debian5 kernel: [1739740.727952] BTRFS info (device
>> sdc): dev_replace from /dev/sde (devid 4) to /dev/sdd started
>> Jan  9 13:14:15 debian5 kernel: [1739740.752226]
>> scrub_handle_errored_block: 8 callbacks suppressed
>> Jan  9 13:14:15 debian5 kernel: [1739740.752228] BTRFS warning (device=

>> sdc): checksum error at logical 1129050112 on dev /dev/sde, physical
>> 277803008, root 5, inode 405, offset 1540096, length 4096, links 1
>> (path: stressdir/pa/d2/d5/fa)
>=20
Since no clue why this patch is causing problem, I just poking around to
see how it's related.

- It's on-disk data corruption.
  Btrfs check --check-data-csum also reports similar error of the fs.
  So it's not some false alert from scrub.

Considering the effect, I guess it may be worthy to use your quick fix,
or at least do chunk pre-allocation for data chunks.

Thanks,
Qu


--KlfHwDLCBXBNZMHWGPKBhXDAgJTIRlgXN--

--Xnn9ighDmZptlfLCEkuFCstyErglMa4GR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4ldk0ACgkQwj2R86El
/qisRwf/Y0OjyBWgk/8aZO3CEuRtQj83hxXiuTcJRnxfEkpemIwgYU3REDgybM9P
NW7Qkyu1f3yqmunLR6iXohd4MpZqS/vIf6laWDMFh+t2O5nMa+09s2ZDOuNEnNgZ
oNoexwY7EIqnSVQKOEUO1ou+mX4qbP1ADsk7gIxo3JBw0x9uAK6NUiHBPSINrpbg
VOibQRTRO370TRpLrSWYI0wLbjW2tUmF+PA46AXAVfkeB876ED4w5SaXAbm3Ic+q
IxPHHUmRGFB4GbMahOhmSZlmE/s4rx9pLkYsXfYG+/zoXwMGQOq/sK3g/0GT5Vt3
Orra6mMEL1M076oOqjaCY1rEDsXJ7Q==
=WqdQ
-----END PGP SIGNATURE-----

--Xnn9ighDmZptlfLCEkuFCstyErglMa4GR--
