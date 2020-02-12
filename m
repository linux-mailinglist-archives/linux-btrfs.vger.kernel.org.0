Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD666159E67
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 01:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgBLA4A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 19:56:00 -0500
Received: from mout.gmx.net ([212.227.15.19]:37349 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbgBLA4A (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 19:56:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581468955;
        bh=kIkBezxdjW6FACH0XB0NnVD9bO2DpdL8nMdfMgNRor8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=VaEdWmtOK39uYVJDJaJ1Pj/LkmyP151llvOGIY73nsmE9HPZBzmVQlJwQ547Rz6Wi
         KpqXb3R40VdkjLBg7GWSCXxZew1fWvVDcusCvydkjlTDGOxCkcjvMVqE8K3WXcXrog
         tdYVUSbNjciw/PeLH7AeERBAWnUyEMpuasRgIW/4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MQ5vW-1ioQmo2zh2-00M1Gs; Wed, 12
 Feb 2020 01:55:55 +0100
Subject: Re: [PATCH 1/4] btrfs: set fs_root = NULL on error
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200211214042.4645-1-josef@toxicpanda.com>
 <20200211214042.4645-2-josef@toxicpanda.com>
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
Message-ID: <6bbb98bb-f9c8-aad3-ab86-da097544e38f@gmx.com>
Date:   Wed, 12 Feb 2020 08:55:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200211214042.4645-2-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bRG4FfLiRVTmLQY6yFvmWJhuGuCJzzNKJ"
X-Provags-ID: V03:K1:ZY9KgQ74iDnINOpVlg1oJvG1ADj9NlxALNCUa9S+5OpvRpE+Rq6
 zo8EDX7aUL5MUhsoT0cYfn602ryyUXDL5UYD3HhneinXOMzkYhWEDxEkD1Q94iqAHsbF1Yb
 chm3ZWX96jxkFfzzoKFdJqLN5KCS8xx31gF727pZXmAi2eiO25SidM3cG94rf1h51Ggc+U+
 amMrWyMekZ8RNKcS5fSHg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Qoacqclx0Ts=:BZE5diHjJm4o2aFlyj4QS2
 tjnXdVWAcpxEMbBgZd7/GTTKW84wrqcXtC9FsPKkkB7GMpfpDf+SFR3Z/Zvqut5qy+536viJo
 mk+6WXq9ELekE8hmDEv8TS1uuzr02Z0A/mMeR06tFYms3GHX/vqUwCLA7OdtlV1sPGZse4nIg
 z0d4rZBM5aldEIfhAfyeCibKMqRAetLKcv0V1M8peAF9lWw1umMfDoN7u/X3ififM6+lRKyPF
 aRqM0kclewoe7D1i40p2EEGaWXuf3GKQkkzSt03rxhnVI0boDQDYwTmFt2IT3nKude/g/ePg7
 RbEDklG07D6Lib8aoyM+PAeJQUlueG3V07QowwaFPlQad5Kk0k3A0Ls+Ey1YuWrL27AMMzGCd
 pvJbgWuvA5N8CT8nTV2eSL/GhIQDzuGxLmVMg8OGrmeE8OpJEsOkcumyZHJTtRiBBsjTWFFEm
 PyYSbJy/nFJB5C19P8t/Tat1bJyesJzN/E8OF0pFz8EBVQhsgHf3yDDrfP0aCqQ4bTFRkWp1F
 IPBxBwvm4Vh40RyFVBChPd9Am2iCm4+IBvWW5Vnp8KygRWXK4u19BKPJBqGN7bND1DDcNnmlo
 kJIgoziOGSh2HiyV26KcKasH5SLZHbij3p7lJ05xV09QXHqoJJ6aBJpTencTRGKeCyGHIoKa6
 0VF0obQZ87Szm/YPW9BExP2dkn1cyf3M4NUs2BRUVAASa3oWSwn6mRj/NdSXgqA5nN0EPrAjG
 7YhSAmz0dV9XEuUZ6RKQ1AgWNLXxOhNYVuPXifOx+3Pkp3GjR9GU3VvUxJ7IH/CNiD+r/BwUh
 2w2+zESpvOYJJu2VOeFQwnV33ldRaM5HSJevf2TVzhqVmliJJB/QTvCAfT24ehCZ3lQCp52CK
 mrCrC1S6ReGB4eMtKC9oTLSh+fld3CIq65qepl1elmDuk0DYiLtbmXPJRknwC6PZrZT7DdJhb
 j2e/3L4ih5Far3/bqYoHRJlTyRvjU9osRMotVcWyKniPlY/IgevzP5fGP8Bf++L+9sXFmT+m3
 cMq1UiOJPWvMNsr0BDgjUi9X+2lYK1GVSMZnJZ55PgsMP1zb2nr7ptrnSf+5Rcd97As63W3ME
 kk6750Ecvsjbm5sSyyA0epWP3FebbkmVNCmkfT7Xyla25uIu47gfWbO/5VORP2VrmmX6THK1I
 jsn58xr7cFXrOF2fUvDyGp+KP1qgt3JqSRz+wY2BniFVqqPq+ucegWa4qVv7PmT4Bn41elTml
 a+gYDK+c7gFQAF9Dy
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bRG4FfLiRVTmLQY6yFvmWJhuGuCJzzNKJ
Content-Type: multipart/mixed; boundary="WSzzvdRTaRwfpfI8R1S9OMApIB4dElXKZ"

--WSzzvdRTaRwfpfI8R1S9OMApIB4dElXKZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/12 =E4=B8=8A=E5=8D=885:40, Josef Bacik wrote:
> While running my error injection script I hit a panic when we tried to
> clean up the fs_root when free'ing the fs_root.  This is because
> fs_info->fs_root =3D=3D PTR_ERR(-EIO), which isn't great.  Fix this by
> setting fs_info->fs_root =3D NULL; if we fail to read the root.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Just one off-topic idea, can we have test cases in fstests to do
specific error injection test?

For your fix, we can inject ENOMEM error with call chain
btrfs_read_fs_root_no_name()->open_ctree() to get a 100% reproducible
test, which looks to be a solid test case.

Thanks,
Qu

> ---
>  fs/btrfs/disk-io.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index eb441fa3711b..5b6140482cef 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3260,6 +3260,7 @@ int __cold open_ctree(struct super_block *sb,
>  	if (IS_ERR(fs_info->fs_root)) {
>  		err =3D PTR_ERR(fs_info->fs_root);
>  		btrfs_warn(fs_info, "failed to read fs tree: %d", err);
> +		fs_info->fs_root =3D NULL;
>  		goto fail_qgroup;
>  	}
> =20
>=20


--WSzzvdRTaRwfpfI8R1S9OMApIB4dElXKZ--

--bRG4FfLiRVTmLQY6yFvmWJhuGuCJzzNKJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5DTRcACgkQwj2R86El
/qgFSAf/at5ifdkLU4f0OyHPGLgi2pHXr37zgABAHVDe7pveXIkFMrm4Qe+5HVwo
/lK1n7SnxGuCdVezTRQu0yIFHUHGAsYal0FtCcaibh6r0JYfMXQX3THzaO8uEj7y
kBureTwZufdCdCvb2gMgC2EmpMYx7W5D1xJDd1UytggaVJGOopCpmOGByDmCN8Lc
th6hBDzu75WS/DYcC22S/N+PRD3uUYqX5EnPBz8hFUW8ZYE3TkuVhmH4w6b2vo7f
WxW/uaAaRSyXX2B0usJrCLWaUCYbn3VF/AP2cbZbKoLu7ze1OqKsR6E1+wCgq6UA
P1NlkL2K/2+znMHA3sd0e1xTTNEdhw==
=JL7C
-----END PGP SIGNATURE-----

--bRG4FfLiRVTmLQY6yFvmWJhuGuCJzzNKJ--
