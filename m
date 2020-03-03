Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96202177A4B
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 16:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbgCCPVl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 10:21:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:54560 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729858AbgCCPVl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Mar 2020 10:21:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4C853B089;
        Tue,  3 Mar 2020 15:21:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 465B3DA7AE; Tue,  3 Mar 2020 16:21:17 +0100 (CET)
Date:   Tue, 3 Mar 2020 16:21:17 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/7] btrfs: unset reloc control if we fail to recover
Message-ID: <20200303152116.GD2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <20200302184757.44176-1-josef@toxicpanda.com>
 <20200302184757.44176-3-josef@toxicpanda.com>
 <27afa0d3-e030-b53a-0033-674f13199c68@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27afa0d3-e030-b53a-0033-674f13199c68@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 03, 2020 at 08:58:22AM +0800, Qu Wenruo wrote:
> On 2020/3/3 上午2:47, Josef Bacik wrote:
> > If we fail to load an fs root, or fail to start a transaction we can
> > bail without unsetting the reloc control, which leads to problems later
> > when we free the reloc control but still have it attached to the file
> > system.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/btrfs/relocation.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> > index 507361e99316..173fc7628235 100644
> > --- a/fs/btrfs/relocation.c
> > +++ b/fs/btrfs/relocation.c
> > @@ -4678,6 +4678,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
> >  		fs_root = read_fs_root(fs_info, reloc_root->root_key.offset);
> >  		if (IS_ERR(fs_root)) {
> >  			err = PTR_ERR(fs_root);
> > +			unset_reloc_control(rc);
> >  			list_add_tail(&reloc_root->root_list, &reloc_roots);
> >  			goto out_free;
> >  		}
> 
> 
> Shouldn't the unset_reloc_control() also get called for all related
> errors after set_reloc_control()?

It should and the patch does that but I think it could be merged into
one label so it follows the nesting. The only problem is that the reloc
control is unset between 2 calls of transaction join/commit, so the
unset would have to be called twice:

	set_reloc_control()
	...
	join_transaction()
	if (error)
		goto out_unset;
	...
		read_fs_root()
		if (error)
			goto out_unset;		// added by patch
	...
	commit_transaction()
	if (error)
		goto out_unset;			// added by patch
	...
	merge_reloc_roots();
	unset_reloc_control();			// unconditional
	join_transaction();
	if (error)
		goto out_free;
	commit_transaction();
	clean_dirty_subvols()
out_free_unset:
	unset_reloc_control();			// would be new, duplicated
out_free:
	kfree(rc);


It's fine to call the function twice as it only resets the reloc_ctl
pointer, no other relocation can run at this point, but it does not look
all great. I still think that having the label-based cleanup is better
than to add the cleanup before each goto.
