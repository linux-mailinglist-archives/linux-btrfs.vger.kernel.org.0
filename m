Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC1917D456
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Mar 2020 16:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgCHPMB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Mar 2020 11:12:01 -0400
Received: from mout.gmx.net ([212.227.17.21]:54063 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbgCHPMB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 8 Mar 2020 11:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583680319;
        bh=oGk656mVixBja9YTJT4I6WVCwDe4l5rGNTktboyjJ5g=;
        h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
        b=eJXEp/q962UNxIEimq7v5ZjpjicA8KumeYwOQNcB6chhA31XtMcTo6VDdeuQNqwEc
         KQesBJ4LMtDoLAzn3ZAk8gft+YICdnmpJbtlm42wMS14Pg/P2LIQWyQMR/lxhDUHrH
         MiW1vZCreQyK/4gjLaVKyfyHacutQv4f1Zu64BDc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from thetick.localnet ([95.90.202.24]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUowb-1ikOBa3AUD-00Qj1O for
 <linux-btrfs@vger.kernel.org>; Sun, 08 Mar 2020 16:11:59 +0100
From:   Marc Joliet <marcec@gmx.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: freezes during snapshot creation/deletion -- to be expected? (Was: Re: btrfs based backup?)
Date:   Sun, 08 Mar 2020 16:11:52 +0100
Message-ID: <2475371.lGaqSPkdTl@thetick>
In-Reply-To: <4477543.Lpmng1OQLe@thetick>
References: <20191112183425.GA1257@tik.uni-stuttgart.de> <CAJCQCtQFw=ThyCQGdG4nXX2r9--Jv3W9KWdFKLv3Gy-sYw=Xrg@mail.gmail.com> <4477543.Lpmng1OQLe@thetick>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2306082.XAFRqVoOGU"; micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Provags-ID: V03:K1:Cjf3uGeUaGimbHfbcXyBTpWtN9hxYqXZLtAo6htUAwZ2eXR9CV7
 w2tZnf2eK1WKhnN81f1OdgYN1gf/7mfaspRriBj3LvcsAbrW9bIGzFB/lqYjQFb6EUB6E1l
 i24h80bGZoVH5mQOshbvQeoxIxk2H+MXHyjOjEsyP1Mkbpg1DBJSF4a4q5OOOtN0Sy+5axd
 7/RiifRVZnHWG/JwhM7WA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7tnYxKuQg2U=:yzqJTP6KwT9W2OYdCgLZ7a
 wqMtIx7LNbDs/9kBVpL+DAc5ciO+Qh8oVwrjYvyGfJFJ/fj/MY5G/K6S735rtlr/dAPUFCZKx
 HtPLpYboeZD2OWMS3lu2OIVoYlM40ozp+EqcGChAVTpZkYl+ETdSxFeDqQHOMvlHOip3v+P4S
 3lBUvg3fXdud6xoNrXhpAPmT0pItjw8/JotuSTcuGZ7L+Xri2ktJ7CTVrTZ3NVlWPHPdiaKoB
 uOLxsVBiwbXFyl8qbExMqg8BFXVi8oIqcd2uX1ms1ecbn7TirANn2QTP+wV3nMHYnQbx+Z+YQ
 hTO4fXdA8CUiRo3VJn6OfmPpffCwN2L4Jr4/yjwCLS0JRlSxm6grmtXvJlIlaYWiVKuc01V0W
 JAuHH/cUKlzrOp89KPI2EtgDW69/nK+bhfn/jQs5bH/WeL9X9Il0jvaMsGVgq6RwZlJRSRDO8
 MBiXJjni/zJFbYgFJPBkPWXWqpl7bLKaoUlmUN2abBn7LKnlJm9Fy7k/uPbkM2QbO2YNqJB3L
 rkul+ouVWzPBo8VzZfeIkFTczAV/A31juRuAZplcdIt5z34bnNtcvFNgP2T1uhsNhF5gTxNN1
 41NMtOqM1f+nQXd/PiahnUZhy0Ndq+t07xQ7tDhjSCHThVs2f8wGBu0rdo8+IWGStUr0zW4eD
 u+FJ8OrHS/YY/relRE0mJNIEhsMZ7wNR88fuf9YJ2tXk7lZvJ+1uHbiIAxVxR+DYjUz4VIbW8
 xqznmy7Z75MsgiAvFI9nmTxkU9StsQsr0ocX8UA/pBjxF3sPFk2NjI4KtK8SgM2wsX9RfOC0l
 9YZdYeWjEYsxStAq6Q6gjwgbi8Rv8CFC0qOASePdFDinY3Z9ndeCoqW9AjQ+PxVK37BXWE8RQ
 L5awd5+HUlhBreWe8hGlx+IzQit+E2nFuiieSvPsO1wj58gvg6uG4/d505oZhOMRR8/uc9cDE
 RRVtSRDL4JNnb17HUuYXr39GNiyA5xWnAn1Ezo6FuN64V5YIoTL9vyYtDhm/OyBpS2J4cZTTu
 s7jhR5XF63EayvPzaW8ow3Dc+jL7d0zfYZOx+qbdmvr7fi7g3t24EyWVaiHl4//+cvGos6YEk
 Fppn4GLwVWwsn5V1t/bTjnyNCBPBuiE2n397sX9ZQcIc1WtqwM0e2DANfPy6jqY9KRXIhM4Pb
 2mdLKa+QE6R5Q/9gmJ+RBepZMbnBtK0xroL9rwbe03XnM6gCVAEMHD9kzSTDBOmMOCw2ZeVZ8
 chTKpPhxGkrjEGMnE
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--nextPart2306082.XAFRqVoOGU
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Am Samstag, 23. November 2019, 00:21:18 CET schrieben Sie:
> Am Freitag, 22. November 2019, 02:36:56 CET schrieb Chris Murphy:
> > On Thu, Nov 21, 2019 at 3:39 PM Marc Joliet <marcec@gmx.de> wrote:
> > > On a side note, I am also really annoyed by the lockups caused by
> > > qgroups.
> > > On my Gentoo systems (which use btrbk) I have it disabled for that
> > > reason, but I left it on on my openSUSE laptop (a Dell XPS 13 9360),
> > > which locks up for about 15-30 minutes while cleaning up snapshots a=
 few
> > > times a week (usually after reboots or after "zypper dup").
> >
> > 15 seconds is not at all acceptable on a desktop system, 15 minutes is
> > atrocious. A computer that appears to hang for 15 seconds, it is
> > completely reasonable for ordinary users to consider has totally
> > faceplanted, will not recover, and to force power off. The
> > distribution really needs to do something about that kind of negative
> > user experience.
>
> Sadly, I can't say if it's better without snapshotting /home, because I
> hadn't accumulated many / snapshots at that point in time.  It might hav=
e
> gotten worse even with only / being snapshotted.  But like I said, I'll
> experiment with configuring snapper before blaming SUSE.  I believe the
> installation even recommends against snapshotting /home, but hey, I want=
ed
> to do it anyway :-) .
>
> But to be precise, it's not locked up continuously during snapshot delet=
ion.
> Occasionally I'll be able to operate my desktop for a few seconds, and i=
f I
> leave top running in a GUI terminal (in my case konsole), I'll see it
> updating (almost) the entire time.  My guess (emphasis on *guess*) is th=
at
> the qgroups update is holding some lock that is preventing other I/O fro=
m
> finishing, thus locking up any application that wants to write to disk a=
nd
> isn't doing so concurrently (maybe Plasma is blocking on fsync() at the
> time?).

So just to follow up on this, reducing the total number of snapshots and
increasing the time between their creation from hourly to once every six h=
ours
did help a *little* bit.  However, about a week ago I decided to try an
experiment and added the "autodefrag" mount option (which I don't usually =
do
on SSDs), and that helped *massively*.  Ever since, snapper-cleanup.servic=
e
runs without me noticing at all!

[ What made me try it was that booting the laptop and logging in started
getting really slow and top was showing several btrfs-endio threads hoggin=
g
the CPU, *before* snapper-cleanup.service or anything else specific to btr=
fs
was running (their activity usually coincided with KDE Baloo activity), i.=
e.,
general I/O was performing badly. ]

Greetings
=2D-
Marc Joliet
=2D-
"People who think they know everything really annoy those of us who know w=
e
don't" - Bjarne Stroustrup

--nextPart2306082.XAFRqVoOGU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQS2YUPDQn1ADQEoj0uXgvYOs+E2oAUCXmULOAAKCRCXgvYOs+E2
oDvkAP9fU2wEjCazoCnH4OQEpBJ8KvR2PBgsEqoMY7jhxf7wZAEAoHkurPwZny7W
nhwW+nvooOGdnh2ZzvEkPTi7pNa6OQc=
=G2W9
-----END PGP SIGNATURE-----

--nextPart2306082.XAFRqVoOGU--



