Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438D32423B0
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 03:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgHLB3b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 21:29:31 -0400
Received: from mout.gmx.net ([212.227.17.20]:54369 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbgHLB3a (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 21:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597195763;
        bh=9+ok6Z1SHfAWNyxdXqtxxTj9gxA8meFy5dabhpiAiwU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UiOT1HbAaUXlisSJmvT5yoyaL8lzI07ubbqxEtEUf0pKfixnZZmium8YupKTCLIVV
         cC7PRnwIzgOVu+ICyVlr41jtKLzrD3D6j+rx/9+4tLuP88914ipo4lywagmb43JoEo
         5Oul+MTu++Y+92Vi7w/x3NPv9M11JZ/u0b4oJ0n4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXp9Y-1kDM7i25tc-00Y8H7; Wed, 12
 Aug 2020 03:29:23 +0200
Subject: Re: [PATCH] btrfs-progs: --init-extent-tree if extent tree is
 unreadable
To:     Daniel Xu <dxu@dxuuu.xyz>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
References: <20200728021224.148671-1-dxu@dxuuu.xyz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
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
 ABEBAAGJATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAK
 CRDCPZHzoSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gy
 fmtBnUaifnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsS
 oCEEynby72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAk
 ZkA523JGap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gG
 UO/iD/T5oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <bb0881e6-0301-2e03-8ad2-ad24055c4351@gmx.com>
Date:   Wed, 12 Aug 2020 09:29:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200728021224.148671-1-dxu@dxuuu.xyz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BmbH171MibAxc0NwEMHvr4wUopvPe6gqw"
X-Provags-ID: V03:K1:5XTldIcfeOHsXlkboTYMnEanGTUBtGOT4BpoW37jGsL/hNNfEfV
 OmKMgxBpwykNtQizO7R5+Dbvh1WyxjkKClyysZsuwsn7HXAr4N26vb5MxartqWzxT6EGFpg
 maYn+gMH+a05mRpByu0Ymjt5C6749+7h3gTZLm1N8t7Bqgolnd8pZvCCjTPeAcUbhQjbGhj
 9RTRZX20UCVm9cvCWnXQQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kv2qi6qgnbo=:bh+l4aHdHz7KVpooINlkOe
 HBP2cz1ytUfkv2IdjcDoeNGZPAy3iYriW9j/ZVwhuDWn9QTIzbrRFa98HN0R0x+VJYpcF/D9M
 dnmOJ1ILWGw7kQNr3dFdgyJVJ5yJLPGXaIgvXsmIUzVCO4fVoQsCFYvaOPuM6SRrLOnZ7Zrf1
 wOgVYK2yqKJc6TF0afxR5UaAK8Rt85X9LO9JGm+1M9TlI/WNl4w7T18bLjqX9cl3x3F5v6Wn9
 IJpkN3yAEUvGX7jxqh2yyU8GbXAmVt71Mc8cc9TvxZLtU2cnw55vOrmpJ0oasDpEDSDwTBavX
 1bIdqNW6nXmZX1A7uv0fJHINB78e0/IRI3bUUgsUYQ9isalbiS4rMiiy2KYb6yFnTo/U0H09C
 PXl5tewlhzuv0+BR9EPC8fizUgpp925h63og/VxjmjdMJbR5SSZNSqeTPYbbq68UYUTHaDtVQ
 jirO2xcQoppEBC3TNArEeHylqWjDeKgvZaQ1TaG5qjadun6svvl2kpXuSvB9KrqR8n4cdD71c
 tzBrNV4NlXog7HdWHgK5/PgyIOypvOMqjNy03jXS/jOtjgO9YHRu1mXLT1Jcw7VU83vY0sOi6
 v79cZhXPzVHqHp/QKOKPqPj2jG1Nq/cdRb6C1JlaF+/8OfweV2OIJb9c67tnHXyryTl+n5ccS
 lyynMP4TPErQu+9GB3np5MbG33ZGcYAOvMBUzIU+41xWAm4FF1sy6pSjApntAgM/bE/nlJvRE
 aUCF6SOVeoGqfvR4rVtZjEjOytx/b/xiclmFp9RYPBD3XKsmQ+uO2Cxu2CHTWgnATzdlqJYxK
 SNjiI9cMcgOWJnHxu8Lq+xPAzUUrtJbkVLrfBvannvsh/32D3sQEyJOOXD+u3iLSIxWxKJ3L9
 2h12JizXXFWzD7T5huiTEzjYwiAz0moTPVBfPdfG53+ltqbmVz6ZUWw5xdnSkeUPu+38re4S4
 2UczlF1q8TkAjfQYyRsViJisQpHN+HlZTHijJicrQzsSpbVvmff0vVYEAcBQHNh0L5Lij4fWs
 3PuDxyb71er67WbNnzIz1wHgSAno6krSoHd5BBrnZyrL8p0FEInVDCXI7nJsG4pLps+tM+0S7
 b5RF0bxW4OUB1KvMaAMNQZkQ5lyyV8U8K7r9TViarMuWAlsTSy30uYOUfUVHW6rSfXhqRmgZ4
 Ub7v6wSotS99HS6HGsT7ijtxEL+BvQt9qOtMRHbCuW3Ihjd/8cMs/3fibqf8KE1PCJY4nTQnt
 b/ndnjoo+sB98OKVu1oPPVfexr93BUa50dFc+nQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BmbH171MibAxc0NwEMHvr4wUopvPe6gqw
Content-Type: multipart/mixed; boundary="nnb1vNgciq0RGPfiH8aB94XjGM3Q3Pmx6"

--nnb1vNgciq0RGPfiH8aB94XjGM3Q3Pmx6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/28 =E4=B8=8A=E5=8D=8810:12, Daniel Xu wrote:
> This change can save the user an extra step of running `btrfs check
> --init-extent-tree ...` if the user was already trying to repair the
> filesystem.

This looks too aggressive to me.

Extent tree repair, not only --init-extent-tree, is not considered safe
overall.

In fact, we could hit cases with things like completely sane fs trees,
but corrupted extent and csum trees.

In that case, I'm not sure --init-extent-tree would solve or just worse
the situation.

Thus --init-extent-tree should only be triggered by users who know what
they are doing.
(In that case, I would call them developers other than users)

Thanks,
Qu

>=20
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  check/main.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/check/main.c b/check/main.c
> index f93bd7d4..4da17253 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -10243,6 +10243,10 @@ static int cmd_check(const struct cmd_struct *=
cmd, int argc, char **argv)
>  		goto close_out;
>  	}
> =20
> +        /* Fallback to --init-extent-tree if extent tree is unreadable=
 */
> +        if (!extent_buffer_uptodate(info->extent_root->node) && repair=
)
> +		init_extent_tree =3D true;
> +
>  	if (init_extent_tree || init_csum_tree) {
>  		struct btrfs_trans_handle *trans;
> =20
>=20


--nnb1vNgciq0RGPfiH8aB94XjGM3Q3Pmx6--

--BmbH171MibAxc0NwEMHvr4wUopvPe6gqw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8zRe8ACgkQwj2R86El
/qjljwgAhgfN4DlLA47GXBqVr5u1ORS+yByW39tn25XF8tU6BMd6oRuVXoENV1Dp
BamWC6I9j1ZnzwpuO5g2VGXN2TvTUpOdhYuOfEg9W0RIYK/26+Yg1SgIoh7URDxs
Y8M0h/tu1xeFPxmLnLngQCngSypArll8R0sIPSY91zfoLR8Up5rCPctQPwzFkjlW
98QnTry3e2kfVLkxN+YMFfZM1+1oX/eJn/xw7igUFnND2fm2s1U+HN0hxExswA2c
gh8wpxPx7SP/xaIY2OaGoYDTKsFihxlKrEZaj8nFLFtTsALY0rQg9xAJ6bEl/CTg
Sd+kCMAYJ/fsS20qiKI8HKBra7OvfA==
=M6uF
-----END PGP SIGNATURE-----

--BmbH171MibAxc0NwEMHvr4wUopvPe6gqw--
