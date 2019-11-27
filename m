Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4A4810A96A
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2019 05:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfK0EcF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Nov 2019 23:32:05 -0500
Received: from mout.gmx.net ([212.227.15.19]:52087 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728264AbfK0EcF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Nov 2019 23:32:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574829044;
        bh=YpkPh+VYfGZ/1uz2QCt+XQSxuV6kvBOhlok9jVIQEPs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=IuM1RbkpNCIDARC+jtguCg0vDJbRtc/LNT/QmdgzHMvzqorhDVwXgb6jd9X5KvJxW
         qJrG3J7GDzb0sVqunaF2+UDCLetTDCK5RbEA1bbnUjdUBoLkRqSMcIWJQTCCXy7ujf
         QXqGRDDzx9tVE0+O4ZiQSzC0VffDUpXF/dPjcqw4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1McpNo-1i127V1leU-00Zy4c; Wed, 27
 Nov 2019 05:30:44 +0100
Subject: Re: [PATCH] btrfs-progs: qgroup: Check for ENOTCONN error on
 create/assign/limit
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        anand.jain@oracle.com, wqu@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20191127034851.13482-1-marcos.souza.org@gmail.com>
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
Message-ID: <0d82cb5f-9d01-0e3a-26bb-33019d8a9e65@gmx.com>
Date:   Wed, 27 Nov 2019 12:30:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191127034851.13482-1-marcos.souza.org@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3cmT2sgJYB7IYUdztG3GlYEXXSgjFfRdZ"
X-Provags-ID: V03:K1:S9Id7kbWD9i1OVJ2zGWkGubHf7EKSUg8EfFV+CVimZ5R+kgPYMF
 esCqF3MOlPxZzf2M/PToa6LDbr7WAdxB9pirRNyX354AsxEPhnL2MVZYcHjiqebM3JLyxNj
 lviPoCiI9QAxq+epKqtyy3T1oD2x8fjq4HTgjA4KTAguXl6fKUTAxjhx9HYwwBW+DgN+MYy
 6ivce8s8/3iYJWtYwL2zg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XZRUzN+FLgE=:h6cQA8Azo8vV+Bg773rZU5
 BHaAx/LmDWiPo9UHrvjcUp6f0QLLhC1u+NIcwN0OjmCeH6zv8ArWYmr032HNzpeXyiwOqJSoG
 6gjzq9aNpvCdsLE0i5btaXVRRfzra83lTjWM7wvODSKAG/Rc3VlCoTSdHnrFVnPdtJtbMT1rV
 JDbMnc76q7rxWZXWxqRV/8iygJbVsrXUg9on/t9DmkukOesJ/VLVjfZcu53aJeL6g9XPLnhKj
 fezt0pSi9FtHz00TGzxgX28xeYyRVP/8y6+oj0+T3vJH7F8M/3kt5JtwY2uH3RG2jBlO655bK
 vt3VS4OyZMQSrsAh1Jb9NOyAKYzzMWIq1VWMn4QgJJ2gytyENaH9nh3MTkFdRHR1fiAhST1l9
 0qHi7FRJR5Em/iaS7XJpOUhq7+A7RQJitPEoPXy6QTX7rDZjywRp7YGAGe6U8a+G4W6lUJ01V
 Yp5ciSbeNFBr6xazYtIRJr7/CRQBNKMhLcEhtHS58S0hyWwrZpmR88lnSfdhsntBRbEOyWGlr
 dqzxqgpB03cO0X90pPBl1ckcZaErzMQ8QyCiRCCB1StGlp1JBrUP0bJJ1AshKQsGIPmK2TNWl
 15aCFNsYL96H2qw7iWIyqbP36bpN1+iOkAw34lXxnWKSX/A+Zns4LO0NXWWXNQp1CG0iDCjvX
 x1DCaWkSyp9P4kld731aoG6639vfmrmGKONj4jFQf0m6xOG4V6UIoxtX4D6fcfHFDQtmQGYEX
 uDyVpJTW1pMmUM47N83T/YLQkKveq0S2PGzxTONXVeWusNxILhf7js2ve9KOI6YCgoaF8TCj8
 syEPxAnNkSTaJmbQ5BbYmjOhDgVJkYTMvo7OrfJ9lSPpMCYu8797t1ZoIpwRWnWBP+gwzTVT/
 Kxx9NAnhFPRUIOtHju//N0NKVcI8brrKxRB7FY8AO0SIDoiV6RWstPCjY0Q1DE33xOIHD5Zs2
 SCo598Tzuk8mQbppsJEFAr+HvqjOkIp7IB1GdwJ3lPdfR7z44i/J00bbYx7STmEZLMXM0d1iW
 4Rz1uTdQkIwRAMpEv2wJubBZI+ybQhE7mHvn/0YsVlgDtXLQEZhDahe32FRbWNgZBq5M27Fi2
 mXNRx00H0eLanMQteLu5Uri8FbgV8aU8kqg5HwR+sdk/T5++MM+4x4mPFI5iVv6u6OTu6lsNC
 07YatACc4bGe1UNvXmnslPU7n39Dlt4iKtbVoLXxlwYwWj0LigV9jFOatAVL7FwNb724KakZY
 caZPCpRUmJVLxDkTohHvJadt4v4aiQhbiafFozlB/D//xk1vEyNY38xVPI8s=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3cmT2sgJYB7IYUdztG3GlYEXXSgjFfRdZ
Content-Type: multipart/mixed; boundary="LmOW9rWQSMwTkDgBfzwsji0HMvUj1hxIl"

--LmOW9rWQSMwTkDgBfzwsji0HMvUj1hxIl
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/27 =E4=B8=8A=E5=8D=8811:48, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
>=20
> Current btrfs code returns ENOTCONN when the user tries to create a
> qgroup on a subvolume without quota enabled. In order to present a
> meaningful message to the user, we now handle ENOTCONN showing
> the message "quota not enabled".
>=20
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Don't forget the original -EINVAL.

So it needs to cover both -EINVAL (for older kernel) and -ENOTCONN (for
newer kernel).

Thanks,
Qu

> ---
>  This patch survived a full btrfs-progs tests run
>=20
>  cmds/qgroup.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>=20
> diff --git a/cmds/qgroup.c b/cmds/qgroup.c
> index ba81052a..6bfb4949 100644
> --- a/cmds/qgroup.c
> +++ b/cmds/qgroup.c
> @@ -98,7 +98,9 @@ static int _cmd_qgroup_assign(const struct cmd_struct=
 *cmd, int assign,
> =20
>  	ret =3D ioctl(fd, BTRFS_IOC_QGROUP_ASSIGN, &args);
>  	if (ret < 0) {
> -		error("unable to assign quota group: %m");
> +		error("unable to assign quota group: %s",
> +				errno =3D=3D ENOTCONN ? "quota not enabled"
> +						: strerror(errno));
>  		close_file_or_dir(fd, dirstream);
>  		return 1;
>  	}
> @@ -152,8 +154,10 @@ static int _cmd_qgroup_create(int create, int argc=
, char **argv)
>  	ret =3D ioctl(fd, BTRFS_IOC_QGROUP_CREATE, &args);
>  	close_file_or_dir(fd, dirstream);
>  	if (ret < 0) {
> -		error("unable to %s quota group: %m",
> -			create ? "create":"destroy");
> +		error("unable to %s quota group: %s",
> +			create ? "create":"destroy",
> +				errno =3D=3D ENOTCONN ? "quota not enabled"
> +						: strerror(errno));
>  		return 1;
>  	}
>  	return 0;
> @@ -447,7 +451,10 @@ static int cmd_qgroup_limit(const struct cmd_struc=
t *cmd, int argc, char **argv)
>  	ret =3D ioctl(fd, BTRFS_IOC_QGROUP_LIMIT, &args);
>  	close_file_or_dir(fd, dirstream);
>  	if (ret < 0) {
> -		error("unable to limit requested quota group: %m");
> +		error("unable to limit requested quota group: %s",
> +				errno =3D=3D ENOTCONN ? "quota not enabled"
> +						: strerror(errno));
> +
>  		return 1;
>  	}
>  	return 0;
>=20


--LmOW9rWQSMwTkDgBfzwsji0HMvUj1hxIl--

--3cmT2sgJYB7IYUdztG3GlYEXXSgjFfRdZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3d++4ACgkQwj2R86El
/qh/igf/WblovK9NTD+AQcLdjWJvH/QaHJYNFIvjxsr4ZQg3+j6jJyY0JKnGvACb
wIAevnMuXCzN+ZKs2jAW+x4aN1IV0CC2xD/oSELcJjTiaVWa1q7wFTOkwxO9YvKX
QkmZanOfo8jNhoaOKn/wCo8u1tMSQ35DHZrzw9ZVE+gcasSZkhAZjFWNvRTxLKgf
3PDYxN9pRFdcyiI66JuW6YX0NhbDMS4f5NR8GP+Gt7DDv9rI6oLxCojs7IxgPy/J
s11yShC2x2pcyKCfqp69Id2vktZfIdjwQvGuMcXEeG3fHZRDc9w+xRFn2p0nhhns
EkojHW2ApWQTWCFm/nT5Yu5rZmZGXQ==
=/oCU
-----END PGP SIGNATURE-----

--3cmT2sgJYB7IYUdztG3GlYEXXSgjFfRdZ--
