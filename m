Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46BC01172F2
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 18:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfLIRjW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Dec 2019 12:39:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:40976 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726509AbfLIRjW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Dec 2019 12:39:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 06DB4B13E;
        Mon,  9 Dec 2019 17:39:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DA431DA783; Mon,  9 Dec 2019 18:39:13 +0100 (CET)
Date:   Mon, 9 Dec 2019 18:39:13 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 1/5] btrfs: drop log root for dropped roots
Message-ID: <20191209173913.GN2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20191206143718.167998-1-josef@toxicpanda.com>
 <20191206143718.167998-2-josef@toxicpanda.com>
 <5e60e26f-8993-ca16-2a93-48d5948ed961@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e60e26f-8993-ca16-2a93-48d5948ed961@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 06, 2019 at 05:03:36PM +0200, Nikolay Borisov wrote:
> On 6.12.19 г. 16:37 ч., Josef Bacik wrote:
> > If we fsync on a subvolume and create a log root for that volume, and
> > then later delete that subvolume we'll never clean up its log root.  Fix
> > this by making switch_commit_roots free the log for any dropped roots we
> > encounter.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/btrfs/transaction.c | 22 ++++++++++++----------
> >  1 file changed, 12 insertions(+), 10 deletions(-)
> > 
> > diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> > index cfc08ef9b876..55d8fd68775a 100644
> > --- a/fs/btrfs/transaction.c
> > +++ b/fs/btrfs/transaction.c
> > @@ -147,13 +147,14 @@ void btrfs_put_transaction(struct btrfs_transaction *transaction)
> >  	}
> >  }
> >  
> > -static noinline void switch_commit_roots(struct btrfs_transaction *trans)
> > +static noinline void switch_commit_roots(struct btrfs_trans_handle *trans)
> >  {
> > +	struct btrfs_transaction *cur_trans = trans->transaction;
> >  	struct btrfs_fs_info *fs_info = trans->fs_info;
> >  	struct btrfs_root *root, *tmp;
> >  
> >  	down_write(&fs_info->commit_root_sem);
> > -	list_for_each_entry_safe(root, tmp, &trans->switch_commits,
> > +	list_for_each_entry_safe(root, tmp, &cur_trans->switch_commits,
> >  				 dirty_list) {
> >  		list_del_init(&root->dirty_list);
> >  		free_extent_buffer(root->commit_root);
> > @@ -165,16 +166,17 @@ static noinline void switch_commit_roots(struct btrfs_transaction *trans)
> >  	}
> >  
> >  	/* We can free old roots now. */
> > -	spin_lock(&trans->dropped_roots_lock);
> > -	while (!list_empty(&trans->dropped_roots)) {
> > -		root = list_first_entry(&trans->dropped_roots,
> > +	spin_lock(&cur_trans->dropped_roots_lock);
> > +	while (!list_empty(&cur_trans->dropped_roots)) {
> > +		root = list_first_entry(&cur_trans->dropped_roots,
> >  					struct btrfs_root, root_list);
> >  		list_del_init(&root->root_list);
> > -		spin_unlock(&trans->dropped_roots_lock);
> > +		spin_unlock(&cur_trans->dropped_roots_lock);
> > +		btrfs_free_log(trans, root);
> 
> THis patch should really have been this line and converting
> switch_commit_roots to taking a trans handle another patch. Otherwise
> this is lost in the mechanical refactoring.

Agreed, as this is a bugfix, we want it backported to older threes so
minimizing the potential conflicts is desired. For that the order 1)
fix 2) cleanup, seems appropriate.
