Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4F6D12F244
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 01:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgACAjD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 19:39:03 -0500
Received: from mout.gmx.net ([212.227.15.15]:58151 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgACAjC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jan 2020 19:39:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578011936;
        bh=5/k6jg5g7S1wWejGejzre+2bekdBA1rSru/zdPxR6E8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=KmI/MvqX3swhJMMWObK/zyMtiB4A1VIzLxcfx6p2780oLf9tPlbAe1PSm1KNSbtLT
         S8QFir8HP3anP2nuaSdfq+oEy8OYA4dPPIDwDyFDByGEJLycIvd/qC64mgQYGWUd3k
         fyvgD4INj0J80UzTAuhuJfbmh3jmY2ERHtCvS3Lo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N6sn7-1jnZLM3XyB-018HtT; Fri, 03
 Jan 2020 01:38:56 +0100
Subject: Re: [PATCH v2 4/4] btrfs: statfs: Use virtual chunk allocation to
 calculation available data space
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200102112746.145045-1-wqu@suse.com>
 <20200102112746.145045-5-wqu@suse.com>
 <6b836ff3-29ab-9a06-b76f-114cb0a5cb5b@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <4f7113c2-bdd8-7f74-a038-dda4db4015f1@gmx.com>
Date:   Fri, 3 Jan 2020 08:38:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <6b836ff3-29ab-9a06-b76f-114cb0a5cb5b@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rNzyCxDHVx5EgcJL2H4fizOxDHf492E8f"
X-Provags-ID: V03:K1:1taDzpFf2YReMndgDfZLr+IjoQRlw4Zfmvrh2wVkAdfPNLHc0OY
 h2OrqfgVV0M4Cbv5h0K6JhNT8rEc9Hj79Qtdjyu8qzxHJgKC3/4i5Wqr7z2YZDaH0jmpXkn
 9d6TjS7R2wAr08qAEHZIca99Xy9BSPfx/PqqvefjEbfIM6WQqg5Zfs7WBCtFm/BASKenRaS
 /FGO+hyKQGXCewlpZkprw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+UK3PGNvfMM=:5whBBGsZPB3K82q0gF707Z
 3CNIYNcovUjMiK594JH57W1mQvtVUPF8oQU/KfNwn5mzIGl29swcFNo5gzvFqv5CjvnGlOvJi
 gww7HWUsNzDMch2C21cXprIO6/RMYKvA3iPNj1XApn5AnouBxzi84yWm4JGmCGlsuF06L0HUx
 +NWKa/neEb992jjXXmHVO74vgZPXHaLHe1TiXnanjjnuTyG982abryDv76R7eShFTM3W7Bq5e
 ZEpxAUC0iyUuTGx66EA7OT2z+hXKAifTwJ675tkh3q+j6OOY9UubMivFQcXVXMQs0JFVCChRF
 3OZs4D3lKdognX0jmFxDXPMIKPHDMQq66DF/5PBXonN+GbEJH56YUsQJ6XbY2/h6+lkteKlIx
 +QZ7XKJUgc2axe+anzU8OL/fzrEqegbEdwDKZMkes58XdRZh907Sq1pZ6PCROxtAFhSXp3O1p
 Rq7YygZe/ZxWg/54dhaqcm4rEOIVZjbAeFXbWgng4p8qiHUe6Yc2fhFjQUpQJzaiPOzPvOJpT
 tJOA9ZRjcRYCAqeEfmYmw15aCDrvESQdezLEJIePZqTtiAyxaTnSrGCqI7zhrjbnd5VBAzDIP
 noQILlO72C5eb2b8ydpPleg1G4aW3zCMs1Ml23tqazQlniGxjgatt4Z+4OQxh/KtrPzp0MMXY
 07EPH2d88RNNeRIbySOlQHAfJ4grhySC/lavNjCJMwK5jAhh4+gMr/Bl5U6vO8Q8XBkvKARYs
 z+0vai1SZz0Pjz3yRE8i2WeHWdF6iZAmq2kzMwZrfELMc1jlrDKO58puj0J0OMVHLClv4nsXq
 xL1gNodnKV+7vmg2l6FKKvETQUiPaTu2+9j9VEKY7aRsEWCImlMSFwNIm4bBqqW5zjCaoQv24
 9w3o+shaQN5mLYL2OdfOfvQHdK5XRdLFoIOw6KCAU+LaVPP3/TSsZ5j/ZM7RFnCanyiC594Vi
 L2WrWlMe3xuRvfLTbsBXbdQEwLd6za105uew81Fvhgqp38+9chfDyPo3I5Se2JHECiqchiizz
 5MinAAsX0ctaS8Qstrf39GSnehUCoadhdmuw/0I41X4IGoQ9f8MiueeSaIwMAShdCQG+2/3BO
 zVBvbJLJoJhgm4pPOvnGnkHmYGRN6OyCnACjzezw6VQ/eWe5VZTImz37B4qtQZ2MBjZDJl6YD
 E5lK3Rcjy+6MDA7u8Qf71atzRdc+74KksVwLyga0vmSkRdeVVsixDs/x0fqLwwKhIWlUizKLO
 EvXkHGbJPf0/Ko67z5saqlSzFKFAZ3t3ZPhK8jV0XfG+bjFAhd53KTe74R2g=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rNzyCxDHVx5EgcJL2H4fizOxDHf492E8f
Content-Type: multipart/mixed; boundary="Qrn7tReikOVc01uqxLvSrJCdEeVdV5QQH"

--Qrn7tReikOVc01uqxLvSrJCdEeVdV5QQH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/3 =E4=B8=8A=E5=8D=8812:20, Josef Bacik wrote:
> On 1/2/20 6:27 AM, Qu Wenruo wrote:
>> Although btrfs_calc_avail_data_space() is trying to do an estimation
>> on how many data chunks it can allocate, the estimation is far from
>> perfect:
>>
>> - Metadata over-commit is not considered at all
>> - Chunk allocation doesn't take RAID5/6 into consideration
>>
>> Although current per-profile available space itself is not able to
>> handle metadata over-commit itself, the virtual chunk infrastructure c=
an
>> be re-used to address above problems.
>>
>> This patch will change btrfs_calc_avail_data_space() to do the followi=
ng
>> things:
>> - Do metadata virtual chunk allocation first
>> =C2=A0=C2=A0 This is to address the over-commit behavior.
>> =C2=A0=C2=A0 If current metadata chunks have enough free space, we can=
 completely
>> =C2=A0=C2=A0 skip this step.
>>
>> - Allocate data virtual chunks as many as possible
>> =C2=A0=C2=A0 Just like what we did in per-profile available space esti=
mation.
>> =C2=A0=C2=A0 Here we only need to calculate one profile, since statfs(=
) call is
>> =C2=A0=C2=A0 a relative cold path.
>>
>> Now statfs() should be able to report near perfect estimation on
>> available data space, and can handle RAID5/6 better.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>=20
> Can you put a comparison of the statfs call time for the old way vs the=

> new way in your changelog?=C2=A0 Say make a raid5 fs for example, popul=
ate it
> a little bit, and then run statfs 10 times and take the average with an=
d
> without your patch so we can make sure there's no performance penalty.=C2=
=A0
> You'd be surprised how many times statfs() things have caused problems
> for us in production.=C2=A0 Thanks,

Sure no problem.

Never considered statfs() can be a problem.
Will keep an eye on that.

Thanks,
Qu

>=20
> Josef


--Qrn7tReikOVc01uqxLvSrJCdEeVdV5QQH--

--rNzyCxDHVx5EgcJL2H4fizOxDHf492E8f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4OjRwXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qiEeAf+PfH4Eev+w9GHBLZPAnLjCH6y
V8or3qwlCKMJu+xl+7sfp5Syl9ACZdn7fCGir55G/TUJluaQNC379TW9BPr4Lkmv
Z2K1s9OfvjVmrm/HZzV/FN8eoJBCfGgiLuub5cw+5cIvT2FcbIxFs0gBnBgUcCKU
7buI0JfKjfJYqW/6WEfYHJfbViMYnLWfkgYHhx+p8BSdB5ceTNt4MS2m4v3A0gtM
UCvz/5eGn6F5zOlPjxTtLI8bkfZLj0CPfiXxJuEDzBh8Oa7Gtc4muxVPWT50dlBX
D7xfLTg/5Bvsf+XkCh7Ji5Xll8huQ+zh/qbBs19UmfYfutR/EUbyXbGAGTfMug==
=sDkw
-----END PGP SIGNATURE-----

--rNzyCxDHVx5EgcJL2H4fizOxDHf492E8f--
