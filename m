Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67DB926D2C9
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Sep 2020 06:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgIQErP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Sep 2020 00:47:15 -0400
Received: from mout.gmx.net ([212.227.15.18]:36975 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgIQErO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Sep 2020 00:47:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600318017;
        bh=kQoxDSmnfJbFZ5jzvzcVS1lmkvrPjqxih9h2RaAxn0s=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=d5iODs3qEf/VCq2bHmy9OoqAQvY5jbFhT2ODW43ntCVp3zqPTQZkOVfnYvBglOFpz
         8GvfL+oZA8hA3NxL22qVtZ7SklnGFAjMvn32/b0PGum094PjE8FC+PWKy2S1ilYBAH
         gwYM5qGnthhvOrDCXlkp9oI35YFToI9NQtCUTu+U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MBlxW-1kDESL0r1Q-00CC5V; Thu, 17
 Sep 2020 06:46:57 +0200
Subject: Re: THP support for btrfs
To:     Matthew Wilcox <willy@infradead.org>, linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Qu Wenruo <wqu@suse.com>
References: <20200917033021.GR5449@casper.infradead.org>
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
Message-ID: <7baf1a4c-1eed-7aa8-fcf1-12c947d8cd3d@gmx.com>
Date:   Thu, 17 Sep 2020 12:46:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200917033021.GR5449@casper.infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8YVflac2Qfe8ArYRLd4ESRTswNNKGD5Ik"
X-Provags-ID: V03:K1:IQzrRWivPrWbGkAC2F9q5ewvnzAZYaivwVkTBUrb38qwGMBvsm9
 1qr11LlOS/VIUCYyqVzfZnRJxDP1zl1ODkGYZA/ICJx9SOflzzmzSoc41ej0O6/A7CHvGdT
 qrKOFQTskVcUObkEgXT+xVmyHhO5LoBEfoYJhMbHAVE0XoCQdWZNIFbwjSipN9LLZCGVpjy
 J/OOHw+AsT0yaKLgOWQTA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5ePgu/9BZC8=:S7NpIq6R6W/aEyaen8q0gn
 MzHGb2kFNDReu6/KOOLvH/X+8CMD18Tv4PqENi//jTaykxmQsoBXk0mVZwCg938f21pTCDYCv
 lBf9m5cX1wBEO9z3YWWsLLKYTaesdcEj2DbcjWRBpbL/7Cdi+SQtWkJchHQN7atXDR8gkC0HK
 F30JHxiDQEYjN3RvJhL885D7ZDgEOcTLx2iO+CBCBWCnnsLF193idMw3PxQ0aeUM5L/Lcopfj
 pxbX9gtV3xinFLID23P0ZB8IFf79zyURFORW/eLrqzomEq+WGWHCx6BvTDWrsjK79IqGUwKGU
 Wzz3zKpWa3lZCXG/nOnd4bX6tjt0YvO1Y0tVr5RkwCIo2B9cezMPDwu7nqN+SGWy98bXgDlVr
 5t3y3asXzfDNf0Hhloo6YIb6n2eeQNSiz1ROCCXQhTlTmaGcvV0gFbzsPLKjj/NAtd09EWDxX
 x+O2EfRXk/4Niq4kBd31rBWF6/Vn0mtOXJMlYkrWsRDbhGooxzeWZb1QQ0opyn2jPNDlcPfwE
 0M4PTtjN8til3XgOpbNJpblol1XmVJTs5QdtKqgIVFEnrLrPgjAaTmeuzlYSMFtzkHFUtUxeB
 9HeR+LxaIUlVlXRev9Y0jZ3JukzqVq1QFrAuS3lrGLZd6bHzZSDtFAKb/WiS5N0q7YSeIJIsY
 0wVV9aveGkMi41I/PTjRTtagt6THIMBcuJewWrVr23Ad4O/M2CvufWJSkiaWlb8Y85fOvxp6c
 Z7e1TL0eZcTFDor2I3UtAEoNpzaoN1TryikoSejWml1PVRjwaF641Tl+iVs2vq4CECkrY+UCL
 RSV5tCpGvEHCOlDq03O360cbAK3mVsqJls8m7IwRvJ3SDj1UGo5JIf0pO/cXGT5fD48Z6qUM+
 21J+VMHDFumujQv5D4moRS1e2ZqZlb9O75SWmjunKvUPXXHpYXD43ng6aHt2d/iBuD4qk22W3
 YpYgWHtt8zmLk98DphY33HrX2Bfe1O54NXKEKnJcHjRDpVCozxGS6rpL15BnRAUYQj2SkSnbZ
 JmKSYapKWpnLvxOWLJyE9kiayzjMiZWfM3BHMgWEdqQ10h75FR0bXebiozgI+7YIRKy3i7YCI
 3/RH+FdAJQoU4MItU3cps3zzgoEFeFNnryyj4Z3IsJAQuS2GuDTJY/es45g/FdDHrEMJe8wqy
 OREFzHmHIuuiGXnMIeHr6fJIo60mwmIUHoAOVW9P80mnH5GmgoUbLPQaasL2ALypIxzFNY9fh
 HqUXC8TSuvjlluxvE0pnGvywHz0bV9GCk59sQ2g==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8YVflac2Qfe8ArYRLd4ESRTswNNKGD5Ik
Content-Type: multipart/mixed; boundary="dO7wkxelbvp7sjBO6kt2r7YgiszVM2XUa"

--dO7wkxelbvp7sjBO6kt2r7YgiszVM2XUa
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/17 =E4=B8=8A=E5=8D=8811:30, Matthew Wilcox wrote:
> I was pointed at the patches posted this week for sub-page support in
> btrfs, and I thought it might be a good idea to mention that THP suppor=
t
> is going to hit many of the same issues as sub-PAGE_SIZE blocks, so if
> you're thinking about sub-page block sizes, it might be a good idea to
> add THP support at the same time, or at least be aware of it when you'r=
e
> working on those patches to make THP work in the future.

That looks pretty interesting,

>=20
> While the patches have not entirely landed yet, complete (in that it
> passes xfstests on my laptop) support is available here:
> http://git.infradead.org/users/willy/pagecache.git
>=20
> About 40 of the 100 patches are in Andrew Morton's tree or the iomap
> tree waiting for the next merge window, and I'd like to get the rest
> upstream in the merge window after that.  About 20-25 of the patches ar=
e
> to iomap/xfs and the rest are generic MM/FS support.
>=20
> The first difference you'll see after setting the flag indicating
> that your filesystem supports THPs is transparent huge pages being
> passed to ->readahead().  You should submit I/Os to read every byte
> in those pages, not just the first PAGE_SIZE bytes ;-)  Likewise, when
> writepages/writepage is called, you'll want to write back every dirty
> byte in that page, not just the first PAGE_SIZE bytes.
>=20
> If there's a page error (I strongly recommend error injection), you'll
> also see these pages being passed to ->readpage and ->write_begin
> without being PageUptodate, and again, you'll have to handle reads
> for the parts of the page which are not Uptodate.
>=20
> You'll have to handle invalidatepage being called from the truncate /
> page split path.
>=20
> page_mkwrite can be called with a tail page.  You should be sure to mar=
k
> the entire page as dirty (we only track dirty state on a per-THP basis,=

> not per-subpage basis).
>=20
> ---
>=20
> I see btrfs is switching to iomap for the directIO path.  Has any
> consideration been given to switching to iomap for the buffered I/O pat=
h?

Yep, IIRC Goldwyn is already working on that.

Furthermore, we're even considering to utilize iomap for subpage
metadata support (currently we set metadata Private for metadata, and
for subpage, we don't utilize page::private at all)

But that would happen in the future, at least after RW subpage support.

And I'm definitely going to add that support in the future, and
hopefully with much smaller code change.

Thanks,
Qu

> Or is that just too much work?
>=20


--dO7wkxelbvp7sjBO6kt2r7YgiszVM2XUa--

--8YVflac2Qfe8ArYRLd4ESRTswNNKGD5Ik
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9i6j0ACgkQwj2R86El
/qgDEQgAop1w63lLZce/NCVEy9pmV0Md1YjO6ZgSEISC6QCQ23+KGgmL9Ri/iqMT
ujD6UhkDcj8V65HmB4izYr4m0NJ0/6c9LqIqf7WsFFrQXnu9BsoEmcugAyVFrguI
kImT1YPO3rD7IOjzFGCw4hfYBpjn0UtylLs/CHnadivis92jIXNC03dRk2huZftZ
IMVwnt4NFSjNrjafK0HL5A46N6aujs8Zlvxj3BzaECv1IU3RMLppKZCRZNTZvefy
1HCYmE2h1tlSF9aE6eTyilVrTMwQm1PXhrYxTaO/zI1cLVxbFthOxU3/di+9BVek
mwkCXf0oTSA6p2P1vXa/wCxxhnIIVg==
=5azP
-----END PGP SIGNATURE-----

--8YVflac2Qfe8ArYRLd4ESRTswNNKGD5Ik--
