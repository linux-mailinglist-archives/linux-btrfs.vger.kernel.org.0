Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBA03922B4
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 May 2021 00:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbhEZW2w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 May 2021 18:28:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:45106 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229624AbhEZW2t (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 May 2021 18:28:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622068036;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9rQKJyqwB9bFmeK7Ulcf347vDghJbGSUake8MUGz5BE=;
        b=aHlhVILls1DzqYE85A+Oakzzub2vPf/jGIDWRulpSpLTIMgFzB+8VfnOOjXQ+odL4kvKp4
        kM//kclrw87OVZYzYRsUTTvssVyfvAwGKprDPJhBJ+R476P33aBmKdRiQaE9lDQX0mSh6g
        RwCcvd3eUPhdojhCMngKLT2Mcwlf/HU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622068036;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9rQKJyqwB9bFmeK7Ulcf347vDghJbGSUake8MUGz5BE=;
        b=xiHXlfX9yK5K0ualeaZcjWkC6FMLw37yPP6CzlNPAj+qkQ3oViphtixZEjJn7/mzFfpSAX
        0u9dmhZmyqbpUBBw==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E700BAB71;
        Wed, 26 May 2021 22:27:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D7998DA704; Thu, 27 May 2021 00:24:38 +0200 (CEST)
Date:   Thu, 27 May 2021 00:24:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/6] btrfs: add wrapper for conditional start of
 exclusive operation
Message-ID: <20210526222438.GJ7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1621526221.git.dsterba@suse.com>
 <fe9738eb5db055e06eafb178bf6aea41c48b2890.1621526221.git.dsterba@suse.com>
 <80f75399-9dee-e26c-6433-6e361bc9136b@toxicpanda.com>
 <20210521164551.GP7604@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521164551.GP7604@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 21, 2021 at 06:45:51PM +0200, David Sterba wrote:
> On Fri, May 21, 2021 at 09:29:16AM -0400, Josef Bacik wrote:
> > On 5/21/21 8:06 AM, David Sterba wrote:
> > > +		/*
> > > +		 * This blocks any exclop finish from setting it to NONE, so we
> > > +		 * request cancelation. Either it runs and we will wait for it,
> > > +		 * or it has finished and no waiting will happen.
> > > +		 */
> > > +		atomic_inc(&fs_info->reloc_cancel_req);
> > > +		btrfs_exclop_start_unlock(fs_info);
> > > +
> > > +		if (test_bit(BTRFS_FS_RELOC_RUNNING, &fs_info->flags))
> > > +			wait_on_bit(&fs_info->flags, BTRFS_FS_RELOC_RUNNING,
> > > +				    TASK_INTERRUPTIBLE);
> > 
> > Do we want to capture the return value here, in case the user hit's ctrl+c we 
> > can return -EINTR instead so we don't think it succeeded?  Thanks,
> 
> The cancel request will stay, so only the waiting part won't happen. I'm
> not sure if this is worth to distinguish the two states, eg. allow progs
> to print a different message.

So as the cancelling would happen I hope it's ok to return the ECANCELED
error in all cases. Other operations like balance or scrub aren't
interruptible and wait until the condition is satisified, but there's a
different pattern regarding the cancel request so it has to be that way
there. This could be unified but right now I don't see the need for
that.

> Maybe a waiting and non-waiting cancel modes would be also useful. As
> the interface is string-based we can also add 'status' that would say if
> it's running or not. This should cover the usecases, but would be
> a bit more complicated in the state transitions.

I've asked on IRC what's the expected behaviour of cancel command
regarding waiting/not waiting. Seems that 'wait until it's finished' is
preferred and it's consistent with what scrub and balance (cancel) do.
