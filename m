Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91AAE3E8E46
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 12:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbhHKKPj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 06:15:39 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49834 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236810AbhHKKPf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 06:15:35 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C1E231FD58;
        Wed, 11 Aug 2021 10:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628676909;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0v9GJdhjdFXIKSxDIRK4HE1AjgEcOwxnyVLHWnACvNs=;
        b=3KRn+fWXG6PrAlit6p93dCWLQ24Mwkkn6i7ZdQaTIs2AIwrv+MaTB/J+Cb6goco6uLAAKE
        4LIfSNnykYvlh/ylXgmx1NWTz2eWozuUJSWLhYMeYcvDIQI0aC1qx7oP8qmNgiLbuqpMne
        k7mDwc0pdUA4c2A7p3+sEChQh9ROoVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628676909;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0v9GJdhjdFXIKSxDIRK4HE1AjgEcOwxnyVLHWnACvNs=;
        b=DavL7cIxb489MlEplwYNPfeCbgzqMzMxYnf/4IXwtouN4K3qmB1gUlVTFNDQpqZq+CM7Bw
        Jr9ICGEKIaE8knDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9B480A3BD8;
        Wed, 11 Aug 2021 10:15:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 46133DA733; Wed, 11 Aug 2021 12:12:15 +0200 (CEST)
Date:   Wed, 11 Aug 2021 12:12:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 00/21] btrfs: support idmapped mounts
Message-ID: <20210811101214.GA5047@twin.jikos.cz>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809152012.lnd4aai34kdhuijf@wittgenstein>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 09, 2021 at 05:20:12PM +0200, Christian Brauner wrote:
> On Mon, Aug 09, 2021 at 04:44:39PM +0200, David Sterba wrote:
> > On Mon, Aug 02, 2021 at 02:28:27PM +0200, Christian Brauner wrote:
> > > On Tue, Jul 27, 2021 at 12:48:39PM +0200, Christian Brauner wrote:
> > I'll need to do one more pass but I don't remember any big issues or
> > anything that couldn't be adjusted later. This is going to be the last
> > nontrivial patchset, time is almost up for next merge window code
> > freeze.
> > 
> > Patch 1, the VFS part, does not have acks but for inclusion into
> > for-next I don't think it's necessary. I'll let you know once I push the
> > idmap branch to for-next so you can drop the patch.
> 
> Ok, sounds good. I wasn't sure if you wanted to base your branch on the
> tag or just carry it yourself. Whatever works best.

The branch is now as topic branch in my for-next and has been pushed, so
there could be a minor conflict in the VFS patch in linux-next (I've
removed the extern keyword as Christoph pointed out).
