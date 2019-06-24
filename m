Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36620518D2
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2019 18:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbfFXQjV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jun 2019 12:39:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:56348 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727182AbfFXQjU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jun 2019 12:39:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7134EAE74;
        Mon, 24 Jun 2019 16:39:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C9BA31E2F23; Mon, 24 Jun 2019 18:39:18 +0200 (CEST)
Date:   Mon, 24 Jun 2019 18:39:18 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tejun Heo <tj@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, dsterba@suse.com, clm@fb.com,
        josef@toxicpanda.com, axboe@kernel.dk, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 2/9] blkcg, writeback: Add wbc->no_wbc_acct
Message-ID: <20190624163918.GL32376@quack2.suse.cz>
References: <20190615182453.843275-1-tj@kernel.org>
 <20190615182453.843275-3-tj@kernel.org>
 <20190620152145.GL30243@quack2.suse.cz>
 <20190620170250.GL657710@devbig004.ftw2.facebook.com>
 <20190624082129.GA32376@quack2.suse.cz>
 <20190624125856.GO657710@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624125856.GO657710@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon 24-06-19 05:58:56, Tejun Heo wrote:
> Hello, Jan.
> 
> On Mon, Jun 24, 2019 at 10:21:30AM +0200, Jan Kara wrote:
> > OK, now I understand. Just one more question: So effectively, you are using
> > wbc->no_wbc_acct to pass information from btrfs code to btrfs code telling
> > it whether IO should or should not be accounted with wbc_account_io().
> 
> Yes.
> 
> > Wouldn't it make more sense to just pass this information internally
> > within btrfs? Granted, if this mechanism gets more widespread use by other
> > filesystems, then probably using wbc flag makes more sense. But I'm not
> > sure if this isn't a premature generalization...
> 
> The btrfs async issuers end up using generic writeback path and uses
> the generic wbc owner mechanisms so that ios are attached to the right
> cgroup too.  So, I kinda prefer to provide a generic mechanism from
> wbc side.

OK, I can live with that. We just have to be kind of careful so that people
just don't sprinkle no_wbc_acct writeback around because they don't know
better. Maybe you could at least add comment to no_wbc_acct mentioning that
this is for the cases where writeback has already been accounted for?

> That said, the names are a bit misleading and I think it'd
> be better to rename them to something more explicit, e.g. sth along
> the line of wbc_update_cgroup_owner() and wbc->no_cgroup_owner.  What
> do you think?

Yeah, renaming would probably make things clearer as well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
