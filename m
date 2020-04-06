Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C66719FC25
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Apr 2020 19:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgDFR54 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Apr 2020 13:57:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:55568 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbgDFR54 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Apr 2020 13:57:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D54ECAB8B;
        Mon,  6 Apr 2020 17:57:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2629ADA726; Mon,  6 Apr 2020 19:57:18 +0200 (CEST)
Date:   Mon, 6 Apr 2020 19:57:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Goffredo Baroncelli <kreijack@libero.it>
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>,
        Graham Cobb <g.btrfs@cobb.uk.net>
Subject: Re: [PATCH v3] btrfs-progs: add warning for mixed profiles filesystem
Message-ID: <20200406175717.GR5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, David Sterba <dsterba@suse.com>,
        Graham Cobb <g.btrfs@cobb.uk.net>
References: <20200404103212.40986-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200404103212.40986-1-kreijack@libero.it>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Apr 04, 2020 at 12:32:07PM +0200, Goffredo Baroncelli wrote:
> the aim of this patch set is to issue a warning when a mixed profiles
> filesystem is detected. This happens when the filesystems contains
> (i.e.) raid1c3 and single chunk for data.
> 
> BTRFS has the capability to support a filesystem with mixed profiles.
> However this could lead to an unexpected behavior when a new chunk is
> allocated (i.e. the chunk profile is not what is wanted). Moreover
> if the user is not aware of this, he could assume a redundancy which
> doesn't exist (for example because there is some 'single' chunk when
> it is expected the filesystem to be full raid1).
> A possible cause of a mixed profiles filesystem is an interrupted
> balance operation or a not fully balance due to very specific filter.
> 
> The check is added to the following btrfs commands:
> - btrfs balance pause
> - btrfs balance cancel
> - btrfs device add
> - btrfs device del
> 
> The warning is shorter than the before one. Below an example and
> it is printed after the normal output of the command.
> 
>    WARNING: Multiple profiles detected.  See 'man btrfs(5)'.
>    WARNING: data -> [raid1c3, single], metadata -> [raid1, single]
> 
> The command "btrfs fi us" doesn't show the warning above, instead
> it was added a further line in the "Overall" section. The output now
> is this:
> 
>     Multiple profile:		       YES

Yeah the summary section seems suitable, I think this could be more
specific, for which profile type it applies, eg. 'data, metadata', or
just one of them.

I'll add the patches to devel so we can see how it works in practice.
