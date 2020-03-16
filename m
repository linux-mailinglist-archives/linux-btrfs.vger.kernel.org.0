Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6B2A186A88
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Mar 2020 13:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730901AbgCPMFR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Mar 2020 08:05:17 -0400
Received: from mout.gmx.net ([212.227.17.20]:38887 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730845AbgCPMFR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Mar 2020 08:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584360293;
        bh=hUYD8jX7XuBOjLptipT/5EeuYr7POCkY5WtNrIBlGfY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=l5jEyunfb+sFR3Nl4tPXnAoNQRFwH4QjVTUNG0osmUWW4QCMq92012h14MMtFkWlS
         Otc5iQkS3yjsnmMrJnG+doLMwa8aCGd3t1B/zYHwB527GqTdYQLao+Ev2SbYGJA1LG
         AzyuvGbcFyIqdy0vdeH0hxKE38zreRMGbgr2Etj8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0oBx-1jYWhd1mL7-00woAh; Mon, 16
 Mar 2020 13:04:53 +0100
Subject: Re: [PATCH] btrfs-progs: qgroup-verify: Remove duplicated message in
 report_qgroups
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>,
        linux-btrfs@vger.kernel.org, wqu@suse.com, dsterba@suse.com
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200315034253.11261-1-marcos@mpdesouza.com>
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
Message-ID: <f68333d0-b71c-b331-20da-84813a349b9c@gmx.com>
Date:   Mon, 16 Mar 2020 20:04:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200315034253.11261-1-marcos@mpdesouza.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BlZbf4usivLdoZ14aQrexWqOdrcypfUnS"
X-Provags-ID: V03:K1:kifM7oVpgg+cPNv3LJhL5bcVoRjNyzeuoPq4m4QcSy8zBeZo0A/
 5+LTp8tEPrinUZaizO6oJ3wy1NGD9VwaJFfaQeopQn2SrRG+jlVwdkswzn187Qt88s6eZdb
 of6jC0tUf69V6Y1ITuEhCKfZqhBJ/Nv1tN85bqIAKtMHVnAY2r9F7LJV56T/8UplzMhAIfG
 p4IHB3+d9Bs3shOLmjcoQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OfEBW4QGNSs=:WEaLVY10joXUVtRxPQSEPd
 qb2WtwE3vjo4ZjKoTck20swDpbLpfCIl9FVYrv3holCikKYUZnEwGnmbkZiyhXlL6TRfqp6Ql
 3PuhPUmmPGXv2ZVX4iPpZnK21WY45p3Y2ddz056iV2t6PpqVigvcHZ/K/5mwBEbxlTeUAy3Xz
 U2znc+QU/9cKbRkcSPw0nJdOgmO139Ad9D3IzY6pT61GBdTVzzCSiq80l68jLNKXqtQn90O1U
 H0e/E5ulM7LwE7hKwOhQW692dvYShImdDPFY7e8pcx+F67VTmRHjDJlOaKHJC4btfSay0nH0m
 AEVVMN7cNGjXcw19UmML/+z+GwA3/lufZABJVz4uzYEThYRIGfYX0BVl6FNzA1yYhSZ6wGgku
 x5yxTQK7K4ck5HEaQPsayWV2NebbmRAinW/d5ali2hs45pLZ+BeG7KLANE6fFip/ROMDksAax
 Ipb9TkCzxa34Lg0XOege3i1SnJEfpuCKjomRa1iP7UZPz5f5Fc6MFN+cSD/h5hCIvizBQKM23
 5hN7ns7Ji1L3ypobuRW4yfin4e1h/8L0zjikZy6XBCAcbUgX5rRitvq1gz5L5GE4+AHAYlqKS
 XOxekHvnTtB6IEzhlzYcWs+bVVso6Aydlko+N7p8yXwaeBfvsrvxTbCGxQFHrVbRW0jVSqY12
 rXSP/LRxHjT/lYsuMzdLAHFJo/fLlLYyvs1WHgwsHv2XQgDpHV8Y5Pxi8hl270uIGOVSBEuzM
 0VRbQMuIr6T5CIK6T7t876+OcYypyZ/g1JH4q6E6fN5gGD/3iPngLz6wZtPM8/RzUWhUFLaVM
 Gudo+sdWOoCoNQxIBrlhrb53Gud7u05dy3KZK31bRxgAVOkgIpjM8v/UU2Fx/qC9PkzJRsltI
 B3DXL7V73w80nVyCt/DRS1YqNL9O0clNAKvTIYJvDCza6eRdicprUn7w6SmemImqjj33rXxXy
 SvXVWWhdPM8NVbqCoHMfan4vB8d9gXApP0mEf5M552Jd4oUQlCMO5dg9u9w0/Tx0JYLTviJfO
 LJzRwjwi82gQsv3cqgc/qrv+Z6oAUJRLUztFe0NdzEPP8kUz4A74djEISFKTKiSTd7AtBUXFF
 tbguaR/i4ftIYsgJ1OSMRS3ubHQLM7lBvG6b3DyY0kwbfKhBdQg3IsclzAV30FFahtt2QEOHK
 liT/RqLz9SFy0whLQnBYIwIufDeOpU3upHt51dQY9PA7VxTb9whVpFv1utZblJzbiZPYZnIqw
 q6FbvXRvoQxc+h6za
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BlZbf4usivLdoZ14aQrexWqOdrcypfUnS
Content-Type: multipart/mixed; boundary="IrdhYIYpCryU9XeunpYogybaV2EIS03xn"

--IrdhYIYpCryU9XeunpYogybaV2EIS03xn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/15 =E4=B8=8A=E5=8D=8811:42, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
>=20
> Since 1d5b2ad9 ("btrfs-progs: qgroup-verify: Don't treat qgroup
> difference as error if the fs hasn't initialized a rescan") a new
> message is being printed when the qgroups is incosistent and the rescan=

> hasn't being executed, so remove the later message send to stderr.
>=20
> While in this function, simplify the check for a not executed rescan
> since !counts.rescan_running and counts.rescan_running =3D=3D 0 means t=
he
> same thing.
>=20
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  check/qgroup-verify.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/check/qgroup-verify.c b/check/qgroup-verify.c
> index afe15acf..685370d6 100644
> --- a/check/qgroup-verify.c
> +++ b/check/qgroup-verify.c
> @@ -1336,14 +1336,11 @@ int report_qgroups(int all)
>  	/*
>  	 * It's possible that rescan hasn't been initialized yet.
>  	 */
> -	if (counts.qgroup_inconsist && !counts.rescan_running &&
> -	    counts.rescan_running =3D=3D 0) {
> +	if (counts.qgroup_inconsist && !counts.rescan_running) {
>  		printf(
>  "Rescan hasn't been initialized, a difference in qgroup accounting is =
expected\n");
>  		skip_err =3D true;
>  	}
> -	if (counts.qgroup_inconsist && !counts.rescan_running)
> -		fprintf(stderr, "Qgroup are marked as inconsistent.\n");
>  	node =3D rb_first(&counts.root);
>  	while (node) {
>  		c =3D rb_entry(node, struct qgroup_count, rb_node);
>=20


--IrdhYIYpCryU9XeunpYogybaV2EIS03xn--

--BlZbf4usivLdoZ14aQrexWqOdrcypfUnS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5va14ACgkQwj2R86El
/qg23AgAgUpUK2qQkvIlHh6bIs1u9vwMGPfBvvhVVW9EATLzk+6AunP5c0zrjBSc
J/IA2EUmUxK0WSshETRU8/IPe75u4Jlp6RyMZ5WpUBUPxYC1i5J2tgKUTFYP2T64
r4v+L2snvSofWKoHMya8+KDAxvT3zAcZxmKJNC5mxWsOLGd5QHKjgeGPBvEpbCNW
wwQiKuwHgLpguXE0vSbh1Q1bOooExYZVlNsE282SSHo2fqKFPaaqPkl3DHJSjA1q
cK53PoCTXBc+GqC8SYN09eDxWaWYObv/wVbZHDozjcUXswmXZKSXzOMaXeT/WBoo
DxT60nA4eQikxxdJmT4Q01Eg3VyNjw==
=jEIG
-----END PGP SIGNATURE-----

--BlZbf4usivLdoZ14aQrexWqOdrcypfUnS--
