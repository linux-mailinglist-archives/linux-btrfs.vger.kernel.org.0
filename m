Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196DB22871C
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 19:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbgGURQz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 13:16:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:41258 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728750AbgGURQx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 13:16:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D75EEAD78;
        Tue, 21 Jul 2020 17:16:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7172ADA70B; Tue, 21 Jul 2020 19:16:26 +0200 (CEST)
Date:   Tue, 21 Jul 2020 19:16:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH][v2] btrfs: introduce rescue=onlyfs
Message-ID: <20200721171626.GP3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Graham Cobb <g.btrfs@cobb.uk.net>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200721151057.9325-1-josef@toxicpanda.com>
 <69cf9558-5390-8d14-21b2-51f4c82eeed7@cobb.uk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69cf9558-5390-8d14-21b2-51f4c82eeed7@cobb.uk.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 21, 2020 at 04:56:55PM +0100, Graham Cobb wrote:
> On 21/07/2020 16:10, Josef Bacik wrote:
> > One of the things that came up consistently in talking with Fedora about
> > switching to btrfs as default is that btrfs is particularly vulnerable
> > to metadata corruption.  If any of the core global roots are corrupted,
> > the fs is unmountable and fsck can't usually do anything for you without
> > some special options.
> > 
> > Qu addressed this sort of with rescue=skipbg, but that's poorly named as
> > what it really does is just allow you to operate without an extent root.
> > However there are a lot of other roots, and I'd rather not have to do
> > 
> > mount -o rescue=skipbg,rescue=nocsum,rescue=nofreespacetree,rescue=blah
> > 
> > Instead take his original idea and modify it so it just works for
> > everything.  Turn it into rescue=onlyfs, and then any major root we fail
> > to read just gets left empty and we carry on.
> 
> Am I the only one who dislikes the name? "onlyfs" does not seem at all
> meaningful to me, as a system manager - the people it is apparently
> aimed at. I really don't understand what it is supposed to mean and it
> sounds like some developer debugging option or something.

No, you're not the only one. Changelog points to 'skipbg' as poor naming
choice but 'onlyfs' is IMHO just as bad because it's supposed to be used
by users so the naming need to take that into account.

> If it means "only filesystem" that doesn't make sense to me - the whole
> thing is the filesystem. I guess "only data" might be more meaningful
> but if the aim is to turn on as much recovery as possible to help the
> user to save their data then why not just say so?
> 
> Something like "rescue=max", "rescue=recoverymode", "rescue=dataonly",
> "rescue=ignoreallerrors" or "rescue=emergency" might be more meaningful.

From user perspective the option should have a high level semantics,
like you suggest above. We should add individual options to try to work
around specific damage if not just for testing purposes, having more
flexibility is a good thing.
