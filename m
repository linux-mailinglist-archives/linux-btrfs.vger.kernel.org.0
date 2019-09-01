Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B383A4BAC
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Sep 2019 22:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfIAUJ2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Sep 2019 16:09:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52988 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfIAUJ2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Sep 2019 16:09:28 -0400
Received: by mail-wm1-f68.google.com with SMTP id t17so12406300wmi.2
        for <linux-btrfs@vger.kernel.org>; Sun, 01 Sep 2019 13:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XZGCE/B7MuC0ozEAFiOoEmuEfOCLBqczGWOG89mwQnY=;
        b=f/1D71UZyZfVuTTFEdC8RCnSJzuSKsOR6FBqizL16f+8bZ0UQNCd+biHpFAAZf8oa8
         oGbPri2UYRI5/Ligp7VT8ojKW8urCoTTjLK3VRpDA6lF//jbxkZdv0M/tUGc6s5AEIYH
         wh8WcWukVolk32V7Ae/I6Kb+ZdNzeJ1d9WKL4YFS4N30vCgT5Y0+Y9sTzG+9rpuDUJJn
         /k8d2RJ5X2P/rvjsKRdgABnm74M5cqdn7YQ/bVfsKnmlIg4YnOMe5JTS3Ee5MCl4qQ9X
         IsegYDeoN583iJHttznrUZWCfaKSYPHasYZxMF7zC3w6jfmczxDab3XV9Np9HmPnWW+u
         ITNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XZGCE/B7MuC0ozEAFiOoEmuEfOCLBqczGWOG89mwQnY=;
        b=oe+Lm623dwF/tLHfCC4XdAWIavieAvGA2wvYy6QLpFCCK85QCjDbnM33ZyemYDNG1F
         BwHuyXP+yk2/fXCcAbIHeQx0GrW5rL9JP5XqL8a4EXjLCP3zSBMSkbmiZ/n/4EPAvNe8
         gZzoIydUvwQ4obW7PL7Km8i689+dICc0cZJky3kyGYxtVLgheQJtD/NuhZ3Np4kFcnjh
         c08HDOA2H/JLXnAx+q+kjxogSdl82LRujulNqFMbEmI3qg1/AGEQnjxxka/YvYQxpDil
         /ql0iUmz1sYcB+ZxEWnsKKZ2zsRqX0pJVtzFfUI8mUq6WOZVLbvWFhOpU+2QN9ldq2yX
         ciqg==
X-Gm-Message-State: APjAAAWPBq3uxLHfqMB3zLq6Jof5+MP86/nIyAvaqkzNYBebNwez5C65
        tgtOfptS3Of6eN0IDLKn4chWa9r735gpLEfamIU3sQ==
X-Google-Smtp-Source: APXvYqznZYzq0b9QtN9FBJPiGdkEgxVM643deyxjYmgccpTF+Aa4TxwhZRMAEnIIbyP7JvRtm9dA0wHtJWKvvw06nl0=
X-Received: by 2002:a7b:ce8f:: with SMTP id q15mr15241478wmj.106.1567368566293;
 Sun, 01 Sep 2019 13:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <bdd368bc2e910523525c54844c5c47dd877f1a0d.camel@math.duke.edu>
 <98252ab04af29eecf51b6c9ecb7f258df56c93ba.camel@math.duke.edu>
 <CAJCQCtQRDfMb6=RtT5rNDSj_QT_nJXYx3C-Zzi9baPykHTrDDA@mail.gmail.com>
 <cab4c26799caa8f4f9516124b5448840245a2811.camel@math.duke.edu>
 <b3ec20d5-e9b1-4688-297b-b102b5a8fa10@gmx.com> <b855969a3108e7ef9be2e758eb8bd2f3539e5af0.camel@math.duke.edu>
In-Reply-To: <b855969a3108e7ef9be2e758eb8bd2f3539e5af0.camel@math.duke.edu>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 1 Sep 2019 14:09:15 -0600
Message-ID: <CAJCQCtR9feFgGtOZ0Wik2y1oQ69V5z5Q-voFtYPLtnbnbWo7TA@mail.gmail.com>
Subject: Re: block corruption
To:     Rann Bar-On <rann@math.duke.edu>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Chris Murphy <lists@colorremedies.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Sep 1, 2019 at 11:39 AM Rann Bar-On <rann@math.duke.edu> wrote:
>
> On Sun, 2019-09-01 at 07:48 +0800, Qu Wenruo wrote:
> >
> > On 2019/9/1 =E4=B8=8A=E5=8D=887:39, Rann Bar-On wrote:
> > > On Sat, 2019-08-31 at 17:04 -0600, Chris Murphy wrote:
> > > > On Sat, Aug 31, 2019 at 2:26 PM Rann Bar-On <rann@math.duke.edu>
> > > > wrote:
> > > > > I just downgraded to kernel 4.19, and the supposed corruption
> > > > > vanished.
> > > > > This may be related to
> > > > >
> > > > > https://www.spinics.net/lists/linux-btrfs/msg91046.html
> > > > >
> > > > > If I can provide information that would help fix this issue,
> > > > > I'd be
> > > > > glad to, but I cannot upgrade back to kernel 5.2, as I can't
> > > > > risk
> > > > > this
> > > > > system.
> > > >
> > > > 5.2 has more strict checks for corruption, exposing the rare case
> > > > where metadata in a leaf is corrupt but the checksum was properly
> > > > computed.
> >
> > Exactly.
> >
> > Although for your case, it's some older kernel doing something bad.
> >
> > It's also reported once for the same problem, some older kernel
> > doesn't
> > set the mode member properly.
>
> > > > > > Btrfs v3.17
> > > >
> > > > This is old. I suggest finding a newer version of btrfs-progs,
> > > > ideally
> > > > latest stable version is 5.2.1. Definitely don't use --repair
> > > > with
> > > > this version. It's safe to use check --readonly (which is the
> > > > default)
> > > > with this version but probably not that helpful to devs.
> > > >
> > >
> > > Not really sure why that said 3.17:
> > >
> > > $ btrfs --version
> > > btrfs-progs v5.2.1
> > >
> > > Anyway, running btrfs --repair on the file system didn't do
> > > anything to
> > > fix the above errors.
> >
> > That's what we need to enhance next.
> >
> > > I removed at least one of the corrupt files (the only one that was
> > > mode
> > > 0) using kernel 4.19.
> > >
> > > Happy to help further if I can. What would you suggest as far as
> > > fixing
> > > this or reporting it usefully? If you believe 5.2 isn't causing the
> > > corruption, but rather, just exposing it, I'm more than happy to
> > > experiment with it.
> >
> > Deleting the offending inodes would be enough to fix the alert.
> >
>
> I deleted the file using the older kernel. I rebooted into the new
> kernel, and things seem good for now.
>
> Note: The newer one wouldn't let me access the file to delete it, nor
> did any btrfs repair tool do anything at all. This is a big problem
> IMO!

The current behavior is an improvement over propagating corruption and
never detecting it because the leaf is assumed to be correct only
because the checksum matches. The next step is figuring out ways to
work around such rare detected corruptions, hopefully automatically
and while online.

I don't consider it user responsibility to have to do this, but I'm
vaguely curious if it's possible to delete the offending file in a
snapshot, then delete the original subvolume. i.e.

1.
snapshot the subvolume containing the file (default rw snapshot)
2.
delete the bad file(s) in the snapshot
3.
delete the original subvolume (snapshot's parent)

I'm curious if either 2 or 3 are permitted.


--=20
Chris Murphy
