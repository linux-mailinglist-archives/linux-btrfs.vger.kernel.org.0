Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D370FBD77F
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2019 06:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406536AbfIYEyA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Sep 2019 00:54:00 -0400
Received: from mout.gmx.net ([212.227.17.20]:49989 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406354AbfIYEx7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Sep 2019 00:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569387237;
        bh=w4/RNZlqsXeM+glUAm5K4s8g3U+YT40xekr3Gh5t6B0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=guaM2jRfMylO+PoIuNFVie18hqId6F84HIF87vutP/FXbaIdjRZ+1lMh0aZdzJxd1
         mUso4RlR5EfHxwzxrLK+4OO1XWWiYnEDWdak9YcA/pA+ntTnSBzpnTw2awqsqXBAWi
         z1iKsdQE26ZCrEtI/1rCGHwkXNaG0MaA1HAyv7HM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M8QWG-1iHN243soq-004P0S; Wed, 25
 Sep 2019 06:53:57 +0200
Subject: Re: error: invalid convert data profile single
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtS6uHcH3CmM5WpTOGrZ8EFPkFr8Xo92X+Q+VxvBiaW4ug@mail.gmail.com>
 <dd2ed71d-df70-28e2-206d-afd16dad64a6@gmx.com>
 <CAJCQCtQBTPTF2i+e_wKPdX5gC3RiKJs-yqNnrswepkmLMnxMKQ@mail.gmail.com>
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
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <5a454f9f-86c7-834d-0b6a-21b3d7bfa3e0@gmx.com>
Date:   Wed, 25 Sep 2019 12:53:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtQBTPTF2i+e_wKPdX5gC3RiKJs-yqNnrswepkmLMnxMKQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9SMrNFZf70Rxd58HYmtjdA8Xun9sAN3G2"
X-Provags-ID: V03:K1:i1O6AGbHH1oKTO7aOW8l4VFsQ6avTpELCU8swf/2SuD7pRrftll
 fO4SxEQBWolj0n0w9AnOGPVKv6u/JMJdLIsfrJw1yvZYHmJ+ICniDoEMY19IAoB6OA3hoBi
 i9AHyBMS6J9A5ikDa8QTM8ZSpsKtAIVXG+C+3/5xRusRZt2g3CQdTsi5dV1Z3JUm8c+PDoK
 EboYdEU+CsfncXO4a8Swg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:B6IzCqppoks=:FO0ULa8q3MHzJ1soCrxRRH
 ZtFkhd7TL0uD42O0Oh6iK5QnCfK8WrA1BM+cQPtD/ixloniZJexs0WSUHHBDB/i7cB9Q48+Bc
 F67LOqt2u5btRFNQId2HFmswboJ9vQTqKiQUApKCshoP9oFiKacjJhUZupKIxvlTawkDHiSES
 duZEhWDjpc6Elo0CIuypdh8tCnBg3xgovmREDEgE1SaurojqWElBbRxX79ABgFBdwu1lt8KIO
 c/BFxP94V8Qv3s2mJttO7KKu+VMo+YRxLLVARkw81mD95+BHEUJBuRded+T3XZzbbe1dtgpTo
 0PUhJZZEqJ5T4csYKlvnDgtamcBQrgJozQXXhRKz132+XOP07f1AxEFMoWICNgpxU0ckDApJZ
 fI1GzGSJcPUDTKGrO5bNOH5cGjqFgRniMfbMC4Hcz7hE1YIIvGK1ymZBICfAqXwoHSePl6jkI
 QvMd4/GlMRoSJZ8ooRLaKlU6B4qNnTKJRnEIFpMpTpcnxbQzdrQBHlVCrFydVgeL45OnrYinY
 IbWM8w4SupuomAL7lm2H8S+3sCA1VPJ214ir+BTF0KEcVyLb9nhESHayBFJX5Jy10Kvvqm106
 uzAo0Zvk7PyoaRNBkCh2S4NZm4y/BU9AQlyKmfE+f8lzsnQgxg0ctfJ+6mbaO3pQwGs7IsIqg
 HqHM7iAOh1bZmHAyiYg/kYdSiaazNUvXCeFgYOfTvKN6wbP+ZKaVLXf1rJIv33pI10ZhR+nJ5
 212hE7tYBOgfghwNcPFfrE9leU29RVBaLy8Q8Bi6lTT9y4PsFnUAsJ5PGzqMFzdwmz9leBK1J
 AGJYrEG2zV7VlDhwBGw4CoC39wetKuJJOnng8IRK1rdXZ0iu27wUhop67qvjGMTL9pV3HxR/n
 fBJ96xQ32tEKYmGHVhxdi4Z9+cTTEyW5ALwHvjEjGLQBBR2PgqX2Zf3gVPvd1+YKokYlvIjg4
 4THXhALHNaVmqoV0xMkisBAu0CgZzR6ybEx/C4Ji8CIntezM0Ov8Ctv0HcoTbalSe0JmYtaig
 AKVMzOsb698CfBN6pXko8jcXjKewpE+/VRu07+o77Vo6t6Hcc1NHO1qTRS2P8F71Gwu6W+089
 Uoeqe5504puy70p4ysPlRoAwDgdgK2tEyExBhMSQnWND4L8r3rTFmx0rS8TJQgaayoI1VRLiL
 roEBfZXpH+aI9ZgGv7U93RceCddOO0MZe0esy21dh/aBFeaIjqUXCbzomGzeYNlGxAdvX+Tij
 fkz+pfZIFiNhAt/2HU6IqXoQi/6rYrWkHfmtKqQW5vdkr9Ds8q1m0IZPAWmM=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9SMrNFZf70Rxd58HYmtjdA8Xun9sAN3G2
Content-Type: multipart/mixed; boundary="JcFxznhpnek1GfzGIy8oKUOxINmB2Krcz"

--JcFxznhpnek1GfzGIy8oKUOxINmB2Krcz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/25 =E4=B8=8B=E5=8D=8812:15, Chris Murphy wrote:
> $ sudo btrfs balance start -dconvert=3Dsingle,soft /
>=20
> It's definitely a 5.3.0 regression, it works without -f on 5.2.15.
> Super slow. The media should be able to write at 20M/s.

Already pinned down and send the fix (CCed to you)
https://patchwork.kernel.org/patch/11159927/

Will send out a test case soon too.

Thanks,
Qu

>=20
> Total DISK READ :       0.00 B/s | Total DISK WRITE :       0.00 B/s
> Actual DISK READ:       0.00 B/s | Actual DISK WRITE:    1418.15 K/s
>     TID  PRIO  USER     DISK READ  DISK WRITE  SWAPIN     IO>
> COMMAND
>    1138 be/4 root        0.00 B/s    0.00 B/s  0.00 % 99.18 % btrfs
> balance start -dconvert single soft /
>     402 be/4 root        0.00 B/s    0.00 B/s  0.00 %  3.09 %
> [kworker/0:2-events]
>=20
> But anyway, it completed without error.
>=20
>=20
> ---
> Chris Murphy
>=20


--JcFxznhpnek1GfzGIy8oKUOxINmB2Krcz--

--9SMrNFZf70Rxd58HYmtjdA8Xun9sAN3G2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2K8uEACgkQwj2R86El
/qgx5AgAjeSw8Bh52poB4ygHVieMs+/v3E+3wNoKe4WQJr8vWuZ5C3YUtosPkOja
csbn1etc6HlWIKy6qhe2VIG0g+nF6IoDFa1FwezGqBv9nMWarmBeck0gVbPwuTHV
AAECfjUB8H6TCn06+wKsbWWVS5Qa3GFRefIEnZkhtFvgdI4xFNhSE6Bg+Y663MY/
qIaP+mB0tVSDqsGXUkxk1dktfDr976+akFK2aSW7ojJxQJC8m1Fekvw4lgCs60yw
Hn6qjR1bI0UWHJQtUN8yUWbtRk74v8brRjIHSv+FN8UsOVKO45sTqc+Mv1vAsK9L
PvtIazZZPMFY/fHf83faFPMXvjR4Mw==
=KY4U
-----END PGP SIGNATURE-----

--9SMrNFZf70Rxd58HYmtjdA8Xun9sAN3G2--
