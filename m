Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25B90141559
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Jan 2020 02:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbgARBIn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 20:08:43 -0500
Received: from mout.gmx.net ([212.227.17.20]:56543 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbgARBIm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 20:08:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579309717;
        bh=uTEUDQF2IEP6ZXPx5RUyL5ueVn3jU55agzBp2WtTSUk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Fi4m8f6JSFtVtyDlso1FF8dVvvd9bKAgQZsNeZMX1d6ey7aoX3Jn9BhsjWl5HrcEI
         OlAtiR6shmsMJnhB7TJEXIb8rk9pAyv5GxNKjPe+B2b8WgXtsqUrrCGT8777p4pBlO
         3SmUTJ89i3jg85FeXuaQmxOPwX9tIeuqUtSgBOLQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mqs0X-1jNqkv1oav-00mtuM; Sat, 18
 Jan 2020 02:08:37 +0100
Subject: Re: [PATCH 0/3] btrfs-progs: Do proper extent item generation repair
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200117072959.27929-1-wqu@suse.com>
 <4205b62a-e72f-6b6e-b112-83588462675a@toxicpanda.com>
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
Message-ID: <6414387b-b2ee-a2a8-6620-cc97fd19b722@gmx.com>
Date:   Sat, 18 Jan 2020 09:08:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <4205b62a-e72f-6b6e-b112-83588462675a@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2cPkjgYpOnta8MwyVoE13EKAhhnNZQfmQ"
X-Provags-ID: V03:K1:Z0zFl2U5NHA2QLOP0s0dPwgwi3uwLdvGktcr82ud3hPAap9ODEG
 NVK1BvtkscYe7OOxwTAEHU3IP+zedsCyQT/CitCFa3ZRwREd1lmO4756iNlkcEr272gl6g1
 KTh9Y+Xu0sOXitPXHDp95lAiYTPITcZKivP7CghaTuvD/9XBpnKM8ZL/HyzS8WBZMc88B9O
 uJvftwk27zLoP7JP2CZ1A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:d1BoorPYySM=:wQO9Y0HsNX8OYacmja4eV4
 ql/hpTbpix9uZE90POwCK0CYLu+yNeaQ8iYCwg9ps1nRqSsUGRpSs3AYcuJ3QyQsEa/rKWdDa
 I2vQT33RayJoPlM0fsUzW+WSNjnSktAOZIpT6Kj6pCAweFqY4xlKXmFcD0mWfWPQ9bDztTQOK
 fyUnbjcHAlRrcro5RmLj9hDHAfhcvKO+MNcO0+XtP7383oU1J/D4ncOam7ZOqzUtC35Mym8by
 0uZh9m+CzuC0VpQzdIQk44Ghl+XFjUDSk415D9aZJ7YCJPXRvj+GVCwqgZ7Xtxh0jlk2Xx7Ds
 byY7Z8ZKzwMvQ1bHF/AMJT7ck2YMlSUhe3n3C0/ZfveMe+vK5vA98zdjNgGJL2Ut4rwko2gmn
 KbU4QRh5x2hVlObxnFFMzo9LLvLKQftctQjTVs9Ozy/HAqrtQ33v3wJsm6RGvNnW34UM0i2AX
 Pd20dJkQ+0MT3lyPN+Sk6gfrh8Pjwu2aNVcc63TPCkMiUc9IZn3vUEDk39W7UFKS5o3VZ435D
 lPO65wyy4XrEMRrOC9nihiTHjCOz8FJu/rZcPfHYkVcJUIddHxoWzB3HAwTTWLoRvYbZsNMiq
 bygRjeOc9ff5R2B+o6fdunFiGTMfQtiTgAWvK8w27Gl3qzGkRuWeFWf+YF36GDl9PaaT4/u6C
 C+nw/SX9l8nByr+h4Zgi6l/xlMDizacyAiulot3slqTYWsYV4rezkswq5XSgrU3z2XaEzXzHx
 j//IFp1GCVtkGCVtxg+OJKpvuG9TgAoGfLCliJ+2+hKK88fA/A5KgWSlGTyWdVdLjqO12ezyY
 irHxoCexzuGpEiloBQiSFRN1kUNZiosB8c99dRWjkNkFIfIYA8fWz5a1mAyfFoEnGdvsr/3dK
 hrXUoZGI9hIkyeiNcoJ1opEDOKoE3fePwhcYDsfSWVZXkYvRTY5Yv7YDmTpNK6xab6i6HqJVZ
 IjEGNiAoPcaDaZ3q6wOtSS7BxwRjZ/VMwWTQz/rqaMW9Wg/axT9BFYjwCKUPY94lbPPeChprS
 i23LDxBoiWxzAfxAFw3Q+Nri6ISTNQr4JEpgozW7fWK/no6nAaqRY/hfKFCcms+hAOQC9banO
 ey49/eQuOOrq1e0EcqKQtZWuEQ0J2pUAzyowbMb6rqEtvzTXoEfIeo2cVK/4879ZSyXn4vK3S
 ZSpH8QOPgSO1mICDXs8Tqah091iFm6HImq17PWQWpkkIerBAu68Yt5fwIaB5FeoKrwu6s9zA9
 7imt8Cq8rchvJw2EkkSsQhs84JOVrOFUFfoFY84ilfi4qW624a/SLRtP+uFw=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2cPkjgYpOnta8MwyVoE13EKAhhnNZQfmQ
Content-Type: multipart/mixed; boundary="Id5oqmtGEcFuX3jgNmY6h3EeHnJEhRuYO"

--Id5oqmtGEcFuX3jgNmY6h3EeHnJEhRuYO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/17 =E4=B8=8B=E5=8D=8810:28, Josef Bacik wrote:
> On 1/17/20 2:29 AM, Qu Wenruo wrote:
>> Before this patchset, the only way to repair invalid extent item
>> generation is to use --init-extent-tree, which is really a bad idea.
>>
>> To rebuild the whole extent tree just for one corrupted extent item?
>> I must be insane at that time.
>>
>> This patch introduces the proper extent item generation repair
>> functionality for both mode, and alter existing test case to also test=

>> repair.
>>
>> Qu Wenruo (3):
>> =C2=A0=C2=A0 btrfs-progs: check/lowmem: Repair invalid extent item gen=
eration
>> =C2=A0=C2=A0 btrfs-progs: check/original: Repair extent item generatio=
n
>> =C2=A0=C2=A0 btrfs-progs: tests/fsck-044: Enable repair test for inval=
id extent
>> =C2=A0=C2=A0=C2=A0=C2=A0 item generation
>>
>> =C2=A0 check/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 66 +++++++++++++++++
>> =C2=A0 check/mode-lowmem.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 74 +++++++++++++++++++
>> =C2=A0 .../.lowmem_repairable=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 0
>> =C2=A0 .../test.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 19 -----
>> =C2=A0 4 files changed, 140 insertions(+), 19 deletions(-)
>> =C2=A0 create mode 100644
>> tests/fsck-tests/044-invalid-extent-item-generation/.lowmem_repairable=

>> =C2=A0 delete mode 100755
>> tests/fsck-tests/044-invalid-extent-item-generation/test.sh
>>
>=20
> If we have a generation > super generation that means that block is fro=
m
> the future and we shouldn't trust anything in it right?

=46rom current report, it's mostly caused by:
- A bug around 2014
- Memory corruption

For the later case, as long as it's the only bug, it's easy to fix.
For the former case, although we don't have a concrete cause, it doesn't
seem to cause tons of similar problems.

Either way, from current reports they can be fixed, so I think it's
kinda OK to do such simple fix instead of always go slow --init-extent-tr=
ee.

Thanks,
Qu

>=C2=A0 I haven't
> touched this code in a while, but that just meant we threw it away and
> any extent references that were in that block were just re-created.=C2=A0=
 Is
> that not what's happening now? This seems like a bad way to go about
> fixing this particular problem.=C2=A0 Thanks,
>=20
> Josef


--Id5oqmtGEcFuX3jgNmY6h3EeHnJEhRuYO--

--2cPkjgYpOnta8MwyVoE13EKAhhnNZQfmQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4iWpEACgkQwj2R86El
/qiPcgf9H+ITsKDsI0BK48S3rBzizg3MCkxqg/Hr4onSkg90L4AZpZ3O2I/dx0Q5
A8qgehfBT+ovXxHsMeZayMczM1i7GXvFLc2TbYVX/YnbunTDYJZ8SE0YFDT0N+EA
xuugUNYzix8/JIwJ+16DBziZdrX6BQw1inAGLqXrpVrBWTLE4PwUrjmR6OwFf3d5
Zuv+gu3PqX1j86eazXvBx84O++Ig/kim1tOORKQTQu6fniyHr3GI/skcRKEkAoi9
pF6Ao8MNfCqZBlOSr11Apo26wUvuPA35v5Okn1YBlL3Q6+LGuRU2BbfYI1Rknkwi
5RvLfGQcYoukqE62azi+RQ9a3rz+ng==
=jf5p
-----END PGP SIGNATURE-----

--2cPkjgYpOnta8MwyVoE13EKAhhnNZQfmQ--
