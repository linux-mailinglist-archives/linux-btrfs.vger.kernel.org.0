Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B95BBE73E
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2019 23:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfIYVcj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Sep 2019 17:32:39 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44421 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbfIYVcj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Sep 2019 17:32:39 -0400
Received: by mail-io1-f66.google.com with SMTP id j4so718330iog.11
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2019 14:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pallissard.net; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j9G377CW/Ww+ABoaDkO3lj+n2byT7t0eYmIIpvSSIRE=;
        b=C1C7R54FENjSKXgx/RD5TeLUEbZ9xivCVgGqqAgQFuTmiUx/B1BTHGUvsuHG6TO3vl
         BUld9JCAh55L9uztZILiziQgUJwBcfWKT0VSIKOhsBR2zZrBS/UMgkTe09BPD3GksYSg
         jyzbAaDJSgsoIqC2s4UTsWgOgvJwEFSFAMfN1rWQXg5TOsVvW49i7EQQoGzmSNMneNSr
         CiFUqq09+6N7Q6gnSBNOwXDiR5hpDYbLy2Iod9a+C9kgjVafj/1MymUsPubUe11i54gd
         5pg1pPMbQzt04lyCYLp2jW5pK2py0+azkEfbcuXAR+1ZI9D1wWsttx9Y80HjEBD7QfXH
         gf0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j9G377CW/Ww+ABoaDkO3lj+n2byT7t0eYmIIpvSSIRE=;
        b=nZ73T4mUh2ombQyLESoPHYhwj1Y3f/SKl0f0fs4jlROa4J7gn31V8J27VkGuqnSTkB
         g5qrPRcahcLKFlU37Kt7ExOen7chSLt7wp1lpZaSWefhpJT00ilfJcsXjXPWIRLdenhA
         Hib7qbW6VoX6oW/ZZE2O557anVALJ7kn+spoDPkOcNSA84ecRimF0O0s7qUOTXAMfhyE
         Pf1yTZ+mRQP2/1yv2oLJtIvqZpb7/3zCxH5XQPy/xPDTT/rdxFOhgOpRuD8R6spxyANv
         MtpTXwpFn8JsSIRQm26wHREAO23y57e/2fzmOS10y/GHhSxknJAjNY22qq09fuMndIvC
         uGig==
X-Gm-Message-State: APjAAAXw7iwDJHxVBwDcwrwjyKVoeaE42ggYb7jPi6azzmyZX9bLOZKf
        BAZ+1oOSVlGgf4QEgNIqzmA28kSTP48=
X-Google-Smtp-Source: APXvYqyLZv65ObJ3wakv+BUCNgfxpgzgLnorRl6NnwXimzEWEyNf3Ekpj0LHVvyho6UBoeDPZETIsg==
X-Received: by 2002:a02:716a:: with SMTP id n42mr454681jaf.38.1569447157092;
        Wed, 25 Sep 2019 14:32:37 -0700 (PDT)
Received: from mail.matt.pallissard.net (149.174.239.35.bc.googleusercontent.com. [35.239.174.149])
        by smtp.gmail.com with ESMTPSA id v3sm561127ioh.51.2019.09.25.14.32.36
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 14:32:36 -0700 (PDT)
Date:   Wed, 25 Sep 2019 14:32:31 -0700
From:   "Pallissard, Matthew" <matt@pallissard.net>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: errors found in extent allocation tree or chunk allocation after
 power failure
Message-ID: <20190925213231.kaqlq4ph3kgfgs5q@matt-laptop-p01>
References: <20190925144959.p4xyyhn2d2sajxjj@matt-laptop-p01>
 <CAJCQCtQwHRVs+XwnnUcktGcaRabZGG-UxS4o=g9y_MCiD4yG9Q@mail.gmail.com>
 <20190925193434.ieyj4oo6vkxmjtnw@matt-laptop-p01>
 <CAJCQCtQKypCbxksq5+XCwRy8enPkfZBaOgzS0SN2un+A1GELtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="axzddf7khvybwhhq"
Content-Disposition: inline
In-Reply-To: <CAJCQCtQKypCbxksq5+XCwRy8enPkfZBaOgzS0SN2un+A1GELtA@mail.gmail.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--axzddf7khvybwhhq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 2019-09-25T15:05:44, Chris Murphy wrote:
> On Wed, Sep 25, 2019 at 1:34 PM Pallissard, Matthew <matt@pallissard.net> wrote:
> > On 2019-09-25T13:08:34, Chris Murphy wrote:
> > > On Wed, Sep 25, 2019 at 8:50 AM Pallissard, Matthew <matt@pallissard.net> wrote:
> > > >
> > > > Version:
> > > > Kernel: 5.2.2-arch1-1-ARCH #1 SMP PREEMPT Sun Jul 21 19:18:34 UTC 2019 x86_64 GNU/Linux
> > >
> > > You need to upgrade to arch kernel 5.2.14 or newer (they backported the fix first appearing in stable 5.2.15). Or you need to downgrade to 5.1 series.
> > > https://lore.kernel.org/linux-btrfs/20190911145542.1125-1-fdmanana@kernel.org/T/#u
> > >
> > > That's a nasty bug. I don't offhand see evidence that you've hit this bug. But I'm not certain. So first thing should be to use a different kernel.
> >
> > Interesting, I'll go ahead with a kernel upgrade as that easy enough.
> > However, that looks like it's related to a stacktrace regarding a hung process.  Which is not the original problem I had.
> > Based on the output in my previous email, I've been working under the assumption that there is a problem on-disk.  Is that not correct?
>
> That bug does cause filesystem corruption that is not repairable.
> Whether you have that problem or a different problem, I'm not sure.
> But it's best to avoid combining problems.
>
> The file system mounts rw now? Or still only mounts ro?

It mounts RW, but I have yet to attempt an actual write.


> I think most of the errors reported by btrfs check, if they still exist after doing a scrub, should be repaired by 'btrfs check --repair' but I don't advise that until later. I'm not a developer, maybe Qu can offer some advise on those errors.


> > > Next, anytime there is a crash or powerfailur with Btrfs raid56, you need to do a complete scrub of the volume. Obviously will take time but that's what needs to be done first.
> >
> > I'm using raid 10, not 5 or 6.
>
> Same advice, but it's not as important to raid10 because it doesn't have the write hole problem.


> > > OK actually, before the scrub you need to confirm that each drive's SCT ERC time is *less* than the kernel's SCSI command timer. e.g.
> >
> > I gather that I should probably do this before any scrub, be it raid 5, 6, or 10.  But, Is a scrub the operation I should attempt on this raid 10 array to repair the specific errors mentioned in my previous email?
>
> Definitely deal with the timing issue first. If by chance there are bad sectors on any of the drives, they must be properly reported by the drive with a discrete read error in order for Btrfs to do a proper fixup. If the times are mismatched, then Linux can get tired waiting, and do a link reset on the drive before the read error happens. And now the whole command queue is lost and the problem isn't fixed.

Good to know, that seems like a critical piece of information.  A few searches turned up this page, https://wiki.debian.org/Btrfs#FAQ.

Should this be noted on the 'gotchas' or 'getting started page as well?  I'd be happy to make edits should the powers that be allow it.


> There are myriad errors and the advice I'm giving to scrub is a safe first step to make sure the storage stack is sane - or at least we know where the simpler problems are. And then move to the less simple ones that have higher risk.  It also changed the volume the least. Everything else, like balance and chunk recover and btrfs check --repair - all make substantial changes to the file system and have higher risk of making things worse.

This sounds sensible.


> In theory if the storage stack does exactly what Btrfs says, then at worst you should lose some data, but the file system itself should be consistent. And that includes power failures. The fact there's problems reported suggests a bug somewhere - it could be Btrfs, it could be device mapper, it could be controller or drive firmware.

I'll go ahead with a kernel upgrade/make sure the timing issues are squared away.  Then I'll kick off a scrub.

I'll report back when the scrub is complete or something interesting happens.  Whichever comes first.

Thanks again.


Matt Pallissard

--axzddf7khvybwhhq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQTvIUMPApUGn6YFkXl1uof+t048SQUCXYvc6wAKCRB1uof+t048
Sbx2APQPgYEQgFL6HP39bRBoBa4OtSwsScVXCnpNN365zqTUAQDXLnw/NhbZfctE
4yhSS1vv7oPTo4gFyiDe8W3aGtzxCQ==
=aD0M
-----END PGP SIGNATURE-----

--axzddf7khvybwhhq--
