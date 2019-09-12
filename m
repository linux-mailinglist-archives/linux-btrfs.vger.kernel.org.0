Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A17CB0C19
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 11:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbfILJ7S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 05:59:18 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:34589 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730185AbfILJ7S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 05:59:18 -0400
Received: by mail-yb1-f194.google.com with SMTP id u68so8455099ybg.1
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2019 02:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jKOuFDI22DBoQF6Vb7bxMGfg3IrMf7N9WrpqdZkwcGg=;
        b=NqvaDTjo/C9q1yJaKkCAEbRO/XygiSJE6b8QZUBwaiZhy7gN9Xo+ISzP3ZxDA/P32e
         lc0VL8j9sDzRGikC1N+hKgMUwW9f3WbKZI+cAoHMT818qnoN/RmhphvzfRit0IRq/TJn
         sVolQd8ibcnOC16hb8HrPRAsG3UNIeMV5hPWtxwIXemMT0VDFnvLrYTRTLvlCS/cgMLj
         8UIF4mifasshNwECELIr4+5txgXk3gjhoK8Qr4oEUzmqu4WxoO/LBiNpGcGP9l53aRFn
         9zS9eECJzxhrqB7fzIkaBWZFH6LTP6ek5/tnW2ytZLbHxSFYv3shGaO59OL8zCHGCb2r
         I+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jKOuFDI22DBoQF6Vb7bxMGfg3IrMf7N9WrpqdZkwcGg=;
        b=rUZsxK89tZrI2wvVQZzOgsWrQ0g6i/nlrW+j0VCJd9efDHCObfFipqoL/S4sZmPzX/
         YWerEjsCyHLsiiwtdBZq0sZHdWmWSYRYU0bW+TcaAg1WDeLP8CqqLTrgb1mBYsD1wmNR
         3r61EMs9XtEMbldZvRQbBwfesDNNF4d5eRmclz5//+MW83eiP3pwAwB9qhbjJhwlVC0v
         4dvAbU/dTgI5x+tQBq4isrpxo8djFlDkIhhdh7PSjlC0sXtYg5jypAMdY+Vs9EOXCMz8
         z3fxXk5OcRqI7hYode/cmTxoDNDnjI6jIMqJeGKC8PVINY8sD/iVNJJpt2x43ehzdzyo
         2S2g==
X-Gm-Message-State: APjAAAWHOV/uBf7zBXDeH0yMdLzYAeX8zu6cir8hLWnLl7mngA1v901E
        Jp5ckaz2ZdxMkPL4wsBGGU7xC1XHoA8GVFu3
X-Google-Smtp-Source: APXvYqy1XustzP4o+esWh/rYBaFtj0SOoflCDER8ctEeEJntqcB2pQfPkUbu8dgUx+Ab//ORV7IZFQ==
X-Received: by 2002:a25:55d6:: with SMTP id j205mr949510ybb.503.1568282356733;
        Thu, 12 Sep 2019 02:59:16 -0700 (PDT)
Received: from localhost ([2600:380:9c1c:691f:cb4:3daf:a71a:adbc])
        by smtp.gmail.com with ESMTPSA id w188sm4460591ywa.110.2019.09.12.02.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 02:59:15 -0700 (PDT)
Date:   Thu, 12 Sep 2019 05:59:14 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: Introduce btrfs child tree block verification
 system
Message-ID: <20190912095913.gql6vbf4d6jj5p6m@MacBook-Pro-91.local>
References: <20190911074624.27322-1-wqu@suse.com>
 <20190911160202.wtprsigurzfxwtic@MacBook-Pro-91.local>
 <3993aeab-a695-3bd1-88d6-48e9743ab597@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3993aeab-a695-3bd1-88d6-48e9743ab597@gmx.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 12, 2019 at 07:38:14AM +0800, Qu Wenruo wrote:
> 
> 
> On 2019/9/12 上午12:02, Josef Bacik wrote:
> > On Wed, Sep 11, 2019 at 03:46:24PM +0800, Qu Wenruo wrote:
> >> Although we have btrfs_verify_level_key() function to check the first
> >> key and level at tree block read time, it has its limitation due to tree
> >> lock context, it's not reliable handling new tree blocks.
> >>
> > 
> > How is it not reliable with new tree blocks?
> 
> Current btrfs_verify_level_key() skips first_key verification for any
> tree blocks newer than last committed.
> 
> > 
> >> So btrfs_verify_level_key() is good as a pre-check, but it can't ensure
> >> new tree blocks are still sane at runtime.
> >>
> > 
> > I mean I guess this is good, but we have to keep the parent locked when we're
> > adding new blocks anyway, so I'm not entirely sure what this gains us?
> 
> For cases like tree search on current node, where all tree blocks can be
> newly CoWed tree blocks.
> 

But again we have the parent locked in these cases, so we can still do the check
even if the parent has been cow'ed, so I'm not clear what the point is?  Like
for sure add an extra check during search to check the first_key I guess, but
all the extra checks seem superflous.

> If bit flip happens affecting those new tree blocks, we can detect them
> at runtime, and that's the only time we can catch such error.
> 

Sure but we can't really detect bitflips in lots of places.  I'm not sure that
justifies this extra infrastructure.

> Write time tree checker doesn't go beyond single leave/node, thus has no
> way to detect such parent-child mismatch case.
> 

Yeah that I'll give you.  But again as long as we check while we're searching
we'll be fine.  The only case we'll miss is if there's a bitflip in between the
time we modified the thing and we write it out.  Your code doesn't catch this
case either, cause frankly it's kind of impossible without actually walking and
verifying at writeout time.

> >  You are
> > essentially duplicating the checks that we already do on reads, and then adding
> > the first_key check.
> > 
> > I'll go along with the first_key check being relatively useful, but why exactly
> > do we need all this infrastructure when we can just check it as we walk down the
> > tree?
> 
> You can't really do the nritems and first key check at the current
> timing of btrfs_verify_level_key() for new tree blocks due to lock context.
> 
> That's the only reason the new infrastructure is here, to block the only
> hole of btrfs_verify_level_key().
> 
> > 
> > <snip>
> > 
> >> @@ -2887,24 +2982,28 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
> >>  			}
> >>  
> >>  			if (!p->skip_locking) {
> >> -				level = btrfs_header_level(b);
> >> -				if (level <= write_lock_level) {
> >> +				if (level - 1 <= write_lock_level) {
> >>  					err = btrfs_try_tree_write_lock(b);
> >>  					if (!err) {
> >>  						btrfs_set_path_blocking(p);
> >>  						btrfs_tree_lock(b);
> >>  					}
> >> -					p->locks[level] = BTRFS_WRITE_LOCK;
> >> +					p->locks[level - 1] = BTRFS_WRITE_LOCK;
> >>  				} else {
> >>  					err = btrfs_tree_read_lock_atomic(b);
> >>  					if (!err) {
> >>  						btrfs_set_path_blocking(p);
> >>  						btrfs_tree_read_lock(b);
> >>  					}
> >> -					p->locks[level] = BTRFS_READ_LOCK;
> >> +					p->locks[level - 1] = BTRFS_READ_LOCK;
> >>  				}
> >> -				p->nodes[level] = b;
> >> +				p->nodes[level - 1] = b;
> >>  			}
> > 
> > This makes no sense to me.  Why do we need to change how we do level here just
> > for the btrfs_verify_child() check?
> 
> Because we can't trust the level from @b unless we have verified it.
> 
> (Although level is always checked in btrfs_verify_level_key(), but that
> function is not 100% sure to be kept as is).

But we have the level at the time we read the block, which we verify, so it'll
already be correct here right?  So we're just adding the first_key check here.
Thanks,

Josef
