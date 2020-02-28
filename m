Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF5A1732E4
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2020 09:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgB1I1c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Feb 2020 03:27:32 -0500
Received: from mout.gmx.net ([212.227.15.15]:45267 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgB1I1b (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Feb 2020 03:27:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582878445;
        bh=XcUVy9XNbLztyN123HbUHPD/BgeiB0mVhBVXvjBSbis=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=gxYx5aDROEkZw7U8rWuVy+ywu2nw+KTRfFHT9Pjn8IwysgwDW86FYDU/7a5oeD92Q
         KPKqd7SptQ7CSLJN012s5RhFVPEFm5fcjvMZ1P81a+vvEFH0H7+y/tXlb+QTclhjYi
         MgITbzkQ3Gr953//Pnv82CdIkUB0mhxAIHOamO9w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N1Obh-1jWR7v2z8N-012lue; Fri, 28
 Feb 2020 09:27:25 +0100
Subject: Re: [PATCH] btrfs-progs: convert, warn if converting a fs which won't
 mount
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <1582877026-5487-1-git-send-email-anand.jain@oracle.com>
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
Message-ID: <af69d1ab-4609-d603-980c-b8a6cfb87f43@gmx.com>
Date:   Fri, 28 Feb 2020 16:27:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1582877026-5487-1-git-send-email-anand.jain@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yAMwZyG777poJ3FMB1meoNjiC48BTRPh4"
X-Provags-ID: V03:K1:HH07DOwR0sIwci/hMU5Ni//jOlA6UCLjQWfUXq3HW3Mp6p3vNb8
 cscLAGOtkS9rAEI2tKvd5cLChliCfrafLyYB6DVDUwh8Rs/1hKzZ2UgS+HUtwZa4ouVZI8p
 nowCyANt6qL61/EnI1A0LvyEpumkXovCjb5DcwPdbteFxpuFFwXdZAU5YdQVCqj1jECBsjM
 DUaRo3o7hNIgYqNPp14fg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WNXBwrh/TgU=:f1qh/uljE+ldZLClZZkPp9
 Ygejj2fI/p8KAGD3e/FvzzdD/Kqy68FQJC302j32Us6K/WEVeETMuvaFMFe2rpcT6yw7Z0hsR
 zf+yyh/hZUYLG4G7TkEphsovVfcnqrJ3DkIGPDlvhkqo0CYpIFAstAyNO5F1TI4iePt2wUwkB
 bT+ORw58lom+tUSqOc1VIBsWDuSpEimP+i8g5p5BEles8PE/orqzri/XrABEb/rCfO3u8EvVG
 1wosE1YA8QuNPNGGeHuNpw4rIzLORlNDcwKd9CIM2BdEtTD+Y9ntTMeL0aZSdjBa4IbDny+0r
 Q4GH6uqfyvf1iZ6Gsv6wRZksNR0SFoJxfXa0U0VQLjwnqSy0QlgUaBhmF9dOCtk8zGidz1vvD
 UrkBSsRyA9ArNMtcgrTWCLz8tD8xZyCBR9cW/lccac+PO2yZewZCx/mWzhLRDnqtYQA7IFREZ
 r0WNWk/m/KSCfusRmjqiWH3OI8aG23a+LkiMauSQ5Vw8FVt4qD0Vk8DzU6Ia80yD1FybbECRF
 pTRgmiE/ABwJuIeofUBXrMK7qf7qtcF4+neauRT2ehEibnFyxcz/VpAoLxBFeH8ITkjp9mw2J
 XNDR9tjwkOoC2vZ/Ql3iaHZek0/E5VvdWlS8Ai4FYnzB1Alo+HLvR23fNnLmlJVsJvuhVcWaL
 E4mkw8daiyeN0KCf0wQeQ2BmvEHmKLYL6C7VHMDA30OU8YA0nhQOHJy2bUJNW4671/07CqRyW
 kCgtSwHU5a6SHaKq4+0McKy7+h+pTPbpeP0AbZllChx2zokTuNEKvLCtNGOInyTdX0EUz+fJ/
 OE7AUOdsdWal0Z6SI6S7eDOOIiFml8nnbbL6k+v+gpc9T54GdP2dQVaICCoMcc4SOqYdNTTc8
 ryVnJm3fnVp0evvZIsaUyG+uilUjbSGal041CBUyoLEnHsIvUj1rQyvrDwnkMORfYIq2B3Wlz
 StgPfZAQ7yf15joTjFcC+fKz0mlbG3NdKHqU32qLg14ZoN0SSQaktEHR/NVp3FnRcyklz2jG1
 SrT8QV1OFxqJ0rHKw1mPH1RiUU+vPUnha/wBGMBetBUBEH7fMA8wauNyIdWjtfNnsAmMawTxO
 jFVKZmTqu0W4kAmlOpSXMtqJm1E75fPbGW7DY/+RsQmUc2t3WBi3mXL4st8x+gCJRRsTsXy0P
 jctjRFGW3aYUmKX/W5g2Dd/4ymzlJnr/GtQD65c5QfrXHI8J+dOezSDGC26P3GbRzGGcziSMc
 Mj6IXcZoPImgOIVOt
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yAMwZyG777poJ3FMB1meoNjiC48BTRPh4
Content-Type: multipart/mixed; boundary="cHcJRfxJJdftg44oSdPDqYhTwoOkwWKhw"

--cHcJRfxJJdftg44oSdPDqYhTwoOkwWKhw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/28 =E4=B8=8B=E5=8D=884:03, Anand Jain wrote:
> On aarch64 with pagesize 64k, btrfs-convert of ext4 is successful,
> but it won't mount because we don't yet support subpage blocksize/
> sectorsize.
>=20
>  BTRFS error (device vda): sectorsize 4096 not supported yet, only supp=
ort 65536
>=20
> So in this case during convert provide a warning and a 10s delay to
> terminate the command.

This is no different than calling mkfs.btrfs -s 64k on x86 system.
And I see no warning from mkfs.btrfs.

Thus I don't see the point of only introducing such warning to
btrfs-convert.

Thanks,
Qu

>=20
> For example:
>=20
> WARNING: Blocksize 4096 is not equal to the pagesize 65536,
>          converted filesystem won't mount on this system.
>          The operation will start in 10 seconds. Use Ctrl-c to stop it.=

> 10 9 8 7 6 5 4^C
>=20
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  convert/main.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/convert/main.c b/convert/main.c
> index a04ec7a36abf..f936ec37d30a 100644
> --- a/convert/main.c
> +++ b/convert/main.c
> @@ -1140,6 +1140,21 @@ static int do_convert(const char *devname, u32 c=
onvert_flags, u32 nodesize,
>  		error("block size is too small: %u < 4096", blocksize);
>  		goto fail;
>  	}
> +	if (blocksize !=3D getpagesize()) {
> +		int delay =3D 10;
> +
> +		warning("Blocksize %u is not equal to the pagesize %u,\n\
> +         converted filesystem won't mount on this system.\n\
> +         The operation will start in %d seconds. Use Ctrl-C to stop it=
=2E",
> +			blocksize, getpagesize(), delay);
> +
> +		while (delay) {
> +			printf("%2d", delay--);
> +			fflush(stdout);
> +			sleep(1);
> +		}
> +	}
> +
>  	if (btrfs_check_nodesize(nodesize, blocksize, features))
>  		goto fail;
>  	fd =3D open(devname, O_RDWR);
>=20


--cHcJRfxJJdftg44oSdPDqYhTwoOkwWKhw--

--yAMwZyG777poJ3FMB1meoNjiC48BTRPh4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5YzuYACgkQwj2R86El
/qj0sAf/WkAMa2kk4bUvXBaqbVe6/KliHW/o8oYNd/Va1Jcuu4t+OVNDHVP7V5A6
gDzYD4XM8KdjnoTlozQU1+F5HQsRU2YtsQ9yuq4NSUA3Z+12HNfnr7APKDbo/evm
oc3CyCTr/yzXoU9FX/X30LzvbNgw5wTT5Z8g1nugc7f6cGHdxT8j1imWauiWdEjh
e2dFURsHwQe0zI00fNAGzhnUST2eA9HrFEVLzGPpopJ/Hm0fMcp/p+bO0LcbDK/m
rcDSbU/a9y0DU6I2Cd49SqruYVLm0w++Q0YFs4SqK4aHJOQQ5/03JDnwP+K+D3a+
R71Q0KMjvRuOXtWdOfWal6qhjNpeMQ==
=7hFE
-----END PGP SIGNATURE-----

--yAMwZyG777poJ3FMB1meoNjiC48BTRPh4--
