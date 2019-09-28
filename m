Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA475C0ECE
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Sep 2019 02:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfI1ABe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Sep 2019 20:01:34 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35745 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfI1ABd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Sep 2019 20:01:33 -0400
Received: by mail-io1-f65.google.com with SMTP id q10so21215916iop.2
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2019 17:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pallissard.net; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+v9TSJjajiT/bRB5NTPXDTAR5ymgJW0VvacBThnAUwU=;
        b=QhsRLjHlLnbc8+CGrgTxE2evVIEq1u01VWQtPrlHywGRxu2ARRNN2WTuOwJ7JNYAEK
         Lzx66QyLtXzdw2MCw8vV1xcLDXpHk597ekF7cycW26WoGNYi4ncH0nHmpb5f0N+3tui2
         Hiil2pFV90gK0S85OAYHUA2BDFAB7dxIG35unvUKBGqlVqffoIrWbKjg4ObEiN3PLbwL
         ChxQnPQPA3AzLss7Pw1OKOC0WqrS8QdktBAKgbz6IniVx8kd/+Z8RB60gDKwchHdWpMh
         ZGMrdZjmrzV8ytseXjbSnGvwpMJwSFELB08cC5vN525Nbi2p5IwgD3IkrLni4G6N5PRo
         5Diw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+v9TSJjajiT/bRB5NTPXDTAR5ymgJW0VvacBThnAUwU=;
        b=kaQLsOC/qUW15W0m+e0sjiG+mdD5h513CnRCNTugDbRNmrpQ1f9gaqE0BvwyV0ri+F
         fnlKMl8pBKp7ZjWtqC3diCr5l15tWYCFlXEOOUf2UpFRGeJswcVVO0KgFG2c2vmZJp/j
         i/429OKP6dc3zMy7+jvx52iZwxlaJgl0kknUf29Y1KyLj3rrzT9X2boP7TIcvB0yky/m
         L1hcgeCl5jwFIFaqtsz7DjjbEUkXUHjVPdlVC8Ydwl+W3CQPbp99Z7jvRBv9aqS9e0ek
         1shZu9auCMYgX5mi8FPXNAFcszkrAhZW8OENmTj/YbJ41tAqml8H0mckys1geOBqP3cE
         sk0Q==
X-Gm-Message-State: APjAAAUf0XdpB0FOA6OR4C9Nt3UDMpzWl40PzG1Qpd/bIboGkho0+uwq
        0yavg4Tw9Y3b0ynbpeheiLezHwiytJ8=
X-Google-Smtp-Source: APXvYqypEq7ZA0aLOEg/b8cnrF7cXgVkkjNuAbW2xGEZwhW/whNGHlfcM7xiitHN8DRUYdZUUcOl0Q==
X-Received: by 2002:a02:b60f:: with SMTP id h15mr10699402jam.73.1569628892039;
        Fri, 27 Sep 2019 17:01:32 -0700 (PDT)
Received: from mail.matt.pallissard.net (149.174.239.35.bc.googleusercontent.com. [35.239.174.149])
        by smtp.gmail.com with ESMTPSA id a13sm1678908ilh.65.2019.09.27.17.01.30
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 17:01:31 -0700 (PDT)
Date:   Fri, 27 Sep 2019 17:01:27 -0700
From:   "Pallissard, Matthew" <matt@pallissard.net>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: [UNRESOLVED] Re: errors found in extent allocation tree or chunk
 allocation after power failure
Message-ID: <20190928000127.gnd5i4q4jqz4ompy@matt-laptop-p01>
References: <20190925144959.p4xyyhn2d2sajxjj@matt-laptop-p01>
 <CAJCQCtQwHRVs+XwnnUcktGcaRabZGG-UxS4o=g9y_MCiD4yG9Q@mail.gmail.com>
 <20190925193434.ieyj4oo6vkxmjtnw@matt-laptop-p01>
 <CAJCQCtQKypCbxksq5+XCwRy8enPkfZBaOgzS0SN2un+A1GELtA@mail.gmail.com>
 <20190925213231.kaqlq4ph3kgfgs5q@matt-laptop-p01>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tvjpgbxnyyvagxfp"
Content-Disposition: inline
In-Reply-To: <20190925213231.kaqlq4ph3kgfgs5q@matt-laptop-p01>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--tvjpgbxnyyvagxfp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On 2019-09-25T14:32:31, Pallissard, Matthew wrote:
> On 2019-09-25T15:05:44, Chris Murphy wrote:
> > On Wed, Sep 25, 2019 at 1:34 PM Pallissard, Matthew <matt@pallissard.ne=
t> wrote:
> > > On 2019-09-25T13:08:34, Chris Murphy wrote:
> > > > On Wed, Sep 25, 2019 at 8:50 AM Pallissard, Matthew <matt@pallissar=
d.net> wrote:
> > > > >
> > > > > Version:
> > > > > Kernel: 5.2.2-arch1-1-ARCH #1 SMP PREEMPT Sun Jul 21 19:18:34 UTC=
 2019 x86_64 GNU/Linux
> > > >
> > > > You need to upgrade to arch kernel 5.2.14 or newer (they backported=
 the fix first appearing in stable 5.2.15). Or you need to downgrade to 5.1=
 series.
> > > > https://lore.kernel.org/linux-btrfs/20190911145542.1125-1-fdmanana@=
kernel.org/T/#u
> > > >
> > > > That's a nasty bug. I don't offhand see evidence that you've hit th=
is bug. But I'm not certain. So first thing should be to use a different ke=
rnel.
> > >
> > > Interesting, I'll go ahead with a kernel upgrade as that easy enough.
> > > However, that looks like it's related to a stacktrace regarding a hun=
g process.  Which is not the original problem I had.
> > > Based on the output in my previous email, I've been working under the=
 assumption that there is a problem on-disk.  Is that not correct?
> >
> > That bug does cause filesystem corruption that is not repairable.
> > Whether you have that problem or a different problem, I'm not sure.
> > But it's best to avoid combining problems.
> >
> > The file system mounts rw now? Or still only mounts ro?
>=20
> It mounts RW, but I have yet to attempt an actual write.
>=20
>=20
> > I think most of the errors reported by btrfs check, if they still exist=
 after doing a scrub, should be repaired by 'btrfs check --repair' but I do=
n't advise that until later. I'm not a developer, maybe Qu can offer some a=
dvise on those errors.
>=20
>=20
> > > > Next, anytime there is a crash or powerfailur with Btrfs raid56, yo=
u need to do a complete scrub of the volume. Obviously will take time but t=
hat's what needs to be done first.
> > >
> > > I'm using raid 10, not 5 or 6.
> >
> > Same advice, but it's not as important to raid10 because it doesn't hav=
e the write hole problem.
>=20
>=20
> > > > OK actually, before the scrub you need to confirm that each drive's=
 SCT ERC time is *less* than the kernel's SCSI command timer. e.g.
> > >
> > > I gather that I should probably do this before any scrub, be it raid =
5, 6, or 10.  But, Is a scrub the operation I should attempt on this raid 1=
0 array to repair the specific errors mentioned in my previous email?
> >
> > Definitely deal with the timing issue first. If by chance there are bad=
 sectors on any of the drives, they must be properly reported by the drive =
with a discrete read error in order for Btrfs to do a proper fixup. If the =
times are mismatched, then Linux can get tired waiting, and do a link reset=
 on the drive before the read error happens. And now the whole command queu=
e is lost and the problem isn't fixed.
>=20
> Good to know, that seems like a critical piece of information.  A few sea=
rches turned up this page, https://wiki.debian.org/Btrfs#FAQ.
>=20
> Should this be noted on the 'gotchas' or 'getting started page as well?  =
I'd be happy to make edits should the powers that be allow it.
>=20
>=20
> > There are myriad errors and the advice I'm giving to scrub is a safe fi=
rst step to make sure the storage stack is sane - or at least we know where=
 the simpler problems are. And then move to the less simple ones that have =
higher risk.  It also changed the volume the least. Everything else, like b=
alance and chunk recover and btrfs check --repair - all make substantial ch=
anges to the file system and have higher risk of making things worse.
>=20
> This sounds sensible.
>=20
>=20
> > In theory if the storage stack does exactly what Btrfs says, then at wo=
rst you should lose some data, but the file system itself should be consist=
ent. And that includes power failures. The fact there's problems reported s=
uggests a bug somewhere - it could be Btrfs, it could be device mapper, it =
could be controller or drive firmware.
>=20
> I'll go ahead with a kernel upgrade/make sure the timing issues are squar=
ed away.  Then I'll kick off a scrub.
>=20
> I'll report back when the scrub is complete or something interesting happ=
ens.  Whichever comes first.

As a followup;
1. I took care of the timing issues
2. ran a scrub.
3. I ran a balance, it kept failing with about 20% left
  - stacktraces in dmesg showed spinlock stuff

3. got I/O errors on one file during my final backup, (
  - post-backup hashsums of everything else checked out
  - the errors during the copy were csum mismatches should anyone care

4. ran a bunch of potentially disruptive btrfs check commands in alphabetic=
al order because "why not at this point?"
  - they had zero affect as far as I can tell, all the same files were read=
able, the btrfs check errors looked identical (admittedly I didn't put them=
 side by side)

5. re-provisioned the array, restored from backups.

As I thought about it, it may have not been an issue with the original powe=
r outage.  I only ran a check after the power outage.  My array could have =
had an issue due to a previous bug. I was on a 5.2x kernel for several week=
s under high load.  Anyway, there are enough unknowns to make a root cause =
analysis not worth my time.

Marking this as unresolved folks in the future who may be looking for answe=
rs.

Matt Pallissard

--tvjpgbxnyyvagxfp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTvIUMPApUGn6YFkXl1uof+t048SQUCXY6i1AAKCRB1uof+t048
SXmrAP9woPs8oXkzKybcLZwmPZiaXa/K+Z048VDbATCwAVQl5QEAlwkxhBsGf574
DU4VnJ1ANG4K5a8yOdz27LASRNuUBww=
=Vnu6
-----END PGP SIGNATURE-----

--tvjpgbxnyyvagxfp--
