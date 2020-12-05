Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5C22CF91A
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Dec 2020 03:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgLEC5L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Dec 2020 21:57:11 -0500
Received: from mout.gmx.net ([212.227.17.22]:55871 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgLEC5L (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 4 Dec 2020 21:57:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607136936;
        bh=MB/mcW0rWiKZ1MktW+tptKi/5XGJoGblfBt301xEC6M=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=kGIAg8xqn8tD+qSOiiefddhkij/Uqsnhm2owa1wBqCHeH3NBxv+XUsnyp7Gn3Q3FT
         APq10sPJ8rwRuckuhDrGhbiANzwJebBDfgDHcIHeZjvHgF3B3tnbqBimnc2kMj/9va
         1yn/lOTX+N90fyGJ7aunxK4pt09NQIVcDrsq8lpE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MKsj7-1kStXm465V-00LC26; Sat, 05
 Dec 2020 03:55:36 +0100
Subject: Re: [PATCH] btrfs: qgroup: don't try to wait flushing if we're
 already holding a transaction
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201204012448.26546-1-wqu@suse.com>
 <20201204172853.GX6430@twin.jikos.cz>
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
Message-ID: <c210ee6e-113a-f3da-b075-d8f2a8802ca0@gmx.com>
Date:   Sat, 5 Dec 2020 10:55:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201204172853.GX6430@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WLMZ0ELmePdc7Qaec9Ul02Az8XOMWqxUB"
X-Provags-ID: V03:K1:Ngj0xiNE/cFahLFVTjAlcCxjLmOrb1KshtPnUExdNdh9pamAFeO
 flkR8ld1I/C+zOnTgp2Cvr1tCF+2wbq2/WfCX+loefHBnorYZp6gmm34VBzsoQAffl1aVR7
 3PhWQv8FUnbGVOBfU982GfJBoK3dB0vcNJ/UhLx4UfRJKXnYCnRX6m/2D8+DyrGhlRI4G0g
 LfqpRGI5gYE+KygR4OQLw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z0+urlVvvng=:eabXuTaRufLi0glosvYjyC
 uyFnCUta9t7wadTL0gG8qAmNcyrth+wrR28r6bTf81+xbriKBgxBaXImUkA+dtHMl5b+ZuTAp
 d70mFe6bKSB+u+W7gNmu07VYL81oV1SS6JauS0HhcfjvPGKZ4hNCBILSBuwCy4cwrYw5SOeDl
 rqlB+ozjwG0iVDcnMyZG9+J3Hnz7dEVTf0HYoeRJPijPS4hSUcqTmfj2v2fg4RciGGyv5UMYD
 EQQOwI0/lpkPhZjwnq1BWyYXFj+bXT6iHPvPi2TW/K5MKRR/Lz/EKKb9UIqbc+VcT09da2KmB
 55iF4U9gdqS52mzPWL5KCSLcoChSXGrJ5d2+SUWZYHihEgPlzlHNm4v17BVfIwk+x1RidXe6O
 5dY48G1CICDoKpaL10SFNhLC1VEzIRdzcFyHZE9R1ClRmuzY8RO4vAgf5BPZMyExw2nDV/8uZ
 +faSWGhXCw8KjmfVF5KqQe/Ues71qmBe+FYGkAI/M3EUN8zUHHskkqVB2jFtc7ek3LG09OL3g
 1dTayYypCihyKhSDTI8rm/x7fZwT6gt9Ne2qv3cBTlzmRxy5cQWLTgWA6sHM+uZRJg14vTMXF
 yGZ6GNuj9u6RuI0ral/Z8JGBPj3jWsRo74OMjqqG11EjK3uD2qubF5ksRK0rt7JcDVzyCo1mE
 FTkE1CF4oq7988vgvoUDIvzVaA37NYtY1a6wWIfvM0d4EwUjNZsj0hrNBBIPX9jscbE+6fSff
 Ke7Xpl/V6ZfqZlAtQqwY+oqWkovHNiXryR1Nx4MVzQ3te0KJZBzKY6nFTzqwirECmmGwjMRIO
 kBHMTmnzh7RYJ8/sceuZLmKb2Lj/1mKFLcgHIAedwbRTIHoF3i35ArWO9Ym5n3rE0y0vIclYq
 Df/cjixAC0yBIgW8ry7Q==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WLMZ0ELmePdc7Qaec9Ul02Az8XOMWqxUB
Content-Type: multipart/mixed; boundary="6KvS0mg002PywmXogZZz3GbPeen6ycxkG"

--6KvS0mg002PywmXogZZz3GbPeen6ycxkG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/5 =E4=B8=8A=E5=8D=881:28, David Sterba wrote:
> On Fri, Dec 04, 2020 at 09:24:47AM +0800, Qu Wenruo wrote:
>> There is a chance of racing for qgroup flushing which may lead to
>> deadlock:
>>
>> 	Thread A		|	Thread B
>>    (no trans handler hold)	|  (already hold a trans handler)
>> --------------------------------+--------------------------------
>> __btrfs_qgroup_reserve_meta()   | __btrfs_qgroup_reserve_meta()
>> |- try_flush_qgroup()		| |- try_flushing_qgroup()
>>    |- QGROUP_FLUSHING bit set   |    |
>>    |				|    |- test_and_set_bit()
>>    |				|    |- wait_event()
>>    |- btrfs_join_transaction()	|
>>    |- btrfs_commit_transaction()|
>>
>> 			!!! DEAD LOCK !!!
>>
>> Since thread A want to commit transaction, but thread B is hold a
>> transaction handler, blocking the commit.
>> At the same time, thread B is waiting thread A to finish it commit.
>>
>> This is just a hot fix, and would lead to more EDQUOT when we're near
>> the qgroup limit.
>>
>> The root fix would to make all metadata/data reservation to happen
>> without a transaction handler hold.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>=20
> Added to misc-next, thanks.
>=20
Sorry, forgot the fixes tag:

Fixes: c53e9653605d ("btrfs: qgroup: try to flush qgroup space when we
get -EDQUOT")

Mind to add that in the branch?

Thanks,
Qu


--6KvS0mg002PywmXogZZz3GbPeen6ycxkG--

--WLMZ0ELmePdc7Qaec9Ul02Az8XOMWqxUB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/K9qQACgkQwj2R86El
/qh/1Qf/Yk7J5PiYM9zZURzc5cdc/zey1CF1pR4BDhntwTZrhHlhUbWx7DUwWSgs
lvNI9khljFZnhXBajiLf2GHyR7PQIz+nPwr2KYnyd4aemlcC2iBb3DJf/JRV7Vx1
kuFr8MYSaFzOzzTJgCY2FblMBYMPfRWqeSrRxqPM3u3YpJT6m9KggTJop+4fTJ1L
RxpqaAhZQq11F2dP4RX+FKaohjKUlrWCPWcrzBoq8rwg6ufZ6OulUFiZ+7msPAJv
klhBPNgb8PeL/9dXMpzZIGbuTu2BydYSEw6onI9DlUCEV4f5ml/15LbH8KS3n8NR
U5o/isZXmb53hAZCtxmm4GzxR2yVUw==
=qupI
-----END PGP SIGNATURE-----

--WLMZ0ELmePdc7Qaec9Ul02Az8XOMWqxUB--
