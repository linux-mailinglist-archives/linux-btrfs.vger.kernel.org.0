Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE6D1769B0
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 01:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgCCA71 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 19:59:27 -0500
Received: from mout.gmx.net ([212.227.17.20]:34995 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgCCA70 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Mar 2020 19:59:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583197161;
        bh=bN7eoi005gWpRN0VitMI4sr/q5Ty9nMDrZZhL8cOJeA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=cWusbqjtNbETZytci/cD1Df0mUiIDkIlvs4H9vQ603fLfDxsHkMJTYQP5QA9rurjh
         8K3DlcmatrtnnbHn3AcNOIKW1yo+Vg739vCUllmwWw+ya/UbIzDKuhnLBCIZks0qu0
         KgAaVeGZMe7ymchysIdcXDJZXyYDOkfxWbTYkiyI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MRTRN-1ileGK0NjJ-00NP4k; Tue, 03
 Mar 2020 01:59:21 +0100
Subject: Re: [PATCH 1/7] btrfs: drop block from cache on error in relocation
To:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <20200302184757.44176-1-josef@toxicpanda.com>
 <20200302184757.44176-2-josef@toxicpanda.com>
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
Message-ID: <c9c3efa2-0aaa-58a5-e8a8-64d2853f4b04@gmx.com>
Date:   Tue, 3 Mar 2020 08:59:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302184757.44176-2-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KYQ1Z1hTmJAf5xTez712SlOtvS66W3Ehu"
X-Provags-ID: V03:K1:fONbiAYM7LtUlKIITOPJStx6GHTn95faQl7nSZfowdroaEBCjlX
 3rDK7jyRuy5f5FU8/JCWadvWW34o69HgGJ8hLDm9nxmQ1WxfOgYCnSegagD3dO7ihmEvt+d
 eSdiYpnEPor0tbxdwfbeDWUqaWf5FrP9aPhO59+NUqDY5eENPwmD9MLqpXFbe70WfZDRPoL
 FnIbmzNsw/WTPDKAtaudQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1+MPK3pq7/E=:+FMsSXppQrkLH7P33sQWMJ
 V6bGyDU/O2k6HyynBXEd9+MvbmPWzgm+rpBB+NyGJtAavlN/VMGbIfkgPMcqWKAt4WWm0Q0Mu
 pLh0+k67E5fiOmf5aLJKvwoBF5mWfUz83pQ07MNe0TDsxztkbhW38861JW+mZrd8IRNGA9tBx
 D6HQbs+UmJYWmZdN+PNz/xD7UBx7auew39JwrN+TjUPOJ6ZzqKNUaxglF/SBPv2o2gci2ZMA9
 L/JIhDfGrCbcANN6IdOyVq5S8GYvwgR/HwvViOGZbslc0BKXgXu+Pu2tW00L0Wc5RzoEeg9Ge
 rvAhdIbmKpfcZLuW7H0CKXZ+8aDlEpvnxTaYspIV7jgGw803rmVMDPURMgTCq/fRIYxW2k0Ex
 ely7KQocw6fXAcNIEvXIudLVyOZFZT/Mo6/wGZomd6MchRKB356jn/m8GkDVOS/n9how6ZZ+M
 VYgVDt+9FaMp1DLY3DJt8Kwo1p5/Gv+rT1Xhc3WHC52blsWoPyB/X2m1zWFq00QiBvptdtb3n
 lnRaJqrmwnexL7VsRkl520WTYTyKsZqG82CPv06Er9RaTzPanJncFiVU/r0BGToaOD1ujZTU0
 5+2MaWZgmomhafzEaH6cu23bthBdopPOykNGfEoaSr97A9khgbkE0lowc3LHfiErp0PCAms6j
 oYUXRxKcov9Srhk+QXeBw5roNuB10tSXVtDgeafr6EI3Lwn2+Dv2H8EHIrwfJ1DlxsjQHeIQZ
 dqNOzxPrkDVkc5dkq7crRXwzY5/3QFc/JSyxIczn7K1bVgy/RpQNue95VhFUccISls39yOqjB
 GrSBN+bpesyN/slwLgc/5zOivnIZz4fFIUCO4l/yedGnDasl3OEQmOv+Tk5+lF87c5/sAizV7
 owor9H3lYbX7cYmFhUmweLasE5mQFsFL6ks8xtM7oTH+BrsmxUT0VjeMK9XMo8XXtUK4LNUm+
 cgQbGWFKbUjDKfkZQUyggfYfVM6l/R8aUqiAq2QlGK9yp/q1GE5KckzKKQiBMCp6B/0TUpCeb
 EqoKyY70Irul8UiTmarHVVgIe9ZX0qZrpH+7z1ReZ6B1FDVIQ/dTzsrmr5zkRuAZnBzCrSNkB
 nWAz0yw/DU+cyCjFwa+7ZgLw7h+fQ9XqJXIf3h5jsf3Y2Ls+jn1llzDzXVEdKTwJAFRNaaWld
 Y/TbtJOlZU44HUnYiYm9u8zJxh3qWALVnudO/35aWtS3+yesE05t0ohmXxKNzJTZmgYFLdpkQ
 mWpN1ZHHeVwjtDyaX
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KYQ1Z1hTmJAf5xTez712SlOtvS66W3Ehu
Content-Type: multipart/mixed; boundary="aNbvGTqpBk1UmcdvQl66jWs7SsduZPEgn"

--aNbvGTqpBk1UmcdvQl66jWs7SsduZPEgn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/3 =E4=B8=8A=E5=8D=882:47, Josef Bacik wrote:
> If we have an error while building the backref tree in relocation we'll=

> process all the pending edges and then free the node.  This isn't quite=

> right however as the node could be integrated into the existing cache
> partially, linking children within itself into the cache, but not
> properly linked into the cache itself.  The fix for this is simple, use=

> remove_backref_node() instead of free_backref_node(), which will clean
> up the cache related to this node completely.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/relocation.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 4fb7e3cc2aca..507361e99316 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -1244,7 +1244,7 @@ struct backref_node *build_backref_tree(struct re=
loc_control *rc,
>  			free_backref_node(cache, lower);
>  		}
> =20
> -		free_backref_node(cache, node);
> +		remove_backref_node(cache, node);
>  		return ERR_PTR(err);
>  	}
>  	ASSERT(!node || !node->detached);
>=20


--aNbvGTqpBk1UmcdvQl66jWs7SsduZPEgn--

--KYQ1Z1hTmJAf5xTez712SlOtvS66W3Ehu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5dq+QACgkQwj2R86El
/qhpYAf9GwaZSrzWZlBVLtzmVQvcAJEuNE7RqfUu1uwnZRIqU1YEsoA5lDv1yKrM
LqZU3LL/5DR4igTyH5lxIeUSIDVswkwJD2XwuFWbb6FSfKQelzdXKZdlMSlwO74m
WPurJpm+qUC7JDxzZnClj5PYZiKEuGBdWMz3cKWeYbRgbQ0Blmh61LU/fWmB57cl
ztbKg/a2hTKWX5fy/Rt2PWf7c7qjlEm89JKMKk4ixYoS474FIlFFswpM9ZjmomRA
60nNRV7nszh9eqELDAGSQIHc0zj4P4xEIAgaFBFM7pzTW50u6Suar0eAzCCokIwO
WVF2Jy0ZU6yKr+OgmczdEyw4/jkh6A==
=lIKh
-----END PGP SIGNATURE-----

--KYQ1Z1hTmJAf5xTez712SlOtvS66W3Ehu--
