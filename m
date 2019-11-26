Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0935710A15F
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2019 16:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfKZPo4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Nov 2019 10:44:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:44672 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725972AbfKZPo4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Nov 2019 10:44:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EFD85699BB;
        Tue, 26 Nov 2019 15:44:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2BE99DA898; Tue, 26 Nov 2019 16:44:53 +0100 (CET)
Date:   Tue, 26 Nov 2019 16:44:53 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     David Sterba <dsterba@suse.cz>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH next 1/2] btrfs: tree-checker: Fix error format string
Message-ID: <20191126154452.GG2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20191108213853.16635-1-afaerber@suse.de>
 <20191108213853.16635-2-afaerber@suse.de>
 <20191111183158.GT3001@twin.jikos.cz>
 <CAMuHMdVbcfB0FFS=gLDathXFM3x0WYXJEq99S_g7mjAPS94rAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVbcfB0FFS=gLDathXFM3x0WYXJEq99S_g7mjAPS94rAQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 26, 2019 at 11:36:58AM +0100, Geert Uytterhoeven wrote:
> > > Fixes: a31ccb4b7ba2 ("btrfs: tree-checker: Check item size before reading file extent type")
> >
> > As the patch is still in the devel branch, the commit id is not stable
> 
> It indeed is not:
> Fixes: 153a6d299956983d ("btrfs: tree-checker: Check item size before
> reading file extent type")
> 
> > and I'll fold the change to to the patch. Thanks.
> 
> Apparently that was forgotten, and now the issue is part of Linus' tree.

Mistake on my side so I'll apply the full fixup patch, thanks for
noticing.
