Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B13BA50469
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2019 10:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfFXIVc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jun 2019 04:21:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:40296 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727028AbfFXIVc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jun 2019 04:21:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BDEFEAF06;
        Mon, 24 Jun 2019 08:21:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 057AE1E434F; Mon, 24 Jun 2019 10:21:30 +0200 (CEST)
Date:   Mon, 24 Jun 2019 10:21:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tejun Heo <tj@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, dsterba@suse.com, clm@fb.com,
        josef@toxicpanda.com, axboe@kernel.dk, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 2/9] blkcg, writeback: Add wbc->no_wbc_acct
Message-ID: <20190624082129.GA32376@quack2.suse.cz>
References: <20190615182453.843275-1-tj@kernel.org>
 <20190615182453.843275-3-tj@kernel.org>
 <20190620152145.GL30243@quack2.suse.cz>
 <20190620170250.GL657710@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620170250.GL657710@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Tejun!

On Thu 20-06-19 10:02:50, Tejun Heo wrote:
> On Thu, Jun 20, 2019 at 05:21:45PM +0200, Jan Kara wrote:
> > I'm completely ignorant of how btrfs compressed writeback works so don't
> > quite understand implications of this. So does this mean that writeback to
> > btrfs compressed files won't be able to transition inodes from one memcg to
> > another? Or are you trying to say the 'wbc' used from async worker thread
> > is actually a dummy one and we would double-account the writeback?
> 
> So, before, only the async compression workers would run through the
> wbc accounting code regardless of who originated the dirty pages,
> which is obviously wrong.  After the patch, the code accounts when the
> dirty pages are being handed off to the compression workers and
> no_wbc_acct is used to suppress spurious accounting from the workers.

OK, now I understand. Just one more question: So effectively, you are using
wbc->no_wbc_acct to pass information from btrfs code to btrfs code telling
it whether IO should or should not be accounted with wbc_account_io().
Wouldn't it make more sense to just pass this information internally
within btrfs? Granted, if this mechanism gets more widespread use by other
filesystems, then probably using wbc flag makes more sense. But I'm not
sure if this isn't a premature generalization...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
