Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D563E8F20
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 12:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237191AbhHKK4Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 06:56:16 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53378 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236951AbhHKK4O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 06:56:14 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9F888221AB;
        Wed, 11 Aug 2021 10:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628679350;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z78fqU0BIODHqtq7Vq/ixWuYxHVJWdNi3lfeEM2rGyw=;
        b=3D8KNMrn2Bm2C12KcQt8/uVuXLfq0SFrrUkYcC5tDv/SpwoZbw54qbP3QojsFI4mS2OmNb
        6e6xEBr6NxchdUG/ik3vZRFa3wS2MiqqFGda0NeKEHbIn/2Tz9MHA+gLxcKXAcMaqDzgV7
        2KK6vy280PHimR66LYGjf0yv+reIoag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628679350;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z78fqU0BIODHqtq7Vq/ixWuYxHVJWdNi3lfeEM2rGyw=;
        b=d5UlX/mxAo70oRVEvZHxIqvxByBuYA87iqsHPY3f9uRnnO72U8JOpnAwGc/zx4OT6PQUvS
        PC3yT1qqys0fgACA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 93E65A3C0F;
        Wed, 11 Aug 2021 10:55:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 25D8DDA733; Wed, 11 Aug 2021 12:52:56 +0200 (CEST)
Date:   Wed, 11 Aug 2021 12:52:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 00/21] btrfs: support idmapped mounts
Message-ID: <20210811105255.GB5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Christian Brauner <christian.brauner@ubuntu.com>,
        David Sterba <dsterba@suse.com>, Christoph Hellwig <hch@lst.de>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
References: <20210727104900.829215-1-brauner@kernel.org>
 <20210802122827.aomsh5i3rljgm2r3@wittgenstein>
 <20210809144439.GP5047@twin.jikos.cz>
 <20210809152012.lnd4aai34kdhuijf@wittgenstein>
 <20210811101214.GA5047@twin.jikos.cz>
 <20210811104339.qfcqx33qokqp7nw4@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811104339.qfcqx33qokqp7nw4@wittgenstein>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 11, 2021 at 12:43:39PM +0200, Christian Brauner wrote:
> On Wed, Aug 11, 2021 at 12:12:15PM +0200, David Sterba wrote:
> > On Mon, Aug 09, 2021 at 05:20:12PM +0200, Christian Brauner wrote:
> > > On Mon, Aug 09, 2021 at 04:44:39PM +0200, David Sterba wrote:
> > > > On Mon, Aug 02, 2021 at 02:28:27PM +0200, Christian Brauner wrote:
> > > > > On Tue, Jul 27, 2021 at 12:48:39PM +0200, Christian Brauner wrote:
> > > > I'll need to do one more pass but I don't remember any big issues or
> > > > anything that couldn't be adjusted later. This is going to be the last
> > > > nontrivial patchset, time is almost up for next merge window code
> > > > freeze.
> > > > 
> > > > Patch 1, the VFS part, does not have acks but for inclusion into
> > > > for-next I don't think it's necessary. I'll let you know once I push the
> > > > idmap branch to for-next so you can drop the patch.
> > > 
> > > Ok, sounds good. I wasn't sure if you wanted to base your branch on the
> > > tag or just carry it yourself. Whatever works best.
> > 
> > The branch is now as topic branch in my for-next and has been pushed, so
> > there could be a minor conflict in the VFS patch in linux-next (I've
> > removed the extern keyword as Christoph pointed out).
> 
> Thank you. I can drop the VFS patch then and let you carry it, right?

Yes, thanks.
