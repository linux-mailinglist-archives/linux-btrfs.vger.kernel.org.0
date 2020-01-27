Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90212149E53
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2020 03:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgA0Cu2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Jan 2020 21:50:28 -0500
Received: from mout.gmx.net ([212.227.17.22]:52151 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbgA0Cu2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Jan 2020 21:50:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580093420;
        bh=b32NA1PRZp1iofPiFgitA1ap0gSZjMtUVh6yzjAiuWs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=k6oJ1N54F0IjtFp9M3e1buFeqQLlwIY04z5RK4leEcjssa6/kMkRH//eBayyhEZT8
         mfUwNu+KG2yptlin6UY+5LrDaYNts3V2LtZQExjWVY5O1+Ch4/Q1vUyL9AX9oAo8eC
         ekiQM82kkhLMTu5SuX0y03vtFfCxXMPkMbu1BNIo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MryXN-1jQ4A22uOL-00o1fj; Mon, 27
 Jan 2020 03:50:20 +0100
Subject: Re: [PATCH 5/5] VERSION: bump version
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200127024954.16916-1-marcos.souza.org@gmail.com>
 <20200127024954.16916-5-marcos.souza.org@gmail.com>
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
Message-ID: <7987441f-c3a0-0d41-45c0-94ebdc17d70a@gmx.com>
Date:   Mon, 27 Jan 2020 10:50:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200127024954.16916-5-marcos.souza.org@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="D79hFQJTMvwX5ZbaItiGxvbaTuuzpsbAD"
X-Provags-ID: V03:K1:Il9KIIg4e9usl0PgxrXRxppbzlnRQD2n6JLIxZ5AAVpfziy/I3G
 TZoC67OgFbSEncO79m2j3HTHPUqqvAUKeeYD2KAOqNS9PCmTE6KDLoXz0qcAj0TexxON4DI
 ySLOclJNGK1aUh6TBwv0eZRgT37JJGRem01is5iUXXB5+B0UeK2/7i7z4X0skssyJYf8utP
 GN45Rbe+Uq1zbMZhavWGQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rm05IXscidU=:sUh76JLWvfBc9xI3ifHPNH
 wXVZWQYCy1tgieHlFmBAY0TBu/yAmuV1BtP6x9B/WjgCyrjGxpWeHWkLe0jYi1Y2zxe8Co+6J
 HgoYQRhX8TRwLLG1iG5mJLjZl6h6Dc8UL//qUQkKTPfegT9xXjeC4YQDKApkZiQAwUybA9CG8
 iClb94spT8nJJzaBxm3pAxpWZmLHoBcawzonfzwflfvgllIO7xwkM3MTJS/odg2lO+9H5dk+O
 zjHIV3rb2Dhy+o3n6jeUC5OXLs777EYzSl6q/6i7szy9lO3x22AULkfE3tEA3FT0DaYVOB2Sc
 1zCnScgLK3CrLTlpC0vkGLKVZZd/y0w8CsW3yHwGoQZbTpy05I5s1uiSnOOBFaSKXbMr7elur
 qk/ifEMA2VZ0zvNK4rWV/MnpRUar3/4zsjK80xFUk0aqSwwct5KbgTMbeypgdOS/wqKILd4wn
 foEjoMUs2pyW6X4kzR+GlGps5002nG6tEtin7fqu3vfQnxRgEJNkbEwlBabC5sV/Vi5dNIzoW
 Z/5Dh8W1ji4dYAPpcyhG1Iaw62Ot/Pj0OOnizrGxlw2+/0evWCEVh2op/AzQS4PN9VuTtIVwI
 Q58iT1TeBoA+q9uoOlfGlPvKkxdiYGCbLTD8vdrqbogi96KpBdO7SLRxo+JNqbf8RCLdNXXtj
 V7JwrVPTIPuw12RQvym2d+/6E72+moSn+1R1FaiTC3PCzraGOmHN24+w5CInPtOWr7NYq23kK
 bxLcIBMmQ/BhTVqT1g6X743ixq9FjlbMR1qGpmL15xK/8jLrBmu5ydJiZjYas3Ik/vJNyMDa4
 BbSgV69Bn6irjvdFGNUIadyFpN1I02xnPXWTV88Xl5uZlPOxBbQeXanZofgGGj4fv1LTgJgWE
 v57sv+rWsC6xWlrYHNX6khqLygIdxnVuKsluEsqLxny9EeYy+SfrSH4MVc9piDbIHAQlPD3MY
 WoRlH7lIxbOjFN0NydwCkj7UfBy6GO2BsLY6aQDECgnlFHM67rBaGemYYR/Yai5nnTGb0899d
 cN06VEHufFVq3nwMzA5aBYoCZg0aCXkVvMEwcRX2GO5bpL7eaemQGERz1wSV1Vf64scxBBQEx
 eIFCwXNcjepttMHpu/jxe2EBCn0PPyZ1z4vUekairlEMIuZUz3J3h703T4NidANNxspoJTgFi
 2mTvkqiCtxgN8fkcKXepUOrRF7oXck5KmosbT7XP7Ycdbw3pKt4FCMHnn4s06E1tgAMVyDSUn
 cgxeDo8KB/p0U3KNf
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D79hFQJTMvwX5ZbaItiGxvbaTuuzpsbAD
Content-Type: multipart/mixed; boundary="cYHzbwdyKCu0GILJtb7NrfYaPZNk1RhBT"

--cYHzbwdyKCu0GILJtb7NrfYaPZNk1RhBT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/27 =E4=B8=8A=E5=8D=8810:49, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
>=20
> As a new symbol was created, bump the library version.
>=20
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

That's David's work. Please leave the honor work for David.

Thanks,
Qu

> ---
>  VERSION | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/VERSION b/VERSION
> index cce56663..4ef789b0 100644
> --- a/VERSION
> +++ b/VERSION
> @@ -1 +1 @@
> -v5.4.1
> +v5.5
>=20


--cYHzbwdyKCu0GILJtb7NrfYaPZNk1RhBT--

--D79hFQJTMvwX5ZbaItiGxvbaTuuzpsbAD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4uT+cACgkQwj2R86El
/qjpPQf/Utjtj7BffelubmqSkWDowrUws4y/j1YNSDZtR91PPRu97X4ezYzskWiD
kaNwFQFrCMc6XlEKbP/69g5qZgb+z+D06JWRVPHjrINQkf+aqJAMYDfIw8L9YaQ2
pFmbl3tLgL8p9nemLh7lNOx3VV3VyIP2xd7iyUkRpsXVpgjzXDVxLvy1Ry3+RqOK
ZChGk1f6NlA0h/119bXPnOAenqZTZWKnk65rgBO3jW8kRIKdOrdNhVlI7nK2ioty
lyt6POeCq0hw2oQFGit/oFkAa9oipHaaYRb4QFj/VLnKPZ6IGyNcM0MQcvqDQ5rT
Rlj+zyaXd5OugFpiHZILzVmil1wKAg==
=Uap9
-----END PGP SIGNATURE-----

--D79hFQJTMvwX5ZbaItiGxvbaTuuzpsbAD--
