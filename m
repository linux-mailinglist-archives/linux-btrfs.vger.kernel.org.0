Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6606E11FDC6
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2019 06:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbfLPFE6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Dec 2019 00:04:58 -0500
Received: from mout.gmx.net ([212.227.17.21]:60535 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbfLPFE6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Dec 2019 00:04:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576472690;
        bh=t5WgDy8XkoV5Z7sZqR0ozczGLT0btOxAs+Ti7C7N59A=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=jlnpUGKFOsbxOicIuuOB69h56w/TfgK0aey8KwgQENY+J+bjBQkt1zOUJbttOQXP9
         jhkcmIy4CenzAmlceUgmnnrmDCnfMN3P2Yq6O2kjZ0SpX1w1R0736QBBf8TXJIZv7Z
         +HmlGVuZ3xz85GHugt/E05su+udjh7Ypi9LtSVQs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MIdeX-1iSAM82E4L-00Eh6D; Mon, 16
 Dec 2019 06:04:50 +0100
Subject: Re: df shows no available space in 5.4.1
To:     Martin Raiber <martin@urbackup.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <0102016edd1b0184-848d9b6d-6b80-4ce3-8428-e472a224e554-000000@eu-west-1.amazonses.com>
 <784074e1-667a-a2c7-5b47-7cbe36f5fdf5@gmx.com>
 <0102016eec056406-8dc0180d-5a2d-44e8-9ae2-f02573e62203-000000@eu-west-1.amazonses.com>
 <b0501a9b-34da-e69b-a06b-1946f7917269@gmx.com>
 <2ae7f7c6-37a6-9133-6f97-e245812b005e@gmx.com>
 <0102016ef51617a2-339bd846-c076-4a86-a263-f1bdb14de622-000000@eu-west-1.amazonses.com>
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
Message-ID: <af8532dc-6b0c-d084-b752-56889ae6e928@gmx.com>
Date:   Mon, 16 Dec 2019 13:04:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <0102016ef51617a2-339bd846-c076-4a86-a263-f1bdb14de622-000000@eu-west-1.amazonses.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WCI8DlupbJBBghHlBYhqPYDNUsgrGz7DW"
X-Provags-ID: V03:K1:BKrJD812uJ416Cb8C0lp3eUA4mMrp+B1TWT0jczXDqMo86/jl5L
 uLhJkieA0B0a7yU1gPwQImeA8r9Ozp1CB9jsIdztdKQUvgy5YYl+PpRwqlOaQomJWsIQfVL
 AEUvDV2jCKs1A1XesKM2Zl3XhxrEWHoHCdwyAUQtHCowDcnhNtwIzv7DPZY7k4ZdL+IN3rl
 Uxjb8uwYWNSxggw2FlM4A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dnWm5dKt01c=:O5ig0ltzFyqUMvTDLF9pQG
 mT1MYHnygXghF7eBGs8EHRhUEhnT+RDdAw6b5/EGey2U4Hvc6UUiyUERF1b33JqbW/eaYf7gk
 h51eKF92PbcOVej1lEunJMruWkrXzk67xbbNXOKFRprM0WKqXg/x5Wjv+TfYeG0RJJui7SwjI
 v7eAfsbaX9I1LKEzY0UYc8ewhZKEMLV2NMZptuhaFQK5SBeLrOXgkItrXKCpieJ++ZNPn+Zb7
 WXgxou+rxfMN4+m/dYri55FXIG9OFGgI71H+pcFWkyU3aNcTRXfJ/OXUMH1dchabdvxNg5vay
 l3BXs9HRuCGyQIh2y2aqQ6AMOr86tZQ9/heFPKzyEtCFEcWszcWa9MsMpGxk9SxZBFo/3xvTs
 8xe9EepKbyvGjCv8VCkIxVJBGDwaRyMOF6Rhmc3+L0q9dm9myaoTRpdkKkmmQfIEiimnHgIVh
 1gmC32sJYhtKS0OLdz9chcBXLle9Q8AZmEspAMqGmOb2zR34dIXqHPtfT9/vL9DGf5FlKTeZh
 f5U1gdoo7+cI5AK6etcyR9UeJLL9Q3pmZmHQPaWkUA0RRb668hQDVcRa6IdErv7de/0xZeB7+
 n9YKrNf1BoiMJU1S2iAwJQGc8MO70j03oR/VNyo3cmt1k9QxsPNEl1hsNLWCSKvJrnUlgdybM
 JbOy1jRZYuGUrRucfYio1D0mZkAPCcfFjVaQkqvkJ58NY90ZhgC0CcRdMgK49sciCf2YyP3my
 CLaZZ2KzZGTWpAt+odWmI1BDy6JVyQ4wi+F/4wOrP84NrL4rLJjz443JEV2NQaXey3uNBdcvN
 kK+ax9PqqrJIon9AYi/6SXZoJwAIfKaYBnmr5OXvT5Wy+E6PxdBM1FhPiKB3LIdtJ+Cb0eIi1
 s9kH3XokY3JgO7RMn5af2SjKgrLcr5ltjHHmEFfccYGpJ529YfCIiyAVBgJNS5TqD8ekLwl2Y
 hPe1aS0FNF5uQ77Hv8O8pZESebFey+HFfQok2OI1Fq/LFPWEfeTIo3t3UiPXgO64ltHJOAWtf
 bThmw3YUF4j1xQAxuYfj48K7HOJ8rNrF2hgbg2Sr72n89i3RL44bn7kjCtpfhrgtFqUqTno7H
 vCY3Ie8P+TEPcfCpUBHJwoS4iA0PTzbPsSR0bZPpLSasDNavmg9vwIrBje19UtIaqcsMbShfF
 f4uRsd8yhcfyimW/XmCj2IouJeQfMVXuDJjoYN0z1OZavQKtKYwv4BCx6SwX6olmea07PvwWz
 Hkb3m5gMlbJl15QhsxEiASwPSixZ5lcfDE4hrzlk47Gms33joyOA3XNuATYM=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WCI8DlupbJBBghHlBYhqPYDNUsgrGz7DW
Content-Type: multipart/mixed; boundary="bwyl1C64gJkeADCjkVuzvvakBNhPewVhb"

--bwyl1C64gJkeADCjkVuzvvakBNhPewVhb
Content-Type: multipart/mixed;
 boundary="------------40C9F918F67DA40CBC1D5C52"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------40C9F918F67DA40CBC1D5C52
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 2019/12/11 =E4=B8=8B=E5=8D=889:11, Martin Raiber wrote:
> On 10.12.2019 02:19 Qu Wenruo wrote:
>>
>> On 2019/12/10 =E4=B8=8A=E5=8D=888:52, Qu Wenruo wrote:
>>>
>>> On 2019/12/10 =E4=B8=8A=E5=8D=882:56, Martin Raiber wrote:
>>>> On 07.12.2019 08:28 Qu Wenruo wrote:
>>>>> On 2019/12/7 =E4=B8=8A=E5=8D=885:26, Martin Raiber wrote:
>>>>>> Hi,
>>>>>>
>>>>>> with kernel 5.4.1 I have the problem that df shows 100% space used=
=2E I
>>>>>> can still write to the btrfs volume, but my software looks at the
>>>>>> available space and starts deleting stuff if statfs() says there i=
s a
>>>>>> low amount of available space.
>>>>> If the bug still happens, mind to try the snippet to see why this h=
appened?
>>>>>
>>>>> You will need to:
>>>>> - Apply the patch to your kernel code
>>>>> - Recompile the kernel or btrfs module
>>>>>   So this needs some experience in kernel compile.
>>>>> - Reboot to newly compiled kernel or load the debug btrfs module
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>>>>> index 23aa630f04c9..cf34c05b16d7 100644
>>>>> --- a/fs/btrfs/relocation.c
>>>>> +++ b/fs/btrfs/relocation.c
>>>>> @@ -523,7 +523,8 @@ static int should_ignore_root(struct btrfs_root=
 *root)
>>>>>  {
>>>>>         struct btrfs_root *reloc_root;
>>>>>
>>>>> -       if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
>>>>> +       if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state) ||
>>>>> +           test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
>>>>>                 return 0;
>>>>>
>>>>>         reloc_root =3D root->reloc_root;
>>>>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>>>>> index f452a94abdc3..c2b70d97a63b 100644
>>>>> --- a/fs/btrfs/super.c
>>>>> +++ b/fs/btrfs/super.c
>>>>> @@ -2064,6 +2064,8 @@ static int btrfs_statfs(struct dentry *dentry=
,
>>>>> struct kstatfs *buf)
>>>>>                                         found->disk_used;
>>>>>                 }
>>>>>
>>>>> +               pr_info("%s: found type=3D0x%llx disk_used=3D%llu f=
actor=3D%d\n",
>>>>> +                       __func__, found->flags, found->disk_used, f=
actor);
>>>>>                 total_used +=3D found->disk_used;
>>>>>         }
>>>>>
>>>>> @@ -2071,6 +2073,8 @@ static int btrfs_statfs(struct dentry *dentry=
,
>>>>> struct kstatfs *buf)
>>>>>
>>>>>         buf->f_blocks =3D div_u64(btrfs_super_total_bytes(disk_supe=
r),
>>>>> factor);
>>>>>         buf->f_blocks >>=3D bits;
>>>>> +       pr_info("%s: super_total_bytes=3D%llu total_used=3D%llu
>>>>> factor=3D%d\n", __func__,
>>>>> +               btrfs_super_total_bytes(disk_super), total_used, fa=
ctor);
>>>>>         buf->f_bfree =3D buf->f_blocks - (div_u64(total_used, facto=
r) >>
>>>>> bits);
>>>>>
>>>>>         /* Account global block reserve as used, it's in logical si=
ze
>>>>> already */
>>>>>
>>>> Applied. It's currently 100% used directly after reboot, and I am
>>>> getting this log output:
>>> Thank you a lot for the debug output!
>>>
>>>> [...]
>>>> [=C2=A0 241.245150] btrfs_statfs: super_total_bytes=3D128835387392
>>>> total_used=3D93778841600 factor=3D1
>>>> [=C2=A0 241.904824] btrfs_statfs: found type=3D0x1 disk_used=3D93464=
006656 factor=3D1
>>>> [=C2=A0 241.904824] btrfs_statfs: found type=3D0x4 disk_used=3D31481=
8560 factor=3D1
>>>> [=C2=A0 241.904824] btrfs_statfs: found type=3D0x2 disk_used=3D16384=
 factor=3D1
>>>> [=C2=A0 241.904824] btrfs_statfs: super_total_bytes=3D128835387392
>>>> total_used=3D93778841600 factor=3D1
>>> This proves the on-disk numbers are all correct, so far so good.
>>>
>>> The remaining problem is the block_rsv part. Which matches with the n=
ew
>>> ticket system introduced in v5.4.
>>>
>>> Mind to test the new debug snippet?
>>>
>>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>>> index f452a94abdc3..516969534095 100644
>>> --- a/fs/btrfs/super.c
>>> +++ b/fs/btrfs/super.c
>>> @@ -2076,6 +2076,8 @@ static int btrfs_statfs(struct dentry *dentry,
>>> struct kstatfs *buf)
>>>         /* Account global block reserve as used, it's in logical size=

>>> already */
>>>         spin_lock(&block_rsv->lock);
>>>         /* Mixed block groups accounting is not byte-accurate, avoid
>>> overflow */
>>> +       pr_info("%s: block_rsv->size=3D%llu block_rsv->reserved=3D%ll=
u\n",
>>> __func__,
>>> +               block_rsv->size, block_rsv->reserved);
>>>         if (buf->f_bfree >=3D block_rsv->size >> bits)
>>>                 buf->f_bfree -=3D block_rsv->size >> bits;
>>>         else
>>>
>> And this extra snippet for available space.
>>
>> Thanks,
>> Qu
>>
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>> index f452a94abdc3..f1a3e01a0ef5 100644
>> --- a/fs/btrfs/super.c
>> +++ b/fs/btrfs/super.c
>> @@ -1911,6 +1911,7 @@ static inline int
>> btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
>>          * We aren't under the device list lock, so this is racy-ish,
>> but good
>>          * enough for our purposes.
>>          */
>> +       pr_info("%s: original_free_bytes=3D%llu\n", __func__, *free_by=
tes);
>>         nr_devices =3D fs_info->fs_devices->open_devices;
>>         if (!nr_devices) {
>>                 smp_mb();
>> @@ -2005,6 +2006,7 @@ static inline int
>> btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
>>
>>         kfree(devices_info);
>>         *free_bytes =3D avail_space;
>> +       pr_info("%s: calculated_bytes=3D%llu\n", __func__, avail_space=
);
>>         return 0;
>>  }
>>

Sorry for the date reply, was busy firefighting some bugs.

> Now logs this at 100% used:
>=20
> [90273.353449] btrfs_calc_avail_data_space: original_free_bytes=3D23583=
420416
> [90273.353449] btrfs_calc_avail_data_space: calculated_bytes=3D13662945=
280

This marks the beginning of one statefs call.

> [90273.369508] btrfs_statfs: found type=3D0x1 disk_used=3D90233212928 f=
actor=3D1
> [90273.369536] btrfs_statfs: found type=3D0x1 disk_used=3D90233212928 f=
actor=3D1
> [90273.369536] btrfs_statfs: found type=3D0x4 disk_used=3D339361792 fac=
tor=3D1
> [90273.369508] btrfs_statfs: found type=3D0x4 disk_used=3D339361792 fac=
tor=3D1
> [90273.369508] btrfs_statfs: found type=3D0x2 disk_used=3D16384 factor=3D=
1
> [90273.369536] btrfs_statfs: found type=3D0x2 disk_used=3D16384 factor=3D=
1
> [90273.369508] btrfs_statfs: super_total_bytes=3D128835387392
> total_used=3D90572591104 factor=3D1

So far so good. All SINGLE chunks, total disk bytes are ~120GiB.
While totally used bytes are ~84GiB.

In theory, we should give ~36GiB.

> [90273.369508] btrfs_statfs: block_rsv->size=3D147554304
> block_rsv->reserved=3D147554304

block_rsv is tiny, just ~140 MiB, shouldn't cause much difference.

> [90273.369537] btrfs_statfs: super_total_bytes=3D128835387392
> total_used=3D90572591104 factor=3D1

So at this stage, f_bfree should be 74732024 - 288192 blocks.
                                    ^^^^^^^^   ^^^- block_rsv / 512
                                    |- (total_bytes - total_used ) / 512

At least, f_bfree looks OK.

> [90273.369509] btrfs_calc_avail_data_space: original_free_bytes=3D23583=
420416
> [90273.369537] btrfs_statfs: block_rsv->size=3D147554304
> block_rsv->reserved=3D147554304
> [90273.369537] btrfs_calc_avail_data_space: original_free_bytes=3D23583=
420416

Still good, we have around ~21.9GiB unused data space across all
allocated data chunks.
All this ~21.9GiB should contribute to f_bavail.

Although it means you have some fragments, it's not a big deal at all.

> [90273.369509] btrfs_calc_avail_data_space: calculated_bytes=3D13662945=
280
> [90273.369537] btrfs_calc_avail_data_space: calculated_bytes=3D13662945=
280

And btrfs_calc_avail_data_space() find that we can allocate around
12.7GiB new data chunks.

This 12.7GiB also going to be part of f_bavail.

This means, you should have ~34GiB free space, before we do the
offending check:

	if (!mixed && total_free_meta - thresh < block_rsv->size)
		buf->f_bavail =3D 0;

This check is pretty old, from 2015, while recently we allow aggressive
metadata over-committing, thus we can have a lot of metadata reserved
space without really allocating new metadata chunks.

I'll try to find out a better calculation to co-operate with metadata
over-committing.

Feel free to remove all debugg snippets, and if you want some dirty
fixes, please try the attached diff.

Thanks,
Qu

> [90273.400227] btrfs_statfs: found type=3D0x1 disk_used=3D726834307072 =
factor=3D1
> [90273.400227] btrfs_statfs: found type=3D0x4 disk_used=3D4908548096 fa=
ctor=3D1
> [90273.400227] btrfs_statfs: found type=3D0x2 disk_used=3D98304 factor=3D=
1
> [90273.400227] btrfs_statfs: super_total_bytes=3D8133881348096
> total_used=3D731742953472 factor=3D1
> [90273.400227] btrfs_statfs: block_rsv->size=3D536870912
> block_rsv->reserved=3D536821760
> [90273.400227] btrfs_calc_avail_data_space: original_free_bytes=3D11710=
38208
> [90273.400227] btrfs_calc_avail_data_space: calculated_bytes=3D74004936=
13056
>=20

--------------40C9F918F67DA40CBC1D5C52
Content-Type: text/plain; charset=UTF-8;
 name="diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff"

ZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL3N1cGVyLmMgYi9mcy9idHJmcy9zdXBlci5jCmluZGV4
IDFiMTUxYWYyNTc3Mi4uYjhiNjdhYjA1ZjcyIDEwMDY0NAotLS0gYS9mcy9idHJmcy9zdXBl
ci5jCisrKyBiL2ZzL2J0cmZzL3N1cGVyLmMKQEAgLTIwMzIsNyArMjAzMiw2IEBAIHN0YXRp
YyBpbnQgYnRyZnNfc3RhdGZzKHN0cnVjdCBkZW50cnkgKmRlbnRyeSwgc3RydWN0IGtzdGF0
ZnMgKmJ1ZikKIAl1bnNpZ25lZCBmYWN0b3IgPSAxOwogCXN0cnVjdCBidHJmc19ibG9ja19y
c3YgKmJsb2NrX3JzdiA9ICZmc19pbmZvLT5nbG9iYWxfYmxvY2tfcnN2OwogCWludCByZXQ7
Ci0JdTY0IHRocmVzaCA9IDA7CiAJaW50IG1peGVkID0gMDsKIAogCXJjdV9yZWFkX2xvY2so
KTsKQEAgLTIwODUsMjYgKzIwODQsOSBAQCBzdGF0aWMgaW50IGJ0cmZzX3N0YXRmcyhzdHJ1
Y3QgZGVudHJ5ICpkZW50cnksIHN0cnVjdCBrc3RhdGZzICpidWYpCiAJaWYgKHJldCkKIAkJ
cmV0dXJuIHJldDsKIAlidWYtPmZfYmF2YWlsICs9IGRpdl91NjQodG90YWxfZnJlZV9kYXRh
LCBmYWN0b3IpOworCWJ1Zi0+Zl9iYXZhaWwgLT0gYmxvY2tfcnN2LT5zaXplOwogCWJ1Zi0+
Zl9iYXZhaWwgPSBidWYtPmZfYmF2YWlsID4+IGJpdHM7CiAKLQkvKgotCSAqIFdlIGNhbGN1
bGF0ZSB0aGUgcmVtYWluaW5nIG1ldGFkYXRhIHNwYWNlIG1pbnVzIGdsb2JhbCByZXNlcnZl
LiBJZgotCSAqIHRoaXMgaXMgKHN1cHBvc2VkbHkpIHNtYWxsZXIgdGhhbiB6ZXJvLCB0aGVy
ZSdzIG5vIHNwYWNlLiBCdXQgdGhpcwotCSAqIGRvZXMgbm90IGhvbGQgaW4gcHJhY3RpY2Us
IHRoZSBleGhhdXN0ZWQgc3RhdGUgaGFwcGVucyB3aGVyZSdzIHN0aWxsCi0JICogc29tZSBw
b3NpdGl2ZSBkZWx0YS4gU28gd2UgYXBwbHkgc29tZSBndWVzc3dvcmsgYW5kIGNvbXBhcmUg
dGhlCi0JICogZGVsdGEgdG8gYSA0TSB0aHJlc2hvbGQuICAoUHJhY3RpY2FsbHkgb2JzZXJ2
ZWQgZGVsdGEgd2FzIH4yTS4pCi0JICoKLQkgKiBXZSBwcm9iYWJseSBjYW5ub3QgY2FsY3Vs
YXRlIHRoZSBleGFjdCB0aHJlc2hvbGQgdmFsdWUgYmVjYXVzZSB0aGlzCi0JICogZGVwZW5k
cyBvbiB0aGUgaW50ZXJuYWwgcmVzZXJ2YXRpb25zIHJlcXVlc3RlZCBieSB2YXJpb3VzCi0J
ICogb3BlcmF0aW9ucywgc28gc29tZSBvcGVyYXRpb25zIHRoYXQgY29uc3VtZSBhIGZldyBt
ZXRhZGF0YSB3aWxsCi0JICogc3VjY2VlZCBldmVuIGlmIHRoZSBBdmFpbCBpcyB6ZXJvLiBC
dXQgdGhpcyBpcyBiZXR0ZXIgdGhhbiB0aGUgb3RoZXIKLQkgKiB3YXkgYXJvdW5kLgotCSAq
LwotCXRocmVzaCA9IFNaXzRNOwotCi0JaWYgKCFtaXhlZCAmJiB0b3RhbF9mcmVlX21ldGEg
LSB0aHJlc2ggPCBibG9ja19yc3YtPnNpemUpCi0JCWJ1Zi0+Zl9iYXZhaWwgPSAwOwotCiAJ
YnVmLT5mX3R5cGUgPSBCVFJGU19TVVBFUl9NQUdJQzsKIAlidWYtPmZfYnNpemUgPSBkZW50
cnktPmRfc2ItPnNfYmxvY2tzaXplOwogCWJ1Zi0+Zl9uYW1lbGVuID0gQlRSRlNfTkFNRV9M
RU47Cg==
--------------40C9F918F67DA40CBC1D5C52--

--bwyl1C64gJkeADCjkVuzvvakBNhPewVhb--

--WCI8DlupbJBBghHlBYhqPYDNUsgrGz7DW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl33EG4ACgkQwj2R86El
/qgCYAf8CmEHUC8kLyTaNQBX2o1D83qEGVMegKXATlpOwWfRM+jOCvsutcq3kPb2
aYagtckuOKQjhS8uvIuIeoUrl5h2phE9FsIXovBrtSHQBp/RtnscWpXwfNeShrsN
qFT/f8JgVB0+n580rVfd6hIHkS2Hxs2kxy/lEECAVNd6Lfaqf8QN1ADGE88xcR0V
JiC3wIx2ngIVNG2+IBcZoWhIRoMUVgayQlUIx3e3ZNat/JCYlOrxNT5lJwysRqXi
oKXUec8Yqd7C0oRh56xQEZFCQ0Q0c5DWuWk9aen/h05CUPMiyv2tqZHZN0tfvyyQ
/H+nHimZ3QsJnhR3CWCAYd/tj4SmAQ==
=LKwn
-----END PGP SIGNATURE-----

--WCI8DlupbJBBghHlBYhqPYDNUsgrGz7DW--
