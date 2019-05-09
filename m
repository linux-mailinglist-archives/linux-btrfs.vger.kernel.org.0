Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD43195A9
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2019 01:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfEIX3K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 May 2019 19:29:10 -0400
Received: from mout.gmx.net ([212.227.17.20]:53395 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbfEIX3K (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 May 2019 19:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557444521;
        bh=fCYg8gTY2e9pI8xNu5YWN3MYpgcPvSd7T3siw11kRC0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=g15Og9d62K48MXzQ8sTTTOPOSAB616/gRIesNsOJC+AA+NFTvvYH1h0PU0dab1C7w
         OtRazrUI7BbkZYU1Cj4lVaRcSmw1pcc4ifESK09eH9OoP+DUxyboD92YPZ7ODAHZ2p
         6eEfJ/WEQX3EwTWWZ7s5dXUj4OHpIf+XiEIt117g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([52.197.165.36]) by mail.gmx.com (mrgmx103
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MGzwE-1hTm0o1ptS-00DssU; Fri, 10
 May 2019 01:28:41 +0200
Subject: Re: [PATCH v3] btrfs: Flush before reflinking any extent to prevent
 NOCOW write falling back to CoW without data reservation
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190508104958.18363-1-wqu@suse.com>
 <20190509144915.GV20156@twin.jikos.cz>
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
Message-ID: <a32c0d72-ca46-1886-1788-1ca5d926353c@gmx.com>
Date:   Fri, 10 May 2019 07:28:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509144915.GV20156@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="x9RCFIsMbnSEMBik1Ak9mcvmI3JTNSPow"
X-Provags-ID: V03:K1:soS8Eav9RHbz2K/d32p9xsVHYNaGPS+hK7TSSW6lyyG9oOF6Pio
 BCPjuYdFi1iZgo4HKHUBIPUMzRVWOnoiUSOPxR/6Ge3ZxqQ8z4YcfEVdpsGEoQhANyO45vD
 I/6BxEwxbZ17iu1wY210FvR48LyI9/pt6XClPlAH132J16af6QL3hWXeetoGQ/8Ezjb3eTC
 4BrhZLEeSYSknIKWsPnOw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rWQIKkNsjvA=:xUihzVCa2U2aBpJm6UStwh
 2pOg+Aw7JXuAkBXzHEkTBJGyTdS4e8Lp2kQsUayGYKNfORQJZdq9s+o298rW9wMxZR/ZMuBfk
 IMzFLDhX2fMYLam9hG4HlOEG4wdU/dmAqmoap/J39lYpRDVTg4Ixu+OUwLwpCRaC1LDSBPyAi
 XMaz92QaZre1fI+AW4d1nBMZV6E2jYl6NZbEbUF34/hL8+wKxqFbkq8KDZjac93g2GfM587T4
 LMvO2DRNl/laZO5xNptgbwhM8oAO95fr9k+kO3Og3i2vg3WqaBkVQbEaCbHqBIKC4xHfNG8A/
 FEvCIb40E3IEBKPjsh0sBrtPWiUzDZz2CMP+bByYRvesxeCgzHaa587NDuOmY8pwZU6hWKgwH
 MIVnKML69cmPWhHnU2Becsgmgu1Ttgtssv7ydL40qqbO/H/UHcjkPqtkqejbM8tWi7FApAJ9m
 njpoVBy3ghv9SvU6PnksB1HoCUr7A0HaYYj/ssBhxzfSoDmeS3gllOqfYDSSvLttNd8BEbUxM
 aGWNQElCxKPckTtuh9jSTGibhHWN2fxoK1KybKi95/ECWkTHiGh0Y6m/nxBgc2JZVf50n/TTr
 CUmNXB5wDDNCJv3WG+d0pG1yI1qYqvLm+wL7wh27NnUp14ghjA94iW8n97dtxkfgZ/HhsLsEb
 1Z2q/0KlC0POTOw8z+CfV6eiwYJtnvTUa5g29jUcB0zkOu/b+zzfw3o2jOL08Qlo5+9XxRX0t
 +VE/Mh2XamaNAr9PMZfNtbZ1dtg5u0LGcdrWN66Ciiqz0jAjXC3oI+ekmy5htYahA5ZMwXLqe
 oddfgWrIYAC73BcjGvLE+2QLYUdHaU/osqGuCj3y2+gg+UW4HWn1fFjVAFAyVm9j8kVc4oxU5
 odbGV70/hhruXDqnJ9FK37qkI2u5HCGzNDVExWKGYrYPQQ0kOAUimpZ4tJj/IB
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--x9RCFIsMbnSEMBik1Ak9mcvmI3JTNSPow
Content-Type: multipart/mixed; boundary="t84a2h0r0VcMMqfk4DVzfg9kMeG3HLq26";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Message-ID: <a32c0d72-ca46-1886-1788-1ca5d926353c@gmx.com>
Subject: Re: [PATCH v3] btrfs: Flush before reflinking any extent to prevent
 NOCOW write falling back to CoW without data reservation
References: <20190508104958.18363-1-wqu@suse.com>
 <20190509144915.GV20156@twin.jikos.cz>
In-Reply-To: <20190509144915.GV20156@twin.jikos.cz>

--t84a2h0r0VcMMqfk4DVzfg9kMeG3HLq26
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/5/9 =E4=B8=8B=E5=8D=8810:49, David Sterba wrote:
> On Wed, May 08, 2019 at 06:49:58PM +0800, Qu Wenruo wrote:
>> [BUG]
>> The following script can cause unexpected fsync failure:
>>
>>   #!/bin/bash
>>
>>   dev=3D/dev/test/test
>>   mnt=3D/mnt/btrfs
>>
>>   mkfs.btrfs -f $dev -b 512M > /dev/null
>>   mount $dev $mnt -o nospace_cache
>>
>>   # Prealloc one extent
>>   xfs_io -f -c "falloc 8k 64m" $mnt/file1
>>   # Fill the remaining data space
>>   xfs_io -f -c "pwrite 0 -b 4k 512M" $mnt/padding
>>   sync
>>
>>   # Write into the prealloc extent
>>   xfs_io -c "pwrite 1m 16m" $mnt/file1
>>
>>   # Reflink then fsync, fsync would fail due to ENOSPC
>>   xfs_io -c "reflink $mnt/file1 8k 0 4k" -c "fsync" $mnt/file1
>>   umount $dev
>>
>> The fsync fails with ENOSPC, and the last page of the buffered write i=
s
>> lost.
>>
>> [CAUSE]
>> This is caused by:
>> - Btrfs' back reference only has extent level granularity
>>   So write into shared extent must be CoWed even only part of the exte=
nt
>>   is shared.
>>
>> So for above script we have:
>> - fallocate
>>   Create a preallocated extent where we can do NOCOW write.
>>
>> - fill all the remaining data and unallocated space
>>
>> - buffered write into preallocated space
>>   As we have not enough space available for data and the extent is not=

>>   shared (yet) we fall into NOCOW mode.
>>
>> - reflink
>>   Now part of the large preallocated extent is shared, later write
>>   into that extent must be CoWed.
>>
>> - fsync triggers writeback
>>   But now the extent is shared and therefore we must fallback into COW=

>>   mode, which fails with ENOSPC since there's not enough space to
>>   allocate data extents.
>>
>> [WORKAROUND]
>> The workaround is to ensure any buffered write in the related extents
>> (not just the reflink source range) get flushed before reflink/dedupe,=

>> so that NOCOW writes succeed that happened before reflinking succeed.
>>
>> The workaround is expensive
>=20
> Can you please quantify that, how big the performance drop is going to
> be?

Depends on how many dirty pages there are at the timing of reflink/dedupe=
=2E

If there are a lot, then it would be a delay for reflink/dedupe.

>=20
> If the fsync comes soon after reflink, then it's effectively no change.=

> In case the buffered writes happen on a different range than reflink an=
d
> fsync comes later, the buffered writes will stall reflink, right?

Fsync doesn't make much difference, it mostly depends on how many dirty
pages are.

Thus the most impacted use case is concurrent buffered write with
reflink/dedupe.

>=20
> If there are other similar corner cases we'd better know them in advanc=
e
> and estimate the impact, that'll be something to look for when we get
> complaints that reflink is suddenly slow.
>=20
>> NOCOW range, but that needs extra accounting for NOCOW range.
>> For now, fix the possible data loss first.
>=20
> filemap_flush says
>=20
>  437 /**
>  438  * filemap_flush - mostly a non-blocking flush
>  439  * @mapping:    target address_space
>  440  *
>  441  * This is a mostly non-blocking flush.  Not suitable for data-int=
egrity
>  442  * purposes - I/O may not be started against all dirty pages.
>  443  *
>  444  * Return: %0 on success, negative error code otherwise.
>  445  */
>=20
> so how does this work together with the statement about preventing data=

> loss?

The data loss is caused by the fact that we can start buffered write
without reserving data space, but after reflink/dedupe we have to do CoW.=

Without enough space, CoW will fail due to ENOSPC.

The fix here is, we ensure all dirties pages start their writeback
(start btrfs_run_delalloc_range()) before reflink.

At btrfs_run_delalloc_range() we determine whether a range goes through
NOCOW or COW, and submit ordered extent to do real write back/csum
calculation/etc.

As long as the whole inode goes through btrfs_run_delalloc_range(), any
NOCOW write will go NOCOW on-disk.
We don't need to wait for the ordered extent to finish, just ensure all
pages goes through delalloc is enough.
Waiting for ordered extent will cause even more latency for reflink.

Thus the filemap_flush() is enough, as the point is to ensure delalloc
is started before reflink.

Thanks,
Qu


--t84a2h0r0VcMMqfk4DVzfg9kMeG3HLq26--

--x9RCFIsMbnSEMBik1Ak9mcvmI3JTNSPow
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlzUt6MACgkQwj2R86El
/qgQMAf/VRaw2dgOh4m7Wv4bwBGReEMlMlW+WfIoT358cFrALhyflWH9dbaqeIE0
suQumSNl8s3yMY16iXrlfH80yTgB0weim2w5NfZsDRW46SxSCA5jb1t3d64hHfZB
tLDL7dplH+2oPjeetv7x1zAIKdd4uoEBwU5oaUtQpM9KAff7iDjOzB3CeEG9psij
4LgDgpNqg+yyXP6ib/B6pbfYI2YMhr2Xi/xbHHXZ8Hb6OwEy+W6qWuCImff1VXqQ
e4LKAjZjeKO7N+2AV76/uhYUJRaRsW+yNdPrnJdiiV+NdaKcHQ/oKNqvh3FjHgC7
lQA6VBZJrioOzfxHWKSWYXYeCpaXaw==
=T0hN
-----END PGP SIGNATURE-----

--x9RCFIsMbnSEMBik1Ak9mcvmI3JTNSPow--
