Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A78864E9F1
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2019 15:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbfFUNw4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jun 2019 09:52:56 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40817 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfFUNwz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jun 2019 09:52:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so3410110pgj.7;
        Fri, 21 Jun 2019 06:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2gtphzP/bpRDT8GjhjgIxtYXvKqMZkcliLBFJW0ibC4=;
        b=talyJMTcjpuLq4hTvxk6zEfv7IpP8BLN6kEH5TTIKlIYbwlc3hW3gcrzAB4O/gOtUF
         BETBQXXtDsu4wq2W7CZWkUOgvmkr7l+bY4E7g+yrl+ztj3ETe06KTofV3rV8P5mUJjWW
         sEVg6S907XWCGiywDWy3Bx9dG/yZ19bOwH2sen+/uwr7UohD2jCZohT2vIbRMaFhDaEb
         EY32TYKMdi+ikdJm+wF0rHTn/lATXlvJErgA2AZRTwNhNbmipWa6DDqM3c95YMyLDNr6
         9zXUIilsnatphjim8mOIxWLd801oUZV9FgjMDb+7tZXFI5I8s8qOgRipFLb46eIM6Y5h
         hvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2gtphzP/bpRDT8GjhjgIxtYXvKqMZkcliLBFJW0ibC4=;
        b=HxJa73jqL72hXk64QBS8OClCddpNTShw72b6arJalGwsbx4Xp0uHD61xAfrQJ9l4n9
         QnGMFbN6x/gVqItw1RPAOzgH8GetGZqBFRVq/BegvOLuR0qcKRaHwFTCfB0Yrs2gqmvM
         PHhCpr3YlBgublOtB6oiB+flC51uQFOdR1xKN0Gjoz/bUq3CxWD9zctOG6qFUzhrnvTZ
         P0/zZA/FRItx4BwDQ8Fr4ARoTHF3nmVtp4KnvJSLnEzEud37TzYX5uc2Kapzwn195Du0
         /yavM9NrduaciG+XCHAYwgQy6aik/IZQTqtMsmg2kHnd+expDhiXTh7DDEyZ5UneBTVY
         YfKQ==
X-Gm-Message-State: APjAAAVPnqVoSwFnuoY7fqcczWFV+pJ/f7/YjsPZgTJD90qfzDmv/4+q
        3eTBQLEc0xUUy4J/ghfaP5o=
X-Google-Smtp-Source: APXvYqwyqVS83chhaxEVGyd7C1vG6DVEpokUX1qngS21+FM3kmKFMvR9A1zCepjypDdS+DFiZlzciw==
X-Received: by 2002:a65:64d6:: with SMTP id t22mr19026058pgv.406.1561125175021;
        Fri, 21 Jun 2019 06:52:55 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id c26sm2836654pfr.172.2019.06.21.06.52.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 06:52:53 -0700 (PDT)
Date:   Fri, 21 Jun 2019 21:52:47 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 2/2] generic/059: also test that the file's mtime and
 ctime are updated
Message-ID: <20190621135247.GL15846@desktop>
References: <20190619120624.9922-1-fdmanana@kernel.org>
 <20190621103642.GK15846@desktop>
 <CAL3q7H4YqSZSdUo5zrFKjmtDEaOKak2YHVf9MR3y9WdXnE2xnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4YqSZSdUo5zrFKjmtDEaOKak2YHVf9MR3y9WdXnE2xnw@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 21, 2019 at 11:48:57AM +0100, Filipe Manana wrote:
> On Fri, Jun 21, 2019 at 11:36 AM Eryu Guan <guaneryu@gmail.com> wrote:
> >
> > On Wed, Jun 19, 2019 at 01:06:24PM +0100, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > Test as well that hole punch operations that affect a single file block
> > > also update the file's mtime and ctime.
> > >
> > > This is motivated by a bug a found in btrfs which is fixed by the
> > > following patch for the linux kernel:
> > >
> > >  "Btrfs: add missing inode version, ctime and mtime updates when
> > >   punching hole"
> > >
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > ---
> > >  tests/generic/059 | 18 ++++++++++++++++++
> > >  1 file changed, 18 insertions(+)
> > >
> > > diff --git a/tests/generic/059 b/tests/generic/059
> > > index e8cb93d8..fd44b2ea 100755
> > > --- a/tests/generic/059
> > > +++ b/tests/generic/059
> > > @@ -18,6 +18,9 @@
> > >  #
> > >  #  Btrfs: add missing inode update when punching hole
> > >  #
> > > +# Also test the mtime and ctime properties of the file change after punching
> > > +# holes with ranges that operate only on a single block of the file.
> > > +#
> > >  seq=`basename $0`
> > >  seqres=$RESULT_DIR/$seq
> > >  echo "QA output created by $seq"
> > > @@ -68,6 +71,13 @@ $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foo
> > >  # fsync log.
> > >  sync
> > >
> > > +# Sleep for 1 second, because we want to check that the next punch operations we
> > > +# do update the file's mtime and ctime.
> > > +sleep 1
> >
> > Is this supposed to be after recording the initial c/mtime? i.e. moving
> > it after c/mtime_before?
> 
> Either way is fine. Capturing the times right before or right after
> the sleep, gives the same values as nothing changed the file.

Ah, you're right.

> 
> Btw, I had noticed the other day that the second "echo" has
> $mtime_after instead of $ctime_after (copy-paste mistake).
> Do you want me to send a v2 fixing that typo, or you can do it
> yourself when you pick the patch?

I can fix it on commit, thanks for pointing it out!

Thanks,
Eryu
