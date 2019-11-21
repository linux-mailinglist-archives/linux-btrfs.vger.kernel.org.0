Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94405105CBB
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Nov 2019 23:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfKUWjN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Nov 2019 17:39:13 -0500
Received: from mout.gmx.net ([212.227.15.18]:49597 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfKUWjN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Nov 2019 17:39:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574375952;
        bh=XSJ3MCAQ8QAW3D0WA4thbvXBHDZZ2SVhy9PLbZJEM0U=;
        h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
        b=efe3h2+7HNeCS3W6A1ktR2bQ2mj18zzyMMO0hzhwS5BaoGa3FnUP8f8kLP8ciY/4f
         IzppeLwv4aPO8Awcl0CjbMtnbdnMAU1QtzSOdBHgCgOJRR3UelVm1zWKLJT1OIAXFI
         ln2NilE0cfzlEubGxbvoc1c4KGuB8w5YIn5S/lcs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from thetick.localnet ([95.90.202.39]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhU9Z-1htcLM3TLX-00egU2 for
 <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 23:39:11 +0100
From:   Marc Joliet <marcec@gmx.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: freezes during snapshot creation/deletion -- to be expected? (Was: Re: btrfs based backup?)
Date:   Thu, 21 Nov 2019 23:39:01 +0100
Message-ID: <6893661.AATI4FVq6M@thetick>
In-Reply-To: <CAKbQEqFX8_oU=+KtDsXz-WeEUytgcXr-J-pw+jEmC3dwDAfJMQ@mail.gmail.com>
References: <20191112183425.GA1257@tik.uni-stuttgart.de> <CAKbQEqFELp0TWzM+K9TqAwywYBxX_3jXy0rz6tx9mNXyKEF02A@mail.gmail.com> <CAKbQEqFX8_oU=+KtDsXz-WeEUytgcXr-J-pw+jEmC3dwDAfJMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2709832.BLJF4r2Mcq"; micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Provags-ID: V03:K1:g7IWWJvBqAADKN0yC4e4MwgPfWK3+gy5Ar3uzOkm+4WVCOrIPtJ
 AmVCRojolxkGr0WMkNId0zsNnT+74jYv/9EulGwwxl5BGoL0Io31ShO0rhap6N9VB6HmToJ
 hWUtiO9qDnfKay5rWdgKW0Xp+pqqTWGvS+3RxenUV8lmXJm8Ckp3fY3N+cQYY2QX5xE6i7/
 wPtVvGekjbxeeb2EUgoXA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rVdtP6A2drs=:S7SH3BeDndHkriLtPaNWUf
 yz+iIop585kIa+s8iIFgdQc1enUI0GkuwdA3OwwevZ7YhAhpEU9g72eEWu+M1W/sphL9u+D3w
 M3yhjhE2UGP5dRyKOeMGp2vxSnPLyM5Si0BoAnumPqY7vJ0Mi2r/7ivZujn32acgfnBUnjj7X
 nHXwi9jHeK/x6kbzyNjsUBwgdHpI7AS+xmPrgJADA0bCv/lglncuklTCrMyynHFUoBdrMPBm8
 EuLEkpk9RHbkxmdWYdvbX0rBpMq2IR/xgaz4/0hkMcao8SShNwjoacyNVBbb91ohTkNGzT6Zc
 gGmyN3SHegI8EbanWfnU39Hv/JFmlsAPu0EHsqsAyx3A9K4OxQ4MzIPIanU8D5W9vcMEEbJwH
 skSuibmCEcT08qn1y+fISECcMaWd/Vbo/d54elcBLLDQ7FY0IycsaikJff/+z678QdVw9sz9E
 beFe6x4G80IlM71qoc+XtRMuRVBm/y+C4QpEC39F3spqO4IriM+MJXB2QUrE6DUQyOYbG36ID
 ghXoTpxLESVI9DJ7UJyKKDPmQHWg8ACK5lMvDj0NHDp3NFx+2x8FzGBgdRRMFuEK+17QFXP4Z
 jQLOVOsmfHQxsP0OwXL+83vWoMqKGmWkhOX8G8xXm481tfLWR9+7E5hIOIFFQmklk7SLJNcCq
 AoP+ee5InsfVwCxFWysdTHGoNpPl+ZBHX9RxFEbKt3HUwCUypZhSy8LiEIv9qw4TrqYSxqZdy
 aCangG1cYbSrTGaNJsl1yilZ5uFXlibHWLsdPQK7txLAoEZxTSkl4U6D7mq6VdFcSOH5+dden
 923X+rq71zw0p2GV/XAjfj7PsJs6jebcEumedTKTavN3M83xF3JMUEEchM+FXlEgFQCePkh4d
 idLDpUJvB1zD0nqOqvKRxnjpm8TEfCqmRnJlDwKCvZ4v5cFezoWJ64D84QbpPD58qvJ0vfxnr
 wsDYhGUpW/VEcv2n889+bdiMKywLzYakmCdiEP8uFISZ98RtiocIXjkRypUfUzWvXMFBnFBv2
 FS1jtnHnrTUhdJ4DsMiwfs75o93He93zjCLqpt2/cE7SKhbSI8oXciAHvZ7C7/hBG1ckBuaa2
 QxiTeU2w0LmoCSnbmtaGBAXE4BGWUlbxhsQiMJeAOQj5hf4jfEWSAajH3+q6TvoTXADSktjWC
 yFD7evID9U2vCpggh6m74ML76UPKvj21l5OPJqBqH2vMuuDDRixMumvTI4nY4CvnrM5zNK7r9
 fkSlYmrLyiGzQDqezUhDQeg1cVEX+mUpz/UYCmg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--nextPart2709832.BLJF4r2Mcq
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Am Donnerstag, 21. November 2019, 22:34:41 CET schrieb Christian Pernegger=
:
> > > Another interesting test could be to adjust btrbk configuration to:
> > > btrfs_commit_delete =3D each
> >
> > Will do.
>
> Hm. No freeze, this time (with btrbk set to commit after each delete).
>
> In other news,
> - I seem to be leaking cgroups. There are currently 191 subvolumes
> (most of which are ro snapshots), but 547 "0/*" qgroups. Should
> deleting a subvolume take care of removing its (auto-created) cgroup,
> or does that always have to be done manually (or by setting the
> experimental *_qgroup_destroy options in btrbk.conf)? Any elegant ways
> to remove orphaned cqroups?
> - Timeshift, at :00, triggers this as well, it's just less severe
> (maybe because that's 1 subvolume instead of 3).
>
> Cheers,
> C.

As Qu said, the freezes should only happen on snapshot deletion.  Dependin=
g on
how you have btrbk configured and how regularly it runs, not every btrbk r=
un
will delete snapshots.  Therefor not every run will cause the system to lo=
ck
up.

On a side note, I am also really annoyed by the lockups caused by qgroups.=
  On
my Gentoo systems (which use btrbk) I have it disabled for that reason, bu=
t I
left it on on my openSUSE laptop (a Dell XPS 13 9360), which locks up for
about 15-30 minutes while cleaning up snapshots a few times a week (usuall=
y
after reboots or after "zypper dup").  Of course, that's with snapshots ac=
tive
for /home, which I do so that the file system doesn't change out from unde=
r
borg while it's running.  I'm tentatively considering turning it off there=
,
too, but I'll experiment with the snapper configuration first.

Greetings
=2D-
Marc Joliet
=2D-
"People who think they know everything really annoy those of us who know w=
e
don't" - Bjarne Stroustrup

--nextPart2709832.BLJF4r2Mcq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQS2YUPDQn1ADQEoj0uXgvYOs+E2oAUCXdcSBQAKCRCXgvYOs+E2
oDM9AP41k6OBqQ3hNAMlLxbyUO9wiTrDfNzVZxFd1nn67Y765AEAq/jNMPgKDeNi
EQxHRAseZaOAB0yXgjk3nvTpiGquOws=
=wtCC
-----END PGP SIGNATURE-----

--nextPart2709832.BLJF4r2Mcq--



