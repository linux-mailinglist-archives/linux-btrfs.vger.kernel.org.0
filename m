Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E640B137C99
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jan 2020 10:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgAKJZE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Jan 2020 04:25:04 -0500
Received: from mout.gmx.net ([212.227.17.20]:43143 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbgAKJZE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Jan 2020 04:25:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578734698;
        bh=s5z7CmCf3Xs4IVvJLZZq4pQfUgFNZp5NrbXbObPLZgQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=iXrLiLQuvBYvKzzq2x58q2bseeVYHQX9tUVNPgqqspTNCqu/OaoDvpO7jNav3qtWf
         XtY+lW4lJcEm7x0igVzbHG/NRLRWXDyihWadZtdEDuZPwX5RSM7c2VUB0elxIEGSFo
         oad1nebTvTrlbHbdMlOD5fPy1zPOpafTINGcKhKY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M42nY-1iqD0r3o9Y-0007M1; Sat, 11
 Jan 2020 10:24:58 +0100
Subject: Re: [PATCH 1/5] btrfs: check rw_devices, not num_devices for
 restriping
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200110161128.21710-1-josef@toxicpanda.com>
 <20200110161128.21710-2-josef@toxicpanda.com>
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
Message-ID: <ad071df3-1ee1-9698-e6e1-38d04c2b4e66@gmx.com>
Date:   Sat, 11 Jan 2020 17:24:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200110161128.21710-2-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gSX2gT9KLLNxQFdmyEqTnhyABh2KzgmpA"
X-Provags-ID: V03:K1:FaxYfVfEJuRsKV9KZ/c50e+iarjKJp26QC5TBtZa8XFfPlVVF/8
 rLHaKDg2Ly/yxpslVsY3FXgDyTDpFDc5YFvudx3RArN1UPf1V5DmVbOWTEIxPs5KjFb4A2V
 gBE6ZHR1kujjtMY+v+wIlvyMi6PTH6x8P4zJH9gglpP41FAVprx7Ekmd1MTomW7NrRemM/6
 R5QSeerTbR2/tS2I3ssYw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:37mxdLObOkc=:spcg4RUrdo+BLPZ/JAIZb6
 QHrbOwcn7UpHEL9ipfquFvjgxeA6xIKSPjZjfQ5tVIF7Pv0d7csfKqYN0lBzwozD0/mLhsw5S
 /JrLR4ag5HnpycXTHmUQpbAa1CmyxFelaqedgK144yA/sxSxw+o8xVBSReJaip9y8wo2ubJUW
 BtY5i6IQT74afIWaAs6P1Sbp8EVRrwbuRZd3jGFuU7O3NitWYv95NM+hczfrrvOMUyZJQxxhm
 YKO5YwHBKEcPn0Ig01gb7GCDrJUgYQ4mXnPg61H7why5v45bb/qzi6E6I8I/eZHMN2nmNJQLm
 +bHWiyANpxoWae/J1SgB2Ge2KD0DofRmUoMM2p7tZVy2gJAstoC04My3EOuvEhmHP99wZm7mY
 5vC31jS9JQD3JVVgHGvOyCD5dDFa/h/X6ctu0jz6+k6qbazb6a4k/p7Md2f+FHFJUHYRLlzb+
 VYn9+l+jRQJrNdGWkx8be/GL46te/cxpT2YrkmnSe56bCeGKnNGs5aXTwzA3/0s4Y9jAZT0/Y
 FZOEINkEozYaxgY8Mv4yQKPRhzyQIyu0bL2iB8kwarAOyRttGqtwge67XfaoF2x78lxhEu41/
 a2f+KFLT18UsqQheYaibGKA6vl8CMPxbvFa70Ezp65VWJ0yOdVfi9b83IYlCLIFlCZtkVZcb7
 hkUBLjB3n0jQqi/wq4OE95rmt9mXnq8QSgx+7fzpgoa7DbZNSmTmkz6+cS6Iv+4QtslQqVOXj
 K1GIqfHMHulyVUJJ5dQhT9jXFDCwm80BFlYbu+v45NMEAL0rPo0K6C4NQY2A0yyUuxl27n9ht
 JQFimw7KjIoFYFe8icZlxHRstZYlqT2lnzqv7aj+gsI1limhNNvsXkNM6NTeNJhP5IqkrQoMI
 HKkJjCW5IRtxt3xNmZKUTdQau3xHOJrt7cULDNdjACm8V5NHeyvtS4t+Lk+vI3IVQu5p9wEFb
 JtGnaNIlwpAcE288jznwfY+muM6euffophHcY9tr8lptUcpjInjTln04iu/0HYY9Y1CV3B8Ex
 NqVBhErQb6D1az5rTzJ3DwqRHPbu4rUeND9QFgjlJR3cHWwmE9VpQWDCZiBSno6/D3VTjsYp0
 bC0aJjeVGWAVS0BIUri05i1oJ/0cNnMvdbvNFgODjV+keBOs/SZDdcERL6Wd+tJ1KdWL7mnra
 oJuZb3j8wrwVOxRRgvLUVKG1go+yLgKqyRmApfek77r7KbVPzq77W8UJEarjbxKiNVJAfNBCS
 6HWYP1BehdduK3AhDlihj7bhzYJf3Wa+3k7nMj+XkLtQeh+0laNR0Szgg77M=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gSX2gT9KLLNxQFdmyEqTnhyABh2KzgmpA
Content-Type: multipart/mixed; boundary="cWOqjduMvWkn0GU7664SLvc45T6M0O6O7"

--cWOqjduMvWkn0GU7664SLvc45T6M0O6O7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/11 =E4=B8=8A=E5=8D=8812:11, Josef Bacik wrote:
> While running xfstests with compression on I noticed I was panicing on
> btrfs/154.  I bisected this down to my inc_block_group_ro patches, whic=
h
> was strange.
>=20
> What was happening is with my patches we now use btrfs_can_overcommit()=

> to see if we can flip a block group read only.  Before this would fail
> because we weren't taking into account the usable un-allocated space fo=
r
> allocating chunks.  With my patches we were allowed to do the balance,
> which is technically correct.
>=20
> However this test is testing restriping with a degraded mount, somethin=
g
> that isn't working right because Anand's fix for the test was never
> actually merged.
>=20
> So now we're trying to allocate a chunk and cannot because we want to
> allocate a RAID1 chunk, but there's only 1 device that's available for
> usage.  This results in an ENOSPC in one of the BUG_ON(ret) paths in
> relocation (and a tricky path that is going to take many more patches t=
o
> fix.)
>=20
> But we shouldn't even be making it this far, we don't have enough
> devices to restripe.  The problem is we're using btrfs_num_devices(),
> which for some reason includes missing devices.  That's not actually
> what we want, we want the rw_devices.
>=20
> Fix this by getting the rw_devices.  With this patch we're no longer
> panicing with my other patches applied, and we're in fact erroring out
> at the correct spot instead of at inc_block_group_ro.  The fact that
> this was working before was just sheer dumb luck.
>=20
> Fixes: e4d8ec0f65b9 ("Btrfs: implement online profile changing")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/volumes.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 7483521a928b..a92059555754 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3881,7 +3881,14 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,=

>  		}
>  	}
> =20
> -	num_devices =3D btrfs_num_devices(fs_info);
> +	/*
> +	 * rw_devices can be messed with by rm_device and device replace, so
> +	 * take the chunk_mutex to make sure we have a relatively consistent
> +	 * view of the fs at this point.
> +	 */
> +	mutex_lock(&fs_info->chunk_mutex);
> +	num_devices =3D fs_info->fs_devices->rw_devices;
> +	mutex_unlock(&fs_info->chunk_mutex);

chunk_mutex is the correct lock for rw_devices counter and alloc_list.
So,

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> =20
>  	/*
>  	 * SINGLE profile on-disk has no profile bit, but in-memory we have a=

>=20


--cWOqjduMvWkn0GU7664SLvc45T6M0O6O7--

--gSX2gT9KLLNxQFdmyEqTnhyABh2KzgmpA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4ZlGYACgkQwj2R86El
/qhHxggAgs75zPSkFPBMZ3U5G9ZagJB7NxVBG9tZ1c8X7M8IOpUqaIVf0cxUKsGl
rqz1kK0JJjNczJOxeBgxXHljHcelTIvpENRHRtu8S1NN2lRawiLgAdwbujY+nvUI
9ocTEtnBtkoRKYEH3R8VIwuypxCUcYRET9eh1vCxMdkE6YC6KAMwGFDE2HKsG91C
NE1wixOf8T2L9VczUjCjCCbAnPGT/+2mNAMWNnR2Lcz9M7/k5CVg9Yry86vbDU46
IIHeg8yoVBIl9KE8oSDgqzjn+bIdL+6O+IhNu8kqLCCytvNwTzTaJkOGjbWm+FUA
CW0XzS99h0kCXb9TUY7e80mXquYLuA==
=AWsr
-----END PGP SIGNATURE-----

--gSX2gT9KLLNxQFdmyEqTnhyABh2KzgmpA--
