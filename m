Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AACFE184DC5
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 18:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgCMRif (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 13:38:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:52536 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbgCMRif (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 13:38:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 443D8AB8F;
        Fri, 13 Mar 2020 17:38:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2C4AADA7A7; Fri, 13 Mar 2020 18:38:08 +0100 (CET)
Date:   Fri, 13 Mar 2020 18:38:08 +0100
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 4/8] btrfs: free the reloc_control in a consistent way
Message-ID: <20200313173808.GP12659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200313154448.53461-1-josef@toxicpanda.com>
 <20200313154448.53461-5-josef@toxicpanda.com>
 <20200313171851.GO12659@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313171851.GO12659@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 13, 2020 at 06:18:51PM +0100, David Sterba wrote:
> On Fri, Mar 13, 2020 at 11:44:44AM -0400, Josef Bacik wrote:
> > If we have an error while processing the reloc roots we could leak roots
> > that were added to rc->reloc_roots before we hit the error.  We could
> > have also not removed the reloct tree mapping from our rb_tree, so clean
> > up any remaining nodes in the reloc root rb_tree.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/btrfs/relocation.c | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> > index c496f8ed8c7e..721d049ff2b5 100644
> > --- a/fs/btrfs/relocation.c
> > +++ b/fs/btrfs/relocation.c
> > @@ -4387,6 +4387,20 @@ static struct reloc_control *alloc_reloc_control(struct btrfs_fs_info *fs_info)
> >  	return rc;
> >  }
> >  
> > +static void free_reloc_control(struct reloc_control *rc)
> > +{
> > +	struct mapping_node *node, *tmp;
> > +
> > +	free_reloc_roots(&rc->reloc_roots);
> > +	rbtree_postorder_for_each_entry_safe(node, tmp,
> > +					     &rc->reloc_root_tree.rb_root,
> > +					     rb_node) {
> > +		rb_erase(&node->rb_node, &rc->reloc_root_tree.rb_root);
> 
> The rb_erase is not needed here, the postorder traversal just goes over
> all nodes and allows to free the containing structures together with the
> rb_node. Dangling pointers are not an issue.

I had not seen your reply when I replied to the v2 patch but if you
think the rb_erase is needed, I don't see why.
