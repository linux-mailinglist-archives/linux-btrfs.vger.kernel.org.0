Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F863897B7
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 May 2021 22:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbhESUTr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 May 2021 16:19:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:43350 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231124AbhESUTq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 May 2021 16:19:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E953CAF35;
        Wed, 19 May 2021 20:18:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9EE9BDB228; Wed, 19 May 2021 22:15:51 +0200 (CEST)
Date:   Wed, 19 May 2021 22:15:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH] btrfs: abort the transaction if we fail to replay log
 trees
Message-ID: <20210519201551.GX7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
References: <9513d31a4d2559253088756f99d162abaf090ebd.1621438132.git.josef@toxicpanda.com>
 <PH0PR04MB7416EC2004FF7AB6B2F4D5339B2B9@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB7416EC2004FF7AB6B2F4D5339B2B9@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 19, 2021 at 04:22:20PM +0000, Johannes Thumshirn wrote:
> On 19/05/2021 17:29, Josef Bacik wrote:
> > During inspection of the return path for replay I noticed that we don't
> > actually abort the transaction if we get a failure during replay.  This
> > isn't a problem necessarily, as we properly return the error and will
> > fail to mount.  However we still leave this dangling transaction that
> > could conceivably be committed without thinking there was an error.
> > Handle this by making sure we abort the transaction on error to
> > safeguard us from any problems in the future.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/btrfs/tree-log.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> > index 4dc74949040d..18009095908b 100644
> > --- a/fs/btrfs/tree-log.c
> > +++ b/fs/btrfs/tree-log.c
> > @@ -6352,8 +6352,10 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
> >  
> >  	return 0;
> >  error:
> > -	if (wc.trans)
> > +	if (wc.trans) {
> > +		btrfs_abort_transaction(wc.trans, ret);
> >  		btrfs_end_transaction(wc.trans);
> > +	}
> >  	btrfs_free_path(path);
> >  	return ret;
> >  }
> > 
> 
> Hmm our Wiki's Development notes page says:
> 
> Please keep all transaction abort exactly at the place where they happen and do not
> merge them to one. This pattern should be used everwhere and is important when 
> debugging because we can pinpoint the line in the code from the syslog message and do
> not have to guess which way it got to the merged call.
> 
> But there are 6 'goto error;' lines in btrfs_recover_log_trees() and changing all of 
> them might be a bit too much.

Good point and I want to keep the abort pattern consistent so it should
be called before the goto error's. Note that this function still uses
btrfs_handle_fs_error which predates the transaction abort framework and
should be replaced as needed.
