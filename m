Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9861C81E0
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 07:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgEGFwU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 01:52:20 -0400
Received: from mout.gmx.net ([212.227.15.19]:59105 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgEGFwT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 May 2020 01:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588830734;
        bh=34YHUyZI99/J1ob+oWVqEjfeh3G2gODj9+QKLtmSDr8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=dxZe31uC8BZ5zEMMvF8glCt08spwOfsqk9rGbH9v3M+3/Hss5h0wjo/P/a6P46m74
         6tm79xRIcU/rUeOdz/xRdnfFAuRxKby3gAsomc5vRn3WIyFYfvAx04T0XSWX9hzQE0
         vuUX5K4A8PtkPsuwEtj350G6jTmU/sZyCYHgup9s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MAONd-1jP7TO2jlb-00BrS5; Thu, 07
 May 2020 07:52:14 +0200
Subject: Re: Fwd: Read time tree block corruption detected
To:     Tyler Richmond <t.d.richmond@gmail.com>,
        Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJheHN0FUe-ijMco1ZOc6iKF2zbPocOw+iiVNeTT1r-JuXOJww@mail.gmail.com>
 <CAJheHN3J85eLmZZYs0-ACoUQFuv3FVHmAnoJTxB+Xu8CGnCy5A@mail.gmail.com>
 <a89afb42-facf-3e11-db53-c394cf8db2ce@gmx.com>
 <CAJheHN26GYa7ezw-Jw_y5voFicoywwEJ2pJ4KKx96x-WA2h1eA@mail.gmail.com>
 <CAJheHN18TmG7g=-Sgi36hVmWka4z99rQRfaf=3FCRvat07C8pg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <bbd08948-6672-4fb1-0e84-802482da7228@gmx.com>
Date:   Thu, 7 May 2020 13:52:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJheHN18TmG7g=-Sgi36hVmWka4z99rQRfaf=3FCRvat07C8pg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8Zm51X4j0Wi6HNQyVa5m8GymviKVjiNfa"
X-Provags-ID: V03:K1:Yg5GpBOI8U7d3enflUO+BXM+BDjGny/g5pqIVrk11n5uFvsKmc/
 DDUlrdNWd5TKtTofj8t0dHjQgGRQKR1TaGQbxsd/VlmumTlhZKlrZH9PpZxpuCWPCPhIKxJ
 8LSa1Z6ncp93lQJGm5mQ6p6v7nu9PK/eCTRI+3slfO6LmMj5GmlH4TXnEfBNOSkJuwpgMnS
 qycQym1iiI7Cw6ZLCjr/w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2HP9vjTJKgM=:KP2xH60WH/nMxATbYt5s62
 yLxtao0e7U6U9XHHUjJStZfZ7L4Rhc/yqG3ZP8Fg5uJnJRLiJOLEuBqYc/Bl1KP7Mxf9UYKR/
 1gPD85E4H3ymjpBmOwC6F7JmVeh2OEVn/sWUyVXf6pFrj4CgC/JeLF9PmW+GdX0nH1ANg01iP
 zn+ONq/mi+pkf9VOZ//gPiQwchZ2aZg1Q42h2h5vBRqafgXCT2N5Tv8HWgvgW4aS1oK5jysie
 t1rIu2BPRuVFVZjS/WRS+70DCa8O8PwRfQzfYLNh53hYj9b8Hob7A41UmN3e8bFPh5+sKrkNn
 7UKG1eJwSqFUkSM1fJZen7zwK6yNUys0wdeJUY02oE3GIT0+nQeMFzUfmTBVAU5AelGy8lz4y
 sJJCMYLxWg50p8MqW9p6Iz6y0eWncKStr05kWVAogTk/l/IKVXOTq0+9tO23vMxur6VDGwKaB
 iBKfIaPa0GLlLduWiKTWp4Ts9DUBJTktIrc8d1mQbYJYqCi+JmadAorCxJX6Rxlja4RwPcyJL
 0itl4pC3v6+z614etDgKVeQnYI1c/q3r/+qyoorFhXVzap8V1PUVgSgNmyWjPAxppWE4x0XZ2
 FmVqCZ6NU6PN8ZNyZEVN6RWCNw3F0YNyMPJcx8XRTJDX9QpNzTffcEN1rYOehwG5sb9dbiSzj
 3pMcgNSyD22ltGfUdkVIX85r6eU7hQBYme8KvyWBrpcdRUYbkOUfRfF9T1flMzDUPDh6vepTu
 3INFtBDs7+KmqP68vihfXTna/jhuzzruoWdgJj/NLrj+dl77pMrMvIH4lqM+t6qg8Ah1lIUna
 mnAXO4CIGwdOaIqU8WQGndU5JNaD5YLu910LUAAm1lU24B1A9st4NAIET6s0D44e5gSfkEW+t
 uZtNXONLSyOdhwHBvA3dcbo3cY5cZrheE2YaNlOUkZK4y5HEk2P5eAtOMLuA3MOQFE4KP6Agj
 OcJuh6JiyZ8ARBRV15r8pLRVkDoFn/egH4oheq3o/LamAsqXneax+51ZZVEAdSP7Bj5nLX5Ur
 Y9kjVCYQB1/ZO+63jxPXYvw8rB+wEmXRYgzqbkevXoSNyDnW+l0waS0c0Am6Z+Xlv1VQld4Iv
 Op/Etf3FQyzs/X+HoZoQB6ZhBfgIYeURGjiUlNGukTRJLhO+cdabGCBcsUnxVWwEUOXNPDnhO
 oRs/4tsAeQ7rpX50pHcoe4A/J1cQIPmiFA4o4ewU42hVoG3m9hPrj+ckx+EudCo0p3mvnQ93Z
 G774hN9Wzl4hIgRQ5
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8Zm51X4j0Wi6HNQyVa5m8GymviKVjiNfa
Content-Type: multipart/mixed; boundary="F2zCJ9yTKp65diBZQ21l8TiSuTDDU8caF"

--F2zCJ9yTKp65diBZQ21l8TiSuTDDU8caF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/7 =E4=B8=8B=E5=8D=881:43, Tyler Richmond wrote:
> Well, the repair doesn't look terribly successful.
>=20
> parent transid verify failed on 218620880703488 wanted 6875841 found 68=
76224
> parent transid verify failed on 218620880703488 wanted 6875841 found 68=
76224
> parent transid verify failed on 218620880703488 wanted 6875841 found 68=
76224
> Ignoring transid failure
> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
> parent level=3D1
>                                             child level=3D4

This means there are more problems, not only the hash name mismatch.

This means the fs is already corrupted, the name hash is just one
unrelated symptom.

The only good news is, btrfs-progs abort the transaction, thus no
further damage to the fs.

Please run a plain btrfs-check to show what's the problem first.

Thanks,
Qu

> parent transid verify failed on 218620880703488 wanted 6875841 found 68=
76224
> Ignoring transid failure
> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
> parent level=3D1
>                                             child level=3D4
> parent transid verify failed on 218620880703488 wanted 6875841 found 68=
76224
> Ignoring transid failure
> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
> parent level=3D1
>                                             child level=3D4
> parent transid verify failed on 218620880703488 wanted 6875841 found 68=
76224
> Ignoring transid failure
> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
> parent level=3D1
>                                             child level=3D4
> parent transid verify failed on 218620880703488 wanted 6875841 found 68=
76224
> Ignoring transid failure
> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
> parent level=3D1
>                                             child level=3D4
> parent transid verify failed on 218620880703488 wanted 6875841 found 68=
76224
> Ignoring transid failure
> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
> parent level=3D1
>                                             child level=3D4
> parent transid verify failed on 218620880703488 wanted 6875841 found 68=
76224
> Ignoring transid failure
> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
> parent level=3D1
>                                             child level=3D4
> parent transid verify failed on 218620880703488 wanted 6875841 found 68=
76224
> Ignoring transid failure
> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
> parent level=3D1
>                                             child level=3D4
> parent transid verify failed on 218620880703488 wanted 6875841 found 68=
76224
> Ignoring transid failure
> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
> parent level=3D1
>                                             child level=3D4
> parent transid verify failed on 218620880703488 wanted 6875841 found 68=
76224
> Ignoring transid failure
> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
> parent level=3D1
>                                             child level=3D4
> parent transid verify failed on 218620880703488 wanted 6875841 found 68=
76224
> Ignoring transid failure
> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
> parent level=3D1
>                                             child level=3D4
> ERROR: failed to zero log tree: -17
> ERROR: attempt to start transaction over already running one
> WARNING: reserved space leaked, flag=3D0x4 bytes_reserved=3D4096
> extent buffer leak: start 225049066086400 len 4096
> extent buffer leak: start 225049066086400 len 4096
> WARNING: dirty eb leak (aborted trans): start 225049066086400 len 4096
> extent buffer leak: start 225049066094592 len 4096
> extent buffer leak: start 225049066094592 len 4096
> WARNING: dirty eb leak (aborted trans): start 225049066094592 len 4096
> extent buffer leak: start 225049066102784 len 4096
> extent buffer leak: start 225049066102784 len 4096
> WARNING: dirty eb leak (aborted trans): start 225049066102784 len 4096
> extent buffer leak: start 225049066131456 len 4096
> extent buffer leak: start 225049066131456 len 4096
> WARNING: dirty eb leak (aborted trans): start 225049066131456 len 4096
>=20
> What is going on?
>=20
> On Wed, May 6, 2020 at 9:30 PM Tyler Richmond <t.d.richmond@gmail.com> =
wrote:
>>
>> Chris, I had used the correct mountpoint in the command. I just edited=

>> it in the email to be /mountpoint for consistency.
>>
>> Qu, I'll try the repair. Fingers crossed!
>>
>> On Wed, May 6, 2020 at 9:13 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>>
>>>
>>>
>>> On 2020/5/7 =E4=B8=8A=E5=8D=885:54, Tyler Richmond wrote:
>>>> Hello,
>>>>
>>>> I looked up this error and it basically says ask a developer to
>>>> determine if it's a false error or not. I just started getting some
>>>> slow response times, and looked at the dmesg log to find a ton of
>>>> these errors.
>>>>
>>>> [192088.446299] BTRFS critical (device sdh): corrupt leaf: root=3D5
>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, invalid inode genera=
tion:
>>>> has 18446744073709551492 expect [0, 6875827]
>>>> [192088.449823] BTRFS error (device sdh): block=3D203510940835840 re=
ad
>>>> time tree block corruption detected
>>>> [192088.459238] BTRFS critical (device sdh): corrupt leaf: root=3D5
>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, invalid inode genera=
tion:
>>>> has 18446744073709551492 expect [0, 6875827]
>>>> [192088.462773] BTRFS error (device sdh): block=3D203510940835840 re=
ad
>>>> time tree block corruption detected
>>>> [192088.464711] BTRFS critical (device sdh): corrupt leaf: root=3D5
>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, invalid inode genera=
tion:
>>>> has 18446744073709551492 expect [0, 6875827]
>>>> [192088.468457] BTRFS error (device sdh): block=3D203510940835840 re=
ad
>>>> time tree block corruption detected
>>>>
>>>> btrfs device stats, however, doesn't show any errors.
>>>>
>>>> Is there anything I should do about this, or should I just continue
>>>> using my array as normal?
>>>
>>> This is caused by older kernel underflow inode generation.
>>>
>>> Latest btrfs-progs can fix it, using btrfs check --repair.
>>>
>>> Or you can go safer, by manually locating the inode using its inode
>>> number (1311670), and copy it to some new location using previous
>>> working kernel, then delete the old file, copy the new one back to fi=
x it.
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> Thank you!
>>>>
>>>


--F2zCJ9yTKp65diBZQ21l8TiSuTDDU8caF--

--8Zm51X4j0Wi6HNQyVa5m8GymviKVjiNfa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6zogQXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qg7zwgAkpcjNRTleHl8rDuoMAVOrWPW
n/1RxJECuPb01lyzx2dgqrb50nMweok+fYcO5rCTQ4AMzwP1L+gmD1s2tNTdQ6IV
I2dVngt9ldlqvlGrbPgfjewfwM1JN3d6ZXNDv4xIW0gCYpJDPz/TnjBj/4wK1ayF
TbtSoSMLbPZX7AvZgZKKtepYW/OztD029hiaWsvRgPW5kSY3iGhImU4CwnWrQCKY
B35n5BsNcjBbiwMRef5+UXMw3g/8hTAjY9E72bDkw+67yhVH7YXGz4OGRj54a3xq
IkdYRQJJsA9KGgRtsDjxhXkJzAy9F3NKUPcXQSztu2rPg4adkDCgEyf3xllOsA==
=sdYv
-----END PGP SIGNATURE-----

--8Zm51X4j0Wi6HNQyVa5m8GymviKVjiNfa--
