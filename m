Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 027CB115AF4
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Dec 2019 05:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfLGEbi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 23:31:38 -0500
Received: from mout.gmx.net ([212.227.17.22]:36143 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbfLGEbh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Dec 2019 23:31:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575693080;
        bh=6Wx2vKdpCUs7dLpNeQtGzN9RsSBo/Gi827oo02sErd8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=WCIYmBsTrcBaTCsI/pOGL0Q6Fx9HOjgz0Vj3yDmFNp4vx72/0nOqjShazPqY2XNsU
         xKej82iN1kkocuw0nui6AU+qcWOiIg+v7uBcE9StN8Xy31ZqtImblWv0TRkNsaoPzY
         fzSyts/ZFMe6Bqwpi6UU5Bm7fh61OKlDAE7xo0OU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Md6R1-1i3YhR3ff9-00aDN3; Sat, 07
 Dec 2019 05:31:20 +0100
Subject: Re: [PATCH] btrfs-progs: Skip device tree when we failed to read it
To:     Christian Wimmer <telefonchris@icloud.com>,
        Qu WenRuo <wqu@suse.com>
Cc:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20191206034406.40167-1-wqu@suse.com>
 <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
 <762365A0-8BDF-454B-ABA9-AB2F0C958106@icloud.com>
 <94a6d1b2-ae32-5564-22ee-6982e952b100@suse.com>
 <4C0C9689-3ECF-4DF7-9F7E-734B6484AA63@icloud.com>
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
Message-ID: <f7fe057d-adc1-ace5-03b3-0f0e608d68a3@gmx.com>
Date:   Sat, 7 Dec 2019 12:31:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <4C0C9689-3ECF-4DF7-9F7E-734B6484AA63@icloud.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mPouf4pf5NkVDpZx2TV4xIxDEgtmbfkr7"
X-Provags-ID: V03:K1:+ND9W8Woirnfq2ee9gS8rVFRO4ZjFlbL3Wk6vaBDNZEgmnPTxP9
 tXUHtbT/ie2f5zW+FE52qvCGq2rc/ybNUOMgsUBdvyjB7OV+tgdncqzRQrWjkAGC3JiiJcH
 Asw7cm7x8b5Oc53DoceYEcYU+/+UCkP6aeOn0UTpneGc8bMlEjx2gg7hv0mTKt+yHhFnRtX
 AHi/w7yLEudR0Py+Duyyg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9SRKpM0frv8=:71MuGmz9tAtR5QyfVf0WEm
 wsf2KeerxIW6wCmmWpz5SmQGdPoGfl4Z9vk8YA8TOelHQyAF+P4YTTo8WTKwnQnhLC87FkGtW
 mJg7knQps1erL5q9oiak57E0T/z7vqzWDuGmeHusX52vcEaOo3CY3BQyucEegYeHtt/oFmZAQ
 iaA49418NbGk85x9NBdHVSyIrcmB0BKbEz/kMhmQM0Pw8RaCKlSObPIWqzVgt1Vsb6d9u4rl6
 vzP1nnJvzuaxlcmWJ0rXo88JFHSwHysacuNd/1PZ42yWyeSKerdy57qRmqcctBSxoMumve6a7
 WcX9gXub4LFFiNJwRKZ1tvSYSIErS2q8KRxuS288NuPrLyVdCthB4OdIW7o3JfO3fOoMUYA1U
 JHgElVmBTSd8EFdxs8GfAEKAdXUB8kRaIFDm+qB9fOlHy/sTIF8oDbdrvkdeie09+5gah7gv1
 7Vbp/ak8frj3DR0likj1o4hsm6HJF+xKrtFZ6Umcvy5AblJcBTWMR5d6VNGWKDEDbH3rnEgbH
 /osfhjRJxupcnOy6QwxnVJCs3U3CyFt1H0GJSYFojvPCmirRv6/w5rd0wf+M6sRvFsfKQxzMg
 Z6yX8rgRjqNDyZbQr+E4DRut+3IKs6N5ovoF2V5+rhF8iL4lfBV9YOn7aelIF0OH3FiWT3FMe
 vhZ0S7Q4HQIVyngc1a0ewxRU1hPJrpaCyBSqQsjw3ooRMKzTGv9TrPgp+ywvFNHwHe0exxGr9
 aHBaWns1E0U4pAJ2XfufK5K9tW0C9LrXCqS4umQuz1kOB/otuNcKT599zuTGEKv7H0Jkt1guU
 hBlx3oGevUWUSRF0gIaXJvnSQegQVwo7WcA9AYPMGvYryGd0e6eINaF/HcX/PjuH1Pp1WP9+7
 +QDbIt2fIemSqhHOa6BNl3Wp7rJuDBlmXmrqRoYNET/PwLGRigaAExdwQ047FIaBXJ5MYn/0t
 I1NZ1n5gABvXskiYSqryQrNIHkVQN26pZoAXs8Iz8n+MoDqutSIr4J8oiGPwW5CFsa2cYByZC
 SVzzSO7XM3fPzQI46JnkvFEvF70H5A2LInB8Gx0uCsA4EvP1lkWMqREM/3HF9ELb3D7z6EUbx
 VD2RUFf8UUxsWDW/cc8v8VG9uAKW4V9zL5f5vCuLm/TanRqRYh7pC06iHAdGjssPeYzcgG41S
 sxfMdJH6FYeevRF4fYnlQ4GDki8VGGV6MIDmhRJ4yPwY1JKlwDlD0AghSNZQ6vFJAVdMK761P
 ExlkSc/dBPe10CUF9sG5g3Px5jGS9+mIq/aix4WGhGGQYhSDyG39kdD/VEi0=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mPouf4pf5NkVDpZx2TV4xIxDEgtmbfkr7
Content-Type: multipart/mixed; boundary="tqUb97hepEK8KeaH4iUMrZZJjCkdBuDZS"

--tqUb97hepEK8KeaH4iUMrZZJjCkdBuDZS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/7 =E4=B8=8A=E5=8D=8811:47, Christian Wimmer wrote:
> Hi Qu,
>=20
>=20
>> Chunk tree is good, so is root tree and extent tree.
>>
>> You can go btrfs restore without problem. (Of course, need to use
>> patched version)
>>
>> Thanks,
>> Qu
>=20
>=20
> Unfortunately I can not restore the contents:
>=20
> # ./btrfs restore /dev/sdb1 test/
> checksum verify failed on 5349895454720 found 000000A8 wanted 00000000
> checksum verify failed on 5349895454720 found 000000A8 wanted 00000000
> checksum verify failed on 5349895454720 found 000000A8 wanted 00000000
> bad tree block 5349895454720, bytenr mismatch, want=3D5349895454720, ha=
ve=3D14275350892879035392
> WARNING: could not setup device tree, skipping it
> checksum verify failed on 3541835317248 found 00000044 wanted 00000000
> checksum verify failed on 3541835317248 found 00000061 wanted 0000001C
> checksum verify failed on 3541835317248 found 00000061 wanted 0000001C
> bad tree block 3541835317248, bytenr mismatch, want=3D3541835317248, ha=
ve=3D18445340955138505899

This is another tree block corrupted, not the one in device tree.

And unfortunately, it's the fs tree (from your previews reply), and
that's not a good news.

This proved one bad news, there are more corruptions than we thought.

BTW, do you have any subvolumes/snapshots?
Since the corruption is in fs tree, we may have chances for other trees.

You can try "btrfs restore -l <dev>" grab the numbers and pass it to
"btrfs restore -r <number> <dev>" to try to recover other
subvolumes/snapshot.

Thanks,
Qu

> Error searching -5
> #=20
>=20
> What else can I try?
>=20
> Thanks,
>=20
> Chris
>=20
>=20


--tqUb97hepEK8KeaH4iUMrZZJjCkdBuDZS--

--mPouf4pf5NkVDpZx2TV4xIxDEgtmbfkr7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3rKxAACgkQwj2R86El
/qju6AgAoS3+0lZWkB/jdKDoHgwmdjheq5cn4ly4lfSI6Wx7VqVxYT5bh3j0IwPh
mTfGs3PnibrHuD3wwTl7jqDqZWARsLjUW4FNjv0V3YtXYd1pm9tA41ZXtbCPS06M
p1adbJe1YvNB6hQcOvJbxMQo4FgGFBaGqk+lGQ35VA1mMAld0KZFrqc4LOcFuFpq
4pM/fEgwkfS1H7t1LzbJA/alAMmlaEdYdhJfH6DFk7Ub6Sv2Kfpy6qrwmb/BEcyD
Rg2CxqtozEQ3I5RB2aF7s1IRb2OClEFCD34FV+5vfWJ3sog4TrE3RqZkLf3Vt/Tx
E0WI5XszHH0D+s13If1EwBEQrXI9cQ==
=LLPG
-----END PGP SIGNATURE-----

--mPouf4pf5NkVDpZx2TV4xIxDEgtmbfkr7--
