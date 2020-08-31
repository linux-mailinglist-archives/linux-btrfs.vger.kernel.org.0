Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC057257A49
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 15:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgHaNXq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 09:23:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:44012 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgHaNXp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 09:23:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D1CE0B64A;
        Mon, 31 Aug 2020 13:04:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 136C6DA840; Mon, 31 Aug 2020 15:03:45 +0200 (CEST)
Date:   Mon, 31 Aug 2020 15:03:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Urs Thuermann <urs@isnogud.escape.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Link count for directories
Message-ID: <20200831130344.GW28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Urs Thuermann <urs@isnogud.escape.de>,
        linux-btrfs@vger.kernel.org
References: <trinity-57be0daf-2aa0-4480-a962-7a62e302cfde-1598031619031@3c-app-gmx-bap35>
 <e592fd12-1662-49f3-75bd-94609e660517@suse.com>
 <trinity-963db523-ba60-48b5-997f-59b55ee6b92b-1598305830919@3c-app-gmx-bap63>
 <20200824222306.GA26736@angband.pl>
 <5062163c-47ff-f811-7b37-e74e1ef47265@suse.com>
 <A61FAA28-DE0C-42BD-8074-756765C5557E@fb.com>
 <ygfd03dkhvu.fsf@tehran.isnogud.escape.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ygfd03dkhvu.fsf@tehran.isnogud.escape.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 26, 2020 at 09:04:21AM +0200, Urs Thuermann wrote:
> > Find certainly paid attention, but from an optimization point of
> > view, dtype in directory entries is dramatically more helpful.
> 
> 1. dtype is not in POSIX.

It is not but is this a problem in practice? Linux supports d_type and
that's what matters right now (manual page says that some BSDs support
that too).

> OTOH, I seem to remember that POSIX states
>    st_link == 1 for directories or otherwise it has the traditional
>    value of 2 + sub-directory count.  However, I cannot find this
>    anymore.  Is that correct and can anyone give me a pointer?

I can't find a reliable source for that but I remember reading it
somewhere.

> 2. If you just want to find all directories you only need stat(2) on a
>    directory and if it has st_nlink == 2 you don't need to read all
>    directory entries (with or without dtype).  So this optimization is
>    possible with the traditional link count of directories but not
>    with dtype.
> 
> > I'd want to see big wins from applications before adding this
> > into btrfs.
> 
> I would expect noticable but not big wins.

The usecasee you describe skips readdir in case there are no
directories, ie. if there are, full readdir will need to be done anyway.
I can see that this saves some calls but otherwise it's IMHO quite narrow.

> However, I'd like adding
> this to btrfs just because it looks nicer.  Since ls (and readdir)
> gives you the . and .. links they should be counted in the usual way.

As said elsewhere, this comes with a cost of backward compatibility
issues and unfortunatelly overrides a 'nice to have' feature.
