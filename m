Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671951E6907
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 May 2020 20:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391432AbgE1SFI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 May 2020 14:05:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:39120 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391258AbgE1SFG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 May 2020 14:05:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CC299ADB3;
        Thu, 28 May 2020 18:05:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 01E63DA72D; Thu, 28 May 2020 20:05:04 +0200 (CEST)
Date:   Thu, 28 May 2020 20:05:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/6] btrfs-progs: btrfs-image related fixes
Message-ID: <20200528180504.GP18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200527102810.147999-1-wqu@suse.com>
 <51ac5cc9-5902-663e-da51-b5a5004ec719@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51ac5cc9-5902-663e-da51-b5a5004ec719@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 27, 2020 at 06:46:53PM +0800, Qu Wenruo wrote:
> On 2020/5/27 下午6:28, Qu Wenruo wrote:
> > This branch can be fetched from github:
> > https://github.com/adam900710/btrfs-progs/tree/image_fixes
> > 
> > Since there are two binary files updates, and one big code move, it's
> > recommended to fetch github repo, in case some patches didn't reach mail
> > list.
> > 
> > This is inspried by one log tree replay dead loop bug, where the kind
> > reporter, Pierre Abbat <phma@bezitopo.org>, gave the btrfs-image to
> > reproduce it.
> > 
> > Then the image fails to pass check due to the existing log tree
> > conflicting with device/chunk fixup.
> > As log tree blocks are not recorded in extent tree, later COW can use
> > log tree blocks and cause transid mismatch.
> > 
> > To address the problem, this patchset will:
> > - Don't do any fixup if the source dump is single device
> >   Since the dump has the full super block contents, we can easily check
> >   if the source fs is single deivce.
> > 
> >   The chunk/device fixup is mostly for older btrfs-image behavior, which
> >   always restores the fs into SINGLE profile.
> >   However since commit 9088ab6a1067 ("btrfs-progs: make btrfs-image
> >   restore to support dup"), btrfs-image can restore into DUP profile,
> >   allowing us to do exact replay for single device fs.
> >   This is patch 5.
> 
> As expected, patch 3 can't survive the mail list filter.
> It's 402K, so I guess one needs to grab it from github anyway.

Thanks, patch picked from git and the whole patchset is now in devel.
