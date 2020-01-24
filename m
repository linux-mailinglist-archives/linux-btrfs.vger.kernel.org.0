Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCD251478FB
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 08:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgAXH2q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 02:28:46 -0500
Received: from mout.gmx.net ([212.227.15.18]:58543 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbgAXH2q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 02:28:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579850919;
        bh=zGel2H6gq885wu5gJp4nA/sBeXdThXNyA/icNOdd654=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=as2HErvvGXMCCBNVsn8n3OpI5UejnIX82IVxx7raQlnHXmlerLQ0DFgfrBow2Al5Y
         XLry6+UVm5FdeSwJsZY9BoDVUayBB1fJ61vp6Owf0eBMD4TKOkLfZ+6JjKe3FVIvMg
         Aor/iBSymxjVyJWJORhBFU6Qstk3bCU8zvoG4fQU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M5fMe-1iwWE83vkg-007DMI; Fri, 24
 Jan 2020 08:28:39 +0100
Subject: Re: [PATCH] btrfs-progs: fix btrfs-qgroup man page as unstable
 feature
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <20200124072521.3462-1-anand.jain@oracle.com>
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
Message-ID: <2a302f48-2acd-d963-0c86-992eccb1fe6a@gmx.com>
Date:   Fri, 24 Jan 2020 15:28:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200124072521.3462-1-anand.jain@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TnHoDD6bPtcQYpfkgfCLtMGnx3hHHEwRt"
X-Provags-ID: V03:K1:sC1PB/wn3fg2kYv0r9r9KDN6agl8kSggxaVzVplxN9nWoRRw6Gl
 VBeWsKBOie4KUqYIem4etjYi5jCkfaoMMVpEbgCXh6jPYAK6nXrPvSjHd1epFA5KH0MM056
 R0aEpmbKWXWOuqpHiFK1lEFdjbFx0yoMVzob9pRBudYAnWUyqsYSTMTex1JwPZMZEhBom7f
 2gO6oLIZlVRuKMIY6j+nA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:okU84ZPyC8E=:BFh/7fyoMgDC/fv8nOmGu+
 v/GVrNhhrRRRoP5gmNfZUBT4ZZV4SqeQMjeVOot6bVv+xZkb78ov2QB+WGQgb/h9run0CvcmG
 +zxNESV+RJeH0X3TmCiro9bUtsfcu58ssALojqLjtT6J1h3dgWU0LVDfd6nPR/Rc4T5mdaOoq
 p1z+BABlTCJnSYuWWDSgZLjoQm84ArgZRZZJnBUWiMfj+n2NJD7PCniSdOcT5EKqwkTMpB2T6
 QTgJDaQAdlBb5vB5bBcQR+dbPQMXRuxKkN93YLESKzE7A8kSg1jPeik7aYy+UCv2OynwjK4gj
 +Cx3RqDrCa0KGztuKdV+EEJmFvk3NOh/t14W9Dm7BnmLUuJTTTy4CpDUwbgswAFC4qZruDVl6
 2TcQmRT4B7YUOr8LVo5saQLvi6DvEV3b+YMC7KLaz4N5YF5/7pKQhuC/UbnLMxGsUBWN0YMIK
 wro9JVTp/chJte4OZu2He76bpfVE28M7ak3N0wJer4Ma8gK+nb3N8z31yZiremdKP8iFIiBmC
 SZhol6t70mZUnmDkC773KXzHxe45geqhd0oBMLXawwStFaNL3YYjrFoUesuCUj6+hSqYwiITp
 lZX6/DZt6GT0okOOulT2zat72n8yvmOPAws2OgqTDAGIIlOHm+UO2tKUselCPwEE9bnCovI+P
 dTb3DXozR6RnfxYMH3eE/VOYz5prl3xaeePW+FJ2Ia4OK/zeorBTT4jXyJ4/rjMt4SWFrolyn
 RvsSKon/SjY46Js4KWAWAxJ8ODnhpY1neG6z8ZzX1WVxIXGO/UQjVCzbG55n19sXxLFA35HH/
 cozwer4kVCSo9J2F++LiuJ5MQUkWL0eMm0wAI5KLc+IgOPl5g4/1aeXCVX7DwXej+gRw+8qgT
 sbPRR+vuIetfEa9rhquxeu7DIK68vwdGBRNQmG/NnldU8CuQBF4iViBsRRTDRk4006kNF6+6C
 q3b42mLKYem13kiBi56kWVo1fFU6TgfInygPrlyitZgqhQFxk2jlEjcJuSZW1VE+FegeCalc8
 G6Gn1wvea5zxLqgpgVlJx1/GeIGfA/ic9TLJ4nAHD1uTAV3hz/lbdq3jLKApUt0gPVYi8QTcZ
 yslENkjED8OSyIvAzog3Neqv30mIi5/8FaKVxAudKkTQj2+DxksQWZJ0NvVpmwCXvpKarGE5Q
 JBoplcOX+8WTFy79OADVbjg1wSelYycJyaAm02FbgylW+KHfZApdl7fkhiKegZV/MRg6EKLer
 Xi9mHEgo1ILvu6aVq
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TnHoDD6bPtcQYpfkgfCLtMGnx3hHHEwRt
Content-Type: multipart/mixed; boundary="Yz0K9OULz3GH2kCLj6uvEnrn3YSD0hLKI"

--Yz0K9OULz3GH2kCLj6uvEnrn3YSD0hLKI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/24 =E4=B8=8B=E5=8D=883:25, Anand Jain wrote:
> There are known performance and counting errors for the quota when qgro=
up is
> enabled.

Counting error is a big problem, please report if you found one not
caused by impersistent qgroup status.

For performance, we still have problem, but that should only be snapshot
dropping.
Balance is no longer a big problem.

Personally I think the current man page still stands.

Thanks,
Qu
>=20
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  Documentation/btrfs-qgroup.asciidoc | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/Documentation/btrfs-qgroup.asciidoc b/Documentation/btrfs-=
qgroup.asciidoc
> index 0c9f5940a1d3..2da3d7819ba6 100644
> --- a/Documentation/btrfs-qgroup.asciidoc
> +++ b/Documentation/btrfs-qgroup.asciidoc
> @@ -16,8 +16,7 @@ DESCRIPTION
>  NOTE: To use qgroup you need to enable quota first using *btrfs quota =
enable*
>  command.
> =20
> -WARNING: Qgroup is not stable yet and will impact performance in curre=
nt mainline
> -kernel (v4.14).
> +WARNING: Qgroup is an unstable feature as of now.
> =20
>  QGROUP
>  ------
>=20


--Yz0K9OULz3GH2kCLj6uvEnrn3YSD0hLKI--

--TnHoDD6bPtcQYpfkgfCLtMGnx3hHHEwRt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4qnKQACgkQwj2R86El
/qiKDAf/QKb0Ae1AgHUfMZgmD/yrVEiMC8gXAvrxZMq5D2eklER4V++vapcssg7Q
qCaaZBFut/7Wn/KIBuBfcp733pnWiE6VNfTAl3PomMacSKbCkttT2Wf0xvBEo8WB
bR4P9oZs6BRR1YgfT2cuT8JlPwy58nmSmMRXLMkDwa30g+GVSdBbMw+VAjhFJIeq
PN+cPaj3FIPJNEJ6ysn8KRfk9hclT5lvGXarhC3zFWpr53hbCoFtRzvT1jOT/0PU
iMje40+AGfj/poiWdkmvJDn/bgNSdvR4CBfC7ZmYnVS1nVpbg5WF7jTKe5j5bU/Z
VF+U+/mVFZ5WQxlBF7HCL4R7OqKLyA==
=g0yW
-----END PGP SIGNATURE-----

--TnHoDD6bPtcQYpfkgfCLtMGnx3hHHEwRt--
