Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338ED21705D
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 17:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbgGGPQo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 11:16:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:56924 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728441AbgGGPQl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Jul 2020 11:16:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7D31CAE25;
        Tue,  7 Jul 2020 15:16:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6B2F4DA818; Tue,  7 Jul 2020 17:16:21 +0200 (CEST)
Date:   Tue, 7 Jul 2020 17:16:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com, wqu@suse.com
Subject: Re: [PATCH][RFC] btrfs: introduce rescue=onlyfs
Message-ID: <20200707151621.GA16141@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com, wqu@suse.com
References: <20200701144438.7613-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701144438.7613-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 01, 2020 at 10:44:38AM -0400, Josef Bacik wrote:
> One of the things that came up consistently in talking with Fedora about
> switching to btrfs as default is that btrfs is particularly vulnerable
> to metadata corruption.  If any of the core global roots are corrupted,
> the fs is unmountable and fsck can't usually do anything for you without
> some special options.
> 
> Qu addressed this sort of with rescue=skipbg, but that's poorly named as
> what it really does is just allow you to operate without an extent root.
> However there are a lot of other roots, and I'd rather not have to do
> 
> mount -o rescue=skipbg,rescue=nocsum,rescue=nofreespacetree,rescue=blah
> 
> Instead take his original idea and modify it so it just works for
> everything.  Turn it into rescue=onlyfs, and then any major root we fail
> to read just gets left empty and we carry on.
> 
> Obviously if the fs roots are screwed then the user is in trouble, but
> otherwise this makes it much easier to pull stuff off the disk without
> needing our special rescue tools.  I tested this with my TEST_DEV that
> had a bunch of data on it by corrupting the csum tree and then reading
> files off the disk.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> 
> I'm not married to the rescue=onlyfs name, if we can think of something better
> I'm good.
> 
> Also rescue=skipbg is currently only sitting in misc-next, which is why I'm
> killing it with this patch, we haven't sent it upstream so we're good to change
> it now before it lands.

Right now we don't seem to have a consensus what rescue= should or
should not do and given that the patch is not in any released branch I
can keep it in for-next topic branch.  We'll have something to test but
unless the final semantics is agreed on, I don't want to keep the patch
in misc-next to avoid dealing with the fallouts.

To be specific:

- patch "btrfs: introduce "rescue=" mount option" only wraps existing
  options so that one is probably ok to stay in misc-next

- rescue=skipbg would go to topic branch
