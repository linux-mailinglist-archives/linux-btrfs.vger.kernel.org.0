Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5AA8777CD
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jul 2019 11:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbfG0JHs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 27 Jul 2019 05:07:48 -0400
Received: from mout.gmx.net ([212.227.17.21]:44459 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727885AbfG0JHr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 27 Jul 2019 05:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564218459;
        bh=o7ISfIU1cXUGnsk4tV15nK08a1/U8Pj6Gl0RvOlMkEY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=BjdgUQoXYnPfj1nW8YRc4vFb/WbImTjorao+/gbJd404hnVBOybPr2FipdpOdNOq3
         pL8gP+yXG74DoP9GQhuuyMjKDByfeUIMSTEVTe5vbIXJg4e5lft7PQaPQX6AASVL8J
         orEE26bGJrH8znkjuBwnpChS6Z+c2qOrc85tx8m0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MirjY-1iL7BH0H5Q-00erur; Sat, 27
 Jul 2019 11:07:39 +0200
Subject: Re: [PATCH] fs: btrfs: Add an assertion to warn incorrct case in
 insert_inline_extent()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190727085113.11530-1-baijiaju1990@gmail.com>
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
Message-ID: <de8c1056-8b6b-42e2-561a-954f77b7ef6b@gmx.com>
Date:   Sat, 27 Jul 2019 17:07:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190727085113.11530-1-baijiaju1990@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZM7glqX7MdarI7SC83bS7vrAtYhlcyAMi"
X-Provags-ID: V03:K1:0dFkT4ixDfeAOX2DsXrwgZTqQWzOlMfna9agCdXWttpLgqwmco8
 eR3fW25esuzx23JJoCcQ+9C9ZsHxXRkfvGJT3f8jn4Q3BzvgBDu6bJ6L6703yqxEtXSUqGn
 eFCk91hZCjSGJRfFl53I4NJFGxYfbKVS8qt9akIoUxCQl65dJf2MphkWPVyYcZ00XsfaK4J
 C4VyeV9pPsxc5WuIfDqrQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:L3U+MkvE+W4=:EcTsapfPzFMKJac/GJr1+R
 gl0CwUKu3vIYYiQwuMyZWeAnI3CP1dKoRbRjlKewZj+Qfzz9H+9PdpCXo3bFrHGnCH6nqWvsn
 oC3FK3ooHWa0amiWEvy4GkNKFqGI1YpFAYobmwzT8kv7Q+D5wxgW+7Mw17DoStBC/9Q9SWhRv
 R9ccZnVdiBsgfpOE/gex8TZk78WQtSCP7bBRoXcA3HXUhvDJS7JBo9DQvhBrY6zfefciGQffn
 fyR0up0xjmgMHkGosgEmdCR0EoR4Mk4LeiGaB+7Aa7SYS2UEGgqwT3HZN/wbhmjwD3CEYygEW
 7g5FIHcf8JCPbyYNEbZAUUid2PiApsc/CyfgBbNA0k2df7aRXj1CdFCDCwS3jfJkQpsOIp/HH
 BWNNnh0gPgtWWxcQ2MZAhhXRzLz8Dnvhx2Mx7IQITVto05+DTL21hXPTW+pgaMDSO+P/UgsBy
 xucfE1vr0Kof6U+y5zaLZgufsdsJD1kc1wcxcj8O/rOC1AlDTiQt4sVYqV8SD5hlqxzySSWkm
 vDDtiKmvi6TZhqm/nqim0moNWToafRlPvox/JP0wFDgx7FDva7LeX48MNXraXk2dKL0Bin9Z1
 8P/ZpZMalOIFjtkLehsV+hNeknCcFwEOXXjvvvbPA1w0cjbwsIPjBsiUge6IfgZy9dyhMmRLt
 AMbm6GPWnu03mplPB6894RyFydwRqhUUSRjujpe9steNcj1NLaOYSSCXWq/UfySS9/jIBuYlk
 HSyFdPRfe2TZlwbXLdjpWqeaRFOS1dFL8QLlYYYC8RtAOC6gMAJ3JU5MWINVpKe/Wn5CqR3Ia
 HbQ9kT77zmOuLE7T5lkO1aPz1kRp629gaaap1sxApBwy8UThB1hLjDuPwoLgWUSCKyVg7yxxy
 X/DJlcTDNmf+CEA6giwOEnY2Egk4ivoER0HRsM0dtSk6eotEKBQsQoR+siYeRnd+65o9f2D/v
 +LgQSxOGUrbEyKO0H9nPj/VPOf/EpKvV8cquIthfr1krUhhgoJuxptLlDq8Cl0/cnRVCZoU0x
 F+ZjElzXmBrjW9Bfej/8qIbBAHzKiMd4arlo9XPp+7rV5N82i5YVYxv8g/1OAsEJZbCXcqW7J
 TsjTlVQ4buLaCs=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZM7glqX7MdarI7SC83bS7vrAtYhlcyAMi
Content-Type: multipart/mixed; boundary="De0IqULClqaQYiATmO7AVtITJlCdwA1lI";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>, clm@fb.com, josef@toxicpanda.com,
 dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <de8c1056-8b6b-42e2-561a-954f77b7ef6b@gmx.com>
Subject: Re: [PATCH] fs: btrfs: Add an assertion to warn incorrct case in
 insert_inline_extent()
References: <20190727085113.11530-1-baijiaju1990@gmail.com>
In-Reply-To: <20190727085113.11530-1-baijiaju1990@gmail.com>

--De0IqULClqaQYiATmO7AVtITJlCdwA1lI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/7/27 =E4=B8=8B=E5=8D=884:51, Jia-Ju Bai wrote:
> In insert_inline_extent(), the case that compressed_size > 0=20
> and compressed_pages =3D NULL cannot occur, otherwise a null-pointer
> dereference may occur on line 215:
>      cpage =3D compressed_pages[i];
>=20
> To warn this incorrect case, an assertion is added.
> Thank Qu Wenruo and David Sterba for good advice.
>=20
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>  fs/btrfs/inode.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 1af069a9a0c7..21d6e2dcc25f 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -178,6 +178,9 @@ static int insert_inline_extent(struct btrfs_trans_=
handle *trans,
>  	size_t cur_size =3D size;
>  	unsigned long offset;
> =20
> +	ASSERT((compressed_size > 0 && compressed_pages) ||
> +			(compressed_size =3D=3D 0 && !compressed_pages))
> +
>  	if (compressed_size && compressed_pages)
>  		cur_size =3D compressed_size;
> =20
>=20


--De0IqULClqaQYiATmO7AVtITJlCdwA1lI--

--ZM7glqX7MdarI7SC83bS7vrAtYhlcyAMi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl08FFMACgkQwj2R86El
/qhxOggAkE+CQ/VVAHAjNdvtaChxrAZs7xEx1CZKFW6XPociGQmS9bTOWudBsuF/
2QZWQP60OyToln3J+X/UEYNoOdZLygAF7a51Oc+K2Kpw+qXTtt/Wde8Ji7otktPC
l0GFi4yb5UJ9iOnLPDjUwk6xfKLKvKNXhXbjXdD05izh7VvKzNYXyjX3CC1TVe5W
K4HFIr1sIMeG4ja9uiRoi6+Ovzj9zOEmFQ1z0maWdD8evdZybpsutOcHyBJJkKTA
HuyCG96U2r5cp4euwqqMDQccGKDo+AX/2A3Q5tBZ7L140V4Yxnda2By+2ACCu55f
fm8bBm5anFKYigLDKCv3D3fkwv0p0A==
=D/27
-----END PGP SIGNATURE-----

--ZM7glqX7MdarI7SC83bS7vrAtYhlcyAMi--
