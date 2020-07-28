Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43381230AD4
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jul 2020 15:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbgG1NA5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jul 2020 09:00:57 -0400
Received: from mout.gmx.net ([212.227.17.22]:55211 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729431AbgG1NA4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jul 2020 09:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1595941247;
        bh=gLszeCibTiblcGe6WhfLumcSuC2I5TTADba8enLjSJk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=FH8xTcWbXoKEj7jsAE6QgXeJEc0tmoB7aOZPxvSVJIyF+1VgdYcjVGbErlWBu1nEp
         5rb8OvzzDuXaZYzVlBcN4PRqBPDSJzQjqMxWYCSAyZ8qDqN1/RyqO7+81fbYmaTzxS
         aaRFxBD8ogrSBKxqFKa0A7Oax0q1df4vW+BIeuao=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MjjCF-1kTwTF37Zj-00lE5E; Tue, 28
 Jul 2020 15:00:47 +0200
Subject: Re: [PATCH v2] btrfs-progs: Add basic .editorconfig
To:     dsterba@suse.cz, Daniel Xu <dxu@dxuuu.xyz>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200728015715.142747-1-dxu@dxuuu.xyz>
 <20200728113837.GR3703@twin.jikos.cz>
 <0ccb18f3-d4eb-9978-b4b6-157cd7c922f0@gmx.com>
 <0f91c4fa-e9b4-c170-78d8-0e8fe932ccd0@gmx.com>
 <20200728125732.GS3703@twin.jikos.cz>
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
Message-ID: <0b039506-577f-05a1-2109-565e8c5c2a04@gmx.com>
Date:   Tue, 28 Jul 2020 21:00:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728125732.GS3703@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="800biynXSYZtTS0YFd2ThR9SdstyfKEEE"
X-Provags-ID: V03:K1:Y8BlDpOzbbfjpb3XQkYcLw+wUNjZhrVQX+7NLLgdrLN1im40I3S
 Fy+I9TtjJs7aI+naStycmJVTXSap60TWEzRKb//ggt2PTlQaIfQWYsnMn4GUshFPhymarYi
 VV7RM+SrmLhVN7dINWCAdg87d71L5A4vetUke0rW7kfkY+wxqC263kGrjokJZeCNjpxyDIO
 BDKuNGgRgw5SeDLp/JX0g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pwqthcofWZk=:Fw4spnIGbOu17ar00RnqqD
 jntbTRn1mpUJ6eb+dtBDgWIE1gTY0jn46wdDpv6U3hSj5biw2TrWgS+vggfn+BdzsRgOylgyg
 C0Jlan/puuwkZVcAjKZhGz9hmywCWnTrxHjWj9IE5sbtka5kyK0TRYjs3I4O7ga+vMCtIlqBy
 qFCWRs2QQ3UQfvRqdvqp6ZXmntNJA/lkRKE5rseEfC/l8LcZWCdtsZiRfWQS5GOHrW2lxmcje
 EcyXGcuo0OkAmH/+hg7X+HGmo8vQZxaOqXQQwUm8cwPiJkAObfxETGHcmSsRNbVP1Q7/WUvWI
 RSjjHZtQfthFDzDMxlN9uTKXArmVya3vVkQf4puZ7WuB8K4WKlNoc5aq0yiX5LiLDWsiL4s1H
 UvqUr/P/px/4QPRqWeA8sDN+2bEwhnuL2dmBXOQLZYVekP09K6Sag7mjO3TRpI5w24f3+1dHL
 6inLIRdZ2HRGitfINQOIey+4I26pQXjiiDlQ/vkSv+Iky8hqJ5YeF0tANMY1VeET4QojKtn0q
 EmLzo1jcGkkXFvFV69SxJQN7Bf/nEXmEcce2jUMn8z0TH6SioSX1NE54SzAjj8VlL6CiEEt+w
 caWF83Rw4+9jwzk2mJeEukGyu9FukKEjhXsG4XmfJ6BoPYQo8cC3NLlwkNrTzJLrzPXBx1c4o
 af8zhcQgYyD4/b1oh2gsoWghUcxxcd4qPXCFxaxUJ1KuX1g2TOwJs5+W1/solFk2DweqRbw/K
 8RXfVTE2RXfCLZnvx2Uu20cRYrUgcgAunJ0pQj833ntUJTbKbmZXrsHUBK6owextO3BRRVr1E
 qXRdVi+7Yh/ZlWy7/GPE1SMUD/niJEVA/u2yVro/bNahRjryx6QtP/yBB4fU83mSCs1s/UQSw
 LZ1P/V2kZftVIXm/LLXkKIFBkrRP+TuziXcrPaLrgV4eeE+hXNJU0orbNRzoyDpTshxfIVHUT
 riQNdB1ci/iNWT8NbnM/MAgVRYscTNQyKOAjkLZkPVrpyvoXz+jW3T9RRh9QysH+XL3liX48N
 LznxZhrg9sACWhe/q/jfxFuUdZjFbsSNi+D6nyUjficrVESTRHhobsphbTW2LUQURixbUJCj5
 KyVq4Uf2L/d0g5+hduDgWs2rBwsq7D4zAlLD4LLcNiefjC2yXKPOObdZVALx9kZeccxr453py
 kVHqXBkD0dr7ZmB/i+IBY+BufF2Qjuln+gvAD16+peNrdnLCLVwFVdRBInPOdrRMIbf2j4y7+
 MxF6bF5DekJBu6i0JeY9jXFrsIZJdQgX6YLa/Ng==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--800biynXSYZtTS0YFd2ThR9SdstyfKEEE
Content-Type: multipart/mixed; boundary="Is5Vofe1apYUy1lMeOQmkSYGewMujXIKd"

--Is5Vofe1apYUy1lMeOQmkSYGewMujXIKd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/28 =E4=B8=8B=E5=8D=888:57, David Sterba wrote:
> On Tue, Jul 28, 2020 at 08:12:40PM +0800, Qu Wenruo wrote:
>>>>> +trim_trailing_whitespace =3D true
>>>>
>>>> Does this setting apply on lines that get changed or does it affect =
the
>>>> whole file? If it's just for the lines, then it's what we want.
>>>>
>>> At least from the vim plugin code, it's just for the new lines:
>>>
>>> https://github.com/editorconfig/editorconfig-vim/blob/0a3c1d8082e38a5=
ebadcba7bb3a608d88a9ff044/plugin/editorconfig.vim#L494
>>>
>>> It just call the replace on the current line.
>>
>> My bad, %s, it replaces all existing lines...
>=20
> So this would introduce unrelated changes, but it seems that we don't
> have much trailing whitespaces in progs codebase:
>=20
>   $ git grep '\s\+$'
>   btrfs-fragments.c:
>   btrfs-fragments.c:                              black =3D gdImageColo=
rAllocate(im, 0, 0, 0); =20
>   crypto/crc32c.c:/*=20
>   crypto/crc32c.c: *=20
>   crypto/crc32c.c: * Software Foundation; either version 2 of the Licen=
se, or (at your option)=20
>   crypto/crc32c.c: * Steps through buffer one byte at at time, calculat=
es reflected=20
>   crypto/crc32c.c: * Steps through buffer one byte at at time, calculat=
es reflected=20
>   kernel-lib/radix-tree.h: *=20
>   kernel-lib/radix-tree.h: *=20
>   kernel-lib/rbtree.c:            node =3D node->rb_right;=20
>   kernel-lib/rbtree.c:            node =3D node->rb_left;=20
>   kernel-lib/rbtree.h: =20
>=20
> filtering only the sources. So let's keep it in the config.
>=20
Great.

BTW, it would be better to mention we use editorconfig as the unified
formatting config.

As most of us are using vim, which doesn't support editorconfig by
default, thus we need to install that plugin manually.

Thanks,
Qu


--Is5Vofe1apYUy1lMeOQmkSYGewMujXIKd--

--800biynXSYZtTS0YFd2ThR9SdstyfKEEE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8gIXkACgkQwj2R86El
/qhdLwf+IA6AMu8ISlP4yc3hPf+C8cMC8dZkFL9xNOucbgbk9zT/yB0LLdF+4U+Y
x8V+MnId3AUd0ZAB0t33+IoTTdpt8EZAzG3K7D1C0zuwT6H4nLJ5We4g4pZqQUU7
oKNGwzFWcwLtxao7g0+7TRfucb0FHgUSVhZDmoEimkaRHWkaiqB+TII8OMxbgFXE
BDbAYwclxRzHmds4Qq5K5XIhIA+5qk66Uwr7icNDyPmIkMRlyWsTkhgeVJ+ysftR
YG5/IxNmVPQS5f0J5jgJaVE5gfLwWnhpyy+x8idWXEQ1Pzv9b1WDhsaS20Ywdnv0
ucgssY5duVosBc8mYzxZ4YGVa0TjZw==
=atmu
-----END PGP SIGNATURE-----

--800biynXSYZtTS0YFd2ThR9SdstyfKEEE--
