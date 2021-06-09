Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77D93A207A
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jun 2021 01:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhFIXG5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Jun 2021 19:06:57 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41028 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFIXG5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Jun 2021 19:06:57 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 36010219A7;
        Wed,  9 Jun 2021 23:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623279901;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mlsWobBerWfFrg8aDDUB+4shQ+pMVEP20lmn7L8rIdk=;
        b=YaIFa6vWcmziGerjPi3aRA7s50vCH2JRVF+PG6lde7d/bAJl+JXCcO9Ot3QXwxLSzAMSE5
        +3FfQBcuuBIK44T9B6SQesDWsAnpvPDbWxu0fnROATueLYrYwP7LtiYLxTye23S+66xaPa
        tPmwy7+gs2F1OQCw5SbMwvJsl6o79+E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623279901;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mlsWobBerWfFrg8aDDUB+4shQ+pMVEP20lmn7L8rIdk=;
        b=EC/7pcNurdXoJggNtbNwa+o1Zltx+vZxGwfXTf27pNmC+GSiLwG1RiaxtPX80JErmcCSJo
        Gges2T0QpQK+3DBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2EE39A3B84;
        Wed,  9 Jun 2021 23:05:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EF309DAF37; Thu, 10 Jun 2021 01:02:16 +0200 (CEST)
Date:   Thu, 10 Jun 2021 01:02:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     David Sterba <dsterba@suse.cz>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 00/10] btrfs: defrag: rework to support sector perfect
 defrag
Message-ID: <20210609230216.GF27283@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Neal Gompa <ngompa13@gmail.com>,
        Qu Wenruo <wqu@suse.com>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <20210608025927.119169-1-wqu@suse.com>
 <20210609152650.GC27283@twin.jikos.cz>
 <CAEg-Je_8sDQNWM9tdka_Zd=v5pQzf0AsnJJAVAeKy7nMO5CE8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEg-Je_8sDQNWM9tdka_Zd=v5pQzf0AsnJJAVAeKy7nMO5CE8Q@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 09, 2021 at 06:48:31PM -0400, Neal Gompa wrote:
> On Wed, Jun 9, 2021 at 12:23 PM David Sterba <dsterba@suse.cz> wrote:
> > On Tue, Jun 08, 2021 at 10:59:17AM +0800, Qu Wenruo wrote:
> > > [BEHAVIOR CHANGE]
> > > In the refactor, there is one behavior change:
> > >
> > > - Defraged sector counter is based on the initial target list
> > >   This is mostly to avoid the paremters to be passed too deep into
> > >   defrag_one_locked_target().
> > >   Considering the accounting is not that important, we can afford some
> > >   difference.
> >
> > As you're going to resend, please fix all occurences of 'defraged' to
> > 'defragged'.
> >
> > I'll give the patchset some testing bug am not sure if it isn't too
> > risky to put it to the 5.14 queue as it's about time to do only safe
> > changes.
> 
> This patch set makes it possible to do compression and balance in
> subpage cases, right? At least, that's what I understood of it (defrag
> code is used for balance and compression...).

No it's just to do defragmentation in subpage case. Defrag and balance
code are indpendent, and only defrag can do compression, balance just
moves chunks of data but does not do changes to the data itself (it
could write them in a different way eg. the stripes or copies).
