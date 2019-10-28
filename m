Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E462E716D
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Oct 2019 13:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389114AbfJ1MgT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Oct 2019 08:36:19 -0400
Received: from mout.gmx.net ([212.227.15.19]:55179 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389043AbfJ1MgS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Oct 2019 08:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572266177;
        bh=DVASN6w+c8lPYwypOtCoP7ksTeRsAwT2Ro1NfU5L/Ao=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QDbPKL7NrTiPIdXKEte6OOhHGfkiiQHFO/qmbTo8f2h5fjr8wcxdKWxoYQVKCnpOv
         biHfXZF3IzuZQGtvYNW2OO9sPUiWv+Y2XhvN8HX21wMiktxuZdsYRJmqp0UrPRg7PJ
         mBTQDD80ZQe9kPvBQ2APaFDdLhF5AtJp/IKLehek=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MTAFh-1iYbZH1RbL-00UagG; Mon, 28
 Oct 2019 13:36:17 +0100
Subject: Re: BUG: btrfs send: Kernel's memory usage rises until OOM kernel
 panic after sending ~37GiB
To:     fdmanana@gmail.com, Atemu <atemu.main@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAE4GHg=W+a319=Ra_PNh3LV0hdD-Y12k-0N5ej72FSt=Fq520Q@mail.gmail.com>
 <cb5f9048-919f-0ff9-0765-d5a33e58afa7@gmx.com>
 <CAE4GHgmW2A-2SUUw8FzgafRhQ2BoViBx2DsLigwBrrbbp=oOsw@mail.gmail.com>
 <b4673e3b-b9b2-e8e5-2783-4b5eac7f656d@gmx.com>
 <CAE4GHg=4S4KqzBGHo-7T3cmmgECZxWZ-vXJMq8SYnnwy16h3xg@mail.gmail.com>
 <CAL3q7H4Wc0GnKNORVvwCOEk1QhzUweJr1JnN=+Scx5-TpQ5+yA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <6364c263-0e47-9ff1-9288-7f6cadcc69bb@gmx.com>
Date:   Mon, 28 Oct 2019 20:36:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H4Wc0GnKNORVvwCOEk1QhzUweJr1JnN=+Scx5-TpQ5+yA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2tgEIyNEGydaGsaNDkRFMGMdsqxEW9YZC"
X-Provags-ID: V03:K1:eImO6NXciczDyT6IABW69u0uUtTVty/lyqFMqJ91CVWuut7+LQI
 MokdmoCNc05a7bmzrN1zEqNhj7vElp+dqCm2BHHeujUAn04aYgc4cHcQTnkKDHux9UbBHpj
 1D/kznwQ3c4QYHdfzDu4diGy/BhRziqa4PAG/YkWpJerBn+egF0gBw0CN8wq1o34SiEXncy
 p0gXhCRlk8cz1hep/dygw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LCbKa8qTeV0=:0dmreoKdQFMoQonKadzfbZ
 MD6r/J9htRdwgSvLGTbn0IKIQ+7fCEOwHIB1YFaQ1L9lfSCum/V53AW9vr+e2LkDwaESpZcdn
 AuGszAA2vnQc3rjIZtmAcabvv1xBEMEVYMne+l4aqYJfq56Micz/08u1284JVKuWAvI5vOo6d
 0zLc115wIj+SktmmIx00BqYUoeE7Kkmb8DnvQlvoVZ/wBD2U0ea8/cX5CN0tf56RxD5+LQp3f
 RdbL2CwD+sWKktW9YxhFFaxi+Ajqk5ZGDMB6LEzhhBLhuKypl09Go0u8D0W6zAviimK6KMQJ+
 sgApTaUgrdjGhw06rsY03ulRcoDRpgGRCMK9oG+3Pgw/oGV4D3CrZYp7aDfDDqufDbqT266v3
 r+Dyo0l4QGKx9PabDh/p338F6TE6oXK1xt76m2t/evStJXtybscv95YXu9CwRQdAGG5pO4IPn
 xRk/MV59RqsaN4b+/iQ8e8+DaXuNNNq6M9IEouoCfh2ZpDetP8br7mBMeynfRYFAyc7qXwg90
 ec1dIqCVAy9U2BYuBav+PIxXRxDgNg11ukl9A8rC3BYm8w3lomVhMYNJGyllpob8DfJMVmxr+
 wP3jM6F5oT7ZRmgXwjWDzkwCf4usPXcSKDpz7/hejwjl4C2WIGJFfbFjNilnVBzypWZ4T7LdI
 bZ9FcKbLQgXGNJCIK8FNAYgHdxdZ6E4/GvktDOVJ39RSTHhTXsNHwDlc09nkqP8F+mKsORo8l
 dhW0GqwjRm7pcMwVawhbjWYDH+7cH3L67bM9j/yjZb/dXC/9BGydfAHqSZ7sro1JaYOXCrZi2
 I/ocm84GG5MkyWFYLVLrxQE/ILdFVQwrE9mWx/NPYUETicZdtfJcgwUxldoeSYDUT1vNZ413H
 ek7o73TxLho7aJKDM9KH+KWf5GvXc3e4EOoSNgSTV9U0+sN6/Xmz8Eol689OtDcy1aT5pBsPJ
 gHFkI3vWHaX0TzvLU6ozIxVdZOiCCU7PgNr1/KCDLpGAQOYl6zPgmsf2yYckje83MOyEnR63O
 ot/y03+4I6Znpz7YfxDXFvrqeyLG+ntiBn2Sd9MiTeGHXzkpqGeakr6gcwcUySTX/X7FbXUxT
 YFXzfO0AgdmJY1eiIg6oVNBEA+3+OpeS4ldhBtShbaiqUYWkYM4aBNRLTY8Vm3hQ4rf4haEWx
 3u5kjNZsopfYvKdsrDE0bfENpCNBm7FZ6Hg+YCZRsEM8y8q1u4q5U023tdOjKAuh5KtoVsYyk
 V5+O6bnzDqG9Y0bkDqqTJNZH7LRZ0o3CERGHvu21LjzH4wOwrLxPfgIW6tDg=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2tgEIyNEGydaGsaNDkRFMGMdsqxEW9YZC
Content-Type: multipart/mixed; boundary="uC1xk4T03jEYDnxCPOkxaKsXDnG4l1skL"

--uC1xk4T03jEYDnxCPOkxaKsXDnG4l1skL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/28 =E4=B8=8B=E5=8D=887:30, Filipe Manana wrote:
> On Sun, Oct 27, 2019 at 4:51 PM Atemu <atemu.main@gmail.com> wrote:
>>
>>> It's really hard to determine, you could try the following command to=

>>> determine:
>>> # btrfs ins dump-tree -t extent --bfs /dev/nvme/btrfs |\
>>>   grep "(.*_ITEM.*)" | awk '{print $4" "$5" "$6" size "$10}'
>>>
>>> Then which key is the most shown one and its size.
>>>
>>> If a key's objectid (the first value) shows up multiple times, it's a=

>>> kinda heavily shared extent.
>>>
>>> Then search that objectid in the full extent tree dump, to find out h=
ow
>>> it's shared.
>>
>> I analyzed it a bit differently but this should be the information we =
wanted:
>>
>> https://gist.github.com/Atemu/206c44cd46474458c083721e49d84a42
>=20
> That's quite a lot of extents shared many times.
> That indeed slows backreference walking and therefore send which uses i=
t.
> While the slowdown is known, the memory consumption I wasn't aware of,
> but from your logs, it's not clear
> where it comes exactly from, something to be looked at. There's also a
> significant number of data checksum errors.
>=20
> I think in the meanwhile send can just skip backreference walking and
> attempt to clone whenever the number of
> backreferences for an inode exceeds some limit, in which case it would
> fallback to writes instead of cloning.

Long time ago I had a purpose to record sent extents in an rbtree, then
instead of do the full backref walk, go that rbtree walk instead.
That should still be way faster than full backref walk, and still have a
good enough hit rate.
(And of course, if it fails, falls back to regular write)

Thanks,
Qu

>=20
> I'll look into it, thanks for the report (and Qu for telling how to
> get the backreference counts).
>=20
>>
>> Yeah...
>>
>> Is there any way to "unshare" these worst cases without having to
>> btrfs defragment everything?
>>
>> I also uploaded the (compressed) extent tree dump if you want to take
>> a look yourself (205MB, expires in 7 days):
>>
>> https://send.firefox.com/download/a729c57a94fcd89e/#w51BjzRmGnCg2qKNs3=
9UNw
>>
>> -Atemu
>=20
>=20
>=20


--uC1xk4T03jEYDnxCPOkxaKsXDnG4l1skL--

--2tgEIyNEGydaGsaNDkRFMGMdsqxEW9YZC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl224LkXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qgehgf/Sj9vr8FHSdBrUUoX1t7XNAXP
sOXxIP811JT+ukT/zsKeBc/LqPe7ro/5ztu7fkgY5DRqnipip3CD9CbtTaODAinv
+o4PpTMf2cnEFhQHiw0vv02AViAPnz+jFSSqZkbQCInJA7DMjP5wRq5y84W8wgr6
IlbBzL/4EHtOnfEpuJVTUQ8ZWXXhWe9Fra0v5fNjf/DRRFb2gm0SDR0EyITluPN1
yJjZUCHEB2AZ3cReszfg19NUBDxRWzzPOxucFg/G2LPtUmobpBwFbKimP/2DADyG
4e8IOvBEMNfXSV40I8CrfPBysj4tLmoSNl4cuxto0Vtip7L/f+gGlJH1r1Ki0w==
=i4HN
-----END PGP SIGNATURE-----

--2tgEIyNEGydaGsaNDkRFMGMdsqxEW9YZC--
