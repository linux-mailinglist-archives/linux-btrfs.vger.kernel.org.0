Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB12710979E
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2019 02:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfKZBrN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 20:47:13 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36585 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfKZBrM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 20:47:12 -0500
Received: by mail-pg1-f196.google.com with SMTP id k13so8155519pgh.3
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 17:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KkZGv+kaMOga5WARXycE1ZR6cg0tzVfNuWa+lDuB6eA=;
        b=fKk7iNXTahDaTuu4siVHdmD0NjesZJugTBAO521e4DBMSdzUiFWFwplVD/tNz5lnEv
         GINdVulbR0rZ6ElEFBaDghKkQH7Lbv5boGbJgpixv8LeZpvERzo2qPu+zGbjT/al82sA
         z62npVcm4VPxwCEnQq5dQQf/a0QQVEWE24gDUEv6KZ1qlqE9UU2QMEtR6fJxaBoKR6V6
         gtZmnhU1MDcN0Eys4c26fpYm9Up0lB/o0EBSMt35dyw7SGwIYhyD7fnhIKJBq+GDJkAw
         bdH7IGoeYKHr6/53EWQAxTK2w2/qNssD7+kxV45f6MRZaXrzK0dwSBgbvNyw+oz04uKS
         JPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KkZGv+kaMOga5WARXycE1ZR6cg0tzVfNuWa+lDuB6eA=;
        b=N0mWC7QxXwuOzQ74d0H9oczoS8zKwD+ocufMmwKs/YyaLbh4P9gRC5Eo9g+bvcmRPj
         R34ebTZvyHQ0ArqI1jmQg4el+bxSKgAyQs1LhpgE9dd2PnMes04wBprDFUmjETGCKlXZ
         A+hT5olA8MGIDV/y1CKa/xEbQRdIWJ/x4v0itq8sd2BoJT62KeyCbxHE5LL6yFRkij9r
         yBdUMjbI+SJTPgDaPkI3D/QsX3TvLbYd2wMKvfe5bMPT65i8S+mH3cIKrW1LykRjZzP8
         8grLGNMqPhAaAzEDrKoKeRmSjNGfBAp/UPFH67UQkWP9plfpQK3jP+lLDOb/fR6cOrXR
         3hSQ==
X-Gm-Message-State: APjAAAWWjX9Qs1H0YdVl3F8my7E/B1JJU2xMtp2dm4YN1onHqspxQHjc
        MIT8vtzAWa4ruj+Vw+u72hSXrL6DaGTZtTUkJucoNg==
X-Google-Smtp-Source: APXvYqyImvfmdTfyDaHgXSiWPllgqHWf9GpTbhRsh7dw9gJgDmp9BsGWWi66XgRFRpDBOL50K/fZYgB/fkgfjD3GP8s=
X-Received: by 2002:a63:4c14:: with SMTP id z20mr27206083pga.10.1574732831450;
 Mon, 25 Nov 2019 17:47:11 -0800 (PST)
MIME-Version: 1.0
References: <201911220351.HPI9gxNo%lkp@intel.com> <CAKwvOdn5j37AYzmoOsaSqyYdBkjqevbTrSyGQypB+G_NgxX0fQ@mail.gmail.com>
 <20191125185931.GA30548@dennisz-mbp.dhcp.thefacebook.com> <CAKwvOdnaiXo8qqK_tyiYvw5Fo4HvdFzrMxLU7k62qEWucC-58Q@mail.gmail.com>
 <20191126014209.GB21240@intel.com>
In-Reply-To: <20191126014209.GB21240@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 25 Nov 2019 17:47:00 -0800
Message-ID: <CAKwvOdnp6kjJkmnDj=bmnN-VaRrNunNCQ5ngUNbCEUXCqYvq5w@mail.gmail.com>
Subject: Re: [PATCH 05/22] btrfs: add the beginning of async discard, discard workqueue
To:     Philip Li <philip.li@intel.com>
Cc:     Dennis Zhou <dennis@kernel.org>, Chen Rong <rong.a.chen@intel.com>,
        kbuild@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 25, 2019 at 5:35 PM Philip Li <philip.li@intel.com> wrote:
>
> On Mon, Nov 25, 2019 at 11:39:08AM -0800, Nick Desaulniers wrote:
> > On Mon, Nov 25, 2019 at 10:59 AM Dennis Zhou <dennis@kernel.org> wrote:
> > >
> > > On Thu, Nov 21, 2019 at 08:27:43PM -0800, Nick Desaulniers wrote:
> > > > Hi Dennis,
> > > > Below is a 0day bot report from a build w/ Clang. Warning looks legit,
> > > > can you please take a look?
> > > >
> > >
> > > Ah thanks for this! Yeah that was a miss when I switched from flags ->
> > > an enum and didn't update the declaration properly. I'll be sending out
> > > a v4 as another fix for arm has some rebase conflicts.
> > >
> > > Is there a way to enable so I get these emails directly?
> >
> > + Rong, Philip
> >
> > The reports have only been sent to our mailing list where we've been
> > manually triaging them.  The issue with enabling them globally was
> > that the script to reproduce the warning still doesn't mention how to
> > build w/ Clang.
> Thanks Nick for continuous caring on this. One thing we initially worry
> is how to avoid duplicated reports to developer, like the one that can
> be same as gcc's finding. We haven't found a way to effectively handle
> this.

Thanks for maintaining an invaluable tool.

How would the reports be duplicated? Does 0day bot build with GCC,
then rebuild with Clang?

Regardless, does it matter? If I make a mistake, and get two build
failure emails from 0day bot instead of one, does it matter? Sometimes
developers may just get one, as some warnings are unique to each
compiler.  Maybe it runs the risk of folks ignoring the email if the
volume is too much, but do authors generally ignore 0day bot emails?
(I'd hope not).

>
> >
> > In general the reports have been high value (I ignore most reports
> > with -Wimplicit-function-declaration, which is the most frequent as it
> > shows the patch was not compile tested at all).
> Do we mean the report with -Wimplicit-function-declaration can be duplicated
> to gcc, so we can ignore them to avoid duplication to developer?

Many of the warnings GCC has Clang does as well.
-Wimplicit-function-declaration is the most common warning I see in
triage, which developers would see regardless of toolchain had they
compiled first before pushing.  It might be interesting to see maybe
the intersection or common flags between GCC and Clang, and only email
Clang reports for warnings unique to clang?  I think CFLAGS can even
be passed into make invocations so you could do:
$ make CC=clang KBUILD_CFLAGS=<list of flags common to GCC and Clang;
-Wno-implicit-function-declaration -Wno-...>
such that any resulting warnings were unique to Clang.  I'd expect
such a list to quickly get stale over time though.

>
> >
> > Rong, Philip, it's been a while since we talked about this last. Is
> > there a general timeline of when these reports will be turned on
> > globally?  Even if the directions to reproduce aren't quite right,
> For the timeline, it's not decided due to the duplication concern. We tend
> to look into next year after other priorities are solved for this year.
>
> > generally there's enough info in the existing bugs where authors can
> > rewrite their patch without even needing to rebuild with Clang (though
> > having correct directions to reproduce would be nice, we could wait
> > until someone asked for them explicitly).
> >
> > --
> > Thanks,
> > ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
