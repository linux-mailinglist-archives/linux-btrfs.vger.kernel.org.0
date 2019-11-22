Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E35DC107B42
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Nov 2019 00:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfKVXVg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Nov 2019 18:21:36 -0500
Received: from mout.gmx.net ([212.227.15.15]:44941 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfKVXVf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Nov 2019 18:21:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574464894;
        bh=WxQI0hA3eWrPoX6AeexBq16nw88yQyZ9fYJL96GLvxw=;
        h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
        b=NPRo2MUasi5IGH2zFVbvUt1h3xCeL41i4jDQp+X2WgdQGfo6rOdWB8K8La6ZRfeCF
         Tw53dXcqWMOYg+LI5eB2S4Lgakkd8p+TIu45l1mX2NlS91VMwPyWEqvpQDad+9aZua
         KkurtS9td1TMNyk++aqkn3jGjS7rBY3xGGqdm2Qs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from thetick.localnet ([95.90.202.39]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIdeR-1ie2rA3LSn-00Ei6v for
 <linux-btrfs@vger.kernel.org>; Sat, 23 Nov 2019 00:21:33 +0100
From:   Marc Joliet <marcec@gmx.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: freezes during snapshot creation/deletion -- to be expected? (Was: Re: btrfs based backup?)
Date:   Sat, 23 Nov 2019 00:21:18 +0100
Message-ID: <4477543.Lpmng1OQLe@thetick>
In-Reply-To: <CAJCQCtQFw=ThyCQGdG4nXX2r9--Jv3W9KWdFKLv3Gy-sYw=Xrg@mail.gmail.com>
References: <20191112183425.GA1257@tik.uni-stuttgart.de> <6893661.AATI4FVq6M@thetick> <CAJCQCtQFw=ThyCQGdG4nXX2r9--Jv3W9KWdFKLv3Gy-sYw=Xrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2503782.fJGFplznbQ"; micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Provags-ID: V03:K1:0CDrf+xG/CCKtEApK9BkiCGIW/8+JPdj/TUMUJcUaNWxtnYxgoG
 EFEp0334RXEjs8NDx5IBqb405R9XWpe5XHwnP3t982W3/2XvUwFIjQBsh3u14yYDubOfFxj
 rJQlucRelhcpFFSU0y4O3BsO9RXjM69KCxL04KSKM72JxazPiktn2APiwFm5+qIAzNxfiiE
 QDgpUtcmsl8COURp7aNzg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UOB0tRpVRsk=:Xny4aAsWqT9ossIzbsFnmj
 S28dQG7ZJKkQDGToBWm0mI/RMmpl+Qjotz0f3pXvLnl5wev+PQlzy0qlq4G7KGkjeg7ty7bZ1
 qdKoivZ+flxoWlqWtHdza4OrSh1bN+ZIX9wOb801Ftes9if+biTcGa5GzjFNlhHFZqCflQLU5
 m9qPFOmp5Vp25KfhstX5mZgdT0COCp/07jI+gHL2VFnkaiGlosy8RqvJJXyJwpgovGWQnGqX8
 y2nW01QWbAPQkFY4vSdTQzr5Awz55upUGN+4qLHfJO8rsf65KaxZw1HEIkFWDNUtUE1oBs8dw
 L4P+7T1F6W/Pzz4U5FeUFn1UzSYVvJMnI4+rgj/r3NUBswCXsUdy/KZBl7ktRCj5oMdnmdL08
 BDnRDa6FDkeXhfa8/zo2bF0AXp5A5ENa1MPGoEK1KcJXO3pTmjRr7t3tH/WXbKXlCSwDOGIqQ
 t6JohpbqDFOAXRccFroWz6QmRkZ+6lt91C+ZBJeclu4pU0QFnw31kBbpD3TXkZIPak/0J/SbR
 dLcQ1l25Mw3sdFSQyoZgGZUK60PIrAyaYlQxridogfMwK5mA6AEU7Ut/bYcr8A0AOKNHoRLxi
 +vhfIQr0vaNk2oaP5F00leKzWFuupzF1yd5tZSXGH41UR748dw0MOv2YFfFwWb2vAaawX/YTF
 jh7Xqh1dC/1768+FpL9JtXgpwjoMsJIyRLfS9gX5kqrZhEIuAnxy+QP+bMcLx5/U3jnd8Skis
 C0SqBVzt8PzmlwKYqUj8widF82DYZzRlVwMeKzf4WZAmU5kviV+mTmlw0hEueYt6ySAJpHcYe
 eZKI2iU7rQl+dnwx+MOirj9aWYgHOrrDghduAPXr0U/KmdVEh49oSTpBqAr5h2s6yDdoOsmaN
 24XqBuyn58goATCLJeLJfu6brciRKSeZDk4+jCboRTAscCjXJfLR/abENdHgr5+ObNhb7+0Qh
 zsUJ5orW4+2Nc+ntznjCxPuHLDejcRKFSuKgYrYbGkEZv3LzB5pKoDbA6UV9iubAtE/GPR54e
 MEUKSkSqKJMLpw6+KQZxp6swBUJekAR5C2YSbQjI9LiF30EWs1Gu2ZzcA3kng86kJjJHrmI2F
 IVViacVoHqGqaa0C/AYf5N5NtpUL8WdWpC/XO87D0ca5/xf2b3tF3AomnMn+vLrNRZs9DZ3Ps
 AJymqd5wW/NCwO4Owe8p3emR5Kh+JJ38N2f8X9mCwM+Ln+MCb6lqBNo1DjhBq7Y2bS+QAnEmn
 CsVlYuyopDGk3Qs9k8SzfdUJHO3KCqwY5D7U1Ug==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--nextPart2503782.fJGFplznbQ
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Am Freitag, 22. November 2019, 02:36:56 CET schrieb Chris Murphy:
> On Thu, Nov 21, 2019 at 3:39 PM Marc Joliet <marcec@gmx.de> wrote:
> > On a side note, I am also really annoyed by the lockups caused by qgro=
ups.
> >  On my Gentoo systems (which use btrbk) I have it disabled for that
> > reason, but I left it on on my openSUSE laptop (a Dell XPS 13 9360),
> > which locks up for about 15-30 minutes while cleaning up snapshots a f=
ew
> > times a week (usually after reboots or after "zypper dup").
>
> 15 seconds is not at all acceptable on a desktop system, 15 minutes is
> atrocious. A computer that appears to hang for 15 seconds, it is
> completely reasonable for ordinary users to consider has totally
> faceplanted, will not recover, and to force power off. The
> distribution really needs to do something about that kind of negative
> user experience.

Sadly, I can't say if it's better without snapshotting /home, because I ha=
dn't
accumulated many / snapshots at that point in time.  It might have gotten
worse even with only / being snapshotted.  But like I said, I'll experimen=
t
with configuring snapper before blaming SUSE.  I believe the installation =
even
recommends against snapshotting /home, but hey, I wanted to do it anyway :=
-) .

But to be precise, it's not locked up continuously during snapshot deletio=
n.
Occasionally I'll be able to operate my desktop for a few seconds, and if =
I
leave top running in a GUI terminal (in my case konsole), I'll see it upda=
ting
(almost) the entire time.  My guess (emphasis on *guess*) is that the qgro=
ups
update is holding some lock that is preventing other I/O from finishing, t=
hus
locking up any application that wants to write to disk and isn't doing so
concurrently (maybe Plasma is blocking on fsync() at the time?).

> And by the way, I've recently done some unprivileged compilations of
> webkitgtk, with default options that cause n cores +2 to be used,
> eating all available RAM and swap, and quickly totally hanging the
> system while swap thrashing and basically acting like a fork bomb. I'm
> using Btrfs for the rootfs as well as user home for this compile, and
> have done hundreds of forced power offs during these events and have
> seen exactly zero corruptions or Btrfs complaints. So at least there's
> that, however unscientific a sample that is.

My experience has also been that forced reboots don't cause any damage, ev=
en
though I usually only have to do them rarely [0].  I mean, with COW it sho=
uld
be expected to be safe.

[0] I have two main situations where this happens: The first are RCU stall=
s
that cause my desktop to get hung up (happens during bootup occasionally,
shortly between the boot loader and the login screen), but also recently
started affecting my home server.  The second only affects my home server =
(a
used small business server), namely a wonky e1000e NIC, which I only recen=
tly
learned are sometimes buggy are known for causing servers to crash.  The
workaround is apparently to turn off TSO and GSO, and sometimes also GRO, =
but
I've been able to get away with only the first two without experiencing an=
y
more crashes thus far.  Interestingly enough the RCU stalls happened short=
ly
after I did that.

Greetings
=2D-
Marc Joliet
=2D-
"People who think they know everything really annoy those of us who know w=
e
don't" - Bjarne Stroustrup

--nextPart2503782.fJGFplznbQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQS2YUPDQn1ADQEoj0uXgvYOs+E2oAUCXdhtbgAKCRCXgvYOs+E2
oJsUAQCUrgDbDQlSaYDPfy1oHK9VTR1wpNDaNOohqOUQrYAxHAD/aH8cEFokPt+O
/ih5nXKfjN1t1mofbyYtuUUriEs2nQA=
=y6Rq
-----END PGP SIGNATURE-----

--nextPart2503782.fJGFplznbQ--



