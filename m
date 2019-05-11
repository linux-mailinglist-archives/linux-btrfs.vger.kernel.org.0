Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B95D1A7AB
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 May 2019 13:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbfEKLVm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 May 2019 07:21:42 -0400
Received: from mout.gmx.net ([212.227.15.15]:49965 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728518AbfEKLVl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 May 2019 07:21:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557573699;
        bh=kuI0uNgRDdWslsTg9oWqPhiBot/P5okKrrp239lMNp4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=BWGkxF/0JebHWTUbSQ8CvJAA++WRqpGoz0lEv1Alc/OOXfLT/frJziQ7QNZgP+wdi
         Aabyfuwhqf4+gCN5mae1JbiAMWQKN6OFkJjrzBBT1o2q/O8IBpDh/7kWD7KeBxUjhM
         PwbAY/43gQg5FgAARFmmW3rnBIJ3NK4NwKG9lA5s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MIMfW-1hSfjy2OOK-00EQ71; Sat, 11
 May 2019 13:21:39 +0200
Subject: Re: reading/writing btrfs volume regularly freezes system
To:     Nathan Dehnel <ncdehnel@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAEEhgEsQD1WgqZBZ2YEsEZKKH6X6PSxZGKbMgSVrzkEjVVDFrg@mail.gmail.com>
 <9338f259-47a7-11f7-8411-54f777a59487@gmx.com>
 <CAEEhgEstmUEZs_ArDxRd0RoF70N+w0Pk=CSisQSNK-NWhLga=Q@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
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
Message-ID: <f950f86e-e42e-4360-f6bd-0502a7070b91@gmx.com>
Date:   Sat, 11 May 2019 19:21:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAEEhgEstmUEZs_ArDxRd0RoF70N+w0Pk=CSisQSNK-NWhLga=Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ihK2fLlOyfCywytUALyg3OEH9WA0czg4G"
X-Provags-ID: V03:K1:WrhKvwRFqxEXwa+k29/8h7wk5IeHsDVLWPQJd/O2wLYgJdrVIbZ
 lXT7XXJJRGdj1oArtrHYoexuVz7MtL2vQo3ErRnwPv7rNfZreu9ZYL3tdylLnE9pO0dntm/
 dTDch4tMAja2Lp8IhL9x9vULcnqdLNke9eoHGE49+lTxItRggKKc3gONJl+nq7ZUYObxyXr
 KK84QzADV0gFmh/l143+g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0bbYbLqXr8Q=:fO/TGjWTUCelyxQer8c4HB
 VEOveotrHswedayIkGW0oE31WNaIgFeDq3PP21KjjvbDkywKVPAJW5lUwDtJNktUsBpmAaqNH
 +zKAdqFIewQUxW3kRVylgY1Szx86ee8fJx1r3PQIkzBaK34FmuqqWfzn0+ilmYfyvh2zcnhHH
 8GrvrxwUEkJ3FEMv3krdPLfiPcY4e5ktmOmnRq+bUOey4joh/dhama+Zuki4VV7rzpDYyBOlH
 BjrTN4/FJ/dknFaFtKK9jwTv/E8Lhshdl9jbaU54ZmmddjtxAJ98NV9pdT2JySRjJH+BsrIQQ
 fg75twLiFy+Glrg+QT35CH6evvYSPfzOT+VFZP1lZnGBOZcNiW+UdQpkxC2niDAdBExZhaL4G
 USmOwMzBIHwTmvdw6cHLDB+6WSILimB3ycdlW5bZdyHtJyR6RABHDSiWUdxntnUmeaSLRv/ck
 ubJcwWJ0QhMzGYUa+FJxN1nDGs4gkN3SIRDU46HmFFoAEa++xiqB09T1MCCZEEIR19s7j/JRS
 uAi1KfBz1+oMQNvmQAcFWXfMxVaKrKlAsjRkA1toV6/WvP3dEyxL9K6JmKGJUDgwH6JxPsNTL
 s14Ax9JNp+4fiQ47z1dnMoFHRubLG9vpn73tNwJ3LErgg7tOpyLiff5ZqulcHDFJ8u/MejLk8
 JRs0b353q4QbHF17Mk697AbcoA4+et6Y64OyzRC4qnj/yJqY6EZheF3DbCwzuLYnZROaHHGtr
 mRaH4PugJ3FCGJGvRMfAnbOXYerCy+JepIByUnM23Q1xWfKAfWmnVRfxndTTtVkVndHz0o4QH
 yNup5YG+u9sj+EFh/veAQ/iMqvLLm6vyCrNtVI48ZP9Xz6VntiXCVJTmI01ht+bBwjqKYsWgG
 Z2GPssLQhbOPUwyoygulg2UOnFseYUC+CuZokO8GAJftbvTXBHaxZBTA7nLwJI
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ihK2fLlOyfCywytUALyg3OEH9WA0czg4G
Content-Type: multipart/mixed; boundary="61i0xYNpRGU80k7eHYdhIQq4TtfStndsU";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Nathan Dehnel <ncdehnel@gmail.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <f950f86e-e42e-4360-f6bd-0502a7070b91@gmx.com>
Subject: Re: reading/writing btrfs volume regularly freezes system
References: <CAEEhgEsQD1WgqZBZ2YEsEZKKH6X6PSxZGKbMgSVrzkEjVVDFrg@mail.gmail.com>
 <9338f259-47a7-11f7-8411-54f777a59487@gmx.com>
 <CAEEhgEstmUEZs_ArDxRd0RoF70N+w0Pk=CSisQSNK-NWhLga=Q@mail.gmail.com>
In-Reply-To: <CAEEhgEstmUEZs_ArDxRd0RoF70N+w0Pk=CSisQSNK-NWhLga=Q@mail.gmail.com>

--61i0xYNpRGU80k7eHYdhIQq4TtfStndsU
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable


> [362108.291969]  btrfs_tree_read_lock+0xbb/0xf1
> [362108.291973]  ? wait_woken+0x6d/0x6d
> [362108.291978]  find_parent_nodes+0x91d/0x12b8
> [362108.291985]  ? btrfs_find_all_roots_safe+0x9c/0x107
> [362108.291988]  btrfs_find_all_roots_safe+0x9c/0x107
> [362108.291992]  btrfs_find_all_roots+0x57/0x75
> [362108.291997]  btrfs_qgroup_trace_extent_post+0x37/0x7c

It's qgroup.

We have upstream fix for it, 38e3eebff643 ("btrfs: honor
path->skip_locking in backref code").
It's supported to be backported for all kernels after v4.14.
But I'm not sure if it's backported for your kernel.

As you're gentoo user, it shouldn't be hard to check the kernel source
to find if the fix is backported.
If not, feel free to backport for your kernel.

Thanks,
Qu


> [362108.292002]  btrfs_add_delayed_tree_ref+0x305/0x32b


--61i0xYNpRGU80k7eHYdhIQq4TtfStndsU--

--ihK2fLlOyfCywytUALyg3OEH9WA0czg4G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlzWsD4ACgkQwj2R86El
/qhxnAf+Lp1HP+5cZu1jmFawoy6d2THgtYid28eoMTUuGVT6vNIqyMyExr1sXOKb
41j4n2Cmrvi+c5gNer+1Muli0sPWmuMWmoJQi0Mm8R6EbquTBTW8I8zuWzeegl0F
JcJv8xrrQ+NoIa7/iwKTP1Lm/OD4Pk+26DPnLk/20a+Il0NQ8nkNNHwpddTmmoj4
OAkWjV5zZ4irWgnJ6N7idWQT8uaDpALw3NtL7n1zFJ8soZSxizisZP5OFnECus9b
GqOnaulPpTl/tXMkctAibji04GutIb3yioGJQLopWaFbDiqhX3ldAsBGmbs8wutq
TkvoAiX2WPuWypexB0hSXtKzO1ZdKQ==
=Fnk5
-----END PGP SIGNATURE-----

--ihK2fLlOyfCywytUALyg3OEH9WA0czg4G--
