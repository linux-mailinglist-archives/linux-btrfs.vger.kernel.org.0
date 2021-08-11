Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B303E92AA
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 15:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbhHKNa3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 09:30:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231575AbhHKNa1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 09:30:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E0C260724;
        Wed, 11 Aug 2021 13:30:01 +0000 (UTC)
Date:   Wed, 11 Aug 2021 15:29:58 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 00/21] btrfs: support idmapped mounts
Message-ID: <20210811132958.7sldsgm37cfvijox@wittgenstein>
References: <20210727104900.829215-1-brauner@kernel.org>
 <20210802122827.aomsh5i3rljgm2r3@wittgenstein>
 <20210809144439.GP5047@twin.jikos.cz>
 <20210809152012.lnd4aai34kdhuijf@wittgenstein>
 <20210811101214.GA5047@twin.jikos.cz>
 <20210811104339.qfcqx33qokqp7nw4@wittgenstein>
 <20210811105255.GB5047@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210811105255.GB5047@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 11, 2021 at 12:52:55PM +0200, David Sterba wrote:
> On Wed, Aug 11, 2021 at 12:43:39PM +0200, Christian Brauner wrote:
> > On Wed, Aug 11, 2021 at 12:12:15PM +0200, David Sterba wrote:
> > > On Mon, Aug 09, 2021 at 05:20:12PM +0200, Christian Brauner wrote:
> > > > On Mon, Aug 09, 2021 at 04:44:39PM +0200, David Sterba wrote:
> > > > > On Mon, Aug 02, 2021 at 02:28:27PM +0200, Christian Brauner wrote:
> > > > > > On Tue, Jul 27, 2021 at 12:48:39PM +0200, Christian Brauner wrote:
> > > > > I'll need to do one more pass but I don't remember any big issues or
> > > > > anything that couldn't be adjusted later. This is going to be the last
> > > > > nontrivial patchset, time is almost up for next merge window code
> > > > > freeze.
> > > > > 
> > > > > Patch 1, the VFS part, does not have acks but for inclusion into
> > > > > for-next I don't think it's necessary. I'll let you know once I push the
> > > > > idmap branch to for-next so you can drop the patch.
> > > > 
> > > > Ok, sounds good. I wasn't sure if you wanted to base your branch on the
> > > > tag or just carry it yourself. Whatever works best.
> > > 
> > > The branch is now as topic branch in my for-next and has been pushed, so
> > > there could be a minor conflict in the VFS patch in linux-next (I've
> > > removed the extern keyword as Christoph pointed out).
> > 
> > Thank you. I can drop the VFS patch then and let you carry it, right?
> 
> Yes, thanks.

Dropped, thanks!
