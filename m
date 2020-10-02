Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCBE2280FEC
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Oct 2020 11:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgJBJcy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Oct 2020 05:32:54 -0400
Received: from ns13.heimat.it ([46.4.214.66]:57576 "EHLO ns13.heimat.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgJBJcx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 2 Oct 2020 05:32:53 -0400
Received: from localhost (ip6-localhost [127.0.0.1])
        by ns13.heimat.it (Postfix) with ESMTP id DC2D53021B8;
        Fri,  2 Oct 2020 09:32:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at ns13.heimat.it
Received: from ns13.heimat.it ([127.0.0.1])
        by localhost (ns13.heimat.it [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iCfedeEtkzvg; Fri,  2 Oct 2020 09:32:31 +0000 (UTC)
Received: from bourrache.mug.xelera.it (unknown [93.56.169.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by ns13.heimat.it (Postfix) with ESMTPSA id 43B7E3021B5;
        Fri,  2 Oct 2020 09:32:31 +0000 (UTC)
Received: from roquette.mug.biscuolo.net (roquette [10.38.2.14])
        by bourrache.mug.xelera.it (Postfix) with SMTP id 0A78577748D;
        Fri,  2 Oct 2020 11:32:29 +0200 (CEST)
Received: (nullmailer pid 27735 invoked by uid 1000);
        Fri, 02 Oct 2020 09:32:28 -0000
From:   Giovanni Biscuolo <g@xelera.eu>
To:     A L <mail@lechevalier.se>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: how to recover from "enospc errors during balance"
In-Reply-To: <0afae20d-62d2-00eb-4ac5-fa9b5205a937@lechevalier.se>
Organization: Xelera.eu
References: <87r1qk4q4d.fsf@roquette.i-did-not-set--mail-host-address--so-tickle-me>
 <20200930000417.GH5890@hungrycats.org>
 <878scq1g0g.fsf@roquette.i-did-not-set--mail-host-address--so-tickle-me>
 <0afae20d-62d2-00eb-4ac5-fa9b5205a937@lechevalier.se>
Date:   Fri, 02 Oct 2020 11:32:27 +0200
Message-ID: <87v9ftdlck.fsf@roquette.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello,

A L <mail@lechevalier.se> writes:

> On 2020-10-01 10:56, Giovanni Biscuolo wrote:

[...]

>> --8<---------------cut here---------------start------------->8---
>>
>> ~$ mount -o skip_balance,relatime,ssd,subvol=3D/ /dev/sda3 /
>> mount: /: wrong fs type, bad option, bad superblock on /dev/sda3, missin=
g codepage or helper program, or other error.
>>
>> --8<---------------cut here---------------end--------------->8---
>>
>> dmesg says:
>>
>> --8<---------------cut here---------------start------------->8---
>>
>> [7484575.970136] BTRFS info (device sda3): disk space caching is enabled
>> [7484576.001375] BTRFS error (device sda3): Remounting read-write after =
error is not allowed
>>
>> --8<---------------cut here---------------end--------------->8---
>>
>> Am I doing something wrong?

[...]

> I think you need to mount an unmounted filesystem and not re-mounting it=
=20
> (as per dmesg output).
>
> Example: "mount -o skip_balance /media && btrfs balance cancel /media"

Ah OK, now I understand

> However, I think this is your root filesystem, correct? They you must=20
> boot with a bootable media and do recovery from there

Yes it's the roof filesystem of that machine, so yes: I'll have to
recover via bootable media.

> Just remember that deleting data on Btrfs can increase metadata usage,=20
> especially if you have lots of snapshots and such. In the case your=20
> filesystem goes back into ro mode when deleting files, you may need to=20
> add two additional disks (or loop devices, usb sticks etc) to continue.

OK I'll do that.

Thank you both for your support!

Best regards, Giovanni.

=2D-=20
Giovanni Biscuolo

Xelera IT Infrastructures

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCgAqFiEERcxjuFJYydVfNLI5030Op87MORIFAl9286wMHGdAeGVsZXJh
LmV1AAoJENN9DqfOzDkSsLMQANRgwTnTZCkOVm4YFnUWXAi9NzCYSs5J/T6wVlup
EmYyIEgzf62FDjDreh1U8drA1AAJyD1WLJ2c1zYf7MSFpML2TB4NLqjbkt5CXN/6
1eS8saFTlI/6uo4LUunX+ptqnS4qz5fuROVL4n9GluzarMNZnG9q03aOhm91LIc7
LsdGpB/LA/ibU5qNIPr7TNgoqs2npz6m/FDWyMlH8NbzZHzj4c0UNe2p6R9y3pjU
giaKnlHlC4IGodj2KuvxzxKU+oH9HI2ziHpR0Rr5QQUCOc5uaKm4YcRxSKcH2Emv
ViDHNfB9987FvDhf1kyIAou+4chuzf3U4Sg+HMt0u8n16Fdyt40S6LNZsYIdm5XW
M3aGnTK2BHVHooPnD7Dl0g48zUHg/kcjkQGUxNhZRpQdyG+6GzPF+HHrPYA8+s73
nT5VM733VOKqOKA7BijsnqPkp5YhfaWvDrLYZyo1I9G0DQ5F6GWfh8cJ574N/Ukf
LQ0fMjS9vXFUfuVwJLDV5D/QfZVozchMHJcQ7ebGoDsgiHPmJNZ7OjQd4+RR5lrd
z4+6sf9xvfAfVz2u8377C1BoUKngqIo4tVvn0/PKzj4mlqzYugWUViR1OgnWv1lO
xQUwNY/j4qKc4EyxthzMTrwe33cv7FIdW2d5pn3pdYQGLz638ZlIIQHqC9kPoLJt
i44y
=CTcF
-----END PGP SIGNATURE-----
--=-=-=--
