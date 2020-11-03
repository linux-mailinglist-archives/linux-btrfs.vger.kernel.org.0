Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5E72A43DE
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 12:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgKCLPn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 06:15:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:59014 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728100AbgKCLPm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Nov 2020 06:15:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BD055ACD8;
        Tue,  3 Nov 2020 11:15:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1E1E2DA7D2; Tue,  3 Nov 2020 12:14:03 +0100 (CET)
Date:   Tue, 3 Nov 2020 12:14:02 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: Re: ERROR: modpost: "__udivdi3" [fs/btrfs/btrfs.ko] undefined!
Message-ID: <20201103111402.GM6756@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
References: <CA+G9fYsqbbtYXaw3=upAMnhccjLezaN7RUjysEF4QhS6TfRr-A@mail.gmail.com>
 <CAMuHMdV2A21oMcA9=rQVfL9xJfRZpV__87byMo4GsXH2i7Y2uQ@mail.gmail.com>
 <7cf2cee6-3a15-b4d4-d0cc-ebc828ec0f56@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7cf2cee6-3a15-b4d4-d0cc-ebc828ec0f56@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 03, 2020 at 06:21:06PM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/11/3 下午5:47, Geert Uytterhoeven wrote:
> > On Tue, Nov 3, 2020 at 10:43 AM Naresh Kamboju
> > <naresh.kamboju@linaro.org> wrote:
> >> Linux next 20201103 tag make modules failed for i386 and arm
> >> architecture builds.
> >>
> >> Error log:
> >>   LD [M]  fs/btrfs/btrfs.o
> >>   MODPOST Module.symvers
> >> ERROR: modpost: "__udivdi3" [fs/btrfs/btrfs.ko] undefined!
> >> scripts/Makefile.modpost:111: recipe for target 'Module.symvers' failed
> >> make[2]: *** [Module.symvers] Error 1
> >>
> >> Full build log,
> >> https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-next/DISTRO=lkft,MACHINE=intel-core2-32,label=docker-lkft/891/consoleText
> >> https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-next/DISTRO=lkft,MACHINE=am57xx-evm,label=docker-lkft/891/consoleText
> >>
> >> --
> >> Linaro LKFT
> >> https://lkft.linaro.org
> > 
> > Yeah, I had a look earlier today, thanks to the kisskb builder, and
> > the btrfs people are working on a fix.
> > Interestingly, the issue was reported in September, and still entered
> > linux-next, so we all had a great time to look into it ;-)
> 
> Yeah, we all know that and how to fix it (just call do_div64() for u64 /
> u32).
> But at that time we're already working on a better solution, other than
> using do_div64(), we use sectorsize_bits shift to replace the division,
> and unfortunately the bit shift fix didn't get merged until recently.
> 
> Considering that patch is only designed to be merged after the bit shift
> fix patch, we're not that concerned. (Until some other guys are
> complaining about the linux-next branch).

I've pushed updated for-next that uses the sectorsize_bits.
