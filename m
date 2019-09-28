Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7E8C0ED2
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Sep 2019 02:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfI1ADZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Sep 2019 20:03:25 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35227 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfI1ADZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Sep 2019 20:03:25 -0400
Received: by mail-io1-f67.google.com with SMTP id q10so21225943iop.2
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2019 17:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pallissard.net; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=65qUV7T0+sz94TxaONHn4XF0brEiWDiInNEL+s0/Ck0=;
        b=JsOBkFy9A+g3/Y/KbuUubTADt1xxgU6YA3SUfilwOZP+wSHHvTDeROKNBe4EEd1MZH
         geeXjkodOGrp+lgHZzGU9F8/PQ46vW0lLH4JeF5FixXaagWb40jM+x1JhaYfhlssmLVV
         vY9efQUg3MCMM/1uQHOJ2eJkBpZei32w+Fkm8ZCTrdsXbqcg5IvRznGiDqK0k01GO7vh
         YcH0F7EGMzqDc2oWYmtlQNzSoWPIhuXoBM4W+PJcI1rN+3pKGfSjuckcOmlXx/jQB5Kp
         u0SjfgudBnLXQ51hfDNqiScL8k+iiU7ugOVMREoid7sa6kIRjfMBmUTQgknORYBx+wRh
         BQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=65qUV7T0+sz94TxaONHn4XF0brEiWDiInNEL+s0/Ck0=;
        b=OxxH/sustizGf7ihaLfcQCOCSjDVwngX76EvdUgPNh6U2Rr46/3K/6+Ce9AbjKiLWG
         1J4IWEJ1nuXXMWmRErN6fDq1TuHOn3+w56vTotronFd194xhPRhH0azM8RsJLdC5NdXa
         o1scB+bvJJQ2f1UzKx+/a4XKXtjD1WA59ufKapz1t+8eBG2oGiOcLGOU+8LcNbx0GIua
         W/b0CeAaAODVj1K5ZuVmADNQD2sV8UXIx2PqqwSy29MD5U3FBRlofdzT2ygTn6mhIeIt
         B5EtcteTqfdDourt0r4s3RCKLcOuHZ0CWbB4qeJxNWmfjzoVM4RQdEJ7nIVADz5nSatX
         yaDw==
X-Gm-Message-State: APjAAAXnshnleBcUXzLx1uF6NMaQ9NBgerDw3St1qUVQvgzyoL5EajH3
        An90lNRGz1jQ22cxrSnkVQJDkd7+hQc=
X-Google-Smtp-Source: APXvYqxA9VOLldHjWH0vSZfNugRXnq2ynCCuT+/IzPCDltD8wW2AbC9R/A4kTunQxs9qUYbktXwIVQ==
X-Received: by 2002:a92:c530:: with SMTP id m16mr8174909ili.44.1569629003299;
        Fri, 27 Sep 2019 17:03:23 -0700 (PDT)
Received: from mail.matt.pallissard.net (149.174.239.35.bc.googleusercontent.com. [35.239.174.149])
        by smtp.gmail.com with ESMTPSA id s201sm3344136ios.83.2019.09.27.17.03.22
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 17:03:22 -0700 (PDT)
Date:   Fri, 27 Sep 2019 17:03:19 -0700
From:   "Pallissard, Matthew" <matt@pallissard.net>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [UNRESOLVED] Re: errors found in extent allocation tree or chunk
 allocation after power failure
Message-ID: <20190928000319.3vdv2kbxpcs5kdyj@matt-laptop-p01>
References: <20190925144959.p4xyyhn2d2sajxjj@matt-laptop-p01>
 <CAJCQCtQwHRVs+XwnnUcktGcaRabZGG-UxS4o=g9y_MCiD4yG9Q@mail.gmail.com>
 <20190925193434.ieyj4oo6vkxmjtnw@matt-laptop-p01>
 <CAJCQCtQKypCbxksq5+XCwRy8enPkfZBaOgzS0SN2un+A1GELtA@mail.gmail.com>
 <20190925213231.kaqlq4ph3kgfgs5q@matt-laptop-p01>
 <20190928000127.gnd5i4q4jqz4ompy@matt-laptop-p01>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nhokoa2gwnnkpfks"
Content-Disposition: inline
In-Reply-To: <20190928000127.gnd5i4q4jqz4ompy@matt-laptop-p01>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--nhokoa2gwnnkpfks
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On 2019-09-27T17:01:27, Pallissard, Matthew wrote:
>=20
> On 2019-09-25T14:32:31, Pallissard, Matthew wrote:
> > On 2019-09-25T15:05:44, Chris Murphy wrote:
> > > On Wed, Sep 25, 2019 at 1:34 PM Pallissard, Matthew <matt@pallissard.=
net> wrote:
> > > > On 2019-09-25T13:08:34, Chris Murphy wrote:
> > > > > On Wed, Sep 25, 2019 at 8:50 AM Pallissard, Matthew <matt@palliss=
ard.net> wrote:
> > > > > >
> > > > > > Version:
> > > > > > Kernel: 5.2.2-arch1-1-ARCH #1 SMP PREEMPT Sun Jul 21 19:18:34 U=
TC 2019 x86_64 GNU/Linux
> > > > >
> > > > > You need to upgrade to arch kernel 5.2.14 or newer (they backport=
ed the fix first appearing in stable 5.2.15). Or you need to downgrade to 5=
=2E1 series.
> > > > > https://lore.kernel.org/linux-btrfs/20190911145542.1125-1-fdmanan=
a@kernel.org/T/#u
> > > > >
> > > > > That's a nasty bug. I don't offhand see evidence that you've hit =
this bug. But I'm not certain. So first thing should be to use a different =
kernel.
> > > >
> > > > Interesting, I'll go ahead with a kernel upgrade as that easy enoug=
h.
> > > > However, that looks like it's related to a stacktrace regarding a h=
ung process.  Which is not the original problem I had.
> > > > Based on the output in my previous email, I've been working under t=
he assumption that there is a problem on-disk.  Is that not correct?
> > >
> > > That bug does cause filesystem corruption that is not repairable.
> > > Whether you have that problem or a different problem, I'm not sure.
> > > But it's best to avoid combining problems.
> > >
> > > The file system mounts rw now? Or still only mounts ro?
> >=20
> > It mounts RW, but I have yet to attempt an actual write.
> >=20
> >=20
> > > I think most of the errors reported by btrfs check, if they still exi=
st after doing a scrub, should be repaired by 'btrfs check --repair' but I =
don't advise that until later. I'm not a developer, maybe Qu can offer some=
 advise on those errors.
> >=20
> >=20
> > > > > Next, anytime there is a crash or powerfailur with Btrfs raid56, =
you need to do a complete scrub of the volume. Obviously will take time but=
 that's what needs to be done first.
> > > >
> > > > I'm using raid 10, not 5 or 6.
> > >
> > > Same advice, but it's not as important to raid10 because it doesn't h=
ave the write hole problem.
> >=20
> >=20
> > > > > OK actually, before the scrub you need to confirm that each drive=
's SCT ERC time is *less* than the kernel's SCSI command timer. e.g.
> > > >
> > > > I gather that I should probably do this before any scrub, be it rai=
d 5, 6, or 10.  But, Is a scrub the operation I should attempt on this raid=
 10 array to repair the specific errors mentioned in my previous email?
> > >
> > > Definitely deal with the timing issue first. If by chance there are b=
ad sectors on any of the drives, they must be properly reported by the driv=
e with a discrete read error in order for Btrfs to do a proper fixup. If th=
e times are mismatched, then Linux can get tired waiting, and do a link res=
et on the drive before the read error happens. And now the whole command qu=
eue is lost and the problem isn't fixed.
> >=20
> > Good to know, that seems like a critical piece of information.  A few s=
earches turned up this page, https://wiki.debian.org/Btrfs#FAQ.
> >=20
> > Should this be noted on the 'gotchas' or 'getting started page as well?=
  I'd be happy to make edits should the powers that be allow it.
> >=20
> >=20
> > > There are myriad errors and the advice I'm giving to scrub is a safe =
first step to make sure the storage stack is sane - or at least we know whe=
re the simpler problems are. And then move to the less simple ones that hav=
e higher risk.  It also changed the volume the least. Everything else, like=
 balance and chunk recover and btrfs check --repair - all make substantial =
changes to the file system and have higher risk of making things worse.
> >=20
> > This sounds sensible.
> >=20
> >=20
> > > In theory if the storage stack does exactly what Btrfs says, then at =
worst you should lose some data, but the file system itself should be consi=
stent. And that includes power failures. The fact there's problems reported=
 suggests a bug somewhere - it could be Btrfs, it could be device mapper, i=
t could be controller or drive firmware.
> >=20
> > I'll go ahead with a kernel upgrade/make sure the timing issues are squ=
ared away.  Then I'll kick off a scrub.
> >=20
> > I'll report back when the scrub is complete or something interesting ha=
ppens.  Whichever comes first.
>=20
> As a followup;
> 1. I took care of the timing issues
> 2. ran a scrub.
> 3. I ran a balance, it kept failing with about 20% left
>   - stacktraces in dmesg showed spinlock stuff
>=20
> 3. got I/O errors on one file during my final backup, (
>   - post-backup hashsums of everything else checked out
>   - the errors during the copy were csum mismatches should anyone care
>=20
> 4. ran a bunch of potentially disruptive btrfs check commands in alphabet=
ical order because "why not at this point?"
>   - they had zero affect as far as I can tell, all the same files were re=
adable, the btrfs check errors looked identical (admittedly I didn't put th=
em side by side)
>=20
> 5. re-provisioned the array, restored from backups.
>=20
> As I thought about it, it may have not been an issue with the original po=
wer outage.  I only ran a check after the power outage.  My array could hav=
e had an issue due to a previous bug. I was on a 5.2x kernel for several we=
eks under high load.  Anyway, there are enough unknowns to make a root caus=
e analysis not worth my time.
>=20
> Marking this as unresolved folks in the future who may be looking for ans=
wers.
>=20

Man, I should have read that over one more time for typos. Oh well.

Matt Pallissard

--nhokoa2gwnnkpfks
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTvIUMPApUGn6YFkXl1uof+t048SQUCXY6jRwAKCRB1uof+t048
SRdmAP4q0D+hRGj2jSVJbNSoY31skN3heliAaU+LBjoj0zY3XQD/djyrSsfWxmsY
1Ap8COAtofgz9qZAhrmmkz2p6kZNIwE=
=pRf3
-----END PGP SIGNATURE-----

--nhokoa2gwnnkpfks--
