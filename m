Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAFFA14322
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2019 02:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfEFAHR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 May 2019 20:07:17 -0400
Received: from mout.gmx.net ([212.227.17.21]:60321 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727285AbfEFAHQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 5 May 2019 20:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557101225;
        bh=8vFrnkZw0G88mxlMW/BpXoT00XOgbOcpnRT/jx8fcCQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SaJZtGqJ1HYlCpAlQhSrneIZREuwVyq68Ydx0wtBBM6XyWCVgH3+01JwP19o0mBau
         ik7SYSiiZjHui8MiBj6cehRnr5BEhossyPcUTcFji4ufQdOii9vmkCosIFleBSRZPT
         kVOwlpTxFJINzsh7TmEZLHpVfRNhAC0ea8Rv3I8Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([52.197.165.36]) by mail.gmx.com (mrgmx102
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0LcEPJ-1gvlu939hl-00jaHj; Mon, 06
 May 2019 02:07:05 +0200
Subject: Re: [PATCH RFC] btrfs: reflink: Flush before reflink any extent to
 prevent NOCOW write falling back to CoW without data reservation
To:     fdmanana@gmail.com, Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20190503010852.10342-1-wqu@suse.com>
 <20190503215622.GC20359@hungrycats.org>
 <448c9a50-98b0-15aa-cbde-81b294bd74e4@gmx.com>
 <20190505150724.GD20359@hungrycats.org>
 <CAL3q7H4mQ1MggsxiugFfnCmDaSgNjD==VKg=FsOzRwAbS8cw2g@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <8fa2a7b3-b06e-638e-8d10-c46557568a0d@gmx.com>
Date:   Mon, 6 May 2019 08:06:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL3q7H4mQ1MggsxiugFfnCmDaSgNjD==VKg=FsOzRwAbS8cw2g@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6Zzb3KA7UCTlPqIHKU8o81HRTcTnGfzhq"
X-Provags-ID: V03:K1:0Sm8c4PYXQKzKUVU6W5F7eWE/3i0HKY2vI/Fi+oufu9Zg6KK/bf
 hQBn3qbhB43I/wbYyu7Oojj+erCJtCrkdS9CLFztfqBRzx4xwbN8Aw6zjLeViJbY7SBjrSc
 qQWdrvpYlo+nIT3GpDzJgSjb1EuxZdj2+izmdlu+z528jQf5bxroGs5qiBvGCpgIDjgBEpu
 34rgZeNDwKralwFzSEquA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uC3N7xabuWY=:ojUyXV9+C57Gh39Du6eAdn
 i3KwWfHfFZ1IsgrYHrw2zcpUCWxbnVElseqmSbsE+hFTVkFZX7C493AdFEd2h06DMrD/jbLot
 VNnwm/iV5MtN9TG5umbrn767UEdIGf50H+7Zs40Q2F+G6hOEW6JASsN4hKMyCC5NRi8Z/DP/0
 X4iR0Ptd9qQEISNqSSd2MuIsaIGSvRCrQlZhtNHDG9MR1gn2yGczCxbyy5iLEpkhVp8GLiPZL
 bhSTEd+WAebpHaWxc7yH7rO+NUijenD3/DuA5uz6A0DaP1ELMZs9ZiAwV/8dV0wr7FPIsSYQw
 PSAaBrHfz4GILQheHkF7+Fm0/98wYBdq6lhG/F2OFoVWraLfXPSoB7l9BKO8f7riO0Iiiocpk
 i04JBNwMPIf65Plqlg7mUhdbI58LXaLkTJlLwsay1rKrE0ayjWiY34SGBe3256EsVfAN+hNpN
 ZorvvzLrG24Srg027m9jt4lDqmtq351jub+A0YN7z5lPl1CVteVihdHGd5CfnWicNtKQJpyI/
 RntevmG5yUEt8Fq8JT9kBbWTc9TPcvVV/HpUuiNS5xih8UvPMKa4hqKbQ5Bzd6FhOmbqW0Ytn
 xE1pCh4SSLkAXgWKdZq3vWWpeBSi0yLYTls2IEbbaHzsLmjM+mASbNW0SnV32mcxbA0gPy2dH
 zr326D1iUdXahRs2Er36jKwvBCR7dBs3i98wo4W1WrCqqVh5Hm3oZOgdWmcW8ZsXOjFYaE5b8
 9u7VvBtqRmkcNe7YqbIQcgqPUID/+o2nDZ2itTs6RPzShWvRWuh2SMB4f6WWu9Zp8UivosIG4
 ErD6lCToiUNVvzDX688FJZ5nQHonPSwr1HeGtlIZ1DRPY+LisrL1B+W8Sb3SUhDqo0eKSxlHk
 Crmb9sep4KNhuFaZLoXjcKY4RE9L94yH27pjuOSY8iyUAFoE9Tlx4ZLu3ogqTP
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6Zzb3KA7UCTlPqIHKU8o81HRTcTnGfzhq
Content-Type: multipart/mixed; boundary="XGUPeysCXteHLac6LiddlLNLKmz7ZYJzw";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: fdmanana@gmail.com, Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <8fa2a7b3-b06e-638e-8d10-c46557568a0d@gmx.com>
Subject: Re: [PATCH RFC] btrfs: reflink: Flush before reflink any extent to
 prevent NOCOW write falling back to CoW without data reservation
References: <20190503010852.10342-1-wqu@suse.com>
 <20190503215622.GC20359@hungrycats.org>
 <448c9a50-98b0-15aa-cbde-81b294bd74e4@gmx.com>
 <20190505150724.GD20359@hungrycats.org>
 <CAL3q7H4mQ1MggsxiugFfnCmDaSgNjD==VKg=FsOzRwAbS8cw2g@mail.gmail.com>
In-Reply-To: <CAL3q7H4mQ1MggsxiugFfnCmDaSgNjD==VKg=FsOzRwAbS8cw2g@mail.gmail.com>

--XGUPeysCXteHLac6LiddlLNLKmz7ZYJzw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/5/6 =E4=B8=8A=E5=8D=8812:24, Filipe Manana wrote:
[snip]
>>>
>>> Yes, also my reason for RFC.
>>>
>>> But it shouldn't be that heavy, as after the first dedupe/reflink, mo=
st
>>> IO should be flushed back, later dedupe has much less work to do.
>>
>> Sure, but if writes are continuously happening (e.g. writes at offset
>> 10GB, dedupe at 1GB), these will get flushed out on the next dedupe.
>> I'm thinking of scenarious where both writes and dedupes are happening=

>> continuously, e.g. a host with multiple VM images running out of raw
>> image files that are deduped on the host filesystem.
>>
>> I'm not sure what all the conditions for this flush are.  From the lis=
t
>> above, it sounds like this only occurs _after_ the filesystem has foun=
d
>> there is no free space.  If that's true, then the extra overhead is
>> negligible since it rarely happens (assuming that having no free space=

>> is a rare condition for filesystems).
>=20
> The problem is not that flush is done only when low on available space.=

> The flush would always happen on the entire source file before
> reflinking, so that buffered writes that happened before the
> clone/dedupe operation and "entered" nodatacow mode (because at the
> time there was not enough available data space) will not fail when
> their writeback starts - which would happen after the reflinking -
> that's why the entire range is flushed.
>=20
> Even if btrfs' reference counts are tracked per extent and not per
> block, here we could maybe do something like check each reference,
> extract the inode number, root number and offset. Then use that to
> find the respective file extent items, and using those extract their
> length and determine exactly which parts (blocks) of an extent are
> shared. That would be a lot of work to do, and would always be racy
> for checks for inodes that are not the inode we have locked for the
> reflink operation. Very impractical.

To add my idea on better backref (block level), it's more impractical
than I thought.

=46rom extent double/triple split, to how to handle old extents in old
snapshot, it's way too expensive from the developer's respect.

>=20
> So it's one more big inconvenience from the extent based back
> references, other then the already known space wasting inconvenience
> (even if only 1 block of an extent is really referenced, the rest of
> the extent is unavailable for allocation, considered used space).

Currently this patch is only to be a workaround.

There is an idea of introducing new extent io tree bit, NODATACOW for
this case. Buffered write with NODATACOW will set the bit, and for the
specific problem described here, we only need to flush the range with
NODATACOW bit set.

And that bit can also be used to detect unexpected COW with no data
space reserved.

But that need extra work/testing (especially with my special sauce of
doing NODATACOW at buffered write time).
At least we have some idea on how to reduce the overhead.

Thanks,
Qu

>=20
>=20
>=20
>>
>>
>>>> e.g. if the file is a big VM image file and it is used src and for d=
edupe
>>>> (which is quite common in VM image files), we'd be hammering the dis=
k
>>>> with writes similar to hitting it with fsync() in a tight loop?
>>>
>>> The original behavior also flush the target and source range, so we'r=
e
>>> not completely creating some new overhead.
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>> ---
>>>>> Reason for RFC:
>>>>> Flushing an inode just because it's a reflink source is definitely
>>>>> overkilling, but I don't have any better way to handle it.
>>>>>
>>>>> Any comment on this is welcomed.
>>>>> ---
>>>>>  fs/btrfs/ioctl.c | 22 ++++++++++++++++++++++
>>>>>  1 file changed, 22 insertions(+)
>>>>>
>>>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>>>>> index 7755b503b348..8caa0edb6fbf 100644
>>>>> --- a/fs/btrfs/ioctl.c
>>>>> +++ b/fs/btrfs/ioctl.c
>>>>> @@ -3930,6 +3930,28 @@ static noinline int btrfs_clone_files(struct=
 file *file, struct file *file_src,
>>>>>                    return ret;
>>>>>    }
>>>>>
>>>>> +  /*
>>>>> +   * Workaround to make sure NOCOW buffered write reach disk as NO=
COW.
>>>>> +   *
>>>>> +   * Due to the limit of btrfs extent tree design, we can only hav=
e
>>>>> +   * extent level share view. Any part of an extent is shared then=
 the
>>>>> +   * whole extent is shared and any write into that extent needs t=
o fall
>>>>> +   * back to COW.
>>>>> +   *
>>>>> +   * NOCOW buffered write without data space reserved could to lea=
d to
>>>>> +   * either data space bytes_may_use underflow (kernel warning) or=
 ENOSPC
>>>>> +   * at delalloc time (transaction abort).
>>>>> +   *
>>>>> +   * Here we take a shortcut by flush the whole inode. We could do=
 better
>>>>> +   * by finding all extents in that range and flush the space refe=
rring
>>>>> +   * all those extents.
>>>>> +   * But that's too complex for such corner case.
>>>>> +   */
>>>>> +  filemap_flush(src->i_mapping);
>>>>> +  if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
>>>>> +               &BTRFS_I(src)->runtime_flags))
>>>>> +          filemap_flush(src->i_mapping);
>>>>> +
>>>>>    /*
>>>>>     * Lock destination range to serialize with concurrent readpages=
() and
>>>>>     * source range to serialize with relocation.
>>>>> --
>>>>> 2.21.0
>>>>>
>>>
>>
>>
>>
>=20
>=20


--XGUPeysCXteHLac6LiddlLNLKmz7ZYJzw--

--6Zzb3KA7UCTlPqIHKU8o81HRTcTnGfzhq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlzPep8ACgkQwj2R86El
/qhg8Qf/Wo1m2KC7cu1bF8K9x4t1+llxR4mxk+VYoimnAeG7LS0TDHqzQTJ1qC+i
V5zh3esuVO7NKUfd2u6ZzDTl/rBABn5Mz2Hlzs3ELCW+dvpAA4TrvNr8o976Qwf4
KE+U63AddN6UcZrqtC7QDYQ2LcSydldd2fspUcoFv8BeOX90azlkBtOnkkpU+l9K
zs3EHwevnML5ZDr0RKdZ2tGsheePdASAfTZ44+exwnDaag49zWT58u7cE7Yrz38a
rxnwXhNj/X5uRWGBoxBQrmjpQRqqSbOztfglgoPfIRkAHWXvfuPNn8cZqwKkJKTW
gnKQg3GGzr8JbtrgmkJuELNk/hNizw==
=VsjG
-----END PGP SIGNATURE-----

--6Zzb3KA7UCTlPqIHKU8o81HRTcTnGfzhq--
