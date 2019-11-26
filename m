Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A923109832
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2019 05:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfKZECG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 23:02:06 -0500
Received: from mga07.intel.com ([134.134.136.100]:29153 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbfKZECG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 23:02:06 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Nov 2019 20:02:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,244,1571727600"; 
   d="scan'208";a="409847404"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.13.128])
  by fmsmga006.fm.intel.com with ESMTP; 25 Nov 2019 20:02:02 -0800
Date:   Tue, 26 Nov 2019 12:09:08 +0800
From:   Philip Li <philip.li@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Dennis Zhou <dennis@kernel.org>, Chen Rong <rong.a.chen@intel.com>,
        kbuild@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 05/22] btrfs: add the beginning of async discard, discard
 workqueue
Message-ID: <20191126040908.GE26032@intel.com>
References: <201911220351.HPI9gxNo%lkp@intel.com>
 <CAKwvOdn5j37AYzmoOsaSqyYdBkjqevbTrSyGQypB+G_NgxX0fQ@mail.gmail.com>
 <20191125185931.GA30548@dennisz-mbp.dhcp.thefacebook.com>
 <CAKwvOdnaiXo8qqK_tyiYvw5Fo4HvdFzrMxLU7k62qEWucC-58Q@mail.gmail.com>
 <20191126014209.GB21240@intel.com>
 <CAKwvOdnp6kjJkmnDj=bmnN-VaRrNunNCQ5ngUNbCEUXCqYvq5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnp6kjJkmnDj=bmnN-VaRrNunNCQ5ngUNbCEUXCqYvq5w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 25, 2019 at 05:47:00PM -0800, Nick Desaulniers wrote:
> On Mon, Nov 25, 2019 at 5:35 PM Philip Li <philip.li@intel.com> wrote:
> >
> > On Mon, Nov 25, 2019 at 11:39:08AM -0800, Nick Desaulniers wrote:
> > > On Mon, Nov 25, 2019 at 10:59 AM Dennis Zhou <dennis@kernel.org> wrote:
> > > >
> > > > On Thu, Nov 21, 2019 at 08:27:43PM -0800, Nick Desaulniers wrote:
> > > > > Hi Dennis,
> > > > > Below is a 0day bot report from a build w/ Clang. Warning looks legit,
> > > > > can you please take a look?
> > > > >
> > > >
> > > > Ah thanks for this! Yeah that was a miss when I switched from flags ->
> > > > an enum and didn't update the declaration properly. I'll be sending out
> > > > a v4 as another fix for arm has some rebase conflicts.
> > > >
> > > > Is there a way to enable so I get these emails directly?
> > >
> > > + Rong, Philip
> > >
> > > The reports have only been sent to our mailing list where we've been
> > > manually triaging them.  The issue with enabling them globally was
> > > that the script to reproduce the warning still doesn't mention how to
> > > build w/ Clang.
Hi Nick, i forgot one question. Is it still expected to use latest clang
to build test? Any possibility the issue is related to clang compiler itself?

Thanks

> > Thanks Nick for continuous caring on this. One thing we initially worry
> > is how to avoid duplicated reports to developer, like the one that can
> > be same as gcc's finding. We haven't found a way to effectively handle
> > this.
> 
> Thanks for maintaining an invaluable tool.
> 
> How would the reports be duplicated? Does 0day bot build with GCC,
> then rebuild with Clang?
> 
> Regardless, does it matter? If I make a mistake, and get two build
> failure emails from 0day bot instead of one, does it matter? Sometimes
> developers may just get one, as some warnings are unique to each
> compiler.  Maybe it runs the risk of folks ignoring the email if the
> volume is too much, but do authors generally ignore 0day bot emails?
> (I'd hope not).
> 
> >
> > >
> > > In general the reports have been high value (I ignore most reports
> > > with -Wimplicit-function-declaration, which is the most frequent as it
> > > shows the patch was not compile tested at all).
> > Do we mean the report with -Wimplicit-function-declaration can be duplicated
> > to gcc, so we can ignore them to avoid duplication to developer?
> 
> Many of the warnings GCC has Clang does as well.
> -Wimplicit-function-declaration is the most common warning I see in
> triage, which developers would see regardless of toolchain had they
> compiled first before pushing.  It might be interesting to see maybe
> the intersection or common flags between GCC and Clang, and only email
> Clang reports for warnings unique to clang?  I think CFLAGS can even
> be passed into make invocations so you could do:
> $ make CC=clang KBUILD_CFLAGS=<list of flags common to GCC and Clang;
> -Wno-implicit-function-declaration -Wno-...>
> such that any resulting warnings were unique to Clang.  I'd expect
> such a list to quickly get stale over time though.
> 
> >
> > >
> > > Rong, Philip, it's been a while since we talked about this last. Is
> > > there a general timeline of when these reports will be turned on
> > > globally?  Even if the directions to reproduce aren't quite right,
> > For the timeline, it's not decided due to the duplication concern. We tend
> > to look into next year after other priorities are solved for this year.
> >
> > > generally there's enough info in the existing bugs where authors can
> > > rewrite their patch without even needing to rebuild with Clang (though
> > > having correct directions to reproduce would be nice, we could wait
> > > until someone asked for them explicitly).
> > >
> > > --
> > > Thanks,
> > > ~Nick Desaulniers
> 
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
