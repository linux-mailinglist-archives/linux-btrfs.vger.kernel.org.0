Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C87830CE9
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 May 2019 12:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfEaK4m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 May 2019 06:56:42 -0400
Received: from mout.gmx.net ([212.227.15.19]:52639 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfEaK4l (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 May 2019 06:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559300192;
        bh=yOljLAGagZrg6Rev9WOxs39SauMId/irOPZgZb49NJE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jgzfRhCbpPbcnjOKEyF3LI5Qde8zPh9ANukMdu6bPelB7dpWrV9w5PQ4Yyvn1R2EU
         1nj+KOQz6juaAWfM72kD2r7X9IRMdlukOBRUXl4DBA0cBAxv4bP/fHitOkcWBx3bvO
         JSLT1KfCwewl0oX/mhJfZgONzlccQA7K3ka2TaC4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx002
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0M8NWM-1gcF8J2joI-00vwuM; Fri, 31
 May 2019 12:56:32 +0200
Subject: Re: [PATCH v3] btrfs: Flush before reflinking any extent to prevent
 NOCOW write falling back to CoW without data reservation
To:     fdmanana@gmail.com
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20190508104958.18363-1-wqu@suse.com>
 <20190509144915.GV20156@twin.jikos.cz>
 <a32c0d72-ca46-1886-1788-1ca5d926353c@gmx.com>
 <CAL3q7H4Px96R9upobOO=7osCjoMeW-w9RCixMo81YEOCsc07kQ@mail.gmail.com>
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
Message-ID: <06563d2a-428d-7811-de6f-6b7b26da23f9@gmx.com>
Date:   Fri, 31 May 2019 18:56:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H4Px96R9upobOO=7osCjoMeW-w9RCixMo81YEOCsc07kQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dYfT2hpviMG6ABiLnRO9pJ03U3oUGD64i"
X-Provags-ID: V03:K1:vMm/DDpAnuRLWPNoKdiyuRUUqCW9JS7GCBQ7M4x4HJpATqFK0UD
 q+V14yrdRL6bdWZIKVhRZvlmZYjSu4iLcHIJjQf9IQakwkZeHhlVzkQxJLhoDIW0jWFjNBe
 crHBSlii/PKA+9YQ7uSSQCVwrDr+A8Vr0eJPBgzRwag/uyhtFTPnrvE8CwqmHlpoDnNowbj
 +nJpmv0ggjjifwSUw+upA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:f838yxxq4IM=:RBqtuWJcGG99rsbv+RD0nX
 PRsr/5XBoIp6IhwCbi3VNfaubWEJvbpTuvaLXuSMXhLaO+IAItXZ/lp+f/OstCZAevpGmUFBt
 ZEoiHkNkpmDVq+x1Rw+Q4p1kI/sb662yCLZ3ONCgbcSobS7g7SpR7bHpgRG4gkJqTiod37ryI
 mVY9A7/O9I1nMzEqokuF8fpHmCpTqKdxdzmWMo7vSJTTZqRZPq0NnuHx72ZsBTnd8wgtbpsK/
 pfsFxxTq8FkbSff2+k2vQRZF73GgeKLiKS8UWprJGGVv5hb/Emf9TjtfNihUvCzBdrkWSWBZR
 y5VItrDHgb8KiVbvfycTAoak3WA3/4Lpr8VbD7o598WSuDCo40/kRPcXAqwNXwmuKSE4Xehll
 oPn+f6dy2Fqgvp17RU+AhEmJttMxhw5OAWvb4Wf+EcoSRN6l5/Xr0f6ieZKSWf1lR6Jw8Lijv
 /PScGlrDr9he5XyQ4IUkJWy6oJaWn7BgDiGrG4j7IZWe5hc6/l6QGhrnHNV312hJGaU3uEW7j
 mSwOtzx3MQ5ByKvCqsZ1UYg3Eua0hxQSuf7w1YwWFxWfWEDaTcgIBQiRpVtcyjqkEF9NeUMBQ
 zYRtebICuzu+i9Era03xJ/Gg3V8zIRlIBTVPsHAJbFKWRSFK/yjMfrVyDGI583LGhCSHcgCgu
 T6jSpRQ7QHBPO/zppPKj098x29aKbxurKA1hDcFKdaTI+py3CRVuxMmvXx5KIX76yElcQx0zc
 VZsSPQgy+mzlclgCayhJ4TyYW4hdG3WHABWpigNbeA/jrdXVtmkYK6lsvCwU9veXgjC1x7HMG
 cxJ0rTVl6qPuSLmI2M/Iz3lXIU/NUqipDbIbCljWOwEew8qQPvJVk/uUQoKeSOXAWmCLBOMnH
 BUcnjauj+tqgkno4KlAIHfkfpk0uxT+eNN5PjVR143i1POE0axLyyRwd5fhv9l28APzcHe4qC
 i3UEUCl023dWAykXxzes2gQz4YP/5bfw=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dYfT2hpviMG6ABiLnRO9pJ03U3oUGD64i
Content-Type: multipart/mixed; boundary="gPdG1yzryV59RQgShUNCenoACUcJjugxz";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: fdmanana@gmail.com
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <06563d2a-428d-7811-de6f-6b7b26da23f9@gmx.com>
Subject: Re: [PATCH v3] btrfs: Flush before reflinking any extent to prevent
 NOCOW write falling back to CoW without data reservation
References: <20190508104958.18363-1-wqu@suse.com>
 <20190509144915.GV20156@twin.jikos.cz>
 <a32c0d72-ca46-1886-1788-1ca5d926353c@gmx.com>
 <CAL3q7H4Px96R9upobOO=7osCjoMeW-w9RCixMo81YEOCsc07kQ@mail.gmail.com>
In-Reply-To: <CAL3q7H4Px96R9upobOO=7osCjoMeW-w9RCixMo81YEOCsc07kQ@mail.gmail.com>

--gPdG1yzryV59RQgShUNCenoACUcJjugxz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Gentle ping?

I didn't see this patch included in misc-next.
Anything went wrong?

Thanks,
Qu

On 2019/5/15 =E4=B8=8B=E5=8D=8810:56, Filipe Manana wrote:
> On Fri, May 10, 2019 at 12:30 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
>>
>>
>>
>> On 2019/5/9 =E4=B8=8B=E5=8D=8810:49, David Sterba wrote:
>>> On Wed, May 08, 2019 at 06:49:58PM +0800, Qu Wenruo wrote:
>>>> [BUG]
>>>> The following script can cause unexpected fsync failure:
>>>>
>>>>   #!/bin/bash
>>>>
>>>>   dev=3D/dev/test/test
>>>>   mnt=3D/mnt/btrfs
>>>>
>>>>   mkfs.btrfs -f $dev -b 512M > /dev/null
>>>>   mount $dev $mnt -o nospace_cache
>>>>
>>>>   # Prealloc one extent
>>>>   xfs_io -f -c "falloc 8k 64m" $mnt/file1
>>>>   # Fill the remaining data space
>>>>   xfs_io -f -c "pwrite 0 -b 4k 512M" $mnt/padding
>>>>   sync
>>>>
>>>>   # Write into the prealloc extent
>>>>   xfs_io -c "pwrite 1m 16m" $mnt/file1
>>>>
>>>>   # Reflink then fsync, fsync would fail due to ENOSPC
>>>>   xfs_io -c "reflink $mnt/file1 8k 0 4k" -c "fsync" $mnt/file1
>>>>   umount $dev
>>>>
>>>> The fsync fails with ENOSPC, and the last page of the buffered write=
 is
>>>> lost.
>>>>
>>>> [CAUSE]
>>>> This is caused by:
>>>> - Btrfs' back reference only has extent level granularity
>>>>   So write into shared extent must be CoWed even only part of the ex=
tent
>>>>   is shared.
>>>>
>>>> So for above script we have:
>>>> - fallocate
>>>>   Create a preallocated extent where we can do NOCOW write.
>>>>
>>>> - fill all the remaining data and unallocated space
>>>>
>>>> - buffered write into preallocated space
>>>>   As we have not enough space available for data and the extent is n=
ot
>>>>   shared (yet) we fall into NOCOW mode.
>>>>
>>>> - reflink
>>>>   Now part of the large preallocated extent is shared, later write
>>>>   into that extent must be CoWed.
>>>>
>>>> - fsync triggers writeback
>>>>   But now the extent is shared and therefore we must fallback into C=
OW
>>>>   mode, which fails with ENOSPC since there's not enough space to
>>>>   allocate data extents.
>>>>
>>>> [WORKAROUND]
>>>> The workaround is to ensure any buffered write in the related extent=
s
>>>> (not just the reflink source range) get flushed before reflink/dedup=
e,
>>>> so that NOCOW writes succeed that happened before reflinking succeed=
=2E
>>>>
>>>> The workaround is expensive
>>>
>>> Can you please quantify that, how big the performance drop is going t=
o
>>> be?
>>
>> Depends on how many dirty pages there are at the timing of reflink/ded=
upe.
>>
>> If there are a lot, then it would be a delay for reflink/dedupe.
>>
>>>
>>> If the fsync comes soon after reflink, then it's effectively no chang=
e.
>>> In case the buffered writes happen on a different range than reflink =
and
>>> fsync comes later, the buffered writes will stall reflink, right?
>>
>> Fsync doesn't make much difference, it mostly depends on how many dirt=
y
>> pages are.
>>
>> Thus the most impacted use case is concurrent buffered write with
>> reflink/dedupe.
>>
>>>
>>> If there are other similar corner cases we'd better know them in adva=
nce
>>> and estimate the impact, that'll be something to look for when we get=

>>> complaints that reflink is suddenly slow.
>>>
>>>> NOCOW range, but that needs extra accounting for NOCOW range.
>>>> For now, fix the possible data loss first.
>>>
>>> filemap_flush says
>>>
>>>  437 /**
>>>  438  * filemap_flush - mostly a non-blocking flush
>>>  439  * @mapping:    target address_space
>>>  440  *
>>>  441  * This is a mostly non-blocking flush.  Not suitable for data-i=
ntegrity
>>>  442  * purposes - I/O may not be started against all dirty pages.
>>>  443  *
>>>  444  * Return: %0 on success, negative error code otherwise.
>>>  445  */
>>>
>>> so how does this work together with the statement about preventing da=
ta
>>> loss?
>>
>> The data loss is caused by the fact that we can start buffered write
>> without reserving data space, but after reflink/dedupe we have to do C=
oW.
>> Without enough space, CoW will fail due to ENOSPC.
>>
>> The fix here is, we ensure all dirties pages start their writeback
>> (start btrfs_run_delalloc_range()) before reflink.
>>
>> At btrfs_run_delalloc_range() we determine whether a range goes throug=
h
>> NOCOW or COW, and submit ordered extent to do real write back/csum
>> calculation/etc.
>>
>> As long as the whole inode goes through btrfs_run_delalloc_range(), an=
y
>> NOCOW write will go NOCOW on-disk.
>> We don't need to wait for the ordered extent to finish, just ensure al=
l
>> pages goes through delalloc is enough.
>> Waiting for ordered extent will cause even more latency for reflink.
>>
>> Thus the filemap_flush() is enough, as the point is to ensure delalloc=

>> is started before reflink.
>=20
> I believe that David's comment is related to this part of the comment
> on filemap_flush():
>=20
> "I/O may not be started against all dirty pages."
>=20
> I.e., his concern being that writeback may not be started and
> therefore we end up with the data loss due to ENOSPC later, and not to
> the technical details of why the ENOSPC failure happens, which is
> already described in the changelog and discussed during the review of
> previous versions of the patch.
>=20
> However btrfs has its own writepages() implementation, which even for
> WB_SYNC_NONE (used by filemap_flush) starts writeback (and doesn't
> wait for it to finish if it started before, which is fine for this use
> case).
> Anyway, just my interpretation of the doubt/comment.
>=20
> Thanks.
>=20
>>
>> Thanks,
>> Qu
>>
>=20
>=20


--gPdG1yzryV59RQgShUNCenoACUcJjugxz--

--dYfT2hpviMG6ABiLnRO9pJ03U3oUGD64i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlzxCEkACgkQwj2R86El
/qgBjwgAkNRDpPIKi7UkcobWJtp2chGcO+LWQAB0JcMRimXRBv7UfhXrpFWAe4Q+
2wTM+DDL8n7PMfqvEkOQsAYLKtqQthdYQSAPpeMLDZVwgV3Nrhqv0DInayU3GGLt
gFugbvQaE3bWhmGoEUyyH2gSx1/8SS2i2EVDHW5moLAep3XkKKchh+bqFblNlYNz
WRCHEdx0an/uCapvzdt8/KNfyHBWXx8fo9QU+h3KV2bkrgSdCKqDAQsGHtMI7eiD
XNBToTbADP3VEPF0rjL7VJNuZgVDNnGa1UZ2Z7mYxS511WL0h0ABmV8Xf8z96Qea
/aIa9+DEpzvDZgyI5IhUZ51GhyRnFg==
=dEwJ
-----END PGP SIGNATURE-----

--dYfT2hpviMG6ABiLnRO9pJ03U3oUGD64i--
