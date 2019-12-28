Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D02612BD76
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Dec 2019 12:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfL1Li7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Dec 2019 06:38:59 -0500
Received: from mout.gmx.net ([212.227.17.21]:54177 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbfL1Li6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Dec 2019 06:38:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577533134;
        bh=t9A0HwAmWjbURPPW5RDR/hoALuZWf+ehZwgYTjJsz8U=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=FSoVIUCLyhCaGgYN5mt5TQzBzYUoiD64kQ9q7cRhFz8OxMcCX0i7wql6xHVJieDoB
         78ZuS+XzrQMOXKIAgvsfuEORyWRvv17XJljQdEh3lAP6qFTF8C8WTTrlpYOyNDVOCf
         Swil2qKBkFAyEeHXmvAauRZKZtdQSq6EnOoHFqu8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MnakX-1jRtBB4C6X-00jbJr; Sat, 28
 Dec 2019 12:38:53 +0100
Subject: Re: Error during balancing '/': Input/output error
To:     Michael Ruiz <michael@mruiz.dev>, linux-btrfs@vger.kernel.org
References: <4196932.LvFx2qVVIh@archlinux> <5555870.lOV4Wx5bFT@archlinux>
 <f8696732-09f3-315f-3f66-6a318782bbbe@gmx.com> <9620299.nUPlyArG6x@archlinux>
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
Message-ID: <c6a2b628-66b4-6bcb-7af5-48f1edb65522@gmx.com>
Date:   Sat, 28 Dec 2019 19:38:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <9620299.nUPlyArG6x@archlinux>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zlz0zlRtOGMG5w3m6MQtuKE9GtpWJvakQ"
X-Provags-ID: V03:K1:7ig4bWPnz/P60FQoLWYd3CTv9Zmdtf2i5LoedegkHFXQ0Ivn1oU
 g7a88SWrTnnCkcXeLCCgskWtwx9hxj9+HKqX2RaPnpl8SUszOwiDFKrHsmWejrrM00LG/De
 r3eFbRHpfYdILa0cqp7tNuFtODCP9Nh/hZpgIV63mPUbkN3RqucKfZPLU1mjkL91UMahziO
 X5Qh5Vh5XYVtoK6bL/5GQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UYS9vYD4bKQ=:2hC75e3rbtae9CJ99f9zCk
 CMacn7grUIkEB3v4fOWMlT+iZ5tG1uwptHwEQfO2mlw2Pp/wjJb2oOd9ZTTTgDD12G2Z2qc5C
 4wI/krdk07tyToBTFjWH8htMY00RRFZyEue5tIQ6dRPnYhc4DlVvXv5mh0mxXnwJ7+8cVKgwF
 J34lI58nuqFSVhywz0YLhi+7mjJZ+xExCJGpMpOrmx3T5dHe8oy+BMQsstKMTPc2e59usVQm0
 WuwFwjKAxFPK75Zeqkmlkcj3s2GBBtVeqjPmCtYWviPy7pfGDDpDaYgj5PWUxo+0MGg5Tis5s
 /YrFZp+0motzjh1BocSTj88KndNQzG9nx4y8AeF6g5VrzuHHkrUir+/d/Vue3L55DALHuLhgO
 g/+extas2M2mX9UnlPIJvSsxpjeD0no62Y4e7unp1e9EiH8wotdv+GxrygprnPj6IhgAN3Fg/
 bbu00eIALYJeeKbk1lM0ACVVyJDoYUv/Eq/+4kd+4owPKK7wJ/EyF72rR6gISkKZDa8+2O8N+
 1/BJHstQmMwmxw4hxpoUNdEd51MuHrgATm1V/Q7FCDowbJGexmzf5YC+QA6kky6ZeuCT1MeOT
 nWfQpIKW8qg8Su6SHe+93DSoyE5od3qdCuL7LVn3Xi7iHVDXAigTVWRo7GajnzOP4iIXTa4CV
 w3X4LNSPVVoGqIZb9Ly1yYCeL8a26WFazr0X2R5ELJNM9r/nllEAFQoFATugWv6oWLJBnmugV
 oecdOZUKoosa33Ny+3hgvUAdR+mqIE7MTSBHV8ELtzslbOmMnBGojIs03gTb2qDEjop5aPo14
 DbLgUu4RyQvg/s/YjoUrg6tj3CS5ZfhV91EVK180dwmhIHJVA7SzeEA3vKxsHwIf1g1jcQln8
 yX8CPd3MJIds+bFSjBwW0xPODApfARcOVuKkR5n9tmOp9xpD+r3V+JmHMAXbxLqgWnVHSWCoE
 MVvAKHbDgdAV27Acyp3imM8G3ntnI8CxlduHpne2hk4YbviG0T935ZqO2Ii3NqsX8pD24CnVc
 yU4jbWVj0MVGV0sbg1rCiA/d0oDevqTEHfItsQfxOfaK9EZXQoD/cOrzEaNHq377lZOl2bdcP
 aU4djKzfQTeB6Q1Bpw3c98x7zEEExBZguYP44v7L+KrjdJgagJqBRFFF/wVsIEwTMlppiJOOF
 8DGSEMyjs7swwPuu7Rd75yxrmA2d7z81CSHTq9cM3+VobtKEO+Y7ivSbJCFvcFy82B0s2JSSa
 d5OuvTaVnFSDHDaF2jMNI/yuk3kyPU66NJbQfeEspcZDYc2aK5tYRSSZsoGA=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zlz0zlRtOGMG5w3m6MQtuKE9GtpWJvakQ
Content-Type: multipart/mixed; boundary="H3pQxcCqkrvplmmmyl8IwIXXAlSxrAXCO"

--H3pQxcCqkrvplmmmyl8IwIXXAlSxrAXCO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/28 =E4=B8=8B=E5=8D=887:26, Michael Ruiz wrote:
> Hi Qu,
> Thanks for the quick reply. This is what I could find.=20
>=20
> [michael@linux /]$ sudo btrfs ins dump-tree -t data_reloc /dev/dm-1
> btrfs-progs v5.4=20
> data reloc tree key (DATA_RELOC_TREE ROOT_ITEM 2)=20
> leaf 286941609984 items 2 free space 16061 generation 1186381 owner=20
> DATA_RELOC_TREE
> leaf 286941609984 flags 0x1(WRITTEN) backref revision 1
> fs uuid <redacted>
> chunk uuid <redacted>
>         item 0 key (256 INODE_ITEM 0) itemoff 16123 itemsize 160
>                 generation 2 transid 0 size 0 nbytes 16384
>                 block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
>                 sequence 0 flags 0x0(none)
>                 atime 1577186710.0 (2019-12-24 03:25:10)
>                 ctime 1577186710.0 (2019-12-24 03:25:10)
>                 mtime 1577186710.0 (2019-12-24 03:25:10)
>                 otime 1577186710.0 (2019-12-24 03:25:10)
>         item 1 key (256 INODE_REF 256) itemoff 16111 itemsize 12
>                 index 0 namelen 2 name: ..
> total bytes 255307284480
> bytes used 94295339008
> uuid <redacted>
>=20
> [michael@archlinux /]$ sudo btrfs ins logical-resolve 253563502592 /
> //home/michael/.mozilla/firefox/default/storage/default/https++
> +www.pinterest.com/cache/morgue/16/{b696bf53-d26a-48eb-9688-
> ab3c5fd49010}.final
>=20
>=20
>=20
> ``` BTRFS SCRUB ```
> sudo btrfs scrub status /
> UUID:             <redacted>
> Scrub started:    Sat Dec 28 03:17:49 2019
> Status:           finished
> Duration:         0:05:09
> Total to scrub:   87.82GiB
> Rate:             291.04MiB/s
> Error summary:    csum=3D16
>   Corrected:      0
>   Uncorrectable:  16
>   Unverified:     0
> ```
Dmesg please, as that shows which file(s) is involved.

Thanks,
Qu


--H3pQxcCqkrvplmmmyl8IwIXXAlSxrAXCO--

--zlz0zlRtOGMG5w3m6MQtuKE9GtpWJvakQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4HPsgACgkQwj2R86El
/qiBQwf43scUV11D269oYZhvyKKsqjaJWSzEDMUoiUfxQ7oNoU+R2X+q9D5ERWKt
KzUSzLVYVeAfBYqRwghtfoIMwkSchf4dyX6Y2KukLltcD0AVDPcQy0AxyhK1OzTk
W38AQ1pswakobSPfl+Okr7NPoFaUTcnFUb1VQWAveolau1FtMOjjMQHPMGdY/m0v
v+bUkAuc1BSpj3FMNlrsrwBkwUhVQyGmzjbQ045MO4gfzn8ODMJLAPb1azqDV9nj
rXcBJXLTbzAz81knsYtcT1HP9olBrD9XnqZPkvcYGHHA+I+MmbeVKQqYjUQ2Lm3h
3WpwFOW7w3cj8NE/pW31q2sG7qAt
=l7Mv
-----END PGP SIGNATURE-----

--zlz0zlRtOGMG5w3m6MQtuKE9GtpWJvakQ--
