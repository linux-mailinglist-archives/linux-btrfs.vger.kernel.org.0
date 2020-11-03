Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877422A5AAD
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 00:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgKCXol (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 18:44:41 -0500
Received: from mout.gmx.net ([212.227.17.20]:55301 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbgKCXol (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Nov 2020 18:44:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604447076;
        bh=y0Q9C5V1u2vJ+6YvKCiJda0KgTqKNKtk3JLujAnuALI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=JIO48dOsZ2hM1vQ60coJMIju/fWavdinFA6tZTWo/LhrBPokabzRAKQoNNeMRm/43
         /mcUmMOHaQYOypE4mlijgwgC1jagxJHUsXxapkstivM0ba0uezAH/om+It6cVKMrgE
         rZcMGgYMGeRrQyFzpVND4OWMsN7aqT3Nvtzotpnw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYeMt-1knTpA2VCV-00Viy2; Wed, 04
 Nov 2020 00:44:36 +0100
Subject: Re: [PATCH] btrfs: reorder extent buffer members for better packing
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20201103211101.4221-1-dsterba@suse.com>
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
Message-ID: <96d4080f-38cd-d49b-ebb1-72de8ae43c34@gmx.com>
Date:   Wed, 4 Nov 2020 07:44:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201103211101.4221-1-dsterba@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LTfABizZBSY5EFVaZ0zJbwnIwB7Rut9EU"
X-Provags-ID: V03:K1:JKXawh9Rd7tixaUUplIuBvxA8CB+7s4qFQ5APUpj2OPB6hXfycs
 XHY4XiS8BilD922l2B9PbnaYQ0F6YHAn/N99bpb9pjIlRToVrUuvCVQLTH1QWwcb3KqubU+
 LpdH6t+TShdVw7Y32RwlzMT5ZPvpKZCVwxBWS0p/XzoJVu3U32EseeJEm6Vi8Ra2c+gQ3l+
 41NN/YjsmM0Oh1X1v3mTA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9U0nUR7bovA=:b7SM0Bbasf73UXu8O0JQAa
 RMFDidlgVYpNOp8MdUg2SUkF6Tcy0Uuh7rPJr5U6OqgbexVCIEhZd36xylXPTtgWFuqVNwyQI
 Pt/iJBe4HYQvnnme4lWFyaj9M+b+ucRq8Bq/9Rjh0Lg2ojfHi8W10Trb0yb8plhNHYoxjk3uo
 t1BQkShexIbPfg8L1/tM42cdzrxBHH1QTJG/SyL69hpmeq/EihcYxP+5GYlztzZtSvThKUQ3U
 ViX9bw4oQwN6Ge7EqIj98I9DRStYflNC1/WuPfR9vCLKRTgx/hw4ydxjvw3w0Eat401sdsRhh
 McVvDRfayV78VzAqLzZXe+FaweAJ476tUEpa1HNDMJP9wG7vK96/LCv0sPxM3aZiNmkP592sF
 7heEUpJR+dF4OtzKqXD+/wSe0GSkB+qbWcfcu/HXnyGGmsFs6O+qyhGyCzQLU73A2lgveYfYp
 ihNQ0H5gZi6h9N9dyiPLqlxPlwbTvV84Nm8XqkP+WinZSgifTG76v7BZsx2yzPB+U714FHjCV
 2/ignHy/HkqvW3KIGVqKHrt5OoeQgFmgyQDVIKhe83ELbj4wH8vTcI6ZcVGijt426jQdDzX1I
 IhnYmSd1qpmtGCahXAaAvHFZ++0cEbveo+02fj2X97hie+mEJ/1yDOkIYPZRUEyuzRNzTRStS
 QM/jACXOKVxy+JyamMOZOPPAO1R6UyZXne6ifmac0w82219hq9J5pHGmMdXTNVIoQGZhE7OUj
 V7VyikYfxeUPi6Sj/9hMbg8DWyC3L2JjC+ox7mA1VZPOZ5OCxHSdGsP2lv3rjsZOhk2KMQQ8e
 tLE8Hdg21iwmsffmMc4ar4dwFOZ4kWd6+xM4ci9Z6oirQH/BGCb8umOOvEQX9enuYV1CyXpv6
 ZcmJOQPGw2TdD5sm+mBQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LTfABizZBSY5EFVaZ0zJbwnIwB7Rut9EU
Content-Type: multipart/mixed; boundary="tkqdsBJ5mnzHCIRtjnG0odRA6ZzB3PFyN"

--tkqdsBJ5mnzHCIRtjnG0odRA6ZzB3PFyN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/11/4 =E4=B8=8A=E5=8D=885:11, David Sterba wrote:
> After the rwsem replaced the tree lock implementation, the extent buffe=
r
> got smaller but leaving some holes behind. By changing log_index type
> and reordering, we can squeeze the size further to 240 bytes, measured =
on
> release config on x86_64. Log_index spans only 3 values and needs to be=

> signed.
>=20
> Before:
>=20
> struct extent_buffer {
>         u64                        start;                /*     0     8=
 */
>         long unsigned int          len;                  /*     8     8=
 */
>         long unsigned int          bflags;               /*    16     8=
 */
>         struct btrfs_fs_info *     fs_info;              /*    24     8=
 */
>         spinlock_t                 refs_lock;            /*    32     4=
 */
>         atomic_t                   refs;                 /*    36     4=
 */
>         atomic_t                   io_pages;             /*    40     4=
 */
>         int                        read_mirror;          /*    44     4=
 */
>         struct callback_head       callback_head __attribute__((__align=
ed__(8))); /*    48    16 */
>         /* --- cacheline 1 boundary (64 bytes) --- */
>         pid_t                      lock_owner;           /*    64     4=
 */
>         bool                       lock_recursed;        /*    68     1=
 */
>=20
>         /* XXX 3 bytes hole, try to pack */
>=20
>         struct rw_semaphore        lock;                 /*    72    40=
 */

An off-topic question, for things like aotmic_t/spinlock_t and
rw_semaphore, wouldn't various DEBUG options change their size?

Do we need to consider such case, by moving them to the end of the
structure, or we only consider production build for pa_hole?

Thanks,
Qu

>         short int                  log_index;            /*   112     2=
 */
>=20
>         /* XXX 6 bytes hole, try to pack */
>=20
>         struct page *              pages[16];            /*   120   128=
 */
>=20
>         /* size: 248, cachelines: 4, members: 14 */
>         /* sum members: 239, holes: 2, sum holes: 9 */
>         /* forced alignments: 1 */
>         /* last cacheline: 56 bytes */
> } __attribute__((__aligned__(8)));
>=20
> After:
>=20
> struct extent_buffer {
>         u64                        start;                /*     0     8=
 */
>         long unsigned int          len;                  /*     8     8=
 */
>         long unsigned int          bflags;               /*    16     8=
 */
>         struct btrfs_fs_info *     fs_info;              /*    24     8=
 */
>         spinlock_t                 refs_lock;            /*    32     4=
 */
>         atomic_t                   refs;                 /*    36     4=
 */
>         atomic_t                   io_pages;             /*    40     4=
 */
>         int                        read_mirror;          /*    44     4=
 */
>         struct callback_head       callback_head __attribute__((__align=
ed__(8))); /*    48    16 */
>         /* --- cacheline 1 boundary (64 bytes) --- */
>         pid_t                      lock_owner;           /*    64     4=
 */
>         bool                       lock_recursed;        /*    68     1=
 */
>         s8                         log_index;            /*    69     1=
 */
>=20
>         /* XXX 2 bytes hole, try to pack */
>=20
>         struct rw_semaphore        lock;                 /*    72    40=
 */
>         struct page *              pages[16];            /*   112   128=
 */
>=20
>         /* size: 240, cachelines: 4, members: 14 */
>         /* sum members: 238, holes: 1, sum holes: 2 */
>         /* forced alignments: 1 */
>         /* last cacheline: 48 bytes */
> } __attribute__((__aligned__(8)));
>=20
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/extent_io.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 5403354de0e1..3c2bf21c54eb 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -88,10 +88,10 @@ struct extent_buffer {
>  	struct rcu_head rcu_head;
>  	pid_t lock_owner;
>  	bool lock_recursed;
> -	struct rw_semaphore lock;
> -
>  	/* >=3D 0 if eb belongs to a log tree, -1 otherwise */
> -	short log_index;
> +	s8 log_index;
> +
> +	struct rw_semaphore lock;
> =20
>  	struct page *pages[INLINE_EXTENT_BUFFER_PAGES];
>  #ifdef CONFIG_BTRFS_DEBUG
>=20


--tkqdsBJ5mnzHCIRtjnG0odRA6ZzB3PFyN--

--LTfABizZBSY5EFVaZ0zJbwnIwB7Rut9EU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+h62EACgkQwj2R86El
/qjc3Qf/RQFRPMAVsB0J22Jy21IWm7P7zC3VlOz1mHg/8l+GTGQEHa1qF/r/Vtz0
DNeVueiODKPXtgT8/D/l0VBbyyPOpi894NjwrNHMhmEikyVMYSyUNoDD7qoXWfoa
ee3yPqPydoNICaVMjsPfzRK21v2Cf9a1ZNv/XcsV7K0RIVcF6eK7R2DaOe4J/imI
8vFK2cwO0E/wljMDfSYCXyVJ5FwvZ+KLxCK4mM0sdZwFGxJjnO2+lDI2rfvnMo7i
SjYDzAFAUI3pmtvIUzrk7qXt4ctoT76ke9FTbSRp3G42rhnMmPtE+wk7DG+UuDQx
35ylwrj8ZVHO/rTH5DFu77CM6onMGA==
=Jis/
-----END PGP SIGNATURE-----

--LTfABizZBSY5EFVaZ0zJbwnIwB7Rut9EU--
