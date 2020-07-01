Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5932116BF
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 01:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgGAXpN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jul 2020 19:45:13 -0400
Received: from mout.gmx.net ([212.227.15.18]:51355 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbgGAXpM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Jul 2020 19:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593647110;
        bh=WOKzrZHIZYuffTZQtDMyD/khYn+6coPSQlJd8a6MsKw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Pl31ZW6Y9VwKt5E+KazJ4vUGrQylgs3P6w9dM6iEa3htLQDg278rOd/Y8a+IBE72b
         xQTuV87YFISS/IbaAVIn2UNiX7R03uM8Hrx94HSXVhysQGLMVOin4F+8mVT5QLRUmp
         0N4JBEbIDHQb0siYdv4wmqiwjURCcu+Xk/DVQr54=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MgesQ-1jA3D73PLw-00h4EN; Thu, 02
 Jul 2020 01:45:10 +0200
Subject: Re: first mount(s) after unclean shutdown always fail
To:     Marc Lehmann <schmorp@schmorp.de>
Cc:     linux-btrfs@vger.kernel.org
References: <20200701005116.GA5478@schmorp.de>
 <36fcfc97-ce4c-cce8-ee96-b723a1b68ec7@gmx.com>
 <20200701201419.GB1889@schmorp.de>
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
Message-ID: <cc42d4dc-b46f-7868-6a05-187949136eae@gmx.com>
Date:   Thu, 2 Jul 2020 07:45:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200701201419.GB1889@schmorp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UCYLxUsciswtzBKCkpV4ez3uGHPMoS18e"
X-Provags-ID: V03:K1:p5Kckyg3+sMjvYxOgBmUMgfcMDCZva/JyJzxFXpGgf7JMUVESU8
 Nv8hdcKIbYIkLkz6P0l/aa4IhmpSUS2N4jfPwKwCRBcZw9G4bwLg79p3N8L5Dbcwh+EyyIs
 0Q4pFnXS+Wq4yN5fGc+qCNXNtlkdGBw7eBfW5rUwCmTDmIpUvY2kZBO7I175KbdEY5+frim
 Cl2XkwT2ZR7Xum48hfRTQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Oyzd9ZOAgE0=:mgJ2Mc+RAlIIIYJjzr4aI+
 QWqdYYJ8Fh5/nc+01PSKUraD6VhaAdNo0WQ7tFN0iwdzxoZornUiKR87NlCVzFZ/Gwpzjbluq
 78fXIZK/EMR1rPQrIdrJnMsvwdw1jDvVlaQdyZ9lPi6rzjGZPCFasZ2it/pg0FnthV8RBc3w4
 97WM1OYa1B/bmHv8inqoO1KrR3OfA9NfRfO0Dg5mZ/BxKSZHIcChv/rxXQkofk70W361Ajib5
 L2eA3LnFVtCXDsDth4XbWQqdD1hxhezaC/8hkQcDPLb5VRRZVyKA46cGZyPmhBlsvIdxTErQD
 0eaY5nVx9uMtxBVbfgjh8MB4y1H79Ymx7yzVAABZzw8utPrgJsUMeyL7nCoRQbwJr3PNaeSov
 bXTP/kZQ/CyFlrcMGDdDaftkhqfojg0gZpmxyXaXmIUnCiDj6QV8fz0hjdyoNXhoSXkwFXvw2
 J0JOR0erK8a7ASSPoKS5q0si4XinmhLrzSH4umAjtQbbDC8pgywk7WOyiDo0QGGK4ESvyAn8i
 hBrf9qGlmMhAH2Ndw1zJiEQzX6auSo/Ev31NbrbWhTdBcaXjeEI83yKBKpth/aNawNQs2x5dt
 ZVt4ILtd4NOTnvnQv/hQH5mX18jIo2Q/2ztp7AJ4vaKtwiByU2F+TlFmpOWcsN1pEeQu9EpwF
 a4HDpa/7t4TWOKDRXOrPnfn0Bo/PF+WfM4cZ/2nzxC/l1FK01ksGpWBhpFe1c9j1UJRDY5fM8
 /OyPdN0evCy2fsfRn5rcow/awct9kpJQcGj2pf4FZCE/yhkIwUkaOTUUOAXOfmmcxaE8996OK
 DktKlZPdcm1yIwZ7FKPUJp0XxAfuBMjrbHT0TI/ZWE/s8GDgs0FLF0Y1nqkVITx1CKEfBGdFn
 8CsbnVsvLoUa0qpdHVrufEYI8/pw/9JLjT45L7u6gMeyq4p3bJohe2fpnqyMtOMKASRLGWXg0
 r/iC+x7Rvn/3/SK7FF6luyivGSE7X9EkUewGE9wq4ZuUG90SxajUgXE/ICyQKGJC29c+AUG4V
 IpQBGAmJBQrNnxXahOtcXGe/IwEbzeRnSDJIZe0mn19ALGtLKjBDQVlJMthFmVUOdThfYdidf
 kNyjYbvg2m5KX0qW+EmS5m2UWbjIc1IRmWLKd3j7QttvC3F10+yfUUbcYfsxE7qCILdZGcvwd
 2Rhrqgw7rvL3rWEGLlHldSUNpG2w8B4mjWj3s+iH6V6H4F2rTjCo6n5BdNtrNOtcP/UadB4G9
 /M+pq4JEdiXPo0z3E
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UCYLxUsciswtzBKCkpV4ez3uGHPMoS18e
Content-Type: multipart/mixed; boundary="SHOKaGoLkZ8s2gn1OSzSEgYvHEtp8Wdzf"

--SHOKaGoLkZ8s2gn1OSzSEgYvHEtp8Wdzf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/2 =E4=B8=8A=E5=8D=884:14, Marc Lehmann wrote:
> On Wed, Jul 01, 2020 at 09:30:25AM +0800, Qu Wenruo <quwenruo.btrfs@gmx=
=2Ecom> wrote:
>> This looks like an old fs with some bad accounting numbers.
>=20
> Yeah, but it's not.
>=20
>> Have you tried btrfs rescue fix-device-size?
>=20
> Why would I want to try this?
>=20

Read the man page of "btrfs-rescue".


--SHOKaGoLkZ8s2gn1OSzSEgYvHEtp8Wdzf--

--UCYLxUsciswtzBKCkpV4ez3uGHPMoS18e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl79IAMACgkQwj2R86El
/qg45Qf/acfrSuuwVxjxerH+6IWiCBtkWE5vE+oZGEWUwRntrTm/QApeAqu8fD5t
6I9L2NZhjKAZVEn6pgRIMf1Xnc9u3XWc6skF3rCzEpXxcbodjiSoycdPBLLuyaGs
vQVbwlVI/cc2ei3Ufp4H2F83tU71wfHlIYip2dWIItVHU/6xHVARDuJgjAct3U7k
+W3l7+N95Zt9IZSluZKAdk67lMzvMvUHU5MMjl+ZEBvdnH0iosKTKMUG1lWZYoPe
z4RcPr0wL/rD6BOtFaOYNCMFocXZGcTsyVl/ZyDcAkxqZKWrkobv7LA8llhOGbGa
Risj00xTs60hzVSOfijairAWf/yQKA==
=eU7u
-----END PGP SIGNATURE-----

--UCYLxUsciswtzBKCkpV4ez3uGHPMoS18e--
