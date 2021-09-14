Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97EC40B10B
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 16:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbhINOiA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Sep 2021 10:38:00 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39848 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbhINOh1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Sep 2021 10:37:27 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1295C1FE04;
        Tue, 14 Sep 2021 14:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631630169;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s1j/a3GG2iOs+xCNBiyrviKAe0IVcjZka/mN5yuwbB8=;
        b=2UuIiArnp5hKdFNBoAPdTkxeQaLk6reNKbYHsavHsuDbLlG4g+8UCcGeIwcA15FmcN31he
        DPgP+JyhP5+th2H4aKH+HaEj/f6bpwREJExu5odD/0eyoNE3SKKx1UVhqC1go6cEEzbXiW
        jvfoSN4CMuNND5JiYmz2wwVe4y0QkzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631630169;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s1j/a3GG2iOs+xCNBiyrviKAe0IVcjZka/mN5yuwbB8=;
        b=FI9PIJm9O9vA+vIwv+3RUPMGeiP/P0gPda/ACniKZLrg9SPxH10NoOE9/MNWZxuJviXoLD
        BFpWPW47HKJ73cAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0F231A3BD5;
        Tue, 14 Sep 2021 14:36:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 19822DA781; Tue, 14 Sep 2021 16:36:00 +0200 (CEST)
Date:   Tue, 14 Sep 2021 16:36:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Su Yue <l@damenly.su>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: make btrfs_node_key static inline
Message-ID: <20210914143600.GB9286@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Su Yue <l@damenly.su>,
        linux-btrfs@vger.kernel.org
References: <20210914105335.28760-1-l@damenly.su>
 <20210914131253.GA9286@twin.jikos.cz>
 <mtof1bt2.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mtof1bt2.fsf@damenly.su>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 14, 2021 at 10:08:36PM +0800, Su Yue wrote:
> 
> On Tue 14 Sep 2021 at 15:12, David Sterba <dsterba@suse.cz> wrote:
> 
> > On Tue, Sep 14, 2021 at 06:53:35PM +0800, Su Yue wrote:
> >> It looks strange that btrfs_node_key is in struct-funcs.c.
> >> So move it to ctree.h and make it static inline.
> >
> > "looks strange" is not a sufficient reason. Inlining a function 
> > means
> > that the body will be expanded at each call site, bloating the 
> > binary
> > code. Have you measured the impact of that?
> >
> Fair enough.
> 
> Before:
>    text    data     bss     dec     hex filename
> 1202418  123105   19384 1344907  14858b fs/btrfs/btrfs.ko
> After:
>    text    data     bss     dec     hex filename
> 1202620  123105   19384 1345109  148655 fs/btrfs/btrfs.ko
> 
> +202
> 
> > There's some performance cost of an non-inline function due to 
> > the call
> > overhead but it does not make sense to inline a function that's 
> > called
> > rarely and not in a tight loop. If you grep for the function 
> > you'd see
> > that it's called eg. once per function or in a loop that's not
> > performance critical on first sight (eg. in reada_for_search).
> 
> Right, the patch won't impact performance obviously at the cost of
> +202 binary size. So I'd drop the patch.

It does increase the size a bit but from what I've seen in the assembly
it's not that bad and still probably worth doing the inline. There's one
more extra call to read_extent_buffer (hidden behind read_eb_member
macro).

Cleaning up the node key helpers would be useful too, adding some
more helpers and not calling read_eb_member in the end. I have a WIP
patchset for that but had to leave it as there were bugs I did not find.
I can bounce it to you if you're interested.
