Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B6E2A8C51
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 02:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732625AbgKFBwj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 20:52:39 -0500
Received: from mout.gmx.net ([212.227.17.21]:45451 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730414AbgKFBwj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Nov 2020 20:52:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604627555;
        bh=sbRwIF1GUyV5btmUX96zKUP96QomT4Hg1ZTNm9w+Uic=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=JJwpxq5wHwFODr6wn7vD2ob4xNDibnaaqQIyHJIgbu1/ElSB+ydlD4FV2r8e3LyS6
         0+jKOGvQxpquwIbGLYm6sLIt6II5mRMMkGtLfOL8xHtGiwKbsxYDXW8IXblLE2ZeyX
         +1/YzKfDTLJ5+nyPHYT6SchVOuHMv9M+8tOjKU6I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mplbx-1jySq43YDd-00qAUm; Fri, 06
 Nov 2020 02:52:35 +0100
Subject: Re: [PATCH 01/32] btrfs: extent_io: remove the
 extent_start/extent_len for end_bio_extent_readpage()
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-2-wqu@suse.com>
 <08947273-050d-8f44-5cf3-9c980f0906a6@toxicpanda.com>
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
Message-ID: <f6990dd0-31da-8850-f783-4d2ff195ccbd@gmx.com>
Date:   Fri, 6 Nov 2020 09:52:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <08947273-050d-8f44-5cf3-9c980f0906a6@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SA8GikrO1XiTrZOPaa9mWbbZya9c1T8dG"
X-Provags-ID: V03:K1:kSlhaFKnScBeblUHlWPKODeGTQGAGDz7EdIvtJnO+4qldv22zr/
 cG9H4S6wHThBNsYwegH98WqdHx0H81d3phm3QN4kjR9J4HRvE05QMAhshWIUHqipZwKzPs0
 f3FTm7oiEdth2Ci3kN4HfV0tBy9gqyDnn7uCcdRpL2pzGEfMGRoqAmHiVQ8lZC2tSl8Tea9
 5t9J+iquhJdf0gbEUMY8A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:el2IVmp4LMw=:zmI8gRNNl2UVIjGAWl8KU5
 DzgEPwCZdksvJeTyAL+43OF8jpxhN+DBjz2PYukQf8I3XqpxY4tEjIVQ6GNa4r0hwQLAiORVQ
 zx0vDdfsZt0yVNiucAyWJcYsbwHJC2tSVE0uUFZ0lSaIAgH+vPq/UpoNs4ZM/vLKo/qlY3ReH
 /XzxQHCUD+Z69wiGn6e35afPC1Z0laKihNZ/T7wV9jrGzbgM6LgjvmDES0FOgzT4FRniKjv3B
 XGXGuj/QppGjp/AIy3qubEikNq4SgXacj59Nz48E1u/t8UQ+aTnP4b9V9v5r2BOZFboGp7XVI
 jUb5WwN49h4tR4yxxqiCFbdpJ+QDPqtJDUYydOsD/P5Jlci0qvqrckSsFeN0N1lklHlhQkq9b
 laY63d8LMnEE5VjNRg7WUVAUS4ZHuhGkCb0cvj2/0lmbGmBWj/tbyxdjPQnZNr16/Zze3nIUS
 trnuBlRuYGHFyUiVkHmT8zL9K47V10nTxIhpBnrBSYuGaz57S1vixH7/ZBnt1Z6gtrplYlobt
 g5SNSVjTpqD/gYZ1H1KLnsVUwGGaWvl7/YOaLoMsfrGSVZV/OTI5fNvuZm+KAYrutFyvYX3mH
 TqGJGCVFf9ybcerhgql15gBk7d0k5Rqv8bYDnKP0Hz0qVIbuP9cvcliyBekWx9MmbtiL6T8mA
 KnRLKsg2RNt9yjTYFk+X8qKGexEJ9iQoyePgidbHdxBakJJK/F/7xvfV/xFkusX+DLAtxu1fq
 SUuuUJm78Dv5RETtWBPSuvV3D7xfpGHYMw4ESNzENP/qjVTVvGeluCnB/WXFqY3J2ZPciKnAD
 kwk6PyvKnanPNPHST+F7Lv8SzbCWaFb5fxBO6FWesGpugnzjEAb23VO7xAalspYIMofs7sDld
 ATxptZ9EuljzcuFSmQrg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SA8GikrO1XiTrZOPaa9mWbbZya9c1T8dG
Content-Type: multipart/mixed; boundary="f26F63eX75dXniP7DUVGvV2HCD9LY2aQb"

--f26F63eX75dXniP7DUVGvV2HCD9LY2aQb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/11/6 =E4=B8=8A=E5=8D=883:40, Josef Bacik wrote:
> On 11/3/20 8:30 AM, Qu Wenruo wrote:
>> In end_bio_extent_readpage() we had a strange dance around
>> extent_start/extent_len.
>>
>> Hides behind the strange dance is, it's just calling
>> endio_readpage_release_extent() on each bvec range.
>>
>> Here is an example to explain the original work flow:
>> =C2=A0=C2=A0 Bio is for inode 257, containing 2 pages, for range [1M, =
1M+8K)
>>
>> =C2=A0=C2=A0 end_bio_extent_extent_readpage() entered
>> =C2=A0=C2=A0 |- extent_start =3D 0;
>> =C2=A0=C2=A0 |- extent_end =3D 0;
>> =C2=A0=C2=A0 |- bio_for_each_segment_all() {
>> =C2=A0=C2=A0 |=C2=A0 |- /* Got the 1st bvec */
>> =C2=A0=C2=A0 |=C2=A0 |- start =3D SZ_1M;
>> =C2=A0=C2=A0 |=C2=A0 |- end =3D SZ_1M + SZ_4K - 1;
>> =C2=A0=C2=A0 |=C2=A0 |- update =3D 1;
>> =C2=A0=C2=A0 |=C2=A0 |- if (extent_len =3D=3D 0) {
>> =C2=A0=C2=A0 |=C2=A0 |=C2=A0 |- extent_start =3D start; /* SZ_1M */
>> =C2=A0=C2=A0 |=C2=A0 |=C2=A0 |- extent_len =3D end + 1 - start; /* SZ_=
1M */
>> =C2=A0=C2=A0 |=C2=A0 |=C2=A0 }
>> =C2=A0=C2=A0 |=C2=A0 |
>> =C2=A0=C2=A0 |=C2=A0 |- /* Got the 2nd bvec */
>> =C2=A0=C2=A0 |=C2=A0 |- start =3D SZ_1M + 4K;
>> =C2=A0=C2=A0 |=C2=A0 |- end =3D SZ_1M + 4K - 1;
>> =C2=A0=C2=A0 |=C2=A0 |- update =3D 1;
>> =C2=A0=C2=A0 |=C2=A0 |- if (extent_start + extent_len =3D=3D start) {
>> =C2=A0=C2=A0 |=C2=A0 |=C2=A0 |- extent_len +=3D end + 1 - start; /* SZ=
_8K */
>> =C2=A0=C2=A0 |=C2=A0 |=C2=A0 }
>> =C2=A0=C2=A0 |=C2=A0 } /* All bio vec iterated */
>> =C2=A0=C2=A0 |
>> =C2=A0=C2=A0 |- if (extent_len) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- endio_readpage_release_extent(tree, =
extent_start, extent_len,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 update);
>> =C2=A0=C2=A0=C2=A0=C2=A0/* extent_start =3D=3D SZ_1M, extent_len =3D=3D=
 SZ_8K, uptodate =3D 1 */
>>
>> As the above flow shows, the existing code in end_bio_extent_readpage(=
)
>> is just accumulate extent_start/extent_len, and when the contiguous ra=
nge
>> breaks, call endio_readpage_release_extent() for the range.
>>
>> The contiguous range breaks at two locations:
>> - The total else {} branch
>> =C2=A0=C2=A0 This means we had a page in a bio where it's not contiguo=
us.
>> =C2=A0=C2=A0 Currently this branch will never be triggered. As all our=
 bio is
>> =C2=A0=C2=A0 submitted as contiguous pages.
>>
>> - After the bio_for_each_segment_all() loop ends
>> =C2=A0=C2=A0 This is the normal call sites where we iterated all bvecs=
 of a bio,
>> =C2=A0=C2=A0 and all pages should be contiguous, thus we can call
>> =C2=A0=C2=A0 endio_readpage_release_extent() on the full range.
>>
>> The original code has also considered cases like (!uptodate), so it wi=
ll
>> mark the uptodate range with EXTENT_UPTODATE.
>>
>> So this patch will remove the extent_start/extent_len dancing, replace=

>> it with regular endio_readpage_release_extent() call on each bvec.
>>
>> This brings one behavior change:
>> - Temporary memory usage increase
>> =C2=A0=C2=A0 Unlike the old call which only modify the extent tree onc=
e, now we
>> =C2=A0=C2=A0 update the extent tree for each bvec.
>>
>> =C2=A0=C2=A0 Although the end result is the same, since we may need mo=
re extent
>> =C2=A0=C2=A0 state split/allocation, we need more temporary memory dur=
ing that
>> =C2=A0=C2=A0 bvec iteration.
>>
>> But considering how streamline the new code is, the temporary memory
>> usage increase should be acceptable.
>=20
> It's not just temporary memory usage, it's a point of latency for every=

> memory operation.

The latency comes from 2 parts:
- extent_state search
  Even it's a log(n) operation, we're calling it for each bvec, thus
  it's definitely cause more latency, I'll post the test result soon,
  but initial result is already pretty poor.

- extent_state preallocation
  This is the tricky one.

  In theory, since we're at read path, we can call it with GFP_KERNEL,
  but the truth is, the extent io tree uses gfp_mask to determine if we
  can do memory allocation, and if possible, they will always try to
  prealloc some memory, which is not always ideal.

  This means even we can call GFP_KERNEL here, we shouldn't.

  So ironically, we should call with GFP_ATOMIC to reduce the memory
  allocation trials. But that would cause possible false ENOMEM alert
  thought.

  As in the extent io tree operations, except the first bvec, we should
  always just enlarge previously inserted extent_state, so the memory
  usage isn't really a problem.

This again, shows the hidden sins of extent io tree, and further prove
that we need more interface rework for it.

The best situation would be, we allocate one extent_state as cache, and
allow extent io tree to use that cache, other than doing the hidden
preallocate internally.

And only re-allocate the precached extent_state after extent io tree
really used that.
For endio call sites, the possibility to need new allocation is low.
As contig range should only need one extent_state allocated.

For now, I want to just keep the old behavior, with slightly better
comments.
And leave the large extent io tree rework in the future.

Thanks,
Qu

>=C2=A0 We have a lot of memory usage on our servers, every
> trip into the slab allocator is going to be a new chance to induce
> latency because we get caught by some cgroup limit and force reclaim.=C2=
=A0
> The fact that these could be GFP_ATOMIC makes it even worse, because no=
w
> we'll have this random knock-on affect for heavy read workloads.
>=20
> Then to top it all off we could have several megs worth of IO per bio,
> which means we're doing this allocation 100's of times per bio!=C2=A0 T=
his is
> a hard no for me.=C2=A0 Thanks,
>=20
> Josef


--f26F63eX75dXniP7DUVGvV2HCD9LY2aQb--

--SA8GikrO1XiTrZOPaa9mWbbZya9c1T8dG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+krF0ACgkQwj2R86El
/qhdqQgAriBgAdNz074g0wrmq2e60gxoe6YFNlQ4HjBGj8J7E94jlaxBQTXcusUg
0h7VmlgZr14wVqLrbnwUJnlh+aBGEiq8EX0cySowdn9munBvBbjefTBWf2HcJbhq
mOCOJi3iaBvY09EqZ+gmWXAaLTcUHvp1zE8FL1OqSwAtXFr5NJAXP3E54lABaAPp
bfSVB0QV/eH2X8UrYA5wKFCGJDQlY5FAUhhIar/Jt5ocPfb0jV1mcWPpUUiEUGv2
y5kQsXCieL1ZqgJ1udeIobmzcMM7I6FviRmmjd7UP3/EXLxd4/lXUIKC8OnJmz4g
jjeWZyJfaEPR53vLgAak9ppTEoY9fA==
=ISDm
-----END PGP SIGNATURE-----

--SA8GikrO1XiTrZOPaa9mWbbZya9c1T8dG--
