Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47ECB15101F
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 20:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbgBCTG3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 14:06:29 -0500
Received: from mout.gmx.net ([212.227.17.20]:41469 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgBCTG3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Feb 2020 14:06:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580756787;
        bh=CG0+lWtGXm3alu7GpugOvVz+CO/ZSXhShWlBtIGa1oo=;
        h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
        b=Q+7Zk5NbWmqya5tj5qkBxWz1uiOLJ8zIk0DD+QN24ABjGAOJ1Tt7orzlZs1Wiuksv
         7niDmPfjsMjaEeQjawQmUG0gQ/T4N4UD8puO/gSI/oPeLEb1wiXUGun9PRvTw7clQj
         CUZtMHHciXyrPGMw+iGAObfavffIOUgsVHNxwgM4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from thetick.localnet ([95.90.202.39]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmlXK-1jQpzl1A2A-00jrOY for
 <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 20:01:27 +0100
From:   Marc Joliet <marcec@gmx.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: My first attempt to use btrfs failed miserably
Date:   Mon, 03 Feb 2020 20:01:18 +0100
Message-ID: <2497374.lGaqSPkdTl@thetick>
In-Reply-To: <CAJCQCtRhTWJuF_=BC0Ak2UtU7RcT2xruHpkYew6zSz2jH3916A@mail.gmail.com>
References: <CACN+yT_AYiLc29M41U+WrQHtk4t==D-4AkH+wRROKJY=WstGAA@mail.gmail.com> <CACN+yT-0B7ytOTEh-uv4T+NBShQBgpRGUhYMv4O=zFi5K0QRoQ@mail.gmail.com> <CAJCQCtRhTWJuF_=BC0Ak2UtU7RcT2xruHpkYew6zSz2jH3916A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2328398.XAFRqVoOGU"; micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Provags-ID: V03:K1:ZfsLP8Jk+Kb0G7Z2ekXiRQd+JIBBebPQOckjY3D5/ZdY6yLU9Eu
 XtcJh3GST+ltR0DnzHmCP9nCYgXnsLmpFuF71u1TdyKRMdR6770WrZnYVs1gpQDsrDKJRBo
 cco+dX9VxLC2iMr5y5V445cRdxD6wFGsm7+1wCjxZppGiahcW0Vf1GRRTl7U8Wy+qLDAzG4
 mFVg+zqkAP1/ap3taqzWA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LYTV3hT5Ryo=:J1SoXu8lVOX6Y1AnpUHURK
 EYZ8J30khdIsUBXdDsN/CopoQXaxD6o+a/e4+dVcCweJvmVqk/fTEYGzJSxp59c84VFg/ikJ+
 HqpLqxX4E6BZypE/sHNc3SJlASncnlGPWO05F+uOGBoLNAtGakssAoSiecAydOdkiuRiDt/M+
 m8PogcAQNxU90QH2QJTDAXJRtNumDIiruJR6EKMLNifA6fHKE3kQJwqrwT04D7N2kc747k9oI
 hR5Jm1/xQL9AUvoBw6MkabVD6ZC2Hx1YeXLeIWl1F5QlAA64zXjkIBCLlNAGZEoTsDPuGdDpC
 +DR83tjRpibNFTSxiuYunwfJGsnoc8oFp5EsqEpV5MteCBTJnBqkl4JFbanHzt6HEDA+4/8Ul
 0TZ4qi4vbvn5ecDiv2Wqs+k97gYySM12StewilfqwCisoTvqCJ+p5BuzW4iZvecBO8Wx94VLw
 ILtUBJ7MXSEun+umJKsdtg+7qaKmpZ14rzNkPSkR0wrT1Uke53fGF68WTWXPDWPtNDlK+I4Ne
 m/0whSuHhmG0tgFq+EGtDGhAtHZnzj3a6Bqby1tLu6857ZAChGT+Rnt5ABH+5GlFSUy+udkG7
 HisW3xzUlhvx3XwHmkQHlH5l3uOxBmWJSKFMxrMgnB9h1NmWjIRJcicA0v5NTCRdXX/vXv4jk
 AJR/Ec0XuJcxtBXs4MNj8MaTC6W/usIni9cck9whM6gUmaPKZn24hmaTvsQB5oCiCP+EQO+xE
 5qouBBlZxjxDaBRGbFycpTF/pgZZA4KXP7KUl8l29G34Psy4/UYX+qdxet78fKmqWv5CG3UJ4
 XCDlW6lteMjOkvqy6UcOtZABgr1GgdGXu6Z1G+Fy356CTNd1xpJ48NYaYfAO5bs9L5/EFvayo
 ttoFmNMxY4BzXs400M9SGLev/qPdfww0a492UKF70LFenPglvxTiLNQHnoz3jhc+3uT9BLYxO
 uTHkWibh50ZcaccQOgSDLjH5V82g5E8U48WoQhF1ba4yDVzXT0ZTrE8p8wrg+btqBB/B+RBb0
 58B9P3ZftlY5/5PoySk5tnvPB6+KW+fV/neSz5hp35BkkCMsSNrp3HuO5lQWCDBfxcJeW2HX8
 LB5YumtPuvcgtc8KMmoVCvwVtOphBQFxLvUMD+LUti5i0ZxOGBESPHg3OuRtka6pUTbazoKj7
 651BbYgLubH9r4MGOO+fB1MAx5RT0Mh20QbHSGCq/oXMzl+2B0M3NSLLwlTbyvtl2UPhZmqf8
 LDMROQYlcidPGKs36
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--nextPart2328398.XAFRqVoOGU
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Am Montag, 3. Februar 2020, 17:12:17 CET schrieben Sie:
> > Yeah, I found out some errors in dmesg suggesting this:
> > [  370.569700] usb 2-1: reset SuperSpeed Gen 1 USB device number 2
> > using xhci_hcd
> > [  428.820969] usb 2-1: reset SuperSpeed Gen 1 USB device number 2
> > using xhci_hcd
> > [  473.621875] usb 2-1: reset SuperSpeed Gen 1 USB device number 2
> > using xhci_hcd
> > [  618.254211] usb 2-1: reset SuperSpeed Gen 1 USB device number 2
> > using xhci_hcd
> > [  664.334958] usb 2-1: reset SuperSpeed Gen 1 USB device number 2
> > using xhci_hcd
>
> I get these with a very common USB-SATA enclosure bridge chipset,
> plugged directly into an Intel NUC. I also sometimes see dropped
> writes. When I use a Dyconn USB hub (externally powered) it never
> happens. I'm not a USB expert, but my understanding is a hub isn't a
> simple thing, it's reading and rewriting the whole stream to and from
> host and device. So any peculiarities between them tend to get cleaned
> up.

FWIW, I used to see errors like this with my external HDD (3TB Toshiba), b=
ut
not anymore after I increased its device timeout, i.e., its SCSI command
timeout, to 3 minutes (following a recommendation on the Debian wiki).

=2D-
Marc Joliet
=2D-
"People who think they know everything really annoy those of us who know w=
e
don't" - Bjarne Stroustrup

--nextPart2328398.XAFRqVoOGU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQS2YUPDQn1ADQEoj0uXgvYOs+E2oAUCXjht/gAKCRCXgvYOs+E2
oFkiAPwN6epvQHoP83Nr+5OG8ESH1kDTMhwSb3uYUoWOkjJ5nAEAozQ6nSumJ1nX
EK9hilXXITHzWc9QYDNJZl592HmUEQI=
=l+UC
-----END PGP SIGNATURE-----

--nextPart2328398.XAFRqVoOGU--



