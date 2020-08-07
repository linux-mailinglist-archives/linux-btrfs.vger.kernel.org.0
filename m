Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C06923E713
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Aug 2020 07:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbgHGFlI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Aug 2020 01:41:08 -0400
Received: from mout.gmx.net ([212.227.15.18]:35239 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgHGFlH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Aug 2020 01:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596778859;
        bh=LKZrU3qLFV/jzqWhRQVfKpvweGdgfsmTldsEXUaVRkw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=YmBX+bV0YRJ5q/O0OBmWlac9NPTnQ/sZP7POzjQ0vW//p3KXPPclXK+MjDmj8JvGN
         TQuxzea2Rk904FSDI7KJW8rsYit+/oEJKn75jRhKLxfV+pFVSasZMWHo1drOd89EFK
         jHePbl5olx9wutXWUcFoaQ2nqDBVp7mUepAf1Op0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MVNAr-1kCLYT41Z9-00SRJQ; Fri, 07
 Aug 2020 07:40:59 +0200
Subject: Re: [PATCH] btrfs: backref: this patch fixes a null pointer
 dereference bug.
To:     Boleyn Su <boleynsu@google.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Boleyn Su <boleyn.su@gmail.com>, linux-btrfs@vger.kernel.org
References: <20200806063144.2119712-1-boleynsu@google.com>
 <13d20404-ef74-bb04-d206-086207561464@gmx.com>
 <CAJkxivDhyn9ZbNyhKgs1KcTjzz_2UFMVKDi0SLkvb=O3iZ4rZA@mail.gmail.com>
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
Message-ID: <55450ec5-a49d-2855-0a60-42d8a4d9a8e8@gmx.com>
Date:   Fri, 7 Aug 2020 13:40:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAJkxivDhyn9ZbNyhKgs1KcTjzz_2UFMVKDi0SLkvb=O3iZ4rZA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pU3SaasZi360Ug0wOGFFVBIsKI4ljA2kZ"
X-Provags-ID: V03:K1:hIlXktGfqnFP//fZX+Pr1jb8l3aaxtprmG86SKxLOEQ/PN4PI8B
 BayJAR43TwcEh5RhU6rtIjzqSLpSE8GgtVBwHSvZDaK892dB8k23S1mZ3DtdgMeHSv3XJxk
 C6edIGsMltlS2NGNA0yHDNYRLXgWW4vtXtWeUj2oejUrHVgqI2S+CBlXMVGAuy1eAvcjXpq
 wA3ixZm67K+1EXQfuvwmQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:++MHZ9fMiPM=:ilLzizkC2Xstm/CcFUfKb9
 EDFDp9fTC+tDLksTJXMEWZ67wv/zKf4MHPnn/bs6q8EhZPXrrrcCpA/c0jyaQg8q6XeVWoz/0
 M97xUCRe0JkBEsXLnPtiua1cymqBYAWFxK8W7Kj7Gy45Ftp31FzfCXbJzu79pVzNwXd9RJNDE
 qPTjJexB+YTrcyYXQ/JJ2FRAHEWYQEZwlhFomRvp/OxTD8bwE5PDYyojd6GL5DyVe9xTs4CcZ
 bJnv9ljRGe3TwE470xFgnDUr7wup2jy08jas6T493PrLbQwGs9uhfK/nrO7sQR7kpjByWJh8T
 f8QtwfDGnnjzdzeDw8B1O+jlmrpiWNypZ899hkUP589/+Lfc/TLx1nUoNeS1RK7HVElJrd+pW
 qBgsh80NQl98KIXYkMt3lsMoWyZFDeVeHhjXB6SQUhbMgnwl/9lLBRvh3lrakL84fdSCnrr1g
 gtANTzoGnfmwwAsdVMTM6UnwXJp0EPxTdEis0gVuc4qsB65L0jU6aT7wn9KEC0K3MEjiPQQbm
 Kczig4ejFwjgw4hG07YkRYgNF+qRwsLqP0VRmPDi+aPOn7x/8MYQ+4upUeL9ilbZL+c+TFjTQ
 2rrQN9VCR0WqGoCtSXk5Mwp0H4VhY4x1jgDM5Ssbp6dUt2sgQ6le0djx8JPo0pjvtZMfz4lBf
 MxGPY96jcRcSRRUvBnzWzwzbg/v6Mwv52V5xZzOOv7/o3WEXaeif1aDwr64l9eLr8aBW/CA9s
 C0rs3pKhdiV2MI9OusE7XRjncaMiokkODfnzG5JdGAnuMXA1FQJbMccUI1utzvcdERms8Kwwn
 PD7/A2XtxxYmOm8t1JxGN5xNhW/QsJJBZx4wNYGaadF8CvOHbgkJVz5cFSbqGmv9dU0KdJGMa
 Gh1bD8emNUqdVqJ0kZGxOjQwoBsuq54Qj9d3wd4CWjQZwuTl/Cd73+lPr5n5VzxvtV2HMd2/9
 gzfH2DI2YZNWaCBaXesYS6C2o5v8DDDfm2vHD4IP/aBMT/LOmXr0x1B+C9NN8UARdcAHZ9JC5
 Tfet66hcQOLtyNHtM2FypGWT2+LBIRA14yE7Xn+k7LLzuUGUKzHrlyyIpudrUqk0SZxeAe2sB
 K5YIuyQ+6UR4zSthldD0Z8X5IhwPg7hFA2ro4C6ltp+qm4IwMKcB1l2PF6BT88JF4fpyP3wNY
 lbZ7Yq66SjJNWGP6/VzqbI82yGwTxgwPmWM+OXmDNj02H6LBgbbVTNRKrc4RmiqNesLbRS2t1
 Kt584XJuHZFSsJaKD3gZ4y549bxgqDo6LFQOI8A==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pU3SaasZi360Ug0wOGFFVBIsKI4ljA2kZ
Content-Type: multipart/mixed; boundary="K4JhHNLpPTSdx3BTDbdN2k5MF3p0DddtQ"

--K4JhHNLpPTSdx3BTDbdN2k5MF3p0DddtQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/7 =E4=B8=8A=E5=8D=8811:34, Boleyn Su wrote:
> Thanks for the review. BTW, do I need to do anything else or just leave=

> it to you?
>

If you mean adding the extra reviewed-by tags, no. It's handled by the
awesome maintainer David.

But if you mean to find more btrfs bugs, then keep going your awesome wor=
k!

Thanks,
Qu

> On Thu, Aug 6, 2020 at 4:04 PM Qu Wenruo <quwenruo.btrfs@gmx.com
> <mailto:quwenruo.btrfs@gmx.com>> wrote:
>=20
>=20
>=20
>     On 2020/8/6 =E4=B8=8B=E5=8D=882:31, Boleyn Su wrote:
>     > The `if (!ret)` check will always be false and it may result in
>     ret->path
>     > being dereferenced while it is a null pointer.
>     >
>     > Fixes: a37f232b7b65 ("btrfs: backref: introduce the skeleton of
>     btrfs_backref_iter")
>     > Cc: Chris Mason <clm@fb.com <mailto:clm@fb.com>>
>     > Cc: Josef Bacik <josef@toxicpanda.com <mailto:josef@toxicpanda.co=
m>>
>     > Cc: David Sterba <dsterba@suse.com <mailto:dsterba@suse.com>>
>     > Cc: Boleyn Su <boleyn.su@gmail.com <mailto:boleyn.su@gmail.com>>
>     > Cc: linux-btrfs@vger.kernel.org <mailto:linux-btrfs@vger.kernel.o=
rg>
>     > Signed-off-by: Boleyn Su <boleynsu@google.com
>     <mailto:boleynsu@google.com>>
>=20
>     Nice catch.
>=20
>     Reviewed-by: Qu Wenruo <wqu@suse.com <mailto:wqu@suse.com>>
>=20
>     Thanks,
>     Qu
>     > ---
>     >=C2=A0 fs/btrfs/backref.c | 2 +-
>     >=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>     >
>     > diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
>     > index ea10f7bc9..ea1c28ccb 100644
>     > --- a/fs/btrfs/backref.c
>     > +++ b/fs/btrfs/backref.c
>     > @@ -2303,7 +2303,7 @@ struct btrfs_backref_iter
>     *btrfs_backref_iter_alloc(
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL=
;
>     >=C2=A0
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0ret->path =3D btrfs_alloc_path();
>     > -=C2=A0 =C2=A0 =C2=A0if (!ret) {
>     > +=C2=A0 =C2=A0 =C2=A0if (!ret->path) {
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(ret);=

>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL=
;
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0}
>     >
>=20
>=20
>=20
> --=20
> Boleyn Su (simplified Chinese: =E8=8B=8F=E8=95=89; traditional Chinese:=
 =E8=98=87=E8=95=89; Pinyin:
> S=C5=AB Ji=C4=81o; Katakana: =E3=82=B9=E3=83=BC=E3=82=B8=E3=83=A3=E3=82=
=AA)
>=20
> My PGP public key is available at=C2=A0boleyn.su/pgp <https://boleyn.su=
/pgp>.


--K4JhHNLpPTSdx3BTDbdN2k5MF3p0DddtQ--

--pU3SaasZi360Ug0wOGFFVBIsKI4ljA2kZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8s6WYACgkQwj2R86El
/qgz3wf+JQlL4BRIWHV8JJQRzoSz2T6wqgQMaDxgP5KTcUANeSkP+6NvfvwfFaeQ
XMvMHt29XJx324yIgNNmvTr4484EchMGJ3U5jX7EnvTVQnfjY332m1ZQjgNaETOe
P9gqajDQBvuAb4LcjA0Wa2sQWjhmZMZsGy/N1RlGpMMMu2tqbJuB4enK/1usdHJn
DkeXdlbMKItq3rwxQc5msBMnI6lAylscI3aicM/UT6fXfJDXDNnC63+lN9YBfCEQ
ymjTcea2p6jFG51IGVoyd3miCnSBY4fyYTElWs/cuet5RRyhjiV/5t++nxJe/u0e
YEVw8AIEyjWYzct0QzKsmStdmWSfNg==
=3QyV
-----END PGP SIGNATURE-----

--pU3SaasZi360Ug0wOGFFVBIsKI4ljA2kZ--
