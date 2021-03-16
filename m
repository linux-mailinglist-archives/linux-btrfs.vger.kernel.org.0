Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F3733D177
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Mar 2021 11:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbhCPKLI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Mar 2021 06:11:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:57912 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236525AbhCPKKs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Mar 2021 06:10:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D7DB3AC1D;
        Tue, 16 Mar 2021 10:10:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5937FDA6E2; Tue, 16 Mar 2021 11:08:46 +0100 (CET)
Date:   Tue, 16 Mar 2021 11:08:46 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: fixes for subpage which also affect read-only
 mount
Message-ID: <20210316100846.GD7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210315053915.62420-1-wqu@suse.com>
 <20210315154205.GX7604@twin.jikos.cz>
 <09680ea1-12c1-eb0e-b3fb-08caff760b04@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09680ea1-12c1-eb0e-b3fb-08caff760b04@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 16, 2021 at 08:29:35AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/3/15 下午11:42, David Sterba wrote:
> > On Mon, Mar 15, 2021 at 01:39:13PM +0800, Qu Wenruo wrote:
> >> During the fstests run for btrfs subpage read-write support, generic/475
> >> crashes the system with a very high chance.
> >>
> >> It turns out the cause is also affecting btrfs subpage read-only mount
> >> so it's worthy a quick fix.
> >>
> >> Also the crash call site shows a new rabbit hole of hard coded
> >> PAGE_SHIFT in readahead.
> >
> > There's still a lot of PAGE_SHIFT use, not all of them are wrong but I
> > think we'll need to do an audit and categorize the valid uses, otherwise
> > it'll be a whack-a-mole.
> >
> 
> Already did that.
> 
> The current valid use case for PAGE_SHIFT are:
> - Grab page
>    Including:
>    * compression
>    * raid56
>    * relocation
>    * buffered write in file.c
>    * sb cross page check in volumes.c
>    * send
>    * zoned
>    * sb rw in disk-io.c
>    * tree csum in disk-io.c
>    * free space cache v1
> - Some legacy code still runs in full page mode
>    Including:
>    * defrag
> 
> - Verification code
>    That part has way more hardcoded part to be addressed.
>    Will be addressed in the final part, along with selftest enhancement.
> 
> Although there can be something missing, I believe it shouldn't be that
> hard to hit during fstests then.

Great, please put that to subpage.c as first comment, and anything that
documents the high level topics regarding subpage. Lots of that is in
changelogs but we want that readily available in the sources too.
Thanks.
