Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD06814AD79
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jan 2020 02:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgA1BXt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jan 2020 20:23:49 -0500
Received: from mout.gmx.net ([212.227.17.21]:36767 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbgA1BXs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jan 2020 20:23:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580174626;
        bh=Yh3bZ0G1BbOXzg7FlsC9zgcbv1yhXymZvoDurOM3fT8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=aq7EXvczNLmC0FZU4zOWilovYgiGGYnwnE5XTgSx3cRk1kcnwqmqaZUMKbxoqzkgZ
         PgMSwRMzU+LJ+4SY7VAk7vwJ8iK0DyHrAyOUhELqdBLqgh11qeilKTiC39UmKFNy7t
         cCwUWxTsL4Lx7qNWnfZiiBxO9kO1djXb/fHCjD3E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5GE1-1jcplM1m0j-011AAm; Tue, 28
 Jan 2020 02:23:46 +0100
Subject: Re: Endless mount and backpointer mismatch
To:     Pepie 34 <pepie34@gmail.com>, linux-btrfs@vger.kernel.org
References: <c541f131-c60b-4957-0f86-3039da69f788@gmail.com>
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
Message-ID: <f7966f07-38e1-f72e-984d-31f46dd2f5ec@gmx.com>
Date:   Tue, 28 Jan 2020 09:23:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <c541f131-c60b-4957-0f86-3039da69f788@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Du019uz41PmJu4y3jbXLURGZVilUMNdzA"
X-Provags-ID: V03:K1:8muAuguFJz5zssCrh2Vr7v05jdy4hH437pbkGuORYjj0ixieFIH
 Ec0597yVfO7FZ+q02WnLpXnWPiELTwBQDEjTm6DV1UKrAUHu2LjXEpi9oSS00Ot+wW5aWS1
 +kgYo8m2g0KVnS4KUEAbVYAeyba75n4r/4XvP/7MaMMEYoWJ9kTrMcsfdb6px0ovoI5XTUX
 VB89HsFt6uXaU6IWVRr0w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6AMYCvo6quE=:taFrAuWeNDGl728h0xmMI7
 hSzafqYqtXCBKpXOiGEsiVhijgpXVFIrKvFVJvmTpYvoDzJOuEX+zRC2b6ErUP/Rbk24zi6A3
 mSelAKVaYEaTzE1HIHcPSDFIX+tDkPpNr/nXKEnChdjJ4GqpAbdAPK4nYQz0XUzbX4/D2TFCL
 B0wC4DihRiwKWMZ7oqfxnJsRrDPcvPlyx0XKhwhf44ZAikCZxmWwdfUWgmt+sCsgjMhkYPJwh
 6N9McOB+mW1Uj3Y7Nn3ZsPcUJ2/1HyXq3KOtXCw4zFc5iuJNwcSMNssiqIgbmDVXmIBZbH6cl
 jh9skpOZbbJXvR4QevmTQG1BS94MlfZ4RG6mvQzHZiSyYBXmcM3l5IoBKRa2dUQShxFAFop3V
 NpDXJ/ErFyptCJGjPdePk9klX+0n/9gprxwDifKxKEM5B4HileOUSWefVTpfaV15lrFUgAoZ4
 5w2los1lj26eHqGqakRM6vhMfrAY2s8oPQEh0qL6OPPczHpmLdcmgK4aLa+97M+X0Iutq+xOu
 +nx2uRmT1m1azHxgyGeX1KQkMFEWlLW4t6kTzkEgPkRVVbt1MtI+on2XrOz5voeMeGcs4qOcH
 /KyCR1Eu6rzhDBbKN/mNguCIB1EX8dS8N9Q5bp+FFmqWJ8U0Ta8cRGlhe3kiC99JnfY5Kd13m
 NQyoyhC8431+NaV6qxnSxRolAOndbS2M+xOSkQiLtVMkadE2Bw4F6nL6z8cIal7ProfB3XPts
 VoLLIXL8Haonkl3TTjt0s4LYDEV0fK1Vebz6Q1jxTzIcWJkFZu1hDcktAY3uyqshg3CQddQua
 lakPQAO5Rrs0Dq5F5hhR5VWx8o9tv2dgXC0JwZ3/D/ylDl/jVt5eWLpRAiRkz76dfGk+mp0EW
 9CZsf6EFwFjX7WjOU2UeH3oGdzttbzD217e+YYoW2Yu4Ukicam69TdondSwjvI2nk1/HKm+tS
 LHYspYfq6SJ2dvJL4PeLPTHkD97QsVyeLIbsDv1tDCsYFJdJuS0z1RKUOSB6rorh2SS0kiOKh
 hpkwkFsf/h3b3y7C29cGJIA8cDRH0Lt2qlckh69NlSkiNcZdAWU+eiSAaTAIid7QgKr1Ebuna
 H6E0b7D09oyL477Ar+ukrTaUm0jCx1UywC5xpE8eyyzeLyPSfwCEt55VKtS6pH5A9v3tMHG5M
 6v37Rkm2PKJaj2DhHt+PY7SNIAqzGvl2/C7eOaNdnySKLbqMuYJp+BALpTmW/A5Kou65SOHvF
 r36Ak6utBTc/PXgJu
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Du019uz41PmJu4y3jbXLURGZVilUMNdzA
Content-Type: multipart/mixed; boundary="KZWnnGjsifmS9sGmWwPMeV1Ig1DX3O41s"

--KZWnnGjsifmS9sGmWwPMeV1Ig1DX3O41s
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/28 =E4=B8=8A=E5=8D=885:20, Pepie 34 wrote:
> Dear BTRFS community,
>=20
> I've a raid 1 setup on two luks encrypted drives for 4 years that serve=
s
> me as btrbk backup target from an other computer.
> There is a lot of ro snaptshots on it.
>=20
> I've mistakenly launched a balance on it which was extremely slow and
> tried to cancelled it.
> After two days of cancelling without results, I decided to power off th=
e
> computer.
>=20
> After the reboot, even with the skip_balance mount option, the mounting=

> is endless, no error in the kernel message and it never mounts.

Is there anything like "relocating block group XXXX flags XXXX" ?

>=20
> What I have done so far:
> - mount the volume with the ro option (fast to mount, data OK).
> - scrub in ro mode, no error found

So data are all OK.
Just need a way to cancel the balance.

> - btrfs check
> In the extent check  there is plenty of errors like this :
> =3D>
> ref mismatch on [9404816285696 32768] extent item 6, found 5
>=20
> incorrect local backref count on 9404816285696 parent 5712684302336
> owner 0 offset 0 found 0 wanted 1 back 0x55f371ee1ad0
> backref disk bytenr does not match extent record, bytenr=3D940481628569=
6,
> ref bytenr=3D0
> backpointer mismatch on [9404816285696 32768]
> <=3D

It could be caused by half-balanced fs.
Need to re-check after we cancel the balance.

> No errors in other checks, though checking "quota groups" is very slow.=


That's caused by the nature of qgroup.

>=20
> What should I do ? btrfs check --repair ?
> btrfs check --init-extent-tree ?
> btrfs --clear-space-cache ?

None of the options should affect data, but none of them are recommened.

Since the problem is about the balance.

Have you tried to mount the fs with RO,skip_balance, then remount it rw?

Thanks,
Qu

>=20
> Will the "init extent tree" option break btrfs receive with old snapsho=
t
> parents ?
>=20
> Best regards,
>=20
> Pepie34
>=20


--KZWnnGjsifmS9sGmWwPMeV1Ig1DX3O41s--

--Du019uz41PmJu4y3jbXLURGZVilUMNdzA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4vjR4ACgkQwj2R86El
/qjpAwf/S8GbahAxRFtm7eT64VUuDwaAESdBQZRUm+Pxiz8Z7MRouEcrzO5DNC7Y
DO9G43vWjKWp3WQZRD8usE0qh9jBqD5XfEl8GSycYvYU5BfIOT9xzlXi0uJ140VD
UdIDgnJkF0twd3okGWHJ9ywyiBEDwVEdtbA5/MUz1NUEcbYuLl6eCw/bJ7Gbbma6
S4JcLWek9M5JpTo8L+CJOEM65BmSkrBDIfuzbakq1TEo0MrJLdCwBeHIhVJubrF8
+S7Zhifi5F9fpIVVfES4UH5jcj59Qr+hOrUhr3oo6989w9Pi2vVqM2qG75KWp2JJ
T4PYWZSvDmBKWb25qtXMR5Mcgoqilw==
=yHS8
-----END PGP SIGNATURE-----

--Du019uz41PmJu4y3jbXLURGZVilUMNdzA--
