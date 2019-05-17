Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE3D219A8
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2019 16:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbfEQOOd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 May 2019 10:14:33 -0400
Received: from tty0.vserver.softronics.ch ([91.214.169.36]:40336 "EHLO
        fe1.digint.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728535AbfEQOOd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 May 2019 10:14:33 -0400
Received: from [10.0.1.10] (unknown [81.6.39.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by fe1.digint.ch (Postfix) with ESMTPSA id B403930C23;
        Fri, 17 May 2019 16:14:30 +0200 (CEST)
Subject: Re: Used disk size of a received subvolume?
To:     Remi Gauvin <remi@georgianit.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <c79df692-cc5d-5a3a-1123-e376e8c94eb3@tty0.ch>
 <cef97a5e-b19e-fdae-2142-f8757d06c4d4@georgianit.com>
From:   Axel Burri <axel@tty0.ch>
Openpgp: preference=signencrypt
Autocrypt: addr=axel@tty0.ch; prefer-encrypt=mutual; keydata=
 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
Message-ID: <aed995de-79d4-9932-397d-bd0d12a51b7a@tty0.ch>
Date:   Fri, 17 May 2019 16:14:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <cef97a5e-b19e-fdae-2142-f8757d06c4d4@georgianit.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="09OxILFhkIDbvmwb5ozIpTyr4w4w35vzE"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--09OxILFhkIDbvmwb5ozIpTyr4w4w35vzE
Content-Type: multipart/mixed; boundary="B1JMQRlrJoeDJ3pWg6XslPX9QMzBmX4iD";
 protected-headers="v1"
From: Axel Burri <axel@tty0.ch>
To: Remi Gauvin <remi@georgianit.com>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <aed995de-79d4-9932-397d-bd0d12a51b7a@tty0.ch>
Subject: Re: Used disk size of a received subvolume?
References: <c79df692-cc5d-5a3a-1123-e376e8c94eb3@tty0.ch>
 <cef97a5e-b19e-fdae-2142-f8757d06c4d4@georgianit.com>
In-Reply-To: <cef97a5e-b19e-fdae-2142-f8757d06c4d4@georgianit.com>

--B1JMQRlrJoeDJ3pWg6XslPX9QMzBmX4iD
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 16/05/2019 19.09, Remi Gauvin wrote:
> On 2019-05-16 10:54 a.m., Axel Burri wrote:
>=20
>>
>> Any thoughts? I'm willing to implement such a feature in btrfs-progs i=
f
>> this sounds reasonable to you.
>>
>=20
>=20
> BTRFS qgroups are where this is implemented.  You have to enable quotas=
,
> and leaving quotas enabled has lots of problems, (mostly performance
> related), so I would not suggest leaving them on when there is lots of
> activity, (ie, multiple send/receive, or deletion of many snapshots.)
>=20
> But you can enable quotas as any time (btrfs quota enable /path)
>=20
> Wait for the rescan to finish
>=20
> btrfs quota rescan -s /path  (to view status of scan)
>=20
> And then:
>=20
> btrfs qgroup show /path to list the space usage, (total, and what you'r=
e
> looking for: Exclusive)
>=20
> Note that the default groups correspond to subvolume ID, not filename,
> (someone did make a utility somewhere that will display this output wit=
h
> corresponding directory names.)
>=20
> btrfs sub list /path is used to find the relevant ID's.. (I find the -o=

> option useful, so it only displays the subvolumes that are children to
> the /path)
>=20
> As stated above, I would suggest disabling quotas when you are finished=
:
>=20
> btrfs quota disable /path


Thanks for the tip, but this does not seem practicable for productive
systems, as it involves enabling quotas, which had many problems in the
past (not sure about the current state, but probably still true if I get
you correctly).

Nevertheless I played around with it and it seems to work, I'll keep it
in mind for the future.


- Axel


--B1JMQRlrJoeDJ3pWg6XslPX9QMzBmX4iD--

--09OxILFhkIDbvmwb5ozIpTyr4w4w35vzE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEGhZyjCOMCiVqHcFZjQOnykvjzX0FAlzewb4ACgkQjQOnykvj
zX2jvA//Qh0RXfyC0kkQd45lnHR0R2weu4ZJI03qocaTvkYDA2C4fhgU0YMjHDdM
5Z1sHX0bH0jfyg0tNzKYoZHUGoxtOerSOvuL0M3HzT1yfmGAyYZUZ/sHd/MNjXi8
26hQxmm0t9xpSbbhjyA7msj/hc7CjUuZlGg6/ICMEsLk+ppSIONJSMmNztJe7k58
RMMr9FMCit7hq9dFmy09BwXvBtUbA1uq6PyTE01TB6hqHKibXN24x4kK12ljsV3J
KV9igidaLEJyOL5R0ctBROUP7/jGxtLebJprZna7Lp3muoAtodGZKOrV5NwOlwlj
YIK+v/iZa/0lYDaj3B8CTVZkcDp9IAWrmsu+XDcX143RxghfF0nj4PiwS1X9711q
B2+ikJ5Np0Ba/L5WdrlGx02pbgzoUD777+VFsj/age07Krdc0fhQMmZVpQWb2CjT
QKZ5tNFE5VG3Deetv2QbOmY+VmWS570Xj/cAWaQyNNdKbhu5sc5TRo3gjE44cGEj
qUIu6P+ltuTyC28SqbO9pQnVbO1H7YVxlQL/NLSq/KC5AvzH8+kYdokayUFOd0h0
UOdZs+KVGVph0JRFzdsuMJa6OSPwuYhFRJUburtQU1au2UC0dMVY3GVQ7GzSR853
Sy5J4As6yKKRLsasuXKeN0Rye/WulsOz8Ou0863J8+SYRlC8f2w=
=s9lF
-----END PGP SIGNATURE-----

--09OxILFhkIDbvmwb5ozIpTyr4w4w35vzE--
